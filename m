Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E537B719085
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFAC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjFAC3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:29:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719EB3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:29:11 -0700 (PDT)
X-UUID: 146206ce002411ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SDcqfnKxeo4kKOpl1gWGmu+7WhF4V6tnoi6oFiz2tD8=;
        b=NhY4MPbiUYigKU4cKdcviwHcDpNHo3NjDy/4nsyPKTbwuMGwWm8e6/d+4YTyDz1RA+s9wj74G5GYktOLOBcexW/7jueP1I9/ifXCPYe1vjhia0kMhMRnjN/CTfhFRyUAcJKNuFR/0+mUjhj7lMhEynn4h+Q/j8hdv91QccQjXNQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e206d090-d094-4ae4-b3da-a39e1e2b0bf8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:e206d090-d094-4ae4-b3da-a39e1e2b0bf8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:a636a66d-2f20-4998-991c-3b78627e4938,B
        ulkID:230601102907EXLECDT5,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 146206ce002411ee9cb5633481061a41-20230601
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1064230120; Thu, 01 Jun 2023 10:29:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 10:29:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 10:29:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXYGbMoIbYCDYKXtiIc7ZXX4xivij5NVO9tetN5z8FCnJpPOP+ePmFp1wrvN022guz/DJpqPOqu6o3zUpfXIlgPQPkycDTbOPqaa1Q+iqpC89vd6FXNueFraf4JHjOnUMOp+4guXWgOHt3ob897zCG5i4xMRT/wqT1vjPYF00O6EE2y6UzZGfS/r+rk9u76gK4K4tI7tl/mdgbpx2liXbNetePGuaXKLGvvldOfyqUbdeAdad/4GLZPib5qBZ4u9VUD4Knjlzbi2expl9+PqZoY1kXjjZ97DbHNy23LluRcQpeJyP1MoIN+5DqCLzzg5AXdTSMQ783E0Qt5tX7F4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDcqfnKxeo4kKOpl1gWGmu+7WhF4V6tnoi6oFiz2tD8=;
 b=nAaDJVguJkAHt+1veVYwsPRPq+Z6DdT7lv3UKjtLnY6hUUelXCphtXzBWfaZjEbJl8n7+jHsaHW5dDn7F7IkkIAinujWNkIrMyAMLDbShxNtZKi9lKUVIgAF4OB5stozGj2seOnkeoxj+GaDikWKKqZywUqUfkzU9lNO5XyS8jSaUbIULBmOowMN8hY1XwsrTq0CWSsK1M94WQ+Os07bevFVQ4f50LRivsXixU+cHD7KwFG3EF58R1tDBDeau0uFrwZWYIielCgEj2+2Ocd8acx8j/dbs8dKfaZqGGXlrwSAZbwj+910mkeRFGnoPmCAgdw5JHYTF8xGMmkL6dIFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDcqfnKxeo4kKOpl1gWGmu+7WhF4V6tnoi6oFiz2tD8=;
 b=UopijOfM9gw4YfvIXB2xwd5+MaRLm/DReWn/x4LSkWABbYJKWzz2Vh+bbLPZl0BPTn85qTBx0pAxZb6M5REyk9LMGPOMkroElK7BDkt4LuGRqRo05thZFwhepV82blbbrtPIgxAdTbiVQxJCH4uYnbx5RFvSRJR5FT/FhHq3Lgg=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5310.apcprd03.prod.outlook.com (2603:1096:405:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:29:01 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:29:01 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH v2 2/2] ASoC: SOF: mediatek: add adsp debug dump
Thread-Topic: [PATCH v2 2/2] ASoC: SOF: mediatek: add adsp debug dump
Thread-Index: AQHZjSK0Rdkhhy4w/kWtFl8OymCliq9y52SAgAJf/AA=
Date:   Thu, 1 Jun 2023 02:29:01 +0000
Message-ID: <197ff41e8a0f10c48b7bd8bfdfe523734deace60.camel@mediatek.com>
References: <20230523025933.30494-1-trevor.wu@mediatek.com>
         <20230523025933.30494-3-trevor.wu@mediatek.com>
         <12f075ba-6886-4916-a62f-8fb004eeb4c9@sirena.org.uk>
In-Reply-To: <12f075ba-6886-4916-a62f-8fb004eeb4c9@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5310:EE_
x-ms-office365-filtering-correlation-id: 60897fb2-e979-40e2-6108-08db6247f640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuTlBI1zY5wdijmMYPA4PClhqynEXort2Er+PA8tW/2qAsgyj+qmR2UyPDmmaD1z0woFoIVJnX5c5S4vrgdcHeiw1HYoW6EF1auDz2y0bhTzcREd0vpkZ7djbRV2ECHK33q0ajQNhHfZdBCpjf6TuZEauzAxP7n4b1E/+ifrIQJksXdN0kPVzLIM1iki6D6LyDuqxAjj7I1yX+8W9LMOKzAn1/+i+kst76DKF8Sap4IovvrdMA2I9YC4A79uFY7yXhJ0jKXnkFXgO1EfKJy9bD+bMYPfz+KZIgHQ0LKic7IVWiJaA3AVyBIsJRDcGmqXWXxc7+JC/Ndu08BXS6B1Vl6NXgJZJi5GL/f8FlYFpPjoxdjokMCbIga1Wsgf3imcmbuupclOl/2EIAu6WNYnyvEjL/T8e6teo9h7+ZCxsyLyRHh2XqF1QBolrNR2/JSvr1d3n1IbC47mq9TPKSM18Fjlj3sCsb2Ghek1t02G6M4CAqkWirpaBAOgmRlgHn8FL6HmahsQyHeE3Ab4dmiHKCxiGGEWhXWwxgmtCfV0V7CnAW8Tz/AFGdv6kTcL499Q+R1w9uHl2oohypaGwyQAMT8BxZ6HKRZH+bi0uNG+cT7PvSDbAvrxkefp07lF1h9juyfM70JIcWpzOUa3kUrDfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(6486002)(71200400001)(478600001)(36756003)(85182001)(186003)(6506007)(6512007)(26005)(83380400001)(2616005)(38100700002)(38070700005)(86362001)(122000001)(316002)(4326008)(41300700001)(64756008)(66946007)(66556008)(66476007)(6916009)(66446008)(76116006)(91956017)(7416002)(2906002)(8676002)(5660300002)(8936002)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2FvUHJXdWdGemxOc1R6ZDlrbm5JTWN2Z1JYTkhScHZ1WWlaVVp6ejhsOWhH?=
 =?utf-8?B?RGNGOGZrVHZtQ2ZJb0hUVjAxeGVYMEViZUx6Y205NTBOSkQ4Q2tXM0Q5TmdE?=
 =?utf-8?B?WStIL29rc3pBZHJ5T1M1Wjc0RndrOS9Vejh5WCt1VTd4RHR0bjcyamtNcEJC?=
 =?utf-8?B?Vi9ZOTA1Y0RjRGZRK2gvc1JyUVlFbFJPdTQ1bDJWN1QyWUJ6ckNaM2ZTRDFC?=
 =?utf-8?B?YXZwNktkLzdxeXRmUjRueFFDQVIxaDBLaW5lbjAwK1hETVdRTzV3dncwOEYy?=
 =?utf-8?B?eDJIL01wMmUzaW9wVVJ1Zk5pdnJ4REJqQ2pUZU1YcHhYOUFBQUJZdEZVTTVz?=
 =?utf-8?B?MEpKcDczTlF3YjUvT1gzN3lFWDNuZXNYbXZ2emJBRjBQeUNRak5EcDRQUC9o?=
 =?utf-8?B?MkFRdFpLTUMxa3lqY3gyUXBjNlNoRWFpUXVWc3FlMk43a1Y0UXArME9IMS9I?=
 =?utf-8?B?VVY0SEE5S0dqSkRmVEM3a3ZPeFlXUkYyR1E0RlhlRG9NQzQ2WVdGVlRvd3Uz?=
 =?utf-8?B?a2VNenk1WFVZN3E0NlJCcEg5NXZ0aVQwbzh0U28yS2l1b3VBR1d6UFZLeWQx?=
 =?utf-8?B?NGRuS1gvT1IwMEQxdWt4Nm84VlBGdHZYeVBKaHhVeFAzVklLTUNkREpNdm9l?=
 =?utf-8?B?VU83TlN3NjYxOGNKdzdqNHViV2lvOTNwVHh6ZzJab3FNMVR0VlY2YUh5dWdi?=
 =?utf-8?B?MkZDbWd2Qk5HaFJvK2hYRDVaMEJNWjJyMmFPS3ByQStSck54dDZyZHo0NXpz?=
 =?utf-8?B?RWNoak1ybTRNSElPOVNJdUFVNVc5alp1YW9DYkFrTzFhK3B1QUxDaGpiQjFz?=
 =?utf-8?B?Ry8vOHU3NE1DTVhseis2OGFlRVo5QjI1UmxYaVlEbW1FQXE1c3JmQ0N2cmV2?=
 =?utf-8?B?emdwbEhSTUZBQ3h6b05XTFlSaU9WSVJjRXJsSE1lMThLTlYzZXJuM1c2ckIy?=
 =?utf-8?B?MW40V21CNm8wMWxLK29jNjYxalNnYUFJRW1NOGk2REc4ZWZsRXFPOEp1czVV?=
 =?utf-8?B?Tm9tOWxVaWRpUEJnVTdHKzFYbG1NeUQrNUZWWmNUOGNYMHVoWlJjdXkwY09L?=
 =?utf-8?B?QWZtUTVUbXAxYmRzZVRCRmxZeHFLclhaY3RwRnVNV0g1a0lRTEtIcjZBVGNJ?=
 =?utf-8?B?MGtvcGF2RUhZWDEvaVQ4V1BNZFBDbXlvMmhXSVJ6KzNrUDNOb2NnZWF2MW42?=
 =?utf-8?B?V3E3WVhaU2pXKzYySTBtaFdGY1VWQktqSTQ1RnFuRWpUOHlFKytZQXprUmxV?=
 =?utf-8?B?aWthdjF3Sk44RUtwYU91a0pxL2dMMGJwaEo0V2drb20rRHNocXNqUEhlNGhr?=
 =?utf-8?B?RlB6dG1kUUdtT3IxdkhLUVV0UkJ3d0NLZktTSHc0STlOdVB2a2tFMUpOaUx3?=
 =?utf-8?B?akJiMGM3NE5FaHZwaktUWUh5MWtqVWZaTXIwU0toZk1EMTBBZFJQbHNEUmJR?=
 =?utf-8?B?T29OQ1crbGxneHFhWEo2ODRRbGlPSkJqTHdCMUFNcmRYcEFkMENWM1cwaUc2?=
 =?utf-8?B?NVN4R0FwVjdFOHZDbXZveUFoU1AvODcwRzBLQjZQZUhhaDY3TlByeVh2KzNu?=
 =?utf-8?B?dmJxQ0JwS2hUQ3BMOUo4RnJWTHBaTWNlNm9oZmx6UEkvWUd3YmExVUl6c0py?=
 =?utf-8?B?cGtPendRejhxTzh0c21qMTV3ZVQrVHcxcDltaHAwM2JMYkdlL0FvbEhGSnRD?=
 =?utf-8?B?c2xBcGpHMVFvSHhwdXpFSXMxN1lKWDIzNm42SlM1bkJkam5OSSt4QnZ0M280?=
 =?utf-8?B?NG9CRjZWSWQra0d4K3FKdUQ4aFpkS2RhZkNmRG8xNHdzeE9HM0ljRmlVa2do?=
 =?utf-8?B?K0xOM0xtaDFJbjkyKzBqRUZvYjJPK3lFcjdDTHE0dlFFWHFLYnhCM24rV3dI?=
 =?utf-8?B?cnFHOWpVWnRnM1VJZ3BVQjVOL2N2bno2YWwvSFhZZnAzQWhVUklhY0RZVXEy?=
 =?utf-8?B?SGx6dHJzVEJlVktoNjJ6RkRPNzJrQkk5VzBvNW9DTEtMSnlLbC9DcnNaMXNx?=
 =?utf-8?B?U3NHUTQwZmRPVnpSV2J0cW1qWG5CVys4d084SWloeksvK2g4RHRFZnY0VWZl?=
 =?utf-8?B?ZW5CMGttdkVtQnhRakJTcklRL0RRWERiVk5mblZQclpJU09aVDY2NmxRYkZx?=
 =?utf-8?B?SDg1MDBIcnY0aEU2L1NIZGdJeUhHN0xsSjlOYzdBeTRLOXRWYkNrU0NMQWJH?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D83E5BA16FD1D48AF03B7434ACA6518@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60897fb2-e979-40e2-6108-08db6247f640
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 02:29:01.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdVxmVa0bfP39vx6M/RmGncMZnagXXp5SDp0nbIE2OWM4yFz30ISb3Psu6Dkxp3QN5IserJ2cAkLqs1FQMREqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5310
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDE1OjEyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIE1heSAyMywgMjAyMyBhdCAxMDo1OTozM0FNICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6
DQo+ID4gQWRkIG10ODE4OCBhbmQgbXQ4MTg2IC5kYmdfZHVtcCBjYWxsYmFjayB0byBwcmludCBz
b21lIGluZm9ybWF0aW9uDQo+ID4gd2hlbg0KPiA+IERTUCBwYW5pYyBvY2N1cnMuDQo+IA0KPiBU
aGlzIGJyZWFrcyBhbiB4ODZfNjQgYWxsbW9kY29uZmlnIGJ1aWxkOg0KPiANCj4gL2J1aWxkL3N0
YWdlL2xpbnV4L3NvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5jOiBJbg0KPiBm
dW5jdGlvbiDigJhtdDgxODZfYWRzcF9kdW1w4oCZOg0KPiAvYnVpbGQvc3RhZ2UvbGludXgvc291
bmQvc29jL3NvZi9tZWRpYXRlay9tdDgxODYvbXQ4MTg2LmM6NDgzOjU2Og0KPiBlcnJvcjog4oCY
RFNQX1BERUJVR0RBVEHigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24p
OyBkaWQNCj4geW91IG1lYW4g4oCYRFNQX1BERUJVR1BD4oCZPw0KPiAgIDQ4MyB8ICAgICAgICAg
ZGJnX2RhdGEgPSBzbmRfc29mX2RzcF9yZWFkKHNkZXYsIERTUF9SRUdfQkFSLA0KPiBEU1BfUERF
QlVHREFUQSk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fg0KPiB+fn5+fn5+fg0KPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEU1BfUEQNCj4g
RUJVR1BDDQo+IC9idWlsZC9zdGFnZS9saW51eC9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE4
Ni9tdDgxODYuYzo0ODM6NTY6DQo+IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlz
IHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaA0KPiBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQo+
IC9idWlsZC9zdGFnZS9saW51eC9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE4Ni9tdDgxODYu
Yzo0ODQ6NTY6DQo+IGVycm9yOiDigJhEU1BfUERFQlVHSU5TVOKAmSB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZA0KPiB5b3UgbWVhbiDigJhEU1BfUERFQlVHUEPi
gJk/DQo+ICAgNDg0IHwgICAgICAgICBkYmdfaW5zdCA9IHNuZF9zb2ZfZHNwX3JlYWQoc2Rldiwg
RFNQX1JFR19CQVIsDQo+IERTUF9QREVCVUdJTlNUKTsNCj4gICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+DQo+IH5+fn5+
fn5+DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERTUF9QRA0KPiBFQlVHUEMNCj4gL2J1aWxkL3N0YWdlL2xpbnV4L3NvdW5k
L3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5jOjQ4NTo1OToNCj4gZXJyb3I6IOKAmERT
UF9QREVCVUdMUzBTVEFU4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQ0KPiAgIDQ4NSB8ICAgICAgICAgZGJnX2xzMHN0YXQgPSBzbmRfc29mX2RzcF9yZWFkKHNkZXYs
IERTUF9SRUdfQkFSLA0KPiBEU1BfUERFQlVHTFMwU1RBVCk7DQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fg0KPiB+
fn5+fn5+fn5+fn5+fg0KPiAvYnVpbGQvc3RhZ2UvbGludXgvc291bmQvc29jL3NvZi9tZWRpYXRl
ay9tdDgxODYvbXQ4MTg2LmM6NDg2OjU4Og0KPiBlcnJvcjog4oCYRFNQX1BERUJVR1NUQVRVU+KA
mSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7DQo+IGRpZCB5b3UgbWVh
biDigJhEU1BfUERFQlVHUEPigJk/DQo+ICAgNDg2IHwgICAgICAgICBkYmdfc3RhdHVzID0gc25k
X3NvZl9kc3BfcmVhZChzZGV2LCBEU1BfUkVHX0JBUiwNCj4gRFNQX1BERUJVR1NUQVRVUyk7DQo+
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fg0KPiB+fn5+fn5+fn5+fn4NCj4gICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEU1BfDQo+IFBERUJVR1BD
DQo+IC9idWlsZC9zdGFnZS9saW51eC9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE4Ni9tdDgx
ODYuYzo0ODc6NTc6DQo+IGVycm9yOiDigJhEU1BfUEZBVUxUSU5GT+KAmSB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCj4gICA0ODcgfCAgICAgICAgIGZhdWx0aW5mbyA9
IHNuZF9zb2ZfZHNwX3JlYWQoc2RldiwgRFNQX1JFR19CQVIsDQo+IERTUF9QRkFVTFRJTkZPKTsN
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+DQo+IH5+fn5+fn5+fg0KDQoNClNvcnJ5LCBJIGRpZG4ndCBub3RpY2Ug
dGhhdCBJIG1pc3NlZCB0aGUgaGVhZGVyIHdoaWNoIHBvc3NpYmx5IGNhdXNlZA0KYnkgdGhlIHdy
b25nIGZvcm1hdC1wYXRjaCBjb21tYW5kLiBJIGNoZWNrZWQgdGhlIHNhbWUgcGF0Y2ggaW4gdjEs
IGFuZA0KdGhlIGhlYWRlciB3YXMgaW5jbHVkZWQgaW4gdGhlIHNlcmllcy4gSSB3aWxsIHNlbmQg
djMgdG8gcmVzb2x2ZSB0aGUNCnByb2JsZW0uDQoNClRoYW5rcywNClRyZXZvcg0K
