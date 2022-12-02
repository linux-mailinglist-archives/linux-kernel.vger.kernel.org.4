Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D85640590
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiLBLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:13:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A42CCECB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:13:42 -0800 (PST)
X-UUID: 04ff5585279f4a318a21b30f6a212ef1-20221202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eteZViennRHsHFNcIMNDK0yPrAXETr/EL87Q5JCYv64=;
        b=lygKcUSXfJATYPcyX3yu/gntLHgRzNO1kBG8DtfC4EVgeGvpfz7rhJ4azUMtsMJCSez2Dwn8SBNvF+PQc1/Daa2v4t9k41Vg3CakUSm43suzzsDRIb1vJaVj+KyNzC3gmW/7isllJz6SYjGKVcUSzDKqbevv4ZSuL0jnOn06D88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f6d87561-8a7c-4f9e-80fc-1138b6c14231,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:eb048130-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 04ff5585279f4a318a21b30f6a212ef1-20221202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1913969841; Fri, 02 Dec 2022 19:13:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 2 Dec 2022 19:13:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 2 Dec 2022 19:13:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaC7e94GwnPUsSog7UyixPC+ipsRcXKUP4IQZw6Bge8X9ngv5/1H/DbRPopOOYqp7bdPRKukuvfLJLwfIDN59lnLKkosFjkjwNAb4H5hTvD2U3bSIDZ6T5JCFfTFlFgmlRHVAk0e4IObwjSWQW1Gpx4lmk2oYoNLFQFwbXUfG2os6rOkzlZ8Wjw4Dgy33SIMI5RF7xVoJiG/X4c3In3XQ+/YOPCsxRCw8uFY4vKp9mka7FxzkrHOsMBH8ALeyM+rNs2uTC0KlYhscjgr6e37KeiXxTk9LmaQGWntj/jAUwhOv3XxH9ba3CPb94RBzZMPUHYR1OORFmM2LDe6ix7myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eteZViennRHsHFNcIMNDK0yPrAXETr/EL87Q5JCYv64=;
 b=mOdsYXbPypxdTs06IO4fdBBStfiVmkGySoPDAoKH0J3D0CkimGtK6jM3zxHyy5V7ku5UtyP69M5XiE95y5yoKCf6Vf8A5V9F47eA8va//vibr7KF4hdHOLacInal/+uE824bJEz3gVWh1bV49RHLQ631TLu+/D7Nw0RX3QzcxPSV/hY6grm0aOp4xvv3aZllcJbb2LmQkf2KHC9i3z/Gsn1+Y3+4V13Mwv69OozM12dBZN01kx6fPJnincZoIADIDGNg8jwddvfJvxzrrKd0Qmzzlnbf9JKWLuQvNhs4u0NHpJNcxKnIlQta2cFAsgFoViwkVPcOfgYiDJGlSFr+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eteZViennRHsHFNcIMNDK0yPrAXETr/EL87Q5JCYv64=;
 b=THGtOgnkDov4cbdwNko7qT0KF71fTYwNK2EaoYIPIAj9W2pdOEdYTWUhbdlIcdMbm2Cu3D8Qst4cDqv1JUSUeCQThD9W6nSM1/c5cjxsk4HibqgDv1FzJqB+9oMTJUK2/4N3F4uRo8qxOAU/LUbSwr5GXnLgtLxoUiRMsYOAb3Q=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 11:13:32 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::7579:391a:7de5:2399]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::7579:391a:7de5:2399%7]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 11:13:31 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Topic: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Index: AQHY3g/idaSasqXP7E+kkGotWaHzpK5MjisAgAAF0gCADi4aAA==
Date:   Fri, 2 Dec 2022 11:13:31 +0000
Message-ID: <ece0356f5e184e87a6d5e1fc5ca7fa1a3d203c13.camel@mediatek.com>
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
         <ce1c6a1a-9183-e56d-6757-947f5fc8133d@gmail.com>
         <d4856589cdbb8ba31d5139604abffa4a06c5c73b.camel@mediatek.com>
In-Reply-To: <d4856589cdbb8ba31d5139604abffa4a06c5c73b.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|SI2PR03MB5260:EE_
x-ms-office365-filtering-correlation-id: 70ff0073-fa6e-45de-0bc0-08dad4563f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6+nGH2R65Gki+aWgYd4MtJ8CfcbEIfPiLDkEJ8Vj4ccgH6CdPu4de0ksgs5oqpIPQQ0REHQdNC/Gb7h3i+IcH5Bz2q/ZcNN0JI+SYyda3eibG0G/gKP9VOEwHikSn1JlWtG7ESxsJDeDsw+hfqdw5NQ4b2dCrRlaaT0POBg0TGg4fEJTceFYNX3ukl1q1Jc4aes1EceU9RkWzKWvxrJXxykDIEffMBw9yz5yZUhQ2BahLQs/s0/O+JWEIvA+8mQEeAUSMJ7S9qArpS2+6GuAudA+0ZzEvDP69jANdmx4KnvHbylo052NCask01fiDh72gr1bgYg5NCmeU+H1drobrQcso02pHJ0Y1sBykHADXGKLDVc9zWsadnQQHfmJg6Sa6bsMUexmQCz2kSE+KyZT/MH8hC5ROFh9xDJDYvl9eOclSD24oluAomvad8H60DZ1VaOyAGXVlIWn+6fN9yZRyXTFoM57X3vn0Lr5so86IwCR05hzpfI/ChfGGvy6aDrgNPoXQoU68yTGJgpN5aoWGBjI+17dujnFkfc4q5VF4l92/BmWcpDpn8dy3KW0Ae7HMa3fDa+JkLQA2v8SDCTplFVQ1t+XG3uKoGPqAoqlrwdekmJs/s8NHcuDttazTk5kCn9sTlhHPc89owoC4CgORoE0sKNnx/6yQaxbn1Q+JvLiwOmGf5CXuNMOWYIPru1LUGgVfq4HhaSxXl+lBUfow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(6506007)(53546011)(107886003)(6486002)(54906003)(6512007)(186003)(26005)(478600001)(316002)(6916009)(91956017)(64756008)(4326008)(66446008)(76116006)(8676002)(66476007)(66556008)(66946007)(71200400001)(83380400001)(2616005)(5660300002)(8936002)(85182001)(2906002)(36756003)(41300700001)(4001150100001)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG8zWmM5MlBxUW5odnFQdW96cE1aMnMvOTB3TUtFT05hQmRBZThacXovcVli?=
 =?utf-8?B?dlZxUHRyMmFybUhYeVBQVGdSaVhnT29zYWl6UVF4UU91S3poeCtGdnlkVEJT?=
 =?utf-8?B?VE5ZdXQ0QUJzSjR4UUFna3A1dnRCNkhqSWcxSVFDeVNZVk8yanU1TWt6Q3p0?=
 =?utf-8?B?ckdtY0p5azJDbTROcHI1TTJxOE05UzAveWJXM1gyQW5KdHM0c1hJcTNBa2w0?=
 =?utf-8?B?UGtxcmx3c01TQy9qRmU4TG9WcWRieVpublpmRGR6a1NZWndBeEVSQnUwaXp3?=
 =?utf-8?B?YURDTFJuQzNETm43RjU2Wk9UN3J6bitrUU9lL0hEQlF3RS9mcll6N3FvaW9i?=
 =?utf-8?B?VktIZWRDWmR4cEZhdElTTXRLUXYyaThMNU9vWFdqdGczd0NGV05QWlNHamZ4?=
 =?utf-8?B?cDhEL0FpNjVzRno1U010SEduNGY3VmRVVERMSkZ6NXpzc3JQVUxLOVY0MDk3?=
 =?utf-8?B?ZWhiM2VROWVjeXZ6Qmp2djNQbmgrMVUxWDRQai9SOUREOHRpc1h4aXFDSXRY?=
 =?utf-8?B?R2txWHVjOGZEVGw5ZlFwWXFuTW9JTWhNdlJnWTJONy9qZERDc0F5a1NqY1BR?=
 =?utf-8?B?S1NGcHUrZUV1NHBUcHAxa3hoSEVKVU83NzBWKzJPRjBYOEJTL3RlUkNFQnJr?=
 =?utf-8?B?SHBUUnN5Q1ZKTTRRWVVyeG9XOEMyQmpaWTlqSiszZVpmMkwrcWFCUnY3MkFW?=
 =?utf-8?B?amFRc2dMRTN0SVhxbWNwVnEzb2JWa2dmYnBSTnFTRldmQjlScUc0S1lXR2Jm?=
 =?utf-8?B?WUFDWGtNai9NbEhyb1E5UUxHWGlqa0FqOGpCS0xpQWU2cVpMU0FGQVduQ0J0?=
 =?utf-8?B?YkR6RUxyc1F1NUZlN3loZjYvcVlGT3luTVo3blJEcm9lb3FBZEVxdkNKVTFY?=
 =?utf-8?B?SHJoaERqdytzZXZQY1NHOGgxalpFeGM1Z0c0ajcvZGN4STgzeW4zQVNCUDZH?=
 =?utf-8?B?ZmhSSjlWbHM4ZmNKVFdpb3JMamFRTjBjenFvSVNmOEJBR3hvWktmRWIxYVoz?=
 =?utf-8?B?TkhZNVd2K2t4OVNVNGIydUJOdmVNNHlHbnFCbjJyeGo4dkVQL1RJbW9adzhS?=
 =?utf-8?B?aThpcmhnbUJVMUZEVENqRDJiMVBqQkVmRGJLdEF5eVFvd1J5V1FXdlVJbHNV?=
 =?utf-8?B?RFYxN0cyTFEwZnRvK3pXUVBEK3FpWnQ2MVJMclF6VGhRQUMzRkJVclRCL2dE?=
 =?utf-8?B?cm43TkI2emRZaVBzeVhrZ2RWYkhVUWJlTklUN3pYdmJ4RU42WExkL0ZUelJw?=
 =?utf-8?B?M0YvcWFIZDNaL21sQnNDVlV4L05KVjJNMHV2QzRvNll4L2VZRG1pZDUzeERV?=
 =?utf-8?B?SVZwWkFLUEp1MWljL2U5bWw1UkhsT2JtNnFBcGZRb0xVanViUGFEL3JQU2Vl?=
 =?utf-8?B?clRnZVdNWmZ4V21xM2xYc0ZhcG5RQlFBRUt3ays5S3R6ZTFxbWFUR3Z2YVZ3?=
 =?utf-8?B?dVJrWVBHalV0QUNmMVN3NU5sMWNQQkwvRmVKbE9DcDg0YXhGMXdFcGMzbXl4?=
 =?utf-8?B?L0RHTTd2WlNnSHJEcWQrcS9Na2ljQmduR216K0VXQjRpek9XbzRBdDdmanNt?=
 =?utf-8?B?OHZQM3RaNTBCNWFLcENUcisxdVFpcFp6RVkraCs4dTJTSVk3b2IyWnl1T3Bl?=
 =?utf-8?B?eHBjcWNKZmNjb1kyMnEvOWVRazdqS09FakFnU004b2xBc1JlcjdIZWRNWTNu?=
 =?utf-8?B?UTMvNjZabXdpRFEyTmc0U2U3L3QvYzNSSmN1RDlnTG9ReXZtVWtRaGYvaHZU?=
 =?utf-8?B?OVpQamIxVmFZWDhLWDZrelFkSEg0L3RJSjMxaVQvVUFoN09SbFdWZmkvQ1Az?=
 =?utf-8?B?QzM4MW1lVnBhc01kUUZ2Tm50TjB6L3dIV1JKb0ZRRlhQbnpZWllwNFBOOFEw?=
 =?utf-8?B?THl6cW9UTjFEcWlLWmVTNUhWMklVTllrQW92VHVuNXRjWjJYbnREMC9qSWdE?=
 =?utf-8?B?dUw2SXA5VXAybXRhNVlRM1ZDRG1nMFB2eEhHb1E2SE02ZkRKNXY2M3hXT3VF?=
 =?utf-8?B?VG9EeFRCWkZrZDVHa2JYRnUwdFJFclhIZUNnVVVGUkR5ZFEwSVg3Z0FZeXB0?=
 =?utf-8?B?QTRWOHRpelhXeW1jekkwK1owTjFsVzJBc3EwenFIcVZFalZJZkhPWHBzT3ZB?=
 =?utf-8?B?bUQrYVAzSTY2UWU0NFJydHdGajJ0NGxKV2s2WXVmT0RpaFM3d250NDQ3Nk4y?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E073FE24A5F52747B7AA717E7CB51C0D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ff0073-fa6e-45de-0bc0-08dad4563f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 11:13:31.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peQW/IvrchFlktTDCSAOk592EMgEt6rrjiPl4Pc1aV52q8XQ3O0wedflXqlz6MQuL4Q2J6hqgwcQzPfhwMNopUEJYuChPfZhI4hU3WS54tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCk9uIFdlZCwgMjAyMi0xMS0yMyBhdCAxODo0MCArMDgwMCwgVGluZ0hh
biBTaGVuIHdyb3RlOg0KPiBPbiBXZWQsIDIwMjItMTEtMjMgYXQgMTE6MjAgKzAxMDAsIE1hdHRo
aWFzIEJydWdnZXIgd3JvdGU6DQo+ID4gDQo+ID4gT24gMTIvMTAvMjAyMiAwOTo1NCwgVGluZ2hh
biBTaGVuIHdyb3RlOg0KPiA+ID4gSW4gdGhlIHVzZSBjYXNlIG9mIGNvbmZpZ3VyaW5nIHRoZSBh
Y2Nlc3MgcGVybWlzc2lvbnMgb2YgdGhlIEFEU1AgY29yZSwNCj4gPiA+IHRoZSBtdDgxODYgU29D
IEFEU1AgcG93ZXIgd2lsbCBiZSBzd2l0Y2hlZCBvbiBpbiB0aGUgYm9vdGxvYWRlciBiZWNhdXNl
DQo+ID4gPiB0aGUgcGVybWlzc2lvbiBjb250cm9sIHJlZ2lzdGVycyBhcmUgbG9jYXRlZCBpbiB0
aGUgQURTUCBzdWJzeXMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmdoYW4gU2hl
biA8dGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBEbyB3ZSBuZWVkIGEgZml4
ZXMgdGFnIGhlcmU/DQo+ID4gTXkgYmV0IGlzOg0KPiA+IEZpeGVzOiA4ODU5MGNiYzE3MDMgKCJz
b2M6IG1lZGlhdGVrOiBwbS1kb21haW5zOiBBZGQgc3VwcG9ydCBmb3IgbXQ4MTg2IikNCj4gPiAN
Cj4gPiBPciBpcyB0aGlzIG5vdCB5ZXQgYSBwcm9ibGVtIGJ1dCBuZWVkZWQgdG8gYmUgYWJsZSB0
byBpbXBsZW1lbnQgYWNjZXNzIA0KPiA+IHBlcm1pc3Npb24gY29uZmlndXJhdGlvbiBpbiB0aGUg
QURTUCBkcml2ZXI/DQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBNYXR0aGlhcw0KPiANCj4gVGhp
cyBwYXRjaCBpcyBuZWVkZWQgdG8gZml4IGEgd2FybmluZyB3aGVuIGltcGxlbWVudGluZyB0aGUg
QURTUCBhY2Nlc3MgcGVybWlzc2lvbiBjb25maWd1cmF0aW9uIGluIHByZWxvYWRlci4NCj4gDQo+
IAlbICAgIDAuMzM0MTU0XSBtdGstcG93ZXItY29udHJvbGxlciAxMDAwNjAwMC5zeXNjb246cG93
ZXItY29udHJvbGxlcjogL3NvYy9zeXNjb25AMTAwMDYwMDAvcG93ZXItY29udHJvbGxlci9wb3dl
ci1kb21haW5AMTgvcG93ZXItZG9tYWluQDE5L3Bvd2VyLWRvbWFpbkAyMDogQSBkZWZhdWx0IG9m
ZiBwb3dlciBkb21haW4gaGFzIGJlZW4NCj4gT04NCj4gCVsgICAgMC4zMzQyNDZdIC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiAJWyAgICAwLjMzNDI1Ml0gdG9wX2Fkc3Bf
YnVzIGFscmVhZHkgZGlzYWJsZWQNCj4gCVsgICAgMC4zMzQyNzRdIFdBUk5JTkc6IENQVTogNSBQ
SUQ6IDExMyBhdCBkcml2ZXJzL2Nsay9jbGsuYzo5NjkgY2xrX2NvcmVfZGlzYWJsZSsweDkwLzB4
YjANCj4gDQo+IElmIG5vdCBmb3IgdGhpcyBjYXNlLCB0aGUgcG0tZG9tYWluIHdvcmtzIGZpbmUu
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBUaW5nSGFuDQoNCmdlbnRsZSBwaW5nIGZvciB0
aGlzLg0KZnJvbSBhYm92ZSBkZXNjcmlwdGlvbnMsIHNob3VsZCBJIGFkZCB0aGUgZml4ZXMgdGFn
IHRvIHRoaXMgcGF0Y2g/DQoNCkJlc3QgcmVnYXJkcywNClRpbmdIYW4NCg0KPiANCj4gPiANCj4g
PiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9tYWlucy5o
IHwgNCArLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ODE4Ni1wbS1kb21haW5zLmggYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9t
YWlucy5oDQo+ID4gPiBpbmRleCAxMDhhZjYxODU0YTMuLmZjZTg2Zjc5YzUwNSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4Ni1wbS1kb21haW5zLmgNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4Ni1wbS1kb21haW5zLmgNCj4gPiA+IEBA
IC0zMDQsNyArMzA0LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzY3BzeXNfZG9tYWluX2RhdGEg
c2Nwc3lzX2RvbWFpbl9kYXRhX210ODE4NltdID0gew0KPiA+ID4gICAJCS5jdGxfb2ZmcyA9IDB4
OUZDLA0KPiA+ID4gICAJCS5wd3Jfc3RhX29mZnMgPSAweDE2QywNCj4gPiA+ICAgCQkucHdyX3N0
YTJuZF9vZmZzID0gMHgxNzAsDQo+ID4gPiAtCQkuY2FwcyA9IE1US19TQ1BEX0tFRVBfREVGQVVM
VF9PRkYsDQo+ID4gPiAgIAl9LA0KPiA+ID4gICAJW01UODE4Nl9QT1dFUl9ET01BSU5fQURTUF9J
TkZSQV0gPSB7DQo+ID4gPiAgIAkJLm5hbWUgPSAiYWRzcF9pbmZyYSIsDQo+ID4gPiBAQCAtMzEy
LDcgKzMxMSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbl9kYXRhIHNjcHN5
c19kb21haW5fZGF0YV9tdDgxODZbXSA9IHsNCj4gPiA+ICAgCQkuY3RsX29mZnMgPSAweDlGOCwN
Cj4gPiA+ICAgCQkucHdyX3N0YV9vZmZzID0gMHgxNkMsDQo+ID4gPiAgIAkJLnB3cl9zdGEybmRf
b2ZmcyA9IDB4MTcwLA0KPiA+ID4gLQkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZG
LA0KPiA+ID4gICAJfSwNCj4gPiA+ICAgCVtNVDgxODZfUE9XRVJfRE9NQUlOX0FEU1BfVE9QXSA9
IHsNCj4gPiA+ICAgCQkubmFtZSA9ICJhZHNwX3RvcCIsDQo+ID4gPiBAQCAtMzMyLDcgKzMzMCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbl9kYXRhIHNjcHN5c19kb21haW5f
ZGF0YV9tdDgxODZbXSA9IHsNCj4gPiA+ICAgCQkJCU1UODE4Nl9UT1BfQVhJX1BST1RfRU5fM19D
TFIsDQo+ID4gPiAgIAkJCQlNVDgxODZfVE9QX0FYSV9QUk9UX0VOXzNfU1RBKSwNCj4gPiA+ICAg
CQl9LA0KPiA+ID4gLQkJLmNhcHMgPSBNVEtfU0NQRF9TUkFNX0lTTyB8IE1US19TQ1BEX0tFRVBf
REVGQVVMVF9PRkYgfCBNVEtfU0NQRF9BQ1RJVkVfV0FLRVVQLA0KPiA+ID4gKwkJLmNhcHMgPSBN
VEtfU0NQRF9TUkFNX0lTTyB8IE1US19TQ1BEX0FDVElWRV9XQUtFVVAsDQo+ID4gPiAgIAl9LA0K
PiA+ID4gICB9Ow0KPiA+ID4gICANCj4gDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNClRpbmdI
YW4NCg==
