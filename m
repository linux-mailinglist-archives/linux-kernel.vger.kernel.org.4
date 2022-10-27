Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8A60EDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiJ0CXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiJ0CXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:23:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56913E09FE;
        Wed, 26 Oct 2022 19:23:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM208v014710;
        Thu, 27 Oct 2022 02:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Fs34h5UwZnK+3ISeW6LVqTaN3OoQsC5Ocgey2c/sss8=;
 b=3WX2ltSbU02V77etG71XLXkH0t1afk0GbLfAwwW3LaMCE5zJ17cnOPvEMnPI0ZctYviZ
 SU09sgzg+H2CkbOQppj8jJ/XgfwYNoy9sb6+9OTHiCZ1GjyZvzhByuteDGxV+hxPbdri
 dwoKersUHGLlxTITSAzRcjBoHK63NDgf3t74PT3o1LQYJ+QTVXsE0RY3Hl9CihWkgTKm
 lRw5+t8IBEAXvxW0cGVpkuGRKzPb2SiANzMgPDor2Pbrm4Q8JgizvYGO9wuyeLJOpt4r
 tEExMA1K0KE5E+LCYGQQU97e1fush6WR+bfRaoNkoan6nvqfjPBDlkw5uh4LXZw7j7UZ MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays0ruv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:23:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM76XJ017431;
        Thu, 27 Oct 2022 02:23:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg0p3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBmadEldKF2ApMZ6aabHPg6rVrr7RiE0LPNIX50vuH/EQu7wZz0qlhFVeAGQV1oPJeEL5f4kzIL6MKFQrOGynrWCS1wPuSS4U8Su54iVUZtwNXmqptE5miT0Cs7WBir0DgDuuGB5IO6e/pn9Y8U4bWvPRLmO3xqJCIMjQShW+rwm8OAbKsbH9sfo6VYXxZxTGsNthYiI8e3QW+qEez0jAb4jP7ZvWXySF0ajJOVkF310gKdJ9xL0mgc1ec3zg5lfunaqqUfgmgmsDPaFHeLxE159QfAHQWzhYROUH9AZQkN7O9kjbc15ihAAhXIN6jizfRM1TcGZ9MtgfZfhXP/Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs34h5UwZnK+3ISeW6LVqTaN3OoQsC5Ocgey2c/sss8=;
 b=Uvqy5B16TrOAqqWMKRZemM2giwrmH9sVeNuAdX9U3l5XSIQuVFhdj4FdIOPZKdy08sm1o+RpU++euUOKgaAw/0fRreUgNGTtxoke5csolH/RQhL+AUalt9n7CmAaFFz4JiCUWjsHaBJhIj6ypt5sA61iFxiq5Ov67SM58Hjn5Fy4+ODPuwf2JwLHq1obER7ZiVbV9qJSIzSa1sE7oy8YDtQlTkeVAETskTwKU373bqmyaCFm7R+4ykhIZQv72eh9Fqod+kZ8YoxvZOt+EcgD1IbW2/4tBV2nFDn1u0Wl1MQaTNJXyWMOzkir/01WFOWoSodg2OseHLNs7odeITkmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs34h5UwZnK+3ISeW6LVqTaN3OoQsC5Ocgey2c/sss8=;
 b=qM+GP6Cb1FeNk+a8ZiecT7irVmfK/V+jf08R9+CUFKSZcmeGA3ySTQKP6tFgGuWNMsoPLuqE+KmbDlCfsgPO9RFrxGvJMh5jT3iw0QMsbyOrG4sevF16LnfuFQ4lZoAyerxv9YRqXtxkzht5L4kVGHgIYjwDnjSgv43/ho8neCw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 02:23:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:23:30 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] scsi: pm8001: Drop !task check in pm8001_abort_task()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilk6romi.fsf@ca-mkp.ca.oracle.com>
References: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
Date:   Wed, 26 Oct 2022 22:23:27 -0400
In-Reply-To: <1666781764-123090-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 26 Oct 2022 18:56:04 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: b4893c57-49f1-435e-d299-08dab7c23ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRD50M36h2WZRTIOC/czjDalm4CL0kwxzeqTOE372TY4aXqhg7KqouNJRv1tSDPcg5LRSon0FzWftZXsqmr+vimKVIP/mtsXDLykv6FMJFUapKTqKC4UVmFC5l2p68CtYiCr2OPgl3PVD0nR4Ue3ZjCX3+Y8QUKiHlzHewIudhavqncNNrIKr1ZWRlwxMQ+VOhFfXBQ+KeQcMnm4RIYqTgmkkhma9M2CJksAXSE+JWW9H5VTIAa0Pa6OnWEP0Q2QO08VKwNzWBHdMyy3z/Sr4PiZNySJ0/PUtsBccfYP/U0nHYWMtini00XRjAjZkgDjIQIr9tqRrSBilK2rJYjvk+wRjuzZIfxlFgsv+dVRpJcJiujAiUWBT6iVEXVaGgXLpjJ2NsF54oAu2qDZK+qoUiH9tvgDPnO8idzvech7sRu/dSWDH2nA40UY0Kxkr8Yz6X+bNszAT7pGMD7UJumGG4FYaUHsNE0/LrmxY5dWZc3xYdJVXHqMeIwss2MeA4eC+5rxoFXpaHOYs86A7kZG2ydWp0S+6SPzkntx1S0hOqvSlfW/qGMyootO3x8xJPyrxeMXyqGBGc15X4VigRwOryvdgBMWrK3ah3Idjofg8dOJVWMxHUZgBKD3YuWlSHVPJQgnpPfiQheutUKJi7v7S6QSCZRW05e7c8kpKW2L3rHA9XsYmVaCcWiCGTEmX5mPLdSJY0SRv3lsx8KSGmirkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(6506007)(6916009)(316002)(54906003)(4326008)(6512007)(5660300002)(26005)(86362001)(66476007)(4744005)(2906002)(66946007)(8676002)(41300700001)(66556008)(8936002)(6666004)(478600001)(6486002)(36916002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?na3zeQpwYY52SEC9UJUYC8MAUbBs1XzmM1BMDzLeSLQ97VUS/xAZZvvgNGvx?=
 =?us-ascii?Q?njKzZQ2ID0/OAmmXu6BXIXZuiJuNwVDcnuLdg/sVNhImkQZMI5rx4qHeXI1q?=
 =?us-ascii?Q?DlJKrmwsiMyClPzloGlX5qHBCE2jQF9DHavsEG2+pzosKwWQ10058ISX0e6h?=
 =?us-ascii?Q?I7yMW2mAOZHybBs9Zlu84Exah/ePKSaxF4c6MwRFdxj1fWgMHJzZr5WIbSKu?=
 =?us-ascii?Q?Q9XpNyk7SCPusoKOwl49a4BqfJzwlxqn8NmmrQsxXI+X1COzWxaetdyjKMx6?=
 =?us-ascii?Q?I/TRhfu3s2KdIY7NiS6Ccoajhis+aPb0R0awEgEOJfO8WiIlW33KmGNBO9o9?=
 =?us-ascii?Q?0LiARCySgX1Ohjxb0VZN/yDNwxgae6L1nqpolkqZMkElPbs4SUCmBdSHMEVx?=
 =?us-ascii?Q?iGqacXjnVhZDd/j5Op55mEiobZaBEr0SyM1ydk/txu0H6KyrMUY78dHhp+At?=
 =?us-ascii?Q?FCnzWYg9xLhFab+aXotyhU+y8fcIS5OEDFqlmbUFueBnkfEGWFANdd3PMn6E?=
 =?us-ascii?Q?tOqXgGc3HvckU3rVzIyl4OC1MW0QCmaTS9z6xK8Gc0zflfmgkcFmbvqsoDa3?=
 =?us-ascii?Q?oxM4aFhuTWB8xXua95J+DDpdoTCilNPUZ4dMyVoOk/dHkjYAYlDDCa6VQSOC?=
 =?us-ascii?Q?k/iNrNa4CkMVIbdarD4TfgC+7FjwuLGJyfQJp+W9M4UUUG1+YrUcigSdprvj?=
 =?us-ascii?Q?k4ZraJEZQXs6F3OhIpz6lKTDk1ngD/My15/EcaRcv5L98rbsxnp4QcXbMHE2?=
 =?us-ascii?Q?SdhNEJjxHeVOfEGKw71iHoo8qa1YFqJNL/PrWkThiI08/MgUfbJRRaI1990v?=
 =?us-ascii?Q?e2HyGViGs8CWcL1bv9dxhRtklKtdqy0rqDKxBqJHMVCIEjOd7lmGNwovXVFe?=
 =?us-ascii?Q?hmG1v6W0ZSVmH6RKKRNShdwLvzzaq9R8azkU1ChRM6VcenAt0V1mgNtfnxE4?=
 =?us-ascii?Q?I187ZZ+dPRWiDmr6WhLRgF+fyzoRJyrAYamTxND3hyPNbzyW7ijXWNOeC3SF?=
 =?us-ascii?Q?xNBYQzzoGHNZceioWhkVyYo2X5EgqpXTWgliLBOJQ440xVfFi6X5AEI7vYWg?=
 =?us-ascii?Q?7j3dVmy5ZLBvub5OfqQlTLUFi6UoR+NBLV9Xtm1NYd+w7xUj6ZM2uF12de3h?=
 =?us-ascii?Q?KaV/Sum4NZDPw9CrO2Qr/Fex2tTuGGJn7Nsi2Dz8sL7pf7sVH2DWtF/YM8zO?=
 =?us-ascii?Q?uB8BTnNty1urOJFL1ym08xJ2b/F6wTgczcVC3LxzPD3Kzd62EtBBjYTaD+vw?=
 =?us-ascii?Q?9h9uRU5qU3hOKNLM2ci26ibz4rAVviybbHgakhiKus7WjunMDb5Ujs5eF+d5?=
 =?us-ascii?Q?n22rOYqT8501Vn97k5Uke3lWsbnANYhb0Hkdne5vjR0RNsGBWmqxz1ol7NpF?=
 =?us-ascii?Q?SbUjWMB8/MyBq2LIr54g1COwxdX4csZgkkIWg1aDDmYIZM70dktfsN0/8ZE/?=
 =?us-ascii?Q?gaAJr44oA2GW9JRSKLS2RqErIB8LzDxSoCNhc6j/NuR2/BE0syiNzQQ3/JLe?=
 =?us-ascii?Q?NJN4dU03quYef2/fea8YLRUjgTQ73TzqtZNeAXtYa/tZ5JhSN5/mNBNPZf/3?=
 =?us-ascii?Q?j6S4jqpLQr4DxI/t8tJdE/V9gOVHzKKcZWlJsjhRYUa2Zp84U6qjcbVH07KE?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4893c57-49f1-435e-d299-08dab7c23ced
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 02:23:30.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z28ZATvrJp89hdvwxPXkJuPrChUg6XFRFKbfpvU86bsnV+m08e/n25FjgG5MjZMa9yBw5R3h77UkvCkheeadaiq+UY1QkmYRxKUTlQrqmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=780 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270012
X-Proofpoint-ORIG-GUID: -kIVUmHwHYyM_IYkm-A9iANltQSUM5aw
X-Proofpoint-GUID: -kIVUmHwHYyM_IYkm-A9iANltQSUM5aw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> In commit 0b639decf651 ("scsi: pm8001: Modify task abort handling for
> SATA task"), code was introduced to dereference "task" pointer in
> pm8001_abort_task(). However there was a pre-existing later check for
> "!task", which spooked the kernel test robot.
>
> Function pm8001_abort_task() should never be passed NULL for "task"
> pointer, so remove that check. Also remove the "unlikely" hint, as
> this is not fastpath code.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
