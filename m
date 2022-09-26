Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E75E9B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiIZH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiIZH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:57:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4E3B974
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:51:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so9473359lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jvYvVWLSf4e8Yu944Qnf0DCzJLFbXHx/b6AjfcFyxfg=;
        b=Kl/ik9OP6N486uc3ipCE3PqQ2EnzmmRRIVsetjtVaSwuqxB3KcKxDYZsaVrrG7tocC
         p+YmpNpCtt5hO0WTBfYSh1rZnOfK6argETuht+HyCDwGBgNWRaUSsG4l6hKH65HeDC5a
         nITqMcklR5qVn/doCUCknHlKwh33wJqe5GXSC8FWxRVvRSEp2+oNSIAnGT1rlBEzRk/4
         UdFj0X6Q6yMcqqXYm33FWhVlyaVURGpQATLNZqvHxPl2Avi0GkFfnhQuw5zmJ+jdR0bT
         exzHy5eigO7oKeJ9ZdAVaOkVRuoyvDU6hlkJB6o1c5ivwpdMSO6USsUm7eT4om/W9VL+
         FGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jvYvVWLSf4e8Yu944Qnf0DCzJLFbXHx/b6AjfcFyxfg=;
        b=QlCJ9qGKSC6wJJaksGSugGVoXTeGkYo/+QWc7t3/C7mLNibWM6KoQTt2gNIv1bKm3b
         TvLUgZiL6JfaLCvyzlngMF9S4epz4DN2phkoLNdzYP1Jlv3duBdIPw54lx269PkbfZPI
         ZZ26iHrJ2HGLVv2nnS4SnaZt+SI0Px/O0fgzcZZUZPhtmjO7PAn6cP74s9sOCYQMvPtX
         nHmbSTE7pxDgMloggcOZ5fnDOXWx+BQEdV/ZzzPmgGsQ2MhLjRPE6n1MW8BiFT2SgnDZ
         YHVZ2zDUHBnz2I/mrJwh8KjCe6hewJvSrvQe18+otG9pHMc1kWXZ1j5Nvu8L18zq1JyB
         vyfw==
X-Gm-Message-State: ACrzQf2JkcqNbj1+ghiA6qLg5m6VIHZ2G6cOgLj2UngtIz0ARW3wi7li
        pzoh45yk5x7ttg2d3Tnc1c9u5Q==
X-Google-Smtp-Source: AMsMyM72gQh9BlSdHlb/fUZ1pBNnUC1vPovZqUS1FS9beAE/yju5eVqdX25l69BydVEZuU/PbcPKwA==
X-Received: by 2002:a05:6512:1188:b0:499:6fbf:d751 with SMTP id g8-20020a056512118800b004996fbfd751mr8550642lfr.51.1664178698030;
        Mon, 26 Sep 2022 00:51:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i30-20020a198c5e000000b00485caa0f5dfsm2461378lfj.44.2022.09.26.00.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 00:51:37 -0700 (PDT)
Message-ID: <aca7f1c2-488e-28b7-2ea5-ead507aa535c@linaro.org>
Date:   Mon, 26 Sep 2022 09:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] ASoC: codecs: wcd934x: Fix Kconfig dependency
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        james.schulman@cirrus.com, cy_huang@richtek.com,
        flatmax@flatmax.com, pierre-louis.bossart@linux.intel.com,
        lukas.bulwahn@gmail.com, srinivas.kandagatla@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220926074042.13297-1-renzhijie2@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926074042.13297-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 09:40, Ren Zhijie wrote:
> If CONFIG_REGMAP_SLIMBUS is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
> will be failed, like this:
> 
> sound/soc/codecs/wcd934x.o: In function `wcd934x_codec_probe':
> wcd934x.c:(.text+0x3310): undefined reference to `__regmap_init_slimbus'
> make: *** [vmlinux] Error 1
> 
> Add select REGMAP_SLIMBUS to config SND_SOC_WCD934X.
> 
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

