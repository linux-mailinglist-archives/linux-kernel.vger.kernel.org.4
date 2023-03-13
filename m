Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461066B7803
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCMMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCMMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:49:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645E34002;
        Mon, 13 Mar 2023 05:49:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNnMkh027922;
        Mon, 13 Mar 2023 11:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ucE3cL4PR7AOUni+7/JDokTo+JB5U/1xhxd2PuZSBqI=;
 b=ETLlxGV/FnZmKjd3w9ePaPn6jEU3hZBAHKvtbmraru6csUQ/N23baNNdpZr7CwfnB5mf
 g3nxwgseZ8DMRPOwBOahD7dW5BeXNjrCCdOm+qbblfOfgmO/fYAwFTCLaafKA2Ua6NeD
 zUVsbzMZBqZAgL9nPm21j2gLvIYsiQOMseVPW+omKlsPQt8+pK8XbCyiJln/dp5+N4Wu
 +Dj5pP2+C4+xUanVAuLkiEClJbGcfKDhfC9+m+vxGaU42or41DaSDfqJSUe8V+XrXC4A
 3VdOoRqygB9y0m0OmGLSAPIj/ngwVK3DVsCH7US6sKofRKsdYnxdLlb0DSIDSCMNgqhR HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhabgqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:11:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9abXM002270;
        Mon, 13 Mar 2023 11:10:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0kgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYhLKqER1KiBx/SMbfcWg+ib8tqznGJHbYxJtYy6YmYLG4KS6907kWgD7f5rYsXRma+n0bu1rAI2AL6tJqg3aiiYhQ2FHCJl+XycAg3nRlPSdrciAa3rVX90j2mRjwie1eDxjkZScn0Q6zM3bBZS5FWRo5+bHarj6DAlOTHv2s0WbJ9vnR7jzv9B7nYq7xA44vNmja/2V0ZYzDquAyfFe0CIBKzzSQvJpCxOUUY22N39nPno3CMDVMt7EA1LB7J38fxy22oqYMbUe9sZrqjEYzgaBTexd8skG4Nv5WkcJubBdmhHnGveLVykehfcHteMxOQ5xngUWK7SlRrPU7sAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucE3cL4PR7AOUni+7/JDokTo+JB5U/1xhxd2PuZSBqI=;
 b=ZRMoxqDITgfzXkx5x3/7KGJTrsz4UT8b6EtekAykC59yq05i1gVuT+vuceWNj56JAeWzUgPgdFsmdI2jehYMUBmvljjgfCo4xPLVlJXj1XkEwg8q/7StfCJ0HrK6VhQ6e8OjEDYcQ4zHNXF1orQz612IKCdtyrRlXvtDDgp3q4SQcspsrM2eYaxeC5icgorUR9Co1uGw7SpV7P94POXjuKvVgxi30wnNJWjlvkrB3/i9kqUhtQeNgsjLOZbuO6x0zofVOfo6833WR+lUNjog2eoAYzCME1gnhKg/V3TEskaY2Nku6IXQlPmHUbK5y6lrGEvB8pgxX1nvEgBMgy37ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucE3cL4PR7AOUni+7/JDokTo+JB5U/1xhxd2PuZSBqI=;
 b=GH5n576svcS84mB8tCjxN3S80rZVvLg8iZus0XQ0fPJc+603RbKlOBgrubePOcLFF83C2kDLXWM+Yins5SpkONmZwpwMxrye9MgevuOMIjqiDuVEyucjdnQXSfTkBATurpDznyLyFVyz12XxcrrXu8cmU3uKaJoPh9Er+MEuuvQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:56 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 9/9] scsi: scsi_debug: Drop sdebug_queue concept
Date:   Mon, 13 Mar 2023 11:10:19 +0000
Message-Id: <20230313111019.1521680-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b4f940-02f5-4bf1-3f60-08db23b39e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9w35mZwx7nAT/lqKneFwabgU+3qMcC+ANmtLxH80Jhh2+4UgaUxYTl+8vytJSLK1LUnbU91rLBUVNUQQQIUMECJjxgEDoQHB6lVhouzPD6DoKkgqnyiuHW/AlDma7MuTOl47lqdEH8JHe3ymQ8I0QTcXZg+zGjAQEYv/UJ8r8yJikTpK+xOQRMTO3AwefJkexTl2I7I6oa+Ov2Nd/EKX0V2J39B6wgoyDdd3bUUl4MvDQxHKTOr/8+6sUgjo/lq3pVEV/ZKAaNvB0fkUuZEi1uwPHkhu4oeVveFqKrPcrpCO3bcH12vWteM1JRXVG5N6dMFmk21xcGvhr/nBF5sB846PFrkN48kOx4vqCPYaI++3sxat3NyhHMlGVUApaVWzOTYoPNHFsh4FLxhNyuk5sFAu/1JDK8LDUfHe3rvACQjIVM8J6p/9iQyCpZbCIp4g7bzi0/v0lVpeymBVlB2hwV4Oavv1AqCXIINQwx4ZwrlPbVVV6Yp/YQPeB6ULNLOZQLjcPmcfnlGYqGBHTtux74BkhplJkE89pQJ1jRlk1L2oTPX/H/5QVPnHCu7DaXJWMDSmOADFHoIY/E+GpPaiwH4tRn6asmvuztmb3SnxRHdZklU4trxw6Aino3md3BTRZx3wy+AiHUFHIhXG+b5+kDxqU4H+h5gMNR0FRGJolZbCgqsIkEgDzAKaXGUv5Ak
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(30864003)(103116003)(86362001)(36756003)(38100700002)(2906002)(66899018)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZh4/Uche7wjDzbJW9l0CzknpArd/S3UfNZwqEG73rYYC39gcFGjj0e/d5QN?=
 =?us-ascii?Q?WmYboEoniuvFPBxiLhkwO441UyYP+2GmCNDFHHRxF9dqcBMxBnSHi6lD+1Uq?=
 =?us-ascii?Q?Ph7vYFqqlyZsgkNX1ogU28O1HrnfsmZDyxS/3hXtQuwqEygSjEFlTn7SKkxU?=
 =?us-ascii?Q?Hg53P9Dmd2JUZPkX6W021cuiiErfgNpFSNNWt/DHVy1YOnYq2G3Vcj6BJVE4?=
 =?us-ascii?Q?EnJnQ04gPe1N3hzg6weQvVnUAW1bnUpqS7gCvibyLN1bXzGE8oSYFYQGjNtS?=
 =?us-ascii?Q?PnVX04iXmf2KwoDDA85c2T1MavLyinkGtokIMxP1Hz5HEfZg8xS65t2VzAFj?=
 =?us-ascii?Q?bnPemZOI6Aa/ZWv1pSjiWk1BclzLajaQunf76mGg0/h70WPplkDocBhKeB8g?=
 =?us-ascii?Q?39o5WqKwL6ionGY1fWvL5rPeKv3hHtT/fyk7HzK/lWFKZ7J9ZRtETBvpOxtw?=
 =?us-ascii?Q?31rsXmASWHC/+QZs0X+xzFV+cjPeQFuUEUGPpYdjAh30PeaiplDqtc2OLsjT?=
 =?us-ascii?Q?MIIZXnZ89Lv/zCmh+XfrzIFrLv76Ec9jplKHIovYtnEBW7AaefE7SyTG96Ft?=
 =?us-ascii?Q?cH+vE4hmcy1O/hTtFan0XinaA+DFGAcRD4vX7yF0dUCcAb+3saPccaP7CXyt?=
 =?us-ascii?Q?YEtt1Y2Ca/MSRDHoCzNJz56qD2hXF5giJsb7qyKvMQuEs5rA33kPW7mK0vKQ?=
 =?us-ascii?Q?AYDQZHytjXPEHvNemXLUjR4tR+wyhvyyxyhgVOXkexTJIU+2Cgc2zpJ0HC98?=
 =?us-ascii?Q?F1AdL24wI7vIAOKeW9aYjna0WKWb9fYGZTr7cNXRNVIzKboHjB31yry7ViFK?=
 =?us-ascii?Q?aMi0hk8BxxOsmt3rpX3+VMq6UusTq+IenKTjsxoLIwJOGmZV1r77IXTQJ68/?=
 =?us-ascii?Q?nVokoRqlP2DzFWVKJsH4E6sMhCpD+kyNr+wQ4QTPf1fqh96AyJxwNRGiSPoC?=
 =?us-ascii?Q?/pMWoduT/tkZOtCt/m/SGAmz1i3usvJKeUgKdh1g8fQw+dK+42DOFuRbshIQ?=
 =?us-ascii?Q?lv7pcZi1zVBt3DjFaWdVolHM/fBHQxTFBsIg/8kCcXFqHSE9YBcm8U5ApozG?=
 =?us-ascii?Q?Yg7CCjINebKqPzHpL2K6SX8cEp9HneUMNszwhpB7Nk/75OTMJqbauGyi+WCG?=
 =?us-ascii?Q?oxd6QOpHaLhqjuuiIiLoWeqrnvvTG62oFnofJau7TmRJnvmRWWJb9KxrfHMO?=
 =?us-ascii?Q?4XICsxMOQb3aFC2WOqvxuOldfJ0eo98iEs5oMOK1vwNvS/dLMm3jEPck8hMW?=
 =?us-ascii?Q?iFmg1wnCLC016+b39q3PajQ6Yz8uV3/BrHaNzT04kvKbBIqZoVnD4oCbIweM?=
 =?us-ascii?Q?Kc3PYKHFNxYY5cGtNylsz1om0Kz1+SSOOZff9xMNzzBPoUlmbZfVZbAuR0no?=
 =?us-ascii?Q?k67Ox4ZfKgQjL/oZ/08HicKnCKqVXnVVQuifREzLspabDF9v5wrtbHocEKMw?=
 =?us-ascii?Q?+AS2ZjDCiWQQ2OFTaxbXP8XEp6ZLBHzpptx8WKU6FD632xOEj2DAHjrMyn2f?=
 =?us-ascii?Q?/12RyymrfE9gk455ttiAwKvvAKSfaS2eFIlinRiOqwGBelN7I7qSfXLspCCV?=
 =?us-ascii?Q?gwqLaTz33a40XtMgVbDioL9UnwIXOE2qKnmlHYpmIG5Em1bmlgwa5nQTg4xU?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8IoDtyLoUBy6lx8s+frjDVAeUFC53RCqNjD+Af+0uf4n7JbsjGxnHpZ+nxr4or4X8E7oH6acfhqC/UAI7G4UCN69ETfzdvhrKjy4St5jW4NB5qVtSNU4EL1jC2g/nbLVyaRRyTv3UV/004WEj2Z+R9tIi9BECzrJVJVqfPYODQH0gA2XNYBDz8AOKGa11tQLSFJdbyYkXisXJMulXrI5TEHYgaX3/O1eR9XFsy17w2oQOHIA39lkX9IDFVh4d6NcSAH4h70UYCHhifr9Ls0rSNUw64BYIrwDdFlmBFncUBxOxsJ2OLH4TcQ9MKubuvCxs2QITQfAXSPzXcyay9g5BbSkm6j3cMNNqxFTNEonmFgFmN76fjCPiC6nKk7QQpzVB1/tWEvt6ngLf/zXVIuB6zx+1lsI9SxlRxz9HA/pr+Vbr9Hekiq3UBx7bvZlTHrXiNeEbnfYXpOmiIkx2DSeyf0rHLS3/uKpX5xoOAZLzl7zABoMK3H0yznNTR2Gebm1DeYsCYANCajjUM9pJuM7tX31sZBKYEORgi8tPMB8WryBJc23O2eRoAvFaYjm5hljJmymEqoT+Ny3XSXP2ox3BBCSnDxdQAlF9H7VRvj1C6/mvRMWfCVnHCyEHwa3qAmE1ns4qk5KBds5MsXhK4CDBLb4sNAQxbg8q5HN2xWisfQcc1t2LeGMioFJCmLRcvEt3jglNNnNHJzLWaCJqzmQ3HhQ4PFZt5JdEccyoQi1eWfRDo90Dg1DX3HIB0fo/htzwZzQhwEt0AejXFQm3SEbdCKfzTcu18y82RVlBzCC72Y2oNbhnlmMgru13Dy+qzSU+8X1ZFu4CvHcnlHE9+9+D2wVS6u+ZJ4i0SXPRmph/rXty+JT7xGHyL6PaCp2UMDEE0ZxSxB5NzOU4hlYhzjQmka37VLgUifQWblsHtlwboY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b4f940-02f5-4bf1-3f60-08db23b39e02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:56.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypissdXOOeL11WBrpz2M7pU4OgPTDIgJUsSiYqKOjN+OCAs4JJ0Bo2m9CwTh8Z4t1VTDohhu0Z+PqKwOHFK0rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-GUID: zHUE6ermDfdbM7UqBczb8pwBf3DiZgeV
X-Proofpoint-ORIG-GUID: zHUE6ermDfdbM7UqBczb8pwBf3DiZgeV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct sdebug_queue is to manage tags and hold the associated
queued command entry pointer (for that tag).

Since the tagset iters are now used for functions like
sdebug_blk_mq_poll(), there is no real need to manage these queues.
Indeed, blk-mq already provides what we need for managing tags and
requests.

However the sdebug_queue concept was still being used in max_queue_store()
to find tags which we need to "retire" when lowering sdebug_max_queue.
However the method to reduce sdebug_max_queue separate from
shost->can_queue is fundamentally broken.

The shost->can_queue value is initially used to set per-HW queue context
tag depth in the block layer. This ensures that the shost is not sent too
many commands which it can deal with. However lowering sdebug_max_queue
separately meant that we can easily overload the shost.

Indeed, since sdebug_q_arr is shared amount all shosts, it is possible
to easily consume all tags in sdebug_q_arr while the shosts are not
overloaded according to SCSI ml/block layer, i.e. shosts may be sent more
commands than they can consume.

Resolve this by changing per-HW queue context tag depth when we change
sdebug_max_queue.

The submit queue tags info shown in scsi_debug_show_info() is dropped -
tag info may be got from /sys/kernel/debug/block/ path.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
We should not call sbitmap_queue_resize(), below - any better ideas?

 drivers/scsi/scsi_debug.c | 246 +++++++-------------------------------
 1 file changed, 42 insertions(+), 204 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7ef195072d97..2bfb6db538fc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -341,8 +341,6 @@ struct sdebug_defer {
 	struct hrtimer hrt;
 	struct execute_work ew;
 	ktime_t cmpl_ts;/* time since boot to complete this cmd */
-	int sqa_idx;	/* index of sdebug_queue array */
-	int hc_idx;	/* hostwide tag index */
 	int issuing_cpu;
 	bool aborted;	/* true when blk_abort_request() already called */
 	enum sdeb_defer_type defer_t;
@@ -360,12 +358,6 @@ struct sdebug_scsi_cmd {
 	spinlock_t   lock;
 };
 
-struct sdebug_queue {
-	struct sdebug_queued_cmd *qc_arr[SDEBUG_CANQUEUE];
-	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
-	spinlock_t qc_lock;
-};
-
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
 static atomic_t sdebug_completions;  /* count of deferred completions */
 static atomic_t sdebug_miss_cpus;    /* submission + completion cpus differ */
@@ -848,8 +840,8 @@ static int sdeb_zbc_max_open = DEF_ZBC_MAX_OPEN_ZONES;
 static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
+
 static int poll_queues = 2; /* iouring iopoll interface.*/
-static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
 
 static DEFINE_RWLOCK(atomic_rw);
 static DEFINE_RWLOCK(atomic_rw2);
@@ -4904,20 +4896,6 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return res;
 }
 
-static struct sdebug_queue *get_queue(struct scsi_cmnd *cmnd)
-{
-	u16 hwq;
-	u32 tag = blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
-
-	hwq = blk_mq_unique_tag_to_hwq(tag);
-
-	pr_debug("tag=%#x, hwq=%d\n", tag, hwq);
-	if (WARN_ON_ONCE(hwq >= submit_queues))
-		hwq = 0;
-
-	return sdebug_q_arr + hwq;
-}
-
 static u32 get_tag(struct scsi_cmnd *cmnd)
 {
 	return blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
@@ -4927,68 +4905,30 @@ static u32 get_tag(struct scsi_cmnd *cmnd)
 static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
 	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
-	int qc_idx;
-	int retiring = 0;
-	unsigned long flags, iflags;
+	unsigned long flags;
 	struct scsi_cmnd *scp = sqcp->scmd;
 	struct sdebug_scsi_cmd *sdsc;
 	bool aborted;
-	struct sdebug_queue *sqp;
 
-	qc_idx = sd_dp->sqa_idx;
 	if (sdebug_statistics) {
 		atomic_inc(&sdebug_completions);
 		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
 			atomic_inc(&sdebug_miss_cpus);
 	}
+
 	if (!scp) {
 		pr_err("scmd=NULL\n");
 		goto out;
 	}
-	if (unlikely((qc_idx < 0) || (qc_idx >= SDEBUG_CANQUEUE))) {
-		pr_err("wild qc_idx=%d\n", qc_idx);
-		goto out;
-	}
 
 	sdsc = scsi_cmd_priv(scp);
-	sqp = get_queue(scp);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 	spin_lock_irqsave(&sdsc->lock, flags);
 	aborted = sd_dp->aborted;
 	if (unlikely(aborted))
 		sd_dp->aborted = false;
 	ASSIGN_QEUEUED_CMD(scp, NULL);
 
-	if (unlikely(atomic_read(&retired_max_queue) > 0))
-		retiring = 1;
-
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("Unexpected completion qc_idx=%d\n", qc_idx);
-		goto out;
-	}
-
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
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	if (aborted) {
 		pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
@@ -5275,21 +5215,18 @@ static bool stop_qc_helper(struct sdebug_defer *sd_dp,
 }
 
 
-static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
+static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd)
 {
 	enum sdeb_defer_type l_defer_t;
-	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_defer *sd_dp;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	struct sdebug_queued_cmd *sqcp = TO_QEUEUED_CMD(cmnd);
 
 	lockdep_assert_held(&sdsc->lock);
 
-	sqcp = TO_QEUEUED_CMD(cmnd);
 	if (!sqcp)
 		return false;
 	sd_dp = &sqcp->sd_dp;
-	if (sqa_idx)
-		*sqa_idx = sd_dp->sqa_idx;
 	l_defer_t = READ_ONCE(sd_dp->defer_t);
 	ASSIGN_QEUEUED_CMD(cmnd, NULL);
 
@@ -5305,22 +5242,13 @@ static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
 static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
 {
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	struct sdebug_queue *sqp = get_queue(cmnd);
-	unsigned long flags, iflags;
-	int k = -1;
+	unsigned long flags;
 	bool res;
 
 	spin_lock_irqsave(&sdsc->lock, flags);
-	res = scsi_debug_stop_cmnd(cmnd, &k);
+	res = scsi_debug_stop_cmnd(cmnd);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-	if (k >= 0) {
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		clear_bit(k, sqp->in_use_bm);
-		sqp->qc_arr[k] = NULL;
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-	}
-
 	return res;
 }
 
@@ -5578,7 +5506,6 @@ struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
 
 	sqcp->scmd = scmd;
-	sd_dp->sqa_idx = -1;
 
 	return sqcp;
 }
@@ -5597,13 +5524,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	struct request *rq = scsi_cmd_to_rq(cmnd);
 	bool polled = rq->cmd_flags & REQ_POLLED;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	unsigned long iflags, flags;
+	unsigned long flags;
 	u64 ns_from_boot = 0;
-	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
 	struct sdebug_defer *sd_dp;
-	int k;
 
 	if (unlikely(devip == NULL)) {
 		if (scsi_result == 0)
@@ -5615,8 +5540,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (delta_jiff == 0)
 		goto respond_in_thread;
 
-	sqp = get_queue(cmnd);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
@@ -5635,33 +5558,12 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		}
 	}
 
-	k = find_first_zero_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (unlikely(k >= sdebug_max_queue)) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		if (scsi_result)
-			goto respond_in_thread;
-		scsi_result = device_qfull_result;
-		if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
-			sdev_printk(KERN_INFO, sdp, "%s: max_queue=%d exceeded: TASK SET FULL\n",
-				    __func__, sdebug_max_queue);
-		goto respond_in_thread;
-	}
-	set_bit(k, sqp->in_use_bm);
-
 	sqcp = sdebug_alloc_queued_cmd(cmnd);
 	if (!sqcp) {
-		clear_bit(k, sqp->in_use_bm);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		pr_err("%s no alloc\n", __func__);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 	sd_dp = &sqcp->sd_dp;
-	sd_dp->sqa_idx = k;
-	sqp->qc_arr[k] = sqcp;
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-
-	/* Set the hostwide tag */
-	if (sdebug_host_max_queue)
-		sd_dp->hc_idx = get_tag(cmnd);
 
 	if (polled)
 		ns_from_boot = ktime_get_boottime_ns();
@@ -5708,10 +5610,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				u64 d = ktime_get_boottime_ns() - ns_from_boot;
 
 				if (kt <= d) {	/* elapsed duration >= kt */
-					spin_lock_irqsave(&sqp->qc_lock, iflags);
-					sqp->qc_arr[k] = NULL;
-					clear_bit(k, sqp->in_use_bm);
-					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 					/* call scsi_done() from this thread */
 					sdebug_free_queued_cmd(sqcp);
 					scsi_done(cmnd);
@@ -5974,8 +5872,7 @@ static int scsi_debug_write_info(struct Scsi_Host *host, char *buffer,
  * output are not atomics so might be inaccurate in a busy system. */
 static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 {
-	int f, j, l;
-	struct sdebug_queue *sqp;
+	int j;
 	struct sdebug_host_info *sdhp;
 
 	seq_printf(m, "scsi_debug adapter driver, version %s [%s]\n",
@@ -6003,16 +5900,6 @@ static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 		   atomic_read(&sdebug_a_tsf),
 		   atomic_read(&sdeb_mq_poll_count));
 
-	seq_printf(m, "submit_queues=%d\n", submit_queues);
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
-		seq_printf(m, "  queue %d:\n", j);
-		f = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-		if (f != sdebug_max_queue) {
-			l = find_last_bit(sqp->in_use_bm, sdebug_max_queue);
-			seq_printf(m, "    in_use_bm BUSY: %s: %d,%d\n",
-				   "first,last bits", f, l);
-		}
-	}
 
 	seq_printf(m, "this host_no=%d\n", host->host_no);
 	if (!xa_empty(per_store_ap)) {
@@ -6428,30 +6315,36 @@ static ssize_t max_queue_show(struct device_driver *ddp, char *buf)
 static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 			       size_t count)
 {
-	int j, n, k, a;
-	struct sdebug_queue *sqp;
+	int n;
 
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n > 0) &&
-	    (n <= SDEBUG_CANQUEUE) &&
-	    (sdebug_host_max_queue == 0)) {
+	    (n <= SDEBUG_CANQUEUE)) {
+		struct sdebug_host_info *sdhp;
+
 		mutex_lock(&sdebug_host_list_mutex);
-		block_unblock_all_queues(true);
-		k = 0;
-		for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-		     ++j, ++sqp) {
-			a = find_last_bit(sqp->in_use_bm, SDEBUG_CANQUEUE);
-			if (a > k)
-				k = a;
+		list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+			struct Scsi_Host *shost = sdhp->shost;
+			struct blk_mq_tag_set *tag_set = &shost->tag_set;
+			struct scsi_device *sdev;
+			int i;
+
+			scsi_block_requests(shost);
+			shost_for_each_device(sdev, shost)
+				scsi_device_quiesce(sdev);
+
+			for (i = 0; i < tag_set->nr_hw_queues; i++) {
+				struct blk_mq_tags *tags = tag_set->tags[i];
+
+				/* yuck, we should not do this */
+				sbitmap_queue_resize(&tags->bitmap_tags, n);
+			}
+
+			shost_for_each_device(sdev, shost)
+				scsi_device_resume(sdev);
+			scsi_unblock_requests(shost);
 		}
-		sdebug_max_queue = n;
-		if (k == SDEBUG_CANQUEUE)
-			atomic_set(&retired_max_queue, 0);
-		else if (k >= n)
-			atomic_set(&retired_max_queue, k + 1);
-		else
-			atomic_set(&retired_max_queue, 0);
-		block_unblock_all_queues(false);
 		mutex_unlock(&sdebug_host_list_mutex);
+		sdebug_max_queue = n;
 		return count;
 	}
 	return -EINVAL;
@@ -6975,13 +6868,6 @@ static int __init scsi_debug_init(void)
 			sdebug_max_queue);
 	}
 
-	sdebug_q_arr = kcalloc(submit_queues, sizeof(struct sdebug_queue),
-			       GFP_KERNEL);
-	if (sdebug_q_arr == NULL)
-		return -ENOMEM;
-	for (k = 0; k < submit_queues; ++k)
-		spin_lock_init(&sdebug_q_arr[k].qc_lock);
-
 	/*
 	 * check for host managed zoned block device specified with
 	 * ptype=0x14 or zbc=XXX.
@@ -6990,10 +6876,8 @@ static int __init scsi_debug_init(void)
 		sdeb_zbc_model = BLK_ZONED_HM;
 	} else if (sdeb_zbc_model_s && *sdeb_zbc_model_s) {
 		k = sdeb_zbc_model_str(sdeb_zbc_model_s);
-		if (k < 0) {
-			ret = k;
-			goto free_q_arr;
-		}
+		if (k < 0)
+			return k;
 		sdeb_zbc_model = k;
 		switch (sdeb_zbc_model) {
 		case BLK_ZONED_NONE:
@@ -7005,8 +6889,7 @@ static int __init scsi_debug_init(void)
 			break;
 		default:
 			pr_err("Invalid ZBC model\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	if (sdeb_zbc_model != BLK_ZONED_NONE) {
@@ -7053,17 +6936,14 @@ static int __init scsi_debug_init(void)
 		    sdebug_unmap_granularity <=
 		    sdebug_unmap_alignment) {
 			pr_err("ERR: unmap_granularity <= unmap_alignment\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	xa_init_flags(per_store_ap, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	if (want_store) {
 		idx = sdebug_add_store();
-		if (idx < 0) {
-			ret = idx;
-			goto free_q_arr;
-		}
+		if (idx < 0)
+			return idx;
 	}
 
 	pseudo_primary = root_device_register("pseudo_0");
@@ -7120,8 +7000,6 @@ static int __init scsi_debug_init(void)
 	root_device_unregister(pseudo_primary);
 free_vm:
 	sdebug_erase_store(idx, NULL);
-free_q_arr:
-	kfree(sdebug_q_arr);
 	return ret;
 }
 
@@ -7138,7 +7016,6 @@ static void __exit scsi_debug_exit(void)
 
 	sdebug_erase_all_stores(false);
 	xa_destroy(per_store_ap);
-	kfree(sdebug_q_arr);
 }
 
 device_initcall(scsi_debug_init);
@@ -7514,11 +7391,8 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 	u32 unique_tag = blk_mq_unique_tag(rq);
 	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_queue *sqp;
 	unsigned long flags;
 	int queue_num = data->queue_num;
-	bool retiring = false;
-	int qc_idx;
 	ktime_t time;
 
 	/* We're only interested in one queue for this iteration */
@@ -7537,7 +7411,7 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		spin_unlock_irqrestore(&sdsc->lock, flags);
 		return true;
 	}
-	sqp = sdebug_q_arr + queue_num;
+
 	sd_dp = &sqcp->sd_dp;
 
 
@@ -7552,36 +7426,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	if (unlikely(atomic_read(&retired_max_queue) > 0))
-		retiring = true;
-
-	qc_idx = sd_dp->sqa_idx;
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u\n",
-			sqp, queue_num, qc_idx);
-		sdebug_free_queued_cmd(sqcp);
-		return true;
-	}
-
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
 
@@ -7601,20 +7445,14 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 {
 	int num_entries = 0;
-	unsigned long iflags;
-	struct sdebug_queue *sqp;
 	struct sdebug_blk_mq_poll_data data = {
 		.queue_num = queue_num,
 		.num_entries = &num_entries,
 	};
-	sqp = sdebug_q_arr + queue_num;
-
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_blk_mq_poll_iter,
 				&data);
 
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (num_entries > 0)
 		atomic_add(num_entries, &sdeb_mq_poll_count);
 	return num_entries;
-- 
2.35.3

