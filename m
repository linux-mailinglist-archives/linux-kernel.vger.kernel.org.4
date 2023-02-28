Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96B6A6238
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB1WPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1WPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:15:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AB2CC4A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:15:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SGwsC7001406;
        Tue, 28 Feb 2023 22:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nSqrHZXN1CjQUuokCdNRMtn2Ty5xf8hUgO/R89VTRLg=;
 b=z4f1ajG1t1l90unfHVwv5LjfC8DokuyppEq5wPkIWgEroPrt31OOCwnWmKfab+gZ/3K7
 68ugezkU0lswUMGYqxsUwpVcsgEQ2ryZ/lys/19rmG8wNA0/K0oSatGd969cnhRscaue
 BDQluvvHUH9fx2yyxJcluP0R48zjURVPmGFvO+Yk+pE/B3LcsswwkyqpK5kiwZQ2XBKm
 oiluH61OYvDqqxJ4IMQ03Z5EYL282tuqK8uHWisx/C5SG5oiDxH0I5F59BI+m5H4vJmU
 9TLnO0rk5W4hzH7wg698fcNVEnsQ6zStrLGXvjtesSe/Ck2aBvSaafnxGRdS1/+aaC7n tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72fgvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 22:14:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SLPSUC013062;
        Tue, 28 Feb 2023 22:14:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7g1nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 22:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhb/hfnbpbc+8GXjNMek74ewdKaW3RvmB/1V+CPhA9Y6Ocg8uslGD439R+vuzh1r5bZdElvkAYNnRcriuQ3mKFrj7URItpqNDKTpAc6cOfxcw5adXq5fvolU9Zo6qOcvCkfHN/8OEsObeVupOTKnPMFpzUjOAhqKan9mDIy9p495QfujkzSbVutVNhanQFSZ4ccBAzui1a6cy2PX9Y+qICRkr/htbokfdi90a4mgjU7CtB+cmbGud4GcXLR6UHYcnKc7eQYlH/7iYtDpGMNjo9pXEux/PiLWyYEddQZr4vjGMx6Flo1sydgFA82u9eIxRnyYEfLCqeOwxE93U037Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSqrHZXN1CjQUuokCdNRMtn2Ty5xf8hUgO/R89VTRLg=;
 b=UrGLwJ01b9AeaW0ArFrcA6+imOd8TlsttAU9qwWHZXVPrM7SsXoa/wZFOabFkbKhykxVZVG4756P+dnxHUsuD/SJB3FiN8pKngHnAH+0RciynzTrRJBYhPmFhyHyzblR8Q1vTnIA+HyW4jEefcvMfHSVs8xGxIF9JEi90MRKwZOjX1VUDGpyctom69KdtrPsacxnAsfNcHeYHulTJd7YgywkbbR2jASyl5DiljQgM8YaxLG1MbkHri7SNhQZ/+Fd8izIZIIe35EUTt0xhrDZQ86ulVvqkJSVxIzPiRMsytkAjv5JwWlIc7/mtBHJI12BAh6pL3+hLrhisdmQs3o1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSqrHZXN1CjQUuokCdNRMtn2Ty5xf8hUgO/R89VTRLg=;
 b=kfdmRJdsGpafLKHDTIVWwOkRR2t9/nvu4W8z7/1HZwrs1kYXMd3C6h953YBNZqXy6JCKiJCEgljaH0fIFv7ajEENL+Rg8Tk4GkDThbdm5fOCv8ih098Lv3jV92oPc8XDfKCzNwOtbH1eAiso4EiCvBiDoDnsSHMr4v/kYWxw7eM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 22:14:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.016; Tue, 28 Feb 2023
 22:14:40 +0000
Date:   Tue, 28 Feb 2023 14:14:36 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
Message-ID: <Y/58zLSFe/ygT9X/@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-14-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-14-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af87b9-ef0d-4f85-8818-08db19d92f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEI+MGJ9nUXxBHspQ1c1n9VJrk37eNrQEP6hDHIhH2mJLDIbq2F2i2z2QfCNE1Ag5w1aADoOPZUUdObKfG4qLPCZsRyLzbwpBKIL31OLW0jOjvHNzf23Rj+RG2jGvR5NYhgXlKAZYCKZM8bIy9EKVwxCBfg1GyLCCxN38FokTZ2VEt81jjzFLhVUdUORN8expMJuFKJadm3Bh8PP3NlI9wcwmqgLVzE4f9GKSrbUds2eLo/SE2Vsd/mLe5WRnGbQXa65+D8bdwULHt8hoTLcob7zC2o/Js8H9a6zKGDuY8HgtqnGhUNDhq/0ytHMmuiSmsqsY4nOjjd0QHGqCr5ehwds8tbNshG2xZMRamPteTQbP7HAkI24KEkodKk3PF5zws5QRY2gbDcfVhSpTcGi6TMsBghaz99UP7yJm+KiBjHTLoQw5JHj2N8Hk6u3hgGYJff75mcQNVY0X5e6pvGGa/QhSL+GxLvJbnhWLZ45wy4JK87tKKXVKXZTdnlSFwgxymq9D85C8W+uAsSh1iZXhT5THnyP/r9h4tFr6LBJ+mOIiE/SEdkyD/55crNRI2AsMfIYnq7TnPPLIhvlOh8FNUHshIKv/s0l9cJXJW791L8Hy8+GjhNNC3Y1HsxFEj6bjZe6insC+JktY/0zKOqlMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(33716001)(30864003)(44832011)(5660300002)(41300700001)(38100700002)(8676002)(83380400001)(66899018)(4326008)(6916009)(7416002)(8936002)(66476007)(66556008)(66946007)(2906002)(6486002)(86362001)(478600001)(316002)(54906003)(186003)(53546011)(26005)(9686003)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7ORd/nMyWMTQGfm06SBX9Hcqn58YPSevfy6wfJByA48FV3Sq4wj3UeyuuMS?=
 =?us-ascii?Q?CoZmtN8Njs96XgFYym3+d0f2Wqyj1i3Q6dZtPaVyCJMLJjsphOZP7g5C8+yH?=
 =?us-ascii?Q?7jtaVhp9yFEDLqwLVT/IX4N+5vRHjZNzwrW/z6T+leUPVM8R9+EipZ5YGJpz?=
 =?us-ascii?Q?m9yIxFz8qbKh0R4ttrhPTHW59LdJSsfa4K01atiKAyxjdFaRUEpCbRIpsHin?=
 =?us-ascii?Q?SjJCH6ifMBgXWYGW9Uhv0E4QrS0dqkwEF9jgOyCn4qx5LGp4l6A9Zz1FcAbU?=
 =?us-ascii?Q?4F+lScyRePKlCDZqFJtflzdxJkZMQEy4U2yessXb/iLfTq28Cky66TIaEGSj?=
 =?us-ascii?Q?OvwXTvsQi5znVO0ibgixEClW/b21K+/Fy3WUS2d79h82sYSUSshhr29Q7uuH?=
 =?us-ascii?Q?CGApZuSYBDHPfqQ1CYpZLXSwlzlbEoE/5h/MmyznsURgDBokX7AvNAgk7tXC?=
 =?us-ascii?Q?DHBmWCIhX0SUNEPTo67W4m1gUKbZ8TVjiz8WPUQZVihZWq2e9Vnc2X7fQ5If?=
 =?us-ascii?Q?g6MGWLLFWuIcfYlZuvuOGxPkrPxDyOdW4xXK/aQTNlNGR0GPA6HjUJl5m6Jv?=
 =?us-ascii?Q?zQywDP7DwDLXyoePdXZ/KgcEj+WyrPuzUQL47PdaIw0Kq1JlOPwylIVNBAk4?=
 =?us-ascii?Q?aJgjVrzB/ozelrNlQ4/DJPJgHXBp5eEXoOluE4wYOHRjOz8bvAP9vOPvQyg1?=
 =?us-ascii?Q?ll/o+ZWRITBdECTZSaZeROQQ4AsmtM97FaYno5o/tkYeBj1lUCVeMs1+42/q?=
 =?us-ascii?Q?kp1YcGA8QkwS5wAVYJemgG2rW5ikVGr9WiaTHrk1GSM5w9Eq4rDEw5E9+KK5?=
 =?us-ascii?Q?rCz0AdeZoUDqGjb0yan7PqUHQzaGg5T74awuu19RrZ9pKwXyreUkckuJ5W+D?=
 =?us-ascii?Q?tUeeRg8ZGl8KlI9yJi3jkxeEEMwpCy2Ksk79A/fSAp04vMKyJr5/UsOoPHd+?=
 =?us-ascii?Q?ev0WA5w4fWx5T8F6XwUHnffgqPplO9vjJxbrZ8HGOsyU7oTrroUIg75cj1n9?=
 =?us-ascii?Q?sJSo/OTZyxcAn76kvrOcTjREdAjDi5elP+T69DN1enpSR8Gu3Mw7sToEHBme?=
 =?us-ascii?Q?ORx5nJrDagCt53XZfCpIclUisl8D/ucPagiAISc4wkYncMSv13AHF4DH+z+c?=
 =?us-ascii?Q?hbtgkac9Dvmx1gpFHOkDiwuaLGfVFjKPr5YaQ3gI082yxgBptR3V3BXhmVSR?=
 =?us-ascii?Q?iqcrL2tMHxCGzSr+3BLqqXaNBl6DPxz9fjQFC+5c5ynijTImHsaX/5Tmh+hG?=
 =?us-ascii?Q?Bd9L2OO5bYNTWyBFt2bYNnQD1wAC3OD/exaXvStYP+1hYMY0TjYZBxRXvUC/?=
 =?us-ascii?Q?aLIA86xornrlzHXiyel/4IB/H5wg8EhHH6dHj9gNPJKtJaHU0UTsadcmPK6E?=
 =?us-ascii?Q?0iG6L+81bUmjwCNsZTRcZu7lAr+xTRnIxmhMqsHdu0HgqaumFvZbO6JF8wPo?=
 =?us-ascii?Q?wcoP6Qln5IjEae9+ObfnB3ptj6XEXqMXuYJr8jO3XvaASrwJn3+ZRyAjHFvo?=
 =?us-ascii?Q?EO9ncAFbWU9ENIMSgDuZpedkogpdwFjR5jfQ3wHwdMRjHqRQQ2XmEI47X2rE?=
 =?us-ascii?Q?pfAaj/KymvbRLmsx9/NsBtY0OE10EyY323Rpj+nj4V7S7izP3F5eQqPgbh9c?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lbxN5EwGGhd9mO2TDDyToZMWpvlW6k5r78N1BHe/7fZLajFHlOtD17M3QtTB?=
 =?us-ascii?Q?gvMuaKV3FlItMQYWYgAWEAg5B9NpvnnjV7hosG7NhOHFlExNxR70e80j6GKb?=
 =?us-ascii?Q?jXNDs/PlqlpMp10T/mABLUr7D6AKEtGCfhYh9LOJRJEovoZTpWxJeGq1f3HB?=
 =?us-ascii?Q?zE5ocrs547QC/T8hKadcNmQ4sE7eBNFgGdlQmElCmrs8gd9arUOvMHSj9l2H?=
 =?us-ascii?Q?v4/iYBuVraPwKFkrNTkZ0lWS/zuVITkubg0fyUds1FG6V4/iFUSxAm+ESPi2?=
 =?us-ascii?Q?rZoWCVddOidqYlMgL4WFjC52ghCdYMq93WSPQ4d5WZtHgBrO0R6mMtodT0eg?=
 =?us-ascii?Q?Y3z69blY2EdTDnmUQCh998Ad2Wxq8C1KtetsQvZJjSMqsycHLfJ1LOs/tjbD?=
 =?us-ascii?Q?pkKVTDnVFH+l/mlAdeKhyoaO/HRLiGJC2JLMwBAPRaQzyJLNXwFZ2JoUWh3W?=
 =?us-ascii?Q?Xgwbm8lFyiiGKvHhxM8pVvwWU+jyhxpV34Drg8gaKCGIot6YTa2ScLGfjv7L?=
 =?us-ascii?Q?jgFMxXaD8MzpUVEc8Hjh/ihuyu4A300wEXy94oWq/FlORPT3xsSQ7qs7Q1db?=
 =?us-ascii?Q?dc3eyT2gLtsuvzXD6d9Smedy4l9cDXvv0j20M9ZJQLYwGijJU181bKhhIz8d?=
 =?us-ascii?Q?xc9vn8OKBbhlHzcB1GuymgyWPigRaUdvwecqXh4+a+2/TdsWQkd3itUC+LNM?=
 =?us-ascii?Q?k/B44r9LIToJ0MHxoS0TkmJMULyNRcXxVDWXnBe4ZETQaR5wMCABV5aATaM2?=
 =?us-ascii?Q?EmFlJO0IMwcdzkUl9uwFZqet5v1LM5r2pwont5kKRAftee/tZ/fyoPsBmiMX?=
 =?us-ascii?Q?ync9Q2rNKSxrZXlTs8okbfmGlEEHkIvGikutD9tWVtYNvS6xUjqH7NUfxh67?=
 =?us-ascii?Q?+tPnnvmr3bThTd1xXgdnDUPnhxFw7jC9IF/4K62sZPvFUoR/cvcd4uLC4lWQ?=
 =?us-ascii?Q?1Fm1A0z3gPM37jm/9vzwmAaxoxEHcCdIQx+mWuPXQGUu4lzl9sZkgGPJ/OCX?=
 =?us-ascii?Q?JfC3SzXULqWVIZ1Q0R/d/V8vNt8AVQgMhEo67vCRY3pwKY1Wa51fNLj5FI72?=
 =?us-ascii?Q?pxOr+zRque9/3XkqqxmLpOuAdezdK3p1FRWcShDMs0su1nudZYQmhTp/vJoo?=
 =?us-ascii?Q?Q5Y880jz7xCh3KaRq3d/OLmh5hccaX8Hzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af87b9-ef0d-4f85-8818-08db19d92f65
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 22:14:40.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H38gb/1FZTMnnJXKmaUoClPgdLnhTD+h4kGs2TvqjMGaLPXK/VPzDmwi/2Q5b3Fb6ps+VGIkdaX9wu/FwGbTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280179
X-Proofpoint-ORIG-GUID: _39dK4uCabxQBlJIw2QLRDU-pY5fH86Z
X-Proofpoint-GUID: _39dK4uCabxQBlJIw2QLRDU-pY5fH86Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> hugetlb_hgm_walk implements high-granularity page table walks for
> HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
> immediately.
> 
> hugetlb_walk_step implements how we step forwards in the walk. For
> architectures that don't use GENERAL_HUGETLB, they will need to provide
> their own implementation.
> 
> The broader API that should be used is
> hugetlb_full_walk[,alloc|,continue].

I guess 'full' in the name implies walking to the PTE (PAGE_SIZE) level.
It could just be me and my over-familiarity with the existing hugetlb
walking code, but that was not obvious.

Again, perhaps it is just how familiar I am with the existing code, but
I found the routines difficult to follow.  Nothing looks obviously wrong.

Just a couple comments.questions below.

> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9d839519c875..726d581158b1 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -223,6 +223,14 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud);
>  
> +int hugetlb_full_walk(struct hugetlb_pte *hpte, struct vm_area_struct *vma,
> +		      unsigned long addr);
> +void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
> +				struct vm_area_struct *vma, unsigned long addr);
> +int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
> +			    struct vm_area_struct *vma, unsigned long addr,
> +			    unsigned long target_sz);
> +
>  struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
>  
>  extern int sysctl_hugetlb_shm_group;
> @@ -272,6 +280,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_page(struct hstate *h);
> +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      unsigned long addr, unsigned long sz);
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> @@ -1054,6 +1064,8 @@ void hugetlb_register_node(struct node *node);
>  void hugetlb_unregister_node(struct node *node);
>  #endif
>  
> +enum hugetlb_level hpage_size_to_level(unsigned long sz);
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> @@ -1246,6 +1258,11 @@ static inline void hugetlb_register_node(struct node *node)
>  static inline void hugetlb_unregister_node(struct node *node)
>  {
>  }
> +
> +static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
> +{
> +	return HUGETLB_LEVEL_PTE;
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bb424cdf79e4..810c05feb41f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -97,6 +97,29 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end);
>  
> +/*
> + * hpage_size_to_level() - convert @sz to the corresponding page table level
> + *
> + * @sz must be less than or equal to a valid hugepage size.
> + */
> +enum hugetlb_level hpage_size_to_level(unsigned long sz)
> +{
> +	/*
> +	 * We order the conditionals from smallest to largest to pick the
> +	 * smallest level when multiple levels have the same size (i.e.,
> +	 * when levels are folded).
> +	 */
> +	if (sz < PMD_SIZE)
> +		return HUGETLB_LEVEL_PTE;
> +	if (sz < PUD_SIZE)
> +		return HUGETLB_LEVEL_PMD;
> +	if (sz < P4D_SIZE)
> +		return HUGETLB_LEVEL_PUD;
> +	if (sz < PGDIR_SIZE)
> +		return HUGETLB_LEVEL_P4D;
> +	return HUGETLB_LEVEL_PGD;
> +}
> +
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
>  	if (spool->count)
> @@ -7315,6 +7338,154 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  }
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  
> +/* __hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
> + * the page table entry for @addr. We might allocate new PTEs.
> + *
> + * @hpte must always be pointing at an hstate-level PTE or deeper.
> + *
> + * This function will never walk further if it encounters a PTE of a size
> + * less than or equal to @sz.
> + *
> + * @alloc determines what we do when we encounter an empty PTE. If false,
> + * we stop walking. If true and @sz is less than the current PTE's size,
> + * we make that PTE point to the next level down, going until @sz is the same
> + * as our current PTE.
> + *
> + * If @alloc is false and @sz is PAGE_SIZE, this function will always
> + * succeed, but that does not guarantee that hugetlb_pte_size(hpte) is @sz.
> + *
> + * Return:
> + *	-ENOMEM if we couldn't allocate new PTEs.
> + *	-EEXIST if the caller wanted to walk further than a migration PTE,
> + *		poison PTE, or a PTE marker. The caller needs to manually deal
> + *		with this scenario.
> + *	-EINVAL if called with invalid arguments (@sz invalid, @hpte not
> + *		initialized).
> + *	0 otherwise.
> + *
> + *	Even if this function fails, @hpte is guaranteed to always remain
> + *	valid.
> + */
> +static int __hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
> +			      struct hugetlb_pte *hpte, unsigned long addr,
> +			      unsigned long sz, bool alloc)
> +{
> +	int ret = 0;
> +	pte_t pte;
> +
> +	if (WARN_ON_ONCE(sz < PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(!hpte->ptep))
> +		return -EINVAL;
> +
> +	while (hugetlb_pte_size(hpte) > sz && !ret) {
> +		pte = huge_ptep_get(hpte->ptep);
> +		if (!pte_present(pte)) {
> +			if (!alloc)
> +				return 0;
> +			if (unlikely(!huge_pte_none(pte)))
> +				return -EEXIST;
> +		} else if (hugetlb_pte_present_leaf(hpte, pte))
> +			return 0;
> +		ret = hugetlb_walk_step(mm, hpte, addr, sz);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * hugetlb_hgm_walk - Has the same behavior as __hugetlb_hgm_walk but will
> + * initialize @hpte with hstate-level PTE pointer @ptep.
> + */
> +static int hugetlb_hgm_walk(struct hugetlb_pte *hpte,
> +			    pte_t *ptep,
> +			    struct vm_area_struct *vma,
> +			    unsigned long addr,
> +			    unsigned long target_sz,
> +			    bool alloc)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +
> +	hugetlb_pte_init(vma->vm_mm, hpte, ptep, huge_page_shift(h),
> +			 hpage_size_to_level(huge_page_size(h)));
> +	return __hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr, target_sz,
> +				  alloc);
> +}
> +
> +/*
> + * hugetlb_full_walk_continue - continue a high-granularity page-table walk.
> + *
> + * If a user has a valid @hpte but knows that @hpte is not a leaf, they can
> + * attempt to continue walking by calling this function.
> + *
> + * This function will never fail, but @hpte might not change.
> + *
> + * If @hpte hasn't been initialized, then this function's behavior is
> + * undefined.
> + */
> +void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
> +				struct vm_area_struct *vma,
> +				unsigned long addr)
> +{
> +	/* __hugetlb_hgm_walk will never fail with these arguments. */
> +	WARN_ON_ONCE(__hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr,
> +					PAGE_SIZE, false));
> +}
> +
> +/*
> + * hugetlb_full_walk - do a high-granularity page-table walk; never allocate.
> + *
> + * This function can only fail if we find that the hstate-level PTE is not
> + * allocated. Callers can take advantage of this fact to skip address regions
> + * that cannot be mapped in that case.
> + *
> + * If this function succeeds, @hpte is guaranteed to be valid.
> + */
> +int hugetlb_full_walk(struct hugetlb_pte *hpte,
> +		      struct vm_area_struct *vma,
> +		      unsigned long addr)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned long sz = huge_page_size(h);
> +	/*
> +	 * We must mask the address appropriately so that we pick up the first
> +	 * PTE in a contiguous group.
> +	 */
> +	pte_t *ptep = hugetlb_walk(vma, addr & huge_page_mask(h), sz);
> +
> +	if (!ptep)
> +		return -ENOMEM;

-ENOMEM does not seem appropriate, but I can not think of something
better.  -ENOENT perhaps?

> +
> +	/* hugetlb_hgm_walk will never fail with these arguments. */
> +	WARN_ON_ONCE(hugetlb_hgm_walk(hpte, ptep, vma, addr, PAGE_SIZE, false));
> +	return 0;
> +}
> +
> +/*
> + * hugetlb_full_walk_alloc - do a high-granularity walk, potentially allocate
> + *	new PTEs.
> + */
> +int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr,
> +				   unsigned long target_sz)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned long sz = huge_page_size(h);
> +	/*
> +	 * We must mask the address appropriately so that we pick up the first
> +	 * PTE in a contiguous group.
> +	 */
> +	pte_t *ptep = huge_pte_alloc(vma->vm_mm, vma, addr & huge_page_mask(h),
> +				     sz);
> +
> +	if (!ptep)
> +		return -ENOMEM;
> +
> +	return hugetlb_hgm_walk(hpte, ptep, vma, addr, target_sz, true);
> +}
> +
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz)
> @@ -7382,6 +7553,48 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *)pmd;
>  }
>  
> +/*
> + * hugetlb_walk_step() - Walk the page table one step to resolve the page
> + * (hugepage or subpage) entry at address @addr.
> + *
> + * @sz always points at the final target PTE size (e.g. PAGE_SIZE for the
> + * lowest level PTE).
> + *
> + * @hpte will always remain valid, even if this function fails.
> + *
> + * Architectures that implement this function must ensure that if @hpte does
> + * not change levels, then its PTL must also stay the same.
> + */
> +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      unsigned long addr, unsigned long sz)
> +{
> +	pte_t *ptep;
> +	spinlock_t *ptl;
> +
> +	switch (hpte->level) {
> +	case HUGETLB_LEVEL_PUD:
> +		ptep = (pte_t *)hugetlb_alloc_pmd(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		hugetlb_pte_init(mm, hpte, ptep, PMD_SHIFT,
> +				 HUGETLB_LEVEL_PMD);
> +		break;
> +	case HUGETLB_LEVEL_PMD:
> +		ptep = hugetlb_alloc_pte(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);

Is that right?  hpte->ptep is the PMD level entry.  It seems
pte_lockptr() -> ptlock_ptr(pmd_page(*pmd)) -> return page->ptl
But, I would think we want the page mm->page_table_lock for newly
allocated PTE.

-- 
Mike Kravetz

> +		__hugetlb_pte_init(hpte, ptep, PAGE_SHIFT,
> +				   HUGETLB_LEVEL_PTE, ptl);
> +		break;
> +	default:
> +		WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
> +				__func__, hpte->level, hpte->shift);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Return a mask that can be used to update an address to the last huge
>   * page in a page table page mapping size.  Used to skip non-present
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
