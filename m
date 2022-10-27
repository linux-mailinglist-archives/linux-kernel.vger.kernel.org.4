Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0260EDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiJ0CVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiJ0CVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:21:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403876562;
        Wed, 26 Oct 2022 19:21:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QLNlpD022179;
        Thu, 27 Oct 2022 02:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=dFjIindDV7KbFwMrfsXfAgejnk2pFC3bYGQzj/g9XEM=;
 b=t5UXRM7h7oaqDrFzgQmC4VkMGuiA5PtF1QEJEsAn/OB7CwJFklURHpNyXPa/d5tcWDGT
 Umpag4u2eeKKx9BUv/gePZlywidB0XmQIQm8mwo3wEbgziM9Hf5sDa8mjEAcRKF/2nB0
 QkDT4RxgUjgTM5w57phyfdiM8YaNgqOv5TXCtJnCvx76eBpFKrBMBLJJfW01uMyrISsI
 4ofa7jnUDHsccYQ5mN24g7MJTE2KKwuH4A3lB86GRlJR1Xa/GRAqyM1RqDY94tAMFxpt
 CQlMo2P54C+9TpppjjCksenO8+DpbRqaRrNEJhG0dcAGVgYTuuw/+VEawCZ6yZdCah1p 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahe8udm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:16:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM49qh011614;
        Thu, 27 Oct 2022 02:16:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqgnpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJcLWnzRetDCp6GGLdQVh8H4608IV98pap2zeN4GzblPMJUYOAwUkhct0R/uOrtPlu81+bLQnhrYvXec4j6CJbC8JAspFzjsRCLRZ9uu5CzKYkwZ3twcPSAvTyH/BBQhXAiq0lQadl1OzaBggqVDf7bVFTxjxZpp+Kdhp+yOfgPFZMlfoDcuRxYX7bdwsddNV9Zf+Hrl32wPCYhW9+4p2w1hyFFgW+hojvJzvfwwP/G+yXeWB29ZyB0fhtn6rxWwzR3MpDONtglzy0rSDnnVP82vGxkN/ARYQPmeYvpvGCi9anhnBzlao9nENbw+TkPR+S5ja88ZWASw8zAgI4nFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFjIindDV7KbFwMrfsXfAgejnk2pFC3bYGQzj/g9XEM=;
 b=mt4GWVb7cwZn0wjFAzd4eDgKRmr0IetGleUZEJyJ61pzZUMrSxTRqocvgygXOdL6GSZ2+pvlYIsXKrJJUJZfkCGL4ildcqWlBMTwXiH4nO6QxijWHKA83ArB51ZUqnMhSJC17wff8CCbIWVjEfrbpyKwKYq4XWNO3oXWOO/lsG6fZqf+Tynj2wu2kWHzy8z3iNg3rtOJ2o/hgfnQdEMrkh/Bbfg5XB7QNL3MUlG8Q+4lw0Iz3mA8kawY7yp3h/+oey1dr299jGLj3XL0c3cZV6OW+v6wVz7zXfGK9KBnK5fOoXZ7gX5AD3zXSQqBXYHBSKRstf5txKm9GvaXYNY64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFjIindDV7KbFwMrfsXfAgejnk2pFC3bYGQzj/g9XEM=;
 b=C+170uyjfYOL+TpLbTYsz8nXvsaxuzqT30/z7tq5pOVyEDPkk6x4FCqIERfIZ+lbRncbxQ7EfhYJm4zH4UMkrsxlW2thPn4knjlLIttFCTUh0cc4DVviJawrdOCt9ZgSG0feYpkBt7ET41WBD8ehGjy7aE9Fha82u6VhvPgiXck=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 02:16:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:16:07 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp_cs: remove variable i
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu3qroyw.fsf@ca-mkp.ca.oracle.com>
References: <20221024141101.2161167-1-colin.i.king@gmail.com>
Date:   Wed, 26 Oct 2022 22:16:04 -0400
In-Reply-To: <20221024141101.2161167-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Mon, 24 Oct 2022 15:11:01 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 53394790-a836-43b8-d3cb-08dab7c134e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hFO46VMpd/uQadTzHYtov/M44R5oHl9gfKI3Vlj8qHcVAq7eofjSOZwTn0FFrXfk7k6i6kVlmX358T9RtzUeBPFZ7KtBwyzzkmRNiO5RlaYK5ij3GF6w19HbAMg2tieYJ4dulmaiy1wuABfzAatjDFXmga3tp1REdiNlTP+tKjsVCLt4EOwLOEGxYdde4KPraR6c1uO9fCiOrV88FzM3rMfcBDvX5YBQWHnde/SLcQhXaeBeSXgUXw+SDUgUP5fCbQnCH1nyPBMbU5hUViabyxj+gnLA8xNtGc6HVcPru3/t/Cu0wG4vajoTMudPEU9/+AT9jxKihacevyYmIIh1RTP18fRIT2Cl7ZYKkzZ09NGqqUN6lSkHqQxtScfbTrmDQVL6RlwJ/kHYiq6hMoCU6qCmYCJpD3pd3p29NiFIDw8rZjm3T1YsINH3aOaQRiLRLVBJxKSbAgEVFOZdYY3N70JeTwgk0cWBuWFnPzjkinXUn18u2rIAUVAZKK1Dv/Mbm1JJ2o8mBZTV+0ELybVWMBlDxKb/WbPSfkMx7sU7EG6EcDuWY+6SonWpDfSE6r/Rw0pQaloK9CtjbiCEifGJwHY9NpDYUMiZSs08JF8KLu8Q1/oEy0XYXWAjAPMNR9AJ2GG9yFZBXfRUlY1pEwayAxG0feF9R6wmYnCB6XuOUuVDW+OOLVZWHpqolQUyU2CwBiMrWacfVoPQoX7ewf/M9qRyy7otBWNc2Kng50LsPci85+cqKQyWdtMa7PQLiyyMDLQt5N6xoX92szxv+rS1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(38100700002)(86362001)(558084003)(8676002)(54906003)(316002)(6916009)(66946007)(4326008)(66476007)(66556008)(6486002)(41300700001)(2906002)(8936002)(5660300002)(478600001)(6506007)(26005)(36916002)(6666004)(186003)(6512007)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvpjwbDSZTsqQtyaqoSR7vyq/MnkjBYSIYinqry+btnuXLZCjeurRPk93oQy?=
 =?us-ascii?Q?7m1cHOzDNx7G2BsS7d5d5wESkGKiwwKcDrIoBPdNnInfzopY7LF5DkUWNmaW?=
 =?us-ascii?Q?ldCZzpiE99wdz1pgW8q1V6sdxdlogR+7PXWnzqlcRE8xNo3UExfi2fa8AjpJ?=
 =?us-ascii?Q?vf6mBUtVSz2sLWIA9PZPjmARZCdBNhtOkbWTM/N2qkbVSGBs+xvrO68gKXiU?=
 =?us-ascii?Q?Bt86uedildB0/d0Sq+sFqEYeGE5OTAbw7KSDiRs/olVopm8I6VBdYQSV2YOT?=
 =?us-ascii?Q?yUITC6tiJt+0IMvg74OXz6u3DXtQmriF5r1weYgUlneqCAnpQoQK8zjyYPtQ?=
 =?us-ascii?Q?czmKSHlFwT+PhjKihyOTKBzw+TP0RZ4N91+WyzqnFD7sitGFYSP8S9h02IQu?=
 =?us-ascii?Q?hyvEySfLJokh4HvgcqPmIJo0cp9GaxyV1IR6sJKgY8Bkhg3WMDfAaFlCl0m5?=
 =?us-ascii?Q?aKPMJARDhrtagVmMFXYyHHl3AJuQ+OG8ygC94w2NC8yLulh1p6fL3HzLEiAZ?=
 =?us-ascii?Q?mwfwJa/PcVM9pJT3+01w0wPjfwM6XprM5VYXPifaNyXLew5NnNunKdr14XR6?=
 =?us-ascii?Q?WHWjIT64/gc/JQf2BXlrQgjLTTc65id1+l3EQ2IYiZI6y8KSvQXPMEkXrbaB?=
 =?us-ascii?Q?OTYTG40QdXNnRdXSlUblmtwOqUXfLGpfYYX2TwGZwfKXL2HYHyHuub1whvhe?=
 =?us-ascii?Q?onrV7HeEJ6P0F9UsR5onb2HZ54xHepk2NbBr+vLYdE6N8ihHE/JbgMmKgr53?=
 =?us-ascii?Q?K5YOjaRC9FM8qDIHKPcTUuQ9iIiLj90bpvjERVt2XnPHMMqe8NuSKH8bKoGg?=
 =?us-ascii?Q?/BWNaUfQt0T+ZHVBp8Ocvg4YiOe+U++TyZwKqVtHzo/SdHUC9tS5oV6HfF6L?=
 =?us-ascii?Q?RApvj6PSxEpH5Y74xSNFdUAugwgx7taF6LgjU55cxBXxM/M94RMe6E2np1W/?=
 =?us-ascii?Q?1X9QbZFEF/BPqyY318dK2rZTmaI7UQtxleUOJZ4rLCWkXbZfbpnqqLrUGxJX?=
 =?us-ascii?Q?MrHGoAc8XF26raZn3YHt+zZKU2I9Any9YPz0xQqKxq5JVD33vZxIyRrljJDF?=
 =?us-ascii?Q?io7PphK8oMmxX3z93OYMWpB5eJwnRJd8/kPy6/wFStUdNqhbLt3ORcir1E4J?=
 =?us-ascii?Q?UFxHgka47f9v7vsjOSJbkdCG/SFeFAdp+GbtjfKaUK5qXawkaHZXHOXl5FAj?=
 =?us-ascii?Q?NZvuHiCaICAU94+2l+0cXq1bfVItMpRVNv1FlmDduYdOe9v0bYQjT/DEeDLq?=
 =?us-ascii?Q?YB7UjVMMVkacyLSKvlBvNcZwg6nBcZUR9BsRtNnAoN4LKK3rkULRCLWjSl4Z?=
 =?us-ascii?Q?F/9P2U+AEi9bjwboDyK+RLmGsjezsCBvgRT1erFhcRDyqYXGDsY+/8O58RCl?=
 =?us-ascii?Q?3327DbTaCGICyGkUu0kheqBYstPaUSwdYe2YzpW2kypOmg8M6tnbUf38pf9l?=
 =?us-ascii?Q?gHNlygJut4c4DVTnn0sTyljnEp29agx8HPGP2fa1lGMEVn6Zb7QPpu1dyYxt?=
 =?us-ascii?Q?Pprt60euXDWXMVT2Xd3zBbuFtZh8ZiXd3dMqXx3mk7E8rs2bskm73r0+hRL8?=
 =?us-ascii?Q?u50VRUvjljV90F1AWNldAh/F2P6DwvQmh7tdz2kI30S0vvJ2yPyTUu6m+jun?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53394790-a836-43b8-d3cb-08dab7c134e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 02:16:07.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzxTtRKSaTO7Z85KCVfjHqDEgCmy4FZzm3IGEinm6Re3mt/PuMQw7ciD4HPAgfKHTlkWXZ8NC/b7bdB//kreJ8RUEweFNcqzAKsxNvUrUoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=849 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270012
X-Proofpoint-GUID: drH4S0WhGKyNfBFOPDof9UItApmtFst0
X-Proofpoint-ORIG-GUID: drH4S0WhGKyNfBFOPDof9UItApmtFst0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable i is just being incremented and it's never used anywhere
> else. The variable and the increment are redundant so remove it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
