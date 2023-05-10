Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0776FD39B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjEJBpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:45:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332163589;
        Tue,  9 May 2023 18:45:10 -0700 (PDT)
X-UUID: 4846efc4eed411ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Mci9JA94CLKR1zhS0NT3y5rtZHg+p+CHpeuKzTeiSrg=;
        b=mAb9MEh7irI51z/qOw2Krl4GdySM+c/h8i0D0skbQ8kz2t2F4zPrmfMpQg9khm5IATmtolTYIKfltCsXT2RzXMruM+eab8ZO1I1wOezDrvZnmuh1L9VVujVz2v3kG6FIwOFt45+A1rxN7hu+mYmj+slysNZRjFzPxRdOvawgi2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:163cb710-9b33-47d7-9a1a-62401886d460,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:e607a73a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4846efc4eed411ed9cb5633481061a41-20230510
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 461327740; Wed, 10 May 2023 09:45:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 09:45:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 09:45:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7KbiXXw+mUjj/Gmo20PM97ISx7HayCfJx4BDn1YZnYU/uiEQ+Y9bTVk1nf6m2j20W7o76eaVy5nSHJ42v3D4fYQNvHvpKHeRD7oBm1emmnRj7hheWTe0oPDi+TWh0REG201LlpwTvh0RKpMeQG4W85FNhusc3n6pHfdsMbLpS/VT935IqD8TFlh4dol0T6bderTVP7dcmKcda1oIb3rIeeVvnZqCEj4mXS35QakYDHBn+zS9pmcc5BLesxcLA0GVMUxSmRcyNSt6s170zA0TxO8n3mUmUgzztBbeN54rjYE6sJd05kN6VZvg3TvZVH2Ggb+cDbc8bZKyUYO5o1ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mci9JA94CLKR1zhS0NT3y5rtZHg+p+CHpeuKzTeiSrg=;
 b=moUwaly7t7EPh854xi19VtGXPv+a8B3UEXjb7WDVHv6Pi15d02OnUiP2H421UHNYuQlBHQU95JmTfzNHFJvc9PMoa0xoTqBrBk7tVinX7QbRk24YN84WZTTnOTKrkxJ8b8nuN4d+qcxzurgyDEkFnaPolSwEvH2n8Efe08HTxZi+augyg+6puoNpSp6iUfQ/AWmhg5E5deoQFus/ImLLJUZE1RU3vVsxv2tLCSHMPg7CE8wGNUH29eaJH7YQFO1aAYJM5c0a6s7kXUsYTHaPSUGEVne1M6UpjB4i67PaUr/qAfFUWZYAZTPBO+PZfTsm/PUgjOeCVsxo2SB+z9MQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mci9JA94CLKR1zhS0NT3y5rtZHg+p+CHpeuKzTeiSrg=;
 b=qmZqswBIbEsSdilfFBGKLo8/zNyzbAvWsyYTbshCGbLB1BteX/7zLUMrRD3SYZQJH+tZLR+yy8Ha8hj6z6kwInlZYpDpOM+GKPRTgOyTWSHwQnqxFlkYKLF3Kdf8DRJrMLdJ0XfpryX4nzBaTiWFJyCVG8+Gv2Gh4ziXcE1LEVw=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by JH0PR03MB7927.apcprd03.prod.outlook.com (2603:1096:990:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 01:44:59 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%8]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 01:44:59 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZcoh+h8jvgTjyLUifN3snv7Ofu69RzFuAgAEQoQA=
Date:   Wed, 10 May 2023 01:44:59 +0000
Message-ID: <e5b372cc699588f362eca2e3525daad114af4341.camel@mediatek.com>
References: <20230419063048.10516-1-wenbin.mei@mediatek.com>
         <CAPDyKFreikcPGVyhbrfU6LA+fATiA6M5M-5H6EhEHU3DbjkNVQ@mail.gmail.com>
In-Reply-To: <CAPDyKFreikcPGVyhbrfU6LA+fATiA6M5M-5H6EhEHU3DbjkNVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|JH0PR03MB7927:EE_
x-ms-office365-filtering-correlation-id: 04d5b739-7dc0-4c7c-e716-08db50f82a78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rr9lqqRZoOq5GcmQEZeI/hmCuy6Va4cNgooux+f6XdIvL6LMlpp8KhaB4biFtcLM5gIWjyoc7ezejYA4b5gA/t0iZUUIRMYHQBygNfVXY+7cmrsY4GFcLcI4D3rCrzjHNU+LONcwOdjwqFf+gKGVS5WvGlS1aWqzYuhh2es1GhuDANlPzLnbYO8Zh9rBOyLsX3+H7qOcwIJ8Qt1Sq7+ZggAH8aeALfeKIYg7bOYQQHGkj/a52nkUFEeXp4jnvkdiL/2KZEqcd2ycFW2xdJ4/4mGkTfnoFK7WyWa8/BFx/uB0wf8/xzWliU7DVyBTLdgWUGY8aMikv7kg4aGzLXv1Uf3sWXxk4GYVtQbY8KgmbLn2fcAzBQE4Zgsycd9VnS011fzr5dtcOkUnHlCJyd7lRHBAWDLRhJ01R3j6XJhlZXschd37Dz6NG+jaeaZ2JoyGxkDZ2puL4Ft82hni0mMceCczxsfnbrmkxb6xXrju2RzN/KYFpBWGrlfGUJVFjh/xrCpmVLEXVJC0dL75/qjhEbUFiiojsYS2I3i5pzz+ncuFFCuAjyhbqR6i2Soy4BIb8cnGE90zDB6Uj09L+GmNU9ieRnchKpa0380JE43/rwsVSw6yGJuX0bV7ejgqWu8BJSMpnVMu4gBinAvHWhm2gsbEgw1ikKSt0WMOiG6wbFs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(186003)(54906003)(86362001)(478600001)(36756003)(85182001)(6486002)(71200400001)(38100700002)(38070700005)(2906002)(5660300002)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(122000001)(41300700001)(4326008)(316002)(6506007)(26005)(6512007)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZjYTZ6U2tJRjJxZzJwR1M1MFI5MWpIME80UXZ1dy9lY0FrWVI2YlZMS2lU?=
 =?utf-8?B?K0lrMTV0QS9JaEtncmFqcjZ2bXVQNXFQWVh3RGo0TGlxSm5FcVV5c2h3Rzhz?=
 =?utf-8?B?Ny9XUDNQMHpTb1ovZGhiN01xcUIwbGtsMzc5TkltSHpPZG1VbXBwWkxReG1t?=
 =?utf-8?B?d3N5RHZyckF6K0pxbjRYaHpPd2JVTmlFSEZyaUJ2TURYWC9rcXl3eVVpaG15?=
 =?utf-8?B?WEVpWGFNUXNGSVNJOER5Z0dKcWdVZnVvUEtyaFJuQVFBQmcxZTRTeTZKTW9y?=
 =?utf-8?B?UEpKV0d5R2hiQzdoVzZ3c2xJVDM0dHYvcGxzY2x6b0tVZEF6eWRBT1BvSXlj?=
 =?utf-8?B?UEl3bWMxNnNLdXJkWmtUbGpOSjdUeEt0Sm5rcDhZb0t5NXFFTjFWem1EUEpq?=
 =?utf-8?B?ZUY2eGJ6ZktxUnFLelV4eTN1SzgzVjNubXJ4ZndaOG56VEwvQnQ4UHUyblNx?=
 =?utf-8?B?TDNLYTYrSDNoZVFxVjljYUJKZHBKZVFheTgzUStFZHgxK0YwS0pzMHFDNWlX?=
 =?utf-8?B?citqaXRGbTcxM0Rub01qL2VCZDJ3VHZQbFJiczg1VlF0aVNudElNc01Gbi9L?=
 =?utf-8?B?VXdhc2tLa2RiVmo1eU1lcDRxa29CV3NBcmw3WXFrSU1teUZibjZQSk1hUlUy?=
 =?utf-8?B?dFE0Nk5XKzRJQzI4Qm9ZODIrOW5YT1RIRkFDRG05V21abWVZQyt3WEc5MHRC?=
 =?utf-8?B?d3ZvZ2NVbytwbW9hd2w3S0s3RzJ6UnpLMms1dHBkVEZ6Q0NGdzZFZVJiWDZQ?=
 =?utf-8?B?WVpNaGpGVUhURlRRbUsyOHcvMmJDaVF5aEYwMVpFakFlQUZQZnhqRHdPTXEr?=
 =?utf-8?B?QWUyMmYrUld6Q1h2WXpZWmJyakw3T1NZTEIxamQxR3lJc1ltMS9jRFR1NitE?=
 =?utf-8?B?ME1BekE5elM1M1RjaDhoWGRPRlNUS2tzeXhMa2E0UkxFaWFlUHJGOVBTTWdG?=
 =?utf-8?B?L2NJbzBLVXo0ekREM2d4QW1VQlNoWVMzTVJ3OXdpVWpXWXpCWmp4VDhvSTdE?=
 =?utf-8?B?WlNVSGpVR1lmbC9rWUpVTjhIOFE1UTY0emd5UnVXZ3hYSGF0RldqdndtOERl?=
 =?utf-8?B?R2JWSmpZaW1jRnVUR2FadkRDRENERjVTNnZKNXdwVDZJVHMvUUJzZFgrelhB?=
 =?utf-8?B?ZS9pQ1N3dzc3YXRyZjJ2bU5Jb3N0cWlLUlZ0OXVtTXRVbmorMlVNcG5LbjRH?=
 =?utf-8?B?ZzYzbHhxSFozMUpHQ3MxdHNNNklyZVZUQllQeVJORXVBQ091TGhRZ1ZwUVQy?=
 =?utf-8?B?dTJYZVR2WjZOL3NxblpqdVl4V1RHS3RZTlRVY1RNVS9EZ0hWQ0dBTGp6QU9p?=
 =?utf-8?B?UUNBOFpYR1ZDZGcrWlcyUTFhWExXL3ZlUWZtVklzMjlueFRWRGtQMEtUdVRy?=
 =?utf-8?B?ZXFqYVFHanBXUVRZRm9vK1dPblZPZWVvVUh1V0JZRGl0QnAvdmNleXVHM0s4?=
 =?utf-8?B?dU05U1ZpbzVyUVAwWXdUSzRVTkF3UG4zeko4Nkw3S3AvQjhpbkhMR3BpU2FP?=
 =?utf-8?B?dmRKaHV6TmNsUjVuMVg2R3lvelllUWZmaktweEF3Z2x4Yk5PQkxiaHE0Qk1F?=
 =?utf-8?B?Vms0Z0ltaStKY3RITWlLWVc4YUFKUkNhVE1hTzZmMEg1S09veG5lZ1NkL2VY?=
 =?utf-8?B?U1BFQU9VY3VPWkg3NFVnQStaZGVHZm9wajJqenJsVGdUTjYvdzM3VVdXNFhV?=
 =?utf-8?B?YXZQNTJJOW5WcEFSSWhKc3dHUXhpV2h6K2pUYUo1NW43SmFiSUtRMUFjakpn?=
 =?utf-8?B?bUlFZ0dONlk5WGFtRE9ZbkNvRGkrcTZxUUZvRXJyaGpXZWM0OXdhajQ5SldD?=
 =?utf-8?B?L1g3b0pSTldneFEvM0QvanlablVxV2JySXpRWDhJNnJTcGQ1bFdhRFdacDkz?=
 =?utf-8?B?cWJPWGVrZzhvc2pzVHZkZjhhNDQ2NENuUTdkbE96ODFsaGx5dGF2dUpjL0VN?=
 =?utf-8?B?VEVQQ29jcGl0a2VRdXZFcXh4cURFRUNjVkY1T1pwYWlieTJ4V0oyam5PVVV0?=
 =?utf-8?B?SXNtRGRMQnp4NktkVzFmK1l5Y1Y5SHhmbUY3YTlyZVkyRjVOUE5qQ0hLODFG?=
 =?utf-8?B?ZTNBTjk2S1RFT2dYdFZxT2dJejg4OVpRYS9xRG1ONnY3dkRQb2J4bWdJcnVQ?=
 =?utf-8?B?L254V0RoYzlRRUt6QUR4bGpvZjNOclZGazNFSURiNVlBRDhBTXFwdHRQZmFW?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADE44C7F935C894A9F1C1EDD09B42168@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d5b739-7dc0-4c7c-e716-08db50f82a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 01:44:59.7384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG7ULlmPqN4996UJUgMozh8OASs453Sjs29/s8rtFiaFg7Esgx2h/oKcVmJMfmqwhM2FLluaDzrthRjkpZjKXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTA5IGF0IDExOjI5ICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBXZWQsIDE5IEFwciAyMDIzIGF0IDA4OjMwLCBXZW5iaW4gTWVpIDx3
ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gQ1FIQ0lfU1NDMSBp
bmRpY2F0ZXMgdG8gQ1FFIHRoZSBwb2xsaW5nIHBlcmlvZCB0byB1c2Ugd2hlbiB1c2luZw0KPiA+
IHBlcmlvZGljIFNFTkRfUVVFVUVfU1RBVFVTKENNRDEzKSBwb2xsaW5nLg0KPiA+IFRoZSBkZWZh
dWx0IHZhbHVlIGlzIDB4MTAwMCwgbm93IGNoYW5nZSBpdCB0byAweDQwLCB3aGljaCBjYW4NCj4g
PiBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBvZiBzb21lIGVNTUMgZGV2aWNlcy4NCj4gDQo+IFJh
dGhlciB0aGFuIGp1c3QgcHJvdmlkaW5nIGhleGFkZWNpbWFsIG51bWJlcnMsIHdvdWxkIHlvdSBt
aW5kDQo+IGV4cGxhaW5pbmcgYSBiaXQgd2hhdCBpdCB0cmFuc2xhdGVzIGludG8/DQo+IA0KPiBG
b3IgZXhhbXBsZSwgInRoZSBkZWZhdWx0IHZhbHVlIDB4MTAwMCB0aGF0IGNvcnJlc3BvbmRzIHRv
IHggbXMuLi4sDQo+IC4uLiBsZXRzJyBkZWNyZWFzZSBpdCB0byAweDQwIHRoYXQgY29ycmVzcG9u
ZHMgdG8geCBtcyIuDQo+IA0KPiBNb3Jlb3ZlciwgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEg
Y29tbWVudCBpbiB0aGUgY29kZSB0b28sDQo+IGV4cGxhaW5pbmcgd2hhdCAweDQwIHRyYW5zbGF0
ZXMgaW50by4NCj4gDQo+IE90aGVyIHRoYW4gdGhpcywgdGhpcyBsb29rcyBnb29kIHRvIG1lLg0K
PiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0K
SSB3aWxsIGZvbGxvdyB5b3VyIGNvbW1lbnQgaW4gbmV4dCBjaGFuZ2UuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gaW5kZXggZWRh
ZGUwZTU0YTBjLi40ODMzNTNlYTNhOTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9tdGstc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBAQCAt
MjQ1Myw2ICsyNDUzLDcgQEAgc3RhdGljIHZvaWQgbXNkY19oczQwMF9lbmhhbmNlZF9zdHJvYmUo
c3RydWN0DQo+ID4gbW1jX2hvc3QgKm1tYywNCj4gPiAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5h
YmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbXNk
Y19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPiArICAgICAgIHN0cnVjdCBjcWhjaV9o
b3N0ICpjcV9ob3N0ID0gbW1jLT5jcWVfcHJpdmF0ZTsNCj4gPiANCj4gPiAgICAgICAgIC8qIGVu
YWJsZSBjbWRxIGlycSAqLw0KPiA+ICAgICAgICAgd3JpdGVsKE1TRENfSU5UX0NNRFEsIGhvc3Qt
PmJhc2UgKyBNU0RDX0lOVEVOKTsNCj4gPiBAQCAtMjQ2Miw2ICsyNDYzLDggQEAgc3RhdGljIHZv
aWQgbXNkY19jcWVfZW5hYmxlKHN0cnVjdCBtbWNfaG9zdA0KPiA+ICptbWMpDQo+ID4gICAgICAg
ICBtc2RjX3NldF9idXN5X3RpbWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAwMDAwVUxMLCAwKTsNCj4g
PiAgICAgICAgIC8qIGRlZmF1bHQgcmVhZCBkYXRhIHRpbWVvdXQgMXMgKi8NCj4gPiAgICAgICAg
IG1zZGNfc2V0X3RpbWVvdXQoaG9zdCwgMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgY3FoY2lfd3JpdGVsKGNxX2hvc3QsIDB4NDAsIENRSENJX1NTQzEpOw0KPiA+ICB9DQo+
ID4gDQo+ID4gIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2Rpc2FibGUoc3RydWN0IG1tY19ob3N0ICpt
bWMsIGJvb2wgcmVjb3ZlcnkpDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPiANCg==
