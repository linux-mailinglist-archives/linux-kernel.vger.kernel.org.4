Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFD74FCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGLBWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGLBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:22:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224871731
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:22:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BID13k015477;
        Wed, 12 Jul 2023 01:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=6FyOXxwsh0bp0S88fXtl6curaU0qka4KESvn3CM62fg=;
 b=hUJAe7YzSRh7jCmz2NM2LqjL7rBA5N5gvQ+DxEYHje4LU43k1+b4DgTrzd1Lk4Whvro0
 pUZ3Rg5WbxsJbBd0839VzwmmAlLL9/hQO2T8DETFJhCw3apLszYlB62QB8rCpCOu/dfF
 o+VSb16RSa6werQX0/m/apaWRZta48fbbJ31z7n0wpjF2IgZpF3/eSME/1y8MnPY8KLe
 cwgWLyMGuyhFs46o9OrHwZ7wP1XxjOUR1PjhasuL6GCOdBzFe5zNtzuC/cUkx42+pW8Z
 eRVXxawOnDq7BLUCyclDlu5erFdu0pvTsvsWx8NK8IazK93aB1TCBwSR7Eoj++SdvH+G Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xumndq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:21:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C06niL008288;
        Wed, 12 Jul 2023 01:21:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8c13pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWzS6MfSF4f6Efsub3qjDXUAJkla4nTB7h5ApOYdDffveXCKbNHmlJMi4rT+LRsjrQ8sVl2mDyDZ+qfihttdM1PNTgEH0POh2KFfJnMda/v0WSPAaXfDkN7zaUQVS7do/bR5E1fS+l+N3+4GUsDPs0fWueKfyy7IivFKwM2PCACbfuEwgnQJ8cLXky22HNOMdkVXwJxgKU/Ypv5TIf4Sflk9AaYb6KRoHrUAwFYem08MoBKRW5HBpKwyFmvrkafaI9/Plqlc1ZaNlV62Ku2ffk5atR0l2lGe80bFZgwnBN1F8PGADNb5cu83VxjYnI3cViWXeX7Dx6n9fZvW8YZkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FyOXxwsh0bp0S88fXtl6curaU0qka4KESvn3CM62fg=;
 b=VhcEWCp4U7hDt/98ZjM6HgS1QEaRs7lKr9KTaHzP76zdxASdQYENbWNznej+B5Ywjryzdgjf26ft3fMWevSv+YPbAD229gopj0Zs8BARZe/BQoL/CAvbLTLfoO+DQuUgjcUv3BDwxen6G6RiEOdQsIzYHUozTEn7XEJ2eTHio1zerPoXyT8jaOL8AMhNxEO9SztsKemILzkaPDIsgdVF1tktUERDoKwAHkpJwp+04TjEvhyDyNiShX2/qQFR6iXYMzaigZqOOtWeqAm3x5ptizD/lYRlg/N1zpy77R5fbpkIAxhL5GwoYjJ6LxdMfYp5zLYA8kAdp4BTegIwKFlR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FyOXxwsh0bp0S88fXtl6curaU0qka4KESvn3CM62fg=;
 b=O7si1SXXnkyTLAdwpSYodLDG9C51HQcdiKG00LmlSfAfXTsaGMdbenU6Qx5VX/ZYZ6qT5RD7MeBg0baZxUGFHUZiU8JDkMiUUOBKIt2CSIvpW9VlMW8wU7xczV2b8MlV0Qs8xuDNkk9e9WyGLpnwb/OnaEtBo1C9E/Wh885l9gY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7957.namprd10.prod.outlook.com (2603:10b6:610:1bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 01:21:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 01:21:44 +0000
Date:   Tue, 11 Jul 2023 21:21:41 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 3/8] maple_tree: make mas_validate_gaps() to check
 metadata
Message-ID: <20230712012141.2ccxgy2xymsvq76n@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
 <20230711035444.526-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711035444.526-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BLAPR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:208:32a::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f75d3ed-96bd-4a83-1a45-08db82765ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhmDBViQ55jdvRxaJAlZLeWalW33WNbnGI+ivZBRAPzXlP0KAI8RAZKdxlYjsjQe2lcl/Qvb1BsKTv+RO/ecxZNJ/xhjPjaH9eFMkZU+3+zt0Z3e7wdTtm/c7HLx0ExREY1akErc+fT6nMbnF0T9+Xx7vCbnyGinyNtsT2RMfBmrRvgszKD4+TTfhdx7CABsn3hv6H1nP945l0EgoPH1b5aM0gOQFCh7dQLeu/CMQSoE/d01Dae+MYPjpu9e6a9pRYPnHmrHPXNQVZaDGEaPOUOwxpue4cpSCDDFDO7i8BZ6/qz5TcHjCUZtQGrGiF01+8c0KgFo37Wvwud01+HYbIGThlbTEXtX//Gh5Mg56uVsg/KdRsmpprCEuMQfjNpzaIj15MTj1CM72gCOIHveB6E3DylODDNoCoUfcxmzYTwNZIh50rckHMdCqPW79AlG0QzvCIlx6ofhi3FK7JbgAwxeSCNjzohLTGYybTcho6WuCTK+VSuYu2o1HD9XkYz5P02SXX5m7BBGKcbjtaVQxeGjN/k4JcrnWHpDItqpMNAGHpQ2+Eb8Me31dWPchQUe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(478600001)(6666004)(4326008)(83380400001)(86362001)(2906002)(33716001)(186003)(9686003)(26005)(6506007)(6512007)(6486002)(38100700002)(66946007)(66556008)(316002)(1076003)(41300700001)(8676002)(66476007)(8936002)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVSGmOSLvu/dAazmfb1tAqSpQ+iFNOa+bi53RxBuISXad0D/rB/u3mCNK2Se?=
 =?us-ascii?Q?6nZ5j60KPEqWKXZk3yiUztVTwzzydro7hJk+ZuGVOvqFfYX+xocRbvgriZec?=
 =?us-ascii?Q?IXxOK2jC8hL0Typ1CISMn3D/9Y+iL1qQgp6jXPqSK9wjdqzy3PD3DX8VQqUx?=
 =?us-ascii?Q?vYYiPH/VYoLjwtq5owgGYmiXvfh/eQ10H7OOctOzEElljMoBq8ezPRKbkPdH?=
 =?us-ascii?Q?eibr5GeU81+l1e7vnOaLCHb8iu6IQRSM0Nqb5QBfAFd643AHvR5S0ce8CjHJ?=
 =?us-ascii?Q?kTgZtNvbn4cpEgqQMSWr5jnA9EbjGPVLFW8OSkNHh5EZtEQD6JLCRDJ9jDr4?=
 =?us-ascii?Q?m3e9c84tBNzUbqvsJYTOKhF81WzlZVdbh+GRFuv1bJtVTdQHJ9D9HLNhhCjw?=
 =?us-ascii?Q?2ESrILauiWbSv+MsVjU/97NaTrfN3LFlmKJUsZfxQZ+WwwZGoejDjV3GGcAN?=
 =?us-ascii?Q?kosgAXaovujuV7pjbxKLBfLAozazZhSbTWFVe9vftSsqm5flYY5eQG8EeEc+?=
 =?us-ascii?Q?E2UrJg3Fti2Q5/0Hea182SscpRE+yXaz981Y1IaryyQEtaVQTjupHtSuinNa?=
 =?us-ascii?Q?lHujWNL7jIeAFkd26FjTjY9aaCKDSJfDzWKIamDcJYhcs4bT40Yo/2U+TlGm?=
 =?us-ascii?Q?3MJk2tQD9FiOixmDJT6EU4g3JzzYTjcDbhWf14D86N8m8sYSBu0C3NVlQlhH?=
 =?us-ascii?Q?rkUPD2JktVopiSKted0leJFoIXg/83d0gNOtRHvPg7+EA0v7dNeWQDWW5EQw?=
 =?us-ascii?Q?6cgwGAu+RmuuQcL2QzMofsB3BmaAQLgJdHrXCYLKroSgr1orcUu+KxmkT5kU?=
 =?us-ascii?Q?T5dhxsFDrhkTDquO1maIYjIKZ962w7Z4b7sMMs8YYP6x33bi+ExG3d3nIaLL?=
 =?us-ascii?Q?XuzgVehFt3ls9rH2cR/AApFZDHA35Zm2nN1QMvKyM+irxeDtNhiXtq9hoCnQ?=
 =?us-ascii?Q?6ubPqv67JD/fCN4KtZtVXTHE1EW50l7QLknV3EikSWTdYIXOiAKDKgeDNzWU?=
 =?us-ascii?Q?4ozANnHWNlAj0ZL6ToEAx7Nsbtcf8gNq/xQhuoDGc57DDkvTH4libIFZSd1p?=
 =?us-ascii?Q?zYiPMrH3rOmDcPBqyz+yuAeFMhsVLT7rBlsi737RVEmD7mLgycAREpVz6GnO?=
 =?us-ascii?Q?CZevLoLQ/5yCfsJDS/vvO4nUBlMn1KcTay8JOYVCgCETPEVn9LpD4a51UjPQ?=
 =?us-ascii?Q?f1mM0pwKT3B6YMvp8LKCnT+JK7GKGsDN+p/qdpyQSWApAyeFa7qJZ4duB/2e?=
 =?us-ascii?Q?oFKrJ36nSNU2O0uiB+p31iP2PpC3Ws//lW73YN/CZGK5tSi0CnR+vRZtAsfO?=
 =?us-ascii?Q?l638P+sPKE6bz9rTC4TnDmyFNFWVfjGs9ZXQIuPYAnnb3by4OBgmY4MurYpl?=
 =?us-ascii?Q?fO2OBz928c4NCjsJmxuEQxdr7wCv363CPCrM+VW3EIAm0Fhf+odZF60q7iQa?=
 =?us-ascii?Q?9MxH1nnReapbWEs6gPD0UHT/nCjSI1LSH+mYHan+V/ElLwmqhTBqP03dwt+4?=
 =?us-ascii?Q?Ylik0+DvIH+zl2r6zybvcDt3UAULGoOAfoKUU2RLpf15c0FzFwH79HeOqRQc?=
 =?us-ascii?Q?hhzqvW1MB9Tw5WMGUX6k9IxnIcW24bxwLGd59XHngLSkkgSIUQlaF/LfW/y6?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mKdWS3Ez1QAStA+NcHRIOmJoNUq25w92n6rzqLcBBylzSZW2kK7IkES8Bgf8?=
 =?us-ascii?Q?gV530yCsXYrdx15UOebycb/zg/kn8M7DniGEWiUGdvPTq5leaQ2KlU01NFGV?=
 =?us-ascii?Q?ZkMZC3MLTYMLdL0xORwERd2ZYezdYcWq0wPG46oqDDKZ9feROaf9Ck5gE4HW?=
 =?us-ascii?Q?E6nULJSJz5S7o7Wcsh8S0Bahlq5jJS3Ecm9LpWPL4t+bsaFzv5q5g2k1ed/3?=
 =?us-ascii?Q?wrrX39wm1duth5b1XGYleIlQAwKuXkfODkCMz5C/omhsoShxYT7s5ZH5mMN4?=
 =?us-ascii?Q?AJvF7iJdLqRcQr2GPOysTR+UmVHApd3p2Xo83zinwfF7Kz2POOGpVkgCiZRx?=
 =?us-ascii?Q?AemdLeecK6GkL2S6JdEz48bS6y12rnNGS5E9M14LLWpCPcbLnufPZnD4Uec6?=
 =?us-ascii?Q?6vbfA76rZml6MrdJIo4Ko+jpFj8+Qo/lcDO5Lg2Z6ArTWP/B39VzDZkBBzkV?=
 =?us-ascii?Q?gUT9Fu9H7W5EjHQzuVxpdQyDuNkCSvF3VQYkD43jFHL8iql6okJ9zZgvtuVk?=
 =?us-ascii?Q?Xt1+K+7wboxhQ6PFlfCgAHNfBlAJO4ZcEZoJPLNx/HbI4esJDPMXrQRBGZoI?=
 =?us-ascii?Q?Sb9roH85CmTGCjPU9ViGI7C+N95Gp1VeZzrLuYilMZqt88jNMj09b8oPrHbr?=
 =?us-ascii?Q?vIzhDvXOn1KOJ0h8iuWE3Qycd3gtn7Z8qm7pa1aFITOnM7/myyqQ3uVbv9Ko?=
 =?us-ascii?Q?JWshOCsgLRIYC9XPM28GVlpkQcgHcDBwEbPgEjUatcg2bhURsktGfpA7iP2F?=
 =?us-ascii?Q?i0ZfDKIW/6kJ5hfCEnJOR+cFYdo9ywPePinMz8YBwlGnP8y1tNXrCFeHmoHo?=
 =?us-ascii?Q?j6FTEVfYxCAvVwjdhFMamw73KyAfpoFxgq4KbTyhbFdvmgxKRU5sqlpPhY0N?=
 =?us-ascii?Q?ppwZS79jtwA4nNhCKayXQM+fueBYLWTyfDqBCSTZ+L6UB9eZU1ty1eHVG+q8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75d3ed-96bd-4a83-1a45-08db82765ab8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:21:44.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WDAO6VETuGzYcrg3tT+RCQgIPRPFeYCLMAJ9OulCUrboi/4cueEeCiNivA2mcf6V0UQs3/Sx6YGF31YWq3Hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120008
X-Proofpoint-GUID: Nd55FwvO9PU4cknmosMj_bWTQFN9Z8kS
X-Proofpoint-ORIG-GUID: Nd55FwvO9PU4cknmosMj_bWTQFN9Z8kS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230710 23:55]:
> Make mas_validate_gaps() check whether the offset in the metadata points
> to the largest gap. By the way, simplify this function.
> 
> Add the verification that gaps beyond the node limit are zero.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 78 ++++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 36 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 6a8982146338..a5776fab1875 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6983,15 +6983,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
>  static void mas_validate_gaps(struct ma_state *mas)
>  {
>  	struct maple_enode *mte = mas->node;
> -	struct maple_node *p_mn;
> +	struct maple_node *p_mn, *node = mte_to_node(mte);
> +	enum maple_type mt = mte_node_type(mas->node);
>  	unsigned long gap = 0, max_gap = 0;
>  	unsigned long p_end, p_start = mas->min;
> -	unsigned char p_slot;
> +	unsigned char p_slot, offset;
>  	unsigned long *gaps = NULL;
> -	unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
> -	int i;
> +	unsigned long *pivots = ma_pivots(node, mt);
> +	unsigned int i;
>  
> -	if (ma_is_dense(mte_node_type(mte))) {
> +	if (ma_is_dense(mt)) {
>  		for (i = 0; i < mt_slot_count(mte); i++) {
>  			if (mas_get_slot(mas, i)) {
>  				if (gap > max_gap)
> @@ -7004,52 +7005,59 @@ static void mas_validate_gaps(struct ma_state *mas)
>  		goto counted;
>  	}
>  
> -	gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
> +	gaps = ma_gaps(node, mt);
>  	for (i = 0; i < mt_slot_count(mte); i++) {
> -		p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
> +		p_end = mas_logical_pivot(mas, pivots, i, mt);
>  
>  		if (!gaps) {
> -			if (mas_get_slot(mas, i)) {
> -				gap = 0;
> -				goto not_empty;
> -			}
> -
> -			gap += p_end - p_start + 1;
> +			if (!mas_get_slot(mas, i))
> +				gap = p_end - p_start + 1;
>  		} else {
>  			void *entry = mas_get_slot(mas, i);
>  
>  			gap = gaps[i];
> -			if (!entry) {
> -				if (gap != p_end - p_start + 1) {
> -					pr_err("%p[%u] -> %p %lu != %lu - %lu + 1\n",
> -						mas_mn(mas), i,
> -						mas_get_slot(mas, i), gap,
> -						p_end, p_start);
> -					mt_dump(mas->tree, mt_dump_hex);
> -
> -					MT_BUG_ON(mas->tree,
> -						gap != p_end - p_start + 1);
> -				}
> -			} else {
> -				if (gap > p_end - p_start + 1) {
> -					pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
> -					mas_mn(mas), i, gap, p_end, p_start,
> -					p_end - p_start + 1);
> -					MT_BUG_ON(mas->tree,
> -						gap > p_end - p_start + 1);
> -				}
> +			MT_BUG_ON(mas->tree, !entry);
> +
> +			if (gap > p_end - p_start + 1) {
> +				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
> +				       mas_mn(mas), i, gap, p_end, p_start,
> +				       p_end - p_start + 1);
> +				MT_BUG_ON(mas->tree, gap > p_end - p_start + 1);
>  			}
>  		}
>  
>  		if (gap > max_gap)
>  			max_gap = gap;
> -not_empty:
> +
>  		p_start = p_end + 1;
>  		if (p_end >= mas->max)
>  			break;
>  	}
>  
>  counted:
> +	if (mt == maple_arange_64) {
> +		offset = ma_meta_gap(node, mt);
> +		if (offset > i) {
> +			pr_err("gap offset %p[%u] is invalid\n", node, offset);
> +			MT_BUG_ON(mas->tree, 1);
> +		}
> +
> +		if (gaps[offset] != max_gap) {
> +			pr_err("gap %p[%u] is not the largest gap %lu\n",
> +			       node, offset, max_gap);
> +			MT_BUG_ON(mas->tree, 1);
> +		}
> +
> +		MT_BUG_ON(mas->tree, !gaps);
> +		for (i++ ; i < mt_slot_count(mte); i++) {
> +			if (gaps[i] != 0) {
> +				pr_err("gap %p[%u] beyond node limit != 0\n",
> +				       node, i);
> +				MT_BUG_ON(mas->tree, 1);
> +			}
> +		}
> +	}
> +
>  	if (mte_is_root(mte))
>  		return;
>  
> @@ -7059,10 +7067,8 @@ static void mas_validate_gaps(struct ma_state *mas)
>  	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
>  		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
>  		mt_dump(mas->tree, mt_dump_hex);
> +		MT_BUG_ON(mas->tree, 1);
>  	}
> -
> -	MT_BUG_ON(mas->tree,
> -		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
>  }
>  
>  static void mas_validate_parent_slot(struct ma_state *mas)
> -- 
> 2.20.1
> 
