Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B016B8807
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCNCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCNCFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:05:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448285A79;
        Mon, 13 Mar 2023 19:04:29 -0700 (PDT)
X-UUID: 8a0a6714c20c11ed945fc101203acc17-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=34RGyOpNG2r+Ix8+xWV/FMviuzmL/1fjrZv1+fwaxNg=;
        b=cAgLC0WNoAEqxms9cKiH8rCKdhkQHvEBFafn9k7E8kNuNnA0UuBBSZ3kh1Br2DlgmrrwMGKrhLPmAudt2e3CF55KxtLHI5xfQzJtW7csBqD14Fg9RX/dqrJ5mwdA6XH9SKcYz18yWny+63AGRZUCcjTf5Rrq2H42iVMOpjkLijU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:803d26e7-f59f-4764-abb8-adb3313c8fa5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:b5cfb1f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 8a0a6714c20c11ed945fc101203acc17-20230314
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1937311703; Tue, 14 Mar 2023 10:04:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 10:04:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 10:04:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWY9+Z0q9T1KhYDKu0sZNscykXpyCM8WAXmzSDQyXCjUHukrTohp4kPyVmM8ezruqwJs3qcZ2tEsjWWeY1yWac0ja0/fwr930JXsYkZOCybMYPxt+lmtTEspHAxb4oYdx+dLJjMxkh6yp2IlHHxqQqXnrTIlN+boPkdZdFFAMR1ATbe6xfYNCJVJ7H7MkM/gyTOdrMYG5bdMA2KeKTLhU2WbzLQTcnQ/WOEweIo+0qpXtPArfbujqlz2YZc5jexruDq0vGr5KBy5LACEYQfVSbnEK8dzUH5j8proLASmw3biXq5o4SmScP81+q0dimFfF5eCkE35peGAxBC8u/dcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34RGyOpNG2r+Ix8+xWV/FMviuzmL/1fjrZv1+fwaxNg=;
 b=aSCxz2CNYxS6v48L2hPP9HS1zYmLq0r7tgvit0syHoBLLQBsdTraEn2b3Zw+NaxX13jHI7JBXvawG+BxlfII9M2NfRxBfd5tCAuzGJeuvFpyvlF51W/aX4Dn5RsWILTbzjb/nxLyMGF5o7hF6+bBoBSS3eiSHZZP0TH4vs+HrVVaiMsEpqO+/ZV3vDcGXVhMo7ssRtv54f/FfHAchGGnNyNf3ZOZa3/Zj9ZaAiY8VVQcREwj/ASxTcaw0ccECtjJlaqjigAURk/JkuI1YmPOLQ43+uxNoGMJYv5UkTLWGwhUw1UEVaYHLC3S/TD9N7+eewCeZtitZopbzXyx1ePObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34RGyOpNG2r+Ix8+xWV/FMviuzmL/1fjrZv1+fwaxNg=;
 b=ehUHIghwmzJE8uSA12BuLopD/CC1nvo7Ue8UpWsMe8G/ALheYpsaHu4YJGOpSO7NSluzATjmqKJn3RH0+WbfxaVMzmnLbx0aKPeJ7Fh+/7G/3udv8pwZ/veu0cWh9Fv7cvfAtguLpAxi7oBWlp18qr6pRPzAHqRXLdgqhklI5hc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB6394.apcprd03.prod.outlook.com (2603:1096:301:ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 02:04:19 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:04:19 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v2] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZPRRh7fZS99I5qEegpearM3gM+67IULWAgAVsuYA=
Date:   Tue, 14 Mar 2023 02:04:19 +0000
Message-ID: <46f73b4b95a802d20f31f4213b71491ea815665a.camel@mediatek.com>
References: <20230210055518.6017-1-yunfei.dong@mediatek.com>
         <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
In-Reply-To: <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB6394:EE_
x-ms-office365-filtering-correlation-id: cfb6cf70-64c9-444b-d7f4-08db24306bf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uyl/tu2emWR/FGG2hyYCTVQSdpb+EATjx1Oc1WCiQyTwFrTaiFXLuPI4pgqjlNJr28Nom8vt8oQXeHefvJ68e+iHaJPbTJ5EWT5GpLANSAcFlE331vAq7a9kfMqhMP2BgdKMzzXBjdOf0/k3wx0aeYEfFpBNe8v4DLSn7AKi6pkzReQoDPIfXD9iY8bda9sMKhbb6qLqb3BQ8lyPlZixJdewXyBIqCRp7eZTflcneXeqVaN/FPoAEoPYiHttwWC93e4s063P2B7vF59e4hf5ftTrIR0rjlExKnPpddWXi9iaG6RCBKEG1kZfBzbDzefE2npLZyr1crroFrbkSfgkxWcu0czauRI1wLZxK5J8qHbiQFbJcLdDGDADZuiHZB6uxxlQRCz8/FaEMnp2LS4R5plg76GgMa8N7NM34grJ+qsS/BF8049d0HNSg5aV9Y1ougwh7di25zthn3xFaX8gdANoYjnlYHh0vY54AqqaJ0iO8XfD6HKmCaZw04PNdZQZdrJ1CtDmHGQ3eTqwYMcnp191dY4f5U+VU9UAgkszvnfz3g/9ylNt3IdYKUxYKp1vv70872HFB6npa9q1AK+GEjlx3wh4oKUicLLzPQCBEb1zjY7cjpzrcf4mQ/eJadc2L0S8SLFVPBN2fm9OafPSIN55EY/O3AvJbilHglf4yxwtqqxWAUghnv7GnX4GJCkhm2QZWWY7y/buIfJwjJYL/5BOY3RzyHzXNPb5DLGV2QQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(7416002)(8936002)(5660300002)(41300700001)(2906002)(91956017)(66946007)(76116006)(8676002)(66476007)(66574015)(64756008)(66446008)(4326008)(66556008)(110136005)(316002)(85182001)(71200400001)(6486002)(26005)(6512007)(6506007)(2616005)(86362001)(83380400001)(186003)(54906003)(36756003)(478600001)(38070700005)(122000001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0g3VDZQMENmaGN6dlZER0lCVitSYmhpTGtZaHRwL1F6SU5Mb1NMQTI1VXd0?=
 =?utf-8?B?QVMrSkozQ0RZOUpGNWJUV3Jyd3RacTlQNWVTSFRMZ0NUTWkzR2J2MWFBSE1j?=
 =?utf-8?B?d3Zpc0V4bG9QV2VFQkgxS3F6cU50bE9TS3VRRDJ4Nm5pZGIzRXQyeVZoOTdy?=
 =?utf-8?B?anNIT3gwODlrUGIvU3dUbjZxeUhzaDNzQkJsZEpFZmRaUVNHM054RzQzS2g0?=
 =?utf-8?B?am9wTytsZFNkb1NMcnB6Wmh0Tm5HekF0LzRZRGl3OW1saitmL0dBenZkUkhx?=
 =?utf-8?B?aW5Mc3lNMjVsQnZCMlE5QUF6eGFpVlhlckdHTDcrR0Y2OTdyeUw4c1Z4VDVl?=
 =?utf-8?B?OCtoTjRwQjdSTEQxSFBXbWZ0N3FkSHhzQVZVRExEc1dZRmNGQU16THhDNnVS?=
 =?utf-8?B?bzNILzJJdjd0R2dWT2Q1TFgzSWpjelpDVTY0VWxzL2Y3YS9JQVB6OEN0N0dI?=
 =?utf-8?B?Y0s2WkpiNGNiYkpYVDNrcG9tck5FYlJUaWVvS1BEMW1WN2tEMUgvT2hlbjQw?=
 =?utf-8?B?MXJMLzY0UUZ0a1FEQWhjdkN1Y0hvSDhWMng3a0JOaGxyV0J0TVNIYXVWTm1k?=
 =?utf-8?B?ejRYWXFxdFQzaWg4RW5uUCtZTkhIMGxPTXM0aVoycmZPcDRjMmYxeWVpbGpl?=
 =?utf-8?B?UTJ3NCt1dnVoMnU5elBHeTR4OHBBQ0VsTWhYdVB2dWd1eXF6ZVE3c3FLWTZW?=
 =?utf-8?B?dkIvY2NTQ2kyRzl4bGVxNzk0S2FIMlpoNkNxZkR5T1grSk9VVzZ5di8xUktQ?=
 =?utf-8?B?dklvWFJKYktJSFA1eWs0QUo5UE8vSzNyd3c2V2srNXEybnBvTml0dGhXNGJG?=
 =?utf-8?B?QmtnNUNDdzcwTjVtanV1MndkRTE0a2ljU0NBK05TYTBDU2t2U0NsWGd4UVlK?=
 =?utf-8?B?blFSVVh0TUF4L0M4M1hZS0hsRWlVMWdkTDdmNWZOY1I5c0dDU3Z1N3hvVDVI?=
 =?utf-8?B?TXlqa3Jpb2l6T3BRbDZiRlZNTXV6eHQvZEtCYUsyNkRqVWhCZjg2SkFQVHB3?=
 =?utf-8?B?bmRZS2wyU1ZacVZMcWM5K1hvT1dQMHhOWlh4b2pPTkNHMlVUeWR6eUtjRmwx?=
 =?utf-8?B?RXk0aTYvc2RTc0d0WEtvTFBmWkk5eDB2YlUydWdTRTJyZXU2SmpNSEcvM1dW?=
 =?utf-8?B?ZDBFd2NKUHNqZFBGL2JYNmRNQzFNMUxUQkZxdnF5bEhNdWxMNmh2TUhjOVVJ?=
 =?utf-8?B?WWxPbUFmK29NSHZQMFFtd0phTXJMaHZ1MEtrc0xJMVZUSWdHOFUvTzY1eUcr?=
 =?utf-8?B?cmRmQnZtWCs3U0dDcDJNR0ZvK1VPWHdmOURFZVBVN0xvRGc1SkEzY3ZNWmNF?=
 =?utf-8?B?WWtBTHlWeURXK0g1WlExZHN3Y29keGZtaXNzUXZzd2gzY3YxZThDeU1SM1Fy?=
 =?utf-8?B?ckpVRktVZEprWDFVRURmNkpSS3NCeDQyb1lHZkRIV3ZnTytXajhCN1h5VDdZ?=
 =?utf-8?B?VWJXSk1jNlVkVkovd0FsTG1ZZGdTaWtVcWNZbk53TkFtUjdGaHpzcTB4cWw1?=
 =?utf-8?B?enJBTEk1clVYbmthZHZGcU1kZ2JFOHE5em80NGxxS0o1VzM0YUxCQ29lZDFP?=
 =?utf-8?B?SHpqbUxGdW0yMHBnRE05Nk5YWUt0YkNzUHJIbVFFV05CNFZNRDJkcVZZMWlZ?=
 =?utf-8?B?dzgrR2pNSmxCZUx5bHNIczN1SHdOdzlGb0x3Vkl4UWxPcW5WeThxdzB0OEZN?=
 =?utf-8?B?NXFFelhIbzVZZ0QrbW1MWmdITzc5QlpEd0Zwc05lSXlYODRiTlh2NEFEWi9h?=
 =?utf-8?B?NDFiSVd3aWwvT1NOREtGcW9HOVc0cW5RVERWOWw3RzJKMy9PVnhJbE43a2FT?=
 =?utf-8?B?dDhWNFlBcU9YN05XakdBcHA3L1hZU3BHcEd5cytzMGZnOG12OThzbEZJSUFk?=
 =?utf-8?B?OXZtVEhrQ1hHbzJpQjRnSXBwclgvSkxGVEF2Y0ZITGlFbVVXQzlZNGVnNm9T?=
 =?utf-8?B?cjQrWVJWTUdLWHdQVEs0S203NjNpdVRQNG1jRjRGakQyZ1B5K2ozL21BazQw?=
 =?utf-8?B?QStVaS9JWXVwdTVMZmZjYkwvTUVHMmJoSFc0R1lpWFpwUmRTZlN1Zm1MV3dI?=
 =?utf-8?B?YVlHRWxLZk1VekpxUUJHQXJGcFIyZWtwMjFwNzkvZUpvcXNRL2FXUUt2WFoz?=
 =?utf-8?B?OUNrUktqUEFOdXRtMWx5MUpQamlxUWRYK2VaWWFsNzNCRnJmM3JvNTZQczN4?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AFA37B165A5FC418DB02F5E33A82532@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb6cf70-64c9-444b-d7f4-08db24306bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:04:19.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7QaHx0hCmK2uAQ/8cslodmyLvaMh6DOp9JheBO2yH7EZ73E2NbZIvCAW5ycX23SvD7ONJFxHkhtJqYU5P1Dmj08RSe+KnwPLVeAbinmy68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6394
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBGcmksIDIwMjMt
MDItMTAgYXQgMTA6MzYgLTA1MDAsIE5pY29sYXMgRHVmcmVzbmUgd3JvdGU6DQo+IExlIHZlbmRy
ZWRpIDEwIGbDqXZyaWVyIDIwMjMgw6AgMTM6NTUgKzA4MDAsIFl1bmZlaSBEb25nIGEgw6ljcml0
IDoNCj4gPiBJbiBvcmRlciB0byBjb252ZXIgdGhlIGZvcm1hdCBvZiBjYXB0dXJlIHF1ZXVlIGZy
b20gbWVkaWF0ZWsgTU0yMQ0KPiA+IHRvDQo+ID4gc3RhbmRhcmQgeXV2NDIwIHdpdGggTGlieXV2
LCBuZWVkIHRvIGZvcmNlIGNhcHR1cmUgcXVldWUgZm9ybWF0IHRvDQo+ID4gTU0yMSBmb3IgTGli
eXV2IGNhbid0IGNvdmVydCBtZWRpYXRlayBNVDIxIGZvcm1hdCBhdCBjdXJyZW50DQo+ID4gcGVy
aW9kLg0KPiANCj4gUGxlYXNlIHJld29yayB0aGlzIHRleHQsIGl0IGlzIGhhcmQgdG8gdW5kZXJz
dGFuZC4NCj4gDQpXaWxsIHJlLXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZSBpbiBuZXh0IHZlcnNp
b24gYXMgYmVsb3csIGNvdWxkIHlvdQ0KcGxlYXNlIGhlbHAgdG8gcmV2aWV3IHdoZXRoZXIgaXQn
cyB3ZWxsIHRvIGJlIHVzZWQgPw0KDQpMaWJ5dXYgaXMgb25lIHNvZnR3YXJlIGxpYnJhcnkgdXNl
ZCB0byBjb3ZlcnQgZm9ybWF0LiBPbmx5IGNvdmVydA0KbWVkaWF0ZWsgTU0yMSB0byBzdGFuZGFy
ZCB5dXY0MjAgZm9yIE1UMjEgaXMgY29tcHJlc3NlZCBtb2RlIGFuZCBNTTIxDQppcyB1bmNvbXBy
ZXNzZWQgbW9kZSBhdCBjdXJyZW50IHBlcmlvZC4gTmVlZCB0byBzZXQgY2FwdHVyZSBxdWV1ZQ0K
Zm9ybWF0IHRvIE1NMjEgaW4gb3JkZXIgdG8gdXNlIExpYnl1di4NCg0KPiA+IA0KPiA+IEZpeGVz
OiA3NTAxZWRlZjZiMWYgKCJtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogRGlmZmVyZW50IGNvZGVj
DQo+ID4gdXNpbmcgZGlmZmVyZW50IGNhcHR1cmUgZm9ybWF0IikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsub3JnPg0KPiA+IC0tLQ0KPiA+IGNo
YW5nZWQgd2l0aCB2MToNCj4gPiAtIGFkZCBGaXhlcyB0YWcuDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMgfCA0ICsr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gaW5kZXggNjQxZjUzM2M0MTdm
Li40ZjVlOWMyMDIxNGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
ZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBAQCAtNDEsNyAr
NDEsNyBAQCBzdGF0aWMgYm9vbCBtdGtfdmRlY19nZXRfY2FwX2ZtdChzdHJ1Y3QNCj4gPiBtdGtf
dmNvZGVjX2N0eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0KPiA+ICAJY29uc3Qgc3RydWN0IG10
a192aWRlb19mbXQgKmZtdDsNCj4gPiAgCXN0cnVjdCBtdGtfcV9kYXRhICpxX2RhdGE7DQo+ID4g
IAlpbnQgbnVtX2ZyYW1lX2NvdW50ID0gMCwgaTsNCj4gPiAtCWJvb2wgcmV0ID0gdHJ1ZTsNCj4g
PiArCWJvb2wgcmV0ID0gZmFsc2U7DQo+ID4gIA0KPiA+ICAJZm9yIChpID0gMDsgaSA8ICpkZWNf
cGRhdGEtPm51bV9mb3JtYXRzOyBpKyspIHsNCj4gPiAgCQlpZiAoZGVjX3BkYXRhLT52ZGVjX2Zv
cm1hdHNbaV0udHlwZSAhPSBNVEtfRk1UX0ZSQU1FKQ0KPiA+IEBAIC02Myw3ICs2Myw3IEBAIHN0
YXRpYyBib29sIG10a192ZGVjX2dldF9jYXBfZm10KHN0cnVjdA0KPiA+IG10a192Y29kZWNfY3R4
ICpjdHgsIGludCBmb3JtYXRfaW5kZXgpDQo+ID4gIAljYXNlIFY0TDJfUElYX0ZNVF9IMjY0X1NM
SUNFOg0KPiA+ICAJY2FzZSBWNEwyX1BJWF9GTVRfVlA5X0ZSQU1FOg0KPiA+ICAJCWlmIChmbXQt
PmZvdXJjYyA9PSBWNEwyX1BJWF9GTVRfTU0yMSkNCj4gPiAtCQkJcmV0ID0gZmFsc2U7DQo+ID4g
KwkJCXJldCA9IHRydWU7DQo+IA0KPiBUaGlzIG1ha2VzIHRoZSBWUDggYW5kIHRoZSBvdGhlciBj
YXNlcyBpZGVudGljYWwsIGxlYXZpbmcgYW55dGhpbmcNCj4gdGhhdCB0b3VjaGVzDQo+IE1UMjEg
YXMgZGVhZCBjb2RlLiBJJ20gbm90IHN1cmUsIGNhdXNlIEkgY2Fubm90IHRlc3QgaXQsIGJ1dCBp
dA0KPiBzaG91bGQgaW4gdGhlb3J5DQo+IHJlbmRlciBNVDgxOTIgdW51c2FibGUsIHVubGVzcyBh
IG5ldyBmaXJtd2FyZSBoYXMgYmVlbiBzdWJtaXR0ZWQgdG8NCj4gbGludXgtDQo+IGZpcm13YXJl
IHdpdGggTU0yMSBzdXBwb3J0ID8NCj4gDQpJZiB0aGUgZmlybXdhcmUgb25seSBzdXBwb3J0IE1U
MjEgPT4gd29uJ3QgZXhpc3QgZm9yIHZwOCBuZWVkIHRvIHVzZQ0KTU0yMS4NCg0KSWYgdGhlIGZp
cm13YXJlIG9ubHkgc3VwcG9ydCBNTTIxLCB3aWxsIHVzaW5nIE1NMjEuDQpJZiB0aGUgZmlybXdh
cmUgc3VwcG9ydCBNVDIxICYgTU0yMSwgd2lsbCBmb3JjZSBWUDggdG8gdXNlIE1NMjEsDQpIMjY0
L1ZQOS9BVjEgd2lsbCB1c2UgTVQyMSBiZWZvcmUgdGhpcyBjaGFuZ2UuIA0KDQpXaWxsIGZvcmNl
IGFsbCBkcml2ZXIgdG8gdXNlIE1NMjEgYWZ0ZXIgYWRkaW5nIHRoaXMgY2hhbmdlLiANCg0KQmVz
dCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gPiAgCQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+
ID4gIAkJcmV0ID0gdHJ1ZTsNCj4gDQo+IA0K
