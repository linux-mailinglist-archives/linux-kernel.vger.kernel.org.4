Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13216CF13A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC2Rfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2Rfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:35:31 -0400
X-Greylist: delayed 2207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 10:35:30 PDT
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6CC5254;
        Wed, 29 Mar 2023 10:35:30 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9jR12019666;
        Wed, 29 Mar 2023 10:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS11062020;
 bh=TeBRrxVP98gppJsSnl2xZNL4b5lg+cWJ2z++Zg2+9F4=;
 b=qwwGqbsJaGXbp7zTq4hTnuvLk5zImQPNhF7Qyj9NsveyEuYSLL8xCOvAUpaChlRbWOlT
 RAj0xvSBnL5rI7aviP7yE3pEfMrQ3+8aAaPmrtk2xW/8H0l7NFsrgXjxp8Q+NKiHxx98
 PBt5K0g8QHgiM2sB8t7H0qfA7cOojXgwWXESupXOkbrQOejCiP/fAo0gckZ0wnLtUak2
 V3QvM/cpuM623O5kyVjDGSQSoV4mhxTU+1DVT4pqTNL5N6BFLdLVwGkj8wmvg8ebchrA
 FLsxysYiN3AEqq7vyB+mW+XsrRSnclsF+2ipdWzE7Rx2lnlZpgsWATm5IFF0yk4yEu9i WA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3phw1f83f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:44:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZmOIbGXoQ2SdnWoORqSmiTGes8dL6xDoZI7c4Yd8fPUu5yHMXBOQz7qoy6lsoPxsdCzp/8iXdBOW5oruNr+ztOjlQ8n7GlDI4f/EBYWoo8wdDINqXRVyt+epcV/FVw56M6CKboJ6arL4lNxr8jmU0ZlArV4754BZLCv5K6w80pDEmJWUIlEQhPhMHXkibHyfOC/anvA8oomLUGioLRn7Hmm+CAGjJsJtPkcZgU0c9ssIzeaN1ICpVpDLzqXBHRz/ypT5iFKrxYJu8XPVLO4lYjpSJkR/P2+ln6VNsC9Uu6PlSPYMztcNY//NgsNs1TED+EaajfC+7zoxUKWMUwEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeBRrxVP98gppJsSnl2xZNL4b5lg+cWJ2z++Zg2+9F4=;
 b=nee24RBb8KQidqKje8poCK//C4wa0w94iQ9UV0MvjufGJ53jLue6/PUJsjZtOLiVIXv5sNPuSX6EXlDyD6pevB0qPR5A0u4AvEf4m6xDE1aYITXT31esQt2L1q2vlUlm7bbRNJkxFI6kof0sM4fn04cSUnG+VH8/yFAa5g/lBvI1BEg4s94ty5iQoGEoYa8+9SAWeph+3y3QSyjjzeLQNlNwLHO26zpdhr2wMombwmI/Ng1kk8S6AsodVBwa/osxjEOIDXgyAakhM7Njbf9W6idAk56LOJP6SDry/6DPlOOqwWVb7M/aj0a1vgYLM24JpguJdamISdqv88MUPV8A1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBRrxVP98gppJsSnl2xZNL4b5lg+cWJ2z++Zg2+9F4=;
 b=aUsa1UbYeOzsbBL5x2X4LdytzH81Sh+NsFyCHufe1XFyYWR0h21Clwo6w71aG2PFi+p7LeYCxp1MM08paqPbKPg8Pj3JSUpPmHdzStppSmo2Itgko/R+tFy9BuseJ4pMBgz3ZFIQ5GGqXrbLZs+pMaskN7qNggbP0xpPSIryH4w=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM8PR04MB8021.namprd04.prod.outlook.com (2603:10b6:8:f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Wed, 29 Mar 2023 15:44:05 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%6]) with mapi id 15.20.6222.029; Wed, 29 Mar 2023
 15:44:05 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty-next 0/2] serial: Add driver for National Instruments UARTs
Date:   Wed, 29 Mar 2023 10:42:33 -0500
Message-Id: <20230329154235.615349-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: b2896581-e244-40ba-ccf2-08db306c6cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LP+a1djZHBLdIgCrap1Q5liVWSS58RQko8mIAuvGUIJU5NUNmnwNiNpVIyTQsJDCpjZcsIFtyqVDbnuGj+sUQFRJ7XFH8OxXDeX7SDVsd2Nj4xn7wwcFHEgqmEiSL34c/gkzxxM7Vm8fbwX6PHX3eesVLX4EQSHsqXciPIDHaMJHZqavRb2A91I91kxR9iLiJ4qbgwz4OUrBde1bUbPtR51HVfQKVmjSvZfLxvKoVAt/1fCjYJ3+L4n1Riv3Lsonmu3UHMnDEWbzH5zWfg/ehl5BQcL5et6n2bvac6T3/6Ew2Tnx+Zc49QpD8M1dh/WFp0utmiMQujcv1LiMuT1ZJxELk/7+hmfVKflKHQ0B9uSFeja9KXuan8dvtTPg5JNYI4+ZiaQaUJv2Jc5BqnlPZiMd0RT8K1M5lhZAei34JL5ftUgeCNy4BGsnQyt+W2EhPh3bA7hU1cWE87zUeVRg1OoIKIIG7J85aC2n7RbndNAqAAp13vZ8ipjvf4MWARRM9AukcJtwzbF925JK2yW7/FulyZJFqX3aUfmwYaQUnOmKxURlK1iUmyw8UclQbeujovT4CFciRLE4ZskChgLcajptwgU8Iu4OKzL/ixb+UlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(109986019)(2906002)(2616005)(6512007)(8676002)(66946007)(66476007)(4326008)(66556008)(478600001)(54906003)(1076003)(316002)(26005)(4744005)(6506007)(186003)(6666004)(44832011)(36756003)(38100700002)(86362001)(41300700001)(5660300002)(6486002)(8936002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlSm1Nky1FtuULq+TM2+DRaqyqclnmqxGQtq8z+woemawBDywQZ0grpuwpLw?=
 =?us-ascii?Q?95vgCnmgcKcSJLR2WfJBpcwhJA64TUtWskmM9LDvpQ4sJRoj9Paxj1FyRACW?=
 =?us-ascii?Q?dtSfXZP9rbm1Mbsz0Shrm67Da/38BheYEb7fRm/d5l8dS2klvtSLidnZ7hzQ?=
 =?us-ascii?Q?hVc4ZkkhnhcfNewktHCXMGhQ/HBXVd0saTlTxPHLUqiClaeTau/AXVItzhr4?=
 =?us-ascii?Q?mMB0xEPF4sBKqbzYxhX79jFJzF5Hl6Y620G2fu7JBFWwDSz8e0IlCU0gwFvU?=
 =?us-ascii?Q?oKy5QumxPTq5eWytlui6sJg/09dUJ5Wyoat9bt0RZ31o74BUAJ/Cc5WZ9EkK?=
 =?us-ascii?Q?XwzqoizOpK8t2jPIvq89uR8pDWdk5CYxN8lE8wVf75KjDOnWQJnLTSKBbdTD?=
 =?us-ascii?Q?1jHSgEfbkw94Xwb/SpZ5vo+9uGcPuUhRvds3kLjPndO5n1TrI6opQCc0FMOy?=
 =?us-ascii?Q?qjmbmTDlUtiQ0UIxJZfzOWZuawCjU1q7ENiaEu/CEZPB/9MIzJWM0dr53ykV?=
 =?us-ascii?Q?Gz6v6kiGk6CRmGvohJx4J7/4/h/+Tu97OokVKlRC4+gqVmuw3ERfHj0++wJD?=
 =?us-ascii?Q?XaQw4GzOQ4y4G+cpflp4KBvzr2inaIBqT7i76qDsXF3si15WgGRKKmXU0lFM?=
 =?us-ascii?Q?km/n75qyXJQpJUNdlylSGuy4lDh4m7Ij24vu752urtInJKOeewf5kSqBwLnO?=
 =?us-ascii?Q?CcuXvmStPnItSRtjb3KUHUYMoM/rJphq+sORNBh5TIzn5UTgZPwui6p9ZHlk?=
 =?us-ascii?Q?tU6WyR5QF1lczlpECKhudMCtY22bR9X+zlecGMAeNaqKv4JqxrSStOrSmWkA?=
 =?us-ascii?Q?zvZJC1hM8vU+xY5Y2IYaZ6OzRha21cQx3zU/lhiklLOKztH1Gy93ECIdl4u9?=
 =?us-ascii?Q?eEJ7y2dLdITwBdpQmajLcQ7FAwl9iSWs3C+zE6lQJdIju1IYeDelbUplcfeh?=
 =?us-ascii?Q?dREhlwbapPzGlclesOE72ju/m+mChCrCi4cAbx97GLad/CE6GHKLAOOVQ6ip?=
 =?us-ascii?Q?7FeiS1w7jjjh3DbSUodczME5M2bVLV2UWAE+FekXXZJ72F7OFQL2DqBYLZu0?=
 =?us-ascii?Q?SZ846sJtO2lIJTRdYmA1HVvc9xqg/i/YsJm95KzyIfdfunJ538jGIhLl70t8?=
 =?us-ascii?Q?4vD39BaR+HSOW3B3NlpgGIjOWJ0+bDqFzU3Sv797Z/z0R/kpRAs2EQoz1WXZ?=
 =?us-ascii?Q?6ANkyknuC14Ic8Ow+MpodF940hhWM8/KcJomkgZ7hP+xSM6cARuSzs+KA5X5?=
 =?us-ascii?Q?9XtqlOvnXSsx1hq93pSw8xDiRj+UyK9na/XovbMxCXDdpgscDHcWyap26e1C?=
 =?us-ascii?Q?CNpAUQzeM7vWAMotKU70eXEbl9IWablQzChBh7Sxxb3I0LJjxrJ7bCvXElll?=
 =?us-ascii?Q?EyXEY+9fqVcYvnnFR2KOwHBZG6D4fb+p1Rc+rzS4AnwSKt/XZ2xxq/4jFNCe?=
 =?us-ascii?Q?pdB3gXJVAiFcN2JPfrW9I2Bhl8ePkUCzhLCHNkIA26P0y9og57Exy2xypSi3?=
 =?us-ascii?Q?tciKv3qH0yeZ0K3eGBQeJfACYVcxRDu7hR+E0EG4xXkexJK7D42WGOxcN6xP?=
 =?us-ascii?Q?3T4/k+wvRZ61T9nrmF11vw1AhJWICHergXFdP9p6?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2896581-e244-40ba-ccf2-08db306c6cc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:44:05.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDDE19ZaTKY+eywalsCSFyTIB2RPmV/lMKoBIF93eTkS4TGkZm6AT6jm8bSq1+kNyHpJE4NH/VOM1/57Z1jb2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8021
X-Proofpoint-ORIG-GUID: r8zljAReNLEQyU9iw0k7vgz-ybQU4ng9
X-Proofpoint-GUID: r8zljAReNLEQyU9iw0k7vgz-ybQU4ng9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_09,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=604 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303290124
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver for the 16550-like UARTs on National
Instruments (NI) embedded controller hardware.

These UARTs have an interface that is compatble with the TL16C550C (for
which we build on top of 8250_core) but also has extra registers for
the embedded RS-232/RS-485 tranceiver control circuitry.

Brenda Streiff (2):
  dt-bindings: serial: ni,ni16650: add bindings
  serial: 8250: add driver for NI UARTs

 .../bindings/serial/ni,ni16550.yaml           |  53 +++
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/8250/8250_ni.c             | 447 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   9 +
 drivers/tty/serial/8250/Makefile              |   1 +
 5 files changed, 517 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

-- 
2.30.2

