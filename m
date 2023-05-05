Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AB6F86C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEEQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjEEQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:33:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2075.outbound.protection.outlook.com [40.92.52.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2614E60;
        Fri,  5 May 2023 09:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhZVkgy2sajp3ToDjkIjFRcJpsGvObnxOcFzo57e3TmJxFSFd1Qz4nXTk/bv8qJTnOkdhbeG0JIPD3xxOsV63FVrgjBurwEfCj33h394sB0tTiUpdhnk3S/pE7cW/4HYIQuZdy11UoyYmp6cpUQ3YrVV642jy48rC7jmxCI9Db9NkBY26m0/J6T4fpuUsJZGDQ/ec8rh3i6MTFfkmrqpoSTXLjc1QGfmZXXIXBdsTXfiotwjsHbtsQkHiDyioGGx1NuVjxb9fAMqmzZpyubRhzFivxiJUp56h9sPx6ccAUi0wTc2Bs47iWaQi4BaadM5c3yeQ65MTbb04F7S7t9iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmmJlFEHkMywz6UToheMMZe15STn7UpGGw4Hfy2dtEw=;
 b=DuZ1xr6VFamizh+m/VJkyvVp7U8fuaFWLUNJJutVIGgerSnWeoDjfVpxKS9y3dj8ay1OM0nW7dTqo6fjHkAaCEwhhXO/LA6fSLdAc4aZQ+UoWoSFeYcDJh0FGB03N6P7sMbAbkQFhPewVkDPhIODiNpBWTotvXGlc1jgmXKJRwHF7RELq34o//kv6+1+swuUdhNK+Z7gutVX8MyKmrCQL7Oo8r7OW/EJpbgMfCbC0EnmXGMt7al17xtcLVnDdTsE+zI3rxnZDo4XYaOUA7UiPhVO4UXSIJCYXfz7Uvj/d7AUgpCPOkdxSLYSmxcFkjZ+QhFuV1C4HzI4/vOajPxBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmmJlFEHkMywz6UToheMMZe15STn7UpGGw4Hfy2dtEw=;
 b=M5g6urH4IgRf9CWTKWX+3HWRZQwxNqYR4FgnWipvDm8b9rCA2ebFvacMZfPQpkG63477Kmlv/2WUhD6Xn+qvP0RC3Lw4+8FkN7OvuujWg8ceQTjCPMrYlLjhsIlqfKhHktUZp8sNWxlFvu0SRsyVCc/KOGD1QGds1bPx/RlM2HC/rALG3dM3Dqb3ehM3y5cUC3GLEZPGvUJH7xAjjGe30xF5Ldh0T08yBtYOyG3ZnDZmbkOjDDbsLFOATqND3ed68fx5u6eJcrD3C8achx8cJBZ6Lsu/ji53ZQ/g7HavReG4GTT8VNraa9Bz+CreiV4PNrrxhFX/neNPkUYSpZz78g==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by TYZPR04MB6150.apcprd04.prod.outlook.com (2603:1096:400:25c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Fri, 5 May
 2023 16:33:00 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 16:33:00 +0000
Message-ID: <TYZPR04MB632102315884225B7343533B96729@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date:   Sat, 6 May 2023 00:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
From:   Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-ufi: make UDC dual mode
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [Mu4cyeDXvI424nx6WbXR1VAq42WJTvme1cxIQT9Mw3oq+agK60s5Y/HX5Fsha9NM]
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <f853cd21-846b-c78f-a0dd-119c0e26e38c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|TYZPR04MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9e391f-ad4c-4022-f8af-08db4d8663d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qknd/WSK+nvp0PYn/fsDE4S3gAF8kPPrzzt0tS495i/y8zBEwtps/VHlF8rK8rcKScfB/h++/kfcib1f1C+JOtv+Wok8HJUioV1fp5OCfHZb0X4NZcMUIjPeR32i/wFCWhLZSolRqVQ8l15zPdVVXt3Ly7P2cAxd3QUGQwHR08b062Rb1HQ6QPTpdw9SFDZ/t3f6yXAK4TvlYZB7dWkYsb+yscIFT3sgMmjzWDm6gf6AR3AIpEY6lHuM/JTnapONwkst8K8DZKDLFItPERQkPu06ufczHl9GCHp28NUBn++wFntSXmCUad1YzEbJbRkqiCtZlrtdtLjusd9qaEwbFeFQqJPFyHHfRJWh5xghb7oKZG6/dd3le3fBlet/rQ2qmnwPKXJ7v5bdE6SQzd0gIxcy1PeOdCZGBzOobK4xepRolpF5QLgxqLqB3MVoKBTk2BTBrDhq8MUv+2DwTez/sa0UK0c16O1jVEhFwQ+xjN0xXPfJMzdxtS7VoFqD8/wZrBNyTJeXkqBhxpwbjvdzx6ZN4cmDwqNuwQ0NF717grFyocU1mZuh+E7h+Jo+3HVG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVY1ckR3dXpaQ0ZPb0ZJVEtLejF5WmtVL25DKzZoRmZpU2FUVVlPMEVyUVhF?=
 =?utf-8?B?aVp2QzQ2Q3ZjL1ZucEF1TmEveSszbFl1a3BZdG16cGdES3NyeXloc3VDVVNs?=
 =?utf-8?B?VklENy9ReC9sZVBlZ1Q3Mm54ME9hVTdXQWVoeWpBUlNIeDNvcmkvQktiZnQ4?=
 =?utf-8?B?QlF3b09ucDI4NHJ2L3NDYUNxWHNMdEs4WDZiMXplcmpLL1ZyV1h6UkFtMzhK?=
 =?utf-8?B?c3VDWjF6MGQ4OU93b0pwM2xYNU5tMDl0RWg5elBxVmtMNlE3c2E5NW81aFI2?=
 =?utf-8?B?UGVqMmNYdFYwY1dhRDVMWmprYmtoSmM1M1BLdXl4U0Q3MWRHanJxQnJsT0VC?=
 =?utf-8?B?UGlrZVJ0dGZERkZ4N1NaMUEwMUZDbmZlc1pkVExUazA5d0hVRVVSQUE1V2JJ?=
 =?utf-8?B?Rm51bVViYzRDbjhTVzMwYWdPbG1ScllqMjUxRzdha0E4OEtTL0V5cHZjYjdW?=
 =?utf-8?B?aGw1YlJSdnR0eE05KytsL0JjMlEvNkxrWkZsSnhHMW9YeUVYaW56UFBRSzd5?=
 =?utf-8?B?a1owZjNvLzRvQktPTDBaRkhodmNNQk9nWlJuQTNnYUpxc3lteGJ0RzMwcXE4?=
 =?utf-8?B?NncrRTBzNFZTR3JqVyt0OVNkUEdBdWNtcWdWNDRoL2pVOHB1MnJQbStBdUJB?=
 =?utf-8?B?RTliZ1lVUDNQUWppcnFOb0RrVVdMUllHd1dCTlhUS2p1cG1OOGRpQUx4Z21B?=
 =?utf-8?B?eW04bGQya01jMFNjK08yNHplSjkvVlNlOVRmSkJVZHNnY05tNlZvcnU0MWIy?=
 =?utf-8?B?WTREMm96ZVFMWmFiaG5YRXNiUElhQ0xDcXl4OVFrQUpmN1RoVU9EZFhxWm5i?=
 =?utf-8?B?UmMzWFpxQzdtcWMvZlhSYlZBQjQxcUYvUHhFRjlHN1BJTW9sbTR1bHdtbzVx?=
 =?utf-8?B?NkZLb213RklqMmFiK21GWjltb3RhMDJNYzN4U1Q4VnVUYmdTWUo3NEJ1Q1JI?=
 =?utf-8?B?RDA3WStLaXh5ams1V2hiUUJVREVqaDV3bGhVL25zR05sTkhWNW1mc3lZQ3NB?=
 =?utf-8?B?a05FU1JBMy90VWlKVWtTRGlzZWxmWUhDQ2lnY3ZQM3orTjU1MFllOEZrd0h0?=
 =?utf-8?B?UmRaVHh6czNVMkZNTG5LOGVnYjZ4bUNBTFZwNDNqZ2psdWZaZ1Q0a0xSbTNP?=
 =?utf-8?B?cUtpbUkra3lIdTQrSzFEa1Q0dFB2UVN4aHlobVA0bXpEWGt6b3BDUHVIRzh5?=
 =?utf-8?B?dHVuNDRqa0FsUENCcXdwNGFEaTRiMTZremxxNG1NWmw4TUdhZDJCU3VweXJV?=
 =?utf-8?B?VGJiTTE3WGFNUWRkOW1iVXdvcFB6SHQrNHp0Y041RjNZU0dac09ZSXNMZU9Y?=
 =?utf-8?B?YlE1Y3d1cXhaa3dQOGRUbUU3cERUQzBJRFFMaG1FbHpLLzFlb1BYM1poOUpm?=
 =?utf-8?B?Y1djRzhheVFYM3lYMElHT05WZm9ZYTJLQzRUaVhRdnF4ZVovUmRtRHd0ZlFH?=
 =?utf-8?B?cWtxSDRUazdHdnQ3L3lnOXhaRE5vNkRzRVcydVFPWjZFU2ZVbWNBcDExdW9J?=
 =?utf-8?B?NGRWelRSYmRIZElsWjVlTzRPeUU2bDNsSFRxWEJzVm5sdDNEcG1NY29tYms5?=
 =?utf-8?B?RDVDV1JCMzUwaHFsdE1kcDl0WEdhTTR4NXEwVDZxLzNqTTFMSVRuOEx4NGJi?=
 =?utf-8?B?WVBIYlk3SXNRQTkrdlJ0Q3d2RG9LcGkxYUJJRlc1TStVSEpVemExS0pHeVhS?=
 =?utf-8?B?eFRZSkFwZmxKa3pwRHVjcHBWcGJxOTdTVXJNSUNza014Z25Ha25DdGdFM2Rt?=
 =?utf-8?Q?4ef0aisy3tUpPOSr4Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e391f-ad4c-4022-f8af-08db4d8663d1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:33:00.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6150
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to use this device with a (non-standard) hub to get USB
working in host mode, but dr_mode="peripheral" prevents the UDC to
do so.
Remove dr_mode="peripheral" and add usb-role-switch so that it defaults
to otg mode and can be switched to host mode in userspace.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 50bae6f214f1f..08ecd901c1af6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -109,7 +109,7 @@ &sdhc_1 {

 &usb {
 	extcon = <&pm8916_usbin>;
-	dr_mode = "peripheral";
+	usb-role-switch;

 	status = "okay";
 };
-- 
2.39.1


-- 
Best regards,
Yang Xiwen
