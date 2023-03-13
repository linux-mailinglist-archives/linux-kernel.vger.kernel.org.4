Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5D6B7956
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCMNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCMNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:46:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC57637FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3o2FKLv6+WfGVwVBuGeaACLMRv8zPuFHp6RoNsiYNHl0hGEWNC/ga8bIBwEaQSXNohQBCy/hpY28Aa0LS/89LmQfwlP2/4OG/rSpyx/mGX2e4tJiOom1VjxgVrtFvUEGE2/1owHvwui9wk8fejRmksMoSCF+g/Nzbx8Qykrq0IeGUDSg8c7I4HnwSsD7PvYPzMxirabw6LhSC4zbjYIJq7UdBOS17tlMpiU8b1BnhkYtgxHR+RcR9/DhIHCEMoO3cGB7MQ24C2ASTYqbBdAi7TCyvuIDMINVY9Z0HIgQNsKav0QmL+sR8Ts1zATmDPXAguHcValGB+pLJAaRyUm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFSIC76w5G33eWJRS8tKw04NrY03Bf607hFPz7cEGzo=;
 b=MWYXxvFH4us3QDc580If5ap4eikqr9u3wsEZJtd0Y6ncyYUD06vwIrtdDjH62crFmAcLj1JRV3OOxH72VLluFNyzOp3wOSxMs2eg1Ngp+WiUmPuGHqtZ/rKSbXbo6kuAuk4acwRcdh4NnSg1WUYH1ZPW03xauQkn40SX180exbs+/lraN0xplp7XEEuYFMnceCBG7wB0tVQxtwu0CuXr7EY7kAPheuhW9iCiyRDhvwxEm/xmCl4MlBnq1nG+c3YuOJo67lfdFEP6ESCqxzJXtJDGoajzJoaZVZE4j7rytTrsStuFP5n6Ju0v60BxejYYIAwq6R7Np8kh4EhDHOFXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFSIC76w5G33eWJRS8tKw04NrY03Bf607hFPz7cEGzo=;
 b=JYUYUxTI0pB/kptXi5BY/3/Y9f9K01zaK9A6ZddV9fovTGK23p2Ow1Ov5a7q4/Nzj2O18Mbne9SxJJ6fz3jDuLRFovT9ijzKIU+4eY73KAEb1svN9MsGsoVC0v6m9P1r2L6YTjgZhBDshNTKCwJfmFHbUV9UMDD4qZxyxpqGDQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB6172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:46:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:46:10 +0000
Message-ID: <b7e39919-a94f-3929-8814-ada801365dfe@kontron.de>
Date:   Mon, 13 Mar 2023 14:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea14eae-724d-4b85-9617-08db23c94deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ie1a4/uCycfoYY/ggYNPo7jpWHIfb8w/MZL/VWqH1Pgr9pYEssomgUrvGa02+2xOr541G0NNsSD2OH3bNcoCcjIeES27AT8IVNgpNuLsdRPP5f4vESXpofKDZqnR4lJlIGtMg78EA3rInaT3r2vBAaIqaJH2uK+qc+DiRXvAsGo8+V8EUAdFzqrDMm5C0UQ/Sm/jSGcTGDoGxYgPswkVTNHN/FwuWL5jvJwKKZYZEcndM6ImN6/JFqlEZ1AKAceGS1qR7IkmjKA+XPgv1YPXnu4UFuhS5HK8ZISrotrIWW0c8TL31h4ncPQXD/VT2vZ+KCnljm6L4lUgadGgfzkFkrZZvClaZSTtADfg+uZwchTwV7B9sTyt4y6OhcHu0cXLBadKUXU5fkpOvxtcdttPHUtKjWrvvczk85H0PIuBuIJQ0EQBvHX2SovS3QkqJAXvU7auhyicqAlsOspIu8ADQh6ObE93BpuxVLhNPBsJTuitwYn6LeLw78rQR0ajDOUTaUpLwf/BL9QFFaCeTvVz361G1e9Ue4P5SHm3S4GW7GYd+Wiy26EFjwJ0hRf4ePJNQRyafWZT/9rwt3aw/YDpu//lNEjUUCmWZBOY7aj54WWoPp/B9vVaFHpfotlVo9sG43ZfResOfq3ZZAkLRvvdHNMr80UtqjK4K/YqMeQcojWrcnI6p0deeahQz/p9aAMLjCnG+7ogTml7zABIWoyt6MqXQWQ5C3CJJUbeeS6baM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(31696002)(86362001)(36756003)(38100700002)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(8936002)(110136005)(478600001)(316002)(44832011)(5660300002)(2906002)(2616005)(83380400001)(6486002)(186003)(53546011)(6506007)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRESmZEZkx5YW4vWGxGck03Y0ZMMGZEbm50SmFMcDRaRWxDRHRHUStBMUNX?=
 =?utf-8?B?cVFwZElTa3BadFlIQnJoT1hQKzFvWmI4UTAzYUdDbVUxM0hIVHFBcnNFRGh4?=
 =?utf-8?B?QWlLOXVkT2I3aVlhTXA1Wkg0VnFGcktneHVLZjV3OElSZXBVOVk5czZsK2R4?=
 =?utf-8?B?ZXdBTUw2QTA3M282a0d3Y29paUFoMEtIblNFSW50QTlINXNFUFhwOGVkK1pi?=
 =?utf-8?B?UHN2ZWV0aTlONXFYT2RtdGdwbnBHbERQU2NEcTR1cWxYMlMrbDV0NHI0NHp3?=
 =?utf-8?B?TjNlRDV2a3lkL0x1czdvdkJ0bW9BK1lQWEZYMEFZM3hYZjN0SjVnREpnUXdH?=
 =?utf-8?B?VDYzRGdXcTYzZ0xpd2xnZmtwUWZxYTVESGswaFhwcUpkOEs2WjRuaVpnZkln?=
 =?utf-8?B?L0t1b083eTdhcjdzS1hPSldXS0xLYjZlUzZDWklxN240c1NseW5tVk00K0dQ?=
 =?utf-8?B?N29uL0lnN0tFd1grNHUyS0ZGWkhXb2JIUlBSS3BidjZDUTRJaDVOM2ViakVY?=
 =?utf-8?B?T1pEQkpSYkIrRXhxblAyZHZ2dk5TVmlvUkp0dUVvVm9WREIrS0hkVTU4M1Bt?=
 =?utf-8?B?NkhDMHZKbWs1eTBvZi80VFBqL1RXZm93VnorWCtXdkdha1JPQUtMTWh3RDJ4?=
 =?utf-8?B?blE4WEJVQ1N1aVlVSGhxQnIzMzZRRWYrcVFKRThIRFhkR3B1Z0lMR0ZUZWpp?=
 =?utf-8?B?REtIbDBCUCtsSkhGVzlaWDVyOTdZQ3I0Rytvc0tMQW1JQWhLUEpqbXBkb1hZ?=
 =?utf-8?B?UlN0b09HbDJsN01KNjR6QXZacE8wUzVDbTVPbnRLMndqc3ArMU41MHp5VWFC?=
 =?utf-8?B?dGhteDF4V0JwUktuMTVWWHIxOHZrUjFRRGU4S1JsTGMwU2xOM3B3L25wS0Vo?=
 =?utf-8?B?WUlkaSs3RWZCS01TL0dLS0ROeERBekdXcjVaMWhyNHBDZmV6R1llazVwMGVX?=
 =?utf-8?B?WGJiSndLY3E4Tk40TU5PSytrNzBEclhON2dqNDY1aHV2VjlzOFlZSWI4Unpi?=
 =?utf-8?B?aWR0blBUVExSTDNyYlJEZ1pJSG9qTWRwREJFUTV2cGVlL3FhWXNvRmoyVFJm?=
 =?utf-8?B?dnZBU3hiNFpxVUdXak0rNWxodkJnTFpTSlBJSHBwbm4wREc1MEJDTmtoYWRE?=
 =?utf-8?B?Y2ZGS2FlVmRQajFtcGJyNEswNGdlaEt1WHFPTnE3YmFLc25hSk93MXNwclgx?=
 =?utf-8?B?TktpeDJhWTg5YkF0SHhsMFdRVkg3YW1vSE1XWlhCRFlqcHRoWjI4QWR2LzA1?=
 =?utf-8?B?OGJNZmE4MlBQMzVjdGNBQ1RVYXFhUEM1UzJrQks4Z0txZ2JuczYyYjNSbkpB?=
 =?utf-8?B?YSs0bFA4VGpLdzdBTDE3bWE4QzdlZTl0RW03MVluZjdhWlJOZWNrS3gzVDIx?=
 =?utf-8?B?dTVueVBSb0NpcTNhQUxJSnNKcVJjZEcrUFJGV3NGcHZnY29qdGl3QjJIdU9K?=
 =?utf-8?B?VmR6Z2NQdlF0YUt3WktYbFlYd0ZDS01MUHZkN1g2bWp5OVRhUXBYWklrNHJu?=
 =?utf-8?B?TU91S1dwSEI2MXBINTdhZFBxWXd1dUZHZUczUXQzckc0Y3hCelk2cWxDM1I0?=
 =?utf-8?B?KzNtNkQrMDhVUlQwbG1sTFJmeTYxeUNQMjNzWHE0aHN0TXJ6bEpGellOSXJJ?=
 =?utf-8?B?SVRMKy83TnBmVDlRNmFHYXBKN1RlNldRSGZCeW9rWm5pWlk4N2ZvaTM4aVFP?=
 =?utf-8?B?djE0ak0rYjJKMHMzNEZkN0pxR29KUTd2cGZNS1FMaFQzTk40UWdGNlBneW1C?=
 =?utf-8?B?RnFVaFA0Z2xhY0RYc2E2TkpLYzI3eHdTNUcxYXRHc09OdUxYK2hqQzRsOTNt?=
 =?utf-8?B?dTVyV25Da0FKdE93Y1BpZ2hOaTYyY1RNLzJIUlovUmMrc0R2K1FTUm5TU0Jo?=
 =?utf-8?B?cUQ4QWM4TjBGeU95UlB3YnNxanp2UG9LcDlySm9oQ0t4ZjUzTmRpSWtzS3RU?=
 =?utf-8?B?TDhOTzRKenBHUnJLa1RhQTZJOFY3RkEwZCtkTHpzWE9IZ01OZXJrTDRtWTZS?=
 =?utf-8?B?SjRtbjJRUS8yc0dFbm9nSFFkUFRkRWwxS2VuRWxEekxKMWpRY0RkMlE2dUhW?=
 =?utf-8?B?VmwyeGRYblplT2YzaWg1dDgyZUkwRWs5UUZhdCtMZ05ZTEFIMzdtZ0I0NEFi?=
 =?utf-8?B?ZGdpS0REVWVqM1RvaWtnTEtTWXZ2R1JqWmk5WjYycW5zdGRCQWtObHk3MVlw?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea14eae-724d-4b85-9617-08db23c94deb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:46:10.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bcuvou/Hsyj8uAtDh4H2xq0mHs0X76QgDHAECYH2f3TcitvbqElbd+LoXrWKWlUtgWASzK4xzbci1oyXn1BiDGiSa5uhJ9R0Rxlums5l4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6172
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.23 10:28, Alexander Stein wrote:
> This fixes a copy & paste error.

I would mention here, that this doesn't contain any functional changes
as BUCK1_ENMODE_MASK is equal to BUCK2_ENMODE_MASK.

> 
> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> Originally-from: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> This diff is extracted from a downstream commit authored by Robin Gong.
> I'm not sure if adding Originally-from: is enough here or I do have to
> change From: as well.

I never heard of "Originally-from:". Does this tag exist? Is it
documented somewhere?

I think that your tooling (git format-patch) should add a From: tag
automatically if you correctly pick up a patch from someone else.

Other than these formal issues the change itself looks good to me.

> 
>  drivers/regulator/pca9450-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> index c84d95b11e9c..544e741f7108 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -265,7 +265,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
>  			.vsel_mask = BUCK2OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK2CTRL,
> -			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_mask = BUCK2_ENMODE_MASK,
>  			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
>  			.ramp_reg = PCA9450_REG_BUCK2CTRL,
>  			.ramp_mask = BUCK2_RAMP_MASK,
> @@ -509,7 +509,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
>  			.vsel_mask = BUCK2OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK2CTRL,
> -			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_mask = BUCK2_ENMODE_MASK,
>  			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
>  			.ramp_reg = PCA9450_REG_BUCK2CTRL,
>  			.ramp_mask = BUCK2_RAMP_MASK,
