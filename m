Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46D5F27ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 06:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJCEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 00:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJCEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 00:00:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFC18E18
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 21:00:29 -0700 (PDT)
X-UUID: 182c74c7c59f49d788e12f63260d94bc-20221003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zYZ4sRLSTPUaC9kC7FhZUcqk3IruZkgDgFqV4Pw+1+c=;
        b=CBSRmJM30fz6Qqz4oqZ11EbthSkPlZTAWYHsqXSaLFMvtnSEJDQ7Pzxbmc9KewTdM1/4aHaybHflZpvG2InwOjx0wvSvlA3Kg3K4HhUj0C82q/9l+iJoZJC7yDkdzi40flz7jCjzqhiQUqGpLZwKi17Fun+J4Q0TVQuaHP43htg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:db6f2dca-66b2-4764-98b1-952ec726e795,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:86cac207-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 182c74c7c59f49d788e12f63260d94bc-20221003
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1555357512; Mon, 03 Oct 2022 12:00:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 3 Oct 2022 12:00:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 3 Oct 2022 12:00:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiccoOAkpGmrcNX5q3jgD4IyDOyAZtf6HQpVE5HSztSeGFwnnVRYUher371Gpb3wKZJWO+vZR1uoaHJ7oAdML7Dxe71TUTUYTnlxVSlqwgNFUVNkjGFNRseLlAAitBW/RELYrwTLvAAG7jd3BRdFvEjjfMAVaPfqjcS+jKJpI7psrWNKQn4iXHctNToFQVIQGFde/QIFKeiVEeoxMylDbiCv5iOgCHwJEmyErSmcVcySTSLTnLq9DQGQiKzeit9y2QYYXWno8AaPi/lV4MUdo2HUAYzf/+d4MVNm/+ur4y/PRyjUVhx0husJxbkfaA7NwaM4ZwSije16h7kmP9vi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYZ4sRLSTPUaC9kC7FhZUcqk3IruZkgDgFqV4Pw+1+c=;
 b=Nqtrj9cbRAHt1EGSsdWKzRoI83iP97IItluIet332H8vbWifZrjhZySO58CLHmgSpi8MewULB/dwqnTgdTTbjeN/zGHapx8mS2wYD+t3ZCjQB1XtAFRUwwlOggPz09Krgunfllhl7+QE/ghICXfVWvlSbHlNvLZX0adKSxUdBbaiHPVo932CZioqTRlACjXuMR2tRMWCUipKbt8GuX9mzKTirly6VssGcEo19INNOxqKBUCEo1SeGebzvh6JXm3T8ndPrltn/FjNjn5WhZUROsfXen42R9qFR9XFdFJ2m8zOjjdku0AFYGQKriTPXctNu00E54gBfpvpLzQCiJ2DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYZ4sRLSTPUaC9kC7FhZUcqk3IruZkgDgFqV4Pw+1+c=;
 b=XkkPQnXwEpiYO87P0y4zeWkpm3rOilgRzt/fC1yUs2Ar9LKzKLguXI34m7zPLQLaDLE1PM695yQR0B6DEK2RpHAFDriscSa7xUWwp4I6c3IVmBDYnMtFHXJISuFzBTNSO0gn6xUehy+/TtWV1vX0QYcin/8s6cPDaWK1+KLqucQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB6379.apcprd03.prod.outlook.com (2603:1096:301:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 04:00:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%8]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 04:00:23 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v8, 1/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Topic: [PATCH v8, 1/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Index: AQHY1ObPx+txU1VQPkeXIrGkp8wdoa38D4MA
Date:   Mon, 3 Oct 2022 04:00:23 +0000
Message-ID: <ec6f3ea90c3386c55d2894f79c117d9ac508a20d.camel@mediatek.com>
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
         <20220930160638.7588-2-yongqiang.niu@mediatek.com>
In-Reply-To: <20220930160638.7588-2-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB6379:EE_
x-ms-office365-filtering-correlation-id: f5e3840b-204b-4066-8a08-08daa4f3cbf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /C0sKKlhhwHMpa1zp1dFVq3Q3nFDcRLlScwCC/H/hCta8hH8BUPTpPXiS3tdvH+Q0GhiAWQx3E0CqVLW1W9mTeDZlSZiuTHqc8St5qEpnBLGWG6KgJBnGER0/V8nfFK66thEhpHGzkoXEhu87Y3eLkBW+BM5mCXrGCOO2mdfIgbFd/8Cdsk33iCPoA4T2zc4ZAPaMaQVcF2gtkK97AipsRGOmwId47tfZfal/+NPy7ZD4nnsUL3AMBF9l0q+cDYkfuPSj2Rgs6pYDlFIGWqQ7OJw1xDgqAbER58PB9EZHk2HfLG9Os2GhUSCP0K7hq2J96gwyarBy2rzn1K+2Z7UD2ZWo98a/5UeSvIQjU5IvHj0+/UXtQIpWKw1NIPlKtqwJ3sOePmRoS9uUfGOkSEW+OrWynF+qUilg0e1GZ00bz4J4gxFe9nm66CtmIVuFPJEP9+etgVB1nt0ODTsoNK9rTX/jT4sQYFJdcwJQipFw9xCLvaKjeW+k26c3nbPZinlg810m87FXkXP7faBvkrDl8XQXlmuHphNM/CTS5f3OHinpUqNnj3rz/Bybvy5Vyz130vORaLNlQwao8veI/AdvJN5CWQz3g2sn45ihp/momM290Ny0BFnrzm86OKmIaAHN+HY3HU0AHSXC8TmSlst/07wwVoWBXhdoYXDY8jTZXLjiq/vZeQ5Xysl6uaoOp/93Tifx8xToH8+/AbNH29n7LjyTjAWPTwQPcqSw3IZnFsSoBD/pduiJ2svqGUqAgvzlANKT3kBBTN+hkczCxfkWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39850400004)(451199015)(66476007)(86362001)(478600001)(71200400001)(4326008)(66946007)(6486002)(85182001)(15650500001)(76116006)(8936002)(41300700001)(8676002)(64756008)(316002)(54906003)(36756003)(5660300002)(66556008)(66446008)(110136005)(38100700002)(186003)(122000001)(6506007)(26005)(2616005)(6512007)(83380400001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlFLTnphVkF6REdtcVJlU0w2WEdZMTA0a0JwNXR5Tk5sUUdZVitOQlVucCt2?=
 =?utf-8?B?VG9PcGlVMjZGWHRkU1pydkE0bThuKzMyR2ZDaDlYblFpUjc2cWgwRDQxNG1t?=
 =?utf-8?B?Ly94dGVlNTlRb0o1ZnQrTGxCUmtzOGMzWG1XejFjOWpkWFlnYTQybTF4c2hm?=
 =?utf-8?B?ODZKdkhsNnNjZ0JTdTJ0aisrV2ZURWtuMUh4Q0tLZnlWaG4yTTZxWERySi92?=
 =?utf-8?B?c3hvU1BySVlUUFl0akZ0WWZyUDdLejVGYnlmaWZHV29pQkFmcndXMmRNQnpX?=
 =?utf-8?B?L28wQ2pteE15dXg0YS9KVHY3aG5jTFozMFMrc1NjRVh6cnpiN2pudWdxclFB?=
 =?utf-8?B?V1NHTzZFKzk1OFFER3V2SDhxSnl3RzVBbWprL1hzYjlxbVV5d3RHNVB3cHJk?=
 =?utf-8?B?RU4vTjgrby9jQlBWUUlzcGZSRWUxL3cyZ1JmZi9COG1TMnpUWmxLR2dtVkZq?=
 =?utf-8?B?Q1RCbTVjUXJSUm8wTmFQa1lxcVFiUG9HV2dPVkNzVmN1TG1MTVBZSXZ5bGEv?=
 =?utf-8?B?SXVkMFVlWGE2c1Bja00rcEhJWkN1SXVCUHhDZFp1N1Z3UDU0anFEYnlvOWtq?=
 =?utf-8?B?c3FxaUt0bjZ1Y0FYRmtmMWt3WE1vUWllQlB2OVMvaVUvaEdJNWRxcnpRZ2Z0?=
 =?utf-8?B?RTBacTBEdVBLY09jK1pleFVMU2VvYUlWeEJHUTJCaWt6MUJ3MXFEWFU1TlF4?=
 =?utf-8?B?a2hmbjJiYTBtTHU4Nm9aSlp1K2k1WDIzYXY0TnRqb1QzSmJsTVBOU2VJN2F4?=
 =?utf-8?B?ZGJuSVhibzhEazVqSU9kOUkyTEI1ZStyRlVJU1F1aE1tWHhVOFdRWDZldDlX?=
 =?utf-8?B?cEkrKzhYN0RnS2xNYkVhOHVYaS9yejIwK2x6ZVlVb2N0RVYrR1crTXRHNW9O?=
 =?utf-8?B?WDU1enEvcVJGeWhkVTViM2FkS2NMUFBzNk0zOUJ3ZjF5QmR1Vi9BTkdIeDhp?=
 =?utf-8?B?VjhvUmM0cE9SSkdYaVNRY3VNOWlsNHdZWkt0WjdWRGh2UEw2RDB0NDdTTGlm?=
 =?utf-8?B?VVI3d3NLc3ZHbVQyRXdGWEZHQnV3Y2pKS081c1J4TkRtMjhvK21JbkFjZVli?=
 =?utf-8?B?UjkzNi9MM1A5dDJUY2hUNm9ZZmhrOXVBd3NIZlNUdUVMenJseVhaRVdGWXhN?=
 =?utf-8?B?VkdmMFRiSGlnOWluSEZEWVRWaDh6cXhJVnNjZjdLVmJHdEpwRnpZM3g1UUMv?=
 =?utf-8?B?SW5QMGNtVDZlQjFBYjJGdkV4NnVSZ1crWm1HNkh5blVmcDNUUXNtMVpMbGRV?=
 =?utf-8?B?RFhnU210WElOaTRYZGRrVlFTcDd3KzZOQURHUjRmM2NMei80Q2hHaVpOdzdy?=
 =?utf-8?B?TGRDaVBKZEtVVXRsdFdHTW9wM3ZIUFNvZ2w4NG9Qb08xN2U5N1h1K3J1UHlw?=
 =?utf-8?B?dXp0ZE4yTGRlUzA4b0pucmZjNnplVWZieWN3TUIzQTY1ZEhSbnVjVkRIa2xy?=
 =?utf-8?B?SEp4U2RtNWNUQkU5Qnl1dmZqRUY3OE96eW5VbGphUXdKTlNTTjdKdlJuRnN5?=
 =?utf-8?B?NnFVNHliWkFRVGRBK0ZGRmZRaWpOUkZ3dVhqRmwvNSsxMTBIS013cWhkaTJ3?=
 =?utf-8?B?OTBkZU5UL0QydmgxcUJUc0pDRS81Vm9kZHlmbTB2enRnY2xjOUcwQ25kT1Vk?=
 =?utf-8?B?NDh2elU3MEhVVDNUZjhINFJBSlM1d3g3SE41TTA5NFFEeHkybDlDOWRXbnRw?=
 =?utf-8?B?Z0dweFNZOExlSHlrMlJPQU9JT1dkcktWbUVHZzJUanQwMFU5SjA0MDVoU1d6?=
 =?utf-8?B?QkRwNUM4T0tCMnRVQ3VuV1RURDhNWFBZdmZKaUJtcnhIZUFRSTZhYy9oOEpN?=
 =?utf-8?B?RTI1K2t5cVErOExzVENUdG5Kejh4VkszMFN3UENVbVBkTXJsZEhZRXdyVHli?=
 =?utf-8?B?bmx1OUJqU2RWRkhWS0lJVTNlSTJLeFpEL21FdzNiaEZtYTh5NDUwZUJJaTRw?=
 =?utf-8?B?bHpIWGQ0WUFaQW1FVU1VdnVia0dheTRDeGtkQVRIN1JyZjBuWm1ESDJoVzc4?=
 =?utf-8?B?a1UvTVpyLzVsbUsxbnVucDl4ZkFjWGEwTFFzVHA3TXc2d1czNmt6NlBMVnlZ?=
 =?utf-8?B?QXFnS1BJSXEvUnBaWjlhWVVQeTIwc1BZTWRYREFtVW1GVzh1M0ZWVTh1RzFq?=
 =?utf-8?B?c0lMVjVwWUhqdHlYcTZiNlJPMExJMGtFS01LTGs2UFhnQjd3cnFsUUFHQUNw?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <509BCABDF921E846879C39723415C62C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e3840b-204b-4066-8a08-08daa4f3cbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 04:00:23.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NL7as25L11+j8nfcYV8kDi+DdEdOeo5XdgawBjOrwrTze6OPZnwpaja4Pg8YCNWBHYsiddwrWOdn0gA4BYoKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6379
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gU2F0LCAyMDIyLTEwLTAxIGF0IDAwOjA2ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBpZiBnY2Ugd29yayBjb250cm9sIGJ5IHNvZnR3YXJlLCB3ZSBu
ZWVkIHNldCBzb2Z0d2FyZSBlbmFibGUNCj4gZm9yIE1UODE4NiBTb2MNCj4gDQo+IHRoZXJlIGlz
IGEgaGFuZHNoYWtlIGZsb3cgYmV0d2VlbiBnY2UgYW5kIGRkciBoYXJkd2FyZSwNCj4gaWYgbm90
IHNldCBkZHIgZW5hYmxlIGZsYWcgb2YgZ2NlLCBkZHIgd2lsbCBmYWxsIGludG8gaWRsZQ0KPiBt
b2RlLCB0aGVuIGdjZSBpbnN0cnVjdGlvbnMgd2lsbCBub3QgcHJvY2VzcyBkb25lLg0KPiB3ZSBu
ZWVkIHNldCB0aGlzIGZsYWcgb2YgZ2NlIHRvIHRlbGwgZGRyIHdoZW4gZ2NlIGlzIGlkbGUgb3Ig
YnVzeQ0KPiBjb250cm9sbGVkIGJ5IHNvZnR3YXJlIGZsb3cuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgOSArKysrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiBpbmRleCA5NDY1ZjkwODE1MTUuLjg4ZGI2YjQ2NDJkYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiArKysgYi9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBAIC0zOCw2ICszOCw4IEBADQo+ICAjZGVmaW5l
IENNRFFfVEhSX1BSSU9SSVRZCQkweDQwDQo+ICANCj4gICNkZWZpbmUgR0NFX0dDVExfVkFMVUUJ
CQkweDQ4DQo+ICsjZGVmaW5lIEdDRV9DVFJMX0JZX1NXCQkJCUdFTk1BU0soMiwgMCkNCj4gKyNk
ZWZpbmUgR0NFX0REUl9FTgkJCQlHRU5NQVNLKDE4LCAxNikNCj4gIA0KPiAgI2RlZmluZSBDTURR
X1RIUl9BQ1RJVkVfU0xPVF9DWUNMRVMJMHgzMjAwDQo+ICAjZGVmaW5lIENNRFFfVEhSX0VOQUJM
RUQJCTB4MQ0KPiBAQCAtODAsNiArODIsNyBAQCBzdHJ1Y3QgY21kcSB7DQo+ICAJYm9vbAkJCXN1
c3BlbmRlZDsNCj4gIAl1OAkJCXNoaWZ0X3BhOw0KPiAgCWJvb2wJCQljb250cm9sX2J5X3N3Ow0K
PiArCWJvb2wJCQlzd19kZHJfZW47DQo+ICAJdTMyCQkJZ2NlX251bTsNCj4gIH07DQo+ICANCj4g
QEAgLTg3LDYgKzkwLDcgQEAgc3RydWN0IGdjZV9wbGF0IHsNCj4gIAl1MzIgdGhyZWFkX25yOw0K
PiAgCXU4IHNoaWZ0Ow0KPiAgCWJvb2wgY29udHJvbF9ieV9zdzsNCj4gKwlib29sIHN3X2Rkcl9l
bjsNCj4gIAl1MzIgZ2NlX251bTsNCj4gIH07DQo+ICANCj4gQEAgLTEzMCw2ICsxMzQsMTAgQEAg
c3RhdGljIHZvaWQgY21kcV9pbml0KHN0cnVjdCBjbWRxICpjbWRxKQ0KPiAgCVdBUk5fT04oY2xr
X2J1bGtfZW5hYmxlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2NrcykpOw0KPiAgCWlmIChjbWRx
LT5jb250cm9sX2J5X3N3KQ0KPiAgCQl3cml0ZWwoMHg3LCBjbWRxLT5iYXNlICsgR0NFX0dDVExf
VkFMVUUpOw0KPiArDQo+ICsJaWYgKGNtZHEtPnN3X2Rkcl9lbikNCj4gKwkJd3JpdGVsKEdDRV9E
RFJfRU4gfCBHQ0VfQ1RSTF9CWV9TVywgY21kcS0+YmFzZSArDQo+IEdDRV9HQ1RMX1ZBTFVFKTsN
Cg0KSSB0aGluayAweDQ4WzE4OjE2XSBhbmQgMHg0OFsyOjBdIGNvbnRyb2wgZGlmZmVyZW50IHRo
aW5ncyBhbmQgZml4DQpkaWZmZXJlbnQgcHJvYmxlbS4gU28gZm9yIHRoaXMgcGF0Y2gsIHlvdSBz
aG91bGQganVzdCBjb250cm9sDQoweDQ4WzE4OjE2XSBhbmQgdGhlIGNvZGUgd291bGQgYmU6DQoN
CmlmIChjbWRxLT5zd19kZHJfZW4pIHsNCglyZWcgPSByZWFkbChjbWRxLT5iYXNlICsgR0NFX0dD
VExfVkFMVUUpOw0KCXJlZyB8PSBHQ0VfRERSX0VOOw0KCXdyaXRlbChyZWcsIGNtZHEtPmJhc2Ug
KyBHQ0VfR0NUTF9WQUxVRSk7DQp9DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsNCj4gIAl3cml0ZWwo
Q01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTLCBjbWRxLT5iYXNlICsNCj4gQ01EUV9USFJfU0xP
VF9DWUNMRVMpOw0KPiAgCWZvciAoaSA9IDA7IGkgPD0gQ01EUV9NQVhfRVZFTlQ7IGkrKykNCj4g
IAkJd3JpdGVsKGksIGNtZHEtPmJhc2UgKyBDTURRX1NZTkNfVE9LRU5fVVBEQVRFKTsNCj4gQEAg
LTU0Myw2ICs1NTEsNyBAQCBzdGF0aWMgaW50IGNtZHFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gIAljbWRxLT50aHJlYWRfbnIgPSBwbGF0X2RhdGEtPnRocmVhZF9u
cjsNCj4gIAljbWRxLT5zaGlmdF9wYSA9IHBsYXRfZGF0YS0+c2hpZnQ7DQo+ICAJY21kcS0+Y29u
dHJvbF9ieV9zdyA9IHBsYXRfZGF0YS0+Y29udHJvbF9ieV9zdzsNCj4gKwljbWRxLT5zd19kZHJf
ZW4gPSBwbGF0X2RhdGEtPnN3X2Rkcl9lbjsNCj4gIAljbWRxLT5nY2VfbnVtID0gcGxhdF9kYXRh
LT5nY2VfbnVtOw0KPiAgCWNtZHEtPmlycV9tYXNrID0gR0VOTUFTSyhjbWRxLT50aHJlYWRfbnIg
LSAxLCAwKTsNCj4gIAllcnIgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgY21kcS0+aXJxLCBjbWRx
X2lycV9oYW5kbGVyLA0KPiBJUlFGX1NIQVJFRCwNCg==
