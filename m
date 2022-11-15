Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79162A160
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKOSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKOSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:33:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B2303CD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:33:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y13so14889385pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9sKZ10Ykv4CJ84SfGJqUVfFHchCNyvWc7Bn7ZeArVk=;
        b=nWY4GIyVWUzLwpnqKq+tVPfTpW4IdJ6Ym+rniKqcWT8tl1eie2BCPkXuZDOMrWtXxM
         c6Xz1pUMDlcKhwil5S3lBCZ4Ancvm03ZRMpMAg3snc59s/lipr1MTjZdCVwP9NoNlqdt
         gC/oj5Q2YzS8jcj5r6IBRD6EODAcMkDXwcyIpqzRpv3sLm2TYPgR/c5LeHgymFHS7ifz
         Bl7AGqFV33JRsJu5ajoNOhZuqoY3kd8LfrNTpMqpKqurPyIEVwymCw+2Jxju8Pr8/W31
         EZQdah0ci9NHFK0C9PMpbSsQ6GL4+xAKU7CWMZiIx5N40I1WSTxCvreVhMZ4pv8m3UD0
         Qu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9sKZ10Ykv4CJ84SfGJqUVfFHchCNyvWc7Bn7ZeArVk=;
        b=nfO9IRuDgPnNAaCH3IvBCyMlbqbZi0FC8DLqnEp4jBadjufIcIUTCdC7v+q/DtcQ+o
         Sv6tE4J6N8J+KB6FsPrgtJdYdhNB/aqznRrIuYS+bg5/1I/L3idpUu0+dYSyuLO2FpzT
         mt2rJE5q513V4lWuJGg9WugAqzUSJ6AMvrvwqS1gsygd4mmIm5yrgvYYu3AXp3/0l9xr
         NaddLBmaB6Mlo0UGHRclbh7UYx83H3kUQKDhcl5WR+/ifw9lynoA1sMDIiAVpXCmOHJX
         ymhdMNpFXqWvI6UmuyBTqaMdsxe9hD34LkGR7jhAZ0OKKl/tjahau/M0tXJq5vtQD+L7
         FqMw==
X-Gm-Message-State: ANoB5pkAiAaEZb6Wm0tkIPHSXEkweIPzUVVlM1cDw4+4qcXNC8sF4/Ox
        /XOXMuZ0iNUqZAWUN0PaQp809Q==
X-Google-Smtp-Source: AA0mqf4wcV2CkrkjUfEGRnmxggjGCJg2GsNVQkQnC6/vwoiXbiTVw5KvWrpCHZp+4wmJbe8I81xm5w==
X-Received: by 2002:aa7:8696:0:b0:571:ea17:e111 with SMTP id d22-20020aa78696000000b00571ea17e111mr13681360pfo.25.1668537187947;
        Tue, 15 Nov 2022 10:33:07 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00178acc7ef16sm10113525pln.253.2022.11.15.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:33:06 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:33:04 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Message-ID: <20221115183304.GB61935@p14s>
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
 <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
 <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221104152732.GA1873068@p14s>
 <DU0PR04MB9417DF72B41F79CCF63823DF883C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417DF72B41F79CCF63823DF883C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 12:27:58AM +0000, Peng Fan wrote:
> 
> 
> > -----Original Message-----
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Sent: 2022年11月4日 23:28
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; andersson@kernel.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; linux-
> > remoteproc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
> > 
> > On Thu, Nov 03, 2022 at 06:11:46AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM
> > > > mapping
> > > >
> > > > On Wed, 2 Nov 2022 at 05:12, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > According to updated reference mannual, the M33 DRAM view of
> > > > > 0x[C,D]0000000 maps to A55 0xC0000000, so correct it.
> > > > >
> > > > > Fixes: 9222fabf0e39 ("remoteproc: imx_rproc: Support i.MX93")
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  drivers/remoteproc/imx_rproc.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > > b/drivers/remoteproc/imx_rproc.c index 2c471e46f4ca..9fc978e0393c
> > > > > 100644
> > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > @@ -134,8 +134,8 @@ static const struct imx_rproc_att
> > > > imx_rproc_att_imx93[] = {
> > > > >         { 0x80000000, 0x80000000, 0x10000000, 0 },
> > > > >         { 0x90000000, 0x80000000, 0x10000000, 0 },
> > > > >
> > > > > -       { 0xC0000000, 0xa0000000, 0x10000000, 0 },
> > > > > -       { 0xD0000000, 0xa0000000, 0x10000000, 0 },
> > > > > +       { 0xC0000000, 0xC0000000, 0x10000000, 0 },
> > > > > +       { 0xD0000000, 0xC0000000, 0x10000000, 0 },
> > > >
> > > > But how did this work before?  Were some SoC released with the old
> > > > mapping?
> > 
> > As it is regularly the case, you have not answered all my questions.
> 
> The DRAM mapping was not tested, I just wrote them down according
> to the information I had.  In this patch, I just fix the mapping at address
> 0xC0000000, I not add 0xA0000000, I may also add it or use a separate
> patch, which would you prefer?

Seperate patch?  This is a seperate patch...

> 
> The i.MX93 SoC is still in pre-production phase, and there is no public
> Information for now.
>

That is all I wanted to know.  Other implementation can't be affected by this
change because the sillicon is still under development.  Simple isn't?

I am applying this patch.

> Regards,
> Peng.
> > 
> > > The current m33 firmware release with Linux SDK only has TCM version,
> > > so I not have image to test the DDR mapping.
> > >
> > > Initially we got the information that M33 mapping of DRAM.
> > > DRAM (offset 0 MB)	DRAM	80000000
> > > DRAM (offset 256 MB)	DRAM	A0000000
> > > DRAM (offset 512 MB)	DRAM	C0000000
> > >
> > > However the information is wrong after we check more, there is an
> > > 256MB hole, 0MB [0x80000000, 0x8fffffff], 512MB [0xa0000000,
> > > 0xafffffff], 1024MB [0xc0000000, 0xcfffffff]
> > >
> > > I use JTAG to confirm it.
> > >
> > > Thanks,
> > > Peng.
> > > >
> > > > >  };
> > > > >
> > > > >  static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
> > > > > --
> > > > > 2.37.1
> > > > >
