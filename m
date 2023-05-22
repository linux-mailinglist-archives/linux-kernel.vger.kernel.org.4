Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D370CDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjEVW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjEVW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:26:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFECC4;
        Mon, 22 May 2023 15:26:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNsgo001974;
        Mon, 22 May 2023 22:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=AFSDJce+s65bBZZrXWpGKXZI/PSOReaMuXLk81szQO0=;
 b=tEb1K0UDUD9EbYF9PI+INtd0XKhboVncjbLSZXRU93T95JfF+rxVN1w6t+joPlI0zSV8
 QJtzCEB+tvkjoLiVg501B/TqtlWQNOsWzv/qcPIw6y210KaXDPEJ9VG7otXAmYOrVdV1
 6xJmU9GL35ENPRYbgj7VCwI+3UW7MB1YzP2ZjS/Qi9Uows3Z36AKETdBgtF5eGy3rjLx
 CNAvfioDXKbsYLQOXk8P/1ZZhqSpP6BLlGJaUS/u5HJEeGV+wzbHbps+hPmybQZkodvr
 Q8GF7NVGSZYd7mMy+68iJ8eWz9+KdCU7ha1AGlhEdawJFWa3SLkA5iXtBLzn3c+NSm+M 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44krvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:26:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLrZkj027323;
        Mon, 22 May 2023 22:26:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2csyqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IESpy74c/FkbKpuFLxcTCOu8QVl9ispVXmEcVxBBmt/JEji/wVxQWa9NytH7iEhKGpDjZ3zgE+OTP6bVBahigW6YjzFmP3rE9ejbwNrbfOc3741b+gdXo0XoraBUZO4/JDvX8rVL4UE4hjuWUudO9eQumaGdcJpZY4RqfxwrlVVQI/1shPxwXfxaCXNajzEQNyV12/xYPsgO3gzgGLPrVcdCacmuPYlNOXhHKmeB3pCMVJT5m/05s6fXT9wWFa+17fmHXJBIv2RjxSHSurB8U6wh/dSXJDna5xkRXFu1Lj5KPN3wBLzw/L77CG7+kcx4j3wlX7DxXVCTkINCVBhsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFSDJce+s65bBZZrXWpGKXZI/PSOReaMuXLk81szQO0=;
 b=NR/bo47PkS32KE+u6xxd9iMMU66dURl5+DiVA56pP4622b0W1CBntZzJmEFH3JjwZGX5km0vDRE8XurmjknYCXBrvfTyulv5VrRXYbB14srJ+lfuc/rGCQ8Yr0z+7OLuoS2TVejyoSJwR7DIxM6yUoGLLycE0rWDoo3LMIUUU/ZX4HXfn/pffc0l5nfCHl44og8rXoGEmVvChxyFXc6TJdg3ZwdTjQjilBHvde1fm2cm8F6x8mEymLrzETMAV2HojNB7c1rtBPbNIijy12qsopD3dniDGRanRf59DCJxo16jFWcAzEMuBj4BVocYE73GKoCr9n0rm/8F8yWe+1tKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFSDJce+s65bBZZrXWpGKXZI/PSOReaMuXLk81szQO0=;
 b=mdo1uO/TDjrW3rKejrvj0dWtoQsy4b+ulirJlQM0wSvFmufaCDk8tSVic65InDfdBQ6vIYbPfFqmwhpJuqF0ogaSDsSR8z4bsifHo/78FYJnFGGjjfrBuufH4Rk/9HhogoKErG+yHqTf4p4D6NAw0enVuTb/nSNpAFOBtHjRhnc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7455.namprd10.prod.outlook.com (2603:10b6:8:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:26:08 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:26:08 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm6sm34j.fsf@ca-mkp.ca.oracle.com>
References: <20230511123432.5793-1-jgross@suse.com>
        <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
        <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
        <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
        <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
        <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
        <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
        <73fd2741-3730-ca1d-7e23-0bf9cf10f423@suse.com>
Date:   Mon, 22 May 2023 18:26:06 -0400
In-Reply-To: <73fd2741-3730-ca1d-7e23-0bf9cf10f423@suse.com> (Juergen Gross's
        message of "Sun, 21 May 2023 07:23:56 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:806:122::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 367b0a90-e5e1-4d78-f104-08db5b138a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN9fsO9cmmu/M57I8XbH6BIdNLgyZHb3U60xiU+dZxAOGruTUeVA/UrEWMar27LvScQXTTOCPKTY95gA7P3UgJQOG+qL3oX0I9mM/PbF15NKuB54cMruYRuqyYPNvvFrkKVofVPecKqUCGjq7FjIaC8Z/wF9XhCbHXSBW/IlSUyCdIbQ/LxnOSUPz1oW8dgHBGbW/cvWmPVuyd1+OtBxohPh3pqt09rZeYToxX+IisUUbHkLxYTF1NyBDZuAhVMq8V2uCestMQVz6ZUf+5YzkOxv0+H/0qrAMb7KfUsirkk/aGxlLf/1OBDqt0o8Q9nCroWDeFh9X/E6EAOgbSxi2sSmgo8p6s0qaPgi2l+bXc6F14Z9Ft9pMDvIikyuAuXB6MATgbVZushu9sZDs6l8xtQmCZrJ0ZQT0w+HjVgBnYiS+OSKhlDCaUJIdOVFgcHq+kXYXu5Hl3do4tChUuPSSx3mAh91Ll8l3MTz2QQtBtlKe+smqSP+fiSkaWvjfNAhmeSRFA2PQjIUnbxe6qZcLz4lzwJLBoIV7kP7mpbxxCcVmliyOWXnG8TZWNeVzg70
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(8936002)(5660300002)(83380400001)(6512007)(186003)(6506007)(26005)(86362001)(38100700002)(478600001)(36916002)(41300700001)(4326008)(6916009)(66476007)(6486002)(66946007)(66556008)(316002)(54906003)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFIuac5sIvJlBx4eldhCfRO/TBSoooyxDwysOlgbBLfSq9FN+YIchuumla1v?=
 =?us-ascii?Q?Rtn6ACgP+U29eOEBDIQg87pyJwY0Ws7+nlW2HApfAcP+qtjeATOhgJYZ3tcG?=
 =?us-ascii?Q?pK246+/B9RyJHLb0NoKEyo1p0f5SDiS9tw15WzELCGhWe8HpOChYXwFe3FxL?=
 =?us-ascii?Q?e7r0aT1Qs4n4yYxq/Mx4XxgZLrEZ/jJg5Jd+Fq/yw+bCmi2TBB81Y8CEfM/f?=
 =?us-ascii?Q?BW7vrgHHDrOrTnNMkn2XFX2AkWxEDznTDcDCxI1RHtQerUFA16raP/ydf6/p?=
 =?us-ascii?Q?WtVb5LVDbFkSZXmq+4AKGalk/j9nJQfbQrFX32l529RorFyVnvCB3hrVZYoM?=
 =?us-ascii?Q?pkE6UzunHt05HhcimgwT12tqUuAKx0LZmDOgm1NCIQJDsW5pDTL1O3ZifLsF?=
 =?us-ascii?Q?DC9eAF516c4nP545UKRE4nlOrSf+rB/ae9bQpOVWTkW92eg1UMZTMxRCeJyq?=
 =?us-ascii?Q?Q8l3Trtkx0HgFlwNsvNpziJlTtdU1HZHzSDJXVETeQchBX4GdGGPS+cNV//9?=
 =?us-ascii?Q?nmjM9AP1IctsC8UBDT8NaUYXKevs3e5/0kT23Ld9cASlSI8kXEm2T7lCcSYL?=
 =?us-ascii?Q?pEjFxUBvyUB5ZTcrJE/oBE8eiDlmJiVkw+k/jU8pS7Z/5G1IixK1NWxw+1xR?=
 =?us-ascii?Q?b+UEvT6vvghyCMhW+L8OEz96GJTzE10N8y4kyAtK4uL1rx/cEF6Wkn+lWMAk?=
 =?us-ascii?Q?J2PRsiXzCm1m+xV2Oy53uNhHQ2W9mNLxknRGzyJQYZEeQ8KUHYtrIcM1Nya/?=
 =?us-ascii?Q?wmrgqf/ymgTSGbzTnrwIQpTeK0rOoNLt1sIHuUrnv3h1I9VcRrc6KToKvznA?=
 =?us-ascii?Q?7NSIynfUUQzWAuwscFdwqd7z/fhsQg43REoC1VTAXH924Si01UmJNykFjlad?=
 =?us-ascii?Q?hyvWx2BAddDrG85Ii9PXWFn1jWu0kY8SPkUcSXKOT5x2w7FAHifE7+Ma+7Y/?=
 =?us-ascii?Q?S8QlKwcd3jkgukZftj+AeqiW4qg5bIXP8EE7D9L3ypyLteFrV7kh3wpcEgk5?=
 =?us-ascii?Q?ohay/E4rLNM+6Uf/2EZ10j018WCnXELHSO08V4xm65hID8L3hom4cs3AlW3y?=
 =?us-ascii?Q?iNAoB/OP4VIgtWpAjLeUB5j1YTlGLx6Z4R9e5dcyDie8mBnZSj7gavZ44BvN?=
 =?us-ascii?Q?wQI3+MSQHW/ZPvqiPnAfUjybcEzGPBlBb28KW5XFaTIBO0uB5pLC0SWlDS2U?=
 =?us-ascii?Q?TR/ACK7Jh79ieuZwfqB8JGZPsYrXTBoEICHvKHXRbcCMwFtixrREr731TGKS?=
 =?us-ascii?Q?Q8o0jR1Yj4hHHs0Y1d8GX8OJ89+pR+gyplqlfFw1h7XZ2SUt81QtNDVmOSiJ?=
 =?us-ascii?Q?7ZxAbLfI1fFb9j23/V+QQnzxYcOV8kgfUHiqQcS4j5x7JxzSASHPYbAhxI/i?=
 =?us-ascii?Q?lw4MBff6ed8kyg629Uq9ahIO0/VjZahablZLMaGzUFZzMqEdRlkw679KvLTG?=
 =?us-ascii?Q?xTM00qvk7rCyMHrUAJBQ96IbkSlqDsCYVRri9jgIeKDR0zrbvOudI+HFFnEl?=
 =?us-ascii?Q?YIQSOA986X8FaPdT1LXiCDAQ4FGZmIP5hZs6UsguVCpMAoR2DSUcdCQPzc3Q?=
 =?us-ascii?Q?6jpPnatlMMAO9jE7yoESWrzHSStea4JMFwsDylLdNAhKLC8oAaxiyjIXIWhM?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rd58H0tXGJ+9MtasP1mdMUAs9Tjs2NFZdO3yDK9ecfAtpmYJYkvZWSdTjTWo4/m6ebVY85/DNAgqXrNGTW0utHjoGWoPodFAR+0M0EeVlpzUCA7FiCkAutgI9e/ZRp/QzLgkSk2Q8ux6N9njLuRYn1zGkT+FomH0dZMAp37tQzQGU/i0ah6HzOjSDo5H/sMcB0RGTmQkj2D73ks6DAv3Ed9sokCn6DCN6F8dYouAZ191mUB/PhfZdwXubHUMyBHwEfejvcRwiXs/mXzamU5f2510/V2FagUxe2YkJULuWEG4o+ZHNJBIt3kM4LJ+D3s80bVkVYy9Ogp7BCGVGE4xXkQWgeu7CMi/d7SX2rDU6XaI7Rc0w1yEy6QjPaWrDISdAKhPcpY8WhlMux8zH3Gwrw6oEMVrgonXyBf6N4moxLquA7LZlVrhIMZep+vqS3iuuTG7v2rgnAlLDsujxbnVSuzbLstFAHdSVTrywxPFimllMXyuzH6UoB87C0CGNxPWMYs58CsgIdsJs0zDDyhZKqWZ7WXuGCY0VaeH+/w9gH7jpJ9CRWxryNd/h/ww1Gm9r/dR5hAFaaJhWJ6pdRasQWp2e5HFoztLO5adR4jqC5owRy2A96nbZ59bx/uEI47nTtRF02hEYT1L84MSoP9ZrHY7j0rx4oIE75HKZ1oWaT6T/6LAAL71iNie0Us2KzxS3zHGBu6t9FUyWixGfgJGt4jcyyqssvqu6mJcVf9Xe2GsS9EUEJaY5uxcFLLYTnPOvTuwVJ1o5LCILcpTGmxld3dILXQO9V6tEUB/V0zTgdPbTijMsaXNV01oUFYC6/099ggqvbwLKpTfyv9whdMBBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b0a90-e5e1-4d78-f104-08db5b138a2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:26:08.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+N4qC44/SGn3c5KR7ULmb1d2Vl3vgXccYebEqGs4g0V/pwFg7xCIuSD18SabNi6KXTWmYZESshatg8AjtBUIuLW4w1L1P2LeMPUQ0hZVfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=817 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220190
X-Proofpoint-GUID: 4_0MTeEYb1AKcArcWJ0XT3e6tzp-txFW
X-Proofpoint-ORIG-GUID: 4_0MTeEYb1AKcArcWJ0XT3e6tzp-txFW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Juergen,

> sshdr is output only data, so setting it before returning seems to be a
> sensible thing to do.

I would love to rototill all this and make sense make sense (!) but
that's a major undertaking. Until then we need to validate that callers
check the return value before they start poking at the sense data. Even
if things were zeroed ahead of time, other things could have gone wrong
that would affect how an error condition should be handled.

> Letting the callers do that is kind of a layering violation IMHO,

scsi_execute_cmd() is one big layering violation, I'm afraid.

-- 
Martin K. Petersen	Oracle Linux Engineering
