Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC66382B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKYD1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYD1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:27:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68A1142;
        Thu, 24 Nov 2022 19:27:28 -0800 (PST)
X-UUID: 35d03c51920f425587b42e422b4e8e58-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KcDQZjVQ0AaNSJQC4CtXHIF/QWKdXzu6QIT1Ub1UbDQ=;
        b=c1tZfNxGnjhyyfakd1y7Q5Qqt3iiEpc9B82Fj/sx0gxot/S5QB8sR6ybNmL2AQBmbuzL7RoyXbUlp1WFYZY1VOQjySdh1IMJHV4TLBj9FFG0hEUNvUzJtU7O7lOJ9gq1KeJYOY1qe25h9IiEx0y4s2k32bGRNKB98VTU0ocNGIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ed7cc1ed-eb32-4e66-ab26-1b50546be31f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:59bd32dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 35d03c51920f425587b42e422b4e8e58-20221125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 151443348; Fri, 25 Nov 2022 11:27:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 11:27:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 25 Nov 2022 11:27:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNKUPbSl3UmRZpyJR02mFyqeE0jXs8BrImy2fqfCofGqzihX6OO0DsnQEPlgo/ijYoWn7nYDNu8RKXYDEsLp+Sx4UaTB5iz3U8ZzmgcL0LQ4zR6BXcsmlwQGOcfOefjZQ0rnv253N0ncI1FFX/Z7S1XE3Sg/TFoIstWiMFf2XafV9pOh4QKIp4ZiTXVRpuWp4720cWE7HAo4vK2r1+xyhkRyAVupWEixCQnNDpKlyQfFAWBlvuXuqka3klbH/UuoOeYHi8mO6y69Wue8/HKNQ4H8WgluouY4nkWo9j9lRGqZCNW9kDjq2RuODxrBsp48qhqMTtJRL4LY1TMq66aY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcDQZjVQ0AaNSJQC4CtXHIF/QWKdXzu6QIT1Ub1UbDQ=;
 b=kprlgYoJ+tZqsKSro36l2/prsYa2Z8PySmnbGVxQ6LapUjCzlozZSrLIGKXp1QR6ur9XPpMRWT+Bvf26VXUqIYW5bfHFhnQ3oCUY0tYI31tlJF5zHX0r4DYacnej43ab/Y6ssz3jeg1YVCFS3rm98dhh4BonrGcOGIEAAiKqMI9D+mz1uZ8sDaiRISRGRfRCObevkX81xdFWZ8LZb28a4vBp1rbu79XgaEI70aaT6R6waDJPfXC1KCyqaUEhi2GkQ6neZH82ggLrG9YMtlEkg1UpDFS3eLNie8U+Lvm+vqnnS7VpUhrajsLp4G8VODL+5vhGu8VW7JPG4J9C0icI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcDQZjVQ0AaNSJQC4CtXHIF/QWKdXzu6QIT1Ub1UbDQ=;
 b=ElHnhZJeTxbAYoMJIFHCoLobDDyGmKJJAOJIBIug/eAhyZqRsCb5bqIK2WcKs5oBscGvKKK7rqy95fn7AgEcoOwD4rXQgr+CMxtpiCzTvAH671ePOp3/aZKrjVPeiZ2KMysqqcwzuYx1BgAe8NwizU7YQJt4ZQeNXDDnDGd38is=
Received: from PUZPR03MB5877.apcprd03.prod.outlook.com (2603:1096:301:a5::6)
 by PSAPR03MB5557.apcprd03.prod.outlook.com (2603:1096:301:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 03:27:19 +0000
Received: from PUZPR03MB5877.apcprd03.prod.outlook.com
 ([fe80::6bf6:aaf0:3698:5453]) by PUZPR03MB5877.apcprd03.prod.outlook.com
 ([fe80::6bf6:aaf0:3698:5453%5]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 03:27:19 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8188
Thread-Topic: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for mt8188
Thread-Index: AQHY0xacBLACySQjSEmWgnHQQK+7+a397c8AgFFnn4A=
Date:   Fri, 25 Nov 2022 03:27:19 +0000
Message-ID: <ce3a47c67d4ac8a364cdea6cc4dda1d9c015b3d8.camel@mediatek.com>
References: <20220928084315.29187-1-Garmin.Chang@mediatek.com>
         <20220928084315.29187-3-Garmin.Chang@mediatek.com>
         <ca0f9e3c-ae3f-b886-bfe9-63d7e45c9b3c@collabora.com>
In-Reply-To: <ca0f9e3c-ae3f-b886-bfe9-63d7e45c9b3c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5877:EE_|PSAPR03MB5557:EE_
x-ms-office365-filtering-correlation-id: 79f1d6e9-5861-4c37-820c-08dace94f56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kqYRu1ZdWT4+Y7IKSQ4v/JX+AHfz1kR/RDq2HFQLvmplLBP4Nlz6tIzmwqo5P1aVjNXlOZ5fq9IrsGSZpDkTkZOMFacRgvRrKcAqE1Y81gGcoMz2ZXQ16uquQWbiNkSDttkUr5FsAit/Y1o7QfxF3cXuMz9Nx+kbHFC0VzEnLgpmeZXYrr6NOyQD5u6B4VviHRl+HUKaMPwkz6ZuedtD/43tDeyOzfYOzKtjQoMfk5Pa6zwViZ4t/NOfEo2b8QqgcBzvQ8OIqDHGhD1xESdlrbbtQPjsO6D1zAvJqGYRItWpDsw6Ikd4VeKxFQl8ViKmP8vNqq4Ih4ZN4RHw7qul4/i/Sn1cY/nHR0q7FttQwpUzPCECWG8Hw9toRL1XGFANMuFjiGQVHdz7lhAcMBvmrVpexYIM/KfJ+zF6BUpuKh40i3tNqSIZanoenalG31c6x/54HAiufd16ayf4x+jIBPDs7FA7No04BtNHMQe3keUUKMUxcRwUMkMv1/3KINJ0BS/if/Fr+2AsZm9FiZXIN76/AouQAAd7ZXsGEiWpcIGouokUBIniTgcaIPXRmzc49iMi+bKVMN+f2zUhV+rRi2ExpgQs/TYlxJGNqjauX3nWvSnHezJixZn9SxsiWAiGl7aFC5kcI6ywFcduoBkbSSOgZDIvK0tgFti8YlswCPYGWO4l5ucwHmHJD3zU0HJ+5CC3K1CiGW8+gQ84yOAkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(86362001)(110136005)(54906003)(6506007)(71200400001)(6486002)(38070700005)(36756003)(85182001)(122000001)(6512007)(2616005)(186003)(38100700002)(8936002)(64756008)(5660300002)(26005)(478600001)(2906002)(66446008)(8676002)(66476007)(91956017)(76116006)(66946007)(66556008)(4326008)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0Zjd2FncGZpOHZrelJuVGYvVjNoRGR3cWc5U2RLUVY5ZDhXRW9tVm1jWURS?=
 =?utf-8?B?cUt5dm1XV1labUpOcnRZUUZqcG9QTHVSQ0pUZlBjNi95eHhJdGhFa09lbFA5?=
 =?utf-8?B?RTZZWVJqR2F3a1RVZm13TnV4MmRTdjM4YWdLU3R6Y0Q3VW9nVnNpd0RyTHpC?=
 =?utf-8?B?RXgxWm5FY3ZNd3hmV0IxSS82WkJIYnRvdUpGWWhLUUswTENYZEZzVno0MTB0?=
 =?utf-8?B?RFNxeG4vNXg5dFJxYXZyMEp4eThNN2hBdG9Reks0RlNpQTUyZnRRdnRWV1Iz?=
 =?utf-8?B?azJmdnpRK0lJMGIrODlFaUoyWlR3d2VxYS9NL2paTEo4UnRocTVuTVk1NE1O?=
 =?utf-8?B?UW9KZFBLTnlUam9nUmNMS2VXTlFJQ1V5d2pENjZEL05aeFlhTzQrajh5bHNx?=
 =?utf-8?B?cXRqM2IxU2gyVFIxUWQ1UHRsbk1Cei8wTmFoTnRIMWJPUWRvbFVwYXhEZng3?=
 =?utf-8?B?Z25BbU9xbWR5RXphdVY2TWJTZHpPeEVhRHk2blRmUWVzMzl4SlFDWkYxd1JT?=
 =?utf-8?B?YUcveERzTTE0NkNjTUE2bkJ4VlNZMEF1bnIxdVZPV05FUkpRc2tPaDc2bFNp?=
 =?utf-8?B?UDV1QjB1WXNoM2R5OTQ4aXlNS3BmeWFCN0ZCcU56R1pSRXdmVmphd3ZmeUNU?=
 =?utf-8?B?UEFtb3pJRUd5emVUOGQ0QjFveEVHdjd5QWJvNE0xeDhnYTJ2RE55dDRwZ09K?=
 =?utf-8?B?NDUwTkxVV0lsd1A3cUk1b08rUmxMaUtyQTNRb3NCeFZKQjdCTVBMTW1lWkh3?=
 =?utf-8?B?dmE4VGxKcFQwSVFFdUowZjU3WHpESTR3SVVHcFcwakFYZnpMaHZUNmF2TU9T?=
 =?utf-8?B?MFZHcUo0VmMvbUtiOFlPOWNhUGZyYTVkdkN3OG9ITVJucHNtMHRWYml3WTBT?=
 =?utf-8?B?YjNPbnpnbnZBa2N6TVJNZEhWcytBUXkyL1grVDZrc3ZpMy9memlCaSt1WndV?=
 =?utf-8?B?QkR2L04wRXB5QTYzdnVqRHpVYWtnSzN4c1I0VGQ4WnZ2WVpkMzVjdXBIcjhB?=
 =?utf-8?B?dER6NGNacGUxVzRtV0FVZUJDZi9STEJoZy9yQzZMdGRpUWRZL2FabUNRQkxI?=
 =?utf-8?B?OWxZUlE2aVI4cStOMlVQYm5xaXpaczF4azVleDQvTDlSUFZxeDFzRmxaVjB2?=
 =?utf-8?B?WitrOXFFWWQ2R09hQXJNcExXZ20wS214NHFyZVpEMXJXRjNIeUtFeENJb2hK?=
 =?utf-8?B?SFR5YnQzOHl0K0J1MVBQSUVSVVdRVWNKM3Z0bnEyaWJLSU5XLzQzUWV1WEJG?=
 =?utf-8?B?WU5FRDN6dGJMdGV0bkZnZmpuNXRnVEp1cmVudC9QMXhnVm5HTDFkK0N4TTR2?=
 =?utf-8?B?SVE4VWdXTld0NFljNnZXanhXWm1tZ1BGcHJWYjYyUERHeEhqVUlIZi9lQVBw?=
 =?utf-8?B?aUxxd283TGxuNm4zTjN0N2VTMU0vM3QvRmcyalJrWG91S29CR3d2aURRM1Bs?=
 =?utf-8?B?OUR3NklQTlh6UU55WU9SN2JUY2s2Qnd2YnJVYVJVdHY0VElvNVNodWl0a256?=
 =?utf-8?B?S1prWXA4bWVoMVZqZDF4SklsTTlxemYwd0ViZW5nN2F3eUJrZ0RZVTN1ck8v?=
 =?utf-8?B?dUVaRDhxK2E3MzFxSEFEZjFYSVlGZWhDWnFlVnVERkVnMTVXaUtXbVBRY1Nm?=
 =?utf-8?B?WnZjNksvakc3L1hRaWlQQ1NqVSticC9mU1dlQ2dnNkpvSU9CbE1OSWJBMWFD?=
 =?utf-8?B?L01xSmphQituMUkvUjhWM1pUMVdzRzNSZGFoampvaG1scVJOenVsbjFZcmVo?=
 =?utf-8?B?TWhLNzVPdG1rS3QxTGRSSkZwQ2pJZkhTUHo1UUN6OHVlcDJtc0pEbGVlYjhS?=
 =?utf-8?B?dkR0SW9TVklrb205N1FYZlpoWGt1bUVOZXppQ3YxRmlneExBZG02UGdHZGx0?=
 =?utf-8?B?bURoMmVqZzF0N0Z3RzJ3YTU0SlRLa0JVbCtJeTNqa1l4MjNpUlk1WWlxeDZ4?=
 =?utf-8?B?U1I0d2ppWVJiR3JtcDY0VGIxU0JIcHdEZ011QlNndW83WVZQczJzVjVPeHJ5?=
 =?utf-8?B?VHZNZG5RNTNjWU9VQjFGb3E5R01OVGw0MDJsc3NNY2dRL3FHdFVBbjVoaEoy?=
 =?utf-8?B?UElCdDg5KzF1bnAwU2k5Q1dqVkN2Q3B0aXA4Q1NhY0lhWCs3QXVXYU9IVGFW?=
 =?utf-8?B?RStSTFdOVnI0RmUxRTJidTFIWW8reXhGdWFySTA4bDhQa1lqYVhGby9JYjky?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDAB7F0810E6264BB4E511E8EAA6AB3D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f1d6e9-5861-4c37-820c-08dace94f56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 03:27:19.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG3kRmqu4OUSYA338Fhrmt5xs7NOCkH8j+Er0EyBh2qwGlVPc6QTSBWDdnjhmS6WAYF8K3MM50JxhJrxaZMobxRdbPTRu+FtegSwpY7MBLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5557
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDEwOjE5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDkvMjIgMTA6NDMsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBkb21haW4gY29udHJvbCBkYXRhIGluY2x1ZGluZyBidXMgcHJvdGVjdGlvbiBk
YXRhIHNpemUNCj4gPiBjaGFuZ2UgZHVlIHRvIG1vcmUgcHJvdGVjdGlvbiBzdGVwcyBpbiBtdDgx
ODguDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogR2FybWluLkNoYW5nIDxHYXJtaW4uQ2hhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg4
LXBtLWRvbWFpbnMuaCB8IDYyMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jICAgIHwgICA1ICsNCj4gPiAgIGlu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggICAgfCAxMjEgKysrKysNCj4gPiAg
IDMgZmlsZXMgY2hhbmdlZCwgNzQ5IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODgtcG0tZG9tYWlucy5oDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4OC1wbS1kb21haW5zLmgNCj4g
PiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4OC1wbS1kb21haW5zLmgNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNjMxODFmMDU0NTdlDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ODE4OC1wbS1k
b21haW5zLmgNCj4gPiBAQCAtMCwwICsxLDYyMyBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoYykg
MjAyMiBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1dGhvcjogR2FybWluIENoYW5nIDxnYXJtaW4u
Y2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgX19TT0Nf
TUVESUFURUtfTVQ4MTg4X1BNX0RPTUFJTlNfSA0KPiA+ICsjZGVmaW5lIF9fU09DX01FRElBVEVL
X01UODE4OF9QTV9ET01BSU5TX0gNCj4gPiArDQo+ID4gKyNpbmNsdWRlICJtdGstcG0tZG9tYWlu
cy5oIg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbWVkaWF0ZWssbXQ4MTg4LXBv
d2VyLmg+DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBNVDgxODggcG93ZXIgZG9tYWluIHN1cHBv
cnQNCj4gPiArICovDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNjcHN5c19kb21h
aW5fZGF0YSBzY3BzeXNfZG9tYWluX2RhdGFfbXQ4MTg4W10NCj4gPiA9IHsNCj4gPiArCVtNVDgx
ODhfUE9XRVJfRE9NQUlOX01GRzBdID0gew0KPiA+ICsJCS5uYW1lID0gIm1mZzAiLA0KPiA+ICsJ
CS5zdGFfbWFzayA9IEJJVCgxKSwNCj4gPiArCQkuY3RsX29mZnMgPSAweDMwMCwNCj4gPiArCQku
cHdyX3N0YV9vZmZzID0gMHgxNzQsDQo+ID4gKwkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MTc4LA0K
PiA+ICsJCS5zcmFtX3Bkbl9iaXRzID0gQklUKDgpLA0KPiA+ICsJCS5zcmFtX3Bkbl9hY2tfYml0
cyA9IEJJVCgxMiksDQo+ID4gKwkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGIHwN
Cj4gPiBNVEtfU0NQRF9ET01BSU5fU1VQUExZLA0KPiA+ICsJfSwNCj4gPiArCVtNVDgxODhfUE9X
RVJfRE9NQUlOX01GRzFdID0gew0KPiA+ICsJCS5uYW1lID0gIm1mZzEiLA0KPiA+ICsJCS5zdGFf
bWFzayA9IEJJVCgyKSwNCj4gPiArCQkuY3RsX29mZnMgPSAweDMwNCwNCj4gPiArCQkucHdyX3N0
YV9vZmZzID0gMHgxNzQsDQo+ID4gKwkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MTc4LA0KPiA+ICsJ
CS5zcmFtX3Bkbl9iaXRzID0gQklUKDgpLA0KPiA+ICsJCS5zcmFtX3Bkbl9hY2tfYml0cyA9IEJJ
VCgxMiksDQo+ID4gKwkJLmJwX2luZnJhY2ZnID0gew0KPiA+ICsJCQlCVVNfUFJPVF9XUihNVDgx
ODhfVE9QX0FYSV9QUk9UX0VOX01GRzFfU1RFUDEsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9B
WElfUFJPVF9FTl9TRVQsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9DTFIs
DQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9TVEEpLA0KPiA+ICsJCQlCVVNf
UFJPVF9XUihNVDgxODhfVE9QX0FYSV9QUk9UX0VOXzJfTUZHMV9TVEVQMg0KPiA+ICwNCj4gPiAr
CQkJCSAgICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOXzJfU0VULA0KPiA+ICsJCQkJICAgIE1UODE4
OF9UT1BfQVhJX1BST1RfRU5fMl9DTFIsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJP
VF9FTl8yX1NUQSksDQo+ID4gKwkJCUJVU19QUk9UX1dSKE1UODE4OF9UT1BfQVhJX1BST1RfRU5f
MV9NRkcxX1NURVAzDQo+ID4gLA0KPiA+ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5f
MV9TRVQsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl8xX0NMUiwNCj4gPiAr
CQkJCSAgICBNVDgxODhfVE9QX0FYSV9QUk9UX0VOXzFfU1RBKSwNCj4gPiArCQkJQlVTX1BST1Rf
V1IoTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl8yX01GRzFfU1RFUDQNCj4gPiAsDQo+ID4gKwkJCQkg
ICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl8yX1NFVCwNCj4gPiArCQkJCSAgICBNVDgxODhfVE9Q
X0FYSV9QUk9UX0VOXzJfQ0xSLA0KPiA+ICsJCQkJICAgIE1UODE4OF9UT1BfQVhJX1BST1RfRU5f
Ml9TVEEpLA0KPiA+ICsJCQlCVVNfUFJPVF9XUihNVDgxODhfVE9QX0FYSV9QUk9UX0VOX01GRzFf
U1RFUDUsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9TRVQsDQo+ID4gKwkJ
CQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9DTFIsDQo+ID4gKwkJCQkgICAgTVQ4MTg4X1RP
UF9BWElfUFJPVF9FTl9TVEEpLA0KPiA+ICsJCQlCVVNfUFJPVF9XUihNVDgxODhfVE9QX0FYSV9Q
Uk9UX0VOX1NVQl9JTkZSQV9WRA0KPiA+IE5SX01GRzFfU1RFUDYsDQo+ID4gKwkJCQkgICAgTVQ4
MTg4X1RPUF9BWElfUFJPVF9FTl9TVUJfSU5GUkFfVkQNCj4gPiBOUl9TRVQsDQo+ID4gKwkJCQkg
ICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9TVUJfSU5GUkFfVkQNCj4gPiBOUl9DTFIsDQo+ID4g
KwkJCQkgICAgTVQ4MTg4X1RPUF9BWElfUFJPVF9FTl9TVUJfSU5GUkFfVkQNCj4gPiBOUl9TVEEp
LA0KPiA+ICsJCX0sDQo+ID4gKwkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGLA0K
PiANCj4gUGxlYXNlIGFkZCBNVEtfU0NQRF9ET01BSU5fU1VQUExZIGNhcCB0byBNRkcxIGFzIHdl
bGwuDQo+IEZvciBtb3JlIGluZm9ybWF0aW9uLCBwbGVhc2UgbG9vayBhdDoNCj4gMTNiZGUxNjlj
NmZlICgic29jOiBtZWRpYXRlazogbXRrLXBtLWRvbWFpbnM6IEFsbG93IHByb2JpbmcgdnJlZw0K
PiBzdXBwbHkgb24gdHdvIE1GR3MiKQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpU
aGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCg0KQWNjcm9kaW5nIHRvIC9zeXMva2VybmVs
L2RlYnVnL3BtX2dlbnBkL3BtX2dlbnBkX3N1bW1hcnksIG1mZzAgaXMgdGhlDQpwYXJlbnQgb2Yg
bWZnMSBhbmQgbWZnMSBpcyB0aGUgcGFyZW50IG9mIG1mZzIsIG1mZzMgYW5kIG1mZzQuDQpCZWZv
cmUgdGhlIGRldmljZXMgcG93ZXIgb24gbWZnMiwgbWZnMyBhbmQgbWZnNCwgc3lzdGVtIHdpbGwg
cG93ZXIgb24NCm1mZzEgZmlyc3QuIEFsc28gYmVmb3JlIHRoZSBkZXZpY2VzIHBvd2VyIG9uIG1m
ZzEsIHN5c3RlbSB3aWxsIHBvd2VyIG9uDQptZmcwIGZpcnN0Lg0KQmVjYXVzZSBtZmcwIGlzIHRo
ZSByb290IG9mIG1mZzEsIG1mZzIsIG1mZzMgYW5kIG1mZzQgYW5kDQpNVEtfU0NQRF9ET01BSU5f
U1VQUExZIGlzIGNvbmZpZ3VyZWQgb24gbWZnMCwgc28gTVRLX1NDUERfRE9NQUlOX1NVUFBMWQ0K
aXMgYWxzbyBhcHBsaWVkIG9uIG1mZzEsIG1mZzIsIG1mZzMgYW5kIG1mZzQuDQoNClRoYW5rcywN
CkJlc3QgUmVnYXJkcywNCkdhcm1pbg0K
