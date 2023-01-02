Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4713F65B177
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjABLsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjABLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:48:13 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093FD64;
        Mon,  2 Jan 2023 03:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m72Ir9kca8J/qJ9ANbTpi58XpGmx6w0ig5MkdiDA4pV63GgjcGdenxvfWCkd4/dM0h7dOjmZEzjJ+Ia0Mg3hne3x+s0vn3KQK6X7h7wmkc1FudJnsO+k9CljJD3Lor4pw00jUVygFUiJHMHa95IFUFhjHEdx/1fXpbShmQNaR5KlzC0IpNaIcZbtItva5KlHAfOX1mPKoGhJXuKgtkrAvncXM031HXyrdO8EQYeO3sGZ4q2pWzwVJMxc2SpN9bVTsdHPeAh8kmreIqKT3ObvCGSuaDUAqb8CcNaoX+5/wSeJ51S2bnWwnX7I8PUfbW6YZr6dkI/YaXyBlBrnTkhtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEYuZz3zEFvmN1kh0ZLAFgs6sq7oeV+6QqPLV7VJrS0=;
 b=lEiBWAKoDZEOEMH/Ra6ZsOuwxhCVvVXZmm1A2QnvYvlf93U79ZORpjOufSOtivmfMevMk2KIODLlKZWDPWH+68AGwcdT+KdD39WNc+PmZIQNrjMLO9JEivsc651SYYw8k67dZWW0CNczabUqGg9ovdL/9qVc/KrJQQDtBcl2TPTevU5qobUIHUHmmk4c9zqt6C1q6mo4LZEmkltLgUfGFaXvOe83nc+PXTspbKJA7PSNihbwQZDUvJncc0XncpF6YBGtftnH7HZTsb963SCAXUuxaT3jFli6IumKe5ZQNPok1h3pmPhX1OPL5+SSPKLVLd5+qJyC8Qs1+5QEOGWfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEYuZz3zEFvmN1kh0ZLAFgs6sq7oeV+6QqPLV7VJrS0=;
 b=TX2Mb06wR5gPasVo1QTvbAy0pWHPSE7JOMMa/1ulRnTtNVyAhckQub65OJnYkf9xDjTdpbk8rJjmfIy92cn24QnC9L+12dg3LJ5B+TRXjkcZG76RXya8w+RxRzFPSl5suFzyJXbQh2avpSUzF+uFwQtY6jygo/GG8B3jNJmSak4iNVgR0u6cHht/4nhy3ie9poISLQ67lGEsjY3xKtL6NuPEnKk6jKoYqykZENj1rryT0C6kPIAtK99ZomOZMZQfj9bOobz+JyOz+ber5fbxzYfiFZiTmUBt/EdyvITTJLcxBnDzT2fX0P1PDTdpNN3GPqPpnbscuIXMGZZuiqWrRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 11:48:09 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 11:48:09 +0000
Message-ID: <69dd964c-c015-7ddf-4df4-4f2cb7b157c0@theobroma-systems.com>
Date:   Mon, 2 Jan 2023 12:48:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] usb: dwc2: prevent core PHY initialization on
 Rockchip
Content-Language: en-US
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bin Yang <yangbin@rock-chips.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v2-2-0de821615dd3@theobroma-systems.com>
 <BYAPR12MB339982A244FBA1178423E529A7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <BYAPR12MB339982A244FBA1178423E529A7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0078.eurprd09.prod.outlook.com
 (2603:10a6:802:29::22) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b743d20-b825-478d-a385-08daecb73843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyXFjoTjrIH5dZnjwPiTYKhKlxxZfx3DRH1bcoOcIYUWS8acuy0fcBZ/4AdWfPlR0nneSgLZhQIXHeHaon92X5INo+6v598dQkJj3hc95bc0FmS7d7OImjFc+GwZ9G+fGSyyAi6WQ12kBhIFGsWEUm70joYYzzRybmg9qgVGAsDnlNt0OCpSwj2axlMKdeVKwGA0GAILwxr+H6BMuHcjm0mBWhzFHy8nqNbku/JIoe9ZrIXmHJGe0/4RXj18vRNCN/+UdhvLgwaguDH8NJph27E5uhGACowzIomw+GlCuPIBu2yF25dt1lxYM5XVK76/3k5D8ia5928yhhTRcxeumjsO93PmhLMhsEikszC3ZUSXJzOXqVosaMpH/45k8LcnSf+fPeLWSS1+IE8RX6fBBeVh2aEetnOw1h0FqfqRbFYbOWmFSzTjcEcsrdXI6kzWIqXX+Ze1xe49rFm9Y4ZEcRtHUg1sZstNDmf4rOvYXstWYWzNsHfNsITW7LcE+OZjnjom5xVjAHJYfyaj3b7zg1fBhlXIvF3XxyDv/Ro22uOLJAl/jnjXafq4QGiBAPr2Y+UK200xnjz5oFkLDgimjLGPhF3r17GWqd6eFcZjZx1FSLr8WPvgEsXb+B14JXhAerrPuysNEYyoW0hmyVy2DOToWWGZ+Y1F2e/uJr9wML2nexyU87NOTcMXGm1hP6iQZ4gY7cX/k+Wb4thyig0K/CfSic+9fRYzfYojfRePGJ7Ld/vWKvAWhfmNtieKp8Z/D1AVMoT2pAJnh2zUJiKPhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39840400004)(396003)(451199015)(83380400001)(2616005)(31696002)(86362001)(36756003)(38100700002)(2906002)(44832011)(110136005)(54906003)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(5660300002)(8936002)(186003)(53546011)(6486002)(6512007)(478600001)(31686004)(6506007)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Z6cFp5MUFucHJYVFZMYU9wQ3BrVnJUeXRBdkY3RkdiMWxLbHJkZk16YVhZ?=
 =?utf-8?B?dGhzL1dWbUxCSUJJSXhwVkZHb1FSZmNla1d2TW11Vjd0L2t2SGN3ZjFXQkhK?=
 =?utf-8?B?eUF6cHFqY1ZZR2JqSk0ramRpNVdoOVdpblhvdk9STEtSWTR3eXFzaGpwWVJS?=
 =?utf-8?B?U3NqdWtUODRUOFNpSTM1dTlUam95ejV2RnAybTVHNXVHWUtmaHdDVkNhQTh0?=
 =?utf-8?B?cnRPSmR1VzlKc3pPZE1oRkQvK2xacHhVUUhJNWQyOUJVYUM3czhRbTUvREhy?=
 =?utf-8?B?NGdWWlE2UGIySzlNcnFRUDJyeXNxVUdUeENCTFdoYUVLNUg5RStQbC9YN2VM?=
 =?utf-8?B?WnV6STZ1VDhBdHRKUG84THcweTgwaTZCZzNkSTRMYk1uZTcxbWxVOWhrWkI0?=
 =?utf-8?B?RGdLaE5VczZFaEJPNGNrdmkvNFByYlpQMHhOclhTcVBqSjVEYWhqbnlQMmk1?=
 =?utf-8?B?SmR2RytLbXd3WXNQeWVDLzdpWE5OdURQNTREWHVSbkZHMXI2RXhleWkzMmlj?=
 =?utf-8?B?aXpVV2d0c3V2Nlk2eG5jNkN6bTZrblFYOG8vNUUvQi9vZm01djdSVTJoais3?=
 =?utf-8?B?NW10aklQL0FMakF2UDQ2T1E1NE9lN2ZOc1ZTNUdleHRheDRlak1Rc3VxNEoy?=
 =?utf-8?B?bDdVeEMycVEwMGtmWnJ5QU1vL0h4bnZES1M2cnozbVNVbGNQcmRJUjkreTFR?=
 =?utf-8?B?bUZZZEdwSkFwYVVVcnR6bmtaN1NFZjQrVDlnanFVdytXM3ovSXM2MTljMUZW?=
 =?utf-8?B?N3ZuRHJvM1BXRXo4VVA1TVpnMkhsY2kvK0pYMVJaeDhxOGY5NHF4UmtFaTY2?=
 =?utf-8?B?aDlIaFE3YVQ4YmpJWDhTbTBnNlVUd213bFdLSi9wV0VNenBLSnUwTlFlelF0?=
 =?utf-8?B?dlZEYUFqLzRqenE2NmY2YXhxVG4vOUo5MjBiUnZOQlBLd3BYalRwODE0R25k?=
 =?utf-8?B?cXRvWjZ5VDZXQTd0TzRmZDcrVE1ra0tFRk5TQXNwZ1ZiS3NzZzNlVWhHMi9s?=
 =?utf-8?B?SDF1ejBObldGL1diOGFJcFJLaTlaTk8ybHBIVVVYWGluZ09aY21XQlgrRjZz?=
 =?utf-8?B?ZWdObi9kWnZheDVPK3V2OXhXY1Nvd0JlRDIzNlI0Rml5cTlvaU9QZEZ4ZDNl?=
 =?utf-8?B?MUZEcFJIaEdudlpheWdZWXFaaGYyc1labCs4Sk03QUQwVHFReEtIU1dIQnM3?=
 =?utf-8?B?dDFYeE9ZbHJRbU1EcUNpUTJwWTdBUUZpVS9LRm5JeGcwaFhFbXExVnA4b2Rx?=
 =?utf-8?B?SlBtTWtLSi9oaWRCMUR6Y0hjcjRySWV4UkRtZEJTL1dMeVFkcXdFSEp4cyty?=
 =?utf-8?B?ZDRNUlN0ckZXM2Q5K3hJUW5yZnNLekU4MWRRTlpRdTVhU3lYRVdwTHZsb01N?=
 =?utf-8?B?Mll2OTljZk85Y3NWdm5TLzdIalNxd0cvY05Ody9ON0RSVVNYeitLZWNHZTNW?=
 =?utf-8?B?WVMxOUpuZERMb2lvNkVibmxRY2hTMzMwQXJDTWl1Y1ZWejhITTRMS3htWXJV?=
 =?utf-8?B?MW1xQWd6NlA3Tk9DZnR2VEQ3U2pUcmRJQ3ZGbDh5aFdpNFhMaFRaSWpMaFNm?=
 =?utf-8?B?YWljY1dsK1BRMlVodkZLSnJwb2RoajdMaDZ4S3pVRzNVbzhtaE1oZi8rVXM2?=
 =?utf-8?B?ZzVUZGNMWTdxYTl1L3VHTXNlNjFTcWVZSmxMUDRCU2x0dlRLUVpVRjhLUEpn?=
 =?utf-8?B?NnY1SWdPMVN6TlljR3YvMU5mTk5UMlo0cFdiRkJIb0lMeThQZVpCY0lkSzZE?=
 =?utf-8?B?SU52Y242SlBMNTB1eHVrQ2NUK2Y3MVgzeXg2V08yU2hsWWFlNlBRQ0F2M0RH?=
 =?utf-8?B?ZmFTWVhGU3dUVTlqNzZpODMzUmxvSGdjcUlQcitMNEpDaHUyT3ZKQktrL3NQ?=
 =?utf-8?B?a3E2VUJERUx3SFluODZZcmhTSmdOTlplT29QNGVwWTBkTFlBVE9DeFNHYnFu?=
 =?utf-8?B?S2EvNFFwdXptRTBrM28xdDRsYXI3OHJHRUl0UXZuWDkvb0RiaGRKbXRCbktQ?=
 =?utf-8?B?eUdlWFhYQVlZQ2NiUHBmZW5VdW9wZU1lU3JHK0x6bW8rWUV4V0VxakF2OVdR?=
 =?utf-8?B?ellaY2VsSkJzSmJ5U1o0bk9SejdoVlRteTBtZktNblNtejNxZXgrOHF3Zlh5?=
 =?utf-8?B?UGk2bmpmTC9UY3dDNStBd3lMQmZ2ZW1nT0ZhakUxZTYreVZrUkFiWDF1cHYy?=
 =?utf-8?B?d3FVYldkRGZ4VVBzNFBaNTcxNnloeDlFeFNCRFRaNG9QdGJ0VDhEb0Nuc0VK?=
 =?utf-8?B?TS9ldFpWQi9COFgyc3JwOUlyV0x3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b743d20-b825-478d-a385-08daecb73843
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 11:48:09.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10Nsh81Xal3L51wj0EWZpa/9sky89NeDvdMnrVbF1CrP1Msej7AASJzlAYT/ht5DhlHG2bcVM8LW4ewbHJK97+AqYVAmosH26mPTfIi2adt/QhYD0S0ZoArHPDbOpfE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 12/20/22 07:02, Minas Harutyunyan wrote:
> Hi Quentin,
> 
> On 12/16/2022 8:29 PM, Quentin Schulz <foss+kernel@0leil.net> wrote:
>> From: Quentin Schulz <foss+kernel@0leil.net>
>> Sent: Friday, December 16, 2022 8:29 PM
>> To: Minas Harutyunyan <hminas@synopsys.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>
>> Cc: Quentin Schulz <foss+kernel@0leil.net>; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Bin Yang <yangbin@rock-chips.com>; Quentin
>> Schulz <quentin.schulz@theobroma-systems.com>
>> Subject: [PATCH v2 2/2] usb: dwc2: prevent core PHY initialization on
>> Rockchip
>>
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> In Rockchip vendor kernel, the core PHY initialization is disabled with the
>> following justification:
>>
>> The usb phys need to be controlled dynamically on some Rockchip SoCs.
>> So set the new HCD flag which prevents USB core from trying to manage  our
>> phys.
>>
>> This is required to get USB gadget working in dual-role mode on Ringneck
>> PX30 SoM on a Haikou Devkit.
>>
>> Cc: Bin Yang <yangbin@rock-chips.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>> drivers/usb/dwc2/params.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c index
>> 9ed9fd956940..9095437b3236 100644
>> --- a/drivers/usb/dwc2/params.c
>> +++ b/drivers/usb/dwc2/params.c
>> @@ -117,6 +117,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
>> 	p->lpm_clock_gating = false;
>> 	p->besl = false;
>> 	p->hird_threshold_en = false;
>> +	p->hcd_skip_phy_initialization = 1;
> 
> I'm not familiar with all "rk" platforms, but are you sure that
> p->hcd_skip_phy_initialization = 1 required for all of them?
> 

No I am not. This is however applied to all devices (even non-Rockchip 
ones) in Rockchip vendor kernel.

I could check on an RK3368 since we have a module available for that, 
but I don't have access to any other Rockchip platform. From a quick 
grep, the following seems to be susceptible to this change:

rk3128
rv1108
rk3288
rk3036
rk3228-evb
rk3229
rk3066a
rk3188
rk3328
px30
rk3308
rk3368

Cheers,
Quentin
