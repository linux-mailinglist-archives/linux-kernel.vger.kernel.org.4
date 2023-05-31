Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AD7179F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjEaIYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjEaIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:24:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39093BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:24:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so6811859a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521464; x=1688113464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/tPM97+ixfB8TGDp/bQzzt7wmHeXbjLj3vGjIL85M=;
        b=HEFIw5btRQu1bchZauFcEAzopwCzK90tcqrlscyQ7VWmzwdXLp3QxgH3h4BGpTJcbv
         bL8CYMBqgB8VYU8xL3HoKldk2CP43VguDhP38bOoLGwIAj8oWPxIBbRe19JhHIZ/iLEU
         dGwQcyj/+peSM8qdbO0sz9WPQAS15NtuRI3WDb4nD7ndsawDl23Mamo+DmfK35bIXP+X
         6KCiMilZQFqjied0ZUcVJmTm+c7BM0s1xmjqOgWSgKAv2HQj7+ygV+9NfoYy/11dT7Do
         R8OdAEhmz48pxkUVD4vJ7AN6FlptF6j9t85lYHoEHT8QljomEhqxLTLDqiCNRLtRmkMt
         kiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521464; x=1688113464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/tPM97+ixfB8TGDp/bQzzt7wmHeXbjLj3vGjIL85M=;
        b=MBZOz1suoK4H3fXY4cpaBZfpatDAj+GPZ2WEA+D0RpPYamgzJBabn8PxTEtNUeVmKo
         v+h6OdnuZ27R85+fPIdWyMEC6Gc+ucmaQvYm02YX90NP9103qiGCqKNMoGkkFsDAXCU3
         MyXa41+pQQoa6Wce0kgqG1FwJaA35Yfz0gH0BXgAlhrnpkwwcZcDSFyYqY6WnXtaaZCp
         B+sLYP79qzvFNA6uUvdCpR0amY9UR/+CMDDZhn1p+ATh135vwJaaQmBnywryb3iWrbzA
         nyFO5Evv4aWKz4C85eJMY/jULXLxEnL6VXnPpKo3lapUS8WRMo7EVIuFf2PZ27P/pjrT
         ngRQ==
X-Gm-Message-State: AC+VfDyvbig0Ynh+GPQqC/ldCnfKEB8PRP49uCmxaio48L4haHsxYlEV
        sIrfouqZoIl3+17bE65/bVzTlmReLsEdKExiLJCVdw==
X-Google-Smtp-Source: ACHHUZ4wiQr0aDOh1HHknnfz6rabMIF5zmnzY6T/SaEwLpozbf0hBSiy/0VRb0dgYN+ZvDTr2qGhyg==
X-Received: by 2002:a17:907:6e0d:b0:94e:afa6:299f with SMTP id sd13-20020a1709076e0d00b0094eafa6299fmr4623253ejc.22.1685521464725;
        Wed, 31 May 2023 01:24:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906088200b0096f7ae359a5sm8605987eje.30.2023.05.31.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:24:24 -0700 (PDT)
Message-ID: <38a93add-9c78-de13-4301-8929bb712525@linaro.org>
Date:   Wed, 31 May 2023 10:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/15] scsi: ufs: dt-bindings: Add SC8180x binding
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-5-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-5-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> Document the UFS HC for SC8180x SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Nothing improved. :(

Best regards,
Krzysztof

