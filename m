Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E47617551
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKCDyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiKCDx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:53:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584EA1758E;
        Wed,  2 Nov 2022 20:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB0tlRQdQ+E1zxc2QzijgvQbzU6DteATPDotNgHXSe2TuP9bfgmeR5rULWr0jGqBDuUfKbbhd96EqXdRgH1lvYcojF65KmOb6ksyG5z15VKk+zvXliFk5W6gT71bV++hHr02qDKhwQmY5+WRrCtm/V9uTvgy81YN1xhoPBsHhLuUNyVQJz/v44z7P4hhxJGLkEMBTmRp55PQ6S/7tUiSEaLV6pUO7w16eLJEcM3BuQ+QOaCy25SzoxFNK8S4KatXkYmcT4wBorgoC3HAFxrp/gBVJXbZIW/tCeowU5H7VshuApRaX+Ego46rNihOpu/AtJUazfJqeDnSn1NIjio+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEt6SnoQt5ciN70bbdoQMM2nBaY7jrDjx6HtyQq5Dmg=;
 b=kdmG7LYBt6OOvLYq6Ktdf9BWLHAqewcjLe6GlTfXJahQEmcO66g1UQZnez9+htMT9yKToGNZ+b8fNlNqZIAlOgXh/l2z2YiUuKOGcQXzXuZ1lSdXEWq7HupbxpErlOQ4Fd+pPq7TYbnZip+FT9Sf4NFqDVGE5wWzeM937zQLr6rSNXbkXUloZtk0u1/vU8Qv1MhLXzXWbVX+m2VxpN4XTvNqlOFoP0YtawFqU70ZcZ2Io4ZrdqG41eHEIFibx3cQozHMwuUUrKwruIWOOr/7m81X10CXMmOv58k7H8I4fpubJz75Ayh4By2YhSpxD6mjW2e8cNT8UKP255Zmne6AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEt6SnoQt5ciN70bbdoQMM2nBaY7jrDjx6HtyQq5Dmg=;
 b=EK6tpANKcZ/TMcknAPHiqBtjHHpTFy5i2shtxFpho9XEmXq4MRa+Ni8BK86NY6TOxlpP9mBY++UAbeRMM4o+PkXdP2oyzFXDG1N1JiyOjhpYy3EcuvhycxujEin635nsxEisAs7c4Oe76vmcu7Ob7nNr5wmjkR/CdLBoxmpHLH6Qt0OtDSMM6kgArEhqA1BBeMMs5lZeLp72ahCx/Hdk/z+wEwzRA0WzVRUSkQclZiqZjoeggdb3SRIn6rZV2XPr99YXg61YhJoXaahq3Qz+BVQr4iExNghWyNPcma1puw9+hgc3CkyMpf1z0yKLr4zZvvWgz1da/kibdIf7wp2X2Q==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEZPR06MB5174.apcprd06.prod.outlook.com (2603:1096:101:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Thu, 3 Nov 2022 03:52:59 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 03:52:59 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Topic: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Index: AQHY7ddiCLgpICHNHkaN+NgNt8n5/K4qDDAAgAGuNQCAACN3AIABPBaA
Date:   Thu, 3 Nov 2022 03:52:59 +0000
Message-ID: <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
In-Reply-To: <20221102170138.GA2913353@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEZPR06MB5174:EE_
x-ms-office365-filtering-correlation-id: cd5194b0-3be4-4712-87eb-08dabd4ee633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ud1bq5jvK+o9ETvBSmDAxujOFw60P7/w49IWMH/nwr9B/Ro3XRIWa01x/kD/WvFXKVPSdr62HYvbIRbdRLFMSnIreqZ8DGYr4Zq/fFtIhH/esQmTbDzdsytLy15aRcQeOuYWlJrHnB9anuexOHPF36q/yEqYrHEb8uW8B1Xc3IFE4ltpwWfOQwXVMQIH36iBYaEX0PHoUOvKCBp1MsFjck045WwJAEBT2u6b14zlL/FIZMVeFkogj2oHHvXTP4qiWq6KAVwT+AvQ9QnenbVxcDpF25qn05lircryEwYxafCreAayQbfbrVbGE6Tl82xVd932fhmWpZ6tqq3wEibUP6mZmdyfzTyUc/pUA+8WwObeWceVSIbpWLVCftbDhsqmhnpN4ThZg2k/c4Of+cSMzZMDANw8UcIlcd+b/I9CffQP3BUK3yUcOQw+YZVIW4WGPjITHDpIaq2vhXKASKTVQIdTCPDvZcHXuOEJsdFpazuVWpFzyK6pISKVuecOqcyF4dDj3CMUCfqIxZSZqqRDFPaTiFN4dy5wv/V/U12zIyXBJURZPlQVJ+81qPH3hYxmDNrwqqrIN0RWunaRk7WStgucKl8CjtuGhU1KrvSCHxg6Hspb9Yqt2Qh492STEaai+Eq4J9MKX30bXCNwQpcIgUUatIAErlTQs6c6zTu5H6ojoGhBQU3fkETQEaJnBqPgl46pOEND0A/3uBInai1Ggu4O46fBxCdwACeAZJVswOY2ASild7eeVhDGXFuZYf1WOMeUiTYilpyKtFXWjOSUQHf6IFFrsxtiuhIevV+tOt8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39850400004)(396003)(376002)(451199015)(2616005)(66556008)(7416002)(316002)(478600001)(76116006)(66946007)(6916009)(54906003)(91956017)(4326008)(66476007)(66446008)(6506007)(53546011)(71200400001)(26005)(6512007)(8936002)(41300700001)(64756008)(5660300002)(6486002)(2906002)(186003)(83380400001)(36756003)(38100700002)(122000001)(8676002)(33656002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0d4eUhySzBQMGd3RGUwYjJRWXNGd3dQODF1K283ek90Y2p6eHdvRWQ5SWFS?=
 =?utf-8?B?ZzdZQlJRUk1WWjJRRUFNc3pEMTRaekdJeldDTGJhY3RUZEFLK1Z6aHBPc3Uw?=
 =?utf-8?B?UDhhekFaRkdKb2JHeTl6bkFPZEJrRUUxOXFISVNPUng4RUhzMW5CTXp2T2JU?=
 =?utf-8?B?a3VTMldwOUVLQXFJSG9ZSm9XbnlENEg2RU4yMENidkxpYmpXQlFaR0tZMTkr?=
 =?utf-8?B?ZkdQMDd0RldrdStUN0dwNjBMcVNSQThLYU9kRXJTbVVENGQvbGQyQTRQUFBp?=
 =?utf-8?B?MDhFZkVhNEJHMXlxQ0h3MW5XUGJ2R0UvcFBQQmJ4THI5VmJDTW1xZlJPZTBj?=
 =?utf-8?B?UkJhTG1OZERoRS90TmhEYlk4czNXZ1JYeFRiUmlxK3J2UzNlNHgwYlRFOW5s?=
 =?utf-8?B?SHJGVFM3c3duV0wxVHZMcUxzdWV0MzJYczk5dzNEYVM2aFpoQVE2eGl2ZENs?=
 =?utf-8?B?UzNBYnlUa2FiOGpzQnN3OTY1NXByTFlYUVI0akxkWDBBdE5RYjR2MnkrZ25Q?=
 =?utf-8?B?Tld4ckIyMTFWdzVqTkZhQlBRVmlRUDJqVUo3VVBkVEtFeG9xcWNlaDNSZlZr?=
 =?utf-8?B?c1lvOTdIeHIyREdJeStqK0FZZzA0TmJDbldIT1FlOXJXYzNLM0dFU0s2RjVT?=
 =?utf-8?B?cjJSWURYVmlmOUNCVmV3aXNZU2lHRk1RZ21raC9lSHFYdGRxb3dnU0lSMlhk?=
 =?utf-8?B?SlEzOTE1eFYrYUEyckI5elVweFdmaWJDeXZ5QWxjSjBMYzdEckI5OXhPU2hq?=
 =?utf-8?B?YkhsSXRNUXNHSkpOVnA3dlVmK2pLNVlobHIrQ3BFOGhDK2RkZDkxczgxd0lm?=
 =?utf-8?B?QlFyRnkwRnR2ZmdKaitPVWxMNWFRVjVENUVibTJxQkU5MHhlSDYyTEFMaHhB?=
 =?utf-8?B?aXcwOHBYZEdkd25VaG9lNHNmaSt1RXZPU1RhNHYrZ3FRZkw1Y0k0QVJ1TmJS?=
 =?utf-8?B?bnRxYVo5WlJYSWp4MVRsS3J4dmd2L0ZHTThxQlNyNkdSR0oyRk1SUGQrSUVB?=
 =?utf-8?B?bzh0dVpic2VqS3ZsdlJSaW9oR003RkczcG42YS9zL2FKQXBYWGg0WDFVNEhZ?=
 =?utf-8?B?VTkvM3pnU2dUVkxxcGNrbC9TeVhBbWRYMmQ3NW5VZEJBR1RDWm13ZDhTNTBt?=
 =?utf-8?B?cG5kU29tQUpRWEZXSGZDMUxoUmdxTFAwYUs5QmJScEFCK1NEaVM2eGYxNW5J?=
 =?utf-8?B?dE5nV01EUUN5NlM0dFhta2tyempZZ2Q3cDF2NksxdUZSY2hwOFFNMmxkdWlq?=
 =?utf-8?B?STAvS3Bsa0NzUW9pY0U4VElPRGJVVm9Ed2JJaEF5bGkybzZQeG56THc0T0lv?=
 =?utf-8?B?eityT1IyMVpBNXpnTnNDRGt5WXZuLzV6empFNGI2WEI1YzhvU0hMRVdML1BH?=
 =?utf-8?B?bE1tU3A1NTliVlp5dHJCVzNYNU1QVW1SMlNrRm9jOFFRMll6WS9XT0VNRjNt?=
 =?utf-8?B?M0pFKzJISmgwc3dmaEtTc0ZoT0dJdUpyUTEyY0pMSWs1aExSM080ZTFRT2RB?=
 =?utf-8?B?dXlMQTd1blVmcnI0QXE0NzkwUStjS1RMdlpGSDRhMnhObE1wdC9lbXk0anJs?=
 =?utf-8?B?WXhxN1lMeS9oTWtzQ1pPUDFBN0o2M3dsbWlvUjB5azVReHFnejZ0Tk9wc3FP?=
 =?utf-8?B?RW1LZkRFeERGNFlxSHRxeXU3M3V5RVpBMUM3R3dHYkF4WW1IbnZwdGNXSnVt?=
 =?utf-8?B?RGZyV0lZT3krVnc1aHpQb0hFSTlJNnZCK0laa2laKytaV2NoeG4wam0vNWQz?=
 =?utf-8?B?T2g3eUpWNWVrNUtBMGJIK0dITWpEdGxwSmFEdnhKb2k5azVBTXRhZWVxV1JD?=
 =?utf-8?B?b2ZOTEFZWU5sOVJhQm8rd1AwQkcrN3NaenBEQzAwZExjVHlYRkhDbWNhTUVC?=
 =?utf-8?B?eVBzT25waGk4RitqMWNTbk53UGpNeTc4Yk15UGVZcEtWTTlrNUQ4N2VFS2Nl?=
 =?utf-8?B?SUw5VjF0QzRZRDFUME1vd2hOaWhGRmVJUUlvTWFESEpUdWVsVkUwOERkNEFQ?=
 =?utf-8?B?R1RaRUZQQ3NhckZxc1NwZVgzZ1N1dytoY2pVVmd6L3VIdWlKZ0RLQW9GNGNS?=
 =?utf-8?B?TmNvUUFKL3dtaVIzWFYvRFFBTGxYeVpvTUdJZUQySEt6WFNrUjAzR2Fid2tr?=
 =?utf-8?B?bldESUY2V2dtbVdLb0JPZkJWcVFNejFZVVlvVjU2RUxIa0lpZ3VBaCtWWUJx?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AACCD2E2E1C6044AE9B9C0376A870F9@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5194b0-3be4-4712-87eb-08dabd4ee633
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 03:52:59.3269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enrG2z1CAIuomxLgCiHUtD8IdZwPSjkdWeOX6XADI0XJ3uwKTLU6a6B72/687esF60p+N7GCUQyO6zj6psRAgWVxOYWgfViSgHt/4BfmmSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8zLCAxOjAxIEFNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21haWwuY29t
IG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0KDQogICAgT24gV2VkLCBO
b3YgMDIsIDIwMjIgYXQgMDY6NTQ6NDNBTSArMDAwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+
ICAgPiBIaSBHdWVudGVyLA0KICAgID4gICA+IA0KICAgID4gICA+IE9uIDIwMjIvMTEvMSwgOTox
NSBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdtYWlsLmNvbSBvbiBiZWhhbGYgb2YgbGlu
dXhAcm9lY2stdXMubmV0PiB3cm90ZToNCiAgICA+ICAgPiANCiAgICA+ICAgPiAgICAgT24gVHVl
LCBOb3YgMDEsIDIwMjIgYXQgMDU6NTE6NTZQTSArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAg
ICA+ICAgPiAgICAgPiA+ICsNCiAgICA+ICAgPiAgICAgPiA+ICsJLyogUmVzdGFydCB0aGUgVGFj
aCBjaGFubmVsIHRvIGd1YXJhbnRlZSB0aGUgdmFsdWUgaXMgZnJlc2ggKi8NCiAgICA+ICAgPiAg
ICAgPiA+ICsJYXNwZWVkX3RhY2hfY2hfZW5hYmxlKHByaXYsIGZhbl90YWNoX2NoLCBmYWxzZSk7
DQogICAgPiAgID4gICAgID4gPiArCWFzcGVlZF90YWNoX2NoX2VuYWJsZShwcml2LCBmYW5fdGFj
aF9jaCwgdHJ1ZSk7DQogICAgPiAgID4gDQogICAgPiAgID4gICAgID4gSXMgdGhhdCByZWFsbHkg
bmVlZGVkID8gRG9lc24ndCB0aGUgY29udHJvbGxlciBtZWFzdXJlIHZhbHVlcyBjb250aW51b3Vz
bHkgPw0KICAgID4gICA+IA0KICAgID4gICA+IFllcywgdGhlIGNvbnRyb2xsZXIgd2lsbCBtZWFz
dXJlIHZhbHVlcyBjb250aW51b3VzbHkgYnkgaGFyZHdhcmUuIEkgd2lsbCByZW1vdmUgaXQuIA0K
ICAgID4gICA+IElmIHRoZSB1c2VyIHdhbnQgdG8gZ2V0IHRoZSBmcmVzaCB2YWx1ZSwgaXQgc2hv
dWxkIGJlIGRvbmUgYnkgdGhlIGFwcGxpY2F0aW9uIGxheWVyDQogICAgPiAgID4gKGUuZy4gcmVh
ZCB0d28gdGltZXMpLg0KICAgID4gICA+IA0KICAgID4gICA+ICAgICA+ID4gKw0KICAgID4gICA+
ICAgICA+ID4gKwlpZiAocmV0KSB7DQogICAgPiAgID4gICAgID4gPiArCQkvKiByZXR1cm4gMCBp
ZiB3ZSBkaWRuJ3QgZ2V0IGFuIGFuc3dlciBiZWNhdXNlIG9mIHRpbWVvdXQqLw0KICAgID4gICA+
ICAgICA+ID4gKwkJaWYgKHJldCA9PSAtRVRJTUVET1VUKQ0KICAgID4gICA+ICAgICA+ID4gKwkJ
CXJldHVybiAwOw0KICAgID4gICA+ICAgICA+ID4gKwkJZWxzZQ0KICAgID4gICA+ICAgICA+ID4g
KwkJCXJldHVybiByZXQ7DQogICAgPiAgID4gDQogICAgPiAgID4gICAgID4gZWxzZSBhZnRlciBy
ZXR1cm4gaXMgdW5uZWNlc3NhcnksIGFuZCB3aHkgd291bGQgYSB0aW1lb3V0IGJlIGJlIGlnbm9y
ZWQgPw0KICAgID4gICA+IA0KICAgID4gICA+IFdoZW4gdGhlIHVzZXIgc2V0cyB0aGUgY29ycmVj
dCBmYW4gaW5mb3JtYXRpb24gKGkuZS4sIG1pbl9ycG0sIG1heF9ycG0pLCB0aGUgcmVhZA0KICAg
ID4gICA+IHBvbGwgdGltZW91dCB3aWxsIG9ubHkgb2NjdXIgaWYgdGhlIHRhY2ggcGluIGRvZXMg
bm90IGdldCBhbnkgc2lnbmFsIChpLmUuIHJwbT0wKS4NCiAgICA+ICAgPiANCg0KICAgID4gICBJ
biB0aGF0IGNhc2UgaXQgd291bGQgYmUgYXBwcm9wcmlhdGUgdG8gcmV0dXJuIC1FVElNRURPVVQg
dG8gdGhlIGNhbGxlci4NCg0KICAgID4gICBBbnl3YXksIHRoYXQgc2hvdWxkIHJlYWxseSBub3Qg
aGFwcGVuLiBTeXNmcyBhdHRyaWJ1dGVzIHN1Y2ggYXMgbWluaW11bS9tYXhpbXVtIGZhbg0KICAg
ID4gICBzcGVlZCwgdGhlIG51bWJlciBvZiBmYW4gcHVsc2VzIHBlciByZXZvbHV0aW9uLCBvciBh
IGRpdmlkZXIgdmFsdWUgc2hvdWxkIG9ubHkgZXhpc3QNCiAgICA+ICAgaWYgdGhlIGNoaXAgbmVl
ZHMgdGhhdCBpbmZvcm1hdGlvbiwgZm9yIGV4YW1wbGUgdG8gcmVwb3J0IGEgZmFuIGVycm9yL2Fs
YXJtIGlmIHRoZQ0KICAgID4gICBtZWFzdXJlZCBzcGVlZCBpcyBvdXQgb2YgcmFuZ2Ugb3IgaWYg
dGhlIGNoaXAgYWN0dWFsbHkgY2FsY3VsYXRlcyBSUE0gYW5kIHByb3ZpZGVzDQogICAgPiAgIHRo
ZSByZXN1bHQgdG8gdGhlIGRyaXZlci4gVGhvc2UgdmFsdWVzIHNob3VsZCBub3QgYmUgbmVjZXNz
YXJ5IChhbmQgc2hvdWxkIG5vdCBiZQ0KICAgID4gICB1c2VkKSB0byBjYWxjdWxhdGUgc29tZSB0
aW1lb3V0Lg0KDQpDYW4ndCBJIHVzZSBhIG1pbi9tYXggUlBNIHRvIGxldCB0aGUgZHJpdmVyIGtu
b3cgYSByZWFzb25hYmxlIHRpbWVvdXQvcG9sbGluZyBwZXJpb2Qgd2hlbg0KdGhlIGRyaXZlciBp
cyB0cnlpbmcgdG8gZ2V0IFJQTT8NCkJlYWNhdXNlIHRoYXQgb3VyIHRhY2ggY29udHJvbGxlciBo
YXZlIHRoZSBmYWxnIHRvIGluZGljYXRlcyB0aGUgaGFyZHdhcmUgZGV0ZWN0ZWQgdGhlIGNoYW5n
ZQ0KaW4gdGhlIGlucHV0IHNpZ25hbC4gSSBuZWVkIHRoZSBwcm9wZXIgdGltb3V0IHRvIHJ1bGUg
b3V0IHNsb3cgUlBNcy4NCg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkNCg0K
DQoNCg0K
