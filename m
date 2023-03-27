Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE056C9CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjC0Ho3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjC0Hn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE4213F;
        Mon, 27 Mar 2023 00:43:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7UQdg011809;
        Mon, 27 Mar 2023 07:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=S17hF1GsYVXbSkIhmkwRDLjUlWb6GePaYmwY60w7+VM=;
 b=jDmw0WnnqpQ3l/zTV9aZ8wsPUZDmn23O6xdTIC04h+JDMqmQx1Fpk6xo1kdSwJ7mUPq1
 pOycU65HXibVHz1ikDVbgFyu/iAE3apWxUfhAQxycX0DHvvp1TxlPzXDEEeV+khnhbpm
 C8B8ISI4QfazSXKIb+SOumH6UnYbgBRzQf3ba+5HBqU9iGh/Xn+2rWoB1ggxCXAuzkwC
 laKqfORRpfgue6nRScS9VXNjhgD3oV3NprzRplYIJM5mC84PbdRfyMMVjw3t9+R3XE1q
 wmZQUib/bXmJReuAzo8rsRiAwhc08S2d90avf5oFCYdTvIdxebrN0P522T7UqR9dmEAA hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R7XUfR020313;
        Mon, 27 Mar 2023 07:43:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4mwa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+CA5shhmDu/dPOCRfqz6jhv4N4D/P7X6Ejd0hKikG5orR2HpRNcsgRZKUVoKudkmvDs7EQSltIL7fEsk9ZyxAuLP3DBgwLpclYsQHxmk7XD9ceHzSPumevcKa02Sa/C6UIO5zLX58RVGp6CCyerDCLbae+QQXfrZziFWIZOYgxm7GXfwQvutyZI9VH/VubLL5123yjq3kOdcMKG7OX0MLG+Rv0/HRAg1+FEo37SVneT0jphHIiwZhZrrDrRTgnSRCQkHzSPmo1qVTwDFZmcaRR3YPhl35ch3Shkuymy34+EUISdMbx9bZ7asfL2H+N2+/NcjKxPx0dWxbc4j7d2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S17hF1GsYVXbSkIhmkwRDLjUlWb6GePaYmwY60w7+VM=;
 b=PKyBAWowsh3YNrJ861Vs6UKqngd3NTkiUlV0GjPl8AoWmI5loQTu49vza2wv73TbcAEJLbWtMd0GeGjH9xUFE9LCjkjOPMsSHz0p3gS2PzYBhzRL/ogC+YDIcR6T2DEDhloqcHl12/uHP5hXr9jVY7qP1w8BifRy6Ss2uDXRCpL8aWc7dkeBQuLsBQHaihwf3a+kLVE4HN0YOnXntwxw2nLLX/Ua5AaNHxPg04/gmzYAb1b1js77XOSQaruFdhk5RjmU685SO/SdRnmOmTimi+Pxm/MA+9G4sbZJkuEH8238ctPXtgeDlR2umWmszK4XG7dqSMrtc4n3WFV3Va4V5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S17hF1GsYVXbSkIhmkwRDLjUlWb6GePaYmwY60w7+VM=;
 b=XsYo+Tc9YMU+dYjeDf3MAnn2fulFlVWTkhj/RXdPluszrYiYj1kf+RItNBwDdOC8L8aKkNQtMMF+NeW7pTTcEvX4BFvjjgCdzViczTxhjZm4PfvOKlKocwrre+NyaQIh5N20jM62cTPT/5r9i5vZo0AfntvL0GZYqEDgsC1Oc5g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:27 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
Date:   Mon, 27 Mar 2023 07:43:05 +0000
Message-Id: <20230327074310.1862889-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:5:3af::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c53e66c-63a7-4212-a803-08db2e96f3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/Fcfy3wmCjUXKaezPq9+22hyPgVnIN4GJLoHs/Ug1kjbBUqp/BrkmHtJ2WPgnSMJ8nSFDZ27RMe8yYXkDcXascfsn39EVjtqNQlM6CJ4G7ikuU5i20CIkCcaKnnUc3v7stJ5G2uqy5Dulg483OQsLSBgJnwlp3UxV63ishDbt6h8lSsxgTXYNrZdShz/8T/V6T1NzHuDEQyX8xK3B/2inRaFbD24HCDdJ2U1uEHf1OWKJxx4sQ3SMMGkUi3XS2lFVor61Z6KCrg1m332UDdGknnKlpeJ+1d+qqMYPFVs+LgEOgFsmmP3sBVi7BsKpxWWh+JRvzLZVRMaK0JJPlNDzbpkGlGsXsA1FkHRHbHKr43U/VSY6OyzB/WKXYDCI/0o9iPKHcEykAJin/HVLHsDC46yCIVOmmSm6i6X3oNaF1tKvVFW7wde5VR9DhneIJJChng0flE63kLKQf9VJOmTjqNqR0v2w096dYIgnWKOGb5x69M4on6lTDPT+9snTWfvsKEAcF3u6kfYP5idb2TPKFtds2Mn0AivxgdMu7/9z5pIfcdefD9LYb3Wsv7Yffh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(30864003)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(66899021)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIiGSVGRUu8rIKB2pdmXJ3veFTP9LVdDWHbpW5LWv5HWp3v2a9k2ZpaR2+a3?=
 =?us-ascii?Q?V325nmld+vgYTYVs8Iu63v7S41MIn+r1Mkki0FFMM34v5D3GKFjolfcre0+G?=
 =?us-ascii?Q?wftaOcdWzvfAig12dihO/59M+WthBBqDUwDnxlFB+FgY1ixX/5thx92vyLt0?=
 =?us-ascii?Q?PGeZy+CzkOYnvzLVarJcBFw3mV/K0kVi1ryyuLjro7pvgIAe+fOZx+4qtN4b?=
 =?us-ascii?Q?+OL5SgWR7G4nXcmiXFzZraFbtdDYmcZ0JQXq2N7XLGLEvKYIUuU7F3nwP6e8?=
 =?us-ascii?Q?cMPbt0qGa9WII/lBVKvnLBMatxi/DkQqvTIbNfoEsbWIKD5/qT0AsRdtx/uS?=
 =?us-ascii?Q?B+M9PLrqEqx48kYbJw3KyVW9EZzGAXcvPcky194Tv809hiWX7edGBQgz3sUi?=
 =?us-ascii?Q?zTQ6/bvZi3GcMCSjFkY8ovRvRg7qiKdd73LdlkwNdZutVIiglDb2bshk/lbZ?=
 =?us-ascii?Q?Ckj3BCI81lXMykhVSTRCr1lboaq5gu1bYZaSX9f4mYeWAimIlXszD1VulCyT?=
 =?us-ascii?Q?K8ZpGEQieylHzFOekV3wJAq13S0vPO7pSnXzOo/2O/7Ca3q6D0eeuYvw7Eax?=
 =?us-ascii?Q?mmFmj2TK6ZC7xiPO+60aJkuavfFHIyVpzUQkyLCLlZqhKHhdsxWUa2m+0mlg?=
 =?us-ascii?Q?K6sG5gIub7IVFEOmzZyaZEj+8jJqRrwoHEbSmwL7jz0VZ0U1bUrAS9LmPv7x?=
 =?us-ascii?Q?yX0nyT4nTlGZjq4a/pVPCuU3+TgTjnyNpKdF55QQed+6EldY2HZbq/vvRuc7?=
 =?us-ascii?Q?St8b6Fa4jIj5wWhPOe7AKB5RkUP5IlI/gfWRCF5ToSEOZA8F4otKh//zlkQK?=
 =?us-ascii?Q?KVxS2Vps8lzTxnM8pNniSe8RGyEOV8B0Z71mfCs5nLk1FZ5MdYYV+FD9QdGn?=
 =?us-ascii?Q?h77CIWspQPMGuHWQ/QV8gfjze24CJ0X47HdSyUrZUNkV9wPQ2Dkc5t3ZGYWw?=
 =?us-ascii?Q?H2m34uyLgGR6GSQT8r4lhl0q5QhKHrfw9Qnu8/GGd54J4pWFmoE0uXQcIAr+?=
 =?us-ascii?Q?A9eRW4/zs3Ki9jjt94ohSJyFrMK6zJyjXop6OWXvj6gNFLiJckl57cFOipgs?=
 =?us-ascii?Q?KJXQRVG98BNnA4WkdQD/FAVt/5COh/C1dt+ToB0gO3g1Al0GX7pF/uPdj2rA?=
 =?us-ascii?Q?WNZy4cq9qRNqjA1KccOnJ+uhM8fHx7BSw91Z3T991SC+ceJxnfRIMcfV+IqX?=
 =?us-ascii?Q?ZTD9rqBBLFKa0fn+lw8b9U6kTgyvhpMfpudfumkIDbMFChzQo59zE0HqcrYr?=
 =?us-ascii?Q?fSKTdnZnhc/Wex/F995PV1otNw0gCj5lpcPdRFFz3EUfp/je7CmpqSsJWOlW?=
 =?us-ascii?Q?KrTGWuPnyzvF37A3QpeQmpmdds7NO5SFtVx1g8sS7tVCSc3ezub7vmNbtUyO?=
 =?us-ascii?Q?ja4yo14nuBaqC/eDqhcPOQX3zhRvVNIhL80wlqbMR7pk8WfZoIPGM6L5c0oJ?=
 =?us-ascii?Q?wVOhr+DQHcT7g1gg3yW7k1OAr01P8eHH5vS6D/UKmPrc75mN5dP0FNOPwJF4?=
 =?us-ascii?Q?G50Fyn3L9e9zs7jQjtyvEqXDns3Y3Btb0aZZSzaNYcK9m2mUhKARugrCDEHn?=
 =?us-ascii?Q?y7OnWjpUrPU482EuC4lIMC4fQnVSV0q7dbHng1JrjzmytsLkJurA/lSLY8kf?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ScJBwUxF5ELJvG0BeJmYfbUZDYOOt5OG9FGx36GI0Ue90ge2G6+RySsEbfa6TTMxP3Wmq75Rz0qfgXOELJIo490a848jbrMJsrn1we+X/cFeZ6lCm4ddyJjvohQKHJ1MFaCxDJqYPy4LIXLiKuhK7aAlaRgM0En8yJa7UucNyvQ7FvZvHzgLGhHwOY1WLGPYMqHfAwMK4kfiYvLBvqEWfNe3B3KqTJvlYupFYs1/Isp2h5H4PfXIhN/EMGeycbBgeRMRyhha0JtROvXbqYmDNde1ElRazEGMTFGLLPLoLPTnssgXNhtN8JrPDv1MCnLvPMaBx373j6a52uACXekz7x76kIxUgLMVWh6OUuqdakHOiJIWYMeupaHL6OfntHq+sfu2DPgJnuWScwVKi2ogsMgKA1pHeKSCaQNdcw/TMLXJeYM6CxKH2SU8QdzeQ0orShBxVFIHwwBwKRtbBkcoPOBOO2+QZxKLPZzeDMq3gz1fqwCVaQNVhGGpFTBBiwRVlBHlRMwP5uYhg+Oydv1a5Uz+4YQZMLwNU0F6VxooFlc0UpY+njeQ+ePkqvLEBkfbi+HDneKu48TyBLYItvjzO95u+62Wg9J5g07qnCD6EQXdxAQpP52Z5xAWAZVNVxhRfytBO9pKokIo98+YPJryTZn83LkYtvHYXlFbSIs9j9mYP0FSpEUXsMxQqojkNVlXzs+YjrQG9a7Wk/WV9gL2abv+fxmZ5TDSrfRQCC2omdVC4O663brvjW9fDKn0kQ78bHPESq/+NfFNr+79/XCLGZetnrgcqbRoXZznlgYvqxXR6JmilYYUFhPpFSY1aGgdVXIane9VQxV4Eh0qZhS6aKyL7Jnq2rTmBMqSaiczD5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c53e66c-63a7-4212-a803-08db2e96f3be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:27.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnncfoxk+xXJbjQT9LbdMoh/MMxFm5c4NLtURuK6ZlSVlKigfmw0TGc3eUP7fEymFLqAByE4zyRjwA9CxPm85w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-GUID: vKVrxNQ5y6_Vtv16K_a_xfhbgX0z7-jo
X-Proofpoint-ORIG-GUID: vKVrxNQ5y6_Vtv16K_a_xfhbgX0z7-jo
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/scsi/scsi_debug.c | 427 ++++++++++++++++++++++----------------
 1 file changed, 253 insertions(+), 174 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index f53f3e78aaa1..7dd2dd6cbd6c 100644
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
@@ -5233,115 +5248,126 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
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
+	} else if (defer_t == SDEB_DEFER_POLL) {
+		return true;
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
+				scmd = sqcp->scmd;
+				if (!scmd)
+					continue;
+				sdsc = scsi_cmd_priv(scmd);
+				spin_lock_irqsave(&sdsc->lock, flags);
+				if (TO_QEUEUED_CMD(scmd) != sqcp) {
+					spin_unlock_irqrestore(&sdsc->lock, flags);
+					continue;
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
@@ -5543,6 +5569,34 @@ static bool inject_on_this_cmd(void)
 
 #define INCLUSIVE_TIMING_MAX_NS 1000000		/* 1 millisecond */
 
+
+void sdebug_free_queued_cmd(struct sdebug_queued_cmd *sqcp)
+{
+	if (sqcp)
+		kmem_cache_free(queued_cmd_cache, sqcp);
+}
+
+static struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
+{
+	struct sdebug_queued_cmd *sqcp;
+	struct sdebug_defer *sd_dp;
+
+	sqcp = kmem_cache_zalloc(queued_cmd_cache, GFP_ATOMIC);
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
@@ -5554,15 +5608,16 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -5606,22 +5661,17 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -5673,12 +5723,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
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
@@ -5686,33 +5735,28 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -5722,30 +5766,21 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -7066,6 +7101,10 @@ static int __init scsi_debug_init(void)
 	hosts_to_add = sdebug_add_host;
 	sdebug_add_host = 0;
 
+	queued_cmd_cache = KMEM_CACHE(sdebug_queued_cmd, SLAB_HWCACHE_ALIGN);
+	if (!queued_cmd_cache)
+		goto driver_unreg;
+
 	for (k = 0; k < hosts_to_add; k++) {
 		if (want_store && k == 0) {
 			ret = sdebug_add_host_helper(idx);
@@ -7088,6 +7127,8 @@ static int __init scsi_debug_init(void)
 
 	return 0;
 
+driver_unreg:
+	driver_unregister(&sdebug_driverfs_driver);
 bus_unreg:
 	bus_unregister(&pseudo_lld_bus);
 dev_unreg:
@@ -7103,10 +7144,9 @@ static void __exit scsi_debug_exit(void)
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
@@ -7493,6 +7533,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		goto unlock;
 
 	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
+		unsigned long flags;
+		struct sdebug_scsi_cmd *sdsc;
 		if (first) {
 			first = false;
 			if (!test_bit(qc_idx, sqp->in_use_bm))
@@ -7503,37 +7545,60 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
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
+			struct sdebug_queued_cmd *_sqcp = TO_QEUEUED_CMD(scp);
+
+			if (_sqcp != sqcp) {
+				pr_err("inconsistent queued cmd tag=%#x\n",
+				       blk_mq_unique_tag(scsi_cmd_to_rq(scp)));
+				spin_unlock_irqrestore(&sdsc->lock, flags);
 				continue;
+			}
+
+			if (kt_from_boot < sd_dp->cmpl_ts) {
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				continue;
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
@@ -7542,7 +7607,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			else
 				atomic_set(&retired_max_queue, k + 1);
 		}
-		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
+		spin_unlock_irqrestore(&sdsc->lock, flags);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 		if (sdebug_statistics) {
@@ -7551,6 +7616,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 				atomic_inc(&sdebug_miss_cpus);
 		}
 
+		sdebug_free_queued_cmd(sqcp);
+
 		scsi_done(scp); /* callback to mid level */
 		num_entries++;
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
@@ -7733,6 +7800,16 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
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
@@ -7760,6 +7837,8 @@ static struct scsi_host_template sdebug_driver_template = {
 	.max_segment_size =	-1U,
 	.module =		THIS_MODULE,
 	.track_queue_depth =	1,
+	.cmd_size = sizeof(struct sdebug_scsi_cmd),
+	.init_cmd_priv = sdebug_init_cmd_priv,
 };
 
 static int sdebug_driver_probe(struct device *dev)
-- 
2.35.3

