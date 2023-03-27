Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952D36C9CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjC0HoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjC0Hnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D44EEB;
        Mon, 27 Mar 2023 00:43:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7Z4ZB021839;
        Mon, 27 Mar 2023 07:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3a0rDP2b1ci287MOeHi9JzLp3A5W7MtK50jkyh882PU=;
 b=WdmN+D5cXbfnLSW8jUCIdcWJSfvNWphi0FSg4jar5aMUTHh86j6YVV1NUVY9WGVwIqMP
 rT14BOOJtpRv+bNuxv3+6C9UYZ7uAV8eH1aOBVtt8i3toNn/Prz7IMT2qNsIyq9gRfFe
 fot1m4eGInVXyqu09hdcD9okIUEohvhT4YKDBbFEdWjx13uI3wduUw4SuCOCywxDJnlS
 tSwD5MfIbG4j9RByo5PlXVW/NxSkx02eqIKiaSAsGol1OHubuYAFpUYh0k2csw2kaoV8
 b3O5AkPQj87jgl0CqTUIJZ/XA+r2savv/wVyBxyr/vj6tmpjID9uamf+hXbF1I/RUQAO 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr150-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R6RqjH020441;
        Mon, 27 Mar 2023 07:43:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4mwe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddu1Tw8+9F77c/b/U/XYp3nnSAgMZU3W663qDw3H8tHohbxGqkz//fcfG0WvMn2/IPB0zwDnyrXN6wf0AsU84pR1/zJdo+utzxt6BIuAvd0QOCJ00IJximg7GUmx7tSE+9pPNxzueixtJQ7ev4l+TAyVGsseM9jO2jqwNC+n9k/E6phftXxXsBsTVqDWcO+atViaXbL3RCC7RO2ZD4xFCQy6GjO2+LdLdzGSdh5l3atZtlMhAsU1taTtwDiGrcu9Snv/pQurshm5/4K3ZbrFT24O1vkHYxUVazuLMZnzq2zlyjfiyzXGfeO2WwjHEP5vIv+HWX/sr8ibBIZTwct5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a0rDP2b1ci287MOeHi9JzLp3A5W7MtK50jkyh882PU=;
 b=b31854uYQbV2/N5NZjkiuTvwGOny1s62ZdfG/LOzqFV+swIVpG4VN2YCW1KX2/6RRncfOWBjNrSiL19ci1A1JrFim9YcyDaatTMqravdwibX5p4Ns0hPhg8Z3V+1UZg6ezX1UK+9xFM6RNnHQoHuGAg+PIA7fRZ2LUWE35f2atPOdO3RbTq3HlXMZsUYw87ZJL233C8FDcdQlrU7splwalUcX+wo4uS/4WsRr0e6q7vHq5SImCT7WiBV58gPz1QYIRqftMfAUnmRckXk/ZPq7SnhNiVZu3hCVOPjRydAJ0KeUQ6qtHndq7CqgZLNg/1sUfkUhkz09JPSm+wGXTg/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a0rDP2b1ci287MOeHi9JzLp3A5W7MtK50jkyh882PU=;
 b=DkIIurmqfcAQOL+VHuH4jmRuQ8g7DCtTg7x3LKMe8XDc4D/Vu318gjVazUX8hMx1eKyYRqniQKIsno7sTuOXXD0RTxWEFNBZoxn5GUJ6ylMsQc6vlMivQUvEnewk19kflU8bYgoWKqPL20LzVRgMkMEBZCj4heCv0rStjo0/rsI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:31 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/11] scsi: scsi_debug: Use scsi_host_busy() in delay_store() and ndelay_store()
Date:   Mon, 27 Mar 2023 07:43:08 +0000
Message-Id: <20230327074310.1862889-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: cca53401-70f8-44a6-d5e8-08db2e96f661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8d2miScP4HqKyR+wvioOCoDv+IwUwRfSeXku63eKgumS4e6i9n8BLYdQRCYmeK9ymSGNM01xjJyi0B08v3M1cfj1jaVawjfY05BzJ/EtkSsuFZrgGtnjr9PaM2/7vYFB6tHnSiSuKNSYVy9OpMe+zs8znEUMpZCje1CoNzv3FXmEKH63/mm8TL5AxsXwD4vpYKzakdCAuO3TcMLF/rQ5aLbmHLc5GH1mrVD5jT6OUiG93a94S30IkNDu4hCCr8DqkRa/yGMlBXBa7Nn2TAzbFj5AwLW75T8xvavlGiNcM63Mf8utrVpSW9fKlYlZoveHuKUc6UmYoS6shznpOPOYf0SoGbLwnmgu3vw3IbJ5jkndr3rk00kpLTOB1CFKb0Lglz1pKi4pybq2yLloHzA+zqhDKQmC3jIiDFnC/xYA1YBOcbKklm9Qc7YoN4TRI80rp8BUec8yUo14MYJjMNmxwLUqHMSYdtWkoiwCc/uEYWPYgq6TPumFf8GkwQqavFjB0y19hIQxnRvE8LKyDP0RuZa8N1xiFSlvQf75clnKDUGvOyFWB0SJxjUBxTciu2ej
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jm5FZQtFe6rrCPqBKl+D7dhMHSYszqZSoUcWp8MbG0pmk3+ZqXjDPUhTEuLL?=
 =?us-ascii?Q?OSuN2sNoi7I43ndKbSUvR9wHpEDLJ9+xZUhxV2jhAiAYhpgm2cOmPf7GLKpp?=
 =?us-ascii?Q?Ziaxqjzo+dtbbUau1Z/t9r/RVumx1ESNnrascCuowGwpX2uAoYnF3K+19ltJ?=
 =?us-ascii?Q?YwvpSKNUGQ95F9/26MnkqsSeUiNDAQ0VUc4CAyGOqEUUzK2hjBtEFsMAOZw1?=
 =?us-ascii?Q?UaDD9VaNHR0iI3Q68+bUdlhIzUQNef5xw8EVq8MFWTYx2pZXEoMuII882pvq?=
 =?us-ascii?Q?js6iEnOkq8DIB8l+XWbagqRoFIYAGMnTYq+faKRq2Pe2fk5wg6v02r2d35kp?=
 =?us-ascii?Q?/3euxLSrnKGJspaB2g1AVRU4BHJGCslkDBzBytjYhslRBbzcmGq3l09/pJUz?=
 =?us-ascii?Q?dRO97Hnd6xlYJNwBNRQcewM9T9TRhYKYTq/sNYgm8o/2/vxQayEBjYiw5RSP?=
 =?us-ascii?Q?wU5VJ8Gkmf1OE+5OE7gZTEkIyTQrckfsmSJGqv4AecPlfeRupvpLiCEpyJUc?=
 =?us-ascii?Q?C8O/xMKR+q8rGCsP2fatRSZ/W2GgkL/dv0bNedJPBjPN+F/U012NJaUEdacF?=
 =?us-ascii?Q?CAKrJy0j4g5/d1pNlVQtQR2eXiOEpSArF8mj+FBYhuqEKBxKALu38OU7Xglg?=
 =?us-ascii?Q?KMSVN+SsNZQb3MbcWIka8J5O35ggrtrXdQaNO4D0jf3nwDrmhlW04w7xvQ+I?=
 =?us-ascii?Q?wX9wFzCsLqh415Lnrg/GsrNjE6rqKtiNskjwCnJ6LM4ZkNUnlO+kTUPXu02K?=
 =?us-ascii?Q?lBGlSmIjXWWrYOapgDD9Ly7wVUJse6S3dD/itut4pitUJW8Oh18oP09jmsR2?=
 =?us-ascii?Q?MAJc9CtRwlTWhrJ6GYZyDwv1xcqY1hduOEw83H91TVfLZ57G/E7QYVRClCiO?=
 =?us-ascii?Q?uBYV8F1sjxGWXo6/F1lcHhD49CRCFD5WrE9FG4LRlH5abD1qmkC5n02I5ewY?=
 =?us-ascii?Q?EueV73KS/7zCOx8dI63gdORn6Qsn7/qsP92N58ekT1BQ/NIF+clVGexa1kNr?=
 =?us-ascii?Q?XAnsfzZ99GY8qxkkphncUoQservb8dBgIfRpRnPVpLmFqbrTEyqXfdKntbCu?=
 =?us-ascii?Q?XywuNz1IzQ9BK+f4mXkUCxW+txwdaB9VmgD21D8JdU6AK2Jbgo8vLeuaAHen?=
 =?us-ascii?Q?D/O82b+XDD1lVzivXuIW1aZuWTo7R6pXa7ZxbGNZBp0n0Lnd8BiuytOFnEgo?=
 =?us-ascii?Q?+4wpYU/6g9PJYLfCE79/eFCRXXfTJcdnq8AbEJKjHgRS5HkedJ9F5+TVQp54?=
 =?us-ascii?Q?JDE7t8FDekqs5E7TT36NcCo40Rf3dC0KGlzpDsGmnstEml/5KwNWjSjgtOJZ?=
 =?us-ascii?Q?Bz6DhX/A6/02j74ndA4T6WDXv9G9NcmQj5vbasEi0W0Mz95RgQZw/b2ET6ZR?=
 =?us-ascii?Q?/iBIrxE1e9kLgoNIuzO9ULoQL02AFKl+rM3lC77vA9Ssk9Cx77GQ6fywMz7O?=
 =?us-ascii?Q?3nPYKSyorzNjZvBwaa8X/lG+vcnKhWepDanODG/86Ib3aaqMkok92GfsvaYM?=
 =?us-ascii?Q?zP+cHNelWTUBdfKRKdobVTI0MKXcz9n4usdgBy+e3/gArpTiIKFVjxF1WmwU?=
 =?us-ascii?Q?UqnACo7Tjvd2tjHvAAw+2d0ydFRkbEZIp+HJo77/G6Zxfa2ZofxvZMlUHNK9?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o5zp9C/lAsKHPBvXRXTHvVbeDFlrAy1pCUElzH2UBejHWBE4h0WNXD+9MeeKIogbdrGuomVbHzJ82WdKa8PvupGEjA95yyHh+aP83Q3I4Ent6ZEcFgKgBsUt4PT0daN1KJyIvcmb8CwTsf0h0eMcEsTyYbVuSZLtF1YnaudIsRpwzxmBzaajc5RR+wxXNby5FGZjlM59PlCzYU5tEhuSOIYJZkAeEzk2Dnkx9TsaDGkbViX2o95KCk2XMWbG2TRf8uA8Za0pgcuHc31+ti9erUziPeV8H/LZ6uPy66jYJPhk6Ap7an18OzuDvAI2OYJjna5JASS6hHD2Z7aCm7nnQG61Hbn4a3cI2IWh+nA5dcbWUtiZj7AzLy/a7vmoI8qA3Edonoyts2fcUY2kKI0zNOAKlClRtd70ZHKChNaZ672Fr7h21quMtKUlNbrW2PW+WbXjw18Gi3V5XsE4ukWZDp9vQPnv4ZWwofPQjcMf4VSk8JQTXY3Q0uBoK7tS4jAVkVsPeh7JI7UpufTDAfB3SCYWJhIS7PuHq8doPXXyRpuN9ujx35KNu+VP5MymHSh3tEx9PAkNFehoap4XAowr4WF0BBCz9K/z5Pc6kqB0hvwvpaTeQZSsSPgtvpBi7pdzPOz5OFdph2rJM5VdyCYrQldVUyPgViUNFOq4Du+LlXGyIUzOAqwbg/YIkuzyys1S5iJmKpMWC4zI2rzbkqpTxJG40hgTngfYr0IdzuEjmwcgroeTTlrkj/O9eY6b6Rtf2pG4aC2tliRd4+9fELZhl5dfoM+CvMWY6Y8SK+XdsDAszeum6BlBCC5Waf0fPtxp2Y35Z/P8k0jLhAelYBILs/hQVo0/+f6AGWiCp0dJk18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca53401-70f8-44a6-d5e8-08db2e96f661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:31.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bouh4uUJdKlKC3Xjzj4PCCO+LBo6+rZAfy5++Bm4wbLczprPwu9lfUoeHmwgLuX9xMZkp7AsRtVVw2Qm7MTtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: y_brcbRKfO03aTbdbnZ4uy0o2EgKXu8Y
X-Proofpoint-GUID: y_brcbRKfO03aTbdbnZ4uy0o2EgKXu8Y
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions to update ndelay and delay value first check whether we have
any in-flight IO for any host. It does this by checking if any tag is used
in the global submit queues.

We can achieve the same by setting the host as blocked and then ensuring
that we have no in-flight commands with scsi_host_busy().

Note that scsi_host_busy() checks SCMD_STATE_INFLIGHT flag, which is only
set per command after we ensure that the host is not blocked, i.e. we
see more commands active after the check for scsi_host_busy() returns 0.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 677fb177ccd3..6e40e9253393 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6062,16 +6062,15 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 	if (count > 0 && sscanf(buf, "%d", &jdelay) == 1) {
 		res = count;
 		if (sdebug_jdelay != jdelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
@@ -6104,20 +6103,20 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 	    (ndelay >= 0) && (ndelay < (1000 * 1000 * 1000))) {
 		res = count;
 		if (sdebug_ndelay != ndelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
 			}
+
 			if (res > 0) {
 				sdebug_ndelay = ndelay;
 				sdebug_jdelay = ndelay  ? JDELAY_OVERRIDDEN
-- 
2.35.3

