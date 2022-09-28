Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEB5ED497
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiI1GSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1GSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:18:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0271114FB;
        Tue, 27 Sep 2022 23:18:15 -0700 (PDT)
X-UUID: 074f8c69c4674c62ae710a6d704cd423-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q0bm4xumP7CcAkgXWFUkJMONcBglxHqFBkiL+xZdDJY=;
        b=ANR0j3fEKHecc5EUR2HZ4kH7BVmtwUVHJlCM9TkwK/f+/QWB0oR60KDRYY9Nr+ejFIihGIEnHrbl5sw9ldTRlNfWLI6reYKu25yk8bThe02jLK6QwtQF77eol3fksINnLTTgxW8E0vpWOJUQsrqUAJjGWWuWVZZ7qjg/PwNC2OY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0b655138-ed28-4071-8c5a-8e46102a324a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.11,REQID:0b655138-ed28-4071-8c5a-8e46102a324a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:39a5ff1,CLOUDID:36fe7ae4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220928141811H961H2CO,BulkQuantity:0,Recheck:0,SF:38|17|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0
X-UUID: 074f8c69c4674c62ae710a6d704cd423-20220928
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2001494972; Wed, 28 Sep 2022 14:18:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 28 Sep 2022 14:18:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 28 Sep 2022 14:18:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbgLKetIkjRSaNNW+/Nw/yEGFdax9g9oJtmgoqauSBd33+QYUlrNXZSlSWSKjN1CRz9mp7dhLPuA4CtiJPoC0g9eHUmygv2GhseaHy7rwoqBLd7x4007hiYkUo8HwERKUEyG9v3V49egjzWpWBOFz7L0+jSl9dj61sTcecT3Fvcjs+pxZNxzXpiFQks9+iYkXZ09oZHXvesuY7V6kYwcuPtdDbGKEg2RfBqWFgpt2bOc3Q9ll4KvTZHegYI3QOpG5/tDkqnOF8ZoGtz1b/LBXYhIVWkrwScP39q5pR+EX28V3OYQJz1IPU37Ie3TsJgvIs1FaWnhLMduG4ufO5FGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0bm4xumP7CcAkgXWFUkJMONcBglxHqFBkiL+xZdDJY=;
 b=HiS7vbFpda/pQQAdCN/DiL0TQdbyxi+91Te2rHjFMCaI54jT//rhyOrnOJSrtSUper3zSy+D7GqAm8zgniZZsIsyZfAYbLxcXtTaX7dpPuKzVOmeoQa58kRRbc3d0LzdpzQWcwirLkwgQa2+UyhILVgekzxnaXO6Rokz1Xl0BOx+UA+RxgGDhvscXgrgmTq2K9f6hBNJXV8Yto+/z6UcFuNqNcVPW3FJ7yLrZHzux+JUNOzczKygzoWWU3EPpX0vDhyhlOKZlsiYUpRtJ9CJGq/2xiFQgtGthLplWlHH0jh2Rpmey4uuvUP95BariNZci0n5Q6KkLnKoN1+Dd4E85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0bm4xumP7CcAkgXWFUkJMONcBglxHqFBkiL+xZdDJY=;
 b=Uiti7F8h09uM/yGFQcyRxaCyLl6oNfemmnZ4LjrZxz/1cKUGNm9KUFamg9q1LUhyZ0DbBG+oGznE2P3oHoTy94db851yFDbfYAlfXxvqz17SxffqHXGnq/2KzvB+s58bIIJ8GbuCim4Uxj1PPVbHPACbIf9w/cMOAenfAaEjTpM=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by PSAPR03MB5335.apcprd03.prod.outlook.com (2603:1096:301:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Wed, 28 Sep
 2022 06:18:07 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%9]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 06:18:07 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHYyDgR5+yZ2Jr9xUC25pzz7CNRNa3k9HoAgA9/OgA=
Date:   Wed, 28 Sep 2022 06:18:07 +0000
Message-ID: <2179d4fd670b6035b38eff3daa21a39fb25b234a.camel@mediatek.com>
References: <20220914124552.16964-1-johnson.wang@mediatek.com>
         <20220914124552.16964-3-johnson.wang@mediatek.com>
         <78a0e713-2691-677b-e749-fde609944a7e@linaro.org>
In-Reply-To: <78a0e713-2691-677b-e749-fde609944a7e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|PSAPR03MB5335:EE_
x-ms-office365-filtering-correlation-id: a3c6669a-6346-40fa-2c58-08daa11935c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5hUSXVWKVNcVO9aheN9laWkW2h43Wk+ZSxSh4jSx+DBByWUd1ILgpp0CIpMT6aGWBCzb5rIDR8L9hp8w6KiqN75Q1OM4reKCO8thQVmEF+S0wg2MC19cvWtsmrRc6VbEc9AHzIK+RxtX4CQB6ovF76WTQQgh7VOeVgGzhiS+Tj3u6Dmr+RsnnuLbFWdhR7L2tbLRJ/NQq29bmMkV06/+RCqF4aLPX3i3WCklCb1XdYYTawsSWm1+lwIJzovz+DFy91ZS/gSLysi2NAuR9PAomAefz/PpxcPrwd+KNg4ZfDxd+FHnxMxUri4SRMeKn/K0FrIPwTOIdeSfMJAwwENLqQcWRwodBz6275SBG1ayOhJOGChiTZjkcXW/btxZcdIIM/BL1ENm6xRVvKSMBxTGOYw9c3/J5+lYaoVqiqlb70TePpQFgbuPiTjWq5Sx27FelekL41xxZ7iMgAk6lpp6BFpfoP8tQoIbjgbXzoxiwVbT3uiua8g9qSVn9tSFefnByhqqf5ZcVMjNLG2AkrZoqrG47lTlvxm4QiIsSXweDExY3BXv3aoXMTEBZiLZBOSBSz6VMEkKocKA5qGLrlbya5uqHjJz7P3pjewTHTuW3sRP8okPSvJHFH6NsoIUljYAEbgvgHun+XQZiopVUvAvJ2Nosdoc+YAtLVELy7bGDptPvqvZ/J7bcdvHkPmV3prCjlGv2XvvEGmEQ0friFrax5bSwa+TUwTVtWx65tOHcye0mzZVp6fNM5HM1juemxwDca21RVwLB/s806kCW4lmVzkuRaBaTV8AUmzQ7hV1HOVmUSS7Boe4tDszwJJivw6RyD/7Ql0+AJ2jbUxwv6bKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(85182001)(36756003)(66946007)(83380400001)(2906002)(4326008)(122000001)(38070700005)(86362001)(26005)(6506007)(76116006)(66446008)(71200400001)(186003)(7416002)(64756008)(66476007)(8936002)(8676002)(2616005)(41300700001)(66556008)(966005)(478600001)(5660300002)(54906003)(6486002)(53546011)(316002)(38100700002)(110136005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVhQbWZ4VGF4a1A3WHpTQTIzN0F0dlc3S0EzS0h6QXYvVU9vdk1IYk9meFJ6?=
 =?utf-8?B?T1Z6QmkrYWlobk5FekU5ZnkrRmY0VTAxVVNpQU9oTHNvTnBuZm5qRWhaeVBS?=
 =?utf-8?B?cUNGUzJkbVRBNURYeW0ydlRHdVNRVFRmZzhNb3V4ZGxmK1lTcE82ZnpHTWdz?=
 =?utf-8?B?RUU1NHJwSjhvODRvSEZqY3hNSUtkeFQrL0FQK05zMTFheUg3d2l4Z2ZZQlNZ?=
 =?utf-8?B?YmlUQ0lEdWx0bDBZWE1aWmx6VXV6SmFUbnRlRmNSODBSdlljMHlWREZCMC95?=
 =?utf-8?B?QlhsS3RpaXg2dXN2RXVYR09WNHd4ZW1XZ1pCOU0xdG1SMzRKbnl1NVVvWUxr?=
 =?utf-8?B?MjZWRkE5Q3pCMitLbWQwRFpvU3Fzb2NWejBwUjE1dHdVOU9aV001Y1JEZ2ht?=
 =?utf-8?B?ZWt1VldGSS8zQUZ4ekJramowNFVwNzJKNUxGWmxMeWZ6dzlDS1F2aFRTMWV2?=
 =?utf-8?B?RStRU3JqUXF6TGh4cjlhb2xqVUREbkN2M1BBTk95L3JTUjY4Qzk2Wm16QWZ3?=
 =?utf-8?B?aEtXdWdkRytucHFwQnZHT09ja1pkRnBrR25DNWlHNWVJTC9rTUlHaDE4K0Jk?=
 =?utf-8?B?ekZOUlBIdFJtaVI1ZHJULzVGMlVnZFEwNk5XVTZ3cUYxZm01N1Ztbzd2aWYy?=
 =?utf-8?B?U0x3a21IdHhKN1dRMXFReDlnVHBSMGMreXpRekt5SlhWM2RpSUtDNUo2YlB2?=
 =?utf-8?B?MnZRRmdudzNUN0ttL3Q2MEdRM2w3Mnh6OXhSZDB1dVJsSlVhUUEySGxZUjNK?=
 =?utf-8?B?YVU3SExlOWlXSEpXbDYvalV5Yll1c3dTR3VURGxJQnFpek44aHJqQlpHSEpq?=
 =?utf-8?B?Mm1TbGZpb1g4Nlo0QXR2bUl6aFF2aVhOQXBuZ2txR1c0V2Z6eXhreUR1ZlF1?=
 =?utf-8?B?ZXVNLzVONUpIeUNMbTVOM3h5M3E2ejZyVi9MSTZsR2dIZTlYSWxkcHFCWXBm?=
 =?utf-8?B?YWZWUjR5VFcvVUQwVlFIWDU2UFBCUi81Skp6MnpsQnBva3Fwa1VkNGVoRDBK?=
 =?utf-8?B?QnhubDBxTFZFd2ZKeFNxNXNrZzRxZjV6Ykh3ait4NmxweVE2cTViRjMzZ3RY?=
 =?utf-8?B?MCsrK0hWb2E3MG9FS0t1M0hQRG5wYkhVR29FNll3akNaTlFXOFpneUNzUVhK?=
 =?utf-8?B?OStqaEZNUW52emJrVVFUd2FQOW1lTU1nL0gwTjg3c1A2YUs2YkdsdmV1d216?=
 =?utf-8?B?VU5FSW9rSmo1Z0l2TVZiQXY5cXAwYVhDL0FDaFN3eWh6Rk0vTmhXRjk3Z0c0?=
 =?utf-8?B?OWl5dnhuZGUwRkpoa3MyNEQ3eVNudG9ibXpaaE1MVnBsK1dXR2h4MGVoM2JY?=
 =?utf-8?B?Qm81dWlwNjRJQThqdFRWZytUYjBQNjhSWmppaWZJeHREZXc4MllCajBhRkQ5?=
 =?utf-8?B?QjdjdjYvN3M4L1ZORWVFRG54cVpqSkx6VnA0d3U4MTdqWmlEM05KQmI0Nmdv?=
 =?utf-8?B?VXNGKzBIMHVhcUZJaEYyUzN1Wng5TTY3SG90dUNoNzVGTFhtL25RYUJsdTZO?=
 =?utf-8?B?WGgrTHFsaTFGV2Q4MEtLeEZ4K3NKd3Qyejl2ODk5TW42L3FBdXNWeTdiSHBN?=
 =?utf-8?B?ME8xczNFUWljOVA0KzNNWjF1VXU0emY0aU9rZldrTjNMTGpTTFptTnZKWUJo?=
 =?utf-8?B?RTU1YU4rS0IzNzJ3OURlV1UrMndzbXg1a1BaR3lWMTB3NjIxTjFYWGdZYWVi?=
 =?utf-8?B?UG9JUE5XZHJ5NUJwb0pMN1o4bk1tTWswSkllcHhiYmx0aHE3U2dXMTQxOWcw?=
 =?utf-8?B?QldUNk9heXd6a0crNUJYcHE2N0RiTW1YbGM5ZlpWa21vRFFrUDBjYWhwWnlE?=
 =?utf-8?B?bnJMVVM3aFFwb3Z0dXhFZHBLSUxiZU9zeWFkMzQycEhiUlg4ZzRjelRVeVV4?=
 =?utf-8?B?QXM0aXFnb05SU09PZHJUMmJ5ek43ekpKVnBIVnlkcDB3dVNXbDBnTXR2dG8r?=
 =?utf-8?B?SWpqZjJsWjhOT09aYmVvdmRuNkNlZ2JGRkViMEwxZ2dhTUk3SWdhY3ZubkFN?=
 =?utf-8?B?NmNUOTBETkIzd1R1SDRoM1VFY3ZDdktac0JYRG1pdjRUM3ZhNCtPZ0FFUHhH?=
 =?utf-8?B?MzNnczROaXcvS3BxeStvNVRmR3BkaUFtMzh4VEZkdmxObzdjSU1TNitYdXMr?=
 =?utf-8?B?YTkwalJDTFJwcndsdG1RT3p1NVpERFNJTHVISFhxanJnN2lSREwvVHNpWEVH?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <295206AD62516948BCF8AEBAC0E1D23D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c6669a-6346-40fa-2c58-08daa11935c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:18:07.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exXSEob09SWhETqwnmUGPHB6o+KY8RyMMKgJbciUTjQxzNbRkneaab8MbhU4673LpG7Xxw3ajyFv+VvYumZW7hSiRlHcWfjbE7gYEweIRUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5335
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQpUaGFua3MgZm9yIHlv
dXIgcmV2aWV3Lg0KDQpPbiBTdW4sIDIwMjItMDktMTggYXQgMTA6MzggKzAxMDAsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDE0LzA5LzIwMjIgMTM6NDUsIEpvaG5zb24gV2FuZyB3
cm90ZToNCj4gPiBBZGQgdGhlIG5ldyBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIE1lZGlhVGVr
IGZyZXF1ZW5jeSBob3BwaW5nDQo+ID4gYW5kIHNwcmVhZCBzcGVjdHJ1bSBjbG9ja2luZyBjb250
cm9sLg0KPiA+IA0KPiA+IENvLWRldmVsb3BlZC1ieTogRWR3YXJkLUpXIFlhbmcgPGVkd2FyZC1q
dy55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFZHdhcmQtSlcgWWFuZyA8
ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG5zb24g
V2FuZyA8am9obnNvbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRp
bmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxmaGN0bC55YW1sIHwgNDcNCj4gPiArKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vbWVkaWF0ZWsvbWVkaWF0ZWssZmhjdGwueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0
ZWssZmhjdGwueWFtDQo+ID4gbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxmaGN0bC55YW0NCj4gPiBsDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjdiMGZkMDg4OWJiNg0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssZmhjdGwueWFtDQo+ID4gbA0KPiANCj4gTmFtZSBv
ZiBmaWxlIG1hdGNoaW5nIGNvbXBhdGlibGUuDQoNCkkgd2lsbCBjaGFuZ2UgZmlsZSBuYW1lIGlu
IHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiA+IEBAIC0wLDAgKzEsNDcgQEANCj4gPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9tZWRpYXRlay9tZWRpYXRlayxm
aGN0bC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchM2UtUUV6SmNGOEVSNmJpOXBCaW5YYWtX
VU1Ec3VyWlB5LXE2OUlOSHFhbFBfZXZqNTBtZVNCQzdTTjB1a1poZkVtTy0kDQo+ID4gIA0KPiA+
ICskc2NoZW1hOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyEz
ZS1RRXpKY0Y4RVI2Ymk5cEJpblhha1dVTURzdXJaUHktcTY5SU5IcWFsUF9ldmo1MG1lU0JDN1NO
MHVrWkxTZzltaCQNCj4gPiAgDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgZnJlcXVlbmN5
IGhvcHBpbmcgYW5kIHNwcmVhZCBzcGVjdHJ1bSBjbG9ja2luZw0KPiA+IGNvbnRyb2wNCj4gPiAr
DQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRWR3YXJkLUpXIFlhbmcgPGVkd2FyZC1qdy55
YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgRnJl
cXVlbmN5IGhvcHBpbmcgY29udHJvbCAoRkhDVEwpIGlzIGEgcGllY2Ugb2YgaGFyZHdhcmUgdGhh
dA0KPiA+IGNvbnRyb2wNCj4gPiArICBzb21lIFBMTHMgdG8gYWRvcHQgImhvcHBpbmciIG1lY2hh
bmlzbSB0byBhZGp1c3QgdGhlaXINCj4gPiBmcmVxdWVuY3kuDQo+ID4gKyAgU3ByZWFkIHNwZWN0
cnVtIGNsb2NraW5nIChTU0MpIGlzIGFub3RoZXIgZnVuY3Rpb24gcHJvdmlkZWQgYnkNCj4gPiB0
aGlzIGhhcmR3YXJlLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxl
Og0KPiA+ICsgICAgY29uc3Q6IG1lZGlhdGVrLG10ODE4Ni1maGN0bA0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjogUGhhbmRsZXMgb2YgdGhlIFBMTCB3aXRoIEZIQ1RMIGhhcmR3YXJlDQo+
ID4gY2FwYWJpbGl0eS4NCj4gDQo+IFlvdSBuZWVkIGNvbnN0cmFpbnRzIGhlcmUuDQoNCkkgd2ls
bCBpbXByb3ZlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArDQo+ID4gKyAg
bWVkaWF0ZWssaG9wcGluZy1zc2MtcGVyY2VudHM6DQo+IA0KPiBUaGF0J3Mgbm90IHRoZSBjb3Jy
ZWN0IHVuaXQgc3VmZml4IG5hbWUuDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9kdC1zY2hlbWEvYmxvYi9tYWluL2R0c2No
ZW1hL3NjaGVtYXMvcHJvcGVydHktdW5pdHMueWFtbF9fOyEhQ1RSTktBOXdNZzBBUmJ3ITNlLVFF
ekpjRjhFUjZiaTlwQmluWGFrV1VNRHN1clpQeS1xNjlJTkhxYWxQX2V2ajUwbWVTQkM3U04wdWth
S0VoRm5OJA0KDQpJIHdpbGwgZ28gd2l0aCAibWVkaWF0ZWssaG9wcGluZy1zc2MtcGVyY2VudCIg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzIQ0KDQpCUnMsDQpKb2huc29uIFdhbmcNCj4g
IA0KPiANCj4gDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBlcmNlbnRhZ2Ugb2Ygc3ByZWFk
IHNwZWN0cnVtIGNsb2NraW5nIGZvcg0KPiA+IG9uZSBQTEwuDQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo=
