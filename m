Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C860696E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJTUW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJTUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:22:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D8D1A8500
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:22:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy4so2299911ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIPqJ4tUUqVv4kMlvwmVLXisEqmV1Wy98VDaAlo8cFI=;
        b=CS2zvH+k5N7l3LrbqPDzVAfRb2X3xwhWeezCIDERtzeXe7n3Jc1kxEm5CvcbYFdjbt
         sVp8d5gnhwyB+Qn5SJYvQgrR1WRBw19GHkhVrFji8LpGhZsEaN8B7em3CYtrOqJwZWmJ
         gdFvoliSKMks6Xuigzq7/keq3/dqgAjcyQSCd7qRo7bTwbzn5uWmqrRe440YKIQRcbO1
         K2+A7EtHArXAZqknjFS7Wmqfmxq2qjb9axcuugvyZDMfxMMKTiXzQXZapDPXYZzoiryu
         ihjpX5P6OU84Oct6wN3fY5OGVYgnc/BeethM002chyqpXlZLsFjoQqC1klvphzOxhw1H
         qWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIPqJ4tUUqVv4kMlvwmVLXisEqmV1Wy98VDaAlo8cFI=;
        b=7XvN469wNOpSPhlc3SWl4O9iJNju2Bf+3foor1bz0hRuqBbbeR7tivk0LUKDatdw1H
         KjEpmWidY6dI/WN5j0iwtgQi9LqT3naY3xSIrzS9YIPwnH4YfnFiGDByY5SV8Y8Cgunr
         P3zo9CcK48WmvmZNG7lEBRvCdUcmzmFxskKO0Nqd3L+WyB1pdCh93xQzPidM+pUC8yQF
         BNWdmDNQ0ucfprm3AqH7UamHC1XK0ebCJCxSbd4PjW6TZvR7luNWMCyB+Am2QNxzXtLz
         K0zBmk+3yq3MZm55fq6fSzV/PbOHJeuEDZ4zy996DvzRe3Elcb4/s5UcnQMtvPlT/M7l
         0toA==
X-Gm-Message-State: ACrzQf33/PS+SE+bfKWCKF0epZ6sBnryvAuy7jcpGZ4x0JGlULtB7Bq0
        Z+3X/WUIcsDo2cvDJ5KkLkk=
X-Google-Smtp-Source: AMsMyM4f2ufX2BUCbXdG1/Dplbhqpe4VBpCycpr9+0UsaNzHZxPdhBKRRFdQffGiHCzRx/XbIFEnFQ==
X-Received: by 2002:a17:907:c25:b0:78e:1a4:132 with SMTP id ga37-20020a1709070c2500b0078e01a40132mr12598741ejc.521.1666297341799;
        Thu, 20 Oct 2022 13:22:21 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906710900b0073a20469f31sm10743281ejj.41.2022.10.20.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:22:21 -0700 (PDT)
Date:   Thu, 20 Oct 2022 22:22:10 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/pi433: Change data type of bit_rate to
 be u32
Message-ID: <20221020202210.GA16547@nam-dell>
References: <20221020181815.31245-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020181815.31245-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:48:15PM +0530, Gautam Menghani wrote:
> A TODO asks to convert the bit_rate variable to be a u32 so that bit 
> rates up to 300kbps can be supported as per the spec.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
> Please note that this patch is only compile tested.
> 
>  drivers/staging/pi433/TODO       | 2 --
>  drivers/staging/pi433/pi433_if.h | 4 ++--
>  drivers/staging/pi433/rf69.c     | 2 +-
>  drivers/staging/pi433/rf69.h     | 2 +-
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
> index 5cf3fd99d521..8530bbe61d70 100644
> --- a/drivers/staging/pi433/TODO
> +++ b/drivers/staging/pi433/TODO
> @@ -1,5 +1,3 @@
>  * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
>    -> Replace this with another interface, hints are welcome!
>  * Some missing data (marked with ###) needs to be added in the documentation
> -* Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
> -    bit rates up to 300kbps per the spec.
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index 25ee0b77a32c..c958dcfa9f96 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -51,7 +51,7 @@ enum option_on_off {
>  #define PI433_TX_CFG_IOCTL_NR	0
>  struct pi433_tx_cfg {
>  	__u32			frequency;
> -	__u16			bit_rate;
> +	__u32			bit_rate;
>  	__u32			dev_frequency;
>  	enum modulation		modulation;
>  	enum mod_shaping	mod_shaping;
> @@ -99,7 +99,7 @@ struct pi433_tx_cfg {
>  #define PI433_RX_CFG_IOCTL_NR	1
>  struct pi433_rx_cfg {
>  	__u32			frequency;
> -	__u16			bit_rate;
> +	__u32			bit_rate;
>  	__u32			dev_frequency;
>  
>  	enum modulation		modulation;
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 8c7fab6a46bb..7e754a3aef5f 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -185,7 +185,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
>  	}
>  }
>  
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
> +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
>  {
>  	int retval;
>  	u32 bit_rate_reg;
> diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
> index 78fa0b8bab8b..46a1fb2d5329 100644
> --- a/drivers/staging/pi433/rf69.h
> +++ b/drivers/staging/pi433/rf69.h
> @@ -24,7 +24,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
>  int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
>  int rf69_set_modulation_shaping(struct spi_device *spi,
>  				enum mod_shaping mod_shaping);
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
> +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
>  int rf69_set_deviation(struct spi_device *spi, u32 deviation);
>  int rf69_set_frequency(struct spi_device *spi, u32 frequency);
>  int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
> -- 
> 2.34.1
>

I sent (almost) the exact same patch a while ago. I received a reply
saying that doing this is not possible. That conversation can still be
found here:
https://lore.kernel.org/linux-staging/20220315180820.7393-1-cvn249@gmail.com/t/#u

Best regards,
Nam
