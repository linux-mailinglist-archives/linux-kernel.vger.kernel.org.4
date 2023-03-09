Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0446B3201
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCIXSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCIXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:18:17 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8E4346F;
        Thu,  9 Mar 2023 15:18:14 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 329NI2Bb014703;
        Thu, 9 Mar 2023 17:18:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678403882;
        bh=w5g9O5yVcu5RudsvWZQ/nhMKJuII/q6Dcd9DVOzevpg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sW3In/TzeYU7dT52GfSZ+AW8XjRxsTuI/LSUeEpP2fGYuJHkE9TUlfFnSO1d5v6UY
         lZsCa+vV+dI7HvsoZcq65FKbojjykKq/FT4wTSYFA81Sn0sgwuwh2qoyaHoZJuh1s5
         mG5Gg/ucuuuwLdjJx6vkQXXhAzzmnlY5YcKcQ6bo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 329NI2Od047698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 17:18:02 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 17:18:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 17:18:01 -0600
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 329NI1TV014030;
        Thu, 9 Mar 2023 17:18:01 -0600
Message-ID: <8662e02b-9d28-8ffa-6ec2-5cc6348933fb@ti.com>
Date:   Thu, 9 Mar 2023 17:18:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings for
 K3 AM64x SoCs
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <kernel@collabora.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-2-martyn.welch@collabora.com>
 <20230308205833.GA1768401@p14s>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230308205833.GA1768401@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 14:58, Mathieu Poirier wrote:
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - ti,sci
>> +  - ti,sci-dev-id
>> +  - ti,sci-proc-ids
>> +  - resets
>> +  - firmware-name
>> +  - mboxes
> The 'mboxes' property is marked as required but the description section above
> clearly state the M4F can operate without IPC.
> 
Well, when the M4F is used as a safety processor it is typically booted 
from SBL/u-boot and may isolate the MCU domain from main domain/A53 to 
function in higher safety level. In these scenarios there is no remote 
proc handling of M4F life cycle management (LCM) and IPC. But, on the 
other hand, when the M4F is used as a non safety processor its LCM is 
handled by remote proc(main domain) and mailboxes for IPC are required.
