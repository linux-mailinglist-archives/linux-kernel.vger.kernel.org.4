Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379015B6A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIMJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIMJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:16:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29BB50
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:16:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D9DkLV013046;
        Tue, 13 Sep 2022 09:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=qb+2BWZj9+ZWrA7ydX4mOo7g7FFif37vj3lZLkH8B5o=;
 b=g7di5p7JbkAWu8kMuVOsBFo0cNtvE/zwAgC7L+8e9NJmgt2UUMYODt6qw4CPhE8Armrb
 1weX8R8/oNfUtPhmh4/1oUvPv3QBq8vjBZm9p2cseLefZ2OHJbCtajPKfCROtrn4yp+S
 Hn9b/cj0lN65wkA0XcpkH9dLji+pOyzFChY5WeZu/bNRmtR+xGosjaQpIRI6XPeGN0Ms
 9Ijq3wlIV1EfEum12sfrHd9RETibqh9SxZz27ielwQP4Gq3iLa8zDjw6s5LjuWdDWq4Y
 Qf7komGLlVsM2OsWN5y29r/cs2iN3Gpf7++IM+qLAuAnlJlvcLr30UFkt+s/3Swssu9G tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgj6sp5q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:16:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8UCJm011351;
        Tue, 13 Sep 2022 09:16:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh19scm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8evt6doD+YavcbTJpzxUb4wMJDScDRtNtZOf+C0UeVtpaaADjvSc6irqsHMBn4u7vqfaV7GdBifTfHrwiTpNpSHBL7J4cEy9y6VjfA8ZNlN5nuddjcThI+vFfMBncxgJ5MZZVfeMZJnq/ga+f1nAH3VooCIxE38XTxbJGqROj0z2nv2b+gWZVlqyz7ev4hmQ9h6aMkg/zZc39H7m3MsQarPLs4e3PYp/Ur8E59zhNZmUgMVg5AvG38UaK5EIY6H9mnroYYxdEfDcBSMAG90WX4v0Q3mXWNqoF/8grZQ2QnY0Eo7M3E9zbEGZFlsIJ5oJnFApO+HtlIHoLVZsXdKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb+2BWZj9+ZWrA7ydX4mOo7g7FFif37vj3lZLkH8B5o=;
 b=GOnU5zF9R8VwhujorAPOXGV1HPUXg0R93LnqKM8PQvER6T3dcLVqWHYqvkCLyGx+jeAlWRwbrhkANp+EWRdafGBRbRbcTN5fySXIetGToy2Z/7+VKXpNNLJt5VGrl9Wshs6dHQ75SpqDI0ADMrEzdAReJ92m39WqFM5lErh13LQfamwRbgbrdrQdAgRqwWclg3+Vgf+k9dWDApqZKg2rsFY2kcvpUGFUJ8hzFYygJgSg1mBmsoIyoqA8uucTW4prA3DgRcfNVSnjF6XL/EfhVkc9yO+aNscNbjVVQ9JXmaxXZroopsHtR5T/NQwhrsenCOxAYfncm22k7iBlETMPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb+2BWZj9+ZWrA7ydX4mOo7g7FFif37vj3lZLkH8B5o=;
 b=oJcxCZ1BdC+78YN+rkpFsKYEt9rqhckj5u4wlwlfZ34NKjH6M9XcVMPeB/NWQ/UbxvGdWj2RLbxisd5EeQz+WSAUHUj2RL5H44qAbF4cmgqzJ/jcaTQNuRFmbQXLUBLUPJFmmuLy7+f21jwuXoO5/dfKPUtRiUrNk/WfbZo1PHI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5370.namprd10.prod.outlook.com
 (2603:10b6:610:db::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 09:15:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:15:02 +0000
Date:   Tue, 13 Sep 2022 12:14:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/printk 16/29]
 kernel/printk/printk.c:759 devkmsg_read() warn: variable dereferenced before
 check 'user' (see line 754)
Message-ID: <202209111308.tUVWzQJe-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR2P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dec40c-7e90-4fbc-c7cd-08da95686fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDpU7H2TFgDJUxvKZ2tBm3z0psGZEbYVccwgillcwudFBw6alrBTGRcs+7a6oVmGnNI6EiW09YmaYew/GLrtiJ0tiOdTogoQz00M4aNVMmT2IY1zh5ZiuWOPmaaGIsG19jATfcfGhYkmlYTIV3KQ61izWDI00XiJF2onBYuTyUt8L7lY0gajQcG27koIlSOibUvqNyf1ZW2gkw4LPcWRQpwSjfcqJ8IQvjX53bK4LrqqaT/2dA4NIsb5YfLxc0tDYE8sUyPGJSMdFTgtTTYcpdfGLVjaTiUSsbHq0mloSJsimjZ1uMcww7mj/GJlDzbeMlTDuH1M/+cjJrdvsIW7l4UcTRycidTcQ7FYStItKD8/Q6NC3FkRAaLG8RiYnWPiLVq7pWPu1wIbBz+2HzGi4pqgYpyRidoUhZ/9kAqL93JR/VOYqMW4/wNh0IXrvEPdiUj83SPd4xCXIqHFhkFv+p3vzehjuaklNlEAWqPtT9A2u2FV/ZHNinx5n3GYnJRy1wIkst5zxDiOFWyhQ6SyLLMeMmMBVLrCTDjkjYJ5Wij1wmTeUuG77TS+jUBw7HPboge9adqFHGJEeFP9tMBYe8DADZUfstb4pIPkTfNAbTqV+UM9YxGTXvVuqTj9vYkYWaCr37aG0Fel2LdYDH+z1zk7xDEPzDvVe1DL5+PJAvh7xp7NRI+MbV96yBdQ7IuEluafeGccP+L3dNu+npmcsL7wjqV9z4c6WS275nFdGAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(86362001)(4326008)(4001150100001)(6512007)(8676002)(26005)(66556008)(38100700002)(478600001)(6506007)(1076003)(9686003)(2906002)(6486002)(41300700001)(44832011)(5660300002)(316002)(6666004)(966005)(83380400001)(6916009)(66946007)(36756003)(54906003)(66476007)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1wRfyoyK5+L2OCSnZNjMSdbIoOIRUiGRazNyb6frPKwPgcKY/f8TtmtqgAr?=
 =?us-ascii?Q?geU5O21/znscT3tbpH6giwYvksuUrl6tton9A/xACBzovBtcrvRBzOvJfvwA?=
 =?us-ascii?Q?EuukmbX6cL9iT0ht8x51lO8kEVZEyHXhCdMI+rYnpSVCWm1VTOPb+oqlWmPH?=
 =?us-ascii?Q?OrRU4IVO0lgtd0qzQQjmgUSE2EfNmZBn34WJPljlga9HIHfpfuAK+SkdRIcU?=
 =?us-ascii?Q?zrO0bnButfyf9j72uKPWfbCLLFhJ8wIaPuuXxBEhDm5X7LUjpdmAYlnSHyQf?=
 =?us-ascii?Q?JjcvCWybT63Qa0jcpgGgLUF/XhMNmOUbeSX64HZfwVzK52wvs9yzVxwRNOUZ?=
 =?us-ascii?Q?AhOvqixb+YHXscS3G1CpGr2PyrGjp8PNJYo+UkMkdmS81wt9L6bpOO5Nh040?=
 =?us-ascii?Q?Ifo07MvMuj89woR0rbt/XT8/pctYmMjjRayz204G/FaGgp0kN2u0y0t/5OH2?=
 =?us-ascii?Q?zzWrIbpvjT8TMNV6gqmPXaURRFYmiC3HxKunudgoygUYvUMdspT4f4G5MDXg?=
 =?us-ascii?Q?4v96auMwmPSmig/v75c331ojn/q8PNUBQQRZMZnvQY2l5cIoDAUKRh6Tzz7+?=
 =?us-ascii?Q?TWppxVGE9hmeKBi4LlRJwfojQMv/O1vTG20FnsY3Lc3Dgxx16gER4tG9rJ8B?=
 =?us-ascii?Q?g64hehA9H9yruG4CM5SO2qxiOurciVcgrxjFQgAQex9WrKuVRWBatmwv35Bx?=
 =?us-ascii?Q?9XoZCIQ/pkTS16MDEQZL5iEnq3X12UzGy6g7/DgTmkwdiHycEXMIsl5Dl22/?=
 =?us-ascii?Q?qqpPSYJqFLds+keIv5VxvdMLRIep1u3m+FMdemra0j1ZNnyX7Tekr25e95vc?=
 =?us-ascii?Q?bIdWszRbecoXIszW/1NOHdW5O88+qDK0GWPNN++SCRFTBXNd5Da41tk1om22?=
 =?us-ascii?Q?sEOBCacM8wWMwaC+HRrUxqyg5Cv6QLfuCsVb90g8imto5l3HxzXoXqTnEaJ6?=
 =?us-ascii?Q?JhN84gYXSZBUoXCuFwwIy2eBM69vlZaZuxw15ez4QTAO/xKy1sqU3yKqLPdG?=
 =?us-ascii?Q?GlOmywDmOW883WsF5fwUJGxKVV5DkwGwkXZfc5yYXdvbIOYd8Q6O875gGv6M?=
 =?us-ascii?Q?AhaSGy4gnT7yFr42GZi5ppseWu5Kdifrp51FuyiZtvLvkLSOcAITeJ27jLVq?=
 =?us-ascii?Q?zVWUh6HdKOhvNi6OF2kYQAYVSjFEk0marhA0DysJSpC7Wti0+d//FELSWD9e?=
 =?us-ascii?Q?dMGUfvJRAi8dvSFeYplvm1jo4AgmKz1MUMYLh6BApNKVEg6lV83T0yJ2biFg?=
 =?us-ascii?Q?wt7nMB/FMQFfZQBTqH3FR6hGDjG9CdFNn8Metr4P2UJcNn4aRKWnGPrZgprg?=
 =?us-ascii?Q?uGv7aJovSdR/HWfaWjWEo7g3Gtd3sWoNcoZj2jrrnDSmx/Ojrgy+yyq0i7Pf?=
 =?us-ascii?Q?Seuza5+ZqM0C7GQiMrYgy5YMxtZZrUihwBc/ef/gmHx0sCa3zVBBpq58ocdW?=
 =?us-ascii?Q?Uqbav1TXB5WK0qBZ/5HpMT/HA8Kyd1RY3xR1CiWkTChkDZ2+h4RZ+0iS5j7y?=
 =?us-ascii?Q?Et94kGSPj2XIVIkVfts62uI1u4B6LOwOS+l7m4sMF18IaMirW8k8PqpDb/66?=
 =?us-ascii?Q?z3VN0DZK+bHbLdZmApQ3+cqui2CG4LOsOCu86Bvk2Waq0SvPH7RaUzTBMc1e?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dec40c-7e90-4fbc-c7cd-08da95686fff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:15:02.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj7/lHnI6ppxxt2SnvqHA8t5vxdTAzPtAAKCzIG7iLPR99SQDZYPVgqrLZ1xpd3iwdkd4CEMydqGLxIIpB21a8Q2LczaoadLaV236dFOQA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130041
X-Proofpoint-GUID: WBpiF4PVt6gSGWXrfYKW7LcesjESaqQr
X-Proofpoint-ORIG-GUID: WBpiF4PVt6gSGWXrfYKW7LcesjESaqQr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/printk
head:   f6339cd6dc7f812f822e86bd78d1edbf2bfc730b
commit: 4984141cc2064cdf4e4a122fa0d895bd93943e4e [16/29] printk: Use struct cons_text_buf
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/printk/printk.c:759 devkmsg_read() warn: variable dereferenced before check 'user' (see line 754)

vim +/user +759 kernel/printk/printk.c

e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  749  static ssize_t devkmsg_read(struct file *file, char __user *buf,
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  750  			    size_t count, loff_t *ppos)
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  751  {
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  752  	struct devkmsg_user *user = file->private_data;
896fbe20b4e233 kernel/printk/printk.c John Ogness        2020-07-09  753  	struct printk_record *r = &user->record;
4984141cc2064c kernel/printk/printk.c Thomas Gleixner    2022-09-03 @754  	char *outbuf = user->txtbuf.ext_text;
                                                                                               ^^^^^^
Dereference

4984141cc2064c kernel/printk/printk.c Thomas Gleixner    2022-09-03  755  	const int maxlen = sizeof(user->txtbuf.ext_text);
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  756  	size_t len;
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  757  	ssize_t ret;
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  758  
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03 @759  	if (!user)
                                                                                    ^^^^^
Checked too late.

e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  760  		return -EBADF;
e11fea92e13fb9 kernel/printk.c        Kay Sievers        2012-05-03  761  
4a77a5a06ec66e kernel/printk.c        Yuanhan Liu        2012-06-16  762  	ret = mutex_lock_interruptible(&user->lock);
4a77a5a06ec66e kernel/printk.c        Yuanhan Liu        2012-06-16  763  	if (ret)
4a77a5a06ec66e kernel/printk.c        Yuanhan Liu        2012-06-16  764  		return ret;
de6fcbdb68b29b kernel/printk/printk.c Sergey Senozhatsky 2016-12-27  765  

