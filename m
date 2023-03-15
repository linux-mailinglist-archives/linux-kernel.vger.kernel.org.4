Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282A6BA5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCODnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCODnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:43:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563C5D271;
        Tue, 14 Mar 2023 20:42:45 -0700 (PDT)
X-UUID: 6da07c08c2e311ed945fc101203acc17-20230315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ppcINVuaddTurryo0NehUVxRzujWpB9jrF9qDDsfArg=;
        b=cXL1bT9cJq25+hlMdCwROL5Ivizgsvr6aP0yPAYgm3uNdmxInost6U7mHoIsVyVd+sbe1+/DW1lmw3n9hEjIdLviTg8IyIur82YHKMQ9AObg0eqPaUaIpIY5H3sIl4nyBFj6KVXuZ4O2lv9oo9/tpTWU35hq+9jMMxmKLDNio90=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:fa26d9a6-5240-4a8c-a2af-5332f7332e5e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.21,REQID:fa26d9a6-5240-4a8c-a2af-5332f7332e5e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:83295aa,CLOUDID:002848b3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2303141745340GONSENH,BulkQuantity:4,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 6da07c08c2e311ed945fc101203acc17-20230315
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 350951824; Wed, 15 Mar 2023 11:42:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 15 Mar 2023 11:42:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 11:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+GbDy5I4yTdI4C9UknzIeN/ExRfHdt5Xc+DPTY4lnFikjhw1Q6UPBQOK2A3LBtoZ9dHuV5MVzZT+9WqTL8T3fwCmyq37kw62A7FhPI6xREUD5QD6os0BSYdOwYzxgiApp1siYDcovn0Sj9deR5jr7JDt9ziaym8erqfCQghanPYv6rfNBQERpJeZhzFuELQEak+kbGtay9ZQRzTDyPVsgpwlAOddVeuXZT6FTDEtnPIPZFusYdsK4jT/gc3ucq2SA8xsSUOspUdZRmDZbuDKdadsARof+5sP4X/aIhvC2tEzs7tutV1zr3dgvWHO7TD80TOyDVllurqYC2zmp427A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppcINVuaddTurryo0NehUVxRzujWpB9jrF9qDDsfArg=;
 b=LHFI9McnaqAMJNDaLKf6WgdddXv38NDspFbOgP6z0kjJ2z27Sk275h62lJ0ZCgSUzEf64KpIu6wCh9XlEO2f8qXk1rW9wUQo6Ap/R8iD58ZVOWTm9oLfQLs8FQ/yQgWkY2evG2q1m3IsvtgtxG21ySYhvsvhG8HOEuRoCEPw5VilnSevU+E8tpBoqycKvMnTF27eBtMfF6eGUqfLQ7IgUjPdNZviYZEI1t/DI42qgI0CMf9lykpu44oGabNoKBIGo2nzmdusGaJvax717gae4DxXEybZBfMgeBWlqy593tNbX/+zxiIQVFdO70e0+OO5kBt6htNr1PjIgtYecMFj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppcINVuaddTurryo0NehUVxRzujWpB9jrF9qDDsfArg=;
 b=CG8I3CLUsaqNHk0xBaQlJXfn9gsDG/iKojVrSEktA8/UuvM0wBA056FI6H8pgvKtNvS6+JY+CqGeVFthDpwNYh/SnHaoZhkpKKoOkL1dD2zKER56+tYKHq4L85qLeYcKbRX2q9KLSfpZgtH9R8Ospb1HPYz6sUIOvFAFHLgyup8=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PSAPR03MB5701.apcprd03.prod.outlook.com (2603:1096:301:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 03:42:33 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dc74:62fb:a3ab:b10]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dc74:62fb:a3ab:b10%4]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 03:42:33 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v3] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZVkZS6MhUOC1ZHkW79MuF92sziK76BtqAgAEs8IA=
Date:   Wed, 15 Mar 2023 03:42:32 +0000
Message-ID: <adf8c1ebf1c240dc88889d102ed1f0dadd4612c1.camel@mediatek.com>
References: <20230314072557.29669-1-yunfei.dong@mediatek.com>
         <08ccf52a-39bd-ed28-d9ca-3615c4a02c09@collabora.com>
In-Reply-To: <08ccf52a-39bd-ed28-d9ca-3615c4a02c09@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PSAPR03MB5701:EE_
x-ms-office365-filtering-correlation-id: fc6f3ac4-2389-4dcc-b3db-08db25074f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHi+Ktx0iqmVLaNnpAKCV16SiRL+vUMbvaxkGi3lBkPRqyCHpoSo78VtHIAQPoLX9esV9R1l1Ibs78ZpjE9PVmexDVUYMPn0Yqyp4NcRi6wo+Vk4envTA67MnG16PLtKp0uwAR4aMFWSl8yT2icpxQAxsu1pHIubUKPtjiHZJLI8OA1X98tR8uAHgQ8GDB1A2gcIzFiGyq77oldEkqqvAZYSu8esSiFr8koStMfFsgsotAX8bZQTltnBBDByq4hHzufmsLdppxvo9AApRwMgRFN2GEWr54AGGiIBCLXkfqTB0sfMZEyTLE35pQznV+0QXJaQ+8HxoNc4AbZkH0K4RByp80FMT30a1W7v1fO5t9UY7NoE+Wp76kOZOgUzxFub89xWPzwAFhAIXY7iA5G2ZajNZxWpkflnz8OdbhfuZZQkCdbJD9sFmj8Nf1JOzBdWIZyUmZ74RDtMju105jLa5ccm2QlMhjqYMJgPyjkQaqYIip9iK7vk/svbFZQJalp8Zq6sKmf4WRwuqYPfeOKkvcgt5Zydu4zOqOZ64DBUNsgcC8/R1XQnhSW8Bt1UGishg6MYquGDMjDqUwhLK7iaulpjEdJr+P0d4+xdBON6oz+tvl4nzCjHqj9NfmCLirGteydCCuduhCWxO5ByZDKO8T12+8GOenh78hCyLxBy9NewP6+pdJfTXqgvpoe5Nho8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(41300700001)(7416002)(8936002)(5660300002)(2906002)(85182001)(38100700002)(38070700005)(86362001)(36756003)(122000001)(478600001)(71200400001)(66556008)(91956017)(8676002)(6486002)(966005)(66476007)(64756008)(76116006)(110136005)(66446008)(66946007)(4326008)(83380400001)(54906003)(316002)(2616005)(26005)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktuYVFBekpUcG91UG9sRFlnWVg5QlR6ZTNvNTVqZWNncWJodUxMTXlDdVFU?=
 =?utf-8?B?TUFWL1dOaFFsSldrclJpclFpbzAxY1NrL2Q4SlFEZnhCa0N5N1BGa2hTcldY?=
 =?utf-8?B?OU9FUmJKY3Z0c1BJS0lDNXBZNmRpdzBrS1VLcjY1ek1pTTAvSlIzMER0Q1N4?=
 =?utf-8?B?Ym9aL2dnN3lkU2o0dms4OWhZdlV2bnQ2ZkFPa0p5MWxWQTdwbE9oaWhhSG5K?=
 =?utf-8?B?Zm9GaTNObXZ0S3Y4YzBFS2ExSzRkRitmZDd0djZ1eGxITkpWU3hLSmZ1QjB1?=
 =?utf-8?B?bUF1eFdEMFowZy9kVHZBbDZyUWNZbFFZVUlRL2VwS1RUdlNSZ1dyQlBiTXIz?=
 =?utf-8?B?YzVsTVlGbWRjdDNXbm1uVEJScUNLUXU2MnhYZHdaZmxhTnZVYVdydlI4ZzN5?=
 =?utf-8?B?NTJQczZCWHJ3U0NBT3VjSzZ0aldGcG96VUdXK0ZrUWwyeS9WcjZLVS92QWta?=
 =?utf-8?B?ZUtLWHZXdk8vMWx1dzl1VDdMQnAzUFEvWEdpcjMzUUZJRG9ROFZqU3pjdDY1?=
 =?utf-8?B?M281c01zSSs1b2p1eDBhclZ1Ynp2VUF6ZTBZeVVPM2E0b0tWRXhqbE1MZzFH?=
 =?utf-8?B?ck16NHpCWHM4RmF6ZWx5OVVvZzRWY29Md1B6dFVtSm5OdWhpWkdIYjJqQUVE?=
 =?utf-8?B?QjJzNlAzTVAzMWRCNjlJYXVKN3ExRUZOd0RBZkE2YnU0TUdPZmxYK2JpYkcx?=
 =?utf-8?B?cExla2VObHlsWk96MHFpTkZrSjV2TE5WVjIzUmRncm5COWlkMnFKSGRxRjk3?=
 =?utf-8?B?MmRJWWg3cElzODY2b1VzVVUyayttRzVpZzRGVVdvRDZPYVE0M3dYRkx6VnJl?=
 =?utf-8?B?cDNQL25WRUY5eFh4K3cwZ0xaWEd1ODRzcHVrZ2t3ak16VjFhc09tb1hUSkNu?=
 =?utf-8?B?a3luMmEzSnp3MTNoeHRwVTk0SlU5OE8rYjlNcDNOa1NQKzdTTEdWL0U0akMw?=
 =?utf-8?B?NGNrZjc2cTB3b3V6YWMvdG5xVG1wUTBVZnhWOXdlRDZMcWxML0JaY2lTeER2?=
 =?utf-8?B?emM5Z01SNkxUQUtja0NVV201d3RnVTdwMmVNV1NNc2taTXRLMkUxQXc4bUVS?=
 =?utf-8?B?QjErNEtZaklkdlFXQkpGMHRTNjdlSkI4Nll0TmUvM0RIbGFHWWVHYWJPY2dY?=
 =?utf-8?B?d1dJQTZlZkJnNnFDTWlGcGRpUHVxZFd6c0pNQ21HT2M3eFAwNEVkdlBBZGFu?=
 =?utf-8?B?SGpuUkNqL2R1d0JqVkh3N3h5Q2FWbDFzWks4WTYvYkJyNGJSTnhWZXRvam9L?=
 =?utf-8?B?Q1dLcjVSZVo2NDg3bk1Fbm0zWWhid2VodVFuaDQ1U0VDVk9kYXNFY1lxSnQ4?=
 =?utf-8?B?QmRyR3VkMnloN1lSNlFzV1hONGhkSnF0bTFJMDFCSUhFcDFQenBxajhBRk1D?=
 =?utf-8?B?VkVnUC9SdzdUZnBRMDYwYk5Gc1V6azVBbWFNbzBDUmpHSWN6V2xObkN4bzB0?=
 =?utf-8?B?V1EwM2kyZFlub3R4aFN1ekplY1I5bFcza3lYUHphL2pVVldLV0x6YmlFZGpU?=
 =?utf-8?B?eXR1NlNJdWwvZldtZWxwTUJvTnp6eUNpeCsrM2F4REhOSVNqRFc4VCtNOEhF?=
 =?utf-8?B?VEtTaTd6L2ZPeFYwZG85NS9WdUZvT0RVeVRmeEwzMkRTTmdURmVZRzVmbThp?=
 =?utf-8?B?NjQ0am9uUUFNRW1WL2piYzVpMHFFTWdVRnFkT1RQMTFDdlprN0NOSWFUTkRE?=
 =?utf-8?B?Q3FFYy9PSnFDUjAycDFnU0V0TXlpaVNnQ05aSG9oMkVnU0RWaG8vRTAyQlc4?=
 =?utf-8?B?K2FKS0o3bTJYUHg5NXQ0N1NEa0ZRRm1nZThjdVdHc3JsZkU4bjJxNngzQkxB?=
 =?utf-8?B?V21pZ0c4Q25GQy96OEs2ZmVYRm5VQUJ4MFhKM3JhSU83bTA1RjQxcENqbFNK?=
 =?utf-8?B?QlM4VjZObTQyR3NKeEVtczRqaE1kM295eXhsQ0RXbWlBY0VmNFVyNFlIbE5a?=
 =?utf-8?B?VlBkOVNKelBqUnpBTGxJdVJ5SXV0V20zMHF1QUZpSUoxRVBRV1QrYk1NZWUx?=
 =?utf-8?B?MUIzNCtpU2huVWR4UzkyOFBIQjhhRTVwVGxaSGl0cFF1RkowY01pRmd5YWJM?=
 =?utf-8?B?cmRTYXAxYWd2MUVsYlNjemFhZDZxSDdzQVFuVlY2RTFUNGZqQ3B4WS8yTkdk?=
 =?utf-8?B?aTE1ajlzeDhsblJFS2o5N2J4YUh5YVp2VGJPdWFJSUc5MGIrTDFTdEVBZThF?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <302FC9DE481C3848AC616B6984CCB33F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6f3ac4-2389-4dcc-b3db-08db25074f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 03:42:33.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XuozOhRFLpGAYZr0DRv5T/4o2LmdSs2l1jyqF5sNK/Ailnkrnmgny8M8fNw60RXH+5xr3tkyobdA655PhWdO9RT+0iPo6O0c8OwtoJIZJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTE0IGF0IDEwOjQ1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTQvMDMvMjMgMDg6MjUsIFl1bmZlaSBEb25nIGhhIHNjcml0dG86
DQo+ID4gTGlieXV2IGlzIG9uZSBzb2Z0d2FyZSBsaWJyYXJ5IHVzZWQgdG8gY292ZXJ0IGZvcm1h
dC4gT25seSBjb3ZlcnQNCj4gPiBtZWRpYXRlayB1bmNvbXByZXNzZWQgbW9kZSBNTTIxIHRvIHN0
YW5kYXJkIHl1djQyMCBmb3IgTVQyMSBpcw0KPiA+IGNvbXByZXNzZWQgbW9kZS4gTmVlZCB0byBz
ZXQgY2FwdHVyZSBxdWV1ZSBmb3JtYXQgdG8gTU0yMSBpbiBvcmRlcg0KPiA+IHRvIHVzZSBMaWJ5
dXYgd2hlbiBzY3AgZmlybXdhcmUgc3VwcG9ydCBNTTIxIGFuZCBNVDIxLg0KPiA+IA0KPiA+IEZp
eGVzOiA3NTAxZWRlZjZiMWYgKCJtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogRGlmZmVyZW50IGNv
ZGVjIHVzaW5nIGRpZmZlcmVudCBjYXB0dXJlIGZvcm1hdCIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
WXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IA0KPiBBZnRlciB0
aGUgZmlybXdhcmUgZ2V0cyBzZW50IHRvIGxpbnV4LWZpcm13YXJlICphbmQgT05MWSBhZnRlciB0
aGF0KjoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5n
ZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KDQpUaGUgZmlybXdhcmVzIGFy
ZSBzZW50IHRvIGxpbnV4LWZpcm13YXJlLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1maXJtd2FyZS9hNDM1MjRhMDg5YTc4M2Y3MGFkYmU4OWI4M2VlYjAxZmJkNDA1ZDA0LmNhbWVs
QG1lZGlhdGVrLmNvbS9ULyN1DQoNCj4gDQo+ID4gLS0tDQo+ID4gY2hhbmdlZCB3aXRoIHYyOg0K
PiA+IC0gcmUtd3JpdGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gLSBjaGFuZ2UgdGhlIGRyaXZlciBm
bG93Lg0KPiA+IGNoYW5nZWQgd2l0aCB2MToNCj4gPiAtIGFkZCBGaXhlcyB0YWcuDQo+ID4gLS0t
DQo+ID4gICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMgfCAy
NCArKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyMSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBpbmRleCA2
NDFmNTMzYzQxN2YuLmM5OTcwNTY4MWEwMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gKysrIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+
IEBAIC0zOSwxMCArMzksOSBAQCBzdGF0aWMgYm9vbCBtdGtfdmRlY19nZXRfY2FwX2ZtdChzdHJ1
Y3QgbXRrX3Zjb2RlY19jdHggKmN0eCwgaW50IGZvcm1hdF9pbmRleCkNCj4gPiAgIHsNCj4gPiAg
IAljb25zdCBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfcGRhdGEgKmRlY19wZGF0YSA9IGN0eC0+ZGV2
LT52ZGVjX3BkYXRhOw0KPiA+ICAgCWNvbnN0IHN0cnVjdCBtdGtfdmlkZW9fZm10ICpmbXQ7DQo+
ID4gLQlzdHJ1Y3QgbXRrX3FfZGF0YSAqcV9kYXRhOw0KPiA+ICAgCWludCBudW1fZnJhbWVfY291
bnQgPSAwLCBpOw0KPiA+IC0JYm9vbCByZXQgPSB0cnVlOw0KPiA+ICAgDQo+ID4gKwlmbXQgPSAm
ZGVjX3BkYXRhLT52ZGVjX2Zvcm1hdHNbZm9ybWF0X2luZGV4XTsNCj4gPiAgIAlmb3IgKGkgPSAw
OyBpIDwgKmRlY19wZGF0YS0+bnVtX2Zvcm1hdHM7IGkrKykgew0KPiA+ICAgCQlpZiAoZGVjX3Bk
YXRhLT52ZGVjX2Zvcm1hdHNbaV0udHlwZSAhPSBNVEtfRk1UX0ZSQU1FKQ0KPiA+ICAgCQkJY29u
dGludWU7DQo+ID4gQEAgLTUwLDI3ICs0OSwxMCBAQCBzdGF0aWMgYm9vbCBtdGtfdmRlY19nZXRf
Y2FwX2ZtdChzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKmN0eCwgaW50IGZvcm1hdF9pbmRleCkNCj4g
PiAgIAkJbnVtX2ZyYW1lX2NvdW50Kys7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gLQlpZiAobnVt
X2ZyYW1lX2NvdW50ID09IDEpDQo+ID4gKwlpZiAobnVtX2ZyYW1lX2NvdW50ID09IDEgfHwgZm10
LT5mb3VyY2MgPT0gVjRMMl9QSVhfRk1UX01NMjEpDQo+ID4gICAJCXJldHVybiB0cnVlOw0KPiA+
ICAgDQo+ID4gLQlmbXQgPSAmZGVjX3BkYXRhLT52ZGVjX2Zvcm1hdHNbZm9ybWF0X2luZGV4XTsN
Cj4gPiAtCXFfZGF0YSA9ICZjdHgtPnFfZGF0YVtNVEtfUV9EQVRBX1NSQ107DQo+ID4gLQlzd2l0
Y2ggKHFfZGF0YS0+Zm10LT5mb3VyY2MpIHsNCj4gPiAtCWNhc2UgVjRMMl9QSVhfRk1UX1ZQOF9G
UkFNRToNCj4gPiAtCQlpZiAoZm10LT5mb3VyY2MgPT0gVjRMMl9QSVhfRk1UX01NMjEpDQo+ID4g
LQkJCXJldCA9IHRydWU7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQljYXNlIFY0TDJfUElYX0ZNVF9I
MjY0X1NMSUNFOg0KPiA+IC0JY2FzZSBWNEwyX1BJWF9GTVRfVlA5X0ZSQU1FOg0KPiA+IC0JCWlm
IChmbXQtPmZvdXJjYyA9PSBWNEwyX1BJWF9GTVRfTU0yMSkNCj4gPiAtCQkJcmV0ID0gZmFsc2U7
DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCXJldCA9IHRydWU7DQo+ID4g
LQkJYnJlYWs7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArCXJldHVy
biBmYWxzZTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICAgc3RhdGljIHN0cnVjdCBtdGtfcV9kYXRh
ICptdGtfdmRlY19nZXRfcV9kYXRhKHN0cnVjdCBtdGtfdmNvZGVjX2N0eCAqY3R4LA0KPiANCj4g
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVGluZ0hhbg0K
