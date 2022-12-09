Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87F6484F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiLIPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLIPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:23:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA602D1DE;
        Fri,  9 Dec 2022 07:23:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UslqNYbvmZfBwdDt6YO6v7QV3/tu4GDKddn1RZoCRI5EHmdjYh+2Cwf8HJCIQo7zeWcosOMXqh7cH0CSPOY/AikqLlS/HYXsU24maZ/+dpEDhP2Fo03KU8yIXFgPG0qjKn5wcwtSUqf2uiItWiOMrODgILpmE4TX3ODEk9qYdX9u3i9xm79WJQRhpljZqhuUElrf450TLMdwblki0iQWuDiMIY6QAXhntrr6WVNigI4VD3SX0PD3Csuz+P/jKHpXhgqa3J9mWNENUdLiRHIixosSpV0pCky0KUrjGhdG8kMYgMh7hAnIZ9IcOdzQG/T96cH0FfN+vKp2xJR+DZw/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCKNHIDki15l7ab6l91uQTVIp0k0f4/3tZTw0opKR/Y=;
 b=Zd9S8IccVzsBL9Z2yy+WjAW/YjN7GFKtwSyljwD5tV0NAN47FxhPYUGLruYZwdoGrPODznz1FRhq4E3jpM79VtDcTJRZr/Sssw5UKRQdqU6P/g1Y+Q9yrza0WRp6Gk3rqjDAFMWSvhiiLMMRgknEFqFevjFwC3IDW5At2CFbnmnQkcbRe7hVxt3zEUMDzF6Ya9mmePX4EN5a9is2I77RhsGG0UjbXHBkDkRRtHiZaHvEHp8oAsI0hLJmVmo9Ln1IKHbKKv+lQZkbYqXkRQZRfo+etxkjHSq/Bl/wOgz7km8Jh/07Vm4X+qY1DvWhraiUM0QDGUP6bb36WyXhAjwb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCKNHIDki15l7ab6l91uQTVIp0k0f4/3tZTw0opKR/Y=;
 b=iBZdUPWKIZtEQuIPzcgfHUbKJh0uAWrcsBUNO0vcwrjL8wNhBNzRyhT2D+xF7ENVjZcqBnNLYucZOU5ORXBzODJ9PiX+gqkPkz8HnLqkk+2/TmBmyIHTzdJxtpd7wli71WurcZ4QjV5QwDCpcBN/2foTa2uZDvM78F4jUpPPvlE=
Received: from BN6PR17CA0046.namprd17.prod.outlook.com (2603:10b6:405:75::35)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:23:37 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::8f) by BN6PR17CA0046.outlook.office365.com
 (2603:10b6:405:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 15:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 15:23:36 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 09:23:31 -0600
Message-ID: <d097b9f5-a82d-f343-088d-d745d5d1ed32@amd.com>
Date:   Fri, 9 Dec 2022 16:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible
 string
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <718283a9f5493ab63b4aaa12337dd5cab6538ff5.1670594172.git.michal.simek@amd.com>
 <ff731bed-1df5-aafd-d490-7bdf9382ff38@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <ff731bed-1df5-aafd-d490-7bdf9382ff38@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 055c323b-f9be-4051-a050-08dad9f957c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5u2Q97Ok3OpY5NTAeuOQTW+X7ft1WASIMCJDMQ5TR5B9k/mGeLdBYok6fDzKGJ66XSG0cyqGYQm67UXM6QeMPi77wwmZ2c95jFfIB1Pujy8IlHQKjblyaBRWDsnbqG1OcFAdQVq3tfgdK0443GYzrhscKz0J+kVADdmbkcnzaj8I+Xzi8XokWVhOlHERsLnPzRuJK6hNcrLRXwOZ/3UlbxVAjWzy+jr0KS5nyBTw+OOZ2ODq1MZLhNSJi6AUUtzhzVhF2kWvvq2fu4eknW7MzmSZEexacgXVwaZDwLJYdh4oeJIrOl60kIev9cJVM8OCfkpN5vNogA5qmGYQkrAiyvtm0dAhUZg/VEMydeThcBo00fzYV+HJx8XpJYQuA4Usoe4yQf7dMEvF6Zqdp73QzjpBADxpF4psV6Wzk2fHjKslCIcJED3PD0/WtkZljwP4H//k35Rtbta6HMsesCfL3HafrODwks1S5W8EnfTByDMmUplxvqPDvjxMXyWroV0w9Oc3TrVWIqtAQEGTxDJui/278IUu9S9HZd6BoHNuVAeydRaJkfeGxkQwKUhwnL2DL4uyOmJvgvjQX41m5pj2WkbaQoLNqGjmg28rh4NJ7N3epeSbcy/NtKMPGcKM4POerySyNENhnUnjDtHZEGgqQhxUOW0JFj6IuXbBusL/wUDNa9Qa26wX1bRjt/q97ZlGM0UGE7Ma2c/mb9gHuVy4IY6fo+G87i8Fz7/PWFIJxqyuaejIcJejIfjryPxUrOylScY0L1pBQ/zxCMPrzvVGmZu5NFoGXUA5qLcMH4Gsng=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(31686004)(36860700001)(70586007)(40480700001)(70206006)(81166007)(8676002)(4326008)(356005)(82740400003)(478600001)(186003)(54906003)(2906002)(336012)(26005)(16526019)(86362001)(110136005)(83380400001)(31696002)(36756003)(426003)(53546011)(8936002)(16576012)(47076005)(5660300002)(7416002)(41300700001)(316002)(40460700003)(2616005)(44832011)(82310400005)(2101003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:23:36.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055c323b-f9be-4051-a050-08dad9f957c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 16:11, Krzysztof Kozlowski wrote:
> On 09/12/2022 14:56, Michal Simek wrote:
>> From: Harini Katakam <harini.katakam@amd.com>
>>
>> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
>> favour of xlnx prefix. Add this new compatible string and retain
>> the existing string for compatibility with uboot drivers.
>>
>> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 8553299f12eb..233127d94204 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -507,7 +507,7 @@ nand0: nand-controller@ff100000 {
>>   		};
>>   
>>   		gem0: ethernet@ff0b0000 {
>> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
>> +			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
> 
> That's not what the bindings are saying. If this was the intention of
> AMD, you should have replied to my patch that you need prolonged
> backwards compatibility.

I have sent the patch to U-Boot to support new compatible string and CC you on 
that too.

I have no problem to do switch just to xlnx one but it is not fully accurate 
that cdns,versal-gem wasn't used. True is not in Linux but it was used in U-Boot.

If we can go straight to xlnx,zynqmp-gem, cdns,gem I will send v2 of this patch.

Thanks,
Michal

