Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76964185C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLCSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:05:26 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2043.outbound.protection.outlook.com [40.107.9.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF91FFA2;
        Sat,  3 Dec 2022 10:05:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBB1m8Zm46ooasm5NR3zDJuOEzRsgm5Bmi5xDvokXJtvBgpaWL5mvo8KdQREMK1ELFw4/metM4fQAi2azTszzGyMGCUKaRPeoiWTp6it0ex3eMpPfAR66SsevvYIx0cnrpGwKxZbQZev/fy15Rrbic1TQHDIXkHX3PwqwfJtVlz4VdsCgwFNtkQC0CY8PVUazUdwLTefyNBIzZ0ljcK7D1nvkK8v/humQCsyDnb7iPDheIaFBtxCY6JMQubAM366SPdAvKZl9q4fj5UT0tSttn+TVULSNe+KyiMHFF86P46mXDy1MjzSrt4Wcli20PBreq/ixXlRJo9gFcHWat7YPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKLdbkZ/WhAGPtHZ7uV3Uo0e3qnbfLecQnfd/1eAqZk=;
 b=oCgdvvTZfq8UN2qbgfHVj/Y+LwhH0QdkbCcNobFakqb6tisynOsyJayAHFz97Swl5tMHbsi1KmDmlI0ukNL1OWCPOlIx+qBGpi9/2KAfHviRbbWPJjQF+NUh8zNTmhXboDXqF6c4O0G5VRM99Z+/o02KO4wlyNZFRRh4LDRLXt/SS+RNy+bKhSx2frWKIoVhU7EInNxnD11BOLhJ2tF4AK/AnYZM6lmMew15rzNKrRq9OoxvSv7767omhUuYtMwhrHySrdRNvJS87RO3iOKk68JFKeOtRIgylxiI1G780eF6L/iWQVItGgg3+MNP6r+NAfLNWiOelUynU5KKjEywYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKLdbkZ/WhAGPtHZ7uV3Uo0e3qnbfLecQnfd/1eAqZk=;
 b=1pmTEfzMNPSMv2iZJdQ+/9ENLtaM0wshgx05aRPUABQIo/7t866QWxdv176dk6e1Vvl/JRQKWMOm4WmuzKEXMAngTa7uRKn9X8LCyzWQwo8fm7EugRbAkYJM/osJYHWCyT2eLg9yzhTU5LJszaRSEWE9uNBvda9Rnse4ymL/7P7XCEu2v/5qBYxI2cpROQhUZ6ha99EEgIhFZkNDATUxwHqEFpEl91pf9wFYbyVYfmz7QRCG+Xny203JR7eA35IYwa/4r+LZKTaGBSCvLrBFWpTTXWW7vSYKLM6GyfgFgByLP5LWC8o/QHjKgTSYVwq5e8r/5qGbBtliAwXcrdLVfg==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 MRZP264MB2240.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Sat, 3 Dec 2022 18:05:21 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 18:05:21 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/5] module: Add empty modalias sysfs attribute
Thread-Topic: [PATCH v6 1/5] module: Add empty modalias sysfs attribute
Thread-Index: AQHZBqAlFx5vin8FNkGeoJ5kiCl0Wq5cdl2A
Date:   Sat, 3 Dec 2022 18:05:21 +0000
Message-ID: <7abbc09f-c3a5-5def-5071-d99f3f58a9b9@csgroup.eu>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|MRZP264MB2240:EE_
x-ms-office365-filtering-correlation-id: a3991cd1-f132-42bc-5b51-08dad558f1b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBwUqOAmaBIb10uXFnpvF7fOpKtt+skz2lOfEovD0zpRAzGC1imQ0d+U3fYvTkDgSbVCofH+Y6DbcSq5jRicAqy8qCIjJGTteN7oKka3jBvlF5XDxLwZF9G08bn17ZoIUoFJPFgnzyGAvCOZf/VVIALLWKL3mm21wENaRoZthN5k8XDHJhx0lXt52R4pfoQekitO5kEyT1OXPQARv8XtXOPMR+aKOl+jfXWlmJQNDvQNCvet/nGMBmtOhxHaTXNdwylhRoBiqFZGLjGwkEyPwGc6jTCaje2fQJTPhTmGCJPgkGe4k6hRX0cd3AYT0X927ls2LA00weHY/24rAR6eiJ8mruyjNo4T63P4nSSfWdP1z7pyf02XxZ4I2GFGDIyQn01QoUV1D1D4IDZVE9nctsdFGIDefMqPUcvMos87jIQdo1v/Lh0YtzVZhFBxv2PNc65mcKi+q8WzyQTBVnZaC+vfoTCmkiSgoFxcJC5QhhaKeazW2L0IqZ3QHw0GdZE59g28XTdfgjfW2l9KIj1jKIqdT+MVs2HohzFP7NoXoC+86BdXQz42C+8mwnCshRnq+zjYD2cPOdZ10GhePNtLF0yEsZheC0oWoNor18KSIsSYVRflnxswbWc0ePCa6xF6encfUzuCZixMCRXVlHcBaXh665mtR7Paspotof7Quc/iKsfFQqOF8XUD3FX+t1yidM13UBFDCnRFvJdXz1TBZdmUdaPPcvYtvkBGh610nWT0+8hFygnI8EMRO2kDQMSw41CqoC2zi4f57R9NVDYwSilsn15qxxctCZW1GsU3IHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(396003)(346002)(136003)(366004)(376002)(451199015)(478600001)(966005)(31686004)(6486002)(6506007)(71200400001)(8936002)(2616005)(64756008)(6512007)(26005)(186003)(38070700005)(41300700001)(8676002)(2906002)(44832011)(4326008)(316002)(36756003)(76116006)(66946007)(86362001)(31696002)(83380400001)(66476007)(5660300002)(91956017)(38100700002)(66446008)(110136005)(66556008)(66574015)(54906003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFEyMll6dUZ5MHpMdFpDQm1tc2JFc0VJV3FMODJMakF6RmVjemRpYTRLZnJk?=
 =?utf-8?B?Q3NTdWdUamRUdkpSZDhzUDZHNStNMU5HdFFDTWpJMHhPcHVaNDZnZjhyMnNs?=
 =?utf-8?B?WHV3dVRJSWpOSjkvc3RuK1laUUdZbUkyeFg5RzZEaDU4eVp2Si8ra2piaWVK?=
 =?utf-8?B?NDFSenBJUGo2Ky9KTXRCaTRnakNZYkJSSTU0RHRVMllWSWhZSGxtWVpnVUVB?=
 =?utf-8?B?RU9Wc2J1MDRyWGFIbmFJR3ZBUXRycFFLbXJOVDFnakZEM2dJQkhiNG4zQUpw?=
 =?utf-8?B?K0s2SnIzWm9KL2J6dXZjSTl6QzJ4elhDVU9DUUYzRXFrUmo1OWs5Q3M5Sm9Z?=
 =?utf-8?B?QUVYNjErREVtc2pLUVpaTVVVeTNTOFl3M3RBejNYbFBVTXpPV1AxeFVyNW5y?=
 =?utf-8?B?dVk5OS8vTE93azhMS1NzcDJxQTRCMzl1d1dwMDNaODlyTWtCTjRDU0RhRmxO?=
 =?utf-8?B?aEpFNFk1b0pNZ0lscVdaZnJDb2pzKzRyeDA2WjBod3BEUlNpa1AwNjJVZlZh?=
 =?utf-8?B?bkt1aWJicVpHR3dSVmJMWXV2S1pUdHN0Z3NrUEpHSVI4dG9jblJIYjFsMWdP?=
 =?utf-8?B?SC9OdUxtRHl5MGxxc0twZTJlVjQyQnRFdldoSEdQaHJXcFFoMHBiZDFLVUQ2?=
 =?utf-8?B?R2c2MXVvQnJKajhEOHF3bGd1M21DK1ljVUdDSzFFblNRWlZyQkkvSWxNQUFO?=
 =?utf-8?B?bHU3bSsrR3RCNW5qMlpINERDSnJtaVc3MEdDQUFiUExhTDRHQjJtTkpqeU80?=
 =?utf-8?B?Q0x1T0xuU2ZndEpzVFMySjdaeXBMUit1SVRHYmszM2J6WUlwM0ZsZzBza1N0?=
 =?utf-8?B?Ty9jbWd4RHlQMEd3U0E2bldGWkQ3d0R4QkNCQUpBSmdvVXJvU0U3YzF6S3Jq?=
 =?utf-8?B?TFhEYWk2TSswUy9XRHU3TTcxZURycHVvcUM5VGR0VmF6ZmtNY3plN3VQdTJ0?=
 =?utf-8?B?YndMMk5rTFl6UmczenVXMlRTengzZERZNmpYcmptais4bHBGakNCWXlCQ2lm?=
 =?utf-8?B?RC8yNHI5eGJDT0lNdEcwb1pNdXpHbUtsQ3Z2djc2N1FBL3c0QXg2SFNMUjVx?=
 =?utf-8?B?TDBUOS9Zd0Jrc01taERxU2lNM0dwWGw2Y2UySlBsOFFOZnFVUzNqL1dQWGxs?=
 =?utf-8?B?c3NUOVZiQlllbTdaaFB1c056cS9OZFhOZnZDKzhSY2IwYlVuQ3IzRjZkenNL?=
 =?utf-8?B?c3VySUFmNVJJL1hzUVhIVUFLL0VNNC9mQzVNY2xaVUdRVmJQOTNUNExUdmpS?=
 =?utf-8?B?eGk0TjVaV0pTQmpjRXFJWHZjQVVHM01pY3hVaEhvaHIvMXJJYjhCZ2Rpby9C?=
 =?utf-8?B?UjRBOUF6M1BuZTdDZEFZQXhHakZoanFITDVRZ2dJZFo1VGwyOU1nV0szTmha?=
 =?utf-8?B?Q3ZXMzJqZW0wRkFsTEc2L0lid1BqbUlqMS9zRTIvZHhxOUZNeUEvVWhTcXlC?=
 =?utf-8?B?WjJjWmg2a2ZDQy82Y2lvZG1hOUovMm1VSXdMb0tadU15Z3gxUkFjRnh6QUxx?=
 =?utf-8?B?SGF3K3dBdG52S1dPczI5THpvRlAzY1o1VlRXNThVYVlxNU5GT0JkZUdBb3R0?=
 =?utf-8?B?cERXK0lOQnZsdmpyVGpScDRmMnE0aVZ2YlJNODlGRDA1aFJoeERSeUJhTVBk?=
 =?utf-8?B?VDdoaGNncGZSTW05bFl5bUlhbGxpK3R6c1VheXdmNTZtWUp1Tnk2R3ptc0lD?=
 =?utf-8?B?UFNhVlNaSmtVNDFWdmgvRWJXLzJHYlFTcmdCSXJyL1N4WXRNQWRjRzVocWhC?=
 =?utf-8?B?UDYvNklxbnl6cWw3NitrUENFS051UEkyNHZJTXB6aDNadkxwdVZOQzFpNGt5?=
 =?utf-8?B?KzRLcS9vb0hnUnFVSXVIUWF6WnVFcDU1WXkvektET2V5ekNHbHV0QnYwc3dp?=
 =?utf-8?B?V3d5bE8xTWhqQ0JHT1BXbVRRb1YvakRuWHpoUFRqcGhHaDlzY2NWcDhqK3Z2?=
 =?utf-8?B?UmJNbWZYN09YU1dmejJicjQvUkJCVFltSytWTzdlSkxxVFl3MHZrNzZLSXFy?=
 =?utf-8?B?aHN5NlkyMEkrbTJnVHUrdzdyMldCN0xTZWd4NUFVUWlGQkR6Y1hubEUyUEpm?=
 =?utf-8?B?WFpUbHJSc21nZUEzZHlCSHZObFRFRFJZTDRYZ3JaWThMTE5rQkt0Ym1QUSto?=
 =?utf-8?B?Q2pCM2FBbUxNYWdqdFIwaFA2TFBLRm92dFplSWk4dnd6aDJkMHhsbEFBcHBH?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5D390F504665243A8C2C4D4B47773C1@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a3991cd1-f132-42bc-5b51-08dad558f1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 18:05:21.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9lErlrSBLWnahMsijvhmzGTbr9ROigthmzgEsYHAO6jZ9ot0dn0n433zsL0Cl58WI2R7I3PdAWSoWHAF9aMySfB3KsA7J66ZnjBZk1qAE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2240
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzEyLzIwMjIgw6AgMjM6NDcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gVGhp
cyBhZGRzIHRoZSBtb2RhbGlhcyBzeXNmcyBhdHRyaWJ1dGUgaW4gcHJlcGFyYXRpb24gZm9yIGl0
cw0KPiBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIFdlYmIgPGFs
bGVud2ViYkBnb29nbGUuY29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4L21vZHVsZS5oICAg
fCAgMSArDQo+ICAga2VybmVsL21vZHVsZS9pbnRlcm5hbC5oIHwgIDIgKysNCj4gICBrZXJuZWwv
bW9kdWxlL3N5c2ZzLmMgICAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICBrZXJuZWwvcGFyYW1zLmMgICAgICAgICAgfCAgNyArKysrKysrDQo+ICAgNCBmaWxlcyBj
aGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9tb2R1bGUuaCBiL2luY2x1ZGUvbGludXgvbW9kdWxlLmgNCj4gaW5kZXggZWM2MWZiNTM5Nzlh
OS4uMGJmYTg1OWEyMTU2NiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tb2R1bGUuaA0K
PiArKysgYi9pbmNsdWRlL2xpbnV4L21vZHVsZS5oDQo+IEBAIC00Nyw2ICs0Nyw3IEBAIHN0cnVj
dCBtb2R1bGVfa29iamVjdCB7DQo+ICAgCXN0cnVjdCBrb2JqZWN0ICpkcml2ZXJzX2RpcjsNCj4g
ICAJc3RydWN0IG1vZHVsZV9wYXJhbV9hdHRycyAqbXA7DQo+ICAgCXN0cnVjdCBjb21wbGV0aW9u
ICprb2JqX2NvbXBsZXRpb247DQo+ICsJc3RydWN0IGJpbl9hdHRyaWJ1dGUgbW9kYWxpYXNfYXR0
cjsNCj4gICB9IF9fcmFuZG9taXplX2xheW91dDsNCj4gICANCj4gICBzdHJ1Y3QgbW9kdWxlX2F0
dHJpYnV0ZSB7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL2ludGVybmFsLmggYi9rZXJu
ZWwvbW9kdWxlL2ludGVybmFsLmgNCj4gaW5kZXggMmUyYmYyMzZmNTU4Mi4uOGQ3YWUzNzU4NDg2
OCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL21vZHVsZS9pbnRlcm5hbC5oDQo+ICsrKyBiL2tlcm5l
bC9tb2R1bGUvaW50ZXJuYWwuaA0KPiBAQCAtMjU5LDExICsyNTksMTMgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIGFkZF9rYWxsc3ltcyhzdHJ1Y3QgbW9kdWxlICptb2QsIGNvbnN0IHN0cnVjdCBsb2Fk
X2luZm8gKmluZm8NCj4gICAjZW5kaWYgLyogQ09ORklHX0tBTExTWU1TICovDQo+ICAgDQo+ICAg
I2lmZGVmIENPTkZJR19TWVNGUw0KPiArdm9pZCBhZGRfbW9kYWxpYXNfYXR0cihzdHJ1Y3QgbW9k
dWxlX2tvYmplY3QgKm1rKTsNCj4gICBpbnQgbW9kX3N5c2ZzX3NldHVwKHN0cnVjdCBtb2R1bGUg
Km1vZCwgY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaW5mbywNCj4gICAJCSAgICBzdHJ1Y3Qga2Vy
bmVsX3BhcmFtICprcGFyYW0sIHVuc2lnbmVkIGludCBudW1fcGFyYW1zKTsNCj4gICB2b2lkIG1v
ZF9zeXNmc190ZWFyZG93bihzdHJ1Y3QgbW9kdWxlICptb2QpOw0KPiAgIHZvaWQgaW5pdF9wYXJh
bV9sb2NrKHN0cnVjdCBtb2R1bGUgKm1vZCk7DQo+ICAgI2Vsc2UgLyogIUNPTkZJR19TWVNGUyAq
Lw0KPiArc3RhdGljIGlubGluZSB2b2lkIGFkZF9tb2RhbGlhc19hdHRyKHN0cnVjdCBtb2R1bGVf
a29iamVjdCAqbWspIHt9DQo+ICAgc3RhdGljIGlubGluZSBpbnQgbW9kX3N5c2ZzX3NldHVwKHN0
cnVjdCBtb2R1bGUgKm1vZCwNCj4gICAJCQkgICAJICBjb25zdCBzdHJ1Y3QgbG9hZF9pbmZvICpp
bmZvLA0KPiAgIAkJCSAgIAkgIHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwYXJhbSwNCj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9tb2R1bGUvc3lzZnMuYyBiL2tlcm5lbC9tb2R1bGUvc3lzZnMuYw0KPiBp
bmRleCBjZTY4ZjgyMWRjZDEyLi44ZGFmZWM3NDU1ZmJlIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
bW9kdWxlL3N5c2ZzLmMNCj4gKysrIGIva2VybmVsL21vZHVsZS9zeXNmcy5jDQo+IEBAIC0yNDAs
NiArMjQwLDM3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhZGRfbm90ZXNfYXR0cnMoc3RydWN0IG1v
ZHVsZSAqbW9kLCBjb25zdCBzdHJ1Y3QgbG9hZF9pbmZvICppDQo+ICAgc3RhdGljIGlubGluZSB2
b2lkIHJlbW92ZV9ub3Rlc19hdHRycyhzdHJ1Y3QgbW9kdWxlICptb2QpIHsgfQ0KPiAgICNlbmRp
ZiAvKiBDT05GSUdfS0FMTFNZTVMgKi8NCj4gICANCj4gK3N0YXRpYyBzc2l6ZV90IG1vZHVsZV9t
b2RhbGlhc19yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4g
KwkJCQkgICAgc3RydWN0IGJpbl9hdHRyaWJ1dGUgKmJpbl9hdHRyLA0KPiArCQkJCSAgICBjaGFy
ICpidWYsIGxvZmZfdCBwb3MsIHNpemVfdCBjb3VudCkNCj4gK3sNCj4gKwlyZXR1cm4gMDsNCj4g
K30NCj4gKw0KPiArLyogVXNlZCBpbiBrZXJuZWwvcGFyYW1zLmMgZm9yIGJ1aWx0aW4gbW9kdWxl
cy4NCj4gKyAqDQo+ICsgKiBgc3RydWN0IG1vZHVsZV9rb2JqZWN0YCBpcyB1c2VkIGluc3RlYWQg
b2YgYHN0cnVjdCBtb2R1bGVgIGJlY2F1c2UgZm9yDQo+ICsgKiBidWlsdGluIG1vZHVsZXMsIHRo
ZSBgc3RydWN0IG1vZHVsZWAgaXMgbm90IGF2YWlsYWJsZSB3aGVuIHRoaXMgaXMgY2FsbGVkLg0K
PiArICovDQoNCllvdSBhcmUgdXNpbmcgbmV0d29yayBjb21tZW50IHN0eWxlLiBPdGhlciBwYXJ0
cyBvZiB0aGUga2VybmVsIGhhdmUgDQpkaWZmZXJlbnQgc3R5bGUuIFNlZSANCmh0dHBzOi8vZG9j
cy5rZXJuZWwub3JnL3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjY29tbWVudGluZw0KDQo+ICt2
b2lkIGFkZF9tb2RhbGlhc19hdHRyKHN0cnVjdCBtb2R1bGVfa29iamVjdCAqbWspDQo+ICt7DQo+
ICsJc3lzZnNfYmluX2F0dHJfaW5pdCgmbWstPm1vZGFsaWFzX2F0dHIpOw0KPiArCW1rLT5tb2Rh
bGlhc19hdHRyLmF0dHIubmFtZSA9ICJtb2RhbGlhcyI7DQo+ICsJbWstPm1vZGFsaWFzX2F0dHIu
YXR0ci5tb2RlID0gMDQ0NDsNCj4gKwltay0+bW9kYWxpYXNfYXR0ci5yZWFkID0gbW9kdWxlX21v
ZGFsaWFzX3JlYWQ7DQo+ICsJaWYgKHN5c2ZzX2NyZWF0ZV9iaW5fZmlsZSgmbWstPmtvYmosICZt
ay0+bW9kYWxpYXNfYXR0cikpIHsNCj4gKwkJLyogV2Ugc2hvdWxkbid0IGlnbm9yZSB0aGUgcmV0
dXJuIHR5cGUsIGJ1dCB0aGVyZSBpcyBub3RoaW5nIHRvDQo+ICsJCSAqIGRvLg0KPiArCQkgKi8N
Cj4gKwkJcmV0dXJuOw0KPiArCX0NCg0KSSB3b3VsZCBoYXZlIHB1dCB0aGUgY29tbWVudCBiZWZv
cmUgdGhlIGlmLCBpdCB3b3VsZCBoYXZlIGJlZW4gYSBzaW5nbGUgDQpsaW5lIGNvbW1lbnQgYW5k
IHlvdSB3b3VsZCBoYXZlIGF2b2lkZWQgdGhlIHsgfQ0KDQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2
b2lkIHJlbW92ZV9tb2RhbGlhc19hdHRyKHN0cnVjdCBtb2R1bGVfa29iamVjdCAqbWspDQo+ICt7
DQo+ICsJc3lzZnNfcmVtb3ZlX2Jpbl9maWxlKCZtay0+a29iaiwgJm1rLT5tb2RhbGlhc19hdHRy
KTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyB2b2lkIGRlbF91c2FnZV9saW5rcyhzdHJ1Y3QgbW9k
dWxlICptb2QpDQo+ICAgew0KPiAgICNpZmRlZiBDT05GSUdfTU9EVUxFX1VOTE9BRA0KPiBAQCAt
Mzk4LDYgKzQyOSw3IEBAIGludCBtb2Rfc3lzZnNfc2V0dXAoc3RydWN0IG1vZHVsZSAqbW9kLA0K
PiAgIA0KPiAgIAlhZGRfc2VjdF9hdHRycyhtb2QsIGluZm8pOw0KPiAgIAlhZGRfbm90ZXNfYXR0
cnMobW9kLCBpbmZvKTsNCj4gKwlhZGRfbW9kYWxpYXNfYXR0cigmbW9kLT5ta29iaik7DQo+ICAg
DQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiBAQCAtNDE1LDYgKzQ0Nyw3IEBAIGludCBtb2Rfc3lz
ZnNfc2V0dXAoc3RydWN0IG1vZHVsZSAqbW9kLA0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIG1vZF9z
eXNmc19maW5pKHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4gICB7DQo+ICsJcmVtb3ZlX21vZGFsaWFz
X2F0dHIoJm1vZC0+bWtvYmopOw0KPiAgIAlyZW1vdmVfbm90ZXNfYXR0cnMobW9kKTsNCj4gICAJ
cmVtb3ZlX3NlY3RfYXR0cnMobW9kKTsNCj4gICAJbW9kX2tvYmplY3RfcHV0KG1vZCk7DQo+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvcGFyYW1zLmMgYi9rZXJuZWwvcGFyYW1zLmMNCj4gaW5kZXggNWI5
MjMxMDQyNWM1MC4uYjdmZDUzMTNhMzExOCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3BhcmFtcy5j
DQo+ICsrKyBiL2tlcm5lbC9wYXJhbXMuYw0KPiBAQCAtMTQsNiArMTQsMTIgQEANCj4gICAjaW5j
bHVkZSA8bGludXgvY3R5cGUuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvc2VjdXJpdHkuaD4NCj4g
ICANCj4gKyNpZmRlZiBDT05GSUdfTU9EVUxFUw0KPiArI2luY2x1ZGUgIm1vZHVsZS9pbnRlcm5h
bC5oIg0KPiArI2Vsc2UNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhZGRfbW9kYWxpYXNfYXR0cihz
dHJ1Y3QgbW9kdWxlX2tvYmplY3QgKm1rKSB7fQ0KPiArI2VuZGlmIC8qICFDT05GSUdfTU9EVUxF
UyAqLw0KDQpJdCBpcyBvZGQgdG8gaW5jbHVkZSBtb2R1bGUgaW50ZXJuYWwuaCBvdXRzaWRlIG9m
IG1vZHVsZS4NCg0KSWYgeW91IHJlYWxseSBuZWVkIGEgZnVuY3Rpb24gZnJvbSBtb2R1bGUsIEkg
dGhpbmsgeW91IHNob3VsZCBtb3ZlIGl0cyANCnByb3RvdHlwZSB0byBpbmNsdWRlL2xpbnV4L21v
ZHVsZS5oDQoNCj4gKw0KPiAgICNpZmRlZiBDT05GSUdfU1lTRlMNCj4gICAvKiBQcm90ZWN0cyBh
bGwgYnVpbHQtaW4gcGFyYW1ldGVycywgbW9kdWxlcyB1c2UgdGhlaXIgb3duIHBhcmFtX2xvY2sg
Ki8NCj4gICBzdGF0aWMgREVGSU5FX01VVEVYKHBhcmFtX2xvY2spOw0KPiBAQCAtODE1LDYgKzgy
MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBrZXJuZWxfYWRkX3N5c2ZzX3BhcmFtKGNvbnN0IGNo
YXIgKm5hbWUsDQo+ICAgCUJVR19PTihlcnIpOw0KPiAgIAlrb2JqZWN0X3VldmVudCgmbWstPmtv
YmosIEtPQkpfQUREKTsNCj4gICAJa29iamVjdF9wdXQoJm1rLT5rb2JqKTsNCj4gKwlhZGRfbW9k
YWxpYXNfYXR0cihtayk7DQo+ICAgfQ0KPiAgIA0KPiAgIC8qDQo=
