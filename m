Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366F6C87D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCXV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCXV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:58:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B55274;
        Fri, 24 Mar 2023 14:58:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OLerEb007355;
        Fri, 24 Mar 2023 21:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ebV1bxq2+Gr2pfpNbLIsK2LpMigsq2iIb2vlqY8YzT4=;
 b=b0JkkTVUf7d3JwbVWMDBXWY8jeQqVY1uMf5nxAFQmYN8bIiS4ujDsc8pAS60hM+ihgP7
 giKuDMOtsVLySeiNFK8+Vq3sCNik9w3m2LOs7/elcD9ub96a6cjrzkm9C213GAe806d4
 g7Nsuc3LlJ84FRAW5GUhyQ8Fhb+Iwcma6ZpxTX9Y+zyXXfh3Ny7OMMSGQB+y1odrOvhf
 KtG595PPGlDerYfPx/NqEwrW++X9kqzvEw2KZReidqMwEk/diXKaoKqB6Is3rYW5kN9a
 d2E/Z7UUYy3ACixhI4zzlsF2bPG71tJ7eIbPgU2H1Y6/d3gc29fzU5G3hm2o2U7xIyRy lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkw4r165-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:58:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OL6jXg009137;
        Fri, 24 Mar 2023 21:58:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgy009wyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9N1xxXciTvCmzud/Ah9WN+TUCayjHNeCho1Fr7KLxR9HGVdhSszCJqym3nVvaU1uISctfqlJPmpi/e/xmovx7PQ7LAJ7xCh8+pDHT7ZYwAZGjexftgb2xEvoXNG898N+StegPMgnZVDFIatJX6dOsFBeaqygDFkhSnLzFlPN31IGRvFaELm+BHpwmxOHUa+ZlZT9bK/L0cR+pqjsX8K4bRcOzm8PHeOOzXrv+15++ZeSDjy0PONwgnNjByvvQFTPGpnm3rKjq4nQ25YH9IrPgG8tUU27G6UjBkuKWwp2G9Usfmh9jCF0bRRUZjHQ7CdO1z2I0kNAGyywyG5ZyWsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebV1bxq2+Gr2pfpNbLIsK2LpMigsq2iIb2vlqY8YzT4=;
 b=eoyDyUpiZ5Pr5l5cbD69EnGdK9qjG5IggUktt2Z4vNspZ16wnnLJLcK7a5ttTDdcSNNOwtx4nqbQRamQUxPeNZSSuQuP4SNexgj4o7/MBcugO1L2io4w/UZSDfvwT/45rptFBdJ6JdeOMx1/GCCGNBpNeN0Id2If7f1eTSjV0s7Hoitnf8pFaNctupRYvQFkSE7gudgJp38HITcVVAWUfNxbECqLOlpTOzL+hcIi5C/SKuD7F25X0d3Zo40eVWU6Wpr2PASUHhgdQ2pDULUNuxoI2ul5sgJVBrcSEOt+bUNG0Mb1Q/LLpw20D4ayf1YClJz7ZRFk6rp2oa391NXPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebV1bxq2+Gr2pfpNbLIsK2LpMigsq2iIb2vlqY8YzT4=;
 b=Zyii+keUkV6qeluicWursHv8z6IR1hXGWe6pBfm+ImAgPCxCUqWB+/HKEC37gHMJLo8cgmzLsvihqMa5HnwrDwnPfT97F5fmHT1NgH3Mlyx19ECTif0aSKGnx4VTBkI97kcOhi+VU4pv8rEG1IOFt6oi7S7W235r2O/DAx9Y+w8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 21:58:11 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 21:58:11 +0000
To:     ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] scsi: arcmsr: fix reading buffer empty length error
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm8xizh7.fsf@ca-mkp.ca.oracle.com>
References: <6f3eb04dbe89d2b9f239600dd2c575227f3c0afc.camel@areca.com.tw>
Date:   Fri, 24 Mar 2023 17:58:05 -0400
In-Reply-To: <6f3eb04dbe89d2b9f239600dd2c575227f3c0afc.camel@areca.com.tw>
        (ching Huang's message of "Thu, 23 Mar 2023 00:57:29 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 4237dbd6-866a-483e-2f11-08db2cb2dbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbUqt/Jkonh255Bz4T0UalRLqIc0K5/UtQ6VQ0NEup82SQLQXE1WnQ6LV0aH4ishBoIUJue8wAut+ylDEirZriH+ozFHKq5AMZPVRIaDx7GKQoWnUmLb/7uicDmu2WrT83kkMKos9AXw6LVjHlpEv0h/WUmMaELRhUKhEJZ68Spf/4NV6IQ6sBuywT854k6/M1PGUjrcSiDW7ZFz3yxA+KaZxhWxfsqelC3kPo8NNECFWE6DRnPHkcz4wzclHkVpx9Mk55hgN8LRXEHBitErtPSniOzTWkeF34WRDZiS39PIkJEKVj2qq/g0cJM0BncAYxrBJ+FVDManREYcjyPaJ+m3OWQeBHfAM0IRANJRvyTZS10se0z+bn7nYVYpUz0dRBryV0ydz6GDyvJUGREd/Itg/M66SH3iCSC1yjI2iPQ2inCUtZNpKQVtBc88NBDQNpRMKVPSZLMwmRPsr/76MF3OBW7OiMsFOanCMUIVLUm1STujv3mwYVpSN1GPmYkoeAaZbz3eaJcIYTkZyYuZGeUBtjHR1uMFzKm9uW3VnHY9x9ZE1Q9NQnpMn7IR9lM1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(4744005)(5660300002)(478600001)(6506007)(316002)(36916002)(6512007)(6486002)(8936002)(66946007)(4326008)(83380400001)(2906002)(6666004)(66556008)(26005)(6916009)(8676002)(41300700001)(66476007)(38100700002)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlndFdJvJ6uloMU8Q+IxktnEICXJtSZl/ZBU2evnhzXtrlCusY1hgIitAcKM?=
 =?us-ascii?Q?ZH/rLD562EH/OsAusOvJ2rCHphzBUw9xMqupBLXn3Ic+i1a3o/Xt7x911phD?=
 =?us-ascii?Q?DRNzl5ggsWb5SVPSQomGFF3sfVuqclyjvqHBlvT9nllDz6H3QyWEbQ7oOMK4?=
 =?us-ascii?Q?oCsjCD95xwFnTpNbOW2Al1nlRbE46flvdS6m5FdPRTB8mU99WpBgLlHcymlC?=
 =?us-ascii?Q?IwqAp/6xxrOjIeVOTGd4enicTB7kD2vzUHVpRQ8vGej3BEd+neSUY2mzAhmh?=
 =?us-ascii?Q?4E5lBfGzXs2tVp0MRigzPLMwraN23KdfFuo5xadoedCYMi7g4BpxYypRBZHI?=
 =?us-ascii?Q?FYXUbOiewu00qwbVbE5bSfmaIsKtd5eHSVxEl7TIvrEBlCBJhLh2jokV+lCY?=
 =?us-ascii?Q?GDoswI+20oVjRgjL/oYK2hKi3gjqx15VbzrokdvILz9ABVsRJ9fS636yog60?=
 =?us-ascii?Q?4kmOC2gcldCi/y/txv3YA4mAZJBrnivp8UgyiLNZJMetfc44x8BeRPGdvxXE?=
 =?us-ascii?Q?ANeppUfx/+r9pg+LJGGYYWSrDg/nfKvqqMnLrUfotj0MNVIBO56L14ByhsfJ?=
 =?us-ascii?Q?nx0tTVnppsPL3IzX1vUWvZVofC4VaesH7nlyfbWaJALbauM5Ggw4awTE0L5k?=
 =?us-ascii?Q?M1+sqWE9HZPVTwRXJCQONhLAwg8CB3fri4Y/GyBl0qfmUdFcTBxsoYqcqglw?=
 =?us-ascii?Q?6ZNydQhT/CijTYXTGAp9y67eHNl3a/Qa0kD8l6lm9Hrj/LUJ/Q95Bk1FsWQ8?=
 =?us-ascii?Q?kUgEsRWZp1QgNmwvEroGIcwZ7DXLYsIvXLGxesH93bF7XG9KVJt6TdJz6XM6?=
 =?us-ascii?Q?m2T8XbH2lsWGnsacSEIQwPkxUAJFWBCwpQxXh0+JFrmcE1e+WJBmhLeox0wE?=
 =?us-ascii?Q?/TQ4HgNW7SjU/ij7Zbkb5wlgaDA3/Uz/2oC5NDkdEpE53AqGxpW5Z5JIDjc5?=
 =?us-ascii?Q?W208v71EJs8BELjv1ZpXIYO38hq/Qq3NCjvbtiMK5srUMGEDamt7WRi5VwOA?=
 =?us-ascii?Q?ubD1B0sSv3pl6Qv36QmV0eA2UBIEkJEzAdGOYf5LO7RGbN91xbnI+ByEmum3?=
 =?us-ascii?Q?xyMvXnsUi5v301K5HwWhKp5ANq1cc9D0ta//O2Wc6L6m7tBEe37sFaswNGMO?=
 =?us-ascii?Q?k3dQL2OE/93ZrJh6HvCixUwe5EBRCS1oGjcadnANRvy6F9/sKEkbdn1VdWbG?=
 =?us-ascii?Q?dRF9aZ5AOlDdThCYDLy9c3utF+63IbRLl6dLYQe45ULh4roH+01oKYp1zZMf?=
 =?us-ascii?Q?fYkT7RVrGGq0MusqOSGMoQaj7Pu3Bb1A9rqE4s1iLlzxYepGjI1o7M0B/Z+o?=
 =?us-ascii?Q?gkwRO6VNmWKWNyE765z4Qp5pFWKk+HLgDw2zXt3BBRDXnujzIO89+vKqv5Uc?=
 =?us-ascii?Q?qfVtCiM2ZmkbmBnb1oi25cff5uhn/sgnDFgOtu33SRFqoSTiHVDEeZzgoLUn?=
 =?us-ascii?Q?RzbrzEGLwtDCJWVOAwA6WWXaKZUblYff0TMuxGcbK37eT/sskHmH2ectQ+4v?=
 =?us-ascii?Q?FxdszIf0jIACQUzgXS8SNOt49V6oloaJUH7095Y/5y1OVMS5Ju2IaREE7Svm?=
 =?us-ascii?Q?qDFsCVUGreCqoNJ7gHUaGkgLdSGXeLuwP7H0R2GAycpT8NxSsnmrzQt9UeOX?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pcK5Rz1lxVw1nAYlLI2q7RmuLa96MAFT9ms+YEfWkX8hriPlQYIgMeFoZlRogbYg8CzB6wN+WxXs/zq6wGB0jzcu+dPeyZNDRnx088gHVo27JxTI45GUm0OYX1WH28uxKqIYj//7Y6kJfuTXe7VC1ugrsXib+VNfq3h1kigPoKkD0tM+d5+3U7/WJp/ClbjQgnvqCr8042rDUbkd5eqTgd96g+IsojRxRw+Hf+phL/hwJweryKL07hSgSOm9Eqz12usMKytjUvkcLwH7fQzd7xYHtkB198LJh6RKWKo0ftQqZzEe1bU0vCuikb1bqJQ5Q78sDojycyrJVzSPTwSRrqfCqx2LwdhsDHUFH3JCrmv/Z98y4mn2zyvVuZ3ekkuK5Q9wlyQYG71khw90FlbJ7jEVXcYD1a8i7r/Zq0NwNZ2n5GqD55xH0duTKxCNp6nHkgPgplSSPZZSdmWbSXDDkifAnLx1pz1A3NPwmK5biL6uwzzH/xWHQpVCmBWAw06Z7xmI10O5vdNiqNtiMzWuAttUCNgB0vJOLCD1XYjqeeehI4lZlceVvxxW5zCIgiKjm7BGiA1o5N75auFipLZuyNXSMlxgD0tadk/7QhoOuh08FlFpq62bHBj6rYYvzbnav/UYB265/2IWm7bOUpleRr4oBwWHrzffq6aAy5CtyqnsUGXaFXGlXlA0Tym6iRlracxFL4PqM5ZLxAiJiIawiV3Nuw2t0UtpsAffQV3XPyWlEnNQpeIj/ZUkTobtPGx+i0rttiuZ/TI1GWPufJmx8aYR/jevTYXeRSok9rT/BFklTphALIpSu94L8H85u+L9VC+P9Y8+KITdqZi3ogyB/YKpFgriUzHIuW3JxdXu7xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4237dbd6-866a-483e-2f11-08db2cb2dbf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:58:11.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPImNw+AnfIp0vvt+SVVTzvg84jeeSbrEVR/Fw8ZsZa52YipmRwxUv6tOmEuljRLM1fcukUoqJf405Q60xPd8Q75ryZaxMpbRYlrdXuDfjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=870
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240168
X-Proofpoint-GUID: Hf0UkvmMVbj6BghmbR-4F94J7pAOiuEl
X-Proofpoint-ORIG-GUID: Hf0UkvmMVbj6BghmbR-4F94J7pAOiuEl
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ching,

> The following patched were made over mkp's 6.4/scsi-staging
>
> This series comtain some fixes.
> - deprecated arcmsr_pci_unmap_dma()
> - fixed ADAPTER_TYPE_B 64bits dma compatibility issue
> - fixed reading buffer empty length error
> - added driver proc_name
> - updated driver's version to v1.50.00.13-20230206

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
