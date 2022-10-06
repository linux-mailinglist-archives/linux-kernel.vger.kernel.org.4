Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2995F62F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJFIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJFInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:43:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961394134;
        Thu,  6 Oct 2022 01:43:37 -0700 (PDT)
X-UUID: 956b613e63c540f0a9972b8ccef4d7cc-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WQkpp/r7JcA9cKkxshHsDydjwe8N8JLOB6ksuTv7iV4=;
        b=Zyv0/VaztmMEUCh6ZnO1gOKwqGWZGl6kov+Ts8fMaU/mkoePncMvkgywrka3v8yb1kuCvRIE+5ddb9v3C/yePEJm8FqzH2T+dHOVdUgSteyNI3regTWHsd0XJuQ7cJhARtKwowkHXLEspHpgkXy84Kko0+I9BDX/HtHYaqSzeOk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:45d4325b-e998-4436-b593-b9178c62b63f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.11,REQID:45d4325b-e998-4436-b593-b9178c62b63f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:39a5ff1,CLOUDID:2748b4b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:221005213855X47Q5YUY,BulkQuantity:352,Recheck:0,SF:38|17|19|823|824|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0
X-UUID: 956b613e63c540f0a9972b8ccef4d7cc-20221006
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1970539915; Thu, 06 Oct 2022 16:43:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 16:43:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 6 Oct 2022 16:43:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y620Xjfc+MvAr9N9kHcxoZU1+/cipoBOqnGQ2pFhhKLCzfcLgoy95/K9C9nRvMCvgVR/ll0DQERZ9mxeaFFidaIo5iJ4W6OVuejs3kEOnB4kE/XUBYg0nDQaiw8ZtKsIraS99bSJpm/jF2jhvxrO9Dxn/pkxXWJjIA1EJENIgxmaXWQhkWDfc13MxKUvCDM6BbnKfNGELP+luWEEQz5MBSRJ8oOck+3KfKPlpqJpuPV7iD6EDqU43plI/hgMfVxfqlA4faL+UWVJTxymMBkSaotQY/IYLIjl1XV4d1GQwhL2fyf+MR5Anhh9yNufoCFY8Ib3OcXujtsiAesH1BU5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQkpp/r7JcA9cKkxshHsDydjwe8N8JLOB6ksuTv7iV4=;
 b=MiQea8K8nZ7OMnhrrKZNE/x1SPqQ+iP/FdCmm6ZCqvfBmS1VbmWK3QCjQYK7Nw4ZKV7xxBERVcRmyKyok124yc0Zrxq9Xsu3Npby91Rk8ghwJWX8szGdTWRbcI6J/Gh7GhV1L0EzIY75Gf2HPzkYH1hwBT1gW5FJgM/WFGf0yRgfa0FsSHo4In0WVBTnhqAhyC4EK7nRzHa3CpVHM7EjIykXiGzkImE0N2nu/xUTrFrhZIuXvssKZPvuvNIYya6TMlMFb47fVZjqcPtcqlqRkGYfhyU00dzj9P3UK/qIhWCYhde8Lz6aDYVuaKjXBpvwI0AIkzZSO7An09/VklMe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQkpp/r7JcA9cKkxshHsDydjwe8N8JLOB6ksuTv7iV4=;
 b=di9iK31eY7auhZ5zRf06AkH2jYtweaETzRbuqltcouEsyqJSGxfUdSynwW1LGqrKc56bVxGXhqnv/lQ0fV67AGtPZ8TdJIYhNssQSZbWiG/01Lex1E9fUhbjVEFZ8tZ6zHse/XQPPWTWni8TlEeaRCOKCjjlqT85lKAhMt/qQJw=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB5417.apcprd03.prod.outlook.com (2603:1096:4:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Thu, 6 Oct
 2022 08:43:28 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Thu, 6 Oct 2022
 08:43:28 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Topic: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Thread-Index: AQHY2K6mQHCZgAmyD0GZh0AOdZkHhq3//yCAgAEM6YCAAAIBgA==
Date:   Thu, 6 Oct 2022 08:43:28 +0000
Message-ID: <6b19843bf0fc6084552f8c71c9a16da21017f99d.camel@mediatek.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
         <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
         <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
         <56aadffa-82be-f8ff-03d3-2a880b50ef49@collabora.com>
In-Reply-To: <56aadffa-82be-f8ff-03d3-2a880b50ef49@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB5417:EE_
x-ms-office365-filtering-correlation-id: c964e700-b17b-4aea-e355-08daa776d75b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qpzs5wD+afxifCXheLCKz2zgvemguztKBJghkH9K2v1gNUzg5zmiKuRkdg9lalikM3yqLfybaYdxuu/TbI8CHT+NJp4Xwde5pUMg4dnpoFYPYCKB9aYDLUOVahlnulssbhUtpOkSkOpiNtcCptqf7X1LWsM5XW6wvYCMTnKQkFpg6hEoSUaufknTQ9+gHW9KWn58lBKN+9whd8ZpPYEWi+6M/nvx8tn75ZTULzDcYZbxqBs+r23zqYGNjci9uX+vr875lRI77VnyBD7J911CWeGvRDX4MBvDlMW5mN/jKzM4XanX18jCS0b3t/p+27e37MJk46cFTf07vfDyydVsu/JswPEFL2G1yUM82tvgMP2xVvetRbzSy7zP0RyFZ87UcAJ30Bm7SzgsANubg7Si4hUm0RbYh2yHnhMIxl/upbKERcGL0ylIr7Qr3C0XcTOZVOCLzkMpvuwhBWtkLEzDqSGVymKM+zLPDOUOm3YefitJAG1XkaLTROL5c5JqoiKSQ4JCgFX/3guO0x6NtDLdvly1l/LFVWR+pYUsDsy3uRU4KbWVyvSUkoHCfAyjfEqxwGV5hFj08yvTECRxx4dLM9jVvQ8urPe2q/kVBDg1Chst2JPkTDZG8kAnBMTyoTBUser3cyVf6u3YzC8JIt+Y8dE6xPBRA5EluDHzARynb/hpxCugA50BwYLJtEqJx1n1Dz6+OAoW9/6LB5TdmtzHYA5fCSYzC43URvO1T37FdUwecBnnYZaNsLnlhsavXUTPdaxL4Gzb5rBkyYgORVPcanqPE4hJxFxmCqJMp2Q8FQK/Dk3Ly63WVMWP7UUDq2Vt9JN+n1NfzLCClu/gh5S76xKK4Po6YdNjrZpMD2qSJ7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(4744005)(5660300002)(38100700002)(2906002)(966005)(7416002)(478600001)(6486002)(53546011)(186003)(86362001)(91956017)(107886003)(41300700001)(122000001)(110136005)(54906003)(85182001)(66446008)(4326008)(64756008)(76116006)(8676002)(66556008)(38070700005)(66476007)(6506007)(66946007)(71200400001)(26005)(8936002)(36756003)(2616005)(6512007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFBROWtxM09nMnR2M2xtb1UxaldYZExWZ2p6TUsyR2ZObmhFZ3RhVm44WU4v?=
 =?utf-8?B?bExncDNwNW5wNmRBaCtKT2NpVk5VU3IxbmdLcTJXMUlLWVpzaDBDNGUxaWRV?=
 =?utf-8?B?YkZuQzJaMnNFYjlUdVRCRDdoSnhwUWNNaDdRT3pDbDlLKzMzOHMwaC9MT1h5?=
 =?utf-8?B?QkFoUDRVUEUxdGZhZUpGdVVDTnNQSjVoVTJjSTJyZDJtckFqclVUa295Z29T?=
 =?utf-8?B?M1k4QWpERDgyREtFQWNUOWFNdjFkeXR6R3kyOE9tWTU2Y2Znc29nYU1FQm5i?=
 =?utf-8?B?MzZZdmtUVU4xaHEwMDRXNUROMzVPZU5YNnZTbi9Nc0l6QUQwZDhjSkhFMDI1?=
 =?utf-8?B?SmMyNnhpVVpHZDY3VDZFMDNSSFRsS3Y1bTRGamw3UnFEd2hYbUI1MHVYWVd0?=
 =?utf-8?B?UTJnenFKTXNkZWx5TGNhTTEyRURnTndmSHEzV1JYa0JyS1JuQnRibFQyTDJC?=
 =?utf-8?B?Z3hTVU5KU1gxQzFmY2VQbzd2UkNCNkUwN0hFbEdBK1JEZ2k5Z3lHZ1FtQTdX?=
 =?utf-8?B?bGNuMmcyK1lsYzJLdUlIcVpkcXI2aDNCMHQ5em9VUVliL3FxWU5SU2ZjbW8y?=
 =?utf-8?B?Y3NSNnVaVDZVZzVkTGRCY2wxZjN6aEJrWXpwdFNwR3ppY1BMc1o1Y3U3b2F1?=
 =?utf-8?B?Q2dFeXNUb3BzOHFCb2xlWkJFV3BXaEpRWXI1Um5nK1RBTWo5NzJzZ0dNM3Mw?=
 =?utf-8?B?MnZhcUdVU2JIUm1uS2svUytOUC9ZK1JVL0tCSGxEeUZyOFREOFA3eGoyREp4?=
 =?utf-8?B?SmljZGRyZU1aZUxiM3EyQ2tONW9vUkNna0ZpL2pTd3BPODhCNXNaREhwVllT?=
 =?utf-8?B?ZjU1bm9pNVNrWHhxNHV2RlcvSzAranJZM3VBc0hvaFU1Y01KczJQNTZXeEZ5?=
 =?utf-8?B?VWhCRXdqcWE4YzAwRGl2WXJ6eTEzcHdqUU1nemRlM3p1VjA2MXUzN0swMjVz?=
 =?utf-8?B?VUE5ODdPWVVmMHN0bS9xNUtjTmU4ZUliMUxybE9LdjdkUHRnN1VCQzFlOU5n?=
 =?utf-8?B?c1RRTW9mbEo2OG9mNnQ4MVZhZjEySVRLdW5EK05nTzFUM0lWVGpBbEg1aEpw?=
 =?utf-8?B?ekpxd3p3SkN1RitGRTZYblZ2ZjA5RnAzS25KeThwUkkya203Q0o1QnRWRlFs?=
 =?utf-8?B?Uk82NWplSW14ZTBhWGRpalZ1NjR1UWkxTC81SnEyVWduZTlmWmVxMHE3ajgx?=
 =?utf-8?B?UWtnV0ZSVXlWT1hpMzVkeWZrQjZyVFhZT3phQUdpd1MrUmlMYWxtYTJiaXRv?=
 =?utf-8?B?d0hzWWhnckNWeWNWWnF0dCtORDNSRGJOUXV1WHRHdjArc2gyOFNYaWVrOHps?=
 =?utf-8?B?NDd6ZXJFc2dZTHl2NVNsbG9PdkFoUmhFK00razdtSDRoOUMzV0NKNkdmVkw1?=
 =?utf-8?B?QVd4V241NDlkbmlKelNnNFN1Q2hvODZVTkh4SlR0V1d5dC95Q0piOXRvZUJB?=
 =?utf-8?B?N2orbldiQVJPWGgzSE1mZ3VaNzA4SlNidTZMY1ptS0FpVytuQkVIbjBrVTJX?=
 =?utf-8?B?ZUFHaGRnWHFjRW9tSit0c2trMHNMandDRDluU3d3R2pTR0tPNXVoaWNQZVk2?=
 =?utf-8?B?KzZBaCtXTFREclY3VW14ZFVEd1ZiV2ZtNHFKM0UvWGZ0VzZYNTExNHNsbkl0?=
 =?utf-8?B?UHNlc1hWNk5wUXRDQ2FFUWRjcnp0NkxvblBPSE5SN1M1VzRyQ1hrUmF2QVdO?=
 =?utf-8?B?L2NtMmpQUTZtWHFTSEZiSnpXeG1jWEc2d3Z4eklDSERjZkcxN2ZCd3ZTaWh6?=
 =?utf-8?B?RUVWQ2Rub3FkZFpWNFRNSzlPNU4rTU1TUXBxZ2dLZm5kUjk4V1E1UzRIV2VW?=
 =?utf-8?B?eXllSFhTbFJ5VWNYSWJxUTRiemNVMGRIZUlrRFlibVRNQVNGV1BWOU5VV3hO?=
 =?utf-8?B?VytsdVIyTnVRVk5DSE53bm1hTUhPVkRHMU1JbGFzK2kreFRQa1RPZ1o1REpy?=
 =?utf-8?B?eERYV0RqY1ZjbUtpR29GUzlaS3dMYVhuWU1sT0tHcWFrM1FCeE1OeDduZTh2?=
 =?utf-8?B?R3hBMEUwZzBzQzFKQVNYYlpGUVgzd2MyZnlVVnR1Tk5DQW5NOTZ4MW1FNGdn?=
 =?utf-8?B?dTFVUGt5ZWp5MmxuMXZhL3RLVUFENGh5bVhiVEV4ZUdVNGJtRm1GeldyclNQ?=
 =?utf-8?B?VVZiWXRTOW5RMXFjVHV6WC9rWFQza2RiSWhjSUpZUnRrVkY5ZWZMMklGdFJE?=
 =?utf-8?Q?BnYQpucowt1Pk4MtccO+XTo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC9AA1B2A3777E4CA249189306C709C0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c964e700-b17b-4aea-e355-08daa776d75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:43:28.6981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1byyQNWbJgVInkXHHw4BfeUFt5/31MNz8qBv4nMRSGfcJECeAJSqDSQw64u115mw6WsR2zhueAGW9lQfweKXe9QhybN6BFtOi6ULpy75As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5417
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpJIGNhbiBzZW5kIGEgbmV3IHZlcnNpb24gd2l0aCB0aGlzIHNlcmllcy4N
Cg0KVGhhbmtzIGZvciBoZWxwIGNvbnZlcnQgc2NoZW1hLiANCg0KQmVzdCByZWdhcmRzLA0KQWxs
ZW4NCg0KT24gVGh1LCAyMDIyLTEwLTA2IGF0IDEwOjM2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDUvMTAvMjIgMTg6MzMsIEtyenlzenRvZiBLb3psb3dz
a2kgaGEgc2NyaXR0bzoNCj4gPiBPbiAwNS8xMC8yMDIyIDEzOjM1LCBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyB3cm90ZToNCj4gPiA+IENvbnZlcnQgdGhlIE1lZGlhVGVrIHdhdGNoZG9nIGJp
bmRpbmdzIHRvIHNjaGVtYS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiA+IA0KPiA+IFRoZXJlIGlzIGFscmVhZHkgd29yayBpbiBwcm9ncmVzczoN
Cj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQyMjEyMTAxNy4y
MzkyMC0zLWFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbS8NCj4gPiANCj4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gS3J6eXN6dG9mDQo+ID4gDQo+IA0KPiBJJ20gc29ycnksIEkgZm9yZ290IGFib3V0
IHRoYXQuDQo+IA0KPiBBbGxlbiwgaG93IGRvIHdlIHByb2NlZWQ/IERvIHlvdSB3YW50IHRvIHNl
bmQgYSBuZXcgdmVyc2lvbiBvZiB5b3VycywNCj4gb3Igc2hvdWxkDQo+IEkgZ28gb24gd2l0aCBh
IHYyIGZvciB0aGlzIG9uZT8NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0K
