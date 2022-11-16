Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31662CCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiKPVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiKPVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1613DDD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLdKiQ016874;
        Wed, 16 Nov 2022 21:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Hj6QP3AF4aXAFQOvMDiGMeqsass/ASyHJ9oGGdbl6H8=;
 b=q/o6WyCgmaz1Woru8KgqLCXFIXwpM4JeB3Ot2RiORKmhI+h9yPcqvxmD7qy5KEpJCXw8
 Bi/rJDOOKL6tsP6PACOL0f6vjCBNe4RhOZ4+euSpvO8jf8R9GW8ZbL1sQHt6xEe1pdvQ
 jGSZUPkZFdC2A3xFptGJqfKA4Sgst4nvZkhLwCHPumx71OouJf587kuYW9N1Q72C/+R1
 uy6bWOU3QWKVUaUcQkkzAw7yUEM7RInUzF8pm3st5Gjb8OOSoLIIAGkDCm1XBa/TixXi
 ro/3RZagpJW+nJOgatMI9a0VHUtZW5ncw6M96oTuTb5k8I65bSvSAjvxh+Uk7ia+qEwf hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htxthf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGL1Ye1000301;
        Wed, 16 Nov 2022 21:47:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k8y3q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3rI4Or7TLDa4rgJ4qhYMnVX5Z9he8kuEzTAeu+mAPJ56Fs+bODVMDZfA1VzaL4IdXpnQPR4u5jr6v+WT5UgjiC7vjU8sLbAFrwbH6U0W1GqHcJi5wyfTvsMmX2d06AYLTKi1865+2zX3qE9PDxs38noLjFahbg4Qc214yjTO+PfnDEWb5+Q/aYUgUB7ZxGQGN1VC2J3uR5ymefDQGaUSwhBwVrDUHmJePCNliBKqTp1EvFK6rDW07GCN+uGTYhACQeH5O1b/JDi8m2p+aNOaQk2uKcu6AM67zypbqhsbl3vXycEhs+yC8oZDMD7k+KBD0QQSAF3ubrzUtJ7ZtoZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj6QP3AF4aXAFQOvMDiGMeqsass/ASyHJ9oGGdbl6H8=;
 b=cKsujr4YlWzeLNel+5YvZGKVVC7kY0jHS0n6k+Kr38vmfSd8oIW2FrRqU1/duB6NqMcxg84Kbi+Z+E2naN0DNAzPSyOv7+ryJ3AZUGgZc4X2kh0Zjw9teAZPDf5izoGfTbvu8I69webQHg9iNwwNPZOk+RSv/o0lAP9QBYh7DWrpLFmjToc5YtEY8alwd+u5fFx2fA0wNT29xeJTAMRFhos8kW9ti+ep6dlIAVO+DjSGgkbuyIUZxKE8scENcFJqECV4RM9mcI8wnrMY0/ndYi2bz3+XXdoLsovfCVfCLz/Lk+Wgz/dyhcZT4mWTRAZVUc6oAxiMLa/8IBzfwUdBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj6QP3AF4aXAFQOvMDiGMeqsass/ASyHJ9oGGdbl6H8=;
 b=RemdNfOxjzYZI/YtNq7T0lnR/qQHWb4HJ2zf9ci+4Sy/EM5MBpW6LGh9Efa2lbEP0SDNmW7VWlmE2ho4Tje0o2SNKXhG/Co1Sh4jrzsRBs6sharMoRY3np1ynchFGDaTWgKROHlsBJQEUYIebu0eXoCa8FzTbZyH/kWimPVSV9k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:46:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:46:58 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v14 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Wed, 16 Nov 2022 16:46:39 -0500
Message-Id: <20221116214643.6384-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b885ac-0fdd-466c-0b3f-08dac81c1638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZ6hMcNovM5RjaW4AR2rAuCGjHUG5P6nk1pUw43Mhj6PwHj5Gp+kUHz62l5NR3unxMMbErD60nHD5oDKofBLcZFYIsuJQQBHsY9rdCvQUhlOtAQyWPRN82fU443Spwpvq1Sku5yGVLIXP7mcN3BnOdiEMmYOIrB9ZcrPuJbdtQf4Eq/68Ot0egge2drf9N20v/diVapV5HjG/Gtj0wNKs8ayVrU2XebquUVWg9SkAzURk1UnLqezCt6wLCRv8JtKzjKCmiLl6XGh8AbDqHQZjeREztUFnY5mCMDyCtaIqmgZb8cZ3kpUcYlrkRY8bCqR9FDX1Y1fdJ4xQ3DQY21BX5WMUOe5skWa/PwrhocZn+XEIJadok/nheELur0lXoZKAiz2IO6WAebS5jHu9ypddXTF0sTVcStZ9k4rqcHFZudSpx2tTPN9e9IlivFwJZlt4IBW3YHnot9QOrucEOl9MIcukfUMC/W6bGbn6oAWF6n8FDyWJq7nUakQiLBxyeyi8uQTCmbPSVSXPO+xJiVDK7mI9omT/5XEjpCt2pkAuA6O7CSg+SdxStAkb4WIyDRFF6EamhR+fMFhQVbGh3YDEaM5K7k+EPWf5T9HTVxb/x2FraPt61uCBMnv+2MVlv+APpbX4iJoswoJncvsOvvgHs+TeFvjYH4B48GC0vBClSEtyhascm/LKf1nEw2rLmMdPk1obj1LXs4u6fQmUXftkij6NvqnaLV8pXA1ceK+kXE3eF6ieDzBMretxPJysjEl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(26005)(478600001)(1076003)(6512007)(186003)(2616005)(6666004)(107886003)(86362001)(6506007)(38100700002)(36756003)(8936002)(41300700001)(2906002)(5660300002)(7416002)(4326008)(66476007)(6486002)(66946007)(8676002)(316002)(66556008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpCiMizW8oUP3Tjc87UfSxqdpd7mvvzEAXpIrSkbT6odY9Qv7hlALNvGKhZT?=
 =?us-ascii?Q?KJP880F47ahQZC59cOHDcyOvInAt+bbCIyJ1pSy9gOVOPs5zwxIb+VwvpPQl?=
 =?us-ascii?Q?x+Ox+uQYixoqghgCLr2d8+jBMa5eWZVK/y2WIljsM3xQulWhaGQP3XKHaZ7B?=
 =?us-ascii?Q?gkNd2qBOYAuyO5VdL07pN9wYR5QMhieQOJ2HYGqky8MfwrOaJVlX4jpMsEG2?=
 =?us-ascii?Q?1RdGV62K2EVjuOxm2T+VzCbK6RCsNQTf9PPPWTUlVhu6ZGbxNCh7qlbScxlu?=
 =?us-ascii?Q?UuFnbcXkC7jg3WbR8zqGdSdGKMgqoStJYCJ6tEi2eRT5vU4ndeQO/Igz9jXt?=
 =?us-ascii?Q?jp+IGGs2rNbQwNFMiFfxaX/7UInjOmb3PTTxbVF2bU4ld1ZV6QenL0oJVxC9?=
 =?us-ascii?Q?LQiXEddVGZ3Ss+iyjrvUZjgeJaL46hwMOic2mml4A7FerSkdk5kfqhvfyMrU?=
 =?us-ascii?Q?2y2XuHs6gHbiG57N0zWJPOp1VVm8YP3+qINiSNidA6PzMCjRiYWaWrnMRJcW?=
 =?us-ascii?Q?g9+Y8JVSDfXFIH11RhzQtNFjhxQKA29w/6ttHSjp9zTPRJ0e3hl/xPzd0Hqv?=
 =?us-ascii?Q?Bp+bbguiCGX3Paq2xdvleIcFUGTP+Xc6BTofeenLXmlhnkaFXHgWWCKYg4hL?=
 =?us-ascii?Q?iNPY1OwmbNDC/VUn2B/IxAlnjFimHxVIIGC1XX8bUwkGUOEMIMzACQKt7E92?=
 =?us-ascii?Q?2wC1rc/q0er2jqwdOI3b2CglQEW4vtOFNmiJKJkmjnXDwuRMlw13UQ34rA15?=
 =?us-ascii?Q?J4fC0Zn6yHiHSpCEy7ewZR/kF8k2k+Mfvhs/w+rLr4lHbBCJkcWu3rq2mJ8V?=
 =?us-ascii?Q?30/wVuR2nxN/MZz8uxXxzqRYMO3Ex06nvAGbqkvQfE/ObYtDOvra8Lu8D6wM?=
 =?us-ascii?Q?knT/CobXzlatU8FckTaV5HZ9RuthbUs0EayrzzwZM1tpoWulU7Zgy6yBDL5Y?=
 =?us-ascii?Q?cJgtlvJbu+/dpbk/L00gQ5gSMKwLmTWgh0SgMc1hC1qQ4seuCGSQbSQi+H8Z?=
 =?us-ascii?Q?SapwqogzDGChuSD2awirmr7ibCKi8iENPnDP0Skz3mvZgpTwBe/mWChubYk9?=
 =?us-ascii?Q?GTkcWaUdoisEgYYU2nQrz77APFj10/63zvr1mG32KgIfvpgRRl+CFZ4lvp7Z?=
 =?us-ascii?Q?sOr4F83eVDouVOR33nEQyBqGDkW47xE7ckznq6m+nusI99zlVdvRUssxD8N/?=
 =?us-ascii?Q?PZeuz2T1x8v9IurPAnap8SBuvoOhZ6prHlVfIe/yK++N4TLbHEMpYUmhQjHj?=
 =?us-ascii?Q?Nla85bbkfU6r+YAvI1JFv+4YM0n/JbJStGk3qhzvICpYdo0XTINtFUMzNoM7?=
 =?us-ascii?Q?NRR2wFJLRYS9yMPskpNjar6XobEGwqQRQ7tF/f7rIOvHyJHTwPKsiWidgeT8?=
 =?us-ascii?Q?1fUQ22LabUYGb0ZJVwnXhc1wB3Fd6ZRCpPbWgrs4Aw8JcsjGj9ADr267KRas?=
 =?us-ascii?Q?6514kLhZOTqV6l9DmyiFu/Mfmd5zHLwk6pv8m61AN+E5QxotHNUg1pTBbKzo?=
 =?us-ascii?Q?gsCOduwReJV9SlDuZ1WJmtDlF1ETRnxM1qqxnzWma93TPIRI7uv2/togXnJA?=
 =?us-ascii?Q?NTGP+PMRkqVosCqFAvkvlBzuPi0i5gXIpFQDSFRco1xLsc0P3azcEO7nuAtX?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QqN/YT/afFYCbg+FB56C3/CxEI7o6Wz4nzh28iDHtz+6Rzry6Wa/0rVaIlWR?=
 =?us-ascii?Q?ABl5knaKBWyALhM0mXKDvAWx4Pkiy1M0ZwNg3OmKsgEUdpiIyrweT+bjTb44?=
 =?us-ascii?Q?T9JJqt4OjKAmr05wAF3c+9NKKw5upV/dnRaHx7E1rAvTtVvaTHom4KMQHxLt?=
 =?us-ascii?Q?x4E+oKZHM3t/sSmtlnR24khEv0jy1vzqc2IiHOUHiHCrze0OP42QTjH2nmGq?=
 =?us-ascii?Q?Gem5FdPTcO7RZAij6BGDE5hpl4+A7mAONri8pIz+jQBRZLgIDFOf5uZFj3nW?=
 =?us-ascii?Q?8+xjotWNMTXfFEowTh9xogLdVrK2eqRLzM4jtoptq6zrjZZO+Tct9SSxuMOS?=
 =?us-ascii?Q?3hb2DkKPDqM3eoQw3Wp8fPZiZtrR3WPIxmbZ2ihro6Dr5TqHZFvVHXVoMRCT?=
 =?us-ascii?Q?4wsVKXKiHi8FnNmSxYD+irbzqyWnrogr14dyolpUKzNh0eXmflulq3TZ0U2M?=
 =?us-ascii?Q?V3ax5GoAMDjfaqL+pOIvrYnGF4Nc1+7+lip6fkBszLZVF6pMPtUXEFrshNYx?=
 =?us-ascii?Q?p94IUinhF9adm7KEsjHabip30mUqFBaHWbt15hvWyiyC4UdLHkB/+wIMUyGB?=
 =?us-ascii?Q?a2nhfOM7JvQLxaylD9ewrxmhuwFCXd4S0/zoEX9sQELvSz8M3hOyVj+LB6vF?=
 =?us-ascii?Q?E3DIUTQGc0zX/S5XVAkOykgExyvqMmGKtGpmesom0JaLEUXqEqJMok1E2N3p?=
 =?us-ascii?Q?onFgILWfCp2Zkvzpq5FtjIlOrtC4SNFbAi7jJ2HlBscm99dPMjmYw2jDL14e?=
 =?us-ascii?Q?8bsJKqj0OtGVX/5Bw3aMP0OgXO5rjfoAkeioFOUHB1fES6u6Bcwfh/8DOK7s?=
 =?us-ascii?Q?pm1cTkcPW/U8mbYAFVRLNWChOwzo0VFcdLMxGR4mQs0NpeHrtxT/Hl8VaEP3?=
 =?us-ascii?Q?amecm9O+wyzmC/uBRYTkRhRKA06gQwNQzXkFeIzkJKgPEH0LQzPebtL11pbm?=
 =?us-ascii?Q?V554lrRXkfMbasr/SNbjBDfvc5iMkp/Bq29Vjr8QbmnOf0jrKViTwR0DDwvV?=
 =?us-ascii?Q?f8llpH4/6XUXLeWl4YiqQSy45fLm2af5xiAm5S586RL2CkKwKuzznWYYgqAd?=
 =?us-ascii?Q?mkSTLhTuPc7b83DiX0uzYZ+6/15xiUTGdIo0qGDK4BDPMiSChrGwegCtTeuB?=
 =?us-ascii?Q?JcOXLtVbx1hdZhybjTFkByKE4u0u8pTGKL+BvX2me00m4JkBC8g0Rtx6jop8?=
 =?us-ascii?Q?EgItxwIUjdGKCpZZOYlksjDZNtr68UvjV/BL0H/xO4yt6DsKo7QtMZwVFGxh?=
 =?us-ascii?Q?QweHlytkrnlSKS00Wp+apnbMTxhqcjRmrxcM2dtBe8FoFWo4IMzNPhAO/B5D?=
 =?us-ascii?Q?zY+ohNRHO7Q5mzB6b9viCYPKnSglDr+3W73oajLiIIt3HA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b885ac-0fdd-466c-0b3f-08dac81c1638
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:46:58.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shp8Bh7bySZQc1M8plGPnUADZbl6MRTHjgjSz+SgsPSd8dmO5lH/FhjHp46pzd//wFitGlymzCuDjzmbj7k/GxOJ7wwddSUO0ewwbJGhrBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-GUID: RAA66WreBW7AneB-7fbPsZNVP48XsRbH
X-Proofpoint-ORIG-GUID: RAA66WreBW7AneB-7fbPsZNVP48XsRbH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event(). During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  36 ++++++++++
 kernel/crash_core.c        | 139 +++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a270f8660538 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ebf46c3b8f8b..b4dbc21f9081 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -374,6 +375,13 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -503,6 +511,34 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_map_crash_pages
+/*
+ * NOTE: The addresses and sizes passed to this routine have
+ * already been fully aligned on page boundaries. There is no
+ * need for massaging the address or size.
+ */
+static inline void *arch_map_crash_pages(unsigned long paddr,
+					unsigned long size)
+{
+	if (size > 0)
+		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
+	else
+		return NULL;
+}
+#endif
+
+#ifndef arch_unmap_crash_pages
+static inline void arch_unmap_crash_pages(void *ptr)
+{
+	if (ptr)
+		kunmap_local(ptr);
+}
+#endif
+
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8c648fd5897a..4e7221226976 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -612,3 +615,139 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (kexec_trylock()) {
+
+		/* Check kdump is loaded */
+		if (kexec_crash_image) {
+			struct kimage *image = kexec_crash_image;
+
+			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+			else
+				pr_debug("hp_action %u\n", hp_action);
+
+			/*
+			 * When the struct kimage is allocated, it is wiped to zero, so
+			 * the elfcorehdr_index_valid defaults to false. Find the
+			 * segment containing the elfcorehdr, if not already found.
+			 * This works for both the kexec_load and kexec_file_load paths.
+			 */
+			if (!image->elfcorehdr_index_valid) {
+				unsigned long mem, memsz;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					memsz = image->segment[n].memsz;
+					ptr = arch_map_crash_pages(mem, memsz);
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+							image->elfcorehdr_index_valid = true;
+						}
+					}
+					arch_unmap_crash_pages((void *)ptr);
+				}
+			}
+
+			if (!image->elfcorehdr_index_valid) {
+				pr_err("unable to locate elfcorehdr segment");
+				goto out;
+			}
+
+			/* Needed in order for the segments to be updated */
+			arch_kexec_unprotect_crashkres();
+
+			/* Flag to differentiate between normal load and hotplug */
+			image->hotplug_event = true;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image);
+
+			/* No longer handling a hotplug event */
+			image->hotplug_event = false;
+
+			/* Change back to read-only */
+			arch_kexec_protect_crashkres();
+		}
+
+out:
+		/* Release lock now that update complete */
+		kexec_unlock();
+	}
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.31.1

