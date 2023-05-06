Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A530E6F94BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjEFWMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEFWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:12:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9421940D;
        Sat,  6 May 2023 15:12:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346LvwJS000397;
        Sat, 6 May 2023 22:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nEPhhIz0JC9i55qT3P+wtiZzieuD57GoIahom2bgAmE=;
 b=ALIWYtrDX55a54nMShuwO1nEECyxsP7pG7AYDmysIV5xQUDOw4xltCFo7PCAH5hFy/fX
 bGtNtEB0U7xPIaCMDdbbTTh3oBv567fv+/yULzzCRtdnjv5sr7mro8FludHnlh9m+aT7
 2ksi6WkztN4HzBQsZjbFNPdQMEph6975uGRWLmst//h6wOHAv5eTtM6+6w6wEaNbroof
 /8nFcQF7RMsvAGn+C/wQVM3WJwuEDgilHveRLiX14rQY9aVO903RHLWHOC8k2JZRN7yZ
 kkDmqEDAYMLDiynuEXZG/8hVxDb5OhcZuPDFvaxoDFC/5obHXnEYRk4Hq87kJXpppVCC pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddp4gy6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:12:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 346Jd3Tc023919;
        Sat, 6 May 2023 22:12:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3ay3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIeAymIhXnlYrhMtZtHXA21HL1VpwHn9nRE9S7jZxqYVjrWnYO5BcmeavdCCL1EvFMdQEU19FzcT0wVXyrwtwQaHxqmgozdtimZH+MdhKECi/vi3hjrcnrwNXCaMew02S8uEhppNSkTIxTLjuHjGrgYPwGsprqlt6KNr2q/tmZLXho5tzDGN8AunFDR8Oq+IFOELMjTTR6j0y/GFoHdap9nUXFu0F2mzfabUp51xtf23Mu8qN+owcbLME/zQmkYJKGGpw6p1xmjPEf/orZtunsDYWNUXbT2sAbW7cJlEF/S64AcNK401BvWCnrhsHLLqaF28xQqxtvSK2FxiC/CNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEPhhIz0JC9i55qT3P+wtiZzieuD57GoIahom2bgAmE=;
 b=S3eD04YQaPRmhYzIlfePaUkj/BYbKwt5CMKzhrNxKg00e4+V6GRJj3UQi+D7DwrpBvho8MKwC8vf5fnIpKaBV44UKHUbNH/pl6MDDgaEqO3sFsz4BYq9X/yv865k+9jGQRLJt5HHPVp7wZERjj4SuKpiP/a2UG5m+9JT9YxDA69M03ypp8J6KZ7+3B6DgKg1t6Yk/Hg+aNAuJxw1QERq0zt/DCjbJd77DCt21g/d3b054VYJrzCSF4Ui1iJxg5m4FNIg/9Co6qKbyk0h1pAIGB52CTAwGgXEJVJH4HZm11D6+WVrD2LowF7hsikGT2nqYEHSWsyojj+s7fipZQQWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEPhhIz0JC9i55qT3P+wtiZzieuD57GoIahom2bgAmE=;
 b=ui3+VD06POgqlh0n0YyLDqxRZcnaHafptfJ6TRuacwxRNi7VUgQExYlYvXIJAwAcNNA7q37a1cNG+YiQOHtqBYeno6Mijw+PKgJo+obIUW2tzMsitQVgcJ50DSJLoueqmwaRLAeniMFCkvTeXtRKeFDX4R8y5liYSuZ7MCJhyqg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 22:12:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sat, 6 May 2023
 22:12:34 +0000
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] scsi: pm80xx: Add GET_NVMD timeout during probe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18re13y9p.fsf@ca-mkp.ca.oracle.com>
References: <20230419175502.919999-1-pranavpp@google.com>
Date:   Sat, 06 May 2023 18:12:28 -0400
In-Reply-To: <20230419175502.919999-1-pranavpp@google.com> (Pranav Prasad's
        message of "Wed, 19 Apr 2023 17:55:02 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 287f06d9-f51e-4478-3848-08db4e7efe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LQnlJrHs7HAfZGWa80E/PgV1fbAWb9ot4l0qdRrJ3H8RqPy4XWxc68IoBI2CF2RX+PnWTKJILYYtOOhJIc5C2/B1wdrQ1ceY491pi7TG3SY8gB9FcVhJnKSAkPbo0Yo29nVjFHia9xPmYxXKRm2OD39JA38seT7X0HpnoAFosp6j4cPON+b/WQkLODNGKUhsCK5sKbGGe22e/V832lbigxA170H+9PlHSCgKqGfdkFXKytkOrXrXjpyXagWPe8EO4Q742IkJSDaf+SDppN/fy5pUKX5VdqvNhzmwojEsw7N9qNZwte+5ilcyA5aqaaCbLPyGECj8TMZHOf7MFlGeU5ngSBePvJk/ILfXc9kd2P0iyIJNZrHqkX2z1ZXjH88hXZAKckK5mV/coLhcqj/VgkyKZ6qVCSCZspFw3qYFYamdi3QTVZz6nUvY0UwAOWAGkGh0qAPzGGHH2QWzbVxmvNdilk6i0lCUs3CBG4aZbrw6ggKFcIXJSShnlyJZWFWn6FGqjfDMID0Nw5ONTFkxrNcnHgMPS/UarMohc4a0JvHkOUDv5S+jJVBgReKknyv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(41300700001)(2906002)(186003)(83380400001)(478600001)(26005)(558084003)(6666004)(316002)(6512007)(6506007)(54906003)(86362001)(8936002)(8676002)(5660300002)(4326008)(38100700002)(6916009)(6486002)(66476007)(66556008)(36916002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQhwDVbk6jNCem7LXgrqvddWs2iZaoFXLMIWPYaIr8fBV3lD7DCsajUZMGd5?=
 =?us-ascii?Q?8Y0z4Im7tcEjJJBxq5p8MNAgk32iwn2WLWVvNHmwSMhhKMjpKiRSAlgrYiQg?=
 =?us-ascii?Q?s6tPzx67ItlEIInYaSp242HPH1PARg8+BeFj2CcP8VPcSJ42cEL7jSojx9Um?=
 =?us-ascii?Q?JpyMxFMfv1LMV8QuFRGFIgV+wP9lG2KaZvOFZwnPW4bj+atRgIxm3eslVKwQ?=
 =?us-ascii?Q?yA240ICdh4JL7Ke1AW6Pd+lEObqGR/ksH+ZCg5ro/z5px4fSy9cFnSPuoXqu?=
 =?us-ascii?Q?rTmjjIuG6SA0bLfgxCA6WGDlHlQn481wN2/7F7HLwPivcCJiReMv8PzbPDNn?=
 =?us-ascii?Q?HMTMPiBoKeM2EYVNqPXyGJaO78f6z1yuJn9AS8RN73OfUdq+JWjuI3hRPTXq?=
 =?us-ascii?Q?qLEroWjXvO48JEWV2DfzcUNKcPPLSd0uLeP+QJ/wK+fOWD2M7QdCmnIrbp84?=
 =?us-ascii?Q?AhLZBnRtVFApLq2xcLdgGR2yJCqlNgEr3ahjXBp28pp0E1hrcoXDrtBimZN0?=
 =?us-ascii?Q?nMQEUObRtwxRJ0rIQhdBoP/U6B2Srq4q5NzKuzrOrlh7rf1Z+sJ5V9UhfQLz?=
 =?us-ascii?Q?4DTHKgmBQr6qFGuHryaVnh65BaHdFI2yC1MamljbthRZ4WNdd0l0l4if2QBc?=
 =?us-ascii?Q?dm2nS4lAl4sW7X8JrT8877evAUwQEpx0htstwXursYEDr8Q2ImkJtYJA+3Kg?=
 =?us-ascii?Q?0k7RugTSfSa2rF98As5XEDELzHUEDsbLdqaMv+hPWPIQaLP4umVZW7rIH0BD?=
 =?us-ascii?Q?HsQTJCzZTETPUOdmn4LayxRfayvUtkim7YaISpPzLUD7G72WBdMtawU29l2l?=
 =?us-ascii?Q?/UHslnPKJZihHXKifIt0a2gmbX5eGjWOg5JpflBNyzQiXBeLR/F7XWarX8zr?=
 =?us-ascii?Q?PDFSIDEZTw8/Der41X8zVzF4xRICArRZhJgGgdONsTAUVKbfiKNKCNQrmVNv?=
 =?us-ascii?Q?MOMvZK6n+94NDGgFX5eO09s3JolAebzbj5mdVp+M45h7LqPnnGi6Mt6k+Wdy?=
 =?us-ascii?Q?aHrW/6YVIqkm0vIm6uU29uqondNfMls4WTPNszHQ7R6tNJjTgWHcHNCrnjkC?=
 =?us-ascii?Q?GwiC7frU+tqsIelq9A6EoOABRs4ocz29C0M0QW8rnPODjMw9l5aZ5GUoHm/T?=
 =?us-ascii?Q?BTd0S8VEbMO6EnXq1sFP26vbF+HmYR8JouYeAWue5Y7bzR26ST2iHrpCxrWc?=
 =?us-ascii?Q?f6PLKWeayBYfsjofyj5TtXlwLyHlQTrHcxlv2us4MEGW9OG4N9eLZunxSsJa?=
 =?us-ascii?Q?jvAYK6iaJjkAslXakzgJJ51hO0ZwyyjIFr9tGyI7fsipJBcb0UjjugAwYONQ?=
 =?us-ascii?Q?nQrC7LxXhCVUwqMAtaV1dmvKzGDETjkolECxKlyb9zlZbIbTGKeW8UfDEiNd?=
 =?us-ascii?Q?jYkQuejHeC4ghB95Kff+yzNeKN+8AeM718FBdcWPNMALoEhztJqTGHhvD9Cc?=
 =?us-ascii?Q?htnbbL4T8sQOYwe3UJFcMhXEZa+lf9qOTEsnvt0bx6xb5Bi4AYqNcYiKBP+p?=
 =?us-ascii?Q?f3rfIfFWvIZB5rwFBFgWTYiuOq/xEF0SncqoQfzXoQs+KVzOUdIyzrYEdE0T?=
 =?us-ascii?Q?RWcT3oLXS/4XhBABPbnF7n5tLJZzSwSJPlrtV3KocU8nFkHSjkfWPDgc6POB?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VU7ufSfwL1anTN6X2SA6JiT0SFsnIVYqU+W9e7gj+WX5PewDR+DzudYsvAYU9CCVF+5T/kXmayJL9MOExbDntlTyJFg/59Mtv5/3ht/pycHSE8/rsRRIWiqzQGbQqV/p551cNpJmm2O1zit7l7mTCe0brREC9SKucVwPDDZd8hl6cg9czzLonTTJzxYXk+NSSZzzGz1B3NuV1Fp2Ju05suBQW80tBRBHQOrHjck5sWlvy3oN9kzxno52WPcQlEn1shqYuoEH67PYsDe+KNr5Q8jygoLiFlnbbHuK7xNJrKdVOE180xAwb0OK7KlukqBd652ZjZBfZiUv3oVKNanhQdOBwDTqJ9cza1490umkCVAFfDdl5fRfLmEmkVMn2ftCsgqb9EQs4elL2wqWlGFBLdfSoDAzUe1tlBHHH5tXRT/wLJqcPYHS0j44LXSRaCbTCgzuodr52/KDN1B3yIKkva7wizabyd0Ijju0jGHlyZWJty5rUKjALyWJaABsZLXS2703/FHgALgdMhTikZEKHZsaaQUkYn+g0eyM2++QfQOxnw7ravKG3PFYcGtXCPcyp6sfwcJDevTQ37KHAtiGWN+3TCdZsfNfo/ZzBxrwEg53TSof9KLbnmzVJ+rZZOrjMyvpIhGBf02ZJVNCKPSYjTfFENDwL/BcraTu6xFnCDKk/vaMvYTuvMgPdw3VV1w9vAeIajf/WSHLWGottKNAS7SgBwrWS+OlZr7fI7F7BjGVZUK3tbu7ejQkMUBogTp4upPZxgnv9amEubC5E8+JKtDHRHAhODtqCSQr/rfa+PDeH7JnEH3TLxrS9FpgrGYACbRjhBb9fZrtlwAjHo0ep2/Pn4e9lRWkwGY0d8Ii+ViqvyP3kinLF36csRm926+/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287f06d9-f51e-4478-3848-08db4e7efe5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 22:12:34.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 058dYJSK+q3IsJqeCly/3PnDrBUIA/T7mB/Qrwg9RVz9sjVA1El33SpfXEIPeQQ8Li4yXIPvRYJ3G6lnFZg04KjndUq1l5zeqeUTti3wlPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=866 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305060173
X-Proofpoint-GUID: GL4MMLHHhc_MmN-An8J6fFZLl17vTQ6O
X-Proofpoint-ORIG-GUID: GL4MMLHHhc_MmN-An8J6fFZLl17vTQ6O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pranav,

> Added a wait timeout to prevent the kernel from waiting for the
> GET_NVMD response forever during probe. Added a check for the
> controller state before issuing GET_NVMD request.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
