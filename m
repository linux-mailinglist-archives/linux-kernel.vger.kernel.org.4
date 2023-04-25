Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5E6EDAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjDYDf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYDfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:35:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75FCA8;
        Mon, 24 Apr 2023 20:35:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0iNpH032338;
        Tue, 25 Apr 2023 03:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DGby9auyErJ3S+pQP+bBXUg+kA/IANf6mmW/8uCRGWU=;
 b=f63L6TQWketkjE6wWAlNMzUNLgt/kYuIESMoF443eYwynFoMRzHe7hYDnb4beAlA6yb6
 2ph/MYe0mk26xWb5+7gH/j3XcecyyvB+yJ1K6S3ht+b7kP/GMAUEIFuX38cCYCFlZVNc
 jRqhBiQoLodMg1KVO2mW7gxWUpuH32uohIksZjPIipuR+CwPyegyW7PU8LzInHGBaCuA
 m5o/MRA+KZBcQCL2n1W03AQOYOkLFElvfdiPOkDjSsM1G4hTuHkBSL6Ibcqy3TGvfLRF
 sKM6jMNMPVnN3McYH9IEtd+jTMPQ6jc4wdfRrV254dLpldKX7nLcLeAKDk9vVFB4c77g Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbmdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:32:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P261cF006792;
        Tue, 25 Apr 2023 03:32:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4615vfbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMBxWMJFEfkMlp3kVQ617QF8bCZYCqY7Y0gJNlsopnI7WTKZG9FFQrXOyo4N+UD87j1H6SHrMSI9se6AT8ET49DIDMg5grNNtqKvVdgVnmvOJxCmfXyoVQNXVrMyDPYzjUeQQfjxXonrFtX+N8x48GaqrDs9g0Htyx49xkDeyXH24uaR8Lv6YbOvG9g9yc5jOkoh2nN7/umAclWSCzAP682shmI37zinGZjGHNUtm6s26N0/UsNdClnrQ5fgtzSwJBuZ4xZojHROI46XT8UNVKyNSqGvYOBYlVThHMFyPF/g3g0dGBEiWgG1+ZKwvfCxGgfvgeLwylh25kVHafBqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGby9auyErJ3S+pQP+bBXUg+kA/IANf6mmW/8uCRGWU=;
 b=iLmVXDkEcsjy+OzOO1iPuo0IPSvr4kXIbwUtR20RtuwIvQXmw5aYAFAaHAVEZqi31WkhSIcF7flPsKyusA7e64PRRw5neg6kn3oapVKbPAPrt3qhSG0xkX+/OJhbUSOS73BjzuVHQ/ntjTemNRdoBIjGFPWEoHQ55f2fnnmCbQhehcix/AjQNfRrLhYtteXeVvOd/D/zQ2uhWYs5OoTtPPYsO/8FtjsRy6W7r8NOj0Rs6An5h9CGdi47l8xImpC5ygZaTPnZso4Ch+kZwYwtkxLG10TiYdtqphaDQL1X+hq9m2Axt9d5mvaPmaP5wR93AdY/sBa3wk30YVmxOFgqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGby9auyErJ3S+pQP+bBXUg+kA/IANf6mmW/8uCRGWU=;
 b=MCE8MUt4KjgADLx/Rl0+Oazt2GRFTAr/IQmd3Ksvps47U8y20dD+OX5JR4qF61aiFGVXBy1nmUQMUwCVYM/jvZQIAA+bbiSyxYfrt81N5vvJTRPLjPcuLvX+qo54A6NOUC5GAT5bYX4LR1gOEu1SwxrfHK+Icewq4UGU75vtqzs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6406.namprd10.prod.outlook.com (2603:10b6:806:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 03:32:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 03:32:39 +0000
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH v2] scsi: qedi: Fix use after free bug in qedi_remove
 due to race  condition
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1leigk56d.fsf@ca-mkp.ca.oracle.com>
References: <20230413033422.28003-1-zyytlz.wz@163.com>
Date:   Mon, 24 Apr 2023 23:32:32 -0400
In-Reply-To: <20230413033422.28003-1-zyytlz.wz@163.com> (Zheng Wang's message
        of "Thu, 13 Apr 2023 11:34:22 +0800")
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ebb904-3d5c-4fa5-b4dc-08db453db7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nK2C5CSngrLNTTZ7IDXZqEejxnr/Pg/OgqqJW2DX2xBGCMIWwU9rChELdjpP1pmJXASCw4aju+spxYyYDPLt+aWxVq8lhw+MY08JJWT9sUoyLIL0EVFhxdyXDM4ToqmREithaskXvm4CNm4gHQTGloK/aR4hh2F/Ag0UnSxRG1n9DoQYaNKZVnB3l3RmtqNx72kYcht2MFj57zKTxaMjcfAAnztAcCL8zJtByIpKNwfx80niOxjXS/9vOlZz45dgbTx4STrPnPAIF4pf9G/Qr7XX4lzem3JkAzrplB4YzMaNRaDkLrETXgRkaZujKlLgd/b3EqVZekgeVAtfPE9vUFBbeq6a2sLUwk4pymaKlgKqE+BkbE65Fb4S3bSuF8v4mJpw/GoOwIedLR6RSYYJf6DP92v9wQI5klQZJeb8eqgY4gsICYxlvuQZfPBxOdgjWCEh4M+l/cg7TasLywh/sLn5VIF5p2YIHPu90gXns3snBL5y3amjk8fofD3DBLD9hRWKQ/4J20RVJuPxAXRvtYTFcZ38iGuPOs1XJ1tylB/Pd4G6l08r88l6p5rts/F+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(4326008)(6916009)(66556008)(316002)(66946007)(478600001)(66476007)(8676002)(8936002)(5660300002)(7416002)(41300700001)(6486002)(36916002)(6666004)(6506007)(26005)(6512007)(186003)(86362001)(2906002)(558084003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SGZUWbro8VF5r/9mxVcRabppRpPWpFRViPc0BtAJaX5EOvuufP6mQ88nt3KW?=
 =?us-ascii?Q?2fw9Yarmmg3CwcSMEOt4cUGoHnb4B1j9qSpctUiLvV8SYspyWfVZXsdR43kF?=
 =?us-ascii?Q?WWRt5PhccoeXm91KTJ274iP/luPB7zdaGE4NVqUcs6sUc1M98LtY7/E4yHZ4?=
 =?us-ascii?Q?sqPOdn48A0o+c0dqinBlH2WwXdIkV/zQMIxJ8dpMV/15eA9xK22uPCzEbOBJ?=
 =?us-ascii?Q?Q9oLRS5hJ+K3YWJJQ5cWlwI2Okqrx5WQnBbsNUA0mGeAVdKtUuoenOoIFiAL?=
 =?us-ascii?Q?GWVJh8XxsIKj0C/gdzXIzaz8tKDe7yUxRorSFMbH0u5C8TEPNNVHKb7T0O46?=
 =?us-ascii?Q?Dax6hdAnf/rbgfWGTv3Nc3JFLRsVVh7jzR0pls827jxAVArkd6W+XJ6vLAPa?=
 =?us-ascii?Q?EdrS7olRjUD36oP6vw2B89z3HUCoKIrShCF3StsNYM6FCJDx3ZE14YOBr2YA?=
 =?us-ascii?Q?Qf3eVRN/AToT0wsSfwUL9dQNpOlMlarS0PngDFzwfjAKnmWt0MRGgUvyOIpX?=
 =?us-ascii?Q?kUC1qcygdXlvGXMD9hiGbUe3Pp3urA3Y/i6TF4hEN/JS6IxrwvoFYnI99ZXM?=
 =?us-ascii?Q?RaxAbG1Cg5ND4FT5UNRVM5SBAa7ciHMuG6oaKEoUxh7lv2AXwYWxh3hsAgNg?=
 =?us-ascii?Q?1V6HE35KPvzEJfBo5lqLCstBquv6nZ+KAlL66tfOa+iRPxMPuAIbMISYSfuA?=
 =?us-ascii?Q?fU+LO7iGmw8mlndZ0YaYtLueKnsLQ2skoLisSULMm0e+InhctLGK0z7yWdAo?=
 =?us-ascii?Q?vhmt/A8rT35V6gv12WW9bzwPBoB2d02fslcSZiYc01ZFzXgvBwgAjtw34bge?=
 =?us-ascii?Q?XkiFnsXycnfQ09kMW9tR1f41Ocv9OSLIgMeM0YHGUGGC+7rK2srEC7P3utKo?=
 =?us-ascii?Q?6bmpaiNNL7itsB7nhOik3pxrfjJALxjUXaQUJNQ6/PYBBd8wT6mmGjpnErxQ?=
 =?us-ascii?Q?9qqQHUJ4MXHGgch2sFiVHpqLNhXbjYRuqmIPCDR+YDa29x6QEJPzaN4zta53?=
 =?us-ascii?Q?RH9USAfDAxM85URwmPt9AWMD3jlknmhnvdijGDUQlxGrSRpWIHw4LHlLaheT?=
 =?us-ascii?Q?dKAaQmuhoPMswHoZD7gNCXTMmdb83H3hEXaQyei8lAhejyG1DFifShpmAM3L?=
 =?us-ascii?Q?fiM/FrbbZDsZav8uLIpxBkmt6I+CbOZ+FIgPRyknPW15unZPeoMd2BIIod4H?=
 =?us-ascii?Q?qiqx9wJer4L4t9iQa4SL/rSbE50CkldLsWOW5z7b4I9ezR553TEX9Itn1Q2L?=
 =?us-ascii?Q?8uyI3g05cgWnn9SuuD6YtH6GbF7+1VN8uK3DAHd3W9p4IFEMFmiF+cwER/RT?=
 =?us-ascii?Q?XXJoBoMbmOvtXU5UtIt3FkwEkWgOSitx4yZ5QFyC+QFZ7cUFeF1i1e1zlKz8?=
 =?us-ascii?Q?Gh7b2DOsv/hCDwResXXGgBrYTB93aGILFhEibgz1ev8icdrXAQvs//TbXcDI?=
 =?us-ascii?Q?z5giraTwigt92tgYn1DcWS3L0lhyyN+z4TB3ODQ66wE9FSVI0Fh9i0jrU7DQ?=
 =?us-ascii?Q?JMbvl9ZcFIDl9a2p8qJjkKPhFuMXUnjNEAiHTQdge+2jZ5ZRvzZX9+BHp9bc?=
 =?us-ascii?Q?p0YFmutewBG0ZIcwiX1Rx35NBmGB1fRYyC/TZIyrWQP5FoM+V6YlEzdWfc+U?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lv/RpkGneCquL7vgsM2ej3VYDAVno16MdVSEJ4qtFE/XyC5sUdXEEKJtad6aSZ3q7J3NYmbxv5gWl4t/V3C2mVuQh9gJT2w1vISTnsbqyQVqWFhsehOKKG9FdmO+n3pi2a0BIyCQlt36Ng0rWHO/NczA8b1hgJ68EC5FpEZPySuic5ZfgLTWX1LCwliGxaOAQemr1geva/vzoG8b9jW6Ki89WD8ODv72kBYhzeV7/+csRpRmCya6bilmgbY8T5V0TYwOS2L9NkuPzYHCgvcCOhX6vFNzRFK12LA44Nq9TqJfJB6gsOyDp46tMKAykq6z2hj5Ie/MbAHu+BMlBewHnP5gd0Yki4I+Pb2u/MfZ6lJdBc73FSWB7z58YhVYkqb+5NuSoi8dT6m3jcFyBqza3vvAmD5M2wI6Xu/WjFnzc9cYiWEguE3SivMJsZ+Vv+VCVqip09dzHd1NcL+sLRRzckY6ghByAqWZoVvnifdhyjNax4j+kGqNz/1YsULgnjQ2ufQ81WvH7QaYGT2oCij4Tk+8ZraxG38ygTpWWP/GBZktWYedC041CJDu9G4HOtOOMMmB8C9OsQn8QKcaH1xJIYgjnc/QHnePB8t0fVjgbTKuTr3yCzjK71WG2wmK6h85/ru83HdTPctRYihlgglY+78ZCgyUhGr71hZ5C1mGXIbDOxBF5hik26RBTXJmJRTs6yhTMm7Ol7rkiCJNMNd18Y5vyTL7bL86k3Xh4K9THs5NorLZoU2xpEb1jrpFnHFkgX+noviJunQaA4wQagTliiI/Eq5UNWg8BxAHkpQxfEXzhpTyrtukKJMQK6NcuKv2VCKxKVb7aFPpy8wJMje3qL91twEvgzB5hm+ulVnbQZpjoc3tvPs63BLaIpVEbXL6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ebb904-3d5c-4fa5-b4dc-08db453db7f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 03:32:38.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jAx9K61CIeFDLgyjAbM5UBBWQD3z+wiA9c7XYR6JPtXmp0DkOCPLHZakE04V65kiOAPHlZXPsGkLGFRc4yn3PHSdfVnrmiQ59FcthQC/+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=522
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250030
X-Proofpoint-GUID: j4JDHmrkQDQy3klfWbJcDXp1HSt7arp9
X-Proofpoint-ORIG-GUID: j4JDHmrkQDQy3klfWbJcDXp1HSt7arp9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zheng,

> In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> with qedi_recovery_handler and bound &qedi->board_disable_work
> with qedi_board_disable_work.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
