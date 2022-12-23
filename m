Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0C654F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiLWLOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLWLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:14:30 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1BB4D;
        Fri, 23 Dec 2022 03:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJao4pyzQkwNQQOEMVD1uz1Tlcfw5RPad/Sd0ZQUg9s=;
 b=I7P4CyDQoBKnVvafmSApuzDMDohrD1oU/rYSfoBF4oNFXvbKUfFZH9SK+S25GaAWNT4NxVCCcuCn+NxAnuKHndj/nDUrO0oSoMTK2YHtGEwWDFB4hNiCtBJyIoXcuPD60VGUgNXkPvvOh4LO+LC8vCV6iJWrzZ74De1b4YkOedI=
Received: from AM6P191CA0084.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::25)
 by AS8PR08MB8184.eurprd08.prod.outlook.com (2603:10a6:20b:561::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Fri, 23 Dec
 2022 11:14:25 +0000
Received: from AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::27) by AM6P191CA0084.outlook.office365.com
 (2603:10a6:209:8a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 11:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT018.mail.protection.outlook.com (100.127.140.97) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.13 via Frontend Transport; Fri, 23 Dec 2022 11:14:25 +0000
Received: ("Tessian outbound 8038f0863a52:v132"); Fri, 23 Dec 2022 11:14:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2aebbbd61136b481
X-CR-MTA-TID: 64aa7808
Received: from 3faec33a094d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB3EA943-AD51-4FFA-A802-3E86C4E28902.1;
        Fri, 23 Dec 2022 11:14:13 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3faec33a094d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 23 Dec 2022 11:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEp2hqpKXKqRMBi3+jv0fqLHB2r3GQeOMuvCl+fCV7pq4Ic6kl4Tm0bRQAmFF3boR9tEyeKMlV+nKsLzs2x2lcRnV1FeSGqFLljc3etrrHoakis4dS05I+inJbq/4sQkDY1ZVqPuP0KqBoXWlPpQoCn7z9RKL6r1swl8CqFl49BayMQGIo+EnncPs9t0Q9GSBXtD/W52DhRJhzFd0iHUPHyF1Nzp7hnAFGKa4njW6zr4m2LOZU/tzAd35UyNpVqVUwQoDdLPa/JR0DwQZXO2MBANFMM+kBrlujrRlFaM2t5IO/UYkFIhWVFZQVr/wiaQeLnOAH/ujjb4nHKG+eO39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJao4pyzQkwNQQOEMVD1uz1Tlcfw5RPad/Sd0ZQUg9s=;
 b=lKEtoRIy1zhzZNoNpfLFmZlsnsQyGfzGBqUffZ+xzcPPKPSOfbY5/sh5tCnH4yUpqV0Fw7PtxDujJ9Uda81rTsaplmeBbmup7pbDecyBhXJyFckWu9TaauQbsdiF79ecJS6IrL0hTaIgdLtEnbaQVewOIUgeoE7DokiRxo/cl1gCaVQW37p5OvF6gcDbUWcjJs7D4xp1vhPrnNF29lULc7cVr1jmBZt/NKjYKEuiNsJCp2h6EGoTEfeSAbXawi5bQF1aPQuOJZ2SucCiLRSv12QX/158v4pmQs3WBg17FdG8tFHwuiv+Anknorhn+rFQH3fZ41AK8p1F/D80IDqLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJao4pyzQkwNQQOEMVD1uz1Tlcfw5RPad/Sd0ZQUg9s=;
 b=I7P4CyDQoBKnVvafmSApuzDMDohrD1oU/rYSfoBF4oNFXvbKUfFZH9SK+S25GaAWNT4NxVCCcuCn+NxAnuKHndj/nDUrO0oSoMTK2YHtGEwWDFB4hNiCtBJyIoXcuPD60VGUgNXkPvvOh4LO+LC8vCV6iJWrzZ74De1b4YkOedI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (2603:10a6:10:f6::10)
 by DU0PR08MB10358.eurprd08.prod.outlook.com (2603:10a6:10:415::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Fri, 23 Dec
 2022 11:14:11 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::3cd:ddee:ec77:e09d]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::3cd:ddee:ec77:e09d%7]) with mapi id 15.20.5944.012; Fri, 23 Dec 2022
 11:14:10 +0000
Date:   Fri, 23 Dec 2022 11:14:05 +0000
From:   Emekcan Aras <emekcan.aras@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm: dts: arm: add arm corstone500 device tree
Message-ID: <Y6WNfXUQhZot9wcR@e126835.cambridge.arm.com>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
 <20221222123244.147238-2-emekcan.aras@arm.com>
 <36611392-5bdd-4f08-6748-d36c6ffcd470@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36611392-5bdd-4f08-6748-d36c6ffcd470@kernel.org>
X-ClientProxiedBy: LO4P265CA0106.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::9) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:f6::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DBBPR08MB4838:EE_|DU0PR08MB10358:EE_|AM7EUR03FT018:EE_|AS8PR08MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c572d8e-ceab-40a6-79ba-08dae4d6d99d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8HhBPGWpHKcqrntHyBH2NSPh69j/O3aueva9LTT8JrWAgN0swb5iY42oaoaajTiYshKinLWeLZbEBq2L52W/xncVQH6bkkoDOsyBeBmXdj3iKM/4v2B4OM6Fw3VbomUuyfyw1B9PR95fqvpT+U0AAr0hDsgHLZCEqN63V/N49lxCAGgitBWsTRf9GvFnma/mfMrkm5gKUHFGPZUpc0L6jU7DYPOVm2uYeyP69+uDZaAsKOv2Xx/04pLsA45wyrNFLiWG4NeY5ql/2T3B44xRqbtoQy/3w2FKrAtOieITse8seWsrrdD2w63cpLCbubH8hEwuQVu7GqQlqgpHHGbQ8NLEuJ3IfQdWzcR7grrOkAvgWDTmD022xe9JVnjC+8Wv9mSRV0FEp9noqCdKS1ASprAtumrlOj6v2D24M3TfXUy710GglUT/YkUXKmIo0biqBrUWDy7U/2PHjJa9WWIG788PvYG2eWv9tu42Kv1OSazXbi8fZ1LT+j+V8kkVXQ04uoeL93jr9ZQinhYjc0+Dn618gMS6mvQZIFmVlzNgqzWSGR07YegcLC74iEmS/BHkIFvKiuuqpbSxRalRW/IujvX6ImVZw6tj9e7MbN35tBjCRI/7AL+HM6twYhJlbAPpeIBR6e30RBbGGrFSmLObWPxABuyuPRjSU+qPiUbCwGE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4838.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(5660300002)(44832011)(8936002)(83380400001)(41300700001)(8676002)(4326008)(66476007)(66556008)(66946007)(86362001)(2906002)(38100700002)(966005)(6506007)(6486002)(478600001)(53546011)(66899015)(6666004)(6512007)(54906003)(6916009)(186003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10358
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f02f6f7b-bc05-4080-14b5-08dae4d6d0d4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2grNl/xvTLmfSuxowsz06WhojaqJnNvYDGte6LIWWH5JUxdxnTZ+tzXZFH3DxUsQ2aoGvtNtUPLN+8B5+S9BPBgxcydu7AA9HGsZuTJbiiulTuEJ7tLT6fHGJmaxrp8hgY4S7gPJCc2wvuj7PjCd8g5gg7WTqKyDn4OUlP7NgW4wTTlCBm1Ba2OWVz04cjKmel6Saba/b2RcRPEMjGgbg/Zx01GSUPP5kHWg5LUBQlFY4RiLvD8R4/4S4AMGKF/8A+8RDpXnJm4rAdrENMmUDZncRoxx9/Pw7bNe5BuHVu3urypB2jRKBVfNt0ABOK/JkZidCc/cbpu3qjJIGBFWJufKZNmbDj9yueVXZJF3Ny7Cc1ymcFREjSv1RO4HYB07cOUi+1WkJYXc8EpB9iYiHIQZ5oAqZEp4WdgB+Kj63Zixyt2v0XKP0gR5mXz7rwG9dCZvNeAi1cvwoHCupxCwQVYALJWoMU9DKnn1PP3w5YjkbkatLFQl8foBXa+0JTExx2YHcbU9KSiVEYpBd2qjQPTT/yRWs6fMZqihVEKnSfmbNm3Rt7a83/btm440vnOTjv/nUA6pfsy45HI2J64sOj32E+NitMnuBx1cFKukKfdIIoQ1JsFjj8HijOj/81B+5tSDcIR0xucgL69FqHwys6JrkiGALUXz/KrUdnXOeuYhYr5bXMK7qduf4/gOWZkgaQisGT0F+KEqm0Prg1njdx5A5ZnzJUZadldsZbFp9BA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(66899015)(2906002)(8936002)(6862004)(336012)(356005)(83380400001)(70206006)(450100002)(70586007)(81166007)(316002)(44832011)(5660300002)(4326008)(41300700001)(54906003)(8676002)(6506007)(186003)(53546011)(6512007)(26005)(478600001)(6666004)(82310400005)(47076005)(966005)(40460700003)(86362001)(82740400003)(6486002)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 11:14:25.0675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c572d8e-ceab-40a6-79ba-08dae4d6d99d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8184
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:26:54AM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2022 13:32, Emekcan Aras wrote:
> > Corstone500[0] is a platform from arm, which includes Cortex-A cores and
> > ideal starting point for feature rich System on Chip (SoC) designs
> > based on the Cortex-A5 core.
> > 
> > These device trees contains the necessary bits to support the
> > Corstone 500 FVP (Fixed Virtual Platform) and the
> > FPGA MPS3 board.
> > 
> > 0: https://developer.arm.com/documentation/102262/0000
> > 
> > Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> > ---
> >  arch/arm/boot/dts/Makefile        |   3 +-
> >  arch/arm/boot/dts/corstone500.dts | 182 ++++++++++++++++++++++++++++++
> >  2 files changed, 184 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/corstone500.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 6aa7dc4db2fc..4dc4df0707dc 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1465,7 +1465,8 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += \
> >  	vexpress-v2p-ca5s.dtb \
> >  	vexpress-v2p-ca9.dtb \
> >  	vexpress-v2p-ca15-tc1.dtb \
> > -	vexpress-v2p-ca15_a7.dtb
> > +	vexpress-v2p-ca15_a7.dtb \
> > +	corstone500.dtb
> 
> Why this is vexpress platform? If it is true, then add it to vexpress
> bindings... It's confusingi and looks disorganized - some bindings here,
> some platform there. Who is overseeing it? Who is maintaining? Who keeps
> it consistent with other Arm platforms?
> 
> >  dtb-$(CONFIG_ARCH_VIRT) += \
> >  	xenvm-4.2.dtb
> >  dtb-$(CONFIG_ARCH_VT8500) += \
> > diff --git a/arch/arm/boot/dts/corstone500.dts b/arch/arm/boot/dts/corstone500.dts
> > new file mode 100644
> > index 000000000000..bcca7d736c85
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/corstone500.dts
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0 or MIT
> > +/*
> > + * Copyright (c) 2022, Arm Limited. All rights reserved.
> > + *
> > + */
> > +
> > +
> 
> kbuild reports that patch does not build. :(
> 
> Except that other topics which you did not solve from previous case:
> 1. Missing maintainers entry
> 2. One binding file for your Corstone platforms, not for each of it.
> 3. failing `dtbs_check` (at least failing due to non-compiling DTS).
> 4. Subject prefix not matching other arm platforms.
> 
> 
> Best regards,
> Krzysztof
>

Hi Krzysztof, sorry for the late reply. My mail client had an issue, and that's�
also the reason why I missed some of your comments before. Anyway, thanks for �
the comments. Ccorstone500 is currently in maintainance mode, and mostly used �
internally nowadays. I don't  expect to see any corstone500 variance in the �
future. We just wanted to upstream few remaing patches on u-boot and kernel so �
that we don't need to keep rebasing the out-of-tree patches for never version �
upgrades. Also corstone500 normally uses device-tree in u-boot, however as you�
know we need to first upstream kernel device tree to be able upstream to u-boot�
device tree. Long story short, let me build this and test it throughly, to make�
sure everything is passing and make sure all your comments are addressed. Sorry�
for inconvience.�
  �
Cheers,�
Emek�

