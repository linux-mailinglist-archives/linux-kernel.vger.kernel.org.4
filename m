Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38AF6EDE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDYIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDYIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:50:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C083B4;
        Tue, 25 Apr 2023 01:50:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33P8nmbq116180;
        Tue, 25 Apr 2023 03:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682412588;
        bh=F6uUKvlJXnHtyqmkArJksL0ShD4iEzTqe8kOtuCpooU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cwDxKnMPag+538P9Q4PSp7xXsYWgWjU9rTlg4akysmDb59Po7UhABk4IN27wz2TEY
         WSQ3kd2YYuTGzxcG9xN24w2wy+fMyGB0aqd9cyQ4TcT2w+5Y9GEx4NGLXmhVvKaBCg
         xnT2rE1GIHH6b1sjG7FXUOIUR1iP91dVjVHNBl9k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33P8nmIh122945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 03:49:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 03:49:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 03:49:47 -0500
Received: from [172.24.145.195] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33P8ni6w058505;
        Tue, 25 Apr 2023 03:49:44 -0500
Message-ID: <705557cd-0a60-3cda-d78b-d78e2faef856@ti.com>
Date:   Tue, 25 Apr 2023 14:19:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 0/3] Add support for ESM
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
        <kristo@kernel.org>
References: <20230424105011.70674-1-n-francis@ti.com>
 <aabe7488-29b8-895b-38b8-67e5a7d1dd35@roeck-us.net>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <aabe7488-29b8-895b-38b8-67e5a7d1dd35@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

On 24/04/23 20:27, Guenter Roeck wrote:
> On 4/24/23 03:50, Neha Malcom Francis wrote:
>> Resending as no major changes, commit subject change only.
>>
> 
> Maybe you consider changing the subject of the bindings from "misc"
> to "hwmon" as not being a major change, but it made me aware that you
> are trying to sneak bindings which in my opinion don't belong there
> into the hwmon bindings directory. This is not a hardware monitoring
> device, it doesn't have anything to do with hardware monitoring, and the
> bindings do not belong into bindings/hwmon/.
> 

I understand, it's a thin line across which I pushed ESM into hwmon; my 
reasoning was ESM also actively looks for signals that it aggregates, 
and is overall monitoring the device health. But if there was an option, 
in order of fitting: fault/ > misc/ > hwmon/

Using misc/ was questioned in an earlier review; and fault/ is not yet 
created and I did not think there were enough instances to back me up on 
creating a new dt-bindings dir

To come to a common solution, let us keep this binding in misc/ along 
with other fault detection mechanisms existing and take it up as a 
follow up action to create a fault/ ?

> Maybe you can convince the devicetree maintainers to accept the bindings
> into the suggested location, but that will be over my objection.
> 
> Guenter
> 
> 
>> ESM (Error Signaling Module) is a fundamental IP responsible for
>> handling safety events. The driver currently present in U-Boot is
>> responsible for configuring ESM. This patch series adds dt-binding and
>> nodes for J721E and J7200. This goes towards end goal of having DTB sync
>> with that of U-Boot as well as ensuring completeness of hardware
>> description in devicetree.
>>
>> Neha Malcom Francis (3):
>>    dt-bindings: hwmon: esm: Add ESM support for TI K3 devices
>>    arm64: dts: ti: k3-j721e: Add ESM support
>>    arm64: dts: ti: k3-j7200: Add ESM support
>>
>>   .../bindings/hwmon/ti,j721e-esm.yaml          | 53 +++++++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 +++
>>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
>>   4 files changed, 61 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
>>
> 

-- 
Thanking You
Neha Malcom Francis
