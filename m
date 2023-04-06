Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F56DA4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjDFVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjDFVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:33:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3CF30FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:33:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FC6Aq004169;
        Thu, 6 Apr 2023 21:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HDSXSayFepoXOS6vggL7BR2L4CmDkkTvc4TLVlMRtNM=;
 b=eJTvOCzY+GyGdZ39+1qIB+Lnh1T9Ky65A38h6xDzygqvWtwbMjdC1IONBwXGvnIOGL08
 7k1VNEEXL0VIRcQkfhRKPIjLP4qHD4UyJ33nYqc4gAh1gUpH5EJm0pv100khIxpOBi8x
 Y0PwSUgwQ5vpm/GE9Wer14cr3RqaQAz28aUloXhvamTkYNwKLHBgMdOvsBS1AYUb0IcF
 qaCQ511ZrnQeGmBeru53F+TayKgC0s2YR+PJ4uGYNP8J9xjUj3SuG8PF852eBg+EFBTD
 5tFgQ0xvpjafuNef26FA6uUqYo0e6CeJde52mo5YQG9dsh0BgWWXBAD/4CXrPWnx2pQK og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71v1ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:32:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Kp6S1008979;
        Thu, 6 Apr 2023 21:32:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3kmhu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9kTl2JbkCCtG7GJL4bG0XbO/BpYmPDO/AErXQIAEOuH202agQBSdMDp+Sp+Dk6d5U1w6c91Q0lnOLRAATTHELd2/Mf3Hj4DYPavVk4PvSqBQ5AzHyyYxe2n/d56f4aTA3IxsFfk53nsBfUuNt4WI7iQvhE3DkF9ehO+EsjUiwXBBRdE/QphmroqPtlcwHApWwABS94tfwjc5Vd+0kh2SL9G3M5XXAxIbxLKrXCIVC6/R4t1xh2wcLgTaWCd2fWNhN/JZoJHC6kPnv7hUEdhowHxQ103HRkHY+dbB2RZM2l9ZJMrUJyKoFDHj0equ6A6y+xYrjM0f84qYtVmBaupSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDSXSayFepoXOS6vggL7BR2L4CmDkkTvc4TLVlMRtNM=;
 b=jNEQXOx4CQRguWmVoZS+XR2XBCl3NT9H7Zfe3oN5Cu1DZtitW9OMG79fc+YxRCOWdq167ByWwHClh5UeBCCnEdv2w9/WWeYvRbCI6moA7hdvHpjXTk2bYScQOtQSmJQFbR1kRr7qenfvxsaFiDbi9J2nqHGuK+vJEerwUjeEjweqaXaZCT+5EqIN++3BCGj5FkqCZvfyJlEJuEKc4v2vNiAoAHJ203w9OItZd+f7bW5FCULyFq3TYoaxgs1r0Lu8K173S/b3J/wzRoTbnpsCdKn9g7pys9EEjRgxfrX2XnwmsLgcEVR4mjzRJZQC2dTcO6ogXqQgALm5TBBg5XZnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDSXSayFepoXOS6vggL7BR2L4CmDkkTvc4TLVlMRtNM=;
 b=RD2hJxMG6G7NYARupJUiduJYWWBSn97DyVToSifUWtZfmu19BAn6kWz7ZyKHrhFvozdg6PM5/vWaRxwg+gJEXSXbUsFDL97zODU63U8JD/wHYPTrdlwbhPU/d6GuGtkI0qB4x6s3AosiTVWDEfWz2ZIdwl8IttsBEqPsDUpwLmg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5220.namprd10.prod.outlook.com (2603:10b6:208:324::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 21:32:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 21:32:36 +0000
Date:   Thu, 6 Apr 2023 14:32:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 2/6] userfaultfd: use kmap_local_page() in
 copy_huge_page_from_user()
Message-ID: <20230406213233.GC14244@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-3-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331093937.945725-3-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW4PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:303:83::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e756c38-2ff8-4511-a600-08db36e670a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVqQc5dltxMdO8kK9JCoGOspLbYYKMmFA0xix3QTq9w5N0T4fmZbvdTwF7DcG6wXYX6fxz/EWA11z8zG5gSsF5Ugu08UgV9zYs+lfeDtW70dUkaFe05wNkgWOYB0S9IOqHz1oxISCsU4kKQXEbWm73lv02RXhgaamwTWcTGm8e92QPeM2X1zsz5bCMkAFZ07MXavFss9RRga1qWewemY2BuEy1JkhUF8xJdfDpNeM58wKlvlgItd8qZF+nD8TnZJS1QyWRKXAuoKQPlv3Mna6Qtw7vBpPtWZwKf20FEi+w0Unn9Mcvk6xEWQPY/iaZyyXNM8GoWe/u83KjOPniYJDUSOCbyM9/BUqJohqK1dgFhhnzypRTvLzXNQ7qc36QW6/TYKzm7LZo9ZQJN1kFZhbypbcpA38P/1JJO9TJF9wpJKiwQnUxoI925hhBXAebeVG08aS0HVNO4rTSxt5lvWhWIaiLsfIzCfjgyhPogRN1svbObfX1E1tYLotGbatROVrsGen32SwfsjV62hYnR72btNLBZh3VAHdhSs7JvP6s09ylJ6e6lglDiDZNK4Bmsvn++ibeiUCMzMA8vzpUyXJtJlqzecmzWGKLbMvYGgvQC1JNCqecfVfR3QCq7+9a7VSqLtLy+zPfke9bfJwHKgqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(83380400001)(33656002)(86362001)(33716001)(38100700002)(478600001)(6486002)(316002)(966005)(41300700001)(8936002)(5660300002)(44832011)(8676002)(4744005)(4326008)(6916009)(2906002)(66556008)(66946007)(66476007)(186003)(1076003)(26005)(6666004)(6506007)(53546011)(6512007)(9686003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtRmT8YGJXUx+YW+2Jw2DgO8VRzSPAH0IyqqpAXJYslr8g4gFwSSySF9feoG?=
 =?us-ascii?Q?5G/WBH3M5LwXrn9eb5syuAAGm6cnlyDahiqH6+VGYNUdyIZwrV2CX4/Oyddl?=
 =?us-ascii?Q?HtDWyrCjzg3Zqj4E1EMV8he15dxwy1YX000W/LqcDit59R2dLkOs0CD/OpCx?=
 =?us-ascii?Q?KTMpanC4s35MxR4ziNkWaSw3b+3L+iN0SYewsVUtsrfyS9YBwZvcK0ZNtms8?=
 =?us-ascii?Q?JO7lihu/4StcBNVaAe2qWwRNv8ac+tC7JlCNYcYge/uei+oTGiT9Drw7OUbB?=
 =?us-ascii?Q?ghDEqXX6BqYmnJMJnjF9Of/yCCxtGpbszF0jb5xmv/LZ3KCHFbQnEju4nr7X?=
 =?us-ascii?Q?o6FVIN8NVG2vHkCOOpu/fmH1mXvUfq8L8Qa6yGMbX22hkyE9+ZsJwWq5dbTT?=
 =?us-ascii?Q?2ANGFmBjhMQyzPjbnAZdh3iVsg+C1EAbfBuXhZKtNf43JJDZJlsl//C5q6Xr?=
 =?us-ascii?Q?ZOr4pMNCfa+SU2/lB26PhRy+dya7d7kQZCYUYSSlSonvWsykOvN377Vrp4q8?=
 =?us-ascii?Q?h3H50qBVg/LBdDRIG940vRNzncV1gKtYBVzdDTfL493DMuo1Z++axbxSM9QM?=
 =?us-ascii?Q?7BjUiB62uDsoRtzjqNwhVI1tuYv7R7W10J2eIWV8oADNRF6vB1kZcM6P0GVj?=
 =?us-ascii?Q?JUQsQ333xi4qOsyp17Qk5MelpUQnFXEydQpYrhtmFgeZI7yrYZwNmj9m7jnQ?=
 =?us-ascii?Q?Am/+wprInc4G6OI0GR6HrK+3IVyuLcSPsRYt8XEkzsytZ6vi4l15G76TLhfm?=
 =?us-ascii?Q?DZepHPRw5d8tMFP4uDMFzkwN9oUL1G9fx4Kst6z6bFizDMz+LYtWZSVJxU7W?=
 =?us-ascii?Q?W12Rks8SIhKR6Ni4IZc+Pu0+mqoKC1A6OCCVWdeLyZC+xPUpZt3kqoc917dD?=
 =?us-ascii?Q?q2ZzbS3JEuoPWnYZsrFAB9kOcKSXQlR+hYbeRczZ//H/E3muYPIGDW9BiBmK?=
 =?us-ascii?Q?hZdIvI325BEbPghE/7h0OUT6H2Prl5Dys8C5qDvkRZfGJOUlCypcvnnuLEEp?=
 =?us-ascii?Q?j0xhXuSjaZ4Gt2BhCXEWdLZwByaYiKwNcuV7vrAksa9OeOLVQrZt9Iv2SOge?=
 =?us-ascii?Q?U3YAOSgBIWnRXPr/Sp06kbjFmlS2Le6kTu6HUdzTkc39CD3N6HPvrCFSMI52?=
 =?us-ascii?Q?3KhTZG5N6jUV9cdF/vQyluEHGnZxO/LJa25y9vCdlIG897UZo8c7ob5xCVl3?=
 =?us-ascii?Q?MRHjZ4kjfjy6waHA0tSLg42Z4mkeVJe5fbEp++2fzdWvYaKvKsWNZyo3d4Va?=
 =?us-ascii?Q?+GVRtEleauI2v90CILN5bTadJyJdDSuTK9U+b5OB1ag/NpwJKhDP6MmAz+4I?=
 =?us-ascii?Q?gNNYLt3ubCMp4vLqXaygQxDydPBcX6n8VUrx2gq45cK6/7v+UU5WDT2uvOKM?=
 =?us-ascii?Q?sjSce08djA69NxqD7hzDMzl0kdUAX6LarnrqGJW7jLD92BNZu+VvZoSF+uhf?=
 =?us-ascii?Q?YJtXv06zg4gvhjbCNrYx1tuPWieBWruV0MFk59hJg/2D3wxu9R9dwRmUWk3G?=
 =?us-ascii?Q?hIwrMxM23+bxmxudUq5vn3//V2oXYOaQqYnZIPi5MEhy9QzCyLkVkqSAp6FE?=
 =?us-ascii?Q?jKeXPn4D5p3v1lXh3npdIi0xgtouhpu0DenjM26PhLeJ8thglL/+o2MrozIt?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ECXZil5UpgP3pJDtiMQEuWTAaK0yN/Zk8zLc4bhMj6kpG2/XloxivrqoCPyR?=
 =?us-ascii?Q?esL/hlR69JaiUdsqPcJNype+6M4eWZGndOatIjB2e8j5DW0SSovXKXH1seqC?=
 =?us-ascii?Q?9ZpnVL3OI2Y+4RehcvU+X2szeNenWYQc6ujJK8gskvvOmkbb8dRr4BXXNaWT?=
 =?us-ascii?Q?4eqTpbrsp8MHOtp+XeVXL6CRu9/lBQQhn4u4nM5jnOCEQpahLS4x346bRKnZ?=
 =?us-ascii?Q?fmqwx/y3G3WzVbMvq7ieLyCJ1h6AJaF61jhBaj02hu4bAyYM8hrFIxPe52ID?=
 =?us-ascii?Q?TASpXempuBUO/Y6+9tgwst59zJK2lvRZn+Kc61BFVJ59x2mMXX9ROPTkLTds?=
 =?us-ascii?Q?2izOH+158mQj/Yu/Jri1tX8f/WZ+f+Y5goBhgyDGyrGEuyWe2Nzk/tAAZE6L?=
 =?us-ascii?Q?i7mZ+PxeCrv+p1M4MVpKItfXsrvJnMlHB+A4itkYWcypHegAUk4fWxsazkFb?=
 =?us-ascii?Q?8bZulfLgakJwnCKv+2nuzsNwR4sJoEF44DGkcAC/FWN+K0qdd5HOu9lKN0fI?=
 =?us-ascii?Q?ljCQx3IdMp9gvF1XB9PBkOAVBPEW9kVIAWcz+kjtHw2R72Wl00ioMt6Ke02d?=
 =?us-ascii?Q?mVUN555E75fae8O4IS4dY1kQ+Fd5W9jQv4JaHwIWnmcbzeSzcw6QXauUEIp7?=
 =?us-ascii?Q?2pfpIYyd9SOZeoNv2kHkwSgu/Ftps+t0nvDn7hUAczwmh/fWuGHHhxUcZpKO?=
 =?us-ascii?Q?oOLrCJfsgt74hAopNkkb3N7nfrUOJzufE95TjGkTi1DFztp796ewRcxL19rc?=
 =?us-ascii?Q?XkRQWB715S2VwWPn6X8GNrMQOjMxKeNfO7QX6h6uzr3tpAIwf0Fc299fN7lk?=
 =?us-ascii?Q?spfhQ3cX6A+30JLauwXyPhjo9BasrhN+A+p0ptGJ8bnbhJEewWYtyuZLojkU?=
 =?us-ascii?Q?vgQk4M+6IC5cQzHOQdID2QXm/zoudvQmpSw9ugcv7n7LK6jmTq5W68mIAE42?=
 =?us-ascii?Q?9iV8cBaTSEZXVZy/MjNiXA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e756c38-2ff8-4511-a600-08db36e670a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 21:32:36.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xbyZEbCeJTHG4Ku5sLraIrIdTwOJNlEbKd+shwlg3agG+bZfUaAGqcCmtK/xDZkNAj7tfd7/X4Ai2uX4efCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060190
X-Proofpoint-ORIG-GUID: FpGMA8u83IwNb2zP2FHxbKKb-oQn6HdK
X-Proofpoint-GUID: FpGMA8u83IwNb2zP2FHxbKKb-oQn6HdK
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
> kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page() which is appropriate for any thread local context.[1]
> 
> Let's replace the kmap() and kmap_atomic() with kmap_local_page() in
> copy_huge_page_from_user(). When allow_pagefault is false, disable page
> faults to prevent potential deadlock.[2]
> 
> [1] https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
> [2] https://lkml.kernel.org/r/20221025220136.2366143-1-ira.weiny@intel.com
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  mm/memory.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
