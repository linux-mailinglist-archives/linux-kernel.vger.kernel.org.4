Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED736B8E79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCNJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCNJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:20:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62B7EA0A;
        Tue, 14 Mar 2023 02:20:09 -0700 (PDT)
X-UUID: 6800ba00c24911ed945fc101203acc17-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ChHL9LkGzDKEoEGKgEfI9aoosHdD/XYZBPnadctPEio=;
        b=mvOF6X87RB7UfF8W2W4rnAh1ruCiK+1mBmRTjZ3sPfGXj+nYcch4ixVAmUWSbWe1uRJ/inoxT6pGlCy1ccGG10i2Qkxhyy+tCvTEzK8xnTVJdn0AlzMguGaut5fa/MKZAH8vRN7L8ByB2jEjOGwsYuAyTd2KsJvrxT4TWHDXkoU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:577e3244-da91-4f8d-a8cd-b3ca92febfaf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.21,REQID:577e3244-da91-4f8d-a8cd-b3ca92febfaf,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:83295aa,CLOUDID:531133b3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230314100424BSE4LX3U,BulkQuantity:9,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OS
        A:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 6800ba00c24911ed945fc101203acc17-20230314
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1043696467; Tue, 14 Mar 2023 17:20:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 17:20:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 17:20:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJqus6DsL34oLuTNjVjxpAOThtkAUCwEGs1BV5GqMMrRJ+Q8P4ffPWVdyqqkz0ESdcYhEL017DQr5fWuL0Bh03Cnb+UTM4h3sfBXcQoKWREWP/Cam+SH+pTYbh4cuFdWMOZt5ku7qXE+nAh0Ghs/PUsxGwFV2u4oX3CVOJ20Wdmeto4SsLajYlgvdB6X4ppLX92TNLttW+I4es+dwEJaPdi8+9su5BFzyKWtJZyxzpaUz8sjeVf8NfNjN0727AZXLcxl4hQDn7i/pRShCVOCMXzJijtUDspIn66AKdUcSER+ZOg2kKfgEdKZyK7OXULaeZTVjGebf3iUuPzRx/FpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChHL9LkGzDKEoEGKgEfI9aoosHdD/XYZBPnadctPEio=;
 b=Tghj0EO83zsbUjT7p5/z3SjxweR/294ZeAsz9ilwDBH2wZYWlVLuXqAiI3H2QKNq0uS/bOAj1BAmWBkZbGtBc4Vqrbl8HmB4KYD9uMARI/HOXkTdD2AzzNrD3qqRSwhbJKDsT+O3413bBq530TI69iNYWnsTXxmGzg7u4JRa1nv89wmJVaSm+BF7uqwKfwcW+7WCTNziQAwjHRYZV/v/eTLhmdqcdCQ6T/9+D+Xu9WTvqB7p4CDEuZdyjmD6X99UNvBS+vz40wBSKAqlkdICxmRacChZUYFh7CTthhL97JP8OQfgqcxdvgBAybyxXHkiG52tx4cao0ZSF04RI2WC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChHL9LkGzDKEoEGKgEfI9aoosHdD/XYZBPnadctPEio=;
 b=KgIKypzS9duOLOJ8iFssxslgiC2XDkuYTxmojKY0+cOOWck53+byMn7fUK+zeE/yOboHgPwalMqZX1aiILYMsDFd4Q89puDwJuvOj2bGra0pcUTRQdGwGCQveia3POOKKpwYcnPK8A+PZcsq9ZmC3M7sjuV1TrfTNN1WlpQtwlA=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB5751.apcprd03.prod.outlook.com (2603:1096:301:84::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 09:20:01 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 09:20:01 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v2] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZPRRh7fZS99I5qEegpearM3gM+67IULWAgAVs3YCADczZAIAGnpqAgALd1ACAFStKgA==
Date:   Tue, 14 Mar 2023 09:20:00 +0000
Message-ID: <0f4a279beb8bf442c5eec41957d0bf2db36d31b7.camel@mediatek.com>
References: <20230210055518.6017-1-yunfei.dong@mediatek.com>
         <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
         <f6148f4c4864d324b52a52cc87b8785d958ceeb5.camel@mediatek.com>
         <20230222211154.mhl7mihycl7eq5v6@notapiano>
         <f3d53cf7bfbaf092e1020c41316668b9f53b890b.camel@mediatek.com>
         <20230228220336.gnainmcyi42l2a6r@notapiano>
In-Reply-To: <20230228220336.gnainmcyi42l2a6r@notapiano>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB5751:EE_
x-ms-office365-filtering-correlation-id: dae03db0-320c-4acc-f795-08db246d498f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vleT9dmnMOV23CgZFcSX+K/ovAtUm9mU0urItFOc6eU8q5QnPqq4+FzHqjYH3TOnYHNhKRnMDzmnMUWaDkpioCIjBTdYZsCtqxwmZGz+oGsgriz5p3oM1ALfjykZJV21G2FFbsGRKaJzYdrIq/lB/nB73RQflBzHZ8DFFQZEG60lVTnVXm9KDRUs9bJXT3jwNaPqR1FNFTT5XCtmCPOzIdIMEuouQX0WH2SFY/xAC8wf/IXdG8rBkuYGMVk6XyF+gZoGECONU+85cD0BmsXDMLnQey/KP/9A1tCSU5r9ELaRJz0w44Hm9JuM+yUNkjLkpiS7PpJ7m0BLwRQk92FmeBpcjEmaYU1t0RfXUdQIqrN8kw6mIj3GZ0eh2vdi/ToNainwGrMVyftwSN8HuEVlV9ks7vBkDA8uDh3dR5cylhhTnk30uQj1yCRRdJhr/DM0Smr5tlHpyEEX5zV0O+7P5tEz7RY0qrt83czUMVMEWFjRKqxiLXzNVuq+WMT48mKmbB0M4gdW0tvyriOkYddD5TPX8ovs3for+5LC9fwhAGxyelI6yg+va9V2Ia7PCwOHVjhC2cxNdKNvvWXrAz0hsZP+lmCLq+iSzlOO6eTqNyNQJOn6cGhvBa0qWcEyI9XiQv/5GEQgmYClYkEqMRLsjx73SvAX/2noAnKhOHLUDghcHmIR06foLb5LoTjgQo+FoReW624Fu6S05NTlawIVNT3OlCY2o3w45EwEnUGeqHcOj1yYETXU2ypV3WaDAmQ+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(71200400001)(2906002)(41300700001)(8676002)(76116006)(91956017)(66446008)(64756008)(66556008)(85182001)(4326008)(66476007)(316002)(36756003)(478600001)(54906003)(6916009)(66946007)(86362001)(38100700002)(38070700005)(966005)(6486002)(5660300002)(122000001)(66574015)(6506007)(26005)(6512007)(2616005)(186003)(7416002)(8936002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5IeUZzWTBTd3AwaHpETkJBSWhyNzVUOE4rK0k5OUE3cSsrT1dPTmU4Rjhs?=
 =?utf-8?B?dG5TZXlpSWgva0ttQTRCNlFDSmFlYjk0UjVSejZYVURVRDlrdTdMVklnaVFj?=
 =?utf-8?B?L2dyanNJeHR4Yi8yZXRjaCtpT2cyeDdzdWh5anRlZGgxL3N2TThWVml2dlZM?=
 =?utf-8?B?UEFZRy9YN0kxVi8wYUVBU0NiTVp1alhtNEF4N3JwQld0TW95ZTMvU0R2MEt2?=
 =?utf-8?B?dHArSk9HNzg4d1pZYVNIL3RpSWNjWDZMcVQ1eUFxMGtKRjlnZkVSQmRETnBK?=
 =?utf-8?B?dW5EN1lWOUlDS1NUcHE1aUFiOC9SenFKZExnU3RabTlPWWhpcDJWa25Hc0tK?=
 =?utf-8?B?THRMb2tlU1E5Y1dVRTVpcnBJeDZwU2N1cjEyemNNcTREVDRtTUhXbXBUY2xG?=
 =?utf-8?B?NGk0KzAvcEJwM1pRc3lpU2hObzBSQmNXd0t1Z283R2ZJUldJWWhsVUxUY2Na?=
 =?utf-8?B?RkpwSGRKY3pRM3BxTFRZZVA4ZVVPMzJoaE8xdGczYTNCTmcrYWJEb0FJbVVU?=
 =?utf-8?B?YWR6WGc2VGxleGxpZ0VpbXVUVDBjcGFTaVdERERwOS9yKzFjeDBjR0x6SFA3?=
 =?utf-8?B?aFdzM2c2UUZ5cTJOLzZyNTlpQUN2UVV6cmRtQnU0TTUwS1QxaDIvVk90Z3Nu?=
 =?utf-8?B?dXUzeGdxdmFkTDJwZ0tNUERDSW1qS2RVU3FDckFPYU1LREdqejhSbnpVVUND?=
 =?utf-8?B?eEE0cjhCMllzSW5TRFR0U2cwODY5ZjJXV1M3YXQ4enFjWHJNbGJsbmdiRkph?=
 =?utf-8?B?Z0NXSlYyQXlmdzA2eXRsR3BhazlFRENNT2tJK3UxVFpqZEVJL1dBVU0rcTAv?=
 =?utf-8?B?KzlSR0M4OERCSDZGd1RvQytzVC9LQTc2VE9ubkcxQzBKV25ReHF6dHlMVlYy?=
 =?utf-8?B?dUV4VGFNcnlvNG42SkJxQ1VjZTQrUjFISU1XdDhqZmc3NTZZQXE5M3BQK01G?=
 =?utf-8?B?aHcveXVJQVJndHdQaUp4aURneHdvd2tCcnA0THB5S2svRWl1MmpVZWMrckky?=
 =?utf-8?B?bGpSTkEwZ0twUzhkeDVkbGhLWURRU0NNOUpZc1VaYXZxRzZvdUI3azVhNXhk?=
 =?utf-8?B?YjFvNFRkV2F1RUZlZklXblducFVweTJJLzJLRlRWYUF2RnhPM1cxSllpbDlI?=
 =?utf-8?B?VlRkeVl2THdSbUlaL3NWZVQ2N1RiN3huVEhrTHU3cHZIbU96VUJGU0NBY2dN?=
 =?utf-8?B?MXU2U2FPOVR5SS9kd2xLUXJpTVpRL1BKVzh6VjBaY1B2QnY1V3Nvbm1pUStC?=
 =?utf-8?B?Nm1Yd1llTHB0ZWhjeEtrMmtiQmU4eUxiYXZSTmhRVXJ0V2YzTzl6SFYxUHc0?=
 =?utf-8?B?bEd5U2dPc2d1dnl0T0RWd3Bzd2Y1ZTJWLy9JZldGeEVGenNFcGRvcEN5cFRw?=
 =?utf-8?B?bHcwS2JnQm83emFRc0Y3YjU1SVk1a0oyR0NweWlta0JzcUZSbTN4bWtRS085?=
 =?utf-8?B?SmloUDFPTWROM2ZBWjEvL3JnOWY5RXpQKy82b2J1ZUJZdjgvVnQ0eGpON0RX?=
 =?utf-8?B?T2t6Szd4QzZYemNHWFNGN2d4aGpUSTRQL0lmdVZ6WlI2MS9rTzNseU11S0pr?=
 =?utf-8?B?V09HRzVhUUs3eUhYbGFPY21nc1cwb1NQdVhkMDg5ZWxGd2lxMVR0Q0YvVHZk?=
 =?utf-8?B?eXJJUjZjYVZ3eXltVEFrWXNYM29KdWJBaXZ1dFQ1MkwwRnJvdTBzWVB1QWo4?=
 =?utf-8?B?dEt0d2hnd2JhNVZDZXdVUXh0VnhlWUZHNWZpT3dqeXRlRHdkVkNCUjlHY1Ba?=
 =?utf-8?B?OExWeXVQQzhlSUt6S0hLb28zU05aTWFTTWN2NFI2VXZpUGlyZVM4MFc5Zm8z?=
 =?utf-8?B?UU9WS0RTaVEyQ3hockZNZU51eXIzVktTTVpHNE9SdTRWb2gxc2FBUC93eVZj?=
 =?utf-8?B?ZkdrcUpZcVdrV00wbnpnVHJIRWF6R0JxeXNhRU4xZTNDWi90U29EdXlYbERy?=
 =?utf-8?B?b2d5QlcrVkExZzE0Z2dNSGVvM2IxZVVmK0RLalVYRWlDcncwQUdCNXZydExO?=
 =?utf-8?B?UC9qOGQyOUVwRXEwRWtXeDRkd2RHQmhqVnBJN3RSQzUrUUlwZnBLNDdwY2dG?=
 =?utf-8?B?MWZDMnFnRHBkUmF3T2dPQmVTdDV0K1JUZGQwdnc2cVkwbmtiWlo1Q2FZRkJv?=
 =?utf-8?B?bytreGs2RFVZeUpCeGM3YmJ4b3lwYjNhajVVdElFbXR4OTV3SXpyRVd1UC9I?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB8997E88E961C4399816BF97060AF04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae03db0-320c-4acc-f795-08db246d498f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 09:20:00.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6wSzGa3soF0t/9lLek0tmf9Zz6dqSbE06XdAm7+aTBcJ/kFJvUCz7sPm+5A1S3QYpEw66CibBppxIri6FJSMdta+fw2UfbP0aol0ygeqLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5751
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBUdWUsIDIwMjMt
MDItMjggYXQgMTc6MDMgLTA1MDAsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIHdyb3RlOg0KPiBP
biBNb24sIEZlYiAyNywgMjAyMyBhdCAwMjoxNzowOEFNICswMDAwLCBZdW5mZWkgRG9uZyAo6JGj
5LqR6aOeKSB3cm90ZToNCj4gPiBIaSBOaWNvbGFzLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91
ciBzdWdnZXN0aW9uLg0KPiA+IE9uIFdlZCwgMjAyMy0wMi0yMiBhdCAxNjoxMSAtMDUwMCwgTsOt
Y29sYXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24g
VHVlLCBGZWIgMTQsIDIwMjMgYXQgMDI6Mjg6MDRBTSArMDAwMCwgWXVuZmVpIERvbmcgKOiRo+S6
kemjnikNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBIaSBOaWNvbGFzLA0KPiA+ID4gPiANCj4gPiA+
ID4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQo+ID4gPiA+IE9uIEZyaSwgMjAyMy0wMi0x
MCBhdCAxMDozNiAtMDUwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gPiA+ID4gPiBMZSB2
ZW5kcmVkaSAxMCBmw6l2cmllciAyMDIzIMOgIDEzOjU1ICswODAwLCBZdW5mZWkgRG9uZyBhDQo+
ID4gPiA+ID4gw6ljcml0IDoNCj4gDQo+IFsuLl0NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4g
PiA+ID4gPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zj
b2RlY19kZWMuYw0KPiA+ID4gPiA+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gPiA+ID4gPiBpbmRleCA2NDFmNTMzYzQxN2Yu
LjRmNWU5YzIwMjE0ZiAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4g
PiA+ID4gPiArKysNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+ID4gPiA+ID4gQEAgLTQxLDcgKzQxLDcgQEAg
c3RhdGljIGJvb2wgbXRrX3ZkZWNfZ2V0X2NhcF9mbXQoc3RydWN0DQo+ID4gPiA+ID4gPiBtdGtf
dmNvZGVjX2N0eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0KPiA+ID4gPiA+ID4gIAljb25zdCBz
dHJ1Y3QgbXRrX3ZpZGVvX2ZtdCAqZm10Ow0KPiA+ID4gPiA+ID4gIAlzdHJ1Y3QgbXRrX3FfZGF0
YSAqcV9kYXRhOw0KPiA+ID4gPiA+ID4gIAlpbnQgbnVtX2ZyYW1lX2NvdW50ID0gMCwgaTsNCj4g
PiA+ID4gPiA+IC0JYm9vbCByZXQgPSB0cnVlOw0KPiA+ID4gPiA+ID4gKwlib29sIHJldCA9IGZh
bHNlOw0KPiA+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZSBkb2Vzbid0IGRvIGFueXRoaW5nLCBzbyBJ
J2QgZHJvcCBpdC4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgY2hhbmdlIGlzIHVzZWZ1bCB3aGVu
IGNhcHR1cmUgZm91cmNjIGlzIE1UMjEgd2lsbCByZXR1cm4NCj4gPiBmYWxzZSwNCj4gPiBub3Qg
c3VwcG9ydCBldmVuIGlmIHNjcCBzdXBwb3J0IG1tMjEgYW5kIG10MjEuDQo+IA0KPiBCdXQgeW91
IGhhdmUNCj4gDQo+IAlkZWZhdWx0Og0KPiAJCXJldCA9IHRydWU7DQo+IAkJYnJlYWs7DQo+IA0K
PiBkb3duIGJlbG93LCBzbyB5b3UncmUgaGFuZGxpbmcgYWxsIGNhc2VzIGluIHRoZSBzd2l0Y2gs
IGFuZCB0aGUNCj4gb3JpZ2luYWwgdmFsdWUNCj4gZG9lc24ndCBtYXR0ZXIuIEl0IGNvdWxkIGV2
ZW4gYmUgbGVmdCB1bmluaXRpYWxpemVkLg0KPiANCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiA+
ICAJZm9yIChpID0gMDsgaSA8ICpkZWNfcGRhdGEtPm51bV9mb3JtYXRzOyBpKyspIHsNCj4gPiA+
ID4gPiA+ICAJCWlmIChkZWNfcGRhdGEtPnZkZWNfZm9ybWF0c1tpXS50eXBlICE9DQo+ID4gPiA+
ID4gPiBNVEtfRk1UX0ZSQU1FKQ0KPiA+ID4gPiA+ID4gQEAgLTYzLDcgKzYzLDcgQEAgc3RhdGlj
IGJvb2wgbXRrX3ZkZWNfZ2V0X2NhcF9mbXQoc3RydWN0DQo+ID4gPiA+ID4gPiBtdGtfdmNvZGVj
X2N0eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0KPiA+ID4gPiA+ID4gIAljYXNlIFY0TDJfUElY
X0ZNVF9IMjY0X1NMSUNFOg0KPiA+ID4gPiA+ID4gIAljYXNlIFY0TDJfUElYX0ZNVF9WUDlfRlJB
TUU6DQo+ID4gPiA+ID4gPiAgCQlpZiAoZm10LT5mb3VyY2MgPT0gVjRMMl9QSVhfRk1UX01NMjEp
DQo+ID4gPiA+ID4gPiAtCQkJcmV0ID0gZmFsc2U7DQo+ID4gPiA+ID4gPiArCQkJcmV0ID0gdHJ1
ZTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIG1ha2VzIHRoZSBWUDggYW5kIHRoZSBvdGhl
ciBjYXNlcyBpZGVudGljYWwsIGxlYXZpbmcNCj4gPiA+ID4gPiBhbnl0aGluZw0KPiA+ID4gPiA+
IHRoYXQgdG91Y2hlcw0KPiA+ID4gPiA+IE1UMjEgYXMgZGVhZCBjb2RlLiBJJ20gbm90IHN1cmUs
IGNhdXNlIEkgY2Fubm90IHRlc3QgaXQsIGJ1dA0KPiA+ID4gPiA+IGl0DQo+ID4gPiA+ID4gc2hv
dWxkIGluIHRoZW9yeQ0KPiA+ID4gPiA+IHJlbmRlciBNVDgxOTIgdW51c2FibGUsIHVubGVzcyBh
IG5ldyBmaXJtd2FyZSBoYXMgYmVlbg0KPiA+ID4gPiA+IHN1Ym1pdHRlZA0KPiA+ID4gPiA+IHRv
DQo+ID4gPiA+ID4gbGludXgtDQo+ID4gPiA+ID4gZmlybXdhcmUgd2l0aCBNTTIxIHN1cHBvcnQg
Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhlIGZpcm13YXJlIG9ubHkgc3Vw
cG9ydCBNVDIxID0+IHdvbid0IGV4aXN0IGZvciB2cDggbmVlZA0KPiA+ID4gPiB0bw0KPiA+ID4g
PiB1c2UNCj4gPiA+ID4gTU0yMS4NCj4gPiA+IA0KPiA+ID4gQW5kIHRoYXQncyB0aGUgaXNzdWUs
IHRoZSBzY3AuaW1nIGZvciBNVDgxOTIgb24gbGludXgtZmlybXdhcmUNCj4gPiA+IG9ubHkNCj4g
PiA+IHN1cHBvcnRzDQo+ID4gPiBNVDIxIFsxXS4gQ2FuIHlvdSBwbGVhc2UgdXBkYXRlIGl0IHRv
IHN1cHBvcnQgYm90aCBNTTIxIGFuZCBNVDIxPw0KPiA+ID4gDQo+ID4gPiBGb3IgTVQ4MTk1LCBv
bmx5IE1NMjEgaXMgc3VwcG9ydGVkIGluIHNjcC5pbWcgWzJdLCBidXQgc2luY2UgdGhlDQo+ID4g
PiBoYXJkd2FyZQ0KPiA+ID4gc3VwcG9ydHMgYm90aCBNTTIxIGFuZCBNVDIxLCB0aGUgZmlybXdh
cmUgc2hvdWxkIGFsc28gc3VwcG9ydA0KPiA+ID4gYm90aC4NCj4gPiA+IFNvIHBsZWFzZQ0KPiA+
ID4gYWxzbyB1cGRhdGUgaXQgb24gbGludXgtZmlybXdhcmUuDQo+ID4gPiANCj4gPiA+IFsxXSAN
Cj4gPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMTEyMjA0NjI2LmNpYWZm
NGFtc2VvaWR5YndAbm90YXBpYW5vLw0KPiA+ID4gWzJdIA0KPiA+ID4gDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMzAxMTIyMDU4MjUud2I1cWNxaGg1a3d2eWkzeUBub3RhcGlhbm8v
DQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IE7DrWNvbGFzDQo+ID4gPiANCj4gPiANCj4g
PiBNVDgxOTIgYWx3YXlzIHVzZSBNTTIxIGZyb20gdGhlIGJlZ2lubmluZywgTVQyMSBoYXZlIG5v
dCBiZWVuDQo+ID4gZW5hYmxlZC4NCj4gDQo+IFRoYXQncyBub3QgdHJ1ZSwgYW5kIHlvdSBjYW4g
dmVyaWZ5IHRocm91Z2ggdGhlIGZvbGxvd2luZzoNCj4gDQo+IAkkIGN1cmwgDQo+IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9maXJtd2FyZS9saW51eC1maXJtd2FyZS5naXQvcGxhaW4vbWVkaWF0ZWsvbXQ4
MTkyL3NjcC5pbWdfXzshIUNUUk5LQTl3TWcwQVJidyFpMVNxNjR5VjFTc0t6a3h0RnNaaDRwZnU4
WXdHQTdUaE8yeld0R3lEUkM0UURsenBtS3hZSlJ2dzN0b0gzb1ZEbEhEeE9wVDczRFpWV2ZlOU9X
ZXlqNmlmJA0KPiAkICAgPiAvbGliL2Zpcm13YXJlL21lZGlhdGVrL210ODE5Mi9zY3AuaW1nDQo+
IA0KSSBoYXZlIHNlbmQgdGhlIHBhdGNoIHYzIHRvIGJlIHJldmlld2VkLiBBbmQgVGluZ2hhbiB3
aWxsIGhlbHAgdG8NCnVwc3RyZWFtIG10ODE5MiBhbmQgbXQ4MTk1J3MgZmlybXdhcmUgc2NwLmlt
ZyB3aGljaCBzdXBwb3J0IE1NMjEgYW5kDQpNVDIxIGF0IHRoZSBzYW1lIHRpbWUuDQoNCkJlc3Qg
UmVnYXJkcywNCll1bmZlaSBEb25nDQo+IAkkIHNoYTI1NnN1bSAvbGliL2Zpcm13YXJlL21lZGlh
dGVrL210ODE5Mi9zY3AuaW1nDQo+IAlmYjliNDcyN2Y1ZTdjZDgyYjJjNjNhOGEyNjA0ZDAyZThj
MGYzOTBlYWUyZTlmZDg3YWExYWUwNzk3ZmIwMWINCj4gMyAgL2xpYi9maXJtd2FyZS9tZWRpYXRl
ay9tdDgxOTIvc2NwLmltZw0KPiANCj4gCSQgdjRsMi1jdGwgLWQxIC0tbGlzdC1mb3JtYXRzIC1E
DQo+IAlEcml2ZXIgSW5mbzoNCj4gCQlEcml2ZXIgbmFtZSAgICAgIDogbXRrLXZjb2RlYy1kZWMN
Cj4gCQlDYXJkIHR5cGUgICAgICAgIDogTVQ4MTkyIHZpZGVvIGRlY29kZXINCj4gCQlCdXMgaW5m
byAgICAgICAgIDogcGxhdGZvcm06MTYwMDAwMDAudmlkZW8tY29kZWMNCj4gCQlEcml2ZXIgdmVy
c2lvbiAgIDogNi4yLjANCj4gCQlDYXBhYmlsaXRpZXMgICAgIDogMHg4NDIwNDAwMA0KPiAJCQlW
aWRlbyBNZW1vcnktdG8tTWVtb3J5IE11bHRpcGxhbmFyDQo+IAkJCVN0cmVhbWluZw0KPiAJCQlF
eHRlbmRlZCBQaXggRm9ybWF0DQo+IAkJCURldmljZSBDYXBhYmlsaXRpZXMNCj4gCQlEZXZpY2Ug
Q2FwcyAgICAgIDogMHgwNDIwNDAwMA0KPiAJCQlWaWRlbyBNZW1vcnktdG8tTWVtb3J5IE11bHRp
cGxhbmFyDQo+IAkJCVN0cmVhbWluZw0KPiAJCQlFeHRlbmRlZCBQaXggRm9ybWF0DQo+IAlNZWRp
YSBEcml2ZXIgSW5mbzoNCj4gCQlEcml2ZXIgbmFtZSAgICAgIDogbXRrLXZjb2RlYy1kZWMNCj4g
CQlNb2RlbCAgICAgICAgICAgIDogbXRrLXZjb2RlYy1kZWMNCj4gCQlTZXJpYWwgICAgICAgICAg
IDoNCj4gCQlCdXMgaW5mbyAgICAgICAgIDogcGxhdGZvcm06MTYwMDAwMDAudmlkZW8tY29kZWMN
Cj4gCQlNZWRpYSB2ZXJzaW9uICAgIDogNi4yLjANCj4gCQlIYXJkd2FyZSByZXZpc2lvbjogMHgw
MDAwMDAwMCAoMCkNCj4gCQlEcml2ZXIgdmVyc2lvbiAgIDogNi4yLjANCj4gCUludGVyZmFjZSBJ
bmZvOg0KPiAJCUlEICAgICAgICAgICAgICAgOiAweDAzMDAwMDBjDQo+IAkJVHlwZSAgICAgICAg
ICAgICA6IFY0TCBWaWRlbw0KPiAJRW50aXR5IEluZm86DQo+IAkJSUQgICAgICAgICAgICAgICA6
IDB4MDAwMDAwMDEgKDEpDQo+IAkJTmFtZSAgICAgICAgICAgICA6IG10ay12Y29kZWMtZGVjLXNv
dXJjZQ0KPiAJCUZ1bmN0aW9uICAgICAgICAgOiBWNEwyIEkvTw0KPiAJCVBhZCAweDAxMDAwMDAy
ICAgOiAwOiBTb3VyY2UNCj4gCQkgTGluayAweDAyMDAwMDA4OiB0byByZW1vdGUgcGFkIDB4MTAw
MDAwNCBvZiBlbnRpdHkNCj4gJ210ay12Y29kZWMtZGVjLXByb2MnIChWaWRlbyBEZWNvZGVyKTog
RGF0YSwgRW5hYmxlZCwgSW1tdXRhYmxlDQo+IAlpb2N0bDogVklESU9DX0VOVU1fRk1UDQo+IAkJ
VHlwZTogVmlkZW8gQ2FwdHVyZSBNdWx0aXBsYW5hcg0KPiANCj4gCQlbMF06ICdNVDIxJyAoTWVk
aWF0ZWsgQ29tcHJlc3NlZCBGb3JtYXQsIGNvbXByZXNzZWQpDQo+IA0KPiANCj4gU28gdGhlIGRl
Y29kZXIgdmlkZW8gbm9kZSBpcyBjbGVhcmx5IG9ubHkgZXhwb3NpbmcgTVQyMSBpbiB0aGUNCj4g
Y2FwdHVyZSBwYWQuDQo+IA0KPiBGdXJ0aGVybW9yZSwgd2l0aA0KPiANCj4gCSQgZWNobyBtb2R1
bGUgbXRrX3Zjb2RlY19kZWMgK3BtZiA+DQo+IC9zeXMva2VybmVsL2RlYnVnL2R5bmFtaWNfZGVi
dWcvY29udHJvbA0KPiANCj4gYW5kIHJlLXJ1bm5pbmcgdGhlIHY0bDItY3RsIGNvbW1hbmQsIHlv
dSdsbCBzZWUNCj4gDQo+IAlbIDMxNjQuOTk4NzgxXSBtdGtfdmNvZGVjX2RlYzpmb3BzX3Zjb2Rl
Y19vcGVuOg0KPiBmb3BzX3Zjb2RlY19vcGVuKCksMjEyOiBkZWNvZGVyIGNhcGFiaWxpdHkgNzQw
DQo+IA0KPiBhbmQgaWYgeW91IGNoZWNrDQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL210a192Y29kZWNfZHJ2Lmg6DQo+IA0KPiAJZW51bSBtdGtfdmRlY19mb3JtYXRf
dHlwZXMgew0KPiAJCU1US19WREVDX0ZPUk1BVF9NTTIxID0gMHgyMCwNCj4gCQlNVEtfVkRFQ19G
T1JNQVRfTVQyMUMgPSAweDQwLA0KPiAJCU1US19WREVDX0ZPUk1BVF9IMjY0X1NMSUNFID0gMHgx
MDAsDQo+IAkJTVRLX1ZERUNfRk9STUFUX1ZQOF9GUkFNRSA9IDB4MjAwLA0KPiAJCU1US19WREVD
X0ZPUk1BVF9WUDlfRlJBTUUgPSAweDQwMCwNCj4gCQlNVEtfVkNPREVDX0lOTkVSX1JBQ0lORyA9
IDB4MjAwMDAsDQo+IAl9Ow0KPiANCj4gbWVhbmluZyB0aGUgc2NwLmltZyBmaXJtd2FyZSBpcyBl
eHBvc2luZyB0aGUgTVQyMUMgYnV0IG5vdCB0aGUgTU0yMQ0KPiBmb3JtYXQuDQo+IA0KPiBTbywg
YWdhaW4sIHRoZSBtdDgxOTIgc2NwLmltZyBmaXJtd2FyZSBuZWVkcyB0byBiZSBmaXhlZC4NCj4g
DQo+IFRoYW5rcywNCj4gTsOtY29sYXMNCg==
