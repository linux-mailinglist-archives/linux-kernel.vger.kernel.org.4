Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AB6A9935
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCCOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCCOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:15:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF65D447
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:15:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so1688522wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677852926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dg6dj3Q6N5MYQn5C9fBk1Ggl0n/80gp3aauAx9F7jug=;
        b=yIXZrzjPqd7cp1fL8HoYWGw1R9f4Qv017OtTqnh+Sja/P5TGRZIGASc+OAty828lw8
         9HzgR8YxJWL/YTuk4RFCxoRYbzfmGs6SLuRkMwqP80FYgjG73SfJXz5n+ykYEI7asvTM
         gm/J2n/TJiQhN4+TCJPHJ1vMCFIH0mYshaRtOcCd6PGhuFlp1O2cuFwOiS4YeOEHTmBP
         rht0D+/ks38b+v6jsM9YLJ80XUBZ/lboVzjNBrp+n9dtUEVMUgeL66sCkor37AiJB0rR
         RrYEnq+VdFhDLoMqmJWuew014ttgl52BQrMNtPBZBd968SlvDl6tfx+UL2i2Y0B0DvCY
         JHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg6dj3Q6N5MYQn5C9fBk1Ggl0n/80gp3aauAx9F7jug=;
        b=WpC3dZL5hEN71Ii/xizo/SXXYVeg5beD9PTTdvU8LYXoSBiu+qJJkW9SWa60Hg1XUC
         zXZewfE62BLNMHnNNdUwlYAjlLD6bfW+5DFP5+ZTwzU7SYxb0FfGR/JZ76ST7Owx09JO
         gRmNhEjsdY7NwWOWii5KBerQtopBhu97VzVnaPiIXFpLYxmGkkK297Z/9R75zIu4f0em
         pX1RGhZo41IvMVbSmpPUyqgZwQq9h+RO+/x9Plu973l7eCqAJBVEmLV1nkqkcmZdO/SE
         IQgIaadziqgMgcRQ0fFA+UMloQHrzIvkZYKpEBMrsl6MXQZZFqD68OyvxXwGa2kl3TvW
         ITqQ==
X-Gm-Message-State: AO0yUKUZ0MAMunyiEuo3rVCO067CzFCvDsKkgLEPa5LYH5fRi/r+U2MK
        chEH4OOfNjbAKec3hAhVp/CMqg==
X-Google-Smtp-Source: AK7set+CvFYlMNwMVTmScXAECqtz9G/93stRCPw3xDHTesSY2cacrpOgFze7WDdOxXDQgcCRdFJi3w==
X-Received: by 2002:a05:600c:35d6:b0:3ea:ed4d:38eb with SMTP id r22-20020a05600c35d600b003eaed4d38ebmr1849295wmq.24.1677852925791;
        Fri, 03 Mar 2023 06:15:25 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003dc434b39c7sm12526269wmp.0.2023.03.03.06.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 06:15:25 -0800 (PST)
Message-ID: <73ea5ba2-18c8-abd8-3896-eb9656201f53@linaro.org>
Date:   Fri, 3 Mar 2023 14:15:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds
Content-Language: en-US
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230303125717.29196-1-quic_visr@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230303125717.29196-1-quic_visr@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2023 12:57, Ravulapati Vishnu Vardhan Rao wrote:
> @@ -1064,9 +1064,10 @@ static int tx_macro_hw_params(struct snd_pcm_substream *substream,
>   			      struct snd_soc_dai *dai)
>   {
>   	struct snd_soc_component *component = dai->component;
> -	u32 decimator, sample_rate;
> +	u32 sample_rate;
>   	int tx_fs_rate;
>   	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
> +	u8 decimator = 0;
Minor nit, any reason why decimator is intialized as part of this change.

--srini
