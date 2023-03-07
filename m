Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333F86ADD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCGLRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCGLRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:17:01 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4D20078
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UEBuDKS2AmYF5KHVPKkP9GV6ErC9WRB54zR0Z9O4X4=;
 b=iT21zFfBaD28mVDjMhuyUSZ1+jeDmDGpFhkloaIoV63JTHeXdwhhN4BrhkFX4MwJLuv5XXSLxDql1gVvhehtDSLzKp4IZdyFPB8jJes7udNtOmPX8A52dfLvIX5/rIixthuUT7liwk7qBxeeaPWNV+CNzZcSzaihXPvAGfi6zVQ=
Received: from DB7PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:10:52::17)
 by PAVPR08MB8896.eurprd08.prod.outlook.com (2603:10a6:102:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 11:15:20 +0000
Received: from DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::7b) by DB7PR02CA0004.outlook.office365.com
 (2603:10a6:10:52::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 11:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT015.mail.protection.outlook.com (100.127.142.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28 via Frontend Transport; Tue, 7 Mar 2023 11:15:20 +0000
Received: ("Tessian outbound fcd8b5fba459:v135"); Tue, 07 Mar 2023 11:15:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0b1e6a6ba2a14b42
X-CR-MTA-TID: 64aa7808
Received: from 7ea485230abe.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5CE11E41-F8AA-4BF2-A38D-23F5D40C7C3B.1;
        Tue, 07 Mar 2023 11:15:13 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7ea485230abe.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Mar 2023 11:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anLuDkUL4FgAlTMbieMTwIGCFdzG4VYv/juDjIzKAxO7T6+u5JOgh148+3odeduh59/0RTahOUlqcAZ7/bNCI0IOiceZrI7zKjwYQa1KAdj2TrdJzC0PvcKR+IbG+3aSBphAEvlfCkAr8g2fMTi6MBIQruY78yWOCRilCF1UGe5X4MKQOVl/bTIMYqJkiE9co6nqu5jlsWNHL0kLwgiwRnFh2IDLHmqqw+vHduqUbTJNR419otTaoRejftx32gfaySOVG2N4Y2KqZGPqv17/AWNH8/8ObWCKexCBKzrYmTDZ8ACI64P1q6oP0xDuVNCdUUO7Y6jND3WBQ0fBna0eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UEBuDKS2AmYF5KHVPKkP9GV6ErC9WRB54zR0Z9O4X4=;
 b=jn4TDI8Kmg8/80kOX+pDDyqcYLqB21gEJvs0Y7yHTJd+yZRLUNDdnxVpxvprPt4/fHoNu32FK8zoOB31RB/l0EcyhuTaBY7XCSrc0Gl5NCVkdrHUG7i6cPkyvfSrBIUcGAopv0dTyVh57FlV3VoGsiQfgWfD7ZZ1ByJGUeqq3TQxlQPhnuntbCQ//RjACjpI8JwcSQa5klpzGxfQSNS25LiOeWIO0RZgKl1OCc3cbEYwxN0FmZnOdY38qy3tmbSRk7NyS1OUl98hMPi1cS23+QtYU91A8ABa47q1S8HKYGqITpnO85rjI0HlFXuLlHuUYSfYzcq7p1S0AUayVWsQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UEBuDKS2AmYF5KHVPKkP9GV6ErC9WRB54zR0Z9O4X4=;
 b=iT21zFfBaD28mVDjMhuyUSZ1+jeDmDGpFhkloaIoV63JTHeXdwhhN4BrhkFX4MwJLuv5XXSLxDql1gVvhehtDSLzKp4IZdyFPB8jJes7udNtOmPX8A52dfLvIX5/rIixthuUT7liwk7qBxeeaPWNV+CNzZcSzaihXPvAGfi6zVQ=
Received: from DB6PR07CA0086.eurprd07.prod.outlook.com (2603:10a6:6:2b::24) by
 DB9PR08MB7608.eurprd08.prod.outlook.com (2603:10a6:10:30b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 11:15:11 +0000
Received: from DBAEUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::75) by DB6PR07CA0086.outlook.office365.com
 (2603:10a6:6:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Tue, 7 Mar 2023 11:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT061.mail.protection.outlook.com (100.127.143.28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.28 via Frontend Transport; Tue, 7 Mar 2023 11:15:11 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 7 Mar
 2023 11:15:10 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17 via Frontend
 Transport; Tue, 7 Mar 2023 11:15:10 +0000
Date:   Tue, 7 Mar 2023 11:15:09 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nd@arm.com>
Subject: Re: [PATCH] arm64/sysreg: Convert HW[RW]TR_EL2 to automatic
 generation
Message-ID: <20230307111509.GA19068@e124191.cambridge.arm.com>
References: <20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT061:EE_|DB9PR08MB7608:EE_|DBAEUR03FT015:EE_|PAVPR08MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: a7918824-0ef2-4065-60e4-08db1efd3cf3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yVIBsZtYZfZtsmYZxb3IiewGNwnkJI3Y0g0lciyhD7t/f7FD2J0U2y3/AmOgcdEo/Y5bWr70o7qxCEXQFL4TZlOtbtYcCpALAd3Io0YMFlXj1hV9rSpAtbgrMZXm+HW+lCzfMjtUfFMsI8hzhcehnaX4QntfukDTFSYhRQR1HqnYXbB1kD478HzBOKzn2ElE8naWaUJg7PsiH76pfWLZEzyixkSFQlg7HGt6FFB7euhv1UuCwF0uYza8+KRLnqFiesFTWghytHsE8SnRCWyRT/iCZ0JUKIKGtUA3o5OLPO60jTuBlzc1o7iOQW4J4OVt90tmjOKXuXbo2CVLHYgOYTUsfvCqAz/0/Tm9/IMIfmVAUuWE86Avbz0sIO5Y318XAd1L4RkIvLJcFxDqm67QQU1MYmIUjYjgvAGTFbCXYOTx5/QBEAJhdVIZpf0eKAOcvkBtVxRjMsGMlZjpDzcm5IVA4IVAh3imEzNJ3R0fflI04tjI+YUluBOf5vlULYt8135dRA2DHvkgx7sm+h0Dr0q0r/BzP1DPBJj+XBRl3zJCaIWPIneJpniB4TG4fQQmAGCzcoCU9ELuDRRle2e6QqheeTcYfvaUfmjyECJ5rRQvoBSmdorRMt0CqrU6PHDVh/pqUtbBdCrai4E0+O4F+ryzeVDs+4fA/MEW0Le1q0h+32Mfm9ziMu1Du5a004B3LL5q7o3uTdxebd4Bm1Q3RIlHsJ5JSPOq3SPmqvEQBXI=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(356005)(86362001)(36860700001)(82740400003)(81166007)(33656002)(4326008)(70586007)(44832011)(5660300002)(6916009)(41300700001)(70206006)(8936002)(8676002)(40480700001)(2906002)(82310400005)(47076005)(336012)(40460700003)(26005)(186003)(83380400001)(426003)(19627235002)(54906003)(316002)(7696005)(55016003)(478600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7608
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a21ddc6f-9186-4596-d1e9-08db1efd37cb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wudSP+xv64prNPQ2RdaV4a8bYMDPZcAP6oyypNWtlrQrtOoU8XCYMJT2li0wse1jGLtaQ7epjUz/EbJ0YUfEG/CeHo7KZyGTJnfpOODo5ceymb5AJ073a0HQhbMbb2uBZC/R3SYCk7i+lLQpDBf25Rhz5WSBiSxs1v+KFyl+HPG3X3KPWhrqd+aVujBI4F7w/H1xrUWMlvsXmYYo/aYJAFszWsLs+zXTV9fG9iubicqTmpyOXYV0xot9BeuL8358x+k4LSkU2WmKJGzm/iNMSkiuBX+9QUDA2xbYWUotnC1T3avPr0MC79sEPs8oPs9eB/tbb3om5akE9sYWmwdscPvmVwdAISkBCVhyJc1B55RnsxPYRt9CC518VOhkJkhIncx49gc6Vt/XUuvU7g2W4+gpQge3FQ1t95/ZQiuOpb7D6cxtZTHYBbKFHfhTcTqk0V5uNaMmbj2V8hNtlpqcARQemDOEnOs1YhAUWnZpVjgnr5Q9tribGYq4UfLGnT4lTt5PZkgDsOzJm5kOapn5RIjm1pA55uBL3c5cTsdTxGIqV+3uR5MXIGL9YtND6CCBkveDRk9eXc6xWIeYNaNdVQ02jQQ/CWrB9uUJ63/0Kple/QscW8Wc8NrDd3r2okTFFcVNM89aKbviDCGxzpikag0f+qaXC3iF8IMH8dsK020JMuA+gvSdCJgK2Nx5QfJ+8D4UW/0KYbX61PsBh32lQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(8936002)(6862004)(2906002)(41300700001)(4326008)(70206006)(83380400001)(70586007)(8676002)(316002)(54906003)(33656002)(19627235002)(478600001)(7696005)(1076003)(40460700003)(47076005)(40480700001)(426003)(55016003)(336012)(82310400005)(86362001)(186003)(81166007)(26005)(82740400003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:15:20.1199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7918824-0ef2-4065-60e4-08db1efd3cf3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Mar 06, 2023 at 08:46:18PM +0000, Mark Brown wrote:
> Convert the fine grained traps read and write control registers to
> automatic generation as per DDI0601 2022-12. No functional changes.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  8 -----
>  arch/arm64/tools/sysreg         | 75 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e3ecba3c4e6..e5ca9ece1606 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -419,8 +419,6 @@
>  #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
>  #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
>  #define SYS_HSTR_EL2			sys_reg(3, 4, 1, 1, 3)
> -#define SYS_HFGRTR_EL2			sys_reg(3, 4, 1, 1, 4)
> -#define SYS_HFGWTR_EL2			sys_reg(3, 4, 1, 1, 5)
>  #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
>  #define SYS_HACR_EL2			sys_reg(3, 4, 1, 1, 7)
>  
> @@ -758,12 +756,6 @@
>  #define ICH_VTR_TDS_SHIFT	19
>  #define ICH_VTR_TDS_MASK	(1 << ICH_VTR_TDS_SHIFT)
>  
> -/* HFG[WR]TR_EL2 bit definitions */
> -#define HFGxTR_EL2_nTPIDR2_EL0_SHIFT	55
> -#define HFGxTR_EL2_nTPIDR2_EL0_MASK	BIT_MASK(HFGxTR_EL2_nTPIDR2_EL0_SHIFT)
> -#define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
> -#define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
> -
>  #define ARM64_FEATURE_FIELD_BITS	4
>  
>  /* Defined for compatibility only, do not add new users. */
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index dd5a9c7e310f..cbf8c7ed633f 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1866,6 +1866,81 @@ Field	1	ZA
>  Field	0	SM
>  EndSysreg
>  
> +SysregFields	HFGxTR_EL2
> +Field	63	nAMIAIR2_EL1
> +Field	62	nMAIR2_EL1
> +Field	61	nS2POR_EL1
> +Field	60	nPOR_EL1
> +Field	59	nPOR_EL0
> +Field	58	nPIR_EL1
> +Field	57	nPIR_EL0

This should be `nPIRE0_EL1`.

> +Field	56	nRCWMASK_EL1
> +Field	55	nTPIDR2_EL0
> +Field	54	nSMPRI_EL1
> +Field	53	nGCS_EL1
> +Field	52	nGCS_EL0
> +Res0	51
> +Field	50	nACCDATA_EL1
> +Field	49	ERXADDR_EL1
> +Field	48	EXRPFGCDN_EL1
> +Field	47	EXPFGCTL_EL1
> +Field	46	EXPFGF_EL1
> +Field	45	ERXMISCn_EL1
> +Field	44	ERXSTATUS_EL1
> +Field	43	ERXCTLR_EL1
> +Field	42	ERXFR_EL1
> +Field	41	ERRSELR_EL1
> +Field	40	ERRIDR_EL1
> +Field	39	ICC_IGRPENn_EL1
> +Field	38	VBAR_EL1
> +Field	37	TTBR1_EL1
> +Field	36	TTBR0_EL1
> +Field	35	TPIDR_EL0
> +Field	34	TPIDRRO_EL0
> +Field	33	TPIDR_EL1
> +Field	32	TCR_EL1
> +Field	31	SCTXNUM_EL0
> +Field	30	SCTXNUM_EL1
> +Field	29	SCTLR_EL1
> +Field	28	REVIDR_EL1
> +Field	27	PAR_EL1
> +Field	26	MPIDR_EL1
> +Field	25	MIDR_EL1
> +Field	24	MAIR_EL1
> +Field	23	LORSA_EL1
> +Field	22	LORN_EL1
> +Field	21	LORID_EL1
> +Field	20	LOREA_EL1
> +Field	19	LORC_EL1
> +Field	18	ISR_EL1
> +Field	17	FAR_EL1
> +Field	16	ESR_EL1
> +Field	15	DCZID_EL0
> +Field	14	CTR_EL0
> +Field	13	CSSELR_EL1
> +Field	12	CPACR_EL1
> +Field	11	CONTEXTIDR_EL1
> +Field	10	CLIDR_EL1
> +Field	9	CCSIDR_EL1
> +Field	8	APIBKey
> +Field	7	APIAKey
> +Field	6	APGAKey
> +Field	5	APDBKey
> +Field	4	APDAKey
> +Field	3	AMAIR_EL1
> +Field	2	AIDR_EL1
> +Field	1	AFSR1_EL1
> +Field	0	AFSR0_EL1
> +EndSysregFields
> +
> +Sysreg HFGRTR_EL2	3	4	1	1	4
> +Fields	HFGxTR_EL2
> +EndSysreg
> +
> +Sysreg HFGWTR_EL2	3	4	1	1	5
> +Fields	HFGxTR_EL2
> +EndSysreg
> +
>  Sysreg	ZCR_EL2	3	4	1	2	0
>  Fields	ZCR_ELx
>  EndSysreg
> 

Thanks,
Joey
