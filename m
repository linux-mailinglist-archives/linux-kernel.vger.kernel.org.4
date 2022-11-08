Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629776207AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiKHDlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHDlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:41:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21817A9C;
        Mon,  7 Nov 2022 19:41:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OUbN027225;
        Tue, 8 Nov 2022 03:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jj76022iGDf5EczHSn/QiKBz1R6AgZTDnnGzkfYSkWg=;
 b=qi01Th+3cqtYFGx79vv480IvP2pNhiHb+RtXpEu10QZOjopjFHQDhpTOwzDotCCWs/ZH
 R6c5chQ81+2ieoMAL8xOpbDiFdVSOmNwXl0E/QuCaUOpMeibmZzuoV4DLyPUm47pBXMj
 Nsm9avHk2H8YCPEs/OcssPL3PurfUzjlkmN+Ol9S0t/vEnDpRutIJ3edMfGw3yo9Xe3v
 a28Twf9RFf9/2Zr58UgQAwQilYU9isJsENyEHWKDnQQ+9ga+NREENkKZAXZJxkcOvvRM
 1Vu66LbfyMWkmpXpmzD6ITKOFjzR5qmdgs/HlV2W4np9pCmtmrZlHUeZBFNwzJkgz1Tj CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenvsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:41:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A813Ukt014316;
        Tue, 8 Nov 2022 03:41:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq1f791-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT89NRl8pDmt2aPel9ZikLtjf4DE5qKlV85gSP/+DMj1aLm0lj19NUSScY3g+pzrH6OIBBrZ9qGsoRsjBGs6n34cEau8MgU3EZmE5uyXML+NEZRpJoNudL+BO/oqwnJQW+rlID4M2/FI5Tfl5HH5c6AZArlE1QlwOodXJGKbcVpSwGRsdCUw/OukmRzpsFFCiPhh5qlXldPHcFAJ2aMmn3OoFiGHcYxc8hdOJCVAmXzfYnaz2kBHi3W1uSAnOSBd2OlaCIrIyCmUEPtN3dfS59ccXU/aT7IkO0MhOUKtfJ46yKX397WqKiDjLi9ghwKrZJ5RBrBxSgWTyBFpTzJsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj76022iGDf5EczHSn/QiKBz1R6AgZTDnnGzkfYSkWg=;
 b=kJjtPIHAS4/DtIM3uTZXl9LQZaebwLkX0K8Z5fHzzHH12SCetTUJcwJWA1wq2G3SxaOGmEAr2UPoJQs+tasi637WPLSnDttwi06d2RKWCyIEeGggxtDmiKKzmbaeLfKgjQ75/OVoxtfE1ZyPVm/i0pFi6AEtqj3u6Jr5r9Ev6ZA5gHzCMB5fzJ9uL4nhO9R20OrJsqkhNZckZbRQ8l4duy5/Cj6kLQu2+HLrUimy9I6de3MwmCAbg3YuNJ1PgCZR5huq8iVXE3tb7fA9o1JnXnBwWwiJDNUCLeFcGLfmAgYNHk1rBOUzj4uwcj8lRmQ43SaAZ/xrikWROmgeLqpRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj76022iGDf5EczHSn/QiKBz1R6AgZTDnnGzkfYSkWg=;
 b=vN/txPFWZvuz30dC2Tx5T3KT2q63T3QhI+dhEDUrgeYta35+VvSm03nEjthipl+R92WHpZU6uPIrv5d5WEfUGZPlLaT+LFsR0S74hqNcTOTmPQ9D1hJtTTw+RLnS+E5nyYZjlgDnmd0MBNUsi+gADwgOYGRVFDUv4CXk+wuiuhQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:41:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:41:38 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: Remove unused variable n
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jvajeos.fsf@ca-mkp.ca.oracle.com>
References: <20221101123235.52152-1-colin.i.king@gmail.com>
Date:   Mon, 07 Nov 2022 22:41:35 -0500
In-Reply-To: <20221101123235.52152-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Tue, 1 Nov 2022 12:32:35 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:40::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa22dd4-1408-4aab-aa71-08dac13b2442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r762xQr1KqXSpnXbKrTRNYJVSbw6jF+o7Np+T/edNysSJQaxDUGFLH6dpGDYw6lfQI0tRijXSYHyScJDqwOWZXO4M1kLk7EJwD2REqj/lnzQGdbubQjTSFp+lgam/kqUaTsqA763P7GaHTBQUEveJbp/UkEBU92iF7CFDuz+uOV/ME7Q426buLw5FZlSww9OxT7s9YkUtlIWb8b6QIaI0p304ZO3UVth5t4To12/4jB8aZ2omnBtK0huvJa40jztZEyJ+af1kcL/072OD2s8ccg6KHZ3C8dQUZ0BWs8t6qd3QbaJpHEo1yGea8nnMmXp+soL8Oe7gL7owFa6igtPFD3dkLZ44aQHZtSy6Eryak3GMzofndajJPL/rw/dxDu2ZzHdZOXP5Y3TgdI29WTSFpXKnNb2RYDWjvf5DMF8CMUbesAVlq3aVVUs9/TxbqtcwFbpJ+cP3a/O7ESZ+QcjyM157fcl+Jd5kW0B9HQV8+6cH5Msmus1oNupn5Xz9DarLsUSxR9ZR4t4qJbDlO/eh/0qAp8CBp+R4CVa4MHONwLmDXpKprxbG8ttZ6zGLa2JLZOwkZyxx+QVHVZtVt0++hL7Ko7fxtp+uD2ydiNMVei9EvPVGJuJIhUxF57aE6uw9GYcZ7tj41SMFUo4IbL/KkNSCqQWBjBbHAhcyGWAoSlQMZxKXLv9Nyt/G+3r9RXmwHdGfD1uaedOyRyFpGXHH3PuYzjd2ZIefRz8e9zcIfYeFfAqK7uYgW2bd6IXaEAU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(66556008)(4326008)(8676002)(316002)(558084003)(66946007)(66476007)(6486002)(54906003)(6916009)(2906002)(38100700002)(8936002)(41300700001)(6506007)(6666004)(186003)(6512007)(26005)(36916002)(478600001)(5660300002)(86362001)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/M6phzLtig9p+CnS4t9BriIBNdZZB5QPODk9Ltd8HAIVgYbieKjXhksPTLT?=
 =?us-ascii?Q?GvHXWih0LDYk0WLa1vQMokmI/taetFTM49MHJ9PvbNkVYlVlGNHmY4n4e1+I?=
 =?us-ascii?Q?hZK2kDy0uf22cF3GUOK1NjGDaRuf1GULvvpTSub2KrvstFKBZSt+/JBk0Vww?=
 =?us-ascii?Q?OjSV8fa+LqYsyt0MhA8DbAjbsJoXBp06RB9cH95ThllBFotxlNm99V31v1OC?=
 =?us-ascii?Q?81sWRNynTlCOeF8ZV2jpGkVXpeZ5cQN+uFmbcptNkkk/9Kq3aLHICVBeN17m?=
 =?us-ascii?Q?xsmnhINy2mDqPEv2N/oGPCWhyOzhMidyOmalCyW49Q/hXs7uUHA8TlmnydGQ?=
 =?us-ascii?Q?4W22vI1qSUhnfyhGLYpYyWENI2/lAIu4eHBY31kk4v2kj5eaGuTQ6KfD4An8?=
 =?us-ascii?Q?mpeV1S+sbK5CjIdNIJwcUhzqiavY2o8awywV4J5cu7aWIvVOaUEtJkdf+D41?=
 =?us-ascii?Q?aukSu1UVDjY1Mn4UyK4S0c1XOIZeFONKWOGvMrur9/BT2tJAyU5prrlV6m3P?=
 =?us-ascii?Q?gTQjK0WPkGOXf3U9vl5rit+YxIK2bmvDGLVE+hXSgJ61ETtgpkMRL0JnmoRi?=
 =?us-ascii?Q?k1FdPrRzdy5PGOo1KsYlo9fwaMxvjA1bx7emPBBdB2NMRYzs+GnK/3PoFwOB?=
 =?us-ascii?Q?RybLZwEw0N/kq9/M8CzBHiXRptqLd31uinX7r5R2WcTmyxyIQ05mNujXpTQD?=
 =?us-ascii?Q?ZsjOiKm/Z6ba/5liFpc/Xe7wu/SSsh4mS2wdKhcJXbnNuqB2NR9/bGSLjNgH?=
 =?us-ascii?Q?M0FNFkN+WG5HVwNJbdVNleo2GrXuMn/JbihHNQBW0Ul0tNa6YgJwIMsh+x9b?=
 =?us-ascii?Q?K7T4UOdBJuVkSJzdq3AWOa+ENDvKKi5phOailorUIkk0QmUK0+1ibSgYofUE?=
 =?us-ascii?Q?TckaZ1X4eaOHaimloPtvpdyAVDrBxtQ3Q0cws2Cgl0GxzBEV0KnYwkWkJSzQ?=
 =?us-ascii?Q?nBB6vL3jIXRvr9aBFoHDSiZc5B6hKq8fZxDsnpIHSRVoIaM0lQ7SyB9xyGtL?=
 =?us-ascii?Q?FHpvPEsVsqZkuWR5BQOe7832YZlJYpvNAXitkmD57t1xXO9j8roNtPTLCBot?=
 =?us-ascii?Q?zqXk0q9q6G3uNnlJlUIINFgz+pquahemetbePbaXe3YDuXFtcCMN7yrC/zNh?=
 =?us-ascii?Q?j850Nt/gSxE1b3vFIB7ncwyfzD+TYpqAalugmem/aalutpyAAMiHBmA85q/I?=
 =?us-ascii?Q?rsNzJ+xj9I3qzl9UNjb/r0b63064DMbdiWXsHdavrTAgV6gUwaEyeTaqh1D0?=
 =?us-ascii?Q?tgF9Zw93pvg9cQgYVKAo2usylbaXYRhEpltN9DHBe3YVXo9NWVYypibZibLd?=
 =?us-ascii?Q?W1K2zYAIlOX+PTcBI5NFyyWXnY2UYxJf1BXbnEXbV37XPmDVNhMhgd+wiAsc?=
 =?us-ascii?Q?gJpHq+ylxuFG05DyttiE1Y6py3OvJaVudcDGnqY8ZysiZTNIPR5Q3tyEITTf?=
 =?us-ascii?Q?MflRpQcqwZE3mk2eyy2KPaPMfpKNNnC1U0srMeNPMaqQhZQDWJXwq4QE5MUz?=
 =?us-ascii?Q?sUCw2fD87d0pHBKGL7ZQIqjpeYO1U5q3y2fh5GtT4Pt/Q4SH2Q+DKTseBBrn?=
 =?us-ascii?Q?dnBXqQwQBy30mOBbeldjKczygT9XFHQnLTFRDPK1lBhF1AtxU2OBWzR+uNtH?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa22dd4-1408-4aab-aa71-08dac13b2442
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:41:38.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esdU7waeYzK+3z2ZXAdgh3VGWDHORkc4O63mbxo1O+cMzmZLtEMGNu8CSF/DMyfsu2uDihxyf4Py3M1wgKSIouzJm8JnPOoF3gFE7vehV+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=878 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080018
X-Proofpoint-ORIG-GUID: Oq3r_SH5hdczEV3RTUfNYWJri2xVeZ1R
X-Proofpoint-GUID: Oq3r_SH5hdczEV3RTUfNYWJri2xVeZ1R
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

> Variable n is just being incremented and it's never used anywhere
> else. The variable and the increment are redundant so remove it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
