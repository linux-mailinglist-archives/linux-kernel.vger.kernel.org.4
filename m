Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43770C3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjEVRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEVRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:02:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A68CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:02:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MFjLM2007431;
        Mon, 22 May 2023 17:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4kWPUE145LQv61HtbuOClkkxqgdB6ygNDagzVxQbSqs=;
 b=tS7SBuWvLyxm9yu5edG8FHhK1t2xWkafr8UP8nxHOjTSJxi61GB0Q0Xl06E2WcIF+NGX
 MY6ygp2tJBapZvDOfPEO1WrnwBLbWiQd7zA55CT7Bol8JPOPjxD7SpsNj9M0GJOLH8qs
 B7RMtQbbPx/2Xp0b+DUMV8WrURaP9Y1bvmm3CPGGV2gmgG1vKtAhGbNM7GTzZE/1PQOH
 403IJb6Zqr1liELaKVxNz0oNKL4ez0wbHT5Q3ac/drcxNcVkSxhkVojjdZSNpx7CleqB
 SvpTRPUkk47r5mSgSe1d95lH20hvyCPDB0Al3Cgu6Ay5s2dWKfR9BtJmzvMSP04pZjcY xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qk873-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 17:02:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MG5MGC012966;
        Mon, 22 May 2023 17:02:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7dqkfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 17:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqeg012+/nVk3kOapvgDZUsyF7cgGiTaemb3g4zemNW9Qp3XkIfpd3+FeX3jWn9PqI4YBqXXrvtskSsp09MDTyG2xuNRuddvEDGQ0LOMTb1rtgak9AfHPEXG0BWnPbhRLIzTR626o8yCwP8y3YFQN9cGxvxWOOLUersuaRe3/PioBbZ4+sZsN2v5CIKawuhus1xtJRlENRRQzBOO8cCnlOOm59mi/HRxowzuRNIRpeF69quLKWBsIWsxpQhlkI3TNFwqi6O2A6mzNiKIAt0SzSGAKX6aPot7dQ/Hvh9TONFI14dRTPOeTxgTCIcu0epS3sQgte9Oiku8TCLjnBN6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kWPUE145LQv61HtbuOClkkxqgdB6ygNDagzVxQbSqs=;
 b=jPSM4D45xiy8lho45PO6XDcD8Ms4hxIytviXAgPncXScyGxKmzBlyH5n1yEYqVs4JmIIwjUEd6w7V7/ZbXub+Gle6U9BUJhbpdnI5+TN31VoG2sS7TeTvshzYwNqjHWVecJtDQPCH63/ICYIu4suKnanyoh1ZXRwAb4GCkf1WIs0EpNHGGz1y+LIkBmhKhz2wEoTsOE0XA9AB5x48uYeQQp7UeBPJJV2iL3zxIhFqGOmi+nzrNgnwh5fvy7MZfyGb/ot5o3khnBNCK1l8Gr/A9rAdR6wnWH2GVh5TBz6g3Sioiq3ZYitPKBYDg+TLCKbspKkB5jMbsn76VFcs4e6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kWPUE145LQv61HtbuOClkkxqgdB6ygNDagzVxQbSqs=;
 b=WRNUBlln4xE50VaOB0aPLh1L84bbNk6GoxyS7yOYet6Vd+Idv/Boy1foiyHOs5BOszcGCP7718DQb0v4ImWKhcroYJ2EJDv7PLL+/R/THsbnM9BBVx4uL5uHPE57zsX/Wyiy9uXxDqKqpZOi+CUUHzaH5PdWira4mfh+l4F1Z4Y=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DM4PR10MB7390.namprd10.prod.outlook.com (2603:10b6:8:10e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 17:02:22 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::f942:ba2a:1330:244b]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::f942:ba2a:1330:244b%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 17:02:22 +0000
Message-ID: <875e1afa-6bab-bddd-19d7-9f60b47c64f7@oracle.com>
Date:   Mon, 22 May 2023 13:02:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce Disable IRTE Caching Support
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-4-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230519005529.28171-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:5:bc::14) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DM4PR10MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: e861b936-eb64-435b-e2a2-08db5ae64f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/KQkkiovpXxA1fSQFnJSLdCndYVy2OCn/2MXFus3tvqPbXMSS0WRumH5m+k0BCVbmrd0P85xjK6C6nT23aev8ZevUcQIbNv0qRPlIuVaRuRMmVXeC0/qDIZxuU2nwnPiAogJIv8gWXC+Vjuf54//86Q+SfY/qD4AVAIIbEHkoLjmTXK8TceDEW7Z8vU75JNR4InSMAEKwDNsOAH6wrodis693Uv42hec4uG/jKilCDiI/66LigGP9Bx0IkdyK5dfa7uhnfEqQUTwfXqvJDD7RQdAzd+yvsmNc+iPZ8CQi8sbfMeSlPK56+ZrBnhVqtdeWWCqdK6Fkk37oRYsCTCgy3lZHMMyMSCWWMO8bY7eaweqH5N6/8hd1Kz5cPpVEYOgDih0080tTIKPaDlMvKVlitkN42vH4zzRST0FXO0uvbvgOgIaWCQBfXbBmzyWnd9s4Fng67bvuujIuKbmvvSBR2u0gSX8k6UJutSlLou/t8v02Q/m/XfR6ZBCAu2DO/9Wp/kXmPR6Sx4Qot7KQSw2Fxgw8eaBPCERpZ6TQ7jIuj1k6dBmAVMyZwiCAMQfBKXNRCaQhBp9FoAkA6WS4yzGfYKfLnDFCYj49djvhiIHXaFYV4Q5BlsbWIyTSu9SdY7Gp0g217+xNFQnjxcAE8NXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(38100700002)(31696002)(86362001)(36756003)(31686004)(8676002)(8936002)(36916002)(26005)(5660300002)(6512007)(6506007)(2906002)(2616005)(186003)(83380400001)(6486002)(6666004)(41300700001)(66946007)(66476007)(66556008)(478600001)(316002)(53546011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFFR2U3S21kaURnbXRTeWsrU0lVVHpzU05MQ3hJVTRHeUw3MXIyK01HaUhE?=
 =?utf-8?B?TGdOZE9aRFdLaUpFYnEyeG5YdEcwRVAyc2hFN1BlcFdEdkNnSGJnaEVIYWJh?=
 =?utf-8?B?Q0phc3JyOTVaS0Y2ZjNHOEs2QWF6dVJGTWVGUG1Ybm1aTmoxRVpjZFhuT1Nk?=
 =?utf-8?B?cFpuNjRKM2tJOEpURjcxeENHY0M4VHQ0MTZSRmJ5aGR2ZWs3bUFIRG5FK3dB?=
 =?utf-8?B?VC9qekJWUjlrYXlvaEJhTDZmcWdpUFcrd1BiZGhRZVBmNHg5OHlaV0NSVkxr?=
 =?utf-8?B?ZXJiMk5lKzFML0JuT3YxYm1OQ1lnYXFrR1N2NG94UWRlSTdHZVpCMUNoeVNH?=
 =?utf-8?B?b1BFTjhZbXhjTTBHbW1EMHg4S1V6TEprUWxna3VKdnRPeWJ3Q21XU3hGMHBV?=
 =?utf-8?B?aWFTeXJ0NGo4UEM1S0dQSXZEM3dLcmVodVhLdWU3R2tWS2xXL0tTT2kwS3RP?=
 =?utf-8?B?OHRONW1OeUM4Mjl1aGpzSExnNjRkbEJaVEdNQTlKUWNnc2dPYTVXVllINUls?=
 =?utf-8?B?eWlxUlBKdTFNc0FjanNlZzEwYmFDQWxJWTFUVUpiREtTZElWSFhGeEpmMFlq?=
 =?utf-8?B?Y0hTTSs2L2d0akNYZGYva0tyLzBjUHVBbHYwTHpNbXJPK2dGUFFOL0NxYzdi?=
 =?utf-8?B?VXByaGgzY05rVjdTcG9qdHJOYzV0KzZnL3hLaXFNZ3kwbGYvdHUrbCsxcGEv?=
 =?utf-8?B?WnpOQ2Z6SXFOMmpqN3FjUDQ2a2NFV3J3WFh4VFFRQmtCL1laWHlKRUlYOG4w?=
 =?utf-8?B?cmxxUUNmMEFpMmJKZDEwdHM4THZld1NYMU9kbVdyRVVManI1OHZZQ1lKc3d4?=
 =?utf-8?B?ZVpPanVZclA1RmNCR2p3WUZTcURwTFRRVGU2NnlRVkdRcjAzNTBYYTZxSFVs?=
 =?utf-8?B?aUxKRDdIenYwUVJ3bEJsUTFtVFJCTG5saGZUd20zdXRtK085aE5IRFh0WXA1?=
 =?utf-8?B?Z0RHbE0yYXkvYmY5c0FsaTlvV2ZidGZ4U1FaaGg3OHl5OXJURFVJRFVNT2o2?=
 =?utf-8?B?dHJwMnkvUXp2Y1kzWFMxUSt0SGZEQkptMEEwSzVZZnNKL1BEVDIvKzBrb1Zq?=
 =?utf-8?B?NW13cnNxNW9lY3MwaEg2T3lzK1ROMXZBZUJLU09xbXdySGJCa3VrZ0NQbEJO?=
 =?utf-8?B?SnZaUE5ac2QzZVdKTFlieEZTVlVjU2F5QWNVQmNRbnNMUC9rcVJEd3o5d01i?=
 =?utf-8?B?S1VFYXV0c25UUkhZNi9raVhoZWJpMG5aWmhJVmt1ajFHSmYxNGYwcXhyMk9N?=
 =?utf-8?B?cGErZUVKZDk3Q0FjUXR6bEVLRUlVNzRrR3JiRld5REhJZ2xjUDhHUWNuZHYy?=
 =?utf-8?B?NXN4R05ZVVNrNnE4YlU0Ym1zeml3TjBJaDJqMjZVLy8zd1NKMXVNM1h2ZUpi?=
 =?utf-8?B?bXBtWklVeUpQcE5LS2NPSmNHQjdYbDB3aWdxRzVOODlLc1NZdHNlVlFTMnlR?=
 =?utf-8?B?Q2pnVWlRNURsWkVTRFBDa0ZXckMxbUpNcTNkZDNUWWRCTlR4di8vWE53R09X?=
 =?utf-8?B?RDN5VEtyZ1RWUDRPWkd5TjJWa3EvQXBsNUpBZXcvejJqS0VYN2VHK05oczJv?=
 =?utf-8?B?N2xPWDROL2FsazZlclZCclJwU0dSSWYxcDdOeWMvSnBQTzlqaFJTc0crMmhG?=
 =?utf-8?B?NHlSUjRlK1B0eklUSG1PSnQ1a0N2bXZITTluT0s2M1luRllGYVE2VEYrbHRk?=
 =?utf-8?B?Q2trRCtHYUlCamk4cFZqUi9BcVl0YnlyZXlMYzQ4cHJlU3daSDNPaGliM0Nv?=
 =?utf-8?B?UC8rVS9wUXVpanc3Tld6bzludm95SGVyeGd2N2NUZW1ndjdkWXlKeFFuMHFO?=
 =?utf-8?B?eVFYa0NvNWRDMTFiT3JVWmh5SDd3RXJlaWFnVVpCc3VJQmV2Y2VXQmk2a2tn?=
 =?utf-8?B?TVAvcTNGZXV4NmVmSFV5QmtCZjdJUjRpTC96eXdTTW92Y2lkdDlncUZET2g5?=
 =?utf-8?B?dUtIbDB3czV0RmdHbTgxQVA5dE01K1M4aW5jSnA3bVJHSjJmamF0TzlrY3dt?=
 =?utf-8?B?eS9va3RsWFQxTXJENmdrTCt6cUJPZ09IUGwyMVFaclRyVjM3UjkvT2JrV3ls?=
 =?utf-8?B?dTZnV1YydXZFbzk3Nkt2eHYvV2ZPaFdoZHFXa2d4M3V2NEJZZzd0TDM3akpV?=
 =?utf-8?B?ZDZPZ1p1NVdBS1g5eElNN04ydGc4eU9WUkdNT1Rwc1F3NmhUTUw2QVR4YlRI?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lKiSoidhxT/GaamUeeXquY0fNTUmveHXW+5cUZobgZT7NoyLz45N7M2Y9BwM2V4exHE74Mq4ulQHM8NKCIhRKapK8x59XJG4jwnPDvK3lSTVdZ0CFnwAliMII+HBWW7jIUbH/OfCzqIA5MtA1FERLBiYVWObekFdEGC4WZujHSoiEpr8KwmGmdJTvVBpUs7+v5tVMGxzpHdkOVXNvxXREzumFzH7WkV3HEHHRWnKYJ7E0v0Xovzs+fMV3ULDrIu5X396OmCtF19SaV1BRV3kyXSXWxz9wmn5SCR9kuCjqHzK7Rn4r94By76eeftjcjrXxCKqhJdHd3/cLzPbtcI/OUpFdyoL/wA5bgd5mpeb8zjbTOhxevI36lG6UZUKh82ln5IQ/jARHC8tvvInFWFyhk9vpD2wp1Rn7FjKFrfzFo76FsuHZIxxlASwuFweAHooT08f/uS+J9NKjmjg2zYp6YDLYMhbt5QP34iDdOZHokNgvwfpyt3eucW5MWYyT5i+3cvhvu5zQvwskGykl7wUe7wjuZwSvLUPzvIbvA9KdCT1y9O+1wktL/OrwyzK3u4Z9HB8JpjLjqErOz1AjTWiZTXfPOqHi8bG12kqlCwatKSABhkG9nvSlgalmt9iEvvmSiB72iGowqnNA3apt8Yp9p//19YyY099zxNNF4EgZKtbvEDl4fzUnUlZ7mciecLrj2L+L+05x12hER0kY5x+kHkp+7loLyZiVVe1YfV6Hva9cj42xuVpbTfLS391W8dOKcec3rfoE/iILs/Xt4Q71kJfoUxy5iSlTcOOV88d2hkFFWoRTb9msHneHDhcE06kFP2qZxYrGmKz4SaOuQP6seTgL0BuiiGXU9XAxJqleh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e861b936-eb64-435b-e2a2-08db5ae64f17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 17:02:22.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k05QbNrvaWDABnNeM1m9v+j7SpQbNw/6AJIL67cQqNiT0N7RK0Dy2j2WoDMAxhjKjEhbmlENRAQBGGxV3jSQhFTEFCJFdSB/SFWWsngSjW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220143
X-Proofpoint-GUID: sST_WWvOUGIWwGotwdN8B9dHdKfVFw8L
X-Proofpoint-ORIG-GUID: sST_WWvOUGIWwGotwdN8B9dHdKfVFw8L
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On 5/18/2023 8:55 PM, Suravee Suthikulpanit wrote:
> An Interrupt Remapping Table (IRT) stores interrupt remapping configuration
> for each device. In a normal operation, the AMD IOMMU caches the table
> to optimize subsequent data accesses. This requires the IOMMU driver to
> invalidate IRT whenever it updates the table. The invalidation process
> includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
> a COMPLETION_WAIT command.
>
> However, there are cases in which the IRT is updated at a high rate.
> For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
> vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
> amount of vcpus and VFIO PCI pass-through devices, the invalidation
> process could potentially become a performance bottleneck.
>
> Introducing a new kernel boot option:
>
>      amd_iommu=irtcachedis
>
> which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
> Control register, and bypass the IRT invalidation process.
>
> Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> [Awaiting sign-off by Alejandro]
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com

I sanity tested the kdump mechanism, and confirmed that 
CONTROL_IRTCACHEDIS is set appropriately based on the irtcachedis kernel 
parameter.

Also, I have not observed any errors during multiple rounds of testing 
with large vCPU counts and VFIO passthrough devices under 
interrupt-intensive workload that causes heavy vCPU scheduling activity 
and exercises the relevant code path.

Thank you,
Alejandro
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   drivers/iommu/amd/amd_iommu_types.h           |  4 +++
>   drivers/iommu/amd/init.c                      | 36 +++++++++++++++++++
>   3 files changed, 41 insertions(+)
>
>

