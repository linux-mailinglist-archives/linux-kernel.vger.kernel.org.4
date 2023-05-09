Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB26FD153
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjEIVY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjEIVYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:24:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7887AB8;
        Tue,  9 May 2023 14:21:56 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-61b5a653df7so58760706d6.0;
        Tue, 09 May 2023 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667257; x=1686259257;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZGWO1kPdJmcL/B4Vp8uEGUKDR4PKEQffccvM6HpXCU=;
        b=JZvw+/ajuk00Lo7e1gHcEQ2u6nuePYCFq0krtr5dkEnHq8NpnCj8kYR5Bg58XqoJJT
         WBSAh8nlAieGuQ9Ym70mJ239o8MRbIpUVdtK3YR/MXaQBnF9HAoxZDrWXWppvmXi+u5e
         Pihqa4xbbiJD9TG7yd5HRd0rJT1TVF4CoG4DeVFnCG7o8K5wfg8RcAAmke9DguXEoz/Y
         JgN+uyAcBQ4njsvtCqigI+VY8LcIc28stZDdJmJ9De325yCVAmTuxY6w67Ku9h6QhNEp
         /WZcU+FMQThVOwGBxzQASXrkx5L8KZTXYHAmW+knOvNYSk5POGTyUiEdpoGN36l6RdOw
         IrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667257; x=1686259257;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZGWO1kPdJmcL/B4Vp8uEGUKDR4PKEQffccvM6HpXCU=;
        b=CAvZdufUBcfiJB1iBxMm4O89pH8wqS9wen9+XnVjAGMrrKTdKrOeDTq8mKF61gyJVE
         GQppjHDu/wgdeKe1pksAMC/Bq3hCCSj6rsHMd7IKjW92uk/8UEKXtRQ//mIunqgyozDN
         AkJM2MfwOS8WicEuZuE7fxpm75C8ZbYmI+bz7gRhReRV9/khTNxt3WCdTkgRywMlRTXA
         16XshebeU/1BF1KbVipJbzIzEKLkUbDINQD+0PfuhQZ3/91jiBVeh181oGCXpkgzG+oI
         1qwolsrAiKlyxjCwpPurjdOY9i0PbjpzKd9swWivLnT2SSCCgsGInzGQMczAlHT/UAAw
         N1lQ==
X-Gm-Message-State: AC+VfDxM5WZUMrCalbdSmquGg0uojGaWqvZA61WbgFv1QVPQqk8CVyrO
        P1SaozDT0BSGhYQ38Kc+u8gqfla3Ph0=
X-Google-Smtp-Source: ACHHUZ5mP3MWlk3DaY+oHOzqqtGvflFGiLKU+Ad6aByDnCT3TO5o4bRFt6+T9eRvI/gKIiaDpji62g==
X-Received: by 2002:a05:6214:260c:b0:614:da60:f45d with SMTP id gu12-20020a056214260c00b00614da60f45dmr25975131qvb.30.1683667256985;
        Tue, 09 May 2023 14:20:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b3-20020a0cf043000000b00620b99149d9sm1042949qvl.91.2023.05.09.14.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 14:20:56 -0700 (PDT)
Message-ID: <c90f4cf0-0571-3b5d-8ea9-aa8f0ecaadec@gmail.com>
Date:   Tue, 9 May 2023 14:20:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
 <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
 <20230509211953.1796591-1-f.fainelli@gmail.com>
In-Reply-To: <20230509211953.1796591-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 14:19, Florian Fainelli wrote:
> On Mon, 8 May 2023 14:46:03 +0200, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>> Convert Broadcom Kona family SDHCI controller bindings to DT schema.
>>
>> Changes during conversion:
>>    - also mark reg and interrupts as required
>>    - drop deprecated compatible (it's been deprecated for ~10 years)
>>
>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!

Sorry, that's not the one I intended to apply, dropped.
-- 
Florian

