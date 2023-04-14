Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701C6E1E73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDNIgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDNIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:36:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CA119;
        Fri, 14 Apr 2023 01:36:14 -0700 (PDT)
X-UUID: 61884e2cda9f11edb6b9f13eb10bd0fe-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hzS5reuGaYb0FMofKpFjZkq/yS3hlFyFtT7pYR/jYfc=;
        b=cjcedsQvRvkVgPefm+u7hbzDzwY2jGhjf5GITbjHQypMGYVa85yE/2KKjwdQ9tjS0aWrH8yJmlHaapX8ADLdxPs/MXgDToNxArIkTnoSK/uLzNkBI/ebQm0A+9ACuDrjYq0eG6kuhcqnl/0B3D4NSO1YSHKIG/PBSS+xU+thNRM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f9655fb0-c504-43fd-87ca-2f07b60bdce1,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-INFO: VERSION:1.1.22,REQID:f9655fb0-c504-43fd-87ca-2f07b60bdce1,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:20
X-CID-META: VersionHash:120426c,CLOUDID:3db90e84-cd9c-45f5-8134-710979e3df0e,B
        ulkID:23041321051153L2P2LY,BulkQuantity:16,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 61884e2cda9f11edb6b9f13eb10bd0fe-20230414
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 853416407; Fri, 14 Apr 2023 16:35:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 16:35:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 16:35:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ7z80umNhX/x7PTsZ/o6IFYLsXtpuzkZdaXrZNKWajWUU2ZF7B1+rstv1I8yGOhEEnB4nRRhy/6/1Zc9ubaMXvidqbVapApAvZ2vSIxFNQT6kuMQRLRpvHzoCGyH2tNgD7uCxX4XTqlN4e2sESKYKGyPs7eJb1qZKcYZVqmCtEr7+mRFEFkzwS7T27MiplslqL0GdXvPx61hFhAXR0lbUcMU5lsfcaCHflNlYgRIpnzvIkkq/b8VHCg0gRDKp6xceCm17RFYCwyo4RXZyW2UywB85gRikgLqSZGNqE/yDeJz1FBRSvOUIwCPD0OfwHUNTrelR+FdlWIS6CHS701lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzS5reuGaYb0FMofKpFjZkq/yS3hlFyFtT7pYR/jYfc=;
 b=nK91guGm9Up/LqNWK21siigJgL0ZQEXBIvyU8GOJDd3dPNP9FGp//8q9HqxAMt8jIGmeP0B9k04gG5O0RGBqD1lSITrUtKYvjY4/VP2h4+cnI5d+zVYScfwRG+l3ZEsZK4e7cqj61M3PdnUteE2Tg+MO8z/KFLih+Z7Vl+hw3eqwCbytyjwEUjCL9vj4PcwhluvUdDpS22wHQt+CUTlc8td90aEZnKWxTUwGzDF+GvSd+IeyW6SEyozsUzvJi0kdvL3Lig6lH435cZR2vZF7S5S9q1JE5smsyfkb3QwSni7LjI/2SMhPphpx9cfJFYJG/196c9fVdVwhubkBjfAUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzS5reuGaYb0FMofKpFjZkq/yS3hlFyFtT7pYR/jYfc=;
 b=osIx0LTP1PmwyCYwJ50olWg5OxWmBaQqtBQZyQPHhy+UHGgOi6tuhK6h/p+jiqtSlA1yamsfTk/MV1PMkiPtgMyEIjWYWuB7FqfsyjRnfkQpFP/HRi4HYiQftSD3jabBEpPANsx+v6t8bQah330Y3dabR0SX6o1mWnGNxS6GGxA=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SG2PR03MB6429.apcprd03.prod.outlook.com (2603:1096:4:1c0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Fri, 14 Apr 2023 08:35:54 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 08:35:54 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Topic: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Index: AQHZbeeIpBD7nBGd2ESOfkL+LicR1a8pNVKAgAFHHoA=
Date:   Fri, 14 Apr 2023 08:35:54 +0000
Message-ID: <7b4492efa4a1becbdfb79d23a0a0c0fe11dba5f4.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-3-yi-de.wu@mediatek.com>
         <8ace9b0f-742a-7ebc-555f-1f8be04a5955@linaro.org>
In-Reply-To: <8ace9b0f-742a-7ebc-555f-1f8be04a5955@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SG2PR03MB6429:EE_
x-ms-office365-filtering-correlation-id: f87db165-e2a1-4850-8a4d-08db3cc342ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HBp10gVCBLnDhiTpYmZw2YOkEb4zdKv+nbTzuVJPewIatK/VF65iknNWASgCpyYHP4DLx3BQuQZCoyYpxm8AUNwKsqhSaon3eydzvSrG87+ezNTksLjsb16LNUI3sx7jut7bP6ULoG7IiwCiEsBT57q6O7J/Np4Vf9FAydmjjb54PynKqo8QfSP1fqBX8wCac+mg//XI8a+bWMYmpLSJVquwIhazoe6aKBrtF+uJwlbtZNPKN/2/OB2lfK3M6NLnpOCeWC10f5paVehiZijtfMhGzIsXSoEOnv7uIHfI2OwJz18qmRRFHLK84XnXrCiW3wH7jtbEva9m3P+y/NHHp0vJto8v8Ar4TRWYbRnJv8OpPtuP76GLkl+a42XVdCHPDqZM55UZiujdjNpbk56j7S9xqR4eY6SY4nSuUUGozpFx3L1Exo5vhnTHYeoG+gfK+6kKLBintU6AFjkPGIXAXPbHldfNq2y1yfD4EaH4TPJivjhF1YQBOUpDy+j5IfV5zk/FA/jWksSpdeZhY8uoRMm+zSDtOAa8cKXV6xw48D+82Y2qEt03kViE9T5nv/ejzUioIjUSDDPoS8ydQ2xoThKB+wJY+8IiYTFxTQUXGsoYpdNwE74SYYfRYo5YaK/rXP9//rjkZ82P7mhZSB16A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(478600001)(41300700001)(91956017)(86362001)(316002)(71200400001)(76116006)(64756008)(66446008)(66556008)(8676002)(4326008)(66946007)(66476007)(110136005)(54906003)(8936002)(6486002)(38070700005)(966005)(7416002)(5660300002)(2616005)(186003)(36756003)(85182001)(38100700002)(122000001)(53546011)(83380400001)(6506007)(107886003)(26005)(2906002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnpkcnJTUlovOGVVNE10bC9DSHY2V3orc0ZhMURwdmtsUCtDc2NNRFBUSm9E?=
 =?utf-8?B?cldHRW13M1diZmdaRkRtMHc0MVFhMmtXMkFWTVJwajNyK3NjL1YvbXY1SW1M?=
 =?utf-8?B?YXQvR0M5enZJbERWWXM3NndIdXdXRmR0UmU4TUw4Z1ozOFJmWkJvbWFqeUNn?=
 =?utf-8?B?bWpPLzB4SGlYeENQbEVIT3VlL290Q1lnWEVXZmNkVlFvUWxrUmo0SkFrNU5j?=
 =?utf-8?B?bkhGZ1JkRXBwZ1EzYUMwd1dXemhrak1zYU90WGU3aFhVc0tiTjU5K3pjT05K?=
 =?utf-8?B?SUdvNUlYbUF5NVRJNmJvUG9ucCtoNks0Mm1rTityVkRIT3d3QXZzOUEyalAz?=
 =?utf-8?B?MSs5R2kyZEtHSkNpQTZ4ZHhLQnA0NGdBYm9wbkd6NDVCSUFGMmNMNkJsb05h?=
 =?utf-8?B?cDZidmE2R2VVWS9vbzRoZjlRS3FudnN2aklqSGphWUpzUXZ2TG5ncGVYeWpx?=
 =?utf-8?B?QU1Ec1Z6Y2hVTHcwTDVWdGFLamh1NzFBaTJlalVhMVp0ZmRxZ21KQmUzaUtq?=
 =?utf-8?B?aUFnUFFDYVczMklDaldZNGloOFdsYm9Sc0RLamxGN3RrR0k3Mkl3ZzFyVHF3?=
 =?utf-8?B?aVZHaTFlbjlKbFRCaTBhU2tGZEM2eTBLV25oVExxTjkvK0hPNXpXUTV4d0o4?=
 =?utf-8?B?UmcrRmhRN29nbURNZ3p6N09GQzFMelFLTnRIMDNpM2s1YzROMzJ2WHBuNUVU?=
 =?utf-8?B?S0loemlQQWJSOWtHMmRhNmF3ckFjYWJ5WUM2QjJtYklWY0ljb1dicnc1N0Z5?=
 =?utf-8?B?by9Kejhacnkxd1h1OXZzaEx6eEEwZTlrMDNKN0RiZzZHb2hwOW5uVmJNcG1v?=
 =?utf-8?B?UldpV0dtTUp1b0h1Z0JYVWZPaXlMWGk3a2QxMmY4L2dubXZHODVuZWxuMUk5?=
 =?utf-8?B?RHNocG5JalpOUlBiaFBZZkk5R3Q4WG5yUGhkY2VFRThYOFM5cmVibmdnS1dT?=
 =?utf-8?B?cWE2OEFwNjl4ZGV2Q3Z3YUx0dGxjWUNuR291UVlpdnJQQyswWW9ibHhPZ0Ry?=
 =?utf-8?B?TFNhbDN1MllPTXBWVjQ2Zy9kVlhNcUcxTURQZVBTbS9vZWlYRXpqVEVqTHVp?=
 =?utf-8?B?bGpBdWhEcjVML0J0NFFGTzNCMnQvYi9PWThyWmsyeWlLbWJhQ3RmdWorQ0dO?=
 =?utf-8?B?QnQ1VHQwUC9vR0Q5MElWOUg1Wmk2SlZ0MDRPb0ZTbTA1MzZxQXgvU01XSkx5?=
 =?utf-8?B?QmNsNDFqeHNRUlorV2dyLzhqWFFKNUZQNmlNeFBFUk80dGFVeGhpK2RmQmx4?=
 =?utf-8?B?ODg3bUc1bTRjcDhjTzdTNGpQM1ZBQ3BQdUF1T0psYm1zUmt0aW9zN21SdDdB?=
 =?utf-8?B?WUxuNnRSSlFnMmtJeVRtUEQrYk54QnYzSlg1YjRUbmN5Znptb2ZrSmVSV2d2?=
 =?utf-8?B?YWl6T1hOOUxZVnpsN0dvR2l5bE4zWXowR3YxNmZwdEdqNVFFbU1HS0NDS2xR?=
 =?utf-8?B?di85REpMYmdsNHNBTGpkZm43MVdIeC80eWI0N2g5OTRlQzhnMjVpdWNwcWY5?=
 =?utf-8?B?bU9mSzd4dzg2WlM2VVdZSFByOEZiZVc0N2I2MGt3L3lZbktRNzMvYTJIT3VR?=
 =?utf-8?B?dzN6SG03c25GbXR5dk5Ma2NCV1UzMVJnbVhvV1Rvd0dadnVpdVlGL3Z5MUha?=
 =?utf-8?B?T2oxc2V1WUNBeUxSYlVjMnFubVBlSWtEa0xIOUpQZWU0OGx6aC9tRTlWM2Np?=
 =?utf-8?B?RndkSUV5c0xLbi8vQUdJMWpwOXQzRDJPenRoSEZ3U2paa0M3N29VcjB3TEl3?=
 =?utf-8?B?NXNtOWZyemlBUkFQS3MzTC9ydWNHUVBiZW1IaU1KejRuNEpiOHMzZm5qbEp6?=
 =?utf-8?B?bnd4aTd0S1BzN1Baak85YUdzQlJqQVB1ODhkNWRJY2VDU0xQWlVYTUJJblhB?=
 =?utf-8?B?VUd2ZUVpVThPVWQxVjNxa29OajY0a3FDQXNWZFI3OHhCa01NcGsvbEFpV1FP?=
 =?utf-8?B?R1F6RndQWGNDakh6YmxTMFl5cTNhRUJwRmcxR2gycmgyVzBsNzBVYisrY1JK?=
 =?utf-8?B?NEVJYStxNUVhWWNRdXN2dHZidmV5ZEVIa1lWbWRrMDl5YXlOMjNROE9IQW1F?=
 =?utf-8?B?THlIbzR5bU5sR0JjcnhZVnl2blFibVNRaHFTTUVUR2l6dEdlYXRTdGZEWWhQ?=
 =?utf-8?B?Qm0zYzczWmRiK1c5eFcrRU9UdExGamphNUlKdnlBQVRSTkFuVTUxMWlFTExy?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <370F42C2967AD04FBD1626E0DFFCB2F9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87db165-e2a1-4850-8a4d-08db3cc342ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 08:35:54.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ippK02RayDUW6ZGqTRjIMMdB98La/SFKEQ0LEgFHsi9Tz73Vyn+JdHrwCbGHTlIzw4iToShuFz4wIuqybthkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6429
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDE1OjA1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDEzLzA0LzIwMjMgMTE6MDcsIFlpLURlIFd1IHdyb3Rl
Og0KPiA+IEZyb206ICJZaW5nc2hpdWFuIFBhbiIgPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgR2VuaWVab25lKGd6dm0pIG5vZGUu
IFRoaXMgbm9kZSBpbmZvcm1zIGd6dm0NCj4gPiBkcml2ZXIgdG8gc3RhcnQgcHJvYmluZyBpZiBn
ZW5pZXpvbmUgaHlwZXJ2aXNvciBpcyBhdmFpbGFibGUgYW5kDQo+IA0KPiBTdWJqZWN0OiBkcm9w
IHNlY29uZC9sYXN0LCByZWR1bmRhbnQgImJpbmRpbmcgZm9yIi4gVGhlICJkdC1iaW5kaW5ncyIN
Cj4gcHJlZml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNlIGFyZSBiaW5kaW5ncy4NCj4g
DQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuIFdlIHdvdWxkIHJlbW92ZSB0aGUg
ImJpbmRpbmcgZm9yIg0Kd29yZGluZyBpbiB0aGUgc3ViamVjdCBvbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KDQo+ID4gYWJsZSB0byBkbyB2aXJ0dWFsIG1hY2hpbmUgb3BlcmF0aW9ucy4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZaW5nc2hpdWFuIFBhbiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpLURlIFd1IDx5aS1kZS53dUBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGd6dm0ueWFt
bCAgICB8IDMwDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MzAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHlwZXJ2aXNvci9tZWRpYXRlayxnenZtLnlhbWwNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaHlwZXJ2aXNvci9tZWRpYXRlayxnenZtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGd6dm0ueWFtbA0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zNWUxZTViMThlNDcNCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHlwZXJ2aXNvci9tZWRpYXRlayxnenZtLnlhbWwNCj4gPiBAQCAtMCwwICsxLDMw
IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2h5
cGVydmlzb3IvbWVkaWF0ZWssZ3p2bS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbHA0ZDRX
QnAyNmNwT2VFR2NLbl9hSGNOR2Z5bDFZLS1CWXpmUjhvUl8wWHpyOVRMdlVFTGZPUUFBZHFIbExJ
T3JhMVdfUWRqVlNKdjAtSE1wTGVzSm1BM1RQSlNhZyQNCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbHA0ZDRXQnAyNmNwT2VFR2NLbl9h
SGNOR2Z5bDFZLS1CWXpmUjhvUl8wWHpyOVRMdlVFTGZPUUFBZHFIbExJT3JhMVdfUWRqVlNKdjAt
SE1wTGVzSm1EU1hpbF9RdyQNCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBHZW5pZVpvbmUg
aHlwZXJ2aXNvcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBZaW5nc2hpdWFu
IFBhbiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRp
b246DQo+ID4gKyAgR2VuaWVab25lIGlzIE1lZGlhVGVrIHByb3ByaWV0YXJ5IGh5cGVydmlzb3Iu
IFRoaXMgZGV2aWNlIG5vZGUNCj4gPiBpbmZvcm1zIGl0cw0KPiA+ICsgIGRyaXZlciwgZ3p2bSwg
dG8gcHJvYmUgaWYgcGxhdGZvcm0gc3VwcG9ydHMgcnVubmluZyB2aXJ0dWFsDQo+ID4gbWFjaGlu
ZXMuDQo+IA0KPiBEbyBub3QgZGVzY3JpYmUgTGludXgsIHdlIGFsbCBrbm93IGhvdyBkcml2ZXIg
YmluZGluZyB3b3JrcywgYnV0DQo+IGhhcmR3YXJlL2Zpcm13YXJlL2h5cGVydmlzb3IuDQo+IA0K
Tm90ZWQuIFdlIHdvdWxkIGVuaGFuY2UgdGhlIGRlc2NyaXB0aW9uIG9uIG5leHQgdmVyc2lvbi4N
Cg0KPiBJIGRvbid0IGtub3cgaWYgd2UgYWN0dWFsbHkgd2FudCB0byBzdXBwb3J0IHByb3ByaWV0
YXJ5IGh5cGVydmlzb3JzLg0KPiBUaGVyZSBjYW4gYmUgaHVuZHJlZHMgb2YgdGhlbSwgb25lIHBl
ciBlYWNoIFNvQyBtYW51ZmFjdHVyZXIsIGFuZA0KPiB0aGV5DQo+IGNhbiBjb21lIHdpdGggbWFu
eSByaWRpY3Vsb3VzIGlkZWFzLg0KPiANCk1lZGlhVGVrLCBhcyBhIHBhcnRuZXIgb2YgQW5kcm9p
ZCwgb3VyIEdlbmllWm9uZSBoeXBlcnZpc29yIGhhcyBiZWVuDQpvbmUgb2YgdGhlIGJhY2tlbmQg
b3B0aW9ucyB1bmRlciBBbmRyb2lkIFZpcnR1YWxpemF0aW9uIEZyYW1ld29yayhBVkYpDQpub3cu
DQpUaHVzLCB3ZSdkIGxpa2UgdG8gZG9uYXRlIHRoZXNlIHBhdGNoZXMgZm9yIGJldHRlciBzdXBw
b3J0aW5nIHRoZQ0KTGludXgvQW5kcm9pZCBlY29zeXN0ZW0uDQoNClJlZmVyZW5jZSBsaW5rOiBo
dHRwczovL2Nyb3N2bS5kZXYvYm9vay9oeXBlcnZpc29ycy5odG1sI2dlbmllem9uZSANCg0KPiA+
ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6
IG1lZGlhdGVrLGd6dm0NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJs
ZQ0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtl
eGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIGh5cGVydmlzb3Igew0KPiA+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ3p2bSI7DQo+ID4gKyAgICAgICAgc3RhdHVzID0gIm9r
YXkiOw0KPiANCj4gRHJvcCBzdGF0dXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KPiANCg==
