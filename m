Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EDA664FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAJXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAJXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:21:18 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B363F5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:21:14 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AMem1d020056
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:21:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=ElBnPNoTxbyBPN6mGb41NhgvcpxMujWOMh5vjRpw13o=;
 b=OfNSaScnOm+mZrKU1nVA8TjZI4myjNlpWN5L2Nwf25Vsh2duskqeM2mxzZV3KYBls0AB
 dt4LET9WRYdYQTI1MgJggD0CQ1t/nbXifNVcWtLJ3F39zUAJQoeCDOZOFXnmSGmLLQto
 ODrfjKbw8RpY0YwGzZlFoTy87HypqRCR5/iNn4O4GlJr/QUB5L5aalV5MOlhOEtbMxX2
 fXAXb3xMY/46pXyxS9+q3czDjf7nHmDk8BHDprlpbAK33pes8TnxsVKgqZqRBo9OWfe9
 l6Wc85f+FnA+xhALYEWnXK3mjXrksuw1t6OwXRgzNP29pVwkjUyhBXvy/4Pb9hil/1FU 5w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n1b0q2pt2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:21:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQCbvqU+NS4HS23FcNo+jBesgECQZJALeb9awGKWiDwmA4HhRaY0a4QSo1xCRCZ5mnGuri8EFV31GydsV5Hr94SEnqWRU8zqhfPLYk+uhQ4gT+tlyY/k5+ZSTFvi3id9SgoVHMmrQyzKX9qp0IqCbHoN2y3vKUndH5YXBqKREVb/6ZjkJ30mKG0WuK9m0b8DpsQdFV+Io9tCrGfghILVAoy/6A7Ygsf7tkfTKWe+o0CKZfsyu3NaGpwuG5+w4eGgKeB/XBUKsfDf4uBFij0mAd9wbDqaAqA7ooAkhI5Knn5AcNTBVATMT6S7WekQNID1Nb0coV2BBLsF7c6/+KGx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJKEITeuYH74lP6fZejgFKEuUQ/ShJfBPYSFykQ0v2c=;
 b=EyGt5gyV899PfPpZlwA3bbmPN9OnJMHRZioRbfM9WF4/kxk3DYjns5rANfvOL0A2hWxUrT41huw8BM/w4S1KbwGzfbPEjogykLTrIDhVgHzph8QQ5ACmX+W29Mt5BlP0fh/5DXBpj3azaiZfHr81NfwUwFjZCNB4KX1xclRMITgwcl3Wa4jgVDI/U40K8wX4sAW3a/3MYrPyRCsTfp9FCK4dEJ+Ejt1xw+0Wkgorn1sArDyUa2GHVARLwclaqeLgxHYI/VPBzzWsdxYx7gU+TIWcr2yRAH9mNJulAVeJr62vk2bdXVM1xM05VSkC9d40OTGT3vm1aGv1NHeHoi2www==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MW4PR15MB4507.namprd15.prod.outlook.com (2603:10b6:303:108::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 23:21:11 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 23:21:11 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the
 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
Thread-Topic: lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the
 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
Thread-Index: AQHZF87ejzbFHyM1/Ui4ZjVt0fvk1q6YZNQA
Date:   Tue, 10 Jan 2023 23:21:10 +0000
Message-ID: <B251F283-9183-4BE8-9790-7E1F605F1185@fb.com>
References: <202212241900.qp4rtcCs-lkp@intel.com>
In-Reply-To: <202212241900.qp4rtcCs-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|MW4PR15MB4507:EE_
x-ms-office365-filtering-correlation-id: 8df56b58-c519-4238-ee82-08daf3615c2b
x-proofpoint-id: b222f61d-39ce-4c00-bf68-b051945dbb5a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETvojewx34EwgU3y6dkGlMsuxQj/eFoq8sfBSygH/RPA62cPhwW6iS0IL9Q/Y+6hfluHH4FEoy4RTPXNPolH731qqdu+ZfYBXerR1GB0HIiwGplSGbWnCQrlUJGGqk9BoRCXyqw5or1r5uAClnzhLjI8hoxFqRzDNHXbgaShL+WjAfNWNixrrPZ0FQa+TCjlc0seN40gvFOuIQekH0t3J2F1TuByaxKhu+17vHOVN7UaK4zWdy74A6Ex7Szzu6GyEQXk1XzzSt1p0QSCALunwqGUvoygDeqWzqdM1U3UDmJ4DNAa+Ob60M24hdU0GdLt5uqJvSGnkur0nzyhLjcuF4ldI7dKa76cwxYDBNvujZ8HYtplt/Xrp8bex+4OQ4sReuz77vIFk1H8X2t7TLsVJmNUBJKem5jWSvQa+qiC6nxwrCDvx8pdDDR0EdRFe4mYR44zOaYuybu1BJoPkuM4St9xzkRR+WfAca2Gv0lub26aReNAAoAdxfwHC+f4y8+gxc+LUOLB2XzSjlJ37tru6HQVq/ljv7k7PP5ypHh2N0CZvuHFjom0N96QRj9aBgz894+SoaoJT0HppGWbWCJIf7f87xu6O7vbMGXPTF1teUwXI8fx+kNok9jsopF7haGl9uLCJLAGAge4ss1A0q35Dr9on1HKW/Xs2LQPpypT7mm6LfhLaowD3ih2cHpLyTKFA15EWnNtmIF01kymXCD4udu5Wq40SiY2/yISRz799Cg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(33656002)(6486002)(53546011)(6506007)(478600001)(966005)(4326008)(26005)(186003)(9686003)(64756008)(6512007)(66556008)(316002)(8676002)(66476007)(6916009)(66446008)(76116006)(71200400001)(54906003)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(41300700001)(66946007)(5660300002)(36756003)(4001150100001)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtsC9E37BjoHCsezeBjZ41KZi3NcWhPk+Sww4y/HEqzlr1pqubLm2wgZga1V?=
 =?us-ascii?Q?lgkTyRvq7reDpjWH6D2lCVE/R1qNBossyrNw0tKseRwahBktTSWoCYZhdVif?=
 =?us-ascii?Q?OADJtZvw9B+oDpWqvkmyW9wW/hm1QxfvsIlzTXMISCGnXbV+XpPcjk76bA1a?=
 =?us-ascii?Q?ekl0Tu27bZAs5wQ8sU8tK0M4KRMS1zSnvLXFEQx/h4ULHlZmicbhvl6Wwkou?=
 =?us-ascii?Q?nERgHUbEmI/JOw+h7E1oUMkrSXs8dp3iv220WIRqZOv2vTF2+yseQL2mVG6r?=
 =?us-ascii?Q?6v4L6GwjVajbeOWICK+JrKp3JcL+U0Bp3Hz4fXt10IawR7ze751biXeYX5vU?=
 =?us-ascii?Q?t4CMktayp1vG5KFQYAsn/yXOr4zf18HsSY9MKIZgaQ/3pUQllEacGDSnLzk4?=
 =?us-ascii?Q?knX4lwl9jSvq8/cjcsB0Zivb/8kS8yFlKu621ATbn1I62uIQXtlnO9cf2H4Z?=
 =?us-ascii?Q?JrS1vYxG9y5VT01zDSTN25T80Dh2YNltpBnMb0fbTxjpzH2YSQAhXngqnSTo?=
 =?us-ascii?Q?DSxIhx/fcZvmDKTK7UPGL8dn8HFECL7AnPFzgfd1rTegQys1iEcrsEGmsPYM?=
 =?us-ascii?Q?jVTSOaptln4eclszWMdZ0wUkgdA4TXtBJl2uoQxMU2YIt1Vbk3zxsYZBhRfx?=
 =?us-ascii?Q?KXTNe1gvnu2YYO6UWs+JDrLHs47hC48s0vh6xsXvadUNvfVwZPNdt036GFBg?=
 =?us-ascii?Q?z/57rLqZrj0A4JJPSJBDs+ngFH/gkcWfD649TXZu/ExgdMtGsdE9bvSkGnOx?=
 =?us-ascii?Q?VVCWYP7eW13JXwCHYgbdk8YuOzYvag9v5JyYQ4VBqX5Q33ErRHMw20sVhsRw?=
 =?us-ascii?Q?PPc5/UQCt3qQ2qCaErgSAE5CWZfz5BlsBKxizTI9U4trCxe51Xufaii7vTFu?=
 =?us-ascii?Q?B5rRTRkz6sSAokSWidFfoDxGa+T1W+PvtVXoscS3qrZQumPcXURcdAWvlN13?=
 =?us-ascii?Q?HSWapm4cUFqZvOQ1/FkrNEVXjdTlnTu/cLQ7B2JQfTPZMoXHG8EgDsDnwLBd?=
 =?us-ascii?Q?ME6FnQ4rcZP/gb1s5j+qUHwe6zb6JgDRd5jbZm6ZBW4Db/BuTeZT0Y8IbuD8?=
 =?us-ascii?Q?f1GrWVocbEsvuXb77jW3xcPkPPsPEBfNfsxD6KNdwTJSAjP2aAm0uMxb7xof?=
 =?us-ascii?Q?eNjIJ5Cv8AfwfbwWLTt4jfWAHbST7ZwXySsIhkMJRwvcNmcHHjVvRztH/JVd?=
 =?us-ascii?Q?NhI3bmexmV+6RqXOEi2Pw8Y48QV2apu55By4NaI9+Z8ko0mjjsAZC4XyeGJM?=
 =?us-ascii?Q?P/8TfVShGi+ngux7kw/MEwc397Ko80V0O9TP/tjF+gscAurt1PYJ2Lbw8jsY?=
 =?us-ascii?Q?+3gPmfIzHCdmX+QMtd/U3n2cqB6k32B3MyRXnHO3NON62xeKwDtCZdkCCldk?=
 =?us-ascii?Q?7RIlNt4cfoSsYJYw6tk7yXJCRCrv3XI5J8z3GBqCms3qjKSF1B++XQQrcNer?=
 =?us-ascii?Q?xxGsdqO56Ws8ba1SjDeZ1gA7DkZyq1zwpy0qzKjiHbEAh50fMTafP1R5l5hE?=
 =?us-ascii?Q?6dTCVqiWEeu0lEJSYMpf7ogwUTP+tpGAouX1Lb1kQWZnsN0V9pfWOLLpJG1Z?=
 =?us-ascii?Q?PK7LoHfQqBQyRxlYYHi3hZorimAwXKHDHAN2yg/H?=
Content-ID: <3320C04CCAA05A4D969A80146ED771D0@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df56b58-c519-4238-ee82-08daf3615c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 23:21:10.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMSf2QhPBbAIVnN1mI6QD7+GV9l1QywG+425tmjVFK+DcrQgqN1JwvGJE55ocyRLGeyOeaHEzimC9EQoirxD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4507
X-Proofpoint-ORIG-GUID: kv4ltXY-yBtesCS8q5GGSQopUhgs2kIA
X-Proofpoint-GUID: kv4ltXY-yBtesCS8q5GGSQopUhgs2kIA
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 24, 2022, at 11:35 AM, Dan Carpenter <error27@gmail.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   72a85e2b0a1e1e6fb4ee51ae902730212b2de25c
> commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
> config: parisc-randconfig-m041-20221219
> compiler: hppa-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
> lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
> lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
> lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
> lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
> lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting
> 
> vim +/RANK_POSITION_LOG_BUCKETS_BEGIN +460 lib/zstd/compress/huf_compress.c
> 
> 2aa14b1ab2c41a Nick Terrell 2022-10-17  457  static U32 HUF_getIndex(U32 const count) {
> 2aa14b1ab2c41a Nick Terrell 2022-10-17  458      return (count < RANK_POSITION_DISTINCT_COUNT_CUTOFF)
> 2aa14b1ab2c41a Nick Terrell 2022-10-17  459          ? count
> 2aa14b1ab2c41a Nick Terrell 2022-10-17 @460          : BIT_highbit32(count) + RANK_POSITION_LOG_BUCKETS_BEGIN;
> 
> This define looks like:
> 
> #define RANK_POSITION_LOG_BUCKETS_BEGIN (RANK_POSITION_TABLE_SIZE - 1) - RANK_POSITION_MAX_COUNT_LOG - 1 /* == 158 */
> 
> So it's a macro expansion issue but harmless.
> 
> 2aa14b1ab2c41a Nick Terrell 2022-10-17  461  }

Ah thanks again for the report, this is already fixed upstream in commit ee6475cb [0], but that
isn't in the v1.5.2 release which we merged into the kernel.

I'll go ahead and backport that commit, and fix the indentation issues upstream and backport
them as well.

Best,
Nick Terrell

[0] https://github.com/facebook/zstd/commit/ee6475cbbd04408e721c4daa87d993faf3b3c1cf

> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp 
> 

