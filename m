Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3C702354
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjEOFcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEOFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:32:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C237E7D;
        Sun, 14 May 2023 22:32:16 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4BCA624E00D;
        Mon, 15 May 2023 13:32:09 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 13:32:09 +0800
Received: from [192.168.60.149] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 13:32:08 +0800
Message-ID: <6c4b3965-a86d-41f3-f8c7-aab731b70f09@starfivetech.com>
Date:   Mon, 15 May 2023 13:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/6] media: dt-bindings: Add JH7110 Camera Subsystem
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <bryan.odonoghue@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Robert Foss <rfoss@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Todor Tomov" <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20230512102844.51084-1-jack.zhu@starfivetech.com>
 <20230512102844.51084-2-jack.zhu@starfivetech.com>
 <20230512112607.gbf5m3vntr5h4giz@krzk-bin>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230512112607.gbf5m3vntr5h4giz@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/12 19:26, Krzysztof Kozlowski wrote:
> On Fri, 12 May 2023 18:28:39 +0800, Jack Zhu wrote:
>> Add the bindings documentation for Starfive JH7110 Camera Subsystem
>> which is used for handing image sensor data.
>> 
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../bindings/media/starfive,jh7110-camss.yaml | 179 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 186 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/starfive,jh7110-camss.example.dtb: isp@19840000: ports:port@0:endpoint: 'bus-type' is a required property
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 

OK, I will fix it. Thank you!

> 
> See https://patchwork.ozlabs.org/patch/1780481
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
