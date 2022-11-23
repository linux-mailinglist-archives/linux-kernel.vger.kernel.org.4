Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0763522D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiKWIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiKWIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:20:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631AF72C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:20:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id be13so27087079lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhFEQELa4VkTH3dXCJFPIV5f7OVafEghYhmDz8dxAsw=;
        b=ti0fy3zFjpws7aumeLZs4bfmrqyyUmZEkE6AkEd6AxWduEk4ZrhiKtm/h+Mz00+5Sn
         qB5P8Ocx1KzMRETnzTrdSiQTQJZpH2sxphGQDOwOkPp1gJ6qYSrpGJSR6FlVbaKz/+9G
         Mcoq4D22FZP5gmimwaBhuHIdIBqb8DK8vXcRb7jF/7aMVzYFxLEN0HBcNJNg41b7wRas
         Z2GLoJ1bjuI6R6bDGvpuxzrCa1GLfvXyeR37Jbm2emzMKbucVsLle+IfrtD1+Fh52CEb
         HhZWkAE1deU4LoH3gLaPmorX8A4i63J+dKQLq2kBZOW0Afp2vABNv3A3NS56viGSPuln
         9t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhFEQELa4VkTH3dXCJFPIV5f7OVafEghYhmDz8dxAsw=;
        b=jwC5k8uRDoiFshCqLUX0hxeoh+Ag5QjCAYNBMQQb9D8gxgYzXCe+WxBuzuO2pzJpS6
         lFnlKTAIwyy/qrdXv46+a90C9PEZWTt+6302fpWG3FQTvxV0HXFmLOZRKuPD0qWQ0evA
         t3H3K0ZEwI7wEVyjeGkzTXuSSqJxENq1YtATFunxwtOjcErGKXgMpj8khzgRSB3aVe22
         sbfCC1vii7qKxZFa/aHM2QsuuqVrJaYyL/SDUwvhplYn6JTAxzW74vVf28x6LSO6G6Ll
         mpWMqcEukh4R6rpg28zZhyuodjl7TJlu7QcIdyllEGYrn5Yn+Lcijv04iyHrVP/6iAAR
         ED3g==
X-Gm-Message-State: ANoB5pleiRvgyXhhjv3i5EWZhMXOrOiy9japQ74aAHz8LZiVbOQx7/dZ
        kSydeh2Xjlmy3I6kqWowLM5QAry27xONRj9B
X-Google-Smtp-Source: AA0mqf4CI8Ij3JSwtMSUrYc+lIf7HpUCJeQnclMNeRAu9pqSPkVrvgNxp3xG0b2MW5XqYTW6hP4Cnw==
X-Received: by 2002:a05:6512:689:b0:494:78cc:f153 with SMTP id t9-20020a056512068900b0049478ccf153mr8626000lfe.644.1669191636500;
        Wed, 23 Nov 2022 00:20:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j12-20020a05651231cc00b0048a934168c0sm2790896lfe.35.2022.11.23.00.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:20:36 -0800 (PST)
Message-ID: <4f4bdc95-16a2-df76-9787-df46a3b5e1eb@linaro.org>
Date:   Wed, 23 Nov 2022 09:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: (subset) [PATCH 06/20] arm64: dts: Update cache properties for
 exynos
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob.Herring@arm.com, linux-samsung-soc@vger.kernel.org
References: <20221031091945.531874-1-pierre.gondois@arm.com>
 <166742051292.139492.12539582422109367063.b4-ty@linaro.org>
 <7681ba8e-1036-7540-5eda-417ed204d35f@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7681ba8e-1036-7540-5eda-417ed204d35f@arm.com>
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

On 22/11/2022 17:52, Pierre Gondois wrote:
> Hello Krzysztof,
> 
> This patch and [1] were dropped after a bad patch management from my part.
> v1 and v2 are identical, but [2] lead to the 2 patches to be removed.
> Not willing to worsen the situation, I wanted to wait a bit before getting
> back to these 2 patches and let them be removed.
> Would it be possible to take back these 2 patches ?
> 
> Regards,
> Pierre
> 
> [1] https://lore.kernel.org/all/2d8b2d85-7bc6-026a-baf9-11a47171ddc5@linaro.org/
> [2] https://lore.kernel.org/all/bb36df3f-5aee-256a-4d64-eaeb9bff998e@arm.com/
> 

I was expecting a resend with:
1. Fixed subject.
2. Changelog.
3. Trimmed list.

Best regards,
Krzysztof

