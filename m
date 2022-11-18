Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC162EE23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiKRHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiKRHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:12:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F4769D7;
        Thu, 17 Nov 2022 23:12:09 -0800 (PST)
X-UUID: 0fdf82e75f9b40ada954fdcb8a308b10-20221118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xYrOvQfAbsB7V3LURRJr1AMUaeeAnet0zmBHBd93aVE=;
        b=YQP+VgzC80M6+BpIt1fhXBBmkYK5AYMLwTs56YTKjxfSM0Ox4FON0UV89OrK22PCmgToqtiZE5HMWLeBUA98GEI9vL1cgTGZcXyq6w/g5e//nqykKJrdYgWjSvl6AV4GBKD1asnCT5+3vJkS6kr2/danAg0htxTaCZyN4rjqaRc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:5966b318-25c9-4b59-ab04-d9ef0c004137,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:456a90db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0fdf82e75f9b40ada954fdcb8a308b10-20221118
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1034871679; Fri, 18 Nov 2022 15:12:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 18 Nov 2022 15:12:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 18 Nov 2022 15:12:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NawoSHytSZk8cNgg/+WxODZCaJRFk69RMQYnIWfRybdRHCujbM8EC4FubbJYurXj8PLfkhYV5hu2zC/5GrfvevMPPhyiHEGsabTmZ70zVgTqtOE+0S5OGClcmvJ/HDvFJojmL/QBBqmlo7v10QB02IAKsZQr/dX1YlWJSxJOWGd3B93VmeaGp2msDCFlKicvYxzOxrwtRJ9mV3Yog30EmFe4ho3i1GoTWcWG9UuFkJnCwFnYfSKyAThzL9uzyhO+9pg8HbjqAKF7ZnSFrV8tvQ24ACqZXWpM6FZQqNQpfzLDGD+hQ7ZJlulDf8BS8y+Vl2wlyqymWnMAN9SKDvZPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYrOvQfAbsB7V3LURRJr1AMUaeeAnet0zmBHBd93aVE=;
 b=bqUHfXnpu5Ej4agj5N4yU+PqjKgal8JY0Rkas8n/baOZcrc55UwkfF+wJQ2X9RlBdaMz+7TnrqhF1J1gekbAXoD2lxgewN8/4hdSMPkc/CTJPXVLPTnFESOiRJqjYbLtP0z9m32ajQJ9YU8kYFT/miMrJtae3S9/Nes/AVL6F93k40jDpFpi9N8IijUENCa3qz7zdF5nwJv+qMqmRsu9//Jim2KZ2w3UCMLPrBuOQSdt2go2aPhtMUmT55kEuFhHrUOe0Pb2jZcyZaTO1adO2W4y+2nIeYj/LbuHAk08M6IjFxIl6ajMrN5y6WV6A+tOpRTzAn3WdVbuB7IeBq+TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYrOvQfAbsB7V3LURRJr1AMUaeeAnet0zmBHBd93aVE=;
 b=wT2gJopQO4IMFQLPdOu1jRm94y7b5PIBWpQmDyKqPM/kyp8/q1789eL4mMQNFME4+H1E7DGCJpo0FEcNTBgrk/LUXyxo9K9oSPZKL6Peqv+X3jGceWwDCVCm+zZg7E+anv4usHgcHjJCQV5HkVG0bQDQwyXtSGGtIX9shWJFqCM=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by TYZPR03MB7129.apcprd03.prod.outlook.com (2603:1096:400:333::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 07:12:01 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e%8]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 07:12:01 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Add vcodec lat and core nodes for mt8192
Thread-Topic: [PATCH v4 0/2] Add vcodec lat and core nodes for mt8192
Thread-Index: AQHY1L71KjSu+NJkuk+Q0FMYd6Y7f65EkJwA
Date:   Fri, 18 Nov 2022 07:12:01 +0000
Message-ID: <e38634f17d508e46f3c264cad7be79d38d782b25.camel@mediatek.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|TYZPR03MB7129:EE_
x-ms-office365-filtering-correlation-id: 208e7e6a-65c8-4b48-b2cf-08dac9343085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTVJTJfqBwt1aHx9PD8Gwm6k2ZqgIOvgF4I0jDvoW2IABaLhPmg/EZlPkojxTVFY9H6muDgP/cSM54ius3E+AaZuHbr3Q/gf9v3xHDWVf2YABDE3ovFHdGM1DDagjtLF0pbwnUNiUscvzydR34gosk8CTgw/nDbXNjM2N2h8s8WGk8yXGMTFHT/tXEwBhgnX1b3mbbqom2wpsQZGXcXnbzWbRWavCCohYXGc7WwbqCuOwCCuJYHLMjYLqP+OXiWrOLqcJQsRzz4eohVQRzvHSJL/QUDai5y1cxFbPvk8GaffaPcbthlGMmUTDEB6ip5ugHKimqHnNc3dxxyod6PX9NMVCWeZuFB/lEF+J+MUsmn5CiH/yq1gBtEjrhHMPv1xKK7Ue8no497EFvXiJdyVfm8oFPs7KYjV54LXCQG2Rd0LSZiDNT3g5kEuVOfAF4Vz1rqECnbDgPu6o9jloGD6i6RSJqVJmcYmWMei2RJb+Sa4VSH8cc4Lt/ob2PdyDolbx7KAUEndlJIpq5NIB01MVlmFkyXKh6WENhesliewu6M7pM2dPxpZG82PzdvcEmr/09zNRztT3g3+ggD4uZNsVOwW46THxvYq2Kbi/cIi3PgiCOtS0puBZglG4XGhNh5PZrU69owena/eLBGxHXd3G0h2tlNyIiPZG3ILlOme0oVbxL+8gO3H1IJiKULmRCXBEGftrqtEUjlkiHuPPeEBXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(83380400001)(6512007)(110136005)(6506007)(26005)(6486002)(86362001)(85182001)(36756003)(38070700005)(8936002)(38100700002)(186003)(66946007)(2616005)(122000001)(41300700001)(71200400001)(66476007)(4326008)(66556008)(478600001)(4744005)(76116006)(66446008)(8676002)(5660300002)(316002)(2906002)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2s5cG01Zm55bDcwUlROZVEyZWVGZ2ZseGdrTWlIODBHRkloa3hPRmRLUHJV?=
 =?utf-8?B?VDF0SFJQQXE5SnlxTWYxekJzY1p4WjBrdGNabkpJTndGQVhaVUJTMlhXV1Vy?=
 =?utf-8?B?Q2lxak5SMlJPd0QzbmNkb1F6OFJ5a0lnUys1RHFudThDYUZUa2d0a1lyVytB?=
 =?utf-8?B?VHYrSGZhTmlIRG9wMnhaOStNOFBWdWdzSjE5cFh4b2lmSG9seEJ2YWRlaUpL?=
 =?utf-8?B?WkpnVHRJVVIzbkNtbzQ0UHRnSmEzTzRlZXpPa3IzMUJjSjYwOW96eWZXU1Q4?=
 =?utf-8?B?aEQxZWR4OVA1c0QvK2M2UDMvSVh6WXdPKzczY0NqdWxUWVZGZjZYMFd2SCtC?=
 =?utf-8?B?cmhsVXc5TThQelY3eXJOUDlhWitTUEtBR0VZaDU0Sm1mMjV2amNqbStCNmpl?=
 =?utf-8?B?dWo2WEpjOFNwZ3BwNUpHQUlJVmEzRnY0azhXMmNKVEZWVGNxTWFNTUd6WHNu?=
 =?utf-8?B?b0N5VzFvdzVpRjNKVktvV0ZUekpoSGJXMjZ1b3lxOGUxMXRmVmdmTU9HUzl5?=
 =?utf-8?B?SnZmZHlYekZsRnkwaTI2YmdmaWNDRmFyUEpDNEwvMlpOK0t5S21mdFdUUlJR?=
 =?utf-8?B?SlVLaFRlSU5FdzVLQTdMdm9vVUtuczJvL1VJWlhUcUNnYjlzdXB2bVZJUitx?=
 =?utf-8?B?SVhNSjdvVzkyNy9DMWpDMlZPdm5lYk9UVlowUzlsc2pJR0VRYkhWcEhPSFdi?=
 =?utf-8?B?UkFNYTJIeWo4YjZiTE5HMW1KbDg3YVpZZW9FQmJuVEVFS0grOVFCTUxsc1Nk?=
 =?utf-8?B?SVNtaHYyL0NQMXorUmlveXFuREhSYWdlNks0cCtnd3BuWjR4Qy8xdzJMSTlI?=
 =?utf-8?B?OHlwVzJPZzdaRjNoK1RBQzY1OEdzTkxKODRhVTRId0VVUUthODFtMkgycGsw?=
 =?utf-8?B?WXViSDJJMXVrYit5ZU5QbGhrRm5tQlhiTS9iQ1NuMWhxZzFQV3J4ZTRSU3pC?=
 =?utf-8?B?TzY2R1Y0ejBlUnlITHovU0pJZ250WkQrNFE2a1kyTFpieGRiVlZNVjhXU1My?=
 =?utf-8?B?YVNsenpKZGdzdllFdURWdGRoZXhmY0RJZlV3U3ZSQ2pqTW8yYi95Tlo1cEh3?=
 =?utf-8?B?Z3A0OHR1ek1KSmFENFRYU2tXVW4zNUZWWDlySHdadEtUdkNaajd0RGRQRTNV?=
 =?utf-8?B?L2NsZlcwcmZqR1FzN2pJTHZsamtkS1Uyc2NGVVlVMStmcEJXRXhPajdHaitO?=
 =?utf-8?B?S2d1QURzZnRQQ1lKQkZuS0FKQy9XT0RrSzNGaGFIbU1uMGR3VmdxUkRyN1VV?=
 =?utf-8?B?dDFiM1VCZzFZQTlVbVo3Ni9lZXJFdE5BNXZYck5KZUFpcmhnN2JnV0RNQ0RX?=
 =?utf-8?B?b1lkWFNGR0tkMndzRjRia0FTVGhEVng2RzdxK1o4bEh2dm5WbWUrYlg0Zkdr?=
 =?utf-8?B?bTdTVXRmNWFmSmxPL1ZNT1o1cWJ5QlpWQnAvWWRqSDM4R1h0RUtIc3ltZ21R?=
 =?utf-8?B?b2xKMFh6eGdJd09kN2Y0R2lHaTVVclIvVEs3eERxaXJHVjl2WWVmUk12WkFS?=
 =?utf-8?B?MElqdlNGb1kvOFVTK3c2RTRlRHhNbnBvWXpOVWM4L2hNQmIxa08rWnVsNGRL?=
 =?utf-8?B?YUU1Y1Z5UU9ZV3RNaXUwSkZraXN1aFNHYnMvaloxYi9mcVJNNGdhME1DcGkw?=
 =?utf-8?B?NWt5QThMSzl5VmJOUjg2d0NZZWlqU2VFTHA3aXhxbGtxcENlY3gzSC9mNkk0?=
 =?utf-8?B?V3grRjZBRm5VWVVLcDFCVDJicS9wMVhYc0dkcmtGN29lUVlzZEhNSmJKN3k5?=
 =?utf-8?B?VHJuSnhaSVdkek5LdGhIWlJxdGlTdFZROXpCdkpMQ25EVlN4N0luSjJSMUlD?=
 =?utf-8?B?RS9UZHRNN1JCbjNsclU3KzlHVFNobHEwSVJGQUlpeVNMU0t3cnlHOEg0Wmx0?=
 =?utf-8?B?TjNUem5zOGhuamVIY1JENFczWGJCeWN4eWJYWTVLSTQ2bjRZYmx1cDVYRHJ2?=
 =?utf-8?B?cmJUZUl6VjJhelJuVnFsVGtxZkxsNHREZWJZdDZBeVQvRXJ0NlZPM01jR3gr?=
 =?utf-8?B?N0Q0cWNEbHMvTEN2ZnpCczZHbGovTDhMZ2dwMXlsRzVlcFJSaitvVVdHTzll?=
 =?utf-8?B?MEY2a0p5em1nWmc4a3JwNTVQeW9pdXlvbmx2V0JhWGZrN3J0WUppNnF1QjEx?=
 =?utf-8?B?SndiZ1VieEVlK0hOd0JlOFJWNTZyRnVOdXFxVWJIMWdCL0dzeU82SnlMQ1Zz?=
 =?utf-8?Q?uzSRjTDpkhom5XpHC+rq9Tc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C425A03C0A4884B995C393E66E173D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208e7e6a-65c8-4b48-b2cf-08dac9343085
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 07:12:01.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mkor6yZ2+daCFSyxzR/19ZEEkA/j/LRiJMn8aFtblrkPSDoY8Lfzy925JdFJafHDZ/OwmPfjGbn9A4Ffx00jwbimnMFBqFEpbYQzbKCP4qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlzIHNlcmllcy4NCg0KRG9lcyB0aGlz
IHNlcmllcyBsb29rIGdvb2QgdG8geW91Pw0KDQpUaGFua3MsDQpBbGxlbg0KDQpPbiBGcmksIDIw
MjItMDktMzAgYXQgMTk6MjIgKzA4MDAsIEFsbGVuLUtIIENoZW5nIHdyb3RlOg0KPiBUaGlzIHNl
cmllcyBpcyBiYXNlZCBvbiBsaW51eC1uZXh0LCB0YWc6IG5leHQtMjAyMjA5MjkuDQo+IA0KPiBD
aGFuZ2UgaW4gdjM6DQo+ICAgLSBEcm9wIGB2Y29kZWNfbGF0OmAgYW5kIGB2Y29kZWNfY29yZTpg
DQo+IA0KPiBDaGFuZ2UgaW4gdjI6DQo+ICAgLSBBZGQgYSBkdC1iaW5kaW5ncyBwYXRjaCBmb3Ig
Y2hhbmdpbmcgInZjb2RlYyIgdG8gInZpZGVvLWNvZGVjIg0KPiAgIC0gUmVuYW1lIGNoaWxkIG5h
bWVzIGZvciB2Y29kZWMgbGF0IGFuZCBjb3JlIG5vZGVzDQo+IA0KPiBDaGFuZ2UgaW4gdjE6DQo+
ICAgLSBSZXBsYWNlIG5vZGUgbmFtZXMgd2l0aCB2aWRlby1jb2RlYw0KPiAgICAgW0FsbGVuLUtI
IENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRpYXRlay5jb20+XQ0KPiANCj4gQWxsZW4tS0ggQ2hl
bmcgKDIpOg0KPiAgIG1lZGlhOiBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IFJlbmFtZSBjaGlsZCBu
b2RlIG5hbWVzIGZvciBkZWNvZGVyDQo+ICAgYXJtNjQ6IGR0czogbXQ4MTkyOiBBZGQgdmNvZGVj
IGxhdCBhbmQgY29yZSBub2Rlcw0KPiANCj4gIC4uLi9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3Vi
ZGV2LWRlY29kZXIueWFtbCB8ICA4ICstLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaSAgICAgIHwgNjANCj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg==
