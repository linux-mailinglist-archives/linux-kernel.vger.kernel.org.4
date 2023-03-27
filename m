Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D706C9CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjC0Hoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjC0Hn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E55249;
        Mon, 27 Mar 2023 00:43:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7ZFqa021908;
        Mon, 27 Mar 2023 07:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wgjRk98w/OAWYBQ3HlwyEhUAkcSEBVv5ule5dectEC8=;
 b=gsobvQfmRWWj+vS2XNLOATLLOuHmJ+LPrXyYOQKt8GqW0R9H4VRzPHt4lxX8WS+7Uncm
 UtTW2mCADHKpoVAWbR5sL+Dvq2uh94FF553dTYzSmFGl+ZwVB6GAzWA53Qkj+1sclPy1
 gpmsw/Zy+yraN+UZfpc/d8qCyZUSdydByHJQkQGR3KJDj9L0BrS6dYyNCIMs4lsUwgyb
 vK/cIugVewFqr9nRZCMCkHinxkvJ9RpDf7WNA5RvBeY4Th44mlyzgAYp6XGjON9UEdzt
 dWlVbpec8D+CSJCz9jwvujkNA1XpxftXxweOt6n+5a9DZ0BArLA3Z39VMQTEyryi3Osa Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr158-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R69ZkK032943;
        Mon, 27 Mar 2023 07:43:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdc4waq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOLhWDHIQm0UB/vgkSktojFsg1S+xjMCQRYaxsN03pDOfjttnDJ4kK76Bkh7kTbeFwYFkS7zDkCwbUhudH9+Bsg4fUYNief5wQ5mRM98QPRGYfDLcSwhc2JhNRqBDyc/ej1vbVDlQR/I4zLoMgBgphrL/E0B9Cvvfr7DtCSxJk+EBjcLnThbIupfFwsrPMyfQi+VpUTh0d8YYk+dyl3MLVuLguUKZFr2fcMeHRCU0Swjf9D3B2VcovY0ZmTkIz+nVRP7bwLUrqLanfUSQCN6QDnx61D9IgJzrwTrnlpBfKMAOxlQaSWi4skyreZS2ifOTCjIa18CS2QWl2y036DLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgjRk98w/OAWYBQ3HlwyEhUAkcSEBVv5ule5dectEC8=;
 b=hb8ykBBlN2VoFDsJHBdZq1vGXcRL4V8cXhIH0orxF9V9DRVKqv/qodhrvwQuOLtDil/vV3CJSNbuSSs/B1OEOZmz30jHwfkaUyO9xF+WcqKLKfEk2g2uZX3QEJDqh9hN8A+ePgZ/tz+iw4eO0si2DcxzrEhklbxCUUcmbI9ptV2fO83Ks4WYidGBjQNAt1mEMAHyQXNXhHZoABPgMeC6IERw5NkZRYGP/9Js2xpyQWJEv4EKwc0Ww3S+l+HV+wPqTSxlqvIX8qU+W0ma0V+uMYwLsCBXJjn6A698brOrNbXWNPjWFkIAz8m4RhCLGckKPLcqMpCv/bflES4o5FWVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgjRk98w/OAWYBQ3HlwyEhUAkcSEBVv5ule5dectEC8=;
 b=homTKIGhP2SGokRDy+FbwIVaQzRfIgdPjOGiPnYCCdq6RaXoVuAEGia27OFSwDLtjJq4670XwpVaLlZIUdeoLP6peuDOfUgk6q3/tfOHuT6sZPbhwPwcv9K8I5PHIQGAc5q05c40O2DIjRjbRfVTVyj5BcA6jaD8+3r3lafEdQQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:33 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/11] scsi: scsi_debug: Only allow sdebug_max_queue be modified when no shosts
Date:   Mon, 27 Mar 2023 07:43:09 +0000
Message-Id: <20230327074310.1862889-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:5:330::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf3985f-7eb5-4e72-b72d-08db2e96f71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4JNdha2FyGNYgp4GeVHStLSO6gGf3X7V+ydVKsCQwu2GwtqsjJrKYWJyB2uOUEroTjspx5rUcKiIZpTAl5ANNJ3PQfMCYgJjVDO8ZfKvGmrITvz1/HU/RZsEmK7jGQVbQX/R742kgKdiZfkswK1bfecYdt3YJVUbyXVz549glchb7sqSdaraStzvUSe9skdTnFs6TKR2HPp5pi5qoJMN2ErK97Z8CkcESJrvQaiC7/OzDK90tXk1//k7WbjOAbWlG+fEdnODn/jtnMWnOmgo8EIrRYx6lM4d//o1JCVvrIzjp//jbQnFWl9vkM56Zca5G3oml3HHoNTZx0SUeOLUZ5KSIflmyldHRjTg/6k/q7qKvFztzaVzd9Z5XUg6zK6jJMdRohFO3LdXZQivyurB58UTOPc+el6W1yFmWDHgzCbMWJtcOE4uk1w2QrpV0ELroLce2KqO6+VhMhuZRZDd6HdOYw3pnuIF0TXCvuEJJmpIyxJ9yfFamenx8rlH0l6ITrRrwMRCt8MVSaKrTqZX3VEiMvoNwfXkLO4D91wRARv/SwwFY8Q9qD+zjdI94NH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(66899021)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGLelM0SOTjL26NpJ4NPLZcGrAGlHXtkTipSOj+vNs3Ja8RW7rkJbH+39VDR?=
 =?us-ascii?Q?dTQ6ZPzbhj3jsCcn4iX1vES0sN5q75zp3s+tNOxKY+TjXtp/CZm7zdcYqarq?=
 =?us-ascii?Q?dMpsmI5JcVqqiXrVUJ4aMLJDzIyRqqyyrBB6kBFg/8bH7+hpk8h+OK6ui8Dk?=
 =?us-ascii?Q?eyScrc5GfZ3YMwLjZJm/82SxF9kTOtPS+6AzHWC4mvb/houxR+FZZm02+3ad?=
 =?us-ascii?Q?ydalxbfMGkU3cGA27RPjYpItKHnjjpLk5PfPe6NQdkuzz8qhfu71xeUqlzv1?=
 =?us-ascii?Q?Pk39orEWxBNKG0uXR+v/CP6pje3iGdsnFiZkwe2EgHS3gwGGOR958K9dcIp/?=
 =?us-ascii?Q?eLWBj82IFWz/BQSP1cfq90jgRHaLYbuCRg29DwucIhJfKZaVPIBvMmNKJLgy?=
 =?us-ascii?Q?82SgVcDT0SqcgtSdc439zyo8Ryz9z0PExrxkats8+Vz7UclRvZz4ul2aVDme?=
 =?us-ascii?Q?eZ2B2S517ZFD2nIrP/3xKkCsw1C16cWpB0Fn6YnlLDXXmm2V9SwSqGXJ+3EL?=
 =?us-ascii?Q?3flfqlUTqKlZe4yXNxsI98djQcbQr/8nKPQB0Cxfwmow+G2kSjz7z4Njn/XQ?=
 =?us-ascii?Q?Na42DtWoxpHZkQ+et7OawrkzXM5RhQQdOEKpf5GT50z2F3SK46QWbzeWm81c?=
 =?us-ascii?Q?pH2jJezhzwwqiw/iZIJ4Er3eOW9FRvOrM9/OoCv3Bq7JZTfRGcQ3g3lclD75?=
 =?us-ascii?Q?javynnLokqQNQGhg8KaXt0rbSzwaFYAUVp4n4NZL1siQ7Au58yvsWUVwBNVv?=
 =?us-ascii?Q?KCltwXLatmMJh2vQccLeEW238xrNrxlBkUNv3UeDcmofU3wxLptwufmzovln?=
 =?us-ascii?Q?LIqO88Z1UJc/5If9In4VEamkd9TM/NdM+AfGQE71f+dwyBFlAFuVsPfpOl73?=
 =?us-ascii?Q?6yYl4kt2O5egYA2YRUEO01n34ujmVa33qLEllQf1f36fMaakEX3/vgtkC+Ox?=
 =?us-ascii?Q?Q4QFHfIU0SZrpx62vy3xzWtCibwe6r8mCd0X38Mp56iqlFvWaU0KsVUK+2Zn?=
 =?us-ascii?Q?BporyvzgrxdZDM8i33EZ72uWMIGEeIiWBB1xG6sj6lwLszNbCuRjfxmylqnv?=
 =?us-ascii?Q?u4Jjd7QwWlPcKIQgY610FlmXEz3RL6zV3zbmVCdgoVvPUG16A6XJ7fAiqs78?=
 =?us-ascii?Q?HoRfQlbQ1Ci73K4XSqyRLUYF/sJAQYuWqSTlshLC0kxoYLNJdcJ/X20dTQ5v?=
 =?us-ascii?Q?L1AUuRF83L/XL0hVWtwAYdbxTMFTJPil2QY1rvrZhJ1qNNoyOThLXy5aNfV7?=
 =?us-ascii?Q?YDWbUH6sfz23o7y5I6dt5igucTsk51wLEFGqVZFQZzLV5/z9GBmtPJolDvN3?=
 =?us-ascii?Q?ReySIVC6UkvudMXYAx9t8mPsWUc+kRnSyKS+b2VEIZy7c1rnzb8ORuRM+Ll0?=
 =?us-ascii?Q?yPOrDnq0R0wqaxwmk+nEpeUWTP0gCK8OKh05B5Bk8mOIJvpeWP4d9bm0m4Tr?=
 =?us-ascii?Q?ICZNWIU+sKnQrr1ohTQonVO/XCnjfaYGXHhY3vYCGAfIalefCTcVxZGR2PHM?=
 =?us-ascii?Q?5MNugGbrHnQGVsMEbtenfmkmMS6WX3Bw+2IqadgSb4wWISu5efGQwzrBc3+Q?=
 =?us-ascii?Q?uIBU8ybvZMo4YUSGiBVMUHMzei1QB/KG6HjFJTGvdkyVwG0jhQVi4owcZJyD?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E0xWn8ZkqcKtwcTcS5Vi7N5F5KwxInD/9/4d4slNZt3W+YiweUEKnDoF/u8sO1G0XKgmqAXp0orYq+VXXwCsu735rzfFNOUzsT0rRE+Vw/bJFfl62N/gh0KP4MA61/qpD41z0JHUJhCz3/iiNrLNCxX2HW234Q5Q2bIm45QpFimfYueP3K6jXMTa/v8fFgf3n4nHm59w/rFu9/nftwXMuc44SBB7bdH+B7zfeiAwaYyhAS8l+CfF+l3941+WUmBxTk1gBWnZ+253/aoeMIRye7z9DQGf/MYq2SHCN7BzxJP+ly4PdCtgo1oGRwR761G5+F5zcjgr9Nqh5PTg8IQCaR0+XAZTZxb4+uN3ZQ7Tuv9+pTIWzBPQM80Q0d7h6ye+X490slgd6plyKpK5WksgvJp65+6M/Bq2HtVZoyItL0WvDNfMuE6xscJ390bNHeZhgj63xL00A6lyVHsKpXbdtlw0tYQKgevcfxkAbHZyEn5Wn235s9bHzdXtVtd0Asi2ejvrM+S80oNdPS6NI+KZhPOPrX33kZRA1TFgQmFXT3XQeBy+XLM4uc503ZJzB+gSkQmAh+niTnra2KUGrGZ1+gCKikxINj2Y2/RRtkbqQPVCma3Py1egcqx86hv1JE2rz0Pp7ey7xIxsic70A1gN9KPNxU7knLpf1qpzOb7bCjsF2eKNAgzhxXcHf0OtsmmQtqu5e8YyRrU6h1HrUnMgpeC24PavF0S+bCql1hKJOuVBTBaJHRFBvrs1He786+jtcXfJq8erWUbD15VwrY5ih+N8iMqIvpCgTjgjVH8+yXWq/GZSxmvdY7eKmI/IXrrBPco+yczD3UVId3IJQRROQVo4T61y78HYONadU/HvILc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf3985f-7eb5-4e72-b72d-08db2e96f71e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:32.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUttcXb5ICrWhsGlAjS2FAgjO/YpCteROba6xVZRS14WGEHlE/WS1O9kDpvwHTA+OjN5fYv2UvFbH5vpmBuByg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: 9XbTbSQ0qYGdemeoXesCEEX_PvY5tei9
X-Proofpoint-GUID: 9XbTbSQ0qYGdemeoXesCEEX_PvY5tei9
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shost->can_queue value is initially used to set per-HW queue context
tag depth in the block layer. This ensures that the shost is not sent too
many commands which it can deal with. However lowering sdebug_max_queue
separately means that we can easily overload the shost, as in the following
example:

$ cat /sys/bus/pseudo/drivers/scsi_debug/max_queue
192
$ cat /sys/class/scsi_host/host0/can_queue
192
$ echo 100 > /sys/bus/pseudo/drivers/scsi_debug/max_queue
$ cat /sys/class/scsi_host/host0/can_queue
192
$ fio --filename=/dev/sda --direct=1 --rw=read --bs=4k --iodepth=256
--runtime=1200 --numjobs=10 --time_based --group_reporting
--name=iops-test-job --eta-newline=1 --readonly    --ioengine=io_uring
--hipri --exitall_on_error
iops-test-job: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
...
fio-3.28
Starting 10 processes
[  111.269885] scsi_io_completion_action: 400 callbacks suppressed
[  111.269885] blk_print_req_error: 400 callbacks suppressed
[  111.269889] I/O error, dev sda, sector 440 op 0x0:(READ) flags 0x1200000 phys_seg 1 prio class 2
[  111.269892] sd 0:0:0:0: [sda] tag#132 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
[  111.269897] sd 0:0:0:0: [sda] tag#132 CDB: Read(10) 28 00 00 00 01 68 00 00 08 00
[  111.277058] I/O error, dev sda, sector 360 op 0x0:(READ) flags 0x1200000 phys_seg 1 prio class 2

[...]

Ensure that this cannot happen by allowing sdebug_max_queue be modified
only when we have no shosts. As such, any shost->can_queue value will
match sdebug_max_queue, and sdebug_max_queue cannot be modified separately.

Since retired_max_queue is no longer set, remove support.

Continue to apply the restriction that sdebug_host_max_queue cannot be
modified when sdebug_host_max_queue is set. Adding support for that would
mean extra code, and no one has complained about this restriction
previously.

A command like the following may be used to remove a shost:
echo -1 > /sys/bus/pseudo/drivers/scsi_debug/add_host

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 67 ++++-----------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6e40e9253393..b6e5b1f2a746 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -762,7 +762,6 @@ static int sdebug_max_luns = DEF_MAX_LUNS;
 static int sdebug_max_queue = SDEBUG_CANQUEUE;	/* per submit queue */
 static unsigned int sdebug_medium_error_start = OPT_MEDIUM_ERR_ADDR;
 static int sdebug_medium_error_count = OPT_MEDIUM_ERR_NUM;
-static atomic_t retired_max_queue;	/* if > 0 then was prior max_queue */
 static int sdebug_ndelay = DEF_NDELAY;	/* if > 0 then unit is nanoseconds */
 static int sdebug_no_lun_0 = DEF_NO_LUN_0;
 static int sdebug_no_uld;
@@ -4928,7 +4927,6 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
 	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
 	int qc_idx;
-	int retiring = 0;
 	unsigned long flags, iflags;
 	struct scsi_cmnd *scp = sqcp->scmd;
 	struct sdebug_scsi_cmd *sdsc;
@@ -4959,9 +4957,6 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		sd_dp->aborted = false;
 	ASSIGN_QEUEUED_CMD(scp, NULL);
 
-	if (unlikely(atomic_read(&retired_max_queue) > 0))
-		retiring = 1;
-
 	sqp->qc_arr[qc_idx] = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
 		spin_unlock_irqrestore(&sdsc->lock, flags);
@@ -4970,23 +4965,6 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		goto out;
 	}
 
-	if (unlikely(retiring)) {	/* user has reduced max_queue */
-		int k, retval;
-
-		retval = atomic_read(&retired_max_queue);
-		if (qc_idx >= retval) {
-			spin_unlock_irqrestore(&sdsc->lock, flags);
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-			pr_err("index %d too large\n", retval);
-			goto out;
-		}
-		k = find_last_bit(sqp->in_use_bm, retval);
-		if ((k < sdebug_max_queue) || (k == retval))
-			atomic_set(&retired_max_queue, 0);
-		else
-			atomic_set(&retired_max_queue, k + 1);
-	}
-
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
@@ -6431,29 +6409,18 @@ static ssize_t max_queue_show(struct device_driver *ddp, char *buf)
 static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 			       size_t count)
 {
-	int j, n, k, a;
-	struct sdebug_queue *sqp;
+	int n;
 
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n > 0) &&
 	    (n <= SDEBUG_CANQUEUE) &&
 	    (sdebug_host_max_queue == 0)) {
 		mutex_lock(&sdebug_host_list_mutex);
-		block_unblock_all_queues(true);
-		k = 0;
-		for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-		     ++j, ++sqp) {
-			a = find_last_bit(sqp->in_use_bm, SDEBUG_CANQUEUE);
-			if (a > k)
-				k = a;
-		}
-		sdebug_max_queue = n;
-		if (k == SDEBUG_CANQUEUE)
-			atomic_set(&retired_max_queue, 0);
-		else if (k >= n)
-			atomic_set(&retired_max_queue, k + 1);
+
+		/* We may only change sdebug_max_queue when we have no shosts */
+		if (list_empty(&sdebug_host_list))
+			sdebug_max_queue = n;
 		else
-			atomic_set(&retired_max_queue, 0);
-		block_unblock_all_queues(false);
+			count = -EBUSY;
 		mutex_unlock(&sdebug_host_list_mutex);
 		return count;
 	}
@@ -6882,7 +6849,6 @@ static int __init scsi_debug_init(void)
 
 	ramdisk_lck_a[0] = &atomic_rw;
 	ramdisk_lck_a[1] = &atomic_rw2;
-	atomic_set(&retired_max_queue, 0);
 
 	if (sdebug_ndelay >= 1000 * 1000 * 1000) {
 		pr_warn("ndelay must be less than 1 second, ignored\n");
@@ -7520,7 +7486,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 	struct sdebug_queue *sqp;
 	unsigned long flags;
 	int queue_num = data->queue_num;
-	bool retiring = false;
 	int qc_idx;
 	ktime_t time;
 
@@ -7554,9 +7519,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	if (unlikely(atomic_read(&retired_max_queue) > 0))
-		retiring = true;
-
 	qc_idx = sd_dp->sqa_idx;
 	sqp->qc_arr[qc_idx] = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
@@ -7567,23 +7529,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	if (unlikely(retiring)) {	/* user has reduced max_queue */
-		int k, retval = atomic_read(&retired_max_queue);
-
-		if (qc_idx >= retval) {
-			pr_err("index %d too large\n", retval);
-			spin_unlock_irqrestore(&sdsc->lock, flags);
-			sdebug_free_queued_cmd(sqcp);
-			return true;
-		}
-
-		k = find_last_bit(sqp->in_use_bm, retval);
-		if ((k < sdebug_max_queue) || (k == retval))
-			atomic_set(&retired_max_queue, 0);
-		else
-			atomic_set(&retired_max_queue, k + 1);
-	}
-
 	ASSIGN_QEUEUED_CMD(cmd, NULL);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-- 
2.35.3

