Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0567ADA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjAYJTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:19:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631046D7A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuQFL862AD18NK+puuh2ddFzV9l48gbK4j0QZ0b/ICI=;
 b=rC4BL0noQe8nVUbtTO+4DGwC9TKCwYTmHDTQ0bufzWqfwqtWongA5zAUNpgPeeRsnhoh1QqM/jjTdCmEw28IQIkialbKpHD1/Skln4+s+HOyYkbpRoDo7u2r34pLRBKEYz0NFyI8BA/g5vxmvfHTEmRDnVZrWCmFNwxwgj/IG1U=
Received: from AS9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::10) by PA4PR08MB7521.eurprd08.prod.outlook.com
 (2603:10a6:102:26a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Wed, 25 Jan
 2023 09:18:47 +0000
Received: from AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:540:cafe::a7) by AS9PR01CA0008.outlook.office365.com
 (2603:10a6:20b:540::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.34 via Frontend
 Transport; Wed, 25 Jan 2023 09:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT023.mail.protection.outlook.com (100.127.140.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 09:18:47 +0000
Received: ("Tessian outbound 3ad958cd7492:v132"); Wed, 25 Jan 2023 09:18:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5be824bac85b6354
X-CR-MTA-TID: 64aa7808
Received: from 8ac90293c535.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DBD1A084-0F55-4E27-AE16-0D5B7344ECDC.1;
        Wed, 25 Jan 2023 09:18:35 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8ac90293c535.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Jan 2023 09:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcAIjh9FbEFbgeeC/edNcC5GtFqYeYxa7z0GIviEqi+YknUnM3CJiOp+3HrHTm1xgWhM1eesFehTfwOrAnMdsAj3krvmxj2UW0zG2KOpeG4kUqtCSloVbeyd30nbDj37H8hLX5Hp+O5i7IuFa85boovqHOatCtjfTFd1tDHK/muO3OqaNFqpO5k5xU3ufgqSlHRrSEvLO4oXK1BqdBTODirRKhT0QxqM/x+LFxMkvlocx66a9QaWn1APJlimU5/e4XRlV/VpR3fuA27PNSRlj+QepTll7clrlzki+1k68ro33NK37AF0MK04biAiQCHQzSdkx9PWudQIuv9YckiPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuQFL862AD18NK+puuh2ddFzV9l48gbK4j0QZ0b/ICI=;
 b=bEO5NX+qx9GxQwwaCADERje/9t6sP9KROyECxhxdnlIUKbucCEbnbHE3ypsFcGvsiZc4heOmmM4FsI6tCE8DlAmdQMplIWtnlADwVvdmploP3tBPJm7bLQub6IEGneDQmvLWPPEo+NGixXMAqJic9llQfrSQb1tS0W6u6wIoMbn02n0srCz3Kz5h+l+4hUiJT7tu6RWpOzlhCPRKYt1nQ8sVIscFGYEc2kuOnV3TyW2EsX+uRdqbMAgFP4wxScZk6GKfBEELoT7JAHJImvC2u1FPRmz4yOtxzqy20Z/ENYwIE/6pjlR+A69YzNgsu9nGUP/kyabXs+/AZceiNHC7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuQFL862AD18NK+puuh2ddFzV9l48gbK4j0QZ0b/ICI=;
 b=rC4BL0noQe8nVUbtTO+4DGwC9TKCwYTmHDTQ0bufzWqfwqtWongA5zAUNpgPeeRsnhoh1QqM/jjTdCmEw28IQIkialbKpHD1/Skln4+s+HOyYkbpRoDo7u2r34pLRBKEYz0NFyI8BA/g5vxmvfHTEmRDnVZrWCmFNwxwgj/IG1U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by VE1PR08MB5615.eurprd08.prod.outlook.com (2603:10a6:800:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 09:18:34 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::bced:32a3:b77e:90a6]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::bced:32a3:b77e:90a6%6]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 09:18:33 +0000
Message-ID: <d6a92e81-0f67-68ce-744d-149bbcdc06d9@arm.com>
Date:   Wed, 25 Jan 2023 09:18:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com, liwei391@huawei.com,
        mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com>
 <Y9AdunpawWzWKIXN@aspen.lan>
Content-Language: en-US
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <Y9AdunpawWzWKIXN@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|VE1PR08MB5615:EE_|AM7EUR03FT023:EE_|PA4PR08MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c85c56-692b-4d4d-e01c-08dafeb529d6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BgqlCSeeLBrOQXlkA+4HuPIvuE2hdGX8pFx8tYeRCZS7Ox8dVs5paGMT00Bbfre45hFEc8klDiEjQDVoRX0jTbRRhjzCmMFDnKl/R/oeWpd/eZlWRUiQz+lM82zTJAveXGsm2af6LXcMr63b9DvdwG2Hx2FGAAZKzbVOxXu5UNCjyWLoQqP1M2gFhExJSDcEbVmtXvpLiSNwEVkaAXwa3UHugcFG94aeu9dTy5Tgpg0R3igRREp1cl6Biodavea8NZmRS54d0LfuJQFOv04KKf6nF9NayOSA8/jvFtxWBVUc/25yhhmTb9Cn4Mz5tcMvQ/VwKDlPh3ROUuJqd80wWa1C1wiR8Koj+U5AOisHTBHF24d36ZGvtZM5clx7mCppr9w0nvPNVOuq55HUw4RbUIvp6q0kicHXAMNe6aM+SNyk47L0pc3yrUGCu9+tjvTLCjvzy/se4Q1DJMkIqAFklWw2ph8PhFnY3RKy5+kSj25HIYFY6o80RyplJLQLF9Sm62X+MSvPYdsrE0AMB7SwSIGBH77ToHAggEScTKTlZJzEqowhYRQku7iFLBXNb1qBnFgoYLjO6BjPhLKFpSTyQVsi6Qg0o3TEcpHY4yf/3euEEigJ54sAs3fBtglhDwCcw6gR3DHsbKq/sSvKzzAl1ax/OQAeOCTIaAL5RlTSgzD2qUr/AymfEQPpSSTIU+LTElpJDNy/gVE1f6EXlqBbJk7v7wpvuwTS3HFqjHoxU0zavpM6ZTwxj8Sb4C9Q7ylf+AuXQ4H8BRObCZ8HiwHI4oLqqWWi1NoMGrTdv5jcFnTnzjV45B57dXHAiTJT5el+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(38100700002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(2616005)(6506007)(110136005)(6512007)(53546011)(26005)(478600001)(8676002)(186003)(66946007)(66556008)(66476007)(316002)(41300700001)(4326008)(6486002)(31686004)(966005)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5615
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c94c23d-66bd-418b-3d33-08dafeb52172
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPuVCZm0/uUvBO5qlh+8XTnf7GAws7wej69au6KH0WhjqVMVUxVPbDn3M7UJn4rlyh+kTspGRqjbYRL5c/D9m+OUXRtxmJJiH9rpi6AFgwf5Am4gNKyoc2yG7d3YtycwNX5tqAGymB4mai6BPRxEH4gwykx7YfRRYShiSJpUzsS07ihkJkJSCtTGaQVATGGMZ8q9Gz+RI3p8YM7dO0YEGB+7ad7pzyfHnukoQaeoHDgVuQokpFVEmVY623CuJ6i2wOIhhLf9FEeqsShCzETMv+wgWNffOw+fkozoj4qAdKLZM16hSmmRtX3BHUf/Jobc7d6/+qxqutKusz559dQW4QH6lN4zmH4gWZXLQEuIwn1QL3d0UDWm4aksk2mTqKBt2IOhpNJkgvcAuwKgQUp8YCwAJN5q3BAzdM+8sq1ffLcz5qsBLqSW/etB5yVF0hLtZwIoXhRkyPE3XoffqOgsvWRLE/IvG7sidVUjlpdQpOpBnDSIS6OtkdAxwLmm9/M1lL6VOGcHdvANkyg2nQGOiluW1njr5r1pUzV+ZnoiJcxmfx5LLbHmbri2TBNuc+YVPerr+TEMbFL+8kmN3IgWM2DIKwN2J6BYx7JM8CKVXgdVCa+KVhywCc4YCGfesw3H/pQZ2zYTdi7RUh6EK3i+b7Hl+fyux+0tC8PUsRSA0QMq+X4XnFSykXPffJC2mmZ2oft1gquwEnhfGLb9p5dN7w7O46MCCV14jqrW4zflmjCaPCNFpOEC0hC1hX1adZw4P4mLOrT8YTs1uDOSXSHc5BBvYY6Qh3ppPMpG/rkN7zWtYgFKtREqHKc658gN2UBm
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(31686004)(40480700001)(40460700003)(966005)(2906002)(6486002)(110136005)(478600001)(316002)(86362001)(31696002)(82740400003)(356005)(82310400005)(81166007)(36756003)(36860700001)(336012)(2616005)(6506007)(70206006)(53546011)(8676002)(41300700001)(4326008)(8936002)(47076005)(5660300002)(44832011)(70586007)(6512007)(26005)(107886003)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 09:18:47.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c85c56-692b-4d4d-e01c-08dafeb529d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7521
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this expected to change single-stepping operation in usespace for debuggers (gdb/lldb)? If so, it would be nice to at least
test it a little to make sure it works.

On 1/24/23 18:04, Daniel Thompson wrote:
> On Thu, Jan 12, 2023 at 02:52:49PM +0530, Sumit Garg wrote:
>> Hi Will, Catalin,
>>
>> On Mon, 19 Dec 2022 at 15:55, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> This patch-set reworks pending fixes from Wei's series [1] to make
>>> single-step debugging via kgdb/kdb on arm64 work as expected. There was
>>> a prior discussion on ML [2] regarding if we should keep the interrupts
>>> enabled during single-stepping. So patch #1 follows suggestion from Will
>>> [3] to not disable interrupts during single stepping but rather skip
>>> single stepping within interrupt handler.
>>>
>>> [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
>>> [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
>>> [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
>>>
>>> Changes in v5:
>>> - Incorporated misc. comments from Mark.
>>>
>>
>> Since patch #1 has already been reviewed/acked by Mark and the
>> complete patchset has been tested by Doug, would it be fine for you to
>> pick up this patchset? It fixes a real single stepping problem for
>> kgdb on arm64.
> 
> Sorry to be quiet for so long.
> 
> Testing this patch set has proven to be a little difficult.
> 
> It certainly fixes the single step tests in the kgdbtest suite.
> That's a good start.
> 
> Unfortunately when testing using qemu/KVM (hosted on NXP
> 2k/Solidrun Honeycomb) the patch set is resulting in instability
> running the built-in self tests (specifically this one:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/kgdbts.c#n74 ). Running this test using the kgdbtest harness
> results in the test failing roughly a third of the time.
> 
> The error reported is that the trap handler tried to unlock a spinlock
> that isn't currently locked. To be honest I suspect this is a generic
> problem that the new feature happens to tickle (this test has
> historically been unreliable on x86 too... and x86 is noteworthy for
> being the only other platform I test using KVM rather than pure qemu).
> Of course the only way to prove that would be to find and fix the
> problem in the trap handler (which probably involves rewriting it) and I
> haven't managed to do that yet.
> 
> In short, I think the debugger is more useful with this patchset than
> without so, although it is caveated by the above, I'd call this:
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> Daniel.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

