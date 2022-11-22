Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94881633907
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiKVJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiKVJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:50:14 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B72F3B7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669110549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++6jCyUWhgl+AO9BCP35VWtiY3btW+9+fbAeJFJTpxI=;
        b=k1puzlLO/94LNt0YPeqRL0LUqY0riVeJhRRrs7kGi8QFCGB7f6vah4g38XJq8nmduOv2tM
        QxnOfAaiVmIcJ8J6uDUFGFGVTwoanMvBkVyVU/VL4M4FAq2jjnAZhYoE9h7JYHcPcRiFls
        utHWfxQnH+hZNNOdZklkObR2FpiDfYklmYF+LG9AszBvmuMUR9aWHlaQlIgZx/6yzem9TF
        4+809sjnka0hwoS62kRp/DSNBHHx3C2sPDNapH5bQC2Qthydnupy3Rby0PLQlqded1CT8j
        sKPWe8p1vt+m4U1KnkNwab6oDwK6A+XlEpG8bBG/DGRxrmH0OY5dYin7o9qIkg==
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-x1h5qp3HNR270WJcm6yohA-1; Tue, 22 Nov 2022 04:49:07 -0500
X-MC-Unique: x1h5qp3HNR270WJcm6yohA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6122.namprd19.prod.outlook.com (2603:10b6:8:6d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.11; Tue, 22 Nov 2022 09:49:05 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:49:05 +0000
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
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Topic: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Index: AQHY/kRd6x7F/veGJUyUIWlGtgApL65KqhWAgAAIsIA=
Date:   Tue, 22 Nov 2022 09:49:04 +0000
Message-ID: <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
In-Reply-To: <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6122:EE_
x-ms-office365-filtering-correlation-id: 4e0ffc08-d418-42c4-1ec3-08dacc6ecaf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: v1kqiP46Ta00adSelINkgUheCQBmhExsE50PyKF/UCrAaIHysOJixBvXgMQFSoeEdc/FPi4a+zj4OIttcFhiXnGgxUTJNvppSZUuncQ6xKahHYqBM1q8hZ7ExVVEXVS80qpqSvcT5GYBxEDoZDwJmnPV+UpssdbgqyzDwc9sun1qbH/nODsEG88Otjmsm8KhwT0Aid474p8ycjzuIg9lmAzA/3i+bpgdzJEGCqEl8KdBLUYq/fDDLuv4poogziE2xpyujkNICvup9OG0YF1/coguofPuK16R0fHVMur9/WazB/mTtoiiBGlrpcJJEstfHL1KfsaryYwGH9sg95qHo3/ZxjawYPHwtZp4Tg7pX57tzDi2X6BpDh8B39XJR9wq18i/Y6HrwIxtZBTIY8pudoDoKNF+Girnl1vgO0v+jYVHY0B7rIEWyyHZsiSE33WFMQadmFqHMdNMnzBBJv2wUkdLe/xx8u6MsMX+HkF/T8uxlSD89I4lAoed3S0sQ2UgthHVBFbvH87cJf7mA/jthtyAChx/VYzPxa1f7sl+EzfCOJwnXOlvLkhjw/bwkVsuQ8UOD/j2s8sgPcU/oLGYSgjzeor8UJhp63xSrrMyQH1pMD3OfRUSb6L4/fQI8t0LTwOsLl+9/JHgymohuYmtvA6bydbqzP6tDPHoz1F9nzd47FlWrfwrqq1dVBBOx0bFSTpJlwCEEEjOwcawbOnCTcCUrayP3sAyfwBzi4dThQ7NFnL/S99E/mSXuDaAoynKppXRY97OZQ39ZEIsysmISg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199015)(38100700002)(122000001)(186003)(478600001)(31696002)(86362001)(54906003)(38070700005)(8676002)(4326008)(53546011)(6486002)(6506007)(107886003)(8936002)(64756008)(71200400001)(76116006)(66446008)(66946007)(7416002)(316002)(66556008)(41300700001)(66476007)(5660300002)(6916009)(2616005)(91956017)(83380400001)(4744005)(2906002)(6512007)(36756003)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFlaeW9tWEM2YjQvb3JjRFdaM0YrY3BhTGtSNkliTVJSRWpKTTVKeTVKNW00?=
 =?utf-8?B?UGk0bzhieHhPZkFZbHZsNCtkSU8wVmJKbWp4VS92OFlZakludGRuZXdSYmYy?=
 =?utf-8?B?UEVwZVViSHRMRXRhSkZxU05NZkhKY3Nza0tWSFNwenlXakVmSkt1TkRYWUVC?=
 =?utf-8?B?MnZMa2Q4SG5MbFhPaEUxMGJZVmJWYURxSE94bWdLTHNpNHJkTkFrRGRUUzR6?=
 =?utf-8?B?S0FMUTVvajFPQ2RzdjJaUklmSUZPOTdza1NRKys2cGlnVnZXaS9FOGJKTjZT?=
 =?utf-8?B?RS9aNEVmYjBEMWp4dVhFRUVHQWRyNDZRaFlod2hwWlFkaGN6R2M0U0hEVmYr?=
 =?utf-8?B?OTltZGVLbUZvdXR2VzEyMWxJQVpscTZBTEdJazRmYmRRZ211S1Z1dVQvYTRT?=
 =?utf-8?B?aVFMVFIvaFMrc3ppaXVYY3c1SGFWUEQwQzFZS01oaldXaHZxTjNKWXFZaVdy?=
 =?utf-8?B?TFJoOUMzWENRaUtVRE53Tkc1NEN5TWdueXhrZnNwNkNzQXAvTFJWaFNuRzFY?=
 =?utf-8?B?OVdUWEFJR0FNUjZsQ3lpN0RRd1JkYjdlaUtva2xkbEI5N0hVTnJnemNrN283?=
 =?utf-8?B?R3lKSUtHekhUYmljbTBIcUxrYVprSS9JSlh3SjNKSnhHMWZ6MGRWaFJrcytZ?=
 =?utf-8?B?UmRKbndOM0RDVXd2Q0JCQkNwb2NDSzFYa280N05qcEd0RVd3V1poTk5rNTRR?=
 =?utf-8?B?bzE3YzZDRFdRSHUxMWtxVktEcU9KbDJBdWpGQ1VCSEh1RFpXUE5wSEJ5dVhO?=
 =?utf-8?B?NDQ5dk11dHQyVTlGQjUrK0JoZDZpQ1BXQVFESy9KWHpxUHdkb1lCWDZwZjNp?=
 =?utf-8?B?MFlGSTZYYXJUb241ZGJRZHA5aU9XVjdiNGJEdjRMb045cXV5R0lmN3NUVWc5?=
 =?utf-8?B?MEZ4VGtWZ1ZCTVhZdC9Sc25SUTZJZWpPZVEwaTdrRmVLZ0g3UFc1QXZobjhG?=
 =?utf-8?B?ZVFDcmttTnRqODcxTXNSalRtZmJpWTdFSThEWG95UVBRUFZ6cUcvWnM4Mlhw?=
 =?utf-8?B?ZTZyUi9vdkxnTWc5c1RhMzA2d1E4S0dIeVhNSEg5MGtRUnVRcElCM1czbGlw?=
 =?utf-8?B?VHc4Z203RzgxNkxIM3ViZUYwOE5oSTBPWTNEd3NmSmltWDFKVHJKTEg3OUVq?=
 =?utf-8?B?OW9UK2VHTHJBWnA1L1NabUMvckRvTG1RQWdMdGNpSm02WTEwZzE3cE1BRVRS?=
 =?utf-8?B?UXRZTkY5eE1XajNHZ25OWjMxaTNLV2U3QXdPeGsrU1lyZktRblNtaDhmZkxM?=
 =?utf-8?B?bi9JbXNqbGZFQUNrc2MwM1IvSWpjYjAxai8vSGU2a2F5MjFvMkR5b0FpY3RM?=
 =?utf-8?B?MmhEVS9ScGNSSVNrZEcxWE84RTFXM0xPRzJxMk0rS29EUFA0SDJlck4xdE1I?=
 =?utf-8?B?VUNmdXl3N3FEcXlyTXIrYkNkb2pKUGFUY05VRkhZdmU3SzA5cC83RWRla3dj?=
 =?utf-8?B?QjhkZFBHSTdsS3NVQnVwWUFETEs5YXRicTBRbzNCcE1JV2FXQ1lNQnc4SGts?=
 =?utf-8?B?Y2NzQm5mSHNPejFxcGFzOGxHdDhHcDFIbEVnYU14YmVVRURxamVqUkQxZ0sw?=
 =?utf-8?B?MFpCUzNtY1hqMFZ2YWd3WWFJSVdzdTY3OE93cTAvRzA4Q2hVeHhPdWtXNHAy?=
 =?utf-8?B?Z005bEZzM3ZjVW93aUNaRWoweXVmamkvNHZkaUNxaklpNndjTDY0U3VSQTZP?=
 =?utf-8?B?cVk5eTRQd0lZVHhGazZWaTc5M0xsVTRIWWZUOWdtbUhtNktkSndXaGh3TDlQ?=
 =?utf-8?B?b1ZxWnBObVNjSHNRdTFEQWc0dFNkU1hTRTBXdWVxTEVRdk1ySVZrZUU5eVRx?=
 =?utf-8?B?OWlmMEYxZUJzaldDdjhRYnpqeUQwUk5rSWVpZkxENEd0UXY4K2hPODJCQ1Rr?=
 =?utf-8?B?SERNWm9IbEFVUDBDV1VJai84MTBkU0hCTDhGeTVqYVdxRmVlemhJeU0vMnZR?=
 =?utf-8?B?WlN5c1JYSlRWbHdQVDUwZjBFcnBRTFlHRHUyV3J1b3Z0cHlFcE9GWGlOT2VD?=
 =?utf-8?B?bFdhTEcxT1VpcDhwRkdMQW5KOEFzUnIvN3NjTGRGajFJWkljNDdaVURqb1Jm?=
 =?utf-8?B?ekNQYnp5Yjd5YmYxZEd3dE14dWg3YjF3YWRYZWxkZlJ6WnpoUktoZ3pZSU5N?=
 =?utf-8?B?d0NTV2U0U2FpV3FhYjQ0KzlJVDF2TVMyUVUzeFgyZW5pZUxOUmVLN25RNDBC?=
 =?utf-8?B?RFE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0ffc08-d418-42c4-1ec3-08dacc6ecaf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:49:04.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+fjTakFzBR0yl8wSXiFWHQ+W98bQl+bwJ+qXYDshFy2u4gLTcPf3YnNca2jF+BErYjN5+Mr8I567bWarFHZaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6122
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <5AE8D1E93CC23F448AF035582D55234D@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA1OjE4IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IA0KPiBPbiBUdWUs
IE5vdiAyMiwgMjAyMiBhdCAwMzozOTowNlBNICswODAwLCBSYWh1bCBUYW53YXIgd3JvdGU6DQo+
IA0KPj4gUmFodWwgVGFud2FyICg0KToNCj4+ICAgIHg4Ni9vZjogQ29udmVydCBJbnRlbCdzIEFQ
SUMgYmluZGluZ3MgdG8gWUFNTCBzY2hlbWENCj4+ICAgIHg4Ni9vZjogSW50cm9kdWNlIG5ldyBv
cHRpb25hbCBib29sIHByb3BlcnR5IGZvciBsYXBpYw0KPiANCj4gWW91IG5lZWQgcHJvcGVybHkg
cHJlZml4IHRoZSBmaXJzdCB0d28gcGF0Y2hlcy4gSSBndWVzcyBpdCdzIHNvbWV0aGluZyBsaWtl
DQo+ICJkdC1iaW5kaW5nczogeDg2OiBpb2FwaWM6Ii4NCj4gDQoNClllcywgaSBqdXN0IGNoZWNr
ZWQgdGhlIGdpdCBsb2cgb2YgZGV2aWNldHJlZS5jIGFuZCB1c2VkIHNhbWUgcHJlZml4ZXMgDQpo
ZXJlLiBUaGFua3MgZm9yIGNvcnJlY3RpbmcgaXQuIEkgd2lsbCB1cGRhdGUgaXQuDQoNClJlZ2Fy
ZHMsDQpSYWh1bA0KDQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNo
ZW5rbw0KPiANCj4gDQo+IA0KDQo=

