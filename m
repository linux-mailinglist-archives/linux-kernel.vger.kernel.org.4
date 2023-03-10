Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95C6B5021
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCJScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCJSci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:32:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118C108C31
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:32:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4ROn016561;
        Fri, 10 Mar 2023 18:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PRt8lMqbN4KwnBC9JqXDz/DfhgdzgXGT7bZeFqX88WM=;
 b=fEGxQbdd5/ar6jOtaz4Bm8rHyGq5WmEkdGpY2uStrCHCsnPKn1a99ZVxF0VsBC2m2eWj
 6Dpgg+bsXUOKfkSFX3q+7ZxQOthpP1GJA41mbgQZSR/LzjYqSHA62RGu+aMDsKlf/aWg
 aU6mirLRtpvKM3qKGUkq2RMKObdtQXqT+fZx1lKeyQfYNDt2XcJ0sJRT9QnU85lBU88b
 hWpqVg3t3n3GaCWRffhf8OLTj8txMZhsmVCmS9GEsX3jxL80u8KOfnwfUhhb5aL/mrfZ
 zAyURs0dQnpGeCm6+o/cEq2TgPFJIE9+jN0O62RYNnv5Y2AnDM7nSChF7+wy4oxX6Ye8 wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn9a87u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:27:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHUXmX005146;
        Fri, 10 Mar 2023 18:27:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g4k17pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaIKjqroAnNB9Oge9pj1nrE0Ij41cBOqTwoRhuAQgKv9qqdNztJNvkz4PFwy1PpdTxvOzRMKjzKui76jkbZL80hDFqfCDcaDw1s5XlS/mak7PKkNTSBafPAtb+Ja+74MPkATY3GMpFlzC7+0kAbZo45o4kp4+UfHqfFzAFiO8ricvu/obIOBO01jq4V+P7osrbnDkSJNdvD8Bd/ZCWIuu4TrTtokZKlqWr0+qs3RmfkGyzWZs4unVNbinxzlP/UaAMSG9d+OV2iJUmlH2D8NPzrYewcep4gKxFBqwCiW27Ux9hdOZmWpffwjz8rWZDvS8J8FeDc8i2QVq0h+YnAtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRt8lMqbN4KwnBC9JqXDz/DfhgdzgXGT7bZeFqX88WM=;
 b=VcxZA9uUp66pVrlCdhm4sje+H4mGsBTQSjTVHhRRTvVKjRuqqZSedPC0IPbZgz1cKULAdzgwYSD4yMb6+EiALQMFpY4RrhR7SSc/j1h9eoRMgskCRtG42gqVQbsmqorP1EkQb9Zpk/wwT7LAw7OtTHMDVw+Xy4mcoU8UMZkM3BnD9TTavrczyeAHkHj+rbznYmZEdOuCL3F0ESRBw1RGHpLzYIwuSh2tqGU9uWW2AO3c/e46vGx4eEyCRTNKX4IGf6rIhPu3oQFuAwq96kqweVV8zFCIWfm/upQB5lQHkl8TQMnOHx+PvizgemAVkvw7jXNFIXmipsY+DAghp+auEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRt8lMqbN4KwnBC9JqXDz/DfhgdzgXGT7bZeFqX88WM=;
 b=ChvwaKpuh0sK0ZFgApc6Tz+PZgJiHi+VDeWTY7NgB5T3A+OBMG2aorc/bUMHL0idAFBSHbzmm7+WmhbFMagTn+g8GGmYAtk2Vg9JWjoR1sEPfQ0fn5ixwxoU9CCpkbSAsgJ8ZnhvPldEuv/PJcSL+yu/GSVOzV3FrMUsgdaVsFY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:27:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 18:27:20 +0000
Date:   Fri, 10 Mar 2023 13:27:17 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 3/4] maple_tree: Fix a potential concurrency bug in RCU
 mode
Message-ID: <20230310182717.csx4qgmvfvtc262c@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140848.94485-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: c790ae19-59d4-4d28-9b33-08db21951608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5hg7fDSm1WfMZ5ibyJYbjEvx7ZI84tv0TiCFJnNI3Zp8bEotcz18hU/4Vm5nXccXwjU7RhNYrplTZgCFQIQ8uDLFSuf+A2iCfCZs+Qhm92fX18It24+XLfk0/5EHRW42FPZuuhXvpzv3L4PusV7JWWY0VdUKVpPic3oYEjem0i14iBKrw7BLejl5HkwMGFf5CUfmP7Mvwa9i2iqmIxYvyE6ygRwjJjO9QvCKxLydQq7aNbGDbh0q7ocvuGjBlj1gpgvEujM4UY99e+rTG/uOZQyvafVpMKVUmF/RW/BpX/esJypArpmV1QCJqjIvCttK6s8JBWsA6pRDTf6Hb8d9jjjIS4/B842zCQzq0aj/FVAJU/it9Uez7SCZeVLs3x/s0udYjIbmpb+nKDRrodr66kyyq5KXyg7V6vyL+sK2ZNGrdM1tifn9pEA7Kn+fd/4E8e+FsN2X9jS8QVoNKo0fr8Zx+K+r+qpNmxVYizX1iIwYwNbXBKMZ9/5QIeqGkiCi7Dc+c+VuqNx+YlAJK38rbBsZeFGYHO3D2umMdgbTeBO+9A2s7AieY/qN6o9l646GYnqDNCqdwCP6q/ULYx0i27USr1/ZOOOxiXvxpqqvkKKw4gP1HQ/UFkQSipQAqUo5wN34Aq24YmNsQ7CHm/Tig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(6486002)(186003)(86362001)(9686003)(38100700002)(316002)(33716001)(6506007)(83380400001)(26005)(1076003)(6512007)(66556008)(6666004)(2906002)(66476007)(41300700001)(5660300002)(478600001)(8936002)(6916009)(8676002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VKiYyRM1C9/UjfLVLTJX2I2gLQAcLj47dFXEeavYEGbDkoikXwe2kdPd5Bw?=
 =?us-ascii?Q?XfsQ3WrTBgDGaYnySaMuDmVFWTYnAWR7cPTO21ZhYr7wwGmZnZCbUVkqj/ZG?=
 =?us-ascii?Q?5l87EaRV+/vsVsuIW4xnYTwSumWfPF0Pv13L5JEkHixMx70GYP2SwzSGZ3vf?=
 =?us-ascii?Q?6UIsZAlOC86QAHsmKaTLvkha0GlIfARyLh508NnbQYQnlnx9rXsCJDGygKeI?=
 =?us-ascii?Q?O1GZzINUDaHA40Gx3azASNRJIrXvniXAo3ha/QUReZLvY6MWSmjW9mmzwVV9?=
 =?us-ascii?Q?OTmuGSdTYBbj1dKAIsmUAV3JWvoSGs5MRby9C69qZFZz4RU3NlIkkXaG80OQ?=
 =?us-ascii?Q?mMB2VN4wmhShl2CKKapX2MaSMCzyDzwpupCeq1SEBnevfvNv/ObxpvoyQXMQ?=
 =?us-ascii?Q?q+wchz+b0Dm7K7j3GMQV21NRSU9A8VQlZ4/Q9ddUuwhWfYTctY0iWg7vqooh?=
 =?us-ascii?Q?UTeitc6AI1Ph62Zx1cx/oUmG9Hwm2kUXSQ6guhFSX1D0sgKoIYjIPkiDZuZv?=
 =?us-ascii?Q?oPZhDpIxKPudIX4gjBtA/6dTLiwVVcH5avGFzKPlZmHzCzL6863rgTjk1iRm?=
 =?us-ascii?Q?sU/mDVgDDfCvDNHOMJ/1qT6KP9yiNyAIL8TbZtzNNyKPVxy+TM+bQZEZGwOw?=
 =?us-ascii?Q?LVYxxaKvGvSjE1XHstqPmBXzWkKbhYSuwJJAtheGLg+30wswV3cFZZrWIKX3?=
 =?us-ascii?Q?57/SnlN8yKc3EwSR9I2+RuqUQhOap9jmPLBxwYTNzbwqfw+3gMPUhharDGTA?=
 =?us-ascii?Q?IFdNkzD7hkD9nIpK4exmpYAAV3fg1b5FT9sDlZr33FNSHwam7tQyXze6OhAD?=
 =?us-ascii?Q?+5LAz2Oew5zKrfi5VxDVWYfFQtURIRPYtDKVz1T0qDyvNIUkRGCM5VYPKi0L?=
 =?us-ascii?Q?THUNyUWauACK0WmdJndPV2UryqiSPTtnl+Yz7TEy29Zr3Lis2Lg7kUrP828M?=
 =?us-ascii?Q?YzxF7peyF1MbO2e5LtYat4hldBhP1ccMv3e7KU3lRItWheN0ImRZh1OW0bia?=
 =?us-ascii?Q?NKXRKNjVfuYftBxdWQZQoxnKeLsi43Jl7KFKPDMV/nAAKcnK+q251FpXp7BJ?=
 =?us-ascii?Q?Hr2lfvExIDgToZwQs9Mm8Ah9xT+IwT7/zLM4Ule5W/4U8AEKKd0pm3fP3a/E?=
 =?us-ascii?Q?Rd9H14vitgWJT+/Gyv0wOmDBp3dFYH043Sy51s0mGz30UNxDjCjrbzMdNH/A?=
 =?us-ascii?Q?emIhBwIXiay8dakau4I2jdA/xmm4t0m+IWExioRoyn9+X5LzYyoG87DnPCmV?=
 =?us-ascii?Q?XtWX9PRxmKpXeLUDXh7XBK52NUFmFWsRMXTrHOHDBB1GRNPoX60I81KuCyvw?=
 =?us-ascii?Q?Otar8HKB/qj4suxEZQQ0A37bONlZ8hCAdxzIXk5I5wFEDKY98B/zLtvE0n3z?=
 =?us-ascii?Q?5ukP3hZeiKw0/QKYFPJLTOcWME4RpCfB7autqL6uQScwBTEEIy3Vs/PQaJ30?=
 =?us-ascii?Q?o7QuzRlt34eKnNpJDnCB0tlVckKlgioDj4fvqtLybBZ9FBZtN9zrI/XAbUjd?=
 =?us-ascii?Q?TRwfiDSyFkv/Xctnd7Tea/0XnKafWgySpfBKJb7bjHLSy3vMN2UIvUcjLV/M?=
 =?us-ascii?Q?hFXRNSKtAEysLTDiTHFWmfrKn6Du6ZxaFTxhrcGkQnjwn05ncOjTbKDW1DCc?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QZel6agyFqGFztpxj9HQ7jRR1H6j9CDQI0BAoM3stwDMqtahbxMTB32vYfRh+cabG3PFUgyV44RMxehugT7eCByNu5+Ba2PtWQf87m6WcfHSYUzLm1udx/Yg7WzzYbmwwXHreNZghD6RHIhMcQ6GHwoTQDLooWxM9GyCK3OWehXk7MUtySjmkFcv63iMFzfB/zmhpqKxIjQPWZiyvdPEXxziI93CDKA5g58lRj5B1Qma9b53pABK2zrdMIR1jj2hJZs84gpfoY1jgMyvhrQTKoYbx4UItROsv4jbUtoy63S/lIZpN0TH2R7+98cAqUWWe8/taz8wJjAaqu28CBmjFYKKS13PbxSkYYKWJpsF2wCHko98DPsK9Zgllv6lckKsRp8AF6kkKGRKfX3747RuDFStSJs0vDGMOppq8FmnbUcboHKHlE3zK/cN2oSSMjY/j0CTgbQZwn5BfswYmioJbogLBcef4gUceKw/Sks5NLYkqn+WbXR4tUTu+rg1ny6X+wVk3Y0fvfG2gO5TTfUYJyv94iMagdXR1dkiuSh0ksmuI6ZjbiBYwDiu86O3bBsrCk23biWnST5t92um5lWsZKFsBmJdVcKvJZ4uRw9dPZXjx6cXbJhK7t4GALo57z47PnYHPrPf/AFeNZqgEAmo0qTDas8vl/SQUMStAhuqg6Wqx8ELtiadT6w7+xbD0mfEdC3qZpcHmJuyO7JTKY2qSFgn2pkk4N+YVp0CkXbtKNxrY3LFxKhEx2wAFCNCKpiDv9l4FwyKEfVxH3I7wmPTl5cITDjOdcAKhWPfinsjZd/lbgCClW0lsTQGU4dXqBc9q4pwP/30UX+POi3fg3CsYhJbTHMfDpdQnQlHKdC81zzUIBv5Zt3MuoZJtP3RzcAg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c790ae19-59d4-4d28-9b33-08db21951608
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:27:20.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy9nTlqvd9hiLjD70hAjKvEIqAwPfBVl21TcBKkVXXah7MrSX0vLyFDGQ9uqYXC4uFUcqGG0Y3CJtdEhB6CFfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_09,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=952 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100146
X-Proofpoint-GUID: 2EATcetvp6MBGMSWc3MzDjPaV_AMslFO
X-Proofpoint-ORIG-GUID: 2EATcetvp6MBGMSWc3MzDjPaV_AMslFO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
> There is a concurrency bug that may cause the wrong value to be loaded
> when a CPU is modifying the maple tree.
> 
> CPU1:
> mtree_insert_range()
>   mas_insert()
>     mas_store_root()
>       ...
>       mas_root_expand()
>         ...
>         rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
>         ma_set_meta(node, maple_leaf_64, 0, slot);    <---IP
> 
> CPU2:
> mtree_load()
>   mtree_lookup_walk()
>     ma_data_end();
> 
> When CPU1 is about to execute the instruction pointed to by IP,
> the ma_data_end() executed by CPU2 may return the wrong end position,
> which will cause the value loaded by mtree_load() to be wrong.
> 
> An example of triggering the bug:
> 
> Add mdelay(100) between rcu_assign_pointer() and ma_set_meta() in
> mas_root_expand().
> 
> static DEFINE_MTREE(tree);
> int work(void *p) {
> 	unsigned long val;
> 	for (int i = 0 ; i< 30; ++i) {
> 		val = (unsigned long)mtree_load(&tree, 8);
> 		mdelay(5);
> 		pr_info("%lu",val);
> 	}
> 	return 0;
> }
> 
> mt_init_flags(&tree, MT_FLAGS_USE_RCU);
> mtree_insert(&tree, 0, (void*)12345, GFP_KERNEL);
> run_thread(work)
> mtree_insert(&tree, 1, (void*)56789, GFP_KERNEL);
> 
> In RCU mode, mtree_load() should always return the value before or after
> the data structure is modified, and in this example mtree_load(&tree, 8)
> may return 56789 which is not expected, it should always return NULL.
> Fix it by put ma_set_meta() before rcu_assign_pointer().

Are you able to write a test case for this issue?  I understand it's a
race so it may be difficult to catch.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4d15202a0692..de43ff19da72 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3635,10 +3635,9 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
>  		slot++;
>  	mas->depth = 1;
>  	mas_set_height(mas);
> -
> +	ma_set_meta(node, maple_leaf_64, 0, slot);
>  	/* swap the new root into the tree */
>  	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
> -	ma_set_meta(node, maple_leaf_64, 0, slot);
>  	return slot;
>  }
>  
> -- 
> 2.20.1
> 
