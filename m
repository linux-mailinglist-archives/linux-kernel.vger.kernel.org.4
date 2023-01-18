Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6B672AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjARVgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjARVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AF63E17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKnDFa002415;
        Wed, 18 Jan 2023 21:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=f6UdExf1TKM8GUOVAAnj9buuvcJy94WdoCzKS2kMVAo=;
 b=rGAnPudw36n0GN0wiWEHkCR96+OXh2ZzsW6fNX0dWHfa4M06Y4pSBVU23lcUelF9JHII
 3O2Yl7fe8gptAxndVwO9etOA0hON9Kt8ZI85kv6wS+/mqSkyb99GuGMAULkXtMY2Rev7
 DNrAI9THNtLVgcUCHPj+XM/UM3Wtrh9V5Tj6PGkOt31GQsEI0Dj/sfJlTjNfPymvgGBQ
 dYAdRc/2eLA6Nqb7ce3wc1SYEi6NuIFa54AlzktQF8RtZgTHWhLkT++CTV0LX7r/eCF3
 PAD7BBDVem5gEHgHBUcVLGtUlu+2rgfkdQO3r9muVeZUhkByxt2V5MYO6pN5owbnHEHM Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k010t89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ILDROl033460;
        Wed, 18 Jan 2023 21:36:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgc8tb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1MODJtXnMXH7aHVTcjqpq/pmu9y5wyDQ/sADLmpyMdstL2gDVrgI7OkrLV/ewBWTRcmDVGhLaN3n7a2I0hjm4qgdjkSp+14qEqm1RChMTv0RleHOsetqMP4XoAIfV/LW2FafO76eEZTz1+KLQW8cI+aN0hfHKWHbz7RMu10n153YFkzB7Vi1/MG/Fa2Pa2m9Yp8h1l41gQcZdEoSYEIBft+pHr21ljuUBlgNuYpPu2pDmvLqvGikET6H325cb0a1dVbyjyWKQIjXWYYF+JCNWSnmvcI32Eip54QPnPRcTgQ+BYfvYDvFgwBs/5o/30V74ULdUelLvA9I9MgKIICfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6UdExf1TKM8GUOVAAnj9buuvcJy94WdoCzKS2kMVAo=;
 b=gy9pNNUqwQN+Xru7V8UE1MLRwTXI4Z9xnzTwk/d3qXAJ8i3CI+iWQA93rdGPSTEggg92i3MFtu0oN989dyFOYQvGo29jNSYj330PiUl8XdERoKZRPYPDgBGKvtQw3816AoFZ1AcVmwzFLFEu1lk2qrFO1VMvg1dKoeDgUbtod7UnOfJ+BYVgkA3T1Ehq6d3rc00O5Gjy6gVc5Mc5BQANxBIdYOrsicTsPomhEGTTr3CBsgFzCNB7vH/wVwib7ktlebdwtwFFE7JP5UldYsEQITm3CktM9jl8TJOS8aTRb01PFSvrRpyUdLlewgjQUEtvvyhlrymmu1MzAv7XZ8OTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6UdExf1TKM8GUOVAAnj9buuvcJy94WdoCzKS2kMVAo=;
 b=moy/RY3RF1ZN1B7xol6Y2gsRwsAD2kzoDgx/OLtD9MOj36Q2+/Bk9jSeQ4KMnxPwbS0L4z4PSgXLfj+7ojUz+1FxUFM7NG8J5PVGBudhafgclCNsGFQ6B3HJYjISGG5Ug0VSwWB14+yNpX2p+SgeVBxj0htdykZ7VSaq1CmNQZw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:36:09 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:36:09 +0000
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
Subject: [PATCH v17 6/6] x86/crash: add x86 crash hotplug support
Date:   Wed, 18 Jan 2023 16:35:44 -0500
Message-Id: <20230118213544.2128-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: a477b4c6-a27d-49bd-998b-08daf99c030f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qn5KgznBrTdchz6IpNuNBVJiv/466ys0F4bs0YAtfmgEXdi4VUUc6zp6ieBfw9ePFfIU4vubjTJflXSfdD8JmjSwwsONOfMtN78A1AVinkIC73M7HGM2EtLU1eE7sUmJlgIS2esPnNHk4Arf71Q9PEiB/2dDX3KAjSjT/rOqqsUrZoScHA9a7Uz4gDF6SnMib7MNuEoEdj3bv8QlQdPEp7NNqZ54X0xLy7PPd/0LVCvv2FTXfJOKmgI+0st+BQCgwSpT22BLio1mW38QBDv3sYNkcpRK+5PaqqIkhThS5z+/lEXd62EWzHUB8AiL43vqSlmdOXLY2yDhJyb/OH2DrALX3zHTMBHljhoo1i9mDsGfthqNwcfjCvKhsHavdRsizKYEWlTCa1SRKUE0HRpDER/62Hj2VoWtkbouQATRi8opCE2SbfACB61wMpzWy1UMPJCqrlYzA8N2bBUkizJMXNvpeBIeZbbLJ5R+FYsJ6GygMAsHXFgKkpose6WArQUNdr4ebraGpjUXBtAG0nF6tC576JNMRcAQ0uT2W675hqlslPl9633xml/EKjs4Yw8uhcm7yF7tscuUJG3MrizrX0kvgbL6vWYH63BVKsEYYd94kq2XgPWpD/Jh0NYR75Crqb9YjW/K0oePpKXsA+PLUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(38100700002)(36756003)(86362001)(316002)(66476007)(66946007)(186003)(26005)(4326008)(66556008)(8676002)(6486002)(6512007)(478600001)(2616005)(1076003)(2906002)(6506007)(8936002)(83380400001)(41300700001)(107886003)(6666004)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/to+1Kk5oc8DtTn0xl0gQO35O3GQPdv+JyzWe9rRFUoxvevkoihxcW6VGFpU?=
 =?us-ascii?Q?uZAAREzyI/b3/l9qrCtVPc4eRql3yvy7srlfeyBuot+LUElJN6wEf2Y19STa?=
 =?us-ascii?Q?tnuuDJ4DbTyugTL5Z6hij5dgD1PRs4gUOcZNlnDAJugOIxojrBfe8EUxw+wT?=
 =?us-ascii?Q?2FfdSOQ6otXXdJfRoNYdsREQSyJTqtQV0kiOV4WYYkh9GcYwLmYEcyx5F4VC?=
 =?us-ascii?Q?DB4JjtCBoo6/1BM6MIjzLa1/9FaMxu0fBer7trEFPR5nP4NzjBMbOPybh6Ua?=
 =?us-ascii?Q?cPYlSX/UzyJYjaX/aKg7LPcSGsVBP7BZXqUDO9knH/XxrMXJMG41d3PD2QcF?=
 =?us-ascii?Q?9qWYxP217/T/VONxnT/cbrcFUYRBexvfJ8vsE7B2VaV+WvSlSlOI1rD4kXtv?=
 =?us-ascii?Q?5OP/cq2/vG3LSWgWHJ/yhcnxbBEfyUEmYRhA/AxayacKdqFk/NJkUzIRmWi2?=
 =?us-ascii?Q?zbsn8WpN9CMg38CATwWNylIeVDf27GLOSjIVacCjfDyCbWREQeZ1xh4YXVls?=
 =?us-ascii?Q?NlW+j34rR1c06mxpvz627cFliI/sayfgfv/UI2QbDdnA+AZdVNjI++rQebUq?=
 =?us-ascii?Q?TEgHfjY+TagtQPUBKLkIpwZHPZUSevksUCJAfeimf5vig6hpioPCVIQxgcPJ?=
 =?us-ascii?Q?ANAwpN7pNPx1N4LLlM5rw8RvCFZOhEg4U3/KRwA1+DKAXBzKtiwDzk1GB278?=
 =?us-ascii?Q?mQMWGVp9qTX2jumDHo0KlaK8VWsorRqUKi8Sc3WJC5oH+WFfO0z2SfTWOK39?=
 =?us-ascii?Q?sZ5CRIWOEGnC6LbB2Q1Rg5d6ZSOfLATvopcrIma1VPRQFgpYbW3PNG2VOhXw?=
 =?us-ascii?Q?GXvbdn8WnXytw+cPV8rpPS8ZDsVx5xWT5eexRdAJdYZtJCHZyxqYtr7W0EY7?=
 =?us-ascii?Q?xfIN0CJLQZPPIytRMLd8cM+IQ6JM/2x7L2RUvT4/oFMvGXQciPVr0Xzc+VL/?=
 =?us-ascii?Q?Rs86Yh+4kLqLbZqiv1Vy40yhzPQpSfZT891NUbPzRQRF87rk2YdBbAr5JRob?=
 =?us-ascii?Q?PuSKdgyBbnZIjc/nrTFTiftrCOeSQ5H6wSXOcF7rjlaR2CiqbDeWKUJalN5u?=
 =?us-ascii?Q?JpbweHezdUeyIkBOopIVmHVB0VFprOsgvMnA5L5Pm1iD30pEdfZGaALllLQe?=
 =?us-ascii?Q?tVVO5w7ztDm/0PNE9QI3GjaYZvPsPXd2icuALrMBEjXCPK/ah55TJkrz3vUZ?=
 =?us-ascii?Q?gZ9LX6TC3nItoxANzJaTOvML3xF6/wDepJMWFin1cLjPe3A8IFmShhqrCyGm?=
 =?us-ascii?Q?ac7DNvaS7i9xAukJvUHLqxwZ+VlL+QKN1+95SMFOp3/RxkH24jRZUOGcP5Fw?=
 =?us-ascii?Q?JfM4bPmk9LPtYHTkfT9CsVfo4UTuGlpyJBk/zI3B5kIx9DKpkXdymw5h5iP1?=
 =?us-ascii?Q?sW1AQ5ss2lQmpbLAVaNLN2XvMlsbGGyNYsf9qCXnloCMMrsp1zW5KNulREdn?=
 =?us-ascii?Q?jJWeU5E0y4rTmfbFLuhbXWmfz8jGBTgN77VQQkezOf1a9xLPLkwUEsJkyMHM?=
 =?us-ascii?Q?HSYT7NFWYQP6zO4M9oznqJ7oD/VochFpQHyk3aMmdtzSWpZMZ7vETKiFPB/y?=
 =?us-ascii?Q?jqoU4GJMguWuxm2eHcCDdm0meXDh89iF/qqCSno2yKwhy/B885l6zBgu/5U5?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mBPM0BLqpN5XIgd/J+9ZlisJ+mmbBcjUbxJoISoZ/sAox9ChLQu+tJyFjDYG?=
 =?us-ascii?Q?+QGOTBs5IByBgkxm0ZBXq0xGxJ4TqGIz/rBvp1oRmzdCEck889przRaUWZBt?=
 =?us-ascii?Q?VcjJzeP16S84rQQZyPV8iuEsJ7iyD1V6Qf97FOmrmdNHzI7xD69EHvM4ACpM?=
 =?us-ascii?Q?6hSkQFNH+prn/Y9XnNym+EHtyXfs1PITKbjhlg6FuY9QLT29U85NJz5GhKC8?=
 =?us-ascii?Q?WWPvg/GjkqP3aF2vKaISh9+kL6ui9HYR5oS1qx8VkF0wpR9V8J3OR5QNxJrz?=
 =?us-ascii?Q?xtE1VKffkXOf++b97zpaGzP+EreX5LWZWxDbkujhlSGWUxJ2PoR9WjIz847S?=
 =?us-ascii?Q?fcP46oEhMTn+qy91ZWRRilSDBW3Xd7JSSSFoBeb4ZtO5Vb3iTIQaBn/nHCCY?=
 =?us-ascii?Q?UMFEPhDp1n9RHHzk8ycBx/Nh7Uv7N28oDM0aGJtDxCPX2fBZHz0lU2vfEgTR?=
 =?us-ascii?Q?l247QZVJaj9sqTWNRWOiD+E9JzIjEjE8Bj5U4HsPjKDf1Q6haX9a0AZGrhfu?=
 =?us-ascii?Q?8sVCFSRvQnbkULcerREi2K6Oi8duqcNu9YIlQ1+vhdEdwJa6LDhd5f+CL/vr?=
 =?us-ascii?Q?JmBGoE6pQpPRKSexg1zbsP7cj9rTc7EAdM7npt3/vnhPjr+lZTyIqE3S/cEI?=
 =?us-ascii?Q?qbijeNnMtvOW0zYFmcNlBr7bBlxYIw+TCWyt2Lf2418UazbGboCAdyLjFaVL?=
 =?us-ascii?Q?ZJjitvEENJyKiMWl37gmxdLSG2kS6qT1SKERXdMvw+pEbFQhYWm9uxl4Z+ke?=
 =?us-ascii?Q?Uhf+F1jWT4HdYq93KINvvK/BBEbJiX9wzT/RirPr6Qu5o+Lk/1EsIBqZbk22?=
 =?us-ascii?Q?1T8OdaL+IsTpZsPsc5o37nwUoFlMCtQvzaMY18/hmmNtESsp4wOk/ynFHo9V?=
 =?us-ascii?Q?AnagkP6nRQTl0hnxkG0E7MLsxz/pQiY3rhRpYuGONUH/S8aki4iM3U3MHg0o?=
 =?us-ascii?Q?zmsAksz4fL/WyZltz9mEsRL2O+W6W0eOd09WZI4XNeMCkye8sqJfu2CJDXQ6?=
 =?us-ascii?Q?EtflN1/EelvX0vvwNOB8Acmo378uddNUMmGNEXNFyav03tt9KwQSu5btA98s?=
 =?us-ascii?Q?LATmBS+MUmTxLbez7VzQDvroU11mFBCWzPoJRUsgVhkwR+aGobOvT2y8kpB3?=
 =?us-ascii?Q?YXfDnPu6wwef5EPdpMzzrsnnPaIcAwfN0ghgJ/Wej3iwXVlM436gecI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a477b4c6-a27d-49bd-998b-08daf99c030f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:36:09.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8nyeIOTH6hHAd+LTwEacU7qXmdX6D8KRbxIYEw1Ls0IQigSGjsQf3UmsxbvzIfIHxaC+UV45qhp8fhqPDWoxhCCBveBqM2bEYJQTOOvBuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180180
X-Proofpoint-GUID: Dys_SDOHcN9352GpjbvQwddgzo8jdTl-
X-Proofpoint-ORIG-GUID: Dys_SDOHcN9352GpjbvQwddgzo8jdTl-
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
 arch/x86/Kconfig             |  12 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 123 +++++++++++++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..09e9b7a091ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,18 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug of CPUs or memory. This is a much
+	  more advanced approach than userspace attempting that.
+
+	  If unsure, say Y.
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
index 8a9bc9807813..ba11c7e70edb 100644
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
@@ -173,8 +188,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -246,7 +259,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -264,6 +277,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -272,6 +288,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -386,18 +403,45 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long nr_mem_ranges;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &nr_mem_ranges);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		/*
+		 * Ensure the elfcorehdr segment large enough for hotplug changes.
+		 * Start with VMCOREINFO and kernel_map and maximum CPUs.
+		 */
+		unsigned long pnum = 2 + CONFIG_NR_CPUS_DEFAULT;
+
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+		else
+			pnum += nr_mem_ranges;
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+	}
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -410,3 +454,68 @@ int crash_load_segments(struct kimage *image)
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
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
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
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

