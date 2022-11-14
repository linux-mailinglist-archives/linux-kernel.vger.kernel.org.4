Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7E6279F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiKNKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiKNKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:04:46 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31620367
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668420009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhCMdk2a5vomTvURgF9BlMTC6wy5bCn5NvkoRGYTQHk=;
        b=Fq2J+Bk4GoG6IgQ6AtSyZGUL048m7wC1vcLiobRXBr59dEMbUXjknXWEIyEp5AYa3RSi6t
        1slP6bC88XZ6Z4bOYaLYxH/9ZnSNn26kOK0q/KkhycgOSSnG7t9YxhwMyKtjOELHvfO8iG
        Yw1Mr/Odt/bBYn6wnBIItC4UZCDleDDLiqDnOlflTyu/fn7MX5nM2RGFPsITXFTjCkM4Ws
        ZG4Ev1sX/dvtrEH1w3fHBqAEg4OL/aTkf9lG2mVtnv/qaGltX6j1ucuTKF8wQkbjdjbePO
        GtytwtjVncR+LLlXJejqGNJNDDX6L1q9jQatxVH4P3iSBMJc/ZSZyiPnFwaXUA==
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-4WOAaxjDPcu-HNgegFAbeA-1; Mon, 14 Nov 2022 05:00:08 -0500
X-MC-Unique: 4WOAaxjDPcu-HNgegFAbeA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by PH7PR19MB6483.namprd19.prod.outlook.com (2603:10b6:510:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 10:00:02 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 10:00:02 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH RESEND 1/1] x86/of: Add support for boot time interrupt
 mode config
Thread-Topic: [PATCH RESEND 1/1] x86/of: Add support for boot time interrupt
 mode config
Thread-Index: AQHY+AOGmj62zaZ8t0y44wGG1V/isq4+K3AAgAAEQYA=
Date:   Mon, 14 Nov 2022 10:00:02 +0000
Message-ID: <00ce811f-2ec8-802d-d032-8ac2c65d06ff@maxlinear.com>
References: <cover.1668403214.git.rtanwar@maxlinear.com>
 <37cc31242d0edda1bb0900cc62bba87954a7e892.1668403214.git.rtanwar@maxlinear.com>
 <Y3IOEFTZ1e/7uWJ4@smile.fi.intel.com>
In-Reply-To: <Y3IOEFTZ1e/7uWJ4@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|PH7PR19MB6483:EE_
x-ms-office365-filtering-correlation-id: 851f7a35-6337-44f7-a1d0-08dac626ff86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +Zmi9zvCqe1yMvGf5Dm9ljtp4HsdY3mMkJhnfNW9sM7t0J6lhlAuv1n2VIUYvy9s8bZX1+/eAhURr7K3sbOyzWiUBj+K1dcfmd0MtXmHSSYpx++OCWTk8FD3Ngnivivr0N01k09TgRZvVxNJ7AQmrzslTTSUYhF09U1kOa4J4vNn35aUfYzHxQol2hRzvRQjSnpDtieXpfctxTgWb/E3f5NIaQ37Q3tumTzvdbvagyL0h8HdkMpnk0hmDEeqz1zO7tbfU2yXgoNcJTAcG0FjihH9GFOsIPaUQn7pk64qULeo7UzyW6dqslPEsIRxEkGIDn92I+K57/QEu04tk6defCp1Z7dXMThwVymKaVC8l5AQCTvV04zy4/tZE2+RgC4Cz+YHfzX29w2Ju0oBIKyB5AzgomILxnRNEenniEYSJuFvAwPUawreQKWLlDP1MfyGhHHOHfM3g/CQp3DYQAzijnEGfb5dM4wwj6Xa6v7WGYDZIQVjYUUmXguzRvqA0A8OXHuiXxpKs1pzz1c9AC9nnyaQHAhWX9PdqIHR3kdyeqahnb6/ju9ADpC4pK7b50BcOm5+UQFwLQ17PcO+7cu6azMr4VTQFwQaMoATy/bk8wIe8W2cGjfFjp1+7R9MgGUwDdFAbMpSHCKrczddM4ZCJrci3Kpb7qq59VVeGTARHwp1V5egYYyycn2osZTvUxMHi7QK0cTJjIXcbQY1Mw0s5LKElZHfh16/t2CIbBRvbigHaiNv8sMFjKUSZP7+mTjiQKBDWCyhUmpS013ovBhH85FY5uPnV7k3QPZGboJ/876cJMYxjDiCYGALcCyHCSycnzrbrMU9g0tkve/1rtP32XYyr06eNnck46a+OQe0nhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39850400004)(366004)(376002)(136003)(451199015)(54906003)(6916009)(86362001)(38100700002)(6506007)(316002)(122000001)(53546011)(2906002)(8936002)(2616005)(5660300002)(36756003)(7416002)(186003)(83380400001)(31696002)(41300700001)(64756008)(91956017)(66946007)(76116006)(66446008)(66556008)(4326008)(8676002)(26005)(66476007)(6512007)(38070700005)(31686004)(478600001)(6486002)(966005)(107886003)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3FOd0tQSzlqSlpsZlAxMGkyOTBJY0Q0SSsvcnYwTSs1ekNldU4yUEhTclcw?=
 =?utf-8?B?WjJranI0eTQ2WEd2YUpyQnhYQzlqYnBmWWorRVdXNTd2MmU5aUFCMlVFVGZ1?=
 =?utf-8?B?RUdwNVM3NUpSVlY0OGlRZ0RoOFk5ZmVway9kc2ZvRHJ1RDU0cnh5TGdaZmdm?=
 =?utf-8?B?ZEFjcktOWnBTcCtKZjBsTFU5S2lkR3BObGNHaG5yNHJ1b3Q0RExhQXlSN1RW?=
 =?utf-8?B?SStidUl1bkw5WDg3aUtxQnI5VFVUL1hQbU1mVUJSM2hEclZoY21WVTNOc0No?=
 =?utf-8?B?bUhETmJFWGhTOURMR0lKdFhobVQyb3NDMFNSQ3hNaVdENUlXaEcyMzdWY1BP?=
 =?utf-8?B?T0RPVEVwYnNqbmRFaGVaMlhMenRCanM4WnZTWHlCL24rWkxhdVFuY00wRFUw?=
 =?utf-8?B?Tkt3eGlmNS84UElxdnlwZ1RTQ1pGeFc4cCtaQk5XdDAyYitFdnRwb0dmRGtS?=
 =?utf-8?B?RHhOMXRCZHNRc09Zelk2SmYzRk1MU1JTRmRtQjFMWk9qbGhhclpSNlMwMWtp?=
 =?utf-8?B?dm45cVc1RUNNQU5sb3ZWYjRxd0lLOUFCc0pnS2RtTmwrTVRkQU1wZ0Z2VFp2?=
 =?utf-8?B?cFV5Z3ZzTkNwekg0c2x6clRCRHM4d3pURW9ua200NlNKM2hOekhjMXVvcGR3?=
 =?utf-8?B?MWxWeVArRzE4MFJiQnBibGNsM0JnVGVIdjF0UnNMemlDck9lK0JmanV2cTk5?=
 =?utf-8?B?MU0wZFplWWpKbmxySXJUMkhlUkJNRk90Z243RkZLYXk2anpXUkR1RFRiTWNw?=
 =?utf-8?B?cGVhbHBpTWJjMGcxdDFJVzNiYlZweFk2NjVaczNqbWNXejI5cHRZb2VON3ZS?=
 =?utf-8?B?S2RuS0MzMFBhNlkyQllPYXI1VUhOL1dXa3ZheHRkUzNueEt4TWJDaFFrQktj?=
 =?utf-8?B?ZTlzcGxKVkdIQjRWYVZ3NHNyeFBZYWorMzJ6TXozRDlXRDBzdi9FemFSRXhx?=
 =?utf-8?B?YmNoTW5HeGowWkoyMTlNRGlnUk93aFozd1ExQlVZaDZuN1F3Vi9yRTBPcmxN?=
 =?utf-8?B?OGM4RmxMYXViNzZHVWpnZFFpYXBHY3FhREJ0V0lIWWpLZ3BaQ2VibjRxbHRQ?=
 =?utf-8?B?TVNTSUgwQ3RaOC9obm9zTWdYbmNMYytjQWpwbUtYVUZINXBneWRXMXowOFR3?=
 =?utf-8?B?MUJweFk0UTRWM0xhcmtqTVVWUGY5VWtRcVBYdUt4V29tcDMwV2NzTWZMamhF?=
 =?utf-8?B?NmJXSkVaaU91SVlIaGFKbDVBd2xtYVpBMThJQ0lCNTU4ZFhpK0g5ZjNzWnZj?=
 =?utf-8?B?Mm9FeDFoZkYxamFtZWJ5Z2xPbDZHckpaOCt1Titoa05kWWRjd0wvK1RnYVNj?=
 =?utf-8?B?aTh0V0Jvakhta3hTODVhUlJPaG9Fa3c1dEFoLzlYV3VMTmo5bmF4Q3NKZkh4?=
 =?utf-8?B?UXZOZmZYdWNWTVNyTXdNMnVNbW5YSTRZMXZpNXkxTmNOSVo0N2tJckNhS2RB?=
 =?utf-8?B?TXVuL2xCL1pVQVBRL2hnMWlRNmdUVWJaclFFNVN6NzZuYkNBTThHVStSUklD?=
 =?utf-8?B?R2x1VnhSUUJCTHdjQXJuMzF2cTgzOW5ZMll5cDN1NlJxYkVoc1dpV0NCUEd4?=
 =?utf-8?B?Y2dISDVXVXhHRUdQWW45MmMwZjN5M3haMzR2NzZSTFpOMUV5d1lzblI0Um1Q?=
 =?utf-8?B?SHA1SU9iRnhhbmpMY1RhbWppN0ZnTDFaR2IzUkxoMlRIajMwRVJMSUhvNHB2?=
 =?utf-8?B?MUNsYzJFeGRWbFpCemxiQWYwaDU4anZ1eCtMNnhNdzk5Si90S1VaMmNqK1A5?=
 =?utf-8?B?UUlSSXVmQjdHa3JuZnFXTlcrTXhhR1FlcWV5TStHQU55VHFTUWkwMHBNOUlX?=
 =?utf-8?B?RmRGMkRDU1RlbjYzLzA3MkM3b01pR0NsN1JBKzJHTStiVnFkeTVVanFVSi9O?=
 =?utf-8?B?dXdMOU9zZE9leHd5dVFiOVJHTXQ5UldmZUhGVTg3cTVYK2FvaTQ1V3BYMDFm?=
 =?utf-8?B?TjBNaktjZjlWSnNlOStJbm9nKzlYb1BGWVBBbTlTcDBrTi9SeVBFRldDenZx?=
 =?utf-8?B?Y1E5SldqRzE5Z0NIdHlqWkpoVUpUcEQ1dkRDaEdoeExZRGI2U20vc0hlOGtp?=
 =?utf-8?B?ekRQNGM4SWJWNDRlcGdFZUVZODJsbTdmcG8yYzRuenRtcEU2L3cxajJQLzdY?=
 =?utf-8?B?MW56Ui81eE5WTzVCY3J1NHpIdk1kb2twZ2N6YmhwOU1GTWU0U1B3NlF4OUZq?=
 =?utf-8?B?UkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f7a35-6337-44f7-a1d0-08dac626ff86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 10:00:02.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kwOPtxygoBFxw4qyERQVei1f1Nj684yJehWQLMwoV320mF6jcjS5v1Bza7OrYw9Jc/5j5HbmRHfZrcL1i1D5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6483
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <DD203E155DCC104F9E3B0BB668891409@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbmR5LA0KDQpUaGFua3MgZm9yIHJlc3BvbnNlLg0KDQpPbiAxNC8xMS8yMDIyIDU6NDUg
cG0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gVGhpcyBlbWFpbCB3YXMgc2VudCBmcm9tIG91
dHNpZGUgb2YgTWF4TGluZWFyLg0KPiANCj4gDQo+IE9uIE1vbiwgTm92IDE0LCAyMDIyIGF0IDA1
OjIwOjA2UE0gKzA4MDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4+IFByZXNlbnRseSwgaW5pdC9i
b290IHRpbWUgaW50ZXJydXB0IGRlbGl2ZXJ5IG1vZGUgaXMgZW51bWVyYXRlZCBvbmx5DQo+PiBm
b3IgQUNQSSBlbmFibGVkIHN5c3RlbXMgYnkgcGFyc2luZyBNQURUIHRhYmxlIG9yIGZvciBvbGRl
ciBzeXN0ZW1zDQo+PiBieSBwYXJzaW5nIE1QIHRhYmxlLiBCdXQgZm9yIE9GIGJhc2VkIHg4NiBz
eXN0ZW1zLCBpdCBpcyBhc3N1bWVkICYNCj4+IGZpeGVkIHRvIGxlZ2FjeSBQSUMgbW9kZS4NCj4+
DQo+PiBBZGQgc3VwcG9ydCBmb3IgY29uZmlndXJhdGlvbiBvZiBpbml0IHRpbWUgaW50ZXJydXB0
IGRlbGl2ZXJ5IG1vZGUgZm9yDQo+PiB4ODYgT0YgYmFzZWQgc3lzdGVtcyBieSBpbnRyb2R1Y2lu
ZyBhIG5ldyBvcHRpb25hbCBib29sZWFuIHByb3BlcnR5DQo+PiAnaW50ZWwsbm8taW1jcicgZm9y
IGludGVycnVwdC1jb250cm9sbGVyIG5vZGUgb2YgbG9jYWwgQVBJQy4gVGhpcw0KPj4gcHJvcGVy
dHkgZW11bGF0ZXMgSU1DUlAgQml0IDcgb2YgTVAgZmVhdHVyZSBpbmZvIGJ5dGUgMiBvZiBNUA0K
Pj4gZmxvYXRpbmcgcG9pbnRlciBzdHJ1Y3R1cmUuDQo+Pg0KPj4gRGVmYXVsdHMgdG8gbGVnYWN5
IFBJQyBtb2RlIGlmIGFic2VudC4gQ29uZmlndXJlcyBpdCB0byB2aXJ0dWFsIHdpcmUNCj4+IGNv
bXBhdGliaWxpdHkgbW9kZSBpZiBwcmVzZW50Lg0KPiANCj4gLi4uDQo+IA0KPj4gKyAgICAgaWYg
KG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkbiwgImludGVsLG5vLWltY3IiKSkgew0KPiANCj4gSSBj
YW4ndCBmaW5kIHRoaXMgcHJvcGVydHkgaW4gdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy4NCj4gDQo+IE1vcmVvdmVyLCBJIHByZWZlciB0byBzZWUgcG9zaXRpdmUgb25lLCBz
b21ldGhpbmcgbGlrZToNCj4gDQo+ICAgICAgICAgIGludGVsLHZpcnR1YWwtd2lyZS1ibGEtYmxh
LWJsYQ0KPiANCj4gUGxlYXNlIGNvbnN1bHQgd2l0aCBEVCBwZW9wbGUgb24gaG93IHByb3Blcmx5
IG5hbWUgaXQuDQoNCg0KWWVzLCBhZ3JlZS4gTmVlZCB0byBhZGQgaXQgaW4gYmluZGluZ3MgZG9j
IGFmdGVyIGZpbmFsaXppbmcgdGhlIHByb3BlcnR5IA0KbmFtZS4gSSBjaG9zZSAiaW50ZWwsbm8t
aW1jciIgdG8gaGF2ZSBhIGRpcmVjdCBjb3JyZWxhdGlvbiB3aXRoIHRoZSBNUFMNCnNwZWMgZGVm
aW5lZCBkYXRhIGZpZWxkIGZvciB0aGUgc2FtZSBwdXJwb3NlLiBJdCByZWFkcyBiZWxvdyBiaXQg
aW4gDQptcHBhcnNlIGNvZGUgdG8gZGV0ZWN0IFBJQyBtb2RlIG9yIHZpcnR1YWwgd2lyZSBtb2Rl
Lg0KDQpCaXQgNzogSU1DUlAuIFdoZW4gdGhlIElNQ1IgcHJlc2VuY2UgYml0IGlzIHNldCwgdGhl
IElNQ1IgaXMgcHJlc2VudCBhbmQgDQpQSUMgTW9kZSBpcyBpbXBsZW1lbnRlZDsgb3RoZXJ3aXNl
LCBWaXJ0dWFsIFdpcmUgTW9kZSBpcyBpbXBsZW1lbnRlZC4NCg0KUGxlYXNlIHJlZmVyIFsxXQ0K
DQpbMV0gaHR0cHM6Ly93d3cubWFudWFsc2xpYi5jb20vbWFudWFsLzc3NzMzL0ludGVsIA0KTXVs
dGlwcm9jZXNzb3IuaHRtbD9wYWdlPTQwI21hbnVhbA0KDQpSZWdhcmRzLA0KUmFodWwNCg0KDQo+
IA0KPj4gKyAgICAgICAgICAgICBwcl9pbmZvKCIgICAgVmlydHVhbCBXaXJlIGNvbXBhdGliaWxp
dHkgbW9kZS5cbiIpOw0KPj4gKyAgICAgICAgICAgICBwaWNfbW9kZSA9IDA7DQo+PiArICAgICB9
IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICBwcl9pbmZvKCIgICAgSU1DUiBhbmQgUElDIGNvbXBh
dGliaWxpdHkgbW9kZS5cbiIpOw0KPj4gKyAgICAgICAgICAgICBwaWNfbW9kZSA9IDE7DQo+PiAr
ICAgICB9DQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtv
DQo+IA0KPiANCj4gDQoNCg==

