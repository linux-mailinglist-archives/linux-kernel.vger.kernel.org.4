Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA976F590A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjECNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjECNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:25:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B5E6598
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:25:10 -0700 (PDT)
X-UUID: e97e112ae9b511edb20a276fd37b9834-20230503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U6ww2RWI3twHtVYxZ4U/5WtXdmx51r/Hi8DQ/9QgLAk=;
        b=gCe5hRnbwFDP0E47gIVMvkLIxiUP82cD3DNuXmRm+aPexmToaWw/zDZ5vonXiznKDJ0CQ3v6HytMYBr3J3Z9nQ5EJJ/yF/8jswjQ2LYpfGSK6oERzKkpD8bzqeyoQTfOOeK+EYLTERTHxUA9nc76Ke7X6yUP+gojRucuwTFsVsQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:af6bb43e-791e-4d9c-b60e-260eb76d7439,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.23,REQID:af6bb43e-791e-4d9c-b60e-260eb76d7439,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:697ab71,CLOUDID:b29fa030-6935-4eab-a959-f84f8da15543,B
        ulkID:230503212323VD7IQS1O,BulkQuantity:4,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: e97e112ae9b511edb20a276fd37b9834-20230503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1397457427; Wed, 03 May 2023 21:25:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 3 May 2023 21:25:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 3 May 2023 21:25:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KScNTVljRLgYYnrxhrD3l7RyKJRpo6Hb8+NlRN2j4yaX2AOKa9pD/LFczl2knDzoIBHyCrN8662x0zC4jebFD7anad51B6uatfqFVj9gF5W6pmcRTTEEqoOVKB+fEBYBIWxru+8EdrPhCNL6JPgM61757dKOrfe45/9moc1iOxJq+HxMf4G+LK7X7u/2XgIYk06z9xqqSSweCVm9qTvvNXn+Ox6p+u7/wezaXl35i5leqjRP0Lh9XIZHzsdaUErKjxgnh6IdoGni5I6kzX9m0oK86rduSh2aed6dYT4OylrRsZtXfwu8TSYjpJo+iSOE9ckSqJRWUbvDLC3Np6hFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6ww2RWI3twHtVYxZ4U/5WtXdmx51r/Hi8DQ/9QgLAk=;
 b=ei1nj3FwZYhvjImZLXxhWy0Kx/vtP7yoXkmTH7odCcNDIODPJ2k2mJZPu1aYconuex/fv7+uqfNIlsDVUaryx8Gx7iEPwoI1pCunKsDzcEGaHW5tQ2eyV+XsJ0uBQ7Xk2wV5YkyzI3VicQpPQvLFcumE9419WW1JWcDSmP6aFaKerW30wzZK8yT0H3msLyLAHJ+5m308+hvX/tqKgRcaKd1Mbyx+FD70UaNqmZihrtGMAgTqk69csTXPhl/q++PpVkG7oHjA6mZ43B1ikp4yWxIslynbee+XIy9haUCX2lk6MTrZpso63Qsn4csBBT24l0bfZ5X9yGVSdi2jw680BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6ww2RWI3twHtVYxZ4U/5WtXdmx51r/Hi8DQ/9QgLAk=;
 b=Koh/A6FEZDkE8nn+xmgKvZFmPG+GO82GCwLDjych0MmDCiMQ6UjAR4K0zzV/cXtrTsYsVJPzk+Dd3faTW0OuudTEQFeFyLKLdztiYna7MT4goFzcWS0/LmZGKwC16paode0MibkdrAb29hfaHx9YsIKxlm4N4j/0oTC/9lDs1hw=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB6143.apcprd03.prod.outlook.com (2603:1096:820:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Wed, 3 May
 2023 13:25:00 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:24:59 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8195-afe-pcm: Simplify with
 dev_err_probe()
Thread-Topic: [PATCH 4/5] ASoC: mediatek: mt8195-afe-pcm: Simplify with
 dev_err_probe()
Thread-Index: AQHZfbNlCp1AlguueEONDsYVXLgYaa9IiekA
Date:   Wed, 3 May 2023 13:24:59 +0000
Message-ID: <03ab5c75083baed351bdb64c6501bfd3db33289f.camel@mediatek.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
         <20230503113413.149235-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230503113413.149235-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB6143:EE_
x-ms-office365-filtering-correlation-id: 36e33a5e-5370-4ba8-9969-08db4bd9cb81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPVnk/nOIwR4MJvzu0ijpJHrB6ZCekUQGcKQsUcOPcWYJ3I36wt6OpgIsFGYdWBthguiD4kbX3qdT2047o7dpnvGh4LOcvc42iUVtXms68nyWTANLRRFrD3pJJ2dMtz5gnxFdEKTdbL4eedYMNfPhTGiHftiGyOm4wCBl130l6YbNQ9W2rV7TCKkOhnSBeqz3i/Cx9patHyd2NImctMxsgtdwWnZ3KlnW5UQaIsAjUBqgQXv21Jra4Jb8HkSI/qVxyi0Bouhr8p7kQ6OggGAawFE4KkUMhhpX8SDEP3/SDSfAXBX1P6CC7lptW1RWIA9yajKhPA3RhPV+O5euxjWOCrI4pycqzIha/+OZRCxHD0rHzlu01eaS3T/cpzfgJ7VvzDLoRVgFBjR2zKog2elXBWo6FViw1FA9mQzgA8ZzOvf6oW+HDviE48rG7zITJJg0O30ov1SYQ93Blj/f3VAWhJz6EY7bFrU/gRPgFGu/YW91OsDPdzBL/rjMnbrfqO6USS1VYwn2nDzznMnpZ0XYmuMZZpdpK/P619qTkq4FbzFhzks4VcGtpJqpkdXePrAq999ILlHBhvoUt1WyQDtJblAl5GSbW1BKFdcUYmGZv+dQAlpXglqG82/428ckQRUi3aM35QGaU1qcecLNQ5FPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(66556008)(66946007)(66446008)(2906002)(66476007)(76116006)(2616005)(86362001)(7416002)(64756008)(5660300002)(36756003)(8676002)(8936002)(91956017)(41300700001)(316002)(4326008)(54906003)(110136005)(478600001)(85182001)(71200400001)(6486002)(26005)(186003)(6506007)(6512007)(83380400001)(122000001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hySEVlSVhuZDV0TUt3aGxSMi80UGdUbkRRQlFmd2RHT0pTNE95eGRldVZa?=
 =?utf-8?B?aWV6eHFjYnVuVXVnZTUxVm1EN0NUOWsvTnV6VVpkYkVUSXN0UEgxcG5FbHJD?=
 =?utf-8?B?NEpGeEVXRmtkVjFMWVREemxpRDB1YVVxMFpBUjRwRVR3d1FtbjVGMk1BeUt6?=
 =?utf-8?B?MlZuWHN6RHlDUERZYVNrRWRtcXJWMUIvOXBLWEgyQ0NXNG1lajdnMHdBcHo2?=
 =?utf-8?B?cHFMRmhRSWhIM3N1cUhpMjdEM0JtOUpHRExQYmR6Z09TdGJRd0xqY2JDcUlY?=
 =?utf-8?B?Rm9yZWxzZWxxNFNUWlRnNlFBaWRZaEVmcG5Sai93bW9nZ2owd0g4SndNZ1dk?=
 =?utf-8?B?RzdBQjd5b2M0bDJzQlZOYlhXeTBoZVU4dzhwK3RhV2FqVXZPcDUzNTkxRllh?=
 =?utf-8?B?MkpUSDVKWWVrNkdIbkpyVnN4Z2VuSVFmKzlOcGpKeEtzdDg4WDBlc2lRVWds?=
 =?utf-8?B?SHNHdlBjSHZMTnRuSmdEMkhvQzdyUWE3dFFrZGlMTnNsRFd1anNVU1ZRWjdt?=
 =?utf-8?B?dTNzQmpyOWhRREdjRGYxMzlNSVZTTlZUR3YrMjRpYkFDS1E5ZDFMOTRLbVly?=
 =?utf-8?B?am5rUVBkQ0xsWVhVaUpMZmd4Lzc3MzJxOU5LeGFJamxNY1c0Wlc0MGJ6WWNM?=
 =?utf-8?B?alhGOWpXQTRIdTNRN1Q4Z3ZlN1g5RWgyR2Q0Z2lyeG12dklTWDV3UElhR2x4?=
 =?utf-8?B?MjJ2UldodFk5blpvRU9LQ3Z3M2RPWHN2VklPQ3c0Y2k3Qmd6RExHcnE0dTMx?=
 =?utf-8?B?Z3ZHdjlPb1pRZjNCSkhRRU53U3VUdTY0Vm1ZZmtUUUZkNElockl1RHNnbWx2?=
 =?utf-8?B?Mng0MnNWbUduZ3ZJNE5xaVhNWUV6dmJPWHdxQW9tb1dSQlNkYUI3ems1ZHJR?=
 =?utf-8?B?SGorMGdLUnNwNGdUelRGWmlDVjIzWlVXMnVtWGs1ejdXV291K3hjV0NHQVFD?=
 =?utf-8?B?SmtPV2hESk1xaFFPK0FJSVhEUDFMRXVKaTV2eHR0eExRY3QreEhHeC9KdC9O?=
 =?utf-8?B?QkEwU2RBZG1EczM4dk5HTFR5TDQxK1praUZxcGozOGdJYngwOXcrT2FGZEE4?=
 =?utf-8?B?S0h1bXVNSkVnZ1ZOdlZER3UwNWZZNmtUVXQxaHJKOEtvRm1YdmhoQUVTUEhI?=
 =?utf-8?B?ZWR0QW83akM2OVUybE05d3lsL2t5ZWs0Y2JXSnNiWHVXdTdEMFZEVXRBOGJm?=
 =?utf-8?B?R2ZMN1EwZ293VHVkSi9vL0FkSy9BNzBsZ0RFL2J1clJqTktJTnhENXdrdkVr?=
 =?utf-8?B?OFkreitxSTBqR3EyQVpWbmFwQUR3cFlDOWNzK09qM2NPOWx3QUlQN3BGTHJS?=
 =?utf-8?B?cDZ5ZEpsbGIxWWV5N3VyMCttNHMzckJFenM3WFg1dnJJNXlmU0hSVWtWeWto?=
 =?utf-8?B?eU5ua296Vm9VL3NiSFRqcHZtcFNlbmlubFBiU2NwVlBTU0xpRmJzVUhwTjF3?=
 =?utf-8?B?bUZ3WkFKakYxU2JXQVN0RjkvUzNLNjFXejU5bit1M0tUVE9sdEE5OW5ad2ZC?=
 =?utf-8?B?aUM1bjY1dVdtVTZLZjZZLytub25CQWJkZXJqTUhUM0dBNE9YQkFNUE5SREMx?=
 =?utf-8?B?U0d5KzNwQnF6Y2V6cUIrMzRDQWp6MktkTlRSdGRyY3RhbUVFTDRKRk8vVzAx?=
 =?utf-8?B?S0JUK0MxWDh2a29UL2NqMUlCN1Y0RCtQTmsrNG5LSkhyZ1ZNWmRDcGpsaFVr?=
 =?utf-8?B?WTU3c1JXWWZJYnRpbzJlTzF1a1dXUW1jNDdZdzR6SlErWHNDcCsrOUFITVhO?=
 =?utf-8?B?a002YmlrL2F2QTBGcjFMS2d5YTJ1cGdLSXg2RVBPU0UrWTBreXgwUlNrOUc3?=
 =?utf-8?B?UTN2U0trbENIMHNMYlEzejE1NVpYRG1lQUUyWmlReGg0aW9PZDRuL0tXaGlW?=
 =?utf-8?B?VWNCTzd3bVBTdmhmOVlUSlMxemc5bFFiYXlPT2N6Umc1VytiTWxULzI5L2h5?=
 =?utf-8?B?YzhJMWY5RVlDdzdUaXplSXJwVXAwc0JNdnkzYWU5UDdsOWFPemhqRXprdysw?=
 =?utf-8?B?a1pTOWlQajdLRU8zUE01eTRPZFArR0FpTUhJcjNnTkpGNWIvOGxscmdObWRO?=
 =?utf-8?B?ZnVOUHNhTCt6RGtrcEFSQStJVE9tU1RRRDhPMHoxeFUxak9ybHZzbU9zcEtX?=
 =?utf-8?B?UVdaS3pGOWUyNTVRTnlwTXpYMFZjc1dnejNjeUJIQUg0S3lRVU1id2pVR2tT?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1845CD4CAF7541448794F1D3388A69E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e33a5e-5370-4ba8-9969-08db4bd9cb81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 13:24:59.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7YMupBm5TL2HoJDdjzZ1IXDr0R7keLziOl6RzTQByBIhnrit8VZZRG+IRhpT9O+5ouu4/Esl6+C4aIXFfMXVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6143
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTAzIGF0IDEzOjM0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IFNob3J0ZW4gdGhlIHByb2JlIGZ1bmN0aW9uIGJ5IHN3aXRjaGlu
ZyB0byBkZXZfZXJyX3Byb2JlKCkgd2hlcmUNCj4gcG9zc2libGUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4NCg0KQWNrZWQtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1h
ZmUtcGNtLmMgfCA0NSArKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTUvbXQ4MTk1LWFmZS1wY20uYw0KPiBiL3NvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxOTUvbXQ4MTk1LWFmZS1wY20uYw0KPiBpbmRleCBhNTRjMTZlMGFhMDUu
LjEwNWRiMTFlZWNlYyAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL21lZGlhdGVrL210ODE5NS9t
dDgxOTUtYWZlLXBjbS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTUvbXQ4MTk1
LWFmZS1wY20uYw0KPiBAQCAtMzA2MiwxMCArMzA2Miw4IEBAIHN0YXRpYyBpbnQgbXQ4MTk1X2Fm
ZV9wY21fZGV2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAg
ICAgc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQ7DQo+IA0KPiAgICAgICAgIHJl
dCA9IG9mX3Jlc2VydmVkX21lbV9kZXZpY2VfaW5pdChkZXYpOw0KPiAtICAgICAgIGlmIChyZXQp
IHsNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGFzc2lnbiBtZW1v
cnkgcmVnaW9uOiAlZFxuIiwNCj4gcmV0KTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBhc3NpZ24NCj4gbWVtb3J5IHJl
Z2lvblxuIik7DQo+IA0KPiAgICAgICAgIHJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQo
ZGV2LCBETUFfQklUX01BU0soMzMpKTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiBAQCAtMzA4OSwy
NCArMzA4NywxNyBAQCBzdGF0aWMgaW50IG10ODE5NV9hZmVfcGNtX2Rldl9wcm9iZShzdHJ1Y3QN
Cj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICAvKiBpbml0aWFsIGF1ZGlv
IHJlbGF0ZWQgY2xvY2sgKi8NCj4gICAgICAgICByZXQgPSBtdDgxOTVfYWZlX2luaXRfY2xvY2so
YWZlKTsNCj4gLSAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgImluaXQgY2xvY2sgZXJyb3JcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gLSAgICAgICB9DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiaW5pdCBjbG9jayBlcnJvclxuIik7DQo+IA0KPiAg
ICAgICAgIC8qIHJlc2V0IGNvbnRyb2xsZXIgdG8gcmVzZXQgYXVkaW8gcmVncyBiZWZvcmUgcmVn
bWFwIGNhY2hlDQo+ICovDQo+ICAgICAgICAgcnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRf
ZXhjbHVzaXZlKGRldiwgImF1ZGlvc3lzIik7DQo+IC0gICAgICAgaWYgKElTX0VSUihyc3RjKSkg
ew0KPiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihyc3RjKTsNCj4gLSAgICAgICAgICAg
ICAgIGRldl9lcnIoZGV2LCAiY291bGQgbm90IGdldCBhdWRpb3N5cyByZXNldDolZFxuIiwNCj4g
cmV0KTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0gICAgICAgfQ0KPiArICAg
ICAgIGlmIChJU19FUlIocnN0YykpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIFBUUl9FUlIocnN0YyksICJjb3VsZCBub3QNCj4gZ2V0IGF1ZGlvc3lzIHJlc2V0
XG4iKTsNCj4gDQo+ICAgICAgICAgcmV0ID0gcmVzZXRfY29udHJvbF9yZXNldChyc3RjKTsNCj4g
LSAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxl
ZCB0byB0cmlnZ2VyIGF1ZGlvIHJlc2V0OiVkXG4iLA0KPiByZXQpOw0KPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gLSAgICAgICB9DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHRyaWdn
ZXINCj4gYXVkaW8gcmVzZXRcbiIpOw0KPiANCj4gICAgICAgICBzcGluX2xvY2tfaW5pdCgmYWZl
X3ByaXYtPmFmZV9jdHJsX2xvY2spOw0KPiANCj4gQEAgLTMxNDMsMzAgKzMxMzQsMjIgQEAgc3Rh
dGljIGludCBtdDgxOTVfYWZlX3BjbV9kZXZfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gDQo+ICAgICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGlycV9p
ZCwgbXQ4MTk1X2FmZV9pcnFfaGFuZGxlciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElSUUZfVFJJR0dFUl9OT05FLCAiYXN5cy1pc3IiLCAodm9pZA0KPiAqKWFmZSk7DQo+IC0g
ICAgICAgaWYgKHJldCkgew0KPiAtICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJjb3VsZCBu
b3QgcmVxdWVzdF9pcnEgZm9yIGFzeXMtaXNyXG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImNvdWxkIG5vdCByZXF1ZXN0X2lycQ0K
PiBmb3IgYXN5cy1pc3JcbiIpOw0KPiANCj4gICAgICAgICAvKiBpbml0IHN1Yl9kYWlzICovDQo+
ICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmFmZS0+c3ViX2RhaXMpOw0KPiANCj4gICAgICAgICBm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkYWlfcmVnaXN0ZXJfY2JzKTsgaSsrKSB7DQo+ICAg
ICAgICAgICAgICAgICByZXQgPSBkYWlfcmVnaXN0ZXJfY2JzW2ldKGFmZSk7DQo+IC0gICAgICAg
ICAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRl
diwgImRhaSByZWdpc3RlciBpICVkIGZhaWwsIHJldA0KPiAlZFxuIiwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaSwgcmV0KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gLSAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIGlmIChy
ZXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwg
cmV0LCAiZGFpIGNiJWkNCj4gcmVnaXN0ZXIgZmFpbFxuIiwgaSk7DQo+ICAgICAgICAgfQ0KPiAN
Cj4gICAgICAgICAvKiBpbml0IGRhaV9kcml2ZXIgYW5kIGNvbXBvbmVudF9kcml2ZXIgKi8NCj4g
ICAgICAgICByZXQgPSBtdGtfYWZlX2NvbWJpbmVfc3ViX2RhaShhZmUpOw0KPiAtICAgICAgIGlm
IChyZXQpIHsNCj4gLSAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIm10a19hZmVfY29tYmlu
ZV9zdWJfZGFpIGZhaWwsIHJldA0KPiAlZFxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
IHJldCk7DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAtICAgICAgIH0NCj4gKyAg
ICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+ICJtdGtfYWZlX2NvbWJpbmVfc3ViX2RhaSBmYWlsXG4iKTsNCj4gDQo+ICAgICAg
ICAgYWZlLT5tdGtfYWZlX2hhcmR3YXJlID0gJm10ODE5NV9hZmVfaGFyZHdhcmU7DQo+ICAgICAg
ICAgYWZlLT5tZW1pZl9mcyA9IG10ODE5NV9tZW1pZl9mczsNCj4gLS0NCj4gMi40MC4xDQo+IA0K
PiANCg==
