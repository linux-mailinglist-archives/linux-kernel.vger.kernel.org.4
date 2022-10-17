Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654C601C43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJQWYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJQWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:24:02 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE012AE3;
        Mon, 17 Oct 2022 15:24:02 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HIdild018817;
        Mon, 17 Oct 2022 15:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=TYxDO13vlPBvUvUVRGUSr7KO6kZBYbSOH70tUgzry9o=;
 b=jj9kBdhs4hEF+ed2hs6IcsjzbDia2KFyXKa9IEtIA83Yr7x8HdYsd/9QyKcv2gWDs10N
 aV8N+47Y+6pJfo5BRVJVEVyfb2cfBNLbQ/5cDYjypLZmTr/xbVxw5GGkcGYwvPqXlntO
 Fyw6lLsp46pxWteZuXqEdh0LSJJffqdJjzd9HRoIXcGSxXLjwdn7Khw3sHmrXoPDCfGO
 94xfubcf0SHShVjWS21t8Br2SyHXlRfy/7OOHRSvjRkANFVeaagJ+TllDQWKLOXkWp3q
 kP5vFUdEih/cyVyBWwmkt6z5v6wVo9o18vOPnogjtURHR3QNjE9E/AVX5AG/JneX7LwT JQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3k7uvn4km8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 15:22:53 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F70DC00FA;
        Mon, 17 Oct 2022 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1666045373; bh=TYxDO13vlPBvUvUVRGUSr7KO6kZBYbSOH70tUgzry9o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T1b56IqVhvTNcwx5LKcIiA7bwuS+1wrxe0zDkNpHnJU5l2Ko7+K3Xq8TLM4bTihsF
         9V1VoYc8XNxwN0pATBy2G84wHHUnuuBVK+/bzLDXGQG29EKuX63tEUCUMPJO1E/62N
         37OvU3z0NPyPq3ieKvWHKOcvWQqjn6+0nQzjCn8umrwgUq8GiJNAceTl71yxSmvWEd
         GoFhiAemeY7s3zW4fj32CJCYE0ZQaJOUnCWCGYl1FdaNRdREtt7mitdy1cH105RrmD
         pugFA8cUCZlwnLVebw84EVa+njOlPkQALrte8AQGvrZ2MG3wO75MykXyzz7Gc/gV0W
         ZkJASn7R2KVLg==
Received: from o365relay-in.synopsys.com (us03-o365relay7.synopsys.com [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5474DA008D;
        Mon, 17 Oct 2022 22:22:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 28840A0092;
        Mon, 17 Oct 2022 22:22:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XbUa+UTk";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGlk5ywCep+O0OOgyNyIL0mCcG1AQjfGMA+GOrBjlO6aK1C7Y1f3XGLtfIttHycAWklyV/TSxHkhkwNHcraLbSS+h73AI0x2izU0hIVV6ayU9by/uaV2SpSQXnCYl+2R9pYxzfGAW9kSW977mZajr2Vklx34zmr8dmkxyetliVRzbg8sePfvDmKqjPET6jedzPuz50U0CgO3BLVDypa0il0IvxJ4GAYxi89F/+Zh8MZtfJiQTWf3tYukO/9zwfztIYgRBQgDrKBw8rAJlG4OLCFXk+LMOii5xL2r2y3aM059jLPZ/pA5ekF+a9OUlboJb6/35pT4LZWmMkjPF+L0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYxDO13vlPBvUvUVRGUSr7KO6kZBYbSOH70tUgzry9o=;
 b=ST0fCNbHL9syejajlPL/8XaBU1cvnT924I8aPbauxNof9zMYaOng71ycm2gmfygzXfJh9cKUYH3+l62feIv6Oql7ccww+BMhiCrZo7BUTi/AmTr//NGd09nDzk8oZNsPZkrIc1f6bdOazgllNP2aUbk6PRe3G1IfDT233RLuMPg5mEYRcZhs1fLHwXAxTOVDONhwLUMoYHc0XNEIU8Or/4wn0C5Q8ltec2mmKw6GPMpuz4ABV7urdCLSlIJSjXJPc9Aoe5ZiuMTuc8v1x3OJXNPbOQZ+ZuGjFp0miTpBl45I1pOWpasYvK2c8GizZcgiPu3wiTDqVcgmO/BUdMOSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYxDO13vlPBvUvUVRGUSr7KO6kZBYbSOH70tUgzry9o=;
 b=XbUa+UTkn787ycVUEm1yH2ILW0ygjv/aJsUuRkp+wEop8aQz8yQYqM0G837zY5fI/GsOBWyj5Y/foeHMGbAZE/BHafZDuXWLwI6PoW+LjAUG/51lHdjW4uVWtRlMuJ8R4om90GcvijM/XRsW/1715qbD08qbFfwynP96q/IQ8WY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 17 Oct
 2022 22:22:46 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629%7]) with mapi id 15.20.5676.031; Mon, 17 Oct 2022
 22:22:46 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
Thread-Topic: [PATCH v2 0/2] usb: dwc3: revert OTG changes for Intel
 Merrifield
Thread-Index: AQHY0omwZzKMVHxgkkSJlfArPMdC2K4TOhqAgAAOvoA=
Date:   Mon, 17 Oct 2022 22:22:46 +0000
Message-ID: <20221017222237.qaxskzyf6dj633oj@synopsys.com>
References: <20220927155332.10762-1-andriy.shevchenko@linux.intel.com>
 <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB5711:EE_
x-ms-office365-filtering-correlation-id: 1833091f-cc73-45fe-efac-08dab08e1e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7LBliH2HpJqyM5FiWv0G81f3T0IdAoCSFwc2SzJU9AOc0O5nMMyv7F8hOpL+o7i5gHa6LS1y6CJ8IcoZWJwOStzg7E5n4/MF/pO9AsNfZIcrbQ3Jr8mwmtFmfAtTggLjt1XMdALSVZ99u+o4d0r8TSbOQzwsx/u2xPYNm3/ORTr5qmprUy2kBUMxtRN/26vt6PY9Gttv3X2DtyykPZM3vSC4TE0E6gV/cRs3HDpEfa5bZbDEN7l0Wef1akpcikkKSKV1+ZbhlzlfJ8fhNgMKNAGfwxW4KrKM+CfZZao6B7Um7GsIz3T1Oay4K9wFiK/E9DWox2NAMtPXrBiOrRxRZbemuaiUMWfTTIFmYElSVipLTfO+NCOjmJG720TifPTGMjGxLNY2hwTl7hWM1KIDpDUT+qzuF+pJwwjrUnpHmLXER6XQCcK7m4YjdAZLO1X8jRoT/nCFaruSEqTYx/qv6ib5RGBwpcSO9EHZaNtSTtWkxqW23UFtjNoid7UR5q5eDp8tYQ+uR21mC0ZwYxmOfDD8+M+txYQ0bh8QEyAMYFTmYjRXOJ6B5g/bUmdMtzsEseK4nuvPUY24cGMs0LqxKSCKneGiNSx9mUO5bznF70+NZOmd4sdcOBeKp3rV7eCObO8hZva2xFzZMYmjvgABO3zCZEqd4ysmmYLFKRiGnnLc745zg4buXPZsqs02cucUqzKGyCfq3l+Jy8hE6gtdXPLwwiSJus4Ix5trzqe1evXdcIK9rl+Bpz1yZ0fvL814vdPCes18WWkM3zMZgL6Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(6506007)(36756003)(2906002)(8936002)(5660300002)(86362001)(53546011)(26005)(186003)(6512007)(41300700001)(38070700005)(1076003)(2616005)(478600001)(4326008)(8676002)(64756008)(66446008)(6486002)(66946007)(71200400001)(76116006)(66476007)(66556008)(38100700002)(6916009)(54906003)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2lkUDV0blNQVHBOcTFnckxBYWhoYXN1bVJLOUNucUJJSk5icXdPa3RtY2Nk?=
 =?utf-8?B?eFhTcXJoWVg3SmFxaWE3QjRON3NzbGxOaWtqRmJ2bnZoMDkrZ3lqL2JhUTNS?=
 =?utf-8?B?VmJkSEY1YmpnQ3FUaXM2TFEzN3JRMnJhWEhsdVdVMFVzNWFIeVJzMkVtREdY?=
 =?utf-8?B?MTNTRk5JdHZqTTdFbUE0L1dtK3laNy9YaHBrMGF5RzZyZmtEVzFTZ1VjaWtk?=
 =?utf-8?B?cWZPYW9od2xDNHpjcHZvRzVkYXpwdGUzSE9tOFFTMzF0UUEzam1BWXVCaEtQ?=
 =?utf-8?B?RzZLbE84UjA0RHJ2dy9WNTV1blNnTWYxbGpzSWhSU3pxNEdpdUo3bStDRiti?=
 =?utf-8?B?RmtoL3dUUW9LTDhrTmRqSno0eVpPZHZrcFFmMm00SW5SbWovQXNQeGhaV0hD?=
 =?utf-8?B?VzNOeHpBVy9wd3pXVXUzQ1pBN0lpdGQ1TTZRdEV3UElhS1ZjSEZIUFExL1RF?=
 =?utf-8?B?VUdFUjhPSWNlTm5aaDl4dTFtS20xczFtcksxak9mOWNvYllraXpaYzhjRFp0?=
 =?utf-8?B?QWF2NHM0MkVhWmFzbGtkTnhSR0JYWTd4MzBYVk1BU2JnYnlJRTB0STN3NlM0?=
 =?utf-8?B?N1RoSytYbHpFT3d4MCtEdFhsZU9pbnpYR0thdFkxbU9najMwQ0VWMk9zdnhC?=
 =?utf-8?B?K25uRkVhZXZKSEJNM2pjNmdMeEJiVFhKd3phTmhJT2NYbEtUenVhOEZ3MTJ2?=
 =?utf-8?B?T0R0TXhDVTRENmI4d0hRTHZ5OFRlVlplWDdWZFFhQUVDQlE2ekEyenZUK0Ra?=
 =?utf-8?B?MFZZakpnVHkwSGo4d2ZEN2xTK1JKdjZ2NmczVW9wNGdkMk5KMnVzMlA1dWhH?=
 =?utf-8?B?WHp1bms2dlZOV2FOM1NxdXczMWhaR1p1SkR4UFVCOWllU3ZUeDcrR0MwQkN4?=
 =?utf-8?B?M1U4YzhNbjh1dFJyWDQxMVV1and0L1YzVzhWUmN0Y20xSzlKK2pnQ0VQWjVQ?=
 =?utf-8?B?cHloMVBYZ2lFSUR3d2FoQ1ZQeUpodGcrNmNSOHlvZlhXdVJSMEJFakdUOE1U?=
 =?utf-8?B?d01NamdnczJoQTlkZGVYY2JZSXQrZFRkeWhueEUwZDlHQVNkN29ZRnBXbVRK?=
 =?utf-8?B?RCt1K0ZGQ2ZWYVJMTFBFMXRMb1BwOXYwbjVUeno2RmlFVWNRZzRZRnBhU3Vs?=
 =?utf-8?B?WFgvbFZRNkcrd0h1V1ZsdE9Sek1VRzFxaFp4dVkvSlhkMnNwMEVMOGdOVHRj?=
 =?utf-8?B?cWZJWGUxeFZ6Mml0TDlXRkZVRTcrV3RvOHVFNWVLNFZFZkFkc284d2o0VE52?=
 =?utf-8?B?UG96NWJIM1JXZTVpQ3laVW5rU0VQdXRaamJlZFpVeWVLdG5EejROZFZUMHlp?=
 =?utf-8?B?QWR1aFFkTmszRGlpTU1mbEsrUE9xNGRjM0k2N3pSbmhCaHcvRUkvS040NTZ6?=
 =?utf-8?B?VHd2SGhyTytwYWp4cnc0YzBobEpLMUFLVGtZR01TVFNBQW5LR1FXVU0wN3Rk?=
 =?utf-8?B?L3JYZnZFNDFHcVpyTHNzcmNwNG5nYkd1T2NVQXVrcWl2NmVsc0ptOTZEd2pO?=
 =?utf-8?B?NU9BL081ZkJXQkEwdDZaTlM2NEtxZjJMZEpDMkJ6SUczQWx5RUlHTFlQcWxT?=
 =?utf-8?B?bi9XT3hxMHBQc1ZNK3NPZUFnc0Nqc3d4bnNycWJsYkllc1d0SDIvQ2szZm5B?=
 =?utf-8?B?ek5GQ2dQYTZNc1VacHAwQ08xN0k2SFJaY3p6UFBvSy9qaDhScitJTHdSZ3Np?=
 =?utf-8?B?bnl4TmYzd2NpUWpEMkM0ek1HbWppOFpwQ2Z2SmJsUExCbnJXSE82VVJPVzBO?=
 =?utf-8?B?TlMxWVN5V1RXTFNQTlFpVXMwMVhJblNYNi96SU43c0NlMGJUZEc1YUZwdmYz?=
 =?utf-8?B?aS9DTkxMSDJaZWMydWVoN0IzRkFoMm5SRmhyenBqd0NTRlZqNFZwTzlIZDJw?=
 =?utf-8?B?YjdxcXBGSmdpbXdMSFN0TW8rWDcrdXVPbWpwUHFEVjJKSTZ5QjZmZlRGV1ZP?=
 =?utf-8?B?STFHZzY2SlIvVnErdm9PeTNjWUhhRGxYbGo2eUs4bTNtR1dUK01zOHd2RVZ4?=
 =?utf-8?B?TCtvdWl3Z1lYUjhxT1M5V3NyYkNJRDNYR3dGNW5pUnhkMVBHcy9TRXVseHJZ?=
 =?utf-8?B?eTVwT1oraFBmbHYwL2x1bFhBczY3UjRzUTNYcHBiTC9WV2xiVlRUR05xZE5S?=
 =?utf-8?Q?ZS98CRm8E6VbSboelKnvIjvbq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EEEAF89604FFB41A811492F8978D006@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833091f-cc73-45fe-efac-08dab08e1e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 22:22:46.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3FsnEi+F42ShIv0KZGvmzGJyUiaCXGN293klHsWvJgm4WQb3QJHYf8H5XVEVOJFBFXkcT57XXIKwNWGSqTbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
X-Proofpoint-ORIG-GUID: 5F8OO7xxcQUL8EYGD-Jj64se3TVk_KZA
X-Proofpoint-GUID: 5F8OO7xxcQUL8EYGD-Jj64se3TVk_KZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxscore=0 mlxlogscore=850 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210170128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTcsIDIwMjIsIEFuZHJleSBTbWlybm92IHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAyNywgMjAyMiBhdCA4OjUzIEFNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFzIGFncmVlZCB3aXRoIHRoZSBh
dXRob3IsIHRoZSB2NS4xOSBjaGFuZ2UgaXMgZ29pbmcgdG8gYmUgcmV2ZXJ0ZWQgYnkNCj4gPiB0
aGlzIHNlcmllcywgc28gd2Ugd2lsbCBjb2xsYWJvcmF0ZSBvbiBhIG5ldyBvbmUgaW4gdGhlIGZ1
dHVyZSB0aGF0DQo+ID4gYnJpbmdzIG5vIHJlZ3Jlc3Npb25zLg0KPiA+DQo+ID4gQ2hhbmdlbG9n
IHYyOg0KPiA+IC0gYWRkZWQgQ2M6IHN0YWJsZUAgYW5kIEZpeGVzIHRhZ3MgKEdyZWcpDQo+ID4g
LSByZXdyaXR0ZW4gY292ZXIgbGV0dGVyIHRvIHBvaW50IG91dCB3aGF0IHRoZSB2ZXJzaW9uIGlz
IHRvdWNoZWQgYW5kDQo+ID4gICB3aGF0IHRoZSBkZWNpc2lvbiBtYWRlIHdpdGggdGhlIGF1dGhv
ciBvZiB0aGUgb3JpZ2luYWwgY2hhbmdlIChHcmVnKQ0KPiA+IC0gZml4ZWQgdGhlIHBsYWNlbWVu
dCBvZiBvbmUgcGllY2Ugb2YgY29kZSAoQW5kcmV5KQ0KPiA+IC0gYWRkZWQgVGVzdGVkLWJ5IHRh
Z3MgKEZlcnJ5KQ0KPiA+DQo+ID4gQW5keSBTaGV2Y2hlbmtvICgyKToNCj4gPiAgIFJldmVydCAi
VVNCOiBmaXh1cCBmb3IgbWVyZ2UgaXNzdWUgd2l0aCAidXNiOiBkd2MzOiBEb24ndCBzd2l0Y2gg
T1RHDQo+ID4gICAgIC0+IHBlcmlwaGVyYWwgaWYgZXh0Y29uIGlzIHByZXNlbnQiIg0KPiA+ICAg
UmV2ZXJ0ICJ1c2I6IGR3YzM6IERvbid0IHN3aXRjaCBPVEcgLT4gcGVyaXBoZXJhbCBpZiBleHRj
b24gaXMNCj4gPiAgICAgcHJlc2VudCINCj4gPg0KPiANCj4gVG8gc3BhcmUgZXZlcnlvbmUgdGhl
IG5lZWQgdG8gcmVhZCBleHRyYSBsb25nIHRocmVhZCBpbg0KPiBbUEFUQ0ggdjIgMi8yXSBSZXZl
cnQgInVzYjogZHdjMzogRG9uJ3Qgc3dpdGNoIE9URyAtPiBwZXJpcGhlcmFsIGlmDQo+IGV4dGNv
biBpcyBwcmVzZW50Ig0KPiANCj4gTkFLLCBvbiB0aGUgd2hvbGUgc2VyaWVzLiBUaGUgcmVncmVz
c2lvbiBkb2Vzbid0IHJlcHJvIG9uIG15DQo+IEVkaXNvbi9NZXJyaWVmaWVsZCBzZXR1cCBhbmQg
ZG9lc24ndCByZXBybyBvbiB0aGUgb3JpZ2luYWwgcmVwb3J0ZXIncw0KPiBIVyB3aXRoIG15IGJ1
aWxkLCBzbyBpdCdzIHZlcnkgbXVjaCB1bmNsZWFyIHdoYXQncyBnb2luZyBvbiBhbmQgd2hhdA0K
PiB0aGUgcHJvYmxlbSBpcyBhbmQgdW50aWwgaXQgaXMgdGhlIHJldmVydCBkb2Vzbid0IHNlZW0g
d2FycmFudGVkLg0KPiBQbGVhc2UgZG9uJ3QgYXBwbHkgdGhpcy4NCj4gDQoNClRoYW5rcyBmb3Ig
eW91ciB0ZXN0cy4gVGhlIHNlcmllcyB3YXMgYWxyZWFkeSBhcHBsaWVkLiBJdCdzIGEgYml0IG1l
c3N5LA0KYnV0IGl0IHNlZW1zIGxpa2Ugd2UgbmVlZCB0byByZXZlcnQgc2VyaWVzIGFzIHRoZXJl
IGFyZSBhbHJlYWR5IHJlcG9ydHMNCnRoYXQgdGhpcyBpdCBhbHJlYWR5IGJyZWFrcyBvdGhlciBz
ZXR1cHMuDQoNClRoYW5rcywNClRoaW5o
