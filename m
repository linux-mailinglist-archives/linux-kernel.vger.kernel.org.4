Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862156DB885
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDHDRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDHDRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:17:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28331CC01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:17:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 338393U7010247;
        Sat, 8 Apr 2023 03:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jeV/GWBaIfcf6vxXUE/R7wmNUwNEOEwRAtQtrmPc0ws=;
 b=qI4eiX4vFvuJQpww+xCSOg1f3l+SFuFn1myRgzRIlPzDvOhdmI+yQ+LQJKnLjxqJBOlE
 3nWPBUx1CfRtfJaWzBZ2FDllAIITIZMB67fZCslnB1z/h38FgPRd8OeLa+LHCBdVQ/xP
 ETAi6fTuL2nnjqeA+Dwi+d9i9bskAdtgxvfa5OFDhQsS6fZKXqiNOQKSw7r3qe3qwv2a
 Qx4A3Rq6XRkrNtd2CtyT/qGi09BzKrR/RqJZzKmtiPv8NvucT5z/gunsonUv3+8H8WrW
 G702FUQrfOjltCxaeox72CWJ0TdJ3lkN/b/EV1VRLhwc+8kwLswD37bCTdjQP0xZcYeT yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd6b1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:17:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3383DY3F029917;
        Sat, 8 Apr 2023 03:17:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ptxq22w8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy+/4NKJJ0MVpHZGmu+KXhY0b63KMGEbvA3oKBjrIBc3ItG/Gi4wWHFSWCZUBT+EQtu+uwYkPmolKrdXXSt7xhSQBlcf9ED/4rbtfoTnFpLfoAt2KYSBDl8Onjr2d0V4bVMREyE7JdXSrAh8RV8fBRmuWBQkDejc9AlRQUlbsKIQ6xNwQw5G+84dqC9v1ne+2nRx3KdK1lBLo5/UVV/8Oee0UQIDtsZjGBXuW7ppxqbgZtfivSfdfdCvMLPQ+BAdg0gA1KBUvN8BH9XZWu+XnbiS+xCl01pBpyaolmaj7Fyewpn9k8DoXs+Sc3yy4RomPO24K67FZ4tTnBoKTeZO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeV/GWBaIfcf6vxXUE/R7wmNUwNEOEwRAtQtrmPc0ws=;
 b=T5QUy8QjYDkqgigIFE15bnrkGXBkACL+ZO30DDmerGXrekAuRbvYpiYxy06d45HBUN+Xei+R81z/QOajUMfAjWWhCuaZ9XUklARHgbGLeu/vm2F8ljCDfuJz/wJhk8AYvQc9fGdH+svPcjjLPh1NUC4jn+ZUSRASzfOwxfW0q/EYxdhDSaIjRaDXqJWhZQdXvBjRxnxcKgPY4KANQyLFG9MELHywZAlckKgOWk2AfKaF/RXPGl9PmbFDfrZmK6K9Eh+yRhByauTq4gOK99m3ZARbh6y3XzbUZJWArN0i18dW28LuBOLYMRawwOPkxMR6Y2O3o/TAHSiTxo3W6Ggpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeV/GWBaIfcf6vxXUE/R7wmNUwNEOEwRAtQtrmPc0ws=;
 b=prOwFQntSi6bibY58U/N3GAPeZ2GBL+OX/gOAsLyKkTaIE4e4IzrRjlSu1PUHdD8v5fhcijmJ2oDTa+B2RtvN8wfhinZWf5pJ3giyKsl8obi5N7Oq4sx+Vp1ymNsKzJ6Hr6M22cYPonrFqGa287msTqexaPbE4LlWAZG9gYNUUc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Sat, 8 Apr
 2023 03:17:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.035; Sat, 8 Apr 2023
 03:17:01 +0000
Date:   Fri, 7 Apr 2023 23:16:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: Add a test case to check maple_alloc
Message-ID: <20230408031657.66fglyhaqds3unya@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: e1769751-2f4c-4126-0d88-08db37dfb841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aisPpLspS06w6rPo3K0JX/OhhmDkzH428NKYEgBGjNOrcp80XWSwPuHhrL3kN3Hh2E7Nxd4atvq2B5XzUnkkRF7SZyUo0quY4lwZYljobZImEACv84YOPhcibRi9Z1eNeeXyyembSQGIAsWoz/c1tInWIWLU+3GKDlHJu5foKyysF1nazuwTxTRK2+PsqZaae/slzL0ftC45vUY+m69bTbw3+dGu+DU1WXb4QMfeXGpPAjogD8Spphu/+Vz9fjVx8HaOkpmR5+2gQyQEAohy3gDs+mz7f5lnmb+Svr+oTM5uVDrD1nC6sJQxcEvAaXN7ZQuOHoVT9uQK0VOxDyvl5272/YL7HJa7Li7ebazFFuzfxBikAcKZrH9LQf92tzSRf4rgvR3OIt0dxcRitFxekXfd2pdUV5XEUmUuim3HpdpLOEGVgCNIJf8gzdrG6emdn+4EA3fLFHAK97jflhm5Opm8/RostYckW8njlCODZ7EqxvV0Qns/BNGBp+JDPipJZlS2Q8r/u8iXxJ6PDVWrda5kY2GvlL4qzX9qvZQ6aNrhaog8igv79hl5x2qWeqAb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(5660300002)(41300700001)(8936002)(8676002)(38100700002)(186003)(83380400001)(9686003)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(33716001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1I+VEMN2M4VagzoStP5aPwZO+Mdw5GzU6v85lW5JF6566C8r/Moy2ywti/6?=
 =?us-ascii?Q?Hq4w1dtEU5Vbwy6T8w9dVRhaWvoqYbP17oILZ49rVKipiw7jIFPJeIE682uc?=
 =?us-ascii?Q?WeH/lDFxO8J8wvGtdN4CdB71LDTOPI06sezZjnY6foeDJcjd58AFxq19U1OU?=
 =?us-ascii?Q?3+Ad3lVZefom5WG2Ssvjg62QZghyh6ck95MTe9K/Y0SSw6SleJJKKhM6kQIT?=
 =?us-ascii?Q?xS1tmrGG37VoKC7MPendr7YLjACciog8etJJAmRrUL2CzHzdFTaMM4+tDl2w?=
 =?us-ascii?Q?pas/ykqqNWiCs05lin45rxnh65mdpydlPKfSd17x+GyE79HTP2rreJnhgtt7?=
 =?us-ascii?Q?8j55gh8ZXMFzl4mwXzbriGKB62mmUISJgV9nWn/oVRv6+DEWwIaV09Lq8n/y?=
 =?us-ascii?Q?KLQ2yn0gD4WxIsUxTu9UviNNO6q3X7DNXO5l+Zhp4Pii4K/1LpV9bpjYQjns?=
 =?us-ascii?Q?40mLBdqd2Y/HptUULaMgoJTlz14etiL4Lgz4+lF3PHyVWes6ItvAo3Gk2sgO?=
 =?us-ascii?Q?aTNmYMuIUA2LmbydrxfxJ19u7kP591TsG1NqccU6JqJJ/SsVobervwPVNRg3?=
 =?us-ascii?Q?FSS3U9HITLs78EMBwvkJOeCU5vyL5Ru/cAguLbhVjZS0X1U/zifrR4fbOVz6?=
 =?us-ascii?Q?3gjVhW9Tp464OMRrLYgZZLZ+SZU7nZnt1uAg8ALeJt+XZrReaDI82JdJgFrM?=
 =?us-ascii?Q?tpXUPDsovTIVV0C/Pz5WPW/z0Q0iNH35b+DkcVg4HaHP6hwtESXTiX2gWcgz?=
 =?us-ascii?Q?gJ/PAE8pjJ64BMz/8cu0dW8qxISRHZZYeFiosjv/5mmaZ5ibSpvGM+HDfYU7?=
 =?us-ascii?Q?iDyOsDXC4WDmR5AKoLp80rvMz6kgC+KTQrAoUeBe5Juroeq9Y1l9ZZiZigJz?=
 =?us-ascii?Q?2Hiyjos2/0+E/HfEgalJfiQZpF6emB5DPqyMsNvTX+Wv2VUfSXqbASckxckV?=
 =?us-ascii?Q?iYg1cwCjSbh/H8w518bwh1yC8RsKwj+ekKGJK86r0FCZRGLiI7snpeT0kCxA?=
 =?us-ascii?Q?9lBFVxbZEAA5AZbARn21kEFkgU3eIqCr/PZHLV8JTEcifdYTJX/dNen+LqCR?=
 =?us-ascii?Q?nhvY1QQsSjKwMLctflfL6JVjt6qQJjva6pMiCsButwpv6r7iQxpRcae6vfFU?=
 =?us-ascii?Q?SDfZcy0qSkZWpUsGqj6bDa/mWOpoRNp3KMwj7l0tL97Xc9OLv+1SNe0V6Bd0?=
 =?us-ascii?Q?dl9/HDjB96XocI28DDCjLZuIHvWimfmAVzp/ueeUmwTJAaO0re84Z30nP3V8?=
 =?us-ascii?Q?uuN8hVWfwCPGEODEGP3Asb1ujxftPzrk1Hcp8cRBlPsJZW2RmqxPXvEtC4M7?=
 =?us-ascii?Q?/r0fPsSnem8UvzE8qcKHESI2lqDTahAwqpgEdujWMZwCXexmslrTvpHvlBwf?=
 =?us-ascii?Q?k+zgNX9i1CtlvZG2VSr4OvwoTV5dpBcQc5z5/Hy5v7cosl063/EUpr4Ateu0?=
 =?us-ascii?Q?ZwEErDdCWMCBrRg/UiQu2o4Wjd/EePkU5tHhcnoohq8QYImlUUBrkosks4np?=
 =?us-ascii?Q?Wsl3ILcj8TFgI5onYwewUABKpkTKcDPC17N1Szyw7f4YjveRF3Fr8S6gQQtR?=
 =?us-ascii?Q?zKJwz7dZ1IcuYD72DTKCWBF/qYCnu/m/WnQmskUS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aqUGXLPNiECh0CS1eyWJMNAKF30/4zkOs239hBgXuYGuwKXkPOl3wmLibGDE?=
 =?us-ascii?Q?I0GshmjVC5++8amws3TY4/i6ec/uENVZKmFZdoAoH03rH3OHB9rbeNZZWHxw?=
 =?us-ascii?Q?41+DUGnl63vTm4EU13apOYxqDvkVXYYxOBoE3gh/KGjJZ6zpXCrdnNN9eBc/?=
 =?us-ascii?Q?k2W2vOyx87Ej4K/vCt3wFORjhrlIY9iSutLgVCTy4aTmmXp9kesl2PdyVJkm?=
 =?us-ascii?Q?/FsHT72MihKyJrjz1/MPNSmLxbcuYMJoJvxAVNuzMfgFzEn+wLpd0oPDRKMw?=
 =?us-ascii?Q?9v85kvmYox+Do0vmA/heXYYGrK4yaBWLSx1uHOtDo3ILG4i2VHYffMEipaq7?=
 =?us-ascii?Q?JrgzMGkl+61WtrFfXe0cVXBAzWOKgcYCukz5ZfmOHrSU8wN/oFFmnVSPP85L?=
 =?us-ascii?Q?pn5iva4wkY7WHlB0QzbLfO1wbEArkG+CRmHvPUFYXTzxHGI4qeIlItnYfbEj?=
 =?us-ascii?Q?2Pf6V1VfMJCkLyqTLfRzHlV1zxT5NOr4kSwBRpr5cL/GwGzDOGJo/QDo02Te?=
 =?us-ascii?Q?F5uckGTz01HDW9iGjHjYepi6tJp4I1S8TDcwO5NGw/3NjYbFGO+At0Nm5WCR?=
 =?us-ascii?Q?MpX++nBaps2dknrCTmHqaA2CCMA9PACxB/ZEKDGGjqiwUiUIdRBAcDLX4m/i?=
 =?us-ascii?Q?j/8FaKQxOWgypVxPYOqU1xRdhFl/M0TsESL85rMJT790H3Zm9ie3ztPND0nw?=
 =?us-ascii?Q?28UODjx5nLHtinblY5E7jCgyHCUa3lW5/xiuuxn1G/tCx1SCdD2LC1K9xG36?=
 =?us-ascii?Q?mVhcPOg3pQn88sZfSe6vS1G0+A/+99A5W9qSUTSonM5hEzTs5z7VGsiayw+g?=
 =?us-ascii?Q?H8Al92HExmgrYA3rZ7i+YFccxbmFxTjZFHvzfMcoJAbzoGLJMZBDhdYKxkAI?=
 =?us-ascii?Q?qNv//Sq/6jzBMpFAlW6aNEBB6CD5sjnFtDnxF2zOwQmbyP+foXP28rOTenP1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1769751-2f4c-4126-0d88-08db37dfb841
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 03:17:01.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIPvSiH2/BXkPsfonnyBGrq/QY2htAYu62Z2+HXQ/HZqjeCEUsswOmvOdV9K9PVJe7xrABm3LQuUdLXqHGmqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=853 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304080027
X-Proofpoint-GUID: K1Kj6AtT50ZPL5llnyUf0o_H44UcgYpF
X-Proofpoint-ORIG-GUID: K1Kj6AtT50ZPL5llnyUf0o_H44UcgYpF
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230407 00:09]:
> Add a test case to check whether the number of maple_alloc structures is
> actually equal to mas->alloc->total.

Please have a look at check_new_node() as there are tests there already
and see if it covers what you are trying to test.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 958ee9bdb316..26389e0dcfff 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -55,6 +55,28 @@ struct rcu_reader_struct {
>  	struct rcu_test_struct2 *test;
>  };
>  
> +static int get_alloc_node_count(struct ma_state *mas)
> +{
> +	int count = 1;
> +	struct maple_alloc *node = mas->alloc;
> +
> +	if (!node || ((unsigned long)node & 0x1))
> +		return 0;
> +	while (node->node_count) {
> +		count += node->node_count;
> +		node = node->slot[0];
> +	}
> +	return count;
> +}
> +
> +static void check_mas_alloc_node_count(struct ma_state *mas)
> +{
> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
> +	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
> +	mas_destroy(mas);
> +}
> +
>  /*
>   * check_new_node() - Check the creation of new nodes and error path
>   * verification.
> @@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
>  
>  	MA_STATE(mas, mt, 0, 0);
>  
> +	check_mas_alloc_node_count(&mas);
> +
>  	/* Try allocating 3 nodes */
>  	mtree_lock(mt);
>  	mt_set_non_kernel(0);
> -- 
> 2.20.1
> 
