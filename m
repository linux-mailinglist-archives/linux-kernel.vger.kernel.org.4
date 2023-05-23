Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3070E3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbjEWRZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbjEWRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:25:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42065132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:25:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFTLYc032561;
        Tue, 23 May 2023 17:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dLX25x96jYgsgrLfHjhbpo+Q2GbRCFvFeEI/Y3siRNw=;
 b=hWkRzDa9Xq5NzZJ3wodZocQVveKESOFMiErR+ftTucPWJbiH358zkxt6TlBRPogjZYml
 SrtHjimg3uzFcm0kXMBl43Gfd/g2mjAfc66EjFixpkPRLxD7ucW0YrBVugFxyLlpFF5g
 ROLuoJuAqiy4CUIklr3ymD72EINGsfbojjgiEQHxe3R302vBoOX7YRm/ppDZ9TYzPWmE
 VA9G56LsUkV4rKySP3nmSHEEDjBRwOOwcgLi9/CfPUnzxVe0+Wy9wqoyh/RPJaS8ddUt
 Vgs9rAqqxEjmSK2yFwEhqEnj3Db9CIBwGvmad4R08GIS2EMJkzKvSvyIw8N7NgLKiH/E 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bnrd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:24:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NGB04L023912;
        Tue, 23 May 2023 17:24:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8unc8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXzNvv7pi6PavUSnR+JucuMVlakWRbI4XcO0OMtjl34bkQ0VXwjZKuaezZl9FYoOELs9AGRv7MXWTrM122ru8XN96S/1GHQ0FRg7DPYaZgAe6AsWKkxNV614EXYhwFcU1fOtza8Oxy1ta1O/rgvxfleLpvpkkBMPBZkqeeiYHZhAK9RqDwx6VvWCJiigbg6tLsglphtOTLPMW013EcXz96SICaN9KvE1pXF7gSQQgrPwxQbnECzzJ47fMuKUOUUfJDljBSCFZmchKO7gjfVkzW7NTkFlLTmiOdlg6DYsWwvUR6t6cjl8oQSsuPKckzHSksdUK36GsXBqoAxfCa+oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLX25x96jYgsgrLfHjhbpo+Q2GbRCFvFeEI/Y3siRNw=;
 b=oCmekCKtUOtokBDoWo39Jt6VWTG5Wjm7kzOPyBhcrq0O/Fg5ErVKa0J5W+kl/yiR6bdCaheUdz1IuLZ+dITyFSnvIRZzdjFazU3Kdx6fbN0jGixbEFc4LzkbsBPvzKYvuhSKf2y4Koqaa+reIzeTZrjpy7/w5kSyMmlOL97DlkuuC8SW/ZieaHrVhfRinEDmUOVJvinQagoMjCLVWTFScqelMdZqWLYwowO/6s87+HHgvfR7jC9t0aUbR4ZHSTXQLVqwDaRz/A9pxbhRgOcDuUCB53daCqidd11sOTmdwEyeV3+DmGQKEiFbELzLahEjU+ib7f1SeYd1k9BauhYKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLX25x96jYgsgrLfHjhbpo+Q2GbRCFvFeEI/Y3siRNw=;
 b=ZawOtGeyx3DmYmrgc/pRNMwZI74pIOkv7yqvfMFXrSvUCE+R+g68gwHj3mADoImyq3MpxJEP9nFEJSCas3RMm1+wEVpd/9Chid2ni2ewPI3T8eubp3Ds5y5yiQadLaHpWz3F93OUdOcBoqj9U9GeAK1F5ZeHajqhDJsQfvjW434=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.29; Tue, 23 May 2023 17:24:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:24:12 +0000
Date:   Tue, 23 May 2023 13:24:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <20230523172409.goshjwenknthrbr4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-3-urezki@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3cf123-7a92-4fee-95a8-08db5bb28687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUWvA1nifdNQWXX1PfM30w0ghPbfy9q3ZVCh/6PVvZcNfE/F2rerw9W7knzucCzAdt+yoZW6nBAXCQ4LrUmjknoskEFECL+axOOX0rplRSbke6JydkhcdUmnJkcz3duyPr9Dddz1Jp58pZtQVaG6M2CgPl28Aq21qiNER+7i1EiPZOTmNzJP/Eu+/UzjWQXXe9ABBuODKaS8O+sDyDW1F/vY/qln1+ujYWneiX8N0AhcS2ERQy1G+mRoYF4rYY9zHZi/ZVSqXE2uCySM/IhElsiojsbCtoj0Sq2qbCfoLmFNCcclSi7e3d3ZaNw7CenGDzUfqqJFQ67Sx5UYPiX76oVgDCJCf/uU3RJ40pU5wMxUtHHiW9FqyFTISK3v2U5ZfalHPppEJ1eelQqs/WLiTSDGixoY1Lo7dJhTv3IX/Q1XOitWPzD2gOgyAiLpjeYlI54pvNebn1Lw9hoK72XTlAVtnlahl65h9VVFK9FbcWF5Ooed+NcvWu2DjyKNpTQ1tYk1zZHPr9oAmIwxLtyUP9YSY3zA1slibvwN9L1yoOOZl8bBYpouSDbHFgwmUocV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(54906003)(2906002)(5660300002)(7416002)(8676002)(8936002)(41300700001)(6916009)(66946007)(66476007)(66556008)(478600001)(316002)(4326008)(6666004)(6486002)(1076003)(26005)(33716001)(6506007)(6512007)(9686003)(86362001)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S59rU9CcXnuvQt2c2vmtpwTrrhHEuAKu1oFgkZscy2cC3XCJaivTd2+qk60Q?=
 =?us-ascii?Q?uqVj4o/dOCAlJbh1dGm8cFgDubYcIVVQTr5yn9efzA2vMJ98kiAMfIlgWZPm?=
 =?us-ascii?Q?NjI48BeEweYbV2hhyDE0JV7G4JfBEfOvEgtdGAFUKiSVTZ2WCrylv3gQ5bDu?=
 =?us-ascii?Q?JaanPk6pCim1dO52Ln3SyF1WGp1C2jLLttBqlxnyjk+Pdk+uFHvAChaV0/v+?=
 =?us-ascii?Q?brGXFbX6ScvYUBCny7rzvINs2WuGYN4L7zsHgFVcPgKKCEbHtltoCkrxFB8T?=
 =?us-ascii?Q?LgnkqbZwBtnRmTqf3pr23UXgqQPQL7aY50NKATaH13udAn/IugoYoEWkPYV4?=
 =?us-ascii?Q?7wxyT5V/DDDLzs0Z0QsQPrsXbHTbs46NgXpfdZY1S1UMKU6Rpn1lElArWiXI?=
 =?us-ascii?Q?5ZMXmh8miyw94v/HvoImf2mQh9dHxrrdxgFPYbrmlL5OpkZUVKA6uEGTZ5vN?=
 =?us-ascii?Q?Q2ibD46mJ0+ZJSvu1Dpw1oj7wMOQ6JJnwhFq28+r6puaWPuL8KbiCujy2XS5?=
 =?us-ascii?Q?g535L7t9HkLjy/1on0yNyGeyo9oEjQQz4fHsQgCDSbGqovKg++Yi/hx9I+FE?=
 =?us-ascii?Q?un834xy3rgF7Qhyxg2oEAbi+Qtd4CFskXfTsJE7Ceja55FM9BxK7dN11NrjC?=
 =?us-ascii?Q?Hux8e3OPkXWV1kby49MlABDYf5ULFn2BEwcB1jVQT//dBp2ukmrORNrBuMY8?=
 =?us-ascii?Q?qfrEY7daDSloeuDW0O3/eEzDNniDdYd58VCZF6nKPrIO8Y3j+AbJuAiZaEkw?=
 =?us-ascii?Q?dZmj/NUSa+61pR9G4yRd74QEDyVVj6NEmxEhAXl2dhZ23i/0C03FH+r/FWHo?=
 =?us-ascii?Q?mybzo0tyg6gMoPitHiRtMb6B9Z6kEFCgMFmLShV/bKsaEfeF8F7UTtivGb69?=
 =?us-ascii?Q?TlrdBwS+m/rIXlfuqloIU6gJo/MpVJsUvgsmuIxoyhT+1MsMDAaD8OihiKP/?=
 =?us-ascii?Q?TJETB+1tRj6GNq7FuWP/trnIBnlQGkPR+5uoKjpWrfAwxExFOupKbb1Q+Qel?=
 =?us-ascii?Q?bNCzFqIg9kRKLEjJANxTkcORSz1G1v3c8hD9Z8oVffHB+xpst0e+ayw2UUPz?=
 =?us-ascii?Q?dyiVlJH6yJQ/K0RrJpZCbPvSYWWtl+J/kNsUhZpWAFy9VRaHLh/NrQeOIKnB?=
 =?us-ascii?Q?2wt7q0Q/OQ7RcHbgqgq1+BKhy9mzdcAwB7JzrIJm0OeSeuyIoYjvVgCFROA4?=
 =?us-ascii?Q?6bbEH3TAj+p3s3P2GrOpxcKnqgwHft2AbNY9tfElLR2mlyRDdNl2LkNPnLkj?=
 =?us-ascii?Q?yhobe44KSvlmkgnI7iZTV45A5ESG+7GiG1J0tb8vPA8NIbf89f7/hxxlaHD3?=
 =?us-ascii?Q?Dv17KJ/NuUJBJwMhqQ8Lzfj+siL/7uvVtISCHCNV1NdekR8Krwv3Km3CYyOu?=
 =?us-ascii?Q?uYJ3TXTWG+WhBp++bzdL3kw0H/9kugoDIVOu8m/MnCfel0/7SqHJn0ywvJVe?=
 =?us-ascii?Q?zj0vJ8NwIxMob/SwwbvbTNXowPifuaYLi7/4yxepGrhAdGTwtqzBe+bd91zv?=
 =?us-ascii?Q?/BG8JsZDAsTsQqpOJogofANJg7DUWnUr7JEdesUfQOD/uYsYpiPUIX7g2C3v?=
 =?us-ascii?Q?ml8AuYRs45eQwMLouUP3imnsL0DApvqDoLOoCZEkZ2Ng6OERO7PY3uF2TZRp?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YZFDVB5TbHd8EyMLSOAqPIvAy7tDWsGsC2P0HKK2yKRFZ7knSOKvUYr1+VWt?=
 =?us-ascii?Q?G34L1mhcrIUpI8iWrWN9t2BBvNtBEnS9PKT+7sR+wiznfdNWvCzIE7cS0Jw2?=
 =?us-ascii?Q?v5OxUIwSjMz9+k5hBlvqXqTktau72pIKdCmIJWkbpFZe2iyf8VI5oTNj6Bq6?=
 =?us-ascii?Q?6yvatL9F31oYGGU9mf/+gRSwQBPts3A9N+YFBPRMSWCFfMa5ig4Nmx0231Vi?=
 =?us-ascii?Q?4t2BBAsKx3fXLW5DXoyUnS5Koyqw0stfB1ulaKppRUTmi5TSve6Mry/ZBFIf?=
 =?us-ascii?Q?mfpCU/4q47oq5n5lCDuujgbSOspvPzK6Bm3JNSzZmtmpznrpueZw8Y7EzjRo?=
 =?us-ascii?Q?ODryP34W8ZlAx04g98p8iTJ2edtp5YN55zN+HqpUy61XbqHFOLwX1uLdu17U?=
 =?us-ascii?Q?rlyXJZ0fctrNInKkYb1zXcmfQlj+XSrJFwkHGVeTMrwQki1v6lUAxPjgLKSy?=
 =?us-ascii?Q?3Xr2lvbPpRJNuf/QDShCWLCRxKmFAfeGj9unPTmkrQOB7kj1hhaW1DqaTFAA?=
 =?us-ascii?Q?upYTTRLmv/WlTnvrYj+IcflvjcLS7AMHhXd+j8Lq4LerjY04iAxVPonp2cRw?=
 =?us-ascii?Q?RTz9HIbM+nCiU7rCjJTULQCawjNGZRhEfdGFZR4US/OwfbOY81ERvu+yEXz4?=
 =?us-ascii?Q?DDnBLYrgQmBKgcbg5YfesDC8EKS3hF5zFHVUddFwjcp7lJp0NFGuZodl5O4K?=
 =?us-ascii?Q?KfDfUUWcTBV9BXydECK9US+WJOsFLuAlm4uDI58hN+9hh985LjLfpc0qMfX+?=
 =?us-ascii?Q?AJbGA1ZZ8N6IIkCYKe722IU/2N2c/npHAH/Xhvkl6h2mgNxvp0oe1Y5xXXjO?=
 =?us-ascii?Q?P77I+hwW7G9WTj0hX2CwRyDdj7j/ml8VhzgbtYiJQFUofo5E+6NdLyH+am/A?=
 =?us-ascii?Q?yc7jM3gT8gtPV/oFbaRq9GqWVIc9G/fBUK890J8t6rXijvZiEDtxxZoa1Mn7?=
 =?us-ascii?Q?T0+o4/rzG88189TFiPgObpuOSi450TEeeaokK6N3pAPv9RxviYetQqO4uRdE?=
 =?us-ascii?Q?mXtH9vXxiY/UZuxAps10cYlOFZLLfbm3+BQXohUOxgtHtK0/gau0v2oKHpN6?=
 =?us-ascii?Q?zrKU0hdJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3cf123-7a92-4fee-95a8-08db5bb28687
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:24:12.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYVyvMNvSEwPZAfG6mpoDh4r7Dh3k+C/YjeTSaJvdJXOiICkvf7dN2BmgC0MT22aiuUCzYym9PPxqj6GPD9qrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=849 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230139
X-Proofpoint-GUID: M7t5Qc6lOAb44ohKdEea-JcsiIPJ48i6
X-Proofpoint-ORIG-GUID: M7t5Qc6lOAb44ohKdEea-JcsiIPJ48i6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Uladzislau Rezki (Sony) <urezki@gmail.com> [230522 07:09]:
> This patch renames the adjust_va_to_fit_type() function
> to a shorter variant and more expressive. A new name is
> va_clip().
> 
> There is no a functional change as a result of this patch.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 409285b68a67..5f900efec6a9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1383,9 +1383,9 @@ classify_va_fit_type(struct vmap_area *va,
>  }
>  
>  static __always_inline int
> -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> -		      struct vmap_area *va, unsigned long nva_start_addr,
> -		      unsigned long size)
> +va_clip(struct rb_root *root, struct list_head *head,
> +	struct vmap_area *va, unsigned long nva_start_addr,
> +	unsigned long size)
>  {
>  	struct vmap_area *lva = NULL;
>  	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
> @@ -1501,7 +1501,7 @@ va_alloc(struct vmap_area *va,
>  		return vend;
>  
>  	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> +	ret = va_clip(root, head, va, nva_start_addr, size);
>  	if (WARN_ON_ONCE(ret))

ret is only used in this WARN_ON_ONCE() check (from patch 1), since you
have shortened adjust_va_to_fit_type(), you can probably drop the ret
variable all together here?

>  		return vend;
>  
> @@ -3979,9 +3979,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
>  
> -		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> -					    &free_vmap_area_list,
> -					    va, start, size);
> +		ret = va_clip(&free_vmap_area_root,
> +			&free_vmap_area_list, va, start, size);
>  		if (WARN_ON_ONCE(unlikely(ret)))
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
> -- 
> 2.30.2
> 
