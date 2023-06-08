Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA9727451
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFHBaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFHBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:30:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E526B1;
        Wed,  7 Jun 2023 18:30:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MAwFg001922;
        Thu, 8 Jun 2023 01:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=lB5l5GBRPRWiO482AfcO78mhkayM1mp8YKt9MT9soC4=;
 b=0ydSQBI/Mnc0EiGTWJ0NrkB1rxQzmgwivYFzN9CKrr5EgTtCZaLR8/jM0odHTON2d0SL
 Eyu9uiGuGMIXpg0u5iT0jXv9ZF9/id4UqotBIZdDrA1UGP5T9lVdmn6OzoX7ONyFtxQb
 c/My0nRpf+clkP3H6IhpeGS5jf85pntW2Q6Y6iDlF8SrNKFhvnMr7jJcV7KAJO2E8Yzk
 RvIvYz167avewo4QqPdP+siPnwRa+sb1oVGDCGtxZciJbzFgLc6hEQHo5N3vBC+H0WgB
 Rm78cTJtH3EU1aDczsgMFEErVFXfPph6Q1oUzXRzXLkA789wh44XjQogbxUZ4noZcyQQ eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u3595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:30:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3580wZOY015834;
        Thu, 8 Jun 2023 01:30:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mg0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McRHaVJKEW51C0f8ZIh/ibcd9CSK8iZnbVlcN+a/CJ/Xy6wGYsSYNQCHUYs8FCEst5r6hWuSE4oIdXdaULY4py8R2Lf1oC6N756i7CxK3+tzRIOWFH6BCsdwIMJ4rrqHpUi6+K0AKZNqh1I0q40AlSZUDy0ExPdFmfcPbLZT/ihEFbEK248AAlMUeUUfZhDK/J7XmRSc8ZgrxZVpQMKa5BZF33DR/OXrymdpUzSt81dlEP7fTsEgiq/e+sVdRcxNYMx4Qm3V1ExfXS37kqEfEA4//sgC2mJ+VO9QZQrXQmErPhUuxslPGW1zpjx6cpafUv2MouCCQw/5XUlgR19WMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB5l5GBRPRWiO482AfcO78mhkayM1mp8YKt9MT9soC4=;
 b=hL2XjWoIYjYyj+yirB0sr5gR4YiDoPGssMGABydrVprPFXQy0EGoBMTPej4Wv3KyGlkRJcWpsp3dqD+CaXE8WtZmntzIk4TmDpO7rFWiDd/TQZuy3wcS5AUDPN5ovzCoRxLQyLmTbP4Knl1Hh2Vz+wWWqIzXWdTkusZXntMKfqXtYkc5BGL04o1bv4JfaAlwxY4MCSDK/cwX6gJ3XjMpSalvdArpI2BAtZmoHgo5ldkwCQvQpwLha0e+AvPR0I99eXWX8c5G/56I8mqSYjSbbX4e7dfdWQfb95Hx9hxQD88ukUgqb9uQSBwa/KaCPjflW/F5QK0j+/NkyUktVCJekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB5l5GBRPRWiO482AfcO78mhkayM1mp8YKt9MT9soC4=;
 b=Cb1oDLMmxD6D5EzYxgt7Di4PAXRciq2/V1h/Y+AhSdOmXxHstscEJT2Px9khYB5kszKoGB/pFpTV3n47V+N8B8z6I5Wfdt6Qh9WUNC8gETvlr1hgQ+eFWmd9ywfnl3So77jZq+sgLw+/8N/q+HjsdGLI5gdeRCc1jo2wYxwW4zo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 01:30:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:30:03 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: Drop useless LIST_HEAD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzwe3fn1.fsf@ca-mkp.ca.oracle.com>
References: <49bb77624c9edc8d9bf8fe71d0c8a4cd7e582175.1685854354.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 07 Jun 2023 21:30:00 -0400
In-Reply-To: <49bb77624c9edc8d9bf8fe71d0c8a4cd7e582175.1685854354.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 4 Jun 2023 06:52:42 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:5:335::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed43d9a-05a5-4175-4c2e-08db67bfe200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKsTK2OgCepgnwAj/ZXXVhItUgvPYSSQiKBaEBYJp9X97Uiaoq91zXtt1X5RwpfpoZ/R1bh7fHGrhgzJYABQydS6j4tFITXv+sOQBt7Sq6PCSo93KwESTLDvdvfWYoCfdfHpPZ/PVKR28b5c3xWvupwBVXGqUQ88t5/JRiDhZLhJzfOaqRhQ/gir7K9gY5tsvw6ITxRfB9WhSz5Qo8W6Xe4DT0fKj9nyyvWDlFL/jFU2J4NpX9XljcVvbcIpukreLOaybAHFNQh0YAaPlkmTFwPkicAh0Hhr5hCuhjyold9xmZsvIyyUI+DxjlLAvpDF+QW1artaxO9a1QxCVZkioh0W8BKzfdhh+U7vpLiT9hQepF9DexDOwaFQxA0uHH8ltolaKlUO9PVFac4QUsyPD4FTJvrcIQR3uk7PuhBVO9mRrlBkYkbYKei92vGm15U9APmobO2PTq06wT+lrihm8oN7Dh1IPxdk38V2WtY9ZGUzGA99KybW4DxtPLqemuPl+e5TDYtCiP3hA6ZHrenbit20nL/zUINQJOOTh6aB099j60EFYxlsBWxmWb5ZDxlD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(54906003)(478600001)(41300700001)(5660300002)(316002)(6486002)(36916002)(26005)(6916009)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(2906002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3Dw92hrA50HUF5PJPyKZ5boYEuOm/M2VPf0voIqqXRvI+xmbhFdkrd0IHKp?=
 =?us-ascii?Q?ZMs7lcP0TnuzcStWTpFKsz1JKKv27LTYeJlZfcj/3JQ11J3Bv3evuKx2bEEC?=
 =?us-ascii?Q?xH7uc8sR2BaVwCmBm1B4lCgocNLFFJdIJz3SWzB4JMENr8QkwY6b1GYrRBfl?=
 =?us-ascii?Q?XQgIIfj25NlmSZqglM3ca8nUHhQf5vxeoiZMAEWTDvd1Q/CViL2+B39RIXCP?=
 =?us-ascii?Q?L1y+2ab4wtj7RkV23jSCVfkUeAtA+4/tQdpAbtA4zSGuewAT2ctm8K9txtDr?=
 =?us-ascii?Q?Rhit+swNuaIYdFNHqo0lkC9NG/0hCBwzpZ19X6294ljxhv9e8oufZ7I/EUXn?=
 =?us-ascii?Q?k4zqEh4GyG40Ce/jBb2YjSbCFM3m5vo/p7vjF8OaA41aDSUCShVwKMkLpgYc?=
 =?us-ascii?Q?2Osc1YCYCVkGhkNszwMxnvDV2TIFwWIJ3b+1PPlizRIzDv8lkIhqmXukvbCm?=
 =?us-ascii?Q?hZJ2aZUxOEp5UJIZsThD3BDP+PuEgr7O82SROJVIlRFsU/ttK1SueZgKppib?=
 =?us-ascii?Q?73ZXEpiRELpdr6pk+0cJc3EbLyhzyw3+FS4njm7TYCjusVkBC43vp+cIKJGN?=
 =?us-ascii?Q?KMErdX6KtoE4ObcT6CzZBtaL1J3iKZajknZAw9D/Bcmdd5Cuz3/GSZn+Y0M8?=
 =?us-ascii?Q?LNFKolezTU7BxLO9swc7PvpXON244p0B98htC+WmcOZLg8IgrhTADMDCbsb0?=
 =?us-ascii?Q?0YO3AePIK32F0q/+/73e7kIm3gMMbkvGsuXTdI5FSvpnU9s9PM7LMB6QhS3J?=
 =?us-ascii?Q?cpmAQT+PfxO6Mjq/6UW8DWhwgfTeLcIv8hwxd3khGy+AbPK1OjPfTFz/tJSZ?=
 =?us-ascii?Q?gd0ScIog1JzECnYa50TYtAi9KbEgyNfmXcsjglnxyFDFFVdjBT6HzfGvkIcA?=
 =?us-ascii?Q?5W/gHTlHvgSaYrwa1rhaqNQfa6Xm4HLF7mn4+sv6+T2+FQ7AFudOjpc/Aqhq?=
 =?us-ascii?Q?b4TqgGVELCiTkebmpybVij1sJhjMJKhvU9YiAfF4RLTP9RYiASg//Owz0fdt?=
 =?us-ascii?Q?BsP0oj7yAyiS8IxP0zEhsEzd6SYLTEVn75jXvnHxNvsjdFRdOqOfx7YB7iO3?=
 =?us-ascii?Q?J6JppZkodNB8+jXRv7gsAhMbjwJMewHiVnrWfRoQq4enqwrUh/iERCRzansq?=
 =?us-ascii?Q?790vGJl+zqjlN6gV2MVtbknUQqlKvHKCRnq9z7Tofq+vybaGMrbRJ4g07fUU?=
 =?us-ascii?Q?9Zw8QNZkjcw3lFgVqB7CRnUXAI3xNWuyMpR876LY2lIQuI81Xk2UYVgRPUhQ?=
 =?us-ascii?Q?UtkMn+G+HNH4iOcE+aFNsVtwPrETLk7vfTdZ2ArQ/RRU8GMkpjiGKDPvDpOb?=
 =?us-ascii?Q?YmA3Uw3FAcF89+IRYik4G49/qCzPcVmRkF3Ajq6PeY9+C0Bh6UmO8+FgwZSs?=
 =?us-ascii?Q?0RydjuQZjvq3RjcASSIdqq7TDzPWM9miOKpC5+qflwrOGEv1kL8Gm3dqEwEJ?=
 =?us-ascii?Q?ATNwO4+bDYbSroaNp8RFfLs/EOrwnfLEVcAS4cgjo8tWI/W+Adyte3N6rEV2?=
 =?us-ascii?Q?fexwOiVeho+eEVFFZMzmUWSz71wb8w8CKKqtR+KYBgnTcix0urLbYa+S6Eld?=
 =?us-ascii?Q?c4CqzF2Ms47GzCWyAmC0zq+9voUIVxY7hC0S79Y8qBu58iM2C5bSynPB6py4?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z9Mowe20Vgphucmx6shNS0bcE0oa8P9wWHs+906v6vB8tEOIlD1DGVIElWmvFeIKlwIfsBPMd18MKeqkK9W8lO6PiJkb6ZgcRp+cO5yyMYn9NTtmdhntm/22S0N8lyU2Myoc2RW4AtUaCZghEXqxMv1v7SOp4gsM0E65qBRyqJSId6o0sSyQ7bEUWICcXA6w+5Wh5ZQN36MYZg0Q+1FZhan8+F8zOPV3KjtSeI4V0RzpzRJAXKL8LgG9UDtXjBYqu6T5NW1LpYUQmfJb74BGVtwPjgDGNk6CmG6rjOYlPv9HimTgoNPqvpY+TZGHkGXHcw7uZtTRVQvatDlANUHaOovzQgsEDtID7p/i+pkf8hlSXbYQzKh7vo0acCrDbGuMtnvv6T0AVBNB+LjRLXk4kIsrsfSY8eBHb0xUDXHpyETo/VRLJP+CulzoMavYjn5YaDHsnbpZFDtz6kOGLrWjaHGW2EofSjUZgYT04lClrsD8cxp7xEHve7qvd4o5kGobELsnnmWjOWpJA+3K1Wi3oJQnbHH+rZ9b8WORuPWrAm0T3g/KOTcwGwjOAh+xSB5SDTHa+bCPqQ59BxogHr8tczvXInhKCQazZwArDlnmUpZj6kiqydOnRqkItBC+9K2gl6xQxtBGz6h14Knu8ZWs3Ux7g5+xM1FDLCkAOkwMyG7R+Uyv0OlJqWPBWOEE1MfC6QCIte5MvhTPj6vtN4hOUJSKt37dGFd9EDGCdkMnSBtBI5avJtZJxyFkNoHU3D7xI7ebJrF0X3H3FHLTxuprD019GeHMlv58HTASe7YmQrXqOK1Ryan9Bbg0DWMENOoikThrlDllk2cNhECBxVey7dhtIDu4Ox+8I4ef1+cIaJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed43d9a-05a5-4175-4c2e-08db67bfe200
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:30:03.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOSMS5Um1Pcr/PsifF5UMG54hgLaPOo97vQTvNwCDQtHBbZtiPRu4ShYONBGPDlysnutyDTw9QLsq5D7bdrgpDNW2jBH6/7DNlY4BkGH2vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=625 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080009
X-Proofpoint-GUID: __ChBTpQWsiYmepgschxUkNUIfGNyDaT
X-Proofpoint-ORIG-GUID: __ChBTpQWsiYmepgschxUkNUIfGNyDaT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> 'new_fcports' is unused, so drop it.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
