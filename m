Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614736A80B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCBLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCBLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:07:39 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29310DF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ4crIVMT50AdDFTiFUyvJYKNuw63tAkStWsZ5GEMX8=;
 b=1RkOrbK1i6ncVwRH/Uqrc8iOmnivFsmfUpMVsUaYtybXxgrzLt5i9ncoe0Ve3ATH1AVoEh/g9Bb7y0qodHLJwjYaSUaEghOjlnFs2EQ90d5PHWj/K4hQTQVCnNfTFM2lwyTowZn3ecvHSbV9C3rixMpbsn80597nUhgq195bMM8=
Received: from DB8PR06CA0066.eurprd06.prod.outlook.com (2603:10a6:10:120::40)
 by AS8PR08MB6360.eurprd08.prod.outlook.com (2603:10a6:20b:33e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 11:07:35 +0000
Received: from DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::e9) by DB8PR06CA0066.outlook.office365.com
 (2603:10a6:10:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 11:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT036.mail.protection.outlook.com (100.127.142.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 11:07:35 +0000
Received: ("Tessian outbound 0df938784972:v135"); Thu, 02 Mar 2023 11:07:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 76cfeb340727d869
X-CR-MTA-TID: 64aa7808
Received: from b340bb095a4c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B3F7A356-8443-4959-B286-424EEB20C9E8.1;
        Thu, 02 Mar 2023 11:07:28 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b340bb095a4c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Mar 2023 11:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTF5k/bYCNGaLi3ktBBfgDmpbsQTy0+X6tO61Ym2/4xsu6lHIMbeWX4w2Mdp16Yr7wMI7X98dzGZcjIEGybwGZPR4sudG6ZL35UHJadb0ti7T1t839gP4wu8mLGo9JpsUVj5P3jg6KNBlTF4HQ57bPxFBqdgYe3jXMX4yGp8SQQEnGwrq48fTrf3BquKZnMmaZQ5I6nG5jwvcONmveSNCU9u0OOQrjfT4KEL7k94xaWF82bcDdNHpmoTmvchHPFH2To8EnQka8ZofxH+sJccaHbLnLTLuzvDFsqKjhbvAaKgwKPDZHrsG0aJCHBVLb0R2fcyrEYyz4NdOf6IwNKAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ4crIVMT50AdDFTiFUyvJYKNuw63tAkStWsZ5GEMX8=;
 b=d6WXr13jo7I/zJkrk5T0db2RSWJrLebMGQT1YRVVzgJv3DYUzzel7FPZIOrPY9WKI0XAhqnnmi0ZD83NosJKLm0Km7QOb0AkQh9p3sS882SQxpU8VXX4u8Ywzp3KQWvHTqQEN/z8ux05AeQuDbUbG04nXVZ9TNvJIu8tt03OypPpBymuh6Ke2KohtdYxNVf4K2dyj35FhM93LIoDEli+JSlqs8i/h7e1AuCZ4My2lVqU7pGY8S83QzLN/zk3MexBMCBPM4lTS8rhJZJpO7SMTpZIReYn+jL+oLhoKNt7FHYU7em9e07HI9l51+U2radVthjgXjL2z4Atum6UnAhebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ4crIVMT50AdDFTiFUyvJYKNuw63tAkStWsZ5GEMX8=;
 b=1RkOrbK1i6ncVwRH/Uqrc8iOmnivFsmfUpMVsUaYtybXxgrzLt5i9ncoe0Ve3ATH1AVoEh/g9Bb7y0qodHLJwjYaSUaEghOjlnFs2EQ90d5PHWj/K4hQTQVCnNfTFM2lwyTowZn3ecvHSbV9C3rixMpbsn80597nUhgq195bMM8=
Received: from DU2PR04CA0304.eurprd04.prod.outlook.com (2603:10a6:10:2b5::9)
 by AS2PR08MB8952.eurprd08.prod.outlook.com (2603:10a6:20b:5fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 11:07:24 +0000
Received: from DBAEUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::7) by DU2PR04CA0304.outlook.office365.com
 (2603:10a6:10:2b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 11:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT014.mail.protection.outlook.com (100.127.143.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 11:07:24 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 2 Mar
 2023 11:07:23 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 2 Mar
 2023 11:07:22 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17 via Frontend
 Transport; Thu, 2 Mar 2023 11:07:22 +0000
Date:   Thu, 2 Mar 2023 11:07:21 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Szabolcs Nagy" <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <shuah@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <20230302110721.GA4476@e124191.cambridge.arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-3-joey.gouly@arm.com>
 <Y/9+7LMtZ1c/J8JV@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y/9+7LMtZ1c/J8JV@x1n>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT014:EE_|AS2PR08MB8952:EE_|DBAEUR03FT036:EE_|AS8PR08MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: b18dedc4-6e9d-4200-676b-08db1b0e53d8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4pw66NlTRgOnMUk0rXZQQ+grD4rIlSdzr98qp2eb6549VD5XPN/9wmJ0Pic+Qf6CvWk9ZOiDukMKqRRLCwjIrQFsIuEGxAqBGfVe9C2mjJHrxnsvNabMIA8HXwM66YB7TtypzZ3hE1CHaZcCJvbgIFqhCOv23LvtOxSWNEK9LXnToNVdrqcrz4USs8dpvUAhiTwGVa+dWaYx5wmQWXdo0huWfE1MZ5P8ZpaSCuN4fXX69EraC0MPylcqXxi9LHQIi4TiQ7qoxmeqvHQgB0VoDXFZLb+4CKoygr4WCuggr/vlzmwVY5yieZf+CdV8akuqapIpTDqpfLiriwTpajvRBncwXC22ntBrJtcsVwKy7U/AXjMlGAIwzCrNYjvK91hcy7oK/FNGAxWd1mTIR1+/kJk3B2ITV5Zp1OILSKo8nIFlxzg9YN7su88AXdc6v6Di3I94tXXPfIAWelFVRq4v0gCcUW8k7qH3u+BMMJKlsh/vr6cHFvOPqeZPQyBspB2XXdDNyhWdkSZYGBOOgfZX57wEe09NREDmd87Ibf8u58fU7a+WqbmJ5Z1TP5SCyhS9h60e0QoDatjjti+lyyVP0UmfIIH2EKo3CN6Op+Vc0B0nuMCXPiSiQM90iN3L3+wwnPoL2IVYRB5ufJmrpbL9P0vai9SpaN3ON/9JDIyHPL60ibzafwgwi3n8z/Yj/vtEJR1u86kAPSGef82/RNeTw1nHVev9nJlArdw9K9MotSU=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(36860700001)(81166007)(5660300002)(82310400005)(7416002)(4326008)(8676002)(44832011)(6916009)(41300700001)(82740400003)(70206006)(70586007)(55016003)(478600001)(7696005)(54906003)(40460700003)(33656002)(47076005)(2906002)(426003)(83380400001)(336012)(356005)(1076003)(53546011)(26005)(86362001)(40480700001)(316002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8952
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a78036c7-1141-4c77-996c-08db1b0e4d65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neE+J+zXtmZ2cqsNoHfj0I5oG4jImeTjJqA6h64mfUEWQE51taeJfVRTz2BVOS7BMtHEuJbraunzobF9zxNFGz5HfsBbnKawVKco3JFThwh9wORPhVsa8CSPOw4B67FQiHDy7EiuPmJOuxKbKye+y/QSwsEfAwqW3W+D6uCFQrd7y7ZfNO4qh9T31MYgqqLiUE01HqBaEf1CeLBDcqs0tdFkHDLY/ndBXqXwy7I6GuEVI8gpF30wanjyQH6FJA7y59Bzb6ABNV3XeivvBCN477RTapZK0cyIM3PiYCbqv+AR78grN0bQ1sDHfGL1hL+lK3yiQk7zzCLU8wCPlg+jmlnLsMUArOM0nDnLtz3GvMnKuCQpZFBuCLxGTAnxFw1yw9o3Tq5HekPDQqlCgWRrZzn4NE3YS7IdXqZTbT90N4Nn3z28Omuukc+qcprr7daG18hmaGjZBfHKu0LzekwD0w7iPH2rWbJ0xadBpROnYj/qNXJmuk+Jw3/9wdqs+pcYzDCBSYYEg2O/kUj5FYq1O4z0n6os2EhuocHiuF1W+kocBYQH23/XHqGNhYJvUMbcp6oZnIatKw3jsgxfLVOPm0C61do3uWJZ3HCdT3i5jMp4uWHMVzZiJJ6XKzGDNCDBReixr1uPxpg9ckUUbW3+QaUhtZ8DzJxRpBJ5tHE5QMc1MYxx/bNpma+EGDol7c1NNKts2Hbpq5jqCfw3RwYUIw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(54906003)(82310400005)(40480700001)(83380400001)(336012)(316002)(478600001)(426003)(47076005)(33656002)(82740400003)(4326008)(81166007)(8676002)(36860700001)(55016003)(1076003)(26005)(107886003)(7696005)(186003)(5660300002)(40460700003)(44832011)(70586007)(70206006)(53546011)(6862004)(8936002)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 11:07:35.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18dedc4-6e9d-4200-676b-08db1b0e53d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6360
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Mar 01, 2023 at 11:35:56AM -0500, Peter Xu wrote:
> On Thu, Jan 19, 2023 at 04:03:44PM +0000, Joey Gouly wrote:
> > From: Kees Cook <keescook@chromium.org>
> > 
> > Add some tests to cover the new PR_SET_MDWE prctl.
> > 
> > Co-developed-by: Joey Gouly <joey.gouly@arm.com>
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> 
> May need to sync prctl.h into tools/include/uapi?  Otherwise selftests/mm
> build fails here.  There's also one compiler report.  A fixup attached
> which works for me.
> 
> Thanks,
> 
> -- 
> Peter Xu

I've CC'd Arnaldo because they seem to update the tools version of prctl.h a lot.

Sorry about the 'p2' variable in the test, was there for some experiments but seems
I accidentally included it.

Acked-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

> >From ce8e17c244fcc743c7006316dd431c5650480756 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 1 Mar 2023 11:33:34 -0500
> Subject: [PATCH] fixup! kselftest: vm: add tests for memory-deny-write-execute
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/include/uapi/linux/prctl.h       | 6 ++++++
>  tools/testing/selftests/mm/mdwe_test.c | 3 +--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
> index e4c629c1f1b0..759b3f53e53f 100644
> --- a/tools/include/uapi/linux/prctl.h
> +++ b/tools/include/uapi/linux/prctl.h
> @@ -281,6 +281,12 @@ struct prctl_mm_map {
>  # define PR_SME_VL_LEN_MASK		0xffff
>  # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
>  
> +/* Memory deny write / execute */
> +#define PR_SET_MDWE			65
> +# define PR_MDWE_REFUSE_EXEC_GAIN	1
> +
> +#define PR_GET_MDWE			66
> +
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
>  
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index f466a099f1bf..bc91bef5d254 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -163,9 +163,8 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
>  
>  TEST_F(mdwe, mmap_FIXED)
>  {
> -	void *p, *p2;
> +	void *p;
>  
> -	p2 = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
>  	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
>  	ASSERT_NE(self->p, MAP_FAILED);
>  
> -- 
> 2.39.1
> 
