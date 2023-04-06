Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81F6DA213
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjDFT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDFT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:59:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73E83D0;
        Thu,  6 Apr 2023 12:59:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Evj71015316;
        Thu, 6 Apr 2023 19:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZBpvWBPbXOjz2vPnktFrf4fSO1lyAB0Pgr1bL3CbSHM=;
 b=YJPpOKTJhPER+Wnjyp/wjCSS7MJUgXVrs/Lb9VI6T30F8yHDE4+A51mX/z1cAM8PS+dr
 rX39zU2JSJLjDBc+DHZ1Y2g01NzvPznYnJgcNT5A8UNFLbUoXiZ3mYXV0m8N/QH02DdF
 rIHPAJutQ2R1wjLVXtpVtULXnRtEW9MxfhyYjYt4oqLmfI61VgH98S/epDR/bGIATRWK
 970njHUOfNE6wdg5I2L1pun0CIin1YJay1zo1dN9xhVDBLvrm4YqDLJKDxEmuzmIqtdg
 4FtuKQgiQ9EketgWenMqusL59UMIVTVkaIwV4AdPmatG+zoJ8M/MIRJJ63VrFbvjdh2t xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u3qee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:58:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336IkYlL027442;
        Thu, 6 Apr 2023 19:58:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptuthcum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVpgzgRc3CsPsDjDJuzncqbamw90tjmAP8P6rJdZoVQ63NPg2pMs2K2YHk1Ir6bRaD6wIg0/97wbCtqLB6BQ7r64Gt09hD9ELkHvAjRqFRbV8+mnj9u4RB2xLiUE7kI8gpIYm8zI32uiEU4x1FR9K+4gYntxx1dEUyDQ8P0l52jpA9wRcD075MkBjUZVYO+6dWqJ49p2Sj5TCsc1lYpJkWmIsYpW/DSPbDmgAMXOi2qYB7gi17PQTxDAtHifeAZuU5hpDm/0rV1OrahUk5mmLJJOcEcVumwZ73lnvQ9X+Hxz1rOq3rvyGmT23PDkpfuvhoLhlMgRUITDu+jeDo+Xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBpvWBPbXOjz2vPnktFrf4fSO1lyAB0Pgr1bL3CbSHM=;
 b=mKCAyHzAQGWaYyzfVGtEqfDxpdkHWsEmYUy2oeBbHho6HADxPssN+vWg0CWvue3RyZeN+laYm/ZjoG1SlYS/gauiz3tH3ECEiZ/6N1FyVjWvSGZYAuXcpm9TCz4G7NbTzuB5MFAm92L32sUPIPgRhvk0nSC9K3GfXBY638sFCpdQ+ppQuN1x0BI8y20n/ca+mJe0W9O2a/IogWiRcP56qHwDvWorMFLgGLCIijTg6aw1RFiP853kUAGO2CG2BcvDTaxc6Gf0AEiP0lR/RQVc8cyVlDcKG2aS92E3zOBENMrUAfiKkGDQYqPFLWiB/WYwTzU0/MN+L9UtS+7R/ANcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBpvWBPbXOjz2vPnktFrf4fSO1lyAB0Pgr1bL3CbSHM=;
 b=bAqHglJqrD1S4YvB5+r/I15dqAKNFL1postpWOyUxwCH3MVTHPlG5uuQLRr1gSRtxs0pgPmASiXsm1992Gp/RCoatFdWMidm9jjnX6nm9OWeLGdNpFZDhGQ3mtKkE6uCFHJtmWrcKDf8/tmOm6ndILN7L7IpOFmoHm/e6PB8xZ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6601.namprd10.prod.outlook.com (2603:10b6:510:205::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:58:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:58:34 +0000
Date:   Thu, 6 Apr 2023 15:58:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
Message-ID: <20230406195830.ieiozetmk7qjllol@revolver>
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f6dd32-e099-4c46-f7b9-08db36d94df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhd9C+Z1HuNPi2FOLHto5c5PPxjuJthxBRx0y+NnoI0DKS22EXXk0dTgikFd3LeUZ0K/ZEVkXwptjTEu5/6NEGA7aosFR0jwn+qw2G7mV541bBEuGK8KYfT4ZlfUSTAcQPGq8IuXRSaZ3Iehc39Akyxd4+Y6G7nmleXaVdXZ+moSQnHYjdnx9KzZ7kLCN776tLyb+3KT2l18WOgpeuj1lLwyq2MJchD1mE+snP6bbtDMknesK4z/pXXdQwZ/JP8oTWKLtye5sorFyeTcwa8kGv7VRhJ6rqVof+py3vU4aW0zOXYx0nIwjIpJPsS3pqWjmpCzkVybpqUHznSRdbXxhvZkKNZ0rPqza9WbpbgnHCuhsNwk9JKT1YZXl+y2A3nu2Xg8J4RNq+3hhGDU9QWpgtCXz6v6eoHYQLmNw7KE5mfnHmcdxXuDBM5px9Ljd3gwamPtu6L6LeSwkj5wWsfvsmAuX7pWslUPw7eNnDs/Elo/fjtae6UPUqu7ILk86FJ4jEanBPZavzAsdB7ogsWgg5zxJlsIVDwtH/qdul6Ie6dhvzV+j6cLIqJvffXU2nhJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(83380400001)(54906003)(6506007)(316002)(478600001)(6486002)(2906002)(9686003)(1076003)(53546011)(6666004)(26005)(6512007)(5660300002)(7416002)(33716001)(66946007)(38100700002)(66556008)(86362001)(8676002)(8936002)(6916009)(41300700001)(66476007)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NVQMgbQJyeICoCY3aWaz3SI0KUeikoN8z15mdIXTF5B2BI4BZsaftx4G1XO0?=
 =?us-ascii?Q?5F8pvjcFfINflp3YQJptMMxS5fNGK6tcdKGpKnMKO5uHaII2GkBHchFRvvEg?=
 =?us-ascii?Q?MqYntnYVcN0v0h7eqRdBE7GVXnbuM8ZObL7VV3GIX7a3a+yPX9b3oInlAB/e?=
 =?us-ascii?Q?UIUzP0WCnTWsxqU9sIQ5aY8/u7sqDS/Yw581Mn/FKntf4nyFMxN+SiAF9ezO?=
 =?us-ascii?Q?VL10HFxdBe8E2BGPYWJKGCqXxUQAnZUKvsccWfutpBMknSttI9s/kTgtHVhG?=
 =?us-ascii?Q?d+IbQ3WZl28fPQqs1eE/4n4p/hDHOusJvJatsKTe0XT0BHwq0XRIM74JFSxX?=
 =?us-ascii?Q?j792ZgvNhWy8ZVYmI9PdhKFQscjMhXPVfHbUb0ES07WwsDUZyrTU+xAYwWKp?=
 =?us-ascii?Q?0vAs19hFHxJ/ajBUkOo1mBuODj4WeImkUPb9I0+ZyC79c31VMxfHun2ligyr?=
 =?us-ascii?Q?qCdsp3m+Q1PVZ7ptbQqd1kWOhaTX7YSgGqrEZs05MENCKocdhjJa94/2V9Q9?=
 =?us-ascii?Q?Ah5+R+UQ24tn/biOkFpqgwhwUvOPM7z1j/JTo8YckCLmKSll3XKT6Cw76NLO?=
 =?us-ascii?Q?6uEXZk6JWL3cOrSpDfzU6JvaSRCizmAu62wcWXIZPCUoT5vdf0oLFjf6PTwe?=
 =?us-ascii?Q?ij+18fQrsE6IDfOlcgZ3+FI2OY0MqFTVhKojlUfdcBvH08G6RDkrqISnFMYf?=
 =?us-ascii?Q?yHGFz+Jn7IuCN98d97yrwNNSjVDAhmU8J4VnFf2AHY8ecj6Wj0Sqr+3sG26f?=
 =?us-ascii?Q?8y06lCIsZCE63sB6dsgfFbg0S/llOCVodWN+jTo24J0iqh2jg3s68nrMFCgO?=
 =?us-ascii?Q?n7JuH5M4svpyPXxBxTeHIizziqXmnRXn9BhftNH5qhxudS6oi2D/0MTjEWDz?=
 =?us-ascii?Q?CeMJlvt2Cvmq0M5ogBcV/BW/bZbwMOsTTfQS9eZAc3zoPNY4+ZIvUHrQBgdG?=
 =?us-ascii?Q?9X6n3lyllWKHU8jpw/e4miAzxpMs2HW1oCKIWUGvyGWP+0jNC4JXIVoO3g/j?=
 =?us-ascii?Q?j5l3USSwgYVzNVMiw+lwdNXDuwYi4t4ZYrU+zxKuDYJ29Mg+1sFSB65w+EO5?=
 =?us-ascii?Q?xNWaK5Rb4aZz7TPhEqQmRM/jPIrqmgrfzhuTLbqdX7AMaJqSOKjOt1yt7LLA?=
 =?us-ascii?Q?gBZRqcCeh6o2xcZZ4+59xVwwyaWtdIed8I49UzE3KxeLNPAmKLb0M6BJxBGD?=
 =?us-ascii?Q?FZvObBe7/tzxul4SjFm5zXTssjxeoTOpto652rFFEL66XzarNpPqQbfxJmRt?=
 =?us-ascii?Q?kTGek45TB99WnfneSIcRh/deKqNMMmdTUJqgDxVeRRSthM7NV/0Ripgm5nAj?=
 =?us-ascii?Q?uu0KHsdEQXztlyQXs4GnRH7BzXKPP9mYJX2Ax9ZDEnr8OLrSoyfzhQFyak/2?=
 =?us-ascii?Q?xA1XCPOTafW3QfhuIEij2p45YxVYwVmBfP3PDbNla/zVm3FPXPteAoOYfSXT?=
 =?us-ascii?Q?Uq/PILlQI22M3vQDUe23jCA0Oy8HCa56vR/W94hvjdnaf5J2Le2TOUKtoSlw?=
 =?us-ascii?Q?n3PpQxnXjfDLJRagZ7/XQDQYKmX44SmxMFr/waD3d0CkKPVQM46z/g1WwJ6w?=
 =?us-ascii?Q?lST2mm4hUCE5x1CmPyBEsvr2MJUZfLXceWApcmRJR/3i4/EqE3hpy4fp/aGf?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wqviCM2WDfNkEhPuVGu1oMzAAmXs/ED5weHikn9pNj8hrGFZGEcSev0EiHdf?=
 =?us-ascii?Q?avpmrQld+l/vRm4S80h96f6MDOzgJTeQmoWngDVkOWCRsmy/boPfwONlfiKb?=
 =?us-ascii?Q?wx6Bz9+c0srva7lqeQe7oZ3BEE0YXzwvkqg0uc8XLwjOhjn4Yc6kQdWMo8ug?=
 =?us-ascii?Q?4gd3OFa3htsGr2aEW48QwS9OOql/AzDi1EzveX8uzYu7rnX9wc1UQDQPmQUw?=
 =?us-ascii?Q?S3kujQrQ5+vyDDy9l7Vi9D4TlU7yw46JPF9l4BRNjiAg8ySNW8LmeM0UBA/y?=
 =?us-ascii?Q?LRpoNWOkDBE1BEYZ6ZYiUEBXy4bbea7oEWLw+qNP85JdhgCexTORDvyN5ii+?=
 =?us-ascii?Q?Xt+Q3IU5apvKrUDLV252EKx3tWF4rsTjNpq+KOEfV4qjXRVUNAUkKPJbGQwD?=
 =?us-ascii?Q?AFjccBR6oB2qUfJ9Ej85zfx+MqacLYtGs53nV17/mBfhh5iIRnjbPyubTcAl?=
 =?us-ascii?Q?+s20HIu8g0YidalrBjOVkiISzxuDxmjolc046si1AOVe1wpZMs4gG8wbL5x7?=
 =?us-ascii?Q?4JJjBPzpuwY6l88xR5PuIrC6pnpafAsWP25iPxWFFi39rrZTmmcqB1LqWNOT?=
 =?us-ascii?Q?9vfSUlwHibbKUfJhB2FPYaJpnBvi6/sVB1tm7MTcR5d6p/Wmh4Zefw6OKANZ?=
 =?us-ascii?Q?jYqc/Mj7IimoWTKR9BMGqyAJrKEkku1LxbJMND3rm5XKUQ9beyxNTL3R25qc?=
 =?us-ascii?Q?bXkiMJCuDLMOX+eK2JrlcJvSPinESoomaFaydvvnqgYJYaDAHyvtvZLHiQIt?=
 =?us-ascii?Q?P7AsE42VgLrNfur4umVz8roMS+aLdDlGrpPDg2Sz3WM7TNpIoM8FaSNBRrX1?=
 =?us-ascii?Q?19yPSVPED6+G5/dxCLKfwbSz7GPySW3KNpmpqoqWKI6bDELB5YTdpXqyYKPk?=
 =?us-ascii?Q?NSSZblm+YPNyoaBOk2WlFX0y7WYbF3aXtLxyk2d7Ha0EdYQz58NgSm0w2ZPK?=
 =?us-ascii?Q?GLAoHDy1josCNGoFsSCvwSCeWf/QKo5utJ3dF7E9NZQKz2IdqHqbd5RA4yAz?=
 =?us-ascii?Q?c77Lq21LDuXxb+W2f1QYzPFpzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f6dd32-e099-4c46-f7b9-08db36d94df2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:58:34.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnjNDFYwRi/zXqip+7rKCDgGseGfgqIhf4VxXSvZG2dUrn+PMILnDVoL1CjB74oRyo6u4br9VKq584hhdDYfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=873 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060177
X-Proofpoint-ORIG-GUID: m_k4kLt6vxUmbJKIEqV5wCI0gLGw4IrI
X-Proofpoint-GUID: m_k4kLt6vxUmbJKIEqV5wCI0gLGw4IrI
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> [221125 13:51]:
> On Fri, Nov 25, 2022 at 4:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > Rename the fallthrough attribute to better align with the kernel
> > version.  Copy the definition from include/linux/compiler_attributes.h
> > including the #else clause.  Adding the #else clause allows the tools
> > compiler.h header to drop the check for a definition entirely and keeps
> > both definitions together.
> 
> Thanks for doing this! Consistency with `tools/` is nice to have indeed.
> 
> I see that `compiler-gcc.h` is included for Clang too in `tools/`, so
> it looks fine to me:
> 
>     Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> 

Any chance of this being accepted?  I'm looking to use this in the radix
test suite and would rather not duplicate code.

> In the future, it could be nice to enable the warning for Clang too,
> though I see it requires a few cleanups.
> 
> Another idea is to use something similar to `compiler_attributes.h` in
> `tools/` (perhaps just copying it and removing what is not needed?).
> 
> Cheers,
> Miguel
