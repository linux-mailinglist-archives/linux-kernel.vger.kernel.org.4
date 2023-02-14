Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2D6956B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBNC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNC3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:29:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64711A25D;
        Mon, 13 Feb 2023 18:29:30 -0800 (PST)
X-UUID: 65537d6aac0f11ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
        b=QtLmOT3zgMDbMkrdc7Dw5QVhanBKlXEcJppcFkCMfhtLUesH7Z/loyehW2UcocJ167Ya+JLOjFqq7W9JeHCKF/cKYjpUYYsX1eygiZxPx1EWT891fQBCuMft66iuDos1EwSxhllEji9E6JgkbwoaueWq+DqDdBxMP1f3da4FXm4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:f7760f65-8a2d-488e-a713-78709a0b27d8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:f7760f65-8a2d-488e-a713-78709a0b27d8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:3c385af8-ff42-4fb0-b929-626456a83c14,B
        ulkID:230214102824KM0OBT5U,BulkQuantity:2,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 65537d6aac0f11ed945fc101203acc17-20230214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 355896790; Tue, 14 Feb 2023 10:29:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 10:29:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 10:29:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6HgtIF3/qU0imCXsg/WBImkA519KMyOkmYVeuAWCCjuoJrNStR1+TLQfG5QaRV9aTP43btyUq7ymfZTxBB4eJdzajtpHQsXquRljpka9VJLtWiyBQhG8hWwr7Emb2Qw27e6y11A/c5NfhqbNPNPIWbXHqO4HZ7GmKIiE0vWbrNZPWNuX2BlDGIfalhaUdcZQQysntM96qCRFEV/aijCW96hh5MCJr62D0932d+0K5CKINlrxa0FIkY/gqN7EQhbISoVtpAiQWcFzyBDHv63REcxJKixw1Tdqjazx9otimbFlQ5p0Rpdd+u2fL6eH75Kzubv5mMwmhukuWGHHtSK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
 b=lTQE0AgwkaHtXcoDsj7DicLYEi+ihcy77sA5gW9gQ6SFFMdyZkn35cXNk/11b/S8eXWLhr/08gP+whk50Feb6CF2PD8H7iy7rCH9cmNyNisZvpI/ZKbcSglrcltJgRJLpZW5OE5TInPESyTGVM/COv30D+N3Gc+PgbxGYcRfx5cJOzhNZlunuzvHQuCfcjdroyLYmZGNvI8xNqet+KWO88qZuVvV2lYGrizvhUH6q9fsudHIAsB28+8J02EYaYDZQ6CekKaHR2GLeS++AcoIP3CX4DmpfTQo9nX2y/t0aWnfxuoPngZH+Z3A5PylGIOVFM54tSW+dt65bBmj+DRQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2lUaAzsoS3UMQhehsgLv2yKw7D171s4I+4qtjDaFx4=;
 b=MR1Yhp3+/rh+Fo0oSu4AVvz3InwFjq5fCHvtwWw9UL0IHCvrI2Xpg1y9dbSqd0+sdALW7a7r7BnRUwu3SiAH4d9Y29XTaSQZEf4TDqldZUxXZoK7MTx0Ssm1KOsxZHbYa87R277tAUiUVaeQr2vEdLqo291uhTic8/PeXY5OSog=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB6386.apcprd03.prod.outlook.com (2603:1096:400:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 02:29:20 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 02:29:20 +0000
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
Thread-Index: AQHZPRRh7fZS99I5qEegpearM3gM+67IULWAgAVtZYA=
Date:   Tue, 14 Feb 2023 02:29:20 +0000
Message-ID: <e647eb5f8a3bda455db839f0672aa77f984d4e9b.camel@mediatek.com>
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
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB6386:EE_
x-ms-office365-filtering-correlation-id: 0afdd87f-998b-42bb-3539-08db0e334744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6gEbluHvUv55LM3RZ9OLkAVXRHDKkQ5vxoO19Uc5hPcSWo3BN0TaP/7gM0EV9KGjPz49NLPI5NBotK1UZzyI+djpQIjocbXjMv+dnDQwQB+jgoWI8/F5K23YpBYlA1zLRymxiV5MwQPaX3+YlvI+iK7W20Kk3V2doq+x2qdWHyLT658a+LyMsW48eocd2jBjWPKM3qgGKQ9SBuP1Zl0ovoE5svcDU3VKSWfHnIR2RePRZFXv3Y0R/vgTc0ENfpjBdRgPw9cMJRYVTsF+fym5F7UU7jqacIqlzkKcxfLjz/aJ7ifW1cRju7CtHA4hHTT2qKMXalbnYB2cfnm+jNB0CTbHBOlN6SBty+7qWju1Zy5UwKuZFmnV7HDPCucrfvflIXqd6I/6K/yvJf0mNR74C//rQLiRp1FCxWVram6l6TQrGcmUNXYvuqI/BtCu0dJ0TxaRIirhxCVCD6VBm7eQqkJgEOM/kx/ZPQcptJuJWorsstk7wD6pzNIc484fZHQl6zVb0iCOtr6XDk/SPa+qy9PDXXLw9d5Efz2HwKALFNebfMbioaXM52BnjbjNovxNNtjMQqER4UpWcq6jLlaI97dANqdPMVZ+7Bhnrn7KtdMsR8E85WAXUtfwOdZ6NilGpaBMjWRaPsDbOR5t0cHjXJ71+H5qYZzWvNS8/wAvN4/PtI4ZJnZg6uoeNbFWsadhFCIoc/27RccGrkQDmPbcKfPKWSmj2DIcOGiQZR/4A1c5fPssaI83V2ZXRKec7tPfpbAjfCEwp5MdZUpy+y7Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199018)(71200400001)(478600001)(2616005)(6486002)(66574015)(54906003)(6506007)(110136005)(186003)(316002)(6512007)(26005)(91956017)(66946007)(66556008)(76116006)(83380400001)(8676002)(66476007)(4326008)(66446008)(64756008)(41300700001)(7416002)(36756003)(8936002)(85182001)(5660300002)(2906002)(38100700002)(122000001)(86362001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTk3Z0UzWXA3aU5wTmhtZ2VpbkNaN0NHRll4YVdESGpBNDl1ZnZGYkR5ejdx?=
 =?utf-8?B?Z2VhaGVwVFZIK3F1Z0xJeThUczZwVlZUS2tIMVYvUkxPd01rTzFqRTdTT25N?=
 =?utf-8?B?dlB6V1ZqWXNqNUpRcHM0d3Nra29aMGd3MEtqbDUwNTRZMU9Kb3hiRkpKcER1?=
 =?utf-8?B?K1pIN0lUSTZGa2ZwYVBleVNzL2F1Q1JZa2pXTTVhWkdLb2kwVmc5S1duaUVL?=
 =?utf-8?B?L00ra2tPV09jQld4OGNsckExSG16TWRUcVVlditYb1F5ZGp3N2F0ZTk3MGZj?=
 =?utf-8?B?V2o3aEFOQ1ZhNXZNTEhGT05WUExVR2hHSXNydDhHUHQvN2FISDRqYlNyUlp0?=
 =?utf-8?B?bEFwV0xMWkdsQWtJYkd4VFh1MFl0VURxZ2g5RVRDQ2s1U01xeFFkV1ZxWmJH?=
 =?utf-8?B?UWlLVmxNcXdRODBXUmZmS0tZYjhra3A5RG5CQmZwWXRlekMyVmlpVlpTUHNK?=
 =?utf-8?B?blVyck1aUDNwU2Y1SWxpR0x2OHk2TmdBSXRvZ0laY1lpRHZlOEhHRjVuTDVN?=
 =?utf-8?B?anRsRGZQM1lzdFVsdzU3bDNjaFBWZHVoNkNBTlkvOVR4ZytUTk9ObzgrRDBu?=
 =?utf-8?B?S3ZTVG90T01mNEk3UFdyNVQzMk5mZzNBNlg2TlNGNTZsY09uUzNyVUI4NlMy?=
 =?utf-8?B?T0Q2TzFQRlFFczF0aWhZSHQ1N1lYbkk2QXNGcFpINFJ5aEdIWkhRUWdsNnpF?=
 =?utf-8?B?UlNJTmlBaGdTL0NKNm5mSGVSK0kxb3U1V3laVzJlengrZ2thenRiLzMyTGdD?=
 =?utf-8?B?ajIxWEg2TzBwYm5mdlR6blFITGhxMWtrVTQwZXZQZno3ZHdzcGdMenZSbXFh?=
 =?utf-8?B?SDc2UTBpTTJCN1hpMmxpVjYrQjNrQmdRV3BJNzJRY2sraVRuc2JHNm1wdk93?=
 =?utf-8?B?RldQei9FK1RnTys3Y1lYeDNCZUVkV1JUVlJOQ1R1aGlSSlhtOThMTUpoSGlM?=
 =?utf-8?B?L0NIcUN5NTJ5amZFcEU2L1NKZGdvaFZDQmN6NmxwdHZWaVlCSDg3dzNORDM1?=
 =?utf-8?B?R1ZBTHFOWGxRMjN1QWx2T1RpakJRYndoWlRmMW1Ka3dhaGJtVldMbmdLczNh?=
 =?utf-8?B?NHd5djA5bG9ndkFHUTF3TmhnWFloTWY3TEZqQXR2b0hBZ0szeDdGbFI4UERt?=
 =?utf-8?B?Zk82U2VkeTRWYkFwaW9TeCtmRjVlTExaL1FydDYxa0xpTk95TTRSdnB5blNy?=
 =?utf-8?B?dkJzeGZEUU9ESG15R0RUUWEzRGJxVjNUdWJuQ2ljNFZEMThTUzVUSVdVTXNR?=
 =?utf-8?B?azFGNjZUN0ZkZ1JJUXJ4a1h2b3NNMXErN3FhSU14Q25UYzIxR2dzNlh6T3RJ?=
 =?utf-8?B?VGVMb2JvOExCZ2RlZ2ZqbTRWVXpOVWttK3p5RTI3K0I4UVpuOEV0TFd6NkxE?=
 =?utf-8?B?TWY3eFQyRzl3WGZyVWNNZzM1QmV2RUdLWUdDb2p4dXZwbURydjNDUGc0N0or?=
 =?utf-8?B?Y0tlMW0yMmlEbHR0QjAxbkI0aXcrRDFYdGFJVjR2SVFjUU9XZXRWUWUyRjRE?=
 =?utf-8?B?Qnp1NzFvZ2wvWGYwVDdNYUNUOWxIT1MyeWVyZHhJcUNrcEp1Mk12NmJjYUJw?=
 =?utf-8?B?OGRXRElaSHlTaE42STJYY2thTVpmWVlpQU1DT2EzaFNLdUZWMFpoTHZpdjhn?=
 =?utf-8?B?ZDdCZmk0Yy83TExKSjJBOGptTDVVbzlVa0F4blVNaFlQZndzVm5abU1wVHlJ?=
 =?utf-8?B?VCtWTnNCZ0N4M2kxYnRCSXdZOXMrV3NsazJXMFRzclhjbm81RXZFRWVGcDQ3?=
 =?utf-8?B?aFhWejk3aERIbEhRS2NwZThtMEkxdmRPWlBCazF6Yk4wSFVrUE42c0dZenFh?=
 =?utf-8?B?c3BMWTRwb2lZUzVxT1BWcGY2QUMxWmFBUjFXTUI4MWFHakdJTzdTMXp5UWFa?=
 =?utf-8?B?UlVmMlB1ZzhQN3VXSGgxdUtwei9QMnpxZkRuSmdRMUNSNnJCY1VJeTF0RDVt?=
 =?utf-8?B?UlVydVFUVC9GZzZ3THlBcDk2Mng0S1NiMlJRSDJsK2xielhLV25NU2h0VDFa?=
 =?utf-8?B?NUlkSUpkZ3BQZ1ArT2lSUGVDZldYZHFRendyYWcxT21mYkZzY2dTMW8wakhL?=
 =?utf-8?B?Mm16Y28xVmFVRHN1S2ltd05UdWgzbmJERFRWVFdCWTZWRGRneUcvKzB5KzBP?=
 =?utf-8?B?aUU5SmhSb3pTUGo5Q2wrWVlrNGlxY1FVQ1hzZFZVakxrNnhqUkRsb2pvdjht?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2441FEB7B250642A75FE165D73C0DCF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afdd87f-998b-42bb-3539-08db0e334744
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:29:20.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0QIY4e44EmqHhgpI6QCont7dTUxit8rUfded9hKA0eUcY8PoClGOfKd2zlAtGSzJaZuG4wpeSDfsW21sgvv4AhBLI1SOaSQ2sFqLXI88TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6386
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

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBGcmksIDIwMjMt
MDItMTAgYXQgMTA6MzYgLTA1MDAsIE5pY29sYXMgRHVmcmVzbmUgd3JvdGU6DQo+IExlIHZlbmRy
ZWRpIDEwIGbDqXZyaWVyIDIwMjMgw6AgMTM6NTUgKzA4MDAsIFl1bmZlaSBEb25nIGEgw6ljcml0
IDoNCj4gPiBJbiBvcmRlciB0byBjb252ZXIgdGhlIGZvcm1hdCBvZiBjYXB0dXJlIHF1ZXVlIGZy
b20gbWVkaWF0ZWsgTU0yMQ0KPiA+IHRvDQo+ID4gc3RhbmRhcmQgeXV2NDIwIHdpdGggTGlieXV2
LCBuZWVkIHRvIGZvcmNlIGNhcHR1cmUgcXVldWUgZm9ybWF0IHRvDQo+ID4gTU0yMSBmb3IgTGli
eXV2IGNhbid0IGNvdmVydCBtZWRpYXRlayBNVDIxIGZvcm1hdCBhdCBjdXJyZW50DQo+ID4gcGVy
aW9kLg0KPiANCj4gUGxlYXNlIHJld29yayB0aGlzIHRleHQsIGl0IGlzIGhhcmQgdG8gdW5kZXJz
dGFuZC4NCj4gDQoNCldpbGwgcmUtd3JpdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIG5leHQgdmVy
c2lvbiBhcyBiZWxvdywgY291bGQgeW91DQpwbGVhc2UgaGVscCB0byByZXZpZXcgd2hldGhlciBp
dCdzIHdlbGwgdG8gYmUgdXNlZCA/DQoNCkxpYnl1diBpcyBvbmUgc29mdHdhcmUgbGlicmFyeSB1
c2VkIHRvIGNvdmVydCBmb3JtYXQuIE9ubHkgY292ZXJ0DQptZWRpYXRlayBNTTIxIHRvIHN0YW5k
YXJkIHl1djQyMCBmb3IgTVQyMSBpcyBjb21wcmVzc2VkIG1vZGUgYW5kIE1NMjENCmlzIHVuY29t
cHJlc3NlZCBtb2RlIGF0IGN1cnJlbnQgcGVyaW9kLiBOZWVkIHRvIHNldCBjYXB0dXJlIHF1ZXVl
DQpmb3JtYXQgdG8gTU0yMSBpbiBvcmRlciB0byB1c2UgTGlieXV2Lg0KDQo+ID4gDQo+ID4gRml4
ZXM6IDc1MDFlZGVmNmIxZiAoIm1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBEaWZmZXJlbnQgY29k
ZWMNCj4gPiB1c2luZyBkaWZmZXJlbnQgY2FwdHVyZSBmb3JtYXQiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5vcmc+DQo+ID4gLS0tDQo+ID4g
Y2hhbmdlZCB3aXRoIHYxOg0KPiA+IC0gYWRkIEZpeGVzIHRhZy4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYyB8IDQg
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBpbmRleCA2NDFmNTMzYzQx
N2YuLjRmNWU5YzIwMjE0ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+IEBAIC00MSw3
ICs0MSw3IEBAIHN0YXRpYyBib29sIG10a192ZGVjX2dldF9jYXBfZm10KHN0cnVjdA0KPiA+IG10
a192Y29kZWNfY3R4ICpjdHgsIGludCBmb3JtYXRfaW5kZXgpDQo+ID4gIAljb25zdCBzdHJ1Y3Qg
bXRrX3ZpZGVvX2ZtdCAqZm10Ow0KPiA+ICAJc3RydWN0IG10a19xX2RhdGEgKnFfZGF0YTsNCj4g
PiAgCWludCBudW1fZnJhbWVfY291bnQgPSAwLCBpOw0KPiA+IC0JYm9vbCByZXQgPSB0cnVlOw0K
PiA+ICsJYm9vbCByZXQgPSBmYWxzZTsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgKmRl
Y19wZGF0YS0+bnVtX2Zvcm1hdHM7IGkrKykgew0KPiA+ICAJCWlmIChkZWNfcGRhdGEtPnZkZWNf
Zm9ybWF0c1tpXS50eXBlICE9IE1US19GTVRfRlJBTUUpDQo+ID4gQEAgLTYzLDcgKzYzLDcgQEAg
c3RhdGljIGJvb2wgbXRrX3ZkZWNfZ2V0X2NhcF9mbXQoc3RydWN0DQo+ID4gbXRrX3Zjb2RlY19j
dHggKmN0eCwgaW50IGZvcm1hdF9pbmRleCkNCj4gPiAgCWNhc2UgVjRMMl9QSVhfRk1UX0gyNjRf
U0xJQ0U6DQo+ID4gIAljYXNlIFY0TDJfUElYX0ZNVF9WUDlfRlJBTUU6DQo+ID4gIAkJaWYgKGZt
dC0+Zm91cmNjID09IFY0TDJfUElYX0ZNVF9NTTIxKQ0KPiA+IC0JCQlyZXQgPSBmYWxzZTsNCj4g
PiArCQkJcmV0ID0gdHJ1ZTsNCj4gDQo+IFRoaXMgbWFrZXMgdGhlIFZQOCBhbmQgdGhlIG90aGVy
IGNhc2VzIGlkZW50aWNhbCwgbGVhdmluZyBhbnl0aGluZw0KPiB0aGF0IHRvdWNoZXMNCj4gTVQy
MSBhcyBkZWFkIGNvZGUuIEknbSBub3Qgc3VyZSwgY2F1c2UgSSBjYW5ub3QgdGVzdCBpdCwgYnV0
IGl0DQo+IHNob3VsZCBpbiB0aGVvcnkNCj4gcmVuZGVyIE1UODE5MiB1bnVzYWJsZSwgdW5sZXNz
IGEgbmV3IGZpcm13YXJlIGhhcyBiZWVuIHN1Ym1pdHRlZCB0bw0KPiBsaW51eC0NCj4gZmlybXdh
cmUgd2l0aCBNTTIxIHN1cHBvcnQgPw0KPiANCg0KSWYgdGhlIGZpcm13YXJlIG9ubHkgc3VwcG9y
dCBNVDIxID0+IHdvbid0IGV4aXN0IGZvciB2cDggbmVlZCB0byB1c2UNCk1NMjEuDQoNCklmIHRo
ZSBmaXJtd2FyZSBvbmx5IHN1cHBvcnQgTU0yMSwgd2lsbCB1c2luZyBNTTIxLg0KSWYgdGhlIGZp
cm13YXJlIHN1cHBvcnQgTVQyMSAmIE1NMjEsIHdpbGwgZm9yY2UgVlA4IHRvIHVzZSBNTTIxLA0K
SDI2NC9WUDkvQVYxIHdpbGwgdXNlIE1UMjEgYmVmb3JlIHRoaXMgY2hhbmdlLiANCg0KV2lsbCBm
b3JjZSBhbGwgZHJpdmVyIHRvIHVzZSBNTTIxIGFmdGVyIGFkZGluZyB0aGlzIGNoYW5nZS4gDQoN
CkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+ID4gIAkJYnJlYWs7DQo+ID4gIAlkZWZhdWx0
Og0KPiA+ICAJCXJldCA9IHRydWU7DQo+IA0KPiANCg==
