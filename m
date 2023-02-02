Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C688AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjBBXZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBBXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5096B032
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDpJ7011698;
        Thu, 2 Feb 2023 23:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8OzPqjwC6FJGRhR/XkHY0bienzxTR8QruTu4B92H35o=;
 b=rQgPQYP2v3nkkBbM97T1NtFVw3QOvyx21WILzFED/6noXKIdHZihdAuQykMd4iSbXZl8
 DTeMVZRNgRWszf5jIxGt1XQJDGCcp02P3zPKgdpS9tYjJyM4fgLdaJd+TidGiGwZzzsi
 /ZfvbObSoQpPXWhTAPrykzjlRtoWb8un7r75Mta8ZgBq+lyAUmjaRMX+UmPQlnco3TMy
 0RLmygTexcePBYt80XXOJNfa08zgxrzyT3YuzHmJJC/2G/l0CC+FoaSSjgXmNjXJyWjo
 vIKS2WZtCuVqG810kvUaUG5aX/7KDV0ET1aZTWAQLJ2h2yoRYQ2tJ+RJwUMmQ7jyMGY3 dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkd1vms1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312NEqb4034153;
        Thu, 2 Feb 2023 23:25:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5gbawe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa6uXTZZh2woOCzQ4CRQVMVgAMxaDcUAGQr7Nbx6mTE4ezRIBhJMbH5LhKML4SoM12/VywBvp8Ew6xPLiDXj7DcKou6Le2a3le6rNuPAmkyh5SdXEvovnR3Bm2bwazfhPyc7+CkzGZFVxRwH+x+WZPu+PrwoYPyA2LVhEHy5/pEXWtwFIHfJ8CYzgYCMDHBNa/cbdNPOidBbAEitEhJW6/7QiPZTMOqpPI5bRNWrJoWbu9q+l745N+bBl1Oc43Ri4AEzPuly+ZgkoAfUKWkCpYRb6MFYAgXHhVdPnbRO2skGDBB4GTMvXQSNc2wbasns3qFG72LZhBEy+/r77iw+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OzPqjwC6FJGRhR/XkHY0bienzxTR8QruTu4B92H35o=;
 b=SoWQ/oDkIpVhWc6BoCM1NgGOWxD90bPJAKeZ8CM5FluX/Z9uSb3wplNqvveYZXZsS8B1UKPY6B767F3TRqJy6f5rdbppgsBPgRq9uAVDZB95CrFpu0hcxjBex37OSHBkuUoD9MOgnJ0CsUd6xnUYxgLdYRRHXh+hvXQMVKm6bbhIOZSXXTu0VWfyGhCeEmZy2JbO8VGImGju5jDGIw3WpUmvZ+cXVZsCiyFUep7ae5VUQCOEVE5Lw7YNRdscbt7zocA5VUZT0h4iyrX+zxOMFaWKAGU+GYekwh9m/jXVbf03/Y9URszMLe3uoI2U9wvhTmd7dQcSXpP0P8gE6m5KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OzPqjwC6FJGRhR/XkHY0bienzxTR8QruTu4B92H35o=;
 b=rKPkpO0ra0DAdOORJ7nVSmZbIvCOCtNvbEPjQkrLSR7USPxOSfFWAFWrTqXUN+J7RLLu8EkNXSAL3ZSnyguNOh+SKq8pfDdBU/WbKWNh9ElAnfNbRuiSZf90XGNuMvnC/MMhuamhkr8d3Cwt5dA1ngedyXtFe+9Df+8w18tv1qY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Thu, 2 Feb 2023 23:25:24 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:24 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v11 2/8] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Thu,  2 Feb 2023 17:25:11 -0600
Message-Id: <20230202232517.8695-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:610:e6::32) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 8199dfb3-28e2-45fc-01c5-08db0574c2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: novCI6Op+0dVpZNxcv4ekd5Lj3QtbPFLmM3ekClizE4YbjCqj82xLCY1o6WRg7GIqqiYwsGOHduWXjQ1MYOwk/vSJimfusFvOyn+Z7sDlw196iYKiwZWfou+6hEM6kktnVYXZpkBrUAeVSLv0wsPdA0/zTNSA6XAARCm71a7qeGkz70Yjz8rd6B5JxpUUPCPOQXohDImrzR79VOzHiggDJO72ENpvkvIVIHWxEkiSjn4N77mpg7xNXJojOlfkWNE6EdCng8U+VjMcqLmlBjmJM34SnR8IX2gUSFwVDG7DgkxLqyLjhNSauR2Ujii5UGU1JFmCm6ydSI9VtO7b5BjevxAMdomWbZ8CbZTto3cLJa5tjwlKYLWVatpZcG1V4+dP/Py481pbb6EeIf/ZIiA8Pb2s9p4AKkGQDm+9UneL95uXbF4tgQlMgdAf8HcAy87lbcWrEIgaGQr0RbkwPiwQCGlo5/YXGlx5SlFfbvLU+k/oxMHNGCROhzTaZ3JRgwPRUSiOTJsuBooDgf1kS4Y9L5rF77I1JahPtQCTwoHD09Y7i8wRjbKo3Zw/XCpF9n+O3wHm/Dxh41XuNTbwC0pmPJO2KWfvRxxN/VcxoXOQNPmrUO1lnO6aK3Qz5o58JLkC41AHQVqCCcLo1t6JtGxXjQiWe9dG+tsVmSJAF6/MILK4FFPmiXW0+vHEfXZ2nqU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199018)(316002)(83380400001)(107886003)(6666004)(2616005)(36756003)(2906002)(66476007)(38100700002)(186003)(6506007)(66946007)(66556008)(26005)(1076003)(6512007)(6486002)(8676002)(478600001)(7416002)(41300700001)(86362001)(4326008)(921005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6K3ABrGq3MAq7ZYFA5WBSY+fwy9pJnXl3i79emtMWmM8an8JTd2DjlF03dvf?=
 =?us-ascii?Q?H6hv0VLXWxz+DFx5cSglCG1Zt5a5bDxJbQMPUccAXk/wAhv0U43w7CHM4xUK?=
 =?us-ascii?Q?MrQYpw8bBlNhFaR9YXPElbnC9/p4wj3lxW4C5co4ixhk/uN/RY+/OTunM9J6?=
 =?us-ascii?Q?lTishPGhglypqsJPoujnw6Rlr75SSqiDLn++irAyBe3GLwcbDic+z34eIY4j?=
 =?us-ascii?Q?4i3oVAYSwtMJmu26j5o4eMTLJiaROFAh5aDs5bTh8kmaeG+wvY47rzkx1UFi?=
 =?us-ascii?Q?tvd2nUKPr3um42NhdGeeMMmRBLe6a7K+hoXqZcSEfcABL3LPhASucW2B+lNS?=
 =?us-ascii?Q?M6ykcBOX9lJsEawb2EBFrYGVShAzDhuzsprWT8gJxFsCuSidKjfEVoWt1ZNW?=
 =?us-ascii?Q?B/VHEmZ4CXjDT0P2KUSrf6uTbhqpbhNiPFHSx3hsZDpfqcnen7qPTORsuVrU?=
 =?us-ascii?Q?nl+tTxNwzBOzOQDMYORDdJllX6C1FskOWPES4XIhPjLaQ+HUmXADcdlJbVSL?=
 =?us-ascii?Q?LxDd43JB9he5LlAUGWCat3ibZgWmIA54wQEQDSyYTiiN6PquhW9RPD5d2Eos?=
 =?us-ascii?Q?SAzRgBj4r2TeXY5F3BUDj9xv+mBvW3Xks3knNFh2UgOWTWUm47XCcA4e2EVS?=
 =?us-ascii?Q?BhdOhbeJYg+iXKxOtgJBNqCSBs0WstdvJWsOiKOjAPm1YzHka+espahYzRVZ?=
 =?us-ascii?Q?/lELjWle/UrQ3dqR5q9cDWtlhJkD5DfT3vTJBXXFF67dzxtOcPn0QSubss0r?=
 =?us-ascii?Q?zaYRcbA2YNQ887w1OmDxOgIuGw3erQnb8a6Bovn1hdSUtFQAAvONNApksutZ?=
 =?us-ascii?Q?sII88S5UGx0QOnMZKcgCQx+CB4By0BB2SWcv8rax3fbrorgKh+pfjLRTWCm+?=
 =?us-ascii?Q?Mr6XeLO/Ep83/W+frmdBIa+ZyOoWLulghMfxEdzO5cSBEV4Z7csCkck7uk9Y?=
 =?us-ascii?Q?f2MY0OAuj1wWwODn3OxNOT93N1sMXGg4ZjMrGpz0rAWstRYuv+mm7tHDn0RB?=
 =?us-ascii?Q?HgWOABBFm1rmScq1jlawF/9oviOX1qtJSFgiGmwg8qK7VEh3XAj/s47jm0Nw?=
 =?us-ascii?Q?GqsQunzplt91TPQd9lRdS/FDUb5oiSHTvwSjNaWYlVaqrNpsV59HgkyPMTJy?=
 =?us-ascii?Q?S0MAkhp3HEcIzhrq73YzJtbW40kvjceFQLJbnnsSPoV9uNaHICuNjF+bSyNG?=
 =?us-ascii?Q?E08hiIGLVfQK2aDs9xeQpbQcneoe6WNAX/lz69vkmrXOzRRMf/GKa8ovOzxm?=
 =?us-ascii?Q?sVmSeI9SM+/fLC2GbxHMvvAWDh3fgxP+fiooQLtR+jK0XsEtFo1nSyCrWBdu?=
 =?us-ascii?Q?o45d0MDiJLbi4nalFoDJDLt6uwW3/9+rYhqBMNerraP4EYpZA9g6wpntCduf?=
 =?us-ascii?Q?xW1I3Tfm8DRvzcVWjRFae3P2Jru7kdZb8/d4xSfmW73Y8SMV5k1gfC71f49P?=
 =?us-ascii?Q?dTMAVLBN9H+pefKNqcOwv4AgKicUeo6hIZ2GTcTR+EnEx5WcAns50hfTOIHK?=
 =?us-ascii?Q?ge8Dye/6d6ccg6I//xjVNxJ3iLPVUFwwZdyzdYVhvtDoxxMwlzQ0i/oW+Cd6?=
 =?us-ascii?Q?F/nOXbWhyKHYEpwSFnZzff+qv+Ezsyl1Q6LaRBfxN2jYa7kqytIZo7iqqDIn?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2EgoBNpnd7KbkQV7Meqz71jv6NvwD9euQePdxxU2ENa7DLgRTsAKxVAaY6bC?=
 =?us-ascii?Q?JKY7EzfWHCcmBg26lG5IhYzq4bNxvvaTQL0gyEGFs3m44r9S53HQ1OitMIgb?=
 =?us-ascii?Q?1Oc2GCLI+F5oAobRV12RhYtNEp1dRNLSgr1O/PWJA2TzjX20HU85Q9hOLrkq?=
 =?us-ascii?Q?oPO3BCyEjcWfQXOmkAUS9O3H7XrOaA97KVyHjIZOwPF39pwEnGOE67tiUzYo?=
 =?us-ascii?Q?u5HpVS2pU3VHHLz4Gs42xgEMRWekS7Zr1UH4Ln9LRz9VpMyOsTQqpRvy5spi?=
 =?us-ascii?Q?QbRqZTqWFsU5SnChiLpOe+jb/5Xzf1sU3UF1q5glS8v2ZBfPNOggvsZ02fwC?=
 =?us-ascii?Q?nu8Yf3uSqMqD2IISdimRoR7oLWPcou6O2kAnWQiwcxZplvIlmwDQol7nU/gl?=
 =?us-ascii?Q?wfWX6FRr770NingceJIkQ4XnHrAV+LAIjYO7vHJlhZTyWO3e+6wzRhf+1ZIs?=
 =?us-ascii?Q?x4HpMxowREhwokkSGkT7cJ8eZd3hQPBcmQWoUMu14J5MnVbsAkKR8YLiNbY3?=
 =?us-ascii?Q?PDxsfGsrr8I5XfVie6dDDTJs4xrllUV1C4MXU66wcI5M0Rfp/9pBR0Qiy1Fa?=
 =?us-ascii?Q?nTAkQYFQrmP12Z5T/iKxEXHh0H+Br/BidmiTG4HGVfk281G5YWoY93quJBg3?=
 =?us-ascii?Q?djA2AlsBRlp6aGtZy1L5Dfk7vh+VR+pyRGUvrs3ZbanrTr4j+0boJfQ/xLXw?=
 =?us-ascii?Q?J+Y46QL+YqjyPQem40R6Rbt/yyQfJWgCal7peMv/Xcx5BuhCH9W3sJE8Wi87?=
 =?us-ascii?Q?S4Q3zuIQpsc9IacDQMXeKfeknT08w+bRMF4o0Zl/7ZG3v5wvn4NT2bGfK89/?=
 =?us-ascii?Q?dZ3sp6M9pzsfk1BNmlJ3qmE0f+HOFtm5vEKe8W1hKVl23dEh+7ZhUQhMybfJ?=
 =?us-ascii?Q?bBjBrfiu8x3vCKoGtdHnDMJl9XAOJEMCFEHGwMS3p7ewX6luM/DyPOJth/7I?=
 =?us-ascii?Q?wIKa6NUqnZBaIbrmmRiL0EdsWJwG5xBpQahYFmCip+u3Rzqji5gEcemi5yu2?=
 =?us-ascii?Q?CkuBYZRvTNOUgtr0fPY4B1mT5g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199dfb3-28e2-45fc-01c5-08db0574c2c6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:24.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEmNIoci5rjjEEqypgAD863InlKh3j3Jh9q3AyfXSjErcQEC2dThjQ5hOxOIo5kyufbC1J9TZyst4F0JKjd6OOAviNstNnLZUzPuIjuTZ30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020207
X-Proofpoint-GUID: Z5EfaigNLXKGw_vPOHGHmIQdvweV7ePq
X-Proofpoint-ORIG-GUID: Z5EfaigNLXKGw_vPOHGHmIQdvweV7ePq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use a new helper
instead of create_io_thread because they require different behavior for
operations like signal handling.

The common behavior PF_USER_WORKER covers is the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched.h      | 2 +-
 include/linux/sched/task.h | 3 ++-
 kernel/fork.c              | 4 ++++
 mm/vmscan.c                | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..2ca9269332c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1723,7 +1723,7 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
-#define PF__HOLE__00004000	0x00004000
+#define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF__HOLE__00010000	0x00010000
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index a759ce5aa603..dfc585e0373c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,7 +18,8 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
-#define USER_WORKER_IO		BIT(0)
+#define USER_WORKER		BIT(0)
+#define USER_WORKER_IO		BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index b030aefba26c..77d2c527e917 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2100,6 +2100,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
+
+	if (args->worker_flags & USER_WORKER)
+		p->flags |= PF_USER_WORKER;
+
 	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637fcd8f9..54de4adb91cf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1141,12 +1141,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}
-- 
2.25.1

