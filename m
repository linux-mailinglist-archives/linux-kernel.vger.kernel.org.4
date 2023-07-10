Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73774DAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjGJQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGJQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:04:59 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn20829.outbound.protection.outlook.com [IPv6:2a01:111:f403:7004::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B89E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0enLWpvhIWQF7J6vX36Du4HZioC6JgL+67+pQFCKw950sc+X3lMF8QK8ZA6nkBB66uMt53ZMY8GlYJmXmHhc2o0aKQXe7i6eloB8YbM72aWiriHWwA3xFarIcuPKZLYcXfbHEGP2ESspac+8ihUBxjY6kp/55DDwajzHpgycrLs/XkNyPUsfib5yT4EcOQKaK2FacOYJCcg77a0vwJPld3KjTOWRr+CQmP+dUito6mc1uC8SgFJ5GPLhvl5zoPpnD4mSERG/om7LvPmaeIG2EM3hfksTVk2wiD9/8uP6iAR21eQ7n5SawpDzFgHHh/bdFlJ5CXjss/1cW8BlP2m3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khz19YuBasUavwaUrd1V3BRA/xnJ14MsksuIKTDvg9k=;
 b=CUT4AqQSthPiVqysh9qdXnw40iSlrwxholsV8MbEqUFsWPfZ80/cP7GCW+LFbAIDGbtoqQQeAlb4ANrE3Qrkv70cxYZHc5MIlFddzJwe9Rwv5nllCso0hmU+kDTHKsoKGgQydbhNhIg6q4f/R1GlSjGbzksv4uxJ4969jQgcpB8t/H+jFP/ynTlEF55uwT5n8TNrt1PPB7smkb23jRw/b+XfTUvuCiZ0AH37Pe5iohkNr1y3o+XB1CNwuo88AxHgFH/mKTYN9rwn0nxYRklYAN4hieU57Bt92ECcrWNjNDozhvZC0p9SA0a3F3E1tarYMWlwi467BYX+DrDZWF2EYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khz19YuBasUavwaUrd1V3BRA/xnJ14MsksuIKTDvg9k=;
 b=ZaVYGdRY6ASxsKJmUWXHTyDgtRwChKuPxOS5e883tdHkDkfcdeCHanZC1KLPAnCfPssjxRQe0qqQ6M3pzKpDzBzXiWUPjpMsPxBX/DS2b8bub+lOeFQyGmHMGdFDllnLaBOk+nUj0L+a4eI/U9X9gUlswbZHWfNbuGIi4/qU9Ov/pBa2ZQ1hfyJ85EZVUnunILSUAUFK/nRp07N8bJ0so8BiMMgjiPoJmcN1GhXGY9pjDcxAxRqV/5iVBu8jO4uGEkafp6BGDttfXvXDIdPfmJnjoxi8K1UacjRMkcsJJze9f78yjEUa4I08hv8lJLla+OPLX9lQmmPLpHXj2IB1oA==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SYYP282MB2128.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:04:51 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:04:51 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZsmnnf7L6P8pq70KmLgqGjaEZu6+xj+EAgAAiuACAAO/FAIAAiVAA
Date:   Mon, 10 Jul 2023 16:04:51 +0000
Message-ID: <ed74894e05c2541b436fbb29596d106fe569402f.camel@hotmail.com>
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
         <62e81ce06e69d549b12d1145429730f8b27ad156.camel@hotmail.com>
         <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
In-Reply-To: <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [6J3E3MSCUKz5Y8W5PYEaDfRgI2ThDDRHdFhAaGqn9pdh0wEpmoBCPKIf/D+JKPct]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SYYP282MB2128:EE_
x-ms-office365-filtering-correlation-id: 9dfd1ffb-1ded-48d4-7536-08db815f64f0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOh/CiF+fYx77g9QsV3CxQqOduC0KJm6bvbH/3Ker28CV4ry1qGl6kzU81CoJqm/I+tViegM6jrF5QHpMPkQXt+jprrjwh21XKEvDgJeCaQrqtnjtkD99+WRm4XupHSvU558oRp+5gnM8TnqEhOz+qTWtAtWOhV0j9/WcvhyxOe6fJUN+HwdcYfTgRr2BapN12KxMaN6lJo/63LLttnCpJS1Kc0G9sNgE9NB2ks9BvOTOb1U1kpg0P7WA9WbkeNadmMsfGjS8DzUrqwz1qtPODH3KS1cWSsKTVvtyq/aWf0xfKNyZLNUJ6i8zUGjzIWgOJkJiyuk6X5Td9qVqGYWIUgNrCvgybzf+RQlmHRMqxDWZLRfp7WGgrCpek9+7lwPlEk/RElvDs/1bIOuAuK2Ir/tuAuEXLTHZ4iP7BSz+4MyLcP4YRNV1ennKbKqHRmwz7JK0WeLpwBDy9Ko/H6f5hcSRIStL/0JzD5NEEIaO6e7D3rkOXSG74ywwC//0cr9jmw2jCN1oE+U47cO3vfriq3dPvSCpvK/nZDaJBQAv54kV3Uu78twgW0NgJPr+7Wl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDltMEFDUjBKR284TlhnS2FPZ2o4V0l2d3V4WFRPTkI2alRSYjYycnFuSXJv?=
 =?utf-8?B?WTkvSHBKNjlKbE91RXlIVmtOVXNQeXovZThtWVBacklHUm5mTGZocFdBS3R4?=
 =?utf-8?B?YzdoaW1XN1hhUit1OEMvTDBnQWJWaWlGMmdCNDNVQWhQWkJON2t4dWpEWWhU?=
 =?utf-8?B?T3lFSVBUY1lCa21MZzJoUTZ2OUdKS1QyclpNTXhxelRtcHRMeHJpbWJKejNv?=
 =?utf-8?B?UDhncWZQVk1MK0VIdFU0UVhGTFlyQjAyd0VWaGFyMTdxMVJPODBqd05nSWlx?=
 =?utf-8?B?ODV5WG1pTmZvcXhJM3F5a2FZVHd6VHg3WlZnK1F5SURxMmFRaDJ0cTAvK1pu?=
 =?utf-8?B?Ulo0RWlsekh3RU5sZ0V6NVM2SXNnSHRkZzZKTjJCaGMyT1FscnNQVEFLV25Q?=
 =?utf-8?B?RUFkY0lDMFVabGdVbHhnNFdsQWJZb05DeExIY3didmN0bDMyUEluYVRlL0pr?=
 =?utf-8?B?bGV3dDdEYlRrYzYxQTliUnNRbGtYbEhETnhHcXlsWlNDMjNEcWFIby9Md3hD?=
 =?utf-8?B?cm1TeDR3SDVQR3MvTkVjZTZOSTcybW1BbHYwa2ZtVHB5N0pLaWVsSVBxOHl3?=
 =?utf-8?B?bDBqTUdkeEdNZkdKd2FYWUhxaUJrNGNMOHhOWlRLeTNLNE1hcUg0YVNNYmps?=
 =?utf-8?B?NjBMakJLQ09od3lDU0l5YUNqM2RHZXlvTEw1V0N5SERIQTZGOThPU3NYYW84?=
 =?utf-8?B?R3B1ZjBpNU55ZDVUZ2EyK0N0aUZDWmZPdUVYbUJoaUJqYnB2bUdzZHFZRHdY?=
 =?utf-8?B?Ym83TjRWTDFoM1Z6SzJMdU5GSllIdkVGL3Rsa3NlT1d1UTk4eDlzRjZIZENY?=
 =?utf-8?B?OThUZWwzTWdmenJNcHNiSmJ0Z1piUVFlMzBoMXlmenJ4bVRoL3E4a3RYTnph?=
 =?utf-8?B?blNaQ0lFS0dVUzQ1aTV0NW5nMlAzUUpRZWZMRGxLekNJMVdtbVhrTVJNSzd5?=
 =?utf-8?B?SjRGVXlSK2ZNNXZtU2dPWU9YS0thcFFjVXhqcEVqaXEva0N2TjhoNGVFa3hw?=
 =?utf-8?B?TXRkK2VSNExGUUh6azRqVUFkVEd4RVBWWXdkZi9iL1k1aXYrRkRqM1JiYW81?=
 =?utf-8?B?SThWbmM5QzltTk0yeE9ncW5IN05EL2pDUTVvTDdNanlJWlRZMmJka3l4c1lP?=
 =?utf-8?B?VE1ZZFQ2aGc0TE1ONzNsMXpjVDRMWFAraHh4UENXVjIrMUNpUVBGZXFqTTRF?=
 =?utf-8?B?ZWtKaFk5MmhERWdGNVpLcGlqaVo3by91UXhyTlhrNkIyUVNzMEFhMFNnRkJG?=
 =?utf-8?B?RTJvQVIzNkFKTFRMcjRzL1RYbWVFZmpRUGljOVRvaURSZDMxRVZUbkJjZGsr?=
 =?utf-8?B?aXp1K1ZoWGlZS1Z2cUl1d0x0NWthaWZ2QWNVMkxMK3hEVWw4QjZzK01YRjJk?=
 =?utf-8?B?TnpmYS9lMmd6N2Z4TlZvdytIUXNDUFRxWnJmdVUxR0RKOURQVXVyTTNsZXlD?=
 =?utf-8?B?SUtwdDg0Z0lHSkhMazVEUklLS0pWQW94QTkxQTV3bEl1eno3M0hvZVNNejJD?=
 =?utf-8?B?bW9BRDUwek9jRE1yNFNvR2xKdW5vT0JpVWcrRTZDZ1pMZFdkbmFOUUpheThT?=
 =?utf-8?B?TjFqblVRcHlmbGxlRWxObG1LeVIwcEJ3ZkJXb1NkSWExaGplSldFbDIyTWND?=
 =?utf-8?B?T21mQ0ZVc3dxT1cvQlUwS3dKOU1rZnhzc3pNeTE0OG1vajkzRXg4d011TlVK?=
 =?utf-8?B?aVFIME4vSXExNXUvSitFMjFPVVkzdnExSXlmMTQ2cW1vTkxmQ1kzcGRyTkZw?=
 =?utf-8?Q?7v1S2ftwitYtDns6l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <266AD3AFD25AC84E8A82BD6833AB500A@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfd1ffb-1ded-48d4-7536-08db815f64f0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 16:04:51.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB2128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTDmmJ/mnJ/kuIDnmoQgMTU6NTMgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsIEkgZm91bmQgdGhhdCBmb3Igbm9uLUZEVCBz
eXN0ZW0NCj4gQ09ORklHX0NNRExJTkVfRk9SQ0UgaW5kZWVkIGRvZXNuJ3Qgd29yaywgYnV0DQo+
IENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIgd29ya3MsIHNvIHlvdSBuZWVkbid0IGZpeA0KPiBD
T05GSUdfQ01ETElORV9CT09UTE9BREVSLCBhbmQgeW91IG5lZWQgYWRkICJnb3RvIG91dCIgaW4g
dGhlICJpZg0KPiAoaW5pdGlhbF9ib290X3BhcmFtcykiIGNvbmRpdGlvbi4NCj4gDQo+IEh1YWNh
aQ0KDQpBbmQgSXQgaXMgQ09ORklHX0NNRExJTkVfRk9SQ0UgYnV0IG5vdCBDT05GSUdfQ01ETElO
RV9CT09UTE9BREVSDQp0aGF0IGRvZXMgd29yay4NCg0KZG9ubW9yDQo=
