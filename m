Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDF60A217
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJXLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiJXLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:38:02 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e24::71f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980F36B65B;
        Mon, 24 Oct 2022 04:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3TUjdug6vfp1BFcTkBcQQKnzwI8R3lAmE2JLWy9781EqXLmJgiknQFUqMcnoXKit/5wIjTYlbD2bpA47n9YrFRRVK9zqn/zIzD0ozz2GAJ4Fe6HZksj5+FgKzQapPEC/PALrZc57Vl6VyvnHb/dXH8UXywzWGz/rf0eFOOxBgcvJz+uvwZWQLPT7UHqPcgWRcBsVJTyR3+GHR7Oj5DA7dICut5E2k+6O1bMZ0XyOco0YbefgATFX3D4Y/ruz+aOcI+wcB9+DNonnj789ZPYtNuEyLRq2sDOl/f656D+UVuTOEOmtGT6qMU+hT+g+TgmWbMmzSv2XMyAV8pW9YlQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8JGHxC43io5+DTXx7FTDOcwAk8rKOhpWcC+spArxGs=;
 b=WIyFOiNFm52uqinFz1MB5ZAI5fG+Na68OUorD5sYhtIlu6GC/4KIL4dHBeFHoIosdqDTcuCVckBgOZ2Rgs9PbSg0x4TvPfRGH5+dif+wUTVmq9x6y/SdXGswMM0ikWxIZlLYyLZugs7WVMQw1v9EyqSaOLINo3KIJTnj8GFTnK8vajurzxxeTiuSrVIThRDkF1l4i5KLR8mqnfULgsVk9PsDjCmGHAE4ZI5lBaIx8dmpMOuWGWeoYjtQ1XO7DevpNrOoufI9PnXlmEDi13QBzPXTFAr0uae0iU6c9ZayRYBfsUgpbnn7XFRyUitOA77WiIlrwU0vhmyduQCG5hE2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8JGHxC43io5+DTXx7FTDOcwAk8rKOhpWcC+spArxGs=;
 b=aWBj9nOFIicWvo2QUtDEV7dxRsyHTs7rMULUsiJ34tI5bWDR+dNk/N7+/4ZiLsXHmTJg2MRwEEaoBlaxiTXXr+dGBAFd7o7BVP+n/uWSKM8xj52ralRAEFvmbD4jrDVi6p61KbISnVUJ1TyQ/s88//L2t88KA35aCjThjCcD+50=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB1456.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 11:36:33 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 11:36:33 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Joe Perches <joe@perches.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Topic: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Index: AQHY5T+Ki+hRTsI0rUKVheWiu5nxcK4dH/IAgAAI0gCAADasgIAABLCAgAADVACAAAfGgA==
Date:   Mon, 24 Oct 2022 11:36:33 +0000
Message-ID: <ea05a744-0eb4-a18e-c238-a1e3d99c8aea@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
 <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
 <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
 <6b9b7f9d835a271312bd5955d96b83bd14c9e6fa.camel@perches.com>
 <57582495-210b-f9c2-db80-e2ddbc76e7c3@fi.rohmeurope.com>
 <e72efbf7a80cae08041e4ff7be8630044c989c92.camel@perches.com>
In-Reply-To: <e72efbf7a80cae08041e4ff7be8630044c989c92.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB1456:EE_
x-ms-office365-filtering-correlation-id: 0ed92dae-e448-4ca3-439a-08dab5b40062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SDZnR5vUXMGxM1oiSdla2+pHRSSQaHkXiGeN1aJ8+NuPgS4PoAd8WaRj41wW3rcbYaCX2LMNnYHKnZHWFBPJWHvsTnl9xd9EvMT3WHivuCKWmGRK5n2TBVIAdG0tuGAT/r8WJvGzfU41QB5GBwtGg5cwGErZ1pzEYFmUiLD5vCdrUMl0Ze7XWxjWhzUytMV2a5nTSpwQ/RyP9zNJcWGARSEzazf1s2QdWT1tF0Y6uG53MTqLVBG4TBDEjA2gRgO9IcSFzT4NVh8CQbXBpcn2T/D7YZ/YCkCeT4aX7XgfRdgVLnKgjlvst5zolh+ONNT8uiE6yNuMqc3HbptRIpLHOBnb1EtL+o7c9ACOcc4Y4kBeIwjU4uVe0otnShnic3+gggzdI/n6A5HmCIZHtlTZzlSLTkhZCYxSyG8Qn9Dt9YzyFCEYEIvtBNLhB8eBvIL9vGAyPtUYHwdx9lMgn3TWKFH2FO5gwPH9n4ow/ay2ypBl2H96rxEV5MGCISCFFZoUdrFAdanhI12DU7Jxim2pUqbOA3TeQMBJIrCKNRL6uMkkNGqH557pWmDLT2QKW8tdEDf4/Wr2sLOaxPm2uJc5xO7gc8+9XKZVu9vmZe9YsHpBJS4xHvM7GHHJBF87bFAA+At+d50NgTmDWQDO+VdAiYEo15Rr7mgB5t4yrOWQ2dfGmdqq+pIaJbU5+TJWUmZN2sxjzm5+OdvBu70aVqPzx5GT5uLDNdHbit2hDvpdZ+qVJ5eJk28dv99w4HNFs4M9zvEx5H3y0qSTJiJMXY2GFTriRQY7tsi3+ogK6MYpA09OSrBNZQmiwaCXJjsW2EqN0ORkZTSLTvau0JBcLnH1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39850400004)(396003)(376002)(451199015)(31686004)(66899015)(478600001)(4001150100001)(2906002)(186003)(38100700002)(71200400001)(6486002)(316002)(110136005)(66446008)(66476007)(76116006)(38070700005)(66946007)(4326008)(8676002)(122000001)(41300700001)(91956017)(64756008)(54906003)(66556008)(53546011)(6506007)(6512007)(26005)(5660300002)(8936002)(7416002)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3dZYi9ybVpuSlVEZFRwMXNhYkJJcnlWM0YzQ0VkSG0xWEFWQ2xkZmZ5WWVr?=
 =?utf-8?B?alN6RkFaMDlXZnVUT05MVHNRV0NRU2ZQZiswd3VMRFRTN1BRWVVkMTN5RjMx?=
 =?utf-8?B?UWJZNEVoejNPTmhQa1cwcWFkUW8rRS9UOTZFTEF0NUFQWGh2MXFVRjEwM2po?=
 =?utf-8?B?akNTdENEbWNXVnhjZlRTK2ZTZE0wRzBJcldvak1hMHZrVWlGS1ErdnZzdHRM?=
 =?utf-8?B?NDhmeUpVVDNLbllxcXhENjdldkdlN1o2WGFUd3JId1pvMjd0OWpKVS83cG5T?=
 =?utf-8?B?enFtMks1WmNVMEQvaDhES3JBRzVhNUUxQXEzTE9JUG84MnZYVTlaRGwvYkQ2?=
 =?utf-8?B?bUdtTnFYWldDQ05qMnNjUHEva291QVBTUUlEczFRSkVOV0RUMnd2ajBCYlk4?=
 =?utf-8?B?ZkFiUm5Jc1JzY25WMVY4bWRJOVNMY3BjQ0VQWG1rYk1iSFUrcEQzanlrM1pJ?=
 =?utf-8?B?a21YK2dIejRJSjN6Ym8vL2lucDZIblFjK2NoZllEbWxlOXlmR0szVm5XTkQz?=
 =?utf-8?B?YllQVDcrczBDcG8yMVE4K0thQUJnT0dNcHBZZUVUbmE4aCtxRTE5ZXFGQ2U1?=
 =?utf-8?B?VTNCWWJmclBVUng3QzQ3M0s4R0hTRzBuL3hIWTVMSVM5QWJZMjVJNW9Eck91?=
 =?utf-8?B?ZFhZNjY4LzFKdVovZUFwZEM2TVQ3WkVvYzBncWFzWFFndWYzc1hoYXl6RGc1?=
 =?utf-8?B?azhRa29ISEdnN0x5RHMwRjhJTGVLSzlsUjRhV3QwSGdrTXBlZlV4aVU3cnMw?=
 =?utf-8?B?WTl5ZkdyL3BFSjNYdGg2YW0wNzdoeGJBR2xNanh6Nk9WK2tISy9UZHlyNm9s?=
 =?utf-8?B?c3F6SzJwNXk4ay8zMnM0VGFZOHJQRTd1Q1F3SWJZZkFDbko0ejA2ZC8vd3ly?=
 =?utf-8?B?Q01rS2Rtck5FOHNuRlA2eWIrNTUzNE1jZGx1VklaOVE4TkI2NEsvc2VxM0Nq?=
 =?utf-8?B?b3FiTkRrR0pNd29BTWtvenE2R3JCSjlQTUVEdGhyeDNqU0FNc1pWcUlpMDVC?=
 =?utf-8?B?K0hUd3VIWUlUSVUxWW1NOVdJZnNTaWlvRzJUMFN3YkF4RW45di9tbm1nbTN4?=
 =?utf-8?B?NVMxUXNocUlrV1Jib0U0b2xpWWJzTXdZRXV6d05mMHRMNHpqNGtDMFdjRDg5?=
 =?utf-8?B?MzRKYkczTmRGc3IrZW15WlZPRm5rb01pQkxGcWUrN20zbDF2UmdtTlU3RW9a?=
 =?utf-8?B?YWhjMXdnZ0tud08xUXo4YzluSzlJYzdCVVZ2SnB6b2VVMXlPNklRc0dJOGtU?=
 =?utf-8?B?QlJQK3Uvb3R0VWFPL2dGblUxSHV3d2crV3Evalc1clhGemRSdkE2TndrdlNT?=
 =?utf-8?B?VEVYMXBnNHFxY3JpMW04Y2ZGMExNNDdrMnFoMWQwYjlIczg3R1IvL0JpUWJU?=
 =?utf-8?B?MTFUTGIrUlkrRjJsVmhuMk82dlc1eHJnSFo2ZDZ1QkRPR1pzaGx3b1oyeUs3?=
 =?utf-8?B?NGhPQXNubTc2dEFvUk5veXNBVFFGcXZmMW15THZTcGRudEtaL2QwcjVkTGcz?=
 =?utf-8?B?anlZODFSdnJvN01NdHhNanNnREQwalJwTm05eVRwQmxZa2c1RVVvS3BQbjFr?=
 =?utf-8?B?Qk5NQkZrdDRreEJzekRWYnd2WkpHZFRZWklOSWlrbytLdE1kVDNRT1VCYXNx?=
 =?utf-8?B?SllwR2llU1NTMXUwUHBOQkQ4VFpxOERrZFdPcXh3cFoxdTU5MFpVbDhOK0p1?=
 =?utf-8?B?ZzZJM3EyNlZWSE9FMGFoSzlWTFlGWWxuOXJPWUt4dytUSU5LSzVDdk80dU9Y?=
 =?utf-8?B?S2FqS1JuVmJob0oxNHdEL2o2cE5NbkpkZkJ5R2tkSHVpb3RFRVRhY2xWQ1JC?=
 =?utf-8?B?M0pJQWtHQkpXZGFjb25wdWxFK2xLYUxZcWN5bVFBbDM4SnR0Y05XTm1GQ1c3?=
 =?utf-8?B?VFFlb2h2emNYN0JoOHp6UXp5WE1YZWU0cEpLYmpRaHcxNFVpWE1ZdTBuNENs?=
 =?utf-8?B?SnhhN2w4bmpzbktCM1FwWk44KzNyQVBIS05xbWdWSlhnSHhTU28vdG4yM2lH?=
 =?utf-8?B?aVN5OGkrbHF4cEtON2ZMM1dLV05VdEN5Nm05dC9kZk1jOFE3VHZJb3hjSnB3?=
 =?utf-8?B?aTYyZ1I4OVZ1REtCd0Z6clZ3REdocy8rVktydCsvcTVDTUtXMXJlamRGTitn?=
 =?utf-8?B?ZGtiaHhwdEdwNWRTUm9Ra2ErZ0RqR2FMeWFDakxlMmdyU0s5UTNZVU1WUVlP?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E285B36B05DBA42BA5C94D5846A684C@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed92dae-e448-4ca3-439a-08dab5b40062
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 11:36:33.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBEkmivGWfk3v+JYXli2VG+lKDLSVmjNmAlX13jWgSZwDawssrf6Zo5cRFCoppWVqfNWJrthUqufqmq25EJ72caoJy89WcoFbM8qBzDBJwYcRKJ8ZKHT6C2Zkn1y1KC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjQvMjIgMTQ6MDgsIEpvZSBQZXJjaGVzIHdyb3RlOg0KPiBPbiBNb24sIDIwMjItMTAt
MjQgYXQgMTA6NTYgKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+PiBPbiAxMC8yNC8y
MiAxMzo0MCwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+IFtdDQo+Pj4NCj4+PiAJUzogKlN0YXR1cyos
IG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPj4+IAkgICBTdXBwb3J0ZWQ6CVNvbWVvbmUgaXMgYWN0
dWFsbHkgcGFpZCB0byBsb29rIGFmdGVyIHRoaXMuID4gCSAgIE1haW50YWluZWQ6CVNvbWVvbmUg
YWN0dWFsbHkgbG9va3MgYWZ0ZXIgaXQuDQo+Pj4NCj4+PiAidGhpcyIgaXMgdGhpcyBwYXJ0aWN1
bGFyIGRyaXZlciwgbm90IGFueSBzdWJzeXN0ZW0gImFib3ZlIiBpdC4NCj4+DQo+PiBZZXMuIEFu
ZCBhcyBJIHdyb3RlLCBJIGFtIHBhaWQgdG8gbG9vayBhZnRlciB0aGlzIGRyaXZlciBhcyB3ZWxs
IGFzDQo+PiBvdGhlciBkcml2ZXJzIEkndmUgc3VibWl0dGVkIHVwc3RyZWFtIGZvciBST0hNIGNv
bXBvbmVudHMgKEtpb25peCBiZWluZw0KPj4gcGFydCBvZiBST0hNIHRoZXNlIGRheXMpLiBJIGhh
dmUgdXNlZCB0aGlzIFN1cHBvcnRlZCArIFJldmlld2VyDQo+PiBjb21iaW5hdGlvbiBmb3IgYWxs
IG90aGVyIElDIGRyaXZlcnMgYXMgd2VsbC4gVGhpcyBpcyB3aHksIGJ5DQo+PiBkZWZpbml0aW9u
LCB0aGUgUyBlZy4gc3VwcG9ydGVkIGlzIGNvcnJlY3QuIFF1ZXN0aW9uIGlzIHdoZXRoZXIgb25l
DQo+PiBzdXBwb3J0aW5nIGEgZHJpdmVyIG11c3QgYmUgYSBtYWludGFpbmVyPyBJZiB0aGlzIGlz
IHRoZSBjYXNlLCB0aGVuIEknZA0KPj4gYmV0dGVyIHJldmlldyBhbGwgb2YgbXkgTUFJTlRBSU5F
UiBlbnRyaWVzLiBIb3dldmVyLCBJIChzdGlsbCkgZG9uJ3Qgc2VlDQo+PiB0aGUgcHJvYmxlbSBv
ZiBoYXZpbmcgYSByZXZpZXdlciBzdXBwb3J0aW5nIHRoZSBJQy4NCj4gDQo+IFBsZWFzZSBkbyBu
b3QgY29uZmxhdGUgYSAicmV2aWV3ZXIiLCBzb21lb25lIHRoYXQgIm1pZ2h0IiBsb29rIGF0DQo+
IGEgcGF0Y2ggYW5kIG9mZmVyIGNvbW1lbnRzLCBhbmQgYSAic3VwcG9ydGVyIiwgc29tZW9uZSB0
aGF0IGFjdGl2ZWx5DQo+IHN1cHBvcnRzIHRoZSBkcml2ZXIvc3Vic3lzdGVtLiAgSSBkb24ndCBo
YXZlIGEgdHJlZSB0aGF0IGlzIHB1bGxlZA0KPiB5ZXQgSSBhbSB0aGUgZ2V0X21haW50YWluZXIg
YW5kIGNoZWNrcGF0Y2ggbWFpbnRhaW5lci4NCg0KSSdkIGxpa2UgdG8gYXNrIHdoYXQgdGhlICJh
Y3RpdmVseSBzdXBwb3J0IGEgZHJpdmVyIiBtZWFucyBpbiBwcmFjdGljZSANCmFzIEkgYW0gcHJl
dHR5IHN1cmUgdGhhdCBpcyB3aGF0IEkgZG8uIFNvIHBlcmhhcHMgSSBzaG91bGQgY2hhbmdlIG15
c2VsZiANCmZyb20gYSByZXZpZXdlciB0byBhIG1haW50YWluZXIgZm9yIHRoZXNlIGRyaXZlcnMg
dGhlbi4NCg0KWW91cnMNCgktLSBNYXR0aQ0KDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51
eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0K
DQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5
cGUgOmhlbHAhIH5+DQoNCg==
