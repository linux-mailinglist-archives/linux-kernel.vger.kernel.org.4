Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018A672C91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjARX00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjARX0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:26:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B2D15563;
        Wed, 18 Jan 2023 15:26:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmnOx021487;
        Wed, 18 Jan 2023 23:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=e+st8lNRcMCN8ouR36aCNghIDshRGNUtq6fD4TrYHPI=;
 b=Cqg/zNrmkK5wH7/whbCcV8n3oVkSeqApWrELgtVPd1NL+1TegEGN6HUv3IVGqGdatN5M
 hOEmUcHWMWJxWsSAvEHwebJ6A5E+l9yX8XlhNooMMddQyNK5DnUhjTefOnrtLyw9eNGS
 QPSy6Ajw/u6INBL+iivuFw2D2IWQJZOF6p+rn3fTfO+HQ6MdLun3G9VA8rHXbeaFzJ2q
 FhjeJjLPZ0cEEDLWT/dEqkvznf1iCM5/NO6eXwpU0SOVBNAjCRRByt2sTe2MrCTeGt71
 uABopSh1oEL5UauDQzMabmknwKqTEu0naiY9gOrKniw/ITUmfWmN2II9YUT4YUBTE5+6 KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0trw7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:26:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMqUnm018138;
        Wed, 18 Jan 2023 23:26:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r9e4dth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYHuFy3sNNwycOqQYarUtQYQ/kgkvCm5u4I7jQ6x1JelmS4rYxMrQKwDHyPu3jdsHvYG0O9+ETSmzjHZT7Bdzl38F08BovD0W4Ky9q1nBPrPIHeX9qEtXQPHb+mNx2KbQqztCepdoFrwJkXujRrlDfo5urWYlrdxp2wx0AlfIjFnL/1NqsRiBFPPUAOv9DDq/E3KVgRfQ53d57ClRwXmfR6OZxg+Uqga9hW3EbuoFvWrlg8yPrhAb8zgnQXZVou+Ukg98bHS2YoLkW/XnF3h2QB3nsq8a+uWs6sBF29w6uV54JALfKOOAPF/mGz4hDSFM9EzokYtQA4qLOamL8jwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+st8lNRcMCN8ouR36aCNghIDshRGNUtq6fD4TrYHPI=;
 b=ldckbX1+p0WEYzCmoajih7gp80qpdNxYFGrbbmPm1Q8HJBYwIVtu3YmAkbgTtd+M2HFYHGdjSF291yOAR7oA4GEYCLDO5+xTxuMvGash/+ZYYMwTDV3XF6BAAYHVTa+xpttHCHam5/zRkCCQDBCognljapHZrkhtxTzOKF8WSj03apEWADLKDqEXNjxi0U26DoGcdFLmmpHZyk++n9Indj9ZOZVp01SzCVfnVcbu04JQhM1ahdql4hqQXubqG3hf7+LjdQuqE9bRtPuFcNbE0H4z9Eubb8kLe1cCjTRZAzcDo7rh/ckNskPNByNMiu3co7tY9Qf87CtAxSK3ZtmYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+st8lNRcMCN8ouR36aCNghIDshRGNUtq6fD4TrYHPI=;
 b=Ku4MdFp4OKdjDT7B9YFhTPkbzexXo6+QJ/vs1Hhcd29k+pGtTJzHsxqLEC/EN28BBJvYD8SHWIe62z8Zh6/OyQ3CtvJkDhqLhF1sieqythP9t83PDbP+jSCyHgg6qHnMeUzc34KsfKPsFDIwTNlIkFiIQArBvcoP+UNHdK1AgoE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 23:26:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:26:14 +0000
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org, martin.petersen@oracle.com
Subject: Re: [PATCH] scsi: MAINTAINERS: Add entry for Exynos UFS driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8l3pgqb.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8@epcas5p3.samsung.com>
        <20230114080247.601312-1-alim.akhtar@samsung.com>
Date:   Wed, 18 Jan 2023 18:26:11 -0500
In-Reply-To: <20230114080247.601312-1-alim.akhtar@samsung.com> (Alim Akhtar's
        message of "Sat, 14 Jan 2023 13:32:47 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: e6414ede-2ca7-4f61-47e4-08daf9ab6404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI5KqWbHFKMEsErdnM2qYIbPW1f3MPAC+K34VXfYaUVzHbSqx9aBgK8qbJh3G6hyWPITVgT15FKPuE9m6bFZ84+PNiDjI8zQQwu9D2MOYDneVzznjiTfSnWpiW3Obt6faSkwk7AcXU8IJLle8Ln5zGWokvQ9tU6xmfgqxmFR7K4IV/Y2Ubt3ap90q5eFUA/XYE+2ar7Vv1jQSpWMm630zB/UKYBJxCNB44mkgJDJCnANYudjNeaBK88R61aQqmqYpjc5XpaZr9iiAnuhJ13cOkT6smJOoBFUP6ckypQcssm5bZ6g1lzW9RvHmYowq+xF+qW2DfW8rTbp152b+YQEGd+ExASwOhXakXhXSNOycrKw/3PL9pLnMPlRDxpb5RZfVn/isychcB8dA8KWhrScoK36O0ozwoCN/RaEXttUrN8q2Q4rnlEl+BirMaTuz7RnZnjbXIrKjPojA3YxYBqTd+oGBlUUOJM+0FdOmG779cV0FCIzivtmbVf51CUICI0oOn6m9KGBO/mvQSgiYdT7Lh5nyBKmPsUZi8bDIh9x/GQsZgtxnUksGWydefr+EfY5xyfZR6g6pwlgdlpzfLx2vCPmaqcuUtfhTbGjhC6Q0JIdkr8GEVknvfzwP07HvLV783WaAdiytCxdqxJcte+q8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(6666004)(107886003)(8676002)(6512007)(6916009)(66946007)(66476007)(66556008)(4326008)(41300700001)(558084003)(86362001)(38100700002)(6486002)(5660300002)(2906002)(6506007)(186003)(316002)(26005)(8936002)(36916002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tF9MTGC6LvLB0zdsiDErl2nCPtMCegIbsBvaPwR+JdsiVIuln8H5aoeqtgYH?=
 =?us-ascii?Q?dWOmJBYRkYih7+ExejUlqLNkDqj4zjae6cIvQtZCY3UD0FEEkJoeJVTNL6gI?=
 =?us-ascii?Q?Y52c3blt3RgbAA2/E+bbhggPnTynRjLVPcyyC4iu3Q+9AgrtlVUXydLf1rMX?=
 =?us-ascii?Q?VFOdou7sauGMr+edZa6iMMzGzcgUb1cZGZ7Fsxbh7koVm4Fd6mndN/A63k/c?=
 =?us-ascii?Q?pz6+68ua9a43sgCznkJgpZ++qDtONEs0DCNrhkCkK1nlbQ4ajFbLDehVVEev?=
 =?us-ascii?Q?zt1EGnOqCugbTN9HfZrCYceOBb8J6pfXUJKphILvoqkiyOOlqUm6r5GJOCFg?=
 =?us-ascii?Q?y660uhfpE+H7hUnFaWbGxtfniXRzmWiILkWP+19eeXlVE/AZiqXUkqLO2vji?=
 =?us-ascii?Q?tYbuYNRTh71IIl+jX+j24aCfSGp1byqDp1f8ckA4ECZOF/sZfn7x9htDM8h3?=
 =?us-ascii?Q?2q6DAWsrGEbyfMBF+6hZI1Xx0HKOJpqCZlAvsn3AzGPfi+pIeZFdfzRjiqPP?=
 =?us-ascii?Q?cI5acameX/GutXs9cZzFnuhYGagx9J/XYZDbn449UQCce4TMs1ly4dYyhRas?=
 =?us-ascii?Q?92nIMH7THWpZlNafR13ZPTkYwWcpegK3MZI2g24kqSRalTnBYAnX2SakM9H5?=
 =?us-ascii?Q?dkvZstbVF7wWvxgcshCNuFkeOPslCxf4sikt9/w6hJ7yBbOlCPpNBMxOIXaB?=
 =?us-ascii?Q?bg95owmM/7WrOo5ZjbOW6P2NhomhdPajrcHUZ0daaO+tIZ0sdiJquyvRvpsP?=
 =?us-ascii?Q?jY9ler2mVlmbU2GjGLU7lT+tmKQiaCgptxBFBo2kUoeaDIkstJp2Fm72Lvdw?=
 =?us-ascii?Q?35xQGT1l0XorEnA75J8uqoO0VEQEhxRJXhsdGgb/8VTLvNZO73blNENMbRyd?=
 =?us-ascii?Q?WAjUPOzt3Nc31B/NDtwtPA0cPyr8rJPUP0quTo9WyP9xIOe0RUeP4QnpsXgx?=
 =?us-ascii?Q?lsbWT44NQ+eJ0rB+bYwKmUwQCe2eDs3a5+8ayns1sTJUOjUngR1K6UJJTfP7?=
 =?us-ascii?Q?EtJbRRnvQBPwIlQqrces9DvbTf4vQKzo5aY5AhzvmpMnsuBmNfcFuUVWtG3x?=
 =?us-ascii?Q?g7xy06MQH/rE07rVP8zJ7p8oK0AgfH2BL9mofol2MPY08n3MOUUZTfVO2gbZ?=
 =?us-ascii?Q?qvaZGQgKJkM04hI3pjCcsEWKvgNwpExgs2Lp+uQ3q9KRgiaZfuozF7GyUNaI?=
 =?us-ascii?Q?uBvtUtJFns8dSg6D7GzT45lyfF2wFa2QIt494QdptV2VdjHlUu5h71XzpbwL?=
 =?us-ascii?Q?j/5N6YIZH+0nhgjVWnx+6Pn4Q8J1ApEKGVDYsgWAF2WstuIYhKSZUR3E/QhZ?=
 =?us-ascii?Q?X2qMG6uxOgaR5Et2uyZEdnkRnSr2Ri6+zjDKYBSzpEYd6b/Uyf0O/40mtv/H?=
 =?us-ascii?Q?3R9XzPSbQ/6XKpwxAuHMPwG4v+bfpcaLDHcYW3i5GkOalQuxpQ+V5HCKnZAd?=
 =?us-ascii?Q?196Ri0TeTI7K1vi6bkKM/iEaE0IJjJAmIi2G4Ui1Bm3vGogsWA3zTeJM+0Fs?=
 =?us-ascii?Q?gDg8q/0IQEBjM1GBRJZGJy1FwXsdzs4GpG21pwANLigeCi3HcGW2AvF2mtEL?=
 =?us-ascii?Q?QxyVAwuey+7VTkMM6NkvwDJd0yhPDD/UcuJ47oOo+y3Ity4jnsXKSgIv9BN5?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N2X7cvISDGn0LSYsKWI0dQHo0OwPANV9O3Oxp1IUwMKuyn5nfisdISby9q9eWR9Gp8bjLdEgXGw1T5ympXVBDW5y+hGTUZ2y8zqQYoj9KhgJl8Ql/E3hZpGxUtkyk/BNmL9nQwNbJ8xOavsyGSk7qKXOEI0NdLhBxRAQzWh8VI+16tjyRsXJURaw6lGigCXgEio9K1lVIA+wMJ9yjwRM49HxvIkN/Y06hdF+xBXHUe6HtegpaLlOnBb98frjaTBob2XprCLkOVZ2ql+8hdxVEVB0+3XS5KXXseafMgwiCKaFr5HOFMrFncGS6e7WIzdnxQfRfa81juL+zZZvE6ipYQC/Ha3Es69+0oYKF2hx3LOulFWM76LPRPxoTFFz19V+YLNpmDXCUUCkN7BiDV+2lZauLk8eF95R4bx2XlmKNZyKs5IzsB3SG5nsmDIiS4sugoCb7JR7S60YWR5YWPIVCFWHxM3rmyUMmRZeKbUmTclr6/R9Y8KjtcEa+yVu+Ob6/1FKqDeODs7VS5JuUzLLLQ2FLbIttied/Qx8bt5FSO1Ny93pgABhyfutwAgbu2YouhifIEKl//gZDWUgJmXki/Ux5Sf1719GHG/FxzlSlmlRmBH+KmaFB+OwZ99P/Cqcl6Q6hUoqDr3wkzS/kcfUL0OLzQOSHjEslPIm7Nt/+oBlRi1dMxzLdvJQ7SXf36QVnaQe6T/l6vMItovemsXJfW/mMDePLYZI3zKfyIzlQs2zkB04tToeTzftobp95KqRgqi9/jAtOhm/AbbNnVf4x7aA+EL/pvudrgTDm7EwQZ1IeuLdV8TW6MEq/o6GahZseY1+SBZ45xCZPs3Snly2KQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6414ede-2ca7-4f61-47e4-08daf9ab6404
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:26:14.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp+qKNoCAPKnWAlH/KhFmfEXIqQE5DZ965M9RmQBj2bsCF/Ocwxz5d1soOtmG7ay6aavX1H9xoivvqtZ7/4ae5MH+zHIOYD3AjcsBDHB4vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=647 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180194
X-Proofpoint-GUID: l4mBpbbx10Arya1bJpVzh0spuIZ81bmj
X-Proofpoint-ORIG-GUID: l4mBpbbx10Arya1bJpVzh0spuIZ81bmj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> Add maintainer entry for Exynos UFS driver.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
