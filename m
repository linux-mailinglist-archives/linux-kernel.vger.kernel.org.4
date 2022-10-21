Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB526073B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJUJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJUJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:14:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50341A0472;
        Fri, 21 Oct 2022 02:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8yfvaMUWU2Vha8E8cAhIgYS5JTKGvWKxo2DMr42ONIQPJYtyLlcCTbUeJne8q7TjVA1dI1ornxY73/ue8CD85jBsGC9WTIRaUahIhUZ3iB3cNnBS3/QFVGyoAHeJc7ezcJtK47xQKqGyP+CUpnfYXpjvMFnUNgDTiN1angkgqxQDnE1oX2bTXmLav4T8KhonL7pbvwFdDJ/oZh+h1WLUW2TeT4SPCZrTE04YYYAZFLwN0tTPNo5B0LcL8YVOQI5Ng4IilbpOb4f3y2MnrdF90H8VzQ4Z3KNIExZ63LAgRY9fZDulJUpsyk+O/OhiVgeLXy3BhTpCdSo4xjaoGJveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAp69Kqd2JrS6bqpxfzRBC+5+aXo/LTAJP1qVew9a2s=;
 b=PqRdxntsQCkM2U+TDd0pszVn9cvJS5ZPlpxXAGAg+yIoEj7A1+RZafKa6iQdXMvakuRUHSLIjYAPSRoEZ4+EJj1kFbYDQc51NkezApER8k44/kgvWif+wJuppZb/ooNFh0z5mWqDVGUPg/iICy8Uw0QvdvZt9t1WYDZE4uhYulsuwnAChQ1SRcIxLz2X/cOcBA0M79+fQ1c+sUQhLmkstP3rNTtXD23csr5Sy52282QHTW1+qT7PDY77an5221zXqi6fqmQxWIqCJXOgWFkYinMV7Jge4aJYY2N2YC6adXhcdhFEWjZJqp7ZOieFw3A3w7u2oE38G4bJLeno5jByXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAp69Kqd2JrS6bqpxfzRBC+5+aXo/LTAJP1qVew9a2s=;
 b=U6qD5iR2hX5Rgb9eSrlLnUWYCCW1r9aP35n0ynPz7O3WnmQp1O3RcwSKlMWrY7LkyZ6YSYMQnqzJtajBLOHzQYAeFGRXgxesATY8BnKa5TW+/mQLOWUpIeHUkKsx4OFLzBzCQG+D7kgs5xSB3b5OcuD4awDqYGW5i/f1g8ZZOpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9652.eurprd04.prod.outlook.com (2603:10a6:20b:4cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 09:13:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 09:13:58 +0000
Message-ID: <ac906692-b4b1-136d-e93f-e1388a803684@oss.nxp.com>
Date:   Fri, 21 Oct 2022 17:13:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-4-peng.fan@oss.nxp.com>
 <20221020110257.5ojjq2j2c53hevnt@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221020110257.5ojjq2j2c53hevnt@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: e04ee6a6-19cf-4dae-589f-08dab34495e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/dvUfbA2Jtnk3J2ANqS8N+j27PIUCs5zAzeEabd7upOz0lYvLGdxCenEvzAt2of5Vc80zdwvFHmBF0qacVTouzZI2KoXuhdYPcEEjX8pkMErZEHL/DoCISPPWPResjqBGPh06ANsw86DjkJ9yQBYTkDIGlPIL/dtzpmbmNacw6wodtKGFBskOBHP+Yi/JAvv5NkDLtvfuKErrGob2gdWjqNLwTA4u2ag9omAB1njcMu6QMN51QNN4EluUGdgGIgGWq3uwv8sM1RXAv3XVnUlVF4V1DBpvwcwgdh0A5YkLzByhm5IJac+pwFx0N9NHpQLaxovEuZKGy3yoyOb2FtK1XSmhdJHTm3VilvceSlHO0KqjTr9ncFeb1Rg+vd921RHZKV6p+Yk/gsFSitQvfdE4aXHJF2kYZy4iPGrzal/tBBNOs8EFua8QsLLgYVmNubrgRRJTFwow1Gn2NWMPFbFfl7BsoVazsMQ30Z7kWERcaydflRqUOKEKw3gh/Q4wVKEJrcoi3eNrcARrORkHnXGBmNFloN/QxBwg46b4cr2d0jN6lY9Dbqz5AEk8enhndHDamVQpRm04WNvCcRwQMEAuUYYABkgsH38yhI+GcZTU9j9vhhqhrk+R6lKas5kb/yy5XTTSCZ6KMEmRL0EvPRyDGKG00jFLFl0AInUYNBY6RkwVHEa/1FfVzCNG+k6CePdMnalMy2Q7crC4laBnLCuZ51nW37DzpBuY7qxqetEZvOnV7evr2Vs31B1IO34NdxCot+D++AwvqtRGND6lSA742QdPx0gDJekmXmZz6k2q/xEWaHv+kO48cYTKbyquJ7V64QLGOv/jORdDG1FZo+hhy3nJTVwPxb8uWZyQucmJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(5660300002)(7416002)(44832011)(6486002)(52116002)(66556008)(53546011)(6666004)(6506007)(8676002)(41300700001)(4326008)(66946007)(66476007)(8936002)(86362001)(6512007)(26005)(31696002)(478600001)(31686004)(83380400001)(6916009)(38350700002)(2616005)(38100700002)(186003)(2906002)(316002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Y2eVkrQmFDM1ZsOHphNkYzUVpnZzJyWExEMG5CekRJbFpYcmI4N0NaT1lR?=
 =?utf-8?B?N3pja3ZYd1V5NCtLeHFzUEFucENUSHZ6eUZsR0cvU1M5UDQvekNjUjh0SmVs?=
 =?utf-8?B?WVl6QXRoU0F3RmNVbzUyM0RjV3lDVmdqajFWME9MZzlxS2NuZEtzUWlNd2J4?=
 =?utf-8?B?R3FjU3FaSWRTUGVkaE5QK3d2cjJIL09aUVQzdGhZeXBWYmh1MXU0V2FoaGJH?=
 =?utf-8?B?OHFOMkx4UWtWbm5kVWNEb1lLdjRhczJkeWxsSHA1a1JIWWVQc3BKdExRTUpJ?=
 =?utf-8?B?d2dKa2dEQ3l0eFhjMlFTWGJSY0JoZ2JiN1VtbGlOcmZKTnRhdnpKUXRhRm1J?=
 =?utf-8?B?bS9xZ3pEYS9XNGFMQ0dLb3lZa3NCRWlRVnBkWHMwR0M2M2lhakJiblhRek9N?=
 =?utf-8?B?b0FOTys4TFArQTlVWWovbTY4THhPQlQvcjJVaktmSG9RTlowd0VCR01NM3ZV?=
 =?utf-8?B?TzdOeWVNYzV3L2xwdGxrYVFwNC9HaHhBUXhudGxQUlV3QlJuSXp4TDB4TGVY?=
 =?utf-8?B?aDBEVGs5M25CVHBSaUJBVEc2RXZCOGZBREcwWWkxY2Fkc3Exa1Y2c21yaDdX?=
 =?utf-8?B?OWpDcmRmdFBUUXk3ckViK0FmOTA4TzlzOGY3SkxFMi81SUlvWk1md2VIWWgw?=
 =?utf-8?B?cmx3b1ZoNmNzN2dLaEFNL2xJN29TUFRaSzRSYWVrRWZ2MUc3eVZEMTgxcjF0?=
 =?utf-8?B?d2dIZFl2Q3JMNW1NVzJmZlZ5T0QrSGdweEsvcHlRTHVFQmRKbGNrVEh6WkxI?=
 =?utf-8?B?cWJEY3RDVUxmQTNrS1U2RGRlRU1ER2NBNWkyckoxRHJNOG1mbmJSTEcrOWJ1?=
 =?utf-8?B?WlZqcUlpYkhZQ0djMk5aOXk0Y2plbEUzeVhNakxyWVBCRWxETk5jam01L3Fn?=
 =?utf-8?B?Q1Vsd25jS1BIanpVWmt3ZGdtcnJEeXlIblNldWdEbytDTlQ4NTVkNFEyclRn?=
 =?utf-8?B?aFpFbmU3SzdoTW5xVjlnc1V2bk1WS1pHWFZkTmNReFZaYWhzL2JLVEIyWkQr?=
 =?utf-8?B?blFBdVR4ZDhmQlFjQm1ReTZtdllpQ1NaUENDUys2bWwvYkNHNHhlOWNuVDVN?=
 =?utf-8?B?T2FTYnBqT1MvY1dWZ2QwczB6eEh6MEN2YUQrMlllTkNFWVV2cU80NmhNaytC?=
 =?utf-8?B?RWo0M0RTbTJiNDlpUnhVMHFlUWRwUjJhQ2VkcjZ1bEE2Y25EOXlrb1RpSXF6?=
 =?utf-8?B?eHpIcG1HU0lOdlRDQS9xTjJSRkZTUk95WnBQT0tlaWgyckFOUWdURUU1eFZ0?=
 =?utf-8?B?R2JNdmVaQkNIcXpEbGdLQ1UwbnlnQm05bFR2RVhZWTZCVWg4SUx4Wm9MZzJo?=
 =?utf-8?B?VzNoNFk0a05DRTZYVFh0MHUwdUtVWGoxUXFYMENxcmNaYy9wZFFoU3UvZ1dJ?=
 =?utf-8?B?RG5UMVorSDc5Vk1Da3JDVUoyRE10WHNMNWxYTm5qUEpoRXJNS21RR2FiU0Nt?=
 =?utf-8?B?TVVXWTdBK2hnR3FxT2I0RE52eUlPcXV4MXprbU9zeUNCdGRwZ3FaelF0ditr?=
 =?utf-8?B?ZkxtY2RORW1UcFV6NEk1RXU4VmFVdUMxV2lYL2dkRnlZaFFMYlh0MTJxa2Qy?=
 =?utf-8?B?RDFpbVdsSGcvUnZNQ29oY2F3ZUpFek5sYThiVS93WGRoRkFNL3NGL2tURDhv?=
 =?utf-8?B?a1IvWll4Z25zaUl3UnN3bjRrZ2V3a05lZFRkd213M2pkc0pYSWdtU2gvSUZT?=
 =?utf-8?B?RXZmejZOU2V0bDc4enI4dVE3V21DV1FUMWN4TG05S2RLbVNZejd3bTNDR2ZO?=
 =?utf-8?B?blN3STdpUEZoeW9tSUdxcXlWYitzbGVPSmdkVEFkRGM3Z0hBdFVSNW5zci9G?=
 =?utf-8?B?bTAxelo2ZmJST0x3RzI3N1BuNGZlcmptMGdhcU1FRTlhZTJTZVZkajc5aUVZ?=
 =?utf-8?B?SGNJdGtHS0dWTmM3WitlY1BkaGZ0R0JaSHpqSURuNzFwbG42bFQrU0NjZUJE?=
 =?utf-8?B?b1lsN1JhZGhpbWRTenJGL0FPZWFPbmJjcU05Rk1aRlFLNXljMUJWNjJIYlJa?=
 =?utf-8?B?cDJYWVNBUjIwVmhWb2VwTndLTkNGN25TRkQ1amlEUnFZZjNJQUZGU3ZVVUFG?=
 =?utf-8?B?SjA3ZWQ4aTlHVU5xODlUTGxObG1XclFRZ3JjcnJDbm04OUNrRnhYREl2OG1p?=
 =?utf-8?Q?jwso8LBbzrhHPN6O8QEy2L8BI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04ee6a6-19cf-4dae-589f-08dab34495e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:13:58.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS1N0n4+vBZNINv3Tkl7c+vdnWmgYJ8Ym88GIlJGl++j4sND2XY4ZT9JkCA9BtFoIvcKkZCau9iXnhfxsBlISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9652
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On 10/20/2022 7:02 PM, Marco Felsch wrote:
> Hi Peng,
> 
> On 22-10-20, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Per PCA9450C datasheet, the voltage range as below:
>> BUCK1 0.6 - 2.1875
>> BUCK2 0.6 - 2.1875
>> BUCK4 0.6 - 3.4
>> BUCK5 0.6 - 3.4
>> BUCK6 0.6 - 3.4
>>
>> LDO1 1.6-1.9, 3.0-3.3
>> LDO2 0.8 – 1.15
>> LDO3 0.8 - 3.3
>> LDO4 0.8 - 3.3
>> LDO5 1.8 - 3.3
>>
>> So correct them, and also add LDO[2,4]
> 
> In the DTS you specify voltage constraints for a specific hardware and
> not the one supported by the PMIC. What the PMIC supports (min/max) is
> specified within the driver.

Technically we could set board voltage to PMIC voltage range, it not
damage the board from hardware level.
but I am not sure whether Linux could work proper.
Saying set VDD_SOC/DDR to pmic min voltage, system will crash,
because it could not support higher freq.

I am not sure how to proceed on this, just update commit log
to say that the board voltage range could be set to pmic voltage range?

Thanks,
Peng.

> 
> Regards,
>    Marco
> 
>>
>> Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 +++++++++++++-------
>>   1 file changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> index b4c1ef2559f2..a4cddc5a8620 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> @@ -248,8 +248,8 @@ pmic@25 {
>>   		regulators {
>>   			BUCK1 {
>>   				regulator-name = "BUCK1";
>> -				regulator-min-microvolt = <720000>;
>> -				regulator-max-microvolt = <1000000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <2187500>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   				regulator-ramp-delay = <3125>;
>> @@ -257,8 +257,8 @@ BUCK1 {
>>   
>>   			reg_arm: BUCK2 {
>>   				regulator-name = "BUCK2";
>> -				regulator-min-microvolt = <720000>;
>> -				regulator-max-microvolt = <1025000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <2187500>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   				regulator-ramp-delay = <3125>;
>> @@ -268,40 +268,56 @@ reg_arm: BUCK2 {
>>   
>>   			BUCK4 {
>>   				regulator-name = "BUCK4";
>> -				regulator-min-microvolt = <3000000>;
>> -				regulator-max-microvolt = <3600000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			BUCK5 {
>>   				regulator-name = "BUCK5";
>> -				regulator-min-microvolt = <1650000>;
>> -				regulator-max-microvolt = <1950000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			BUCK6 {
>>   				regulator-name = "BUCK6";
>> -				regulator-min-microvolt = <1045000>;
>> -				regulator-max-microvolt = <1155000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			LDO1 {
>>   				regulator-name = "LDO1";
>> -				regulator-min-microvolt = <1650000>;
>> -				regulator-max-microvolt = <1950000>;
>> +				regulator-min-microvolt = <1600000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			LDO2 {
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1150000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			LDO3 {
>>   				regulator-name = "LDO3";
>> -				regulator-min-microvolt = <1710000>;
>> -				regulator-max-microvolt = <1890000>;
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3300000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>> -- 
>> 2.37.1
>>
>>
>>
