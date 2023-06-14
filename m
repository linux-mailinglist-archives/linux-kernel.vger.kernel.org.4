Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2791472F94D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbjFNJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbjFNJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:31:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDE2128;
        Wed, 14 Jun 2023 02:31:06 -0700 (PDT)
X-UUID: c3737b0a0a8f11ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=xTqel8hSqbsfxkd/wpDdX8bfS8NNhkhKYF2r3wkgmbE=;
        b=a65X+iYmeo/cxz+KLkRUA2Lne3oP8kAOG9o6hamju+dqtWrydZrsFJpfT/fP2HuC9ezBbXcM83bYLvLR8EvwztKGYHbws9skQ3/uYWBCSpGHsyf9SFCBOE5eDJN3AArcgwKSfVLsJpRk908mqC1/FFbon+jg/y9mZHtRltxcwrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:f99af8ad-1470-423d-bfdb-7995bf506ba5,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:b2e2643e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c3737b0a0a8f11ee9cb5633481061a41-20230614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 189467772; Wed, 14 Jun 2023 16:45:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 16:45:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 16:45:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUETQIiRjkLMuzLk8vVZ4bPznQ3L1StYtYb0daw95a8PHswBcYPYhjRcyqBomDydCOgdHm5chyZMksGkfi3jJ2fs06WS9l1JzWo+82f6twkA4+PICwam4MHMv0WFGS2YZmZ7qs9GdrCmH6Afdm/pB3P7e5/Dw0GVRwMwVuLOmWbSwn/IssgAT6bduRqoZRg8Vz1EMuefxxNI3RvybOyzti5fGdqjFgY/ibUB/xjgQDioVH8GkdWOxGDVu8IjS/7NBMForLkWESzTse9n+QumeekMvsmmJh4XfTlq5kfPLJIn5fXBaz/KhnTXlEu1nSEkyIgPjVfN82KwA9ryqGTTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTqel8hSqbsfxkd/wpDdX8bfS8NNhkhKYF2r3wkgmbE=;
 b=AKHA/Z48DBMcI2Xl60TH838o+4DcRtTVCIDCgnKITXMA2H8CEJRx1cIB2Bn/Nr0pHN1yk6ecSiWj/zzVfUnc84cXVpvYwWPrjDado2yoAej538iJKmAcMw7oIzZbClM5S7YoyMQ/dZxVyvGaCt5CSO8g9h3Gig0kcnCmqLPGuj3qUjebu2gBEcIUSE/EM6WTW0ONwQDOdzqd28yELK92wOn6K1tDwpwp/7287VPZA848JU7/NYJmz0UN/Af04tsFFvD146mHVCMgKsHA8EvWBWoGJnzdt37B0ks6For+4VlUBT/R36P9C/O3jXb5Bst8FERKb+DjubDq8oMzpgjZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTqel8hSqbsfxkd/wpDdX8bfS8NNhkhKYF2r3wkgmbE=;
 b=Xjbn6fjYg5UcjF6zGZ65T92Kl0woTGbHtKnZ7gkAT807/kV1SCmNld1eDEpUXlh3X8snIX3lFub0BhjTP6zxnVESIQaQDpz4btVN9+qTHaopgT8mbFWOe+R00/+a8h9gLLEqCMAsJqibcYURNozypJz9T2qw4aBZOHwuNzSYAhk=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5632.apcprd03.prod.outlook.com (2603:1096:400:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 08:45:03 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 08:45:03 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
Thread-Topic: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
Thread-Index: AQHZnRxrxfjJMnUoLE+/r69NNJMkHK+IbaGAgAF/QQCAAAusAIAABj0A
Date:   Wed, 14 Jun 2023 08:45:03 +0000
Message-ID: <6a1b30d773556b0cd0bb3fb9061ee5831358d69e.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-7-maso.huang@mediatek.com>
         <7bf1395a-eba8-fe27-a359-9c50af7add2a@kernel.org>
         <c87eadd9fc8d0ef9dc4582493e540f0b311e06eb.camel@mediatek.com>
         <ea7b94b6-37fc-1352-9849-66a49dd1b39f@kernel.org>
In-Reply-To: <ea7b94b6-37fc-1352-9849-66a49dd1b39f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5632:EE_
x-ms-office365-filtering-correlation-id: 1e377f4d-0ee7-49e9-2614-08db6cb3a56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVm1iyTSxJQXnrjUgKlxxi4QqcUCHvrsJAc7Y+6MMecfXVVaOYDfB3+xRa5E1rNj/nm7zipOlhYKpdoRLm/AgfHCJ03HGjoJBEdktdaGdxWnXLNMMuOuRwB9JJfOqAqraTzVU/qmaueUX97aDWYTNeopl3HBaQCD+HRwRW1tHE3ycSuD8rsavKtP/FcJfoIPQH2BQJ+UBaIAUVIKIL/9V9pWbqk7qlvWfj0/ubRVJOawCNo3amXY5/knWh8lGhwR6YePYP2jI08rPiNcgQgTXJUZtqMqQMBNeThmcqkoLdeRX8jm7vOML7gBpNl21coWhlBiqgYeiv+aXBhXFsuqu4FylM5P7egd6hhV/I1+rY1Vp0S37h0RuBIACNVSndEy53Pd6G8+Kzl8vGv167epDLnCpirPixLbEuRTlVQX44vYYwY8TMnVpwajcdm+PFGdHrZxXLvfGg/9+QQGX+2aD2r8qeDvF2xrXRU0hOqF5jJfPvB+YTAcD3zBHOczzq0YjmlKd8wdHfU+6eKKnTtKasbJiFjHMDQzSwnNeaqaL9oosv6raXtfxFzWC/Ry/ZGsrtJKdYktbFG7723oZYPdvHwSo68igagMZWVIS+pQc/p76AbD/+ZH8AeLzYRWtq30Ap+Zlr1CGHgu6MUEdsGCocclCSjnOz8p/Uzx+o3sm/M5Dy71qoqyEN1l7rfPKYaiMlY1i14XNIcnLurfBTRUDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(122000001)(921005)(38070700005)(38100700002)(86362001)(8676002)(8936002)(83380400001)(5660300002)(7416002)(316002)(41300700001)(91956017)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(6636002)(110136005)(2616005)(36756003)(478600001)(186003)(53546011)(85182001)(6506007)(26005)(6512007)(2906002)(6486002)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZxY3ZaN0ZISjlnSDdnT1pFdnE1cWFZN1ZMcHdmdGpBdytqemlua0lwLzNw?=
 =?utf-8?B?eVlvd01vWUFSaENBc1U5QVAxc0o3Q25taXZRdE9iLzIvM1FiSWdkc1c4R1V1?=
 =?utf-8?B?NmNLY0grWXE0UkRGWVRRbXFuckNRUkZLbGovekd1SHRmME5ITkQwUmZSally?=
 =?utf-8?B?V0xYUkZvTUU4VHZieVZkRG9WUUpVNUp4VzJ2K3dEYmVUK0RYV1FxNkx4Y3Z3?=
 =?utf-8?B?eTZ0QSthUERra0hIUWlBRFp3azAwRFpzVnYxNys3T0UwWXBIamNrUndrUjV0?=
 =?utf-8?B?YVpLa3BVZUMzUno0VWV2ak12WDhZRzY5Y2RoM045MDRYb09aemloYlZqbVcw?=
 =?utf-8?B?cVllNlcxY1lsWFpKOU45SnNaS0daUWY5MFZWSi83Vmg4WVJESHRsby9SZFJP?=
 =?utf-8?B?cGs1b09nVE9NSUdoMVpSdDE1UjVSWjZDZjhVUEFtSTJiT013bEsya0V2b0x4?=
 =?utf-8?B?dHNoSzZhSEtwUU4vTkxPR2M0TjBoWnhKVHkvTzZFZ1Z5QlV5TFNOZXJDMkI5?=
 =?utf-8?B?ZnBFeVNEWWQwWmRrTmFWZGpzN0RCdVdWaEIzTFhGeEV5WU9HemdoUldNb3hh?=
 =?utf-8?B?QVJNZUpVRUkxVjBCK2dtQ2dpcUwxS2QrMHBPeWwvVWQyS3BvbUZDcmpKMVNx?=
 =?utf-8?B?NnI0b0tSTHdNcnBNSmlUanUrem1DR09aMXBSbFk4aDkwaGdBclo5YnRrOUtK?=
 =?utf-8?B?Z3VYL0ozQWdpSGRHYTh2OXdyNmo4WnoySUJIdXlIZDhPdm15UExPV1NKR2NJ?=
 =?utf-8?B?YjIzdFp1NEF4V25zTmwwQVlFaUt2UlBpNndHMk9wbG5sKzZsT3pCQjVlQ3lL?=
 =?utf-8?B?SWJ2ZVBZa1lXbENIWjIxZ2ZndFlRUXQzT0twZ2Q3ZktoTkdtbld5Y3BzeG5Z?=
 =?utf-8?B?L2dOZ0hyOXNnZ3IyVlBIUVZURTBqQUpEbkZTUWFjUG9EY0U0aTBXOWQzNUps?=
 =?utf-8?B?cFJEbmQwWm8reEdqM2Urcit1Yjd4a0xMU2paOTFhcWRFb3BXU1pkc3pQaWVF?=
 =?utf-8?B?eUg1Nk1Hd0NlWG0xWVNQN0FnaUplOHVoZTFGV1RHeCtQR21adEhRVy9qUk1M?=
 =?utf-8?B?SlZLTnVaVXczQzR6S29NWWFNSlBZUDNZRXA2UzhMbFBuTFFKdEV5cG1mSGkv?=
 =?utf-8?B?a1BVNnFQeURaWlZSZjFrVnUzNElISzdQNzRSQkJjVFVWYU11akxaYW1ZcUJH?=
 =?utf-8?B?V2tnM0RBNVI3MDdWeFgwd3N5SWkxRDJnUndCNWRqazZDTVQwTFEyc1A2d0VK?=
 =?utf-8?B?NkllQ3RwSXZlRzh3SnpQWERjc09vWUdxYVNZZmpyTGlMMGphOGY5U2FLcC9B?=
 =?utf-8?B?NTFBczVuRWUxdklVb0hkWlIxa0wyd25oS2JnRUxtcDQzZDIyUkRIYS9uRXY5?=
 =?utf-8?B?d0RMRXRaMWpINHVHOWYxblVBekpTNStGbG5xR0Era203UTFRQlFDRng1bXJz?=
 =?utf-8?B?azNiNmVraGU0VVZSY3h6Rng0K1FucXBBMzZ2amp5eUdDM1BzRjc3Y2tOU1JE?=
 =?utf-8?B?TjdvK0JKamlvaVhpZlJPT0dSMDd1TTJrNHNjS2xCSzJCNmxQazYvUXhFeHZH?=
 =?utf-8?B?Qm9ZZHhuYmxmN1FaenlEZmNZVk1RQTBtdG1JWFVuSWo1blBkQ0c3RjVlR2lW?=
 =?utf-8?B?OGhrSEN5azJBTkhsR29mYmhYaHlZejROSWt1bDAvV0xkN3VKM3VkS1A3Y0du?=
 =?utf-8?B?aW1KT0lWcVBtbFJCUEI0Rk5LMU1MV295MmIyWnZ3c1FCS3hyYktuMngvdUNm?=
 =?utf-8?B?Z1BQRmNvd2dwdTYyQ01qaHkwYmFFd2hkRys3dTVWcE4zbHJ4QXJUaE5EeDE3?=
 =?utf-8?B?RXFOKzF0a1pCOGViMlZVRC8wNXhRS01qVTkzS3ZxclJYbStxRytBeks0YmpZ?=
 =?utf-8?B?V3FjMUZTQUpQNW5VZmRsUWNSTWxmNklobys1ZnhhZHdiMWwxeEdwb0VmOStk?=
 =?utf-8?B?amZrQjRrc0dhZ0xrNGFyZ0VyTktWOVJQblRyQkZmdlVqdHNBQlVnaWtlb1BN?=
 =?utf-8?B?cCtZVmh1cCtjNE1XZDZZYktzbEZQVURrc0x2TEQzZ0xsT3pPTWV6bVZRWVp1?=
 =?utf-8?B?UHBOSFAyaVlSNzEvbFpyc1VYeXQ4QTZrMmFRNnh3UGhhTEtrOHJPclZ3bDVI?=
 =?utf-8?B?dm96SUhlYk41amNUTElCMGwwMXQ5NlFTWWt3cVVDN1VyaDRXa1plOEpreTBm?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABB0DB5CB731504284C8A05299BC0DB6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e377f4d-0ee7-49e9-2614-08db6cb3a56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:45:03.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICA/Ajxz+kRlsA+JWJ5XUf7Cve8Ds7UoDefalyF9oc36F6S4cKcs6YhLWam8q2AgQLRaupFdWVROuxENdjKAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEwOjIyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE0LzA2LzIwMjMgMDk6NDAsIE1hc28gSHVhbmcgKOm7
g+WKoOeruSkgd3JvdGU6DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1
YW5nQG1lZGlhdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9zb3VuZC9tZWRpYXRlayxt
dDc5eHgtd204OTYwLnlhbWwgICAgICAgICB8IDUzDQo+ID4+ICsrKysrKysrKysrKysrKysrKysN
Cj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
bWVkaWF0ZWssbXQ3OXh4LQ0KPiB3bTg5NjAueWFtbA0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQN
Cj4gPj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWss
bXQ3OXh4LQ0KPiB3bTg5NjAueWFtbCANCj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OXh4LQ0KPiB3bTg5NjAueWFtbA0KPiA+Pj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjZiMzhiYjYyOWRh
DQo+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OXh4LQ0KPiA+PiB3bTg5NjAueWFtbA0KPiA+
Pj4gQEAgLTAsMCArMSw1MyBAQA0KPiA+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+Pj4gKyVZQU1MIDEuMg0KPiA+Pj4gKy0t
LQ0KPiA+Pj4gKyRpZDogDQo+ID4+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5k
L21lZGlhdGVrLG10Nzl4eC13bTg5NjAueWFtbCMNCj4gPj4+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPj4+ICsNCj4gPj4+ICt0aXRs
ZTogTWVkaWFUZWsgTVQ3OXh4IEFTT0Mgc291bmQgY2FyZCB3aXRoIFdNODk2MCBjb2RlYw0KPiA+
Pg0KPiA+PiBXaGF0IGlzIGEgTVQ3OXh4IEFTT0M/IElzIGl0IHNvbWUgc3BlY2lmaWMgU29DIG5h
bWU/IFdoYXQgZG9lcyAiQSINCj4gPj4gc3RhbmRzIGZvciBpbiBTb0M/IFhYIGFsc28gbG9va3Mg
b2RkLCBJIHRob3VnaHQgTWVkaWF0ZWsgdXNlcyBvbmx5DQo+ID4+IG51bWJlcnMuDQo+ID4+DQo+
ID4gDQo+ID4gSSdsbCB1c2UgbXQ3OTg2IGluc3RlYWQgb2YgbXQ3OXh4IGluIHYyIHBhdGNoLg0K
PiA+IEFuZCBBU29DIG1lYW5zIEFMU0EgU29DLg0KPiANCj4gQUxTQSBpcyBMaW51eCBzdHVmZiwg
c28gZG9lcyBub3QgYmVsb25nIHRvIGJpbmRpbmdzLiBJIGhhdmUgbm8gY2x1ZQ0KPiB3aGF0DQo+
IGlzICJBTFNBIFNvQyIgKGFzIFNvQyBtZWFucyBTeXN0ZW0gb24gQ2hpcCkuDQo+IA0KPiBQbGVh
c2UgZGVzY3JpYmUgcmVhbCBoYXJkd2FyZSBub3QgTGludXggb3IgeW91ciBjb25maWd1cmF0aW9u
IG9yIHNvbWUNCj4gU1cuDQo+IA0KDQpHb3QgaXQsIEknbGwgcmVtb3ZlIGl0IGluIHYyIHBhdGNo
Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KQmVzdCByZWdhcmRz
LA0KTWFzbw0KDQo=
