Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFC6C63FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCWJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCWJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A22471D;
        Thu, 23 Mar 2023 02:46:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hsEo010794;
        Thu, 23 Mar 2023 09:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qg5XdTbWZUwpbpRExqpv15ja87BSh65hIv3SoRSNLIs=;
 b=X7mJZfz/Kq9RIRljTiOC6ICVCXzguOBYC67R0DQ1gQ5hNhrD/eD/EsYK6+My/Iq1n/sH
 plSES8N8KnUO6rnKjKi11+tv+GodUh6PNIYYclv5wMLhpoQvbIZrkRbnw2UN48ak2me2
 V/hmi+dAMFbSJRXD5YS6ot7pqfy6oBFqAnl9pnTlCuXqGLcinJD/LksLBNHLwHvSv5s1
 xcEL7Ia9YFlw6ZIKjJMOgS7l90BmfipJvQ3eH5yMLGWf9dCA/qY7OZV8FxI1NFM6Nadj
 lHSVh782Cbgor4QYuw0YtzwDZE8y5DyaqeUfSGkJfLMFikt37ng4XDkKYubJqs29e2uf wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433u9hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cgpf020657;
        Thu, 23 Mar 2023 09:46:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgman08yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkDmTYKokBBds06mrvSXWdzSknvVAHc6XidCd/vLZDCU2m2m1XyKE/wcajarNNWSLROU2cI4Xbfd+dqcF46peWDQVX9SqYtfr2buO1ZQOTYfi7rd1wBlbuha6Oj+NOlR2b3hv0OsH72cmGjzSo7Ugf1UPHTqBjQkjdrQWejB5nLfgcGLfZThIVsfH2QQJuB42G4w2JvMKWI4eMMQV+kW6Hu6I8ETXkDFYhwfZfbhARZbIWBJ8HCltFV3jPDRUv+AsR/fLj5eXq2l109050TXmCb07NpYQwez1pu6XvZvYmvjAXCO8UXLoq8vDzEZASBvsviGP8URhMT9xoBl5A/YhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg5XdTbWZUwpbpRExqpv15ja87BSh65hIv3SoRSNLIs=;
 b=O/wGuhysT+x1tjUMnETrXKUFpfLMSscquZIexEsDFQAC8jf1eYn2kbHaje5Au2GjOf1UGEh74RIBb8jNfISXk38o1LWhfmhOMPRzhtvDLyTexUmY0bYoLoMbG9XELytFQ8tfg16MKRBoyabEh5FBKgHaI9ba6h4dXHWCp+2jh8M6yEbKDRtn79UNjycbHw0Zq6Se0+4iz+sd8a3wjnArxgpnYNJ6GSbDPZloRykJYvayHwD/Y6UOYxUHBA2LMeSyUnZc5zDyM9YP2q4dWoDSlAJqF52oKzvHjPPqvoaRv94EpxMQYzV2Bffnt9bSN7hoRiog9fP/7PhwNVl9Vpw2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg5XdTbWZUwpbpRExqpv15ja87BSh65hIv3SoRSNLIs=;
 b=x3Dl4xXkZZL0mnlR7ZWWQjkJsTIRUlWkd2sXFlxEI4uvCa7OGaR8MQ05cnZwsxmQK6GzsgJZ3cIIp50lpBChk346uhbUejndNNrbb9stF/h9+GhiE8cnK+kqT3UtSVTpAd5LomzAF+QKJAbF3AE5FtrGmmNBw/oEpiZBih02Jfo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7319.namprd10.prod.outlook.com (2603:10b6:8:fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 09:46:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:40 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/11] scsi: scsi_debug: Drop sdebug_queue
Date:   Thu, 23 Mar 2023 09:45:55 +0000
Message-Id: <20230323094555.584624-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd2672a-8450-4c59-1d5c-08db2b8380bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjGzh76tmnXiXeiMtJeD+4pIE8PGiZf8w9CrqXahIHAKrssN5VpAKZcDURflyQPLK5D1ZmHrJ4N5IdvG4gk5EEazm16doiP6bvDBE3rViEu2ajh8zVqMJkWs9eofSSAAZiMyx1HNVlwPifTGtWkBaMzTpokQ87l4RUj74EiQ7k3VtujsiLJrdivJNNeslw4hQwNw5vZJ2H04NnUJlUXb9VMR+5xp4DhLnHgV8Ba3qNaN7KH9PwoyBinfcogKZeQivXjLBQSN41p41pw4WXkT7YRsLhwIIaVFFiWEG+gv1EeD19ia0+2zXmzH/3ED3OJOwoAcLBzbCTLt3htjgPUfIzFQU8WDmpez6APWoqGqhZwRNDVqQ7bIy3nhgbu9JGaZlufbWQrHLpCJTK8pm6ZpCvHrhkLp5M152m1iRZzfr2+KsfnzDNMn4o42nVvFDo44EPUsgXv/vVnr30qCuFLjGTOZRqtHAJRIUNhnxsP2e7cxwBlTHpyRo0LuuxaO81pfXJyfMsxtdNmlzzN98B25REx2xA6/pCsF1v/YbTIMutGEeVEIR0hygdyVvUgFc8SKJ/qv4aH7DuoeO9kqm7bB2+dcFWjeJmskhfpObXvhJ3HWtR+vdlujdKPjd5PcziL8v/94rwEaPsRoCRVy8N+NVn8RwFHqC5LUvKGvnwxruq9Kx/c5rScH/Bbb+2kuAN/r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(478600001)(2616005)(83380400001)(2906002)(41300700001)(86362001)(38100700002)(4326008)(66476007)(8676002)(66556008)(8936002)(36756003)(66946007)(186003)(6512007)(5660300002)(6666004)(26005)(30864003)(1076003)(6506007)(316002)(103116003)(6486002)(107886003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8dCfoKwc2iiVCom6TDKmt+OULz3Daviy1ENIm50o0MJH0OwHwJoD2u3/9rq?=
 =?us-ascii?Q?rvFI1vxgFVgQ12MG7YVf64ETEALU5LXWgwynYOoRiH4DWe2kLMvC8o2wey7c?=
 =?us-ascii?Q?edBvyF3rM2uzGKZPPknJRAEHmy26AXYsxzsjuG+vHEGffaDOfs+34LBzwTbe?=
 =?us-ascii?Q?hdIZWrTlcSsX9LmYVy0MmWHN6TiKTCIf38mMo7gO7mnlMokGpSxT3fqowxg7?=
 =?us-ascii?Q?mKUxn01esKH+B/ItuHr9NVLR/XMNCpahYogYwmDKJoj1BmJ30Zvg1q4C0UFy?=
 =?us-ascii?Q?TcUUlfqQgSXG5608Moy5P0KilrFZdYn02qC/SYGWUU1DBTGOa4o5G7V6zs+o?=
 =?us-ascii?Q?y0kMxN0fr1NXYtyki6ZeV4GsJY0BJvXG+QPLBMfckj+vCOmXpj1PMvy3wwnL?=
 =?us-ascii?Q?LiJpFg/nwH7iy/Tb7edbXuy1VyAA5cUYQargUCvP7K/dHcR8Nl/1lY89nWWZ?=
 =?us-ascii?Q?wjHTn05ki+5HN1yGiq4bCYgfXdr1wgLYWAri/BY/PXlnjjP5KnWivi0ysufa?=
 =?us-ascii?Q?1iLsMQZgUh68WbtgK0fXhR87wTDW7sw0ehFcIbdlUeh+nQHOo/RVc7mFAMhI?=
 =?us-ascii?Q?cIJsxHii4Il/64D+6qAq6jkgsJg4lvZyhTmoJsAUGoI1GMRa1c8Dv2jHzQOo?=
 =?us-ascii?Q?KF4mnx3PRk0uH4YSvjlghbGA77MNM2VKyBJ+Cm/xKt8GjsFS2D1/uBghnnf/?=
 =?us-ascii?Q?dg8SHtY4uu4C2aNffDHbCGhO/tYYfTBQvNPCtOt9sJRwUk3e36zVJ2f4kldM?=
 =?us-ascii?Q?Zys4ByZMuRYD54KX+fUZyIFpv7CiEsaPpMBSnZu4+ulAvTWaS/DLjHfeWvKL?=
 =?us-ascii?Q?ldq7Mn+JDBX/nA44ZQvGoTCjUoHdHtCN289n4nxbxP1hdMIpZuU+DhwV1UH2?=
 =?us-ascii?Q?2WvH+m33cJ8uRomsNsovMwo7+4jxt3o450nY9qHwZHzkyDF5gSuZdJt7n8EN?=
 =?us-ascii?Q?gcv1lcsJFPVpWyE0qyrwM/FF/tMiTNREX3mQJAyqqJkx2yQpDhnQqW3/tfBj?=
 =?us-ascii?Q?3VsnBOloBUlNRv1D/Z7JZts8Krud9exAx/rFCu/gqtHfZsvquWhInf2xfdQi?=
 =?us-ascii?Q?6hEG3sLv6UhQUFQ1mJfe+/mXFyJ1kgunJQGS4qDgBG8/xf2U6kWECjbZk7f7?=
 =?us-ascii?Q?3PTxXJiBCs83bjaRFJJnnixYKfujkRf2IQBpXn2g77bBuCLVCiSZL4gPumaU?=
 =?us-ascii?Q?d14z9UzhRZDLKnwMsssK/6SkxBPt0DGqvWFxGn32MQEWbMTVAwbjpuF3SryZ?=
 =?us-ascii?Q?u0z/V0QLxGQXh3XTyUh9gABeulhsmuO+RS8luYKlawaHTkARE9Pss12n3r/E?=
 =?us-ascii?Q?jD7oEG46uf4LQywAoQeMnm8KnNlzlsNJmqO2KPlDqAwqHMewwzKy/iQ7koxT?=
 =?us-ascii?Q?S+ZTyXakEFWcYYj7fEwtv59No5y/jYhEQTH6vj/0WIQhzF5MK45GaSs7CEUx?=
 =?us-ascii?Q?k1W3ks1J5ZXLClhSMTFk+ZhXYw1UFRDLseAXqH0Uzp4REpQE0RMw1GX1XGE/?=
 =?us-ascii?Q?WuykqTsaxc5/R6KhCMWlkn4ykjboW2Tg4RDl7iNbTCRIxc0N0NIdYWx4lgWz?=
 =?us-ascii?Q?dH6+jWNSjUaEDbxrkfQoAtUHcTgpsi/vDVjyAQpXdg9vXeK2L3bhLc0Y1Rdf?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R7O7g4jrWqBYg3Ev0g6FuerzsxadirXUGj7Plm/w9oJXIdjqcM5q9pYM1h+g8bJTuHru6c+E0r9s728CH1rYx/clquizR/kJywCRjimGi/4f65KAQL4G00VE8jy5r8J8lnmUtytGCjwmmVS2+yDDR8uBXULipYWyjplx01GqDpxoN8YtaLKCJLaDkje/GpdNqXLGCDXLG/RA+yUNhgoRAtr49hfQUHhF5K4VwtrBKl0atS/2FexffVTqGlu0qA9TsirpFIw79oqKLCC9QsvY7Kani+YJHDGn98KVkgEVZl/C3TNylOd2MOGdJf+O6MPWoT6STwW+VMTMgV7yiEdVH6ZshNcZEcoYqeFo77EljLorHfeS1Lb8LcCX6E3lgjQpxb+oYovRCYNZy6KnMSyDpisJtCHp4ghhkBSf/Rtx+OZKIfn8Sk3S94vJJgHb8j+C04TwVh0XLIifex1+JsFtHQs8UzsOpDMiiFXVSL2tr+3alT+bHANPJkfnwIbaoY+TN51NdMFJ2vqosVraDxgPptHXQfPP3gTJVY2efEYnN0UUT9uxW9KfTYuw8Wji7TTV3Zpuukdj9XOrpltdf4FCetrVhtMTn9opVZUUzkpFV8QBHmNasTpCryA1VOBk6r/me8UAHdrB5Eg9GN/gZVPIbJqiftvaRJYdOdyQjfshM6/mpGqdGBjhXaR6aUN4+TQTlU6puKzL5Qxbf2pZ8Fh5lW7tlIGKC9bTjZ3Q8ATR60v9GuOlH+kUbCkOlWZCUzUrku8+He+ZJO9MdWdXbvn/EQ9uS5XLa3qhWFF7xWVn80fgALJROqMnDOluQJ0EwRxOx1lKcGkmSa74kPUdB88atjwY54b+x9aKY2j2INNyHD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd2672a-8450-4c59-1d5c-08db2b8380bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:40.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiCZkuoBmttvsg28hVzYuqUckXmwheh95WW7rr+KKSkOfA5YEJ0Br6FhDEe/PGIzU9q3evXuV8z8PQCxZE9tMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: yJhg1WPjWjStwiMKI5EPnxU5JwrHvf5A
X-Proofpoint-GUID: yJhg1WPjWjStwiMKI5EPnxU5JwrHvf5A
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

$ fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read --bs=4k
--iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg
--eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
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
shost it is possible to overload the submit queues and run out of tags.

The struct sdebug_queue is to manage tags and hold the associated
queued command entry pointer (for that tag).

Since the tagset iters are now used for functions like
sdebug_blk_mq_poll(), there is no need to manage these queues. Indeed,
blk-mq already provides what we need for managing tags and queues.

Drop sdebug_queue and all its usage in the driver.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 189 ++++++++++----------------------------
 1 file changed, 51 insertions(+), 138 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 78bd393cb2a0..e3e63425e415 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -341,8 +341,6 @@ struct sdebug_defer {
 	struct hrtimer hrt;
 	struct execute_work ew;
 	ktime_t cmpl_ts;/* time since boot to complete this cmd */
-	int sqa_idx;	/* index of sdebug_queue array */
-	int hc_idx;	/* hostwide tag index */
 	int issuing_cpu;
 	bool aborted;	/* true when blk_abort_request() already called */
 	enum sdeb_defer_type defer_t;
@@ -360,12 +358,6 @@ struct sdebug_scsi_cmd {
 	spinlock_t   lock;
 };
 
-struct sdebug_queue {
-	struct sdebug_queued_cmd *qc_arr[SDEBUG_CANQUEUE];
-	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
-	spinlock_t qc_lock;
-};
-
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
 static atomic_t sdebug_completions;  /* count of deferred completions */
 static atomic_t sdebug_miss_cpus;    /* submission + completion cpus differ */
@@ -848,7 +840,6 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
-static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
 
 static DEFINE_RWLOCK(atomic_rw);
 static DEFINE_RWLOCK(atomic_rw2);
@@ -4903,20 +4894,6 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return res;
 }
 
-static struct sdebug_queue *get_queue(struct scsi_cmnd *cmnd)
-{
-	u16 hwq;
-	u32 tag = blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
-
-	hwq = blk_mq_unique_tag_to_hwq(tag);
-
-	pr_debug("tag=%#x, hwq=%d\n", tag, hwq);
-	if (WARN_ON_ONCE(hwq >= submit_queues))
-		hwq = 0;
-
-	return sdebug_q_arr + hwq;
-}
-
 static u32 get_tag(struct scsi_cmnd *cmnd)
 {
 	return blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
@@ -4926,47 +4903,30 @@ static u32 get_tag(struct scsi_cmnd *cmnd)
 static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
 	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
-	int qc_idx;
-	unsigned long flags, iflags;
+	unsigned long flags;
 	struct scsi_cmnd *scp = sqcp->scmd;
 	struct sdebug_scsi_cmd *sdsc;
 	bool aborted;
-	struct sdebug_queue *sqp;
 
-	qc_idx = sd_dp->sqa_idx;
 	if (sdebug_statistics) {
 		atomic_inc(&sdebug_completions);
 		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
 			atomic_inc(&sdebug_miss_cpus);
 	}
+
 	if (!scp) {
 		pr_err("scmd=NULL\n");
 		goto out;
 	}
-	if (unlikely((qc_idx < 0) || (qc_idx >= SDEBUG_CANQUEUE))) {
-		pr_err("wild qc_idx=%d\n", qc_idx);
-		goto out;
-	}
 
 	sdsc = scsi_cmd_priv(scp);
-	sqp = get_queue(scp);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 	spin_lock_irqsave(&sdsc->lock, flags);
 	aborted = sd_dp->aborted;
 	if (unlikely(aborted))
 		sd_dp->aborted = false;
 	ASSIGN_QEUEUED_CMD(scp, NULL);
 
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("Unexpected completion qc_idx=%d\n", qc_idx);
-		goto out;
-	}
-
 	spin_unlock_irqrestore(&sdsc->lock, flags);
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	if (aborted) {
 		pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
@@ -5255,21 +5215,18 @@ static bool stop_qc_helper(struct sdebug_defer *sd_dp,
 }
 
 
-static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
+static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd)
 {
 	enum sdeb_defer_type l_defer_t;
-	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_defer *sd_dp;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	struct sdebug_queued_cmd *sqcp = TO_QEUEUED_CMD(cmnd);
 
 	lockdep_assert_held(&sdsc->lock);
 
-	sqcp = TO_QEUEUED_CMD(cmnd);
 	if (!sqcp)
 		return false;
 	sd_dp = &sqcp->sd_dp;
-	if (sqa_idx)
-		*sqa_idx = sd_dp->sqa_idx;
 	l_defer_t = READ_ONCE(sd_dp->defer_t);
 	ASSIGN_QEUEUED_CMD(cmnd, NULL);
 
@@ -5285,22 +5242,13 @@ static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
 static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
 {
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	struct sdebug_queue *sqp = get_queue(cmnd);
-	unsigned long flags, iflags;
-	int k = -1;
+	unsigned long flags;
 	bool res;
 
 	spin_lock_irqsave(&sdsc->lock, flags);
-	res = scsi_debug_stop_cmnd(cmnd, &k);
+	res = scsi_debug_stop_cmnd(cmnd);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-	if (k >= 0) {
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		clear_bit(k, sqp->in_use_bm);
-		sqp->qc_arr[k] = NULL;
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-	}
-
 	return res;
 }
 
@@ -5558,7 +5506,6 @@ struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
 
 	sqcp->scmd = scmd;
-	sd_dp->sqa_idx = -1;
 
 	return sqcp;
 }
@@ -5577,13 +5524,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	struct request *rq = scsi_cmd_to_rq(cmnd);
 	bool polled = rq->cmd_flags & REQ_POLLED;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	unsigned long iflags, flags;
+	unsigned long flags;
 	u64 ns_from_boot = 0;
-	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
 	struct sdebug_defer *sd_dp;
-	int k;
 
 	if (unlikely(devip == NULL)) {
 		if (scsi_result == 0)
@@ -5595,8 +5540,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (delta_jiff == 0)
 		goto respond_in_thread;
 
-	sqp = get_queue(cmnd);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
@@ -5615,33 +5558,12 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		}
 	}
 
-	k = find_first_zero_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (unlikely(k >= sdebug_max_queue)) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		if (scsi_result)
-			goto respond_in_thread;
-		scsi_result = device_qfull_result;
-		if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
-			sdev_printk(KERN_INFO, sdp, "%s: max_queue=%d exceeded: TASK SET FULL\n",
-				    __func__, sdebug_max_queue);
-		goto respond_in_thread;
-	}
-	set_bit(k, sqp->in_use_bm);
-
 	sqcp = sdebug_alloc_queued_cmd(cmnd);
 	if (!sqcp) {
-		clear_bit(k, sqp->in_use_bm);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		pr_err("%s no alloc\n", __func__);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 	sd_dp = &sqcp->sd_dp;
-	sd_dp->sqa_idx = k;
-	sqp->qc_arr[k] = sqcp;
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-
-	/* Set the hostwide tag */
-	if (sdebug_host_max_queue)
-		sd_dp->hc_idx = get_tag(cmnd);
 
 	if (polled)
 		ns_from_boot = ktime_get_boottime_ns();
@@ -5688,10 +5610,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				u64 d = ktime_get_boottime_ns() - ns_from_boot;
 
 				if (kt <= d) {	/* elapsed duration >= kt */
-					spin_lock_irqsave(&sqp->qc_lock, iflags);
-					sqp->qc_arr[k] = NULL;
-					clear_bit(k, sqp->in_use_bm);
-					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 					/* call scsi_done() from this thread */
 					sdebug_free_queued_cmd(sqcp);
 					scsi_done(cmnd);
@@ -5949,14 +5867,39 @@ static int scsi_debug_write_info(struct Scsi_Host *host, char *buffer,
 	return length;
 }
 
+struct sdebug_submit_queue_data {
+	int *first;
+	int *last;
+	int queue_num;
+};
+
+static bool sdebug_submit_queue_iter(struct request *rq, void *opaque)
+{
+	struct sdebug_submit_queue_data *data = opaque;
+	u32 unique_tag = blk_mq_unique_tag(rq);
+	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
+	u16 tag = blk_mq_unique_tag_to_tag(unique_tag);
+	int queue_num = data->queue_num;
+
+	if (hwq != queue_num)
+		return true;
+
+	/* Rely on iter'ing in ascending tag order */
+	if (*data->first == -1)
+		*data->first = *data->last = tag;
+	else
+		*data->last = tag;
+
+	return true;
+}
+
 /* Output seen with 'cat /proc/scsi/scsi_debug/<host_id>'. It will be the
  * same for each scsi_debug host (if more than one). Some of the counters
  * output are not atomics so might be inaccurate in a busy system. */
 static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 {
-	int f, j, l;
-	struct sdebug_queue *sqp;
 	struct sdebug_host_info *sdhp;
+	int j;
 
 	seq_printf(m, "scsi_debug adapter driver, version %s [%s]\n",
 		   SDEBUG_VERSION, sdebug_version_date);
@@ -5984,11 +5927,17 @@ static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 		   atomic_read(&sdeb_mq_poll_count));
 
 	seq_printf(m, "submit_queues=%d\n", submit_queues);
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
+	for (j = 0; j < submit_queues; ++j) {
+		int f = -1, l = -1;
+		struct sdebug_submit_queue_data data = {
+			.queue_num = j,
+			.first = &f,
+			.last = &l,
+		};
 		seq_printf(m, "  queue %d:\n", j);
-		f = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-		if (f != sdebug_max_queue) {
-			l = find_last_bit(sqp->in_use_bm, sdebug_max_queue);
+		blk_mq_tagset_busy_iter(&host->tag_set, sdebug_submit_queue_iter,
+					&data);
+		if (f >= 0) {
 			seq_printf(m, "    in_use_bm BUSY: %s: %d,%d\n",
 				   "first,last bits", f, l);
 		}
@@ -6943,13 +6892,6 @@ static int __init scsi_debug_init(void)
 			sdebug_max_queue);
 	}
 
-	sdebug_q_arr = kcalloc(submit_queues, sizeof(struct sdebug_queue),
-			       GFP_KERNEL);
-	if (sdebug_q_arr == NULL)
-		return -ENOMEM;
-	for (k = 0; k < submit_queues; ++k)
-		spin_lock_init(&sdebug_q_arr[k].qc_lock);
-
 	/*
 	 * check for host managed zoned block device specified with
 	 * ptype=0x14 or zbc=XXX.
@@ -6958,10 +6900,8 @@ static int __init scsi_debug_init(void)
 		sdeb_zbc_model = BLK_ZONED_HM;
 	} else if (sdeb_zbc_model_s && *sdeb_zbc_model_s) {
 		k = sdeb_zbc_model_str(sdeb_zbc_model_s);
-		if (k < 0) {
-			ret = k;
-			goto free_q_arr;
-		}
+		if (k < 0)
+			return k;
 		sdeb_zbc_model = k;
 		switch (sdeb_zbc_model) {
 		case BLK_ZONED_NONE:
@@ -6973,8 +6913,7 @@ static int __init scsi_debug_init(void)
 			break;
 		default:
 			pr_err("Invalid ZBC model\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	if (sdeb_zbc_model != BLK_ZONED_NONE) {
@@ -7021,17 +6960,14 @@ static int __init scsi_debug_init(void)
 		    sdebug_unmap_granularity <=
 		    sdebug_unmap_alignment) {
 			pr_err("ERR: unmap_granularity <= unmap_alignment\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	xa_init_flags(per_store_ap, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	if (want_store) {
 		idx = sdebug_add_store();
-		if (idx < 0) {
-			ret = idx;
-			goto free_q_arr;
-		}
+		if (idx < 0)
+			return idx;
 	}
 
 	pseudo_primary = root_device_register("pseudo_0");
@@ -7088,8 +7024,6 @@ static int __init scsi_debug_init(void)
 	root_device_unregister(pseudo_primary);
 free_vm:
 	sdebug_erase_store(idx, NULL);
-free_q_arr:
-	kfree(sdebug_q_arr);
 	return ret;
 }
 
@@ -7106,7 +7040,6 @@ static void __exit scsi_debug_exit(void)
 
 	sdebug_erase_all_stores(false);
 	xa_destroy(per_store_ap);
-	kfree(sdebug_q_arr);
 }
 
 device_initcall(scsi_debug_init);
@@ -7482,10 +7415,8 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 	u32 unique_tag = blk_mq_unique_tag(rq);
 	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_queue *sqp;
 	unsigned long flags;
 	int queue_num = data->queue_num;
-	int qc_idx;
 	ktime_t time;
 
 	/* We're only interested in one queue for this iteration */
@@ -7505,9 +7436,7 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	sqp = sdebug_q_arr + queue_num;
 	sd_dp = &sqcp->sd_dp;
-
 	if (READ_ONCE(sd_dp->defer_t) != SDEB_DEFER_POLL) {
 		spin_unlock_irqrestore(&sdsc->lock, flags);
 		return true;
@@ -7518,16 +7447,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	qc_idx = sd_dp->sqa_idx;
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u\n",
-			sqp, queue_num, qc_idx);
-		sdebug_free_queued_cmd(sqcp);
-		return true;
-	}
-
 	ASSIGN_QEUEUED_CMD(cmd, NULL);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
@@ -7547,20 +7466,14 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 {
 	int num_entries = 0;
-	unsigned long iflags;
-	struct sdebug_queue *sqp;
 	struct sdebug_blk_mq_poll_data data = {
 		.queue_num = queue_num,
 		.num_entries = &num_entries,
 	};
-	sqp = sdebug_q_arr + queue_num;
-
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_blk_mq_poll_iter,
 				&data);
 
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (num_entries > 0)
 		atomic_add(num_entries, &sdeb_mq_poll_count);
 	return num_entries;
-- 
2.35.3

