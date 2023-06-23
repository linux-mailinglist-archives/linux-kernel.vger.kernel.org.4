Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3373BF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjFWUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFWUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:18:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6829135;
        Fri, 23 Jun 2023 13:18:36 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35NKITAL050172;
        Fri, 23 Jun 2023 15:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687551509;
        bh=f7q6qzALH79mV4hDBDS7tVfeINhU4GHFP+Le2xR2a9Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nh7AcErGC4RlFcGD1QYM6BUbZjYlkcokkrVWePZ9lhrvf+ZTWJW17GngHP2PlcwMs
         h1C6hIn3M39nuC3MZr9guXo6a91q9QKkmr2zy8de2JxbLLLCXHgf9AizKaXfrOUx8l
         CudxsCOK4zWVr0zyIQi/JkB1HOynTAPiWmjsD+qE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35NKITBX129411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Jun 2023 15:18:29 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Jun 2023 15:18:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Jun 2023 15:18:29 -0500
Received: from [10.250.37.10] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35NKISns008310;
        Fri, 23 Jun 2023 15:18:28 -0500
Message-ID: <602856f1-3c94-554d-58ac-461d10110538@ti.com>
Date:   Fri, 23 Jun 2023 15:18:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon
 compatible
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230516184626.154892-1-afd@ti.com>
 <20230516184626.154892-2-afd@ti.com>
 <20230517075310.iduc2eisw7a5bm45@krzk-bin>
 <CAL_JsqL7EPkBAigGJ8iR4t532R82N0fFFmb4BVUw84xpb0545w@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAL_JsqL7EPkBAigGJ8iR4t532R82N0fFFmb4BVUw84xpb0545w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 2:59 PM, Rob Herring wrote:
> On Wed, May 17, 2023 at 1:53 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On Tue, 16 May 2023 13:46:26 -0500, Andrew Davis wrote:
>>> This node's register space is not accessed by any other node, which
>>> is the traditional use for the "syscon" hint. It looks to have been
>>> added here to make use of a Linux kernel helper syscon_node_to_regmap().
>>> The Linux driver now uses a more appropriate helper that does not
>>> require the hint, so let's remove it from the binding.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: scm-conf@100000: clock-controller@4140:compatible: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
>>          From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: clock-controller@4140: compatible: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
>>          From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> 
> Now failing in linux-next.
> 

Sent fix: https://lore.kernel.org/lkml/20230623201519.194269-1-afd@ti.com/T/#u

Andrew
