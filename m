Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6D7495F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjGFGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjGFGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:52:00 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61051BD3;
        Wed,  5 Jul 2023 23:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OevxMgUU1jrzFDzFyZw4H9oWlmdRKOXEqKUkwRQWvFWlWx6brRDeTmsUWxNgwS3Jd9aGiAu2STcwc4krwT18SiN0PBg/ueh+R3hB9Umu/OZXgAx3fyj1HZy6IiCFzw6vFFTj8M+XMY2NEUJUcP/Ptb7EgtFMz4/auayesn1JJ5thKhs20XBf9ZNguYqv5WPk/1nxGghibGsAt+Gs3s1G7Jv8pTaxSmc/HFWpxjD0qDZDCNflLN3krRxD6M+21g/pTfKP+zxo10DBJEaZqSiK0RZdS0imoFGso3CpzBd1EktKCESbGBsRaV3N1zQX2/z4iR4BcW9WnXD9hmtgUE4mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4qPY/cKDxdE4Sk+5x8cIu+k+Kj8NGxLE9QqhEat10I=;
 b=f1pOkuLeBnyFqPb/2M6OVpkE/QWS6jptCKTXgOy3sA6RB90y+KOhiLNFy8wda5/xur9xEhx5KM7sgZ/fJ9nEBM+jv2aAtjtGC13/DOCGiJ4WxKw/2UB2VqCiT6sjp+FxbYua0wOK1NCwefk7gGYXXIgGLtEkHO0gt7rD/pecTUOurDPr2LBv+hVokRMq2ZP/R1T5ETaP67J5owh8FYS5BAGuGDQOqnkEJNcRZjyEQfzZmMEQ8KmUPmrrWih4VXemvSHZyaYBgldsKA6fpbjXak/h3VV2Zo9sqImGZtzNp0m1oUkl2NtkWVa282GKFHvImZkYLkscpx5dTBeqzW7LXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4qPY/cKDxdE4Sk+5x8cIu+k+Kj8NGxLE9QqhEat10I=;
 b=zqp8KE2yw6AtTUy+2JHdMLwzDySLEpELAFH+/iwJoGYCR46kzIHNFblCX70jM931E6ZyuEdF5MLxmomQpoeK6wpXbKNzdeSbXNSSBrE9mZ5RTek5Jll1LE84Cc3R7yWbBKDaVeSiSgA7sUWuqJ7UmNB6kmdqMXCHNWbw6yquPvUdi8wE2H9mJWbIdkdxO8K5VBvEh0+D2/yujI4iUzugYCvsOJBkEb6vjhIaWAHx6S2MwqUbMCYdVjUd8DEFfcYm3h4UKhYgp+a1LYWgGvid2P3taavTsi4CAAUE9IkYiRlu47q5XcJ7AvoomOB9zxNcTtwnUTLFLERce8mTBBg5Tw==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by GV1PR10MB5865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 06:51:51 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 06:51:51 +0000
From:   "Haener, Michael" <michael.haener@siemens.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Topic: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Index: AQHZrkUWBZBED1bC10u9HajfJFJci6+pMsAAgAEQEwCAAg1QAA==
Date:   Thu, 6 Jul 2023 06:51:51 +0000
Message-ID: <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
         <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
In-Reply-To: <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|GV1PR10MB5865:EE_
x-ms-office365-filtering-correlation-id: fa6cdb2a-205a-4f52-7b55-08db7ded7a34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRNTbKw2hP4scnkqRCCXvA4OkuwWjarWxbpBcypXjksavBNuoGXRec3HsmKfaUv9pOjDV+DN23vzmCYQmU15zU5+U6uULKxDQz2XzTN5vnQZXIxiTzHMpbCNaCBwniKj72z2NdMGUK/uyW6YQme8ip1e3fd403wP9pvlyT6ZRDLhOXvhma4Ld+b84XjdfTA9Kxf9aAH+lY8tp+hYzMxfKsCTR4DYNpcBCMhOe0N9Ny7EH6JKStSJbOZ8pUbEW4dqmQ5/viAJwhFpA+efe4geeH9XO1tmvKp3Z4wguWVB2f/C+spDoblm6/Q4qtR55k7h1AqfSibdJSbnZ1iM4N5xcJz0HIL/x3yS12XZF8d1qin3SX+uF+7yZjdZTZtbscTnmYmxd4IA9r3KjEbuTlXxqO+6lJAQLhim0LKU7zN/8peGVDoZ/iXnwqN6ITCOWyMsszwwCjzEgEvVD/rBEB/cOcepP1C5aYbGCF0+Y76sd0Gc8iajkgGOtIoYzd9WrZhxJenxx497KiGi05jPhSdrYyev3YQG6lJpZSOS0SbHmoSh+B3oyQ/8LeGDG0g/ivTRlM6E1N1rNQtNt/jnrcn7blvZSO85013lubRbNNCXL4PF4ru3NW5kyhGHIt3uJ3GcIdU5mTwQxYTkFeIYUamjOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(1590799018)(5660300002)(26005)(478600001)(6506007)(82960400001)(71200400001)(6512007)(2616005)(186003)(38100700002)(66556008)(54906003)(66476007)(66446008)(4326008)(6916009)(64756008)(66946007)(91956017)(76116006)(316002)(122000001)(86362001)(6486002)(8676002)(8936002)(7416002)(1580799015)(4744005)(38070700005)(41300700001)(2906002)(85202003)(36756003)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0lWVHNQNEozaDhXM09YOE5weU9lMk1Fa3cwZzNUNzEvZnBNbDhUNHZ4MEFw?=
 =?utf-8?B?OTA3N0doR2l3SjE2NHpIYXpSK2VhT1lIZ3NwVVloVi9LWTRKbzR3M2VtWE5u?=
 =?utf-8?B?VWJOTzFXdFRUZ1NHU0o1UlNScFBudzkrRU9lMXpZT2FlN2tnekw3NTV3MTVp?=
 =?utf-8?B?ZWRLdXhFVWFvOVlkTDZkRlVKekhPZTFqS3AwcmkzbGpLaXltTW8wZW9PK1hB?=
 =?utf-8?B?cFlCSWQ0Z2JXNUMzK2J5NkRuWHJYK2s4WjFnaFhlcEhXQTFvK2o2cjI2Tk04?=
 =?utf-8?B?dE9BQ1hPUStlRE1jZE1JQVpXcnFHTFhCVFdibW5GckI0K1JGTFpDYjZIVkRQ?=
 =?utf-8?B?N1N3ekFIdXNxbm51Qy9pc0RMcTVGZDhEMlgyb3J1NDQzUEZOYm96RTN5QkhE?=
 =?utf-8?B?ejA4OHordkQ4QzZGQmhETElaM3h1VUhNVWhBUjFmWk14WnA5dng5aE56OXVU?=
 =?utf-8?B?dHVTOXY1UVl4NVA2RVFlKzFaMHFWZUQyanB0K3ViSmhFRktKNHg5eDE2YktN?=
 =?utf-8?B?ODJuQ1YvTWovV2k0Q3N1TFNKbVhHd2Y0WVlUZVdoOEhJd2FPNlNibStEYmd1?=
 =?utf-8?B?alBULzZ2NHgwaVB3OVZ0MVJieUdDU2dkc0taaVlDS3hIMXlSRW5wRTZiWVhW?=
 =?utf-8?B?b1hTZ1NsN0RRdUJ4cXFYczE4a25pbjcvUTZMZ2ppR0xiZkVRSEJUQTVWSGpk?=
 =?utf-8?B?WTlkNjJBYW1OWVltTVFKZlhOK0x6REFSOGpPdVZRbXRRbDFJdllzSUQxeW1n?=
 =?utf-8?B?YWg5ZjM1TVBRR0hmU3huSDJrK2l6QjMzK1BuUVF2WmwwZmxkRno4Tk5BWXBC?=
 =?utf-8?B?SS9MVUhwWEE4d2ZZMldzVGR1cjRzbEROSmxvTjlySE11S3BScUkrcDduNWZt?=
 =?utf-8?B?Ry9qRVNlNHlWSmc5RGRrR29nZFR1UEg0U2t3c2poM0kzZDVuTVRmRzN1TXpt?=
 =?utf-8?B?VVBYcitQT2dKaU9HSHNwMHVYUlRTcGQyNFNiRit4elNQTlh4MTF2aTZId05y?=
 =?utf-8?B?YndQMDdsdkE0N0RBeXdzajRVeWI4bU5ScWtXS0hYZ0J6b2dqaFA5Wi8xYlNC?=
 =?utf-8?B?YTAwclpwdnp3cENiZTM4MjgvNFlvR0c0RFVzL215dVkzVHVUUEJMRzBGTWlh?=
 =?utf-8?B?LzFJWmRmL3p2bzJzU3pVQjdVRFZ4UDJpVUFCM3hlNDlaUElXdXdBSFYvdGpq?=
 =?utf-8?B?OE1IOTFQKy9rRk9NcFFVcnhEZEpUTm5ETDhVeFdUeDB3dk5zQzJMbkc5S2ZQ?=
 =?utf-8?B?ZEdaNGZhck5sa0U3cVBhMzhjdjlIeWFpQXZxKzZnMHNTTEU0cnpUazg0eTdT?=
 =?utf-8?B?UW4zeWE4eFhabXc4dzl3YmltbVZCaWlrMDliS3AwNHJWK1N5M0E2VUYrKytl?=
 =?utf-8?B?eE5PZFF5R25BNTYzNytPNTVBUC9sT1BzVVo1M050MmttMUtsSFdrc2JQL0xF?=
 =?utf-8?B?b1VRdmJraUF0eVRzZFNOYkZvcTlyL1EwWTI1bEhJT21jRm5FSUYwZzFmWkZz?=
 =?utf-8?B?dlNaZ0VIV1REQ2tZa2lSRGJNaVlySHlLL2NSVytZV2pkck9LR04rODAzN1hv?=
 =?utf-8?B?cFc5QVBWR0JlcDVGOGVtZWk4eDRuVURpYU5uWDZNM2IrSmorS3hOUmFFbzh4?=
 =?utf-8?B?TzRHV1JqN0FEdUpoaTVPYys4aUVFdWhLRU1RSjJHL0ZUcmg0UmZBZjZoZS96?=
 =?utf-8?B?ODlnOVpzVHMvZHhFaksxdW43RnJjRUFaUEdqT2dnbW8ralZjR01aMUZFY1dk?=
 =?utf-8?B?eGhUcWNwNjVaTGN2YWE2a2tPMTZ2N1NtVlpuSk5rZ003ZzJ4dkNRZTcxUkFD?=
 =?utf-8?B?ODQyZDh0NmFadVNHR3Urd080WC9oSGxGeWJIK2ZWaTVFR2VmdjNNUGVMekt6?=
 =?utf-8?B?OGNTU0lES28yNmRFVjRtTWxlYmc1aFpDMFFCTzhWMmlrc1ZEVTFVNjFlM2JD?=
 =?utf-8?B?b2lEV3pMT3RseWY4TERBNVhCMnpzbHlDMUN3VHRRNTFXRGJidXJBRlJLZWtE?=
 =?utf-8?B?N1ZDSlNqQnBmY0VRdGtPZjIxRnV6WElnSjlKNzNWaEJ2d3U1UDFFVzQxMFU1?=
 =?utf-8?B?Y0VGTm15ZWovdjA3c21PN3JLUjhpaTlISWhPYWhJMHBlaS9FeGJIM0wyUyt5?=
 =?utf-8?B?akY0aStTTWpyZVhsYkZuWTJlWlpvdlZObWQvOE1KZjk1RThraHpZdStDa2dk?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <085A5119296AA24DB9380D7A59BB7F99@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6cdb2a-205a-4f52-7b55-08db7ded7a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 06:51:51.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBI3rHDph4N7kekHyBGkw65ECOB8lcKwqJyey9m2c4XEG1JZRyG0yIU5Q7rjWW0EvtyI2zFCawlqAyxWUkTRcQ8t2iemadgadhIQ6E0+QWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTA1IGF0IDAxOjMxICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDc6MTc6NTVBTSArMDAwMCwgSGFlbmVyLCBNaWNoYWVs
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMy0wNy0wNCBhdCAwODo1OSArMDIwMCwgTS4gSGFlbmVy
IHdyb3RlOg0KPiA+ID4gRnJvbTogTWljaGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFlbmVyQHNpZW1l
bnMuY29tPg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBicmluZ3MgU0VSREVTIHN1
cHBvcnQgZm9yIHRoZSBtdjg4ZTYzMnggZmFtaWx5Lg0KPiA+IA0KPiA+IENoYW5nZWxvZzoNCj4g
PiB2MjogcmViYXNlZCBvbnRvIFJ1c3NlbGwgS2luZ3Mgc2VyaWVzIGRzYS84OGU2eHh4L3BoeWxp
bmsNCj4gDQo+IFJ1c3NlbGwgS2luZyB3aWxsIGJlIGludGVyZXN0ZWQgaW4gYSBUZXN0ZWQtYnk6
IGZvciBoaXMgcGF0Y2hzZXQuDQo+IFRoYXQgd2lsbCBhbHNvIGhlbHAgZ2V0IHRoYXQgcGF0Y2hz
ZXQgbWVyZ2VkIHNvIHlvdXJzIGNhbiB0aGVuDQo+IGZvbGxvdy4gU28gcGxlYXNlIGtlZXAgYW4g
ZXllIG9uIHRoZSBuZXRkZXYgbGlzdCwgYW5kIHJlcG9zdCB5b3VyDQo+IHBhdGNoZXMgb25jZSBS
dXNzZWxscyBoYXZlIGJlZW4gbWVyZ2VkLg0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoEFuZHJldw0K
DQpPbmNlIHRoZSBvdGhlciBwYXRjaCBpcyBtZXJnZWQsIEkgd2lsbCByZWJhc2UgdGhpcyBwYXRj
aCBhbmQgcmVzdWJtaXQuDQoNCg==
