Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C496623FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKJKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKJKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:34:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010C66C81;
        Thu, 10 Nov 2022 02:34:25 -0800 (PST)
X-UUID: b21da98d5c8943b88bf6fe0715364f80-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PJSZfyuhtbGTs/8kINl5maoTHQnAjrHLBkDGpWlyhmA=;
        b=fVrA1ch73PE7OcyYE+McnmoauXP5/vyWABxpfGmM3C+pANWJsmakjqRP8EASCG+tyaZO8fi8DkcPICaP/7kVvuDAG1pEBEPYzHFD+zKIgmdkDnYUJUyfSN6mUH5DFiRi6RPZFOfL05x7whz8JQpubJRqEkk6LNsnbiQwANazqaI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:bfdecb3c-2ea8-4438-89f3-e210e0481a87,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:88872e5d-100c-4555-952b-a62c895efded,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b21da98d5c8943b88bf6fe0715364f80-20221110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 308583096; Thu, 10 Nov 2022 18:34:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 18:34:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 10 Nov 2022 18:34:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmNnImD0zdER7Yust6TCuFZNmTyg+OI4uphvQ3un1iYWf5s+CDWZaKZSua11nJZM6S0q6hWuAP2jQXQwK6JGUFSpk/Y6e247gZP0snewIj0xK6QzNIl7h5Ub+r0fxzfwGqYwSKc837mRiLjY+GY7FI9ItjynRt7uZAu84nQUPgMPFuHKm8kCyMh9rlxgBqJLsf2s3pN753cv9aOQyS/UeaF+9uPVZOpz6X7dp2uEm1YwEl63dzGzF/gDO8tHpvAbHR0yDcHRY28SbCfo3Yn3b05pdN3Bgn7pvIZ+5LRffj5KiVDRNJabkRB1xigxgD4QTJcv4Sc6EZbiLkhkpW+rJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJSZfyuhtbGTs/8kINl5maoTHQnAjrHLBkDGpWlyhmA=;
 b=nX2g6VaTj1LAfiABy5gEaM8RcDQrPvlODH56VXXK50SAQQq0S8dI/34iWSC7ztElzGXYy3qoqC2pb9GRiJIqCGze/qRxxywW9BC+9/uuskjru2EGoqfehaDJonkFWYMpgzAxtReCDB+kI99S3AeVJxoJKTW8QXqIKEkDr1BeV2n+Oeix3mjN88iDqV/I4xA1069QVCF2lMa/+6+biDddoAwVtCdF4JIoxx1Na/J8dwxkNqIbHDMLuyOyuw4g6WHn4cFKIp5gSZSHRDuVTymm/D1Tq868fIXtkwkQNx1//9xBW89RgnltEBk8OeRT+0DitYBewGQzYl80g1uKjGC1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJSZfyuhtbGTs/8kINl5maoTHQnAjrHLBkDGpWlyhmA=;
 b=SE12eceaAJT/AmeOHHKtXz/uJ0QfZ3UnPc/vaKef7CTKKF/lEQmXNtrHPA7gMFsQE8Yw0QpdFhnz13f2tw4IoTbsvIhQ4wg73HBcYLuyTF7WoqP4oQmmnpz+to7v8fUV9we+YInDFXNFf0ixTprez9f3SJTyIO4YIOaPXiCLjak=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SEZPR03MB7148.apcprd03.prod.outlook.com (2603:1096:101:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 10:34:14 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 10:34:14 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
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
Subject: Re: [PATCH 2/3] media: dt-bindings: media: mediatek: vcodec: Change
 the max reg value to 2
Thread-Topic: [PATCH 2/3] media: dt-bindings: media: mediatek: vcodec: Change
 the max reg value to 2
Thread-Index: AQHY9A3s5UobTKtD5ESIsMOIykLWOa42U3+AgAGkWIA=
Date:   Thu, 10 Nov 2022 10:34:14 +0000
Message-ID: <6229b2ce6f49ccad25eed3ae00390b4553cf94a3.camel@mediatek.com>
References: <20221109073529.26765-1-yunfei.dong@mediatek.com>
         <20221109073529.26765-2-yunfei.dong@mediatek.com>
         <96979d33-829a-4b38-bd8e-83b7f07a7c2c@collabora.com>
In-Reply-To: <96979d33-829a-4b38-bd8e-83b7f07a7c2c@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SEZPR03MB7148:EE_
x-ms-office365-filtering-correlation-id: 6dc6bb5c-708a-43fe-8194-08dac3071d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tS3zjNEa2VBVrQPvA7ANLjsUkPi0y9eRDODkTAC/3j/cSP4rRMfk7Nm5P3iN9f90HjJF7jK8OSq6J8Og09t2fGlyM0eQ1dyJ0rxwtOypJdSFXdW8hszTgecBwDglmExdlWYYsqXv1F6oVErdS8h/Ab5nwYkTievnhGm6T5yeIY+iS0nE4/pNdPN2Wq8nWFoFe+4mUi0yPCDhxjfn+KEH/JF0oDO5LESxrDBpDuy3wzHm9o99bpny2jjw+G2SLFBh35DB8uFfLXkHBF/6c3HQDDLq7wee3CsasAZw88z1mu1GA2plzhaLiPteNI1KMlm5jWu8aSeu3ZlkeoRrCi4wKtgXyveAljPZ4BD+Mzs32YzIkeb+lidwbRjYGTHMLTcbIRUx5deVAZRTUMHmBLIKft8CDPHnCZdCY6jakyfpZ91R+DcEuRw792kp0RnS6aLTvE4OgU0gAOUxPW2nC1lj+4Zt3p8fXfm1qSNx8nGtO9eSeXQXlhteVN/92Fs7fGvH6BIbNJAVfSG6qOsJTPA1MWdKRcr0ntYlzSJ41bJtanim4tMzunJAUItKOxdbSb00HAL+MzGTjFqps3zS7akaQ4fWh1ns5dc+lTn8HIQFkWsqCoiAIat0SV/J7nEb6X9E2J8iCkYiJxVOHJJqwXenWJfHcRfjyJx6yGwsIh5Y90znMluXfRu9JmgZwRE9SreAwI8UGJQJQuawzbQMtdFEpBEacBNTn0Q8tE8Wrn2Hz7rpBiSwRbw92eLq0iIiZ98dudEzqAWtSu0ye9fuNsHXmy/S+nl79SCeG4WoI0NBGsKqx5xlNwcISlpyNaTbTMuc/b5LBSI3rH2TqOjbtWgkaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(122000001)(38100700002)(2906002)(86362001)(38070700005)(4326008)(6506007)(2616005)(26005)(6512007)(110136005)(66476007)(316002)(478600001)(91956017)(64756008)(66446008)(76116006)(66556008)(8676002)(66946007)(6486002)(71200400001)(7416002)(41300700001)(8936002)(54906003)(186003)(5660300002)(83380400001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elFjYXJ2aFdkd1FyUktYNmtpUzhkYWFNN0cvSmdqUWRXUE5VY1laalk0Vy8r?=
 =?utf-8?B?L2JTd2ZYOVBKUHg2dEY0NXJmQ0w0QTdWM3V0ak83Z1VQRW5iVmNCNDBKaEtR?=
 =?utf-8?B?MnJrTmxZWWN4UGpCWFFuWTUrNElrOThTbkQ2enhXWVFJendjOGlZTUlwb25V?=
 =?utf-8?B?R0JwNWFwb0grczQxOW8wQkZPek04aGZDUHFIL1JUcWV2WUdTT0orODVMWHhH?=
 =?utf-8?B?Zk9rZjBZTlI2bmVZMUNTQklKNmh2ZElkWUhGNi91WHpudzF3YURqT0dyYUM4?=
 =?utf-8?B?Q0dqWnV0UXFVRmtpQjhNMnhDT1loOEpoR0h1dnYzUlpaRUpkbXZ6OGZQb0pT?=
 =?utf-8?B?dXljUWdoeXJpbDF4bXJ1V3RHYmlpanNuZk1lMFQwMEkrQkMrQTZyZjRyZlpW?=
 =?utf-8?B?WjFuTFJWcFFoRk93cC9xTHZHWUEzRHprbVY3M00vSXFHV3BueUpmcER3Mldw?=
 =?utf-8?B?MlYrR01QMnJDSWdtYW9CV0ZqZWk4VnhzL01VWCtTeEZHSTZsYm14dVNaNm1l?=
 =?utf-8?B?WjdEeXgxb1duOU91Z3ZGMHZ5b283ZjZhclprdVI0bkZKcjFlRGFWNnFEVzdp?=
 =?utf-8?B?bStKREJBRS9yeHk4Z3EvSXpDbmxjSHlsQnY0aFR3cEdHaUtqcElhcUVmMGhX?=
 =?utf-8?B?UHRxcGFZOEFiTGkvaUFiVFI5bHh4cG1Oa2NYNkJEeityNUh2bzJCS0xodVJ2?=
 =?utf-8?B?b005aGsxTll1REVnVnJaK2R0ZTU4RmVXTEhpTmdsa2ZXbnI4M0FmSkJBa2hZ?=
 =?utf-8?B?cklzYmxzd2doaDdwaUJ4c3ZRMkVTelc0Y3UxTXBpV1k3ZkhxcDAxdWZIaGRm?=
 =?utf-8?B?Z1A2M0VxQlMyQUZQcFNPYjlUelptTVRyS3NURExWbEUyM3dTa0kwWFh2OEhR?=
 =?utf-8?B?ZUJlOFQ1U1h0ZzBUbHZCaitaenJwN3NFMktSYm9qWDgwOVd2amQyazhkTHlq?=
 =?utf-8?B?Ui90NzZ2MmNCLzZxWlJLK2lvYVdnQm16L2lLdXY4azZQbzg2R1lUV2s4aUNo?=
 =?utf-8?B?OVQxRjRDQmJGLzZtaU1NT0NoTXc0TS8vS1VMbUF4bWh2MngwdEd3czloRFdh?=
 =?utf-8?B?Zk85REphN09VdTVLeUJ0ZnhzamN5MTlSUEw5NFdoQjBiYk95azZ1NlFnWTJ3?=
 =?utf-8?B?cS9VUThLSnZUcWR5blBQS0owa3RuS3IybkNrQ0VmSHZiM3hMREZTdi84TGJq?=
 =?utf-8?B?OEVuNnJVdEdWZjM3RXYrRDIxRHBEYmpPd0w2UXYvWlNMQUZydm41cXRLR2kw?=
 =?utf-8?B?aTZTQW5sMUNlYk1Oc2F6MDBsUmtpVUdJcnF6NUQ0dUhzUVh0VzU0Q0x0MlBV?=
 =?utf-8?B?Z1RLNHJWY080cXhqMWFiNEI2K3E2YkVQWW01czBOczNDY20xTTdTbG0reTdS?=
 =?utf-8?B?UzloNjM1akNabGlDQVBRN1R1VjlkYUVFRzgwK1k2blN5U1hPWHFiQ0hhNmhx?=
 =?utf-8?B?WmlUZjFacFg0eHU2bmprc3JZdHdTNHJuQlNsMXVCeXFvbFdwNTVFeXp2SHNU?=
 =?utf-8?B?RWlLaGJGMWVZeTFzMktqNTVVL2lDdEUzTmJzL2JWRlBnWXFNQUFEdVBNdUYv?=
 =?utf-8?B?UzNOaEJ1YmxqbWxuSnJmU3QxUm5vQU84NktrZ295WmVpWlRUU2JCQlRiNmtK?=
 =?utf-8?B?aXBwdWRielBHcElZQWZ4aVlaVjVlR2lQKzF2TWpFTXRnNXVQbm5TajgrVytp?=
 =?utf-8?B?SVREamhZOFpGM1JUSVFNaXFxNS9pUTZsaTF1OUFUOUJaN3RKVnQvN0wzUlRp?=
 =?utf-8?B?M1NFSTVXVnFKVVZERE1zRitLak5pRElRMEFXLytURmNJN1ZTTzNyRDU5Qmsz?=
 =?utf-8?B?bWUrMnV5WHlUQ2pUVEQyQ2tQMzNSYm4vRkVnOUFhZlBFeThhRExUWC9nK2c4?=
 =?utf-8?B?S2EzdXc3UmxjaG1OYTJ4eWlFTTJmeURKVS9XWXdSeTZ1Z1k5WHJ6WkRkUElH?=
 =?utf-8?B?cWtjUzRIMXpFcmF0SDhyNW1uTXZYbDlmcGxmTExVL05tVjVxMHFydCtFanM3?=
 =?utf-8?B?UXR3VUdBTHdWVWtycmNWZkRCdVQzUFJBR2VYOVdtTnVpc2ZieGp1Rk9YWFpw?=
 =?utf-8?B?c3BuS0praWN0NnpWNEFMYS9ycGpoS2FpWUNIaVRFaTdnOWJSdlFHREZVdHZM?=
 =?utf-8?B?OGk2VURGTE5TdjRLaWhUWFM0LzEzcVV2MnNxV0JIeEx3YnhTRjhhM0M2RWRD?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73EF268E9F31FF42884E513222DC245A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc6bb5c-708a-43fe-8194-08dac3071d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 10:34:14.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NTynN0s+8gNOHyRLZM9DDlWONqhco9sD0doyLy6iCoiETt2wl7lP18qKqUpeQxREYoZHS4KWWU752htepjRpQfYReWNA5BA49p7MsLvPLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7148
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG9HaW9hY2NoaW5vIERlbCwNCg0KVGhhbmsgZm9yIHlvdXIgc3VnZ2VzdGlvbiwg
bG9va3MgdmVyeSByZWFzb25hYmxlLg0KRml4IGluIHYyLg0KDQpCZXN0IHJlZ2FyZHMsDQpZdW5m
ZWkgRG9uZw0KDQpPbiBXZWQsIDIwMjItMTEtMDkgYXQgMTA6MjkgKzAxMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwOS8xMS8yMiAwODozNSwgWXVuZmVpIERvbmcg
aGEgc2NyaXR0bzoNCj4gPiBOZWVkIHRvIGFkZCByYWNpbmcgY29udHJvbCByZWdpc3RlciBiYXNl
IGluIGRldmljZSBub2RlIGZvciBtdDgxOTUNCj4gPiBzdXBwb3J0DQo+ID4gaW5uZXIgcmFjaW5n
IG1vZGUuIENoYW5naW5nIHRoZSBtYXggcmVnIHZhbHVlIGZyb20gMSB0byAyLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gICAuLi4vYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi1k
ZWNvZGVyLnlhbWwgICAgICAgICAgfCANCj4gPiAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVj
LXN1YmRldi0NCj4gPiBkZWNvZGVyLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2LQ0KPiA+IGRlY29kZXIueWFt
bA0KPiA+IGluZGV4IDc5NDAxMjg1MzgzNC4uMTY5N2ZlYjFmODU0IDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMt
DQo+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gc3ViZGV2LWRlY29kZXIu
eWFtbA0KPiA+IEBAIC02MSw3ICs2MSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAtIG1l
ZGlhdGVrLG10ODE5NS12Y29kZWMtZGVjDQo+ID4gICANCj4gPiAgICAgcmVnOg0KPiA+IC0gICAg
bWF4SXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+IA0KPiBXaGF0IGFib3V0IGRvaW5n
LCBpbnN0ZWFkLi4uDQo+IA0KPiAtIGRlc2NyaXB0aW9uOiBWREVDX1NZUyByZWdpc3RlciBzcGFj
ZQ0KPiAtIGRlc2NyaXB0aW9uOiBWREVDX1JBQ0lOR19DVFJMIHJlZ2lzdGVyIHNwYWNlDQo+IA0K
PiB0aGVuLCBzZXR0aW5nIGBtaW5JdGVtczogMWAgd2lsbCBtYWtlIHRoZSByYWNpbmdfY3RybCBp
b3NwYWNlDQo+IG9wdGlvbmFsIDotKQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiAN
Cg==
