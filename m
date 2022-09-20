Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9583D5BEE09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiITTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiITTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:51:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994E7173A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:51:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v4so3718401pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=eGGyCLmqX21PYqdoRyWCXIZnky3GHSCL5lT2ITrEJ5o=;
        b=fGRN7oMYqwM1PFpJFhEf2J3FdHGmcF/3mhPXv22I6/QlpXysWafsy236UMit6vwapB
         P4SzvDHIuRjpXCI1MJasoXhu0BlO+i4zbTc4RMZK5DAwnuwgNGWSuYPv4xshyEQT4Uun
         VgmNn51mvUosSmQl8WyG9oduYzoGa1qaFLG3zLbqhZiBuNQvHPvZ1yX3TlYe6hyQsUl3
         5hQyZ6ZCcP40OPqEIs76tPrTKJ3ymYw5HQBth0sunYxWb05aw1oolFxct8qtKQrTrbaH
         rVjLur/lvegcsxthuC1xxoW/1qG4/rbI54a4zCuqwnUA6/zFrwm9TtSmvIm+ZMovbClT
         bhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eGGyCLmqX21PYqdoRyWCXIZnky3GHSCL5lT2ITrEJ5o=;
        b=K1McgIimV7sxpB8iToL31SMMkGiYd6ZAKz4dq6VFUhxx63vXIL06nrE6QZYrHVzuAU
         c0ByMehaxaSaqXWounBE/op/YMnIJHwOo8SncgC0PFyrh1izESixV3lER6fGQkqAWncZ
         /e4T1MOmgWtrMKvXMgwGyqcgQoz8VpPFaXW1M+0I5Au2f08qRansTkCRwILrJp18vtwE
         xRqPoror2XEjDHthuLlykbRt8QlhZmEMPu+DamZA+kC24m/iop/OPSA5LrfJerTc5IdV
         skTEMw8uxLA6i4U3f/Q+R9DC85AY97XKcHXT7asC0R7jHGgx2QSnSPEQLDyNUd81w631
         DX0g==
X-Gm-Message-State: ACrzQf0tmDxsv7/+788EP+TgPIIFu/wmVZNbB/86uf6Pqf+wezSaUZql
        YmA0UA4+WsHZq91+zIztE56Y1Q==
X-Google-Smtp-Source: AMsMyM5ljjWdLmiYY62ZaRyb/GnDmm7DWKg3HqBQSS9R7a6ES2Jo9jz0PTUiApZPurfllmut6lNqzw==
X-Received: by 2002:a63:784f:0:b0:42b:4c9d:79ee with SMTP id t76-20020a63784f000000b0042b4c9d79eemr21185648pgc.65.1663703492032;
        Tue, 20 Sep 2022 12:51:32 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0016ee3d7220esm323798pln.24.2022.09.20.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:51:30 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:51:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "andersson@kernel.org" <andersson@kernel.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 0/2] remoteproc: support self recovery
Message-ID: <20220920195128.GA1042164@p14s>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177A3658A8B5E57D0C5DAC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB94171E5A5D7EFD79E3C2D950884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94171E5A5D7EFD79E3C2D950884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:34:18AM +0000, Peng Fan wrote:
> Correct Bjorn's mail address.
> 
> > Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
> > 
> > Hi Bjorn, Mathieu
> > 
> > It almost two and a half month until now, I not got any response.
> > You accept or not accept or suggestion?
> > 
> > In V6, I got a typo  comment from Arnaud, then Mathieu replied dropped.
> > 
> > In V7, I add A-b from Arnaud and no more response.
> > 
> > I not understand why ignoring me.

If you were subscribed to the remoteproc mailing list you would see that every
two weeks I send an email that lists the patchsets in my queue and the order in
which I intend to review them.

That helps people know what kind of traffic maintainers currently deal with. If
a patchset is not listed on that email it is likely because it slipped through
the cracks, as it is the case with this set.  You did not notify me and as such
it was impossible for me to know about it.

Last but not least I do not recall you reviewing a single patchset on this list
since the beginning of the year, which automatically negate your right to
complain about how long it takes for patches to be reviewed.

> > 
> 
> Regards,
> Peng.
> > Regards,
> > Peng.
> > 
> > > Subject: [PATCH V7 0/2] remoteproc: support self recovery
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V7:
> > >  Per comments from Arnaud Pouliquen:
> > >    Typo fixes
> > >    Added A-b tag
> > >
> > > V6:
> > >  Rename rproc_firmware_recovery to rproc_boot_recovery  Drop the
> > > unlock/lock when do reproc_attach_recovery
> > >
> > > V5:
> > >  Rename RPROC_FEAT_ATTACH_RECOVERY to
> > > RPROC_FEAT_ATTACH_ON_RECOVERY  Add kerneldoc for rproc features
> > Change
> > > rproc_set_feature to return int type and add a max feature check Use
> > > __rproc_detach and __rproc_attach when do attach recovery
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0 remoteproc/cover/20220615032048.465486-1-
> > peng.fan@oss.nxp.com/
> > >
> > > V4:
> > >   Based on Bjorn's comments on V2-2
> > >   Move the rproc_has_feature/rproc_set_feature to
> > > remoteproc_internal.h and  Keep rproc_features still in remoteproc.h,
> > > because we use RPROC_MAX_FEATURES to declare bitmap.
> > >   Update commit log for patch 2/2, and add comments
> > >
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0 remoteproc/cover/20220323034405.976643-1-
> > peng.fan@oss.nxp.com/
> > >
> > > V3:
> > >  Resend the wrong labeled patchset
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0
> > > remoteproc/list/?series=621311
> > >
> > >  Write a cover-letter
> > >  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> > > Linux loading firmware. The self recovery is done by  SCU(System
> > > Control Unit). Current remoteproc framework only support Linux  help
> > > recovery remote processor(stop, loading firmware, start). This
> > > patchset is support remote processor self recovery(attach recovery).
> > >
> > >  In order to avoid introducing a new variable(bool
> > > support_self_recovery), patch 1 introduce a new function,
> > > rproc_has_feature to make code easy to extend, cleaner, such as we
> > > could move "bool has_iommu" to rproc_has_feature(rproc,
> > RPROC_FEAT_IOMMU).
> > >
> > >  Patch 2 is introduce a new function rproc_attach_recovery for  self
> > > recovery, the original logic move to rproc_firmware_recovery meaning
> > > needs linux to help recovery.
> > >
> > >  V2-version 2:
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0
> > > remoteproc/list/?series=621311
> > >  Introduce rproc_has_feature
> > >
> > >  V2-version 1:
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0 remoteproc/patch/20220126085120.3397450-1-
> > peng.fan@oss.nxp.com/
> > >  Nothing change in V2.
> > >  Only move this patch out from
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > &amp;data=05%7C01%7Cpeng.fan%40nxp.
> > >
> > com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > d99c5c301
> > >
> > 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&
> > >
> > amp;sdata=LHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > mp;reserve
> > > d=0
> > > remoteproc/list/?series=604364
> > >
> > >
> > > Peng Fan (2):
> > >   remoteproc: introduce rproc features
> > >   remoteproc: support attach recovery after rproc crash
> > >
> > >  drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
> > >  drivers/remoteproc/remoteproc_internal.h | 15 ++++++
> > >  include/linux/remoteproc.h               | 16 ++++++
> > >  3 files changed, 74 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.25.1
> 
