Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE76C401D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCVCEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVCEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:04:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F334D29E07;
        Tue, 21 Mar 2023 19:04:29 -0700 (PDT)
X-UUID: dd43935cc85511edb6b9f13eb10bd0fe-20230322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=48xjlslr+K9LAZitTjOcQoXZ8givnaoqxXqX8CkBdAg=;
        b=elyibMTayOaE3I/BH4c4Xkg9DUdY9LPN+CWDZjf2ri97g3uV7dmwegUZ0Jo+pRLuTpQ5Y0UbLL3mozvdXCuLLDo03K432+HR+nLlBNmBfzbzDuW0+v1gKh5IjqVv2O6+8E49p4E6Pkpsd1UBgPZWtxCWCGTk5Xk1gxCQJICPgu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f3dfd6ca-d06d-4faa-a9ef-685999537c36,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:f3dfd6ca-d06d-4faa-a9ef-685999537c36,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:fc301529-564d-42d9-9875-7c868ee415ec,B
        ulkID:2303220142460NPY7QQN,BulkQuantity:9,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dd43935cc85511edb6b9f13eb10bd0fe-20230322
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1689417027; Wed, 22 Mar 2023 10:04:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 22 Mar 2023 10:04:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 10:04:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbC8DU8HDRjjfjVIv8vMsY4qKXGtUuQ6uuPmtCckRfd/du7yZZcNDAnOc+6zTm85iudtMVNVInGjqjd5JzYQVCnfgZhx9iD6Fd7dNw5MwOqOiIgESjYkkX4aCXbWa03eSLbaLFrlWQ2fSnCMYSYeb+QrISSPkouOxxm0sTkPxfDAEZxiAjz4tpvIHqNDbHuGVEStbJfoDnW91w+yLxeWX3xe+jpHn4Kgzmy+CKf3/UHhNEM6kXCTIbS5VsOofUok2d7q12batfoH6zMr8RMdYjfavQoy9GKy+ltqCt5BCUhmgo9Q0O5nGQeh0qXmKtfgiJQyvLKGa81IoQjMbjvIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48xjlslr+K9LAZitTjOcQoXZ8givnaoqxXqX8CkBdAg=;
 b=MoujJxvqs5xjxugZR4HYLJmYJxi0tPcJjKKQDdkLPvuCEHrKcpv9NWyLKhpSN6R8P4GwdDf0CtUlGVE9LargIAnGWNEuEvEDCcPdTw0aTQ4OT7niC+Lu3nzET4wr4SnTgchBoM12UJLaWN2e3hf8/ENMmMRiLMUxga/lZ1asIVC3WMrz+w3szFToBvSOqX8eC7Z43++4WsE8Ix5UTciO0JvkTp3+P/sE9SiZSXUK2o48X8aO76hIpdw504jPnY9qsxWLIiitESG7yS/Hv6ywlr1tLepOOzBKhEJ4Uq+tAELinvheHJQz3lPfHrOVTCG/24d6/eHBg5LLtV4q1PBBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48xjlslr+K9LAZitTjOcQoXZ8givnaoqxXqX8CkBdAg=;
 b=JuFSgF1Rwuu/uAf3+5OkxYh8/5JeQd+N/0HTpsyiCW83kfHBFkAYGcU4PYYJaEMzhTePNhbwxksVUCa4/2IHpO/uVLUUi7zW7GfkmCxd906fv24S/AnVXxXA17i/Be+rxLSt3q0gN5p9OqY9/v4NvWiUI5Up+xF7I6cKUxVfj+0=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by KL1PR0302MB5202.apcprd03.prod.outlook.com (2603:1096:820:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 02:04:19 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 02:04:19 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] arm64: dts: mt8195: add display node for vdosys1
Thread-Topic: [PATCH v1] arm64: dts: mt8195: add display node for vdosys1
Thread-Index: AQHZW/b5t+PXgbFooU2dsjWlbTyiga8FgSGAgACMJgA=
Date:   Wed, 22 Mar 2023 02:04:17 +0000
Message-ID: <f5eea6b4e12dbd7e1570e5d1cfce81ba7e672186.camel@mediatek.com>
References: <20230321131251.3351-1-nancy.lin@mediatek.com>
         <67b73929-ac8b-0e41-1940-89dcd1090da0@linaro.org>
In-Reply-To: <67b73929-ac8b-0e41-1940-89dcd1090da0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|KL1PR0302MB5202:EE_
x-ms-office365-filtering-correlation-id: baa442bf-f2d7-4a2b-af70-08db2a79be8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdlpsE3gbItmk38En1M8vnYeLfjI+yN8huLaL+Y7SqOGlG28hoM6CgSMmUnarOhABB2L6KeVZ22wpMgKd8UbmJSZ6Vmy34GSpsYZyuoqV6Qw8sHSs1Tg6KxYolBzqMa+xTaZoex2v8km1Bx8rU96EuMsm9RVOauG91ucdZ2h9oI+B7RTrbTeaTTEeaiB0BlTE1GsqAs1eapsimAyiRC6VjTw//m4FQB2L5Luztnd9NDKjU2o581cAu69a5WWAM9HpKEfOBVsTUfsHGAn20XY0CLocK8PvG1xXzNVlhzxzJImd16ajHO+TkkP3V0ISbX3jXZHQ77JLKhX5bvm2taI14xNvCdJ0uUHOz2dINeOwjJ+m7uaBMjlyjyUH1/5eBynuiNZYJSg3DFIlm0rrqjxqfwLHWlLxdDqkN1bdI61ajT5x3rCFhcsLKOgugjoLf0cD8eKnJo/KXMu3HvbaRajlkZAJKeTeXPrkq7h9fl6vHqyP7iLEbIARJjMA/09zAjUTPDLXR1fP43msBdMRb7EKMBwg6VnG8cHhX0QjFzYLLZbYlMswexf+2i+mAXkN5DbMuBp+BWHHybqSRiZVPOKyfdvn3B6J3N7iiHOe/+AWQtgZwPJyGH40ciajgSRoED12ixOoTSXlog1RL2G5kNwD5c3umkY/A1QazJGAeVCIrDoPVSnsW4LQxPCqBqga2kxk3jVbAenHKtiwyIzO5llBITL676hqrQ+yZd1OvyOB3UYBUiiB6bi7J6BzsLWWOH+UhGYHHjtbL3GEhF/Z/FJ5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199018)(66556008)(86362001)(85182001)(36756003)(316002)(64756008)(4326008)(54906003)(83380400001)(66946007)(8676002)(478600001)(66446008)(91956017)(186003)(26005)(53546011)(66476007)(2616005)(6506007)(6486002)(107886003)(966005)(110136005)(6512007)(76116006)(71200400001)(38100700002)(38070700005)(8936002)(7416002)(5660300002)(41300700001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlJkTU8xdHB0MzJXMkJIcUo1aG1oRHZFNFVkV3hVZGFNZmVRM2xPVEZjWVRR?=
 =?utf-8?B?TzBKaFVSamJINWJoT1RjZ0xkaWtNajdqN2dCdGROVHNDQlR0cjhkVGZmR0NO?=
 =?utf-8?B?aFRMbW5yTnBDNmtxUE5zT0psZkx0aWZHZjhwUjFCTDBnN0JXbVNIVCtQYmZY?=
 =?utf-8?B?OFU0RUF6YnFoYTJOTk9mM1Fhd003NzZzVk5sZmtJd3pWelgrRlBiNE1Lbk9M?=
 =?utf-8?B?VXZEK0ExNStPTmt4ZERrNk44ejVqT2JXR0xhZUhnWUplUWJaVmxKbXdhUzh5?=
 =?utf-8?B?OCtjOWxlTVNuUmpiZzN1cTZqamNjUlkxMVJ6VjM2TEJWaXF2NnpjRnRTbUZU?=
 =?utf-8?B?c0wrYUh0SU80LzVaNEFxTmMwVmE3VGpVRzYva2JOYTVLejRvTDdESENwMFEw?=
 =?utf-8?B?c3g5azczSlY1TEFBeEx5SmllZm9Kblh3V1ZadFVHNEN3WkFyQ0dZTVFHVzVQ?=
 =?utf-8?B?TUxEbkpFMncyT21jOW1WOGNGeFpKMjlvaFdDMUl2aDViY1diaEh5SGd0c0xk?=
 =?utf-8?B?M1pjKzZtRjVMdVVFdXlIZks5b3hBWk5va3E3SEkyZGdqREJVRjcxSStXdHF6?=
 =?utf-8?B?OFRHdkNneTVUaTBiL29Ib1VxaitOUzQyUm5GL3lWODlqS0hseFdkMkJYbEZF?=
 =?utf-8?B?a0Jrc21XdmozMW5pK3VUTTJ3andxb0NTc082S2F6UXRwNjFTNzl4RDF6ZXli?=
 =?utf-8?B?clg3NStITXdFQjZRRTVlSWtCR0pqUW1aUllWV3FPMHoxejY2MGxkcmlRMWMx?=
 =?utf-8?B?enVpNS91ZEtmQW9nbkxaaFV2NnhCLzRFVWNJOEg0cjN5M3c5WVlsNnRkQ09E?=
 =?utf-8?B?YkxVT2h2WDM4Sk9QMTNqSW1RNCtFQkt3ZDNHV1A3MUMwaGtYQ3J4MlZSSG42?=
 =?utf-8?B?MDBWaFJiSlBObWYzZlh1VlFoSEZoSVo2SFJmbXk3SnZVUWMyYVViM2lpeUNE?=
 =?utf-8?B?YU5rRCtpZzIrQWpNRmh3U0dTb1dLTE5hckMxc01XcmlxWCtUcFNwRmZ6T3ZR?=
 =?utf-8?B?RzVXZS90amNCTFB3K2tYKzZFREQ0dFpwVW9VNTN3dmZRcnNabnpvV1BKbm8x?=
 =?utf-8?B?RjBWTzNCTTR3Z3RFMzRyQ04zTTVMaHQ4K1VzdndjVVFjWFBTaWRjcytVVVZs?=
 =?utf-8?B?dDZSTTg2RlJBR1hpVll2NDR1Q3BtY1RPeXRlSUN1QkxrTEJFZXZCaHBRUXRB?=
 =?utf-8?B?Y3kxUzhvYWN1RGxyV1hmQWZhMkpvZFRoMFBPUzl2TzBJWjlCOENQVVpneC9p?=
 =?utf-8?B?Q0dtaTFKK1c3YmpiYi9aTEVncXBJNXV2a05xQnliWTh5QU4xRXZ6Q29uK3ZS?=
 =?utf-8?B?QjRDODhZcE5HUmRMUmdkYzkxbHBXVVBmcHN6V2wzODJYQmtROHBFdml5dmJN?=
 =?utf-8?B?cXRCYk5lYnFFdS9qNXpQd1huSU90cXVFUjVNbWZZU3hDMG9DMUJaL0NWbmda?=
 =?utf-8?B?NWdjVU01ZnBPVjhMNkk3OVJKZjhxOGZUbSt5amJJQVZtK0l2VFVVU0lpVFFG?=
 =?utf-8?B?ZW5iejUxNno0UzRUeTAzT1NRd1pjOGp6T3pFODdrZG9KYjBNREdoSTlvSGox?=
 =?utf-8?B?MG94UEppdGptZXcrdjEwSVNrTHhnSTl2VUozVUUrVzh2RTRlNzJvenFXblZ5?=
 =?utf-8?B?L0FVbTd5MG1NQkxHMHFWR0YwcFV1RG5FSXhURW9tNncxalhURVYwK0ZqeG5L?=
 =?utf-8?B?amsrN3lIWlJRbjROeTVVVkt0Tjg2L1JqWTg3TDl5dVM1aTkvRVM4SEdXZzZk?=
 =?utf-8?B?NU1BZU40TlVBbU42VHZmaVFoa21EOVpDazhUZzdSYmFrYlpmUDA5S05PS1VQ?=
 =?utf-8?B?ZTl0Vk1sREdqSktObjdPb0dpNHJKajcrdTlLcGduY3RYazhUZzNPWEt4TFBr?=
 =?utf-8?B?UjJpZW5lbHRnMEt5UmNlZHFCb1hQSDRQUUdmZVFJTkhWaHplV1ZlZTJac2dn?=
 =?utf-8?B?Q1JEbFE2TzNyeFlGT0svYTU2RERyTmFVMDJrN1NrU0V4SnZiZUtxbFVQUVpw?=
 =?utf-8?B?YnJSaENqV2V5c2lsRDBWS3ErWU5kcnlQSnU1U3ROdGFyNmlWY3grYlMzNDN3?=
 =?utf-8?B?WkRwd0duWkc5eUphd04wVnhUUUJkbTJmVmdtY1hUalowYnhnUG1IaXpTTnVF?=
 =?utf-8?B?amROanVMa0h2dEJRMjJvVmNYSldRRUlxNXcxSDJLNEZSWTU5UTAvdGJicEZm?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43CF2CE759124142BA34C5CDD661EFD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa442bf-f2d7-4a2b-af70-08db2a79be8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 02:04:17.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VT69EKMcJhKzV1yt+OOa9uP8DhBOfFaPLERtl7pdlNFNDOyiK9VlQuc+x4LPr1TejcCNFRCjbEcOUxOc0cjX/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5202
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIFR1ZSwgMjAyMy0w
My0yMSBhdCAxODo0MiArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRXh0ZXJu
YWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4g
DQo+IA0KPiBPbiAyMS8wMy8yMDIzIDE0OjEyLCBOYW5jeS5MaW4gd3JvdGU6DQo+ID4gQWRkIGRp
c3BsYXkgbm9kZSBmb3IgdmRvc3lzMS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5M
aW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gMS4gVGhlIGR0cyBwYXRjaCBpcyBzZXBhcmF0ZWQg
ZnJvbSB0aGUgZm9sbG93aW5nIHBhdGNoOg0KPiA+ICAtIFt2MjEsMjUvMjVdIGFybTY0OiBkdHM6
IG10ODE5NTogYWRkIGRpc3BsYXkgbm9kZSBmb3IgdmRvc3lzMQ0KPiA+ICAgIDIwMjIwNTEyMDUz
MTI4LjMxNDE1LTI2LW5hbmN5LmxpbkBtZWRpYXRlay5jb20NCj4gPiANCj4gPiAyLiBUaGlzIHBh
dGNoIGlzIGJhc2VkIG9uIHRoZSBmb2xsb3dpbmcgc2VyaWVzOg0KPiA+ICAtIEFkZCBNZWRpYVRl
ayBTb0MgRFJNICh2ZG9zeXMxKSBzdXBwb3J0IGZvciBtdDgxOTUNCj4gPiAgICAyMDIzMDMyMTEy
MTg1OS4yMzU1LTEtbmFuY3kubGluQG1lZGlhdGVrLmNvbQ0KPiA+IC0tLQ0KPiA+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpIHwgMjIzDQo+ID4gKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyMyBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0
c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiBp
bmRleCA4ZmM1Mjc1NzA3OTEuLmM2YjYyNTM1MDU4MyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiA+IEBAIC0yNCw2ICsyNCwyMiBAQA0KPiA+
ICAgICAgIGFsaWFzZXMgew0KPiA+ICAgICAgICAgICAgICAgZ2NlMCA9ICZnY2UwOw0KPiA+ICAg
ICAgICAgICAgICAgZ2NlMSA9ICZnY2UxOw0KPiA+ICsgICAgICAgICAgICAgZXRoZHIwID0gJmV0
aGRyMDsNCj4gPiArICAgICAgICAgICAgIG11dGV4MCA9ICZtdXRleDsNCj4gPiArICAgICAgICAg
ICAgIG11dGV4MSA9ICZtdXRleDE7DQo+ID4gKyAgICAgICAgICAgICBtZXJnZTEgPSAmbWVyZ2Ux
Ow0KPiA+ICsgICAgICAgICAgICAgbWVyZ2UyID0gJm1lcmdlMjsNCj4gPiArICAgICAgICAgICAg
IG1lcmdlMyA9ICZtZXJnZTM7DQo+ID4gKyAgICAgICAgICAgICBtZXJnZTQgPSAmbWVyZ2U0Ow0K
PiA+ICsgICAgICAgICAgICAgbWVyZ2U1ID0gJm1lcmdlNTsNCj4gPiArICAgICAgICAgICAgIHZk
bzEtcmRtYTAgPSAmdmRvMV9yZG1hMDsNCj4gPiArICAgICAgICAgICAgIHZkbzEtcmRtYTEgPSAm
dmRvMV9yZG1hMTsNCj4gPiArICAgICAgICAgICAgIHZkbzEtcmRtYTIgPSAmdmRvMV9yZG1hMjsN
Cj4gPiArICAgICAgICAgICAgIHZkbzEtcmRtYTMgPSAmdmRvMV9yZG1hMzsNCj4gPiArICAgICAg
ICAgICAgIHZkbzEtcmRtYTQgPSAmdmRvMV9yZG1hNDsNCj4gPiArICAgICAgICAgICAgIHZkbzEt
cmRtYTUgPSAmdmRvMV9yZG1hNTsNCj4gPiArICAgICAgICAgICAgIHZkbzEtcmRtYTYgPSAmdmRv
MV9yZG1hNjsNCj4gPiArICAgICAgICAgICAgIHZkbzEtcmRtYTcgPSAmdmRvMV9yZG1hNzsNCj4g
PiAgICAgICB9Ow0KPiA+IA0KPiA+ICAgICAgIGNwdXMgew0KPiA+IEBAIC0yNTc1LDcgKzI1OTEs
MTAgQEANCj4gPiAgICAgICAgICAgICAgIHZkb3N5czE6IHN5c2NvbkAxYzEwMDAwMCB7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZkb3N5
czEiLA0KPiA+ICJzeXNjb24iOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAw
eDFjMTAwMDAwIDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbWJveGVzID0g
PCZnY2UwIDEgQ01EUV9USFJfUFJJT180PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbWVk
aWF0ZWssZ2NlLWNsaWVudC1yZWcgPSA8JmdjZTANCj4gPiBTVUJTWVNfMWMxMFhYWFggMHgwMDAw
IDB4MTAwMD47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICAgICAg
ICAgICAgICAgfTsNCj4gPiANCj4gPiAgICAgICAgICAgICAgIHNtaV9jb21tb25fdmRvOiBzbWlA
MWMwMWIwMDAgew0KPiA+IEBAIC0yNjA0LDYgKzI2MjMsMTcgQEANCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmc3BtDQo+ID4gTVQ4MTk1X1BPV0VSX0RPTUFJTl9W
RE9TWVMwPjsNCj4gPiAgICAgICAgICAgICAgIH07DQo+ID4gDQo+ID4gKyAgICAgICAgICAgICBt
dXRleDE6IG11dGV4MEAxYzEwMTAwMCB7DQo+IA0KPiBTbyBpcyBpdCBtdXRleDEgb3IgbXV0ZXgw
PyBPciBtYXliZSBod2xvY2s/DQo+IA0KPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLg0K
PiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2RldmljZXRyZWUtc3BlY2lm
aWNhdGlvbi5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvY2hhcHRlcjItZGV2aWNldHJlZS1iYXNp
Y3MuaHRtbCpnZW5lcmljLW5hbWVzLXJlY29tbWVuZGF0aW9uX187SXchIUNUUk5LQTl3TWcwQVJi
dyFrVFRQSFZrUlNLeUlfbHpKTHBUQUFEcjJkXzBPQ3pIMDgzQU1UVHFzRU03bGdUN1ItMEVTMllQ
ZWplSlVicUdTUFI3Q1lMQUxyNkZzTlotVkxPaklwTUFGa09zdiQNCj4gDQo+IA0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KDQpNdXRleCBpcyB1c2VkIHRvIHNlbmQgdGhlIHRy
aWdnZXJzIHNpZ25hbHMgY2FsbGVkIFN0YXIgT2YNCkZyYW1lKFNPRikvRW5kIE9mIEZyYW1lKEVP
RikgdG8gZWFjaCBzdWItbW9kdWxlcyBvbiB0aGUgZGlzcGxheSBkYXRhDQpwYXRoWzFdLiBNVDgx
OTUgaGF2ZSB0d28gbXV0ZXgsIG9uZSBpcyBmb3IgdmRvc3lzMFsyXSBhbmQgdGhlIG90aGVyIGlz
DQpmb3IgdmRvc3lzMS4NCg0KVGhpcyBpcyB0eXBvLCB0aGUgbm9kZSBuYW1lIGlzIG11dGV4LiBJ
IHdpbGwgY2hhbmdlIHRvDQo9PiAgbXV0ZXgxOiBtdXRleEAxYzEwMTAwMCB7DQoNCg0KWzFdbXV0
ZXggYmluZGluZyB5YW1sDQogDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL21lZGlhdGVrLG11dGV4LnlhbWwNCg0KWzJdIGFybTY0
OiBkdHM6IG10ODE5NTogQWRkIGRpc3BsYXkgbm9kZSBmb3IgdmRvc3lzMA0KDQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
Y29tbWl0L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2k/aWQ9Yjg1MmVl
NjhmZDcyMjI5NDE0NWQ4NmJiNGQzODNkNGFkNGFlMjcwZg0KDQoNClJlZ2FyZHMsDQpOYW5jeQ0K
DQoNCg0KPiANCg==
