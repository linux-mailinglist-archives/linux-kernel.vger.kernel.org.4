Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E46F6640
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEDHsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:48:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE49D;
        Thu,  4 May 2023 00:48:45 -0700 (PDT)
X-UUID: 16af2c2aea5011edb20a276fd37b9834-20230504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y4ouBMOo5OVaa/v7/rTO7WrSN2J5D3+BZNPsmv9dZ6E=;
        b=sl3sR3KfgI1Rl8vaauybgjZmFKykIQKCs1WBC8Vt23zhVWzzvXoUdFRcpL9+0Q/N2KA5rilSvoiyGg/8kJUVAizwxyfotsilKT1PriOuZ/CmtXfRVl5GUYZTQHU7MOUL908AFE8EiBOt2KXZoV/pO8whZEz2g6NrIoa2e6j+sOA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:6ab32868-fa87-4d9b-9dcf-2eb83a0b3293,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:f067b630-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 16af2c2aea5011edb20a276fd37b9834-20230504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 650290668; Thu, 04 May 2023 15:48:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 May 2023 15:48:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 May 2023 15:48:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyY0Du4QttT67d2VtQrn9t3/aeF20fhkHD7yWWHYzr4PuFCR+qqodGf/aeuZNEeJId/m5BAj5O4Ims7Yr38QfA+GaFyn6O4kX0T83fFxHzLuOl/T27d2eA5XQHNZ60LwN7YHZowFNJ1UK4yDBa5xKc0PrG32SBtuUGHM0IDYPKrGi5xU93rS0qyOb5ClFwJMAFBz5MxKfo0iOjcL2g1leQz57fIhXSYo6zcRgQXPJJ4ONafuv8aSFfv46Pv3Z3VN4mYl0pS34gHHGJcyMhoX40VVTXCJEQJRthHY59PMW/5BZm+tGB25IFcWP1Vpaw3kh0JlpPN35Wn4KufxoURvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4ouBMOo5OVaa/v7/rTO7WrSN2J5D3+BZNPsmv9dZ6E=;
 b=NQCqBN+CDsK4lg0KaTwduvRcWRKzW44MFAkM5pSqFAK/YCKKApSn2sVtyJqwr151aKjb4vJic9PoYryZUK52JnQu8xVNLtrmN0dVvkS55WPK6SMgE+icg1W2AH+V/raNZAjOd3p0F8G/QF71OP7+m/W2lJNlWJpkK2lMlI66/5BnX7L5tFKhf10vLWiIX3TWrZYvcbUszAWn3kmwaxJjtlX14CJgO+dYDyAuK/ZKBYatWEh5uajMuG0xLY5d1uEfbQxsA47e6dJjJMDxys8GxG5eMklmSngitSYTxd3uGa1qKkCpUdYgsPz0dn9501m6Kc8vYnt8AXqb5UK6yED3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4ouBMOo5OVaa/v7/rTO7WrSN2J5D3+BZNPsmv9dZ6E=;
 b=htW9Xa9plfLWJGxbIOKGVTMmTHXQL0ghhL5/PCGlNilDkM3gCWgYQ7bezfimDCIXRmA/CnD8z2ayDSthRWzKypD8WZPNiTUriEd6ddkheOztJpsg1boJ8nofW3tbrxRPUwvnE6TAhvMBncaBZPz2urr6Lu3RapvrWG37K921/Ck=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SEYPR03MB7664.apcprd03.prod.outlook.com (2603:1096:101:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 07:48:34 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::7050:a778:5abe:27d2]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::7050:a778:5abe:27d2%4]) with mapi id 15.20.6340.032; Thu, 4 May 2023
 07:48:34 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "fparent@baylibre.com" <fparent@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "abailon@baylibre.com" <abailon@baylibre.com>
Subject: Re: [PATCH] usb: mtu3: Don't check the USB3 status bits if the max
 speed is USB2
Thread-Topic: [PATCH] usb: mtu3: Don't check the USB3 status bits if the max
 speed is USB2
Thread-Index: AQHZeHTIkPZXZKPquE6tM0UXWSs2rq9JyLyA
Date:   Thu, 4 May 2023 07:48:34 +0000
Message-ID: <563a124c6bc5903bd8855cb077c512f8b91c6797.camel@mediatek.com>
References: <20230426-usb-mtu3-improvement-v1-1-1cf02434b478@baylibre.com>
In-Reply-To: <20230426-usb-mtu3-improvement-v1-1-1cf02434b478@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SEYPR03MB7664:EE_
x-ms-office365-filtering-correlation-id: e470e4e9-2885-4ae3-5328-08db4c73f68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfJ+MGHegT702f55aF85d5JgkuhDJPVvWxWiJr/z68IbBL/qJ0jZgUVgXr/Qq/5NFrjG5Io59reL6qGXHvKsKsefsjzF3wIxnwzArj8pZMTfoPjEp4mautkfPWkLEfAf8/Zg/DcF7HUA8IeA3fLXDrn38OluLSGf+D7UkMGOvriWNxo+hVKR2nnyC3+yOPocqssoxMok68raeB/EFJrbY8vEQmgjx9QXQRUHnoOZGizzC+FHU34WBsxUyy54gKLIx3sL/0t8DODk65ZSoc0B2DCbTdLXILl7ncSdLHIeWXNRNFL3wnzZaS7hTvZmjVQYmboPpQbt65wRzQ+KQKV3BsI/GOSmkomBb05ryOBMIqZjsN8WlcEr4L4K31LlLT3/6yGKQJd5pfa8thADFmnF8j5Egvvh2aq33auSzAMMCfAAigSvEAGUSOd2XJa9xp8N+pd7ldUap+19igvVugrxOSB1JZ4q4taF1OWezV/lIGfw4R6u4hVUNRqnoNL7Yp0Htzi9bBS6tLP+CksskpaGJtpuCdD0+ROFxOrYiUvQWHxke5t38A4YmU9wTHcP1zL8gMh9lCEM8qxBzREjHG41CY1f7TLmH7+xbpEYSnDtiQlHMpgDZzbULoSjPsVR/OFoHy2krliFhjitWnBUk42z+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(38070700005)(122000001)(38100700002)(83380400001)(2616005)(86362001)(36756003)(85182001)(71200400001)(110136005)(54906003)(66946007)(316002)(8936002)(8676002)(41300700001)(4326008)(91956017)(76116006)(66446008)(64756008)(6512007)(26005)(6486002)(5660300002)(6506007)(186003)(478600001)(66556008)(66476007)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REhMZFhRQ01FS2U1dmJROFlmbXcvSjFSRHNvS2oycS9BUE51ZHhkT2lacjZv?=
 =?utf-8?B?R0VSVW5ITDhHRStIV2VUSnRTSk9aTEdZRmFGQXBHcmxSQ0NrV2txY3dTNG9z?=
 =?utf-8?B?NDFMYUxwYnozYk1iWDlydTlwSkcwY3BDMVo1RlV0R1BnN0ZQRHNnTUZiUDhF?=
 =?utf-8?B?MlMvY0dFMWVKZXlobzcwWFZ6dXJhdllESHBmUVpWT2xuazJpVldUUDJrMjN6?=
 =?utf-8?B?KzNQUkF4WXJFcUZPMlVuZWhOTm5VRXpweWFVMDNMQWRjT1A5ZWVwSFEybFVo?=
 =?utf-8?B?OFZwWGwzeXoxV2w3NityQ2JRR25TVEtnQ2E0alVQWVM0NXRjRkVmdUM2QTdr?=
 =?utf-8?B?dklqVVBNaHcxaVBiL0d4eGYrYm1scmNENUM4ckZVMk01dUhTZHBZYWU4bTBh?=
 =?utf-8?B?MW91ZENoUGEvWEVJSmVleUtjS3E1QVFkYWwxb2YzT3QzZjZhbjhrNkw3NlJr?=
 =?utf-8?B?elBPMitNMnhuSXVCOE5pS0xHY2YvV280UjArQVVNNGZad0N3SnpXTjNVT3ky?=
 =?utf-8?B?WG8vNGZKQUpXUFZrcERaVUVHQ3dVaDkxUVJEMzFQTk50Q01hdHlWVUxGQ2J0?=
 =?utf-8?B?aEJBVFVzSjE0RzVMc01mbUp3UEJYTkZoeDI3dXlmWTFLVU5EZVZuK0RJSzR1?=
 =?utf-8?B?WDVUeE1lRStiNEZZbW0vYXhIU2ExL2ZBUFUvdHcxZHA0S1ZQbmNXanlmSzdL?=
 =?utf-8?B?bUllTk5neGc4UkxHaGp6Rm5mYkEvN2VFNitKZHA0Vnl1YnJXZmVWeWlCdFFC?=
 =?utf-8?B?S3FHM0k4WEgvcmw5QlkxTFFjb0xsT1BjWWd3V0FQZ002NTZYRUpZWThmeUt4?=
 =?utf-8?B?MHgwRjFEeHh6Ull2ZW9ES2ZNc1BZNGZ4UC9kSGNrZlNGZHJEYnpOSGVXbXky?=
 =?utf-8?B?dzdya3IzWmVnYklGS2RSZE52UkZpYjAzWVBlKzdTNGNiUjlSbWI0aVFFWVk3?=
 =?utf-8?B?RTVpaXBtQnpKK1dONXd0SHJHMEZtckpuVHdQT0Z4SXN5ZGRLVzVPZTFIc2F3?=
 =?utf-8?B?elNmVmFvNVhRWkVKME1ac05zd3QvblhWNm5XNmNZTE14RHRnaFJLZU9sRUJX?=
 =?utf-8?B?emJpbURyNm9pcU50YUFNUkJKcTlMTVpIZWNVc2E3Tkkwb3gwYlpWcS9ld1NK?=
 =?utf-8?B?a2JYU2dQZ2NPNzQxYzRFR1pSNjdsaUpLaFBSWXdKS0ZGUGJacmJkdUttOG50?=
 =?utf-8?B?d1pwdGcxT3RST0xrN2ExVGtNalhGTEVBd2tnSmVHSEVSWEhTR2QvTkM1YWY4?=
 =?utf-8?B?bGFlN2JJTHpaSSs1Uk80VDBmRkdJcTdxMmtMdXBBb2NUcVc4Ym50OWxWdE1B?=
 =?utf-8?B?OGxERWt4dHJkMjJyZGxpRENvWkhRK0ZCYWI2bE5MSXNVUTFLWE1IbTA5QjlU?=
 =?utf-8?B?d2taSm95ZGhXMlhIeEhOY3doSG9UalA3bisvQW5DVVRjbEx3Z2RBK1ZJY1Jq?=
 =?utf-8?B?STNLQXJGbEdBeld1TWNUK2E1ZWlqTWxkSjl4SmtLbG5JRFFRU0pFNEEyS3dY?=
 =?utf-8?B?d0R3NWJSekpHcXkwR1pBYmxJai84NU5KcytoMDRUbEZrMTBSNFFBRGFwNWJK?=
 =?utf-8?B?ZlRqWkQrdEZsZlpZYTArei9vWlBnTW5MRjQrYWJsckwyUmJmTkJiZWdab3g4?=
 =?utf-8?B?TUNEOWwvcmJ2RGpOS2dQd0haS2RROUxDMWlqZzdaWGN4NGZPcUw0UCtRU2V4?=
 =?utf-8?B?RlFJNmk4dXIxQy9ZUzNiZmlSV2ZLM25qYUc0bE5Ycm5aTUtzOEZKL2xVSGVO?=
 =?utf-8?B?T2lwVzdYQ2krQUxGZm1ZbkNmYWkzOXpMRm4vVEFwM0haTlNHRFptTUYrWVQ1?=
 =?utf-8?B?VEFUeGI3bE10KzVYYXlrajMzT1BGVXVTZnF4TVF1bkt3cjkvSENqeFZjSkRL?=
 =?utf-8?B?QjFYNVgvQzBjWGpIQUVManBpdTNzZjg4djZsa0JwUTA3N0hHc2ozNk9zSWVE?=
 =?utf-8?B?eU9jcGJhUjEyZXIvOGt1aHV0aXRIYy9BQU4rSFJGZytObDlUSkNicE5iRGZC?=
 =?utf-8?B?OS9hZUZ2eU9uV3BPVmF3aEt3Q1l5dDlnVStMOEVSaFk3SWhWazB6aE53dE5P?=
 =?utf-8?B?bGNGeWRQSGlLMkdzckpxT3FXZk1Xd3FES25wOUt3RUg0MmphRzEvVlhEK2Vx?=
 =?utf-8?B?NnNrWWR3b1ByK3hqVWd2dWJCd255Y0dzNVFNQzVjTVlDZGhnaExzaHdma1pC?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D83FDD685AD50B4A87EA6D16387179C6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e470e4e9-2885-4ae3-5328-08db4c73f68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 07:48:34.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlwO97qW+jcUkjAdSdmAYyTxaM/i5UfQZdUwfKqwOPK65c0TiOtN2omwcNUm+KNtmDQ8hbzJRsLX1eBiWT3Ulmm79NIxp+giGNCqbiTm5to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7664
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTI2IGF0IDIxOjI0ICswMjAwLCBhbWVyZ25hdEBiYXlsaWJyZS5jb20g
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gRnJvbTogQWxleGFuZHJlIEJhaWxvbiA8YWJhaWxvbkBi
YXlsaWJyZS5jb20+DQo+IA0KPiBJZiB0aGUgSVAgaXMgVTMsIHRoZSBkcml2ZXIgd2lsbCBjaGVj
ayBzb21lIFVTQjMgc3RhdHVzIGJpdHMuDQo+IFRoaXMgY291bGQgZmFpbCBpZiBvbmx5IFVTQjIg
aXMgdXNlZC4NCj4gVGhpcyBvbmx5IGNoZWNrIHRoZXNlIGJpdHMgaWYgVVNCIG9wZXJhdGUgYXQg
VVNCMyBzcGVlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBCYWlsb24gPGFiYWls
b25AYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gUGFyZW50IDxmcGFyZW50
QGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJn
bmF0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IFRoaXMgcGF0Y2ggaXMgcG9ydGVkIGZyb20gZG93
bnN0cmVhbS4gV2l0aG91dCB0aGlzIGZpeCwgVVNCIGRvZXNuJ3QNCj4gd29yayBpZiBVU0IyIHBy
b3RvY29sIGlzIHVzZWQgZmlyc3QuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvbXR1My9tdHUzX2Nv
cmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCj4g
Yi9kcml2ZXJzL3VzYi9tdHUzL210dTNfY29yZS5jDQo+IGluZGV4IGEzYTYyODI4OTNkMC4uMDBk
YmE4NzFhZmY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCj4gQEAgLTEwMCw3ICsxMDAsNyBA
QCBzdGF0aWMgaW50IG10dTNfZGV2aWNlX2VuYWJsZShzdHJ1Y3QgbXR1MyAqbXR1KQ0KPiANCj4g
ICAgICAgICBtdHUzX2NscmJpdHMoaWJhc2UsIFUzRF9TU1VTQl9JUF9QV19DVFJMMiwgU1NVU0Jf
SVBfREVWX1BETik7DQo+IA0KPiAtICAgICAgIGlmIChtdHUtPnUzX2NhcGFibGUpIHsNCj4gKyAg
ICAgICBpZiAobXR1LT51M19jYXBhYmxlICYmIG10dS0+bWF4X3NwZWVkID49IFVTQl9TUEVFRF9T
VVBFUikgew0KTkFLDQoNCk1heWJlIHlvdSBtaXN1bmRlcnN0YW5kIHRoZSB1c2FnZSBvZiBAdTNf
Y2FwYWJsZSwgaWYgeW91IG9ubHkgdXNlIHUyDQpmdW5jdGlvbiBidXQgdGhlIGNvbnRyb2xsZXIg
c3VwcG9ydCB1MyBmdW5jdGlvbiwgc2hhbGwgZGlzYWJsZSB1MyBieSAgDQpwcm9wZXJ0eSAibWVk
aWF0ZWssdTNwLWRpcy1tc2siLCB0aGVuIG5vIG5lZWQgY2hlY2sgc3BlZWQgaGVyZS4NCg0KVGhh
bmtzDQoNCj4gICAgICAgICAgICAgICAgIGNoZWNrX2NsayA9IFNTVVNCX1UzX01BQ19SU1RfQl9T
VFM7DQo+ICAgICAgICAgICAgICAgICBtdHUzX2NscmJpdHMoaWJhc2UsIFNTVVNCX1UzX0NUUkwo
MCksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIChTU1VTQl9VM19QT1JUX0RJUyB8IFNTVVNC
X1UzX1BPUlRfUEROIHwNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZmUxNWMyNmVlMjZlZmEx
MTc0MWE3YjYzMmU5ZjIzYjAxYWNhNGNjNg0KPiBjaGFuZ2UtaWQ6IDIwMjMwNDI2LXVzYi1tdHUz
LWltcHJvdmVtZW50LTc3ZDk4N2RlZjlmZQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBB
bGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiANCg==
