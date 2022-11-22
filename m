Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE66338E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKVJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKVJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:44:16 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883715739
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669110197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJt8UO5HCN244lOs57k4IKcNhRBmsr6a2T34jRgGHOw=;
        b=R1A2u0UU3QHC4cHmuj73dv85/9epa89VX0H6sxWHilHja80wZUp/hSdL9NpQmKSvUdcYDj
        qFFnGHBRtfC/jtakyjopaktu+iWg0Cm+IzqgRZAxbDdOc8ZOvqms02mCfo9mWoqmCpYQN3
        xSFj50LrrD2NDAQ6XC2iZaatxGzKjrxx85JSBVrNn3rAVI1da4fAIyW9rcDcnK4W/IOptv
        +orRVGB4CWMCBRf35BA79FB18vKMuvy3O1Jm8y42RSlBp/Egav73Fure1EnvZpeI4miYP4
        +0CtsYvC09s0xtLwkTBKupNJNrkObuHEtxhl7uNGJsRKHGVrZhDGpfZ0YKcyvA==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-EL0DA8YfN_2CArK8py74vg-1; Tue, 22 Nov 2022 04:43:16 -0500
X-MC-Unique: EL0DA8YfN_2CArK8py74vg-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by IA1PR19MB6499.namprd19.prod.outlook.com (2603:10b6:208:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 09:43:12 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:43:12 +0000
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
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Topic: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Index: AQHY/kRfW1rEdSurPU+OlYduityf0q5Kp+8AgAAJMgA=
Date:   Tue, 22 Nov 2022 09:43:12 +0000
Message-ID: <b790fa4b-e2d8-ad21-09a3-6b92c863343f@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
 <Y3yR+Ouc7l9RvB8K@smile.fi.intel.com>
In-Reply-To: <Y3yR+Ouc7l9RvB8K@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|IA1PR19MB6499:EE_
x-ms-office365-filtering-correlation-id: 489c7d8c-c867-41c2-34fd-08dacc6df8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hnTbb+2z3/RnE1LdkQgt94ZCitWf14xRgDCBCklCJQ8RlCx9+R8oMiWFk2rgupJ0OtkB2NLUaz+5LBawQQwDHXSLQwGUDqV5p65mx784JkiV0SISr1Iit0KgjRgNuOGbDDSuCEy8+K2IPUP1MmFVNG5oQA6jeRYICXTB8RfW02f40MaWXcotl4MOde/iSYPD2KnO6e4mEf+6TjpEJ5DNzlqakU+TYLHRkV6x9/34j9uNpKl65f1zjExqIG7I/XFs29KXdwD/pbMA6C6SYlDB/R5sx+lGgR2EKmOs90gn6btNWT2ElDEPmYRUOXMSvFuVK8vHbvhkjOc/gRrOc+VthVfx051oEeTvo8gvAoL8kMxsnwRP6dkGNxHMyCeg6zQSCshav90gJ9sFjzWtTjJV9dVdOz5Jjj6VVa1Z5gTbv7QzgkvnWgJJJAinbbflI/Nt4Vv/o7UVQ86Rwoi7RKuLwaG7aYa66V2pkN0aLY0QCrW8b6DZ77JeYgtvIne+7Rjj4pxY4iTfswhtNS/NWTsHsP4mqvZHL96bXr32MTdpf/0IJRB7XwEmSgZn+cWxBjR0RCpYT8ThXN82eaAFcY8sBZB0R0tcW2fStUASJDNXlAXMnBLFOFJswCHgbqbTixm6A8MP5Z7v1X7FYumQf9+W6Lv7jG3v5VmcKB288pH+I6d+pQaYzbWR6KJm4rcIh66fgjVTC5LNWbnZi5g/9chZh/NORHclvAAxc9wZPLU+eco0oGq/7jCtd5eczkjbNWsHMH03951gk8CHC/st/DBQvjknSALgURTSTPF8uY+dCUoi2rkRPNj0CJnBfWns7w0pfBOwNq7w3uPxPGizS8V7rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199015)(36756003)(31686004)(5660300002)(7416002)(83380400001)(2906002)(76116006)(91956017)(66946007)(66476007)(4326008)(8676002)(66446008)(66556008)(64756008)(8936002)(107886003)(6506007)(6916009)(54906003)(31696002)(316002)(86362001)(38070700005)(26005)(71200400001)(53546011)(41300700001)(2616005)(6512007)(186003)(122000001)(478600001)(966005)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzF4V0ltaXMyeE9KUVk1K0J4a0tBanBScE9xang3WTRZdHRYQzZXNTJzR3NS?=
 =?utf-8?B?ZVdXY08xb2NUNzFabDd0aFBHd2c5cnRFMFZUaDN1WmN5NWpWb3o0UHRIZXNO?=
 =?utf-8?B?aHZPQnVHK0pjNXZ1b3VYVWJ2cE41NkZzdldHaC8rNE51M1ZJdTM1dm1Jd2Iy?=
 =?utf-8?B?WVVhdHd3WUNuKzhTZXF6S2NRR29KNExEOGljL01Xak5HSFpiNjNrU2dJajdE?=
 =?utf-8?B?emRhaXY4UGhpYmtmNnVoUFhmV1puWDdlVlkxUHkvRW9RTUlMKytsbi85c3gr?=
 =?utf-8?B?M1Npakhadzl2cTZDQ1BCdXNkRHlLNFZqZU90dG5RYW5Dc1ZDOGdmK0hSODBN?=
 =?utf-8?B?NTE0dmY4TE9BMnlHVmVxOUFpeDQ5R1Y4Wmx5VWFQMVVKWU42ZEM5SzlaUit5?=
 =?utf-8?B?cTJ1OVZsZWFNNUcwZ0d6UWZwNXMzNVhENzlPMHI2OVA1SnZVaWJPTDV0ZnpK?=
 =?utf-8?B?TjZoNDBYdVBsckRHTCs2Mm04cXJXcy8rNit2N0lnVUNNQ2ZMekJnOFhIbVVU?=
 =?utf-8?B?Y2JRQjVkZVVrT2ZzNTFaNWZsN004OFIvZ3VNUmJMQU9PbGFUZENsWWEvT3hq?=
 =?utf-8?B?a3BqTFdhSXluQXlGbnBOU1g1WkVuaG5zQTF3Mmd2elIzRHFVNVNDMkl6dXpw?=
 =?utf-8?B?MWJGMHljL0tkZTExWEpYMFMvZDloMHpDU3l6YXR1K05UaS9KS1RGNFhpREhQ?=
 =?utf-8?B?ZnJ6eEF3VkpJdURmRE9GTHVBRHZ6b1h4aTBxZWd3V0tIWWhhbENjcFFDcmNj?=
 =?utf-8?B?c3NZYkdOV25DNEdBM2xUWEdmais1TWpmNjh2Q0hTdTVHdnVVOWVhTTdXMFhu?=
 =?utf-8?B?eWRvUFVpOUpCN3NYaGw1TGVEc3BHYUJsUjZDWEh2L1JYR3JVYWtwTlVnSER2?=
 =?utf-8?B?Nmg5UXZ2N0dyNExFOWRRUFFiYTlaN1NzVDBjK2xsRXp5UGNZdlpnNUIxWFAw?=
 =?utf-8?B?RWk2YkU4VDRpaTNiZ2tOQnJFUFUyaHV2K1ptdGc2TUNQVnR4K2FjVnpZTitt?=
 =?utf-8?B?ZGZuNzlXdGxaN3pqZHJ3eDZVWElBUHErSk1aZkVBKzJTS0dGTzU2Q1hUMHRC?=
 =?utf-8?B?d29rUVJWdVZwSE1yazB6Mk5jb3UxTkNxZGJmUGtoWWpJNEhJVUZlK3gwMEtM?=
 =?utf-8?B?alQrMzdVSnFiTjZ5NXJjRFkyLytqN1RSQ0lMUlREV05vakkwTWtjVVVXRllT?=
 =?utf-8?B?NGcwSERFUEVuZ09Ec0hIaTNKVk1XZzhoL1krUHJzbXBtOVdVbnJSUGZlWTFo?=
 =?utf-8?B?UlBNM2NYRzA5N0hlSit4U2ZpQmlPYTZpcnRudWo2NmZKY1l2UTJyRzQ1SEhQ?=
 =?utf-8?B?TjkvclBTcmJScVVmd2hDMCsrY2o4ZnV0b0laL3ZCTHBEVDkrVXJxbVA1akpn?=
 =?utf-8?B?bU9LREgxcnM5MVV3WS9RdW85OXoySmM1TmMrWnhzdnN5WXJyVTd5MkZpTUFs?=
 =?utf-8?B?RnkrSzBESHJlU0Y0N0JFQU9nS3c2clZnMDVJeklQd1VDS0JxM0k5NU5sb2xR?=
 =?utf-8?B?dTFVcFlJN3h5R01OYlUyUkxZRGRza0ttNVRIRVFPcTdGL2VrcEJVeGVmSFhH?=
 =?utf-8?B?SSttQXVhN2lKazJ4V3FLbkZIa0FzdGRacDYxQjZsU0w1MTFlQ01PUFovTmV2?=
 =?utf-8?B?SjlOUEkrSDc5dWQyWlpvelhmYWJ3L29jblUvS2IzeE9Oc1FDMGJQQStIbmRn?=
 =?utf-8?B?ekxDMzQ1N08rL1NDSHpBRW8xUzdyVSsxREhlWE1JUVU1WTZTaUlwaU50WDF5?=
 =?utf-8?B?L2lxamlMdWdhK3BGNmd1OGhla1Q0YW9QUWNURVE4eUkzOGNpVkNBNTlrdWpF?=
 =?utf-8?B?S2hXMXdRQzB4VjJ1YUhBRU9rQWpGY0tEV3lDclBaR2Q1QiszOTdYOFNZdDZR?=
 =?utf-8?B?NkxNQWVmMWhHMURIN0xVQ0dRakxKTWRxbGRyZXU5M1Qxdjg4V0o1a0E1TjFQ?=
 =?utf-8?B?ekpYeXQwRUIyWVFrbjd3VlN2N3ByMCtpU2RjMWdocEMzcDdTd2hlTE0rT0ND?=
 =?utf-8?B?MUVodEt3bXRvLzRXWkg0R1ZWTWVadStuekR2OVhzbktlSUNMVnZodFlJNzJM?=
 =?utf-8?B?cnVxMkVVLzI4Rm9PWk1YUllibU00SjhnSFlmRVN6QXlKSkpGTGk3c1JyYXpt?=
 =?utf-8?B?RE0rZXlCNGZyaFVidldabEtpdHhxbDF4YjA2NmVwK2d3dGxmYWdneTZxRVha?=
 =?utf-8?B?REE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489c7d8c-c867-41c2-34fd-08dacc6df8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:43:12.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbNR0nSBMHk9ZBkyl9M4QiT1akyeCZlRg0nix75/cCasWCBEmJ8bI3G8NI7bj09c/sHP2S+ei2nleBQ0jEfk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6499
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <0E787628C11CBB4BA46E00531FB54082@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA1OjExIHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IE9uIFR1ZSwgTm92
IDIyLCAyMDIyIGF0IDAzOjM5OjA3UE0gKzA4MDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4gID4g
SW50ZWwncyBBUElDIGZhbWlseSBvZiBpbnRlcnJ1cHQgY29udHJvbGxlcnMgc3VwcG9ydCBsb2Nh
bCBBUElDDQo+ICA+IChsYXBpYykgJiBJL08gQVBJQyAoaW9hcGljKS4gQ29udmVydCBleGlzdGlu
ZyBiaW5kaW5ncyBmb3IgbGFwaWMNCj4gID4gJiBpb2FwaWMgZnJvbSB0ZXh0IHRvIFlBTUwgc2No
ZW1hLiBTZXBhcmF0ZSBsYXBpYyAmIGlvYXBpYyBzY2hlbWFzLg0KPiAgPiBBZGRkaXRpb25hbGx5
LCBhZGQgZGVzY3JpcHRpb24gd2hpY2ggd2FzIG1pc3NpbmcgaW4gdGV4dCBmaWxlIGFuZA0KPiAg
PiBhZGQgZmV3IG1vcmUgcmVxdWlyZWQgc3RhbmRhcmQgcHJvcGVydGllcyB3aGljaCB3ZXJlIGFs
c28gbWlzc2luZw0KPiAgPiBpbiB0ZXh0IGZpbGUuDQo+IA0KPiAuLi4NCj4gDQo+ICA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ICA+ICsl
WUFNTCAxLjINCj4gID4gKy0tLQ0KPiAgPiArJGlkOiANCj4gImh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL2ludGVsLGNlNDEwMC1pb2FwaWMueWFtbCMg
PGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL2ludGVs
LGNlNDEwMC1pb2FwaWMueWFtbCM+Ig0KPiAgPiArJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyANCj4gPGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIz4iDQo+ICA+ICsNCj4gID4gK3RpdGxlOiBJbnRlbCBJL08g
QWR2YW5jZWQgUHJvZ3JhbW1hYmxlIEludGVycnVwdCBDb250cm9sbGVyIChJTyBBUElDKQ0KPiAN
Cj4gID4gK21haW50YWluZXJzOg0KPiAgPiArIC0gU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8
YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiANCj4gSSdtIG5vdCBzdXJlLCB5b3UgbmVlZCB0byBo
YXZlIGEgY29uZmlybWF0aW9uIGJlZm9yZSBwdXR0aW5nIHNvbWVvbmUncyANCj4gbmFtZSBoZXJl
Lg0KPiBZb3VycyBpcyBlYXNpZXIgdG8gYWRkLg0KPg0KDQpXZWxsIG5vdGVkLCB3aWxsIHVwZGF0
ZS4NCg0KDQoNCj4gID4gK2Rlc2NyaXB0aW9uOiB8DQo+ICA+ICsgSW50ZWwncyBBZHZhbmNlZCBQ
cm9ncmFtbWFibGUgSW50ZXJydXB0IENvbnRyb2xsZXIgKEFQSUMpIGlzIGENCj4gID4gKyBmYW1p
bHkgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXJzLiBUaGUgQVBJQyBpcyBhIHNwbGl0DQo+ICA+ICsg
YXJjaGl0ZWN0dXJlIGRlc2lnbiwgd2l0aCBhIGxvY2FsIGNvbXBvbmVudCAoTEFQSUMpIGludGVn
cmF0ZWQNCj4gID4gKyBpbnRvIHRoZSBwcm9jZXNzb3IgaXRzZWxmIGFuZCBhbiBleHRlcm5hbCBJ
L08gQVBJQy4gTG9jYWwgQVBJQw0KPiAgPiArIChsYXBpYykgcmVjZWl2ZXMgaW50ZXJydXB0cyBm
cm9tIHRoZSBwcm9jZXNzb3IncyBpbnRlcnJ1cHQgcGlucywNCj4gID4gKyBmcm9tIGludGVybmFs
IHNvdXJjZXMgYW5kIGZyb20gYW4gZXh0ZXJuYWwgSS9PIEFQSUMgKGlvYXBpYykuDQo+ICA+ICsg
QW5kIGl0IHNlbmRzIHRoZXNlIHRvIHRoZSBwcm9jZXNzb3IgY29yZSBmb3IgaGFuZGxpbmcuDQo+
IA0KPiAgPiArIFNlZSBodHRwczovL3Bkb3MuY3NhaWwubWl0LmVkdS82LjgyOC8yMDA4L3JlYWRp
bmdzL2lhMzIvSUEzMi0zQS5wZGYgDQo+IDxodHRwczovL3Bkb3MuY3NhaWwubWl0LmVkdS82Ljgy
OC8yMDA4L3JlYWRpbmdzL2lhMzIvSUEzMi0zQS5wZGY+DQo+IA0KPiBEdW5ubyBpZiBzY2hlbWEg
aGFzIHNwZWNpYWwgZm9ybWF0IGZvciBkYXRhIHNoZWV0IGxpbmtzLi4uDQo+IA0KDQoNCkV4YW1w
bGUtc2NoZW1hIHNheXMgdGhpcyBpcyB0aGUgcGxhY2UgdG8gcHV0IFVSTCdzLi4NCg0KDQoNCj4g
ID4gKyBDaGFwdGVyIDggZm9yIG1vcmUgZGV0YWlscy4NCj4gID4gKw0KPiAgPiArIE1hbnkgb2Yg
dGhlIEludGVsJ3MgZ2VuZXJpYyBkZXZpY2VzIGxpa2UgaHBldCwgaW9hcGljLCBsYXBpYyBoYXZl
DQo+ICA+ICsgdGhlIGNlNDEwMCBuYW1lIGluIHRoZWlyIGNvbXBhdGlibGUgcHJvcGVydHkgbmFt
ZXMgYmVjYXVzZSB0aGV5DQo+IA0KPiAgPiArIGZpcnN0IGFwcGVhcmVkIGluIENFNDEwMCBTb0Mu
IFNlZSBiaW5kaW5ncy94ODYvY2U0MTAwLnR4dCBmb3IgbW9yZQ0KPiANCj4gU2hvdWxkbid0IHlv
dSBjaGFuZ2UgdGhpcz8NCj4gDQoNCg0KRG8geW91IG1lYW4gY2hhbmdlIGNvbXBhdGliaWxpdHkg
cHJvcGVydHkgcHJlZml4IGZyb20gDQoiaW50ZWwsY2U0MTAwLWlvYXBpYyIgdG8gImludGVsLGlv
YXBpYyI/IElmIHllcywgdGhlbiBpIHRvdGFsbHkgYWdyZWUgDQphbmQgaSB3aWxsIGNoYW5nZSBp
dCAoaW5jbHVkaW5nIG5ldyBmaWxlIG5hbWVzICYgYWxsIG90aGVyIHJlZmVyZW5jZXMgdG8gDQpj
ZTQxMDApLiBJZiBub3QsIHBsZWFzZSBjbGFyaWZ5IG1vcmUuLg0KDQoNCj4gID4gKyBkZXRhaWxz
IG9uIGl0Lg0KPiAgPiArDQo+ICA+ICsgVGhpcyBzY2hlbWEgZGVmaW5lcyBiaW5kaW5ncyBmb3Ig
SS9PIEFQSUMgaW50ZXJydXB0IGNvbnRyb2xsZXIuDQo+IA0KPiAuLi4NCj4gDQo+ICA+ICttYWlu
dGFpbmVyczoNCj4gID4gKyAtIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGlu
dXRyb25peC5kZT4NCj4gID4gKw0KPiAgPiArDQo+ICA+ICtkZXNjcmlwdGlvbjogfA0KPiAgPiAr
IEludGVsJ3MgQWR2YW5jZWQgUHJvZ3JhbW1hYmxlIEludGVycnVwdCBDb250cm9sbGVyIChBUElD
KSBpcyBhDQo+ICA+ICsgZmFtaWx5IG9mIGludGVycnVwdCBjb250cm9sbGVycy4gVGhlIEFQSUMg
aXMgYSBzcGxpdA0KPiAgPiArIGFyY2hpdGVjdHVyZSBkZXNpZ24sIHdpdGggYSBsb2NhbCBjb21w
b25lbnQgKExBUElDKSBpbnRlZ3JhdGVkDQo+ICA+ICsgaW50byB0aGUgcHJvY2Vzc29yIGl0c2Vs
ZiBhbmQgYW4gZXh0ZXJuYWwgSS9PIEFQSUMuIExvY2FsIEFQSUMNCj4gID4gKyAobGFwaWMpIHJl
Y2VpdmVzIGludGVycnVwdHMgZnJvbSB0aGUgcHJvY2Vzc29yJ3MgaW50ZXJydXB0IHBpbnMsDQo+
ICA+ICsgZnJvbSBpbnRlcm5hbCBzb3VyY2VzIGFuZCBmcm9tIGFuIGV4dGVybmFsIEkvTyBBUElD
IChpb2FwaWMpLg0KPiAgPiArIEFuZCBpdCBzZW5kcyB0aGVzZSB0byB0aGUgcHJvY2Vzc29yIGNv
cmUgZm9yIGhhbmRsaW5nLg0KPiAgPiArIFNlZSBodHRwczovL3Bkb3MuY3NhaWwubWl0LmVkdS82
LjgyOC8yMDA4L3JlYWRpbmdzL2lhMzIvSUEzMi0zQS5wZGYgDQo+IDxodHRwczovL3Bkb3MuY3Nh
aWwubWl0LmVkdS82LjgyOC8yMDA4L3JlYWRpbmdzL2lhMzIvSUEzMi0zQS5wZGY+DQo+ICA+ICsg
Q2hhcHRlciA4IGZvciBtb3JlIGRldGFpbHMuDQo+ICA+ICsNCj4gID4gKyBNYW55IG9mIHRoZSBJ
bnRlbCdzIGdlbmVyaWMgZGV2aWNlcyBsaWtlIGhwZXQsIGlvYXBpYywgbGFwaWMgaGF2ZQ0KPiAg
PiArIHRoZSBjZTQxMDAgbmFtZSBpbiB0aGVpciBjb21wYXRpYmxlIHByb3BlcnR5IG5hbWVzIGJl
Y2F1c2UgdGhleQ0KPiAgPiArIGZpcnN0IGFwcGVhcmVkIGluIENFNDEwMCBTb0MuIFNlZSBiaW5k
aW5ncy94ODYvY2U0MTAwLnR4dCBmb3IgbW9yZQ0KPiAgPiArIGRldGFpbHMgb24gaXQuDQo+ICA+
ICsNCj4gID4gKyBUaGlzIHNjaGVtYSBkZWZpbmVzIGJpbmRpbmdzIGZvciBsb2NhbCBBUElDIGlu
dGVycnVwdCBjb250cm9sbGVyLg0KPiANCj4gU2FtZSB0d28gY29tbWVudHMgYXMgcGVyIGFib3Zl
Lg0KPg0KDQoNCldlbGwgbm90ZWQuDQoNCg0KPiAtLSANCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+
IEFuZHkgU2hldmNoZW5rbw0KPiANCg0K

