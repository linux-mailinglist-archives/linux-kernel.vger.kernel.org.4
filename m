Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87286207D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKHDya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiKHDy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:54:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FF13FB1;
        Mon,  7 Nov 2022 19:54:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OaRR029245;
        Tue, 8 Nov 2022 03:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rzPpIedG5zDamj0SXS6ZwK2jvJciZRc+IeH3ECMKsm4=;
 b=3CkA2AQtnzRVlUPTxOhwnj/DeCjRajr0haDS4mpi2td2+LDcBB8xdVGMTalUtEcgsqL4
 p8XfKw61/B294i32sjjk/WYj8eRLnnqfdZyjfZAhWsx5FNRgweW3uo9ixkEa3XE8tFPe
 +e6YgwUC2IbYKBr/gEeh7DqXgAJilmbhvp/Cjvj1y5/+S6ZIn6tCG1YbROosTxqaiuKp
 WJBrQskf52eado4ZuumUZVsds+OHnb5IuP0S/2G5EBhnMZOSnMhsQ0rWv459y8GC9tdZ
 tlo9uRdrJajnc/Tueth7cJSYNHshpkXhina0DvSdmttL0LWSJDsBN4JA0Qsg19KVNHyR ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfx53x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:54:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A83qMVw025524;
        Tue, 8 Nov 2022 03:54:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfgy0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlR8f/kd1M7o4nNUZAte+vUVqjt4uwDyXZXUe/8gCV55TMT3MeqxJRrCvkRS91kI71QP15iubslprg/KgqxfbLVcb8ZD8cksNq82/vy7v3UXEUYExa4+wn38vuJlqZzaoYolf4wTfNzuKTfoGp4ARxMr0VoZRP9lOdmNSeL9oB2OqA2R3mLYCnlxQqaaMZgQS6Xt6q92wu+fVmt/1AwR0b7SOC6nG3kp0xSdNPRBiGdaHkneRmwGnlFwJlCeJ2PEkpeiNahqAiGCBrxkhtppt5DAr5a+erDqXFJMmIIoZ+gX6ZmKmCVgAnJl9Uk4LfYBzoRYHWxZVppaoTtGgRetCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzPpIedG5zDamj0SXS6ZwK2jvJciZRc+IeH3ECMKsm4=;
 b=ZbD2bZAjhMNUIRPB1WmyCUTubNho9OQiuzoElPb2gLzBSuPEd7GPZL+Rmj9W0drDljMeAP3rfKwH+pY4qsVGYs0ORrgzCRnYoH62a7M/XBbKhZpMkqQNpWizzKpW4JDcu2jEUORowt5lRkb4g+o/OxJ3jCk1Fr7MJS9pidh9JbH2d/faW6omJGluDHKg0ZiQoELt6eZ7XkA4eaAuFtBXa54eNBKAlRbGClBkK1MXWBs+HqJwLEEyxkFqxUlBlW54n6S8TuU3qIO5Pz/kLwMJ/lWdx9qZtaxzNxpfXZKWSvVE7nDzOoT7b3c057/Vp80+aotZS2zgyJJLyubcqeRdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzPpIedG5zDamj0SXS6ZwK2jvJciZRc+IeH3ECMKsm4=;
 b=R/PaUhnhQWMEyMhXtxiLKzdjB9dUIYS5hEx87HeXTD/8DBmbVg25/esIMQ5TxkCp2zrBV+l7JP74hDbbZ8ToRWM9W3evg+SjudnoI6ZpkNbpvK21Fu/XPlx9rvre3IBqT5ZVGTEwo/7iUwI1Psf04gHi8s9T7QOLEBlDqabkRz0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5576.namprd10.prod.outlook.com (2603:10b6:806:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 03:54:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:54:22 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 04/30] scsi: target: Use kstrtobool() instead of
 strtobool()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt92hzj5.fsf@ca-mkp.ca.oracle.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
        <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
Date:   Mon, 07 Nov 2022 22:54:18 -0500
In-Reply-To: <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Tue, 1 Nov 2022 22:13:52 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4b7528-a762-49ed-8815-08dac13cebb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zX3etKLkxquAxLrhlOMlpsdJqdnnZq3i9oLXX++nMMEUriBRQTn69Ax/UY2Hd3FiAqDRHPK34xGaHd/+T7VDbeo7LHjbdJCHpalsqp1UXTdzSt7qB8UR4CrkgXAsOuo/yKHVB7ksUaYoVtQwD6tvqt1/qObdHlqfInlW/ezrxLbhhIcpY+KzdHxVP3wkCwESVrZzRDNf45U5MHj9hpuEIynsT9EApgwybYBrKk9LPMfp7nwFdvzbs5OlJhncGYc4kswUMFQScfS50wVeXjFxUiRuNfz5y4XxQzjHf4kO/KO7TX9v6KOajB7bc7eK8sEhonFCG8AdylPzIavzowz22DfNDYLWTpSv8zaoVzqEH2fN5PlrWesjfGaD4A1REfvGjghPZxZmVfZb+TiFV8yn4IyJtbuyzuiSSEZ7ryeWB2oG/6vuWWbS3fQNFb+H5Efu4kXtb8K0ZvGO2KSxajZCJydfhMqxMFu7VQgRFnwKvJn8bBVi4139dY0m+H67LDYS2KJ0X0dPLV5Y36ZVzDSQGr/23SFc4QeKzuXboPrIAXyeuZR2/AgddxSXur7da3CbmWSYd3p3UM8BD8KhT+R8l8nXo44uHA9DyBJT8C2DLFZQTzowPebA+ye2h568Gj+h/clA+5d7gYcM0JPAEclc3mdse0MGGmyGiiosIDWcFUuOxHfo7chHLVgnWxW/9RFMWAx/AV3NNi1BlNdu7JquWVX66u50YP8YP456hTpqHvjlhquRH1O638/9UA7wzyB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(41300700001)(478600001)(6486002)(36916002)(6666004)(558084003)(38100700002)(2906002)(26005)(6512007)(6506007)(86362001)(5660300002)(8936002)(186003)(6916009)(316002)(8676002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8YoXe/ypYA+IbvwePsSn3l864wGuY3u5PjGJGVa9WSl8SlcaCcUA6nKhiQhr?=
 =?us-ascii?Q?HfBZ0c9Odno3gWYnk4kD7mL7odIZJRsncLkTmBnwyV/R9gNGbbFhvltYCxK1?=
 =?us-ascii?Q?5qE6k1tdc6EQpyDrIehCxy/XAioTQl5AvxrJqYcJVK5mbGVQTXwS+B9aBpvb?=
 =?us-ascii?Q?xOsAtxlPWb7fjcrrx5FokxT3xfSJBnXe+AtBEA8Y23Sp1OAwdF0PawbT6mZp?=
 =?us-ascii?Q?Gr4nLfKdfpoRuL5uBnCsaUA55L1iOcCmPrcXCfeBUMevDWMeSIU8xfOvc+Fa?=
 =?us-ascii?Q?KoYb4Z0BBZ3jh39WuidG0CjCmyiWcR3ZV1hYr3ZWfkopXu81Vh3I7n5E52un?=
 =?us-ascii?Q?hwsAUGm8PbcJ8x+NgScAyjgYJDzOQFJRInTFx77E4JbXu0F9fDwWZCnlTani?=
 =?us-ascii?Q?y33eaZS/Zx4JjGRmwrV3vF27K9HaylPWr0cljnzrpPj9VJUNBQChUom/RHli?=
 =?us-ascii?Q?Zu3P8+tW9vBHa3rtPrRlF7p+80rXrLyO/zuDpAyh1Z8zFYxRbMFwa4URBHQp?=
 =?us-ascii?Q?bFuZYod2Qq+6Tl6SH6UXMi2BgRqa9GjQbtWP8vOwW39HmE71yWn0JqdT22ke?=
 =?us-ascii?Q?A6dLCPO2tgb9pIAgPFidT2PmkyvqNI+6+friYoH0/O+t2DfSwwXE2bw0W6H2?=
 =?us-ascii?Q?NQ6LFNNCS0cDLU3n5eDG4MGOo4zKniKtj3FjT1S2oAdDZd1ywAvEE6h1a6an?=
 =?us-ascii?Q?0f0juBam6HU3CyEyQqdPMNtgE94YInxN+ZOeAuMujeK0r3HZZdxKky/OCML+?=
 =?us-ascii?Q?1AcoGaWav4etz7Pp8B6s8qpKsj+O+Gby0d2vZqXir8AzNJmz6wm7+RPAHgbI?=
 =?us-ascii?Q?0HZpox/cIvQX/N9gimCenFG1htsOcueMSh/VfkwOAJQFB4g/daBGAcaSnBww?=
 =?us-ascii?Q?Wo1trv1TdNkd8JAFaoj3D0iR4gQ1LrLnIYEn1WCGTC/IfpP02ewf1mAHqPAw?=
 =?us-ascii?Q?Oji2HuVo60Oqv8Spnx3cDeZhjbm7Kku6rxLDYuxTUrDPN2qc6t9AjNRSgxyt?=
 =?us-ascii?Q?e99apTBAdRbUj7JvdBN0r2K370xI5mAT/e+xr1yX7A+NngauZtJrSzBAFXSq?=
 =?us-ascii?Q?wjJlhIMHgJ0YxDHYZBYhWg5pPiriltb28n0aq1kxCWaQH4vBRACHwRiQTqhZ?=
 =?us-ascii?Q?wdyq5fyTkU27Vk/aGXyc3afY8dosHB1i0fD2AAJbDw0tnIGiXrHZJniKVbyA?=
 =?us-ascii?Q?46m58sgyXwoBDzibMkrWZp5IvV+J7d3B4SRmei3l9bsqdk+6nZhBCKhH/j49?=
 =?us-ascii?Q?tsjQE9Dix5UCZAJzczfZskQcU2x0E22Devtunn7iJi54cX7krtVh1+p8rVKk?=
 =?us-ascii?Q?6RCCaBFdjk3BmvxFXRHw32ErWvW+vBrVjUiPQEdd4VTGakwd5rRdA7gstyKC?=
 =?us-ascii?Q?inNWaBtf8mY+2av2gWasCszoat3lCBw+lclT/Aa2GVO2C+y0mgNZWT4/c4F9?=
 =?us-ascii?Q?WFMND9rrD/RL9ZtbB94/YNDw99JqYKL6McSUIalCKtEwE2W6/HpkeR4SvPL/?=
 =?us-ascii?Q?A2KWu/ubY75Pzvys8IVrgn8Ql/P7ATfYmj+HdfFiGqd5Ug46Q+oIojvdGvgj?=
 =?us-ascii?Q?6Qx8ECjGFNapJcVo2qijAlClZVutsePKymOTdxgDE2zvP/GEgwirB3f+RDhx?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4b7528-a762-49ed-8815-08dac13cebb2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:54:22.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcULr8YJ9DahbHj50nMtHzvCKOMQv97VHjg1W7Aa+phWFOFwRl9dCxR7Hrgz8gGT3nE+rUCUS8f3DPcK9/+gB/hau0k9ODpTO23OHJuakig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=803 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080019
X-Proofpoint-ORIG-GUID: eHyqbFYCJidYk6oX9jpCz2VYA5rF2YwU
X-Proofpoint-GUID: eHyqbFYCJidYk6oX9jpCz2VYA5rF2YwU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> strtobool() is the same as kstrtobool().  However, the latter is more
> used within the kernel.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
