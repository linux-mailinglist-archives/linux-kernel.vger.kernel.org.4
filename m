Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7232E722266
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjFEJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFEJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:42:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D96BD;
        Mon,  5 Jun 2023 02:42:12 -0700 (PDT)
X-UUID: 3b83caf8038511eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K2Rc6YgWYKIgvknjLBNr4S76q02vrojT0+YnS5HcxiY=;
        b=qmZhBw/7TEZay1QeNolTjc1lisyDW9rNU5NnMzZys0hfqXjbRxPdWu+z+Fvr9O0xhU5+AxXs7aLMZYeTXodOE2qt9PH+ok21vFoqQau8m0qcR0jZmDk0tyxD1siJuqX3VVtuyERKqkFSs+e5Gb2G5NHvfyAA1Gqks7L6kz0vjiI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:16726ee0-bb56-418b-96a1-f67c3acb4f3a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:7c500f6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 3b83caf8038511eeb20a276fd37b9834-20230605
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 967266374; Mon, 05 Jun 2023 17:42:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 17:42:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 17:42:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG9lEEseqrYizKNl6+V3AOee1chcCL9q/O7sEVw4eFWBWo80THopTHxUGjcPghsDDPLZ7X56KPw2MExE68AjTUrsWC77aZHaiN1PqJRMkFkimakl/AhY4yyudvL191nbRfOYzLM6ZgNjVwy63a2ki0BaIT2zwDUaybjhSGw1Jg7yKHJh4Sb9y/D3I0LE6sT/LF1V4sUMSb8SoymFAPxTO2zZPLYahvDIVlHrr+sHdaGmlwd+/gKW18YjZtOVcBKetwd5fVuxrS+xLr6VMXU+Q0YKYYDYkAz6nbit/nAw3LswKshcbmhBKwcrudD7I31JPpSg4H2EL8UQUt7fDlIpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2Rc6YgWYKIgvknjLBNr4S76q02vrojT0+YnS5HcxiY=;
 b=aB9EADfiRoI0Y/LC65pE9sCR0cPxreFyKFP1rHC7tr2hb3qxS7NrC+swWx1p5y3TxL3pyhwFk4uTu583V3tY2+/kbetjCHnKz2jXNChUOlYngJGAv9TP5fvqoYhf+OEqa82vYyFMPrIajNjtgqGUqKUKZzIRiqgdVAW8ycLlsbjKm4d51g0+ihV8oFRYeCOdt3G6LhlxjSw6VwFmkknut/davH8htjwyMlrWpoE+VEl2zxOyK0rAGrWVpGN2lOXZxjnbbh/raHNaWgGjDqMI2LOAdUT1B6U9lEg415Uo2QWVlrEbpzSReS5hnlRjaIiw1EOBXZ8srswter4JUakH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2Rc6YgWYKIgvknjLBNr4S76q02vrojT0+YnS5HcxiY=;
 b=IDxgnpbIQfXqYn6eGziZa6A/UXXtgAcNYrRLqeRzZBFyFjaWtfxZaaBkKYKY6xDRc2acD0ypBdOY50rIZuHbZPsuklC9GUURwgp1Ah5Og6jsgzTbUpmJaIVOoT8nPCUfbsRVCMvS/O8GjqOOhF5SeQMqgQAaE3USKhRcplhaRnk=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SI2PR03MB5529.apcprd03.prod.outlook.com (2603:1096:4:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:42:02 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:42:02 +0000
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
Subject: Re: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl3MhuZQwxAGKvU2Q3XN2G99nQK975gIAgAAPDQA=
Date:   Mon, 5 Jun 2023 09:42:02 +0000
Message-ID: <7b4be09c2d5cae3c8057ad00eeb6f6d65985651d.camel@mediatek.com>
References: <20230605060107.22044-1-wenbin.mei@mediatek.com>
         <47ee4c8b-dedf-d69a-dceb-dcaa34ddd0e1@collabora.com>
In-Reply-To: <47ee4c8b-dedf-d69a-dceb-dcaa34ddd0e1@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SI2PR03MB5529:EE_
x-ms-office365-filtering-correlation-id: f64f476c-78a7-4111-6788-08db65a91dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrBqziM/eyN52yj8i29ELqhh1g0lINQL+OgreJeP9bzLtBJMxgCQ1DFTnfnKy/ceUDgobUdXDBvWpLz+KdfIoqiE/Wjk2Aa6VfHToyd/KKtOg/zDu7R4i4sICnAHLAkp6qKmOzpU1MsLieA2fahjw4Oz6cC0pVlw6FmFld9Ad8teF2sAkABef1DKcoawLIKLSpKr+dcvf1LkzUF6gvM+2me3waSd0VDBArftbzd8nDGa9AiSwUfys34VYUPi6OPqR0BwrVWduA3fVNVPKB05+LOQz721iaC0p+AqJ7XwXIfJULEBJGYcbqhMAIl2gRlrYOKmyGIIT+zL6IwnMgOQXElXukDDGf5bacS1hoQWwCNlB3MxgtLLYrWk1NEJW6gZjjs9x7kRk7uuLj1y+H+72I4fzUAmivZF3RQJhMwlct7/XfWKR0UZhHzIG7TgzRayEvzShoDo9trmmjvNjgcdWheUz/HdM2r2Jg1duj4KvpV6AjRcoAJRYPrX/LtyFDWE4f2YqNOoYMGhkLGw9JNQvvsbuJbxk9Ly1XQZwOIxV8xeqLm33dwB6/pzpbgRt1aVdDji4oQIqrURaLUAPqrSNNmrTXoO6jr0TVzjcTroXTtMiZpOmWplvCYYL9yWrwrB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(2616005)(26005)(6512007)(6506007)(38100700002)(83380400001)(41300700001)(6486002)(186003)(71200400001)(478600001)(54906003)(110136005)(4326008)(122000001)(66446008)(66476007)(66556008)(64756008)(76116006)(316002)(66946007)(7416002)(8936002)(8676002)(5660300002)(2906002)(86362001)(38070700005)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjEwcGZzRk4xL1U5NGpjZWhrRzhWaEQrQ3AyWVgxMzBVak9SR2dKeTU1N0dC?=
 =?utf-8?B?eTlpOHhkN1VPYVpmOFc0NlJRWURFNktDNzVCekZQamxCbUJ6TCtaNGpSU0d3?=
 =?utf-8?B?ZFlTZXZkRmFiR0JpQmJEUDMzak81aGF5V2RaKzh2QVpnUVNDOC8rRnBFQVVH?=
 =?utf-8?B?YTdQaVI1RjRvYWdUVDljWmZqbmM4QURoYmFYREVWOTFUY0RyS2kvdjZtZ05v?=
 =?utf-8?B?dFBhV0VMdHlWbE8xSnNwMVVPSVRFZUhHTG5OVUM2aGxtOXRTWDNwZkw4MVlr?=
 =?utf-8?B?R1pkSWJWcjBjYzZLbi9nTGpQNHVWaVpNd3pNMmJSYUZJMmtuTkNOdktNOTB5?=
 =?utf-8?B?cTM4RTNJTnVGUWtNYWZ1cGp5ei9UcTNIZ0RWVUVPWEQ2LzdTT0FRSXJvcTI3?=
 =?utf-8?B?MVNDSml2b2RQdXU4Yk1iY3ZHbHFVdURWNWRHdXRMZ0p3Q0thanpjbHNBVHgv?=
 =?utf-8?B?bDZFMEJaZ0wzY0w2TmtqQ0UwcE5qdyt4RDVXNm5SWkRXbGw1UlRDMXFuUjhs?=
 =?utf-8?B?bng3ZysyN3YzUlZ2c2hrNGt0ZU9hT05kNUFJRmNqL0w2MnVxOVZrTkFnaUFI?=
 =?utf-8?B?T3dwRzBtU0lFVXlJOHd3ckZTRkpUY3ZGTFY4aThneStVOHB1TTRlcitMTk9l?=
 =?utf-8?B?bm0yVHVCSnpHNisveTBUc3FEV3VXbnhDeEEzVTB3bDA0c2xDSnJaYU9rVWtz?=
 =?utf-8?B?SkJsZjBlUG85bWpTYk94Z21aZk9TM0RPTnBSOWQrc1dGZkFYVGlGVGE2bmZB?=
 =?utf-8?B?YUFaOEdoUzRZbHRCL3A3NndiVTV4UUpXakNRY28yeC9QVjhpRVZPak10WDRJ?=
 =?utf-8?B?cVpCazEvZ0QrTlNyMGNTcS9yMkdXTnVQeTVXUDA3RkR3SjNLbURqMDBYQXln?=
 =?utf-8?B?OU5GTmFsbnF0RkFuUGpGMHBkazBoMlRFMmNnVkNjdk5MdUUrTlpLdU1WYlRM?=
 =?utf-8?B?VjVrb0lUSU9welBjSWxpN2RQZjIvbmhBcmZSV2VaTW9BL1JQeTQrL3JzbjUv?=
 =?utf-8?B?UStPOWlPd2duR0krOXM3Q2VndEZiMVVGZGZ6b0lqOGNlNXpLUnJzOGVnYVFN?=
 =?utf-8?B?cFBjU2NFc3QxMmhoeDE2VHFaNWxlSmhoRXhEVkZpc2YvRVM4c2Z5NmtDdGFs?=
 =?utf-8?B?QjBHZzZFNld2TExueHVEUkh5SElMb1VNS1h0b2FlWXpGUStOa1FTWTRWN0I4?=
 =?utf-8?B?T2dYYWpwZVZyc3cxMWtJYzkxQkVhTFZOVDQ1OWVJSnc5cmdRTFJDc3BqUlBs?=
 =?utf-8?B?V2dDcGx2ZHpYMzN2K01sTEhwbjhSdTBnbDcvTmhBRDVTY0M3VEZ1Mi9lUFZp?=
 =?utf-8?B?MkFsYmJmN3E2NkV5SHVkRkZtUldlYUZsUzFGbC9nYnBRa0VUclpBdXYzdDBx?=
 =?utf-8?B?TzM0a1BRSXZJTUQ4SGdKMWZUVHZuc25pL21kamMrcjBoOEIrSXYrM0RsaDVC?=
 =?utf-8?B?NHBPUSsrZDRLNDM5WnViYUVNcFp5c1M2ZFhZWVZnMlZxaU0zQjN5c0xCSXVW?=
 =?utf-8?B?cVZBbytYTFFhcjRDdDloYlI1WFQxVDFBZGs5dzhVTjMxMXYwNEkrK25QMXBt?=
 =?utf-8?B?ek00VVBvVTJiNnViYXNhemE5ZWc3a0dGWGVJRGh0bW5ta3lGRFAzODVxcTZM?=
 =?utf-8?B?ZDlvbitTKzUxQldaR0FwdldTVHdxdktkQkwydUhyRk5YL21pSVVFTGZ5S1Mx?=
 =?utf-8?B?Zjc3a1R5K2FtdGY1cHdjWXpLNEhYY0dEZ3B1SWlNeXpVK1VIU1ZQdWxCRElm?=
 =?utf-8?B?YWRKWkREaUZpN29mMEk3a1lQbnljbVRmbWlWWVRmUFdadGdsWlNUei90Q2k0?=
 =?utf-8?B?UHlsOHhhNDlERVdCc09zSHBXUG0ydWd0QWtQYndZWU9wb0wycU9DV1p0dGpV?=
 =?utf-8?B?ZC91dkx3Q09OS29GNE40ejJVWUFsbjFsVVduMCtpSmJIWXhMZ2VNWmpWNkdG?=
 =?utf-8?B?NFMvbDl0QWNId1JNbzBmYkpMWEpQQlNUNFNVTTFTVUp2ZTJrQ05DYWlha08z?=
 =?utf-8?B?NG56RER2TFBtQ3FBRktIeTVwN1BsVThvNll1NFIyVWRTajFjVUI2eFlKTTZF?=
 =?utf-8?B?T3FIREQ0T2krOEFzcDdUMENuN2VGbHRRdGw5Q3JFMG1vMWxnMkZhS3BFVmh6?=
 =?utf-8?B?S0ttSHpqaFpab3VoRkszYURScVJWSjBIR0dudGRXQmdVSTkxMGU3Vzd4VzdV?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1B464AEFCB4C946B896EBDC206B0072@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f476c-78a7-4111-6788-08db65a91dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:42:02.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5cqjkEKZaaEDz5RHlWtwOzww/VguW3FbAPGDKmt5p5Nu/6eY88560gyZn4kfiSi63I36VbQaaNoJOCB5LHIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDEwOjQ4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwNS8wNi8yMyAwODowMSwgV2VuYmluIE1l
aSBoYSBzY3JpdHRvOg0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGlu
ZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gcGVyaW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NU
QVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNsayBh
cyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZSBoY2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdl
dCB0aGUgYWN0dWFsIHRpbWUuDQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29y
cmVzcG9uZHMgdG8gMTUwdXMgZm9yIE1lZGlhVGVrDQo+IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVh
c2UgaXQgdG8gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDIuMzV1cywgd2hpY2ggY2FuIGltcHJv
dmUNCj4gdGhlDQo+ID4gcGVyZm9ybWFuY2Ugb2Ygc29tZSBlTU1DIGRldmljZXMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+
IA0KPiBPSyEgVGhhdCdzIGFsbW9zdCBnb29kIG5vdy4gVGhlcmUncyBvbmx5IG9uZSBjb25zaWRl
cmF0aW9uIGhlcmU6IGlmDQo+IE1lZGlhVGVrDQo+IFNvQ3MgKnJlcXVpcmUqIG1zZGNfaGNsayB0
byBjYWxjdWxhdGUgdGhlIENJVCB0aW1lLCB0aGlzIG1lYW5zIHRoYXQNCj4gdGhpcyBjbG9jaw0K
PiBpcyBjcml0aWNhbCBmb3IgQ1FIQ0kgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IElmIG1zZGNfaGNs
ayBpcyBub3QgcHJlc2VudCwgQ1FIQ0kgY2Fubm90IHdvcmsgY29ycmVjdGx5Li4uIHNvIHlvdQ0K
PiBkb24ndCBoYXZlDQo+IHRvIGNvdmVyIHRoZSBjYXNlIGluIHdoaWNoIHRoZXJlJ3Mgbm8gbXNk
Y19oY2xrIGNsb2NrOiBpZiB0aGF0J3Mgbm90DQo+IHByZXNlbnQsDQo+IGVpdGhlciBmYWlsIHBy
b2JpbmcsIG9yIGRpc2FibGUgQ1FIQ0kuDQpUaGF0J3MgcmlnaHQsIGkgd2lsbCByZW1vdmUgdGhl
IGVsc2UgY2FzZS4NCg0KQmVnYXJkcywNCldlbmJpbg0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvbW1jL2hvc3QvY3FoY2kuaCAgfCAgMSArDQo+ID4gICBkcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jIHwgNDcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+
ID4gaW5kZXggYmE5Mzg3ZWQ5MGViLi4yOTJiODllYmQ5NzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5o
DQo+ID4gQEAgLTIzLDYgKzIzLDcgQEANCj4gPiAgIC8qIGNhcGFiaWxpdGllcyAqLw0KPiA+ICAg
I2RlZmluZSBDUUhDSV9DQVAweDA0DQo+ID4gICAjZGVmaW5lIENRSENJX0NBUF9DUzB4MTAwMDAw
MDAgLyogQ3J5cHRvIFN1cHBvcnQgKi8NCj4gPiArI2RlZmluZSBDUUhDSV9DQVBfSVRDRk1VTCh4
KSgoKHgpICYgR0VOTUFTSygxNSwgMTIpKSA+PiAxMikNCj4gPiAgIA0KPiA+ICAgLyogY29uZmln
dXJhdGlvbiAqLw0KPiA+ICAgI2RlZmluZSBDUUhDSV9DRkcweDA4DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+
ID4gaW5kZXggZWRhZGUwZTU0YTBjLi5jMjIxZWY4YTY5OTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNk
LmMNCj4gPiBAQCAtNDczLDYgKzQ3Myw3IEBAIHN0cnVjdCBtc2RjX2hvc3Qgew0KPiA+ICAgc3Ry
dWN0IG1zZGNfdHVuZV9wYXJhIGRlZl90dW5lX3BhcmE7IC8qIGRlZmF1bHQgdHVuZSBzZXR0aW5n
ICovDQo+ID4gICBzdHJ1Y3QgbXNkY190dW5lX3BhcmEgc2F2ZWRfdHVuZV9wYXJhOyAvKiB0dW5l
IHJlc3VsdCBvZg0KPiBDTUQyMS9DTUQxOSAqLw0KPiA+ICAgc3RydWN0IGNxaGNpX2hvc3QgKmNx
X2hvc3Q7DQo+ID4gK3UzMiBjcV9zc2MxX3RpbWU7DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZSBtdDI3MDFfY29tcGF0ID0gew0K
PiA+IEBAIC0yNDUwLDkgKzI0NTEsNTAgQEAgc3RhdGljIHZvaWQNCj4gbXNkY19oczQwMF9lbmhh
bmNlZF9zdHJvYmUoc3RydWN0IG1tY19ob3N0ICptbWMsDQo+ID4gICB9DQo+ID4gICB9DQo+ID4g
ICANCj4gPiArc3RhdGljIHZvaWQgbXNkY19jcWVfY2l0X2NhbChzdHJ1Y3QgbXNkY19ob3N0ICpo
b3N0LCB1NjQgdGltZXJfbnMpDQo+IA0KPiBzdGF0aWMgaW50IG1zZGNfY3FlX2NpdF9jYWwoLi4u
LikNCj4gDQo+ID4gK3sNCj4gPiArc3RydWN0IG1tY19ob3N0ICptbWMgPSBtbWNfZnJvbV9wcml2
KGhvc3QpOw0KPiA+ICtzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZh
dGU7DQo+ID4gK3U4IGl0Y2ZtdWw7DQo+ID4gK3UzMiBoY2xrX2ZyZXE7DQo+IA0KPiBoY2xrX2Zy
ZXEgc2hvdWxkIGJlIGB1bnNpZ25lZCBsb25nYCwgYXMgdGhhdCdzIHdoYXQgY2xrX2dldF9yYXRl
KCkNCj4gcmV0dXJucy4NCj4gDQo+ID4gK3U2NCB2YWx1ZTsNCj4gPiArDQo+ID4gKy8qIFNpbmNl
IE1TREMgQ1FFIHVzZXMgbXNkY19oY2xrIGFzIElUQ0ZWQUwsIHNvIGRyaXZlciBzaG91bGQgdXNl
DQo+IGhjbGsNCj4gPiArICogZnJlcXVlbmN5IHRvIGdldCB0aGUgYWN0dWFsIHRpbWUgZm9yIENJ
VC4NCj4gPiArICovDQo+IA0KPiAvKg0KPiAgKiBPbiBNZWRpYVRlayBTb0NzIHRoZSBNU0RDIGNv
bnRyb2xsZXIncyBDUUUgdXNlcyBtc2RjX2hjbGsgYXMNCj4gSVRDRlZBTA0KPiAgKiBzbyB3ZSBt
dWx0aXBseS9kaXZpZGUgdGhlIEhDTEsgZnJlcXVlbmN5IGJ5IElUQ0ZNVUwgdG8gY2FsY3VsYXRl
DQo+IHRoZQ0KPiAgKiBTZW5kIFN0YXR1cyBDb21tYW5kIElkbGUgVGltZXIgKENJVCkgdmFsdWUu
DQo+ICAqLw0KPiBpZiAoIWhvc3QtPmhfY2xrKQ0KPiByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGhj
bGtfZnJlcSA9IGNsa19nZXRfcmF0ZShob3N0LT5oX2Nsayk7DQo+IGl0Y2ZtdWwgPSBDUUhDSV9D
QVBfSVRGQ01VTChjcWhjaV9yZWFkbChjcV9ob3N0LCBDUUhDSV9DQVApKTsNCj4gc3dpdGNoIChp
dGNmbXVsKSB7DQo+IC4uLi4NCj4gfQ0KPiANCj4gPiAraWYgKGhvc3QtPmhfY2xrKSB7DQo+ID4g
K2hjbGtfZnJlcSA9IGNsa19nZXRfcmF0ZShob3N0LT5oX2Nsayk7DQo+ID4gK2l0Y2ZtdWwgPSBD
UUhDSV9DQVBfSVRDRk1VTChjcWhjaV9yZWFkbChjcV9ob3N0LCBDUUhDSV9DQVApKTsNCj4gPiAr
c3dpdGNoIChpdGNmbXVsKSB7DQo+ID4gK2Nhc2UgMHgwOg0KPiA+ICtkb19kaXYoaGNsa19mcmVx
LCAxMDAwKTsNCj4gPiArYnJlYWs7DQo+ID4gK2Nhc2UgMHgxOg0KPiA+ICtkb19kaXYoaGNsa19m
cmVxLCAxMDApOw0KPiA+ICticmVhazsNCj4gPiArY2FzZSAweDI6DQo+ID4gK2RvX2RpdihoY2xr
X2ZyZXEsIDEwKTsNCj4gPiArYnJlYWs7DQo+ID4gK2Nhc2UgMHgzOg0KPiA+ICticmVhazsNCj4g
PiArY2FzZSAweDQ6DQo+ID4gK2hjbGtfZnJlcSA9IGhjbGtfZnJlcSAqIDEwOw0KPiA+ICticmVh
azsNCj4gPiArZGVmYXVsdDoNCj4gPiAraG9zdC0+Y3Ffc3NjMV90aW1lID0gMHg0MDsNCj4gPiAr
cmV0dXJuOw0KPiA+ICt2YWx1ZSA9IGhjbGtfZnJlcSAqIHRpbWVyX25zOw0KPiA+ICtkb19kaXYo
dmFsdWUsIDEwMDAwMDAwMDBVTEwpOw0KPiA+ICtob3N0LT5jcV9zc2MxX3RpbWUgPSB2YWx1ZTsN
Cj4gPiArfSBlbHNlIHsNCj4gPiAraG9zdC0+Y3Ffc3NjMV90aW1lID0gMHg0MDsNCj4gPiArfQ0K
PiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5hYmxlKHN0cnVjdCBt
bWNfaG9zdCAqbW1jKQ0KPiA+ICAgew0KPiA+ICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IG1t
Y19wcml2KG1tYyk7DQo+ID4gK3N0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0ID0gbW1jLT5jcWVf
cHJpdmF0ZTsNCj4gPiAgIA0KPiA+ICAgLyogZW5hYmxlIGNtZHEgaXJxICovDQo+ID4gICB3cml0
ZWwoTVNEQ19JTlRfQ01EUSwgaG9zdC0+YmFzZSArIE1TRENfSU5URU4pOw0KPiA+IEBAIC0yNDYy
LDYgKzI1MDQsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9lbmFibGUoc3RydWN0IG1tY19ob3N0
DQo+ICptbWMpDQo+ID4gICBtc2RjX3NldF9idXN5X3RpbWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAw
MDAwVUxMLCAwKTsNCj4gPiAgIC8qIGRlZmF1bHQgcmVhZCBkYXRhIHRpbWVvdXQgMXMgKi8NCj4g
PiAgIG1zZGNfc2V0X3RpbWVvdXQoaG9zdCwgMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gKw0KPiA+
ICsvKiBTZXQgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciAqLw0KPiA+ICtjcWhj
aV93cml0ZWwoY3FfaG9zdCwgaG9zdC0+Y3Ffc3NjMV90aW1lLCBDUUhDSV9TU0MxKTsNCj4gPiAg
IH0NCj4gPiAgIA0KPiA+ICAgc3RhdGljIHZvaWQgbXNkY19jcWVfZGlzYWJsZShzdHJ1Y3QgbW1j
X2hvc3QgKm1tYywgYm9vbCByZWNvdmVyeSkNCj4gPiBAQCAtMjgwMyw2ICsyODQ4LDggQEAgc3Rh
dGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ICAgLyogY3FoY2kgMTZiaXQgbGVuZ3RoICovDQo+ID4gICAvKiAwIHNpemUsIG1lYW5zIDY1
NTM2IHNvIHdlIGRvbid0IGhhdmUgdG8gLTEgaGVyZSAqLw0KPiA+ICAgbW1jLT5tYXhfc2VnX3Np
emUgPSA2NCAqIDEwMjQ7DQo+ID4gKy8qIFJlZHVjZSBDSVQgdG8gMHg0MCB0aGF0IGNvcnJlc3Bv
bmRzIHRvIDIuMzV1cyAqLw0KPiA+ICttc2RjX2NxZV9jaXRfY2FsKGhvc3QsIDIzNTApOw0KPiAN
Cj4gcmV0ID0gbXNkY19jcWVfY2l0X2NhbCguLi4pDQo+IGlmIChyZXQpDQo+IGdvdG8gcmVsZWFz
ZTsNCj4gDQo+IF5eXl4gZWl0aGVyIGZhaWwgcHJvYmUsIG9yIHVzZSB0aGUgZU1NQy9TRCB3aXRo
b3V0IENRSENJIHN1cHBvcnQuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gICB9
DQo+ID4gICANCj4gPiAgIHJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaG9zdC0+
aXJxLCBtc2RjX2lycSwNCj4gDQo=
