Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE116B75A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCMLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCMLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:15:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCC13D74;
        Mon, 13 Mar 2023 04:14:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D01VoX018846;
        Mon, 13 Mar 2023 11:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mpfFqbGWfiJfSOdBbdUS5NSh6oFnRQ9DPEte4/4Casc=;
 b=ViWFV0MI5HO20n+8oeOK46p9BmsO9JKDMfBLJsIP9JBiOUcmfY74G8+4kR2BP3jx8vJN
 zNsNIJbs7y7Ap9XgHyNZumixNZMCA5oNqOq25te8sHjPw1P9LiGNA5EkqWnt4gTCAoRD
 uiSb8gxTblYq916Wpv1gIxk0dWpHv+Tb1wjRrj/YcIoCyrqACbCwfo/SC7G14c93vemH
 z8DhB0ioUB53qELqXThDQxQ5IbdI+T2JON7U3fezWcV7J9kFn8CqaH7FZxBE66moY3WA
 u4ORr9vaGtYm4ysidbBbVLQnjrEOF2gUY7GMrfDdCd7xY6WRjv1A5SP3aAw67VHhDxjQ Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhabgq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D944A9002312;
        Mon, 13 Mar 2023 11:10:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0kd2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQiXYY/Lj9gzjAu6RBO9/x6Zq8/SLxTaTThAXwvk8R2qm6G6CujV1wRsBgix9ghNnWSBYSvdCYoyRDVCX+wru1u1jgsj18cLIXu4x4YpstPpKerUUY9M950b1bjS9iKGSg/eQOOgRERSgQ/Xi8cP7yga761q50BDvpHlvlb//PsW94ljckt5+dYmXLc+Ikli2k3TCAHX3vpqqySlZXWhq+BqguB6VT/VYKHFafRt7d1ci3a23BDsivsB+9ok2yXDIhpDXwYUlNLN98BgCW9ZQ+d/3jyXoSfib1SbrOBrnj/OO/0UmG+9ccDapdpU+CvRL9qMZB87EHKG/n4Ak5p5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpfFqbGWfiJfSOdBbdUS5NSh6oFnRQ9DPEte4/4Casc=;
 b=mt591is5fjGSBx1Pjjvd0RzCXkx71Insg/ChoRb+JVzn6CEji2/OtL9mD7jPddFM/TNGpmRyjmsMtCfzAwH9SV6pUafzOyiZb2wJaO93m2698YbN5IEQrGsYB8peQpr7h2+4iBqk4PqKL7XCwWRi1uxxjdOLtV//tZOOb4lJ2Oi6vTvLdR4r0gdhgrUb/CyYnFUQNRQW5vZG6qRlK6giiYnlMv1ngNPrv8iw82QK2oygEQygC1E71HATzaiKRPJTys6ihH/bV1QeziyZNpbvq+ZDn5FtWm4c/3QzS+8m/XmI1+OZA7sgttZdunBLZulp/NLZOz+lAFGMyaXn1f7yqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpfFqbGWfiJfSOdBbdUS5NSh6oFnRQ9DPEte4/4Casc=;
 b=I/qU3NA2qaqZpHjQGGD4Rag6ggacRKWHRX03bZiFsRpE5vgx7EKTovxSnol8may2Euv18Z0/4bG9hs+Rxq59wFwVbwt0xUGdOC6lp67MyGnSu/TF8AyqONVO9T1YX60SYxko2Y7w35TB7C/gEnvArjqGkadnMUvamkxP3pdTju8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:51 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 6/9] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in sdebug_blk_mq_poll()
Date:   Mon, 13 Mar 2023 11:10:16 +0000
Message-Id: <20230313111019.1521680-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d27ca9f-11ea-47cb-7a9e-08db23b39b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gso4UgNNGJW4SEXa/jHA7Dr8SJHjQ3YTwe2spGhLSpfrroVdefM3Z6VDoIXnSKv8TaRMlbsQt4Ow9/JvDOe7rsTUKkFECnBIbhdTAmiHecPLFz5Q9Zj8gZikKA1JbtSdypC5a5D5jC7ZxYuxRZflIve/QPGsZC7OcyXW2rxyVfdhFE4I31lRzULlD2X0DAsPWDOBNblXp5QdSWsAQRYt5sgsZFWc0djkM3MAKU+yPEk7n8GbPFjclYo/7XQqjy5nGLeLid/0WXn1f9zGGIpGWKE91WFJJRdGhfamnghSYHFSHxMgzRqkHGONtopF6Hok7aRpCxagOq6ui6bouJ2tmIKOhJkLKyR3o4x4SbpTzo+0h1uinKY2KXDhGQR/sDOXc2ueceVGnpcTdhuXGpkL3M/pK6Fvm55DXmUu7hdCyBtomIS7XfpNBpLT45GdZujFs6C+U5t/XeByJOqWw4N+JNK/omuJ89DFAYGXrDIvaVA+x9leeBPKt7aCC54/CKqOA1b2H6fpzaVcMLOGpS809wjCVxoZMSEiWYZoq42ekAG6TQSmssZ1KKYJKqYfaeXFhvzftf525wouCYsXMlmpp6LbQtiwFaZpYnu+GhIuXeM1/B2YzYB0CJhGxuevzEyS+v7eRoaYdBM+/4XjMtU55A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmam0EKRxn7/XL3736g2yW327jWAV9IY+yhJhuERQrzcrFcCeLG0wUS2mEoO?=
 =?us-ascii?Q?Qup1oaNRpF45bCc5N4lsI1BP449TP7EvjNGzzxmbC4M7e3MINPoIQSQ5XS2T?=
 =?us-ascii?Q?ipkid5Pp9h4Cr8MKt1FYhrVp5jpRKVWxIwdvSA9sCiz1Q4Qt5a0R9zfHJ6wu?=
 =?us-ascii?Q?O8imGYDmWkXzGHNxIjE6lDJtX5lyCk8KGMMsjxTYe90qia89bbyJLAk9u4PJ?=
 =?us-ascii?Q?A/GOvXpEXV9VLNC3jNjr1jTCZxY7NmEKMxZxmIj7IStTtza5DV7FZ+kO9UWu?=
 =?us-ascii?Q?Ry0pnHeJClkKHgmpAMBqtaEDSwe6BnaoM3JuIVLDXzD5g0d7BpnX832+ZUmo?=
 =?us-ascii?Q?HdWQx8+WKMOzetg1K+OL11AM15c7W7ywWX89caxx+EO9EZk6I8LV6+VOQnAj?=
 =?us-ascii?Q?SewonVTQomQF9BaCBovzc/yaPy4+DFi8Jjek9vL82PwX71ryFhNnIM3WBorg?=
 =?us-ascii?Q?47rTfV1rjwbUUwTlUvz8f4Qf0DNsLSZlKt9DaayaOHOuszEQ7v5huu6HvUgb?=
 =?us-ascii?Q?ZlHsLZl+Ooz4UT6j+Vl3MkSf5+WJ0CHC3vC49GOpC2VrP8+Pr+nZa1J8OL2Z?=
 =?us-ascii?Q?0t0ErjC/BSorvlV0D3fM0jDH2nSuSyHIamRea6xZN6GVppzT8KXi/mnzKYpH?=
 =?us-ascii?Q?S5+AoJk28nEVHftH0jodq2H83lffVYQXZSYoh2J44YLzstYWHjYQ5nOdG/bY?=
 =?us-ascii?Q?gHfj3fdbJ1xK9/wcgyy3ecfKm8nxh3LBkGCVNBLUxXjmFKXGe977oAbwuttD?=
 =?us-ascii?Q?TkdUbGoLbLumrNHY+P7kcPn2zaHv6GWg014aPwmLD4ZTiksawm6ZrrE4x6sf?=
 =?us-ascii?Q?64MOwRgN4oC8xyFoTj8n+FvReGPAk65B5DehR7W392K83iJzdLlDAMBaToUb?=
 =?us-ascii?Q?GLra6IHuB+bbYghkY8xLQzje9ciSVofVMLh68HWFmqU4jhrx9D1OG+xX1LNe?=
 =?us-ascii?Q?u/ixXJtFHxQp3506ds7E6fymizGAj6R0iCfwhhJIE0DsxxwMnddyQDA+nLLJ?=
 =?us-ascii?Q?1WdX4v50K0j28wO+QPUKYNcAnvla7rea4ivAtJIcyVUBmkC7cOuOh5uvbPc5?=
 =?us-ascii?Q?pRSBZzRjwarVPDs8fWPBGPjkPPEUupViTfQcBPKa7pWDUH6DW5xwxVI0YfBs?=
 =?us-ascii?Q?qY2NbEv4+/fYI2DAyE+XJLws0ZMJqXR+5Mtt1MmiMywI+O5fUjkcl/jGaByT?=
 =?us-ascii?Q?POKK6wRgBbuCGH56iCr0VMwBBDVe31+oMwo7rdh6o2Tb9mOZlttK71xx9vFR?=
 =?us-ascii?Q?LhktqKjOKqKoOy7B8Z9MMNm422ADTkni1yfrXAavPVsiCP3od5UdZpUjxDBe?=
 =?us-ascii?Q?6k9xbGFHJM58Qzsk6FwWcmylkcwXKMrdz4O4f95cSwm/9q/B7AifTThr1OFE?=
 =?us-ascii?Q?2V2vmaBOR/EjFv4FMcyqj0AL0PnnzDODvqn4hX+eLhfb7DxKMATlZTCBuo5l?=
 =?us-ascii?Q?YXop3uMuSST4D4wvAO1RTfgOFcwqw6vzyHIaq2+wrFCbQHJpcu0IAXqOWzil?=
 =?us-ascii?Q?AV8YhAarXAQNUHEjkCbjkXpqvYA3VuOFAdoLhmmEqdKK07FDOMQH6cPzdvqS?=
 =?us-ascii?Q?NsJfavyiR8IHeRLuuRz1TiDJv6omJtkkqxHfdwI20iHyryFU+QBwvsdk0t9x?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ioLxBvuBKSVzE8J36EJuAf//204jwhe4aPMs1tyiM1HAXnpUkxLE+oDkaxqdzjj1kaA/pnSbw/8B4ND546wRoP9QzD1P7EH22XDWlQNtaMuOA3lAamw+lOueAQiepQBIs4MKa7MGtDt+vlEahicInNET+zdvzACAm7S+Bm/vf0hHQ26ELuuNFS85BMfikaqI8UFFGvKs+/xVu1kz/SQ0QMZD/RdLKQ1Kfnk5gGb9mdAe1KByNohbFSCqZrXgRJa8zDP3w+t7RCkFCdwZKZhwc9IfYvkrK9uPlAk3LBe5LEyNMg2eBoWuaXghRoGoodVk5mnj0Ob1S1glrBAZ4AcI44yNjEbkjgxiNo7NhFP09pzFazstQgZhKWVNlmxecnW6eXSKKZ6ET6uQgKAIpJLfu3FzoGZ0V+mGbjDWtM0rJ/t1YjxK11n0B9ZcWjkrWLO/oyG8/2Lx+DA2neShzdrjFsFhVkRClRyfkovJf08oDqJGFAmZBMbO40reTJSusHBejpttPzzMLtHxsb/AxFpGn0lwEQsmSGYEjECucfmBoFIYw7p+gLRtnRLMZBO9y8d0VzXJNdj2GX+JOhrK6Ywp/yJE3Rb7x1uINqh/siAiQGQduyxhIII2U2wIuK/x9DpTg1jLC2IjXI0TebIMFvvCZwjV836TjH5U61Nzvp2eOnrx1RPf1b+0ex42RMcxEnJQUMPrmedQ/OR2uRjPEtQCOh/Uh5ULIsLDD01u+XDGMSZHD3Jr2zoOIbWKRNgRdNvmJN03aXngM4rfwFse01ptBEOmzWZ5LPsupbSWV364v9TsE5XbvxLLjhGpvc/WI07iP5AhOmmcltnOtbdntoQmRkZzSKPACFsF26K34WpgazsKVi94xgKi1gSjfJCq7H5legPvQ4nOApwAFNXHvmSFKzMlmzQZilkIqJ8Pxj0Luxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d27ca9f-11ea-47cb-7a9e-08db23b39b2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:51.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHd0lq2YCvv0U2cYzgiZvxjXO6OsK/pNgzAfc0jj8MjYouHlQ7QUSJioFsvBtMKbDS7QMEpaJDYB3nKu7/JPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-GUID: j-b-mfFrc_0fBV6_uqERmnZZCS6QN_4U
X-Proofpoint-ORIG-GUID: j-b-mfFrc_0fBV6_uqERmnZZCS6QN_4U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating all deferred commands in the submission queue
structures, use blk_mq_tagset_busy_iter(), which is a standard API for
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 187 ++++++++++++++++++++------------------
 1 file changed, 99 insertions(+), 88 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 4db66edcc9bb..890241b852ec 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7508,114 +7508,125 @@ static void sdebug_map_queues(struct Scsi_Host *shost)
 	}
 }
 
-static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
+struct sdebug_blk_mq_poll_data {
+	unsigned int queue_num;
+	int *num_entries;
+};
+
+/*
+ * We don't handle aborted commands here, but it does not seem possible to have
+ * aborted polled commands from schedule_resp()
+ */
+static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 {
-	bool first;
-	bool retiring = false;
-	int num_entries = 0;
-	unsigned int qc_idx = 0;
-	unsigned long iflags;
-	ktime_t kt_from_boot = ktime_get_boottime();
-	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct scsi_cmnd *scp;
+	struct sdebug_blk_mq_poll_data *data = opaque;
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmd);
 	struct sdebug_defer *sd_dp;
+	u32 unique_tag = blk_mq_unique_tag(rq);
+	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
+	struct sdebug_queued_cmd *sqcp;
+	struct sdebug_queue *sqp;
+	unsigned long flags;
+	int queue_num = data->queue_num;
+	bool retiring = false;
+	int qc_idx;
+	ktime_t time;
+
+	/* We're only interested in one queue for this iteration */
+	if (hwq != queue_num)
+		return true;
+
+	/* Subsequent checks would fail if this failed, but check anyway */
+	if (!test_bit(SCMD_STATE_INFLIGHT, &cmd->state))
+		return true;
 
+	time = ktime_get_boottime();
+
+	spin_lock_irqsave(&sdsc->lock, flags);
+	sqcp = TO_QEUEUED_CMD(cmd);
+	if (!sqcp) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 	sqp = sdebug_q_arr + queue_num;
+	sd_dp = &sqcp->sd_dp;
 
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
-	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (qc_idx >= sdebug_max_queue)
-		goto unlock;
 
-	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
-		unsigned long flags;
-		struct sdebug_scsi_cmd *sdsc;
-		if (first) {
-			first = false;
-			if (!test_bit(qc_idx, sqp->in_use_bm))
-				continue;
-		} else {
-			qc_idx = find_next_bit(sqp->in_use_bm, sdebug_max_queue, qc_idx + 1);
-		}
-		if (qc_idx >= sdebug_max_queue)
-			break;
+	if (READ_ONCE(sd_dp->defer_t) != SDEB_DEFER_POLL) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 
-		sqcp = sqp->qc_arr[qc_idx];
-		if (!sqcp) {
-			pr_err("sqcp is NULL, queue_num=%d, qc_idx=%u from %s\n",
-			       queue_num, qc_idx, __func__);
-			break;
-		}
-		sd_dp = &sqcp->sd_dp;
+	if (time < sd_dp->cmpl_ts) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 
-		scp = sqcp->scmd;
-		if (unlikely(scp == NULL)) {
-			pr_err("scp is NULL, queue_num=%d, qc_idx=%u from %s\n",
-			       queue_num, qc_idx, __func__);
-			break;
-		}
-		sdsc = scsi_cmd_priv(scp);
-		spin_lock_irqsave(&sdsc->lock, flags);
-		if (READ_ONCE(sd_dp->defer_t) == SDEB_DEFER_POLL) {
-			if (kt_from_boot < sd_dp->cmpl_ts) {
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				continue;
-			}
+	if (unlikely(atomic_read(&retired_max_queue) > 0))
+		retiring = true;
 
-		} else		/* ignoring non REQ_POLLED requests */ {
-			spin_unlock_irqrestore(&sdsc->lock, flags);
-			continue;
-		}
-		if (unlikely(atomic_read(&retired_max_queue) > 0))
-			retiring = true;
+	qc_idx = sd_dp->sqa_idx;
+	sqp->qc_arr[qc_idx] = NULL;
+	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u\n",
+			sqp, queue_num, qc_idx);
+		sdebug_free_queued_cmd(sqcp);
+		return true;
+	}
+
+	if (unlikely(retiring)) {	/* user has reduced max_queue */
+		int k, retval = atomic_read(&retired_max_queue);
 
-		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+		if (qc_idx >= retval) {
+			pr_err("index %d too large\n", retval);
 			spin_unlock_irqrestore(&sdsc->lock, flags);
-			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u from %s\n",
-				sqp, queue_num, qc_idx, __func__);
 			sdebug_free_queued_cmd(sqcp);
-			break;
-		}
-		sqp->qc_arr[qc_idx] = NULL;
-		if (unlikely(retiring)) {	/* user has reduced max_queue */
-			int k, retval;
-
-			retval = atomic_read(&retired_max_queue);
-			if (qc_idx >= retval) {
-				pr_err("index %d too large\n", retval);
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				sdebug_free_queued_cmd(sqcp);
-				break;
-			}
-			k = find_last_bit(sqp->in_use_bm, retval);
-			if ((k < sdebug_max_queue) || (k == retval))
-				atomic_set(&retired_max_queue, 0);
-			else
-				atomic_set(&retired_max_queue, k + 1);
+			return true;
 		}
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
-		if (sdebug_statistics) {
-			atomic_inc(&sdebug_completions);
-			if (raw_smp_processor_id() != sd_dp->issuing_cpu)
-				atomic_inc(&sdebug_miss_cpus);
-		}
+		k = find_last_bit(sqp->in_use_bm, retval);
+		if ((k < sdebug_max_queue) || (k == retval))
+			atomic_set(&retired_max_queue, 0);
+		else
+			atomic_set(&retired_max_queue, k + 1);
+	}
 
-		sdebug_free_queued_cmd(sqcp);
+	ASSIGN_QEUEUED_CMD(cmd, NULL);
+	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-		scsi_done(scp); /* callback to mid level */
-		num_entries++;
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		if (find_first_bit(sqp->in_use_bm, sdebug_max_queue) >= sdebug_max_queue)
-			break;
+	if (sdebug_statistics) {
+		atomic_inc(&sdebug_completions);
+		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
+			atomic_inc(&sdebug_miss_cpus);
 	}
 
-unlock:
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+	sdebug_free_queued_cmd(sqcp);
 
+	scsi_done(cmd); /* callback to mid level */
+	(*data->num_entries)++;
+	return true;
+}
+
+static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
+{
+	int num_entries = 0;
+	unsigned long iflags;
+	struct sdebug_queue *sqp;
+	struct sdebug_blk_mq_poll_data data = {
+		.queue_num = queue_num,
+		.num_entries = &num_entries,
+	};
+	sqp = sdebug_q_arr + queue_num;
+
+	spin_lock_irqsave(&sqp->qc_lock, iflags);
+
+	blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_blk_mq_poll_iter,
+				&data);
+
+	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (num_entries > 0)
 		atomic_add(num_entries, &sdeb_mq_poll_count);
 	return num_entries;
-- 
2.35.3

