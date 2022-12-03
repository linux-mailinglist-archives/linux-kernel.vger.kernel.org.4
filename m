Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF69641860
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLCSIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:07:59 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2085.outbound.protection.outlook.com [40.107.9.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3441B1E1;
        Sat,  3 Dec 2022 10:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/f6PGAbg8yvl+jQRsEcGJqruskq+L0HSbQme/iL/5JC7SnOHtqsJGO6JK6DfdsU0CUNE1+HZBQcu7ER2yhDDB3fQD9lfg1zCy8rYiiXYXl6xNTfto69hwJ9hXxBU2GumNB7t8seit5zpwX65nvzF1uc6A2ostG7lUqagJ5JTsS+7CVc8TC7hQ9npZyX4lNTsh2+UJjleET3uiv9lqFsz9qVa0g0UCj7FzpJBz0jS4y7c0UAewjxp8v+PSJ5JGRBfdsirOfkEYThOoHr8ulHABIA60apLUpdLhAMSRLG1oKPfV5Nds/36S3AwfC1IDuZ2i4M6ViA0MNb7uWLhXEboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3bkmbpXrOcWYfHrw42ca/vnQQAkDzLqt9MkbeuqnYQ=;
 b=mouWc3IXoAMY8FKdmTwVvzh8aX7HYSSRREaiAjzkOP9ynAama5EnvE+KpZW2o7OTk10p200EHpCn8DUErvRmDm14dVbfky4sYEg3o4YcNVW90c5g+ypUIAU7yveU+8kLnCSS0MRGyyxIEFr0LGv4gGYEFi0ooSNxRZbcpkMfx78FQWQNnhgcX93VWtCjM72+toKMqbMZEJ5ll0pN0w+g5aNBDMrvAmBPYrtaBl0ip9avkhhgQtf+9FJS32vo/ePUmArA7YC+3/XIMnBDKa+YDC4rgG3BUnPWMJgNRU+tf5BaEmOOeuoEoSoFlXYEKckt+4QUNWnpscG9L7al/HoSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3bkmbpXrOcWYfHrw42ca/vnQQAkDzLqt9MkbeuqnYQ=;
 b=qL908GSmk/u4hR4viIjnMHy/vxcC5VCgx6UZCZTbzYJlDO17VkF3TV0RsWG7sThG+8bnqpbXy56WoCfjF1b0Qb7oFx06tnE9rKRigWZw7p8xNwSZlAWsOjHPzsHwkGpKaA7hPX5IwvIY5YvBerOH/ntZELb4HvNzszC4w0xl7PcokRovU4Z9Ykfm8ojZILxnV+EGCLmq+aaqIZbmYXC8H6zn95m6EDp94ZnBT+nfKzLCM+ehiYvvZLzdjlhzfSU2GfRIPGjgIL/K7oUtnripYgzuFnRiTepNEv5qQ6b83a1fctxN+4ACbbIq2TsaskmbzG6LFPYt/uzSWAC9E37qRA==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PR1P264MB1789.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Sat, 3 Dec 2022 18:07:53 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 18:07:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 2/5] drivers: Add bus_for_each for iterating over the
 subsystems
Thread-Topic: [PATCH v6 2/5] drivers: Add bus_for_each for iterating over the
 subsystems
Thread-Index: AQHZBqArSG7nrwpx/UON+4SmVyyWk65cdxKA
Date:   Sat, 3 Dec 2022 18:07:53 +0000
Message-ID: <8831b90c-4968-a618-a6ba-4bfcc97f74eb@csgroup.eu>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-2-allenwebb@google.com>
In-Reply-To: <20221202224744.1447448-2-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PR1P264MB1789:EE_
x-ms-office365-filtering-correlation-id: 37a8196e-fc67-4ece-13cd-08dad5594c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzi97HFaga0uBMYo5IKCFY+hodRQub7U5D0gJLAB8di3CEPKgqYgZrHB5EJgBX7nNa7XLYW93F6TVJ9c1DHAzHl3X8GqvTmtY4BWPrFHucKS7zwfj8OFp/37F4QKdn/J2M/LON/w1WYd3Ls8ELtCWpBsZK7hAQz5AUZHWHmGEI8nYmHiWWnlmelGgY9tdWrMk4pOh/Tebzagru/97/w7xemZHz0C2hnxzoaCFTn8808YlluT11xlAMBYUECvKvdvBdsq60rUbl8Y3U5aepstKprUVJMA2ZCz5lGgXPuMig6ASEtiB6Cv6JQw54X988YdOdNyU7Br34lv+bXUC4U84Ten02T75coCT6si46oEEe/KfxmxeJHDMVS59PAVkJTtiTAM45TdaAtqPocWx/5BY4Bbc9Df0hmyLtfuDW4nmP/uYALhpuxiF2V2TI5fwDA5Ztz7655zOo06bVOB2Fxy7YFGp4R9rpNEnrDmvsBcpCr3YUssqVeEiqKQZblOb+RF2DSZj/V+Dnr9pqEwcgIhvE8u3mGC0AEyZwRukj82OJoJDTSSPimjXxsdV7nk3QLrr8i49qcessXtjB5TsluqaSfkalcQ0omlz88YThhUILV9KJOwI4WTuAF55E0mqzGXKUBMdM3WkshIPDIA2GIUFzUS1iqZ0aSxz2Z240Zu9jL7Y6FToX3WWl1xH7jjPjT9uR7d/nlpZX9AU8NGo4mPwv5v8rrUznQq0IHfpGZlbOxxjC/W8f3N6GZ2NnWlBOLtIwBP6TH2+b/FrBxY32m15Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39830400003)(366004)(136003)(451199015)(110136005)(36756003)(6506007)(2616005)(6486002)(4326008)(66574015)(186003)(316002)(64756008)(2906002)(8676002)(31696002)(86362001)(91956017)(8936002)(6512007)(26005)(66946007)(83380400001)(66476007)(66446008)(66556008)(54906003)(478600001)(41300700001)(76116006)(31686004)(71200400001)(38070700005)(5660300002)(122000001)(38100700002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1h5YlZTTTgrWUhVY1NFb2NQbDJ0S2RRMytTVE8vdklIOW9OVU1vbmRjUEcv?=
 =?utf-8?B?QWRQOThwVjRKdFViUTFPNGhIQ1Ara3RqMkt0RWpUN3JxRnBIR2dZcUFHeUZD?=
 =?utf-8?B?anZ4cndOb2xWaEpZUlYxNFdHNE9OVnVFQlNTNTZFMlZKNzE0VkQzU3RsaEdw?=
 =?utf-8?B?RlhValRBRkhqWW52NHluQVB2RnpvNm1XNDZ5Q2pad3lXRDZvczB6d0dxV2RL?=
 =?utf-8?B?NHM4a24yMHJNN2poT1Fxem11cWJuMHI2VlF1eWwwUFp1L2hFS1VVbnNHdElO?=
 =?utf-8?B?R0VVMXpmbTM3bU9LUGwvL01yV0lWTDVVWkdsWXJjc0lJWVU0UlpxWUx1MnNF?=
 =?utf-8?B?NkdjM3R6ckxySDVnNzV3c1VwckNDK3BXVUxtb1ZPQ083UmlNMFhyNFpDb3NF?=
 =?utf-8?B?bTR5M2hOYmdFL2hNbmRvWDkxSG5LVUpHby8wdDRhWklJOFZYL1pFSWZJQ1VB?=
 =?utf-8?B?RHZha0M3UVNqeEZFTVdXcWtMYlNTOGVRYktvN0hydWZyVWlXa3ZPMmRJa0Fr?=
 =?utf-8?B?NkN3cGVMUEFucnhqYjNka0pJS3padDJtMGthQ2ZGOTFlNkpaWktNc1hzUnA4?=
 =?utf-8?B?QWJSOTBIT3FucGFkcFdPdDc0YVpwZDJGeWZuVlJaUDNTUnByMW13Z2d1R1RF?=
 =?utf-8?B?bEFjVEpOOEFEa1loTFM2SmxRc0piQ1lZZWxwQ0ZkSDFNa1hwRG1rRXBzazJn?=
 =?utf-8?B?RHh6TFdMLzV3cHErVkJiNU5rNGYrT3I2THoxVUlwU0ZnbnEzWGhzeWdKTnMr?=
 =?utf-8?B?d3VIdytXU09FRUFvYU5OQWJJVkthY3d5eE1MU2w2TUJyVW8wbzlsOEtpeUp1?=
 =?utf-8?B?cEhlL20vY0tUanVQVVhpblNnTStzYjFwUkpRNENLSWVhUlRJSUlwK3U3WXVw?=
 =?utf-8?B?Nk45Z0QrWERUbEJqd1F1eFRFUzdCV0YyZTA0bk9VRVA0aWJkc3pHTFpkeGFQ?=
 =?utf-8?B?cGpaVnJhbm02WlRwTmFyeXFjb1pkWkdvamxFblRQcnFiMVBSYXlGNXJhcWtO?=
 =?utf-8?B?NmNHQ0Jpc09vcnFMWG5KU0hLQ3NwS2czTGF0bVlLSnlFUFJaSUtwYitQTVo5?=
 =?utf-8?B?Z3p5VVhvRVIyaEkyVWlXcHpJbFRTOTlWellubDMvdjRzaElscU5XT0hKVVZM?=
 =?utf-8?B?MTRpQXZzNjBJbGhBOFd4dGhUKzg1ZDZ2OFBxMnZrU3B6OWRyemtSc2g1b0dz?=
 =?utf-8?B?cjV6UDJZbWtEWlZySEhxVHAyRzc5QXhRdDBFNG9yV01ONE9uOTE2UGZlbEho?=
 =?utf-8?B?a2NaRG1FYVEwWEhnb3A4QmczL2FYRjBnQVBNclh6NHgyczRpUGtIaDFkTHpO?=
 =?utf-8?B?Qm9EK3B3SE9LZTdoNFNLVW1uVWIrdmx2UDdQZ21QSkV2ZGRYcWhKeHpzSnds?=
 =?utf-8?B?bnJEZmVDMGpRRmZGWHduZFJSbnJwdXRyVUVKZXoyaUU2VUk5Z2xJRlh1REhK?=
 =?utf-8?B?VlEvWk5Jek5BQXZzNy8wOGVPcFpIWVFjNXBCaEMrbWpURnVKenl4eWh5Uk41?=
 =?utf-8?B?bjdLKzM5QTh6THdVODBza08rL2QxQkxBNWVTVzlhcWtnMXFTdWcyMjBrK1VO?=
 =?utf-8?B?Q1kyQ3hDSjUydGNlRVNvZW5MWEpIWUo2U1BheTlHZ21teGlRWk0wUUdzeEk4?=
 =?utf-8?B?eStFeXAvRVBFenk2cmtybENNeHVMamdITGpkamw4YmdGU1hpS284WktoZE9X?=
 =?utf-8?B?OEJjN2tML0hscnRJaW9LSUI1QjNPODArRWN2aklXWUdkdjA0MzJRQXpTQ3hU?=
 =?utf-8?B?NjZLZEJBS21QUURoK3pIYVlJdFFiWG1qZjZJbDNDMXU0eXVJM3BTd0VMRHdh?=
 =?utf-8?B?Mkt5bStiQTl0QXBpTkRpb3FjMTl5SWRxaG5BNVdRMGJoVzZWZWx0YkYwYksx?=
 =?utf-8?B?UUpFNGdFZmg4OVF4ZElQbzZZazZSaTlQZHJJYm1pTllUT2FMVGllN2JiWTZE?=
 =?utf-8?B?c2p6b1ZER1hscVEwY3pXS2kwbXhTbThEejhwVlduaUZaSjlpaGxESkRPMVNy?=
 =?utf-8?B?VUpUSlBLRDQ5SmRRdC9UUDhQQkwwVXl1WFBtV3V2dnM4NXQ3MGVwbzhZT0JC?=
 =?utf-8?B?dmVrUTFaNTJUSXpwa3RHYmdHQlFoSUxCWmpGb3FmeVE0UG1QUkVpN2REVFFD?=
 =?utf-8?B?UG9oeUFPamxEa0tHajFRcEJCSG9Uai81TmxQNFRVdmU3VFZGbk9sZERYUHQv?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C178C89BF4334A4BA3525B049DEF7E93@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a8196e-fc67-4ece-13cd-08dad5594c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 18:07:53.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbMM/s7oq8Y2eT9Vi4b8vO1HtHKoADXxPhhA+02sZhYqbymzRwTh4kysu9RYuh39YFsTtpWqyCTmElSlK8TRcWU5aD7OD+y8asx8/7B9qG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1789
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzEyLzIwMjIgw6AgMjM6NDcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gSW4g
b3JkZXIgdG8gcHJpbnQgdGhlIG1hdGNoLWlkLWJhc2VkIG1vZGFsaWFzZXMgaXQgbXVzdCBiZSBw
b3NzaWJsZSB0bw0KPiByZWFjaCB0aGUgbWF0Y2ggaWQgdGFibGVzIG9mIGVhY2ggZHJpdmVyLiBX
aXRoIHRoaXMgZnVuY3Rpb24gaXQgYmVjb21lcw0KPiBwb3NzaWJsZSB0byBpdGVyYXRlIG92ZXIg
ZWFjaCBzdWJzeXN0ZW0gd2hpY2ggY2FuIGJlIHBhaXJlZCB3aXRoDQo+IGl0ZXJhdGluZyBvdmVy
IGVhY2ggZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxsZW4gV2ViYiA8YWxsZW53ZWJi
QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmFzZS9idXMuYyAgICAgICAgIHwgNDIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL2xpbnV4
L2RldmljZS9idXMuaCB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYnVzLmMgYi9kcml2ZXJzL2Jhc2Uv
YnVzLmMNCj4gaW5kZXggN2NhNDdlNWIzYzFmNC4uNGUwYzU5MjU1NDVlNSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9iYXNlL2J1cy5jDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9idXMuYw0KPiBAQCAt
MTc4LDYgKzE3OCw0OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtzZXRfdWV2ZW50X29wcyBidXNf
dWV2ZW50X29wcyA9IHsNCj4gICANCj4gICBzdGF0aWMgc3RydWN0IGtzZXQgKmJ1c19rc2V0Ow0K
PiAgIA0KPiArLyoqDQo+ICsgKiBidXNfZm9yX2VhY2ggLSBidXMgaXRlcmF0b3IuDQo+ICsgKiBA
c3RhcnQ6IGJ1cyB0byBzdGFydCBpdGVyYXRpbmcgZnJvbS4NCj4gKyAqIEBkYXRhOiBkYXRhIGZv
ciB0aGUgY2FsbGJhY2suDQo+ICsgKiBAZm46IGZ1bmN0aW9uIHRvIGJlIGNhbGxlZCBmb3IgZWFj
aCBkZXZpY2UuDQo+ICsgKg0KPiArICogSXRlcmF0ZSBvdmVyIGxpc3Qgb2YgYnVzZXMsIGFuZCBj
YWxsIEBmbiBmb3IgZWFjaCwNCj4gKyAqIHBhc3NpbmcgaXQgQGRhdGEuIElmIEBzdGFydCBpcyBu
b3QgTlVMTCwgd2UgdXNlIHRoYXQgYnVzIHRvDQo+ICsgKiBiZWdpbiBpdGVyYXRpbmcgZnJvbS4N
Cj4gKyAqDQo+ICsgKiBXZSBjaGVjayB0aGUgcmV0dXJuIG9mIEBmbiBlYWNoIHRpbWUuIElmIGl0
IHJldHVybnMgYW55dGhpbmcNCj4gKyAqIG90aGVyIHRoYW4gMCwgd2UgYnJlYWsgb3V0IGFuZCBy
ZXR1cm4gdGhhdCB2YWx1ZS4NCj4gKyAqDQo+ICsgKiBOT1RFOiBUaGUgYnVzIHRoYXQgcmV0dXJu
cyBhIG5vbi16ZXJvIHZhbHVlIGlzIG5vdCByZXRhaW5lZA0KPiArICogaW4gYW55IHdheSwgbm9y
IGlzIGl0cyByZWZjb3VudCBpbmNyZW1lbnRlZC4gSWYgdGhlIGNhbGxlciBuZWVkcw0KPiArICog
dG8gcmV0YWluIHRoaXMgZGF0YSwgaXQgc2hvdWxkIGRvIHNvLCBhbmQgaW5jcmVtZW50IHRoZSBy
ZWZlcmVuY2UNCj4gKyAqIGNvdW50IGluIHRoZSBzdXBwbGllZCBjYWxsYmFjay4NCj4gKyAqLw0K
PiAraW50IGJ1c19mb3JfZWFjaCh2b2lkICpkYXRhLCBpbnQgKCpmbikoc3RydWN0IGJ1c190eXBl
ICosIHZvaWQgKikpDQo+ICt7DQo+ICsJaW50IGVycm9yID0gMDsNCj4gKwlzdHJ1Y3QgYnVzX3R5
cGUgKmJ1czsNCj4gKwlzdHJ1Y3Qgc3Vic3lzX3ByaXZhdGUgKmJ1c19wcnY7DQo+ICsJc3RydWN0
IGtzZXQgKnN1YnN5czsNCj4gKwlzdHJ1Y3Qga29iamVjdCAqazsNCg0KVGhvc2UgdmFycyBhcmUg
bm90IHVzZWQgb3V0c2lkZSBvZiB0aGUgbGlzdF9mb3JfZWFjaF9lbnRyeSgpIGJsb2NrLCB0aGV5
IA0Kc2hvdWxkIGJlIGRlY2xhcmVkIGluc2lkZSB0aGUgYmxvY2suDQoNCj4gKw0KPiArCXNwaW5f
bG9jaygmYnVzX2tzZXQtPmxpc3RfbG9jayk7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5
KGssICZidXNfa3NldC0+bGlzdCwgZW50cnkpIHsNCj4gKwkJc3Vic3lzID0gY29udGFpbmVyX29m
KGssIHN0cnVjdCBrc2V0LCBrb2JqKTsNCj4gKwkJYnVzX3BydiA9IGNvbnRhaW5lcl9vZihzdWJz
eXMsIHN0cnVjdCBzdWJzeXNfcHJpdmF0ZSwgc3Vic3lzKTsNCj4gKwkJYnVzID0gYnVzX3Bydi0+
YnVzOw0KPiArCQllcnJvciA9IGZuKGJ1cywgZGF0YSk7DQo+ICsJCWlmIChlcnJvcikNCj4gKwkJ
CWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXNwaW5fdW5sb2NrKCZidXNfa3NldC0+bGlzdF9sb2Nr
KTsNCj4gKwlyZXR1cm4gZXJyb3I7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChidXNfZm9y
X2VhY2gpOw0KPiArDQo+ICAgLyogTWFudWFsbHkgZGV0YWNoIGEgZGV2aWNlIGZyb20gaXRzIGFz
c29jaWF0ZWQgZHJpdmVyLiAqLw0KPiAgIHN0YXRpYyBzc2l6ZV90IHVuYmluZF9zdG9yZShzdHJ1
Y3QgZGV2aWNlX2RyaXZlciAqZHJ2LCBjb25zdCBjaGFyICpidWYsDQo+ICAgCQkJICAgIHNpemVf
dCBjb3VudCkNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZGV2aWNlL2J1cy5oIGIvaW5j
bHVkZS9saW51eC9kZXZpY2UvYnVzLmgNCj4gaW5kZXggZDhiMjljY2QwN2U1Ni4uODJhNTU4MzQz
NzA5OSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZpY2UvYnVzLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9kZXZpY2UvYnVzLmgNCj4gQEAgLTE2MSw2ICsxNjEsNyBAQCB2b2lkIHN1
YnN5c19kZXZfaXRlcl9pbml0KHN0cnVjdCBzdWJzeXNfZGV2X2l0ZXIgKml0ZXIsDQo+ICAgc3Ry
dWN0IGRldmljZSAqc3Vic3lzX2Rldl9pdGVyX25leHQoc3RydWN0IHN1YnN5c19kZXZfaXRlciAq
aXRlcik7DQo+ICAgdm9pZCBzdWJzeXNfZGV2X2l0ZXJfZXhpdChzdHJ1Y3Qgc3Vic3lzX2Rldl9p
dGVyICppdGVyKTsNCj4gICANCj4gK2ludCBidXNfZm9yX2VhY2godm9pZCAqZGF0YSwgaW50ICgq
Zm4pKHN0cnVjdCBidXNfdHlwZSAqLCB2b2lkICopKTsNCj4gICBpbnQgYnVzX2Zvcl9lYWNoX2Rl
dihzdHJ1Y3QgYnVzX3R5cGUgKmJ1cywgc3RydWN0IGRldmljZSAqc3RhcnQsIHZvaWQgKmRhdGEs
DQo+ICAgCQkgICAgIGludCAoKmZuKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpKTsN
Cj4gICBzdHJ1Y3QgZGV2aWNlICpidXNfZmluZF9kZXZpY2Uoc3RydWN0IGJ1c190eXBlICpidXMs
IHN0cnVjdCBkZXZpY2UgKnN0YXJ0LA0K
