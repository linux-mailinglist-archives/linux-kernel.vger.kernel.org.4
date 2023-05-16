Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839017043FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEPDfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEPDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:35:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD51732
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:35:03 -0700 (PDT)
X-UUID: a2669912f39a11ed9cb5633481061a41-20230516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6DBHRuECSTKb7suKQHNrfd7CUwiIzpEMJa9lXe8llMA=;
        b=B/PpTzHrFfd+xpB5S5ueZD9mLgEWzZ49+tc43Dut2Lp7LDafGqTX+D6RLRvzaoLE5CyyBHKGrkPlHg/KKD66XQQtbnrlSg8/5ktoRn+31ibMeQNb65GLvxcWM/Bdwsb4/7WwfTI9j7EgTXK8D64UbS8m8pfwab/YQ8VdU0vpgsc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:e0fa9f9c-78d9-4530-b6ed-cc1eb7e203e5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.24,REQID:e0fa9f9c-78d9-4530-b6ed-cc1eb7e203e5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:178d4d4,CLOUDID:4727f6c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230515192555TDTBY5E5,BulkQuantity:20,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: a2669912f39a11ed9cb5633481061a41-20230516
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1577940058; Tue, 16 May 2023 11:34:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 May 2023 11:34:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 11:34:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnOg1eqQx2gOHb2YFrQMziXIEqLeAF3uImn6PfFUla0ef+vaxBA43jg2B/9JUZMynPpfSko6AwC73/MzmreaQFn16v6/caVdgi3cg2v+cqqm/WclYhSsciAhwJwdtQU46/CkAkyrDqkpI9b1X+JVUCZd0PnB55XmM9L9yTI775uWwIjtlYXpdpnddidS7nrGguVylOOEU8q2xTEYqepLQlENPJjcdO7jHvFElCZi2Z9W8uSmAJfTyYC7LLol60uoa2lhtMva/5lazO6uLpRxbDWWeKRrOiavgZN6J2pZlkVpXzf7ObZjVFmJp8dQOQirNDSlu0EtadSuK9tuQmA6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DBHRuECSTKb7suKQHNrfd7CUwiIzpEMJa9lXe8llMA=;
 b=F5g9UyW7TYUAVvXbz2yt+USRNJCwtVbNkVtAB6LQgTJk1206Uw4AlNR4hwV4fqMMskXkktKQ4coupFx0xjNx5ptrTCZ5AAMAlhUjkYfXFqgBfg3tAIlOT9pgt4ygY9GGwdBbmdqfyHD0z+nCTrW2Y5L7rcERuUepsyCCUIDVtXlP0LRUWFWdpCUdDXaLJSONKf3Tzk1R8nBnKlVRYGygylLnjQmFWfOCxtwVLwYNX7tX9DTShNPHBEtLwWkZI07mhg/QhrIM2CP3AoUr6SF9yQS8k/WrzvUHM5oe0wjdgVlPTb20OOeZukGsqRyEfiX+iL8TSdzV0KIXxN01b6UBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DBHRuECSTKb7suKQHNrfd7CUwiIzpEMJa9lXe8llMA=;
 b=AmMYkMZuGRTUd0rNeD2Lm0vs8xrP82+Uq3e1SMHt5tX18sA3Z5/MKqw5Pq0AdwrOCiw3lSL25XPkqL/YjBNhZY924G22DKH54J/kOmLuqqAJW/bwJiuyiz0aoqTGbaEU5lE+AwTKOhDIHme3t7dBFjdE1RbqNlERLdsNux38YiM=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEYPR03MB6506.apcprd03.prod.outlook.com (2603:1096:101:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 03:34:55 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:34:55 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/2] ASoC: SOF: mediatek: add mt8188 audio support
Thread-Topic: [PATCH 1/2] ASoC: SOF: mediatek: add mt8188 audio support
Thread-Index: AQHZhu3Sn+0oo178vEumn/jQJPYWz69bMh4AgAA9awCAAAZFAIAAyxgA
Date:   Tue, 16 May 2023 03:34:55 +0000
Message-ID: <3dd728e8ca50e54b475afec1b70569548f2bee94.camel@mediatek.com>
References: <20230515052540.9037-1-trevor.wu@mediatek.com>
         <20230515052540.9037-2-trevor.wu@mediatek.com>
         <7c784932-951a-65c0-c48f-bfa4c098b2e1@collabora.com>
         <ZGJKPuf1FX4AYLXl@finisterre.sirena.org.uk>
         <8f57c62f-c427-f5df-d517-d4025fe7c65d@linux.intel.com>
In-Reply-To: <8f57c62f-c427-f5df-d517-d4025fe7c65d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEYPR03MB6506:EE_
x-ms-office365-filtering-correlation-id: 1f4b70ca-7e94-47c6-1694-08db55be8456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j13EubIVxHFldfKEklCkko1FsgnR4EE3BMflzKUsjndVIswgg2tPZYgglvhaBYubsK+kp8kkLuENEyr2vDP2mFoPvKox7hsRetaw36X7SlYibyCQo4HmtHr/vJw+8tDkZua0B9ObMvmUD2vJ29OqbElmBPBAPhzqhW90zZh1yyHpGlVtnAI+M5kWSS7RLa2GHW9ZLlMSP8zrK1yqOrrWIEVcgQ6UL1DD6v4F2j242OlQU8o8/ori2jveiXyC0pUoK25i49lGJOkwugwacrZ11vw4y1Hmf+uSQhNRRq6e6r9sXwdiWIKxfplOmWS6Hao2o8jkl7cYIYWLNSwJk79vCvtWuqPlUTl5x5F4e/icuXt+njyAsXBng7YQjJYgO0ksamWk2/14TfHSmHqX/6p0CH+Z1A2E6wSAiepKKedhut7ZEtqhtPGEmJNex+VPW/GCiTREXFLG2LpHf46+aH7nLxvnzAzbTSR4eFyU15RUHBXm4fBVOzk2kwoZk/mz3hFYEufjNS4Gw3BcNVZ7rGboNF3fkXA1fh2F7RwK/DlcBqHASJaGj7EpLdW5IieSwRYUQZRJoSi6c3TsKLaonjkuizSxuEGiBVzln6DmYjWXXsNDda7wzm1T5ixWRn/P+N+trCQdgxcNGy3prQ40QQAVSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(83380400001)(66476007)(64756008)(66446008)(91956017)(76116006)(2616005)(66946007)(6486002)(478600001)(6506007)(6512007)(26005)(66556008)(54906003)(110136005)(7416002)(186003)(71200400001)(5660300002)(86362001)(8936002)(8676002)(85182001)(316002)(2906002)(122000001)(38070700005)(41300700001)(53546011)(36756003)(4326008)(38100700002)(66899021)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWxzWm9SRWliTjJIMCttaXpnd3NGM1duY3BhRGNEcDU1Yi9tWG8rOVR6SFpR?=
 =?utf-8?B?Sll6NDN1bkxZU3lkc004WHhhMVVFMHVVNmdZdXNoeGpJd0R4S0YwRnl3dnND?=
 =?utf-8?B?aVI2UlR3Z3pIWmdJSlF2TEt4N0ZYcldpdDU2b2hJdkhSTGlmTXNJMytkRGRD?=
 =?utf-8?B?QW8zQXc5RzRXVjI0STVORlc0eEk3OUlQdDhMeFlEVEE0akRlaXFVWXJHUDlr?=
 =?utf-8?B?bEtpcExrclhZM0szM1liOFVsdTUrYWFHRnZqWW9OKzV2VDNzRXhtNlh6Yzd0?=
 =?utf-8?B?SWl0QmFWNVVDNC9xQml6VE5XazhpaFVocWorUndaQ3NpSkFhSkNnallSODVq?=
 =?utf-8?B?TGxOdGwybnlPd3IzNlBaaTdVODVJL2o2clJHcUNkbVIxeUQvRXBZcC9Bc1lC?=
 =?utf-8?B?dFJlVXFOUmNrNWNXQ3Z3VG5MUVFBdDNyYkx1b2ZxYmIvRXNQUjVGbzVvMm55?=
 =?utf-8?B?VHByK3lZZW85OWVyV1ZDQjdQeVdHSlYyNkZDV2FUTDd3dFUrS0VZbVlYd0E4?=
 =?utf-8?B?cE9lUTFybjduYzFRUnBITzdEU1ovclJxclowNTIrOFdFdGtlai9QYlV4L3ZP?=
 =?utf-8?B?WFRQQjhjOThBU0h3ZTJOMm9OQkNUY0FDM3QwSXFBaSsrTW0rb2phWkt5SkQr?=
 =?utf-8?B?VUVMemtJUFJvVlk0ajNONHZzRjNvZ1NIOThreVA0NjB5VnA0dkVzdnVRZ29t?=
 =?utf-8?B?ZEtyNDVHbnVKakN6TVRkZmtXT2tOVExUTzVjd20zWEtPMEprdXZJdlNiRE9r?=
 =?utf-8?B?Vmg1ZXhTbVltNXM4bWNLaEcwakphWkNUaGowRzBWZEx4KzBBeGVsbS81bitn?=
 =?utf-8?B?Z1RTQWc0NTFrVEw4Q2hYWUtxVklUd3Q3Uno0L0U4US9SZ0V4Ly9heDNnNGpE?=
 =?utf-8?B?TU9uKzRTekd6dTU3cHlTd0QxZnplN2p5elZXakJBcTBNU3BkKzF5cmtVNitx?=
 =?utf-8?B?Q08vWGZFRFNkNFZoQzFZQ3I0T2Y4R0luVEVjTzlsa0w1SEVxTTRBamhsaXJx?=
 =?utf-8?B?d1YvT2t4MytuNU5KcDdqNG5oNVlWYWpJdEwzVkJ2Yi9jYnFhY0sxMjFFYUNY?=
 =?utf-8?B?N0E2UUJaVTdKcnB6TjlsN0EyMU9qSzlCRFk3b2ZxVzF5byt0TjUxMG14amJY?=
 =?utf-8?B?Z1NORzgwNFgrYkl6Y3ZnQk9pbFNSRlNOQ284SEs3TlRJVGtnT1MyVUd2c0gz?=
 =?utf-8?B?VkRqbVFXUEJ3amhMNlpIWjV0d0Vlby80NjVmbWFkKzRDVDBVTjlLQ3JBOWZl?=
 =?utf-8?B?RnFDMjF2ME1ZSncwS1hqN2Z5K1ZEaFdHZjdJNHVqaGk1S1NibWw3S0Jqb3Ew?=
 =?utf-8?B?NEVtTjlBN3lIM3A1cjc4NWVLQlZHUEUvMFdJZUF1ZzNuWHlrL2ZVOFdqOU9i?=
 =?utf-8?B?RWd0MnFMcjFGcHM4NnUwWFQ3ZWxwVjk2b25oNmxEZkZEVmtGSlFOTUtTTHcy?=
 =?utf-8?B?ZldDcVNla3c0MUpTWVU5TFh6NThMSEp1M1ZZb1VaTnBtUzRMQmJtdzgvcTNX?=
 =?utf-8?B?RFFsWTZsSGZDR29oRnZKeGhpVEdkNmIzUDQwK1E4dWhLSEpTYWJMRWovcGhu?=
 =?utf-8?B?VzlJQmo3MENsR3RyTk5FS1E3azMvZGJzNDRwbzZvQlVOaGJjaHl4M1dIQTJF?=
 =?utf-8?B?dndnZ0JJNStvOGxHaFd0QnlYTlUweUlrTEVzZHh4YTNUNkRFMXMyOUxmZTA4?=
 =?utf-8?B?UFVKQUIyQUF4N29wTnFpZkRHb2ZZY21yd2Q3MVFnQlpQZlI3aHcrMFJqWENP?=
 =?utf-8?B?M0FvVlVUVDhHM3RETmtnN3EvRXViMXVlaG50R1lEdlUyQW1HMWxRdGRQY1VZ?=
 =?utf-8?B?UXloSEZOdm5HWkhOZ2lGd2xXcHN6Wll6OGdWdmtrMkd5UG8zdzJUQWJndm1Z?=
 =?utf-8?B?VjJoRVYxWkljbmwwczM4V1M1TitoL2ZLMXJFS2g0bkpnOWUzU0YxYVIwbVFk?=
 =?utf-8?B?QzNXNzFDUis0L3pOR0V0SEp1SCtHSlFpbmFacUtjMmZ2dWU3OVdlcWlOVDdx?=
 =?utf-8?B?ZXBRNTl3UEtDdXdPa01pWEIwS0w1UmFub25ZT05kME95L3V1d253Q1JvdWtp?=
 =?utf-8?B?Tlo2Sk4zZGMxeUZ5bEt6U1ZWSlZ3eS9tWGFlZGxxVTFrQ3YzbTQyeUVLS01y?=
 =?utf-8?B?bnpySjc3RzBzcmNySFZlWVE4SkNoMUE2LzMrSnRKUi9ZWTlmQmVtTGlkbkNC?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B459E644886916478D05F094A48426E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b70ca-7e94-47c6-1694-08db55be8456
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 03:34:55.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlpb/tMXaYwTcifYtTURCAjl5zhqVjKyAKjcWfhJ59DIK7vnoA8NvdAB2+lglVUNQ8AVWw9ciitNR7GcJ0cDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6506
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDEwOjI4IC0wNTAwLCBQaWVycmUtTG91aXMgQm9zc2FydCB3
cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiA1LzE1LzIzIDEwOjA1LCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDAxOjI1OjQ0UE0gKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsDQo+ID4gUmVnbm8gd3JvdGU6DQo+ID4gPiBJbCAxNS8wNS8yMyAwNzoyNSwg
VHJldm9yIFd1IGhhIHNjcml0dG86DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAvKiBjb21tb24g
ZGVmYXVsdHMgKi8NCj4gPiA+ID4gKyAgIG1lbWNweSgmc29mX210ODE4OF9vcHMsICZzb2ZfbXQ4
MTg2X29wcywgc2l6ZW9mKHN0cnVjdA0KPiA+ID4gPiBzbmRfc29mX2RzcF9vcHMpKTsNCj4gPiA+
IA0KPiA+ID4gTmV2ZXIgdXNlIHNpemVvZih0eXBlKSwgYWx3YXlzIHVzZSBkZXN0aW5hdGlvbiB2
YXIgc2l6ZSEgQW55d2F5LA0KPiA+ID4gdGhlcmUncyBtb3JlLg0KDQpPSywgSSB3aWxsIHVzZSBz
aXplb2Yoc29mX210ODE4OF9vcHMpIGluc3RlYWQuDQoNCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB0
aGluayB3ZSBuZWVkIHRvIHBlcmZvcm0gdGhpcyBtZW1jcHk6IHdlJ2xsIG5ldmVyIHNlZSBhbg0K
PiA+ID4gaW5zdGFuY2Ugb2YNCj4gPiA+IGJvdGggbXQ4MTg2IGFuZCBtdDgxODggZHJpdmVycyBv
biB0aGUgc2FtZSBtYWNoaW5lLCBzbyB5b3UgY2FuDQo+ID4gPiBzYWZlbHkganVzdCB1c2UNCj4g
PiA+IHNvZl9tdDgxODZfb3BzIGZvciBtdDgxODguLi4NCj4gPiA+ID4gKyAgIHNvZl9tdDgxODhf
b3BzLmRydiA9IG10ODE4OF9kYWk7DQo+ID4gPiANCj4gPiA+IC4uLndoaWNoIG9idmlvdXNseSBt
ZWFucyB0aGF0IHRoaXMgYmVjb21lcw0KPiA+ID4gICAgICBzb2ZfbXQ4MTg2X29wcy5kcnYgPSBt
dDgxODhfZGFpOw0KPiA+IA0KPiA+IFRoaXMgZG9lcyBoYXZlIHRoZSBpc3N1ZSB0aGF0IGl0IHRo
ZW4gbWVhbnMgdGhlIG9wcyBzdHJ1Y3QgaXNuJ3QNCj4gPiBjb25zdA0KPiA+IHdoaWNoIGlzbid0
IGlkZWFsLiAgSXQncyBhbHNvIG5vdCB0aGUgZW5kIG9mIHRoZSB3b3JsZCB0aG91Z2ggc28gSQ0K
PiA+IGRvbid0DQo+ID4gaGF2ZSBzdXBlciBzdHJvbmcgZmVlbGluZ3MuDQo+IA0KPiBXZSBkbyB0
aGUgc2FtZSBmb3IgSW50ZWwgZGV2aWNlcywgd2UgaGF2ZSBhIGNvbW1vbiBzdHJ1Y3R1cmUgd2hp
Y2ggaXMNCj4gY29waWVkIGFuZCBvbmx5IHRoZSBtZW1iZXJzIHRoYXQgZGlmZmVyIGluIHNwZWNp
ZmljIFNPQ3MgYXJlIHVwZGF0ZWQuDQo+IFlvdSdyZSByaWdodCB0aGF0IGl0J3Mgbm90IGNvbnN0
YW50LCBidXQgaXQgYXZvaWRzIGNvcHktcGFzdGUgb2YgYQ0KPiByYXRoZXIgbGFyZ2Ugc3RydWN0
dXJlIGp1c3QgdG8gY2hhbmdlIGEgY291cGxlIG9mIGxpbmVzLg0KDQpDdXJyZW50bHksIEkgcHJl
ZmVyIHRvIGZvbGxvdyB0aGUgc2FtZSBpbXBsZW1lbnRhdGlvbiBhcyBJbnRlbCBkZXZpY2VzLg0K
SXQncyBlYXNpZXIgdG8gc2VlIGEgZGlmZmVyZW50IG9wcyBleGlzdHMgZm9yIG10ODE4OCBpbg0K
c29mX29mX210ODE4OF9kZXNjIGFuZCBpdCByZWFsbHkgYXZvaWRzIGNvcHktcGFzdGUgb2YgYSBs
YXJnZQ0Kc3RydWN0dXJlLg0KDQoNCkFkZGl0aW9uYWxseSwgSSBmb3VuZCBhIHR5cG8gaW4gdGhl
IG5leHQgbGluZS4NCg0Kc29mX210ODE4Nl9vcHMubnVtX2RydiA9IEFSUkFZX1NJWkUobXQ4MTg4
X2RhaSk7DQoJXg0KVGhpcyBzaG91bGQgYmUgc29mX210ODE4OF9vcHMuIEkgd2lsbCBjb3JyZWN0
IGl0IGluIFYyLg0KDQpUaGFua3MsDQpUcmV2b3INCg0K
