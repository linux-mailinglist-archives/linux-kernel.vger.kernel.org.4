Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B16155FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKAXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKAXOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:14:39 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 833646254;
        Tue,  1 Nov 2022 16:14:37 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Nov 2022 08:14:36 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id BACE72059027;
        Wed,  2 Nov 2022 08:14:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 2 Nov 2022 08:14:36 +0900
Received: from [10.212.158.13] (unknown [10.212.158.13])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DBFFBB62A4;
        Wed,  2 Nov 2022 08:14:35 +0900 (JST)
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
 <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
 <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <07155116-2027-2916-5a39-e4dff8298b27@socionext.com>
Date:   Wed, 2 Nov 2022 08:14:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/02 4:31, Rob Herring wrote:
> On Tue, Nov 1, 2022 at 4:10 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> On 2022/10/29 4:38, Rob Herring wrote:
>>> On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
>>>> The word "glue" is ambiguous for the controller node name. Should put
>>>> "sata-controller" instead of "ahci-glue" on the controller node.
>>>> And rename a phy node to "sata-phy".
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>    .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml  | 4
>>>> ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>> index a3cd45acea28..89b8b133777a 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
>>> yaml
>>>> +++
>>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
>>> yaml
>>>> @@ -117,14 +117,14 @@ additionalProperties: false
>>>>
>>>>    examples:
>>>>      - |
>>>> -    ahci-glue@65700000 {
>>>> +    sata-controller@65700000 {
>>>
>>> But is this really the SATA controller aka AHCI?
>>>
>>> In cases where we don't have a standardized name, I don't think it makes
>>> sense changing node names from one non-standard name to another.
>>
>> I see. This can't be named generic, so this change will drop.
>> And "sata-phy" in the same way.
> 
> I think sata-phy is fine. It may not be added, but usb3-phy or
> pcie-phy are common already.
I understand. But of cource "phy" is also common, so I defer the change
from "phy" to "sata-phy".

Thank you,

---
Best Regards
Kunihiko Hayashi
