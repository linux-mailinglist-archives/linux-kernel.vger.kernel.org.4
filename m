Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC135615C87
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKBGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:54:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EA423398;
        Tue,  1 Nov 2022 23:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX2vq56UUEpgqqIWe9LXOpiIuyUARLG9nBwI5oLn7BS3htmwANu7hkkqbp00OQPvtORd2E/JFXcJ/txsyAWVDJHP0HDMD1oQxvF8EZnQ/0QqA5jkasEi7A/cFLzstHqEPabbx5k52hXtgbBpPiRJ+TunnGklzOWyVkCzZsemfqd8IIGrFq8oYz3dY7JFCNQOA9v1Hst4mInTzfBw4WqrLWbxRPHF8ZJgbEGQq7k6PIHXpjOUzlkOQYu9aENRlzwKPuP7JslC6qwt/9opPRco4qWTSH+1sR+QS4MLXbaYGSnjGwIOfjzsBABx3AQafN5ojXtIKxeVp51CidwQGsnPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV2HCPkCaFcUXZfY7XGCLPBI2vM9Km2epssA/QF2fIk=;
 b=WYo7iZPbPyeIvsAIvehc6eUahj3CqkJUVKG85XC2jf3QwdPjERs4GDDRUPNPlGfrCoDZccSipzgCxNXDq/fkXli+i9BNizPAJ+H7BZERu42CsURGrjjHDKvNnVfCNolPBa6d5HujZn06VYT1Cuw+up+eKOd7ICDrW+LEQnRWHVYFJYuNDxNL2SLpwyEZP5SZT19T0wTvHSr+53/wRifNZgicyk9FN5gBI0e+APcsaO9CgjBffyr7TcIz68+EuXL3dVOLNqeKMXzuwEGcYhGl6iw9RIfwtFB2uiFX3A0TrISVKBoJxdc7IdrOIldcZY8BjXgmct2oeI7P5EoosnSwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV2HCPkCaFcUXZfY7XGCLPBI2vM9Km2epssA/QF2fIk=;
 b=LvxjV4qkNJGAra9RR0mY7tE0WqM15hatsG1HAh9LrOLw0lWuCJ8IuzahHnE+iMRm6VlwBpqz/4csd6jhzEEwZL0sruN6caLSFPgTRxCPmU8OvS1EywQBSIWdD91kZefLHiv8ZM5NLnYv9EQHbGDmtFVGMU7+Du3Mt0pzCKePcQCYEhuFaFOAaumEmQsbneuGJotNgklClE+93SPYQ0ssqX02/ugnsEnFAu4r18a+JT3/CicmGvsKN7+b38PjTXopUBbNyJyzF47GpZHsntBsiCvDSZzMFV4vPoZv6nzwqgCrNOy9VcyOFcq1Xat7zVlwZ1T3yevNKW5G9sZ6oWq3cQ==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 PUZPR06MB6032.apcprd06.prod.outlook.com (2603:1096:301:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 06:54:43 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 06:54:43 +0000
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
Thread-Index: AQHY7ddiCLgpICHNHkaN+NgNt8n5/K4qDDAAgAGuNQA=
Date:   Wed, 2 Nov 2022 06:54:43 +0000
Message-ID: <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
In-Reply-To: <20221101131456.GA1310110@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|PUZPR06MB6032:EE_
x-ms-office365-filtering-correlation-id: ba22b636-41c8-4cf1-791c-08dabc9f1f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQNL2N3LfGCWJLcUa6tf9u+pvujfPcg2sZxbHTMmvwe568rbNVjgkWBybUNgj1fcVq8fdYNImsryv0t4Qchv8DPZO1y5avnSQlV++nKW/JjD+41XuOqpJLrvmUkVV3g2E5glMsJDN1EblsoNGtLhi9TRQj/D2+DJtcis/256tCA0RzYYZDNn1sRVlvNtGVCyxp69FvLsJdBxsAHr7kPDeTyfGuyV+wQach7FMzJ6EQ5lwf9zUZ5CoViSUpmYxvlcc7l+NAsTdCbDziN1L3E17GhpxzfG0rrmB9Bld1w3YBGUUSxGGZDkCHpgvOPTmySLEExJoWQQnF3FAeJSeMwpJYM214s14AETSx4Xf1hxKu55Mry64Ylmwr4hbr5WdGfRZi16JgTgX6ObojVVER0ZbTxhHdGu+I74F3rk51rMfMK6WzbC3jRw8C1O6qLmyfe61t+HR2jWWsfQj3fisZ/YRI8+7L7Fvv4yILOtJGspjv1R8Ihju/0y4+HRbYofY19LPSN9scejZBcjJLxOhr1JQSOJ4MrRS0l4k+l4O3EaVZcqFbocGSqZ00NxBme34QNqCCXKv19gsyz+QrBd/8Ziu9OZcObGtOzo37PJUItINlP0FjiIOdPthjB7/Jb+yMNVKDgTmUwQnLwnJH5KwIVkGON2QVm0schIGCWY3iAoYD7lz767lB1mepM8k61x994FkrAXiARu3ctqZuG00P8EHHjbZ7Y/ezMh7slZZr0KzEbR1M+MRncbhsaqYluVNLkDA3ok7Y7LxlPWSYKDVNsJHB8wnXcqKMo7T4cuJdhFoUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39850400004)(451199015)(86362001)(36756003)(33656002)(122000001)(38100700002)(38070700005)(316002)(478600001)(66446008)(91956017)(54906003)(6916009)(71200400001)(66946007)(5660300002)(6512007)(2616005)(41300700001)(186003)(26005)(8936002)(7416002)(66556008)(66476007)(8676002)(6506007)(4326008)(64756008)(6486002)(53546011)(2906002)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVKRkVGdTNNSlhzeWxzWEcrZnNtNzNSN3dRR1hKdlcwWE9OVHZDZ0xVbkNl?=
 =?utf-8?B?VG82Ung4aFpCeElPbVBHK090SmkrdHp4V2JUSVJBN0plUTJkUVZsa0lwWExB?=
 =?utf-8?B?WFQ3dGs1UzJvbXZnMWE3Z3hyeG9sdXQzNzY0dWpYN2JtSHdZSzByelh4TENy?=
 =?utf-8?B?c1U1azJ5YkdqcjloZDlmQ0JLTFhIMkxRNE0rUDVIdDZCVlR1bUkvOW1WUENL?=
 =?utf-8?B?U3ZLNkFvOEg0WEQ1L0p6cERPQTkyOFp6b0JxdzhuVG00Y3E3amtSZys4R3BO?=
 =?utf-8?B?TmsvNjhxQllwMmxKVkNlc1NWL2VRT2JDUk5vVlhqV0w3V2NxZjhBR2kxYjRr?=
 =?utf-8?B?MWIvajZ4c1NUcXRaVWdDNHluU3c5by9uWkh3dnVSeVA3bmVlOWIza1J6bHg0?=
 =?utf-8?B?TnhkWjBweU9pOVliR1RzVUFQM2M3cVRVK1lNMDRCQXBFWHRJRUNiK01WL3Ja?=
 =?utf-8?B?dHZFc1RmNTZ1UVNBbWxTcnZvUVQrR1ZlRUwxSUZqdzUzODdBMk5HUkwya1ZX?=
 =?utf-8?B?cjlSeHJhRTQxVFFzYjljV1ZWdnhITmJqdktESXBHQkw2Rkt0YWcxZThHTjls?=
 =?utf-8?B?Z0pwbjNwSlFpY2lqSEF3ejVBWW9RQ1E2dmdZcHVEODh1OVlMYXdFMm5KMTJO?=
 =?utf-8?B?dC92TUhxWFNXZzVVSFNkKzc1WktlajZqcGFsazZGVTQyQXdpbldEUHZtQmoz?=
 =?utf-8?B?WDlkbWZ2TGVrQjRJUnBOM29SS3p4SUNqZlFZb2dEaGFDakhQa1RKaGRIRVhl?=
 =?utf-8?B?WW1xeVl5enNzNmY0OWFQWUw5MnhxNDlldjRpOGRFeXhWNGRmdDZDbTFpa0hE?=
 =?utf-8?B?UmtUeG03Z0V4YnZwaDJ0bXVFLy9POWVxZE1CWnc4WTgxWE00d3BHai9XY2Vt?=
 =?utf-8?B?UjE4Nk1MOG1abzZlb2lEZ0xzM3I2c1crWDNJWHlCSURId20wSnh1ZmZ3MTg3?=
 =?utf-8?B?MTI0VU9seW9CWGFDaEVld1A0dEVuTzFlWDJ2OVRQQ01pNDJqVm90bnIrbHhN?=
 =?utf-8?B?TFh0ejB1ZkpsUFNHNG9LSXRsYWZpU21xTU9XbmFzdWlDNGdScCtlbk83bXR0?=
 =?utf-8?B?UXBZMUoxbGVuVWJvbzMxWlNvY2YraEhpYjFtaStzekhYQjNTamtQYkN2cHRx?=
 =?utf-8?B?SzMyRmVPdGUveU42b2NWMElLY1R2Zy9FbUxGQkdsUnlCOEk4dVFpRmlkNUY5?=
 =?utf-8?B?d2xqdDRFN2o0T0I3TmNSNDdxTGVDbHlGY1YwOG5XTDkwQS9RYm10TlNJd1VZ?=
 =?utf-8?B?MXJ6QThYN3plU1RrUGFrUWVJanU2SGI3RWNNK0EvUVB0UWx2Sm8vc3haVWtT?=
 =?utf-8?B?K0J5TXYwZ0dyNTY2OEFzQzVKMXVVM1FDeGtLbFVEeTVZZ0FLRkdZeEk1UlVm?=
 =?utf-8?B?VVVaZVZOTnQxa1lXU3FzNHN3NDF3bnRTbnJBcW5sOEZWeWF6ay92ZllxQWJq?=
 =?utf-8?B?dGp1QkZPQ29GUjNYWTV4eE1XM2hMLzB3UWgwOHNWR1pDTmlvTVZRMFdnSkli?=
 =?utf-8?B?MzVBazBsUHdBWnRjd01kUGplZC8zdmc3QmZHQUpJZS9OcTFIbzBpUExmVDB2?=
 =?utf-8?B?NDdJSUE1RWNCcHNJcmF3VnRMVHBtUnpYL29RTVU4WGpGd1hLNmUzUi9haGE5?=
 =?utf-8?B?Q0tLLzhMUVJ3dFpCK1AwdVU0RENNNXdkb2RlODN0Smc5eUMrZ2c0VUIvTjFs?=
 =?utf-8?B?R2todmJHbHREN2tWY3pCM01YNUNDS0hORUVtT2lPaithYk9RaCtVbWs4MWwv?=
 =?utf-8?B?UVFSeGZvTEdleElZUzhheVdDSGo0dTJGRVFteU1yYXR0S3hteVpIWEt1SDlI?=
 =?utf-8?B?b2tTcXJVVTlKd1BjYm1ZNTRxVitUTGhWNDk0YTd2RDdMd05pTFR1bDY2WDlK?=
 =?utf-8?B?UmhKbUtMVHB6d2d5QzJsb2k2bVFIQ1VQM3p1b0t0cSs0R0ppTTd0UlNGdEl0?=
 =?utf-8?B?TlBLeGkxdzYxWlpUQ0g2RTFheGJ2UCtqaWJWcmJiNmtublE0U3k5KzM2dk03?=
 =?utf-8?B?OGFsR0g4a0R2SXdMSndSYkZHUHlSTDd1ZXduWVVqWmRWS2xBK3pFQWNjSlc3?=
 =?utf-8?B?N2xMNXl5L3VxdzBJSWhyd3BLNVEzV3I4Um9kMGF3SzdNTThzOUgrVFBMVFow?=
 =?utf-8?B?S1h4b0Irb3NscXVPVEh5dHMwYkRIQncyRkxtWGwwcGp4TlFZTCtPT0VEenJB?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C9AC82443FBDB46A1865C06EAE224C1@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba22b636-41c8-4cf1-791c-08dabc9f1f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 06:54:43.4420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1B8JSWLqHPUk99oEtU60OSUlSozlr7sy387S0HwgO4n0Umsn0vm9fLIJUx39puZ7K2nUr3w8ZA1l0NotfCoSwaa0Uu+yov655Vr2+XFHNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlciwNCg0KT24gMjAyMi8xMS8xLCA5OjE1IFBNLCAiR3VlbnRlciBSb2VjayIgPGdy
b2VjazdAZ21haWwuY29tIG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0K
DQogICAgT24gVHVlLCBOb3YgMDEsIDIwMjIgYXQgMDU6NTE6NTZQTSArMDgwMCwgQmlsbHkgVHNh
aSB3cm90ZToNCiAgICA+ID4gKw0KICAgID4gPiArCS8qIFJlc3RhcnQgdGhlIFRhY2ggY2hhbm5l
bCB0byBndWFyYW50ZWUgdGhlIHZhbHVlIGlzIGZyZXNoICovDQogICAgPiA+ICsJYXNwZWVkX3Rh
Y2hfY2hfZW5hYmxlKHByaXYsIGZhbl90YWNoX2NoLCBmYWxzZSk7DQogICAgPiA+ICsJYXNwZWVk
X3RhY2hfY2hfZW5hYmxlKHByaXYsIGZhbl90YWNoX2NoLCB0cnVlKTsNCg0KICAgID4gSXMgdGhh
dCByZWFsbHkgbmVlZGVkID8gRG9lc24ndCB0aGUgY29udHJvbGxlciBtZWFzdXJlIHZhbHVlcyBj
b250aW51b3VzbHkgPw0KDQpZZXMsIHRoZSBjb250cm9sbGVyIHdpbGwgbWVhc3VyZSB2YWx1ZXMg
Y29udGludW91c2x5IGJ5IGhhcmR3YXJlLiBJIHdpbGwgcmVtb3ZlIGl0LiANCklmIHRoZSB1c2Vy
IHdhbnQgdG8gZ2V0IHRoZSBmcmVzaCB2YWx1ZSwgaXQgc2hvdWxkIGJlIGRvbmUgYnkgdGhlIGFw
cGxpY2F0aW9uIGxheWVyDQooZS5nLiByZWFkIHR3byB0aW1lcykuDQoNCiAgICA+ID4gKw0KICAg
ID4gPiArCWlmIChyZXQpIHsNCiAgICA+ID4gKwkJLyogcmV0dXJuIDAgaWYgd2UgZGlkbid0IGdl
dCBhbiBhbnN3ZXIgYmVjYXVzZSBvZiB0aW1lb3V0Ki8NCiAgICA+ID4gKwkJaWYgKHJldCA9PSAt
RVRJTUVET1VUKQ0KICAgID4gPiArCQkJcmV0dXJuIDA7DQogICAgPiA+ICsJCWVsc2UNCiAgICA+
ID4gKwkJCXJldHVybiByZXQ7DQoNCiAgICA+IGVsc2UgYWZ0ZXIgcmV0dXJuIGlzIHVubmVjZXNz
YXJ5LCBhbmQgd2h5IHdvdWxkIGEgdGltZW91dCBiZSBiZSBpZ25vcmVkID8NCg0KV2hlbiB0aGUg
dXNlciBzZXRzIHRoZSBjb3JyZWN0IGZhbiBpbmZvcm1hdGlvbiAoaS5lLiwgbWluX3JwbSwgbWF4
X3JwbSksIHRoZSByZWFkDQpwb2xsIHRpbWVvdXQgd2lsbCBvbmx5IG9jY3VyIGlmIHRoZSB0YWNo
IHBpbiBkb2VzIG5vdCBnZXQgYW55IHNpZ25hbCAoaS5lLiBycG09MCkuDQoNCiAgICA+ID4gKwl9
DQogICAgPiA+ICsNCiAgICA+ID4gKwlyYXdfZGF0YSA9IHZhbCAmIFRBQ0hfQVNQRUVEX1ZBTFVF
X01BU0s7DQogICAgPiA+ICsJLyoNCiAgICA+ID4gKwkgKiBXZSBuZWVkIHRoZSBtb2RlIHRvIGRl
dGVybWluZSBpZiB0aGUgcmF3X2RhdGEgaXMgZG91YmxlIChmcm9tDQogICAgPiA+ICsJICogY291
bnRpbmcgYm90aCBlZGdlcykuDQogICAgPiA+ICsJICovDQogICAgPiA+ICsJaWYgKHByaXYtPnRh
Y2hfY2hhbm5lbFtmYW5fdGFjaF9jaF0udGFjaF9lZGdlID09IEJPVEhfRURHRVMpDQogICAgPiA+
ICsJCXJhd19kYXRhIDw8PSAxOw0KICAgID4gPiArDQogICAgPiA+ICsJdGFjaF9kaXYgPSByYXdf
ZGF0YSAqIChwcml2LT50YWNoX2NoYW5uZWxbZmFuX3RhY2hfY2hdLmRpdmlzb3IpICoNCiAgICA+
ID4gKwkJICAgKHByaXYtPnRhY2hfY2hhbm5lbFtmYW5fdGFjaF9jaF0ucHVsc2VfcHIpOw0KICAg
ID4gPiArDQogICAgPiA+ICsJY2xrX3NvdXJjZSA9IGNsa19nZXRfcmF0ZShwcml2LT5jbGspOw0K
ICAgID4gPiArCWRldl9kYmcocHJpdi0+ZGV2LCAiY2xrICVsZCwgcmF3X2RhdGEgJWQgLCB0YWNo
X2RpdiAlZFxuIiwgY2xrX3NvdXJjZSwNCiAgICA+ID4gKwkJcmF3X2RhdGEsIHRhY2hfZGl2KTsN
CiAgICA+ID4gKw0KICAgID4gPiArCWlmICh0YWNoX2RpdiA9PSAwKQ0KICAgID4gPiArCQlyZXR1
cm4gLUVET007DQoNCiAgICA+IElmIHRoZSBmYW4gaXMgb2ZmIG9yIG5vdCBjb25uZWN0ZWQsIHdv
dWxkIHRoYXQgcmV0dXJuIGFuIGVycm9yID8NCiAgICA+IElmIHNvLCB0aGF0IHdvdWxkIGJlIGlu
YXBwcm9wcmlhdGU7IGl0IHNob3VsZCByZXR1cm4gYSBzcGVlZA0KICAgID4gb2YgMCBpbiB0aGF0
IGNhc2UuDQoNCkl0IHdpbGwgYmUgaGFuZGxlZCBieSB0aGUgcmVnbWFwX3JlYWRfcG9sbF90aW1l
b3V0Lg0KDQpUaGFua3MNCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQo=
