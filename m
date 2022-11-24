Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7929E637422
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKXIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKXIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:37:09 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C67E0DC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669278968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBS6L1X0VnV0UEEtIcHQ8/V9UarXrUihMOhQaFMragU=;
        b=FAvut7zcdZvkNDKmrdSNMcZ0XBHVvQ26nx2PCUoIW2ax0tnhPnP+j9L6ggPW+hpA7NYq+M
        6mbYxnJZRtU9SdtvtrS/+QW7fUkLPOG5k7e/KagkT7Htidi4GXDFbGqnvBnqzg+rylkWP0
        rjLbm03reZzrsEyM4VENE9f7jda2xvZsOfJfaJP2kvyNZdiC+tQjbxseyliOhif/sZitO1
        XkP1ooDVEs43YlU8cAKH1Y84wG+RTMj2Yzbbz8xt8Wa8BhB1QoOT2fwsbTYBIYrISbgTho
        MoUMAQExC8jMpMraeZQSAAzNk2Dghu8+Xvl9bl/DjthIN1fykXWyHSp24TNVYw==
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-D-7uLQ7TPeGxDqPXQkmjGw-1; Thu, 24 Nov 2022 03:36:06 -0500
X-MC-Unique: D-7uLQ7TPeGxDqPXQkmjGw-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6121.namprd19.prod.outlook.com (2603:10b6:8:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 08:36:03 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 08:36:03 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: x86: apic: Convert Intel's APIC
 bindings to YAML schema
Thread-Topic: [PATCH v4 1/4] dt-bindings: x86: apic: Convert Intel's APIC
 bindings to YAML schema
Thread-Index: AQHY/yOgCJGZfD6tmUuVws657kjATK5NBlKAgAC69IA=
Date:   Thu, 24 Nov 2022 08:36:03 +0000
Message-ID: <17b6cd23-6098-055b-0de1-922ad015d98b@maxlinear.com>
References: <20221123100850.22969-1-rtanwar@maxlinear.com>
 <20221123100850.22969-2-rtanwar@maxlinear.com>
 <20221123212651.GA2519263-robh@kernel.org>
In-Reply-To: <20221123212651.GA2519263-robh@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6121:EE_
x-ms-office365-filtering-correlation-id: 5fc798ee-258a-4d29-56bc-08dacdf6ec0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: FZ/jPEt7D+gCf4KAEqOkmxzGS3FkpdkkTotKugjzWSvO6SVgIpG0KYFa6vnUDTQ7lgOZwyQpo7Q0jerd23OtjErvAXP/R//Bipbk2vVOFu1KyA81o2pTR2LNI27u6ESVd9m0Lh6y6G56eAmioohqK4Zt5nE/OPKqtz8Rr0GBPfNRjn7pup5p58QRs+dF2SSKkvtUm61PgQyEfQjp3XbO92VVCXnvLxeIe2R+BobOKwHpipbj3NLb8dPrYL8KfIYxCPIamJjChPEzfXdUQw+Ksf3e+CEqQm7EVJG7lXgum/R+vVckUs5DiFtVsricKLijXipdFl/9b19QYtN9yuxgx9imkNCoIZlrUNMsbKNrqJnUx18HWS5TlyNWKtK7zyGE7xxXiWjY908uK/sSH5w54KIVR+TJJB05PTerle0LF4CzdAD9tB8v/3EOcBeQ5L2xLjBuuXIO70NnzThIv9QtyyYk7b8tCTowRZ67HlIJxqzSQYvfM6ZttY+brPrmMDE9/5i7pHOM+VJtdAHul1/6vRFe7TkP2iSemO2PF3kHSYHUbW31n2XwPuhYktwXsCtXzwCDAWnym3V5E6yWszW2997pJoaO4bPhLqnaKr96hJXTUbpU1Nv2QKKL9U0tsVt6yEs7eVwMwqJ4WFEr0rkkoYvrvtNiNqJm3loQ92Gf0PXA5BDUuxoVZFGkTDExcv7dt5ysPOcY2PJ+Ax4Hpx3IqYG4ZnhTxUxdZ6vG6rAM/lIRtnmZ9J7gFmkiodcH1amOdT80XliFNaGUWqEvDpVaWh310G1KR7w5IkrVHxMSr74r7TOWI9UrHIKTyi+Uhi7qs5b+4nZ8kHRSLTgnVpOlmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199015)(6486002)(6506007)(6512007)(2616005)(26005)(36756003)(122000001)(2906002)(478600001)(53546011)(71200400001)(31696002)(86362001)(83380400001)(966005)(38100700002)(38070700005)(186003)(7416002)(8936002)(31686004)(66446008)(41300700001)(8676002)(66946007)(66556008)(91956017)(76116006)(64756008)(66476007)(4326008)(5660300002)(54906003)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU5OUElGeDRray9DaGJyYnNHQmZtak9VT1FGRHV6dXlvUnFYOHd4VkR1K3dq?=
 =?utf-8?B?dDd1aGU2NjIyc1Q1d0pzbHdxeHh6emVZOWR6SXVsVVRWbHBzSFlFeUxrckVi?=
 =?utf-8?B?ZDhpaDhNTG85RWYzUEZGQmJUOTNaejk5cFBxcXRGMWNMemNhZWJpbzUzQ2hj?=
 =?utf-8?B?SVNaTTJwRHZ0Nmd1MjI0U3ZtVE5mRWZZMExyVWNZYTM5bjVmR09hMVZxWFFu?=
 =?utf-8?B?ZnF6bExKK3hKUFNJbTBGUkkzblJCYldzcEdScGNPTFpIVHkzbm5SVk4xQW1m?=
 =?utf-8?B?UU80ckJSbko0NDRBRGwvNDQreG1LSjR4MGtvQmlZOU1QZGErWG5taDMrV3pK?=
 =?utf-8?B?a2tIUW9JU2MwMFk3Q3VaalJ6d2ZsTXBSenc0d1FNUGlOQm5rR2JuTWU4Yk1Z?=
 =?utf-8?B?MjRiUnRCdThMdHNvMTRHQ0hSWVhlUnVKQ05xdjNTUDEwU0doanNZajA0M3o0?=
 =?utf-8?B?Z1RIMVkvL0tVL29xWUpDNWtNdzFVZzRiUGtqdTNPSzlpRXRFMm04Y2FoV2Zi?=
 =?utf-8?B?RUNXRU1uMmZuT1ViSVUrbG9IVFR4Mm01bytSbVM1dVY0UFZNTjlScTJXdHFT?=
 =?utf-8?B?V3R3YjdLSk05RU45cDlwV0I1VWE5Z1g1VmZCcFRIemhXUWlRVGNSVDB6Vml3?=
 =?utf-8?B?alJEWjFvbS9idWtkU3hmcG1uWHhaa1QvazgxSHc2aUVxdjUyS1k0OHBXL0tO?=
 =?utf-8?B?eWdUNjl3c1dBRGU1dDk2R0tMVFJoVFN6SVc5ZzFDZElzbW1uZDZRSG5UZmI1?=
 =?utf-8?B?R1IxN01yN1BEcW93cjBERTBnWmp3MEFDZkVpTzczMG1SaXNDZWlUd0ZuMmgx?=
 =?utf-8?B?RTZhVWlsRGM4UERXdy9QcmluNWFuZmVranczb01zMVUybE9rbFhWN1lLMFBv?=
 =?utf-8?B?WU0yUi9vTUJmdE5jYXg4Sk5Jam9nQ1FxMzBELzByczdTVUpxTGg3bFRIUlRV?=
 =?utf-8?B?RGQrc1UrbkNqcklyK2UxVmhYSEdqc1hUVGNVOG5kRzVsaWw5bVVOdHQ2U3Jv?=
 =?utf-8?B?Q3FUZ2JFT1BKbzFTRjh1VDVnNVNEdXlmaWN4blFpR05jcVB3ZW9SdTB3QmJD?=
 =?utf-8?B?TlBiUEduNEI2M1pKcDZOYTVYOUxaTXk2TkZWK2Z2R203djZYc05lTFVMRFVw?=
 =?utf-8?B?WmtyUDFubmZCWEtLclhCQThicVFpTWEwZFZieERhRUZ2OGo3bHNDOGdUNUhX?=
 =?utf-8?B?MUw4QkhwYmpWUFZvSTlGTmZra3NLYng3cWdsYXZkRWNQRTZxVGFGOFBORE5j?=
 =?utf-8?B?dHNBaHpHN042N1NUZldya0JHVDdaQ0x2cDRlQlBuVU41ZW1qdUZFQ1Jwa0pU?=
 =?utf-8?B?SGwzSW1YZk1oOXdJWGNDbzJpRnArOHpUK3hKYlAzdmZjSEpWZ3Rsc3U5Vnh1?=
 =?utf-8?B?cTJmUDVDK1hkQ3Era2VYREE4dm9PSEJMK2wycE5pdUxFSEtJdmh6THZWcThz?=
 =?utf-8?B?KzNPRnJWRkZ4OTI1SjZvNzhMNHlHbVRPQXRzYkprNjl2TktFYmZrVkM2aW5s?=
 =?utf-8?B?Ty9xZERvMVJPNE1KdUdQaExoekV2aWxEZm5zSHAyM2ZvWWZRYU5VdVpHampT?=
 =?utf-8?B?RGVaRzVhTFA3NmpYeUM4ZWQ5MExGUkJ5eTZzUVI2cTdpeEs3WUk4NFZHQldl?=
 =?utf-8?B?YVhvaCtVMmREbWREcStnSEhYaTVCOXZJVDRBN3lYWnJwYlRGaWhZQ3QwNXhW?=
 =?utf-8?B?MGZxZXo5YUR3bUhSQm81dUFkSXljc0pLdXYyT2tDUVVCVkVHbHZpczJIU2w5?=
 =?utf-8?B?d25wbDJYYlN6RWtaTklYdmE1OW5tSklmaVR4LzNuMTM5NHhEalcrbFo4SzdU?=
 =?utf-8?B?MUJWbFVFNGxKUFBpSXI5ZGduUzNNb1NOaUlqNW00azBmVUk2SVFNQXBTaXNY?=
 =?utf-8?B?SkFNUE1Sb0hWMnZRdGdGZ2kyZXphOXg5ZXFpMVpha1V5OWJCbjJIY0RXdGZl?=
 =?utf-8?B?cnJodmIvYWJzQlY5WDJZYmhSbE9JQ2xNSVJzQmVvNVF1aThPL3p5MGd6amNS?=
 =?utf-8?B?elZVZWJ2UzU0cmRjZnJmNWRHalNGck85c0k2aHc2M2QrOHpCazlhblJNTUJ5?=
 =?utf-8?B?NTQ3UmJuUkRYbUl4Q2RRMk91NG9GZWxuS1NpSTFXVFo2djNMcnFicVFSVC9a?=
 =?utf-8?B?cGJrTW4ydHlnUXE1ZEw5QjhLaWJ3SUtDS2E1aW01US94M0x0NlNQK1B4QStL?=
 =?utf-8?B?VkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc798ee-258a-4d29-56bc-08dacdf6ec0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 08:36:03.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVG0xVizewth4gS7bH6ExVzl+arCYNcxejI4UYOlWfFWFOyEgmeeuvJnyrqDRckBkrpCSOpxqy9E+Lf99eoc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6121
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <B380832F3A19914BA1A040B5689E953C@namprd19.prod.outlook.com>
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

T24gMjQvMTEvMjAyMiA1OjI4IGFtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gVGhpcyBlbWFpbCB3
YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgTWF4TGluZWFyLg0KPiANCj4gT24gV2VkLCBOb3YgMjMs
IDIwMjIgYXQgMDY6MDg6NDdQTSArMDgwMCwgUmFodWwgVGFud2FyIHdyb3RlOg0KPiAgPiBJbnRl
bCdzIEFQSUMgZmFtaWx5IG9mIGludGVycnVwdCBjb250cm9sbGVycyBzdXBwb3J0IGxvY2FsIEFQ
SUMNCj4gID4gKGxhcGljKSAmIEkvTyBBUElDIChpb2FwaWMpLiBDb252ZXJ0IGV4aXN0aW5nIGJp
bmRpbmdzIGZvciBsYXBpYw0KPiAgPiAmIGlvYXBpYyBmcm9tIHRleHQgdG8gWUFNTCBzY2hlbWEu
IFNlcGFyYXRlIGxhcGljICYgaW9hcGljIHNjaGVtYXMuDQo+ICA+IEFkZGRpdGlvbmFsbHksIGFk
ZCBkZXNjcmlwdGlvbiB3aGljaCB3YXMgbWlzc2luZyBpbiB0ZXh0IGZpbGUgYW5kDQo+ICA+IGFk
ZCBmZXcgbW9yZSByZXF1aXJlZCBzdGFuZGFyZCBwcm9wZXJ0aWVzIHdoaWNoIHdlcmUgYWxzbyBt
aXNzaW5nDQo+ICA+IGluIHRleHQgZmlsZS4NCj4gID4NCj4gID4gU3VnZ2VzdGVkLWJ5OiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gID4gU2ln
bmVkLW9mZi1ieTogUmFodWwgVGFud2FyIDxydGFud2FyQG1heGxpbmVhci5jb20+DQo+ICA+IC0t
LQ0KPiAgPiAuLi4vaW50ZWwsY2U0MTAwLWlvYXBpYy50eHQgfCAyNiAtLS0tLS0tLQ0KPiAgPiAu
Li4vaW50ZWwsY2U0MTAwLWlvYXBpYy55YW1sIHwgNjIgKysrKysrKysrKysrKysrKysrKw0KPiAg
PiAuLi4vaW50ZWwsY2U0MTAwLWxhcGljLnlhbWwgfCA0OSArKysrKysrKysrKysrKysNCj4gID4g
MyBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+ICA+
IGRlbGV0ZSBtb2RlIDEwMDY0NCANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2ludGVsLGNlNDEwMC1pb2FwaWMudHh0DQo+ICA+IGNyZWF0
ZSBtb2RlIDEwMDY0NCANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVy
cnVwdC1jb250cm9sbGVyL2ludGVsLGNlNDEwMC1pb2FwaWMueWFtbA0KPiAgPiBjcmVhdGUgbW9k
ZSAxMDA2NDQgDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQt
Y29udHJvbGxlci9pbnRlbCxjZTQxMDAtbGFwaWMueWFtbA0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0
IA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9pbnRlbCxjZTQxMDAtaW9hcGljLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlbCxjZTQxMDAtaW9hcGljLnR4dA0KPiAg
PiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gID4gaW5kZXggN2QxOWY0OTRmMTlhLi4wMDAw
MDAwMDAwMDANCj4gID4gLS0tIA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlbCxjZTQxMDAtaW9hcGljLnR4dA0KPiAgPiArKysg
L2Rldi9udWxsDQo+ICA+IEBAIC0xLDI2ICswLDAgQEANCj4gID4gLUludGVycnVwdCBjaGlwcw0K
PiAgPiAtLS0tLS0tLS0tLS0tLS0tDQo+ICA+IC0NCj4gID4gLSogSW50ZWwgSS9PIEFkdmFuY2Vk
IFByb2dyYW1tYWJsZSBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSU8gQVBJQykNCj4gID4gLQ0KPiAg
PiAtIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICA+IC0gLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
ID4gLSBjb21wYXRpYmxlID0gImludGVsLGNlNDEwMC1pb2FwaWMiOw0KPiAgPiAtICNpbnRlcnJ1
cHQtY2VsbHMgPSA8Mj47DQo+ICA+IC0NCj4gID4gLSBEZXZpY2UncyBpbnRlcnJ1cHQgcHJvcGVy
dHk6DQo+ICA+IC0NCj4gID4gLSBpbnRlcnJ1cHRzID0gPFAgUz47DQo+ICA+IC0NCj4gID4gLSBU
aGUgZmlyc3QgbnVtYmVyIChQKSByZXByZXNlbnRzIHRoZSBpbnRlcnJ1cHQgcGluIHdoaWNoIGlz
IHdpcmVkIHRvIHRoZQ0KPiAgPiAtIElPIEFQSUMuIFRoZSBzZWNvbmQgbnVtYmVyIChTKSByZXBy
ZXNlbnRzIHRoZSBzZW5zZSBvZiBpbnRlcnJ1cHQgd2hpY2gNCj4gID4gLSBzaG91bGQgYmUgY29u
ZmlndXJlZCBhbmQgY2FuIGJlIG9uZSBvZjoNCj4gID4gLSAwIC0gRWRnZSBSaXNpbmcNCj4gID4g
LSAxIC0gTGV2ZWwgTG93DQo+ICA+IC0gMiAtIExldmVsIEhpZ2gNCj4gID4gLSAzIC0gRWRnZSBG
YWxsaW5nDQo+ICA+IC0NCj4gID4gLSogTG9jYWwgQVBJQw0KPiAgPiAtIFJlcXVpcmVkIHByb3Bl
cnR5Og0KPiAgPiAtDQo+ICA+IC0gY29tcGF0aWJsZSA9ICJpbnRlbCxjZTQxMDAtbGFwaWMiOw0K
PiAgPiBkaWZmIC0tZ2l0IA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pbnRlbCxjZTQxMDAtaW9hcGljLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZWwsY2U0MTAw
LWlvYXBpYy55YW1sDQo+ICA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ICA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uMjVkNTQ5MjIwYzJhDQo+ICA+IC0tLSAvZGV2L251bGwNCj4gID4gKysrIA0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9p
bnRlbCxjZTQxMDAtaW9hcGljLnlhbWwNCj4gID4gQEAgLTAsMCArMSw2MiBAQA0KPiAgPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiAgPiAr
JVlBTUwgMS4yDQo+ICA+ICstLS0NCj4gID4gKyRpZDogDQo+ICJodHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlbCxjZTQxMDAtaW9hcGljLnlhbWwj
IDxodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRl
bCxjZTQxMDAtaW9hcGljLnlhbWwjPiINCj4gID4gKyRzY2hlbWE6ICJodHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMgDQo+IDxodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCM+Ig0KPiAgPiArDQo+ICA+ICt0aXRsZTogSW50ZWwgSS9P
IEFkdmFuY2VkIFByb2dyYW1tYWJsZSBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSU8gQVBJQykNCj4g
ID4gKw0KPiAgPiArbWFpbnRhaW5lcnM6DQo+ICA+ICsgLSBSYWh1bCBUYW53YXIgPHJ0YW53YXJA
bWF4bGluZWFyLmNvbT4NCj4gID4gKw0KPiAgPiArDQo+IA0KPiBPbmUgYmxhbmsgbGluZS4NCg0K
V2VsbCBub3RlZC4NCg0KPiANCj4gID4gK2Rlc2NyaXB0aW9uOiB8DQo+ICA+ICsgSW50ZWwncyBB
ZHZhbmNlZCBQcm9ncmFtbWFibGUgSW50ZXJydXB0IENvbnRyb2xsZXIgKEFQSUMpIGlzIGENCj4g
ID4gKyBmYW1pbHkgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXJzLiBUaGUgQVBJQyBpcyBhIHNwbGl0
DQo+ICA+ICsgYXJjaGl0ZWN0dXJlIGRlc2lnbiwgd2l0aCBhIGxvY2FsIGNvbXBvbmVudCAoTEFQ
SUMpIGludGVncmF0ZWQNCj4gID4gKyBpbnRvIHRoZSBwcm9jZXNzb3IgaXRzZWxmIGFuZCBhbiBl
eHRlcm5hbCBJL08gQVBJQy4gTG9jYWwgQVBJQw0KPiAgPiArIChsYXBpYykgcmVjZWl2ZXMgaW50
ZXJydXB0cyBmcm9tIHRoZSBwcm9jZXNzb3IncyBpbnRlcnJ1cHQgcGlucywNCj4gID4gKyBmcm9t
IGludGVybmFsIHNvdXJjZXMgYW5kIGZyb20gYW4gZXh0ZXJuYWwgSS9PIEFQSUMgKGlvYXBpYyku
DQo+ICA+ICsgQW5kIGl0IHNlbmRzIHRoZXNlIHRvIHRoZSBwcm9jZXNzb3IgY29yZSBmb3IgaGFu
ZGxpbmcuDQo+ICA+ICsgU2VlIFsxXSBDaGFwdGVyIDggZm9yIG1vcmUgZGV0YWlscy4NCj4gID4g
Kw0KPiAgPiArIE1hbnkgb2YgdGhlIEludGVsJ3MgZ2VuZXJpYyBkZXZpY2VzIGxpa2UgaHBldCwg
aW9hcGljLCBsYXBpYyBoYXZlDQo+ICA+ICsgdGhlIGNlNDEwMCBuYW1lIGluIHRoZWlyIGNvbXBh
dGlibGUgcHJvcGVydHkgbmFtZXMgYmVjYXVzZSB0aGV5DQo+ICA+ICsgZmlyc3QgYXBwZWFyZWQg
aW4gQ0U0MTAwIFNvQy4NCj4gID4gKw0KPiAgPiArIFRoaXMgc2NoZW1hIGRlZmluZXMgYmluZGlu
Z3MgZm9yIEkvTyBBUElDIGludGVycnVwdCBjb250cm9sbGVyLg0KPiAgPiArDQo+ICA+ICsgWzFd
IGh0dHBzOi8vcGRvcy5jc2FpbC5taXQuZWR1LzYuODI4LzIwMDgvcmVhZGluZ3MvaWEzMi9JQTMy
LTNBLnBkZiANCj4gPGh0dHBzOi8vcGRvcy5jc2FpbC5taXQuZWR1LzYuODI4LzIwMDgvcmVhZGlu
Z3MvaWEzMi9JQTMyLTNBLnBkZj4NCj4gID4gKw0KPiAgPiArcHJvcGVydGllczoNCj4gID4gKyBj
b21wYXRpYmxlOg0KPiAgPiArIGNvbnN0OiBpbnRlbCxjZTQxMDAtaW9hcGljDQo+ICA+ICsNCj4g
ID4gKyByZWc6DQo+ICA+ICsgbWF4SXRlbXM6IDENCj4gID4gKw0KPiAgPiArIGludGVycnVwdC1j
b250cm9sbGVyOiB0cnVlDQo+ICA+ICsNCj4gID4gKyAnI2ludGVycnVwdC1jZWxscyc6DQo+ICA+
ICsgY29uc3Q6IDINCj4gID4gKw0KPiAgPiArIGludGVycnVwdHM6DQo+ICA+ICsgbWF4SXRlbXM6
IDENCj4gID4gKw0KPiAgPiArcmVxdWlyZWQ6DQo+ICA+ICsgLSBjb21wYXRpYmxlDQo+ICA+ICsg
LSByZWcNCj4gID4gKyAtIGludGVycnVwdC1jb250cm9sbGVyDQo+ICA+ICsgLSAnI2ludGVycnVw
dC1jZWxscycNCj4gID4gKw0KPiAgPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICA+
ICsNCj4gID4gK2V4YW1wbGVzOg0KPiAgPiArIC0gfA0KPiAgPiArIGlvYXBpYzE6IGludGVycnVw
dC1jb250cm9sbGVyQGZlYzAwMDAwIHsNCj4gID4gKyBjb21wYXRpYmxlID0gImludGVsLGNlNDEw
MC1pb2FwaWMiOw0KPiAgPiArIHJlZyA9IDwweGZlYzAwMDAwIDB4MTAwMD47DQo+ICA+ICsgI2lu
dGVycnVwdC1jZWxscyA9IDwyPjsNCj4gID4gKyAjYWRkcmVzcy1jZWxscyA9IDwwPjsNCj4gID4g
KyBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gID4gKyB9Ow0KPiAgPiBkaWZmIC0tZ2l0IA0KPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9p
bnRlbCxjZTQxMDAtbGFwaWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlbCxjZTQxMDAtbGFwaWMueWFtbA0KPiAgPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiAgPiBpbmRleCAwMDAwMDAwMDAwMDAuLjg4ZjMyMGVmNDYxNg0K
PiAgPiAtLS0gL2Rldi9udWxsDQo+ICA+ICsrKyANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZWwsY2U0MTAwLWxhcGljLnlhbWwN
Cj4gID4gQEAgLTAsMCArMSw0OSBAQA0KPiAgPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiAgPiArJVlBTUwgMS4yDQo+ICA+ICstLS0NCj4g
ID4gKyRpZDogDQo+ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9pbnRlbCxjZTQxMDAtbGFwaWMueWFtbCMgPGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL2ludGVsLGNlNDEwMC1sYXBpYy55YW1sIz4iDQo+
ICA+ICskc2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjIA0KPiA8aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjPiIN
Cj4gID4gKw0KPiAgPiArdGl0bGU6IEludGVsIExvY2FsIEFkdmFuY2VkIFByb2dyYW1tYWJsZSBJ
bnRlcnJ1cHQgQ29udHJvbGxlciAoTEFQSUMpDQo+ICA+ICsNCj4gID4gK21haW50YWluZXJzOg0K
PiAgPiArIC0gUmFodWwgVGFud2FyIDxydGFud2FyQG1heGxpbmVhci5jb20+DQo+ICA+ICsNCj4g
ID4gKw0KPiAgPiArZGVzY3JpcHRpb246IHwNCj4gID4gKyBJbnRlbCdzIEFkdmFuY2VkIFByb2dy
YW1tYWJsZSBJbnRlcnJ1cHQgQ29udHJvbGxlciAoQVBJQykgaXMgYQ0KPiAgPiArIGZhbWlseSBv
ZiBpbnRlcnJ1cHQgY29udHJvbGxlcnMuIFRoZSBBUElDIGlzIGEgc3BsaXQNCj4gID4gKyBhcmNo
aXRlY3R1cmUgZGVzaWduLCB3aXRoIGEgbG9jYWwgY29tcG9uZW50IChMQVBJQykgaW50ZWdyYXRl
ZA0KPiAgPiArIGludG8gdGhlIHByb2Nlc3NvciBpdHNlbGYgYW5kIGFuIGV4dGVybmFsIEkvTyBB
UElDLiBMb2NhbCBBUElDDQo+ICA+ICsgKGxhcGljKSByZWNlaXZlcyBpbnRlcnJ1cHRzIGZyb20g
dGhlIHByb2Nlc3NvcidzIGludGVycnVwdCBwaW5zLA0KPiAgPiArIGZyb20gaW50ZXJuYWwgc291
cmNlcyBhbmQgZnJvbSBhbiBleHRlcm5hbCBJL08gQVBJQyAoaW9hcGljKS4NCj4gID4gKyBBbmQg
aXQgc2VuZHMgdGhlc2UgdG8gdGhlIHByb2Nlc3NvciBjb3JlIGZvciBoYW5kbGluZy4NCj4gID4g
KyBTZWUgWzFdIENoYXB0ZXIgOCBmb3IgbW9yZSBkZXRhaWxzLg0KPiAgPiArDQo+ICA+ICsgTWFu
eSBvZiB0aGUgSW50ZWwncyBnZW5lcmljIGRldmljZXMgbGlrZSBocGV0LCBpb2FwaWMsIGxhcGlj
IGhhdmUNCj4gID4gKyB0aGUgY2U0MTAwIG5hbWUgaW4gdGhlaXIgY29tcGF0aWJsZSBwcm9wZXJ0
eSBuYW1lcyBiZWNhdXNlIHRoZXkNCj4gID4gKyBmaXJzdCBhcHBlYXJlZCBpbiBDRTQxMDAgU29D
Lg0KPiAgPiArDQo+ICA+ICsgVGhpcyBzY2hlbWEgZGVmaW5lcyBiaW5kaW5ncyBmb3IgbG9jYWwg
QVBJQyBpbnRlcnJ1cHQgY29udHJvbGxlci4NCj4gID4gKw0KPiAgPiArIFsxXSBodHRwczovL3Bk
b3MuY3NhaWwubWl0LmVkdS82LjgyOC8yMDA4L3JlYWRpbmdzL2lhMzIvSUEzMi0zQS5wZGYgDQo+
IDxodHRwczovL3Bkb3MuY3NhaWwubWl0LmVkdS82LjgyOC8yMDA4L3JlYWRpbmdzL2lhMzIvSUEz
Mi0zQS5wZGY+DQo+ICA+ICsNCj4gID4gK3Byb3BlcnRpZXM6DQo+ICA+ICsgY29tcGF0aWJsZToN
Cj4gID4gKyBjb25zdDogaW50ZWwsY2U0MTAwLWxhcGljDQo+ICA+ICsNCj4gID4gKyByZWc6DQo+
ICA+ICsgbWF4SXRlbXM6IDENCj4gID4gKw0KPiAgPiArcmVxdWlyZWQ6DQo+ICA+ICsgLSBjb21w
YXRpYmxlDQo+ICA+ICsgLSByZWcNCj4gID4gKw0KPiAgPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ICA+ICsNCj4gID4gK2V4YW1wbGVzOg0KPiAgPiArIC0gfA0KPiAgPiArIGxhcGlj
MDogaW50ZXJydXB0LWNvbnRyb2xsZXJAZmVlMDAwMDAgew0KPiAgPiArIGNvbXBhdGlibGUgPSAi
aW50ZWwsY2U0MTAwLWxhcGljIjsNCj4gID4gKyByZWcgPSA8MHhmZWUwMDAwMCAweDEwMDA+Ow0K
PiANCj4gV2hhdCBhYm91dCBpbnRlcnJ1cHQtY29udHJvbGxlciBhbmQgI2ludGVycnVwdC1jZWxs
cyBwcm9wZXJ0aWVzPw0KDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBZZXMsIGludGVy
cnVwdC1jb250cm9sbGVyICYgI2ludGVycnVwdC1jZWxscyANCnByb3BlcnRpZXMgcmlnaHRmdWxs
eSBiZWxvbmcgaGVyZS4gV2lsbCB1cGRhdGUgaW4gdjUuIFRoYW5rcy4NCg0KUmVnYXJkcywNClJh
aHVsDQoNCg0KPiANCj4gID4gKyB9Ow0KPiAgPiAtLQ0KPiAgPiAyLjE3LjENCj4gID4NCj4gID4N
Cg0K

