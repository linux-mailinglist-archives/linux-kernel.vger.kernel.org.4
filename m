Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B095F1385
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiI3UUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI3UT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:19:58 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B31437410
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:55 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 88B941FFC2;
        Fri, 30 Sep 2022 22:19:53 +0200 (CEST)
Message-ID: <3f6ce239-a412-4839-84dd-213a6453388a@somainline.org>
Date:   Fri, 30 Sep 2022 22:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
 <2b1a536f-fd84-831a-8b0a-9c0cce5e6421@somainline.org>
 <1dfd2858-cc30-5cc0-0b2a-209a8bf8bace@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <1dfd2858-cc30-5cc0-0b2a-209a8bf8bace@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.2022 22:19, Krzysztof Kozlowski wrote:
> On 30/09/2022 22:13, Konrad Dybcio wrote:
>>
>>
>> On 30.09.2022 22:05, Krzysztof Kozlowski wrote:
>>> DT schema expects TLMM pin configuration nodes to be named with
>>> '-state' suffix and their optional children with '-pins' suffix.
>>>
>>> The sdm854.dtsi file defined several pin configuration nodes which are
>> 845
>>
>>> customized by the boards.  Therefore keep a additional "default-pins"
>>> node inside so the boards can add more of configuration nodes.  Such
>>> additional configuration nodes always need 'function' property now
>>> (required by DT schema).
>> Would it not make more sense to drop this and keep the properties in the
>> root node while at it?
>>
>> Konrad
> 
> Not possible, because the boards set different bias/config for the pins:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=v6.0-rc7#n2988
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845-mtp.dts?h=v6.0-rc7#n729
> 
Ok, I see now.

Konrad
> Best regards,
> Krzysztof
> 
