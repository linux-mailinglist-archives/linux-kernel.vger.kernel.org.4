Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5366B82A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAPH1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAPH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:27:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F16CC10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:27:48 -0800 (PST)
X-UUID: 43116c82956f11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iVSb7qI+h0DXVUDVDn5DzJtzTzwM3+bWYDGf7hqo/AQ=;
        b=YY/xXDNCFZGShZmgA7vEV8fvGRbzPUYqaFWGpSq18MW5o7BYnwGs6lev5JufVa34nu+f+VANrKC6IAKLpNZ4F3r3s1Ol2ONdv6JLWYCQ8tmbVjJZxnbsDurY+qj7INxIZZVajCZWfcbJdpXm/qixzw9vg6g6aS/3fNOMS8rCnEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:b83b4a7b-9ebe-4108-9d1a-07c6dbd03587,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:b83b4a7b-9ebe-4108-9d1a-07c6dbd03587,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:dc36c254-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230116152742P6ZX7WML,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 43116c82956f11ed945fc101203acc17-20230116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1936681371; Mon, 16 Jan 2023 15:27:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 15:27:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 15:27:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hifzYC0lwK1mSiIaxVreO8oGlHDJ2DlAJGm/UT9w5sd6Sulttf3xMMQpv76bdVWSJE6EIx8BQnu+FXMRXKK3kk6CQqoyrsbiCcEQtTCqbzE2dG/E9LW1mUwX+XaXRQEUqwF/x82SzFyuiBAhdEtdDFDEsvZIBZkmqOZBfuuVFA/Li/uRyqaf5I/ikThTyZbavrTbxPIe3N71Aw8SPr+8Jb3j+/Xb4q7Mb3aTX6i0x0Ee/AqvcQw92XYctHqsX5Rt2ywCHmiOmntU1P7Hrq9oTxN9WbBGf09X20/8Vm2nsiJE84iiAuJMebshURrqP2kUOLvJpdypKbkOsXSTHAmX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVSb7qI+h0DXVUDVDn5DzJtzTzwM3+bWYDGf7hqo/AQ=;
 b=BYChYXW0aKzi1RObRs+kq3XhdwFgKE/fGFRXTkH0Xv8AXwOctoSKXM0TMr85StDp6ydZzfInzFI+oCO7kg5fJK77ue8bVvwZqFVyjIeblAtOkPwFP/SUSmoR7TH7m22Cky6HpC0Y0nLazHL7wHjCCRqo5QVS1p2Lzg2+zG5HfFQGsxny6ITgU8wmjI1at/yTZBcOsoie52gG018ScaW3E8KRpIqASY4ucSV6SG3zpDSHYEUNCZa9CWKAXYYF+xtmTS/gP8mNFNgVKnkDxsrMBaLmpc2PKIDbW+E3UvZDNbsN2TRtoLGecHSeFb+KDoSVsC+6y17uvtEcfdtflOk9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVSb7qI+h0DXVUDVDn5DzJtzTzwM3+bWYDGf7hqo/AQ=;
 b=TGVpTGmu8uGmeBMSdbGob2Dh1s+++S9USdsK7qKO3EyKj+M4OeEf3+oa9+/D3LvGk0PV45UUX29J8wtvEI00lXrRb364NPdeaPseztqJQLhgZ9sK3sNaV8VwVsrO7Fljt27Y2kHPMpOH9sp5qYRjNQs3Q8DmSeNz405TyxvDV2A=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5234.apcprd03.prod.outlook.com (2603:1096:820:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 07:27:38 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:27:38 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHZIEA44YFL/mrrbEuqD9Ku1qRfkq6ctaeAgAQB3IA=
Date:   Mon, 16 Jan 2023 07:27:38 +0000
Message-ID: <731a1382b969269ba0a482b766ac4dfb6fdc115d.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <20230104132646.7100-3-chunfeng.yun@mediatek.com> <Y8Gf2xxq7iaV/+ax@matsya>
In-Reply-To: <Y8Gf2xxq7iaV/+ax@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR0302MB5234:EE_
x-ms-office365-filtering-correlation-id: c6abb26b-589c-4d7b-f1b8-08daf7932569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWcRdHPAr8oxvhRf1sIlwnCHvk7WcWXyFrlbvgQR8YguGUFctPA+oJHuXywFxd7bBy/7P51HBAfFu9j6qS6Rjd27eK/ivA0L3tcGhFhhITx9Og7IypdISrafL5OfMQfMr8n/f9iF8oBPEDdHGVcvTe2B04F0FsZE1Qhvozi6lxbjBodQT/QMLtvLaCigLnjUZATJwfcER85nOEOwOwD19yFe3oUbw8Mfkxyr2oy5BRwyE3Cp1LeugicWfyBO6XRQQKjPAnTBL+64jQu6mnmmfvImWAX+xDbrfcjI7nOy/+DooPDlsn3QQRYdLLEAK2ZvtrlvbiXf/rmOkfd1f69Zlh9mjH9C6G6N1OR7MUuGmY2i7K3yh3yqAmXlX6+VlnHs5M2UXTogJdmnRhtINUj1CWd3xlnWfYCBxABSYdaRsZ682p+fQPYgKLNxaV75oxiwagR7mG5KU7N2t+6dPWs6jN1N3/WDHuR+HGeukcOpIcEHSnorYG9v6cr5l84vdYZRZeCC7jdW2Qn3xfqxhVpx90OJcIIctLx4xQI0Rci7tucNfrtk7uSDYY4Yd4XMLxqM7hWXVDvnWTyW0zH/a0HawuEznk8YKayuOkCi0WEYNufMhVFj1TCDANo/Nc6WTodUUAszpi9ATFvEm3JFZUZFdR6jTsrBihQ/xXLtwKQk+hVRHG34c9aNQGXyJrZt8Kkby9foDrGePaTN4rMiEgWazTq/vNJ2HIZVrv35cxvJNlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(8936002)(76116006)(86362001)(66446008)(6916009)(64756008)(66476007)(66946007)(83380400001)(8676002)(4326008)(38070700005)(122000001)(36756003)(38100700002)(85182001)(6486002)(5660300002)(478600001)(66556008)(7416002)(41300700001)(2906002)(54906003)(6512007)(6506007)(53546011)(26005)(186003)(71200400001)(316002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVNNWk5SaXI4OTBaNGpBUHZsa0xFN3htUW16Y1VycVFzaGhLSkFFQm1wdG9D?=
 =?utf-8?B?YnlYeThIaEhldDJPd0xpaGErSnRYMTNJVnFiQmxmZ3ZmaFU2WmhiSDVMdERS?=
 =?utf-8?B?T01hVDJ4b3Uvblp3eTl6V0Era2l0aVB0VDcvUUIzODBHTzhxT1NzZlFXNDZm?=
 =?utf-8?B?QkxRb0RUTmo1NlpQWXdGUm9DQXVBUG5OWTk4VTdMK280VjV4aUpBYmdZQi91?=
 =?utf-8?B?NU4xbXJWelcvdmFBZ0FWdkg2aGtHa2FqNzhRc0JxSXFwSm9FY3pXOGVTTEtO?=
 =?utf-8?B?aXpQVFB1NGdvaW9rQS9YaEFiUmlOdkhtUC9pUUdtWG1raTFhOW1oWktkSnFw?=
 =?utf-8?B?UytOQ29yQnlPbWhPVGgrcTJDY0gzSjJMZ2E0eUQ1c2RsRk9wdE9IMExYK0E5?=
 =?utf-8?B?QzhiY1YwUkkxeTEweTJUU3I1N2dacHBmOFByM3RYSFBQNWJFYjZuZTQxMnF0?=
 =?utf-8?B?WTNhclk4TERiR1lndldJK2ovTHl6aktTZ21ubVMweSszS2RmcTBwY2ZndExB?=
 =?utf-8?B?Tjc5VEVOM3daNE1ad3BIVm55RGlZTHN4VGdWVkloZ1NjM0dLME5ET1YyOERN?=
 =?utf-8?B?RkI2STdkYUVqSGZXeWMvc1RscVcyK3BseVBSMEticlAzV1RTVnR0LzN3VDZm?=
 =?utf-8?B?b0pKSTdxWU5sOUsxdEk3eVBlT2hZR3UvZWZnOEVDZnA1UW5QYXJWc09ab0xh?=
 =?utf-8?B?Z1Ixc2tlWlNVRnNkZ0owRlVJdnEyUjNpc21hdGRzUmduNzRuVXcxa1F0UmNX?=
 =?utf-8?B?aGVwczEwL0hCZkowSzRQR3FjVnNOR2lpUk9ZMUd0WnhKb2tLNGRuNWFYSkRy?=
 =?utf-8?B?M0hveTRrZ2k3T0c0RmQ2WnF0NzV1aUozNlZvb09hSnlIZ29Jbkl5ZXpncXFP?=
 =?utf-8?B?eWtOYkQzYkh3eWlFWC9MUTFwcWNpcWdoMFo5R3JYS1RKU2FCMWwzR3E2eTlR?=
 =?utf-8?B?dVB3ekxwUy9pLzlndEU2SGZOZytxM1FzanYwSkxXbVZUa0t0MWw0dXRLYTdF?=
 =?utf-8?B?Zjd2T3ZRRk5NNFljQ2lRUmo1ZjRhaWZJRlNhSXd2R2svb3hxVmwxcWdqczBm?=
 =?utf-8?B?V1Q3aUdtY1hZK1N3YndwUzdBZ1N6RTRvb05DZk5mQ011WGphUXZza3JZTWUy?=
 =?utf-8?B?OEU4WEt5bFN3QU9nb0VoQzhXS1N5cjRyOXRPYlkrQ2Ezd01uNDBSVENVSlNZ?=
 =?utf-8?B?Ry95c2dEY1VOTkxTa3N2NEh3K1FPNFBzM0dMVkRRbVdmdUdCVGl1U0VvK0Ni?=
 =?utf-8?B?T0dkWmNLZFRId2pQa1F3ejBGZHFwbmplY01hWitEbFJqRVZWSVFxL2FraW1l?=
 =?utf-8?B?UEZmMitRTTdUOWFWcGpWWlJOZ3NxTVBaY25CK2h2TWpIY0J0WXNsS3pLbnIx?=
 =?utf-8?B?U0E3b1VVeWR3aW5qRCtubm9kRytVQ0VKdmVmY1BnWFJtc091SWErUlBYZ0xk?=
 =?utf-8?B?YTdrNWxtZnAxditmcFd6eFV4L3RUMUtoelVPaHl6TXQrNGdINUs1SGtrN2Jp?=
 =?utf-8?B?Mm1VOXk3RzRtYnd3a0J1RDljTXFFSWRDUFpWUlVyTmhoM1dWaDdDTFhtcjNY?=
 =?utf-8?B?R2Q1eHpWUFdObG51TUszbEZ3czRwc0crY2RLQitUZnpkd0wwa0FNbjdWNVpL?=
 =?utf-8?B?V2w1UDlCM0k1dzNycEFsM2dlM0x5b1hSYVk2YnZYcVJoWEI5L2dQa1daelZx?=
 =?utf-8?B?Zkp3Z1pXTDQ0QTlkSjBIRmptMTViU3J6NlVYek0rdHQ5aVMycUlmQjVkalZ2?=
 =?utf-8?B?Y2h1S28xdGZzR0NtamoxZDdwWldKTDVVTTJ0UzVWTGhvcFVwYXRreXlnblhH?=
 =?utf-8?B?Yk9Qdnp2cHY4Q0t6MmZUMWFCS09KRVd3NVA1eUp2N2RWYXRubEk5YlE1R0FV?=
 =?utf-8?B?ZXdNWWt4VDROMjJPTnh3cjJzbzQybzYyemh1WXg1QU5udjFaZ2VSYWZ2VmRL?=
 =?utf-8?B?UHMzNDZYUkxWbU1QbldTODllbCsyNnF1L0F5TXp5NEhyUUcwVTBDU2poQ2RX?=
 =?utf-8?B?VWpKSEFDZmIweU0rTEs5LzRYWmw3bkxQdWQ0bzlsUm1Ta2hvY00yY0FjYlRt?=
 =?utf-8?B?bWJqdmk4UVFHL3BIeC95T1R5NnAxMGVVSHM2ODM1anRaSFhsaU5TMmF0Tk9h?=
 =?utf-8?B?MVlGQzQrTGxqWFZiSE8ydGh2cDNhNTBGZkJQQjhaUjJqNVc0eTRxRzlIUWMz?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4991B7BC78A054E8526AD276E668265@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6abb26b-589c-4d7b-f1b8-08daf7932569
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:27:38.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdMZrCSe7OgaIXb1qTJMad1vaYqahq4J/gtP063soPdA90sy3dJTp+JBNaqE828LFIxhphTIdqwmr/dThKLnpKei9+isM3uCjT9ACFIviaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5234
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDIzOjQ1ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAwNC0wMS0yMywgMjE6MjYsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBUaGVzZSBkZWJ1Z2Zz
IGZpbGVzIGFyZSBtYWlubHkgdXNlZCB0byBtYWtlIGV5ZSBkaWFncmFtIHRlc3QNCj4gPiBlYXNp
ZXIsDQo+ID4gZXNwZWNpYWxseSBoZWxwZnVsIHRvIGRvIEhRQSB0ZXN0IGZvciBhIG5ldyBJQyB3
aXRob3V0IGVmdXNlDQo+ID4gZW5hYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjY6IG5v
IGNoYW5nZXMNCj4gPiANCj4gPiB2NTogdXNpbmcgY29tbW9uIGRlYnVnZnMgY29uZmlnIENPTkZJ
R19ERUJVR19GUw0KPiA+IA0KPiA+IHY0OiBmaXggYnVpbGQgd2FybmluZyBvZiBzb21ldGltZXMg
dW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiA+IA0KPiA+IHYzOiBmaXggdHlwbyBvZiAiZGVidWdm
cyIgc3VnZ2VzdGVkIGJ5IEFuZ2Vsb0dpb2FjY2hpbm8NCj4gPiANCj4gPiB2MjogYWRkIENPTkZJ
R19QSFlfTVRLX1RQSFlfREVCVUdGUyBzdWdnZXN0ZWQgYnkgQW5nZWxvR2lvYWNjaGlubw0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyB8IDQwNQ0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQwNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRl
ay9waHktbXRrLXRwaHkuYw0KPiA+IGluZGV4IGU5MDZhODI3OTFiZC4uOTIzZTVlZTExOWYzIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4g
KysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiBAQCAtNyw2ICs3
LDcgQEANCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pb3Bv
bGwuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiBAQCAtMjY0LDYg
KzI2NSw4IEBADQo+ID4gIA0KPiA+ICAjZGVmaW5lIFRQSFlfQ0xLU19DTlQJMg0KPiA+ICANCj4g
PiArI2RlZmluZSBVU0VSX0JVRl9MRU4oY291bnQpIG1pbl90KHNpemVfdCwgOCwgKGNvdW50KSkN
Cj4gPiArDQo+ID4gIGVudW0gbXRrX3BoeV92ZXJzaW9uIHsNCj4gPiAgCU1US19QSFlfVjEgPSAx
LA0KPiA+ICAJTVRLX1BIWV9WMiwNCj4gPiBAQCAtMzEwLDYgKzMxMyw3IEBAIHN0cnVjdCBtdGtf
cGh5X2luc3RhbmNlIHsNCj4gPiAgCXN0cnVjdCBjbGtfYnVsa19kYXRhIGNsa3NbVFBIWV9DTEtT
X0NOVF07DQo+ID4gIAl1MzIgaW5kZXg7DQo+ID4gIAl1MzIgdHlwZTsNCj4gPiArCXN0cnVjdCBk
ZW50cnkgKmRiZ2ZzOw0KPiA+ICAJc3RydWN0IHJlZ21hcCAqdHlwZV9zdzsNCj4gPiAgCXUzMiB0
eXBlX3N3X3JlZzsNCj4gPiAgCXUzMiB0eXBlX3N3X2luZGV4Ow0KPiA+IEBAIC0zMzIsMTAgKzMz
NiwzOTEgQEAgc3RydWN0IG10a190cGh5IHsNCj4gPiAgCWNvbnN0IHN0cnVjdCBtdGtfcGh5X3Bk
YXRhICpwZGF0YTsNCj4gPiAgCXN0cnVjdCBtdGtfcGh5X2luc3RhbmNlICoqcGh5czsNCj4gPiAg
CWludCBucGh5czsNCj4gPiArCXN0cnVjdCBkZW50cnkgKmRiZ2ZzX3Jvb3Q7DQo+ID4gIAlpbnQg
c3JjX3JlZl9jbGs7IC8qIE1IWiwgcmVmZXJlbmNlIGNsb2NrIGZvciBzbGV3IHJhdGUNCj4gPiBj
YWxpYnJhdGUgKi8NCj4gPiAgCWludCBzcmNfY29lZjsgLyogY29lZmZpY2llbnQgZm9yIHNsZXcg
cmF0ZSBjYWxpYnJhdGUgKi8NCj4gPiAgfTsNCj4gPiAgDQo+ID4gKyNpZiBJU19FTkFCTEVEKENP
TkZJR19ERUJVR19GUykNCj4gPiArDQo+ID4gDQo+ID4gPHNraXA+DQo+ID4gDQo+ID4gKw0KPiA+
ICtERUZJTkVfU0hPV19BVFRSSUJVVEUodHBoeV90eXBlKTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2
b2lkIHRwaHlfZGVidWdmc19pbml0KHN0cnVjdCBtdGtfdHBoeSAqdHBoeSwgc3RydWN0DQo+ID4g
bXRrX3BoeV9pbnN0YW5jZSAqaW5zdCkNCj4gPiArew0KPiA+ICsJY2hhciBuYW1lWzE2XTsNCj4g
PiArDQo+ID4gKwlzbnByaW50ZihuYW1lLCBzaXplb2YobmFtZSkgLSAxLCAicGh5LiVkIiwgaW5z
dC0+aW5kZXgpOw0KPiANCj4gSSB3b3VvbGQgc3VnZ2VzdCBkcml2ZXIgbmFtZS8gZGV2aWNlIG5h
bWUgcmF0aGVyIHRoYW4gcGh5LmZvby4uLg0KPiBhZ2Fpbg0KPiBmb2xrcyBuZWVkcyB0byBzZWUg
d2hhdCBpcyBmb28NCk9rLCBJJ2xsIGNoYW5nZSBpdCwgdGhhbmtzIGEgbG90DQoNCj4gDQo+IDxz
a2lwPg0KPiA+IA0KPiA+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdHBoeV9k
cml2ZXIgPSB7DQo+ID4gIAkucHJvYmUJCT0gbXRrX3RwaHlfcHJvYmUsDQo+ID4gKwkucmVtb3Zl
CQk9IG10a190cGh5X3JlbW92ZSwNCj4gPiAgCS5kcml2ZXIJCT0gew0KPiA+ICAJCS5uYW1lCT0g
Im10ay10cGh5IiwNCj4gPiAgCQkub2ZfbWF0Y2hfdGFibGUgPSBtdGtfdHBoeV9pZF90YWJsZSwN
Cj4gPiAtLSANCj4gPiAyLjE4LjANCj4gDQo+IA0K
