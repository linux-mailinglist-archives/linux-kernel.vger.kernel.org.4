Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03672FB78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbjFNKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjFNKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:44:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A59A7;
        Wed, 14 Jun 2023 03:44:22 -0700 (PDT)
X-UUID: 4679c5c80a9411eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nYb6eBfox5pj/5qW1FlwR0wUupDPSVYIBQpN4jV5FHY=;
        b=NzvAq59PcMuy3x2VUYA+LwOa5fL/ukMCdlLJ/XZbVxvn7g/GZyCxpfkK1JNnVK0qFEuhh1vsUulovtdmpDmpeSkYAKU62iC3tWS/y9h/rhs6XHX5R2lSGnNPtR+YABHo1pJ0qoanwxzOpgDV3mlTCiny4GRGXgonsUWcj2e1r1g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:8d615861-38a7-48e2-99b0-cb9bea92fc57,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:09e5963e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4679c5c80a9411eeb20a276fd37b9834-20230614
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1916667790; Wed, 14 Jun 2023 17:17:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 17:17:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 17:17:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4ISz8WbfJK1ni6SquckwfNx5tViKDHTSIKltRsXjYMjGf4bXuAeERyT6RQ+rLNPpiX2G0NFcjmBXTLNQOhkc6wNIWS5G2NnmODPFQ73I/yxxZ/8FdhT7ln/PBLfe4K0Qrbz/czA6IbbRtVYC7jX2uVAT0Aj3gW5xOus6pKfwKNzhXKhoAEL4/553y92umRrsBzwty9L87ynTVD3sjeK4YLWujMZ8y+RD8O09gEkG919Fj97qCIvgkCkoD0pqyb2+IbsF2t1C5Ldt69BqwqpONORnu/Z/bbuaseMiPMNZfw7/6wY3Z9e8mfmn8iOYhaCWDNEzzb3EfqsOme+Ywyhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYb6eBfox5pj/5qW1FlwR0wUupDPSVYIBQpN4jV5FHY=;
 b=hH1aLg3iMD6KJSpwuvL9rn/lI4vUiXZ706oQJtany/EiT/hGgOIXDU0W6cv1lOuzxF0wq4pkm9G4qD4Fvt5cLufaXwCFybtnF9R0cseAMcu7F1Af9TT2MZjFMFZNCnUB5Un0v6XZlieTe26jcIU0Tb62P6JQVzYc7wUgr+c4WccWnEm2yJT2t1tHBLe65jJ+TCqZScZQ8FrjK6hohFzReKHC1/wwYpZ3xymNhX11lKUKvU87SnPEz1rTNNZucK2gHmcSBWe8MznFa2F6n+CqIp0sokg75TS7rmE1JUNV3IF8z3A6Qtnop7NUTfpqtZXsZfgJAVX4Ql9iw5xZht/gRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYb6eBfox5pj/5qW1FlwR0wUupDPSVYIBQpN4jV5FHY=;
 b=d84is/VYvcOsmByzPErgiHOz4SkyhEH1IL5CNfOYEZrxC91szEHxCt0nMS1eTm3t2tiMZqjKf3dIcBKOGFX0/SVxUiVx+alTJ98+chZvTtN0vm88hwEASsBvqKsqZy5jBDvMMhmq7yLlpq2+NM87xpioo5cp7pizAFkxFNStLBU=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PUZPR03MB6910.apcprd03.prod.outlook.com (2603:1096:301:fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 09:17:21 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 09:17:20 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Thread-Topic: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Thread-Index: AQHZmR0jmQkpnXgRrkqIvSc9R6kUVa+AImQAgABg2ICAAF/4AIAAD38AgAATpoCACQl2gA==
Date:   Wed, 14 Jun 2023 09:17:20 +0000
Message-ID: <1ea03faee8da26e17690c707464ab1cda405a313.camel@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
         <20230607084901.28021-5-yunfei.dong@mediatek.com>
         <ad28c125d9efca1f7e422fffe42dd56cef66b349.camel@collabora.com>
         <6bb7e4b283332f1b76c1550347cb245a57eee90b.camel@mediatek.com>
         <ac3f4becf89d909503caeb8a05883fc38afccd41.camel@collabora.com>
         <925956db-9001-7a4f-700e-c84220103201@collabora.com>
         <e1e00e3207784f48b6adc9c3b6ec48f57795228d.camel@collabora.com>
In-Reply-To: <e1e00e3207784f48b6adc9c3b6ec48f57795228d.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PUZPR03MB6910:EE_
x-ms-office365-filtering-correlation-id: ed0b2727-6d3a-42fb-1f57-08db6cb82836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NLBBBmD0+BZtl6zU+r5PP3UbVggECxedsou64pczPLOc2OV7ZcPDBDx9JwBSOA4S3PaCxfEBqj9TfgZ44M9ZxImu7+HDuHSEgoqoA/57E4CTVSpdtdUFj8DEkamgEFrirXn2ZUHhZSEVnSjSCNodMCFfCzHIPrwBgwG3xyfOBQ5nxe1DBYD7qunKJfQ81qz/zMFtIJsoDDg996/N6tt+G3CaePK1u+HmTncI3y7wU/ZKxV+8/4sXzOLUUfKmpAckJYa2EJowatvnb6E2DoJhGM2ZoJCD+l7hn+U+go+mRMetK74WfnaBkldinYDqy2v6s6PE1vF61Tq8OuJ9I5fJecQ3AHW4Si2YM2o4aQDVAfZ+6XqQc9Ys1eaHmARX6WXSXCCSUrFmSRAJ8zzrSa79gKT8cwNuh3DaoNXh0fet2A3TKxBJUQeCA708rB+5n9iUmXRlOa9XT5z02HsIKn6HFg2BINLpTFeNpzPUkGiXluwRnCT1cNLB5msSAhTa6O/O5b4gWl46Vx+W1nHK72OpL/+bV0tjNe4S5ledeXtQSgmK9SkFQTtaSgk+EKUEPBjalUYrZ/qqBc61mezN9SNOh2NrooqV2XUXWGcUU0KhL8zxPog8CWIGtPx7/dyjRPlLHLh7JcCtmm1WRMQLkPKrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(122000001)(86362001)(2906002)(38070700005)(2616005)(26005)(186003)(83380400001)(6506007)(6512007)(478600001)(66574015)(38100700002)(6486002)(85182001)(71200400001)(41300700001)(5660300002)(8676002)(8936002)(66556008)(76116006)(66946007)(4326008)(110136005)(64756008)(36756003)(316002)(66476007)(66446008)(91956017)(54906003)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cyttRTNEV29kdXdsdnBRcnI0dzhmWTlFS2h1VXo4aGk0T3ZhQWhTOVdkdCtJ?=
 =?utf-8?B?OXhjdmNIakxXNEZERzEvY29ncWxuY0xzOER2dmtZa0xzMG9jd3ViODhsMTc2?=
 =?utf-8?B?YUFhazh0UVM0MHFJcGpURWRGN1pSaGpmMkdadFUzRzhtbS9zTjREbS9MV2Nh?=
 =?utf-8?B?LzE3TWlITUNybVp2ZkQvOWU1UnpXWUxGbFp4WTZPNk5LRm5FVkhJL2hxNk8w?=
 =?utf-8?B?VkxXQ0hNNEhyOHVDbXp1c25mcXd3Q3BIWXNtQjMwdFl1NUNQbUVyQzlhTHZ0?=
 =?utf-8?B?Z1dDYW1VUU93c2VWVTBpYThHbzRQRHZiNmQ2a1pobjhaNysveVNZRHZRWS82?=
 =?utf-8?B?eXM0eWpoU25IcFlWdWw0Zko2KzI5aFFwL1RKSGQzaVN3blg0WXpxV205Szl2?=
 =?utf-8?B?NVpQSk1DRzV1ZmV5alRsbitmQmZ0bUI1VUV3VzNIMk85YU5VMzhqRzBBMWhZ?=
 =?utf-8?B?QWNtak9rZ2I5aElad1BObGg1WDJVKzdOdUNyTThjZnhJWkNrL2JGZGl6YlVa?=
 =?utf-8?B?YUdxRWlhcmFLZCs5ZnJScy9CVXRMTzdwUjRpeVJBNmxjNFlXZ2lmMFBVVTF6?=
 =?utf-8?B?N1EzWjNRRlQ3VU15U3FkMkJLY2FQc3l3b24vdzVUQllRcjFwQ0dleDM1SjBx?=
 =?utf-8?B?K2ovbDBJQ0pFaEF2bnBTNnFveE4zMENFRWZFeXlxdElXd2ZKUGQxM0NkQk0z?=
 =?utf-8?B?RmdROEVVZlF4V3Vwc0pLcWI0NFZQeDUxcDFUM3lBcFcvRVB6WnFKR0QwYmNz?=
 =?utf-8?B?YnRzZ1dPTVhmQW8wVXRJYjZLcDJ1TVNTUy9oS3FKK0R3eWd5NlVTcDZvWUxD?=
 =?utf-8?B?TncvSlkvVXpIc3ltZXU1anFEMzF1UGllckhhV09lWDdma1ovVjJEZGsyQlND?=
 =?utf-8?B?eTdXTWpZcGZHVWtKSUdCTldaREkzL3pCcHVtTC8yQ2MrUHNHWjhra0ZEbGJM?=
 =?utf-8?B?VHREbld6NDgzYllJOFU0QUhOUjJBWEdPYThhQUNvcC9iR25IK29BSC83Z0ty?=
 =?utf-8?B?Q2NPWjVBKzE5SzhSMHNtVHlMN1MvYjJrb3pVSUdSVzNvVTJzL21WWFFFQy9G?=
 =?utf-8?B?Q2tvck00NkRkY3JxdktxK28xVUF3cEI5emV4NU9MTnNybXlPT01GVWFYYmxR?=
 =?utf-8?B?SnpCRWJ5eUV5TENUdStTTHcxc0tZUGpWSk9qN1FrTW1ybGNLYlpKMmV4SDRN?=
 =?utf-8?B?TzdTcGNmVjVpU2toVEhHOHB2V3NaK2wvZ1RwcjI0V1FoamNCdmQ2UzBhTmdU?=
 =?utf-8?B?OFZzSWJLVFhiZnNsMTMzM255VGxqODF5RC9WT2d2S2JGWTBOZ2pGcTNseXVq?=
 =?utf-8?B?NGZ3d0xYMjZRVWJ2Slp5ZHphWXNjT0YwenVpMWFMQm1GK3R5ZEhKT3lXMXZi?=
 =?utf-8?B?bXAralZSWGExRmhGZktVOWJGclBsNDFHUjFyQ2hSNFVQUUJuZk9QamRJdjF3?=
 =?utf-8?B?TmhIb0xYS01NSlBjSjBVOUlERVNKQW1IVjAvWjRhL3BkZm9LQWZxY3R0TEE2?=
 =?utf-8?B?RHVMeWQxbzIyc1VEMkJXMEVmcUFiNkFGdXFHT0dlSTJmb2tRaHhLVGxUNGhY?=
 =?utf-8?B?MFVLcmtmU2MyWGZTY0xLQmZ3d0lvdWMvd1ZhNVhWQ0pyL2I1bVF5UWZHSmxP?=
 =?utf-8?B?Q1Q2SjRsWjVNdHZwaFlMbThydE8zaUJncFdyYWFCSGowc1ZGK3FrWVF1OEhh?=
 =?utf-8?B?eUNOTy9MczJMMmo1aUkxTlJURnNzd0ZWK3ZsMXFaYitZanFuWTh4aXlXTXE4?=
 =?utf-8?B?RVB5Rmt6Nzk0UWd1S3V4K2Z1cUdDU0w1cEVSejhqRkFZNll0OHgybS9tSlIz?=
 =?utf-8?B?ZmlYQklBUjBwWU1WUnBVY3QxVWFmTWc0bENDeHRxK2tweVFzbmREQ1BKNEM4?=
 =?utf-8?B?YUIwejRyOVdQOVo2MGtoUlJSWXRlQ2lxY2QwVmVsR0UxTytQOWwvNTZEVHJ2?=
 =?utf-8?B?VjJEaGdJS0xLbUhoVHI4YnBnVUVTOHpKUGttMTNlaS94MFI1eHJhVitYVXFm?=
 =?utf-8?B?RFZJQkpYZUFSUU5WQ2FhVHRDZVdtK3dhUDJrYUdadm4renllOU01YndTazZZ?=
 =?utf-8?B?c3kyOFZCVmNCYWVRZE1jZUJsb25qK2ZUTm5uY2s1M0lnQ1M0cVIzWjU1OUo2?=
 =?utf-8?B?UTc2M1daWEZpUDh5RktIN3VrV3MzTXhoUUMvamh2TkFYNXBWLzh5N1ZEaFhi?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <144CC0BC9B462E48A92600460E7AEEEB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0b2727-6d3a-42fb-1f57-08db6cb82836
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:17:20.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwQXywlUr+MYjHEHkiovq0QTUewaXxoVG7HJQO4baIdjC8wUlTFZYiIkikAYmqI6tsjyt/Z8wdmNtHakZOflbzmn14SCX8mk2npnFLyDOEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6910
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KSG93IGRvIHlvdSB0aGluayBhYm91dCBOaWNvbGFzJ3Mg
c3VnZ2VzdGlvbj8NCg0KT24gVGh1LCAyMDIzLTA2LTA4IGF0IDExOjE3IC0wNDAwLCBOaWNvbGFz
IER1ZnJlc25lIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIExlIGpldWRpIDA4IGp1aW4gMjAyMyDD
oCAxNjowNiArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gYQ0KPiDDqWNyaXQgOg0K
PiA+IElsIDA4LzA2LzIzIDE1OjExLCBOaWNvbGFzIER1ZnJlc25lIGhhIHNjcml0dG86DQo+ID4g
PiBMZSBqZXVkaSAwOCBqdWluIDIwMjMgw6AgMDc6MjcgKzAwMDAsIFl1bmZlaSBEb25nICjokaPk
upHpo54pIGEgw6ljcml0IDoNCj4gPiA+ID4gSGkgTmljb2xhcywNCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+ID4gPiA+IE9uIFdlZCwgMjAyMy0wNi0wNyBhdCAy
MTo0MSAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gPiA+ID4gPiAgIA0KPiA+ID4g
PiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+
IGF0dGFjaG1lbnRzIHVudGlsDQo+ID4gPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiAgIEhpIFl1bmZlaSwNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBMZSBtZXJjcmVkaSAwNyBqdWluIDIwMjMgw6AgMTY6NDggKzA4MDAsIFl1bmZlaSBE
b25nIGEgw6ljcml0IDoNCj4gPiA+ID4gPiA+ICdtdGtfdmNvZGVjX2RlYnVnJyBhbmQgJ210a192
Y29kZWNfZXJyJyBkZXBlbmRzIG9uDQo+ICdtdGtfdmNvZGVjX2N0eCcNCj4gPiA+ID4gPiA+IHRv
IGdldCB0aGUgaW5kZXggb2YgZWFjaCBpbnN0YW5jZSwgdXNpbmcgdGhlIGluZGV4IGRpcmVjdGx5
DQo+IGluc3RlYWQNCj4gPiA+ID4gPiA+IG9mIHdpdGggJ210a192Y29kZWNfY3R4Jy4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5k
b25nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gICAuLi4vbWVk
aWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5oICAgICAgICAgfCAgMjYgKystDQo+ID4gPiA+
ID4gPiAgIC4uLi92Y29kZWMvdmRlYy92ZGVjX2F2MV9yZXFfbGF0X2lmLmMgICAgICAgICB8IDEw
NQ0KPiArKysrKysrLS0tLS0NCj4gPiA+ID4gPiA+ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVj
L3ZkZWNfaDI2NF9pZi5jICAgICAgIHwgIDYyICsrKystDQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4u
Li9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gyNjRfcmVxX2lmLmMgICB8ICAzOSArKystLQ0K
PiA+ID4gPiA+ID4gICAuLi4vdmNvZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9pZi5jICAg
ICAgfCAgODANCj4gKysrKystLS0tDQo+ID4gPiA+ID4gPiAgIC4uLi92Y29kZWMvdmRlYy92ZGVj
X2hldmNfcmVxX211bHRpX2lmLmMgICAgICB8ICA2NyArKysrLQ0KPiAtLS0NCj4gPiA+ID4gPiA+
ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfdnA4X2lmLmMgICAgICAgIHwgIDU0ICsr
KystDQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3Zw
OF9yZXFfaWYuYyAgICB8ICA0NiArKysNCj4gLS0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRl
ay92Y29kZWMvdmRlYy92ZGVjX3ZwOV9pZi5jICAgICAgICB8IDE1Mg0KPiArKysrKysrKysrLS0N
Cj4gPiA+ID4gPiAtLS0tLS0NCj4gPiA+ID4gPiA+ICAgLi4uL3Zjb2RlYy92ZGVjL3ZkZWNfdnA5
X3JlcV9sYXRfaWYuYyAgICAgICAgIHwgIDg0DQo+ICsrKysrKy0tLS0NCj4gPiA+ID4gPiA+ICAg
Li4uL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjX3ZwdV9pZi5jICAgIHwgIDU5ICsrKyst
DQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmVuYy92ZW5jX2gyNjRf
aWYuYyAgICAgICB8ICA4Ng0KPiArKysrKy0tLS0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRl
ay92Y29kZWMvdmVuYy92ZW5jX3ZwOF9pZi5jICAgICAgICB8ICA0OCArKysNCj4gLS0tDQo+ID4g
PiA+ID4gPiAgIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmVuY192cHVfaWYuYyAgICB8
ICA2NCArKysrLQ0KPiAtLS0NCj4gPiA+ID4gPiA+ICAgMTQgZmlsZXMgY2hhbmdlZCwgNTY1IGlu
c2VydGlvbnMoKyksIDQwNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92
Y29kZWMvbXRrX3Zjb2RlY191dGlsLmgNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5oDQo+ID4gPiA+ID4gPiBpbmRleCBl
Y2IwYmRmM2E0ZjQuLmRkYzEyYzNlMjk4MyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLQ0KPiBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5oDQo+
ID4gPiA+ID4gPiArKysNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2Rl
Yy9tdGtfdmNvZGVjX3V0aWwuaA0KPiA+ID4gPiA+ID4gQEAgLTMxLDkgKzMxLDggQEAgc3RydWN0
IG10a192Y29kZWNfZGV2Ow0KPiA+ID4gPiA+ID4gICAjZGVmaW5lIG10a192NGwyX2VycihmbXQs
IGFyZ3MuLi4pICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+ICAgcHJfZXJyKCJbTVRLX1Y0
TDJdW0VSUk9SXSAiIGZtdCAiXG4iLCAjI2FyZ3MpDQo+ID4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+
ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19lcnIoaCwgZm10LCBhcmdzLi4uKVwNCj4gPiA+ID4gPiA+
IC1wcl9lcnIoIltNVEtfVkNPREVDXVtFUlJPUl1bJWRdOiAiIGZtdCAiXG4iLFwNCj4gPiA+ID4g
PiA+IC0gICAgICAgKChzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKikoaCktPmN0eCktPmlkLCAjI2Fy
Z3MpDQo+ID4gPiA+ID4gPiArI2RlZmluZSBtdGtfdmNvZGVjX2VycihwbGF0X2RldiwgaW5zdF9p
ZCwgZm10LA0KPiA+ID4gPiA+IGFyZ3MuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPiA+ID4gPiA+ID4gK2Rldl9lcnIoJihwbGF0X2RldiktPmRldiwgIltNVEtfVkNPREVD
XVtFUlJPUl1bJWRdOiAiIGZtdA0KPiAiXG4iLA0KPiA+ID4gPiA+IGluc3RfaWQsICMjYXJncykN
Cj4gPiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gPiAgICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19G
UykNCj4gPiA+ID4gPiA+ICAgZXh0ZXJuIGludCBtdGtfdjRsMl9kYmdfbGV2ZWw7DQo+ID4gPiA+
ID4gPiBAQCAtNDYsMjcgKzQ1LDI0IEBAIGV4dGVybiBpbnQgbXRrX3Zjb2RlY19kYmc7DQo+ID4g
PiA+ID4gPiAgICBfX2Z1bmNfXywgX19MSU5FX18sICMjYXJncyk7ICAgICAgICBcDQo+ID4gPiA+
ID4gPiAgIH0gd2hpbGUgKDApDQo+ID4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+ID4gLSNkZWZpbmUg
bXRrX3Zjb2RlY19kZWJ1ZyhoLCBmbXQsDQo+IGFyZ3MuLi4pICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gPiA+ID4gPiA+IC1kbyB7ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+
IC1pZiAobXRrX3Zjb2RlY19kYmcpICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+
IC1kZXZfZGJnKCYoKChzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKikoaCktPmN0eCktPmRldi0NCj4g
PnBsYXRfZGV2LQ0KPiA+ID4gPiA+ID4gZGV2KSwgICBcDQo+ID4gPiA+ID4gPiAtIltNVEtfVkNP
REVDXVslZF06ICVzLCAlZCAiIGZtdA0KPiAiXG4iLCAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ID4gPiA+ID4gPiAtKChzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKikoaCktPmN0eCktDQo+ID5p
ZCwgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gPiA+ID4gLV9fZnVuY19fLCBfX0xJTkVf
XywNCj4gIyNhcmdzKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4g
PiA+ID4gKyNkZWZpbmUgbXRrX3Zjb2RlY19kZWJ1ZyhwbGF0X2RldiwgaW5zdF9pZCwgZm10LA0K
PiA+ID4gPiA+IGFyZ3MuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+
ID4gPiA+ICtkbw0KPiA+ID4gPiA+IHsNCj4gPiA+ID4gPiAgICAgICAgICBcDQo+ID4gPiA+ID4g
PiAraWYNCj4gPiA+ID4gPiAobXRrX3Zjb2RlY19kYmcpDQo+ID4gPiA+ID4gXA0KPiA+ID4gPiA+
ID4gK2Rldl9kYmcoJihwbGF0X2RldiktPmRldiwgIltNVEtfVkNPREVDXVslZF06ICVzLCAlZCAi
IGZtdA0KPiAiXG4iLCBcDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQXQgbGVhc3QgaW4gdGhpcyBw
YXRjaCwgeW91IHN5c3RlbWF0aWNhbGx5IHBhc3MgcGxhdF9kZXYgYXMNCj4gPiA+ID4gPiA8c29t
ZXRoaW5nPi0+Y3R4LT5kZXYtPnBsYXRfZGV2LCB3aGljaCBpcyBxdWl0ZSBsb25nIGFuZA0KPiB2
ZXJib3NlLCBhbnkNCj4gPiA+ID4gPiByZWFzb24gd2UNCj4gPiA+ID4gPiBjYW4ndCBqdXN0IHBh
c3MgdGhhdCA8c29tZXRoaW5nPiBoZXJlID8gV2UgY2FuIGZvbGxvdyB0aGUNCj4gc2FtZQ0KPiA+
ID4gPiA+IHN0cnVjdHVyZSBwYXRoDQo+ID4gPiA+ID4gZm9yIGJvdGggZW5jb2Rlci9kZWNvZGVy
ID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEluIG9yZGVyIHRvIHNlcGFyYXRlIGVu
Y29kZSBhbmQgZGVjb2RlciwgbmVlZCB0byBkZWZpbmUgdHdvDQo+IGRpZmZlcmVudA0KPiA+ID4g
PiBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4IGFuZCBzdHJ1Y3QgbXRrX3Zjb2RlY19lbmNfY3R4
Lg0KPiA+ID4gPiANCj4gPiA+ID4gc3RydWN0IG10a192Y29kZWNfY3R4IHdvbid0IGJlIHVzZWQg
YWdhaW4sIG5lZWQgdG8gdXNlIHBsYXRmb3JtDQo+IGRldmljZQ0KPiA+ID4gPiB0byBwcmludCBk
ZXZfZGJnIGFuZCBkZXZfZXJyLg0KPiA+ID4gPiANCj4gPiA+ID4gZW5jb2RlciBhbmQgZGVjb2Rl
ciB1c2luZyB0aGUgc2FtZSBpbnRlcmZhY2UgdG8gcHJpbnQgbG9nDQo+IG1lc3NhZ2UuDQo+ID4g
PiANCj4gPiA+IEp1c3QgYSByZW1pbmRlciwgSSdtIGp1c3QgbWFraW5nIHN1Z2dlc3Rpb25zLCB0
aGVyZSBpcyBubyBzdHJpY3QNCj4gYWN0aW9uIHJlcXVpcmVkDQo+ID4gPiBoZXJlIG90aGVyIHRo
ZW4gYSBkaXNjdXNzaW9uIHRvIHRyeSBhbmQgbWFrZSB0aGUgbG9nZ2luZyBhIGJpdA0KPiBtb3Jl
IGxpZ2h0Lg0KPiA+ID4gDQo+ID4gPiBNeSBwb2ludHMgd2FzIHRoYXQgQyBtYWNyb3MgZG9uJ3Qg
Y2FyZSBhYm91dCB0eXBlcywgc28gaWYgeW91DQo+IGtlZXAgdGhlIHBhdGggdG8NCj4gPiA+IHRo
ZSBwbGF0Zm9ybSBkZXZpY2UgdGhlIHNhbWUgKGN0eC0+ZGV2LT5wbGF0X2RldiksIHlvdSBjb3Vs
ZCBqdXN0DQo+IHBhc3MgdGhlIGN0eA0KPiA+ID4gYXMgYXJndW1lbnQuIFdoYXQgSSBkb24ndCBr
bm93IHRob3VnaCBteXNlbGYsIGlzIGlmIHRoaXMgaXMNCj4gYWN0dWFsbHkgZmVhc2libGUgaW4N
Cj4gPiA+IGFsbCBjb2RlIHBhdGgsIGJ1dCBjb25zaWRlcmluZyB5b3UgaGFkIGFjY2VzcyB0byB0
aGUgaW5zdGFuY2UNCj4gcHJldmlvdXNseSwgSQ0KPiA+ID4gdGhvdWdodCBpdCBzaG91bGQuDQo+
ID4gPiANCj4gPiANCj4gPiBPbmUgbWFjcm8gdXNlZCB0byBhY2Nlc3MgdHdvIGRpZmZlcmVudCBz
dHJ1Y3R1cmVzPw0KPiA+IA0KPiA+IFBsZWFzZSwgbm8uDQo+IA0KPiBJdHMgdXAgdG8geW91LiBJ
IGRvIHRoaW5rIHRoaXMgaXMgYW4gZW1wdHkgc3RhdGVtZW50LiBTdGlsbCBiZWxpZXZlDQo+IHdl
IGF2b2lkDQo+IHRoaXMgY29kZSAiZGV0ZXJpb3JhdGlvbiIuIE9uZSBjYW4gYWx3YXlzIGJlIGNy
ZWF0aXZlIHRvIHdvcmthcm91bmQNCj4geW91cg0KPiBjb25jZXJucy4NCj4gDQo+IHN0cnVjdCBi
YXNlX2N0eCB7DQo+IHN0cnVjdCBkZXYgZGV2Ow0KPiB9DQo+IA0KPiBzdHJ1Y3QgZW5jX2N0eCB7
DQo+IHN0cnVjdCBiYXNlX2N0eDsNCj4gLi4uDQo+IH0NCj4gDQo+IHN0cnVjdCBzcmNfY3R4IHsN
Cj4gLi4uDQo+IH0NCj4gDQo+IEJ1dCB0aGlzIGlzIGluIG5vIHdheSBtb3JlIHNhZmUgdGhlbiBh
IG5hbWluZyBjb252ZW50aW9uLCB0aGlzIGlzDQo+IG1hY3JvIGNhbGxzLA0KPiBpdHMgbm90IHR5
cGVkLg0KPiANCj4gTmljb2xhcw0KPiANCg0KSW4gb3JkZXIgdG8gc3BlZWQgdXAgdGhlIHVwc3Ry
ZWFtIHByb2dyZXNzLCBtYXliZSB3ZSBjYW4gZGlzY3VzcyBpdCBpbg0KY2hhdC4NCg0KQmVzdCBS
ZWFncmRzLA0KWXVuZmVpIERvbmcNCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IEFuZ2Vsbw0KPiA+
IA0KPiA+ID4gcmVnYXJkcywNCj4gPiA+IE5pY29sYXMNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4gPiBZdW5mZWkgRG9uZw0KPiA+ID4gPiA+ID4gK2luc3Rf
aWQsIF9fZnVuY19fLCBfX0xJTkVfXywgIyNhcmdzKTsgICAgICAgICAgICAgICAgICAgXA0KPiA+
ID4gPiA+ID4gICB9IHdoaWxlICgwKQ0KPiA+ID4gPiA+ID4gICAjZWxzZQ0KPiA+ID4gPiA+ID4g
ICAjZGVmaW5lIG10a192NGwyX2RlYnVnKGxldmVsLCBmbXQsIGFyZ3MuLi4pIHByX2RlYnVnKGZt
dCwNCj4gIyNhcmdzKQ0KPiA+ID4gPiA+ID4gICANCj4gPiA+ID4gPiA+IC0jZGVmaW5lIG10a192
Y29kZWNfZGVidWcoaCwgZm10LCBhcmdzLi4uKVwNCj4gPiA+ID4gPiA+IC1wcl9kZWJ1ZygiW01U
S19WQ09ERUNdWyVkXTogIiBmbXQgIlxuIixcDQo+ID4gPiA+ID4gDQo+ID4gPiA+IC4uLnNuaXAu
Li4NCj4gPiA+IA0KPiA+IA0KPiANCg==
