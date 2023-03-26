Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9B6C980E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCZVtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCZVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:49:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C659E2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:49:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q27so4266108oiw.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679867348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jPnc/mNq3d+a+FglCHgJpNdOZEFwd7wj5X3i1Idl2k=;
        b=gn++6ZvnWydiyQDWYLM37Su6Y8V5AelENXkUd1zfa//HNth0qxGvJN+a89bYW+xj5L
         bfX2CxHvmPzI2zOwDeKc1dQM5IlRAAon4lh/hb/Ol5TRreXiVsnui+aobUeYC6VqO517
         R0C1He49n7ubWTQdzZzzP7Lo9HxJdKUSAEOXvw07XY4a8aCwNWHi/BAhEJjNQL2YPpbB
         FbWmvqiwqBh5hvinVOXCzxhDYBLMRskPTfgw4JpblnaEZu6TvpDhjHUVz+dI+ZJbqGhW
         ebahe6bV++hj8P476NOp7FQVOZqLIpHK5KhfvjAf7wJMUnGXywtNPmPQi9Ez5sUugn1j
         WEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679867348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jPnc/mNq3d+a+FglCHgJpNdOZEFwd7wj5X3i1Idl2k=;
        b=ZsquQTm/6qHawf6r1dIt9AiCSlJZlc6fgJ0Auz/tReNueYJSVK2WhepcjqkOeJWhOK
         L/Oa2BXBmPdzqdMKc7dovAbX/Sj53lpwIF9hAC6Ux0UlxyjVTb+ro+Zn9sbUcKzPkOMd
         EZRXPo9Wjf2hrGoFy/+qDrgAjPpOumigqBQ9HJPCc577WunlpTXLDpb5IMD6JfrKnd5C
         SDxMOMAy76ZHYZxgptJYtYOXPhHde57BXLE2XlmhMQ8CqeGxTamSH96DD4tux1i0Vn1l
         C+zw/AIRz8Xb95PRrpiTcgtsKGqlgeaGkSEKbd3YEWhAI/BKmqhyxbk1CvI37qQ3fJxI
         LGjQ==
X-Gm-Message-State: AO0yUKX0amqskDLS93p4fnZ8+ChCBq40gDkN1ERl+nDQi03//5kzafs2
        T1nQTP0gOJPownxi+AQQzTs=
X-Google-Smtp-Source: AK7set8dH4HtvjhK+fXwyFFt+qdAPbaKRPt8t0aLV6eBrQH8ELAGqmtVsBdJ+8shFunKm/pjE/e2nw==
X-Received: by 2002:a05:6808:6190:b0:384:23da:6e73 with SMTP id dn16-20020a056808619000b0038423da6e73mr3879432oib.47.1679867348216;
        Sun, 26 Mar 2023 14:49:08 -0700 (PDT)
Received: from geday ([2804:7f2:8002:df06:a135:1d39:bf0c:2898])
        by smtp.gmail.com with ESMTPSA id bl31-20020a056808309f00b00384a45d3106sm10418910oib.58.2023.03.26.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 14:49:07 -0700 (PDT)
Date:   Sun, 26 Mar 2023 18:49:08 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Shenghao Ding <13916275206@139.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
Subject: Re: [PATCH v7] ASoC: tas2781: Add tas2781 driver
Message-ID: <ZCC91Jhv9+rlb3FM@geday>
References: <20230326143419.11711-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326143419.11711-1-13916275206@139.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

On Sun, Mar 26, 2023 at 10:34:19PM +0800, Shenghao Ding wrote:
> +config SND_SOC_TAS2781
> +	tristate "Texas Instruments TAS2781 speaker amplifier"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select CRC8
> +	help
> +	  Enable support for Texas Instruments TAS2781 Smart Amplifier
> +	  Digital input mono Class-D and DSP-inside audio power amplifiers.
> +	  Note the TAS2781 driver implements a flexible and configurable
> +	  algo coff setting, for one, two, even multiple TAS2781 chips.

You changed coff->coefficient below as suggested by Pierre-Louis Bossart
but you forgot to change it here, and this will surely perplex people
when configuring the kernel.

> +
>  config SND_SOC_TAS5086
>  	tristate "Texas Instruments TAS5086 speaker amplifier"
>  	depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index f1ca18f7946c..5559b9e9cc17 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -262,6 +262,7 @@ snd-soc-tas5805m-objs := tas5805m.o
>  snd-soc-tas6424-objs := tas6424.o
>  snd-soc-tda7419-objs := tda7419.o
>  snd-soc-tas2770-objs := tas2770.o
> +snd-soc-tas2781-objs :=	tas2781-i2c.o tas2781-dsp.o
>  snd-soc-tfa9879-objs := tfa9879.o
>  snd-soc-tfa989x-objs := tfa989x.o
>  snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
> @@ -619,6 +620,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
>  obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
>  obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
>  obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
> +obj-$(CONFIG_SND_SOC_TAS2781)	+= snd-soc-tas2781.o
>  obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
>  obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
>  obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
> diff --git a/sound/soc/codecs/tas2781-dsp.c b/sound/soc/codecs/tas2781-dsp.c
> new file mode 100644
> index 000000000000..6a0e9fb5e20f
> --- /dev/null
> +++ b/sound/soc/codecs/tas2781-dsp.c
> @@ -0,0 +1,2232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
> +//
> +// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +// https://www.ti.com
> +//
> +// The TAS2781 driver implements a flexible and configurable
> +// algo coefficient setting for one, two, or even multiple
> +// TAS2781 chips.

Here it is OK.

Thanks,
Geraldo Nascimento
