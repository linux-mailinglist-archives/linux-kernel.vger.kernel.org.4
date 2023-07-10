Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BC74D09D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGJIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:52:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B7C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:51:59 -0700 (PDT)
X-UUID: 04d54f961eff11ee9cb5633481061a41-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AgxYooNwz4zOx5a+n20710ZMIJd/Ge5iCRoG7dLWysk=;
        b=UbWsvT277MAD1a9L1JnmBGFVFs9RLtoHFH+wopSMJWHA4OW/Xv3tIqgFxv3n9UtTU6F372dpCfIcrI3psmrE9uySNfsSAfx40GG/4wIC32waiPiPLUHmgbqlBxPwmjv/Qvq9XbUpTNyoVhhlhc2XFEWiSxAyYhF1ZLzPyaRB3Jc=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:0174571d-1cbf-4ec7-b3a7-7ca9e37309d5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:54
X-CID-INFO: VERSION:1.1.27,REQID:0174571d-1cbf-4ec7-b3a7-7ca9e37309d5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:54
X-CID-META: VersionHash:01c9525,CLOUDID:81590e68-314d-4083-81b6-6a74159151eb,B
        ulkID:230710165155QIQI7HGJ,BulkQuantity:0,Recheck:0,SF:38|29|28|16|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULN
X-UUID: 04d54f961eff11ee9cb5633481061a41-20230710
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1590582181; Mon, 10 Jul 2023 16:51:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 16:51:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 16:51:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abnVjZJwzl1/Ab3bVrI5vLTF58zb+HTDxmwrQByD40oDKIzM6EwlQjrm8InhB3iycxyMdtzzKeVp2xGBhC3/BV/Z8cOTv7B9eXTuz3yQwkQHAaiS17ugWXuuayS0RSOnEsFaxtOocbugGiWJAhvEnb9bBhjsf9JKXRdvSoFlY4zaTqP43c52oUPy6/5aZ2/ylKo9XB0T400+M4OwOE9Hq1K3c3Hj2fu7fRiY7ZQBGo9vXtqHW9oah3muOv6OREV/YhOo0xt/IZJ08hdmSLpAq7fT9mCQx2BYHNvm+Szc7raILglnC8fSJq9McNdu2vVIEF6nS/JW+xgfhEX5ZjKJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgxYooNwz4zOx5a+n20710ZMIJd/Ge5iCRoG7dLWysk=;
 b=PZWUT9kAeRPkWMseer+0pey5VpN3NxKCk+dYI+FmkmH6IP222JaxNDlZH1tF6Lii1ockRLGqO2QVFYJPbiqMgIPdBURic5DD7dXFivCV1y6r4K8izEHyjppBlIfFSmPFk9fbM1LSFEwqtcm4jslspnLOrknDADJXcdEmg0t47S+WXwP43KnoiBGYH1W39l48ijUVn03luNGnpxC6NPwIRUsq5dfeK6I8BV4rH/EUhp44z9qY7Lqh7967Rwt4/Frbc9a1yPXIOuYIwV7HffkDKmdjb4DBbXG/CsV062ze1ogZX6gFDwsaiuGoHyw+rVqCRUI1I5zjB6vUDOAo66jNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgxYooNwz4zOx5a+n20710ZMIJd/Ge5iCRoG7dLWysk=;
 b=IXYARQNYOB6QGRApiJDukaSBLQN7c9UqdqAjoDjjbT5kDVjUn7i69vaLUj3UMpNkamXENeRlr01RXBsYdaRyA0eo9J61uwsfrWwdasJcVwUqzc3bxLsmo2zLRVnyk/eeNZ/TqDdcOLOkGaCdSt0HOWQ/Xj43GBjDg0y03P2t/yw=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by TYZPR03MB7225.apcprd03.prod.outlook.com (2603:1096:400:33c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 08:51:50 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4add:dc54:f62d:e003]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::4add:dc54:f62d:e003%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 08:51:50 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "kbingham@kernel.org" <kbingham@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>
Subject: Re: [PATCH] scripts/gdb: fix 'lx-lsmod' show the wrong size
Thread-Topic: [PATCH] scripts/gdb: fix 'lx-lsmod' show the wrong size
Thread-Index: AQHZo1xmwpM5k4kpiE2XQmDIwwaXNa+pmq2AgAk2IgA=
Date:   Mon, 10 Jul 2023 08:51:50 +0000
Message-ID: <0990cccb0d6361c2d824e4efdefa98a1980cf6b8.camel@mediatek.com>
References: <CGME20230620094846eucas1p21dfc03b10384449dee5e67837ba3e72d@eucas1p2.samsung.com>
         <20230620094834.14688-1-Kuan-Ying.Lee@mediatek.com>
         <aad3e8fb-d16b-3fab-f17b-3e6645c946cd@samsung.com>
In-Reply-To: <aad3e8fb-d16b-3fab-f17b-3e6645c946cd@samsung.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|TYZPR03MB7225:EE_
x-ms-office365-filtering-correlation-id: 4d931edb-82fe-48bd-94ba-08db8122e6f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzmRgwv2Q7jzwSksHhCxkQcTcHpAxXsis1LAEzpssfZzCcw0+BCK5Aq8g0IleRKxuA9gTNv3CHiW0ilm9FbmViTGLXbIt4iUbvq6AzGRr138sbsJ/wLBwLAoCthRHr5UdJG8D0bBufuOcau9e/50LZj1SvFb/N0pnremcJ/R0zgUxDCDtzC6CGV72ZCeaO+p0OFxMoHkugn3jDT2QSvdZNP05OVtCsZ7rv833GMd6xIpzY1vDLqLLY9V8rE4pE785Taiufs76TC+z/RBgJVHhKj6WP+j99N0ra2Ts3uU1kXx/AJTZ36w2bu6xpcZVrAxdS0nfKV9zcFnjUE4ItRHxzHl/JMuuep3Rld1uRvpWw1u7OW32E0fbRh5CISja+vh2RTPqnZTca0mUo+T7mCoUzs9ZFxqnY1Z+GqZ3tKu8wspf0d5RS+8CKocfZ3uCMvX4POqCx495hOOEodn5QTpqtyuLv5MYU3iHE6SuiH4lcrenIAX18HxlhZXtrpZc09zglvxxy1EkDX1JUk6JsllHLiQavC4zLoav1COwLA3xs1TZDnJ61kkyUdM5JlFTpjteFFjpel4wUNDY3W+3dd60p5nItxAzNsGf6G/qhDpyykPxUMa9w4uDSpA9PGGM0jNiBtmFF+9b1ckmNgTlwADab1C/OecHOQvGP9c6e9AKUdRgi0KILpmCkUVqRwpwkGx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(86362001)(38100700002)(38070700005)(36756003)(85182001)(6486002)(110136005)(54906003)(76116006)(71200400001)(91956017)(122000001)(107886003)(6506007)(186003)(6512007)(2616005)(26005)(7416002)(5660300002)(316002)(2906002)(66556008)(478600001)(66946007)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(66476007)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXorUGd2N1IySkdZK2dVd0NGVzJmL01pMFloSWw3c0JmaWVnK0o3SmwwM2xi?=
 =?utf-8?B?akV2QllwN2Rac2J0b0U1S21HMWNPbXc2NnNzUTBTNEJoUkJwMUlydlB5dnk2?=
 =?utf-8?B?K0d1dldLckU1ZzRFbGUxRXVlMFp1aWVNcjZ1K2swbHMzZmxkMG5NWC8xcVFu?=
 =?utf-8?B?M2ZtT2NSSHJ6TFZsc0lrK3dpYWlWV1FlUlJWK0VTS3p0SG04dTRkYUQwQ0dG?=
 =?utf-8?B?dEVkZXZ1QzAyM0JScHZ4aW5FVTB0eW1qTXI5N0t5SjlKZ0pOcTdHbkxLTlEr?=
 =?utf-8?B?UU1LZXpZK1dla09kT0l5c3R4UlZXQ1pmeDFMWEhqQ3JuL2d3WHN0QlFXSzRx?=
 =?utf-8?B?Y0wrQVN5ZzRDV3Q3S2h6ZkphaENWSEM4OGxOa1JzU29sWm5rUzQ1eTZ5U3VD?=
 =?utf-8?B?eFZ6UVorSXd3SWVNMk9FVFZPYUlZU2czYXpGYVJTQi9tR1JZSXNCU05HNHh2?=
 =?utf-8?B?ZVdYeWVnUlg3S1RZaVB2TVdxOHYzNVhpRFJGK2VyV2w0RE0rTDR1Ui9hamVK?=
 =?utf-8?B?c0w3czZmQ3piaHFaaEZvUXlkZjkxTHNJQ09PSWxvc280ckRKMmFKMW56clFQ?=
 =?utf-8?B?c0xSbVNCNkxWbDJkWmhRdTdKYXBZc1lWcGpZR0xZWmFuRkdkdnpDNzVmRDY3?=
 =?utf-8?B?NlhETUw1NVN1YzY0WXlvQkt5dVBaYWcrVzYxYzdxaVB2cHBxM2JaSHl4MjlI?=
 =?utf-8?B?SHBFRmFla0YyQktuUVYra290U0ZuZ2JCNjlhZVVHWVpOaFJIRTJSUDkvdEhG?=
 =?utf-8?B?Q3JsVytsU0VQUXVnMFVpU3VvSzIxZmVLU2Z3cDcrMG9QZXM0SFZwc2toNnJO?=
 =?utf-8?B?b2xtekxmcUV6WFNXSGZtQStwbElaM1pYRHowenRGNXZ2UG96Q0thNFBsQnF1?=
 =?utf-8?B?Q1VHK3ZaS2JWNTB0aDJJRkMxbURTclVrYVVQQ0hzdERaYXZYUDIyajJ2SmJ0?=
 =?utf-8?B?RTBhWm1XcEVpUWs1aGJZV05PK0xPbDJEelE5TFlZOHQxN2M3VzRFV2tmS1Ez?=
 =?utf-8?B?aGVWUFNuS1pDdTdXVit3eFJ6RXZFYmNhQ2h3a2FCc2dvWXg3U3pIbDNid2Fk?=
 =?utf-8?B?VEpvWmxjbWIxakdoU1JnaHNXWTBkdzZzdm9TTmtRcUlmSWx3cDdVUDhxR1BU?=
 =?utf-8?B?S2VlWUNQL01SZGo0SWp5emQ2d2k1NVJ4L0lXdzhrWW5GTVN0cEwzaGlRcHYy?=
 =?utf-8?B?SGFzU2hWRUR6UXN2SmMvR09Fd2wzVXU4SWhLVUpneWx1UkxodUNNU01kZ2Nv?=
 =?utf-8?B?eE9WQVZVbVRBdzhCb0FUQ2pkK1o1NG1hYkdTVTlIR3ZrZ0NaTmlEclpQbnJ6?=
 =?utf-8?B?ZUEvMTVvVUpXZ1N6K2VJS25va2lSR1pLR3ByS0FwWnBIOGdjVnRYNXBPSzJw?=
 =?utf-8?B?VktXYUJYMzZPVXhZR2ZuMjRKSHh3T1c3b0JNbHRyenNVdkJVbmdqMFF1S3JD?=
 =?utf-8?B?Snk1WDV4WktabWxSUmEvd0lGMk4vcGFFUnZjOGFsdGlKS0NpMVZvYjc0ZzQ5?=
 =?utf-8?B?dkRQaThxUDhoU045NkZhMExwYlZQR0tCMUh6RFJwLzNWVGtxeEEvT3hDMnJ4?=
 =?utf-8?B?a0ZjUHFMWDg4MjZ5bmc0VTJwakJIR2wyOEMyU2ZrT2wzWUo0NE9wRkNIVys0?=
 =?utf-8?B?TnU5REpuMjZOdUtsNUhnT1ZCV1pHYnV4TGVIbzhHTEhsNUd5VFd5V2JtaWx1?=
 =?utf-8?B?WkNpVzkvMjhDYUlSdGxFUWJySCtMazREaTJRSEtBYlQyTFVDbmV4S3RhSVFq?=
 =?utf-8?B?bzkzLzB0SWZsVkxpK2ZRb3I5UGd5TlEzTE43ZHd2YjZ3d3hFTUZrd3FLRVN6?=
 =?utf-8?B?eG54TXBXZHZpY3F3OE9uL2QzOEdBUGhZcDlJc0I2cVpvQ216NFMrRVZPT1pS?=
 =?utf-8?B?SlBDWUdRN3BPMGJ2cFNZY0I0UlBlQnFxR2dpNXRpeG96YmFPK3N5SEtBb2Za?=
 =?utf-8?B?TUlTZ3MxbWJlbWdUN050Sm9TaHpOT2JCK3RSVktiYlJaOU9qajRyelMzbHli?=
 =?utf-8?B?QlFWYkdHRlNoaHNPVzc5bXZ3VHgyMFJscU1JZXZOZTBxTHBNZWQzUGRwM1Fv?=
 =?utf-8?B?bGJMdnEvVFB3ZXhEQWxiaTJOZDlXckdjQ0w4ZlB1Wi96VTlhN1h1Zmc1U0tY?=
 =?utf-8?B?YlpBTTdUU1VhY2FYd1o2NU41UVM2cTh4T2FOU2hFSEhMTTJPSWF6a0NVTG8r?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE11DE40705B90489F0333838C6C2D01@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d931edb-82fe-48bd-94ba-08db8122e6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 08:51:50.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wmR4zfIl37I8rowutDN1Qg6GWDDambbZUT7GRqHNKCSiCnAK+/V2IMOXPs2p//k9mougIeVYldXDAbFT5U9cy/sDAsMvsGVL94gGvtIze4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7225
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDE0OjExICswMjAwLCBQYW5rYWogUmFnaGF2IHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gID4gJ2xzbW9kJyBzaG93cyB0b3RhbCBjb3JlIGxheW91dCBzaXplLCBz
byB3ZSBuZWVkIHRvDQo+ID4gc3VtIHVwIGFsbCB0aGUgc2VjdGlvbnMgaW4gY29yZSBsYXlvdXQg
aW4gZ2RiIHNjcmlwdHMuDQo+ID4gDQo+ID4gLyAjIGxzbW9kDQo+ID4ga2FzYW5fdGVzdCAyMDA3
MDQgMCAtIExpdmUgMHhmZmZmODAwMDdmNjQwMDAwDQo+ID4gDQo+ID4gQmVmb3JlIHBhdGNoOg0K
PiA+IChnZGIpIGx4LWxzbW9kDQo+ID4gQWRkcmVzcyAgICAgICAgICAgIE1vZHVsZSAgICAgICAg
ICAgICAgICAgIFNpemUgIFVzZWQgYnkNCj4gPiAweGZmZmY4MDAwN2Y2NDAwMDAga2FzYW5fdGVz
dCAgICAgICAgICAgICAzNjg2NCAgMA0KPiA+IA0KPiA+IEFmdGVyIHBhdGNoOg0KPiA+IChnZGIp
IGx4LWxzbW9kDQo+ID4gQWRkcmVzcyAgICAgICAgICAgIE1vZHVsZSAgICAgICAgICAgICAgICAg
IFNpemUgIFVzZWQgYnkNCj4gPiAweGZmZmY4MDAwN2Y2NDAwMDAga2FzYW5fdGVzdCAgICAgICAg
ICAgIDIwMDcwNCAgMA0KPiA+IA0KPiA+IEZpeGVzOiBiNGFmZjc1MTNkZjMgKCJzY3JpcHRzL2dk
YjogdXNlIG1lbSBpbnN0ZWFkIG9mIGNvcmVfbGF5b3V0DQo+IHRvIGdldCB0aGUgbW9kdWxlIGFk
ZHJlc3MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEt1YW4tWWluZyBMZWUgPEt1YW4tWWluZy5MZWVA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gSnVzdCBvbmUgbWlub3IgY29tbWVudCwgYnV0
IGFwYXJ0IGZyb20gdGhhdCwgZmVlbCBmcmVlIHRvIGFkZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBQ
YW5rYWogUmFnaGF2IDxwLnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4gDQo+ID4gZGlmZiAtLWdpdCBh
L3NjcmlwdHMvZ2RiL2xpbnV4L21vZHVsZXMucHkNCj4gYi9zY3JpcHRzL2dkYi9saW51eC9tb2R1
bGVzLnB5DQo+ID4gaW5kZXggMjYxZjI4NjQwZjRjLi44NDkzM2M0YzEwODMgMTAwNjQ0DQo+ID4g
LS0tIGEvc2NyaXB0cy9nZGIvbGludXgvbW9kdWxlcy5weQ0KPiA+ICsrKyBiL3NjcmlwdHMvZ2Ri
L2xpbnV4L21vZHVsZXMucHkNCj4gPiBAQCAtNzMsMTEgKzczLDE3IEBAIGNsYXNzIEx4THNtb2Qo
Z2RiLkNvbW1hbmQpOg0KPiA+ICAgICAgICAgICAgICAgICAgIiAgICAgICAgIiBpZiB1dGlscy5n
ZXRfbG9uZ190eXBlKCkuc2l6ZW9mID09IDgNCj4gZWxzZSAiIikpDQo+ID4gIA0KPiA+ICAgICAg
ICAgIGZvciBtb2R1bGUgaW4gbW9kdWxlX2xpc3QoKToNCj4gPiAtICAgICAgICAgICAgbGF5b3V0
ID0gbW9kdWxlWydtZW0nXVtjb25zdGFudHMuTFhfTU9EX1RFWFRdDQo+ID4gKyAgICAgICAgICAg
IHRvdGFsX3NpemUgPSAwDQo+ID4gKyAgICAgICAgICAgIGZvciBpIGluIHJhbmdlKGNvbnN0YW50
cy5MWF9NT0RfVEVYVCwNCj4gY29uc3RhbnRzLkxYX01PRF9ST19BRlRFUl9JTklUICsgMSk6DQo+
ID4gKyAgICAgICAgICAgICAgICBsYXlvdXQgPSBtb2R1bGVbJ21lbSddW2ldDQo+ID4gKyAgICAg
ICAgICAgICAgICBpZiBpID09IGNvbnN0YW50cy5MWF9NT0RfVEVYVDoNCj4gPiArICAgICAgICAg
ICAgICAgICAgICB0ZXh0X2FkZHIgPSBzdHIobGF5b3V0WydiYXNlJ10pLnNwbGl0KClbMF0NCj4g
PiArICAgICAgICAgICAgICAgIHRvdGFsX3NpemUgKz0gbGF5b3V0WydzaXplJ10NCj4gPiArDQo+
ID4gICAgICAgICAgICAgIGdkYi53cml0ZSgie2FkZHJlc3N9IHtuYW1lOjwxOX0NCj4ge3NpemU6
Pjh9ICB7cmVmfSIuZm9ybWF0KA0KPiA+IC0gICAgICAgICAgICAgICAgYWRkcmVzcz1zdHIobGF5
b3V0WydiYXNlJ10pLnNwbGl0KClbMF0sDQo+ID4gKyAgICAgICAgICAgICAgICBhZGRyZXNzPXRl
eHRfYWRkciwNCj4gPiAgICAgICAgICAgICAgICAgIG5hbWU9bW9kdWxlWyduYW1lJ10uc3RyaW5n
KCksDQo+ID4gLSAgICAgICAgICAgICAgICBzaXplPXN0cihsYXlvdXRbJ3NpemUnXSksDQo+ID4g
KyAgICAgICAgICAgICAgICBzaXplPXN0cih0b3RhbF9zaXplKSwNCj4gPiAgICAgICAgICAgICAg
ICAgIHJlZj1zdHIobW9kdWxlWydyZWZjbnQnXVsnY291bnRlciddIC0gMSkpKQ0KPiA+ICANCj4g
PiAgICAgICAgICAgICAgdCA9IHNlbGYuX21vZHVsZV91c2VfdHlwZS5nZXRfdHlwZSgpLnBvaW50
ZXIoKQ0KPiANCj4gV2UgY291bGQgc2xpZ2h0bHkgbW9kaWZ5IHRoZSBjb2RlIHRvIHJlbW92ZSB0
aGUgc3BlY2lhbCBjb25kaXRpb24NCj4gd2l0aCBgaSA9PSBjb25zdGFudHMuTFhfTU9EX1RFWFRg
Og0KPiANCj4gKEkgbWFkZSBjaGFuZ2VzIG9uIHRvcCBvZiB5b3VyIHBhdGNoKQ0KDQpUaGFua3Mg
Zm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkkgd2lsbCB1cGxvYWQgdjIuDQoNCj4gDQo+IGRpZmYgLS1n
aXQgYS9zY3JpcHRzL2dkYi9saW51eC9tb2R1bGVzLnB5DQo+IGIvc2NyaXB0cy9nZGIvbGludXgv
bW9kdWxlcy5weQ0KPiBpbmRleCA4NDkzM2M0YzEwODMuLmY3NmE0M2JmYTE1ZiAxMDA2NDQNCj4g
LS0tIGEvc2NyaXB0cy9nZGIvbGludXgvbW9kdWxlcy5weQ0KPiArKysgYi9zY3JpcHRzL2dkYi9s
aW51eC9tb2R1bGVzLnB5DQo+IEBAIC03MywxMiArNzMsMTIgQEAgY2xhc3MgTHhMc21vZChnZGIu
Q29tbWFuZCk6DQo+ICAgICAgICAgICAgICAgICAgIiAgICAgICAgIiBpZiB1dGlscy5nZXRfbG9u
Z190eXBlKCkuc2l6ZW9mID09IDggZWxzZQ0KPiAiIikpDQo+IA0KPiAgICAgICAgICBmb3IgbW9k
dWxlIGluIG1vZHVsZV9saXN0KCk6DQo+ICsgICAgICAgICAgICB0ZXh0ID0gbW9kdWxlWydtZW0n
XVtjb25zdGFudHMuTFhfTU9EX1RFWFRdDQo+ICsgICAgICAgICAgICB0ZXh0X2FkZHIgPSBzdHIo
dGV4dFsnYmFzZSddKS5zcGxpdCgpWzBdDQo+ICAgICAgICAgICAgICB0b3RhbF9zaXplID0gMA0K
PiArDQo+ICAgICAgICAgICAgICBmb3IgaSBpbiByYW5nZShjb25zdGFudHMuTFhfTU9EX1RFWFQs
DQo+IGNvbnN0YW50cy5MWF9NT0RfUk9fQUZURVJfSU5JVCArIDEpOg0KPiAtICAgICAgICAgICAg
ICAgIGxheW91dCA9IG1vZHVsZVsnbWVtJ11baV0NCj4gLSAgICAgICAgICAgICAgICBpZiBpID09
IGNvbnN0YW50cy5MWF9NT0RfVEVYVDoNCj4gLSAgICAgICAgICAgICAgICAgICAgdGV4dF9hZGRy
ID0gc3RyKGxheW91dFsnYmFzZSddKS5zcGxpdCgpWzBdDQo+IC0gICAgICAgICAgICAgICAgdG90
YWxfc2l6ZSArPSBsYXlvdXRbJ3NpemUnXQ0KPiArICAgICAgICAgICAgICAgIHRvdGFsX3NpemUg
Kz0gbW9kdWxlWydtZW0nXVtpXVsnc2l6ZSddDQo+IA0KPiAgICAgICAgICAgICAgZ2RiLndyaXRl
KCJ7YWRkcmVzc30ge25hbWU6PDE5fQ0KPiB7c2l6ZTo+OH0gIHtyZWZ9Ii5mb3JtYXQoDQo+ICAg
ICAgICAgICAgICAgICAgYWRkcmVzcz10ZXh0X2FkZHIsDQo=
