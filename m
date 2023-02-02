Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6F688AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjBBX0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjBBXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AD62793
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDmlo027106;
        Thu, 2 Feb 2023 23:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YyX5FcTVXPfGWxJkJKarYQzlIruAFxA0wxiAnVnrvZs=;
 b=fJThlsKwsJDzFC+Dd1WBsIqmS7CN7IPF82fH/LFNfR5fMM+epyV1RJhBItoi1qJRWGXi
 TsoerqbZmceR0gpCBRhrDogKAr74be69kj76xTAXCZHEErPsGR/KgPwCcrO793dV1KCf
 ++dnJdZv7m8fAcVD45wDTktttjPHsN5LQJmOCOyoHMBmZrO4jOGdqqCxcq0BH/OSXqLc
 kZaTXc8pJMsP5dxlM1B3G3WRHfUJxy1m8zq3u7KVvqRa4z3WdTb/Gt2TDuANfWEUHwx5
 DkNgZnAQlKm8h4c5H2pEQAhuFd4ihH//2qCy/GJEy+X6kUAKjczct9fUw1rYVD0Tdr+O fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfpywm6cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312MlwMg005929;
        Thu, 2 Feb 2023 23:25:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59rb4b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZcu7HhhMYzVZ5BJ+CiEGyAE7M4fhTqZ60BOsD3oZSB8f9zbB3wKFtQzPk/f0aFCJzpj1ZSrGSnd9TZVEgRuOjSClFhP6brwGOkfUIZSw4TOLZrN4XFObYkPMWIVSwTS7VOJ77iZyB0PtbiHC9CElnbgiN6AHovvB14nLUriKhGYTL1LwjJjP1mXn7p3HQA6BHP9wbKzfyzxrQs2ViTz/KA86OTMzY0ywmzre1Flvcmkp8Xt5+aCR5EXfriuGQwAX3TPuKnKkgs85r/6aHxmaevEQQVTUlzgn684r0UvIz66U9TKRoB27p8lmvRYdGHEfLC1FFaULpNJwWagSz09pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyX5FcTVXPfGWxJkJKarYQzlIruAFxA0wxiAnVnrvZs=;
 b=YX5A0MITjDVUQq5lrgNAIaF4wMkZkJEseCmUsRqrSAMNtYBh+Cc7032Miw3sG5yGZZsv0iun2KdWfLJOEPquKYuHqMfEeoo34m4NmmXmPy1FecpacS0UB3QsgrIV5y0cGslVCTPrR2Dn+sUEXIT7bfZMJtGXjFNaBSd5wj0vRy5neGLkZjHuJ6OQT1woQHIhq/XbhmU8Ot1cTDF3fwK2itqraHnmDZcXy7iBcw/uOd15zyUBRp1ki3IJ4CLxeuTMAnm4STIBp1kgOeyvsgQU7np3X876wuB/uYYD20NCpml2sLf/RRMyglROKyt67uN7dIYyMHeLF0BMsdYcxI4kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyX5FcTVXPfGWxJkJKarYQzlIruAFxA0wxiAnVnrvZs=;
 b=MIQsLMieV7BWYdX5bPs+HVxKTP99HXTJa0fAh7eovL8cws8mJYRzJwLfoxSMA2gUbZn93nl9KSnn+q+lWhR4Vo6o0ftsrb38CAHoKpY0H5FvHHdJC/tsPnhbaVPIzo1w4Nds2fJCwExk5DxYX2yUD+lOwHXPgUrQ++w3vHhS3Jk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Thu, 2 Feb 2023 23:25:23 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:23 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 1/8] fork: Make IO worker options flag based
Date:   Thu,  2 Feb 2023 17:25:10 -0600
Message-Id: <20230202232517.8695-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cee94e-9fa3-4de6-2709-08db0574c1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBNObR3JzKddDGZkJQ2jVB4cpT+xJ6aHc4sP75+gIooWgSSmkHT1wByCGgiFm4nbFIsPL/YLUyaNYfWagP1UvWpMOhyDjZU/QHfEnQUFvAx9pxwj1DqweOevKfhWyRhylPNy3h8Ka9CxCspaeNK/J9SLJ4Lh0Zxeyjym0ZLFdXNcadFjS+qcU8ODSrAqLJjpku46J3kWMDGDFUuS731OPf3UtfmEyYpDOdTpAxKMyEvbnzPi8bXgAZDR21i5HaVWqqflbgtm/2Tw7aVwNGgQE0DkAKx2PT7lc+ouev9rFUsKc3YswUI1TbqlOrwGFXwSZcf3jKpt2jsSC7ocD6bIkVtkGBWOa1ndkV40pFv4sK1bmBejgykPlI6W4rOUWdRe4p27zOhHIk85ntT5jhd2jPEZcVTnjxRSMGg8VY7/9VHS7+3UFfdjz7AQJvO9un4WzU6vY2oYBivQdbN3HYCexMEl3HWTfCajyB0dSh5x+y8U4+7UcLYvZmHuLRJklUmrA6pCQBfBFQH5RnvhI03dAa1cODOuPUpFjmhcSNDDPOmgzOZelY7k/+CS+riFjInRbMZ0Y3iCnza2WxtpnsQlTWuFJ/f4s3JGnE8MPYFXYp1Sph8kDp+z9UO8SUsdWrkOFv15jVlFNN1FKTaa00J2QpGYZFBsX40tiShasVc6/+ZZxLTyVdilE6V7WFONdOPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199018)(316002)(83380400001)(6666004)(54906003)(2616005)(36756003)(2906002)(66476007)(38100700002)(186003)(6506007)(66946007)(66556008)(26005)(1076003)(6512007)(6486002)(8676002)(478600001)(7416002)(41300700001)(86362001)(4326008)(921005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdNKRCFx1rup9EQvUJaM+q5T4AqSLdqROhfo1HQaRWbaZCy7g+4znfBTXTUY?=
 =?us-ascii?Q?2HGNFKU4g5k67+n+v677mrWjhr+VdG8zPDm1VfW2Kiq8J39EUMLZDk05oEP7?=
 =?us-ascii?Q?N3cQknBps3m+pCAVHQMyQdSi+hoWmQxQcgPtJ0Kq5mXj/NDE/f8G9uWpKnA9?=
 =?us-ascii?Q?YkuVHsm9FVjEHJMYEnWmknDkkyg2EK8RJhVm1TfULBtGurELXPDcQa7DX+A7?=
 =?us-ascii?Q?+dEYFnqmTu/iB41KeMSDZyK109HO/eyGkrRjRmRhhj1uyr7jymJ1xS9cSW1p?=
 =?us-ascii?Q?c+J8sC4S98/Od0/BUtrT35LsBfbVtkthuIjqCyRCPLboNNIorRCChLIARNpA?=
 =?us-ascii?Q?jhkHBQk7NAQF/a5rTDM7iV6/7iQ2w5A30oTNknnEoFbhsm+cFSEPj3sozM0A?=
 =?us-ascii?Q?NXSCTCol8p5dKNaWJcQTiAkl+M2ayA4HhyMTM44ZkOnSNYbUWNmnOhawbQWo?=
 =?us-ascii?Q?b7O7Y8AVt2CPmC0K1hoa/qB5q0kDun44PBsECeYDlvty9A+PKsGTLENX7W1f?=
 =?us-ascii?Q?G5Elc9lcPggHheRSc1Yf4mnPUdeFJZOU/GENUq2NE6MLRav6ygbKKI6WyzU0?=
 =?us-ascii?Q?xQ0DyigY3tTSL1I96BgchJ4mu111S4vm2sYB+yYBLMkXXrx5yqmYBHivvlyR?=
 =?us-ascii?Q?1HhGknQVn+9Z29p0wvDeiYiLbGQeD9ZbBMlyBlQQF5TtlVlaSN8cLUTYe2+a?=
 =?us-ascii?Q?WrwSuedFxCvCJLS/kcsDFkLdSPecCjkNFLlVPgUv+SXDGwYfSs98SkTHHEvH?=
 =?us-ascii?Q?vNVCLSLY5XONc6xqeXhwhydKxNAXKnGHsuhz9rXwJLSEgVk3sZ2rVf+shetP?=
 =?us-ascii?Q?k6ogpO/lgfVJNQzdjouo0b/GPMbVu1sAcWACr1wvV04vabuRfxmGPNwQPOng?=
 =?us-ascii?Q?wBVgFOZ+httZiul9lwa+yH2UE/69USKp904tYBDgvpf7d6ZmVrrmJBFi14wW?=
 =?us-ascii?Q?uMe3aoah0JDcnplecoM/j5k5q25Hd/fGBdvXNrHAIQjUTMOpC5KpM9bh1uHe?=
 =?us-ascii?Q?rlz+12W3eGsB8c7fHH9EzQ+FRT2XYiuUvVVJ2GyigQpc08ZxmG5lzSj6bfYB?=
 =?us-ascii?Q?8wpUkm2Uw8d210BePXNZl8MBw/w0l72BhSU41PRl5vnVAuCzZ5KorjL6/knt?=
 =?us-ascii?Q?bV/RK4hIRsRwHHxQoYzWjz2rIJ/uOIEKsW/c8zHYwvZX12TXRy9bqe9ArOHc?=
 =?us-ascii?Q?BIqsYIbKfiNXnjjNTVOCog4zbwoQaAVWA/wsM2r8PU44EUASU/JLpmiYMtkS?=
 =?us-ascii?Q?ZD0d89+Wmpb2PnJff0EcvBWuZqbQyG1PSy+s1bRiR2g1heiLWJNSHPYpciPa?=
 =?us-ascii?Q?2P/Om4ForOfDXGP7iHO/pyjHAQSEWM0wkMZkbEHfpOwqCbVDCxNNpmGMNxoN?=
 =?us-ascii?Q?0kiWXV+ndyZKT52VM0JT3SE5W+aNuR256MIvQk8TSLJYdi7rnqiks5l/tAiY?=
 =?us-ascii?Q?tP3qsIrWvUCcLJr6UM1KNORTgJkHL4Nf7hymCjgIn+E6iivjkXBU5jv7lq7H?=
 =?us-ascii?Q?Qm0W6/eyRer/sVkpQ48xzN7J7mOiENWSS/safd50InPydHIR25Rnq8N4zqlL?=
 =?us-ascii?Q?9w68ii4Kdk9EvA7g2XgBr2JfL7yEQP3N42tDcI3EUcHW+wQr6+w0C1h2vZWb?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ql7FI7Gu+mbk3Q9tBS7QeyF71ywcwIze9LR2RBOgIvs0e/j5AZ6thcaxtGcl?=
 =?us-ascii?Q?5j4KW+jz/2H2yAR/DshTaojmZdORqjtI5YvDrnDOmKrzLvYWdPM90VI7mQxz?=
 =?us-ascii?Q?9Jk4YcWsy0sIljBMoyVJF7xJqtGTMCX1w+pgBWz4ykRM5duBHVIgcxh38ALN?=
 =?us-ascii?Q?aH24SiQuLiUQ6QLP9L5+aE4acdLHrelYs4GhSZ34//UybOmt6OKuG4hYRxsK?=
 =?us-ascii?Q?Ls959sWK8Rv8OprDFgqxyQ8Ma2Vov4vFsI/qfTfjNSdcrhjW478ilHZRTMR9?=
 =?us-ascii?Q?W6fJkDQm7uWVdGX7j6yXO5NOyEXV5lwyHC+0M9sXt/evfzMY534ec1VTa+ru?=
 =?us-ascii?Q?Q3xjaJmDEsfdvkgfbLLd+0b0bOVKTuSeV0IXRC3lCD0FTp1Va64jYgYaBg5b?=
 =?us-ascii?Q?C3R73yFnhDSjP3K6oFTtj8zgDQ987Q7RcXojMr1VkEcx2+vRYLRaI1r75Ftb?=
 =?us-ascii?Q?iGAj2FG+Pml6H7MErRtvXonyf7HRhlI3+ipBZKOMFt+ZoKn1VaEOuy/HnRV/?=
 =?us-ascii?Q?lnVTI21Bm/U1lVPLaSbzguNsjS72uEi0GwnzYBecHeOT4cxwWCTcTLc9wTq4?=
 =?us-ascii?Q?i9FImaEsNvwLjjA6pxgQVVHPkahIMP5+YyXqURcQFyMr1XPS19DhET6Q1fsU?=
 =?us-ascii?Q?KNNG3A9LAiprDwF8GosOv3UJ7FEyOHfc5F952Y4p3ztRoCQ4GsPlOnMMnCG0?=
 =?us-ascii?Q?nTU8+w+oLdkEKWpRccLdEBVyV5L9Lv1TE2I3ybACzG06dpjDwYaTds1AiEmS?=
 =?us-ascii?Q?9hJVRfjtv7usnWD0kcZ7kL1clb6DtV+Y2d8CGq3NkQhGVKY8v2Xw7/t5G5nl?=
 =?us-ascii?Q?Mvx1J2aaCJ//h1pp/8qyz9u1eEX8IKj0BKOqpFRQdBQMwsQH6VbqzvGaJtHN?=
 =?us-ascii?Q?uZnc/CEH4NsI52kKm6yi0Y5MQV3weDCJttyqlSTPraMO88GkfuNS4WdvH9xb?=
 =?us-ascii?Q?38Pru5CaA7upLbiONtZu3Mh2v6AE0+QZgvdARxGDZZXZDRDQe3EDT1mZa9Un?=
 =?us-ascii?Q?RaqOO3UvIAmr6OSrhZ7Lp6TDW169wpdUaS3FFMjP0ewI3So=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cee94e-9fa3-4de6-2709-08db0574c1c2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:22.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43zstFgS75PyIT6ypGvOyGZ4g84uddxr8GldfrbRkLl0xEU48n38ZvBlyx2AoHJv/QqFyB3gGe1twBJ81i7lbCOF5jiJPa9IWQWcBjO3gBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=797 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020207
X-Proofpoint-GUID: CufellArNNF9kTfh6LlNPXgt_F5t2lsq
X-Proofpoint-ORIG-GUID: CufellArNNF9kTfh6LlNPXgt_F5t2lsq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a couple new options to kernel_clone_args for the vhost
layer which is going to work like PF_IO_WORKER but will differ enough that
we will need to add several fields to kernel_clone_args. This patch moves
us to a flags based approach for these types of users.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..a759ce5aa603 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define USER_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	int kthread;
 	int idle;
 	int (*fn)(void *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..b030aefba26c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2100,7 +2100,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->io_thread) {
+	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2623,7 +2623,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
-		.io_thread	= 1,
+		.worker_flags	= USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

