Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA0633A95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiKVKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiKVKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:51:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5125FB;
        Tue, 22 Nov 2022 02:51:44 -0800 (PST)
X-UUID: c2444e227eff4ea0b6aa336a609c3640-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cFoIHNQRGy3Pl85Uefgy9KDKfSwEhwPX9adMTGgRNlM=;
        b=KqoX30Gks1vl3Jai46E7LDLg2CTaZZS8gI8SqKDokD3LtAuuv3RYFfiPMehC9pcjiK2iJ+NOkSPI8d7dr7x/5J0JFtMePyQJjSfmyryHSgeHfRYZlq5xxlDg0XRumqvEfB7JMFdPGNGuZ6xF7zzlmDPBgvyK0y6MHXhcwTyJmu0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:b6fb12b8-2eb4-4db4-835f-4db32c232eee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:2bdffaf8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c2444e227eff4ea0b6aa336a609c3640-20221122
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 378833494; Tue, 22 Nov 2022 18:51:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 18:51:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 18:51:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ensnm4oMxsLujbKpep9moQb46zOdnAleugHQJSMB6HVX0jh28VBm0sVjBbtSHI4LrgW4rsBjyKCz8XOstNjKxRtbFjdR0r65B+hkVmNM1J8siE1Qfabwk8shJ1QsSoZWExzu8I9TsUbkl5vBDaeK0Dmoq4drqht7euObG/MLQ9quyJ+pD3v9ZbdOJLviazUIptE2F2oXx1dhCO67RYGLDM/sbAiret+R8FupoXH3H3+rhOqfYmiISe8KRLliJtBauQS7ltdUeIlzv9GDOTHvZUsNrgDG2rfbbvPDsQfqljM7K/B7ZbKvKoNlpXldv4U9lMuJEshWx6H95tZEQooyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFoIHNQRGy3Pl85Uefgy9KDKfSwEhwPX9adMTGgRNlM=;
 b=n5tjua1dvtB+qliKsm8pVBxTaNr8kN7AZ96cjq7PMiYdAAdZVbA0TEizMGep3ZcMOisIt55+x6L1Bd6764RALnHkwZW7t/IMdPb/Shhc620UHDAKuq7uiBn4c/bOUhgGOuXny4cMl6V0tYRfGXsd3Gg14Pnn89/FgnQybROnPR3PzfMgTfXl5j0AcmPW0pWfxOX5N3EPjm4X88xl7a0XUEKId1wBVd6RnFbX7+gHI0XFkjCE4IhG7cgALO0wr0JcSvK6BXnm04wrnx1Rx3Y5dZmtdyXI4hQYrQS5avvp1dN2CSHX4VnH/WO5FdxSNVJOvO7EbBKCtJtYxN6gu70+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFoIHNQRGy3Pl85Uefgy9KDKfSwEhwPX9adMTGgRNlM=;
 b=QqXpk0mKgaIPyuyvOnDFiU6bgTEthe2l0QolDp+gU7pmmcxLy5vjUgfxL3uNqcsZqRZwviRA8dQRxgIb5p+mvNdboptzVgHAI9Wcdf01P3YO+yEkRCFgAfANBRuXdFwnmRXVqikJL3cQrWeyBk29ErzlKUeemC4gqdujPIRynCk=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by TYZPR03MB5599.apcprd03.prod.outlook.com (2603:1096:400:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:51:36 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::c49b:1118:aea6:61e9]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::c49b:1118:aea6:61e9%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:51:36 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v28 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Topic: [PATCH v28 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Thread-Index: AQHY8nnSexf5uHq4NEqdiRYMbNh8ra41TzuAgAC/BwCAAhhnAIAStSkA
Date:   Tue, 22 Nov 2022 10:51:35 +0000
Message-ID: <de21390898759ce979da8d2ae76a93982f59c149.camel@mediatek.com>
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
         <20221107072243.15748-2-nancy.lin@mediatek.com>
         <c6297a1c-e282-4a18-f16c-fa2df08b440a@gmail.com>
         <f6d7eaa0b7e2a3ed6567692616ebc1304500806c.camel@mediatek.com>
         <fd6c1299-4ac9-6d51-247f-3a7b7e39052b@gmail.com>
In-Reply-To: <fd6c1299-4ac9-6d51-247f-3a7b7e39052b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|TYZPR03MB5599:EE_
x-ms-office365-filtering-correlation-id: 20318dac-dca6-4ba7-b5f0-08dacc7786be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Pl29Odt1OeEvifu+QKVcnGXgBUxcUGI3FOHPNzThVg6byXY8KNJPykAzTtBnZUeaPRcIsHord+N0KbaFRwWJ5k+TvnfSMqi+EUDM2e7kg08UxUC7nnjzlumORu1df2gFLxOcBNP/SVeEhipUcGMOFIAzc0RAsmP6/E/Fk5Az2kp7+TxB1qxsKABLVQNKvnXBmJEGu0RLflmP9MxAUWPdIY5rXNyA4h8RzP6pOIvdB8a8YOf9hWQgMEmBvFbvqUfSBJR0tVJBZtbaKVF1f/3B1B0jkzWwhUFxI1ImqWYA93v4YQxryy4dQVUa0sdMAF9WMOA0tpJeRy5usFagBEmpxvC6BH4FBO2ekp25disNFVKCq+q4la1Dh4TIA/BXe+1OPP+w9heYnvLhhm1L7eGfleg0SNQIBZi+3A0H9FuDP15+ha8JpB+cDnFeBmwqGZYt2bKLl6GfTFVsVPbGJ6kkwfwKX4U++6Qev6bDBPv+YmoqzaSjsru0aJP6TEIdVbjliXaqtRNJshQkPT87MbJU/SA/rygV8E4C74shoBf19sfmHgASgwLS2T3tc04LTf1mbL4SuY209wFIjJ5ioRxMmbVNTgPBgW5Nd7t4WI15vggmanXa3QZ9G65nQNA12rBdOylbqQfpsSNOR4DO8j2bqCU25BMMGtLCBacInq+D9tOLE+Pi6fiyq61rao56peKySr4BBHrueEJAhfR+o2XBiTw2OjPTmTpI/e9nzVbJoZIsCBklD9iPsRIrWMFlu2j+IIxivDQSWOtVpXhDihXsy/Rhxhsvn42GaqruKMzLo3oMcj9h/DHUWFnTExU+WVG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(83380400001)(122000001)(86362001)(66574015)(38100700002)(91956017)(2906002)(4001150100001)(41300700001)(38070700005)(316002)(5660300002)(7416002)(66476007)(2616005)(54906003)(6506007)(53546011)(478600001)(8936002)(76116006)(6486002)(186003)(26005)(4326008)(66446008)(64756008)(66556008)(6512007)(110136005)(71200400001)(66946007)(966005)(8676002)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRjcm9GWFdCeCtDVGJOeTUrcWpCR2o4OHY1RURLTndFUnRHTk5uOWpNc2ov?=
 =?utf-8?B?TDJFc3Ntbi8vTjVaZ3Z0eEc0cHlrSURWcDQ1Q3lPVWJaeDRORWwwOVZqMHc3?=
 =?utf-8?B?RmZqUW1MMWhBT0JCYUtvTlhwUFZBQXVrVGxEVHFKRHUrcVVyemk4RDRtSzM1?=
 =?utf-8?B?eTZTQ0w5QVordXRsQzgxcUtFYUQxZUIvZ0VvNWZTejdvaDBRSUt2S2RSVFRt?=
 =?utf-8?B?Nk9rczM5TEtsMU4xVkY1aVBBRWRock5TZzZxcFJpUTdZSDJBOGxZVWFNMXM4?=
 =?utf-8?B?WXZkanRTTEllV1BHTTRYRkE0Q2pFYit5Yk5DRm45bFpNUWtCTFZORS9lUlBu?=
 =?utf-8?B?eUtDcjdVdmd1Y0tmY1hqMTFGdzFuSXhpd0sxV2hjbXUvdFUzUlk3K0R2MXhK?=
 =?utf-8?B?U1QyOWJIWCtPclgycUFuQmo3YWJlRkpTQ3A5emxxb0NQNk1nMjh2SEhiOWd5?=
 =?utf-8?B?d3NTaHl1VWE1NVhzZ1Q2YlZKVERydERQem44OXhUanVJdTFLQlFxSGxjY1gw?=
 =?utf-8?B?QTd2ZVR0Uko1Ry81bjBVa3R3bVlSd1RialM4TlViTS9jRTd5QmFpVEdEL3pm?=
 =?utf-8?B?VGN2NlZWN3pzZXRUdk5nZ2dKcDlsQURBSFRzQ0NrWElHVlB0eS8xMDJ1WTZN?=
 =?utf-8?B?Zyt5KzI1SHFVTTR0ZlpwcVU5M0tnQmJIWmRMTGNpMGZOTXhiZEUvQTQ1OVRh?=
 =?utf-8?B?bktYK2wvQUpVVGladlhBTVJ6SkFYMGZJMkdWY0hTRU1jVzV1dE50RHY5N3Qz?=
 =?utf-8?B?U2RCNUI0blBJUnZrK1ZvMUFzZkRUdGQ2T092Q1h2TjhiampVT3B2NWlHK2Rh?=
 =?utf-8?B?Zy8vOUNhbXBpektaaXZKVkpXcDdsNHcxVTR4aG1ySjgrYkU1dDBITE5waFZu?=
 =?utf-8?B?WnppWmllcHVCaEJEcE5zNEI1akRyYzZPcUlYcnFTa1JjQkxYRmFQNjd6YnNx?=
 =?utf-8?B?cFlLQnBlRHpCNXFQR29jL1RaT09DWnA1dFVLcXJSTXVxbXU1bVBUcUlrZUhR?=
 =?utf-8?B?KzdDQ3ZlS1E5bCtFUjhIeXJzMld4N0VBdVFhYjlMVkxiYlM0NDhsaTFydW02?=
 =?utf-8?B?NWgyOU5wRHY3UE1OZGVXdjJITjVDRUt2ZGx6QmZ6QTBqdmtMUjJLMVd1QVNP?=
 =?utf-8?B?bWh1WXJ2WXFpeGZjNVBZcGtlZE5UeXhZamRNckhJT3djVzR3a04rRVVWaXNY?=
 =?utf-8?B?ZFpsd3d2aWlFRTU0TWUzMlRiTWZhUWpZcmgvRTBNcEUzMjQ1NVdDUFYzY0tH?=
 =?utf-8?B?SmNhRDdVZ0JUeDNKKy94VlovNmVCOGpMZXdkeVArdkh6WEk4SGFEd1RIRGxt?=
 =?utf-8?B?WXFpL2M5MlFmaXFtZHh4NEhFKzlvMERwem0yK2MyZ05XbnFOTmxyUHpoZjBW?=
 =?utf-8?B?ckdTbDFQazE0MENPbXhUYktKUWh0MkNpODdHQkphUlhWQmFyK00xUlRXeVZs?=
 =?utf-8?B?Zml5LzFYcTFRMldUaU4wNzAxUytmR3lxYUgzSysxWXdhcW80bm5kVmRsTE8v?=
 =?utf-8?B?WDRFam9VVkhGeFQ1OGJFWjBYSXVONGsra0hGQzUvUDB2L1JhREpEMDhrenZv?=
 =?utf-8?B?dW5QRGNnamhFQUlGUVJWaFRzVG1XdWNNWWFFRlZwdGNSSWNOeFI2emZZMVNs?=
 =?utf-8?B?Z01IaVozWnZ0czJ1SGNVRVVPS3VraWs4aHZhQVRHQlJGdEM3Qy83ZnVhcnlH?=
 =?utf-8?B?Vm5xUVd0SmplUlZhM1M2L1VxZ2YxY1hVY0ZldmUraUxOempFd2pYUUNkVFpx?=
 =?utf-8?B?ZjRRTk5DRGJhaDVsbDZLOFJmWVRnTmpHTUVwZjR0K1N2Z09pd1M2LzZYOGZ0?=
 =?utf-8?B?YWRmRUcrZE9UaVhWcDduMHEvcDQ0bGRLMUhuN2J2WmtTZDFXTUc5c0VJbTM3?=
 =?utf-8?B?N1pyTHI0ZkltaGFiNklpZGJnb3RVMkFQb3dOeGdTUVAxc0JpeG92T3lHQUg0?=
 =?utf-8?B?QlVISC8vWFM3UDZvMGJPeG5Sd09zU3lYUncvalVMb2VmOXJua0VEaWhwRFkr?=
 =?utf-8?B?WTRtcCtqQi90M1o4N2Q5cUdNY3d4dW9nYmxqSHcwUVNqbXRFd2d0LytLN2dD?=
 =?utf-8?B?U3FLVEN3N3FUS1B0OE9ZcEZudUZjek9iMlBUd09KWDZzTW5lbmpzTUZsVk95?=
 =?utf-8?B?UHN6SjU0NXF6aUZqMyt3TjVCcHd1d2FrZlFZQmJVU3F3Ti95TmhXd2JqRzlx?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A62C60BACE87C4D8AC28DE0D58CAC25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20318dac-dca6-4ba7-b5f0-08dacc7786be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 10:51:35.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUdqIim9U0spZ95Virx0Y+SCngoMQDOzh9gtskdzEv6nB0NuEDmo8tHLORlTb+Hgny9OHpvcsqWOSTTo6gSFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYXR0aGlhcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBUaHUsIDIwMjIt
MTEtMTAgYXQgMTQ6MTAgKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAw
OS8xMS8yMDIyIDA2OjEwLCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gT24g
VHVlLCAyMDIyLTExLTA4IGF0IDE4OjQ2ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0K
PiA+ID4gDQo+ID4gPiBPbiAwNy8xMS8yMDIyIDA4OjIyLCBOYW5jeS5MaW4gd3JvdGU6DQo+ID4g
PiA+IEFkZCB2ZG9zeXMxIG1tc3lzIGNvbXBhdGlibGUgZm9yIE1UODE5NSBwbGF0Zm9ybS4NCj4g
PiA+ID4gDQo+ID4gPiA+IEZvciBNVDgxOTUsIFZET1NZUzAgYW5kIFZET1NZUzEgYXJlIDIgZGlz
cGxheSBIVyBwaXBlbGluZXMNCj4gPiA+ID4gYmluZGluZw0KPiA+ID4gPiB0bw0KPiA+ID4gPiAy
IGRpZmZlcmVudCBwb3dlciBkb21haW5zLCBkaWZmZXJlbnQgY2xvY2sgZHJpdmVycyBhbmQNCj4g
PiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+IG1lZGlhdGVrLWRybSBkcml2ZXJzLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTmFuY3kuTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gPG5mcmFwcmFk
b0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIA0KPiA+ID4gPiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbCAgICAgIHwN
Cj4gPiA+ID4gNA0KPiA+ID4gPiArKystDQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0K
PiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssbW1zeXMNCj4gPiA+ID4gLnlhbQ0KPiA+ID4gPiBsDQo+ID4gPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cw0K
PiA+ID4gPiAueWFtDQo+ID4gPiA+IGwNCj4gPiA+ID4gaW5kZXggMDcxMWYxODM0ZmJkLi5hYWFi
ZTIxOTYxODUgMTAwNjQ0DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMNCj4gPiA+ID4gLnlh
bQ0KPiA+ID4gPiBsDQo+ID4gPiA+ICsrKw0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMNCj4gPiA+ID4gLnlhbQ0K
PiA+ID4gPiBsDQo+ID4gPiA+IEBAIC00OCw3ICs0OCw5IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+
ICAgICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPiA+ID4gPiAgIA0KPiA+ID4gPiAgICAgICAg
IC0gaXRlbXM6DQo+ID4gPiA+IC0gICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LXZk
b3N5czANCj4gPiA+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gPiA+ICsgICAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MTk1LXZkb3N5czANCj4gPiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxOTUtdmRvc3lzMQ0KPiA+ID4gPiAgICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRl
ayxtdDgxOTUtbW1zeXMNCj4gPiA+ID4gICAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4g
PiA+ICAgDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgd2UgaGFkIHRoYXQgc2V2ZXJhbCB0aW1lcyBh
bHJlYWR5Og0KPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
NmJiZTk1MjctYWU0OC0zMGUwLWZiNDUtNTE5MjIzYTc0NGQ3QGxpbmFyby5vcmcvDQo+ID4gPiAN
Cj4gPiA+IFdlIHdpbGwgc29tZXRoaW5nIGxpa2UgdGhpcywgYnV0IHBsZWFzZSBjaGVjayB0aGF0
IHRoaXMgZG9lcyBub3QNCj4gPiA+IGdpdmUNCj4gPiA+IGFueSANCj4gPiA+IGVycm9ycy93YXJu
aW5nczoNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnkNCj4gPiA+IGFt
bCANCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtbXN5cy55DQo+ID4gPiBhbWwNCj4gPiA+IGluZGV4IGViNDUxYmVjMjNkM2Qu
LjhlOWM0ZjRkN2MzODkgMTAwNjQ0DQo+ID4gPiAtLS0NCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55DQo+ID4gPiBh
bWwNCj4gPiA+ICsrKw0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnkNCj4gPiA+IGFtbA0KPiA+ID4gQEAgLTMyLDEz
ICszMiwyMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ4MTgzLW1tc3lzDQo+ID4gPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODYtbW1z
eXMNCj4gPiA+ICAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tbXN5cw0KPiA+ID4g
LSAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbW1zeXMNCj4gPiA+ICAgICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODM2NS1tbXN5cw0KPiA+ID4gICAgICAgICAgICAgLSBjb25zdDog
c3lzY29uDQo+ID4gPiAgICAgICAgIC0gaXRlbXM6DQo+ID4gPiAgICAgICAgICAgICAtIGNvbnN0
OiBtZWRpYXRlayxtdDc2MjMtbW1zeXMNCj4gPiA+ICAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlh
dGVrLG10MjcwMS1tbXN5cw0KPiA+ID4gICAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4g
PiArICAgICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4
MTk1LXZkb3N5czANCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gPiArICAg
ICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LXZk
b3N5czENCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gPiArICAgICAgLSBp
dGVtczoNCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+
ID4gPiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPiA+ID4gKyAgICAgIGRlcHJlY2F0ZWQ6
IHRydWUNCj4gPiA+IA0KPiA+ID4gICAgIHJlZzoNCj4gPiA+ICAgICAgIG1heEl0ZW1zOiAxDQo+
ID4gDQo+ID4gSGkgTWF0dGhpYXMsDQo+ID4gDQo+ID4gQXMgdGhlIHZkb3N5czAgcHJldmlvdXMg
cmV2aWV3ZWQgcGF0Y2g6DQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNo
LzIwMjIwOTI3MTUyNzA0LjEyMDE4LTItamFzb24tamgubGluQG1lZGlhdGVrLmNvbS9fXzshIUNU
Uk5LQTl3TWcwQVJidyF6UmRiSXl5QXNmcW9iMmthcE1BY0tZQVRBZ3VoRVYweDBxRTVjVE9BY1dV
Tmh6ZUFiTUh6Wm9vc18yUXpVQ3hTJA0KPiA+ICANCj4gPiBTaG91bGQgSSBtb2RpZnkgdGhlIHZk
b3N5czAgaXRlbXMgZm9ybWF0IGxpa2UgeW91ciBleGFtcGxlPw0KPiA+IA0KPiA+IE9yIHNob3Vs
ZCB2ZG9zeXMxIGFkZCBpdGVtcyBmb3JtYXQgbGlrZSB2ZG9zeXMwJ3MgcHJldmlvdXMgcGF0Y2g/
DQo+ID4gICAgICAtIGl0ZW1zOg0KPiA+ICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5
NS12ZG9zeXMxDQo+ID4gICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+
ID4gICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gDQo+IA0KPiBObywgdmRvc3lzMSBtdXN0
IG5vdCBoYXZlIG1lZGlhdGVrLG10ODE5NS1tbXN5cyBmYWxsYmFjay4NCj4gDQo+IFJlZ2FyZHMs
DQo+IE1hdHRoaWFzDQo+IA0KDQpJIHdpbGwgZml4IGl0IGFuZCBhZGQgdGhlIGZvbGxvd2luZyB2
ZG9zeXMxIGJpbmRpbmcgYmFzZSBvbiBbMV0uDQoNCiAgICAgIC0gZGVzY3JpcHRpb246IHZkb3N5
czAgYW5kIHZkb3N5czEgYXJlIDIgZGlzcGxheSBIVyBwaXBlbGluZXMsDQogICAgICAgICAgICAg
ICAgICAgICBzbyBtdDgxOTUgYmluZGluZyBzaG91bGQgYmUgZGVwcmVjYXRlZC4NCiAgICAgICAg
ZGVwcmVjYXRlZDogdHJ1ZQ0KICAgICAgICBpdGVtczoNCiAgICAgICAgICAtIGNvbnN0OiBtZWRp
YXRlayxtdDgxOTUtbW1zeXMNCiAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCiAgICAgIC0gaXRl
bXM6DQogICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3NjIzLW1tc3lzDQogICAgICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1tc3lzDQogICAgICAgICAgLSBjb25zdDogc3lzY29u
DQogICAgICAtIGl0ZW1zOg0KICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5NS12ZG9z
eXMwDQogICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQogICAgICAgICAg
LSBjb25zdDogc3lzY29uDQogKyAgICAtIGl0ZW1zOg0KICsgICAgICAgIC0gY29uc3Q6IG1lZGlh
dGVrLG10ODE5NS12ZG9zeXMxDQogKyAgICAgICAgLSBjb25zdDogc3lzY29uDQoNClsxXSANCmh0
dHBzOi8va2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21h
dHRoaWFzLmJnZy9saW51eC8rL2IyMzdlZmQ0N2RmN2QyNWI3OGMzMDZlOTBiOTdjNWFhMGZmNGM0
ZmMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayUyQ21tc3lzLnlhbWwNCg0KUmVnYXJkcywNCk5hbmN5DQoNCg0KPiA+IFJlZ2FyZHMsDQo+ID4g
SmFzb24tSkguTGluDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gKioqKioqKioqKioqKiBNRURJQVRF
SyBDb25maWRlbnRpYWxpdHkgTm90aWNlDQo+ID4gICAqKioqKioqKioqKioqKioqKioqKg0KPiA+
IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVk
aW5nIGFueQ0KPiA+IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFy
eSwgcHJpdmlsZWdlZCwgb3INCj4gPiBvdGhlcndpc2UNCj4gPiBleGVtcHQgZnJvbSBkaXNjbG9z
dXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUNCj4gPiBjb252
ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwNCj4gPiBk
aXNzZW1pbmF0aW9uLA0KPiA+IGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBj
b3B5aW5nIG9mIHRoaXMgZS1tYWlsDQo+ID4gKGluY2x1ZGluZyBpdHMNCj4gPiBhdHRhY2htZW50
cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQN
Cj4gPiBtYXkNCj4gPiBiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVj
aXBpZW50IG9mIHRoaXMgZS1tYWlsLA0KPiA+IG9yIGJlbGlldmUNCj4gPiAgIA0KPiA+IHRoYXQg
eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
DQo+ID4gc2VuZGVyDQo+ID4gaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWls
KSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcw0KPiA+IG9mDQo+ID4gdGhpcyBlLW1haWwgKGlu
Y2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbw0KPiA+IG5v
dA0KPiA+IGRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBw
ZXJzb24uIFRoYW5rIHlvdSENCj4gDQo+IA0K
