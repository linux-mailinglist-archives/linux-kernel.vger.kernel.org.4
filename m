Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CD6C9C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjC0HoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjC0Hny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979E3A9A;
        Mon, 27 Mar 2023 00:43:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7UWO6011911;
        Mon, 27 Mar 2023 07:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=CFbVnRCbp8kb/+4WUvNh36x/qZFuDuie9cKdEUsnwYLTI1uX3AtgILZiFppl8AWEY88Y
 xtp0uGkbUIaT72/ShHd1Tgb64mwyWC+GvUwkVWnY5Ucl6aviAedqJdZdfYNY2evDfJ58
 Wnwen5RHkj2W2PshXPT7ygKYfpHFMCweT75L4J2LtKKolFUOxOEmUuMde2yobwQjJWx2
 DRChMb8O7Ncbhg39rpG5OIr3gIUKF9bDmzmrbxhtIvKzvk+hhOgnz9vKgYypOmycN5C8
 2BlWgkUkCqvI76L/Rjk3MhxVxaCV6Gwhux+Pkj/1lY3oe/N+jtSNplOz/zRDxZaeFOJg 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R78xFe032830;
        Mon, 27 Mar 2023 07:43:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdc4vyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3ACjbBxLvkUsL3X3WsvDuPui1yDMeh7kRxsjGuvQK6oMdcDABR4g8cIkd9HSs6ScQuSxxZuJW6Jz9GBHCCCfREIxGsIucxjpCw2RkQXFSEkpOLXQM+ebURGedFCEJ81uz9LzL5DlJYkhrFQMpI6vMEVr+RPw+29yvetaTYxewzH8pYq3olQ0KFyI05FYa1x/o8o/o2d6luVq/QHOwixNKGYe/Z/zrjqZXd7SR+gHs1c9Z2ko4VINk4+VFBO+jXedKheP/tMoBtDrOZRfHQG1W1V1s8SHrDN+iODVThbBa6SzEKyXs00JHVsoOc3A8gqXgTjshbmXOjiEKGp6Mg4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=U9Ln/7qbMRfah8SueCIAaMuszRNcW4fsezzoEdTQX+K/BQuhRmnJAAXufiO9DewAPWbNH9fXfqKawLEwSKNuZgdKnxfWtHNJMrLvcHID4h4yiz7RdFg636Ex1r1aGCZNAx04rc+q4g6tRuGfBH4M+66+WzYNzrCzRWe7z6Iwqn39nwOfhw6R1+XnU9J9/7FTy7Q3qNhsr3Oo7iKoMTrIlRgqhnezvu9LMU4vWqZuUpBAwHKKM7W2arBgM6+HRh7MAiXLpAMwHZOWtKKkrOs9th4OAHdl6adBVFe8zMC90lawGqwuQEKhVTYaDihlnXYjqnPeAy9n3I3Tr0CZvaayeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=rK4bObvYGPlGshWDRdH3UotV1Vqr8bMDCnJc6YyVRtFdUSxxUh5vIFtAcTKNYNSsBtw0VNDDLc3+QhQpxpAxiNPglC4Mdcaa/t6YxQPuA2soar4SkxX3v+P9l8VgdUDYtl3SB4AK5wY8EfoNvI3uNP4E0SxukpChYEbshXwn/BU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:19 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3 01/11] scsi: scsi_debug: Fix check for sdev queue full
Date:   Mon, 27 Mar 2023 07:43:00 +0000
Message-Id: <20230327074310.1862889-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:5:74::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 761a205e-4817-4f9e-d396-08db2e96ef56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNag7CZFjnC+5GdStFkNMjsz6pqbTy8wijP2rUq+SIkKu8LZYwUrovLGA8wI9secXUmYgZO0WpjcNTFB3O+hw513cRRYLjeKqcGtDYASlDaufnp3w5RdO407FvBDDPDbRrRjXBICYuxVF10C0PPQiklT4kZIplClQqnL5y/ruBZSfeDZzEBt71fIeEcb3zbC+oos95JKNqRSv/FRE9PBKSiULchjRIAH5IV2SrkQc74cyDYLXD+2Qv5jkm0ChR+8STCnT9eL2aNe+oV942mtrH42F4udyNhhPXLj6tS/gAQLs9qx7AhBWogneNieKpGTrWv8/akeO/VkHuHugmNQ5cuwKjgLX/lhT9HJoNSkUIbPqA/pa3ICh168tGD8wqCBaJ4FRptP0reg5i39f5jf8kvVy5OdbA8bfJk3Two1FJkpQ72DAAI6sfVpdJ95cXCafV2bAm4emRjLVn79ndfYxJPRJ7OwH7kq1VTey3dnGuSI2uc5NbtwO42EBlJpgHp3azhj7z6B80UJYrvJRfBEpFMdKVs0lGfUukkZTgCXK7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(54906003)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(2616005)(86362001)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sh+E0RA2CPapXzYD/xGZpLOIDhWS8aRtjEoWY9J1JwzuQLBrbd21fWfYUahy?=
 =?us-ascii?Q?Kggq6MYlgCI1EHi+uOY1vAU+EklcNF8TkMiEniZLzGFNNz9hUMmdjgXRhjcl?=
 =?us-ascii?Q?cB79AhS1GJja98swtM3R151N+D2/jjaqepXIpoX5ZyiB6ZhwoVe+EPcV4Iiw?=
 =?us-ascii?Q?TaMaCQEA7ZRTTGG3837Blz44nNIuISS7wnIrfeXXOVL5HIeXHPE21DjYM2c4?=
 =?us-ascii?Q?51CwojD2SwgyoZW0z8og+CXv7oQQmS9l8AABnaWHRT876gdX4vENZqgQOBhN?=
 =?us-ascii?Q?ZnhoIrfxxNd881FVq6YFttB9fNBUif9uBUKFLLnKBsui5QWb4MC7TIRJJ+ie?=
 =?us-ascii?Q?SGuwNAGsqV5g7QBYlcpa2kSTqam5l2mu5DanE6/ctqy9Bax5eNz06/G4Hq2i?=
 =?us-ascii?Q?Gt6hoOjZn9rcRpSZwchQSzX5qNliL2kwJYKk1NXdGoI4FZruf466ey+diMeh?=
 =?us-ascii?Q?O6+QUmtEzhqlwstxOBimhfpZHC+DwyaqxLrUteqYkh7iNUFtUX96VwVCsoj3?=
 =?us-ascii?Q?zXRgzJw2a8XI1LW+Z1NRS1a03q9pwMz+6ujsjuy07P2ILcAp5SPKDnp+xBYi?=
 =?us-ascii?Q?n5nJiBbNq+haxted8CAA+PcLIyn/eeZ0nEj7U5K3aR82ZZkf7Y5EBnxl+2V3?=
 =?us-ascii?Q?B7nJpgwJ4Wj5VfZJyJvcfLHkGt60ePEallCw1uK8lPoQ09drJlcTvxBHsK5Y?=
 =?us-ascii?Q?cUboyVCfqmOHloocIfGH5GBhLQhc84USRZXMTydN9X8mSxtPee6tYUGyds+C?=
 =?us-ascii?Q?u2S4PFqb6NZWMUXPYI0o5Uu1LEhfWWlEJyTdgrotvOwEuRTLGAQL14qT/rs+?=
 =?us-ascii?Q?6JS7g/gED/qiKy5MRkRTXtRy5dF2Zwlkg+ntm5fs05MZDJwsWSjQBLH1hjLM?=
 =?us-ascii?Q?RiXDXYeuXdQoyjU/28lHAG/xTeHIXlk1hb4/wUUOsUlV/XSFCxOiQF7CzHxL?=
 =?us-ascii?Q?9AQZ7PrDUEFxhRcm9dC2OaPb9Dgq0/7A0MtfeeRC7j3bCJnt8cJOn6FEAc+X?=
 =?us-ascii?Q?jTlfiWnZz47Cw0i9kCQnHkCh5rV2F4wW31iGFlflgE0RxuWUjmmBpTy9w8QK?=
 =?us-ascii?Q?0ra5gCSXuiUSRU+jyqNM3C1wlpwMyPvwgacZ4s5FWypbyeIidi4ZaaA0z4hY?=
 =?us-ascii?Q?cVcrjay2hyhaDcOvW7FxLGCVm9O2eiQ8ArFTiZOuhkFR/9eLMHOkQ5bR9uf9?=
 =?us-ascii?Q?SJ06SBbX2T9Lb93Wf51P2NFeR7Jhpt6x+jLL6zjmmLh+nhGBBtu78c3zzKqp?=
 =?us-ascii?Q?oC1WKAHkS/QcIsi5k49bjywQh6TQ+tFl0uL2SOKn25PboCs1TCglcZqOulAD?=
 =?us-ascii?Q?AYcDFYWKRoVTD2DU/uuDYJue6mCZXNc/VTUOqwZgvXxCV+6VATnVcXEC1udW?=
 =?us-ascii?Q?FCy/71zkouib6fCc4V0MFIAvi84ntKyf6huJ6DMqHPAYtCDW0QfOhLuffwUN?=
 =?us-ascii?Q?6hQIYA9+UEHYr1VQ9bsXDkfRLBiZgSr4G66ryRRMnNzKTdYIVhU/4ph/OmVv?=
 =?us-ascii?Q?19I694qCUs+IOX/JhbRiOsRbffCQ0Cf+R4AmkyttIJ8rbHo+L/N2/u/Cf3h7?=
 =?us-ascii?Q?e+5TJyptyqRV67kXUSd+bdI+YKfsD5AzbIIWB4jflLh87MGM+oFWpM9VZulK?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bd540h/zif7lhtAPJzcKv7m6cEWatDE3X19c+zMuBypCd939pDolowdVKbqntag3zT1GuJm6s7qF9KiWdrIbSYVN4JScWaUSViho+dS6V722uD5sVo37eO50mEOVLjYhyzJUv3HHv6eHXIIV/fDTf7RE+K4Wx2SHTdHM0hyPQ/VXmbCLYm7otcBgX+vsf2aTbgklZGV2EpgyRPTUqvozLd8LcVXW/BZuKqBcTGWxV6EDjuVCZAyezBWnfdRpMl5ieyjv1eyJ4hSruPclT+Nq0lw6E8q5wey00ByT1n3qOf21oV3eT6hYauZr+aM25gIg58FLXibe/zIJI49z3v7LkyY0zywiqN0ZePx1A/tKoh1skBNGR3G4plQiNo5qjbGC+X9JxYTINlLs67UtW4Rz58OJYlJUpka7Q2NIvUPEfA83iralUgeg1LljGsAu7QN0A0vJAPI+DWPmZTGQwF82uzIor7HDYK6XeCHQkutRgkUXfDFEO/hYa2u6lyRQaUeyzF3T6i9/qVBB7zMpn4Xti49pRsSZySD3EjcVLXhMljHNW/yxdYnzuIuiaRUxSdcbSQ95oIk3xrn15nl7H021hDvkj91o5RAGVBeEjfiOAtBfKsaX0N+0V/VCD+OFBgLk7lfs+tXOj9o4sDUyUQWEhGw1ywiDfcTKboTkvjKeHS/AX6dw9XDqclbLxaLxhQgJxYbVDfHqPtB1nV1bH9lH8oQx2PusccVmVYokT8LJycXLz1m7Lc++jwNga5UJpEc2JDIoipCMjRDo40+QexW39/KBPEU9CC4iZDa8IzgojejwG8kCMJZyrTD5qBrvKxyeEgvtMETTF/TweupIsvRD/JMqVdNT4HIZj+MCT+DLkAxiRJlRW1W+wn7oKKpUdUO7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761a205e-4817-4f9e-d396-08db2e96ef56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:19.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZzEUqfjYXvEzeFQXDy+/EdZOQ8Im2JQC+LYljZSAL8nu+qfCqT/QTmbnAsDdgeZEux1iIGqAjfY3J1wFmVc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-GUID: FLhV0qV68jDpUq5e0-xH3ntVw7uu7diR
X-Proofpoint-ORIG-GUID: FLhV0qV68jDpUq5e0-xH3ntVw7uu7diR
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a report that the blktests scsi/004 test for "TASK SET FULL" (TSF)
now fails.

The condition upon we should issue this TSF is when the sdev queue is
full. The check for a full queue has an off-by-1 error. Previously we
would increment the number of requests in the queue after testing if the
queue would be full, i.e. test if one less than full. Since we now use
scsi_device_busy() to count the number of requests in the queue, this
would already account for the current request, so fix the test for queue
full accordingly.

Fixes: 151f0ec9ddb5 ("scsi: scsi_debug: Drop sdebug_dev_info.num_in_q")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303201334.18b30edc-oliver.sang@intel.com
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7ed117e78bd4..782515abca2c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5580,7 +5580,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		int num_in_q = scsi_device_busy(sdp);
 		int qdepth = cmnd->device->queue_depth;
 
-		if ((num_in_q == (qdepth - 1)) &&
+		if ((num_in_q == qdepth) &&
 		    (atomic_inc_return(&sdebug_a_tsf) >=
 		     abs(sdebug_every_nth))) {
 			atomic_set(&sdebug_a_tsf, 0);
-- 
2.35.3

