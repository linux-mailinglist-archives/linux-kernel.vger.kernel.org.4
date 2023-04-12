Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB07B6DEBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDLGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:17:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2029.outbound.protection.outlook.com [40.92.40.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275140D8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZqPqr3c74tG2Zi5a4wN7yq1yUFzPgdkOggpoOzq7bT9Rcn5odtAeQrsKOR5D9SAdDBMxyws9LovYI+JoBmBBnQTchYEOmI5EFeF0c3RV/3WO7DYTP7oDvGik631KbOyE4OQaJd4xrlqPnm+FCUmm4EZBsMZLQMuMWDU3wccjO0ATD+STs8Nq/1YwlLBpqipgKKkWhtqOhzegHaPbKWQ3DPs3Mfy/NAkkqQqYFDVyiXrzX3TFigiNXA7rZ8HbcJpGkSeWUt9D8UTKCFTWKuM8tlZzxZ+imw268YdfY9zY4RmlmjxNzg50PLTn01+qjB6Cd2I8Q6jO51wRQy8nGn3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjHXgO+zDj/zezip5+AydHFuYg2J6cuHmjVEssPNWq4=;
 b=MGszpSwUhMpcf3OtfPUzKHnMtNdFLqSrkUL+fxHYEz+weEAPazb16wd4GAMLfL8k8J5tenvQG+7TdqqVkKYApLENOYP8PbSphXS96o8G1qpGaE6hMG33XL+4jaFIbg7bFj8TEwuAzQxlj9sPY8FaEzh1wANPb1QqbnQ6VaNvzc6wc3fI5qYWLPo5p4m9XJBfFyuW/ffMwTEXIDVpGeZomfbTf669zRoFoMzohHmOR/3rU6bSr0REMBQDM6N2vcdx6vKxbZh7Ibc35O5Mw22vNkJcsr0AuGQiabFn5zozK9tZMIkdQl9EqWagDC/ieqYyDcRVsRJ+mZaIHQDKD0WRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjHXgO+zDj/zezip5+AydHFuYg2J6cuHmjVEssPNWq4=;
 b=MuMSwaenEjekfBgp0MImJ7HSWgm6HS6ufPmZHnLm8LxhzNORkmBX53pgFB51b+7j7jC+REf1u9r3NXdb9vpeWI17H2JN44kEbu6kdjRDelC75lKOqbWtKwBskQRu5Dy92daC1EE7ejZ67lyd9O/shcWM883psJ+kJb6iA60wUjZMJF0b1kmN48cuw3ePgkXT++3vVVnVifsNlmznqkBuLGEvZ/xVxSdijhLF+WYSrnuhDUQ8y2x80pxMqBFYTiqeqlZPQEi1e46NtXUeYUmrlJlqmcEcNFfFypH8krh1HuroiCm2nrovzOdo/A9V5N8+GVeT8SWT5ZqP+aBL1lVc+A==
Received: from DM6PR22MB1836.namprd22.prod.outlook.com (2603:10b6:5:25e::21)
 by CH3PR22MB4309.namprd22.prod.outlook.com (2603:10b6:610:179::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 06:17:43 +0000
Received: from DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c]) by DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 06:17:43 +0000
From:   zhao xinchao <ChrisXinchao@outlook.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cl@linux.com" <cl@linux.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIG1tOiBGaXhlZCBpbmNvcnJlY3QgY29tbWVu?=
 =?utf-8?B?dCBmb3IgX2ttZW1fY2FjaGVfY3JlYXRlIGZ1bmN0aW9u?=
Thread-Topic: [PATCH v2] mm: Fixed incorrect comment for _kmem_cache_create
 function
Thread-Index: AQHZbFXpRN6nmzcD20Sp8Jzuee1G8a8nCGAAgAApiJA=
Date:   Wed, 12 Apr 2023 06:17:43 +0000
Message-ID: <DM6PR22MB183695C5151EE3E3E749763AC59B9@DM6PR22MB1836.namprd22.prod.outlook.com>
References: <ZDQXl2wMk271w3xy@debian.me>
 <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
 <aac1fa88-46bb-08ab-35e7-75e44b8d28b5@gmail.com>
In-Reply-To: <aac1fa88-46bb-08ab-35e7-75e44b8d28b5@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [Kmt/WO6srupvSxJDgKNZjlcCn5lVie74]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR22MB1836:EE_|CH3PR22MB4309:EE_
x-ms-office365-filtering-correlation-id: 32f439c3-3b8d-430e-908c-08db3b1da05e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsdvNq8qxXsG8Uu8vvnTSx4fadESrVB/o3AHqCVKlqBkdX/awVtZeheY0AOtvbtBhwrLRNyXhe5rchPKGnFKGqTzQafxJruMSeSLB5tHVXZpeuqTKHJWxK3wt/ckHSK2y6nN4otQbkiHNWbOG2EXfIanf3BigCsq9Hp8zzjJs5FN6+mq5ApYbUTaicr078biG7i/RUknyVQYJMBCY1oqke52L7w+Di+4XE7+XXRKy5Pwhkj9+NmM1dcU6rbdEFlYZEnFARTmBgnjJn1j122vHn4nKfk60y08ySCgApYjL2b5TeKyLJFVdmAYzSTYOiJE24PvJIditUG/LGJulZh4mUr8a2tSEs0zWgaDezFWkO0bGZ7TPqVcqOz9Gzzb0yLVnwpIY0ciKqPWqsK9YVCmc4vTlW6rphtUKT0oJk6C1K7OAgCHvTEgZlr3Fmh3r85LHyUq7WW6BkJwY/l+GuG4OT63G5IH173OUQwbGvL4mxS4MpmHgEyZ0JCu5dAYV3ZgyMK/3gVqzOWuO1vs7vtxWCjFs5qQNJsa/EQ1dxAxhjEvlc3tXDKUVZxryxnhLTEp
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEVGcVhXSVRSU0k1Z0NiQzNZcit3emR1TkZYS3hGZWtOVDlNd010Q0JuMXda?=
 =?utf-8?B?N3BWWjNQQTNobllxaVA5VU1FTmRxNlJrbHd3cXFkZ1lQY2I3SXRlZFQ0YXB2?=
 =?utf-8?B?QVQ1aFROQ2RqQUVZOEx0VnM5SExmZ3gwazQ1dnFEc2pTSmZVK1R6K1FwK1Zo?=
 =?utf-8?B?VDA2cEpCcEV6bEVGYmVOQXF2cmt4eFhKbVFvNThCZGNjKzhreVUzS24waEZl?=
 =?utf-8?B?WUhkaHE1NDJOclFQMHNQYlpUS3lMeUhJVCtFaFRudlNHcG5VeUZ2L01tVHNt?=
 =?utf-8?B?SGZLR001aGlrU2JBaHRwckVpMENEaHZhd010b041b2ozM0w5cXpXZllkWjg2?=
 =?utf-8?B?SFMwNFZ5cklpSzhKVGFuaGFWM3pJYU1VYjhUSVQ2cXZhZjRZazlpODU0L3Fh?=
 =?utf-8?B?YjhZcGpESWtMVW4xT3ZleE5NSEVCNGlqOE5FS3Q1VXhGWHlmem1JV01NSWJT?=
 =?utf-8?B?S2R4MDZlQXBVTFB6b001UUJWRmtUWldOblR0V3NkeTZoTktwcEZ6cTFoSmwv?=
 =?utf-8?B?VklNb3ZDak9Bd0pNWkR4eGpVNG1IN0FmRnFtUDQ2dC9IY3d0MUhaUTZBcWth?=
 =?utf-8?B?dlhadGx4SUt1YkFYMFdPb3VOT05KODRxdGNKaFc4b3BxVUxBRU1hUTFzRU5a?=
 =?utf-8?B?VTZVeWg5T0V2VDhBOHJPS1YrelFHd1dnYm5OVjBuQlJWSzN0bjdVa3pMbTMv?=
 =?utf-8?B?SHFsR01BR3hWT1FsQXIzZnd3YjhWRGNGczBwQ0FId05WUHVlb0h1WEd5M3JS?=
 =?utf-8?B?RThDckd0SVBEK2c1aGRNQ3ZNbWo3K2pwaWJVallQblF1VVQzUVBSeUYyakpo?=
 =?utf-8?B?SVd0d2x6WWFzdWFsOWU4MVR2RlBmL0NYWVljL0d3ZkMzcmhCSllrRTBLblRD?=
 =?utf-8?B?c0F3ZE44L21CVmxjS1FHNDNRMm5LZGV1dGVwSFBYTjRSalJUcnRyc0xhY1lZ?=
 =?utf-8?B?QlB5anliMzBxYkpqMWpzMC9TL0locERORnBqd2FIdUNZc1pPTVJNZUh6V2ty?=
 =?utf-8?B?enExZWZRM2lOaWF4b2dIR2NiQTFVSm1DK0dGMVptYjIwMTBjV216czFvVEVj?=
 =?utf-8?B?My9sSUhMK1M4eWdsQXp0a2VLbjFoU0Z6UUU4SUVyS2M5SmVqZ1JyTXA2RVF4?=
 =?utf-8?B?MHhqWVhGODVsY25XMmJYQXpCbkxZb0pEUlRJNzZKbERNdHJ3ZnJ6SDFaelNC?=
 =?utf-8?B?NjNkZmtPTlh2eTk3bFMrMFhreGxuNVIwVnI2SUdVeWg0cDZlMUFVQW9jeXE3?=
 =?utf-8?B?aFhuNE92cjgzZlZtdVJTeFdhVWNBRnl5QVBnbzhBam1vcWJUMmN1Y05URDlJ?=
 =?utf-8?B?ZlFKMlZoUW8waW9tSXRQRGVWSCtNc1VzaUxtNWxjdEV3N2tnZWVwV0Z2bEVG?=
 =?utf-8?B?T1FhUlprbFlRMWhJYkp3c2JITzFlZlpMcWJqMmxWdkVkWUZmTzk5ekJzTFFr?=
 =?utf-8?B?TDhOTE5QYUpjT2JLRTlycmF1dzh5Nm8rMUVvL0wvWDZ4MHNoWk9KL0xLbjJI?=
 =?utf-8?B?dlp4V2ZqSkt4K1Y4OXVNMXJUZUF4V1QzUlQwYVpZMXdrZGlYaXlDMHN5Y2dH?=
 =?utf-8?B?SzRHdW9majh3NzFGQnJzT0J4RmNFN05PYkxUM2prcFJ3a1g1TmpWSlVVSkN4?=
 =?utf-8?B?bjF5eWU0SlBKTWdqSjZ5ZFA1SHJlNnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB1836.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f439c3-3b8d-430e-908c-08db3b1da05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 06:17:43.3375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBkb24ndCB0aGluayBrbWVtX2NhY2hlX2NyZWF0ZSBpcyBhc3NvY2lhdGVkIHdpdGggX19rbWVt
X2NhY2hlX2NyZWF0ZSwgDQpfX2ttZW1fY2FjaGVfY3JlYXRlIGlzIG5vdCBleHBvcnRlZCBhcyBh
biBBUEksIGl0IGlzIGEgZnVuY3Rpb24gY2FsbGVkIGludGVybmFsbHkgYnkgdGhlIGtlcm5lbC4N
ClNvIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiBkb2VzIG5vdCBkb2N1bWVudCB0aGlzIGludGVy
bmFsIGludGVyZmFjZS4NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBCYWdh
cyBTYW5qYXlhIFttYWlsdG86YmFnYXNkb3RtZUBnbWFpbC5jb21dIA0K5Y+R6YCB5pe26Ze0OiAy
MDIz5bm0NOaciDEy5pelIDExOjQwDQrmlLbku7bkuro6IHpoYW94aW5jaGFvIDxDaHJpc1hpbmNo
YW9Ab3V0bG9vay5jb20+DQrmioTpgIE6IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IGNsQGxp
bnV4LmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBwZW5iZXJnQGtlcm5lbC5vcmc7IHJpZW50amVzQGdv
b2dsZS5jb207IHZiYWJrYUBzdXNlLmN6DQrkuLvpopg6IFJlOiBbUEFUQ0ggdjJdIG1tOiBGaXhl
ZCBpbmNvcnJlY3QgY29tbWVudCBmb3IgX2ttZW1fY2FjaGVfY3JlYXRlIGZ1bmN0aW9uDQoNCk9u
IDQvMTEvMjMgMTY6MTMsIHpoYW94aW5jaGFvIHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvbW0vc2xh
Yi5jIGIvbW0vc2xhYi5jDQo+IGluZGV4IGVkYmU3MjJmYi4uMzk5ZGFhNGQwIDEwMDY0NA0KPiAt
LS0gYS9tbS9zbGFiLmMNCj4gKysrIGIvbW0vc2xhYi5jDQo+IEBAIC0xODkzLDcgKzE4OTMsMTIg
QEAgc3RhdGljIGJvb2wgc2V0X29uX3NsYWJfY2FjaGUoc3RydWN0IGttZW1fY2FjaGUgKmNhY2hl
cCwNCj4gICAqIEBjYWNoZXA6IGNhY2hlIG1hbmFnZW1lbnQgZGVzY3JpcHRvcg0KPiAgICogQGZs
YWdzOiBTTEFCIGZsYWdzDQo+ICAgKg0KPiAtICogUmV0dXJucyBhIHB0ciB0byB0aGUgY2FjaGUg
b24gc3VjY2VzcywgTlVMTCBvbiBmYWlsdXJlLg0KPiArICogUmV0dXJucyB6ZXJvIG9uIHN1Y2Nl
c3MsIG5vbnplcm8gb24gZmFpbHVyZS4NCj4gKyAqIFRoaXMgZnVuY3Rpb24gaGFzIHRocmVlIHJl
dHVybiBwb3NpdGlvbnMuDQo+ICsgKiBJbiBhZGRpdGlvbiB0byBzdWNjZXNzZnVsbHkgcmV0dXJu
IDAsIHRoZQ0KPiArICogZmlyc3QgZmFpbGVkIHBvc2l0aW9uIHdpbGwgcmV0dXJuIC0gRTJCSUcs
DQo+ICsgKiBhbmQgdGhlIHNlY29uZCBwb3NpdGlvbiB3aWxsIHJldHVybiBub256ZXJvDQo+ICsg
KiB2YWx1ZSBmb3Igc2V0dXBfY3B1X2NhY2hlIGZ1bmN0aW9uIGZhaWx1cmUuDQo+ICAgKiBDYW5u
b3QgYmUgY2FsbGVkIHdpdGhpbiBhbiBpbnQsIGJ1dCBjYW4gYmUgaW50ZXJydXB0ZWQuDQo+ICAg
KiBUaGUgQGN0b3IgaXMgcnVuIHdoZW4gbmV3IHBhZ2VzIGFyZSBhbGxvY2F0ZWQgYnkgdGhlIGNh
Y2hlLg0KPiAgICoNCg0KSSBkb24ndCBzZWUgYW55IHZpc2libGUgY2hhbmdlcyBpbiBteSBodG1s
ZG9jcyBidWlsZCAoc2luY2UgdGhlIGtlcm5lbC1kb2MgaXMgZm9yIGlubGluZSB2ZXJzaW9uIG9m
IGttZW1fY2FjaGVfY3JlYXRlKCkpLg0KWW91IHdpbGwgYWxzbyBuZWVkIHRvIHVwZGF0ZSBrZXJu
ZWwtZG9jIGNvbW1lbnQgZm9yDQprbWVtX2NhY2hlX2NyZWF0ZV91c2VyY29weSgpIGFuZCBrbWVt
X2NhY2hlX2NyZWF0ZSgpIGluIG1tL3NsYWJfY29tbW9uLmMuIFNpbmNlIHRoZSBsYXR0ZXIgZnVu
Y3Rpb24gaXMgYWN0dWFsbHkgYSB3cmFwcGVyIG9uIHRoZSBmb3JtZXIsIHRoZSByZXR1cm4gdmFs
dWUgZGVzY3JpcHRpb24gKFJldHVybjogZmllbGQpIHNob3VsZCBiZSBzYW1lIG9uIGJvdGguDQoN
ClRoYW5rcy4NCg0KLS0NCkFuIG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMgd2Fu
dGVkISAtIENsYXJhDQoNCg==
