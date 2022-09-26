Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C7C5EB18B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiIZTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIZTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:48:43 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2AC6593;
        Mon, 26 Sep 2022 12:48:35 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1274ec87ad5so10714811fac.0;
        Mon, 26 Sep 2022 12:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M50FI7LNj1aukpmOfyVHjUDvsfAXsOHY9FPlj/V6CBo=;
        b=vj+1cQeYdfHmG4O+2QWYIO/LBFMZ9IY4qVVruWvjPS/UqWen7zw4SrH6henjrrvB2a
         g/BgONi6HRA/RMZUwsu6Idfc8VIi66aIrwxMC/3MWyNYcNRVKoXM/tmr5yuS5sIAy1Em
         mTDd8reVmjOcOIH0Ltvi7fzzcpWOVDw3F7WIijiIA+kGbscp/vlTm+lfWcHYCfgTlP1U
         X3vYDlpDzlUDT9kqo3BRqtSh/+RU6zAe1zA7omBCuwd1vYGSgKyD33GVQnn+IAkPxwrA
         h4/oOaK3sn6G5YlCPTQ2zFCxslKi/48eAm4oTvXT0sf+D8egZquPWfA15yvYOFyjSGQL
         Q57A==
X-Gm-Message-State: ACrzQf3WTHUlXiyLeY9vdk5kjPn0rfydW7Uu+ad3HjskvEuaK68lWtWe
        o8dcJmJoCtaeNuuYLLGpYc5MnuLz6g==
X-Google-Smtp-Source: AMsMyM6Br1/MAg6GDzGavnanJLMgJ/Uf+HWn8UkUSSrF2UjAIQWyzkfE3qsANrovvBLiJVEF2w+YjA==
X-Received: by 2002:a05:6871:b26:b0:127:7d57:9e28 with SMTP id fq38-20020a0568710b2600b001277d579e28mr188586oab.141.1664221713866;
        Mon, 26 Sep 2022 12:48:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5e89a9c60sm10413556oao.3.2022.09.26.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:48:33 -0700 (PDT)
Received: (nullmailer pid 2677686 invoked by uid 1000);
        Mon, 26 Sep 2022 19:48:32 -0000
Date:   Mon, 26 Sep 2022 14:48:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ASoC: kirkwood: enable Kirkwood driver for Armada
 38x platforms
Message-ID: <20220926194832.GA2668987-robh@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
 <20220920132648.2008-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920132648.2008-2-pali@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:26:44PM +0200, Pali Rohár wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
> other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
> driver can be used to support it and this commit adds new compatible string
> to identify Armada 38x variant.
> 
> Two new memory regions are added: first one for PLL configuration and
> the second one for choosing one of audio I/O modes (I2S or S/PDIF).
> For the latter purpose a new optional DT property is added ('spdif-mode').
> 
> kirkwood-i2s driver is extended by adding a new init function for Armada
> 38x flavor and also a routine that enables PLL output (i.e. MCLK)
> configuration.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Tested-by: Star_Automation <star@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Hezi Shahmoon <hezi@marvell.com>
> Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> [pali: Fix support for pre-38x SoCs]
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
>  sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
>  sound/soc/kirkwood/kirkwood.h                 |   2 +
>  3 files changed, 149 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> index cb8c07c81ce4..4f5dec5cb3c2 100644
> --- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> @@ -6,9 +6,14 @@ Required properties:
>    "marvell,kirkwood-audio" for Kirkwood platforms
>    "marvell,dove-audio" for Dove platforms
>    "marvell,armada370-audio" for Armada 370 platforms
> +  "marvell,armada-380-audio" for Armada 38x platforms

Perhaps be consistent with the 370 string above it.

>  
>  - reg: physical base address of the controller and length of memory mapped
> -  region.
> +  region (named "i2s_regs").

So you are adding 'reg-names'? The values belong under 'reg-names' then. 
'_regs' is also redundant.


> +  With "marvell,armada-380-audio" two other regions are required:
> +  first of those is dedicated for Audio PLL Configuration registers
> +  (named "pll_regs") and the second one ("soc_ctrl") - for register
> +  where one of exceptive I/O types (I2S or S/PDIF) is set.
>  
>  - interrupts:
>    with "marvell,kirkwood-audio", the audio interrupt
> @@ -23,6 +28,13 @@ Required properties:
>  	"internal" for the internal clock
>  	"extclk" for the external clock
>  
> +Optional properties:
> +
> +- spdif-mode:
> +  Enable S/PDIF mode on Armada 38x SoC. Using this property
> +  disables standard I2S I/O. Valid only with "marvell,armada-380-audio"
> +  compatible string.

So boolean?

> +
>  Example:
>  
>  i2s1: audio-controller@b4000 {

DT changes should be separate patch. It would also be nice to see this 
converted to schema first.

Rob
