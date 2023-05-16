Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA97054AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjEPREg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjEPREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:04:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470E131;
        Tue, 16 May 2023 10:04:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GH4HqG072550;
        Tue, 16 May 2023 12:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684256657;
        bh=rGBz1Lk2ymMxVaQM6dL4QCfsjWcHHyRlf/X4IvKG/HI=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=yBUiRODiiQgzZtAfAHm4NuaZYARaJXyEFqgxc8MArY64kILNBQpYAm0GY/VtzyGhN
         CpykqAGE2pBf6tSVZ3lViCffHICLW8NuOB5LI0MfMqT1eHLSqpzFMSZ1xEyk6iVgKc
         nmZKWn3/7OLDQhq2RYLEgGxhs+u3HEX36pfSly7A=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GH4HNX101719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 12:04:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 12:04:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 12:04:17 -0500
Received: from [10.249.133.214] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GH4EeK099267;
        Tue, 16 May 2023 12:04:14 -0500
Message-ID: <e331d497-9b70-7895-24e1-8932457aa611@ti.com>
Date:   Tue, 16 May 2023 22:34:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: ti: add missing cache properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230421223143.115099-1-krzysztof.kozlowski@linaro.org>
 <168425511044.243008.2148983708471957289.b4-ty@linaro.org>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <168425511044.243008.2148983708471957289.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/16/2023 10:09 PM, Krzysztof Kozlowski wrote:
> 
> On Sat, 22 Apr 2023 00:31:43 +0200, Krzysztof Kozlowski wrote:
>> As all level 2 and level 3 caches are unified, add required
>> cache-unified properties to fix warnings like:
>>
>>   k3-am6528-iot2050-basic-pg2.dtb: l3-cache0: 'cache-unified' is a required property
>>
>>
> 
> Applied, thanks!
> 
> Please let me know if this should go through any other tree.
> 
> [1/1] arm64: dts: ti: add missing cache properties
>       https://git.kernel.org/krzk/linux-dt/c/be9633397b9f268242724a0c763839579761ee60
> 
> Best regards,


I have already queued it up at [0] for testing (should be part of linux-next already)..
I intend to send out this as part of fixes PR towards -rc3 tomo. Would you mind dropping this from your tree?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/commit/?h=ti-k3-dts-next&id=27244f81d6f6abbf06fc705a940ba650fd687b9f

Regards
Vignesh
