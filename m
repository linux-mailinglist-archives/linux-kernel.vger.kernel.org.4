Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504386C4F90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCVPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCVPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:36:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F083B0C7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:36:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCYlRg026960;
        Wed, 22 Mar 2023 15:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=is5JPlarrXs7oWx+ZQWdmBoXOfWMkJOq2WFvuw1eh5Q=;
 b=BD4zoVl/NHCklOg4DLKH2VmJOnGr9GAUmE0nKDAFbOTulZK7Vl2alRg8wU77ZT2C1TXa
 l8R98pHuaQByhCoORt/1J2Hz/ox48sTqMYIjtbIvokmN4dkuUD5CuvLlGJHeGEpMt5BR
 vHr4mECkiSArCk68Hl1GxFk78VP+T9lhG01IWdyUdXoUDE97s3NnvfEtawOXffw3mL9/
 3LxCLU0t7J75rn2lIDciRWPU0K/grsibRjW0mNKxxY9Pla4xb4x7a68oR64rXFNcfqyx
 D1HQnSxMH3Ltq/qlvocZcjwgs0rD1+3ahYTmskz4g6mLbgAkOcvBXIQ91v52lHsqASl6 UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wghekj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:36:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MEcTmR029293;
        Wed, 22 Mar 2023 15:36:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg3m8jamt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIMi61kkf8tLQ9+E3ABQbYESMBeFILOEkAEMV4jHqGG0mt2ZpXOERecIxU8rZsit5WfM5/J6usAmEToYJrlB37Z4dK1NlHTceKTOckhCMDAFXJ+djMRA5cTP6kJpSUTHHRg2g2RKNCNaSX366DAciIn20uWxE2UdoGbuIWSf8hyON6bLCAdQ7DNjrkxfr9GWqIveKrQ9nMcr2q9FuqIy4FuGHol2Ap6E9iO/T/7pVzLctQuFy76ELzZD6GdKx5L5sHo/Lf6cE3zueaAN5Ar+QoCpQw93klcjnJxHLQYgcKayru2guSowneVmCQKnxnb7PpW509gxNukjeqcbmqO5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is5JPlarrXs7oWx+ZQWdmBoXOfWMkJOq2WFvuw1eh5Q=;
 b=PNJCC2uiCCsYFaqCwoAoNKxQAYcsmqpv/zJ7u896GagZAujWTmI9VCvYDwE1Wu44J4NnJPeaDFcNLZSb1NjF7Pe/m4+yEZP6NK8vOQ9hZStMg4qvMkRFRNPFiyRt5OhsNJmfkuBVmHwf5FCZAvFN2U1IbA3HNr8YazWY+JdTCEJXrBot4ZyivJ7qV2JFNMxUz+ie/QVU24c5MqIOPA6MOJqHzEvBheR0R7jecZGxklWI4iWR7Zz0poLqFwB06NhUtYv8li53ADyGjwYwQL1Xk2Hmk1gq/iUqlqoF53zxQZChIAKHn0QZBMQT/izaRWs6qyAe3DlJevRXOF0/Wup3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is5JPlarrXs7oWx+ZQWdmBoXOfWMkJOq2WFvuw1eh5Q=;
 b=AkfAnfNVinJc7w4VFfkEr2x62TvLQO29NjJ472X5ft+dFU0GlzthjvO0DbWkyiFSHnoG/qV4W9qYI5bci7UjzMhSlslJer2luIVCJ059MXgOEeqbQl+bR4xinwZFbmGtTsgXEhbraTeDfEC3wF4clRtg0cILddpC9Pewpog9C5g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:31:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:31:12 +0000
Date:   Wed, 22 Mar 2023 11:31:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v3 1/4] mm/mmap/vma_merge: further improve prev/next VMA
 naming
Message-ID: <20230322153109.wtz42xxmnchcigaa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <f4474a419648fbbef13b29ce00880054da085788.1679468982.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4474a419648fbbef13b29ce00880054da085788.1679468982.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b3cb5d-926f-4628-f0f3-08db2aea77ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KurdOPhJ60aXcP8wjnF0liHcH9D1OQvUZ7tVTYhZkMXnB0BY48wIJvWYWzGbtMuF4J6IAbycPunLy+unCtG8ihFjSgkj4avamujLkmkk/ewVxQfKFOkFklTsSpKWz3uF65YDa/5tSMtjx950+Pr9mG8lVtik7d7U4U8JExpTe8NqAzx0lBHr4WJ16cdNaZ3yghVg8w9TWhSZKKEDcBGpBFY5Um0FnVTt+axRpfiRB9xxTzYxhnadDC0jHAKgzhph3Wn/0Z1jPL96ma6kvOC17/Rf0U3nIS4oFbwSf/8pcZl+08xlP+8LHSq7+ipfyUm1mkkgBRnyjpFfTB1AzsNswC41skc3lc9imzRIwBwM4ZHtalXvZATwNJVOZrKMIqUxADteL4t/hopUpn+5NsODs9fYagKuWEYeVA+ZIEfMDl13K8laYPcRcF96/Mexs4GyrHdBxIcGhERsKkhZY+Ql5NTY+dv3A/zG58Ilz09rfOiLbHLdDSVxMFSIdWAizcPteGnFPQcdvp6MGBnbDB4hHFZyFC2BpqbzwK9m7qAo58hJ5yf6EcjnVcoP/ddKVwrxSxHXQIL3Kw8W2+6wK4VAxeypP/ZBhhY1r6FNoX+sHiMTRGqdJSqb1rgTA4ZmsYRYLqjvlTZOlHse2/JdIZOwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(9686003)(6666004)(6486002)(1076003)(6506007)(26005)(186003)(6512007)(33716001)(38100700002)(478600001)(83380400001)(2906002)(86362001)(316002)(54906003)(8676002)(66946007)(66476007)(41300700001)(4326008)(8936002)(6916009)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxpcT81D7Br0D1/d8PzGEKJnSPa9iH5rGOM9vKB0eanoOxYZapUnUmyOkNKa?=
 =?us-ascii?Q?9tgxr3/tzvIDP+UAXo+o5tVFmUfX1JkQ5oXCJCSInJuqH0hASCKpy3G/1DoF?=
 =?us-ascii?Q?b19r4X2fSgyKBSm+TS1jewUOCVy+UmkvMZMAG8XiPxTFqQ8ijN2flXFpNI30?=
 =?us-ascii?Q?SNhmDpKQkJU0HsznkLWihaZKLuUJfcRtWGYb9wzyJMJ7Fpced0bTRvSO2R65?=
 =?us-ascii?Q?iWJwLyMFwi2gjTZHOwQMdU9VQW1BZn7Goi8sb+9tpplDOYVm49FmbTyGz5FS?=
 =?us-ascii?Q?sgXY5iC1avGtgSpSNsi9rEuu3AncWuxpg5ZPYKX6ot9zFvPg2MFfNujoDyI8?=
 =?us-ascii?Q?c8MG2+NM1/5/emT9uq9VMvUAEfOIY0Tg5UBAV1NpN0a4Mx2KXklai6XBDegJ?=
 =?us-ascii?Q?y1hqMjoOf9ezjJHmtuFLn7J3fudMUzfoFMjD/cB3YGkHLzvuhNmayzOx0q/L?=
 =?us-ascii?Q?1hb/n7dAqxvls0selHkaRwygAQZY1ukDbGf3cyh111d7sDS5oUJLZHPpVAuw?=
 =?us-ascii?Q?JtfF2IiaCCg8b7OElYUmB7LoYmBT9KtX1K3M9wTOMb1qZbt8HD2Q6GUhJ9ex?=
 =?us-ascii?Q?1LMqRq0mZrxttQEVZWoXqG2JmXOKPWyvXLRTQUbXJJEUnGhA6NdUQq3ESLFa?=
 =?us-ascii?Q?inY4Q1X06D/UU/eqU//dR0e6rr+qZm+l8MS5X6Lha11DcqaoGY0L9Yt8G04u?=
 =?us-ascii?Q?QUckeyjbQNMGBpqw1z0C1uhh1DLdBoipFJudA0eDHBjY1Fat+6EYix2MQcLN?=
 =?us-ascii?Q?FCTL7rGhbSTiKvmL9kyUvtwc16xKA4BS4qpXOWV8M+ikwYZEQijv+H6gKye+?=
 =?us-ascii?Q?r+fQeGrsWMczs2qvbcLNn3NEqhnL8K7zQpcptVYlh+hYq/Z59W4nVS5fROgp?=
 =?us-ascii?Q?XSdegLUmOwX3BiORpl3NY3zP0vhdvqK/yer7KRaYNNEJpZfqw2vUBoWqCad9?=
 =?us-ascii?Q?RBDCPB+DOgE7CvRD5+aZ+uerHVlxODSLhkcLbcDczEm7T+vgB9aSAhtiSc/q?=
 =?us-ascii?Q?KPd4brbb0zqu25gpRncFdDQT+msKWGDJTi7/uKhVV/gML88pfasqz8gD+AjK?=
 =?us-ascii?Q?Q4LdxYMMGdfdmLYXASTgh8CS33zh0IiJQ+PdbLaj5bIb7EB/eSYpEHt4RWUN?=
 =?us-ascii?Q?fNWZg+LckLUXWiQfW4S+2nLb9WD8QbKM9lru42ZJa3qYVSbNkzFZI07cN7Kk?=
 =?us-ascii?Q?3663kRRrVXsi2X9I0Mo5p5XbySdVgHcUp9Uw53N0uWumpC5sjZU/4GD5PcvG?=
 =?us-ascii?Q?hMaKHXAEmxhKdq4eysozJELvQFcaMKf/DcziGXDtUtpZjQTTQOTx0MwiK0YO?=
 =?us-ascii?Q?dMmLO9ady6Mv2XkO7+p2sF8g9JC7/zirofzKIaevMxLYCyI00QYwOwV901Ks?=
 =?us-ascii?Q?LdiVr9o4Nl7Ju8leZlXCiZvDdPDYvTdzggLXBsVxoidBVlegIxxZGJv++Q7A?=
 =?us-ascii?Q?ygosBB2mUVSjjkV8VZHR9SKeSKtv5cy7ROEuxBkjbRgYP8E7x2Gl0gwVRCNU?=
 =?us-ascii?Q?t3nzsqUgWGit6tiFzmDvcQUBOtmTfYn8BKWAF5wUE67fz34N3ceeFErOQw1k?=
 =?us-ascii?Q?BHKD7z8nb/gpuhHue0RI5y4R9xTCMDbh+v0qJ2nViUe5r3+IJJhJwlcEOGQE?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tAaIyQYTnUSXakV8rkW/EjyrYBgkuyp7OcQ5LONFKuu16OjnDZT8ykSH14Ws?=
 =?us-ascii?Q?vJL981RMB11Y8hsDl4VYjpaJNqDsWBfH9VrqII3qKw7mF4viYPpWYQ3z40fK?=
 =?us-ascii?Q?gUEF60AIbZPnoU1VXFHFetI7cnj251G2ASAQWEerSPUTQ0jnfe9BjinbAxEX?=
 =?us-ascii?Q?xEJZJOSIcxSsbS7AGC1YGszFGix4dH2IJW2hl4TQpO2ocWgRN94qPnwZsx/0?=
 =?us-ascii?Q?fJGAWEwj/0hOf7QfqHnB21Cxlm+SxRuCzQbt1HYzMnPQ+Sk7LVb3+JEyAjoc?=
 =?us-ascii?Q?CVcgLuERpuazIDri8pUajr5+oGgTIuraFlqVybQ4+Af9zbm5QT7X0SM8B7Ey?=
 =?us-ascii?Q?/O6MVv5hqU8aZLDtt7No6E+ceUGEp0YaR+faylet7bxgUFdARRl3fbpoLffY?=
 =?us-ascii?Q?uSA/HQkxvZapbUrfWiWPbZetT/aoBciydXh8Ex5Cb1IcXhLDQWya9YcusUoK?=
 =?us-ascii?Q?yKHLA9sA6UFsio23gGaNoRZZsj9FZ6iOxj8P1iow2Dzzoe3Ze81KCCvfDJWT?=
 =?us-ascii?Q?ztqq1KfEphtThkRhfxlb/vTAdeqlc9k3aZEJcFiBlKBH19Mm9v7Wf0nlHcFj?=
 =?us-ascii?Q?sVFEV7KFMjHWhqLhjqref/MCvy64z8dNKnMByI+bXFibblhQYTtj/aa6dAHl?=
 =?us-ascii?Q?KQ3qU1oYK3VgAM7q5ZPLzvhR/5XK+7SfW9wsvxB15roLb/PoWuxFSR7+RvDT?=
 =?us-ascii?Q?4trQQUWmOGGsm69eH1rrStKPNZIUtakd2+KHcZp9TqvwSd+vKZ8fc1TpJrsI?=
 =?us-ascii?Q?fIf4V2BPB5EHnmUTucQBMHQTeW3z65B2GpWI5/Hi0ei9YAXt6M6zeCv+j/UN?=
 =?us-ascii?Q?Vt2Q9xCpuuQsg4kacPIekQI7jE7zi8f8SiPjWfLndhSmMXiKmD/GtH3Ij7d+?=
 =?us-ascii?Q?mDN9VNRmnvvJI+WfVTp7fSN2NQP+w5uV99QIQERkHcYqr+2ZppxSZw+9lHCp?=
 =?us-ascii?Q?7ybSHft40D3TEPjAd5jluBL0ZGPaq+MADgSFoFSSQrgXGCvhllAWjE8c8IxI?=
 =?us-ascii?Q?c3GH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b3cb5d-926f-4628-f0f3-08db2aea77ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:31:12.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tgb05u2GnJ1pbnsxMM9jbBGZl+Df5kfsOPxXkX+2KZ0mOYYqSheSKfR4v3q8Q9lYjJ2qP5XAq+GqnKiIG27DQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_12,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=951 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220111
X-Proofpoint-ORIG-GUID: tVApg5nmk9T1skCilmtpyAeIrxyd6j_8
X-Proofpoint-GUID: tVApg5nmk9T1skCilmtpyAeIrxyd6j_8
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
> Previously the ASCII diagram above vma_merge() and the accompanying
> variable naming was rather confusing, however recent efforts by Liam
> Howlett and Vlastimil Babka have significantly improved matters.
> 
> This patch goes a little further - replacing 'X' with 'N', which feels more
> natural as this represents the _next_ VMA and replacing what was 'N' with
> 'C' which represents the current VMA.
> 
> No word quite describes a VMA that has coincident start as the input span,
> however 'concurrent' (or more simply 'current') abbreviated to 'curr' fits
> intuitions well alongside prev and next.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 86 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 042d22e63528..c9834364ac98 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -861,44 +861,44 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   * this area are about to be changed to vm_flags - and the no-change
>   * case has already been eliminated.
>   *
> - * The following mprotect cases have to be considered, where AAAA is
> + * The following mprotect cases have to be considered, where **** is
>   * the area passed down from mprotect_fixup, never extending beyond one
> - * vma, PPPP is the previous vma, NNNN is a vma that starts at the same
> - * address as AAAA and is of the same or larger span, and XXXX the next
> - * vma after AAAA:
> + * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
> + * at the same address as **** and is of the same or larger span, and
> + * NNNN the next vma after ****:
>   *
> - *     AAAA             AAAA                   AAAA
> - *    PPPPPPXXXXXX    PPPPPPXXXXXX       PPPPPPNNNNNN
> + *     ****             ****                   ****
> + *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
>   *    cannot merge    might become       might become
> - *                    PPXXXXXXXXXX       PPPPPPPPPPNN
> + *                    PPNNNNNNNNNN       PPPPPPPPPPCC
>   *    mmap, brk or    case 4 below       case 5 below
>   *    mremap move:
> - *                        AAAA               AAAA
> - *                    PPPP    XXXX       PPPPNNNNXXXX
> + *                        ****               ****
> + *                    PPPP    NNNN       PPPPCCCCNNNN
>   *                    might become       might become
>   *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> - *                    PPPPPPPPXXXX 2 or  PPPPPPPPXXXX 7 or
> - *                    PPPPXXXXXXXX 3     PPPPXXXXXXXX 8
> + *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
> + *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
>   *
> - * It is important for case 8 that the vma NNNN overlapping the
> - * region AAAA is never going to extended over XXXX. Instead XXXX must
> - * be extended in region AAAA and NNNN must be removed. This way in
> + * It is important for case 8 that the vma CCCC overlapping the
> + * region **** is never going to extended over NNNN. Instead NNNN must
> + * be extended in region **** and CCCC must be removed. This way in
>   * all cases where vma_merge succeeds, the moment vma_merge drops the
>   * rmap_locks, the properties of the merged vma will be already
>   * correct for the whole merged range. Some of those properties like
>   * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
>   * be correct for the whole merged range immediately after the
> - * rmap_locks are released. Otherwise if XXXX would be removed and
> - * NNNN would be extended over the XXXX range, remove_migration_ptes
> + * rmap_locks are released. Otherwise if NNNN would be removed and
> + * CCCC would be extended over the NNNN range, remove_migration_ptes
>   * or other rmap walkers (if working on addresses beyond the "end"
> - * parameter) may establish ptes with the wrong permissions of NNNN
> - * instead of the right permissions of XXXX.
> + * parameter) may establish ptes with the wrong permissions of CCCC
> + * instead of the right permissions of NNNN.
>   *
>   * In the code below:
>   * PPPP is represented by *prev
> - * NNNN is represented by *mid or not represented at all (NULL)
> - * XXXX is represented by *next or not represented at all (NULL)
> - * AAAA is not represented - it will be merged and the vma containing the
> + * CCCC is represented by *curr or not represented at all (NULL)
> + * NNNN is represented by *next or not represented at all (NULL)
> + * **** is not represented - it will be merged and the vma containing the
>   *      area is returned, or the function will return NULL
>   */
>  struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> @@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  {
>  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	pgoff_t vma_pgoff;
> -	struct vm_area_struct *mid, *next, *res = NULL;
> +	struct vm_area_struct *curr, *next, *res = NULL;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	int err = -1;
>  	bool merge_prev = false;
> @@ -930,19 +930,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>  
> -	mid = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (mid && mid->vm_end == end)			/* cases 6, 7, 8 */
> -		next = find_vma(mm, mid->vm_end);
> +	curr = find_vma(mm, prev ? prev->vm_end : 0);
> +	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> +		next = find_vma(mm, curr->vm_end);
>  	else
> -		next = mid;
> +		next = curr;
>  
> -	/* In cases 1 - 4 there's no NNNN vma */
> -	if (mid && end <= mid->vm_start)
> -		mid = NULL;
> +	/* In cases 1 - 4 there's no CCCC vma */
> +	if (curr && end <= curr->vm_start)
> +		curr = NULL;
>  
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(mid && end > mid->vm_end);
> +	VM_WARN_ON(curr && end > curr->vm_end);
>  	VM_WARN_ON(addr >= end);
>  
>  	if (prev) {
> @@ -974,21 +974,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
>  		err = dup_anon_vma(prev, next);
> -		if (mid) {				/* case 6 */
> -			remove = mid;
> +		if (curr) {				/* case 6 */
> +			remove = curr;
>  			remove2 = next;
>  			if (!next->anon_vma)
> -				err = dup_anon_vma(prev, mid);
> +				err = dup_anon_vma(prev, curr);
>  		}
>  	} else if (merge_prev) {
>  		err = 0;				/* case 2 */
> -		if (mid) {
> -			err = dup_anon_vma(prev, mid);
> -			if (end == mid->vm_end) {	/* case 7 */
> -				remove = mid;
> +		if (curr) {
> +			err = dup_anon_vma(prev, curr);
> +			if (end == curr->vm_end) {	/* case 7 */
> +				remove = curr;
>  			} else {			/* case 5 */
> -				adjust = mid;
> -				adj_start = (end - mid->vm_start);
> +				adjust = curr;
> +				adj_start = (end - curr->vm_start);
>  			}
>  		}
>  	} else if (merge_next) {
> @@ -1004,10 +1004,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_end = next->vm_end;
>  			vma_pgoff = next->vm_pgoff;
>  			err = 0;
> -			if (mid) {			/* case 8 */
> -				vma_pgoff = mid->vm_pgoff;
> -				remove = mid;
> -				err = dup_anon_vma(next, mid);
> +			if (curr) {			/* case 8 */
> +				vma_pgoff = curr->vm_pgoff;
> +				remove = curr;
> +				err = dup_anon_vma(next, curr);
>  			}
>  		}
>  	}
> -- 
> 2.39.2
> 
