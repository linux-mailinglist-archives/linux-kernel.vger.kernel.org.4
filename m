Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101869F203
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBVJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBVJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:42:10 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AC392B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1677058760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tupfe2xEHx34A+XhwcRc0fJQY+uToP/lRzq+ZR6Y4lQ=;
  b=esMTEUOwOQfHmWYYD2SOszCt10nfjVFVsBOoaidFl6wv6ds9/RDAbq2I
   1W+K9fnI/ULIhvN3nOYvEfGsqFWrqNTQdfTPPCB6V/5RzjA8zSni3tp/K
   Ez4TmkfMLiRURRuTyjXgj/KqNy1cIETEKKvM44TF1exVwfmuYER2mTsnb
   o=;
X-IronPort-RemoteIP: 104.47.70.105
X-IronPort-MID: 97948692
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IY0/1KsxtLSkQMj7IwRzeVpYNufnVGVfMUV32f8akzHdYApBsoF/q
 tZmKWuDOa6OY2P9fd93Ydiyox4E6J7Tx9YwTwVoriFgHi8b+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj51v0gnRkPaoQ5AWEzSFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwLzJQPjCT382Ny6viUbZRv+gCKZDEBdZK0p1g5Wmx4fcOZ7nmGv2Pz/kHmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0ouiP60aIe9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPOznp6I63gzJroAVIAExVlGJhOC1sEuFcdkBC
 W8d1g4StKdnoSRHSfG4BXVUukWstAY0Ut5RHutqrg2AooLI6hiYHW8sQTtIadhgv8gzLRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDQcUHVUt4NT5pow3yBXVQb5e/LWdi9T0HXT6x
 W+MpS1n37EL15dTiuO84EzNhC+qqt7RVAkp6w7LX2WjqARkeIqiYI/u4l/ehRpdELukopC6l
 CBss6CjAComVPlhSATlrD0xIYyU
IronPort-HdrOrdr: A9a23:+Qb75qP2nFxO6MBcTtCjsMiBIKoaSvp037BL7S1MoHluGaalfq
 +V7ZcmPGDP+VQssR0b9+xoW5PtfZq/z/5ICOAqVN+ftWLd11dAQrsC0WLq+UyEJxHD
X-IronPort-AV: E=Sophos;i="5.97,318,1669093200"; 
   d="scan'208";a="97948692"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 04:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9z+Ic3XdV5drCh7X9/OtySDFdeoUeoIBq4tQKF3mb/pJQspdrOniyGNMX27I2ZN2FeWV1BGXyOz9MjO+d/qkg7pnEINui10iQ+4CXGxrQbC5gEDzgOUqDYVD1vZJbch9vohLHyq/e9FMSty4DtpPsSZN3CLENByljxWJ3MfS1nfaoEJPt7oo9h80XzHplUlbSxYUzpBIgxcflf0qIieA8UNbLdr/ErowR5vwkGA5EcbfwC4lQqyIt8t8UNSKXfsevYF/yivpiTQKnyQ4jehpPxF9bnlrFe9iZFpCQsnlNcLJPr6QGzK8cNkPVxsMC7+xC62MRKcSOp2VrxNTbcy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tupfe2xEHx34A+XhwcRc0fJQY+uToP/lRzq+ZR6Y4lQ=;
 b=kdvAigx9XHKrLiqSmYEqE4u064k/nMRlB25Fn2I+1vhNAouNP+/wxPsXta1uwZRpTXgkhriYjDONhrUs+4RuMCVbyMDESCtcevls1icAsAjLOJyPDGWVmHruW5HbW5fwrfYaDanjljXc+TyXpD+Mamq+3cX+YSUGIEPKv04PdEiuTfeOhe7j6ZFgIjbcHHVoqK/zcuvLIoBG13QV4ii6xbFFIz+CVIPBzMCVr02A9JBEs60i+84cLyj3DgJXJH4GQtFK47N3Am0re83R0NnFWW9/0p4tGKgJEPy2xtK4XxfoywDgLsc9nI0TPWLZtM/ZMpBkQQ5WZOn34IxG71o0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tupfe2xEHx34A+XhwcRc0fJQY+uToP/lRzq+ZR6Y4lQ=;
 b=cqw01Snbwzej4mDND7C96co8q593ElOKn0knZ87wxa3SVH/KPVnxupU2rdAJtOdMN/goYWxMMYArSFhX8l1UANgHK3ujH0TppcQw1pSwjYVJ69CfaHRUT3hRIjtXhgybxNfBbnKNGKfz8PESgU04FGRWgbBxFY0zJfv4z0MAA4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SN7PR03MB7035.namprd03.prod.outlook.com (2603:10b6:806:351::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 09:38:16 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 09:38:15 +0000
Message-ID: <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
Date:   Wed, 22 Feb 2023 09:38:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>, Tavis Ormandy <taviso@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <Y/Xc+yMzI83WZ4V1@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SN7PR03MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: afada7a8-6bce-41e8-7927-08db14b8853e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 407O5s66aV93OyC95Nye6yoEbbWeRzPkOxlnCIZ7puQOgfSvg2WzJPlyM3GtzjBRgaY4h8O0Yv+X4CteBUgY8m0g/uv/OFrxMByMKxusxgUQwdAUYRXtbK442DsdMclXFfdXEvDeyqDcs7rUmlby0K4Rh164sFclJCavuIvCnhcncWHF8D+QwabeRDwOluP9BRnf2sGy/uVBP2N+0/yLIfk3dxXnbprPlRfS5NQQG7KOI6aiZM9neNPLpKbXS36GRaWG+hvetSYRbrVhIoaW0WpEJHjNsEba/dvydYNlCMBc343N+cBkaJDVNwGdGhVvcKzSx3Yep9Jh/11mMK6FQ+GA0Y+8k+EFLKKfYhGrHBo1J+JudWOO+WIWE/DaWkbg0kSbLr8hZITAU29NG/a5ZKgROvwzIOisJgFPUdSejYOPpLLNb4kH8sN5cW6v8Yvk/RnDCEV/PalCiI0324gZfbiLHxoH3giij2Laq/LwSsHVYPmeLhtC9B1CRYd4aZMsT7jphToogV3+X96t6lUndYlZ/vldjnvmgt3PZ28Yt3ZskT0wydnGiFD2TmsUv9AIDDdfjthC3IEcgiMFvCZBf5C/GGt6RGw23akDh7hv1xenHlQrViqTZVE8QWx5xuy0jPUDiRUuos7LehkG1WbuIURjF5e2LLpUg7q0bW3URPxqTtyA7X1r2kDHsR7CDC6OrVL2lmYuw1iOzWTiPsvfJWsIjQOrmI8HPydKyGG6H4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(31686004)(66476007)(66946007)(66556008)(110136005)(316002)(4326008)(86362001)(31696002)(82960400001)(36756003)(38100700002)(186003)(6512007)(478600001)(53546011)(2616005)(8676002)(26005)(4744005)(8936002)(5660300002)(2906002)(6486002)(6506007)(41300700001)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlpZC9tR08wZlJjTkxPQjFHdkNndmFXcEdLeTNLaUVVWnNZZTNSUnNGa2ZK?=
 =?utf-8?B?YkwyclhoYmNvSU9UNnFqQXZGR0gyUWdRQ3lpeVNPZ0UrdXUwcGJCcElnTWhv?=
 =?utf-8?B?d1NNaDRueWZSWC94RFlUZDJpYzc5T0x5ZjBaeTB6MFNSckVvMTd6emw3dk5v?=
 =?utf-8?B?VVVpZXUxVCttTEtvRWh6NTNoQ3RLbmQ3Z2ltWm5tOHhFdkVSbGxYck12Yk5i?=
 =?utf-8?B?ZlRwVTVUL0QzWUhrYjJobHJ3ZE5jUmFheHQzaitaMGFyRDh1TmJrWEd6anE5?=
 =?utf-8?B?bXhPQ01wT0RQa2tkYnJhMEM1cEhqcERRWkF4M1B5d1JZeHJ3RWlYcFdYWS9B?=
 =?utf-8?B?MXRKd3lsV050Vkp3KzlJZEM1eGYwV1N5SksrU0xjaURxNHdlOC8yMjRPZ0V2?=
 =?utf-8?B?NjFFR01seERvMHdlRjBZL1l3QUo0VnZXd1pEN3BGNkF6WGxBNk0yMmgzbDF2?=
 =?utf-8?B?RkIxUkxteGY5UEV6ejhDZUVIVUpKNlVueUJxWkxMaG9uTzh2c3p2b2hZS1hW?=
 =?utf-8?B?MmRvZzV4OHh0bGNZK2xkUWpKV0xic0RGYlcyd3pzODlIWVl0aTdKQ1NrWE5D?=
 =?utf-8?B?SU1kTHJUeVY2dE9mKzhrNWNBNVNncUg2cS9qNUZkWjVzeC9zZXFjKzRBVWVS?=
 =?utf-8?B?NUpIaTNxcEplQjVPU0duQjFmeUozallVcEEzekRhai9jbGcvdTh4aFlvTEh5?=
 =?utf-8?B?U3NKaHpubnNCRWpoM1dwVlFhYis1L2p0SjRMSWExTUdFTGZKMEpTV0NhVGxZ?=
 =?utf-8?B?VEJrQ3FOVnNzdG1zNllYN0I5dm1SRXpWeG5GMlBxWHZNQXBsYXV6S1NDT2R1?=
 =?utf-8?B?amJJa0l4ejkreUFROWdWcDFuUmNPWFFIMStjeUYzb1ZtYS9Ibk4ySGo0RklL?=
 =?utf-8?B?dEpPelNETUhEOWxRck0wYmxOaUhFUXhvZnppYzU1ck44L0lYbHI4RmVaWlZl?=
 =?utf-8?B?V3lieUQyT2hXdE9YMXNORmczYy9zUUdFK0dscklQamxmUVRnRG1oeHBTdmVw?=
 =?utf-8?B?VFk5eC9Va0VtVkcyZDdZQzVzaW53amdVQTVYcExkM3RVZlRLVC9ia3Npd2lD?=
 =?utf-8?B?ZHpldzUzOThyNnZxcGNOV29Xckk0N1grZFBUOUE0aVdOMDZHUmppVDV3RlhW?=
 =?utf-8?B?SDV5YnR0Y0VQa3FYbFB2MHc5K1JRR0dxOVpXTjZWdkEvcnN5TklYeEE3SjZz?=
 =?utf-8?B?aFdodkVoM092YlJVamhFaTJZL01VNWVTYUJtbGVXdzZBUGI2WXMvV0VjNCtX?=
 =?utf-8?B?MGp2QXlOZitnZ0krb2doRVlzS0ROaUhzSnJWWUZQY09aVmlNZy9QR29oUTlo?=
 =?utf-8?B?bGpXREVibHhZemJPTG9QdmE4MHFjSjZBYWl6bEJpUXFIR3RMOUE3QitKQUUv?=
 =?utf-8?B?WEU0dkFocStrOEF4aUZNMU5rSlA1VFlJUjhVS3pwZUt5dDFENzd6bTNSdlJI?=
 =?utf-8?B?ZUlnZDdtdlZaNXlMR0paaiswUkREN0xrY3FaRFhEQ0tEa1lWWEJkNWdWOGJB?=
 =?utf-8?B?akR3M1RmbHpYOWs2VUF2ZE40a1hudW96WmtCa2t6dUJYZ2pMMUlDVE16a0Ev?=
 =?utf-8?B?QkYwQ09kdWluek02RDU3OEY3ZEpaRktrZlVHZEtUalgvZnh5RnliN2s1MFNl?=
 =?utf-8?B?dTlOMUVlN2Zvc1VPVmxiSkpMUGFqOGFtNzZHNk4vcGErL3VBYTJVNGxvV0VJ?=
 =?utf-8?B?dHN2NlN1QmV0VDh6dW1zU0dKSTFKZFkxejVFdkg0WUJuSUc5TlM0ZEpaNkZJ?=
 =?utf-8?B?T0tubk9PR0dXWDNIdWxmbmZjVld6UHUxMUtXd2ZaRDQrQXJQMDNXZnRMVTZv?=
 =?utf-8?B?RGxxVkdNTUpWUlJncmhCZlBUaVZTZytnNDhoS3hRRStIMElZZERIbWp5ajNa?=
 =?utf-8?B?bXFuRGVzdHhMZlE5VGNVQkMxVUQ0cmpFaXN6Q1ZBUFV2YjhTL1pUMlpRcmhW?=
 =?utf-8?B?SVRSZVdFSWszK0liTy9ac1B3RVF5a09zSTFJS3pJaUF0Vk0xUmx3STJEUUVH?=
 =?utf-8?B?VXlhSGNBK0tpMUZ4REFxeUVWSmRDUVRDVktRcEMwZ2pmcjlXb3VlYi9aN0hl?=
 =?utf-8?B?bXduQTFPL1V5ZjlsZ2pxSXdOT1BBaHdwQWhiQm9OQUdDRmw1UmtwSlJmZnVO?=
 =?utf-8?B?YWFjT3p3ZG43dklpLzcxdDY0YmF4UEJQNStudEkvTG5DUjNicHZ4NWQ3d3Vj?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GX+pxMKe/TWejCbDMinNxnWwF7dHqlmc87iBpbKyxKnm0+HvT09YKLFcc+MGrVqItD6LIsWNIlxKjkkmr4fzSllvGj0nz/b0Etl99v3V0je0yg1c+9Ls5VjO22YiC/hYLlUq+Fxu6MY9u7YePJq/BoD0AAFwDsF94C49msCpXEBJBV0oNm91SUffEh+T5HXfr7T2Qr53qGC8qxEY9yxGuyyMUvbH0zmSuLNPoig7cTFWAqUL9ASzBxyXlkZOCv4RszlchSTQ6PHsHJsSs5350/mRP1mDB65BOdwH/gRaJQGmtaDCqAshcs4Y7KFoJB6nGBe7d9Ys2oqj/vsNeySmKwVcVIawk81T21aDzhx0uDxttmMGkkBVhpLtMXB6VNOaerH94c5pxFpA17L4axYq4HYMtoXMmUfmjt5mfvr5Qbi4fxCTvg2KZkJcKVH8J6ol7+iQXeTyVNFvjiacsEY8Hvbi9j+6CSTAckqes4rfcHTuZeDGJelkQWZ7+ffd1L9DX7GhFhCY3/VRaZJ7L8tM7jdMtJ0a+EGKnLQLXryDpDVLzNN4zwWv0WHi+O4M7jbRfb6cG2a5xbsRHbf86/cBzUDK2QUhDNRnLLK/qgJiX3C/5QGGbMhauIz7Wg5TmbLxv3ALAYUwMjzxzl0CuTyJ9MI1xMS2L8SQ9N3/anWh5GPqCfom+++DA1ADiJ9chl4RMQre9QMfudOj5tpODc0VrDSxo1jHgf84tBpAzDblDUwbKtCGbWE9fhCDIUL9Svwe7sVwNxABnY5PlNI63iIMHY/q1hicS+Grch9UG3FXsjEybG9QF9DbtK8GIN67adlpT1iwEr47XLgq9EnLZGlqZkjzF17HBMHf7t5hD6CI7cU=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afada7a8-6bce-41e8-7927-08db14b8853e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 09:38:14.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+X6/ovsdIkc0R/xDECIaK0jjpZwTqiTxsXt/kL/bOPouO9A9rwZ2zSB41EHgEcIBisfsXbmAkHnt38jD6WqApkYYPhMAJfQmWmxx/KPqB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7035
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 9:14 am, Borislav Petkov wrote:
> On Wed, Feb 22, 2023 at 09:33:19AM +0100, Borislav Petkov wrote:
>> It probably doesn't matter all too much but which kernel are you running
>> this on?
>>
>> Latest and greatest I hope...
> Also, what does
>
> $ grep microcode /proc/cpuinfo | uniq
>
> say?

This sounds suspiciously like an errata which was fixed with a ucode
update last year.

Check that you are up to date with ucode.  If you are, perhaps the fix
needs another look at...

~Andrew
