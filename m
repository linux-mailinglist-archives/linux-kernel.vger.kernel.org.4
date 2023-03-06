Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20426AC188
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCFNjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCFNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:39:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFA2914A;
        Mon,  6 Mar 2023 05:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsGKCgiNYvnODzxKChqZDyatnjDHF1VfmEx9BLLplle1QEbVQjtxYGEKJuORWMFxLms6V1OO5Jkpp5npuNdRoejLnAhcD7PHU6AjYdMPukZ2lf85iSLd4Hcr5T7v8821VcX2j+Ylw4mBvU8KzxLJQdVRBrQ2ReSE1Zodd4RKU5Y8LBgoOEQe1M9+9RS4Ca6cYouFaGEXhXyfokRy8rCFwRErU+je/AvoP1UCeTkiacFY7VVEP2Yxs2VQ6SuR9x4miK0FqjX3krVTIShV6d2yrDn0O5wW7GpeaOeZ/rltqK8HTNpXAf0SvX5Ar3YxTUEj2f5l7b6PrxO+qo5Qj+tn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgHrOLJ0OyjyGk9Fz/YTeK7ulv2shM/fMZlzvolrewA=;
 b=kpCMECgV22wQ5ohXFgeGnP8b6WKn1LH3nUY97gymJz8IzBdJnOxlGKYeaZtmUgWgIzqAl+EmwyBcSMEzs7Y6ljwLWPnVqE7VEBPWlB55G3yl74xQpxgC3U9mjA7DCWK1pitXNZDct6k9UkEUNnvtPBPd5TpV+iNifO+wxq2k20iITbMTZYtxDU/rAuhoqTXDOKFMVBsokfwABN5zMe6yR8+IETrLBBX+JAp8+AtxttJgdFK1Vvixya/CWkt92Gou5cpp380c4AyziLkK07LCelbTLE0HNuhNflNDYqf5zjmtKf18f6qpjZ1qIwctjcrqtzVYFP+4ZjjvHtNCMY2EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgHrOLJ0OyjyGk9Fz/YTeK7ulv2shM/fMZlzvolrewA=;
 b=FbWJW/Y6jM2Lbc3OYlA6lkip6Z5cn7SfIOyWMM2gEZLhxvyV4yu6H0mxUw8z1h4Lc2uVP825yD9Z0SQ4qf+2zalXmN/KW0dp74NdvOre3hgUPyzbX6aWH7KPYcEczKJqKewuBtzNPdaU9xZ0WZLzhjZ8u80qhqpZamJ17G2Ymdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:39:18 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%8]) with mapi id 15.20.6156.019; Mon, 6 Mar 2023
 13:39:18 +0000
Message-ID: <4bd91ae6-5d88-a6ac-7972-ad747ca99f1d@amd.com>
Date:   Mon, 6 Mar 2023 07:39:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/7] Documentation/security-bugs: move from
 admin-guide/ to process/
Content-Language: en-US
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        Minchan Kim <minchan@kernel.org>,
        Jeimi Lee <jamee.lee@samsung.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-2-vegard.nossum@oracle.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230305220010.20895-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecc0114-e791-4947-0043-08db1e482f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGbYTKkj6DauIMmTek39u53woaQK2lAP2Xp2icyZdcg9KQnljloZgZIE86HCNQWtOakgvBg55sodDy9Q/nRc5K2aU586OoqknH8kNkdZpS8d95hNtKwFRKILdNWiaB6f40c8djZ6twDHELurLFWdhG34lbLJSOHybrF4Nat0EDaABNx3IdECwnCeoUWTitzmJarjjW+1Nr7oQgjInDLj9d1Lce/fkFm7uiYdserUrfbov5NQsTfSlymSW/7eWhsXkjPzz1baNgblBL7V9iY4g/p/mbPLsQJwUa0Lgi2QL22JFlkqCOzBKSFA0tDkr0W6znPmOAY7NAr6D7x2/6GEPmeHpJp5Hbofe47oO5pGF9zUKO4RIZ/bakvA2a3s2nqdQ19GTtMg+xIese+ek4SvJl0HHW58XrId7tJQxc3WtMWusRlJa8W5a9F/FT298HMjFtCHu6BX0t8b2m+cDZHT0YjUKITdJCFwsc3kNN7XBrM/8yjd1B1Yf0c+OkDaKBVAsqFG0Wh5wcExBhjUapy5ARsGMJxn1NIqSYqvPfzyUAX+gSQP9tmSNxjOAaX30FwgyzwIeGnB2a5+yzmT3YUKFtmp4bzeUkF/JgIQsvhdWbr3EeyHtv+Sr4ceyZTzXnvcBJynuxUrYpmVSVrNYPvfx+vvOfpZGfYUk0OR8GAqTrv9qOjiwEe689c1pky3i0a+Wm+VcRHO1bBgPUGQpdNPzkw0pc9H2OcVKfmf9xhLhQl2qWRafnXKksppin7tBeOF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199018)(26005)(6506007)(6512007)(53546011)(966005)(6486002)(6666004)(36756003)(66574015)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(66556008)(66946007)(66476007)(41300700001)(8676002)(4326008)(2906002)(15650500001)(44832011)(31686004)(30864003)(8936002)(7406005)(7416002)(5660300002)(478600001)(316002)(54906003)(110136005)(66899018)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBySVpwSUhTSmhqamp0NnpKc3BjL1k4NWM0UWhnUmpoeElOTU1BdHRRWnlp?=
 =?utf-8?B?SmRUeEhJbDdtNFU2Uy92THJjemRiTFVtbnRCSmtlNHNKVDVmbHI2TFVkaFJl?=
 =?utf-8?B?dlpMYlVCM0pQblBCTzV6c2RvaGdQcXRxSzMxVnI3eXNsYndDWHpwUWxDUC9m?=
 =?utf-8?B?L2psQWJyS3pLMHdwS2R3T0wwUGJ6SjJWNVNyUW9yalI5RVhGT0JRSXFveHZH?=
 =?utf-8?B?SC95MXg0QnZ5ZG5ydDR3N3haZkZqdDBncHR5Y1JXVklVSEJFYitYTWRLUzVE?=
 =?utf-8?B?aHNzY1I1MkJPL0hFVmVsLzhoNzlqU1ZQYnAyd0dtNDYxYUtnblc3QzlaWE5E?=
 =?utf-8?B?ZEpKM0RnbTZCOGNvQmV1TC9sTHBSbVNRVk5wT3JjU2g2bVc1R3V2TFJTZnht?=
 =?utf-8?B?RmFNT2ZLamVEL3pXSlh2QlNaY0lmOWVWamJtMllWWitSeHBWUUZvMjhhSWdR?=
 =?utf-8?B?V0syaHcvdmdZRFlmbCs3eFZKY1Q1ZWRqcHk2aDNFcEcrMXJ4WXYyWGljdjB3?=
 =?utf-8?B?OW5TN0VRdGxZbndEUlVqRDNwdThlVDNWZ3lCS1A3TVJxSlJ5S1lkWnBBZUlG?=
 =?utf-8?B?Z1JvMlBYU0VMdEt4OVhtTUd6U3M2U3hoc2tJSDMwcXNlQnBTTnY2b0JKOGlR?=
 =?utf-8?B?VzBLcXovVGJSY0haTDkyenkybWxRT2NEMHp3U3F3YjIwbUpPbnBmRzc1bXhC?=
 =?utf-8?B?Q29kNVZGenZvTXNTQllZUk9nODdoT3AxVm5KeDlCVmp5ckptd0crWERDNG1x?=
 =?utf-8?B?YkFFWW9NTWFySVVSMENjTDJnQ0Y1MzRML1JvV0VNdEwydHlYbUpTek41QTJX?=
 =?utf-8?B?NGEzaDljK1dZTGFaRFlzNFpoTnRXUmdlbWZXT2ZWemZlNnAzdFB6T3lMVmxt?=
 =?utf-8?B?dnY4Nk5TS1U5VnFSRGFTajBaaHJLUjMxbUxKanoxNDEwUlpPVWdjWjR1Qm1G?=
 =?utf-8?B?UHhoQXVsTDM1YkhiLzRDKzVSTkZ5a2ZXeEZiSmVUR0tnaW9wWFJoZmpRcEZ3?=
 =?utf-8?B?aFM4WmpZUGd3QWJ5dVN4U1JudHVhQXFEZTFoclZwSHkxWUpHNGYzUlo5ZkMv?=
 =?utf-8?B?a2NyeVVzWWZjL1RORWZGMk5xTDdSMTBsUkZscDJHTU80cVpoNmU1bGpKRVVH?=
 =?utf-8?B?eWtqM0htQnJhdjJYb0lqMVNMWkFrYjJvMWwyUkFwcUVRUVVTVXVPeTErb1Bs?=
 =?utf-8?B?NjY3d2FtS1pyWFZ0N0dlUXArd1RTcTRSZ3ZaZXVNOGQ4bGlMaDUzRmpVMUpZ?=
 =?utf-8?B?RkY5OTZxNXhJWnBFUVNjWXplTlhqWWE5bXJNa3M2SW84MFNTbjIzT0FVTjM0?=
 =?utf-8?B?bVYzRFl4SEpsQ2IwdVNoZldOWWlZOTdGa3lhWkIvWUpkdU0xMnl5SHFaQUJY?=
 =?utf-8?B?Mkxjak5wbHpZOVMrRW1jWGRtU1RzdTVqT214My9kckZlU25xREE2VUVOcGc3?=
 =?utf-8?B?WjE0SzJEOURyeU9CQ0YxbDhnazVhVTJ5K2FoUTRkSnFsbkY2N3M0QWg0R3o4?=
 =?utf-8?B?K29SRU9TNTFHR2o0amxkS2RmNUk5QWIxN0Q0VXM1OUtEdTUrcDlTUDdjVTZB?=
 =?utf-8?B?aURydzczQ21YcncwN2NFeE81ck9CaVo3VzhyaTJvdU1GbnFwMU5JbUkxdk1I?=
 =?utf-8?B?aU5XSXJMSm10MS9uOGVSWkloZ1dRb1FEaC9xLzNCNU90VnlIZXRnWnVMcklw?=
 =?utf-8?B?NWxJZUgzR3RjVmt3N3BGOVBCRld0aS96N0pIQXFGbE90VWtRZnhGTVgzbXpL?=
 =?utf-8?B?Z1ZVTS9xZEszVFJ2cml5TzNORFB5VFFoSGRXYWV3M3MzL3ZieE1uL0RRNG5P?=
 =?utf-8?B?VU1JdldZR0g0NU1NR04zeUlGOFFtMjR6SXNHSm9WbzNURk9GL2ZGQytpNmt5?=
 =?utf-8?B?YkpJSHlPdFVOZXVlN2twZ0hCcytyYkNMd3FHeVRkVk1tdGtrMmY1VWYxYW53?=
 =?utf-8?B?V2VJWThRKzJudlc4M015SmpwejBocW5scUVNUlkySTRvUVVJRG5icWc5WTJP?=
 =?utf-8?B?ZWZBaXg1RHdEY1RKd0RMUjIreTlIQzZwK2g0RlF2U0h6NFozMUIrdWNyM1lF?=
 =?utf-8?B?ZVRHZlYzb3h6YU9qSGIyTER6NkVxclk5aktTVmtjMnh5bmcrWTVMVnk5MVlB?=
 =?utf-8?Q?mf1l+yhvYZ6zM0RIxG8SlIKux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecc0114-e791-4947-0043-08db1e482f47
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 13:39:18.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ucNTaLZQakQ5xONVEa02PUtp2W0QRy/mFLsmf9c+ISTTVZzOb49qgjuSMquF1TYcsSk73QWEOIudRgf0/3tRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/23 16:00, Vegard Nossum wrote:
> Jiri Kosina, Jonathan Corbet, and Willy Tarreau all expressed a desire
> to move this document under process/.
> 
> Create a new section for security issues in the index and group it with
> embargoed-hardware-issues.
> 
> I'm doing this at the start of the series to make all the subsequent
> changes show up in 'git blame'.
> 
> Existing references were updated using:
> 
>    git grep -l security-bugs ':!Documentation/translations/' | xargs sed -i 's|admin-guide/security-bugs|process/security-bugs|g'
>    git grep -l security-bugs Documentation/translations/ | xargs sed -i 's|Documentation/admin-guide/security-bugs|Documentation/process/security-bugs|g'
>    git grep -l security-bugs Documentation/translations/ | xargs sed -i '/Original:/s|\.\./admin-guide/security-bugs|\.\./process/security-bugs|g'
> 
> Notably, the page is not moved in the translations (due to my lack of
> knowledge of these languages), but the translations have been updated
> to point to the new location of the original document where these
> references exist.
> 
> Link: https://lore.kernel.org/all/nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm/
> Suggested-by: Jiri Kosina <jikos@kernel.org>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Jeimi Lee <jamee.lee@samsung.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Acked-by: Carlos Bilbao <carlos.bilbao@amd.com>

> ---
>   Documentation/admin-guide/index.rst                      | 1 -
>   Documentation/admin-guide/reporting-issues.rst           | 4 ++--
>   Documentation/process/howto.rst                          | 2 +-
>   Documentation/process/index.rst                          | 9 ++++++++-
>   Documentation/process/researcher-guidelines.rst          | 2 +-
>   Documentation/{admin-guide => process}/security-bugs.rst | 0
>   Documentation/process/stable-kernel-rules.rst            | 2 +-
>   Documentation/process/submitting-patches.rst             | 2 +-
>   .../translations/it_IT/admin-guide/security-bugs.rst     | 2 +-
>   .../translations/it_IT/process/submitting-patches.rst    | 2 +-
>   Documentation/translations/ja_JP/howto.rst               | 2 +-
>   Documentation/translations/ko_KR/howto.rst               | 2 +-
>   Documentation/translations/sp_SP/howto.rst               | 2 +-
>   .../translations/sp_SP/process/submitting-patches.rst    | 2 +-
>   .../translations/zh_CN/admin-guide/security-bugs.rst     | 2 +-
>   Documentation/translations/zh_CN/process/howto.rst       | 2 +-
>   .../translations/zh_TW/admin-guide/security-bugs.rst     | 2 +-
>   Documentation/translations/zh_TW/process/howto.rst       | 2 +-
>   MAINTAINERS                                              | 4 ++--
>   19 files changed, 26 insertions(+), 20 deletions(-)
>   rename Documentation/{admin-guide => process}/security-bugs.rst (100%)
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 0ad7e7ec0d27..09a563bbe3e7 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -36,7 +36,6 @@ problems and bugs in particular.
>   
>      reporting-issues
>      reporting-regressions
> -   security-bugs
>      bug-hunting
>      bug-bisect
>      tainted-kernels
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index ec62151fe672..2fd5a030235a 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -395,7 +395,7 @@ might want to be aware of; it for example explains how to add your issue to the
>   list of tracked regressions, to ensure it won't fall through the cracks.
>   
>   What qualifies as security issue is left to your judgment. Consider reading
> -Documentation/admin-guide/security-bugs.rst before proceeding, as it
> +Documentation/process/security-bugs.rst before proceeding, as it
>   provides additional details how to best handle security issues.
>   
>   An issue is a 'really severe problem' when something totally unacceptably bad
> @@ -1269,7 +1269,7 @@ them when sending the report by mail. If you filed it in a bug tracker, forward
>   the report's text to these addresses; but on top of it put a small note where
>   you mention that you filed it with a link to the ticket.
>   
> -See Documentation/admin-guide/security-bugs.rst for more information.
> +See Documentation/process/security-bugs.rst for more information.
>   
>   
>   Duties after the report went out
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
> index cb6abcb2b6d0..deb8235e20ff 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -138,7 +138,7 @@ required reading:
>       philosophy and is very important for people moving to Linux from
>       development on other Operating Systems.
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       If you feel you have found a security problem in the Linux kernel,
>       please follow the steps in this document to help notify the kernel
>       developers, and help solve the issue.
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index d4b6217472b0..565df595152e 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -35,6 +35,14 @@ Below are the essential guides that every developer should read.
>      kernel-enforcement-statement
>      kernel-driver-statement
>   
> +For security issues, see:
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   security-bugs
> +   embargoed-hardware-issues
> +
>   Other guides to the community that are of interest to most developers are:
>   
>   .. toctree::
> @@ -47,7 +55,6 @@ Other guides to the community that are of interest to most developers are:
>      submit-checklist
>      kernel-docs
>      deprecated
> -   embargoed-hardware-issues
>      maintainers
>      researcher-guidelines
>   
> diff --git a/Documentation/process/researcher-guidelines.rst b/Documentation/process/researcher-guidelines.rst
> index afc944e0e898..9fcfed3c350b 100644
> --- a/Documentation/process/researcher-guidelines.rst
> +++ b/Documentation/process/researcher-guidelines.rst
> @@ -68,7 +68,7 @@ Before contributing, carefully read the appropriate documentation:
>   * Documentation/process/development-process.rst
>   * Documentation/process/submitting-patches.rst
>   * Documentation/admin-guide/reporting-issues.rst
> -* Documentation/admin-guide/security-bugs.rst
> +* Documentation/process/security-bugs.rst
>   
>   Then send a patch (including a commit log with all the details listed
>   below) and follow up on any feedback from other developers.
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/process/security-bugs.rst
> similarity index 100%
> rename from Documentation/admin-guide/security-bugs.rst
> rename to Documentation/process/security-bugs.rst
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 2fd8aa593a28..51df1197d5ab 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -39,7 +39,7 @@ Procedure for submitting patches to the -stable tree
>   
>      Security patches should not be handled (solely) by the -stable review
>      process but should follow the procedures in
> -   :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
> +   :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
>   
>   For all other submissions, choose one of the following procedures
>   -----------------------------------------------------------------
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index eac7167dce83..7b223f306efa 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -254,7 +254,7 @@ If you have a patch that fixes an exploitable security bug, send that patch
>   to security@kernel.org.  For severe bugs, a short embargo may be considered
>   to allow distributors to get the patch out to users; in such cases,
>   obviously, the patch should not be sent to any public lists. See also
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
>   
>   Patches that fix a severe bug in a released kernel should be directed
>   toward the stable maintainers by putting a line like this::
> diff --git a/Documentation/translations/it_IT/admin-guide/security-bugs.rst b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> index 18a5822c7d9a..20994f4bfa31 100644
> --- a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-ita.rst
>   
> -:Original: :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +:Original: :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>   
>   .. _it_securitybugs:
>   
> diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
> index c2cfa0948b2b..167fce813032 100644
> --- a/Documentation/translations/it_IT/process/submitting-patches.rst
> +++ b/Documentation/translations/it_IT/process/submitting-patches.rst
> @@ -272,7 +272,7 @@ embargo potrebbe essere preso in considerazione per dare il tempo alle
>   distribuzioni di prendere la patch e renderla disponibile ai loro utenti;
>   in questo caso, ovviamente, la patch non dovrebbe essere inviata su alcuna
>   lista di discussione pubblica. Leggete anche
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
>   
>   Patch che correggono bachi importanti su un kernel già rilasciato, dovrebbero
>   essere inviate ai manutentori dei kernel stabili aggiungendo la seguente riga::
> diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
> index 9b0b3436dfcf..8d856ebe873c 100644
> --- a/Documentation/translations/ja_JP/howto.rst
> +++ b/Documentation/translations/ja_JP/howto.rst
> @@ -167,7 +167,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
>       このドキュメントは Linux 開発の思想を理解するのに非常に重要です。
>       そして、他のOSでの開発者が Linux に移る時にとても重要です。
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       もし Linux カーネルでセキュリティ問題を発見したように思ったら、こ
>       のドキュメントのステップに従ってカーネル開発者に連絡し、問題解決を
>       支援してください。
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
> index 969e91a95bb0..34f14899c155 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -157,7 +157,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
>       리눅스로 전향하는 사람들에게는 매우 중요하다.
>   
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       여러분들이 리눅스 커널의 보안 문제를 발견했다고 생각한다면 이 문서에
>       나온 단계에 따라서 커널 개발자들에게 알리고 그 문제를 해결할 수 있도록
>       도와 달라.
> diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/translations/sp_SP/howto.rst
> index f9818d687b54..f1629738b49d 100644
> --- a/Documentation/translations/sp_SP/howto.rst
> +++ b/Documentation/translations/sp_SP/howto.rst
> @@ -135,7 +135,7 @@ de obligada lectura:
>        de Linux y es muy importante para las personas que se mudan a Linux
>        tras desarrollar otros sistemas operativos.
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       Si cree que ha encontrado un problema de seguridad en el kernel de
>       Linux, siga los pasos de este documento para ayudar a notificar a los
>       desarrolladores del kernel y ayudar a resolver el problema.
> diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
> index bf95ceb5e865..c2757d9ab216 100644
> --- a/Documentation/translations/sp_SP/process/submitting-patches.rst
> +++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
> @@ -276,7 +276,7 @@ parche a security@kernel.org. Para errores graves, se debe mantener un
>   poco de discreción y permitir que los distribuidores entreguen el parche a
>   los usuarios; en esos casos, obviamente, el parche no debe enviarse a
>   ninguna lista pública. Revise también
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
>   
>   Los parches que corrigen un error grave en un kernel en uso deben dirigirse
>   hacia los maintainers estables poniendo una línea como esta::
> diff --git a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> index b8120391755d..d6b8f8a4e7f6 100644
> --- a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: :doc:`../../../admin-guide/security-bugs`
> +:Original: :doc:`../../../process/security-bugs`
>   
>   :译者:
>   
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
> index 10254751df6a..cc47be356dd3 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -125,7 +125,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
>       这篇文档对于理解Linux的开发哲学至关重要。对于将开发平台从其他操作系
>       统转移到Linux的人来说也很重要。
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       如果你认为自己发现了Linux内核的安全性问题，请根据这篇文档中的步骤来
>       提醒其他内核开发者并帮助解决这个问题。
>   
> diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> index eed260ef0c37..15f8e9005071 100644
> --- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> @@ -2,7 +2,7 @@
>   
>   .. include:: ../disclaimer-zh_TW.rst
>   
> -:Original: :doc:`../../../admin-guide/security-bugs`
> +:Original: :doc:`../../../process/security-bugs`
>   
>   :譯者:
>   
> diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
> index 8fb8edcaee66..ea2f468d3e58 100644
> --- a/Documentation/translations/zh_TW/process/howto.rst
> +++ b/Documentation/translations/zh_TW/process/howto.rst
> @@ -128,7 +128,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
>       這篇文檔對於理解Linux的開發哲學至關重要。對於將開發平台從其他操作系
>       統轉移到Linux的人來說也很重要。
>   
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>       如果你認爲自己發現了Linux內核的安全性問題，請根據這篇文檔中的步驟來
>       提醒其他內核開發者並幫助解決這個問題。
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b0db911207ba..ed84d41353a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -73,7 +73,7 @@ Tips for patch submitters
>   	and ideally, should come with a patch proposal. Please do not send
>   	automated reports to this list either. Such bugs will be handled
>   	better and faster in the usual public places. See
> -	Documentation/admin-guide/security-bugs.rst for details.
> +	Documentation/process/security-bugs.rst for details.
>   
>   8.	Happy hacking.
>   
> @@ -18807,7 +18807,7 @@ F:	include/uapi/linux/sed*
>   SECURITY CONTACT
>   M:	Security Officers <security@kernel.org>
>   S:	Supported
> -F:	Documentation/admin-guide/security-bugs.rst
> +F:	Documentation/process/security-bugs.rst
>   
>   SECURITY SUBSYSTEM
>   M:	Paul Moore <paul@paul-moore.com>

Thanks,
Carlos
