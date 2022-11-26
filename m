Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9105F6392A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiKZAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKZAUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:20:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF65532C0;
        Fri, 25 Nov 2022 16:20:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APMiQNo001269;
        Sat, 26 Nov 2022 00:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jTZ/87AZK3BKxLCTxddgBDYydkkFgBooLytsiFN/zLw=;
 b=ch+iKBbG+MxD0TtjQLFTTADpfL9Kp3WtwWoidb/NFc6pTcH8rpAZYNy/Ub6NJ5P6ycab
 6CPqGZrmS8vUUVeUaSxdnR6EODYiLX9UbHV26h5iSMgjcf5KFlkurA9Dor6lM8+DWNyb
 ZvA4MwD29vJOcsAXFog+OnDs7IHCil8m6iPqJAb6I6lGiSaZL4HYQdgigLujjalBqIWF
 9r2ZeCEXJe3iVqsoss2BOlxYpI9lCmqxgKur6Vp1RBiF64bdmTjvoS2cc9FkEC3z14qN
 ZwiJvdnMOknt3tH9r4Qx9BXMSDsbS9KonLdFUzWtPl9deNm6H8EZmQj2JV3T9eT9Q4qG pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd8dgw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:20:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APLRSLO001496;
        Sat, 26 Nov 2022 00:20:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9htfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:20:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdLBarZ9D0YecA/FVWxMxeq7e3iXuxAlnI+kzTsg8Bg5dZYd1YNjR2/OZHqD2Sd3BNry8y98148honJL80nMFBnctgO9zvaB1K21YNZbCJjl8UvXr55xzuGYuHoJkbyVFXvm4oUe+Z9QeYYUuxLz0+lIdGATjTwwvohPEactUH5PL5VVy/mvmxrico73mbLDB4/Sf65W66gjIkj2SH79NNdV/oMhbyXya4UrDbExYIF6QkXKUF+00fiXhSMzOcd9z3o9xyVh/bl/0N+D1RTayYOug+S5+UVR3fJBd5UrT9fJQ91i6NI30IPgJYQ+zAeY/IkrOnqjyMtV/vOr7rOP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTZ/87AZK3BKxLCTxddgBDYydkkFgBooLytsiFN/zLw=;
 b=c5lSEOPvwVVvRu3tbjdz9B3ydlomr9hPLV87VbyLkgq7sWWQ/ZXAiABQby/zCS6Snq6Ri/XnJk5QzYOm1WOHoTcb0U/JyGxcZ11I4igzSzIO0x/0HrWL0jN9P69/JdrW2KvU3bEGGd1TNaC9rKYzfrpDiuGgW53JOSf1M5+QmdVNeZgAfn1Bt+7eHcYyV90nxnvYLWb6X57LcuN+g5h7YMNhn2BdoBqnGHw85hx85BVIKcRdZ6SqJx13d+YtX1WblGc41cMT8jSPTKm2SJPX0+go0gonLh2BqIwEl4xPQrNc8gARmFTKl0l+VIuwpVrcaOLqr88TF65bKAXXrnlKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTZ/87AZK3BKxLCTxddgBDYydkkFgBooLytsiFN/zLw=;
 b=mSS6mI+DeaDYC5WqbPkl87xG9pwVU4beJM8+733Ag+HaHYrCOkPlbQ4kB2L9QqZWhtXfAJ0R3DtFck96X5276B13gOeo/ToLo1ZBfdRBfzI7ykq+de+TqeXjSb202qGnEcExxaaDttx3jW3ZviY0dBZxUaILoLzEER9lei2FSx4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 00:20:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:20:00 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_verify()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k03ir2hl.fsf@ca-mkp.ca.oracle.com>
References: <20221112070031.2121068-1-harshit.m.mogalapalli@oracle.com>
Date:   Fri, 25 Nov 2022 19:19:58 -0500
In-Reply-To: <20221112070031.2121068-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Fri, 11 Nov 2022 23:00:31 -0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: fb576280-9472-4ce7-8cdd-08dacf43f4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dEPpP38OHPWZ3UsxP26ZDlU2ruy/w1MSGpAIWsErrwRA2HvKlKcNMpaSJMOYPPslua2C2h5WNHjNBnzfUIn09to3LY3eYUao7vOojLCF+TI64c4UPu9YW9//G/DoU5U2SLZkPCcJDHe3D89Qx1JCPwNuDtF2jcX7TY8a7VOWNs/2ItRr7rSccwH0NvCaQ6QOqdwT6ERy95mNCxJCBkncNxd7HTlGrRnBxGmVM+un5sQNw4vaZ//HQnIPcCIwSccEfYDqB6dgsiUF2rMDMEYWHRvTRHmHQkU0INoVUaWKh4AtBCtRBNARE79JH4KMtoqyvhyOg8SXyayNJV/pGEk9lWYdxxcu7QQ6aKvpVTmPrAyo5KSxGwxJ2Kv4v24NfBqpXag1OXjeiBm36DfabwtUagbLgYliQovEAHObhcKOtLf2LY2mMotYnleerrOHNmVOKXom6TOPJQwihAw/38lHBeU6zoLPFQz7Fz3arY7mSKbuV0r60rSG2dnm7uffqbv1E1a8o2gWQNlpWjQSwUK/SVvjsnP7b7Ao6Ur0eNgA3EPLcnEgYPYIwplm19XnkZgTiIGi/KRiAsK+eMvCvARuRabmSvQApwllLhOQ2YFRXHjS8v6KWhhfvTea1Pt4dYuHxZKL72qTypeSYG2oht9Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(8676002)(4326008)(66476007)(66946007)(66556008)(36916002)(38100700002)(41300700001)(6486002)(86362001)(558084003)(6506007)(316002)(6636002)(26005)(54906003)(6512007)(83380400001)(2906002)(186003)(5660300002)(6862004)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uy5l5waj/8PR0+v39ktS+rtrRPQAoWHZZjTEHLMtFzijxiFyAD7bkU+VSTGK?=
 =?us-ascii?Q?i10w8ISS0WB1UkHbfr+/xtxo1ZEYF/jdGsEmEWRtAFPGR9Nyj+YLYSSl3yah?=
 =?us-ascii?Q?64xYJey88JxSA6gZzCPNSAl9T1kMaBgbLrlHi1xxwWwxvgnCTKsmbPL+FHAX?=
 =?us-ascii?Q?sx57UWlZje1h0l/6p4Jfhv3zOfo2Km2AmAxWepyYsGBsfKefhytbCEEpPeIK?=
 =?us-ascii?Q?lIZ2mCmDG2dQalifh8Ao52/P8PkTj9YB3UJQ6Lt9d+Z079S/1x1Pm8O+ah9P?=
 =?us-ascii?Q?0k8cFmc4NA3RZIaV5uZkvz39ht8FYL8ZaytS9IRQ9fGeW9GNgymxKdq1JET7?=
 =?us-ascii?Q?9OoOt0GwgctWqO+TG5zxwqGSKoGzhA4KfenJGZMiwlVLte8BsNAxRr3vUNKl?=
 =?us-ascii?Q?3wCUQ1XKpFDQOpAZO9JBesmeODQUFOLZeFZNeocj4ttHOrsmcSbsU7XHVN6X?=
 =?us-ascii?Q?ueB1cW7UG111jpB4LGNNpVtQAYXkwdPojlbEACmlrnhu8qqIpgKiRUsp1KGg?=
 =?us-ascii?Q?N8KSX+nX36IXW5KuN1pcbGZ1UNs6NzlUyoCHRGyqAY99evnS6PfJSDtJD6z5?=
 =?us-ascii?Q?A4I7v9FeDYTFDkHev713nLmNA927L+f5oDQlIrPq5XB6UxHBarUnV8MBJSQx?=
 =?us-ascii?Q?EuAk7X3Qqhn2HEmOn258SJn9GcIR7yxBiLCF9uc//WSUjcp5uEJ7k1/umDJE?=
 =?us-ascii?Q?vpUf5VEdyd9mwPAGGYYZ8MfAplD7cnGaraVC+H+K5Ebewuf8IaqQhRosN19v?=
 =?us-ascii?Q?cOedl/XOp8P+dPRyUGmYNwXYyXoAeSsfxDGtFZU1xrc4xMs9qWU+3NFomEc0?=
 =?us-ascii?Q?zG1+7gtXX+w7y+rH0fKTukhi2LxY5GJLtEOc4eswsZ6MmmAWwgYrDicOYufk?=
 =?us-ascii?Q?o3kb899DZcrmcr86RaVWvFNWubw85pq95gwKryAcrFQ21K7qvazx9dsvJpRG?=
 =?us-ascii?Q?CtmAwTA6+9tAjBQ3wT8SSPINUIIOrxkE0A2xDArwtZVC+bDbwjzT9LMYwrm5?=
 =?us-ascii?Q?m/hFSAh802nTi4y+UdyziJDaFtP2roBvLDY4udX4hLjiXMJ/IhdFTJHyEqTy?=
 =?us-ascii?Q?CARvNo0/Rhrn47BDGx1/vcFtWwBElLmcbl0xnTNsGcSORVQckXBlLlDKkWTW?=
 =?us-ascii?Q?fhL/eueNzvWfaDgPiV7n6uawi/CVoqd8N96Mey7KCoyi+jwHZC1mdrejh1CN?=
 =?us-ascii?Q?NrGS9wQtkIHPnb6zMc2sd0pKRIvjAkp3eg7dGYT+oSkA0xyiEDm6JSxafyv0?=
 =?us-ascii?Q?JpINiXfPtsLcb3hjpyXf7/G2oCEcFGz480/vqtZrW/PBCJSi4Kvgtzb+awL6?=
 =?us-ascii?Q?LwL2u6ymKLa4QgwogHKCsGPlNDP9lkTg95LJ5DW2CyoL0sY1wdqtuZjXnPcG?=
 =?us-ascii?Q?ZxJtKypG3kU49iHY2gEr1ptUsqhsi5O8K+s6bknAVFXY2L8nGg9xeGP2/4fg?=
 =?us-ascii?Q?JSv1oJ+/gnt3zkAISorEl225WaarA1OfLEjOzN+6ZQZgeyuzrsgfkktKLlhP?=
 =?us-ascii?Q?nEgkECQgHS78RuQJvpAedn+TC3DEw4n7N6hbz9YP2VTVa+ZDn9PtUyPd/hyV?=
 =?us-ascii?Q?97X7MaejzCdzYd42BUZ5ZLknoPBtSgpUEQxRKtM36/R/WMTF+HX6PtW5BI8S?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2O4UjyKxYacS+bzpCJSoTsGxsE6+HIrahWmvyoVmlgbQod9YDECepEpQ6OQS?=
 =?us-ascii?Q?41RLqF9ZHLD+W6p1mtkl0LQ7aMGc519aQpPvAhFe9K80h5xhcuAj9nw8g7Ww?=
 =?us-ascii?Q?WAcIoqOnxhP/sv3dS5JG0P97D3NpLM3l6SQkTs9kC/4xTUxBY+J7d1zSzwDx?=
 =?us-ascii?Q?IHNp7b1H9XTTL4Mfk5qV6JtyxWzGt7JsF+jWkfYRX86C/NwCF3KSOHtovuf/?=
 =?us-ascii?Q?lNN407YhiCGh2vtIooe6upmYxdNbqqeJphlb1BUZfH+OVmJ4dW1mPXEycdUc?=
 =?us-ascii?Q?YHow5ZMQSOxw9MGbsA1phmHEfI8zpZPNoym2c4fn/IbTVORVoedNoTM1yrWv?=
 =?us-ascii?Q?dFYJXfSwJQwI+48nveWaEwEkxBE33451IAZmsnHJeJKWH4kAOgU0xCyI0/u4?=
 =?us-ascii?Q?uYLt2SC07WlOoZ2lITR4lSrypkr30KYUxzK97XZz8pGWkIMghRNkxCZT8rrr?=
 =?us-ascii?Q?WkRiD9+mXd4372QocLOQgh+DRznjLazrBylaOfjwGs3Zp9aZU9vT1Fgx3Pfu?=
 =?us-ascii?Q?hbEtpm/Y77ZInWdgyFFwgz1oVhpHUMYLv00SIiE40LF2Vjds4WkepX00mpC2?=
 =?us-ascii?Q?tDJdCHdd6uDB7DxSqe3Wl6iZ/wlJGOSh1eo+3RpV2bBeVHUAigIce2ue/Mcn?=
 =?us-ascii?Q?8ANUlBoFjtooc76Jx5ZaZ7E1JLNI7qcT4pWGncT7maVozfblpWz4ViQImsiF?=
 =?us-ascii?Q?mbiDjs7QoS5vmEHJjHOFWhUYSPN/MgIKAnvHXWw1qJHfiEliE46SnqFeEFoF?=
 =?us-ascii?Q?tfjA2FezX3zhtNXF03Al2mLNX9rAXBkY/pWTsgVu3XdSVQEc8EwiayIaS9rY?=
 =?us-ascii?Q?HFAwb+qjxUKcQL2vP7UR4VEVZdAYAqq0HnDgDPfRAybNYwBcJYnTXpCA9Auv?=
 =?us-ascii?Q?vic0saSBvbM8BOsXLp532JG91wxAnRsbxVHngSUttLVcPYK0Bj7DH9ceIHhp?=
 =?us-ascii?Q?+6wlOwxiaXYLr4VdeAoxWA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb576280-9472-4ce7-8cdd-08dacf43f4ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:20:00.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XdYwBRyJtuzkq/h+FhFCn+FM5s0zz53US6+XBQOjsDMmTr+yzRAP7/IconYmkOP6vv/goEJiOyg+RaenjmiwFAVi8w9FkgZzYkFrhaRgJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=761 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-GUID: SchleKigY2Ng-SHDyiC9ObWPuXaNN7FD
X-Proofpoint-ORIG-GUID: SchleKigY2Ng-SHDyiC9ObWPuXaNN7FD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> As 'vnum' is controlled by user, so if user tries to allocate memory
> larger than(>=) MAX_ORDER, then kcalloc() will fail, it creates a stack
> trace and messes up dmesg with a warning.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
