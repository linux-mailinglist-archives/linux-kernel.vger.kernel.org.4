Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3F63938A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKZDEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZDEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:04:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF0E3FBAB;
        Fri, 25 Nov 2022 19:04:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ2rdq1026358;
        Sat, 26 Nov 2022 03:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=w6Q5CQ/jcFLqWtea0rwkK/xFnCMtcxUPK+83C64hLII=;
 b=WX5sHQ4cDx6UGvqm+C+oLqy59PPaIOFc2Xizy7rw1DwEHbOUiB+hzo/KI1af3+QbghhS
 MIoicJCpDZh1TjTVT6axNsz1PXxpORbKTnwYleiXa9v/M46i4YfdIwXhtlPLxwsVT/fY
 +Cuma4Q4RObrR0EAH7++CwT/Cu2Za3cRkdr1jwkVzJY4kH4e28R7t9nMUK9ikSpkUigW
 hKVY3iJg0+Er7fNjgC2k4DO/GhXVuzvfCLX5gBS+aMGMkP7oScf83O+x0CqURwKqDAF1
 o1hWrmA6EwtZmY84OJIfqdBJrb6TX7blLaGK9sCUMCqlvTdoZas3Ge7bVLdkIJ0YFjvc aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt006j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:04:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1Wvaj009140;
        Sat, 26 Nov 2022 03:04:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3981tfw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUgvMvgbv1yZE+HzXaX3XBu+izD7w1LGHeP2j+9/P9QxX1rPODalRAzHGdrhzVjnVUHlMnvFhmzu8QqhCbzYOdeQaTtZvpMGVdNyp64IUTCjdKph58R8zu4wSIc4lVIEUQZAiSC2VUo4Yi5AbA/RwPQwCRMata8tqWu8dyKJC+ahBQPFB0IJtp7V+aFxl6NhRiBGdaQq5qN4CPDfTgOoTtGKhtcPNLZpD/mnu9dRWJuwZ7CuQ6a8GSEFPZSiiEdaeO5AG4rAAZHv45lacwiHAeOLU7wJOWuVuz73V25qEwTZnMQowc9+e4hTbvuL3O9TfpvbsNo3ORqTPcUV2wxX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6Q5CQ/jcFLqWtea0rwkK/xFnCMtcxUPK+83C64hLII=;
 b=QKC6XevjrJrdt3SQZus+7VK2VlUJoIRws+BY/O1cudTW/2/Dnn8NHf9DiLXq+IAVRsARcaQaGr7fu3hfNq0EqDZO4J/5M0kqMEDpjCN4kxDOoCUem87+sqsUBzKgoeuIzGl/oGp7cy1yPZp0WNe4cbmdd1FDgIv62236LNSas+f56DCOo3YeCQJSfyHd7N4VIduNrE6oKPHrq+4S9ZXe6A11Z0XIkA0abq/FZ9wpSZdh8A4PV3h96pDchFa7i43XbKDBp0Y0yPbvjzWUoi+lxoIaIe7ZOTPsUYX70lB3neZvSI8WS2PUv3iMxKa7rcllYEJYc9UPF4P+hUQ4vSCd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6Q5CQ/jcFLqWtea0rwkK/xFnCMtcxUPK+83C64hLII=;
 b=hu3DcVM8eUsgoYEKpo6aSCExjYQoLZpEtHf4s8nckFn+kMT3cSjdifpn1bePcRG4tb66tVbPn0LaGSsSp7zI5b3WH4vCvMTk2VRRpN8r+H3e1EJAjT3JfBjZzMB2ThJGjG46tV7ZuUBR0xZHNO6ha9bhK7twO/AEhFVUU9rwl6U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 03:04:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 03:04:31 +0000
To:     <guo.ziliang@zte.com.cn>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next] scsi: scsi_debug: use sysfs_emit() to
 instead of scnprintf()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz9amn7s.fsf@ca-mkp.ca.oracle.com>
References: <202211170940036248332@zte.com.cn>
Date:   Fri, 25 Nov 2022 22:04:28 -0500
In-Reply-To: <202211170940036248332@zte.com.cn> (guo ziliang's message of
        "Thu, 17 Nov 2022 09:40:03 +0800 (CST)")
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e98582-0e6a-464f-9b9c-08dacf5af01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPhbH6mCeD8JN82zLS2wAQ5xgsfl9vOSuEkJK0kKVPo6YeZiQr77XUm8Uk33/0nVUdZee2J3z6AEl8nGuPHUsVMg5nZMuaDJpRZ9/ZNR4UgRvdXBy3AgCjf+x/LnMn81fnIB1SQany/9ZadAH12eRNjx2HwqqEr5td8bPkGIfypOWwyOjVpjBduMoLu5RFCEY3hVp6NVxW+/C3qlPXgrGJqhdkIxR+q0u3vO9N9qM0cK1mupwwaeHlHHvsOC4HYiZkg4cqHgiBbJ/itRYNC+OZ0mV7FzEeSDtf3lxxCoNKqtqoNhWfme5zTRkygZ8O5PtmxXJl8VQA7iWhrMkjBnvHmad0QElKgTL3y5//ejXlRbxQND5+KRs7ifY7RCr76194ongd4sGnp5Q6+WjDaNGZOWygppUKBWMQsNnTeXR2WqWpGDW4yqisOlqp9nA5M/uZZT1J4RXDdLyb+bi1djTgjIOgAR50+Gh1QlNFewSH/lMVxQJzyhgBLut8s2WKNe5JcRn3bSEBGGEp2lw0vfn6bDigG1vTcxDPVmc6uWNA5NawpmZrpo+/yEnW8Uc3PexVpcKmtMWU6ud8ZS22QHDCRVEoLePp5SPbK22UenrZZ7VQeVzGIrTF7FgElM9IqT0DrNc6qez8bcKje9HhsysA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(186003)(2906002)(66946007)(66556008)(66476007)(5660300002)(8676002)(4326008)(86362001)(38100700002)(41300700001)(8936002)(6916009)(54906003)(558084003)(316002)(6506007)(6512007)(26005)(478600001)(6666004)(6486002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQh8N4664YlF2Q7nl4z3jYB3gz0gUrD/rv2eLnFtQFnL1eRF7+A54fgg5ejn?=
 =?us-ascii?Q?3C5QrYYfFoOck8AOKFsFU9CMcFZ2J9sNwYb8B93Hir83clb78FcCTqtb4sQN?=
 =?us-ascii?Q?Etd2hFzgh9v7nyUD6oow60Ti45j4g1+CEW7Y+JbOQBxCFRPOZN2UuWtZ9sPy?=
 =?us-ascii?Q?mDsSl+Ibhk/KqPJl6NV0LImdEIBpftl5oz91+zTRATyGJ4m8iwwvYrIlX/bm?=
 =?us-ascii?Q?tfaBa88dqANIWIJ/3SJj5BJdBH8UOiGcPfTEjnyiMJ2PjVUHDDakUYmfPZ3H?=
 =?us-ascii?Q?mijQ8rIvUFP9bR57MX65ftc/WKnudl9A4IMgRNviPI+NfQjNmLXztRKr3I7J?=
 =?us-ascii?Q?zWseJMlajTrsSTU8e3Gto5kVlcWtlFjjO7EZ9Y8vvaMD05X06pcR6Vb2QbeP?=
 =?us-ascii?Q?Gc/bOAn92Aw7RCTDgx35icLKPb1nkx6YpXJ8erNOP8GdVutWUlQierV2C3tW?=
 =?us-ascii?Q?wD7B1RDs3ktZlJac21Dqv12mZeHnUqkRkCywlUqrutG08+BZ8lNypK5YxgwF?=
 =?us-ascii?Q?xcpvtKdKs6htnw9Eqv8rZ77iHUfv8w4oHLCzOYn2J7KoyyP8Ud7jRI+HZU0S?=
 =?us-ascii?Q?a78ZMWRypvLYCtaiHfMBDHNE9BABrU+sAsEv/27Z/wWbcMKxfZIZKxs6/m0J?=
 =?us-ascii?Q?bSSjPLgEVyaDY9cPGlPP5Lzrg7lrJnSpXxUYCQcwZ46rpble2eA01aTX3vJw?=
 =?us-ascii?Q?19jpH6vQ+q7VZ/U1+Km4FLkaADaXC0dISa+IYpf92VwhTE0SANYKvv/T+v0f?=
 =?us-ascii?Q?drzNGpJrSOXax36Filwkboed/M8cDVTW8teBUB4bl1hKJFsBEz1FvCq6yoBX?=
 =?us-ascii?Q?CxxiQITlwhRjNZ69X6+ADtObLrOIX4+qfizmy/EVaLsfX9RYP8rXuYqGxQFJ?=
 =?us-ascii?Q?RIG/R0Lcc1AVpHWrXJhmKpe0yHc3Oq2Yc3HS2VrrAvTeDbMhs6rMyNiEgx+X?=
 =?us-ascii?Q?/DG7+pO6v69s98+Vfw3XfU28MteJRxz1LA/zHJFPk4ODtBXmIk6tgWOejSEe?=
 =?us-ascii?Q?u1XYYE//x4eYevtDSeiIxOd3f/3HWKIwWUCw2xmIrrVmIX89aq3ZYk2qpOIY?=
 =?us-ascii?Q?8A5Xv0j0UTmHTqLT9VKe3YXyx67InElVe0OEJPWyND6HYkCau4ucpP7imCUZ?=
 =?us-ascii?Q?IlgjLZZyb4d3g4sCL9IQj9//60gGXMzzLyPTrTaXcsr5F5QXGmfe4srkYFyX?=
 =?us-ascii?Q?GJNjCAQYh/LoD0zOgO1DIORNDvM1wwWpTg8OXSS1b2Gp6cqE9IaWrdIArhyb?=
 =?us-ascii?Q?vVQy3Xr4k+KJsVsTbr3AEexD+AuqfKVoKrSGIhcNo1e4wF7NVwxfQwsv5rcz?=
 =?us-ascii?Q?ef3Evhkg8QbCV09Zvz7wVT/K/7WWzsIBtA87nuFAVQZxiITlQy2bWAK1Ayy2?=
 =?us-ascii?Q?4O4Od9MkenBaIMKuXi1hbxoy6nNe1LvUYZpSgrAycKEJ1Wxxp43O5nDW6ACi?=
 =?us-ascii?Q?aqOBglsg7G35KrSqFVnhAW0o1z3Y3mbQo3/O3elgmH7dgN+NoP8IfT3FJsWK?=
 =?us-ascii?Q?9wqDtQ7bTGhp7WNgfJ4kuHogoBKvbrwZD5xg16UxXRfrquRaj5fkiJrfml6S?=
 =?us-ascii?Q?kJcF91+Vk5C36w0hzGtknAzvFs6/ZAOfU16Z8ZD1S/XYLWD5aPEGYLic+QwO?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M/mjbUJrlQ5yekJaCtmZxqQURsMXxpE31bTn5wZkg9KF56Cr/zjPHfyAKxzJhFYbb+OToLJVLmSV8kKC15FALfJqKdPzd4bMQdlnZsMzej4DyMMvMBCzn10/6nGjbSt6t4IDRaK4Ir9xFUgN4iHDc2riK/Ru8nsXdcpEAFwJ8q2QDkQn22eo1bk/mjOX6436Q8O+zpVlrVzODyBaVt9+fbttzPflAR+/JHrAIbIikJ7m0p/Wp6AqtZo2pOlGlVBT+qQQsuC7NG9GraeVWdHd8WliB6jQ0Fj4xWercB+vpZGWp3OgssyjG6+zqb0WU4WVib3AWbAFBt0kcz9FG1UpMfF9at/jqKnih26aLYdEby9NKQ24kJ5aVMKjSS3epj5cUCCccQLyrmdZWTY7n30zY/taD1nLJeYNU4xjBorH9Qpu4RuF0/CrzyKz/5yv0Aveb7tSxcV0pg3WoDna5yLB6jKVO36KJizSzxF0GZqonin6gftvLszz2sD9KqkUg1b3pUJeZcvqvnW4nVWHBZEa7E5paT+b3YRz8MsQEKlbNqTy5CXKfwx+SwwgFFmrtLxbL7TElFLkqCtq5GLCTvgCwK95iLMzpkIg1xnVZFZtY46g0bvACrCQxdlHFBnQGKpFxS+03PXjnwe4F8f9lAP6/bwX8KTg8dDa1zNRq//DgJAkoAHjlvsRRh/NhAaA/0wDHerkLSxBRGl0NGhOfAVicexfi0JBDvoVmM4naFdyzPh+4FUFbZ7zA2fKvOb5pNlQCDBMQBXkhQoYbRDkTpVzFWubhnsXBMPvAiOxgvOAubjsMzBMS7/pm+A1oBuXvFsdhHhQ8KTYBSFSnAGtgXmq7b/CAc05oh+Y05ssnQTShfuE1WqM1NFjMm1JjBgzUnbZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e98582-0e6a-464f-9b9c-08dacf5af01f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 03:04:31.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adKaOAy9aC31HmjOpjJPAzy/Rln6OsGIGDPJ1Wi2QwmBwlOI72kwAE7AshMIKIPOyStpcTx3rMPceRsA4TTtbLwsHy7GLs4xdPG3m1VIidA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=866 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260022
X-Proofpoint-ORIG-GUID: nU3HtRXepIut0oIJZdV6Gcxua9zQHgsq
X-Proofpoint-GUID: nU3HtRXepIut0oIJZdV6Gcxua9zQHgsq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Replace the open-code with sysfs_emit() to simplify the code.

Whitespace mangled, patch does not apply.

-- 
Martin K. Petersen	Oracle Linux Engineering
