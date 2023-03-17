Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2213F6BDF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCQDJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjCQDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:08:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E207432F;
        Thu, 16 Mar 2023 20:07:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H0dZdR026779;
        Fri, 17 Mar 2023 03:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=B3pNqf2Mh7y0iFSkid/+HpilhquYmOHaK09ZnkPwpRs=;
 b=DT664JwIjMynxEiDePGimNBdLyrkAHd57Ba1YftVSCjkVPQG/NcPFQbo+cvaGURWt3G5
 wLZpOPR+U+Z2PSvJTe/DS6KXgDF8T3W5plwmcCBQt9TyBKsUTc/F8XTylwRw6hdDwmo4
 M51tGO4edysM4dnpYFOmSEL39hp8lgx5QwJboV/V1P4HGWcVvrfrezgID7f6hyvSt1r/
 XbNTyXfWsiJEZwpn/56r6nL96deznhc0/Yr7Xmn8skcviFVycyrshY/keaCr/wKeWinq
 TGjnI87m8r2MdmhYupXMvFX7YG8OrZzlgiYIuLJM27nNh7ja9ZmF5WpukANCPF1KDWN0 uA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29jxdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:07:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H0VZQ9029615;
        Fri, 17 Mar 2023 03:07:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq659uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVV+d2ZVhKGf4k6AjEY5hT94KJv7y5M8wYG1cWLzXp44fNCr6CLgBc6Gl/ewoZPSMXD1ywiC4lZ22RZA3F1G3CrVbNK0DLspEqsVbymlhQ0vkkhhOF0CZrL+W2cTky43Txc0RdLBESeQE04X67cAg9lf4Z7Sst25+I0lfdLGn6iQnCdH/rvYaFQ2pjG6x0Qi9dwE/QWKZvUHT2A3lfH2ULlFaD2HwJ4E6ocBxu59UTX28sMmraWtYso9S3AYd8b09lRRKnFDlTq7cntncXr4I/RZNRzd3bJ61RCRfilD6npqRYC6zQpHV3WJTZ0v3oYBYe5vGxWfnQR3mQQYvDgm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3pNqf2Mh7y0iFSkid/+HpilhquYmOHaK09ZnkPwpRs=;
 b=R4Ie7bTtoUlJ2AyefCuYbqZwRpORWk+BLCVZML3JsYLNXqwdFOjCcTtix+el9T/ZeNTnoJTh8xDmKIhHvLBy+/9FIOti4gEtTqOZk1MuFquhofWww9Qr31TN39LmU4GYB3iQkurddzVWtQix7335izD9RjxgR7ckXAjTPsjfbBQ7yHrXlHtL0MxXZf8PwnGmPB4gaHtFEU2YlFevyg7Ib0JpjoDbUafobCxL58w3OEUCXPk2CARCZTyhEjWUA8IBpiaYELHGrW2tgEZV4d0bey8R17EdUURZORNfHJ6QpXNdIOFV+EmpwnDeyZ7Xg/P82xmj0Fy4MSltyvbv7GEUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3pNqf2Mh7y0iFSkid/+HpilhquYmOHaK09ZnkPwpRs=;
 b=nzcKSgFANwi94JOE+pIpAve1O61njR2AUy/Mcii36qJ9JoGfisrBkZ0HSYX4Z/zPSsIOHmlx8BbDt1u21teONJcTsamyJOzgoOxNs4i2+D37C78kcxAkBApIfzGJ5i5XaIM03Wy9LR81okNSJpT7vw9sLqvz+anZ4jLuxGZ0LpI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7119.namprd10.prod.outlook.com (2603:10b6:610:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 03:07:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:07:07 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: be2iscsi: set some be_main.c variables
 storage-class-specifier to static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsa4yt2s.fsf@ca-mkp.ca.oracle.com>
References: <20230314005157.536918-1-trix@redhat.com>
Date:   Thu, 16 Mar 2023 23:07:00 -0400
In-Reply-To: <20230314005157.536918-1-trix@redhat.com> (Tom Rix's message of
        "Mon, 13 Mar 2023 20:51:57 -0400")
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ac8ba9-72ef-4b55-a199-08db2694b0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3DVyl9NHH7PSm+MDBGag9vsyXSvG0o4EMGeGS2++1Zby9TGuhavSIcRKMz8c+CpDekuufgEdaYpdS2PPNcEOlM7zDQSj1+dZplSkf7JfmLDwa7l2LxiAIKgjTJTQV4DhJyA5AcbKPevY1iXECDxUESR1i+oIbiXghRBLcgoROJKPJhnjTAKEZ17weLV6KffDIEejHFMRqfzk9hSguSkE2cwPWRh3XHk7CsM/k+mVc7HfggdsLYt5gVYrlslhAlO4ZLpzkVrx95g2E9laB5bk6cf0knYszF/Qe9/+WoQbB3qW62c0KJW+ljqdv/p7uoKljBzO/BEGEuPpgGV6jL5g+y/MtHq+ilX89OCi4qjQYdv16qcOT5A2iXkH73QNzs2ZATspVdQQVFF1cUuPGc4T6RWKeE/UpwHv4IHf2vIrzTvh9F3rLW4JBA9Cj/r02FAb0CkTdQxpZPbKAIOqUvxhnk+o78Ei5UTCBbXKLHc9jOlPWayDlOykhDWpdE1by7bKFsxF8ofO/sc7SXOlokVgxArSqDU/ItKSnzOdQxYy8+wpKXzTi7S5QHvl2ZkWdE6CVaFzet9fkqA3SJm2OqGpXkEDXJdgsw5dGzGOSLtliESvXOqRgBOf9isI3lOi2Zv3Bxjun3AXNkvZYQRNttQxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(558084003)(86362001)(38100700002)(66946007)(8676002)(66476007)(6916009)(66556008)(4326008)(41300700001)(8936002)(478600001)(316002)(5660300002)(2906002)(83380400001)(6486002)(186003)(6666004)(6506007)(36916002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHuNn31Uk/iXAslKPLullMl2pXvEgUWJE3lfx72HsTxiqj1KCCen0amwnjxZ?=
 =?us-ascii?Q?tjfzlq6Nnw2A8zRCMtIVHLdA1ephMTb6G9dm5sklwh3Ghf/+h4FB0TjRre11?=
 =?us-ascii?Q?PyHP6+Ewne6M+fM5RjkFmmFshpJuRcFDZQsIiorLR9Q2bAZx4iiIpJiZ+zvo?=
 =?us-ascii?Q?+WNxKa809r7knePOg90/Uhxtk0bdwnyU+IFis+SjX9FU8vul3B9Ky7m18Q1W?=
 =?us-ascii?Q?cWPiWCqUe5XulN+hY7lEuYtfj8N2XOzZGZ2GaHFjR5X7lRxy7EY2PJvojjNQ?=
 =?us-ascii?Q?k8A3vsxP6xMvoVtApDL7NfkRwHN0wkSzOE9PFhQevucGcj4j1OjDZtZuR1sY?=
 =?us-ascii?Q?joE2E+zUduoEoU2PL4tBCUWjYhfrIQAFZUG/AuACcm352w7uMdlwmRIlaa3M?=
 =?us-ascii?Q?ADrPzlfZin2/w7eud6i2tSJTQxa/pt1P3cz8S/rYN7SSkLogvVF2aNep++7n?=
 =?us-ascii?Q?gqG8Ah2pmLWivz+fhQOnf+YANXYjEc3lAL9GFaLDC7MB+Hh2ETBHCd/zmOpL?=
 =?us-ascii?Q?S8wuFeQB5VkZIUcrLoaUrm3DsWDopOC+wThY6lJusriWp1IOLD64s5bi+j9E?=
 =?us-ascii?Q?34MS3R60mG4hMqYOZ72Lo/D1Cbm/UaHElmVO5sy8i5BjUPc94RGHK9cj5yNh?=
 =?us-ascii?Q?DWptv9Poh/ubJRO3A4W8dKOpEBTvuJWt2MXH9hRPhc2DZxUHzHXauJdFij8J?=
 =?us-ascii?Q?db1EckaEui8jrzV7IPH1CKuFm+actl+cY8uSxfP/wa2WA7X68BI6NgnVzpgb?=
 =?us-ascii?Q?PoJpScroPkOuB+CffHvNwQ42aGjscuioqDxgL4izoVffYHPDnLKtwcVk9fAB?=
 =?us-ascii?Q?6axNjFu8Ke5fkS2a8J5+M/citYJX4crmWzk45mzhFMK8YimkCyqWjoJCf+ww?=
 =?us-ascii?Q?cnUODDeoSJ2TnoFtvdL1iw9vmF+6OSjoBnt3QjJmUTqmzj33dHQ7kZNfMdZx?=
 =?us-ascii?Q?bC9RgUrad1+XxiJiI7OeVrDumAzSL8T8RF3K8c2co1/Qtcxg59Y3rk1pBjK6?=
 =?us-ascii?Q?a61OyOCBYPe3hs0h2mrCkHnK+WNkDJTiFtwLtKakxYU5nojIP4SI5JM916so?=
 =?us-ascii?Q?0exBSZREqMF+oPbE4Mjn6V6yUpxSEumPp4Wp37Hxjld2NcJcU4scCuyRtOxg?=
 =?us-ascii?Q?Xg7yBUlkLJpuDxGeEVO9AjQQS34/Lm1Ln8emRu2rdYFtVMucLioUIKIAlRCF?=
 =?us-ascii?Q?pAa8SuPLNdOLdtJLNZbHyrjS9DVochxBwpCFKDHVHhQLx3DXou9Inwk3IdU+?=
 =?us-ascii?Q?wAKlG3GnyPl0mMqJuxIIYkqbb3XshY8ZcgtvK+9R3SoJPWg3QuQ4KQ0cM9XU?=
 =?us-ascii?Q?LUAw0K8yEkcqx19f1pDgp/OW4I2l9POQ6l35gxLGjHTSrrCZe9myXcPrA8mb?=
 =?us-ascii?Q?5hQu4nk9C6aoVhq4mAHb7ce7ubugK2/yBCJLw4W49oYV1zqEdwki10/3GErP?=
 =?us-ascii?Q?kw6s5yyvcBlnyaD0IrprLQ/jSP/ubxjMvZlrI4WKTed8bG/kaJrX9yZExPkI?=
 =?us-ascii?Q?mKzO1auAJ41bT2D96lun0wM+lEHRxqbPJIFDFR+0PgmyIBcWBdcbkQ/1oVJF?=
 =?us-ascii?Q?zSggwz1S5OHc7mUh7zAa/XxpJKkAyMpQyDq4HWFCVtHLpBEhU/o48vXGm/N2?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PDZBhSdGc3low5CrkSoLactwBPv+WEUGOLfGr1sCJYY9BMOLQBsNzKPnNoMcE9eBbnWSSWBBGzZadZRJNewt35pitSyzNh/5lLNiy6zjK6oPYV+Fsc3E6xBcXesD4CoPOGrk/19dcsvzsaRRQIjgDu+1Zr3lxRE4UkgDcMbb3KDL/OlKzKKx/TyYA2bmG9pj7hiTbPLNfL8E78LVQvJkd+b68tzKJzTKYi1vYNQ/fCh1D6xy2eQqoMlrcJjm4fA3UfNKK0/3ZbiQy5fxEwuzx+piY3z8cKfrh2SPxz5JzlQVbw4DyrxdP9g4gmlDfWeJ6TPNXSwdxkzM3GvE3VL2yB4vLXtm1ChRg9wvLPa9CCSumHhfxd+3tT8krM8i5UKEDYObP/5nVaD6iIWtazwJoXtieYbxAfSjTeILAZQQShkCEGXbMe9XyTZJ0oPp5uuHiblaXCte7MRCWYaZD6zoHIEKfJO7wh+SH3Jd5SxlVWiv76ykL3tg2NLlgpg/wrcI4VNSVOzafT8du5dbo72TJRr/HAVnsmeOroEJQ8B2ezOj9Pl7yW+0MGjXdHpwsyzaZaACYMI8uusLpXdedHRUhlT1v2tnMi0vLsFsKY4/rTaBpW/8oOd+2R0Ix7bl+FFmnfyMozFmIv3i16XVifQnNwFf1/UIAn4cLx53QT73jhc5mUqgJmRWtNxf6HIWCKM9ozXTMh977advJlvu1vw9udCEiP064QDRmOAS+Ah1KIBw4Ly6hSVskR+kSblnwAgU1W/nOpFx9dhHp6G3ZhJG5WoakUVJvQkAoAiSh5imFK4/E8ZWfK4/pUXLmz6K1uP2xyKHzblh15OPDju8ajDxVbuENE2KBebic4/Rje+bguw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ac8ba9-72ef-4b55-a199-08db2694b0dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:07:06.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW8FQki2zUI4D5+4aBMGlbV4MclsPyAAuwr4C9nl6kXwtGcDSgbAYseMHVldH4zFbcyUT36Mn0y6Y4PezCSwEz5w+tfAizVKoi4JTOdx8GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=823
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170016
X-Proofpoint-ORIG-GUID: SATdMkCIN_zoDnLDP2T-JWu2xHrFA-G_
X-Proofpoint-GUID: SATdMkCIN_zoDnLDP2T-JWu2xHrFA-G_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> smatch reports several warnings

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
