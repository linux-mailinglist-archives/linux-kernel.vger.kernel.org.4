Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6E62CCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKPVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKPVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:48:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2175654B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLX0gv016352;
        Wed, 16 Nov 2022 21:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sa+WccxhodFz7MWxPohazvPJBvn1/J4kEad4/zAvTms=;
 b=acizyEDr78IgYtqzqqf5LAyPaYnupx5OaPjlfjvDEJ9eiEhMyoMYgkH8+pPB/jq+/+y/
 KI2sOVqZjz54lME13yB9ZofJdjNj3D0keQgA4Lgp9JTfc7A44+voJEYjtUyqvRQZfClf
 blSLq962CWMBlyqdRIYebjOskK2J6qEi7tKlf5IBHxqZ6csmPecRBfRbbxlkUV2DjzhX
 gUqvmy+epgCGdE3H/7bBl8JaCFKVfLz0Ynt7jp1yQWo5Z5TrursSZYjW4w81KWIdu72t
 x110llh7gm6LAJIOH+Q5AmWvgas4MoOwhJK0tbnwURi94tNmGan4pWJqk7zwMxojJtBq 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykp6m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGKoAKQ034766;
        Wed, 16 Nov 2022 21:47:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2dcjunw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIOi9O2i2/HPMAknATJdkbo3iuIph101FTnHGyoYTzB03Uf5IPWmqVlWGpz4GP9yiDxyofSpoHauB8x66bebKBdlpdaagODDULKCDPKtM94xN9tJHuv+FvIpGoqdsgXfmp5hy7BnUR87GkzcJpJc0mOqtf3hDNimdIjLI8HwJMMNQlHWXOV2IYD1mKUjnTgt2sCjbI4YofoxSl18U1eYG3Nn2r2EofmbD1bVmqdQ0o5iqjOzVdhQrfCf2pzBjlhqLhyNYBVEG5MWOM26eSNcKBaW8xyEE6yeI5lthEwXdSHFoZnZg8gkpWJCs0oUrJdbJKeZ8vRaYP8X8KKYf1kc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa+WccxhodFz7MWxPohazvPJBvn1/J4kEad4/zAvTms=;
 b=aevBOvZX33UvQq4951QsYa0ucf3GltT8T6ZDulSuHxbvbihlO6wWXaQ2LJfrSkl6aGyXSIzb/buze1hvszWIvofpLW/4UAFMlhVkj/tKH2ntxZ/sHCqUP5UYsnwnz3JO8HgS4LixqkmNce+rC+5tFWbXSuqckrma9eSp3cVU8JhEb8Tc50bMpVVGP3pvQVJoqyvUfNdckXke/LGn8LSffYECN1UZTxrrhrhDqDgQI/EE6OQrMkycOW9XAc+X7aOQNkmq6wHqSDi/2VBXGzs5cHdEYZBG5kFKVD7aGgOYzX57+QzEPpDOWs29K1rqmrxBPavWwwCGVS7o0KNwwkzxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa+WccxhodFz7MWxPohazvPJBvn1/J4kEad4/zAvTms=;
 b=TSbRnpEswktLKGCbGH2uDzJC6aqqrs/tIlEJbJIhB0li1n28CDcU8Onjs8IFt7FflZt/MoVh43pVMYhbAp13Fj0gh5Avrxc9qUKcnhFw56UXwBb7/43OobcFmQcEslEg8UXfvbi1o6+zv2fG88ACprVnzfBqhhgS55LcPvZ5iUA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:47:34 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:47:34 +0000
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
Subject: [PATCH v14 7/7] x86/crash: add x86 crash hotplug support
Date:   Wed, 16 Nov 2022 16:46:43 -0500
Message-Id: <20221116214643.6384-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 446dbee3-a5c0-47c0-5a36-08dac81c2bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3sa6w7uGy5u3gIUy7idiuaomor27W+eBtM1UjeoieJzA49fvHadOAbWf5LsjI6JAslZnVeOZAqu4fX5FPvcrGruV+9lymCZkGookBKQLG7fgMTaJYnYoiJgX+NVzh9ta8PljNdVfHL9oRuhdqjUwwE1R3oJy/VZTOYEs+6fUzOwx/zEP6BW4SEWzWpaJxtz4R98UfyCNFJtzxw0MF0QQCAfVBcOL3Zg8auLPO7qoVDklTkKKQQzXN+Xm8A/5E6ruSJxPpQ2Ha0QX2OhrmMwfJiw1CzBYqhsxtTU7YLVUIb2iRsVlxKoB1/tcLz1sEURXbXSiaefaoMdpkt1iRTHN5srvP314v6CPHnHGjq4ud8kSXoRvdofhiDxBccjuMRZqWDNZ4IerzMVsTlwAaUd+H6W14mOhyyKOLDlwJ9DCLpxk5lXfpN9ZjAonudrmgwKiO61gb0zz5fih0sbWkQ9P3dyn29n/8qymebEJKp1671o5iUOiHlodsVfTC5rtWvKF1h1t9lDdJBlkTwfNo/YWvcv9cp0H6ADAD0A+JhNvJOemPdVbHce/J+wL1rdvpdQjNbVv1pNQMSTgyj+jQ1LKacwjqWmuKV+/y670Dhczrp3q2/S5kTI/PF9+T2C7nzvfcy4K6ZKTTZuKz/qOsibOXs2RoabbT0Mfg/cCzlv/rvLbLjm9d798sqBNmYEs+7nRDzCNC9ExKfwTXMy70qe3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(38100700002)(186003)(86362001)(6666004)(5660300002)(6486002)(478600001)(2616005)(8936002)(7416002)(107886003)(6506007)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(1076003)(83380400001)(6512007)(2906002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtUytPhBduQQ23K0RnLnOjZZ7B0Qxv3aXtztPBOKhoTKWIY9F+lsZ4c4dtFq?=
 =?us-ascii?Q?vJBSu6I1Qd5an29bciZxbvBI5QI/RsT0uWzmhDf1Int6i4skUgXv+VHU7ebY?=
 =?us-ascii?Q?A6ZvsbeF/VHyE0psZyEcpZqaDL+PvMyx1SJGVKPALUl5Ryjs/7mJArlxDl3k?=
 =?us-ascii?Q?LdmtvqeS/z0t3CW2xIIHBAbriBY3DxRCYiB/+K+e9jf9Fx7DV8F/zrDO4m9i?=
 =?us-ascii?Q?MqFRx9NDUa153qIWEc5rsF++78dRB89rngZa1b/hvTzHWYeYM8ipnVIDCtak?=
 =?us-ascii?Q?lq7XdAzKNOHaLeFKOESs1I2gLvdWU8639WYqQNKkMCFa+04xU5tt0a7ob4N2?=
 =?us-ascii?Q?hcCCMSr8y+kov6SbUQQhG5QJWQv7kx71WgO4TTPKB93wceV/pT0wkKWNaRoQ?=
 =?us-ascii?Q?EBdfuYZ3NbI6ek8GWxrKfpjCbKbToRCysCwiFp9bRXNdDHp1q8Q+726d9BBP?=
 =?us-ascii?Q?PKEv3h82ZZCjncGn0tqD4X+1ywF3dSnUaY9cZn0i2QXmWIRJkqaVRzs0OfvF?=
 =?us-ascii?Q?O2n1Mexk8JcCxrvRCXpJcgWzArmtXqQTJZrTZEWEcBTRNxZjxefNNkFbTyOm?=
 =?us-ascii?Q?+eoXV0EPjzAJwgufufhJUZI8fn7qEdUHOP4tV+lp3Igy+HQoZti1bDBcG807?=
 =?us-ascii?Q?kZdlZS92srlzC6duo05HxVxrE2XLsyxk54bUUXor1TsKsf3U3YPPqTQEDXpt?=
 =?us-ascii?Q?/riHm5Ykm1lK+7Z0lCf8BcNTu408HA4+ASOn3E+45UWOJXBmN339R67Y4tcy?=
 =?us-ascii?Q?3K+3ucp6tFHOgGSsLV79QRp2WUyc7iuNOtx/BHEjlw7IZgzNRe0m9qFAN1f4?=
 =?us-ascii?Q?im/6deZLa6GAf8PrugMiiZKt5wlI7ChvJ2MMOV+blCUaor/FwJJqyxbW+6Jd?=
 =?us-ascii?Q?0Sd5l73OFmGfaKiU4Xd3jzT1iXvkAbQsYSSjMSjjAV/FCB4lCmXHM07W712J?=
 =?us-ascii?Q?txB0MvyHiQHQgr+ILBnnDMtWrhHFDoPnZxQLvta9YHGhRHjSx2eh92kG3NrU?=
 =?us-ascii?Q?qSXUmG43dKb64LFervwvYHUVAN/THuzlJ6myURuZ0sDSuV39RKWh/2YFblVD?=
 =?us-ascii?Q?gLcx0XX85iuumaQ2WZFWZD6kx/PUsY7TS36q2wF6ojvbFRdCJFUIfj8lZR/p?=
 =?us-ascii?Q?EM53l81IuzjZTN53ddrVKd0ZXXyWtLK59sJPFPKjNUaOOOgs8sSQkaGpFfqk?=
 =?us-ascii?Q?n+r9E5g823C6zUhPhG84isrFROlAGEeT1Z9eDiR3IdWWZZXpZbPgYBUpN9zt?=
 =?us-ascii?Q?5yEljgZU/QoqIPoiB/BT/dknrcQypQqMFSDCZghamhgs/RvQt3sYG6x9FI2Y?=
 =?us-ascii?Q?PMV3TViLdSKVQnshBi5ZMgI771hrJroIFCsNgz3PHSMjfOU2axKy3DeuyAfy?=
 =?us-ascii?Q?TichaNmCTJMJ4QNxlykigE/RMIkd20qy8D7DUlgwHI7Y6fX2R7SQzUlDNqSu?=
 =?us-ascii?Q?8PIpfXLbSqBbVpGOqKd8a2vK5VF4SUoX4ltmDq8OQhOmU59IjbSQu3zk9eIa?=
 =?us-ascii?Q?7mEIxReKJSGZTveWiGKByClf9wXIHn07QH7SWpTxhUmE/i5aLJ4ERV8D4Dat?=
 =?us-ascii?Q?Ssxk1RmoftzeKlfyrmd5yZobFG+UkmjApf9siHxKZfkcqmH6x9ALUR1/xsMU?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5RFQukxWkh+uGQOWClV34M7hjcW8emgZJUfotnSFMi+KlVRae5DDxDnpiRK0?=
 =?us-ascii?Q?BDQOWC2fywF32QTfhGJ0UDzMse1gLeY/tX2gk0FLl3EmyqErq1eq2nmLHhlf?=
 =?us-ascii?Q?VDhoCBnSJsZuObb3lH6vvW7M56qhMvqAVDD4eTMSWeFpaenyNRiQWo9236/p?=
 =?us-ascii?Q?qSruWfovOomk2Wrab+yKn5czdy2r6G0LvFeApHaVqmsRp9igpBSM5MAtLlrd?=
 =?us-ascii?Q?jIpSX+e/WdHruuxJm3dI4Y2kOxMSPzBT/RiMsPfXqWdcCk98VXthrwLaxMIu?=
 =?us-ascii?Q?Q0JyQT6tF1JxwetD+8ym+yG4zbn/K787Tk0zWr/+g3qOPA4H7NqIXAmNSEDj?=
 =?us-ascii?Q?NLi51eIIp29pXwc9RuB9k0JK4ieVBM9wrsIhesQv/a+y50qettOxacvC8VGF?=
 =?us-ascii?Q?+Eg46tmGjxA/nUv9mi0dZL54j7gmGZWVBzG1WKI0xVfvGrMKIuQYAaRj9you?=
 =?us-ascii?Q?pzVd0Y6K+WxvmqI6GjUh4R3DUiJNKFcWdaJrsTTQ2Cy2u2hVgajNYKA5PNSW?=
 =?us-ascii?Q?IgryH3U3NrtZpaoZt24hXFI3GdHrR3dAUGRQzpUHq/5RtwNqJK1sqxfj52PR?=
 =?us-ascii?Q?O6zBHutzjOGkl3XfjsWunLYN+BmAUkhGg4nMp0EfJxMSM+oIyxEcCw3SAZyn?=
 =?us-ascii?Q?X7SKLIINlh0kn5GGkj50OqfkXDEs/lCv2HmKipcP4YNuslHkOLd6OLtJnRSD?=
 =?us-ascii?Q?NMBxzSnOswDaNs2bIbLamxCdCab2HMR59hXh9L0a/l7Ve3oVQVhsZXJv7voB?=
 =?us-ascii?Q?ehm6BOlMKPb2OeM37Ys0+M2Lr5FmC3rA/hP3BSzeT7xpFCWYDCHABOB1lHCL?=
 =?us-ascii?Q?6IcAJCeyHxO3jJnhUb+YsleTeU781ND9Dk5+GinXTv2sNEGupnqfJexsYXcK?=
 =?us-ascii?Q?y946aMeoF69MqnDzbqpKLTUdfT6AOidAMTaozj5Ue1ROlBa4Ydhy+EXLlf+/?=
 =?us-ascii?Q?OqXX6cZFdUrMpfVEcPj8xgkKO032ONJbF21pO0W4EjBib4WxndMSnnoNICgV?=
 =?us-ascii?Q?/4rszT+VoDmG/1jPKruwaIvYuzNsZMBx7SEk+jkoHQjO7qv7uditxhOuvknI?=
 =?us-ascii?Q?pKL+M9HrFQEb4aCkgSzX6BaFDHF0ccwV+/WIvPf/qd4mXDU4E3mg3xSzhm5n?=
 =?us-ascii?Q?OJ1F8MokTibVOb9ajVEthf2fa971u3r86rMZiG4T1DKtSfOnbRAi5ShidiPN?=
 =?us-ascii?Q?muiMH2NWxjXbftorQNbo8ZmbWrKgzMuGqSJTV4FL7GfIVKu2Ar95jBS+CwLa?=
 =?us-ascii?Q?lKm2ry0CR3W3EeacxKOlP+6yKrlikdT2vNUsFlpFx4hyPMfYinnRQ+qLNefQ?=
 =?us-ascii?Q?S3MRyzWzhCqyeUCwiotZzHOkS7y5QPLgdXr2tKtDFLM8fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446dbee3-a5c0-47c0-5a36-08dac81c2bce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:47:34.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW97f5tL8t/qBknw6ZhyQvrIbd0vTO+G+yPabnFYyKqnG/evMKp6S2wSF25vD9evnnZ7f+0O79xQumoRlNBtXW+Im4bKNwizpO30Xfgvd3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160148
X-Proofpoint-GUID: W6TJk9z2GTHrm5hceuWARiOfRAceVXPo
X-Proofpoint-ORIG-GUID: W6TJk9z2GTHrm5hceuWARiOfRAceVXPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, the crash elfcorehdr, which
describes the CPUs and memory in the system, must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
into a buffer, and then installed over the top of the existing
elfcorehdr. The segment containing the elfcorehdr is identified
at run time in crash_core:handle_hotplug_event(), which works for
both the kexec_load() and kexec_file_load() syscalls.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |   9 +++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 106 ++++++++++++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..fc7b6457a0b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2072,6 +2072,15 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable the kernel to directly update the crash elfcorehdr (which
+	  contains the list of CPUs and memory regions to be dumped upon
+	  a crash) in response to hot plug/unplug of CPUs or memory.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..d2238bcf8106 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -42,6 +42,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -394,10 +409,30 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	unsigned long pnum = 2; /* VMCOREINFO and kernel_map */
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		pnum += CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum += CRASH_MAX_MEMORY_RANGES;
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+		image->elfcorehdr_index = image->nr_segments;
+		image->elfcorehdr_index_valid = true;
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +447,68 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	void *ptr;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache(ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+		arch_unmap_crash_pages(ptr);
+		pr_debug("updated elfcorehdr\n");
+	} else {
+		pr_err("updating elfcorehdr failed\n");
+	}
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1

