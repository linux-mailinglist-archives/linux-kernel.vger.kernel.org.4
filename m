Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFC6CB2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1AxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1AxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:53:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE411A5;
        Mon, 27 Mar 2023 17:53:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so10128256plb.5;
        Mon, 27 Mar 2023 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679964795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sV7N8LUyHkNioiD8M1h9rvVPbKL2byNtWw5W5Xmfpk=;
        b=jV6hxQM96H8vWkkWVymtC8KSBBy09/mGteJIBvrTBHLyNct6Pqy/84aEqfEF9csOP9
         fdCis1snMKiq1DbgEPWe1UqqW9O8WscgVJ4W+g7rzDm/GuGxigR8uaBP12mniaM8fz+a
         TugBcB0qwGPJHjc9EmCdSx+dBft3Jc0V3H5JiPRRDJg7NKRAWea3dxjUmo3i11Dgk4uB
         fAY8wq7C1hDU29dgquOzL5DJA96PC5W0qrWukEsM2Gr62ayfLPLtd63Arw7VDpNS1OpI
         EL6fypWFJScOl+rEPMDLxI6BHhRuogGgYq15pJ5X9n6F+rnjbJ+521AoC+oMGg94WonL
         96xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679964795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sV7N8LUyHkNioiD8M1h9rvVPbKL2byNtWw5W5Xmfpk=;
        b=BIXlJSZK3VCzqnLkbSnlcA3wONZ4vQTWtpQz0VVNVQvn8OEDSVpmm9JM2AMjdi2AMT
         bmCxy0JjXHspUKWMlf5NC5V36r2ugkI2GSzYGMLzX4ddXQEpOBddgd8LL7r9XpTgvXad
         Tn5/3abxxfeEL9asUP+2K3L7pgsWY13+QyTLc8XJ5EJddufoU/WzRkbOsGJJjlOxySfI
         Kbt5G7JoZ1XeFrhDvQ5xfwSbvbKXly26fv+mAosMORAPTp0spRVM1o8iI1gWrptgNlyr
         rhwY8JQXWahK6gOXMG0rK+T0BJ6BvpOO0j0QSZRZwe/B8ojo5gx8P0xTCxvqvyOzG8Gv
         pcOw==
X-Gm-Message-State: AAQBX9cIQhk3vDvSSF6Ej/ZNj7wwlG/DihR/ngP8Rgw7IwdC5nJXXI/S
        XZZPyHUAmTME3poBM39t7GuhoF9j3z+FUvhjLwQ=
X-Google-Smtp-Source: AKy350ZJVxAp3LNlRvxe5HntaBey69rZkupnsKcLPKAHqIzvAZ+BHMKHluvzaT3MoyNkj3xjRgMjIg5sjkLTPY1YRvg=
X-Received: by 2002:a17:90a:5141:b0:23d:50d0:4ba4 with SMTP id
 k1-20020a17090a514100b0023d50d04ba4mr4175358pjm.3.1679964795626; Mon, 27 Mar
 2023 17:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com> <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan> <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan> <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan>
In-Reply-To: <20230314003610.GD2426758@leoy-yangtze.lan>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 27 Mar 2023 17:53:04 -0700
Message-ID: <CAHbLzkqMZMB7sGLbJk82CpE9cssEU+WZYaXhVTVC-B40bY52jw@mail.gmail.com>
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
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

Hi Leo,

Just follow up on this one. Any update?

Thanks,
Yang

On Mon, Mar 13, 2023 at 5:36=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
>
> [...]
>
> > > Just a quick summary, here we have two issues:
> > >
> > > - With command:
> > >   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
> > >   -- taskset --cpu-list 1 uname",
> > >
> > >   perf doesn't enable "text poke" attribution.
> >
> > No, it enables "text poke" and perf fails to decode coresight trace
> > data too. It doesn't matter whether "--kcore" is after or before "-e
> > cs/etm/@tmc_etf63/k".
>
> Understand now.  Thanks for correction, if so we can ignore this one.
>
> Leo
