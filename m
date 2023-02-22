Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68169FE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBVWSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjBVWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:18:32 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890247412
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1677104293;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aZ89vT8cHjS8N+qbvxKVZHCmtfy3PrkAe1jFZLRj+nA=;
  b=EmP2WEsB9OqqsLZOsA1U0bChkoRjEJrDgoSV9szpA+1Vg7GcC7ZpVcPo
   mR4ulGXdEdx2JCIZvNxUD0NaUAKzJ0KbbLc0xhjCI5u7BtDDtsTWKkTxj
   SVdIX3/P7tFYNOSrVoxriW94a+xabOdUR6B29BPj2QJRffo3vj2hVXk5N
   8=;
X-IronPort-RemoteIP: 104.47.73.44
X-IronPort-MID: 98141826
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:rffy0KrXau5v8Mqrk0g3fulmBGdeBmIoZBIvgKrLsJaIsI4StFCzt
 garIBmPb/uPMTPzf9giboi3oB4AsZDSytdmSgBrrX8yRCsR9JuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WxwUmAWP6gR5weEzSNNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAC4HbBeT1tyT+Yy2cPNO2uEAD9DnAbpK7xmMzRmBZRonabbqZv2WoPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+OrbIa9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPOzor6Iz0AfNroAVIAA4BFud8fSFs2CBAohxD
 GwJ8wEns7dnoSRHSfG4BXVUukWsohcCWsFXO+I/4QCJjKHT5m6xDHAsRzpAZdp28sM7LRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDQcUHVUt4NT5pow3yBXVQb5e/LWdi9T0HXT8x
 m6MpS1m27EL15ZXi+O84EzNhC+qqt7RVAkp6w7LX2WjqARkeIqiYI/u4l/ehRpdELukopC6l
 CBss6CjAComVvlhSATlrD0xIYyU
IronPort-HdrOrdr: A9a23:tpYe7KGPGduWw4Q7pLqFjpLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6faVslkssb8b6Km90dq7MBThHPlOkPQs1NaZLXPbUQ6TQL2KgrGSoAEIdxeOk9K1kJ
 0QCJSWa+eAc2SS7/yb3ODQKb9Jrri6GeKT9J/jJh9WPH5XgspbnmNE42igYytLrUV9dPgE/M
 323Ls6m9PsQwVfUu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyR+49bLgFBCc/xEGFxdC260r/2
 TpmxHwovzLiYD39jbsk0voq7hGktrozdVOQOSKl8guMz3pziq4eYh7XLWGnTYt5MWi8kwjnt
 Xgqwope+5z93TSVGeopgaF4Xir7B8er1vZjXOIi3rqpsL0ABo8Fsp6nIpcNj/U8VApst1Q2L
 9CmzvxjesdMTrw2ADGo/TYXRBjkUS55VIkjO4olnRaFa8TcqVYo4Az9F5cVL0AACX5woY6F/
 QGNrCV2N9mNXehK1zJtGhmx9KhGlw1Axe9W0AH/veY1jBH9UoJu3cw9Yg6pDMt5Zg9Q55L66
 DvKaJzjoxDSccQcOZUGPoBadHfMB2NfTv8dEapZXj3HqAOPHzA77Tt5q8u2e2scJsUiLMvhZ
 X6Vk9Cv2JaQTOhNSS35uwJzvnxehT+Ydy0ofsuoqSR+4eMC4YDCBfzCGzHyKCb0rEi6s6yYY
 fHBHsZOY6lEYLUI/c74+TPYegiFZAgarxkhj8aYSP4niuZEPydisXrNNDuGZHKLREIHkvCP1
 prZkmAGCwH1DHmZkPF
X-IronPort-AV: E=Sophos;i="5.97,319,1669093200"; 
   d="scan'208";a="98141826"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 17:17:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMtawpTPqmwH2qmBPBRO6eYxcjxcjtEKtSzNrEJ8ygiKBjS2z9yJ+W8d+HCdBKNrSYkA9kTKb88d4riBFGE8HSn1Pe+vFJHYuhZ9l0st3+h0Op3N4qBtoZpHVE/KsO5Z3b5WhhBkd06dA65XxtqGwZgWJOK3j/2C04Q4z1ilD3jcG0nQ7SPI41Ni3ynG9NW46Idc/VvIZc7qloqCpA7wUMRIsOlrxoRpXiBQ9+zIf+LTiANEL2RX0q1/ItM3LTBMapjT58o28ke0P7CeDZmEw0aQS3BWvmOmGMsVuOmy25ZEWVji0Nk0aaL28r/RuvkyTRJHckHMfaf/hz3S08Pn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ89vT8cHjS8N+qbvxKVZHCmtfy3PrkAe1jFZLRj+nA=;
 b=lmbWN2uQPdNp4f1vpmqret9IOqwdfTgHgyziWO9noXtDe6lOIBcg14q5JWGaw2o5XPKgrKil+cNF1u9oPYITztRwq0TIjclSQINulbE81V1hfeTGPvMIdgnSy4VOIpVmwagpJXaDQnTl7jmRh7lb6aPFoIA//LlodoY++iE7QFDs/uu9KpuYgKrfig8Oxe6b7V5WNXc9wK7i4wNIsMZiGK3JJVuTqbOaUAUVE/DJujXFkihEM94wnewOFipZfM9tYX+w+s2BnXGWaW8kTqAQP1SxBH2HYFDdqjK2PCDPP7IG5fWdqv9jtlnLIKfkFK6JJCcUjLG+uL0zEnlBOIUpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ89vT8cHjS8N+qbvxKVZHCmtfy3PrkAe1jFZLRj+nA=;
 b=CZDEVgGTJwKleHXIGMI1/EkZNv7OGQk157D46Xps3GKDnk/GoIzCSdO4Qyj4vqGEfRfYDsv45wobTIMpXHDOycA9zon9CzgnvUniLWuRafP+l36DACXCd4wHp/3Wk50UzDKZx3lH0d0x584V3ijT2itvRQ8bUU7fi6rPPoHikhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5279.namprd03.prod.outlook.com (2603:10b6:208:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 22:17:41 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 22:17:41 +0000
Message-ID: <f074e03d-a991-23cd-80d7-162067143034@citrix.com>
Date:   Wed, 22 Feb 2023 22:17:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Content-Language: en-GB
To:     Tavis Ormandy <taviso@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic>
 <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
In-Reply-To: <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::19) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MN2PR03MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 1241776c-2cc5-4e6c-fd82-08db15229cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tULZku23T1BXvs4bgbsGEC5xty4/rz/POJlv3g5Rf7WCu9EeRMV5pUiZ0aWLs5hajaRlCCkOXWQH9dC5KlJx+gDevXq8aF2zWeNtqi3i+M999Ug2jlBRrIdFUOyx4lwAIEKjtLT3ytbXJa8MUS26KGXzwvVo0d53cwrqY0Nsstoh0bz2NI/2W6367UGmNcENUVWt2DrS8LXkgR34btqfaeNKugiBMO18I51peRJprdgTteiTbMyDyojAm/4zj0ut5Yj/SBY7T2GasdcuRJXpjN3s+Abr5KxBWcBoHNv05lB3NzuCCdBpyJR90RxiXUl3fvCGL0XeyviwYROy1a1Le7CzoilPLaoO5h55y8iyExiiGXx70WJAPXGz+ism2cefEeq1Rh4lzEnTsX5QuHVGH7+q4UICfpU9yeTI2mONTLuvDscupkNcq263E45/LMKpJeyDCZXG49bdw8fU0EdY1yez2lSMeEnXdH1VPTg3wUrpEKtVnZXY/MCvIYMUbtfvcWeMgrmylIMziVN56LhX08hmvud5o9ZZdQn6jAloOiO1Kpfi/sCYu9WjacLOxKy6vAwBaSFZ7iOAUo9dgaKvBjSMSd0Prz8NDGqhfETESWili9DZ2qSXaOHDCNCQkbdVba/gOUSlGQTCdbSQZDqmM1VYebUnnJlexIvwkqpbsqqUfGRtPmKezzjq13c3hd0lsImCiH2PU6FdDxFlA6Nzv5jDFHmF4UDeE1nQ3mvs/0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(6512007)(186003)(2616005)(26005)(38100700002)(82960400001)(41300700001)(83380400001)(478600001)(86362001)(31686004)(8936002)(5660300002)(6506007)(6666004)(31696002)(53546011)(66476007)(66946007)(966005)(66556008)(2906002)(4326008)(8676002)(6486002)(110136005)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akF3MThuM3E0UzJiblhLRDJjTU1ySlV0ZkNOQ01obU9PVW0yUW5wbWNYb2JT?=
 =?utf-8?B?ZXRhenRvRTRTNWNqeDdSWHJLd01pTFNuS01GUEZYcTlMRllkbnNjY2pZTzRq?=
 =?utf-8?B?YktvZjExRnJwN2JqNmVGaGYyRjQxNStoWVhLTU4xeEQvWXpaVlJtT0NORENo?=
 =?utf-8?B?WUg1bE5nS09FRk12OVkyaG03RmtZSlJZSFBVYUh4aWNheHdoYkRrL2N2WGlC?=
 =?utf-8?B?cUdhNWo2VlBXN014OXNrT1ljbENFQjA0SmQ2bm1BZ3hDaDdaVk1EdWlpaXZ2?=
 =?utf-8?B?K1RWODZhcDhUQm9LTGFZQkh5bHFrQTlYQ0Fna3ZJcjI1RXdwa0RnenNYQk5W?=
 =?utf-8?B?ZWNkTnJnZzF6Vno1dGF1bklVclNtZERBRGQxUjBpQy8vSUdZcHc4Z1hackh1?=
 =?utf-8?B?SUU4bThLTTFIR2RlaEp6NzErYncyZkdOZ2ZyOVpNcTlTQzZrSzk2NlE3SzV1?=
 =?utf-8?B?N1dqZU1raGJ0bWFCTWxqRE5JMHF1SHZ5d0pzSWhWdkpKRDVDYlc1SitESjVr?=
 =?utf-8?B?d3pXT0xCeWR0TXhlcGlEZ0xCcDhhSGd4M3N3cWtVbHg4eUltMXdybWk3UkZ1?=
 =?utf-8?B?TUcrQ0pablgxU0hPaW5QNkpvTU9TNTlaTXdKTHlUdlcwenV2Qm1uN08zREsr?=
 =?utf-8?B?VXVveUFTQVREWVBRN3NrQ3lneUYrZ0VWREwwTmxrTHczbVlyK2F5UzNLT1c0?=
 =?utf-8?B?dmRLVjErL2VOT3JhbmtDdzFqNm14WXBKbGlJdkFzdURwYVV2czJ3cHJlOC85?=
 =?utf-8?B?dGtLMHM0citEWTg3Q3lIL3Y5R3ZmN09CaFd1dE5uUDFnOVNaZ3EwK3lHTnkw?=
 =?utf-8?B?akoxbDRGem9XQ29BRlpSbGVmam5TWUc4Nm5mWWNYaUFlR01SRzU2bFRwbjRD?=
 =?utf-8?B?QXZyM0pmQjV2dEljOTJWNmVoYWZ6N2ExQU1kdHh0U245Umhrell1by84dFd5?=
 =?utf-8?B?SzBoM1N6Ty9XTkFiU1pvUFBQZTh0R2RaNWYyc3lnSEp4dUdyVDdoR1Rkc1c2?=
 =?utf-8?B?R0ZvL2lWU3hkendBa1pPODZDaFdxMm42M1YwaGFITGNEUTN0TitEQW1uckEz?=
 =?utf-8?B?Y1FLRWF2ZExqcTNyMU1WWmt6RFFSSGNFR2ZFLy9ubSt5YU12UFJhVHN2RFFC?=
 =?utf-8?B?bW16MnVJb3N6UEVYNERiWXNOeTdveEJUcUdvVlplMmdwSDlIS0FoeXNLcjN3?=
 =?utf-8?B?Mks5alo5dDdTQUtPeFRrNGFzRGN6Q0xDZkk5L2FIVmRwVmRZSEpYSFdreS96?=
 =?utf-8?B?aU1nQ25qVzQvMVZ3dUs4QjE5cUVrSlRXYXA5UGdUeGJyc1JYcmMwQjhmZUF6?=
 =?utf-8?B?VkRjemhIUnBQTUc3eWZ5THVPdS92VERGdjJncVZRRlpaS3hPK2pCMzRXSExu?=
 =?utf-8?B?KzVjYVdUemY5b2NQbCtrc3RGa1lacm9wMFhJWmFtNmVvVXQ2QzZEZm9jZFlB?=
 =?utf-8?B?R0FsalpiYU51OG9IWmVCRkVGZkxNUVpLcTRvMXNaMGp2T0Rycjd1d2hHSWhw?=
 =?utf-8?B?UVN6a056WmNNZE9JNW9vZnJBdWtmVWlZUlU4MXp2TWNWN2YvcGUxYSswTEor?=
 =?utf-8?B?cUtaeXVUaE41MGxSSWcrdGRyNUFIM3hqWDBLRHJIY3poa3J3QWRRdVUyV1o5?=
 =?utf-8?B?MHNscXFJcXJmMVFteFc2eEZxWERpdkgxU1RmUW1EODk4T3IvNVcrQXVoN2po?=
 =?utf-8?B?SS9kckRkQWFmWmtuaDR5NkR2dnNTS29WOXFibmQyMzNEK1ZaaWF2ZjFyUDk0?=
 =?utf-8?B?SG1abHEvZzVvWW5kaFlrSmFyNmpiZ0J0ZXVNeGRXaHl2ZWhkU1ZJWE9sNVBB?=
 =?utf-8?B?cVRTSkUxRVdPRittcWM4Z01ZdExVYnZqR3FLdkZvQ2JGbjhTclltYS9jcE5n?=
 =?utf-8?B?YUdSZE5VNGdjUElNTHZiYkVMSmgybkc2UEhReTI4YXB1Y2JJOE40WXB0TmY5?=
 =?utf-8?B?c2pMSzh1Z3d0My9sV3VtWVdGVW0wa21aU09peVJ5OUhtN1NPRE03NFpmUk1M?=
 =?utf-8?B?WXVwMEJxWGRsWnNWZ2ZhRG56TXhQNEV6MTZsYUYzWE16ZUdjL011RDgrUmFk?=
 =?utf-8?B?cEdJS2I3ZWZDV1IvZ2oyU2hIYmx2eGFCWDBRMDBReEVpVEJ0SjFYdC9XL2pH?=
 =?utf-8?B?cTJUVDZHaHlwbXhVbFJnVzdUWkFxMStTMEMzQUlJZ3dFa0xYVURkWnNMNGZt?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p3xydV6O/V53MnKptRoLSdt3U7/mOaaylbqFD4EssmLEPeMPbHm0vazQzaQGhj2AxK1eG8p57l6D8WVdHMurTBZgGo1oMWWWDvJd2aC2YmmMg3+eMdSvIBYDcO7oxQx+nVg0Oj/kI+x2sUkig/Docg6wAwYJgBrSi4btngKzR9DCtU2CP1LZvrDDoLpFwxMF/MtcrvQlKrya3On7bS0yjI4igsqsYlaugIX3uGAaQsJgof3qv6HfQzOWgVRILEJQCX5TVdEoaQwJAGWhdZfdBYmhg/FQafpu4azjO2bEO91z6Plx/f/6LdHm08PjeT/E60sq6t86IyWZgKeHbCcNS3R0JrbLCn3WhTS5KjHi6ALREQ3+ux0U0gz4toH+tXOT31rid7K2TMjMO6lRsrY49/NBj/OREylVXdKoqhkTEYRKmObZ2C8HbY3nnS+Z7JOvk5Eec/eLqOVrCd+AMtbYVjsl5gyltIDhPy1Ify1VeM3EjqR3EmIjcjySD1NnR85t7r8e8LtCbPv36noxk1yp+soLQT+udgEdmg4Az2J4KgDELRSlAUV5NQpabJWeV1FzsYrbb9gSPzbOCmjzFbp2UO3ptZVdMHbRXkdxrIgKnzRkhw8diIhaaIshDr91Htn+gTxdS5YNhMFjuuhaE/1x4IN6btwk7nIGyKSXaRtll8cA3qQkmOsFGRGivknkN3w7FIRs07teaR4lG+TYZDLu+m6EmLy5/w0g7bOqHENSjwbHNWZ+rM49r72zu4azEq3acQJwNggq9heOYhxIKsIQC96SIk7zAhW3CNQxjes2joxO707WFPiFdKuROuByRZhCnAEe20p4wsDL6rqrfMKhjbTh1XX2vIV4KnkNqaccuP4=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1241776c-2cc5-4e6c-fd82-08db15229cae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 22:17:41.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdADWfkoqbRi19eIowCW5K9S4CCQOnanPJBAAbXGbhFAtTTO19bcseU66RjseH0hjHSQ7kEJBG1vCMU5OMu5eR1CO+lNnPewwQpB9pctkoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5279
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 9:26 pm, Tavis Ormandy wrote:
> On Wed, Feb 22, 2023 at 11:09:51AM +0100, Borislav Petkov wrote:
>> On Wed, Feb 22, 2023 at 09:38:09AM +0000, Andrew Cooper wrote:
>>> This sounds suspiciously like an errata which was fixed with a ucode
>>> update last year.
>> Yes, it looks like it.
>>
>> Alternatively, you can try booting with "clearcpuid=xsaves" - that
>> should take care of your observation too but yeah, you should rather
>> update your microcode.
>>
> Thanks - confirmed, it *doesn't* repro with 0x8301055, but does repro
> with 0x830104d.

For completeness, this is erratum 1386, details of which can be found in
https://www.amd.com/system/files/TechDocs/56323-PUB_1.00.pdf amongst others.

That said, looking at the list of preconditions to tickle this erratum,
I don't see anything in your code which would cause a change in MXCSR. 
Which most likely means there's a path in the kernel modifying MXCSR and
that doesn't sound like a thing that ought to be happening by default.

> Annoyingly, I thought I was using the most recent microcode, but it seems
> like there is some bug and debian wasn't applying it at boot.
>
> That seems like a scary errata :-/

Honestly, this is tame compared to some of the things which get fixed in
ucode...

~Andrew
