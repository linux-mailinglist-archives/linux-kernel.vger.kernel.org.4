Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5E6C63FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCWJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCWJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24E244B6;
        Thu, 23 Mar 2023 02:46:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hoNS019252;
        Thu, 23 Mar 2023 09:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NpF0Loc3vV5MFrD6YCOAk1qLEJTwm3Krk6N0TLS++Pk=;
 b=XGwYqJlYTm0zFpPXJ2NKpnM6a15Q45WH+KTjRDk+aUBQSj0IL/Mwt4sFcOGlycxesXFC
 liJFxwZ2BO1dGnZs3N3QW2L07Tink6jXLIo1MhJFmXchSedIi84GhFtYZu8LFQM19tEy
 UVLv+2cgWCi+gC//YfeD3ZVAIiGzRN6EFjNrfRQvUS35yjlS2AY0orK/iU+nBcczH3kx
 cO/6d+06Uqsg1be8Qk/Mq7HjKIj0CaUI1RiyXlrVa9rMn9n7Og6ju9y3qcGaPy1SyhGZ
 bw6tKQaAV4+sr2SGC4WnHgj7RWfxbeLUWcGeLrMaC9Y37sLRiS1ZjHdf82YvqAa2bRqZ tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bckbq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiI006987;
        Thu, 23 Mar 2023 09:46:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLlfhYUbL0+6Uxs/LQfXo7XXL+oaXa+b3uwLu+YKvbtA8Ff3HMsZujO+Vi9+FlDMsH84rhhFr4TJN9VfOwj9SPRc1055RZNc1ib2DwXyWlDxaQSt/7fHSh9qv2JxGFRkVUNnZforIJ29OpgDOVImgGNU+lFNVk0WLyPoHIlqM7u6ugPEDrlXrGMI+hIqbodewp0AZ6ZY5dJ6UhLxOjWRjNqRcXsdEjhmM+iMgChXGzqvxqoOgFDjfes2aKUCiDvO4FvLhPUwGgyYvF8r4Q3wlKf6nQp4wn3A6laRzLF9a0d9LX+R9CLtvhsVw/em4Khh4w+iCy09Bz4eK+5cAVu4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpF0Loc3vV5MFrD6YCOAk1qLEJTwm3Krk6N0TLS++Pk=;
 b=FcV/hBTFHn6IcsDanDfw/eqtoAgfxTA6Eq/R3gF/sr/LqmUE64iwg7rqlvwcerBgjYjxlFZ9q2C51xeP9oliQaXj3oG+IK6kWSBHHGqRE6pdzPc5kC+xBLyywd5PFt3ydEiEL8shn/1+vmp1ADPmZQTgL6GAfsXCQq4kpVjne4eiTwKN798jwsr/9TbirSonqgpYq/uonI+5j/f98IlfdZfuLPeFNZohNsfyFnSncfmacrZvPYs28OTRYK7h8qUmf9ApSVS7F3aNvCPYqBtmo4nKLcOZ79kVp+o3YlZHaOfPFvlnr4qapXfWVfcGvop7PQd8d3kH9VGt6xb9hFrLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpF0Loc3vV5MFrD6YCOAk1qLEJTwm3Krk6N0TLS++Pk=;
 b=YyxkTi7Q1LJB362OjRXY1cp7tm81Vd3RNZmXTbORSk+fo79xlJUtWShEdOL59DvCIXuf0gB377wWVMDfFqcRXqOQQeilYU8ihtNWBdGgE4gx7BSw2mtBm3GMKbfFVru2pvdu4Odw6SOGV4wpsOf9SYOfxf24v5QC/oMFU974dLI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:38 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/11] scsi: scsi_debug: Only allow sdebug_max_queue be modified when no shosts
Date:   Thu, 23 Mar 2023 09:45:54 +0000
Message-Id: <20230323094555.584624-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:5:337::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 75638bb6-d6b0-48f9-987e-08db2b837fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1XMPHPUnC9ShyKIGme/QEPRPm1nMYy4oAEtrouKGs+Zc1Lycm+2IEeYLz2fxs1kApn9SmqPxRJYU3zDOsLnT0BILD12Wn65+mvCcz/XWCH9Aao6gg+VRby9E6GuCUyh3NS8UChK+L6tqnTx138bLv8CNtG+IqCwLEgq1n6T/udiLreAo3HmbohpTH79iuiau86JYMwjB41e/87tiLBZem9xFW6OzC/VQKY1RSmRgV3JLyOX8/DwyGytzs8ThjmoLqiDAJe6WlgDcWmdSmdhsOildctcD5upE56TT7VivO4dQcMAfoSWqM7xmu3PK3fYXiHVdBqLHgxit+faZdQA4v9/kMhqCqkbYLsHYEKpjiS8jnmjIJZo1Mw0o2PMlVl6FhwN/Gut2eYIRqd7TTfODIbx7P2YmflS+guKwZUEgfCihCPSssrgXz4eyW+UwV3J7XhmtFYU4k/wbGiq7E8RdQqZjTwqNc/RJejfrySajTlsQe8ngdBWN+DEdIS5R04rP6wlsPTqFSrbLQ2kTL9H8d/U0B52cIOVzYqi74/ip3Ol2xsroDGqt2/Tofypt+Wts/L4hnO9mocwS/pX/oiYDEAdoerx1hAxlWGQzEPzz/dvyoSUWwrgbF9tSC2Ywh+4hc3tKLb5VHkFp/k3dHquAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(66899018)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gPaTv7t8RUyaA6UAhd+nbDgLfMpLF5DmKOfmuLWvMjnwMCNABEXPOhk14sHX?=
 =?us-ascii?Q?63Ak9erza0sFjnIpVvSUyQtapFTA8rfSA+pzKbUi6F+Hwt/UkmSZtRn1o3L8?=
 =?us-ascii?Q?ygAS71IQDb/Fuo8udZ7FtlfNtUI2iYAjyHNgd5BTAtouX2iXD4Vvn4H5vWDH?=
 =?us-ascii?Q?EB4Zwp/5RhivVL6bFXo3hNWCP4KXSvBsNG+QNNCd5HSrxRl7XWpGK/XRuYFp?=
 =?us-ascii?Q?tDVPS5NjFPS0R/a9FF2nqi6VDEA9tMP0hY07d/T5RDlV2u0zKZmTh09lsdWs?=
 =?us-ascii?Q?HmyJHqCBAd7AgKgxbHNptU0vHvZ5Fai7Oa4bC38/pXrndOAf+JSLHqkhT+OL?=
 =?us-ascii?Q?fFkFDcSJP0dBTBZakie5mpEF8VniYkOGuUYT0sZbY+4zw6BRAtboNjTiB8D4?=
 =?us-ascii?Q?cFfUZy1hsmprQhV8WUGOBPUqEn2ZvArFX7Wvs5mbC6KA6fU+rjaCT3Jk6LJF?=
 =?us-ascii?Q?JvkadgqY8nAu1qRN/fA/yYTKefsTqDGmC6lTR4rB9hweVvWIgIGiZ49G5/2B?=
 =?us-ascii?Q?p5W3PvMPQ2UNZ68Jac5r0jDSzf+KdvLG+1Lr7W4GFUwbYQlPMKLz5Wfz7V9k?=
 =?us-ascii?Q?SelPtpCiCzmHoydbHZ5mlbOLgiOfIutbt3MvJvr8yFmo/SjlcLAiZcirZPq/?=
 =?us-ascii?Q?VSy0gl+k2egYVVLZsIQ7KKPQw6eRVKNL8Si6AAlgFJ21Uioq7ugj45yiURj6?=
 =?us-ascii?Q?GIQVbr8BK+bCftW8dBarORmegU27qKos5c9H0j3N3QAO1RZlxkJks09gu/SD?=
 =?us-ascii?Q?PjDCzyBzdtiKRZ/iQOiegroMdVLOtcx+BZqb4FF15SCRqXCY5z4DGRJo8e3C?=
 =?us-ascii?Q?UTDzkbU8g117U4iCHXaAvJFywdZ6mGhEXzWHueTl6KLxivI8d0uQGsQes0Ez?=
 =?us-ascii?Q?TXzVruvS5igXgBP6s4TnmPIuoqsSnwBLkGFgFgpKn19ZA7uHbozDicbnv9mz?=
 =?us-ascii?Q?2rTKhMGH8smuzbM6HBYh1EpQ7JFvJmZuipr3j7qkCcyAQfCVZneziaNKaC8O?=
 =?us-ascii?Q?0X2nWaXioBf24BBLlA3Dnt2VII3nPzaSmdX+TIIACWKlJeyZwUsvfJKu5R/O?=
 =?us-ascii?Q?IP4cu9WarxB2NnYxawDd40vzPRS4Vw43X54rOZa+7xI3/9+33CekECzsuNXn?=
 =?us-ascii?Q?4IK0K/kRAxZeuzG7jtsBCqlQpzDtLky8/HjrxQh+aOU7djCL1wgoPyr29OHr?=
 =?us-ascii?Q?bwV7VSWS+cs23nRM0oWnR34oJIci/jftpQhj3iAAxaI9oPGHiWSU3kSdwdaF?=
 =?us-ascii?Q?5tamogza+jmZqFREgatzHTPPJ3p8jgX0iCzNpvvkSU7PzOSPNgAa0lAzfH3r?=
 =?us-ascii?Q?wzP1Nnb70v+MmzVLY4Cxbd2SsCXHZ+Iw6Izy1JQgqidOPaeW7a+OBNbTkq0c?=
 =?us-ascii?Q?BzAnyg6Prv+cIkiocdvzvECKyjEOeZOAmXCb0agYSyjJvyyKVYInc9oFCm4q?=
 =?us-ascii?Q?kmm7Zq3jWBMDZHSewjRK4COeB9VzgJtbWhbKpNjs2ekkctdxqxfsUmSjb8f4?=
 =?us-ascii?Q?RZJPTYcLhVz38MBkmJ4fYh6ZbDwCNMUdJoYzFu89G32yUph5NGTGbKmOKxsz?=
 =?us-ascii?Q?BRFUC/MXxyXX+zY9xx/VgtvkB7+d65jqBT8hKxXbBF5806pdYBupSzFqX9E6?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: agNJuYndNz9uW1RH54kvYAOagioHuRePo7qcf0EpH9x7g2wORNbdKr7BurC+DGAO9ByQt75kMcy9hCgzECucOWilEemja9VBWdghmbw0JGOtDaFxJqUww3q3dEF2YQFjNB3a4HzqdY388exlPII1Vb+aPpe2ofY5ETi2X1KHZcGvEjnXORKv0iVulMgJ1cpztcjpHCxt7yUH5jTHfBROZ7yA02nsbdNgnOvRfpgHFJ0OqhB7NvypqebMDeMdrRYE+M/BakQjrAt4uXuxP9lR5hvXipR/vvC+dlXI5lhpW07WsBEyyIVcFyvJQ6DLrUHe2kHiZ+h2rMhDw7jME9dsyOxuSuv0CeQX3l5vGFFCRzQHv4mRdiJJRnvzgoTL5eRdjLzq6YYGKNPhfe6ULALtvYHAu/8fbuyPdLG2Brf0saqmIF/wxeyWyJ0PWYmhSx3vIyYbEEK+W4UdMhfhLAGKpAibeP/ohXKMSQCyogTf8lQ3YiO41zOe+Vo8fXOmCG2AeGWdS2/E4E+VvibnvNbsJ3iuWUr6p5XzWHwMdC0vsrNnPD9f/dLk5rEg0Tyz5Brm2uMsbizVR1yfbWBVWs+VQo1DW2XUQbFwi8gzFCg/dj36QE39TMFZN7i2MvL0AJH3VyGpvvlh/jxl0VWHjLUyhRVQGpJl5If+/BbhPbsTIBT2JBzN89uWGVcJQ6bwNXeUE3BSDsFiqe1rBYFLRwqr5X+kt9Kr+lj1wE47wEcYMqxm8ZzDpMwATgJzgJHWN7cUOn1wxH+1z2IOgto3108xlPvVAIBNj3DIRNWtYQJWF8CE7yvvlVoymmm2ZjQsgTCq9keKCCKxK5ILITzJooDv6crvBZTsIL1ZykdBaWKt/to=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75638bb6-d6b0-48f9-987e-08db2b837fc2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:38.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsBsRl6CeJ4Ib8hEDp8ZmS2avfhdI8UUAxkVOjkZPvTmWHEswbxg4TgXVx3h1MtgVuCHVmxSp7Qa2S0wD1qAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: -LOZwH68QyfTnUJsIIhwjM5HVdJrcdkg
X-Proofpoint-GUID: -LOZwH68QyfTnUJsIIhwjM5HVdJrcdkg
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
index 8a0fe403e225..78bd393cb2a0 100644
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
 
@@ -6430,29 +6408,18 @@ static ssize_t max_queue_show(struct device_driver *ddp, char *buf)
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
@@ -6881,7 +6848,6 @@ static int __init scsi_debug_init(void)
 
 	ramdisk_lck_a[0] = &atomic_rw;
 	ramdisk_lck_a[1] = &atomic_rw2;
-	atomic_set(&retired_max_queue, 0);
 
 	if (sdebug_ndelay >= 1000 * 1000 * 1000) {
 		pr_warn("ndelay must be less than 1 second, ignored\n");
@@ -7519,7 +7485,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 	struct sdebug_queue *sqp;
 	unsigned long flags;
 	int queue_num = data->queue_num;
-	bool retiring = false;
 	int qc_idx;
 	ktime_t time;
 
@@ -7553,9 +7518,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	if (unlikely(atomic_read(&retired_max_queue) > 0))
-		retiring = true;
-
 	qc_idx = sd_dp->sqa_idx;
 	sqp->qc_arr[qc_idx] = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
@@ -7566,23 +7528,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
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

