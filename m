Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD3606963
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJTUQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJTUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:16:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BA1AD68D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:16:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4568187pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wikui5zgMClbBeCdN445jqfppxsvsQZJYe9z/nf05m0=;
        b=ASoOmFYLo5BTraLYzv/b7dLlDyzP0vgBCEknTYECrAhZkt+PpKZ1PTM75k0/hhInvx
         1Ysx98awdp1c/ubfYxfmV8fc1f26ao0wGB1psiiU1Avz6SZif3CxTM670a1fC1CC/zgH
         tgiiWPhk7gQ2OXf+ASObEMmn+Z51DONYr+9RYGVr/JDM1iboSxcXoxY+5GYGTGRNa7pd
         MiZeqA90vWubpr4ZlT+f0MK/SwtiHrI0Kv5dl5f2UaS/+fjS/Ie7nzfVNIWukOsxnfpQ
         UVSzZAxE+Yc4vxEz0DKdSvG/oCKe5wTtFZQy0+DWA9B+Rbmtv7xZpIJjzPevAfGROyM5
         Fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wikui5zgMClbBeCdN445jqfppxsvsQZJYe9z/nf05m0=;
        b=5uj79LiIrx9cNf25UxFR6WFFVvXadgk+ZuwA5u+/tjKhIAR1aPZwbN2XxP++uW4ZsO
         Fj4dRQbnRLm7MD7IUTxs3uMM7EmTezUUHeVckrUJnYqx7HeyrANzacxhy6p6GCH/nRy6
         /0pNw3BzS+p2r2nqp6Ens1N3sIa3CDhQTOzxcuEepZWBoH23l1VAOAEB10APxn1J3+lZ
         v3CbiYFxgaBwZqgUD19APYoffIJCxp1YpoMyr2RB5zI+QcsHt51jcXFJbs9NOXsqzfKk
         kD+B7DXyQmBu9lP/kaBt18krU4VtNf3AUgn73sXyQuRyrhaJqNKnaMYwVHCEXg8xqgzZ
         U5/w==
X-Gm-Message-State: ACrzQf12ym/MeFHqFs+SrvMADN0rTNXzRTsUUzocKrfRTe/WfHW2WZBy
        ACYKj6qr5Rr4j+lfya7FF6IQMhcWGg8=
X-Google-Smtp-Source: AMsMyM4/3D1Pz5sNpGtnA0LdFxLhp4bIZISRVx0CyF1f15UBM6lrxC5MlxiDLjFeba2y6inz18ilqw==
X-Received: by 2002:a17:90a:e393:b0:20a:eded:cbae with SMTP id b19-20020a17090ae39300b0020aededcbaemr54542555pjz.168.1666296960090;
        Thu, 20 Oct 2022 13:16:00 -0700 (PDT)
Received: from mail.google.com ([202.36.29.252])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b00176ba091cd3sm13538528plh.196.2022.10.20.13.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:15:59 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:15:53 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/pi433: Change data type of bit_rate to
 be u32
Message-ID: <Y1GseU1Z+CCHJs9I@mail.google.com>
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
Thanks for sending this patch. Comments added in-line.

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

Cutting a long story short, you won't be able to change bit_rate's type before 
addressing the fact that both pi433_tx_cfg ans pi433_rx_cfg are part of the UAPI.

Usually there are 2 approaches that most people go for when talking about
changes in drivers:

1) Add changes in a backwards compatible way, so whether users are using the
        bitrate member as u32 or u64, it would simply work. But that leads to
        sometimes hard-to-read code.... but this is still a card up your sleeve.

        One suggestion given by Dan Carpenter was to leave the IOCTL impl alone
        and start a sysfs implementation. That way you could have a u64 bit_rate
        synthetic file.

        https://lore.kernel.org/all/20220119053410.GW1978@kadam/

2) Change the tools that make use of this driver at the same time as you change
        the UAPI. This can be tricky. There is a thread I started in the
        kernelnewbies mailing list on the subject which I think might be relevant
        for you to read.

        https://lore.kernel.org/all/YjHvLFSV06w%2FORgV@kroah.com/

Happy coding :-)

Paulo A.

