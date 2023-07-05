Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A47491E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjGEXgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGEXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:36:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD51989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:36:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365MdNPj021269;
        Wed, 5 Jul 2023 23:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DZ6h6yQAUURjbxSleCruLpdCccqSJGpMA89ctX6cr7A=;
 b=buMSRVuEHOdVfi7BhhejPP+H3lNJijFrPKd2LdJz3dIf7ag3E+jDoHhQabV3WAULSxZU
 3IX76B/iN5G0K3IK4uzvKKoSGnaDH/joHCbulE/iAvGoo55ygDmQdriAuckp+EqWXs0y
 tWYVlPFoF925tyP1EOkM+QX+15UHS2hQfL9gMdHqELEUYnBbJoRjXcIiLbNbCBZmHDld
 fhvjjDN/ae2LdWJO8fSTa2JoNaMX3gyEHVzDlyyCH/LJdML54avgAAjs3AHt55QqNGYl
 be6Phr8lDYFMdu1065BD7nmtONVpAqEnXCHFEnzDcJ62t8p0uWm4tnT90FXVyr4NbsQG 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rneqqrak9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:35:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365NYEQU025170;
        Wed, 5 Jul 2023 23:35:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6qg5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QODMB+X8QYSkjUzEk39D0JFQglPg7tRl2k1ZLWLdXi7G1d2ZkvpBtFm6f+tGXN9TXkxYEOaRUSV/AoHOy3SLZBbmvWGYOzypBOiNeCcZYOYmB5zh9p7FTsFQDtqw4jQHqPhXbBvfbm89iuuJ/UHpiry9nPhNaPSuXW8Oi0bCDAZ39DBbuBuSRV7RzIe7xK4OKBWzlat8VQz8/4cdc1VgV3w8kbPWxQr4olbKhE9H2tzBG64oQuAOmaByigk2eKxl09vtlPm//mt6yANpLFqn9NWHIYAsjZvXkWvohPdpAUqicrvdt+o2cRMpwReX9v9De4YqqJrd9qwGXEa2Omrz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ6h6yQAUURjbxSleCruLpdCccqSJGpMA89ctX6cr7A=;
 b=GA9jtk2MyzvsXXKX5Op6WEFGG1wh697tAaw5nYsCrJY2vP1IpzA/YgV05XF1o5pbVnrmuFmS8oRANuGZo8zEqf55Bf+AyAs6TCBUJng2VoHNxZ+c2JNk0qegWquE0PQd4bxMmek8nvPByjr8ZGl8235dzmmPbNFbiSOH7lLIT4lsQguZ4eb0hrpv4wcSkizKR/KnRinadnjnPQnqWJoTPpaMQvmI098O+lnIRCAxldl8+NvuuIqkg0TcPYkU63RwX+ICBBECf640LCU7Hdw5EE44I1lPsS8OhTXNjs3ZU8uEWPl3q19RSVJHPBFW43viDL5f/keZ9IxkwOjAY9IEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ6h6yQAUURjbxSleCruLpdCccqSJGpMA89ctX6cr7A=;
 b=UoOyCP7yRDv8q3to9I7RXD+CeCUs2EhG3DFr4le9sQDfJdgz+pU2J21LnCw36DE2jJQ+3uJHcB0wGd0C0ADH6hD7YNhwxiLlT67rIOZWho6cjv4BS1FcbmusvVSWzY5pGwnUNz6/U/I2Y32vznQai0kPI6LbSGg40fidoBOZGYE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 23:35:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 23:35:44 +0000
Date:   Wed, 5 Jul 2023 16:35:41 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
Message-ID: <20230705233541.GC41006@monkey>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-2-jiaqiyan@google.com>
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 52db3369-ed3e-457f-194d-08db7db08d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmYVBKLaRqWCnzTiHvG4Bm42AGbVqlPLH21c4CujJzquemBTg8z7bLOLx9E4/ChYwQc6e001xfaJpffcLfmd+eE5XFrzDWhNaDBNHs2w8zza/Z3I+OwDwzKFbhDSPZoMYQcXlSAQ5hSkFTHcTWFZIbMDDDcU7WyN1J0zjqxJJZ2aGjWNlQDooyfyuM1a7IJYSJKTV4iDoulGQ1h5E23bt1t3EiIkvTnDBO1+g1jAX7jAzY/AIroVrXFLkBqHeMwwRTA5wXCMtxjxMtmgyeJPBJBMwbtlSwy0tYYrabU2JAMoYHIY7n+YJwBdgPnh4anUwv8+SBewVzmLorhfaHtO+W6+4LPUrqGdquhDDt5Xcbqv9pL5ztegAwaONCNhxkPoAM2DDvhvZqMBnQH5Hmekk/mk5g7m7RYt7tU2aIxsGbHVWi+JkHgwkpTAA02szaSdhS+6MvhCEywzarGP3bqwRf+zP23+0gR4rNTZxOB64+pTijYu3/4r4d8iXJNYbuV5H+mC1V0NfNmSX6KdkxVExXBIukm/Zw6p2XF/qX8DseZwsU7iASOwnhEalYDgfiof
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(9686003)(6512007)(44832011)(53546011)(186003)(26005)(86362001)(8676002)(6666004)(33656002)(8936002)(2906002)(7416002)(6486002)(5660300002)(41300700001)(478600001)(38100700002)(6506007)(66556008)(4326008)(66946007)(6916009)(66476007)(1076003)(83380400001)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnvRlfsSbCbGQIfKrJYDUGAqhg9cPur2M5rJIJL5uq146hDyYhYwhHzDcvOf?=
 =?us-ascii?Q?6y/5RgfwppYW4dOueqVcUxJIKI9nJZjHw0Tw9TUGRUiYkR+rK0Ki9SXBpsmB?=
 =?us-ascii?Q?kjWn5vZ+TzbOFoE7WcltrSMO1pErxxy6wkSAULjBrzhYkDT2shrXbRQ5ZQXP?=
 =?us-ascii?Q?XpmlE8gfITrURMYitOnxdk3gZ4lX3RgKSCDPhXnrb5dGw3N/5uqhmOAinsMX?=
 =?us-ascii?Q?0hDj3kavJR49fGjSaZZ153pD+wnrwjWvPIahH1FOauX68A1usP9vEUSn+dCw?=
 =?us-ascii?Q?M0/yg8L/cBpQ40pF3+avQgINPcF/+165iWugDUcrCHBD9T6It2rHO0QOhkTA?=
 =?us-ascii?Q?7ZD6sTS4La3Rrjg/AydYqv87mQA5FhGIvNpS8zA3veCFC4CDZJV+nGvBl4TJ?=
 =?us-ascii?Q?PmsIOKklLkThMnM4KFgsqT/anfyiuTjWWn7Z4hojCZg1WuauDNOuMuW4B94P?=
 =?us-ascii?Q?xkvXe7qzM6cDpEyVSRmThA0VN34aauAkUamE902TUkQnS8aXPD+Ny/KRyPqo?=
 =?us-ascii?Q?9FoC+4r04czPFgMjQJNZGONCGEbCIFxs+o1AHsUZYLbhbSbwBCGSbWtMuw+4?=
 =?us-ascii?Q?ZCVq8J8dHzZmI4H2nOqBHoqbGFEOcHvdd5a1E9WnUc7xsyxqbJG9z/VPZP0M?=
 =?us-ascii?Q?PbTV44Tygrff1hV03RkbuHG/R0q+z2I1BhH3yxhTv7keoMPtozk2sPcIwuMJ?=
 =?us-ascii?Q?VtLSsdkRBH+i2fqc8AVhY3gB4Au0F1PUUrjjTkluQTR/P3kjE1dWYGWa7cW/?=
 =?us-ascii?Q?w/G+OmYJKjUwHjkxgdTscIUICFnXrwOcgErv6WEBH8AK1Abub0DhXTxd0Del?=
 =?us-ascii?Q?XIajqhB3jXpsy8GlmjGgKpAdOhZ8MTk7pt0VqXmcmGFVdDeBoDLlHOaCc5ZD?=
 =?us-ascii?Q?1NmTvUVxOOUxKNxWa+PI+qf3GgAZwmvnRm1+36xPAVjK1KBX+D7CTJ2JS3Bt?=
 =?us-ascii?Q?Sktucb7ScV63cbQuhml3HakzoiqvVFniez4NnMm27VQAw0kYFXsKRBZ9kEkG?=
 =?us-ascii?Q?DV1EGSC7/HK1OzZSbp2Vegj/fwjLdKjkvDnXFzc1kW0DAZfLSQBN7lurQ+DA?=
 =?us-ascii?Q?e9mGeZVao833+9d2kiKgTYqCPX9PdmTxXb8USbs8GAfr9oxvpVlvSewTaDj5?=
 =?us-ascii?Q?aa8XX/2L1KEVrTJhYsM/BbxlcubRKUBOqVFSbzi6pW+dKrvEtTJEm0J9d+z2?=
 =?us-ascii?Q?p9cBsOjTdPj01Sr05Y1m5onJrlHgdoRKF+veqkm/UoKE9GHdxtaWRa1ncNme?=
 =?us-ascii?Q?Zz6ESu5WVtnkfYdpPxpHOOL/qpGbXLjLscsv7iQI4ZsiZW1qlEn2LXKxs496?=
 =?us-ascii?Q?rCcldN2yTBZzne4Bjra9+ttw6Z7RCSKAtpCUMVBOcd/O4WkB4L0DlSU5mWxR?=
 =?us-ascii?Q?+8LAz/MWviH5KshSUo1atumoDK9CSv4Gs7jN65G9xipcrRrBXvygcUE9mK5W?=
 =?us-ascii?Q?WoILOOPi0QR0ZxZ6FYsyKPdzNjmNbPLtwBYH+brk5tn/b6uaddpYX4dAIjLW?=
 =?us-ascii?Q?dXc2CpM51LlVEvWpSpdbUIt5mLOccJaP0xzck+jegIUKG2oPkpWzQeWf64Oq?=
 =?us-ascii?Q?Vf+NKphfp9TWn4zHSpi9535ijf3FyZ7lPuD+ieY0IpNPp/YvVP9V72nEtIiQ?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EKJKwBKXeMip6hKS5WCTYaFA8rtYjGj8r3PBUpyqFq+OUzr3uy3zhqobqbZO?=
 =?us-ascii?Q?4UcMbitVSa2QoWd96k+gL5tDUnTum2Cgkqaeyydd6HVTi1XHnhXKyNzvZwl/?=
 =?us-ascii?Q?mpO7Q4UTJeSpF7ZBkPzDifmziA6LVsG0TW7Z6EqQgsnPffbM35fqtG5EDcp9?=
 =?us-ascii?Q?C3gxzEflqyXv1PNDZ3F00KRDGwcEq508vojidT95fl2dtKJeNRNOCKsRHjwu?=
 =?us-ascii?Q?fqhX25F5zGAKNEMnG6W238ViNeEOkDjyC3QQ1uHBzdnoPpeF1Jn5MUQYjsga?=
 =?us-ascii?Q?ANH16kM7J9eonaL7/4CNZvwL2Tmqc55UshtJPNLchfviu8GU7LBhRonBwDkz?=
 =?us-ascii?Q?JWNDoZTsfsvs9NQxY6xdHib8jblTTZIBaVPOi6xSxCXoT/KHYFr4q3qUwd/3?=
 =?us-ascii?Q?qVci5EVstQnn+OkNcuFdzBanmBpXJpKfPRr6cQ10YZ5ziYr032dVENHIdMV3?=
 =?us-ascii?Q?k0tG2VzUdng+0vjOjh0CR+x+FhmaV6TWaMdzYuX7oAEx4CqQSn4ki7krC4t3?=
 =?us-ascii?Q?M+TjUKhueVNVTLVeqNLw8hydQw25Dc34u0ftDBb26rpRsAS4q2KVj5QPgzqR?=
 =?us-ascii?Q?kxmHh8WILdJ1J2noZyT8QAtoiBTuYgWg/rHPD8XNwjdWvgFzGwZfsEZaah4a?=
 =?us-ascii?Q?J+fzxc+DRkW6cqN1bDdiKNiyjCZaLUA5WLa1vOGfPagv/WKJ2RYfq91U95IB?=
 =?us-ascii?Q?GAJdM/JK8Whw0Vr1VbCphatG9LTwxrqWFAxq3yvDNYxUGaOqjEVAIF/JVaHJ?=
 =?us-ascii?Q?h1Ms6+2xU3WlfUjJcMIHMrq/+fleVbov+v0pJs9h9U0NKx+GLQDaH2tqoDm0?=
 =?us-ascii?Q?n50Hw/qoHAfSyEPR6fBqXOdIEHSClA2q2eJPXdqmKR/ReNNyX+k7qhDzvijr?=
 =?us-ascii?Q?gXia2xxAw/2Sqv6pAjJLEWpzD+aBpBK/Ceki9r68dVIWwoHmMSG3s3Rm5Jmj?=
 =?us-ascii?Q?OsazNjX72Kp2uMcaitJev9vaclsaTVm9bQyogicnx1A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db3369-ed3e-457f-194d-08db7db08d76
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:35:44.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHOLm4CjvP231/xgWHFQuaZ/FUNrVkeKYlsSkv7ymr+nCs3pK2xp/oGLaYPlvrBzoMIVrf7S5GkImpbvlL+gTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050213
X-Proofpoint-GUID: -7hBD5BigJ7T7X6-He2zBPQWvK6FmZSb
X-Proofpoint-ORIG-GUID: -7hBD5BigJ7T7X6-He2zBPQWvK6FmZSb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/23 16:40, Jiaqi Yan wrote:
> Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
> are deleted from the llist.
> 
> llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()s
> from __update_and_free_hugetlb_folio and memory_failure won't need
> explicit locking when freeing the raw_hwp_list.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  mm/memory-failure.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

After updating the reason for patch in commit message as suggested by Naoya,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 004a02f44271..c415c3c462a3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
>  
>  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  {
> -	struct llist_head *head;
> -	struct llist_node *t, *tnode;
> +	struct llist_node *t, *tnode, *head;
>  	unsigned long count = 0;
>  
> -	head = raw_hwp_list_head(folio);
> -	llist_for_each_safe(tnode, t, head->first) {
> +	head = llist_del_all(raw_hwp_list_head(folio));
> +	llist_for_each_safe(tnode, t, head) {
>  		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>  
>  		if (move_flag)
> @@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  		kfree(p);
>  		count++;
>  	}
> -	llist_del_all(head);
>  	return count;
>  }
>  
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
