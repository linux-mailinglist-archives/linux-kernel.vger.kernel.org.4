Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6856C4A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCVMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:16:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F91C587;
        Wed, 22 Mar 2023 05:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDfsSeYirTwMVPacvVnYm6/SYt5lCWfNQLQNyy2gfYvrCeJRUlNlQhq9G9mGWDHwH8PdVZplqXtByckJeGIYXANNVtvIAcZSvqIH++zM2oVbxDcgCQdsuAC+3fC9DboB7eQpefLdPZagNyYAkvLYlqH61H9fNzqhNm8BE3yKKjeAhPPx/5lpLkGzdf4rRoYLRt+cikijr2OhgnzgZwUP3jsZ7bCaoyC5w1U24mOQppPMuG1PKMuLgC1aqiGVhc6wrfB4u5m7vTZgFq9UccKQFJm02w2vDYn8k6dWYZ6Jsiy8MFAwptk+If7B5saSYjwdOzLC/REngkcd+lcyKC3TeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh+J3hB3c/ZZPD/o9hi+r2C3MO/ORnrK8HHhvFfDE/w=;
 b=mdeNmKmhxiU6FS3Y5TVXA+lCGOm4kGlhQ+AILNioScZ9yTGXX4O4yOwEkNINeGAXoVrDjOF9M+QgYA1ggCtLlPg6z7mRGaSOpHHftwn05ZaPK7RDMyfwDdMVFNFVADxxw0eokToKtZ41TaNdMg6uiXn4XaG2fJWkdH+qHc7FqVejtEGpSlAKexSPsrPz67zDiFKENznKxx0O0MHPU/p6a64UpHcoD4J1rU88kGOj1RiFUpeXuxXvibtRUoa0CdFTC3B2NfE5Hx6+z/lK0IvLSqs7mXH5p6s2WR9b83oJzFPx8K7sdz+KMFWPpd62/YKA+60dMLgs8pmvrSBsi6wPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh+J3hB3c/ZZPD/o9hi+r2C3MO/ORnrK8HHhvFfDE/w=;
 b=HrFrBXEDjCGwsvMuDpeeTmjK2PIsCGubit0/wN7cHOOCxWL0LraHtyI83o2RX2+N4Ngb0g9wZRzSYx9+uaRkH4rCAdGdD16izDkFQOUBLPp+J/F/XZq+YK/YAXkQ5E8KH8WSAQkigc+o+FEkLEKkLNI9fJ4N8Bb/KnOhH4dpcao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 12:16:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 12:16:13 +0000
Message-ID: <0c7f583b-ad19-3010-f7a8-e6999f5477e1@oss.nxp.com>
Date:   Mon, 20 Mar 2023 13:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/3] clk: imx: composite-8m: Add support to determine_rate
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230319132120.6347-1-aford173@gmail.com>
 <20230319132120.6347-2-aford173@gmail.com>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230319132120.6347-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 141410c8-c4e6-4d7c-e353-08db2acf3a16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFHOEqYMNpuFrngxjIjhRu4eCLawS1D52PMX0LKswznP1XrBB2VlnriQKacaBX0EPQo8izFDJ8o+mvQTEDHBfA2uSHSK6tf1teWYyYDjWWXJVMPoUOiQGJiD7yNjFbgZ9yUVYdyEw9FnjLUQj0r25m6preVPqzbBwOHFIkkT6Mez2u0K4E79HwXkMcVq/WBG6uQFfdu6Htau9OvELM4aEhjDnexrXjam4NjztJkglEM2tGR/tv99f8tZVWWSMOYdlrm9XCr+71dcFf9FpWU9h6c8IRXhhpyLOMv2S0tsI84u52wg1FH16L9VssQs6vKK3VqVvW7P/BGj+wDGApArAXrmHVVu+QXewKqQbM94OwmdoiPUIF+Iai8nZwaJjpJ/m+EuYsIVjFJWuB+rbhvKC6fFAqJ7g25AdYflzbKyJ1qSVMbqoqe9PkOmXTEChCqX8x/UKK79kjl0S7BLihKGdu1ksJd4wz8hInnfnuXQv2TEbRYvkE/Qci/wkwJ1KEiA/TZbJhSGFY1rGah2OLuNKS2KbUHZ8Z6OCSRQTmHQ31qYbSv3sXLr8WFtltPOaaBEfiPqtKXcBnJRetn7PhyRfG15Ud2Y1QseP1giHdar7rhXaeHCqwtfE7zD4TVjlfNLrwedtQsHG1Y85KLoAQKlZdyi1IionRvRuC7B8PjkSFnNtM6umI9w47gejyvKaIUbNgk/4lDPbN/UeIts6JMhtSC7yW1g85j1JB9ow5mdwsBdx0QBuB8kUZLUoRzXbG4diqVsqSlF4MQXw0PM03tq0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199018)(31686004)(41300700001)(5660300002)(7416002)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(44832011)(38100700002)(38350700002)(86362001)(31696002)(52116002)(6666004)(26005)(6506007)(6486002)(478600001)(54906003)(316002)(8936002)(83380400001)(6512007)(2616005)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVR3cVNJa0loWGFQdXpLZExiWUJENDNpT0w4Wlh5RWd3eWg4UnRtREUrN21G?=
 =?utf-8?B?L3hxeElRUGg0Q2VGT3VGb0tKRllLMVdwSmhrMHlNMTVjck40WmVpY0g3OXFT?=
 =?utf-8?B?eVhXbFEvaFlmT2ZkbEFIWTN1Njd6MkFaU0ZEOFIvM25oMXNuc000Nk94MVNX?=
 =?utf-8?B?WjQvNHc1d0FrbTlweTNDQzZIVTR4ajY0STdvUUxzU3Ezd2xDamxsUUtMMnZ2?=
 =?utf-8?B?UndPd01TZFVzeUcrOWtzaWtUTFhzL24rU2kzQWNGNXdYRGw3Q0gxQW5KM0pO?=
 =?utf-8?B?dDN6SjBjRHlHbFg3MEpoWnlTcGJDRVQveHBLemcyT3RvYktYYThmQkJieUVn?=
 =?utf-8?B?a042UHRxdDh1MEV6NDZoWForcE5QdDhESG1wcklIVG9HNTNoYkEwajBTYjNV?=
 =?utf-8?B?Yi9SUFhtWjBsVlpVLzBydlNTcmFnTVUwdUhQb0QrOVFHUENGRkxKZmpXb25j?=
 =?utf-8?B?RnFzZVplelNlbWJjZGpBSHFsUFBqQlVXZ1ZyVDZ2UTlWWGtLQy9Uc0ZCS2Rp?=
 =?utf-8?B?ZmwzQzdNVE5KVzBtck5pclBrUDJHQmZ1RXp4SWxnL1pRR1VHNXovWW5GVTZI?=
 =?utf-8?B?RURua1NVV3k5SHpZWWVZakcvaThMZWoremZkUks5OGNJQ1JEbVlsMTYzMEtu?=
 =?utf-8?B?MlE3Vkk2U04xK1BJdVRXd2JYS3BYdmViUzdNN0lHRG0vTlRINDFRWU9QUlov?=
 =?utf-8?B?Ty9XMFFDSUVvTDRRRlZLOER5WDNoNlQvNlQ0SVhYU3dmdzFDS3RJRWQ2MUxB?=
 =?utf-8?B?ai9DMTN3aXpyRWFsa0t3QzkxVEZJbTNRY0lzcGMxZDRLcEdCNEdIRzFUaDJv?=
 =?utf-8?B?MWVUS05zUjlKeitKa0t4SGkxdE5lMkRXNWIyMVlQd2hzcHE1UFBXL2l1Y2U0?=
 =?utf-8?B?c2FLSGtvWWE1R3dQaUh6eWp1OGRhd3AzWXRzYVFZUzJBYWk1OHhRNVVTbU1D?=
 =?utf-8?B?TTdsQ1BvL0h5TXp5b2hLWWZXV013bE8weURnWFJlZU9hUnpqV1ZXbTV0YkEy?=
 =?utf-8?B?Y1J2ZVpoRHNBNnlPVU1yMmdTNjZ2Wlg4U3E4Q0dhWnNWN1ZHSko5U3FIZmhl?=
 =?utf-8?B?cTkwcFhUa0ZCb2JkUTh0Um5SQ29Yc2RNTFF5Z3BBQnZTd0NOcUxFYmtUMFZZ?=
 =?utf-8?B?SUJCRmFvNWZKR1FXcE9zZ2gxcG9HczF4ZDc3VmpRWVBtVG9IT3RDMmdxUDAz?=
 =?utf-8?B?SlZQL2JRV0Njcjg4cHloU1RKUlIxTEJ1WVRMME9yK1I4THZjMHRhUUE0Tm5u?=
 =?utf-8?B?MU9nWGFsZGV0SW1FanpkR1Q3Yjh0MmU4UkRJZnBnQmYyVitUMHhLUC9kZC8y?=
 =?utf-8?B?UG9OR0h6K2tXN2FhSS9WVVFlRmNDeCtna3kyMExLTUo2cFRYN2ZYOW85TFk3?=
 =?utf-8?B?MXNBNGt3UmgrRzdNUDIxSHBpYTNmTTVQVllPTGkvWVBjVTRzOUJkbGJCaVFU?=
 =?utf-8?B?bG5DLzZsN0tNSkZQUjZYUWJ2YkNwWDZuak1rakJOeVlUd2txdVFMeUsvajFz?=
 =?utf-8?B?UFFyVkVBUkp2SmE2bWR4TzdMVStSdUt1R3lhOGZCRVBqNGorSm5YMTFacVB1?=
 =?utf-8?B?M2llYkphVmJ3S1dXQWtHbWlJTWRBeUp1K2R0Nk5VM05BTGZDczJhbXUyYnRF?=
 =?utf-8?B?OGpxckxVamNhck5Zak0xbGcwTzNTeTU3a2JUQ1pLV3NRU2RyMEh0YnpzN0Qy?=
 =?utf-8?B?ZjVkZ3RZOTFOdWppUVJUeE9USlk0VHd0a0VXNlFpMVNFN1RqZ2ZjaklmUEZs?=
 =?utf-8?B?QjBTSDQvK0IvUjljQ0FwMjU5TEVreDFBVUNldGswMEdiRFNoQXJXMUYrakc4?=
 =?utf-8?B?SGhOUTRaNDRWU0Z5VGgwai9BL21HOFE0UjZDYTk2L0hmTDFodlo3YVBuRTVt?=
 =?utf-8?B?WFhkMEIzOW1WWE5GSTdhSXZXNGVaMmp2a05WdThwLzByOFNxWm9xQm1McmNS?=
 =?utf-8?B?Q21peHUzajRLMGc4TkN2VmpuTEtra1ZKVUhQR0JDL1JCbmlmTjNENTdGZmNv?=
 =?utf-8?B?RC9mWVpGRlk2cTZPcnFRNzFmcWZkUkQ3UU80TDZZYWZ0MGZvR2RNTE1DaDl4?=
 =?utf-8?B?amYrVGkyaWhLQm1yRHlYOFd2NVJ2aTA1c2t1eXJlMWZhU0RTN0JRRXp5enRj?=
 =?utf-8?Q?ngIC+nPkxARp+UuQ6UQQGMp4n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141410c8-c4e6-4d7c-e353-08db2acf3a16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 12:16:12.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZK7k1VJD7DbNE92thWSZvtHheiowLlBdjkQtf4PAu8eq5UhXumPeBZ9lqifoIlZfD2z1btjUFQYh9ulMrxyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2023 9:21 PM, Adam Ford wrote:
> Similar to imx/clk-composite-93 and imx/clk-divider-gate, the
> imx8m_clk_composite_divider_ops can support determine_rate.
> Without this the parent clocks are set to a fixed value, and
> if a consumer needs a slower reate, the clock is divided, but
> the division is only as good as the parent clock rate.
> 
> With this added, the system can attempt to adjust the parent rate
> if the proper flags are set which can lead to a more precise clock
> value.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index cbf0d7955a00..3b63e47f088f 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -119,10 +119,17 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>   	return ret;
>   }
>   
> +static int clk_divider_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
> +{
> +	return clk_divider_ops.determine_rate(hw, req);
> +}
> +
>   static const struct clk_ops imx8m_clk_composite_divider_ops = {
>   	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
>   	.round_rate = imx8m_clk_composite_divider_round_rate,
>   	.set_rate = imx8m_clk_composite_divider_set_rate,
> +	.determine_rate = clk_divider_determine_rate,

Please align the name with imx8m_ as prefix. Other than that:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

>   };
>   
>   static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
