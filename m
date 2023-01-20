Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406E6761B0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjATXlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjATXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:41:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA801E9C7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:41:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJwlmH023240;
        Fri, 20 Jan 2023 23:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QlD+NhTWwDxpoO1rDVQG4Q+ZXo3TC+6ciC8a+FGg47w=;
 b=kpBGLaWk3ZHh+CnCvVlCpR7X4lFwLnrne+zAgxW3D/GG6IHXr2nHsrk72741sl8krea1
 y6N8aupYZXap2GOIJp12KLZijOrfSqCHH1I+P9bSNptEzfBchgzyJLZvzh3tHMgFIhAg
 Lx2txiyB8Trjvv8W5NUONpGulS0JUJGA4BlWCnb/02JRe5bL+Ai/6SRs5jLMyIfWYnq+
 lpCFP7TXfjJ1vNMQWM/a2Nc3IbUoTTnQv358lzZdBx9M+0KH1H1zBwI352TJZjR/vZ4v
 9Ddv55phZgR6PomZb/jG6pqt9lBo4reGN/GVQWwXiY2xCGMDROxje0zZ5qt4NwW4yxi5 Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medp2k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:40:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KMZU9m027926;
        Fri, 20 Jan 2023 23:40:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qudqgb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Qz/LhuzmJNyAnfWmx8+WKnhm93rI3R64reab7x59tMahx5Fb408G4c5o3TLsP1Btl3V1swCb/qlMaN7NID0Mf12NwUEUVDq27yyRh/jTx8K5P5ACOO5dzU5d44IppuAKiZ0oLsJsePiOP/agwnvmrFhlqEPxUq4lOqTnLo/wKbjVHuW3bb6XXTqVwyhu7SCLw4rFE0ZDoo9f4CjYjHCmUdTtdF5LOn2YU0psJ1ZAuRknq7wkhX8XDiRAwsG3M+kadCWdhyQ4/De3AOSH/w3WRr+G2pI78R7SnyZNo5GKx0voUqo+HY8gFual+ZreGBVcrOXNzJ3vboPbqHifS9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlD+NhTWwDxpoO1rDVQG4Q+ZXo3TC+6ciC8a+FGg47w=;
 b=EMmJNCqm6HQMB1GgzlU7wBu8Wyoh4VKR8INeUBgGe7snOGQIqKEj0YIiaLDR6Y1uOHKU8Yuhr8j1mhK9vy4CWbelcnhIv/f5jAnMf3P1u1GXAam6DuW04IeduDY0Gkr6VLr5z2zmnT1Jj5/1zuXADxaryweUUxrUr/wZUZp70pN8AIctR7AKMiEl+hYyfUISLaek0dVQfxlNQPpYgYv73zIoKAKzHd6SvGVnypWkqH40AqMTwMrTaVg8JuDiU4dpV1dPcLCdb3pVi5aaJvOQD/pyVRnF8nbYDC+yTrp42MNG6hbI2oxTSYjBXASk6jgAkmi/x/GRxHV3MgdmwKLkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlD+NhTWwDxpoO1rDVQG4Q+ZXo3TC+6ciC8a+FGg47w=;
 b=olDxB/3VP3zNnSRY9boSRhHbknn0dJUvUnTvysJsjhcT84ATOuHdev+EQmvTorhHGENsjFbFikTVAXe1XA2zPacN+rJx8NMve5UB1S22rOqMbQjdo//sX8yTP5jMzmPsr4cTmoyvr6VaHOWgWINSvWnr/na6po+2olzp5PhSdwM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 23:40:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 23:40:38 +0000
Date:   Fri, 20 Jan 2023 15:40:34 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH 2/9] mm/hugetlb: convert hugetlbfs_pagecache_present() to
 folios
Message-ID: <Y8smcgsffpX3X/bd@monkey>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-3-sidhartha.kumar@oracle.com>
 <Y8oqEOICcNV762IA@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8oqEOICcNV762IA@casper.infradead.org>
X-ClientProxiedBy: MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4ee71a-a2b1-473d-cd12-08dafb3fbbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WFTnahrqEUX+o1QBmIa6EFgqmCke/LQEytmwcJGF7MJrodofZJo+sAUHTLqbF30ikyN7w1CPMpao/qpj0YH76DqTtg8NgiONnIrC99eHA9jIxYOdJXzZ98GQfISoUNPMhl7N9EtWnPOXWHh5IXs3qYpgjEst/LcSnYCklSmUcD+IsZxdvUJLpbWVs+ExQV3xsBpBsKXjpAWyuTAaa84zNhsbETlAx0TfXSNa+BpC89vmbc2nDQ0KP7ob/fKxnROp+NM7z80737KWQdVmFaT8OovIA+hwI21Q3STlynE0qnCsYb4P3wnYgQg5d2nZKdCPUqjXkcBIx4lcVTLNV+JNomMJ7w2qaGFO4lQDeDQ8O5Ya50qcHnwFsV2i6NDsRnb5amm+6z+Yj7GwBF2+gcSz4oUo41wDKjLUiAA7TKuYcMnWFxC2iEiwwtqfj4aSFUJitTe419L4V2g4S1R96WS3sajYPfVbrjBzw4FAhD/UDg0MFYiL6UhnsJJgTQY06DwiB/BAoHv7TQ/AQMFIP+llkIDqxcf54YG/DMXMDsD1YnKb0GKqnIRkqnwcN6LET7KYND5ur/mbd7YhG5ZGguteJgYFmh7++Nib4wBohMmms0zppy2vXZUdnYdp58SnKeCXMXH601uS3xztuVyZRmOtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(38100700002)(41300700001)(33716001)(44832011)(2906002)(8936002)(5660300002)(86362001)(83380400001)(66556008)(8676002)(66946007)(66476007)(6916009)(6666004)(186003)(478600001)(53546011)(4326008)(26005)(6506007)(6512007)(9686003)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZngRbWFjSufm1To0pLZn4e7z8f5i+DKNrtJQDCaDBc1PYDwJBzGP2o2o5xa?=
 =?us-ascii?Q?6mEEIsRU6tj5fBTA+6VsL2KfQjsVp55h7GoG/7J2Syh4OhvyuzjZf1Ohsh7L?=
 =?us-ascii?Q?U2YmDwLzlG8J8DKHzWKlW/gkx61bNh883Vm20colZr0a/RlWEwRDRCwXYk/c?=
 =?us-ascii?Q?3ZVoEd9s1J/SSCluxqEMnrA1KZXalFukqXGVsDhdpbesiTyKQMYxqqkO01tL?=
 =?us-ascii?Q?TIHc+0eKseTv9/b6RnqhcfFZu/LU7BijLLbQyHR3jcp0qFQ4h3CRmOW8pfhr?=
 =?us-ascii?Q?zP5SBwPCk9Z5MmjBCQzaD2V5ePlwvaU2d8TAha4NSPR8RphoeNdRBp2Km4D9?=
 =?us-ascii?Q?Dltf8GC5k14Zt+Drf2SOGMvzbDEBXbowP9jhDLn0/PAErEmqY2wkahTOmdCF?=
 =?us-ascii?Q?d5EhGBmDCETiZkEbJsc0RhFI6FchsSu+RTRB1nzv81yLucZ+Eb2yDAwOaRYU?=
 =?us-ascii?Q?jtd4JsqI8h11nduuz8JzbUu7z9/4Fb0L9P4z4xLbvjstDjf39j2xeRASCLQg?=
 =?us-ascii?Q?Ae7vPnHjK7jnDwkpeYvt9/gTZegoWl2/0aTAO4I5b1mE8FAFPhY9nLb0gvRT?=
 =?us-ascii?Q?DtiFLlu5PNO34gd9F0N5DagotEfkDinHZ9mHT7cr6xirwlsv3mlnLyOaPXjc?=
 =?us-ascii?Q?mswSQYhozk32ut4XJW+R74Pqv2WCovyEu9Z81JBNuImZCz48NxEYsNXxhTs8?=
 =?us-ascii?Q?c0skE/30VfBLMuF0uA1WwoUavAKDDNi90nMh4vqW/lhXUdCphA06Fh1yL8c+?=
 =?us-ascii?Q?TmFhiPYekgHhjSpGqN4qCQdiYUpf1twCjRTRxWRTK5wZ79H2EqAMKPOE2x+Y?=
 =?us-ascii?Q?D31thdpMCBLHMWaRqeKJuKZ3lWD5cyfyTL0EC8BXkCcfYnuYp89on8UQTNPc?=
 =?us-ascii?Q?InV4F7PZgSI16x5p/0zKchlc880lC7iBnGcC8AWdPNzwgOfWNpzddvhpoiij?=
 =?us-ascii?Q?833nQxhuRXGrFI6L9zquznPOUwm07ofTL0083dPXHjFBH4lqmsVWCN+rpRyw?=
 =?us-ascii?Q?1VX2KOt7AXTDuvsSY2rPRkjGT4JwVqrqY+9mxKEl4/UUXwK9lJutnmKxEcg1?=
 =?us-ascii?Q?8ePi1qj/XC3yge0v8bnW1JYLJnILrdcOndJ4sDbc91SWIdii0sL9imlAGSw0?=
 =?us-ascii?Q?kpAvPlnVE7vyK6pXJeknktH7eUrXyagYdLJykpd4mlmQN7WSoz9jheVk7hDe?=
 =?us-ascii?Q?1LxGzZ241PyRp17TgKSnZgTcETI7SH9IoctP5KE68j/jdCle4KmBm04yQ8Nt?=
 =?us-ascii?Q?MrrDI7k3/r0Pj38MCUuJVKJauFLyhw+/+SfxinMWgSl/z4/ySyN61jyPqM+f?=
 =?us-ascii?Q?d6HBVLZZjJlpicIySfwi02k1JCabePjxpqdS5WEtG0xCrHvekzHzJFAkjhww?=
 =?us-ascii?Q?VX+TKK5KoBKaGP3bg4plqlASNuzKDcCP7gU0SedWV8Q0SVlyJvaqyaeMOK/c?=
 =?us-ascii?Q?nuSdaUja6ZZzfRBowsaI/z1C9vkJhl1GhwXMnc4n5V7pthlQVQslvOfohnM/?=
 =?us-ascii?Q?DPOUk9z/4+duHsbolSgvU5/cki7WwqEVvgZLz/lGW5leL5SgMe/z0jeTKgre?=
 =?us-ascii?Q?dmGgNqXHXEaoXuIosvaOUBFm/RYWqvAhGWToaR3ABRxsdIZGLr17iF8rfoLy?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?q8WVkxB5O173LezKWITX8Pt5laNV2v5V+lnxEUO0ZFdBmfYCoHQHpdWhPIub?=
 =?us-ascii?Q?4ef7u1VX7Fxe+HUviTZ0mAia9GObU9/7NZcAzNsnGEzch3RHtB6KOY1fFBxL?=
 =?us-ascii?Q?KWcbgbq5u4rP4PNjwIdTi7r0Kr7nQjHdPYAPHZfGB9fioB+ZArorS395vrTH?=
 =?us-ascii?Q?snqEW2AffuRHfR8a96EhyMawzuVLCkGHUjgWp+8DXcRTjvjoKyElCjaYyvPv?=
 =?us-ascii?Q?pbOKCNg8u86Zv7+1qhL37faC0ZacDfQbAgUEbggSdRdyfagg95FA4kB/Hvp6?=
 =?us-ascii?Q?laO49lmPFuC+rhKLKyWYEqu08kQq4jhbJNjbBHCtVJ45XP+LSHsjVm+aar/8?=
 =?us-ascii?Q?hSttb1covtNFLgDenn8yVE9vXaNB76vtGmzlmmP6AvDc58MSWRIlr1IkjF1b?=
 =?us-ascii?Q?rxaxP2Nz1jVn922FOQX1TxOmVBfvNAYYkl9BFlVtj3LRwR1CU2MDoEfcMOyn?=
 =?us-ascii?Q?29S4pwGKxylqQQHzZDOTBl8sfLM6l2gNLJyvB7TUFHiemSk9ORnN3feF25cD?=
 =?us-ascii?Q?V73bnYAH5YXHRMS6A+6cuTox2ybjUO/dmWZt9bh/wlRl+QJ5ebn5ExXKTj+J?=
 =?us-ascii?Q?E0KV8XT2Z36C6iRZclCfM0N+HFUS1hJK1mmce6RGbjNF99kyV4zkty1TGfKG?=
 =?us-ascii?Q?VqQsMRc0M7T419yOntXhJsplc8UGF7qJdy4EhIdNb3G3QbE5pcCbVLRGBzyG?=
 =?us-ascii?Q?wAqEGEiRPmW07bYEkfEP9XxzK36e5ZDXhwjlKiNJHoUw3irCFukXu+0EfQIY?=
 =?us-ascii?Q?wUxKq2YXTS3VVgWlC0f8/V3Y3bhbPsPUP9MdmeU+T3a5QxUG5ErEUw/SIZao?=
 =?us-ascii?Q?syFB/FkZWLgyImPau7V0kpIF0Pjx5n+H0ie6Rue/xdi37cnpqdzNBTWwREaU?=
 =?us-ascii?Q?q3UBu587mIlSSoNhSw6HaM98Ko/5PpHwPWLQ8Wjsv4yv94b1ZTjb93baOBE5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4ee71a-a2b1-473d-cd12-08dafb3fbbd4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 23:40:38.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nApDzdp/krHSueITevdlOhVXRCd1VTmTKOY6ge58G5x4MvnrC/DwH+ODBJRJ59+iL74KqMw38Gh+JDp2N4di9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_12,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200227
X-Proofpoint-ORIG-GUID: aEUeMAnqg4pdHOaaGpL4MTocoOIaULai
X-Proofpoint-GUID: aEUeMAnqg4pdHOaaGpL4MTocoOIaULai
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20/23 05:43, Matthew Wilcox wrote:
> On Thu, Jan 19, 2023 at 01:14:39PM -0800, Sidhartha Kumar wrote:
> > +++ b/mm/hugetlb.c
> > @@ -5653,15 +5653,15 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
> >  {
> >  	struct address_space *mapping;
> >  	pgoff_t idx;
> > -	struct page *page;
> > +	struct folio *folio;
> >  
> >  	mapping = vma->vm_file->f_mapping;
> >  	idx = vma_hugecache_offset(h, vma, address);
> >  
> > -	page = find_get_page(mapping, idx);
> > -	if (page)
> > -		put_page(page);
> > -	return page != NULL;
> > +	folio = filemap_get_folio(mapping, idx);
> > +	if (folio)
> > +		folio_put(folio);
> > +	return folio != NULL;
> >  }
> 
> Seems to me this function could be ...
> 
> 	struct address_space *mapping = vma->vm_file->f_mapping;
> 	pgoff_t index = vma_hugecache_offset(h, vma, address);
> 	bool present;
> 
> 	rcu_read_lock();
> 	present = page_cache_next_miss(mapping, index, 1) != index;
> 	rcu_read_unlock();
> 
> 	return present;
> 
> No need to get/drop a refcount on the folio.  It's a bit similar to
> filemap_range_has_page(), but the API is wrong.  Maybe there's room
> for a little refactoring here.

Thanks Matthew, I did not know those APIs were available.  Perhaps just
use page_cache_next_miss as suggested above for now.

FYI - There is the same pattern in hugetlbfs_fallocate()

		/* See if already present in mapping to avoid alloc/free */
		folio = filemap_get_folio(mapping, index);
		if (folio) {
			folio_put(folio);
			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
			hugetlb_drop_vma_policy(&pseudo_vma);
			continue;
		}

-- 
Mike Kravetz
