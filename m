Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20662864D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiKNQ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbiKNQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:58:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD924BFA;
        Mon, 14 Nov 2022 08:57:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEGY3lU026171;
        Mon, 14 Nov 2022 16:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UmO5bUAEmMJa/jaqPbO2aQ1aExR+olK65zSg4D36Ekw=;
 b=1NaDDXor9g4oTnxSNhfJ4R/oRDM28k6Apk+ZeMdOKxgqThJ6SWqjjLEb1A+gOCR1JAXe
 BuT+2UIqLzO0Q0wH23d+c2KeUkYtlgfKcjjOeuButdH3bBghtTMyExTn24oo9wA0OEul
 MqnHZgzkfFkTNn0NUnYr6gKPbN/acXE+F9y5RqvHCr/ySALGEzNA7+olQ8IgNxtf6n7A
 BhaiVEWkqjsihImOPa61X5iL4KKWKS4izJB0BjCg8gx5c+ZX4d1d/SfnBLFkwXlff86P
 b3m76MpcLgjVk+r+xs8zORz6UanOtRwOAfnKyQ1fJa8wEqwjc+txj+ZCbU+5bxCr/G8B Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1ng2s2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 16:57:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEGPmjQ019257;
        Mon, 14 Nov 2022 16:57:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x4cxuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 16:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtnMrj7J34CMznMbF76JDZ4qq1MiGVJ0zhVVZqxR4/TuE/94V7A+WWQ9jNiQW1qHaxcCY1Z2fcpnB1Ge4YCPIMWAYKruHQjFRWz8lTOQFkx9OPKBr0HRrGaB2zhPaYt/o1f/0Tiise1pD0EkNDbAxKLEGWhFtO3jGl6FJbml8t1bhmJmXiQDtNs0eeltx2HuVQjOtUzzIqF43glvUsFR6VYqYKFDEtsPGNG1N9+jdqj8wktUuNDVN4+KfnuksCUJrHJqMFXrYwYh6QbO/ZjnUHqAYgNJRsWJbOBmujUlDHerjEYizFOJXtIQCLN7WXzfRfgkW5bYPto0NLRnw32NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmO5bUAEmMJa/jaqPbO2aQ1aExR+olK65zSg4D36Ekw=;
 b=XaoJIDLV97OGTErSWDXQBXYwhrrwQfTqNK91oCRFNZ4v1siVTn9LYeExYof3qq2UwIZSs/6TSv7pudJdoClBBKoUppvHUqYABA7Gjpl8ZxUTGF1buTJ/Hwu0lFROlz+z0BmsFC2ZvfKbNZgQFLcRun41nNnv2uAmBklaP67nQSU64PjIBwCU7xM15GotqqBqCU7ROcbZBmo+R/SCiNNadgwvGgKx2uhn1lKosMKPjBCQEyPGPd3xfVOPLzZsyL/2/1t5Ch6Yskd15nSG+tAuhuGTW/tthS4OFsfTeo2LWKGO+ma4vOxmCWIO+MSHmbmrgSIFc87oI0smP06Qb2Nk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmO5bUAEmMJa/jaqPbO2aQ1aExR+olK65zSg4D36Ekw=;
 b=bZcUTw9fUQgNROurZicAiilA9eAKCfihEphAxSwdrdOculErSjgMtUB4ZQucP2e/A/GcVcPx8NcL0Bm3cz+QNprulxDkMSgmx5UPTY6SoLFN2kjmuCqoO4lh9nKoXKgTn1Kls3vxMJ/X2vyN78TwgaAY/EQ76xoToohqK/olDas=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MN0PR10MB5912.namprd10.prod.outlook.com (2603:10b6:208:3cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 16:57:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Mon, 14 Nov 2022
 16:57:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 7/8] kallsyms: add /proc/kallmodsyms for text symbol
 disambiguation
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-8-nick.alcock@oracle.com>
        <Y3Bjy8UlZXdpWMYn@bombadil.infradead.org>
Emacs:  don't try this at home, kids!
Date:   Mon, 14 Nov 2022 16:57:17 +0000
In-Reply-To: <Y3Bjy8UlZXdpWMYn@bombadil.infradead.org> (Luis Chamberlain's
        message of "Sat, 12 Nov 2022 19:26:03 -0800")
Message-ID: <87r0y5v5hu.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0287.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::22) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MN0PR10MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bfabfa-a427-43d8-eec6-08dac6614bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rCEpbmPLNy26qwIiNO6qt16fc/Xpta5G+lLbgFFfne8ftlsI1C0Cax2a7WK71uUEIXyTLgxLBMECEZdJmSNwC/1xlz7hmoiAKpvlGtae0Iadrq3z2qNU4KfDtufksCtrW1Q+ycDUhCkog+mLixmIylFvWFRx9HntdNh3Ct4kmjC7pyjxloZ6B1owa08BYeurLEeQmthH5puVZkFv/PAunFT6XbV4lJA+MdoGvLlZVB3IQ7+gtONgPOlpvtz+9DI7BpcRVDuQaocvjqeLZ/AMSogx1/qQvf4RRkz9MS4BVcFuNKhNSRSSyH9bIPGdvHzf/ICOMO6Ds1dIH+W19og99IkxeEcEZRdAhLwLZ8Vd4Iv+WlOdxZDhHMuwpPyBk5NZHmG6qk3y4CO7JFe4i1kFF6QKvTte1hCOFoob3LdgO9Pyw1t5RWN5dhCibDXi/bViu018PMvzEHzoxiwH6wODJJbayWYPMJL2O6fYKpDG4dIdLV1ZVAar6H0mkkFmSEwn7JOR2vD/ewBVtIm6RZ2WJ9sfpAJvgcSupgEi9FeQ5gu0FjWRfmf000JyktPBqH/sUZes/imWJY+jW1l5XSRlF6sY45lxzWa1YbnEh3TU+6TQ22ift4GyaUisDf6Aaylb0p/xEcDhCL7r2cos3/pMxAotxiVLdUG5MkoidPGRnMW5b7yL+a9YiWL6+QmuulECdUgkKdm36qkeG1wodeL4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(5660300002)(83380400001)(44832011)(38100700002)(8936002)(41300700001)(36756003)(54906003)(66556008)(6916009)(6512007)(186003)(316002)(66476007)(9686003)(2906002)(4326008)(8676002)(6506007)(6666004)(478600001)(86362001)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wlu4nAs4PcgidQPbOBDx5sGenFxWjmrSu306B8y4tmzyBWOb1S7ZEwZlO5Pf?=
 =?us-ascii?Q?YN8HohyL9RwOLoiIUuBDlUcE9AX6E1ys7mu6yn6ZzQqrqrP5wTK6MLx3v2E6?=
 =?us-ascii?Q?RzRFMUerW3/u+x/4rSd4kFTBAkCn0VrcB3jKLQ2tEOmxeEI5ud7GNmCvBvtH?=
 =?us-ascii?Q?KagUBoMj58ppjWUaJdDiincb2iZ868o1BBZ+7K7SI/qsICNjJHTAYm6/bsjL?=
 =?us-ascii?Q?wVykCBoK9jhRmvC+cJp5PmMfpw62pf87MuWyPBMrkvxbuvVd6npMoTKGgC8B?=
 =?us-ascii?Q?WroDcD78Jfk5uC73gi1nwMmzSvAoAr4x3+JowvIjZXKBHMOh37Z5ny82QfHT?=
 =?us-ascii?Q?EtTpMlhvuMk/H70YnI6u79vF/juPKz8A8+n2gKIRXenwEC0JPNuGwZDb+KbI?=
 =?us-ascii?Q?KBLvlCrj4A7qMQWwj8MbtpNG+WMkEGC0lxudchpJ0o+Yak6NuR6f7PGjSH4w?=
 =?us-ascii?Q?yA8fhEyu993qxQPq5W7GLig8qdygHqpUKXF/5Q7ZUybZhgqKroEldWmjeG8n?=
 =?us-ascii?Q?WptNX6qRDg+zQGXdreP6Pgqx1Y1N4CbwXaueP0P20W7OGrEZmL3cJhX0+mto?=
 =?us-ascii?Q?KJGVGo+Kjem9fHU7nOQAZiXhziq02fWfxILE54HY2LZR+4ZDlXMBe46s+GXB?=
 =?us-ascii?Q?8Vh5DdYDIk6SizoPhqhrB+KepzjPNzumua5xARqsWsjq5qt3R1nQCyJXbp+L?=
 =?us-ascii?Q?mxgCbsu/a9u6bRzGzT8h2K67VcQZNnpXo+GiD+QQmfFgzsBE+hyuDWx5L8y1?=
 =?us-ascii?Q?lDSRnLaWArXmucJUIwb58VGMteVCBQVt1cKkj4WIiq7164Nn1J9qe1eFRSfd?=
 =?us-ascii?Q?S2EkhgHqTCijqYuaFqOWkLGGbtTvF0MNPnQ+GWzyqDRYj9j4yI/th1C7URj4?=
 =?us-ascii?Q?8gDwYAkTMrhP5Z4ArpU7vi6Wd6ekK5hvGbh6zdpmld+2yMuij2aWOiiubQ5C?=
 =?us-ascii?Q?wq+mCQgk23FAyG8bG7FdFDsmBiqRoY+LkXw+ngJE/LA2aVcuyL6LSDgOkTMx?=
 =?us-ascii?Q?E+ILZ2OS4kHb4m70kR3JAupudh5CFn1L48dNnspB8i3NArNAWvY9GovoesKG?=
 =?us-ascii?Q?NMKUAej0Dfr3XKDpQet6rHV8p/3hrI+aYYGJsH7VKPZ76iSr/vLSo8UHMKej?=
 =?us-ascii?Q?GRivvqTv3bjT3EXS0/M8+bZiBUnRCgfEDnJp/+joC+eWPTM5y7qERx0gQBnR?=
 =?us-ascii?Q?svwoTuQrlmdD49qEtNDDSoaq2dIPAwrBDlBlRjx9NCvgSzOUEk34J0kR+euz?=
 =?us-ascii?Q?QBBnjAzI9vSPlGJYV71VIihBYWNfyjIvzKKZ6LbCuAxCc2JpLdJdziGt7vxF?=
 =?us-ascii?Q?J0wrHWRzTb+zS4yhxdkF1lgs58Af7i8Wi5PvQSxev/hT5u6vLcA8/TAZbAiS?=
 =?us-ascii?Q?8NCCLL90qZpBwo0wsYHKfwMYGhr9B2Lw9Hyy75cZohQVqwV/PP1ctc7ZGyV5?=
 =?us-ascii?Q?Prd8WU/TrqDbSP4t9MtKYXrwOTJWajLwAe9t4CU3w6iiP8QLpmnzmA5rsDzn?=
 =?us-ascii?Q?3bnQSpIw/G6VGfOBdWhOMHfSRH0Seh8TqltEpaOjJJnE2xzTPRStBJaHELUu?=
 =?us-ascii?Q?I9HIriL2meqcH+63G1hHczfZQ4qvKQQV5oZ1NkwdrPBq7kcXIyfgD7JJCaQc?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bPtpYohnku4siFvMgaERmeldTup+J0F3kYiZsRjWUUODIlrQxbo4zQumHaKw?=
 =?us-ascii?Q?GN1+TnbmRNz8/L+HbWglzVqqx60udciQeCsEVRg61azDBeJCMN+9NX4Ktc0F?=
 =?us-ascii?Q?lNq/vrGBzV5koxLYK8zn35WDGmKqHLa18SJKj6+fYPhntKMbBZgtbND+S2JG?=
 =?us-ascii?Q?9tjZBSZ+7rrMgWnu30XGPuDf/tdzUxNQUCOQwb5epGW3Pfe3GYDahbiJeqBL?=
 =?us-ascii?Q?l7b+6c2ECIEaqyivDNmI4hL+0PsI/Jdw29e6h82F5C4LVyK1Mtesp7rjL5Jd?=
 =?us-ascii?Q?cAWRROPr3ujBS+hF0BtT0lGaXPC+yQ2RqDf0zK7ITTwkX2+L9bnX2ORFh75d?=
 =?us-ascii?Q?c72OPLi4Sx/Qa9+QTYoS14MrJYTx/V6dId0jC4D3NL/ISFpnO/Oe7+1fyfM7?=
 =?us-ascii?Q?Nxw2qEyiXhtx++XY1xRLablWUwfSQ1bIxTk45t2xwWmQdIFa12wHMEUZp7/7?=
 =?us-ascii?Q?D3nEgwdkgMANzHgGWod4eObQ4y8rnG9phUUNoF8XeKq/Tbec6bOadCcAifVm?=
 =?us-ascii?Q?T9srGseRVeMBgyQ1z1o0AOvrcEmb1KBFcLH4C6J1e715+Ac0R+MS/S2GbdWI?=
 =?us-ascii?Q?oSE9PFiuLvquz04wPp1DXF8swi3SLg+900eoA9p224hkPJs7AphLrB4P12WC?=
 =?us-ascii?Q?u6VrrriTmnj+C6TpzZJodpQogTk94XbRWZil9GYhnJ/oMsJ7rQ824UHDflvs?=
 =?us-ascii?Q?LzblgYvq7ksSoa6TAQk5cPmGCDGouHNbhB8Gol5QxB23VJW54UWNogg0pIoH?=
 =?us-ascii?Q?9PwupGrCiDFKul4zAx6ZEVAUnX8NQRBGKaOyOkv1XzoKPvigrjZvaAc+6mkW?=
 =?us-ascii?Q?S9GNklv6GLYqAnnjMsDcv0/hFx36L1itpbAlWWXwMU+cwALxTmWP/zIZp12O?=
 =?us-ascii?Q?FKYW/3i3LuajjDHu30CWZnn/lLsYhOFuN78AqkPOadI2cb02bxcY6HCxiX4E?=
 =?us-ascii?Q?pNUfXNOQdIqElQrjokUP2OZZTTdkSn4BKaq42nUZS/xG4dEeJzazcVY+q91U?=
 =?us-ascii?Q?EA66?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bfabfa-a427-43d8-eec6-08dac6614bb2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:57:21.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3RWfPyryaWLqwiJaQx3iGbto2aVWD+Ib/ZFRXhyJK2MK5X7XTZyx42PArVXbgA9Iqux1q8wss+dKtkWW8lvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=616 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140121
X-Proofpoint-ORIG-GUID: hjGzhXrhaDF9bFJReJYikPPwUPsGsQg9
X-Proofpoint-GUID: hjGzhXrhaDF9bFJReJYikPPwUPsGsQg9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2022, Luis Chamberlain said:

> On Wed, Nov 09, 2022 at 01:41:31PM +0000, Nick Alcock wrote:
>> This helps disambiguate symbols with identical names when some are in
>> built-in modules are some are not, but if symbols are still ambiguous,
>> {object file names} are added as needed to disambiguate them. 
>
> *Why* would we ever want to trouble ourselves with expanding all this
> data into the kernel? The commit log does a poor effort to describe
> any value-add doing this could ever have.

Er... the cover letter says:

> The whole point of symbols is that their names are unique: you can look up a
> symbol and get back a unique address, and vice versa.  Alas, because
> /proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
> really satisfy this requirement.  Large numbers of symbols are duplicated
> many times (just search for __list_del_entry!), and while usually these are
> just out-of-lined things defined in header files and thus all have the same
> implementation, it does make it needlessly hard to figure out which one is
> which in stack dumps, when tracing, and such things.  Right now the kernel
> has no way at all to tell these apart, and nor has the user: their address
> differs and that's all.  Which module did they come from?  Which object
> file?  We don't know.  Figuring out which is which when tracing needs a
> combination of guesswork and luck.  In discussions at LPC it became clear
> that this is not just annoying me but Steve Rostedt and others, so it's
> probably desirable to fix this.

This *is* the motivation. Previous iterations of this series only added
module names, but that doesn't disambiguate all symbols, and only
*partially* disambiguating symbols isn't really much use. If all symbols
can be completely unambiguously identified (via a triplet of (name,
module, translation unit), and mapped to a single address, you can be
sure that you can unambiguously cite a single such triple and get a
single address back, and vice versa: e.g. trace output could finally
give you names that you could be sure came from one specific place, and
thus often with one particular caller, even if that symbol appears in
fifty different places in the kernel with callers in fifty different
translation units that do quite different things.

(Plus, with notational additions in tracers, you could in future use
this to trace, say, only *one* instance of __list_del_entry, rather than
being forced to either trace all of them or none, or guess which entry
was which and do a tiresome binary search of repeated traces to get the
right one after lots of trials.)

(And also it's not actually that much data any more: 10KiB or so. :) )

I can add some of this to the commit log too if you like. (As noted in
earlier messages -- which you haven't yet had time to read -- I was
trying to keep that sort of duplication down, perhaps unwisely.)

>> I am not wedded to the name or format of /proc/kallmodsyms, but felt it
>> best to split it out of /proc/kallsyms to avoid breaking existing
>> kallsyms parsers.
>
> I'd like much more review from other parties other than Oracle on this then.

Well, yes. That's what these postings are all about. If I was supposed
to get review from someone else as well, I'm happy to add those people
to the Cc: of future iterations.
