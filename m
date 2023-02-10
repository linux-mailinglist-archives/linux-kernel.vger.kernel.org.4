Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA469203B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjBJNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjBJNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:52:10 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C722E244A0;
        Fri, 10 Feb 2023 05:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD+lsnYCTTrBQ9fXu5v61rcoUElGBiL3qy1+AZqvSF2AWIF3VILAJn5rRLp6B+RkDr8uTDg8nHZ+hhszwn3jKw8NPPVN3whA2zJwBhQzpa/s0JrHL3pU/L8qM3L0VXQQKN5Xs51sceLSErcAZ3hZYFDPmkU502SQ/9KBpInRCe/sfr9iXU1PFM4uuZVP28u6n0eezF/NlnXh891gNfFVRipVzK8YJb8o4vuIrEyM4Y9Z432YNKgNwZ+U/icOSUHNNKSIMqFLu3GOwmPcyTHW9ictdfHH67EnSN8wVSIJuhFdty6vCSQTZxAtVe/QQdn++wYLkuyYZi2I79KEgpIPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtL2+H3IKniIGEGOY18+9W+EUuTZ29F28CQA2YXS6Sg=;
 b=f4nofO/Ia104SiSOy86PBCALOOqiWifB/y8xlGbCB9ZoSX3Bi0AVx17v/WyvNwF/sQU0B7cJoHdb8lpRcdcUL8uawL53rsMyrmhZi1D2WRIPeFl4JXL2wldykCYh2PZTYzESXbOFk2GUY46jSUmcnsz/wKTGHGpLU3713ebyRfGvUse3wkC5xETAuNJMaKtPYqLp5GPXexo6s8KTB8w8pNlWQiDpL4Xn7jDixT3FEJaYFJ5BRKiWRMuuNf+LHTxOubYzM+s4QGBdo3Zqb5OSP3aLq4a3JHky/7rzQNrS6iOkTlyRWM9D0atx55dEKTXm2Nk74Kp9cTgsyglPYyPptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtL2+H3IKniIGEGOY18+9W+EUuTZ29F28CQA2YXS6Sg=;
 b=mq9LmWSmLfOmZ0o++fg7jUoa5KlP8GynKykXgQTh8KVVTeUfCNH5wFYXZZsFnudR8VjJYsfwaFsAK8T+CxvDUXZ28YRjRE19kcpW8PLv+Ia9SpkQ5+qDh7hr7A00wiaHXWAe//FeL2WGkwv7jScPgrcaW5BipggSy4FcPWGQMh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 13:52:05 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.038; Fri, 10 Feb 2023
 13:52:05 +0000
Message-ID: <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
Date:   Fri, 10 Feb 2023 15:52:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, arnaud.pouliquen@foss.st.com,
        daniel.baluta@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: d41e2e63-93b0-4b7f-8f04-08db0b6dfe92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h108SBqmiI/5A2sreBa2I2gb8gftj+/PSzZZqz3NnO+jwZrHZHwpTTpAOqq/jutb99/mJxT0aF8HrLEpczCflN2Zsc+UoNm6Pko52e7y2kuaWuslxiCxfPNrlcKYjlU9MQ9u2JvOXOVUqDvsC2ZtYKPS99beaLB2CWmAr7jn6dp83w7hFnpvpdg/yhiSekfTDojpncB0+vsHchee6fonlpywkO2fXlFeWFfIzN6EEMbRH5dmNKhalg+nufaadgBB+0ZL2LyYPQCHMUAuWrNG550p19Uo7kZrorPiO4gzvt28SIyCwH6pRbC6z6OItD3vuqoWavOrHZq2krq1EYSj+2Nc+59nfDDgJ8mdEjzE25ijSAg8NKpg8f8EbhXaJ5us/5UOfjVFdNbi3p8/oTVgArSuG6J5W3qDujjO82H3632UqNybmCigDuGiwupB/fmZOVL79U6SoxNs76XfuwcBCv+1tl++0rSDKkFlMiKcmBIELgGE7BiBj2YAVjIlmjw2GsbhFE33FDQ1u2tsd0/9wcG7ftqrwrbx3ru+NFQ3uu6Pc2062gS0M8wN2rXodymOnEOY3eD5YmCSU/nLqqaK5/mLjTw9vElH0LIw86ULImLGypfax6bn6wVRHIQm77g3+7wLo1OFhoQ6YyzJrFb/UpNXGnCEDRKz8NYCxIWH+QjYu4sXpPXRiV1LygDQ6vwMdr+Jes0DPZRVYiAtsRq1okyRyvYjYh+Yc8nw/4aRcjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(6666004)(2616005)(6506007)(53546011)(55236004)(478600001)(6486002)(6512007)(186003)(26005)(31686004)(86362001)(38100700002)(31696002)(7416002)(8936002)(2906002)(44832011)(316002)(41300700001)(4326008)(36756003)(8676002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZsaHhYNjUrejlMaVlYL2xEbzVtd3B3VVZZWXpjTnJuVWVBVnRWQ1d4WVY1?=
 =?utf-8?B?cVM4SWw4amxWaVFmRjNjbHdLekc2L3RHcUgwQlFCUW9iM3JmY25LWUQrRWRy?=
 =?utf-8?B?Wm0xKzY1djgwZjJxWlEvUm9CbHByZllhSldaMjVmd1dWWmY2VDNRUE52WFBt?=
 =?utf-8?B?UzdRcnFLOU0vUElDQ09uZENUb2lqUE5Wb25kcS9IWVhzK1N2S29EUXBDYndz?=
 =?utf-8?B?bVJweHgvN3FzOEFWU3hqMVg5TE05VEVTUUV3TXd3WXlSM1hxckVuTWw5bFhV?=
 =?utf-8?B?bE9BMzgydzNINEk0Wm9VTkwxQUVHZGJPTHFpdGRVWVBXWUVzVzR6bUJyd1JM?=
 =?utf-8?B?R1d4UG9ZaWZVNnMwWnpmc21pNWZqWW01TTlWYmVabHR0VkVTdlhOZ2pCSkhL?=
 =?utf-8?B?ck9PTE55YXROQTRXWG16d0FsTVB2LzV0S3ZXRTFUVnJSNVN5dGIwTVU4U3R2?=
 =?utf-8?B?R0FqV1dlcGxlM2M5Z2JRTVcrY3E5a3hYbUZrbDhtbzNrV1VqMlZESmlFeWZS?=
 =?utf-8?B?OXpZd0RuRUpCOTJqZm50eGZ3c285N3VVdk1ZUmc0QThiYVlydlo2M0pOM0ZS?=
 =?utf-8?B?VUR2aGYyODBqcE43ZExVeEh6VzNneHEyTUwvS1JlRmxwYklhNDkrUExoK1Np?=
 =?utf-8?B?S3IrbFNpWUI2MHNLSXBlM1BFMXFBbE1tejlRMFVqNjVCWmFibkpOUnFuaGl3?=
 =?utf-8?B?MWIzMjZXUVUzOFMyLzB0amNSREhHYmNZWnZFWFdDVWdwdDJ2U3RaMkNsM2xu?=
 =?utf-8?B?ME5wbGVTMTBpRUlZZm13dSs5eXdiL3lUbWhVWUMxT2tueVRBL3N1MVNsOUpE?=
 =?utf-8?B?dE1idlV5SUJMOGVEZUlpYXNWeHJwQmprRU9WL3BFWHFzb3dvRnhMTGNSemdj?=
 =?utf-8?B?S2FXNjVjR2pKQms5cVg4eFN2dmpwV3FKNXI4Nk9iRkNQZDZZUjFiU2ZvNk8w?=
 =?utf-8?B?dStQdHpFMHhtUmdjK1ppQW9EbklBLzlTaHBFa2dBejhOYnNVaDhtNHFQeXZ1?=
 =?utf-8?B?eHpOTWVNQzFFTkszYlBHdzRmRk9LeWxNL1BMeFJSU24xSHhHNjNHNW1CbWxB?=
 =?utf-8?B?eU10a0gzK21HNnhTYTVRS0NrOGozT3NkOXJlM1RySzY4clE0d3pXRFQ2RnhK?=
 =?utf-8?B?c1hsUkRaYktnam5ZMWtpSmRGcUpYenZ4RWRRREhoQVc1VjZxcElyLzFDQ0J3?=
 =?utf-8?B?NjZpL2Frd09EKzBEamRKRkRlTXprcnlwVWlDUzhqYjN6WEhYWEE1M2Q1YWhQ?=
 =?utf-8?B?S3RDUnlFTmEyY0N6RlNkMVVvb2Jqb0dxRTdrOXNuUDBWdXFLeHBSR1pTUXUz?=
 =?utf-8?B?aUsrb3dPaEtZNXNrNkRvUm9tQ05DQjMybGw1ZmV4Mk9yK092TnB0c1J6VGtk?=
 =?utf-8?B?bjdVQjFIK1Q2dWYvT2xVOWRTajlZNmxrbjB3Z0xTbGJuVE0rdkRMN2taN0la?=
 =?utf-8?B?bjF5L2p0RXliQVFaemkycmpNVnU5UFJIUG0yZ0RucUQxY0tpTEkra0xsNGVK?=
 =?utf-8?B?alVEdWhReWRHNGF5WEE0UmhSN0lwdUFIbGN6YUhxb0MzZE42c29hekNWQmVo?=
 =?utf-8?B?QjJGdyt3b0ZMcmR1bkZ3blRTSzU5L2Q0VUVuZFFLNUVaa0hTdHQzdXlybXMw?=
 =?utf-8?B?SjJmekNOdVNobnJOOTRwZlBYOW5yV3o2dnhYZVpnN05VV1lHenh1djN4TDYz?=
 =?utf-8?B?eU42VmVVaDFkZDZ2R3l4ekJrYXJINy85cER6enFDWTBzanV3WTFFckw0dHBu?=
 =?utf-8?B?THY2U1h2OGhSUTRYTnN4MDVSakhaeHRZWGFYeDZ6ZU5ldUVQd1NoMCtQaFpD?=
 =?utf-8?B?dWxERllJejhTd0hkejUzd1g0aFdZR1hSZ1ZVdzhEcmpDRlpHREd1dzROVFlp?=
 =?utf-8?B?VjZvZDR0T1c5ZU1acm5Pc3hHSmE1L0Q4V0xqR3FEcm5oWW0razcxK0doL0Vk?=
 =?utf-8?B?ei9YTzJTajd1elI4U0xpanMxZytIaW8vdjNzMVJqeXZYeGh2TGI4RTFFRzRY?=
 =?utf-8?B?MmdIbDBIRFhhU0ZxV051VERPVGhwZGR5bS9xY2dtUkNmeHAvTXNCWmNTc2wx?=
 =?utf-8?B?ZmllUFBWN084QUVxaXI3MTc0anIyeHRSd1VjemFhb0JGUm5wSHJoV1Y2Y3BM?=
 =?utf-8?B?bk9sR2dxUUVCbnpiMG11Q1VNTThCcGNPMnlXc3pyN0k0eUozbUN5b0d1enlB?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e2e63-93b0-4b7f-8f04-08db0b6dfe92
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:52:05.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etpQvcre/XjigQl7mHCHnDK8NwY98MeyQ/E7sV5phFOS3fqKTv8VjJoj+6oa6eGfe0AieEcjkPWQx6Yoln2/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> V3:
>   
>   Daniel, Iuliana
>
>     Please help review this patchset per Mathieu's comments.
>
>   Thanks,
>   Peng.
>
>   Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>   IMX_RPROC_ANY in patch 3 Per Mathieu
>   Update comment and commit log in patch 5, 6.
>
>   NXP SDK provides ".interrupts" section, but I am not sure how others
>   build the firmware. So I still keep patch 6 as v2, return bootaddr
>   if there is no ".interrupts" section.
>
> V2:
>   patch 4 is introduced for sparse check warning fix
>   
> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware could
> be in DDR, not just the default TCM.
>
> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> initial value could be got from firmware first section ".interrupts".
> i.MX93 is a bit different, it just needs the address of .interrupts
> section. NXP SDK always has .interrupts section.
>
> So first we need find the .interrupts section from firmware, so patch 1
> is to reuse the code of find_table to introduce a new API
> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>
> Patch 2 is introduce devtype for i.MX8M/93
>
> Although patch 3 is correct the mapping, but this area was never used
> by NXP SW team, we directly use the DDR region, not the alias region.
> Since this patchset is first to support firmware in DDR, mark this patch
> as a fix does not make much sense.
>
> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing .interrupts
> section. Detailed information in each patch commit message.
>
> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK

If one can build their firmware as they want, then the .interrupt 
section can also be called differently.
I don't think is a good idea to base all your implementation on this 
assumption.

It's clear there's a limitation when linking firmware in DDR, so this 
should be well documented so one can compile their firmware and put the 
needed section (interrupt as we call it in NXP SDK) always in TCML - 
independently where the other section go.

Regards,

Iulia


