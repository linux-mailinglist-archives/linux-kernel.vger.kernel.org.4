Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219276C6409
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCWJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:50:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675331DBAB;
        Thu, 23 Mar 2023 02:48:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i7Aj005177;
        Thu, 23 Mar 2023 09:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=45mxMYqHSd3BwstZxZV61Lirq3i604xsUFmo++wzJH8=;
 b=BOP7vivWNeKLv0AGuqK8oKA8qZyMC6TP1mXsSY4CbVSdnodhKsX7dttdTVYhu5tVPwoI
 gDqAceIFadEtvKmR76RJfYuyz/kR5fIzGcn9B4fyVu0FwqvQ4asCUwSgtFt6aDztnqoD
 H9H0S1YyrkL5Po0Q601UKaDATjFWmn7fSnRjusPQQOn5gZT/VTEWXbyNR41N9N+hjZJ4
 Q8nuUxbWwSWTD1uapMFihLah8k/UUtiTh2FlTiv8jlMnD7YkbAon4I4BzkztnMwDOOHI
 2Il2JRYZtZo4l5idrCDxi/KOhdNfEe6SbrXH2SInuOlhDG6yzgtYuaklrxP+puVazLhq AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdu43k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:48:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cnfG017309;
        Thu, 23 Mar 2023 09:48:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmap08mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9PQ2Ezss8M2TUTdw9wcZ6+CBRMiLiqIBzOSmXq/lfXpVtCoIL0pto94AKJ4swHp7dBMGXJJP3wyIIDhcASt8R55ltdNhyEZ5Sl8P+sTJF4D79lg5jUs8KEVVgOl2og2JvaMIBf6XcoeitaxMzV5SUCf9uVdT80sMWntz2npx5z9URoMbQ9uLsq7gbytTazg67YvNgUWxQQh5vxtYd04vrNFyNzHbLrs1EE4b9e7fXC2qSwHGoP6YWn4uL1V9L3Pcnd8uBPfhgDufq3aK5oN6SVdZmFL5YvpYB6tRIhdj+4GHGKdmgQDL2XZ2iG0+J2MgsFg9o3xvgpMhhfnCDGX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45mxMYqHSd3BwstZxZV61Lirq3i604xsUFmo++wzJH8=;
 b=g6yRV2na/5RmRNJtzdd9DWW+wPWXNsRMAEG1pc0rKCb1jVxGKgxLjqsLTPEwKe3BEhk1O0Pc+k0LjmDC/MOU9d0n5iW6uY8UDXZ+8nui7GjjYx164JLkkO2gJhir+JqtnIF/pcc5EBD1K2x3jUq9eMAKkGPB2RW7MhO/Nt7nFCupt0WezKweLyeQ7GwOmJ8vRjthtZHUKPtafDhaUiO05XPq258BpLVwmYUsGfhG7buR429cRSg42XdVQrFY+mj1CGtqOVXzynFiA025X9qPcPvlIwVkNJlfhHblEwVc4MF7q5+f+Ubr9pvwFppYZP/PqI9tBPMZnkJ4hA0sS1mBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45mxMYqHSd3BwstZxZV61Lirq3i604xsUFmo++wzJH8=;
 b=i4M2Y3PRq9ev01Vtrl/NtivwHrw6NT4aej2QrPglRLKnJn+TTAc3M+VxE14iZAJfpG6qhFEegCnOOQqwni5chyll6QEBGvr2bpB/1qJwo4lb1Toc8Eg7boeOtbkWyteIIg6DpPotgkuj9sOSiVePbKyZnGRWo67ob4toesUNRGQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:12 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/11] scsi_debug: Fix shost command overloading issues
Date:   Thu, 23 Mar 2023 09:45:44 +0000
Message-Id: <20230323094555.584624-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:5:15b::38) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: e6740ad2-55d3-4adc-0b96-08db2b83704b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0mV4q7R0znJiKT+6HHIleoxhSqnYNIXFv8/DzNo7obA5L7ifT/42sakc/Nv6mD8A5KNALYAUNU0165F1mEjFZL0o9EuJdjUrkkPWi1XBKpeHokQA4mWFaNQZVzlu/Gtu9Fg+oW0EUfN3h/brSrnjpAiVKlZtqKzZfpHmFlgqUE9vCbm27cb3RogWveUzIiYV8SOP6s0JpXvIQ45jOfJXNeVxKYhj46BkPsAASm/hxDT4Of2Td2MuBDIqwxxBP/1zNotKUmVuMTsG/rCk3A2kU19zkelqLaHXl3SMhdDr5JzSaVfp1eX9azATpY34VVtnSZGRPAa4ePebfqjxZdh3TG+qlc1DcXUwtLUxv5xHKR3CrLxz3zfenEvnaYFevxnisAnMW6Sm/5zVUPtIbfm9dmJOxhrW0Atf0tQC+jSRPmfojiaow6g+B3E1JmrUjxRyqCo1VmCbV8mkvsrJLjbVlN8UPVgmjfM0GNUA2sx1/q+RlaOBk5aFypz/BpVyqlWoWkXa6tN7XA53gyLpGwhzQMxZkbNptERf2jZ8oyp2QCLNB7OV6NHsr7QcflWvg8DN0VoFnuXBnO1sVSTIlK/KPp25d+DxqYoAlMURzpuFX6SXnWVuUC0NXjCNB33mErZMJ1I6oMqYJylEUYf5x3wqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2QSmQ2qNG/FQHr0KRXE/DUoTPJoUnpS8g6Pw0AsphxH0X4MrtYZ5da7wXse?=
 =?us-ascii?Q?C9MIBBagOjU+oJqu2w0MPbGHV9zGrHvfUoSHuiffumzWASkNa5TylF+aOOyR?=
 =?us-ascii?Q?JZRiHWP+C/Yvr5HGFY80AVJPZ8Pwo15J6UAkC1IvzP5nNlNg+rM2mVV5KDKa?=
 =?us-ascii?Q?5YF+TFAY7PIJVt901do7Zu2Go2FSsrvzsGFWj8MyRXbAlQnJBc6kOEC1eKbq?=
 =?us-ascii?Q?lXi6bjkAs2xobX9BNWF/qNoxZnoijvSYJcnKZiBzO2Dk+Ib+CEkataZ5gp7p?=
 =?us-ascii?Q?2cwFXG39KEGHtq6hmygsf+na6yLQqvN8CDpYU9Fk4Wsr8fWD3el1MLCYhgI8?=
 =?us-ascii?Q?BkoFyF598xOAZfyhR30zEj2nfPPx1iY8L6GZz1SR5f9Ay1zkwjXXpSIBRked?=
 =?us-ascii?Q?dTDbByjnpedJPyNBlt+hWRLQkd7c1Fgtu354O3oMXdnqf6ZZORbwepMbaHdX?=
 =?us-ascii?Q?/czgZQN1sqpSR0gkb4dhPrSXSi2GhKxLb9uVMJ/SzdOp4kUPQLq7qqDr2NYa?=
 =?us-ascii?Q?eHbQGBns2noKPmpcyvItu56m5qOM17WR6izCwhhdW2cwymKosS4BInhrcIYL?=
 =?us-ascii?Q?5pAmxgbHP6Ky726NUrW2d4irEJbppI5x0t7/zjQHCNpJx8uUqrtpsBELrocw?=
 =?us-ascii?Q?sLKgd2y1XJo64ibgrzR6b26NNKb477ecO0BLQgvhHt33TXNI73DsFt1zKtFr?=
 =?us-ascii?Q?mbrSck7zh5Nmz1Q+QgCLWBlThD3QqJ/ZcsWNtJ/MqL7OtjM0+leHA3qCTITP?=
 =?us-ascii?Q?znB8EW2lnCYxAaL7zNvtHsIGrr7mOr0o138q8rGZHnXC8UAl0OdRgVoZHvmm?=
 =?us-ascii?Q?wHg04WOskwI4x+ggK/f+tSt6H9VTZdcv+yD1X3xsFozp8Qcnh6L5248dXNLv?=
 =?us-ascii?Q?NI3mm1ad1aJrG9zLbm/oqT02YTZDTnbJr3YWYrU+h7vcEAlE3D61p9Hs19T5?=
 =?us-ascii?Q?KsDvimXdxbRsvX6um6Fbg5un018IsLJnEABemliI1RQW2uY0zf+fXbATqEBu?=
 =?us-ascii?Q?Roi2ZwO5DaNI2Vtljxc2c4e5CiLcCvbyylC7gBf/JUELTxmhObqZIT+s5icW?=
 =?us-ascii?Q?HWGGhLa+OLv468C8L5rCH/Q97dmkRYvCZya/wKMfz6dkVZOgYppAfsCdcGsZ?=
 =?us-ascii?Q?lxGAIMb4/fHjbdVXJm2ICPCBfSYtcATuMAqEYqlYKZABfBIggD1Ot7P42Nzj?=
 =?us-ascii?Q?sGYHlgWovOmgmj39j6+PEG1vPHKDQibzCykJ2kMdSU9x88vFVnttTyjbS/fB?=
 =?us-ascii?Q?PL2V5hic12eD4oawTf7IUwKab0IiMXgNyIFqIRavw0Nt+ZSzkmjmIlXeM63I?=
 =?us-ascii?Q?axIPZnUZz2s4TXt9k9A50KYeQXJTS2yp4B642uiHEdhaFV1wvRqPifC61qo5?=
 =?us-ascii?Q?bNwpNV88iH01ta9R2YwTaRc4oel+rKfLgQR89kI3UJJZIpzaHzsAbNumKAcg?=
 =?us-ascii?Q?vaOihFK70g54qwRWYIZf45nAyuVmTt7D1TmcyiSGxzDkczqOgBT5UaeEsrmv?=
 =?us-ascii?Q?bJoDSo27C0AxwmHTt+FzNHMvLe083dX7M0gpBSXERAC+PHOfucfa2AQtY0w+?=
 =?us-ascii?Q?zI6EN1FAGr/3ko2r3AoCOe7c8UxO3Ru9uv5C2jOVSdgTK6dM3g9Nx9eWnBKz?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ll/zWgX+SBuZdGPIa6criX/xLlrQyn+jY6PgiOpWZzw0VbsXsfdJL9D2Ir6RJXdplvd1fvfTChltmP7HqTqFbPYjQyyx8lhw9rHrxvDVbJMigjX5sqXKQetjcmprRjSKTId37+DoWxvpJEKtpid67TkasqRu/IelBcS84P7mowB10N+EAxBNgddloi9bbA4WFplCnb2DFDHEBAFo6evsoIl7G5a5zUFzoVLIKHs4GkcjhOXty+RLNMfdytXkDgSWojD6Nb5o5DWGjYggtXzpHn3PM8Ec3WH0l2kHsThzdKAaQh2qK3dLJJJdahZmUct6PkOBCCV/DA2hzG8TqmDBPWXZljC1E8fUlrrZTpw3Us7k8fUvKAPhIPgk1xn2MgB2AE+H/ZyIhsrkrufS4ptzZicmxLIbmAawSU7NoYFpq8ohaGkk2e5HH6t2KO0W1BbkC6IMPhOI6KMhkuJcyaONUD5m3EicVjaPKQXaFlgnXSu37iYRltRbCG8yB5n3X3Vjmr1gZAVWMENzf9+vWNYWPYNef3in0xHWwXPLepr/iMM8EmcIDijkAIa/fxyT7FP6xD0bZhCMoWOTN6nxBLm062DJTws+gpzsZTmfYNldQw4Bi3J5H2SehioRhNNA2Q+u2rj6yLVXD1dRQNsbS+aRZ1RAGIX+smOJM9ycTTHzQL5Aa1h7AXLa9O1TSh0Q3Db4IvT5Xt4x580DgvUtMXNKmHQEqOktteW0XGx6GaeUvbaPusAk/YiNRzbztsBnZRSYkYbdzKQyGKEyLqO1gyZfYmFJ/oa3L8Lg36RVFkqzMtn9b4Bb6iAuf53hshy7NCYGLeg/nDzMtEWgGQSWYijZ6/pfXo/md9oKQnvoTXvamFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6740ad2-55d3-4adc-0b96-08db2b83704b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:12.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH/d4zOr0EQIL1i22v6EzDX918aVMkzwctKndJYjMA2J8hCfSivzdbucRX6LcxWh3kq1u3/yY3QJeHA2qTRddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=989 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230073
X-Proofpoint-GUID: wSFCdA5mRge04bRcZhEzB9FMCLUdBFLN
X-Proofpoint-ORIG-GUID: wSFCdA5mRge04bRcZhEzB9FMCLUdBFLN
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easy to get scsi_debug to error on throughput testing when we have
multiple shosts:

$ lsscsi
[7:0:0:0]       disk    Linux   scsi_debug      0191
[0:0:0:0]       disk    Linux   scsi_debug      0191

$ fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read --bs=4k --iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg --eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
jpg: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
...
fio-3.28
Starting 40 processes
[   27.521809] hrtimer: interrupt took 33067 ns
[   27.904660] sd 7:0:0:0: [sdb] tag#171 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
[   27.904660] sd 0:0:0:0: [sda] tag#58 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
fio: io_u error [   27.904667] sd 0:0:0:0: [sda] tag#58 CDB: Read(10) 28 00 00 00 27 00 00 01 18 00
on file /dev/sda[   27.904670] sd 0:0:0:0: [sda] tag#62 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s

The issue is related to how the driver manages submit queues and tags. A
single array of submit queues - sdebug_q_arr - with its own set of tags is
shared among all shosts. As such, for occasions when we have more than one
host it is possible to overload the submit queues and run out of tags.

Another separate issue that we may reduce the shost submit queue depth,
sdebug_max_queue, dynamically causing the shost to be overloaded. How many
IOs which the shost may be sent is fixed at can_queue at init time, which
is the same initial value for sdebug_max_queue. So reducing
sdebug_max_queue means that the shost may be sent more IOs than it is
configured to handle, causing overloading.

This series removes the scsi_debug submit queue concept and uses
pre-existing APIs to manage and examine tags, like scsi_block_requests()
and blk_mq_tagset_busy_iter(). Using standard APIs makes the driver more
maintainable and extensible in future.

A restriction is also adedd to allow sdebug_max_queue only be modified
when no shosts are present, i.e. we need to remove shosts, modify
sdebug_max_queue, and then re-add the shosts. 

Differences to v1:
- Add patch to fix sdev queue full test
- Add restriction to allow sdebug_max_queue only be modified for no shosts

John Garry (11):
  scsi: scsi_debug: Fix check for sdev queue full
  scsi: scsi_debug: Don't iter all shosts in
    clear_luns_changed_on_target()
  scsi: scsi_debug: Change shost list lock to a mutex
  scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
  scsi: scsi_debug: Use scsi_block_requests() to block queues
  scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in
    sdebug_blk_mq_poll()
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
  scsi: scsi_debug: Use scsi_host_busy() in delay_store() and
    ndelay_store()
  scsi: scsi_debug: Only allow sdebug_max_queue be modified when no
    shosts
  scsi: scsi_debug: Drop sdebug_queue

 drivers/scsi/scsi_debug.c | 782 ++++++++++++++++++--------------------
 1 file changed, 360 insertions(+), 422 deletions(-)

-- 
2.35.3

