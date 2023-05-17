Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5D707238
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEQTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEQTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:34:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757EF109
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:34:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIH4xG010199;
        Wed, 17 May 2023 19:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=yLtZGm3YEy1sFopB9MoVMTaejoo9XXNHvjoNGxanCCU=;
 b=vQpSwgff8WSzFrU9Jvc+DDCR5EDS7ri5VR6xATX2ZE13tO2aKcqfEp5PfJ8K14juryPL
 UvWgLQ7lhxsS6/ZJXqOqk7PWk7R6tDEaB66pA/OJ8zqkV96PbDsXkYnZunGB/04LqftW
 Fb9O0Jutno2rthMvqtzVNSc2kl5SQWya59nOQK45f9l0/nlwSrwV3z4h+nnq8anx3wl2
 j6OJ/pQklsovK5bfD+Cz2FrOfN5M++CnUu57+n5Oc0LmqZny3cxdwTnHdjMYgTuGFAcE
 kPpjfdv4XDsWaL1qpbL2GPorFI5HHCoFhHnjh2zlLF1cPugMGKYrDFmPUYy46uB/LiNb Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j14cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:34:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIrnI6033846;
        Wed, 17 May 2023 19:33:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106bnsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id3IIxP089TcMsMUoTe2IKEAhoHbE1faxAAzOyI1MxwzvEs7HmuzPfj8IRO0YbcyaCjEcqiqaEIBv/kgF3RG09BQREWggd54oFqqNHMQw4//krjQFI6kmvNZfw9PfGaBGZ33ZOefB7nxDqK0ENzF483FuglPDddD94smIHscA8U5vtQGipdgfFOXjpvwaGO4sYV16sp8WyUpUjEsxYl02Tb9L8/rBi4B+qtb5z8fSKSJL/IcZ4HnZKQh7cKDTYC1eKNSnTp8zMOtLo5D1urmQDKdq6/hw+yKkSmMkjJfeCSxbQOgSZFzaV+hmQastw3dkdslJSt7YuwRFEcpgbeLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLtZGm3YEy1sFopB9MoVMTaejoo9XXNHvjoNGxanCCU=;
 b=VIkFK1wy0rnqAYekhDl32YQAa5ChjzbGnkwj+p2Ivjd85q2z+hsCujM2ictPAQRdC/75I1Jc7hX1OnmsqRfdblygvq7XQoDWyzn7D4O+zmTZPA/fj3L96vY2C2H8xKJeOSpXBQbCoKuL2gZBKGfHUc+0bawYL1I9C224bXlFzvVFv3EfI/fpcLo0PhzSSaheZANgi5tKQY+b2ZomBr0Pt9fINF/oxKZtxxauDe+lJRP4XvkYqeoPl+QoF+d7aYfcLj+QPx1zN79aBx9Jr8aE+h9YRkv7zGufxn3OCEDxpYmrguGvOfpscfugNdxCQUBKuTzkGl2qd2NAEpzfZ8MvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLtZGm3YEy1sFopB9MoVMTaejoo9XXNHvjoNGxanCCU=;
 b=WB4gT2B5c4Lrj6A2v1QvxSKfVFu20HE75RzNg4H/OpLiUjI0qZkadnt3gdenTvrgZOzUnV9+6wrVI4t8HIZIIVqvNwCyywdkSSeLBqopGwjRGHhQO9WDcPmT6UB3R/Vx2OzkyBJLgzLHk5e0tNEqx1vlHoPrl3GoW54c2U6j9N8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 19:33:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:33:57 +0000
Date:   Wed, 17 May 2023 15:33:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 07/10] maple_tree: Add comments and some minor
 cleanups to mas_wr_append()
Message-ID: <20230517193353.xwd6vztfjqxesyl6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-8-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517085809.86522-8-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: af7e638a-c631-421f-99c1-08db570da81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mud91kJQTTL4ssQrgteHGQ48ii8uWpkS35/FybqfyaJL5X75GAcCPib87dSBWehuNXOr0OEGu05RHn5j5pjtVYg+0Zxxk93zde0Mo29cdAn8S8Jcil4v7ZsImIIY749zanpSN6P4uwzFX3e+RnhmW1wPO9JTlcUen0HFFLL3hKCb6Xzx8bMOyjFXvo0uID21FdUoAd1h8OFJZ6+qV8dzCmnsSSNKqKOi/lFCBorGo1gmAwGTmxwUomC06GeBEClMcDQoVXIPH/nsOWb0lDW2Y9IACIZA3euoUCB9NenC8DTC7L84v/5iBqZv4KM78OVM5l5SkN4ox1HnNeIv0t8mZltvGTRK7htSMnP9h8Y3psawxzuAbequynOm8Z3dHNfMVY7S4HwaJAvZ1NxD4rYODUh7Vxr8i/tYSeOkua/xvFCBHUNvQzryJtzwhc8V8I9z4YARo9yM05avL74VopclMlQIggQo3H/5u1uF+lsCOAd/1RAs/HsIv9C8ReLdpyQ+nEyoQkqH7CYC3mvBuX35Rtg9TWHG4qNCeMFQUcp0cC64L4gF3zsMHaN1/fGWfjGm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(83380400001)(26005)(1076003)(186003)(6512007)(9686003)(6506007)(6666004)(6486002)(316002)(4326008)(6916009)(66556008)(66476007)(66946007)(2906002)(38100700002)(8936002)(8676002)(86362001)(5660300002)(41300700001)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElVfXq1KdGX+vCmgHiP/R9WfRpW7FqWZvGCUZK9/DuRxU/L7UAnMQTrL5AJe?=
 =?us-ascii?Q?S28g7g6lOl8UcbmizlrFpbYZbR7p9JaAvtBhKtgZyagVcMJakecKh/L68jcV?=
 =?us-ascii?Q?Ya4kVP5NWgjeMb/DHXZ3lPU6yXL3dCJT8kgEPivot2pPovbfKktRIUNDKkYu?=
 =?us-ascii?Q?yhNfJa156JhnJpYpDYgA2Om89pkb/95e1rrHLujJV0a+fBeFPyeUothPpInU?=
 =?us-ascii?Q?nsKJdgTOSZtZrS2W6a0o8rCY6L2zuzf8iqdSK7uMs5L1oL1nRMyIallrnzi7?=
 =?us-ascii?Q?VlQOIWCClRXZG/eESGw9EpLsMsNWczWOtfpBFQzxBA1uIOUClQwzHCcQhuI5?=
 =?us-ascii?Q?V3BWIgG13uBtVKkaINVluQvqOwtBfHTYm47AeEr0X0UbjkZMev9T6YRY/jsm?=
 =?us-ascii?Q?dx2oCTsWosJepp6Fbde0lvOrs/02QbmybdRP94/zKh9YTZYR6fy+pv9g5LTv?=
 =?us-ascii?Q?MFL3r3p3YheshPeiER7dPU2fFIrzZP2yf9uVCscdwPqdSumhateGkCo+CMnA?=
 =?us-ascii?Q?uniePjfd+DnujQFfmvrcO62RRcNEnGpmOGeCnndqPjsL3W2KbQyeYv5hJDX+?=
 =?us-ascii?Q?WONBQ40bpFgsAMpA3Yxbm2ZjZvlHnEDLLRwI4bgJh22fBbuw6xlb96UfFZHK?=
 =?us-ascii?Q?GblKa14bUnbwyj01aouBpBINSKrf8vQmo4kjlTQOJevhrTs8WuV0CCBV1723?=
 =?us-ascii?Q?dbaOIXjdgyqNbMdY9s7eFbPTeXkQHMhGDpp85mV49the8/FdHuEUAOq/2qPB?=
 =?us-ascii?Q?Ew0MS5DMKvXHm1IZ2psnroVpJ7k7iaBHtPFa6f9dcKD46vtX4rllgFQ/e+L4?=
 =?us-ascii?Q?5CeIUKyfApz/+I/1tBZiBldKHD6C/sD8CBXVL3F/f3INBdrS5kdbtO+CfhB7?=
 =?us-ascii?Q?cP97K/ea+z2hxk5h6Fnx6Ae05kll4AZTEwiiCZ9hdcuQuDobErmua0Xbbyc7?=
 =?us-ascii?Q?arJxiam20in/WP7yuuMqj4K6sTOAXw/Lr3S55gJTjnTVw1ayqmVGeWdiuiaU?=
 =?us-ascii?Q?+YSvHFY4RqU7/+tLHbtnUbABvhazsKmKXDzZzLT+W8qWyjEy9EmxC3Ltqtn4?=
 =?us-ascii?Q?FWLNcrV6ZC3CYSvaHBNYNHlZYxeH5QDUfsNTqYutnG8jRAtl5HC8KHt/pViJ?=
 =?us-ascii?Q?fGVj9vEkwGbWbKgmImpfM1bhXMvrl9oAG4okY+vJY+4CyMgmaZXOgIiYA7KJ?=
 =?us-ascii?Q?eVzbCgxvL+fZmKvcrBseHRmYYjHumkapbOIvmBDlNRO72Bz2NcIG/+wPfWbI?=
 =?us-ascii?Q?iq98ttjV00XPnkfZABnRckLjIBiODlZZkWVySlODoNYHB8R6YAedu6bc//Na?=
 =?us-ascii?Q?9meogP9ngnQ/qRusw9RnS0h+QGUJXFUttuk5VZrhNgXUzgnNmqXvGAD9+VK+?=
 =?us-ascii?Q?GZfT+yL2RzXyJljI6WNdxMld66HpIggMzdSuFtXiDHbqDj5XanWMc+UI2Ili?=
 =?us-ascii?Q?KEheBBhxQndOjEEixjXlBrBlSa/9aXEhb63DIsX8/DOUbURO8ljVfAhhIPDa?=
 =?us-ascii?Q?biLL6T9rAIuL3dDBii6xtx/DLLCd0G8DL/w2YLJ6d54V8qkol+D34gd8aaUN?=
 =?us-ascii?Q?1npTkNU2Pd8XGT9x33I2NJwI+v+ok+ebqSDBRl/FmqwNYxsPFldQgduEFIui?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KWO3n8gae02rN/VIDq9YPjPy1uEMB9NDzZkKXskbqzONK/bZSnncbPnTrHRL?=
 =?us-ascii?Q?Ca0O5HGGEH8+gFDfr5XjtUprzYAtvOHpgQI/uOz4B3kpXpAx8gUyKufR7h7g?=
 =?us-ascii?Q?LN+/sIfYrHfhJ0smWcWF7Xe4IT60CoVQfF+pLmrO+OoSwjkhcjDypwxAtaDG?=
 =?us-ascii?Q?92UVhPbogOyDOaJqrxabgVkbKEbi8pimHO0s9WVDuvZK4Bjam1uR8GRS69lL?=
 =?us-ascii?Q?3Y6AQAPStd8pRlX154NUJCmhU+Qz28GT2yrr+KH1R2cgDynAjEzEUcfnBIxF?=
 =?us-ascii?Q?nAp9z1pGazCpWR2BWXr8MqMIWhSIAqYFpm+OyQQZ2lbOV4L7z1z+HuByrL4M?=
 =?us-ascii?Q?xlPxp/p3Tmr3pyZZmhytNtRBn5FS1IiN+hMMHYBp99YWeF7ujcD0Smj4TAin?=
 =?us-ascii?Q?vZkMaQn+DxeiRdiG7/Tw5SIg5VhnYvFzHe0GmCw5GsRe5vXMBdSicfHYMvs+?=
 =?us-ascii?Q?WxPL2hbEJ6XwsOuD6Czt8CWbT40q6m4UK3YUn+5N/G+aZahpoGALr5ZAbm1a?=
 =?us-ascii?Q?Mo6yWffoJ2xAVjxqtmGgpYYv3xQn4E2JuPsDMMX4SkI7P8wnJU82otxmKJ/q?=
 =?us-ascii?Q?ZLEHLNWPOzl8peqL0twuCOMX8OeGuue9qSZ4Eed/C8xNS7ziTGA6fP2rrr7r?=
 =?us-ascii?Q?aikRhqXg0fPArXfVA6mEQI2Hog8bnE79AWK4snEesFbzSpiU1H1yLN0vbUeh?=
 =?us-ascii?Q?RlcUUDvTMJXyYr+qf1HkSUGfC9uNwRtB6xEAWkTRLKK0RNkRkgpMJxPN+3it?=
 =?us-ascii?Q?bvNzKoRlXdsPsPIkC2G5Ro15vvg0RYt7tfplHywhXW4Hmai2PIkhSg+jJfrn?=
 =?us-ascii?Q?2kuYA4sGp3cI8MGUPio/8ovgnlygFCVnBvl+oK2c8f0BQYINe2RX/2PGq63O?=
 =?us-ascii?Q?+hZ5YI4g8uotFtXytQt92y+xQyM9gdqDnOAi6hMPgkxOKlQVhA/dBhZr1R5b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7e638a-c631-421f-99c1-08db570da81c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:33:57.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB/kNEJ1n/3KPncrJi+pbZaidFGPukYP+oT4q/v7YtbWaPXpLA+QS39I/val9cFIrZir8A6exGGyTo0V8KlYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170162
X-Proofpoint-GUID: 2LqfozHzZkmyEVSmgBWblBXomHlz9w2M
X-Proofpoint-ORIG-GUID: 2LqfozHzZkmyEVSmgBWblBXomHlz9w2M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
> Add comment for mas_wr_append(), move mas_update_gap() into
> mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3b9d227f3d7d..bbe4c6f2858c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4308,6 +4308,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>  	return new_end;
>  }
>  
> +/*
> + * mas_wr_append: Attempt to append
> + * @wr_mas: the maple write state
> + *
> + * Return: True if appended, false otherwise
> + */
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4315,7 +4321,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char node_pivots = mt_pivots[wr_mas->type];
>  
> +	if (!(mas->offset == wr_mas->node_end))
> +		return false;
> +
>  	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
> +		/* Append to end of range */
>  		if (new_end < node_pivots)
>  			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>  
> @@ -4323,13 +4333,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
>  
>  		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
> -		mas->offset = new_end;
>  		wr_mas->pivots[end] = mas->index - 1;
> -
> -		return true;
> -	}
> -
> -	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
> +		mas->offset = new_end;
> +	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
> +		/* Append to start of range */
>  		if (new_end < node_pivots)
>  			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>  
> @@ -4339,10 +4346,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  
>  		wr_mas->pivots[end] = mas->last;
>  		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> -		return true;
> +	} else {
> +		return false;

I don't think we can get here with your changes, what do you think?  If
so, we can move the metadata setting to the outside of the if/else.  I
checked by adding a BUG_ON() and the test code never gets here.

My thinking is, we know offset == node_end and new_end == node_end + 1..
so we must be inserting into the last slot and only adding one entry.

>  	}
>  
> -	return false;
> +	if (!wr_mas->content || !wr_mas->entry)
> +		mas_update_gap(mas);
> +	return  true;
>  }
>  
>  /*
> @@ -4382,12 +4392,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end >= mt_slots[wr_mas->type])
>  		goto slow_path;
>  
> -	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
> -	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
> -		if (!wr_mas->content || !wr_mas->entry)
> -			mas_update_gap(mas);
> +	/* Attempt to append */
> +	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
> -	}
>  
>  	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
