Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56355E94A2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiIYREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiIYREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:04:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0511158;
        Sun, 25 Sep 2022 10:04:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9QMOf025029;
        Sun, 25 Sep 2022 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mCcVrLxfR91jprrCtDDqCHuA2Uo2Y8mv6WmP0foXPKk=;
 b=a1K+75Q73O73TiKX2H9bcSS537+WaWk0UZH+n14lVIYi4QQPjdlwoD48Z4UxEstPEAiT
 PDNntiYI5BEwWb5k3HyZpY0b2x3z9q2pZXo9kZd1CjEqMQN0Pc3JqVdkPFrcA1tiDul/
 JkeTbL559HOm6OXMfhgFKtINqi1N3FLLNSMqsmw3rCwAgBixIZlfUHYTRgDDrLsN9aZI
 j4UsSlPibQ8RKKQ5SIxizO9A/5L9fNw9UZcbyJASqy6mAubCheKfpd1W1GnJeqYMxlOZ
 N2HzC8VK/v+TyK0nwLyDHf1n+50a+nRoLGUTJoQ27k3dCE46bvNQyG4w1nzGzXZCM585 gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrw9xmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:04:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCAepM002790;
        Sun, 25 Sep 2022 17:04:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtprskf58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhdkOxKRLduNbz4dF7aPNv4z3brwCbAkLbnZE6541k0nd7NKGFYxNSvH0cAs4IU6ims0b4/M2JiZZroCHwS1iVsAcF9J3XDS/E7zPMUXs2NSicsXLn6gbV+oKwhFWb3McZlmFlOVc+F/3drlrnJ7WNjv+li0/ZJfSnZ3xgOsIcP0rBZh+d9B2G7WR6HCDeC4janLMNTbxltidpaxUeitfB+B0i/BMFF29SSEPvipdTdfMWi1onReQnqCTKVng3yH+GJKWvG1Ee5X4YpkCo/yqJ9Vhkp46VbXye+k0jhilAHWb2yE0mQzhGzyTL/H27H88l/W7YQFxpBZUzPz6X2gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCcVrLxfR91jprrCtDDqCHuA2Uo2Y8mv6WmP0foXPKk=;
 b=WvVTFzp9D6QkexA4fW/kGDAv+2l3NQk3UYVPJ0SFqKZ8zfgE+zrRgd63oh4rVEzviw+KZ6tE4+YTkFMbYzXfUXI1AteJL/XJhNk04Yj9RYRNMDDB5E+sxH/yQo8DMdcnDTWUdtK/vxZrucl+NFCW/7RzS1+OCeByVj6kNO5pRfQ6uhbzr7ku3zE+XBMrRp4zHLTbcoMcGrOKjDi8hke7ppaIR+GY8MLkeN6HK90M0tgyq3dX3E8EGQtoJFYN+PzUejx9Y6ZsmCLfHWmSQ2Ii++t63tZgNeRRUcxexvmcZgpIZK5hJRPUSN2l+6lq9aausPoEXfprj3d1utBqy6/yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCcVrLxfR91jprrCtDDqCHuA2Uo2Y8mv6WmP0foXPKk=;
 b=YPpZOfRXrJHbz/eFctqZJzfmSMaz7eMJdXt79tslE72nxteF+2uAdEmXHuWt8NXMjs4b04YN3NnBbH54rAJ2YG2XiRW9pWwHqJCegkO6ixXN4qyPYyRQZALdiWWnfRXV0l7VH0e6reFqRSx4anqMouCcGpBUswiEF0YmZT0HB00=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 17:04:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 17:04:36 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: hptiop: Replace one-element array with
 flexible-array member in struct hpt_iop_request_ioctl_command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7v3qtbd.fsf@ca-mkp.ca.oracle.com>
References: <YyyUvuId7dAZadej@work>
Date:   Sun, 25 Sep 2022 13:04:34 -0400
In-Reply-To: <YyyUvuId7dAZadej@work> (Gustavo A. R. Silva's message of "Thu,
        22 Sep 2022 12:00:46 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: f12b9573-9992-45b8-f3c4-08da9f1806a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blokFd3BJFmfjiwdB9aAac1XtJCi8G0s5hS55QRPQcaTH1ApQH+xwXxszdEKpTcEvkgDiQYYuo/O4a3ROTzNAIMhBjrrhKIlfeHyMh0RmcxQPm4Of0ffblKAZfYsC8zruWQgUVXs8NMUynnID6b2hM0At03Q1KFO5ue3n85z0EN79L4PD3nfqNdBMG4DbQkf5J/nwlMjpO2H4PXZfLSZRVzk4fGBcsv9GhBCaGmjhI1YjmEMaBzglAsZIVaWhMFesrjnfbYkPko7rTFBZB8cQN+bAY8A/rp1tlXzcbj4ZfA6YFqN/2VDKvcRtsyIhO/DGM+jJ2iNdX8EOeWJvnfUeWGAfMc7Sa5XkhuMU9cRtyHEYezwuwMZVoYvOJbxMjSBUwzqEZWYLz8lxVIdzlu/YsCYxU3ZFtEvatVFELGdjR8r/q/TLQRhhNMwlr4OOXvgU+bfnaGf0EH5982Z3xF9XNG6sHjo0CmBxIHREP8MoRPPE1e6T9FPbMSIZATqsqL1dXyIw5ax2roaHb0HWG17jhxio3Iv+rqA4UwtitgLkn7ocb3TmOcu7n1X5ziUywmNZ7T0e4AA09te0hSdbXJymb4xHLOAnzHHJUysy+u8uhbU/qJdz8ehVS+HQkBqulkpJFfpNBB2ulWYpX/jRpC649PWdOWr6QnXhwMUaYaszq4Yv5xDTM4gvRM4hd0A5bFInR1D5RwWcw+f9a6T/3HWlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(54906003)(6916009)(38100700002)(316002)(5660300002)(2906002)(6512007)(8936002)(86362001)(26005)(186003)(4326008)(41300700001)(8676002)(66556008)(66946007)(66476007)(6506007)(36916002)(6486002)(558084003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6UV32sANoFEOT9Sb/d2n8D7IFNvAZhwfii91lNgK1RxNWzs33ilWTe2C3tT6?=
 =?us-ascii?Q?GdmfjTEiP+kR7W97J1uSzOdXlBAsy7XpaB/SWVBN9VRk/a8OAQugPWz2XWbi?=
 =?us-ascii?Q?95P7+VkOpsjPrDEoslzvr3bkyDejczXU+xnTyTJsp8leW2dRJk1CoK9cxuPv?=
 =?us-ascii?Q?EpGdnUNHhWup8Gy4XdlySuCPySQ9TKd+XlB4fN37yaM1doCI4w6oT9Ji7KXV?=
 =?us-ascii?Q?K6vMa1K+YVPDoPgiiOkYVa5iv6eXKPldLRo3JvMTyHRkkZDEPtJqrEP/EKjS?=
 =?us-ascii?Q?11gfETrC92cDKR9cfLCzm+WmHgJMOaQ2gI+1+CbcZvLQRh6a/hctlFgdp19l?=
 =?us-ascii?Q?fdvNnQzc6vNe5NshEuDOdWoVah0//F+/1cMALpx1wGfxttOYmySOjWpnb8Qf?=
 =?us-ascii?Q?vmz2WfEZhoPgRNok6MDzUg/1/MqmH5utYIipwV2lp5Q7g+R+FtIWzm76QDcA?=
 =?us-ascii?Q?XnMDjBWYjw3DfQWPBMNImIqbf0G3GJuiClb5vPKLYzmTJ5ghNMSUyhq7h1hg?=
 =?us-ascii?Q?jhK4bVjRsuiyq2Vstz7hte88KnziFwTBV+6uy897FejeZDUTAKSx3/HNMvKi?=
 =?us-ascii?Q?C1lEUq28jh8hzhauQVk8MktZdbMGiAlKr2O83Ui2foCacww+sSxnNLMRUyeN?=
 =?us-ascii?Q?Xx1hXpA9XdG/bfphLmzoaKKFAV0FQVbmlknKntwP+u33BerrlHRG/Q39hHXL?=
 =?us-ascii?Q?EKJc0zVcFekb4hfMJ6r+6xNb4ntfU+amdHW1qnEmCRj6DQSI9QM0uGJ7KXWD?=
 =?us-ascii?Q?LdP8BkEeAtdtcwK3Tj27WDcKolas8iI0kSHY3TZPppurQOch244n+kB5XbB2?=
 =?us-ascii?Q?xrJfLLw9yzcGSZuEyXqL1Yg3XBOAXz8FNdU4hzk7ioDkXLCDA4RegsnBNX74?=
 =?us-ascii?Q?IFW+pLqeIo4HDF8xNJWcmXvrAVQGD+9g1cRiUBquj5qTQQEQt1qqlmSu5byK?=
 =?us-ascii?Q?SUowjNMObIttuncc+FTS46MDbEDxDF8qFRh9wa7Hm9kAMsmH2CXBYMP1pPOn?=
 =?us-ascii?Q?+j09JxVfshXSepuSHhFqWe9cikqvZIA7nSSBpur07zPFGgHDgPU1AMFbJXfK?=
 =?us-ascii?Q?XbpCMGoFBZKxt9QKveiIMllgQwizI+Wip8esR8jyCQOI3q5wQU9QIAl0U0yp?=
 =?us-ascii?Q?FX9rYjWeRWP6fBZldCJomZsViv6Mz1RRnFCTXFpp0BMvQLGRiR6QZU+QpQGC?=
 =?us-ascii?Q?YMmeLXDeJQHV6Hh85wCBfMB9myT3/GQ3fchM5/k4tjkkrIxMRMHpuSmDAGta?=
 =?us-ascii?Q?gEUyK8VXUqTyrbgTvq4MYwiQ7pdYFaDj2sTpQG6V6krm0mW/sNupRcmr4JXJ?=
 =?us-ascii?Q?0OBBFpbtZ4zMNaWe2vs+sEVtwkEKn/pARXV88P+0yk6HI94RCyiMP922kNO1?=
 =?us-ascii?Q?hKfk0P9enktcraPezlGiSkYXQzESWqRhFdwmUQQ+fphyP4nmmCikkHw7VXHV?=
 =?us-ascii?Q?GAgjcm6kzBkQ1sGPA/btYUntJVEDlRgUJbpacVOztfUMn77LFAmGp6egbFYD?=
 =?us-ascii?Q?jaUMhBosqHzSoM/0l3COWzdbgBBq2ZvkXjR63dE+A+K4s+DO7zE6antbSwqe?=
 =?us-ascii?Q?Fbd9SwD8rFaSoXDtlZYDBrIujV9rSPlEfO9fWV84RWBGFyBuDDLJDscM1gFU?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12b9573-9992-45b8-f3c4-08da9f1806a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 17:04:36.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EPCQVS3yJG2mEMKhXA5dLO5gaUW9Srb64UcIL6j5y0Ko5hi8J1Figh/qdcaLxnc7vlXS1u9VCQf8lRQcC8noNy/EyhKEUs44cbPt2Z+kqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=985 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250125
X-Proofpoint-ORIG-GUID: DcrSg5zpGMK8UjRQ4rx4OJIYUFk2Kgei
X-Proofpoint-GUID: DcrSg5zpGMK8UjRQ4rx4OJIYUFk2Kgei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct hpt_iop_request_ioctl_command.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
