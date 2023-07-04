Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CD7469AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGDG2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGDG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:28:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698DBB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:28:39 -0700 (PDT)
X-UUID: ffaedc5a1a3311eeb20a276fd37b9834-20230704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KFYQ/0Zx0sZ4Dxx1DODgwjHMKFH4IRs6949GMNqmRCw=;
        b=CVHlkq0+XuTtfKkxbmYJ3SB/p0g+zZxbxAcoRRzGR9DS7OBHvIUQl6nAYxJT5/UCovyZZq1wa2J/8NKd1INMRyng2yoqfNDd37wKijRjSIFckL91e+BOwfKFTVnSXkrXDMK34pfgpcaQ/GfaSdjTEnLnIFzbaNWqZBorX/m2pYI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:56d4ffd3-33b5-4720-a0e2-198326418119,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:ba0cac82-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ffaedc5a1a3311eeb20a276fd37b9834-20230704
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1254308414; Tue, 04 Jul 2023 14:28:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jul 2023 14:28:31 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jul 2023 14:28:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1lGBeA1LzLHPuzM9PW1Vy0e1vZnCucr7kEGMLW640raiNDYdC0UpB2Na4LusQmsUq/LIBsQ5FV6QW+FEh9ZY79ItQJpTcIs0tAn16ptb5YTNyMpWwntp5Q1iYaQymw7TlExsYg6mLsPwMMiOcUK54rghatRX6jMWj8X2tAZhpQ+YVQuZEWlFiDQ1eTrfM1pJFi1hGp/oN+LSsrJfNYS4VNUn6/tidJTx7vVM6s8XSYJ9YKwkrjBWdtJLhwj4juI7SyHxdLV2JnoUHorP82pUH7gk+nXC87gaXByYrrMma+SI3Apx652Nf28ywk0cd3lSNCD2UKqTV0h0ThM91Qmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFYQ/0Zx0sZ4Dxx1DODgwjHMKFH4IRs6949GMNqmRCw=;
 b=IXc1GKd46i+X46F/zBfucHfllE1N18/pjTvOJ980cBiw+oyFW55481PU/o6K9MrpoDCMlD672aD+bJAuJV4gcDwr59HHvRJPdtvBb6haWFBLcOpKUwsAPY+V9uskrgP6+6CvWby+ISRh5m8dPOSWFDov7GjoWWb9aKS09DVICjMeddk4YTXjLD0Pt/18HlmRchEEY+y3Uxuyozg7MslOa7J/5CCTysE8mGMYDbCvn5MfPsbp2Wz1K9htQr4x/F4dHzli8GWZ0LLlq/Rs+PsBT4Cm66Fldny0OLa4thZ4Q9YIIoISlwrTZxMzEipWZnTmuIt/KL7shHL5jq11nd6BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFYQ/0Zx0sZ4Dxx1DODgwjHMKFH4IRs6949GMNqmRCw=;
 b=Jwacgfu5xWog78RNNIk+ImR2YftPDU1XhRuwO+OQZYv6qeYbqPRru4LaoFFfdpMLRipvWmlveUKTfdXHK98jYc+WOL21wlxM1WvkuyD0Ftc5Mt9wS/Q92EZtVE9KHjwPJ4bq3OnQa/Iby4BnbUJY1v/lDZF1MIwJNtcrQmAzNQI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7965.apcprd03.prod.outlook.com (2603:1096:101:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 06:28:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 06:28:29 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 1/3] drm/mediatek: Use
 devm_platform_get_and_ioremap_resource()
Thread-Topic: [PATCH 1/3] drm/mediatek: Use
 devm_platform_get_and_ioremap_resource()
Thread-Index: AQHZmfHO8p97D3IThESdC3pIXNPA4K+pTZqA
Date:   Tue, 4 Jul 2023 06:28:29 +0000
Message-ID: <ef62141b4b9940d9642e1318763ea6c687deaa8d.camel@mediatek.com>
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
         <20230608101209.126499-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230608101209.126499-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7965:EE_
x-ms-office365-filtering-correlation-id: 2af0c742-0238-40c2-95a5-08db7c57e1f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OqP9wWcLLL0nCfiZhuLINasYHZutavLiOchnQkuZMpndM97SjFea6bbDDS448gdZhUYEBUOmFeWwcgA9IpeIgRpKFcBChs1Ob/5epA7kZWva8i5PON0w93cyIatCvfPVcxwNIRyda5ha07ivwxL3b6FrWK5zMOAcdZYa9ZS3WgigThkNHmSXAR85YyLhZ04ZhfHRSCH2IrIkpdzkcF88OwF8Df9JxzTZdXYfsJocjPbaGkzSiZgBr5wg5FMfH1+SenbBHjlKASHZw5f/G2kXvUQcSc0FjM26Ar7pa4GFYnzmyk/hvygURGnBXSZZdbLMuTd5Xlwr9kOACNqPnLCIG5ggsYm4+XLjX1ItQaXbfIthY095R7SusYtPUNBR5uJ1Zv4OE+m1TRD6sD/TCL8ueUI7AWaQUGYx/+gCFAP0ac19yvRC0Wt4198dTiApliXOoWmhG9SQiGKTbkBdE/YXU6TP1Zihox8OtC1rhMQ9m0K+XEYGAbbORCKoTB1aKhN5KljYki7BgQpvNOIk0Niu8iFcneRyJQUwfYNPDiXXrwUGnqWU9/CjuJURmyTpGlEWcPVUXP5PjY/OEJQO4VusO6KOUGIEQzD1loh1WT7j7c7kteTRfDFsa8Lz9l1j+UdAJVMn73PceqWNl4ae8u2r3YU1Y31BmgzmBHH3DzdOC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(41300700001)(38100700002)(6486002)(26005)(2616005)(71200400001)(122000001)(186003)(83380400001)(6506007)(6512007)(54906003)(86362001)(38070700005)(110136005)(478600001)(85182001)(66446008)(2906002)(36756003)(316002)(66556008)(64756008)(4326008)(66476007)(76116006)(66946007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExEQzRPS2NjWE5vZ3J2S3ZkNmdwNFRWLzRkdHpGTmJpU1dZUjVSTi9IQWd1?=
 =?utf-8?B?UmRvU1hsRTM1RlNBZzgxTHB2RlVoMHp3OGgwYVNVcnZXYWhIWGlKcjNIbVVj?=
 =?utf-8?B?dWlxRlliWUVnNWg2V3VHbUVxMTRCWExMUmppZVBRQWw2WkM5OTB4NWJKdDF4?=
 =?utf-8?B?dlhiYU1ucUpvbXBvdElyeHVRdGpDSkNRNnZRelBZd0t5VVZ4ZmRFN2RtL0N5?=
 =?utf-8?B?a0toczBiWmdIVkpCaThMbkdXUS9VVmpId2g1L3NzU2hoN2IvK2lDTng4d3p3?=
 =?utf-8?B?dTFPajd5ZUw2YzhQdFlUb3dDVE9xSjc5T0VrdTIva0dBVEozSGQyMis0VDRD?=
 =?utf-8?B?QnY0YmdYNWx2OUQ1a0gxaUFsT20zSU96SDgxVU8zQVBXWEw1akpDVG1ab09m?=
 =?utf-8?B?M0k5TzNRYTZzM3owODVkUWs4V2dJcUUvbXdRZExtREtBcVp5czlYbjJBOFVC?=
 =?utf-8?B?RGFVVkJnSmlhSFZzR2JZOUhMYmdmSGJTelFvZjFwa0ZRREh5OERJcWp0MnZq?=
 =?utf-8?B?Y3pDYkpEK1FCZUovMytpK1lvNzVLV0pGeXI4MzlIbEZ0c3ZPcE5VTUZsL1hx?=
 =?utf-8?B?VHk4UUlWTVh0Vmp0eUFYc2xNMGwrL083UVdjVnlkTC84ZlV1VGViYkF2YU9G?=
 =?utf-8?B?c0EvcTdTcjNNbHd2U1BxcTV4UWxpRkZIZE9XaVhjaml0NUFlempKUE5nVnBY?=
 =?utf-8?B?Umo1MklwdGd0Q0EzZll2M0xzSTVVZ040dUk1QUJuQXRtRk9jK1BFT0t3NFJM?=
 =?utf-8?B?T0ZuQlVadkhUUm9tSmtjWE5MQkxjNmFPN3FhbnJtTENISWJjaWFZV2V4REhm?=
 =?utf-8?B?TXQyQk1EYlN3WFowZHphN2hGS1lMR3ZQZDlqQjkvUjJPbjM4eExDdmZsYlo1?=
 =?utf-8?B?ZHJPT0o2ZzNHMkNLZlZvRGRlWEgzcFZ1VWNyWUJjT1Q3NXh1M1dkU1R4akUw?=
 =?utf-8?B?aVIxVlRyU3FnVSt1MkpGeHVZNmdJam5DQlh3NjZVNzdoVFdhNzVpSC8ycUta?=
 =?utf-8?B?OVBiTVhaNmsxZkZmaklySWxNZkN3QWdPQVdmbkNOdTE2WEtSR0RBRE1qRjdu?=
 =?utf-8?B?TE5tblRmVkRUZ1hxc2hDWG44RDV1ZmhNZGNLNjZhcnVmWlZ4bXgwbElsa2Zl?=
 =?utf-8?B?VURWbFY5dTJ0anRUSFBteTBPMkZUckhFdmdibnJDNUxiS05pVzlZWkVrNnRl?=
 =?utf-8?B?UUJYVlk3eUdFbU9jeXpBcHpvM1VDa2RFSzZLUFd6YzZtUklPWm1JSkxDVzVt?=
 =?utf-8?B?SHhCdkZ5dmEwVjdyNjBkOFRMMXo1MTJ6UlhkWUxGaHNoK0ovTFdsZ0plTzlQ?=
 =?utf-8?B?VThQOVh2cms2LzNLdmVGalpTUnlRUlZxU3RxZG1GSTdlcnBVMVJ2VGd2Q3NS?=
 =?utf-8?B?R0dKT3Q5MkF4b0tvak9DN1ZOS0xaMnd5TjNvcFNwR2NFNzBBZ2lJaU80NWY3?=
 =?utf-8?B?YXBpbHJuZEswOXRDUFM1Ynh2dG8yM3gzRWo2UDE0WFZZOXZqaGxjVzVTWkUv?=
 =?utf-8?B?TjdpMlRTWnJZQWM2U2M1WnpxUUJGMUJQaytwa0h2elcxd0pINXN6MXptNWhn?=
 =?utf-8?B?L2xWZElLQWRrQm9JM3hSU0tGMVJNNWNEallGYVV5K0ZYbW1CQWJuYnJhbGRJ?=
 =?utf-8?B?TXZPc2tnbmx1M25heFRXS1ZvcDFuU0hnV2d1eFpUSEVuMzl3MmJJUmZhK0ND?=
 =?utf-8?B?YSt2eGZxUGE0SXBqZXFXV2x1RzBNSWxYWHZERm80TDFETDJuZ2c2bmpPMURL?=
 =?utf-8?B?eU42dEFUZ3JwamROTFVUZGJhTGV2Nkt1c1ZnZEdPQ24renc5WVNrbmNqT25N?=
 =?utf-8?B?SURySzF4OGlYaWZXYkpvL0J2RmZyL3lHQVRzckoralRNYy9UNWc5MURUUXJw?=
 =?utf-8?B?RkppYnpYQktjaitzZHU1a0gzcHVPSzJDbm9NSStlTWt3bEltSFphN01wNVpS?=
 =?utf-8?B?QncyQThzU1ZoYlFLR0ZWRDJvMXJpMCtLZSsvYWFPOXR3VTlrRklIcHFkMFd0?=
 =?utf-8?B?SnhIV2tlMlZVdm5wdk50MUxINDc5VExZV1I3c3hlN1pHTFhGVzJrSDlUYkI4?=
 =?utf-8?B?SG5yM1lpeDAzbzYzaFdDaWlKRjFmL25lQ2l3bFdTODVkS1ZuWUI2NUVCejhH?=
 =?utf-8?Q?6X7QmlCZzaRkVAXnW419iTyoL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8E85548984294393885267B43E4EF5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af0c742-0238-40c2-95a5-08db7c57e1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 06:28:29.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3pu2OM96Q5E/CHjV3vg/fZ0cxX3IltHZ9h5b/C4oQH4AN4CthTAMcGSerwCJfs0+6JBDeWVx+UaZPcMMb8AzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA2LTA4IGF0IDEyOjEyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbnN0ZWFkIG9mIG9w
ZW4gY29kaW5nIGNhbGxzIHRvIHBsYXRmb3JtX2dldF9yZXNvdXJjZSgpIGZvbGxvd2VkIGJ5DQo+
IGRldm1faW9yZW1hcF9yZXNvdXJjZSgpLCBwZXJmb3JtIGEgc2luZ2xlIGNhbGwgdG8gdGhlIGhl
bHBlcg0KPiBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgpLg0KPiANCj4g
VGhpcyBjb21taXQgYnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfY2VjLmMgICAgICAgIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9hYWwuYyAgIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9jY29yci5jIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9jb2xvci5jIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9tZXJn
ZS5jIHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAg
IHwgMyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgIHwg
MyArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgICAgICAgIHwgMyAr
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jICAgICAgIHwgMyArLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9kZGMuYyAgIHwgMyArLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYyAgIHwgMyArLS0NCj4gIDEy
IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY2VjLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NlYy5jDQo+IGluZGV4IGI2NDBiYzA1NTllNy4uNTEz
NmFhZGE5MDIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Nl
Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY2VjLmMNCj4gQEAgLTE5
NSw4ICsxOTUsNyBAQCBzdGF0aWMgaW50IG10a19jZWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBjZWMpOw0KPiAg
CXNwaW5fbG9ja19pbml0KCZjZWMtPmxvY2spOw0KPiAgDQo+IC0JcmVzID0gcGxhdGZvcm1fZ2V0
X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQljZWMtPnJlZ3MgPSBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiArCWNlYy0+cmVncyA9IGRldm1fcGxhdGZv
cm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsDQo+ICZyZXMpOw0KDQpUaGUgJ3Jl
cycgaXMgdXNlbGVzcywgc28gZHJvcCBpdC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAlpZiAoSVNf
RVJSKGNlYy0+cmVncykpIHsNCj4gIAkJcmV0ID0gUFRSX0VSUihjZWMtPnJlZ3MpOw0KPiAgCQlk
ZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpb3JlbWFwIGNlYzogJWRcbiIsIHJldCk7DQo+IA0K
