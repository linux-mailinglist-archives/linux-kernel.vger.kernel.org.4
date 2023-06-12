Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6D72BA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjFLI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFLI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:28:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42BE56
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:27:28 -0700 (PDT)
X-UUID: f202134608fa11eeb20a276fd37b9834-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QANAPBuQUBffkDjDCyGpryReYwhzqRy/kHgACG2e2jo=;
        b=eUQaawIPPp1u7aY2rp6ASCTF4trmk5qGMVQqafdtLoFUHvkBcpbp1VWZygNjvzD8T8gpXW+Z/MEBfTwsKm89Ah5eCzMVDSKprwtWrxYMR8EQT+th8E5CyAsnJXqFWUOGwyrhI6xMQq/UNjG0iEIUeXG8i7gTkXE3gi2+8KqnIXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:7d547ac1-bc4d-45cf-b6f1-9ac765ea3ffe,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:5b9d553e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f202134608fa11eeb20a276fd37b9834-20230612
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 678316056; Mon, 12 Jun 2023 16:27:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 16:27:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 16:27:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxf4EjzDyfB8iA+5Ve59Bnzi2/JKxQU8ovejbx7dRzzfcao96aov8kGcDXHib2V+52B2kirLWWb40RqhEz4TpPIdOuKE6AdIGjOGWxhLsg8SwrH2zkJbExisqn0kHcEORDYILLS2Db9c9nzQ8dkO0ma2Tf4sjGGYqhcc1szipLYyk8lr9I2TiqDQ3X91LKrhV9EiEj700u6ZdR4SNnx+QbWNS6Fh/SWcnvx1YX6PAHHGzsbVLb+99vDIsdEL6tHRELgJSOOa1v6PtDg9GEw1iEmwj5dZGRG+5nZ7++kJd6CYWqFLdsn0magS+DNvSljWsMtGOLZi+n0FKK7M4euZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QANAPBuQUBffkDjDCyGpryReYwhzqRy/kHgACG2e2jo=;
 b=FMWv01KWJMO71YROEOWkcPVFr9kXvcL87z4qnt6jrET4ja2JBPLEkSCCPF6k79eUrZjkvMeSvIc01ygIK7hkmqWl4Ap5RBjBql1SqWgblYNrGdWhl12bPkf0ppv59bcyDlgRaKIHauBFHq/dKbsWryBRcN+QyJLZNGH9/NrC342g/z1SMgHq+2o2/kJaYwdLthsIlnlZqUZfgYqXY933PJJilAgLi6/LLbZFrIC+0LOwkyMKh1JuBq3Mrab2I1WqjB3MoRrjocHBJEQgNUEcPVHAR5Ml0SVb2INw43pvo9k2L6gR+Vg8IFR9DD9tDZ91QRstyTefPsKsVUaJ3udqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QANAPBuQUBffkDjDCyGpryReYwhzqRy/kHgACG2e2jo=;
 b=lzbzqdeZizlWeBXF0pi853WpLNC9tDHOK2/xRRtZZtwnOp8J0wMB/6kra5w/fgr7UgpwODmPT1H9ktsTT/rvBs+o/LBbGfWL3eUcEgF5wt8sajxjC+ZkIMiGg0bi++vRfDn6HormAvgfZzBWQjmEhDWatqG6NEdioa6pywBoEsY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5505.apcprd03.prod.outlook.com (2603:1096:820:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 08:27:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%6]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 08:27:16 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 3/5] drm/mediatek: Add initialization for mtk_gem_obj
Thread-Topic: [PATCH 3/5] drm/mediatek: Add initialization for mtk_gem_obj
Thread-Index: AQHZaR0qcNA4DmgdD0msFJkFJQRE2K+HPSiA
Date:   Mon, 12 Jun 2023 08:27:16 +0000
Message-ID: <f5cb370ffee4fd7f244dcca46f985fdf1367524a.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20230407064657.12350-4-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5505:EE_
x-ms-office365-filtering-correlation-id: 06f68e65-7ba9-4bb9-0595-08db6b1ed4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1j2NQ48aYCRDd4UutNn6JN9R97DX8GEWjFdRcD4W/i1fy77ErSRpy1cGQv9g16hPNn/cavBOkuythwOchO8xKakx+jSGxqy8qnb5ySmMki0gwgeoNSDxCye71+92Ei1xYl4P2ZwiUrQ4gBfJTi5uS3UCL5zOEoBMWay1DA25R0/Jb/YsP9a6Q4BZPX27Wv9OQe7ylfX8c+wD4BlBxLgXhnnogivC8u16Dga91fcrJ1Qu38+XRTvaJqqgkO6VIwm2cnzr+zjekm8RVi5z2MKzxBPTV1y2g2+RHByuNh1keUBesuFfReMvbMo4A7NBf5U6Gg8vidFMnROdegjh2kz0UdrHVCtK0+J4auyCISswUCyY5C0V8sDGpf5+PJilxQ4YR7gt125Dl/8fxNKGbWeydeafzsBTyAzTBToKN44weIEZN8clqH4OxaJsMRbCCGQw7BR9+Ak0ViLA7jQpdkKqPwTejlC1863t1g9UPg67X9FXrSeEZtxQii0wNGEKLeSjZtBQfBOaZO4tCnSXIycSvAfhzafULmyy7l7EDUV981zA2XbaKYwJDN4Ba7rC/nQiB/Q5IsNts8oQedWtTXrjg25WKTlRDsXFEx+OCLbkFwbmjSrOoGdvjM7viThyQ9OfixLvtXtKYO7G9vRYAMxPiEqSJ91HUyEnkAm29h29aF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(107886003)(6486002)(36756003)(85182001)(83380400001)(2616005)(38100700002)(86362001)(38070700005)(122000001)(6506007)(6512007)(26005)(186003)(2906002)(110136005)(54906003)(66476007)(4326008)(64756008)(316002)(91956017)(66446008)(66556008)(76116006)(41300700001)(5660300002)(71200400001)(66946007)(478600001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0I2TUUzRHZjdXlkWVJiZ0dTZUJTZjZtVDEyYTNGT0lPOHQxSTNWTHNNa2Q2?=
 =?utf-8?B?ME9MaXFGUWJnWXA5VlB5cGt5NS9wTFJna05Tb2dCMEpVYndNR2ZSU2pvN0FJ?=
 =?utf-8?B?Q2RYVEhicHVVOUJ3QTZSNEMzVmRKdDBOL0ZDQ0ZudkxlcU9pZjR2bWNpenlQ?=
 =?utf-8?B?dUpuSGJlMy9TaDRkSGFQd1RZanRXOTVUenFPTDlYVDJvUk9wMmpiem1VNmFq?=
 =?utf-8?B?ZFpRTDdveTNZY3RGRE9LODRTdnFSZStHT05Sa3BzY1U2YnI1bkw1VGVZbDVZ?=
 =?utf-8?B?aW1mejF1Z1hKdmZYcWg3YWFTbXhKVHVmRTNEQzFvbFkyWm9PN2JrYWZNekor?=
 =?utf-8?B?bTkvS2FJWHJFVjB3cUl6S05XbUt3NTBydXM0Tjd2aDJKYlpaT1Z2NXRKaTMz?=
 =?utf-8?B?WVhiai9CUmN1c0oraEozZHljUnBXWlNxQkFYaWRWMzhGejdvK3F5UXk0THQw?=
 =?utf-8?B?cXNvUnBDb3ljandsKzk1THd0UHdWM1IraytyUWllSUhwZVpLVExqOWhUa0NP?=
 =?utf-8?B?TXJEemNxTnVsNUgya2wrQTB4RlVLVTExZlpNQlVCSVU4Y1FBOXg3NGNXWWR0?=
 =?utf-8?B?TVhBeHJoQWs1TUNxY1crQ2hraTRacEk1MG9PZ3ZvWVJ4YVJRUWpITy9HUGxx?=
 =?utf-8?B?SkZJRlhNOTBaWWJDUzU0eFhqY250djN3U0l0NEhvSCtnQTZ6K0VjU1hTbHRy?=
 =?utf-8?B?WERqdm9HS3VNTmVpOXBUWHFqay9nNnI2c1pZRUhKVmRCS0tXdzFQdWlqN1R4?=
 =?utf-8?B?VVE4ZEh3cE5yYjNET0pzMnJWTmcyQXZoeWFrYzg5Y2p6dWcydXFkUVlEUWFr?=
 =?utf-8?B?WnJXRElzMlpMSWl1bmlyNE8xTDNzTi9qSE9YZ0lCQm5jb1VaN2t3RHJiRDdp?=
 =?utf-8?B?Uk1keTd6NCtzNmlGMDg2cWRhamwyTm84UWFmOVpjY0taMDNENVdjcU5kTWhs?=
 =?utf-8?B?bzdraCtCZGI4Qkh1QVJ6S1dvZlFWQVFoVWNmQlBMRjFNNXBxclczeUtCOXRQ?=
 =?utf-8?B?YW43K2lXb01SMEJ4ak9xbVdmWHFnMzY5T21jcGdOU3RMZHVROFE3Vm1Eemxo?=
 =?utf-8?B?SWRPT09LSkZnMkZYUWg0WnBpekx4L01aSzc4V2VqME9EaCtOdmxhUzdhTk4r?=
 =?utf-8?B?WXpacUp1R0R5V21QMFBGeU1HZ1B4SWlUWFVkWGlsWUJtOStXeTRmK0RaWHpF?=
 =?utf-8?B?eHpvR2M2REk1MnhGR1RHRW81KzEyY2FGMG9KL2NZWGdBZ3hrL1FWOHNOeG9o?=
 =?utf-8?B?Z01CNFdTR0U3NFVKREw0U3pYeit4S2YyTDh6ajBzaGVkdG1iZm10LzJFa1Vp?=
 =?utf-8?B?SzNWZ0hsQ0wxQUhsVkE5RHN1MnZpNlZheVpwcmM2MDlKbkh2TXN6OVJqdGtK?=
 =?utf-8?B?L0grc3M1TEMrTDB5aWxPMHN3SEY5My9wTDhqa2t5V0t0R2tNMnBtWUJvdVVJ?=
 =?utf-8?B?Z1NheXRTdFZVektkekQzMDVPMy9xR3VWenR6NHhYamxDQjBvc29aRU9TK0FI?=
 =?utf-8?B?NDFZQUJwS053N253UGs2dTZrNXRuTVI3eWpwQSt0WjA1U1lLV2NHQnRLN2dB?=
 =?utf-8?B?aGNtdmtjQUJZUFZpVlkyWFhydTdPU0dxK2U1Y2h4aWdVUUFocjRKbFRGUlNC?=
 =?utf-8?B?bjRRSEVxMG9jS0Vjc3M5SnJDcTR3RlpnZEtpMFJRN2diamVCemFua0Mrd3dQ?=
 =?utf-8?B?L3ptL25qSzZ3MS9tYU5mRStwT2czL1ViTW5hN01xNDRud0lyWTlFL0h0Znpr?=
 =?utf-8?B?alFMaDV2QkdCaTFnN0VFZTFMSEtUUElmcTB0STV1ZkpUTy9Sd0JKZHoreDBY?=
 =?utf-8?B?dWV2VTRnT2Q3bGVONko3Wm5QMnNiZ1B3V2lWamVmaE9hc3BxZUZQNXQ3dC8z?=
 =?utf-8?B?Y2RicXBrS090WlZSMURuNXpnenlFb3hRblRpTVRWOHpldCtITnEzSGVQSGlY?=
 =?utf-8?B?bHZwYVFnUE1xZW4xUVpKN29qZkJHVTBmUGdlOGFFR1NVdk5lMlk4c3NMSFhr?=
 =?utf-8?B?MkhZcWRlQVFHcTd2S2JnWEV3b0lIcE1Xbkk5dHZuK0xSZnpHYUZCR1dKcStB?=
 =?utf-8?B?VjRxMkFTTUtsd1ZHRVM0R05la21mVlVjQnBwdHFOZ0FsYk1QVlhjcVR3UEhJ?=
 =?utf-8?Q?9BGIRs58FnOJ8KzCt7n65ZJKT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <889A2C8C8D1A654BB419B2060BC9AC02@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f68e65-7ba9-4bb9-0595-08db6b1ed4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:27:16.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UT4B06CDYHJrBbSJx5n9OxMM8Od0qQ1XaNwRI8qpNqyylQu3C0CX0hptoGZjLL88/6P5x45tahEtoBuTMtm+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMDQtMDcgYXQgMTQ6NDYgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQ2FsbGluZyBtdGtfZ2VtX29iaiA9IGt6YWxsb2MoKSB3aGljaCByZXR1
cm5zIHVuaW5pdGlhbGl6ZWQgbWVtb3J5LA0KPiBiZWNhdXNlIG10a19nZW1fb2JqIGlzIHVuaW5p
dGlhbGl6ZWQuDQo+IA0KPiBJdCBtYXkgY2F1c2UgdXNpbmcgdW5pbml0aWFsaXplZCB2YWx1ZSBt
dGtfZ2VtX29iai0+YmFzZS5yZXN2DQo+IHdoZW4gY2FsbGluZyBkcm1fZ2VtX29iamVjdF9pbml0
KCkuDQo+IA0KPiBTbyBhZGQgaW5pdGlhbGl6YXRpb24gZm9yIG10a19nZW1fb2JqLg0KDQpTbyB3
ZWlyZCwgbmFja2VkIGJ5IG1lLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBGaXhlczogMTE5
ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsgU29D
DQo+IE1UODE3My4iKQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2dlbS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZ2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiBp
bmRleCBhMjViMjhkM2VlOTAuLjliOGY3MmVkMTJlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gQEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkcm1fZ2VtX29iamVjdF9mdW5jcw0KPiBtdGtfZHJtX2dlbV9vYmplY3RfZnVuY3MgPSB7
DQo+ICBzdGF0aWMgc3RydWN0IG10a19kcm1fZ2VtX29iaiAqbXRrX2RybV9nZW1faW5pdChzdHJ1
Y3QgZHJtX2RldmljZQ0KPiAqZGV2LA0KPiAgCQkJCQkJdW5zaWduZWQgbG9uZyBzaXplKQ0KPiAg
ew0KPiAtCXN0cnVjdCBtdGtfZHJtX2dlbV9vYmogKm10a19nZW1fb2JqOw0KPiArCXN0cnVjdCBt
dGtfZHJtX2dlbV9vYmogKm10a19nZW1fb2JqID0gTlVMTDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+
ICAJc2l6ZSA9IHJvdW5kX3VwKHNpemUsIFBBR0VfU0laRSk7DQo=
