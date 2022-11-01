Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A461465B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKAJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:10:52 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A42B60F9;
        Tue,  1 Nov 2022 02:10:51 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Nov 2022 18:10:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9ED3820584CE;
        Tue,  1 Nov 2022 18:10:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 1 Nov 2022 18:10:50 +0900
Received: from [10.212.156.238] (unknown [10.212.156.238])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B561CB62A4;
        Tue,  1 Nov 2022 18:10:49 +0900 (JST)
Subject: Re: [PATCH 2/2] dt-bindings: phy: Fix UniPhier SATA controller node
 names in example
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-3-hayashi.kunihiko@socionext.com>
 <20221028193859.GA2188803-robh@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
Date:   Tue, 1 Nov 2022 18:10:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20221028193859.GA2188803-robh@kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/10/29 4:38, Rob Herring wrote:
> On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
>> The word "glue" is ambiguous for the controller node name. Should put
>> "sata-controller" instead of "ahci-glue" on the controller node.
>> And rename a phy node to "sata-phy".
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml  | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> index a3cd45acea28..89b8b133777a 100644
>> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> yaml
>> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> yaml
>> @@ -117,14 +117,14 @@ additionalProperties: false
>>   
>>   examples:
>>     - |
>> -    ahci-glue@65700000 {
>> +    sata-controller@65700000 {
> 
> But is this really the SATA controller aka AHCI?
> 
> In cases where we don't have a standardized name, I don't think it makes
> sense changing node names from one non-standard name to another.

I see. This can't be named generic, so this change will drop.
And "sata-phy" in the same way.

Thank you,

---
Best Regards
Kunihiko Hayashi
