Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47A6E0415
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDMC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:26:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C33C27
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:26:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJT7k1005168;
        Thu, 13 Apr 2023 02:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZdNxxI57znv3g3RNME6qwT2V7Kii3UGuHgRiNUe3LY4=;
 b=BGelZtctjrMt4nuumB9qLxenkmNlsErv/yWSG5VwqSTSIQabibLjroGbjVW7TqcZG/ni
 g3edpJB5t2mIqmYlMIWv4zUhClm+eGy7XvuSt+49Jdc9Do5RGyNhlMg3YgEz4wC7aJRy
 Tf+Kpy5mBJFisYqh1Lp6nQmGkM7YzpKo7Am3wjBTPCAfOFTR7FtWQqDWzXCJhKNdzQim
 Zumj8JptYd08pcnoToHikqKQ5H9kuUOfbvBs7Gzo58jtySc3mEPwhn4G65nkSyA7hG0P
 hQuKtfGGWWN/r9jRddE9+ZAJBjwZ5Led9HjkUoVbQ5lYCiCjOw/Jd9I8xzHHz9xN8B9r DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b31tvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 02:26:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CNFRlN025253;
        Thu, 13 Apr 2023 02:26:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdrsea5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 02:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzNR4/TZ1GjV/hGjj1vCvXtZqQupNUzxcIcGC3RbfMwNGAJ5ELak03Y/mAtlhbILmrbyoKORhYm1fwsQs1tm38F0MiUMGeBbGp92dfevRCLfn0eP3T48G6iYJ4O1XoExIdJbiNLrME03L5YjPjerm47biORQQyxI09RkKrFtCVz9fbInQQpdeWS0nLjubncBca1bp1nOBpz0/meKbDjcpHVoGhRH8H5Jna9V06PJRPfrGxr+45+QQFaBUJY0yKsZxV/rAeVWAZ53RyKfqqVdxZ2JXHfqfPQFLniTniy9Sk7rCHQUD0zOsdaga3Q69P3+vCvi24kXHL4D85TTT0mG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdNxxI57znv3g3RNME6qwT2V7Kii3UGuHgRiNUe3LY4=;
 b=acVRddDaQxyR7xTiLWVvXzvNg1QO7tVn4Zr0HdzXMYCWMZ28UN3RS2k6B08rDJ+WwHSXhQ8PW5lKSd5yU3DJIetzqWQhOGJ6PPoHXdYzguOecuZlC9TpSr3Y5AZ/n+oGMxaVQCEAhf9ihOTJweZ42mB22xAYMgeMRjYDguJ8PyXajixG6taimPdTYZIwqIHwPzvzkNr88DStJz5evFc+YEvVVcqprep/LrWGAKefJRKqjtBQ4WyjxZstqD2TmS2UtR2RXh/j4SKETrVOdZRbcTEuoG2JWX38Qi/M0bl8i0oOrsa1kiqEKILrHZXyg48J/Ru7/Re1R6rvWTEHBI0Zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdNxxI57znv3g3RNME6qwT2V7Kii3UGuHgRiNUe3LY4=;
 b=EN7Et8/fhC5r7NqZqMfvcrAtPxtCDINWhyDPufu9Xot68gCw8AesTiL1rneL8p3Fhyda8dRNzcTG7INlzn2L8wWQegzv0QhIFbgMG3FlEIkzfI4HW+eOzZNBPtXEZPXElgDMmQEEMbOAGBS1Y2itKjpj24FcUQDLupipHh9JBzs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Thu, 13 Apr
 2023 02:26:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 02:26:07 +0000
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: (2) (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cuga57p.fsf@ca-mkp.ca.oracle.com>
References: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
        <20230412065736.GB20550@lst.de>
        <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
        <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
        <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p3>
        <20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c@epcms2p3>
Date:   Wed, 12 Apr 2023 22:26:04 -0400
In-Reply-To: <20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c@epcms2p3>
        (Jinyoung CHOI's message of "Thu, 13 Apr 2023 11:19:31 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: a867b3ad-6fd3-4bb0-8e5b-08db3bc66fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKkhHMsH2kgiWYEgh5EpFNCp6c5XKLx8Yar7NkTjtkOg4ooI8EZq06jX7A1VI1GT3dPugp40ZDLB+7fXic6jYzLn4SBlTY5qw0TwuIpFUk3vIB/qacXvnPSRLRv5c1xANSTmc6mStpYK3UHW3FcOPexEZbUl1PLUZWF7oHi5/T/e6IuG2bk2LtuusK5g0PfmttL6vi52LZnv0YsNiCF8OidWT3jCJd9MxGjyfMDf6dUBGNG9gB+0ItkSUcqGtfJhrsBemjJF2v8WxJrdkEwmqJ3sTOfXPFNhl9IlIz/AU2LdJHYfNI5gWjj3gv7RQ7LegoZ9If2dyO5JlL1o3kwycZQgs6KCbw9rn5dUJfzu6IZMFirbMP8qfUswHVRXeVmPGsKjunuTm2kOc5aDe2KXgl9c0rw9wm4lPNO9QqgTygRdOE7rGOdelmIWUIVvLvMW2znFgW3U1SF/ZBZfkehzbTjRXZsbkj4JgYoUdxCpjOipcLjKq0XrF2JOjrk2yh90/l/ekxglQjD5js5jakkLZTd/BwZOkrcj7WFR5T5xfHrEHWaDGy00nKW22a0+qsjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(6666004)(478600001)(36916002)(38100700002)(86362001)(2906002)(4744005)(6486002)(316002)(26005)(5660300002)(6506007)(186003)(6512007)(8676002)(66476007)(41300700001)(4326008)(6916009)(8936002)(54906003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZAPGopFm9BFgL5192Vs4tbGcEljNhIGdMIyaRc/8heRVVShth6hiUFs8aoS?=
 =?us-ascii?Q?sRvnCqVp8XiKYF0+LSxwQGxjsZ21f9zfA9Z7qlzzHBYUCxvRKkJSgnvmwGw5?=
 =?us-ascii?Q?4+7ebgKracNHJVtel+SU226hbEixF8FbEJWdzcEFu+sOgcafnL5YkRlrFo0o?=
 =?us-ascii?Q?0OPnzngXyDTbNZ4FvnMfLLIMrZjEHRTrjnRbImj9wDHQJIMzVUtOMEbwy+g9?=
 =?us-ascii?Q?JsDNMOrPvhtf/Sc+iZOtzXtiiwhhxFJn5cgTejBLuMeDTS+NUUaysD21Tmeu?=
 =?us-ascii?Q?E699MHgsy0DfjU7ACl/Bbe6+CLAiDo/NXL20DWdfOCWr1GgHV7DQKfwap3lb?=
 =?us-ascii?Q?yH8xv8DNk/MOJCEG8nN6NVp5gLvSxF6+BnnskWq1EHhMZJih9JBci/3Y3vPj?=
 =?us-ascii?Q?f1tVN5sRUgrrLWWc+1dNiQyOXOaBwpIBJOxDTDB+MyhvSEdxNXvoEgS07+hn?=
 =?us-ascii?Q?rhdg9oiwa0Z+trYlxUJN188W/T/EltxbHEBmNzdWKw/KtqMu8s0+65LoVq/d?=
 =?us-ascii?Q?Pz1obXodLlh71ZjaC9CQ/sqF9UGthAauhFe6IOC5yI+QdPKbuEyr8MOmPh/E?=
 =?us-ascii?Q?Jvp3aEjO9cEhsxJS/sGZ02Lbu3u90SFfENwWv37sXTcX9L4FRrMyajT9AbR1?=
 =?us-ascii?Q?kwcvBS6WiTDtKiNL/W+MR0ZjYvJYIInXB2OJdljKm3sq2ym3CKXmmQxZHFT5?=
 =?us-ascii?Q?pzwez6usIZSobP2zShSMNYvkYkNppzC85uXUHly0rFNWpieVyLbh/KKvAqMl?=
 =?us-ascii?Q?Zxvt31//+Td7yG5j0cEzhLjRpA2Ybcp9r/a2Bn127yl/HI9UPnHFChl9BfYS?=
 =?us-ascii?Q?w5E/9MAELZytCIE8ZINu83wk4ne0VgbVYqMle/KIUz1iOl4JNbyHQV91wt36?=
 =?us-ascii?Q?zRC5BWnphDzd/z5ZijX/P/tMT0+8daS9As3G39Ci87fpxpkU9O9WN1qJ35uC?=
 =?us-ascii?Q?aKxgdfQgPMlETJSI5WeYwVA2GRu7BCNyEvzVW2O8Kc+/clgxPNpgN8gbacsk?=
 =?us-ascii?Q?+tCfpeVhY7kgJqLCkVKGWwAOoioKFSxIXWa7JKSsU/lz1RehJdqjbQMOyC84?=
 =?us-ascii?Q?xC98WzFPHiTArFkyF2WuOb9lmUNKS/jSlhZbaLE7TizJsK+aOxi5qR14DvNB?=
 =?us-ascii?Q?NrW2M8wjGcJ0YbZk1WETVaewPZ9qV+/uVlRegqrjpoCG4WvMnHS08fcSfIGU?=
 =?us-ascii?Q?pq+A0vBxQ6lOIoTJDqfg2KrC/whgwl1uMg6Ge0Q57iwlcJMokWdK+6MnpjGM?=
 =?us-ascii?Q?sobpb+BpiB2SnzLrimby5qyyzQ9/LQ4SNWspSDkrWCaa4EpR84aFd/sdAP+X?=
 =?us-ascii?Q?M0Ds/a5DJdGndyEzAzZMlgbBQcOnkc9taJNLyyilfuTfdIL9WT1DbYBJ85Cq?=
 =?us-ascii?Q?H20sWJOFL9HtBO2feD7wqonlMevoEPm97uYOBHPTkdtsIiW/lRZg0sK1912/?=
 =?us-ascii?Q?JNsfqhYtUW/90no9H1Z+eVv68faghn+vfvp/HFHu3LtQJ8mKqhd6RjIz4Vu7?=
 =?us-ascii?Q?XN4Lgjk+1G7QLJFP6EyaOWgf8jtMpd9RYyhwXenfNP64OlaGRV0FfQEm4plb?=
 =?us-ascii?Q?WXcFzIweE6oREnT9miEIiISxv2wtKGv5zJ/a35FfdUCgqTvUI8mfyMGXptyb?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d/k0O5p+paC1YfejPcV/KAbIye0JG1BQdf929lnzp9p/0jxhJebX8aoVHUMv?=
 =?us-ascii?Q?ZluUdV8EQ01rkufyB3k/QmrdhskrXJ3V2/7JbXysWz0EYx+f9xKpqJ8GMP/b?=
 =?us-ascii?Q?Rkqnr493JB82VKXu0hpMPiTYbVVR7zXES5MbbBa8rR0OvHIn/sY3FJgwLyUH?=
 =?us-ascii?Q?UXAs53k9zWnF/4Y6dWHKegkMb8Yhm6bWDXq8z+S1R+gpqqrDXAKYRzRu+jE1?=
 =?us-ascii?Q?ih6gS/gvczqLWDg5tO40jdtJW8lypK73iSvMqDLbQhHFmWsVaapeWKEfqnrs?=
 =?us-ascii?Q?IpRvQ9CZRLzRC0KgiyBzJ/juoCfGfi2N/DWT1HAmcBikOUsbDaXyoxBwH6kW?=
 =?us-ascii?Q?maeejNo4XcMyWogF9shO8PKx9wUjJ10Bx4y7vDtB1CzYcuEeQsj36fCc5Rmg?=
 =?us-ascii?Q?bkYGYMxxjI04PwNxDoRbN7lCrE5zovWeB0LmQXfXvzc0hrAXf5cphO6YrtZf?=
 =?us-ascii?Q?ykhr5J2yovYTIvPwZyCmtPUzpYDkKkQn0ww87foZ+QHaYp2XQ8jMSdSA0E0e?=
 =?us-ascii?Q?RLLPlXF4+umNI1FvOGG16pvPimHmW50Mt1z6IiQWhKemFTKuBg/kYZGzwSLP?=
 =?us-ascii?Q?qLCUw6Wy9lckt2usZnB9vlByTafMadO5dIe5wdk+79cUDdEvgDUceCbKyswy?=
 =?us-ascii?Q?92h2rfkepEHmmT41UVN5nTOfNa6t+OwCrCbR6ahtn0QNYcjSrQJWAOoM1Xpv?=
 =?us-ascii?Q?UJN+4Q2q/34PFt2lQRTDMAXOo4HuP0wpNiqD7GUwUz3dJITNf/PVBFr+sSEA?=
 =?us-ascii?Q?VRZ2auj5CG4LY99ceGyUTuZ3ntKmfesmdbK3+eoP3U2fFGq9g5bUM1a6xNAJ?=
 =?us-ascii?Q?DMeOS5QhEOYn8RcJN+sxSO1I6LIdd94fhPU1UUCKb6faja3BdnHegYCBJ0RA?=
 =?us-ascii?Q?8KLocAGgBBMGZkMRcIXUv3aEgQ2e/TAfSTYDWW2wLnhN1PaWn2Il4BQ67bY3?=
 =?us-ascii?Q?d6K9o5/MVu4efvm8AYYpKUH1X0PgdycMQekeARWuzTw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a867b3ad-6fd3-4bb0-8e5b-08db3bc66fdc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 02:26:07.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5OJkjzHBVV2/JuaBOFIucvpsGzxZVvz0EkymeutXg1RQmbjuH2H/wNd+EmDvn5eZ4la7TXI7CdPwr4uPGZrH13MAEu4F0dRC2cBxqJG5VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_14,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=767 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130020
X-Proofpoint-GUID: ZBkw2_fyu8r6G0WF_qiK_88I7LdXtSBJ
X-Proofpoint-ORIG-GUID: ZBkw2_fyu8r6G0WF_qiK_88I7LdXtSBJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> When merging is performed in bio_integrity_add_page(), I think SG
> functions for integrity will be able to be modified more concisely. It
> was just the reason. :) If you are okay, can I try to modify it to
> solve the problem with add_page?

Yes, go ahead.

-- 
Martin K. Petersen	Oracle Linux Engineering
