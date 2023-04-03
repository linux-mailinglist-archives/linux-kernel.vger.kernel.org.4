Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EB6D4BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjDCPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDCPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:22:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529910D5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fm1Uo53/3gGGZJepT8vaeCo4l18njpzvb7kDWJf9eg=;
 b=SVOsCXlSLj/kgaSe9sG0AXX6g8lNOL9Ug9FzNY3GklT5CEvruaeF/Mglp1N6/wx+R5jle5u/yMfz+QeBSsFFA2RUiVgqQuG2VkILYGtYFT34h2EWWkBE+TRXSILZ6msB+B+otaF9mwk4VkQn2no2CJ7oi4ItUbx3AC4nhfjsW0ih69USK88QFWcVPDTax1n/3KCGjGvPwNb7wQD2YK/rXL13Yd/s98fpvqAfrTemzo0L+rtNnrqMa9wGjKmpeCL+AsvnjGTtJuOerA/T9nHyMwLuu0Rg57r3gSIXoVMyGO8ZtoK3RKTWYUvWIQcM02hYtSRWzLHxVsI96Hxoi4atsg==
Received: from AM6P191CA0050.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::27)
 by DU0PR03MB8368.eurprd03.prod.outlook.com (2603:10a6:10:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 15:22:24 +0000
Received: from AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::f3) by AM6P191CA0050.outlook.office365.com
 (2603:10a6:209:7f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 15:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 AM6EUR05FT040.mail.protection.outlook.com (10.233.241.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.43 via Frontend Transport; Mon, 3 Apr 2023 15:22:23 +0000
Received: from outmta (unknown [192.168.82.132])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 9344A2008088F;
        Mon,  3 Apr 2023 15:22:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.109])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 59F3920080073;
        Mon,  3 Apr 2023 15:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOjTSVrEh7DKV/mVWjNnNC8gDdXuJM610p+UynK8/s9H/7ZH1SjHJeCojTSqK2yxW2I/67aDP67328Vxv2whUBmD6d4GZSkqC3fMw8qu5SzszYnM9Y3aVx9Yrs2jEp+jM8m9L83L5I0O26+ezMIUdMEWroApM+a77jMoKVydysGwjLtMolSo77ON7erF9PpuLaigv6Xxzr3snXAbJ8WBonaOkcCBtLWch5wydSUaok4AYFDWXzmeplt1hCNU70ra+TWisHabnW7qQyuXv0PoxpwyOFDUPo+s8J5qpKEUzSL/HyJ7b7WXtvYKukl1ZCqda3EsFjWHcMk8x/SimHIFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fm1Uo53/3gGGZJepT8vaeCo4l18njpzvb7kDWJf9eg=;
 b=fa6oteTtAExkqzUf3tUvXHFA7OIU4tUicXX4rq9D9Jcf1CjFzd3MvWfOOQbrl+uWwnqRfz8DEQiW+PbNBe3w2UA293NYlEB1roxbM3+FUUIL+bwNwHzob+QV/yRpXoxygZSsTTt3EXusFxozHGNGkXAl5HFxOATqPi82j0PqS40OglJHGa9SX13nKwEh7mnxybO1p4uPpAU9o8bl7A1K4gKQOLG8ahTX5JwxSOyr0hF13dsFzAHneHxsXLh9BWhEThEKA4iFnHqYs3IG69nig1rPOkEliZ73URLmXJClLTKNO6wy/XB1KbsEuL8TLpvY5ZABJkxp3YGuqkH4P0Fg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fm1Uo53/3gGGZJepT8vaeCo4l18njpzvb7kDWJf9eg=;
 b=SVOsCXlSLj/kgaSe9sG0AXX6g8lNOL9Ug9FzNY3GklT5CEvruaeF/Mglp1N6/wx+R5jle5u/yMfz+QeBSsFFA2RUiVgqQuG2VkILYGtYFT34h2EWWkBE+TRXSILZ6msB+B+otaF9mwk4VkQn2no2CJ7oi4ItUbx3AC4nhfjsW0ih69USK88QFWcVPDTax1n/3KCGjGvPwNb7wQD2YK/rXL13Yd/s98fpvqAfrTemzo0L+rtNnrqMa9wGjKmpeCL+AsvnjGTtJuOerA/T9nHyMwLuu0Rg57r3gSIXoVMyGO8ZtoK3RKTWYUvWIQcM02hYtSRWzLHxVsI96Hxoi4atsg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAWPR03MB9641.eurprd03.prod.outlook.com (2603:10a6:102:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 15:22:18 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2226:eb03:a8c:a7e5%2]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:22:17 +0000
Message-ID: <7bd6967a-7f0b-575f-d972-3bf98fab5a6a@seco.com>
Date:   Mon, 3 Apr 2023 11:22:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] soc: fsl: qbman: Always disable interrupts when
 taking cgr_lock
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Scott Wood <oss@buserror.net>,
        Camelia Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org, Roy Pledge <roy.pledge@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
References: <20230331151413.1684105-1-sean.anderson@seco.com>
 <20230403140247.ugb23hqrha2kjup2@skbuf>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230403140247.ugb23hqrha2kjup2@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:208:329::28) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAWPR03MB9641:EE_|AM6EUR05FT040:EE_|DU0PR03MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: b8031a8c-b35b-4ac8-abce-08db345739cb
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XPYT4TfaU/Ef1ueXnkAhcCzxmvy0xDSQmwPGybmbpw+IIhL02350eQ5SXb4KLhzxtPBCMywFjSZQSAMxInlycI2QViufeUZ7ssz7NxIwBghpeRnQxaqu6Ic5cuxgYTmgIFGoYNc1kreT0m0vwQivKNJIU88aSDZOXukA+z0HoSivf8gOulR6zguzy+TpH5KaI9dyUgcomDLB0bhMnETAK+y4F1Cj3cCldKScV89D2ZKao64M+EJ/CsQvBAJIyCZeo/jxen9Yrsb4z9eVq5LvWPzx1p9eFJ5qilCLewlSbtpVpB1voFheGsNRQIAdbW3Nwmw64+VTvglvInMqd8YOiaBGghoVRsUdgjnx26Miwvxmo3pFDzlgSICFWOnKZcC+ZSzt+HOd9kgCdmCkXTXswoIjKo1IhPgmiRfmlASnxw5PMm/RbbnHo+SJ73g/uZ0jXtZGjyv6O2ae7iKm2syjW0YwCx7IvXJJnJw61zAL4E0aFF6RlZLqD8C3MOvlv5wAxFhTKqFxjAlzF5UAEn1ZDMSrgVH98DTaIlmQTGHdqU5lxHPDNjChGI6Gq36ogzYiRQEyHSKhsoPWofFKv4u3jqXeE0mmnB74ugrRR//l1FR2NPVqBBYWfEs//Tqn68IgYf91Ek7zrqGJs4Vn+Zt38rgyuv4CcOCOXOkIbnAW+08IWRgGUt8QfFpNeMfuxJaL
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(366004)(346002)(376002)(396003)(451199021)(7416002)(186003)(53546011)(6512007)(6506007)(26005)(44832011)(4744005)(6666004)(31686004)(54906003)(478600001)(38100700002)(52116002)(38350700002)(36756003)(66556008)(86362001)(66946007)(66476007)(83380400001)(6916009)(8676002)(4326008)(316002)(31696002)(2906002)(41300700001)(5660300002)(6486002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9641
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58f333cc-2101-4ed2-6f37-08db345735d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6mkr6et1WZeuGy8PfBFyGPbRrzxSvgEF1Nh8tj1BQsuwv/YplKecCMR7AL/yeCRnU4aN75LZHli90V1RTTtT4Dnn2gnyZWVMBPJmjtBbNseHJSNwxQDabox9hdzADSWd+0R9lNyAjJCe5IZUMSh2gHkUwREMRIL/YPD8+pjOOSv2MYkRrWzhDOEzAZ+Mq1z60IyFWi1OkPmyPNZzcvsuq/k9ha2/78LLGXj3Agj0UsLUY6Dx43EbM94njXR9UyPLDft99oYysstkpDZXojWXVaM1u77cE5VFcLbmBkZOimLAOFaNivYf2YRMNV4FVkX/9Xzf0uetSDacpRyRx/LzycQFWLt7Se4oZfWc1Ov5B0gEgAzlMMoFc/AqYiqQFaVYiomLHIrLfa0vF5QdSLJORm4DoT5RjpQdp2RI5umudA+bmf8PFq8SZ4Sl6PQ4SdYXC7ZYOa+h4qpgTqXDZntHaKEsXSOE9fwkOA670WoabdesvQ7THJ1PsJLdwEAKLYMvozDSly94KWBahc+TkcArqzTDvK+0E8Eya062EI0VrAgXgYz5wCk+0Wn+P54dzPPiM+Nt2fqEE1SZaHnTjXk7Lghr/9oHxeOkBvhSiRN7SHsigGMuMbzYq17nyXj8vFcdG0UwCrr6G3Xr9upcTvTOWRAPGe0tClFnWrkBLLj2tbYBcYk/9tJBspPwGifzsOGNncva3TO8mAcL9+BqcLNerul8Vm4gyl62+kTpzAWp3xv8I4q3VKh4NnKrN3ArDpnc+P+BaMMt+nDfIbx72tx8Q==
X-Forefront-Antispam-Report: CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(39850400004)(451199021)(36840700001)(46966006)(40470700004)(6916009)(4326008)(41300700001)(40460700003)(356005)(82740400003)(7596003)(7636003)(36860700001)(82310400005)(86362001)(83380400001)(53546011)(47076005)(336012)(2616005)(186003)(6512007)(6506007)(26005)(34020700004)(5660300002)(54906003)(316002)(478600001)(44832011)(8676002)(7416002)(8936002)(70586007)(70206006)(2906002)(6666004)(6486002)(4744005)(40480700001)(31686004)(36756003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:22:23.9036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8031a8c-b35b-4ac8-abce-08db345739cb
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8368
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 10:02, Vladimir Oltean wrote:
> On Fri, Mar 31, 2023 at 11:14:12AM -0400, Sean Anderson wrote:
>> smp_call_function_single disables IRQs when executing the callback. To
>> prevent deadlocks, we must disable IRQs when taking cgr_lock elsewhere.
>> This is already done by qman_update_cgr and qman_delete_cgr; fix the
>> other lockers.
>> 
>> Fixes: c535e923bb97 ("soc/fsl: Introduce DPAA 1.x QMan device driver")
> 
> If you've identified smp_call_function_single() as the problem, then the
> true issue seems to lie in commit 96f413f47677 ("soc/fsl/qbman: fix
> issue in qman_delete_cgr_safe()") and not in the initial commit, no?

Yes, that seems better. I did a blame and saw that qman_delete_cgr_safe
had been around since the initial driver, but I didn't realize it worked
in a different way back then.

--Sean

> Anyway,
> 
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
