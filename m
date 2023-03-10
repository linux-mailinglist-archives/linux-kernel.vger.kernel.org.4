Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF56B53CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCJWGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCJWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E809108C1B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhwht001380;
        Fri, 10 Mar 2023 22:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wOS4crnF7UzB77MiOWLKhiLPLcBxr6ca62kT++wIZO8=;
 b=V5BtUgMf/ojrjRozkCcNif9b4rKa0Z4X7NuiFHVUt117BFpW/4ripc8jktVVC9gMnVqz
 pijBPXe/bTNDH7WoGPEmv5Rbjh+cgigyFSkCWAUhZA9vQR/DM+0m4FEVNjC+rSi2o3Cr
 s3PKi4Z6dllQxYSS2YfKG0VldzYwx5YUDednobVxZdcEd3smIAGTJQJWOWVDHsNPs+T4
 vMiFzL9cS7DBA6vZUNzsonpE4kvKHdBSVd6MbX1KnCzuwH87NLVQMdyNUu/m7HHb/R0M
 qDgD41Zxvv6BkzjzWVwE+ObipgjBQT2CG0QMf/0sIGrKfwMywRf/mr4qTf9jXIjyHzd3 XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4181643d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AM2T3V034871;
        Fri, 10 Mar 2023 22:03:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fubfdjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2xIw55NRYsTj30oXy2AOlAaaYUYOkMpk2KzV5qiZWu4LMOd28i5VwS2udzw7h0DDM6SBiF0pLHsD4CsM9w2M96nTw9h+jHNYnq7s79+tGL0LDz+wGBvvzReR8tEcCH0fdepQCA5WUlPuK9AcI7JtaaHnGnottmi8s2iZK01YGXlDcCEQ598zg/WA1rwNAQ2V9aqUVaw7RXYKsV5lUGR9LPXgVDHfm+U5u0nqfRNlM5prNNITVhFDlXF9jjlqsv3siwZZ4LYcUDDsLvWax4h3O9qsn6c0YuxvcQ6rfv/TIAXrp/vt8+sg/sbY5J9LDK6zMq7P5rDRu8ymjkG1eMMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOS4crnF7UzB77MiOWLKhiLPLcBxr6ca62kT++wIZO8=;
 b=RdO12uJTbMFNn8kS+wppg78ezYtJX8wKBk0chOgeBVqhVZ85dMUN6D56ps5wCdUI4dHNMhFhRkHrq99gLxsu9t7D09nHdEm+oXGZU8wHMWX5BvY0hxUyaL38tMyz3UX9pOVwIG0STRsRIPX+5iLa1+YZnhmx9SvD0VOTcE0guOOIJUKnPkEhf0D0L8XumgIkz57mNB21GOXXGMXs10QxFoWMprRSdUg6dSskCY601i7SWcSQ90lBH5DAxxX9jH0Sohp372bSyUrf7PmqRRH0RcQBdJFI1K/F9Tt2QAHYGTgjWOKp2ZVwG38RjqL1+SeE0KCGYjrygUMGN47nx6jgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOS4crnF7UzB77MiOWLKhiLPLcBxr6ca62kT++wIZO8=;
 b=voO1Jx3nxDARMaeYXtAper6glPSW3l1RbS2E3WjdGkg0giVoPCVbXiuDlOs68eKg5lDGgplZ4N4cYhEtCvmmBRKLiPsw0hqQjeaH3aD9kVhbeh3scur+a14LHoEYwfbUssLtk9EYtZSIlCmea+a2k3bqPakSMDcjaGT/dWglFZw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:35 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:35 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Use copy_process in vhost layer
Date:   Fri, 10 Mar 2023 16:03:21 -0600
Message-Id: <20230310220332.5309-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:8:57::28) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1a65f7-911c-47b8-ea48-08db21b34b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mwrbi1yE6f4eMno0+IpNYedk48+nm/GVgasiSTkeqH93ZyNSeCVNKZu31rai1wxPdjSsZbi6glimWhyazKSbLWcJYe/AKH+603xMrzz+/FIJmqTRun460bzGiilVuRiOLBjTDvNexSWHEjVVnURvZNwdqytDTYn1VurqHyGvhw4qlizhdi+ySbQPBd1Ort4xwpAaxgX95RW5+dNH+2Xm/IyPhuV/oGG3I6SerUutiVnYzPuFLx0SZ7ip4MpXTxLoVeashvWcmowFCH8LqamWZTzi1FA7Wsu2JFurwP02qGr0/XgaZRgcxPn1rekqyjZj5LImuiXvQulw+RZNbOy/ZCJjKFHu+Q5PG2OYsi6WGrWtVD0QjFWlTBNyy/d0m+4MMfljkwx+2F9PgubB6Mu+DoUuu+BVCtSu5qI6WdBIO8clmb8LKHOrVxky+KbZdLqB3aRA5WNaTVXXWBR/OgXVl2HfY1/pCBopGFFy2RMnuJGNUPLdb6DolIJ4n6tbGtI/jBZ5nhNHt/YrQdZFyoMZOKS4LDI0n6eB1s2OlYFj89LOlFwy6A7mVkUP2gSbhiCpSbHYiR+GwBgEP7k6Fs/dki5I8MTLl0QAHSajTNAiMPXaNuo/ko+38r4db7Ml/1CvGUtmp+0w71ysELjmF43mdV70KZ0xVBFsipjc5WmpxmvbFhmLCGIjxrh4EXsxh/8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(966005)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(41300700001)(5660300002)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XK8ccJBZ7pioACecvs3wnpZOcE821i6QLSsyMLk0WSZ7UWmPY6W57hDh8oQN?=
 =?us-ascii?Q?KbObASs5aO2ndJC8whYkfC2xeuIKxcw0JrayqS6EESCW5QDI4j6VIUh7zlcT?=
 =?us-ascii?Q?hmKU+HzBdgUeBldmQG0tJu7oCIS+lPJR/ZuFYoibfHgl0FXzmMoMez/H38fo?=
 =?us-ascii?Q?uDygl/AuLx/3qf0RV8k6nH0d9U9KDCw3tiD798Ab4CDjMb5E4CqHjTmDBBnm?=
 =?us-ascii?Q?Ku1IxJaon7H7RhRK3r/rj59DgjkzF9VlWKlNwxJgUWoRc9Z91Y7GWqadvCxx?=
 =?us-ascii?Q?9a2a/r4UKgnRky55JlrmkA3rBp1DHEzrO0c1B14aDadwEerT496NEn6HKytM?=
 =?us-ascii?Q?706COCUTJ5XWAf4FErkXlVjr1rGd1HuVMOUuy74u8dS2EXBW2Z1rWzMWTGib?=
 =?us-ascii?Q?i38SI+sKU15GVrzfL9lujwXiBInx94/IMIig0FIIqYdl3MWFs5smG3K/YQeL?=
 =?us-ascii?Q?eftE520vkdlW3ZDmPDu4IzKTdSf1bhiYp1ZlAGJ33JUrWla9glzlCqP+RQ+f?=
 =?us-ascii?Q?rIpvUQHE6Xe4Efj++7Zu+EIDZPk+Br8cuBzEfonDXIUaBgOaAoCxziupyHSL?=
 =?us-ascii?Q?ldlyAiL2zi29foDAhY2Nne6907Kt2nH1aH07Fr41c7zOSF+93/0NZFgN2vtY?=
 =?us-ascii?Q?Y8Ey9+2W1ohYFqEb60jv25Wt7K+DfdfQUOCRQLn458ICVj8+Ti77yw2+1z85?=
 =?us-ascii?Q?ownpgQbJTgLapJv4aUNrMtU4yuyXjHBhGMSu8ZR+U3Mq4+Pyc3bl1Kmg7ujs?=
 =?us-ascii?Q?LOy+7d54sOQOw65Njsaza5/ABqpaWrgKZYnELaTs3p19KnZkUVMiF351DMSc?=
 =?us-ascii?Q?Jx+CMW6LnCosJPw8hYvoldtbUygeMB2qyF+sV1JPiGqY8teEHh2e8gsmQ/2f?=
 =?us-ascii?Q?oue59UgewopfUq2FImVdcA4aXH0/x5WmeSzqn0Xm7WSQShaVwG7/WRQO5v97?=
 =?us-ascii?Q?WXwBxvNC8b6bmJa9+iMcKPR/7Kw6k4xNhdJ0skYETONZ3r/vad+o5vU7h0Kf?=
 =?us-ascii?Q?bcvdb1u2I+Phpojc0HAhEDV6PGaRLpZ3NrVWksh1U7kDCZQvu+okTPcRcVCP?=
 =?us-ascii?Q?L0Czr9c634GDKfE4jxI0CL59MapBQ5XVhVf3Bxvbw2aHRU3DONecy/yZmUgd?=
 =?us-ascii?Q?hRNPlSktMWyOJaXwMdMFBUxDaRT3Cj2q0+V/vYQB6XQcBkqdWTnVqo8hif35?=
 =?us-ascii?Q?2vMkAFlmQGd7XNm1Bo4qoV9nw1LMccHuZCYMEmgk3zizfbsfz/LBQQpm0hWZ?=
 =?us-ascii?Q?Q5Ar1BmBkfp4GdlWzQn4/vfILVYSPqUEMJeWJeNTU6299S41marKLxkzsEoj?=
 =?us-ascii?Q?j9/w53SvWaDq270EOOhpnZ1hI0tujMJgQOiATtbv28V8ovrgCravlyHD35D/?=
 =?us-ascii?Q?VGLPyT/x+oc4v498SIcnpibQOk1LhFKfApxGTMgNq7UvPBajMm80dUNBjkAD?=
 =?us-ascii?Q?ivUofS1sJmnbBTtCATvnoYqvabblpXvi/d/ysljJZjxhSmUkPbd8EiTSsjDU?=
 =?us-ascii?Q?0KLmVbcybwvoHk5wGSpJqskKHJQj+jNusNmSVpcFjTVBomsRVWOXfalQKbic?=
 =?us-ascii?Q?sQn3W3rMfK4z7gpI3nbM3kbXjo25vcGIoOmoepagh38Mu7bZHKSWwIRAMC/m?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nyWy2fOR8mOreFmmkZRz2sUjEeX5uSyzRPtZFKfsTf6TgIhZaAIQ+jTJAEnq?=
 =?us-ascii?Q?wH0g1mSz8xw4gPOHPKz0v4bOQw54iEXM3tRfSSiaTz1JfUa4NM4znZ5qjVPi?=
 =?us-ascii?Q?HGcStH5BaDCm1+TDeZ2GHESFWMrPyXuyLf6sdCh9d9nor8mrN7wMzuf5+upP?=
 =?us-ascii?Q?zXFCAmyeKLAg+wqk+/6Y06bQDNzTrKaIUbjs9QfCkMcBU6lPUAvi/EESgjPk?=
 =?us-ascii?Q?icL8w9vLh40MY+VAfq5bkdZn0L3BKhRXvHiJThXkBUeaq8Gyjkxqt5GOgSYf?=
 =?us-ascii?Q?NHSaWK9AcMhibsmHUUuf3Xag2VK6X9yOPiRmAoO/rAhJGw+JIl51yVHFI0VX?=
 =?us-ascii?Q?Gj3f+6Wtid6EDNqVr7g6oVXCwYB0lvZbWaajbMQeC5yZ7UML5h2/PIX4+KcU?=
 =?us-ascii?Q?DZNrZVHHCnkVfxXgF3RWGZXhCblQvOV57K0+Zb2rt/g8/REIBAt82JeDCR7w?=
 =?us-ascii?Q?GhVTlcWP5nn3cxR5v0kkKy6Bk5UGXKTpRi4FIBB4eAa0n7/UhQv47qzyfYm2?=
 =?us-ascii?Q?J0nzvRvfIxUNxK8P0rPL0hsOhuDAZ1yDppy1aK/1tF7wzL/nazBIj5wvWGgf?=
 =?us-ascii?Q?q3wDrOB960SDHhtxK5b+rs1fSPDTBrqe9797vogOiAkQx2kk4jP/SAzhqPOW?=
 =?us-ascii?Q?dS1FBQbzBQfFF2lzqhnVAdm5gGGsE9geXld/j9rzybX0kIBugtKywrdC1Xuv?=
 =?us-ascii?Q?QqHGC8qPTXuIrl+rG/5RZRuPEOB91NHD1iwjpwanKbel9FHECl5nEjIqmwmf?=
 =?us-ascii?Q?jbfnan9ipZd5iwefwFXaDmACdFMvMeeVsCKDuFTF+83ho03P2DnBU3z+8WEG?=
 =?us-ascii?Q?hbgdSZ31UZ1608AbHGl7hbtTjCsh1CtKqZKSyFJwUuiH1/S3QNYGTRpApY/C?=
 =?us-ascii?Q?aLvE2MSiHgE/dCOWVMp8TTMzU3wky1eMTGrD77hXtWhBqG3+JrJArR1zVsSW?=
 =?us-ascii?Q?tS7AYNqDPV5UIEp1jSr9C3tWVHsQDzq9hmhev0u5SDdV0D/GNeXb3eNBZqTJ?=
 =?us-ascii?Q?LXroxqWfWgpF1HQyeiH9iO5/uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1a65f7-911c-47b8-ea48-08db21b34b5a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:35.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RF3kwS86pLCHQOUafP9FS5W+mAWmIIXOtHmGm3bY37ZdF/PxKwbwsMKLVg2eqB4gNtjqcEUNPJsjo0BLWs2p+Kj/JnMo4zWyXZjPOdsZaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=705 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100176
X-Proofpoint-ORIG-GUID: 2dUtz4MUpyMMDVNcVYLH-1X3e4391X5d
X-Proofpoint-GUID: 2dUtz4MUpyMMDVNcVYLH-1X3e4391X5d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches were made over Linus's tree and apply over next. They
allow the vhost layer to use copy_process instead of using
workqueue_structs to create worker threads for VM's devices.

Details:
Qemu will create vhost devices in the kernel which perform network or SCSI,
IO and perform management operations from worker threads created with the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups.

The patches allow the vhost layer to do a copy_process from the thread that
does the VHOST_SET_OWNER ioctl like how io_uring does a copy_process against
its userspace thread. This allows the vhost layer's worker threads to inherit
cgroups, namespaces, address space, etc. This worker thread will also be
accounted for against that owner/parent process's RLIMIT_NPROC limit which
will prevent malicious users from creating VMs with almost unlimited threads
when these patches are used:

https://lore.kernel.org/all/20211207025117.23551-1-michael.christie@oracle.com/

which allow us to create a worker thread per N virtqueues.

V12:
- Change how new fields were added to kernel_clone_args so they don't
unnecessarily expand the size of the struct.
- Use named bitfields and make kthread and io_thread work similarly as
the new fields.
- Allow copy_process users to pass in the name of the new task and
convert kthreads and vhost_tasks.
V11:
- Rebase.
V10:
- Eric's cleanup patches my vhost flush cleanup patches are merged
upstream, so rebase against Linus's tree which has everything.
V9:
- Rebase against Eric's kthread-cleanups-for-v5.19 branch. Drop patches
no longer needed due to kernel clone arg and pf io worker patches in that
branch.
V8:
- Fix kzalloc GFP use.
- Fix email subject version number.
V7:
- Drop generic user_worker_* helpers and replace with vhost_task specific
  ones.
- Drop autoreap patch. Use kernel_wait4 instead.
- Fix issue where vhost.ko could be removed while the worker function is
  still running.
V6:
- Rename kernel_worker to user_worker and fix prefixes.
- Add better patch descriptions.
V5:
- Handle kbuild errors by building patchset against current kernel that
  has all deps merged. Also add patch to remove create_io_thread code as
  it's not used anymore.
- Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
  case added in 5.16-rc1.
- Add PF_USER_WORKER flag so we can check it later after the initial
  thread creation for the wake up, vm and singal cses.
- Added patch to auto reap the worker thread.
V4:
- Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
- Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
  added the new kernel worker functions.
- Fixed extra "i" issue.
- Added PF_USER_WORKER flag and added check that kernel_worker_start users
  had that flag set. Also dropped patches that passed worker flags to
  copy_thread and replaced with PF_USER_WORKER check.
V3:
- Add parentheses in p->flag and work_flags check in copy_thread.
- Fix check in arm/arm64 which was doing the reverse of other archs
  where it did likely(!flags) instead of unlikely(flags).
V2:
- Rename kernel_copy_process to kernel_worker.
- Instead of exporting functions, make kernel_worker() a proper
  function/API that does common work for the caller.
- Instead of adding new fields to kernel_clone_args for each option
  make it flag based similar to CLONE_*.
- Drop unused completion struct in vhost.
- Fix compile warnings by merging vhost cgroup cleanup patch and
  vhost conversion patch.



