Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97BD70CCEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEVVwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEVVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:52:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC1100;
        Mon, 22 May 2023 14:52:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNxWn019687;
        Mon, 22 May 2023 21:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1OmrhadzW0b6SjgaBXQHdF6qH8gKvF9qskAvazgYEm8=;
 b=iTrzrtorFeAvGV6f0qK1k3tvYJCGbH4QnqTGRCtNgdZMVlJFrjWkdx0mqJQWXSlaJNeH
 5O4vNiaDc9wIWtl8oaN4PXZH3I4GnBfXYktJjdmVpFu8nQsH9dEXvu95rqsHQPWMZIQN
 UlR8XUHtALSKsyb9u1u7HaE2k5IvzgHvTheGE6DK5VgrJ1NwvedWczJnvJfM2mignvH4
 Qa7nnfHhRd5wVZEP+gRZJzpAdkSTPELTHvqUziE2m9LyqzR7gZ9fi6aMMKsFhwft4K9j
 yT0mtLk6k5/j0FpzmGe6bCND6jlw5wcmslh99Cl8zBtv2Y7lPGKJOsHQJYeTXKC8Wd9B Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cbtjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:51:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MJfQHu027324;
        Mon, 22 May 2023 21:51:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2cs24b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkQ+osKUQ66MdPUFa+MUE5heS55H8W/Ylf1SVfX0UfxlgkFRmxnW2LHJFMPhh4KRwPbdUPzcsRXYfV+UIm5JTJYSfe4TKpdzViJundceMnk1xTxOTugPFAbbVPl1Xyw+bSh5RcKAk+R/KiweWfAx202+G3+nPTzlFuBB02L3ruJIxbuXQ1P1TGX36D8jP0B6e34mKSwFGyNB+BUcAbjRTYx5gc8AFy3QW9CoEPvCI1ISnnTwZaZguS5CBU3bJFNcQz7jEk5zU1WpK1j9OVba4dvjE0Jed10EnbkvL95zRqtMdlPZ9M6hi5WA8bs7kLDH7RPSJcaBZc1eDLjYmQo0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OmrhadzW0b6SjgaBXQHdF6qH8gKvF9qskAvazgYEm8=;
 b=b/CSBueN9Hhzk6ErLOLuZ9qczYBRzU7W9JrSTHBpmPUTXqx1e+/knbOsSDk7XePk2Vdf0iwQs7KZBmAiJdi3gs+pRSChMJIcYnElEosteOSr2T95pSRW7rTpoDlw9b/OjAhyz/ov+wPxE4OvPLFJJiwh9zoQzhVmlrf4UqqnBvM45VNeh8bXxoXQewieIU/FMQNDhIXzQOK5Rs3wW1RuRpbeJhovL7zraRSFLMl0kDHpA3rzN+T1er38kpXdlSPLqH52HxbOnuPdgWNJO6miLZ29dxj7sPnbolSKZPwx2BhmRB4luIG7qj89iOCosOLKHW8mpAeMXctdTC189KP+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OmrhadzW0b6SjgaBXQHdF6qH8gKvF9qskAvazgYEm8=;
 b=qSCe4C+myqyp5b8ORQFAFNZfxHmB41Ae/XePYX9VeBZLVT2sdX5PSfUQHM1B+hCk8GNbMOe0kZWtu+tM08twRaglvco94orvB7VjXug3apUfk4MUAW7nxS+XTkTbxnxGzYY63fiwL8pbKN+fnTkYLXT+kuKMaaAq1wbo6gJfQlo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:51:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:51:26 +0000
To:     Chao Yu <chao@kernel.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com, hch@infradead.org,
        bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
References: <20230310123604.1820231-1-chao@kernel.org>
        <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
Date:   Mon, 22 May 2023 17:51:20 -0400
In-Reply-To: <b53321ab-679d-e007-6407-6bd00149948e@kernel.org> (Chao Yu's
        message of "Wed, 17 May 2023 11:49:03 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9c2ed9-a26d-4669-68c7-08db5b0eb14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLTff1l2SxNqWhMLuScQOU+2Y23BUoHzynbHs9FhDxYnxCdC15SUjBwCWeYbSHh5lYgZzOUaxWoA25EfR5jgQooILkxFaiF5wvO49q4d+K2p9ObTznBM1nZerMMibIXQS9mhnIBWOzHmX22L/AO/pqFt/H8c6rquSL5px1fw6t4sYW3atXvbfb9CZNUxMrbjVx3tKSS3qV/WlhgDvHgbaTv8UdFEP8YlDEntRG81hlouU9bBK0QqfFp1QS2V/HdYcNB59JcFl+ScIkSJ8u2BKBaQbBq7xJheTrTZOfIgnuOefE++zm8Q52dIzSY97EscLKn6V2IwlPxB5i4MNDGaAfGH6EC2orK4SjKMRBPg7IxUr/c0ToZ1QXgH979VpUt5NPGYconUVTeg75PQrTjyQMITlCuYLdbCFZqw8309uWuX2ONK1oniEuC0H6xlndBOr34nStGSASZAgBTcuLTsdR4QV+3/gHaHX+WTiaA7GZIWT1TJ2vIZbpvIR3Hh0gMx8xBvZsZOlHaPcvkS9BNchLeSpMV//GXBwhG07qTVuSYDgXXbBLwWmSS33s7v9PSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(36916002)(478600001)(6486002)(6666004)(83380400001)(558084003)(8676002)(8936002)(5660300002)(2906002)(186003)(26005)(6506007)(6512007)(66946007)(66556008)(66476007)(38100700002)(86362001)(316002)(4326008)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPRbteob8oGdSMkn9aklvFT3ZjnmRnLihgn1HVfiKLAZcQ0T5qe2/49FOHF1?=
 =?us-ascii?Q?l0ZkiJZWpN5gBn3vieMAUeSs3PVAw/z+hSXrtB296UHSIxY7nVTeSuVe1bxw?=
 =?us-ascii?Q?leGa1g6+4RjNieWdfkX1BsGzphqO3CB9Vv/TucL7XLH+cDHuS8CO/EosJhtR?=
 =?us-ascii?Q?p1xlo+Ht25awxRRN9YvgtyK+YoXkmG47+QK/6ywcg2YI6gGXavvAOQz9dwDX?=
 =?us-ascii?Q?HLpFrGkWKQ8fdoNj2K/fw1TUpDGtYSjRPv03ZFyl7TxRd0hLzMYaIMM61JSm?=
 =?us-ascii?Q?nFLeIRL1z8DSJR+a6zmBJyPq/bd2bi8JSQLCOJWFj2kXXn28X1Hnh5R6f0jt?=
 =?us-ascii?Q?DxhvhPgTWGemHflbv9t/Ad1AYXcF/f1tGq4HEAoZAynqN5e++IyaS4I+wgCJ?=
 =?us-ascii?Q?G8tnIMB3QCztz+/R07aAeYBc0PQIf3bYtw4gBRwM5Ckk48GC1MurJZNeaQYy?=
 =?us-ascii?Q?wsKM0LsAU/QhJpE5czbtuImjwyHN+kTG8LA7tPw+HRlwRCK6Ma2XeGNiDhZj?=
 =?us-ascii?Q?Yg/UPwOTv8Qq5Ly0X4zjF8kPg3tcHzBdpcXUyHEkAmfgeDnB7H/+XphS0wic?=
 =?us-ascii?Q?iKFbZPSxuMrvVlekzONh7KH+rXETthWJs9k6ldnnpqTsEjGw/TyaokIp0moZ?=
 =?us-ascii?Q?LYbPFyo+YBlLipoDEr0wLRAZiXt+xmrx0NZy21R1tMzsaXXJatelEAPwe1VW?=
 =?us-ascii?Q?mEo93p230AF5PxmootXRrul+JJpo+ayTxF/g3PfkLs23feCULYZ4NicM3zS5?=
 =?us-ascii?Q?YO9HfNZEpHOtGDVOObTTLtlVOhtjUE0tlKUQLxOq1kijVJKkbBYDKgeF82iB?=
 =?us-ascii?Q?eCALZ/nIXq35Vc2J9fdO7+hPsUiBTly0vvNAVclOmSYdgxGtDdFlitsnvIop?=
 =?us-ascii?Q?mtG8twN+uV7KEmb80vE2+Wre/1/fLirNfc6Oyfp2BG+FjU9kkG1yHHdb2s+v?=
 =?us-ascii?Q?DSIyl6WBlhH3XvWnxuYmugfN6PsIHAw1uggCepJXhxedK8hv09WG2NRayd72?=
 =?us-ascii?Q?cYr6IYUTtqXEiJub0CQoeRXSkugBvHQDCHgBc6naqM8tmSyZV79jetoFHB2U?=
 =?us-ascii?Q?w5EOq+Ga9QWwzcVgSmscks6uNzIEPZMIKvbPUWyg9HnwqoEqyxzkKGqoq7TL?=
 =?us-ascii?Q?RLhDDumCQD1ul3ujgO+m3cjmseNY2UzhP5IAkBJ9MCkAX63tVegcKkCHhOC6?=
 =?us-ascii?Q?Vynt2ambWoDBQCJ8hF6+3BXTCKQz3qPgvhCUKzjoRR/QKhHFrTlZ+lnEeNTp?=
 =?us-ascii?Q?qEIVU5XVtw2h/OKxDeTPEtEPs2ADp4L6MnRF/omsN9WA3/mszgGinsK/Qdgg?=
 =?us-ascii?Q?LAMnkkRii4x5AHi0mkDyomFTrndvl3qyu6Hq63D1Q0buFDbKIyx0Aw2dqTox?=
 =?us-ascii?Q?EKjZbMgL6JHRaJAOyoJE70OHv4XSEV4Cnlic9m9NBbcL0hnh4KBDhxQaWEE9?=
 =?us-ascii?Q?sg8oojsOsyFwNkByr4L7axR/rlTLYWNZ43sT90Ve+k+U/7xqLYRo9oi1GOra?=
 =?us-ascii?Q?Hyts3nlZiQ7P8qeZ+j8jm2WAFNr5f9o6fFcQxAao8hVWIF5oABEFesaW7a3a?=
 =?us-ascii?Q?2n+VRuxT3VPaatuVxQOa3KfayspKw0qSDrT22WDS3rAWBHECuX+p4eyEFx7u?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ja7jeZOSxmegoN0lCPRo3/hC03Q7rcVjGLy7EZfiV8Wqs0nZyflNDhDYKWKy9aNz6fFDsx4vbF7Q2qGYJDJGH9toU6pZ5HzRUGWcl5w4y8+n71+d+DJkKurU/ymI9Cizoe/lt9fd25gu5KLb0NkSDG0ZLkO4zXKWr80bMePnBQf2MkTLkCHlqIZwWm8tE5JceLaMdRdcMvl4gybsCQC4Hm36hx26EAGYY6dpNljUf/6XgMRLNeJQ/6rmEbN+Z/ISL9rjYaAeiBY2qpI9QejcAfCWCEW/cclm3YRae7O/5MM0rFvTARyXb7wcha81dvFHmuBIWcITicITrUH2+VyGMn3ZuZLOzJmMZi4ItxNHXphTBePk6NAgHuff/CQd6iYleZKDkbMcfWo37gqU2pCc5ufXpe+gmYW9ne+QNpQMkLUBQP/NPhRtBaw6cpjVSkz+tnSoNxO5ni+/EDn3UQc/2salOzBObTXQA8/APzYlY+NjeVfxQqwbHev4pWPGQCluRM1NAlGxXEi8bA9OpforIvITxfR6HaDhBL9oaSQXZ8z50IHMlBGSBNZDsvXDvfSn6IFiUPaqE5iz8jaD9rv1ltbIF0qisYPE+hqBgh+DkH1mBHwZ8lcNYEF3FVInf/R9xywb4gQACMg2eKYtEmyLSi4BEBlQjdYR3OOO0O+AMVnmqF68CvJ00yTIfcF1/0sjD3c9cWaW/KIJQyGcUDJ9A5hyh9AYeFN8Tlzk0bSvOsW7UAi9XTXP66G+19aQF3wDgci5vK1jRsAr7aycNk/2t65SJNAx6dV3wqEEY2mCs+4xDeiaoj8IQ4lt0K52rLP9pUL2pNXz6PTCmIwMHwBjGTMGADKGLST4/y37XS2NRRJp51Z1LFl3tmR41ApOeYjd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9c2ed9-a26d-4669-68c7-08db5b0eb14f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 21:51:26.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBdF6Sl8uGJYicZr8gzMJboWOjdFMy8bY3UbAQrb8db68LkNdUrFoju9Brl6fKNLzLsqqvUD9Zor1WZ1XLlbjWTWdBlQ6FtayUH22o80cmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=754 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220185
X-Proofpoint-ORIG-GUID: sGE48ekHTT47J6u2uzA9qC-3vG05VCSY
X-Proofpoint-GUID: sGE48ekHTT47J6u2uzA9qC-3vG05VCSY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chao,

> SCSI maintainers,
>
> Any comments on this patch?

I have an updated version of your original multi-segment UNMAP support
queued in a discard topic branch that I intend to submit shortly.
Without the UFS HPB bits.

-- 
Martin K. Petersen	Oracle Linux Engineering
