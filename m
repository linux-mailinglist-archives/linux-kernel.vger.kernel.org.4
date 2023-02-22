Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345E69ECD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjBVCaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjBVCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:30:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF5D2CC5A;
        Tue, 21 Feb 2023 18:30:26 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMhqs4009051;
        Wed, 22 Feb 2023 02:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ccaTEjY3z9tS8EsuFpyt/ywhpotDVTS/vf1T0X1zh84=;
 b=DbZKETYSGqyDvb8CuYvuMW51gua98IaIcf0BK50QZThVUG94OWBEKcFhtGFfgxYo8ZLQ
 vijn0e0x5K9RTj4vWPJt4j83hCkc31CGYv5m3ce0D/J9xjrnEx8ywWMXO42w+cpU7/fo
 DwBaL0CAMWZskHYghJ9ZXqirhsEHEyfIKtXdwou9l0e1Zq/28h9rPjWP1oj/eT5iDXof
 MGpzJiE8M4PUdDz7vyhdqa0JufX01mgx2GoHT2Tpl0jxS/9X2x7Yup1PutJTzaY72xJ8
 s2Mo3EMkpwnmPAlYMwV7WHqubmS/BJEdlnAwNIRQ9oXUrVivGK0GAUC9H9rAwgXxBxqj oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3etkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 02:30:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M00sgH006939;
        Wed, 22 Feb 2023 02:30:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4chkru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 02:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlHQZ2pUKGFfNdLTNHTS13nXVCy2w+6PMWUqb9rThNXKPjDcwaZOL4NrcwCp0WXGxgqACY1NkV6bsfV8vTpkLQEmNKUyFHr4cXsohCZWC8kHY43x5KMYqavUWiximV3gzSgBMf2EyZIVKkfZMTUXus/cjUytas5hIFNRY7rQjYwU8Uu4IfOiyfrwE5Uk0EYADDQnXWnH1naYeDG6umFIzMBdgWjqvP+1lQQ5RfFDczoC0smqA7T1cHykL9l/9ggbmR5JDszHJBPt+kAGhtEV/beqI0O0TQoAyEgyYEXmHUxSSiFMmxCHUCD5saxg0YetN4BXaTXo8xt4qn9d40LWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccaTEjY3z9tS8EsuFpyt/ywhpotDVTS/vf1T0X1zh84=;
 b=KUWtRtzVpq5PcYTdAXJYMfyOGdpmdNLE4c8tyDNB10b3Nal9FFB3nEXnvgPSZrEfhH19ROQfHQDDmUXxWfWUtwm/yvgZvHy29pobzI8Np2hiodECOm5/bZwU+H+IJxa60z2QoexfRYA2IJdHzPocrPLDkMaPt0Ot7cFmldrdLPhyM3Yv+yVQhglYlsb7z992xiZOAvFFl2zM6e988seXD7qpgxNDyQug0tdRaxgRfOwaVL04XIbLiNH99BD0McKZXWgv0EkHpJU524DCQ/LGuRcKIy2kHXep3m/T811haXcT/t1PioMcw9NKYJIBPE2QmSzDtiF8Sss7UGaFRc39pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccaTEjY3z9tS8EsuFpyt/ywhpotDVTS/vf1T0X1zh84=;
 b=zmEozSU+llLjWLL1rGpZ1KcpIBLdO8TGm327c/q9RJVlJ61KQT17Ugg/ahNapBhRggP2pLE/EtsA2dXtzcWZkmdMuRynRy6db5pnEOxnJtHSZI7S2YUfkWGZGNI7krA8fYcZANu860u49y30IF0cinT2d2Ap9g8T6RMC/1tm44s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 02:29:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 02:29:57 +0000
To:     Xingui Yang <yangxingui@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH RESEND] scsi: sd: Update dix config everytime
 sd_revalidate_disk is called
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cwaph47.fsf@ca-mkp.ca.oracle.com>
References: <20230221081026.24736-1-yangxingui@huawei.com>
Date:   Tue, 21 Feb 2023 21:29:55 -0500
In-Reply-To: <20230221081026.24736-1-yangxingui@huawei.com> (Xingui Yang's
        message of "Tue, 21 Feb 2023 08:10:26 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:130::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: ead42cfd-d0ac-492c-cebe-08db147cb0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omG+3AeEjhU2MXEoBnZioaQ7kiJn6RpZkMVihdv1kRvD9h5SDHgBDemQk4lOvnpShEIfPHI2rxbz7TAhcxpsdAT7qado+rzmtzI6fXfsx0/0MCuYiT6EScyku/6gSjAb9WXP1zAYBgXqZrF5MzHyfMNdVSbUkndbaYcC6HmecWPSF14fknBrjhMUvNeVp03iwxUkdqeOBAn/jwsbzLD/SWrFQLBBBnA39l0yauPMzIyqmSTP/y6QbZbd77v5j3457RU8ZjDtuSubJO5MXhVhnHQ3wRZZ028vvWKL96h6P1izjIjr0jeN+cwUsCO8Y2X04tEffXs+y7IqadcUA3QHJs2SuTnKtaENNqQd7rc2uGcfZtg2LaTA/0kVX/UhBJYLSUtItdsTgkJTwIwUvJF9puTh+n4ROrfOsIyHTdb47abFpWqal2fl8fRFmcwBTPdJMbp57plo5eF6SIOGbFA5thUU980mzNvUfV4/kBj6I2E1V0bDa0k3c3fUe2aiIAsrV8Nb+QGFGf6sgoxgh5QL245rs7ZA7/yiV6s+Rf+GjuoLnNr52Bk5xhRxDpGljv0hgcptsUYcRx6r6vP6VvzS0kKWDrpcZgXAokuFFCI0XkZWaihS01N8pVCfloVpas+TnsmBkkNtfl3dxkX2vGH4Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(38100700002)(2906002)(83380400001)(186003)(6506007)(6512007)(26005)(316002)(54906003)(5660300002)(41300700001)(86362001)(66946007)(66556008)(6916009)(4326008)(8676002)(66476007)(6486002)(36916002)(478600001)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVpt2QyuZSrgoOLDo04zoY4O3TV1YysYV0Tk8JxVyS3G3HfH0TOtBtUpgf2u?=
 =?us-ascii?Q?xUZPVhir1/qHIp0uus/YpVuJdXIrw78kcUPUbvGPDBmXG0iGDx97KmXmWx3i?=
 =?us-ascii?Q?Ln6GEKx6F8xlH/Tc3jfx4Y5gCH1n6vbu/Hlc0DZ1DSxfESD74QwpX9njJJVt?=
 =?us-ascii?Q?cbfSiWgWjJP1mw6NVXbxqmexMdN7MXcHQnkzqhNekzCnYWi+l3RJY6E/CWkq?=
 =?us-ascii?Q?5KPFgDWhiW2QbwABm4g958oDcnFvcakRN1xbY1cQmC1TuldVBPbqmWKhiLyy?=
 =?us-ascii?Q?mgjwXW8cnToZo58xOIDgSiYFykmdoW2mWO4WZvkNZSbVnwElF5N5W2hFzPiS?=
 =?us-ascii?Q?MYFnCTKm0tOV4nESKMRFPye+2ohOoCzLHdnuYuZK+BWs5eJOtcN9TpOzrDFW?=
 =?us-ascii?Q?z5Zqm5J+fA96CaluDFoGdU08BBzJrc7CHc63MpOgGa2E2zOf6l2HycFWAEb0?=
 =?us-ascii?Q?4pRR8xphhV1LgfCtQ9Zssl6FR/JNU3iUOI3EFoA+scQYXozRINQ/uB6YgqLY?=
 =?us-ascii?Q?4Q56h9rQZTixNES84cW26fqJj3e5+s70MWWUSSjyno7s5zZEm3c5kYF0id3M?=
 =?us-ascii?Q?qDwS4YoPwvjqJrZY08wnREiXexGRLzdYPR9HriQm8TnFdwQ3yJRA3nv8KdnK?=
 =?us-ascii?Q?88QgQEbCJQSVXvuVS2oZpNZsf4bQZa0+7ksKuvmZ0pgUbCsjqxLG3CI0LzTv?=
 =?us-ascii?Q?Towe+tXDZWMhJx6DQsIIfbfbvEhJD8M5VMt31vlFJ92uSx1a0IXQjzRMhmRL?=
 =?us-ascii?Q?NAVUCJbhTimSn8ScnHB1IWVFmNIVuW2HuN5Z4/SDWTcn1AkxVfYkbk/xSudm?=
 =?us-ascii?Q?TACS2jzw1HRVk831h2FEu38pWnqioh/gGqc4OQF/2FrFmzmSG03NAJnO6zeP?=
 =?us-ascii?Q?8+RFZga2e2MOogE3gt49+aVI6fmInJavHvPNATDer3e9B7i39LFth8wnK1L8?=
 =?us-ascii?Q?CjxzbrhFYWhOJlet6rx2kHw8QQT5mLCG2wisYGgqJcicMyy5/G+BonXFrl/I?=
 =?us-ascii?Q?FxW3PEEY9QU3wfaOWzkSBPf1uFB7KUvFuQ83O+KLNl6NnQ+Le0rL0zXQTQoE?=
 =?us-ascii?Q?7F8J0G/VrdaZOFY5oLNwASKKXakA7ibDiI6rJb7nlGLZhnHHGSalgwrarFhA?=
 =?us-ascii?Q?dCCwoW0MMGfQjpqZTitwUHf6rbFoMg/l8EdYnMWfpBdICgLz6OHeAIbJ5lvY?=
 =?us-ascii?Q?Y6vhSG0uwM3hywlPN51estPLuro4WSA/wkPxBiNh4bWW43QHajRhAbLd/34Q?=
 =?us-ascii?Q?ODk7nKYEnoxGuF1jrljwfta9tfu614KhTINC/Wl6UvCE84iiMPpiNSs0pHgj?=
 =?us-ascii?Q?tS9ckWlMBQI7hCoayKT6bDhDVHpvO8BZytBMn5Cj6SohklGQ9kEFz1zF3wDI?=
 =?us-ascii?Q?YJfxB9XSJRVfMfLN30kHZSwT7vQeGZ/57UD/T54B6CGVIbQPZvZ7GR0ASKmf?=
 =?us-ascii?Q?zAfqGr8VnGZSmpaS+4lNXE/wPpOVIdA8kRilCOybWB8bw5rmq5T3fJtwGKNv?=
 =?us-ascii?Q?+kVQ/JSnMLMT9fhhLE/azd7e/UFJRP/DFq0UzuNWvm0lwW1IdBACbZ1GYOxE?=
 =?us-ascii?Q?HsEo0SJ6qNNn0bKnAhR+zmgU6MiFcBbSr0E46lw13m5cNJmPfbA5IebOCY47?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2raB1ZSGMp/zXh8rc09S6lH6fzBkAC5h3uJ2cefEwNRMzJIzOwMdAxii+9CE31dNW+dK2hERcjiiHSuzPl76YRHRGhv11p+sAu9plDtozXHFs7exnSoG29pbtGlS9QRd34DgWEB38LEzVAuo3+eJr8QvVD0/3/XDtcWWDM4KroB5/n5tZ3BEoUkGHGlB29Ix4Z/KAG7EJIpmvIDwLTT4SsQA/5f1GoLCeFULUIIBL8+eeXo5y1L+rCv3omlj9vni1Erc7EILXjGrO1sTp7DOZvEfjy1D3kdTh83edtH1Kd8EOQGLZ1c+OeNw9Lytv3XWaNxQIqt/ZJivO4JUYcoMDYZSGFowux6+tKp9fTdpOhi1U6Kay792T8VnZmiIBlTCPKhXSdz+z2524EHNKTzAI5UEdTJqZ0e6FqJcFmXMmL/FRyUfwINEHCMcvpgFLD0FcSvUAZX390ROaXuX6nt54Hd9gdlxKDT16fibj3Mvhfe8URNHYjCwPqq2HYFvouwPg9s7RoWFdeBDkUK8G4rFMLvR7ILXHj4iJouIYtqtqB8foOOxmd1HqQhTfPJU1HFWpC4vLxsRkJO2gXDVeYEO2NVDJMFbcmKGeAE8YkPHwklJMPcqMdMvXDV6O+hA4I8dfqVQB4fzcaxL552EdghOHw7Br9b2KnnhvKqPEwv/MNc5o5xm1VyPjG6Y+xSnO920ef+uEPOWVd7YQWoryz4+iTUq+00DOldVfPFbZs+EUVFc5o/pDkOgYcLJ+IWjvFe11b7HQHni1ud+AETv3Y8J+YDKlrGHrKOEy97HSBkc6eAKadCjRllA3DctpxzKTekhuEhc6LmMSWnq5Ar9cU/Fa31m+J3sZDk5GPVpOxopveQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead42cfd-d0ac-492c-cebe-08db147cb0a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 02:29:57.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR3CSth/ITQx9y/plc245FIF0aFFO3ew2tRdC2IJHMHEeEm8e1Q6HpY7arJZ4hLi9pe0fX5BLAnN2dbpK46NCNV3RCCjb4nQ9Ms9rLRKgdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_14,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=936 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220016
X-Proofpoint-GUID: IhTwnHJZD5A7Oi5-gc9inpCsDW6nWxi0
X-Proofpoint-ORIG-GUID: IhTwnHJZD5A7Oi5-gc9inpCsDW6nWxi0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xingui,

> When the host protection capabilities are 0x77 and a DIF disk is
> connected, the DIX and DIF of the disk are default enabled. Then if
> that DIF disk is reformatted as a non-DIF format, per the currently
> flow, the DIX is kept enabled which is not correct, which will cause
> the following errors when accessing the non-DIF disk:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
