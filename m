Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B238A72AFFD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 04:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjFKCJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjFKCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 22:09:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF43594;
        Sat, 10 Jun 2023 19:09:31 -0700 (PDT)
X-UUID: fde569d207fc11ee9cb5633481061a41-20230611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XPgQ9eUcJMPTUAj8kc60Wg710K79n5iBz9EsKXmox5s=;
        b=XTXlKeHB2lcDWWwZvK6bXLVhISp/ten59t1y0vvtgDRRVNL6L1SOPqqLSJ29l7SnuiEorV01PerKuxfFE4jZtB00G9QjV2y0Ub9WeiSRoceF1+EEuyYGy+uIGwRSPHFcmn2+5ENRNUMTjq8YUPhbL7OyIbu7iEkw4WCGogbw/TE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:eb989762-8ea8-4646-aa1a-1b0cd35602d0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:b795073e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fde569d207fc11ee9cb5633481061a41-20230611
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 772391964; Sun, 11 Jun 2023 10:09:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 11 Jun 2023 10:09:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 11 Jun 2023 10:09:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlsgQdIvaHEMK0RLyClzT7h1Deg5fWL/q4poEgmbnNiKsyYDgFVBeE26Xz9KVyPlyTrfZdJgHHAgB6XHc2Xql0hY8Z9bC/zptuvpXHFUTPWCyiJL1JkFpFo2t0E/SPbnSSThTOZ9USETXzTPmMtohabEj2J/hgyaNhllHsAX/FUL9oa6axlwa78pYRA/EVjYklBljdXs/qu6MQQinsPfs/iZ+RDz7bUxYq85vArTzoYTGwItA6YK7t8EOCNeEPTeUJiPPQ/KWIAAzKrjF1K/oBXCbOhKm5SLBbiKSVzNvjUVr55CvzaMGvEPysuSkox4cCl1Ebl/F3CmjbZwmK8HRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPgQ9eUcJMPTUAj8kc60Wg710K79n5iBz9EsKXmox5s=;
 b=Jnf7+c4t+161Pdl0TniL9rg2E048ffSsv5YEs0AYE6ob2DTnZ+ZkV6sKCQr9uXWObRWYkXxE+y/u29+dsEjHT9jkN9wXVJdJdzWSWY2tnouAvE3XPb7vneSjUeu9SgdtwnQsabVA2iizcTd2o5nIKJlnGHkkp2BfiiUzOJE9BgAILBiCBAZVgaazAS+tdxNdPgLoeZziblsQBCC9mqSHha6N1KqOMWezgt5IA+wbx38lQQvyZozVYO958OxzxnNYR5YUk5ona/zVMVQXT6m6qKoa+irRsg7Tk5K1Y9xUz/deJ8O9c2hBID6bAoJhGeBbmXvVQJmnEracItmz1e1p4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPgQ9eUcJMPTUAj8kc60Wg710K79n5iBz9EsKXmox5s=;
 b=PBesTZ/Br+sNPpiQpywnIvtW93ELtkfJlxNc0Lg2O4IlIRRwdREWNtqR+KDpaCt+9+agURya3Wl8y96YQfIVteuSEAkRzw8j6eNNWAqcTPOYyc4TSUbW5Ygq5ue7QOdjBjCuOVSUM9VoXJsFbZ3RwZLU/7UPr0WdJXB8QcPHkEc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SEYPR03MB7967.apcprd03.prod.outlook.com (2603:1096:101:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sun, 11 Jun
 2023 02:09:23 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%4]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 02:09:22 +0000
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
Thread-Index: AQHZmR0jmQkpnXgRrkqIvSc9R6kUVa+AImQAgABg2ICAAF/4AIAAD38AgAATpoCAA9rlgA==
Date:   Sun, 11 Jun 2023 02:09:22 +0000
Message-ID: <7a15e0e9b290ddac8ccb1b4bc77a85d783ce5828.camel@mediatek.com>
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
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SEYPR03MB7967:EE_
x-ms-office365-filtering-correlation-id: 2afac375-30f8-46de-4b23-08db6a20dfae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM3tR4yGKVPuRXxCpHVceU6pa2RfN3j/Rdq8Q8d9hXuqBcA3uIw7I7H+3d02Ny5LvIoOmH4Ch5DLE49rCMvI9EmQtwxk681wlVbRh7CBMe5/D1IhUZd2+FntO2xz13VeQi0EtSr9ykBb5BCC8GCBoFnHHv+tMV7OrlpDS+prF8hDuNWJ/wMDIIr7wLhaod+TS8GwnXAuFNeySpyDp1SeeUP++blzK4MvxEiUVg4RfSrz4NiOpLWuEh4shXpL+HIZxtLAjOrZaIiSNx66lCjHuYQ0leuJ6RXkhon+D53KTWIscuP1k2y0EASdQY6FkCnXyZ2tK9CTfYoU423jvwVCJSoMISflSxw7OvxCXnyygrX3Al/QdI1j6CV8RMe6as+ZAMtIILMqxgVm5elWFXnBqI6z4C5Wuz30PnJYbukXGXuNobG8kKIKHNDP+i5AvMWKPbabHD7BMN8jr5ZIfBMbRKIRcDTa62o001f3FzMGPWi9sOFJPKCSnUuv6+wfUWMZqZYUq+q0VlKBhRw8qcubp/fVSnY06rvS3QgeCvdCS7BKKTNHY6XorfbAUiTSPA7E5Yjat27ERtaazNln1F929L7ECnk7DtdN9tXb9ZNiGYNlMZBtG5Xu6xU0ieVLZLn0o9HsTaDlN5TXTvo5Xnom7c2TSYV8I2iDsdvaLkNAOvltWm3cg+0dZK6sVxDz7/hL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(366004)(396003)(346002)(451199021)(66574015)(83380400001)(66556008)(122000001)(4326008)(36756003)(85182001)(66476007)(38070700005)(41300700001)(38100700002)(316002)(6486002)(6506007)(26005)(71200400001)(6512007)(66946007)(66446008)(64756008)(76116006)(91956017)(2906002)(86362001)(7416002)(5660300002)(8936002)(8676002)(2616005)(54906003)(110136005)(478600001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vlp6aGdUUXdkZ1F3MWtVNjYxc1RPeE1kVEd3ckNlQjRZcDZYVisxRzZpNFFm?=
 =?utf-8?B?TnBMdCtzNTVTK3FVOUhxQjdpWWwrUlJBamYwRjVwR1VnRUpUMWtyZUFYek1s?=
 =?utf-8?B?anh2WUdqWUhvL011ZjZlc1hlZUxXVTFSVW5udnZpbXRxUnN6bWpZeFJLcHNH?=
 =?utf-8?B?L0RwM1VsRnoxNU0rSFdTcG5tZE9pTWtKdVBrc2VNYmdBSnJ3UXNnQlFIcWxB?=
 =?utf-8?B?cE9waXBqVFFZaC9tVUl0NmdPSWU1azBhbGRwMDF5UVlnK0dJMEhucCtjcUJE?=
 =?utf-8?B?MDBNdDBSTS9zZ3dKU01IRldqVGNjTjRLclg1ZzZRT2VHZy8xVE5pTXRuR3N3?=
 =?utf-8?B?WHp1QVVYcUF4TVBWMXRGelZsWmpVaUtXMk16WlNGRk9WRWVON1NBZndubm5m?=
 =?utf-8?B?emdBczBNZXhGZUM1U3B2VHAvbzdWNWhjN3JURVhhb28wN0htdm13Nk1DVC95?=
 =?utf-8?B?SDgyRFJtTUFIWDJ6Q3k4RnpIaWVXN3NkUVliczdYU1FkRmRZWitJbVJHT3RP?=
 =?utf-8?B?Ymd5ZW1SdEgySWVNcHIxLzZRYUZ5SzU3YzBJRGZxRzRpODUxMXRoSUdFQThp?=
 =?utf-8?B?aHZIWXdoZUtKL3lTWHlGdUZFcjBBS1VTbkU1NkRDalBVMXUrVSswWnEySm9Z?=
 =?utf-8?B?dmNsMDhGb3hPV1NURTk4cWVYRFZpMDZNeFhveEVpYTV2aGY5YjZKdTliSmRT?=
 =?utf-8?B?cTRkUytyaWRTd0x6SlhKdi9GUHlySWNMQXdSeVNvZ0NGZWhrUmpWbEpGeVBU?=
 =?utf-8?B?ekZFeTBHQi9iNGVPQ3FQRVBJNUtmUUVEOGxqN05RM3BHUnVqTSt4SG4xRHlZ?=
 =?utf-8?B?MzhZNU1ZS0ZIQXh2N1lLQ0o3UCsweldxTFpuVkRSelNwaGE4eUhRc0F0MXF5?=
 =?utf-8?B?Yk5XZTFDNDZZSWQyY2NsZ0dnVC84eHliWm0xV3R2K0xLY1ZVdUFFS1F1QTRT?=
 =?utf-8?B?QW9uZ3RpY0MramVmaG9jN1RGNDJpYmprWWNMWXk2VWllK2FkclZWSUJmemRi?=
 =?utf-8?B?bk92ZnpBNCtiQnRRQkg4NFh3K1lSeXc0NFpMQ0E4cStQR2ZCT0NmRXNWTmdo?=
 =?utf-8?B?TmY4RWpIL0dKcFNVQnkvM2FWTUVZZWxBTzVobk13UUY5c2xoZERwK2lGODg5?=
 =?utf-8?B?SWc1VVVxaWxEbVNRb0tCYVhGUmZCNzh1Y2VKRWpMQ09raS95cU9EZTFDNEFW?=
 =?utf-8?B?SW5zU25TZGRJMlBPZXpKNTlyTmF5azhxeTZsNVIxaDNBOGpDWGNqVVB1NEdK?=
 =?utf-8?B?SVFrczBmWmdNQU1YNVdTOFFuODNzNXdkbU9Tcmk1T0lNWWFiMk9XZjJOYklt?=
 =?utf-8?B?MnZtZFhjQXU2bDJqSG9yR0lTSCtRcTRKdmhXbmdqcXV2Vm5xVCt4U1Y5QWZW?=
 =?utf-8?B?R0VlZVNPck0zdXJyeEVmalQzUjJuaHdndUQ3N2FtMHhwM2xmN0tjcHcxWVkr?=
 =?utf-8?B?aDhJN1dxcGhKOFNnN1ptRlBWYXRSYitCc2ZjdEM2ZjJPSjV3Q0RCUkExNXpI?=
 =?utf-8?B?aUVZWng5ellEZHpzcG5seFVHVVFMYm5hVzRYMWNVWlRpa3lYbGw5N2N3TUFa?=
 =?utf-8?B?UG91WndLUXNUSGpabHRITE16T0NDRFU3cUNXeWprWHpmZW1CZzFHeFhrSENU?=
 =?utf-8?B?dlBBWktKVnBEeWxreVZKazVNamlVMmJRU0NXS3lHMGY5bXJHOXRIRE5kcytq?=
 =?utf-8?B?azQ5eWdCdUpQMjFZOTFyd0ZBSklKVUlhWVRudVZVaVEvRjd2SSs2c2hwRk93?=
 =?utf-8?B?di9ZQldnRnZhTE4wTGpRM1JaRXVGd1VJSVhpblJuaitwKzlMZk5MZFRld08x?=
 =?utf-8?B?RWtNK3duUk1IN2xPdFF6c3UvbEo1QWhDSjljOEVBYUlhZWV6VUw5L0lmdkUv?=
 =?utf-8?B?cVhXT0lSUlBPQWlCNzBZR3hlMVk2MWZYQ0NsdVJHRi9pK0E2UExSVjFtbCs0?=
 =?utf-8?B?VXZlTlE5dVhqakxmZlZWMmpBVlhtSTl5UE9mVktKdFg3TG1QbDdCSmFJblZ2?=
 =?utf-8?B?VjNWdWg0S08ydngzYXZLOTVUeEdxN0laMCsyMTZBUVBMeGxmZkdVanBHUm5n?=
 =?utf-8?B?Z0RWVERSNXB0THEvNVZuejlXY3JzemVCYU5qb1BZb0lqbk9uZ1RCWS80V3ZW?=
 =?utf-8?B?ZGI5WEViQit3U3BJWGRYWUlxQndJVUJ1SVcyaE5acVZZdk9jTE0zcjJkVzBZ?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6257AEB1CD7D4144B94FC8DDF867A653@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afac375-30f8-46de-4b23-08db6a20dfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 02:09:22.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tu48Akgna5Ty8U2CUR8P36A8oShjlTSZV6qR2C2WFebzHGY2ks2HKBhMz7tnCDxqi5KHilOTRR2EcqZ9W08kaDPTvy7kYMkoLaDVKmYgeYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7967
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

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gVGh1LCAyMDIzLTA2
LTA4IGF0IDExOjE3IC0wNDAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOg0KPiAgCSANCj4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gIExlIGpldWRpIDA4IGp1aW4gMjAyMyDDoCAxNjowNiArMDIwMCwgQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8gYQ0KPiDDqWNyaXQgOg0KPiA+IElsIDA4LzA2LzIzIDE1OjExLCBOaWNvbGFz
IER1ZnJlc25lIGhhIHNjcml0dG86DQo+ID4gPiBMZSBqZXVkaSAwOCBqdWluIDIwMjMgw6AgMDc6
MjcgKzAwMDAsIFl1bmZlaSBEb25nICjokaPkupHpo54pIGEgw6ljcml0IDoNCj4gPiA+ID4gSGkg
Tmljb2xhcywNCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+ID4g
PiA+IE9uIFdlZCwgMjAyMy0wNi0wNyBhdCAyMTo0MSAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3
cm90ZToNCj4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+IGF0dGFjaG1lbnRzIHVudGlsDQo+ID4gPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiAg
IEhpIFl1bmZlaSwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMZSBtZXJjcmVkaSAwNyBqdWluIDIw
MjMgw6AgMTY6NDggKzA4MDAsIFl1bmZlaSBEb25nIGEgw6ljcml0IDoNCj4gPiA+ID4gPiA+ICdt
dGtfdmNvZGVjX2RlYnVnJyBhbmQgJ210a192Y29kZWNfZXJyJyBkZXBlbmRzIG9uDQo+ICdtdGtf
dmNvZGVjX2N0eCcNCj4gPiA+ID4gPiA+IHRvIGdldCB0aGUgaW5kZXggb2YgZWFjaCBpbnN0YW5j
ZSwgdXNpbmcgdGhlIGluZGV4IGRpcmVjdGx5DQo+IGluc3RlYWQNCj4gPiA+ID4gPiA+IG9mIHdp
dGggJ210a192Y29kZWNfY3R4Jy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ID4gICAuLi4vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5o
ICAgICAgICAgfCAgMjYgKystDQo+ID4gPiA+ID4gPiAgIC4uLi92Y29kZWMvdmRlYy92ZGVjX2F2
MV9yZXFfbGF0X2lmLmMgICAgICAgICB8IDEwNQ0KPiArKysrKysrLS0tLS0NCj4gPiA+ID4gPiA+
ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2NF9pZi5jICAgICAgIHwgIDYyICsr
KystDQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gy
NjRfcmVxX2lmLmMgICB8ICAzOSArKystLQ0KPiA+ID4gPiA+ID4gICAuLi4vdmNvZGVjL3ZkZWMv
dmRlY19oMjY0X3JlcV9tdWx0aV9pZi5jICAgICAgfCAgODANCj4gKysrKystLS0tDQo+ID4gPiA+
ID4gPiAgIC4uLi92Y29kZWMvdmRlYy92ZGVjX2hldmNfcmVxX211bHRpX2lmLmMgICAgICB8ICA2
NyArKysrLQ0KPiAtLS0NCj4gPiA+ID4gPiA+ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3Zk
ZWNfdnA4X2lmLmMgICAgICAgIHwgIDU0ICsrKystDQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4uLi9t
ZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3ZwOF9yZXFfaWYuYyAgICB8ICA0NiArKysNCj4gLS0t
DQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3ZwOV9pZi5jICAg
ICAgICB8IDE1Mg0KPiArKysrKysrKysrLS0NCj4gPiA+ID4gPiAtLS0tLS0NCj4gPiA+ID4gPiA+
ICAgLi4uL3Zjb2RlYy92ZGVjL3ZkZWNfdnA5X3JlcV9sYXRfaWYuYyAgICAgICAgIHwgIDg0DQo+
ICsrKysrKy0tLS0NCj4gPiA+ID4gPiA+ICAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92
ZGVjX3ZwdV9pZi5jICAgIHwgIDU5ICsrKystDQo+IC0tDQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRp
YXRlay92Y29kZWMvdmVuYy92ZW5jX2gyNjRfaWYuYyAgICAgICB8ICA4Ng0KPiArKysrKy0tLS0t
DQo+ID4gPiA+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvdmVuYy92ZW5jX3ZwOF9pZi5jICAg
ICAgICB8ICA0OCArKysNCj4gLS0tDQo+ID4gPiA+ID4gPiAgIC4uLi9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvdmVuY192cHVfaWYuYyAgICB8ICA2NCArKysrLQ0KPiAtLS0NCj4gPiA+ID4gPiA+
ICAgMTQgZmlsZXMgY2hhbmdlZCwgNTY1IGluc2VydGlvbnMoKyksIDQwNyBkZWxldGlvbnMoLSkN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY191dGlsLmgNCj4gPiA+
ID4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNf
dXRpbC5oDQo+ID4gPiA+ID4gPiBpbmRleCBlY2IwYmRmM2E0ZjQuLmRkYzEyYzNlMjk4MyAxMDA2
NDQNCj4gPiA+ID4gPiA+IC0tLQ0KPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL210a192Y29kZWNfdXRpbC5oDQo+ID4gPiA+ID4gPiArKysNCj4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwuaA0KPiA+ID4gPiA+
ID4gQEAgLTMxLDkgKzMxLDggQEAgc3RydWN0IG10a192Y29kZWNfZGV2Ow0KPiA+ID4gPiA+ID4g
ICAjZGVmaW5lIG10a192NGwyX2VycihmbXQsIGFyZ3MuLi4pICAgICAgICAgICAgICAgIFwNCj4g
PiA+ID4gPiA+ICAgcHJfZXJyKCJbTVRLX1Y0TDJdW0VSUk9SXSAiIGZtdCAiXG4iLCAjI2FyZ3Mp
DQo+ID4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19lcnIoaCwg
Zm10LCBhcmdzLi4uKVwNCj4gPiA+ID4gPiA+IC1wcl9lcnIoIltNVEtfVkNPREVDXVtFUlJPUl1b
JWRdOiAiIGZtdCAiXG4iLFwNCj4gPiA+ID4gPiA+IC0gICAgICAgKChzdHJ1Y3QgbXRrX3Zjb2Rl
Y19jdHggKikoaCktPmN0eCktPmlkLCAjI2FyZ3MpDQo+ID4gPiA+ID4gPiArI2RlZmluZSBtdGtf
dmNvZGVjX2VycihwbGF0X2RldiwgaW5zdF9pZCwgZm10LA0KPiA+ID4gPiA+IGFyZ3MuLi4pICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gPiA+ID4gK2Rldl9lcnIoJihw
bGF0X2RldiktPmRldiwgIltNVEtfVkNPREVDXVtFUlJPUl1bJWRdOiAiIGZtdA0KPiAiXG4iLA0K
PiA+ID4gPiA+IGluc3RfaWQsICMjYXJncykNCj4gPiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gPiAg
ICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykNCj4gPiA+ID4gPiA+ICAgZXh0ZXJuIGludCBt
dGtfdjRsMl9kYmdfbGV2ZWw7DQo+ID4gPiA+ID4gPiBAQCAtNDYsMjcgKzQ1LDI0IEBAIGV4dGVy
biBpbnQgbXRrX3Zjb2RlY19kYmc7DQo+ID4gPiA+ID4gPiAgICBfX2Z1bmNfXywgX19MSU5FX18s
ICMjYXJncyk7ICAgICAgICBcDQo+ID4gPiA+ID4gPiAgIH0gd2hpbGUgKDApDQo+ID4gPiA+ID4g
PiAgIA0KPiA+ID4gPiA+ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19kZWJ1ZyhoLCBmbXQsDQo+IGFy
Z3MuLi4pICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+IC1kbyB7ICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+IC1pZiAobXRrX3Zjb2RlY19kYmcpICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+IC1kZXZfZGJnKCYoKChzdHJ1Y3QgbXRrX3Zjb2Rl
Y19jdHggKikoaCktPmN0eCktPmRldi0NCj4gPnBsYXRfZGV2LQ0KPiA+ID4gPiA+ID4gZGV2KSwg
ICBcDQo+ID4gPiA+ID4gPiAtIltNVEtfVkNPREVDXVslZF06ICVzLCAlZCAiIGZtdA0KPiAiXG4i
LCAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gPiA+ID4gPiAtKChzdHJ1Y3QgbXRrX3Zj
b2RlY19jdHggKikoaCktPmN0eCktDQo+ID5pZCwgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+
ID4gPiA+ID4gLV9fZnVuY19fLCBfX0xJTkVfXywNCj4gIyNhcmdzKTsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gPiA+ID4gKyNkZWZpbmUgbXRrX3Zjb2RlY19kZWJ1
ZyhwbGF0X2RldiwgaW5zdF9pZCwgZm10LA0KPiA+ID4gPiA+IGFyZ3MuLi4pICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gPiA+ICtkbw0KPiA+ID4gPiA+IHsNCj4gPiA+
ID4gPiAgICAgICAgICBcDQo+ID4gPiA+ID4gPiAraWYNCj4gPiA+ID4gPiAobXRrX3Zjb2RlY19k
YmcpDQo+ID4gPiA+ID4gXA0KPiA+ID4gPiA+ID4gK2Rldl9kYmcoJihwbGF0X2RldiktPmRldiwg
IltNVEtfVkNPREVDXVslZF06ICVzLCAlZCAiIGZtdA0KPiAiXG4iLCBcDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQXQgbGVhc3QgaW4gdGhpcyBwYXRjaCwgeW91IHN5c3RlbWF0aWNhbGx5IHBhc3Mg
cGxhdF9kZXYgYXMNCj4gPiA+ID4gPiA8c29tZXRoaW5nPi0+Y3R4LT5kZXYtPnBsYXRfZGV2LCB3
aGljaCBpcyBxdWl0ZSBsb25nIGFuZA0KPiB2ZXJib3NlLCBhbnkNCj4gPiA+ID4gPiByZWFzb24g
d2UNCj4gPiA+ID4gPiBjYW4ndCBqdXN0IHBhc3MgdGhhdCA8c29tZXRoaW5nPiBoZXJlID8gV2Ug
Y2FuIGZvbGxvdyB0aGUNCj4gc2FtZQ0KPiA+ID4gPiA+IHN0cnVjdHVyZSBwYXRoDQo+ID4gPiA+
ID4gZm9yIGJvdGggZW5jb2Rlci9kZWNvZGVyID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+IEluIG9yZGVyIHRvIHNlcGFyYXRlIGVuY29kZSBhbmQgZGVjb2RlciwgbmVlZCB0byBkZWZp
bmUgdHdvDQo+IGRpZmZlcmVudA0KPiA+ID4gPiBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4IGFu
ZCBzdHJ1Y3QgbXRrX3Zjb2RlY19lbmNfY3R4Lg0KPiA+ID4gPiANCj4gPiA+ID4gc3RydWN0IG10
a192Y29kZWNfY3R4IHdvbid0IGJlIHVzZWQgYWdhaW4sIG5lZWQgdG8gdXNlIHBsYXRmb3JtDQo+
IGRldmljZQ0KPiA+ID4gPiB0byBwcmludCBkZXZfZGJnIGFuZCBkZXZfZXJyLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gZW5jb2RlciBhbmQgZGVjb2RlciB1c2luZyB0aGUgc2FtZSBpbnRlcmZhY2UgdG8g
cHJpbnQgbG9nDQo+IG1lc3NhZ2UuDQo+ID4gPiANCj4gPiA+IEp1c3QgYSByZW1pbmRlciwgSSdt
IGp1c3QgbWFraW5nIHN1Z2dlc3Rpb25zLCB0aGVyZSBpcyBubyBzdHJpY3QNCj4gYWN0aW9uIHJl
cXVpcmVkDQo+ID4gPiBoZXJlIG90aGVyIHRoZW4gYSBkaXNjdXNzaW9uIHRvIHRyeSBhbmQgbWFr
ZSB0aGUgbG9nZ2luZyBhIGJpdA0KPiBtb3JlIGxpZ2h0Lg0KPiA+ID4gDQo+ID4gPiBNeSBwb2lu
dHMgd2FzIHRoYXQgQyBtYWNyb3MgZG9uJ3QgY2FyZSBhYm91dCB0eXBlcywgc28gaWYgeW91DQo+
IGtlZXAgdGhlIHBhdGggdG8NCj4gPiA+IHRoZSBwbGF0Zm9ybSBkZXZpY2UgdGhlIHNhbWUgKGN0
eC0+ZGV2LT5wbGF0X2RldiksIHlvdSBjb3VsZCBqdXN0DQo+IHBhc3MgdGhlIGN0eA0KPiA+ID4g
YXMgYXJndW1lbnQuIFdoYXQgSSBkb24ndCBrbm93IHRob3VnaCBteXNlbGYsIGlzIGlmIHRoaXMg
aXMNCj4gYWN0dWFsbHkgZmVhc2libGUgaW4NCj4gPiA+IGFsbCBjb2RlIHBhdGgsIGJ1dCBjb25z
aWRlcmluZyB5b3UgaGFkIGFjY2VzcyB0byB0aGUgaW5zdGFuY2UNCj4gcHJldmlvdXNseSwgSQ0K
PiA+ID4gdGhvdWdodCBpdCBzaG91bGQuDQo+ID4gPiANCj4gPiANCj4gPiBPbmUgbWFjcm8gdXNl
ZCB0byBhY2Nlc3MgdHdvIGRpZmZlcmVudCBzdHJ1Y3R1cmVzPw0KPiA+IA0KPiA+IFBsZWFzZSwg
bm8uDQo+IA0KPiBJdHMgdXAgdG8geW91LiBJIGRvIHRoaW5rIHRoaXMgaXMgYW4gZW1wdHkgc3Rh
dGVtZW50LiBTdGlsbCBiZWxpZXZlDQo+IHdlIGF2b2lkDQo+IHRoaXMgY29kZSAiZGV0ZXJpb3Jh
dGlvbiIuIE9uZSBjYW4gYWx3YXlzIGJlIGNyZWF0aXZlIHRvIHdvcmthcm91bmQNCj4geW91cg0K
PiBjb25jZXJucy4NCj4gDQo+IHN0cnVjdCBiYXNlX2N0eCB7DQo+IHN0cnVjdCBkZXYgZGV2Ow0K
PiB9DQo+IA0KPiBzdHJ1Y3QgZW5jX2N0eCB7DQo+IHN0cnVjdCBiYXNlX2N0eDsNCj4gLi4uDQo+
IH0NCj4gDQo+IHN0cnVjdCBzcmNfY3R4IHsNCj4gLi4uDQo+IH0NCj4gDQo+IEJ1dCB0aGlzIGlz
IGluIG5vIHdheSBtb3JlIHNhZmUgdGhlbiBhIG5hbWluZyBjb252ZW50aW9uLCB0aGlzIGlzDQo+
IG1hY3JvIGNhbGxzLA0KPiBpdHMgbm90IHR5cGVkLg0KPiANCj4gTmljb2xhcw0KPiANCg0KRm9y
IGRlY29kZXIsIGRlZmluZSBzdHJ1Y3QgZnJvbSBtdGtfdmNvZGVjX2N0eCB0byBtdGtfdmNvZGVj
X2RlY19jdHg7DQpGb3IgZW5jb2RlciwgZGVmaW5lIHN0dXJjdCBmcm9tIG10a192Y29kZWNfY3R4
IHRvIG10a192Y29kZWNfZW5jX2N0eDsNCg0KSW4gb3JkZXIgdG8gYWRqdXN0IGVuY29kZXIgYW5k
IGRlY29kZXIsIHNvIHVzaW5nIHBsYXRmb3JtIGRldmljZSBmb3INCmRlYnVnIG1hY3JvLg0KDQpX
aGV0aGVyIHlvdSBtZWFuIHRoYXQgZGVmaW5lIG9uZSBjb21tb24gc3RydWN0IGZvciBlbmNvZGVy
IGFuZCBkZWNvZGVyPw0KDQpzdHJ1Y3QgbXRrX3Zjb2RlY19iYXNlX2N0eCB7DQoJc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldjsNCn07DQoNCnN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggew0K
CXN0cnVjdCBtdGtfdmNvZGVjX2Jhc2VfY3R4ICpiYXNlOw0KfTsNCg0Kc3RydWN0IG10a192Y29k
ZWNfZW5jX2N0eCB7DQoJc3RydWN0IG10a192Y29kZWNfYmFzZV9jdHggKmJhc2U7DQp9Ow0KDQpj
aGFuZ2VkIHRvIGJlbG93Pw0KZGV2X2RiZygmKCgoc3RydWN0IG10a192Y29kZWNfYmFzZV9jdHgg
KikoaCktPnBkZXYNCg0KV2h5IGNhbid0IHVzZSBwbGF0Zm9ybSBkZXZpY2UgZGlyZWN0bHkgaW4g
bG9nIG1hY3JvPw0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiA+IA0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gQW5nZWxvDQo+ID4gDQo+ID4gPiByZWdhcmRzLA0KPiA+ID4gTmljb2xhcw0KPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gPiA+IFl1bmZlaSBEb25n
DQo+ID4gPiA+ID4gPiAraW5zdF9pZCwgX19mdW5jX18sIF9fTElORV9fLCAjI2FyZ3MpOyAgICAg
ICAgICAgICAgICAgICBcDQo+ID4gPiA+ID4gPiAgIH0gd2hpbGUgKDApDQo+ID4gPiA+ID4gPiAg
ICNlbHNlDQo+ID4gPiA+ID4gPiAgICNkZWZpbmUgbXRrX3Y0bDJfZGVidWcobGV2ZWwsIGZtdCwg
YXJncy4uLikgcHJfZGVidWcoZm10LA0KPiAjI2FyZ3MpDQo+ID4gPiA+ID4gPiAgIA0KPiA+ID4g
PiA+ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19kZWJ1ZyhoLCBmbXQsIGFyZ3MuLi4pXA0KPiA+ID4g
PiA+ID4gLXByX2RlYnVnKCJbTVRLX1ZDT0RFQ11bJWRdOiAiIGZtdCAiXG4iLFwNCj4gPiA+ID4g
PiANCj4gPiA+ID4gLi4uc25pcC4uLg0KPiA+ID4gDQo+ID4gDQo+IA0K
