Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE373045A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjFNP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjFNP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:59:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514771725
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:59:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDFXee010589;
        Wed, 14 Jun 2023 15:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=y8cc+HbZlbfzkiVfc99/aEBIoEyVo5FNG0b+VGf98u4=;
 b=AwaGVomQABtOWnheYbEDxmUDAJIWZhuJhCm0588j9q248MoN/KtuTz+aBiwa3HQJaXC1
 0kKpQAgeLjRqOxmSZ3yKw/aV28ykekWqhOeJmZ76GBVTK9ht3TrKM56MO32OPE1KMrYf
 ndIOLCTDzXCOCgGOy6EpxsrXtAaX+OAVdNc/asrcUrhxtV94WhOSrc0k3+JZNawFnh43
 zJMZAixCeVwhEr5LH1xDHGPPrLWsb3JeX5UvMD3Q89D5mqb8CgIUGqxslj5Fs1qM9MsA
 EnqsN6C0D4NMVEJW6nnW+u2f0yZGnelGhpJOOFsww848HSL3mplzy2XYgkYvTNBVCwKy 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs201bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 15:58:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EFBOaI008322;
        Wed, 14 Jun 2023 15:58:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmc1x1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 15:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua+lP1QXGKWjlKOrngN6i/Cuqs9sxpAZ3v4Uvpatuih7KBI5wLP8MrXf/Ke2RXE4b1IQBK3Nk8L8DnBy18T/ucxFfhXSFfHNWlu2s2JbPYhbtYmny0Vxht4K6Gf0fRh9HTjkRLU7dxraw/rqeqbJF94PgQnIEfpFGKpCxoA4jqrj9Z+SAlisYDnsgmsz4BB75occytrX3RliPJGNH/o3FksgzFwozNcNaz0GcXLftK6X5qX+jRaeW+S/KYdtR4ESlMGBf4QaO9T4g19vTx0lLtuLNQMxx+Xv1ZjWb1yBc68VkK8lnptt5fTYolBlvpeHBfGiOmHHWUJ9996Rib6AHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8cc+HbZlbfzkiVfc99/aEBIoEyVo5FNG0b+VGf98u4=;
 b=Y6SgPr2s3M4fQ4l/G6rED4JpqWZwSkRv4Iv/y7LXKmkSePxPJ8SitSjUPKdLa2rcWvne8qg9kLN/5bEpgzPQC2VrjlgqQyP+8giv78Icupu478LpXGRUbt2273+Roo24esNnObhuFdsuOlnPjJNAJsmC/qkrUJp2boTByoVCgSXydNUxbruWUHGbrM3VJg+zID4ND/qa8YasAeEWzUBEMGHf8YuEDZBvrFSZNgCXVg2UdFWVhT8McsRgOY3OU+wrRaKcI2BFg3gAzmOqIP4adVO5ImvWZWGQYyv5vUxhJAYwdJTZSkK77uPBdR20wHRd9aoVDBkBPeLIAtg7hGm0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8cc+HbZlbfzkiVfc99/aEBIoEyVo5FNG0b+VGf98u4=;
 b=W0E33k8WTHXrGGwjMEFT31JNi/CZj7AFSMuCoGSQafZfWfhV/ktoQc0InjxsRyOkIH8lbyEIyZfrICa5htRBi0Uora5lP6TaJPkpn7ZIAH96fYkVGkdK8uN3tIQ8stjqrftxhUjWSdeHbnTSaBiMm0d6KDxDAHYMv6NH3r0KdBI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5556.namprd10.prod.outlook.com (2603:10b6:303:143::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 15:58:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 15:58:29 +0000
Date:   Wed, 14 Jun 2023 11:58:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230614155826.cxcpv33hs763gyrg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
 <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0374.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d7a192-5742-4046-14ee-08db6cf03254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4CywKTgpyQpGaKhipCEyfq8bAzrqQbpRjKS1jDUwOsComchnrUPzCdN6/wqolLcglEn4eNz5Z+JBqgbrnf5ovIvJNcg/FKUbnrfgoDv+Re16u6xDQ4JVw7/7uCCLSMkMR53D4znA5Z1P32IV0RNtWfQWbu+TnnCyP1mTIDA9RniC4bocascYXSUSF8j2NermYDisNzDobeiO1qFvYGg9dcNxamQfK+iEshlqi81UCahWLx1QahBPK8Nu7zNm66vPPs3kpQNfkKN5eMKAsumUe/iN0BVX3myX0uspGgRwVl0Rr/BcgWTCdGQMj+kYG0zy5lH4QcUtvZgLfWqDtC3L+sWR/oZHw933DwzLkRLYGVzahyR20LOclYrXs4SHOIDKFrcZTIBJERKHpfFkY71hx8WG49eVVu9fPS2bTa2iNw6ZM/qiZMFoqJSUWkgHpPVuzXKM3VwzSajl18ZKOq/Mo8ml/OzueB6PEsEWQPEBXpavNJyyzXNA/Oz8grXFPUU4ZwlQD3rkO2kbbFz+w8uFFJfCJT/8vPRSaGUpZhXxBEGthTdxjhFZI5oSAQEKT5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(316002)(6486002)(83380400001)(41300700001)(33716001)(86362001)(26005)(7416002)(1076003)(6512007)(6506007)(186003)(9686003)(2906002)(38100700002)(5660300002)(8936002)(8676002)(54906003)(66946007)(66556008)(66476007)(6916009)(478600001)(6666004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25BYXh4RHNncTZOekhoU29wRDN6cUFlUFF0S3QwcmpKSGVvdXBGS01qNjMz?=
 =?utf-8?B?SmY5czNjN1pmcXFSQitSai9TVFcxQWdqWE9hbWxyamtQNHBpaitYSzl5Z1hY?=
 =?utf-8?B?cGFlYlgxLzlkZUorMEluMGdPaVNTekcwQWZlaGlRMGVHMCswYWVzaGVTWmEy?=
 =?utf-8?B?YnA5TERsYitYUmJ1QVFscXFhZHplci94ZWJTTXloRzlvVXF0Q01naVJqeGpj?=
 =?utf-8?B?NUthSnY4aXhHUjl3UWdRbzY1OXpGWHNSdnBXdWJ5d3JqUGlSdW8vQXVURVR6?=
 =?utf-8?B?Tm1YcEc1eUI0K1dKZUxmaEIwYlpWdHJHNWMzckVldkU4ZzQxWDUzbnBCdWxI?=
 =?utf-8?B?WDZTMkkxUHFEN3lKSzNUZXp2US9rSXQvbW1kS2NEWHZOUURpL3NLYy9vYXRz?=
 =?utf-8?B?MVovUy91TnpTcVFoNUNQU2p2Mm9Sbko2T2pCNlVBb0t2a1FzQ1FPSWV2WUph?=
 =?utf-8?B?NFliMlp5NER3eTJuSzVRK1kxYmlWWlQ4aTM1MEY0ZlVSUEVxWFlFbXlpNHJO?=
 =?utf-8?B?L0dQYUV5NXNWWlJaS1pLZDFjM1h3WWZ5YzIyVDhnVExjUHpHbUFFSDJzVTM5?=
 =?utf-8?B?aThDZ0JqUFUvbUQ5b2oyQWZTYVNGVTFRVjJJb3pvTzloTDdGM0VlRkd4OGFV?=
 =?utf-8?B?VDhYZVZTNnJsaUZXanNyTW12ZUFnYlhtcmpBSDFSTjlGTUtldGkva2FINjZJ?=
 =?utf-8?B?MlN3MnBxTFJ1dnQwQUtoVzZiT3E5d0JSVzJDeFFKbkxOckFubUlUQk9zcmxN?=
 =?utf-8?B?Z0RIRWViZkZSSGFxVEE5Z05aOHNuQW04Q2pUOXhObjIvVEh2ajdnRHBIVGtR?=
 =?utf-8?B?eWFRTVR0SVRRSXU5REx0cUZycUNjTWVjY3JPNGVTWVIyTWN3ejhhWUdrcEE3?=
 =?utf-8?B?N01UMktsNXZRYW5IWnpVek84MHZXdWhXcFl4VHBpNGJhalN2TnFlQW1keG5j?=
 =?utf-8?B?Z0NTbk84ZGF1QmhjYk0vWVdSaDdRRU9SOGptSktQdUpnWjNCa2hnb1RjR0g2?=
 =?utf-8?B?bGV5YTFWMEFhWGp4Q3ZucHRsZjd1cXI4SjJKelEzRzMwZ0RZVHFLb3hsVUdS?=
 =?utf-8?B?UXBqQ0lROXE3VkFoZXdESjZnOW9oRWUzYXd5YjlFZVBTUXBkc01BT2lUMk1X?=
 =?utf-8?B?QUtVY0tvelJrV1B2cEpJdElUamlWOEJEVHF6UTk0VWZDemJYR2wxTWRFUUFt?=
 =?utf-8?B?dkllTEdqcmhkQk1RdTlLbFR5NktqY1RsdUY4UDFYOWtVamdabEJlRHZJNTJl?=
 =?utf-8?B?bE4xODZENkI5Q2UzWkpvMkVOL01XUHlqTyttMnhIbUQ1SHVTV2VWckZhcDZG?=
 =?utf-8?B?dktYUk9LaWNMQ3FSQWxnMm5KVGhUSDludWpOL1luNnV4MnR3ZGtZTU04bVVy?=
 =?utf-8?B?Y29aRFBqRW9IbUhXczY1SS9WVzl2aVdpdXQzbGFGZG1HUlVCeFBPUkM5MFlk?=
 =?utf-8?B?dlYwWE5DYU12Z3hOandWc0NrZkNVSmV5T2I0bzMxQmlwMFNOcHBIbjc0bHZp?=
 =?utf-8?B?RkMwUFJ5RFM2eVlEc2xCb0g0ZUlyQUlGY0lsS2lLSk9Ua3U3dWNzb1dQWGRV?=
 =?utf-8?B?WnErTlFzT294Zm40bk1rNTV1eWt2WHI5cUd4dU9PbzU1a0w0QnIxYmdNUnFa?=
 =?utf-8?B?M1Vxb3laMndtZmtVbWUwVFl2d1hpTFA5WlRiNklsWmw3QkxtU3hYbEdCUW9z?=
 =?utf-8?B?WlRlaTZFaDNXOUlDYU5KOUZVb3pGZVVHMTllY2NaMkNzNHV0c2taMGFoVUFQ?=
 =?utf-8?B?blNIemZEVTRnbWxPVzFnRkgybHcveWYyeG1UYzQwMUFnczB5RXhjTTRjbkRN?=
 =?utf-8?B?UVMvaS9qR3dCTDhJRHFOc21LNlRrYXFYeGo1VElVenJjbGtwZHlFWkFiRnRi?=
 =?utf-8?B?MjM0eGE5QVRlUktYU0lsZWs1c0ZLZEJpM2t4ZHU4Rk5GRjV2blh5NFVWbW5F?=
 =?utf-8?B?NjVnVDdhVEZsRmZ2TzFhVlBlcTR6VlpsYmc5OUtpOWE4Um1pQ0RIQWsrQU9p?=
 =?utf-8?B?b05DQ21kc21Mb3FJeng2eXRTNTFud095KzdadENNZFgrRk9DOVFqRkpiQXJX?=
 =?utf-8?B?TWlRaFZVam5ndGRKRXB3VGZoWlF0TkhXcnBOQ2oweTNkaXo0V0RtUnlHNGhh?=
 =?utf-8?B?S0FrOG90MjVRSnZlN2JPdU5FRGhEZ2ZwK3ArMHJJd3l4WTdnaTZrNE5sUmNU?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a1lDb21zaUQyTjN1eVBnSmhrN1VpaWowakRuZmZKOVBxTmM1OXJvdURqbUkx?=
 =?utf-8?B?ZWtXYkpDYUk5SVdOdkc2QVJhbGM1Uk1mN3ZQZFZJV1VxMlBTd0Zhcm5rd0k0?=
 =?utf-8?B?RUJlNVhhLzZ3d0VFak9lNVR4eTZmNFRRcm4yUERaWWw4LzU4TFVEQzNMalZZ?=
 =?utf-8?B?MkVUQTdRV1dGdEwxVGFHbnBxUlQzZURtb3A5TE1SRGF4TVN1YnZCYTBtYW8z?=
 =?utf-8?B?K3dPcjBNN2MrZ0lqZFB4MmZ2WEk2SldTMERyamJWUWJTRGJLekJCWnB2eTlq?=
 =?utf-8?B?dlBkS1E1cWVWdUR1Wkk4dVpRRHR4V2hqaDB1N2Z1Q0xNZDdNNTJaRlJzRllN?=
 =?utf-8?B?K2VxbVJWK3BhQklyMlFYd20yeE4rTEZFRkdrU3JtU2Q2LzVZbmFHNHJaVzV2?=
 =?utf-8?B?U3lYci9ZUm91WjJsZHFWekNEK3NUYzVJMmtNOXh5MkJhMnZ2Q21UNmQ0WTFj?=
 =?utf-8?B?YUFBYzRycEl2aDJFVUNlbnJsVEpweE1lc3ZzL21Qejlpcy92djRmUVhuVFdv?=
 =?utf-8?B?bXgwNjlhOUg1UWJuaWVjbnJ0NC9JTXVLYjdaOFNxWjVaRGdUUTBuN1IxalA4?=
 =?utf-8?B?NFpJcVRBUXFsbHMzVDFtTjA0eFZjS0tDU0tKQXk5Z05MdjEvNTZiblYyZ2hB?=
 =?utf-8?B?NnpKSWtZSElHRWczTVVuVUNFdUVnTFE2TnBFa0JZVlBYTkp1K0hzYW5QeFln?=
 =?utf-8?B?V2x4TnlHdFNlWDV4ZktucEJMd1lkWmE3Wm9EZThySnZKTmU4WXhrVjVjYVFn?=
 =?utf-8?B?c2x0SkYrV1diV0RrVm56OWp1NW51Z1FPRjFuUFVOcjRxK1VaSUhTS2ZEbXVX?=
 =?utf-8?B?UFZXMldraU5tVVh4ZllzOUhsZWpTY2QxV3ovYmk4dWRhbWRLM2JCNjB4NWJS?=
 =?utf-8?B?NGtMQzNZSFNOWWFsTC8wYWN5VFVwQjUzamUrN2JyR2xMTVRHVzg0bEZwOFhV?=
 =?utf-8?B?Yk1qTzlVUWNvaHJQbTBNSUJTdDY0NVJBaitCNW9LM2tCRnNLRVBZQzZUZ1Iv?=
 =?utf-8?B?amJmcFJMWFpaL1J1OUgrNkNqVXlLSU0zNXBWZ2wzbHV3RlQrOGZYSzlwYkhn?=
 =?utf-8?B?ZDA0TS9ySlRxSTlRc0hDVVF5aWVXR3RaT1JGeU8rL1h0ckQxWmwrZktVaEdU?=
 =?utf-8?B?ZFBaNE01MU8yQ1VkMDAraEtjUjQvMG9ZVmhFZWdXOGFDTE5BdlM4TGg5Z2lp?=
 =?utf-8?B?bnB2Z3FGUHE4YlE5MXpKYUJ3Zm5Kb1paNWgrTGxhOS85RWZhaWo4b0c4dks4?=
 =?utf-8?B?eitaZkwwaGY3bUljR1cwNjZMRnVyM3ZhSE5wbG1WdWtlcE9Ndz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d7a192-5742-4046-14ee-08db6cf03254
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:58:29.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI3lhlxyBxasgDtgYtXTt6hgf+xcilxItHSgNT6m7L4bnXV4FKYwF+8zT6F4d+818dH+XshkkT2/HwX8qxJATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_11,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140139
X-Proofpoint-GUID: gRUi0ctB_WiliWMrWHbtj_wSnodiPjtU
X-Proofpoint-ORIG-GUID: gRUi0ctB_WiliWMrWHbtj_wSnodiPjtU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230614 03=
:06]:
> Hi Liam, thanks for your reply.

Sorry, your email response with top posting is hard to follow so I will
do my best to answer your questions.

>=20
>=20
>=20
> version 6.1 or 6.1.x?  Which exact version (git id or version number)
>=20
> Our environment is kernel-6.1.25-mainline-android14-5-gdea04bf2c398d.

Okay, I can have a look at 6.1.25 then.

>=20
>=20
> This BUG_ON() is necessary since this function should _never_ run out of
>=20
> memory; this function does not return an error code. mas_preallocate()
>=20
> should have gotten you the memory necessary (or returned an -ENOMEM)
>=20
> prior to the call to mas_store_prealloc(), so this is probably an
>=20
> internal tree problem.
>=20
> There is a tree operation being performed here.  mprotect is merging a
>=20
> vma by the looks of the call stack.  Why do you think no tree operation
>=20
> is necessary?
>=20
> As you mentioned, mas_preallocate() should allocate enough node, but ther=
e is such functions mas_node_count() in mas_store_prealloc().
> In mas_node_count() checks whether the *mas* has enough nodes, and alloca=
te memory for node if there was no enough nodes in mas.

Right, we call mas_node_count() so that both code paths are used for
preallocations and regular mas_store()/mas_store_gfp().  It shouldn't
take a significant amount of time to verify there is enough nodes.

> I think that if mas_preallocate() allocate enough node, why we check the =
node count and allocate nodes if there was no enough nodes in mas in mas_no=
de_count()?

We check for the above reason.

>=20
> We have seen that there may be some maple_tree operations in merge_vma...

If merge_vma() does anything, then there was an operation to the maple
tree.

>=20
> Moreover, would maple_tree provides an API for assigning user's gfp flag =
for allocating node?

mas_preallocate() and mas_store_gfp() has gfp flags as an argument.  In
your call stack, it will be called in __vma_adjust() as such:

if (mas_preallocate(&mas, vma, GFP_KERNEL))
	return -ENOMEM;

line 715 in v6.1.25

> In rb_tree, we allocate vma_area_struct (rb_node is in this struct.) with=
 GFP_KERNEL, and maple_tree allocate node with GFP_NOWAIT and __GFP_NOWARN.

We use GFP_KERNEL as I explained above for the VMA tree.

It also will drop the lock and retry with GFP_KERNEL on failure
when not using the external lock.  The mmap_lock is configured as an
external lock.

> Allocation will not wait for reclaiming and compacting when there is no e=
nough available memory.
> Is there any concern for this design?

This has been addressed above, but let me know if I missed anything
here.

>=20
>=20
> I see this is arm64.  Do you have a reproducer?  If you don't have a
>=20
> reproducer, I can try stress-ng on amr64 to simulate your workload using
>=20
> mprotect, but I need to know the exact kernel version as this issue may
>=20
> have been fixed in a later stable release.
>=20
> It is offen occur under low memory condiction. Maybe you can try stress-n=
g on arm64 under high memory stress(e.g. reserved lots of memory).

Okay, I will try arm64 with v6.1.25.

...
> > following are the backtrace:
>=20
> > mas_store_prealloc+0x23c/0x484
>=20
> > vma_mas_store+0xe4/0x2d0
>=20
> > __vma_adjust+0xab0/0x1470
>=20
> > vma_merge+0x5b8/0x5d4
>=20
> > mprotect_fixup+0x1f4/0x478
>=20
> > __arm64_sys_mprotect+0x6b0/0x8f0
>=20
> > invoke_syscall+0x84/0x264
>=20
> > el0_svc_common+0x118/0x1f0
>=20
> > do_el0_svc+0x5c/0x184
>=20
> > el0_svc+0x38/0x98
>=20

Thanks,
Liam
