Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17B654254
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiLVOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiLVOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:06:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45FBD68
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:06:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y25so2863311lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJ2W1GMQIGe78AmF/wCcmW+UzQQhAIEd1wyU9+4ZMjA=;
        b=DoI7xzgkqXPPZafcj5WA1ceIIWZsQC3IXCVcDdaAMUn9xDJnkKsueyQY9t/NlOfU09
         KkguJhiUYmJ1653IBjYmMj9KB6XeTDTcpSqKXknF7FXSL2Brk7QA0C/VAMjEuzbp9YJK
         1aRoLz/eEbaFZH4Kq7eSrIyLVAxeQ+rKBH6OvgHNfn3zUiHnOR34bNVKcAGx+qn0AP0Q
         NCd8a4555kwKvLhWpn753Di4Xvw90qnGPfGFpTLqnHTb812TO9YZryrH4cJ0ifSsyAfw
         7kQvCMXNwXnv4bqOM4JtRUf5sGv/b6ZHa6zN8fBQ409hx1lti1+Xgtx5I3fRAc6s0B5z
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ2W1GMQIGe78AmF/wCcmW+UzQQhAIEd1wyU9+4ZMjA=;
        b=zLv7hk/9pumGWqpYMd10rSUakrjy+dEk48oPNnY4HunpoV1wcQfHX91YK5Z6Uztoop
         qx28UcDy8NoiYJ7hrbY+mxh1+0MEo3ZuLyavMayE9bMAbAarfOxObP63LC1piTiAjVhv
         Y5TF9ftDXEFuZhbgMunBQo63ZLKb9tWMg/gPv/EUCHxUiib187V5o2JH8+2LcgfjOAPL
         uaJikYL+MWZctgLYeQSjtnIcoPxSehAAYL5gbUjCtlgO80tfXsYpYMSvYeOZtS6ZWVrL
         Lzlqtl4oQ5qogrLxdZxoSOF0Cwjg9Ie5MENNVJjI2R0aT4GlcVfaLPCPVJXwhhztJoNL
         g8sw==
X-Gm-Message-State: AFqh2ko+OmP96hpcw9faVKkYzKK8NC0GCu7DHYP/GQbBM7j8J46nREp7
        9P99deNzMvUemhQrANFOPI6eBw==
X-Google-Smtp-Source: AMrXdXu7vX4NO13sACbl4Kfhk9qfPtAku5VtWX1pi3/pYc60hUJAAcragf7iv5I+QHv1ddCTlr3RlQ==
X-Received: by 2002:a05:6512:2247:b0:4b5:7338:e2c7 with SMTP id i7-20020a056512224700b004b57338e2c7mr2041245lfu.53.1671718015252;
        Thu, 22 Dec 2022 06:06:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651c119300b0026ddaf38b0fsm53809ljo.96.2022.12.22.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:06:54 -0800 (PST)
Message-ID: <9dec25fa-7bce-a715-b63e-0a71b5743e3d@linaro.org>
Date:   Thu, 22 Dec 2022 15:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/2] adds corstone500 device tree
Content-Language: en-US
To:     Emekcan Aras <emekcan.aras@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222123244.147238-1-emekcan.aras@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222123244.147238-1-emekcan.aras@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 13:32, Emekcan Aras wrote:
> Adds device tree and correspondent binding for ARM Corstone500 reference 
> solution. 
> 
> Thanks for the comments, and sorry for the late reply. Most of the comments are
> addressed except one.
> 
> @Krzysztof Kozlowski: Thanks a lot for the comments. I've tried to fixed all of 
> them. Just have one question regarding having no dtsi or compatible platform.
> Corstone500 is a reference hardware design, however there is no silicon solution
> from it yet. And from device tree perspective, both FPGA and FVP (virtual 
> platform) implementations are identical(same addresses and same nodes, etc.).
> So we didn't want to create a seperate dtsi file. What would you recommend here
> ? Can you point me to a device tree from a similar platform?

Corstone1000 was accepted that way, so it is fine. I am just surprised
that if you are going to have silicons with it, there is no common
compatible and no shared DTSI.

What do you expect from customer? Re-implement and copy most of your DTS?

Best regards,
Krzysztof

