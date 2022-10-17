Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E6601B51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJQVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:32:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E313F3B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:32:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJiL0n003484;
        Mon, 17 Oct 2022 20:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s47ywj1z+kjaBx0Girni7+rRKRKrvbddXuttqHsRHqE=;
 b=1ztzcFN4QXOY9FmufPbtlnbNWcLoYEn6V+8rIPyC8hdKM88Va5QHScyQIXA74qQUFR2c
 mqVLqmWM0i03IhsAHg+Fx4Lq/r6iihm2dLjEScYLJ+0pH+a0oQZi9QgCdYWLyn8HRZyi
 pIP3LaBnwGHErnmW2TomCU6NhGgYiQtMwddI7LDVmRa8jtnpHQ8IqPZjFVQIZtAcIZ6t
 urkEQmDqI3HW2doob5EAFdvXPdeuzJJMc6EjCssaT5mocI1591wBKzcOLCxooU6r+15T
 +eWwzCK9hkAb9PhrPkm+kIPSXTbC/YZVDTsZsKyLmauy0foQX9J+LkvvrF0KZlMId2Z8 jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtd2yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:10:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHX6if015912;
        Mon, 17 Oct 2022 20:10:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqxwkep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKWMyVfBpqOnBWVVZzsWi/pMAAPHzGljdRBvrbjlxiPajf/qsrwzE8ckXRrGWzrKX+mlEIvwJ1VkXh3TsHcr3PxScgsuHnCh2ZR35p1Up60R9p8eXMQn722KQ5fRy8IVndO6Y+TBARDN9jbX1rhfv9pnDi3JRZgJtkcLeVxbVP/g51fIQK5uyDrpYBG9DApSwhV13nNzhTxnzWtBIPq9qy+3/gDVIkcBZvmNVAbcXi5+pLqzFhoFUSIiUMazOILWZjLfKBBRTZRbWc09f4YWkERapDv6qVOQKyZccIhc0WPm1QAXmiEZTsd5iFUpJAxoC5oQuJuJMdZzNcc3TzB8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s47ywj1z+kjaBx0Girni7+rRKRKrvbddXuttqHsRHqE=;
 b=brwoZEyPQoPqqlA4JdUb+GoWPvaSn1i6GGt67DmuFqbxTHWY9WL6bChWIwjMxZI007HF51CcaHKMH7E86Pfwfulhx6C1FniqmhI3UffCYbQM1xF+apeuvwFycfyZ6MjoC/S/+bCXyuC4H7nOxnT0lMoxnwCUuCrbi3bSHlMWiGvGGK62nXLNRMzF4mFQid9J0uDVopsFXNrwcDZbsQwxQn+sActph5ilAM+DfkCa2A4mfVfOlod3SgwJIrYKd1tMkTWfhom0By8g08uqNBoDb3Y9n09DM5nBNIYnox9cE1goEquF3sc3x3S8CzvEQdzDtLnQiN0gPldLpjDrECIj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s47ywj1z+kjaBx0Girni7+rRKRKrvbddXuttqHsRHqE=;
 b=JereQIOYY6bLjLyw8RXjFnGkorNUJBQj9aLvLs3r1SPnzzN24b716jGhzyXLrglqVHOvgun0LGo+nwCaCcSL5UErwDuAnWRKzL/3aLKmmg+OOpKrgcVQWik/YKLtIMsUNS6+1+9HUYsTrxDhFG5/qXNH7gXcAvhk72kj2N/3jcA=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:10:34 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:10:34 +0000
Message-ID: <6f08c2c8-45bd-47e1-0835-281abd60f242@oracle.com>
Date:   Mon, 17 Oct 2022 15:10:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 kleikamp
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20221013214638.30994-1-palmer@rivosinc.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221013214638.30994-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 507b338b-fde9-4681-d08a-08dab07ba65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7+8hwc3U7DmiQz4zCi8Dyhp9/2K71Qs8Vx5zNPvwozzJhpaynUM+TrH+w4yRBNwOJxq3SwM8QWwmsJzaDCao+tYx9kf/Hi5Q6Bk5a5ZyjlEDY+kbrPVnZK8ysXkRJ/u3+jOqCwRWYCLgxi8COn8scIRM+CEj9Lb9xprv8W+1Th7NMdk6FPgde3PtR4SugNUBtMdollrSbRKcHBGR7Pj3y6qGSQLGvpKSqbVbqMm2YUFr42RLQO+JvtO9uWgSLzDoazTk9mYBvqh/h/5icjAsgCwX9826M1uWlrDXVozC2INkcRqHkggMbJpsrJeA/EVtvJeYai4Nr9unbeBVS13d1LER0A/T9e9eEGscz4FkOoKlgY6wAYjdN+FtaKSBaSVPxZx/QY7zhzgCm25rQL0oe4is4ofIRbZ+E10ftfC90yUgOvdbYB2Q8EwZX9wJVUFwGGHVrO3uHn7eyoSpG77wZfPIqCce9A8TqfjCUx0aGEUg5wiJZCrVLsQROlof2Ofo+EVoS3yf/qHObDUK3sWxcxbSGXMg8oQg/ApFrexVrh9u1q1RAASJV2b+3W6aFLx9yoA6k/J1zEnDdtXB1riFcCexZTVE/FRj5mn3JzcWQr/rzQIoUxdxrhvBMFgRo4+W15l7WlJzu4HJPr0vKzZHI7YU60X+TjuISI0gtaCgPlAiEiV08yIhKSeoVdh6zrJZQL0Kn8uGwGfOURDscRCkvDBfDahnd1RH4ntIAB6AvCV8OaW/uDr2gYVCSHEX2RkTFDI1TBjJINYU8fmpze1v03m4DVAHQuD0rZag2gNdKsU7oJGb+ekItGNuSm4mggInWdRLm6H8dS/0lzyCA/3eGWGRO5nnLSAXTal+FUejOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(83380400001)(6486002)(966005)(31686004)(66476007)(31696002)(86362001)(66556008)(66946007)(8676002)(478600001)(316002)(4326008)(41300700001)(26005)(6512007)(5660300002)(6506007)(8936002)(2616005)(44832011)(36756003)(186003)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhvdllzMmVnamVyUW1wdU5qWldyVnI1bXlEUmFWczRwVFRTNzMvdksrOC9E?=
 =?utf-8?B?UkhWZWs4VkFUNFA5VGhkLzhQY090MVE4TWd6bWZoMllLcGRtOGk1aUJEWEMr?=
 =?utf-8?B?eFptcnVmc3A0VG8xY1hRZkc1VG1tTmx0YWxadzNQZ3VneXJvRk1Ic1p2R3Ra?=
 =?utf-8?B?NUMzWU4xc3hiekZwNGVERnRJcXB3d1M4ZE9JYlBlc2FXdjFxOEpnZjhXSnVu?=
 =?utf-8?B?YkdrYXgvTjdaYkFadFB2NDJTb0lnanFJZ1VGSFdrU2N5WHVPWjE2M1pCM3lQ?=
 =?utf-8?B?dlM5YThIcDhkbThudCs5TnVaR1F4TVM5N2FDSzBTZklxZUtIZy9KalU1NDc5?=
 =?utf-8?B?TkZVTTdHWXRvQTJBbEZ6UkhWcXBXczQyL0p5cnRXZUhuZ1R3N0Vibitvd1VB?=
 =?utf-8?B?d3I2NnVuOUJVY0FYcE5qa0JKc0VabGpYMFRXMkVpZys1dEZ6MWhPdzhKcVZV?=
 =?utf-8?B?OXJoWnFkaUo5Q0FETDJVUjFzaEE2VUZmcDlka2Y5aUt1Y1pLazNLQlF1SUtT?=
 =?utf-8?B?cysyZkJ6QytyMzVGdldNWmFKdzdIdVl0d1FtT2J1UHMzWW5TTjhSRGI0bCtB?=
 =?utf-8?B?L3RHeXkrcUdNWDJtY0h3VG9TY1JwQXAvbEVvNnQvVTU4S2xEREQxY29KWDA4?=
 =?utf-8?B?UHNUbHBlckVJSFUyRWlmdE5JbWwzVS96dWg5S1pNQXFVMUVPcTlFcm9JRGFS?=
 =?utf-8?B?TEY3T0wrWFdEMDByYlFvQXA2ZVpsL2JHeG1qWW5OY1RBVkRYYktzNmNjUW93?=
 =?utf-8?B?d2V0MzkxOG1GaDhoMEhoOFpJT0o5eFdQNDFub1VqYVdzRDJSdGhnTTIyS2RS?=
 =?utf-8?B?K0VNdjUyaFZjTHUrb2xmY0xpZlhmNTc5cHI5YllMSVJDdjNOZjVsVXNXbFIz?=
 =?utf-8?B?QVB3Vzg2dk12VG1pMVJ2Sm1sbHA5cE85ai9QcUhrU1U5VzJUeFo1TU8wTTFn?=
 =?utf-8?B?WVVhZlhMK09ZZnlaekVYNlB3SUdjaGJaWElBbnROb2gxT0Z4cW9mVkYydFhZ?=
 =?utf-8?B?RFFrcGxnamRJNjJJV2pBTEZVVUdQekl6MlVjNXV4Um1NQTZ6WGNqTzdtL0Y0?=
 =?utf-8?B?TGNIOUlDaWVvejVnaGtQbHhzbmpPY0c5NHQrZUhCTXRvV1NaWkQ3UmxuYW1N?=
 =?utf-8?B?djcwazZ5bG1BOUVsa1lPdXpudjlPaGtJUHVrUStkWkNTYnZkcVcvaE43eENQ?=
 =?utf-8?B?RXEvM3VidFFBOUNKei80SSt1OG95dTZmV0dBd244Rm9tYW5IVm11R0xZRitX?=
 =?utf-8?B?MHlxdWVzR0NiQ25WcUV5NGxJNEI2S1ZKUUx6YkxVeFkxTERyOXBESUdwSHpK?=
 =?utf-8?B?UGV3R0RMTG5LZHBNRVN6QW9xOHFQaFJyczZKZE90ZHROV3p3S0VvVHp3b0lE?=
 =?utf-8?B?N1dCcHV2NTZ5MU9jWGV2VXFGaVc1MFJLSEtTM0pSaFBKSnIrYlhqclhzcVBG?=
 =?utf-8?B?SUVIcWRGT2lWRFlvMkR0K3pvbDIxRERXbm5ya2JRK2dIQnZITm1DMXhIczYv?=
 =?utf-8?B?UlJBbmdoQ1hWWndLcWpJcEswTGtRajZFODBDMCtGQkFYWDIySzlKbkg0eURN?=
 =?utf-8?B?VkhueEJBcUVCeDNzL0xWWjlxcHdnaVNhU3hVa1VISDY4V0x2TG9OY1M4bURF?=
 =?utf-8?B?NllHR05kdXlZemt4Ly9jYzczdDB4MElTOU44Qk4vcjBVM3pqaTl2QUp1NTdL?=
 =?utf-8?B?cTQ0VTdlN0NVcllLbFh6NnFUQlpsLzg0b0V2eEFLd1lOYjhvUmZvZUxUanFj?=
 =?utf-8?B?c2ZueVh0RmsrRUpnN1NWZW1wZGt4TGRQb1RGOXBuWDY5Nk9OTmRTcHdCKzZ2?=
 =?utf-8?B?NDB3T0dleEZMd3pBbURBVVhGS3ZDbzVqLzB4SjdaeXhHOS9ERTB3REpHU2xK?=
 =?utf-8?B?cUVVSGFsVGRsMU8zTWNtNG1zTlJveURWSGVZck5hNUpVUk03Nnc3ZDFVTjIz?=
 =?utf-8?B?Qm9BMXZsU2JVcXpUZVVKVFRHT09NS1Z0Ujc0NDY4THNLRk9WdHdiQXArV0Nx?=
 =?utf-8?B?N3BBTFJ3UFo2cmZuR2RGaDVyQUJkWFJWTEZtQnVOd0g5QXJVNVBjTWNoQ05S?=
 =?utf-8?B?SWd2UWdUZzNXOVF0MG5RMlMxRnRvaldxVWpESjhZcXRrSVYzQy9LNEczQmp3?=
 =?utf-8?B?Nmd4dWx4SnJTclMwSTBFLzFYUVNKYTBpbGxOZ3I5ZlJDUTE1bmlkY2RJN1JX?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507b338b-fde9-4681-d08a-08dab07ba65a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:10:34.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLI8tI3BOTJM2hgryxcFNhumLafY9BwHukOLRL6BzoQKyos/MWQdqppzr1zVk2z4+5nNu7zpcpBrjJdHCwlY3qAr0EXGpNfEwdiFUBDHPEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170116
X-Proofpoint-ORIG-GUID: Ih7KMPi65UUnZoDYZdKyH1uwcRe_osTS
X-Proofpoint-GUID: Ih7KMPi65UUnZoDYZdKyH1uwcRe_osTS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

Thanks,
Shaggy

On 10/13/22 4:46PM, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a4e8144198b..9a47bd58a330 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10867,7 +10867,7 @@ M:	Dave Kleikamp <shaggy@kernel.org>
>   L:	jfs-discussion@lists.sourceforge.net
>   S:	Maintained
>   W:	http://jfs.sourceforge.net/
> -T:	git git://github.com/kleikamp/linux-shaggy.git
> +T:	git https://github.com/kleikamp/linux-shaggy.git
>   F:	Documentation/admin-guide/jfs.rst
>   F:	fs/jfs/
>   
