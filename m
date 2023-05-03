Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65046F590B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjECN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjECN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:26:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F275BB8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:25:57 -0700 (PDT)
X-UUID: 069cc49ae9b611ed9cb5633481061a41-20230503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YcqPHIGPsGgivH18jpMN8d3drlnVLOYWCi0PUPApTpw=;
        b=dhAx8fbl2+wviY18P+Up4uApVdX/5jajgnRE3260cTJBWslCYNsvpH+yTf3L8WEjxJjCvgcq+U68IWeEFkiMP5/A9c55lUhP3lrDNeTBmnojbFnF7jkv8UJ4jyrfqIXdWq/AxKRrGPA6p/3ubYGl0Xruve7QEHqHZweO4O6gLLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:1e672c64-8edf-462c-9581-d5ae73cedcf0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:54a1adbf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 069cc49ae9b611ed9cb5633481061a41-20230503
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2015398032; Wed, 03 May 2023 21:25:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 May 2023 21:25:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 May 2023 21:25:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWMwS0qNc16gawMTmOioeISIGba0FtANBjbTnb6okfv8iaJaeG5RE6M8Z7ZeOwUn+WcOM7E0ubwLAll3PMEIhvrKmPP0u9qIJanJey8MHqCDoyNw1WWSAxywWFUgZ8ST5kZ+kNtZKvM4hdgYPzEfIVX6lMerolPiu7GSZMRbG9Nx5Sk6wjHoBvxb6r/PPOaJun57epVOESSVp3sVliOYUwEAbPVWqkA9H0vfzjsvk8XEvl4O9W73mEy4WYcbyo9Kg6mlKnI6ztvRD/xFcP1rQzB5Eb7wNYkB0RXkf/BTcG4tgUvUQO0ewgE0Md/XZMWvNwjF7w3TpXiISJQONiSa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcqPHIGPsGgivH18jpMN8d3drlnVLOYWCi0PUPApTpw=;
 b=FDJDY4GJ02aGq5KhxPTwvWmefTq/P5RfUhE2PxH+2DlJm2pHS1gXrPwpfIVDUrmWmwXpIxY1LdIfdJwLNaBu8cRJWbiYkaBfEBjD6QporOhr38LDqQyqsr1ueUEx4LV3t73nEKbU1HZcgBgfgyEegwD+MaSwVNZgWK4tuhmzOQI032qhk3hkD7FYdmr5QoW1mzy1l1hXed+6B72pun8TrDPl7AQhd2uqO8oQq6y+VUhjszpOjUo7xiIwjsUCQ0LryehxIl9p0eV2BFlhy6jGs+blaFu8RRv6T/q8HwSpKrfkWMx39yFo7m/H9eqEXuQ5liXFQDw12OJJYJyxRUs31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcqPHIGPsGgivH18jpMN8d3drlnVLOYWCi0PUPApTpw=;
 b=RENkkV2/MeASQXmb27yRXLTl+ruowRo3JCkMQNUMHPnHefrodpbpxwGZaJNJC7eytO4H1BsNFvgOsSvJ1zxCsbnIPkIbirzv08zuHu2Vdi4UsmvhTkG27k+7icSf4Zb8ZES2+kjW4wYv1XDpF/GOVqh+3Duqls+1yPE7iZL6rsE=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB6143.apcprd03.prod.outlook.com (2603:1096:820:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Wed, 3 May
 2023 13:25:46 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:25:46 +0000
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
Subject: Re: [PATCH 5/5] ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary
 functions
Thread-Topic: [PATCH 5/5] ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary
 functions
Thread-Index: AQHZfbOH5MWsUkCf5kqlRgx3FqWycK9IiiCA
Date:   Wed, 3 May 2023 13:25:46 +0000
Message-ID: <131123e4dde4d95927bb9ec92aefc50bbde53cd6.camel@mediatek.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
         <20230503113413.149235-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230503113413.149235-6-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB6143:EE_
x-ms-office365-filtering-correlation-id: 90bff204-5590-4c21-39ef-08db4bd9e767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RkaRlvyW+fLPZLGFFJendetZsxQRwQZ3FpNNkznDr5x61kEjsaAytZykfPwTzgaNTjO5mEvnf4Q/3Imx3MuC9MsLDB+05ghbe1yzEoIxWyNM4GyPYTNjowyZJ7DFM8M7FN9jnAvXb/dTf/l6KlFJzKGkG6k4FODwbuF9sxsFzF8ejAfzzaMiv3Pz85yojc1YuRu6WxEvPk5/BcpGbjy734y2xL3DZKFUjjHZ2HzYFcZjcIt1Bmr15WLmZJW2So6YPA8qgrtk0hL3koe1IChGBE9IUSRmFRjU3pH7m4U6RrTbh2l/YXbGSDplXPPckGsjRxK38fHG4Fu0iCdPMoAQz1ZM9oJuPitqAxwI75Ol//jG3k54vHECGs9M9ZSU8n4NpzGPekZxilPpQiMhxXyMO5Kb0Nb/5OOYYk+5APl5CBIymaGb7eSndQzxxfOquMA97ajO3c2NYPQPo4y5pegbFsWKyIGzOt+1X9rJu3RWvtRwy93XUEV+Q1bETVnk8EAVPxKbAnAE1l68fhp9T937fZRDf2EgMuPuUx2yUMP0WqLNFCiwrvvl7bwe5vYSDAsiXxSJaMbfRsPeto3WUaVQ8r5q+TL5CHSHr+cCBOuFlcBTwy8Xpt768x8ett2oJ2CBs/tQ8hzZM9ZUdxrThqxeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(66556008)(66946007)(66446008)(2906002)(66476007)(76116006)(2616005)(86362001)(7416002)(64756008)(5660300002)(36756003)(8676002)(8936002)(91956017)(41300700001)(316002)(4326008)(54906003)(110136005)(478600001)(85182001)(71200400001)(6486002)(26005)(186003)(6506007)(6512007)(83380400001)(122000001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzBuaG91QzFGQVA5M05lODhaQkFCTFB3MXR6dnhpSG53dEsrb1JGV09wY0hM?=
 =?utf-8?B?RHlLRmF0VHFDS0JYaFV5WlVsemxZTmYxc2UvUllCUW8zcE5vOG04bkMzODVV?=
 =?utf-8?B?NGVFRUVFTVV3Sk16VklGOGdTRzl5dVpGNGNuempONkNSbXAzZ0JoNWVyakhR?=
 =?utf-8?B?Uy8xcDlaaVJPTSt2VDZsUUxiRmhETzBhWnZvQ09RK3dwZ2h2dk9pOE12Tlc5?=
 =?utf-8?B?eVBWVmhnZWRaVWxYM2p1S3BXZDlUM3pYOE1rTnp4MHFla3UyUXNsQktkT0hj?=
 =?utf-8?B?YUVWZnI2ZVkxTjVGQUtob1p6bWRtY1ZPMkYzcnRPSzVnUFRCNWM2S044QlVx?=
 =?utf-8?B?eFA2cnNFL21WREhYUTRJZXVXYitQUTJ4d3MrdE5xNldLZGVMclppVTRnQzB0?=
 =?utf-8?B?ZEU1OEY0K1d0ZDNKeDg2cHlxZDZxVWEwdXJXY1ZzMlJxak13eDA3OE5mWW9H?=
 =?utf-8?B?Z3E2T3hTZ055NWhXUU4zMEFtV2hCRVdUOXlvLzVxRUFiMjBSOER6RTQyVFlC?=
 =?utf-8?B?ZWdkajk2cll5OG9Qd1U3b2NMYUVmZEs5NUMzQWVCOTRSN21aMy94SU9VZTJP?=
 =?utf-8?B?VEd2Zkl3QzlybkNma0lWN3BoWUdPdWJBQnNReFhVdEdCWkxOWFJrUHp2UGsv?=
 =?utf-8?B?aW12c1NzMXhwelZTTVVRa0JrU0lLWEFTeG0vUE5ZNGl5blY3SE5LN0RkYzdU?=
 =?utf-8?B?cm5rU0NESnNQN0NGSlFyK1dkVGdLSGhLMHdWcDF6L2J0eDBYclM5WlZ3RWlp?=
 =?utf-8?B?U3dQanhYWjdZajE0a0x6MXpNUXZUUGdQdzNPQnJCREpXQUt5cjVEQUx3SlZw?=
 =?utf-8?B?TVg3UC9BeDhJUUY1OTd3ckZBYUZtVDJ5aWZOMUk2RFZVd085ZEFVam51L1VM?=
 =?utf-8?B?SHVMeHMyL0xJTHdoSEdPSi93V0ZRRS9PMTIzbXZKTTgxSUhvVFRleEFZZzRE?=
 =?utf-8?B?azVyOWtMczN0dW1uVDlCYnk0QTJmOUNpQlFBTWptMGJidnNIaWtISVpvNGx5?=
 =?utf-8?B?UVBRMUt3UWt5cGhGMVhDSFNCMXhoTUVaRjhuY3ppam5qUnB5b0gxVjExaVNq?=
 =?utf-8?B?dGdmWkUyRlJiYVlOc1U4UW01Q3pkTnJnazNCOGFlY3RtYW8vbnpLUk1HUXIv?=
 =?utf-8?B?NUdWOTNBdXlMRG5TR1FnNjVrMWZZdFhwZUlkOVVja1dwRFFTdnpVWkJwYkVx?=
 =?utf-8?B?NjlUMG9MTnN3ZURZNm9ZOFhza2hCZzh1VVFNNlc2MDR5SGZ0K0dXeDZKSE5M?=
 =?utf-8?B?RXdHUjNoZ1BsZHFFaWZrakFqdTNRSGh0WXlHN3EyOXFQc0Z3dGJjYkt1eklI?=
 =?utf-8?B?WnZwNWZ6bmJDYnlkRXFPd1p2eGxMZnBmWlhWMWs2alRXUkRZK0dkNSsxQ1lj?=
 =?utf-8?B?Y25Fc3Y0UFhzU1czUjZkdHpOVU5tVXhHR09QNFdLditTb29UWFd3bldValMr?=
 =?utf-8?B?YnRKejdWQzNGTC9oVkFMM3ZDT053d0FPdkJLUyt4eEh5aUo4OFF4dTJZZE05?=
 =?utf-8?B?U0RmaHQxTHJ6OTlpQ1ZVcXpKSVE3a2d5ZWVCVWhpOUZSTmllOWljMjBRMU5I?=
 =?utf-8?B?UmZxT21WSi9nWk0zSkNPVEYvWG9oSndZWkxyRmlpY0hXTGZrTnZ2RGo2M3hP?=
 =?utf-8?B?N0E1TVlmTUhVSGdvYUVUZjBIWVMwVHdIaXJKYkVaOFV6ZFBVQnMzZ3hWeWph?=
 =?utf-8?B?eTlnaG5hVzhjelVseDRjQjJLNkMwUUNzOFFJM1pjVXhmMGlZc3VDZkhRbnNq?=
 =?utf-8?B?clpQZkh4T1VSeGZOd3NtbDZPMzVFVU1YYTF2YmtDVVI4NHhDeW5SczlOY1VO?=
 =?utf-8?B?UWhFWmJocGJ4MWV6aGw4R2cwQWtWY1BOaHc4VG5KajdZMEpBVUZMWnFWU2Yw?=
 =?utf-8?B?ZmtvMDMwRHViWkZWS24rL0UrTm83ZWxVTXpDcnc1V0JtU2FhRXo2R1ZWOWJR?=
 =?utf-8?B?aWpXdFFjTjMrVkZLQ3kzV3o1d1QxeDBBQ2RCVUFGR08wbXh4MklBdzVVU1FY?=
 =?utf-8?B?MS9NTG1YTGR5TFRreWxvc2dQVUE2R0NDZTJzZWx0bFRBTVhuRU8zUFdtZzNl?=
 =?utf-8?B?a1dEV0hhSk5iclJoeHFKRXFycmpkNFBjRFFiV0ZueTZmc1kzaWFUWjM3UVFm?=
 =?utf-8?B?QlJjKy8rZWxnbVVSOGE1VVlPd2gxTmpxZXdPSVdWeXp6UkpvSTY2NjBMTVph?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D51A811C311EFA4A8FCA3C765312ECEF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bff204-5590-4c21-39ef-08db4bd9e767
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 13:25:46.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxEV+gFezO2sYV56B4oKaBAFhbz/4XP6g/ZSagmw1d7TknD6jI/4ET6OS/qTM8cyBsMSHKuMf1bTUMZBtRlNnQ==
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
ZWdubyB3cm90ZToNCj4gRnVuY3Rpb24gbXQ4MTk1X2FmZV9pbml0X3JlZ2lzdGVycygpIHBlcmZv
cm1zIGp1c3QgYSBzaW5nbGUgY2FsbCB0bw0KPiByZWdtYXBfbXVsdGlfcmVnX3dyaXRlKCksIGl0
IHJldHVybnMgaW50IGFuZCBpdCdzIG5vdCBlcnJvciBjaGVja2VkOw0KPiBtb3ZlIHRoYXQgY2Fs
bCB0byB0aGUgcHJvYmUgZnVuY3Rpb24gYW5kIGFsc28gYWRkIHNvbWUgZXJyb3IgY2hlY2suDQo+
IA0KPiBXaGlsZSBhdCBpdCwgYWxzbyBtb3ZlIHRoZSBjb250ZW50cyBvZiBtdDgxOTVfYWZlX3Bh
cnNlX29mKCkgdG8gdGhlDQo+IHByb2JlIGZ1bmN0aW9uIGFzIHdlbGw6IHNpbmNlIHRoaXMgaXMg
Z2V0dGluZyBhIGhhbmRsZSB0byB0b3Bja2dlbg0KPiBhbmQgc2luY2UgdGhhdCdzIG9wdGlvbmFs
LCB0aGUgaWZkZWYgZm9yIENPTkZJR19TTkRfU09DX01UNjM1OSBjYW4NCj4gYWxzbyBiZSByZW1v
dmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0K
PiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNCkFja2VkLWJ5OiBU
cmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQoNCj4gLS0tDQo+ICBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1hZmUtcGNtLmMgfCAzMiArKysrKystLS0tLS0tLS0tLS0N
Cj4gLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL210ODE5NS9tdDgxOTUt
YWZlLXBjbS5jDQo+IGIvc291bmQvc29jL21lZGlhdGVrL210ODE5NS9tdDgxOTUtYWZlLXBjbS5j
DQo+IGluZGV4IDEwNWRiMTFlZWNlYy4uZDIyY2YxNjY0ZDhhIDEwMDY0NA0KPiAtLS0gYS9zb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1hZmUtcGNtLmMNCj4gKysrIGIvc291bmQvc29j
L21lZGlhdGVrL210ODE5NS9tdDgxOTUtYWZlLXBjbS5jDQo+IEBAIC0zMDMwLDI4ICszMDMwLDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdfc2VxdWVuY2UNCj4gbXQ4MTk1X2NnX3BhdGNoW10g
PSB7DQo+ICAgICAgICAgeyBBVURJT19UT1BfQ09OMSwgMHhmZmZmZmZmOCB9LA0KPiAgfTsNCj4g
DQo+IC1zdGF0aWMgaW50IG10ODE5NV9hZmVfaW5pdF9yZWdpc3RlcnMoc3RydWN0IG10a19iYXNl
X2FmZSAqYWZlKQ0KPiAtew0KPiAtICAgICAgIHJldHVybiByZWdtYXBfbXVsdGlfcmVnX3dyaXRl
KGFmZS0+cmVnbWFwLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICBtdDgxOTVfYWZlX3JlZ19k
ZWZhdWx0cywNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgQVJSQVlfU0laRShtdDgxOTVfYWZl
X3JlZ19kZWZhdWx0cykpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9pZCBtdDgxOTVfYWZlX3Bh
cnNlX29mKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAtew0KPiAtI2lmIElTX0VOQUJM
RUQoQ09ORklHX1NORF9TT0NfTVQ2MzU5KQ0KPiAtICAgICAgIHN0cnVjdCBtdDgxOTVfYWZlX3By
aXZhdGUgKmFmZV9wcml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiAtDQo+IC0gICAgICAgYWZl
X3ByaXYtPnRvcGNrZ2VuID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShhZmUtDQo+
ID5kZXYtPm9mX25vZGUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAibWVkaWF0ZQ0KPiBrLHRvcGNrZ2VuIik7DQo+IC0gICAg
ICAgaWYgKElTX0VSUihhZmVfcHJpdi0+dG9wY2tnZW4pKSB7DQo+IC0gICAgICAgICAgICAgICBk
ZXZfaW5mbyhhZmUtPmRldiwgIiVzKCkgQ2Fubm90IGZpbmQgdG9wY2tnZW4NCj4gY29udHJvbGxl
cjogJWxkXG4iLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIFBUUl9FUlIo
YWZlX3ByaXYtPnRvcGNrZ2VuKSk7DQo+IC0gICAgICAgfQ0KPiAtI2VuZGlmDQo+IC19DQo+IC0N
Cj4gIHN0YXRpYyBpbnQgbXQ4MTk1X2FmZV9wY21fZGV2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IG10a19iYXNlX2FmZSAqYWZlOw0K
PiBAQCAtMzE2MCw3ICszMTM4LDEwIEBAIHN0YXRpYyBpbnQgbXQ4MTk1X2FmZV9wY21fZGV2X3By
b2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgICAgICAgIHBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIGFmZSk7DQo+IA0KPiAtICAgICAgIG10ODE5NV9hZmVfcGFy
c2Vfb2YoYWZlLCBwZGV2LT5kZXYub2Zfbm9kZSk7DQo+ICsgICAgICAgYWZlX3ByaXYtPnRvcGNr
Z2VuID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShkZXYtDQo+ID5vZl9ub2RlLCAi
bWVkaWF0ZWssdG9wY2tnZW4iKTsNCj4gKyAgICAgICBpZiAoSVNfRVJSKGFmZV9wcml2LT50b3Bj
a2dlbikpDQo+ICsgICAgICAgICAgICAgICBkZXZfZGJnKGFmZS0+ZGV2LCAiQ2Fubm90IGZpbmQg
dG9wY2tnZW4gY29udHJvbGxlcjoNCj4gJWxkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBQVFJfRVJSKGFmZV9wcml2LT50b3Bja2dlbikpOw0KPiANCj4gICAgICAgICAvKiBlbmFibGUg
Y2xvY2sgZm9yIHJlZ2NhY2hlIGdldCBkZWZhdWx0IHZhbHVlIGZyb20gaHcgKi8NCj4gICAgICAg
ICBhZmVfcHJpdi0+cG1fcnVudGltZV9ieXBhc3NfcmVnX2N0bCA9IHRydWU7DQo+IEBAIC0zMjE5
LDcgKzMyMDAsMTAgQEAgc3RhdGljIGludCBtdDgxOTVfYWZlX3BjbV9kZXZfcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX3Bt
X3B1dDsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIG10ODE5NV9hZmVfaW5pdF9yZWdpc3Rl
cnMoYWZlKTsNCj4gKyAgICAgICByZXQgPSByZWdtYXBfbXVsdGlfcmVnX3dyaXRlKGFmZS0+cmVn
bWFwLA0KPiBtdDgxOTVfYWZlX3JlZ19kZWZhdWx0cywNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUobXQ4MTk1X2FmZV9yZWdfZGVmYXVsDQo+IHRzKSk7
DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX3B1dDsN
Cj4gDQo+ICAgICAgICAgcmV0ID0gcG1fcnVudGltZV9wdXRfc3luYyhkZXYpOw0KPiAgICAgICAg
IGlmIChyZXQpDQo+IC0tDQo+IDIuNDAuMQ0KPiANCj4gDQo=
