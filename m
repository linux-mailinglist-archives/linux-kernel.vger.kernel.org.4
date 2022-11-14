Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C50627A58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiKNKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiKNKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:21:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4FD1A078
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:21:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k19so12532335lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EECihYF9c88LJIQKWGKZKOyFDgZGNXgYE2EMHMrpgGc=;
        b=l2iLI+xhGaJ79qTwJr2KzxikJ+QQbCqGuLf2cII2hL51fYEH7kB+GYspHgN4hrIQIC
         gAwMVJ+Dt8tSuNWevmPoST3KvaECqePkwCvKBrQR/G37K/ViMRe2l0ynHt/u1Ysf9Hxv
         Ea16PX28n/gOC6SU9YAxcHsyRfCR1HE2OmY/URcsWa9Ll5tEKjg4WWUS1z+eRKf/USt1
         /YFnCSJySjL/pcOlD6WFTVnhfnfZenv7lJCMI//OjJoycqE2dnaWNTMvyyy/gYUDS9wD
         ImOGDi+LIYLs+dTIGqdzHbes2ydl5GAoQzcj/9bpsCjnl55bmj4qDFq7hUILnhLda8GP
         AHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EECihYF9c88LJIQKWGKZKOyFDgZGNXgYE2EMHMrpgGc=;
        b=xm8ahTb2pWA/LwmPw+QguGzMm/5EKjoMRJmHwSTb0N7Z6OACYVowCIQdm2eVSiWptp
         nOT+Nts1/dxOOsDTL9aOD8f5nSEdQTpmnmP6PF7u8kwPj4Mfvl5/UdW7n/quklgYNAk9
         fuYS5S12tUSXkNK5xLGG2Kezh2m/7oXZ1SHwZ3NKeygxBE0IVoIiYW+DTkNdQqDmupZ5
         A8oNn6QHzj06EKTVXskXO3K8KVbDSPzsTNypz9b+5BIAKysOZfyX2BrCIgpjOVTpd1Yx
         aPKZp3JH0bc5q3enMUsry26/9Iwg5RiB2jJwnDI/yKGGpbj+bp9KrptzkHh5hZAaNtW1
         K9SQ==
X-Gm-Message-State: ANoB5pktn4yelajckOrG/xTCmm4CTPNz5sllxFgPwyrVT90xWQ8bESkS
        rlajgCBMrSc/EknO2z2Xx3X2uQ==
X-Google-Smtp-Source: AA0mqf5EjdvDCOi7qOUPGfn3HlohNe9gT78Bfzd2K+VM/Wk3LnYToHrPsC+o+wcmAPZ4cnYfqPZIeQ==
X-Received: by 2002:a2e:9a85:0:b0:277:64ad:383d with SMTP id p5-20020a2e9a85000000b0027764ad383dmr3632499lji.67.1668421303305;
        Mon, 14 Nov 2022 02:21:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d19-20020a194f13000000b004a044928923sm1767610lfb.293.2022.11.14.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:21:42 -0800 (PST)
Message-ID: <03b94d20-05a6-71fb-61e4-00889f5aa64d@linaro.org>
Date:   Mon, 14 Nov 2022 11:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] mfd: max14577: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-6-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112151835.39059-6-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 16:18, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/max14577.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Mention this is a resend or provide a changelog for v2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

