Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21826620747
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiKHDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiKHDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:07:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB15303DD;
        Mon,  7 Nov 2022 19:07:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OUmu027229;
        Tue, 8 Nov 2022 03:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OLazskoQnhoI11zPyVXni4AnIpvSRKq0BaY0tnDXClY=;
 b=s3NEfcScBSE3mKenYIHNYlNCqYR40/XChXLN2jnN8gUDVt4ZYGCgAKcWgxI6N98KAdai
 QoG6ICovxipqWPKIhkR7YDYbgaUdL1ieVaDg4X55RRb/dzdIYj5oL+449mWhXPBKbSPV
 DpsnIv0XokO5VOdKVZobGPpBnX1A6UXwxgAt2i7/tUfHfbe/Go22lgi9XY8Mh/A8T5Yv
 pzR3B8dQ45gbXJbU6m+hBSiff+JKGq1AB1AiZpRaEZhqJ27oDPF8Eo/1motizJoAjxZ4
 I6tpuxniFvsRizzTd1dMpUo6g0RJ3kPPFveqkPBHOOUT2v8xzonZoBp7rJxtehMvKe9c ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenud1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:06:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7NUjL1014416;
        Tue, 8 Nov 2022 03:06:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq1efqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfWGGiv7LC6wOtgamRiUoJoLb1CwitZr9U1F0ScxPFEGN7CB02DnaS3qoDUMIgnu6Q5PuM7bv3V9hLVTJtGUNyz3wuN37vMkTf+S2tV+oUMfm+AhuZztXTqG4SYq784yBQc8Q7Fts7sEYVhOqj7MlrjTkByh6LJThLarKlscgznqSG1TAL7S1+nhYIglVA16HsHjL/Ijek2TqDSA74uqIp4M0sUGtedk3jJV0AKZbkaNIhkWO1Xnf+IrNazeEhJyrj11udlrPF7ll0pIEnhz9vPRk+RB7kGNi0V0RtG4DErJGPyU8Lw7PG6zCqKD/8//aHc6CiB85iTVBNc7DT6A7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLazskoQnhoI11zPyVXni4AnIpvSRKq0BaY0tnDXClY=;
 b=kXabblByJsf3n9C238YbXfSnsPrChf81cQ/Ll/7oR6NRWMmNq1kvgzEhqb6UgiDpo2DWMGFuUOO+t0VJ76gNHv+ACbFOFfZqhcSV1l1SxM3xIqUfMv2ZUXD9RHbuiWNKbpWKl2VJB2tg6Xm9Vg/SwcWL7vCac4QJ5tcC18nbiEvc9iK//X4aE35ynWJyzEK/BteWvrMolPmiu4crsYrbpfK0rWsP288Gx3bvd4Ak13xxuR+fCvqscas7LLHYejW357C3zrB4uyfDFjRv1/uTQ5xv2QjpB/hmDHjy/b+XZjqt181MGc/+wfVTWyJ6J+aRsHw3y8y6Cy2d3rCo60ZFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLazskoQnhoI11zPyVXni4AnIpvSRKq0BaY0tnDXClY=;
 b=hq7F/hp2roSNyRhQsKf4sF+KesxmOv6OQryO5QW2aIzgju4b/16KYl8nJN6RiGTnlLNzpOb9WGYsthDwgy9GAY/mvibrzBFTTYJTYiH8+eozhBE7HUrjIl6rZUbBOvyQ+imWid38aq8OR0kjRKZzoFIFmK5VVwXWEn8Vn7PJrvI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:06:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:06:48 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "draviv@codeaurora.org" <draviv@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: Remove check_upiu_size() from ufshcd.h
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1leomjgaq.fsf@ca-mkp.ca.oracle.com>
References: <CGME20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
        <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
Date:   Mon, 07 Nov 2022 22:06:45 -0500
In-Reply-To: <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
        (Keoseong Park's message of "Thu, 03 Nov 2022 14:53:49 +0900")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:5:100::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b343f3-8c22-4762-b448-08dac136466f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh0lVjTx4mLD3U+MhP2q6XvLBCAtdbub+XHFfA71HOnY0sVZOkn/qypQYmLRrKzRPd56xbHrZ14ZZdu9Xb0Tq+BRUSXGnbLNdSARZTCiPG3b2UudeA9gCtBfU8dtkBogEacF36nuC4mtuCsMnwJNAnvPk1fxZ/T7CQPQXi2qI2V2SjzRsaiqPDAjRWbfOpSZdiZxxPy71865mWQcnfuRhbHi25pWPTJaa53IAhyc42OXQHe70EqiAewSFzbPliSQsH/yCHPw10yJYIJ6i79VmYZZOdmS4CS9euRty1GLfBShhWof0XS2bVUiTsfA/JfNZrKGLy+RrgAIiUadmezrtvEbBNJdI8s2iobnG0MalTmeJwhZDa0lhLnx/F79nV1XA/u4ib0ljc08g3DQPctehrrLpAOWLrr9OQJeMx8AX9cg5e9cx9TaJlqf0GcGSfX0zc0Wi6s08jw2VMRwa6RBXz7rd0+BigrdoOF7Ocp/BUxQq1FTpmpodkCkyzkbh7JE4yne3MR6CocgRtMMJyd4WPXpofr28SjwLhPpoUbqQrrlqV7FAIRT2azAlMiwVhrZv2RlBz2XeqvkbUnV2bV1dBamri00X0b6qFxO31bfWYfdwDf50CdXmI4dsbMAUC6QxPgKHrttdh3+gYgQTpBLOpwyVmEBUjI/xsUyzfbf+mo+yEbwazs7V7SwKeSbmat3U9vO1wiwzY8sOTIcVidB2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(66476007)(86362001)(4326008)(7416002)(8676002)(41300700001)(5660300002)(6916009)(66556008)(66946007)(8936002)(54906003)(558084003)(186003)(478600001)(2906002)(6666004)(38100700002)(316002)(6512007)(6486002)(26005)(6506007)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7TKUvpJjiqWvTvy3MF3iZCwgCppmYUEw+4DM4J7lzMB4tj24cDmJYQWEZQQS?=
 =?us-ascii?Q?k58Iasl9mLpIGV8g2v1fw+ACOW1vq8qpde2SO7+TL5PsK7UluZcOdO2+XnRY?=
 =?us-ascii?Q?21TmG9uUQ89l6skkkG6OJu0y755b8spQfXOcPELvRjyU4MtJwPTlxlYQiKET?=
 =?us-ascii?Q?lwq6P5SL6SCQA0rxqCFa81ob40op3yiHRnK1DhlJqh2J6g7Pa3jBSuEv6xtW?=
 =?us-ascii?Q?9kAJ4wPopwrKD5l8aX1m0iOdugdt2DadRmpbind0xT+hPjCVj/xMTpTlbesz?=
 =?us-ascii?Q?JFHOMWpJ6nh5TumDjqsw7u9OjyIVzX7DfjcYCNxxq2AyDzyyqjMFWBFYA61x?=
 =?us-ascii?Q?k3VUWE+zOIcFqI4vkglQeTp4hO4XqZVDFOhlF6/wFGzLobdFvWWP1NaLL0et?=
 =?us-ascii?Q?3ZGNP4QhaD78tHZKcNg9oS9oNrC5+VD/e9e8uRPkWoOljr7/9cGhzOIaaJS4?=
 =?us-ascii?Q?+7SsWz8lfHrIXWafpj41bc4xpWUt51mR3BFYZzsxxXNFbKbITfHM57djuOjB?=
 =?us-ascii?Q?9NnWXv/3Pp5PPsRqVK+hJ/WRvqfTGiemZV8VCxVqvJexjjgNTPrBefpz2TGq?=
 =?us-ascii?Q?BFay7TK9z13LtaWBbXBXjv/slEtcEuOwHMtHD+NqLJrG3FMyy3bhF8QtxXE1?=
 =?us-ascii?Q?EBElAwcii+AXkdHAu2gggcINe8YLsPAAB1ZFg/T2kJfkM5hZ3ZNYFpS7PwbF?=
 =?us-ascii?Q?61QMBd6DFkyVs+eI6TsIO91bw1Uv4nwS/0MZ1g+w84tBuWCqr3tYqSAqmQW+?=
 =?us-ascii?Q?T6bHhRPEpII10DPd9nMgKlMdo3SriqCsJBMoH8qlSOQCsMzMNsntm9ghaupV?=
 =?us-ascii?Q?6ZCEgAAV+30IZZHOiIS6tViPe/NTJiNdLzReLhN/dIHnAFvudC6ZpCqfuFtt?=
 =?us-ascii?Q?uvQXCxOZofqBAbnu1SEnU7fsP6n7LqPkcgT8IOzPNdK6GlfQylqZ7BOQfarN?=
 =?us-ascii?Q?zbtUdSl5f2pHIZwBDbRfNXED+X/U1aYvA9+yoqlXzocmwbABzzCIeBX0iMtc?=
 =?us-ascii?Q?jGhLkiOwJuziyONqsh4n2slx4L+7j6AreMYy8feHrQ1ZYXMNAIu/bbFW6T2e?=
 =?us-ascii?Q?MpaMOqDbmPssTSMjhhOvwkq8ZKPNdQkLnOC1FHHohxEeIPA8HquvJWT27VN2?=
 =?us-ascii?Q?ht9UYDWOhlzCRUIlsdba3ByrnUfeHs0d1xLmga33n9mTLcaOdpxXww9lU8bD?=
 =?us-ascii?Q?riRG+coAK6Xn7u9Dnq2/o/tlVGxQz6sPTzRauw6Pi8Lv6msksiUf9VqiR4Fl?=
 =?us-ascii?Q?qIxIKUVdniygxnzk+JnJj+0IzWMQ/CbquIYZhqoq/8K25Vvq9apazWjMWcfr?=
 =?us-ascii?Q?jubaNIxb7gQn8YOESgohN/tNvv+Xfzv2JGbNfu7XbaNoLimr8ezDgW4Mm8gU?=
 =?us-ascii?Q?7xbSa+BPm0i4k1yQ96C1C9WYkHl2+mF7jb7QlMYYqwIgFdJ+3XpP/ScuuwMq?=
 =?us-ascii?Q?evI692AgTzQ5yrsZG8Fspem34P/tT6VJIAKd/p7SldOhmW1xrvnM73uPPbYU?=
 =?us-ascii?Q?ipDdXH68PBT2EWXv0WqgzlZsh3RucMb7jdQzN2xqFkNllqKAzcn9KwsVfK7V?=
 =?us-ascii?Q?D6BHzFBUBH1L5xEa7JMoBUEF89c4/Z7V5Rg6rmmNROo9Q7UsWQlIy/OHeack?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b343f3-8c22-4762-b448-08dac136466f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:06:48.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19ju4gt6CilYmTpj5o82JoNG1QmL9dj2RtNgBgIsN0Gen7SPC98IMrMCuxh6CIpAB5NnEMTPj75nbqv4uJfnGN1vR63cTMzebChf6+N/JY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080014
X-Proofpoint-ORIG-GUID: LmYmgdPK2EZP1_jxB7KNvNWLWUWvG8tx
X-Proofpoint-GUID: LmYmgdPK2EZP1_jxB7KNvNWLWUWvG8tx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Commit 68078d5cc1a5 ("[SCSI] ufs: Set fDeviceInit flag to initiate
> device initialization") added check_upiu_size(), but no caller.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
