Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E4645040
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLGATU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLGATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:19:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC843ADA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:19:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LKdEP002944;
        Wed, 7 Dec 2022 00:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ssCNAH1ZLojGkkRZ7RCyS/d9638FfKmkmfeYoIqZo4g=;
 b=AlBw+SreEpu1p3FoywVivGYMfFSLnuHpO+kFVcRCm/oOJ6AJOoL0qBLK/GoLHHFAXOpn
 /ZdfiDEnkFVEydmYJgNnxnEBpXBjhQo2f/NV8rRkDQ+hYz/Wxkjq9xWkUde+rYScpmCw
 5QcEt/EvgB8VBaslE1YEDnMRJAOLpBON1CC130yv7McrAcSmeOX6zGXLIUIeiNtaabRa
 rMaqZlayihVHfU6SSzChkEJpBRORUr5U4LOKGP3E0eVrZxQ9YUc7L0qfpPxjpXURIUXF
 kg6JEo9SXpyISWAcfcOI/bEj1FBLStGcPcnqEWqDyqwakjt4w3WFsO1TiVIjai15Lj+m Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjhkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:18:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6NXn9i032335;
        Wed, 7 Dec 2022 00:18:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7vfndj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKNw8Dsy2V30sdOwCeYMJDwLJPI9OPnumJ/g2Hpym/WsQXO1ZEzmahREg3TmYD5kgeiaPzk9zE38MImqAd+KdjPsJcNSlfe4p36aJoc4+eVFma2iBCXXtTfQwe9gf/yJNXkqlzmoQsI3cUXtGGETk4j0URkvUBenOaL2eIK4/am3ceLTSJYZuhe5JS5aZ+7hDVdGGSHAsLrBsAA4sdXTHFftTm7HTqC9ahaOgO9WXyAbMFLrBY92xuWHw1Qk1l9SMsqzY3EFBG7RCTv4m43ElLmTGBtKCQ/3dU1n4e7aITM9GCAovPrIviHNmU0ZeGeHu4p3eH7DZ6gAEjRpVcFw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssCNAH1ZLojGkkRZ7RCyS/d9638FfKmkmfeYoIqZo4g=;
 b=MWDrYCdXyAnEjLg0pBPwYc0mWjWtt4zGJjeJC8CWzGqiy7BtOrb9z/JVdaQ4c37bcn5foeywbRpNhzb1aVJU3CoVjSoiN9PFa0xjzGPdAvzoMat1xoKdoOt2sB3YcUX2KyI4AplUPOzfaU84ALbHX71i3dQbW80WVrxjju8MMqVhPfJ5ueoLRSV83oBWuwBuQk1xnZb5wlzVb5YVQeD2C301fkpCvbOIbsF0OpNQKm3d9ymUq2RundaVcj9VNvYc26PKAuj3a2ZJOQhE/jjCp2tCoyH956WaWc6LGGclWZQJ1IhpP4KrQQNAi7FDeAo7e+yJ3MdOFoM3htZf8tHdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssCNAH1ZLojGkkRZ7RCyS/d9638FfKmkmfeYoIqZo4g=;
 b=w569//olqdg85Zt7jjNApiYoTMu5r5P273dQBFVtAqxOAVBg1eeyBegj9ZmePbBgPhWV6qH+xCSYg3ixDX+pal8FocfzikIu4mRfVi953RCfmrXNZQpJv9wTtPuAoNMS06EM0ENkcbmpmuV+xt9oDHK96G9CcPC/ifsU6nkJLBM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 00:18:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 00:18:43 +0000
Date:   Tue, 6 Dec 2022 16:18:40 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Message-ID: <Y4/b4DNO6dWDMXZ/@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6980aa3b-33d8-451e-fe49-08dad7e89989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D46TSQZLoIhweN/OxQmHzKwADmWn2fYLI0gAZMV7A4zacA4gKmBA+QtsjPEa0MXtM9qKZ9hO/7EFrAfZazYmfldIxqrPFbNV0eMVswZPbkMRGO4dKjgPFomb6I6gljH0K87FzwLsrkbtiT30IqjO3JC1Mq/z9SGR3NtTdQWpqj8iZOoPNZYVieR0CVV5lpG/a3Vil9Ne7NdxX8d5z+JlZeC8fDO0XfhE+xKQiTHGhJbQRGaro0p45uF2pekVBoFoI4F7pLtW6rh9XrZrKXDEOy1561KLyL4sJ7HFmn7OABGHYavymwDmS2D4LhyalxdZgkg45h+lCjPjNuGbmnyLt1SI9GjOfzB0l3Lj+UDwaVMV2gT4Oq1sOxkmuKYmtTZSoThh2VKb67ma6s+1M2AOUbmXXeYp8Qn4C4hiA99ocHxOYNDWpK4vMkFlumTHxLvW7oY83u6Samuv52/EkXQ7tTdo2l/iNHecsUATL+HTexKeWxfX5xD8Cki1JnkRm/dNqzHHMX+cj4G8lO1jmJ8GwjAeZpzKwbV1s9ib+w474A27EULWMkrSEgpGiAtWZUtKqm9z0brCxMu1BDC+UIXxkbZ52ZHLQzltZu9FEpL2gli5FPPdIcHkuADhd76wZKoi0e8Cc+91vOr+LxR/V+GLJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(83380400001)(9686003)(186003)(33716001)(6512007)(6862004)(8936002)(26005)(38100700002)(7416002)(41300700001)(5660300002)(6636002)(6506007)(4744005)(2906002)(6486002)(4326008)(53546011)(316002)(478600001)(44832011)(66946007)(86362001)(66556008)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWOxx6juRO2Nv1/kTRE8MmKzGXH1EF2FvFdQzhENrTb+lGfwxQKB6hBRKoaY?=
 =?us-ascii?Q?SDTz3RCsvWpK69XNsesVNDVCUDZ4koop0QHITt3qYYZPwCwxkZUTCla+prtB?=
 =?us-ascii?Q?rxlqUyxzcJjoyHe4Vuv9p6Vhwo+Kgj+3aTiFTdicarledudN6a7mTzW3j9CP?=
 =?us-ascii?Q?IClehfbSUxro9VcsJbgLzn95/oZLKl+wQkeOUU3DMq/0A8izOpeD8lEPObGR?=
 =?us-ascii?Q?mwXo368flNTAJOj/eMtr3GRPl/Kpu7uemruHOuoST536/W9BEnEt66SxSjSN?=
 =?us-ascii?Q?ElYVF8tk/9mbRvL8vqkZNP8r6nwHFX7KZ9LGxqu3jG/mgen6t4mF++cYUHsU?=
 =?us-ascii?Q?5SVKgQKPq9qBwjUMm+3qfa5SdKZWqUdvDXhCzSDTUCWCzKEC9Q7R3xgXlhl3?=
 =?us-ascii?Q?oUUweFDEA5lPHw/D56qSBmzH6JPprCinE31chEzHqo2ZfvtsPEl/K+SWSqTE?=
 =?us-ascii?Q?01c6lWWFjwHY0feVXpb/kU3bKGdWeZPj1MbrPV4z8y/gHwenF7ssDWYtRvYv?=
 =?us-ascii?Q?WiCpZbwe9pDua9L8P2zOuKBZX0Mg2pu5TgzSb69axy6XGr1YvNr3BPCUTiGH?=
 =?us-ascii?Q?7oqNby5qsvGUvf1OTOH5wNyjf1UnanXPYl/6XBLD2TEK0DjBO4Yib85RUf2i?=
 =?us-ascii?Q?TEyrPppN7cZcDxKabKrvsspmGWcNBJCIzXCYP6bPK67dj/aNhF72cVxvKoeV?=
 =?us-ascii?Q?kp8m1Gl75sjJpWB3KVIU6+87ZRTaDZsX2SXd7o2a4CJDlP4kn0EyvWgJYL04?=
 =?us-ascii?Q?yoiGHVSTGuRiOYSULo9MHau7EYlxa9ttrxCquH0OvwQvT+Hob8rI4KAloOXV?=
 =?us-ascii?Q?hCbgNUh7TeXs3XEuEujSllQu7ixeNYm2zNaKmagDnclEjSu8HfmFH71p8Hgq?=
 =?us-ascii?Q?XTTMEuapjINpipAnCPVk+Fw7vICv/n9YM1CH73ufWS0VVWnhvtU+/IxlTfs7?=
 =?us-ascii?Q?5tRiWuf4ATFCo+4tTHxeSaHGYb7VoNQiPRZvPGCFWELSL/swBt6Vu9QspY4V?=
 =?us-ascii?Q?badrfoCbCFAdq5HIz+USv5xXDCWhdWdk4z8CSMy2ougu1CUF8dq8JwtGYKz6?=
 =?us-ascii?Q?t8WOd6C1OYxDLWOAetZhicxf7nDoCOP/5f0KwGIWN1xFKAj9u5/2vPoT4OFe?=
 =?us-ascii?Q?5u0z+zbsfGEhelS1KSvVrepaBhAMJOl3pECJJb7oq8EjOnactTgfRO/ucv+m?=
 =?us-ascii?Q?7IJkySjRnuYGorSVOncP9U+C8gEd0lJzbytXEK8P5lvPJe2I02nL1aK03DjM?=
 =?us-ascii?Q?RyZ/mMxDqyGHnhsq2yHDjZKJTfSj7J5Yjoui08LpT7rLUDRj2Wsny3d9oBIo?=
 =?us-ascii?Q?e+diaug/SOgTPypUG9LA1xAk5W8m9MShv4MraTlIZK+YSU5jtXQ4nodW/j13?=
 =?us-ascii?Q?rXbkz77nw9QIOZ76OGb819bZjCg9g3dlEHVTyLjPsSLRpIU3mX1CWUOwMmks?=
 =?us-ascii?Q?DUD2vpYddKjC1E4nkg7719Iv2kItsTxpvK93UMGtEHlJ1vtp6wz166O6Yu/e?=
 =?us-ascii?Q?neXtyTs6qXtBXGaQO0dHpLc/nN4hp3F4IlazR2I3vuj11jXAjUo4adu63IkC?=
 =?us-ascii?Q?WfPIfPhevTS38qeA+HPxkioO2lXwanGJcL5K0NnpAaYo8NZrVWZJS9QTY7/t?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AlZvgeMTy0UglynMXhoQtcQkvwQI5lXBmFtJ21i8a+W8vLyVU95o6uQHo9It?=
 =?us-ascii?Q?1lpfR1fmir6MdwgSAxIxnDZ2Ptib7T9rgicORpZnmfw6kHNEbtp5iXIlS07y?=
 =?us-ascii?Q?bq7b4MtEaMHNAPzGG5M2iucKzMQfqTnUfDjsrZyHlBfyXLcLjhQ+xhzYJByJ?=
 =?us-ascii?Q?2s0K5rPH3cKyWD/IZkJLLd++52nKJfSna7L+Z7Qy5K8Il5YamslztTGFgyct?=
 =?us-ascii?Q?bOhhf9gj6OjVL/6UCfvZWBty+PSC4ZGZjqo4+HHD2FoMQyLXmCG5r51vw3gM?=
 =?us-ascii?Q?jJC9g2IFj+0yPod5CItBYRGRA/UgJcB7dn5kKJHjREETJSPEEITrNSHy2gAW?=
 =?us-ascii?Q?YohTgtY87ZMf9NnftPI0bjb92Qo/o5Rhb9Sz1X+k0P4MMkHPgUBeuxTAqvMz?=
 =?us-ascii?Q?WkDxT1GIvegXEkhsSc/bBp3vmWtK1oRLh8Y19mghe7L21u8wc+CxIC7GSf83?=
 =?us-ascii?Q?Rn430ttUweHFL1oVK1KGWG6cR7I1192TvSIhwdcHmt5LVaGI0h0zE2ud5LWY?=
 =?us-ascii?Q?UlFRDNxiF/DYj7tAUFFn1M2Krg8QuJBCEZ9m2Saiho8gp0/f9ciZM6Pf2sfR?=
 =?us-ascii?Q?B/kkShL2XXjhZ0XrM5Mm8mp3Q/b+jH8b7bgH7GKLB8GY3jSz6Kb/u8EwsEg4?=
 =?us-ascii?Q?ZLSAYe06Mb7BvfMslNrRmSz4C2evVIuspLDP2MnkuYJ1BZ7R4Hm+nZGVzH6q?=
 =?us-ascii?Q?Qiznj7dvij42+6ShbsdEFyPfckpQOU8XnueT71bfE74cSbJw5OJE7k7BfhnF?=
 =?us-ascii?Q?79YRXFCKrxdMJCC3YeiJcYMev+cOc6hKmwJY+uAmm4nt4ag5xAJSwguJjNAu?=
 =?us-ascii?Q?d8r9wAJlfRFl3iEEo4XJ3z2jb52vBD2TUrhLUvkL7sm0gSLH7axgzekhuzHg?=
 =?us-ascii?Q?8Ix8licxxWXPH/LhYfY3mtsPQzmEbmfLeFMiYq2vfVEthixQF5/Ye4E6Ymg0?=
 =?us-ascii?Q?eaAD9BGLkwrHECcXQhsTu+22x8y1jUb+FUsVfGzARHUTDdzkszYSF82mk2L5?=
 =?us-ascii?Q?S9A4l73W1wO2sBSKlf5tl5XyadQejQ2/mXyA2S92PpsjSrqbFNRBZoRCxfYN?=
 =?us-ascii?Q?WhPRI/ldxDR0xvRzHsX61NzUGjR/7wQWqmmKNk+trJpsZc8wVqM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6980aa3b-33d8-451e-fe49-08dad7e89989
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:18:43.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ypIJzF7QCjLLaGyfukp1iJ2RnYn6nmjr+ADTdpvuLfonal4rX1jC2E5GZGiER+EKVIWinE3K91CJX196ojk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070001
X-Proofpoint-ORIG-GUID: bCCUH8YwyOf1ZOYQMyEqNwIADZQzs6Pp
X-Proofpoint-GUID: bCCUH8YwyOf1ZOYQMyEqNwIADZQzs6Pp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Add folio equivalents for set_compound_order() and set_compound_page_dtor().
> 
> Also remove extra new-lines introduced by mm/hugetlb: convert
> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
> hugetlb_cgroup_uncharge_page() to folios.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/mm.h | 16 ++++++++++++++++
>  mm/hugetlb.c       |  4 +---
>  2 files changed, 17 insertions(+), 3 deletions(-)

Sorry, for the delay,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
