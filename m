Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9516624E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjAIL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbjAIL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:58:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889A1A04D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:58:44 -0800 (PST)
X-UUID: 8bb5b425a06f44ef92d6dfe2500b2237-20230109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q7QIQs/kJZnofrWxsZKGlFZJtgf/2PRQw3Vc149hpCY=;
        b=cqmRYBwVCh3w/iv4MVBu4ADMsnqRJD1aRUNSdAwAZoNoxj98Eg3zOlWp84ya1FaVuKfXLYgbf8hOkv9+eVEyifr30p06Fu3tA0REIHNeH0AS0aoYsf/GcH/Nw54lyLdayDvjQ2Uift/UssYGY1vGgXtRBuxUE7RQrd2LTttcXJU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:741e2219-d871-4dd8-95f1-cc2f29b2410c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.17,REQID:741e2219-d871-4dd8-95f1-cc2f29b2410c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:543e81c,CLOUDID:389bb78b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230108043105IYOUPZTN,BulkQuantity:20,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 8bb5b425a06f44ef92d6dfe2500b2237-20230109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1057481824; Mon, 09 Jan 2023 19:58:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 9 Jan 2023 19:58:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 9 Jan 2023 19:58:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPxe3kYbxcoj/uJ+psXcSlATRjNY7bQnAK4cVTidp/gvqH5olHVGfiGYyUXikUBJzSURqOS45OFCfpz/BqmllJebjyq0Jd6C6PbgTX9kW0IvCoimpwohlQun+fabyyOKPL+haAiRLTU3BEewdZlxegj7r0FZb+tJmr9nplwDd6Ypa7by2LAiKBy/FmR4gJIHAF713k1bIZLXR3VzQ0839gFkTD+H7QeAhS980LyC4kZUEFv6zzDUuVljTPLuWH+o2YxVsZSRN3+nKbLhLbMQrFJb2ofhWO4Q8WjIFhNGHjcV2LK3zlXKOVC9+gfnh3JEzZEK2QZCnWzRfPrWzA5O7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7QIQs/kJZnofrWxsZKGlFZJtgf/2PRQw3Vc149hpCY=;
 b=iX1RQGvP6GI01AA/DZDi6G0dlgdLWPZfKan1MYJdACj/aPqpJ69b5aNdjpk1d6f5WyZkA3LFpho7Tv8iJEo/y1hPjFpepLOwaJyjNHEbTugsO7gg4z9bjoJRnlwVx2OJYjzayxv2kJ4vMgK3A9aBwNldTf2+BjefCvo42qWQknJ9BLcyoGDRGdDRH1uIX9R7srMPMAwhUam2pntnmQMhZqnGbbU2yDPzxb9gsOgheMys+l7WekdzrmWB9Q3XZcZZVmyakjkHEuQB/d2h28SL31ST4e146pNLbPF5RrvJIq/yvOASWi2pa3lJjm7V59bPy6sgWXylTTBpo+QQOG9Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7QIQs/kJZnofrWxsZKGlFZJtgf/2PRQw3Vc149hpCY=;
 b=rqLnMconOsM0kfyilA1TT/tl21YZ47lo4mLJpLgzoc+v8Sd+mCcPvPD/xeCN3WCgEbUB7uE33Y0gAAskG76HMOj+zjJTQnbr4Zll8qfRojU5afyExleqBYPn+PUay4dMpFbCLJBDpyxJqT/YJE+apk54l1VbxGMGHAY9oQ60KXU=
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) by
 KL1PR03MB5587.apcprd03.prod.outlook.com (2603:1096:820:39::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 11:58:34 +0000
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b]) by SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 11:58:34 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     "sam@ravnborg.org" <sam@ravnborg.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to send
 initial code time
Thread-Topic: [PATCH 2/2] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to
 send initial code time
Thread-Index: AQHZIXvy5e1lbNR4AkKSRYdDZpV3aq6TavGAgAKVhYA=
Date:   Mon, 9 Jan 2023 11:58:34 +0000
Message-ID: <3aa9243afc5fa8484bfe2db0b566ada24257edbe.camel@mediatek.com>
References: <1672974321-18947-1-git-send-email-xinlei.lee@mediatek.com>
         <1672974321-18947-3-git-send-email-xinlei.lee@mediatek.com>
         <Y7nWhciY7cru78lQ@ravnborg.org>
In-Reply-To: <Y7nWhciY7cru78lQ@ravnborg.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5339:EE_|KL1PR03MB5587:EE_
x-ms-office365-filtering-correlation-id: 7f686853-d116-4a00-e374-08daf238d598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQ7ojSjmrWdRjAVPvLQrUf/N/wgYby69NzsXYCwhWRvxVPoXCP6SE/da4xyH46ba0749KDQpatvsfs1HL2mjUPfKfEFTyv0ym1YoYBDhFij1QbWCxWuV8uQJ7+Cot3tu6UAWWWfhPAuyOwN8iu12Nx1F3q7xk+CTclSEK9MwwU8znFQ6W7PGgSXK3LZuOwFdVccYSiDJZHOzD4Enyn6E6WkIlOlZSx4eTpQp3jWuUDNMtmSDeHQmhaCOR6N76w1mimMyNsBLC+6qaB98sq7wbET7idnGfiTABMW3DO91uARlH89iROQsOzwu0Y0g++r5DtoRz7fMiXZxjaUKFgfHm2FD46QG9FpywhMDbe2tFyDnFAPgCRF96GFPUSW2Wp5iSdx9fqaTY9L/urAmKJ7ApntCvnNP+nz3N3KrUBrcTlY6xJWfy3rrQIlg91qG6XFiMTkHLzmpeGxvScbY7/y6ZjnAnm+4/6NdQlKp277zErQ4Pcx7qIlUOpu4acA+Sc8DTT5Q/JEcRjMgjQq20TQXxZQNkUBSh3UPbAXsM0yIIT/j2Z7CAKW3DuwavqpyILcLgZtwxkKKjDGL6INBNjYqHASRG/0uRlC3ibc3KmKDAT8Es+fAyvqznCyOmv5mqY2NUExME6bTL/zuk/HDzW0LEsx6bFCrWoxzWN6g5mo5ilpL0QIpIRbfyKtCi1MrF5SP4T+XHtwJ/zXK1K57AhxBarBhd4HW88sgBJyQyrEzYACe1LSczk9Ao9SX1VbQ2Gd7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(36756003)(186003)(85182001)(8936002)(122000001)(26005)(6506007)(6512007)(2616005)(54906003)(5660300002)(66946007)(7416002)(66446008)(66476007)(64756008)(66556008)(6916009)(4326008)(91956017)(316002)(38070700005)(86362001)(71200400001)(6486002)(38100700002)(76116006)(478600001)(41300700001)(8676002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEE0RC9QUnczU0NvNEJURUFLV2V6TWtmbDJadHd6M1hYVVN3RUthY0FMandW?=
 =?utf-8?B?Vmszc2F0TXJpaWtpS01WL1JGQkE2am9iME1pU0xxaGlhRGFIZ2hXMnpTamti?=
 =?utf-8?B?dlM3akdsa3Z6VjVmelpLSUt1UjIrNXdQMmU5WkxwdWpQZ1JObEx4TnF4UzF6?=
 =?utf-8?B?SHlLdEdzKzlybzZ1a2ViL1hYM2dOb0xGT2V4SzdqV1VKYzdIR0RLVTcyV2Jq?=
 =?utf-8?B?YjVOUkw4QjFxWlloQ0pGZFVnaFlPYjRGUFkxeStjKzhPeEFETE1ENVdBWlB0?=
 =?utf-8?B?ZmZLSTk2aGVwLzRBdGtMSG1PeFdPZ0o4bWZodW9hZlFUeUxzTHZaZ0p6ZUZ4?=
 =?utf-8?B?L08wQnlGdmQwWE1NekdkK0FaTjZvWTdaR2NkWTVkVEFhcHd1WnRmckNydXR4?=
 =?utf-8?B?azlqUzF3NXNSeDRkQ3ZubWRTSTV4TnIrNk9uOWZMMmZEZTB1WjRYcUZRVGVU?=
 =?utf-8?B?bEZ0ak05NUdwMmpHb3l5ZzFwc3RjOHBScCsya0tHMy9QbC9TeXI0UWZIZER6?=
 =?utf-8?B?bjhDdUEvbDhIUWU2WEZwcHM3SmVQSCs1bk9EeXc1cUE4RWVRbmUvWXI5YmtQ?=
 =?utf-8?B?RXFPSFVvOHJnQnBuTGk0NGIxQWZRVy83K2xaSW9CV0VWR3VrMUhPcVRCaUFi?=
 =?utf-8?B?dEpFazlMUW9kVkNYUGRiajJEdWxLWXY0eE9PVlRzS2hvOUtDQXZlTG55blhJ?=
 =?utf-8?B?LzI5SklPSVA2UC9WZmhHWHZ3K096VUFSZkJrQy9FK3d5L3lhaXZoL0tXSytm?=
 =?utf-8?B?MUlXb2dlbTVYdTU2Nk0xNDlhZGgrUkxZa2o1b21lUWN6aVFmM0JzLzBCNHpj?=
 =?utf-8?B?UzcyeXl3U1QrYm9xRjNSMVN1bzVMdFN4VW9LbjltM3ZKdVNkWHFVMU1DdmpO?=
 =?utf-8?B?YWZWajdaaTJVcUNDcytYNzlDb2dhUEEzbEFDc1ZPRVRiRmxnSkJuWDhncTVj?=
 =?utf-8?B?bXpQV1ZiY3pVdGpsSXdUQ3JSMFRNTmNXdjJxZjNoc2EvdjRqa2xvWjhTVnNI?=
 =?utf-8?B?ZHZvZ1c1ZUw0dWxpSVAxbjZDcC92ZlZsU1NMdXFzK3p5M3ZuQ1oyQVkwWXh2?=
 =?utf-8?B?dXJnaDVCNFZSMS83SUxMeUx1eHVrUVIwSjVTYlFvTGQ2TWhyYS9KL3kxYUUx?=
 =?utf-8?B?SzNRbi8yWUt5UlJ0TkNPVmMxMURCOVhvVkdFZWY2VlFJTFo5cTloUXRhUThC?=
 =?utf-8?B?K3NINHVDSEZKZWg0aVlZSWFrblliczQyT1NERXJtekFWc0htV01CTXhrNFQ0?=
 =?utf-8?B?eGtwMzdoRC9wOW5aTXIvWTM0ME1FZlJKTXdraWNGV2phQTVmT1RYK0hxTEtP?=
 =?utf-8?B?Y1k5cnlkZEFFekpuMU1WL2dUbHluT2llTWxWTFVuNWI1U3pmWENOTGlkazZl?=
 =?utf-8?B?RjhmbENzcCtoaHRUZmdpNnR4dmJIZVZZUTh5U1g3dXp1QWF5QlU1b1BwblJC?=
 =?utf-8?B?b3ZlY21Mdmg2THpVR1VOOEhtMTFWdmF1dk1lRW1BQXdsTXpJYW9taWdtbytE?=
 =?utf-8?B?bm5uUzREMGhhdmtaQzFVRmtnTEpnSGE5dlI5V1J3ZGF1Y2hzWnNUUnZuU25S?=
 =?utf-8?B?aXZUYmIxV0FFK042b2NKY2NVcGdlaklmTURsdVB2UW5MbG9oQzhLUm85Z3hi?=
 =?utf-8?B?WW1sNVB3TitqSlB0clhpa3JYcTZkeUsvc2ZuMVp3ZFlkUFByTjE0b1JBQ3l4?=
 =?utf-8?B?UmN2OGpwKzVDblJIZnE1Z1BPa2wxUE9rR1NoU2kzZ3o5eDZuaHNmMzdJNHJ1?=
 =?utf-8?B?Q3IwVjQ2L0RqUlduaHdKWU5rTFdUNmtOWTBSOHlZSW9kN0pERHFCR3hCck1q?=
 =?utf-8?B?NzdKT3hjaTUybHI1VUZ6dXBuUVNYcmgxVnJtSkZTYlpPTWZDbW93a0xpbm1M?=
 =?utf-8?B?NXVDQytKdzd5K0Q5QW83dGo5WnNyeGVyV2N6blNvdjlnN2JjMC9DTUh3Lzll?=
 =?utf-8?B?TlBzUm10MXZ6RU9NblEveGxkTWQvU3lyVnJHSUxQbzZkcUFKRjFua013dlgz?=
 =?utf-8?B?UExYN09LZXdIWVI3YTBWNW9UN0M4RjJGTkZDbHpoRnFCc2VkNER4Uk51KzVD?=
 =?utf-8?B?K0lzYTZuQVJpRTdidmp5ZFRlTXlzVGJrR0xVUEEvUU9tYTV6RVBQVVJyOHFp?=
 =?utf-8?B?bjlRZXlCdGJDcENVWmNQbVA2NGFRbkYrMzI5azNyYkMvOXF2aWRhYk9wNWNj?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F36AD9F3652754CAF5B51588CAF1802@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f686853-d116-4a00-e374-08daf238d598
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 11:58:34.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvF7Wv6GM7JOpGqk2DgL4S9q5CeXqybTaADyFfpD/mtiOnxcBjq9wMfkn9QS+FPdjwegnlcHo+Vb0ozOs6I0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTAxLTA3IGF0IDIxOjMxICswMTAwLCBTYW0gUmF2bmJvcmcgd3JvdGU6DQo+
IE9uIEZyaSwgSmFuIDA2LCAyMDIzIGF0IDExOjA1OjIxQU0gKzA4MDAsIHhpbmxlaS5sZWVAbWVk
aWF0ZWsuY29tDQo+IHdyb3RlOg0KPiA+IEZyb206IFhpbmxlaSBMZWUgPHhpbmxlaS5sZWVAbWVk
aWF0ZWsuY29tPg0KPiA+IA0KPiA+IFNpbmNlIHRoZSBwYW5lbCBzcGVjIHN0aXB1bGF0ZXMgdGhh
dCB0aGUgdGltZSBmcm9tIGxjbV9yZXNldCB0byBEU0kNCj4gPiB0bw0KPiA+IHNlbmQgdGhlIGlu
aXRpYWwgY29kZSBzaG91bGQgYmUgZ3JlYXRlciB0aGFuIDZtcyBhbmQgbGVzcyB0aGFuDQo+ID4g
NDBtcywNCj4gPiBzbyByZWR1Y2UgdGhlIGRlbGF5IGJlZm9yZSBzZW5kaW5nIHRoZSBpbml0aWFs
IGNvZGUgYW5kIGF2b2lkIHBhbmVsDQo+ID4gZXhjZXB0aW9ucy4NCj4gDQo+IFRoZSBjaGFuZ2Vs
b2cgc2F5cyAicmVkdWNlIHRoZSBkZWxheSIsIGJ1dCB0aGUgcGF0Y2ggcmVtb3ZlcyB0aGUNCj4g
ZGVsYXkuDQo+IEFyZSB0aGVyZSBvdGhlciBkZWxheXMgdGhhdCBtYWtlIHN1cmUgdGhlICJncmVh
dGVyIHRoYW4gNiBtcyIgaXMgT0s/DQo+IA0KPiAJU2FtDQo+IA0KPiA+IA0KPiA+IEZpeGVzOiBh
ODY5YjlkYjdhZGYgKCJkcm0vcGFuZWw6IHN1cHBvcnQgZm9yIGJvZSB0djEwMXd1bS1ubDYgd3V4
Z2ENCj4gPiBkc2kgdmlkZW8gbW9kZSBwYW5lbCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWGlubGVp
IExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMgfCAxIC0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJt
L3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYw0KPiA+IGluZGV4IDg1N2EyZjA0MjBkNy4u
ZjAwOTMwMzVmMWZmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5l
bC1ib2UtdHYxMDF3dW0tbmw2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFu
ZWwtYm9lLXR2MTAxd3VtLW5sNi5jDQo+ID4gQEAgLTc4MCw3ICs3ODAsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHBhbmVsX2luaXRfY21kDQo+ID4gaW54X2hqMTEwaXpfaW5pdF9jbWRbXSA9IHsN
Cj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGFuZWxfaW5pdF9jbWQg
Ym9lX2luaXRfY21kW10gPSB7DQo+ID4gLQlfSU5JVF9ERUxBWV9DTUQoMjQpLA0KPiA+ICAJX0lO
SVRfRENTX0NNRCgweEIwLCAweDA1KSwNCj4gPiAgCV9JTklUX0RDU19DTUQoMHhCMSwgMHhFNSks
DQo+ID4gIAlfSU5JVF9EQ1NfQ01EKDB4QjMsIDB4NTIpLA0KPiA+IC0tIA0KPiA+IDIuMTguMA0K
DQpIaSBTYW06DQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KUGxlYXNlIGFsbG93IG1lIHRv
IGV4cGxhaW4sIGluIHRoZSBib2VfcGFuZWxfcHJlcGFyZSBmdW5jdGlvbiBpbiB0aGlzIA0KZmls
ZSwgdGhlcmUgd2lsbCBiZSBhIDZtcyBkZWxheSBhZnRlciB0aGUgcmVzZXQgcGluIGlzIHB1bGxl
ZCBoaWdoIA0KKGdwaW9kX3NldF92YWx1ZShib2UtPmVuYWJsZV9ncGlvLCAxKSksIGFuZCB0aGUg
aW5pdGlhbCBjb2RlIHdpbGwgYmUgDQpzZW50IGluIHRoZSBib2VfcGFuZWxfaW5pdF9kY3NfY21k
IGZ1bmN0aW9uIGxhdGVyLCBUaGlzIHBlcmlvZCBvZiB0aW1lIA0KZW5zdXJlcyB0aGF0IHRoZSBk
ZWxheSBpcyB3aXRoaW4gdGhlIHNwZWNpZmllZCByYW5nZS4NCg0KSW4gYWRkaXRpb24sIEkgd2ls
bCBhZGQgYSBzcGVjaWFsIHBhbmVsIGNvbnRyb2wgaW4gdGhlIFYyIHZlcnNpb24sIGlmIA0KeW91
IGhhdmUgYW55IHF1ZXN0aW9ucywgd2Ugd2lsbCBkaXNjdXNzIGl0IGxhdGVyLg0KDQpCZXN0IFJl
Z2FyZHMhDQp4aW5sZWkNCg==
