Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A885FC39F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLKRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:17:17 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120077.outbound.protection.outlook.com [40.107.12.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62F10050
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCoXXZYHhFX2G9MonNHNFu/R8rOTWGxAGBrM1FQTobxGEOxp4RzIna2X3qHl/HLgmIjt+KeeKDE/O0TNEmxp9GZkpdK9UbLX4JRfefhCuFhN7DNvdUi/8P/xQE3kk1MPOwM9GrYRE33VfiYAdVF/5/g3xLgu+Pc0Oo/hrcJpoq7TAd7J8QG+PeJz/fKLS6b04KOxAzAiUiC3GS2yvmXp3RjVEj/b6sFexLyKKfZs11/YKMvdNDxDi20s/+32/DlPw628zJOXDPU5LaqXdldFyxcWrwCOupT/utViBq5V/sY4Kzp6439I9Z/S1/WXwnrT7gVxDGDDS91eZWH04Cfvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXhQDbvV0G5H312G6k/ytNDjTYJNo3S/YuRcx20WVFY=;
 b=ncFEGMSbJK09tKV593BgXeku/zC0Vby+JMw/mw8W1YQerlUrOgHsFKshSfBea0MmdRHJS8FEGos1WKSJ+LCWXfOdl15lfmilXNgx6jq+k8Xs/14NuCwORL6Qa+5x2DKpnaiFpzy0AwEFqYDIFN3UFMfSLl2uSgK3hMAJ4wtqUvFq3byDeR8JRvZQWMd/0MHZpdxvrVui7lMiMuX+JqV/r0KjBR7tmL8pgkuE8I2i9ZQRVAKlDOdjJKH8F0v5H4zG6RPoaf9QihcycmcLnzvey/wJpl5O4UZ1gnuNwef25Hwo7/LqxuTMKO5TfPtSFoHlzE+b8lAOXHknV6baglp9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXhQDbvV0G5H312G6k/ytNDjTYJNo3S/YuRcx20WVFY=;
 b=1NKKcbnSAXXiVJY7x/7HGXk1Uxxyn+k9VepnlO4j2xG517LscKbxJG7+tmEC5gQa4u6JN3e8m3hqVKYDhkQdGE6laFUd+zALuMGswV2LqMATHZckhMDSHdBFX3S+Ovc4TGs/JfIfnPXYK9ziC2QYxouBygs/XnPVqptOJwv/HK1rEvK79EJTbHuL8DLE8hbMGgleC0K3vtMrcp0fLwuIIRdtE+s0Ee80Aot7ICGNx13AZy4LiYZ3OEMlb4gqTUdSLje6KYUtQKHjhVgr3MBrROhaIzkiHUgLFZIcJFSbxeeT/z5kUmzUh6z0eTziDOJJD5QgQ3wa6ZyYE1oRFl4g+Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2895.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 10:17:13 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 10:17:13 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "shorne@gmail.com" <shorne@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v3 05/11] arc: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v3 05/11] arc: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHY28pqiGUSLkalmUiLbeWAFE5mta4Kj/oA
Date:   Wed, 12 Oct 2022 10:17:13 +0000
Message-ID: <bbfa1fd5-3dae-2d00-0421-5f1e627eb8f7@csgroup.eu>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-6-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-6-bhe@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2895:EE_
x-ms-office365-filtering-correlation-id: 1ac345d5-dc7f-4aa4-36e0-08daac3aee67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8TktuRnTakeNYkeE0NiiMuEKM4zpWae9w45fNMqn+wgUjXOQTIWgIsnYIR7KScg3CnxTsBQOakcZj2cgM8iFGVWIH8ee9tRh/gsMml46OjYPhL+canFpE5CzQzOXHBtAlNNDmj126cT1kUSjxBh/E/sQic/U/FKyuVHvM0F5MD4ZXW5dxGum137Q3qaOrF4Tz3O+23yIccEfaoV6/gV/YCru/fNHdlX9qAi7nq1ztan4usLkDV6u7mTHmY49WQulA9Y+tVniX7Kx7mR6424EhKu3TJ8Lf9EcCe0B9zUlijwrQCggGpsJm14wP58amdRfkorRzG62DPKNKoE6jcWn8ane4M77E/9AM2i5rjC8m17jagrZ7RBmH4Q4Ch4WOUiWzfGcZhC5YFiYm39MEWbkBN/eP2egc8AoIWMBPwcBWvsEyryRpaZ3ZHwxD5+m8xK2xKkS56NjO1rC5/xQKBeoM1WfTngXp3Q7iYm9z0Pk6vLQ3YrwDeGdVqFhe0jemLRTnlU1bx88x5VFbCQbk3I2Ap54YijUUSjohxYKwpl91wqikdeV6RMuHatL9kWivoXYMivhRo0GmAdc+49lQkQ0NoSjzBL+cbli+31ib1MaFbHEjTAvQj2XeVn4Ol3knuxHMGzhthralCpcYFw4iWap62qwC4vejnH4hbc7urWfBLAzoxIOXQ2XozINGIq8wHB0a3ELDfiNZ1tvgWdf5Sc2xLRgu9umLz2ZNqFiiqyzNo0ZWEOR1lB1NPv2Sgqb0A4jgtG6i4U9EE7DzjNVoNt+jZAPBtJIiocMMgCP9OvRcZT3UIvEhBjTl/KndFQcyGAL90uI3bUYGzZ1/H94jEI5b/joBTkJVqfvOaRtfEuveM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(31686004)(86362001)(44832011)(71200400001)(5660300002)(83380400001)(64756008)(66556008)(66574015)(66476007)(8676002)(4326008)(66946007)(91956017)(76116006)(66446008)(7416002)(316002)(41300700001)(2906002)(110136005)(54906003)(122000001)(6486002)(36756003)(6506007)(26005)(186003)(2616005)(31696002)(38070700005)(8936002)(38100700002)(478600001)(6512007)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzFNcnBvNVNnQjlHanVvN0JlYjhWTWtNeWo1Wkl5NHBzVWtXRGRLZDFqTGR5?=
 =?utf-8?B?YlgvVWVJTlhjeXlycURqV21xeGhtZkZseUdaNmFWTkM2WCtzSG95QUpibkhF?=
 =?utf-8?B?SUJmb2VNMHA3R1VGL1BadFAzMFNjNHZLTjR6NTZOTk5LQ3hOKzh6a2VPRklj?=
 =?utf-8?B?TXBFNHIzQjNzNU90K0JLY21sbGdrVGhSc2paUDJCdXpMbmJTeXNpeEszUG8z?=
 =?utf-8?B?SitqaWx3eWJXZDNTUU11ZjE2eldFMDRCUGl2V1lzSThKOTFMZlp6V2taaE81?=
 =?utf-8?B?emhiQlhnZHdMR2FLR1p0RXJNSmRPd0dmVkJTSmF1aGhuNnBsSmwxL2FvTHJr?=
 =?utf-8?B?RDR2K1dJbjAxRHo3T0d3NTA5bnRJRGVtUjFPYUZma0NhUVduVzZZRmpkejJy?=
 =?utf-8?B?YXZMYTZnT0RGWXEvbTFERzNPTWM5eGVOUGFUazgyUCsyWkdMem01YU9scUM5?=
 =?utf-8?B?K1dQVExGQ3RxdGZhY3VYeTU4TlpZZlducXpUMzN1Z0laNFlyU20rdTVwMHlS?=
 =?utf-8?B?K3ZBWEZHTEdBZ0RtM2hZVlU2UEszU29FR0NZTHVucklrV2cvekcydnh5UWN5?=
 =?utf-8?B?UlpXM0Rwa3kxdzZGc1FYVk9XS1JwbUpoNG03T0tVZDVUc200STFhY3BQbTlO?=
 =?utf-8?B?bC9XQnNuK0wraXRkeE95WmRGcUtzTThROEVBNVlKUGh3bkhTZ3FQTkMwNGZS?=
 =?utf-8?B?Rm1JSldZaFpiNmZpdDN5Y2dHeG1DYWZHdHlPTHYxTkg0RXUwNzVBRWFiNzQy?=
 =?utf-8?B?SzFNWWhhdUpxZjRKWUovNnJydEZPc3BRYVQwZWJ5bk5WajNHZ1VQdjRNb0xz?=
 =?utf-8?B?Z20wcTBBeFRWaDllWXRuQmdqMzBGUVkwb3hTVGtFRjREb0U0OVdTcHU0aFFp?=
 =?utf-8?B?cEJJUWNwcE1KckllM2Q3VzhJclA2bWZZMWdiU2pFOHFIeFJMVGYvMkR5ajFs?=
 =?utf-8?B?QlVHZ05mY0txN0pzZGMySjlWZENBbnhCL2FnYUI1TElWY0R4VVRyN0Fjdnk5?=
 =?utf-8?B?cjdhbS9neitTM1FWWXZIdnVVdG01QTNRVWhkNkEyY1U4VWozVUYra0dFWG5m?=
 =?utf-8?B?V1VrcFYxSUlMN0lzOGdSR1ZhVzhCOGw1UmwySXMybEpDU1BNZUljYmdVQzRU?=
 =?utf-8?B?cmlyOXlDNDF3OHVUek84cm92YXAwb0RRL29wSjN2VEpGVmFiTVdtT3BWWmtu?=
 =?utf-8?B?YWFET3pEWkxmaUl5Vzd4ZFFSVlRXRnlPTVQ2N1BhNkY5N0VYdmhRS2FJRjRr?=
 =?utf-8?B?VUdyejhWVStoeDdmTGYvWHZTeklNdER2ajBTckZiUGRWbUVJM0MzUnI2QVBz?=
 =?utf-8?B?QzBhRDVKVHdkWHNjRmlVRkJNd0pWaVVPZ2h6WDZYZWNhbjN6aG96ZkxwTlVD?=
 =?utf-8?B?RmlENTEyOTZnNTZJTTN6SDhtK2l1UDdzK3MyeWpIUUtpZmJNa1hQSVA0UXJl?=
 =?utf-8?B?TkJBNG9GYmRBRjhYaHNtVTlhWitYa24vMmcyaStZS3ZjeStDWG9KR05oVS9k?=
 =?utf-8?B?RWNuYVQxa1NiUlhLOTBud2FJSGQ3cFBNRHBTVjNtTFlkd0g2dnBKREZ5RTFI?=
 =?utf-8?B?RmUxSTZEalFVRjk5L3JOTVR6RDh1T2JkT2RackhOcEtFR0VxL2NyOWRrV091?=
 =?utf-8?B?M2pobkRLOW9KbHJ5MVJQRUpZd2Nyem5nb1NjQ2RtV2k5MkhTSXk0ZDIvQ3E3?=
 =?utf-8?B?dDhibUVoeXJreFlnRFBHVmcrcWJIS3ViLzVRYjJkdmNocWpjbS9rQlM0Mlg4?=
 =?utf-8?B?UjRienliQ1RjNENqTDEzV1RHR1RmTXQrcm5icHpIOGdIUlNCQlJJVEx4N0dX?=
 =?utf-8?B?R2lvNDYyRUVaMzNiNHZxKzlnME8xUy9XOTA3Ky9KbmFoNW55dXlpMXVhWkVa?=
 =?utf-8?B?T1VneEdxdEVzRlRZSGMvUXZEMHlOQUMyM0c5S0hyR2IzTlRydjlUbEEwbVA4?=
 =?utf-8?B?Y2k0eEVVMUpBQXdwVFROUjlyTlFFR2JzemRKVkU0Tk02d2o1Z2NXU3gzUEJM?=
 =?utf-8?B?RHczSlRyNU5MY3p1UzBwRWhiMDIrRG1rb2hTOVZueXJaM1p4VmJ5c0JuK2Zu?=
 =?utf-8?B?RHBseGNOOW0vcW5XeVp5SUtVNG4wWTJPY1NETTZyVG1FNGxaYUdCc3dDVzNL?=
 =?utf-8?B?bytOU29rWXdGVGQ1c2ZMQWt1REpjb1dka2FzTk8zRytVOFpzcHJDd0d1QXcv?=
 =?utf-8?Q?k3gm/XR0lVG3hERWibM/rvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F51DAE7125A944F9D007FCD563A2218@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac345d5-dc7f-4aa4-36e0-08daac3aee67
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 10:17:13.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhhNNn42IgEE1TgDcmWA6u8H6gZlTW4w+YT4hCrMlBg9h/nHaJmR1gUqxVZnpkFd9T1E3PNSsYwbB9dO8rPMeH7l3gYvJ9VYMLzqQ0omADs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2895
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA5LzEwLzIwMjIgw6AgMTI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gQnkg
dGFraW5nIEdFTkVSSUNfSU9SRU1BUCBtZXRob2QsIHRoZSBnZW5lcmljIGlvcmVtYXBfcHJvdCgp
IGFuZA0KPiBpb3VubWFwKCkgYXJlIHZpc2libGUgYW5kIGF2YWlsYWJsZSB0byBhcmNoLiBBcmNo
IG9ubHkgbmVlZHMgdG8NCj4gcHJvdmlkZSBpbXBsZW1lbnRhdGlvbiBvZiBhcmNoX2lvcmVtYXAo
KSBvciBhcmNoX2lvdW5tYXAoKSBpZiB0aGVyZSdzDQo+IGFyY2ggc3BlY2lmaWMgaGFuZGxpbmcg
bmVlZGVkIGluIGl0cyBpb3JlbWFwKCkgb3IgaW91bm1hcCgpLiBUaGlzDQo+IGNoYW5nZSB3aWxs
IHNpbXBsaWZ5IGltcGxlbWVudGF0aW9uIGJ5IHJlbW92aW5nIGR1cGxpY2F0ZWQgY29kZXMgd2l0
aA0KPiBnZW5lcmljIGlvcmVtYXAoKSBhbmQgaW91bm1hcCgpLCBhbmQgaGFzIHRoZSBlcXVpdmFs
ZW50IGZ1bmN0aW9hbGl0eQ0KPiBhcyBiZWZvcmUuDQo+IA0KPiBIZXJlLCBhZGQgaG9va3MgYXJj
aF9pb3JlbWFwKCkgYW5kIGFyY2hfaW91bm1hcCgpIGZvciBhcmMncyBzcGVjaWFsDQo+IG9wZXJh
dGlvbiB3aGVuIGlvcmVtYXBfcHJvdCgpIGFuZCBpb3VubWFwKCkuIE1lYW53aGlsZSBkZWZpbmUg
YW5kDQo+IGltcGxlbWVudCBhcmMncyBvd24gaW9yZW1hcCgpIGJlY2F1c2UgYXJjIGhhcyBzb21l
IHNwZWNpYWwgaGFuZGxpbmcNCj4gaW4gaW9yZW1hcCgpIHRoYW4gc3RhbmRhcmQgaW9yZW1hcCgp
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+IENj
OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtc25wcy1hcmNA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiAtLS0NCj4gICBhcmNoL2FyYy9LY29uZmlnICAgICAgICAg
IHwgIDEgKw0KPiAgIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2lvLmggfCAxOSArKysrKysrKystLS0t
DQo+ICAgYXJjaC9hcmMvbW0vaW9yZW1hcC5jICAgICB8IDYwICsrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygr
KSwgNTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvS2NvbmZpZyBi
L2FyY2gvYXJjL0tjb25maWcNCj4gaW5kZXggOWUzNjUzMjUzZWYyLi5hMDhkMmFiZmFmNjEgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJjL0tjb25maWcNCj4gKysrIGIvYXJjaC9hcmMvS2NvbmZpZw0K
PiBAQCAtMjYsNiArMjYsNyBAQCBjb25maWcgQVJDDQo+ICAgCXNlbGVjdCBHRU5FUklDX1BFTkRJ
TkdfSVJRIGlmIFNNUA0KPiAgIAlzZWxlY3QgR0VORVJJQ19TQ0hFRF9DTE9DSw0KPiAgIAlzZWxl
Y3QgR0VORVJJQ19TTVBfSURMRV9USFJFQUQNCj4gKwlzZWxlY3QgR0VORVJJQ19JT1JFTUFQDQo+
ICAgCXNlbGVjdCBIQVZFX0FSQ0hfS0dEQg0KPiAgIAlzZWxlY3QgSEFWRV9BUkNIX1RSQUNFSE9P
Sw0KPiAgIAlzZWxlY3QgSEFWRV9BUkNIX1RSQU5TUEFSRU5UX0hVR0VQQUdFIGlmIEFSQ19NTVVf
VjQNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2lvLmggYi9hcmNoL2FyYy9p
bmNsdWRlL2FzbS9pby5oDQo+IGluZGV4IDhmNzc3ZDY0NDFhNS4uNDFhMzE3NTY3OTIwIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FyYy9pbmNsdWRlL2FzbS9pby5oDQo+ICsrKyBiL2FyY2gvYXJjL2lu
Y2x1ZGUvYXNtL2lvLmgNCj4gQEAgLTIwLDkgKzIwLDIwIEBADQo+ICAgI2RlZmluZSBfX2lvd21i
KCkJCWRvIHsgfSB3aGlsZSAoMCkNCj4gICAjZW5kaWYNCj4gICANCj4gLWV4dGVybiB2b2lkIF9f
aW9tZW0gKmlvcmVtYXAocGh5c19hZGRyX3QgcGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSk7DQo+
IC1leHRlcm4gdm9pZCBfX2lvbWVtICppb3JlbWFwX3Byb3QocGh5c19hZGRyX3QgcGFkZHIsIHVu
c2lnbmVkIGxvbmcgc2l6ZSwNCj4gLQkJCQkgIHVuc2lnbmVkIGxvbmcgZmxhZ3MpOw0KPiArLyoN
Cj4gKyAqIEkvTyBtZW1vcnkgbWFwcGluZyBmdW5jdGlvbnMuDQo+ICsgKi8NCj4gKw0KPiArdm9p
ZCBfX2lvbWVtICoNCj4gK2FyY2hfaW9yZW1hcChwaHlzX2FkZHJfdCAqcGFkZHIsIHNpemVfdCBz
aXplLCB1bnNpZ25lZCBsb25nICpwcm90X3ZhbCk7DQo+ICsjZGVmaW5lIGFyY2hfaW9yZW1hcCBh
cmNoX2lvcmVtYXANCj4gKw0KPiArYm9vbCBhcmNoX2lvdW5tYXAodm9pZCBfX2lvbWVtICphZGRy
KTsNCj4gKyNkZWZpbmUgYXJjaF9pb3VubWFwIGFyY2hfaW91bm1hcA0KPiArDQo+ICt2b2lkIF9f
aW9tZW0gKmlvcmVtYXAocGh5c19hZGRyX3QgcGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSk7DQo+
ICsjZGVmaW5lIGlvcmVtYXAgaW9yZW1hcA0KPiArDQo+ICAgc3RhdGljIGlubGluZSB2b2lkIF9f
aW9tZW0gKmlvcG9ydF9tYXAodW5zaWduZWQgbG9uZyBwb3J0LCB1bnNpZ25lZCBpbnQgbnIpDQo+
ICAgew0KPiAgIAlyZXR1cm4gKHZvaWQgX19pb21lbSAqKXBvcnQ7DQo+IEBAIC0zMiw4ICs0Myw2
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb3BvcnRfdW5tYXAodm9pZCBfX2lvbWVtICphZGRyKQ0K
PiAgIHsNCj4gICB9DQo+ICAgDQo+IC1leHRlcm4gdm9pZCBpb3VubWFwKGNvbnN0IHZvaWQgX19p
b21lbSAqYWRkcik7DQo+IC0NCj4gICAvKg0KPiAgICAqIGlve3JlYWQsd3JpdGV9ezE2LDMyfWJl
KCkgbWFjcm9zDQo+ICAgICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9tbS9pb3JlbWFwLmMg
Yi9hcmNoL2FyYy9tbS9pb3JlbWFwLmMNCj4gaW5kZXggMGVlNzVhY2E2ZTEwLi5jMmRjYWNkNTZh
Y2EgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL21tL2lvcmVtYXAuYw0KPiArKysgYi9hcmNoL2Fy
Yy9tbS9pb3JlbWFwLmMNCj4gQEAgLTI1LDEzICsyNSw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBh
cmNfdW5jYWNoZWRfYWRkcl9zcGFjZShwaHlzX2FkZHJfdCBwYWRkcikNCj4gICANCj4gICB2b2lk
IF9faW9tZW0gKmlvcmVtYXAocGh5c19hZGRyX3QgcGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkN
Cj4gICB7DQo+IC0JcGh5c19hZGRyX3QgZW5kOw0KPiAtDQo+IC0JLyogRG9uJ3QgYWxsb3cgd3Jh
cGFyb3VuZCBvciB6ZXJvIHNpemUgKi8NCj4gLQllbmQgPSBwYWRkciArIHNpemUgLSAxOw0KPiAt
CWlmICghc2l6ZSB8fCAoZW5kIDwgcGFkZHIpKQ0KPiAtCQlyZXR1cm4gTlVMTDsNCj4gLQ0KPiAg
IAkvKg0KPiAgIAkgKiBJZiB0aGUgcmVnaW9uIGlzIGgvdyB1bmNhY2hlZCwgTU1VIG1hcHBpbmcg
Y2FuIGJlIGVsaWRlZCBhcyBvcHRpbQ0KPiAgIAkgKiBUaGUgY2FzdCB0byB1MzIgaXMgZmluZSBh
cyB0aGlzIHJlZ2lvbiBjYW4gb25seSBiZSBpbnNpZGUgNEdCDQo+IEBAIC00NCw2MiArMzcsMjUg
QEAgdm9pZCBfX2lvbWVtICppb3JlbWFwKHBoeXNfYWRkcl90IHBhZGRyLCB1bnNpZ25lZCBsb25n
IHNpemUpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0woaW9yZW1hcCk7DQo+ICAgDQo+IC0vKg0K
PiAtICogaW9yZW1hcCB3aXRoIGFjY2VzcyBmbGFncw0KPiAtICogQ2FjaGUgc2VtYW50aWNzIHdp
c2UgaXQgaXMgc2FtZSBhcyBpb3JlbWFwIC0gImZvcmNlZCIgdW5jYWNoZWQuDQo+IC0gKiBIb3dl
dmVyIHVubGlrZSB2YW5pbGxhIGlvcmVtYXAgd2hpY2ggYnlwYXNzZXMgQVJDIE1NVSBmb3IgYWRk
cmVzc2VzIGluDQo+IC0gKiBBUkMgaGFyZHdhcmUgdW5jYWNoZWQgcmVnaW9uLCB0aGlzIG9uZSBz
dGlsbCBnb2VzIHRocnUgdGhlIE1NVSBhcyBjYWxsZXINCj4gLSAqIG1pZ2h0IG5lZWQgZmluZXIg
YWNjZXNzIGNvbnRyb2wgKFIvVy9YKQ0KPiAtICovDQo+IC12b2lkIF9faW9tZW0gKmlvcmVtYXBf
cHJvdChwaHlzX2FkZHJfdCBwYWRkciwgdW5zaWduZWQgbG9uZyBzaXplLA0KPiAtCQkJICAgdW5z
aWduZWQgbG9uZyBmbGFncykNCj4gK3ZvaWQgX19pb21lbSAqDQo+ICthcmNoX2lvcmVtYXAocGh5
c19hZGRyX3QgKnBhZGRyLCBzaXplX3Qgc2l6ZSwgdW5zaWduZWQgbG9uZyAqcHJvdF92YWwpDQo+
ICAgew0KPiAtCXVuc2lnbmVkIGludCBvZmY7DQo+IC0JdW5zaWduZWQgbG9uZyB2YWRkcjsNCj4g
LQlzdHJ1Y3Qgdm1fc3RydWN0ICphcmVhOw0KPiAtCXBoeXNfYWRkcl90IGVuZDsNCj4gLQlwZ3By
b3RfdCBwcm90ID0gX19wZ3Byb3QoZmxhZ3MpOw0KPiAtDQo+IC0JLyogRG9uJ3QgYWxsb3cgd3Jh
cGFyb3VuZCwgemVybyBzaXplICovDQo+IC0JZW5kID0gcGFkZHIgKyBzaXplIC0gMTsNCj4gLQlp
ZiAoKCFzaXplKSB8fCAoZW5kIDwgcGFkZHIpKQ0KPiAtCQlyZXR1cm4gTlVMTDsNCj4gLQ0KPiAg
IAkvKiBBbiBlYXJseSBwbGF0Zm9ybSBkcml2ZXIgbWlnaHQgZW5kIHVwIGhlcmUgKi8NCj4gICAJ
aWYgKCFzbGFiX2lzX2F2YWlsYWJsZSgpKQ0KPiAtCQlyZXR1cm4gTlVMTDsNCj4gKwkJcmV0dXJu
IElPTUVNX0VSUl9QVFIoLUVJTlZBTCk7DQoNCkkgdGhpbmsgdGhlIHNsYWJfaXNfYXZhaWxhYmxl
KCkgY2hlY2sgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIGdlbmVyaWMgDQpmdW5jdGlvbnMuIE9uIGFs
bCBhcmNoaXRlY3R1cmVzIFNMQUIgbXVzdCBiZSBhdmFpbGFibGUgYmVmb3JlIHlvdSBjYW4gDQp1
c2UgZ2V0X3ZtX2FyZWFfY2FsbGVyKCkgYW5kIHZ1bm1hcCgpDQoNCkNocmlzdG9waGU=
