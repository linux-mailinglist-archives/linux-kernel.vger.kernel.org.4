Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694772BE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjFLKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbjFLKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:01:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BBD30D6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:44:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso6259203a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563063; x=1689155063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGS8bUQt/Q6cTb/mgXADh7fF0bhjSopnevV2SXx3L4U=;
        b=YSSRXRoo0P1z3yM2ZR4wZWKoP3Sl8rZWfiAlQEs4iWFCwZMeuSKRCodcraff+Pq4n2
         M0ea6UuE2ErAiu0E+2CjqAGfQBQ4frqt4GoAtoJmmz6FJctoEP08nvtLfcw3NOZH6pXz
         94zqQf3zZGxIJbl+g9NG1MxJgQs22OEoJpdFCafaYXdKG8UJUrbjBLs1jntFngaAbf3S
         X7Xk1ajH+t3Z9W3Gi+5pWgbVVMD/xS88qAqGHiLqPd7O7AqphbeNl+SftFUcQvNxx7vP
         GMoKyKgzponxO7CqVvQF9aemJ+fQMqpHxclg0ROSUvlzw9P6vq59btqQ+YzPRC2pfJVF
         6u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563063; x=1689155063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGS8bUQt/Q6cTb/mgXADh7fF0bhjSopnevV2SXx3L4U=;
        b=YqvaM9a27xLlxAjQEfy66DRjkeZ1VbehzVqQQ7Nzv5LNga/h9reaBTHkdhT7/cZ05R
         0sMceK/2kA1AggjBYTVeZJzKTUibbfMjYNV/RsjZC9QBPsepwvrwDZbo56A/h0sIpOQi
         Ca7msLB3F/Dk3z0vTWqEu11ZKYoHiHNdg46IDYe7+7AGArSpDt9pdwDsQ3GwKxb3TMHF
         ANwfao7HHWW+7Pt8hIrKXR5Glczuain2EBjX6TviE9uuoNBlCjG17ZrNX5dL24yLnv3K
         9tNNA+NOzrgosirT4lOsHE+Sa0UlUAkx9gxVBeLjI3HKen14i5/GwxRBLVZqIKU2Bf9r
         3dcA==
X-Gm-Message-State: AC+VfDxBaiYj6hQIi4/yQzdy8Lnt+ihiRg6Ch463kVXbZsxniKmSXoUp
        IWbBohaV6O4vkiDDNo95w12ibg==
X-Google-Smtp-Source: ACHHUZ6wyE6QqIeF2j0gJURaZNl3T0vHhDGy/+70UPdIokB7RGA5vADzdJcAIGv55ZlvmTXnTz5xFA==
X-Received: by 2002:a17:907:7e8c:b0:94a:5d5c:fe6f with SMTP id qb12-20020a1709077e8c00b0094a5d5cfe6fmr8600237ejc.47.1686563063029;
        Mon, 12 Jun 2023 02:44:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bi9-20020a170906a24900b009745417ca38sm4951012ejb.21.2023.06.12.02.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:44:22 -0700 (PDT)
Message-ID: <ab8dfd0f-fa49-6493-d79d-c35f632373f3@linaro.org>
Date:   Mon, 12 Jun 2023 11:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: defconfig: Enable HSR by default
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230612094340.13865-1-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612094340.13865-1-r-gunasekaran@ti.com>
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

On 12/06/2023 11:43, Ravi Gunasekaran wrote:
> Enable HSR feature in kernel build.

Why? Commit msg should answer to this question.

Best regards,
Krzysztof

