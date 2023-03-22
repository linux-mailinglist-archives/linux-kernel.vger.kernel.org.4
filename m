Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68806C4F96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCVPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:38:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112035CC1C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:38:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCY5Zu002408;
        Wed, 22 Mar 2023 15:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=onmyxUP70AyIgs5dxuHghV0wz8lnbjWLVDIOAmCDAug=;
 b=BBi+jbCfIObUEmJXeiID0zq9Tf72xw9/4haZq6t9H8XiAnt7272TRsONVIRm7S6h7NiQ
 CWp+2X7A8ewEj13diujDwd+pVP6n2deulDuRyD/x/npJoe6G41zdzhbTk5kkolBYFI83
 sDYBHUeVYMe1ZPV5qcfdNAQQRxdJQ3siB28/I4SSHXm5scZASdw96DYIHnBK5ShXokV+
 hKqW8qf4iU7AI67nWspKg4XizvOBZCLZ21JsvojfX6Dh3Bjw8V6rmnih4GyCTFDM3JDt
 QDhrep87Y+3DotQ4X33M6428YCoM93I7Bm77EWIceKUW123Y5rtrIUe1kvt8gOoKr95x 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tscqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:38:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFNlEp030246;
        Wed, 22 Mar 2023 15:38:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg49egjrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3J/2DwgEI531ZvIpgeP7/M3BUpoFQe2QyWJ12QCgJyXTIpShli0ZaF+ffoXDpU1ufv64T1MlPsOVfHd5MomVgJhcqVgbmY6lL7HckB1hSehCXZTyW7WUYNQIZvIMpuNUkGB4EgMxq2VxOuxGpfZ2RcO98+9cg5hVP+IyFqhAg8LiD2LuEtViKIJxmR1WdMuvF0ZuRNCpDQm0atGDkSkv36ysFkFBAnfrn+5jBw1DMi0AjkHkRV4DMw4L9SKUYJUA/DCsB6YMQa95/+YLXDFoyYEACAOAkUx3vwYvedH9VkqP5G7POoN/S+PgyuGNv92nJ+IjaV85oIqIsZYWJhTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onmyxUP70AyIgs5dxuHghV0wz8lnbjWLVDIOAmCDAug=;
 b=Gb63/i1Wf4xQjkAPlTNwYthlCzOc6tzU0wuwLJm48ZV68f6CqKXfCs8dueDMa64Uv5F1Fj6q8kvOCyMllYjWuHlUXlljgaPhMnx5pnVd04yT+jmXOWN9kTSNml0krfWUJFMd/hJUCXw1lfHl3eR1yBI5LoXpm5rDG0tmrvr7HOG0IyldC9NXXa1axYBBE9aTl2SKDPnZEgkUG6rboKp3S5Ic93uTmx6L3nBtdzjTds4S02G8VJOKQ/fk/rC2xYkSPAD21b4+I6oyNOXYy6PurYIilXcoess54NTvrFlOk2/JqcJUBbOzbUOepiJrL/m1j/SwGJ2CIbXlgxUr190Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onmyxUP70AyIgs5dxuHghV0wz8lnbjWLVDIOAmCDAug=;
 b=Y8RBnR2TuF/gdf2W8RmdAWAK3pj1SnyLKHRcaSWi2Cvbp/HczRGzTyZduqRoyeyuA/DQbwUbZWpoplp2lz5CvOnUUr+4FAGCVzJfyhauBn5TIeTclVGiwxg0luSD/mJCuY1FDy2tAWWMJaJk3H5UiH4E7if7Y1jyvRbsCfjUph0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6785.namprd10.prod.outlook.com (2603:10b6:610:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:38:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:38:04 +0000
Date:   Wed, 22 Mar 2023 11:38:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v3 3/4] mm/mmap/vma_merge: explicitly assign res, vma,
 extend invariants
Message-ID: <20230322153801.fd3n5comdb3uscgc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <a88bff4cee88232027bf6356a6c3e265600521d4.1679468982.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88bff4cee88232027bf6356a6c3e265600521d4.1679468982.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 238ebf2f-5291-4843-9f03-08db2aeb6d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpbMBVXSqKIgVFSKEtB++P+Lm1PjDRXQZuNMxzXi5xdYH0IR3OkTzLftMP2BJbVvLYcsjcsvmK4N9AjrHokiMrswgJosNTNu/aRmhsX2+XGvdWpziepA7z1iMum+Ls8DmC3I152RO4UVQ0VjR+ubtRrzt72TDduomG2xZ2/8twEMxIRu/XLCEOvVDyG3UDQQb2tLlHnfwnH0E6XJOJ06EWQXOXYvEyTyWrOLaBwLwep/Qi63amaxCQCGI1x510kl3QMgrGjqIfQHHy/6gq1/GK71W4/KkL3ByGtT16gsAuclOh5ZvrBoByDRBfVoECa0l4NdjQCgvVLVubLSfjdkl3wuiOvZUYSa8ivzR93QmHEVPTi01hJvLWwQxVgCnYSjlq+GyK9umsnbARcQGXUvqzKVdDmh2iSELLPkGe4GJOHvba26rf1iftqC5x7kYst+KlpzgSg9b2hxGciv5F0+N1ii4ak2TC8crn+shfRPyOJGeaX3BDrZhH8+ABT3WeXI8twiK1bw2DQEuz/5lUhG/r7LxC29FDKTZID4ETowLzvfib6kxt0n08UdsCXNMIxOYbM4ttk5b8DcBdaZepiaMiFh/pfVaiPKTCfgYubu7WzbTqNwwySzv/l95Px+qFX9ppGkjrAgC9Bk9WrKMGuk+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(9686003)(6506007)(54906003)(26005)(83380400001)(6666004)(6512007)(6486002)(186003)(66476007)(4326008)(66946007)(6916009)(316002)(1076003)(8676002)(478600001)(66556008)(5660300002)(41300700001)(2906002)(8936002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAM4WuTxc/6o3l0e6dE2B4t0dsIH4e9o5AfxfanQPilgBEAiUhSIuypiN4Rg?=
 =?us-ascii?Q?6X4Q+1c8EbENX0Ik8Pyz3Wm5fUJuzKcJ82KkYVqgcZUX7JKpXulxEVCAIyE0?=
 =?us-ascii?Q?HeInU/nNXKFMD4RFJBGWLIZ8QV/s86HGiCzpChg88ROVpPFRA5w4nm4xlKwC?=
 =?us-ascii?Q?vxFX+jTaqU01odfZcrYfJngoNOxaGat2Gu+6m/GVznzu+wmd3Dc8WWSgTGsN?=
 =?us-ascii?Q?tU9hfcbyB/rUs0n/i7MsBHSndPC3JQBZ5BfCr+LA+O07+/5uxaDY6Y9xZHdn?=
 =?us-ascii?Q?/1p6kyUNcmSoUHHuRrm+V0WT907+eV2j0Eeq69Mzguzp9EI88QrqGUhozRUW?=
 =?us-ascii?Q?I+jEVXEM9VweWJ3eoJ29DuimPL1WY/rvq+K1Z926hHuAMxcmvsHwvLuNzv8Z?=
 =?us-ascii?Q?HiUA/1InhcrodCSO4kZ+wGcgidoo798snQW6q3b4iWbWRS/bCyR0r0w8cYvs?=
 =?us-ascii?Q?E/h5y8z5EUOQWp34QO67P398yh7arNLmdH8AZHwOgc8naX9TadqwVtb5IDyg?=
 =?us-ascii?Q?UR6N6AReoPSn62IzywP+GUCG9rE6KpAWodizhG3da9e7ykwQ2obe2u5LK74f?=
 =?us-ascii?Q?F3lgII+SlU973zbCsTLBaZthzknv9JtdgXcWborzBTNxvgdap1qNxtf3v53G?=
 =?us-ascii?Q?GnBaHJdgAOv8/5iOn+dvtvyciVkfcZk2pit38Jzt2PDX+fyCnLaD6cViF2Gm?=
 =?us-ascii?Q?brZX7/+W4GbujtklyOd7ai8AGDYDmW8o7qfNMjwvmIGh9XOf+hr6+SNwHzZV?=
 =?us-ascii?Q?NDZLTg+j+DPfftiMwi2pZavLNXSub4JNBQG0gojRWM3977S4w2xZwAVf/CS6?=
 =?us-ascii?Q?Yg0yVUPaM66/ablPQxDprrpvAuXFoPQEPet2ndLalUBvb/jWrc6m3rquOOLd?=
 =?us-ascii?Q?kCY/1pFsPqNx8gkK9sJhOtW6IzQMvIc8qrd1ZQ0ARwWU3mHu6+Gbwzqjb9RA?=
 =?us-ascii?Q?bhslG6MCqcEIWc1vKr4hYXz7pTW9M90OuV4+gXRqKLNCENvgON06lgKacUoz?=
 =?us-ascii?Q?QyPCrElb+jAAg9gBINFmbHQjHRr39GWRf3RlWieVQyN08FlsddbUIQ2iDBOw?=
 =?us-ascii?Q?Cro6XlZbCNPaVFP77alZcUnwAw/v+i7FwUNpv5ZB/uak9vmzvfNK8gHTEkx1?=
 =?us-ascii?Q?w+y3IHBZnmdHSnQtQnALVLTdjolyEcXzGR+GFssyHK1+md//DX8C3LhkEbsC?=
 =?us-ascii?Q?FLdmwxWkYvFlJ61V2xHwFY4zswevOF49Y5nS0FvuQkzi2SXU6rhyysrSHyNo?=
 =?us-ascii?Q?X+Ag0wQrb3susl00Hn2s/AfSc+k7lPNJn9gTFr5W80viPN/lo+3y/5eCrEyR?=
 =?us-ascii?Q?aE+WFmL9yKLN+nHlj1v5LowbRFCGcqmrguUaBKy80XtDD9YwcKTvGxO0hC8k?=
 =?us-ascii?Q?CBaYly3jkto07o9MA0u3e8ubNlozOhXkEMq5DrB8IfS7sDNEcYxndyXm2Nat?=
 =?us-ascii?Q?XHGa1YUTbgDkEdXgo6a38Omhe/wiKFJuZ8/+EMiu7MqzqQ2Axf/p96DSgtgy?=
 =?us-ascii?Q?5SK4CJJTKrs18sc9Ro7g8RwvUAtPuQwhEdTs0ewIpJ2i+uGWCU0jcToJtm2k?=
 =?us-ascii?Q?Lot4h8NQ9CBRNlyOoSHRFSx5IkFQ/LnwXSY4mXSNR9j3WSpT4LPbUEDAfKLx?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?txKb3RrqSJ4p9oul714BqiaQHMRFbArp8kt+3s5dIvvijgjzEiNvS/UH9up9?=
 =?us-ascii?Q?1e/FACE2HL5TYQPKMl2XtoFU9GxYEEF1bxSJmc5jL4Pku4cQvwxuwyxFU5Bd?=
 =?us-ascii?Q?Dq1jyWW3ZPWvRNPhw+86Xhg26sRqYiZPY18Am2ME/z/2iAtAFI9Tm8epR9t/?=
 =?us-ascii?Q?2Zofixe6Ggu+dD8TDvxZOlDS3VWIPexjEI0FHsaQLkMrDZy+ZpLvHBrh3apb?=
 =?us-ascii?Q?Fw4ETYhiD4T+KN7EnOxAcAv35228Y3ZDqTekeEtrYr9tNQDmPRi0PfWPWAp2?=
 =?us-ascii?Q?ciPB2k99bKaia+Yn5Rf8pOWf6X0kE6l43oJIZt6UcQBfJOsB0w26jD/ganVx?=
 =?us-ascii?Q?a7dZ162YHkJnbwkDZcY6WRp8L2+fPnZSr946qksxDY3owMSPR1ogdbU4WytW?=
 =?us-ascii?Q?jCtBEiNIGtw1+IMdVbKXcazHzlxUd1p5UgUi7EgtIN2coOghLMDPgO7cl5ro?=
 =?us-ascii?Q?aW1jRoAHaHcoSAtl/16E2JlZEVS7+BKfLvg+jwrHMJokaS1EnRvXJxoLMDWb?=
 =?us-ascii?Q?W9ulU2f+/4LHeXJJ24xebzgcMNbmA3MrMhT+dMFva2OPyu5bH6jvIC1bPVKQ?=
 =?us-ascii?Q?HpE+uMMapYk24RuTr64iPxnba4/1fxj4IBN6skAwLoQaM9xOkq95KmPb5yLl?=
 =?us-ascii?Q?ecB7+VSxEwLL0zM92kQsG7/tT3EPIzZfcayTYXiQjd0X3CJTuznD4QxpYp4z?=
 =?us-ascii?Q?jhL4m9tO4zBZ34gX8yXiWYcf8Z8mHj06W4o80Ul9LK2z63Iad+0qWfHg+WzS?=
 =?us-ascii?Q?mq9AAh+IumqJFNmePwJwTGZzrQnHctwU/JmKiuFAslKzF6fA2g3UHsWgbrjH?=
 =?us-ascii?Q?OcjfHse4mUdy4zRj4CHRhxg0XIINc476e8kqmAhM7m0PyqPJCRR9v0TQo/rm?=
 =?us-ascii?Q?iyFJ1fn73R4xbM0whxW0A7k+ENNePghyGYuJE1REgYk9bHHwxUDJ/xAj8hB0?=
 =?us-ascii?Q?xxPYGDhyDwyOJBvMjT/cER8lBRgJlPiugsNlrL5NJy+hKNzpMUApaldeF6TK?=
 =?us-ascii?Q?akWM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ebf2f-5291-4843-9f03-08db2aeb6d7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:38:04.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlfoeG4bnBcpgtl1s20cSXnvJvp4tlUXXNqNWIeZg3dJUOGU5KEt668FNxzCQsMFTcuQZB+dKW2y0qweudgb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=941
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220112
X-Proofpoint-GUID: 37j4QTmothUA6gY1_fzW8Zcsyua3Nhgm
X-Proofpoint-ORIG-GUID: 37j4QTmothUA6gY1_fzW8Zcsyua3Nhgm
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230322 03:13]:
> Previously, vma was an uninitialised variable which was only definitely
> assigned as a result of the logic covering all possible input cases - for
> it to have remained uninitialised, prev would have to be NULL, and next
> would _have_ to be mergeable.
> 
> The value of res defaults to NULL, so we can neatly eliminate the
> assignment to res and vma in the if (prev) block and ensure that both res
> and vma are both explicitly assigned, by just setting both to prev.
> 
> In addition we add an explanation as to under what circumstances both might
> change, and since we absolutely do rely on addr == curr->vm_start should
> curr exist, assert that this is the case.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dbdbb92493b2..2a4f63716231 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  {
>  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	pgoff_t vma_pgoff;
> -	struct vm_area_struct *curr, *next, *res = NULL;
> +	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	int err = -1;
>  	bool merge_prev = false;
> @@ -939,14 +939,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	else
>  		next = NULL;		/* case 5 */
>  
> -	/* verify some invariant that must be enforced by the caller */
> +	/*
> +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> +	 * and cases 3, 8 will also update vma to point at next.
> +	 */
> +	res = vma = prev;
> +
> +	/* Verify some invariant that must be enforced by the caller. */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && end > curr->vm_end);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
>  	VM_WARN_ON(addr >= end);
>  
>  	if (prev) {
> -		res = prev;
> -		vma = prev;
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
>  		/* Can we merge the predecessor? */
> @@ -957,6 +961,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_prev(vmi);
>  		}
>  	}
> +
>  	/* Can we merge the successor? */
>  	if (next && mpol_equal(policy, vma_policy(next)) &&
>  	    can_vma_merge_before(next, vm_flags,
> @@ -997,6 +1002,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			adj_start = -(prev->vm_end - addr);
>  			err = dup_anon_vma(next, prev);
>  		} else {
> +			/*
> +			 * Note that cases 3 and 8 are the ONLY ones where prev
> +			 * is permitted to be (but is not necessarily) NULL.
> +			 */
>  			vma = next;			/* case 3 */
>  			vma_start = addr;
>  			vma_end = next->vm_end;
> -- 
> 2.39.2
> 
