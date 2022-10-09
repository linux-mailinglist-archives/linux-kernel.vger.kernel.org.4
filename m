Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDD5F8C60
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJIQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJIQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:39:49 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8DF7A;
        Sun,  9 Oct 2022 09:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PztspxPkgzhZLXIrthtLl/N9HMfXrge2HtG0wY17VXmOVNjZOimeVZkPf1G65naFzxz8HZZ9LXb2IzKU4tAojT9cX6aFhM61S77pWUBnniVgbXO3Wzni5/ught9fn9JCBz+99P7OBn4vF1H4vFtKofUeaXCvhccGAuEhYEB9tZiY0eWvLCrAIPvn78NPGiFjDdhDk1G2kaU463N06mGJjd1ipgawXCtl8sN6SwhoIhomqoNea8rCbvuRzgtBJbz1lfmPUqjqU79/SIcUpYXtCwvNTNOae2ZnVhP5wyALz5WvrsGPPENqxf7qy1lgO86G2NZJC3cUGSp03AwMnlLg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvhxTMZBAdayG5c/St+nuZ3XxsafeL9UJDeMyU8TGwE=;
 b=JQBr5sdVDxVuab/Q6ZYPe1kXXJMLf2cH9fq1IBtaJMSk8/EnLYC+ODP2ne9jXpI0N8rJZtAlPGffauYmIIMs15TP0G6i0ZNcH0LiRvniT9hLRZcTWXUu9ExWbw3QR92psXkowPMb4fSZrcWhnl1Qjmw1fO0nMe0ve8LSRfYxK0TLauoHT+ol8Xg29EjvQC3HQ6QJ9LhXdMm2AnheJL5xgPKS5h+eq0nbOHSbNDnfFZA1ycY5rb+6HWP7UvLbkhub2xWqf/zzCTYhMrMChPHCXR3f/cegzuNe44z9eB60Dg/jtmDj/9OGHYApJfQh9AI8x1zzKJ374SEi0vrEXD5xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvhxTMZBAdayG5c/St+nuZ3XxsafeL9UJDeMyU8TGwE=;
 b=XnFc/gjjxeUmzrxJEWFieTzwFqFIw5oJNoWpIyN0ECofjx4ceCAPzKWUmEuGXZ3EHvcpDa1qPhTGcKusnno+9P7HU03MlqQ9Qvd2nV5lazb/b3yX/xbnJHYrUBhRXUYKhsfWQwnVzC1WJc0dO9k2VLOjIlBpxQFnmwdF/E8Nm23prh0dg7lf/9tDUhilJnlRtuuT5DqJvIE6yc0Rf3UmrIXN7ZB2YotBtMvwVx9Ge3RUG+Vm3AcS0xMhCvAi2807uWMWTaIdmJqOoxW+/lybDvH6R5lF47qkd5o2sZzYUbzfIK+zPeBGTEhRobTohb1OH/20kAEiIH1sNqiIge4vRg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Sun, 9 Oct
 2022 16:39:43 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%7]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 16:39:43 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "shorne@gmail.com" <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v3 01/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHY28pRwB5uoa5m+UyEzf+Gt+dL3a4GQ96A
Date:   Sun, 9 Oct 2022 16:39:43 +0000
Message-ID: <83f292b8-0639-56b2-6dac-0475c34f623c@csgroup.eu>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-2-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-2-bhe@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2121:EE_
x-ms-office365-filtering-correlation-id: 53edb9ee-0ef3-4240-5db7-08daaa14de4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrAlpnRghvvCFVpzN7/hdExKYLoa4brxEBV4mWymehTc1m4E/5mzVZAAoZbfR0if5sTsTMSYh2IFdFnGkrDD/PIRir8SPBdkFh89buyveb5cwx4ZEZqmad7g5PGOc83VayJWto6YjIuiFcPMPp05iEfSnjBJfv8HnYvsIkPd1V0Ft4s+0Ju+Ri5AHJ57A9vgBsJoyaTwWR47yVup2jrnMmjv9EDbHbupnHpw6VPwZ4z934yL61kr6tc7eiXnd4p/GbmajG+V4OMHu1Yi+vBRgfdibpKQZIKIguNPVTu1PcXjgGsr81IJbB/A/TLfPe0PqpsGEr0sBzM+VcMq5fFE0rGOOm4gU9ebjuLs3SPCLRrDR8e1ia4lGuCtn1sxuK488B3C5Fz/RM8Y33DKsXImrEXFuyZjojo2SbynJ1FrvNgiTJc6VlF09pv6n1GwQTjxACbjyE/on8l1nQkbRfgyvrpnD1bE7qhbIwHvGCgsjq4IyMfBAypYH9WIfM5zNvwhgo47qFeXhJj39g/ccjOfcLWg0Su9e6pBNbTt1lVSZBpLMTUJzdoqEJPRwoqwr5MYI8K/SffDS6YUh7BliQjRij7KjKIV+Hs5ViC9uI4cM38E48zFekCmh41TauZPjY+aV6OBshbxBUZWinNHqMfoae+Ceh8zej/L1iLe+FsYXUUPTSO4ToSmKFpYqdWQH3tHW/fIsZd0KgRz1zbKM1Mf+qp1tZeUDiG2KTwFRlsdJu6M4ynG/NWube4j8Utep0VmYYRl1VwdZ+7yMmoDpzCXEVeepiejeaamyK6XYXs61deLOdpfg3rNQwvsI34qa4CokwwxH0TXBPmlbqIWyT4ym7jC5gGhcynJWbfHL0vPjIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(451199015)(8676002)(66446008)(6506007)(122000001)(54906003)(38070700005)(4326008)(316002)(110136005)(36756003)(71200400001)(66476007)(76116006)(83380400001)(66946007)(91956017)(6486002)(86362001)(31696002)(64756008)(66556008)(66574015)(38100700002)(186003)(26005)(2616005)(478600001)(6512007)(41300700001)(31686004)(2906002)(8936002)(5660300002)(7416002)(44832011)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtWSS8xV3FNbWxZc2J5SXNKd1QvK0dpL2JWMnhQYys1ZVdLNExkR1Nub01a?=
 =?utf-8?B?T3ovcjJLRWsxVW5qVWFycC9JYVh3WWh3U2wwVUQyT0xoc2R0K24ySzJFc0VX?=
 =?utf-8?B?TW12dGI4SVpCOTM4RnVLWWNXdkRIVnJEVHFsZ0xocG5Tei8zSnNoaUtvRDVi?=
 =?utf-8?B?YmxMT0VuRmZwdDkrVktGVVpxTkdyZ093VVZjTEJjRnFtN0I5a2RqdERpK3Jt?=
 =?utf-8?B?NndDc0pzS0ZsM0x2Q0xTTUo4eDlONS9KZEJtb0NyUzdsUzRTZ3pNVjgvZXow?=
 =?utf-8?B?MUlCNTFjb2lWTGplOFlqdHlWK1ppL20wMEk2d3NCWlVEZmJOYTROUk9jK3NP?=
 =?utf-8?B?cVAyYkk2enRqTmJXUHpvb0JPNTRjd21GdjdLMitCVFB1SW85dTNsTkJDSXAw?=
 =?utf-8?B?WEtVUUwxSDhvbC9XczBodTFLUWpTZzViaEdoQURnV09ueDNQWjFRQzJPWHFH?=
 =?utf-8?B?Z1dBWlAxME5zbWh6NXF6T0NDeWxpbkIvdzZGekY3cGJaQy9IbUpwU1pJRHdZ?=
 =?utf-8?B?K2ZVbkhaUVpxa0tQV2JyL1ZKWlNoNFdCY2Z4YkxHZDhPUC9QWGZQeWorTTQ5?=
 =?utf-8?B?S1VSR0dwSTAxV0l3bDVXOGEzOEN1bzcvQnl4K1VySzkwS09SaDZabU9GYlRv?=
 =?utf-8?B?YS8rSXZkL295R1RGRDBGdUMzWmYvSkM1ZEpQUGE1T2RUNllNWmNLZFdsbmZF?=
 =?utf-8?B?Q09sRFA1dVpMQ25KNm5vV1pUeDJSM1h2VHMrekxjU0szQUM3K2JyUDZwMGNE?=
 =?utf-8?B?cjNkaFlsUVArR2tGOXZrL3krTzRURkFXWEVPaCtOcUJaczQ5RUxYOUFDZmFS?=
 =?utf-8?B?MDJUY3o3UUtrdWFLMEZpQ2hPUWdNWlFVSEpTVytiRXlxL0UrRHVrN0hCSENa?=
 =?utf-8?B?aXBzZVdYSTRWbVhNL1dOODdTUHovUmdDZDlTS0lDUWF1eEJxRWhKdldORWRi?=
 =?utf-8?B?R091Mi8rTXZpMHdXYkgveXpoY3psb2FlU3BHK2dlMGVOdXR4VG1TemtVMzhC?=
 =?utf-8?B?TWU2K3dZcnlwM08yUkZBZkhQQndHalJqcEhKOU5seU1YT0hycTU1S0tNcmR6?=
 =?utf-8?B?WEhycmlLU1BRdXdhVHVqcmN1RlpZa1dzS1dTZ3ZFTUxMdkFuRVVWTG5UalNR?=
 =?utf-8?B?UDZYa1lSWnhsMmNhYkV0NXVSRDJ3eEF4RVZScXc1NnRPa1ZYcFNCZWx0ZmRr?=
 =?utf-8?B?NmV4SDdhMXlGdnBoVkpaQ1IxWmcvVjJ6d3cwR2h5UnVYdWxkdW9LcDRuS3lN?=
 =?utf-8?B?aVdJNGZzcG1Nelg1aGhGZmIvSWxGMTE1NHZZdVZtNjd0YTJDR1pOOVlLTEJp?=
 =?utf-8?B?YncwUk52anhHL0JFL3hyajlKajJsRlNDWUduWmUxRGZUdlBOOXYzVi83Q2ti?=
 =?utf-8?B?cnMybEJHRkJRbHE1aG9IakhPZGp4eG9ZWEJTcFpLeTZoYlV3Z0FVRnFiQU56?=
 =?utf-8?B?VHprdFIyR3ZRQnRPckFYSEdKS3Q2WG5BMmdONkdwMjlPUHVjWW9BVEFDbnFu?=
 =?utf-8?B?SkhSNDAxZzBCQUJTZTQ1L3h0NGszSUgyK1B1aE1JVmREMUhpNmtxS1hKM0xp?=
 =?utf-8?B?dENJSjBFaUpBS1VDZTlFcFk5bGtMaHdKMU85RjkwQXhnMjFaVTRMZkhLZDRD?=
 =?utf-8?B?bnc4bldhRHlVRWtpeDVaM1dEWnl2dEdIdmE4K1BjVkpoN3AvY3VycC9LMTN1?=
 =?utf-8?B?bGJhUlpZZVVGcFJQOUVuOG5LZXl6MVJ1S3ZDNi9TWE1pcjk4akZYUUJJeVFE?=
 =?utf-8?B?aTJ0aG9GNXU1V1lQV3NSUXNlZkRJYzAvUm5PZ0N5YWJWWU5KMFhUZ3JTa2d2?=
 =?utf-8?B?YTN1L0IrZkJwbTBjdWExazRMR045emZwbHp2U2p3cUJueWdZVFhoOXRhdUNx?=
 =?utf-8?B?VWN2ZFFFcVdKczZmUll6WHdtTm9QeGQ0cjZnZFdLL1FVUkpsUUs5ZS9KZHgx?=
 =?utf-8?B?dndiVmF6QzBRbThBT2lnVjlYejg5RzNXMWV1V09QVmtYb2FJZExwRjg5aVVZ?=
 =?utf-8?B?YS9tZFVkanJNVnc4SUw4SGVpRWZjLzVBRVdZdDJYcmU3TFlZN29TM3BpZS9i?=
 =?utf-8?B?K3kyOWlhTWtRWlJjVkRrd0hzYXcwWGQ3bVNzNXpRbUZWMklBRFV2RVl5NWlo?=
 =?utf-8?B?ZXZYSm1WdHlMUGEreW5CbGpSdzFxOHExSFYwUDRGN2tjQzIvdmNQVHMwdnFR?=
 =?utf-8?Q?9OXx4Qko5nlt1/9l9IxjRdo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C88727DFED983B43AC405240C8B7CBBB@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53edb9ee-0ef3-4240-5db7-08daaa14de4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 16:39:43.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwbeMzG5mysMgcMvgW8RYmzVLVwFu+YxvQ/tdOM7GR5Yo8pneJSFg5KvJoCvqey04x1QI38B2yHPObqY/XQ6w0K7PGxF6C7q/sFoCxp4gck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2121
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA5LzEwLzIwMjIgw6AgMTI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gQnkg
dGFraW5nIEdFTkVSSUNfSU9SRU1BUCBtZXRob2QsIHRoZSBnZW5lcmljIGlvcmVtYXBfcHJvdCgp
IGFuZA0KPiBpb3VubWFwKCkgYXJlIHZpc2libGUgYW5kIGF2YWlsYWJsZSB0byBhcmNoLiBBcmNo
IG9ubHkgbmVlZHMgdG8NCj4gcHJvdmlkZSBpbXBsZW1lbnRhdGlvbiBvZiBhcmNoX2lvcmVtYXAo
KSBvciBhcmNoX2lvdW5tYXAoKSBpZiB0aGVyZSdzDQo+IGFyY2ggc3BlY2lmaWMgaGFuZGxpbmcg
bmVlZGVkIGluIGl0cyBpb3JlbWFwKCkgb3IgaW91bm1hcCgpLiBUaGlzDQo+IGNoYW5nZSB3aWxs
IHNpbXBsaWZ5IGltcGxlbWVudGF0aW9uIGJ5IHJlbW92aW5nIGR1cGxpY2F0ZWQgY29kZXMgd2l0
aA0KPiBnZW5lcmljIGlvcmVtYXAoKSBhbmQgaW91bm1hcCgpLCBhbmQgaGFzIHRoZSBlcXVpdmFs
ZW50IGZ1bmN0aW9hbGl0eS4NCj4gDQo+IEZvciBoZXhhZ29uLCB0aGUgY3VycmVudCBpb3JlbWFw
KCkgYW5kIGlvdW5tYXAoKSBhcmUgdGhlIHNhbWUgYXMNCj4gZ2VuZXJpYyB2ZXJzaW9uLiBBZnRl
ciB0YWtpbmcgR0VORVJJQ19JT1JFTUFQIHdheSwgdGhlIG9sZCBpb3JlbWFwKCkNCj4gYW5kIGlv
dW5tYXAoKSBjYW4gYmUgY29tcGxldGVseSByZW1vdmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+IENjOiBCcmlhbiBDYWluIDxiY2FpbkBxdWlj
aW5jLmNvbT4NCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6IExp
bnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LWhleGFn
b25Admdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiB2Mi0+djM6DQo+ICAgIFJld3JpdGUgcGF0Y2gg
bG9nLg0KPiAgICBQdXQgaXQgYXQgdGhlIGJlZ2lubmluZyBvZiBwYXRjaHNldCBzaW5jZSBpdCBk
b2Vzbid0IGludHJvZHVjZSBuZXcNCj4gICAgYXJjaF9pb3JlbWFwKCkvYXJjaF9pb3VubWFwKCku
DQo+IA0KPiAgIGFyY2gvaGV4YWdvbi9LY29uZmlnICAgICAgICAgIHwgIDEgKw0KPiAgIGFyY2gv
aGV4YWdvbi9pbmNsdWRlL2FzbS9pby5oIHwgIDkgKysrKystLQ0KPiAgIGFyY2gvaGV4YWdvbi9t
bS9pb3JlbWFwLmMgICAgIHwgNDQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pDQo+
ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvaGV4YWdvbi9tbS9pb3JlbWFwLmMNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2hleGFnb24vS2NvbmZpZyBiL2FyY2gvaGV4YWdvbi9LY29uZmlnDQo+
IGluZGV4IDU0ZWFkZjI2NTE3OC4uMTdhZmZmZGUxYTdmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2hl
eGFnb24vS2NvbmZpZw0KPiArKysgYi9hcmNoL2hleGFnb24vS2NvbmZpZw0KPiBAQCAtMjUsNiAr
MjUsNyBAQCBjb25maWcgSEVYQUdPTg0KPiAgIAlzZWxlY3QgTkVFRF9TR19ETUFfTEVOR1RIDQo+
ICAgCXNlbGVjdCBOT19JT1BPUlRfTUFQDQo+ICAgCXNlbGVjdCBHRU5FUklDX0lPTUFQDQo+ICsJ
c2VsZWN0IEdFTkVSSUNfSU9SRU1BUA0KPiAgIAlzZWxlY3QgR0VORVJJQ19TTVBfSURMRV9USFJF
QUQNCj4gICAJc2VsZWN0IFNUQUNLVFJBQ0VfU1VQUE9SVA0KPiAgIAlzZWxlY3QgR0VORVJJQ19D
TE9DS0VWRU5UU19CUk9BRENBU1QNCj4gZGlmZiAtLWdpdCBhL2FyY2gvaGV4YWdvbi9pbmNsdWRl
L2FzbS9pby5oIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2lvLmgNCj4gaW5kZXggNDZhMDk5
ZGU4NWI3Li5kY2Q5Y2JiZjU5MzQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvaGV4YWdvbi9pbmNsdWRl
L2FzbS9pby5oDQo+ICsrKyBiL2FyY2gvaGV4YWdvbi9pbmNsdWRlL2FzbS9pby5oDQo+IEBAIC0x
NzAsOCArMTcwLDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB3cml0ZWwodTMyIGRhdGEsIHZvbGF0
aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4gICAjZGVmaW5lIHdyaXRld19yZWxheGVkIF9fcmF3
X3dyaXRldw0KPiAgICNkZWZpbmUgd3JpdGVsX3JlbGF4ZWQgX19yYXdfd3JpdGVsDQo+ICAgDQo+
IC12b2lkIF9faW9tZW0gKmlvcmVtYXAodW5zaWduZWQgbG9uZyBwaHlzX2FkZHIsIHVuc2lnbmVk
IGxvbmcgc2l6ZSk7DQo+IC0jZGVmaW5lIGlvcmVtYXBfdWMoWCwgWSkgaW9yZW1hcCgoWCksIChZ
KSkNCj4gKy8qDQo+ICsgKiBJL08gbWVtb3J5IG1hcHBpbmcgZnVuY3Rpb25zLg0KPiArICovDQo+
ICsjZGVmaW5lIF9QQUdFX0lPUkVNQVAgKF9QQUdFX1BSRVNFTlQgfCBfUEFHRV9SRUFEIHwgX1BB
R0VfV1JJVEUgfCBcDQo+ICsJCSAgICAgICAoX19IRVhBR09OX0NfREVWIDw8IDYpKQ0KPiArDQo+
ICsjZGVmaW5lIGlvcmVtYXBfdWMoYWRkciwgc2l6ZSkgaW9yZW1hcCgoYWRkciksIChzaXplKSkN
Cg0KV2h5IGRvIHlvdSBuZWVkIHRvIGNoYW5nZSB0aGlzIG1hY3JvID8NCg0KPiAgIA0KPiAgIA0K
PiAgICNkZWZpbmUgX19yYXdfd3JpdGVsIHdyaXRlbA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9oZXhh
Z29uL21tL2lvcmVtYXAuYyBiL2FyY2gvaGV4YWdvbi9tbS9pb3JlbWFwLmMNCj4gZGVsZXRlZCBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDI1NWM1YjFlZTFhNy4uMDAwMDAwMDAwMDAwDQo+IC0t
LSBhL2FyY2gvaGV4YWdvbi9tbS9pb3JlbWFwLmMNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSw0
NCArMCwwIEBADQo+IC0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+
IC0vKg0KPiAtICogSS9PIHJlbWFwIGZ1bmN0aW9ucyBmb3IgSGV4YWdvbg0KPiAtICoNCj4gLSAq
IENvcHlyaWdodCAoYykgMjAxMC0yMDExLCBUaGUgTGludXggRm91bmRhdGlvbi4gQWxsIHJpZ2h0
cyByZXNlcnZlZC4NCj4gLSAqLw0KPiAtDQo+IC0jaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gLSNp
bmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvbW0uaD4NCj4gLQ0K
PiAtdm9pZCBfX2lvbWVtICppb3JlbWFwKHVuc2lnbmVkIGxvbmcgcGh5c19hZGRyLCB1bnNpZ25l
ZCBsb25nIHNpemUpDQo+IC17DQo+IC0JdW5zaWduZWQgbG9uZyBsYXN0X2FkZHIsIGFkZHI7DQo+
IC0JdW5zaWduZWQgbG9uZyBvZmZzZXQgPSBwaHlzX2FkZHIgJiB+UEFHRV9NQVNLOw0KPiAtCXN0
cnVjdCB2bV9zdHJ1Y3QgKmFyZWE7DQo+IC0NCj4gLQlwZ3Byb3RfdCBwcm90ID0gX19wZ3Byb3Qo
X1BBR0VfUFJFU0VOVHxfUEFHRV9SRUFEfF9QQUdFX1dSSVRFDQo+IC0JCQkJCXwoX19IRVhBR09O
X0NfREVWIDw8IDYpKTsNCj4gLQ0KPiAtCWxhc3RfYWRkciA9IHBoeXNfYWRkciArIHNpemUgLSAx
Ow0KPiAtDQo+IC0JLyogIFdyYXBwaW5nIG5vdCBhbGxvd2VkICAqLw0KPiAtCWlmICghc2l6ZSB8
fCAobGFzdF9hZGRyIDwgcGh5c19hZGRyKSkNCj4gLQkJcmV0dXJuIE5VTEw7DQo+IC0NCj4gLQkv
KiAgUm91bmRzIHVwIHRvIG5leHQgcGFnZSBzaXplLCBpbmNsdWRpbmcgd2hvbGUtcGFnZSBvZmZz
ZXQgKi8NCj4gLQlzaXplID0gUEFHRV9BTElHTihvZmZzZXQgKyBzaXplKTsNCj4gLQ0KPiAtCWFy
ZWEgPSBnZXRfdm1fYXJlYShzaXplLCBWTV9JT1JFTUFQKTsNCj4gLQlhZGRyID0gKHVuc2lnbmVk
IGxvbmcpYXJlYS0+YWRkcjsNCj4gLQ0KPiAtCWlmIChpb3JlbWFwX3BhZ2VfcmFuZ2UoYWRkciwg
YWRkcitzaXplLCBwaHlzX2FkZHIsIHByb3QpKSB7DQo+IC0JCXZ1bm1hcCgodm9pZCAqKWFkZHIp
Ow0KPiAtCQlyZXR1cm4gTlVMTDsNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4gKHZvaWQgX19pb21l
bSAqKSAob2Zmc2V0ICsgYWRkcik7DQo+IC19DQo+IC0NCj4gLXZvaWQgaW91bm1hcChjb25zdCB2
b2xhdGlsZSB2b2lkIF9faW9tZW0gKmFkZHIpDQo+IC17DQo+IC0JdnVubWFwKCh2b2lkICopICgo
dW5zaWduZWQgbG9uZykgYWRkciAmIFBBR0VfTUFTSykpOw0KPiAtfQ==
