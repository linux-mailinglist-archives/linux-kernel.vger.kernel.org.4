Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893A723ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjFFIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjFFIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:00:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA710F7;
        Tue,  6 Jun 2023 00:58:06 -0700 (PDT)
X-UUID: c85af090043f11eeb20a276fd37b9834-20230606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k/mCmtSUIbNcsmLK5DRIoYWe5LXDv+Q5NUqS0ZQp/R0=;
        b=mQRNZRKIXpu67JAqM27hfnXho7sYQ8a9Vw3BKcFF90iWUwPN8k62b0/UE9leH8gZnf7sYIw0HyftRwuVPmyGuvUfLNtpkYJlZWUq2hDpU57yJEoA9gZpb4976sKxoa6pDZo3bEsHbdoRfSwXCxjDJz4GwAxtKAojfhRzsBJju+0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:35a0213f-4c1e-42c1-84a8-32b2e0495d0a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:42c9b73d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: c85af090043f11eeb20a276fd37b9834-20230606
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 931264060; Tue, 06 Jun 2023 15:57:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 15:57:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 15:57:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFMPtcMd5BxhbtN08KVUAweildQgRkId4bXMi51LWGRHxm4Hnwk2+uqjoj8377toHc+7CZD9xQ9Bwby91o/lzG1gTaM7L7JXAU7bcol01QRBUkc3PfIe6+CXk3ou3IBY5Ahwc5qxHHBZlfm57Tgz0bFNraWh4vHyE6GNpLkQxgHhos3oiFs6vkAlUy5z0vTMfbP+rZ/EOdRxDLi07uGBI/skecZgRaHnksjtPDZ5mPTADmSG5feDFg0IWmQKpQkqjysPPhM1jJ+J981IlDMo7fvZmbLAwdqBLG0LcTJN1zANzTt2qEWE6RtQiPpSC7+SK+Nx7a1mZozLi4nIy9fayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/mCmtSUIbNcsmLK5DRIoYWe5LXDv+Q5NUqS0ZQp/R0=;
 b=JKoG8wIqd64jEqD9GRU/57uNbxFEf4Z2I0KNc7UusIvEM1grejygDjVXcqi3NCy9JsnjIbavmi0lmHRBvIZP2mRL1DUj6kACJAFGhlVwr/iPNpzkwhzT14NPWQNpAJlEY+25YlUiNflndJh4NqsiCfzRaOr1p4r3yQI8NugMfKpnvpQ5IbEPFgBSY+WOxYnXQ0VlvyBDXka0mVVzqdude268ksZE6mZdEs0KpaTvZomW5M58USOT/PAGdS3FK8IwJlRb9ogbuhGBei497wYnJ/CHL2IYKXGiapDT+3pEpIsn50bCrnflP8+H8IC766VpKCMTErFezD+LA7fbuzZoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/mCmtSUIbNcsmLK5DRIoYWe5LXDv+Q5NUqS0ZQp/R0=;
 b=MXrY+9j4KmWLogQFVbtVLVSjwElsd2Ca9eSe3z1hyzXW6kyxaSzoSA6D2mEeBjuNyhgmGm4hYuiDgH1wEgkdl+JM7c2Gx1x2MdP6oSjPUpKMfAPi2Us0FtW8QxaPYMyJsH2R3f+c/dw58l4YH51G0yWVatl80asueApvLLNDDdI=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SEYPR03MB7213.apcprd03.prod.outlook.com (2603:1096:101:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 6 Jun
 2023 07:57:21 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:57:21 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl6dRPPunsFP83kqJ9kXlEUngRq99ZpGAgAADKgA=
Date:   Tue, 6 Jun 2023 07:57:21 +0000
Message-ID: <724e384163c4b0e65bd67ef4e689c2d3f7e4103f.camel@mediatek.com>
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
         <d9f506ff-d088-98d0-7f4b-d1f9db93d3e6@collabora.com>
In-Reply-To: <d9f506ff-d088-98d0-7f4b-d1f9db93d3e6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SEYPR03MB7213:EE_
x-ms-office365-filtering-correlation-id: 3ab84081-a274-4923-6095-08db6663a81a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/IeMHhwtfqeleWL2ni1V+k46qwV2lo8sXW+O5nsyk3dx5jLFxrVXQ2E9qYLTReWDizD6pFVbq5dziHLVsyC33s4AmoiMRxkLSe7sFbIsQZ9N6pmhK180mAz2CFYVOUBta2x6ZFpNONj9/XA7bDQujzYfAU2UoT9WYq7aLcxDMQ4EwRuSm18u0ybApRCxyFdeLRCVmQ26pSG8gESF3BUmf2S3B75j+rgdF9wN2N56xqKBI4rsAh64HxiUU/EeWvqXJgYGsp/6hoB+jphXQmrCcENJsIPSZw0PMB7v1dVfrhR1k1O3Ck30aIw0a2IXiW0DWotUvSaPuThfXqU3KUEC7HaHQJWGLoNV7SAhRJuETLO23IpwH1BdDQ6I3gqi34zawF/KB5Bw8L3aTcTc93gCkxf0m1Ba8MkjYoBplCDzyHuoQarewZXQYnt1YeFP8gz3Xvx/+NbiOEbLVCVYuvm8/rnFnwXqbyrOnwFmF3DEvkXYe1sfowOy4JxHQuoOYw06E8Lvkd4w0g3Mv+VNOQo+bRpUPJwSgbcZ3eJT88Ucsi2NOTrM6s3X4PKgAsyFUHrD7LyyTONOWOHWgzFhLAOXgUT5IYuCVn5e7Uazfcr0M+F090g938LC2xUAn0o5W6oNA+uanI/MLfadPzzps0iKKz4ZJ+6pfm0A6fGshVpEX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(71200400001)(83380400001)(7416002)(38070700005)(85182001)(2616005)(316002)(186003)(2906002)(41300700001)(36756003)(6486002)(5660300002)(86362001)(8936002)(478600001)(8676002)(122000001)(26005)(110136005)(54906003)(38100700002)(6512007)(6506007)(4326008)(66556008)(76116006)(66446008)(66946007)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRIakZhZGx4MFZLRDFNSVlxSXdKM0JzSmZST1VJNUQ4QnVtNTdwaHBxV1dO?=
 =?utf-8?B?clVxM1JhM2c4elV3RWtTWGJxdUl1bWY0bGt6Tm1ub3hkRk1uREE0c2FYS0s0?=
 =?utf-8?B?c2tUc2czeDZPSW9CelR6MlQyWGxTaTgvb2szQmM0d29DeGZ4VG16ZVdRRWhL?=
 =?utf-8?B?dy9LOEJGVTVxOFRwdjlkWDJjS3JCbUQ1NXIzMWMvK2x6Wms1akpvVkRma2Jv?=
 =?utf-8?B?M08wa1hRR2hkTkJ5VVBFS25BRFpHQUhrTWhXRW43T241V2tWMUo3aUI1REF4?=
 =?utf-8?B?aUd3RklkT05FVjVRM1dEaTQzL2lSSVJlVkFwUHhEQ2s0aFplZ25WZDVwYXhh?=
 =?utf-8?B?allqMkJiNGNEUlh5K2kvWXFYcFZ3WEltdHI2eU91dXM5MGx4WUFvc251MEI0?=
 =?utf-8?B?M0VsK0dISTdVQTJMVzhCZnBKcFJROFRWZ241REFNdTI0c2ZCcEcra0hLK3ZH?=
 =?utf-8?B?M0xjTXgybzBESGdQSFhibzhsT2c5cGdCYmNEK2w1cUt2ZU9iZmhPakNUNWZD?=
 =?utf-8?B?a1kyb3hyTmppZngrWHJ2K3FXdDJmbHd1L1VkQXhhSTF1aHNZem8wVjdzQnph?=
 =?utf-8?B?bmZBV2dLeWQxa0FBbUpiTjZ4eUZQeElseG10ajFsa3dxL2ZuSE9adUxub053?=
 =?utf-8?B?QXRraUhyVmRveXFxRzVqNDFvYnZSaWZpOTZGbFlsV043MVhnOThxNGxTbWEz?=
 =?utf-8?B?QlpKTnRkZE5xbDg3Nkh6Szl6N0xuZ0k5aVFEM1d0dmt6TzY5NHlWUnF3TzNP?=
 =?utf-8?B?ZzJ6RGVOQ1liTC9UVkFHcnVsMlZNTnVYeFVPbVJxMCs1YmF5RlY3QTUwV1J6?=
 =?utf-8?B?blNoUUJydU5mS0xoN0xRQ0MyeFozLzNZVXQ5b1dzUnMvL1FUOENvTmRHYkJl?=
 =?utf-8?B?NktJVE9VcjNlQnNpUlk4K0tVSklNR1VJWkpZMWF0N25Nc1V2SWZLWEJ0eWlR?=
 =?utf-8?B?OWhQSEt6RStzWEwyK1ZZZG5odFpNY0FrT0JBMEpwTE9qZm1MQ3RSZXJZeDhJ?=
 =?utf-8?B?WGlxbHdzRGlhTXpHc3UxeXdPc2ZCZ1RQN2J6a3dla1QyK25rZ1RTbTgyT3Vq?=
 =?utf-8?B?VEJScElhR1JwQWhwMjdOanVOL2xkZmpENUdWWjRKNzNSZXZvVnZ2eEpOdWov?=
 =?utf-8?B?L0Fnalpra2RlbEZEUVJsSUUrRWpWVzJ3c1R5Q0xzM3ozQUU3bmdWV1doUVZs?=
 =?utf-8?B?UHBueWhITjlJaCtEY0ZhNmpWV0VMMlArQzZUcThSZGFrbG5tMG5yVW9jSnln?=
 =?utf-8?B?YjJSV1ZjMUlGZlJ2UTVVUUlZWWlJR0tWWHFEZys4dTh1cGg0TEExSFZHVjhL?=
 =?utf-8?B?NEhVN25IeUZxM2VEUkhvZkh3SS9ZSGpjNUVBdUt5R1hVWDRpM0R4cGRXRUxi?=
 =?utf-8?B?eTBoL2FMSXA1VXZjbXk3clEvZ1NMRXc4NG9FNFBZdkY1Mm10a05jTEJMSXlS?=
 =?utf-8?B?TS9JSXUvdE5MdStGTnRXL21wZlkxRkIzMlgzL2FIbE55bWtRTlZsV3FOMzNi?=
 =?utf-8?B?dzd1T0lJQ2ZhL3pqRFpIQ1owaGdad1QwS05HdVgzdFdtbHZaL3dFakVxTmpQ?=
 =?utf-8?B?TWsrTlNkNitzeEhoV2J3WnZnSXY0YW5HSm0zaVE1U3VXVDNOalB3QVRkemVY?=
 =?utf-8?B?Smx3bWFLSnhHOU9BbUpmb2JRVkdjTWZNcE9PSEJFUmVXR3RxMExqSnRYcVk1?=
 =?utf-8?B?UkprdFd5VHJPVlQ5NnBMSS9uRWhzb1hYZTREcVUxUnVyWkUzaVJsVjNvTlFs?=
 =?utf-8?B?b3R3clVQRW1MQ21hQTBsWmlBSVJTeXhOK0tyenhjd2ZMMmxhUnJLR0hPU0VD?=
 =?utf-8?B?MTlTVllOdWVBSlhBY2ZEMU51MlB1Yi8xYkhvcThpN3k2RVBMby84TjVEZmlI?=
 =?utf-8?B?SThmbElHTUIyUGxYWmNBL1pwajhwa1dxa2hPbWRPTWQrTmJOSi96a1RNRURp?=
 =?utf-8?B?Q2JWelE5Ny9YMVgzR0lpdEEzVTRUQVlvY0JPc1prbG9UdDlyVnFGemd6clcr?=
 =?utf-8?B?SEFRdWc2RWZWWkJhLzBrVmNIMWVDZHV2clJ1ZlRCVnovQjVIMSt0T1NXNzVK?=
 =?utf-8?B?SEE0N3N0ZjhBdlBOSHU5VUZ6bjZzY3hLdkkrTGNnMEFQRk9sQ05LQXJGUDND?=
 =?utf-8?B?amZVMHVkdmF0U2tYOWpRTlIxblJienJ0TUlueG9iV1ArTFFERGNPUUo3aS9h?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A730C8386955F14AAD75534C6C58E8AA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab84081-a274-4923-6095-08db6663a81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 07:57:21.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26mh9Zaqs4OT/yNbxPxaxrsvx7QE9C1d6mR6bC4+bmH3qcFywZaIYo3PX/8/Tvh268KIwtgdAXvwkngrgl0UUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDA5OjQ2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwNS8wNi8yMyAxNDoxNCwgV2VuYmluIE1l
aSBoYSBzY3JpdHRvOg0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGlu
ZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gcGVyaW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NU
QVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNsayBh
cyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZSBoY2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdl
dCB0aGUgYWN0dWFsIHRpbWUuDQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29y
cmVzcG9uZHMgdG8gMTUwdXMgZm9yIE1lZGlhVGVrDQo+IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVh
c2UgaXQgdG8gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDIuMzV1cywgd2hpY2ggY2FuIGltcHJv
dmUNCj4gdGhlDQo+ID4gcGVyZm9ybWFuY2Ugb2Ygc29tZSBlTU1DIGRldmljZXMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLmggIHwgIDEgKw0KPiA+ICAgZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDQ1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaCBiL2RyaXZlcnMv
bW1jL2hvc3QvY3FoY2kuaA0KPiA+IGluZGV4IGJhOTM4N2VkOTBlYi4uMjkyYjg5ZWJkOTc4IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3QvY3FoY2kuaA0KPiA+IEBAIC0yMyw2ICsyMyw3IEBADQo+ID4gICAvKiBjYXBh
YmlsaXRpZXMgKi8NCj4gPiAgICNkZWZpbmUgQ1FIQ0lfQ0FQMHgwNA0KPiA+ICAgI2RlZmluZSBD
UUhDSV9DQVBfQ1MweDEwMDAwMDAwIC8qIENyeXB0byBTdXBwb3J0ICovDQo+ID4gKyNkZWZpbmUg
Q1FIQ0lfQ0FQX0lUQ0ZNVUwoeCkoKCh4KSAmIEdFTk1BU0soMTUsIDEyKSkgPj4gMTIpDQo+ID4g
ICANCj4gPiAgIC8qIGNvbmZpZ3VyYXRpb24gKi8NCj4gPiAgICNkZWZpbmUgQ1FIQ0lfQ0ZHMHgw
OA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9t
bWMvaG9zdC9tdGstc2QuYw0KPiA+IGluZGV4IGVkYWRlMGU1NGEwYy4uOWY1NDA5NzNjYWZmIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gQEAgLTQ3Myw2ICs0NzMsNyBAQCBzdHJ1Y3QgbXNk
Y19ob3N0IHsNCj4gPiAgIHN0cnVjdCBtc2RjX3R1bmVfcGFyYSBkZWZfdHVuZV9wYXJhOyAvKiBk
ZWZhdWx0IHR1bmUgc2V0dGluZyAqLw0KPiA+ICAgc3RydWN0IG1zZGNfdHVuZV9wYXJhIHNhdmVk
X3R1bmVfcGFyYTsgLyogdHVuZSByZXN1bHQgb2YNCj4gQ01EMjEvQ01EMTkgKi8NCj4gPiAgIHN0
cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0Ow0KPiA+ICt1MzIgY3Ffc3NjMV90aW1lOw0KPiA+ICAg
fTsNCj4gPiAgIA0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfbW1jX2NvbXBhdGlibGUg
bXQyNzAxX2NvbXBhdCA9IHsNCj4gPiBAQCAtMjQ1MCw5ICsyNDUxLDQ4IEBAIHN0YXRpYyB2b2lk
DQo+IG1zZGNfaHM0MDBfZW5oYW5jZWRfc3Ryb2JlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLA0KPiA+
ICAgfQ0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gK3N0YXRpYyB2b2lkIG1zZGNfY3FlX2NpdF9jYWwo
c3RydWN0IG1zZGNfaG9zdCAqaG9zdCwgdTY0IHRpbWVyX25zKQ0KPiA+ICt7DQo+ID4gK3N0cnVj
dCBtbWNfaG9zdCAqbW1jID0gbW1jX2Zyb21fcHJpdihob3N0KTsNCj4gPiArc3RydWN0IGNxaGNp
X2hvc3QgKmNxX2hvc3QgPSBtbWMtPmNxZV9wcml2YXRlOw0KPiA+ICt1OCBpdGNmbXVsOw0KPiA+
ICt1NjQgaGNsa19mcmVxOw0KPiA+ICt1NjQgdmFsdWU7DQo+ID4gKw0KPiA+ICsvKiBTaW5jZSBN
U0RDIENRRSB1c2VzIG1zZGNfaGNsayBhcyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZQ0K
PiBoY2xrDQo+ID4gKyAqIGZyZXF1ZW5jeSB0byBnZXQgdGhlIGFjdHVhbCB0aW1lIGZvciBDSVQu
DQo+ID4gKyAqLw0KPiANCj4gDQo+ICAgICAgLyoNCj4gICAgICAgKiBPbiBNZWRpYVRlayBTb0Nz
IHRoZSBNU0RDIGNvbnRyb2xsZXIncyBDUUUgdXNlcyBtc2RjX2hjbGsgYXMNCj4gSVRDRlZBTA0K
PiAgICAgICAqIHNvIHdlIG11bHRpcGx5L2RpdmlkZSB0aGUgSENMSyBmcmVxdWVuY3kgYnkgSVRD
Rk1VTCB0bw0KPiBjYWxjdWxhdGUgdGhlDQo+ICAgICAgICogU2VuZCBTdGF0dXMgQ29tbWFuZCBJ
ZGxlIFRpbWVyIChDSVQpIHZhbHVlLg0KPiAgICAgICAqLw0KPiANCj4gVGhlIHByb3Bvc2VkIGNv
bW1lbnQgaW5jcmVhc2VzIHJlYWRhYmlsaXR5Lg0KPiANClRoYW5rcyBmb3IgeW91ciByZXZpZXcu
DQpJIHdpbGwgY2hhbmdlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlZ2FyZHMsDQpXZW5i
aW4NCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCg==
