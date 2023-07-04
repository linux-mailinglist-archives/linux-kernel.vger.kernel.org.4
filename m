Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706BC746709
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGDCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGDCCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:02:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B0E54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:02:34 -0700 (PDT)
X-UUID: d56452b01a0e11ee9cb5633481061a41-20230704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5ouaFlN9YwsU4+WTNxnlAxE/IURRboe66ZAX5rrP+m8=;
        b=diJ0Dg4FORz1nuxEuoTgR7AWKB4qQUKHeboapoU/2tOi+RxES1WVMgaWiT5jnEeFoOMxmcKogBwoXf100SbDgh1SJ27rClAonKu623zf3E6e0K0vwPnR58vOjNoooQbTrTbVmAZHL1jIo/DUfb+GmMz/icZzj2OUXyR5V5FqIuI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:a6c18607-a087-4f34-b7a9-c216de7cf27b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:c93f96da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d56452b01a0e11ee9cb5633481061a41-20230704
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 581040279; Tue, 04 Jul 2023 10:02:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jul 2023 10:02:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jul 2023 10:02:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY0HYMJfftFwHS+mWaFDTF2iUePw67up7CA51m6Ieti7sZ8ii91AzkreC3d9sZpeaGtzhCirN5aVMw4CJLVtxGWLu3A5rIsaSnWFOyYnTJMAn7bYyGupiw9HDwY1kGmokwnqLBPe6H6ojSMGWqCXV31zRhS29+nfqQB2Umuf384miQ3s/vpUqsz866asFyYqtBMw/iLJZ+ENs+RLi56pbrpKtCQRNbO9nxKMMuPERQeX1U71fC/xHj8hxCKShtfKGTSmZZk9ofFFfxrAe4P4g89rIwfbruCGWqonXeXtTeeIxrP6eHNdfipmPNjM6LMBkTd2Od1ppSzdHz4MguaPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ouaFlN9YwsU4+WTNxnlAxE/IURRboe66ZAX5rrP+m8=;
 b=i9j0EbX2Gr8NBQrkfKSPa89vXsFhKpwqL45oT5vjtbiKKHb0231z9ayZy5Ya/n1YCAxwDzBPmsO3h093/MRAU+bplhge9jj/gCrKJsOtFW347eV5qqcJ4SEibeDcOe6tPB4QvOPhHPpqksaV67DPCXDtxg65+kR/xxR0UV7QhhnF+H8/zSD/+gD/SN9tIxC4RwN5X9XF7uemhrTFZoJ9j5/8B92j04bMZZU2yZtfNPyFnKEQCFJ8TOU2Q4088i5SNgXb48XlaFCS2JNmfg6lTEOafPwJITkHAmMHNMbgls7eqR7LvMrZgLpQt7pR+bP4n06KUzPXbZX5bzpOaBiubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ouaFlN9YwsU4+WTNxnlAxE/IURRboe66ZAX5rrP+m8=;
 b=eM2rR7D6wtIIu7q2kBvcqDlP2NOM5zSwDvtI+brcCUKXi3cskPI8ycmUtGfyjB0NDbd9Tpsc0HiGDeG7dXE8ug/2Fc05B82caz9VEsPiBTyeU4P+Xb0Nsur8qWycdnvpmNlYFA3g7W6focPayJEOitiSSXcMWubWZOeN/dJJSLk=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB5907.apcprd03.prod.outlook.com (2603:1096:301:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:01:28 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f5fe:ada:20da:5200]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f5fe:ada:20da:5200%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:01:28 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Thread-Topic: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Thread-Index: AQHZql+a6p+yEgGYRky6qKsurqdc2a+h4bMAgADxNYCAAFxvgIAEz20AgADjX4A=
Date:   Tue, 4 Jul 2023 02:01:28 +0000
Message-ID: <fe35c2597040e84ac842696f72a5b3e5cd0f98ad.camel@mediatek.com>
References: <20230629075910.21982-1-trevor.wu@mediatek.com>
         <5995e77b-ea8e-4e88-8ca2-f716df9c9579@sirena.org.uk>
         <0e8b5ca298a01b16da0419928a30af6371e923ca.camel@mediatek.com>
         <6cda3265-7444-46a1-8b2e-75706a839670@sirena.org.uk>
         <8b576880-1c78-84d7-ee46-641c65cdf35d@collabora.com>
In-Reply-To: <8b576880-1c78-84d7-ee46-641c65cdf35d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB5907:EE_
x-ms-office365-filtering-correlation-id: 216c6451-d305-45b2-366c-08db7c32947b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYSTSusalPCRk5UD6BQbr1n4YnVi8obcvblef/SuKysVx+JAZWBFoEN7vRKqf600zldqdp59nol+tY2tdU+4rdxJUnAZghoawpnHVsBoyYF6Dn66iUG0QPNZ4G3QquIydzQgT3BFleoJUtigYvd/nmnVE2ByeJ7olznRVGJtSCsNIagYt6HPCkioOgpqyykv9p66swlal1aka3sjlMwTO15OP+ZsLGUlvBM/Lni2B1mhom0B7y1WGq55kuPcyWKrj543B/a3jr04onICyCPv6mHylZfI0iEay9Aogq4FWiKNEH5r4+SWlirv79tB16AaTJh1hlnQkS1ofWRDhek0nr1a2iSVip1jSl26ZQy/zFxPu/H6pZFerjzWgi70pDONrJLM13bJc6Ok94hGOuRc9cMeE99PJACiMaFOXLtEj/NTF24jOdm5mM93aiarjRNhkJ0C5qLZEXvetVTxyG+wQ0gufJgTG4Y8hAYE5VmV8EZ6cOtBNrVISAa4YFa1aSMhFgSYY2TbcOHV/FhQ4jwFjrh12I5zWXnqr2B0TgmyvFtPE5oyi2200LS86iLYl1cju7S/IB8FTC9GdhdX2Cy22kp2Xrso8LKsasVbA4RUuzaAJ50HHq0B/AHagOPcVjdaRzth9VU9N2LZcwul1+y/yk1bk8hLmXalhr50iDXx2gnvZ8uDoS2Nsi29rYDOn/Kw4fw+ICrJUmapo+MqltvuIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(26005)(478600001)(71200400001)(6506007)(6512007)(86362001)(2616005)(186003)(64756008)(38100700002)(54906003)(4326008)(66946007)(66446008)(66556008)(66476007)(83380400001)(110136005)(6486002)(91956017)(76116006)(316002)(122000001)(5660300002)(8936002)(8676002)(7416002)(38070700005)(41300700001)(2906002)(36756003)(85182001)(99106002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTA5TXQrTVQ1MDBjaEFSWXVNOERiUFJnQUdLL0ozZ0prby9qUVBuWmg0K3JR?=
 =?utf-8?B?QkU2cEoxSjhTeUFVQThKRC9XOFluaVF3dW45U25JNVpXNXphczRhN0tMclVk?=
 =?utf-8?B?OVZLbG1DMGY4dUk5N09LMjczTzk3Tzg4bGk4dFhKTVpVbDlobVA5cHNSanlw?=
 =?utf-8?B?NG5rZUduNk1SNFJBdyt1clQ1WGhBZDY4R3o1eThuSWdZVWpnK2xTRzV1OHQr?=
 =?utf-8?B?eEtieXkyYzY5eHdqL3prb0Roa3BlZ2xTaXpEV25rRDFjSllRNFNBU2tyTnY3?=
 =?utf-8?B?UzZxWmRwQmhsUGZabkt2YkNJZVJXOU1lZElEZlNzZVI4NmtSV0hjTS9EQWZL?=
 =?utf-8?B?QjVCcnBrdWpaTDVtTW1FMHY1UXJaU1owUTcxN0pNbXdkb2dVdVFtWFJXR0Nv?=
 =?utf-8?B?YU9iL1NVUHpSVi82YUFjNGJrQ1FXd0I2TG9zTjFzQnJxVmRudkEyZGE5Z1hp?=
 =?utf-8?B?Y3JxMmJqRkVxL1BYZHM4L2lvZWtTSlZCU2RRRVp0ZGU2UGV3ZlJnZ1A0SEla?=
 =?utf-8?B?eFJBTmh3RWZLd05XMzQ5dVl2N2l4OUQwek1yYmt2b3NJWDJ1R1IyQWlMSkRD?=
 =?utf-8?B?dDRWdWRIKzRwVmhnQnY4Ry95QnlWNjNZQTYwaitXZGg0WEoyZzhUWXpVODFK?=
 =?utf-8?B?dkxOTXRSd3VjMURXcXdBRm5RcWpHSWhxT21sVjBvZG1mQnhsUGlrc3NKMXBS?=
 =?utf-8?B?c3ZZazRjcjBieGp6bmhFNW9vbGFyR1FqakVzVCtDaGUwZjNWc3RUVklqWGo1?=
 =?utf-8?B?TTBvSUQ2cEhVZWtJWE1WeTFOYUNvOHdVNWg0V1o0WjJHWnY1TC9YbG9hbEtK?=
 =?utf-8?B?ZFdnYjAxV1prNUdRMFNSOGNKNDRZR29FVnZPM3pNMnlBZ2dkdmpCVDVua1cw?=
 =?utf-8?B?aGR4ZFZCblM0RVliVGdaN0s0YU00VkhVTVg0dEV0RzFSeG5oWDBCYVBKZk16?=
 =?utf-8?B?Y0t2R1dXTFJpWTJnajNZMGY0RkRkVTNPYktPK01taGR0RDQ3SFM4RnRKTjRX?=
 =?utf-8?B?aE5KZExjN0dYb3NWWG41dWp5S0R1U1d5Vmx1bnpGYXRoSk45b2lOalFlekFJ?=
 =?utf-8?B?ajkwQnMvWjIxL3Z2T0djMGdLcTlrVzJ5TWc1YS9qSml6SE83M0sxWFZ1SSt3?=
 =?utf-8?B?clRtWllmMy9GV1BtUGFaOTl5Tmo1ZkJoK0hQdDVQU2ZqTW9KSmFLYno4SVZD?=
 =?utf-8?B?dEtJaFhqWkxCcTE1ZTRVMkJDOVRaTXNhVWFrSlBqemcvK203ZlhEQWF5eHZp?=
 =?utf-8?B?c1NJTTNaQzBHYlpJZE4rcHJnTWNZNzZOdTJDanp1ZFVSZ1U1SmRJVzNMZHVM?=
 =?utf-8?B?ZFY3RWYvWE1LT0ZmSjBkUEVKd1hUajZzYzVXdWdlR0l0THAvejlYakxSRzRP?=
 =?utf-8?B?Y0xubzBiZW1vcHRYdnIzMjQxb3c5R21PZ3RlS2h6VU1VUW1Nd0xQdUo0cllN?=
 =?utf-8?B?NmZyVVp6OTladXRDeVJDMlJBL2p2VlFuNVdUdmhnK2l3aE9CRmJEMEZYWjg4?=
 =?utf-8?B?NlFUWWZ3bFZselBQNzBGV3M1MytuSlNkQkVGY1M0NWZlKzhXK0diZDUvd0lF?=
 =?utf-8?B?MERQczBiV2duUy91WUt6MU9xaUNBaEd1VWJ5ejZlS1RBWFcxaTNTeUhSNkRt?=
 =?utf-8?B?ZlM0VFM4aVByb3hmclhmUHZ2OU1taWU2QlhYa3Y3QSsxTTliK09hcTcweG8x?=
 =?utf-8?B?UjRlZSt4VWhOOVdsWWptRGVyOWpiZ2FUeTFnSnhCTWxXZHhORlJvMFBLNW03?=
 =?utf-8?B?b3UzVkwwZUZ3M1JSUVkwdWlhZElobVdDTG5tbnBDcm9ZWTVNbVJRbE9YbVF4?=
 =?utf-8?B?SWtWZEVEb2xmTDNrOU1WbUFHdHNVb3ZDVTFDcyt6QUtVVXUraFNqQW1kbnJt?=
 =?utf-8?B?eDZ0QzhQdlRlSkc3TndNZVdVMlVaL2RZT3g0U1pSR0p3TTRxSUY0cktkWjhI?=
 =?utf-8?B?RU9UV3Q4d2JQTHA4RUErNGRFRkRNYURsOGFFc0MrUDQ2Nlg2UWZhQXk0c3pN?=
 =?utf-8?B?QlJrVEZubmlHS2laV3JrcXo5ajI1MXhnZXlDK3BtZTNmY3NST1cveFVISEtP?=
 =?utf-8?B?am9NRG5RMGVnZzZmYVJ3UzRCeEwxeEl0aEV0djlhTFVEWFJXQWNLeHlYUFB3?=
 =?utf-8?B?dTdMNFZZcHZHbzA0VnNRelloTXdvZ29SNUNtTWg3MW5Sbi9FdzV1Rmx3eW1q?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9447A8921A657C41BA517B0F61D36CEC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216c6451-d305-45b2-366c-08db7c32947b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 02:01:28.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQ6kGhagqydQMwX3+KPRrpu0JOZFGCKf5t2Vymq91UaifuVNUijjyklIBsU548LCSyOE3evH555kJri1TQPHvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5907
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTAzIGF0IDE0OjI3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIElsIDMwLzA2LzIzIDEzOjAwLCBNYXJrIEJyb3duIGhhIHNjcml0dG86
DQo+ID4gT24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDU6Mjk6MjNBTSArMDAwMCwgVHJldm9yIFd1
ICjlkLPmlofoia8pIHdyb3RlOg0KPiA+PiBPbiBUaHUsIDIwMjMtMDYtMjkgYXQgMTY6MDYgKzAx
MDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+ID4gDQo+ID4+PiBUaGlzIGNvbW1pdCBtZXNzYWdlIGlz
bid0IGVudGlyZWx5IGNsZWFyLiAgVGhlIGVmZmVjdCBvZiB0aGUNCj4gY29tbWl0DQo+ID4+PiBp
cw0KPiA+Pj4gdG8gcmVzdHJpY3QgdGhlIGNvbmZpZ3VyYXRpb25zIHN1cHBvcnRlZCB3aGVuIHVz
aW5nIGEgbmF1ODgyNSBidXQNCj4gPj4+IGl0J3MNCj4gPj4+IG5vdCBjbGVhciB3aGF0IGEgbmF1
ODgyNSBoYXMgdG8gZG8gd2l0aCB0aGlzIG9yIHdoeSB3ZSdyZSBkb2luZw0KPiB0aGlzDQo+ID4+
PiBpbg0KPiA+Pj4gZ2VuZXJhbC4gIFdoYXQgZXhhY3RseSBkbyB5b3UgbWVhbiB3aGVuIHNheWlu
ZyB0aGF0ICJvbmx5IGENCj4gbGltaXRlZA0KPiA+Pj4gbnVtYmVyIG9mIHBhcmFtZXRlcnMgYXJl
IG5lY2Vzc2FyeSIgYW5kIHdoYXQgbWFrZXMgdGhpcyB0aGUgY2FzZT8NCj4gPiANCj4gPj4gRm9y
IGluc3RhbmNlLCBzb21lIHVzZXJzcGFjZSBmcmFtZXdvcmtzIG9ubHkgc3VwcG9ydCBzcGVjaWZp
Yw0KPiBzYW1wbGluZw0KPiA+PiByYXRlcyBzdWNoIGFzIDQ4a0h6IG9uIENocm9tZWJvb2ssIG1h
a2luZyBvdGhlciBwYXJhbWV0ZXJzDQo+IHVubmVjZXNzYXJ5Lg0KPiA+PiBCeSByZXN0cmljdGlu
ZyB0aGUgY29uZmlndXJhdGlvbiwgdW5leHBlY3RlZCB1c2FnZSBjYW4gYmUNCj4gcHJldmVudGVk
IGFuZA0KPiA+PiB0aGUgYWxzYV9jb25mb3JtYW5jZV90ZXN0IHByb2Nlc3Mgd2hpY2ggY2hlY2tz
IGFsbCBwYXJhbWV0ZXJzDQo+IHByb3ZpZGVkDQo+ID4+IGJ5IGFuIEFMU0EgZHJpdmVyIGNhbiBi
ZSBzcGVkIHVwLg0KPiA+IA0KPiA+IFRoYXQncyBhIHVzZXJzcGFjZSBwb2xpY3kgZGVjaXNpb24s
IHdlIHNob3VsZG4ndCBiZSBlbmZvcmNpbmcgdGhpcw0KPiBpbg0KPiA+IHRoZSBrZXJuZWwgLSBl
dmVuIGZvciBDaHJvbWVib29rcyBwZW9wbGUgY2FuIGluc3RhbGwgb3RoZXIgT1NzIG9uDQo+IHRo
ZW0NCj4gPiB3aGljaCBtYXkgbWFrZSBkaWZmZXJlbnQgZGVjaXNpb25zLCBhbmQgaXQncyBhbHdh
eXMgcG9zc2libGUgdGhhdA0KPiB0aGUNCj4gPiBDaHJvbWVPUyBwZW9wbGUgbWlnaHQgY2hhbmdl
IHRoZWlyIG1pbmQgbGF0ZXIuICBJZiB0aGV5J3JlIG9ubHkNCj4gPiBpbnRlcmVzdGVkIGluIHRl
c3RpbmcgNDhrSHogYW5kIGl0J3Mgc2xvd2luZyB0aGluZ3MgZG93bg0KPiB1bnJlYXNvbmFibHkN
Cj4gPiB0byB0ZXN0IG1vcmUgdGhlbiB0aGV5IHNob3VsZCBqdXN0IG9ubHkgdGVzdCA0OGtIeiBy
YXRoZXIgdGhhbg0KPiBjaGFuZ2luZw0KPiA+IHRoZSBkcml2ZXIgdG8gd29yayBhcm91bmQgaXQu
DQo+ID4gDQo+ID4+IFdvdWxkIGl0IGJlIG1vcmUgYmVuZWZpY2lhbCB0byBlc3RhYmxpc2ggdGhl
IGNyaXRlcmlhIGFzIGEgZ2VuZXJhbA0KPiBydWxlDQo+ID4+IGZvciB0aGlzIG1hY2hpbmUgZHJp
dmVyLCB3aGlsZSBsaW1pdGluZyB0aGUgdXNlIG9mIHRoZSBtYWNoaW5lDQo+IGRyaXZlcg0KPiA+
PiBzb2xlbHkgdG8gdGhlIENocm9tZWJvb2sgcHJvamVjdD8gT3IgZG8geW91IGp1c3Qgc3VnZ2Vz
dCB0aGF0IEkNCj4gYWRkDQo+ID4+IG1vcmUgZGV0YWlscyBpbiB0aGUgY29tbWl0IG1lc3NhZ2Vz
Pw0KPiA+IA0KPiA+IEkgdGhpbmsgd2UganVzdCBzaG91bGRuJ3QgZG8gdGhpcywgaXQncyBwb2xp
Y3kgZm9yIENocm9tZU9TIHJhdGhlcg0KPiB0aGFuDQo+ID4gc29tZXRoaW5nIHRoYXQncyBhY3R1
YWxseSBuZWVkZWQuICBJZiB3ZSB3ZXJlIGRvaW5nIHRoaXMgaXQgd291bGQNCj4gbmVlZCBhDQo+
ID4gbXVjaCBjbGVhcmVyIGNvbW1pdCBtZXNzYWdlIGFuZCB3ZSBzaG91bGQgYmUgcmVzdHJpY3Rp
bmcgdGhpbmdzIHRvDQo+ID4gQ2hyb21lYm9va3Mgb25seS4NCj4gDQo+IEkgYWdyZWUgd2l0aCBN
YXJrLiBFeGNlcHQgZm9yIG1lIGl0J3Mgbm90IGEgKnNob3VsZCBub3QqIGJ1dCBhICpzaGFsbA0K
PiBub3QqLg0KPiANCj4gU3VjaCBvdGhlciBjb25maWd1cmF0aW9ucyBhcmUgc3VwcG9ydGVkIGJ5
IHRoZSBoYXJkd2FyZSBhbmQgaXQgaXMgdGhlDQo+IGRyaXZlcidzDQo+IGR1dHkgdG8gc3VwcG9y
dCBhbGwgb2YgdGhlbSAtIG90aGVyd2lzZSBJIGRlZW0gdGhlIGRyaXZlciB0byBiZQ0KPiAqaW5j
b21wbGV0ZSouDQo+IEl0J3MgdGhlbiB0aGUgdXNlcnNwYWNlJ3MgZHV0eSB0byBwcm9wZXJseSB1
c2UgdGhlIHNvdW5kIEFQSXMgYW5kDQo+IHJlcXVlc3QgdGhlDQo+IHJpZ2h0IHNhbXBsaW5nIHJh
dGUgZm9yIHNwZWNpZmljIHVzZWNhc2VzLg0KPiANCj4gQ2hyb21lYm9va3MgYXJlbid0IHNwZWNp
YWwgYXQgYWxsIGluIHRoaXMgcmVnYXJkLg0KPiANCj4gDQoNClRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9uLg0KQWZ0ZXIgdGhlIGludGVybmFsIGRpc2N1c3Npb24sIHdlIGRlY2lkZWQgdG8gZHJv
cCB0aGUgcGF0Y2guDQpPbiB0aGUgb3RoZXIgaGFuZCwgSSB3aWxsIHNlbmQgYW5vdGhlciBwYXRj
aCB1c2luZyBkcGNtX21lcmdlZF94eHggdG8NCnJlcG9ydCB0aGUgYWN0dWFsIGNhcGFiaWxpdHkg
b2YgaGFyZHdhcmUuDQoNClRoYW5rcywNClRyZXZvcg0K
