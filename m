Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735769E07B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjBUMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBUMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:33:47 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2029.outbound.protection.outlook.com [40.92.52.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FEA5C3;
        Tue, 21 Feb 2023 04:33:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ10w2SBOJ4kmqCIAZVsL9gDAZ2tzl+6E6HwgbvmLeC0w5D02qMCzN/kpfa7m6yKZl+I2BJz750wUowf0s2RQU3fwkVAqwixHxcBqngC+PWTB2/Fmv4XvKuh84EPDKQUn+uIHB2fkDeuvwsARoixN4IV8Q4WOuR7MTg4xoQV5f1/tZn/8i4ZX5tUfD34zzH/VlOQ8A2yJS+Wx0kSunwXEcsDkJu+9bNRTtrHPzuHLp52FLgp2yEC5iLy1lXQS1ywrFB/WL8/kVi0sdcmL5fo0j7Od7UHNMi5f6+FJzO9xvJR2zRC+mWIlb193Z6JYXtiikko9kf1aMWYAXB+AeWjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OCZHjF49yzkLs3XX7FHlBh67u2Wsr4ep7dZkQWN/A4=;
 b=C8n+pe/srwrhaZrqeZB+cZB6Pucwtnaie0w6431AT6QQzg0p1Pc3ziV+Hi6EwSA/8RdCdPgQ0Gk1rg5Mk0FqulUw/jB/4t8FTSrLsaLK5HUZm4g8o44v6bjfbl+JETSVc75825WR/6kajv1t3WeOACJt5GPu9NqPjK/gIUFLoRvwfBn8OFqB3NP8zUpti0Ue0mdy/4p3W79dslhlPsVlExqwu2ORNQV0o9mft7/S2amBNx51GMFfgNIH9s2Gg+UCbmc3QQlPjLce7rAGW/B863JZoSg513wpqVkdqDUjhSCu688bRLmpOGwED+IG6XOaXU7Sjx3G3DdIyNC/aZtgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OCZHjF49yzkLs3XX7FHlBh67u2Wsr4ep7dZkQWN/A4=;
 b=tRD/rgpqvJ6+kZnjWzRXmak6RGeZg+d4Xg8Z+kC4LMaGGOSJgs0jf44ONwKtfzM7F9oQbo1KAi0EWJ30ms/7ppSfJOjjPqGYO322Gi72KB0XA/wwrWUYQS9UvfCe0Fm9N0nc3ZdS3dcsN5mysup7m6Dty4UQNjrB69R3s0hU3541R7v+mPTQff/wCR7Mp2PhcEGQpZr8S94h3nCkCsvpXEO0GJqmD/sNCYzmuCLG/N1Fp6puUPukwF+pqpmonPzQ3ir+K5L6FkF5PNGGqWnRtxcpZ8vh4atysTd5PQwl4hCVLzNij4w8BBcmySFW+YuCuzMbDpFBkvfSO78cMbyr9Q==
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12) by SEZPR01MB5110.apcprd01.prod.exchangelabs.com
 (2603:1096:101:e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 12:33:41 +0000
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa]) by SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa%6]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 12:33:41 +0000
Message-ID: <SG2PR01MB2048B375B64A96654FA20DABC9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
Date:   Tue, 21 Feb 2023 20:33:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hminas@synopsys.com, fabrice.gasnier@foss.st.com,
        amelie.delaunay@foss.st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
 <Y/Sf8j5y+DJ9L4fY@kroah.com>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <Y/Sf8j5y+DJ9L4fY@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [XWndIz0rk9IKju4OixCaf8uM79lGu60J/unW/i264opFzQLC9Y+kempha6RQDZ8T1kAb2Mu1K+M=]
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12)
X-Microsoft-Original-Message-ID: <9347cc90-5f1d-3ca3-6a7c-1374468ec2bd@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB2048:EE_|SEZPR01MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 70edc5e7-a9d3-45b1-ede4-08db1407dd53
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a98dohsIdcwzqkcOz4NnjQk3IKEPmYAkkESF+4bheXc4QLYrVTHpU8Ncg4VGnr2GaCs3mvBBU87UwZcxRPPwwSlRdteRw63ZDUCTGu0RcA5Dmp8+SiDPzOnyOYGXxSnY2HP+nLFgDElXl+DccwXBCsDb9zi/Fd7gnIzbShe3O+opSG+As1xrnnJQneERomdQmUtAxnKX9GK5TwXEAMu41TI6/XgZoHncgVAXog5ib6KHn0mn0QZk7ICi/J8CG+K+Z2lQ5tU9oqQDJanUzV8ay8TyiGhA3g2gasLIDDWEDf9eLpQWWv79HgvfhYKZxmJOL5gUhu0HXWqeug4MriOcRJsb4lJRrdPipCXg2bJQz53trTuVHCYBFC65zXXH0jR+JvHygs8A80YB7+Rg6gyesZxg51U34bkkhGHJ7iYAL0irj7i7mh61Fp3eDXXwHs82Jf83KfGyUqsJ/67hZd9vuhOuvIDDPWfckisCZmsu6+76Z3cxHx+hoUPoKMOyNwUUxMtZrSlQA8QRxt4Ph5DzIqfrs/Q2+rhRF2DOO1vHM/OXGYx5QeZR/otvtX+ZSZgomg6P1DGV2O6/gehTXM32LZcVCLYHvohEP1a30y2UunkkJemYqGkmFQAWtOVis4jPTHq1lNbC5XBscyuJNKusrA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXh2YmJtRklTWWllNGQ3ZHR5SFpXWE8rWkhnQUlHNCt3Qk5HN2c2OHpRMGRa?=
 =?utf-8?B?aStQNEI4K1JUVnQyQzZVSmF2SDlDVldjRE9OZUQ3bDQvc3RMVUNTd0dJWE9F?=
 =?utf-8?B?YXM4YjM5RUtJZFF5UWhicVpXSUpZdlAyWHpLQld5SVJwUVdaSDRsVFlXNkxs?=
 =?utf-8?B?cCt5bjNuQ0ZHa0FRejZrY0w0NEtyZVRXRllya3I5NlR0R2phZitnSTlubHBz?=
 =?utf-8?B?L0tMMzBDZVBzamYvT1VpYVhmS3UrZHkwQWYwODA1TSs2eW80N1ZJYUNhSHV0?=
 =?utf-8?B?VWV3b3dqb2N3aHlqcHllRHdxQlhpLzNxQUZYdDZ0UzNUV0htaXR1NWJYc3h0?=
 =?utf-8?B?amhVTE1nbWdLckdtVXNHNTFxejVDdXVybW0wVGYweGcvMGVoMU1lbndFZ0xV?=
 =?utf-8?B?eXNUaS8yME5wVmMvbFlNakd2YjNaR1FLQ2hLNThieWRUN1dHNW5acVVXYTVR?=
 =?utf-8?B?Zm50YlJoYlNFTGQ0eWJMU1JES254MFJNZW9WcUFTakVUZEROcWg1VUlZSFNE?=
 =?utf-8?B?VVBsbCs4R1ZqWnd6T0pna292VE4yYkcrRFhpS1lhNEprbkJwZXY0ZVMzTXkw?=
 =?utf-8?B?c3dnY2hhYWl3WU9kVVQrYTllSUZWZHNRc0hBZU1Rc21JTzA4amZJcHcrMkRE?=
 =?utf-8?B?NVhRR0lKWHBOUnRaSThmZk5WdjhYVzhPOEZhWTZid3pTdTBoNkM0bldRbFM1?=
 =?utf-8?B?bGwxbWY5Q0tJNHF4dUdJN3VXT0orRXlqSmdCYUFMOGFPZWFxeXdoNUxnTmhY?=
 =?utf-8?B?Z1JsaC82cC8wTytaZUZnU2VabGtjRXBFVVNVTnR6emNWSlZobEFoMUJ3ZFZL?=
 =?utf-8?B?aUE3SXhPM20vVkw5SEl4dVZXWG9SbnU5WmhnSk41UGFaYmtvQmFMSWRGWFVv?=
 =?utf-8?B?N1A0em5WYWsrU2NqSHhoL1Jrbnl1WDFhdkt3WEpoU3hORllveXVWS1I3UVpW?=
 =?utf-8?B?a1VNNGNrdEptQnNqTzlIK0FhQm5LTHFYbGdqanNBVDEvOS9UaWw4RXhwNHhN?=
 =?utf-8?B?dGhIRzBnQkZkM2VOM2J0RWQvQTZCSGRuWVJka2thb0FPMGJQSHpvUCtLeU50?=
 =?utf-8?B?QksxYUY4Y0tCNUFxcm1Sem02cnNQSitpb2JDUFVkQTZ6K2FuRHBaaHNXaHlO?=
 =?utf-8?B?UkdYQmhtbGs3YjViSm9EaXJNL0ZINGdEVmpXeWZNVkYzT1h1eEs1Qjg4bGxL?=
 =?utf-8?B?aldGRU1BdGZhTWxGamlIYUE2Zjh3dXhNR0gyaVN2a0NxYXZoVTQ4SXk4U2dw?=
 =?utf-8?B?eW5iU2JETzZzUVF6VE56aHZtVjV1VmpOTXVLZG95Um9vQUYxOWJkRUJYYTEw?=
 =?utf-8?B?K010dTdtaUw3K2tSUnB1dWZNWUc5YStzTU91Tjd5cEpPd1NaWVZYUEQwdHpL?=
 =?utf-8?B?bVo3SUtuNU1vVytZQ2FWdDlkSmYzbGtVY0NKZEJiNmM1TW95MnBhOTVqM0VU?=
 =?utf-8?B?NWsxOGV5VjI0SkdkZ2tTeHE5M2Z3WjV3NmdqOEJBelZzdXZKVmxwbEM4NCtr?=
 =?utf-8?B?ZDczRnZkSTVFd0RydGxRTFdySm1MNzgycVIwYXViRnIrSHljdlZPRW5rSjUx?=
 =?utf-8?B?dng0Wi80YkZrNVQxTUcyTDd2Uy9GREl1SDlvR1psQWtmVmwraGJRdmRjWXhH?=
 =?utf-8?B?S09DcFNrTzJoU0Z6WjhzRkpuc0M1YWdyQnZXYkRkTVpnRkIzSmRIcVZ0ampm?=
 =?utf-8?B?U2NsY1lhekhIbjBKNElCMmRQcmp1bElwTDgzSXlEQU1RR2xUUW1tR1NvV3Mw?=
 =?utf-8?B?MEZDVEdINDJSVGp2RzJQWXdaa1ZKdVpzeTVJbDlSUlIzYVREeWRCZEZVRjJk?=
 =?utf-8?B?L1NuRjRKbzEvMlo3SmNNZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70edc5e7-a9d3-45b1-ede4-08db1407dd53
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2048.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:33:41.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5110
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/21 18:41, Greg KH 写道:
> On Tue, Feb 21, 2023 at 06:30:04PM +0800, Ziyang Huang wrote:
>> Some boards might use USB-A female connector for USB ports, however,
>> the port could be connected to a dual-mode USB controller, making it
>> also behaves as a peripheral device if male-to-male cable is connected.
>>
>> In this case, the dts looks like this:
>>
>> 	&usb0 {
>> 		status = "okay";
>> 		dr_mode = "otg";
>> 		usb-role-switch;
>> 		role-switch-default-mode = "host";
>> 	};
>>
>> After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
>> dwc2_force_mode() with parameter host=false, which causes inconsistent
>> mode - The hardware is in peripheral mode while the kernel status is
>> in host mode.
>>
>> What we can do now is to call dwc2_drd_role_sw_set() to switch to
>> device mode, and everything should work just fine now, even switching
>> back to none(default) mode afterwards.
>>
>> Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>> Changes since v1
>> - Use corrent name in Signed-off-by
> Nope, still incorrect, please use your synopsys address.
>
> thanks,
>
> greg k-h


Oh, I'm not a Synopsys employee but a free developer. This is my first 
time submitting a kernel patch, please excuse me. Thank you.


