Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACE607762
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJUM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:57:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA321E124;
        Fri, 21 Oct 2022 05:57:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LCliVd018993;
        Fri, 21 Oct 2022 12:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=BFAlD1ezRmiHqea11xYMkcp7WYsx9e7io/0S5rrf4lI=;
 b=PH+4H1gy+h6/+HP98J9wT1vp0NwxUOZbu43LtxcRkR+LYqkfLiEwR111Fxo3Vm1C8V+Y
 2tdW0Y+3p3EhUwOMUSvJj29cVGgu9yi+j8cDY+BviK/+Yz1Gb6+5C/WSnRpsoMSZAeqo
 WwuSN4SpWLv3jD6vUf6lLSXfJgPLk6EC9DnIgZNxMG//29bkQwY+CtLlT60R0I9s+8VX
 6pxf3P33pWPFXNxL9+hqY4K/5w32esGfJpWapYMOZpMLp1lKt3JkbO0yZeQGDuUUW3pM
 DwJJUSYz2Yj37DeBcN7wN19uCTXUiLdwaMsKkBmT67c/3LHZ6k0s8WRnyJpXWTua/Zh8 Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3r5mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 12:57:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LBno4T027377;
        Fri, 21 Oct 2022 12:57:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htkjp0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 12:57:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+2yXdhtH+LMkHU4zeoU5fTkC9nvQpDLW7NlEC2jIIta3pOZpsQ89BvVZAJhSmpIFuG2GNWFzam+7ICTdYfs+tuShu//37Q1KEw5UrFbCqGc9KFfZT5mVZS7Jwele1cTfId73B3hUCVzaUxAAXe5LgKA3eftZnPSDc3lczsO13bptC20h5Ux3bhVtAG6GEK1JlgoF7HlVHq36VLVoe3VltsF8MCWXmvI9i1KbvibY4v3eiqHBmUa7IMODdZ60OiYBI0y+cZWQzrKm3OLu5DuiGrBcXWoWQIDwkIWidZBvTGFAbuwCCLp50qzAJE5QpvrLeBF5uJWL6COuudcep6uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFAlD1ezRmiHqea11xYMkcp7WYsx9e7io/0S5rrf4lI=;
 b=j8xFwmWphngt7FAn9pomQ5P9pfL2/PMetuZXtl65enunsPNtsEflPrkQzoN4wAekDzWzOSuCA6mo/8WGG4XZ9VF62YAzFIrLruF8zsiSq4IQQvRsgfjCC98aibhzrUGDysz2AUqiNPb66mt5Bhc2Er4eY/OXSn/fzrIIDdwVFH5H0yuuW58JZQRb15WgcYEOktwj+WF7I1WjYTBaJyH05sPD6Oy4hkkQowENYxMBr0XRCJzje6wLJnikjpgcZA52HiypydSMin/T8L2HG+6uPTgh0jjQgIoPffhf1H4bgKCWRci8wcLmzcrrWeV+JfJdEcQppZmTTASPvJSxEMYUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFAlD1ezRmiHqea11xYMkcp7WYsx9e7io/0S5rrf4lI=;
 b=VIh4/ksJxKjz1OK9vhOm8K3mh1VlfyxDTSQFJ5hsQ3nJGinzRqzoTtjM8akw21Zg6/Xg5bSESoCzqxG3fUMo9hRqpw6U8bdwKwIc8FhX2kI66uSjN7OujeE9R9H5qJhikX1PHVwAbsSkD8Dk2YGaa36HP7KKMB/YX4FUjdd+7+Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4471.namprd10.prod.outlook.com
 (2603:10b6:510:38::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 12:57:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 21 Oct 2022
 12:57:14 +0000
Date:   Fri, 21 Oct 2022 15:56:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Paolo Valente <paolo.valente@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Subject: [kbuild] Re: [PATCH V4 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Message-ID: <202210212014.ynAHDVJU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020152643.21199-2-paolo.valente@linaro.org>
X-ClientProxiedBy: JNXP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b04b673-b817-4636-3da9-08dab363c670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDKNZuiG/PtCrtlHI4RH4CZK8zAXqbCokBTkqce1TrjR+eNBk1ZYjzCa/Zq5BHnlcEATLeQ3a61IIvgEd9G/S29d+MMmHwtWu7Xjqp3EOtpFXjxVGSxBn3Rb2koFse+4tjhvA5L7o4lzLxvZdT4dTa51AuS4oseZDT/hmc5/ov3J3fuQjW7gsa4XmEdpL1grG3E+Ci4H6SE+a0ETiIt8TiR486Cag6c0Tq94lzXk00BxKFZTuOjoBaFJhshmije53qFJuBk48dTBg/cq9mznWvBYfu36XZ2aTjtMrm7Y0GIW/FnK7vZZJKzL27sQSokVHa3HCif4pgXqjv2A1AvX/umpYmBml77snPhJSXm/oWg9HXx1QKEy4Co0ATFDMmew7wOCD0KEusTMRuMQtq0xaQv6mKBlcfOaWfRivlQelLaewnK3lgARQROAj7evgjgxlUmYfQbmOhHE7OEen1PUTHib+q5ZKW7uDcRkpReMPzg9e8Qcbbt8zc7cgYVpbNo6eGSPnB1kWfvophuhuNnajI41mjCikIhQTaAz6iDE8NLQdwAG26CDcT6k1iyXd29cjXKfSrj3p8izGLdDbxqn/KvbJEM83RBcarJNJ0sk7bynFL2a0nla02DvSdyt1uju1zy5I4M8FLe5MaIyN4jz9ZI+dBbReP+zdKYq8xDmUsi+atHuw7jN+NYfTE7ByDbC7irw95w7AwlN6B0fKGfC4gnVhl7XKpZwxfP7vPygLaYiGWKYG4N2/JwI/x3h2zx41mluju8vwfP69KhmBQ4vFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(8676002)(66556008)(4326008)(966005)(66476007)(7416002)(316002)(110136005)(66946007)(38100700002)(4001150100001)(2906002)(44832011)(36756003)(41300700001)(6486002)(8936002)(6666004)(6506007)(54906003)(1076003)(186003)(9686003)(6512007)(26005)(86362001)(83380400001)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDrx8hD0RTPrFksR9pSXBde0eB/GZ3Qg+GA6Ty3/E07g9hY/nCn28lTo6iTY?=
 =?us-ascii?Q?v3Lf7VxCqGNpY7br5rbro+17rWavLxePEmkolO54BqilYg3J4Za2qjUtilBL?=
 =?us-ascii?Q?eFpwXxE5M59f2KkGBDRiHet+xhbdtFnb8aykSUZdTBqE4rKH1iAj5jZBAJwd?=
 =?us-ascii?Q?idimmdqmEbZIeSch1+/3oiIpYRWNd8XhOBqEsfgiIPA/2ZR0olewAnM2eAXw?=
 =?us-ascii?Q?Jn9lNXe42kH1/qqbIZqGCjTm1X7WPWoweRjPnC7aeG8x3BJQhtzBJGrK1TrH?=
 =?us-ascii?Q?hRMTWf+D703YT+5cjNKjENM7Ara5vJQ6/9eaLwk8PYK0af9zbgysu/ExRGLE?=
 =?us-ascii?Q?Bj9WO7dp4hgCF7LlBQ4SeDIR2lIcvlEFC8VitGd3o1ykVPB2yQVNPMcWCdXO?=
 =?us-ascii?Q?GsAy6q5sd2uvyzVbHuxIv27Dicfj8soCrzTXV/ZQ5+JmktSQM/8DAB2j8Ar/?=
 =?us-ascii?Q?Wg7v/ZGj3xGN0GhQH1agHToBxWJIbtIgxX5Bc/tS1257tAL2xCdcQdSZzqom?=
 =?us-ascii?Q?hNukqmwnTfqcxM5COVH79W5DfNjAO5P6fcHHPr8oWe4bRX4ocpboKkhVx4dE?=
 =?us-ascii?Q?lsu/HApaieT/Kn9OfR/nVeQQZpzluw+R31uP9xK3VIxc928oc6O+0XtzkWjP?=
 =?us-ascii?Q?An0D7WOWbYHYEFGOxSGoj9fKHGB1s2I252PWp9xmnVDShqmICDe9v8trnQ51?=
 =?us-ascii?Q?d1wxK9nMeqN8L5li2FbkMAiSWgK/qw2sbqbGdvz4fD+La/ZNTDRzV/4rybmm?=
 =?us-ascii?Q?dukId1SBINmp80A/8EyfK97RiCDe96coWvRiY2dydj90zdjwwKpJoTpVWz1W?=
 =?us-ascii?Q?GSXIyaTvPQ/pzXLDvrc9PxXPldccBZBv4I9CKEQP91FSN402XUJWsme0/8Sa?=
 =?us-ascii?Q?OKTm8Ouo/sS2ehcrX1nASFzcdNF30XTD/BMOHtg5aBuhl6cQTa0hiVEVgk+8?=
 =?us-ascii?Q?N0oyw/JUX4HGfJP+BM0jAe/TH8Ne0aaAOLnCHR6gMD34VvvGJxi5zvdNkCf7?=
 =?us-ascii?Q?+nt0fl4qynDfI13zXng8/bTLaE3C5GTFd0AR/adpju/N0VnNY3QP8mG6TLca?=
 =?us-ascii?Q?uGXUM/sWldF/RxRJvyJRneuzAnaK4uiYRdhfHne28KuyvjhFnvd6ukbkK8k4?=
 =?us-ascii?Q?LCkBsHMu2o8bz+0zmqp1U9BXoFDIXEBsFAuOY+CT0QVoTQmCCM2S08F/7eSn?=
 =?us-ascii?Q?wqk0xZh4UFdPA6pr9deAwJMMdOuqmQwS2uKT3bPPNa7YzCLDkuMGOaJZjTz3?=
 =?us-ascii?Q?gvbQTkKC2zRHUzTf7ROftZEF/u6aw6SZhnqMsjyfxSryMPGjA4me/scF4HnU?=
 =?us-ascii?Q?FVeniomQV09G9/l6eCu8BMGKOpdRWYfuOh/Kr7rUbl9nM5zIlFOmuNfZeajN?=
 =?us-ascii?Q?tG6yZCDB8RqBA2Toc3FK39Mf5HDHBG8DYPTgbf2AJLmZvvlx6aNbHXjxNipe?=
 =?us-ascii?Q?bCiC6yj0rgosIFKA7QyhQwS2QyCMgpHYqEkzY3vZWiV7PJmYrN5sMFWt0Y2g?=
 =?us-ascii?Q?d6ONYQXT9aJUCKHi8pm0gtkuGPLC0GsFI4W8/8qLrDRuTSU+bjfmuFHxFmJQ?=
 =?us-ascii?Q?IhZo57OzT3gGKTR0xg4pWDLLvRTjBZcKMmFKcuwiVToRxxL05ImAlwSejYxX?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b04b673-b817-4636-3da9-08dab363c670
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 12:57:14.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r54w/9BoYDkVsVzNvzBRb/53arjb8YvhjzqS1J2tS5PsLNNIxjwzqmvEX4D5ZjysmM66Axqk8+8c3s0GXT2Sm3FFdTf4lk3A8xnIMLbD5/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210077
X-Proofpoint-ORIG-GUID: VLiabWRmYnnj9WjjSaJKz7XJo9xVO5Y1
X-Proofpoint-GUID: VLiabWRmYnnj9WjjSaJKz7XJo9xVO5Y1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

https://git-scm.com/docs/git-format-patch#_base_tree_information  ]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Valente/block-bfq-extend-bfq-to-support-multi-actuator-drives/20221020-233011  
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git   for-next
patch link:    https://lore.kernel.org/r/20221020152643.21199-2-paolo.valente%40linaro.org  
patch subject: [PATCH V4 1/8] block, bfq: split sync bfq_queues on a per-actuator basis
config: openrisc-randconfig-m041-20221019
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
block/bfq-iosched.c:5423 bfq_exit_icq() error: we previously assumed 'bfqd' could be null (see line 5420)
block/bfq-iosched.c:5431 bfq_exit_icq() warn: variable dereferenced before check 'bfqd' (see line 5423)

Old smatch warnings:
block/bfq-iosched.c:6115 __bfq_insert_request() warn: variable dereferenced before check 'bfqq' (see line 6111)

vim +/bfqd +5423 block/bfq-iosched.c

aee69d78dec0ff Paolo Valente 2017-04-19  5409  static void bfq_exit_icq(struct io_cq *icq)
aee69d78dec0ff Paolo Valente 2017-04-19  5410  {
aee69d78dec0ff Paolo Valente 2017-04-19  5411  	struct bfq_io_cq *bic = icq_to_bic(icq);
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5412  	struct bfq_data *bfqd = bic_to_bfqd(bic);
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5413  	unsigned long flags;
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5414  	unsigned int act_idx;
430a67f9d6169a Paolo Valente 2021-03-04  5415  
430a67f9d6169a Paolo Valente 2021-03-04  5416  	/*
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5417  	 * bfqd is NULL if scheduler already exited, and in that case
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

fc8f914d9fc5a0 Paolo Valente 2022-10-20  5418  	 * this is the last time these queues are accessed.
430a67f9d6169a Paolo Valente 2021-03-04  5419  	 */
fc8f914d9fc5a0 Paolo Valente 2022-10-20 @5420  	if (bfqd)
430a67f9d6169a Paolo Valente 2021-03-04  5421  		spin_lock_irqsave(&bfqd->lock, flags);
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5422  
fc8f914d9fc5a0 Paolo Valente 2022-10-20 @5423  	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
                                                                            ^^^^^^^^^^^^^^^^^^^
If "bfqd" is NULL then we're toasted.

fc8f914d9fc5a0 Paolo Valente 2022-10-20  5424  		if (bic->stable_merge_bfqq)
430a67f9d6169a Paolo Valente 2021-03-04  5425  			bfq_put_stable_ref(bic->stable_merge_bfqq);
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5426  
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5427  		bfq_exit_icq_bfqq(bic, true, act_idx);
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5428  		bfq_exit_icq_bfqq(bic, false, act_idx);
430a67f9d6169a Paolo Valente 2021-03-04  5429  	}
430a67f9d6169a Paolo Valente 2021-03-04  5430  
fc8f914d9fc5a0 Paolo Valente 2022-10-20 @5431  	if (bfqd)
fc8f914d9fc5a0 Paolo Valente 2022-10-20  5432  		spin_unlock_irqrestore(&bfqd->lock, flags);
aee69d78dec0ff Paolo Valente 2017-04-19  5433  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp  
