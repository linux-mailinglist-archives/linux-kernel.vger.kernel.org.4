Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BED654CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiLWHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiLWHry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:47:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09A31DE9;
        Thu, 22 Dec 2022 23:47:51 -0800 (PST)
X-UUID: 7e235ae601f84f4cacf9b020ea0ee73e-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xA8w5KNd1PjhE/u/da0VjYcd1ypOzecCyRpVXlZtDk0=;
        b=Bt+qdVVfOnRBJVNrPANtqGne5UTaFmsCvN8CkKbw0kp26N7D1V5TJejYlZqrZct/mywaI+0O2uhBqfY7UcMdJZNFu/vI0l2q3tG3mbTk5WeM1fdpbYSGJ9QesBs3no3aGD7baKG48HV9HlLOfGB1H2VzrcEB2NYelR+Ib32Q/vM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:14f173db-5f8d-4f3a-ac51-a9e02e7ae7c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:14f173db-5f8d-4f3a-ac51-a9e02e7ae7c5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:2eda338a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2212231547479RWLEPZD,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7e235ae601f84f4cacf9b020ea0ee73e-20221223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 627515383; Fri, 23 Dec 2022 15:47:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 15:47:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 23 Dec 2022 15:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEzQp0m25qFRfZ91eMu2tX7eVL+LZGvVoRzx9qhy3PsMeHAOptk34T9btGCVo8JA28xV2soG1kAkaFYz7DoQuOBDhWDsO+h/8/+Tz2Jxjt/ZCTEmYgp8E9SJSvhql5V1kdlxAsoOZwXGPvpzgLtIACh0vLxjdb6plaChVOOwq8U5dcL8Sm1gw8fjhyZe8wq9fsw+ASBz4XyMCYR854ZQhqL7jiHXS2Av6yZSyrcGiYqk42Escd3N/EJvoRHrC/sT82Dj6aIRpyrVyGyg8y+ZXSjAZyWbvAhY20FyXHizt56O/xD04CJKInf+7TircJv6uswQ5GIzpiNngQZzA1JizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA8w5KNd1PjhE/u/da0VjYcd1ypOzecCyRpVXlZtDk0=;
 b=c0K3s8Pz+9MY7HkPejooBcTBkDRNM2DVbsHYjx4EolgiwoZU7+bY9SrTbqbjfvjV7YslECX+SRsH8KJB3iCNfRWrPjRqDjZFIqyvj2rm6lsJClq0wMa0qbBDsg3RxgoIB0I9/vE/6snHQTrCtq6/TvwuQw0EiVFyMeMEEwnhrthtt6ai4T2DJInT1K0yaLQQsfqCPpmdjCcvr1LVboRt212F06n6K1BYYmsUW6n7xnyfmOXLGk5bVOMdYtlUCGMj3f3o+ZsjCXhn74uL5EbqPiqRaY6P+wz0M/Q4yCiRv3ioNarhlMR+CweQj+nQD7ptahcDUMBcvLIjN00wecrvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA8w5KNd1PjhE/u/da0VjYcd1ypOzecCyRpVXlZtDk0=;
 b=TJtgNMPoj4og8tS6T8xzdBIjEHH+X9ZAXfUzW/WldiXhBXnG+3+ZZE3BN2zpfYoFh6/+qiGyE1g2C5tfTdbxwShEz63y+dnCNw3FKwKFsurN9+vIxH2Z5klKRYUh/LiurPhXgeebKo7i/lrPNONc936s+flBS0fpSB+Gb6uuaUA=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 TY0PR03MB6425.apcprd03.prod.outlook.com (2603:1096:400:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 07:47:42 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 07:47:42 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8188
Thread-Topic: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8188
Thread-Index: AQHY0xacBLACySQjSEmWgnHQQK+7+a397c8AgFFnn4CALEoQgA==
Date:   Fri, 23 Dec 2022 07:47:41 +0000
Message-ID: <ebfd78894b326488a4321e8eed9dbc61b459f88b.camel@mediatek.com>
References: <20220928084315.29187-1-Garmin.Chang@mediatek.com>
         <20220928084315.29187-3-Garmin.Chang@mediatek.com>
         <ca0f9e3c-ae3f-b886-bfe9-63d7e45c9b3c@collabora.com>
         <ce3a47c67d4ac8a364cdea6cc4dda1d9c015b3d8.camel@mediatek.com>
In-Reply-To: <ce3a47c67d4ac8a364cdea6cc4dda1d9c015b3d8.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|TY0PR03MB6425:EE_
x-ms-office365-filtering-correlation-id: 403908f9-eaf5-4cab-13de-08dae4b9f8c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leBTf2GxmES0Df4THeEqBOv5Ir+l8sS7o+4MNvm/PQFdQRfIA22rfo3jtZUX2SYIWMz1wvRf4fcpI3uBMjojBn1Tn0dbOjfHozeZVgp4M4Ube2VgNxKZ3tdLLUHl7GcNYwuURNyTr/ruY6+1V1DpXt+f0D8D1uClN9RgsY41V2+KU3Tl9EydHnrGxne77CVfBqrXra5hkWip25LZgZVy7CaRwYSnfx8AmzMiSuA4BviY5G4NyjIgcaJGeTo9nCNGfpkKteI9n6kVAG5nHDHhSeENIWoGD+ivbzuthsU0xb1MVxOlYcZX7XjYPxpFskAuIuJXKgtahpAwIpTB8vRS4Vda9LNYtpUHaCDQFdqbm+0u4JRNV0zOVBuAjf9ICztY+nFARusLkuEd71ApNPHL22VHW7wAkwJVKUYQu5JAe0ltaxmYLAUtTv2r1mVRhHepmeNkcQ6oZUgKqa4JHDSSHmtozn8Ko+JIrw2LLygyffU57pp6Wb0kjEerK1xVSsM44ccqE+LFlQgF+5ZHI9ciTPmIgKf+cLFW0iXyV1RkBKsvj26K0mAecLgXeDI+L5lFoAazNV9Gqe1ZqCN+6J9S8LV8dUnuLLFeLdJRASty1XTYJk9HU7H+Dey350WQv0MiN5rwSHVRi74nNVoENIOhDRO1G9g0QYQ82niKY9YVDo/eD806UhX+m2ppPYWgdMdeNQOXizngEOV6NTauDrIEUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199015)(38070700005)(85182001)(36756003)(86362001)(186003)(41300700001)(2616005)(316002)(4326008)(5660300002)(122000001)(64756008)(6486002)(478600001)(6506007)(2906002)(6512007)(26005)(66556008)(66476007)(8676002)(91956017)(71200400001)(66946007)(54906003)(66446008)(76116006)(110136005)(8936002)(38100700002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmdwamVraDhYczZYalI0ZFZHeUFxUjFOVHJ2dEtwNTAyOExkaGtYWEVWdTc0?=
 =?utf-8?B?RWhIMWhDU3YveExML2VyT3lOWFl1R3lBWUhHcHlSWENWcHJPYmEyNGl6Rkll?=
 =?utf-8?B?dHdmV1RNYW1Zcy9NMnVPYWVEVThQSEVyemxxZk9uRjdIeWtJYVdnOGcwZWw1?=
 =?utf-8?B?TElobWVzZ0o0R3ZBdXloRjl2TkZWNnFGS2NLOFJlUnJQTUhvTmZWM2IxV2Na?=
 =?utf-8?B?a0NCNUJoK0VHU1JZdkxDaVM0QjJ5c3VKb0pkbXlTVHhOU0RZR2J0eTRlZHdT?=
 =?utf-8?B?T0d6aTZGVHBkTzdveFRNeUNrSDIyaVFLemJ4SEhvd0Y5RGNxcjg5TExNblh3?=
 =?utf-8?B?M0Y5amlZRFljVjB0QmUvUjkwNk1WSldwTndHT3hhb0VKQ1Y4RUtKV2Z4b3V1?=
 =?utf-8?B?VFgxTkd6VHpGSGxsZm1zemZCbEE2blR3c3JpQUJKT2FZaW5IOXlwaFpvQk1F?=
 =?utf-8?B?OHhTMVZtZTJSSGQ0MXZQdkt4Yjk3R3daSlVPZStPby9aa3kzbldqVXpwcXEy?=
 =?utf-8?B?bHdzK1Y5L1ZjTTNYR0I2MWxLSWUwbHk3dFJLdUdFN0Z6QkNEbFV3b3d1RHN4?=
 =?utf-8?B?UEhCQndTWU5NMURuaWlaTExIQ3hYZ08wdExEKzVsYmNyWlNSQTVwMWVmWWFS?=
 =?utf-8?B?VzBQbzBuU1FhNm01RVhuNTMyc2NJa3ZBME5VY0xzZ3dPMnhXR2dmeGR4M3Jk?=
 =?utf-8?B?Q0g5WUQ3dUpzclN2Qi9BcTRhZGhJZ28xam5YZ0ttL0ptN2I3U2xTYW1ZMnVX?=
 =?utf-8?B?M1NwTzQ3UkZiS1JMbGpiNmdnSi9hU0RRcGhtNVJnYTg1VXR3bkxrMklJekpm?=
 =?utf-8?B?Q3ZycFFZZXVJdHVIV1YvM25mZGNtMStJUVJjYUlGbWNnYUtEeUNJRHZmWU5P?=
 =?utf-8?B?WCs3M1BOa0pTYUp3SkpEa21WRys0QjV1eERFQUtrNGlta25yK1RFaGNCQlN1?=
 =?utf-8?B?c2x3UW5aZ0pNOVpWeEF5YlVCVXBRZTQrZEFJak5TMVRKcDRDbVpHSlB0VHN0?=
 =?utf-8?B?OEhKbkx5eHZrQkFVckVXRk11b0cveThRSEZEb3pzZkhGWXlvMHhNTVYvUUJv?=
 =?utf-8?B?bjBtbFFLdFR2NXAyamlOTUJTUVpWR0VaWk55Sm5YcFRudG5TMkdqY05nMVBx?=
 =?utf-8?B?elQvMUdSQ28xU3ZvRVpuSVUrSENYc3hIeFpLU25ETkpEYzdGU2d0dHFaRU52?=
 =?utf-8?B?anV2M0E4UmZHUlJWbk8zQjFobFZVVXJXNXFzYWk5bWZMSW9PNWZwWHFheHhC?=
 =?utf-8?B?eWNpQ1hMdCtpZVY4YzNRWUVQTFYrc2lseHlvQzdFdEQxV0dteGpHU0tJTDFJ?=
 =?utf-8?B?TzJoT3poQTdhc3N4d29IN0cwYTZ6Uk5zQnkxY2ZDWE45Tmpqdm92aFlsUHdU?=
 =?utf-8?B?V3c0Tmw3TFZra1dJRmVDN09XWWxsWWlxcEc2MC9LQ01LSnBpS3B1MnFrKzg3?=
 =?utf-8?B?TURrazRSR3FNQ0FZL04xWUhWRFNoNVRPOVZBUGdPTjVZakxRUDFBbDJrV1VQ?=
 =?utf-8?B?WXBIVzNhaURaMVZFd09qWHhOUGh4NFFyeTVBeDdZTVlFUldGRDNxM2hZYkxw?=
 =?utf-8?B?aVI4aVYrTXhsMXVhOVdrdDJ4ckIvZHVkUmhMUGJ3cnVDdCt1cTV6VkkzeFdL?=
 =?utf-8?B?dS81aGtZSHIrV0lSWlJtUHgzQmdWK2xIMUhPeHpmbVJtRWo5T0VVK3BtaGVx?=
 =?utf-8?B?T0RPY3kyb1hTYVpnY0thWVE5MmhDR3pqQk80YlRNcG1YNDJ0K3BXMisxZnF4?=
 =?utf-8?B?MVdKeDY0MlVyNDQ0b0pkMDgrY0p2dVNzU3pieklzK09iUmU3U3IwQ001L29a?=
 =?utf-8?B?T21UVWlicVJuZVVDNXhkMXM0TWJydjdoUFJLcHRrYjZ4WjNUTDYzS09oc3lJ?=
 =?utf-8?B?b0pNY0p4dStQRllJOTBMem1SV0VXdTl6WkhYM3ZrbzZhc2I3TDR4V040elNL?=
 =?utf-8?B?bkZMblRyTmhEb0s3eTh3UEFOQ0F1QVlRNE03Uzh0UWxFZFk4TzhsUnRORzhs?=
 =?utf-8?B?MVI3eDhlbWpWVGpyOXoyNWlDOW9MNzYxaytMQnlIN0YwWVFERFN3Q2JzVHgy?=
 =?utf-8?B?MEVDcDQ4dnVCMWNNVmhRR1VmeE1SWmljVEZDaE40Z2ZDa0dBd1FEYnEwZTdZ?=
 =?utf-8?B?Nm9NUXJPbUhBTjd0VEVqNWVuRGZHS0o5cGhiWTh1VFo5L1Z5S3pONFRDbmlx?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65981B148010FF4E803290E8A29E4AE2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403908f9-eaf5-4cab-13de-08dae4b9f8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 07:47:41.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mO920ri92XHERW4CRtRy/TP8f/SCMrmEjX8+th7cNjDRBNpK9+fD11zAXHqtkRi0xlZx7Kky/kGk4NFJaDKYvD2bjW39mzCb8zgsd0uM8R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTI1IGF0IDExOjI3ICswODAwLCBnYXJtaW4uY2hhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyMi0xMC0wNCBhdCAxMDoxOSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gd3JvdGU6DQo+ID4gSWwgMjgvMDkvMjIgMTA6NDMsIEdhcm1pbi5DaGFuZyBoYSBzY3Jp
dHRvOg0KPiA+ID4gQWRkIGRvbWFpbiBjb250cm9sIGRhdGEgaW5jbHVkaW5nIGJ1cyBwcm90ZWN0
aW9uIGRhdGEgc2l6ZQ0KPiA+ID4gY2hhbmdlIGR1ZSB0byBtb3JlIHByb3RlY3Rpb24gc3RlcHMg
aW4gbXQ4MTg4Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHYXJtaW4uQ2hhbmcgPEdh
cm1pbi5DaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXQ4MTg4LXBtLWRvbWFpbnMuaCB8IDYyMw0KPiA+ID4gKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyAg
ICB8ICAgNSArDQo+ID4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgg
ICAgfCAxMjEgKysrKysNCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3NDkgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg4
LXBtLWRvbWFpbnMuaA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXQ4MTg4LXBtLWRvbWFpbnMuaA0KPiA+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dDgxODgtcG0tZG9tYWlucy5oDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi42MzE4MWYwNTQ1N2UNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4OC1wbS1kb21haW5zLmgNCj4gPiA+IEBA
IC0wLDAgKzEsNjIzIEBADQo+ID4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seSAqLw0KPiA+ID4gKy8qDQo+ID4gPiArICogQ29weXJpZ2h0IChjKSAyMDIyIE1lZGlh
VGVrIEluYy4NCj4gPiA+ICsgKiBBdXRob3I6IEdhcm1pbiBDaGFuZyA8Z2FybWluLmNoYW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiA+ICsgKi8NCj4gPiA+ICsNCj4gPiA+ICsjaWZuZGVmIF9fU09DX01F
RElBVEVLX01UODE4OF9QTV9ET01BSU5TX0gNCj4gPiA+ICsjZGVmaW5lIF9fU09DX01FRElBVEVL
X01UODE4OF9QTV9ET01BSU5TX0gNCj4gPiA+ICsNCj4gPiA+ICsjaW5jbHVkZSAibXRrLXBtLWRv
bWFpbnMuaCINCj4gPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbWVkaWF0ZWssbXQ4
MTg4LXBvd2VyLmg+DQo+ID4gPiArDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBNVDgxODggcG93ZXIg
ZG9tYWluIHN1cHBvcnQNCj4gPiA+ICsgKi8NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHNjcHN5c19kb21haW5fZGF0YQ0KPiA+ID4gc2Nwc3lzX2RvbWFpbl9kYXRhX210ODE4
OFtdDQo+ID4gPiA9IHsNCj4gPiA+ICsJW01UODE4OF9QT1dFUl9ET01BSU5fTUZHMF0gPSB7DQo+
ID4gPiArCQkubmFtZSA9ICJtZmcwIiwNCj4gPiA+ICsJCS5zdGFfbWFzayA9IEJJVCgxKSwNCj4g
PiA+ICsJCS5jdGxfb2ZmcyA9IDB4MzAwLA0KPiA+ID4gKwkJLnB3cl9zdGFfb2ZmcyA9IDB4MTc0
LA0KPiA+ID4gKwkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MTc4LA0KPiA+ID4gKwkJLnNyYW1fcGRu
X2JpdHMgPSBCSVQoOCksDQo+ID4gPiArCQkuc3JhbV9wZG5fYWNrX2JpdHMgPSBCSVQoMTIpLA0K
PiA+ID4gKwkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGIHwNCj4gPiA+IE1US19T
Q1BEX0RPTUFJTl9TVVBQTFksDQo+ID4gPiArCX0sDQo+ID4gPiArCVtNVDgxODhfUE9XRVJfRE9N
QUlOX01GRzFdID0gew0KPiA+ID4gKwkJLm5hbWUgPSAibWZnMSIsDQo+ID4gPiArCQkuc3RhX21h
c2sgPSBCSVQoMiksDQo+ID4gPiArCQkuY3RsX29mZnMgPSAweDMwNCwNCj4gPiA+ICsJCS5wd3Jf
c3RhX29mZnMgPSAweDE3NCwNCj4gPiA+ICsJCS5wd3Jfc3RhMm5kX29mZnMgPSAweDE3OCwNCj4g
PiA+ICsJCS5zcmFtX3Bkbl9iaXRzID0gQklUKDgpLA0KPiA+ID4gKwkJLnNyYW1fcGRuX2Fja19i
aXRzID0gQklUKDEyKSwNCj4gPiA+ICsJCS5icF9pbmZyYWNmZyA9IHsNCj4gPiA+ICsJCQlCVVNf
UFJPVF9XUihNVDgxODhfVE9QX0FYSV9QUk9UX0VOX01GRzFfU1RFUDEsDQo+ID4gPiArCQkJCSAg
ICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOX1NFVCwNCj4gPiA+ICsJCQkJICAgIE1UODE4OF9UT1Bf
QVhJX1BST1RfRU5fQ0xSLA0KPiA+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9T
VEEpLA0KPiA+ID4gKwkJCUJVU19QUk9UX1dSKE1UODE4OF9UT1BfQVhJX1BST1RfRU5fMl9NRkcx
X1NURVAyDQo+ID4gPiAsDQo+ID4gPiArCQkJCSAgICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOXzJf
U0VULA0KPiA+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl8yX0NMUiwNCj4gPiA+
ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5fMl9TVEEpLA0KPiA+ID4gKwkJCUJVU19Q
Uk9UX1dSKE1UODE4OF9UT1BfQVhJX1BST1RfRU5fMV9NRkcxX1NURVAzDQo+ID4gPiAsDQo+ID4g
PiArCQkJCSAgICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOXzFfU0VULA0KPiA+ID4gKwkJCQkgICAg
TVQ4MTg4X1RPUF9BWElfUFJPVF9FTl8xX0NMUiwNCj4gPiA+ICsJCQkJICAgIE1UODE4OF9UT1Bf
QVhJX1BST1RfRU5fMV9TVEEpLA0KPiA+ID4gKwkJCUJVU19QUk9UX1dSKE1UODE4OF9UT1BfQVhJ
X1BST1RfRU5fMl9NRkcxX1NURVA0DQo+ID4gPiAsDQo+ID4gPiArCQkJCSAgICBNVDgxODhfVE9Q
X0FYSV9QUk9UX0VOXzJfU0VULA0KPiA+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9F
Tl8yX0NMUiwNCj4gPiA+ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5fMl9TVEEpLA0K
PiA+ID4gKwkJCUJVU19QUk9UX1dSKE1UODE4OF9UT1BfQVhJX1BST1RfRU5fTUZHMV9TVEVQNSwN
Cj4gPiA+ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5fU0VULA0KPiA+ID4gKwkJCQkg
ICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9DTFIsDQo+ID4gPiArCQkJCSAgICBNVDgxODhfVE9Q
X0FYSV9QUk9UX0VOX1NUQSksDQo+ID4gPiArCQkJQlVTX1BST1RfV1IoTVQ4MTg4X1RPUF9BWElf
UFJPVF9FTl9TVUJfSU5GUkFfVkQNCj4gPiA+IE5SX01GRzFfU1RFUDYsDQo+ID4gPiArCQkJCSAg
ICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOX1NVQl9JTkZSQV9WRA0KPiA+ID4gTlJfU0VULA0KPiA+
ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9TVUJfSU5GUkFfVkQNCj4gPiA+IE5S
X0NMUiwNCj4gPiA+ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5fU1VCX0lORlJBX1ZE
DQo+ID4gPiBOUl9TVEEpLA0KPiA+ID4gKwkJfSwNCj4gPiA+ICsJCS5jYXBzID0gTVRLX1NDUERf
S0VFUF9ERUZBVUxUX09GRiwNCj4gPiANCj4gPiBQbGVhc2UgYWRkIE1US19TQ1BEX0RPTUFJTl9T
VVBQTFkgY2FwIHRvIE1GRzEgYXMgd2VsbC4NCj4gPiBGb3IgbW9yZSBpbmZvcm1hdGlvbiwgcGxl
YXNlIGxvb2sgYXQ6DQo+ID4gMTNiZGUxNjljNmZlICgic29jOiBtZWRpYXRlazogbXRrLXBtLWRv
bWFpbnM6IEFsbG93IHByb2JpbmcgdnJlZw0KPiA+IHN1cHBseSBvbiB0d28gTUZHcyIpDQo+ID4g
DQo+ID4gUmVnYXJkcywNCj4gPiBBbmdlbG8NCj4gPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91
ciBzdWdnZXN0aW9uLg0KPiANCj4gQWNjcm9kaW5nIHRvIC9zeXMva2VybmVsL2RlYnVnL3BtX2dl
bnBkL3BtX2dlbnBkX3N1bW1hcnksIG1mZzAgaXMgdGhlDQo+IHBhcmVudCBvZiBtZmcxIGFuZCBt
ZmcxIGlzIHRoZSBwYXJlbnQgb2YgbWZnMiwgbWZnMyBhbmQgbWZnNC4NCj4gQmVmb3JlIHRoZSBk
ZXZpY2VzIHBvd2VyIG9uIG1mZzIsIG1mZzMgYW5kIG1mZzQsIHN5c3RlbSB3aWxsIHBvd2VyIG9u
DQo+IG1mZzEgZmlyc3QuIEFsc28gYmVmb3JlIHRoZSBkZXZpY2VzIHBvd2VyIG9uIG1mZzEsIHN5
c3RlbSB3aWxsIHBvd2VyDQo+IG9uDQo+IG1mZzAgZmlyc3QuDQo+IEJlY2F1c2UgbWZnMCBpcyB0
aGUgcm9vdCBvZiBtZmcxLCBtZmcyLCBtZmczIGFuZCBtZmc0IGFuZA0KPiBNVEtfU0NQRF9ET01B
SU5fU1VQUExZIGlzIGNvbmZpZ3VyZWQgb24gbWZnMCwgc28NCj4gTVRLX1NDUERfRE9NQUlOX1NV
UFBMWQ0KPiBpcyBhbHNvIGFwcGxpZWQgb24gbWZnMSwgbWZnMiwgbWZnMyBhbmQgbWZnNC4NCj4g
DQo+IFRoYW5rcywNCj4gQmVzdCBSZWdhcmRzLA0KPiBHYXJtaW4NCg0KDQogIEkgd2lsbCBhcHBs
eSAxM2JkZTE2OWM2ZmUgKCJzb2M6IG1lZGlhdGVrOiBtdGstcG0tZG9tYWluczogQWxsb3cgDQog
IHByb2JpbmcgdnJlZyBzdXBwbHkgb24gdHdvIE1GR3MiKSBpbiBuZXh0IHZlcmlvbi4NCg0KPiBU
aGFua3MsDQo+IEJlc3QgUmVnYXJkcywNCj4gR2FybWluDQo=
