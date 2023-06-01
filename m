Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B33719340
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjFAGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:31:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D6E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:31:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso758117a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601091; x=1688193091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBMwt1BKmcTv1Q96e1R6bySbFByacC9PxCMzst7QHI0=;
        b=uFBp1Ykgm1ySYkYR6y3mqLku3EbkpzNMBnGY9pTm4LJam+ZLSUpENQOSGXk8b85MU6
         lKHUQjpPo18cb+yE18TAYtjQiZXvMeh0cjDgJ5z8C6yln6gIZ3uKwegwk6f16h7hARb8
         +BLNFY+VKDi5EYacYde0WDRacAQHv139+RjqGvUE07sWX/ELGjTrY+h3TZURnZmpWa7X
         S7R39vBZnPZUmtubJKR6co/amSPvJSH9Kr0T1uzuq4DNykQ6ATxEAf0Q84G8Buj9BpCg
         zjReXS0VK7aJMB2vzhK36Mc3zJz2YAFClW/Fe2LhNXtRWEYvZcYh22MYPTNI3NTVUNYP
         BW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601091; x=1688193091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBMwt1BKmcTv1Q96e1R6bySbFByacC9PxCMzst7QHI0=;
        b=UNl02Qj0MbOEjBH/uXfgRATssz999pdl3/z/RYjcAqPiUhYB2+UpfIKZ44oR/iVOTL
         bsbZkexkdqhoM2PcsAml+J6UpvTjxlPDz9fLS23ZIyOviIppT9qZy6hXxZc8pDnv3ynG
         /gu1wswU7ebMvIsDxuTHgmIPLWNwk0CKLSuPL0N+l6XiDfb9E5E1KIv/Hk6AyyYRWlIW
         QNChmqLzdcYGThem6craVoiLEMFKJ9mKlORASP+BNOwbl5kOdiMeLwJwkvjaKkg63tsW
         mff4NERd+S4SeMWiPoBJniB/UUJSo1t95EpzFYfwaLW4vtU7NSiNTXZSsdkEpVo9casQ
         G1WQ==
X-Gm-Message-State: AC+VfDyvhhRaJ8cc13feHuSomzexWPPy4VM12Aw4l2QUtS7vVdIIVLRg
        h5ZLgIr37KQmy2aIt6NpaAQD2w==
X-Google-Smtp-Source: ACHHUZ78B9G4/RBXOop0xSPO5CUd8uex2xfXTI1svDqDV63Ds3Eq1cZzCKRRclQhiblnPMBoRyTYnQ==
X-Received: by 2002:a17:907:d15:b0:971:2ead:e161 with SMTP id gn21-20020a1709070d1500b009712eade161mr7470546ejc.6.1685601091175;
        Wed, 31 May 2023 23:31:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id va15-20020a17090711cf00b0094ee99eeb01sm10051977ejb.150.2023.05.31.23.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:31:30 -0700 (PDT)
Message-ID: <3843deaf-2913-d850-0422-d411031947b4@linaro.org>
Date:   Thu, 1 Jun 2023 08:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] power: supply: rt9467: Make charger-enable control as
 logic level
To:     cy_huang@richtek.com, sre@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, chiaen_wu@richtek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685600676-25124-1-git-send-email-cy_huang@richtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1685600676-25124-1-git-send-email-cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 08:24, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The current coding make 'charger-enable-gpio' control as real hardware
> level. This conflicts with the default binding example. For driver
> behavior, no need to use real hardware level, just logic level is
> enough. This change can make this flexibility keep in dts gpio active
> level about this pin.
> 
> Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi,


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

