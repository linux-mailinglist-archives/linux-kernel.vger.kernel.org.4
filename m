Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C6689969
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBCND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjBCNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:03:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51AB13D6D;
        Fri,  3 Feb 2023 05:03:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hx15so15064926ejc.11;
        Fri, 03 Feb 2023 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhw606rE28kJkerg6webpCcTMHL9GNutaEWEkICkP4A=;
        b=dWAat21FSCa+ly38JnA6kNDPMfUkpj2HPBcqphl2Tph4+firr4q+JxKSF1FoooSloK
         oHJABjdQekom3WQGVRnrTJqvyWJE9ZDVAa/Cn6rfA8GFqtFSHbrps/eaRgblnoPJlibx
         7hffzcWoaQaUoaoYbXtHsYr6na5lwCDC2vwvMQXUTgflvTfxKfWdx0OIXQhdFEntWpxN
         xeocA8eK+blhIi792omSvidtSaKb85OVzsGe7T8bZ5pt/+0UA20DMjwcH0WA2xecIyjd
         ab/tr++iLyYr9sAOpZtfzDlWeQ2a02ceipWASZBVGTPUN+iLfeMWjkSe/vNUqNxiFX8Q
         IlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhw606rE28kJkerg6webpCcTMHL9GNutaEWEkICkP4A=;
        b=fZ5euVCPAcmWJ8YPdKGWJ+wU5Jxyevx6M555DNIIBXIKBf/fleXqnuMXN2LRoBLQa+
         KRZEw8NKLqszsGN5wHzjq9gfJt0uLezwgtD/5UFc5NBCWzakYPCOe2rkLKEaOy/+PZOm
         W3my12WbAadAfwlKVrfR2FgRr0cBlskX7OOdNbs2h5D1CZZJw1xbX8RrD904uNSouMvf
         VCVIlA0r7WsQrPD3blj0k5OATea+NF1eiN9aMOhp3b4QzGoymYBu8bGW6Y7O8x7Tg8i/
         v35hkQpqiLZ9fC7qeH9i6ncsYqnH7GkkMBZxhEjItndnTl74Rzl6FKMwj5ftzwn7KpyY
         LddA==
X-Gm-Message-State: AO0yUKURg2FEV+sGW9OUNHGWNk/HoJYeF8T8wR7VLFQYSYCKBZg9795C
        syE6IlKJr4QqKxBtXngV13ToMIGbOFAtLwP6Gvg=
X-Google-Smtp-Source: AK7set+GT28lvuIdrbuFkNyv98dve6hfJTkOGU/HVRCnNu1qb7iwfUz7ktL1kTisAd1J43RlxafLdC/jh8jQfopFLe4=
X-Received: by 2002:a17:906:139b:b0:88c:1d3d:6fab with SMTP id
 f27-20020a170906139b00b0088c1d3d6fabmr2969827ejc.299.1675429400191; Fri, 03
 Feb 2023 05:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <CAEnQRZB4ZLWcz-2jqZ7UDFxc60U9BFu_QuV9AvRYdqvC=Y-zwg@mail.gmail.com> <DU0PR04MB9417C6008B6352F7FB34355F88D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417C6008B6352F7FB34355F88D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 3 Feb 2023 15:03:08 +0200
Message-ID: <CAEnQRZDbC3MzcQ69yUzM9L71mP0CT5EAQWCpzafvsxaWeUwj4w@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 2:55 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Daniel
> > Subject: Re: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in
> > DDR
> >
> > On Fri, Jan 27, 2023 at 11:26 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V2:
> > >  patch 4 is introduced for sparse check warning fix
> > >
> > > This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
> > > could be in DDR, not just the default TCM.
> > >
> > > i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> > > initial value could be got from firmware first section ".interrupts".
> > > i.MX93 is a bit different, it just needs the address of .interrupts
> > > section. NXP SDK always has .interrupts section.
> > >
> > > So first we need find the .interrupts section from firmware, so patch
> > > 1 is to reuse the code of find_table to introduce a new API
> > > rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
> > >
> > > Patch 2 is introduce devtype for i.MX8M/93
> > >
> > > Although patch 3 is correct the mapping, but this area was never used
> > > by NXP SW team, we directly use the DDR region, not the alias region.
> > > Since this patchset is first to support firmware in DDR, mark this
> > > patch as a fix does not make much sense.
> > >
> > > patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
> > > .interrupts section. Detailed information in each patch commit message.
> > >
> > > Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
> >
> > Hi Peng,
> >
> > Few observations:
> >
> > - bugfixes should come first in the series.
> > - in case we want to patches to be pushed back into stable releases please
> > add "Fixes: " tag.
>
> You mean patch 4: sparse warning fix?
> Or patch 3 is correct the mapping? Or both? For patch 3, I would not take
> it as fix, I just think there is no people using this ddr alias address. If you
> prefer, I could add a fix tag for patch 3.

Yes, I mean patch 3) which is definitely a thing that stable versions
could benefit.
