Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD1651F64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiLTLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLTLDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:03:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953D18E00
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:03:44 -0800 (PST)
X-UUID: 637776aa751e4765b5e464c58895b1dc-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kSGi1dF6Hnb6P/P9CMIQze+hGRV8V0Pe+H0KT41oMLk=;
        b=mzw53Ws1JyPwCUeT8HE8xnxEh8CxWzHPOY7UFXVpmaiM/VWLQbfOV326scPUilK4+TxHSASdL++Ir6jOaf8PA+dySFa+ypWcF6gonKOpJUuvxEuYja4qd+5/dlCD6iWHioEZQMEPw90H3NxnW5m1oi1xKDewJfwm/kfkCvLF60k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:96e1dab3-8aa9-4540-b386-81c4268768f9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.14,REQID:96e1dab3-8aa9-4540-b386-81c4268768f9,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:dcaaed0,CLOUDID:32ff72f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:2212201903412YRJ4NRA,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 637776aa751e4765b5e464c58895b1dc-20221220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 219795087; Tue, 20 Dec 2022 19:03:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 19:03:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 20 Dec 2022 19:03:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRLv2Kjl78tgz3DuLdYVHcj0/h2CbSHJDknoX6oUiV2AMMYPRGMecrBoIubcnpfWB3fh7EE7liHEIliM6hUKjnvwyQCHLYBDEUtDterTP79GWTn/Go8AjUugLsH4lLtGsYZl8qNfq6SqkwQTXXxvKqyEfoFBs8645jigukcUJ8ZMI0qCsO6fzWY0Jy8aUf8UOB7OoeFJnZkbWSZg3m5it7Xq+IBCkhvBAuIRAwWBYHUeXepAHVpy0uj0SQglq+HwGOyX3yJR8UdrgukRROFHQENQNsUkjbShRm9sINe6XX2s8ELDNt3xVvDj9UC2waJlwJ4QLAWfKZM8vBJbZC5/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSGi1dF6Hnb6P/P9CMIQze+hGRV8V0Pe+H0KT41oMLk=;
 b=SiO/qWYb8FGebmQP/di549oykVp5/RotCprFB+BQZGn/3G/onyPRCen1d8Od2UYxfGVE6wFK3uhqvRV7LXOwDGGZizeWWa23vWhaQ7JtEsMvRQUYLxzSptOPmtU2wabTFSIhPJjVfLfPqo9BCb7q2GzQ9tPT+58DAaLsJhnDg0u+4JP+8y8HBL0jJJ5pnpAqFBRVRNVxnaimFXxnivSnCU8Z6M8F9XIYv6Y3ZA1JAZ7TPU8zOKuTPI01fFDmQQV5bDBDBQjb6Gp422fUHeyIis8Ll/G47xbxUqsxn+eG7Up+Rd+6NCRMwWBwL+RY8nYovRZ2sqspUxckDOSmovTDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSGi1dF6Hnb6P/P9CMIQze+hGRV8V0Pe+H0KT41oMLk=;
 b=YhRlNqbOF/97vycm7B7LYnBk+z928Ilmwio+uAHPO00HWVJVKrp3DveY+487+86lIpH1kAmqdBOYweKV5N5zJTWRpgN9yJKugC59a+gHYUy0SzE/5cl6JVsj0z+5ZifDMJHSO9GqxPld4iqdQyGzFJBcH1TTKb+RUk9RiADhxuo=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 TYZPR03MB5552.apcprd03.prod.outlook.com (2603:1096:400:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 11:03:36 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::e44b:8436:2fd1:5b67]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::e44b:8436:2fd1:5b67%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 11:03:36 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Thread-Topic: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Thread-Index: AQHZAp45eHJhO3l64E+pzj5jqpTZUK5XUKAAgBlDWICABiwzAA==
Date:   Tue, 20 Dec 2022 11:03:36 +0000
Message-ID: <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
         <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
         <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
In-Reply-To: <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|TYZPR03MB5552:EE_
x-ms-office365-filtering-correlation-id: e128f59b-0276-43a8-a15f-08dae279d7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLVkkq2nkKjnklYkgRtG3ffcUH5DQbznqwCTV+mjFTwDDJfZyhxIqBF79T6ujNObcRNKxikP1CUbCoLzCxyn43syTM5xaEj5v8uSBhn/gvJ88TjjjNXKm7kKCYXsVTIHNy6TG3dMOph3FxShNaQ3veZMara7Jmx0CEizoai0p7O0aleqPn1lJaZ9bN2/3c6S1jjKgGKF9N2e9NpsiffUzJWeh65Jk+L2jVjezKFzDKG5p/HInH5J4TOfTFNcDiLeHuMpGu9drTFfYJpyZ699sN8VjhGhAym8+Kaoxx0Z51irWHRJlvvXHVhfhlSreqgYCeSSKRaJB2jXNlMsaksA2Epu0XBLel6mmTCToAQnAFeOxrDMkicyZ2nhC0zEW9Aj2YJupNl4jxpEpJiNhOG4DTgnz7ARmcWsieOMlzCy1GVsnc/CtKZ8KA/pSeJ078+DH9aZCo5xuffujdEI2niTs/F/7JRAdZcV7kBxk5U5M+n08NL2ufqtlHWEsZd1C70KvQ43z58XJ0EoHjGXHGCaCY9Lcl0Cr/ECgdWuVq1mmF8nRn1LsSCTh+A/94UtnU8GW8l1J5h+4NxHSZoigZtfjhDr32XfVL5m1MxM5U4onty8bl3V5VRajN35usei9LfsXwnSD1rvVpiBvyJs/REthvRbjB13vEiBUOgjwcmjwQtd9CvDrA6U+Uf9V8h4Y9/j9bcHneHQm0e2FQcWI444Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(316002)(54906003)(110136005)(478600001)(85182001)(76116006)(41300700001)(36756003)(64756008)(66446008)(66946007)(66476007)(66556008)(4326008)(8676002)(53546011)(26005)(86362001)(6512007)(186003)(6506007)(6486002)(2616005)(71200400001)(122000001)(2906002)(4001150100001)(38100700002)(38070700005)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anArSHVNRldyVU1xeXlKOFFkNWl2TzBqRWF4ZGFsUFNaTzFGWnpDcU1RbkZH?=
 =?utf-8?B?TkFUT0s1dHYvaXNvQmFPdHRNN1JRTTJVSkFGK2dWNitwYTh1czlJWWorQ2lj?=
 =?utf-8?B?UTNsOGtHeVNjVnlhSmczcFI5SlM4WVdQVVJSWU8vUmE4eWZHZml2bzRUMzJM?=
 =?utf-8?B?d242QkhmTy84ZVRyaGVITHM2UUpvQWlMeWZHN2h3MVhPRENIa0hnOEdRbUhU?=
 =?utf-8?B?Zk82OEdsTEdOVmNmZFFHeDlzRkh0anhOLzBKaVVFby9aa08xKzcwM29xbnVC?=
 =?utf-8?B?aFVDbU5TblNhOFYzdEJmZUU3U3B3ZXZSc2Q5YUdrMXJHUFJWT1UvRWlWbFdm?=
 =?utf-8?B?YXFSSUpiQ2E0Ty85WFp1Z2hsVisvUk5PLzB2ZVNOck0wVHVtRkJOY2JjTkFz?=
 =?utf-8?B?OE1ZOVdwcTZpVFl6RU1DaGFEME9GOEY1YWV4L1ZzeHBRYmg1NGFDdGFxNHZw?=
 =?utf-8?B?R1pDbXRRVVV5M3NpeGJxRFdZTTRSS3IzT1BaNVMyWU8wYUJOQmlBOW42MkRK?=
 =?utf-8?B?alhGai9OUDdzdFkxZzhHRGtQYVJ3VEUxNlUycmhBZWp5M0k2RWx4Qm1JMEpU?=
 =?utf-8?B?UDZYWk96TXY3TkxQTmlISm1wSGZPL1d4TXRQU3dBZmNKbkYvU2hzakhPWi9M?=
 =?utf-8?B?bG9rZmNPSU1mNkNES2M1a1phcUFHV0JPZjhtcVZMMVlMTERGcDllSnhiZGhZ?=
 =?utf-8?B?bk9pUUpJaWRmMkxXanRSMEVmdVVGN0o2dENaSUYrTFZaTnoyQ3RSRlI4ek5h?=
 =?utf-8?B?RS8yZ09lZ1VxRWJ4d3VzV2pDalh5d1JpNGR6cWNhZldTT091ci9MRzZ6ekFV?=
 =?utf-8?B?QkY0RDQ2R1QxeTMvMXlBeXlja1I2ZkgyaVAyOTBUS2NDU2YxclUxdWlhYXVZ?=
 =?utf-8?B?SzF3Y0JEY25pMTJmWStoaE5ON0JPSjM2bW9GMks2QWhyenZacERJcCszMFFh?=
 =?utf-8?B?cHhRM3lRcWZQREJjN3BuN1FwdHdXTzhTWDRBY0xoUGpsRzF4aDZYTTBFeDlh?=
 =?utf-8?B?NWUrRzQxRjJ1WE82cGhta1lEM1FKZ1ExbWdxdm8rNlNKenNxd2JET0NSMkdt?=
 =?utf-8?B?SDFYam05RHErRWRwV1M2c21jRUNxZnliVE1mWTd2cWpmeTFBQnJZM2VLcnR2?=
 =?utf-8?B?cGhBRk44TkRhNi94U2hQVmtUZHpxaDY5czV6WWZ1S1Z1SHhIQ1RHcC9lN0tv?=
 =?utf-8?B?UUlxMnpXYUU0ZVRSeGdQVTRiVnRkblk1bkdnY2NDZ0U5WHFmdTE5SXBsYjNx?=
 =?utf-8?B?VFhzN2dwRUR5VW9ORWdiMUNRYkNNODVJMFM4aURvN3NHQW41aDNmYWhBK2JX?=
 =?utf-8?B?Mm8wblVzdkVMZzRwbExjcS92Mk9PWmFBUlEyVmJhNE8zakpLcVB4NmY0WlF4?=
 =?utf-8?B?OStML0QrSjJOR3lkZFNrVEkwWnZVcll2SjRvajZCTlI2Ny9NMm9ibEg1Uk83?=
 =?utf-8?B?WDROZnl6Nm1BaFd6Z2xETDVDd3I1ZkZPSUxsY0h5aThYTW0vMVZEZ2NDVGpt?=
 =?utf-8?B?RmlnNmY5NzRyTUxhcGJOOThvUnNDL1FTYTh0VjIzWmQxL1IxNFJzbS9KRjJw?=
 =?utf-8?B?VmtPK1VmRmFjeklPVjZydWRYUlpIeDFJKytEUFY4R3dUWndzQURBc1hxalNS?=
 =?utf-8?B?UHhuc2hWSk4vblVsVFc0bjE5aWJ0emRteGdRRDl5SUFwbnRDWWtLL1lYMFlv?=
 =?utf-8?B?cmJXd1VGN21QTHBFR0UydXg5aXU0THdmM1ZkR3JWeEp4blRaSWpYUWtPZEd2?=
 =?utf-8?B?emFUempSK0ExS0grcDEyVUdXL2FlZ3JkcVl4MEdBU2xNSjNOTHZIazZTVWpS?=
 =?utf-8?B?aG9aOUQyWjZTbW14Z3EwY3RKb0gwSXc4dzRkMk4rQmdnMjljK3REVk5NeWRo?=
 =?utf-8?B?akJDSW5SVmxGWEpjVU4wY1hrdDRrZmdadm9PWHhXOE5XdndLYkJpVjc5SGJG?=
 =?utf-8?B?REpMUVZTY1RWdUhZTTZMQ1FCNGoyWG9rOFNCN3FVbFMzZHRPSkVvYUpMQWdV?=
 =?utf-8?B?Zis4VHNJQ1A0Wm5jMVBwbURWNFdBczF5Tk1uY3h5aEk3aUxvamhxcmNDY09Q?=
 =?utf-8?B?KzBsVGxKRGFxb1FrVW1GQnBMaFpUZko4ZXB3SGR0eHVMV3ZqellvQkFVTUF6?=
 =?utf-8?B?SzhyWW4vRGVPeFErbG5ORzhxMWpkdmRMUVpRMHZkaDJRTU4zSnRma1hJZkVy?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B78D9D95C9114EA745834963403D4F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e128f59b-0276-43a8-a15f-08dae279d7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 11:03:36.3434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XEVbvknTC6SEy7Ayr8W9SbS3lY+F6njRKN4D12px7Rq4Zpx+CIaRbOSb7FjU5DsLQ6ogz7mSPSKJKeAEKRt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCBTVlMgcHJvYmVz
IGZhaWwgYXMgYmVsb3cgb24gbXkgTVQ4MTkyIHBsYXRmb3JtLiBJZg0KdGhpbmcgaXNuJ3QgdG9v
IGxhdGUsIHBsZWFzZSBkbyBub3QgbWVyZ2UgdGhpcyBwYXRjaC4gSSdsbCBhc2sgUmljYXJkbyBo
b3cgdG8NCnJlcHJvZHVjZSB0aGlzIGlzc3VlIGFuZCBnaXZlIHRoZSBjb3JyZWN0IHNvbHV0aW9u
LiBUaGFua3MgaW4gYWR2YW5jZS4NCg0KI01UODE5MiBwbGF0Zm9ybSBTVlMgcHJvYmUgZmFpbCBs
b2cNClsgICAxMC4yMDk0MzBdICBTVlNCX0dQVV9MT1c6IGluaXQwMiBjb21wbGV0aW9uIHRpbWVv
dXQNClsgICAxMC4yMTQ0MDJdIG10ay1zdnMgMTEwMGIwMDAuc3ZzOiBzdnMgc3RhcnQgZmFpbDog
LTE2DQpbICAgMTAuMjE5NDc5XSBtdGstc3ZzOiBwcm9iZSBvZiAxMTAwYjAwMC5zdnMgZmFpbGVk
IHdpdGggZXJyb3IgLTE2DQoNCkhpIFJpY2FyZG8sDQoNCkNvdWxkIHlvdSBzaGFyZSB1cyBob3cg
eW91IHJlcHJvZHVjZSB0aGlzIGlzc3VlPyBJIGhhdmUgTVQ4MTkyIENocm9tZWJvb2sgYW5kDQpj
YW4gZ2l2ZSBpdCBhIHRyeSB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHlvdSBlbmNvdW50ZXJlZC4g
VGhhbmtzIGEgbG90Lg0KDQpTaW5jZXJlbHksDQpSb2dlciBMdS4NCg0KT24gRnJpLCAyMDIyLTEy
LTE2IGF0IDEzOjQ3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiANCj4gT24gMzAv
MTEvMjAyMiAxMjowMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gSWwg
MjcvMTEvMjIgMjE6MjIsIFJpY2FyZG8gUmliYWxkYSBoYSBzY3JpdHRvOg0KPiA+ID4gSWYgdGhl
IHN5c3RlbSBkb2VzIG5vdCBjb21lIGZyb20gcmVzZXQgKGxpa2Ugd2hlbiBpcyBib290ZWQgdmlh
DQo+ID4gPiBrZXhlYygpKSwgdGhlIHBlcmlwaGVyYWwgbWlnaHQgdHJpZ2VyIGFuIElSUSBiZWZv
cmUgdGhlIGRhdGEgc3RydWN0dXJlcw0KPiA+ID4gYXJlIGluaXRpYWxpc2VkLg0KPiA+ID4gDQo+
ID4gPiBGaXhlczoNCj4gPiA+IA0KPiA+ID4gWyAgICAwLjIyNzcxMF0gVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQo+ID4gPiB2aXJ0dWFsIA0KPiA+
ID4gYWRkcmVzcyAwMDAwMDAwMDAwMDAwZjA4DQo+ID4gPiBbICAgIDAuMjI3OTEzXSBDYWxsIHRy
YWNlOg0KPiA+ID4gWyAgICAwLjIyNzkxOF0gIHN2c19pc3IrMHg4Yy8weDUzOA0KPiA+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3Jn
Pg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IA0KPiA+IA0K
PiANCj4gQXBwbGllZCB0aGFua3MhDQo+IA0K
