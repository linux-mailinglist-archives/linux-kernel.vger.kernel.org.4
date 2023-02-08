Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90F68F861
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjBHTwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:52:16 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A1166C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1675885934;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FXbsB4ymfHsDz1A6qK7gdZ02zoTX+1Pao4zny8xl4Aw=;
  b=ggtKcZISBvpEzklkgWEq0MBtF+dY4g78ObbnqaEUW1yFP46y6vrfwFdo
   4mMJSlxW3jNIp20EPhH2wOmLq6UhmWLqSFm8DExhu1X/Pssd0cNhNmIre
   QbWcUHsF6mOrVYoJ85pjb+ra706jevnyTAutnS70PwGpkGb7FroTy5JGW
   4=;
X-IronPort-RemoteIP: 104.47.59.168
X-IronPort-MID: 98672734
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:G6whE62zwOy+JerdY/bD5SFwkn2cJEfYwER7XKvMYLTBsI5bpzIOm
 GQaXzqAOPiNZTT2e9wgPNi3/RwDsZ+EmNFgTQo/pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS93uDgNyo4GlD5gZmNagR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfWEZ02
 9cyDBMxZQGpqt+a/7yac/ZriZF2RCXrFNt3VnBI6xj8VKxjbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsi6KklwZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXKrBt1IS+bknhJsqG/PnnUKBDkraX6+p/u1gRXld9diE
 FNBr0LCqoB3riRHVOLVRxCkrWSWlh8aVcBZH+Az5EeK0KW8yxbJWEAHQyRHZdhgs9U5LRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDQcBTQof6tzqvKkwgwjJQ9IlF7S65vX2GCvxx
 zTMtygjm7gWitAj06S94ECBgjSwq5yPRQkwji3VRmWk6wl+aaa/aoCo4ESd5vFFRLt1VXGEt
 XkA3sSbsuYHCMjXkDTXGbtdWra0+/yCLTvQx0Z1GIUs/Cis/Hjlep1M5DZ5JwFiNcNslSLVX
 XI/cDh5vPd7VEZGp4cuC25tI6zGFZTdKOk=
IronPort-HdrOrdr: A9a23:kI+QiKlpC+TU2GouxCp/gsEpjrrpDfLw3DAbv31ZSRFFG/Fw9v
 re58jzsCWetN9/Yh8dcLy7VZVoAkmskaKdmLNxAV76ZmnbUQiTXeNfBOnZskXd8kTFn4Y26U
 4HSdkaNDSaNzdHZKjBjDVQXOxQp+VvXZrY49v23jNGdykvQadl9gJ4AgGQHglNQhVcD5ZRLu
 v+2iMCnUvYRUgq
X-IronPort-AV: E=Sophos;i="5.97,281,1669093200"; 
   d="scan'208";a="98672734"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 14:52:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwwTDJQh1FQe1WGyEyMIaf0ucPMHw3W/J3LBqozBkUG0O6vF9PeMt60a6vhQb+PSn4KFPmi6GirkKIWfi7wTZt8PqoTdoodH6+2ID3jxqVbcLYJhA04Yw1zqmKc4iiAcVrhxIPzfx9V04yQ6zosnSCdGkZPbBNkesOuTD6Kh8V6AyJExq1rW/37ZgIf9BuS3QclFlP52tNkOMPI4H9s8LEFjGlcQA5KYKne3QygAV5YK7O5lj48oH9c9jL95J8Fzw79Xru6kR9MQL/2ACdn4/8cAK54Ti2eSJzTsM1XzHwY77wSePWeYTPu9IZ66yPsBZFKftzxUuEVEVhXk4FTUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evSnJ2RYphSZCz0L+WIkYWNP9owqX7zG8WQmPGT7/gw=;
 b=BCUy1b9vU3QIY1OpLpc7rs/ZOmlaYwwJ7o+JZgYs9Piz+6d5iF0jkmJX6sqLaOY0WAjGmZ3R75/+rtwsqf58/lEmI/L25UVu+a/QFH2ZGwp6zA14UwVfijetxaqyCHYkaLG7vuD8Q+AZ6fLJ2PYqiX/tj8ho7olbcMKKx9LmHQyOG/qFxF/q3RJySHUzn8ucW0BFpPixRT9hFfAlmK6IuVJPAY1Tk3rhxx8LUnZSTDDpum1wrlR8sVCeHO1k1hzzjLtExtttK0o9pa2uGYSJWoqnBBaJdaHdCImwK2hwEpb03FBMyYquFOSLOHCdLDx8GimA4sOx5JMDAFxmLu13sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evSnJ2RYphSZCz0L+WIkYWNP9owqX7zG8WQmPGT7/gw=;
 b=Qbn/sz2+s0+LsHdeZlZ9FqRjFwwocil+tansndSh2/fGRBnAdD4jlV1O1XvbqZ4yKlBtJ1jybKwIo9h2UUz9HX90QwC4vyzP16+dlI5dgfoN3qhrnRfgOPnvP6GGuywCnGMBmqVjwa4ek1hrPUt4z7WwpmjmB+ci7ZbCYDqcKHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO1PR03MB5907.namprd03.prod.outlook.com (2603:10b6:303:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 19:52:11 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 19:52:10 +0000
Message-ID: <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
Date:   Wed, 8 Feb 2023 19:52:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew.Cooper3@citrix.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
In-Reply-To: <20230208171431.373412974@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|CO1PR03MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fd4026-435c-4f5d-47d9-08db0a0df72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhouRKI3yOzZiGS/Bit3QbfCyA49dNXWQtOY4B39bxeW1/IGjdKYCHW6MwEm1tJhvKnlUiO735zQ8yn32vmko9gsIXK6fj2V405vl5OIfNiafmAfnFNPBGWvHN4lli8+DF4QJ1Zk4pLJNTt63FpKEbBD5scynSBmAptSz9Ci5QvyUTGUMLgomOcv7WUfOW0MjYZo8Kg/m98ntJl6BxBL6ILPDAuA8optqJ7DYTD6lEMfwG3jsLKKf7ohKdSnwvnw0hdZGrokFxtP56bx9unxF4ttZO+OxaKW4+6/Q7zb1spZSZseU0wpsR2ROWmGyHuux3erOxhmmESwu2rKvSC10Du6P6fnariuLmButg5HiuN6zlOV9wnF0kv3xIW/jQ0gwhJ6MIAPRZ6S7UXpdU9vgyQPLQB9WT0QciG+z89iK30i2xTa5pHII4egGexNSzED2cQGwxbH0qvJ3eVjckIAhyv4hGmTTxsGhv4VUt12LnB8Wc73mRrHYGwLb2V8CP/RLFD7tDWyYq3+2uBt3VZknA+Dq3atXuGUqd5hYVYDRSNv/dFqfGRiMBuRGB8r8cXu6ex4/kKwriA6a+ZFG2unBNHBhovMB7VvK8vITxddOQvRrw0QmhVctQThJCFwxiLz/2Xnf6jUAYW4hBdTsgGcV5VezhI5XFCMIr4DYMZP/lR42UgPnMsplrVwokMAP6JTnp3Yypfa7lpMHWv/n+dXgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(86362001)(31696002)(31686004)(5660300002)(38100700002)(2906002)(82960400001)(8936002)(41300700001)(66476007)(8676002)(4326008)(66556008)(66946007)(316002)(6506007)(2616005)(6666004)(53546011)(6486002)(9686003)(186003)(6512007)(36756003)(26005)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdDaC9PZ0JiNFpEV3dDR0pGSXZaTVFzcWpoK0thU1J2OUlTckJ2Zk1yQklX?=
 =?utf-8?B?UFprM0tnTjJQSjZEQ1Y4aHBvSEtZNjU3cXRvR0hINTVIRlRxRENERk81SHZM?=
 =?utf-8?B?cVpGenpLSjJvNkU4ZVB6eHRwN2V0TVhBajNQSzAydU9ueDlTUDkwK2dDTnBo?=
 =?utf-8?B?Z3M4Y1hBZ21GNDEwVEExSlkrNlhVVTRrdGhtcE4wYlpmMTJRWFBCYU1wWXh2?=
 =?utf-8?B?OVFYQ3QyTG9WaXB1cS96YzY3K3NkWmtzbzdFNUxzNnYxZlIydTBMbEIwb3kw?=
 =?utf-8?B?aWs3VkVVOThORDRvM3R1c3hGNDFTenpGOXBLUzFwVHN2V1NoRkRuZ1dlUmhk?=
 =?utf-8?B?VmVQNTYwMlNOYmVocUlvcHpBdlF0T1lVN0UvZ25lN3VTM29qWGg3V3h0TFhD?=
 =?utf-8?B?dTFxZU1WQnFoTkd1eEVnRFMxQmF1cy8wM1QrcFRjWHQzY2UxRU8wTzh2Q29J?=
 =?utf-8?B?bGJlN2xSRTVJOGF0TWRSUjlnWFB5NjRLY1B0UTZRN2pLRmF1UG0xS012NGwv?=
 =?utf-8?B?ZFkwdDlhUmQ5N1ZqRE1idWNYaXJZK053cU05K2UydXdSbm5iZVN0Q29xL2Z3?=
 =?utf-8?B?MXNydXZQQVFwSnY5TjBXc1RtdGRXRUZpR3JSczdHaUdGcjNYamtRR2FCeVEv?=
 =?utf-8?B?TnNKbkVCVWk1RVFGZmhqRDFIeGxxT1YxdXIwaDFRb3BvMUtnVE9ST0NJT05i?=
 =?utf-8?B?OWZ0SDMzWEZkRmQ2NWlmRmRWMElUejR0OVE2Y0xBQWNpSFZ6SXVKOU80aDhm?=
 =?utf-8?B?THFPQ09FYUxLY0NLSWFKWHF6MFlxMnRYY0h6Umh2V3h5SytOMUtsQkhkNHl2?=
 =?utf-8?B?a0V1MlJmbmx5SWV6M3ZFQ3picFZDRXZ4WUJ3VWRQd1R1NXFYM1ZNbFZRaW5P?=
 =?utf-8?B?UzR4dytabHpwTU5GODl5S0Mya2puMWNtcE9vbHN4RUVWZmNEbGJ5RFNnQmps?=
 =?utf-8?B?QWN5RDJiRG1RNXRGS3dnV3Rtdk1DMW5vdFdBckdIZmZEYjBZcE1VaWY2N3lZ?=
 =?utf-8?B?TmVNSDBaY21tbzdkQlptNFlQbEs4SGtMYlMxcEdVV2lDaDh1UHhWUTFEWSsw?=
 =?utf-8?B?UW5UakRyZzRHbnZMdlFRUGN1M3ozUjZhb2JzdE1lN0RsbUxIcDZvMzArSXpZ?=
 =?utf-8?B?YTRjQk4xVUZXTytMV0M3MlFibHRNY2k0bU9EMGhMS0ZlYm1tc0o5d0R4cEll?=
 =?utf-8?B?UkR4ZFVJYW9rY0Q5QmxBOTRoOHp2c1h3TXFiMmJuNGpMZTJSem1iU3RDbVlP?=
 =?utf-8?B?elBqNjE2aUQ1WUUxWkE1Q2hBZkhXR2pDazU1S2NXdHk2U3NwSVdIU1phazM0?=
 =?utf-8?B?WDNLamdMdHJnUEp4RVZqR3NYVXErK21xcEMzTGJ2NjBmM0FtcStkRjU5QzRH?=
 =?utf-8?B?MjRrSUlnOEpqS2hLdmVQamFHTlJvODlLek5RaWNVT1lXMzNlN0pNZU9mbkh3?=
 =?utf-8?B?Z0xkeUp1S056Sy8xbnlscHNLVGdsbkVWb05MNGhPYjVFbDgzLzA3OFp0VzU3?=
 =?utf-8?B?Tk51Y1JPcVZWSFJWZ2VMd2JNRHlITDZFdGYzbUUvM1VOTEFyMjlCOXhGL3Zi?=
 =?utf-8?B?bjlCQnlaTStIbUhESkFmSEwrdWNkL1BMOHF6UjRuOTJnZExXSm4ydjdWdll6?=
 =?utf-8?B?N05GemlRTmQrcDFCUlNlaWlWSFZUbjYyczE1c3JwalhTd2NMWFRkYWVMSEVO?=
 =?utf-8?B?cmRRRzJPRVV1Z2UvSFFQdTJEMWwvTVh1UWk1UUg4ZFAxNVVlREhsWnJoVlRJ?=
 =?utf-8?B?ZWh4blV2cG95OXUwQzlsY0FvZ3VSc3BldkhMMlNRWGZGOG9iL0Z0djZaVmdu?=
 =?utf-8?B?SWdFdTlwbC9uVlRidFMyeTJCMFdoZmpLWnh0R3pHZXJFQXJPdGFmT00zODdT?=
 =?utf-8?B?Z1BRZTIzN1VmekE0ZWRpbDlKcnZWcld3aldkampYWllFMk9NVG9QVHV6SFVF?=
 =?utf-8?B?Z3BwWDZSUDJkRFN5VnFTWGNGVHdreEowUlRrdmZCY0V2RS9hU21rNk43Qklo?=
 =?utf-8?B?K0lXckxqOFAvaW9saG9rcGJpaFV5aTNPK25jdFV3a3M3UEdvd3piUm92K3lX?=
 =?utf-8?B?cGRZeEFsTlQvalVidTUrdjViRHhzZjlTUEhJVlZYWkxqVUYwYktFMXJwdVB4?=
 =?utf-8?B?UHB6ODdvb0xVWXhKZzBHT2xjTlNwVlYwaERwemt6QVRXRmpLYlFzMmMwSHhU?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6I5cVONZ877nstm1IFNR4YCd7R79PbsQlFNfbSqa7YEMyZ4inQcoGnWemAb+dhPVzV8RKVCvZNZNvPWsgOH6DYeCZF/R+NndtKE/5jMgvNOEXEArI9/kPrV+m5pdbekJprMyu47mb57xrunzr+xz6Mu9W25gg/bkA8POftkM5DRcBtTk+4tGuiHbYf7hdUDYxdRxErnN0Bb4F9vQWGX0Do1kMQHhKxurWhBjJPH/EQhNiFF9G0uVGBQCLb893pb5q8idlUow88BRI1ASEfggk+eu7c9/EXkn5O849dDNC864EiGZr+ViwafYv9tUbWApy61LjLEaDdMyGQx85IsMT0aTZPieg+T9LLgtsO/DVdscQ3QhYMGwLvJuzs4ToyTLVulHLcRYAaUK4whceqkU48FHzSDdqeU5bg188LbL9VLCAb+pbIqzlbzBwcy1tKzbJVAyOoOWgQkOoyelq7HcLRwA21hgXs5cG6mBH4qRFgfhyCHq7znDDcYRYDqAs4MKdcYrw/dLxfLRKJxcZ5XOcFOMx5Xn4U0/hxifg4FbnJth6V6TdbF33RLz0uWtJ8U5iwB1Y/zOWfXUKHNMD843N2wCph/DYTBRzQsaD2l5g5RoAub+HDrGRsN2b+Egp2IPfcPLh1w5P0NA+eu3byUIlSUcJDr+IeLcTr/UbOo3WalAOC5zh5w3P5Rj01/AppnR1/0YokFXELYfs3ZzImReUOJohZO0DgDQ9ehb9FiIuwA8xsRhChqhWYGoTLmnk0c+4Znm200QZ/MBVXrn3XhZEX8kd7i5P10BlPp1rpLrlPQ6LP0Q1YsCRKuk3rWZr1pPlbxTJ9MoXYY2FrvUERH1KCam/5q7HijXA1LEQ0zBtbGC7IAzpRFBC6gFVn7dAVRbG871AA6F49SVtcwQODvoWA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fd4026-435c-4f5d-47d9-08db0a0df72b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 19:52:10.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtH3KWI5QRCYNtTpWtOtNKsS/71PCffotKinflvHL0A+fFrEMKQGuLHRVUR/jT3HFgeC7TSug73dcPb7noJ0wGPVoTJ/wiSYj3Br/inCeSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5907
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 5:10 pm, Peter Zijlstra wrote:
> This rewrite address two issues:
>
>  - it no longer hard requires single byte nop runs, it now accepts
>    any NOP and NOPL encoded instruction (but not the more complicated
>    32bit NOPs).
>
>  - it writes a single 'instruction' replacement.
>
> Specifically, ORC unwinder relies on the tail NOP of an alternative to
> be a single instruction, in particular it relies on the inner bytes
> not being executed.
>
> Once we reach the max supported NOP length (currently 8, could easily
> be extended to 11 on x86_64), switches to JMP.d8 and INT3 padding to
> achieve the same result.
>
> The ORC unwinder uses this guarantee in the analysis of
> alternative/overlapping CFI state,
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How lucky are you feeling for your game of performance roulette?

Unconditional jmps cost branch prediction these days, and won't be
successfully predicted until taken.

There is a point after which a jmp is more efficient that brute forcing
through a line of nops, and where this point is is very uarch specific,
but it's not a single nop...

Whether you care or not is a different matter, but at least be aware
doing a jmp like this instead of e.g. 2 or 3 nops, is contrary to the
prior advice given by the architects.

~Andrew
