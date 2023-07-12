Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83074FD84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGLDNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGLDNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:13:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E210D4;
        Tue, 11 Jul 2023 20:13:10 -0700 (PDT)
X-UUID: 03933eea206211eeb20a276fd37b9834-20230712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=g990LKFPEcW5ByOmHfWp2eYBFcP47BxW3pLvUcc1jYI=;
        b=A2FovTsQlx6O/wF/cdYBwkZ8fJQc+WLUEe/Sh1/Ew8/fO6COfC6FtaGFyHncLqRFuRj6GyWWpnzDS2saJCSMX2HXkJquY0ZvQYhaCA0fUuIWfbSjuw5zfNjocKi2J5egZcJ+Y8lRhFEqBopJDngGTDKj9sc/dSbCM8/KxbFL+dM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:0bb54b9b-e875-4525-aaae-0b23a77d0412,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:0bb54b9b-e875-4525-aaae-0b23a77d0412,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:1dce210e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230712041627N8Z41WWU,BulkQuantity:6,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,
        TF_CID_SPAM_SNR
X-UUID: 03933eea206211eeb20a276fd37b9834-20230712
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1239431593; Wed, 12 Jul 2023 11:13:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jul 2023 11:13:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jul 2023 11:13:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWa9H8BhjufT7CnbcT4RSk7FBGDld1vtJDFG9xLyG2GY2nxvCmU/j8sNduKTyCuOkY7aHdNCoIg1m4Ipy6afdiPKwBfy/+nkl17pdUsE2O01heeV3fTuYGzNyypJfWCwMh45IlOY7pdDHnW207KYvLLsmNz6l+4okgrdFIA4pVaCOgW34F5h1whRK1nDSb4GYUuz/k34ePzThMI+BMJmARTxhf+IZx5z7Fc5rLFxxnvVk0Nem9k1gu3C6bvJLaFxEo9aaWRnsDXPzggvuClGHuN8YZ9hM1iFZKenzpbukr3H20a14XZvbexpbh+JO15/ucS55TNlhc5h4vN/zS4GgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g990LKFPEcW5ByOmHfWp2eYBFcP47BxW3pLvUcc1jYI=;
 b=iLtkfz/Ff9gmPVMojjZlkA0/Axgax0is/yhw3Wb1VfH6AEpx5hV1CZ6XP2u4tZ9iQNffFN2zXOTw077is6yqhuIcm190i3i8tVvTJaMClFmoWAFRAwqfGgHtST5yw/QPanptw4gDMEHAfyLmgLC5yXGLMV/QpNKNuyhR89hl1QnYKW3AVulNmsnseZ4IrLcQfeTm1TvFUxJPtycGa81bBpfRxPqdLkTU56oUMkRcPdI0FV+Mdn6xyEu8PnYqE5m1+iWY1+AA463BjswNjpTbT2Px+8n2REbUjwEdN+nYosORPJKBXlVo4uWQJ2QX6SdCeNbWykHPK7GQVVZEBU4Log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g990LKFPEcW5ByOmHfWp2eYBFcP47BxW3pLvUcc1jYI=;
 b=dcxfrCwCO23ZoI56xL+dt7ZBSLLqb3xM2Uy75I8FEjOHZcut+TjiwDUF3BsxTjYJqxZIlvpl0hfc6QvsGO5O5d7EskSY7WCNgocFWowB9E+RKh494TGZYOF6Zc0YhjHngr1FRENgFkwQyS1XgEW4ZLBgl0XiB0C36PNVfIpcMqo=
Received: from TY2PR03MB4157.apcprd03.prod.outlook.com (2603:1096:404:af::20)
 by SEYPR03MB7664.apcprd03.prod.outlook.com (2603:1096:101:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 03:12:59 +0000
Received: from TY2PR03MB4157.apcprd03.prod.outlook.com
 ([fe80::54c0:a116:f88e:716c]) by TY2PR03MB4157.apcprd03.prod.outlook.com
 ([fe80::54c0:a116:f88e:716c%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 03:12:59 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?utf-8?B?TWluZ2ppYSBaaGFuZyAo5byg5piO5L2zKQ==?= 
        <Mingjia.Zhang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] media: mediatek: vcodec: Add capture format to
 support 10bit tile mode
Thread-Topic: [PATCH 1/3] media: mediatek: vcodec: Add capture format to
 support 10bit tile mode
Thread-Index: AQHZs/dmuWZMCwuxpEaKw0cDTeniVa+1ASKAgAB0cwA=
Date:   Wed, 12 Jul 2023 03:12:58 +0000
Message-ID: <da954d28f48319a4bad181eda8bf091356a19d18.camel@mediatek.com>
References: <20230711125749.15555-1-yunfei.dong@mediatek.com>
         <20230711125749.15555-2-yunfei.dong@mediatek.com>
         <c68c63924a2aed6c98818d3ad3b39e065cbd0b15.camel@collabora.com>
In-Reply-To: <c68c63924a2aed6c98818d3ad3b39e065cbd0b15.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR03MB4157:EE_|SEYPR03MB7664:EE_
x-ms-office365-filtering-correlation-id: 688faa3d-d164-4ede-3f41-08db8285e531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFmu5iDoDkaAv5mUuG9raFivvUFr1fX71h1fbaeWj51sMVf9X5B2jN+F6BjuZ82yfUBRQ8L0yGrh5Crhc9VIm78Ajklgwf967UJJBkMZineHoasvGCWyc2SaG4c3DFIV/v9IkOD2fxd+y4WuASj4tXXo7Ch9jbj+FI29/lehabtSXKzxcI4vGEnKr/TaJtgKi064vQ8N6MnQIo3fSNJ+gr3HapI2DfapR+ZI+BdeEKsRVJ7Jex16xQBZ0gRbuVuOoI+m09HHohVQ9il8R1UcLf2urvBCC1vdzDOKKssfzs8dKAcWgRaNUWs/RXrtZ1vqEuKiHLhugqM1CX9sAs3uz5LNYG8UJQp0iCWvw1f1nmC2xxxKjcouU6wiDd3XF5m9KTu/TnbTEPE15s6AbD2bu1IEsZp1BzEvj2hqIeRwlrD5GJnHH46Jnv38T01dYU008MvUZAas3+eg8MkN75e4stMAee2Os8LaBtDJuXlg7E8A9Br4Rdmb88WGHvbxyaVS8eMLiIUIdX8356BNfnmViP8IPgXr2yM551Tl630UkUpKXK1qViFMlzT0A81hiWtGzKdbB0j6LjPiIGJUN7iKJ+3n61cZ0AOSz8LXhNkodCKTQ1nCGbyUunn+YOC8nY9crtczRinV8486OwnuDTuC3b/WJjULg/NuvSviyTldXtJGhs91zvIuUEApgoVK/cnny1cTkW0Mye9MPYGJRXAcrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR03MB4157.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(91956017)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(4326008)(966005)(122000001)(38100700002)(86362001)(186003)(6506007)(38070700005)(2616005)(26005)(83380400001)(66574015)(36756003)(478600001)(85182001)(6512007)(6486002)(54906003)(110136005)(41300700001)(7416002)(8676002)(8936002)(5660300002)(71200400001)(2906002)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZGaVFDV2ZJSHNlSUR0MFpKSWZRUXNPNG8xSUR2bFNvWjFLWE9ETklXQjlz?=
 =?utf-8?B?TVFpd2JWUXNFNHRhZ0FydDI5NUZvcFJwdHl1Tk1xblZwZkRTWENHUVJVTlB6?=
 =?utf-8?B?RlFxc1h3czVDdEZndHA3TmhoQ0pNeU13ZnlWaWFvTlcveXM5Uk56d0JwQ3BM?=
 =?utf-8?B?eXFxMTAwbExOUDJFUEU0cFY3R2VMMzZmUGloNTJQQWRIcjdZaXR3OUVMVnZn?=
 =?utf-8?B?RWtTaXcwQzRJV0VPNVdHUk9rQVZmWnJ6UHJ3eXVZUUY4ckdVbHp2dXhwUElZ?=
 =?utf-8?B?YmNaaDFlY1NTZ01aakZJaUI2UHByK2pyRlpiT3JLNjk2czBTVUlDMkRZSU9O?=
 =?utf-8?B?QW9BTE45SEJlbHVxQzU1WFpyeSswRWVGZkZXeGdKNzZBb0FWdEltajRaa1o2?=
 =?utf-8?B?cUJLYlNaZUtNSEVCelJxUFlUNHloQWt4Nk9KOXE3N0VSR0RVWDcwcXh4a3NO?=
 =?utf-8?B?MzZtTThDa2FTYXJGV3oxL0VLYk5DVERTd0FiTUhFRGswY21Ncm9LSWhoZm8y?=
 =?utf-8?B?NWtXczFGK1RmeGowamthU2xwYmNnS1k3bTQ5eG5Bc0huTm80Y3d2SXplN1R3?=
 =?utf-8?B?L255ZDN1TWVZSFR1WmtIUHZQcWtXaVZuRGJvY0R4OWNRQUJoa08yVk8wQlN0?=
 =?utf-8?B?VHlyM3pCT0kyNEJmamR0Vm54TDZ1Q0hIQmtVNTBTcGd0eWxya3ZZOU5DV3Qr?=
 =?utf-8?B?c1R3R1hKRnhqVmFuZWpCZ1JHaTA3MERyVmFuSEdReWJNL01RQVJhMnc4YnEr?=
 =?utf-8?B?dTM4ZGtoNDQ5YlpVVThoMUdrMXFpajM5WUcvTG5xUE9PQTEySzFIOHVzWnpj?=
 =?utf-8?B?K3BPTVAwd0hxSEJ6OFBZNTJKc3ZKalVVdjVYakFSYTNpVW9qR2xnSEdDMXR1?=
 =?utf-8?B?WlU5MVliQnRNSDN4a2tBUlF0YnhNdSt4YWE0eDB1bkk4QmRwdFltU2tyc21N?=
 =?utf-8?B?TDMyMGl0dnRRNzNhTHRlOWxlMXdnYzhyanFSbFBROXJSNXFzelNselhmODc5?=
 =?utf-8?B?UnFXWWVVUHB4S3ZvSFI5aXJWVVVTNzRZZFVleUtpMDV4cnFzZ01RSjhiM3ZB?=
 =?utf-8?B?aHZTVEMrRkFmRVhlQXFncHR3NVZjWU1hWmQzaFQ2NXRjbGRTdWZQMk5qc2ta?=
 =?utf-8?B?aEdqd2Q2TTNWL1BjTXk2aEEvallnMlB6MlNhQWh0czhTWFZhUkV0TUQ3OFg2?=
 =?utf-8?B?dXlqWjU3czdUQ2sxSjlBUWlsZVplRjVUTU9PM0hXYnd4Z1hCU0VuTUN6STly?=
 =?utf-8?B?TWJ3L3g2bnlsYkNKYklTVWwwL0g3d1ZNZFBjZlpvR2VudWd3VjlDc2pxNTFX?=
 =?utf-8?B?enc4alFzd1V5WlZzZk5LQzRBay9Qd2NscmVKdnEycjJPaktERVl2bTBBVGl4?=
 =?utf-8?B?QjQzbHpoMlBHdENrUllYRzV0OWc4MWVDdEtTRTFJZG5rdG1UYVY5OU9Jelhn?=
 =?utf-8?B?Z2RTRmJOMHZicVB2YjRXbnA2OTBaK1JjdDllSkt3ZXNvT25mYmgxZ3pBMXVq?=
 =?utf-8?B?YUVkZHVhY0pRV1hqbnBqY0Z0c0tlUStaZWExQ2RxNENIcEcyZ1paTVhHTk5u?=
 =?utf-8?B?c05xOWs4YW85cHRlTDRCb1JwejkzaXRnY1h4cHF6a2llb2RLdTUwd0piNVNs?=
 =?utf-8?B?a3RqTFRjSE1wbFRRNjhGa2lxRG9pL1ZDaVpadGdIeVdqQWZFZ0YxNThKbWtt?=
 =?utf-8?B?R2RCaHFhcVdKWS9mR0t4RVVOTG1wVm9xTUxJeDZtOCt3bFI2NHhyMWRyQmRa?=
 =?utf-8?B?Tjk5NXhwbmlPWXE2dnRsb0tSbCtRdld5NlFWOGJmL2NybnEvZ2F0MytDQ3dM?=
 =?utf-8?B?M1JOYTRJdWJkVnpwUndKZ2xGNXl6bzJ4R2ZzRElvcE9xelRVKzRpdjduNTBq?=
 =?utf-8?B?SXVobjZHYkxYQVZRMUFoNDdUc3lEdVBSalRzcHI3RWNIb3N2UnU4RmJtRk9E?=
 =?utf-8?B?ZUh5RTRhdTBIdWFLSUlHeVA1TWMyUkMrWWNiWEc1MEZjM1Yxa05NbHBHNCtP?=
 =?utf-8?B?Sy9WSkNvQnBzYVJYTEU3K2NRTWdGdnkwU2svVUlMNDY3aGNmelNVK2FGUnNY?=
 =?utf-8?B?bFZ5d01Xa0tGVzhlY1QwbXVtVWxYL2I4cWV4OWpsMDM4WGkyWXE0SHN0NXJE?=
 =?utf-8?B?SkV1SUlmcDRPSmFmVHkycHJMZ2ZrTURGR1g2aXZoSDRyNUMrWVd5TVU2ZHVy?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF204CA1F5AF1847B64784BF8B449FC5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR03MB4157.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688faa3d-d164-4ede-3f41-08db8285e531
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 03:12:58.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjUAKt/JekgPWLo/VyzJSFc5tQbagOOOCEynX0uyTU6iHH1/Nea9eAWVkMfmWsYJF+h+wyET+SoHo9zeG+X5jUG+cGjZH3NoUsESvhoX9Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7664
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

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNCk9uIFR1ZSwgMjAy
My0wNy0xMSBhdCAxNjoxNiAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gIAkgDQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ICBMZSBtYXJkaSAxMSBqdWlsbGV0IDIwMjMgw6AgMjA6NTcgKzA4MDAsIFl1bmZlaSBE
b25nIGEgw6ljcml0IDoNCj4gPiBGcm9tOiBNaW5namlhIFpoYW5nIDxtaW5namlhLnpoYW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBEZWZpbmUgb25lIHVuY29tcHJlc3NlZCBjYXB0dXJlIGZv
cm1hdCBWNEwyX1BJWF9GTVRfTVQyMTEwVCBpbg0KPiBvcmRlciB0bw0KPiA+IHN1cHBvcnQgMTBi
aXQgZm9yIEFWMS9WUDkvSEVWQyBpbiBtdDgxOTUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
TWluZ2ppYSBaaGFuZyA8bWluZ2ppYS56aGFuZ0BtZWRpYXRlay5jb20+DQo+ID4gQ28tZGV2ZWxv
cGVkLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LXJlc2Vy
dmVkLnJzdCB8IDgNCj4gKysrKysrKysNCj4gPiAgZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRs
Mi1jb21tb24uYyAgICAgICAgICAgICAgICAgICAgIHwgMiArKw0KPiA+ICBkcml2ZXJzL21lZGlh
L3Y0bDItY29yZS92NGwyLWlvY3RsLmMgICAgICAgICAgICAgICAgICAgICAgfCAxICsNCj4gPiAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMSArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZt
dC0NCj4gcmVzZXJ2ZWQucnN0IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0
bC9waXhmbXQtDQo+IHJlc2VydmVkLnJzdA0KPiA+IGluZGV4IDU4ZjZhZTI1YjJlNy4uYjE2YTcy
NTc1ODBjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRp
YS92NGwvcGl4Zm10LXJlc2VydmVkLnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vdXNlcnNw
YWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LXJlc2VydmVkLnJzdA0KPiA+IEBAIC0yNzUsNiArMjc1
LDE0IEBAIHBsZWFzZSBtYWtlIGEgcHJvcG9zYWwgb24gdGhlIGxpbnV4LW1lZGlhDQo+IG1haWxp
bmcgbGlzdC4NCj4gPiAgDQo+ID4gICAgICAgICAgRGVjb2RlcidzIGltcGxlbWVudGF0aW9uIGNh
biBiZSBmb3VuZCBoZXJlLA0KPiA+ICAgICAgICAgIGBhc3BlZWRfY29kZWMgPA0KPiBodHRwczov
L2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvYXNwZWVkX2NvZGVjLz5gX18NCj4gPiArICAgICog
Li4gX1Y0TDItUElYLUZNVC1NVDIxMTBUOg0KPiA+ICsNCj4gPiArICAgICAgLSBgYFY0TDJfUElY
X0ZNVF9NVDIxMTBUYGANCj4gPiArICAgICAgLSAnTVQyMTEwVCcNCj4gPiArICAgICAgLSBUd28t
cGxhbmFyIDEwLUJpdCB0aWxlIG1vZGUgWVZVNDIwIGZvcm1hdCB1c2VkIGJ5IE1lZGlhdGVrDQo+
IE1UODE5NSwgTVQ4MTg4DQo+ID4gKyAgICAgICAgYW5kIG1vcmUuIFRoaXMgZm9ybWF0IGhhdmUg
c2ltaWxpdHVkZSB3aXRoDQo+IGBgVjRMMl9QSVhfRk1UX01NMjFgYC4NCj4gPiArICAgICAgICBJ
dCByZW1haW5zIGFuIG9wYXF1ZSBpbnRlcm1lZGlhdGUgZm9ybWF0IGFuZCBpdCBpcyB1c2VkDQo+
IGZvciBWUDksIEFWMQ0KPiA+ICsgICAgICAgIGFuZCBIRVZDLg0KPiANCj4gRG9jdW1lbnRpbmcg
dW5jb21wcmVzc2VkIHZpZGVvIGZvcm1hdHMgYXMgIm9wYXF1ZSIgaXMgYWx3YXlzIGxhc3QNCj4g
cmVzb3J0IGluDQo+IFY0TDIuIFRoZXJlIGlzIG5vIGp1c3RpZmljYXRpb24gaGVyZSBzaW5jZSB0
aGlzIGZvcm1hdCBpcyBhbHJlYWR5DQo+IGltcGxlbWVudGVkIGluDQo+IHNvZnR3YXJlIGFuZCBw
ZW5kaW5nIGluIEdTdHJlYW1lciAoc28gaXRzIHdlbGwgdW5kZXJzdG9vZCBmb3JtYXQpLiBJDQo+
IHdpbGwgdHJ5DQo+IGFuZCBwcm92aWRlIHNvbWUgYmV0dGVyIGRvYyBmb3IgeW91IHRvIGluY2x1
ZGUuDQo+IA0KPiANCmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9nc3RyZWFtZXIvZ3N0
cmVhbWVyLy0vbWVyZ2VfcmVxdWVzdHMvMzQ0NA0KPiANCkl0J3MgbXVjaCBiZXR0ZXIgaWYgeW91
IGNhbiBwcm92aWRlciB0aGUgYmV0dGVyIGRvYyB0byBtZS4NClRoYW5rcyB5b3UgYWdhaW4uDQoN
CkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQoNCj4gPiAgLi4gcmF3OjogbGF0ZXgNCj4gPiAg
DQo+ID4gICAgICBcbm9ybWFsc2l6ZQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3Y0
bDItY29yZS92NGwyLWNvbW1vbi5jDQo+IGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1j
b21tb24uYw0KPiA+IGluZGV4IGJlZTE1MzViMDRkMy4uODY5ZmMwOWEyMTBiIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY29tbW9uLmMNCj4gPiArKysgYi9k
cml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWNvbW1vbi5jDQo+ID4gQEAgLTI2Miw2ICsyNjIs
OCBAQCBjb25zdCBzdHJ1Y3QgdjRsMl9mb3JtYXRfaW5mbw0KPiAqdjRsMl9mb3JtYXRfaW5mbyh1
MzIgZm9ybWF0KQ0KPiA+ICB7IC5mb3JtYXQgPSBWNEwyX1BJWF9GTVRfVllVWSwgICAgLnBpeGVs
X2VuYyA9IFY0TDJfUElYRUxfRU5DX1lVViwNCj4gLm1lbV9wbGFuZXMgPSAxLCAuY29tcF9wbGFu
ZXMgPSAxLCAuYnBwID0geyAyLCAwLCAwLCAwIH0sIC5icHBfZGl2ID0NCj4geyAxLCAxLCAxLCAx
IH0sIC5oZGl2ID0gMiwgLnZkaXYgPSAxIH0sDQo+ID4gIHsgLmZvcm1hdCA9IFY0TDJfUElYX0ZN
VF9ZMjEyLCAgICAucGl4ZWxfZW5jID0gVjRMMl9QSVhFTF9FTkNfWVVWLA0KPiAubWVtX3BsYW5l
cyA9IDEsIC5jb21wX3BsYW5lcyA9IDEsIC5icHAgPSB7IDQsIDAsIDAsIDAgfSwgLmJwcF9kaXYg
PQ0KPiB7IDEsIDEsIDEsIDEgfSwgLmhkaXYgPSAyLCAudmRpdiA9IDEgfSwNCj4gPiAgeyAuZm9y
bWF0ID0gVjRMMl9QSVhfRk1UX1lVVjQ4XzEyLCAucGl4ZWxfZW5jID0NCj4gVjRMMl9QSVhFTF9F
TkNfWVVWLCAubWVtX3BsYW5lcyA9IDEsIC5jb21wX3BsYW5lcyA9IDEsIC5icHAgPSB7IDYsIDAs
DQo+IDAsIDAgfSwgLmJwcF9kaXYgPSB7IDEsIDEsIDEsIDEgfSwgLmhkaXYgPSAxLCAudmRpdiA9
IDEgfSwNCj4gPiAreyAuZm9ybWF0ID0gVjRMMl9QSVhfRk1UX01UMjExMFQsIC5waXhlbF9lbmMg
PSBWNEwyX1BJWEVMX0VOQ19ZVVYsDQo+IC5tZW1fcGxhbmVzID0gMiwgLmNvbXBfcGxhbmVzID0g
MiwgLmJwcCA9IHsgNSwgMTAsIDAsIDAgfSwgLmJwcF9kaXYgPQ0KPiB7IDQsIDQsIDEsIDEgfSwg
LmhkaXYgPSAyLCAudmRpdiA9IDIsDQo+ID4gKyAgLmJsb2NrX3cgPSB7IDE2LCA4LCAwLCAwIH0s
IC5ibG9ja19oID0geyAzMiwgMTYsIDAsIDAgfX0sDQo+ID4gIA0KPiA+ICAvKiBZVVYgcGxhbmFy
IGZvcm1hdHMgKi8NCj4gPiAgeyAuZm9ybWF0ID0gVjRMMl9QSVhfRk1UX05WMTIsICAgIC5waXhl
bF9lbmMgPSBWNEwyX1BJWEVMX0VOQ19ZVVYsDQo+IC5tZW1fcGxhbmVzID0gMSwgLmNvbXBfcGxh
bmVzID0gMiwgLmJwcCA9IHsgMSwgMiwgMCwgMCB9LCAuYnBwX2RpdiA9DQo+IHsgMSwgMSwgMSwg
MSB9LCAuaGRpdiA9IDIsIC52ZGl2ID0gMiB9LA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92
NGwyLWlvY3RsLmMNCj4gPiBpbmRleCAwMWJhMjdmMmVmODcuLmY0NjVjMGUzZDZlMyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4gPiArKysg
Yi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4gPiBAQCAtMTUwOCw2ICsx
NTA4LDcgQEAgc3RhdGljIHZvaWQgdjRsX2ZpbGxfZm10ZGVzYyhzdHJ1Y3QNCj4gdjRsMl9mbXRk
ZXNjICpmbXQpDQo+ID4gIGNhc2UgVjRMMl9QSVhfRk1UX1FDMTBDOmRlc2NyID0gIlFDT00gQ29t
cHJlc3NlZCAxMC1iaXQgRm9ybWF0IjsNCj4gYnJlYWs7DQo+ID4gIGNhc2UgVjRMMl9QSVhfRk1U
X0FKUEc6ZGVzY3IgPSAiQXNwZWVkIEpQRUciOyBicmVhazsNCj4gPiAgY2FzZSBWNEwyX1BJWF9G
TVRfQVYxX0ZSQU1FOmRlc2NyID0gIkFWMSBGcmFtZSI7IGJyZWFrOw0KPiA+ICtjYXNlIFY0TDJf
UElYX0ZNVF9NVDIxMTBUOmRlc2NyID0gIk1lZGlhdGVrIDEwYml0IFRpbGUgTW9kZSI7DQo+IGJy
ZWFrOw0KPiA+ICBkZWZhdWx0Og0KPiA+ICBpZiAoZm10LT5kZXNjcmlwdGlvblswXSkNCj4gPiAg
cmV0dXJuOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgN
Cj4gYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4gPiBpbmRleCAzYWY2YTgyZDBj
YWQuLjhjN2Q3MWFmYmRjNyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlk
ZW9kZXYyLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4gPiBA
QCAtNzk2LDYgKzc5Niw3IEBAIHN0cnVjdCB2NGwyX3BpeF9mb3JtYXQgew0KPiA+ICAjZGVmaW5l
IFY0TDJfUElYX0ZNVF9aMTYgICAgICB2NGwyX2ZvdXJjYygnWicsICcxJywgJzYnLCAnICcpIC8q
DQo+IERlcHRoIGRhdGEgMTYtYml0ICovDQo+ID4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX01UMjFD
ICAgIHY0bDJfZm91cmNjKCdNJywgJ1QnLCAnMicsICcxJykgLyoNCj4gTWVkaWF0ZWsgY29tcHJl
c3NlZCBibG9jayBtb2RlICAqLw0KPiA+ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9NTTIxICAgICB2
NGwyX2ZvdXJjYygnTScsICdNJywgJzInLCAnMScpIC8qDQo+IE1lZGlhdGVrIDgtYml0IGJsb2Nr
IG1vZGUsIHR3byBub24tY29udGlndW91cyBwbGFuZXMgKi8NCj4gPiArI2RlZmluZSBWNEwyX1BJ
WF9GTVRfTVQyMTEwVCAgdjRsMl9mb3VyY2MoJ00nLCAnVCcsICcyJywgJ1QnKSAvKg0KPiBNZWRp
YXRlayAxMC1iaXQgYmxvY2sgdGlsZSBtb2RlICovDQo+ID4gICNkZWZpbmUgVjRMMl9QSVhfRk1U
X0lOWkkgICAgIHY0bDJfZm91cmNjKCdJJywgJ04nLCAnWicsICdJJykgLyoNCj4gSW50ZWwgUGxh
bmFyIEdyZXlzY2FsZSAxMC1iaXQgYW5kIERlcHRoIDE2LWJpdCAqLw0KPiA+ICAjZGVmaW5lIFY0
TDJfUElYX0ZNVF9DTkY0ICAgICB2NGwyX2ZvdXJjYygnQycsICdOJywgJ0YnLCAnNCcpIC8qDQo+
IEludGVsIDQtYml0IHBhY2tlZCBkZXB0aCBjb25maWRlbmNlIGluZm9ybWF0aW9uICovDQo+ID4g
ICNkZWZpbmUgVjRMMl9QSVhfRk1UX0hJMjQwICAgIHY0bDJfZm91cmNjKCdIJywgJ0knLCAnMics
ICc0JykgLyoNCj4gQlRUViA4LWJpdCBkaXRoZXJlZCBSR0IgKi8NCj4gDQo=
