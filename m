Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C26EE546
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjDYQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjDYQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:10:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDE210A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:10:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFx4s1004532;
        Tue, 25 Apr 2023 16:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ikCEGZvxdgF05fQnplUhhgPaTSGZjJqxs0eu3+sltN8=;
 b=cCAWKOBjO4nG0YT+6EiM/8qx3WBFSWtIkBhBEythGrbpHPYmh/PyKHGUE8j0+WlcZkOq
 7s/qsGBazjrRCiRnLpd637dl7khyrzgaAR3DO3TnJMwNV39uEl1cYWDPaAkXAORPFQD9
 oE7Y+KkGPDPfZ/dCq5dPQiVjbvdKaeSfaUZuI4PdBJRnrYXWUH7AVwvLmmkZBUrPvACz
 lOD06VjKR9EvCEcu5tNkB3GqdEllJ7nZT2tYG9kefv8HoiHGXzm+RjkENGynksfTRWzn
 sfznO7N+kiNi8p4hHXqN635+fI/lk0fFhfgo/xsozQU3VXwez/dBSrY3NmjB/uPxf3Vm DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5vax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:09:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PF0QGH032750;
        Tue, 25 Apr 2023 16:09:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616wa3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9UOwu9g3bj8JrkCG4zi0mXhdSFdZsnJTEkUZ2E10tDLeDQL6ufZxL4W9IKUWK2zcu+wbAQ2JP8k1TZVGnI8moiQShXTsibn0LmadfMODzDvSjp17IuoqzM0awTJotcOh7JarfXa2pH1z7+cZf7DcP6lkTQYIVgiq+TM6pyBWE6+vphx+2uGmiphj6YvMAs/M1/aQwndeEwkCSXxahS+pTc0KTuzneCUD329FR+Ixy8oBpjt1kpoif2Mn3SPPevCUXrIyx6kIZyaTGTmPj5NY9VyNHb4ZbwxD4c+wSvCvZ1LFNhScYkBNNJD99EHOnmKAtEALIPUE5XnQIFuUSgHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikCEGZvxdgF05fQnplUhhgPaTSGZjJqxs0eu3+sltN8=;
 b=KMEH6P/xJQM6i3cbCfBYgbs/pIZUz44aPxH2iK+7vVOtEU0domcwejStDJf6JHtg+p4+CW0h+nVSO2FU6E5Od1Q4mO2xqXZZIk+Cu2h/kMHXYifSn+6xByNnTWBzRLZKvTW51cuTXlhmFBEX6vV4/slHRUH94v/hpBkbxbbBUd352p/Fi5SLGlAwoph+BBpdbKNVWzvji4Z30djpDZ/m4P/O17QaZ4srKK7MLwdrscG+f/RRCSMBvKD3DX1xzYzMfyVW8sUkVlQRnK8NP5Y2aoa10tA/wACYqSfkat2KARNwL50ISj7iyEvVThlyp75bMmV2B55C14plwubaGkM09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikCEGZvxdgF05fQnplUhhgPaTSGZjJqxs0eu3+sltN8=;
 b=lRCsfbLRJDwemAvOZW7tNogTsUqYRngxm02ukUNSMqUf6DO11M3gtLx2dv9dCKKKTGlOaWl1t0pT0Y8wp5ouLTfquZataiVlD6YmBZtCW6+eYrdDu8d/AfJHGv3yLdy1PMmDLTk5WRQKNjpwcCdZicq5ccqLVdrk7TLg00mapDc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5235.namprd10.prod.outlook.com (2603:10b6:208:325::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 16:09:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:09:41 +0000
Date:   Tue, 25 Apr 2023 12:09:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 4/9] maple_tree: Update mtree_alloc_rrange() and
 mtree_alloc_range() testing
Message-ID: <20230425160938.2fxuemsai6nk37hs@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfe90a0-0e2a-4c17-aea3-08db45a779ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZH/7y0mBmfipFZyMRv2HuuVol128eq94VcNqxaZgm7Z3kLBEkZ7zElly9zOrxXkh55SQufekVQHMLOdE6Tu+L3rnVtQr36ikwaIZzCHeaI8w+JcUAcoJtlMqERP3LSmlMItFfQGUt3AehtxzeArfF3N+6okajXJmX4a26GlnKN9dP8nMawgz3MO0LZDOFbtrfWH+e1tG1MoNXgJyEE1c4+GIoAcHIsgvvLialabVNk5i3VCE0KbeGTx5Kcar1dmmMRDQJkCW8nHVj3VVdxoZAE9HyoxGEl2MzIvcDrWQzfhjZE9UB8aiLvM6dIvmplDR167bYmRD2w4eAfXIpxQYYbJjhjy/5TTfJ9YCmfYcHHnCBjLbtz+Uwe5RJRA8sKMHbcDN4OeR5YY2R3i2XZNhLbYicax8GgAocE/277Acsg/E2L0Jfb1YN2lF0AQshYd7oQ8a6Ojbv8z7FN6Kl51Ibl2oLDjinuO3lEu4Z8ZGetYV4sV0/xJobLFojUIzkC0baw0gOe5iXnshJhWETZC008ehHbM0p8JE6tuZMsxm8ZSdcKHaO0V51ZBx0l6O1WL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(83380400001)(478600001)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(186003)(9686003)(33716001)(2906002)(5660300002)(15650500001)(38100700002)(66946007)(6916009)(66476007)(66556008)(4326008)(41300700001)(86362001)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xmMbqDpAE2S7inRZ31LLtJ/eGVmbDcc/x/0G67r9xXYDifsdr9ANhyOmoA+s?=
 =?us-ascii?Q?zW+OTz3NR9Sh0xOjcwyN+BgIaimMOxAipAifeVvAuYVVir3Z0DTyyAFXeJ1G?=
 =?us-ascii?Q?g6Jj78noZAdK6KqpnNUZblnio/gwghEJh2l9Q3gHrToZinnkj5lZ0Hst6mzJ?=
 =?us-ascii?Q?8rWbrqUHbvUFvEI8ZT79RYimIHc/p5wFVdx1thQIigeEv+yz1TSogpZjV6kG?=
 =?us-ascii?Q?g+KIXMkvxbIh0XLHXdx7eOn0Yszrz2J8E8qYmonSuXLF6akmCz6QN4yJATz1?=
 =?us-ascii?Q?4mYSDxlQZ0XCbcXnyt27IJZEiQwvYfKWjlmoWr/KzjkaMdqAJgIZOjg11uV1?=
 =?us-ascii?Q?59bL4z7jbswCAWYE3/6a2Dq2RZ3uy8C61eC1flPyqqUm1BXkLGKP+90+Goll?=
 =?us-ascii?Q?CLd9yCoq3ZJM2fhl219ssvzKehLMjut72B9GRYsLydS6RG0cow2wqYor6NV2?=
 =?us-ascii?Q?PLgGPbL+2bTQQ5LtNqigxaWtbg1CLPSgNGaQ7HOwB2cOo3NRO/eZyYiGRVD/?=
 =?us-ascii?Q?kV878i/NxR+WW5UakfmsMSKG5udlAhVvt6q1/qXQJ4l7BrRrMUn6pGSWuaOY?=
 =?us-ascii?Q?kDI8ZRgp6we2n+NwxgrVc0tA1QFjnn1/DG+Hno/sb8m1gOXklJV3wAq4Gyit?=
 =?us-ascii?Q?s5eHrVioyrKkpvlyNp7UC4exjC488njkElFHBCA1D3HSBIu8kAEq5/bOPEVl?=
 =?us-ascii?Q?23//QYGWgFOilOk0JosF19pEboAHHzLAoyznXR6vsX9nhTyvz9gH8LDMn9B/?=
 =?us-ascii?Q?uFle5AhVWwF99AHnM18byD4mUc5u1RSabUSNnzzFTmzI1q5GNLgC9TD8aJlJ?=
 =?us-ascii?Q?qjZ7dOkM6xTLuY4igOBf77PE39NlfRFpXQ1jK/YkFCMujIjFxGvchjY0S/g7?=
 =?us-ascii?Q?xH/ivFPQ+JSr8CZ3SWsKz3fplhu4fX3OzZV3qGAu/RNbdzB0UB/75PAxGOh+?=
 =?us-ascii?Q?JLZ7w8SoJXaj19s2Nt0Z+JWOTiFrr7wwhTqeCr92YLY/WSFs656y+oIdjIAn?=
 =?us-ascii?Q?q6Y+49dCDdMu2dDcPfCruHxvZWi1e428dFdnqXAZDd1ARmKvMzXySksGrpti?=
 =?us-ascii?Q?dmnc7a2OtDVeD0kdBnPKf9r7fj+VQzX7jB/Sfwg+WJgYsM6iqQtghtEArNcf?=
 =?us-ascii?Q?52xdUCW9nf9+tzyoOUX+wuz0xVfre6w2o+VGdGxit6BsHU61c++CU00weGjM?=
 =?us-ascii?Q?DBKAuPPGqoXg8a2vCd6WzTPhTr7nBV7gly3oDbW8qV8kbWK+iieuaTXJlwAW?=
 =?us-ascii?Q?0nsIfSj376soKl695GRlbT1O85Lm+b1l4WHQVwmfJZSW7T6XY5mPY3g9lyhw?=
 =?us-ascii?Q?LqXXMX+u9UODX8r3XfdcDqMVORqrkS0qO3P0G6ZTQBX59b05vGyN+0sNT9jP?=
 =?us-ascii?Q?1rmuxpziv2cQBMrKWH/JFNzT8VaF35DnzMlAhGr3FMmut9fQ7G2pwlgHbxPq?=
 =?us-ascii?Q?G2L0Kr8xAYdk6cOZpTAZhfPQbBKambXpaZZtw3K1wAaAkqUs6z7SSqeO7BU1?=
 =?us-ascii?Q?o/NF0gvAS3Dc9Uu4QciMikmvch2JcR/KnVARwjedlcU6bIOqYzvSBRuydFtE?=
 =?us-ascii?Q?4svCz+9+xM4RxmKVFHfr8sNxizqCUOJJDidbFioD7WXFBqfIU2Bxde8mNiUG?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IFOsHtRfIeF5JyXognOI7/M+Phh0jgO32CtS6rypp3NVFw6dS48pPtQYdfdG?=
 =?us-ascii?Q?QAiYacHtMtIkJ8dzbci1Jq0O9VIep2j4Giu/YsL/qhhA2taB4A7otF+fpuJv?=
 =?us-ascii?Q?mtqk19kkVJ3vGkut/NHzwHPunrelI7Ity+XYi3BXDQoSsxt+PdA8K605Vl1j?=
 =?us-ascii?Q?Vb+Qme2xPQ5cp+rDBkBeTx4fDSn7SnTSXW3L3wxaYDYRUmY/4As7M+nvmM3W?=
 =?us-ascii?Q?MMaMFdRSQPncxS8nZ/L9LakBhG79LluKFhQxO9uHpX9/kkrGI+R0qbb191yz?=
 =?us-ascii?Q?vPuHizn2T0prheJgIUPes/JaKRvmAbuOeQJdG5MHuR8yUH5E5bmop8a7AMI9?=
 =?us-ascii?Q?7e5cBTtql2J7VAapUVNkP8qqk/xd98RnFqkbGZpyGS0q9vhJY1aPC6VDJUAn?=
 =?us-ascii?Q?SN7cUPUBTyvIaNKW2PaO920gh+wBxOGWBrfF+WrjfOlApphd+p4hFdlixykK?=
 =?us-ascii?Q?AaWA02SUKgO5+8IzT/MDboHr6jdvHWPfqjT468hweyaTCKt+89UM8LBpwW5C?=
 =?us-ascii?Q?H0Og7j8za1K9Tre3BCbSLwJ7F1AtGjpRGZSpfgd44Qzi1OJrPu8fqTGDpD86?=
 =?us-ascii?Q?7WUmcHtfW/apSuQBq1vmgP/L2oqzEh/TSHtd/yY0WwNSsnbkaoEau0pxu3dD?=
 =?us-ascii?Q?PSoiLyn1nUfvH+ciXhZO/jDpCBfOkz8XcUxyWpEFCZsnp5YNf0HhhxODAmsM?=
 =?us-ascii?Q?0hCOHuC8vWH/mmEQvsDj0KmLISnRrQXzqn3iIcY46QGIOfgUW7KTYdAyzhK9?=
 =?us-ascii?Q?2Q0got5MUGOY4ic/4ER+Vzi30FZmNKSE40LfJ8rFKXqlGUD1EMDdc0uQoddT?=
 =?us-ascii?Q?kJgz0iff8AUEnd/TKk2Nf+KyTCoWw9IoIJLwkRLMrrqcg/J9B5NVE1ASRnHp?=
 =?us-ascii?Q?eMILQOpNc3XDC6ROlU5SK8ljpeu1FTREtMefcClYWeDH4JUiW4qICPEdJCcd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfe90a0-0e2a-4c17-aea3-08db45a779ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:09:41.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWQ0fVYyMZgg0QpKF+8GDV5Nk4i6plAjlbWbHJ7kywOjtVvE16zwUgs+a4uE9vgEG4rZoYlzVyO15Gr4fCajww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250146
X-Proofpoint-GUID: 1tiO3y3MBTX5eoJ7XtAjDXXMHNm_Bw1j
X-Proofpoint-ORIG-GUID: 1tiO3y3MBTX5eoJ7XtAjDXXMHNm_Bw1j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> 
> The previous changes to the gap searching made this testing fail.
> Unfortunately, there was not a safe update order, so fix the testing
> now.

The testing will need to be updated to use the mas_ family of functions
instead when the mtree_alloc_*() is dropped.

> 
> Fixes: e15e06a83923 ("lib/test_maple_tree: add testing for maple tree")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Co-developed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/test_maple_tree.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index f1db333270e9f..30f2ebff95d75 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -102,7 +102,7 @@ static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
>  	unsigned long result = expected + 1;
>  	int ret;
>  
> -	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
> +	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
>  			GFP_KERNEL);
>  	MT_BUG_ON(mt, ret != eret);
>  	if (ret)
> @@ -680,7 +680,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
>  		0,              /* Return value success. */
>  
>  		0x0,            /* Min */
> -		0x565234AF1 << 12,    /* Max */
> +		0x565234AF0 << 12,    /* Max */
>  		0x3000,         /* Size */
>  		0x565234AEE << 12,  /* max - 3. */
>  		0,              /* Return value success. */
> @@ -692,14 +692,14 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
>  		0,              /* Return value success. */
>  
>  		0x0,            /* Min */
> -		0x7F36D510A << 12,    /* Max */
> +		0x7F36D5109 << 12,    /* Max */
>  		0x4000,         /* Size */
>  		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
>  		0,              /* Return value success. */
>  
>  		/* Ascend test. */
>  		0x0,
> -		34148798629 << 12,
> +		34148798628 << 12,
>  		19 << 12,
>  		34148797418 << 12,
>  		0x0,
> @@ -711,6 +711,12 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
>  		0x0,
>  		-EBUSY,
>  
> +		/* Single space test. */
> +		34148798725 << 12,
> +		34148798725 << 12,
> +		1 << 12,
> +		34148798725 << 12,
> +		0,
>  	};
>  
>  	int i, range_count = ARRAY_SIZE(range);
> @@ -759,9 +765,9 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
>  	mas_unlock(&mas);
>  	for (i = 0; i < req_range_count; i += 5) {
>  #if DEBUG_REV_RANGE
> -		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
> -				req_range[i] >> 12,
> -				(req_range[i + 1] >> 12) - 1,
> +		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
> +				i, req_range[i] >> 12,
> +				(req_range[i + 1] >> 12),
>  				req_range[i+2] >> 12,
>  				req_range[i+3] >> 12);
>  #endif
> @@ -777,6 +783,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
>  
>  	mt_set_non_kernel(1);
>  	mtree_erase(mt, 34148798727); /* create a deleted range. */
> +	mtree_erase(mt, 34148798725);
>  	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
>  			34148798725, 0, mt);
>  
> @@ -880,6 +887,13 @@ static noinline void check_alloc_range(struct maple_tree *mt)
>  		4503599618982063UL << 12,  /* Size */
>  		34359052178 << 12,  /* Expected location */
>  		-EBUSY,             /* Return failure. */
> +
> +		/* Test a single entry */
> +		34148798648 << 12,		/* Min */
> +		34148798648 << 12,		/* Max */
> +		4096,			/* Size of 1 */
> +		34148798648 << 12,	/* Location is the same as min/max */
> +		0,			/* Success */
>  	};
>  	int i, range_count = ARRAY_SIZE(range);
>  	int req_range_count = ARRAY_SIZE(req_range);
> @@ -2660,7 +2674,7 @@ static noinline void check_empty_area_window(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
>  
>  	mas_reset(&mas);
> -	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
> +	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EINVAL);
>  
>  	mas_reset(&mas);
>  	mas_empty_area(&mas, 100, 165, 3);
> -- 
> 2.20.1
> 
