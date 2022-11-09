Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE536229BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKILJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiKILJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:09:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C7645C;
        Wed,  9 Nov 2022 03:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C57B9CE1CE3;
        Wed,  9 Nov 2022 11:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BAC433D6;
        Wed,  9 Nov 2022 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667992170;
        bh=gePMbDLBiqDoWg7fZmMC3tcRsatb0/x+KppJV5pZlxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BysyAq8hpl8MPcSx7crD/arC8SVUT8+9cH+u+F8KxSpcyINlC1QQ44MZlyxXiVWgI
         5sWRVLC8wXZDp3JoCcSin5ZGLWSZM2e+STuOlQxJ7N3Fa8dO80rBSZPDJ2DQ5RhIqR
         r/gXULVj6KHvCjWcv7BK/+3rWK6uxXll+E29SeGlKr3ppKJmQH44CRt544nardhQz0
         8pxJ529HytGSSaoF8UL65xl+KiC7ZwIphpuJiQ1pfF8ot0/sFfmBPkwOtBdKfqHYbU
         X6gy8CdjcH3rt8/4OwLgsfL7Mg0wMsjhc8fJINjslWAafrZZifXiIlSQauJH0+8gGA
         jy457vvMjvSbQ==
Date:   Wed, 9 Nov 2022 16:39:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aniket Randive <quic_arandive@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_ramkri@quicinc.com
Subject: Re: [RESEND V1] soc: qcom: geni: Add SPI Slave protocol type
Message-ID: <Y2uKZZqF/Pps8hvU@matsya>
References: <1667987326-13970-1-git-send-email-quic_arandive@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667987326-13970-1-git-send-email-quic_arandive@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 09-11-22, 15:18, Aniket Randive wrote:
> Add "GENI_SE_SPI_SLAVE" entry in enum which represents the
> protocols supported by GENI Serial Engines. This is needed

Ok

> to support the SPI slave feature on QUP based target.

Where is that support. Typically we dont merge things without users, so
please add this patch along with slave support in driver

> 
> Signed-off-by: Aniket Randive <quic_arandive@quicinc.com>
> ---
>  include/linux/qcom-geni-se.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index f567278..9fb2175 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -35,6 +35,7 @@ enum geni_se_protocol_type {
>  	GENI_SE_UART,
>  	GENI_SE_I2C,
>  	GENI_SE_I3C,
> +	GENI_SE_SPI_SLAVE,
>  };
>  
>  struct geni_wrapper;
> -- 
> 2.7.4

-- 
~Vinod
