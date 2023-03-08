Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF76B070C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCHM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCHM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:27:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FDBAD3E;
        Wed,  8 Mar 2023 04:27:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288EHc6030982;
        Wed, 8 Mar 2023 12:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=UwCOnQKyWdOtgU6WZ3nBwYvTD2E+HY9/NHkhqqvtBGw=;
 b=gXrLDg+GKfnAjAMVdQ+dqsmekkuUm0Xm2R2r334eDDJOda3e0C/d+7QpESggOV2Y/3yK
 drEnN8JsRaXqxok6m9Pnbbw+KMk8KF54op411IenHEDSPXVYGccjKjOR2HE4AVuWVBau
 4wcGgA/8NpRx0Z5GTknUya31x3DINEk5NudmBT1krk8r1E0jW8DpMbiHKPJQB0Wjj+iP
 qpMXNxQI8a2Fsj294QN1OOy660aXsIJiMTMT1O2ERzuqd1bVIBljpd3siHGMENq2ZWib
 UN9AC9JtnxCkwFb6aZmVQjnDnJuA7ejUXOp2ytWS9DSwHBpj4IlxCRSciJcxsmE9cNjG pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wqy6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:27:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328B496u020792;
        Wed, 8 Mar 2023 12:27:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu7wbex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNjDgqF2NZ9z+i6SmBSH9hQuhr7mwVEg9YxHLLHlA8tP1XBh1FP1OjeihIwtmd/K69pKhiBmN6dQuYU1/p+lWh+cn31F3qYsnE2+v/iFcTH87M6BQU+rfgyQDyltlygSMNkN5kty1XFnTVeEYpGINeUjP02ycApDdL9P+51B8J6PSOqnxmlyzX664uDb8kheN+3L8EVxQ71aY7+fW1fWBTRjJhWGtkeisz/8gRQ4el5VADzmKxc/VlOnZarPI58VtDiuHAOYI5PWSBZXtikBzNzM+3rHp7EwlKwr93lza2YXqNwQjm7FHLmkkT9AWGJ0wKGEQwCiQ8zTe4rqv7PByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwCOnQKyWdOtgU6WZ3nBwYvTD2E+HY9/NHkhqqvtBGw=;
 b=JgbL3PrkB918LJ33NcIJ0Nf69Q/SmVoitQnz36kCuKVd9hbw6+ysiicofqT1O4pSP6/A8ppinGFLvf+17EVBSIsFBOVSvUNjZd1I0vI12B7IlK5n96zWzpx2uByFekGWQWSLlMlce+sehKgB6Uht6FdDtT1A8sAwJAesziLyFkEi5WQ2k1TN68YMj/2PtcMFi+TpEopItBCacUZ/kU1fItD7aLUujZwTw6VQe0YlepcPuuMp+9BjBwf+m2StxPxQSQ1kNGHf+CnLBZxXGdcxKi5AORQhckgri/j0LlT6xP9HLEfGb+MdIT8Mlv/Dl8KSNm8OL1sWzb48TM+GCZW68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwCOnQKyWdOtgU6WZ3nBwYvTD2E+HY9/NHkhqqvtBGw=;
 b=kOUoRzV6i/ihm1yrI1oepFl8/NcQk+e7jIRv5StqfdJJ6OSL+kfLhfTJu91cK81Fm4QszrfXbJZvTelIFZTkJQi8s3vPlx02uK7bVGBT3+6tKHrYw8v5RSq/oUl4XkKivtt3RGcToFNyfxAbESWw4ivT0kfO4swJYBjUvkWPNXw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 12:27:15 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 12:27:15 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     michal.simek@xilinx.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mailbox: zynq: make modular
Date:   Wed,  8 Mar 2023 12:27:03 +0000
Message-Id: <20230308122703.114549-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308122703.114549-1-nick.alcock@oracle.com>
References: <20230308122703.114549-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::24) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6436b5-6756-4ce9-5ea0-08db1fd07347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmVPpF6lo96k4tEI/dDMG7DZL1HAUama9QftlbUT4wDcsdRD+OkWH+teCO2tOTR+78bSZ/LFiuKnEeCSAKhHRAvzhowGl92QICK7QEJrtiFoQhL+PbuKj51C81fLsoMAWqWwHJrGgAGX2VzisqRvuqFh5J4fQDdDoonvcjhddoIpbfuPawJlFbbZrHGTuqXmzNRDC2nZLecDWZctazslgQm8F3he6lAf3G7jKEHfhCgjjZ4yIAh6nxDEAB4Dv55EbX2WLMOm+2Q5/P2e3Oey0ITZ+lQx5HuEpTuPlnnEoanvCCE+grJxmgHBOQULmGej6bfNWnd3tVRBOqsLmlQEWgqFut+drOSMixlerSMCA5Butsd7uMHHeAEj0DUzSefGoUjnAXPpXp9v7GlniilWnSUegUc49umXqwMSu0czuBSWz70ofwlc0SdK9MldtOXbfl9xdO5WA9eeay80Sg8NQbUmStsuyDRAaSJQ4kJyg55ccAkc8HUnKkQdrfWfAM/AeqLiyl0a59T9i0vFkwCfRjudYuaSdWH8pfFt2JscydWDru4ilF1GKarakvk0vaXcKBO48c5VGrVJiVrnsp4/2YOn2qcHzn6HVdzGKEM5kS0M9Dk17FIgNVKiFb5LeHuwJu8zXzNC8WCow4C/p8wJ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(66476007)(66946007)(66556008)(316002)(54906003)(2616005)(186003)(5660300002)(15650500001)(8676002)(86362001)(36756003)(6916009)(4326008)(2906002)(8936002)(44832011)(41300700001)(1076003)(6506007)(6666004)(6486002)(478600001)(38100700002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+AduklPaNSEhVOWzPkfWW8o8VDQ5lwz+UIJBHl+tU8YceoywbS+7afCu/2A?=
 =?us-ascii?Q?hez0vFLhgS5Pg+ICdO//i+BVGc1tSEVDejcfEopNvs+zueR2A78RIo6RtdRi?=
 =?us-ascii?Q?eoStwUvG5K7y4HCmdoyf6Kg1c/NQgUYrt/7U0vxp1hGnotBdy7TKvAno65xH?=
 =?us-ascii?Q?Oet6vfkgsFBYtRpCQqkVNIIEtxErxksHt02zMbP9UA054hSOjuNvTcuQnvfe?=
 =?us-ascii?Q?urPU+T1ukBcotUrU/c50uyWWAhy6Kmr6pXl/um9QOlmgt6k6NpJkqShXIpN2?=
 =?us-ascii?Q?z/7RkjxkxPCn/8OVEGbCkl22sLKqLM26XXb/yY7CibhYgKGbeWzHYvIwjin7?=
 =?us-ascii?Q?b87QVqk3oRKBhnkRC5NsJGLFOakuxhGBZXc93wIM2SNIf2KJ1DHdMe6TBfNX?=
 =?us-ascii?Q?rE4+2tcYtrV50488Hkzq1lywo9H59eSiWPYdcNyI0cTri2/Lphc+jBi+3RSt?=
 =?us-ascii?Q?2AUBY5B14LptKAlM1zxcN6Wls+ECSy5SxfRhTxkW39kah2xw5I4pvGkfbLVk?=
 =?us-ascii?Q?NAhEO0fzFzCAsKbkfpYde0kT+ClhNYvxPvMeuJbnu0dHizgeJ8IoMD9zMBTz?=
 =?us-ascii?Q?/v5CI+uoBftkyc8YaJVVGnhItEXcgz8zsfxKb6qM1nvnLcYsd61kdIdAO3ai?=
 =?us-ascii?Q?tiSc10TqJrRLW1kziJxpHbWWfmjjhpy0vmqbajovRyzPEQQ/WBWOVPMnTJsw?=
 =?us-ascii?Q?8mB3dEqMbqyuAPWg0jNxRT7C6ek55v1UZ4oYZpIcANHbwpblzzZWF3VZ6YvA?=
 =?us-ascii?Q?X43XHYG2Lh/0BFH60X0S2qQPWuWPEacMgAh7XTR5xWqvqijCH0EvkF75ybLY?=
 =?us-ascii?Q?xRVQ0EhFtdPR+emgDMGQsDtwyMsFeq/m1NU01RYz5QsFqVcd9JFN31fJz9I3?=
 =?us-ascii?Q?rKu2Me+VOuyeEVBxv2CCbawZg4PhCwsiN8aqZI3cexmoPIS+1hYC84x2yJjs?=
 =?us-ascii?Q?B6kRzoSneYJRNQRaUhDnIOSKTOB3aBEU1lFLbX/6xY5uIjWX2stemTz6BaDS?=
 =?us-ascii?Q?X9PtNdVZhsL7LcEdLqAkiAfZoH1rPyrdAojW9Cgz08z7Y06PZbQeWoGyQDx/?=
 =?us-ascii?Q?fDAdaHKN0FaEP2psvXWCj7W8yyYxkp4/9rlu0b4Xi5OGeyj0n+trO7IFwpFS?=
 =?us-ascii?Q?q8SYBRL+kGQRrn2ulRYzMA6DkhZHAa24XMdhkH05P7XWfGRS1xWaABWhO4RR?=
 =?us-ascii?Q?5ZjeZBKq90M8HS0xdWrlqAdj09hAyffWbKe8lxFjiCFC166DgxE9YRFD7H9k?=
 =?us-ascii?Q?3BEeSHcRj/inx2qIasOLrO68E8y+CFmJgQYUO1MFUsf7XACjJFfY1FreH1uO?=
 =?us-ascii?Q?9oLlvfP1uscIoVJXgN8LTBhRzoOzjqkOETqUZjNpjHWCnuUacBQj41ae+yNk?=
 =?us-ascii?Q?653eOMg3IlvICcygYGeK1T+Yw8AelBw8nztd0YXEm2bVd2/tjS7Ho+qBD3vo?=
 =?us-ascii?Q?3v45lx6Jiw3iLqt4uvyd1fcA0JoF2ip4AJaZc2mg7xQ9Z4ULift95VxSxBn/?=
 =?us-ascii?Q?XFYEx5q8tfsOUzSP4KxUzfKDYBVjZxu4J4eNj3qF7gw9lIVsarMoAhawrKjE?=
 =?us-ascii?Q?seW3SYHmVR4jrrlep/+JNMLmg2vSxofISsCP7HczO+yq+gX+JoLnao8mdlUn?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3n0LtQaL1jw3jiv3hD83CrI6s7k4lYlyCVZylqYaQqyPIUO9wUFGmaW5HoeV?=
 =?us-ascii?Q?uZalpazD0/sz1nVKGr/AzlkEOjBGe83NKPKirzGzmdGDuHOLyDbkD+2M6Cuo?=
 =?us-ascii?Q?e+x+sK3s+0zRnewmPtNf4zniG7N+q1hGGKsn+ijgh/GgK/K/oI307lF8jbVD?=
 =?us-ascii?Q?3qT9+e0y8nIrMg72+DKATOHAENhHCMMNNDp+D4JSh+AS1UTozh2JeCdV+oB8?=
 =?us-ascii?Q?2qrO+7fHocSE9ERpozvXZXonRvs3BR6FEnI822ddCKZ8j6c0yWXWLI42ULDG?=
 =?us-ascii?Q?LoYvCkonfp5gYDPt1z2vbq+bt0oPIkE3hmywJTu17og9X+GrUjoeCF0Sq9cc?=
 =?us-ascii?Q?0V76Zh9c2FzR5jg3t1RmcrPfvE4q2DTzd46eDCRgQA9qTtq/U3VtC2VpJiNm?=
 =?us-ascii?Q?Fwr0II5NtbrleSiAuxNohHpeyduVY+GSdE4TpkPBCu0TArsqzCy3pA2vVmgo?=
 =?us-ascii?Q?R2ojTKKVrNm0/+K9fWaN/5r8t+IiZXMqi9uK0eya4bd5n47PjNNUKLPleMZK?=
 =?us-ascii?Q?cbL34/iYcST+nYRCfgwsIkjAS6N/sJs7AI603fVRnBNCxQysOtsqkT/QoNH5?=
 =?us-ascii?Q?8WryVf55MXc/sG8r0XPv/+QthaC/9LCfeQgB0f7YvTnF9zY84kJ+n2sb2EKZ?=
 =?us-ascii?Q?YNXD4w4D5M4nUnD6MIBYJz7KLZExI5APzhIQgLiPpIhbW4SgjcVO5X3bcXOz?=
 =?us-ascii?Q?mBuai0xxNaMGJqFXKyGPOriw3uj/fTVSUlDszTR1Fq/P+g25P9QxyvE5NlQN?=
 =?us-ascii?Q?MOHikrGTF0hbAIXVP7P+if9yvYyoxr+7TEcnrxbOnJymzAwwUuoYw/1N1C6Q?=
 =?us-ascii?Q?50/6JBGd1sO7g7cc+dU4+eQfF2X3qnbFF8A+pvN5xABe/6uQ2ANeUQvMFzC6?=
 =?us-ascii?Q?IZxToycLoVOxk3F/0w+/SPJ6WbutJNKX/OI54jmD3eoBRdvnnZAlvflR4T/H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6436b5-6756-4ce9-5ea0-08db1fd07347
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:27:15.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/O7Wyen3eAoZ7Ro+1huaEcVgV7GQ0sG5mUxEF9bwNFhra/k/dtNvzBYvkx7IwOefDeh/HSpXzYFw3Rxcmvqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080107
X-Proofpoint-GUID: BqXlEAsxVSXZTnXD02WTrA56-5221LjK
X-Proofpoint-ORIG-GUID: BqXlEAsxVSXZTnXD02WTrA56-5221LjK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has a MODULE_LICENSE but is not tristate so cannot be
built as a module, unlike all its peers: make it modular to match.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Michal Simek <michal.simek@xilinx.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Also adjusted as requested.

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 1495965bc394c..af6b0f5b491dd 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -259,7 +259,7 @@ config MTK_CMDQ_MBOX
 	  during the vblank.
 
 config ZYNQMP_IPI_MBOX
-	bool "Xilinx ZynqMP IPI Mailbox"
+	tristate "Xilinx ZynqMP IPI Mailbox"
 	depends on ARCH_ZYNQMP && OF
 	help
 	  Say yes here to add support for Xilinx IPI mailbox driver.
-- 
2.39.1.268.g9de2f9a303

