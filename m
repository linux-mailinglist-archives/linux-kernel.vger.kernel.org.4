Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424DF672CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjARXtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjARXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:48:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB3677A1;
        Wed, 18 Jan 2023 15:47:37 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmvXb020595;
        Wed, 18 Jan 2023 23:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=JCIqkHlkwj7Sk9i73MkaS1D/wu7Bb7e8fsVR7evOAFg=;
 b=UIo2psRM4WjxYz6RVv4zSVi95xju8BEeGlNg0rMrgGJBnNr1SWSS3b4ofde6+zSJUcrs
 BDrdlUwSRg8UDARk3L4UU/yN7dKOfVxgMRUW28nSEMUAMIYZWHUHYtd9ABkLAL80ahY5
 Woe8AlZZByjwkxVn0/+IwpmmHXGT3YYLdppTBdqrAC81anZUfwYSaQm/usgzfBIeyLYB
 j637fMbmBnahXe4xUNUFc8MzrVLnhBxCEzuTaZ0/O4Z6yp4/6ziG7XHuJvqUyo6rMv9O
 Pgy3Dok1kE0Q85UUsT2c1/M4dUVcOy3sKPR2YcoMwQK+N6MWGeO8VmqAsGkq64P8a62E rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jturwdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:47:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMxaL9016056;
        Wed, 18 Jan 2023 23:47:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r9e4vyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+WAcqX1u6ML2/tp2GHuvOIy9nJ5NMgA4YBl3Pyy+atsN87Wpaqz/1xCkCew1wHZ4ZO0qyEn4+Iq4Rsz+kfzPbe8VF6K5OtrUL1H6BS18AsMEbXiAiKtlIa01coQcY+qMCgYKvwdRgqYrqTtjuRSk39AfDvTfO1jXyjr/1CYNkTgUNxRnYxjwxQRBgjYiqc4VFFUOa38JhxbkG3lCe3A6seXnkPKqdm3Z69NcbrHgjn+IBWmi9JhaXh9RTJpe52sJC2GTgEAPDoFa9zNOLIqy/hSiOrUb4QhsIxx2i5VZzO0WyaGdBgcTSFB+IG/rnsAOMeJSm2kWUdUG9uo3JJ1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCIqkHlkwj7Sk9i73MkaS1D/wu7Bb7e8fsVR7evOAFg=;
 b=DV2BoNjiY+scyU+b/SrtMCJW0Bx63Sz18jef9fJ0NQ9BSSyt7iDsjiv4SSmBezbC+YDg1RGCVLIdiNqQLEJqVIt+OTEFQQaeh3FNIqvow/4jp5qLKA6UcZi5KbI2UFZgXceScDH40md97w/kkySthXS0+NKjr2zAjMFuVPG9rE1Im1fSaA9zmC3nUxvQzXOnh6VFHhGF66tNoC3fM+lUcjLqxKMPCM1JOftef+zqnShJXVoV+ddITg3fYa68yx5lyrv7kDSUC6s9axsc4kSm1DXWXcMbszZVZekwqUqVmTatKjthi3mhrvB8YUuKdNoDDiGBfjd9K9ETpbGKU4rxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCIqkHlkwj7Sk9i73MkaS1D/wu7Bb7e8fsVR7evOAFg=;
 b=KeQx8AePxFN7yvzG7wdJKbBPIW9H68j5tECiXBaw+d7FqXGkrX0hM46bD5nlyF7loTDBE9SGBqfr+YfjysmoGU6oot0CCNJZ02uyo3L0UUhHjypYnk7i9WNZ/Y73JulS5gqbOR9znrUQp8h1wteJoArnjunR7EQX9/r+LCUd6RE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 23:47:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:47:16 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, qutran@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Change qla_trim_buf,__qla_adjust_buf
 functions to static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn5jo16v.fsf@ca-mkp.ca.oracle.com>
References: <20230114013724.3943580-1-trix@redhat.com>
Date:   Wed, 18 Jan 2023 18:47:13 -0500
In-Reply-To: <20230114013724.3943580-1-trix@redhat.com> (Tom Rix's message of
        "Fri, 13 Jan 2023 20:37:24 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 248028de-3d6a-4288-1960-08daf9ae547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BZGChDFCdT3601Dkv2QK7mEm+VxOva5IvmlV4+4KQegvti1gm1UF8bZUOxmIqVk3NXINUhBs7ikM1Kgj9iCcOZMDzL+m+75DJ/NAscBKLE8IBx03ZsK8OuBYGtE25pbm/PUm5di6Uf+cIpWQLpiMMwd4fDVfY+iSnO3N3IzvJyPSXvpQbqQs7IY9rbZHlqagPTcSHkOiFz5UhkvaC55kkrYs27a9xZPSe09WnRDflLDNxtX1QlJKplGQsG0vNsP1czagpe+msEM32vd8V7DMATYgtABeR7LLrXQjy0UX4eFw6w00vDg+Sd2HEBS4n7z5GWsFxYJZF5tNbyPkdDivEieY1w70AEjdY/zEkIMv7t4jr6QQE5FvA6tNV9JsiNBEtozGKb08uRTAsugULubRbetYliD63LkuoFFNBQLvWHwvuY2i5I5lfZEpVuUN4Wd6Lxn3M/0KhA7hMOnc/ry40eKTNmu5HkFAH93XqWkh6OYoB+WjtxV3pCEq8LzDrqgKEL0+uKN7g8klwhnFNVEAB3dZet7G59E8DDzObbyhLYCtn06/D/wA1HCaNZbdalfm/U4RFWKteHZKosDCTPACsyllHk+Wn4I2vWCZTZQ5y6pnHF6fPGB8GLzVNbkfi3shltBRSuPW/SMfzaEeOzpLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(83380400001)(5660300002)(8936002)(41300700001)(4744005)(6916009)(8676002)(4326008)(66556008)(86362001)(2906002)(66946007)(66476007)(38100700002)(6486002)(36916002)(6666004)(6506007)(26005)(478600001)(6512007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3ivpSE4Dlt5XgQZbd0ikV4vZiO/dRuDuJpENVYBAGyfs/Yw264YchyjSjCc?=
 =?us-ascii?Q?04BFZ2L64iR8/7GnDfZ89HKZugUmt1jiOwHwKuxVkliDCMOlaGtm8zXINnca?=
 =?us-ascii?Q?k5GgsNdo+E94yYAYqmBfKCH6a4FppyagfdnfkdAqtfU0VGcarkITcRlBmRxs?=
 =?us-ascii?Q?RAqme1b77P/natyprhXyvNi9ELgp6qLNUvr6KuhaCpCcL8lLTI2FrF9e1kS7?=
 =?us-ascii?Q?hnAaeZ1AuuvwS2l5rUcYPI1BdlLV1lgAi/i1F9uvu5OmhAm36bFOl2x4xoRL?=
 =?us-ascii?Q?JyKNspQk3isaWvKZRUBddJ/kVU8I7AHBOGjXfwIX3zNj/FdtKf1CMxrlrZCo?=
 =?us-ascii?Q?deuYXpeA5hyYT/1zhcM5x0xud7lWf2GxPMPBY+gcKpxi6upE4f+1CeSm7OTd?=
 =?us-ascii?Q?S6u6bvxkomr7pqQeXuWUaK5HPoQiPrzMDQrU92E7tSM5ccA4LYSDfP5Bijn5?=
 =?us-ascii?Q?BkG+0CdWEJpfCc+jIo1sM9dFpu6ck7BxbKouV3PWMCg+gTIv9a/kvGsH0oSR?=
 =?us-ascii?Q?+owkBO5KyCv6oqkH5FMQJlSOxsQLowmdJZUdH//mSYiUq3+0yIOCJjOi8N0s?=
 =?us-ascii?Q?p9kPJzzlz8t/CvnpTiCj7DP1xyhwxtiwcfDnqNuxgVwItMCQms5LTF5kN57F?=
 =?us-ascii?Q?+aQdzBxf/uTNLaf779swhcBVjgMgPC6TwDF3fhfas7faPTHhXVZVIMTFdzSi?=
 =?us-ascii?Q?fMJshmQsBG/EHUBYLBANe4Nf2sN8g9YQaHFOvtXpCa5XOLzOZp1lchGuBXIQ?=
 =?us-ascii?Q?tlVVRSvB1N45lLxawH2BzJ/ull0+NNfTpEow2F/2JP5I8coXD40raIiQlmvq?=
 =?us-ascii?Q?FmAQFjBgeo3zPA8Uzk8i570CO6/792O0dcpIBIuI8rcVDFvvdQa0HeR9WHOT?=
 =?us-ascii?Q?vjYGJo51GwR5WFJLq1YYFP7S3Jn/yxWoA2bgjA/nB0HBvEHX/XU6UEcNtdsG?=
 =?us-ascii?Q?mwzPzBH6fQWKSuceWt5ZyhMTOk6sQsBYSsF8LohMbTPsRx/FfiwDVoEm2WTZ?=
 =?us-ascii?Q?77Gej4jVMbfNkVG4iJUfOkZElSxL9gMVow+ohqNjcYkqqDO79/YfHGnF1r8I?=
 =?us-ascii?Q?roz7kcvID5fwTMCIYS2UkmdKz9aHZTxZXUrRxwA+AR/rxJuht4+jsnboXv4O?=
 =?us-ascii?Q?yAJEr3KVEjzFuc6S7Md2YmRb892uLnZGT8idisT38PZstnIQoyTUJfJsl0PP?=
 =?us-ascii?Q?o2m8uBxTDI4AD3Rr9pOXYxNvvgP6GH2rVYdIFKpPTeX9hzM+wEC7HctrjjwJ?=
 =?us-ascii?Q?8tsOYDwqHvGuVEbxOTCIbpZdrtImxuOzO7Z7stXEC79XMuFAJToz29sIvTWq?=
 =?us-ascii?Q?Rr6zL7CzBikTIKwlALn6EHamNPh/8a/pMncmv+xVZYLAkB5T1E5DlrI7bS5a?=
 =?us-ascii?Q?Tu68yKp9hwrWZVF/vX4C2XDaLMX40/aBk3AJgtmh0FabSHtQIMAuPelz9J8h?=
 =?us-ascii?Q?kbLK7U+bU+mOsGkSoV+l7sTude0tj7UefxCnecB5KQx8Kd5uxC1oxMSKZx1N?=
 =?us-ascii?Q?zXKGEIOiMfHWJBYKZvKGBT1app7NjS/+xd+O0d/7/ogCgm7DEBpMY/4/KEyD?=
 =?us-ascii?Q?3qFuVmMl1ZGIrNn6NoSMSLv09/F5r7tfXp7QB4YfFwVTvXBWLgO/Z0W/9Jg8?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dAxbO489vyFFiRmGEMcOSx5zb6MChp75lle5sJ3DlsuWWQKFTLDuL+yzLqLO+AJCKlHdU7OlBwZe7yCjEnWZ9e1Pg2Faj8nne61564BZSXqujCRhNTzdhqP0H52FWrLkY6DvwI6TE/BCyWv1GtMN1ERp0flg/Im9ajPpL25+SlS+3WcFptmwEF8rxD0YsC3gLKCvDWmh6blF+lDkQav2vw5WygiC9lwTpvwGK39WLAVUedZwHaTDmGiGM9FO5io9zMjP6gH3CXLQ/V5pIt4/Se2eZm16/el7zdK2UTcuVhpyWRHAf4LLUMNLSoB8sKOh3TMOiSZfpQTp2UjkL2f3KGiSISmfp9MMX9TdNwkIxZJA0fqEUqDnG+oGClyCJnycXhNEVLdRX2ftECC+QZmQJmSCwlI+iMBNBS9V8a8bJLExhk0h82z0f7vTXerfoJLaZ9JhLNLtKEqcIg7jJPu5Wlp2J5ocn9sJZZyJnTxdmc0ulAr86ifaupgOq7Sj6yT49Q8biKN4Mkq09UKWuWQoEEh3OMXL6uKaZZgeuVepm1K91HMeDprwdvVWYwX0Ug0fPdzrw4KY9o3kbfkOIqhcnUQx3ydUPfyolC3mCZGmMGTWBJ0kHF0/lLY6D9URLEZgUF6EY+ET3RPhQneoXRP779IsPbYZUK1dYV8Pkh14LmGzB4UJ996WqDuksk8XRUNLrv9vp7ujtuxOrAQAysSvEg1KW3YgJVjzFDhIlasF2nUdKGE3eULlgl1GAfEbNcONs6Pz7V6iuJxHm1UKkD+4/9o3lpIjQsg6srw2oeGQWQLLm5MV7D3Yjgzy9QHU8CK7YUfQkNrbb2u8Ik4Gb9f4PQ46hcomlknEVL1G7DGt+qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248028de-3d6a-4288-1960-08daf9ae547a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:47:16.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKSF227b1D8CcARyu3Rs0cuD+0oRO9MUmxJLFpcwNN3rWadJju8kne89b4EqjYRMobmg/jBGfljFh52F1foeb4vO5FxmObzSXFG6kwn/vCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=945 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180197
X-Proofpoint-GUID: CWBS8nUh_w_ie8J0UcGht6WC78d31j2-
X-Proofpoint-ORIG-GUID: CWBS8nUh_w_ie8J0UcGht6WC78d31j2-
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

> Smatch reports
> drivers/scsi/qla2xxx/qla_mid.c:1189:6: warning: symbol 'qla_trim_buf' was not declared. Should it be static?
> drivers/scsi/qla2xxx/qla_mid.c:1221:6: warning: symbol '__qla_adjust_buf' was not declared. Should it be static?
>
> These functions are only used in qla_mid.c, so they should be static.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
