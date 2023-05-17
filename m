Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D5705C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjEQB34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjEQB3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:29:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09731BD3;
        Tue, 16 May 2023 18:29:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwrE1019747;
        Wed, 17 May 2023 01:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=D9s4+J8MQ0/lNHReuKr4LLUy7qQGOMfOS6eYiUct3xk=;
 b=XEoqBOMc8/NcKg6UQSAtLVTAz/qmglwYJS0H41FfTzAL2OPQTvoZY2Q88gVjiQwuaSxz
 CkHgCDU1/FtgiN7gvVsH39Fb5oJxtGjjPph+FxE25JC+paCNfjalScfxYSE9tERffpBq
 pWtm5Nx41ML5cbic3XWD3H048L4rl4aCMl0GHscoruJfzw51bigtf3pGQ9GA7cnuNL8x
 Fy4ngJJbLTS19Oi20Vn8jKuHnHcicmC0V7GJ/uDOYmvneg0fLCwxhMTT6pxqPNcnfvZX
 yE+7dLJ4hQhOIm1U3uk/Yr/RfeYyBPYvJrKmMbcquksT+okn1V4d3x74zjrc+G0/tynd 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmrvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:29:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GNDkEu025033;
        Wed, 17 May 2023 01:29:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104t34y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAcHu1ileAQUAwiya7gTcVJ+s/oqz12n9jJHlhBEXu1JAjYxHu0YKAoZguj0YwGraNEX4VVuK7mG6r4jNJqXz0sW+yoTA8Srpt1QY0bH9aL2yP+tICEa5yKzK9hm0A5aXiHkA2ivx8gmx5lOaHstOCsz4eStQJejE4w0t/AEB5oA/s2Ze1gxHgQZHHVQfLpdN5WBRZyk+kO871ueJrM2MTWHUlaSUMhClq/3B0aiFHghvdkDkIzRsghcK8HiSU+YTXatTu8GOumLJqZ6Lasc8h/61Q9Nn6MLfncAIaFdFIOpKTjvRvGEZBu4C1VtrDm5AkbvD67wgKiDqXxEM5F/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9s4+J8MQ0/lNHReuKr4LLUy7qQGOMfOS6eYiUct3xk=;
 b=bUy8/avXvyqWE9PeMKR5lCHrB+k/wFgQ0x37QfDj7jzn/WFbvR8Rd3jk2ELwlKiA/OPvnQibl09UdJosZ39G3S2Qj1ru0yIgc7l1SQk2Cf3CcHiHgTt8Sftv5BI/EkarccRrO7MjwbogiHCwwKussGoGhj806lsCY8d9o/d2P0922vKCmCfUhglCAb3nI0he9Q2UM+FqsO6tuEF5LpCr5tJd22TyVjOYVKJmMuXdga3+M4KNLN6MV/XHXRwv1pkFSoicQ1VKfwIVJFeQGLzOhGqIKHIsTX50bWP+OwVZc8ucZKiHe5qb9eWFXTd1gABwW2HRIvkfT/KcHqM0cAAwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9s4+J8MQ0/lNHReuKr4LLUy7qQGOMfOS6eYiUct3xk=;
 b=huX0jFTbaDGHK/PkVhQ/bAGj7fgchtWGEy6XRc565JI8YVrFe7Z+7isbNxlT7K3504CD3xuj59KmljbQuA3on5A0IaBjqgW9Y1pn1G6iNxZgx2Za5NAojQGBt0EzqsNO/Oq6iQGWtUhTBgPFpBxqJLRog8BUOTGGorAkpQY1CKQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 01:29:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:29:36 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ufs: hwmon: constify pointers to hwmon_channel_info
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkijvj81.fsf@ca-mkp.ca.oracle.com>
References: <20230511175204.281038-1-krzysztof.kozlowski@linaro.org>
Date:   Tue, 16 May 2023 21:29:33 -0400
In-Reply-To: <20230511175204.281038-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Thu, 11 May 2023 19:52:04 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c8be79-85a2-44f2-b3a2-08db56762d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh8+DabXTN0OGr4E9gngWzfK4x+ErTCbe0zr1ikZjJeBrLNQ30a+5PfaI4GBG9YMZE9cfBH/B4P7lFaYJu928VxE9n9CltSQNz7YkjhlUpxXkHpDG7h1aUO7WUek7pXjZ9CMjp3O2d0HhxM2YzfkJg/Ir0B4yBVKFNXccAphxY4jYqyflJjcOUBEYBX5tkFyQ+qKB422XS89oZ8yoNS4fW/ZlgAaqtGP9r/PXdjGBZ2IXiteeXdzGkgWhG/uGwY/WFo2/v/HtOoRH+dwmdZ2UTFUWJMzGJ1fT+WPSsbH1gyRIAieHxwhzw7DyYP6aXvDyDj+W0/KVYW2WVZHfMwM1z+6H0s0RIw4nv3loJyaWMuR1uqmIatUHkJ2dcWDxjrTuqzIYvYH3Hm7GwNxVp8YatyoTVJhTADt8JA5EpvNQMyQKeiS8qGK65l85H37Ro0cvZ8RWK62L7VVZK+Wqt5pqIQI1FH5JNC9/LObbZvS9ZHips+RlGWW/8Vg5pOfxe2wzYyLL9eD0I8VbgweSYkUJCjcPa4KnzNI8sIbmNReC89e+Jc1DZ5vRKsX0mduBcIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(6512007)(478600001)(6486002)(6666004)(54906003)(36916002)(26005)(2906002)(4326008)(6916009)(316002)(66946007)(66556008)(41300700001)(66476007)(8676002)(5660300002)(8936002)(38100700002)(558084003)(86362001)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsyCZWvlP4cYX/2J/Au683w4XxnaIS5hsKk2tBJiAg4lN0JHD5in9vH/KhHj?=
 =?us-ascii?Q?p80EhxKt34NZUSBkDDKBCam441ySNldfJ8GEvPrxnlnxM+OtfLXNonx9AepW?=
 =?us-ascii?Q?Ru6b8bzQm/BgGcvh3Mlgc4XQLw2WfudUpW3kITu7FrV/vObiYmGzUWPio6Jf?=
 =?us-ascii?Q?gBPsuCw8vPABXOW1zf8Rs18wAPUKAaChTcdZWvE+wUfhNfYZTt/k65zqH1iO?=
 =?us-ascii?Q?sK7WYUDGG7wbwjPPG+1JtCTHZTGbADPfnLIroFoaDhXbRLoHOxrzpsflpnaQ?=
 =?us-ascii?Q?AFDT2QakO99YBUL1QtXQlOX0nbPsZiwNHSzmQyICeFxbtoVyTjUNzk0PKQtA?=
 =?us-ascii?Q?zNe+z25DnmfMvb/BEEU5zmeqtVM2VCJvJtEt4MbGHqyDP0OFz6hgYR1S+gJ+?=
 =?us-ascii?Q?Gc7McW11lAfXdeUzMEcG04uupV3Wqcj5KwjxJh4X1TWFCSopcjYy0Q0MLqOb?=
 =?us-ascii?Q?HnxhKLqz25zGnjeLgsyJ/me5hHzPDbbTUPsWsGs8m4OVJ3YdrBsFwfPdChLu?=
 =?us-ascii?Q?1d8YwxR8vH4nOzbn3/7NF093r+z6VkPn6IiTtBood9SM4rKXMEAlgIxTgEyC?=
 =?us-ascii?Q?f+h/dk/AlPbfJW7aamfjbLesf0uNF5ef5VGuyvn4OUkCiZ349nrzO0UcJO9y?=
 =?us-ascii?Q?kTAIxqRzjUcFyiGFbV2R18EWx+FUg7yd5mdUoWL7UMuapBS4WfStCPweGGSn?=
 =?us-ascii?Q?j3jpjDKSxT8ZpFqg7yaVGhZoTQvQZaedSoM07lRGxkNH+ym4zW/D0CBjEeZB?=
 =?us-ascii?Q?SuYRTKA3j4vmc8oybkPD5xtOFMPdveb4IoAotqYrIM7PKHwtC3U2SDSvOvGe?=
 =?us-ascii?Q?hzOoc+iLcNnhBZtZlRI4IYF5uI1gyAP4B6dfzz8A/GTrAK/jFbugrX7f6lIy?=
 =?us-ascii?Q?QBMaoDSu6+KSEyCeMWxlBt0X9y4Vq8xV+QWZy18eufyoY9tD49bGi+6ND2bC?=
 =?us-ascii?Q?U37re52MIGETIFEmuNCEy/DQbU8gEo6s3L3k0109iN5MCesprNfpx6t0g4/p?=
 =?us-ascii?Q?/zvV5zUY7pKVWtp1A33YkcjIdCCGjaps3YJguQcFb8QIosSBj7idrn7sFsnJ?=
 =?us-ascii?Q?d/iQLoDKH1nLoCfr7QO3zmm/mpRzksJcDXJnJYfsJB32/fSmzGK7ZiaKdspY?=
 =?us-ascii?Q?Q4r9j3sGbM6TjZat4KrqLEE4HauGG/q94lQOLo5l50Rm9xClekR9isfrFG8r?=
 =?us-ascii?Q?SKzByyXfEjJQvcAP5WhUoeonbuyzLIWOB0c8QsXLylijUdJoEMwVnLn4obS2?=
 =?us-ascii?Q?p/OO7FH24VPgby/HmN/Zlty9jTrxICXmcPEyz8Ev0//xnXiJNsa1FoT3uP8z?=
 =?us-ascii?Q?dVoGBzBr0nd93u0XxdN5zzqC1/PXL9w5ksuxrmziFasHkkXA/3dThzCYFfYC?=
 =?us-ascii?Q?VdJSH4M98P7WD5QpM5CnzdTKEuI2yPtB92O9ZhcNoUYvNzGzm7I62Ah4/zAt?=
 =?us-ascii?Q?Ccc86YCGw3+oFfb52f99Pw2xNUfzWWRuUc6f/OibZ8roGdwzMF2u+WA+7J8L?=
 =?us-ascii?Q?2DC6NtiPt22ljvvMk1J30PmoUWQ1tspFtLIMTb9PydQqz5sUeFY8LhHmPx/U?=
 =?us-ascii?Q?cyCi00ltuBRh3fXyG/AQapW7xHIcWJxm5Q/pzQjzQcXCQ3dyg0R97MDG0zCw?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wuHpPtuzuTJxwxqdjdmDp2ZECSTyMZPFQbWf5FHJnzdpFarvc7/i26xHWdwTD2baenfZpxK8Bp/+9WJVw2QWR5Qi2f86xicnNHi0huzEj+3+JUC5Q7Rwmsy8BR3lah0C2oKgYRXjLjVIVE16rIkywPgJDTm7DQbwC7lnhTvb/RPpN57EBvCQZrl3+pNF/BoDtV2W62VVSuXVPOdovd/3PpG0NfItwRDrOUH6fHGjauIkm3VL3q9JGxL+3m4euAwcAqXzVuQgB5Tuwau7Da+Bwo2/O/tPdGley2CLKmlBedZroodHRx0YXLgZcRYJWq+DAm5l7b/TL/fhhmBD48FgmYl0k3U5rk9lw9kCzHiszdcMzxbte4g2zSx1Q+HCtHGkMUO+x/klvM+Aa8scIC1aYlTTaWaZZu5VIs8OumiO0OZuJiwcNo3R2DndU/Tng7RWOfqARlrzk/XK4xHelmPHKTN8XW5G8eZz2Z2IFxv1fMXanlfhBIP4EYlJCXbfe8tNB2bRT/96mxAa/jqBW5ZDQrEt+8Sa1stQIThXFzYtbWaJYxb4hQF2ymobBxAng39U4n1MV/tgG7T2Gc3Y97PcBA3txL5siA5rJomXN42cgShDSaOIr7sJC1Ml5qXA6tayMkh+sx1A7n6oMJdXtSHmLut5FG2JQ+jnIHSQwoclfdVw0fvxyqHq/wZ61bcQYJI+7vl77nJajjpX57AKR9Eiw1EkL2H10KixoP1qLZnjVB/g/anVUbt/S5laae9G+QXyNX5c3JgOH0vS3mZZjgs+vil89mPCqIGop0ZpS/hxtOsDAcjTE8oJ7YX356GJLEG+HYQcGO9Yv5z3GySPn3MPC9gydSVdacZcirC6fjkZlCKCr2WbhaOdpaG2LuWXV71zuF7ZNp3BMO6W1EB/Bly5hg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c8be79-85a2-44f2-b3a2-08db56762d10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:29:36.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDQbYBhpkuq6gwugHrBpaDg9kyeJyor/ek/e8il2Ixii7UZAf/P21YAsd+RdrvO5+xIcBXgGeSMpM+rJ3pYeQMC49r9DMm+Um5scJ6KuMrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=862 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170010
X-Proofpoint-GUID: -LuztrjJs9msjy25EaYx9XwfHtMGD9uL
X-Proofpoint-ORIG-GUID: -LuztrjJs9msjy25EaYx9XwfHtMGD9uL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
