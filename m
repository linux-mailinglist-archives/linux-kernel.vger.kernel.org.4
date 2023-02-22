Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CB69F5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjBVNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBVNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:48:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271113539;
        Wed, 22 Feb 2023 05:48:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xQaC003325;
        Wed, 22 Feb 2023 12:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ZHUAz2bhJhnS6t0nTgcmdMvzJgsFyDQ4/PwsowkdRIc=;
 b=oT2XpeQhEdN2TETWNjrPydBO+FZJPKTGvZGJf8MjqGijwwtOm64nF1nCGZrAgD25jfvN
 ixG8M3QydRSrq2A3+O3dbi3Ars8wi3cNRrEizGILAaueh0TLdjAm8Qf3D3N0BnFK83dd
 fzUJ9VW4fodCyJOVL7ROZMsqex3s+Dalg7Y5dbFpsXVlr4nGKVnmu2xCNDCxtCUHIfiJ
 2NqQKzN++Wnngx8n1GX6j2ujuPESrUur6sOUnQ+I0dN0CeV34aoMUxYVENgKL1PeBzkn
 9mEk7Q/MUspBLNMN6gDm8erQ6kWPlW1yhYiXqYG30HIyGBIXwViBSAGYBt7KoEUmlX6H wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja7n93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBleaD027309;
        Wed, 22 Feb 2023 12:16:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46r07e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRsx4OE44cI8zhi+ZBcKkPr3G8ADqWNi3f3hgI7uIM6QCqmgYtWiJrFELYVMpIBdeB37LI5lezWOKeY/6Ednb/GwoogeHOV6+74GNYuVDSRmJ4jeZN/OmFW7u4Xw9pc1q/j+AKmBQymRVD/FJif77YC7jLoJv4lKDzeOnC7gqIilv91ntOz1sDH9EWE7wCrUwA6O5K6dSULwS8qs0h6AdTFUVzIq9pMtT+JpEqEYcBQx0qG6J8TAUbfKiiKsiQOkzmOSDafK1eCffodpe63Q2PdfgRiFNjatx+iFTLkPVLC+wGQ8d9q+fEChfi/z9WU//Mi52xFFRaKevQ9YhqwFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHUAz2bhJhnS6t0nTgcmdMvzJgsFyDQ4/PwsowkdRIc=;
 b=EpYR2nosLch86OSItOym4HIC+vcd+7n15Fn54HRfJzpDdNO495UHiXOe5SJMb4UGnchOPTipccJce5whkyYVqmz1Tz5WPWQcjRhGVhSKcHLrgiqJvnfrUanVekLc30Jn3pVG8i5kkqF9oAQ8z1P2iAmFjLS88d6uOCqbqmY4nUYUJdcPItctnn0CSgN4d39t/YjDOu2+U++fghlllVig7zVk6tWuqM09Uw6N+irDN2G0EZebdgKZZNvz8aNVWE58KczySImhjufSCKdo1iZ4zLoTC9/WdfbcRSP3ugSTxo0C8LOWnxzbaYeCIxd//lcArVeZEtGsJZ8bp3OB6SpegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHUAz2bhJhnS6t0nTgcmdMvzJgsFyDQ4/PwsowkdRIc=;
 b=He723fKedc0fE/k1fcoVBsphX1JtJfdUlYgLXXnbZsgEciwXy8o3bt8WPE76wtLhN9C6RNNwzEd1AxTdnDvPd97MIm3gfdDLky3dnc7FBgFmSfv8qsw+NOeRQGtBW+msMo34FvD7OrN/q0T0PC4nj9K26hBxWxSoiPBKPrJqmHw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:20 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:20 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 17/27] kbuild, crypto: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:43 +0000
Message-Id: <20230222121453.91915-18-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 48581092-a258-4b9e-3911-08db14ce9b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZnPSBpYs8L62gXcdgjdu8lA9YxUzUYH9euLXjFXI+/P0Lz6qY2nTd/iBkZmDn9iMEK9ryEOKSPJGvuZ/HgUgyhUIGr9CsifetTutgUajBZu89hkSboQBmQqxRP07UEq0uUNsEfH3HtpW1GvtP8+CBYgGcnMebrRQ0zlIOwHh7OuMoF7XFG9PPTBUpqEFAtxn5FgHM3a76siIYjrBf2rGDsOYR/VzMq0KddWI/F5yYnptNzrpva8rQyb1DmO9Z/YlF/eJKwmopGM4PqxrbaaMqYI2QLUrGIWQ9/Zwjpb39fUA4KXxtogjTpGQ87wpg+Dd7v9K3PWQuYGqrISqKT26aHnpV6rsd+X+fnmqa8svRGZjf1wWjGYfEsZOd0Io/jfi9UCGSVrrqCDslM1nVMWEWIalasPrNKVZC+UbB0TfN+QxM8w/GfGDIKXurmddTL+g0Gn1YM4W/+7o+9ZV3wEpy/AhI7uG9qai2SOXtSXyiiYtE2nGvn7m90aClhAOAPsLwQLjhl9uWTIDPLvkiKUUmBLsvuOyAVRk3vVbPdWrZiz3t+O28/dZ3MBHJbZiztLJ88xnJijm8Iy4CexrkbLUdVRP6Gf8iKuu3idDnvbpzQbeSmcE7oxd8/Z/pRHCsZYjSwAq15TKOW7SugQdpyQKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(7416002)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XqrY5+4YCOMoUDzeAOZHVpRrM6ITF98tn+jS5JRp/dRLQuCSgRUupmAOZVrc?=
 =?us-ascii?Q?xKbhDzuFPI+9zSs8bT60MghIfW99sEx9MCQn4z69b4q5/DvhpGa0A7JCwRbE?=
 =?us-ascii?Q?JYkTrtg3bcmFDpCvDfqnJw2CabvjvP4sQwoVUrs9tuevwU5UliX3oA9bmLZE?=
 =?us-ascii?Q?+hsQkXLuTgI66S3kLszWb09v8f32vNfB06BfYEckZxnZKxZjLTtGq78RLe9Y?=
 =?us-ascii?Q?nX7vZW6J2aoHznFpyp52xxKA9BM3jBi36gMGrhIvI7XkMS0vMKWoAksMmrkI?=
 =?us-ascii?Q?oDNwjk/He1GZIoalOHBGbc0Q1a7sIDaJTyKBaCbgSXxiYUpsa6R/h/24oWiZ?=
 =?us-ascii?Q?mMqtkK+Aa8K1erbczOfno+dAADwb2UMfheIiBsuEGcH+aCUz6oc1Q7u4ODBK?=
 =?us-ascii?Q?6TViW4rauEWS0h5es8VlroZLDGZwJeG6xWtKgaYssiALicN0IHD9AiSvZw73?=
 =?us-ascii?Q?xNE6ViSfzcZuoa0mmQwwI6jtQ+Kxyq6Ei9RL+E7FpVuXUBOJ/XkIXzz+R2d4?=
 =?us-ascii?Q?LGaaR7MAEAkZVgegcuj4Z8qyAiXO9Ngaxxy46mRO3D/yJ0M9H7Ez7rQ5z7RJ?=
 =?us-ascii?Q?GJKt89IjE9Or+N7WsT9TfdS5c4btEjTrSqhfPoL9Jw8i1U9fCYAOpX3FcLAB?=
 =?us-ascii?Q?/Jyn3492wS/QE2bGCoXGDGJs1GA93tBSOH4kDv5U8gEyTucPSDjx4D+CZmNR?=
 =?us-ascii?Q?/3kDX8afyn+XHHIvucyivv475vFQjIVutxhnX6QEGCOTMeBHVDXJgYJYgtqS?=
 =?us-ascii?Q?9CxpOnNOVSYTn1GJhXD1PbZguDNFijMZHAjUW8RATp5K1shUy5FzdkbMHHnI?=
 =?us-ascii?Q?c9jZ1ONEkViZn+iaXDd6eiHkFmq30afq/XosBLbTePpINgOzMUPwf80fiG2U?=
 =?us-ascii?Q?kXuPk9tuFfxi+FA9rTTGUnotCGfGFvzpQhFLSjnU7JGllx5iyay95tYLHHfi?=
 =?us-ascii?Q?8fFg1zJEEk3zpktJN8vKFd1s6oW/WMQ4JBV/PKKrH39XQvB+SR+xqFX3qF/n?=
 =?us-ascii?Q?/iJjeOfl6HnMKfyRGxtpGU7cOXMyfevxkPRkRjwhqkqUKNB1FEX71zF7DKdI?=
 =?us-ascii?Q?MDKveAS0FMnBfV9Fxh761qMlHCbdKAk0U+3Chpssnfx2LEiTZZL3moZFQyhS?=
 =?us-ascii?Q?Ph5OUkb+rnIryANr/7nYAXRS4fWi571AujsXhy8fdAIwILoISy40C/3OoV6Z?=
 =?us-ascii?Q?HwgowDllPaSX9zpoRtiPqjj0jihg7UeOqBnc7E4qOWzTGHpIxxWWxHvFp/gU?=
 =?us-ascii?Q?5zx+MVfWlrzpJ051BazmJoOp0fCnXRFlFoxkzeTQW8lfjzfMR4M1GRs70Qwa?=
 =?us-ascii?Q?ZInZzdXkXR4NN9a4mHl2SUIlZQL1noVuPzBmOOOlQ8Za3C32AZBkhqGaQIPH?=
 =?us-ascii?Q?k53+HKoG4MHx0XLBSWtSNm+UC1exn55Kerqm+LGSixt7HO1XbnohXBAL3ATi?=
 =?us-ascii?Q?tRIDN+rbSeyQVyNDoORMq9Ja9GP7D10SIayc3wlJc/pWAsYcZcUxSzu+J4z4?=
 =?us-ascii?Q?qCZrJwBH0ASCJ4jEUx8grvxE+IcD1LTs0h1JrbZIfzl4HPSXPAPgRBUqYrVG?=
 =?us-ascii?Q?Sp5duQblk1OgTuL9OB+QEaj8rzp87NqPYAZXuHZryi/NSldncmTLBlOVzYjF?=
 =?us-ascii?Q?h+cMy+WVQyZRAostJvDMR/I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2BKw/XNTHB38DwzXviw3DRhuc/75Bhiny5CHd+w9h5TY2+IERuV1pCAFnEqW?=
 =?us-ascii?Q?+mj1mB8WeJJeV/ZU5Yy4tjToXj9vPhm2S1jvqrRMxcMJcVXdnlp53DZILs1R?=
 =?us-ascii?Q?0X13u3XKBjWncmnmG+RBik0yEYTWyqau/zWAxcX0wOUHUqO6tYHmKssoG0Xs?=
 =?us-ascii?Q?U+hS1VALxHhzApv/GZQhWlKo+MDqXuo3nak4ejMkVU0Jz2F6j3XS0ECobELk?=
 =?us-ascii?Q?TUH6VnP1aErCbSNZOOw7DAqKy/8qliXDl4jCayh1lRH8+zz7hWY+73R56KF7?=
 =?us-ascii?Q?iAJxM6X9w7TxmlRcg5fdkrXuUJ1L5qHp3Mw7jjRB1uv+maetNWig6XD1npxA?=
 =?us-ascii?Q?u7zI/C4mm30YLrtEXH2T9a+dOhF1ZMBiQWSXSKtA1H9psc8uprstjorHX8TF?=
 =?us-ascii?Q?zmhdGAp8xQoMYNab8CajXSjE2zgY51U6NApxNJNf2FNQl7ZUx1E8UeALAjY6?=
 =?us-ascii?Q?HUMmcciKCqDMSbXgfCyhcCzHn73bBUzxps1f4V231N/JoeYz298+RszvRGhD?=
 =?us-ascii?Q?G3ujdolEQWTlIXD3Bf2Fr+7kUrWJ6VACzOX532Box00/HCqIwQELKwilbE25?=
 =?us-ascii?Q?r9PZs9A2GdqvsI9jxixu0Tn+vKvL3zJLCOVIZ5RtIqQRf4LfaNLtjlW7clV3?=
 =?us-ascii?Q?erLhUMDJiJQJwHlXa7DwETN7wbd6+YU3iHUyy8dKYEib26ihXOcfQGJJdqtx?=
 =?us-ascii?Q?vEoXjq4vJJj6vO/mDrn300gW/vGro3aPCCLGIp+Mc6uQeu/UNnsYtetiyFPJ?=
 =?us-ascii?Q?AtHQa9/ve6MiVSdrgvrrZ/7FSCpNdV+yDqxRRidwqAUwnq0OBPixGP5m+C8a?=
 =?us-ascii?Q?uU4Y2gOQjEC/N8YKl90PzjH7qomwUmz8Y0yarFEYb3OLtZ4HtGESyJDE+pIh?=
 =?us-ascii?Q?QDammo2rGatlMG8RIhADhtGbO4Sd28aKAdszwnt8pRICd724svzhXTGk4Ne4?=
 =?us-ascii?Q?Bel8dGuwoQayRiV0udsjKk/PIFVuhjnUKRY3+h/HetMsFdYJdi0LfeO+xinX?=
 =?us-ascii?Q?RvFkT1XdPAm8FCAS8agqDyRH0/tY8c+bGUKQHiLrm9RBWhw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48581092-a258-4b9e-3911-08db14ce9b38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:20.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UXXPKXqlYMnt+vho5VyJi1yDS75WJ1xfeqh+NS/AmLPDUElnNk5Pvqm7JQIPfOplgp5pQKks6+k5ZNiJBI3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: 4pF-3LSQT_SXBXjYE2KTVotnFpvHGYdD
X-Proofpoint-GUID: 4pF-3LSQT_SXBXjYE2KTVotnFpvHGYdD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
---
 arch/x86/crypto/blake2s-glue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..0df9ec15643a 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -74,4 +74,3 @@ static int __init blake2s_mod_init(void)
 
 module_init(blake2s_mod_init);
 
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

