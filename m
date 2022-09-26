Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482775E9EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiIZKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiIZKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:09:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD22188
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:09:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8t9Qx013271;
        Mon, 26 Sep 2022 10:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=4/Mw4dWORSwbsEw4gR6ZwdXhyJxzT3cRveGaQvmQmiw=;
 b=zCkLicUChtoHq0TFZT60KPxlyPTUfiTjIAKPLrPcWmGOkB0DQyD9HcGlaT1lSy2X2bQm
 kX+pFn6U5IETX1LxrZNMwcLXNtkBBxPRT+lCOzWY0xJax2F8G/qh1SDtgJEVRJIxTAv4
 TUvMNhQSUwFYE8FWz0dBJYPuCAzPSZdMdHi1XlGeah2GwW8NmHyDX/bXweymeLH1+A8N
 phJsEB4c7WPwQ+r4FZ4Y/2sk1+PozXYRUxh1gXRLP6U8Ip4SxnQUxStZFW0xiRFLK88t
 SQ+Ip/CAfJjkIDmOXv/mbvT+wxfrmWg8bEXIVvT6jiSVksavhi+Foi+biQnwrG8SZTm5 UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kk3kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 10:09:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8huKi019091;
        Mon, 26 Sep 2022 10:09:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvd2u7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 10:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnlUuqb8g+gvdTOBKqli75iKfL1JKNCX7GaE3zdfAkVlwk6Cara3NrvBSOiba7/qjdKoIE4fnj6L5+bkS8RefIn6Gdt4c7KZWlZriewtv8c0Z47sPKJoAuBuOdajGqiopmO4VsrWu1nGplGyupLLJLNoVjkQ9A6cTNY+Ixxuf9qb6Wbnuz5QUlJYp8RCPpVcxFg9s5t+1/Q/i9tKReDiQNTN7p7S46ABVeLGirRCUfLJg9Mu4gKktYI2Bb6agl87IdBwNPBeWVvtBp6CmPVgwoun5iyTYKqlQ+sP4BcH77RG2Ruka84iABOEvcYFvbqeoyrHk5M01G1Ns63eIaqP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/Mw4dWORSwbsEw4gR6ZwdXhyJxzT3cRveGaQvmQmiw=;
 b=DxPeLztCttd74jwbgUutnJ85Zi+ZHpv84bxESZkHQF4QqKinwshGdzVmMREZ8DFmjIYymJLkA6mr9J7AdihZv4Mx60qc7ecpjxNURgiWQ2/VyIKBQknL6MdOPfazWO56HokHrfI5eSoEvncY19UkgobzWSJHIEESbT9/tit5n6k8+zKwC66Htf1Qc92hIrHuYGxwG1entkzLvqo99cMzvVc5M1WTjECRPBrtK2ml3Ri4UBTPezqQDrZ0aR4wzj7XNjH8VB3pwnCamOvvwoM1c0uGpaFJdGxKY7I5/6mCJVpQ9AoLR5o5Cx4DsBEl9QaHTX24LaqR257EZ14N3QGANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Mw4dWORSwbsEw4gR6ZwdXhyJxzT3cRveGaQvmQmiw=;
 b=JQY1EmK600DjJlTA3PsY0Ohio/64XRruujvSz+3fQWl4GBcVXDOp++krQJGRqI1yUMFkvEsknCE80c+Iz5WMlI+cRwF5UAo5Cv2krb4emAZ+N8q1v9VcrQG3/fnLE8NGWa4ALIyX2nhGR7BXzbPUOdk75K+PWTrQgqA3XSDdNrU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6218.namprd10.prod.outlook.com
 (2603:10b6:208:3a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 10:09:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 10:09:17 +0000
Date:   Mon, 26 Sep 2022 13:09:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Andrea Merello <andrea.merello@iit.it>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 44/63] drivers/iio/imu/bno055/bno055.c:635
 bno055_set_regmask() error: uninitialized symbol 'best_delta'.
Message-ID: <202209261001.a8hOrx3A-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 79241d03-3771-4c0f-e12c-08da9fa72c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxJcXVXR/1gvRtYYILel+SLNZJG8moXDrfoPlGy2J8I5rL2ZCzrJxv7k5mD4dlALCe1HO8wkhNtz6QHr3ZxvchAtq1ggRBuwrCv994FLJrmv1jQqp7Sj7XDSjUT7SiK7Lh4HKyB4k6qevGILuwjzqMhyOUohDj6FUP0cgc/0WlMJpFRH66qA6mWeIxO1rR1Dr6GjfEoHn4W3N+QYhEmQfJz0w4fQtMkVeDpCX/ubZxHE5COmTsjSX1rbaS/+iMLhx4Fp1vOR9MUz+KzLv7tG+an4NYtXW3650hptM34ZGzjn0ADjOG6rAPqFTEFipLrBscMtY1wG5C2Xs0fXfLrg8z8yf0JDUF8Bn7o1LIrheebWDVmUkUFWnpOtmFwHKEujGJXwfeZNXEnocfu/bCr8E4ChXtzdgL6bL3nAsoCk6BdXgx/TDR8QvaZkPfdXmb/QR/WpTwkN9JEXQeJzsRUs3Dfl/2/fIPuzATb6GsndyD7M3Wt7vdnIDsPDKJenGf291eSafmbBJm9LIaL3BRo2jJkfJo3dVvF4yCalGSeeqgKfQoFEwzhcCYLYyK3T8FazwcujyA8NbExZf+pmlbsQEKbnZ/R0rbZIdhkVH0TnI9kk5MK6EA7dute601Q4KTfq8VRXc37AI0CgzRx0beZENWDYaSX/HHh8MbKrUDRIx6Ko67b1Ut7jodyaEauNmk2MnBHUtG3NVXMk6vxmC0D0ElYHgNiJKdM9WErl/5OPO6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(5660300002)(8936002)(478600001)(26005)(6512007)(9686003)(54906003)(6916009)(966005)(6486002)(83380400001)(6506007)(41300700001)(66556008)(6666004)(316002)(4326008)(1076003)(36756003)(186003)(66476007)(66946007)(8676002)(44832011)(86362001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXz7mybfQ1H+OFY+ndkH2dqkCVaWiowLcURDth/dl5ATzl9+39gx5eq1Fmxf?=
 =?us-ascii?Q?+VTQeYI9yZrAD/WEBXVH2fESz//ajKETIGf10bFYdDWs8OglzhlkqrmHmWn9?=
 =?us-ascii?Q?GF9sqB75wQA/yL8vXV8Tpqg+jo+ChVsea+oXThte00F/IS8hd43CbvmdMvOQ?=
 =?us-ascii?Q?M5I8aDFHxZuxplSvG2D8i+knuUsXwWCe+ekTFH9iZpy3gOjtvA2YJYhmkX7g?=
 =?us-ascii?Q?2x/mlL1cpep73BkF4us10Nu9KCaHxENqHfFS77mQBpcZmL4S5ThX25ihtFZJ?=
 =?us-ascii?Q?2Qqr5gJJ3Qn13dGCXHnLA/DCOwcs2Eg5C0kMVS3t04lf8NWZoFjXJF1aMPWT?=
 =?us-ascii?Q?cue2kO1JJpMzamkrurmq4XTynjgmwRP/t9I2YwClONNug6Ki5af0Tj9etq/e?=
 =?us-ascii?Q?WSLJnWzvZF8WH+TEXBiIsitvqqbfLE0KazMYeZt1mmPEQ+Ma1W1mOQ9m305v?=
 =?us-ascii?Q?CmJBLhQthcuUdAbzLNMFWyz9hhnYEWmrXkiPvRYxJbZH7GkTT1fcATa3xs6v?=
 =?us-ascii?Q?F3Lm+qbljklcAzwlhsXpYozsVvW0j8BNL96GK+sSHjYwVL/Q/lEE5HDKwRel?=
 =?us-ascii?Q?tLDyxiFih/pw4v3hj9cdfHByx86rjaeGtdS6lV/kk4VnOLq4V32MouWSNCKw?=
 =?us-ascii?Q?HI5o12XdkA2RoJ7aVyF8P1uwOS/Axd4KV8eyqwE3uWVrBDq0oTIFZUb15Yje?=
 =?us-ascii?Q?V8+pj5GlIZjSuXWbqdHs4dS90OremZ94xlfrgcjGmOyKyvOiTGdbA3wxbpXy?=
 =?us-ascii?Q?CDzTCj6mNs3kB0wPWhoxTB45/DUJc2h9MYfWZQYcgvf3AgY5k/D8CpArDcvZ?=
 =?us-ascii?Q?bf7/p0N2aNebjz5uC0695nvnkUhUcIr1PFLA5CBl/gTl3pcgv68+pHrGCxLN?=
 =?us-ascii?Q?N//fZKQwimZI0nGVbWBUBvxNfNRYw6DFXgn+QiL5/Z93Vh8f7YFN8n95XOzT?=
 =?us-ascii?Q?F8geuEcmKAn4BegZhKGS9aF02aewDiNL5AF/rK8qRh1Ah6NBVywQ9axUJJmO?=
 =?us-ascii?Q?4Gp+CNne0bZVStTC34cLsE9BQHqBUB+dON2dOAX+D2fsM7dNPppYnn4+Q/08?=
 =?us-ascii?Q?+93KtG0vkW4OMGBVdcYsfLyA/u8YjruvVAVF8KFgrMhZohPSTJJN38X6eSvR?=
 =?us-ascii?Q?8iS0cwQNOlODRRebK11F4Paf6+w0p3vmWYVTMyZ4YdjL2949iLNk19mOC9L4?=
 =?us-ascii?Q?CfJncZZ+XgXPfcxeZgPUZkf7UbeZdJDrkXUOuogHVZAVijsqewyTk5cypFoL?=
 =?us-ascii?Q?KRsK7o4NzsHouvA7tRQaaDFpITxiMmR6Vq733dqPHrhrU9qD+EqPI3b582JZ?=
 =?us-ascii?Q?rbIQ0hPW+t+7H68pOVlMhPB+VZ+5n+H0R3tg3pt6ElxUO+3+K/jCwQyRf58g?=
 =?us-ascii?Q?Ys0mjmpf1Cm6BXJczltRi9I9SfLdMfk5mWrKWLyMpq2xgIuodX2ClRLQbwet?=
 =?us-ascii?Q?0tu7O3joQROFiw+yp9yOTujQR0RO0eS9iN5zIkBSQGYUMUANlNfa4tVA7q9j?=
 =?us-ascii?Q?20U7VLDHX0+tcBLTD79vlJjvWEKXIFPoUFoJc2ENeb/nlsTMb3NfV9144oJ7?=
 =?us-ascii?Q?AbtShU4ZQfTOwUT3d6Qqi2o8QOwWtc2RznnzMZhT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79241d03-3771-4c0f-e12c-08da9fa72c13
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:09:17.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiHYs9DgRGr0XTlZGPWpc7VrMI4fgv8ld094a7N5aW77c5Ylsleiw7WvjZVtFjJg7Jy415W/yI22+jAY6B/hJovcG5tsBbUSYnghvVQBlto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260065
X-Proofpoint-GUID: tj6054CHFlUKOvpftnCj921gJcIgFwLw
X-Proofpoint-ORIG-GUID: tj6054CHFlUKOvpftnCj921gJcIgFwLw
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   df957373c1649c74b78bf2fcfd144f0c3baa68a5
commit: 50fe984f376abb4a00f80e13f51465ef09c2bde7 [44/63] iio: imu: add BNO055 I2C driver
config: s390-randconfig-m031-20220925
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/iio/imu/bno055/bno055.c:635 bno055_set_regmask() error: uninitialized symbol 'best_delta'.
drivers/iio/imu/bno055/bno055.c:643 bno055_set_regmask() error: uninitialized symbol 'hwval'.
drivers/iio/imu/bno055/bno055.c:1511 bno055_trigger_handler() error: uninitialized symbol 'xfer_start'.
drivers/iio/imu/bno055/bno055.c:1513 bno055_trigger_handler() error: uninitialized symbol 'prev_end'.

Old smatch warnings:
drivers/iio/imu/bno055/bno055.c:649 bno055_set_regmask() error: uninitialized symbol 'hwval'.

vim +/best_delta +635 drivers/iio/imu/bno055/bno055.c

4aefe1c2bd0cb0 Andrea Merello 2022-09-07  579  static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  580  			      int reg, int mask, struct bno055_sysfs_attr *attr)
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  581  {
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  582  	const int shift = __ffs(mask);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  583  	int best_delta;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  584  	int req_val;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  585  	int tbl_val;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  586  	bool first;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  587  	int delta;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  588  	int hwval;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  589  	int ret;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  590  	int len;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  591  	int i;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  592  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  593  	/*
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  594  	 * The closest value the HW supports is only one in fusion mode,
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  595  	 * and it is autoselected, so don't do anything, just return OK,
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  596  	 * as the closest possible value has been (virtually) selected
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  597  	 */
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  598  	if (priv->operation_mode != BNO055_OPR_MODE_AMG)
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  599  		return 0;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  600  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  601  	len = attr->len;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  602  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  603  	/*
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  604  	 * We always get a request in INT_PLUS_MICRO, but we
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  605  	 * take care of the micro part only when we really have
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  606  	 * non-integer tables. This prevents 32-bit overflow with
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  607  	 * larger integers contained in integer tables.
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  608  	 */
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  609  	req_val = val;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  610  	if (attr->type != IIO_VAL_INT) {
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  611  		len /= 2;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  612  		req_val = min(val, 2147) * 1000000 + val2;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  613  	}
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  614  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  615  	first = true;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  616  	for (i = 0; i < len; i++) {
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  617  		switch (attr->type) {
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  618  		case IIO_VAL_INT:
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  619  			tbl_val = attr->vals[i];
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  620  			break;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  621  		case IIO_VAL_INT_PLUS_MICRO:
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  622  			WARN_ON(attr->vals[i * 2] > 2147);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  623  			tbl_val = attr->vals[i * 2] * 1000000 +
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  624  				attr->vals[i * 2 + 1];
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  625  			break;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  626  		case IIO_VAL_FRACTIONAL:
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  627  			WARN_ON(attr->vals[i * 2] > 4294);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  628  			tbl_val = attr->vals[i * 2] * 1000000 /
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  629  				attr->vals[i * 2 + 1];
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  630  			break;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  631  		default:
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  632  			return -EINVAL;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  633  		}
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  634  		delta = abs(tbl_val - req_val);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07 @635  		if (delta < best_delta || first) {

These tests need to be reversed to prevent reading uninitialized data.

	if (first || delta < best_delta) {

It's the correct thing to do.  KMsan will detect this at run time.  It's
undefined to read uninitialized data.

4aefe1c2bd0cb0 Andrea Merello 2022-09-07  636  			best_delta = delta;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  637  			hwval = i;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  638  			first = false;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  639  		}
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  640  	}
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  641  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  642  	if (attr->hw_xlate)
4aefe1c2bd0cb0 Andrea Merello 2022-09-07 @643  		hwval = attr->hw_xlate[hwval];


This one is likely a false positive but it's not feasible for the
kbuild bot to use cross function data so it does not know that
attr->len must be greater than zero.

4aefe1c2bd0cb0 Andrea Merello 2022-09-07  644  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  645  	ret = bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_CONFIG);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  646  	if (ret)
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  647  		return ret;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  648  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  649  	ret = regmap_update_bits(priv->regmap, reg, mask, hwval << shift);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  650  	if (ret)
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  651  		return ret;
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  652  
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  653  	return bno055_operation_mode_do_set(priv, BNO055_OPR_MODE_AMG);
4aefe1c2bd0cb0 Andrea Merello 2022-09-07  654  }

