Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05F7397A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVGwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D7171C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F29561772
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82197C433C0;
        Thu, 22 Jun 2023 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687416750;
        bh=Y1Co0eUEY/1VztSjV/SOSKw0BAZFidboJOL7RFsEII8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5YUQb9kpPtpyQndQqKrrS4y0MpSEWhL4A67w53SKPOVFrst5UzoEEZ9WsbMxgKq4
         9lbRQv0Da/irkSbwwGdphZMfr4TPz0HE0hMyyv15CPzinaQb9SD/OSPw4mGoG9gwe1
         jN0yyR7b5aNYnZ20MwdK42YwZGfEivgq8FDjt3VpbEuVfiTijHerZddqdle2ysMfl5
         ayRFoWFtVf7bZCf6NxALcL9pU+3gvGuyS0LGMNyXINFnG8bo1yuLgHB0hC6DzrEE2v
         dnosDx8VQVclAJiJzusdXITTmSmHZFUyqa4ks8V5bCkhAl1gte1L7XQEWOVRIK5pdz
         lJSlLZn/XKGVA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qCEBH-00073T-Mw; Thu, 22 Jun 2023 08:52:35 +0200
Date:   Thu, 22 Jun 2023 08:52:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: common: add default jack dapm pins
Message-ID: <ZJPvs05sb-aCr3CQ@hovoldconsulting.com>
References: <20230302120327.10823-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302120327.10823-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:03:27PM +0000, Srinivas Kandagatla wrote:
> If the soundcard does not specify the dapm pins, let the common
> code add these pins for jack.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Looks like this one was lost somewhere.

Any chance we can get this into 6.5 as it's needed for audio on the
Lenovo ThinkPad X13s?

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

>  sound/soc/qcom/common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index c1f24af17506..555feb845c41 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -8,6 +8,11 @@
>  #include "qdsp6/q6afe.h"
>  #include "common.h"
>  
> +static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> +};
> +
>  int qcom_snd_parse_of(struct snd_soc_card *card)
>  {
>  	struct device_node *np;
> @@ -169,6 +174,11 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>  		of_node_put(platform);
>  	}
>  
> +	if (!card->dapm_widgets) {
> +		card->dapm_widgets = qcom_jack_snd_widgets;
> +		card->num_dapm_widgets = ARRAY_SIZE(qcom_jack_snd_widgets);
> +	}
> +
>  	return 0;
>  err:
>  	of_node_put(cpu);
