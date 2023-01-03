Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468B65B9F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjACEPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjACEPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:15:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AB6464;
        Mon,  2 Jan 2023 20:15:27 -0800 (PST)
X-UUID: f726e664906c42d99d404f12a4f8896b-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gOWQQhI1KMKTjWLfrlQ12sscpjr3OasKdjKkQRGr/QE=;
        b=IafX+Aj7sMcWV1ptmUxa5QoQIi3vC2wKD0JSB8DbvmIdJ9sW1j+cbhubNw3BIoG96DlSrG3Hjze5OOwnzNiS0Xtcbc+4DqGCiTuzVA8USJvLTAeBa9hPYTHc+ZjUv3iods/rbw0m6npcvY2nLex8QvF6kTfCJ7bXCOaBxqr/lI0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:8396c354-c1c4-4006-8f30-6b7a11b7b8b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:e8827353-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: f726e664906c42d99d404f12a4f8896b-20230103
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1945466055; Tue, 03 Jan 2023 12:15:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 3 Jan 2023 12:15:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 12:15:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0QYNar211eVsPB7fubMRYTCBc5be8L2M0y3rS5GHSUWXWHOQ4tAtdOerkKRHxxZqqk/2iYTBmWYPoFoDxz20E+0PSxiX1YPQF2CxezPMFkllo2VtXS0/05WlW+NBpUcXUARkLkv1Hh0eTQJOm+BaE8XfRrxm7FIM3FLlk+pn4yM7RPf6jjKQAF3HHoTG7KZgH7Az8YNKjHxVz7sv/nLQleCtkXGEQWVlzXQG9GaMgJzIRBEKSF5Bri4gyZB+kTf738AvkY+BUwLWBoCzGm+Q4ioIGq/9QPwNTrLEdTi03HjXOHaN9ysoWkkJaP22bPmLRbtuxT2tEV7X3vIX2+rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOWQQhI1KMKTjWLfrlQ12sscpjr3OasKdjKkQRGr/QE=;
 b=fFmpp5/rxx/SMlXQ4qAL5s76nPDE0Afn7c6uAgvJmEgEgcGjoZoZLqDsguvE647hr48LYLCZsx8t3sW8Pwsku904j/JUF7HYeWQwhzgWK9gRJaSPmNFHoto/dX22Hnh70Lm83HPZbyDQ00XNK0HF2AZI/MsApnR9HI3qVV5pmXVNWKtBBl7mS/0n2VK8M/TEEcixnXD+Cka7rUcDB8bcZA+naJxGRGRv+NMAdHGPAH5z/eqvStDmN3I2H/6NKHX2W77lIj0wZ2kupZiYLUWgN6iTp5yOX8tJgoWd1K2+1FZzrvQXpa7P8G5RvKa9oL+xElIqh3O9AhhIcmYgfzaPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOWQQhI1KMKTjWLfrlQ12sscpjr3OasKdjKkQRGr/QE=;
 b=c1l/jlvcrxpVPyS6YGpIHU3YH0ESq7nZHwIF+01Ud7lNn9H0IANAinGPuaQpNdN2mUTi5jq2WVBVherGcoveJmk5rAendtE48WXMo5zLbJlS6R+yiQZjMJKDDC4xWKKYFnJOXdMbw0jTItIJdLO29VJbwAsWxj2iaJZJaGAnBC0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR0302MB5220.apcprd03.prod.outlook.com (2603:1096:820:45::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 04:15:20 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 04:15:20 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 10/13] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v4 10/13] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHZHBOD+EKNxmU00k2ACj0ovnnPmq6LU/0AgADH1QA=
Date:   Tue, 3 Jan 2023 04:15:20 +0000
Message-ID: <70fce807a7d10b806fea88ed86ae542d9fd58a2d.camel@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
         <20221230055443.16024-11-trevor.wu@mediatek.com>
         <43ee7ca8-de65-8c0a-20b4-e3cb5f10a3c8@linaro.org>
In-Reply-To: <43ee7ca8-de65-8c0a-20b4-e3cb5f10a3c8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR0302MB5220:EE_
x-ms-office365-filtering-correlation-id: c6cd9b08-169c-423d-c7dc-08daed4120a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yobtQc/32/HNcnjtFFFGTCxZIDRk+pFe1U4zclbnQt8ZVFbVRhSs+oae+5vVc+jkmxbkoRrB6DX1vd4Vm9gcTRVPlZZafWWdxUWQtgHyjQUy7aruAtH+IiP3l0aCPPrRr5RzB/k4lbIRaCI7MQNrVcMQ2ATzfLr3G1SSmal5jBJV06pXYn6hl9FUPrejOlvpBU/OKHKaYEsf5Gv7xHKz0lEs1cMqTaUzyLqQyz5Eumsut26JaP8WYld87p/eFd6YPnE+hQjA5ivkenzP/mhcimVIyB0lA+aJQ1AaInzyCPVDEE/Ztur+96FGSQFQkCR0c8w6eTPX0ZjQx4ykrvJc4vI8ZQBWgLeJ6Z5HrVgPTbFUQimrUVGpjuckd0rNxBj9mtPTb2RWMqO9jjzNT4NbERWO5C3du7kwaTMgJQxv9Bm5mMZq+b9s//f293R9ATZcuFNt01LmRul40x4R7zrFL9Q71eqOYn4kPrArBdB9nPRuFNomt45NdRqQOOAajUlUDnq1zjXKbYI4QQ8IOKDLEH4HnGYlBGn+g/X5mGBmVSqdaHqYBYkCokhADYpsE++lcSCMLomuq4dbKz3CjpDPWdRWLsNIgbF/JqzfY26Lrm9IFOgoxrdu+RAZki62CcBA7Q8RhrHF/G1BNkV1fK845g87ToMiG1+4ZlFBBRKZobG1jL6G58kT/rQxoEzubtSk5DqFviyZ6210bsmxSjeAYnPdlXkjbrOf8jNqt6u6j3F9vmUUrXeAvgrRufA10WWF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(66946007)(8676002)(64756008)(66476007)(66556008)(4326008)(4744005)(8936002)(91956017)(5660300002)(66446008)(316002)(7416002)(110136005)(2906002)(76116006)(6506007)(6486002)(71200400001)(478600001)(54906003)(41300700001)(53546011)(26005)(6512007)(186003)(2616005)(38100700002)(36756003)(122000001)(85182001)(38070700005)(86362001)(22166006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnNJUFBCdmRNUW9GNGsxZjBENVMxY29qR0pkcHBiQVFMM2J1ais2L1ozbHJ6?=
 =?utf-8?B?T2hxN3F1ZmdKRTVOVE95N25FR0tDaEhpeVVNNjQ3K0VxUEs0c0k4UlNuY0JQ?=
 =?utf-8?B?LzFWRDdacG5Qc21Od1JDQU1VMmg3cERXZHEvbGtOYndoVTNWYlRkT2dJK01u?=
 =?utf-8?B?N2s4QUlIMk9MQnhLS1VycVVocmpkZEdPR3Z2c3RCR0w2WngzeXFqL0Irdlhs?=
 =?utf-8?B?MEgxL0RqUWxOV3lmem5yaFVrZlllR1gzZGZ4R3NWcy9ISWp1VndwM0FaOGF5?=
 =?utf-8?B?SWcxTXI2NVNUaFduVDNnRVRoTVdZTC9tM2JyNlBjMnI3eHdLT1VLSWZTcTRj?=
 =?utf-8?B?elBZNS9NcHVZTG5DS0ZkaEZMVm01QnF6Uyt5VVJoUFAzWDMrQXZjNUZuRnR3?=
 =?utf-8?B?MHF3V21rR0E4S3k0Z3dCSWloUEdyL29OOGlXbUxiZ2lLb3hQQkJEdGNzeGRF?=
 =?utf-8?B?YmFnNFhKczAxWkdpZmVreGVBSzN0eVZEbDdpbk0xejJ6eSs3amdZQTdOMU1r?=
 =?utf-8?B?M3Zxa0k5NGdQRVVRUVdBTkhsTW5HbTI4bzVQV0dSbUNzaFBmK256Y3o2Q2xK?=
 =?utf-8?B?dEplUzBaWkJTWGd4YzN5QzRQa3M2WlJUaVM2SVRDb3czd3R6aW5TS2ZsY1Q5?=
 =?utf-8?B?YnFOTFRRbHk5Vnk4RGNYR2x6c2dRNk5RRDc0WmZYYVJ4ZlV1cVNmajgvdDJI?=
 =?utf-8?B?NFo1ak9zNmV4UFdnRGMwSUpEbVpkWXpFcEYwdzVTZ21rT1UrSWlyUm93SWdB?=
 =?utf-8?B?KzUza0ZzZ2RDNnJDbElKTldWWTNaQVhBZjRSYjJZeU41R01KdzgrM3pkRSs3?=
 =?utf-8?B?OTdQZzgwSVlVVUVRbzY4VjBtUlNmaHk4djhkUFZVcjN0eUdoOVZ6REdOd2Zq?=
 =?utf-8?B?S25VUWRUVEFyVmZuUjZtWFZLRnhJSW9FWmUxVGRhdjF0M215bDNWV2lkekJt?=
 =?utf-8?B?Yi9vWjFRM0dYQlpjU1RqSHVEZUN5YWdNd1BkNjVFM0NNMmlZcHJmQXcvTVJL?=
 =?utf-8?B?am00NE1KV2RsbGZSM2F4RHhNUkdxQ3pKb1hHdzY0c2pPZk45NWRSSjFROWQz?=
 =?utf-8?B?RDloaG05QkxYQjVLTnpwNk1NYnV2WitDWitJNjRjczBITHVwMlFuRlBGUjJY?=
 =?utf-8?B?eVFFVU5KRUFkOTZmT3JxUmlqUWtPVytMUjRoSE1UelZ2UjBYdnh0bGdHcmsx?=
 =?utf-8?B?N1c2VDhwQXJCd2cvOHNiaWNxTEMrVlo2VGF2THllclIvc2h3VFNxNU9IcTVn?=
 =?utf-8?B?UFdWWW9zVk44Q2UwRHB3aUtnbEtHNVEvVGVQaEJLZ05NK1FEZ1craFIvaDJU?=
 =?utf-8?B?dEpZVDJRVVd4MUpXdU9XcGttVG1XbVordnY2dlNCODhQTStKNDVQMmRkbTF0?=
 =?utf-8?B?MitJelFNUFR2U2lDcjBOSHhZTnBUT2R5VjVoL1pKQ0F6VzZEKzNTdXJPMWJq?=
 =?utf-8?B?cVFHc1RDbDVnendsMFh5a1E1L0Q4ZVlZVEJGWkx4ek41VU96SVQydmRqK00w?=
 =?utf-8?B?d2dhOC8vNWN6Vi9BRGxqOTNyRmZyYXlYWUZtMXgxemkxQWt4T084NS9LTTMr?=
 =?utf-8?B?ZGdrQUxCbVlPNmFNKzNwSVFyUFRlRi9WTHVSRlBxV09YS2wxajJjcmY3RnFU?=
 =?utf-8?B?V1VydEdIcTc3R3doaHpJaWk1UTFZbVcxT3lzV0VaaVlwMmFEVEhzOG42V2NB?=
 =?utf-8?B?YXRNYTJtaVB1UDM2T2NJNHBKY2lmVXcvYUJ3R0YrTHBqTUgxTDByYXIyeWxt?=
 =?utf-8?B?V0pITGJueFZJT1RZOUVUcXVpamgwVFRZRnRCWlFTcTBaT1pjUDIwUGZKTlVh?=
 =?utf-8?B?MElLT0dNdG5LVUR6RXowb0dJZS9NbnFVUVRnQ3FZV0FCQnhuay8rcUVlWUdr?=
 =?utf-8?B?aEdndmRMZFlPMys0aEY5d0J6b2pTM1NhZVV4WWs0OVpmZ2tUVFVDOTZlZVgv?=
 =?utf-8?B?VWpxcWNOSEJmSlpMc281aGZadDdqTFpJcGFrZ1Njbm5WZjdLc0FrekdLU1JW?=
 =?utf-8?B?UURSZnBjTzRyc1QvQllONFdQNHk5eE5Rak9hL1NBZHZUKzR2V2ZLbU0xa3ZF?=
 =?utf-8?B?a1NSdnBjWVduQkdwRDVJdHdtRmcvQ2xraXB5ak9HdHhSRHVqc2UrZU4vVW13?=
 =?utf-8?B?SWZvSmdXcnlXVlFYZmRFMlAyYWlOS3YvZ0IrNDBOdy84SWhwSS8rSjZmSitC?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5509DE0421A204D841B83E829E4D031@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cd9b08-169c-423d-c7dc-08daed4120a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 04:15:20.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odJi7ORwhxjfsroI5cbKN54Mjin4xLS3nJV6QOJFEb+Q5F3OBALa/c7KfaewRAGgMx767xw2MWkGFoPnHMmjvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5220
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDE3OjIwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAzMC8xMi8yMDIyIDA2OjU0LCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIG10
ODE4OCBhdWRpbyBhZmUgZG9jdW1lbnQuDQo+IA0KPiBVc2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRj
aGluZyB0aGUgc3Vic3lzdGVtICh3aGljaCB5b3UgY2FuIGdldCBmb3INCj4gZXhhbXBsZSB3aXRo
IGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24gdGhlDQo+IGRpcmVj
dG9yeQ0KPiB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nKS4NCj4gDQo+IFRoaXMgaXMgc3RpbGwgbm90
IGZpeGVkIGFuZCB5b3UgZ290IGNvbW1lbnRzIGFib3V0IGl0LiBJIGFtIG5vdCBnb2luZw0KPiB0
bw0KPiBrZWVwIHJldmlld2luZyB0aGlzIHBhdGNoLiBJbXBsZW1lbnQgdGhlIGZlZWRiYWNrLg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkhpIEtyenlzenRvZiwNCg0K
SSBhcG9sb2dpemUsIEkgZGlkbid0IGludGVuZCB0byBpZ25vcmUgeW91ciBjb21tZW50LiBJIG1p
c3VuZGVyc3Rvb2QNCnRoZSBjb21tZW50IGFnYWluLiBPcmlnaW5hbGx5LCBJIHRob3VnaHQgaXQg
d2FzIGFsc28gcmVsYXRlZCB0byBteQ0KbWlzc2luZyBwcmVmaXggaW4gdGhlIGZpbGVuYW1lLg0K
DQpJJ2xsIGNvcnJlY3QgdGhlIHN1YmplY3QoYWRkIEFTb0MgcHJlZml4KSBpbiB2NS4NCg0KVGhh
bmtzLA0KVHJldm9yDQo=
