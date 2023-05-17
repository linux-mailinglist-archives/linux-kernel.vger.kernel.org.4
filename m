Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFAF7075A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjEQWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:48:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89D640CD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:48:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGwaL003384;
        Wed, 17 May 2023 22:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5l+Fu6MQrpc64TVlg9rFu4eD/EPPuMiwgotO5PQEBsI=;
 b=HvGepxTLsVeQadvYXRk/c4sdIdaHnNvGfHFTse705ZgBjfOUiXiC9K3YptoaX/vsz/JE
 hCQOA/3Z2bDznxcaPUnjH4GjDZapnJca7jT2Me2AeOy4uitPazpyItN+PKq2/0HnNUpN
 XahK6qDPe+Z9nXs7SHBmzjCnkQs/Vy6dY/FcQZ1eeY2HUCVfqd5FtXgCrlXIF8V89xGJ
 nw29zpJ4ti/xtqZn9KG6h19e17/ILuj5u/0psXcvSdq0nWWJTmr2Q9BYpTYf4BElB+pd
 X0LSNSCdz5F2KnVZ6+RVF/t2xkd7dgy3nNjyH6ivwawu5AcmUZyBTigUEYAqlxjgt8h2 lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc71q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:48:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HL0kEr032163;
        Wed, 17 May 2023 22:48:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10c2nk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU7ZaLWIehujslUZhB62wbL/wrarpyYx/cv2LJMuaAnhrHdI0fRLAXsgv3hq7+AEvyiQIrBKMBa5AwX0WfRI1X3N0efgS19FS/5jL55s/USnWCIMXpP9remhWHLkSJFdzJpx2jeRllQpr7oKDlXCFCnRU8NNyNplM1b9iSV4AnTSfOtz6h7eZQVlV8g7/7iHYHpyFDfL2aiuNeTPubnQ1pOm3csMFjIzIcn16kKQ7X7DQEkwhpdEFisfgnYjivfwhoDAOeMyzh3otFz+JHMF1sZac+ZRFCx+Xuabz9Uz+ks0STVIPo70qPhK0dMSRlk215WSsOh0cziJc4xYtvgyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l+Fu6MQrpc64TVlg9rFu4eD/EPPuMiwgotO5PQEBsI=;
 b=fgb9vrga9gsWG9wV7uDMyusiNoTEygywCdH70WKzitd7HFbrLpONRjzQSGS4kvLadlESIx0yaoH2a2SIrVEnAlgXa6VTllg00Gh10Nj0MxDACPSg8i3yK0Eri2ssMPZfFngO55zQ4/i9Y7UzJmbt1DQalNn3FIKjIJThfovQ6qxKRySvgd5F10/UlHbBVGQ73AbjFGMNUP7FrMhb4JJKqEmXryzJZB4uSS1+wu8O8JxWFlNwUPP7+CizMlqz+G+1aGfWIR+vp8Lplwa0ejEpNOsjZeLxtsdZlUZaBfy+V+KuGMmkN8SnCQPmNuBlLRLuv3Sb2K6qoCCOrVdFTXSDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l+Fu6MQrpc64TVlg9rFu4eD/EPPuMiwgotO5PQEBsI=;
 b=oSBiuIMv0WFTnaUUJF5F7mH1zhQFZ+DxAVuEM1IQ4qkMxXTVP1nkcUoi5MvVroSB0UVR08wZqgEHLT6QwOSRKWCSTJnni8/unm4ikAMVLA3/OnYYK4VL+GDuZfPeRF+CpoJgHRhDTBE9qpdGJAIvxwFgOUCS62RbfTOFDY5VBH0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4501.namprd10.prod.outlook.com (2603:10b6:510:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 22:48:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 22:48:15 +0000
Date:   Wed, 17 May 2023 18:48:12 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 08/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
Message-ID: <20230517224812.knkhqmrweggsbnuk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-9-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517085809.86522-9-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b2858c-41d8-4961-171e-08db5728ccaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzlmcSGMvWCt/F7R88qNUNkYK7A0V6aA5AMHeL9kl4DIrBPK1WtlEIELM6oZbnHhKmAp/jXQaFVgH0175NEq9Xmtk/I9zJ8x4F50Ufgy02RyahBZMhKxdXTwtICzFAdFTRFCukeAQHcm5dYdxveYwSH6Qu9rvukGv/JxsK4uBoky336BVzlb/1nj24S0AZsSHfJ2We5J9GUpTjRXRXpEd5fqhfWGQ0nj6xo9Zbn7Ha4Iv5IEw1Tqvj8vdEUgNlXKE5RbySIcjQvpLUMPEb63oSpBUgtJJVtqs/BqGLY2zQULl6FGnXz3KsX8CgGOHQEacp5vaSNgwwXpYF14a04fimlno9BN7/4KnUUITHcBoLQKWh5JQYPKs22b1ImP6biNby1P291Hhz8+M/NXfTaQtGmxSgGB84BPwiWT16kRRjuvf3MJdnEuoJCnzFhk14PY8KQqem8IVtoDa45HmgCLVbcubsKgRRAFl3Ye8Qz8KHbgKPbFjbHb4JIqolUTYgXBixMvrDMI4cHXvbTFUSKARuLM2awc7qkDjnpIil9gt4/X5jmR228XSEIgUc5EQWLS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(66556008)(316002)(4326008)(6916009)(66476007)(478600001)(6486002)(86362001)(83380400001)(1076003)(6512007)(26005)(6506007)(186003)(66946007)(9686003)(41300700001)(2906002)(8936002)(5660300002)(8676002)(6666004)(33716001)(3716004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKruYQa+W5VHu6/bp5ZpiFr3soFHdvCWqXjy3VSR49rv8fdAcwL4b10T5JUt?=
 =?us-ascii?Q?5kUfOckhRS4T4lfIIbDK371R0mEvYr3w4FLufadSZBuSU+VE7AncQri7xhgO?=
 =?us-ascii?Q?dGhva8fYxLMS7vJKiBkHl2ag8DOqVJFbH8uw6XepIDB7s4m0tT6BpKQIH8E5?=
 =?us-ascii?Q?UA0onIo/56jGVuXq9Vup0i4OUWMl6cyXqyLw2w0pYEWHLN2BgUarh6Qf1Qus?=
 =?us-ascii?Q?ZSDeFnWEye8+xXoiiX+cLoRpDywMeQL9iH6slH6ReIxbRhCMb4ggQ/q9ntns?=
 =?us-ascii?Q?rfGlDPUv3W1+ZDwIKRCFHDMf5OSDgL2S+jpF5hCE11eDiCeuruDsXZaAO00L?=
 =?us-ascii?Q?PsQRkh8fymVZlYF/0jKvHvXiCThmmkjk2j0T+pweL3Sf8XiV2jrf90hMyS0u?=
 =?us-ascii?Q?bS18meoPauplCgDZD9Cqqv1yN8xwSO+a74GCi9us7yWi1a0vkyljbDNfqXLr?=
 =?us-ascii?Q?efPwzze4i8Pa8vIvw5uvpq/ZpbCZsTUEbYxZy8Hzc52ym8qKnkxdS13o30fm?=
 =?us-ascii?Q?z3P0Y+/sFei1ieYJcpKft3ERK2g6bSIR8HnuURVUQFdG1fN+IE6tNOqgn+lP?=
 =?us-ascii?Q?Hlphe8ITJBwL5J32Nr7cH0/qyTLv6LMF4vgjke48EiFGN2FibX+zHSPskdc2?=
 =?us-ascii?Q?9svjNh4+mms44abElPbJvQqxquIBC9McAQrxcUrfqhygcdRHYKQPjeUo1QIb?=
 =?us-ascii?Q?YAEt2HTmZbij4kQfu22Q3P/T+dbLbkmKknrCvaywvcn+M0K0WFrIRGm8cKCc?=
 =?us-ascii?Q?9tNUrzdxk/mpdz6UTiN9iHVSlJhBX7OiG5M1RuiMSfeMXjVW/Po8veh9t+RS?=
 =?us-ascii?Q?ul6eq2g97qELcnnc5QDJBzN52XhFAPX/X++4yxrgg1RAz7ZmoPWhYW/5ElRT?=
 =?us-ascii?Q?4T5JjxrT9M3qSOSkCourgnIKxNFwQMGeda8mlXvO5NtUrY7uWRYYqqT1w5Gi?=
 =?us-ascii?Q?l2+sIoizzu+U/+Gkj6Y9zDcWg+yoLnRpQGRF8j66rrJYlIbrl4aSTKvdXCSH?=
 =?us-ascii?Q?TUQVu0mY+mSvffKX1tgLo5q69zKOFRfgxQVhpabncfvj9PIsuZxLkLjskIGz?=
 =?us-ascii?Q?tTe8pKNNQPY0vqi/6X6bPyVkTv//gsjwsVJAoClJH60ZHuSp8v+OkpkygpYF?=
 =?us-ascii?Q?2SgnI8dKo6VLdOxS07MT3DgYAv2FHsoi/nxvYBiilYC9XDLqIAyW8a2esrNW?=
 =?us-ascii?Q?0mhuYyJPestC7zn0gCMIpz7ZULLvaV4M89VdxhuGeMszOvSAwbRc0Kba/bCY?=
 =?us-ascii?Q?tbJj03Y12OgjOJgh2XVJSWe1wMxVP2TJxteNE2VJ950kq2Yc9+lrv16Cj7Sn?=
 =?us-ascii?Q?VpXQnyRfRo1+51JA9OQFeWQkKGXN7laWUux7c1eT7EC3/BBfOEL/cksa4ZUA?=
 =?us-ascii?Q?MVKU1pn2tuo6YtkPSdGdAImyt5kzr4k++trNbuECUgdZDjjQEOXxFcycyEw5?=
 =?us-ascii?Q?78jE679VWvmHOcc/pmYQRYbnQbAVmqmWG3TrN5HX45eiK0mjGAuNaqhdDiZc?=
 =?us-ascii?Q?HQma94QP9imrwbLMb1o5wvKcIjnOoetPIEG0GTWVqeH7i07xNHrO15Ppu4rk?=
 =?us-ascii?Q?A7tjcBROyq8bcCroM13NdHRoeNxHfSSrOxMz7ZaWchhoyZTz2AFLrLxrGjle?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VfMENmPJgndp4i14DPy6OEjTwamzI+4KCmAWRVDY0wHBFtZyDcAPJYKh40pG?=
 =?us-ascii?Q?Rj+cYlu79IrJZxAtUMxm4osZPqbPELqJswN0yhl4SJ5nELRcDlWQeE/dbaAy?=
 =?us-ascii?Q?lf1j/VeBS4nY/06QoW0wBfFBAmTIasmqGIbWSWKej7ZY+oRfKXvTX2PBF2p/?=
 =?us-ascii?Q?CiI2bVoRSCq+G33senqAOJCdtKHmgmfSEdH5/yQ5NkYtO+ZHUor2Meo44xS4?=
 =?us-ascii?Q?e+bhVJCfro1PP3lQXEkf8myZCfmULuzYNmAMad+dlwL7LjxkOt6jnGehcnIH?=
 =?us-ascii?Q?DWcYTHsLG5sSV/gATnTIjm1vRYmtDGYDNNI6olSR3r1b55O9CwIPcsPkTcPG?=
 =?us-ascii?Q?f6ku+cPFvOdnXvRx8wn2YjEm1Lay5lDL2fzM3ADGE3Gqyf/LAA8ADGzTJt17?=
 =?us-ascii?Q?qxtvt/pWe3Qk0aTO8fKfQbtFhVwDc1hjvYUR++x9XP3Z32c1rCpZj/fmcvIM?=
 =?us-ascii?Q?fqwR1tSRFOwwrZk5WHcXudwiAflH6e1zORn38ErjZgHvfc1bqm+3yy9nLvzg?=
 =?us-ascii?Q?MsjT9G6fSX50dK8mGNW40rHO3QpUj2dTwJJBg5KRDQqdfCo/7oDN7KmKMFhk?=
 =?us-ascii?Q?iB1csq9lhKV30FEXLT0Hmj1eBN3PoN8luVrx4haxBgLujO/WyzdFfJyaAdrv?=
 =?us-ascii?Q?su8YzqbfkZvzKQFfA51nfn1C3mO3sMBVx69kgbsS4tLpoacofHn+znRdW/ao?=
 =?us-ascii?Q?7YF9ISeGLuWr0pQHbxrXiv6PC2pkuPHdZZYgsSR8h3K6hzCBAge9k7KZQxZt?=
 =?us-ascii?Q?WnVXUraqUvHti/XEUzCDKoOpApJUfTsdjOAgONo47a1S8ZjgE1Xb93iGZ7kw?=
 =?us-ascii?Q?f5OKpjvlPbeOZw7TCn/ZaDJrFfP92OlvSwEw1dAShm8qqv7IhIdlZNUg89t7?=
 =?us-ascii?Q?o/qmvTsO0NWwi0eb9SxjiksjQGW5cFNRplpBfq/nRSAmUsLJ8UumwLdU7yeJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b2858c-41d8-4961-171e-08db5728ccaa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:48:14.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqg6s1hJXO1jMZ+t3UO79xOqVCgcjsfkhLYejNUB6+2yPmv939zEnCyNnGHZUuqMFc9YzWpCgjcUXh+yxIL5Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170187
X-Proofpoint-ORIG-GUID: eQlvyV_0aRFEHnBi4jT4Ag8ywcM_lfC7
X-Proofpoint-GUID: eQlvyV_0aRFEHnBi4jT4Ag8ywcM_lfC7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
> The code of mas_wr_slot_store() is messy, make it clearer and concise,
> and add comments. In addition, get whether the two gaps are empty to
> avoid calling mas_update_gap() all the time.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 59 ++++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 35 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bbe4c6f2858c..25a8b7d5d598 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4200,49 +4200,38 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>  static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> -	unsigned long lmax; /* Logical max. */
>  	unsigned char offset = mas->offset;
> +	unsigned char offset_end = wr_mas->offset_end;
> +	unsigned long lmax = wr_mas->end_piv; /* Logical max. */
> +	bool gap = false;
>  
> -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
> -				  (offset != wr_mas->node_end)))
> +	if (offset_end - offset != 1)
>  		return false;
>  
> -	if (offset == wr_mas->node_end - 1)
> -		lmax = mas->max;
> -	else
> -		lmax = wr_mas->pivots[offset + 1];
> -
> -	/* going to overwrite too many slots. */
> -	if (lmax < mas->last)
> -		return false;
> -
> -	if (wr_mas->r_min == mas->index) {
> -		/* overwriting two or more ranges with one. */
> -		if (lmax == mas->last)
> -			return false;
> -
> -		/* Overwriting all of offset and a portion of offset + 1. */
> +	if (mas->index == wr_mas->r_min && mas->last < lmax) {
> +		/* Overwriting the range and over a part of the next range. */
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>  		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>  		wr_mas->pivots[offset] = mas->last;
> -		goto done;
> -	}
> -
> -	/* Doesn't end on the next range end. */
> -	if (lmax != mas->last)
> +	} else if (mas->index > wr_mas->r_min && mas->last == lmax) {
> +		/* Overwriting a part of the range and over the next range */
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> +		wr_mas->pivots[offset] = mas->index - 1;
> +		mas->offset++; /* Keep mas accurate. */
> +	} else {
>  		return false;

Again here, I think you have already verified this will be a slot store
by offset_end - offset == 1 and new_end == wr_mas->node_end.

The checking of the slots for the gap could be moved outside the
statements.  WDYT?

> +	}
>  
> -	/* Overwriting a portion of offset and all of offset + 1 */
> -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
> -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
> -		wr_mas->pivots[offset + 1] = mas->last;
> -
> -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> -	wr_mas->pivots[offset] = mas->index - 1;
> -	mas->offset++; /* Keep mas accurate. */
> -
> -done:
>  	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -	mas_update_gap(mas);
> +	/*
> +	 * Only update gap when the new entry is empty or there is an empty
> +	 * entry in the original two ranges.
> +	 */
> +	if (!wr_mas->entry || gap)
> +		mas_update_gap(mas);
>  	return true;
>  }
>  
> @@ -4396,7 +4385,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
>  
> -	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
> +	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>  		return;
>  	else if (mas_wr_node_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
