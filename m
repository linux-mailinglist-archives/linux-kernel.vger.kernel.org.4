Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE485F6526
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiJFLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJFLYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:24:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5754C9F;
        Thu,  6 Oct 2022 04:24:08 -0700 (PDT)
X-UUID: bdca7fcc3553490db0ec54a2f77b83c5-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kzAyMF01dYjwqCVUKXX4icIFqnZIj2MpzsJ6CDxZGHk=;
        b=OKb/YhW4SL0LbSmL9Cf1z09veMThJEH0V2x2K1x9vSRGl1q/l3d3b8WYbAdi3PxZzHJUda01g/v33pSDYF9CEvtdkULeKgPorWghhUeQl3uIR9P9dKvs5tWoRuAXbP3xcdF7xbI0lZ2rbmD2X9z0fS8p+U8hIuOAtmjb0gH8+dU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c0027cee-63a6-49b9-be83-7ba654cc8a2c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.11,REQID:c0027cee-63a6-49b9-be83-7ba654cc8a2c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:39a5ff1,CLOUDID:7c19b9b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:221006192405G63Z7LEA,BulkQuantity:0,Recheck:0,SF:38|16|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0
X-UUID: bdca7fcc3553490db0ec54a2f77b83c5-20221006
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 492430673; Thu, 06 Oct 2022 19:24:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 19:24:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 6 Oct 2022 19:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh4E7kinF8JUcJ3nk6ZbExPKtlbsI9hyTy2ysahpsT3N/PVX1z8iR3T6q6tpwQ+70gOb3W6gnM+lZHd0kjDr+btINiQ5A1MC0VNE1KkLm5LUASdF5Rc3AuTd9MFC1FtR/QVELmcH2vHXsK+zM3pZtnMadXMLtAEU7LYfnHHeUT2Qh4YTWrOLfdNTnTj11CUelzrh0frCLp/kDgEVkPsM9hwDPn60N+8eqjWqNWKsW/h+JCYXA0ivP/v0a2XVIL2rgFiPXX1JoK4KrhhhWtk+j/pyjKPSPPlqrHdgDqhm2MGtClBzNX6s2J6IvVIA3iecP50VoPwVPAH07Dy0my4RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzAyMF01dYjwqCVUKXX4icIFqnZIj2MpzsJ6CDxZGHk=;
 b=gfp4G3Fiie2T+oIUvnIBfc8udWEOTRSr+AVvhFDWS2jp9Ll7214TjGq/JXzhzVdMmh2pD7AZ7xOxEfmm/l7LXgwzcU0L7qbvrtJOW39m/v8NXhWEKrO7fp/+NhC5bz8EtVuIGBDAvGEfo90/EvHdz91CTcIikiWUml2pIHXs8p+dizAqaGQQausZa3z2WyQR7xyqUeB/oVPdKW7JtPRauv+UIWAogpZJ2I08V6FYlFtvDYjk65wtuvGuXffbeueTZuYCkh5AlM6kGvt8PXtoKzMrzCyuRrBj+9WAwMzlgCSu1c+9GetbX2hKvNTHkYSRoh0f0bnaw8dJ4YOxFfs9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzAyMF01dYjwqCVUKXX4icIFqnZIj2MpzsJ6CDxZGHk=;
 b=HU9+0arfUWPLI31xToY/s1DLcGqtO7zf9avnalI7BWKwsX0DGak27vuAGxlwzDSe9T2yGG0Vp5vQqqLaKhBj7mOznDRNDHOVgh/g9Aqdz7ZwZvboshhk/I7OGERIYnIgfMepkBJEdm7R/Jn00+EWdvfWi5PaF92XwoM6FMQ++e4=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by KL1PR03MB5761.apcprd03.prod.outlook.com (2603:1096:820:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Thu, 6 Oct
 2022 11:23:55 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%9]) with mapi id 15.20.5709.010; Thu, 6 Oct 2022
 11:23:55 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHY0/lIndFmLtg+lkiFTv0K/xrn3K32YQCAgAH2s4CACOyWAA==
Date:   Thu, 6 Oct 2022 11:23:54 +0000
Message-ID: <5b84c81d0d7f71bb83fcbef860433e4704ae5c72.camel@mediatek.com>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
         <20220929114624.16809-3-johnson.wang@mediatek.com>
         <ed723cb2-ba79-55d7-7869-abf153e4af0a@collabora.com>
         <20220930190703.GA657929-robh@kernel.org>
In-Reply-To: <20220930190703.GA657929-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|KL1PR03MB5761:EE_
x-ms-office365-filtering-correlation-id: 12b63d05-4c81-4a4a-5f59-08daa78d411e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bL/5Zp2xEkyPhnknmE4yTNr/3VwVEV8eM/Rm3mSEm8XIf5HbZjDM+c89ScySxX7lIL3SxEc7P9IKXcHyQVbb5R33uRJrl/qoh2+S9MA1EcbYviC3gG77X0O5ycTgu/Pj25OmbiK0uaEeyaaVju8VKo3mhcGl5tL5Mvy+84NsiynH5MeCB/nRVPXq0vzAJWsdj9R0pvn4ngtgFN5ubetSInaR52oo45KA+ifJj5w//B3NjWlhKUVI/j2WuO7KuaVeVP8NQrxQxHKTMkR9inL9/N5hVAu4M4WUGjOqgGtVDRpLQMlkaMqz3BV4mLWnLRaAGnA2uyuMUGDvbUvjQSJ4UpP7G7JpCMwu8CRjVEi6UPdf3UXM6yjO8Kc/3ymrPIuJEVLHlzu2JrPDjDEGfzv0zVLoIly0ZfGJvmULblPyOK8FJdYQfTPgfbbWjC5+ronGf6k6GRRzj1NVKdF4jg7wZJyTPX1ttiZr9gP1sniws85RudacmNMbIo1L2UWqxk3ozEWjYQWzP+Y4hhAttJz4QopwoGvC74nANAzzsBu0UhWpskVFe9DjUUXX2vQTcWLEAxaTRXaACRlHLspokEdZ7GSXakQa0dXZl0KOWNB82AheGtq7tEklOkDpnGmfa0pn04+ceR1Np8p3d9lFQn7q6PEhgZwAQNG44VkqOWpcA6O/SgPeWZakZKScecSQm2ZfhuBjKEgPFxi9327letr3yQQ9lVjk5/HotG9VYdY26GQTIly6rDLYeYlQ289bqCKrcvAvH9cj0dwxIA8jIMyWj20iLgmsRtjbv9H3Rr/n3tv3N4FfKKyI9WYh6dRXHyxktvQlW8AryCVAvBkr/i9soQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(36756003)(110136005)(54906003)(6506007)(8936002)(26005)(85182001)(6512007)(41300700001)(966005)(86362001)(2906002)(2616005)(6486002)(71200400001)(38100700002)(66446008)(66476007)(66556008)(316002)(5660300002)(66946007)(76116006)(83380400001)(64756008)(186003)(122000001)(478600001)(4326008)(8676002)(107886003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRCeXVYb0cyUi9taG9SVHZiSDFIZjg5NTdha082YzhkYXZNTzhrVWkxLzNH?=
 =?utf-8?B?NStpRndxM1NyVS91NDlBdWdCZW5mREtLdWxiLzJKaDFaYkdUZHZURzM3amlv?=
 =?utf-8?B?Z2t2TUlOUVlLaWp4SGRQWnFmd2h5SXR3QkQzZFF6TDU5Y3FkNkhUeVo0QW9w?=
 =?utf-8?B?R0YxeTQzako4dUZWMWc0YXhFU2MvaXJ4bWZOSGlqQ2RSUHZ4M3k0WUhGd1Q1?=
 =?utf-8?B?NGRVWlFYQXFnTVRSR0RNakFxSWloUkFvT0hkZ2MrWThJRE5GcEdJekwyMDBp?=
 =?utf-8?B?cUpaMkttZHVJcXgzbmFDME5zSkFrU1Vha3Q4ZEcveVQ5cnhVSUJhVkJpYWVv?=
 =?utf-8?B?ZGcvZFFBVkZuSnFuSXM1aWp3bG5EOGMwbjdYSVZ1YzExYkdoR1FubktQMEhi?=
 =?utf-8?B?ZE90aDAxSFc4YnVodExSUnJzeFEzQlg1SytwOHpUdVF1VngrekRzZEZnQlo5?=
 =?utf-8?B?Wko3RFhLMy85ZDhudmN3TUk0TFEzL3ZyOG1IOTMvNHRFZW9ROW9tVWY5UnA5?=
 =?utf-8?B?YWRzc0FXK00rSXRxL0taM1VNQU93OXc2T0k3dW1PcHJlY2VBM1dYU1Q4cjlR?=
 =?utf-8?B?TmRPRGppLyt6b0NBZVA4b0NGeEUzMFo2NU92YW9xUzBhTStlWnBkYmxPTUNv?=
 =?utf-8?B?NnFQeDRZRHBCS0tLVXc5ZXlTeXpUQXlpV2VSanZrRWtxRjZjU1R1b1VnNUd2?=
 =?utf-8?B?TWRUS3hFc21FSG1JRU1UM3NDajJ5eHRxSUhUL0tHNDh5QXNuT0R0VW1EeGRC?=
 =?utf-8?B?bzhjUzJRNzdNTW5OM0pBb0YzaGRidVR1bUxzaUFxakdVRy9BejcwZXdDMWI4?=
 =?utf-8?B?cExLTWR1Yzh3TFFiT0crKzMzMWJtT0x1cFZhMUJwdi9QaUZ6bXl3WVl2dUxM?=
 =?utf-8?B?WkVRVll3NTl1eHNxdUpMKzJHQVU0NVhIVW9iblBXdXlTUnFkbVNFd2lpOVZX?=
 =?utf-8?B?eTJ0cmd5L09GRjJZZUdxRFI5a29La2ZnMkZQQ3h6V2ZQOGRqMjJpbHN6WDJK?=
 =?utf-8?B?dHFyZlFIVmFUZ2U0ZEU0V1c5eUR1bXVuY1RyUzl4c2VOWUFPc2t3dkRwbmFy?=
 =?utf-8?B?OStQVFBnNDJheVBrTDZ2eXZUS3VYMXJHNTduRi8vYmZtdUgzNzdUVUx5c1FW?=
 =?utf-8?B?TVRndXF0dkJjZ2NjazJuTFZBU2RyZWlWaC85emRhRGVQWE5UK2dSbXl0VGla?=
 =?utf-8?B?UTh6WVlObFBqaldiZEhJVGNOMnFyeHVldE5WMTVpdUxUNllSOEd4QTZzSHR6?=
 =?utf-8?B?VEFBMjhDdDR3aVExclhrTnNKcE9vMVpGbi9JenBSaXBpeEt4eU1xbGUrVldX?=
 =?utf-8?B?U0s1Y1ZlWEJZUmtPRmRGRW9xdXUyTytyY1VEOVI5QUg4UlczZXZNWmR1YmRP?=
 =?utf-8?B?eC9zdE1GN0tRZ0xDNmhydnNQYXVFUU5MQXcyNW0zdE9EN1NCSkFDWHBnMU1F?=
 =?utf-8?B?aVdkeHJNcnY3WDVoN080NStWb2U1aVgyM0pvbGo2RVc1U1lyQitiZTdaVGRK?=
 =?utf-8?B?UUpLSGViSEJkZTNKRkJTR0JNODdRVi82S3VmQWo4cnFnN1BMamlJaTgycHJi?=
 =?utf-8?B?ZGFRdEs2cWJ6S0lKaVZvaWs3cUJ1YTR6NDVUMWpXZG8ybWV0bG9Nb2tXTmlE?=
 =?utf-8?B?WC8zVTIvamdIYnZyOEpNYzZhZ0VycTc5dU5VQUpGSTNDN2F3cEpEMzZ3Q2tL?=
 =?utf-8?B?cUhGWWhFTGpzc3NxYmszZnc1cVdSbEFRK1Noek1paW4zUDVxbnpmS1JHMUl3?=
 =?utf-8?B?dFNCZTNsNjFMUzhhYjR2dnA1MSsyMG1PVE5TMGo4NDFSZDg1MENjVVlob25v?=
 =?utf-8?B?RERkdC8rUE14dUhXUVE0QWlZeDV5dUtrczJWNjlRTHZrNWhHd3FNOVRna2dW?=
 =?utf-8?B?TUViUVhQOHE3bExISXRkMjlDZzYzQ0JjVkQ1V0RDeHRHenVxeFhQUG1uNVo1?=
 =?utf-8?B?WlNUblkwZkRsT0F3TUQ2ajhUbDk1UGJ0eXdJWVhMVXM5Q1VtNkVsaXU1eVVU?=
 =?utf-8?B?L3pJUjlHb0xXUWp2NVQ3RmpBZUZMVlpTN0xJZHdVMjc3aVVPWFpGSkd6TGVV?=
 =?utf-8?B?aUV2NitnN1dPR29GcjhUK1dldTVmYnc3bXZvSjBnYlYxS0lwMmhRSlc2WWdo?=
 =?utf-8?B?SzFnc0QxeC92c3lsR2d0czUySng4ejhUMDJ3aTFFUk1vOXNzVlhvMG14Z0oz?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31D7FB9ECAECC94DA24232568D6D65FE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b63d05-4c81-4a4a-5f59-08daa78d411e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 11:23:55.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUqJPoqVv/F9hTl6CbKV6lvzRUwqiX1T+Ip89b8NAUEhAEEcZQY1JCm0C3uiij68VSl6iZUoPTcgQW44D7Kb9HqRbSothsmN/mC9Lm9S040=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5761
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTMwIGF0IDE0OjA3IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6MDc6NDlQTSArMDIwMCwgQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8NCj4gd3JvdGU6DQo+ID4gSWwgMjkvMDkvMjIgMTM6NDYsIEpvaG5zb24gV2Fu
ZyBoYSBzY3JpdHRvOg0KPiA+ID4gQWRkIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIGZv
ciBNZWRpYVRlayBmcmVxdWVuY3kgaG9wcGluZw0KPiA+ID4gYW5kIHNwcmVhZCBzcGVjdHJ1bSBj
bG9ja2luZyBjb250cm9sLg0KPiA+ID4gDQo+ID4gPiBDby1kZXZlbG9wZWQtYnk6IEVkd2FyZC1K
VyBZYW5nIDxlZHdhcmQtancueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogSm9obnNvbiBXYW5nIDxqb2huc29uLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgIC4uLi9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTg2LWZoY3RsLnlh
bWwgICB8IDUzDQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxt
dDgxODYtDQo+ID4gPiBmaGN0bC55YW1sDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxtdDgxODYtDQo+ID4gPiBmaGN0bC55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTg2LQ0KPiA+ID4gZmhjdGwu
eWFtbA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uMjU4ZGZmN2NlNmJjDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysNCj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxt
dDgxODYtDQo+ID4gPiBmaGN0bC55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDUzIEBADQo+ID4gPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+
ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDogDQo+ID4gPiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL21lZGlh
dGVrL21lZGlhdGVrLG10ODE4Ni1maGN0bC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYncheFZ0
NzNmOFBhUUtwaDhuMGZmR0hIbVFJeGR6b29VdEdyMHhETlZxeV82VjB2d2NzNWstRkxybWtCM1Ba
dXBTdTFjaUMkDQo+ID4gPiAgDQo+ID4gPiArJHNjaGVtYTogDQo+ID4gPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwqX187SXchIUNUUk5LQTl3TWcwQVJidyF4VnQ3M2Y4UGFRS3BoOG4wZmZHSEhtUUl4ZHpvb1V0
R3IweEROVnF5XzZWMHZ3Y3M1ay1GTHJta0IzUFp1bFh3QkFDayQNCj4gPiA+ICANCj4gPiA+ICsN
Cj4gPiA+ICt0aXRsZTogTWVkaWFUZWsgZnJlcXVlbmN5IGhvcHBpbmcgYW5kIHNwcmVhZCBzcGVj
dHJ1bSBjbG9ja2luZw0KPiA+ID4gY29udHJvbA0KPiA+ID4gKw0KPiA+ID4gK21haW50YWluZXJz
Og0KPiA+ID4gKyAgLSBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gKw0KPiA+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gPiArICBGcmVxdWVuY3kgaG9w
cGluZyBjb250cm9sIChGSENUTCkgaXMgYSBwaWVjZSBvZiBoYXJkd2FyZSB0aGF0DQo+ID4gPiBj
b250cm9sDQo+ID4gPiArICBzb21lIFBMTHMgdG8gYWRvcHQgImhvcHBpbmciIG1lY2hhbmlzbSB0
byBhZGp1c3QgdGhlaXINCj4gPiA+IGZyZXF1ZW5jeS4NCj4gPiA+ICsgIFNwcmVhZCBzcGVjdHJ1
bSBjbG9ja2luZyAoU1NDKSBpcyBhbm90aGVyIGZ1bmN0aW9uIHByb3ZpZGVkIGJ5DQo+ID4gPiB0
aGlzIGhhcmR3YXJlLg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21w
YXRpYmxlOg0KPiA+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ4MTg2LWZoY3RsDQo+ID4gPiAr
DQo+ID4gPiArICByZWc6DQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiAr
ICBjbG9ja3M6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBQaGFuZGxlcyBvZiB0aGUgUExMIHdp
dGggRkhDVEwgaGFyZHdhcmUNCj4gPiA+IGNhcGFiaWxpdHkuDQo+ID4gPiArICAgIG1pbkl0ZW1z
OiAxDQo+ID4gPiArICAgIG1heEl0ZW1zOiAzMA0KPiA+ID4gKw0KPiA+ID4gKyAgbWVkaWF0ZWss
aG9wcGluZy1zc2MtcGVyY2VudDoNCj4gPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwZXJjZW50
YWdlIG9mIHNwcmVhZCBzcGVjdHJ1bSBjbG9ja2luZyBmb3INCj4gPiA+IG9uZSBQTEwuDQo+ID4g
PiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiArICAgIG1heEl0ZW1zOiAzMA0KPiA+ID4gKyAgICBp
dGVtczoNCj4gPiA+ICsgICAgICBkZWZhdWx0OiAwDQo+ID4gPiArICAgICAgbWluaW11bTogMA0K
PiA+ID4gKyAgICAgIG1heGltdW06IDgNCj4gPiA+ICsNCj4gPiA+ICtyZXF1aXJlZDoNCj4gPiA+
ICsgIC0gY29tcGF0aWJsZQ0KPiA+ID4gKyAgLSByZWcNCj4gPiA+ICsgIC0gY2xvY2tzDQo+ID4g
PiArDQo+ID4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gPiArDQo+ID4gPiAr
ZXhhbXBsZXM6DQo+ID4gPiArICAtIHwNCj4gPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L2Nsb2NrL210ODE4Ni1jbGsuaD4NCj4gPiA+ICsgICAgZmhjdGw6IGZoY3RsQDEwMDBjZTAwIHsN
Cj4gPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LWZoY3RsIjsNCj4g
PiA+ICsgICAgICAgIHJlZyA9IDwweDEwMDBjMDAwIDB4ZTAwPjsNCj4gPiA+ICsgICAgICAgIGNs
b2NrcyA9IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9NU0RDUExMPjsNCj4gPiA+ICsgICAgICAg
IG1lZGlhdGVrLGhvcHBpbmctc3NjLXBlcmNlbnQgPSA8Mz47DQo+ID4gPiArICAgIH07DQo+ID4g
DQo+ID4gDQo+ID4gLi4uLiBhIG1vcmUgcmVhbGlzdGljIGV4YW1wbGU6DQo+IA0KPiBPbmUgb3Ig
MiBjZWxscyBpcyByZWFsbHkgb3V0c2lkZSB0aGUgc2NvcGUgb2YgdGhlIGJpbmRpbmcgYXMgZWl0
aGVyDQo+IGlzIA0KPiB2YWxpZC4gSWYgdGhlIHBhcmVudCBidXMgb25seSBoYXMgMzItYml0cyBv
ZiBhZGRyZXNzIHNwYWNlLCB0aGVyZSdzIA0KPiBsaXR0bGUgcmVhc29uIHRvIHVzZSAyIGNlbGxz
Lg0KPiANCg0KSGkgUm9iLA0KDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KVGhlbiBJ
IHdpbGwga2VlcCB0aGlzIGV4YW1wbGUgdGhlIHNhbWUgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
QlJzLA0KSm9obnNvbiBXYW5nDQo+ID4gDQo+ID4gICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9j
bG9jay9tdDgxODYtY2xrLmg+DQo+ID4gDQo+ID4gICAgIHNvYyB7DQo+ID4gICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwyPjsNCj4gPiAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+IA0K
PiA+ICAgICAgICAgZmhjdGw6IGZoY3RsQDEwMDBjZTAwIHsNCj4gPiAgICAgICAgICAgICBjb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni1maGN0bCI7DQo+ID4gICAgICAgICAgICAgcmVnID0g
PDAgMHgxMDAwYzAwMCAwIDB4ZTAwPjsNCj4gPiAgICAgICAgICAgICBjbG9ja3MgPSA8JmFwbWl4
ZWRzeXMgQ0xLX0FQTUlYRURfTVNEQ1BMTD47DQo+ID4gICAgICAgICAgICAgbWVkaWF0ZWssaG9w
cGluZy1zc2MtcGVyY2VudCA9IDwzPjsNCj4gPiAgICAgICAgIH07DQo+ID4gICAgIH07DQo+ID4g
DQo+ID4gQWZ0ZXIgd2hpY2guLi4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4NCj4gPiANCg==
