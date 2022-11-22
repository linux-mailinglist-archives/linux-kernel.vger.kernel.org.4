Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8606338E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiKVJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiKVJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:46:26 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9BC76F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669110331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdTn6Lq0+tmkPvo1Jy1e9C7axobPX4mIkQ1V07N3MDI=;
        b=JoZStsg/4B4MrAb/Bw3Hvn/YsRjBDLp54EbxiRr2gUY2GA7SQW5KGzkT6XA+quUjfeEez7
        Xgb+p/VdQsedVwRloxxvjDlHtQHVRXrNDV3NCEF2Rm1aAdbc4VrXeUzwliCQX4AQIMPYG5
        X/BwXiTOu+s5TINtIrMNkcIxFqeL7750KzdKK2qdtD/kEI36NSIGocbRnBEwAHTCjoofRt
        fRx1l0OYLc7RUxc4kAmG+geABeq3JQWW1R4DiAyblFtOhaY9Q+OFVMtNV2jqt6di0vux2R
        g8H1meypk+JamE5iVcIAR7bEce9jdhqLuT/7otXGcoeMyOlUTctX+vua2dqUZg==
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-v-CyL2FEOmm4qyvGrYqzEg-1; Tue, 22 Nov 2022 04:45:30 -0500
X-MC-Unique: v-CyL2FEOmm4qyvGrYqzEg-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by IA1PR19MB6499.namprd19.prod.outlook.com (2603:10b6:208:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 09:45:29 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:45:29 +0000
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
Subject: Re: [PATCH v3 4/4] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Topic: [PATCH v3 4/4] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Index: AQHY/kRfhnVbeItEeUSSkZrCdcV3ea5KqQ+AgAAItYA=
Date:   Tue, 22 Nov 2022 09:45:29 +0000
Message-ID: <e5028335-97f9-dd88-09e9-9036b55e7642@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <c62b81d5b91514e905d97e37feff6920f598e0ac.1669100394.git.rtanwar@maxlinear.com>
 <Y3yS6fCIl+0nsbOj@smile.fi.intel.com>
In-Reply-To: <Y3yS6fCIl+0nsbOj@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|IA1PR19MB6499:EE_
x-ms-office365-filtering-correlation-id: 34cfa6f0-fd13-46fe-6ff2-08dacc6e4a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: O1XUt3bXCJlwseKd2hPq6y1i9HWzAjDraJawx7tviV1irOkStVR6UpJag+qnh/grrmmiyP+3HmNXECoUOJhJh+meBkfb52uI+HIFJIECCIhUtEFWN3R5Io/oIDL7Mf3LK9J8kW02KyIpbE64C6RgVt85IbXl59DLUC9fCWl2L7a0DFouF8VmxZ895WTU77b32g2jfhfoRuIb958LivPFXf82D0NrDyMQWlW1LEwymjiA8Hfb+iYtkY0U+HX0hleHIp0StE7JzkAYwx3VGCDLEWLaHboLVrNDLZHqk/HmkZyABfzWbZsP3ags238dXkRcyAS1ev0JUQKO0pEe/Pchr1ogyHOTX5Cn2xppnsVRYvv/L1wucU38dv1H6O2i6wwBin5oSEcru4fzLroXUK0NT+avrfKwxNBW3mKu+xyyCejXY9JttTje5TCjWIWLBqE1eokTEPelqkXMV7gxTcOg276p1Q1O06DeknPOfNClVYaXm8x+S4ZQ7WnEtWaqh55AeSPdqFWPRXfUV6JuJAi7P3v8fxIqxeDYrwS7pIYPvJopQA4cFgyU3WRwiXypbOj6etOeKQyT97KR12g6n1Y0ZuTkkYg748dL/O1kdjgiUUrSWeVs6pEDSKOlRmzVQIHzmk+0tlm7PadtTV9NU27n43a9+/LfFn/2SCly9YAKjm4ghH6De/TG9ghSqbXY7DlJbSILagGCeCsU445u52+PKHEWnlLG6UzL9D7MSwlntsQDYSTN2tfY7/bKLTti0RgTqluyNo7OpxO2YopWhh+3sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199015)(36756003)(31686004)(5660300002)(7416002)(2906002)(76116006)(91956017)(66946007)(66476007)(4326008)(8676002)(66446008)(66556008)(64756008)(8936002)(107886003)(6506007)(6916009)(54906003)(31696002)(316002)(86362001)(38070700005)(26005)(71200400001)(53546011)(41300700001)(2616005)(6512007)(186003)(122000001)(478600001)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mmh4a2FwT3lCa3Q5TXVpSHhHNjNyemlxSFF0ZWRic2tzTnJTblI1YUhtQ24y?=
 =?utf-8?B?N1o5a3pYRnNvL3ZmVk5xTUdSb0pHcDJONExuMmF5MVhzcUpIRk43Vm53bUhC?=
 =?utf-8?B?RVZzSC92Tjl3MnFEMTlDa21ZWTV4a3ZkWTVXd3Zmc3JnbGltWXFacm1DZWFn?=
 =?utf-8?B?OWU2emtwNDRuUy94Y01yNXdJWkZuTHNQUitNTXFXb1kvWllPQmErYjhxN21W?=
 =?utf-8?B?NTBXRUo4ekNHOXNyVHBwNWFEdTUrRGd4UWt4Z3Y1Tk9RTGQrQ1haWXdRV2p3?=
 =?utf-8?B?SmdMTU84a1dCdHhyZkZSSEk5REd1aUI2NGU4SjFmS1FDTDRWTXRzVG5BdjA0?=
 =?utf-8?B?OEtSbExSeHRhWk1OWFFEZ0FXOU5yZXFpY2NxNHBWdHFMU3hUeDdEWWJKR0U5?=
 =?utf-8?B?Q0tobERGeHpudXEvVmxMTHcyQVJxUHhzcDNlZlJYUm43Q1N2ZDNraGxhWmNI?=
 =?utf-8?B?YjFJbHIxMkR3ay96anBSSHYxK0dNRG55MXVuVUpXTWtuY0Y1QS9QRGlKSmVG?=
 =?utf-8?B?amo3cGtrMHp3aFR4Rlc1blB6ek93TmZOWFNmZktEVW9jd3B3ejRRc0ZVeFdC?=
 =?utf-8?B?aHd3d1BiTWo1NktGajBmbXN5amZOOUFOVXNhMWVPTFlFbWRxT0pkODBEdVI4?=
 =?utf-8?B?cFRVS1BKU01sNjBXcEZuZ2VpUUJZZVQrZjk5WnI5VGRhMkE0UlF3bmptUXBU?=
 =?utf-8?B?VjNydVlUcE9Qc0RuaGRKd3dQdmhDYytJcmJnL1NxOEphVFBDYk1Xa2QzRGFx?=
 =?utf-8?B?bHd1K3RnVms0VFNoQnpxMXFiZ1JOT1Ara3RsZTArZTh4SEZ5cW1NVVF0aGNC?=
 =?utf-8?B?MnQyWjVUYWcwczg0Q1A0U3hteXVXSTJySDdJODZqMEp4RW9ZNXA4Z1VGV1B1?=
 =?utf-8?B?SWVYa3NKYVFTelNtTldaV3RLMi9TejBVRHZzYmphOFd1MlNWTGZFSmkzenl6?=
 =?utf-8?B?eTNrK0NRbWJGeHFOZzNWTTBjY3IvdTRqcmlDTGc3ZU0vL3ZlZUFQdFg5ZGZs?=
 =?utf-8?B?emhmWjNhc2E2YmIwRjJ6RHBnTHdxemk5YVdjSGF5dTBYLzRXdEc2bHVuUHBP?=
 =?utf-8?B?ZTVZNXFYQzZhZzFDNUtGMlVHZ2syRFA5VUlCZ3VtKzYxSlkwMzAzQzFON05C?=
 =?utf-8?B?VkZIOEdUN0FIM2hzQXdnaTNxNldsK211YUQwV1NrT2hrU09HMVBId3ZWLzFV?=
 =?utf-8?B?MnhGU2Q2elZBL2J5MUdIOUw2aWJiZGYwTmNPeUphaERNREJoMzFIZlMwT201?=
 =?utf-8?B?cUVneXY4M0h2bHROZFdEeHFNS2ZQT1Zqa0pRaVgzbzlMV3oyN3ViRUVhMktx?=
 =?utf-8?B?MElRTDJ6Y1FyWW9KT0syQy9tRUtnUzdOR2NHQWlsS3JnVGJWZmUzNDc2S2lm?=
 =?utf-8?B?YW9lSXVDamlKS250Z2h5MTBxUkhUUFJxVE5idGlJVHIvS3VqM2xyQXJ4OFFB?=
 =?utf-8?B?b2Z3RXg0eG05UUhmbE9YSy9yM1ZXU2xVV2h6Qm9ia1JVUE1yei83SkVHNFhB?=
 =?utf-8?B?Q0JKM2UzbWJlSUxudUxwUUdoRzNEa0ExZEtSSFFhZFZGdzVQTld5bE9uZklx?=
 =?utf-8?B?S29ZRnAvakFBckVKSWtwVTVIVE9vR25BRjFFMGN6d0xPQStidm00R0Q1NS90?=
 =?utf-8?B?ekxucnJocnd5UHJNRFZiZ1JjUVFEazloVkFuYnRHMk02eU9sMm1BWXMyOExp?=
 =?utf-8?B?Q1BqZG1uRTZvZmlzeW9SZ25WOGFnYkRINGJaTHdwengzbVhwSG9FdGw0bUhu?=
 =?utf-8?B?RlZpNzdJNllTanpNdkRLdUtmL0dxNEhlSGM5bXJnVVh5azhtWTN0SzREbmJh?=
 =?utf-8?B?dHdwcG0wOC9FNXhaZTRITURSK1hSaENsTy9xNFZyNXdyMk90R2ZNWjg4YXkv?=
 =?utf-8?B?VzNoU1c1N2ZYSklYVFJVZTFNMmtXQlJhY2RyMmxsRW1zUWl2R2gxeTk3T0Fl?=
 =?utf-8?B?TXVUUXlnWE5Ma1lnU244UytmZGplODVlUVBWUThQUGhqUmhQZm54NlY1dDYy?=
 =?utf-8?B?NWtxVmFwdzlxdTRUNU5UbGprS29haElyWnVjU3VWcFJ6MGJUQ2NVWmJVb1B0?=
 =?utf-8?B?VzQwWGNEaDhuSGxCZHY0c2VBRmNjNU1JaGtRVFBBODZHM1lwL3dQczBmVXY2?=
 =?utf-8?B?VXJvUm4vdVdhZmFqVTZhRUFZR0tEUUpaOXh2dkg1cXNrOERZVHFOU1M1UXNP?=
 =?utf-8?B?cVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cfa6f0-fd13-46fe-6ff2-08dacc6e4a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:45:29.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fb0sUIDvipgWcGhQD4+tUZ90s8+UtIMpjUwGcK0hZaOcDpV1BHyWgdH/L0MNvuUFyZhiAWldFcBS9tsDwr8xOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6499
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <544E91B7C73A194CA4F76B3817E5CC3D@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA1OjE0IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IA0KPiBPbiBUdWUs
IE5vdiAyMiwgMjAyMiBhdCAwMzozOToxMFBNICswODAwLCBSYWh1bCBUYW53YXIgd3JvdGU6DQo+
PiBQcmVzZW50bHksIGluaXQvYm9vdCB0aW1lIGludGVycnVwdCBkZWxpdmVyeSBtb2RlIGlzIGVu
dW1lcmF0ZWQNCj4+IG9ubHkgZm9yIEFDUEkgZW5hYmxlZCBzeXN0ZW1zIGJ5IHBhcnNpbmcgTUFE
VCB0YWJsZSBvciBmb3Igb2xkZXINCj4+IHN5c3RlbXMgYnkgcGFyc2luZyBNUCB0YWJsZS4gQnV0
IGZvciBPRiBiYXNlZCB4ODYgc3lzdGVtcywgaXQgaXMNCj4+IGFzc3VtZWQgJiBoYXJkY29kZWQg
dG8gbGVnYWN5IFBJQyBtb2RlLiBUaGlzIGlzIGEgYnVnIGZvcg0KPj4gcGxhdGZvcm1zIHdoaWNo
IGFyZSBPRiBiYXNlZCBidXQgZG8gbm90IHVzZSA4MjU5IGNvbXBsaWFudCBsZWdhY3kNCj4+IFBJ
QyBpbnRlcnJ1cHQgY29udHJvbGxlci4gU3VjaCBwbGF0Zm9ybXMgY2FuIG5vdCBldmVuIGJvb3Qg
YmVjYXVzZQ0KPj4gb2YgdGhpcyBidWcvaGFyZGNvZGluZy4NCj4+DQo+PiBGaXggdGhpcyBidWcg
YnkgYWRkaW5nIHN1cHBvcnQgZm9yIGNvbmZpZ3VyYXRpb24gb2YgaW5pdCB0aW1lDQo+PiBpbnRl
cnJ1cHQgZGVsaXZlcnkgbW9kZSBmb3IgeDg2IE9GIGJhc2VkIHN5c3RlbXMgYnkgaW50cm9kdWNp
bmcgYQ0KPj4gbmV3IG9wdGlvbmFsIGJvb2xlYW4gcHJvcGVydHkgJ2ludGVsLHZpcnR1YWwtd2ly
ZS1tb2RlJyBmb3INCj4+IGludGVycnVwdC1jb250cm9sbGVyIG5vZGUgb2YgbG9jYWwgQVBJQy4g
VGhpcyBwcm9wZXJ0eSBlbXVsYXRlcw0KPj4gSU1DUlAgQml0IDcgb2YgTVAgZmVhdHVyZSBpbmZv
IGJ5dGUgMiBvZiBNUCBmbG9hdGluZyBwb2ludGVyDQo+PiBzdHJ1Y3R1cmUuDQo+Pg0KPj4gRGVm
YXVsdHMgdG8gbGVnYWN5IFBJQyBtb2RlIGlmIGFic2VudC4gQ29uZmlndXJlcyBpdCB0byB2aXJ0
dWFsDQo+PiB3aXJlIGNvbXBhdGliaWxpdHkgbW9kZSBpZiBwcmVzZW50Lg0KPiANCj4+IEZpeGVz
OiAzODc5YTZmMzI5NDggKCJ4ODY6IGR0YjogQWRkIGVhcmx5IHBhcnNpbmcgb2YgSU9fQVBJQyIp
DQo+IA0KPiBJZiBpdCB3YXMgbmV2ZXIgd29ya2luZywgdGhlcmUgaXMgbm90aGluZyB0byBmaXgu
DQo+IE9UT0gsIHdpdGhvdXQgQ2M6IHN0YWJsZUAgdGhpcyBpcyB1cCB0byBzdGFibGUgbWFpbnRh
aW5lcnMgdG8NCj4gYmFja3BvcnQuDQo+DQoNCkFncmVlLCB3aWxsIHJlbW92ZSBmaXhlcyB0YWcu
Lg0KDQoNCj4gDQo+PiBTdWdnZXN0ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPg0KPiANCj4gSSBkZWZpbml0ZWx5IGhhdmVuJ3Qgc3VnZ2Vz
dGVkIHRoaXMgZml4Lg0KPiANCg0KWWVzLCBpIGNvcHkgcGFzdGVkIHRvIGVudGlyZSBzZXJpZXMu
IEkgd2lsbCByZW1vdmUgaXQgZnJvbSB0aGlzIHBhdGNoLg0KDQo+IC4uLg0KPiANCj4gVGhlIGNv
ZGUgbG9va3MgZ29vZCB0byBtZS4NCj4NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KUmFodWwNCg0K
DQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0K
PiANCg0K

