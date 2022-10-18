Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9C602406
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJRFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJRFwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:52:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7CB5208D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:52:48 -0700 (PDT)
X-UUID: 0de2f7b327364117bfbb5f8409222051-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OUSG8R/G14If7dNnPz1jNZSWLX3a9vak6iLrfBhi9CY=;
        b=kzy4NsWWMPyUXaF9wfirqk+3AisE7+Gwe92I1URajXwU09retG2W+4dDR4HmGo4nr2MeSD0bF72Sb3tow96gg1GCTvsK3PtDhuDIGHfdVdrwfGhbLOjgC/+cDt4/xuZ/TkbsU2HUPMqKtqWze6JfCm6WtFNlyYWvfqmSGcai4xI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d79188a4-0440-4546-aec8-1fbb6a56a654,IP:0,U
        RL:0,TC:0,Content:11,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:6
X-CID-INFO: VERSION:1.1.11,REQID:d79188a4-0440-4546-aec8-1fbb6a56a654,IP:0,URL
        :0,TC:0,Content:11,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:6
X-CID-META: VersionHash:39a5ff1,CLOUDID:c1ee99ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:2210181352464VLH85VW,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:3,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0de2f7b327364117bfbb5f8409222051-20221018
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 8564011; Tue, 18 Oct 2022 13:52:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 13:52:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 18 Oct 2022 13:52:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhXAKTOs8fL2BwjXBnIvDrPJ+nJJC7idUz08DYgsUQrJxwQluVWF4gvwOoEy9mt7lWjCHUrb5sPPW0EkC1U/7kIJ0kw3X4TsZxbNSCuO6eQhuysaymKR/9Cj8zGlKicvbPSbfockP0OSdNezz+SHdNy717lesmuuSjQCfSa5ae5dkmhqDp8c/eVWgrV1Q4mWcJFsiBYjGU3wgKRTeZfxTHOE2S0S/qe1dvWX4/IQuKuPAlgtHtqmbZ9sS7GkW8CtWHElISSpZpU5G70bkWe9N0dnVICElxJPHCXQzqcgQ7/PKlFpez8LgGCsPvGuWtFiBC8/aelsePS81cXakA1Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUSG8R/G14If7dNnPz1jNZSWLX3a9vak6iLrfBhi9CY=;
 b=HGIW+YMkrBRhHCAQRHOnysfIo4SagXz4icIEVO8Z6hfZuDB2gZY5jJe+YlhuLrYYaymw/LGalBMKDnp26z2Xki0pP5GzmNunDs0PUhz3iCEroaeES9r19kOmBg7Dprzr4N4JrbUcY8JXhwgpYFMtP+TdJ1cdeXUty03UfGCqiSKRcU9mBsRsrr3QEzrqgEYtldRXqQlm9eKEATLxj4/Y95HOma7L97rIrmp91bSy1bsYSWvc/iL7PeE2rv8Uv/zMW2rlFQaW+ICCAOZ8uI87jHsYx9D4XwLHbiNlofL7yPFl5UbhmZumzD5xKIhi3krc/6FKcJCWYa3HGtMfJ/hPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUSG8R/G14If7dNnPz1jNZSWLX3a9vak6iLrfBhi9CY=;
 b=SHHctGDC6EpfjhxRg3ZMJ+S5IOi0IIiT97Uq8JsaU3MQAYKI9cmsldwUUEMuyTcgZq2THrb3u19ZnuTVEfkP1kKLBSBFZeWCMQojWh5TgtJMlsvWDDxVao21nSNKsm8hlihfpE1k506XaS+Mv4sse34RYuy6ZNAPwg+bkaz1NpY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6454.apcprd03.prod.outlook.com (2603:1096:4:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9; Tue, 18 Oct
 2022 05:52:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac%5]) with mapi id 15.20.5746.015; Tue, 18 Oct 2022
 05:52:41 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v10, 4/4] mailbox: mtk-cmdq: add MT8186 support
Thread-Topic: [PATCH v10, 4/4] mailbox: mtk-cmdq: add MT8186 support
Thread-Index: AQHY3JwdCggSi69Uo0GIEEkmzktOUa4TsnOA
Date:   Tue, 18 Oct 2022 05:52:41 +0000
Message-ID: <c1be7fa3351b8fe2d2f9c5c6654f701adc3147fb.camel@mediatek.com>
References: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
         <20221010085023.7621-5-yongqiang.niu@mediatek.com>
In-Reply-To: <20221010085023.7621-5-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6454:EE_
x-ms-office365-filtering-correlation-id: ff709e32-1280-4f3b-ed0d-08dab0ccf8ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJ8bGvIIKnufHqK3E6n6WOx3/ZLYyX8sSNKBf+rSYnnh+Li++5U4nYUne9x1O9UVhQ5Ufk8zuzqqfy3Qges6IHtbZQEucJYL4d63EKlq61O3ZBB8wPajsmnOPlmi4osZ3mQZ757IvKCRHMmVvXZQvXeQBdRtvepKwLON2QK9ENanYl7mP4KZvX1aGs1VeEmoglxdTbxcB4GQHsSnA9wteQbgPkDtCkO7/yQ5PFBxF32jF2PHfOaV+3b8jXLDMMiVGeqrLdwlZiHtPWeU6/Vq1gu/Mn5Bs68Yx0wyHhhz6UdRmrCZYYdgWIbrGk+zbIXIZ+d5UDOg+Mqt/scDGhPMKHo05z+8pZDIwGjXCtyTEuTbdg5OkaSWB8LysZRfelbEWJW8Ntg53l2yhKl9bdLu/JUeD0ToQ+C7LtoUhmkx4vJCax7lsuKrCs5eC8jq98UXgCJ4SUiHcMhj+/0g3VIkYVvQ43dLW4Jy6KJd4uaijiU6N1aDomz2m4Gg5lDnr+7gsjsXatqYRg5iPOuJZhxZmacdmzEM1LigKeacxe8majODF50LwY5+lJrjvsKQwuBnb4GywOMzwfn/LHQPxasS/97+vwBu9jCrJPAsCH5fiulWGvHmxMCZzToezMQlO2fPXU/mgBEUyJ3VaK5w72Y0u4IA1J2R+koDfGzz1auVRnUZxq4YB1F78Yb0JDaLyjAFu9v4d4M0+N/V49YZF4El+QNkhzQRfk3fy2th08EGLqKvxsMP3BD831qIr6q/hG+L+2G/6A7fRoLc/wFACsIAVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(478600001)(6486002)(66556008)(64756008)(66446008)(41300700001)(5660300002)(6512007)(26005)(85182001)(4001150100001)(8676002)(2906002)(4326008)(83380400001)(76116006)(36756003)(38070700005)(71200400001)(66946007)(8936002)(316002)(2616005)(66476007)(15650500001)(38100700002)(86362001)(186003)(6506007)(54906003)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdIVzUvc3ZFVTV6QkZmOTZKd3hTVk4vRVlNa1U0UlpOTGxsVlVYRlZHNXhS?=
 =?utf-8?B?UUVMNmhOSHVGOHlYc0hyT0piZnlLK3pTWjVuOTZYa01qa0pqdFFPeG9wbUs2?=
 =?utf-8?B?NldSL0h4Vi9ObmlMSXNicGtSSTBKTnh2aHBPbXZzbExyV1BoeG8yNktpUFhD?=
 =?utf-8?B?R2FPbTVFbkVxUWZhRUtzeElaVjhnR3A4Q0JEaHQwWGtDNHFVcTcyZlBrd2lE?=
 =?utf-8?B?cHdUN3o5S3FkN3EzSFJoL3dleGFSMzZkWjdaVVlOM2ZpaUlqZ2lnL0R2THNV?=
 =?utf-8?B?Z0lwamF5YmQ1WityL0V3a1hkSVk0VHJWcEVXVUxtRFpBY3VmWVkyZ2VpZXZK?=
 =?utf-8?B?ZzBNc0JBMVVwQytFajhSRHRDeVV1bXRSQURXUTNqZFlDYUtkSmtPcDB0aTF3?=
 =?utf-8?B?eTY4aEpDSVo2cm5tQm5jQ2svRmViUGdjd0pGdkc4R2JuQ25nbjRVOG5RQUE5?=
 =?utf-8?B?RFlNNmduWUZKVWk3ZTlwMFNXbkErZlRmMHlwSXF2MzV1cTJSMG55c2pMdjU3?=
 =?utf-8?B?ZmcyNk5pYVYzRzQzNy9OemhlVDhnK0Rtcm1HamdROEhOUWZwNlZicm9wWTdn?=
 =?utf-8?B?R3NmMmxEazFnbUFEZzNQYXBsMGgySDhvRUkwYWhnZkVHT3Rka09pQnBRZXpK?=
 =?utf-8?B?VjBQQ29jbWg3U1hoNlUvQ250VGJxem51ZkFXZThSWVZZbzFGdEdtaDJSM1Z4?=
 =?utf-8?B?a3JrSmZ5OEJXZHlta0dCVkxvM1d6NmwxeDFQMDdVRkhDMmlTRjNhZGUwV2FX?=
 =?utf-8?B?ZGNvQVR6dXZxU2Jpa1N3b1RGVVVXVkdZZEhRb29tcmNGSzMxc2NTZm8xelll?=
 =?utf-8?B?UEYvWHppaUxnWFdVSmwxaUtMdVhCQmU4NkNLZi9HcGF2WXlOSFNELzlDUS9x?=
 =?utf-8?B?K3BWNHhPZzRDSFRHQy9jbTRPS056UG1qZTFSU3lSdGxUVEMzUjZDTHM4S0hW?=
 =?utf-8?B?UHJMUnlNanYrd2NyaTRmdDhCY0x2czU1R2tVZ2J2RFZVWitlY3dvdTMxV0Qr?=
 =?utf-8?B?NjFNWXdBUzY5M0tkQjc1UTdibFh3bUtVNDIxcHdRbGZZalJQZXc1eXJBVEFW?=
 =?utf-8?B?cmxiMnZEN0o0a2pOYzlBSHdpZkYzc0tmT0g0M085d3gxWEw4OHcvZm1PcUNW?=
 =?utf-8?B?VVNwM243ODdYSms3NHNRR1ZzRmdYSlgwM2JCS2c1R3NUQ29JUStmSDVVc1Mw?=
 =?utf-8?B?QVo1L1djUzFOTkpjTVgwWE5OZVJRK3VOcXEyZUsrcTVTK3p3Zk50d2RLMVd5?=
 =?utf-8?B?NmFXN2kySytGWURWdE5PRnJrZm5xS0xmZ1I1UFZaVTRIYk5LSDBBT3UycXVG?=
 =?utf-8?B?ejdYblVrdkNoYTFEdGFGWFhobkhhV2ZGK3V0MGd2M0sxZlhTWnlWQktuR21q?=
 =?utf-8?B?TldYZVgrQ3VoOHNuM1ZXbEh6bHc0U1pSNGRGV0lSMXhKaktBUXlNenhsTXZv?=
 =?utf-8?B?djhhZlBaUmp2TnZ0TGhMdEFxNjJWdjFGQUV0NXZ0UHpZN21tZG9XbkNWYWFw?=
 =?utf-8?B?RjFrQ2J2VGVWNTZSS014TWhsb2VMdXA3aVk2SEZnbEN4aG16bmU3OUxxT2E3?=
 =?utf-8?B?ZmxQQlZwUTkxTmxjOE5uMzJaa2lGbGpsSW5KaXg4QW5nd3pDYkZrQ1drTjJk?=
 =?utf-8?B?b0dOL1FINS9ORk5ZQmpMN1F2bEFYZnlxcHZLajJ3TzhRNmwwRzZubnlTeVUx?=
 =?utf-8?B?cjBRY3FZUWZSYWN0ZG9ta0tlMEMrSXQyTHZqRmxDMGhvQjJqbE16aHJJaW1t?=
 =?utf-8?B?Z1BERldRY2RsOGZwcWl3MVcvcFBLVERxeVkvek1PUys4Yk1Dc0NoelIzVThQ?=
 =?utf-8?B?K2d4dUkvbWhVZTBUb0hYTzB5bWZHLzJNSG1CYk5DdjRnTVlSa1c3SE1WWTVp?=
 =?utf-8?B?ZG5XMFVvZVJ4aWdVMWQ5MG1RZElVcmVibHdySmZRazBGSXhNWFRXUlp2disw?=
 =?utf-8?B?Q2pGbnhNTUMxbnVCczdmV3FIK0xpUG1RbXYybjQ1QjB2VkVBSXRIVlI0K2Ro?=
 =?utf-8?B?ZUtIZTNkNjF1eFovdU0reGZqRkpyZURlc2xldWlaNUIxK1hKMmN5Vm80cGl0?=
 =?utf-8?B?U05zNHRKMHFFNE0xTVhSdDlnVzQrY3R0V20vNE5PRk9DeGd3bTBPL2MzUFI4?=
 =?utf-8?B?eElQWnpKQWNKd1N1cktoRkM3RFRxRHpYZW50K0l5dC9yR0xKeFJMMFBWTVVm?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E33138FB856CA4DAC17882FF6B28863@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff709e32-1280-4f3b-ed0d-08dab0ccf8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 05:52:41.7842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE1c2vam1bD4iFTV2561c60+jL2cERzTQ0seK1ep1WI2aSM85c87CYb1qzV8HAf0aOLjpE1KVYiUhlRvsKycWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDIyLTEwLTEwIGF0IDE2OjUwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBhZGQgTVQ4MTg2IGNtZHEgc3VwcG9ydA0KDQpSZXZpZXdlZC1i
eTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9u
Z3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9A
Y29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCA1MzkwNDUxMTU5OGQu
LmM1MjI5ZjM3N2M1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBA
IC02OTQsOSArNjk0LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRf
djYgPSB7DQo+ICAJLmdjZV9udW0gPSAyDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y3ID0gew0KPiArCS50aHJlYWRfbnIgPSAyNCwNCj4gKwku
c2hpZnQgPSAzLA0KPiArCS5jb250cm9sX2J5X3N3ID0gdHJ1ZSwNCj4gKwkuc3dfZGRyX2VuID0g
dHJ1ZSwNCj4gKwkuZ2NlX251bSA9IDENCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10gPSB7DQo+ICAJey5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE3My1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3YyfSwNCj4g
IAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4g
KikmZ2NlX3BsYXRfdjN9LA0KPiArCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZ2Nl
IiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92N30sDQo+ICAJey5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10Njc3OS1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3Y0fSwN
Cj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWdjZSIsIC5kYXRhID0gKHZvaWQN
Cj4gKikmZ2NlX3BsYXRfdjV9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUt
Z2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92Nn0sDQo=
