Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB2B6C9BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjC0HQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjC0HQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:16:11 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2090.outbound.protection.outlook.com [40.107.127.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852744BF;
        Mon, 27 Mar 2023 00:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQRT9ay0DLRo9uALy/6tqZiOv9VA922GtSsNjIBZ4+kFLJR7+D299+qq08bK4z1czAzDgVW5KNzUWAIXmdVQ2I7H3LCVmhebj/DcXxd7nDRB0fPdvccDqB8AJ3lGMzeWoMuVvazDKcvrYIcby2tIOQfUe2YMvkylFEkAkZku/fIzMBYQ9cqUb/RPINloqJeNlmL7dJtiwAsJSRZz1QPz1f0LJ8yIwJJE/Mm9lD359E9Qnn57u4q3OX4dElvBZKua8ICwWnFNjhY/86F26kN2NrzcOWst5MzE3gbOxJadsa7HafNJulaeiuUq5/GqTneHrYi3YtAoS15nXUGfWG+DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyZdDn7xCWKQERUChgnspn93ud1R4glEMtp+5EmTycY=;
 b=PfXxxKcRjzjzEOgiXpKQrC2fh7+bnQOeecRyCSP0c1md2UdhwjJBQCJU8cQyt2Zfje5b9jHIvv01DKkbMWR41NPcWNbAIK0jFercZokVpqZnflDK1O9Uq6pYJwmbkW1yU316/cfnU/DKCQLCiqm7fMoisujj7ljgedSlvTdIeGLnXQOFJPyoY//HnwMhVOKwPhNoEZM84PflYPq/f7iWDG/AckXeFlCqM85unfiIMTJpMMos2PONYfcff0f/3IRW00Vz+GGlb+FBerA9NL8uwdnLpJFpb0SodvNbO8KVPWkiTQM0Ovlf3e2Si9GmjDWzbVCeQnKypb3Jkq3ebqHp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyZdDn7xCWKQERUChgnspn93ud1R4glEMtp+5EmTycY=;
 b=zfiNywNoi8yymq7Y2O50i5pJw3NxtJhKGsvbyHnwEqP1cuefszmIg2f3psRuuTTuztnk1p2XUvv0d/XZ90d9LknMvlAoZ6PcYOD/pOpKvxla64iIhpk0J2s/uPjGVsT9Qdl/m5nUlcS8XaOIx6RRY3Navd0IhuCgmA0vXfpdk2Y=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2884.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:74::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 07:16:05 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%6]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 07:16:05 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Topic: [PATCH v5 7/8] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Index: AQHZXJ3TxztNF2U/OkCcoLrBSqCfwa8NRFmAgAD6aIA=
Date:   Mon, 27 Mar 2023 07:16:05 +0000
Message-ID: <959a5fed-c1c8-db21-5a05-963d0f9a999a@fi.rohmeurope.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <af8901957884c9c658be21ee89f837d5ca4ddac9.1679474247.git.mazziesaccount@gmail.com>
 <20230326171951.0e815ec3@jic23-huawei>
In-Reply-To: <20230326171951.0e815ec3@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2884:EE_
x-ms-office365-filtering-correlation-id: 63ae308a-0021-4d95-7c62-08db2e932144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jbcEbNgPJGwMib7k5/ShI2D61BXs4XR8NqAnFY9Qo3Kca3D8uzesVetm20auWJZS8yogy5MHB22l1unkFOgHhPvSvAoLd60fsPrX+bBaKNAGntGgMnLwA1rY1jPv908xturZAVe4l2X3QHyJR5r4Za+oTi3OHP1zzmn8oK3xBbNmtUY5uswdKSeIo82KkGNhNaD6EeVmD74Yv57a3IQRhLgfFinJJ6PNXaw/YJVozp2aROcbMF8wCqQdXUkdhRUCxjzpaJ+M5mys48jlLKO75z3CbEFqgQVc2GymEYI0NCDKfXcW70IlUkCR1aLB8+FB9KMYFGbZmnGx6AL6b8mAv2G5aBskxK0VIllKTF9uWJQEK7+K3C0kv0vJ/j1n5SGHe1EN3U9Wq+dVM2ABg5/mpjTV7nastgHLX+XERafMGHOx23KF3CGzaVZ79MTXsO386fQ02DVOlvXMRcNDmEYMN8qkWQjlj9QKYCdnX2chvqmHVck/2ZZd96thcoatzv4VK14LeVa3HYKp+SDRbOQPlcXYD2fcTRzTr6L871YxLx/yH2TYw7FgPwxmMevEJGcCwouThcGoK9fw1Mg8da/cL8CWvT6Qtg3OPpM239L5hvzhpjuUhoHSa2N3J2Bva8tcElBLgp1sLHo7HlZotxBcwC70O/6mloI0t0d8ZrHWGflpkk9GgCXkgUwpMl5d+3v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(451199021)(31686004)(83380400001)(31696002)(2906002)(86362001)(6486002)(186003)(110136005)(91956017)(316002)(71200400001)(54906003)(478600001)(64756008)(6512007)(38070700005)(2616005)(53546011)(38100700002)(122000001)(4326008)(8676002)(5660300002)(7416002)(66446008)(66946007)(76116006)(41300700001)(66476007)(66556008)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9rQjM4QWJYVWRJRXYveTRFOXVMOWozU0NVb21acG9lbG9Ua3hsWlJaMjI2?=
 =?utf-8?B?Z3doZ2svQmpwbFpoTmxPaktDeDkxQlhYTGU0S0RNeUpsbkhqazByTDFudkFx?=
 =?utf-8?B?ZFRxMWkzVjhCU3kyR3hORmlJTm5JL3hjNjdqZGxueGltbTdTUm1XNkJ4RFFE?=
 =?utf-8?B?VHJnVmJVMkJ6cXQ2c3Z6T3dRMCtBaTkrRzJEVGhEZWZHWUd3REUzekdiWUpj?=
 =?utf-8?B?ZThlNG96R1NoZEM5SjAxd1dXWEpJckFhaGtpNklmQWY1bkJVVG82NUFoZjFS?=
 =?utf-8?B?WUxzK25NeFVjTyswVzJacDdac1Q3ZkZPdUw0NmlxSnF6cFM1RXBwWDlaQVVZ?=
 =?utf-8?B?Qm8wSENlZEFZQ3IxNlRyTHNEd1JFV0xJZVdOSDVJQjlvSitPVGgzUElDOWlJ?=
 =?utf-8?B?elVDSk1xbEwraUhsNGVYMG1oR0dSUUNLRmhiQnlUZzlXNG9odGF5OXd0dmJl?=
 =?utf-8?B?c29VZUdFWXA4azNHVzJlN1VzV01IVXZnWVBYdTNnSTZSK1h6N01JTWhQalhG?=
 =?utf-8?B?V1QxbjVRSnVqN2F1cENDdk9FQWdjbHRyTGdkUnUzaUNaNjM2YVExV2pPQmcv?=
 =?utf-8?B?UFIrbEpiZHdSMWZOTkp1NldLd0tnYnB1QVFSK2ZjcHBHT1VlYy92YXhvNnp3?=
 =?utf-8?B?SW91UE1TWmdjU0JLOE93OURXa1BjYUtYRlpCU2EwTEJ6OXBrVVJwL0Y0UFM1?=
 =?utf-8?B?YkNOMWZlMlV2L2YwcXNhcHU5ZHZxWDVKcW5Ra2k1T0lyUUZtN1Vlb0xkQndn?=
 =?utf-8?B?NjB2YS9ObXFJeTExMU1NdGJQT3lDcG5hTmMwTTNZZWVpSkhJcSsxVVY5SVow?=
 =?utf-8?B?VkR1Q2JMeDgxbEZGQmNoN0owQWNZRXo0OFFud2YzZ3NXN1lhUW5saEdHUTdY?=
 =?utf-8?B?bDdIVzVyOHNscnlKVEI0OTBGdTdEOWgrQmxTOXh4K0VOOGxCdm00NDNIcFBS?=
 =?utf-8?B?b2ZMaTkvWVZKeWEyc1o2LzBFZ05tMUU3ZXA3WmFMcGV3WWszWjRMYmlkOXhP?=
 =?utf-8?B?OS9sRFU5UmhFVjk2d2FnRGp6RHNvMVQ5ZlIzYWtqdXFXR3N2RS9IRDVpakhJ?=
 =?utf-8?B?VG01bkxmT0ZSeTh3MHEycUJROG50bTF0cTdLNUhpTmlOZHpRSUZtMVJVTVoy?=
 =?utf-8?B?TGNVTVBHWXpaUUd2MERMNnlqa0JHbFplUU11U0dYY2F2YTJGbG5meUJvSmhV?=
 =?utf-8?B?VVlTZzZLbFk0MXBXMDZDZEVYOVJFbUVpYjUrcFBuQmt5ckZVcVAzUHMvdm5u?=
 =?utf-8?B?Wkxhd0lTcW5HMllmT044QnlQRTdWNVlqcjBObENXM1ZaWHd1eEQ5Ulc0Y0Rk?=
 =?utf-8?B?MGhNM2dxS3VyNXFXa2hrZ3ZhcDI2Y0lhWm5CQW5RRWxiWmkyR2p0eDZGV244?=
 =?utf-8?B?ZmVLNTVuSm9tejZaU3RlK3N0RFBzclZaQU1KcGF6eERvVG9CYjdaczZFMDNT?=
 =?utf-8?B?RmNzblpCQk1MZFdlRVZZSjNaa1A4a3h3RS9zenFBT1d6SmRvRkgyMlBKTUk0?=
 =?utf-8?B?allHVGZYOEtzeTlOaVoxQnZ6UkpyNXF2STdWblNYbVZKVUJFbWlmQ1BmZ3BQ?=
 =?utf-8?B?N2grUmN0MDUrYXBGNll0eVd6cnFtVkxNR3RnK1VHNmZuWTBCcnJFM3V6NHlY?=
 =?utf-8?B?WXpwb1pNWWU3Zi9wMUliL21XSG5sTk9veldXNEd0K1J5eHRMVGJVMGZDb2tO?=
 =?utf-8?B?RWY1ZzU2Zyt1NUhJK1JHYUlGa0F6c01MOVcvVnIvZ3Y4Z1ZsLytjRG9aZDVO?=
 =?utf-8?B?T3JyZm1HL055NTdyZHZENHhRaXVBYUowVGJvN2NwL0tkOVpROXY5enVMNlZD?=
 =?utf-8?B?dk9XdS9KVmtMODhkK1VhZFpWYVQzeU5zcThia2dQUWNPYTRudlVRMEtIWTdy?=
 =?utf-8?B?SEJMNnZaaVA3eFptTytVVFlseUROb3VMV05iMEpGRXI3SkE2bmFDY3dDMmtB?=
 =?utf-8?B?eDhudFhnSHh6UUlpOTVTZmhlaUhaRk1ya2ptTXE3eERINnFVYnpOWldXQlZB?=
 =?utf-8?B?RERmMmdiV3lYMzA0alpITyt1a2tCd3VtL3JzY2xiTldOYWpZTnRVbVhvWTV5?=
 =?utf-8?B?UHkweUdCYXY0MWIvQkE0T0hLZVNCQXR1amlmZHhuWUE3V3FoZmJjeFBmNDlt?=
 =?utf-8?B?blJZYVVNd1JkSTlxWFQ0ZDRDbmJJOG5HU1VsRlR0cEorNlp4MGNTZG1ISlYx?=
 =?utf-8?Q?+hgOHZ5DGMPc0ey/PFF/qp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D91E30AA109349BB5127CF9784CBAA@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ae308a-0021-4d95-7c62-08db2e932144
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 07:16:05.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iP09j+q1yl5FEFmvt0iXo+9BxRVyjIKbFKZsR03+elvnvvhWbWCQdUmK5nNNSjijLZfWuQxmQBw9ave2TfCcgaGG1u4lURBCSU8X9KrDA5XyZ/RLHdQI5QTui53RPDrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2884
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNi8yMyAxOToxOSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gV2VkLCAyMiBN
YXIgMjAyMyAxMTowNzo1NiArMDIwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gUk9ITSBCVTI3MDM0IGlzIGFuIGFtYmllbnQgbGln
aHQgc2Vuc29yIHdpdGggMyBjaGFubmVscyBhbmQgMyBwaG90byBkaW9kZXMNCj4+IGNhcGFibGUg
b2YgZGV0ZWN0aW5nIGEgdmVyeSB3aWRlIHJhbmdlIG9mIGlsbHVtaW5hbmNlLiBUeXBpY2FsIGFw
cGxpY2F0aW9uDQo+PiBpcyBhZGp1c3RpbmcgTENEIGFuZCBiYWNrbGlnaHQgcG93ZXIgb2YgVFZz
IGFuZCBtb2JpbGUgcGhvbmVzLg0KPj4NCj4+IEFkZCBpbml0aWFsICBzdXBwb3J0IGZvciB0aGUg
Uk9ITSBCVTI3MDM0IGFtYmllbnQgbGlnaHQgc2Vuc29yLg0KPj4NCj4+IE5PVEU6DQo+PiAJLSBE
cml2ZXIgZXhwb3NlcyA0IGNoYW5uZWxzLiBPbmUgSUlPX0xJR0hUIGNoYW5uZWwgcHJvdmlkaW5n
IHRoZQ0KPj4gCSAgY2FsY3VsYXRlZCBsdXggdmFsdWVzIGJhc2VkIG9uIG1lYXN1cmVkIGRhdGEg
ZnJvbSBkaW9kZXMgIzAgYW5kDQo+PiAJICAjMS4gSW4gYWRkaXRpb24sIDMgSUlPX0lOVEVOU0lU
WSBjaGFubmVscyBhcmUgZW1pdHRpbmcgdGhlIHJhdw0KPj4gCSAgcmVnaXN0ZXIgZGF0YSBmcm9t
IGFsbCBkaW9kZXMgZm9yIG1vcmUgaW50ZW5zZSB1c2VyLXNwYWNlDQo+PiAJICBjb21wdXRhdGlv
bnMuDQo+PiAJLSBTZW5zb3IgaGFzIEdBSU4gdmFsdWVzIHRoYXQgY2FuIGJlIGFkanVzdGVkIGZy
b20gMXggdG8gNDA5NnguDQo+PiAJLSBTZW5zb3IgaGFzIGFkanVzdGlibGUgbWVhc3VyZW1lbnQg
dGltZXMgb2YgNSwgNTUsIDEwMCwgMjAwIGFuZA0KPj4gCSAgNDAwIG1TLiBEcml2ZXIgZG9lcyBu
b3Qgc3VwcG9ydCA1IG1TIHdoaWNoIGhhcyBzcGVjaWFsDQo+PiAJICBsaW1pdGF0aW9ucy4NCj4+
IAktIERyaXZlciBleHBvc2VzIHN0YW5kYXJkICdzY2FsZScgYWRqdXN0bWVudCB3aGljaCBpcw0K
Pj4gCSAgaW1wbGVtZW50ZWQgYnk6DQo+PiAJCTEpIFRyeWluZyB0byBhZGp1c3Qgb25seSB0aGUg
R0FJTg0KPj4gCQkyKSBJZiBHQUlOIGFkanVzdG1lbnQgYWxvbmUgY2FuJ3QgcHJvdmlkZSByZXF1
ZXN0ZWQNCj4+IAkJICAgc2NhbGUsIGFkanVzdGluZyBib3RoIHRoZSB0aW1lIGFuZCB0aGUgZ2Fp
biBpcw0KPj4gCQkgICBhdHRlbXB0ZWQuDQo+PiAJLSBEcml2ZXIgZXhwb3NlcyB3cml0YWJsZSBJ
TlRfVElNRSBwcm9wZXJ0eSB0aGF0IGNhbiBiZSB1c2VkDQo+PiAJICBmb3IgYWRqdXN0aW5nIHRo
ZSBtZWFzdXJlbWVudCB0aW1lLiBUaW1lIGFkanVzdG1lbnQgd2lsbCBhbHNvDQo+PiAJICBjYXVz
ZSB0aGUgZHJpdmVyIHRvIHRyeSB0byBhZGp1c3QgdGhlIEdBSU4gc28gdGhhdCB0aGUNCj4+IAkg
IG92ZXJhbGwgc2NhbGUgaXMga2VwdCBhcyBjbG9zZSB0byB0aGUgb3JpZ2luYWwgYXMgcG9zc2li
bGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3Vu
dEBnbWFpbC5jb20+DQo+Pg0KPiBIaSBNYXR0aSwNCj4gDQo+IEEgZmV3IG1pbm9yIGNvbW1lbnRz
IGlubGluZS4gIEknbGwgdGFrZSBhIGNsb3NlciBsb29rIGF0IHRoZSByZXN0IG9mIHRoZQ0KPiBz
ZXJpZXMgd2hlbiB0aGUgZGlzY3Vzc2lvbnMgYXJvdW5kIHRoZSB0ZXN0cyBhbmQgZGV2aWNlcyB0
byBiZSB1c2VkDQo+IGZvciB0aGVtIHNldHRsZSBkb3duLg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gDQo+PiArDQo+PiArc3RhdGljIHU2NCBidTI3MDM0X2ZpeHBfY2FsY190MSh1
bnNpZ25lZCBpbnQgY29lZmYsIHVuc2lnbmVkIGludCBjaDAsDQo+PiArCQkJCXVuc2lnbmVkIGlu
dCBjaDEsIHVuc2lnbmVkIGludCBnYWluMCwNCj4+ICsJCQkJdW5zaWduZWQgaW50IGdhaW4xKQ0K
Pj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGhlbHBlciwgdG1wOw0KPj4gKwl1NjQgaGVscGVyNjQ7
DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIEhlcmUgd2UgY291bGQgb3ZlcmZsb3cgZXZlbiB0aGUg
NjRiaXQgdmFsdWUuIEhlbmNlIHdlDQo+PiArCSAqIG11bHRpcGx5IHdpdGggZ2FpbjAgb25seSBh
ZnRlciB0aGUgZGl2aXNpb25zIC0gZXZlbiB0aG91Z2gNCj4+ICsJICogaXQgbWF5IHJlc3VsdCBs
b3NzIG9mIGFjY3VyYWN5DQo+PiArCSAqLw0KPj4gKwloZWxwZXI2NCA9ICh1NjQpY29lZmYgKiAo
dTY0KWNoMSAqICh1NjQpY2gxOw0KPj4gKwloZWxwZXIgPSBjb2VmZiAqIGNoMSAqIGNoMTsNCj4+
ICsJdG1wID0gaGVscGVyICogZ2FpbjA7DQo+PiArDQo+PiArCWlmIChoZWxwZXIgPT0gaGVscGVy
NjQgJiYgKHRtcCAvIGdhaW4wID09IGhlbHBlcikpDQo+IA0KPiBTaW1pbGFyIHRvIGJlbG93LiAg
RG9uJ3QgYm90aGVyIHdpdGggdGhlIG5vbiA2NCBiaXQgdmVyc2lvbi4NCj4gDQo+PiArCQlyZXR1
cm4gdG1wIC8gKGdhaW4xICogZ2FpbjEpIC8gY2gwOw0KPj4gKw0KPj4gKwloZWxwZXIgPSBnYWlu
MSAqIGdhaW4xOw0KPj4gKwlpZiAoaGVscGVyID4gY2gwKSB7DQo+PiArCQlkb19kaXYoaGVscGVy
NjQsIGhlbHBlcik7DQo+PiArDQo+PiArCQlyZXR1cm4gZ2Fpbl9tdWxfZGl2X2hlbHBlcihoZWxw
ZXI2NCwgZ2FpbjAsIGNoMCk7DQo+PiArCX0NCj4+ICsNCj4+ICsJZG9fZGl2KGhlbHBlcjY0LCBj
aDApOw0KPj4gKw0KPj4gKwlyZXR1cm4gZ2Fpbl9tdWxfZGl2X2hlbHBlcihoZWxwZXI2NCwgZ2Fp
bjAsIGhlbHBlcik7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB1NjQgYnUyNzAzNF9maXhwX2Nh
bGNfdDIzKHVuc2lnbmVkIGludCBjb2VmZiwgdW5zaWduZWQgaW50IGNoLA0KPj4gKwkJCQkgdW5z
aWduZWQgaW50IGdhaW4pDQo+PiArew0KPj4gKwl1bnNpZ25lZCBpbnQgaGVscGVyOw0KPj4gKwl1
NjQgaGVscGVyNjQ7DQo+PiArDQo+PiArCWhlbHBlcjY0ID0gKHU2NCljb2VmZiAqICh1NjQpY2g7
DQo+PiArCWhlbHBlciA9IGNvZWZmICogY2g7DQo+PiArDQo+PiArCWlmIChoZWxwZXIgPT0gaGVs
cGVyNjQpDQo+PiArCQlyZXR1cm4gaGVscGVyIC8gZ2FpbjsNCj4+ICsNCj4+ICsJZG9fZGl2KGhl
bHBlcjY0LCBnYWluKTsNCj4+ICsNCj4+ICsJcmV0dXJuIGhlbHBlcjY0Ow0KPiANCj4gSSBzdXNw
ZWN0IHRoYXQgdGhpcyBpcyBhIHByZW1hdHVyZSBiaXQgb2Ygb3B0aW1pemF0aW9uIHNvIEknZCBq
dXN0DQo+IGRvIGl0IGluIDY0IGJpdHMgYWx3YXlzLg0KDQpQcm9iYWJseSBzby4NCg0KPiANCj4g
QWxzbywgaWYgeW91IGRpZCB3YW50IHRvIGRvIHRoaXMsIGNoZWNrX211bF9vdmVyZmxvdygpIGV0
YyB3b3VsZCBoZWxwLg0KPiAobGludXgvb3ZlcmZsb3cuaCkNCg0KVGhhbmtzISBJJ2xsIGNoZWNr
IHRoZSBvdmVyZmxvdy5oDQoNClRoZSBvbmx5IHJlYXNvbiB3aHkgSSBkaWQgaXQgbGlrZSB0aGlz
IGlzIHRoYXQgSSd2ZSBiZWVuIGJpdHRlbiBiYWRseSBieSANCnRoZSBkb19kaXYoKSBpbiB0aGUg
cGFzdC4gSXQgd2FzIGFjdHVhbGx5IHF1aXRlIGV4cGVuc2l2ZSBwYXltZW50IGZvciBhIA0KbGVz
c29uIGxlYXJudCAtIG15IGRvX2RpdigpIHVzYWdlIGVuZGVkIHVwIGluIGEgY3VzdG9tZXIgZGV2
aWNlcyBpbiB0aGUgDQpmaWVsZCAtIGFuZCB3aXRoIGEgYml0IG9mIGJhZCBsdWNrIHdlIGdvdCBh
IGh1Z2UgbnVtYmVyIHRvIGJlIGRpdmlkZWQgDQp3aXRoIGEgc21hbGwgb25lLi4uIEFuZCB0aGUg
ZG9fZGl2KCkgaW1wbGVtZW50YXRpb24gZm9yIHRoZSBhcmNoaXRlY3R1cmUgDQp3YXMgYSBsb29w
IHN1YnRyYWN0aW5nIHRoZSBkaXZpZGVyLg0KDQpUaGUgdGhpbmcgZW5kZWQgdXAgaGFsdGluZyB0
aGUgY3VzdG9tZXIgZGV2aWNlcyBmb3IgbWFueSBzZWNvbmRzLCANCm1lc3NpbmcgdXAgbG90cyBv
ZiB0aGluZ3MuIE9uIHRvcCBvZiB0aGF0IHRoZSBwcm9qZWN0IHdhcyBodWdlIC0gQW1vdW50IA0K
b2YgU1ctZGV2ZWxvcGVycyB3YXMgZm91ciBmaWd1cmVzLiBJdCB0b29rIHdlZWtzIHVudGlsIHRo
ZSBidWcgcmVwb3J0IA0KZm91bmQgaXQncyB3YXkgYWxzbyB0byBteSBkZXNrIC0gYXQgd2hpY2gg
cG9pbnQgSSBmaW5hbGx5IGZvdW5kIHRoZSANCm1pc3Rha2UgSSBoYWQgbWFkZS4uLiBBbmQgSSBk
aWRuJ3QgZmVlbCBwcm91ZCBvZiBpdCA6fA0KDQpBbmQgeWVzLCB3ZSBkb24ndCBwcmV2ZW50IHRo
ZSAiZGl2aWRlIGJpZyBudW1iZXIgYnkgYSB0aW55IG9uZSIgLSBpc3N1ZSANCmJ5IHRoaXMgY2hl
Y2sgaGVyZS4gT1RPSCwgSSB0aGluayBJIGRpZG4ndCBzZWUgdGhlIGxvb3AtYmFzZWQgZG9fZGl2
KCkgDQppbXBsZW1lbnRhdGlvbiBhbnltb3JlIGVpdGhlci4gSXQncyBqdXN0IHRoZSBoYWJpdCBv
ZiBvbmx5IHVzaW5nIA0KZG9fZGl2KCkgYXMgYSBsYXN0IHJlc29ydC4gQnV0IHllcywgd2UgcHJv
YmFibHkgY2FuIHVuY29uZGl0aW9uYWxseSB1c2UgDQp0aGUgZG9fZGl2KCkgaGVyZS4gSSdsbCBz
ZWUgd2hhdCB3ZSBoYXZlIGluIHRoZSBvdmVyZmxvdy5oIHRob3VnaC4NCg0KVGhhbmtzIGZvciB0
aGUgcmV2aWV3IGFnYWluIQ0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0
aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1
IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2Fu
IGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
