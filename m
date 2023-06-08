Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA7727D70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjFHLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjFHLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:02:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3200F1BFF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:02:13 -0700 (PDT)
X-UUID: e8d1b81a05eb11ee9cb5633481061a41-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qElEAyRbvoMW+aV2G51ybBhOlg2i79rxvW56eOTJaRc=;
        b=PuHS1o5Q8f6dQJz2lO5sgSReVMJiIBkb/lCbm0u2GozpZ0VgJZwkux4yquuWwiDBPs2yu5xj70r7L/5dCkt+02pXk+XBlkQlYd64gdFwqKkgnAHSyspJpfXmAwAJUdnJpS4qPXQxoJazF7ZIr7Fp7OdAHZu6Mv3irZ9/zdDrCcI=;
X-CID-CACHE: Type:Local,Time:202306081803+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:a7b8a874-b183-463c-8e57-ba1e7f3a93be,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:27c6706e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e8d1b81a05eb11ee9cb5633481061a41-20230608
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1369518136; Thu, 08 Jun 2023 19:02:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 19:02:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 19:02:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac7cYDFbbFwg4YwR31FONGlcdlTLOxslAKkPbYQtz1HR9dP8Te1yX0sMoTHeR0nn3G7kDF5pUHYi+brakwhcF/7QFLk7FaK3dAln1gE1vUH8eSL94gvacVDDoZP4YplU0CG/dM7/2Aqp2koCvuEn2hZqmJVxY/zuvUX58LXDPjeW/fdNpmUAf01DMClHKyvz9rIcZeEiabIEqIe/mY1iWrXQ3B1pkf8ACR8ppezkzlLj/oM0HB24LdXOIove7FTdjD7PMZMcXP1xduBcA5NgidPu20mZVZGVZvnPot4O1Rk+f/6VQ2S6fGRda5D92QJDLtRCiwARxr3YwpS/veZ05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qElEAyRbvoMW+aV2G51ybBhOlg2i79rxvW56eOTJaRc=;
 b=amDEXyISyDS3kv7tujoPuG6m0evrGJ7+A93O24ZN4t+Edm2774aXZZ/zCt6oWkprh00AuoryRxetQXo4m3eR50vMSP94PPoCv+J+lx/sZZYKuHOKls8cwA9NE6OiQomAyRQOwShYNLK6SPuZ3H6IT/YcFL9zcSCjW0Ac8lAdKPlDHD88xSU+xfGbHZDYlPrafa5ub6W6RSGJbFFOvXU64sLWw4qqEldhftbwIp/yRG7Nognele1oUZ6Ru5teAHEkiwgSWu7PRFZnXG1coAfkvoEVHoF3CYpQTZoBdH5cjQc92jU/TIPNhesbheXdUroIQLRCI+SvS+LK9Tru0cO5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qElEAyRbvoMW+aV2G51ybBhOlg2i79rxvW56eOTJaRc=;
 b=K93YQ44QsHewhRZXMrECAkufK1jWSFSORh2x7GNMktCJba+Oe79w9crqXHXRp1iXObUf6jtO7EevqXc5yuXEaL1TEr/1RuyV8bYlGLlKEWtQ4S9k5MnG/+SKwCCOmjAlPZsbP3/lF8C/jbNL9AKTSvjq0UHeJyhK8uV+Ws6W478=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB5627.apcprd03.prod.outlook.com (2603:1096:4:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 11:02:03 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 11:02:02 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Thread-Topic: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Thread-Index: AQHZmeXp4zfNsUjaO0GaDbveqYC3ca+ArRiAgAABQQCAAA8ogA==
Date:   Thu, 8 Jun 2023 11:02:02 +0000
Message-ID: <0493414323dba8d5f59bca8cb7db53f300769dfa.camel@mediatek.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
         <20230608084727.74403-6-angelogioacchino.delregno@collabora.com>
         <c05be93415b3a04db2bc0f86010e14a286ecded2.camel@mediatek.com>
         <169f78a9-179d-deee-df98-d22e82604432@collabora.com>
In-Reply-To: <169f78a9-179d-deee-df98-d22e82604432@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB5627:EE_
x-ms-office365-filtering-correlation-id: 17189c7e-68f8-48fd-84b5-08db680fca24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVd9tFzdFwj6TCjTM6s9U/iemCq2bAKgUscm9AIWDBFAyKj4RSqU7RYYDOqjn0/aHHHxSn9ACxUXI90acnM5VbKAIqCYTz6VrBCeYGdm5JbgVc7KymB1lgjOvUsyBxHkCABU2TqIonGSVthUI9YDp6pDdpy9BLrmJFC4Bc8BypYiZ4BiB4E0DdoE10Qp+KqANb+j8baA5KXeeJcu8C2C8uuHTzqE59tjQYSP3iPtmROpJWLBNUaYIZZzK3PMHDpW9tInf8QMRuXnLUltT1iCb3+TmC1xX7ymhnK3S+pUUOn7DG5qBKsu2kffA8hEzYfLA9JRUmYRd60JwmqYtBKH6MNNrYWo076BEj98Hey6mkCC5gIXYK440n2d0MdnLcRtZxnit+sPn6SRsO2SvQxvAVYw8oJwiNoocbn6HbUqlG4Dcc1neyig+lCZ+j+gJvbNMH/xGjanOYEASOd02ZnkIOERVkutCp7gwuo50eED31+wlxvNsXRHu+Jebat50zyfPOnuYTUM4B57ch7kMJ3osmM7RynKXdHEaLnPVqP8yd/NhDWGgZPVpgxN3jLT99qWZ2CMWfTW7S+nl18dgp+nlMxA36d4xLyl8EDo9lpG6KA85G3zX/MTwBx24w6WIN/PqBHQb/j9IJyQ1MkVDUnUyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2616005)(478600001)(54906003)(41300700001)(83380400001)(86362001)(6512007)(26005)(6506007)(38070700005)(186003)(110136005)(5660300002)(8676002)(122000001)(2906002)(8936002)(7416002)(85182001)(36756003)(316002)(66946007)(38100700002)(6486002)(66446008)(4326008)(66476007)(64756008)(71200400001)(66556008)(91956017)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dldySkloQTZYS3VQTmY1YTJIVGpSMXEyZDBoSXBTNFYvcXJ2cWtvM2hCUitp?=
 =?utf-8?B?SGhMOEliSHdPdmtWaUlhV3lMa0p5LzBRUXZSbSsySGw3TXdwS2xhalF3Sk9o?=
 =?utf-8?B?T2kwaW9vR2tyWTBoTHdPUDlwS3pzaFNSNXdRcXJTbDVUeWMwK3FOS1l5OERZ?=
 =?utf-8?B?M3NENVNERWxVK0xrelFQOE1GTXdaTEpmSitxbStWeUs3Ni9WY0lZZ2x0eXZi?=
 =?utf-8?B?V3hlNTBwWmJFQXdQSm02REhLUjVpUUtaM0dvdDJLNXlWaEUzWjlsd2FwMEJ5?=
 =?utf-8?B?NzdRMS9zVm45RjhUUmtHRXEva2NiRHQ4eHFRSEkza1lCdVh4ZUd3Vm1NS1Vz?=
 =?utf-8?B?MEpYdEVLS2RBR1dYbWhEZ284WnBYRURWKzU3SDUyMFVvZUNSVWlGcEZaNjg4?=
 =?utf-8?B?cjRXMXZBTFAxY1dMOS9neVoyekpHV2ZMYjUwcnFDY1JOdkZMdWRoQko1QzVj?=
 =?utf-8?B?R0tMc3ZJNXA4SWdyNWJuck1hVmR1TG1pMjVFMXlBT05mUWd3cks5MjEvdGE5?=
 =?utf-8?B?Z2ZiM01NN25qV3hxQXd3MmxzdTFPcFg0eVU5MEhra0hxWjNKc214NWNBaDA3?=
 =?utf-8?B?UXRsR2NkMnhKZnhBU0Rhbi9oZnNKY0oyQWFjOC9QQmhLY0FjVnJ5dzFoK0V6?=
 =?utf-8?B?Q09XVURYYzdRNFExMUV5WVg4Y1pqcTlKWHBKUUc4RTJQeERSSE1jK1E0dlZk?=
 =?utf-8?B?clZXbFhQNHZJdG5haS9hVjBhUXhRRzNlV29zVW1zVFBXWVJrVWNFWTZpK3dS?=
 =?utf-8?B?ZEtIYWxmbzl5QXJ1eHhUSUNDdWpHazFKaTJWNEk1czZ2Tms0NDBaekpjOVcv?=
 =?utf-8?B?RllkTzBCSjN0eXVSM09IdzR6dHliZEwxRDcwNm96aFJ4cTF1ZEJpRU00eXY4?=
 =?utf-8?B?SGN4WEhGNDAxQ1kzcnViQTZLdHg0OW9vZWRXUVZmRkE2aVRRV1JXMjRjcXBX?=
 =?utf-8?B?RDFFWEJXcEVrYmFnanNncHJ2MGJaU0tIZlk5Z0l2RUdadlhJMXlmdTRDVytv?=
 =?utf-8?B?aDlnVnkyTVppMWRpNm5ScjFaWUsyaDdSblRYZ3B0UW9WcXlLZFJCY1dMaHhQ?=
 =?utf-8?B?QW1Yc1Q3UW00TCtuQjE3VFFjd2todXl2cGNYS3NjSGVoQUdlak14eGh0R0Ns?=
 =?utf-8?B?aCt1Rkp6cGdlRWxZVHZJWGFSdUx0U2hHKzlPVlpNMTN6TWlFZk8rdE8zSXZF?=
 =?utf-8?B?VThTc0ZuMWJPRDJsaUI0NHlBbHk3S3VDcFExMGFvYUpVTWdma3pTcStPaHdt?=
 =?utf-8?B?RUhCNThBWmtGV2NURUtGeUFmS3hUbUkycWdubndHelgxQTRsaUxOcllHQWF1?=
 =?utf-8?B?QkdjREs0bU56eE9yVzRFdHBIYVpQU2pZMHpmNHhlU3VtVm1mWDIweHRTMExz?=
 =?utf-8?B?L1dpNkVwb2VUWDhHRnZmU1NZNmFxSzdsREtlbGhVWGtMMEFVWlk4TjYyQ29a?=
 =?utf-8?B?ek5EczNHb3pUSnNxK0dBRFRiN3BnMERvQ09DZWZJUDVwTlk3L3NHMU9EZGZo?=
 =?utf-8?B?bXlNY0FBVVlZN24rUGpCb3JicXgxUkdFL2RWQVRxalY1bEpiRnBhcklaU0Rq?=
 =?utf-8?B?V1h6emF1N092Mm5qYjYzK0hIZzdRMTRwMlNCOU42VFFYc1J2VXJOaUFiMWhv?=
 =?utf-8?B?cTdwdXlmYmZ6aG1YVk9lTHRsYzNCaHF5TUtMeklUaThKcmpDcEJleW9ySytH?=
 =?utf-8?B?TmxEUnQzTXRUNjQwM21JbHE1YnVyUERMTzgzaWtqZmxySEJvcWpiVGZDb2NJ?=
 =?utf-8?B?b20vQzlFdHQzNFR5UVhSNG1hNEVsZ3FEQThpWFRDQlBRcmJRU2l1NlVJRDJk?=
 =?utf-8?B?VE1HYnRIRVREWFhQTFpUL3JEUFE0QU1MczNlVDFIRGJjeVZOUVpGcnl3YXRL?=
 =?utf-8?B?ekRhb2N0VW1qTFFQZnh1Q2s1MUg3Mm5OdVV4blJLd29JWmxzMkg2Y3Vid0ts?=
 =?utf-8?B?QmJZVnFpR3g5WFZxQUJOdUs2R3JpTXVjaHpqaWpvd3dHbWVUeHVHTkNpdEJP?=
 =?utf-8?B?azFjV3puRCsvYVJXUDcveWRvOHpnYzZmQTZBWVVUSW1nNi9ROU0zZGw2ZmZU?=
 =?utf-8?B?bGZDNEFzT3dFUEpqU0x2Vmg0Sm1rKzdNM0Rzdy9OVVRJR01ZeTN2a0hvUWtv?=
 =?utf-8?B?eTVEd2FQVXV5N0FJZWVOSmRhaml4TFhiZXd4dytoc2FOaE9SNVVodFV3TkRS?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9FF833D56E2B4498B7A1D07A54CB50D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17189c7e-68f8-48fd-84b5-08db680fca24
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 11:02:02.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84jXECR9FuvXeXknldX2wQTc8hnCazdz0h9dBtsfqAOXVmjU2lgMEzcedATtsHQE6XKUGa6jW7SLy0FmrBsY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5627
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDEyOjA3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwOC8wNi8yMyAxMjowMywgVHJldm9yIFd1
ICjlkLPmlofoia8pIGhhIHNjcml0dG86DQo+ID4gT24gVGh1LCAyMDIzLTA2LTA4IGF0IDEwOjQ3
ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiB3cm90ZToNCj4gPiANCj4gPj4g
ICBSZXBsYWNlIG9wZW4gY29kZWQgaW5zdGFuY2VzIG9mIEZJRUxEX0dFVCgpIHdpdGggaXQsIG1v
dmUNCj4gcmVnaXN0ZXINCj4gPj4gZGVmaW5pdGlvbnMgYXQgdGhlIHRvcCBvZiB0aGUgZmlsZSBh
bmQgYWxzbyByZXBsYWNlIG1hZ2ljIG51bWJlcnMNCj4gPj4gd2l0aCByZWdpc3RlciBkZWZpbml0
aW9ucy4NCj4gPj4NCj4gPj4gV2hpbGUgYXQgaXQsIGFsc28gY2hhbmdlIGEgcmVnbWFwX3VwZGF0
ZV9iaXRzKCkgY2FsbCB0bw0KPiA+PiByZWdtYXBfd3JpdGUoKQ0KPiA+PiBiZWNhdXNlIHRoZSB0
b3AgMjkgYml0cyBvZiBBVURfVE9QX0NGRyAoMzE6MykgYXJlIHJlc2VydmVkDQo+ICh1bnVzZWQp
Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+ID4+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPj4gLS0t
DQo+ID4+ICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMgfCAzMiAr
KysrKysrKysrKysrKy0tLQ0KPiAtLS0tDQo+ID4+IC0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPj4gYi9zb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1tdDYzNTkuYw0KPiA+PiBpbmRleCA1YjI2NjAx
Mzk0MjEuLmFjNjljMjNlMGRhMSAxMDA2NDQNCj4gPj4gLS0tIGEvc291bmQvc29jL21lZGlhdGVr
L210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPj4gKysrIGIvc291bmQvc29jL21lZGlhdGVrL210
ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPj4gQEAgLTYsNiArNiw3IEBADQo+ID4+ICAgICogQXV0
aG9yOiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4+ICAgICovDQo+ID4+
ICAgDQo+ID4+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPj4gICAjaW5jbHVkZSA8
bGludXgvaW5wdXQuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4+ICAg
I2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+PiBAQCAtMTksNiArMjAsMTUgQEANCj4g
Pj4gICAjaW5jbHVkZSAiLi4vY29tbW9uL210ay1hZmUtcGxhdGZvcm0tZHJpdmVyLmgiDQo+ID4+
ICAgI2luY2x1ZGUgIi4uL2NvbW1vbi9tdGstc291bmRjYXJkLWRyaXZlci5oIg0KPiA+PiAgIA0K
PiA+PiArI2RlZmluZSBDS1NZU19BVURfVE9QX0NGRzB4MDMyYw0KPiA+PiArICNkZWZpbmUgUkdf
VEVTVF9PTkJJVCgwKQ0KPiA+PiArICNkZWZpbmUgUkdfVEVTVF9UWVBFQklUKDIpDQo+ID4+ICsj
ZGVmaW5lIENLU1lTX0FVRF9UT1BfTU9OMHgwMzMwDQo+ID4+ICsgI2RlZmluZSBURVNUX01JU09f
Q09VTlRfMUdFTk1BU0soMywgMCkNCj4gPj4gKyAjZGVmaW5lIFRFU1RfTUlTT19DT1VOVF8yR0VO
TUFTSyg3LCA0KQ0KPiA+PiArICNkZWZpbmUgVEVTVF9NSVNPX0RPTkVfMUJJVCgyOCkNCj4gPj4g
KyAjZGVmaW5lIFRFU1RfTUlTT19ET05FXzJCSVQoMjkpDQo+ID4+ICsNCj4gPj4gICAjZGVmaW5l
IE5BVTg4MjVfSFNfUFJFU0VOVEJJVCgwKQ0KPiA+PiAgIA0KPiA+PiAgIC8qDQo+ID4+IEBAIC0y
NTEsOSArMjYxLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3DQo+ID4+
IG10ODE4OF9uYXU4ODI1X2NvbnRyb2xzW10gPSB7DQo+ID4+ICAgU09DX0RBUE1fUElOX1NXSVRD
SCgiSGVhZHBob25lIEphY2siKSwNCj4gPj4gICB9Ow0KPiA+PiAgIA0KPiA+PiAtI2RlZmluZSBD
S1NZU19BVURfVE9QX0NGRyAweDAzMmMNCj4gPj4gLSNkZWZpbmUgQ0tTWVNfQVVEX1RPUF9NT04g
MHgwMzMwDQo+ID4+IC0NCj4gPj4gICBzdGF0aWMgaW50IG10ODE4OF9tdDYzNTlfbXRrYWlmX2Nh
bGlicmF0aW9uKHN0cnVjdA0KPiA+PiBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpDQo+ID4+ICAg
ew0KPiA+PiAgIHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY21wbnRfYWZlID0NCj4gPj4gQEAg
LTI2NSwxMyArMjcyLDEzIEBAIHN0YXRpYyBpbnQNCj4gPj4gbXQ4MTg4X210NjM1OV9tdGthaWZf
Y2FsaWJyYXRpb24oc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkNCj4gPj4gICBzdHJ1
Y3QgbXRrYWlmX3BhcmFtICpwYXJhbTsNCj4gPj4gICBpbnQgY2hvc2VuX3BoYXNlXzEsIGNob3Nl
bl9waGFzZV8yOw0KPiA+PiAgIGludCBwcmV2X2N5Y2xlXzEsIHByZXZfY3ljbGVfMjsNCj4gPj4g
LWludCB0ZXN0X2RvbmVfMSwgdGVzdF9kb25lXzI7DQo+ID4+ICt1OCB0ZXN0X2RvbmVfMSwgdGVz
dF9kb25lXzI7DQo+ID4+ICAgaW50IGN5Y2xlXzEsIGN5Y2xlXzI7DQo+ID4+ICAgaW50IG10a2Fp
Zl9jaG9zZW5fcGhhc2VbTVQ4MTg4X01US0FJRl9NSVNPX05VTV07DQo+ID4+ICAgaW50IG10a2Fp
Zl9waGFzZV9jeWNsZVtNVDgxODhfTVRLQUlGX01JU09fTlVNXTsNCj4gPj4gICBpbnQgbXRrYWlm
X2NhbGlicmF0aW9uX251bV9waGFzZTsNCj4gPj4gICBib29sIG10a2FpZl9jYWxpYnJhdGlvbl9v
azsNCj4gPj4gLXVuc2lnbmVkIGludCBtb25pdG9yID0gMDsNCj4gPj4gK3UzMiBtb25pdG9yID0g
MDsNCj4gPj4gICBpbnQgY291bnRlcjsNCj4gPj4gICBpbnQgcGhhc2U7DQo+ID4+ICAgaW50IGk7
DQo+ID4+IEBAIC0zMDMsOCArMzEwLDcgQEAgc3RhdGljIGludA0KPiA+PiBtdDgxODhfbXQ2MzU5
X210a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkKQ0KPiA+
PiAgIG10NjM1OV9tdGthaWZfY2FsaWJyYXRpb25fZW5hYmxlKGNtcG50X2NvZGVjKTsNCj4gPj4g
ICANCj4gPj4gICAvKiBzZXQgdGVzdCB0eXBlIHRvIHN5bmNocm9uaXplciBwdWxzZSAqLw0KPiA+
PiAtcmVnbWFwX3VwZGF0ZV9iaXRzKGFmZV9wcml2LT50b3Bja2dlbiwNCj4gPj4gLSAgIENLU1lT
X0FVRF9UT1BfQ0ZHLCAweGZmZmYsIDB4NCk7DQo+ID4+ICtyZWdtYXBfd3JpdGUoYWZlX3ByaXYt
PnRvcGNrZ2VuLCBDS1NZU19BVURfVE9QX0NGRywNCj4gPj4gUkdfVEVTVF9UWVBFKTsNCj4gPiAN
Cj4gPiBIaSBBbmdlbG8sDQo+ID4gDQo+ID4gQmVjYXVzZSBDS1NZU19BVURfVE9QX0NGRyBpcyBh
IDMyYml0IHJlZ2lzdGVyLCBpdCBzaG91bGQgYmUgYmV0dGVyDQo+IHRvDQo+ID4gdXNlIHJlZ21h
cF9zZXRfYml0cyBpbnN0ZWFkLg0KPiA+IA0KPiA+IHJlZ21hcF9zZXRfYml0cyhhZmVfcHJpdi0+
dG9wY2tnZW4sIENLU1lTX0FVRF9UT1BfQ0ZHLA0KPiBSR19URVNUX1RZUEUpOw0KPiA+IA0KPiAN
Cj4gVGhlIHByZXZpb3VzIGNhbGwgdG8gcmVnbWFwX3VwZGF0ZV9iaXRzKCkgd2FzIHVuc2V0dGlu
ZyBSR19URVNUX09ODQo+IGFuZCBSRV9TV19SRVNFVA0KPiB3aGlsZSBzZXR0aW5nIFJHX1RFU1Rf
VFlQRTogdXNpbmcgcmVnbWFwX3dyaXRlKCkgZW5zdXJlcyB0aGF0IHdlIGRvDQo+IGV4YWN0bHkg
dGhlDQo+IHNhbWUsIHdpdGhvdXQgdGhlIG92ZXJoZWFkIG9mIHBlcmZvcm1pbmcgdGhlIGFkZGl0
aW9uYWwgcmVnaXN0ZXIgcmVhZA0KPiBhbmQgYml0DQo+IHN3YXBwaW5nIG9wZXJhdGlvbnMuDQo+
IA0KPiBVc2luZyB0aGUgcHJvcG9zZWQgcmVnbWFwX3NldF9iaXRzKCkgd291bGQgY2hhbmdlIHRo
ZSBiZWhhdmlvciBvZg0KPiB0aGlzIGZsb3csIHdoaWNoDQo+IG1heSByZXN1bHQgaW4gdW5leHBl
Y3RlZCBoYXJkd2FyZSBiZWhhdmlvciwgYXMgd2Ugd291bGRuJ3QgYmUNCj4gdW5zZXR0aW5nIHRo
ZQ0KPiBwcmV2aW91c2x5IG1lbnRpb25lZCB0d28gYml0cy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFu
Z2Vsbw0KDQoNCkl0J3MgdW5jbGVhciB3aHkgdGhlIG9yaWdpbmFsIGF1dGhvciBjaG9zZSBhIG1h
c2sgdmFsdWUgb2YgMHhmZmZmLCBidXQNCnJlbWFwX3dyaXRlKCkgYWxzbyBjbGVhcnMgdGhlIGhp
Z2hlciAxNiBiaXRzIHdoaWNoIGRpZmZlcnMgZnJvbSB0aGUNCm9yaWdpbmFsIGxvZ2ljLg0KDQpU
aGUgY29tbWVudCBmb3IgdGhhdCBsaW5lIHN0YXRlcyAnc2V0IHRlc3QgdHlwZSB0byBzeW5jaHJv
bml6ZXIgcHVsc2UnLA0Kc28gSSBzdWdnZXN0IHVwZGF0aW5nIG9ubHkgQklUMiBoZXJlLiBBZGRp
dGlvbmFsbHksIEkgY2hlY2tlZCBkYXRhc2hlZXQNCmZvciBvdGhlciB0d28gYml0cywgd2hpY2gg
aGF2ZSBkZWZhdWx0IHZhbHVlcyBvZiAwLg0KDQpIb3dldmVyLCBJIGNhbWUgYWNyb3NzIGFuIGlu
dGVybmFsIGNvZGViYXNlIHRoYXQgdXNlZCByZWdtYXBfd3JpdGUoKSwNCnNvIGl0IHNob3VsZCBi
ZSBhIHNhZmUgaW1wbGVtZW50YXRpb24uIElmIHlvdSB0aGluayByZWdtYXBfd3JpdGUoKSBpcw0K
YmV0dGVyLCBpdCdzIG9rIHdpdGggbWUuDQoNClRoYW5rcywNClRyZXZvcg0KDQo+IA0KPiA+IFRo
YW5rcywNCj4gPiBUcmV2b3INCj4gPiANCj4gPiANCj4gPj4gICAgbXRrYWlmX2NhbGlicmF0aW9u
X251bV9waGFzZSA9IDQyOy8qIG10NjM1OTogMCB+IDQyICovDQo+ID4+ICAgbXRrYWlmX2NhbGli
cmF0aW9uX29rID0gdHJ1ZTsNCj4gPj4gICANCj4gPj4gQEAgLTMxNCw3ICszMjAsNyBAQCBzdGF0
aWMgaW50DQo+ID4+IG10ODE4OF9tdDYzNTlfbXRrYWlmX2NhbGlicmF0aW9uKHN0cnVjdCBzbmRf
c29jX3BjbV9ydW50aW1lICpydGQpDQo+ID4+ICAgbXQ2MzU5X3NldF9tdGthaWZfY2FsaWJyYXRp
b25fcGhhc2UoY21wbnRfY29kZWMsDQo+ID4+ICAgICAgIHBoYXNlLCBwaGFzZSwNCj4gPj4gcGhh
c2UpOw0KPiA+PiAgIA0KPiA+PiAtcmVnbWFwX3NldF9iaXRzKGFmZV9wcml2LT50b3Bja2dlbiwg
Q0tTWVNfQVVEX1RPUF9DRkcsDQo+ID4+IDB4MSk7DQo+ID4+ICtyZWdtYXBfc2V0X2JpdHMoYWZl
X3ByaXYtPnRvcGNrZ2VuLCBDS1NZU19BVURfVE9QX0NGRywNCj4gPj4gUkdfVEVTVF9PTik7DQo+
ID4+ICAgDQo+ID4+ICAgdGVzdF9kb25lXzEgPSAwOw0KPiA+PiAgIHRlc3RfZG9uZV8yID0gMDsN
Cj4gPj4gQEAgLTMyNiwxNCArMzMyLDE0IEBAIHN0YXRpYyBpbnQNCj4gPj4gbXQ4MTg4X210NjM1
OV9tdGthaWZfY2FsaWJyYXRpb24oc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkNCj4g
Pj4gICB3aGlsZSAoISh0ZXN0X2RvbmVfMSAmIHRlc3RfZG9uZV8yKSkgew0KPiA+PiAgIHJlZ21h
cF9yZWFkKGFmZV9wcml2LT50b3Bja2dlbiwNCj4gPj4gICAgICAgQ0tTWVNfQVVEX1RPUF9NT04s
ICZtb25pdG9yKTsNCj4gPj4gLXRlc3RfZG9uZV8xID0gKG1vbml0b3IgPj4gMjgpICYgMHgxOw0K
PiA+PiAtdGVzdF9kb25lXzIgPSAobW9uaXRvciA+PiAyOSkgJiAweDE7DQo+ID4+ICt0ZXN0X2Rv
bmVfMSA9IEZJRUxEX0dFVChURVNUX01JU09fRE9ORV8xLA0KPiA+PiBtb25pdG9yKTsNCj4gPj4g
K3Rlc3RfZG9uZV8yID0gRklFTERfR0VUKFRFU1RfTUlTT19ET05FXzIsDQo+ID4+IG1vbml0b3Ip
Ow0KPiA+PiAgIA0KPiA+PiAgIGlmICh0ZXN0X2RvbmVfMSA9PSAxKQ0KPiA+PiAtY3ljbGVfMSA9
IG1vbml0b3IgJiAweGY7DQo+ID4+ICtjeWNsZV8xID0gRklFTERfR0VUKFRFU1RfTUlTT19DT1VO
VF8xLA0KPiA+PiBtb25pdG9yKTsNCj4gPj4gICANCj4gPj4gICBpZiAodGVzdF9kb25lXzIgPT0g
MSkNCj4gPj4gLWN5Y2xlXzIgPSAobW9uaXRvciA+PiA0KSAmIDB4ZjsNCj4gPj4gK2N5Y2xlXzIg
PSBGSUVMRF9HRVQoVEVTVF9NSVNPX0NPVU5UXzIsDQo+ID4+IG1vbml0b3IpOw0KPiA+PiAgIA0K
PiA+PiAgIC8qIGhhbmRsZSBpZiBuZXZlciB0ZXN0IGRvbmUgKi8NCj4gPj4gICBpZiAoKytjb3Vu
dGVyID4gMTAwMDApIHsNCj4gPj4gQEAgLTM2MSw3ICszNjcsNyBAQCBzdGF0aWMgaW50DQo+ID4+
IG10ODE4OF9tdDYzNTlfbXRrYWlmX2NhbGlicmF0aW9uKHN0cnVjdCBzbmRfc29jX3BjbV9ydW50
aW1lICpydGQpDQo+ID4+ICAgbXRrYWlmX3BoYXNlX2N5Y2xlW01UODE4OF9NVEtBSUZfTUlTT18x
XSA9DQo+ID4+IHByZXZfY3ljbGVfMjsNCj4gPj4gICB9DQo+ID4+ICAgDQo+ID4+IC1yZWdtYXBf
Y2xlYXJfYml0cyhhZmVfcHJpdi0+dG9wY2tnZW4sDQo+ID4+IENLU1lTX0FVRF9UT1BfQ0ZHLCAw
eDEpOw0KPiA+PiArcmVnbWFwX2NsZWFyX2JpdHMoYWZlX3ByaXYtPnRvcGNrZ2VuLA0KPiA+PiBD
S1NZU19BVURfVE9QX0NGRywgUkdfVEVTVF9PTik7DQo+ID4+ICAgDQo+ID4+ICAgaWYgKG10a2Fp
Zl9jaG9zZW5fcGhhc2VbTVQ4MTg4X01US0FJRl9NSVNPXzBdID49IDAgJiYNCj4gPj4gICAgICAg
bXRrYWlmX2Nob3Nlbl9waGFzZVtNVDgxODhfTVRLQUlGX01JU09fMV0gPj0gMCkNCj4gPj4gLS0g
DQo+ID4+IDIuNDAuMQ0KPiANCj4gDQo+IA0K
