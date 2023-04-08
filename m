Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D656DBDDE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDHWru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 18:47:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9A8A43
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:47:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 338LDfnv002741;
        Sat, 8 Apr 2023 22:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=P+dvfGsCBzouyEfpEh1ADiJoiWzK5MPOA4S7zC6rZO0=;
 b=zdKbrLM7CAiNNqgC5jnCRwtU3hh7UeyAU+R43veJJ3as2/NtQ57qCBoD4cYauB4Vll4O
 qlg0/WmTrjpGhB3WMM71eS2XgkVKt+IGB4GdkadhE7j3FUI4ofCWsu18gCNfQSU5n3Sy
 djvKa1BZVRRfl2eVuBN1mVzWobrKVGIwJNX/CY27LoigLaEQn7fFigPWLEsgQua5G6uw
 qzfPw+iFnhZ/f+p5qOXclP8HYgD8/wkKac7nXeLbeYZ6eFvIJtF8eILgetODxxHyueNZ
 /brP2vXXh6SQB1NzboFnnqRMjyMVsIRvLUIX49I8nSZ96U6356ooUi+85g3EstSiY/jY 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bvrs37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 22:46:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 338ISWNo036865;
        Sat, 8 Apr 2023 22:46:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ptxq8tb3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 22:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emtKhxmVQTpSAlklGRF4DslDYqfbyeFktFxk81/9Rbnv2QCcO44uyK6ROeozHhsvhAbXuVpbsBes+m4vx2CvX6tULlWTvkRpNDveJE8CrGQYVVO+6HNwqkOhI9ngUJGwVJqwkhVCdnB/nXxDS0O3su33+klHgAt3fndpwxGZDoxJ6fPI1SMER/4cff8cpuFEVVMOk4VbmseMFGKqZYFcn0TwCGTaEfhGcy07m8G4Kd0t/Dlnk1fSdHquRkiKI+C3kNl3ul7bfqugpIr0yxsTRNM2wiIpkOiqMfaitICt7tYELGDVxyN7trBbiIZX5fiHVcY9pBv5ZSuXfWW6YpjMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+dvfGsCBzouyEfpEh1ADiJoiWzK5MPOA4S7zC6rZO0=;
 b=gP34vQCdSNE0BiOzJqzg5rk0JmWx0pmm40oqHDhUnbV/5xxD/QjsWiQLcr9tc+RDipb47BfnN/zYHN/+cJmkjxa9+/YxNLhQbf/qF4+RQND2cCuHrZP5o226gTv2dkaUvzCPZlEUYthYZd3Tv1PkBOlbI8XLIcnaR9Zd93e6jxNMb8b/TzBr6VXgts9iDM3vOJMAZppr3b8+lSWDt4MohY9RNdDtotoe+Fqkn3NRDhrK2GrhIo927yCy2Wt3l8U8iI7LVHlHWo19HGUiOYERt0aQIY2ASEvoIIXh9/xOPjyyN/JwwnNBuvp8HLZ7KjY39rXmTs9kRpXMxFBk4UC28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+dvfGsCBzouyEfpEh1ADiJoiWzK5MPOA4S7zC6rZO0=;
 b=ELzsgmpGAQ8OK208zllRcFUS4YGLjP9PsKLv2kBsVwzRprMGSF/c5xXAgZkwXg9pvstH0EFO0eLdeMRhSzFX3TORgLLsXwK0PGnj0uMFS8/OQgW5hoXZcTLpjVOEVdEaIdUWgSIScLEdh3+k2b9Frr7scqA9Y1+aFqL5x0F1ZDw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sat, 8 Apr
 2023 22:46:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Sat, 8 Apr 2023
 22:46:46 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <271b85ec-281e-d33b-5495-59eb2bc9fde4@amd.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 0/9] x86/clear_huge_page: multi-page clearing
In-reply-to: <271b85ec-281e-d33b-5495-59eb2bc9fde4@amd.com>
Date:   Sat, 08 Apr 2023 15:46:56 -0700
Message-ID: <87ttxqf0v3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: ae81ef78-18fb-44b4-2979-08db388321b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7Ecpkf+8w/3LF9rS1lAJPjAhNZ7xrGV9Rq83kz455IILjNI2VwyNhX0koea77wX5Xl++22goWlCtwlGQIg/Ya+DuVvMJcFn1o4IXUW1KG/xHmz2g9/t+WFtiEeKExN24xAFiMeh+mq2GDzxcoGLzuiUUSPeOqCT7j/BsLsTjQl4jhQUlFPWQUowadS6XlDSwiiNwOQ1LgcAiXY7/UYR9xnzQK58Ztth9Fb53ZA+2nZKkNPsAO46ECbl+G4Hv7DlOrAnuW9PmgR68z2UH+YwLa0VfvlmwMYmYASw1k90bzQB7F2u0n+sEDhLyiOBYR9ISUX2m65tBOCgSuBOTpvGA9yuEAoeLVFvJQG30swUa/9BbU1l2xRqSvOIyvahhdk8hl/HpDG1krAgr41Sy4GDS6nTDFdJWOBsQ4OkCJOX3xPe77Ru/F7CXmBltyn3pYvdH1ygMnzmeS2F6uGIY5gZk+8FM6f/FjgrPLRQ67HxNFYcAIXw6JuoDMbjr9/QNJbSC52g03ncDKfBdy/59CrJjNtWLmd1AOeM3086VLnjXv4oY9Jos+6zcMW35znZwNgpYDj6ZuYTOIBsH+5JaHyz956d7WLuUpbBkGoAYI868Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(107886003)(6666004)(8936002)(7416002)(6486002)(5660300002)(86362001)(66556008)(66476007)(66946007)(8676002)(6916009)(4326008)(478600001)(38100700002)(316002)(2906002)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(41300700001)(36756003)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z78BZVgSR9fckh8tl8TjqEgDuumM45r7024Ynn5nUTwcLR1vjMAsYlUDIkTL?=
 =?us-ascii?Q?q6fBcjFRhRIdMYUCeXWXRFFez/wJK0rCITi8xjgB6F3i0YUZV3GUUtowhfEI?=
 =?us-ascii?Q?tZhB0hUmhjkvmQkD1av0f5+92FoK9Iu4ZstSVGPBUZlbR7Wm9dhifnDtrsqO?=
 =?us-ascii?Q?L6Jq7JcCX1Y5D4XjDHUtlyzYJYhxxtnaMzs5HNYK0Uazqo/XMhStsZhVs1VP?=
 =?us-ascii?Q?7EVDT/2q16r9hcHIvV734Tzh5kaZTVD4MXJS0xldd31sFZThN74V/+0g66Vd?=
 =?us-ascii?Q?a5NModpoVCNI6G7+V2m+wqWg3O2RE/JAkvoeQyYlZoOxcBLpsz0kQ1Rkcbum?=
 =?us-ascii?Q?vYR7BycQcvmi5teHYB3i/AZpu0u9FMj0mjtTL5nqejZyrEKr58YcpdUdv5Z/?=
 =?us-ascii?Q?U4n10v8lBoixAo2fYdNge72c6faPf1i7kh1vmjSsIFn7SRrIrYncwrInv509?=
 =?us-ascii?Q?b0FzQlX7cqPwwvuxbJsSWG6nMe1bB+ofn8b0wSnTZJj9JkWdvF5q2Ko6DZiw?=
 =?us-ascii?Q?RGN/y1BKsjNysFbwfxSRlAVhvBzRbhAJ8reMz9MbJvpXLOqkSF95BPksUx+Z?=
 =?us-ascii?Q?1w9Bhmnv6Ha0q2x9aInRLqfMaun5xuoTp7OGniaeYCfc7rTsIujbn8g5ymPU?=
 =?us-ascii?Q?0avlFXdUkIBuKFLscGlyV4kLxcDAzDp/nIlUUMwSRCRv9l9q/AYMoleN4X9E?=
 =?us-ascii?Q?LTtAh8xNEft8JBu+IxPl7K/Atw6EvvTl8LU9Jsn8BPwkBiTvd8s5LzpQ9b2C?=
 =?us-ascii?Q?KtwS1bHcz7aFP0xBOnxnGqQONnAbUew6DE4s+iynu5rEn/iA2o2HVsTrrIdX?=
 =?us-ascii?Q?OgQTroQ3VlI4yFSpbX9dGLhZKOcW9pUN/VrBgCVt7/CoJdfFGMxMJ1mghIG1?=
 =?us-ascii?Q?G5GRB+9wXfZAxveLpOCwn5e5F80v1NQ3aum+NscAgdXDG5kXGHTBFYKAW6tx?=
 =?us-ascii?Q?IRihcU+7g6rrRrkvz7qhn/aet2lctwmhnbSeTPJpSTMxaATwr7lGX3PT+LtE?=
 =?us-ascii?Q?KnZirb5dMW2edhYpJpJyRF1H6hjWN3wzb5Xk+OI2a8Vpp+wDgms2+b6Zycbo?=
 =?us-ascii?Q?Ms2r9aOh+1Zd68qtJvKlTY9ikwU162B3rab8NIkMWkN/MtMKzt5iSQyYRuhx?=
 =?us-ascii?Q?DFgUQJ/fnPg4LOLEmkO08SdwdCRgFRbpDWbFwDbbuowYc0nrsWVI4y6rqCpE?=
 =?us-ascii?Q?osm7p0/sBcELmyqXJAm5TeBlw03dkFNcTSJSwMsth9A6XnhYZrBJ/z2M158v?=
 =?us-ascii?Q?9yZMwwAd3+OKpHtm15Mm3x9aU7RIEIML1s3KLM6qfLjUVSiojvlQXVHoz3M0?=
 =?us-ascii?Q?WCnm5B6bMB/a/244lxV8vgVINdV4YT0eTnqCdJTGwx2n/t0+qoXr117ow1bx?=
 =?us-ascii?Q?LMhVIPoRQMJlU4bsCbcpjCp1XBC2xDGx0yGhZY1kSD+hWtmu+LWM9nBAlDEZ?=
 =?us-ascii?Q?+Wa6ud82wwycEKFWmY9SjRzWCMviERbV7RkqU/KUHCaxciwMRPLByUy4108+?=
 =?us-ascii?Q?UrJufLBm67YsWcl1TTyKtPkOhQ9JGx/P0z6gGjRCtQPEhS1V8ArWkCCUD0rH?=
 =?us-ascii?Q?oXkPWhDJ9Rt5omFNQtmeA7FgMSzVuueMXFy53pkY9XW0UKLrDqEiTuf4Jd6S?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n5rciEIZLPUUUaVYG37+0DAnqNzNm328O4ar/PjmmpuZN7/KNEOgm55psMQW?=
 =?us-ascii?Q?K5/W5VaHHVoFmiTOTNsybmdXC/qENqaG4Q7OEZt3lPSR1AFTBD6sMo6M9Lee?=
 =?us-ascii?Q?zPLzy43nY59fE46OX1Bm8kB3PW2vJwdfJ+YLlffr7fGncxOCCISoVx86Aol6?=
 =?us-ascii?Q?n70fHjErR9hoo7w7o7Qt71Vqwy//rcirMCyqKDdsi2+2QFSJFmtFRl/wAKYK?=
 =?us-ascii?Q?oEpmyuS4mz6lD9Yltvn57OTOF0GkYK94YBj5Vz9ZP2KmzMMKPU4Y6rxLWUuT?=
 =?us-ascii?Q?MTzcLznfoAeXsT5tIf6P517oLI0NLNX+zFlqam5jeahkxalK+PeWzXXuKQuq?=
 =?us-ascii?Q?oR4tZjObNrFr0GMtjkz+bjqQWdYkYNTfWqI6qYobNae0LZcfDf+6icUBEU/W?=
 =?us-ascii?Q?+nRaDKyFD6FZs/gwAWZVXZr8Lm/0idwxAhkq4Du3IATA2TGlz5XuahxmDj1y?=
 =?us-ascii?Q?ACM9+l/U/o+EcJDNLVngbxHE1nswEYvwLx1qcr3B8dX+FoacSaU4LkJ3k39n?=
 =?us-ascii?Q?D040X+Gkq6T2EjrA3ZPyBx2moP+hlDGNSq6moE4TDLgy2pSPWoQHPDFppCgH?=
 =?us-ascii?Q?Va/BFlYuDX0+8yT96hWQX4pRKIVHmAPoYzromyTzHah+dlNGhNTbZWUYAH7u?=
 =?us-ascii?Q?jA9jhEvUkpdqiNrG197ULBUWQv2UqumDE7ZpdqjWuuIu75z0xABbkpTE4P1C?=
 =?us-ascii?Q?+cPwTKM8aDU2LAEhGCbkmixOdY9DxL1wemiLyEQb2fvRIRa1yus6+qLZbCsc?=
 =?us-ascii?Q?tJPGI0q3Ct/EgA/yXIr8AdFTmxyVoPo8TyuvhuMmsd8qtFKhvEK9D1GlYDSX?=
 =?us-ascii?Q?f0MshbasxdjpHeDSwdOSCFfRleXl9ex0JM9vIknPve/Y6XpM9F3JukcNT7K3?=
 =?us-ascii?Q?7n/RIk0aW8te5bQ3flgsrZ7ekSq7l7p/tfs7D3rB57wLPm7CULvmLe4w6kr8?=
 =?us-ascii?Q?ZGiYA2I5/5LMyKqTDR1ls3hoqXTwGoOhSW6YKDPZHPoB8q4s2Yhn1g29gE1C?=
 =?us-ascii?Q?t74arTguZFEsqBZ/5gGmFT7dtyVKC+uL6gCWeMs6mUBKN/HxR8eBFnveHkxA?=
 =?us-ascii?Q?Mnth4AJImccDRR8dVFVS2+r5atZYAKwmT7UDIZO0X/FuBue55CjulOF+NnRS?=
 =?us-ascii?Q?gkqsJQxfEHDkD2FklGM6ojvT1ac0foT7bXOBiD1ivwgSjiuY+a1eXvs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae81ef78-18fb-44b4-2979-08db388321b7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 22:46:46.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoOg6zyyLz1Flkt9R5smvTVwKr5mBrNAiRA0szjZk2Jo48O3VAn7hfNbD++9Nfe6QUqSu9qdjKlQWDR1w5WaWbMv+py+nNQ6+939lcIQ0ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-08_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304080206
X-Proofpoint-GUID: EDuztppLmgHq9H18dSBjx0y_EcKijYHq
X-Proofpoint-ORIG-GUID: EDuztppLmgHq9H18dSBjx0y_EcKijYHq
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Raghavendra K T <raghavendra.kt@amd.com> writes:

> On 4/3/2023 10:52 AM, Ankur Arora wrote:
>> This series introduces multi-page clearing for hugepages.

>    *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>                            (GB/s)           (GB/s)
>   pg-sz=2MB                 12.24            17.54    +43.30%
>    pg-sz=1GB                17.98            37.24   +107.11%
>
>
> Hello Ankur,
>
> Was able to test your patches. To summarize, am seeing 2x-3x perf
> improvement for 2M, 1GB base hugepage sizes.

Great. Thanks Raghavendra.

> SUT: Genoa AMD EPYC
>    Thread(s) per core:  2
>    Core(s) per socket:  128
>    Socket(s):           2
>
> NUMA:
>   NUMA node(s):          2
>   NUMA node0 CPU(s):     0-127,256-383
>   NUMA node1 CPU(s):     128-255,384-511
>
> Test:  Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA node0), for
> both base-hugepage-size=2M and 1GB
>
> perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>
>
> time in seconds elapsed (average of 10 runs) (lower = better)
>
> Result:
> page-size  mm/clear_huge_page   x86/clear_huge_page
> 2M              5.4567          2.6774
> 1G              2.64452         1.011281

So translating into BW, for Genoa we have:

page-size  mm/clear_huge_page   x86/clear_huge_page
 2M              11.74              23.97
 1G              24.24              63.36

That's a pretty good bump over Milan:

>    *Milan*     mm/clear_huge_page   x86/clear_huge_page
>                            (GB/s)           (GB/s)
>   pg-sz=2MB                12.24            17.54
>   pg-sz=1GB                17.98            37.24

Btw, are these numbers with boost=1?

> Full perfstat info
>
>  page size = 2M mm/clear_huge_page
>
>  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_2M' (10 runs):
>
>           5,434.71 msec task-clock                #    0.996 CPUs utilized
>          ( +-  0.55% )
>                  8      context-switches          #    1.466 /sec
>                  ( +-  4.66% )
>                  0      cpu-migrations            #    0.000 /sec
>             32,918      page-faults               #    6.034 K/sec
>             ( +-  0.00% )
>     16,977,242,482      cycles                    #    3.112 GHz
>     ( +-  0.04% )  (35.70%)
>          1,961,724      stalled-cycles-frontend   #    0.01% frontend cycles
>         idle     ( +-  1.09% )  (35.72%)
>         35,685,674      stalled-cycles-backend    #    0.21% backend cycles idle
>        ( +-  3.48% )  (35.74%)
>      1,038,327,182      instructions              #    0.06  insn per cycle
>                                                   #    0.04  stalled cycles per
>                                                       insn  ( +-  0.38% )
>                                                       (35.75%)
>        221,409,216      branches                  #   40.584 M/sec
>        ( +-  0.36% )  (35.75%)
>            350,730      branch-misses             #    0.16% of all branches
>           ( +-  1.18% )  (35.75%)
>      2,520,888,779      L1-dcache-loads           #  462.077 M/sec
>      ( +-  0.03% )  (35.73%)
>      1,094,178,209      L1-dcache-load-misses     #   43.46% of all L1-dcache
>     accesses  ( +-  0.02% )  (35.71%)
>         67,751,730      L1-icache-loads           #   12.419 M/sec
>         ( +-  0.11% )  (35.70%)
>            271,118      L1-icache-load-misses     #    0.40% of all L1-icache
>           accesses  ( +-  2.55% )  (35.70%)
>            506,635      dTLB-loads                #   92.866 K/sec
>            ( +-  3.31% )  (35.70%)
>            237,385      dTLB-load-misses          #   43.64% of all dTLB cache
>           accesses  ( +-  7.00% )  (35.69%)
>                268      iTLB-load-misses          # 6700.00% of all iTLB cache
>               accesses  ( +- 13.86% )  (35.70%)
>
>             5.4567 +- 0.0300 seconds time elapsed  ( +-  0.55% )
>
>  page size = 2M x86/clear_huge_page
>  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_2M' (10 runs):
>
>           2,780.69 msec task-clock                #    1.039 CPUs utilized
>          ( +-  1.03% )
>                  3      context-switches          #    1.121 /sec
>                  ( +- 21.34% )
>                  0      cpu-migrations            #    0.000 /sec
>             32,918      page-faults               #   12.301 K/sec
>             ( +-  0.00% )
>      8,143,619,771      cycles                    #    3.043 GHz
>      ( +-  0.25% )  (35.62%)
>          2,024,872      stalled-cycles-frontend   #    0.02% frontend cycles
>         idle     ( +-320.93% )  (35.66%)
>        717,198,728      stalled-cycles-backend    #    8.82% backend cycles idle
>       ( +-  8.26% )  (35.69%)
>        606,549,334      instructions              #    0.07  insn per cycle
>                                                   #    1.39  stalled cycles per
>                                                       insn  ( +-  0.23% )
>                                                       (35.73%)
>        108,856,550      branches                  #   40.677 M/sec
>        ( +-  0.24% )  (35.76%)
>            202,490      branch-misses             #    0.18% of all branches
>           ( +-  3.58% )  (35.78%)
>      2,348,818,806      L1-dcache-loads           #  877.701 M/sec
>      ( +-  0.03% )  (35.78%)
>      1,081,562,988      L1-dcache-load-misses     #   46.04% of all L1-dcache
>     accesses  ( +-  0.01% )  (35.78%)
>    <not supported>      LLC-loads
>    <not supported>      LLC-load-misses
>         43,411,167      L1-icache-loads           #   16.222 M/sec
>         ( +-  0.19% )  (35.77%)
>            273,042      L1-icache-load-misses     #    0.64% of all L1-icache
>           accesses  ( +-  4.94% )  (35.76%)
>            834,482      dTLB-loads                #  311.827 K/sec
>            ( +-  9.73% )  (35.72%)
>            437,343      dTLB-load-misses          #   65.86% of all dTLB cache
>           accesses  ( +-  8.56% )  (35.68%)
>                  0      iTLB-loads                #    0.000 /sec
>                  (35.65%)
>                160      iTLB-load-misses          # 1777.78% of all iTLB cache
>               accesses  ( +- 15.82% )  (35.62%)
>
>             2.6774 +- 0.0287 seconds time elapsed  ( +-  1.07% )
>
>  page size = 1G mm/clear_huge_page
>  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_1G' (10 runs):
>
>           2,625.24 msec task-clock                #    0.993 CPUs utilized
>          ( +-  0.23% )
>                  4      context-switches          #    1.513 /sec
>                  ( +-  4.49% )
>                  1      cpu-migrations            #    0.378 /sec
>                214      page-faults               #   80.965 /sec
>                ( +-  0.13% )
>      8,178,624,349      cycles                    #    3.094 GHz
>      ( +-  0.23% )  (35.65%)
>          2,942,576      stalled-cycles-frontend   #    0.04% frontend cycles
>         idle     ( +- 75.22% )  (35.69%)
>          7,117,425      stalled-cycles-backend    #    0.09% backend cycles idle
>         ( +-  3.79% )  (35.73%)
>        454,521,647      instructions              #    0.06  insn per cycle
>                                                   #    0.02  stalled cycles per
>                                                       insn  ( +-  0.10% )
>                                                       (35.77%)
>        113,223,853      branches                  #   42.837 M/sec
>        ( +-  0.08% )  (35.80%)
>             84,766      branch-misses             #    0.07% of all branches
>            ( +-  5.37% )  (35.80%)
>      2,294,528,890      L1-dcache-loads           #  868.111 M/sec
>      ( +-  0.02% )  (35.81%)
>      1,075,907,551      L1-dcache-load-misses     #   46.88% of all L1-dcache
>     accesses  ( +-  0.02% )  (35.78%)
>         26,167,323      L1-icache-loads           #    9.900 M/sec
>         ( +-  0.24% )  (35.74%)
>            139,675      L1-icache-load-misses     #    0.54% of all L1-icache
>           accesses  ( +-  0.37% )  (35.70%)
>              3,459      dTLB-loads                #    1.309 K/sec
>              ( +- 12.75% )  (35.67%)
>                732      dTLB-load-misses          #   19.71% of all dTLB cache
>               accesses  ( +- 26.61% )  (35.62%)
>                 11      iTLB-load-misses          #  192.98% of all iTLB cache
>                accesses  ( +-238.28% )  (35.62%)
>
>            2.64452 +- 0.00600 seconds time elapsed  ( +-  0.23% )
>
>
>  page size = 1G x86/clear_huge_page
>  Performance counter stats for 'numactl -m 0 -N 0 map_hugetlb_1G' (10 runs):
>
>           1,009.09 msec task-clock                #    0.998 CPUs utilized
>          ( +-  0.06% )
>                  2      context-switches          #    1.980 /sec
>                  ( +- 23.63% )
>                  1      cpu-migrations            #    0.990 /sec
>                214      page-faults               #  211.887 /sec
>                ( +-  0.16% )
>      3,154,980,463      cycles                    #    3.124 GHz
>      ( +-  0.06% )  (35.77%)
>            145,051      stalled-cycles-frontend   #    0.00% frontend cycles
>           idle     ( +-  6.26% )  (35.78%)
>        730,087,143      stalled-cycles-backend    #   23.12% backend cycles idle
>       ( +-  9.75% )  (35.78%)
>         45,813,391      instructions              #    0.01  insn per cycle
>                                                   #   18.51  stalled cycles per
>                                                      insn  ( +-  1.00% )
>                                                      (35.78%)
>          8,498,282      branches                  #    8.414 M/sec
>          ( +-  1.54% )  (35.78%)
>             63,351      branch-misses             #    0.74% of all branches
>            ( +-  6.70% )  (35.69%)
>         29,135,863      L1-dcache-loads           #   28.848 M/sec
>         ( +-  5.67% )  (35.68%)
>          8,537,280      L1-dcache-load-misses     #   28.66% of all L1-dcache
>         accesses  ( +- 10.15% )  (35.68%)
>          1,040,087      L1-icache-loads           #    1.030 M/sec
>          ( +-  1.60% )  (35.68%)
>              9,147      L1-icache-load-misses     #    0.85% of all L1-icache
>             accesses  ( +-  6.50% )  (35.67%)
>              1,084      dTLB-loads                #    1.073 K/sec
>              ( +- 12.05% )  (35.68%)
>                431      dTLB-load-misses          #   40.28% of all dTLB cache
>               accesses  ( +- 43.46% )  (35.68%)
>                 16      iTLB-load-misses          #    0.00% of all iTLB cache
>                accesses  ( +- 40.54% )  (35.68%)
>
>           1.011281 +- 0.000624 seconds time elapsed  ( +-  0.06% )
>
> Please feel free to add
>
> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

Thanks

Ankur

> Will come back with further observations on patch/performance if any
