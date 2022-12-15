Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9A64E11B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLOSkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLOSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:40:39 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D8286
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:40:36 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NY1JL5FKHz1S5Cy
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:40:34 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671129633; x=1671993634; bh=NBGPxf8
        Uk+YFqUwrijQq4lTC0II0fQREHSPsU0b1IsU=; b=VkTwnrAY3GBULtNEbB3xJGM
        hhQ+Jc4wdvdQl/6l9NU3mCsiq77xqWmGDpLfIr0AP1QeTzNOvfX9hLRAC1nB91Ps
        BJ6p1SZlMLGpjR3RaHqB3ObOpN54Z6j/XIG0BHR0rIuPYCs3xLJXi7nxCQMfjwBr
        aPs08l+d111Q2+ByyVlV7th1TUIZLU05/W9HunXzcPifbGt/CJeEeqv2fF4wKDwe
        CvFok5Me1RkP/JVOlcwEyAwmSpa0kNpH09k+sLkqU5fRcLSRzJdO/tvcDAmjMwLq
        Y5FLLPWpnzKsZUM6i0eRIja/UOi1aA2DRxHARLcLKSuiOBzrrBJn8+Fa7nI5HeA=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qmoXi89-86B0 for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 13:40:33 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NY1JB5cHkz1S4yj;
        Thu, 15 Dec 2022 13:40:26 -0500 (EST)
Message-ID: <c44d30a1-9ca3-e7c3-aeb5-7d058033141d@mint.lgbt>
Date:   Thu, 15 Dec 2022 15:40:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215182412.386064-1-they@mint.lgbt>
 <20221215182412.386064-4-they@mint.lgbt>
 <7c30fc89-8801-7801-de5c-c05fde423bf8@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <7c30fc89-8801-7801-de5c-c05fde423bf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/12/2022 15:34, Konrad Dybcio wrote:
> On 15.12.2022 19:24, Lux Aliaga wrote:
>> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
>> summary on what's working.
>>
>> - dmesg output to bootloader preconfigured display
>> - USB
>> - UFS
>> - SMD RPM regulators
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
> You don't seem to have addressed the review comments from
> v2 on this patch.
>
> Konrad
Pardon me, but most of the review comments were addressed. I only missed 
moving the qcom,msm-id and qcom,board-id properties below chassis-type, 
but the rest should be addressed as intended.

-- 
Lux Aliaga
https://nixgoat.me/

