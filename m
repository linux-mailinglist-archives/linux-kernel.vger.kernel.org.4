Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28074647A85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLIALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLIALR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:11:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592D80A18
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:11:17 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIZZg001138;
        Fri, 9 Dec 2022 00:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6NJ5QlPyHixpAxLVdOFgdEdA6IUncfqtt/Ggwbxf8PY=;
 b=lKC4KlN/YE/oJ6PFUJCathT4lQ/LHwidWijiErY9cKHA18GbRiIvY1SnR8lm/pC+qeeD
 NOn3l4B2s++oHM4XaKNGgkTPa2OIM6Ae374UHiyoNINQuSJXKllqT2jkbIheUTcEAmC4
 Tn9ehUYR6bCKFFBqZxZ5lArYEDLJIt3Qn/Pwh+I7braiNy5MBh5/3/kaP0//rtn3+LCu
 gH0EWE/QrvcyfpGs+Teexv/FwFWjUdJMWzBG5FyUty/JBI4khjuTn8NK2nkL8Jskopqq
 0oFZ0WiS3zIj+vyNcbXP5muxEap8R198g34LmgulbPdmoDcMJzb24Pus2JhD3tHKcO5+ 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6u876-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 00:10:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8NXtxG034419;
        Fri, 9 Dec 2022 00:10:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4sw92m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 00:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbiOI7+agINbZhAjadtmX4YMHyAZWWED8c6qnm4faGn/3aiH2f6nrUQTKLo2xMtt7NJEF5I2q4RneYGCCogWfX0U9UcXhhFrPTDjDqdm+8QBkaonnLyfSrMKx3KSb4WQdvgdgW3U84q3Tc7BaG+sZ15sQPtVt+LgRGRMuRFaQ16ZDERTA6BazBf+zOEj69+8iGj2o+rpXm0nMSI2anN8VgmIDsonYAdq9Bb3KZHdXRPEnfTnX4LGFXOppwMj0lDRcSi8zdrIWWu43XcQAH+oRZUNuAZpMBVTT6u9samWCY4EObXUv/rWZTWJ1RKq7JAHiyFgRfxTQcuu/9i2mD6MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NJ5QlPyHixpAxLVdOFgdEdA6IUncfqtt/Ggwbxf8PY=;
 b=RC4jRsjr3CAMtBSSlQoTpW3n8LrPRCjfjmnHbE8i35SEa3a0fb289WNzlX/dpb9sd7bXgWbmFGF7gw/mxrIU4mv3aZKOcrKaxM7FIr0Qrir/IZrgRJQG2WGpk6URfOnxuxUi0Aa4jjiJmjiB656iVmmJO96Bni8JmIo7ocuUPlRcu/QkpSMFA1hOByrjbBy0CXE1PXIgnzghrp1iPeLG3wqTgj7i49oktLdpiLkD9lxXY1T6FJvx3hFHP6c/YRm0T71rDidhxDqKDiTgUuehS6l9KGRV+MWOrSqyraNLvbSDBY2nY15OpHh1ATVPhT+nVRvFE7k1F0xT6on8TFwMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NJ5QlPyHixpAxLVdOFgdEdA6IUncfqtt/Ggwbxf8PY=;
 b=Zae+vODoAb5/MQYLa8DTnrJuLoSgpc8ovDj9rak72liDGh1xDfS+ki3FBMHp87gUL392ri+Eeu539L1Drh8ZydsMsKNla44uO3iucqZ/wxwpdvc+KGqbVp7Eir/Yd/nnxDf0G8nPOb4Kxqk44DCWrl5+zzT3Rfp2hNfsQJdhZ8c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 00:10:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 00:10:43 +0000
Date:   Thu, 8 Dec 2022 16:10:39 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/47] hugetlb: remove redundant pte_mkhuge in
 migration path
Message-ID: <Y5J8/98mTKC16+lc@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-4-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-4-jthoughton@google.com>
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5dc1ba-1ed5-4fb5-462b-08dad979cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7veg7hyoJMDas+Pj386WDc3axuRQHugIaDOzL0KvaYS1QVp/B9RJp4/L8SKgInp+vF2pTz5gzMsPW8Um5VDzJVMO/ryeVHPkieYC053B1p/lbs98B8oDF8nZZ1/UhvUDvRAyhsZn+tkh8syNaWSF805UNidM+rpwgnEmkjALMAA3gbj/lW2PgchzG88pgsgYMW8+AVPtdiCUysFJ8671PdkaBqmDteR+AiYZNXk/FuGW6+6P9NlSLYagHPB7erVBkAJrdtj5t7YgfIcGTFwd7A++UxteUhqeyZdAQ2DqXDq8kgXAnofPPdZDgDKgEGWpJ/0aX6XSOL4MvRBY9LjwwF0vT8RHSGUaKYcuRgry+qgZR+9YU79hIDbtP7+BmFXLWDPpIKulCFatvjhSRxStfHB1mm1FTPoKraSf0xe761faFdJaXbn8UeJxvezkMJGfTWW0BEI3ych4/VRYYcTrXgd3tBItFkzFrYpAebB0vZELLYayJdEjO8WAdnutAL7cyyqASG7nn6MZxugDeHyDnTyFndWgrms9OynIWPjo7Da8NFgFRwRWt19eFHp4SCjGntQ1qX8WAPKsveW3eNRdkGlmOnUQFrH6cHrYqf7St2vsyDDGuEkakRsTwtfMpngNsMni+raMIZM3UQGjOX7nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(6512007)(6506007)(26005)(8936002)(38100700002)(6916009)(33716001)(66476007)(53546011)(8676002)(66946007)(54906003)(316002)(7416002)(5660300002)(83380400001)(4326008)(44832011)(9686003)(2906002)(66556008)(41300700001)(186003)(6486002)(478600001)(4744005)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAC7LG+nXjh6eMgxlj9WYuCy7II7roQEPAqqVs5sq3UEHVwkJdpj5sR58MSX?=
 =?us-ascii?Q?mzUc6/L1dobPtvGDMrsAG3ybsO7nDGWDoEhypl/5yDDHehCjSgk8LHMxhEYN?=
 =?us-ascii?Q?36GnZ92nqYrtCO5iPPEZYR0cfYMSfU9W7q11hPyNEMvxa3+QlOG2hXTXARrf?=
 =?us-ascii?Q?bAs5Npastyznl7gOt509T8Saa25BrNrdCRCjjTs3gj/qMiO6Nl7jLEYemEny?=
 =?us-ascii?Q?gVJjIIVYat3aF1I6Cz2rOeBCRyOYzm3lIwHgEKyLI7bGrgiK3I/sSD92xTJQ?=
 =?us-ascii?Q?RMBIULWsSHtNowlBTJ6oWvRCHoCfQp9YocKtQGZcMP0WIiUgiisj/qdr8yMU?=
 =?us-ascii?Q?erF4t1MwIYUhsrlTJM4Yp/d7kTACMKCnSskOzKcNKwmZ+JtrTSu7JjqfyFFQ?=
 =?us-ascii?Q?c91Ju97/gUBZ/3Hn1RfqIaFegaVMElJ/wHSKBDlt+KQx9A9HVIgQjDh5Cq0U?=
 =?us-ascii?Q?H4/NaHMCHXg5a8Jm4XgmQfGp43mpgau8wA7uTqOSsBMJExplZrl0txp64JC6?=
 =?us-ascii?Q?3u5m9U1E+1OswiG8qnJdUX2VVkDtADJPXeQXmvJoy9EMoITcxchstB8hBVRr?=
 =?us-ascii?Q?Dt8j4lyuFw83Gs6Rx60dcaO/1bl76Bg5OVrb698yXS5X9An5t0bmqz+x3GoW?=
 =?us-ascii?Q?ajhRNWcZnlqgGFv9HMkZ/ugZBcDxjXl4wsa4WZEYsPdknxxTh4tcNliM3RtC?=
 =?us-ascii?Q?PivjoSK3te4uyQgCq7rQGf7ssWbg6F96Y5FMUPPnz9JXuln7W779aUEXuAVS?=
 =?us-ascii?Q?sTTbIoaxCcyhzbI28noO/jU3S5eJ4gk+lgJFf5JAWeNtAiMi6vF++LJtGjtd?=
 =?us-ascii?Q?rMqehmypMoG2QvrId9h7wLRvDbbzXydvfnY9cQBdU4VU6o4x0V1t/ssPhXUJ?=
 =?us-ascii?Q?gxzJ/iQRTrthkjjJoMPSzgSlYbS/ZZl56hZRT5NVKiufzvIAYvMI2bmBYf5Y?=
 =?us-ascii?Q?uuHvWPSltyhwnQ/pwZ+RRmAJwmPRUV56WwHvdvgHfYO+bBewcIz5h9gTiWpk?=
 =?us-ascii?Q?IfGAjuH62XZPIYf5SsalYKEGiWZpngiCKqgzYg2GGjunCyOjjc2V4z/yJ7Yy?=
 =?us-ascii?Q?BQMnLZsUKwdqCJ9lZ4WrqEl+5nGnhv4sRdN5n2BzPxrxTkyhiMrdWzzGZziL?=
 =?us-ascii?Q?S0QJfpkZ7vvJEN0x3Pu59M0M8mDMBIyKRsF0EGHivKlsn4IayBWm8SEwxqFc?=
 =?us-ascii?Q?/FLU9ZESNdMlJ3qwb6hrOwoX0yCpMstkq9cqdp9OJrOczuB/fVBRqgzynuGn?=
 =?us-ascii?Q?tNFCoQuqc4pOOd5yMkZIZn01RjXfOImdPsya2IJ++HojgQurZ8hFG0NKk6Jv?=
 =?us-ascii?Q?ZHQEEvEKWs/OVZHds5ZfauWDzIWm3IJdsyoGz7SQYkd2x7Di7rTd2uuw1FCm?=
 =?us-ascii?Q?p0+O092YFqVPQuLfA3OFjGh8BVCSi1FbEVIjfHwlZ4r+MxeAVr+o2kS+HGIh?=
 =?us-ascii?Q?R6eBSh1sWzzy9qqsqRfgFGEctMSyBAI3sfo6NTX724wourNYEMlzVphbq4Tn?=
 =?us-ascii?Q?ypF/puQ84TZrwWgeJDyy7JDUwl1v+zKP/HeCugzqX1WA0qAnk/i/ElkOgTjK?=
 =?us-ascii?Q?B358BHOO5GQihlTVGDes1KQnHh7sE0hhrNgrfczHdneoIAb1micMhhg2C0Id?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5dc1ba-1ed5-4fb5-462b-08dad979cfc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 00:10:42.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biIxDrgAMLFZAuPgbG2qt6T3PgOa161RRba7WL8sE+wBzO5GorEUmy22sNPQuby1C8XkotrNDwvfjr+tuRl7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=775 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090000
X-Proofpoint-GUID: 5QhM_fQUVjSZpk7o-n7Q7r11rRc-uS6H
X-Proofpoint-ORIG-GUID: 5QhM_fQUVjSZpk7o-n7Q7r11rRc-uS6H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> arch_make_huge_pte, which is called immediately following pte_mkhuge,
> already makes the necessary changes to the PTE that pte_mkhuge would
> have. The generic implementation of arch_make_huge_pte simply calls
> pte_mkhuge.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/migrate.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
