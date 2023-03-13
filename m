Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BFD6B75AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCMLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCMLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:15:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4E23877;
        Mon, 13 Mar 2023 04:14:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNpTtJ017235;
        Mon, 13 Mar 2023 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jLosYjE40HR35OgZ18qhqr/stcxoHZgkEEw55vC09v4=;
 b=dbK8NQgY2Sg2euEL4Mkawcdfj+kiejo5o/4Vke8QrByC/vw0sdPuMzqi/ofvfh7LFdk3
 1VDMsJxDJb/DK2QM1EG2BXtJRsy0VEvYgezP2UOAqRJtEmLJWxCuIcrU5Gw0IJz8FtQr
 YYoQWNQ7qKLsY+AbzdOK/g3JViKZ2goFh3eyrU7Hwuxt3M6xPDLZzYn7ZB6SPWquOrbO
 iwYt5U4yiOxA1E61yBHck3U/AJ8fzJAbq+EZAcdsKkXJHxlXIqlNN6czKlGR6DYSNnAg
 DS+dj8StcDZBfHzf82qf5BDWQd2FUg7V427nv20gIi1vRrOcnNaWnp2gxTuR07wyNErJ Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3h80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D944A7002312;
        Mon, 13 Mar 2023 11:10:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0kd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRORxpqqoRIMB08kKoLPLa+8ILQSRz67wQsgQb6TDY89SmnV03yQ6YwbZS6Eq1MFfTF+D6ihMhGHh+HXu5I+dVVcwmxLsXry0dZUfvEaPnEiXb/T0Qqs28EOrfAx1+pr1mun1SXZ+yPBdVnGAL9QalvImJjgd50HVqFkLXTbV8ydHKAlMh5V21iQuIoO531Su6LoAZo/yC3xFaRc+hYje7L+uRADYgsEbDiOFxxHskU5DKouxNMub0lGc9hDvmvP5AlKpl3kbMyiDFwUhQ7MFDwwzDv8q5i8n1i8OC3irxkjhBjpxXC6Zyayn1EPZiu08uYBF/AIrHeWFHTZHtzVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLosYjE40HR35OgZ18qhqr/stcxoHZgkEEw55vC09v4=;
 b=ErSZFI9U3QBr0aDf11+jfWlblsTy71KM1kK1AloLNr4PMdWrbggnbxpZVlLkQPmgeNIfiGk+ZtIWxiMGrCib6Tdv2BjxnsONWMqjkrHSijr7eBJuHcdfeS4pRpAd5FFWMdQ6UVTgmtqMByRokOtINTPq242Uf1l4JHZTwmXON1Z4Nbf/jcuvYLsi0e5jrduyPVbHLCuUBfUq7mK0DX/sEAOwiDQdh95uXy0gq8ihhCOhCMKESkyTM/sL9OxA+nZT5CRgiQISCgh0hZG2r5VyqVgWO5RV+VNqI55hfJkOWTPu6VXADuI+1P2Tdc44l591uzq4NgnC6ycvyP512c7WeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLosYjE40HR35OgZ18qhqr/stcxoHZgkEEw55vC09v4=;
 b=QleaZg25bC9r7c/NztHFSdobk71EtsKUP0WUDRMH8D7xqWR2lPPfP9bKySrHMGLb74s3qoVGhm/neYtRKsgmrE6FZlrYlznBm241JhIHYvWc6J1unrH4r+A9J6R9oL/7HMgi6vLK7bcxFC/15dNWELMQ2oiVQEE4+7oQS34Q2tI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:49 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 5/9] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
Date:   Mon, 13 Mar 2023 11:10:15 +0000
Message-Id: <20230313111019.1521680-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 613e648a-c6fb-41f7-0117-08db23b39a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKxZwpIjExDDdAaGe/5sN/cGwq8GC0eTb7LwTWHy6oQ4YJGbUMR+zNukgDodVzun0xmaSJsE9g80c6HX9ZxFp3ttjPImBzjGbK8h0zTJBT7M7ZiK3vO6XQDkkn9TvHoIZps6NEDEF/bs3GMv/Qzik57d7C/JXbZ4npsiVexgtd9WtO9nQkyO/nPmNx9w7PtY0wviJr3T9CVW7NW74ALJQYckGCSHWlKBu2vvsqcTw+RtUd/QhvFeMMHhJ2A6WGkQrEyIs6uNPANj9PsefAsGP4XGRFkRgZhGS4zXBChviU3W5Z9A1/zrKrhIKaV9u5P2i0yimt7lIdV0fXjpy/+APiuUpd/SfWqcVYxvJXBQQbsL4QoNNI8DW2mQ/wheVZRtwNxbNSnKR9YTZAKpLFIEhqESpsPVa0k9vj8OjYHG4L7e69qSokDXlJsst+77VarC4GhfMJa5xe6Bof6z3CqR+Wtye3+CbV79gtuGPrbPRIEfO9isCwkvnwYbRtZby/Dd/1k+JUSbxfBzKaeZAGu879vKZQUVWdPhWdx8Yn8/uTlIGC6bNJaTgeE6jtkbzqrPTQMpUxHENXF7M4QkglE+jKQ/tz4vOaw86JwkvHI8E938hLxd394JINSMvu+mCujg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(30864003)(103116003)(86362001)(36756003)(38100700002)(2906002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iB/LEGKT3ssVOV1oydrl2OH3w5tmgsucxIKM3Ahm8jTULaIZPgL8peVqTZ7o?=
 =?us-ascii?Q?7NbFABeyR7xwYQQpmVBhl1y06SsX41E7or0kGF5TA011sgPpIns4nAP1bHR6?=
 =?us-ascii?Q?Lej7wNoJ3/M+wZBINgUk/bbfePWJqJujDhBHdZ+DinBVS/aDDuv+C/c8wxeF?=
 =?us-ascii?Q?rmhjPr+oUrGE2MOlhcE6HRRuqheDL/yCDZXYYTGerhuvPW72VZPCC1wS8eDg?=
 =?us-ascii?Q?u7cpVD6Z1jmTUNjJRh8/VZgIDOixqHO6EqdDj6r1m9aJZi0M/nNr2GhvmcQR?=
 =?us-ascii?Q?sMVGci7clIU0Q1IEVxuO7pYEr/bwvgKjNanV5nHcGm9+L8UZCG5V7SJWtRif?=
 =?us-ascii?Q?ndLF+pNIoUxI2CdUNIuhHkJWF20wT/Ixtzs+docbnytKjMHiT0XJSeGlPofb?=
 =?us-ascii?Q?3qRu6HReNjVFhGrq9zBI8/bBs+lg8C8X8kAaxhn2iSG3gdA8MGMxVJpxfPrd?=
 =?us-ascii?Q?IUfNEA/bu7ErOWUmtj5wtIBvskD5RSlHCP7ZqgJ8dgPdD/Ji7tgwVpKGdLyJ?=
 =?us-ascii?Q?1DwW48dPaHClwVN6iMzwXew8njUWo5FKyNEupapFxDMfZ07ahbnhN596eikz?=
 =?us-ascii?Q?S+bWTqsDHg1HKXhIwC9vFI21kPsRPf74WON58rcGaO7ZI50N3ey2yi14SVS+?=
 =?us-ascii?Q?pF2LpL/C94HbvtwImbkltgBSsssYNMomXGI1An4ljFuMUrOsXnsE2u3ZsNnS?=
 =?us-ascii?Q?VUu1PLGOlFW4Xn+Gk/2Q65Mh0NVsIXHpx7cxqjMq5Ve4aIfPcAfrQh3xiF3n?=
 =?us-ascii?Q?xfeI8lIIrm12hs68Dzpf8z3wWYmdX+c/MW1lWOc/MNQsMLMr4IQaq99UojHN?=
 =?us-ascii?Q?fAkIrBGvj4jWlixMzqguwUfS0kDofjzt0d7nrRFpzKlVSI40ECMj2p4KUjif?=
 =?us-ascii?Q?2IdNVnByYX95dyzKsX2LovDEw3dgD8Zwe8FAbbH0srCFWjwm2mgUWYpykhnx?=
 =?us-ascii?Q?BG7f0UrOxTi7zKFunGlHc2cNZRhZ/5V/uqmrFlUQAk49u+zKmsMcac0byZ0G?=
 =?us-ascii?Q?Ph7r60+rs843dpKILBK/6tm9tm/9raZpEC6+X6hkS6zJl8FoB/Vy7qiO6CAP?=
 =?us-ascii?Q?vtQZNAuX45URStpQsoTTyM31C0rNmP+7GgmuhtJCMNnPZVQE5qUVWCW6dCny?=
 =?us-ascii?Q?3KkB8qKgcRKyRTQGT9NRBjGAMSg5yfnzSvTYPRoKPuvtl+6cNrFhP/D1qZ9R?=
 =?us-ascii?Q?g5IPtURGQ2ZEgQFIvlRBgxvJJzHZu4TabfLj8z+wbPNg3VwxyuONr5tI6VJ0?=
 =?us-ascii?Q?mxhwbGueR0GHYxmejtB5P+240T9WRc7IkhhFtJSnwmtHzulR1X3yOXWCC45i?=
 =?us-ascii?Q?93/1W/d+EJph28g12MfXb5wGZHrokyU1IVXJYGSZUaDyCn9qYx7bP0BwqMgl?=
 =?us-ascii?Q?4jCsqbpegRgA0Mvf9tF4YK0qDtiomHrLNRGAG8EczwydexrvhSTffq1ar/Ri?=
 =?us-ascii?Q?fhcT5348/A9MNcUBsoVlDvFmJCI5cHX0HLBlzd2b3np6shlxYwzFo9HGeR3h?=
 =?us-ascii?Q?Lwmw7G94JFJGxkrgKutd5/6z6wCbYkDG8d2sK6yV/EgVibgjpFxUkYIMtWhw?=
 =?us-ascii?Q?tmmOXwvfHc+DLmZPbD7Sd0VCLUagGL0XNZblh8r0XNFjXJVpYnn4F8dEVJCP?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U5lQU2xDRsQ8RDjfuRjYwXAnip5E0DICB80Jn1qoNknbapM+QyQXmzPj6KHqvBAFuxk1MebJY5cJ7TeZSalgju+BM8I07vCf6/nIS9ma0t1pYEQq4dWwUUtBsSJC133RsMDKUBa7mECu4S+jS18Wq14oPyXk1PiRCHDt7Ys/HTynjOEYXCHI3j+OJX5NBW6sHK1/oqtnnQzcT0mDDPVxPk02FrbdYHK72Jj7v0BaG5PgJOIjMtopn8LM55yZ4IL/OLI/JYGd0APd/CzfSr1X57btTy4C2VtKC4WA9ef9xkqGyCv7N19NxqG8mzBiGs1VmQ6UZzZs058hBLYa/0l8m3hI4sZFnipdGhXf/a98ascSjU/9rSDUIQlH+D+M/tjGWyJPCKzhF2VgYBvmS8iTlMx3gdGU7BjA6TvsnLKL58guO9ZzqTyUl6xrEvdo4gyE06PhYx5+IyHM2Tu5eenQ38LfO244Ed7qw/WGBQ9LVZ2qZSLTEGdqnXzZL7dNh3tvufKX5UShaGsXOkXVDVCYw7evJdU9ppXWauyd+GXVM20ETLw4m64otv/ffyZZF9AvW+P9PJkgb49O6zFt7eXZiFBrIQDVyeWpGQ9lcDlQMDP4ONl73B7VT65LAW2X9+/yFML1lTIWsXvdB2GQ5MGdfdtFzkKn9xm7jw3VKf1WzAfIp1a7Yd24p2kn1ykFD30CAKzLvQIe1MBCH4+7mVNABqCLycCjbQCLHVNVbAcph2wMIrb5asFEpq3KdTm6fduZ9DbaSMc/t2TAUu6rPLwpePIScCxT9CnX927W3vNal42KPZljuXnKpmf9Fiww0e21N964/HWksjnK3WrMxGow44+oqc/g4/eNIF8+kDPhq2nEjNGd1ySroZzkq0rIvEs5qMHdQ+wRehoDyFUrfbdFQaxkDOC6+93eTqjZJmHy5Ek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613e648a-c6fb-41f7-0117-08db23b39a08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:49.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0vY4xOeM2lXXlylI+u8DS+pPShcWINoySMRYgq24vDVrzPyuI2Im0ZO/6lrPyREiMX1lONeCcUKdoXT6rVg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-GUID: VXR0zrVEFqHUXxcrdtD_7NzGJ0jW3VUA
X-Proofpoint-ORIG-GUID: VXR0zrVEFqHUXxcrdtD_7NzGJ0jW3VUA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventually we will drop the sdebug_queue struct as it is not really
required, so start with making the sdebug_queued_cmd dynamically allocated
for the lifetime of the scsi_cmnd in the driver.

As an interim measure, make sdebug_queued_cmd.sd_dp a pointer to struct
sdebug_defer. Also keep a value of the index allocated in
sdebug_queued_cmd.qc_arr in struct sdebug_queued_cmd.

To deal with an races in accessing the scsi cmnd allocated struct
sdebug_queued_cmd, add a spinlock for the scsi command in its priv area.
Races may be between scheduling a command for completion, aborting a
command, and the command actually completing and freeing the struct
sdebug_queued_cmd.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 415 ++++++++++++++++++++++----------------
 1 file changed, 241 insertions(+), 174 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index fecdaa5be11e..4db66edcc9bb 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -250,6 +250,11 @@ static const char *sdebug_version_date = "20210520";
 
 #define SDEB_XA_NOT_IN_USE XA_MARK_1
 
+static struct kmem_cache *queued_cmd_cache;
+
+#define TO_QEUEUED_CMD(scmd)  ((void *)(scmd)->host_scribble)
+#define ASSIGN_QEUEUED_CMD(scmnd, qc) { (scmnd)->host_scribble = (void *) qc; }
+
 /* Zone types (zbcr05 table 25) */
 enum sdebug_z_type {
 	ZBC_ZTYPE_CNV	= 0x1,
@@ -337,12 +342,8 @@ struct sdebug_defer {
 	struct execute_work ew;
 	ktime_t cmpl_ts;/* time since boot to complete this cmd */
 	int sqa_idx;	/* index of sdebug_queue array */
-	int qc_idx;	/* index of sdebug_queued_cmd array within sqa_idx */
 	int hc_idx;	/* hostwide tag index */
 	int issuing_cpu;
-	bool init_hrt;
-	bool init_wq;
-	bool init_poll;
 	bool aborted;	/* true when blk_abort_request() already called */
 	enum sdeb_defer_type defer_t;
 };
@@ -351,12 +352,16 @@ struct sdebug_queued_cmd {
 	/* corresponding bit set in in_use_bm[] in owning struct sdebug_queue
 	 * instance indicates this slot is in use.
 	 */
-	struct sdebug_defer *sd_dp;
-	struct scsi_cmnd *a_cmnd;
+	struct sdebug_defer sd_dp;
+	struct scsi_cmnd *scmd;
+};
+
+struct sdebug_scsi_cmd {
+	spinlock_t   lock;
 };
 
 struct sdebug_queue {
-	struct sdebug_queued_cmd qc_arr[SDEBUG_CANQUEUE];
+	struct sdebug_queued_cmd *qc_arr[SDEBUG_CANQUEUE];
 	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
 	spinlock_t qc_lock;
 };
@@ -508,6 +513,8 @@ static int sdebug_add_store(void);
 static void sdebug_erase_store(int idx, struct sdeb_store_info *sip);
 static void sdebug_erase_all_stores(bool apart_from_first);
 
+static void sdebug_free_queued_cmd(struct sdebug_queued_cmd *sqcp);
+
 /*
  * The following are overflow arrays for cdbs that "hit" the same index in
  * the opcode_info_arr array. The most time sensitive (or commonly used) cdb
@@ -4919,46 +4926,48 @@ static u32 get_tag(struct scsi_cmnd *cmnd)
 /* Queued (deferred) command completions converge here. */
 static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
-	bool aborted = sd_dp->aborted;
+	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
 	int qc_idx;
 	int retiring = 0;
-	unsigned long iflags;
+	unsigned long flags, iflags;
+	struct scsi_cmnd *scp = sqcp->scmd;
+	struct sdebug_scsi_cmd *sdsc;
+	bool aborted;
 	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct scsi_cmnd *scp;
 
-	if (unlikely(aborted))
-		sd_dp->aborted = false;
-	qc_idx = sd_dp->qc_idx;
-	sqp = sdebug_q_arr + sd_dp->sqa_idx;
+	qc_idx = sd_dp->sqa_idx;
 	if (sdebug_statistics) {
 		atomic_inc(&sdebug_completions);
 		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
 			atomic_inc(&sdebug_miss_cpus);
 	}
+	if (!scp) {
+		pr_err("scmd=NULL\n");
+		goto out;
+	}
 	if (unlikely((qc_idx < 0) || (qc_idx >= SDEBUG_CANQUEUE))) {
 		pr_err("wild qc_idx=%d\n", qc_idx);
-		return;
+		goto out;
 	}
+
+	sdsc = scsi_cmd_priv(scp);
+	sqp = get_queue(scp);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
-	WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-	sqcp = &sqp->qc_arr[qc_idx];
-	scp = sqcp->a_cmnd;
-	if (unlikely(scp == NULL)) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("scp is NULL, sqa_idx=%d, qc_idx=%d, hc_idx=%d\n",
-		       sd_dp->sqa_idx, qc_idx, sd_dp->hc_idx);
-		return;
-	}
+	spin_lock_irqsave(&sdsc->lock, flags);
+	aborted = sd_dp->aborted;
+	if (unlikely(aborted))
+		sd_dp->aborted = false;
+	ASSIGN_QEUEUED_CMD(scp, NULL);
 
 	if (unlikely(atomic_read(&retired_max_queue) > 0))
 		retiring = 1;
 
-	sqcp->a_cmnd = NULL;
+	sqp->qc_arr[qc_idx] = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("Unexpected completion\n");
-		return;
+		pr_err("Unexpected completion qc_idx=%d\n", qc_idx);
+		goto out;
 	}
 
 	if (unlikely(retiring)) {	/* user has reduced max_queue */
@@ -4966,9 +4975,10 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 
 		retval = atomic_read(&retired_max_queue);
 		if (qc_idx >= retval) {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 			pr_err("index %d too large\n", retval);
-			return;
+			goto out;
 		}
 		k = find_last_bit(sqp->in_use_bm, retval);
 		if ((k < sdebug_max_queue) || (k == retval))
@@ -4976,14 +4986,19 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		else
 			atomic_set(&retired_max_queue, k + 1);
 	}
+
+	spin_unlock_irqrestore(&sdsc->lock, flags);
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-	if (unlikely(aborted)) {
-		if (sdebug_verbose)
-			pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
+
+	if (aborted) {
+		pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
 		blk_abort_request(scsi_cmd_to_rq(scp));
-		return;
+		goto out;
 	}
+
 	scsi_done(scp); /* callback to mid level */
+out:
+	sdebug_free_queued_cmd(sqcp);
 }
 
 /* When high resolution timer goes off this function is called. */
@@ -5233,115 +5248,124 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
 	}
 }
 
-static void stop_qc_helper(struct sdebug_defer *sd_dp,
+/* Returns true if we require the queued memory to be freed by the caller. */
+static bool stop_qc_helper(struct sdebug_defer *sd_dp,
 			   enum sdeb_defer_type defer_t)
 {
-	if (!sd_dp)
-		return;
-	if (defer_t == SDEB_DEFER_HRT)
-		hrtimer_cancel(&sd_dp->hrt);
-	else if (defer_t == SDEB_DEFER_WQ)
-		cancel_work_sync(&sd_dp->ew.work);
+	if (defer_t == SDEB_DEFER_HRT) {
+		int res = hrtimer_try_to_cancel(&sd_dp->hrt);
+
+		switch (res) {
+		case 0: /* Not active, it must have already run */
+		case -1: /* -1 It's executing the CB */
+			return false;
+		case 1: /* Was active, we've now cancelled */
+		default:
+			return true;
+		}
+	} else if (defer_t == SDEB_DEFER_WQ) {
+		/* Cancel if pending */
+		if (cancel_work_sync(&sd_dp->ew.work))
+			return true;
+		/* Was not pending, so it must have run */
+		return false;
+	}
+
+	return false;
 }
 
-/* If @cmnd found deletes its timer or work queue and returns true; else
-   returns false */
-static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
+
+static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
 {
-	unsigned long iflags;
-	int j, k, qmax, r_qmax;
 	enum sdeb_defer_type l_defer_t;
-	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_defer *sd_dp;
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
+	lockdep_assert_held(&sdsc->lock);
+
+	sqcp = TO_QEUEUED_CMD(cmnd);
+	if (!sqcp)
+		return false;
+	sd_dp = &sqcp->sd_dp;
+	if (sqa_idx)
+		*sqa_idx = sd_dp->sqa_idx;
+	l_defer_t = READ_ONCE(sd_dp->defer_t);
+	ASSIGN_QEUEUED_CMD(cmnd, NULL);
+
+	if (stop_qc_helper(sd_dp, l_defer_t))
+		sdebug_free_queued_cmd(sqcp);
+
+	return true;
+}
+
+/*
+ * Called from scsi_debug_abort() only, which is for timed-out cmd.
+ */
+static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
+{
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	struct sdebug_queue *sqp = get_queue(cmnd);
+	unsigned long flags, iflags;
+	int k = -1;
+	bool res;
+
+	spin_lock_irqsave(&sdsc->lock, flags);
+	res = scsi_debug_stop_cmnd(cmnd, &k);
+	spin_unlock_irqrestore(&sdsc->lock, flags);
+
+	if (k >= 0) {
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		qmax = sdebug_max_queue;
-		r_qmax = atomic_read(&retired_max_queue);
-		if (r_qmax > qmax)
-			qmax = r_qmax;
-		for (k = 0; k < qmax; ++k) {
-			if (test_bit(k, sqp->in_use_bm)) {
-				sqcp = &sqp->qc_arr[k];
-				if (cmnd != sqcp->a_cmnd)
-					continue;
-				/* found */
-				sqcp->a_cmnd = NULL;
-				sd_dp = sqcp->sd_dp;
-				if (sd_dp) {
-					l_defer_t = READ_ONCE(sd_dp->defer_t);
-					WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-				} else
-					l_defer_t = SDEB_DEFER_NONE;
-				spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-				stop_qc_helper(sd_dp, l_defer_t);
-				clear_bit(k, sqp->in_use_bm);
-				return true;
-			}
-		}
+		clear_bit(k, sqp->in_use_bm);
+		sqp->qc_arr[k] = NULL;
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	}
-	return false;
+
+	return res;
 }
 
 /* Deletes (stops) timers or work queues of all queued commands */
 static void stop_all_queued(void)
 {
-	unsigned long iflags;
+	unsigned long iflags, flags;
 	int j, k;
-	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
 		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
 			if (test_bit(k, sqp->in_use_bm)) {
-				sqcp = &sqp->qc_arr[k];
-				if (sqcp->a_cmnd == NULL)
+				struct sdebug_queued_cmd *sqcp = sqp->qc_arr[k];
+				struct sdebug_scsi_cmd *sdsc;
+				struct scsi_cmnd *scmd;
+
+				if (!sqcp)
+					continue;
+				scmd = sqcp->scmd;
+				if (!scmd)
+					continue;
+				sdsc = scsi_cmd_priv(scmd);
+				spin_lock_irqsave(&sdsc->lock, flags);
+				if (TO_QEUEUED_CMD(scmd) != sqcp) {
+					spin_unlock_irqrestore(&sdsc->lock, flags);
 					continue;
-				sqcp->a_cmnd = NULL;
-				sd_dp = sqcp->sd_dp;
-				if (sd_dp) {
-					l_defer_t = READ_ONCE(sd_dp->defer_t);
-					WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-				} else
-					l_defer_t = SDEB_DEFER_NONE;
-				spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-				stop_qc_helper(sd_dp, l_defer_t);
+				}
+				scsi_debug_stop_cmnd(scmd, NULL);
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				sqp->qc_arr[k] = NULL;
 				clear_bit(k, sqp->in_use_bm);
-				spin_lock_irqsave(&sqp->qc_lock, iflags);
 			}
 		}
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	}
 }
 
-/* Free queued command memory on heap */
-static void free_all_queued(void)
-{
-	int j, k;
-	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
-		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
-			sqcp = &sqp->qc_arr[k];
-			kfree(sqcp->sd_dp);
-			sqcp->sd_dp = NULL;
-		}
-	}
-}
-
 static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 {
-	bool ok;
+	bool ok = scsi_debug_abort_cmnd(SCpnt);
 
 	++num_aborts;
 
-	ok = stop_queued_cmnd(SCpnt);
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device,
 			    "%s: command%s found\n", __func__,
@@ -5543,6 +5567,33 @@ static bool inject_on_this_cmd(void)
 
 #define INCLUSIVE_TIMING_MAX_NS 1000000		/* 1 millisecond */
 
+
+void sdebug_free_queued_cmd(struct sdebug_queued_cmd *sqcp)
+{
+	if (sqcp)
+		kmem_cache_free(queued_cmd_cache, sqcp);
+}
+
+struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
+{
+	struct sdebug_queued_cmd *sqcp = kmem_cache_zalloc(queued_cmd_cache, GFP_ATOMIC);
+	struct sdebug_defer *sd_dp;
+
+	if (!sqcp)
+		return NULL;
+
+	sd_dp = &sqcp->sd_dp;
+
+	hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
+	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
+
+	sqcp->scmd = scmd;
+	sd_dp->sqa_idx = -1;
+
+	return sqcp;
+}
+
 /* Complete the processing of the thread that queued a SCSI command to this
  * driver. It either completes the command by calling cmnd_done() or
  * schedules a hr timer or work queue then returns 0. Returns
@@ -5554,15 +5605,16 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				    struct sdebug_dev_info *),
 			 int delta_jiff, int ndelay)
 {
-	bool new_sd_dp;
-	bool polled = scsi_cmd_to_rq(cmnd)->cmd_flags & REQ_POLLED;
-	int k;
-	unsigned long iflags;
+	struct request *rq = scsi_cmd_to_rq(cmnd);
+	bool polled = rq->cmd_flags & REQ_POLLED;
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	unsigned long iflags, flags;
 	u64 ns_from_boot = 0;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
 	struct sdebug_defer *sd_dp;
+	int k;
 
 	if (unlikely(devip == NULL)) {
 		if (scsi_result == 0)
@@ -5606,22 +5658,17 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		goto respond_in_thread;
 	}
 	set_bit(k, sqp->in_use_bm);
-	sqcp = &sqp->qc_arr[k];
-	sqcp->a_cmnd = cmnd;
-	cmnd->host_scribble = (unsigned char *)sqcp;
-	sd_dp = sqcp->sd_dp;
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
-	if (!sd_dp) {
-		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
-		if (!sd_dp) {
-			clear_bit(k, sqp->in_use_bm);
-			return SCSI_MLQUEUE_HOST_BUSY;
-		}
-		new_sd_dp = true;
-	} else {
-		new_sd_dp = false;
+	sqcp = sdebug_alloc_queued_cmd(cmnd);
+	if (!sqcp) {
+		clear_bit(k, sqp->in_use_bm);
+		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		return SCSI_MLQUEUE_HOST_BUSY;
 	}
+	sd_dp = &sqcp->sd_dp;
+	sd_dp->sqa_idx = k;
+	sqp->qc_arr[k] = sqcp;
+	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	/* Set the hostwide tag */
 	if (sdebug_host_max_queue)
@@ -5673,12 +5720,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
 				if (kt <= d) {	/* elapsed duration >= kt */
 					spin_lock_irqsave(&sqp->qc_lock, iflags);
-					sqcp->a_cmnd = NULL;
+					sqp->qc_arr[k] = NULL;
 					clear_bit(k, sqp->in_use_bm);
 					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-					if (new_sd_dp)
-						kfree(sd_dp);
 					/* call scsi_done() from this thread */
+					sdebug_free_queued_cmd(sqcp);
 					scsi_done(cmnd);
 					return 0;
 				}
@@ -5686,33 +5732,28 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				kt -= d;
 			}
 		}
+		if (sdebug_statistics)
+			sd_dp->issuing_cpu = raw_smp_processor_id();
 		if (polled) {
+			spin_lock_irqsave(&sdsc->lock, flags);
 			sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
-			spin_lock_irqsave(&sqp->qc_lock, iflags);
-			if (!sd_dp->init_poll) {
-				sd_dp->init_poll = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_POLL);
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		} else {
-			if (!sd_dp->init_hrt) {
-				sd_dp->init_hrt = true;
-				sqcp->sd_dp = sd_dp;
-				hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC,
-					     HRTIMER_MODE_REL_PINNED);
-				sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
-			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_HRT);
 			/* schedule the invocation of scsi_done() for a later time */
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
+			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_HRT);
 			hrtimer_start(&sd_dp->hrt, kt, HRTIMER_MODE_REL_PINNED);
+			/*
+			 * The completion handler will try to grab sqcp->lock,
+			 * so there is no chance that the completion handler
+			 * will call scsi_done() until we release the lock
+			 * here (so ok to keep referencing sdsc).
+			 */
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		}
-		if (sdebug_statistics)
-			sd_dp->issuing_cpu = raw_smp_processor_id();
 	} else {	/* jdelay < 0, use work queue */
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
 			     atomic_read(&sdeb_inject_pending))) {
@@ -5722,30 +5763,21 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				    blk_mq_unique_tag_to_tag(get_tag(cmnd)));
 		}
 
+		if (sdebug_statistics)
+			sd_dp->issuing_cpu = raw_smp_processor_id();
 		if (polled) {
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
-			spin_lock_irqsave(&sqp->qc_lock, iflags);
-			if (!sd_dp->init_poll) {
-				sd_dp->init_poll = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_POLL);
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		} else {
-			if (!sd_dp->init_wq) {
-				sd_dp->init_wq = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-				INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
-			}
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_WQ);
 			schedule_work(&sd_dp->ew.work);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		}
-		if (sdebug_statistics)
-			sd_dp->issuing_cpu = raw_smp_processor_id();
 	}
 
 	return 0;
@@ -7066,6 +7098,10 @@ static int __init scsi_debug_init(void)
 	hosts_to_add = sdebug_add_host;
 	sdebug_add_host = 0;
 
+	queued_cmd_cache = KMEM_CACHE(sdebug_queued_cmd, SLAB_HWCACHE_ALIGN);
+	if (!queued_cmd_cache)
+		goto driver_unreg;
+
 	for (k = 0; k < hosts_to_add; k++) {
 		if (want_store && k == 0) {
 			ret = sdebug_add_host_helper(idx);
@@ -7088,6 +7124,8 @@ static int __init scsi_debug_init(void)
 
 	return 0;
 
+driver_unreg:
+	driver_unregister(&sdebug_driverfs_driver);
 bus_unreg:
 	bus_unregister(&pseudo_lld_bus);
 dev_unreg:
@@ -7103,10 +7141,9 @@ static void __exit scsi_debug_exit(void)
 {
 	int k = sdebug_num_hosts;
 
-	stop_all_queued();
 	for (; k; k--)
 		sdebug_do_remove_host(true);
-	free_all_queued();
+	kmem_cache_destroy(queued_cmd_cache);
 	driver_unregister(&sdebug_driverfs_driver);
 	bus_unregister(&pseudo_lld_bus);
 	root_device_unregister(pseudo_primary);
@@ -7493,6 +7530,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		goto unlock;
 
 	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
+		unsigned long flags;
+		struct sdebug_scsi_cmd *sdsc;
 		if (first) {
 			first = false;
 			if (!test_bit(qc_idx, sqp->in_use_bm))
@@ -7503,37 +7542,51 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		if (qc_idx >= sdebug_max_queue)
 			break;
 
-		sqcp = &sqp->qc_arr[qc_idx];
-		sd_dp = sqcp->sd_dp;
-		if (unlikely(!sd_dp))
-			continue;
-		scp = sqcp->a_cmnd;
+		sqcp = sqp->qc_arr[qc_idx];
+		if (!sqcp) {
+			pr_err("sqcp is NULL, queue_num=%d, qc_idx=%u from %s\n",
+			       queue_num, qc_idx, __func__);
+			break;
+		}
+		sd_dp = &sqcp->sd_dp;
+
+		scp = sqcp->scmd;
 		if (unlikely(scp == NULL)) {
 			pr_err("scp is NULL, queue_num=%d, qc_idx=%u from %s\n",
 			       queue_num, qc_idx, __func__);
 			break;
 		}
+		sdsc = scsi_cmd_priv(scp);
+		spin_lock_irqsave(&sdsc->lock, flags);
 		if (READ_ONCE(sd_dp->defer_t) == SDEB_DEFER_POLL) {
-			if (kt_from_boot < sd_dp->cmpl_ts)
+			if (kt_from_boot < sd_dp->cmpl_ts) {
+				spin_unlock_irqrestore(&sdsc->lock, flags);
 				continue;
+			}
 
-		} else		/* ignoring non REQ_POLLED requests */
+		} else		/* ignoring non REQ_POLLED requests */ {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			continue;
+		}
 		if (unlikely(atomic_read(&retired_max_queue) > 0))
 			retiring = true;
 
-		sqcp->a_cmnd = NULL;
 		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u from %s\n",
 				sqp, queue_num, qc_idx, __func__);
+			sdebug_free_queued_cmd(sqcp);
 			break;
 		}
+		sqp->qc_arr[qc_idx] = NULL;
 		if (unlikely(retiring)) {	/* user has reduced max_queue */
 			int k, retval;
 
 			retval = atomic_read(&retired_max_queue);
 			if (qc_idx >= retval) {
 				pr_err("index %d too large\n", retval);
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				sdebug_free_queued_cmd(sqcp);
 				break;
 			}
 			k = find_last_bit(sqp->in_use_bm, retval);
@@ -7542,7 +7595,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			else
 				atomic_set(&retired_max_queue, k + 1);
 		}
-		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
+		spin_unlock_irqrestore(&sdsc->lock, flags);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 		if (sdebug_statistics) {
@@ -7551,6 +7604,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 				atomic_inc(&sdebug_miss_cpus);
 		}
 
+		sdebug_free_queued_cmd(sqcp);
+
 		scsi_done(scp); /* callback to mid level */
 		num_entries++;
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
@@ -7733,6 +7788,16 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	return schedule_resp(scp, NULL, DID_NO_CONNECT << 16, NULL, 0, 0);
 }
 
+static int sdebug_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
+{
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmd);
+
+	spin_lock_init(&sdsc->lock);
+
+	return 0;
+}
+
+
 static struct scsi_host_template sdebug_driver_template = {
 	.show_info =		scsi_debug_show_info,
 	.write_info =		scsi_debug_write_info,
@@ -7760,6 +7825,8 @@ static struct scsi_host_template sdebug_driver_template = {
 	.max_segment_size =	-1U,
 	.module =		THIS_MODULE,
 	.track_queue_depth =	1,
+	.cmd_size = sizeof(struct sdebug_scsi_cmd),
+	.init_cmd_priv = sdebug_init_cmd_priv,
 };
 
 static int sdebug_driver_probe(struct device *dev)
-- 
2.35.3

