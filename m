Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D045F4023
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJDJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJDJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60450580BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:41:08 -0700 (PDT)
X-UUID: 0ebd72e3691c4d7fa82adb391bffd56c-20221004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mz3KPLXgpofrgbgxzaMw3NxxyNLq6B2aemMG0O+gy3Q=;
        b=EGw3Za28M/bT2db4bCjXXfNgDl+orkZwDTeYPEmtmED0PFykMFNI7lQ/xTT55dNnDv8gLdo4+dwm95HIBsApFKpaKJFZ6YYrvGqLLajMZHwO7PATYK9Tjatuls2qxVIkBbChdQaAkTsH0fDd4pQsj6kwmACIpLuLts110TH0FNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:df0a0b28-1528-4470-9f13-bf81ca0bd2fd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:df0a0b28-1528-4470-9f13-bf81ca0bd2fd,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:e0db8d37-d6ea-42b6-990a-700b8e53f2f4,B
        ulkID:2210032254242UT161NK,BulkQuantity:82,Recheck:0,SF:38|17|19|823|824|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0
X-UUID: 0ebd72e3691c4d7fa82adb391bffd56c-20221004
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2071559796; Tue, 04 Oct 2022 17:41:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 4 Oct 2022 17:40:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 4 Oct 2022 17:40:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCL0FONRvfvn2V7RR5iTmHmM1WK6Za8OW7uqSdSsj/Hv6CqaACtVH5l4lH8eVGB3rIp05uzMnazAx3w1m1qfnlCby2guZD4qAJ9D8nTw1ZN65G9Y2L7nP0cNQ32rcoQuRQ+e41D0ly4MBVoRryBiwRYqZEdC8Q3jYioi3mvZmH8xX4ZY3EBHWHd6XaOSVBz3Qic53LNY8HaG4m4lIYxNwPi7I6mdysKY4C+U1cGFFgUBzDPsoyiFgbE7Y0SlGJBoI6WW/6FBXKbLhll49kyl6SGVe1ZfYqldznDidfVR5Dl8GjR7k757s5ySsmWtLtHSj2x9S6IHAV2Qr60fXPVEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz3KPLXgpofrgbgxzaMw3NxxyNLq6B2aemMG0O+gy3Q=;
 b=HkAppYCTtcZvj5VzVzvCMD3tQUwqTWi69fH3Rsiapdxr/TAVdNopY7SFXOqPb7EOfvIiEfbZahOdbEUY3tai2eI6XJuPLzaVv1abA/7BHouBDr8aZLjF5dCKCSfQw13L7K/h7HZMY0KD22W0734skjLTa/deCqVECRHQ42zKowZgaBVmrFP6qf/XJ4Q+EuwWT6g9jZMfMUOHSjt2tCmw+eiVJ+09GJB8tAD4t+983lrWaWw4j2Lec8h9QrwloI6PLdPfObrIMc8Jbpr8zAPUpTYW+kPsmYdDOKkjc/EYV0CO1+9WHlOKUm3/61QK4mgGSYMzDFIqwPPeI7tGEtA3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz3KPLXgpofrgbgxzaMw3NxxyNLq6B2aemMG0O+gy3Q=;
 b=oMXCRsJUYu9uIgM18Sc10gjYWO6JxvsVDl+Bp6r4llZDopzrKwYFWucOwlhawv9U04ZRT+daRpYcuMb9j9jfOgMiTUuafo9qGKBF+rMba4u2pbsF2liP0U8S4kaqLS67ymOVbxH8UDD7/WepMJpLc51LPG/p++5jZQWqybv+uho=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6609.apcprd03.prod.outlook.com (2603:1096:4:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Tue, 4 Oct
 2022 09:40:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%8]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 09:40:56 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Topic: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Index: AQHY1ObAMBSi0RZtGEKRxwiQ9QMPRa38IXgAgAHcgwCAAAMFAA==
Date:   Tue, 4 Oct 2022 09:40:56 +0000
Message-ID: <e244c6030c83239f2e33ddd07802d4c32ab182d4.camel@mediatek.com>
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
         <20220930160638.7588-4-yongqiang.niu@mediatek.com>
         <31b60ef83260b7f3d0761462c127d3fb34d4f8ac.camel@mediatek.com>
         <f50a6a17377ada1417159eb9545960b2afa0bdf8.camel@mediatek.com>
In-Reply-To: <f50a6a17377ada1417159eb9545960b2afa0bdf8.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6609:EE_
x-ms-office365-filtering-correlation-id: e62e7ddc-6c66-4ea1-7b16-08daa5ec89cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0Vqi9BCrxMLrW0XX5gyISD8Y8CIWgKqWy2woZeb1OrpOMoqUMU7FacquzsCqS4UloBVjPtjLublpiG5QCpSy+bWxNx5h7OVr2bYAM8Iy/+7oF/BbS9KyUTNGu53RSEOt1kstlbddizrpgnZf5hGuoOzSi69GFCbVE0XUKA90eJiqKljyJn1lSwZzrx7s+EUaoV06pgQpl/LNa+PRGoHl1BCkb4jNfjCQkw8xSarHvJD6k68Ow6j8Y+oz/s2Mp33mgB85qbxskg4q57gM0rYgbWGtyL5pColitUb+PIWPZQLlVvcHxRhLcCMZTAQybgmvuWkZzK8DQNij13A9hL9uSRXLIJUiXeCwe5NncSPCXcfl5wu7hbf5DabVbOew93NUHGU5ibvChXZOTPKlJNbew+cewRQ83+KJtUmD+iFtudEoL8PsNWl2zwxVqY5RvFdMtkl2GMFL1S/MQKSIBJMx9DWgpFZ6jTbX1t3mxsnVFJwOwmKbIIuNoXpE8bRvW7NQcnyS7/PI9Uni2pkXheu4bRdKtyyUnHCozmi6Bz6tiImevYkgn3X75TsuBhRTR8qasNG44bU9yu+4t++E9jbU7EJft74ebFH/IbwWpwoNOeBbQaX/kY2diyu85SS2PSyPVJxzKbF/44UQ620eD80bro6ntomWWFQ5V9kbdgY79xVOkiNmW6ZyS5t+pj7fzVV8cLsLH5SrpcItdRJnH1XrqOBfDeKlNEPve31b7d3j52uFmqEcXpJYl1uDqL+Nmc17nCEAHINXfunXEzZ0CATeHx9kcofVOoUyblDqtNjYACAcUq0lBqn95jjZN/saJOp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(2616005)(38100700002)(316002)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(110136005)(26005)(6512007)(85182001)(36756003)(6506007)(54906003)(41300700001)(8936002)(122000001)(5660300002)(83380400001)(15650500001)(86362001)(38070700005)(2906002)(186003)(6486002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBrMUlpN09OVUNSSHJaY3JHemZvL2xaQncwZ2RYQWVJZiszVmk0S29WZkhz?=
 =?utf-8?B?Qmp1OE9VWUlMYjdqOHl4QTBxb3FUWmNKZktGVFVGUUV3UHpnZTNUaXlIYmxz?=
 =?utf-8?B?a3VnaGlXeWw1Tm9OQkxtbDBFQlR6RXhmNWpRVlROdkhncHhzd0lZMUtCS3NM?=
 =?utf-8?B?bG8zYVhPOXNJS0ZSM3l5WkMxYURhNTJXZVBwTy9jRzgvS1FVV0FVVUdHQUlh?=
 =?utf-8?B?c3dHVXg4RWV5U2llZmRGcHczZmNHVWozZWU1RlFTMW15R2FRbWxqNHF6eFlo?=
 =?utf-8?B?SGxZOXVHcHFZZGoySjhLd1F0ejlxQXMwdEgzSjlodFpYSzFsakJvbDc1Wmpp?=
 =?utf-8?B?aGVNSy94NU4xdGVUSUM2MjYvQ0RBQnNyZ2tnMUI1SHh4UnE3b1RXd1pvWWVz?=
 =?utf-8?B?SDdlS1dNL3JoWHJJbmpWVExmSWwyVmY2Vmk1Wi9MUlprNWpCRmVSUit2a2VK?=
 =?utf-8?B?YlpHQ29PUjQ1ZTZHbFY1Z1p0Rjd0c2RvcDB1VU45VXFjdUJCMGpIQWdXakQz?=
 =?utf-8?B?NWJ4S0RmbDB5THFLbllrdEFQV1RWOWRKM3ZtaU11UnUrYjdPZStON0ZNNmRo?=
 =?utf-8?B?RWx2Q1BaeFd6OEd0N3BuM0F3dXdtZTFsVHd0QTlTdjRreDd5S2hnaXJiMVRx?=
 =?utf-8?B?enNSNEFEVnc4TFBSMXpBNkdBLzhGSkFlOGJqZDkxbWY0TEpIZlBIZDZ2TUxK?=
 =?utf-8?B?enA1c211N2JlaW9oWFVDeUl2aWl1QlQvSHdPYkxlbGZJUC9Ick54aG96THgy?=
 =?utf-8?B?TEsreXBzWHJXNFlBN21NaHhsY2FNb0lDMHp5bkNpSExidE9xUWdHZmw1cG05?=
 =?utf-8?B?dCtoWGJSRjdmODZBQUVFalorOVlVcmhDY21LaHdkZEdWUWdaVEExOTFIK2dl?=
 =?utf-8?B?MjVHV0lDR1VvaEUyUFZlajN4V0U2M3dXQmNkVnJpckJ3Z1RIaXpzRUgrVnQw?=
 =?utf-8?B?cldRbkdKTEVDMnZ4K0dxdEV2RVpVMXZvWlJ6K1QyK2hsMXBLM21yYVVUV3Z0?=
 =?utf-8?B?ZEdhQnJOR3JFYm5TM2w4SW5kYzhmeHp0RjFxWkxJZGY2Tk1KUFY3WU1PVjVM?=
 =?utf-8?B?aTR4NDhHVmI5Y1plK1ZHSUV1T05oMDBNUEVBMmVJaE1lNm1xbEdoZHF0NXpu?=
 =?utf-8?B?cUp2TTJDY1NBdW5PL1RQZGZDbjUxL3VWR3ZzTDdobDNWMnkwbURpL01VVDFG?=
 =?utf-8?B?VUlIZzNIYnhFempTRUVqTmU5WmFqSkpWNmxZR3F4d2puVUVOdUZrSVdhamQx?=
 =?utf-8?B?MDJTZWtqL0Vocncvb3MyZEFreUFYYUtKQmhMKzFUMkMwVGNKTEthMjMwY2p5?=
 =?utf-8?B?Z21OQVNkTEZDMW9HYmExRUxCcVZYaTdmNFhscXU0UHBXREZCOGI0UnVxVUZw?=
 =?utf-8?B?SjBXdHRhQlBiYit2Wk1FdjM3anBpVUFlN0V2WnpvR0gzV2NobUxVZ3NsckM2?=
 =?utf-8?B?SUhKb1RQM200cklaWmVKb2xaUUJQbnZNR1VSVWRrSFlVc3U5WTRJWXZxZ21S?=
 =?utf-8?B?OUdoUEVHTkd2bjE5ZkNxNkkyMlY2T1M5WTJmV1kyUk5YcGlrY3NCOHc2N2Fr?=
 =?utf-8?B?ZzFXU1JqaERGK1piNnE2c1o2SW8yZXhoRGVzRFA0eGlpeDZPcnFyU1RqWHY5?=
 =?utf-8?B?L2xxekpLWEdvNFFqYjY4REZIRFhySFdPZTNHWFUxaHQ4V2Z2UERyYzEzR2Nw?=
 =?utf-8?B?Q3lDY3NTNkdQaFRMRDhCbTRxQWYvd0RYV051YldscU4yWkpUVEMzVmR6TFh6?=
 =?utf-8?B?eGhuNFlZUnRFSTJDZkNGbkVPbUhSZUxJZUNFWmJPR0NiVy9vclIwS3FweFVl?=
 =?utf-8?B?djJlTnJMQXp2UkNjWVIvZGJ3NXdnMDFIUS8ydGVzNTNic2ZxaU9VMlFJUEM1?=
 =?utf-8?B?bXNhaDJqa1NVRHJYM0srQTVtWVB0WWlGa1pMZW55TU1zcnZUVk1kVkdSaWxU?=
 =?utf-8?B?SlFwTlJvbk5SdTdjTzdSbHg2aDRNdDdoVjFSam5ObVhONmhRL1puaEUzWkxO?=
 =?utf-8?B?MDBxNEFZTTl6YzI2N21TbnBwTVVxNVA4RzdsU0FOdUNvY1djZ2dSaS9WRUNp?=
 =?utf-8?B?VjFwNmtFYVc0REIwdWlBSFdSdWpaQ0NXTTlnWVZMWU0vQWFEWEs3bk5HTjRu?=
 =?utf-8?Q?qlguJq9V2A97ZdFdOEWet3zWH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <068C346E1E27284C909D34B6885C18EA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62e7ddc-6c66-4ea1-7b16-08daa5ec89cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 09:40:56.8778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW6hjF02CMDF9b+wfgt7191eNTXOUTVjJ0Nx3TyWLfwQYkd9SNs2Coh5S1Y0MIiY1WHHX4zJh8M4GbcIQj6otA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6609
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDIyLTEwLTA0IGF0IDE3OjMwICswODAwLCB5b25n
cWlhbmcubml1IHdyb3RlOg0KPiBPbiBNb24sIDIwMjItMTAtMDMgYXQgMTM6MDQgKzA4MDAsIENL
IEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24g
U2F0LCAyMDIyLTEwLTAxIGF0IDAwOjA2ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+
ID4gYWRkIGdjZSBkZHIgZW5hYmxlIGNvbnRyb2wgZmxvdyB3aGVuIGdjZSBzdXNwZW5kL3Jlc3Vt
ZQ0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcu
bml1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+IGIvZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gaW5kZXggMDRlYjQ0ZDg5MTE5Li4yZGI4MmZmODM4
ZWQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiBA
QCAtOTQsNiArOTQsMTggQEAgc3RydWN0IGdjZV9wbGF0IHsNCj4gPiA+ICAJdTMyIGdjZV9udW07
DQo+ID4gPiAgfTsNCj4gPiA+ICANCj4gPiA+ICtzdGF0aWMgdm9pZCBjbWRxX3N3X2Rkcl9lbmFi
bGUoc3RydWN0IGNtZHEgKmNtZHEsIGJvb2wgZW5hYmxlKQ0KPiA+ID4gK3sNCj4gPiA+ICsJV0FS
Tl9PTihjbGtfYnVsa19lbmFibGUoY21kcS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKSk7DQo+ID4g
PiArDQo+ID4gPiArCWlmIChlbmFibGUpDQo+ID4gPiArCQl3cml0ZWwoR0NFX0REUl9FTiB8IEdD
RV9DVFJMX0JZX1NXLCBjbWRxLT5iYXNlICsNCj4gPiA+IEdDRV9HQ1RMX1ZBTFVFKTsNCj4gPiA+
ICsJZWxzZQ0KPiA+ID4gKwkJd3JpdGVsKEdDRV9DVFJMX0JZX1NXLCBjbWRxLT5iYXNlICsgR0NF
X0dDVExfVkFMVUUpOw0KPiA+ID4gKw0KPiA+ID4gKwljbGtfYnVsa19kaXNhYmxlKGNtZHEtPmdj
ZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHU4IGNtZHFf
Z2V0X3NoaWZ0X3BhKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+ID4gPiAgew0KPiA+ID4gIAlz
dHJ1Y3QgY21kcSAqY21kcSA9IGNvbnRhaW5lcl9vZihjaGFuLT5tYm94LCBzdHJ1Y3QgY21kcSwN
Cj4gPiA+IG1ib3gpOw0KPiA+ID4gQEAgLTMxOSw2ICszMzEsOSBAQCBzdGF0aWMgaW50IGNtZHFf
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiAgCWlmICh0YXNrX3J1bm5pbmcpDQo+
ID4gPiAgCQlkZXZfd2FybihkZXYsICJleGlzdCBydW5uaW5nIHRhc2socykgaW4gc3VzcGVuZFxu
Iik7DQo+ID4gPiAgDQo+ID4gPiArCWlmIChjbWRxLT5zd19kZHJfZW4pDQo+ID4gPiArCQljbWRx
X3N3X2Rkcl9lbmFibGUoY21kcSwgZmFsc2UpOw0KPiA+IA0KPiA+IFdoeSBkbyB5b3UgZGlzYWJs
ZSBzdyBkZHIgZnVuY3Rpb24gd2hlbiBzdXNwZW5kPyBXb3VsZCB0aGUgcHJvYmxlbQ0KPiA+IGhh
cHBlbiB3aGVuIHlvdSBkaXNhYmxlIHN3IGRkciBmdW5jdGlvbi4gDQo+ID4gDQo+ID4gUmVnYXJk
cywNCj4gPiBDSw0KPiANCj4gd2hlbiBhbGwgY21kcSBpbnN0cnVjdGlvbiB0YXNrIGhhcyBiZWVu
IHByb2Nlc3NlZCBkb25lLA0KPiB3ZSBuZWVkIHNldCB0aGlzIGdjZSBkZHIgZW5hYmxlIHRvIGRp
c2FibGUgc3RhdHVzIHRvIHRlbGwNCj4gY21kcSBoYXJkd2FyZSBnY2UgdGhlcmUgaXMgbm9uZSB0
YXNrIG5lZWQgcHJvY2VzcywgYW5kIHRoZSBoYXJkd2FyZQ0KPiBjYW4gZ28gaW50byBpZGxlIG1v
ZGUgYW5kIG5vIGFjY2VzcyBkZHIgYW55bW9yZSwgdGhlbiB0aGUgc3BtIGNhbiBnbw0KPiBpbnRv
IHN1c3BlbmQuDQo+IA0KPiB0aGUgb3JpZ2luYWwgaXNzdWUgaXMgZ2NlIHN0aWxsIGFjY2VzcyBk
ZHIgd2hlbiBjbWRxIHN1c3BlbmQgZnVuY3Rpb24NCj4gY2FsbCwgYnV0IHRoZXJlIGlzIG5vIHRh
c2sgcnVuLg0KPiBzbywgd2UgbmVlZCBjb250cm9sIGdjZSBhY2Nlc3MgZGRyIHdpdGggdGhpcyBm
bG93Lg0KPiB3aGVuIGNtZHEgc3VzcGVuZCBmdW5jdGlvbiwgdGhlcmUgaXMgbm8gdGFzayBuZWVk
IHByb2Nlc3MsIHdlIGNhbg0KPiBkaXNhYmxlIGdjZSBhY2Nlc3MgZGRyLCB0byBtYWtlIHN1cmUg
c3lzdGVtIGdvIGludG8gc3VzcGVuZCBzdWNjZXNzLg0KPiANCg0KT0ssIGFuZCBhZGQgdGhlc2Ug
ZXhwbGFuYXRpb24gdG8gY29tbWl0IG1lc3NhZ2UuDQoNCj4gDQo+ID4gDQo+ID4gPiArDQo+ID4g
PiAgCWNsa19idWxrX3VucHJlcGFyZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpOw0KPiA+
ID4gIA0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+IEBAIC0zMzAsNiArMzQ1LDEwIEBAIHN0YXRp
YyBpbnQgY21kcV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gIA0KPiA+ID4gIAlX
QVJOX09OKGNsa19idWxrX3ByZXBhcmUoY21kcS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKSk7DQo+
ID4gPiAgCWNtZHEtPnN1c3BlbmRlZCA9IGZhbHNlOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoY21k
cS0+c3dfZGRyX2VuKQ0KPiA+ID4gKwkJY21kcV9zd19kZHJfZW5hYmxlKGNtZHEsIHRydWUpOw0K
PiA+ID4gKw0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiBAQCAt
MzM3LDYgKzM1Niw5IEBAIHN0YXRpYyBpbnQgY21kcV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiA+ID4gKnBkZXYpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgY21kcSAqY21kcSA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ID4gIA0KPiA+ID4gKwlpZiAoY21kcS0+
c3dfZGRyX2VuKQ0KPiA+ID4gKwkJY21kcV9zd19kZHJfZW5hYmxlKGNtZHEsIGZhbHNlKTsNCj4g
PiA+ICsNCj4gPiA+ICAJY2xrX2J1bGtfdW5wcmVwYXJlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNs
b2Nrcyk7DQo+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gIH0NCj4gDQo+IA0K
