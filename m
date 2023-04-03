Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AEE6D4C51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDCPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjDCPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185130DB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:45:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333DJ1l5010464;
        Mon, 3 Apr 2023 15:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hKkSL0z5hjPV0Id6fpO+3iHm0/gpm0DSDmV8MSgoZoY=;
 b=jwBqmQOVdYHQZaRyglrbs8XbFDjV/EDe8w9Wp1E7dCfW3rNaXbp6KlRRbtqphkH+Qt5A
 ixylZvdFkNlru4WaddMyqkCxvNQ8f9I5Lx/mUXenJ6KxrkS6vNZJdpXEWjwB9epIo3dW
 /r627WWoodN6hPsDo9v9UyLiXv/F977woE2KohTWkoRGPNlOdRlhqM6PaX5krfeGRNNZ
 JFjQmtaqOnd4Wv5j8DbIn2VaQDYZHbvqJHMkdLDyLpVsz+W1WlIjTGOR0S81D12o5lPS
 LVQ/Ek7zdwHnug1vunccGuaWnZ0wJhB+f/vpF/9r6ZNXrvcmTI8m5EwU1cju0T4qaHmK MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tug66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 15:45:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333EYgc3028059;
        Mon, 3 Apr 2023 15:45:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptund28b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 15:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih8sC6Ryn6P3f1U7gWSErlxpWxuAzBydKEjTxzD9ZfXzE2NZd4+v7FHvhJiM71LTpACdj0NTsbpzLqlNp7F2NODEn2AXOXKwAp33T0SAn98995Ds0Mo+8dttJmL4HHDj7ugz1bxL8ziUieU3E1nnmY8TeokC6U74aN6Eg3ZQqcHg+oBOBpth/VnBvFxw0nkfCI3lenrhHzul/WGba/svTGLqObVLeVmGBTOt36QWDAfETNTq8mloN+hIqIhYA86kvQYAhsomkgoEDSzHVCC1rqAppTzZW3RC/qOSUTb4qbPEIiWh950a5WwS/S7LGGreWV4ibF8EjJKl9BJ7aHGJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKkSL0z5hjPV0Id6fpO+3iHm0/gpm0DSDmV8MSgoZoY=;
 b=Bt9Zd/f35Xto+EyDWZKcFTXm7tHYzcMj+PfDaTApE3GMV1pOSsYSTPDRnT8+cQ8cTatG5yKH3ZpXlF82vLT/LSu7UBbMc4HWtKO+PKWBWGsjnKllORORBgHRsx3w2IbseRY1qFYWGSxZBOxTpC+/PKr0mSGpdfSjuRiI+wAf2BVculnOhoWp0T5u+N2C9OjagFJKTan0c49oapU1pVV8dBTUO5hpwkxxhh8Aqq2Jt02dDGHuZLen7AFBOugfFT4FG05UyPXyvjepaCocSvjPd8mUT37IU9xs55NNJlq4/dNXtyhCNN3oTqYL7qarZZk9OcHxQPGSTAnyutDmBCguOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKkSL0z5hjPV0Id6fpO+3iHm0/gpm0DSDmV8MSgoZoY=;
 b=lY/UAsxgfQyYrqkdthv9lO8sqvm7mtYwdZgp+iFCMI2Y3G3chcntS5Px9qQO62gPxLQdci4zLkUo3LNnLZB/vNltHmfmVsHtMgbMUCXjK4lKT4kGtvpCXS/+M10IF/bxecUC9zPIENyF9MCV4Fq1wg2Se2ccpZTDXo2gcQ6y0X4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:45:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:45:11 +0000
Date:   Mon, 3 Apr 2023 11:45:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regmap: Add maple tree based register cache
Message-ID: <20230403154508.qia42tyasj4vhtm5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
 <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a623fe2-ce22-4042-024c-08db345a68b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsX+hxLhqrO97Ug0MfpGX8g6tNfBsHkSVFJKbEXxhkJB+cnR8dnx7aHvPwbZtgVcyDmjM4ei/KD4J79/0Ol6ZW5BKM5YH/F0gIFZzKuYv0b5fIjL7Tank0+6BsWUXkQB17mwcyCntE1O3qvmh2G2Hh07TLnE6kHuQUNlmtcOKJ8h0LH7xLdCwsFRoIQzk7U+Ivh1bz/ZlFlE3DmpHTWyPNoWF0+Y5CKs/WqgNmpyt6ZQKHrfDDgx0JNk0ODx6fBeXx3t7Xqi8c5Swm1Rwb2aZxgVst46YTByV/ke35vgXQU0YLUxKEijCle5FMlOWq1yBPEfN28CO9wKPY1aI0hS1r97RyalIKulHdEcFlvZiQ+GtLAqztc5+urJWRu3MXi/3jScC4Hg268AX9mTSXB57nG6xfjE+ldWZb7L5LmU7QzGEmPWrtLZGTyy+cNk2NAyXfMrZT3C9rHLBSSaJjK15DGp49NAk3xLKHcJUppkzzCITVt5wRCGRID4E4m4ll+iujMkYJiQbsO4Z2c4K7OmTfD4eefFD5CTIc0btd8+o+PK0DNky20bT/uqAZFLApJ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(30864003)(5660300002)(83380400001)(316002)(6486002)(33716001)(478600001)(186003)(86362001)(6666004)(9686003)(6512007)(6506007)(26005)(1076003)(41300700001)(4326008)(6916009)(8676002)(66946007)(66556008)(66476007)(8936002)(66899021)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ee/Vv4gteKQROc1WDokaTGGGR2q8W+zzvYs7Jo1EIIoqT6cN/XZ5LiSKLF01?=
 =?us-ascii?Q?GfLnHTQD589F5SD/wqCtmEuogFr27TEEMkUs/UISjXCYUCVpqheU3P01SUDH?=
 =?us-ascii?Q?QnKr3Aq/wjx4UICm9pZGo6U8WwqU5ZthiBoVzPGbbg5RFkqD/iN2JkED8w8k?=
 =?us-ascii?Q?LHpDf3mYaepRpSzqWDQbfxt3sWQpastR8vKIr5Nh9kRhs0FR62s5Qs9ZxrT0?=
 =?us-ascii?Q?dyAUQd2iMTRo8z9g/FcBz74DPv3xubuhoWPSyul7fBA4nxVmcewQbJMsIRYk?=
 =?us-ascii?Q?XcTNhMbeAN7+kdqAT3pmqdEmVdGJ1jD22Y9qRw9akXm2QQcTBchG8G5DuDfX?=
 =?us-ascii?Q?GmwffVjYSySX5kBk+FtAMjPIIBE3MSHsCMhcXZFAGuhnuptxZYKvseaqFR5S?=
 =?us-ascii?Q?m/Hs3GEyYeS0qhP066kj+jS4YlvGVnPlUJxnCGC4wJP1uRG4Jie/H+kOvhfP?=
 =?us-ascii?Q?U7jHpRah05syeFGnSXQQo/b3NF8YQFbKbZYXPoTEpjRlgEsxc1KabJWbll3Y?=
 =?us-ascii?Q?9bbPrqkfVu1UgzkyFtloGHYGjb8WT8e9dcHVEVazvusdpiDC4LMYpq/WrhuE?=
 =?us-ascii?Q?3vEeMRilJ3EsduiE+TJodRouxQjHalpcIVOKmZrTGmj6tzfWNyf7QLK1dFHx?=
 =?us-ascii?Q?wtMSdAbzLQ0EkgXoDaUXgkRq23FGK03xueM9Y0BYo2EOpDkq57SDLfWKBa/6?=
 =?us-ascii?Q?QlFIIK+WIeAq7vDLANNEN5Oc9K537FQeTrns/5IILR+4pr9CHho7klIcahcD?=
 =?us-ascii?Q?ladVG0ZbZZO0nWxVyhkmcoLTpuXHhsSl/snbno8cFheAIL6oWQhgra7Lgt2C?=
 =?us-ascii?Q?i179WfOUXvp/kAEY7PxAujvVOj6UXay+u9JxHqorfeTBOUaS83IyowY25mN1?=
 =?us-ascii?Q?p4cSWi5SdY1JzN1BbhyZFZGDE4UPIjtJmbki4ra+yaWW27mLrPs85jUf07UN?=
 =?us-ascii?Q?Ivj0KrCZ6LsJQM4aI8V93aRZc29XDuKIroliDFmGPHdAGztyXm75j2hnTmra?=
 =?us-ascii?Q?fb+ih1n+nQE5SNMveMbh77LmFra9mEvtbriC7pQS+BYcKDFXw1JRSVVVSsIX?=
 =?us-ascii?Q?5aaNuwTzUaw1Btgizk6PkHUNumyVYc4RYyBjg0x7fYkb0JurYCtT1gmfNo6a?=
 =?us-ascii?Q?pryjw7PN0Ct0KPj0/pkhu0RAcsnDegDlVuBlmUReri3sc3MuCdlZrktA8dR0?=
 =?us-ascii?Q?Rp68gv+U8KYf8TIhhNeruJbVuj3oDMUH4Qp+7x/wWo+19U1gP5vGqtlDiZVR?=
 =?us-ascii?Q?N2J7ZODugku7NCSmiekSytNG/sfUSE92VKtrKMhCGExDeD0LBJWp17TSJnlJ?=
 =?us-ascii?Q?W5Pb5KI4EtRwGdYglnNbWX0G8yuC+flOLPN4uQAisGMl1axDbvg24Q/yxeYF?=
 =?us-ascii?Q?3nzMeQJUYFaPT8juqnEnzskq3fvTRz80Mw/c5aN44zxDOwj77oP6dSs8iMtG?=
 =?us-ascii?Q?BvCVqK7fiYBS1/f/tJEBbHPsde3I5E1mA1DrQJZpqcgNjaHZwMVT/rlo0NZb?=
 =?us-ascii?Q?3V452rSrF9EPxkUZE5rUyEuaE+Uo3I5wL5dK58yOKvfscW7gpKXxG5Y5boay?=
 =?us-ascii?Q?lWYfCPfeHZ7gNJT4qC9+NlvmQpCQrTSvlA3m5d/YGshYZMRBLqCYhceFKzio?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HCgMarLtl8nhvyBag8Az6DjiEIvhdGue2Kc8ySqpMqlQNqRqRHG5xUXVPKOwr9RIglDvMfaX9fHs1y9R4eo5RPAUSsAGBj225y5nIChtLh+dAhDhEtPJfb6pL5P8+J7HDn89aj2ds+PIDUoFW/6mn21/Hvw3Wxt2rHkdWonvsEDhuLepvxTXsJy6CPBWlpXMiXK/eXXZXDNPQrE6Jjxb4r+1OcZwofdesPsCAhQumHyec9+ectfjtFpaK55ECUWLeOvEkw6opLV26pEyvN6GJOHssEFHCVPzTbhKC7XJB9A6lsLAj2Dn6zIO3nCtubQwq9DM+edd4OBMWL9mJ1fcBjRCzKOk9In8Ncp24bDIJJjJgdD7IE1P74spO9ajICdzClDJmnFohZLpG/HFM+U5jTfu2saMOTopdQuu6zVfRviQ8l7JQmGCI/GOy0I644qNbXb7t2nJSIdxptgDL67tph8ihZS4BuzGKmcJHudeBdmPtnaCJDN4lSbbOxS8lRVJHl/2O+4piw2zZL+DjmSAPMOOkAAmjl0Z3A4V6brmh0B1ru6CBX76YIbHiql91JGdxKyfaIN4lgcZSe7mxWt3YA7zrLsO5TxWQxgtPnsaRcys+nXDfe43wvGxsfzB4tvWDlOf4n60tWfQigw30XX+Akh71dHAxJ9dwHlNg7XX4NS0J3kPTxhJRK79v69QMkERMJp4iwBLAnG0FBiB02il3zXjACSWkU8EQ3gCYovo83/xA4NssySPZJe8J+o7nSSeVW0Pd+6J9Cof5rlDM9cdjlYHrY5LYTrB7Kjyp9mMt5yUYB9ez2Usq3bQn+B0gH8v
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a623fe2-ce22-4042-024c-08db345a68b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:45:11.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlJtUfYtesSYBIz4dqFXs5z3Zk49iUqCz/DpRUhEW7eczKrEz6XzN4XpCiCBRqpGU//yjUE6C/zl6+1B5F0F5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_13,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030115
X-Proofpoint-ORIG-GUID: hPLacdezgn7UK_ugdE_8x6Ba20tJjc-J
X-Proofpoint-GUID: hPLacdezgn7UK_ugdE_8x6Ba20tJjc-J
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [230329 20:10]:
> The current state of the art for sparse register maps is the
> rbtree cache.  This works well for most applications but isn't
> always ideal for sparser register maps since the rbtree can get
> deep, requiring a lot of walking.  Fortunately the kernel has a
> data structure intended to address this very problem, the maple
> tree.  Provide an initial implementation of a register cache
> based on the maple tree to start taking advantage of it.
> 
> The entries stored in the maple tree are arrays of register
> values, with the maple tree keys holding the register addresses.

Why not store the registers to values in the maple tree without the
array?  From reading the below code, the maple tree will hold a ranges
(based on registers) pointing to an array which will store the value at
the register offset.  Could we just store the value in the maple tree
directly?

this:
	mt -> value
Instead of:
	mt -> array -> value


> We store data in host native format rather than device native
> format as we do for rbtree, this will be a benefit for devices
> where we don't marshal data within regmap and simplifies the code
> but will result in additional CPU overhead when syncing the cache
> on devices where we do marshal data in regmap.
> 
> This should work well for a lot of devices, though there's some
> additional areas that could be looked at such as caching the
> last accessed entry like we do for rbtree and trying to minimise
> the maple tree level locking.

In the case of the VMAs, we had a vmacache, which was removed when the
maple tree was added since it wasn't providing any benefit.  We lost any
speed increase to cache misses and updating the cache.  I don't know
your usecase or if it would result in the same outcome here, but I
thought I'd share what happened in the VMA space.

> We should also use bulk writes
> rather than single register writes when resyncing the cache where
> possible, even if we don't store in device native format.
> 
> Very small register maps may continue to to better with rbtree
> longer term.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/base/regmap/Makefile         |   2 +-
>  drivers/base/regmap/internal.h       |   1 +
>  drivers/base/regmap/regcache-maple.c | 278 +++++++++++++++++++++++++++++++++++
>  drivers/base/regmap/regcache.c       |   1 +
>  drivers/base/regmap/regmap-kunit.c   |   3 +
>  include/linux/regmap.h               |   1 +
>  6 files changed, 285 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
> index 4cb73468a197..f6c6cb017200 100644
> --- a/drivers/base/regmap/Makefile
> +++ b/drivers/base/regmap/Makefile
> @@ -3,7 +3,7 @@
>  CFLAGS_regmap.o := -I$(src)
>  
>  obj-$(CONFIG_REGMAP) += regmap.o regcache.o
> -obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o
> +obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o regcache-maple.o
>  obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
>  obj-$(CONFIG_REGMAP_KUNIT) += regmap-kunit.o
>  obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index 7b9ef43bcea6..6361df6f553a 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -282,6 +282,7 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
>  					 const struct regmap_config *config);
>  
>  extern struct regcache_ops regcache_rbtree_ops;
> +extern struct regcache_ops regcache_maple_ops;
>  extern struct regcache_ops regcache_flat_ops;
>  
>  static inline const char *regmap_name(const struct regmap *map)
> diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
> new file mode 100644
> index 000000000000..497cc708d277
> --- /dev/null
> +++ b/drivers/base/regmap/regcache-maple.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Register cache access API - maple tree based cache
> +//
> +// Copyright 2023 Arm, Ltd
> +//
> +// Author: Mark Brown <broonie@kernel.org>
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/maple_tree.h>
> +#include <linux/slab.h>
> +
> +#include "internal.h"
> +
> +static int regcache_maple_read(struct regmap *map,
> +			       unsigned int reg, unsigned int *value)
> +{
> +	struct maple_tree *mt = map->cache;
> +	MA_STATE(mas, mt, reg, reg);
> +	unsigned long *entry;
> +
> +	rcu_read_lock();
> +
> +	entry = mas_find(&mas, reg);

mas_walk() might be a better interface for this.

> +	if (!entry) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	*value = entry[reg - mas.index];
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int regcache_maple_write(struct regmap *map, unsigned int reg,
> +				unsigned int val)
> +{
> +	struct maple_tree *mt = map->cache;
> +	MA_STATE(mas, mt, reg, reg);
> +	unsigned long *entry, *upper, *lower;
> +	unsigned long index, last;
> +	size_t lower_sz, upper_sz;
> +	int ret;
> +
> +	rcu_read_lock();
> +
> +	entry = mas_find(&mas, reg);

I think you want mas_walk(&mas) here as well?

> +	if (entry) {
> +		entry[reg - mas.index] = val;
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	/* Any adjacent entries to extend/merge? */
> +	mas_set_range(&mas, reg - 1, reg + 1);
> +	index = reg;
> +	last = reg;
> +
> +	lower = mas_find(&mas, reg - 1);

If you just want to check the previous, you can use:
mas_prev(&mas, reg - 1);
This will try the previous entry without rewalking from the top of the
tree and you don't need to mas_set_range() call.

> +	if (lower) {
> +		index = mas.index;
> +		lower_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
> +	}
> +
> +	upper = mas_find(&mas, reg + 1);

mas_next(&mas, reg + 1) might also be better here.

> +	if (upper) {
> +		last = mas.last;
> +		upper_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	entry = kmalloc((last - index + 1) * sizeof(unsigned long),
> +			GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	if (lower)
> +		memcpy(entry, lower, lower_sz);
> +	entry[reg - index] = val;
> +	if (upper)
> +		memcpy(&entry[reg - index + 1], upper, upper_sz);
> +
> +	/*
> +	 * This is safe because the regmap lock means the Maple lock
> +	 * is redundant, but we need to take it due to lockdep asserts
> +	 * in the maple tree code.
> +	 */
> +	mas_lock(&mas);
> +
> +	mas_set_range(&mas, index, last);
> +	ret = mas_store_gfp(&mas, entry, GFP_KERNEL);

You can avoid this walk as well by changing the order of the code
before:

mas_walk(&mas, reg);
if entry... return
mas_next(&mas, reg + 1);
...
mas_prev(&mas, reg - 1);
...

This should now be pointing at the location mas_store_gfp() expects:
mas.last = last;
ret = mas_store_gfp()

> +
> +	mas_unlock(&mas);
> +
> +	if (ret == 0) {
> +		kfree(lower);
> +		kfree(upper);
> +	}
> +	
> +	return ret;
> +}
> +
> +static int regcache_maple_drop(struct regmap *map, unsigned int min,
> +			       unsigned int max)
> +{
> +	struct maple_tree *mt = map->cache;
> +	MA_STATE(mas, mt, min, max);
> +	unsigned long *entry, *lower, *upper;
> +	unsigned long lower_index, lower_last;
> +	unsigned long upper_index, upper_last;
> +	int ret;
> +
> +	lower = NULL;
> +	upper = NULL;
> +
> +	mas_lock(&mas);
> +
> +	mas_for_each(&mas, entry, max) {
> +		/*
> +		 * This is safe because the regmap lock means the
> +		 * Maple lock is redundant, but we need to take it due
> +		 * to lockdep asserts in the maple tree code.
> +		 */
> +		mas_unlock(&mas);
> +
> +		/* Do we need to save any of this entry? */
> +		if (mas.index < min) {
> +			lower_index = mas.index;
> +			lower_last = min -1;
> +
> +			lower = kmemdup(entry, ((min - mas.index) *
> +						sizeof(unsigned long)),
> +					GFP_KERNEL);
> +			if (!lower) {
> +				ret = -ENOMEM;
> +				goto out;

With the above unlock, you will call mas_unlock() twice here.

> +			}
> +		}
> +
> +		if (mas.last > max) {
> +			upper_index = max + 1;
> +			upper_last = mas.last;
> +
> +			upper = kmemdup(&entry[max + 1],
> +					((mas.last - max) *
> +					 sizeof(unsigned long)),
> +					GFP_KERNEL);
> +			if (!upper) {
> +				ret = -ENOMEM;
> +				goto out;

Again, the double unlock here.

> +			}
> +		}
> +
> +		kfree(entry);
> +		mas_lock(&mas);
> +		mas_erase(&mas);
> +
> +		/* Insert new nodes with the saved data */
> +		if (lower) {
> +			mas_set_range(&mas, lower_index, lower_last);
> +			ret = mas_store_gfp(&mas, lower, GFP_KERNEL);
> +			if (ret != 0)
> +				goto out;
> +			lower = NULL;
> +		}
> +
> +		if (upper) {
> +			mas_set_range(&mas, upper_index, upper_last);
> +			ret = mas_store_gfp(&mas, upper, GFP_KERNEL);
> +			if (ret != 0)
> +				goto out;
> +			upper = NULL;
> +		}
> +	}
> +
> +out:
> +	mas_unlock(&mas);
> +	kfree(lower);
> +	kfree(upper);
> +
> +	return ret;
> +}
> +
> +static int regcache_maple_sync(struct regmap *map, unsigned int min,
> +			       unsigned int max)
> +{
> +	struct maple_tree *mt = map->cache;
> +	unsigned long *entry;
> +	MA_STATE(mas, mt, min, max);
> +	unsigned long lmin = min;
> +	unsigned long lmax = max;
> +	unsigned int r;
> +	int ret;
> +
> +	map->cache_bypass = true;
> +
> +	rcu_read_lock();
> +
> +	mas_for_each(&mas, entry, max) {
> +		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
> +			ret = regcache_sync_val(map, r, entry[r - mas.index]);
> +			if (ret != 0)
> +				goto out;
> +		}
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +
> +	map->cache_bypass = false;
> +
> +	return ret;
> +}
> +
> +static int regcache_maple_exit(struct regmap *map)
> +{
> +	struct maple_tree *mt = map->cache;
> +	MA_STATE(mas, mt, 0, UINT_MAX);
> +	unsigned int *entry;;
> +
> +	/* if we've already been called then just return */
> +	if (!mt)
> +		return 0;
> +
> +	mas_lock(&mas);
> +	mas_for_each(&mas, entry, UINT_MAX)
> +		kfree(entry);
> +	__mt_destroy(mt);
> +	mas_unlock(&mas);
> +
> +	kfree(mt);
> +	map->cache = NULL;
> +
> +	return 0;
> +}
> +
> +static int regcache_maple_init(struct regmap *map)
> +{
> +	struct maple_tree *mt;
> +	int i;
> +	int ret;
> +
> +	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
> +	if (!mt)
> +		return -ENOMEM;
> +	map->cache = mt;
> +
> +	mt_init(mt);
> +
> +	for (i = 0; i < map->num_reg_defaults; i++) {
> +		ret = regcache_maple_write(map,
> +					   map->reg_defaults[i].reg,
> +					   map->reg_defaults[i].def);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	regcache_maple_exit(map);
> +	return ret;
> +}
> +
> +struct regcache_ops regcache_maple_ops = {
> +	.type = REGCACHE_MAPLE,
> +	.name = "maple",
> +	.init = regcache_maple_init,
> +	.exit = regcache_maple_exit,
> +	.read = regcache_maple_read,
> +	.write = regcache_maple_write,
> +	.drop = regcache_maple_drop,
> +	.sync = regcache_maple_sync,
> +};
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index e5d6b535c002..0b47721089e6 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -17,6 +17,7 @@
>  
>  static const struct regcache_ops *cache_types[] = {
>  	&regcache_rbtree_ops,
> +	&regcache_maple_ops,
>  	&regcache_flat_ops,
>  };
>  
> diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
> index 6f2bfa4650fe..3486bf9e28b8 100644
> --- a/drivers/base/regmap/regmap-kunit.c
> +++ b/drivers/base/regmap/regmap-kunit.c
> @@ -29,6 +29,7 @@ static const struct regcache_types regcache_types_list[] = {
>  	{ REGCACHE_NONE, "none" },
>  	{ REGCACHE_FLAT, "flat" },
>  	{ REGCACHE_RBTREE, "rbtree" },
> +	{ REGCACHE_MAPLE, "maple" },
>  };
>  
>  KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
> @@ -36,12 +37,14 @@ KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
>  static const struct regcache_types real_cache_types_list[] = {
>  	{ REGCACHE_FLAT, "flat" },
>  	{ REGCACHE_RBTREE, "rbtree" },
> +	{ REGCACHE_MAPLE, "maple" },
>  };
>  
>  KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, case_to_desc);
>  
>  static const struct regcache_types sparse_cache_types_list[] = {
>  	{ REGCACHE_RBTREE, "rbtree" },
> +	{ REGCACHE_MAPLE, "maple" },
>  };
>  
>  KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, case_to_desc);
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 24fc4a9ed1f9..11b360da199d 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -51,6 +51,7 @@ enum regcache_type {
>  	REGCACHE_NONE,
>  	REGCACHE_RBTREE,
>  	REGCACHE_FLAT,
> +	REGCACHE_MAPLE,
>  };
>  
>  /**
> 
> -- 
> 2.34.1
> 
> 
