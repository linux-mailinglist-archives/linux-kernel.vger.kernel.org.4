Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBB733072
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjFPLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjFPLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:52:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B989199D;
        Fri, 16 Jun 2023 04:51:59 -0700 (PDT)
X-UUID: 3074be960c3c11ee9cb5633481061a41-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gJUNYvvcULtBUT5BszpPjAF1TvCXMQaZRwm2HvyZDJI=;
        b=kn5kBNZshy71opipDmKh268Xc2hYqS6GxXQp5qTJznbsnlLeP6VGd5fK2bvM2V6RU8eJsPTzSBY6hb7aOMURzzlodL8hggm2ezYWjbYbsO4Ef/2GMrzVqPew6/GDuo3/5oWrew54piLDwZCPv4IBcV3z1dxlOxN8GNEypQurBks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:6e0f3f1c-2c8b-43ec-b037-329397cab468,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.26,REQID:6e0f3f1c-2c8b-43ec-b037-329397cab468,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:cb9a4e1,CLOUDID:91dfa83e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230614194207RFZQALWW,BulkQuantity:48,Recheck:0,SF:48|38|29|28|17|19|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: 3074be960c3c11ee9cb5633481061a41-20230616
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 429734336; Fri, 16 Jun 2023 19:51:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 19:51:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 19:51:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSRsmu/iEZVyHWROWhAVRhrVx65XKBFrhITW1kHUf1nBbksPDZkAqjnnH/5bB4WgG/6pB9GueqHJcl0lb+68p5uv/AeB4q9KccNNyr37rvJwuhuXPaFlt6+Rj8AD8zXocVaDpda7I8xH6ADHrn4CgDjtHb2CW1J/1vIEbTnW6NKKJMj+i5z2m9w4Yz0jxFwSgrp/J7WLUpRaNkD3ufvpW05ILZg9IwwP3cdGYsj9YHsEePnv43EbMlzPkrRSXt17v/KUgf7BSGCsZHaoF4RkKYsxNACJG4XOoJejbCg42YiwFUV6Ww4ZbENMnsTLE3YC5Iu2LwKHp3TSwcWBKwARxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJUNYvvcULtBUT5BszpPjAF1TvCXMQaZRwm2HvyZDJI=;
 b=CcPgSnNa0R/+rlRtiSq7ZCMLVaIoR6OQyNFbkg0j+gjQQ8Yvmi1Zll7qpNq6Ym4IB8adsu1Y57tNCv3ODt+LpP8CYAgJhQacEG7tLlSCtZteH6zeedn/yQi7269H8Cmhp99+IDC7GQQmlaoJf/K1Nx7LHKwtB0fAW0wLQf6LFOlBE789BRgyEQcz3WNMHQdYdIvxaS39fMFlrAHdryhF8OmwolaSQn/f38TZk3kPTO0JIDcHgipekGRtZcPhKcDU938tDjlBLFjn2aM4YKbKtQyA2eE0+5I3hP6cowpByyAB/e9TDvJlVlsIgazTfFMWGs5XV/KzonZ/MuIFb5LKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJUNYvvcULtBUT5BszpPjAF1TvCXMQaZRwm2HvyZDJI=;
 b=fqWAIjxj3Cgev2h2OZc7ima2RGo1Y+fUuUPsoKCW7OYeh4vfajArIAeNUSgFow0c29G7DNkU+Tna57yBiXofIG1Tn7JPvjJhYm1xVJnsWCJWDlTKaNCKZphEoReZWNTe7+iBDeGYkqvoUoWvuhl3Hcqp5kCYW7BGahInMFvqUNY=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB7107.apcprd03.prod.outlook.com (2603:1096:820:d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 16 Jun
 2023 11:51:50 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 11:51:50 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Topic: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Index: AQHZnpJ04dr81uVobkOio2R0/Knn6q+LiYOAgAFgZgCAACwlAIAACSEAgAAOXYCAACcsgA==
Date:   Fri, 16 Jun 2023 11:51:50 +0000
Message-ID: <77cc50eec350c27221ba3b6a39f8029ef6e3cccc.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-4-shawn.sung@mediatek.com>
         <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
         <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
         <643e6681-6ba7-e990-3e90-09071db904d2@linaro.org>
         <8153fbe67ccc70ff78390b78124a6983f9e329d8.camel@mediatek.com>
         <f65955ef-abcb-c542-00ce-1776dd89f893@linaro.org>
In-Reply-To: <f65955ef-abcb-c542-00ce-1776dd89f893@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB7107:EE_
x-ms-office365-filtering-correlation-id: 68ddd193-b419-484e-2169-08db6e60121d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04+7ULiXh7CbqK89S6i31XM5g+4L4iCH8/13UPBPTxapGUhnk7s3UJyvysjufUhUfbIuUpEDs+I7PPhMHAC5NL0iaaiFUz1oDcp2f2xqzF6GPdlsirAdHa69ru7aU0hQQ5gX7DY4uLk4a6Tyyt2u5wBEJWulclrEicvolmIXTxMJtJ9I1KI4/e5LgBqDYYFfUm6Y0YUtY5fZhScwwmdFzxKR1APgEwKvv+RwofG1hMmr0cObl5MMFk+1FGgcQ0vwvvKw8vxsFp7QIiB5hfMjQQ26J6WDZCgAEvzjcxlUi/GdR3jHNj9qL9kXGSnTMBVw2sjecW9aBuND2c4dRrApL4k+8wSFq2XrVXnRpDEbFWy96b1i4skH8Fley3IDdPxVGdUo2eTDSV3f13UmOFAE2h4FWAjw7tCF3voHtuwqQwa6jLEldR0TYDPAkuxnn4mkrtqhqpG8lM4nGsbK2aBDEzMAxR+PF7/qIxeUooMdICd1oP09un8vSWvXGJKj+x10SpOayqqSGD3n19N+8+BdBh/KLjhPZJ6baoglfzT+5T9ftpnf71V1aFGURH56X4/oeMI1vm2gO8IK75z6Bh6CDPXfbl5ArkLvXbB+uK6CGt4WlbAu3gfJegjDcwREfHUF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(54906003)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(36756003)(186003)(478600001)(110136005)(2616005)(2906002)(316002)(8676002)(41300700001)(38070700005)(86362001)(6486002)(7416002)(6506007)(53546011)(71200400001)(8936002)(122000001)(26005)(83380400001)(5660300002)(38100700002)(85182001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVNQb1dVcVpoY1VWQ0VCbWJUdGEwdmxyOCtJNEhYMnNqejlkd2pEbFBETkd6?=
 =?utf-8?B?a0JrdGdLZHBTSVdWMTF6aUNucG4yNFF6NmpRc2pISGcrOGdZSzlIQVo5eDZu?=
 =?utf-8?B?UFRScUZna2JIUHhJOW5mY3hib2xiQ3dWTkhXekRjaXRKZGx4THlnWnd6eS9t?=
 =?utf-8?B?NDNUV0FOOEh6b0piMUpUeXNBU3NNV1M1K0VhVzdxZGRoVkordXBycVZTekQz?=
 =?utf-8?B?WFpNbS8xMW1IcHE5M3BjaUNoTjlaSnllVlRKQkEwQkRzWDh3N2lpWDRjcldl?=
 =?utf-8?B?UlUwNzNONWg3ZUJkSys5RXh6YjhKd25zUEZUa08wUEFoclJZYklJcEo4K0Rh?=
 =?utf-8?B?WVErUm5IaEJZUGNQWC8wNEJzMXMzblAzWlJnTnR3Ukk1ZGtQTXJ4VjBQT2Iv?=
 =?utf-8?B?a1ZReUdZYjg2eHk3RC8xRklSb0RhTG1YbHVjWUZNaUg0SmphUUpoR1o4WG0z?=
 =?utf-8?B?Tmw0Yy9heEVYa0pQSTF6dW5BVTFYV3NxVFFmZDJvOVJXb2NBeUpZSy96YXBX?=
 =?utf-8?B?L1libXM2dVptMy9qMFl0R0c1N3IySkhkVHpWM1RvSk5aRm1lQmNyUUV0azdM?=
 =?utf-8?B?a05iNjBYTFBqd3Era1BzZFZuSXoyVTV4TFBBV1FjaUY2SnBKM0I1Yjh2TmMr?=
 =?utf-8?B?V3k3QURjMVBFZWllZFU0YWxsZmhKdi9uRXZ2cEcvbGdWbUlGWEZCT3dNNlF4?=
 =?utf-8?B?amRUbEErRjh6cFJmVVhQT2xWNjgvdG8yZzZEb3FlekdPZ0tEYXAwbXJHZC9I?=
 =?utf-8?B?MHl1UmNmNjJyZytFNncyZkU5WkQ5bWRTZ2ZPOG1nUUhKT0JleGtIald3VlZr?=
 =?utf-8?B?bXY5NG9uYjVmemtYRUNJVGwvK0U0WVRpNlRvTEFLRDgxZFJHODlYSk5WbmVs?=
 =?utf-8?B?NzlqMDNsMUNVbC9xcCtja0dJN2EwSTZTeGRyVkxaaHUyUlp0L09WM2gwT29n?=
 =?utf-8?B?d0RSVDhPUjNOS2pFVE5DcW56VzVBcE5sZWJ1K2k1dmdEVS83WHpwdEI3RGtl?=
 =?utf-8?B?eGlObURVQTczSWNVZmRqY1pBczZRWUJqT2E2aEVhVlBJRWJWOEk1TnFMMGlG?=
 =?utf-8?B?b0lmM0krRDdjQ1lIMTlDb2dVTUhiN0xiZk1Db0xKbG1qMEcxUlpQakY5Q0pw?=
 =?utf-8?B?ZFJUUmprNVZIMzZZTnlyNi80V0s5NGNNeEdwb3JKU3l3UWZMb0dxVWpQTDhs?=
 =?utf-8?B?dWtIRytHNkovclpyU1BVWVV1WThNSkJ3bTRKQy9uZVdSRmduUWFHVGZFcy9U?=
 =?utf-8?B?bitMNW1SZlB0NXUyYXlhd2c2RzhaY0lkMUo4OEdFNlVBdW5BRWJJbWtZSk1k?=
 =?utf-8?B?clR6SDYyemYyQ1dDc3ZsYVVRM0FJVFZkeDVvVVdvZmU3L3pqZ2QvT3JPUXNR?=
 =?utf-8?B?VldkQm94WVFVS2Q2eHRSb2JrcWxJTXo2OE4wd3ArRnNZZTFYc2tDemFSbzRC?=
 =?utf-8?B?OGpkZmQzV0plSDluZU9JSEJwQllFRkY5VnhsdTNDNzUzb3dKTTNHK1cxOWJH?=
 =?utf-8?B?M0I1eXo3VlQ1NTJUclVLQUw3cWplU3g5M0JIUnROZnBEWEpzK0ZPT3NVSEdD?=
 =?utf-8?B?Sm1GTDIrMHZEdGlMTlh3UG9jeHRhMXJvcW85ZTVRNnczVktOblVWNFJYZUE1?=
 =?utf-8?B?TGFvdjBPZnVOZzNsSkRiOXBxWGsvT3Z5NnF0d08rcmt6SDZPWjdRSGVDOWpF?=
 =?utf-8?B?a3FWbVd6SWE1MnQ4MTk4MGdOOTJOSUtjVys5dWZGQldkUFZGV1ZRQ0h5Sk96?=
 =?utf-8?B?c1VQUWlicDRsU0wxdC9nMzNVb2xsdEJyaXkyVjBvRVJueHFWZ1JTTHFEZ3Q5?=
 =?utf-8?B?ZSs2ZmNucFd1NDJ2RUl1Um0vS0VOQWYxTlpaK2hhWmJrcmpyekZNZ1JnNDZL?=
 =?utf-8?B?V1FEd1c0Z3FKN2IvVy83VVprbGxydTdFd0NPbmRJc3QwWU1KT3FQSTM1eXRH?=
 =?utf-8?B?clh1RXlmNDlTeVJmMzlOOE5ZMWttdDJSMGdRS0p6Zm13ejdHSmtYSVlMd3Bs?=
 =?utf-8?B?a09tVXRYZ21TNVhZVXJHLzBKblpNSVFwYmdOdE5Ia1NGVExTUWViMnpBNjlV?=
 =?utf-8?B?RlY4ay9qUWNTZVBUamFoU09VakpQRE9vcmJ1RWlwbUhkUmVSb0NCU1JaMXAy?=
 =?utf-8?B?YXlRMkw2SnkyQjUrbEpEeks4WXNSZURLaTZBaDF0OFFSSWtodVB6ZjJ4NEtS?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1698AEA5BDD0E84AA3B8475895A13CC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ddd193-b419-484e-2169-08db6e60121d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 11:51:50.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqSBZ2x+JQKGh4x3nAkTYCVLF3fURMvrl1eGwdtF9kb21tLgJxiB/oEOzF7fbCeKn96gjgYVdFVWnY3yljOHTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDExOjMxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE2LzA2LzIwMjMgMTA6NDAsIFNoYXduIFN1bmcgKOWu
i+WtneismSkgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIzLTA2LTE2IGF0IDEwOjA3ICswMjAwLCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0K
PiA+PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAg
T24gMTYvMDYvMjAyMyAwNzoyOSwgU2hhd24gU3VuZyAo5a6L5a2d6KyZKSB3cm90ZToNCj4gPj4+
IEhpIEtyenlzenRvZiwNCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgYmVj
YXVzZSBNVDgxODggaXMgbm90IHJlbGF0ZWQgdG8gTVQ4MTczLA0KPiA+Pg0KPiA+PiBIb3cgZG9l
cyBpdCBtYXR0ZXI/DQo+ID4gDQo+ID4gQmVjYXVzZSBNVDgxODggTWVyZ2UgaXMgZnVsbHkgY29t
cGF0aWJsZSB3aXRoIE1UODE5NSwgd2UgZGlkbid0IGFkZA0KPiBpdHMNCj4gPiBjb21wYXRpYmxl
IG5hbWUgdG8gdGhlIGRyaXZlciwgYnV0IGp1c3QgbGlzdCBpdCBpbiBkdC1iaW5kaW5ncywgYW5k
DQo+IHVzZQ0KPiA+IE1UODE5NSdzIGNvbXBhdGlibGUgbmFtZSB0byBtYXRjaCB0aGUgSUQgaW4g
ZGV2aWNlIHRhYmxlLiBGb3INCj4gZXhhbXBsZSwNCj4gPiBpbiBtdDgxODguZHRzaToNCj4gPiAN
Cj4gPiBtZXJnZTE6IG1lcmdlQDFjMTBjMDAwIHsNCj4gPiAgICAgICAgIGNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTg4LWRpc3AtbWVyZ2UiLA0KPiAibWVkaWF0ZWssbXQ4MTk1LQ0KPiA+IGRp
c3AtbWVyZ2UiOw0KPiA+ICAgICAgICAgLi4uDQo+ID4gfTsNCj4gPiANCj4gPiBJZiB3ZSBhZGQg
TVQ4MTg4IE1lcmdlIGFzIGFuIGVudW0gd2l0aCBNVDgxNzMsIHRoZW4gb3VyIGRldmljZSB0cmVl
DQo+ID4gbXVzdCBiZSBhcyBiZWxvdywgYW5kIG5vdGhpbmcgd2lsbCBtYXRjaCBpbiBNZXJnZSBk
cml2ZXIuDQo+ID4gDQo+ID4gbWVyZ2UxOiBtZXJnZUAxYzEwYzAwMCB7DQo+ID4gICAgICAgICBj
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1kaXNwLQ0KPiA+IG1lcmdlIjsNCj4gPiAgICAg
ICAgIC4uLg0KPiA+IH07DQo+IA0KPiBObywgd2h5PyBJdCB3b3VsZCBiZSBpbmNvcnJlY3Qgd2l0
aCBleGlzdGluZyBiaW5kaW5ncy4gQWdhaW4sIG9uIHdoYXQNCj4gdHJlZSBhcmUgeW91IHdvcmtp
bmc/DQoNCkp1c3Qgc2VudCBhIHYzIHRoYXQgaXMgYmFzZWQgb24gbmV4dC0yMDIzMDYxNiB0YWcg
b2YgbGludXgtbmV4dC9tYXN0ZXINCmJyYW5jaC4gQWZ0ZXIgY2hlY2tpbmcsIHN0aWxsIG5vdCBz
dXJlIHdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2Vlbg0KdGhpcyBtb2RpZmljYXRpb24gYW5k
IHRoZSBvdGhlcnMgaW4gbWRwLXJkbWEgYW5kIGV0aGRyLiBDb3VsZCB5b3Ugc2hhcmUNCm1vcmUg
aW5mb3JtYXRpb24gcGxlYXNlPyANCg0KPiANCj4gPiANCj4gPj4NCj4gPj4+ICBJ4oCZbGwNCj4g
Pj4+IGtlZXAgaXQgYXMgaXQgaXMgZm9yIG5vdywgaG93ZXZlciwgSSBkbyBmaW5kIHRoYXQgTVQ4
MTk1IGRvZXNu4oCZdA0KPiA+PiBleGlzdA0KPiA+Pj4gaW4gdGhpcyBkdC1iaW5kaW5ncyB3aGlj
aCBpdCBzaG91bGQgYmUsIHNvIHRoZXJlIG1heSBiZSBjb25mbGljdHMNCj4gPj4gd2hlbg0KPiA+
Pj4gdGhpcyBzZXJpZXMgaXMgZ29pbmcgdG8gYmUgbWVyZ2VkLg0KPiA+Pg0KPiA+PiBEb24ndCB0
b3AgcG9zdC4NCj4gPj4NCj4gPj4gTm8sIHJlYmFzZSBvbiBjdXJyZW50IG5leHQgYW5kIGltcGxl
bWVudCBteSBjb21tZW50Lg0KPiA+IA0KPiA+IFdpbGwgcmViYXNlIGxpbnV4LW5leHQgaW4gdGhl
IG5leHQgdmVyc2lvbi4NCj4gDQo+IFJlYmFzZSBub3cgLSBmb3IgdGhpcyBkaXNjdXNzaW9uLg0K
DQpEb25lLiBQbGVhc2UgcmVmZXIgdG8gdjMuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo+IA0KDQpUaGFua3MsDQpIc2lhbyBDaGllbiBTdW5nDQo=
