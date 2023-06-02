Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935672096B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjFBS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:56:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A41A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:56:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Hf92M006374;
        Fri, 2 Jun 2023 18:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ho1DCsgzqho+3teXxh7cd2H0nlKV+gfO/r/DlqzepFo=;
 b=c1nwVJ8BaxhCLAefbTjAJHQsOao+NzDG8Wiw4WKVsdmzjBvAEPQiDMJgIBBg8PsgJ0kI
 rTKlHeXokieLI6hzCMF9oBgH09dirC7hzC8ApASgDdcHzAB+4GgavYcasAzVDbfznYMt
 oV42SnmCmKiOzDnOaPi/QbN8b4Xrx619aD1/Y6HTQfsjhR03JK/8hnTqB1xA0wNBezh8
 RyUkGjqVnpUYZztwWHBtxP6VaJRd1Y+eFaUgxaG9dj4GxVx8hwOYShz23tflAVbL80pz
 hDn9IFmZAjkapjvZjwcscFj2yPN01zNj3JzYLmh3R3zviROPHnuvZDuBo58Y9hb3QAAA ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhda3sfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 18:56:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352I2QMs004644;
        Fri, 2 Jun 2023 18:56:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8afgwjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 18:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcphAsmfD2MPRAcinS3hhqH6jFFH8fSDPUB+6hYm8CBEJeKfGYwZyW0HUMpPQD6s8UOLumLiTMZzX3tacitOvA9938ClRK5XuI2Ofo6yP9jxifNr5/7JgQ5ZVs2SHYo8LZ1bow47wghM64d4nsYYKzwlvcJ4ppisp1+BNohdoO0fAuFKYk/wGF3DCB0iTRzKMQoVcj7mDEaxFo6bayRa4d25+yyah8Igy/Sm5RV84aiYVnqazJE5kxRvtpkI5zDP/V0xDnm9sWon9DKNl81XZ9E5iV23pU88rR7ddIfUIDzlg9b7pPUNZrHNPkZy4CPkE0+UHOtGD+lfzM4mmAQLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho1DCsgzqho+3teXxh7cd2H0nlKV+gfO/r/DlqzepFo=;
 b=eM/8ZY6PuvbR7sfIXfIhFI35oiTMsfTLOlPJ6Xds/ELn7FH+Emsl+Cvp+DQ9rVWI3Kzhtnn8oObWRywr/r+PlU5As1+DVRbJ5hzc7v1hA6onRTq79SPzleGnLSSmk6dOQZQeV9LBytIT05Ff9F6DR/Ymd9FdVc2E/xH/pXF6CDWgIYSXjMxKXK3r86dy8rEkfi8GVM+NYkTK0YBO1ZiO+n6u2tSnXMYvVfGPeAO3yg+xDTSF0piQ8NMmyPS2eOtpGPYQKlXyNonmbrO6XhyHGM7+GjCta0hpU8ekdH8z9/nvxRTpXIH2cdXIbjPHaeT7XX12/AD4wWAV7Dmxz9kkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho1DCsgzqho+3teXxh7cd2H0nlKV+gfO/r/DlqzepFo=;
 b=wuncjXGCKZLP6SU8NpSYG9v+UX6zz9ST1ZeLxKJsIM2wLg36wEncjstgyaHZsM4R0tXbP7jJiIqsT7XJX7aUZpsAKwOWK6SqDIzpCfxcVA+rH/1GYoqaWt+GNxs3sgdlipfQUCawK8gNU7oReBnjf/JIBUKxTFyYfHMpvEmb2TU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6015.namprd10.prod.outlook.com (2603:10b6:8:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 18:55:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 18:55:57 +0000
Date:   Fri, 2 Jun 2023 14:55:55 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Message-ID: <20230602185555.irsxyt7svz7h6igm@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: bc55b3ac-aeb4-4153-ab5b-08db639b0029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yshjIPVYUyiFTp1sSpl/Gx1BLS2uLJRtUg9lBtg0RY3wfB3TnQpgQ1Vrc6AWQR2ByC1r+DdAk5HcrNwHQLYBOhF8Zzs/2h0uLy8ejp1gS4k5ynsAO+nbOLBdcbAeqJhhxl3kspzOw9XvgYotczr7oUoZrBx/+JTLRWSOaRmBX7mzFrmWis24fQ1gseOY/KiWpaQk4axF8xud5DDJiMCfCLriWw+QW6e3HLzuq8YBml3M+YxU8u/b8JIFn8L8YaAiQFAhvtyh7VPSkxBLd6OWZfoInSWPoxUM8P/uFCC4SbsYpnEJ2T9lmt0dC5JhSGSKJsJSW42VUB36ieBI2u6iGkp7SeCO5Ikc+jDmz1vDmoXmBH0TW//uEKAZVokAf6DqB+8sZ/KWViYrMzrfFkmecE6317KelUqkVdaiXx+Qqld6aDGkhPkYJy3Y6DNefXjjIWoKqyYjrjT9mnHw/oaEEM8XS6XUrAlg7H/YvF0ckX8g0QThWx6wNyWAUIq44kTB/j20hci/iUZXjopbjiI/U2JJ/AvLmgRf/tgNah8NqRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(8936002)(966005)(186003)(41300700001)(38100700002)(6512007)(83380400001)(6486002)(26005)(53546011)(1076003)(9686003)(6506007)(478600001)(54906003)(66556008)(66946007)(6916009)(66476007)(4326008)(316002)(2906002)(8676002)(5660300002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LDu7X5TBSr6WgptL70WpqiP39uveJlZcz0x6t7ycG4Z2okrFiaSOSSxeODC?=
 =?us-ascii?Q?a5voRqU9VWImv18wsdKwBtHyFmLl4aNhoZurZNCXRM0l78MXs7fNQ/AA7cRe?=
 =?us-ascii?Q?DJhUuXyoJdaNTapoplGTSgDww5zweEj2b4aDu9ApJcHIXWfmhGDlEtZxMjaH?=
 =?us-ascii?Q?OGf/0378OpG3eggU9r3/CL01/dxsAG2ur2NNJN+1wwy6wTl0JPHjA+P6cul3?=
 =?us-ascii?Q?GiidczUBatnJNRfU3nS7Q4RAsnaceghdnrEbZBkt5S54vatTzvHifIOmMS30?=
 =?us-ascii?Q?9KBSVAKWN86f5i9J4U/03nBZLlhB9xgy8OXIWI4izJDT6tTHrM0Qu3NCAQni?=
 =?us-ascii?Q?IG2nWdk/mhhkbyzjwTjIpiP1ecWoPFv5pBDbMiigTe2wadhVImQltgSL4SXX?=
 =?us-ascii?Q?hZDhzLRgIPuaFWZKX6U1ebRahyR/YIwRiPUWiHO/8h9xz+CzQv1c+jyakocR?=
 =?us-ascii?Q?xY9DO+YfFQpfSyj49Pmm6rTbuRAvSFVr+PPUP2vys5uRYvCbyctdOOB0lvS2?=
 =?us-ascii?Q?lFiu4ieS+0hFwadyqp9wAlSzllLLQA5UA5p1c5dbGWQiaTe72ILMVnfhC/Gv?=
 =?us-ascii?Q?rEkhYNlCQNzTDITLB56eiRQYzfVuCumuhV+tODxRQucNi4976p19ogTFTyA7?=
 =?us-ascii?Q?RNv6gvWbMRIvg/q3FhEi9i/qSHHThabYP7oMj0ViF4qygvpLHqOquKyon5xI?=
 =?us-ascii?Q?ps0wFj5EI31dIXoK+aRxc95RpK5nrQobyqPF9eoRdf2svfNWJCT1z8vCxlla?=
 =?us-ascii?Q?efdgJATLv7dkcwssDsR5q3q/f6nR/55vmsWbaHU9XDjUViTuS+Xv9pNxLvhu?=
 =?us-ascii?Q?LNGvamXIWpBeTFexNUMAXMPMZNFN59f4wN/JByce1d62lWneY8PF5L9RYsXq?=
 =?us-ascii?Q?EEYHa4MWJkyLRr+biaR5U163cIflXJ7mj3MrDbRMCzPVi0zyfZ6EWZ2Yy7uq?=
 =?us-ascii?Q?MZmDBW1A04V8IObgMcmOoD8LSCziCoIkqjXw8Co5KQb3Nun960fbs+SM3+b8?=
 =?us-ascii?Q?3D0P4rXvOzolqXJjySxkBz3Xi+8pxJtU9L5MXdxuEf0SuXAgcKWvf/Pi91XU?=
 =?us-ascii?Q?noUCS5Ju/ltg+kLK+1BohrCvxHkYfygXgQB5pavwI6JcRtblRxAqnN5MqvYG?=
 =?us-ascii?Q?g/61BQOUDNguUcc8iPWAZNSGXr2Ck7kPPEVUEC5floBrwAwNrRck60L3npqm?=
 =?us-ascii?Q?CEat9iAWqhOgD1/R0/UvdIa4jQYxFI5WABMYpEkb/hdt4fGc8PtH+JwiLhZs?=
 =?us-ascii?Q?m/dvfpvu4iaOFg6tQd0leGGJ2to1Sczao+JfHNiBxTwmdRMF6YsHOVgZO+bv?=
 =?us-ascii?Q?5oD2QM0BWZJcmD0UytRnUP1TOyZMEswMUxw3J8ViKLe4fchcnBmRL1pjyN4v?=
 =?us-ascii?Q?WGxIn7emI+0/ylCiJ5VDKV1SMnGkR+xmvj9+vbZZy7MtWRLWxZMLpU9Z/M1B?=
 =?us-ascii?Q?22xvIDVYJiFKduHtCkjjQtHGa4erRlKupN8i1Mq3HiQj8dR5tgbrylFAN3mq?=
 =?us-ascii?Q?AAtjbj01zyZ0EWfsgBNUUi7ZbK7vO6yED/JKLudNH4OrVCgHRtZ19OqOdbsU?=
 =?us-ascii?Q?vvZWzdEKk2mlA/vwrQiOzJKaefsLqGKvHA+BHYoA2JyAV6XIVbEtcm8ZyWh5?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9QFi7qLkTVHgqDDdUIM+o5dv0hDsVc0QGO/7UJokEQ3lzx7tVgLc0ovhnbTnAQzsIzL2TSm9Jgj1kkMSBAxkQfo8LWr+QqinjNLGlrAYc86pc6k3uOLrNrzg4r+GZljWs/grcVv3nAobdHZguWWAoZreEcKX8nhVii5vKfJyKWiMh/yBT1VhZlDaO8QAdFwDoXFme92030vq1M2DsUAv+KbVyrcqLAV0UA51VFPeduuL2Fz/htfxgrbQGW8CRCl0HMphiSniQBHS3Ir2Mn/KLTrvbk9Uq6Gd6KZe0yXrZFVkgJGPW+dQ7h3pIAvulfGDZ/cNxS6RMT5xpZ3R2mDZM01OSxMKwhERJTythO4dqc7O79mJgwEZcNcUvHaZhzjlRZF9lfj5L6Y4+WwLMHkZlKr0UarlLn0r+pDq/XhSPCABDKeo5K42m1Bf0SHVEYIjLxLCjxeH7+bw7lnNX2KfhJb0lEVY4FaZb18R3zMWNrBlGMm+5UojxRfQLyBurpB1TmmBr03lX293DEjlvmaWlHcpj+jZXUgQJjS3jbOD4D1mlke3yRj3NcjOuuYiSXfZw3He4k32PUS3bWvD6i/dVFEzs8aQRBKoOjuFi32Yp9+alPbVSAUIHs9/MyTbxOS0I/55T4X729+zftZqh/tEh0XeM7eJ5ONzCtv7kE3hDTooWjZe17OZVfAZzDoDtV2gOPGMnAXaUddbP5fYNQJZaKLQrGPaqcWyA+deAqI1G98MrnQVKh4UMetWLb9AfpjOrdchRUkRw5Kv6PjE36BQUPbehpOYaATtrfs8M8I3YpjQE5E2xb0XRvYmAQyrNYjcR5NXYR5PWJS+Vm3J5zWOUSCUpKXMphNYTWwu6xC7ZRNy47dNrGrEE8xkhkli7ppnLB2uNixo7uzofvCn/rD/DSlqqfic0CIk3afOFYl/7Do=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55b3ac-aeb4-4153-ab5b-08db639b0029
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:55:57.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJkLITJpxWLSLZ+mltcpcuvoZP/gkzBMNQHD68gGKc8iG78Yhi+REjl39Vcen3k5IjPcF0QMDNguSreMpRmVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_14,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020145
X-Proofpoint-GUID: UKmZSU4sQejAPCwmry96nA0SSd7IzkPf
X-Proofpoint-ORIG-GUID: UKmZSU4sQejAPCwmry96nA0SSd7IzkPf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yin, Fengwei <fengwei.yin@intel.com> [230602 04:11]:
> Hi Liam,
> 
> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
> > Initial work on preallocations showed no regression in performance
> > during testing, but recently some users (both on [1] and off [android]
> > list) have reported that preallocating the worst-case number of nodes
> > has caused some slow down.  This patch set addresses the number of
> > allocations in a few ways.
> > 
> > During munmap() most munmap() operations will remove a single VMA, so
> > leverage the fact that the maple tree can place a single pointer at
> > range 0 - 0 without allocating.  This is done by changing the index in
> > the 'sidetree'.
> > 
> > Re-introduce the entry argument to mas_preallocate() so that a more
> > intelligent guess of the node count can be made.
> > 
> > Patches are in the following order:
> > 0001-0002: Testing framework for benchmarking some operations
> > 0003-0004: Reduction of maple node allocation in sidetree
> > 0005:      Small cleanup of do_vmi_align_munmap()
> > 0006-0013: mas_preallocate() calculation change
> > 0014:      Change the vma iterator order
> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
> this patchset.
> 
> The result has a little bit improvement:
> Base (next-20230602):
>   503880
> Base with this patchset:
>   519501
> 
> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>   718080
> 
> 
> Some other information I collected:
> With Base, the mas_alloc_nodes are always hit with request: 7.
> With this patchset, the request are 1 or 5.
> 
> I suppose this is the reason for improvement from 503880 to 519501.
> 
> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
> mas_alloc_nodes() call. Thanks.

Thanks for retesting.  I've not been able to see the regression myself.
Are you running in a VM of sorts?  Android and some cloud VMs seem to
see this, but I do not in kvm or the server I test on.

I am still looking to reduce/reverse the regression and a reproducer on
my end would help.

> 
> 
> Regards
> Yin, Fengwei
> 
> > 
> > [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
> > 
> > Liam R. Howlett (14):
> >   maple_tree: Add benchmarking for mas_for_each
> >   maple_tree: Add benchmarking for mas_prev()
> >   mm: Move unmap_vmas() declaration to internal header
> >   mm: Change do_vmi_align_munmap() side tree index
> >   mm: Remove prev check from do_vmi_align_munmap()
> >   maple_tree: Introduce __mas_set_range()
> >   mm: Remove re-walk from mmap_region()
> >   maple_tree: Re-introduce entry to mas_preallocate() arguments
> >   mm: Use vma_iter_clear_gfp() in nommu
> >   mm: Set up vma iterator for vma_iter_prealloc() calls
> >   maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
> >   maple_tree: Update mas_preallocate() testing
> >   maple_tree: Refine mas_preallocate() node calculations
> >   mm/mmap: Change vma iteration order in do_vmi_align_munmap()
> > 
> >  fs/exec.c                        |   1 +
> >  include/linux/maple_tree.h       |  23 ++++-
> >  include/linux/mm.h               |   4 -
> >  lib/maple_tree.c                 |  78 ++++++++++----
> >  lib/test_maple_tree.c            |  74 +++++++++++++
> >  mm/internal.h                    |  40 ++++++--
> >  mm/memory.c                      |  16 ++-
> >  mm/mmap.c                        | 171 ++++++++++++++++---------------
> >  mm/nommu.c                       |  45 ++++----
> >  tools/testing/radix-tree/maple.c |  59 ++++++-----
> >  10 files changed, 331 insertions(+), 180 deletions(-)
> > 
