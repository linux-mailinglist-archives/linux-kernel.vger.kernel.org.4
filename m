Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD566A6E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCAOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCAOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:11:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C710DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:11:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321DAhjT006334;
        Wed, 1 Mar 2023 14:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=p1kQ6sKIMn8oniPsJxZZwr0F578Ue1efR64uk5PH6Us=;
 b=ecm16TZZeegrd6cjSNI6Ey10WVSeFsYIGGvzx6nOYX5Im914yeexcpIZYbAJwhqZTRSX
 zdkcPS0A8IvE1zTL+aVFIbJdXpRDIMnzYAKs5rWoNBd3eIJMLSuDE5x/uS2J7ex4ss1C
 gYuee4MjuF5yMkV8vsDGSiXfw0L57L6pF51wPzcfreezuXE2PnMi+YJgSXHj+VII9tFl
 fG0Cudr83/JX9NhuK1CY6dFT527l7FDmjtN0D5GbWHGl99xpV6xkuz8woB1Vn2aVNd7a
 mDnQP0T1MgA9q7IJXPFOGuWjS6YafhjmazQfX7WGmjQh8V91B441OHtQ1vPSiUFO1x8h kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ah122-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 14:10:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321CxekW000450;
        Wed, 1 Mar 2023 14:10:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s88gq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 14:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm3bZVa4zOtpVaG01We8k17HiZNkg0mfrT255It0W6cigHpQ1tU8OtFZFZZQJSeMR941R4J+spnZ6NFTJzdMOsz2Kz6vSb+69hHCsKzwCH3QCSHKupSggGppKqVvL2FhJ0HmxtAAM3Jhil5m1MijPXTpyoJXNlzqYPoo4RHbYtGN2i2nM/OhoS32/Xl6hVBlRMND/Qc1of/zud6WxWRvoVMkhpqrv9LgUkLPapnO2jCCLPrABh83Aobk7iv4yJpDJzLawHdbpj1yxOhXDL9E+K/wJ5/1kEki2WwkvV4HWK4hSaftehn2EIjOdqqA7N6pWAU6aI2jddheJ524OneCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1kQ6sKIMn8oniPsJxZZwr0F578Ue1efR64uk5PH6Us=;
 b=F3ZfGaNKQyVnddAOkTuaQ1t8ALbzkDZPs6G8Ybvvzm66uFyR5PrUojpDcy/ZJjDz6QqOQxBjKAn2wwE8SLuuYX7aTZEd6I2o19s164gaHkm58LAiT0LXxkwspSEIZiuUzL4Qww9WddKqIrkO/Z86KO/Of9S9fHuwMmCw7Bmhf28hwd+RwkKjiMc2JcOZM+kEJIDM9cwkiZ0G37pgwyRAgGpmT2M3GYPM7VEsMnXcvAP4JhGfKex3SdphTjjcf4SEIGaDRT5X49UjKNsk6OYUyV2PSuuBSs/C54iXjXoRuxgIwZAbGvSS7QXSddDG0ygzP2tRd9CYYF5GXVVvlX4AEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1kQ6sKIMn8oniPsJxZZwr0F578Ue1efR64uk5PH6Us=;
 b=BqohbXi5oDrlGUNGU9MgFPduyGdxp0t7yjJwEqkVsytYEjtID3Q43pZ3so/UlWmYIix+9hZ3qsjZ0Xev9J7MLYdRD0b7Oa1PuiScMWsNDofAjGOeRLRBiZKBYuZ55fybpd/F4X74qzO3e0fkhMSSWfEBQrK9hl8mwzI9+i81Zao=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6509.namprd10.prod.outlook.com (2603:10b6:303:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Wed, 1 Mar
 2023 14:10:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 14:10:06 +0000
Date:   Wed, 1 Mar 2023 09:10:03 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, error27@gmail.com,
        willy@infradead.org, david@redhat.com, jgg@ziepe.ca,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] mm/mmap: remove unnecessary vp->vma check in
 vma_prepare
Message-ID: <20230301141003.xh47kjle2lcezn55@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, error27@gmail.com, willy@infradead.org,
        david@redhat.com, jgg@ziepe.ca, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230301022720.1380780-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301022720.1380780-1-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8934b2-1ea1-46f1-7485-08db1a5ea8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgDY8qAX+1PfpjeaUOFjAYFo/aw/XD0/4LmFcMMQ71cyglEhJYf39T1A0MLMuvg0D9HuqvcRS4SLnNIVi8LPLtVN62gAoL7RADoA/NDUr+hh2ADAwa0mDokkKEyD9NkOAK72YCiajefLXGl5KPDt6FtbtTIgAawGAhoq8LMhpsEpUro97wyfknRTe/aZ6atJMYdpr5UlG5R3ih4TERy4fUa0mZ78tMwsaO1YYPhwqrPSiQ4Vj2nuevmPNePFYvMw72Dr2MZY07MxE4p+kmEabOgXi+2OB98cw3KcIqBU/t1zqfAFrKzEpurnjqcgIEHSIReK/X+drcER+WkXHA6bhlX7j0QYCUrwRAO+Q98ztitbvuaxDaXOBu66stCyhpT1MDOA9CTmpLWRVlLCIN8A3F9AmOGKJU9w+Sn53N9vJEvWQibo74z3HnJ0kzpc+oPxbi7r0R+SYaVpqZARa8VooElWEq/QrIFEd+xJELd3lbjIjzYiN7VRBVVyRbC4aHrW/pHtFdScTh8wpfMj4l87VKpMQRozcoeCaW8TYGttXeXKiMvlwL2tEVtieTSHvAHDSaVSRcx+ia8mK2FfTOD7PMd68Ykl+wcqSMSgtyk4cKaoNGR555ZzUmHLT5iE+ZnI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199018)(38100700002)(4326008)(2906002)(86362001)(41300700001)(5660300002)(6916009)(7416002)(66556008)(66476007)(66946007)(8676002)(8936002)(33716001)(9686003)(6506007)(1076003)(26005)(6512007)(186003)(83380400001)(478600001)(316002)(6486002)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?honNf/ctUBdfP6gCBm/1cxGNmjKF8cYhAJHwzyeueOJA38rIU08qgtsRHiVV?=
 =?us-ascii?Q?ulZThEtxDNzjCrckX16Vy0swKH8qL4fSyhFdYwqE2EKgQ3TWJEC9ZXuVoo1D?=
 =?us-ascii?Q?4DJ3eDGKE8rlGJI6V7KnTREadO/7K8Re4tc+I+hnWn7n5rIk/tfR91cHKrqh?=
 =?us-ascii?Q?1AKMHVmDO1qqWna5+0b0YTWX+UunqcyfopDEoSG5BO8fOY+wJgh0+120MaY/?=
 =?us-ascii?Q?WzO1ZnfkyWxJpoDg2X8MeaMwm0Q8LcuTMFxuJenmKJpiAGDNn3QKCHlcXyX2?=
 =?us-ascii?Q?vbMYDJDoYYceWbE3DGxcBCVHjNtQz9tauwt6OpnLyzeDwNX/IwyGz+SLT7Fk?=
 =?us-ascii?Q?KbGH4jiq8zpHzoJn8UlL9p7wJU559SqdIj4+1FaC11Vdc/3mJizmAQuFnNhV?=
 =?us-ascii?Q?57KrJInn6DvfTIccDFMmwIRPaFfxzMnibSah/G4x5O7KdTbpdRdKCPG8b2ZM?=
 =?us-ascii?Q?EpLd8U/zh3RcL/82i/hqXKLM0kjMZ7Ps+DUGMbR2P5M+jx81cQP5Nll976JC?=
 =?us-ascii?Q?nyCQzonUkjSkWaP7HLAfsE38ubJixII5uKFv8aiDbYFLWIPjs3WbIrmgB0eC?=
 =?us-ascii?Q?faXhwEaRssR7xY/R4CHbEVVESg5kGAnq7D7/BSt0UqCwGfoOaT/dlTFSUR96?=
 =?us-ascii?Q?BctYp+6+TDpwRbTH0jhn6ueKTh81EuMP5JvWeh1B6S30CFLgAzHwprhJXCp2?=
 =?us-ascii?Q?xd+51gWcZEVcjoeAH1afzPbAIVyVgG8RBoY826qF9l6CO1NKbJeJo6sOBphS?=
 =?us-ascii?Q?bz11QdEPPaIBYGd6ysz8tvlJhVdIROlrpBu6YBlS7Twpg2S0PKX1y429RuAt?=
 =?us-ascii?Q?i5WxWErGe76lVli9APxOyiV7CJHzw8kIzfkeQQm4VepxBTI1f9iPs5iAynSe?=
 =?us-ascii?Q?0T2LLyBa4zNj1SAOMt6NFZS10gRXZeKdv3w2gS8qOnv8bDwZQrA/OBm/ts4k?=
 =?us-ascii?Q?+5M2kJDF/jbgdHtbRDVdGYTekVln0Uqdudpe491nmLILPQdffwqYeTtiJJUe?=
 =?us-ascii?Q?RfL/Oy+pDuCiBmJDgWWgI6BLLccyUxPfynetH/Uyh94MrY9RuTMc1y4urdiV?=
 =?us-ascii?Q?yODIAYracuHTC5CCUOcsOtTRrHTSFEpxgeFu7RGgptJyzz0vpARTL2AdTtK5?=
 =?us-ascii?Q?x6sU/+xVuVMeuGfA7TJYJB12zipt20NV/YrNcco5f7pYC1uxRk0tySy7x+3v?=
 =?us-ascii?Q?KpUdxZGxPl5DDVQtls5jobnEKiF9d4GuS0M9rZePGpbvqXgojRhLqOetYBje?=
 =?us-ascii?Q?fFkw/0vynYm4xecucaZP2LjJZKe8diznqRoLbDu0lyRRFCvSY17aBO9oEObY?=
 =?us-ascii?Q?nSOH+u1V4pi4nc58ZXKzTibkYz7GTy8G4LVJCtb3XJageOVsTf84Mf/PIhj+?=
 =?us-ascii?Q?D23M7GoLSQoDsWhYN7N5oN+KveBVZCzs0r8XTupLJTT1qplkvIOCCCHej164?=
 =?us-ascii?Q?okrNkTEFbckvWnHcQipCShK36BcCBMylP4DojUe7846RsVDEihp6UUxbAzzL?=
 =?us-ascii?Q?9pPWdS2IJTYbB1qO4KBMfABQ+uG2ZDqTrYsM8Yg9v4FGa9EvRA6G+E9AR6Ur?=
 =?us-ascii?Q?84bnt1EVRiBKTR4sYjlC2BgOf7RhaPdKZQ9YgNC4Zz93iMUTDL43ge8GvQEh?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QZBxWewixPT2pBXxJ1kXAFa/xAajpPTnvDphltisgpax5bAsamiGTaN2Wrdo?=
 =?us-ascii?Q?TnPpxjJtrJekT1OC9dn4BqMAYIyJwTPiqNcfsdU3/PHfxNDahRTVUQG90KiZ?=
 =?us-ascii?Q?Y2okw28qQrPVZ848OF7Z73QsvHJeC1kovk/qoRCNpWOXSAW3QdFheyGSVaFd?=
 =?us-ascii?Q?Uyr/x+jhnAr4lTzfqYoYJfrqJaBq8kaElarKf5rpEhCv+x/MfYzYUMFBy/w6?=
 =?us-ascii?Q?bABrDLTai1orFip3at9iQTuBh+pC+ytfaL+WSqzGIPaF18qEgVYGqTsNZNIc?=
 =?us-ascii?Q?XwB11RzbjEJbzAgpENh8MDzSmItn+mjrOstKGczOYvCEfrWYsCFfpav4UvwI?=
 =?us-ascii?Q?zMg333+uXFgXlI1WX1FG7w3Ly0Z6TohM2KOn5z0KhqP5b/GCZ2EjHQeHkKzU?=
 =?us-ascii?Q?SEE5HGtvNJbeF/4Ivl0ofACF7tSYlYinxiD2wB5lZ3WcMTrAzqH/mfMrVBFo?=
 =?us-ascii?Q?t4fFuznzev0lhr5nwlhpjsMUvPcPI20WK+DidTB+350A6yMnPKfanBRrthBT?=
 =?us-ascii?Q?iIS/WUHouWwpfhFGJq2f+y/u2fk5dYzWGYA5aaKXsICpzqWn70PFiTSSBtrW?=
 =?us-ascii?Q?azDN2zkXaDg6wIb4U2n3UyUyhUhAW1Pj2QB6pL/ZXG/b+KaZ1k7t/rQxC7so?=
 =?us-ascii?Q?Wt4VL5+NJ33rgvgDWBvO9vOr4lOfTcsH7BrQWSQYB1+cxAnIysZoaZwfHqC2?=
 =?us-ascii?Q?4Ef+3xEsx7POa3OZlioRelRO39bzoQJm062TqGJACIPpsNo7+DA5KQsLVSdp?=
 =?us-ascii?Q?Q5pI8A4b75tS0XXclltKG7k8EPgtNp+0qL/ER5N5TGXKi5giT+D55ekJtc/A?=
 =?us-ascii?Q?6jNy933w5Ph7AmseEgTHQPvfu/q5qB7L9GweY5XencQiqHBsI6wqXoi+uVOe?=
 =?us-ascii?Q?og9y0yKtstNVG+gcn51SzJUYkAYibwX2cTxpGiMTPSLVAjUOaK8g7zN9ZU1g?=
 =?us-ascii?Q?ACWFX7QEuqRcxJv+bwYIXfEqAjZFkG662bVZCSEi5YW02zlbLOLLM4VH6ylT?=
 =?us-ascii?Q?d5NsRPIDsiNp/vX3ZmRScCu1+OxJVkL5xX6XUigRKKkeyiUsJ1gDFy0KTOIt?=
 =?us-ascii?Q?8euHwZZmPmHNO/YtI9gl78jCvuy3HwxwZDtUYmuc3poFcQakSqauh/p48YTJ?=
 =?us-ascii?Q?/wF/1RBrAsYEwmEgaA8nwnvU2Azv9ZAozQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8934b2-1ea1-46f1-7485-08db1a5ea8f9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:10:06.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE1D4VnvCuRbkPG/k5xTCmvNi3lwzlzxXb+hnJ/KV/lVFucxOy64cK6TBOK3s3HraqY7gMLFEO21SXtFIHlYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_11,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=899 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010118
X-Proofpoint-GUID: 9WfZVBxB_bkBxHXq8fraTjB5ri1EG1Mh
X-Proofpoint-ORIG-GUID: 9WfZVBxB_bkBxHXq8fraTjB5ri1EG1Mh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230228 21:27]:
> vp->vma in vma_prepare() is always non-NULL, therefore checking it is
> not necessary. Remove the extra check.
> 
> Fixes: e8f071350ea5 ("mm/mmap: write-lock VMAs in vma_prepare before modifying them")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302281802.J93Nma7q-lkp@intel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.
> 
>  mm/mmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0cd3714c2182..0759d53b470c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -505,8 +505,7 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>   */
>  static inline void vma_prepare(struct vma_prepare *vp)
>  {
> -	if (vp->vma)
> -		vma_start_write(vp->vma);
> +	vma_start_write(vp->vma);

Would a WARN_ON_ONCE() be worth it?  Maybe not since it will be detected
rather quickly once we dereference it below, but it might make it more
clear as to what happened?

I'm happy either way.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>  	if (vp->adj_next)
>  		vma_start_write(vp->adj_next);
>  	/* vp->insert is always a newly created VMA, no need for locking */
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 
