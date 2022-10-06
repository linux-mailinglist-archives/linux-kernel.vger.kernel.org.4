Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5585F5EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJFC03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJFC00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:26:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FD6291E;
        Wed,  5 Oct 2022 19:26:18 -0700 (PDT)
X-UUID: 7cba209a826d4c66b3a3c93a98e8200d-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7FuQ52XbPPtn7C2f7EyKMIzoh/CQARDN0UyRK0mC80U=;
        b=bR0sMxK8p/LvTFmy9YKlpMkjmux+uaEragnMw2NYt3yTAF67th/S9SMMRDqrXD2L7nNOM3YYp8CanfbGnVkGlSfXPhUTWyJVb7vLKrwQ8iOBQwgPPwwYKkBMf1hHQOHmzOjB0jE0nCsNQjgTB4gAtW6+SBc9iTZ6ipcEp5r/Utg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:aa584c07-a98c-4942-8a9a-1748948c722e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.11,REQID:aa584c07-a98c-4942-8a9a-1748948c722e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:39a5ff1,CLOUDID:5f56a785-5312-4339-9a65-dc27c4b243b8,B
        ulkID:221005213855X47Q5YUY,BulkQuantity:212,Recheck:0,SF:38|17|19|102,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 7cba209a826d4c66b3a3c93a98e8200d-20221006
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1759806351; Thu, 06 Oct 2022 10:26:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 10:26:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 6 Oct 2022 10:26:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIZED7NO5jAxYjqPT3CJk/PrACK2dXVaiJWQ6EotqmRLvChQzzTraLogbH04pAvHjCPkL8fYegvRC+gQvuhtgq6ooP0mBqR+2MaNP7jwL983aOQR6d6YZbBAGOLhrAIS5WFhJMW3SFKc66CilWpAhwgd37xa306PpUHfdohfjPx3SNlZ0jHSIMr1dAHuhofdqTelBhVhx3EJZzh42HqhgCq3ouXosDkiPAH0CoN0nCN7xVp/rlWXCi/aRnB6zvsKkpMUQ7NM5iY57APWvhr2sN636QMgKEYpaBL0Si6abUtm5uebFQ2sL0MOfKifv3tyrYngrq5jGqYdxizRlNI5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FuQ52XbPPtn7C2f7EyKMIzoh/CQARDN0UyRK0mC80U=;
 b=MuyPOmxLn3XhNC43U7yYmXQO3GtLY2opEfi8+1nY3E02HM6WJCx08jkZ7Q+qAV7jmp37QZV/oCcaG0QzLh7Pc5YSn7zVNC9i6C5t5kxtQjYyawZI3AT4Ogc5W6rg9cQXAYdUIEJL1eULA7s63uu2Mefaq1x9RK3rQs98hG5e1TxGjMOlA72OZiJTY3v9I9xSn1vSIEidatS659T6uS8A/0pYhndbKHw6bbIbqqvMFJWTPXwrejjr+cXFDM4y/oSBi0aV9E9xAhyV6zYZGbrR+ErExsy9C5O2yHicVaOwxPB+UuaJSjR0Kh+KKDqUxjTjP1r9zM6abQpw+ofOrQ09xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FuQ52XbPPtn7C2f7EyKMIzoh/CQARDN0UyRK0mC80U=;
 b=qptGUqfBxdTSjb4tjR71LqA/lTXKi+QqtHTKuN+ZuOc94DVwh2oqxycPEBNid1QsNJwoNZW6w5kcfaEPyfqc+DghTrK68Ep4uJLjS+xflfD+Vq61WzX/Mf7seqBQ1zznNiNq+2x+eiZfxw56dS/owRkS+hUu/PXaPmEctlWG3mQ=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEZPR03MB6515.apcprd03.prod.outlook.com (2603:1096:101:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.7; Thu, 6 Oct
 2022 02:26:09 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Thu, 6 Oct 2022
 02:26:09 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Topic: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Index: AQHY2K6mQHCZgAmyD0GZh0AOdZkHhq3//yCAgAClfgA=
Date:   Thu, 6 Oct 2022 02:26:09 +0000
Message-ID: <985e97c85ad228f256e0f7b8a42545a3b7dae3d2.camel@mediatek.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
         <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
         <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
In-Reply-To: <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEZPR03MB6515:EE_
x-ms-office365-filtering-correlation-id: 1cfa6ce8-0723-4a2b-c3a9-08daa742212d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sD54FZ1gz3jAcCfqOw0qbhXwK2CNJGJJJkFKZR9+4i9nDZZX76gA/M6a4odR/CgpGdMEW6RXj9uwmbV2ek8p4YKQ+JEkyr6mDFCrw88Ly6uRhJ/g/pmAOOMkXrG1CjXU5e+uy7hxvKufHCT0YiXQUTQ1Ts40bYgfcIk1c89EmTe87Ap5H4b6EhHCau+hXvB8aV1XsFoK08FkUsTYmPCk1aksybjUgls891IyBaay+VLl55ShQkVaT6O/SKeuVcBBMbbOydMpDy7901t+SOjjYVBN1urhwrIMDMta2q/L4/YsSTcVxU63UG704n+zwGzJcindUi3v7e5EOA5/ieQrwi74FMkx8C17AAFh/fr4l+2lXZXZvC2k1dkYE7RB4WqFUghyf61+1FnwnAOiA5rsLyHcE4isjodlofIMS0u2g/hx/7+BHhao3j8G3NHk1QQAAxUE8N+yeF/yPzuRE04CdineJ6gMydMHm8Zi2Zf97G444BrUhNzJQWngFOWynbv3U5DQ9Aa1ffqlil77OLj3qezc9+DFusDdWPvT6WFp0ikugSWVyw6BblEdOzyk2/aZVPIkVjEPls/afi77gcIa3SW4mS4xANcnC8J3fr+fiXVXQTz2TACVuBO/PQ+Z3emVDhlaOYgRbbaAcfIWLX8iFFm+dgi43k6WDYrNlpF5GFa6sob0enLUPj7ZBKe6QXrdVOfoj6fvhIHNh7Pnk0/hdJm8ehwLO0Hn98xmWOpL71vDkeGp00Nlf7vZJV2r2anPkCxiy10bmZEIf//vgnta4eYudBMeFaSb5NsTOv9S646ADI2RN/RfWYagsfmclJn3QYBZ8tHnczHfp58SO2Qv37wnh/7Dl4oh1jnJF7xBBRldp0LkwfXE5pYhYPvoTg0U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(6512007)(6486002)(966005)(186003)(122000001)(2616005)(6506007)(38100700002)(53546011)(36756003)(107886003)(66446008)(41300700001)(8936002)(26005)(66946007)(2906002)(66556008)(76116006)(38070700005)(66476007)(85182001)(54906003)(64756008)(8676002)(478600001)(110136005)(4326008)(4744005)(316002)(86362001)(5660300002)(7416002)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFoY292c3M0OUxMSHZEVUxES3BtV3JQSWthNHR2K1VTR2dnM2xmLzd0QTdy?=
 =?utf-8?B?OXBPY3dIdm9WZk96bmFXczc5d3NwVnkrQ2IyRnNrMkZDTXUwRkcxV3FuOHBD?=
 =?utf-8?B?WmtNWWdzYjdIUXA2aW9EZ21yM2QyU0o2WU1PS1ZQMDBBZjVOOTBNS0k4c3pG?=
 =?utf-8?B?R3ZraGczSmhRdWw3UXBuQVAyMU42bmc4cmFCM0FsS0dua3RqRFoyOFc5L09z?=
 =?utf-8?B?KzhQbmg1azN3SGNMT1N5b2lhYk9Yb3dZanBaZTZNak9EMEYveFJtNzZVMG95?=
 =?utf-8?B?Sk81SjJMTzBsR3h4RnppSElGbTJYejU5Z0dzekVsd1g0S1RPTExGa3MzUWEw?=
 =?utf-8?B?Q2doOExQa0dLTXdqaTRPRzhaRzU1VTFBMGFCTHBUSzFGWWV0NmxCazR3a0Ev?=
 =?utf-8?B?bldwY3NlYlhoTG1HYXJIMHhlYkh4Rkw3bG9iVlFMdVByOFRQWmR4eXh6RVJs?=
 =?utf-8?B?cVlRQjZLVmxNRjZITDRlTFV6UmtSTU54RUhqenlGMWRHc0pBU3RJRnpUUitq?=
 =?utf-8?B?TmJ4dWxFb3p4R0FReEZjek4xZWw4bGgwZ3pJYmlDcW10bDgvMTBtY1lHcWFi?=
 =?utf-8?B?bTJJTWtDZCtRNDQ1dFlLTXl1RStQc1dHcEF5UXBLMmdhS2YrWUpGQStsSWxF?=
 =?utf-8?B?cUtDRHh1ZkJLM3FrR0k1d1Vlc2Z4VUlJMFRTMURONnk0VXZoWHpyV1hEWXVi?=
 =?utf-8?B?VHZ6NitNVzJjaWt5SjM2bS92d3EyOTJUOHUvVUhicHVHMFhhLy9UdUhjN3NN?=
 =?utf-8?B?MDBWa01DTFBQME5VTFRRZ1JaZ0JrRUxZSTNOUG1pSDlzdWIwcjJndHJIYWQw?=
 =?utf-8?B?b0k1KzR0bEh5N3lSYWhha0hRRVN1Rng3UHhHM3JGcGY4RVhSb3FLYmJ3N2Rj?=
 =?utf-8?B?N0thNUlYeExBenZZMHB4R2VZRzFmVVA3dktRZk00cEg3MkVEdCtnZFAza3FU?=
 =?utf-8?B?Tm0vUnUzbjMzNEhOUWM0eVJPZ1B1OENibzZ3a0hrQVF5RkNLL0VDUlMvY1o5?=
 =?utf-8?B?cFNPbUNSb2hRdVNSdmgrQjZ1bW56bDVVbTJ4S2x3b3EyVnU1UENPa2lXTFhF?=
 =?utf-8?B?eHNwWi8yTG55K0k1VDRsSW01cXFyMUQ2M0ZQbGpuOUdwVmhEZm1EaU1lUm82?=
 =?utf-8?B?amoyZHFkNUx1ZFdvWEd6M09NZjJRRlBSTTAvYXRpWmJvTDg2N3dzRDBxTGJD?=
 =?utf-8?B?QjR1Y2xaaUtYcmZqeDZjR0RGQWh3MTk5QjlSaDNvc3JRbWxrR0MxYlNjYW44?=
 =?utf-8?B?VllsZWx5cktwakdzNWtxRldJRUV1MHg4ZlNEMmVjQVhWQmw5ZTU2NHdXTzlG?=
 =?utf-8?B?ZkM2bVdYYkdHS2dVQWkwUGtkUEtITnFKTEtXOXhXSVFuYnZSNGFYdFFxNkxw?=
 =?utf-8?B?UkovYjFNWng5eS9VcVJFNzVkbzJkMlAyOVZOV0pKaVhjZC9YMmlLYmd2T0NJ?=
 =?utf-8?B?MUFTaXEzS203cnRpTGhDVVRrNEQwWmRYVjloQTJ6eWMrL1lVRUFkb3ZFZ3V4?=
 =?utf-8?B?bUZKbS9wSk55dUNOV05aWTRBMkl0UHhuSHpUa2J1Z2kvN1dPVFZBbEY5N1NL?=
 =?utf-8?B?Z1orMURPeDBSbjM5ajUyMVN2RmxMRjQzMW1yWEw1UGg1ejhoZnR6UnV3QWhJ?=
 =?utf-8?B?ZWlLOVBSbVBrODlCWjYyMWVOZm1KSFlSaHFkb081RUs5b1QxQ3hMelorMjBS?=
 =?utf-8?B?bW8xQno3NmdvWGR3NjBmT21md0c2eVFVd1hKSkJPN3ZWU1dqSE5TMU1tT000?=
 =?utf-8?B?d2Nhb21GbmNEekprOXlpMVlMNUU5dUQ4cUxycDYyM3Rxa3RkTlZjYVpZR3d4?=
 =?utf-8?B?Y0RmTG94VWk0RmJhVnRZMXUxV2p4aUptN1p0U3R1L09CcXR0WVIxOXhMK1A4?=
 =?utf-8?B?eW5lcUs1SE5YZm1HcW1kZmdNMkx6TWZJajB1bVFLTUEzTjdaQ0VlRmpyZzc5?=
 =?utf-8?B?eFFzZlREeUw5WHdFMk54eVhYN05nL0k2WG8xRC9KVXNwQzRuTE94SUVCOG9W?=
 =?utf-8?B?OXp6L3Nyci9VbmVpb1JDNWpIQVdkMHNJZUQ3dEhwOEtxNE1uMmhtTS9SbE0z?=
 =?utf-8?B?M3NzbndvUmo4d0tZcUhOcnhEZDJEUDJxSzFrajEvR2wrWldsbUhuTkF2enk3?=
 =?utf-8?B?QXNWRjlFeG5uQU1xMENzT1ZITUJ6dnlmVlF2Mk9qdVgzbGhoSHorWk1qcVVa?=
 =?utf-8?Q?S5RjcX3rVNxlmOxnMeC6s5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4496A90C2879F14DA13B523C04C050D2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfa6ce8-0723-4a2b-c3a9-08daa742212d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 02:26:09.2048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thBw6h9YWtllbyctJ21M+yt9kCfbDhnVgfJ6UpAe1qHNdoDFO36cjePkbtTSMafA4AzByj73aKkbUK/LHSMvEHDaoevvS2IyU/OhMSqikyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4NCg0KVGhlcmUgaXMgYWxz
byBhIHNlcmllcyBbMV0gZm9yIG1lZGlhdGVrIHdhdGNoZG9nLg0KDQpJIHdvdWxkIGhhdmUgdG8g
d2FpdCB1bnRpbCBbMl0gbWVyZ2VkIGJlZm9yZSBzZW5kaW5nIGEgc2VyaWVzIGZvcg0KIkNvbnZl
cnQgbXRrLXdkdCIgaW4gb3JkZXIgdG8gcHJldmVudCBhIGNvbmZsaWN0LCBidXQgWzJdIGhhcyBu
b3QgeWV0DQpiZWVuIG1lcmdlZC4NCg0KDQpbMV0gDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY2MTY2OQ0KDQpbMl0gDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA5MjAxMDU2MjIuMjU2NjYtMi1SdW55YW5n
LkNoZW5AbWVkaWF0ZWsuY29tLw0KDQoNCkJlc3QgcmVnYXJkcywNCkFsbGVuDQoNCk9uIFdlZCwg
MjAyMi0xMC0wNSBhdCAxODozMyArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4g
T24gMDUvMTAvMjAyMiAxMzozNSwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+
ID4gQ29udmVydCB0aGUgTWVkaWFUZWsgd2F0Y2hkb2cgYmluZGluZ3MgdG8gc2NoZW1hLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBh
bmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IA0KPiBUaGVyZSBpcyBh
bHJlYWR5IHdvcmsgaW4gcHJvZ3Jlc3M6DQo+IA0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIyMDQyMjEyMTAxNy4yMzkyMC0zLWFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbS8N
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
