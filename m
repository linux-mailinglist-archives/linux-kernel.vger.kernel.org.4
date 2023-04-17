Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88B76E3D36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 03:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDQBgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQBgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:36:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BDF1;
        Sun, 16 Apr 2023 18:36:50 -0700 (PDT)
X-UUID: 4ce88b12dcc011edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1tWtEHPEZPIVXPk0eAmAsGpDcKv26k+z/FhrBFnujd0=;
        b=sjPC6ahDN9xuk4qCLk9hdPjXMM3N114tQpFM2NSTCcQnM2KQuidAEwD5wp7eEQlU9dfxApLeGZuPp1V2TyyXrZrjEfdLYULLqDbXNDqW2HW8UDHNbTxk8vksZMahbqMrQzeckBRMLBaoPtXb58/HJ/YUrtNXdRTCcgnHkQGIoPI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:de6834fb-7920-439c-b21c-f4f60fd73e13,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:de6834fb-7920-439c-b21c-f4f60fd73e13,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:64f024eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230417093643LI8PAI7W,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4ce88b12dcc011edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1112074560; Mon, 17 Apr 2023 09:36:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 09:36:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 09:36:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNckUA6+0cat6zsUZgHSVWyuOlE8knyNMtCbFkkAh7Rq9zsniapuaxlMbxDNbA3rSj+53xJU2yftz278ZaBbZKMhF/ZY/LDNVPBhdhYBAgSj55gYo5g6FgVMPp0MVu6+omq/SdQST5x35NlDNIDb4X8q2liMzolqDLKCVHuC068bLlVX5ElzqcSfloIm3k2iytuM9zzxdxHXZQSf6N9NcyMn5s34gGUspmDuQfoS7KYHYrlhxaVGARNNoi9wPYYW5b0yoy9Ka2mp1AKAGK/gPZB6qOx6VESipDMXU2pv6daarH5a2wJJXqxXet4qVHeZ9WW12RaoFpYCxDJDN7mImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tWtEHPEZPIVXPk0eAmAsGpDcKv26k+z/FhrBFnujd0=;
 b=V114xrP/QTjv4cE9M7via/EtDEVxiJjS8LmbJIN53KCcE/87frSdrgv/WCYwPKanTmMPXazfEmJPLc/ikAMFt2b06DIvZJmfBtn0I1s5j5nRLGp9+9BWNO2MduVk93OCzQqUzHJAiymF6xqPGLllfP/wH0ZhxZriiPA4hpbmfqeVtZDQa5BxfBwFIeOg1/yKkUqru6QqQA2gMskPoduqJP6dgKn0SsWN/TlPLdPWPhPpAMmdtYSIm4ePPQehC7WsmuxuUhGQWuPpQXQ3VIVAe0Xhi7S7Le48PwgoFy5yJFsSuRnatIaJts/fffSmkL0+Cqo6Tzfj3Tg8W0BuM3Ou8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tWtEHPEZPIVXPk0eAmAsGpDcKv26k+z/FhrBFnujd0=;
 b=ZHrZ4Qrnfp7FQ0PDbrYVutL02K1QxqLaTiG3nGLqbWT5AL2j+QAZCHiXIWKzP28oY6E+kjFeP5bsXY+yBac5M/jXRaytrNL47PVdKnM+YNAOO0y7zpfU7kCTqhBnDF/B6+QAYjq6OGd7m9XAEP1Ze2BlQ7Xf8lkpx3UYC8jCG7k=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TYZPR03MB5827.apcprd03.prod.outlook.com (2603:1096:400:122::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:36:36 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:36:36 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Add explicit of.h of_platform.h include
Thread-Topic: [PATCH] usb: Add explicit of.h of_platform.h include
Thread-Index: AQHZbAP0xlJ6mCQfZU6kcAUXYDk6O68uwf0A
Date:   Mon, 17 Apr 2023 01:36:34 +0000
Message-ID: <98fec29e9adbb06d413b1c7821655c6579e15b3b.camel@mediatek.com>
References: <20230410232639.1561152-1-robh@kernel.org>
In-Reply-To: <20230410232639.1561152-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TYZPR03MB5827:EE_
x-ms-office365-filtering-correlation-id: f1e2e9dc-d2c5-4418-6028-08db3ee42e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QDG2GF6wvIlWqeQlxiOsNA8aFb7FsK2WNfzKK3mlu5dK0/ANh2wTMJrJzgKj5hWe/17N2FTSuatQrZlFmXox9aAg1XO831foqxM7kwcEl44SS36FKNJFEl9BSTDikFcESmyQ8tLnBYnxcqgziAL8R8Cp2PbdTp9BCMKezEEjPlTFQb3KbCwYjirX3OLkTa656ICJ0UQdVaZi0tJ4oIyyyH/QvsDlE4tE8sV2L8n9Z5fYTf1NGe2obEY1TzOXRs4lCvQJysObZFJUPGjEHMEwCYSGGqmWIqux5dKLVCw/p/FET4mBnE4m0xK3W2be/MtubTlkIuT0LzoEYBpT+/aOhM/IRX1EO9gPnVfJJt/BSExsvDjZg4M0QRSucrGy6moR0ELJjk/9oXqqqqLkch7RjPk64E+HFrJII1Gtyb2dkrL5E2LaiBP1VEgGAOc/Be0ujIagOjrMKuimuQg23D8UoseXXzi9SctjV5EnkaylpEOYTxPfWausisgp1fDUoB0D0ZEnlL82B8DiW2RTbfC9KDbzwqaFCvkOpALyA4gDwc9BafFQ81/x1ZSS0BD67JYTJYU9NgM3Md2r7dssza90avGxidpSQtNFWV/v9EGXqGlDafOYwBXt99h6T1j0A3Gr7Lzji5g9kLhWsCYwY2N6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(451199021)(26005)(6506007)(6512007)(5660300002)(41300700001)(122000001)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(86362001)(91956017)(76116006)(38100700002)(8936002)(8676002)(186003)(2906002)(38070700005)(6486002)(85182001)(71200400001)(36756003)(478600001)(110136005)(316002)(54906003)(83380400001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BEeG1RenRhSC9lb0dFRTVxM3NDVGcxMjFyTjJaWVp6bUw3ZW0wTWtHWEJE?=
 =?utf-8?B?endkdU5zSTBIVUtuWk5aUHczY0hKbGpXZGFoV2s5WmFSQmdpSE5acmU1eExv?=
 =?utf-8?B?ZUZQZzcxL29ibnBjdkpPRUtNVzBGNnFJbXVWRnpvektxckg2MzdFUktpcG1T?=
 =?utf-8?B?TmZUNVRzQVdkdGNDQlkxRFRZTFFJRkhMaTcvanFPQnNqd2s2ZnVSVzFPODR1?=
 =?utf-8?B?T3l5NDI1SEZUWGNvK0VndE15aFB3NmlvZTZ6a0Y5dTN2V0IrYWdNREhUSjJD?=
 =?utf-8?B?OXNjOWZCenUxNmVBcjY5M205d2xTVkJTSUtwbjZpSzNEb0oxcG5ia0syWm02?=
 =?utf-8?B?MUNpaCtDV2F4NTV4RGRmUU95anU2MFJKTGhuNUFpYXYrSjJBMXB1Z28zclEr?=
 =?utf-8?B?MVRTcG13MFJJQ1pQakxhbDJiUVZqdGJtOFpsck9SdEN1aVlmcW40VjB6NHli?=
 =?utf-8?B?TEFWS3ViUmdwSHo1ZnhPKzRhajJaMmh5ZzBVODlLYm52dHpSMFVaQWlYcnl6?=
 =?utf-8?B?d1RibUptaGlIcWVTanlaakJobFYxWlV1cXdVcEYvcy9QWjlNM1I0M3h0NXpi?=
 =?utf-8?B?amtYM0pWMngvSGRLeWphOW5UYnR2REpJek85Tk5kbC8xYnlWTFIyUXI1S1lD?=
 =?utf-8?B?U2U2RHNYaXR1d0tPVmVsVGQxRmNmWkdySUZjQkJUQXBSdzVhL3pPWFI5aUFw?=
 =?utf-8?B?TUU3RzVEVENxeWg4WUZCVzZyV0JkTUxmWk80ZllEbVo0a3o0WFFOaUNnUUpv?=
 =?utf-8?B?MHh2ZjVVb0R3TGNCamJETlAxK1hyTjAyTWZ0d2tvOVBnUWM2eTBVSWw5YjFR?=
 =?utf-8?B?akVOdFBNNzlkcS93ZStML3k1TVI2UkJQM2RISm0rZWtYeDRNNzc3cFNYWm1r?=
 =?utf-8?B?SDhDbkhsWFl3azZKUXNKeU05WEtGZXdNWUtVUFdHbnUyTFZDT3MzRjYySUk0?=
 =?utf-8?B?KzVXVi9VSG94TEpyQWJycDNNNHI2UjBpS3puMVRmdElBeUJJWTNzdHpKMllE?=
 =?utf-8?B?WTRBb0Rnd280WjZZZFhpOVFCVEVGOXJZK2p0dDRxQ0dyNVF0SHVaZkJCNUVO?=
 =?utf-8?B?TUpubjdsK2UyTXVFWC9KcllTZmhvYVE4NjhRZ1VkRVpJSWNIb3NRS3dweVRv?=
 =?utf-8?B?Y01jamFjbEwzdlJNN0hxdEl2NnBlZVMrTkZVdm1DWU5sMlpJVVBySnpuckxM?=
 =?utf-8?B?WEtTTm56bENrUDJPUEEwK205eE0xeVFIV1pJdEY2Qm5UeVQyaEFnV01XdU5i?=
 =?utf-8?B?RHFJcUI0aWkrbFY3b0hNM0gxNGJFRVBFZzJKTlF3Wmp5UjRkYnBxYVRka3pz?=
 =?utf-8?B?eDY4UWJSUUlTTFp1V1BuMlJoVWduWVhqWElvWENEVnFPRjk1SS9SNDkrb3Rv?=
 =?utf-8?B?TjhRb3JZMklmai93K01LSzZxeVJ4YldrcmdaVXd5UGEvSSsvTmRDcWRSUXhF?=
 =?utf-8?B?MmVjTERoTCtzQmtTSnlVb2ZJNzFHanhFZVYzQ0gvRnBDNUM5RFQxa2tZZTZj?=
 =?utf-8?B?Ynk4RFhQK2RRUHF0T0J5T2NPWjUxYjFzRWU3ditiVFNlR2RVa3g4N3BBOEMy?=
 =?utf-8?B?RTFpUkphZzVwblgyTlcyZUNVd1FNMzJIUVQrNmV0dnRUTkxFZmI1QndhUG5B?=
 =?utf-8?B?ME1RdlB1VVFFdkVFWlN3RUVRcXg5SlZKQUYwd1FreGxoeTk4OE80dzRQeUdk?=
 =?utf-8?B?VGhYMkZSQ1p2aFZDV2Y2N29UQ2ZaMUd6WUxib0VZWmg5WFpHRGhZS0RMOXVP?=
 =?utf-8?B?eHl6RThzbG5MUzUzRXcrdFA2bDVsWDF0VExRTVRscFhaMFVoTkZURFJIbDBt?=
 =?utf-8?B?WEVmdDlIOTVJNzUzTlFGVmpHaTUyaEpCRDRPN2xTMUR6WTM5UUVkcnR1ZHRq?=
 =?utf-8?B?b0VmOTJVRFJFMDlma1I4M1piN0NncXVLb0FBSGIrYUVGY1UvMTBuWjdaMGlK?=
 =?utf-8?B?U3lxN0d1eHNORjRpNVhiMlFveUt2c2RXWktGekZ3OHo5ditncUtMVFRZZEE2?=
 =?utf-8?B?MmRReHRCUVdOR2NvRmEvL2M4eGUzaHFwR3RpdGZmUy9YT2tteTVGREdRcEhx?=
 =?utf-8?B?enNra3kvZFI5bHZlSGROVmwzUjRuTDkwRVh6dVNHeVYxZ1JQMERHUWFRN2ZH?=
 =?utf-8?B?aVltSFFCemF3Y1ZNdWdqdmRXMjd2WVB4QWJ3bHdsU0V1cjUyMENPbm84RGtT?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05CA87220526B94C9F4B0310A7812528@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e2e9dc-d2c5-4418-6028-08db3ee42e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:36:34.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Hwf+GkvYrZA5g87PGfbA9e+x+eOcpu6dQJw5EdSuAYg0j9/vPqDPa3yojNEQql9gHUDhB9jokEOZuu61PvkPlk8zlsE90U1yY6k1TNKt+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5827
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTEwIGF0IDE4OjI2IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBTZXZlcmFsIFVTQiBkcml2ZXJzIHVzZSBvZl9wbGF0Zm9ybV8qIGZ1bmN0
aW9ucyB3aGljaCBhcmUgZGVjbGFyZWQgaW4NCj4gb2ZfcGxhdGZvcm0uaC4gb2ZfcGxhdGZvcm0u
aCBnZXRzIGltcGxpY2l0bHkgaW5jbHVkZWQgYnkgb2ZfZGV2aWNlLmgsDQo+IGJ1dCB0aGF0IGlz
IGdvaW5nIHRvIGJlIHJlbW92ZWQgc29vbi4gTm90aGluZyBlbHNlIGRlcGVuZHMgb24NCj4gb2Zf
ZGV2aWNlLmgNCj4gc28gaXQgY2FuIGJlIGRyb3BwZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1hbTYyLmMgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9y
enYybV91c2IzZHJkLmMgfCAyICstDQo+ICBkcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jICAg
ICAgICAgICB8IDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYy
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtDQo+IGFtNjIuYw0KPiBpbmRleCAxNzNjZjM1Nzlj
NTUuLjRkNjc0YTI0Mzc4NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFt
NjIuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+IEBAIC0xMSw3ICsx
MSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+IC0jaW5j
bHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0u
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
Y2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL3J6djJtX3VzYjNkcmQuYw0KPiBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvcnp2Mm1fdXNiM2RyZC5jDQo+IGluZGV4IDNjOGJiZjg0MzAzOC4uOGFhZmQxZGRmMTI2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3J6djJtX3VzYjNkcmQuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3J6djJtX3VzYjNkcmQuYw0KPiBAQCAtNiw3
ICs2LDcgQEANCj4gICAqLw0KPiANCj4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiAtI2luY2x1
ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvcG1fcnVudGltZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jDQo+IGIvZHJpdmVycy91c2IvbXR1My9t
dHUzX2hvc3QuYw0KPiBpbmRleCBmMzkwMzM2N2E2YTAuLjE3N2QyY2FmODg3YyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9t
dHUzL210dTNfaG9zdC5jDQo+IEBAIC0xMSw3ICsxMSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgv
aXJxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
bWZkL3N5c2Nvbi5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQpG
b3IgbXR1MyBjaGFuZ2U6DQoNCkFja2VkLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+DQoNClRoYW5rcw0KDQo+IA0KPiAgI2luY2x1ZGUgIm10dTMuaCINCj4gLS0N
Cj4gMi4zOS4yDQo+IA0K
