Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177C7331B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjFPM5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbjFPM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:57:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD01BF8;
        Fri, 16 Jun 2023 05:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRHh+tqyR0X0RqJzY+t+EWdsVNPEXQ+T7HFqQaROWd55Je4d5KkQHd+IpBpJVG7V3h5UW56Y12gq5UuMZFzCbZhm0osg4e3zv1fZuqnszY/3H/4ZjJXbo9pYcOBbaot+XHHfWNhwv4Akr65tsmbqZbqocG9HKDDGYCtA6KELLhb5auY4ESuBrQ81FIxsn3C6DfX4ByetfIKYSmGJMFYpINgqBDf5Ib8m2Q0BJ+GO5hldameNikNZ1wg65T0rtvpRVaTsomLB8QmKoUNaNAC+KExjW0J/D643glPlZlmguK5J6rNEffemKYqzwpBlxq3YrWJMv+azaVuTmKn0Ngh0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkyMVg5koEREGmThhc5wFUnaQboxqlQ3Ao/5Gli+YRc=;
 b=BgjxFUrf+0Bk+nkcZJJ7TeRpmsxDI3f7bXVIqRmc40HAXKXA530jC3Fen2/7Muck9aneCb3Sd6u2fhtM9u5rRt03wTJYH9XnlT6wLNIatk8uL7dpIVKLSqaUdRRtEPFShWy0S0CwqSD3Ro6IOlAmy3Ma68yDW8kyzmRUbhnnHjgtG9VorKfhyLY2iyhtBRn7VY4r+cW6PKrAYRSbpb8YpUbOhf8FivvhvMJvYDe9kYodXWa3TZrkShRI39rDeE5/7k9dniU5k9iNKKVXEpsEyzqwykMDQ975duw1pSx2aU2q/wTexAoJMrkoCbZIG0eQdSfb/d8/PY/j+dBwOsM4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkyMVg5koEREGmThhc5wFUnaQboxqlQ3Ao/5Gli+YRc=;
 b=lo3snKW5qz0LF3awgiNPuKVb6u22kFaFdo3kPZOJODCCgIhXvJYRyqEs3LxPp+YKBcg/+7wJ6WkELkIFWGtw5xPZbentKtXsE7SfnWoyy16UmPLTI8BNuf9XzCp8qnX4piggKQSYbsXXHrL4ddblOq/JKbEm4XDKRyKdpkNGwnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU2PR04MB8502.eurprd04.prod.outlook.com (2603:10a6:10:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 12:57:41 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 12:57:41 +0000
Message-ID: <12951175-82c5-e93f-871d-1379e5985b10@solid-run.com>
Date:   Fri, 16 Jun 2023 15:57:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add support for LX2162 SoM &
 Clearfog Board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-4-josua@solid-run.com>
 <c25630ca-c791-287f-36a4-ebc0559d6541@linaro.org>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <c25630ca-c791-287f-36a4-ebc0559d6541@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU2PR04MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 476863d6-3157-45de-54b1-08db6e6944ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdwOjKWmHhN9tKenTPUq4aq2KP22o5ty7Y1kTr5EZ1V3OhwTk3vMBBDwAe6lnxc+QJh/V3kL9G85SPlTJR1gkkGEw7aAKQMck2IoLa6tKL5F4GqYLjUzeDN1TSxMsSjM/8cKfR9itks9tYbIfv96Jvct6WHUIh0mugca2+rDe7p0ysRbwVNv1aD48geoQK3sa5GmyHu1GuYEN+1WpGKGPUv2mPdO4714wl6txCArxvyqN8ap6of25Aow/n8rWuHzGsknBYIECX2h27BUsO7F0KW/th8UumM//QwO4wfJfedYS9HSCv194mb1nj6sFVuKxuC90Luzfp8/J0JxSDIKkUp2ROzZw3fb0D5lsUflUhZqhw/IFewp8ElnaxY3Dg19wg+jvO8fbX5W6GedOurW4c+7rZOCkB0R+uhKon5rOSXjQfHfdaAdKVw1XtBdgG2Q1V38P6x0tDy7NZEkMMSiGDs/f7JVRI+RzAur710osZk6DQQe2SRf+0koimcJmXnq0Q7/hvFjno25UFGe3AY27sf+aeOby4AgarfGnyM0GWDr1/qYf8CVxLKD0FowXNpoIFrpTWvUF7A+kPLfcxS7JpyPhHiEZmY/YA/yYds7DVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39830400003)(451199021)(478600001)(54906003)(6486002)(6666004)(966005)(5660300002)(8936002)(41300700001)(8676002)(36756003)(2906002)(86362001)(31696002)(7416002)(38100700002)(66476007)(66556008)(316002)(66946007)(4326008)(26005)(186003)(6512007)(53546011)(6506007)(31686004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpzSDlDaWdlTDZxUzNKSVhvTVNpOFNVZmNLS3kwdVhkWDA2SHZ1amx3eU54?=
 =?utf-8?B?TDQxNkRFWnBtY2lUdDVMVVM5WHI0ZWJwZWw3N2hreG0xNVVoOFd4M3lINnNp?=
 =?utf-8?B?OVNQWlN2VS9pRC8wbkptUUJHdnZTSExtWkRXY1RZZ094bFRod3RhTjQ4QUlR?=
 =?utf-8?B?VG9yMGZLcXpYSGhQRWUrRmFGcUZSb2RKeWRmenRmTVNMS2M0c3JrWmVRQ1pz?=
 =?utf-8?B?Y2RuMWpWcjdpWU9odlIyeW4ycWk0c2ZvSjFabnNkUnZQb0l6QVk0V0pvRVhx?=
 =?utf-8?B?cHNxb0UxbUNsYU9wakIwb3RCZFhLS1NpTDBLR1Z1MTdBY0lJYUl3dDUwbG9P?=
 =?utf-8?B?cVBoTkhVVzRLbVEwUE5vRGtlTWhMYk9SeVFmR0g3bGZrRy9ITEJ4ZVJCSjdY?=
 =?utf-8?B?Zk8xd0c1YmxjTzFLZnBUTHdDbjl6aXpjSmpzSHBxaWI4Q3BXSmFWaTgxYmR5?=
 =?utf-8?B?bXJJVzdHL0tDNmx5OHR3TkhQWDZ5MlhMN3p2SlM3dVZpRy94YlRqYUNSdUox?=
 =?utf-8?B?WTVCcktUVHorZ0IwQ2wxWmh5QjdwUzNYZ3BLbGNMZUJreXlaQ1FmYkkvRll2?=
 =?utf-8?B?V1J1NEFReFJUK1BXUUpOTHB6UHNkeWN0WXFNVXVicWVrRzRhY3FHSFI1My9x?=
 =?utf-8?B?SC9pVURZSFcrOGp0RDkvWUJNUk1ldlM1Z0pVeEtTUUtFcmtJc24reGh3M2JT?=
 =?utf-8?B?bktSa2Jqd2pYNGxkeWxrbm80YWRvb0NPTjFNWWwrOGFGR0l5YStJV3psRTE5?=
 =?utf-8?B?VUs3NEoyNlh4cVF4MUlhMG5JRkxIQ2FlVnhMWE45bEovMFpkTDR0ZThQckpx?=
 =?utf-8?B?Q0tMU2ZDVWkrVW14MkF2RzVHZnhRcXcxRzRMaUVlS1RDZlZnSHFSdTFuK0xL?=
 =?utf-8?B?TFhEL1BQNGRTK29zeE9UNDRQbUp5TWJFUmtqYWh2TmNDdzE0Yk1mcEZvMXZB?=
 =?utf-8?B?ODZKbUJkOGN1dmZZRXVTeGtZdWdkWEg1bjVMcVdhd0duamZzVVFrZFMyVmlF?=
 =?utf-8?B?UkI5TE93b0lJVXRBZTBTUUx0bnU4cVJsTWlZMXJ0RDdQc21VT1BPdXU5RXV3?=
 =?utf-8?B?YWwwQngxakhXMGFZQk5xVG5kR0NRVUNTMGp2emNTTXVCdFA4VXY1SEpVWm8v?=
 =?utf-8?B?bzNUZ0V4VHdkVkgveVEzNTNEemQwNHdEbEM4d0ZHSEI1UzgvVUhoTW5MN3J6?=
 =?utf-8?B?SytjYlNobkxBNmVDSG0yVjBlUm9LTnRiWGtFdDVmVkJzcXNDNGFoWHJDenpB?=
 =?utf-8?B?dXFVS2ljS0V5NTNNaUdQcDJNWDBSeDJkVzFudW9sZ21UVm1vcDlxTHl3Tzdk?=
 =?utf-8?B?Vm9wTU52TlVRRC83d2Q0YnIzVitjdGUzQ1NrZXJjZXlqZFdLSHpwM2pjK2di?=
 =?utf-8?B?bExIeXFBNTE2cGk1d1Nya2ErWnBnQzgzTUNFTHAzT1pGZXNsVXNhRlpMNmhr?=
 =?utf-8?B?bHZ2QWllSDhIV1Q0Y3NHTWhRK21NZEtCYmFjSklYVzg2a0N3alRmaWIrNTFs?=
 =?utf-8?B?Z3hWemNxaVJWWFltcWJ5aTBLaGlWd0phWEtmK2k3bGt4ZW5zSXVoMnZnaVBD?=
 =?utf-8?B?MkVSWmozSVVFKzJ1V3dWVkJHRFJ1eStrRnc4d2hrNExDV1FsOC9ETFRhY3p0?=
 =?utf-8?B?N3JDNDF4bThEMmEwSHBTclZoNmM0R3haQkp3VjMwTVc1QmV2bTZQV1R5RS96?=
 =?utf-8?B?YWJSVUlRa041TGpGTjRNbXB1cmk4NUtBbm5Pb0tYeTVhMWlHbW5DRmpNd1hH?=
 =?utf-8?B?OHN1T0VCSUpkeUtXZGdHNFJoRndZMHFMbm4rRVVzaWZWNzQyZUFtZEZBZmdq?=
 =?utf-8?B?SjlUQTNpcHVxN0hRSCtDUlhHelZtalhyTno1NUpGN3hPY0F6d0tVVHgzM0Rh?=
 =?utf-8?B?VGtYNjNReW03cjBFYTRQVFdRcXNsaHhqaDVSU1R2L1BaVXA0OElscThMMUwx?=
 =?utf-8?B?UWNELzFtZitnemN2bDhIcmdPYzNxblNHa2hpNmp6WWltUzREZmNOM1Q2cjFv?=
 =?utf-8?B?ZEVNQnVNQy9nMHRLQkY1OHJnWHZKSElFQk1ISG5yZUlSU3NsMFZJMk93UHFJ?=
 =?utf-8?B?c25LM1h1bEhoQzB6dHJ5c1E1WEhuV2pLTFJLbzdUM25JM1JUcy90ZytzbmtX?=
 =?utf-8?Q?3Oj4rlBO9cZL+DZbcXq1V9rpk?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476863d6-3157-45de-54b1-08db6e6944ee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:57:41.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTSqhdOJeOCJ+VJKE0ID8rDcZ+FyVhO2GngDt09D0GfMDzIZVV4I1Wdq94qZq0n3QSd+gDuy0ZPBf6OJfwEgnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8502
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the comments!
Before sending a v2, I will:
- move all "reg" properties just after "compatible"
- give the phy nodes generic names
- remove dead code / review spi-nor-flash node

Am 16.06.23 um 14:39 schrieb Krzysztof Kozlowski:
> On 16/06/2023 13:06, Josua Mayer wrote:
>> Add support for the SolidRun LX2162A System on Module (SoM), and the
>> Clearfog evaluation board.
>>
>> The SoM has few software-controllable features:
>> - AR8035 Ethernet PHY
>> - eMMC
>> - SPI Flash
>> - fan controller
>> - various eeproms
>>
> Thank you for your patch. There is something to discuss/improve.
>
>> +
>> +&i2c2 {
>> +	/* retimer: ds250df410@18 */
>> +
>> +	i2c-switch@70 {
>> +		compatible = "nxp,pca9546";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0x70>;
> reg is usually just after compatible.
>
> ...
>
>> +
>> +&emdio1 {
>> +	/*
>> +	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
>> +	 * It competes for WRIOP MAC17, and no connector has been wired.
>> +	 */
>> +	/delete-node/ ethernet-phy@1;
>> +
>> +	ethernet_phy0: mv88e2580@8 {
> Node names should be generic. See also explanation and list of examples
> in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
>> +		reg = <8>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy1: mv88e2580@9 {
>> +		reg = <9>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy2: mv88e2580@a {
>> +		reg = <10>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy3: mv88e2580@b {
>> +		reg = <11>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy4: mv88e2580@c {
>> +		reg = <12>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy5: mv88e2580@d {
>> +		reg = <13>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy6: mv88e2580@e {
>> +		reg = <14>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +
>> +	ethernet_phy7: mv88e2580@f {
>> +		reg = <15>;
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		max-speed = <1000>;
>> +	};
>> +};
>> +
>> +&esdhc0 {
>> +	status = "okay";
>> +	sd-uhs-sdr104;
>> +	sd-uhs-sdr50;
>> +	sd-uhs-sdr25;
>> +	sd-uhs-sdr12;
>> +};
>> +
>> +&pcie3 {
>> +	status = "disabled";
>> +};
>> +
>> +&pcie4 {
>> +	status = "disabled";
>> +};
>> +
>> +&pcs_mdio3 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio4 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio5 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio6 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio11 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio12 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio13 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio14 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio15 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio16 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio17 {
>> +	status = "okay";
>> +};
>> +
>> +&pcs_mdio18 {
>> +	status = "okay";
>> +};
>> +
>> +&serdes_1 {
>> +	status = "okay";
>> +};
>> +
>> +&serdes_2 {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb0 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
>> new file mode 100644
>> index 000000000000..49e03b6600d6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +//
>> +// Device Tree file for LX2162A-SOM
>> +//
>> +// Copyright 2021 Rabeeh Khoury <rabeeh@solid-run.com>
>> +// Copyright 2023 Josua Mayer <josua@solid-run.com>
>> +
>> +&crypto {
>> +	status = "okay";
>> +};
>> +
>> +&dpmac17 {
>> +	phy-handle = <&ethernet_phy0>;
>> +	phy-connection-type = "rgmii-id";
>> +};
>> +
>> +&emdio1 {
>> +	status = "okay";
>> +
>> +	ethernet_phy0: ethernet-phy@1 {
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +&esdhc1 {
>> +	status = "okay";
>> +	bus-width = <8>;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
>> +};
>> +
>> +&fspi {
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "m25p80", "jedec,spi-nor";
>> +		m25p,fast-read;
>> +		spi-max-frequency = <50000000>;
>> +		reg = <0>;
> Fix the order of properties. compatible is always first, then the reg.
>
>> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
>> +		spi-rx-bus-width = <8>;
>> +		// spi-tx-bus-width = <8>;
> Don't add dead code without appropriate comment why it is dead.
>
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +
>> +	fan-controller@18 {
>> +		compatible = "ti,amc6821";
>> +		reg = <0x18>;
>> +		cooling-min-state = <0>;
>> +		cooling-max-state = <9>;
>> +		#cooling-cells = <2>;
>> +	};
>> +
>> +	ddr_spd: eeprom@51 {
>> +		reg = <0x57>;
>> +		compatible = "st,24c02", "atmel,24c02";
> Ditto
>
>> +		read-only;
>> +	};
>> +
>> +	config_eeprom: eeprom@57 {
>> +		reg = <0x57>;
>> +		compatible = "st,24c02", "atmel,24c02";
> Ditto
>
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +
>> +	variable_eeprom: eeprom@54 {
>> +		reg = <0x54>;
>> +		compatible = "st,24c2048", "atmel,24c2048";
> ditto
>
>> +	};
>> +};
> Best regards,
> Krzysztof
>
sincerely
Josua Mayer
