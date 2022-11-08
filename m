Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C8620717
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiKHC7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKHC7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:59:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681D291;
        Mon,  7 Nov 2022 18:59:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80ONEf028583;
        Tue, 8 Nov 2022 02:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Cog4HwxDYZlh5BcgvwTYhBledR+CjTvPzn03fd7miw4=;
 b=rLI/0IhxUjXTocBARhBzzupF7W7bP0L6SE4YBrOZqsKcjQvs3KZ5ITYHe6TrZHYFyqQa
 lYsb+VOlj+zk9zX6LnuDXhgucaAs6uRwWVZyj+s9YNgH+t971iwkCrhXnTDu4MeXIbjR
 HB44YEiifD/bqAeig7VJxr8sBQ49Psc+cTk+qRHLGGd0EEph7pYsqvLnWHE+OZajPEsw
 qQO2eO4yrCTfVcmBz8sX+1372Y6DxYwDvgQUHuCsEn/GdZCUwYJ4gh1EUPJzjYMGxLvV
 bBefFMzXqOXBmUOySDv7CwjxmeelrM5By63av95hROdr82UZ8xXv/7eELwAoyFnQDq9+ ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfx2sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:59:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8106vN014319;
        Tue, 8 Nov 2022 02:59:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq1e9cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWcMILr0ncQ9t9A0PQpORCheG7jyLZqiVLaRv9T0DSKnQL6VWKWWmNv+hXrcIzKTuIU1wNq7O38kGnruMxRKfoguJu6Deh+3N2Uj4bFbNO2dbSR0BaoFzv1a7QabeEJdWlx63vevmKamcGIlgW+seUNXOAkIpcRx3y9BAkVee1HAkyOzM3m/Rnr4DZse9a7wlhRLTupPsebRg4MvOtbi77v8BCp6EFdkqUmom0GtpqcxActV4TeydzfW3BKqolXymClMIhVE/ZSaHbkrFvf/i5n3UTXXtexwG7aqOqGaTlp6W3701tcz0w+e2JIJL4YPFjwwvh8XHwrOl9WoKsDMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cog4HwxDYZlh5BcgvwTYhBledR+CjTvPzn03fd7miw4=;
 b=Yg2azeWhYRj/2IcvNCnLuX36tipGiywnbGEcoi0eM9EAX5T/3A2SVE5moqjjx21kX0lHCh5cXDEJD5iGZRdte/ndfhCZH1emBvRACEsN8geHwfA+Zai2P8rMtoEDLmSeHcbdDDGvkucIiBKr9+aycOBT++d14xPHuyuYqXI0P3Sd9PD3gpLkYcoauFHbvG015ELVg5J+ZNhHMIrM6G+43W3gg1gS/tva7sR4LIbGsxJ0YVJJqNsKyTYGVTQBWyf8c41LYNRQhGaTZVj7Dj0Ude8Hdc807IJheujCI8qsN4K16hJQlkEWmCvSJc31yhOnpXZPHM5LN7sPinwUZGQpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cog4HwxDYZlh5BcgvwTYhBledR+CjTvPzn03fd7miw4=;
 b=RcBIxwdaiP3qn7Jecus+YA4kD3ddHd8iU6v34Zyh3ctNoRmQHyCnGwwXcgVcj19oNxLsuD+rMq8gJVPsLvyNOB8FgJF9lgv5mblpnjiuvpEHP7Gc9otgNxnYYuMFXf4up2vppUf0hIvEPqtwMFFvrUPMuEpqiwYFnuYHvxiMuFg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 02:59:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:59:17 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: remove variable 'where'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rkmkv7p.fsf@ca-mkp.ca.oracle.com>
References: <20221031154538.870223-1-colin.i.king@gmail.com>
Date:   Mon, 07 Nov 2022 21:59:14 -0500
In-Reply-To: <20221031154538.870223-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Mon, 31 Oct 2022 15:45:38 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:806:126::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dfa723-66c8-4be8-3214-08dac135398a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18UL9eVJuZEzKU4wKYwQTeyIVAJzue+4CxigwnqEPSS6dK06PSaK0OpPeQuhGXKBylyfZzL1sEqYTA0FN+b/qx/hqJ1dXcb8QUAfAVoBF3tGOSsx7H1MIbIbbFQFbDiCLKYcWidhXKdPjiUUHi9BYVU5+o0Mxtl/QjR3A52eZbKbjP5krBpjkNBiBFTJkutTyM9O/Tcs4nh70m/cJJASBSxQzAKxQN/RbnSEaupVUS+4WYNPl8GKg2GtktSHdySI/mcDZDFNHgeDcZlnqaTeXJKm8/hZG5qU5yS6RuKnQ6zhu4nikh1VppYHUdMlmyW4uR8JFvyH8QRIHsRtlXZTfIJh9SFsBQU91CwV9cj9IWNwBeNkgYWjJGsNjE2LNiVccbgGaKmu1sRbPwlCKh9aLCGE2e27g+P93T7DS70sNoyW7M/FG9CHBHnhpbv6xN8O2uAkASXnreZAvSKAZCzjxpPuPooDXjFUSYoCryoMSVrNZO7xmIJL9yFLfu3ZH9UJa4eVMAQFYuCu4+QGXsBEMhjuiFHjaczqhxWfeLrnsdyxy/GL0FiElwmWepiB68hwGwwPzyMvHA3+heLvy8Y4d2SwGPyFd8AakwqdJcwunuiE/rkkbbNa1Ty/CWj0Y7jd5rFVpbINqx4u5y8GXyGT03snWTQzmfQEPXmsHTSWbZi7A+skHh3f8duXC4P6FRPUINYMWaUsGqpvyK6xpOblag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(186003)(2906002)(558084003)(6666004)(38100700002)(6486002)(36916002)(26005)(478600001)(316002)(6916009)(54906003)(6512007)(6506007)(86362001)(66476007)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRj0av9TyZMDg5HXBnWukyHo9q0drjGzIXdiMnZNjOiy5ItQZESUhwJm5mGC?=
 =?us-ascii?Q?+fyQPRgu+1K4loNaccmdYzr235ecHL+oSxiC2MhDzjt/4GYSasaLPOfSYBVi?=
 =?us-ascii?Q?7hdfmJcWT+vVOHZqMQ6abllhMPyOXkVpju/swXbaUOyEqQHVng+PpYENjOTc?=
 =?us-ascii?Q?9OFE/4TU5RiBGTSTEI60WoetAtqGFRNxd70Nu4c+W3Wld2HrUr+1Ui0rsa90?=
 =?us-ascii?Q?5T4dmuGeIZgwGB6ycKHfF02rvLOzcP1voewKHB4lGppok/Vlk72ftA1gSLRp?=
 =?us-ascii?Q?mPol9YYg/bSkG8oGHztjWw54Ae73su6oKQNQD2NsYlqK9hmLPlqWuufE4llx?=
 =?us-ascii?Q?e3yZQ+GdY4B4+y+RojRWmtunBfJC5ka78hvz5l7IIZoZAAygQ5Lh7BLS7pi9?=
 =?us-ascii?Q?1bxdletZaaAQOGtZB05MTD3l4rBd+zqQ7bbcz4EdfANr8lQdL/Vq0ZrWFqVM?=
 =?us-ascii?Q?OLGTpHr8AGUHHJDuiffQ+/jwqg9xmMzklGpbhwtdPXbA3YnHmAvbABG4sHAz?=
 =?us-ascii?Q?ij23Eiu/q0EG9tjhV5d/WKw2ku3e6+zAY1ytD7g168ET9hBQgRKV0auEiqdJ?=
 =?us-ascii?Q?Q0iui6zfOIQJyolGOTb0Xx29rYAXK6V+2ZSflV+nY9cl2pYWQ72O4JrI0lKO?=
 =?us-ascii?Q?EY1zJ1879/XqN6DJ9kIHFml5fHzoRI0OpzC+CBItumR0JD6dup2UNx/E6UG1?=
 =?us-ascii?Q?qdm6ZYyy9ictYExHgFyvyqYHZbckY5XL+w9zJRz1dNmiBxcAV/PyNXWbrhCw?=
 =?us-ascii?Q?KByTubaK3B14iIGQXaq415dkjpGKcVHKW6RLHz+66bXlSzBnzjoXz6DGrFUB?=
 =?us-ascii?Q?J89aN4FcRlgfyFNyw0mwcjehKfrYBwL0qbX/R4lLXz2td3L2l86hXqAMPva3?=
 =?us-ascii?Q?LE+RDuOCsXH3Th4PTgkrL5S0b2uRq+uymsojMnikXYJ0lwTZvcrwMpwRHXpj?=
 =?us-ascii?Q?3RDF4y/jq9bOSdoywxnwPE/yHEPYWPwx79kv0RJuDTnGfIDx2TlQ9tXhLm1B?=
 =?us-ascii?Q?XgY4TiqlIj4LO5yCCz3W3XwANFInPTHw8VwpwG310U3MHaATIN0J3nocQ//a?=
 =?us-ascii?Q?PCIdP3T1D10bKMNnyNJJ0akS5hmQ1KsdlX7Hs981KCd4UWN9R2IJfTocU18g?=
 =?us-ascii?Q?bVsPtqjmQj3TTy1+GCmkJDzV9oUMJ2jft1LSyYOVGLjifPN3EcKmfz1gfFam?=
 =?us-ascii?Q?Z+BKXF1hTMoTjzXjIR89cYSUkcao6+wMk6RJu3gLO7108OpiQzuuosjUjjns?=
 =?us-ascii?Q?VfaPSvJNZgcqj4nNe7L/ljrKZb5knWONqu9SLOUeBC1fAE7egtTPKwWTx3gJ?=
 =?us-ascii?Q?P9kdxhG5gSRsd0iatIDL5X9tjz2iIljdcWWNX13YP0m4kpgWaNUZHLgNwOX5?=
 =?us-ascii?Q?7ALffanLi9bvrj5JMkfHVHsbsK3G9qxCXCBNntRS2EDRB+Oldl9xUAFjaRk3?=
 =?us-ascii?Q?O4dmzipuzbndsYQeZm2W8qlGOD3D3eiwE6+WWc2FlR1v1dt1G7ZYzy2CXY+Y?=
 =?us-ascii?Q?zkEGXzPNT4lkOy3tZiKCs0KuHhIraUyRxe2bunzjBP6K/bVqB0Zv2Ik6kQGO?=
 =?us-ascii?Q?CqODHIUUjN0S8eDm8PPyMtWgmF1Hxu0j5QJh9cWhhcjPHVgI77zxFNStxXJF?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dfa723-66c8-4be8-3214-08dac135398a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:59:17.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGR9Sv73+tQK+yhxrb4WMTKxp1tPtrFQ6eNsD+DowWAYeL8e03U3M6iKiFCOtDxoD9h7Pli89HDZCOCGDSnPIHhZN8G2f1Hwj1rvDtjv7i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=859 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080014
X-Proofpoint-ORIG-GUID: trq275mt0gNQ3iC57QpM-apvjqMx3YaQ
X-Proofpoint-GUID: trq275mt0gNQ3iC57QpM-apvjqMx3YaQ
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

> Variable where is just being incremented and it's never used anywhere
> else. The variable and the increment are redundant so remove it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
