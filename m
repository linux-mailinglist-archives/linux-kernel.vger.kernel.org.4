Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C162CCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKPVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiKPVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4815A1E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGJJhj3021463;
        Wed, 16 Nov 2022 21:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=Yvdz0I47/YGbqMABBU7L2ICF6fcix7LjzadxRJCCrf7rAl/MrZbuQ3pHegJHnr6JZdNy
 EPGQOlk3A6vzWE9a6wE4GiZ14XHsMz2WlNyMSy69ONvufVjqJh8kelkxgInGnjoxEjAI
 IJr3Ko9Q9G+jAW+CA/Ta5fXEYvPpzTbmYpVcOpo3rD66yGpFtIT6pO35Nk+0XClgCbAR
 o3mHmQEjrZAf5ee4SlMUtPnTe/I1ttZiRjxUksJW69wdLBym63wZRSP1B1o/xq5p6viZ
 3t1ztHib6NjOQrirqeHE9Uvl7XYlS+B6RjxPq5f/MW09lJkiyGoT0GvsGQXxWqwODmEn XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdx9r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGLdJrx009418;
        Wed, 16 Nov 2022 21:47:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x847ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH8wo6tcmCMPqMLxgzp/xoS+WuzhBHFi8PKQgXjqdtx+4bMm3EPhRLWqjNXsAA17MSlQHJgCJc2yOo7Iacf4AspMYwTAJkQ7ztztgfcXKTVSwMZtpo8h63TPqXFsY0hfahD0m/R4NHLIXUaU7iSyNi278RFg+pzSHJI9gdTxezP3GsTFghAxQfnFBaSoe0mpg7zqQhU9dUojxO3wmFZ/0ywpyddrB1S2B80wFKj0IqCSHK7ynfCBpBW3YYjBOtiw4z79kR05vSwOhH0GETVO4/3HTJm5wh95E77RVgkPepJPArYSPQ7gOT2m/gges0OGDsDlukh8jytS1NecVZClJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=IUQo1pCahFeAWARt5TtL+4C3HeU/qIqJF3jSVdcNDVUKxW+TwmC8IfFmISV+UMmCIirtJ7KG4bnQz1sKKUZBULDYMLAd91rqdNMa8APO7I+l8WNiG5mgkxucNwvIhu5acqemwgg8QQtOkZ1W28VZltSa6uXDRYyGL8QNb3trZvn9cSsqnCSjPdsXP8htPJz7S1Z9T3y3KjQP8u6Uizx1aX5uHcsW6SkT8fx8tSheVGQ9QuIOq5lALxksIHeiG2NvQ8030/USl3G3GmB1Xb+dCxKcKv9N7svs3Fh+ZjkQDEfx4q/NDX9io6awYoJ8wzT3hv1LAvivVWrChYPqRJnpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=gZc/KgwW8mQKkhm8IggT1rihjZATvg2JDSgf+kd8V4cEEGKB0F2q7dCivNmRBvhyt7BIL7toS94HFyN+3Wwz5m2A0QiBhFGTDJz+lIftVkbu41TvKjUr3jwpyAwmao0UsCEwmN5GP/Wh5BDp2f3dmVbmYTLCLuVhSl/2DmKMbD8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:47:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:47:01 +0000
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
Subject: [PATCH v14 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Wed, 16 Nov 2022 16:46:40 -0500
Message-Id: <20221116214643.6384-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd1fd56-4aa8-48ff-1320-08dac81c17b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWc4A4w96gjp/UdGt1D+/JQQVi2NSO8X/kSjjexxYPy9GyB5GEqc/oGt4jJogPa0sG+1++sUbgloXAd7SMrrbEO36oYxO0I2hUd7U3k8RfZ0bc5F4wfXpUzbFteCckc74QwKXz6JBLm8i7lsEjSDBNl36oo0iQmUIrWLxXt2E7dzMFfLt7EMA4rv8ANPMq9Rmwygb9KNzQRWS3YhoFKFtGB6rjcdWNz5VXoIl5UTN201DCSMGnrNhfRlB/Ua/1jH7i713wWQYZROVA3U7aCymOCeFc6CRg1eKHlHdMsP9krEev81UxeA4gZhkdVvgg6JWcL572X4LqkLLDZ3R/k/b5bTR58oQPDdphRpgwG9dh4oVYKaFoGzzm+UgnpUEakYRtdqxair0In/xYlDrga7zoQ0Av5THBF2p/c0iB/eH+9mnBJS2M7ZbBU3W3D27+1nPcLUrh1lP1gh6q+PVxBpjSrL0YHBUU5B9IDln7ZoJBx3QvywOQceeJKLAP6mM1dyWedbCko4ckGI4RWdve+wna0IHjrX/xvA2iU8naJyCkRdOE1tb7KxXqvtnl+euSygFSOoQ3AhHP2WrR3FjFOl6niyHdf02g0yysVGawJdR1uMLME5zlx20Lj5vPwED39OL8I/TKrydMpkgruU6D9m1Vz1Fgyv63RhkNK3/eEf/q8YuJ/Wo0QyrTUVcVwcmYKBnnfxtIuvbPT66Abi2X+Z7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(38100700002)(186003)(86362001)(6666004)(5660300002)(6486002)(478600001)(2616005)(8936002)(7416002)(107886003)(6506007)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(1076003)(6512007)(2906002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1IYX3QUNAKazAxwgVFKoByicjJcGVtiCgzGISMzNNtEdUJOq1sZM+BvqNTj?=
 =?us-ascii?Q?pvhWixChiz1z5Q/YcG/EtHXXiAVB4Z+etSlqVUQ2oKd/BszKaED2dWzHt11N?=
 =?us-ascii?Q?e6LhjxZLIVPwsTN+20WaPd2kOYK2G7qb/LLfmghEXEWrFlHivQutHTy88ARu?=
 =?us-ascii?Q?la6Ru8ou4R3iE+6INeIxJ4vsR8UMkeHVz0P91YmOeMWi0ZlWXlsILDEYLXpw?=
 =?us-ascii?Q?VwfPOKWfis1eIj+cxRanuKCqcJMn4OKklTYFsm+LoTNbC+1XdVG8/VpK2eTg?=
 =?us-ascii?Q?LQAi9q0yqSIhAgj2BHR6royg2uPY4uq/OJs8Fn86O0kqUpv9E6LwgEcwWmFd?=
 =?us-ascii?Q?zgTn5B6/b6RfgaDUi5ky4cEuM2aryEfvXs5xdl1OioOLkX0FcnqIB2R/Hnxl?=
 =?us-ascii?Q?MAD3rcCb5yJSjRwEZI5vNrDi6S6GHq/qHwXQ9kZB8xrHUohb22Mmh4M4Y1YW?=
 =?us-ascii?Q?ofncjGWa0c8UOgES9QvsWuo6RTXSfDeEAoW5SRfYXg8vm2yTeqbU6znw14vU?=
 =?us-ascii?Q?0dqR8+THz3ylWhPnHjwyfD8yXvvSnmBXkB+cDw/1C7Qsaay1smFWLoMvw9xk?=
 =?us-ascii?Q?3me5b6Vb/JTCM/eSre7PpfyPg6UHcDCNf3b9sDkPRP4ETxP25X6d5P7wLnnd?=
 =?us-ascii?Q?9KBIBHKQAYOPc3BU1AX4CSRVXOYgD9WhzTRKjQbAtln9l7K7I3Br60BlasIj?=
 =?us-ascii?Q?GaFE1luvXECJWks/kJ+EQe3lvdcgza+LGZWr8HT9Wm537SFFpGr86+OOuTr8?=
 =?us-ascii?Q?rZx0XcNbiHguurLffagDrWCI4OwMCyIQG1oOHKAK29raaueWRbk6BOOrU+Ez?=
 =?us-ascii?Q?n5AX/QbQG5bBx0+1X1z8FNW4QGhV6SxNf5yvS5x0iKUZOL3h2d85ijZ3JXZd?=
 =?us-ascii?Q?GNAnrrH++4Ub7FC/Rlk63bF32hQOdFSMhkSJkM5LsKDpGNs5SbRZFoaEPHJV?=
 =?us-ascii?Q?L49G6Sqbffz9VUrLT4AtmWhPfco5dYqaJxRodr6/VDjzro7CzHbfip1IH8ab?=
 =?us-ascii?Q?Fg6XncagwhjbJq8I46GIfV/UA09kmn468haMTQIiY1QaclB3cCV4BFgIKekN?=
 =?us-ascii?Q?ppe++5MhEHAFhtrUEdtWrlu7wii0hs/qH7Vg3JAQiWY44ZGVUvnsecMLqW2W?=
 =?us-ascii?Q?OblqiW3PXbZdfeyfOiy9MX2Qz+o55Ue7diuUpcO2Zye2b7HDJ+j61tXp+mQS?=
 =?us-ascii?Q?Qikk9CtAO0CqC9KJzOYlMlc9Y7fnzqTUq1Dwiiw94Gb1dE+lV6NN6KrmzUWP?=
 =?us-ascii?Q?VUXNa5PBDT0h3F1n4k6uVCedo7MaPSJoTi1BzChSNQDgbn//GXzxjvIMBbhh?=
 =?us-ascii?Q?Dv5F5ZUxsbImOt6QqJbqsfgsRgMco4hSN34/L3z0rRXj3MgZJP3zDa9u0bN9?=
 =?us-ascii?Q?dNuMdbYB1sef9nCIUDjpe6gW5u55GBflAJjIIVLEEfojezakRmdxIbinw27C?=
 =?us-ascii?Q?LR3iCJIJqIbTqqCkA6iE+/vqEwTEffDUKCRcu3Ok/zeN8eacJFzNyyYRD57O?=
 =?us-ascii?Q?nikWLBn7MkS4dad0oxn+ZVTQUPamtZCCS27ChmIeTgz9im+nVLZ15SVFfk3z?=
 =?us-ascii?Q?TQKYuC0kLEgXJmtDakzW/zqfD8+9FUVRJBmLXBoMV9ciB0wExf28nyaJAyw1?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0suMi/ICJg7Q2/u351PnQftpzk/nrUUb+L4R3zkql3Wx3QBp53xWNwBGcTar?=
 =?us-ascii?Q?diEeDOYC85Dv4OQ1I5/ezW6xedM1M2UWD8jUcN8Zj9PXJHEuteat/fprhvNw?=
 =?us-ascii?Q?nZOHaH30yW/eZ1gWK9Q1FgqjML+C2BZdekOqX7+ObF8OARkAh1vKYyC6ha5w?=
 =?us-ascii?Q?LpkkfCqsvuFrNBh1V0vAmCuf9kziOQALegflbsWyuE0Kdf0C9pLvHjGE264u?=
 =?us-ascii?Q?SFx58VBAl8+/OsGE4glqpHwjieLeB1tfVdA5kJCzV3/U2l0R+iDzPMJVuRke?=
 =?us-ascii?Q?eTaKESqqVKj2hshSzbwcAL03hpkIjVA4yA8GSOG1sr6sZVTlEw7HPqFp+t6W?=
 =?us-ascii?Q?ybxanphKKacVEWvYcGb86fU0JC+42Zj89M8E5tuw/e/KwuT+jnkqwgJt9GIF?=
 =?us-ascii?Q?8DgPLrMoi1sszu7m4POO2wbBwE32sDAzGqlNmNcnoUacI/axAGCZIqVOW/JF?=
 =?us-ascii?Q?7g/CPm2XisrWutcD7itjoIB5qE9Z6cPG0V+zmizJz48+akbThhVTfbTTrTRL?=
 =?us-ascii?Q?aOXhjiK/8FO6xlID3QrpDxMJtQO3EnUkOgDK6ZVf/JnttGSHWu8Ks8zL+bJb?=
 =?us-ascii?Q?bYAj22ocYErdVBKqSsVLN4mw6Oa2qHCo64hxqdW4Qm5wqGyt6+IfJyE8XKNX?=
 =?us-ascii?Q?w4QuJOVyB2RDQYHHMmW0cRJbrrs312TQNcvRKy55yT6fqT4/+9nTI2rEi8dh?=
 =?us-ascii?Q?ghy8QX7NHzXYsnDcWGqu50HGWwOczOsrof+FY/7+chH6KJ93Y+gNACh9XRcq?=
 =?us-ascii?Q?Gmm6gOkNQOMtUOoTBt9L43lzzMV+3ZwfDrjD7/Xfkhu9rM/V7lGq61zkAAuJ?=
 =?us-ascii?Q?su6Ak/DMknwjC3zvnF0rckViR1EVyWGFgUdMqlkTeEt4G4lJQgmr+MFr1ytH?=
 =?us-ascii?Q?zhzVWyTKYRYMFeS6i2JCOVTnueOYlfEuDTLBnVYiezBu6oaUA4bzz4X4wGB/?=
 =?us-ascii?Q?ke7oBIDGpnXw1P3HfAYIvMdrtpb194rg5PGBG3bRQD2y9eEn7wJUUxQT8oG8?=
 =?us-ascii?Q?IkZXF6tUwy9ulGhah7jsP3A5FrGSpgnxFxBNDhdy/WdUj0KnDsTAcl1WSmiC?=
 =?us-ascii?Q?ckFQPztfUtsF8KXqr5QhvlftmyET4x0s3s/IQnCTGbXKjZ3WsExDZXzwBlyx?=
 =?us-ascii?Q?xBKBUBnP63GI9LwlcMOyIThp9eg+5KUJfzs8ct1N+Dl17FztoZu0DTJK55/Q?=
 =?us-ascii?Q?xc5ZXLvm1i9psy7n8D4yX5GawVbZFdU3e0ESogGRngJ/8SLVC9328PeddBMH?=
 =?us-ascii?Q?k1U8J5uF164rayZdpaIYfJeIbEe5ktUAFEDKRasVc49MHa5NmlWpc24i8Y2s?=
 =?us-ascii?Q?BJmTIS/cXtP5z23VPn14OmJ8+tH5RSQlfWopvU7Qp4Cq5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd1fd56-4aa8-48ff-1320-08dac81c17b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:47:01.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2dcazXdWXEevwFt185bb0V9exblpmJH2AAqf51DolsvNKrjN4sHbpJzd6ttkUeH8AFkxjSlsfZDECnU/uNxVq+eTzsEzpy79pdrJpF8vWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-ORIG-GUID: Y2K25I0AE3drzgdur1lWU2uif_NbwUGP
X-Proofpoint-GUID: Y2K25I0AE3drzgdur1lWU2uif_NbwUGP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f98d1742872b..cc976948f17e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

