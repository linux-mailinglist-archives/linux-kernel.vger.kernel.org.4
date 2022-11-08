Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D96206FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiKHCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiKHCuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:50:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4432EF2E;
        Mon,  7 Nov 2022 18:50:37 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80Nm6O014110;
        Tue, 8 Nov 2022 02:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=h+bnonTzNfppf7tOpTbg4GxtJfy7yH1PLBiYSB6AEP8=;
 b=ZzOCtaGZINnYeHRJYZ7kkuXRx5Z85MS90pGBuDNCdRWS/9nQ73KcPqj/VOiKTsLDsBMH
 IlR9qvnevpT9bMpPGcbPHsLmxBfoBsPKb499P+jNBy61GSMKMgbHd2Z+AF92ype654Ok
 4uiCX2SBk6Ye/Fo/cHVWP9YO7aUi7O48CisERqiWlVBQA87YS/d1D/e6wH/0a5LfBY8p
 kCpswTlD/5GP3vpzvqaqU0mEFYgcMBrULLeNeOkstt/GxuC8k52x/gxMEjFdDranmEiC
 nS4d2JCN0yROwca9hM+eggHVg17S6qR+9n/6twuku9vQGo/OXd8+piQXw8f1eG0MjZjz yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj5ke3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:50:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A801ETB030126;
        Tue, 8 Nov 2022 02:50:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjx640-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTDXnk35VyohQT7W/8FMG7AIj6YD5LGywsNYOzWkgcp6SB5ilGkOXYfFd9bphxCBNwq64DmwSzRx4Yo0Eb7IZP/laGR5VvM9gxyY7wZLCgK5oCqxfaiuMdxPZeOAaK5O2MNb21EIwvR+xbryxmBJqEpJ840xas63NRRItEM0OdzHfGpKDIemIs/Kd/rX0uZZj5REzM8W3G65ioF+wNnHuLZfKwuRlg1akrQtpGvqqNIDGABLEtToVQCng3I+ir5L+62aRa6ksGZWXc+HmjFRogNu4Jciar6CF8L0RiolALqUJtdcAyp/3kUNYw4EWCUy7ajRBHfTiPdy+lwHbfntNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+bnonTzNfppf7tOpTbg4GxtJfy7yH1PLBiYSB6AEP8=;
 b=iS9ZC/+iFfCttpv3hgSYIRUFIrklWQa5/dzvckUIj8tanY2Jx9JLSluDEc8zoK+66EfnTWCxPV4sceZY0WxDpxGWuu1I9htRA7t/+oV6vOd41PqeTuC97ky8RGU6pxFt81jUPuA/UibTqyQvyCoXPrz9uEQFjGQnNcZco+wGdTIBWlOO4lztajilRK7LgMIXq4cQ4PjAHFGcGtFBrmlHLQQXVutgwPg4rPTNeWoKihZBg2OQ5IgNeDwtQn/4exMXTgV8onGS/4MowsOrGUcY+KmA/xserRbkRkw+6u26HTEpc3DgHchKw0Hs2yC/TXoJgQVW1W7eKjcVgHA0w0q0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+bnonTzNfppf7tOpTbg4GxtJfy7yH1PLBiYSB6AEP8=;
 b=WdT9VYQCwGta9IADxFb1lfEwCfUWsgoscYusF3Yq3k2RBeSgPTaoG2HB/h9iJxGIKF2zAYxDyIZm1OPSdDbbF52xcsNX9ko1bmXvSXLltwtR4Zf60v5kOHEcwWu6PDKtSbyT1Xq1b5wq6u+cOjdujsLKiBtg4I5U/T+7zlK5ReQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 02:50:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:50:26 +0000
To:     Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k046kwyv.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
        <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
        <4a1da181-8a54-d2f8-6d19-d9c1982ab044@suse.de>
Date:   Mon, 07 Nov 2022 21:50:23 -0500
In-Reply-To: <4a1da181-8a54-d2f8-6d19-d9c1982ab044@suse.de> (Hannes Reinecke's
        message of "Tue, 4 Oct 2022 08:00:56 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:806:24::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a0d845-13db-4a18-109d-08dac133fd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8417L/uChIr/C31p3OAASE7ihcdcjYB640qQ6LcHurQZlcEh1IzIoE6OP0DZGbyyQU4ELWIO3XEXEOu4qfDjrM7dNQJEpRqUM34Bmxtg/AOPJCuP7qISH/Ok0+m4Gx7YJ+S855/Qj0t1QrsBxhlTo+jNN+m9pylAzV5SEkLUNnA/vTQg/yrUadOrt/UI6sIZjpcAaVXFVY6JH8ESKtBL79rHs22DbRBMYc3ULCCyK98qau5K5vUPrSv2WJi6jibw9wGPE8bcf16clTqhnmnppEtwUdUG4dSXEAuTtnMty/jivAPV1M+8g+XbkDX8gLktDtQo8uBACMUoe1XTelSTGtz89RAk8rSYbQs45oAsPi4kTTiR6OvZ38jAq6ac4FpodC4nS7yy/rglM+4UBEur6oLR/05mA4JyKajHlpu9OJsak07Zvy5gwcGWs5OCr+1I3aU7d64aE79gIfLNXvYkybQD4s+FCcqGDNMCZm8o0Di/FvRku+Cyaok8dxcO698RSsj9AOaWNTRQafTCZcJRl8+5SF7FjuFacuItDbiiIPdcz61hXXSf2PivcPLcRMIwohpIMon/3EgPmA/CtMHQDeVeJdkq4cb5zae0RSHS2I/gz+noufNSu5teJy7cmqAWnJT6/r7S4zdtu4strcfv6CIsw+DzRf/6ZIHyZHUlHxED0XG/Ii2FQZRq81Vl8qzq/OXwVnzq37+PE9O4SrOXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(186003)(2906002)(6666004)(38100700002)(6486002)(36916002)(26005)(478600001)(316002)(6916009)(54906003)(6512007)(6506007)(86362001)(66476007)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sx1X/Ru2Ln2k/ldiTpX46cjkEvkySpf2LwEOlGqDhAJhSmh0IpkoltXijmJW?=
 =?us-ascii?Q?KvTA6yaRvETgp3nsBNGhmXQgWCmNqfOtfPMDcedlyaiN1mkH9+3eCMtNtahH?=
 =?us-ascii?Q?cTelKnHuw7L95K9NfkdHBLlNNIK/AmReEIAEwdJBnto7qfM+0wndlI1AREAZ?=
 =?us-ascii?Q?5gHT0tIeweaLX3CA4eJk9eqLhJjurOYlsmo2iai471DHadMZPhbbPKpam5pg?=
 =?us-ascii?Q?nkU1ITUImHWW1b2OQtOJctlazhyT9oqUuNYQd/URtt5GNcygxWQXTZHO3WUQ?=
 =?us-ascii?Q?XtdGzhYGDLvvCQ92iOoenLNWSkgSTEp2e2cJ29CXk9ccahPsDKjIC8TiSzTZ?=
 =?us-ascii?Q?yhZyjtESsdcI2IS5cEck9D4Le3SjjOwfzpHAoy4qx/tesfq7sw57Ie5K2LA/?=
 =?us-ascii?Q?Ku0IFeH3RmNmn+Qxi0rOv8l7XlvLSB9Mxaw/BSPK7G5DtGw2kX8C7//8yMDe?=
 =?us-ascii?Q?HpDKJ+1ffbeEgpevz/C6dKDoO1AamuXRhNTCs10f5vZqnhlh87ALfgefcCf+?=
 =?us-ascii?Q?ShOJ71Oj0QKahDPejhdxM+IBwNacB8jgrUBfjqMfgYOpYtdGGJtWvF1mdfvR?=
 =?us-ascii?Q?9eAD4ZZ+EzW0x0MHhjGDDqfUkDiSZOnaucALPd+UcsjwS7JAARQ1LxsUMHZQ?=
 =?us-ascii?Q?JEvxe+dhjK69CI53UoV3t+C6q6gbpL0aw2SMkw3RPC8LvBlEc1jfp1NPwZ09?=
 =?us-ascii?Q?TdL/KoHtn4zG4+SZu6p3GN8IeF1lgbKrHsuADftaIBxrX8zV5XqUcKXdqSVN?=
 =?us-ascii?Q?WiQs8DJNaj58dn5RHv4EgHzLtU1kSYNnkvSxeLes7SV90Nm00KAc90/HpxGv?=
 =?us-ascii?Q?KfZXGoS1nfnw2aoIm6wVfpAcmaPRP9KMk7VijFT/veYUGvd7/o9G2p/WQZia?=
 =?us-ascii?Q?Sl0BUcJyWNqFC41p5gduHWEg5lvVNnTrdVsHEcRByM9/UG9Fgy+wxpTLhjHP?=
 =?us-ascii?Q?lG0CdCB6cTxzxdelGQV0Fa3Y/l4VvPxitRVhhDNk4SZxuAWNTfUn9VBE9bSc?=
 =?us-ascii?Q?V6VYj07DJnx2k97ff5ppLQuaIS77uJ0o6GgA+f5Hx+d6Egf0VMwIpOq5JvbL?=
 =?us-ascii?Q?tdOIpP4J3hdNpMIepd6ZtFDSHOBq4fwg1sQfHjpjoc9GeyZUv2w42WjZfIdy?=
 =?us-ascii?Q?M0osDSr9yRlIZcntGRCwoXEcAl6H7EOMBP5uraVVCbZHhHBZgufPmWDVXvkq?=
 =?us-ascii?Q?gHgT6rLAwNmWk03+QEyj0h3IHcsuqmb/0NtPnF1IVVcJxVligTIkM6nwGv9c?=
 =?us-ascii?Q?g43zQql7Tmc2y6CvwtiWUQH1kJCWomT77MfrUu49l2khW2jItrCepFGxRTJJ?=
 =?us-ascii?Q?FTPCFNQ93XAEBCQ5cFw/CTNoaJDiVL4pRhdtdeGCJyKSq/6Mzt8Yb6Mzyg7q?=
 =?us-ascii?Q?OFq6sMtJcbD2Nl6h85aHqyz2FWh6/VKd40mlnoiiUQKjHaBu4WOLBHVSV+lR?=
 =?us-ascii?Q?88XyZ1B/iFuLHTD+K52ndfV9B9rNOGaWzpFfLhYJfBZOPWrNmMAh//Zicc/V?=
 =?us-ascii?Q?jcwq7gjmF5VM5hfMbPl+i+lqIX5yzKWcy63VwxzBLIaODqhF++wPvq9Xrzsx?=
 =?us-ascii?Q?/XXBqMbWWHm91K6xsXjf2zxAOMq2mKegVS6fs2R/NhlVI4RghKcr8ohNddxX?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a0d845-13db-4a18-109d-08dac133fd4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:50:26.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiwCkx7Uf7Om21BXeOqN8hyQMhAENE/L910rHTfOXuG/Rk+wCEUWzSI0dV50w4jRmAcJfmBCnrED6Gjh9ASMs339tvnvRC0GUdnYYnsEBIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080013
X-Proofpoint-GUID: srk9HCLfjpRDGNSX1L2J8833UDX9EFcv
X-Proofpoint-ORIG-GUID: srk9HCLfjpRDGNSX1L2J8833UDX9EFcv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hannes,

I have been contemplating this for a bit.

>> Has it been considered instead of introducing a blacklist flag to not
>> use the reported VPD page size if the device reports that the VPD
>> page size is zero? I am not aware of any VPD pages for which zero is
>> a valid size.

That would also be my preferred approach, I think. I haven't received
any bug reports about devices returning short VPD pages since this
change was introduced. So I think I'd prefer falling back to a
(hopefully small) default if a device returns a 0 page length.

Now, my question is which VPD pages are actually supported by this
device and how large are they?

> But pre-SPC drives will ignore the VPD bit in the inquiry size. And
> these devices do not set an additional length in the inquiry data

Can you elaborate a bit on your experience with older devices? I checked
SCSI-2 (1991) and don't see any indication this would be valid behavior
even back then.

-- 
Martin K. Petersen	Oracle Linux Engineering
