Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE8605261
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJSV44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJSV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:56:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C3F9851
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:56:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h2so11175216plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2aRiLyWvRUlvRE5N2MJoq49Gk7v0uQF4nuK/XgZXeI=;
        b=j5cM3oTJaW15wbf1WDQR3SG+HiIfE1NeKieuBFlF7niQeo5PlkEIsOSBaAY03P6xZP
         ETODBU7scJhRAAluN542ojdhne1x/nh1U/HMr82A9r6wuZfSoRE3n+5RQ0yOG+/q8KEc
         4NrTwpgxy1Ua18JHIzBXlJzTeWF8b2JARfIVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2aRiLyWvRUlvRE5N2MJoq49Gk7v0uQF4nuK/XgZXeI=;
        b=wYZXLxxCG56Jv6D38v2qXWSRtvbgaZ/Yt2HXb9ol9oK7xZR0ve2/Zc/sEmTPcVo1+v
         KlvyG0FL5S0DBi8Vbk4EaP/F6bILXxJJA57hO+HifGpgVRGiZzmb4mWOhC1tPllH/B4d
         hHdBBpwzgw/eWvnH4deN6xmkKd9AismqzYokmhtpkFAZp1NBmSBRaVjRE6drTEspi+Mp
         58/ZDVGMKReKEI9r5oxCmydt5+J5PLnI4j4sUQNcpahO96grmznOBttd+3K0ahakQouS
         ZhRB04G6gfq20YzMwJ2T5mMcGn5F7EtoR8i4msTH2ceXN/IdLI3Zaij8GRPYwi+OF2YM
         GfHQ==
X-Gm-Message-State: ACrzQf3vI/EP2wBBzfKBXOTfffSt9j7vqOEeItBnnnREjQk1n9D5q/lC
        S78VVorQ6UZPPaMXKYfbNw7UXA==
X-Google-Smtp-Source: AMsMyM6ZnXir4B36pdQVeqzQ6UMoGGdhfhXA7wKzmHS2lucDmHeECMGKp4r+5S3L3wGAnnQEh559Xw==
X-Received: by 2002:a17:90a:aa8f:b0:210:bec0:bde with SMTP id l15-20020a17090aaa8f00b00210bec00bdemr2814613pjq.109.1666216611530;
        Wed, 19 Oct 2022 14:56:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with ESMTPSA id s6-20020a625e06000000b00562bc93f1c9sm11793504pfb.213.2022.10.19.14.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:56:51 -0700 (PDT)
Date:   Wed, 19 Oct 2022 14:56:48 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Al Cooper <alcooperx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 3/5] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y1ByoA3MreJTp2my@google.com>
References: <20221018035724.2061127-1-briannorris@chromium.org>
 <20221017205610.3.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
 <DB7PR04MB40107D412EC0DA5517E6CC4B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB40107D412EC0DA5517E6CC4B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 07:22:04AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Brian Norris <briannorris@chromium.org>
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1288,6 +1288,13 @@ static void esdhc_set_uhs_signaling(struct
> > sdhci_host *host, unsigned timing)
> > 
> >  static void esdhc_reset(struct sdhci_host *host, u8 mask)  {
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL)
> > &&
> > +	    imx_data->socdata->flags & ESDHC_FLAG_CQHCI)
> 
> I think we can remove the condition " imx_data->socdata->flags & ESDHC_FLAG_CQHCI" here.
> According to code logic, host->mmc->caps2 & MMC_CAP2_CQE means it already contain imx_data->socdata->flags & ESDHC_FLAG_CQHCI

I don't know why I had this in the first place. Maybe just to be
double-sure that caps flags aren't getting set elsewhere (e.g., by the
core)? But you're right, and I've dropped this in v2.

Thanks,
Brian
