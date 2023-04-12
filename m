Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ACA6DFD47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDLSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDLSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:14:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C1421E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:14:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CHDl73027258;
        Wed, 12 Apr 2023 18:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dsg/6sCAniQy/sPl2lx+TvkA1gyTRdCYEkEaxj5/pXo=;
 b=cttcaBpjF8i6FJocAaTROsl5ZhRWy0k2yt/WOBOTwMfFkfiKBSemf+FH+wwl6yW1ZoXq
 VgL+2Rli7SlFiSbe8PE4SKnm258wBdepZsGCJSts9csNM0g8X94ixq3chlXwax4VQOC1
 nC8FZX0xRtKdIhV/s3501kQvlNKPkK0VGNWJHL+nU1NWc1a4VNSO8bi2E+/g6pfE57Tx
 HbiDwu0Z14uUNDL4sv0d+ghNUMC+j5D/9gwQ5wSefLas6g31kYT+WbG2ICsQf6rYPXun
 6x696jb0nWa1CPscFj7/FewRluq6Q01+evzoDeBAfGhvHr/oGdR1zl6IiZ7AH5+JA1OJ jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwh32x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:14:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGxgBo039630;
        Wed, 12 Apr 2023 18:13:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbqekw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbhybKP18l2pFD0jg0lCsECeuSn1a2iUD0tuEBWAv6eqn+6FrIeMj0sFbmUIjBq6agARL33CgFcCL/oJkqkGvN/CJRr7hwXdLbHBWTubYm7rB1xDpWfLD1OvLch8jd4IVNEpI4InrtnzYcVMFc9avTp0ZtlnkKAtKsSFbWSdIgP2KY5SVUeIfW7Cv/1QMXcz3ttZy0EZNNGHXVQkrGu3WsQpivHVb0E80VKiaoR9Y4R2i2Vu93XITetUzt2iazno2VBk8XOQoiUkbIMFRTAiRMw454TU2JWY8Pf5PHG9LK0AA42cQKjK9fG9IQ2+UOzFD0To1DprFZEStUktKsLvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsg/6sCAniQy/sPl2lx+TvkA1gyTRdCYEkEaxj5/pXo=;
 b=VuJG9DrP7kKFu73D0+r0nT/uEKQF+J3/1fSv/QqoNGu/x7MERAlTFDt2awI20EZfwVhHc8VUWMbuwBCEUUi23KF8J3052newzXSjPQGpt1RGwGdgZkCfLhy5O1acbPLQ4GwcQaKuOQfE5uwcrLFo0dAN5c9foUm/yaMiKnwO2IGmRMIweqvyr/W63dV9gvJlt7qdpIfDOnDeaLL8H8obl4+5pUq4vgr1NSUw7IWaZ2mnKRjJYsuu8rKasafyQgYiXSeU8rNWedVTW1zVpqInfknnHHkgAZcfA4RDNtZr16Tjfd9DfqSpWRphBF4pCYdZg9Qc/hzJY8Xi2gjZlYW6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsg/6sCAniQy/sPl2lx+TvkA1gyTRdCYEkEaxj5/pXo=;
 b=v5fJQQdemUX84wEixzvuJSygFarJycs0Pym9Vc+/xaMgzMiTsE9L8hQcNGoYesVuZpgirUoej9UDU+cvT4lfT/8HUddZe8RpZGE1tZqQt8+8L7v1fYUqhL8UbwTKVRA7zX+l1jRSZO7M4642LYFnjjkaxyIPODVH9QD1/stFCyU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 18:13:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 18:13:52 +0000
Date:   Wed, 12 Apr 2023 11:13:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Message-ID: <20230412181350.GA22818@monkey>
References: <20230411092741.780679-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411092741.780679-1-liushixin2@huawei.com>
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: d81d5a02-3e0e-48b8-4a92-08db3b81ac0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RxWYIj7vuork5ZsLvKLQnxem/sfgIMGUHl5Krfxl1M6VGQYH2vumAEj2iSkTgmpltnMJ62HqcFPNO6JZ3LO8dzIhUU+mLZ8j6Ztb0wQDsM0VETYFAGsUEJmR/ka3tFRB8Nc/Kwdv9/5SKDZlrQKE6o0E3ym0UaWRVhaRBMQeaEyoqxNI36mbUIU8da/KegoYop5ST1OGVNYtYpVoKx/rbG3cJjQs8fqGK4tLDcnKgbsHaofjOGGNulKPkd7xEiO21tUJ2ysqJSepycJ3GciM84ez58TzcL4u/npsLCn3COEAFPfA+lHtILjU5SntKnvcQ/xumdzdJ9RRqstW8TZeF4IyZP87FAyr5GUMLqfdvTjSgiRt9n4/wbhPQYG+J6K1IqlSyovNn82bAMp8A6Iagr1N4x7kq4OI29K22fzGMnYnFsAMNzhO1AJ/fIR2GflCBRSnXQRHlSTkoxyay0FP8VlmauGPwWWpDXqjrzJeBRVrmENGSNVZUbfJ9GXqmryGVYE8ZlWo2ET7R2g8xgAyDCEVpeaQjSzw74lXUAqaUHJXQyUULe0PuWrevk7hR1f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(478600001)(54906003)(6512007)(26005)(33716001)(1076003)(33656002)(9686003)(6506007)(6486002)(41300700001)(66556008)(316002)(6916009)(4326008)(66476007)(53546011)(186003)(83380400001)(66946007)(2906002)(5660300002)(44832011)(86362001)(38100700002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijOLYvNqmD3julQECNL7DDPb0P6Topy0dqJZSmaBkvnHiCy8AndZvE2dofYP?=
 =?us-ascii?Q?fKaMFgT+dz0xBFV2mfwdoae2lCcPLzbu2QtwCEWOkym6Gc7RoBNJp9IJV4/X?=
 =?us-ascii?Q?3/OKe8fhckREdhbZbnReMCh9ZNizWu2z7yG6nCJ5otZGVu0zLLH/+c/WGpqD?=
 =?us-ascii?Q?lmhEmN9sMR6RrL8DGRn63vgBEG0cMQ2jRE1Wt6LoGsqxtEiZNGObmQ/SXhdv?=
 =?us-ascii?Q?W1nGPQAxI1uFMdjPD8/njay1IGdwrmfO6I9VyJj+nUix6gTiNDTMVUFuz9UL?=
 =?us-ascii?Q?cxCIxMJ/jt2V7EBYLwx8oiO1/qjnzwLGGUn576dxgW9NRe+gOtWHZM5TnYbu?=
 =?us-ascii?Q?mMG6XuTNQr7SvMn6t6r0Fp+O2Bp1TkKNWCrvqkZvot/6vz5dBKIp9whZourV?=
 =?us-ascii?Q?81TeFn7AvBGHBlwZTxM5WHpmMTILucwA9PXeySuRGuLW7N/Mxy7dkUfSKZ+i?=
 =?us-ascii?Q?bkKYLvInCSsBuHOyZQe8MQwQUJgenVzbdoQL/ZxOvWcmkw9MO298wgzOt4SH?=
 =?us-ascii?Q?HTZ3TR8/8Ml6J4kuZlJKEwF1keMJNeehBBzsgeAIMkhXqEExnuvCFgNtvIoz?=
 =?us-ascii?Q?08pSmcSg3xu9Nh2sQ/CY0ffGJz571t/DQ4SXlLMGqYFB+HLGVoCKPCQ0zhvK?=
 =?us-ascii?Q?d7Bu+aatgOLXwR8yYjmGqYHEM4lWD4y3VuY278Kkk+DDo7T+r9vOHOGxR9nN?=
 =?us-ascii?Q?Lpp6TeyBxA4zip0yeGH2NHOxnxeyiCTD09L7XPUzHzKVqhRwBjlHVRelrI5F?=
 =?us-ascii?Q?FPFM0mfYqE2pI6WkLa4d0BxN2vy8WaFBQNu8vK957xrjkqDV3z7rPFOXDOfp?=
 =?us-ascii?Q?XVzMiW2NvnRQYoHcnyN3DQgOYAUG4wtfUfzic8dgJBKZS6k4zfNHLRcw/JoJ?=
 =?us-ascii?Q?W+z34C4KM+k4pmDeolpsT9C37UsiCfezY+3RPBGAU5TWVwe37ytINmd/CZBs?=
 =?us-ascii?Q?1/W4RioUUO58ExIqN8Xm/kGz6qiJ8KFB6IGgf6y71Pvf2Tj21CSAPNsMCpFa?=
 =?us-ascii?Q?uhI8wZc2LSovBKx75Ot7JElqRr5fyW7vuJe0tAGAkQOu3kpxdhQjaYstgfrJ?=
 =?us-ascii?Q?ggMR50roYyl/+jH8u+zfBC4o4ar0pbVw61a8+9M8Eyd3PGBuXJMCWZNRBZ3t?=
 =?us-ascii?Q?JaO7eNGbtBb7O/vofK5Qg9WY/VNb+SGCpAleaySHTyOcx8kgGZJYMQIpXD8g?=
 =?us-ascii?Q?JsVhm82kkScMFYPizL3J6EFwb8N90H2ApXOO79/EK289ccxWiVl6KzXPbQa3?=
 =?us-ascii?Q?Zur3g2avfRfuH6XXwwyhsi4enteCwEHDXimF0jWxgYrg9/IUvADn5ENRIa9b?=
 =?us-ascii?Q?QCoLtZTjMTKoKKVFN4ymFsQztYBMaA1u2i1FMc5Yx7cqMM3Qba5HzRAAYb4B?=
 =?us-ascii?Q?5k0UR4TKOSWqnJkjCROu0kYpx7o2uSK94IDi0xX4Pbw4yH4x6OEWwbFfTe84?=
 =?us-ascii?Q?was/r+X2G60bUCdpj/rq/ePubkkFCitBuVQA0gWGwN3dBS15IADujPZ8/kkZ?=
 =?us-ascii?Q?7vtlBCzOD2gIWyJZ1uWfbA9qiB5DgCPYui7eI6bGKlr7cQxOzM9fl382BNEM?=
 =?us-ascii?Q?rSCVDkPbboL87SPmSwVo2bHq4gu3XmG4w6rq4nEL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4BlXUV/274QyK1BgsbOgyO/LPoV1BYOv8n6OAn0vLRZi4shQzdg+398wZOWa?=
 =?us-ascii?Q?M8/e7GkvjaP4uSncDGQoVpklgFswU8YJ5ier7cm9PJe08tMvihEpvERstI70?=
 =?us-ascii?Q?4DWq/X1ITg4Sx3lY5jLwzXCQt9QR48ERuj1FjyO9NBRHJFfT1uGXfpNVYnPw?=
 =?us-ascii?Q?7oYj6mzb6Duj+fGZsJ/v8wZ4/MppdqPh9HIZr9eTRa/BCqIyEORfwmm6CHJu?=
 =?us-ascii?Q?7YcbuLZLJZOMFlL7BLAwBhhxo7A+j/B6DYETz6X1Rsq7GnZ2BI9mLvzS960a?=
 =?us-ascii?Q?P/gPLOcI4UEaT5pG2E7OlxT2ePVTlqLgJfo+hUuqtPwjLMBZdRR7hjDXimcS?=
 =?us-ascii?Q?4uMu1t4b8Q4Naf2MP9/rJtDmkUf4SO2LUy2WSouGKRl/LSxYs1LJfqsloYwP?=
 =?us-ascii?Q?/StQnA+k2Mee0QAEqiVpvnOtfeGDOlyN8jMPIQacz721eYgT9IovW3LXAJtH?=
 =?us-ascii?Q?XfSkNurhIoXOUhKO8NW8kaLYCLwgXI0/2cI1YY3N8qvfYhSJgz13vWh1ObX6?=
 =?us-ascii?Q?wSrmdpRjwZoRLubVXCQdb6Fqj/DVV7UHhCIDMsLn5O+ED1dTlD26ClqmqjC+?=
 =?us-ascii?Q?HBcLy2olmj3gHgT5eR1DGacNoBSS4x8XNVZe58Gzt9RI8vynrRQJPSmVugo3?=
 =?us-ascii?Q?GuMVZwHFlbDVWPIg04rIlOdY9Fu3/gfuxcdpbe+wWXWIyCVzv8A5o3cRQwZw?=
 =?us-ascii?Q?8qourVy7Z3geBMSUfT7YxG4NJgL2MMLVbWx4OMvUi/rX0+PvruY4UGXBiPLq?=
 =?us-ascii?Q?LxRhNj+8300ZK4VVyH59pgRCF8S3xI8gRsXy4OuHTsR9mFGhPhEjWOS8SD34?=
 =?us-ascii?Q?gt93na0bSdRqhwswoe34l4/K0TagclhWybk9qLM8r/kiGFQnNomOyGM1O/30?=
 =?us-ascii?Q?Xn/JMCmgya3MfYdDLLnod1WtQjbTyk2Erqnf7V3z8p/UdzdH3/aLZhw+VWs/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81d5a02-3e0e-48b8-4a92-08db3b81ac0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 18:13:52.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxmgxFS2DWrR5l+dlStSU1NItNyHflMs+MWD3hBwPu4+APsMRsvBMXZgo8v+BLAw15nI+nicRs8TDA8iyYSnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120156
X-Proofpoint-ORIG-GUID: JYLV8RW82XnZc3b18pQ0xDyfMKi7A4eb
X-Proofpoint-GUID: JYLV8RW82XnZc3b18pQ0xDyfMKi7A4eb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/23 17:27, Liu Shixin wrote:
> Patch a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
> introduced a new copy_user_highpage_mc() function, and fix the kernel crash
> when the kernel is copying a normal page as the result of a copy-on-write
> fault and runs into an uncorrectable error. But it doesn't work for HugeTLB.

Andrew asked about user-visible effects.  Perhaps, a better way of
stating this in the commit message might be:

Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
faults") introduced the routine copy_user_highpage_mc() to gracefully
handle copying of user pages with uncorrectable errors.  Previously,
such copies would result in a kernel crash.  hugetlb has separate code
paths for copy-on-write and does not benefit from the changes made in
commit a873dfe1032a.

Modify hugetlb copy-on-write code paths to use copy_mc_user_highpage()
so that they can also gracefully handle uncorrectable errors in user
pages.  This involves changing the hugetlb specific routine
?copy_user_folio()? from type void to int so that it can return an error.
Modify the hugetlb userfaultfd code in the same way so that it can return
-EHWPOISON if it encounters an uncorrectable error.

NOTE - There is still some churn in the series that introduces
copy_user_folio() and the name may change.

> This is to support HugeTLB by using copy_mc_user_highpage() in copy_subpage()
> and copy_user_gigantic_page() too.
> 
> Moreover, this is also used by userfaultfd, it will return -EHWPOISON if
> running into an uncorrectable error.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/mm.h |  6 ++---
>  mm/hugetlb.c       | 19 +++++++++++----
>  mm/memory.c        | 59 +++++++++++++++++++++++++++++-----------------
>  3 files changed, 56 insertions(+), 28 deletions(-)

Code changes look good to me.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Related question perhaps for Tony not directly impacting this patch.
This patch touches the hugetlb clear page paths withour consequence.

Just wondering if we can/should create something like clear_mc_user_highpage
to address clearing pages as well?  Apologies if this was previously
discussed.
-- 
Mike Kravetz
