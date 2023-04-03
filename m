Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F626D3B95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjDCBqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjDCBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:46:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499B903C;
        Sun,  2 Apr 2023 18:46:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332M5osf005928;
        Mon, 3 Apr 2023 01:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hqetarCV/m6mooHRaD6fy6Mbw1ti/YFT9hArcs87SLs=;
 b=UbITuZpJaZeXMucz0VS622DsJmmvRTCeLSKjyJAdva6hn8MK4nuzDWSGBwj3I1vQt9l2
 /ldp874ZP+VkwzRQF7EOaoCrwN6SA2szaz6FJMMGX3999o5Qg/zhOLmSTHHa/ZPG264V
 lzw7X3okEmdsI0zeFpEpO539YEFRg+J0E90RMsi30mFPX/rzfeSDRhM9oQrSfNY2W0Z1
 8hbP6Padcpm4S0796HjkzmZUxUqYQBYjqDmzVTKwMt4Uu1QqdRuocTDdOEX9wAAWpKdU
 jC9zzaCPTPi2d1K1UMCo6K/EzjMOerLJ7zo1/HB1fj2lImkuSPBvXR0tP/ENC8lyiGjo cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncsxfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:46:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332MQMjG000508;
        Mon, 3 Apr 2023 01:46:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjpm9tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB0zDZaS1Gj8BSbw/xUN8LsWaolOcTbDnB2oVlan0TgbMpuF2ZAdppW4Nmo3dvKpvrGV3zZleOOy539MMFcPTQF1F8qkZK1x0UlPxSCgGJkAPTtWgdUx9UFDtZnlKETxZvtOrz+OWRB2xvU5r/fgGZjSUFSJCyXhcCOmIYTRv/PKBss3mq2wCxZ5G8o1IFbIKqCzqEx0TTsnul+xh7/zEmQ61Ey8hejQfe345/DO1pS8VIWhe+dXZlK2uhjjnXoUrIl61ilQuCIzifVgZEeP+vQN7LvNuNSOkULEfQU4ZwaJIlQd3KI34buSjOO6AepEIE2n3J9bBnuOH6zBAhNjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqetarCV/m6mooHRaD6fy6Mbw1ti/YFT9hArcs87SLs=;
 b=ZCqee6fPHRSUQI+RaY+bcli6q35IEJw8PXMZ5cfTHue2o8mNZwg6gEUebFG9ksnpTPbbhvhN5JOYTFIUpKDW8C56ArGKDcZzNJj6ZKqDjMewRuCJxgWHJByQy6fVOqIvVm2ryH5wkPQ09OOsA20SjeqP0mKUMfWzaKCLYnGeBP0ihNFT8Y3VvhuEr9Sl1ZrBCWIBMDfGNk8NDsQ8PXuZMBxIZ8Et3eCVvio6BmeI+6wntXK+ttsXis1QMUR+XedPHoH/HZ2rk/47s1Cu0f/eJvLtxYq65y6k9V1Fdn+sFO1J0Wgf/TZFuCUtXRnXOmOzl/1ywLp2O185gcdgOL28+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqetarCV/m6mooHRaD6fy6Mbw1ti/YFT9hArcs87SLs=;
 b=UAvwUAZesILk2zAZbw2n/mtU4zex2M9t6tufdEKx6usdMbQysW+ASrPH7GYtWcS6XFwRGGD0v66qm3XzRLLRxn26ityATAVtVY3vmTN2uHMyAXgkEgo1r5tJEY9kZDoMKbmSmawu03bydSWufJvpm3a7eMM9XwrTxhmS9T5C1og=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 01:46:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 01:46:02 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     skashyap@marvell.com, jhasan@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: qedf: remove unused num_handled variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt3pwxf3.fsf@ca-mkp.ca.oracle.com>
References: <20230330203444.1842425-1-trix@redhat.com>
Date:   Sun, 02 Apr 2023 21:45:59 -0400
In-Reply-To: <20230330203444.1842425-1-trix@redhat.com> (Tom Rix's message of
        "Thu, 30 Mar 2023 16:34:44 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f0924c-36a3-4f67-9a56-08db33e52e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKSUyQaIf6+JOkRT5UIWm3oxOUKceEdfXXoyyTVAcTs3QwM1AXTqWfxhYvPFlcgN8PaTNXDQYCiSOOstnXU57xP1NMYCH4Z1KzqIu4VPa60AYEq9odtJAC6tqVE7iZ76ZGJpImNUaRJsCtunbHSEm+LeAfE0rMKHOQYOf4hcf1p5pF5FU2NbOOYKdhQYK1TAVcRA/2sQksBKSm8EUjGiVGyZQmPXFVEyDJrP9I43rsB13l42h3xzjTvIex+gCuTUaI42elGRw9MotLM/WmN0xKWt640hOEDppuNInPWhog9g0JIqDYanqc0QQzvgeD8PLH22N+tzatTkFM5S/VIGw3ucwd5zcb4QlDCLZ8wXkdBSn7hL793jJ2RRauSHkm4jU87ZF/35ElnKhJybAznzzXz8zMT5VurRX/oAU2BrHBpc5DajJhixv8i7DZ7BHdqSgy1b/o6IwdAhKzYS6IleCHN4uYb5Uok0/VcMdJ0sSYbHNEzjGMmAXMp3AGlirmKXODwYCo8g+vuKqDGxI6F8JBWiFQzOEu0DwRiKCvADqlAAegDgREOE6CXBOhF55Lg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(38100700002)(86362001)(36916002)(6666004)(6486002)(4744005)(2906002)(186003)(6512007)(26005)(6506007)(6916009)(66946007)(8936002)(41300700001)(5660300002)(66476007)(8676002)(478600001)(66556008)(7416002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKprQ9fqPls8P5j+LYJAA/kCvigK8kWLeGwAAKRDEsyf46WBd5r5V3qRr3+k?=
 =?us-ascii?Q?QLe4pLyA4Ot9CshDsGPJ0SmIt2M8JmW51pxzC3Fg0xwPlmp3S92cLITkSuYJ?=
 =?us-ascii?Q?UD+QKrAnjT9AA6A7skqNMSfGAXDU4MLa1npulzw3qnWtzFE3qjYXswtHGbia?=
 =?us-ascii?Q?LPzH3OlkJsyZzw3y2SzSQm5ECcAZHBP4WeP357csbO8GRc7jE6G1AX/li/y3?=
 =?us-ascii?Q?0f6ZwFiqZ5cOO83bJ/v7jmSgHzQPrw2KnQwLNxlSEE/dJjuimb1Ye6IRmn3+?=
 =?us-ascii?Q?c2RW4NdY3TDrvSM2htUwBNmG2qU81kcVVyF/liwUsLGHNsWozw+CJ97bVifd?=
 =?us-ascii?Q?cVvGMIz2XglRkZ286cJFXhqjJLC38gFNOvYIKqLlppWg8TS7BaJusPFqdm9y?=
 =?us-ascii?Q?33G9iQ9Utym7bSghAqix47UBT/xZaAUVaQCWBaPOaQc3HV3QfpwtG6I9CeyO?=
 =?us-ascii?Q?ZIzA4IToc9G8snDvhfLeWdRfDKe8JGKPG+go2EaO/QHootIX6q9fR3RVPVEh?=
 =?us-ascii?Q?H6Rw09mQFs2Z/wwLGHfZXUurh0n74VUXKZJW+sKsGVl00yaqnVZgePNA7QTs?=
 =?us-ascii?Q?u4QWPDF8ei187gbpNCCRcx4O3WCu7HLLS5dR2uvfNqT90OPhkQc/rGTr0ANW?=
 =?us-ascii?Q?jgK19F2mkxyQ7k65srM62vNvfme8D7cjhI2sh1DONV/ohNLefMXVp+hrqibj?=
 =?us-ascii?Q?C1XUXNJMQcxshIZfdvAHiCqqezdOjRm+otqoB4YKqtPhpT+mquX6Jg6x0dmo?=
 =?us-ascii?Q?gOuhKlAyBMy0bevdr1QiEbcF6BQsrDdwLRISu99JRXierFf3c15enu4Tgbj/?=
 =?us-ascii?Q?rFm6c8AMyfJ3Sf8sZStsm2UTv4INqhdAT4hTI+VskvxMzmjEYLxPi9QEpL5q?=
 =?us-ascii?Q?PpGQBCrhp6RqSRhbB40OKIhsE7q0hJgnfwgSpgLURBFdR5MapsX82e7XAAW/?=
 =?us-ascii?Q?HRTPtbZiEsR4llY61oMFvOKIJa9Ubwrkka0NQqJ+FqZv187A8RqpLHhyYnUN?=
 =?us-ascii?Q?RiyAHUELrwQabfpezNZcnngDwJTbTmnvwAZQbndDf86YeO3EJefgCUkT8Dvf?=
 =?us-ascii?Q?h4+v0i97Z32rGWD1izKGGTzAJihW8T3Y//3Eqto6k0DCg+ieeGuUBjzRvzFQ?=
 =?us-ascii?Q?C3z7RsCLXUoP53AM6KXruj6m9nxTj6vGZScpdFQfVjhhfGOkpalqI5kLN4n/?=
 =?us-ascii?Q?EgYSN5Ye66tAEn03LvKbccBOp0pM6WVRBa9uccCkQoL4/T6lwL3vYKtXlCWW?=
 =?us-ascii?Q?7ElXnNYZRDwXpCSyRVhdHgwgTjkl1Jy2k5peMIQz/zulLo4VGnjCmprgm4aC?=
 =?us-ascii?Q?grIxufEuFaK+EcuTiuPKYNQn0IwcynrLekuNkmYzve68jWjQVtJzwoGtRlQn?=
 =?us-ascii?Q?6ncZmxU85X3LPd//bUTexm40HlFqYuo81d56xZIvbfTF2f5ERLRJ6o3a1rNR?=
 =?us-ascii?Q?N4W1sZNs8W9stVHvDdbh27/aFw5AC8XtFVJnjPr/wm6mlrpITkBCiSl8dTXN?=
 =?us-ascii?Q?/UYnpAg5D1ThWEybydc51j9Bmhb8qCW9jINd/oAdt+2ZWZyqZsDnK4v7aObe?=
 =?us-ascii?Q?L1+WVRIi1+x5HJTtA+liI1UbnA/56WKXfHMlxV+gJw2ZuYD0Axcaf9+j9x54?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aiNbGWgcNujWfRHO9nu2pLDpuusxRDZkcMLAJW0o54lslroBmst5rGqkEuBG?=
 =?us-ascii?Q?t5/Ak57e4xoMbRmujX1S9vNksCKRzdKmMkWpuZ5Rb0UZ/HWqy8m5EE4YP2Wt?=
 =?us-ascii?Q?ZwGyaEXfHDDMOMLf0gfTWzrOnUX2lOj2xQEvAW1UUv8svvWRW9cOzXqTPGQf?=
 =?us-ascii?Q?OpDzeTDkUqDH02RAjKAsbglw897w/VEtfcgkRSdBdUXFjy8wTgGqbOUCdrgU?=
 =?us-ascii?Q?8/JNrfqW/LJxEO7fDS905j77IySAA+ZwxjSsP3PFr2o3vag/DVuvG5DzZ9fW?=
 =?us-ascii?Q?h+pLUxXmBYqAuENxDs8A5ZCBDwztRvjkuOh5zbBdCV2A4yz+sdc8O8EV/BtJ?=
 =?us-ascii?Q?HvMXkOCw7KzTM2VKsZpYOc43BvRaWd16n4/VBbFf5G/1boRr2RYAtVEQ27Ad?=
 =?us-ascii?Q?lWnbZSaK8nNkzAVB2H4tZi9LsjUvpzrLGPxC2ErGgK1+QQHKiaE1G4irStAL?=
 =?us-ascii?Q?TRyYxlRNMIn9ygorPM0vvY2pJZ50Tw6vsEmVlmVy2IsD58CnKfCCjDi6dMk0?=
 =?us-ascii?Q?MoC3zyodFXJyfTdUDvmEDC8DMSj41Npvpwym1+GYVVtREfWFQb2IAXJ1vmyQ?=
 =?us-ascii?Q?SoSfrGRwxofLP9EoTVRn6vfCIHhm++2THxch1SYvK2JnDtZnrjCHffFb9TT0?=
 =?us-ascii?Q?My+Irmemoojwqu9EcD8KhHAjW3iBv9RDOu+sv4rp+5tTN1TUsuXudtEDhbaN?=
 =?us-ascii?Q?B1gfZMQL/6T/mYnHdK2cZg6O4V+Xjub+EkIQv38yOsAfVC/TkpttU7XtCMaF?=
 =?us-ascii?Q?sWNk5Yrd28F06MGmxPifMJKnVK+tOlUPEw5PNZIGP+PibUtYUtg3Q9mErAo9?=
 =?us-ascii?Q?Yfg4dQmOFwu2k8GoiS0gIS4fDauvOWZIvkXtHq1HdmpAyBSNamAnfW0PhRo/?=
 =?us-ascii?Q?9tTDlo3topiWEK0OFC1jMvw4nBZ59ibUuL7QlXydF0ttT+e/XSWlYeX112of?=
 =?us-ascii?Q?uUNcUwdO7KGnEQnOMtL4Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f0924c-36a3-4f67-9a56-08db33e52e20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 01:46:01.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgmHScZfdS+B6PfK9jC1rFQ7In6uZE+KniiRssxPBmL9UmZCynF4VgIS/ZTGXSAyAOUerpomikGFebTI0Khrt0PDhCx+kPDQmv7KlhMpq6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=709 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030010
X-Proofpoint-GUID: 5FgrtQJxyBlyCNXa-nSI8JmBItUvfrct
X-Proofpoint-ORIG-GUID: 5FgrtQJxyBlyCNXa-nSI8JmBItUvfrct
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> clang with W=1 reports
> drivers/scsi/qedf/qedf_main.c:2227:6: error: variable
>   'num_handled' set but not used [-Werror,-Wunused-but-set-variable]
>         int num_handled = 0;
>             ^
> This variable is not used so remove it.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
