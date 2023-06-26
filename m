Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBF73D9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFZIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:32:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFA135;
        Mon, 26 Jun 2023 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687768359; x=1719304359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=grxXtT68EdlEfB3RgfyL5Y0y3IkvhqXegQFjIRACSPU=;
  b=fVNR43gFM/WdmBwaTd5v1hsw/d3XJYgUqdbdkHgoY7okduH2CI8nlxip
   fGQG7/+1Lvn6Sbe/Cp7ryCbxadlnERdqhoPR1NN7c/Zhvo/EwAUsQ7wUR
   hWgDm1TpdVgrgUt6VkatuJ20Y09/jt0RlsQinR17YydtS7EsN231CUokC
   qVKfXN2zyBTIELl9+VKINPDaZmxYIopjxyGjN+1sftWoYKWd5SIQNYnVy
   wBahcAWC8ziV59e6rsySV5GM8KkY5BObz2YwPPtJPD09V0+q8bdfAryZ0
   vFK5qQ05qlADuzHspUjmrkFFSANV3wO1emkUEY8wdKMzi57CyrgPWAc5g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447595480"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447595480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860605760"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860605760"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:32:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:32:36 +0300
Date:   Mon, 26 Jun 2023 11:32:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: fsa4480: add support for Audio Accessory
 Mode
Message-ID: <ZJlNJGNdaknLmXar@kuha.fi.intel.com>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-3-15a92565146b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-3-15a92565146b@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:10:41PM +0200, Neil Armstrong wrote:
> The FSA4480 Type-C switch supports switching the Audio R/L,
> AGND and MIC signals to the USB-C DP/DM and SBU1/2 to support
> the Audio Accessory Mode.
> 
> The FSA4480 has an integrated Audio jack detection mechanism
> to automatically mux the AGND, MIX and Sense to the correct
> SBU lines to support 3 pole and both 4 pole TRRS pinouts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/fsa4480.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index b2913594a58f..45f5683b7d81 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -25,15 +25,24 @@
>  #define FSA4480_DELAY_L_MIC	0x0e
>  #define FSA4480_DELAY_L_SENSE	0x0f
>  #define FSA4480_DELAY_L_AGND	0x10
> +#define FSA4480_FUNCTION_ENABLE	0x12
>  #define FSA4480_RESET		0x1e
>  #define FSA4480_MAX_REGISTER	0x1f
>  
>  #define FSA4480_ENABLE_DEVICE	BIT(7)
>  #define FSA4480_ENABLE_SBU	GENMASK(6, 5)
>  #define FSA4480_ENABLE_USB	GENMASK(4, 3)
> +#define FSA4480_ENABLE_SENSE	BIT(2)
> +#define FSA4480_ENABLE_MIC	BIT(1)
> +#define FSA4480_ENABLE_AGND	BIT(0)
>  
>  #define FSA4480_SEL_SBU_REVERSE	GENMASK(6, 5)
>  #define FSA4480_SEL_USB		GENMASK(4, 3)
> +#define FSA4480_SEL_SENSE	BIT(2)
> +#define FSA4480_SEL_MIC		BIT(1)
> +#define FSA4480_SEL_AGND	BIT(0)
> +
> +#define FSA4480_ENABLE_AUTO_JACK_DETECT	BIT(0)
>  
>  struct fsa4480 {
>  	struct i2c_client *client;
> @@ -95,6 +104,9 @@ static int fsa4480_set(struct fsa4480 *fsa)
>  		default:
>  			return -EOPNOTSUPP;
>  		}
> +	} else if (fsa->mode == TYPEC_MODE_AUDIO) {
> +		/* Audio Accessory Mode, setup to auto Jack Detection */
> +		enable |= FSA4480_ENABLE_USB | FSA4480_ENABLE_AGND;
>  	} else
>  		return -EOPNOTSUPP;
>  
> @@ -110,6 +122,11 @@ static int fsa4480_set(struct fsa4480 *fsa)
>  	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, sel);
>  	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, enable);
>  
> +	/* Start AUDIO JACK DETECTION to setup MIC, AGND & Sense muxes */
> +	if (enable & FSA4480_ENABLE_AGND)
> +		regmap_write(fsa->regmap, FSA4480_FUNCTION_ENABLE,
> +			     FSA4480_ENABLE_AUTO_JACK_DETECT);
> +
>  	if (enable & FSA4480_ENABLE_SBU) {
>  		/* 15us to allow the SBU switch to turn on again */
>  		usleep_range(15, 1000);

thanks,

-- 
heikki
