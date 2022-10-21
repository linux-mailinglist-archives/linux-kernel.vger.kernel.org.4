Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77911606E11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJUCzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJUCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:55:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6E2DCE;
        Thu, 20 Oct 2022 19:55:28 -0700 (PDT)
X-UUID: 0d15aed2cdeb4ad5827e590fe3aa655b-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fCkGWWDiN8zwrDgUIHL5hiXqkoR3Pzpa2dy5pThvqhA=;
        b=UPWZcFj2QhkXqZb8ZYyF2Be03YfCWfSwjZf10kemx9vHbcecygsPa5qNYKIHK0IM0JOpUsoW23gEqKKr3D+q0TTENhkSk6aKnHx0S6K45PR6O6wSXIHQibIWSK1YtxzkYDzZTvZxR/A9iE5XXAwS1qz1oNIYkq4A6oUm4SSgF2c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f38fdc13-03f8-424e-ac98-91a92be42c88,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:c5937da4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0d15aed2cdeb4ad5827e590fe3aa655b-20221021
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 629447833; Fri, 21 Oct 2022 10:55:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 10:55:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 10:55:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9mjj2W5KFBgqKwdIivtFi/20thlwBqmvmnshwCjbs3oPl7hG6J4Td1CKD6c/mLjceylxlaISk4vL8XkEw50fLkoiujjMUD2ls1nwd+gNtYhyhv2ttSnM5epngkWR6SRdYKpclWa/nntvx6RKz4FuqqbfRpIoSkMoNqmv/qGfedibsCL5GdVw1gvbOBafxdv73tEfkdP21mlN+fe6E4SCw/xqm2SJiuZ0MgkvQ2sY1CVkimpgqZeqYHT8b3nkeNHq1POHWP7dbrUf2y+xF013Kg9P4/3qK6N30q4oYkH+L3o+PHsp1LqqtcpBBVNXM0qt7J9JPHWtv5WNkCIkint9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCkGWWDiN8zwrDgUIHL5hiXqkoR3Pzpa2dy5pThvqhA=;
 b=PvwxCReDRdcL74ubDXMCHVI4exleDkksMWyU7XfWG/xcz1rkMpfAIVRY5LGyscP+zwfADj3GumnAIzB0KNpyY8ne6/EspCL6iJ3FH8kZtyF1FGmg8y6/m4ug9eCzhJkRaWZ7AzZ5ZoNa7+nv1J3xDVMIQpXsVsCSsdrRO5PpALsQ9POXmOHYnWGutlQjREygGcX3wwAOuRJDmFKH4FOiLD99WTEJDNiW3LFf752oUWTqotKSRiu7JugNQe9I7SRQW37klcNB06h+9F0G11A7/9QHdg2MMje+jQRdhdFMG9ncb1HHz9rSfE/Tpl3i2VGUKO1R1dxkuSsFmqx1IKAjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCkGWWDiN8zwrDgUIHL5hiXqkoR3Pzpa2dy5pThvqhA=;
 b=glE0WDGkLmm1kVjmVKx2lb4S1wS4c/s4HQfEy3esu2SO4gN9Xlko9nt0E2da4+JQzNLabKkNaSBV5wyzPSV6fR4S1UNUa731iDpyC71wXhWae/Ciktj5vyVVOjkSmLjFdJW77zwMXkTO4ZGS3vuF9yGRGPA93/KPlJHBe64LfwE=
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com (2603:1096:4:1d4::13)
 by TYZPR03MB5453.apcprd03.prod.outlook.com (2603:1096:400:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.18; Fri, 21 Oct
 2022 02:55:20 +0000
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::976e:f13b:1df4:3160]) by SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::976e:f13b:1df4:3160%5]) with mapi id 15.20.5746.017; Fri, 21 Oct 2022
 02:55:20 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v5] reset: mediatek: Move mediatek system clock reset to
 reset folder
Thread-Topic: [PATCH v5] reset: mediatek: Move mediatek system clock reset to
 reset folder
Thread-Index: AQHY2jp2kvt89khLkE6X5zjylAZ4kq4LdRmAgAzHiIA=
Date:   Fri, 21 Oct 2022 02:55:19 +0000
Message-ID: <93fa62972502a9d254c214d764d117a0adaf6ab7.camel@mediatek.com>
References: <20221007104842.13164-1-rex-bc.chen@mediatek.com>
         <20221012234601.E1BE5C433D7@smtp.kernel.org>
In-Reply-To: <20221012234601.E1BE5C433D7@smtp.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6540:EE_|TYZPR03MB5453:EE_
x-ms-office365-filtering-correlation-id: 234b51bb-3196-4981-1775-08dab30fb0f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7tn0MpjMQT216j7f6QB3pelpDQfn10HluO+wid+jkC8aUpGOkE4r6YpzYdQi4IUuOV48V6VeV68Pyo7GLhQrYO1O+iTWgwGUSwPtulfMZZaIIk/BrJg6q9nbwC4xH0OjKsDBBuncQJ6K8G8t9kpsQgFF0ZwQ0ZC2h/vyLRsUOggx1R+aJ0gNFlhIeWuMg7EnH7e8FL8/ieIdFCor89plu/Kn7nOT/r0zB2IYXvNCiiBIi8jkHW1KBlLp7Hgkq4bexkcxRZCttnQyDp1oXsBJmPNTUMRgrCnR729GmOgjqxrTZTrCj9mLR/HPKEYxFQOjqbG9yFPtai5B/vIiVJNQf0s2VlCL75gm6l75sjakzXAZtkjZ7rv2Cypq5gqXryPmkavhshqV8K0yO24mbzqSX6qchUzpYjA6VrcTC8PD3lMPbQ/GoPNCIJ0Pu131Msx9iGoyaF2gra3ggGS4OEEVbgBE4B/WziyHmOpawrp/N6RnCQnDuVt+w0pdmeP5ScZQ+e/WFiHqDEmgl/zZc938bCC3kmtvfa7Deprq4RWhzgL0O1k1K7mRJXopulOizIhM37rp9zkthUwqTg4vzFE6hmr6YiXUXd7jLH+UVI5YHHXK7zbJoy+EJaG1bUYFSePPY0NqN08u06hKtw5dvcsz28HbSlnboz2SRPpGwh+da2XKoc8Zb2uSWAyZ9d3g2aAWoAlAQK2B88jwageU3tvA8O/b5wwzRXRQGpwWmWZCAYnb0BfGprnovMhXm8gvLbr2WG1XcGoc6vVuqMW1mHhdQYpxknaKkzrQDzidy4I8M0l1xhh/Uhw6CiOaQimoNJy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6540.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(110136005)(316002)(6486002)(54906003)(71200400001)(85182001)(38070700005)(478600001)(5660300002)(4001150100001)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(36756003)(7416002)(122000001)(86362001)(83380400001)(2616005)(6512007)(26005)(38100700002)(186003)(91956017)(41300700001)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJrSDM3RXFpcStlaTlDclNSUWxiRVB5Q1o1a1U1dzJWUEhBSkw1bzBkSUhC?=
 =?utf-8?B?d1AyMzZleXhVQk1WSTFRM01sQzk4NXozeHNTaXArRkgzNndmTlIwUmk1Y2dQ?=
 =?utf-8?B?VVhGQ3RObDMwTk9pMFJKSUVDNU9yWE84RnROcWRLVkJET2owUmFDUFNJUG93?=
 =?utf-8?B?ZWVMWCtMckl0WjJHWTE1Wmk4WmMyNUpTWDVvT2I3UUZKek9QRFNJdFNXUW1Z?=
 =?utf-8?B?T2ZrS3h1Q0N4ejBqTStVTDFKNVNPUm5HZFo4OGl2b2IrVlFBSDh6L08vMzdu?=
 =?utf-8?B?WDdJMmlLb0Zuejd0M1RUTmZmM0wwdEFyZDBvNGo0TGhIRVlPRlEvNzZTZTBy?=
 =?utf-8?B?NWhKSENTTDZHRHVMMlh3cTVLUWc4ZWRXY0F4b04vYTNPcllvTVR4L3FZRmd5?=
 =?utf-8?B?MlVGMXFlR3Q2dXZ4ZitaWGdubHJINStxWTNDUXU3UDVGb25PMGFKVDZDSGhE?=
 =?utf-8?B?WUFURWNicFJBdnRZVkh1UUM4VXA2dklmaVdNbkJxZ0lkdDdBVmhHNW81TTlD?=
 =?utf-8?B?UFdicElVM0dneW1EYWcyVEZnc0twM0J0RzFVQ2FHWVcweEN5YVowdStIN21u?=
 =?utf-8?B?Q0lVeGZRZEpOeHRGS216aTNKRzgwMG5OOTV4M2ljaW83aGY5ayt2Skc0MnNy?=
 =?utf-8?B?UVdDOC90WE9MdjIwUDFZMDVGNUI4SnpQa29PUUI3UzJzLzZPa3hqWHpEekY2?=
 =?utf-8?B?QTNuZHRtMGZob3ZxK3VDRVBvVDN0TzNHVmJucWVrbmplcU1hREFBamt6dWd6?=
 =?utf-8?B?VkVCNGtuSTR6UlN5b0pYU3hDeUx0QVJzZlIzaTBEN041cTMwcHJIeGk0Mngw?=
 =?utf-8?B?LysyZU5DSEVaY21SVjZrWHZkNGZ4dVg5VHBua2QzSFVaOC80TDUxNkdhTm1O?=
 =?utf-8?B?RWtzTkRQM3dWOTd2dGJHc1Bzb2NRVEx5d29hdXQvVzdtK21BaXFvdG1WbTRq?=
 =?utf-8?B?M0FHY2dkZnRhU25QSXRRRDgyK0Zpb1VGbXBFeUxoSUxoSTJtckVaVDc2UUR6?=
 =?utf-8?B?SXFBcWJrTk1WU3VoQVpnNmVTRURYS3c2N1QvMjhRdDM0azJnbENDNTk1aTd4?=
 =?utf-8?B?OUVoajR0WU1mN3dONlcwQThSeDJ6djZCL0pYaENyNzJHOGw2MWg5Nko4MVVw?=
 =?utf-8?B?bi9lQmxqb1RadnNYdEdrNnBwYVRkRjUrWHNHV05vdTI5WnVPRkFicm4xRGFk?=
 =?utf-8?B?MzJsRklqOVE2WmxOa2JoSWVRVHdCV1dZVUdOMlJxUklNTzVBaUZSc0c2dkFW?=
 =?utf-8?B?OW13SC9KK05HQ0FGMnVWZE42TlFiQmlhaXVUdG5EQUNFellyNUdzd0U1VTRH?=
 =?utf-8?B?VitEV3B1K3Z4OVZQWG1oQXFYUkJEemsrcU9iSUJkZ3d2TFdPK1JuUFBhSU1B?=
 =?utf-8?B?NVJXc0VNcXJlaHdNK1JuNXdwNzc3Qk5xVmN6U1FoU3hVSVlmSTRxQjZxVnpR?=
 =?utf-8?B?WTUwZENlYlZEMm9HdW9wdzYyQkpRb1BQZGlibGx0VVVuNmlVWkgvL29RamMr?=
 =?utf-8?B?QUtER0QrcjNPOW9zVHluMTJIQmZvenhDWTVxVXh0MlBiMEhNd3NNRCtnOWFx?=
 =?utf-8?B?bENDRFFZVVdzSVZYWXdZbmNUNE1TUktDTVNpWU9mNFBXQWtSaWFYRnpxRTJW?=
 =?utf-8?B?L2drbGxhdXVKNFVsMTREVjg4TWFQZnpkMzJYWlRGRXVLWUJpc0pnS01OeWFG?=
 =?utf-8?B?YkoxWDZPNWsxQkpxNW00LzRsYUxWV0NoYUJoczBmMSsxYVZKOFRuTGhiajhB?=
 =?utf-8?B?YkFtenRnajQwM2p0SDRzbmFUYlA5UGlDK0RSb2pmTVpMM1lxeEZoN3A2Y0RO?=
 =?utf-8?B?NXRUMm1LM0lndmoydDlSYnN5OGoyODJLSVBBUXk5WmRyWlljVTNWaXZXUWtE?=
 =?utf-8?B?U3NFNlpEWlJ4YS9idUV3SHNEWEhBdGpEc2k4dGd5WG1BSDY4S3BWNHVFUWZz?=
 =?utf-8?B?NXg3TzlWZzR6TElVd0poM1prUFhMaFlhMXEyNmhyUzVMYnJMYlk5em0wbTI1?=
 =?utf-8?B?NmRLb2t5VU9KekYwNmgvUUxybEtwSEc3ZVRBdm5tN0p0SjJqUVpYemxEbFov?=
 =?utf-8?B?KzhuUzA2VzlkOTJseEFUcnRpZVhiUVphY1Bob2pGYktSZnY2YVl1ZXdyUEcy?=
 =?utf-8?B?QkE0dkhqMHlGY3pMQm5WYXNRdDhTQ09jOXFLaHgzZnNaak9qdUg5WjlJTlBp?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A731DC045DE1A84ABFE65C15810D679C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6540.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b51bb-3196-4981-1775-08dab30fb0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:55:20.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rMAXsZRZDPQOxvRIW79b6ezp6Li5aJJwseyXHjoSYXV4p3h7SNFasfc//6TpWlmWhH1xchw9CXAzMUIZPViEzbJfrBw9uPfRys/kog8WAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5453
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDE2OjQ1IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgQm8tQ2hlbiBDaGVuICgyMDIyLTEwLTA3IDAzOjQ4OjQyKQ0KPiA+IFRvIG1hbmFn
ZXIgbWVkaWF0ZWsgc3lzdGVtIGNsb2NrIHJlc2V0IGVhc2llciwgd2UgbW92ZSB0aGUgZHJpdmVy
DQo+ID4gdG8NCj4gPiBkcml2ZXJzL3Jlc2V0Lg0KPiA+IA0KPiA+IC0gQ3JlYXRlIHJlc2V0L21l
ZGlhdGVrIGZvbGRlci4NCj4gPiAtIE1vdmUgY2xrL21lZGlhdGVrL3Jlc2V0LmMgdG8gcmVzZXQv
bWVkaWF0ZWsvcmVzZXQtbWVkaWF0ZWstDQo+ID4gc3lzY2xrLmMNCj4gPiAtIEJlY2F1c2Ugd2Ug
ZG9uJ3Qgd2FudCB0byBidWlsZCBpbiB1bnNlZCBzdGF0aWMgdmFyaWFibGUgKEZvcg0KPiA+IGV4
YW1wbGUsDQo+ID4gICBpZiB3ZSB1c2UgbXQ4MTg2LCB3ZSBkb24ndCB3YW50IHRvIGJ1aWxkIGlu
IHRoZSB2YXJpYWJsZSBvZg0KPiA+IE1UODE5NS4pLA0KPiA+ICAgd2UgdXNlIGNsayBLQ29uZmln
IHRvIGRvIHRoaXMuDQo+ID4gLSBNb3ZlIHJlc2V0IGRhdGEgd2hpY2ggYXJlIHNjYXR0ZXJlZCBh
cm91bmQgdGhlIG1lZGlhdGVrIGRyaXZlcnMNCj4gPiB0bw0KPiA+ICAgcmVzZXQtbXR4eHh4LmMu
DQo+ID4gLSBGb3IgbXRrIGNsayBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgZGV2aWNlLCB3ZSBjYW4g
dWVzDQo+ID4gICBtdGtfcmVzZXRfY29udHJvbGxlcl9yZWdpc3RlcigpIHRvIHJlZ2lzdGVyIHJl
c2V0IGNvbnRyb2xsZXINCj4gPiB1c2luZw0KPiA+ICAgYXV4aWxpYXJ5IGJ1cy4NCj4gPiAtIEZv
ciBtdGsgY2xrIGRyaXZlcnMgd2hpY2ggZG8gbm90IHN1cHBvcnQgZGV2aWNlIChvbmx5IHN1cHBv
cnQNCj4gPiAgIGRldmljZV9ub2RlKSwgd2UgdXNlIG10a19yZXNldF97aW5pdC9yZW1vdmV9X3dp
dGhfbm9kZSB0bw0KPiA+IHJlZ2lzdGVyDQo+ID4gICByZXNldCBjb250cm9sbGVyLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJvLUNoZW4gQ2hlbiA8cmV4LWJjLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiANCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2Nv
bmZpZw0KPiA+IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KPiA+IGluZGV4IDg0M2Nl
YTBjN2E0NC4uYmNkMDczYWRhMGU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQo+ID4g
QEAgLTgsNiArOCw4IEBAIG1lbnUgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgU29DIg0KPiA+
ICBjb25maWcgQ09NTU9OX0NMS19NRURJQVRFSw0KPiA+ICAgICAgICAgdHJpc3RhdGUNCj4gPiAg
ICAgICAgIHNlbGVjdCBSRVNFVF9DT05UUk9MTEVSDQo+ID4gKyAgICAgICBzZWxlY3QgUkVTRVRf
TUVESUFURUtfU1lTQ0xLDQo+IA0KPiBJcyB0aGlzIHNlbGVjdCBuZWNlc3Nhcnk/DQo+IA0KDQpI
ZWxsbyBTdGVwaGVuLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KVGhlIHN5c3RlbSBjbG9j
ayByZXNldCBkcml2ZXIgaXMgb3JpZ2luYWwgYnVpbHQgd2l0aCBtZWRpYXRlayBjbGsuDQpUaGVy
ZWZvcmUsIEkgdGhpbmsgd2Ugc2hvdWxkIHNlbGVjdCB0aGlzLg0KDQpQbGVhc2UgcmVmZXIgdG8g
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCg0KIm9iai0kKENPTkZJR19DT01NT05fQ0xL
X01FRElBVEVLKSArPSBjbGstbXRrLm8gY2xrLXBsbC5vIGNsay1nYXRlLm8NCmNsay1hcG1peGVk
Lm8gY2xrLWNwdW11eC5vIHJlc2V0Lm8gY2xrLW11eC5vIg0KDQo+ID4gKyAgICAgICBzZWxlY3Qg
QVVYSUxJQVJZX0JVUw0KPiA+ICAgICAgICAgaGVscA0KPiA+ICAgICAgICAgICBNZWRpYVRlayBT
b0NzJyBjbG9jayBzdXBwb3J0Lg0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ay5jDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMN
Cj4gPiBpbmRleCBkMzFmMDFkMGJhMWMuLjYxYjdlZTIzNzM4YSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXRrLmMNCj4gPiBAQCAtNDQ0LDYgKzQ0NCw2MyBAQCB2b2lkIG10a19jbGtfdW5y
ZWdpc3Rlcl9kaXZpZGVycyhjb25zdCBzdHJ1Y3QNCj4gPiBtdGtfY2xrX2RpdmlkZXIgKm1jZHMs
IGludCBudW0sDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwobXRrX2Nsa191bnJlZ2lz
dGVyX2RpdmlkZXJzKTsNCj4gPiAgDQo+ID4gK3N0YXRpYyB2b2lkIG10a19yZXNldF91bnJlZ2lz
dGVyX2FkZXYodm9pZCAqX2FkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBhdXhpbGlh
cnlfZGV2aWNlICphZGV2ID0gX2FkZXY7DQo+ID4gKw0KPiA+ICsgICAgICAgYXV4aWxpYXJ5X2Rl
dmljZV9kZWxldGUoYWRldik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIG10a19y
ZXNldF9hZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAg
ICBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiA9IHRvX2F1eGlsaWFyeV9kZXYoZGV2KTsN
Cj4gPiArDQo+ID4gKyAgICAgICBhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdChhZGV2KTsNCj4gPiAr
DQo+ID4gKyAgICAgICBrZnJlZShhZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHN0
cnVjdCBhdXhpbGlhcnlfZGV2aWNlICptdGtfcmVzZXRfYWRldl9hbGxvYyhzdHJ1Y3QgZGV2aWNl
DQo+ID4gKmRldiwgY29uc3QgY2hhciAqbmFtZSkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0
IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXY7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArICAgICAgIGFkZXYgPSBremFsbG9jKHNpemVvZigqYWRldiksIEdGUF9LRVJORUwpOw0KPiA+
ICsgICAgICAgaWYgKCFhZGV2KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsNCj4gPiArDQo+ID4gKyAgICAgICBhZGV2LT5uYW1lID0gbmFtZTsNCj4gPiArICAg
ICAgIGFkZXYtPmRldi5wYXJlbnQgPSBkZXY7DQo+ID4gKyAgICAgICBhZGV2LT5kZXYucmVsZWFz
ZSA9IG10a19yZXNldF9hZGV2X3JlbGVhc2U7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gYXV4
aWxpYXJ5X2RldmljZV9pbml0KGFkZXYpOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsg
ICAgICAgICAgICAgICBrZnJlZShhZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIEVS
Ul9QVFIocmV0KTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gYWRl
djsNCj4gPiArfQ0KPiA+ICsNCj4gPiAraW50IG10a19yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVy
KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhcg0KPiA+ICpuYW1lKQ0KPiA+ICt7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldjsNCj4gPiArICAgICAgIGludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgYWRldiA9IG10a19yZXNldF9hZGV2X2FsbG9jKGRldiwg
bmFtZSk7DQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKGFkZXYpKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihhZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBhdXhpbGlh
cnlfZGV2aWNlX2FkZChhZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgICAgYXV4aWxpYXJ5X2RldmljZV91bmluaXQoYWRldik7DQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJu
IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsDQo+ID4gbXRrX3Jlc2V0X3VucmVnaXN0ZXJf
YWRldiwgYWRldik7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobXRrX3Jlc2V0X2Nv
bnRyb2xsZXJfcmVnaXN0ZXIpOw0KPiA+ICsNCj4gPiAgaW50IG10a19jbGtfc2ltcGxlX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgICAgICAgIGNvbnN0
IHN0cnVjdCBtdGtfY2xrX2Rlc2MgKm1jZDsNCj4gPiBAQCAtNDcwLDkgKzUyNyw4IEBAIGludCBt
dGtfY2xrX3NpbXBsZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+
ID4gIA0KPiA+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgY2xrX2RhdGEpOw0K
PiA+ICANCj4gPiAtICAgICAgIGlmIChtY2QtPnJzdF9kZXNjKSB7DQo+ID4gLSAgICAgICAgICAg
ICAgIHIgPSBtdGtfcmVnaXN0ZXJfcmVzZXRfY29udHJvbGxlcl93aXRoX2RldigmcGRldi0NCj4g
PiA+ZGV2LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbWNkLQ0KPiA+ID5yc3RfZGVzYyk7DQo+ID4gKyAgICAgICBpZiAobWNk
LT5yc3RfbmFtZSkgew0KPiA+ICsgICAgICAgICAgICAgICByID0gbXRrX3Jlc2V0X2NvbnRyb2xs
ZXJfcmVnaXN0ZXIoJnBkZXYtPmRldiwgbWNkLQ0KPiA+ID5yc3RfbmFtZSk7DQo+ID4gICAgICAg
ICAgICAgICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5yZWdp
c3Rlcl9jbGtzOw0KPiA+ICAgICAgICAgfQ0KPiANCj4gQ2FuIHlvdSBzcGxpdCB0aGlzIHBhcnQg
b2ZmIHRvIGEgZGlmZmVyZW50IHBhdGNoPyBJdCB3b3VsZCBtYWtlIGl0DQo+IGVhc2llciB0byBy
ZXZpZXcuIEFuZCB0aGVuIHlvdSBzdGFjayB0aGUgcmVzZXQgcGFydCBvZiB0aGUgcGF0Y2gNCj4g
YWZ0ZXINCj4gdGhpcy4NCj4gDQoNCk9LLCBJIHdpbGwgc2VwYXJhdGUgdGhpcyBwYXJ0IHRvIGFu
b3RoZXIgcGF0Y2guDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ay5oDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgNCj4gPiBpbmRleCA2
M2FlNzk0MWFhOTIuLjk1Nzg2NDNlZjVhMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXRrLmgNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmgNCj4gPiBAQCAtNywxNCArNywxNCBAQA0KPiA+ICAjaWZuZGVmIF9fRFJWX0NMS19NVEtfSA0K
PiA+ICAjZGVmaW5lIF9fRFJWX0NMS19NVEtfSA0KPiA+ICANCj4gPiArI2luY2x1ZGUgPGxpbnV4
L2F1eGlsaWFyeV9idXMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0K
PiA+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQvcmVzZXQtbWVkaWF0ZWstc3lzY2xrLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvdHlw
ZXMuaD4NCj4gPiAgDQo+ID4gLSNpbmNsdWRlICJyZXNldC5oIg0KPiA+IC0NCj4gPiAgI2RlZmlu
ZSBNQVhfTVVYX0dBVEVfQklUICAgICAgIDMxDQo+ID4gICNkZWZpbmUgSU5WQUxJRF9NVVhfR0FU
RV9CSVQgICAoTUFYX01VWF9HQVRFX0JJVCArIDEpDQo+ID4gIA0KPiA+IEBAIC0xOTUsMTAgKzE5
NSwxMiBAQCB2b2lkIG10a19jbGtfdW5yZWdpc3Rlcl9yZWYydXNiX3R4KHN0cnVjdA0KPiA+IGNs
a19odyAqaHcpOw0KPiA+ICBzdHJ1Y3QgbXRrX2Nsa19kZXNjIHsNCj4gPiAgICAgICAgIGNvbnN0
IHN0cnVjdCBtdGtfZ2F0ZSAqY2xrczsNCj4gPiAgICAgICAgIHNpemVfdCBudW1fY2xrczsNCj4g
PiAtICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfY2xrX3JzdF9kZXNjICpyc3RfZGVzYzsNCj4gPiAr
ICAgICAgIGNoYXIgKnJzdF9uYW1lOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgaW50IG10a19jbGtf
c2ltcGxlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpOw0KPiA+ICBpbnQgbXRr
X2Nsa19zaW1wbGVfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpOw0KPiA+ICAN
Cj4gPiAraW50IG10a19yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRl
diwgY29uc3QgY2hhcg0KPiA+ICpuYW1lKTsNCj4gPiArDQo+ID4gICNlbmRpZiAvKiBfX0RSVl9D
TEtfTVRLX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvcmVzZXQu
Yw0KPiA+IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvcmVzZXQuYw0KPiA+IGRlbGV0ZWQgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+IGluZGV4IDI5MGNlZGE4NGNlNC4uMDAwMDAwMDAwMDAwDQo+ID4gLS0t
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvcmVzZXQuYw0KPiA+ICsrKyAvZGV2L251bGwNCj4gDQo+
IFRoaXMgZmlsZSBjb3VsZCBwcm9iYWJseSBiZSBkZWxldGVkIGluIHlldCBhbm90aGVyIHBhdGNo
IG9uY2Ugbm9ib2R5DQo+IGlzDQo+IHVzaW5nIGl0Lg0KDQpJIGFtIG5vdCBzdXJlIHdoYXQgZG8g
eW91IG1lYW4uDQpUaGlzIHNlcmllcyBpcyBmb3IgbW92ZSByZXNldC5jIHRvIGRyaXZlcnMvcmVz
ZXQvbWVkaWF0ZWsuDQpTaG91bGQgSSBub3QgZGVsZXRlIHRoaXMgZmlsZT8NCg0KQlJzLA0KQm8t
Q2hlbg0K
