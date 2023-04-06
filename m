Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B61B6DA5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjDFWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDFWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:22:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A23B7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:22:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FJlSX031477;
        Thu, 6 Apr 2023 22:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=r7Uk0ZQ52/CyQ2b+kAOZa2CDwOYsh+U3W4eSpgephiI=;
 b=t8q7A1KWWaG1LsYTH7YDdghsAzotYFRpzHoeg1FBDusf/VtnEwCyGc+qq8c8HkR5o/av
 IBUKWhG36izjZMW79cjGfCoL/7L1aGMn/mgFuLw9g5973KJIiI4J0OuJ9mwluPdgdCrW
 uFs4cN3zxgjO9K/Wa6V/ZBxJWTEn5EldUgI4hGcgGx96hQNT2VJdTQ0SqxWBABpOJ/XH
 L6NAjztovDQYzAa9Mav8ID17iweYFrYkCSZK4rhfAL+L2kUMtGK23jb/K+3S53x3ID+m
 aAtc+DWNwDHDQWaKYsLDqdHWzpFtw7gGec35dqRnvEOt4pek1parnLbsXtBud8HMMRfE FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhc41ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 22:22:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Kp7gp036606;
        Thu, 6 Apr 2023 22:22:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpay0yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 22:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAzN82oaM9hAbxTsG8ZAFGpcSpx20eKCfIXZFWTLKOdfXGIqxEDTZmCdj14FrzzR/H07BsdSEUmTjpDkj1GyPgsf2X/uyrHUvKJprYBHG80I5QfAGZeZKAyBJQ4SpAyiScMCHR7Rr2laXDD7SeIn5cm5W4iFhAEO1wEsG7BNbcPnX7qrRDwepG5LbqKy8nyCVVYLRX+zUHL7yzWpAi49+2gSHCwXrkA587ddugpxNrNd99mqqJR933QKg+k2NrnzKw6osawTx11HJcGX8zh0379pJlbLzW1mlroiMJCkt33JucyUQVcMogYVFkQAoBM6FWnaHKkeWmxvI094UdY7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7Uk0ZQ52/CyQ2b+kAOZa2CDwOYsh+U3W4eSpgephiI=;
 b=QZRrwBWOcLukle/IGUusLP5JPIhIdTdFSPlPC/D/0HtpGB1NURnNMoDHslEDU1/FASKbbpfOV7I3dRk1bu0T22nf/+YuOTkSSwd4/778/YTTq7IdvJCIWcgxpLnjgt87fpqDygG/LeLpTTbkiHR3+3LWlLJqv2ejotszbWCKz4rYnOs/gNx1pFw+H+gPbKkyBFmEu63Oc/xTPAZ555BdVRf+bIpGWbehYVqQnW6pCumv8Ps7lBnf1D26MmbVZvGuI6aCQaVVN3x7pPY1kcB6cMgD8l9pphzOsJOQbch21cOxYllpzfGPBXKgoW3SLzqXkra9HNRm9JejvAS1LuSB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Uk0ZQ52/CyQ2b+kAOZa2CDwOYsh+U3W4eSpgephiI=;
 b=UwG7DduqdqRlcR5KR7x3T5hKRrVyVBmdbVCUqpyKzzKDcfTaTJhTnIAbrGUZCyyKZPcUu6siuSrVeDF/1SPiQpyNjEDnafxK8ShvodpzfEOlpzcRcgcPoAo9yKyetrNPzF6R/nDDLdfEb2Q/27GJsgi1WobqCQs4QTDZdRPctgg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 22:22:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 22:22:07 +0000
Date:   Thu, 6 Apr 2023 15:22:04 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user()
 to copy_folio_from_user()
Message-ID: <20230406222204.GD14244@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-4-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331093937.945725-4-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 696326a9-3daf-4240-93f8-08db36ed5b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Occ1iVLffy1NTBSzWsBPT27oebHRwnKZ7ivKdqN90FPUD8Xsa4pOJKpk9jqHDLAkY7adi4TuI8TZKiqy6P2vlOl+9AJsyp7OQDjo2erCv5WRD8PZNSCCzT2ikpH9HrP0lDLeWo06ygmMRA3lVi3c8TI/2IZ+IuB0VYNn9fdaDSCy6mWIQ0OMpZB2MX2OrpPLnFuIdmtmrmKYDaF2B9UhmldXcY4GRAhh1k31/4xyONjRZxhCyxXtTJ3jKjBApd0kWhBA3uAw5PwE1kNgvdOH2XTFLJNoNdt+kYH4cwdEjZGMOCcoYsQ4c0hYt6k6VLOMkdIuwW0SUXpVNdF8dk0uQbtquGYirpkpM9Pko07L2rIvERoqQXvEHADCTXklcWbLDSSZ6FhReZd80YCly00CareGAN/LT58AQkZLwVSofNvQ18kNghDzYdLsd4LDrNiI8T9Jy/w/xf4b0x0IH0PEdXs+N7PusjJasYnFXvlZdZiT4cE/bQg1ZdXcn/zu8ErPzC7qyuX8RkvJ0Gx4Z4ynqi8mwTOFYhkSORgcZK/Z9roVrjPzVsmiKvFgduSG7aqoQd82tv5W1DYDMn0RT+s4XgZKSSUFcrgABZUXAq/Z8Oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(26005)(9686003)(1076003)(6512007)(66476007)(53546011)(8676002)(6506007)(33716001)(33656002)(316002)(478600001)(5660300002)(6486002)(4744005)(8936002)(44832011)(2906002)(66946007)(6916009)(66556008)(86362001)(38100700002)(4326008)(186003)(41300700001)(6666004)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dxyi+sMSQFPtWAZAn+z5cf0kv0QS8eLP2YGPeESiog6uq/UOUKxLjdfLPbib?=
 =?us-ascii?Q?MdAHwBpL0OnMkLNZQ1dXwunYaxZWxtKTDk1dsQFSO88I2KF5HmjDKfeYyebw?=
 =?us-ascii?Q?5GuHr2E0u5D9GepBNnzwUpAgZZjj+ieQs0VJQm5AdWwBnsD1m9zct1ZGAlwb?=
 =?us-ascii?Q?265WR37nW9p0hk/wk1j6wbdRVnGUOfPdmzjUI0NAPoJnkSLLCa0HhCPmOGeh?=
 =?us-ascii?Q?tim7UnCld8yC8bV8U2FMoiy6tCMYFxTcEJJaVwqHAZI62A+Pf1Ti7+5Hg+KE?=
 =?us-ascii?Q?WmXy1wGtTqhhIDvJlYVblubgGYL/hDaLpxefuajfduon8x0QsljBNZALU23t?=
 =?us-ascii?Q?ufEpPR+UHMTlIS6OplPlUc6bfQkE4E32Z3giI8fUfHHUVv2X+Bid2Nu/i6ov?=
 =?us-ascii?Q?7LR8H2JjJLEMAAht05Au/78FJwQDchkhHeC3yQZgv9MhsotTLit41A6f4+n7?=
 =?us-ascii?Q?skCkvXs0ZV+2Bo5SbiEll0uJIhu5Kqrt6f+NSZeV06Nmn9YP4Xzl06OXGML9?=
 =?us-ascii?Q?pVfw2qUl9ph/6UsQM+zNm6rGHgyW1PfR18eWpR7DahBjMVzhE3qM9UwitA1z?=
 =?us-ascii?Q?aFWezR3mFps3XbjFL5XKs2dnJMj0j74Tbj2QSHcWHy+AwB8VyTkQmfHRV4oI?=
 =?us-ascii?Q?AjTdNhoMJuhhyukgnJduRbRoYytHcEjKhsCFUgnESCjHq+S5/XLQptX4TXip?=
 =?us-ascii?Q?PGEk82F8BQLisj1F4xS6M32Q/JQslYT32PU+7/i2UqmT7AgxXoSjZQbV9zsL?=
 =?us-ascii?Q?rxSQgQHHY2H5EwTX+AOeC6ysOLVb011GzgayMlNB1QiaFyOnIiSNT2YbZ8Nd?=
 =?us-ascii?Q?snDDKy0yWmL6CnVIlRwZM68gP2zCSnd8oXoSaG0GLWy38ptgQj9+JQfn+YWh?=
 =?us-ascii?Q?Buzd/EIHLHTl/ETLUNLxiYQrn89/+LbH/v1X7T0blZmohoGCunRm53aM9KP2?=
 =?us-ascii?Q?al7eU7zKzYhV8Qe3qOzc7SPQYLIF5WpTnZdiSszOZhgeChkIBnO4519+XThl?=
 =?us-ascii?Q?fS+V3v8/0e6iwiPOiGIbH9A+VtOxJq2HdjJDou0953Tj4dbxSK6pyluNvYwO?=
 =?us-ascii?Q?wp354BqBFg5EnMnBndYKX+1koBdIATjXuzGuzfUtbt1N6Tol6xGoKXEZfPPj?=
 =?us-ascii?Q?tBp/uwOpG1Zr2lCFXF3xcWrvQKRd7Uohmkn6JGk9rXY0xxj1DeibA/JwDvuH?=
 =?us-ascii?Q?aAXAoVg6q8ijUCx3kOHKkr3OXGI/QAlrhW4xK9S6BGAs4rhZxp+b6kLrQfEK?=
 =?us-ascii?Q?lcy8m7yt1o81/VNRSQRlo/Cl0md6/EQIWFvnzw/MPEH4N9XcR+8b37W2uOyI?=
 =?us-ascii?Q?Y4cqslygE2W0FBkUg5DeUGYbAph+Th2qmZYLbZevEt2rhu1aRIM/W5K9K0qK?=
 =?us-ascii?Q?CBjESbPtW4qf/lGdu5ymRJn0rYLr+8uJs7EpmrZDc2Z5SEVBOuKPLd7/euQb?=
 =?us-ascii?Q?AH9kNB0pPc6qWplM6sSI26UvCuTnANZlvUJQVEDmICftJk8VvUGlluhEtY5S?=
 =?us-ascii?Q?C9JpPseHb+MrmQoHusTWERJo5NxIqUBBZ9s5TfZQegHH13LL8Xf6m893vQtb?=
 =?us-ascii?Q?kSHJDl4eaOP2MBVGy81AqQHdHoNYbV4GOXmDVBX67fraYRbMx1O0PdLwVpMR?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?m5EnY7gbh0umJdybidGZWdClCoEU8v4VwiF6phlSKsZAe8iYl3YxUJrIoGXf?=
 =?us-ascii?Q?62QM2VTSD62L3Avaw158ArGM2gIpVUel7EoZINbwCTRpJKDwxtjCo71Gdw/w?=
 =?us-ascii?Q?sslZresIcgpbENHHX+3YFB7yeiy4TGMJ2vhOWpTdkIuk07TLvnSC9oN7+5o9?=
 =?us-ascii?Q?Fts5KEWEMIfHhYplE3S6GGwSHAAYWn3UBjMzNpffgx9S30y6FKSFK/6sHMCQ?=
 =?us-ascii?Q?GhdY7gFlo+Hzif5c6lDJ2e6LD5UrvArffxUDHZjU1KMD0oHoPsptX2W9dJbB?=
 =?us-ascii?Q?qSNuC74HuBMORN3mNNgtwjp4ZE4CbORa7qjt4px0EFL6YIzFSbiaArKhaGy/?=
 =?us-ascii?Q?nuCngxZR73EVGBf3vcmTqo0cSbfo85xajUtuqjn9pL4KPOOWV56pd8TfYs02?=
 =?us-ascii?Q?Axdz3U+jwVf+w0DZKD6phqgHjlCcyocMSlMY5zLEXDHnM6VvY927dKLNMLi2?=
 =?us-ascii?Q?dKNDnG56t6Pma2jwk5YbikpP9p886J3D36ME8t48Z2cwYvT/ASqaWxqH5qwg?=
 =?us-ascii?Q?vnk7yRHZDthevjTjqxFdnqXy1rDzBT5GSFvGEHVtMI70FUrOqzXC/sQOIpz3?=
 =?us-ascii?Q?8+8IBYGnJ8rB1IH9EVBT7lct59YVPwzH4OTjEBhTpqMGMxt9v7DU8+WfNc0N?=
 =?us-ascii?Q?TPC3AmKlZUMSRPB3axHNl1Tyq80W91VshLa2RysNdmKTdCuMo+UvKMGJeaaO?=
 =?us-ascii?Q?36GXacoRGI03SF4gjB8/HSAtLiU1aPIuHfB138oNqF+q6KEbDq27gJioVKsK?=
 =?us-ascii?Q?iYMclOR9Y2Jve8ucS5mt91AGA89oW0VdBM2azJR9yAS9C49luFCxvdnVVJhH?=
 =?us-ascii?Q?ejugxgGKb19NX13lH7Lk3GUl4FwWL9f5nx2qpQ8mn/0NWzsN5bnyUneASoDb?=
 =?us-ascii?Q?ppX3x5KTiYAHHs9qQnMnO2rlf7/atyOeDzSWDyTBp+AHdCtSPYEXh0EUwiq1?=
 =?us-ascii?Q?Y5TBZ7yRpP7kXRkEv1uj2A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696326a9-3daf-4240-93f8-08db36ed5b7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 22:22:07.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQfG138tUsvq/uvxUJER0z9he1TpC+6is4tJRIjb+SwqzPFzqxllKE/JSgLW/c5qTSn64dTY0F9oSRQcmJSeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060197
X-Proofpoint-GUID: EPCzcymm6fT9mUYaNYsJCZO9H0AsOSF0
X-Proofpoint-ORIG-GUID: EPCzcymm6fT9mUYaNYsJCZO9H0AsOSF0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/23 17:39, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Replace copy_huge_page_from_user() with copy_folio_from_user().
> copy_folio_from_user() does the same as copy_huge_page_from_user(), but
> takes in a folio instead of a page. Convert page_kaddr to kaddr in
> copy_folio_from_user() to do indenting cleanup.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/mm.h |  7 +++----
>  mm/hugetlb.c       |  5 ++---
>  mm/memory.c        | 26 ++++++++++++--------------
>  mm/userfaultfd.c   |  6 ++----
>  4 files changed, 19 insertions(+), 25 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
