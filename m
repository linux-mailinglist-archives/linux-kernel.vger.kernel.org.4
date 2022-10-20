Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB21560546E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJTASi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJTASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:18:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A818F0F4;
        Wed, 19 Oct 2022 17:18:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JM4HMs009948;
        Thu, 20 Oct 2022 00:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=E4+ISWZb9HB368hh4Ek8V5FLGUThf/V6dvWfcNq1phg=;
 b=eKIwVyxW2pfRbn3ZUwBTWu2En6yZBTmy1aQMwLc/PVpIj9QifpR45zxoMP+TtZexwmHM
 JScPNoV6v3JqW+rK05FEeU2ZTuf8ikmL+B7npT/6Se8IklYOst/NjHwCWZHT9oSphnZD
 SA4FoG/Lmyr8PbzcN5uUAlVWvb3PiucaR1xbgkvT6pv8wwAdzJqCY3ookSVySN3m/cp4
 G+jybig9RzfLy5aZHZbxrKc9X/FoXIRUZbZj01LBX2eHr778tmKy7u0ziHxoxq+92qd7
 fvzO+tmKtOtlfc5s216L3tedobXt74iHBsAmyeCTnZXzqVTugTOmyxFR+2Y7CTBFwesa xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sq039-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 00:18:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JNwkIK013911;
        Thu, 20 Oct 2022 00:18:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu9ajd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 00:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKn9fpp53R2MRuRMNzKOgkf4HoUzr6x5BVj+rbd/QJVdiFOylDanRGmha9l6t44J+iVxtLN9YK57ifRic9kQaJaRZsRJixkeOqMoo91Ih7P3q93C4NqHAmUzuF0pOyVOlk5EK+3ISnF1E7uhMjk2rQE5SQCkvYs/cALSBMbbb23nZ9HZpQMLAlS+7FgsvgW6JHj1gDzhIcVN4RjyqpZ+A+mtEvX2YYEgK3nn+jmFjo84sPo/RhnENqT3cRges731rhavmD4teywzdO7qRoe+0qzkIaoSXnwE0xcQmgAHriDrKKfFMBLKIV8FtpitkcWJVVk3Bf5Mv6XEyL2gqCr7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4+ISWZb9HB368hh4Ek8V5FLGUThf/V6dvWfcNq1phg=;
 b=aI3F2ZCvtGYh8a1T0RyCGsLzPvMg+WxHQXm6Spc1+BNyvAi1hnWpwiLIv0IjbBAE1Eh5JXQSO+h0MDeBtnKcrwjy/ihh8z8ntBSAHZ/Oh1Dt6E33lVZr5iSs7xfkifxVpMpKTqPcRDYcOiG7pyOiBqA3zuZvJB5N6rz+n3fz6TMcbfN1Wl6518Ia4gsHLiOAEt4s7XKmuP9/q8l8qNLfzQfvPOnI8guH4B7WT+qpor04RD2ThHHH+GpfUDG8Ybql31iH+Ud1l3xxEcNnSWbEw2UN9QuYEAYQfbA84t0RMAPKA33n5GDU2/+1PkXi+RHu0Ts9Zz7EU9BeVD2iNkOi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4+ISWZb9HB368hh4Ek8V5FLGUThf/V6dvWfcNq1phg=;
 b=qgmjjoYVjOMLi/sYr+1N3uQfghgQKtPA7+I36AksqHBBPn9d/7HaP1EmuYZ0bzBOMET/p69SS84iTbdK4A7/rAkZNaEzP5ndmUyWgI04i/JKrVX6zoZhR6CWlfPrYslcKgRkKxC9izV8ua7wgHJ5Grg3lzGxykTa5qz87/DmRoI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5302.namprd10.prod.outlook.com (2603:10b6:408:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 00:18:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8714:e5ca:3c31:7bf]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8714:e5ca:3c31:7bf%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 00:18:06 +0000
To:     Xingui Yang <yangxingui@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <john.garry@huawei.com>
Subject: Re: [PATCH] scsi: sd: Update dix config everytime
 sd_revalidate_disk is called
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6zzz740.fsf@ca-mkp.ca.oracle.com>
References: <20221019081825.20794-1-yangxingui@huawei.com>
Date:   Wed, 19 Oct 2022 20:18:03 -0400
In-Reply-To: <20221019081825.20794-1-yangxingui@huawei.com> (Xingui Yang's
        message of "Wed, 19 Oct 2022 08:18:25 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6cca49-a9d7-4c59-b501-08dab2308f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxXJUmBlPfMfbcnpcUXZdC9DRdW/SmlGRwiqtN4OhqM5YTI8PZ2BF084bYeQYV/UnB0FfOOJyi9QgdJDtAjKbKRNQatjuXRUffzXAXPem4ootWCc5Co4hV+oZCPNHL/3gbrIxdAtsBvmWZOhS0Sm9JJEtB8szCexhaHAFoI+izl9X3R2lG1xqR5ryLTDtTYiP1gWrc5kHuIVKwA7G2zyiirIbfT+szNJ++r2ICjFk/1OG3c6t+yNB3SB5JvUWTRworWCLCXdhhvvkcNj5lrDWJpTv1KTQLDs5CqYc/RAi9A3OGLg1B5I/+Hh5l0Lc5YrDZvIkFKklwvK+G1i/1NWOn5/HuxDcZYRDPHeS8hWOfoi8TA/Venpyl/QRygh3Xr/lNNobyiWKLaTUyA4EpryIdyQ/xIXjebtfNFxmMuyCK6CQL6SNVOrWStw+HhIa5z75Hp6f6YhoQaUeDch+CyR9huAinNtVBGMQOlDh0dEjQFG2XvGaWa4jZ6f4Hej9GKFpHUEcl5n+6ZVhA9+F2KxpBsGjmgCK8yM8sWL107eYmdTz+dGr7+Ov+ph7DkFY4DCupVHh8BJwl1CIamlbJmTXnl1SzUUAGz+vpg3RnlaEf7HR/7RW9DWF8DrBAhhwpmm/mygDWbflG62XWdeOIOMCULWtzcoAJq+9aj4MU0k3cxvQ1akO7UcXWp96eic9SunB0fCFxQR7R5BLdv1PmKUsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(478600001)(83380400001)(86362001)(6486002)(66946007)(4326008)(66476007)(66556008)(6506007)(6666004)(8676002)(36916002)(41300700001)(316002)(26005)(6512007)(8936002)(6916009)(4744005)(5660300002)(54906003)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIp3bcqGEgIv86g7CxFf+KPiATmBDgtTsRGMuQlQGiQM7SDKqcRT52uJ+W78?=
 =?us-ascii?Q?TCv+F2c4/ABOq6svQr7UAD6DCSTjC2C0YsU3ep1RSf2nlcCzMTZ34nr7t5Kx?=
 =?us-ascii?Q?wndNNk4Q9XAhxyRayg8h2QOvSCUVyHTah4C6ESKKvjYYC7K3wqzySebHNI+y?=
 =?us-ascii?Q?NWOv15WdOyB716W4JLe063VAWz6/YCnTt/osq6KNRa2hBXCp3lFRwuqEaHA4?=
 =?us-ascii?Q?VMWh8PsDvdD6G66Nq3KdiDAbl3feJT2DCOqbJJPaGj+8j38JkKGuh+WBs4mO?=
 =?us-ascii?Q?bFeaVGQL5HL/tskz7DCNtAy889cBf+83Ys86BuqHTkhqYNEMjOOVuR+vc3QX?=
 =?us-ascii?Q?kNqAonjTjqMxQKxaiaaGW1SzDAUqvjsJOiBmIUbn0aOcRNRZTyTa8U7rVlD9?=
 =?us-ascii?Q?NlT/vPoZvqS5yoFFzfVlku7zRtzVOzH9a59C6kRo4gnPVdkaEXi/ItSGnmmx?=
 =?us-ascii?Q?rHnDYXS1YEatcqUnuXCj0NDlHB+jvfl+ehNSsWh5FfgGWMUBdx21FJYVRCjg?=
 =?us-ascii?Q?JxKu8YM7SVJqVbVgnZxqCs9kVNM8V1JH5CWwB5Jcp34A/vnB48RfzJUqaSNd?=
 =?us-ascii?Q?cs/+9BMQc7hAMV2uj0+SltSF+j7iR1yqQTlyEA5Evxe5SK43AczXkEHHHpL2?=
 =?us-ascii?Q?j4/mIoVous7/ef2STkyLFYx3NSsfTL6ESb6e5CPrUEyIqkzbatsf993/seop?=
 =?us-ascii?Q?1/scL/bs5wrYZeGDGwE8ITOfGsV95HyTh4qye41iU6DpuIluGOYP5LL6c8i1?=
 =?us-ascii?Q?Iu62YCWf3bEM481d2hFkgOzDkm+WRN3TSMqKq8hLf93VIbWdVE08FWTIcrQh?=
 =?us-ascii?Q?QgnioaVeWLpp4IxbDDyjyQq2cnmVZ1FPZWHeR9CkxpHAX/TYJVvP2ghKCmuO?=
 =?us-ascii?Q?2Ek3mdB2LHot+oQMHWw+1gCGvh1NuNLL6nfcFxaiHoLUVe+/nrNEBSahh4yN?=
 =?us-ascii?Q?NiTBcm9+ebrd7rQnL3SGIXDDnvx9BCH1iZvzClfXa8aVE199yI8XsokTU3O2?=
 =?us-ascii?Q?+ntKlLFHk5K2QZbh28T8OFN/U5BrPgyY6azlnE6MqByIxmykg0qKqbUAF9kG?=
 =?us-ascii?Q?8fyxtyO5r/LE/kuLD1ahQvlmG5Jz1in3U5CgduzPXvmT1ITNqhS48glnjga3?=
 =?us-ascii?Q?rF2/BkssY6lIQLeVrpKxCO6wR2jY/IbJbeXMoHwg4idu8hQRGkl5OdsaOAAK?=
 =?us-ascii?Q?ZnTGHYL7BPNuPa52a6MT6768a26PlwMDSkNm3A7TVs1V1JbdtXOyXgeJmfgo?=
 =?us-ascii?Q?BjU83v1PixfJt8AVwTxZRXoNPUE2LPRSfdyy+09cH6NPderDWsriiRbcdjXj?=
 =?us-ascii?Q?Lj1wDKyYOyN2zJUM0XNfbRsRgJZd8TAXdFa4Z132C/ymxqiQ34K5PQ93yRbr?=
 =?us-ascii?Q?I/EMwug7MDQ2FuoZt+80RW8zJlisRL1OncIwvEjPJcssomuVtWciQbMeIxT3?=
 =?us-ascii?Q?a17CpM+BQs4U5UHyyTiLZWobBi+/0deHsgD4jdgiy1nKU4pKoJEHh1/fmNWi?=
 =?us-ascii?Q?+XvQ3Xn2FERL5vn+RhjIKsfN1Hwg7E9PYBpkJJBpSjVl+Lj0cfGrPkdW8EF/?=
 =?us-ascii?Q?AgKp/BXz4RZfdo4EtXLCh+pjRGBDFCuaujCCbe0peppVJuX5tHVpfScv/OcZ?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6cca49-a9d7-4c59-b501-08dab2308f5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 00:18:06.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drmCaWD30Y6GgIsYzwUmy+Q1wRLgNOW7QTNQUbSA09bp1Hl30YmB1oeOUfG1KKKorVA0iK/fR1Qv77WHbuMf5YD33HTvtZem0Hssty7xcew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_13,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=771 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200000
X-Proofpoint-GUID: nos3pIJ36RedcNCvkz4Gvn8RXJNqILtK
X-Proofpoint-ORIG-GUID: nos3pIJ36RedcNCvkz4Gvn8RXJNqILtK
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
> flow, the DIX is kept enabled which is not correct

DIX is orthogonal to DIF and a host property. DIX should not be disabled
just because the disk is no longer formatted with protection
information.

That said, your patch is probably fine. I'll take a closer look
tomorrow.

-- 
Martin K. Petersen	Oracle Linux Engineering
