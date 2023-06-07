Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7E7256AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbjFGIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjFGIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:00:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110C184;
        Wed,  7 Jun 2023 01:00:23 -0700 (PDT)
X-UUID: 57da9ca6050911ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4EQMpPx40f+DauxwTmfm/2R/LVxHvwVsq8EbnTpqhqU=;
        b=bycK+/wifu8U1Qx22cOy1G+2bv3XcPC2j3vlUoYJ6Gbfo8htRXrSzOyGMReR324Jqbm1POhC4zrftxvK8mJqFLbBB9N9x1mqTwXOMH4dNdy/w4m2ynXy0AxHOdHF8Lxx1Huha8ubDK5wkI9CAwqgXeg1Xns+Yr5IG+DpmCTnIYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9fac1adc-c722-46ae-bf0c-89eaa7082703,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:9fac1adc-c722-46ae-bf0c-89eaa7082703,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:7cf5a63d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230607160019II4Z05EA,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 57da9ca6050911ee9cb5633481061a41-20230607
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1805750844; Wed, 07 Jun 2023 16:00:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:00:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:00:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzU9nM1+F3VX43b8PJMNOBN8Du4YigyQ/eOkb34pS8KYbwtf55WkaoqBWzaI0T0mgLLmFRRax4zUPYbzvd/ZvrbKuPbTeWPvEHpM+8GejjPeAeCaswNYyKZHZ3pKdPXvCxaia9L6mUZXv6a+jZ0UaOGP7NOn7eHOIdVQxoDPHQGdtEWDhfqAaOsUGlKbtkU2Ahs/PO+q+njDXq43AEF1WBOONeLQOcoMPul4f+PNa0y22ywoDLYi0I+50niqDdHktkE6tLTnM4VuERZCT8UuIPk1HT8cUF+Xfpcg3VCsdbjT/8Pi+256Bzv/MxqEXklzLr49aTO1XCuSVEuk0qbLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EQMpPx40f+DauxwTmfm/2R/LVxHvwVsq8EbnTpqhqU=;
 b=J3HigUqokp7pzbsQBzCXz2RFEo9YEtACLkjCSndh8iqW32ih0EI8fTUbk1CTBRTNNZR1HVFIVr1vDCkD1VcZvGVh7LPASWsJxEhc5mv82fSPF1B1loNyMceL8N35oXh8na66W14Pdl4/mhHwUObAAGz4vMngJHFokhfUd91jJijtShlg3yxyP5z+aMgEPFGK5OGjZ8usNBMBvqez1UN5YCqgjYIwiFP5R1wV2a/Hv6pEslP7NsUpUBZTTJQ9RLl9Z9bIjhRVcjenCNNiMhBoCkemMtcB/ivuM5vXz3++l9O5cAZ+SwxFA88Yt9TRGJwTsi/mwcpMlQOrusgZiFZZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EQMpPx40f+DauxwTmfm/2R/LVxHvwVsq8EbnTpqhqU=;
 b=cu+lB+txRxgYnDLqez8Ha0wxuBy/x0ESc3pqPtRcjscSpa7Il/xEtJn7ILvOJURxGsIHEDSUndGYAg3sds0b0h6fvKKE2ZGxxmf1yFUWtmRlx9ggJ5fzF/F6zZjt5EUOzz5zFh4ikZEichzNlyUY2Hvkxzj1+btDHGNtQkcm5ew=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB7929.apcprd03.prod.outlook.com (2603:1096:400:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Wed, 7 Jun
 2023 08:00:14 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::2648:bb51:77fb:125b]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::2648:bb51:77fb:125b%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:00:14 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on
 single-core SCP
Thread-Topic: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on
 single-core SCP
Thread-Index: AQHZmREWM9sf5lt/10GGmQUprBIKY69+9UIAgAAEyIA=
Date:   Wed, 7 Jun 2023 08:00:14 +0000
Message-ID: <9c710fca38ba53da3ba1aaf32a2221676eb584be.camel@mediatek.com>
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
         <20230607072222.8628-6-tinghan.shen@mediatek.com>
         <d8053fc1-cace-b14b-57c6-387c0d664837@collabora.com>
In-Reply-To: <d8053fc1-cace-b14b-57c6-387c0d664837@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB7929:EE_
x-ms-office365-filtering-correlation-id: a75fb6a1-cc76-4cfb-a96c-08db672d39e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZ+uiT63pPh7oWwH6aP7PDylHPhZGIc/2ciAYBj2j3QAJNgkEb011mxMEwbo1q3gIlXRrNGWm0ad+9mohbgdNXamyMuU2TQegCe9RI1/h3KZMtnqteP9g93W5LKvNGpbXr5uxz8zUPAJaQatL+zXUGpGrEeNY1A8nR65NJ2/4ShKvCa9juTjqtWM4/Fupz+bJxv0mGBbLeM5/DwMufQOlZn3TXAVi5D+3iwFzQ41Lk2/BqVdy63TFi3KFIdmFpDHQobSL5ofnow4r9yMhcVNw/TBySzdOkcer9DYqfuQHrOPG88PGSkopI7DhjekjE/aFPRHqLu4iMgI8wlovX55utD4a92olTr9y4UYVe8PsEFc9V9KdVGQPfpkp2Dd523tbYYLEjOybYj2tpwaocdpVn8c9CVJd/UbwQFMcNbmkbFcEIv5tCmH/qLrXWezAO20tPhG13fqEw892iRzc6O5Jlq0U7iDvYX077Ka3OjlF3L9xPL+hHHkFAkvgACdJTsowzpQn6EqxAcU1x1QFBlLLcRmxvZa2L3GEpJCdji/bxnUs0DscCQh3RTH0YdO0KA+KA/4IrR2rQ9uT4OV95ILWVFCPTPXe+ZlEnNCAZXPLzyI47zxDMtkqduuAEMPt7jmglRiPsEYaxOIPm7h8y0KqZan2hMt+zgKehYU36QXRu6f6dhbwnW7ycKQM+G+AoIROndY6Wgzzhp0zvNsQrS0QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(7416002)(107886003)(6512007)(26005)(6506007)(122000001)(83380400001)(5660300002)(2906002)(186003)(85182001)(41300700001)(36756003)(8936002)(316002)(2616005)(8676002)(38070700005)(86362001)(91956017)(66476007)(64756008)(66946007)(4326008)(38100700002)(54906003)(66556008)(66446008)(71200400001)(110136005)(478600001)(76116006)(6486002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVd5K2R4SzVtWjg2TkpsVklsZEFldWFCQ3RNdEFuNTVkRXgyTmFneVB2bExj?=
 =?utf-8?B?NkZGSmd2Ty9PMFpsaGxCTDBUMVpSdkRqQmhJVkJVRE1udEcva2toV0xobTgv?=
 =?utf-8?B?S2N2SDZXbXpBUm9VVnM1Z0t5V1RtTFJPQzlhaFBtdjZabWx6K0JBdzBZYjhT?=
 =?utf-8?B?Rkl1d1Y3MDJSWVRxLzFhQThPZk1iNGJUOVBwRFFmVCs4VVU3c2RzRHZVNXla?=
 =?utf-8?B?NE5oazkwZXhlZDlZZ2NJNytuTjU0NmZwa0NpRlVDZnBIUldXU1BvVC8ybFNs?=
 =?utf-8?B?ZDRwdFR4cWJYNHhEMnZUdXlrazdJeVVONDJuWUxIMnFsMjlXQ3MrcitDNlB2?=
 =?utf-8?B?Y1hjdUJKMVNSZlBhTXhxRU1sU1BPRURkb3VMVU04cVZlVkNFREl3R0Y3TXEz?=
 =?utf-8?B?dmY1cXQrbVFTNXVUYVR3ellsQTVCdWlGdGVPR29ReTJjbjArWGlWaUVSSTNr?=
 =?utf-8?B?WjI1MmhEUUV0VGd2a08vLzFkN3ByVEtHSy81V0JEdGg2b1NvTnRoVjllY2Rn?=
 =?utf-8?B?amlJNGh6WERXUlBWbjNINmc4RGRRelN6bTR5Vjh4TGlCdnNuYTZmckhvNHdy?=
 =?utf-8?B?RmgycmhoNEJMUGxhU1kyRkk1eVpzaWRvcUk3TFNXZzZYZWF6RzZNcVVUQXlo?=
 =?utf-8?B?Uk82YnNVMGRUc1FmZWxERGhuNHZodXJ1L1ZTd0FjZnU5dFpCQXR6NHFyOHdp?=
 =?utf-8?B?T3FKZWU5b2ZJdjcyV0hYYlJGNDAvdkhoOWR4bXdaT3pWZFZDN1luZU13TFdP?=
 =?utf-8?B?S2RRQTMyaUxYYk0za3pwdG1NaFdmaVhHbFp1eWZ4U0YvRzhxN1VlN3Vsb2pS?=
 =?utf-8?B?Q2d4QnY3bFVoZVZ5RHF6TEFjcjdHTnVETkY5UVBiSisrUmg1aDFVRXREaDJ0?=
 =?utf-8?B?cDAzeGZod2tIbGl4cjQzaFdZSU5vWnRMV1pHeDluOG8vTTVGVkhZN011bE0y?=
 =?utf-8?B?aFpGQWRPSFk4eGRYOXZLU2hRRHZjbmFIMUVUTEVuL3hpN3l6bmprT1I1RDVM?=
 =?utf-8?B?L0lyYktZU3dYY0JuYWUwZDFwU3lNNjZDWkxZbFVHV3JlMDByRUphT2lUVTgw?=
 =?utf-8?B?ZkRNWWVvZWllSS9mb1BRZmQ1WHA3NkJacmo4UkM0ZDg5eFFMeXkyZ0pOeU1s?=
 =?utf-8?B?dFJhQTVWYVRqVS9YRC8rZXJ1OUhYKzhLRTl2NHlNZkhmUWtsNGhPQlMrRHhx?=
 =?utf-8?B?SkR5YkVrL1pINCtsZWVzUXZXNjBYOW0ySDdFNjFTdHBqeHZxNVRwbHdDK09z?=
 =?utf-8?B?a3JUT29EaGhSZXNMdTBvMGw2S1FZVWFDRXhWcDFIWlV3QTJsQlRqN3Z0ZWwz?=
 =?utf-8?B?SXhjMmd5OEtZNStBcG5VL1FyYnIxSlNhVXpZY3ZQWEpDOGJWWjVWNWhDUXN5?=
 =?utf-8?B?SEIreERjeURkd1Zsc1NBejJ0ZisraFoyV3dOaGhrQnpEV01vK3dVSWJING1V?=
 =?utf-8?B?eTdRYTJGcS90ejY5Z2I4cFE0V2ZVcjNHK010S0xsWis3cVYycG83Slk2YUo2?=
 =?utf-8?B?ZC9GcVgwV01WR1pmbTBPaFhFMWd1NVN4M3lDbE54eXRKVi9ZSEh5Mnh5c05P?=
 =?utf-8?B?SDNFY09LRmZXcEJyenhDeDVUWFVQY3FuWGVmYXV6emhtY2dmL1NJQkkwcUt6?=
 =?utf-8?B?R2NqWjNJbzFoc0lQTy9LT1BPMmhsY3dWRVZjaUVLR2xqUURqelJQWDdoTm8y?=
 =?utf-8?B?b29sM3NWU0N3TnJ4WmZqVUdpK1UyYUFnVVB2ZXo3dXZxVzluKzhxZ25RZ0xB?=
 =?utf-8?B?RGg0dnhRQ050dFdrWkpsT3U2czBrNEZkRjhBWE1CY0VMc1BndW9IVkU3WTJp?=
 =?utf-8?B?Z0VQajJzay9CVERiZnVBOEtjR2RoK3hNazhBT0lGb1lTK3ZNNkgwSi8rOXNo?=
 =?utf-8?B?eWFDcVVBMUJ0Y3pzbE5HMlBiZ1BxcCtVa0JDMlF0bEZ6MkFpUDRZbndmVjU5?=
 =?utf-8?B?Q1hHZU9HOEM1YjAydzV1L3V4M1hPQjZUWTJDb0cwRnZHWk5WRzB0dHphcGF6?=
 =?utf-8?B?UWxjbWgzWXhzNHlKL1BPU2tac0NlZy9MOEs1V0ZRTFRRK2xqcGdxalBUbWY2?=
 =?utf-8?B?WjZ1V1JCdGdXK3ZsWVN3VGFBUWpNREdRRkpyQ3pvS2VYbzM5ZVZQOFVSRkZk?=
 =?utf-8?B?YzJFMDNHRlZFRkc0dWF1ZGxpVTJWb1pIK0lsdHNFVHFJZ0RvcGJDbk5QYzJY?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BCEE055C59A846B392FAD7F64C949F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75fb6a1-cc76-4cfb-a96c-08db672d39e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 08:00:14.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +i/N6BwsOH3LjwSbJpAD1uO/+dA15qY2UE5EN7Edlo2pXW8WTTo+czUvyurrXcK3Oi3GWPUl+jBiLRjZkwJnWWgYPIVpczqLQQpfBlKkAPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBXZWQsIDIwMjMtMDYtMDcgYXQgMDk6NDMgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwNy8wNi8yMyAwOToyMiwgVGluZ2hhbiBT
aGVuIGhhIHNjcml0dG86DQo+ID4gVGhpcyBpcyB0aGUgcHJlbGltaW5hcnkgc3RlcCBmb3IgcHJv
YmluZyBtdWx0aS1jb3JlIFNDUC4NCj4gPiBUaGUgaW5pdGlhbGl6YXRpb24gcHJvY2VkdXJlIGZv
ciByZW1vdGVwcm9jIGlzIHNpbWlsYXIgZm9yIGJvdGgNCj4gPiBzaW5nbGUtY29yZSBhbmQgbXVs
dGktY29yZSBhcmNoaXRlY3R1cmVzIGFuZCBpcyByZXVzaW5nIHRvIGF2b2lkDQo+ID4gcmVkdW5k
YW50IGNvZGUuDQo+ID4gDQo+ID4gUmV3cml0ZSB0aGUgcHJvYmluZyBmbG93IG9mIHNpbmdsZS1j
b3JlIFNDUCB0byBhZGFwdCB3aXRoIHRoZSAnY2x1c3RlcicNCj4gPiBjb25jZXB0IG5lZWRlZCBi
eSBwcm9iaW5nIHRoZSBtdWx0aS1jb3JlIFNDUC4gVGhlIG1haW4gZGlmZmVyZW5jZXMNCj4gPiBh
cmUsDQo+ID4gLSB0aGUgU0NQIGNvcmUgb2JqZWN0KHMpIGlzIG1haW50YWluZWQgYXQgdGhlIGNs
dXN0ZXIgbGlzdCBpbnN0ZWFkIG9mIGF0DQo+ID4gICAgdGhlIHBsYXRvZm1yIGRldmljZSBkcml2
ZXIgZGF0YSBwcm9wZXJ0eS4NCj4gDQo+IHMvcGxhdG9mbXIvcGxhdGZvcm0vZw0KPiANCj4gPiAt
IHNhdmUgdGhlIGNsdXN0ZXIgaW5mb3JtYXRpb24gYXQgdGhlIHBsYXRvZm1yIGRldmljZSBkcml2
ZXIgZGF0YSBwcm9wZXJ0eS4NCj4gPiAtIEluIG9yZGVyIHRvIGtlZXAgdGhlIGNvbXBhdGliaWxp
dHkgb2YgZXhwb3J0ZWQgU0NQIEFQSXMgd2hpY2ggZ2V0dGluZw0KPiA+ICAgIHRoZSBTQ1AgY29y
ZSBvYmplY3QgYnkgU0NQIG5vZGUgcGhhbmRsZSwgbW92ZSB0aGUgU0NQIGNvcmUgb2JqZWN0DQo+
ID4gICAgcG9pbnRlcnMgdG8gdGhlIHBsYXRmb3JtIGRldmljZSBwbGF0Zm9ybSBkYXRhIHByb3Bl
cnR5Lg0KPiA+IA0KPiA+IFRoZSByZWdpc3RlcnMgb2YgY29uZmlnIGFuZCBsMXRjbSBhcmUgc2hh
cmVkIGZvciBtdWx0aS1jb3JlDQo+ID4gU0NQLiBSZXVzZSB0aGUgbWFwcGVkIGFkZHJlc3NlcyBm
b3IgYWxsIGNvcmVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmdoYW4gU2hlbiA8dGlu
Z2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcmVtb3RlcHJv
Yy9tdGtfY29tbW9uLmggfCAgIDIgKw0KPiA+ICAgZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3Au
YyAgICB8IDE1MSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxMTIgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmggYi9kcml2ZXJzL3Jl
bW90ZXByb2MvbXRrX2NvbW1vbi5oDQo+ID4gaW5kZXggYzA5MDVhZWMzYjRiLi41NjM5NWU4NjY0
Y2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19jb21tb24uaA0KPiA+
ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmgNCj4gPiBAQCAtMTI4LDYgKzEy
OCw4IEBAIHN0cnVjdCBtdGtfc2NwIHsNCj4gPiAgIAlzaXplX3QgZHJhbV9zaXplOw0KPiA+ICAg
DQo+ID4gICAJc3RydWN0IHJwcm9jX3N1YmRldiAqcnBtc2dfc3ViZGV2Ow0KPiA+ICsNCj4gPiAr
CXN0cnVjdCBsaXN0X2hlYWQgZWxlbTsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIC8qKg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jIGIvZHJpdmVycy9yZW1v
dGVwcm9jL210a19zY3AuYw0KPiA+IGluZGV4IGQ2NjgyMmRhZDk0My4uYzhmYzZiNDZmODJiIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMNCj4gPiArKysgYi9k
cml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4gQEAgLTIzLDYgKzIzLDE0IEBADQo+ID4g
ICAjZGVmaW5lIE1BWF9DT0RFX1NJWkUgMHg1MDAwMDANCj4gPiAgICNkZWZpbmUgU0VDVElPTl9O
QU1FX0lQSV9CVUZGRVIgIi5pcGlfYnVmZmVyIg0KPiA+ICAgDQo+ID4gK3N0cnVjdCBtdGtfc2Nw
X29mX2NsdXN0ZXIgew0KPiA+ICsJdm9pZCBfX2lvbWVtICpyZWdfYmFzZTsNCj4gPiArCXZvaWQg
X19pb21lbSAqbDF0Y21fYmFzZTsNCj4gPiArCXNpemVfdCBsMXRjbV9zaXplOw0KPiA+ICsJcGh5
c19hZGRyX3QgbDF0Y21fcGh5czsNCj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgbXRrX3NjcF9saXN0
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogc2NwX2dldCgpIC0gZ2V0IGEg
cmVmZXJlbmNlIHRvIFNDUC4NCj4gPiAgICAqDQo+ID4gQEAgLTUxLDcgKzU5LDcgQEAgc3RydWN0
IG10a19zY3AgKnNjcF9nZXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAkJ
cmV0dXJuIE5VTEw7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gLQlyZXR1cm4gcGxhdGZvcm1fZ2V0
X2RydmRhdGEoc2NwX3BkZXYpOw0KPiA+ICsJcmV0dXJuICooc3RydWN0IG10a19zY3AgKiopZGV2
X2dldF9wbGF0ZGF0YSgmc2NwX3BkZXYtPmRldik7DQo+ID4gICB9DQo+ID4gICBFWFBPUlRfU1lN
Qk9MX0dQTChzY3BfZ2V0KTsNCj4gPiAgIA0KPiA+IEBAIC04MTAsMTQgKzgxOCwxNCBAQCBzdGF0
aWMgdm9pZCBzY3BfdW5tYXBfbWVtb3J5X3JlZ2lvbihzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+
ICAgc3RhdGljIGludCBzY3BfcmVnaXN0ZXJfaXBpKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYsIHUzMiBpZCwNCj4gPiAgIAkJCSAgICBpcGlfaGFuZGxlcl90IGhhbmRsZXIsIHZvaWQgKnBy
aXYpDQo+ID4gICB7DQo+ID4gLQlzdHJ1Y3QgbXRrX3NjcCAqc2NwID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEocGRldik7DQo+ID4gKwlzdHJ1Y3QgbXRrX3NjcCAqc2NwID0gKihzdHJ1Y3QgbXRrX3Nj
cCAqKilkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICAgDQo+ID4gICAJcmV0dXJu
IHNjcF9pcGlfcmVnaXN0ZXIoc2NwLCBpZCwgaGFuZGxlciwgcHJpdik7DQo+ID4gICB9DQo+ID4g
ICANCj4gPiAgIHN0YXRpYyB2b2lkIHNjcF91bnJlZ2lzdGVyX2lwaShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LCB1MzIgaWQpDQo+ID4gICB7DQo+ID4gLQlzdHJ1Y3QgbXRrX3NjcCAqc2Nw
ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKwlzdHJ1Y3QgbXRrX3NjcCAqc2Nw
ID0gKihzdHJ1Y3QgbXRrX3NjcCAqKilkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpOw0KPiA+
ICAgDQo+ID4gICAJc2NwX2lwaV91bnJlZ2lzdGVyKHNjcCwgaWQpOw0KPiA+ICAgfQ0KPiA+IEBA
IC04MjUsNyArODMzLDcgQEAgc3RhdGljIHZvaWQgc2NwX3VucmVnaXN0ZXJfaXBpKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHUzMiBpZCkNCj4gPiAgIHN0YXRpYyBpbnQgc2NwX3NlbmRf
aXBpKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHUzMiBpZCwgdm9pZCAqYnVmLA0KPiA+
ICAgCQkJdW5zaWduZWQgaW50IGxlbiwgdW5zaWduZWQgaW50IHdhaXQpDQo+ID4gICB7DQo+ID4g
LQlzdHJ1Y3QgbXRrX3NjcCAqc2NwID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4g
KwlzdHJ1Y3QgbXRrX3NjcCAqc2NwID0gKihzdHJ1Y3QgbXRrX3NjcCAqKilkZXZfZ2V0X3BsYXRk
YXRhKCZwZGV2LT5kZXYpOw0KPiA+ICAgDQo+ID4gICAJcmV0dXJuIHNjcF9pcGlfc2VuZChzY3As
IGlkLCBidWYsIGxlbiwgd2FpdCk7DQo+ID4gICB9DQo+ID4gQEAgLTg1NSw3ICs4NjMsOCBAQCBz
dGF0aWMgdm9pZCBzY3BfcmVtb3ZlX3JwbXNnX3N1YmRldihzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0K
PiA+ICAgCX0NCj4gPiAgIH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICtzdGF0aWMgc3RydWN0IG10a19zY3AgKnNj
cF9ycHJvY19pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gKwkJCQkgICAg
ICBzdHJ1Y3QgbXRrX3NjcF9vZl9jbHVzdGVyICpzY3BfY2x1c3RlcikNCj4gPiAgIHsNCj4gPiAg
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAgCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+ID4gQEAgLTg2Nyw1MiArODc2LDQyIEBAIHN0YXRp
YyBpbnQgc2NwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICANCj4g
PiAgIAlyZXQgPSBycHJvY19vZl9wYXJzZV9maXJtd2FyZShkZXYsIDAsICZmd19uYW1lKTsNCj4g
PiAgIAlpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVJTlZBTCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0K
PiA+ICsJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ID4gICANCj4gPiAgIAlycHJvYyA9IGRldm1f
cnByb2NfYWxsb2MoZGV2LCBucC0+bmFtZSwgJnNjcF9vcHMsIGZ3X25hbWUsIHNpemVvZigqc2Nw
KSk7DQo+ID4gLQlpZiAoIXJwcm9jKQ0KPiA+IC0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwg
LUVOT01FTSwgInVuYWJsZSB0byBhbGxvY2F0ZSByZW1vdGVwcm9jXG4iKTsNCj4gPiArCWlmICgh
cnByb2MpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBhbGxvY2F0ZSByZW1vdGVw
cm9jXG4iKTsNCj4gPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gDQo+IFdoeSBhcmUg
eW91IGNvbnZlcnRpbmcgdGhvc2UgZGV2X2Vycl9wcm9iZSB0byBkZXZfZXJyLT5yZXR1cm4/IQ0K
PiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQoNCkl0J3MgYmVjYXVzZSB0aGUgcmV0dXJuIHR5cGUg
b2YgdGhpcyBmdW5jdGlvbiBjaGFuZ2VkIGZyb20gImludCIgdG8gInN0cnVjdCBtdGtfc2NwICoi
Lg0KTWF5YmUgSSBzaG91bGQgY2hhbmdlIHRoZW0gdG8gIkVSUl9QVFIoZGV2X2Vycl9wcm9iZSgu
Li4pKSIgPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClRpbmdIYW4NCg==
