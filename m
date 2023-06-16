Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D059732F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbjFPLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjFPLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:07:20 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2F4228;
        Fri, 16 Jun 2023 04:03:57 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.6.111])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qA6pq-009MRH-P8; Fri, 16 Jun 2023 11:37:43 +0100
Message-ID: <8525e073-90cd-dde7-5d4b-e4309cd3a657@codethink.co.uk>
Date:   Fri, 16 Jun 2023 11:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-GB
To:     Conor Dooley <conor.dooley@microchip.com>,
        Eric Lin <eric.lin@sifive.com>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <20230616-renovate-country-12b9873b4494@wendy>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230616-renovate-country-12b9873b4494@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 11:10, Conor Dooley wrote:
> Hey Eric,
> 
> On Fri, Jun 16, 2023 at 02:32:10PM +0800, Eric Lin wrote:
>> This add YAML DT binding documentation for SiFive Private L2
>> cache controller
>>
>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> 
> Firstly, bindings need to come before the driver using them.
> 
>> ---
>>   .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>> new file mode 100644
>> index 000000000000..b5d8d4a39dde
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> 
> Cache bindings have moved to devicetree/bindings/cache.
> 
>> @@ -0,0 +1,81 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2023 SiFive, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SiFive Private L2 Cache Controller
>> +
>> +maintainers:
>> +  - Greentime Hu  <greentime.hu@sifive.com>
>> +  - Eric Lin      <eric.lin@sifive.com>
> 
> Drop the alignment here please.
> 
>> +
>> +description:
>> +  The SiFive Private L2 Cache Controller is per hart and communicates with both the upstream
>> +  L1 caches and downstream L3 cache or memory, enabling a high-performance cache subsystem.
>> +  All the properties in ePAPR/DeviceTree specification applies for this platform.
> 
> Please wrap before 80 characters.
> 
>> +
>> +allOf:
>> +  - $ref: /schemas/cache-controller.yaml#
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - sifive,pL2Cache0
>> +          - sifive,pL2Cache1
> 
> Why is this select: required?
> 
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - sifive,pL2Cache0
>> +          - sifive,pL2Cache1
> 
> What is the difference between these? (and drop the caps please)
> 
> Should this also not fall back to "cache"?

I thought cache is required as the last resort.
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

