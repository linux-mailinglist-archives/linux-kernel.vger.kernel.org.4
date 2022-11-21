Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799586321BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKUMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKUMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:18:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1C2B638;
        Mon, 21 Nov 2022 04:18:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALBvu9b004871;
        Mon, 21 Nov 2022 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2/KFxg1yRFlRNJWPkARtijKLCkrKyi/GgTHgvLhJEIs=;
 b=CgRTgrY4bBQGvW9TYaOiKUJIHXBKqQJCsVUwZnVfN1A4/P9vGBR+gVlW3WI6TYm+RDdd
 zA+Dsft5JMNN7hkinWwSU8rl58RFlJnLQr6e+NELpPJrgRSyEs20CSGPYFtB8wXuCjqb
 rDbzVX51vtB6e28ORxSQfjMp6VW/95MzdGSCe4aAq3nMY0PtLoflZycJFp1v1KalMc/q
 AmwSaimBvTL7A5nKdKzFxqkpWGHtUnDspPJ5GZH8OzFW4asxwVZ7KJMp0UlU5tfpoE3f
 l2GhoeyNhwwIfGGpd210Ce07N9stNsfd7HD/j6ESXd9JcQLitSAeqsmFWnILlhYGsNQI BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxr99m9ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALBjMA7039675;
        Mon, 21 Nov 2022 12:18:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9wkrs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F21xCd2cqpAXBzCIeiFYwL6DqdwlGrxI3homuu7uvkKmr+2glRjxvxTRqdIn7ohijfBCmbD/07h95Q8sfY8HrJ8Av+n/BejW2eDKuQ57jU2szzUsjI3w/LVDPAZm+wvywcyjDS2iUuJDGmyGVNE1ssWVC4MVhbEVBuCnCD8AUDGJPff2mgzKarhcpT/RdpZgKw4F95rb0IZEHklyZt43Kx2aTWLyaI5FhW36KiQMTsfdmmhBUQXw8r0o69lId0HP+F5tgGAFzxsVaBW31o0JZDykcqPWan8TOpN+UfBsfdXKbVILWmSnSICPLXIjRw4IK8YYmTwWLxFnGAOX0QWIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/KFxg1yRFlRNJWPkARtijKLCkrKyi/GgTHgvLhJEIs=;
 b=O+WiWdMOZpLa1kyC2XtDMZDRmeADjdWZ5aJDECOAKYEgCx/HIPGAIQtd47iFrMYpClOGnXB4tcHZT3Xe1I2OqtcPTmD7GV2waEffbtoMu40DTLeV7B2ZfgoLBe3chBhlZXnXWl3U4+8wyxSLNMxPwCJqYpUcTXw+TiZQ7AwPUcErNndUuziEfnYrdVny3RLlXr/KTEZSNiZdlr+o8AQmEO7UaqsYJUWKihT6v2r1hJOtgwVI7Ip5rKtP1N8SVSiZYB5YaBHvfAK7Z0KsRoH/V1ZfvNbQcOsnd9n4/2trKVPif/sWnSK2jy30egh8GY/1Xayquwmfq71EiT1QQxjd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/KFxg1yRFlRNJWPkARtijKLCkrKyi/GgTHgvLhJEIs=;
 b=DpWliFi7el2LmdnUwRsO8K0Prt7Bdq6CalRS0IkbxF3RGiQByqkuEM4aeyHOv7wQcOdt1TdeHXNErHRTDodlB78FHQBUXxJJ99QJhA298TepoTtWZQYS3SkGfB0JEPsBdN2AEhgZ4ttZECwaa8qzy5AtQL12IsFC0jxPT8xsQHM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 12:18:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 12:18:07 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] scsi: Some minor scan improvements
Date:   Mon, 21 Nov 2022 12:17:23 +0000
Message-Id: <20221121121725.1910795-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dd4748-1c9c-45bc-c1de-08dacbba72c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeaJ8Dd4PgeGLElSHKrV8wHd/WtVJnhYTUAEvOL/3kOZgtcEOToU7nlt1KVDu3nndlSo9UuIln+BPbPIiImKQgHtVOBQZ6cEHr060LmL+iUl2jMhPI26IaqH1xH7Qyj3GxBU3g9QmWbCj7J+n+C9DWsD5rPg/r+6hGf7CI+MqMMpOg/MFBtzzK4CVUiRcyelGq5ZBQIPXhjLk+hF8JiPLaZW9s89tLNS5GLT29CVWZWfgZIZD6Cj0/1U7BcIMPbKU4OlfepRE+rzseeQXyS8NuMGim+wpAMcsKagypnnQRhAWM7aqGb2g2WpwHUH3x6nbkgxcLtmmOTKiSg3hmOBl5tN4SyD9gsjDoERLoDeZNbP//TQkBjhT58GDmI+O7jbaOMR8cZMjXow1FnkuzvxTZiOmF03th5jM+bqi2eK+Pd4h3I4oagh2tnAyJoqqGmJMug8zW5mxJFf6m8JaTtmSSykKAljO1/+yEuI5+On3s1jewRPt+m3oq+4BpfcUMrLuxriLpPcgotu0dn8pn9O5AgeFrYdPkIj4whbJdyO0jxmTdQkvryNrxNRGEjunyIS0ZMugsWPSaBcZQHP6jfeOC3ABLyMN/jtEhTVvGbmtE1xcNE4UBi9nnHA1/Mzi/u75e81aSrcankiJE1BVvGoig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(2906002)(66476007)(8936002)(4326008)(103116003)(41300700001)(6512007)(6506007)(26005)(6666004)(8676002)(86362001)(66556008)(66946007)(4744005)(5660300002)(36756003)(316002)(478600001)(38100700002)(6486002)(83380400001)(1076003)(186003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xx9Qje56bO/iI0KlkRYNnfGbk47K9gp51LMzt7m36qn16H+RlxNbsujjKL8G?=
 =?us-ascii?Q?9SYJ+St4phTBNH0Gm4nFeDbCkmwqw1yitzuDB+XVwk1UGQt453lea63GmIL4?=
 =?us-ascii?Q?1gWrFvKt1XH1HmZIjgE1AxtMYPXqWqT6o72uO22BnRBGJngL4psxmVi0qNm4?=
 =?us-ascii?Q?gw/jRxA37Zs/U0SCsHIAv9Czh4TjlgBqbFAIMFSGgLhox3Y/xnGTLjo+geo0?=
 =?us-ascii?Q?0XmE0INft+Pg565iBuPnAid5zIkP5Ccpxbn99DBqAV0xEVklxZpFSYk2ro1v?=
 =?us-ascii?Q?kUh7ODZVq7hyoKc8MOf/9Z50oLVU6Kv9B/l2xnAbv6xo3+4Io+HFUpY3H/5Y?=
 =?us-ascii?Q?6XbnMJbnU9BEu+oxuxR69mJPOlnxW+XzQHQLT+8LSEXrVsoIi60hQ8eXPOo2?=
 =?us-ascii?Q?2I9cbX3nCvnYyYxBIKF04Bk13wO7l9ERVPPs1NcdUlsyxJKwcfHn/+gxci/t?=
 =?us-ascii?Q?WJRsK8UkHtqK+rJTNd5oF/Uq7LMcks1JFH2zXaEqgMeQ2FbDi+WJWwSlN6Ow?=
 =?us-ascii?Q?q+LtO5jOISJSOnDRcSgY1f7Zr+GPtzK1vuRr5c5LMWPKss/eHvlBQT4PGQM4?=
 =?us-ascii?Q?Ky56QWYZ3NJC+0RrXlnpTAJerNClbnyKQHATLhGkIFOiZaDiGuKQzmmofstq?=
 =?us-ascii?Q?PXZBkchjKUrT/VSrCEmtIhG8/xc4473cTcPQUon9uu+1CvOqoW4A1OoxJHV2?=
 =?us-ascii?Q?oDfmIYaFwTv3Hb8+hUljRyVmt7bAGFY8zvK6nlPEO/SgmDtnsthPPdDrPKlp?=
 =?us-ascii?Q?fB7vatAVz/ZcZ69FbiPk7ckVsjx/N0fPDP4F5+xTt6EWx/Zy8Vs1H24HF1Mr?=
 =?us-ascii?Q?8tmV5vvK6pqGFzXyQAGTo60BmNgC72hYvKD+jUr0SswoeVIdeHQykZKvlk72?=
 =?us-ascii?Q?p0O0ERPuNtDL8ahOplPMUmUbNhsG6hqJsbz1jTdG/UVk/72wC+TfSI8fpCJY?=
 =?us-ascii?Q?3BPotfrHMdFIEiqA7FYT3i8ZeOl8ynawH7HD658cgDl8oB49pZhGk4dsq2Yc?=
 =?us-ascii?Q?cA8THrdzMFnYhYgN2o2B7BOS1SRgR2y55qUzuFyHQvO61/3CPUS+EPHHZ8B5?=
 =?us-ascii?Q?xF9kvHALxYJsKH71xtDO5F9zoR3kDInF9t5ukU8SzNrMMb5NPLShEjKXJ/k6?=
 =?us-ascii?Q?0HLrn5Z95dsGV6ZIBfD6e7Yd/C3hlFJxAZuvJVWy2bcgW36XCKUdsfDKf65L?=
 =?us-ascii?Q?8rFtHyg/oonZPSkAORUGMfT4g55DsoloYDVMHiCfNNfI2yem6fYaEYhA23kC?=
 =?us-ascii?Q?rXmBCSNqt1Y0/5kPKc6yo3C3L1/lbgqMmDnRMl7zS2vOipQ8RrlmCHxCJEib?=
 =?us-ascii?Q?CLo6VXiK+MZwQqhvOSpB9nVrox/Hmctb7bLbh8vUmYbqa/5YnSzQD47uxNDQ?=
 =?us-ascii?Q?Hc4MYebIBgufXRHx/o4zJuXwSDOpwRmJNWglNi274Hi8ENtQ6WgRbzE3pKus?=
 =?us-ascii?Q?4sAEvg61DX9IMiqKpaolqbsynzIAFPxNS5dTIEgwdVvNqiglXGS3u5ih0ffe?=
 =?us-ascii?Q?2axUcKzT4QF4WUHy5TAwNNYuWyFPsg3WaQsC8Xij9pVPsmRTvVgm8MPnFj2m?=
 =?us-ascii?Q?oBA4KbCTb6ti3v5p/ZsqUXXd02KB8+CdTU6mGToGZsYr1fx8BPRD+aYAYpv8?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mMYjWObUQ2YaH7rBSj7Bcw6iYe4sI2mviRXi4pa6S6IOo4lo+Ogk6LW+Y12cyizKrTG5E1KYcX8doCG94EPxIcVkWkloDOD/bSG/LA8qrcIfB1qnHg/7LC5db12Caf7AWJOq+wPHPsZN335eaqsU3aqWquA4nutxnjvPyc48Q0MpvDJbG1TBdjNpkNPylTbcSu6HLYWDVZud7sNp8WSsToRnDPuaX15uGlBcM8NzXlPUG1Gy5BrDHF40ZVtqhLhJGs9CgLGD+vvz3FOo0Wg9zyelBbZXGA1wtldwTaErGD7nWiQE7ODDMkqhbKAwsX/FG5X/f+0C8s9/n9RN4VO1jfc1i0sHzDA6sxmyZk01XekX0M0BOuXAWIb9NgOfnDPIany+tFOEAwb6MHHiqy25JmXSmjpoZi8R8Ze9cobEMCa/vC9U8qt1C+2dDVTKpQi/qnApZy5mH6JwpwvIKtM3oK1OHT22mbkcSXf+WsgGZzbgEvxhQCOvBx1PedSeiRjUUIY+wTfSDWQVlTBBsyUsHwQB7IPePB/0KNAanH8jVN5sd57/NOWifkkwknahWIYlWdYzyIWWVAqbhRhPZbTxZap7Gm1gDXgzdGBFnlzV9We4WXUCyDON9Es2h19tH3sppcwu7ZAEqjhd81oEI3/S1uh644QaA73cMRKH8+sAIaQu94d1z+GnGPrjkTjtxq3ApVc8QwkD+jkVOqutMfH4Cj8tGA75ZTWgQ3u2Mwl7CGe01sx+LpGv4TXylsx8q01gLlqwGTUqInXfvt7alMdZ+smuFlcbSYLgmMwDAi+vKHywTsiaSvbKfu2W7JJjGHwa6T/uH59a2nqW9XeFtzsV0r/u+pzYLt31vSiZTz5nt+jnV8SBNXsPS23t3/7ufRh9x27xOPR1gv8SMs2ENC313Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd4748-1c9c-45bc-c1de-08dacbba72c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 12:18:07.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHhy0NAG2S2h4cjXaKp6D/RD7yk8dclTNUBUeZxRaXenKDl0byq1Dq3qUTvYtuywd94+SNr4wtM/loJJMQImOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210096
X-Proofpoint-GUID: GUmTyiLszY1D0nT4yPci-GMkYmHXUNge
X-Proofpoint-ORIG-GUID: GUmTyiLszY1D0nT4yPci-GMkYmHXUNge
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __scsi_add_device() change is from another series which I sent a while
ago.

The new change in do_scsi_scan_host() could be combined into the
__scsi_add_device() change if I have anothter RB tag (hint, hint).

John Garry (2):
  scsi: core: Use SCSI_SCAN_RESCAN in  __scsi_add_device()
  scsi: core: Use SCSI_SCAN_INITIAL in do_scsi_scan_host()

 drivers/scsi/scsi_scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.35.3

