Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF174E69B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGKFzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:55:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262501AC;
        Mon, 10 Jul 2023 22:55:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36B5tMl2041466;
        Tue, 11 Jul 2023 00:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689054922;
        bh=yykvZgnCoI6gaQWerwj2eoEr1FlZ4CXV/wzlrynEAUE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=up0SHfiWxC95aybfKVAspgZmAog3rl042L+UD4fS8WE2k/V4Xd/e3j07Ds57fdY8Z
         bMGWrAgw0OrH746pdE/MfJMWW0QUO8XQCRpAQqLrypFLADJTAaqfdR70lDE2QLrr3E
         LMqfhtnitfhzwf04QjSh14mJpcS6j1eWGwfndbxw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36B5tM6u091944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 00:55:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 00:55:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 00:55:22 -0500
Received: from [10.24.68.113] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36B5tImQ058676;
        Tue, 11 Jul 2023 00:55:19 -0500
Message-ID: <ecbb6d34-e024-f6c6-5921-ba7bc6fe2e5e@ti.com>
Date:   Tue, 11 Jul 2023 11:25:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: ti-serdes-mux: Add defines for SERDES4 in
 J784S4 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <peda@axentia.se>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
References: <20230710102712.155195-1-j-choudhary@ti.com>
 <d136d58d-9582-3833-861f-086b64c1ad36@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <d136d58d-9582-3833-861f-086b64c1ad36@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 10/07/23 17:11, Krzysztof Kozlowski wrote:
> On 10/07/2023 12:27, Jayesh Choudhary wrote:
>> SERDES4 has 4 lanes. Add lane definitions for it.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   include/dt-bindings/mux/ti-serdes.h | 20 ++++++++++++++++++++
> 
> Where are the users of this binding constants? IOW, why do you need to
> add these?
> 
> I don't see users of existing constants either...
> 

These constants are propagated in the idle-state property for the
mux-controller node (named serdes_ln_ctrl) usually in the final
board dts files and occasionally in the main dtsi files for TI SoCs.

-Jayesh
