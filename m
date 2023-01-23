Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13084678C41
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjAWXxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAWXxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:53:36 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375322CFD8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674518014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h3/Cz2pYOet/oJbMhdEwSTF8lXSt5Md7bGdUYR3JXXM=;
  b=S3Es6rH07zWK7VqhL+OKJOEwAPHfNFHIsmD9t6JXYkJ8BZw+d4YD46IS
   lo+MGjpXxNo87hW5EDkwk/CVnzplTABXPUy9YgkNpKPSl37GJHrCHCjDM
   9B6zdwo2gx6pPB4JzcYMWOE9S+FgjHXISZp6psSb1EoUvHm5C2x8Rhcji
   Y=;
X-IronPort-RemoteIP: 104.47.56.171
X-IronPort-MID: 96347988
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:eoW+oa8WAgzdOf2EbfAJDrUDyn6TJUtcMsCJ2f8bNWPcYEJGY0x3m
 GEYDGmBOfuJZWf8etonaN7l80MCsZPRx4JnHAZtrHw8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKucYHsZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kIw1BjOkGlA5AdmPKoQ5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklvz
 f42Dm5OVCm4juyt//X4acZiptwseZyD0IM34hmMzBn/JNN/GNXoZPyP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWNilUuidABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTCdxJSOLppq4CbFu79lYSKAUwekmAnaeijm2zRdFOJ
 kEG0397xUQ13AnxJjXnZDWxpXuNpBAVWshRScU17hySx6fepQGDCQAsTiZIQM43qMgsAzct0
 zehk9r3CHpvubuORHS197GIoDf0Mi8QRUcObDEJCwsM5cLupqk3jxTSXpBiFrK4ipv+HjSY6
 yCLqnN4g7Q7jMgX2qH99lfC6xqwqZzZZgo04BjLRGWj7xM/aIPNT4mp71fcxexNIIaQUh+Ku
 31ss8KGxOkKDJyLxGqBTY0lBLy16uyXGDzaj0RmE5Qo+3Kq4XHLVZAAvhl9KV1vP8JCfiXmC
 GfXuAVM9NpQMWGsYKtffY28EYIpwLLmGNCjUerbBueiebB0fQ6DuSppPEiZ2jm0lFB2yP5mf
 5CGbcyrEHAWT7x9yya7TPsc1rltwT0iwWTURtbwyBHPPaeiWUN5gIwtaDOmBt3VJovdyOkJ2
 76z7/e39ig=
IronPort-HdrOrdr: A9a23:t6nwLqjN9g91MsmbnnTIQ8n1ZnBQXtsji2hC6mlwRA09TyX4ra
 yTdZEgvnXJYVkqNU3I5urwXZVoLUmzyXcW2/hyAV7SZniEhILAFugL0WKI+Vzd8kPFltK13J
 0QF5RWAsHrEF5/gd3bzWCDfOod/A==
X-IronPort-AV: E=Sophos;i="5.97,240,1669093200"; 
   d="scan'208";a="96347988"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 18:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPF0Pj6id24APNdK19Dza3jt3KZFuWcg1dByt8xxjIBv3QjrjJq5F4xXnr/eBOy4hXAuQn19q07U1vMhs+c9U6mnu2206vE7m4RnMdmwpeYwHXncy19eLZgIT0cfkKCXQpJDoIDYwOKmPILtFjLlsIvPOlQIpdB3Yu2cnjPU4Rhq/S4iWOufjsLGrygeSmtAcbmF7JoocSl6BC88h6M2e6wbFLWJxe4NmiAw67Q49ROOYlrbTBd2Zj6L/4WjLqutuoNaKzK9tleW10J4rNyggOaMqMvQEQws6ERjfSiWI69q22ydomHwONZsT9l0ZYRxInYrS83SxuE72N3QwXxIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3/Cz2pYOet/oJbMhdEwSTF8lXSt5Md7bGdUYR3JXXM=;
 b=AOGsB3xw3vbhZtgIGnUJnlURoaL6fTzal035xt5yd0U+VSbwSLDtbSYNbdkH7ltaNA8Db11qtXxq51yBaHnRtpM/I3cW7GPf6sMmjrP/PAsvUxXuidJ64bQeKPn1nlWRdzaoC5gQHKriOBNIQsJ0UZdvrVR3tVDl62A0tiU0xmi/5UExselRnMbXRRiyLBMF8/WNVSILGN+aVOm0Y0g5W+u00hbb5qXFfrry3CtrAechcvRI5lY6AmvnSvw5UVsQTVzuXhSNabUjdcji4WIQGUP5N90p+3QCe4s7ivxOUjVdx0CF8dENxUo4hO7rddw2sakiuzCvbZmdSHai5o1SvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/Cz2pYOet/oJbMhdEwSTF8lXSt5Md7bGdUYR3JXXM=;
 b=Ds+utYx+NfmXx4wURVIhqbmBFhQlDEtAnRoaaVHJ06Gaff/CCrXQNe1NYWuHM62bIZocNzgYgyMgYWnd8cWXLuleDpaqvWqqHCEdkvdw+os/GG4zfGgOBB97GD4/ZTrB2Ms/LG1A2E1oISTyi9DD443KsMeBD0Y6FQMYFD25UXE=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BL1PR03MB6149.namprd03.prod.outlook.com (2603:10b6:208:30b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:53:31 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:53:30 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AQHZLwlnyVP56rEBrUalKcRbIW7nK66srbYA
Date:   Mon, 23 Jan 2023 23:53:30 +0000
Message-ID: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
In-Reply-To: <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|BL1PR03MB6149:EE_
x-ms-office365-filtering-correlation-id: 19565c3e-8ce3-462d-b199-08dafd9d07c1
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Q8ORIrUpYYoxKSxVvNLOMpLlOs2IDkyvReWUa/zq6WkaVlCEcd6DE05cOk/2squPPo1X+rTEKaEt2uYHrqfv0ll/wG5oD9rqiRS09kW52+i0z5idci6u4ztN6SanB5ou2riyIfIQCW+mGgdWi2RzGXAtEtJQX+/W3uWSRZNK8Vc30teaFC/c/kOegGfOVOtg+IdyVNsZd4ZhaQE3ue4VUNwGV0RoykaLsoxPonahAYeved9NDvWo8lQLwbU7IM12b4kKY4YiMN6Bq3xTkeP7aBiMe0Rk2dZzfK+eaxKVlznqpE7Vyd0N0k79rclOP+wP5gPs8K4lSZwqFdOf7R4IgroyZFxkSQ5ookHJdWzA2IKBbYVJojlgqISZe68F3zkZs4AlVRmoq4NdTpfcd67SdXQnX77KBaSbyxrIaawdtlMDGwQO01BBxUvK086R8+tjD6RnPzDJfVWRkrTBod8i57yx2sy0t5zGJ5+j479DQSeNkLYbml5AQXL62mqOSro7UoRO8kqKmYbKQ0TQMlSmKpWEZnEAKxnIhumtAdVBMv8Myu7qf62j1mjxVoTuFnvZK2nfdWNmZwR/c0cJyYqdrqP1fVBYjwttIp0wCS2Dg6+aNpbIqcR3grrKknFqnUAVwKTPNCXzSC78KRaGn9qGG1rYFj+dGrMfWjSkrifyjjZcVv3XMXQfQbl6GCYfV5rQqYIBNx45a8wOiUhOP4UbCxnPET/O0FpiAdYI4twbDILzbyoekxydw9fcoAoD4xUNGbNugEiIUuaBPh0YlFLig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(122000001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(316002)(110136005)(478600001)(38070700005)(54906003)(66946007)(64756008)(8676002)(66556008)(76116006)(66446008)(66476007)(4326008)(6486002)(91956017)(2616005)(71200400001)(31686004)(2906002)(6506007)(53546011)(8936002)(107886003)(186003)(41300700001)(26005)(83380400001)(7416002)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9abFFMYVpTaHFDM29WMkVJMjQvYTcrS3RnN2w5Tk9lbzJqbVRnSGhzdXBH?=
 =?utf-8?B?NkNqR0dTcWw2KzNUMlhOclRaY3hrekk3bjBGa0JXU3ZmNDR3NldqcS9XM0Ev?=
 =?utf-8?B?T3FDWFRVZGhHcUF0Y3NUczZKSE5yajIvczBUNUdHaWFYdUNFYnpMWWcrNXJ5?=
 =?utf-8?B?bnBuSGd1aEpLS1RUSXB4Ym1Hc2ZKc2c2MDU3T0hyYXRHOWRRNlVPWkFJaWJV?=
 =?utf-8?B?MmM2RDRiODNxazlndCtieGJ6RkVYUStrZWI4TEtMOXpHd3N4WitRbElUNnQ2?=
 =?utf-8?B?SzZmZENTRlRSRlFJajM5eVh5blFhdDhRYU85bFlyb0xYQzZ6RlduZXU3TDJ2?=
 =?utf-8?B?R1F0dzNxdjk3SFh0aDB5ZXl1RXFMMXhxOHF0K0c2cFloVURFczg5MjVDZ0NZ?=
 =?utf-8?B?VkJ2ZjNHSEUzNXFRLytvR1gwb3hUcU5QSzdLYUpFWVdLUUp2d1MxL3B6R1Fi?=
 =?utf-8?B?Zzd1S2M0UFdoc045YUVOTys2cWg0a2hyRnRlTlVaYlJyS1QvRXk5cEhPNjdK?=
 =?utf-8?B?bm5ZdkJRVXBmVnYvdEd0R2hRcWJudEFNWVp3Mk5lMTZTUWVMeUJrcGRYTDZz?=
 =?utf-8?B?WDV1UDh0OUNPM09VY2V5b0g3cnRpNzJGRWhwa05iUE1LNVN4VGdKMEp1QXZj?=
 =?utf-8?B?S2dGVElVYXE2czhCSU81RjJBZW4zSmM4MFdERzJGL3dlbGNxZ1V4WkpOTFpF?=
 =?utf-8?B?R1lKSnh6U2lHVnA5cGFud2hwMkYyUlNrNm5BaXNjM1BRYUpKWFh0dHhPL2li?=
 =?utf-8?B?VnFpMWRWS3M3dFVXcGk5U01vYXh3bXhYdkRPdEpGdzhuZDJIMmNDVFdZSjhu?=
 =?utf-8?B?U2JRVjlJS2lKM0JnbjZCZlNoLzEvbm94SU5mYWdvMG9DTHZkQjNpeWVYTVVr?=
 =?utf-8?B?RXlyUlJPY3YzV0I5QU1yUXIzcUZmMWdTN1E4T2Y2bDFLMllDUWxqMG1vZEpC?=
 =?utf-8?B?R244Z08yM1dHMTdtZ2prTzNmU2x0ZWFBMFRpUFpBL0l3YlhOSnNqWDZ4Wkkw?=
 =?utf-8?B?N3B5bTRrTnlRSkwvNXFwUmJWdUxtSGNLMkRtd1JNOXg4RTB0RmJWa200b2VH?=
 =?utf-8?B?Mk9mYzdEVWY4eWRlL3RjejRYZ29MZmtyWWJRVjEwK2ZLSUdEOHltWjNxY2ZF?=
 =?utf-8?B?MERZa1BGSUJIanBUQ1ZhWCtrYjFnbXBKUk1tekxsT3AwSDMvRWkxT2p5TkhS?=
 =?utf-8?B?OU82L01VL1NaeGQxU3ljMU1qQkI1NTViS3RWUTdBcUNxSThpNnM0dVRoNElM?=
 =?utf-8?B?WEhlekVIbXN2Y2REaVNhWnQ5RVNtWE9ER1VXcUVPY0xEa1lJWDI5ZXpNei85?=
 =?utf-8?B?ZWVIbjNlbFBORkNRMFRXbCsvY2JXeENOaWdCcDlob1RsNzNpQ0xraW9PN1hL?=
 =?utf-8?B?QlRST3ZNZlRURkd4cWJFWkEvRmJjYlk5bjhBbGNObjBCbkhMcGhXTStpN0xn?=
 =?utf-8?B?RzdsaDZpTndRNEJ1U3pOdFNrSEtqenNLWVVPVTN6empNOE1CRkpySUhVNTk1?=
 =?utf-8?B?S3F2S2NFWjM2RG53Y1ZKSnhWbXFleEZUcjZuRlAwbXN0L3JPSW04VmxaaitY?=
 =?utf-8?B?WUZvTWNZSXNMdW1OZFFHM3dRdXhJWStXOVRTZ1VpZXR3UkNsV3MyNElEeUxn?=
 =?utf-8?B?WlJoR1Bwcm02R1g3Y1N2WGprbFArREsyM3Q0VlNSQkhrOW1YbTl3NDQ4RWlr?=
 =?utf-8?B?Yzlncm1HMkIxTkR5bldGZER0L2tUaWNMMGovNGp4c2lvZnVYcDdva2hRWmk2?=
 =?utf-8?B?MWtrYVVPaU9pVGtGai9KQWVRUXRmenRtaERIQ05kd0o2R0NXcktVMWhTTlVS?=
 =?utf-8?B?eG5GNmZvVDZWQkdQeDl1Nlg3bmdkYmxuaXhmYTRtZ0FUS3VvdWlBSzZUbUd5?=
 =?utf-8?B?NkJ6UisySDROL2grYlNqR2pEd0E4bHU0L1NjUGNhL0ZoU3dxN2lxdDlYWnU0?=
 =?utf-8?B?ZXRCdE5IbFBRZG5VT2RvN09QbmpHRlZQbGR4U2NUY0JxZHppdzdXYnk4WE1Z?=
 =?utf-8?B?L0hGSlg4Z2ZqemJ6Rk8zdzM1cXZ2OFZuRG1KbklPemVOVGtEekF2Z0VZdW5s?=
 =?utf-8?B?ekRFVWdFbTRqVVhlRjgxYVRKYjlMNSsvYXY0R2doeTNxY3l6SjJCNmk3aFU2?=
 =?utf-8?Q?LDBnNy151qpfdFzZiYFNtIIiL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2530BD47A1F902429325D997B2D4F10D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y0RkWkpvdzMvRU00TldnbEhQWGRJS2FPQ1NFNVA0YXZpNUdTS3BLWmg0enhY?=
 =?utf-8?B?QjJYZVJzUE1oeHhhaUxPaWZXOThCRUdyWHpKT04zTHlEMFFKMnl2QjBiZ2JS?=
 =?utf-8?B?alhRdmJFWXZlZloxQXk4dXZPejlQaUhNV1YrTEh6Q2FxdW15d2J1L2tiOXRh?=
 =?utf-8?B?V21SS1VPZk5hVFljL0JaTEp4Skwvb1lSTFZSb0cvdTVxb1RjM2gvZDZ5UWtv?=
 =?utf-8?B?UkxMeUl0ZEJVZVhIbklSNU1CUHIyRzJFQU5mdGpuVDdac2J2cTJKRGtQSXVX?=
 =?utf-8?B?NURjZ2doYXlJbUhsNFcvcUlKczBPVzZ2WnJCc3EzVk9JM1UrdmlBUGk4TGhL?=
 =?utf-8?B?V04vNXU3dklGR1FvZ2NKZW10bE1hV0QydFMyTkNHTVgyY0xwcjdsL05kTk8w?=
 =?utf-8?B?eWlYYWc2MzhGSXppNTRpZW1FUWtlMjUwMVEwUGYzdEM2dWltelpTZGhOM2Fv?=
 =?utf-8?B?M09XM1FsYjQrZXprVmJHODRnQWpnTGhpTkZ5KzlHTk5PQldUeUIrUFl5VHQy?=
 =?utf-8?B?NGI0Y3NpWEVWYmlLSUFKTzdMVE1qcS80N09DNm54S2xScXN0SHRiZkx0R291?=
 =?utf-8?B?MnlYSXVaYjBwVmFmazF4TEs4MUdjVmZWTFRVNzNSb2U0UjQrVlRVTUlXTGhl?=
 =?utf-8?B?QlgxVlpvK0hXQzBWNzBKcSs5VUUrYnNGQmUreWZKMjJTZElpVXloNEhaS2Na?=
 =?utf-8?B?bEtuNmRwa2FRYXlLQVdhTVNEQzVaT2YydzFGeFNDeFRxa1JXUTdsMnh5amg1?=
 =?utf-8?B?Nmw4RGx6ei9IZ2tQNlZTUUtxWHZyVDZmdkFheXNaNHRuVkk0Ui9jYVFrN0c0?=
 =?utf-8?B?akFYckVxS3ZwbHl1c1hXMysvREVlTW1EMWNsUVJUOTRJN01IN1dkNTJCK0l2?=
 =?utf-8?B?RHJ4WXI2UGZ5Vk9Ydjd1aUhOTUtsZTVuaElJdW10UTdGRm5aamZLL29OVjFZ?=
 =?utf-8?B?T3ZjMW5XNkNxWUlIclZQVktTRkN5dHlnOVU2UElYVzZNSW1Oeno3aTNZTzMz?=
 =?utf-8?B?ZkNZU0h6Mnk0dXRIV0grNTZLb3kwbW55eTB3Um1vTE9pRkxpaEw3ZG9ONjVP?=
 =?utf-8?B?WVdMM1BaR1F5QTlSTDdrZHMyOS90M0liVWdjVm5BTit2REp6bG5scWg4SWZ6?=
 =?utf-8?B?RzE4YUNJYUFoS2RQZWw1aWRuWVh4RG9JMGh5b2l6NElwcmpOUWxkcXVKRUE0?=
 =?utf-8?B?ZGZTcHJuTlg2Q1NXNGJPMExyeVV1bWQvaE9vUTJodEhjWUpjVGMrcDFKWjFR?=
 =?utf-8?B?N3VqVDU4MWR5U0JLMmdORmxMTjM1eUtWUDFhWFU2b3RaREZ6MWZ2eEI5YmNt?=
 =?utf-8?B?bHo1U2JxQ1VYUks4UTVobDlrUmM0SHEza0c3VWxUVVdTN0hMT1UvMTJvWVZj?=
 =?utf-8?Q?bYB8kQVfl0QDjSlJwu0qNvmBmgYxntuw=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19565c3e-8ce3-462d-b199-08dafd9d07c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:53:30.8017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJW9BiTRFbq9KxIOW8bkc0ST1BuqDNeLkhe6ZIr8E8P1AVUJ+Rl1WF7wGpPUrO6RkXYDfR6MkNuAaoS9DVk0I4csjP6JD+/+j4bkprdMtb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6149
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDEvMjAyMyA5OjAyIGFtLCBBbW1hciBGYWl6aSB3cm90ZToNCj4gT24gMS8yMy8yMyA2
OjQ1IEFNLCBILiBQZXRlciBBbnZpbiB3cm90ZToNCj4+IHN0YXRpYyBlbnVtIHJlZ3Nfb2sgY2hl
Y2tfcmVnc19zeXNjYWxsKGludCBzeXNjYWxsLA0KPj4gwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcg
YXJnMSwgdW5zaWduZWQgbG9uZyBhcmcyKQ0KPj4gew0KPj4NCj4+IMKgwqDCoMKgwqByZWdpc3Rl
ciB1bnNpZ25lZCBsb25nIHIxMSBhc20oIiVyMTEiKTsNCj4+IMKgwqDCoMKgwqB1bnNpZ25lZCBs
b25nIHJjeCwgcmJ4LCB0bXA7DQo+DQo+IHRtcCBpcyB1bnVzZWQuDQo+DQo+PiDCoMKgwqDCoMKg
cjExID0gcjExX3NlbnRpbmVsOw0KPj4gwqDCoMKgwqDCoHJjeCA9IHJjeF9zZW50aW5lbDsNCj4+
DQo+PiDCoMKgwqDCoMKgYXNtIHZvbGF0aWxlKCJwdXNoICUzOyBwb3BmOyAiDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAibGVhIDFmKCUlcmlwKSwlMjsgIg0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgInN5c2NhbGw7ICINCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICIxOiINCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogIityIiAocjExKSwgIitjIiAo
cmN4KSwgIj1iIiAocmJ4KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAiZyIgKHJm
bGFnc19zZW50aW5lbCksDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImEiIChz
eXNjYWxsKSwgIkQiIChhcmcxKSwgIlMiIChhcmcyKSk7DQo+DQo+IEJUVywgSSBqdXN0IHJlYWxp
emVkIHRoaXMgInB1c2giIGlzIHVuc2FmZSBmb3IgdXNlcnNwYWNlIGNvZGUgaWYgdGhlDQo+IGNv
bXBpbGVyIGRlY2lkZXMgdG8gaW5saW5lIHRoaXMgaW5zaWRlIGEgbGVhZiBmdW5jdGlvbiB0aGF0
IHVzZXMgdGhlDQo+IHJlZHpvbmUuDQo+DQo+IFJlYXNvbjogQmVjYXVzZSB0aGlzICJwdXNoOyIg
Y2xvYmJlcnMgcmVkem9uZS4NCj4NCj4gSXQgZG9lc24ndCBhbHdheXMgaGFwcGVuLCBidXQgd2hl
biB0aGF0IGhhcHBlbnMgaXQgY2FuIGJlIGNvbmZ1c2luZyB0bw0KPiBkZWJ1Zy4NCj4NCj4gQSBz
aW1wbGUgd29ya2Fyb3VuZCBpczoganVzdCBjb21waWxlIGl0IHdpdGggIi1tbm8tcmVkLXpvbmUi
IGZsYWcuDQoNCllvdSBjYW4ndCBjb21waWxlIHVzZXJzcGFjZSBsaWtlIHRoYXQsIHVubGVzcyB5
b3UgcmVjb21waWxlIGFuZA0Kc3RhdGljYWxseSBsaW5rIGV2ZXJ5dGhpbmcgaW5jbHVkaW5nIGxp
YmMuDQoNClRoZSBwcm9wZXIgd2F5IHRvIGZpeCB0aGlzIGlzIHRvIGFkZCBhICIrciIgY29uc3Ry
YWludCBvbiB0aGUgc3RhY2sNCnBvaW50ZXIsIGF0IHdoaWNoIHBvaW50IHRoZSBjb21waWxlciB3
aWxsIGFycmFuZ2UgZm9yIG5vdGhpbmcgaW4gdGhlDQpyZWR6b25lIHRvIGJlIGxpdmUgYXJvdW5k
IHRoZSBhc20gYmxvY2suDQoNCn5BbmRyZXcNCg==
