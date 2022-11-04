Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A76197DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiKDN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKDN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:29:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885AC1B4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:28:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4CXpmh028580;
        Fri, 4 Nov 2022 13:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=pVnsFL9dpOXj33Fd0pTJlMnSfBrcg0TqzDm4VEIUGWE=;
 b=qHbPYhMPT6AuAWA8NLZ6WhC23f9JgpMaSwBDgudIlj0QkakMirUDVLMv9d4/cwyL9x9k
 ENCtldqBW0Oh8rcx8GEyR/iDRNEh//dPFITgjQVNMhl4BHNvZdYpKv/k6pMWSj2DcyWJ
 P+cW+Tqznr1jov3wCEZp65kU8DY6H+aApkU1I+cv4j7yLJ76UxS0kwwCfPLnFc8wirWa
 c1Yw2H4dW53sNJLXAtiHq+gh/9qpGDxgdgCC9UdYDA89laumZECgt4aymt+V1s0r5zv6
 3/ptY+GRJ1OudUAZnx+P9WKHmvQSJLrLCRAB7KkXDU8V5h+RXsKy8WkI1fg4gA76IRYe PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1g3a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:28:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4BxugA023226;
        Fri, 4 Nov 2022 13:28:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwnhu89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZwKiE4kQ4ZMK+qiIKD6GwlrjCLITW7oMgrbALhoLooowlwjWAuXYEiny3XMAMjzq7WAE3OI7CXMEsFTRCzwfsCtHUhU48Y/bEeSpiEJ+bsZXeV/7Tscq/2eg7T+1FezgKsbBkQKuOrYRp3yF1CtHi1/q/YMQYHsGeNaUqde77bJFDFxwz9JjllhGd6C7vnMTUipomIsuNg9ShA5KCdVXb9goMdIfx9Ikc0ynrIefPoEcRN1ZQPRVikTQj6qhB5AIxGTm7hZxcsuBReqeD3/ucFAbiG6d19lFkzIBTHSDcKfltlz5C3sjpT1P0hfDlcynhic+0APDTDH3nqcxpWuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVnsFL9dpOXj33Fd0pTJlMnSfBrcg0TqzDm4VEIUGWE=;
 b=iQIk+mGY9RSoEkxdFhBlCYPdXdqmXjpeOUp8vb8u08dSIcGJqwGuecfetg0xVMlAzkfSIXAJDzDSfJ7ZoN7dBhMKorEqqYjr8v5JxtHSzyaQobv+QBe+wgZiQaFWq7Ofw6GTjA33rLryGi/h6HWzus5IlNJjosUouVNRbxC9lTMMhwmvmMMNGbdtqCJMlLPvGDPqozbY/N4MELWyYOBIAMsM0WIvh0zv3lIZAiNX7WybdMW11jMY7cLuxIhBJ7Ed40UGpbpw+VekEUQ6iL0x0AwBBl7lG+CzDCigfWld3GCho3mC/U7sTZW8mOczEwHUnUi4M9g+v9sHZec6LJuByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVnsFL9dpOXj33Fd0pTJlMnSfBrcg0TqzDm4VEIUGWE=;
 b=yDYw8xiW2L11gAWvuT+tHHygpfwSLPcFNaeapQQ7XHFOOzrMMNlS1HeYBNbdIhzG0I7/OmbNS1PJ0pdewsVUD3YEtZcf2EM/WaDhTnlPth9F/6cNK2Ql0DKxXHLeVKHlGQGXk8U3XTblrzsxpNuoAYAd7R2c8FCU/4425Osdf5Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 13:27:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Fri, 4 Nov 2022
 13:27:59 +0000
Date:   Fri, 4 Nov 2022 06:27:44 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Message-ID: <Y2UTUNBHVY5U9si2@monkey>
References: <20221018200125.848471-1-jthoughton@google.com>
 <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fb7907-3abe-4529-5df9-08dabe6863fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EGc0zfqPkJG5IU67VzBrVXNhrNGpoK/EXLwKQi6c9GFt5Gd8wfhBOdmsrDCWxsrWQaLSvgvzPZIXiLCecCwb4iOt4RXq/kfn21TpNy1bNGDCZQ7apegcl3Riztb2SL+nz1b3eIMSQPQDLG0V1THxolJpQJuzPZPxkAlb+ySjgKSv5muF32bj+IxDSn5HetPmAjR4mXgJBmxE5Iz8mhu2fPlG58IQvtjdvDNp54qGhRfuY6Iu6KJ00nkRM+9EueYissshtTHC0rQGkGPrzq9v9HPSwFRmnWC12P61e/X3TpbOdkHAHZRMZl9td6RZ1Wb5PeJDcQHv9WD5/+/YQhGXsUbigg81funr4lLu8hGw3pYNKFWVt+dE5si4HJxULSAUNnbJGEloHd+70p6RmMIhFuz+XpqPctJiuNrEJrHJ+QdENI9MYlaAw7SxMR831Op5ClxYyVpa7Csi8EutaUdNo9WO4pU7lBXrggt539Wolvs9nzwNmLmhMju6DToPIN/o9CkX02Oi+rC7VAr+yawZ4xXIetFqIFgvoX0SpeJYtndilepYUCVZOVzO/r30AIwuoheR3GPXL1iBm5kF2duIepxW9fAEuzlTDFGaC3b55x9jqH78Wt/fARXPBePzA9PithF8vyf0h/Xg2qqV/780YaHid0+CamU0Kx+yR8RDpFNG8acS/mDmU9ZYvRA6/TtY6W25ucPog1bpNmOLg3LxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(66556008)(26005)(66946007)(66476007)(4326008)(83380400001)(2906002)(8676002)(38100700002)(5660300002)(8936002)(9686003)(6512007)(44832011)(186003)(41300700001)(478600001)(86362001)(6486002)(6666004)(316002)(54906003)(6916009)(33716001)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9rKy8zbERRSkFXUlVZZm5va0NHOEZCc1BsTEZjMHQwOE9PK0JsU0NqT1Vu?=
 =?utf-8?B?ZGdQelhXRU1vNGhuL2R4ZVZmc0ExSWgyV1BVdEc2WjdTbllKN3RybkdpMDN2?=
 =?utf-8?B?QkJFblJzQytCSEVWQVJia2hYbWtqbEpaNFlXU0FNcFRGUzRPS0dCNk9qdUpT?=
 =?utf-8?B?ZUlaa3QzS3lqNzF5NUhGTUVNcFZzWW9adHlhVzdxb3RxZHVLOU9vVEpTZk9h?=
 =?utf-8?B?MXZPNUNraEVVQVpVd0w2aU5hNDdOR1V4THViQmhFN2FqUTZBV3ZEcDRXRGVN?=
 =?utf-8?B?dHpzUVJrTXpNZ1Fqei9vUkRBQndsTWhYZ3ZiYzBwMWdXVld0U3hSNUNKSmVq?=
 =?utf-8?B?OS9SM3ZSSk9Eb2NnQTBmejgzeGVGVFhmMFd6T2hSYm9kWkYyWngwMkNFbTZo?=
 =?utf-8?B?cURkOC85RzVmQ2xKOXYvQ25EK1luNlNNZHRnQWwwdzVPdHQ2Zmtpa2owaXJB?=
 =?utf-8?B?TlhIaE4wYjBJQjB0aDFGS3N4VzF5blp5RXllclQ2eUhDUzY1NndJUHJXZmtm?=
 =?utf-8?B?M1lGdGNLTHVJYVBPME9hT0tjUmpaTTU1Z0p0UkQxSTlQVEZNemNISjlPUXV5?=
 =?utf-8?B?L2pJbkIxelVZdkZCWmNQT3JaY2QxRGtEWnRYL2NYR2R3KzVUVWdTS1NYUVhL?=
 =?utf-8?B?UDZmWlFUQXZXaHFLNUZzUXZnNDQvdHRDUTdyNWNodU1GbFhpanJjNHR0Z3NO?=
 =?utf-8?B?YlBRTnphaTRjdWE3U1hvem43N0RySXJZSXFhWlFmcnRIVXZEWkxrRnhZKytN?=
 =?utf-8?B?VkRkWjVRR01ycS9vVHJFR3VlRm83R3NST0I3Q3hmZGtjTis5WmZSNlJBaUNa?=
 =?utf-8?B?VXFpdnI4MGFwZzhRdmJPK0k3d3ZhbUpiZFpjM0hjSXZHemtjZ1BHMHJJS01k?=
 =?utf-8?B?WlFrTDJuU1BCcGZhT2hvSzJ0ZWlZUVhGSSt1VkRNNlEzQXQybmZnM0cxSFlV?=
 =?utf-8?B?TUNla1Z1d1NXVDVubldxVWVZYjdiRC9TdTQ0V3V3R2FrQ1JJWXNJZ1JhTW5E?=
 =?utf-8?B?NmpLa0w5R3JndTlLbTQwSzdMV0R0RGhGWnhoakFZenQrdmFzMzYySlNsVzh1?=
 =?utf-8?B?VWVodlJ4SHQyVWdjcFlSdVJ5ZzJUYmdGMzNwMm92a2lpSnR2YzNaUXIrSkRy?=
 =?utf-8?B?WUc0SFNZdzQ1MjQzblc0cmFUNnF4b3JhQUlLTFdJQ0xjYXlyT0VKSDdXRDBX?=
 =?utf-8?B?MGJwWXRTMVdEUnR1b01kWnBBUVFyWlFrSnhLaS9xQjZnWGZsS0lubnBOSkFr?=
 =?utf-8?B?eGpqSmViSWFjY3ptOHoxbk9UaVFHWG5hWWphU2ZPdU5ZWSszWUJ6Tjhac0tq?=
 =?utf-8?B?THZPZjRwUVo0SG05WWdnNkkwSVlYcE9GT3lDYkpzbk5WeEErdGlndEI1YzJx?=
 =?utf-8?B?WWVrbWtUODZVVXlNQ0o1NFJvM0x0cXNDMTFHaGtiRWJ2Q1VXdWhoa3ZoaytL?=
 =?utf-8?B?eDQwRzR5NklrYXpkclU1eWdRcDJGZ3BLZ1hOMDZFVEVTVHZVMkhCYzFOdTZJ?=
 =?utf-8?B?d1IreU5JVXdDNW5lcnozaDlaVGVTT1N3cEgwZUhhYTNCbEpaWk1vanVCcTZ5?=
 =?utf-8?B?ZDVhdUpWeWowSitvNjk0ZWhkc2c0RnlhVTNhS2I5YWNyV3RjRStPSmZ1anNC?=
 =?utf-8?B?MnBCNlEwc0hLWUdMVitHZ0tzMlYxNFVQNFFvUnFlVXhMRERSVXdadnBlMWE3?=
 =?utf-8?B?M1hMUGlUaXlPdGFiZXhxZU5hNno4UW9CaDlFS0VXb25pSE1FaTBsNEtiNk1a?=
 =?utf-8?B?TWRNbGkyOVloWUZxR093Q1N5Wmh2Mjc2Q0dPS0cyZlNobGpYclh1bnd1YkVK?=
 =?utf-8?B?OTZlU0FWbWhZLytKWjBydzh1ajZReFFyWVdQUzQ5aFdTKzVnbGdxV3htY25V?=
 =?utf-8?B?aHdkbllSajZQK1JYRWk1d21xamJ5TGdzUngxaGlCTHFiRXFrV0lDb1pRcHQx?=
 =?utf-8?B?MlNNYmZjMEE3MUpxdGp1dk1EWHVJS204TjVWa2czV2tpa0dwN2h6QjNXRmYw?=
 =?utf-8?B?UEkxdXJTUWRvK1RBUVpvbHN2NWRGL29PR2hOQ1owcHpFNTVQY213cm1Qd0xF?=
 =?utf-8?B?dHNTQUtRekJCTUt1cVFPa1JrZkdGWG11aVJ6bUlZYTVoN0tFci9sZERLUWEy?=
 =?utf-8?B?OUU4b0lkdjUveDdnRzFvSTQxUUZmUGhCREsyTFRxbU5lWWt4TDM1eUZuNVZK?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fb7907-3abe-4529-5df9-08dabe6863fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 13:27:59.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpqx6OXWCrjzDVdejdI3YVPDIXKYZTBZxYnNXzDtL/A93hCnxCTszaXKRttn628tLq5V4o8Q+llU/pwM039Msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040089
X-Proofpoint-GUID: hIjfeXvC6Ou7t2k9B_ktyqXc1hTkgrPw
X-Proofpoint-ORIG-GUID: hIjfeXvC6Ou7t2k9B_ktyqXc1hTkgrPw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 02:10, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Oct 18, 2022 at 08:01:25PM +0000, James Houghton wrote:
> > This change is very similar to the change that was made for shmem [1],
> > and it solves the same problem but for HugeTLBFS instead.
> > 
> > Currently, when poison is found in a HugeTLB page, the page is removed
> > from the page cache. That means that attempting to map or read that
> > hugepage in the future will result in a new hugepage being allocated
> > instead of notifying the user that the page was poisoned. As [1] states,
> > this is effectively memory corruption.
> > 
> > The fix is to leave the page in the page cache. If the user attempts to
> > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > EIO, the same error code that shmem uses. For attempts to map the page,
> > the thread will get a BUS_MCEERR_AR SIGBUS.
> > 
> > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> > 
> > Signed-off-by: James Houghton <jthoughton@google.com>
> 
> I did some testing and found no issue. So I agree with this patch.
> Thank you very much.
> 
> Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> As for whether to go with HGM patchset or not, I have no strong opinion.
> As you stated in another email this patch is correct without HGM patch,
> so it's OK to me to make this merged first.

Thanks Naoya.

This is a late thought, but ...
Should this patch and Yang Shi's shmem patch be backported to stable releases?
Both address potential data corruption/loss, so it certainly seems like
stable material.
-- 
Mike Kravetz
