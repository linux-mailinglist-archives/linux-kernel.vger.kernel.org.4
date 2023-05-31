Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5A718E01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEaWE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEaWE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:04:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA7139;
        Wed, 31 May 2023 15:04:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJstdG009433;
        Wed, 31 May 2023 22:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=RGnneFg9/ZU+Sm9YtbGLHimlLVjV9O4omW5+bo9Xn98lqryreI+hc4K2lsqgD7Qa+T/V
 3dKJAA4zNIzsJuC6e1aQ6/lawbL5ZMWPwotJJhw8JePPx6zHfPvHqzntrARAP+mXHAxX
 x2HyQbw30D3/6SNz+uAwSb/TRecszgEwXLKw/IqqIfZEMlMbv/Exei5uLI0Lw83zkDcW
 Em+RPpUk19GYeht5EfMXBW72Rd8j0COIRuzJntFpOR4f12/TpTa4PYtWFgf1xA4+m3+k
 KGSDRPII+xOYQeuIk1HkYziWeb0SIOwmDVE/a5R5+DL2c9syBxwaaWf6Ju5LX0lPQv/N aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkq570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:04:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKnGAD030150;
        Wed, 31 May 2023 22:03:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a71d4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDVHQWWjgz/StqcPH2ElyAEPElgsuTNI/lscEg/595aUadQSzDxICASKhAXq9VPMIOnqKHsxUV6LsP1Ng43zjCzkzE2aN7L16/hoyru6ldkWcEo43bCrKAOA9UX3Hv81JOS9Wb4EdPpoS5vcN6s7+3ll0TVDiU20WtpaUrqzsis2vQI9lu4JWkWsLT6X48TIUgIh54oc5Bcj6rrWF9qAHh2uK7HK7T06w20nJ+vFClJwgdT6Wmz2Y2KiM7RHJGKV68RPwAoXpJLAj+cMFPBcnXlngITKvEZwHU4iSHReGkxeYQpphJ8rrafYrhlxYObMh9x8eRfpBK4RVfIeIoEuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=EWtOyV2+POmQDbz2KS2BoDvoMWwnunHXARC4ipQ04CTFKiWO8weGv6TnBthStsEylWGSBXycrEE44xjfSYiLAIfXoToRJxAkU4/V0loIJ1essqaSRLSmfXxzNtZJOBp2uMNRaB1/8a7T9JZw6TJj7k8nJ2MBZii4qA1WYzhLa4CEXIU+vAqBiuHhn1HxrT9zBQx3X7ic5Vo27DgfVCb+k3zJkOzAyW/o7ERb1rr62iPWB7gH5tJyGFj7C7h527zSCOPvIixqbTwxNxPh5OqfeuhVLFJuzUWwcKv+IBVNHkrWqqe7KlXISJRb3OPobnp0zX8kDVj+HYN5bBMloM0VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=GGK0kbiPVSU2JS3Iz/nQpfWl0egogoSWF6FXBlM3uTYoHWt2Os09v79XAuDiweIeZBWu5Kg84b0LlASZeKh8Uy/R3IfTxSzcp2f0qvu/ZEOc/ZIiXsydPbrmxrUfCBLHcJAGXvoAswAO5FwUbK26yphPSN2uiHoh6/vQa2w5Acs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB7463.namprd10.prod.outlook.com (2603:10b6:610:181::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 22:03:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:03:56 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        linux-hardening@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: Replace all non-returning
 strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttvscg59.fsf@ca-mkp.ca.oracle.com>
References: <20230530160248.411637-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:03:54 -0400
In-Reply-To: <20230530160248.411637-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 16:02:48 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA1PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 821008b2-0eae-4a06-c2db-08db6222ee18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aa/Q4v8JPSiqKY7xIT6jFe2NRzN37HFhUDAOgRd5LytSCQ+BAoONDqPHeiMAq5s+/K0wX3BNmyRbdDA9Wpj3ZoNcFew+t3fPfkBy66teb6tinoyNS7BpMp7l9eNhwoWjSPT6NGzMHYJIA7dUwLNLVLDLsRk1+oRq5UnBQ3hYF4MiHu0NodfXalbO+UOZPVkMTBhhvDSbby7MgldGPo9fywB1+ohZWLbVYjgPFnrxQJ8Z+2l33BHQxNvsttzybR1+ALUypM4Qz8ul/Jap15c3rHx79BqcXPc5f/xyD5VPzJzVPa8iDRJy0Ep2yH5S7m3vD3ZUxfLRPzQY8HwZGUnNtehSyhNf+z/lR6F7z7uooCqgEXqWK3eLhSLCVbRFcsA1QDbdybPfziXUeVPihEbhtOhIixA0SiiHIu72JbEXRZxxAxx8/qx+992+pbcLuSuUg0sLaSO7QbXI8XZO2/L5+GIbkbzw/iH6GXDk+ySTLOJwilCXzn45rTIAQGWT9cfBoW/aMeBgT0z2OMwLcQhipmZyQoTI7dKN9XlDFC0/XZU5PdnmXFkhdfeMA0bBNaSuLaB/xuERLxzjEqRwg9A3zmAsUUc8LQQdPeF5c0ZMue4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(6486002)(41300700001)(86362001)(36916002)(4326008)(6916009)(316002)(66946007)(66476007)(66556008)(83380400001)(186003)(6506007)(6512007)(26005)(5660300002)(4744005)(2906002)(8676002)(8936002)(54906003)(478600001)(38100700002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQA1FtXs4TDs4yqca9Zc+lXRj7FjPgmFiThgAeESCtaEq/g26FgFDeR66T4E?=
 =?us-ascii?Q?LeCGuXcRo0O7th9qvc6mT/w/kezWGIa0C5ZU+iCtfb7iX6VKUOo8GsmLb4bT?=
 =?us-ascii?Q?Ct6yWqQaMTMqAr2DV/CygHkKVHHr2iJHMzonQxdmhCKbH8XB3pbnFNrxzDLZ?=
 =?us-ascii?Q?7HmcAFdzoa8ttX+dr+ZROH1/lfbTJv7jTp3CDaXvlweeUx77PMz+gQ7l7rJn?=
 =?us-ascii?Q?mKyjEjWMqM28ARo5wRPcHsf2NPwdQUpATGJkudXSSUmSHg30mk58WnKu8CLt?=
 =?us-ascii?Q?44d8GkXimIPoYWsJJVWXEECw8Xkq7eBjKQ9WIit260nvId6JmbkvlXtPkEXD?=
 =?us-ascii?Q?1OPRf7Q8fTgP3EaypeSUGxGIejX/svU7SM/UefxZ/sJZb/+/P8FnphoxKvJ0?=
 =?us-ascii?Q?F/3oTeZDRF83BC1ATKL6CUySrH85AJz4oJs+s+9mGR2ej0SajWbZ3lEtT6TW?=
 =?us-ascii?Q?cb+uIlz8RPX/NMgspYHHjE2+0eqY3Amp6lPB0WvnaDe3hEykvaoVS1y4Zq+H?=
 =?us-ascii?Q?nVQa97JsfYBsgmvPPP6JcZHVhNSd0QfPU51tXVfDj+4vjpXXcuvmn4WHOsGo?=
 =?us-ascii?Q?WKpVWVMC8siN/9ShThEBuPaNVHlh3BpLnR+MXUwbH2jNaBlJ2hmN4p8uTaFz?=
 =?us-ascii?Q?+mgu4DimJ9epJB6AwmugUNZs4hiAkR3D/yQGwbDwyDWHq8IOubtgSNPqpnek?=
 =?us-ascii?Q?0UekcE4HAAOVw/n+DrP3lPJOP867hWMFV9QdDsahdnUdzncAUh207kW2ncRg?=
 =?us-ascii?Q?4+7zNBvbK0vDrNsDcDvqdMmVnngTns8rqst3X/4ri/tmgI5nuU8EAR1t8Nro?=
 =?us-ascii?Q?fG3c+qLSnXsAc1HifrconWO8y6aDLHjC3vVZ7Ob6GWsvq9LA2snIPcKLGJBC?=
 =?us-ascii?Q?/PeEzzD/Q4KD8fPhJbN8xFLRMijrdyPvwRZpcLN1WELOkmo/VInNYOj9UQQS?=
 =?us-ascii?Q?PW0cGfMEqbm6t49/A5NXVFr0l/kS2LKU67+GeRzf4OE5vy76BLrUQdKeNmMt?=
 =?us-ascii?Q?akAwsDWkL772voOKF2sD4W477XbBVH3QT15vNv+uIZA1n5pMyTbtL7rCrYj8?=
 =?us-ascii?Q?ASzSeqTDfgxFTU9e0w1zsEqe/B07CurFdmBHIlv9bQIzpE4Zv0TYe3AXns2O?=
 =?us-ascii?Q?GmCo242aQOXUiYdwqJavfL0diKjGw6FXJKJr8kPo7SqmxhL0ENGfjud+nO1Y?=
 =?us-ascii?Q?/clx5D2AwbczfKvr9alP2sr2g3jGPrZcKMcJgAqfVIyJiGRcpASSLA/b7aKV?=
 =?us-ascii?Q?c4FgawPrKCTYoNb2ymqNFnJ+rWnx8aHT3ZIpYgQNIXkogSlHM9Ta6NArGHqA?=
 =?us-ascii?Q?Zm7MIrGyjLUxBAUjeG/FTIC6CuPKByZWzYHnXm0Q6cYsvLDq5+bFXwga1AR0?=
 =?us-ascii?Q?x57aRTPM1eX8NKCqgV4xaup+UDVZ9hZC4lEz7W1AMtExmS5GnfMDc5WnMJNG?=
 =?us-ascii?Q?G9foxcAv7kRuZlnOH7kT6BmwPSbtBksfwS2kWDxRTQuO8hFKVWX7vam4M5TW?=
 =?us-ascii?Q?ZfooC+GXPeAKDOyYqW9c8HSj5tmXWQW/WL+NgPKIBpE+TAx0ygkUlCPEx0VC?=
 =?us-ascii?Q?nj3Hww8MkCTExqmdn6BEd5vLS9lGn6nwpOyXc2VCsfv736cvLSzkE9MYJ6Vj?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kkCeYps0NI1RH0S0Pjyme3ZWu7/XQXECO4YDq1lZHEt6K8WgoinBmJtM/1d0NOcIwGxDZCB0msOnC62GVyTtUMMAHNIWT1qcBFRjlq0YT0ENyMIBGJWY5z6l9KcsywsOfQSs+zCnp6XKs6ttn5YV2bdb4VIxF8Wcz5p9MOPuCy0AK4TYSSbAtLHrPpkxqccwfq/zZpdQ6YNgRSB+dIo5MRoODEt9AkYs2UPwwMcyGv9J7xipQABOQLALBxTVqikbpxbeQDtkc5ZVAFFEGP3UJkZQFbwA/QppjcKaqPrzXSmo5c9xtwcwVs2qC4h3RRrmC+b7+DkENzC7QFrf/+EA83gCzHQOo8uUAw8D1YQw+1VVnlVAIQu7//vrP8EX2MwRPn5IhCHB6c1ytGJ2XoaN2c/NS1vGPnN+UsVwnDykGIbjxiKky78rkb4tnYnMypML2DFslspRBnd/KZ/LgLsN6UHGrvJCwkoJtFF2pGxv1NsY8vxdKUt4IMH1rcvM7p0cltwGhsDQBc9RojDF1/PVPyeqJBNKK6LhJ+wI3/2ZiYMWWxcHhg5xr+BW/oBPg6RMS3ZKSnR59Q4wmqgt2fMHJmArXZIQn8QjSpDSoCxjbU6MLoM7RKFLl0cRNwgD4YhxwZYsN9tgzXdRy1yeEzW8L6X6N4M+MkQxr6Qo++oeWu608Xw+wvcQXxTf5ctRxBH4uQ+gvw+cdLyOdzRcvFsewpY6Knu/qETXwkAlKZe3V43DstO8Nl7hrE1HO+SGn1a1USamRRg2xBxPB0n9pogApniqMraiJmB7M75CIF1aP6usZ3fq10g4ijBkfgf6t87XGpLlA7Jy1sFdhqOmmT0Vtg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821008b2-0eae-4a06-c2db-08db6222ee18
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:03:56.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQjnOukf63Z/Cp1xr/XA/E1ad2LuXU4JL4UyKiAVYKwE4Va8ZqPQLXJG6QbN+sckINyB7jkeqA4KLpMoi3vP3DwC9OlHRRfhI30O884aRXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=991 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310185
X-Proofpoint-ORIG-GUID: Oi0Y8y3tEMxhiD278XLLgBC01bfnNk1W
X-Proofpoint-GUID: Oi0Y8y3tEMxhiD278XLLgBC01bfnNk1W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
