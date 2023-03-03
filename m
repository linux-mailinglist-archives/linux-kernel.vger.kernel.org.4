Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945166AA07E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjCCULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCCULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:11:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28025E13
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:11:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323J3gJM023241;
        Fri, 3 Mar 2023 20:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qrjoQisvWa+Mq1IW+9cEdzAbdZTaOch0Z8yAKpac6SU=;
 b=le6GGm/s4o9NJHXDFHtb7JxO6qwnlRAqehJhIciAe0BvLB5oEtEsWIJJ3yQfbe5Lx8HM
 BmWlM2P2dX+j0MO6tpXjuEigjnV0cC+3TH8JBUVeueJgFENHZ8wPMw3a3qSemx1QKczW
 SgDNjQ8/5REOy5BZCQfMgBVoomFWigF4MFCG/47NmliYwP7iPoxKHcGejTskeBoMHTNi
 b1SPJO+3AAWI7Kf3hxIdNWeEL71x6VyuIFlmrCivkTqeO1yl8tfdz3nCpFp6+5Uf8eHa
 nVC1Wmh1qMK7j67OmgX6yq1KHQbKruzVtonN24fzCGq4/3NyW770YLK+mVnJ1rlSH+GU lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7q3a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 20:11:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323JuXFX034848;
        Fri, 3 Mar 2023 20:11:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sj22a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 20:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3mvUqeZIxplkwdYXLw2sBlIKrmO/SndUUbcaEn/BWrpZ/+M5izvzuBtjESJ+IDE0nhxvMBot6WvO9kjiRmwIrkhDHzvgCjeKAYh3NOfYUxEkPeODJ44nmYb5gqe5AtiBWs+w3guSm65dHD08/+ctkpHJXWc5UAfvA31KRs9wCBjicxV53S4cCtCA2BFHGF3rcpCpW30371l123EbPSEydMqcnEHNFfik7ee4dCuc4u870b7N+Y/OdCWxYzculp6ryu7wyiwLTGAv9vGxOXXWtlz4d0JEDMyRhZI2Uj6//NpOf29l7X+ntjesCEOOMFJDmriWuaW8/CTmmXG0HPU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrjoQisvWa+Mq1IW+9cEdzAbdZTaOch0Z8yAKpac6SU=;
 b=GERvNVMldbRKlGzCkjfL7cT/Ms1iHRNeVGJC8XRHXGyiK1+lxbWLxUXmVAFXx4FVDZaaiiD05te7VZ9HglorXS730QCRl5bePlm3i45CL8I/Vsj8M7Bzt331S6j5SX8uEmN3a972enkS5N4kMV6hDndWQyAmcvJWEpFNSaE0uoflpT20qN1jPpphZup8snbkFVOrV9qBTlPbkGGYpPWGuxNP9HVkhcuhL0D/1TXv1iSZLnUhwC7p6j3GNCAwajUORmEwpFd0oI3ZgZpUvYhnAyrauzH26xYLxyXKGDKtV05ryEQRf5kgwiSbbwJB4Y/bZC8JztN4fcBl0qeyTqfG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrjoQisvWa+Mq1IW+9cEdzAbdZTaOch0Z8yAKpac6SU=;
 b=V9Lhnls7yeJLLVQyqCLO0jthy64XMb0ODNBmb045wGMnfYIFqGXzTwbJYv/1dEsyvHrfYj/KeoOY9FM6U3hLjsrhOHpbuKjMRFykYSvfU9IJnfiW6fFFBpfraF4Nchbdg7BjQgeZ4WrrRgBp9Fy0NMdiEzsFjm6sYBbGq5zoUFE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 20:11:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 20:11:23 +0000
Date:   Fri, 3 Mar 2023 15:11:20 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Regression] mmap with MAP_32BIT randomly fails since 6.1
Message-ID: <20230303201120.kjvrnqi65xll5cqg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
 <3bcbba4f-6f40-51d0-10ed-692e32f630e4@leemhuis.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bcbba4f-6f40-51d0-10ed-692e32f630e4@leemhuis.info>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e033115-1e21-4b48-2c6f-08db1c2375dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUgl0rVRcd5VyqqwP61qBimtn2fjuLgeBnmH59FosSpNb1Ny+TL8XpBMBC1kX8A9qqqfxOtC50VHdXUghImGfOkbQ5OZWGaboq9ZQ3ZzxUmEe2C7D3p89xlGzPpj+WqBLKh0zuUMfU4Y7382IaCRp6bw1pFq5SOX0E4qTKL8EDMh61YHgEHxYWa4p/+wDduE+hPADUc7ZwKTq2EZba6tzC9tEsupNM3tELJifOjkFM3s73e4if74fNi1fd3M0nwfcpIEr4rGU5q6I2dTwaWvldZzQ0//G1xefKQNoGKNlueOn5O257RmyfXA00rPIqi9pyaXHdcfGNE33prjmnAkgPHyJ/CVO/nsUxh3VtMRwnf7IEXeIKnP0ClKEP+HeGPYYivbuMSazCcLk+HDv+O2eWPON3TLbwVyScQd6N7K8us9gh/I+0mxq0Rjv7Xz9L4kIsxwWVcc2n5bSD108YerR0KqSvqpH2TLyYvYJFAzY1uv1q5p2TFzB3+jaNzeHxvYbsrm5CguYBviDuEVuUCD4n9nH27lcRT8gD13zM5qalnU5WqcuK9P34555nzK7cAi4fLYcDi1qna5259/HzouUrn8niuBVnS/ZBKjYJRo4RceELeuBI8QRB6g+U6hG3W216mRNm9gXcOIlG6D83PaYkefxaH5q/r0jl742vBp6Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(6506007)(53546011)(1076003)(966005)(6512007)(9686003)(26005)(186003)(6486002)(66556008)(6916009)(41300700001)(54906003)(8676002)(45080400002)(4326008)(66476007)(2906002)(316002)(8936002)(478600001)(5660300002)(33716001)(38100700002)(86362001)(66946007)(83380400001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ihCD+gJqv3bse6+JCk1jesA9DooDOB92qlkfYghn2BQ9eodECaXykXkmXFj?=
 =?us-ascii?Q?YutfNnFDy0605ULjhzkxUw8K4muXiDpxjsxuPVwQs7SRrGjyRJCpY/d0zZSb?=
 =?us-ascii?Q?H8Wckgmwc7MLUz7Iq7jqVwuq3c4Muwvn0AAjMahQIyyepYkoadsYsaRudUxB?=
 =?us-ascii?Q?T1QRlvYQo4qTF4usXvmi2lEwn4VkjQpJcCmUKDulm3h92v9p2Tg7Ebbez9ts?=
 =?us-ascii?Q?BLgcurZ2RTmA6gh1iEkveGqhzaV5H7qlJ3SZ/krS14mhrxLS+bcvFL1CYQCT?=
 =?us-ascii?Q?YYTfnAxMFAbmMXNwSluvRNadFC1A8pn5K2Zyrg+5xhpTdcptyMxSdqGrELsC?=
 =?us-ascii?Q?HZyLw/Jpl70xadHyRlCm4R0/1zBFS6SHMhfuYQl/uVYv8RvbKTF2hHeDGkD0?=
 =?us-ascii?Q?HhQEWEj/+iTFLLdphD/KJweI4hVDMPwX3Hw+NJ8Hwz2MGs0u+d8f17s+FTW0?=
 =?us-ascii?Q?xpGNh5vpjgn8sHTM7kwTCfyeqybajBySCHB/e9l8pA5IjMxRCz8kcvqVyQFt?=
 =?us-ascii?Q?OzTf6KbinSmssgOCo/2cWTGqqEwVO5GsOuVI7P0EvRhO3z6RQwtNMvKIuANc?=
 =?us-ascii?Q?pryC8U4EF8DmvCV8VAyedxyjHXimlTFwW9qssn7/W4gxForKO4F20IutxUVa?=
 =?us-ascii?Q?nRmYIHviFDEXWj737ROy4IdTE3tIKIef/1c5jY9c0UAnuioEKcM9l9FcyvWV?=
 =?us-ascii?Q?a2kuLR38TLMZGuGNI2xftmFYtKTr1fdR9ZuEGze9ZWIdTrHmLRy6WQl7kTHE?=
 =?us-ascii?Q?wrdj32dYJ8OhHTpbKguAUzHWAjbdMtNDepiWH4sJ62eJ1zB4Pd26LuQRCeNG?=
 =?us-ascii?Q?tgfBfRbnv/WJj7N9NbVrCDQv9kPacWcwhueakgvE6Udsm8xSdPLB7Pq+xIkC?=
 =?us-ascii?Q?4Yp48GTIQsVw1K7hlU7RjVkWmL76fNs5ELTxTQPvPhbZSi3HqRgDGS1vbkV7?=
 =?us-ascii?Q?YLKWIdjtJy4hhH1QQyiuaDTsXlpMrxK637y7ewqjStLzE/0T+cUzY2/oVfdG?=
 =?us-ascii?Q?wKGi5rnEMAJZE9z+/It9nVqEyZooUy7v7eU7pDeLBZNR+YeBsN6hL6oj9sgc?=
 =?us-ascii?Q?FUY8EHhZdiakqFzIecAnVGPCDxwrmqB5YxzCPLLa2JnhyMZClM7FKWViIEVV?=
 =?us-ascii?Q?r9oefwFGs2TpJ697MqlA76mZK0iPm0KPtZJM0lBh3b9sRlxBdEoFG+xmJIVg?=
 =?us-ascii?Q?CLGmT4+zABPrtAhej5ZfojXrAiZqIAQJWcxs+yHs8KboY+IVLTOKMOee3y4q?=
 =?us-ascii?Q?XP7vGwlTtv2Mogot9n2RzWASUH8aSJ25M6JVwt3aggnHq+N5N4xRniqvpqYX?=
 =?us-ascii?Q?TXDTO8Vcz7pG3v4pQH2wHr2s/7+qUyKiiqUJ5yrKOMHVi/HgZboAKI7mUNne?=
 =?us-ascii?Q?REJWa3nzsG0AnJb3YKa81bSD8etYz2W9SgGh75qP0PB6E0B7dqWxssjL2MdW?=
 =?us-ascii?Q?3YXkKcXmUCTdGYsT6mKW2ApyJdrUoLEgNxmnD4ol6sb0onfVjuUQoLbR5HAo?=
 =?us-ascii?Q?ySvWtx0msUtxc2satD3li0CpEjdS8i9zLiT+ex+xrrzKsrHsqMRPrUBgEsCB?=
 =?us-ascii?Q?j49CHMp97O5zaVab/TZJdLJPzNKK0AbcksK9VNB/udyzSgWK2Fw4756FNguy?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KB4zao11+DvmzGMS92418mxc7oJ+27J0Fju0C0A4aEQVZJilJzVsCTuS/TR8?=
 =?us-ascii?Q?SaOgHBxYbyZY7nQx5rUZ06Xzg8eoMSIirIE9wZ+lILocg6fjn3odlDXdn9Wh?=
 =?us-ascii?Q?5v0YCYIU3mipkMTPpRbFNLPmcg3m5SdA9nJGIfz8/TxAhG0Vw5Rg1GSaHEsy?=
 =?us-ascii?Q?NFYQXlIXHz4B1eFfNcRU22wzvE8yUX5C8T7M2T5crFY4u2faUbcC9OrbBpSB?=
 =?us-ascii?Q?UezdSYl6H0vKF7RVWEJd9D6dfLDthdZXk81M17qBDojnKfnuQSzTj4KP2MC7?=
 =?us-ascii?Q?3SFyXjWsD/XJQioUqdD7O64PLY8Zv8+RaCdWiofiTX91EoK6wFl4X3hygxwm?=
 =?us-ascii?Q?kLE/Fb1cMOKE9cRYnLDuCFRhhrxTeBQNzipY+AKcAVbpkO8VysrPrDJ/tYVC?=
 =?us-ascii?Q?9xMcgfMKnyad9E5qD7Vv9R9eMOrk6qhBnixlRndx5qJPA0Qy8WFTphIMTxiM?=
 =?us-ascii?Q?D1M1j4hTvBJRsyggJi1juCw4Ckx1pbKLJpra5HFIx71qnf9VlnM50natgPrS?=
 =?us-ascii?Q?wBk66FlFkfRDI+YnnFW9JWIPmFGPkkKlTxQEnezmBbW5AwPhocGMoejhSEbi?=
 =?us-ascii?Q?ZdGQqJyL9gZlxXKhW3z/ZithU9Mosmme8Vu2/3rLbVGdoE1ahWwqNT8gZe2J?=
 =?us-ascii?Q?conJPyvR86jMaqk4HNDV4DUXsIKAzhUylwUEsmoj2U9ZaBWyi9dc5EQMY6RE?=
 =?us-ascii?Q?IzTMHYhoT3SCqo8CsXGl75sB9ASheH+3RqVnkTS1p5gNucZPAWy89OqHmtYQ?=
 =?us-ascii?Q?8lE/7SF+bB35n5ElTaIvKP1j1Xmb9RfTRbuf4sjJ0ZL5tLKWEKEgPwnd2gG8?=
 =?us-ascii?Q?pJ9K3hRRE3ZbT8x9uUM5ehXKkQZJgsfaEIxT+5U1sANVvM2Eyq/+OZR3yZNo?=
 =?us-ascii?Q?coObP+GryXnK3M4hoLFEpxBXswpj+2AYKGAxQje56PJ/7+xNUtuRyjtTy/OE?=
 =?us-ascii?Q?hiBDhhhkuOAd2TMk3hNklAb7w6rjlo0Ht+BojL7E6bSBHmsvNSbpAvcL/dD3?=
 =?us-ascii?Q?sA9D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e033115-1e21-4b48-2c6f-08db1c2375dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 20:11:23.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NdxrQ6ToEhSaaEgRLQYhFtqZR1zdrZ8j2NKthTxCaFuRi9Lqaoh69lW73Vys22Cl7FygoyUk3wBRQpIIAjb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_05,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030171
X-Proofpoint-ORIG-GUID: 7CaCW4fdaY_5Hv1cJ3U1FWsECnuZjSNr
X-Proofpoint-GUID: 7CaCW4fdaY_5Hv1cJ3U1FWsECnuZjSNr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linux regression tracking #adding (Thorsten Leemhuis) <regressions@leemhuis.info> [230303 03:31]:
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 02.03.23 16:32, Snild Dolkow wrote:
> > After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago, I
> > started getting (inconsistent) failures when building Android:
> > [...]
> > I have checked a more recent master commit (ee3f96b1, from March 1st),
> > and the problem is still there. Bisecting shows that e15e06a8 is the
> > last good commit, and that 524e00b3 is the first one failing in this
> > way. The 10 or so commits in between run into a page fault BUG down in
> > vma_merge() instead.
> > 
> > This range of commits is about the same as mentioned in
> > https://lore.kernel.org/lkml/0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info/, so I assume that my problem, too, was introduced with the Maple Tree changes. Sending this to the same people and lists.
> > 
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced e15e06a8..524e00b3
> #regzbot title mm: mmap with MAP_32BIT randomly fails since 6.1
> #regzbot ignore-activity

Thanks!

> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.

I've sent a patch which has been tested by Snild and does not fully fix
the issue [1].  I am continuing work on this problem.

> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.

Pretty sure I did this part, so maybe the discussion was already picked
up.

1. https://lore.kernel.org/linux-mm/20230303021540.1056603-1-Liam.Howlett@oracle.com/

Cheers,
Liam
