Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52E6DA920
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDGGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDGGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18297ED3;
        Thu,  6 Apr 2023 23:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D565648F0;
        Fri,  7 Apr 2023 06:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB03C433D2;
        Fri,  7 Apr 2023 06:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680850451;
        bh=MofKp5WWpnswSysN+v8UPuWgIO1ysl1ijKql/7omvoA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SShh79BJnamvPW8E1TlfuiK9ylW1J5p/ZYfRAze3mIX9G3YlrbL5uGvcyrArRrYh9
         4bNl5mkNJsu5e4EsvOM7TMSKyQIrRefIfRHeBl0gGR4FA8Qd9R2VFlrXbGAdUEotw9
         IfsbuhssHj7hkpS8prRg6N0QKsC11OXcoDjm6hsqGB85miAcY7HABaR2Aw59XlS88P
         Dp4Fn4nVSWrlqy22dy/yuGl8g2l3ve5ciKROHTOqHre/seYD5BKGpwewa7dtWblbqL
         1W0KFn7QEixcKLHbfH+1YDmdgHCW/ADEFqsfMgkRPA/gPHT+y4czi7W8sXCUugbYQ+
         90MsEKLZZRQhA==
Message-ID: <06a17138-cccc-1283-d235-fa54275c1651@kernel.org>
Date:   Fri, 7 Apr 2023 08:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230315100421.133428-1-changhuang.liang@starfivetech.com>
 <20230315100421.133428-2-changhuang.liang@starfivetech.com>
 <20230320151437.GA1709620-robh@kernel.org>
 <fa13e903-809d-064f-baff-c7e7474b52da@starfivetech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fa13e903-809d-064f-baff-c7e7474b52da@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 08:51, Changhuang Liang wrote:
>>> +
>>> +  resets:
>>> +    items:
>>> +      - description: DPHY_HW reset
>>> +      - description: DPHY_B09_ALWAYS_ON reset
>>> +
>>> +  starfive,aon-syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      - items:
>>> +          - description: phandle of AON SYSCON
>>> +          - description: register offset
>>> +    description: The power of dphy rx is configured by AON SYSCON
>>> +      in this property.
>>
>> Sounds like AON SYSCON should be a power-domains provider. Custom 
>> phandle links are for things which don't fit standard bindings.
>>
> 
> Hi, Rob,
> 
> On visionfive2 jh7110 SoC, this AON SYSCON is the Secondary power switch to the DPHY Rx.
> When we open the pmic switch, we also need to configure the AON SYSCON register to turn 
> on the switch, it is used to link the pmic and the DPHY Rx, So I think it just use syscon
> framework is enought. What about your comments.

Which sounds exactly like power domain provider...

Best regards,
Krzysztof

