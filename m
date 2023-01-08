Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC70D661A69
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjAHWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAHWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:20:31 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69B11144
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:20:29 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4Nqs2z3qYcz1S4tq
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:27 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:subject:from
        :content-language:references:to:user-agent:mime-version:date
        :message-id; s=dkim; t=1673216425; x=1674080426; bh=StAJiwaFSWK0
        oRu5sb22M02ztG8ghVtA9FhCHEt3NzQ=; b=3Hw/yrdc5UmlNdl0k6ReikaSaev8
        lLFs6bUic/QD/B4y8hK8ToEZudDtaOoTrDr3wHpijwBkqe655GRxtP3bqEVYGhoE
        3iTIvD87GSqyiOE434benuhsbJhd0+ISyCK0ocmQsgqYuZggWMAP4g4GzkHKP4n6
        OIHicse+Mr3dprGnoKs5d4fseP1DAWfygXcnvLGwVW9vw/bfInpwMy8J5ykqS1my
        AWcP5DVvijSZnwxg8uXmOlDLILXD78TKoDUrrcmb7bYAJ4njQ9sfTbkQMOFR7G2E
        zYBgrPNFyVOpS//mNmZOF8t7S8+mKQIHYSB+ZZhXVzVr9iqRI8bqSlg/Dw==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r8Uqos8P04jR for <linux-kernel@vger.kernel.org>;
        Sun,  8 Jan 2023 17:20:25 -0500 (EST)
Received: from [192.168.1.96] (unknown [186.105.5.197])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4Nqs2r1cGpz1S50l;
        Sun,  8 Jan 2023 17:20:19 -0500 (EST)
Message-ID: <71daa662-51c2-f4b8-d716-08c3c4480911@mint.lgbt>
Date:   Sun, 8 Jan 2023 19:20:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, marijn.suijten@somainline.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-3-they@mint.lgbt>
 <167320890262.220493.12109738826337104873.robh@kernel.org>
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH v5 2/6] dt-bindings: phy: Add QMP UFS PHY compatible for
 SM6125
In-Reply-To: <167320890262.220493.12109738826337104873.robh@kernel.org>
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

On 08/01/2023 17:15, Rob Herring wrote:

> On Sat, 31 Dec 2022 19:24:16 -0300, Lux Aliaga wrote:
>> Document the QMP UFS PHY compatible for SM6125.
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Acked-by: Rob Herring <robh@kernel.org>
Hi! You seem to have acked this patch from a previous revision of the 
patchset. However, it was left unchanged so if I need to submit a new 
revision I'll include this signature. You can the newer revision here: 
https://lore.kernel.org/linux-devicetree/20230108195336.388349-1-they@mint.lgbt/T/#m9862de18e18e1c0f4abf9db0bcc7c4d2f7f1a948

-- 
Lux Aliaga
https://nixgoat.me/

