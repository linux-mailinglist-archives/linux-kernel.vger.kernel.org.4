Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25A6C4703
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCVJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCVJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:54:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D26C62B43;
        Wed, 22 Mar 2023 02:51:30 -0700 (PDT)
X-UUID: 1a157246c89711edb6b9f13eb10bd0fe-20230322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vV0NDr2oufYqqO43r1KHgBxRCA3rPkHws2diI971hoM=;
        b=RN0fUTbxn4WemtxNTfjnGYtvkInV9Y6RPlHJv9OKnan1JQQQvKoQyoBrxZRJYrT3tL52ta+cnmpJA62Dj+6OEtdpRcAWzxEZIagrWuJzHucdJp8Zv7pnC+MsQs2wDmhRImSMi3K9kat7oXC9L9BwX1+Krj3dixiZilymH3P6UK8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bf91e1a5-d8af-4fde-ade3-efa9f12291dc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:05a72429-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1a157246c89711edb6b9f13eb10bd0fe-20230322
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1642467563; Wed, 22 Mar 2023 17:51:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 22 Mar 2023 17:51:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 17:51:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJWeKuksBSo0MuLNmNbGN+LTLUWpYKST+wZrUGRyeyqmVVHtgFvb8vXzlnvliRj1TLGm/ngRRot5mrKFbyLgWTRzylhTDjmwh+OdcRBUKltkOquGcFiGB8qKU9RHYh3d8xhwcOj4cnz+avTny6PjpIL2mMsH8NcYPnWug4jyvER0WK77wx6dE5sURKOM6Q5gp9jdcBYBuHxHYkfaGsUrgCpev5c9tFCkSaWWeV/2zB9K0rOZP/PWLwIGqFRtOmgV7WU6SANy6UU+OIcukMd/J/EkVxW0lr63/NmNC5zOJoYqIdF+e5OOpcc37zRKu2tAMM4VoKoM9LW41UgqYGcjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV0NDr2oufYqqO43r1KHgBxRCA3rPkHws2diI971hoM=;
 b=BhZ3eIXfAPBIWfHv+fOah4GUZxJJJVa3Z2U3CyJesnPytjyvs7rvq1akQZhr+XX5SeNSLtEJIOnNRoqXro3+5wLeSk2UsKocJE/0/ZdDh1pRn3j7C6hJpjxNvABAF5yog8copwAsfnSHpB0LJpWq0/fz6WPloLck2FsiNAJoNkpblRG6eYJH+xCL2U7X2x4RHVZrRFU3oTo+2EP8u1DvSogBV9uqk0BgE1YYfcrdiAJc8n1mHkUuvFfzyxXLv253aKt6zfPuP3/B8J+rn97qDg+NXGZ7BxHumQrV4/Ih6juDtDJmwkM2tg6fIkjmun6Ek7d1+BtlifeAQCx1i804hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV0NDr2oufYqqO43r1KHgBxRCA3rPkHws2diI971hoM=;
 b=f2BZVMBC+uOtmkiTjudkIsObwZqpdwllK6y4rDLHcyno8n50Oek4KQ23zCppuyGcE1LC5cIOiuLTMhgY3pHVbZQVm5ym2OduGPK0gn4guwdXuVf6c8+GgTulZblQG4rQClLwCi86lWhReYakwkByX/N9RUE1L0ZZ9ADIrwESUsA=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:51:19 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 09:51:19 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
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
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/6 RESEND] media: mediatek: vcodec: Add a debugfs file to
 get different useful information
Thread-Topic: [PATCH 3/6 RESEND] media: mediatek: vcodec: Add a debugfs file
 to get different useful information
Thread-Index: AQHZWxbjQYl7aK9YQEaiZBp9e3DFdK8DwDMAgALRUQA=
Date:   Wed, 22 Mar 2023 09:51:19 +0000
Message-ID: <63b1fb1d5e139de56f993fc19541f5c8efb821f1.camel@mediatek.com>
References: <20230320102838.8313-1-yunfei.dong@mediatek.com>
         <20230320102838.8313-4-yunfei.dong@mediatek.com>
         <100a6c2e-f65f-5297-919a-06b8f73444fa@collabora.com>
In-Reply-To: <100a6c2e-f65f-5297-919a-06b8f73444fa@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB6236:EE_
x-ms-office365-filtering-correlation-id: dab8b850-9e82-43d9-c3b5-08db2abafc90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2AknlntAchjUBxwJtTFG1pNbkVD1W9yOzlAAmAtK76Khm2S0G50Tv/snPVve/3jnf2fFBdko+rl++0R5Am/GkjjDE5HcpeRiMrILrAD5+O9KmKGOk5jftITI0FKhN9DbbzlLLImCGaIA5dSQV1Je/XemU7KOsVnkXqTaRWvkGe7YJcU7Gv5fe6oVyqxHVKrlo99rhJHTaFL+HUE9tiVovnlfRNTUwtSjdTtYgy0fEmGXtJN7ubjfIuKJQPauQJJh4J71x0msD1y8KQl6/SGeBlZ2udXABVDp7tlGBdUpqUXOg+p50kE9p9m3i8dl5EDZsejEodttkEabqa4nPwhBUAnIobz6+LqI0fDXqIAu9Xdw0QH2+wgrBPKrV/gRRKVEhr/0nrapid1EgIsuXTTMUJ9Ob/ZYjKTtlKqS5l3Qj9fgLMDLF+a7WNJQAY+X82QYSQxclRIfSpXvib4GWOriAiu4YBApidZy7DnNanf6hvtdN6pDvfVigwXFB5n4VrJ5+PwOB5iwgueg1aswpo28eaLEfMdqBuSjDz6tpDVIFFPElSH+hjCGPI1zLsDgeJvuQP6X3uFlmhHnUEkwBYxIBEXXGSixUZRspPthObPX9wZwL8lKJqx+7UVxL2NfdgeWUFukRzGSYzfa/NJNkb3rkFeXUyxsIY9CsRigz43SKHFJbqgQsqezL1nszkz6nGiBO/axxSTLZJX5GXA3Rm6hMHqd+S6fVrnZ6t6kpol4jM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(64756008)(2616005)(6512007)(26005)(6506007)(6486002)(316002)(4326008)(8676002)(66476007)(478600001)(54906003)(91956017)(83380400001)(66946007)(66446008)(186003)(110136005)(5660300002)(7416002)(41300700001)(8936002)(2906002)(122000001)(38070700005)(76116006)(66556008)(38100700002)(71200400001)(86362001)(36756003)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW9NMHl0WDdEN3pWU3c5SHBRYVd6NFJCRmRZK1doVlVKcjJabUFPRDNoa29u?=
 =?utf-8?B?dXdFeXdvdGdvazlHeWVmSmc3VE0yem9ydHc4QzRvK1FNaE5MQUY5am1CK055?=
 =?utf-8?B?dXJXeWdNKzZ1dkZDaFNwWW5jeFJLcEJIUld2aFFzZFFNQXZGVEd5MEx6MSsr?=
 =?utf-8?B?ajdaR3N6VHB3OCtEL2d3R1ZXMlVzZm94Y2gvaDdYdWdiZ29zYWRzdWFZS0xz?=
 =?utf-8?B?L2JVTGg1RkRTUjhxVmIwMWdPWi9pSGIvZVNjd0tWMjFNbUN1RUlqdTd5VnRP?=
 =?utf-8?B?UHBYbFlOZjBuU0VOZ1B0ZWo3czRiMmRnTEhCUElTWkhBSTB0NmlkQ0E3dm1R?=
 =?utf-8?B?L2ZNTTUybXhqR2NLSWZJdkhBckNOUnpNL25tN3ZPQjQ5ZTYzZlhubEZrZVJT?=
 =?utf-8?B?OW85NmZwcGtPUGMrTFRvUkVONkpCVEdxT1BDZlhSN0xacXlpbVcvS3BZaGRu?=
 =?utf-8?B?aVZiYzZmSzJrRHczb3VhbnF0R1UyZTJtbVkrYlVvbVhtOTgxdVdDMUVLcjlV?=
 =?utf-8?B?emIzc3JVRXEyZkwwWklpM2VTOEpQdXJWZDlSSnNiNlN1amxEQUFFUEE2cUVD?=
 =?utf-8?B?ZU1HbHlLblFsQlkzSmk4TzJBUGJWUDArZ29PWXRGanpDNGI4ZDlMc1BFclFV?=
 =?utf-8?B?aXpYV2dnTmZFTXpzcllEUmhvSitHaCtZU0FpMmR2NmJNTmFITndNUUtneGRD?=
 =?utf-8?B?SmpWcElxRDFFUGZVb2pwYVVxNEVUSWJvdFlTUHlEbUdOQkFSanZnOWpxL0kw?=
 =?utf-8?B?Q2pqWFNYdVJTb2dyZlBhTGNOWE52QTJPTklLV2NDdlJPcFF4Wi9hN0p6RUZK?=
 =?utf-8?B?Uy9EYW40RG1PYlBWSEhlNEwva0p1THZ1dWtzZnBsZWJDRU8xazVETUtsQ3B0?=
 =?utf-8?B?MVc2NnBaakVrbnlYeFZTUVprcjBQWGN0d2tRZ3R5M2NZazVHTzBxRkN4TmlX?=
 =?utf-8?B?VmliTWJvdS9vbDk5TVZnam5OeVZqcnpJZG44VFFJeGgwcHYxMVdxajV6cE0r?=
 =?utf-8?B?ek1MaU9pbjFaMFFWSFBScHJsUVhLa1RPR2swVXZYU2Q5NEtxVnoxTWFLSkNr?=
 =?utf-8?B?TGd0SFpLeFRnVXE3MjE4TFlxRDFYTDh3a1N1NXhtWkV6Rm90SmtUQ1lRMWVi?=
 =?utf-8?B?ZWNkSGJzL3dyb1J3QnB6c0Zwd2lINkllaGc1bFc1b0JLTG92Q2UrelJUYmE3?=
 =?utf-8?B?L0trMGNLZ0sycE1NOTBaajNRMlJPZDV4S0JYN2UwdlArUTFLeWppRTk5MWhr?=
 =?utf-8?B?V0h1N0JLNnhyK2FVcFRaUlZidTJrR2VRSEM5UlV0dGJlamZLMktkREZrRnBW?=
 =?utf-8?B?UWZ1M2hsbU1MeFcrTUdTWVBQU0RJZFVWOG1OdnpnT1VsQ1FPdEpZRGZjVVhm?=
 =?utf-8?B?YVdDOWF3UlpvL3p1SmkyZjAzNUFCbDg0YkhHYmxBR2lEZlhqQWQ3ZnozcXZz?=
 =?utf-8?B?UkxpUGZXVE5YcWtmcUtZUHJ5aGRtY2UvSGZ5cXdGaC9OZmFNdTF3YUQyVmpN?=
 =?utf-8?B?cHNoN2U0Mi93b3ZoY0JWT01ZMlVLYWNOWWs5WEh5TkQzc1llaFh0elk1QVYy?=
 =?utf-8?B?N0prV1YzK0VzczJZVUxUTElhM010ekJMK1VIUjlKUEtDcnhER1BrZVovU0NB?=
 =?utf-8?B?Z3FDQlRFeVRiZklhY00vR0l6TUNkTHJuU1dBRXJDMnNqOW9kMTVkNXhJckVH?=
 =?utf-8?B?STRBdi8veVEyY3FkcDdRSnYvMkN4cmE3a2F6MlZ1dzUyMHIwOFZPZ1VCY1hP?=
 =?utf-8?B?cDg5Wld2L0tRWXNtd0pJY245UXBUOTlpSHJPbHI3SjRlSXQvdzBEUExiRlhX?=
 =?utf-8?B?T2o4TmJTdDFMNmkzL3p0TThmR21GU3JzRDhHNG56RmQwT3dtY3pQeDVOSDYx?=
 =?utf-8?B?RTdXQVhDRWtZbDkxL2paTTZ4S0h2YzJUSWFSek5sVnZxMVVFdnJ6SzdOMHRs?=
 =?utf-8?B?VGlyTGVKUzhqUnQwWVp4eFdkYk9ndkU1bWpabjdHb0R4bVRPR09IZXlXSHBS?=
 =?utf-8?B?Vjd0U2ZoNENIL2hHaEpLbU9IWjNqQTd4M1h6bTV4aktiTEJZa1ZTK3lkU0pm?=
 =?utf-8?B?ckxVNnhJc0dpdnRieTJucTkva2xFY0VoakJSU2JabXpHZGx4WDdzV3hUbTND?=
 =?utf-8?B?NHp3VDhZd1R0YTVoWnlGa08zU3dQamM5UkpLRm1MMmVXUDUzRVc2NFRhOEFE?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0139FE6930330F44AD204E1459D0F7EE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab8b850-9e82-43d9-c3b5-08db2abafc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 09:51:19.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEBAzppkyxGQWpwIi9/PW95NqHuzcDVt0YEr0C2Twmd0JNgUh6yMRyXPalRVJrb8UkBdP+ak8vXmVcHnuIV9IkicJgIVE1UxENdTP6plaF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6236
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBN
b24sIDIwMjMtMDMtMjAgYXQgMTU6NDkgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IElsIDIwLzAzLzIzIDExOjI4LCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IEluIG9kZXIgdG8gZ2V0IGVhY2ggaW5zdGFuY2UgaW5mb3JtYXRpb24g
YWNjb3JkaW5nIHRvIHRlc3QgY29tbWFuZCwNCj4gPiBhZGRpbmcNCj4gPiBvbmUgZmlsZSBub2Rl
ICJ2ZGVjIi4NCj4gPiANCj4gPiBDYW4gdXNlIGVjaG8gY29tbWFuZCB0byBzZXQgZGlmZmVyZW50
IHN0cmluZyB2YWx1ZSBhcyAnZWNobw0KPiA+IC1waWNpbmZvID4gdmRlYycNCj4gPiB0byBnZXQg
cmVhbCBhbmQgYWxpZ25lZCByZXNvbHV0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1
bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4v
bWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGJnZnMuYyAgICAgICAgfCA4NQ0KPiA+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdm
cy5oICAgICAgICB8IDIwICsrKysrDQo+ID4gICAuLi4vbWVkaWF0ZWsvdmNvZGVjL210a192Y29k
ZWNfZGVjX2Rydi5jICAgICAgfCAgMiArDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDEwNyBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jDQo+ID4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gPiBpbmRl
eCBiZWY3OGMwMjhhNzUuLjllN2Q1N2QyMWNlYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gPiArKysg
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2Zz
LmMNCj4gPiBAQCAtMTAsNiArMTAsODYgQEANCj4gPiAgICNpbmNsdWRlICJtdGtfdmNvZGVjX2Ry
di5oIg0KPiA+ICAgI2luY2x1ZGUgIm10a192Y29kZWNfdXRpbC5oIg0KPiA+IA0KPiA+ICtzdGF0
aWMgc3NpemVfdCBtdGtfdmRlY19kYmdmc193cml0ZShzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3Qg
Y2hhcg0KPiA+IF9fdXNlciAqdWJ1ZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1
Y3QgbXRrX3Zjb2RlY19kZXYgKnZjb2RlY19kZXYgPSBmaWxwLT5wcml2YXRlX2RhdGE7DQo+ID4g
KyAgICAgY2hhciBidWZbMzJdID0geyAwIH07DQo+ID4gKyAgICAgaW50IGxlbiwgc3RyX2NvdW50
ID0gMDsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX3Zjb2RlY19kYmdmc19pbnN0ICpkYmdmc19pbnN0
Ow0KPiA+ICsgICAgIHN0cnVjdCBtdGtfdmNvZGVjX2N0eCAqY3R4Ow0KPiA+ICsNCj4gPiArICAg
ICBsZW4gPSBzaW1wbGVfd3JpdGVfdG9fYnVmZmVyKGJ1Ziwgc2l6ZW9mKGJ1ZikgLSAxLCBwcG9z
LA0KPiA+IHVidWYsIGNvdW50KTsNCj4gPiArICAgICBpZiAobGVuIDw9IDApDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gbGVuOw0KPiA+ICsNCj4gPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5
KGRiZ2ZzX2luc3QsICZ2Y29kZWNfZGV2LQ0KPiA+ID5kYmdmcy5kYmdmc19oZWFkLCBub2RlKSB7
DQo+ID4gKyAgICAgICAgICAgICBwcl9pbmZvKCJkYmdmc19pbnN0IGlkOiAlZFxuIiwgZGJnZnNf
aW5zdC0+aW5zdF9pZCk7DQo+ID4gKyAgICAgICAgICAgICBjdHggPSBkYmdmc19pbnN0LT52Y29k
ZWNfY3R4Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGlmIChzdHJzdHIoYnVmLCAiLXBpY2lu
Zm8iKSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdHJfY291bnQrKzsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgcHJfaW5mbygicmVzb2x1dGlvbjoNCj4gPiByZWFsKCVkeCVkKT0+
YWxpZ24oJWR4JWQpXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+
cGljaW5mby5waWNfdywgY3R4LQ0KPiA+ID5waWNpbmZvLnBpY19oLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGN0eC0+cGljaW5mby5idWZfdywgY3R4LQ0KPiA+ID5waWNpbmZv
LmJ1Zl9oKTsNCj4gDQo+IElmIHlvdSB3YW50IHRvIHVzZSBkZWJ1Z2ZzICh3aGljaCBpcyBhIGdv
b2QgY2hvaWNlISksIHlvdSBzaG91bGQgdXNlDQo+IGRlYnVnZnMhDQo+IFRoaXMgbWVhbnMgdGhh
dCB5b3Ugc2hvdWxkbid0IHByaW50IHRoaXMga2luZCBvZiBpbmZvcm1hdGlvbiB0byB0aGUNCj4g
a2VybmVsLA0KPiBidXQgcmF0aGVyIHRvIGEgZGVidWdmcyBlbnRyeS4NCj4gDQo+IEV4YW1wbGU6
DQo+IA0KPiAkIGVjaG8gIi1waWNpbmZvIiA+IHZkZWMNCj4gJCBjYXQgdmRlYw0KPiANCj4gcmVz
b2x1dGlvbjogcmVhbCgxMDI0eDc2OCk9PmFsaWduKHNvbWV0aGluZykNCj4gDQo+IFRoaXMgaXMg
dGhlIHNhbWUgZm9yIGFsbCBvZiB0aGUgY29tbWl0cyBvZiB0aGlzIHNlcmllcywgc28sIHBsZWFz
ZQ0KPiBwcm9wZXJseQ0KPiB1c2UgZGVidWdmcy4NCj4gDQpBZGQgbmV3IGZpbGUgb3BzICdyZWFk
JyB0byBnZXQgdGhlIGRlYnVnIGluZm9ybWF0aW9uIHdpdGggY21kICJjYXQNCnZkZWMiIGluc3Rl
YWQgb2YgcHJfaW5mby4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCkJlc3QgUmVnYXJk
cywNCll1bmZlaSBEb25nDQo+IA0K
