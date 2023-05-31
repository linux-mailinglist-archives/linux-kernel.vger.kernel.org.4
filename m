Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6D717D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjEaKXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjEaKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:22:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90110E;
        Wed, 31 May 2023 03:22:38 -0700 (PDT)
X-UUID: 0d135620ff9d11edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OspJCl4NgQIN1ecl3VRn6sDztnlmS41ZiWOiFXVMKZU=;
        b=QQvTHrVa86nCJhs0+f9aDm4YpoXzyYrBU//I7jneQhYsf0bL+AIdtTk42ZZoTCqf2BMu1UxEUFWKho4y4bjijsZMVpmgHDEXsiAm8mybJWyAQmz0i73KMwkrKPGyN3v+ojLxSVXizR6kUGK2zLchm8XOovoMPTfA45LR4QF93sc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c8a046be-a339-4750-9485-8a894674b809,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ee1ff03c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0d135620ff9d11edb20a276fd37b9834-20230531
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 278863586; Wed, 31 May 2023 18:22:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 18:22:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 18:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3oZ8YxSH8gFhGCWjnoydGUh8xARODmpqOaVCK8n31lbvR3xWTS9cO0YIs5+Lg4b2puai0EEf0kegfvLknNQdphppWDxqLxs35V/OUpW7cvK5dQLsTUvrareZmmtDrLBgE9W54Sa5SKVNwUBrPHCrG3bGUxqQ59n/2O9tusfbGny0MXYsCnvhRMgjS4O5Q+wjp0KnbZc43eklJg7wM5lsMo1QxC3WCIiN+IH6eKrCxulqQx9iKZlZosNnfZbGvazqDVI/I0FNXM2zTHtwRGshZ9DN9ZCyNwuw3Q7fD3dszzYBdSftci40TRsdyjTMmlpGmGO7SQnQp3Dg0o0FHJHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OspJCl4NgQIN1ecl3VRn6sDztnlmS41ZiWOiFXVMKZU=;
 b=j27DL5oVtYoZ8AxGKqDKA+KcibKVQepeRx+1jXPGIQI0mDKySw43HVGmHZqCwBgg+JZBCrAwT/eCooyv9MT5uKQAQNSzZwEl9df5sGUIrg6N4hBzUMl9LHAyeZ/0vBfCklyHop0OpnznBAceH3gECiydQLUIcwYygkIT35wVNP0Aetb3X7dwcHjkM941EFPSSsWM/4YCw6hVu1t4aeZcWOsmlf70l5+2gKpa9ExD1w6aPcThn1KmpgJT5xZVbWnTJ7W5BWeJlmI5MqKRNf37CL3V8iRRmX/yhYX8hvQGDkJ9RK0124c/Zo6KVDKymyk5Z+LEZCLwJNwDrsLC0QWSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OspJCl4NgQIN1ecl3VRn6sDztnlmS41ZiWOiFXVMKZU=;
 b=GrQHLNUJk5K6AKXZjBKkhpxDitK0TVUXQ7WtGug7Dbzuy9ccrLI+/2reXO6rQRKa7BC/EEp8z/60LvCvkW24GvYJ2Stf1B+1SW1/Jg8LEsZYa8uNN9nf86q9dlrR3Sz+bTgGa2UKwN3OC9WSIqihfXrVltkPfe4ST2iNreomRf4=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by JH0PR03MB7835.apcprd03.prod.outlook.com (2603:1096:990:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Wed, 31 May
 2023 10:22:27 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 10:22:27 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5,8/8] media: mediatek: vcodec: Add dbgfs help function
Thread-Topic: [PATCH v5,8/8] media: mediatek: vcodec: Add dbgfs help function
Thread-Index: AQHZkt6Pmc3I6xwlJkmIZtnuTxG/0q9ynoaAgAGPVAA=
Date:   Wed, 31 May 2023 10:22:27 +0000
Message-ID: <7820b5c393b1a0cb3bfca571d557bdf9dc5bf97b.camel@mediatek.com>
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
         <20230525021219.23638-9-yunfei.dong@mediatek.com>
         <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
         <da165529-ae9a-8461-c582-9c85e6f2fa4c@xs4all.nl>
In-Reply-To: <da165529-ae9a-8461-c582-9c85e6f2fa4c@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|JH0PR03MB7835:EE_
x-ms-office365-filtering-correlation-id: 05355923-f276-4b7e-7c18-08db61c0eefc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MVa6ep49Ie+3T5lnXrJS2GIOPypIg3NKYdhYZku3pcMiD9fUBDQ7ZVGAvgKJf8bqfQS70vLa1R3nB6eJmvWlzdyAuc8DefhCHoEi7+p+zo+cj18l2hHT+O9GhLv3mCqXrmhZmp+aTZIuKlh6YShdLmShQ+ewGvx1fCsqdj1K60lwD4wbTCWs4gB+ayVSF2f7rmZEdm49cor79bdm2gbzBAitbxYkQnOwFRdmN9We2kpeDTmj1gXc9ole8K9ShwxLGVufB4pmgMMrsr2bHGTqD0RODAIpLzDWljMJDvqeqC400JjGbCjVubVSKeoZJeXChSiL/Ger6YzugeYb09ZKzcSuBR2TzMJ+lDLeJ+uiu26hE3raqmcE7haax644T2hUGm64CRJcnS0fca3BXfhDSCcNmH75D+mAW1nLTMxXKafJYKwHyolc6yFIqmTUGVCKJewmD7UDe/ymU37Yo+K2lZ3KOowy2GifMqSUBJ+6RAIhRWLmSE2TKePY61z5Lvu256TINiyGbeEacoE8cGYi1xBBo81OCI9GoWYjEgmfu0X1KQ/6tzYR9/yT6PxymaE7idS+/eQNv1yAlC9fGOnAi//arQM2p8TjcgAVRfl1zmhBVh60iMf0TFRu9eRcdpj9FgL96cyFq7xlxfxeta1F1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(2616005)(66556008)(186003)(83380400001)(110136005)(4326008)(26005)(5660300002)(6512007)(54906003)(6506007)(53546011)(36756003)(85182001)(86362001)(2906002)(7416002)(478600001)(91956017)(8936002)(8676002)(66476007)(66446008)(66946007)(76116006)(64756008)(71200400001)(316002)(38100700002)(6486002)(122000001)(38070700005)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WldBMUtHZlVYd092bWlIZFhlTVE4R3dhOU0wNWtvM08rWlVkQlRUaGFiV0xR?=
 =?utf-8?B?RmZ3YTV2cXNFbVBVcU5VVjRxOVc2QmU4M0ZqOGYzanhPZjdYNlVQWk8xZHJG?=
 =?utf-8?B?Tm4wOHRMT2xDb0hyYzUvTTBYZHBod0NMb1UxWXMwa3VhWU1mTW40amwrb2Ni?=
 =?utf-8?B?KzdTVFN5Mmdpb213NStlM2FuUjJuMTR5TDVqdVZRWU9CTVZmRVFGQVNTY2JY?=
 =?utf-8?B?YWVDSGJQU1J6Z3Q5enlSNlh1SzBmOGhHbFdvSFZPcktxRml2cmtEOGRsdmJ2?=
 =?utf-8?B?UjN0MWgzaSs3U0tEaUwvczVxSUxrTER0MGdsU1ZWYWc1K1BHajl2akJRZ3hF?=
 =?utf-8?B?RFlmbDBzVjBxQXVmV2UyNm4xOFVpazJpZU1pWmFsQ3c4Qk1TZUpFQy9iZS93?=
 =?utf-8?B?RDlnMFdwUHJ2RXI4YURDOFNreU5UUENMTEQ2QnZQTEJERGZrOEhUWUM0cFZP?=
 =?utf-8?B?RURUMjkyQSsvMGZEYnRPN01RUlFXbmExWGxHb2JxdWVtY3RMS3U3VU1lQ3hn?=
 =?utf-8?B?VFh5VHpsR0JtV0ZTL3RBR1kzV1JySFB2RkcyWVk1aUlRZ05RNTlRaSthYzFi?=
 =?utf-8?B?Zk5RUEFKUllqQzNiQnVzVk1yMFExNDJ2N1N0eUh0WGpWbmdlaHZwT1I3SFdG?=
 =?utf-8?B?TE5oRVV3VS9xb2RodzJUM3hUU21WQ0Frd0dqdUIrT2JJWUl1cVdVbFhEcWZ1?=
 =?utf-8?B?a3JsK0FXSlh4NVJ3U1ZUMGJXdUpsTkdaa3JHa0pjdzJ3OGcwQ0cvT1dveGQr?=
 =?utf-8?B?Z1Z1UVpteUpmT05qVWtaK0dKMFNTVlkvUDR4NHZqY2pIS0cyMUZwd2FEajdZ?=
 =?utf-8?B?eDdEUFBWNElmM3BjVnZqcnhETGdORVRaM213MEJXeExOdWdJSnBoclVSYnkr?=
 =?utf-8?B?RFk3d0JvZldDV3IrU2lSNkVFVkc0SzRNMkpXVnpzMTNUYy96MTRFR3lTMGpw?=
 =?utf-8?B?ZzhIcWhjbURSRFRBRUZSWDgwRFFPWndBVjNJQ1RFclZlUHB5US93NnkxZmhu?=
 =?utf-8?B?MFJ6b0JwR0s5RFk0Smlidnp6dEtmdUhkcFNCU3dBUGs3WnB1RExQeG52NG1X?=
 =?utf-8?B?Ymp3OEtBS21HZWYwMm5TWWYwVHlhL2YvUmxkSE1idUVuN3VVaVZodGE4VWtO?=
 =?utf-8?B?bEFZZG1TV0pWT0haeExPR1lhWFBWQkdZRjVMbEJEdUZwUW9DRVd2dzJrR2t5?=
 =?utf-8?B?TTFlN3VGdVF4SnlIUk5zSXJPM0FLbDIwUmJJTUg1RDhQcm5nK3IrOUpyQ293?=
 =?utf-8?B?SXZOcFV6UHRLNG0wbXliVHpkOElrSWFncjR2ZzJtS2ZMZys0dDFNd2NMOWc4?=
 =?utf-8?B?UkJTTjhKa3pzbEoxbXJQMFVJZTZQc3lXODQ3TDNqZlkzcjkvMCtpaldmSEd3?=
 =?utf-8?B?SmY1Y2VwSXAxYzduUzJXaGZuMlQ1YmhYcFNNL3V3SjBBemFHazkrcFo4ZVBm?=
 =?utf-8?B?L3g3ZmpIVG5nT1EyKzJYMGtQcnhTWHY1aWhKYkFJaXh0OVpmN0ZmZEJtbzhK?=
 =?utf-8?B?TFE3cjRBSzBZK05NdlZFcnBkbVRXWmE4ZUYrU1JTUDF5TGhEaENPZVM3QUxK?=
 =?utf-8?B?YnVPZjluNE4rdXBBQXU1aGwzL1QwNElYVHlsWXZMTCszdi9MRXVDaFQ0RjNW?=
 =?utf-8?B?amlYS2V6ZGdhcWZLVTU1dnpEWFpoNnJnclAxU0gvenhicjREWktlZXRJbzRt?=
 =?utf-8?B?UExodE1XWlNWeDRLc2wwenpIR3UyRExVSVVWQXVMbFkwWWhiWTNqWGd0cXhi?=
 =?utf-8?B?WXNlM1NvUExjb1JHWGlTL2hSZ1FoRnJtbGY1WkFnMWJXS05kenhFK0NRQ3JW?=
 =?utf-8?B?b0JUeHpyd2pqNUJ5bDFzRzRYcjZPeUIwTFNDSVBXNngxdE1DVWoyZzN5cmFn?=
 =?utf-8?B?bFAyR0VWSDhVTkFkRHY3eFJGcTY2bHI4aVJibzZaL3YzeUlTV1R6YUdkYWV1?=
 =?utf-8?B?MlZKOXphYytjMVdwMmVLVGdsZW53VTZVbTlkcmhFcFJtSHhpdHA1TjdmMUVS?=
 =?utf-8?B?VUNsdGZPN1FyaDR4aDRIYnBJa1MvRUNCWXU1Z2FlYk5uK3hCUVVJTnZNRmtT?=
 =?utf-8?B?MUM0cWdCWklzQVZRQVJiZHh1VEZFNENjRnZIWEhMbDVWQWo5L0ZnczFnY0k4?=
 =?utf-8?B?VmZlN0QrQW1ENGtFODFkN2hTOFYwSTJSa2RJNmQ4T0ZTVHA4cVhNckZ2cmcv?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8014A11643B314A83FE2338A8518AF0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05355923-f276-4b7e-7c18-08db61c0eefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 10:22:27.3892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l/9ws+T5yi8TzVN2aGCTTSbnPvsdL1QnwwiuXGhzjD86mmEDKDzF4SJLzLUeTrLzFGS4mrXhKA3UeSOyeoRfjb5NpdYrS/U1sckSJQcCPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7835
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KT24gVHVlLCAyMDIzLTA1LTMwIGF0IDEyOjMzICswMjAwLCBIYW5zIFZlcmt1
aWwgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gNS8zMC8yMyAxMjowNiwgQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gSWwgMjUvMDUvMjMgMDQ6MTIsIFl1bmZlaSBEb25n
IGhhIHNjcml0dG86DQo+ID4+IEdldHRpbmcgZGJnZnMgaGVscCBpbmZvcm1hdGlvbiB3aXRoIGNv
bW1hbmQgImVjaG8gLWhlbHAgPiB2ZGVjIi4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWXVu
ZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgLi4u
L21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMgICAgICAgIHwgMjQNCj4gKysrKysr
KysrKysrKysrKysrLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gPj4gaW5k
ZXggMjM3ZDBkYzhhMWZjLi4yMzcyZmM0NDliNDUgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGJnZnMuYw0KPiA+PiAr
KysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2Ri
Z2ZzLmMNCj4gPj4gQEAgLTUyLDYgKzUyLDIzIEBAIHN0YXRpYyB2b2lkDQo+IG10a192ZGVjX2Ri
Z2ZzX2dldF9mb3JtYXRfdHlwZShzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKmN0eCwgY2hhciAqYnVm
DQo+ID4+ICAgKnVzZWQgKz0gY3Vycl9sZW47DQo+ID4+ICAgfQ0KPiA+PiAgIA0KPiA+PiArc3Rh
dGljIHZvaWQgbXRrX3ZkZWNfZGJnZnNfZ2V0X2hlbHAoY2hhciAqYnVmLCBpbnQgKnVzZWQsIGlu
dA0KPiB0b3RhbCkNCj4gPj4gK3sNCj4gPj4gK2ludCBjdXJyX2xlbjsNCj4gPj4gKw0KPiA+PiAr
Y3Vycl9sZW4gPSBzbnByaW50ZihidWYgKyAqdXNlZCwgdG90YWwgLSAqdXNlZCwNCj4gPj4gKyAg
ICAiaGVscDogKDE6IGVjaG8gLSdpbmZvJyA+IHZkZWMgMjogY2F0IHZkZWMpXG4iKTsNCj4gPj4g
Kyp1c2VkICs9IGN1cnJfbGVuOw0KPiA+PiArDQo+ID4+ICtjdXJyX2xlbiA9IHNucHJpbnRmKGJ1
ZiArICp1c2VkLCB0b3RhbCAtICp1c2VkLA0KPiA+PiArICAgICJcdC1waWNpbmZvOiBnZXQgcmVz
b2x1dGlvblxuIik7DQo+ID4+ICsqdXNlZCArPSBjdXJyX2xlbjsNCj4gPj4gKw0KPiA+PiArY3Vy
cl9sZW4gPSBzbnByaW50ZihidWYgKyAqdXNlZCwgdG90YWwgLSAqdXNlZCwNCj4gPj4gKyAgICAi
XHQtZm9ybWF0OiBnZXQgb3V0cHV0ICYgY2FwdHVyZSBxdWV1ZSBmb3JtYXRcbiIpOw0KPiA+PiAr
KnVzZWQgKz0gY3Vycl9sZW47DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gICBzdGF0aWMgc3NpemVf
dCBtdGtfdmRlY19kYmdmc193cml0ZShzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3QNCj4gY2hhciBf
X3VzZXIgKnVidWYsDQo+ID4+ICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiA+
PiAgIHsNCj4gPj4gQEAgLTg0LDYgKzEwMSwxMSBAQCBzdGF0aWMgc3NpemVfdCBtdGtfdmRlY19k
Ymdmc19yZWFkKHN0cnVjdCBmaWxlDQo+ICpmaWxwLCBjaGFyIF9fdXNlciAqdWJ1ZiwNCj4gPj4g
ICBpZiAoIWJ1ZikNCj4gPj4gICByZXR1cm4gLUVOT01FTTsNCj4gPj4gICANCj4gPj4gK2lmIChz
dHJzdHIoZGJnZnMtPmRiZ2ZzX2J1ZiwgIi1oZWxwIikpIHsNCj4gPiANCj4gPiBJIHdvdWxkIHBy
aW50IHRoZSBoZWxwIHN0cmluZ3MgaW4gdHdvIGNvbmRpdGlvbnM6DQo+ID4gMS4gLWhlbHANCj4g
PiAyLiAobm90aGluZykNCj4gPiANCj4gPiAuLi5zbyB0aGF0IGlmIHlvdSBkb24ndCBlY2hvIGFu
eXRoaW5nIHRvIHZkZWMgKG5vIHBhcmFtcyksIHlvdSBnZXQNCj4gdGhlIGhlbHAgdGV4dC4NCj4g
PiBPdGhlcndpc2UsIHlvdSB3b3VsZCBoYXZlIHRvIGtub3cgdGhhdCAiLWhlbHAiIGlzIGEgcGFy
YW1ldGVyIHRoYXQNCj4gZ2l2ZXMgeW91IGhlbHANCj4gPiB0ZXh0IGluIHRoZSBmaXJzdCBwbGFj
ZS4NCj4gPiANCj4gPiBBcyBmb3IgdGhpcyBjb21taXQgImFzIGlzIiwgaXQgd29ya3MgYXMgaW50
ZW5kZWQgYW5kIGl0IGlzIHVzZWZ1bA0KPiB0byByZXRyaWV2ZQ0KPiA+IHRoZSBoZWxwIHRleHQ7
IHlvdSBjYW4gZWl0aGVyIHNlbmQgYSBmb2xsb3d1cCBjb21taXQgdGhhdCBleHRlbmRzDQo+IHRo
ZSBoZWxwIHRvDQo+ID4gdGhlIGNvcm5lciBjYXNlIHRoYXQgSSd2ZSBleHBsYWluZWQsIG9yIHNl
bmQgYSB2NiBhZGRpbmcgdGhhdCB0bw0KPiB0aGlzIHNhbWUgY29tbWl0Lg0KPiA+IA0KPiA+IEkg
d291bGQgcHJlZmVyIHRvIHNlZSBhIHY2IC0tIEJVVCAtLSBzaW5jZSB0aGlzIHNlcmllcyB3YXMg
c2VudCBhDQo+IGxvbmcgdGltZSBhZ28sDQo+ID4geW91IHdpbGwgZ2V0IG15IFItYiBhbmQgSSB3
aWxsIGxlYXZlIHRoZSBmaW5hbCBjaG9pY2UgdG8gSGFucy4NCj4gPiANCj4gPiBSZXZpZXdlZC1i
eTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+ID4gDQo+ID4gDQo+IA0KPiBJIHByZWZlciBhIHY2LCByZWJh
c2VkIG9uIHRvcCBvZiB0aGUgbWVkaWFfc3RhZ2UgdHJlZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0K
PiBIYW5zDQoNCkkgYWxyZWFkeSBoYXZlIHNlbnQgcGF0Y2ggdjYgdG8gcmV2aWV3Lg0KDQpCZXN0
IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0K
