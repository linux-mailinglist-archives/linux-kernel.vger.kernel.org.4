Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906A6C1FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCTS0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCTSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:25:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA69134
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:18:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFx5kO024120;
        Mon, 20 Mar 2023 16:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5AlNqSaTbIHSpZ+nzZrxYtdTBq0GD3OjQbkKlMU0N+k=;
 b=CBcTVD7sICAHrKoJLOKLTJ1YSLsErmD5BzWj9Gt0cUanRQpy88Vr2oi0LafNhYC/u6QD
 MgcpdJ0WNpllHfpRxTRoAbZI8m0zoLrSxRdOAXllJGq6lud/gNq0GB9l+6NL9QSfdH4y
 TrEQ+f5mOG1622vpZDlzVlBTjRjRMIHhcY1wHWxr7uR9VHMkLJDp4obBzse0i2q6TOlG
 zdnKOkNK7A/b0aTF29Cw/LB5NttPkmPXgBT/gJetd+/5tamEszsR8lrgB7Y45mBjO8gW
 LkIFFucg3jeaBSfMktQX8GNK8x6fKDPNaFIekSv6PlXQ2Hmho4+Qokr0Hn3MPOMk6ZRP wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wgc19x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:47:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KFDxbr015428;
        Mon, 20 Mar 2023 16:47:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r52333-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8L+yZ6d9nVx3zTxgDQ59uBrHz0H+LvKoOq0WaTWMTDfGeKmEGFqBrnlYCwpMcDdWIdHqeztY+YHeSMMw8ZoozYecm6YSgjCRIqOSOpgvycp9/f64IkbU6bN7xShgYasVfNTCnerdbBCbRVD+urkWmwvj7I9RYwO9SYm8fnY1ZX8haG2UF2OycnWWBI/EG0xwokIYCpyb0HTHs6PXxMDEBWE5HDPltBgQSp0NTyXqWYp4Po8sHsebVNnDi6J8mtMqCDy10e8uj6YKrbfSTycHMxvLz/n3OQdAVrkdz0lFl0FNUbMbxzKlPAwuDSJSgmIsbHSL6yducaTMgcuHHjoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AlNqSaTbIHSpZ+nzZrxYtdTBq0GD3OjQbkKlMU0N+k=;
 b=i0fIMNRmg7c8nf9FuYXB1xXEkPDasqwCdkGxyHQ5pjy3MPdZ9DQUViCBI7K99gPKvIy34aq4XMsEa94fBx7Vw0LIet6Ogm/WFjapeoJEl6ifzV3LryY0vleXerVnNYEg6K5UqQknf7ypoTFHHnraTpyozcTyf9gXVf57NQDJQgbHrCXALHFIZgwr5Sj/p8J3h5j8F+XTjpueiER2VBlzufbOOdyOgJyr76stqzfc953sjxBCIK5jAnkyXQloYEWmkGiX4mnOgXQKl+9KdptNiT4sPzHebnSgwa2sLWEKvrG1FZUhz28wvN8I5Sfal3SZ8fM9DWI5+6P2KSCRQ4dItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AlNqSaTbIHSpZ+nzZrxYtdTBq0GD3OjQbkKlMU0N+k=;
 b=TN+KR5Ir4ELJwrGf8+FAYIX7zhHUOzsnXe34iq5s9LVHVePIhXCdKLOhbpNsvySJD+8k6IVXp5SW4oF1Zauf8tuKfOjCUz/h3J4MWtx8xan3zBYwtfuagFqxMJYBV1woVeTUBsc0SV7+M8XPyS+sNI2RLNEykoVY4Q3mr041U1U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6604.namprd10.prod.outlook.com (2603:10b6:510:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:47:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:47:11 +0000
Date:   Mon, 20 Mar 2023 12:47:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 0/4] further cleanup of vma_merge()
Message-ID: <20230320164707.zpjhcwplkrp4tvgf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org
References: <cover.1679137163.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679137163.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: f148d513-4ecb-4bea-90eb-08db2962bfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0f2OjoM8hUt/HnXjIIm64WzqLnqLEiz+v+H/X4NKJt4wjibJ8An7qYrZZEoZAlixLo9vp3iaqAw4rWT1B1+zlBoXGPYPkRmf36OG0FdoQq0NkdenhhbngrcS0EPPq432L+MZyMSKlhbUl3NOz6YnahkfdXXiNgClP6c7IMnc6cizjBMZcRiAcdjANHi1NQIKaoIyuSENrFfUJV/6kRgqEmR6CoJrXIzVYVcNDPnrV+67W7qHPGGaDvM8htCxdq/0hnp1Aw4W7RbkcgAEW5VUEN5ulPpvSQ+ZaFcHWEH6wtu/oDOZSLlBa8GrzSthv1HnuoqQB0Hx7fxZjawfvbNbLHNfRmoQDuktZqQc6YbXuShgvf/bFZNT5bhKQ83Xxele19TWxjV50z6oAKc0DWx09w8oFiKxRfsQuetmSejRFmOJ8kub+GwKIOxfgYPk11Nj1cY8BhGaBAN3Y62gT/cdKR6I/TjdOMjucYQzFhZFpDkl4MH34ZSSOdoylFkqSU8DXAN99rOanu3VWw2ccPOn1F7PTkBT2FzEfMj4NU/FFa5F9WSd2CY5uoUfocqPxB+T6pxtCbTHGPj58HQyYm4Pkl/+bHpRIw4NniI/47lMUS13AUA1z5/C8eEJw70ymNjeerHWneFAhzUNSc2ZshYs6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(41300700001)(1076003)(6506007)(33716001)(6512007)(186003)(26005)(316002)(4326008)(66476007)(66556008)(8676002)(66946007)(6916009)(6666004)(2906002)(83380400001)(86362001)(8936002)(9686003)(54906003)(6486002)(38100700002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1kIz2tMqKrKs5VpRxJDqYjFR/IYQhmm1GqaSIbhkF+NtH9XsV8EH+WBQgh/?=
 =?us-ascii?Q?gxZWPEwH+yCnzB0UJhLHwHVjbJRlwy+tSgdfXkdE0kaYJQjY3E9MA9beIl/Z?=
 =?us-ascii?Q?g0YxjH+5hcuOuISGbL9J+9vPkUhveuM5gXvkyAFtvLQBVeQZyow51105mq1C?=
 =?us-ascii?Q?ZFFaKHu8CI6qGTTLQsjjFNQh5E2sR/0FGF9QebyR0k8pqd+AdHdXnsUW9c/+?=
 =?us-ascii?Q?pfhg9AS+I2jog2DIE7BuFTsrM9pFCX4ck42hj4qAZHYZJyKSIsHvrjv/iscG?=
 =?us-ascii?Q?y++Pqs1CwetO1Nd23HjbPgrEHqkldhLoSw4WNSr8coePSPjQUoy2tlpfLz2y?=
 =?us-ascii?Q?amB//PAuUeLFMtki8LdZ5VIgwdyeGCEzTlqAfNHN4gJyCbmWB3NB9QvdYugw?=
 =?us-ascii?Q?49xWbFRZmlYpZDrYKl383ydY+I5gz+MhOveYqFnMzIzghl3GJLvPVb9SPlhB?=
 =?us-ascii?Q?IBApcGLtoAOJlM1e36Qoy4PzyQHQTteB/PU7XGwiWUglSgZ8OU6su4tTYbeo?=
 =?us-ascii?Q?jrK87hK0R8tlnzGLeOk2qrrPZ8LeAEyRix4THS+AHvARWW+woABjTikMha2l?=
 =?us-ascii?Q?yQQ3gulolM7YPx0SxiCGUYDReoXJcYbOX+QQdDJ0hfFlcTUfeDTnXpJMqH3g?=
 =?us-ascii?Q?GcHMpIK7ftK1lbSD54QTsOyESVS69CZhL0SWMVXaUwKDMR8vRxGcbJTsb+Ey?=
 =?us-ascii?Q?e/nAoDaW4k1E58ZVvffacj+9jbNW/rl8Sxv2a39AQ6SUa40SgZznNOj2ywP/?=
 =?us-ascii?Q?VYg56mXcunBGXhFDTKbwsh/dGyO7Z4Fyhjf20qtxP72GN28kIsJ4TRqRCw2P?=
 =?us-ascii?Q?Kbvn6I/avYd6fJa8xLSxvEIk6X9nNYeYiuNi2zA/044nWvv+TQxu6Gx7mgGs?=
 =?us-ascii?Q?M0niK9PqGwPTRIeeVGGR8h7dbXG1wrkIFqmsfcqRzHs64xVxAPfrnKPMw9j6?=
 =?us-ascii?Q?5KjwxEGLE41xJjFO6TNfzDRfOvscZaJYde8OIDXjVeHd5yWAnfwwjNTLkaQm?=
 =?us-ascii?Q?DFnu1U1QxoMgLP/7w/pJHjIWD2gNFwY3VnLlEoqVk01yaJEu/u12S/wROXKe?=
 =?us-ascii?Q?e0aQbDQC4d7ObjGD17wAfT68zP27wqRoH+Prr3yna8geeNjC3oHkrIZEnG3N?=
 =?us-ascii?Q?MWMX5TS41glfY7bp3lM61eMtZqkiI9gC3wMY7oqw0fTeZuf9uZ1irhvL7u1y?=
 =?us-ascii?Q?Mwz5GaumZH2oONGgeqUw3R/olqp6AGkhUDyYWVBRi1JOKX3lkR9qe3AmWF7K?=
 =?us-ascii?Q?lxkV2CBhaLpeeANYe8akYwO+Zen7ybSIk3P5eSGECuGj5Dy6g34X+XIiD9ZJ?=
 =?us-ascii?Q?p4t/D2etk1bTY25wQqP9i11BfVrVoE/dNAj5+gGvEA/LsUrtrgmwvRTO99VO?=
 =?us-ascii?Q?QCDshOiMfkrvq09ecaDSWlEi8PFZiLR5vmIw54AmRUJH88HkOuhFpqnen+mc?=
 =?us-ascii?Q?ci3mb8dhG69Xiqp7fC0Vf0VPjLeR2BRqMwHw6tDTcUvGGbQYBrxFBZukPUJ8?=
 =?us-ascii?Q?zgiCge9D3RzkASyO5oM7dDRDUAZaaMUZ1i3TfQFWjvS9lyDdVJ3goYnjHbmE?=
 =?us-ascii?Q?CKZZQno9LgnLZ6/A9N+17vxBbUb3iP8H9E4Z4evUvhrTD7Y4WJkU4rWsmGII?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+TmBadwey7ceKzf1rok21WqegnCHGMIwNOnl+u+RHTRbNdWyMwcEDTKAmrUE?=
 =?us-ascii?Q?wvVBNHaLBROgyTM6IfW3NOt5zb8rjDJ5gAlUI0MmyE4EUknR4MNZcYCP8kEs?=
 =?us-ascii?Q?kqbJlKl/4W66c+PzfFPQNvl4ek7MroMvnidAP1Z6LO1tr0nUqcpFd/3IDYM9?=
 =?us-ascii?Q?f2L9NmSJweh3ZnE1pKd7+c2ZGGQ0OLtDdnqDrw08rkFs8jfH1KB0iyLvrrGo?=
 =?us-ascii?Q?Bp6csrjkV2+V/BY9a+ExB5A6r2rBJ2XUTo4+b7qDQ0CkLA33e6Ap93ISIJuJ?=
 =?us-ascii?Q?F78QmQ9nOuFvCgFeLnQUnv/h5xIcyKfO6MDbssmCjekBxCkYmgVpigN39cd4?=
 =?us-ascii?Q?4BsF3mGrKCH2gblS0mS4CBnvDBzzD5yOOgPA57CX2f0SKE1Igfutm6VJZ2dt?=
 =?us-ascii?Q?WzLw9FTNU5puVZJ6okP0kvWsQ+LoYV20d6e9bWhsBVfcGqFo6BXTf+WrfuwK?=
 =?us-ascii?Q?KT/NO4S1XNVqhnmDE/eBna2H5l1l98Gi/5OD3ROo9nbWjQnp021J38nKH4W6?=
 =?us-ascii?Q?SBpsRz7cZed23v5IJ4prppV1NRxcE9dYnI6IFxSdMf3dGco3X9A4NNUstvSK?=
 =?us-ascii?Q?rezAhTqjbpNiMy+6fvkGyT8RzGNlHv7DPxz4BYhISGFw/cy+lPhVvI6+zK8i?=
 =?us-ascii?Q?H8HRJPLQiqvaK+NGpIL3aQDlNP7LQ/JwpewYYwHPBKdgkjaLgdyrxxO1Rkj+?=
 =?us-ascii?Q?hBnrU/bhmFMJRJMX2zoOiZO7ZM0EjwvaO0LTcq4oQJifz9/MTdPk+ZHYE75E?=
 =?us-ascii?Q?4hP4SNyq3sMnXcA789KjYMX5nL4hzma1+vHK+M4tZneG9OaGMj8MaviSxUPC?=
 =?us-ascii?Q?uBnzF9lpCyTfCu5+ZikLAyowaNtr8GcPl3r1tUIH/jh+wB5enBEvGWAgvp6u?=
 =?us-ascii?Q?rWgRnzlsfjY2qK3UoKNHXriwmWxD/FJbVrrB2KiZvbecLYv/dPxwAXbAtgqy?=
 =?us-ascii?Q?XzmlHuSOHuaJ4Pxo6K8MhoEBFvvWBEQmplgQgNibrDMtAbRpCbDJi2ZFWZht?=
 =?us-ascii?Q?Ny/Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f148d513-4ecb-4bea-90eb-08db2962bfb4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:47:10.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9mDDqwCjI0vRcZXmgGuF3Ua9uwDAk8y/Cpfv++VOUamJ8uznbRXIb0GsOxzEMIdpxQVZz3gKrV6pd4ZCCNm9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_14,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=2 phishscore=0 adultscore=0
 mlxlogscore=181 bulkscore=0 mlxscore=2 spamscore=2 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200142
X-Proofpoint-ORIG-GUID: Lwc_Yur86sQLIonqp6BrgvjHguF3SAMk
X-Proofpoint-GUID: Lwc_Yur86sQLIonqp6BrgvjHguF3SAMk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230318 07:15]:
> Following on from Vlastimil Babka's patch series "cleanup vma_merge() and
> improve mergeability tests" which was in turn based on Liam's prior
> cleanups, this patch series introduces changes discussed in review of
> Vlastimil's series and goes further in attempting to make the logic as
> clear as possible.
> 
> Nearly all of this should have absolutely no functional impact, however it
> does add a singular VM_WARN_ON() case.

Thanks for looking at this function and adding more clarity.  I'm happy
to have comments within the code, especially tricky areas.  But I find
that adding almost 50 lines to this function makes it rather hard to
follow.

Can we remove the more obvious comments and possibly reduce the nesting
of others so there are less lines?

For example in patch 2:
        /*
         * If there is a previous VMA specified, find the next, otherwise find                                          
         * the first.                                                                                                   
         */ 
        vma = find_vma(mm, prev ? prev->vm_end : 0);

Is rather verbose for something that can be seen in the code itself.

I think we are risking over-documenting what is going on here which is
making the code harder to read; the function is pushing 200 lines now.

> 
> Lorenzo Stoakes (4):
>   mm/mmap/vma_merge: further improve prev/next VMA naming
>   mm/mmap/vma_merge: set next to NULL if not applicable
>   mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
>   mm/mmap/vma_merge: be explicit about the non-mergeable case
> 
>  mm/mmap.c | 165 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 107 insertions(+), 58 deletions(-)
> 
> --
> 2.39.2
