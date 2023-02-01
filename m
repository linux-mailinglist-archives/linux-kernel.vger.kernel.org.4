Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B096866A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBANRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjBANQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:46 -0500
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2864D87
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:16:43 -0800 (PST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id C033941C37;
        Wed,  1 Feb 2023 08:16:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1675257397;
        bh=AusAuhXHLUUHzyxjH+XzP/mPhj0Am3eHT17pQqkxeZ0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EKEK0dVbDMJgTlZkgMxIe5Dc6aw4XzNmf+SKMoohcYHpopbUb7t/mh0wGhsldkNX/
         FITS4x0HCZzZe26/2u9tMPBNjHW6osLhDVYE1ZwNRVRSFVaJHcpCV2+EPSIXIo4NqR
         t+O31uDLskLpcZiXVQsgpf8wCZyWbht0jUhInrqcTgl++qwGkj6TOvcpQIxrmVdnVm
         D4X5z8FuQJ6gk0XUx1LN2GCnvk2hUcStbj42evsYHGCo9ctpHJLfxLJRFptky9H9wx
         AeqVeArOIRHL+jKEa4sSdmzjfoWfrXAezLUW4xyJkORzD/Lo6ck3dWpDX4V1tuMd0v
         OU9R/YwnMJkTA==
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjgnH9+JYPr4h+4lCdVg4FGkT7G+/3ZrqLRj+My37KPVJcbrJhdyquyhOF7wRuDKBVJEYP0FxGQsdZfAXMd4/G/gl5cqHdtJoQNk2UbYrb8QbttTCKq7Wmjv9jd8tKDfMoLESnv8ONj7/d7WTNyqA2Gen8rZI654wI2OJD/l3DMUW7yFhDno2TmFEvdm2Ev0zvzI/FVfsxdKLpxqU+7CKu7dMq9MeJJDGvbp2GrTP5m5Wm/7RIpuZEJi9yNySu8UkSrLTh8enlUvPaIVaMW79WJf0xWxzodqO0jraGL0T5mzWllvzTx5LN36Xwt4t31+fWaZg4S/fxHFW0i4D/c4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AusAuhXHLUUHzyxjH+XzP/mPhj0Am3eHT17pQqkxeZ0=;
 b=QoMzKBbXoJS0tkgrCMMgq4ch07MY1G+gjw8NhrmtZ5ogwu/jDvG7O9zKEKtTKIdi1NCAFawZU6Hz1HQ8igRlVFub+MxqUqEsQKWx3L8CnBHkAPTcM6QQzYD2M3VAfaT/9oMxPfQ98e7ccXtuigaTIPonGz7Knq/ojKD5Bb5Yp1HONkYD57hDBqllGVNwK4QcM+x/0hLiM3hSts9DcXeDKf7XSKloxvlZAw7uSdtjKFb8F/OqwFdzG8QN2FemXfyUku44cLehoU7ysNM+NFezxrwuub520AShmurFLzS08qlYPvelnH/eMIa5yKMeucbAaOTH+VWgzh2xp80Z9lAD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=veeam.com; dmarc=pass action=none header.from=veeam.com;
 dkim=pass header.d=veeam.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 DM6PR14MB3388.namprd14.prod.outlook.com (2603:10b6:5:1ee::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Wed, 1 Feb 2023 13:16:29 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::4af6:fd64:925:e3b4]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::4af6:fd64:925:e3b4%8]) with mapi id 15.20.6002.026; Wed, 1 Feb 2023
 13:16:29 +0000
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Mike Snitzer <snitzer@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Thread-Topic: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Thread-Index: AQHZC9njQhPExPGzik6+OOTOrKe/8665iB8AgAENSwA=
Date:   Wed, 1 Feb 2023 13:16:29 +0000
Message-ID: <DM8PR14MB52210D6056B32061C629E5CEF5D19@DM8PR14MB5221.namprd14.prod.outlook.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
 <Y9mrJJDFnMNWR7Vn@redhat.com>
In-Reply-To: <Y9mrJJDFnMNWR7Vn@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DS7PR14MB6905.namprd14.prod.outlook.com
 (15.20.6064.010)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|DM6PR14MB3388:EE_
x-ms-office365-filtering-correlation-id: 65c7ef75-65ce-4aa5-f8ab-08db0456878b
x-veeam-mmex: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhXP8N/EGVLplhpNq8mlkjfrnqpi2BasG/+ikoC6EO/jWr2OlPYW+luypFUTvc3qPTWC8AWywCMPKdTrISp1LskQsExWlZWOrMmaSbd5uD7HGYJxjbEbytQ/S0fM8S3FEvQfN2HjsKpna0isgYQzyM9R2cT1/mRjLLRz1bCXXMtY0YksVWJvzAX1XmFsRiWxKwNt65N1T2VF30hJl9Pj+EmhgptkuEpdCRnYbh5PffngfpzSe+7wL15xLSH9LM0yZHaUrARdYUjgj7xv90dmMWeXL1jA+pF7awESfCaF3KkFT5dUq9EXM1xmuscAxX0hhAYVal2pP5DpAXvloI3hI5tfbpXkpt1qlcLMh2Lj5B5dEMYT6QwCXFmQRFp6g/icPvUNI6P1X5A6HsLOS63YZGmUVqHNWOlTS+Q0gZn5KnKzF6OjSqxoeoL8/5pi+lXRRZsNGM1GqmWyBVfp/WhYdygRrFB7V+U3OcX6SLKk31PPmVjFn+m5/xHCBFzw38d+c9S6sPpVGz3Cr+i3DIK5owaPCXys8y5Fs3fZCaNj69ju1ybziqDFYEVaas1TZ9N+Hrrb2Y3fpJw69Gtkc4iQT+Dwsome+ikZ8o4Z5nkFn1ttL096Le5axaAJB6wmgMOv8BnGApaofskSTXGXu6rAlmUI2U9n912M8T3ll/4XCktwxR3IjubTHhsvnkoBGrKHvH334gcaw46iWTLPYpaCLY7QpdvH40yJ/aJ2kvQaVWxm8GLK6RhdVXQESHBB82UwJujLuR05jz/sG+qy9BozdTeVVM4Rg6IBosTx9nYnm/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199018)(41300700001)(122000001)(64756008)(6916009)(66946007)(54906003)(316002)(8676002)(4326008)(66476007)(8936002)(66446008)(66556008)(76116006)(5660300002)(52536014)(38100700002)(86362001)(33656002)(38070700005)(6506007)(66899018)(186003)(9686003)(966005)(26005)(53546011)(71200400001)(2906002)(55016003)(44832011)(7696005)(83380400001)(478600001)(65966003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xWVjVnMmtUdElWOVFDV1ZTM1pjUWRCOC8yNCtIREMvZFBLR2t0VG5abFBD?=
 =?utf-8?B?MVdyUzVvQVJoZlpHNzNZdjN1bWFXK0xCcm5tTzNmVTByNVc1aUI3TXp4SGhr?=
 =?utf-8?B?YTZZSDFUaStwZkdMOVlGZVZrdlRZeDVXdDNva1NVa3N0V2xsWTdvMlRTSFQz?=
 =?utf-8?B?Q2FPTk5PcWJENytDL1N3ZVRvYk1ITmp3QktoY1d5TERobXJqNHFyQnJCdjlM?=
 =?utf-8?B?RW1VVms1VW9sQTUwMlcwYTRacWtzRFBNSlhXaDJzUW9hOWVxdXVNdjZjdGN0?=
 =?utf-8?B?S0J5Zkk4T3pVdEIzUzFqRDVjK0ZUUitjMWtVbU8vVm1ITWxsc3JxdW56ZjhI?=
 =?utf-8?B?Y0did1RCZCtWVzJwTUtDNm1FWDZVRGxvN3I5UFVhTkVDL3laUXlZOW1zcGJm?=
 =?utf-8?B?Snp5dUZCZm1Ncm91aTlrR1gzL2xldHJxYkxxaG9jQmIyeHZYakVGeUQ3Yy9R?=
 =?utf-8?B?QlNNZ1I5LzFNK0lrOTFHSk1vYzcvSnFzZ2NzWGg3cHYweFRVNy9vOWhKQnNx?=
 =?utf-8?B?NDJVTzMrM1MrTVByVlNKb081K2k5cHdNSkVkYVlxUWhHdjBCRDM3SmlTYkNv?=
 =?utf-8?B?NGVUUnJQanZkSS8zbjBMekt1RkptQUFUMHQzc1g1d1U0NkdFZDYxRmxjZ3lK?=
 =?utf-8?B?WGhPWkJKZDNScUxYY0ZEbzUrdXZoWnVCNmdDNzVqeHZFN1NSMTBERDhoNDRt?=
 =?utf-8?B?L0Z2d1c3QWh1a0RzREFCL1l3ZW5UbWN4Q1lyWnVpU0dtK1Q2ZCtyZllvN2pM?=
 =?utf-8?B?M1N4eXhlNjFoc1FXQkl1YXh1UnlmbEM5WW9MYU1NL1huQnUzYlVIYkNCakVV?=
 =?utf-8?B?a1BKK3huUWFrWVV2cDRRa2ZyRS9sVlBPV1V4MmhycVk2amxVaC94dHYrWUJD?=
 =?utf-8?B?b3p6ZHpQSVAxUnJ4eWhKYmUwT3VLOSttT0krN3RCMUFPbEdqWUFmL2FrU2Ja?=
 =?utf-8?B?djhBWkR5L01QYWNsSUlMbkp4R1gxNGxFM29Gc0Q3WGdseDVPblBoSWhMODNI?=
 =?utf-8?B?M0RLcEgyNFE2TjlYNTFuWUNZL1FnTHllYXlocE40Y2JGTno3MzdhOFEzVDFY?=
 =?utf-8?B?d2xpMXdHVDZ6K2k2cmtDSXlQT0dXM2VuQWlpM2dJMFV6blYzbEM3RkR1RGVF?=
 =?utf-8?B?QlZjKzZUcWtKUzk1L015NWZ1Q0xkRkVZV2granhkY3I0TlZPbDlCUGVGMi9y?=
 =?utf-8?B?NDlwWitwZ2s3M1RWVU9NWHp3bkhLMzBacWlHZ2Ryd2pJNDBkOW14UFdnZUNK?=
 =?utf-8?B?WW5scTZEUElYUGsvUDQ5c1dUeXRvQkd2VDdFdHFwSTgvcCtLb0cweXpiMUUy?=
 =?utf-8?B?UFFEbDFidmRzcjE0M1BUaDRHOUc1NERXWHU5Z0hwa0t2cWp6dmFMZk8zVjZU?=
 =?utf-8?B?TEZsQnZWQm5jOHBHaUJiUnBGUWk4WWxYSXJXTkxmWU9iM0lPTDRNd1ROZjY1?=
 =?utf-8?B?UU9WcVVJWFdvV3FsNHNxYmlCSUhTb0NsTDhvYWpQdjNHY3d5M0xYMCtGakNW?=
 =?utf-8?B?a21hRWxCU0RVMTZrVTZTT0RxcUtUNnB3ZlkyZkZwNE1iOElmQzNGWjhPR2ky?=
 =?utf-8?B?K0ZPY0QzZ0NIRlJLa2tVQWVQY3FRMGFSMWRJelV6WDRseHg1ZENFbHVGcHRD?=
 =?utf-8?B?Y083YkJvUjViNWFhS2s5Z3ZWdGg1Wm9BRjhRQllhQkRsYVVOUkJKdDZIMWhv?=
 =?utf-8?B?Mlk0N2xKOERIbys4QnhGWitRQjJWNVdVNFhRY0p3ZDVwYVRhS0V6R21ITkZu?=
 =?utf-8?B?blNORHQ2VlZwMW9TRTY5R3E3UVpweUplNWVsMEM5S3ArZ2t4ditwSHBDQnNq?=
 =?utf-8?B?dzBQc2Vpem4wR1B6N0xYZkhselZLKzMwU2ZLNHQ5VGlJRWFxVjFVUW5kVk5W?=
 =?utf-8?B?eWFhSFEzb1gwNzhxVXJhZjFyTDM1TSswNnk3RjF0cVhDSUx1YjllbC83V2E4?=
 =?utf-8?B?N25UdEtaUmZyV3hraUNkSWVYTWhpay9kRm9kNlFzeWl2S1ZvOEVibnNNaEdB?=
 =?utf-8?B?Uk5mb1V2QktkVlN3NmoySUwvSUFjRm5XbGkrNFFOMkR3bGV2WXd6TFZQWFlL?=
 =?utf-8?B?Ri9vd0ZWdjgxYktHS0xMU0FrUmNxRU5PalBpdk1FZ242aGVPK3R2QTFmK1hy?=
 =?utf-8?Q?1IlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90B6F7CCB8C1614F8B050CC51FA58D3B@VeeamSoftwareCorp.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: veeam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR14MB5221.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c7ef75-65ce-4aa5-f8ab-08db0456878b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 13:16:29.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba07baab-431b-49ed-add7-cbc3542f5140
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AL1q6t6IKWhR4V3t955s4D7VDrrzUJ9+76ixpnXDZjcaTflVbzmBePGbxdzViFHh9jQkW5/Ctzj0Rx9TJXT4+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR14MB3388
Authentication-Results: mx1.veeam.com;
        dkim=pass header.d=veeam.com header.s=mx1-2022 header.b=EKEK0dVb;
        dmarc=pass (policy=reject) header.from=veeam.com;
        spf=pass (mx1.veeam.com: domain of sergei.shtepa@veeam.com designates 104.47.59.168 as permitted sender) smtp.mailfrom=sergei.shtepa@veeam.com;
        arc=pass ("microsoft.com:s=arcselector9901:i=1")
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyLzEvMjMgMDA6NTgsIE1pa2UgU25pdHplciB3cm90ZToNCj4gU3ViamVjdDoNCj4gUmU6
IFtQQVRDSCB2MiAwMi8yMV0gYmxvY2ssIGJsa2ZpbHRlcjogQmxvY2sgRGV2aWNlIEZpbHRlcmlu
ZyBNZWNoYW5pc20NCj4gRnJvbToNCj4gTWlrZSBTbml0emVyIDxzbml0emVyQGtlcm5lbC5vcmc+
DQo+IERhdGU6DQo+IDIvMS8yMywgMDA6NTgNCj4gDQo+IFRvOg0KPiBTZXJnZWkgU2h0ZXBhIDxz
ZXJnZWkuc2h0ZXBhQHZlZWFtLmNvbT4NCj4gQ0M6DQo+IGF4Ym9lQGtlcm5lbC5kaywgY29yYmV0
QGx3bi5uZXQsIGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZywgbGludXgtZG9jQHZnZXIua2Vy
bmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgZG0tZGV2ZWxAcmVkaGF0LmNv
bQ0KPiANCj4gDQo+IE9uIEZyaSwgRGVjIDA5IDIwMjIgYXQgIDk6MjNQIC0wNTAwLA0KPiBTZXJn
ZWkgU2h0ZXBhIDxzZXJnZWkuc2h0ZXBhQHZlZWFtLmNvbT4gd3JvdGU6DQo+IA0KPj4gQWxsb3dz
IHRvIGF0dGFjaCBibG9jayBkZXZpY2UgZmlsdGVycyB0byB0aGUgYmxvY2sgZGV2aWNlcy4gS2Vy
bmVsDQo+PiBtb2R1bGVzIGNhbiB1c2UgdGhpcyBmdW5jdGlvbmFsaXR5IHRvIGV4dGVuZCB0aGUg
Y2FwYWJpbGl0aWVzIG9mIHRoZQ0KPj4gYmxvY2sgbGF5ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogU2VyZ2VpIFNodGVwYSA8c2VyZ2VpLnNodGVwYUB2ZWVhbS5jb20+DQo+PiAtLS0NCj4+ICBi
bG9jay9iZGV2LmMgICAgICAgICAgICAgIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+ICBibG9jay9ibGstY29yZS5jICAgICAgICAgIHwgMTkgKysrKysrKysr
LS0NCj4+ICBpbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIHwgIDIgKysNCj4+ICBpbmNsdWRlL2xp
bnV4L2Jsa2Rldi5oICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmRldi5jIGIvYmxvY2svYmRldi5jDQo+PiBp
bmRleCBkNjk5ZWNkYjMyNjAuLmI4MjAxNzg4MjRiMiAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2Jk
ZXYuYw0KPj4gKysrIGIvYmxvY2svYmRldi5jDQo+PiBAQCAtNDI3LDYgKzQyNyw3IEBAIHN0YXRp
YyB2b2lkIGluaXRfb25jZSh2b2lkICpkYXRhKQ0KPj4gIA0KPj4gIHN0YXRpYyB2b2lkIGJkZXZf
ZXZpY3RfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4+ICB7DQo+PiArCWJkZXZfZmlsdGVy
X2RldGFjaChJX0JERVYoaW5vZGUpKTsNCj4+ICAJdHJ1bmNhdGVfaW5vZGVfcGFnZXNfZmluYWwo
Jmlub2RlLT5pX2RhdGEpOw0KPj4gIAlpbnZhbGlkYXRlX2lub2RlX2J1ZmZlcnMoaW5vZGUpOyAv
KiBpcyBpdCBuZWVkZWQgaGVyZT8gKi8NCj4+ICAJY2xlYXJfaW5vZGUoaW5vZGUpOw0KPj4gQEAg
LTUwMiw2ICs1MDMsNyBAQCBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2X2FsbG9jKHN0cnVjdCBn
ZW5kaXNrICpkaXNrLCB1OCBwYXJ0bm8pDQo+PiAgCQlyZXR1cm4gTlVMTDsNCj4+ICAJfQ0KPj4g
IAliZGV2LT5iZF9kaXNrID0gZGlzazsNCj4+ICsJYmRldi0+YmRfZmlsdGVyID0gTlVMTDsNCj4+
ICAJcmV0dXJuIGJkZXY7DQo+PiAgfQ0KPj4gIA0KPj4gQEAgLTEwOTIsMyArMTA5NCw3MSBAQCB2
b2lkIGJkZXZfc3RhdHhfZGlvYWxpZ24oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGtzdGF0
ICpzdGF0KQ0KPj4gIA0KPj4gIAlibGtkZXZfcHV0X25vX29wZW4oYmRldik7DQo+PiAgfQ0KPj4g
Kw0KPj4gKy8qKg0KPj4gKyAqIGJkZXZfZmlsdGVyX2F0dGFjaCAtIEF0dGFjaCB0aGUgZmlsdGVy
IHRvIHRoZSBvcmlnaW5hbCBibG9jayBkZXZpY2UuDQo+PiArICogQGJkZXY6DQo+PiArICoJQmxv
Y2sgZGV2aWNlLg0KPj4gKyAqIEBmbHQ6DQo+PiArICoJRmlsdGVyIHRoYXQgbmVlZHMgdG8gYmUg
YXR0YWNoZWQgdG8gdGhlIGJsb2NrIGRldmljZS4NCj4+ICsgKg0KPj4gKyAqIEJlZm9yZSBhZGRp
bmcgYSBmaWx0ZXIsIGl0IGlzIG5lY2Vzc2FyeSB0byBpbml0aWFsaXplICZzdHJ1Y3QgYmRldl9m
aWx0ZXINCj4+ICsgKiB1c2luZyBhIGJkZXZfZmlsdGVyX2luaXQoKSBmdW5jdGlvbi4NCj4+ICsg
Kg0KPj4gKyAqIFRoZSBiZGV2X2ZpbHRlcl9kZXRhY2goKSBmdW5jdGlvbiBhbGxvd3MgdG8gZGV0
YWNoIHRoZSBmaWx0ZXIgZnJvbSB0aGUgYmxvY2sNCj4+ICsgKiBkZXZpY2UuDQo+PiArICoNCj4+
ICsgKiBSZXR1cm46IDAgaWYgc3VjY2VlZGVkLCBvciAtRUFMUkVBRFkgaWYgdGhlIGZpbHRlciBh
bHJlYWR5IGV4aXN0cy4NCj4+ICsgKi8NCj4+ICtpbnQgYmRldl9maWx0ZXJfYXR0YWNoKHN0cnVj
dCBibG9ja19kZXZpY2UgKmJkZXYsDQo+PiArCQkJCSAgICAgc3RydWN0IGJkZXZfZmlsdGVyICpm
bHQpDQo+PiArew0KPj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsNCj4+ICsJYmxrX21xX2ZyZWV6ZV9x
dWV1ZShiZGV2LT5iZF9xdWV1ZSk7DQo+PiArCWJsa19tcV9xdWllc2NlX3F1ZXVlKGJkZXYtPmJk
X3F1ZXVlKTsNCj4+ICsNCj4+ICsJaWYgKGJkZXYtPmJkX2ZpbHRlcikNCj4+ICsJCXJldCA9IC1F
QUxSRUFEWTsNCj4+ICsJZWxzZQ0KPj4gKwkJYmRldi0+YmRfZmlsdGVyID0gZmx0Ow0KPj4gKw0K
Pj4gKwlibGtfbXFfdW5xdWllc2NlX3F1ZXVlKGJkZXYtPmJkX3F1ZXVlKTsNCj4+ICsJYmxrX21x
X3VuZnJlZXplX3F1ZXVlKGJkZXYtPmJkX3F1ZXVlKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsN
Cj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTChiZGV2X2ZpbHRlcl9hdHRhY2gpOw0KPj4gKw0KPj4g
Ky8qKg0KPj4gKyAqIGJkZXZfZmlsdGVyX2RldGFjaCAtIERldGFjaCB0aGUgZmlsdGVyIGZyb20g
dGhlIGJsb2NrIGRldmljZS4NCj4+ICsgKiBAYmRldjoNCj4+ICsgKglCbG9jayBkZXZpY2UuDQo+
PiArICoNCj4+ICsgKiBUaGUgZmlsdGVyIHNob3VsZCBiZSBhZGRlZCB1c2luZyB0aGUgYmRldl9m
aWx0ZXJfYXR0YWNoKCkgZnVuY3Rpb24uDQo+PiArICoNCj4+ICsgKiBSZXR1cm46IDAgaWYgc3Vj
Y2VlZGVkLCBvciAtRU5PRU5UIGlmIHRoZSBmaWx0ZXIgd2FzIG5vdCBmb3VuZC4NCj4+ICsgKi8N
Cj4+ICtpbnQgYmRldl9maWx0ZXJfZGV0YWNoKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpDQo+
PiArew0KPj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsJc3RydWN0IGJkZXZfZmlsdGVyICpmbHQgPSBO
VUxMOw0KPj4gKw0KPj4gKwlibGtfbXFfZnJlZXplX3F1ZXVlKGJkZXYtPmJkX3F1ZXVlKTsNCj4+
ICsJYmxrX21xX3F1aWVzY2VfcXVldWUoYmRldi0+YmRfcXVldWUpOw0KPj4gKw0KPj4gKwlmbHQg
PSBiZGV2LT5iZF9maWx0ZXI7DQo+PiArCWlmIChmbHQpDQo+PiArCQliZGV2LT5iZF9maWx0ZXIg
PSBOVUxMOw0KPj4gKwllbHNlDQo+PiArCQlyZXQgPSAtRU5PRU5UOw0KPj4gKw0KPj4gKwlibGtf
bXFfdW5xdWllc2NlX3F1ZXVlKGJkZXYtPmJkX3F1ZXVlKTsNCj4+ICsJYmxrX21xX3VuZnJlZXpl
X3F1ZXVlKGJkZXYtPmJkX3F1ZXVlKTsNCj4+ICsNCj4+ICsJaWYgKGZsdCkNCj4+ICsJCWJkZXZf
ZmlsdGVyX3B1dChmbHQpOw0KPj4gKw0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICtFWFBP
UlRfU1lNQk9MKGJkZXZfZmlsdGVyX2RldGFjaCk7DQo+IFdoYXQgYWJvdXQgYmlvLWJhc2VkIGRl
dmljZXM/IChETSwgTUQsIGV0YykNCj4gDQo+IERNIHVzZXMgZnJlZXplX2JkZXYoKSBhbmQgdGhh
d19iZGV2KCksIHNlZW1zIGxpa2UgeW91J3JlIG1pc3Npbmcgc29tZQ0KPiB3b3JrIGhlcmUuDQoN
ClRoYW5rcywgTWlrZS4NCg0KV2UgYXJlIHBsYW5uaW5nIHRvIGFkZCBhIGZyZWV6ZV9iZGV2KCkg
ZnVuY3Rpb24gY2FsbCBpbiBiZGV2X2ZpbHRlcl9hdHRhY2goKS4NCkJ1dCBmb3IgdGhlIGJkZXZf
ZmlsdGVyX2RldGFjaCgpIGZ1bmN0aW9uLCBpdCBkb2Vzbid0IHNlZW0gdG8gbWFrZSBzZW5zZS4N
CkkgdGhpbmsgZW5vdWdoIHRvIGNhbGwgYmxrX21xX2ZyZWV6ZV9xdWV1ZSgpLg0KDQpBcyBGYWJp
byBhbHJlYWR5IHdyb3RlLCBJIHVzZSBhIHB1YmxpYyByZXBvc2l0b3J5IG9uIGdpdGh1YiB0byB3
b3JrIHdpdGgNCnRoZSBwYXRjaDogaHR0cHM6Ly9naXRodWIuY29tL1NlcmdlaVNodGVwYS9saW51
eC9jb21taXRzL2Jsa3NuYXAtbWFzdGVyDQpUaGUgY3VycmVudCBzdGF0ZSBjYW4gYmUgdmlld2Vk
IHRoZXJlLiBGZWVkYmFjayBpcyB3ZWxjb21lIGFzIHVzdWFsLg0KDQo+IA0KPj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jDQo+PiBpbmRleCA1NDg3OTEy
YmVmZTguLjI4NGIyOTVhN2IyMyAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2Jsay1jb3JlLmMNCj4+
ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4+IEBAIC02NzgsOSArNjc4LDI0IEBAIHZvaWQgc3Vi
bWl0X2Jpb19ub2FjY3Rfbm9jaGVjayhzdHJ1Y3QgYmlvICpiaW8pDQo+PiAgCSAqIHRvIGNvbGxl
Y3QgYSBsaXN0IG9mIHJlcXVlc3RzIHN1Ym1pdGVkIGJ5IGEgLT5zdWJtaXRfYmlvIG1ldGhvZCB3
aGlsZQ0KPj4gIAkgKiBpdCBpcyBhY3RpdmUsIGFuZCB0aGVuIHByb2Nlc3MgdGhlbSBhZnRlciBp
dCByZXR1cm5lZC4NCj4+ICAJICovDQo+PiAtCWlmIChjdXJyZW50LT5iaW9fbGlzdCkNCj4+ICsJ
aWYgKGN1cnJlbnQtPmJpb19saXN0KSB7DQo+PiAgCQliaW9fbGlzdF9hZGQoJmN1cnJlbnQtPmJp
b19saXN0WzBdLCBiaW8pOw0KPj4gLQllbHNlIGlmICghYmlvLT5iaV9iZGV2LT5iZF9kaXNrLT5m
b3BzLT5zdWJtaXRfYmlvKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmIChi
aW8tPmJpX2JkZXYtPmJkX2ZpbHRlciAmJiAhYmlvX2ZsYWdnZWQoYmlvLCBCSU9fRklMVEVSRUQp
KSB7DQo+IFNob3VsZG4ndCB0aGlzIGJlOiBpZiAodW5saWtlbHkoLi4uKSk/DQo+IA0KPiBCdXQg
dGhhdCBvYnZpb3VzbHkgYXNzdW1lcyBhIGZhaXIgYW1vdW50IGFib3V0IHRoZSBvbmx5IGNvbnN1
bWVyDQo+ICh0ZW1wb3JhcnkgZmlsdGVyIHRoYXQgbGFzdHMgYXMgbG9uZyBhcyBpdCB0YWtlcyB0
byBkbyBhIGJhY2t1cCkuDQoNClllcywgYXQgdGhlIG1vbWVudCB0aGUgY29kZSBpcyBiZWluZyBj
cmVhdGVkIHNvIHRoYXQgb25seSBvbmUgZmlsdGVyDQppcyBwb3NzaWJsZS4gSW4gdGhlIHN1bW1l
ciwgSSBvZmZlcmVkIGEgbW9yZSBjb21wbGV4IHNvbHV0aW9uLCBpbiB3aGljaA0KdGhlcmUgd2Vy
ZSBhbHRpdHVkZXMuIFNlZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzE2
NTUxMzU1OTMtMTkwMC0yLWdpdC1zZW5kLWVtYWlsLXNlcmdlaS5zaHRlcGFAdmVlYW0uY29tLw0K
QnV0IHRoaXMgaXMgcmVkdW5kYW50IGNvZGUgZm9yIHRoaXMgdGFzayBhdCB0aGUgbW9tZW50LCBz
aW5jZSBvbmx5DQpvbmUgZmlsdGVyIGlzIG9mZmVyZWQgbm93LiBJIHRoaW5rIGl0IHdpbGwgYmUg
cG9zc2libGUgdG8gaW1wbGVtZW50DQpzb21ldGhpbmcgc2ltaWxhciBsYXRlci4NCg0KPiANCj4+
ICsJCWJvb2wgcGFzczsNCj4+ICsNCj4+ICsJCXBhc3MgPSBiaW8tPmJpX2JkZXYtPmJkX2ZpbHRl
ci0+Zm9wcy0+c3VibWl0X2Jpb19jYihiaW8pOw0KPj4gKwkJYmlvX3NldF9mbGFnKGJpbywgQklP
X0ZJTFRFUkVEKTsNCj4+ICsJCWlmICghcGFzcykgew0KPj4gKwkJCWJpby0+Ymlfc3RhdHVzID0g
QkxLX1NUU19PSzsNCj4+ICsJCQliaW9fZW5kaW8oYmlvKTsNCj4+ICsJCQlyZXR1cm47DQo+PiAr
CQl9DQo+PiArCX0NCj4+ICsNCj4+ICsJaWYgKCFiaW8tPmJpX2JkZXYtPmJkX2Rpc2stPmZvcHMt
PnN1Ym1pdF9iaW8pDQo+PiAgCQlfX3N1Ym1pdF9iaW9fbm9hY2N0X21xKGJpbyk7DQo+PiAgCWVs
c2UNCj4+ICAJCV9fc3VibWl0X2Jpb19ub2FjY3QoYmlvKTsNCj4gQW5kIHlvdSBjdXJyZW50bHkg
ZG9uJ3QgYWxsb3cgZm9yIGJsa2ZpbHRlciB0byBiZSBpbnZvbHZlZCBpZiBhIGJpbw0KPiByZWN1
cnNlcyAod2hpY2ggaXMgaG93IGJpbyBzcGxpdHRpbmcgd29ya3Mgbm93KS4gIE5vdCBzdXJlIGl0
DQo+IG1hdHRlcnMsIGp1c3QgbWVudGlvbmluZyBpdC4uLg0KPiANCj4gQnV0IHRha2luZyBhIHN0
ZXAgYmFjaywgaW4gdGhlIGhvcGVzIG9mIHN0ZXBwaW5nIG91dCBvZiB5b3VyIHdheToNCj4gDQo+
IE15c2VsZiBhbmQgb3RoZXJzIG9uIHRoZSBETSB0ZWFtIChwYXN0IGFuZCBwcmVzZW50KSBoYXZl
IGFsd2F5cyBob3BlZA0KPiBhbGwgYmxvY2sgZGV2aWNlcyBjb3VsZCBoYXZlIHRoZSBmbGV4aWJp
bGl0eSBvZiBETS4gSXQgd2FzIHRoYXQgaG9wZQ0KPiB0aGF0IGNhdXNlZCBteSBmcnVzdHJhdGlv
biB3aGVuIEkgZmlyc3Qgc2F3IHlvdXIgYmxrZmlsdGVyIGFwcHJvYWNoLg0KPiANCj4gQnV0IEkg
d2FzIHRvbyBpZGVhbGlzdGljIHRoYXQgYSBieXByb2R1Y3Qgb2YgeW91ciBlZmZvcnRzDQo+IChi
bGstaW50ZXJwb3NlciBiZWZvcmUgYW5kIGJsa2ZpbHRlciBub3cpIHdvdWxkIHVzaGVyIGluIF9h
bGxfIGJsb2NrDQo+IGRldmljZXMgYmVpbmcgYWJsZSB0byBjb21wcmVoZW5zaXZlbHkgY2hhbmdl
IHRoZWlyIGlkZW50aXR5IChhbmQgSU8NCj4gcHJvY2Vzc2luZykgbGlrZSBETSBlbmpveXMuDQo+
IA0KPiBETSBzaG93Y2FzZXMgYWxsIHRoZSBleHRyYSBjb2RlIG5lZWRlZCB0byBhY2hpZXZlIGl0
cyBleHRyZW1lIElPDQo+IHJlbWFwcGluZyBhbmQgc3RhY2tpbmcgZmxleGliaWx0eSAtLSBJIGRv
bid0IHlldCBzZWUgYSB3YXkgdG8gZGlzdGlsbA0KPiB0aGUgZXNzZW5jZSBvZiB3aGF0IERNIGFj
aGlldmVzIHdpdGhvdXQgaW1wb3NpbmcgdG9vIG11Y2ggb24gYWxsIGJsb2NrDQo+IGNvcmUuDQo+
IA0KPiBTbyBJIGRvIHRoaW5rIGJsa2ZpbHRlciBpcyBhIHByYWdtYXRpYyB3YXkgdG8gYWNoaWV2
ZSB5b3VyIGdvYWxzLg0KPiANCj4gTWlrZQ0KPiANCg==
