Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BF6C451D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCVIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCVIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:35:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD53B3F9;
        Wed, 22 Mar 2023 01:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPVTpN56iAeqPkeQWgqV7LD1W9u+iclFlLsGvj5GCkIkk6TBlhx2sDUCkbUGuTKicvg4VYMBlajTPqnOD+7pCArYWPHisMJ4JeKNtbMz4sA0c4fXt58BPXLusadpSsvEey0t9K2AoFsz9u1khQHqbJk0udNOqwesAVcWrpZN6cCk5yPPRTd0KTgwZUTiosufM9PtxJtpktGDEpMzddj2Cmy6SYfYJklG8qxid6OSk8CN6xueKVPWPnxP9eE5XbMsh815+x4okE8DoDrWeVKlZpZKYaJKvql2LnH0U97SDrwen238kMExobt6XYCwUFXxGdBbZA0WFT1y9gVH8QA5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrdsXt01tMUJs+Diy+FcdV4EJVbg4twiDG5en9dKFzg=;
 b=URoL3A/wj7l7SGo894Aun5YgMPEVyP2Q3zBuIp1U5C7KhR8Z3KznbZXSwR62JwZTdwLFVJavO0/ZvHPHd37HRiXEA5SwA9rhG4WSIIP8mjID3J8choCfCbfSiNXR2eD2T2KbxKbD3V/3dyg7R6P6zv+KM/C5yOVjN8cQ3yWwQmcOjXcZI8uP2sK6+abKxfr5kECQ7xNz4Ts63v3khR80hoeB32bj0CLHDg4IGK9ix/JGmxVFihrmzd3vWtFxPKqyO+ek6nkgn0yh7efFZEAvKWlRAqEn7JZAks11m4C/BLjdt8dCF6TrbH27qMz8owKudbCYDK8ktoVQBa5+qcQHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrdsXt01tMUJs+Diy+FcdV4EJVbg4twiDG5en9dKFzg=;
 b=QKQqXww6hZLOLuA4mNLo4uD8j0yLbBKTf2+KMg+DoNJaWYsKPFWzbv7FKIVeotxpB7iv0r7/O4TREyWIBUmDRsLcMaIn3Gw4yi0oLYimWHSOIWe/bPx+fnEXT2cSdEgGExHJrjYhFPG5ycJgPKbcop6unbkCCKCkttPc/kno0iEWHoAbGfce92FMO38Sb9526/FC6XMpkxZja/zcqQrn4IY4Z3J+9mPTntCWKkyubfYy85O4GzzxeqKrkAMqB8w2j6NopCQa5hOQJKl9Tkg9jjkhiiViXfJ+nwzlzKFUYHcosKrfaxEKWqwqf9XAZyKss4O6d5Cyevs5q9PdfqfNBw==
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 (2603:1096:820:11::14) by TY0PR06MB5005.apcprd06.prod.outlook.com
 (2603:1096:400:1ae::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 08:34:36 +0000
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa]) by KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 08:34:36 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
Thread-Topic: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
Thread-Index: AQHZWwQiNdRDdEacbEam/8sjEiRS5q8DaqAAgAABrZCAABDQAIAC8BbQ
Date:   Wed, 22 Mar 2023 08:34:36 +0000
Message-ID: <KL1PR0601MB3781185930057DB03293660B91869@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
 <20230320081133.23655-5-chiawei_wang@aspeedtech.com>
 <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
 <KL1PR0601MB37819E400753132F11F0202D91809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
 <a5b0d7d8-d78a-a12f-783-419713742d5@linux.intel.com>
In-Reply-To: <a5b0d7d8-d78a-a12f-783-419713742d5@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB3781:EE_|TY0PR06MB5005:EE_
x-ms-office365-filtering-correlation-id: 088da2a1-1085-491a-3240-08db2ab04544
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxWWtE8R5s63lSB8mGbU3vhvVok9IlgNxu2+ZrCO+O8NKOjjtrDVg/YjojWQBOAi1/a6mTnxzBg9cPXczyh4qvD4BRyfIWm6pi8JCH8F6ZEGwm0GOMugcELaoevsxPs5B7VgPdQhjYUCzk/3xFvNXkGNRrXXuGi2zQXkrW2xXhEe4Os/yvun7EAat8HEwI0Mlr46BOyTDYOD3k3ojRbQG9iYDU35NwLkSirNnJJPiljJSVdyNm2vtY785XvZZRjKsntikVNbokpjOR+LW1qBKYDFBs1Kj5o5R9iuRI9/Dw5jGIZh4d0y5EkrNGs1UITBw2YBtivNiSuiXpUsg60gA8OzcNaKYzJRBQJGGlRxZGAdH9irB5Ky/AY2Jw+f96WsM+7KAuxOxa8iDbwMNKjbPHFKJYkuD7Su1/o9IUva8KodhYvS92Hpf/a2bWPd/9ugdnHEAEgqlxM3xBBbn0k95s9D30vH+geaEmoBXfU/d8AfKxlHd0eF25d4130YoM0yvcAkirMLs3v1+2Je+whycoykAQayVGTPlCmp9asBWMKh/i3nW5l3TRDhfep0WvQEhgnTVKqI4byI4m+0Dgou0WgsNJAMecCPMMFQHdizBuN1+o4AWPH45NbRBqcIpOSeAtXQFl3JTNSLHGmt5vpKHJnxxp3MKwLJl6CNh2Ct0nQEMnOcnDhCdnvsczDFj5abqkvkva40ySYaKyRBHC5TrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB3781.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(136003)(39850400004)(366004)(451199018)(122000001)(71200400001)(38100700002)(7696005)(478600001)(7416002)(5660300002)(54906003)(66899018)(38070700005)(86362001)(66446008)(316002)(33656002)(66946007)(4326008)(6916009)(8676002)(66556008)(66476007)(64756008)(76116006)(66574015)(9686003)(8936002)(55016003)(41300700001)(26005)(2906002)(6506007)(52536014)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNuTHhXWHJCSjNsU0twd1Rld282UHNWelJGQUl2WXBiVU1sUkt5elNHUUJK?=
 =?utf-8?B?dTJjazZXVzFXdFBPZFRjTkY3REZwZzVCT25YMENla2dzZld2VDFDdDVmSG1Z?=
 =?utf-8?B?a0hnb2wvdFRsYi9uV2REb1hRdmdPK1plV3VVYjNxUXplc2RzYkdIM2Q5UUV6?=
 =?utf-8?B?UmtwVDIvYVM0UVJyYTNNaXlwaUZ6NXBOWER4ZGpCSEovR2hYSFZlcUZxZlBW?=
 =?utf-8?B?eTEzdjh2cjc0UXJFS2pBRklVWXhzMkVFUlJ5MXVTRDZVTnNWMHZUbllxbm1M?=
 =?utf-8?B?YlQwOTB1NHo5QitWc2dFOThCWWRSclJ2NWRycWVObWdCV1ZkVXhsWXpMalNR?=
 =?utf-8?B?dGVYSmJVa0h1SW0rYzg1WGc2RTY2MEVDd2FyTkx0U05QTjhacWVXaFlsaTVh?=
 =?utf-8?B?Vi92Sys4UFpqYjhKUzBmWit2WEcwc1pqV1JkclhsMy9QSXpFZ2srbldWSFVw?=
 =?utf-8?B?U2NPbnFYY3p6bjV6WHJGL0hwejZDbEo3NVVkMFVST0NSWGVNV3Ywc1lKUzI0?=
 =?utf-8?B?WC9xNzVGcHVERVpKeDFXVjJ5RXB6aDkyUkVuWlhpMzJBS01ZZVdKMUxSTDN5?=
 =?utf-8?B?YzlTZmk0aXdjUmRvSlYrNHEwUHFhSEVSYUIrWlE5RzI4aHBGdmNTVjFYU0or?=
 =?utf-8?B?S1I3ZXhFaGhxWVp1dmtJa3k0NVplSWcvMUh4czhMMTcrWGp6RktrN2VReCtJ?=
 =?utf-8?B?UVljVlZHUUdZbTR6NGFVa3YrMmVlMUxNUFlrQklMUzZSVkZFL1VBZ1QxblQ3?=
 =?utf-8?B?M3VmUnk0a0d5SXQrYTYzeTVxY1Znc1NBaDJwQVdpWHBTaW8wSWh2bFg3R25R?=
 =?utf-8?B?dy8wSTJVWGN3VkQ3MkprRkY2UE9HaHRmQ0pYbEFPQW5PeHNnQ1EwWUV6M0xU?=
 =?utf-8?B?Tngxald4NmwrUUliTFVpRnZTaWRrdHZEVlJjZEVnVG5vb1ZrbVBQMXJjTGJj?=
 =?utf-8?B?cSthbS80Ni9qK3A4b3l3ZlJTeHZXa0p6N0RzaHFxdk1ORFFvVzY3d3F1N21r?=
 =?utf-8?B?RGE4L0U4OG92ZnJINVkwRFFtTHd0dFFNNHlJWFRQZzd4VVo0RmZIVUljNC9x?=
 =?utf-8?B?cU1tdll3Ui9HQ0JUT1Z5U2hJVFRJc1ZBc3pybEFmYUdrb3UyRU1ubkRmTHU4?=
 =?utf-8?B?dktRQkxiVyt4MWRyd2pSTTJNRFhFYmVQT2lPTkVRVjc5UDhmdjNxSjEwNjdp?=
 =?utf-8?B?TjZBSWhmb1Zia2VLdWthUzk5NzV2eDBhYXhmdUtmMnQvRGFhT0xUK0tNaDJY?=
 =?utf-8?B?dlYrZGUrN3Z3WlVUbWtoRkR4eG0wcXJBRlA2V2JUaTZFY1V3c0VUOE5OY1d4?=
 =?utf-8?B?YXIyZTZaSHJHdDZkOHJFb0sveTBiUFJlL3AyaHM5ZVJzTlRWOVFEWk9HU3VH?=
 =?utf-8?B?azcyZlA3c1AwV0RLbXBtODNRTGRYRTJ0WjdNU3lxVTBPRkxqSHNDNk5sVjFj?=
 =?utf-8?B?OVIyYXh6VWlUK2dSUWZFZmRORmRRTVRCTEF1MXl4OGVlL2V2aCtBb1d1dkNv?=
 =?utf-8?B?R2gwakt2SVllZ2QyUW9lT2J3OXZVMHRWYi8ydkV6Wmd1MUljNHhrQStYRHFI?=
 =?utf-8?B?K0MyUG9IT3lkbVpRQWNNT2lYdGlCMUVnSzNRVXY5dFJjV1FVeForNVQ4SHdB?=
 =?utf-8?B?UkVjMG5VNnlLbEFGN2xzdmpaNk9EdUxXWHNjaUtJSkxKYmRRaURmUFZ5Q1pq?=
 =?utf-8?B?Z2g3VHUzdEdiTUtGL0FhTGhXc0phU2V0QXo1MDEvYjJnWDhDblRyL2RhRnhN?=
 =?utf-8?B?TEcvcTYyUGFSRGUzZ0lHWHcxMTRtOHF2VFllL0lvWVFoMDlWQVgvenU0c3Vk?=
 =?utf-8?B?bkkyL1hSWDRNYlZhVUpLSlhaNU1nZUVtNWZCYjVidUVBYTlqeTBzM01mU0lz?=
 =?utf-8?B?ck1PZlliRHUwdHVTTzdrUER6aVFrTUhEU1d4bFhWUUttM09VelJ1NG9oR092?=
 =?utf-8?B?TkVLMm1LT2l2dmpCakNpTmZXWlFuYTlvb0ZqQmN2V1VkZlZ5OHBtUEQya0kr?=
 =?utf-8?B?UEhIelFiWHZQemdUbk5TcDNlREtaTWhsdks4eHVmOEI5bXFsUmYxTFllU01K?=
 =?utf-8?B?cU9BN0dKbVdmdEZRdnBzQmRwTWJDK00vUVBmY3NTOGdIR2dDalBmOWUwWGhT?=
 =?utf-8?B?ZTV4dlFNT2RlNHJTWk16bElWaE5VRG5IRG5tamRnek5JUXZqYmd6cUpnWkNO?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB3781.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088da2a1-1085-491a-3240-08db2ab04544
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 08:34:36.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BWVO92vNWBs63XeeROXZd+tBicafdjti96QK0wlgufmTf6fupcmFhHaMvyI1KxqPPh+tM3F/QvVylb96QkJDJ3o/wQOuunwNhERvJPXQys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5005
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjAsIDIwMjMgNjo0OSBQTQ0KPiANCj4gT24gTW9uLCAyMCBN
YXIgMjAyMywgQ2hpYVdlaSBXYW5nIHdyb3RlOg0KPiANCj4gPiA+IEZyb206IElscG8gSsOkcnZp
bmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwg
TWFyY2ggMjAsIDIwMjMgNTo0MyBQTQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjAgTWFyIDIwMjMs
IENoaWEtV2VpIFdhbmcgd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBBZGQgbmV3IFVBUlQgZHJpdmVy
IHdpdGggRE1BIHN1cHBvcnQgZm9yIEFzcGVlZCBBU1QyNjAwIFNvQ3MuDQo+ID4gPiA+IFRoZSBk
cml2ZXJzIG1haW5seSBwcmVwYXJlIHRoZSBkbWEgaW5zdGFuY2UgYmFzZWQgb24gdGhlIDgyNTBf
ZG1hDQo+ID4gPiA+IGltcGxlbWVudGF0aW9uIHRvIGxldmVyYWdlIHRoZSBBU1QyNjAwIFVBUlQg
RE1BIChVRE1BKSBlbmdpbmUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEt
V2VpIFdhbmcgPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZC5jIHwgMjI0DQo+ID4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvS2NvbmZpZyAgICAgICB8ICAgOCArDQo+ID4gPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC9NYWtlZmlsZSAgICAgIHwgICAxICsNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjMzIGlu
c2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBkcml2ZXJzL3R0eS9zZXJp
YWwvODI1MC84MjUwX2FzcGVlZC5jDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZC5jDQo+ID4gPiA+IGIvZHJpdmVycy90dHkv
c2VyaWFsLzgyNTAvODI1MF9hc3BlZWQuYw0KPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjA0ZDBiZjZmYmEyOA0KPiA+ID4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfYXNwZWVk
LmMNCj4gPiA+ID4gQEAgLTAsMCArMSwyMjQgQEANCj4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogQ29weXJpZ2h0IChD
KSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gKyNpbmNsdWRl
IDxsaW51eC9kZXZpY2UuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3Nl
cmlhbF84MjUwLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvc2VyaWFsX3JlZy5oPg0KPiA+
ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2Zf
aXJxLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiA+ID4g
KyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4gI2luY2x1ZGUgPGxpbnV4L2Nsay5o
Pg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+ICNpbmNsdWRlIDxsaW51eC9kbWEt
bWFwcGluZy5oPiAjaW5jbHVkZQ0KPiA+ID4gPiArPGxpbnV4L2NpcmNfYnVmLmg+ICNpbmNsdWRl
IDxsaW51eC90dHlfZmxpcC5oPiAjaW5jbHVkZQ0KPiA+ID4gPiArPGxpbnV4L3BtX3J1bnRpbWUu
aD4NCj4gPiA+ID4gKw0KPiA+ID4gPiArI2luY2x1ZGUgIjgyNTAuaCINCj4gPiA+ID4gKw0KPiA+
ID4gPiArI2RlZmluZSBERVZJQ0VfTkFNRSAiYXNwZWVkLXVhcnQiDQo+ID4gPiA+ICsNCj4gPiA+
ID4gK3N0cnVjdCBhc3Q4MjUwX2RhdGEgew0KPiA+ID4gPiArCWludCBsaW5lOw0KPiA+ID4gPiAr
CWludCBpcnE7DQo+ID4gPiA+ICsJdTggX19pb21lbSAqcmVnczsNCj4gPiA+ID4gKwlzdHJ1Y3Qg
cmVzZXRfY29udHJvbCAqcnN0Ow0KPiA+ID4gPiArCXN0cnVjdCBjbGsgKmNsazsNCj4gPiA+ID4g
KyNpZmRlZiBDT05GSUdfU0VSSUFMXzgyNTBfRE1BDQo+ID4gPiA+ICsJc3RydWN0IHVhcnRfODI1
MF9kbWEgZG1hOw0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4g
PiA+ICsjaWZkZWYgQ09ORklHX1NFUklBTF84MjUwX0RNQQ0KPiA+ID4gPiArc3RhdGljIGludCBh
c3Q4MjUwX3J4X2RtYShzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnApOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICtzdGF0aWMgdm9pZCBhc3Q4MjUwX3J4X2RtYV9jb21wbGV0ZSh2b2lkICpwYXJhbSkgew0K
PiA+ID4gPiArCXN0cnVjdCB1YXJ0XzgyNTBfcG9ydCAqcCA9IHBhcmFtOw0KPiA+ID4gPiArCXN0
cnVjdCB1YXJ0XzgyNTBfZG1hICpkbWEgPSBwLT5kbWE7DQo+ID4gPiA+ICsJc3RydWN0IHR0eV9w
b3J0ICp0dHlfcG9ydCA9ICZwLT5wb3J0LnN0YXRlLT5wb3J0Ow0KPiA+ID4gPiArCXN0cnVjdCBk
bWFfdHhfc3RhdGUJc3RhdGU7DQo+ID4gPiA+ICsJaW50CWNvdW50Ow0KPiA+ID4gPiArDQo+ID4g
PiA+ICsJZG1hZW5naW5lX3R4X3N0YXR1cyhkbWEtPnJ4Y2hhbiwgZG1hLT5yeF9jb29raWUsICZz
dGF0ZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwljb3VudCA9IGRtYS0+cnhfc2l6ZSAtIHN0YXRl
LnJlc2lkdWU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwl0dHlfaW5zZXJ0X2ZsaXBfc3RyaW5nKHR0
eV9wb3J0LCBkbWEtPnJ4X2J1ZiwgY291bnQpOw0KPiA+ID4gPiArCXAtPnBvcnQuaWNvdW50LnJ4
ICs9IGNvdW50Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJdHR5X2ZsaXBfYnVmZmVyX3B1c2godHR5
X3BvcnQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJYXN0ODI1MF9yeF9kbWEocCk7DQo+ID4gPiA+
ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgYXN0ODI1MF9yeF9kbWEoc3RydWN0
IHVhcnRfODI1MF9wb3J0ICpwKSB7DQo+ID4gPiA+ICsJc3RydWN0IHVhcnRfODI1MF9kbWEgKmRt
YSA9IHAtPmRtYTsNCj4gPiA+ID4gKwlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0b3IgKnR4
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJdHggPSBkbWFlbmdpbmVfcHJlcF9zbGF2ZV9zaW5nbGUo
ZG1hLT5yeGNoYW4sIGRtYS0+cnhfYWRkciwNCj4gPiA+ID4gKwkJCQkJIGRtYS0+cnhfc2l6ZSwg
RE1BX0RFVl9UT19NRU0sDQo+ID4gPiA+ICsJCQkJCSBETUFfUFJFUF9JTlRFUlJVUFQgfCBETUFf
Q1RSTF9BQ0spOw0KPiA+ID4gPiArCWlmICghdHgpDQo+ID4gPiA+ICsJCXJldHVybiAtRUJVU1k7
DQo+ID4gPg0KPiA+ID4gSG93IGRvZXMgdGhlIERNQSBSeCAibG9vcCIgcmVzdGFydCB3aGVuIHRo
aXMgaXMgdGFrZW4/DQo+ID4NCj4gPiBUaGUgbG9vcCByZS1zdGFydHMgZnJvbSBhc3Q4MjUwX3N0
YXJ0dXAuDQo+IA0KPiBXaHkgd291bGQgc3RhcnR1cCBnZXQgY2FsbGVkIGFnYWluPw0KDQpTb3Jy
eSBmb3IgbWlzbGVhZGluZywgaXQgcmVsaWVzIG9uIGhhbmRsZV9yeF9kbWEgdGhhdCByZXN0YXJ0
cyB0aGUgbG9vcA0KDQpJZiBVRE1BIHN1ZGRlbmx5IHNodXRkb3duLCBSWCBkYXRhIHN0YXlzIGlu
IFVBUlQgRklGTyBhbmQgdGh1cyB0cmlnZ2VycyBhbiBpbnRlcnJ1cHQuDQpUaGUgSVNSIGNhbGwg
Y2hhaW4sIHNlcmlhbDgyNTBfaGFuZGxlX2lycSAtPiBoYW5kbGVfcnhfZG1hLCB3aWxsIHJlc3Rh
cnRzIHRoZSBVRE1BIGxvb3AuDQoNCkhvd2V2ZXIsIGJlZm9yZSBVRE1BIGlzIHJlc3RhcnRlZCwg
dGhlcmUgaXMgYSB3aW5kb3cgc3VmZmVyaW5nIHRoZSBzYW1lIG92ZXJydW4gaXNzdWUgYXMgbWVu
dGlvbmVkIGJlZm9yZS4NCkkgdGhpbmsgbWFrZSB0aGUgZGVmYXVsdCBjb2RlIHN1cHBvcnQgIlJY
IERNQSBBTyAoQWx3YXlzIE9uKSIgaXMgY2VydGFpbiB0byBhdm9pZCBwcm9kdWNpbmcgbW9yZSBk
dXBsaWNhdGVkIGNvZGUgd2l0aCBsaXR0bGUgY3VzdG9taXphdGlvbnMuDQoNCj4gDQo+ID4gPiA+
ICsJdHgtPmNhbGxiYWNrID0gYXN0ODI1MF9yeF9kbWFfY29tcGxldGU7DQo+ID4gPiA+ICsJdHgt
PmNhbGxiYWNrX3BhcmFtID0gcDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWRtYS0+cnhfY29va2ll
ID0gZG1hZW5naW5lX3N1Ym1pdCh0eCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlkbWFfYXN5bmNf
aXNzdWVfcGVuZGluZyhkbWEtPnJ4Y2hhbik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4g
MDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4NCj4gPiA+IFRoZXNlIDIgZnVu
Y3Rpb25zIGxvb2sgdmVyeSBzaW1pbGFyIHRvIHdoYXQgODI1MF9kbWEgb2ZmZXJzIGZvciB5b3Uu
DQo+ID4gPiBUaGUgb25seSBkaWZmZXJlbmNlIEkgY291bGQgc2VlIGlzIHRoYXQgYWx3YXlzIHN0
YXJ0IERNQSBSeCB0aGluZw0KPiA+ID4gd2hpY2ggY291bGQgYmUgaGFuZGxlZCBieSBhZGRpbmcg
c29tZSBjYXBhYmlsaXR5IGZsYWcgaW50bw0KPiA+ID4gdWFydF84MjUwX2RtYSBmb3IgdGhvc2Ug
VUFSVHMgdGhhdCBjYW4gbGF1bmNoIERNQSBSeCB3aGlsZSBSeCBxdWV1ZSBpcw0KPiBlbXB0eS4N
Cj4gPiA+DQo+ID4gPiBTbywganVzdCB1c2UgdGhlIHN0YW5kYXJkIDgyNTBfZG1hIGZ1bmN0aW9u
cyBhbmQgbWFrZSB0aGUgc21hbGwNCj4gPiA+IGNhcGFiaWxpdGllcyBmbGFnIHR3ZWFrIHRoZXJl
Lg0KPiA+ID4NCj4gPiA+IEJ5IHVzaW5nIHRoZSBzdG9jayBmdW5jdGlvbnMgeW91IGFsc28gYXZv
aWQgODI1MF9kbWEgUnggYW5kIHlvdXIgRE1BDQo+ID4gPiBSeCByYWNpbmcgbGlrZSB0aGV5IGN1
cnJlbnRseSB3b3VsZCAoODI1MF9wb3J0IGFzc2lnbnMgdGhlIGZ1bmN0aW9ucw0KPiA+ID4gZnJv
bSA4MjUwX2RtYSB3aGVuIHlvdSBkb24ndCBzcGVjaWZ5IHRoZSByeCBoYW5kbGVyIGFuZCB0aGUg
ZGVmYXVsdA0KPiA+ID4gODI1MCBpcnEgaGFuZGxlciB3aWxsIGNhbGwgaW50byB0aG9zZSBzdGFu
ZGFyZCA4MjUwIERNQSBmdW5jdGlvbnMpLg0KPiA+DQo+ID4gWWVzIGZvciB0aGUgZGlmZmVyZW5j
ZSBkZXNjcmliZWQuDQo+ID4NCj4gPiBPdXIgY3VzdG9tZXJzIHVzdWFsbHkgdXNlIFVETUEgZm9y
IGZpbGUtdHJhbnNtaXNzaW9ucyBvdmVyIFVBUlQuDQo+ID4gQW5kIEkgZm91bmQgdGhlIHByZWNl
ZGluZyBieXRlcyB3aWxsIGdldCBsb3N0IGVhc2lseSBkdWUgdG8gdGhlIGxhdGUNCj4gPiBzdGFy
dCBvZiBETUEgZW5naW5lLg0KPiA+DQo+ID4gSW4gZmFjdCwgSSB3YXMgc2Vla2luZyB0aGUgZGVm
YXVsdCBpbXBsZW1lbnRhdGlvbiB0byBhbHdheXMgc3RhcnQgUlgNCj4gPiBETUEgaW5zdGVhZCBv
ZiBlbmFibGluZyBpdCB1cG9uIERSIGJpdCByaXNpbmcuIEJ1dCBubyBsdWNrIGFuZCB0aHVzDQo+
ID4gYWRkIGFzdDgyNTBfcnhfZG1hLiAoVGhlIGRlZmF1bHQgODI1MCBJU1IgYWxzbyBjYWxsZWQg
aW50bw0KPiA+IHVwLT5kbWEtPnJ4X2RtYSkNCj4gPg0KPiA+IElmIGFkZGluZyBhIG5ldyBjYXBh
YmlsaXR5IGZsYWcgaXMgdGhlIGJldHRlciB3YXkgdG8gZ28sIEkgd2lsbCB0cnkgdG8NCj4gPiBp
bXBsZW1lbnQgaW4gdGhhdCB3YXkgZm9yIGZ1cnRoZXIgcmV2aWV3Lg0KPiANCj4gWWVzIGl0IHdv
dWxkIGJlIG11Y2ggYmV0dGVyLg0KPiANCj4gQWRkIHVuc2lnbmVkIGludCBjYXBhYmlsaXRpZXMg
aW50byB1YXJ0XzgyNTBfZG1hIGFuZCBwdXQgdGhlIG5lY2Vzc2FyeQ0KPiBjaGVja3MgKyBjb2Rl
IGludG8gZ2VuZXJhbCBjb2RlLiBEb24ndCBhZGQgYW55ICNpZmRlZg0KPiBDT05GSUdfU0VSSUFM
XzgyNTBfRE1BIGludG8gODI1MF9wb3J0LmMgbm9yIDgyNTBfZG1hLmMuIEluc3RlYWQsIGlmIHlv
dQ0KPiBmZWVsIGEgbmVlZCBmb3Igb25lLCB1c2UgdGhlICNpZmRlZiAuLi4gI2Vsc2UgLi4uICNl
bmRpZiBpbiA4MjUwLmggdG8gcHJvdmlkZSBhbg0KPiBlbXB0eSBzdGF0aWMgaW5saW5lIGZ1bmN0
aW9uIGZvciB0aGUgI2Vsc2UgY2FzZS4NCj4gDQoNCkdvdCBpdC4gSSB3aWxsIGdldCB0aGUgcGF0
Y2ggcHJlcGFyZWQgZm9yIHlvdXIgcmV2aWV3IGluIHY0IHJldmlzaW9uLg0KDQo+ID4gPiBJJ20g
Y3VyaW91cyBhYm91dCB0aGlzIEhXIGFuZCBob3cgaXQgYmVoYXZlcyB1bmRlciB0aGVzZSB0d28g
c2NlbmFyaW9zOg0KPiA+ID4gLSBXaGVuIFJ4IGlzIGVtcHR5LCBkb2VzIFVBUlQvRE1BIGp1c3Qg
c2l0IHRoZXJlIHdhaXRpbmcgZm9yZXZlcj8NCj4gPg0KPiA+IFllcy4NCj4gDQo+IE9rYXkuDQo+
IA0KPiA+ID4gLSBXaGVuIGEgc3RyZWFtIG9mIGluY29taW5nIFJ4IGNoYXJhY3RlcnMgc3VkZGVu
bHkgZW5kcywgaG93IGRvZXMNCj4gPiA+IFVBUlQvRE1BDQo+ID4gPiAgIHJlYWN0PyAuLi5PbiA4
MjUwIFVBUlRzIEknbSBmYW1pbGlhciB3aXRoIHRoaXMgdHJpZ2dlcnMNCj4gVUFSVF9JSVJfVElN
RU9VVA0KPiA+ID4gICB3aGljaCB5b3UgZG9uJ3Qgc2VlbSB0byBoYW5kbGUuDQo+ID4NCj4gPiBV
RE1BIGFsc28gaGFzIGEgdGltZW91dCBjb250cm9sLg0KPiA+IElmIHRoZSBkYXRhIHN1ZGRlbmx5
IGVuZHMgYW5kIHRpbWVvdXQgb2NjdXJzLCBVRE1BIHdpbGwgdHJpZ2dlciBhbg0KPiBpbnRlcnJ1
cHQuDQo+ID4gVURNQSBJU1IgdGhlbiBjaGVjayBpZiB0aGVyZSBpcyBkYXRhIGF2YWlsYWJsZSB1
c2luZyBETUEgcmVhZC93cml0ZQ0KPiA+IHBvaW50ZXJzIGFuZCBpbnZva2VzIGNhbGxiYWNrIGlm
IGFueS4NCj4gDQo+IE9rYXkuIEFuZCB0aGUgVUFSVCBzaWRlIHdvbid0IHRyaWdnZXIgYW55IGlu
dGVycnVwdHM/DQoNClVBUlQgc2lkZSBzdGlsbCB0cmlnZ2VycyBpbnRlcnJ1cHRzLg0KDQpIb3dl
dmVyLCBmb3IgUlggZGF0YSwgVURNQSBrZWVwIHBvbGxpbmcgRFIgYml0IGFuZCByZWFkIHRoZSBk
YXRhIG91dCBmcm9tIFVBUlQgRklGTy4NClRodXMgd2hlbiBzZXJpYWw4MjUwX2hhbmRsZV9pcnEg
SVNSIGNoZWNrcyBJSVIsIGl0IGdldHMgbm8gaW50ZXJydXB0IHBlbmRpbmcgYXMgZGF0YSBoYXMg
YmVlbiB0YWtlbi4NClRoZSBJU1Igd2lsbCByZXR1cm4gaWYgbm8gb3RoZXIgZXZlbnRzLg0KDQo+
IA0KPiA+ID4gV2hlbiB5b3UgcHJvdmlkZSBhbnN3ZXIgdG8gdGhvc2UgdHdvIHF1ZXN0aW9ucywg
SSBjYW4gdHJ5IHRvIGhlbHANCj4gPiA+IHlvdSBmdXJ0aGVyIG9uIGhvdyB0byBpbnRlZ3JhdGUg
aW50byB0aGUgc3RhbmRhcmQgODI1MCBETUEgY29kZS4NCj4gPg0KPiA+IFRoYW5rcyENCj4gPiBJ
dCB3b3VsZCBiZSBncmVhdCB1c2luZyB0aGUgZGVmYXVsdCBvbmUgdG8gYXZvaWQgbW9zdGx5IGR1
cGxpY2F0ZWQgY29kZS4NCj4gDQo+IFlvdSBuZWVkIHRvIHRha2UgYSBsb29rIGludG8gaGFuZGxl
X3J4X2RtYSgpIHdoYXQgdG8gZG8gdGhlcmUuIFByb2JhYmx5IGp1c3QNCj4gY2FsbCB0byAtPnJ4
X2RtYSgpIHVuY29uZGl0aW9uYWxseSB0byBwcmV2ZW50IFVBUlQgaW50ZXJydXB0cyBmcm9tIG1l
c3NpbmcgdXANCj4gd2l0aCBETUEgUnguIFRoaXMgcmVzdGFydCBmb3IgRE1BIFJ4IGlzIGp1c3Qg
Zm9yIGJhY2t1cCBpZiB0aGUgRE1BIFJ4ICJsb29wIg0KPiBzdG9wcGVkIGR1ZSB0byBhbiBlcnJv
ci4NCg0KWWVzLiBBIG5ldyBpZi1jb25kaXRpb24gdG8gc3VwcG9ydCAiUlggRE1BIEFPIiBzaG91
bGQgYmUgbmVlZGVkLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGZlZWRiYWNrLg0KSSB3
aWxsIG1vdmUgb24gdG8gdjQgcmV2aXNpb24gd2l0aCBkZWZhdWx0IGNvZGUgbW9kaWZpY2F0aW9u
Lg0KDQpSZWdhcmRzLA0KQ2hpYXdlaQ0K
