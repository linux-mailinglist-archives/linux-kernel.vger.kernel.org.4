Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73570CCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjEVVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjEVVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:40:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58967DB;
        Mon, 22 May 2023 14:40:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNsKZ001969;
        Mon, 22 May 2023 21:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qK9bKPyPnjMEvXhZVJhQyW/Bo5HHdHxPVVv069VYr9w=;
 b=u2lM24WQWixS6FuPHlE3UzVUU7VgdzV1z1RvuKKAIi2T+uwswa2G6rHtnasTvE/TZoIm
 CSprGTVgCa1Q+9v7O4hQ8/Gee8gbHDfZqnONWq8eT5ZUo6VMiMQq0ks6b1b3MGk/Fqfn
 D/RwbrmIGLZ9/FSs8kOkw/rKV2i/oeWPMGvxwmbfMxOCoMROYsC7xWR+z2BfLEi7mmpK
 Pg+qC9/Giez78CUmQ0SOoZzNP78oSRTvL4EM1cWtBMV6wc2Zc21kvy7LNmJsO8gMRR+l
 JYMII5um5AR6Z2CspagIDp/nxTPwihrRoNHD1czHLVZ9HbeXqodveF21Vh6guRYEXXgF sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44kq6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:40:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLamDX023609;
        Mon, 22 May 2023 21:40:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8th0dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn/oEF1FFtQ+0oIeJF7vXa+N6UHLgjwpufBYHWUDsJXUOl/T7VQCNaFC2Inawq84pNIhmtt7jUTVmlu3ewhqHtoMIgkjtkJIZmFHgeAuakUgFE3ffkEpyCKzIKPH6pDg2rJzvx5LqnS2rfn+3GDFlyAvTfP37vNwosAYnoUn8tYtOfTnAP4lhZzhHKqnmHWwUd9FriD4Co17UDJBFo3y3QiWyAuMy0wiy5JmIi6MKA5zfFtY7X6u+XHsIw1s/XU4W3UehtJWb+4OhCgZhtj9v3jEBR1TIQJEq+ilLvGphp0k/ljublI9eF03qOu4TUpWgP+GpklS8N+bkB3bJuhvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK9bKPyPnjMEvXhZVJhQyW/Bo5HHdHxPVVv069VYr9w=;
 b=lVpqn+o/YJNAgoJd8TLcowIpyLpMhDkua9tf7W5mDIXnZMCe+z1W6NIGGk8RUtwSK8DuIoqGz3aU1Ai2dF4ljO/n4cs+b3KEVUXaw6VvMEeKhyP61DPfBm6dJ/w9leHSxqYqr++wOSnH6EsgzJTostpGwt3MA3TuRz8kGXJV4dJ2Ex6ed0QAWFrMvFw39fPD+HK6dzKjWVtK3nUMtj3IXlLCJ58EqCBRcvOnhUztYTonoBDH6IgmszM/1ZF4QKxUy4YI5LsRESaJQ+Z/RfC5RDy672lj8oO9vLbHHvrfClYgqSmSIiuuadTms3Vj8QE/ffNU8q/qNocpgy/ZQlY/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK9bKPyPnjMEvXhZVJhQyW/Bo5HHdHxPVVv069VYr9w=;
 b=WSpYX2YyrJRgLueAnr7Yq0OPssKBImkNiUbb0XCRq4odqFVQGzzNNAP207WH5Ya8Exmrhym1cLSHwbJt/9CYIlGSi+3ZNbH4Z1p5lkgVHbxJw1g999qtGTcwitRBDrKsejeb4o781vgXLNGc/abqsjgwuihf8FGahUA2Ifno3Cc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:40:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:40:33 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: mpi3mr: Fix the type used for pointers to bitmap
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfboniyg.fsf@ca-mkp.ca.oracle.com>
References: <8bdf9148ce1a5d01aac11c46c8617b477813457e.1683473011.git.christophe.jaillet@wanadoo.fr>
Date:   Mon, 22 May 2023 17:40:31 -0400
In-Reply-To: <8bdf9148ce1a5d01aac11c46c8617b477813457e.1683473011.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 7 May 2023 17:23:49 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd2563a-fc8a-4556-82ea-08db5b0d2c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDbheWAESNtfzdT03AEpFAyTBf/6hIfcdsJpFbIFhEAiv5X5WMTk9nDqMuvyMsE4aWEGsJJKDhqhnrBPl8YwJwy3r+dKxIRo1+GWEcBUohcnG7iVsBMej+BYtYdeXrVWeaAJDvUCgmf0kNO+Sn7cJf92h+nlF6O4HPDj+U1Qh1F14WbuL357xZcxbKLj76O1l8H2zwycVaRc1yKwW/iwtl4ZqHCQ/ReADDbPOFG4rjJ1+lZ6G4PpYnMxqDDg1SVNP6x0BXc+4HKZNqYvPT4vK48cyXt98NcZXLjs9m/HbwMQXvI5juAmO21uDBMABWuvJeQcMlqmhdGe+xQIxlcLu43qMeiTIrT8vsfrtXDPTnbiPCecgCGbdmn0gC+k3pUfxx5dTg+Ium0ek0oRT8fivBO6gHIDU0KGdfIC5YS5PzeaoDsX5gDNig1RioiV7ZWwgfWCTaSntcrxGhYDBWyCYoC6dBdgNvFMcw+hMGPXtcgd5J57DzYmUAaeM/CbHjEPfeVh8DGyy+xdwtnuly8BgI37UcOoiPD96FAypt8bkYgLJ8ZamqsSMWNAat6ClIf51Qzm9uwhWCRY7bpEs5zTkX65w5pLZuLqh/5RDnyCdEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(7416002)(186003)(26005)(6512007)(6506007)(86362001)(38100700002)(41300700001)(36916002)(6486002)(558084003)(66476007)(66556008)(66946007)(316002)(478600001)(6916009)(4326008)(54906003)(2906002)(66899021)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOjLlLmyrekOXlh9Vt5jlOuJZACXGeOoali6TTAKbiHDEbE4bbkkEctkFsDH?=
 =?us-ascii?Q?Wxth28WxctahhEBJFaTgWHfP+drRaU1A1E6UUzbvP2uIOjlF2bIoiOe5nO6t?=
 =?us-ascii?Q?yCoL7vwvWDESzjqWMrd8URcyGpw8N8L/K+37ELz3eYBJhpRn6dogW5uYbvLP?=
 =?us-ascii?Q?wFX1a04vUl2Bz+JOs6k0WpfbY9IIq95On+2nmQ/m4vTWnnl1KMIzmLQsrdCE?=
 =?us-ascii?Q?GteQ4lZ0WGa3kH+h3iKfy0qQDYhfnn2z9BOFtgTFbXq5PNSoNxi982yrRitK?=
 =?us-ascii?Q?ITiJV3OmWjdsGrqkzS5pW0eKG2cNMmohu1UjCswAZuI3AaZkluZF3jkSBMLx?=
 =?us-ascii?Q?1a5erkuLSF3MFFtmTxBMRvZzvOCI/x6dRwBKUwxzMvMO88AlW+JdoMd9q/Pf?=
 =?us-ascii?Q?dfFLp+nN0ywKhhkti1n43Q9pDtsKX3/BN6zW476HThQEFfVJiMdXx96PI1TT?=
 =?us-ascii?Q?Yk2BKRCKRp5zdHrVywi/OvsK1GvAaZtgQsYiCWWfmrPLkWLo3q1YXE+cCtMf?=
 =?us-ascii?Q?UigutaKP/g9UB1Sen5uxrv1czjNUN982fsuq3stgsx2/i0/5b7IZ0mK0/MGb?=
 =?us-ascii?Q?MhHDnRv7L3ybzf9dGqQek7YaTjH5YyfZtNPmiukpdv0F5h9ENj6/m2YIemaR?=
 =?us-ascii?Q?SZR37a4NQ9ItsAiCcLpMiMY96nJoEu0XVoE45ZePz0XTaV/1JbA/70uqTkFH?=
 =?us-ascii?Q?xsf9xSGIUrSiPWAzrYz8phkItY6pHdDhfAVS6FPl4oLfxgMYRcTyjdhCKtUJ?=
 =?us-ascii?Q?alG3A/f7oaYLiQ3Feh1OAsrneR66rJ7zIBqdtgl58Erl6GGwvsHsc6sQdmJb?=
 =?us-ascii?Q?e1TrzCUIySyIge3fGsYwa2ejsyYLnl90MtjnygTMdBqh5RUQQ6ykvP5vU/Pa?=
 =?us-ascii?Q?8PBKMC1wjISiksDz9E1d5ogwZqFtngB13+VSAKiXTXa7lvQJB2syRbFyucOr?=
 =?us-ascii?Q?eAdbxzXSsh7+MgDyV8arxO50zEhTGCLMpaRNJgw1mlM4dscXjyljGoGPeZKF?=
 =?us-ascii?Q?3c8JDihwG4LdHr84wTAqqDtT6NKoe7HY+5fy/F9D6W0mWLne6P7mCW9mQwpY?=
 =?us-ascii?Q?Ynrdp+PE2ub8xOwvlaIEHPKywcfirKtuvw2W6J+WadAJfFl3u5xL492MA8di?=
 =?us-ascii?Q?rFSdz9gLaOmjEiiGOnRy7ITE3uDnVBYKX9yHKHawEZf1U9yihBXStYoKLWap?=
 =?us-ascii?Q?ggeKm8Cbgch1PJgAP+nSnOvx4OamFeN2IOhwwjokP5pVcSUWF6liGKyV2Ml6?=
 =?us-ascii?Q?ATp4Tt0coTwzaLCjcSdl3XQ0DurRnfCyvRfxqFMQcZK2G2qDc25vX8j0Spjw?=
 =?us-ascii?Q?33uaugtuO7hiEXS3OaYXOdMkto1DIgdyY15yB8MGrp96z4zJoAPlYUuBtfAf?=
 =?us-ascii?Q?q0kai2oxJKC2k6M2TZU+Fxe7gXPvhYPyDHEz36bs/Ird1FDnjE+SvjgPvRo0?=
 =?us-ascii?Q?kgUlyg7eLL8tjMBjElzjrOw3GmGnX9j2oL9xzjRmVELd6fTfWV7PYnCca/tn?=
 =?us-ascii?Q?ou+XkYJh0rmdp+wN0a4fxaATohZLW31QUVbkG3g1v7K6DJFFp71LLFZ6Zq5F?=
 =?us-ascii?Q?esoIw3XBm4K3BbAb80og2oyaNN0CpU6uLK0NZ+H1D2OyzYQAlgeyjABfA3ih?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RSx3+9Foep1UDroUK0wMMYrWYPr91kVARum/zX5c5pCP9O6pjRsvuzcC95EsM48RM+Y8nRVUo/3U0x8juhOHzfTpSOFeZ9PLq5Ao3S2SRSokycMKVgZWfzpRzdn5Lub15z/j6Zr3vC+uqWIR06HI70UcCKFt8EPshbfj6Kl34zweEmAe7aCYdYGGg4kKAXM9EFfTNj7x3w0MKcQDN9kcak8xtTl2LOSEnDdH+ea22xH6fH052hU/2uIUODumIzxMxh+pK9/BfESc4PEeAtmbn9QRyEmZon8e4ahhSoaBgF62m8hZAuOPw+J3sIUaIR9a4CL7Wk741jpGqTLLM6VQtn/nTd+I24Z6RDmtQYLYp99iQ/AzlKPKb2xpAMbC3ublAB/kkIDzRXW4kSl5xZ6Ldu0B4fwK7IeGHtxe00H1dntVVTkdEYxcD5EUi8+5FCRSyRIYd7506fEuryBmYrX4dWmXxZBlNxi6VVaAuDPlI5Lz4Xc7xu/kWwpwlOAuJMoTvndARcWVOmkasxvLg28j8zO1MAOHSBER7OEoz0TnPELKF739x0mr4jtyrKQv8LNHv/0ZU2MzpJ0SeCubRGUDoM+oo/Ej2JZwqvNwvx8AQhgUMkWGLbeN0xR1aRBuapa0ptkR8H/jpxJ3bcC0qKnsC4llXYKo8LZpeMw2zQDcGEWMwglk3TyEJlNKdkgq7Jvf+7RyUKPbW6TKdRGBi4Go9XrMAs1EBCLOjDqOrEDdM1rHTK+ufbbRdIv9WtBxMCcxY7O/n9jYswb4PshQeo6z7i8rVi8/vWWKXgVirzqLB/iN3i3B3oQkj/oJmTEt5BKQV48U+gGiap4z4XSVVReKTint7/OPsANPOIYHWx+Du7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd2563a-fc8a-4556-82ea-08db5b0d2c09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 21:40:33.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUgBWMRmDqLwz83aS+jXxAXzSNYQ3zjfzQxa2Owl//xghSIEkQuOpg/BkOSwD43mh5RXFE6DHdEq9fjL9Y+x37ubxAWxjff79C1YGOeHWmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=872 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220183
X-Proofpoint-GUID: VBOAQuJli6Mx2nso8tWGBMtHzIJ44pCa
X-Proofpoint-ORIG-GUID: VBOAQuJli6Mx2nso8tWGBMtHzIJ44pCa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> Bitmaps are "unsigned long[]", so better use "unsigned long *" instead
> of a plain "void *" when dealing with pointers to bitmaps.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
