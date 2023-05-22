Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2770B35B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEVCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjEVCvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:51:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42710A0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:51:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LLr1Aw010634;
        Mon, 22 May 2023 02:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Cg7LXXQah4qV9pTbx+uwWn44v2oCIlgCdigkSldHtiM=;
 b=Xh7wmT3Hyi2TrMzrAtYlho2c8pHWNfAysRQbO1qIq3JBL/TrRyR4UdjN7Hr24QoKCuJz
 /d8P2Aa6LcKQjKcu0ZuF+9GkdPjGJXs3BvaALh82u5hWC8pg2nJqrxoLB2hNyrXjJY7+
 5WCdXnPA05/bG3Hgf0IPDTi9mXRjjNvpd52yR7E3DMvlHFjaJufehQvO9xUkGqtKNocB
 4w7AV6RKMRb1l1aecpt5nyc6i16oKwbD0aeeURP71n4QX9A/Y2ad9i0iSDdG97uJQgc5
 ghVqR85Rj5P3xF9jnsaDQkrp9PltivR1IfCTKsJegpvA5YnBnBgA88TqdaeXZG2sOS7j 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8c9r7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LN3faL028764;
        Mon, 22 May 2023 02:51:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2p4dga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ5T2VQRSQ3VcgtL6WtW89vAYSRtdtU+Uvz5/QWHeA1dSpIZOby3ctZz89nj/c/YrjqJZ44uzy7StuCz4NxgUMWydmCEhbKZx/R6YR/baAJPtbRWEn3ENg4aHqKqf0MP9fiN4M332m4S7l6/2PI2GxgE44q45or/1W3OPwIAdDcYJthVpm4LTlLwX3eZdA7W8bD+uj7ZRDmFETMbthi1y9yL+fvZL8EE9LDj/CcY6qYKUA1v1dEQFcQFnLqft6pk4pGIZEpIkky6j27YyV5UIrDFpk6WF0PJdodyRdN/N/1Q5/PAHG4ozT9wwPL5LIc2Idb59QngiVpXJUMKte/t6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg7LXXQah4qV9pTbx+uwWn44v2oCIlgCdigkSldHtiM=;
 b=chX7JS8sASVbJV+X2ACkdQRLBRs4fmyTeN5rnHnmWnGLZh1X14zwJX0r71hFws1iIH9Ni5Ed6cB71zr+QidPBmezoUJHm6B4h0pY1GIcubQIOfTuKcZUWzv117MG6v3xrqMY5U4TNOWIsWZEO2X/yztCtFGpnTAuKxdpM8JdokYbS3ymfCJx8IzIkP4bq3zOIq7QFAR2HV62C2uQHXlHlJz8SyhmwVnBOL4g8SnyS8GM2IP+wBTB47C3G3LB+LsfHJA6rY92nXuh9nGv2UZJh1OzFWn2cdR2/GthHVkagBhHONOzAohyfkdKCYGRt3rzLBhuKHYRbJpIUtKsK7rCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg7LXXQah4qV9pTbx+uwWn44v2oCIlgCdigkSldHtiM=;
 b=EIUYROCasGt66ZZon3zIDGi2FrzP1E7yEgv8vzul8DIf0lM02Fqz+BZWHq28N6l1EUK4dGazJNwMbwj9eTjRAuRPZNi21fhWdMZCDSwYOxvVgIFyKKGAor1tY6Aqq9xqW8PNudL4wyRPZtQOEod+Qe3v2eW7AayNnEGda4UkVeQ=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:51:30 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:51:29 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/3] signal: Don't always put SIGKILL in shared_pending
Date:   Sun, 21 May 2023 21:51:22 -0500
Message-Id: <20230522025124.5863-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522025124.5863-1-michael.christie@oracle.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:610:52::13) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: de016aeb-e8bf-4fa6-d3a1-08db5a6f7142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsvsYwWxzb8ak703qL8zLXKloPu9uFhh5+7Hamr/P9IrbsSryuMzUxi10EFdAD4G88o1BdOFBXLeWpLV7mcPq82C4PhEutYRzIyilD9CFSw3Ki5ifxp9GsW1LRokXhQVZydtbho0tg4FLl3d8Q/5lYJtzCgsiQFO0gN5JH5kvNiT2joddknLDjtkwj0oKEWXoK6YLaf/uO0lLshas4f0UYJqzjbTD6CDYv0Tj+kVIfEBbBaVR18S05rGmdJUm9zNONjZGXKCmUn4sNwxT3zI5HKQsv814mE/DOcrDOe3YeyXd4SM/xrD5Vp+VQFbgtFgyYWp885gYZGW5ZZVgGO3NAwK9+u5uQ1HAE2us6EvDr0PbbCFR5ZQY1RvBBPBrceizRu58c3gpJOXkhz9u6jidMnH2O438/9iHiAZuNjBWoQ729un5qQCHlu1uV+FYm3ZG0n0RO2YyjgsXY89lnHJTTmpysAtRD96iddWszUC5PLUaMn9+tXqAhPgvWczWRn7yrK1Gcc9bpwrZlQIbnu5VMFU5luc9TZAqyRrwN21da0kVq0YSl09cT8NMPDQgL8y263aswXyClFji7FD73XanIpCsx1bxMbavN7PrC6fAaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(921005)(38100700002)(8676002)(8936002)(7416002)(5660300002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(2616005)(36756003)(83380400001)(107886003)(86362001)(316002)(6666004)(478600001)(66556008)(66476007)(4326008)(66946007)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXFLRc+QxQ5Md53vIGntpRy+VCvTuJRvYItJOdCWjI5JV5rZEK6RI9jw64HY?=
 =?us-ascii?Q?s8rvZntBQVTVX/QtOBoHXTqmVbjMPuo+m4WMDVZLoTDdl0tZPvfjRJooT+hd?=
 =?us-ascii?Q?c2MbqJaKYem4a3rVcDoF/6RRuQgicLCdrVC/hN7kC8npX5lQTIJbDsLpr3E1?=
 =?us-ascii?Q?NEsI1yGCW55K3K9b2ELljGXEEujsT1rM0Kfsl7vwYq5IlpNHYf7m5FgQ9Mct?=
 =?us-ascii?Q?++un1VOg37mJbK8HNUfrwfbl5xtvi2AVlKhnFBcd/OaHOf9KCakMJjQuTTx/?=
 =?us-ascii?Q?X9yzYO9vcQQj4uenKcMF3PXYTlWIgPCxKf+8+R76vYL7IebMC3AyeUBjh/Ap?=
 =?us-ascii?Q?JfTnNBe+wKZonb//OZYTnONgBgEHzuc8mAIKKsSfvwVAC8MlkTEMcSna9O9R?=
 =?us-ascii?Q?Kyl72G+X5yt+e/qjA/vE/DRcJqOxgUkeLWkAau5MVmMaV1pHfKBRTy1r/qc2?=
 =?us-ascii?Q?PTGOkRgp+MGgsZ2pkDKK03qb/uOtslWNN9Udh79VKRtYUqVAicn25Ck5CQgS?=
 =?us-ascii?Q?W/4PSZbWDUkeYzvFbgKzsB1yfi6HLPMRFvc0hGUESuzOlyXc0hu+VkKxJGJs?=
 =?us-ascii?Q?yP2ljNeBdUppQdMhcBGP/GWrYFucP4f+N02lutBtg8idIRLyPsM5JSEX3Xv9?=
 =?us-ascii?Q?OMPkgxDQmcO7EqZzOe8htJwj+R4bXzQ+SfKbo4hCo5k+/LzWjpuIl1Atv0G2?=
 =?us-ascii?Q?V+yLrESkU72NxoCIcChVWmdHksBGkWQGqf+CJh8MSevp3n5N/nB4tS6bIuxM?=
 =?us-ascii?Q?l3tMIRZHJ/LNp1u6ODXEjS+O5opf29syu7ltVYBXFhrRxi3PPU3Y0czNYG5M?=
 =?us-ascii?Q?OlOdJKCui0j+tKesgDtx/0idIcauOC0x7a7aKLEqLKLDCJOx2FRvlphOFzoA?=
 =?us-ascii?Q?FuWBl7mA4qaSLSjVlvl9CnCu0OQw91W6jQL7Mezw49vAdAKwZ2Jyi6Dxmy9F?=
 =?us-ascii?Q?fkBoiqhgZAGkbRmzxeRhsUeh3K35u9qmYACb2yeTKYSeeGgR5XbcQf9g3lvC?=
 =?us-ascii?Q?bkaeAJy0jLFSKRm4C4Aq7S+tET/cNOgHIGqsfRuz1dDqg+GzZC7NmodO+seM?=
 =?us-ascii?Q?ksfldLSXQy2sfh8XPc44B3GgcEmEyHUebEOR/cRmQ14alfK8v+9RqhG74nHB?=
 =?us-ascii?Q?UQMPz9X8FajxpHXyDnkEH2x6ThJ0cHlimjcGWnRVeqAgOrwkyBSkvoFr5x51?=
 =?us-ascii?Q?SsoABVIdqnfkxTP8jfOywF8JJ0nYDufJzAJON0evjVOdxzGl8IPDsTyrtlsI?=
 =?us-ascii?Q?+UnoVmgv+t68774IFhHJJBH70nm7GJCwobgr0xUZkUbX0TiWuTV2Bcjm/TzG?=
 =?us-ascii?Q?uVQFhJ1OUbiQt10STsJSrEgQlxbGIy01fir4MMcvwvoVjvWEybzjjxQ3/84i?=
 =?us-ascii?Q?CLHVQGzacUpLR0++i1AUpzE0U3pAH1G0LYS0IZTWN+36Q3c0CbhCDKd14JbA?=
 =?us-ascii?Q?gycVSwG5hmdZ6kn9q+QnNirRVSviTzXht2lo5OSqFWdCjqfy6IKa2jU7hnoi?=
 =?us-ascii?Q?z4wS3TQLY7uC9RkGOpFvX4u6uKufSjjuzdsw6TwoeJcfAphx+5JVX8qRjDZu?=
 =?us-ascii?Q?+QhSKEHSONaD9kxV/D2UPsveNDrHlZ6AfK+GlhFOol1x7yoVVutzsr4E+CE4?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?O97xa8eZfS40pPGNfnA3tKJQUK68CT0saOCETf32U3+j4G9aOpoj/9h0ygDG?=
 =?us-ascii?Q?vXoYlu8z5FGZvRj3mTn1aheHSFWuZjfXwZlvy0eYHqHWwpe1GLIG4r6SJC3l?=
 =?us-ascii?Q?mVbasgOzHkMrx8cLEKZZlZ65C/+A4Ze3GlD7TSefTbNjScu48XUHYu8609FS?=
 =?us-ascii?Q?8sQOUYcFdntHjuC6Nr0tviMq6qdaQaqQWFO8iM2B4sap/EJ3mMH7iaImqQyH?=
 =?us-ascii?Q?/U0S1vhNRY4nt22opWsNc5RU0nee+/heAPca191uL65bu8QLVfV8cFeyHGC+?=
 =?us-ascii?Q?2y3h92TSK/tHOqMc3zLhADUjwOKW/d8ljct3PiGMsfRyczizXDxwXFdfnGoe?=
 =?us-ascii?Q?NRJrLrZu0u9UNgLYVN7wAYWJtmEyCkez/lbV2dTBHxvvxnkgvD4nNP6CSyb/?=
 =?us-ascii?Q?2P1f3JfJlkco//daGglvPNDxxosxMqJ7oXlTmLtfv2XtuYxgINwR0Axu8tFi?=
 =?us-ascii?Q?1To/q46yMeryXVkN9es8KLdNdSJUxFPp7EDDYeWolCPDGUmcN+0QseJa3mHV?=
 =?us-ascii?Q?XvtdVR2+IF4TEeePvN2Y6IDWVDtfmTKiv6HBuwfMBvVMxZpLwl9GyaGWJ2Lq?=
 =?us-ascii?Q?agZcQo0qukFFoF1/RouzKwtI6SeC2Ae0b0CEjeOeZ9TtszsiDZs6uKHyO/nx?=
 =?us-ascii?Q?iFedY6uvxDsQ5+gaN9C4j75yJ+4z57wjMphasqCFHmL1/16DAERjkqBy37NE?=
 =?us-ascii?Q?Ka5nU4SXQIjKiNnpDuS5HmYI4CSCKSzEbScobU0BN+nWoxV1Ck0xNN+bzx6A?=
 =?us-ascii?Q?oX6JjwS/QkrqpCB+0BQCUlPZJZmKJk3tABKzWnWHPOztk9g+xNRzCoZL+WSh?=
 =?us-ascii?Q?FloW2BYv2SKS50uaGtsDzyi1zy3Ey+3SOMbaaJCPguara29oAte3T5TNERc5?=
 =?us-ascii?Q?iXskNzpgYUOhzvmPzIfjKjxTdvafUfIu3RfMqIxFLHy7fLQpAjkC65qo1ma9?=
 =?us-ascii?Q?wTiGwrlK8yorWINuDuT44/mVcvW9jdWfudUbotKJNSY2qjWQVp28pSHnV40f?=
 =?us-ascii?Q?krERxZOPU0PoWgSJQIRARAqaiDNgwrN2uA8TAHd60eE9gfErRMIP5IwZbUlJ?=
 =?us-ascii?Q?96ABbbkl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de016aeb-e8bf-4fa6-d3a1-08db5a6f7142
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:51:29.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H9sx8YDBLM1Sdi0dZNd+FrTITJJQJ+yT+HOQQPsbBFl9dAfUSFPlAHZZL590SQLOPa/Cmvkt3+JnpZLwt4jTeg+j1pXoCKKCtRyjkcENTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=905 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220022
X-Proofpoint-ORIG-GUID: s4ONPpU6a6QpCORZdbF7Kh3Zr8S-53fO
X-Proofpoint-GUID: s4ONPpU6a6QpCORZdbF7Kh3Zr8S-53fO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When get_pending detects the task has been marked to be killed we try to
clean up the SIGKLL by doing a sigdelset and recalc_sigpending, but we
still leave it in shared_pending. If the signal is being short circuit
delivered there is no need to put in shared_pending so this adds a check
in complete_signal.

This patch was modified from Eric Biederman <ebiederm@xmission.com>
original patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..3dc99b9aec7f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1052,6 +1052,14 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->flags = SIGNAL_GROUP_EXIT;
 			signal->group_exit_code = sig;
 			signal->group_stop_count = 0;
+
+			/*
+			 * The signal is being short circuit delivered so
+			 * don't set pending.
+			 */
+			if (type != PIDTYPE_PID)
+				sigdelset(&signal->shared_pending.signal, sig);
+
 			t = p;
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-- 
2.25.1

