Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E76D0F69
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjC3Tyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjC3Tyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:54:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150B49E3;
        Thu, 30 Mar 2023 12:54:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x15so18325008pjk.2;
        Thu, 30 Mar 2023 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680206077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzYl34qHqlnYZZkPFK+yoEyv37qx/dlfpjxFYKlTm4s=;
        b=mq2rnwbci+RMgKDXaruFkc1XWydlzWeaZrArIDHiTdsDMtz7bv5e8qx9R9c23p8EL9
         j74PfI7MfW0o4RfbePiuH53k+4iu3YyZQgUnhZAG9DncY9dkcWMLVC4XpDci7HOJ50Ds
         hxlH4mW72qYfOgHq66jZWGkG3foK4PBNKccmsWNVkYTbLOcs5COijXeRcBRvp3L9/na/
         A10gv0aZFVz63PoE2AFhoPIvQqYfwjHSv1XPdahkTNqO+DdN1oA0NTth0DKzTSwxxxPf
         aqrU1zxYG8DO1960GuDUxfSUk875+12vTMipWq5SwhnM8AKdKU75yarkfM9Zbqtyclqv
         Dn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzYl34qHqlnYZZkPFK+yoEyv37qx/dlfpjxFYKlTm4s=;
        b=73Mhj/EUs9+cKo14eobaqtVqH11vJ1A5q6bWb2fWX93jaLTNv6t5Sa+aWsaAaPG6UV
         UH6L/O+R/bO2F+D1TvHstIvTBFvRJh/LQSZucsvGFct3GKhHF9kvQiX7bSbGEk7CHH76
         pEJYpS95iEPL7X0KgIoI6fa3mKk64Kahg+y4x2dRj7n5r4OO7Mkp9IZ3BwxJ5cz0hkQX
         fVykHWgdRwC4MQT4aknSEdGGysVeK+JaSKbhfjiQCm620npHGThlACymTcVxK67gMJJR
         TVC1B5lzHun0bJh4jSxtYdFeyN5XBkE85y2RaALWSsCHw22HhzhlI5HetcHnlUrDNyw3
         +WQg==
X-Gm-Message-State: AAQBX9clU6HRpNCgso3a9j8ICkWBuaYTiUcqMikO3zQR2cGvlWHxHaXA
        UXVFyE4KSiGiaGnEjOCRsHAK3KrceHH6H/LZpbCX6/RzokA=
X-Google-Smtp-Source: AKy350YzaTd8+e6WYf59Mb6Fe994sEGAJxtHMrPxE167lASMPrx+SMG6JBujSvRBxAgTI3CzFSoZbWFksrs4YRewKc8=
X-Received: by 2002:a17:903:2615:b0:1a0:561c:7276 with SMTP id
 jd21-20020a170903261500b001a0561c7276mr8652529plb.1.1680206077050; Thu, 30
 Mar 2023 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com> <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan> <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan> <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan> <6dcf83ad-bfbc-7e59-7c86-bed334bd09e8@arm.com>
 <5dc10954-d1ad-e8f8-deff-fd237df48ecb@arm.com>
In-Reply-To: <5dc10954-d1ad-e8f8-deff-fd237df48ecb@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 30 Mar 2023 12:54:25 -0700
Message-ID: <CAHbLzkqrEQoK_NDfHVO8tdBT1Lycpia5dcAVuiJBeDdx+jtzaQ@mail.gmail.com>
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:36=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/03/2023 17:11, James Clark wrote:
> >
> >
> > On 14/03/2023 00:36, Leo Yan wrote:
> >> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
> >>
> >> [...]
> >>
> >>>> Just a quick summary, here we have two issues:
> >>>>
> >>>> - With command:
> >>>>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
> >>>>   -- taskset --cpu-list 1 uname",
> >>>>
> >>>>   perf doesn't enable "text poke" attribution.
> >>>
> >>> No, it enables "text poke" and perf fails to decode coresight trace
> >>> data too. It doesn't matter whether "--kcore" is after or before "-e
> >>> cs/etm/@tmc_etf63/k".
> >>
> >> Understand now.  Thanks for correction, if so we can ignore this one.
> >>
> >> Leo
> >
> > To me it looks like it's only --per-thread and --kcore together that
> > cause the issue. I can't see if that was mentioned previously in this
> > thread.
> >
> > If it is --per-thread that's causing the issue then I think I have an
> > idea why it might be. There are some assumptions and different paths
> > taken in decoding in that mode that aren't correct. It causes some othe=
r
> > issues to do with ordering and timestamps as well and I wanted to fix i=
t
> > previously. I wouldn't say that the text-poke change has caused a
> > regression, as decoding in this mode was always a bit buggy.
> >
> > Maybe this is another reason to fix it properly.
>
> Hi Yang,
>
> I found a temporary workaround to the issue. Whenever you use
> --per-thread mode, force timeless mode when decoding with --itrace=3DZ an=
d
> it works the same as it did before. For example:
>
>   perf report --itrace=3DZi1000i
>
> The reason is that the new text poke event was added with timestamps
> enabled. The Coresight decoder slightly incorrectly assumed that no
> timestamps =3D=3D per-thread mode so when it sees the new event it goes i=
nto
> the wrong decode mode.
>
> The assumption was never really correct so I will make a proper fix. But
> in the mean time the workaround should be fine.

Hi James,

Thanks for figuring out the workaround. I tested both (using "-C"
instead of "--per-thread" for record or using "--itrace=3DZ" for report)
works. I think the workaround is fine before we have a proper fix.

>
