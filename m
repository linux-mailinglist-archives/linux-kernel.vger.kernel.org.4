Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C816CF704
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjC2XZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjC2XZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:25:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9D1FFF;
        Wed, 29 Mar 2023 16:25:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k15so10283266pgt.10;
        Wed, 29 Mar 2023 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680132336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK1gMxVBx5URWr0R/hSicMEBUWBlQ/5D6tw4DTkFIrM=;
        b=X90H/nlN6lbaQSZZqPd3D7vr7hn2hfhdfaa3Ol+II9lB7idhD3brdKKOlgRAy+82NF
         SFS3YBcC+oZB94X+BVj72wObVHoLIqR1uuVceqc+lKBUHo/eY0SAl27yupki21ub5wSa
         mwba2ifv0Y35ArZpwzzVSlbvEuUo+ddOrnTZx3+4xH+tXHAFa6F4ZEEjQfA48+44M0K5
         K+Vg5w/j9eCEkYwqAFwe9vv/wdoHC9Gd2tFiDL4cU2Q35XhFq/nv9M5BPfs+OYaxsP5B
         XuS+R3dLsAhemT89bSXcehE8aCFFlIYA8I3B4wqK0vAEuvBcJG878fk1lIXusW1a9E3K
         boxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK1gMxVBx5URWr0R/hSicMEBUWBlQ/5D6tw4DTkFIrM=;
        b=RD/dx8d7IzsUf3JM/wITWw7aDoi1qFjrE2J4i5g66aECglDDjd0ZQjrsp/R9ZtJcAr
         VP9ir2DotI+BzZgAMt7OB5ZZkLpnMmxScH0Hj3gvCd3MUS8/8SJ9x/fJKFEOf5y0aBsJ
         mCgaaoFjnDwL6oHNnmbjlYuZLTlkUj6W4EVlLPWt3CTGO1AEg7m2jQDThB/t03xbMlpC
         sH7fx04ZKAfrTQST9jMK+Wy2vfvefkjNHkJ+QkalvWotZtCj73h9pIh3lo2HwOFNincO
         Ef3zYqNmoQEOZxfg5qUUe5W1lZ/MqiKU6Sxqw5N8BC1sfQQfN3yBs27FxTIpoQ5GlABO
         wFOA==
X-Gm-Message-State: AAQBX9eOREqs/R1qbNySXwQulf1rxPnGSo/REqRIxaRRfuynCoRFJyrq
        iKXR2KNjrtn5T8z6GvjVGJc3WARm6eeb5/6uvYE=
X-Google-Smtp-Source: AKy350aCmP8NknsbQwxR+TYbr9LXnYcWFTKr/g7+N8z+9ir6hvEhnEU5Pc7Xtv49cAnW8W+g4CBBJ7O006VZbPM6u/E=
X-Received: by 2002:a05:6a00:a14:b0:625:66a9:c393 with SMTP id
 p20-20020a056a000a1400b0062566a9c393mr11221253pfh.0.1680132335805; Wed, 29
 Mar 2023 16:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com> <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan> <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan> <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan> <64db6d95-8aca-48cc-80e1-e68211922071@arm.com>
In-Reply-To: <64db6d95-8aca-48cc-80e1-e68211922071@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 29 Mar 2023 16:25:24 -0700
Message-ID: <CAHbLzkoFkxpLuaW93nPrxxvtuHiRmObOnZfRY9YPXcGumzv33A@mail.gmail.com>
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com, yang@os.amperecomputing.com
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

On Wed, Mar 29, 2023 at 9:08=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 14/03/2023 00:36, Leo Yan wrote:
> > On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
> >
> > [...]
> >
> >>> Just a quick summary, here we have two issues:
> >>>
> >>> - With command:
> >>>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
> >>>   -- taskset --cpu-list 1 uname",
> >>>
> >>>   perf doesn't enable "text poke" attribution.
> >>
> >> No, it enables "text poke" and perf fails to decode coresight trace
> >> data too. It doesn't matter whether "--kcore" is after or before "-e
> >> cs/etm/@tmc_etf63/k".
> >
> > Understand now.  Thanks for correction, if so we can ignore this one.
> >
> > Leo
>
> To me it looks like it's only --per-thread and --kcore together that
> cause the issue. I can't see if that was mentioned previously in this
> thread.

If "--pre-thread" is not passed in, perf record failed with "failed to
mmap with 12 (Cannot allocate memory)". Sorry for not mentioning this
in the first place. I was quite focused on --kcore and didn't realize
they may be related.

>
> If it is --per-thread that's causing the issue then I think I have an
> idea why it might be. There are some assumptions and different paths
> taken in decoding in that mode that aren't correct. It causes some other
> issues to do with ordering and timestamps as well and I wanted to fix it
> previously. I wouldn't say that the text-poke change has caused a
> regression, as decoding in this mode was always a bit buggy.
>
> Maybe this is another reason to fix it properly.
