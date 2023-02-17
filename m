Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB75F69B06A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjBQQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjBQQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:15:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453672914;
        Fri, 17 Feb 2023 08:15:10 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HFwnpZ030453;
        Fri, 17 Feb 2023 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=9Pc9VU7tubsYzvYV/0WYCkop5zQXxvC9K/YCudNeidg=;
 b=iHC78h8p38jJCtRIB5fqpCEkrS3APLmCg479hR+xYJ7RemnwcwxQJlSkF3QJN6gVH+h2
 +6CJE63vghg5zsIGkQ93NwXhPCqJKBlqjBK/TPNqq8pO/hd8khuwrOD8ipi8eYh86zVM
 so1SsLPghYunF/M1Rso1r4ZTz80X4Z5xzZy5e93S9uh37fozSnk7bLb962pyxZwXqBan
 JqNIikrmJFZOqZjKDe3K2Dsppd11CYDI/NfRxxnPsboqIrr1fzVqzW2639S9XvJf2liR
 f7yTeu4QQ/PUgpH7YumUY6VnzS9NhO2C2QrHS4t5Fo5PRx5SBzHF2xE1aTEn9HWahFOf 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtp9vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 16:14:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HFD8wZ035971;
        Fri, 17 Feb 2023 16:14:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fab2e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 16:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOSTLl/RirtnH3zzVe3Mo9w/4e2nvLQ8Zk+eaNzeQUFTpSbk+wJZHChoOV4ssKHpPJ06g5OuJe2dB3aRQE5mB1sv/xLeV0ub2Ugeu8TNOZenAD7Dr6evQlmmog8R+dM7FgkYplYbEhvmziQ6Gdu3pjLL3UNYUe95jxMI107owMiFQOt5v5wGtPWxdwpHI8wZm1GiW4jou3NHbx/hbzLQaGRl+0A5wOB1JXPxf4R0XWFUVXRrWsGPzMdMIeQMjNo6J2HN8FXdRXncLc2+w1iSetllwZLc6WfFRV8heob9hxac4QMvrVWHN4yV0Ugxz068WGI4X0/5FCt/q73lZHsjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5heF+cBJAAND6fRw4nyNeYp6X3msMuS8U5MTPugVUSo=;
 b=b5skDfEtfbBS9vpKjH1cvlQkrpVnRZT5yvRpcS88OpeZ5Ef5GX0piLRODTzzidSNnXM3uRc/Y7iF5aUbiFMPE9ggdWSwzpuI7gTtK6NEwtBLnrpGHgY9h22//FDX+xwej6oZNIXlqa9l70rQEZ6CSOF4HZLZe9IXj08RpdJrGCfEbUpSx4/xYfVKcg3kDzw6vrdI1ZrBSIuSLGeFbe7V1uUrwbbqFA02j7oHwaivYNlTNkPEckrz6HsSmjc6imbEtcdHRt8Snvh4ot/SU9jkYaxztvpHXbZ6ZjqoFvD2CSJ8TWvRY6yHuiINOJSIfbE3f6OhZniUX3OehtwBDlHAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5heF+cBJAAND6fRw4nyNeYp6X3msMuS8U5MTPugVUSo=;
 b=X9VrSj0awiP7ytxD3Py3Up6S9UxnXFkWNIQz801R6JtSqR0q/V2pp2kR90bXzolhEwSii/mFerKFe4wvfB1eWF9XElDi9McKbAK8mrQRyXupTezzWnhK09p6ODg2CkD2uUlzzbi5R+m4rrXnJqKVVnrBKVPiWdmowqV3hL70ZmI=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA1PR10MB6471.namprd10.prod.outlook.com (2603:10b6:806:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 16:14:54 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f%3]) with mapi id 15.20.6134.012; Fri, 17 Feb 2023
 16:14:54 +0000
Date:   Fri, 17 Feb 2023 11:14:50 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Make kobj_type structure constant
Message-ID: <20230217161450.blix7iek7duexlic@parnassus.localdomain>
References: <20230217-kobj_type-padata-v1-1-e70b6cab4875@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230217-kobj_type-padata-v1-1-e70b6cab4875@weissschuh.net>
X-ClientProxiedBy: MN2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:208:15e::34) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA1PR10MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: ad874ef4-fedb-4f2a-5a03-08db11021aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: werQxZYn2t/kzZuHoi3HUZBgyedVVonlZqMffoiXNC2eTFtBvXA1Wv/yrvp+Rws6UnftH3qQqrd/4hLJgec6w1I+EhzCARxQ4MPnHGGzsPyS4pZ9eZyTp1of9LBUI7ya8uze0jjLaB8HHc5F6Q92XyXQiXufnhYYYYYq0T4EhLz1aJyjj+Imc8GUs/cTZ+4cFe2yuQjm1NvXkui55aXZ2RTZqrWBCecg2H/LMulVkU31RXLiZYIfnaxuAKpAq4csVTVQ21TC+A2PaLnK4e11JEPjrMQ9Oq3GUsQwO8xh6i8t3YV7oOfbHO35lbv5LapAV5XrtHq4pQEUmIQALovV9BGYe9DT94daeAV7LK3dxm72NmN0hHlx0u4vhDLIGWHK6jYNo5u1AJ9qerxEU114MuujIBYocURqtK505jUGU06aF4tMy/OXPDrsFssTbsNWo16EYkLfOSC+vbNTBgDx+VUmzjZZIcWHq6CthSMB5IUM1n0OBSRDGjqHp6dEK8H2dV2o/Ur0ec2ifw/X0ctTig2HqYmwf73Vwi3eewCLNyclygrW8lj98ocUK3dEtJYf2b1nAtnBuukL8VRarT+SuHI1rFEfe/+RgwyRgKpKhxA1D3LTP/e66sDCKbNa4Z4JBkkLPp1vg3u/LFHeP9uYbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(8676002)(66556008)(66946007)(66476007)(86362001)(38100700002)(2906002)(66574015)(6486002)(478600001)(6512007)(6506007)(1076003)(5660300002)(316002)(6666004)(9686003)(83380400001)(26005)(6916009)(41300700001)(186003)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rvJh+16N4vW94NxUh4uIr4jMJdn71FS4nU4BoL4JGkdrmmYVuyfi0jVpWu?=
 =?iso-8859-1?Q?QQjZp+ApcjC+bAJ7NMe3pPQKUm3h0f5fz/O565Nx+DPdHpC7SFGaJu+SW0?=
 =?iso-8859-1?Q?pdD8GhToB/+39+A9WEi0P5Q2SZzFO0RqJoNt+jdMZJjgjtIWoyA1+n50nj?=
 =?iso-8859-1?Q?nBwM5JZWt1d2wiWaCFbMRWeZfY/FdeZ4Whi2fFRYzuyj8zhbxJYEBS7FzQ?=
 =?iso-8859-1?Q?t/+TuKbzqrS8R+oEAxJTKlOufSpJcP/HTHPD+gFYrV7dMh0R3DjJcdKptD?=
 =?iso-8859-1?Q?YWW3/EQ1xtnl+FTxbSfIG4gsVR7BevL/xCU+dzj3Trt50bYT+tZ1AmJ7wm?=
 =?iso-8859-1?Q?Z5vq+UtDQb7LJ4SekRSmttoUzskex9Dy3FRnXXjmIG6LHOmBD++2batZxH?=
 =?iso-8859-1?Q?0UxKEUjHoaWo5NXwNTsesugyk5AgJNSi/gqCT/OhmdijNppAIJGvk+9b7E?=
 =?iso-8859-1?Q?i5KDGvjz9aac+RDLNl29Vr0uiaOBERVGrBTsJ/9Xp6y8VV6VBZv9lfEPle?=
 =?iso-8859-1?Q?cyIO4obCp4MYwheKq/kclafJ/vJED2QNGw4FEp4S5gEVw4RAk7hy6Srbel?=
 =?iso-8859-1?Q?52o46vx/4kwK+DRm9C+4lKIOoYCzQcrvRpsI3vTl5PLNljbsUFJ9mUbBOe?=
 =?iso-8859-1?Q?nhfk6b4aMH//8QWRk+xzmTF+pVGKxQlXKFEgQkUw208f+xHkK+UM534OJv?=
 =?iso-8859-1?Q?a7PMQGWP71DuezVMAUuuYRRk7ggQgWeKAT0eP4STuH31B7fNrogofMtpLd?=
 =?iso-8859-1?Q?81DAoi3UzySuMVlhpl9gB4bvHAfw3oEiJmWDpEqPdWUru7Sl+3r2Yx65wi?=
 =?iso-8859-1?Q?GMZfzOJ7gdrPV9Tvkto7HbyMS+Cg5nZAZqKCc6aUvjvfnIG07BD+PnnVa2?=
 =?iso-8859-1?Q?vqqNmzts3bhplrO6YqJs/wnDzzs1I6kz0v9kKlC4rlOKzqEoiOo2DUFNIQ?=
 =?iso-8859-1?Q?QvyOw5XeGCi15Gu3wdfQbioV/AREDg89Lg2YOHRSHQgM8BY2iFr2chxgp5?=
 =?iso-8859-1?Q?aWMA//yAXc1sAgadRHD7/f2ucqxbGkAcsFgsaI5DCvtQnAOjyiTRsLLCvJ?=
 =?iso-8859-1?Q?udwBxs6Q5YRkJ8FuJPZef9zvy8y6+8SpnuUxf+CUS+l8qjuo1mgPN2kbjT?=
 =?iso-8859-1?Q?Q88MXUCg8qSAMaazEapW7VE5pzSZLPeZEgRrBQMeAotpOg8jTYApi5mGyx?=
 =?iso-8859-1?Q?mb1HEQY8mTWwn6hPv6z5XTma3LiZq5b+M65lYHUdTaRuOEie5qZ3Y+oSlY?=
 =?iso-8859-1?Q?8XQQ6kWf6OkP5cdc9GOMKioDYg/DjVhY5jJ6f0MFXDnqYnEZVKgQzuNBRj?=
 =?iso-8859-1?Q?fzDuq/r5qMRmoXROhZ5az+Dj9Iq2WenvUM4mK+Tc+P+zRDJNyg7NQb1jQb?=
 =?iso-8859-1?Q?1wUe4hpVT8uX2XVTqYLZD+kF9jdWffHvz2Sf50Rqb3lmrY2+nMF/zTz9xt?=
 =?iso-8859-1?Q?/X9Q4BBZBcYrNQ5Gxma/M2HTVGYg4XeU/yYND7BTu3a5vkBVarggFxub+I?=
 =?iso-8859-1?Q?vAUChbszgLuwmQVuMVGXugI8NtqwwTJojUdhqQ3KSQPzBgTvoMVKKX8rQq?=
 =?iso-8859-1?Q?E/WnhRreoObmWeixOOhgoAmtMR2LPvfurMcvPYz+uulECw9NaGMA5xfIsh?=
 =?iso-8859-1?Q?I5JfNaj172WCf1rBNYecngX/AdgWogc0602B3iHXtitUBDW9kHhu72pw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dy6LlPmwLe+ncs6l5MtDRolW6/UutydZ3jWCAsFU09rhiXhjjh5ICgP9/OT1ib1lD+8ct8LI0VSe1gEZF9LdAJBT/0R12j2sm+T9gxXJMMEk5Kw5GMk1jvz1Ou1JV6xJ88tnbVCVltFb/ijrC6IDIT3hx9Ezm7COVmMfwY4xDivwnv7WTe3QJa2uKclqPHITFrnQkwlvep7gjqxGzKzR7CcKrqR0G+ENv2Xofobhpb+e2k0v/eJMMEXFhm0QVGq5IR89G4+M8V6XCtjpTsx8NRSpQfFR8Np2v3bCFpBeS9wwDjN+Sl6wouR7wWDgJi5b4a8VrYG+jsIGUOAkSb1yzEyzAouQkzhW2sekBunjYpfOh21egE7XfGlMTxD3zSSr4wlaeW4xPbFCwrA3xCeL76hkafaFDnaIcD1j9xlaTY1r20hHVZLcuHTOkKdWy/i4IXR0INaG5zOExDzkuQpbDWD3Mkbu+mGJZJl97YPtMp0wchp8XPy/wxVQHNDp2pX6r+L40A5Y3RD52PTa0fM3UNT++rkjk3V4Ij64u6MZ0X1qfmfbWNQGSvtDfP/H+ESl1Wsn4KwPIpdpZ7DWljYn01yEGh0L0fR0K0x1FEfBrwBeUCzx8A9zJQ3YFUU8V06tsiwFZaqhWZt6MhR4F6kuGU1njS9hlyh0a5Vu75hi+SBw/0kPXYU7qoMg72haj6NISQSUuEAYKvNwyBKh1igAkO3IGweRJ7uF+iCB6dbR4pBRmPSg5xqfUF1lLpqJ7rlJWNr1B4uV5ZBEqCL624i7OMPFfLsi/aYFgDqaO2I/UtMSRIJwSpZ6c2jfNlK4h0ZP+ICLwWev4+3UdSQvBEAPaQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad874ef4-fedb-4f2a-5a03-08db11021aa8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 16:14:53.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1R8MwLdi1tGFPaIy5Il7VCjypfUYVkVOVVZU4ObEwxNYna9vEThLQwMd35PdgnPZTU+N2rKCbB8JGBI9jyoXBjK9iSLy+UMAGYiRPELu80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170144
X-Proofpoint-GUID: wGipZ43OcmKd7QiNSycIE5v5qo-ucxXl
X-Proofpoint-ORIG-GUID: wGipZ43OcmKd7QiNSycIE5v5qo-ucxXl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:17:49AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

I see the symbol in .rodata now.  Thanks.

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> ---
>  kernel/padata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e007b8a4b738..106d08ee9ce2 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -967,7 +967,7 @@ static const struct sysfs_ops padata_sysfs_ops = {
>  	.store = padata_sysfs_store,
>  };
>  
> -static struct kobj_type padata_attr_type = {
> +static const struct kobj_type padata_attr_type = {
>  	.sysfs_ops = &padata_sysfs_ops,
>  	.default_groups = padata_default_groups,
>  	.release = padata_sysfs_release,
> 
> ---
> base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
> change-id: 20230217-kobj_type-padata-288edceca728
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
