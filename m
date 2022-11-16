Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFD62BAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiKPLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiKPLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:07:30 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DAC5F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668595987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXD7Jw/0CSoykwTsg+sUdsDz4wmcjaCj1R178DQxmlQ=;
        b=gRkISmD1ztNMWyOfgJVJETOH68ycG7WcuGS3To3Riw/EaOaFmNEAnQxE/KyRSiiqAJZj+2
        880Lq8yjmrTgqOS7wm4f2kK+3gIotEVgbWXPk7RUjc5fssdY8yNeofgalcmJEoxychuXcx
        q8BIUVqSM48eSW1dxl598HfkY6elWOhUNpyfG/jaK0rXbnwEteh3dFcT3AM6qD/zI+yJJ5
        +ZlgQAXy6lSQL42OBKT3IbJSqjg19UjFNR6qvTLOViDRv2MPQPGSFMU6Z2ZmPHoYcleSIR
        0BZr3l2UFiFNpnRXrjEDyWC0kkNqDO5g2MXQavESYt0T/K/aTXzfTdbsNoWCYg==
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-b3qCoFGkM7CmpJ1NGGDtYQ-1; Wed, 16 Nov 2022 05:53:06 -0500
X-MC-Unique: b3qCoFGkM7CmpJ1NGGDtYQ-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by BY5PR19MB3906.namprd19.prod.outlook.com (2603:10b6:a03:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 10:52:59 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 10:52:59 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "sodaville@linutronix.de" <sodaville@linutronix.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related
 binding schemas
Thread-Topic: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related
 binding schemas
Thread-Index: AQHY+aYz2LWLewzqbkGgRKTN4JUevq5BXMkAgAADGYA=
Date:   Wed, 16 Nov 2022 10:52:59 +0000
Message-ID: <db4c2ec5-d4ac-c2b8-0b6f-89ae926ac1ee@maxlinear.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c.1668589253.git.rtanwar@maxlinear.com>
 <Y3S+cgOm1vHq/kv9@smile.fi.intel.com>
In-Reply-To: <Y3S+cgOm1vHq/kv9@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|BY5PR19MB3906:EE_
x-ms-office365-filtering-correlation-id: 72f11d00-e19b-478f-42b0-08dac7c0ba1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: O8utUXDV5CxkmcFeSQymL5bHT7h4PrIF2Dbtzb5adZfzs2tkb4I0sOagNtlK1DbFu6SoO0NTfi9ufaGWYCQBbVpcHYg3IppbG2q+ufB0HDmLJEytPdlBzcxMIBdyV8cppglWaFp/1h/LmAkCk7Zcnh79K8aFY0fCnii2HMKwS97Ij8mYx+yLxgdESxf6qCMw1+McN0d4aaIltyjx5gby3hS4mk9ayxvH7kV423YzEVNNg/7AEvg3jiHlI4ovBsVzs/EIgs0cQAtOWhQtru2zZuqk7sMQ672g4siRruK1iP+5P8qicOEy4/6CDj695JBIJ5TOGbAEG+vfJNOY4e1zEql9YkdPQALQyfOu2qfxS6go0tFplfQFmXFuy3IalygoBAdlaWpjmyMOOp3TbsgBIqgCgbuasnvcoN4qPTbZLac7q1OoRMbI+iOtSxle+v11uzhzyP0nbN20ERGqvA0k3S31BF9IvUA+ekJiwTkW4+bxfNXCGf2ikahewQi4QHdjoP1Hu6AkH4sYiiIuUfPsOItkUb3PeFuhjKU17K+qMUMDbHPYIFdFWitUUvXosCS5z7PKTxIJ7OTKf9Du9oK3Nvq2VNxPNcj6I+UWei+QEKAffnfS107qoc/iBObAnLfUUfm6QRA4cSk/C1W8Wqgbz3L+w9ORn6LKTE4RbuXoDbGewqj3j0dE8NnMw5GLy6Pq/PFdK+sBTwNDrS3NNAHmvIxmgw+DBSQubK4jB/bMIxTcWesb5u3zZFlmJ9MzDHUHKmfHkuG3pJcGLhwUq2CejE42S7BZpLsDGrOZXuHjD06Rb3b1dSmMayBBLkT0/B+H44KosyJs1TMhecifTnTv4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(376002)(396003)(136003)(366004)(451199015)(38070700005)(2616005)(316002)(54906003)(6916009)(53546011)(107886003)(36756003)(6506007)(6512007)(86362001)(26005)(31696002)(66946007)(76116006)(91956017)(4326008)(71200400001)(66476007)(66556008)(8676002)(66446008)(64756008)(41300700001)(31686004)(2906002)(83380400001)(15650500001)(122000001)(4744005)(186003)(7416002)(5660300002)(478600001)(6486002)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3VFY2RWVFFVdGpmWmtMWjMrNms0ZFEzenZ6RUh3ckZ0UnEybFJzaDdFNGdR?=
 =?utf-8?B?R2syV0FsMHlaRFd3akdNYm8wc2l2YTkvT2pHY3VLWFRUUGE4OG00d2RHMXg0?=
 =?utf-8?B?SlJORHpKZlBDLzBZZ3VxSThHZU56VmtSTWI1WFY0Sk5LK2JCcEE5RHJIK2hR?=
 =?utf-8?B?VmU2WGl5dWhQRVVxYmdiUE80S0o0VEdsYXYzZjBxbUc4OWdkamh0c3pOSytt?=
 =?utf-8?B?aHJQeDcwWTFqTXpPMDF4Tld3c2p5dWlITWUrZnRJL0NGVms5S3ZFUHNtMHQr?=
 =?utf-8?B?VlF0MTdjNUxVaGcrcUsxcjA5S1lxQWhmUkpRbFFHYTJZZlFxNjM0WkhoUktX?=
 =?utf-8?B?T2phbTZEdHcrMFVNclhxZW5aVEZ0eDVlN1loQWxyTW1pcWd1SXhhWHcrK3Fk?=
 =?utf-8?B?QWtkZ25pdEI1ZkY4M2RNT1d2SHROcTArL05rYWdOR0ZEVDNxc3JwZWx6eVd4?=
 =?utf-8?B?U0hvZG5sd3JHVXhjbVFlVE8zZFd2RDBjVVU4anNmSkd1QmZrWU1WVmF2UGtr?=
 =?utf-8?B?d0NUaTRXejk1c1prTVRNTjBNMXg2dFBRM2RweFR3UmpzVi9QcXE3VS9mREUw?=
 =?utf-8?B?SXJRVHJhTUNwSUpUTHBaSkp0R0wwTG1nb0RxaXZKYjZ1ek1vUG95WFlweUI5?=
 =?utf-8?B?Nm9YQldwcjRteWxBdGEzTlRCQmhPelRHcWVhUWtDeXVnMUptczZJSjN3OTUz?=
 =?utf-8?B?bTJER2NkZk5ZRy9mWTJpRXJraHBtcGR3ZFhTRzQ5aHV3WnBGR05MQVE2S2NI?=
 =?utf-8?B?dStJNVRneHpqTTBhVWU0eURzMDNWWDlNRTc3bFEvZFR6NEszd3VHWVh0Q1M2?=
 =?utf-8?B?RmQrWUxNRldvbXpGZFR4TDBiVkFWbms1STA5U1VGSUhYajErUFNjcFFlanJV?=
 =?utf-8?B?bjBSWTNSaEo4Qkd2alkrMFJxVEFZanBqYktRTjRSWm55LzllOHlaYXFSVWE2?=
 =?utf-8?B?Q3hVZHNzek5scVEwNEZ4TDVEZWNZT1VaVlloY000bkhEZisraDQ4TjNUYnlr?=
 =?utf-8?B?OU1pRU5MZytaaTloRUJqT0xnS1Jmb3hJMTlubmRIVUpTVVRnMUhCUFRURnJC?=
 =?utf-8?B?cURYOVpybWZNdDN2b240a1hucVMzazBnYTN0OVFYOGpBYzBxbzc3Uk9POGJU?=
 =?utf-8?B?R2tRRHBHeWh0MmI1NS9HN1ZZcm4wYUMwTEhoUjBpRzBmcUl0QkozWGJSMGx5?=
 =?utf-8?B?V28vQXpyQTB6YUhHalhQZjdUWlAzVW1ZQlRVemNIYjM1ZHc2TEoyVERoazdj?=
 =?utf-8?B?aGtJRlZPRXpzLzhNWGhlM1dxbWNRcjJocmlicDZyRW5taXVNYWpnMGs5Sm43?=
 =?utf-8?B?Z1ExVG5lZkQrR1BqSEVYS29yVHZzZ0JsTGJZSUFTcGZNYkUwSEUxeEdGNkRI?=
 =?utf-8?B?ZFhoMDJpTG9aSXdhK0hJSHBxWVJ5ejVVUVZkTWR1VW5CQWI3cWpwdG94Nm0v?=
 =?utf-8?B?bGJGWUpFVUZQRUJkOFBvQlhacm1STUFpV3JkZm1PclY1ZTZvQ0VYQXNuUERn?=
 =?utf-8?B?K3dNVGpiODNvSTdmMXovZDF2U3pwRlBzRUwyRmRIUU4zcU9XZmhkMGF4b2tr?=
 =?utf-8?B?WDVVcGN6NUZWTDJoSCtjcFloUklQQXpjcWg1MnB1RnhVSVhPRUxlMUJnTXk0?=
 =?utf-8?B?UDcwOTBDVGZDL3FaeGlpbmVEaFZLa3FEMHRZejloSlBQM0E5aVhvSmtlQ1Y3?=
 =?utf-8?B?dUUrY1RScm1NYjExWjFDUi9ycGRIQUNlQUl1ZXRtSlpYdDdzMUxQYUpPZHEz?=
 =?utf-8?B?ek9qOWhmVS8wOHlCVFFwMG40cTJld0RoY203OWJoRllRbzNoOUEyUC9KK201?=
 =?utf-8?B?VEd5bmx0N2hpUmJLQzJrNUlKbDZQdUZ1TTU2ZWVDQU9ZVjlhVE5HeW9mbVAv?=
 =?utf-8?B?S1J5UmNhVEpWRlczdFNheHpHQUVNN0ZOZ0tyenBXTTRxQzBkalQ2Z0JVTkZL?=
 =?utf-8?B?NElJa0VuTnJaUWNjLzNKSXY4dGZsOG5NS3g2Z3dOSlBsZHdQYkhJY05JcDd6?=
 =?utf-8?B?Yitaa1Rzbk1pWkFyT3BCTUxDUVRmWTF1d0ZHS0hjUjMwNU9sYjZaZFlUQmQy?=
 =?utf-8?B?ZDM3dkF6RlpJczBxRDhnMGE2TXIxMzFydzRDY0JYNGR2QzBpT2o5aWdzanMr?=
 =?utf-8?B?SU1rRVJKK1E0bS9VOVBKSnVvQWVHTVd4V3pvU2dlc3RjZk5IMk9qYUtQazVa?=
 =?utf-8?B?TEE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f11d00-e19b-478f-42b0-08dac7c0ba1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 10:52:59.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+CTE3Hs8ljcZoGU0/H++PbqrTydtLXcaa3pjd9L1fdx8zdlGAL2elOdTOS86Xp0lwlUONr8LFB/zS1YF7GXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3906
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <2920FDDD546DC84394FFE9E06DAFEFA0@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMTEvMjAyMiA2OjQyIHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IA0KPiBPbiBXZWQs
IE5vdiAxNiwgMjAyMiBhdCAwNjoyODoyMVBNICswODAwLCBSYWh1bCBUYW53YXIgd3JvdGU6DQo+
PiBJbnRlbCdzIEFQSUMgZmFtaWx5IG9mIGludGVycnVwdCBjb250cm9sbGVycyBzdXBwb3J0IGxv
Y2FsIEFQSUMNCj4+IChsYXBpYykgJiBJL08gQVBJQyAoaW9hcGljKS4gQ29udmVydCBleGlzdGlu
ZyBiaW5kaW5ncyBmb3IgbGFwaWMNCj4+ICYgaW9hcGljIGZyb20gdGV4dCB0byBZQU1MIHNjaGVt
YS4gU2VwYXJhdGUgbGFwaWMgJiBpb2FwaWMgc2NoZW1hcy4NCj4+DQo+PiBBbHNvLCB1cGRhdGUg
bW9yZSBpbmZvIGFuZCBuZXdseSBpbnRyb2R1Y2VkIG9wdGlvbmFsIHByb3BlcnR5IGZvcg0KPj4g
bGFwaWMgdG8gY2hvb3NlIGxlZ2FjeSBQSUMgb3IgdmlydHVhbCB3aXJlIGNvbXBhdGliaWxpdHkg
aW50ZXJydXB0DQo+PiBkZWxpdmVyeSBtb2RlLg0KPiANCj4gQ29udmVyc2lvbiBzaG91bGQgYmUg
c3BsaXQgZnJvbSBhIG5ldyBwcm9wZXJ0eSBhZGRpdGlvbi4NCj4gDQoNCkRvIHlvdSBtZWFuLCBp
IGZpcnN0IHVwZGF0ZSBvbGRlciB0ZXh0IGZpbGUgd2l0aCBuZXcgcHJvcGVydHkgYWRkaXRpb24N
CmFuZCB0aGVuIGxhdGVyIGNvbnZlcnQgaXQgaW50byBZQU1MIGkuZS4gZm9yIG5vdyBpIGp1c3Qg
dXBkYXRlIGV4aXN0aW5nIA0KdGV4dCBmaWxlIHdpdGggbmV3IGFkZGl0aW9uIGFuZCBsYXRlciBj
b252ZXJ0IHRoZW0gdG8gWUFNTCBzY2hlbWEgPyBUaGFua3MuDQoNClJlZ2FyZHMsDQpSYWh1bA0K
DQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4g
DQo+IA0KDQo=

