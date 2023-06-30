Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34338744334
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjF3Uek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3Uei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:34:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8A2952;
        Fri, 30 Jun 2023 13:34:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIxIc0007380;
        Fri, 30 Jun 2023 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=WaeXEi+jszNL6GF9HzRLwwCzUhqXR31gZbRAaGNM6kM=;
 b=E8WOKlrQAPvHfGCNjvVHti9nqEKFZl+8iOrm6cTm7cs9NAb+Gm7l/cfc7SS3fw3cmOix
 QJt34cYwh1xJ92BcUvC51i25PiYdsYzYZb4xgzonEAeYMVu5wlKHeb4Hhcw320QkXE92
 gzzLD2u+zpbVxpaG59UYONJPOm2Hzf+A4OCokcyhgNno2Kb+XodqnIUZnEkzdjBgxQeE
 aAgr5AVSAUCN+YwKKLZ4rLSjB7dg7ADYFavmjm1nBzrhiH895XBVu54dIpxHteTXjdIV
 0vEinCBYpV+Gw3jeT10ZKwc21foEKLLAiPgcaxDvR0CZ06NR698EK+vdMePHIJJIufou lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1uj3mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:34:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UKGlsC013057;
        Fri, 30 Jun 2023 20:34:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx9kwtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZuheJlLtC1MhinPUUenSW/WVNThckcb6+mEh/GloEVUy7GoxlaKk+wLKJceMVNzba+Vz7Ej1IgAKothpx2tn7mdlLV20Iq6TCR3wPQmV+zNZdOVM85ni7sFrnBBKdoOa7/XEHVMVJEJobnpRHcgJl9hyxuUhn2gdZE9cGvl8ZEYA2eNXgd0+rerTFQLKQpB/vGTABiy5/mlaSd05m6QI3sQK6yGHtrnYOSQOjuHiLDzLnjj12BM2refnufG0hWv94/UTJUKIl5mrHzR3X6ocPXhXj5SzZMg+3+n4J//qCaqzBNigX+w/Gmp6llPoFnzm5LPYZomQe9daPgwFDjqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaeXEi+jszNL6GF9HzRLwwCzUhqXR31gZbRAaGNM6kM=;
 b=a2qzv61zRVugA2Z30+iAb/T80O1Zn2vaaQ81goXXBgpe5J6c/vuAKwPX2MClFpJOpIUotvAgiqxNXZ/EyLhE3c1lB7HnfkoN6tEK/bq47MYGJtERGZDUORMvXre+dIIPSdioYXfpj0+//SCt/hJEpNZkZF9G73L9uDcCrJ0JK4NrIdMARVQKmbzcmCIdo+iEkErDiUk0MrBHrdYtUBH6vsw4cmEVDVxnyf+ktjl4AHDhx4T1i3gYEi5qad+ckiCphKgyIpd/rpAzTKeaUtND1yKTjJM96JDUL7R0U1Zg8GV4mNJ5QX/2aiahmZaa8eXd306ZzVGyZ3j/LVrKMPs3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaeXEi+jszNL6GF9HzRLwwCzUhqXR31gZbRAaGNM6kM=;
 b=ar0w1lXyOFTfdNRfkNv0iwQmCpi5sS1a5mYtdIwQ5E8meWIVrfvXMUmWxNqqJiOlDulgXbH8kDiI4yizlX5DzK7nS4CTEc8WJup8RIEs3d9gCm/rWx1WDgYUeyUsq0iiXHN154q7ZdRHYm8z5fhfMj6kP8WXflhDfYMnqIbjdBk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 20:34:03 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 20:34:03 +0000
Date:   Fri, 30 Jun 2023 16:34:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6 4/6] connector/cn_proc: Performance improvements
Message-ID: <20230630203400.k4yuaecr2p5upn5k@revolver>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-5-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614234129.3264175-5-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|IA1PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 12778aaf-1058-4c75-d0cd-08db79a957d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCGJVEErcFyh6nhm3iyBq7KjJ0+xR/ApGeATiXTI0I9CHXe1tkTKBvYmMc/IbzMeRzO6PA96hhh21JX8RLpOzZJBKxmLrX/RdO6fOXD70mN9/PCHYFFFE0+dFxFeK2FCIxSG4J5+Kv7FWudeNwLl9YT7UhwL/vH9jjbBTa7ZA4iKkydTKnug9R6BcCr8PqdywBTbEnzzz2Kf6cqwnBegC0Zgmf32OCdl2IzwrY802t8yHCqN9T9OdH+c2mZWeUQX/nimqzUoM/br9lPHyEHRVgwI0rTNtbMKtqpiQdUBzd6FrJPTGOADFnHyF8M0rrG9dZEXZCd4mWLV9TwnvYK4kg1X8N4K/Bv7r5pdS7V/iM0V/PEN6FWiLI3RgdU1XlTMQQ0hL2uhG9DovHDsQldTrLrKw2UrkeCE8Hct/BxhxJMZZg19faiItf/fFAr640HJrG3vr8UzsfPZiXkKt4xKy1pU0nUEgkK2dikA0EVnSLavORZbkfi9Wnx0co+CqxXRAVNDfuoOxkQeyqGgPZT2SkqwWhaJR5EKduOLiDw7Yy76eeXE9kCOLdf4+JfiUU1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(478600001)(38100700002)(6506007)(2906002)(26005)(186003)(6512007)(9686003)(66476007)(1076003)(33716001)(6636002)(316002)(8936002)(6862004)(66946007)(8676002)(41300700001)(7416002)(5660300002)(4326008)(66556008)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQvfVcQFzN2cWeRmWyX5QK9WF23t628nrUJkfLL+tvX1p94hs/6VJPcr6Plc?=
 =?us-ascii?Q?MH5lMBMRg+cUqnxy9mI3kvMM6stMeMgR4cerdORMZbrVr0DZ22G+SV4Ss/HF?=
 =?us-ascii?Q?e7S2JgSOKYfEP7otjkT7kzjnifcMqnw944NeGqsRiY80XX861XNIXmg2O82B?=
 =?us-ascii?Q?gVNgL04gx8JlkiSM17CdjkC6QP35z1O+lTlYv1qERx+1f+aO6AxylZ+RZ2bX?=
 =?us-ascii?Q?QgqIIBo72vX5vM/vMS8nsi8oi0vk04+Jl6XCUTjBerx6RIs5tEOZkv8xcwRX?=
 =?us-ascii?Q?o/l1hA5WejAAbgDQvLp+8CbZSYCr4Ap/4y2qSFI29iJU2WHRkPR1MRQAOTOv?=
 =?us-ascii?Q?G8eenNGgT49NeASukVleUmH3zh2QMvzIzCwJeKAUq2nJSNeEamhMUMUwgegB?=
 =?us-ascii?Q?CotF/uXj3hKasypt2GUKpqRiqCJeDrEHMjN5S1zrPIToDMqY09sW35xGkyWr?=
 =?us-ascii?Q?N+2VenQw5v7UtuZfbX8Uw6jG6vivAvdnVTeJkHHOno1/L9Wm6jLnbYUNOg+8?=
 =?us-ascii?Q?IL9C6WSl3eI8ea0fLyOJ/NeLNO3Yz+hf+dP6W5zVYtCgWYvE3grGUtDGY05Y?=
 =?us-ascii?Q?8gT+VIEzj9BsffQn8fnpbgepFWQdEQDQqIp5u5pmzomyuLaJSrJl9xqvkdRu?=
 =?us-ascii?Q?qSjJjmq476KY1qNxgIxhgWKeGrFmNKBHOClb5Y+UsrLyScLEEv4ov+OkVnnf?=
 =?us-ascii?Q?pJScxn1nuh2cgcqYGIJRlRjeY/SmwH6QEwbJTzwwJAD7KapYN4hjBzk7KdaI?=
 =?us-ascii?Q?9GQF0jC5yi16szDXBqpV+ij+XdeLs0k7OZa4LTlRJKt1mjTP2LRMA+gugmEL?=
 =?us-ascii?Q?gMUBBcJz6qG2zmWs7BGK1yudslogw4OzA7uq6qfJ2jbhTAYIDtT2yGpTcaX/?=
 =?us-ascii?Q?GKbd0AiJVds433X4xbE74JaI6DMPAKcZijFXHgF1fQBQnvMqrMX+yvvWBLgY?=
 =?us-ascii?Q?CyUVGet8XMx/XLNZH5zNOFz6aUiPfMap8QzvSUI43yHBTAInMm5z6vSAZ6/h?=
 =?us-ascii?Q?hiBdKTN8ZYeKAN8wTc6dXIqhF4r++VFXGKEN6ub7rbvXUZX0isdCf1KGmJUE?=
 =?us-ascii?Q?IoaOPQah0/rSab3hysPgdsKJl3hpXQHeY/gizsZeJh9OF730rWZpZEz/14uf?=
 =?us-ascii?Q?+aS4mtSR6oj6B7pTu5FKW09NN7bYSfRagW1mZkIeRg0DE+8PMFnkxST2pxQi?=
 =?us-ascii?Q?FUOVLCPI7LB0WoZ7CPp+vrkBPB+n6Bo9DUfnaZ+IYliAbRtu0SMcJIDkrFxw?=
 =?us-ascii?Q?cJwFkT6pCHHZHH++K52XtYeSXU/nt8BNFur5pKEKYG4tkBkv6/i8Qe9/+1Wo?=
 =?us-ascii?Q?XrdJdLlBXJnYBgNcgosghIQXE4gebhGnsKdV8NYYmdDjgvtj+8SAFe5PfMTB?=
 =?us-ascii?Q?DGCLQ0YWO5U7NX3xTQWoyV7HtrsMCbfkw94gwLbWaEkSX21oLb8b2yqNsbnQ?=
 =?us-ascii?Q?54STA6UCIHnH1daGfrVsqwYje/GHgj/jGMM/nf04Dsf3y9R+cVJrpqf9W+7s?=
 =?us-ascii?Q?J7z+9IIhy1lFPSSEAyuBM+AWb3UqPCyEvOlaxQS73xs0fi0SwHJykfsZ5pIV?=
 =?us-ascii?Q?wy2R33qNw6S6MpfOr/FwzP9MOGBKuKmUIHhDPyuVfXRKAHPsaJSe+hkV7AQD?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OYGNnFyiS1AfVfh0ghnMdxTjo6fQWl4ptQ8qIptOnw5+z3wWBW72wTfevogS?=
 =?us-ascii?Q?5fCXthPCSgxreLuHMpkfOv2siBiQBegWff/t6qJMU5CIk25vgaffA8oDmQp0?=
 =?us-ascii?Q?rvybHhrxIUcm/KgaPvDhCo7SI7ego+3jp3NyYIia7G3Bc0P3Cep8dZgSoVD9?=
 =?us-ascii?Q?84PD5lDM6ZIkpQOAz3BaQC4UskoMSYuy0rTyrz56jC/Oo781fTga77sq77pA?=
 =?us-ascii?Q?1ID+DJEtGUWokhyQvSVlj5KoViMq80ZWe0wzQbPNYV8Otwh5nmMCmyHb1QC7?=
 =?us-ascii?Q?xL+7nDin2v1fNCRklzYlVi9mHU/13BIFYvX4G5WRASmS4ra6vUIYd43WFmxL?=
 =?us-ascii?Q?eUxKLuy5A2jy5O1UWx+LjRzuCiDtyuN+NiZgijKtR9aQ+PugRls8yP7oPE6G?=
 =?us-ascii?Q?KBIMv52dtaJiIcJFLuWNGYQMCwTReqhaV6Ds+rWn5JkRf3Oe1vpGBvus9BoR?=
 =?us-ascii?Q?hFV5vYSvzbqRHbyg509KuBaOZow7u/GxwbEz6ySQMP3vlaNpU4PLJFifbbUc?=
 =?us-ascii?Q?69MONrtZq6UbDuc8QSbB6MZ3HDUxFNqEKsN/zKMG50Dv5gSr1BUlv8GMBGLA?=
 =?us-ascii?Q?WGCszYp/WjrVePYno02LX4o+Kt3kXRss0fAPw/Dkh9eIPQU/F2/+TBig+P7f?=
 =?us-ascii?Q?nzMa7SrD+Qdr6uGT8D54RZWbnJKzExSV3101frITLfhYOMcPDxaEMQMF8zFP?=
 =?us-ascii?Q?JE+p5lJ6VmGFKEJI2bBo8uBXBqcX8w9q1cbAMIfbyFRjIlaKDuhCnwh9Vx33?=
 =?us-ascii?Q?xqXeNlVzkguE2VtJEXwulcWemb/M3BhgwC2TV6sJA8rIkTeYUo9jLV43lOam?=
 =?us-ascii?Q?jIrV8nxMQLc/CW1hU1rlas9JX1ltCKrJKkDkH33xb2gpu1yszU/vstaNn5Ph?=
 =?us-ascii?Q?JU3nf4C8B0SDvA7jI/TBl/AVl3PVMTVRn7SYgbrPtxafKgEVMZZJdtUYuUj2?=
 =?us-ascii?Q?1ViQHE8PYAMBtA09WdZFceSyiokBs5EgmUv+nHzyeH0Qe0O2qOq+NSp2ytT8?=
 =?us-ascii?Q?g17ZQ7F7kedzpJcWiOa+ajbOEyYFrZWz5owfxL53xmjiXnYLmbMtVrRxkOlJ?=
 =?us-ascii?Q?pMvVJwttzRZt64j0h79NmzDPJlKfVapA4iBWrSRwP63QZLDnm8dJc/uEkNFN?=
 =?us-ascii?Q?VTOZ/R9PQK7gG/3HZMF/4/+HOCo4ayQ/uFKxOdpctVkuJJyTspwioMQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12778aaf-1058-4c75-d0cd-08db79a957d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 20:34:03.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcGpXmArWaOomzJrKK0diFIe7Dx/XSHyZykaqwdIV06X8K4NBl4gtAkeE0+HcBC3hEZEdunMMXmdb7TySe7zGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300180
X-Proofpoint-GUID: R0A6u3mmUn7O7invq5eBrMEjw6jbrpDk
X-Proofpoint-ORIG-GUID: R0A6u3mmUn7O7invq5eBrMEjw6jbrpDk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
> This patch adds the capability to filter messages sent by the proc
> connector on the event type supplied in the message from the client
> to the connector. The client can register to listen for an event type
> given in struct proc_input.
> 
> This event based filteting will greatly enhance performance - handling
> 8K exits takes about 70ms, whereas 8K-forks + 8K-exits takes about 150ms
> & handling 8K-forks + 8K-exits + 8K-execs takes 200ms. There are currently
> 9 different types of events, and we need to listen to all of them. Also,
> measuring the time using pidfds for monitoring 8K process exits took
> much longer - 200ms, as compared to 70ms using only exit notifications of
> proc connector.
> 
> We also add a new event type - PROC_EVENT_NONZERO_EXIT, which is
> only sent by kernel to a listening application when any process exiting,
> has a non-zero exit status. This will help the clients like Oracle DB,
> where a monitoring process wants notfications for non-zero process exits
> so it can cleanup after them.
> 
> This kind of a new event could also be useful to other applications like
> Google's lmkd daemon, which needs a killed process's exit notification.
> 
> The patch takes care that existing clients using old mechanism of not
> sending the event type work without any changes.
> 
> cn_filter function checks to see if the event type being notified via
> proc connector matches the event type requested by client, before
> sending(matches) or dropping(does not match) a packet.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_proc.c  | 64 ++++++++++++++++++++++++++++++++----
>  include/uapi/linux/cn_proc.h | 19 +++++++++++
>  2 files changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 84f38d2bd4b9..825d5f506919 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -50,21 +50,47 @@ static DEFINE_PER_CPU(struct local_event, local_event) = {
>  
>  static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  {
> +	uintptr_t val;
> +	__u32 what, exit_code, *ptr;
>  	enum proc_cn_mcast_op mc_op;

I guess reverse xmas tree would be requested here as well?

>  
> -	if (!dsk)
> +	if (!dsk || !data)
>  		return 0;
>  
> +	ptr = (__u32 *)data;
> +	what = *ptr++;
> +	exit_code = *ptr;
> +	val = ((struct proc_input *)(dsk->sk_user_data))->event_type;
>  	mc_op = ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
>  
>  	if (mc_op == PROC_CN_MCAST_IGNORE)
>  		return 1;
>  
> -	return 0;
> +	if ((__u32)val == PROC_EVENT_ALL)
> +		return 0;
> +
> +	/*
> +	 * Drop packet if we have to report only non-zero exit status
> +	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
> +	 */
> +	if (((__u32)val & PROC_EVENT_NONZERO_EXIT) &&
> +	    (what == PROC_EVENT_EXIT)) {
> +		if (exit_code)
> +			return 0;
> +		else

Nit: don't really need the else here.

> +			return 1;
> +	}
> +
> +	if ((__u32)val & what)
> +		return 0;
> +
> +	return 1;
>  }
>  
>  static inline void send_msg(struct cn_msg *msg)
>  {
> +	__u32 filter_data[2];
> +
>  	local_lock(&local_event.lock);
>  
>  	msg->seq = __this_cpu_inc_return(local_event.count) - 1;
> @@ -76,8 +102,16 @@ static inline void send_msg(struct cn_msg *msg)
>  	 *
>  	 * If cn_netlink_send() fails, the data is not sent.
>  	 */
> +	filter_data[0] = ((struct proc_event *)msg->data)->what;
> +	if (filter_data[0] == PROC_EVENT_EXIT) {
> +		filter_data[1] =
> +		((struct proc_event *)msg->data)->event_data.exit.exit_code;
> +	} else {
> +		filter_data[1] = 0;
> +	}
> +
>  	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> -			     cn_filter, NULL);
> +			     cn_filter, (void *)filter_data);
>  
>  	local_unlock(&local_event.lock);
>  }
> @@ -357,12 +391,15 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
>  
>  /**
>   * cn_proc_mcast_ctl
> - * @data: message sent from userspace via the connector
> + * @msg: message sent from userspace via the connector
> + * @nsp: NETLINK_CB of the client's socket buffer
>   */
>  static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			      struct netlink_skb_parms *nsp)
>  {
>  	enum proc_cn_mcast_op mc_op = 0, prev_mc_op = 0;
> +	struct proc_input *pinput = NULL;
> +	enum proc_cn_event ev_type = 0;
>  	int err = 0, initial = 0;
>  	struct sock *sk = NULL;
>  
> @@ -381,10 +418,21 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		goto out;
>  	}
>  
> -	if (msg->len == sizeof(mc_op))
> +	if (msg->len == sizeof(*pinput)) {
> +		pinput = (struct proc_input *)msg->data;
> +		mc_op = pinput->mcast_op;
> +		ev_type = pinput->event_type;
> +	} else if (msg->len == sizeof(mc_op)) {
>  		mc_op = *((enum proc_cn_mcast_op *)msg->data);
> -	else
> +		ev_type = PROC_EVENT_ALL;
> +	} else {
>  		return;
> +	}
> +
> +	ev_type = valid_event((enum proc_cn_event)ev_type);
> +
> +	if (ev_type == PROC_EVENT_NONE)
> +		ev_type = PROC_EVENT_ALL;
>  
>  	if (nsp->sk) {
>  		sk = nsp->sk;
> @@ -396,6 +444,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			prev_mc_op =
>  			((struct proc_input *)(sk->sk_user_data))->mcast_op;
>  		}
> +		((struct proc_input *)(sk->sk_user_data))->event_type =
> +			ev_type;
>  		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
>  	}
>  
> @@ -407,6 +457,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	case PROC_CN_MCAST_IGNORE:
>  		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
>  			atomic_dec(&proc_event_num_listeners);
> +		((struct proc_input *)(sk->sk_user_data))->event_type =
> +			PROC_EVENT_NONE;
>  		break;
>  	default:
>  		err = EINVAL;
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index 6a06fb424313..f2afb7cc4926 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -30,6 +30,15 @@ enum proc_cn_mcast_op {
>  	PROC_CN_MCAST_IGNORE = 2
>  };
>  
> +#define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
> +			PROC_EVENT_GID | PROC_EVENT_SID | PROC_EVENT_PTRACE | \
> +			PROC_EVENT_COMM | PROC_EVENT_NONZERO_EXIT |           \
> +			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT)
> +
> +/*
> + * If you add an entry in proc_cn_event, make sure you add it in
> + * PROC_EVENT_ALL above as well.
> + */
>  enum proc_cn_event {
>  	/* Use successive bits so the enums can be used to record
>  	 * sets of events as well
> @@ -45,15 +54,25 @@ enum proc_cn_event {
>  	/* "next" should be 0x00000400 */
>  	/* "last" is the last process event: exit,
>  	 * while "next to last" is coredumping event
> +	 * before that is report only if process dies
> +	 * with non-zero exit status
>  	 */
> +	PROC_EVENT_NONZERO_EXIT = 0x20000000,
>  	PROC_EVENT_COREDUMP = 0x40000000,
>  	PROC_EVENT_EXIT = 0x80000000
>  };
>  
>  struct proc_input {
>  	enum proc_cn_mcast_op mcast_op;
> +	enum proc_cn_event event_type;
>  };
>  
> +static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
> +{
> +	ev_type &= PROC_EVENT_ALL;
> +	return ev_type;
> +}
> +
>  /*
>   * From the user's point of view, the process
>   * ID is the thread group ID and thread ID is the internal
> -- 
> 2.41.0
> 
