Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1206D6B2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjDDSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjDDSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11645243
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DxAVd002595;
        Tue, 4 Apr 2023 18:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=Eh61JE3lXJvam2YiNNwYlch8hkxGRKsVXi9sBPtI/mij5GHOSCXnyxf00RimGRpAxI21
 9R72A0x/UY9onHLoG/+Ow9PEkFxbt1XCBsPcAVKN946cvWoCe6j6TsyTMtBlq4u/4CgY
 3JMGVA/UuL0Tq8ofDTZc8H3fj80h7315tzGR9VIFsDbw1IQWMLxlhivxC8hKbrnM/Ojb
 /qQacpeUXv/Kg1voi3boix1Ti8vx3lcbxqKuWA+06/M/qeIGiJuBu7EWoVqaXD8XGqKd
 XR/xIlZR0+0Ag6JzHhHYXNqD5psUxqa46Ho9+hlTwZs9uuHzcgzeAciBqUw/NsgVDSVO Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dpgms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GVLEt037764;
        Tue, 4 Apr 2023 18:03:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjsgnmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBGoM5yVyLdGEXK2fVjvz9IqlJ4n1qaEdUOvuX2t4tNUmHIsp4dyXKnaBpfmcscMVUYXrtnpidmMWlmGkp4Eww036m+sd1CVo3I6GCEDu435sOuV2o01NAXL2qSLBMh0YfouDPcJPF68x9ndgbHG8F/M7qt2vGbd6vBpYXjVz4h2jo63jCBk+1oQLsMB/+Sugu2CV6Yk3VgnzYHkoHAdwmCsQNpN6GuedItFlt1nxKwyuIGTIcI1MCeEhKFgbVywImybJU0/2WO/1Hb7Xt4mkIYCjDPduwqM860L9afT/Bwym7Sv+PAVG+6055OIKbHgAsOjhtlqVSOUQLXkl9iTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=Y3TicJG+eMfSIVnGUhnb8RfVTTnaBytRzuV+afUbNmG1kB/iLObLusx7H+TA1HFbqUv1mLAMjCa5+itq/8bHVStOsgPrlJK1sKyMpcQeYAIS6K5KQyKTT+QsSLmcasQRvOCA9uEMO0AZFiys8hDB9Cgl2ZgA4v2aEDva4pgc3uJakPR963D2LyctiWHbhtM2PsEoA+OZ+jPQG5KlCDVwr3MwCMJfg98fsUDnCw9X7SzgXgpCxa5btHJQSWxKmmd6r4F4Pme+m7NsB4OtYTyLnP5ZDB5xLumvK2Zo4ySeyZodK5c6V/0BERaKQI2eAkKkd0BNSfMziCDWE4yCJlmWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=dtvESRKjd3G9P6lPg1/SX94c9ZZIANOyz5R3e9GNZjqUGVIbOYX17uecfzOQxte06y1dzOIVmE/slXkQ2e2qlZyT3Rc7EPp9Dyn+vn3lHt9gNhneGqV+6Iaqvh3CoIxZsHuR78GeNtizCnTjDg1EH5t2LLsskbu3pR/cg9J2raQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:03:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:03:55 +0000
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
Subject: [PATCH v21 3/7] kexec: exclude elfcorehdr from the segment digest
Date:   Tue,  4 Apr 2023 14:03:22 -0400
Message-Id: <20230404180326.6890-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: cedbf88f-1730-4bbd-74be-08db3536f482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29YnU6Q+eWDCKeZTjDdRyfgZ3+6GRHeRa7XRIApjC2s9UCTMUL9YnEmGe0bqhtg/97JImHVgSXooCFVYrsGm8pKFKOoPo6Hhi8bYivG3QVQyi4BrX+MULMaYGQTd3iMxLQRaAycLGXgFsi6vU3DWPEU0QSAnI8gNeiixRApacWLX/H/TfJGsRIymlDL/gGkVHetujN/84I8xeHG41nT8NmAnylnXY+GC7q7EcYyqUD1lI8GqXo1fVrvPO35z2vXsiRzdbVKxj4kcvPekPWXTApG1iAefaOR0NkZBx+Dh8IwZECab3xc4SKdNqeem1KTfh9tsxsArPKxFDPKgPbUGg/JR5sd2gbiTPvOPFUohLpXlDFEhke+kqxpBqLuhRaX0ZAcmkgQNgOkreH5HAgli4Y47geT6v+628Dy2P3QoLEvOoIVwQLOKPUsw1e9Q3Ecvf5aBUH6Do1oHJNesfV9wJuyYKEiiQhZkoBGvqi6FuGTzda9dVM+pgPSMNP0XIGCM55umoz+tpwkBM8nS4M2sazgJ5NCdDNuz1/Z+ACi9qlSQajqip4qv8xVGOkKDhXmE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ifhn6AZrNc43qE02fM92plEOvymZQJ4IIxW5gvQ9Hz/1O6vH+V4CnL8VVbru?=
 =?us-ascii?Q?4+DNus3TqbwHK2PV0FtnnnAubiW0eqsJUPpgW0Z4xyjL+tjP2RSCNCW63cqB?=
 =?us-ascii?Q?3AIFsdXctcWdk6vEikMuRYCInpiIAASQVNPfQklmeY+0/GeKvAlE3g9+xACb?=
 =?us-ascii?Q?vNrKp6CXxkgcPC8N8cfEB96oO12H8g5fQGPSREaOdY2WjkLQvLGzmD9NnPo5?=
 =?us-ascii?Q?g0v2hCwtr1vBCg/Mqv0LuXuf7sTiXPBZpSbZJWpuNTT4ddqUdwB3PBxidGsX?=
 =?us-ascii?Q?pB0cl7tEkT0+fflDM2KC49UImY+WcMEO+akxzr5R+9d2TJoWXjmITFlhklFI?=
 =?us-ascii?Q?8bE9A8bWt4KpUe3CMIVVGFZghq5uMGcSCeYCzch5Dv3RvcC5rIjcQiaeSbyr?=
 =?us-ascii?Q?l1mvNuYgTCljcvnyZZfTPR0JEo4DqeICd8gXtNy9ePCC5j5E70F7LMzbRjDq?=
 =?us-ascii?Q?+6ZiBChkqm8K4JQzBJ80F0gjmgn6NhntKuAIome1mGkRJ4kv1VvsyKip9rpE?=
 =?us-ascii?Q?71Vag6zpORuUbCcp7e6Zrb+rUzDMAnMslgfHD9jcXBMknM+V4JKgLXV/DkJN?=
 =?us-ascii?Q?Mt7CCksLpQXNn5RfMR/nq7zHlurQoWZjkPAydU7IELR9xQR81pQA70IWqUiJ?=
 =?us-ascii?Q?3yTOP0XnqTToeOUq1Zquc+W8j0OHX9JBCPYG4mcI3SZA8V4mZ0meALWtSd2r?=
 =?us-ascii?Q?wFLYuqQt0MxZQ6Nne1zO9y/0xFi+fEDPwPRUxoWHHLwT2FB+kgNOd5sx8Rrl?=
 =?us-ascii?Q?pALIr5Izk8jBWF43C/jiOHsb04A2FAetuv/RyUWcJ/lx4RAf6/A1DIEQrT6x?=
 =?us-ascii?Q?YbK6STx1tGWKxICAQeKsErXWRF2J8YNpT+MTVplIhlcE1/+CJuuSkO9bvxva?=
 =?us-ascii?Q?Zy496Yl8Z6gm7bb44IrT/YPChwRKsqnj8bo2vU3q3wm7rnUjFLE/EFa8fHNG?=
 =?us-ascii?Q?b7ev4mZBkO/cOptjVV7Aefd8R3Qt/zARgfTFsPcoUiBfEhB6FOxjb0aoP1zr?=
 =?us-ascii?Q?TFt56zku6tc/mJgcZroWAqywyU7lQFQ7F0YlSRHb8YncWU1pAADaweNZsXBR?=
 =?us-ascii?Q?bjmQZ2JdefUHCsd4gBu7RJCOs0M/4LsAuGFhHpsewlOGeD7FVJa7b18+7GeA?=
 =?us-ascii?Q?uOwhu9t7wwshVTcVPuhtwHhuICTs1eRljkOey9BnxMKryU8FxrfHNov7DPVN?=
 =?us-ascii?Q?ALlhO9Hi72eR+e/sF7bsqR1hUEse+xSOlY9eUD2+0MWeteNamnp4bBkEigH2?=
 =?us-ascii?Q?pb1ntBLoQ3I3Q+MWhmiCzBREX4GoemB2tqwxtbrZHHzOAHqzFGHOLA7Mm0tq?=
 =?us-ascii?Q?oc0ssFMqGLjN1kJzfaMsGIy9iHOJIV7I78oX10dQBzRPt2/HxEjaxKoWp+n6?=
 =?us-ascii?Q?qI3sYDYb36mSzFBgjAw/B5mmZAP0st1ucXcwQjeefB8aYPBz3tAnlc2u6sI/?=
 =?us-ascii?Q?IjZUS1tWgNISHhjbrN5UtH76xKXfl2dcCI9mDWNRX1JZUKQ/7G+zv8WzI61p?=
 =?us-ascii?Q?qyrfWi30fmNjk0fJCGx6KSH4LssRsgHN763J+0knUw64LcrBBa90njcwrlHy?=
 =?us-ascii?Q?ww5irDwyqC2UqWfFVHT+XspFCiDy0nI7GYGnsrZzxjcW/HfMdpA7Pfh4hZAP?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nOXe4M3Al2y7FR789SzqOkWIqbRUbJiyctgYiQFqrvGwp6KBEBUu1VO2STit?=
 =?us-ascii?Q?2+lSyvUvKzQAWvNncjt0fY/rbMjq+46nbgUvN8SLXbtM+99dFFoagGICgRkS?=
 =?us-ascii?Q?opbvbE1M2UcbUyg3GFJcmFKrBH20EoLIQRQYBckhcfD0B741jRcg1NMv+VGS?=
 =?us-ascii?Q?vqAbzmT8F91MM6JjdEMHOowA+jKDMPcB1wserCm8+bMlfDQ3symFvb+OESgy?=
 =?us-ascii?Q?oixEJuNweOoJpE1MH7w99g+p5U/0607TQR1MPuQWuenVFrGYDtUP1VQwDN5W?=
 =?us-ascii?Q?px0VgEOoEwviRXbb/8Qh8AaemajwEXq54dDJWXxd0qfo47oz9+3nsx5yL+lf?=
 =?us-ascii?Q?vhLNt8IO8FSZkhMAFW2PLXJCUwXykWRnWb5hqWx3ERaZxhuSwsq6YHdyEJJd?=
 =?us-ascii?Q?8TCnMDZyw6mjvS4HlTQdV8GxLtfakBpLGAYQ3DThDCXFUfLqjajHVqt7Oi9g?=
 =?us-ascii?Q?/vVLI7cwCxvgFK+SHKr2ZpNmhQ7PIxjjk3F2uL5owvQ7QTFAxqPp0gh0UpqB?=
 =?us-ascii?Q?R7c45dP1Y2lLJSt6jhvbElhScQj4o0ZwqgCHrHu3bbbuDEKU2zyknVf/Ux0e?=
 =?us-ascii?Q?6yLSyKHkdHdpjDYymSyDdFTSmE7Co7rR/6CLnbd04fDpCmNGHywJ7Rf/aTr0?=
 =?us-ascii?Q?haLkOZbTAj+7e8plkWgOWsj7qyB4X3xziRpNqGgXm5c5VGyB9Xo3MsaRlQFf?=
 =?us-ascii?Q?7L8F7g6qdALkEAOVh6lUaqjuvDVmNW94S5f3EglleNArxWAKXv/BUfr/6iby?=
 =?us-ascii?Q?5r3OU2gw+KZTVDbFrWMW7fw+vykN/x++c4sNX5e3dRh50rsV8Lym1uWqz5NC?=
 =?us-ascii?Q?KhtvJFguw5ze4tRkdwPMbfRPGEzL7E5x9g+qmVqzyFBVNIY24qnwvxGv5M+5?=
 =?us-ascii?Q?5GEx97PYkVW8jXBsL0ajFuf6HC85Jo6gHAvq08XdUn/DtWQWphDlrBzPe4Hf?=
 =?us-ascii?Q?GOdeqW+lo6GC9KpuXMxdw68dutQuX6PpyT1SYCuKP+0BiQYEvr3/rs1wgK/I?=
 =?us-ascii?Q?fkRFfo/YtLNliT7BdJbJ0QM7Hv+CV612Ov/BoZmxHuvLS+/Y+rNZG2QoRXzf?=
 =?us-ascii?Q?L7BSm57roBFLcccILM6C+v4uOBTTJZJw5pKXddudZTOhfmTubBNeltnsny9o?=
 =?us-ascii?Q?lPueq1CHMuzRLGjsdUyF5lIV9T65x51h7ix8Re2Xd0WzIlp/Bk8JQ9g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedbf88f-1730-4bbd-74be-08db3536f482
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:03:55.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77WfkS3rbTfObXsFO47hphh/OhRCP0fIMIJEjbZJCNef2rlFsaGFyBDXxhy1+QH3UYKUfUQy7EZ0T9APO/2pUnwFq4T31wbb/iKDea9PcpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-GUID: pmsHazm3FQ0abuPg5_Q2vOw1tESsERgb
X-Proofpoint-ORIG-GUID: pmsHazm3FQ0abuPg5_Q2vOw1tESsERgb
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

This patchset updates the elfcorehdr on CPU or memory changes.
However, changes to the elfcorehdr in turn cause purgatory
integrity checking to fail (at crash time, and no vmcore created).
Therefore, this patch explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits updates to the elfcorehdr in response to CPU or memory
changes, and avoids the need to also recompute the hash digest and
reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0b560064579e..a28f01318a47 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

