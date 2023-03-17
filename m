Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C456BE44E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCQIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCQIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:51:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C15A6DE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:51:06 -0700 (PDT)
X-UUID: d6f31800c4a011edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7taDSul/9TxzktDNcA3FDbUfgLtKP5ETxFSakzaJQKs=;
        b=cbjPNCbZr9UmfpyyQpdeTetHuIhW/Gi0x5VhCpRlIF6x4z9j4t34W0vwAR0fhEe4bu1Q7EKD/jTQZHLJ34wJcaD78Z4YTe+GQ/nOrSSrfpWInGNf6glcVZ5KaNDnzZe8BJADt7bmURy1I2Zx2Tv6gtYIzAQV2zJwIi6oXAsGIOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:97c115a5-abb7-47a2-ab21-841e51c9eeda,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:2d90ad28-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d6f31800c4a011edbd2e61cc88cc8f98-20230317
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yanchao.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1915199906; Fri, 17 Mar 2023 16:50:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 16:50:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 16:50:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV8dWeJeS22+1qZtuMl4xoH0Ia0ImWsVjJLDjx+CvQZ2zI3vbnh7areF2PD210A9AtnlQF2xeOA/ztYrv0uTeQOu9D+KZk+07M9UKy4w4zMY2tmtD8X6vk4mSwSa0eGHf/pwM+k/rZHF8D8x3rXAxmtG7JIoQ+i3VgY3Piz+K3yYE8AolBWycpYgXg/4du9ED8/qcYQEssfQKFnhYWxS/QbPZmgl9wWHEEKKL/Sd2PVsCAIQ5D14hQ2XiI2cba15Ccot69FX6JbyQRkRXLBVWIi3YhnPh0nvNweMg0zw20s1PE2Yq5mZ4f6EewXUwetRH/S2jjTM20g07jMfQv/lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7taDSul/9TxzktDNcA3FDbUfgLtKP5ETxFSakzaJQKs=;
 b=hvJh0MSjNU9W90iDntW4eYxs6d/3pJUAs42qotX6Wu/CnkafeJZh6lxmeAyez7t8NnezG1z8aR57/wSvCsL3p/BrhLgCRr+5gP4WeQnhqvjsudVEb8028sBXb6P4lHbc9KgCFVduQLIgsZ1fleDz0PP4EjL47CCcqqf7CBlB6eawM2SKr9XxD4xHsmp7/BIDXsvHTGtwki98vdVQf2uNXfjiRU748rMiznwW/K4kq1eP/gZjWYKzXqkJoLTxkGT4W91SmB0mQOXikwntMPb3pp3iEuYG0OHz4FbhaZky++AQzsOMi54EvtNm6SXuiaGp1E628MyPuJ7w8h3UKbT+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7taDSul/9TxzktDNcA3FDbUfgLtKP5ETxFSakzaJQKs=;
 b=Pxpl9Bpw2E25qZ/UiHEp07Vhoe1cmTUBwHLpJO4zr9pFLCGOLMRQiSgyg71sXH7qR2OOQZgfYhLeCVyjQIeEgFAhi6J0QVNgPGvpI5xI/2Ow9KISZ4ZZPYgAtqXgt76z9dW26a38UbroLOzTqaqCHL4jEN/r65LHVi12SCD2+Mg=
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com (2603:1096:400:12c::13)
 by SEYPR03MB6769.apcprd03.prod.outlook.com (2603:1096:101:68::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 08:50:56 +0000
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7]) by TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7%9]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 08:50:56 +0000
From:   =?utf-8?B?WWFuY2hhbyBZYW5nICjmnajlvabotoUp?= 
        <Yanchao.Yang@mediatek.com>
To:     "kuba@kernel.org" <kuba@kernel.org>
CC:     =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWluZ2xpYW5nIFh1ICjlvpDmmI7kuq4p?= 
        <mingliang.xu@mediatek.com>,
        =?utf-8?B?TWluIERvbmcgKOiRo+aVjyk=?= <min.dong@mediatek.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@intel.com" <m.chetan.kumar@intel.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        =?utf-8?B?SGFvemhlIENoYW5nICjluLjmtanlk7Ip?= 
        <Haozhe.Chang@mediatek.com>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        =?utf-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= 
        <Xiayu.Zhang@mediatek.com>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Topic: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Index: AQHZPfRhXG0uLuMh9ki8uUJNPx0e967PblKAgAIgUwCADDu2AIAAzFUAgAQ2vACAAHJFgIAA1h0AgAC0CwCAAJfcgIAACKKAgBl064A=
Date:   Fri, 17 Mar 2023 08:50:56 +0000
Message-ID: <e0b31587fe26a00f06b6f649c0d612607106e0c8.camel@mediatek.com>
References: <20230211083732.193650-1-yanchao.yang@mediatek.com>
         <20230211083732.193650-2-yanchao.yang@mediatek.com>
         <20230214202229.50d07b89@kernel.org>
         <2e518c17bf54298a2108de75fcd35aaf2b3397d3.camel@mediatek.com>
         <d6f13d66a5ab0224f2ae424a0645d4cf29c2752b.camel@mediatek.com>
         <20230224115052.5bdcc54d@kernel.org>
         <e7628b89847adda7d8302db91d48b3ff62245f43.camel@mediatek.com>
         <20230227110047.224909ee@kernel.org>
         <ebe8c4057b16c6565223af53bfb229dd1846d26b.camel@mediatek.com>
         <20230228103132.325def4c@kernel.org>
         <3e38940908752018bda7912f294d7a7c390657b7.camel@mediatek.com>
         <20230228200557.1a563b0a@kernel.org>
In-Reply-To: <20230228200557.1a563b0a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6161:EE_|SEYPR03MB6769:EE_
x-ms-office365-filtering-correlation-id: 763f658f-0fea-4479-1eb5-08db26c4b913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdU9gk/zrkPyPQtownuqNJOOAxDdxWJoIL/tvOg4ZMI/L3YZy+mgSXt+PCeHNwwRUv4WPTa6GlY3q/7hyXF3sLvaODYIU2+G8/kh+Pg4/Hukys0CV+TrP4xg4CXF8gDP8AXKfTzAiHEFcOWGrASxf8uro23PjyV9DvZXcBi/Uck6EN93zigOdbpCBvaYhRUDF6SrIjTbjo2Oz4JiIaSr0BvFvM5UuA1VaY8Ml2RyIyj8co3dKhAaNCS0grZKLVRq3v+wjRhF0qIVPYk8vjsN7wRvByYcqnwElSqhLqvTzS8/PLVpJkHBxFfXYb09qgFhnnqpKMIvkopH3AGumEj9Ik3HS9Ko2dr5JwS3v47DO2nnjCajdXzaXfty3ywP9U7SxYSHrSoecllMB1lEG1JIjAg0p94YBsO2yqi/5GTnDtRhXhW1Nqge50ZE8gh6yQlWENkl/wYRKSd6w0UOEtx8vpvfMSnwotZ+X3rsZcFcWguHnieHgRJryM1p9q3aBk+pd1r7/73TUL/7pjfNMLZ6t0R5+swxE9tHT6S29ee17tDGIUa9xG1Gicc2J851Gu+0NeyKoTBx1u9WJ044OFrhhb9pPOJ9JmPVe4/dyBtWrK/lqcNtGOz7ofb2fFKjpEy0cYWyDBdWA+6yqtMVgSXj9Dc+f4/Z6ml83Zf9EizrD3osUbNSm2WZaCg57hqwkao0KeUu9vFZOChK3oSOHF/2HUfnGLLAq5LDOpTLApF3D38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6161.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(2906002)(41300700001)(122000001)(83380400001)(5660300002)(7416002)(4744005)(36756003)(85182001)(66476007)(64756008)(8936002)(66446008)(66556008)(91956017)(8676002)(6916009)(4326008)(54906003)(316002)(38100700002)(38070700005)(76116006)(86362001)(66946007)(71200400001)(478600001)(6486002)(2616005)(186003)(26005)(6506007)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHppcEo1dUxEM1dFNGNUQzRIeGNFd3RkRENPbEU3TUxFdkpXUHZ3MVB2OU04?=
 =?utf-8?B?T09pMVROTUtQWjQrUjZhdm96N0J6NExPc05TMVM1Qml5OFBWbVJvM3NNTk91?=
 =?utf-8?B?WExkUTRjeVFLcDc2MHYwOFIzRWhpRXAxZTF5c0tLZGVuV05YcDN4ejV3SnZD?=
 =?utf-8?B?cXpGbHNmbVQ3b3dJVDBrNHlaS1FJbzFCM3UwWC9VbXJrOS81ZFpnblFNdjRZ?=
 =?utf-8?B?RWUyUFB4YXJEaEVPMDlaTWVSbHFPWndtTGhUQ3RxdXF3dHIzeFpmUnJUc1Y5?=
 =?utf-8?B?RzM2M2E4STNraFdTeDFkUkpjMDUrU0pKZmJpLzdXT2IxSDJTN0hnS0hYa0Zv?=
 =?utf-8?B?NVlabVUzSmphQWxKOUUxbHVLd0I3K2RuQnQ3WXYwckhMQXB2YnFVbVdCU0V1?=
 =?utf-8?B?U0tYajRuT0FaYlBha0xFUXZnMnV2dDR4R0hYNFUvb3pZTUVyT0JtYXVLaWx4?=
 =?utf-8?B?bEtMbVluMDVsejFJOWJWNWM1VTFwbU5ZT0UvK00wc1JhdjV3aGsxTDc3K2o4?=
 =?utf-8?B?N2U5em5yT0ovcVpiWWtSUWhuOFZCRTBFRnNDWW8rV1NmcjQ2cHhIRlZiMGVm?=
 =?utf-8?B?TXp2Zy82YzNBazZFV2FhNFoxN29LVWtTRzBQeHNsYy81U3ZpSG4xdGxPZjJ6?=
 =?utf-8?B?c2YyVzE0TEhRZitQd2tuR2Y1TzB6UUFOTDdETVZrZERMV21IK0FVOHBvSFVt?=
 =?utf-8?B?c2RiQWtxV0kyK250VnBMSmpDWEhnMDZxL3pqdGJQcFplZGl5UnhWZkxTY2xy?=
 =?utf-8?B?bGR6T2pwN0I5N0c5dlRBVFp2RmU2bERObVJ3a1NOa2sxb3FTL0Zia1JZLy9r?=
 =?utf-8?B?WDVjb0U0T0RTcXpVc3JWS1ZwN0tFYWxadDR1a2N5emxGOTVWYm5yZUJIaTFn?=
 =?utf-8?B?UjhENjZHMG41dGRleXpVbHk3SFJ1NXI5S3BiYWl3T1ByZHNUOWRkNnpyMEp1?=
 =?utf-8?B?OGJldzdCa3RYRy9YelRKcjNHR0g2WTZFaFNSZUFQc0piWnNOdDN2ZkhCTzFk?=
 =?utf-8?B?eUtmRzVjaVRkTHBETklEQXY0NzJxUVlXUWNiY1A4NldXVTV5MzQwMGdtQ3FZ?=
 =?utf-8?B?WGlFanh5Sk1DZjkxakYxZ1N6NnI0MkZtam9IWWhWVmcrRm5OTTRlcDNrYkpT?=
 =?utf-8?B?cmsxMy8zQkhrY3hvZDdLRjhSaGFsbWVybVhydDhSbzhxUFR1eUxvT0FqSCs3?=
 =?utf-8?B?VHNGcUZlV2IxV1MwL2ttMFJkbW43QS9ka1hlbG8vOExvdmZLUTBxWVVCOEhh?=
 =?utf-8?B?QUtJMVFicVQvOWE4cUE4VmE4YVpnekxpT2ZSNEJwYVFuOW05aU1ON2ZsR0RU?=
 =?utf-8?B?QzRFb1pibUd2M3FjZ3h4WnNKTTFVNjN5WHdObkRNc1JEZEhBa00rZmJnUVBE?=
 =?utf-8?B?ZllqSlVubzhiSGR6QVlHdXd0VUFBNDZyU3lWd1FzRE5IdEVNazdnS0I2K0wr?=
 =?utf-8?B?YUxoY3Q3U2tDL2lKRWJWc2dhUExCNkJmcml1MkdNQ2FLeTUzVCtzYlMrODZD?=
 =?utf-8?B?THIrS0FudXV6VlRvazhxYUFCdUFlY2N4Mk01b1p5bWY4U0YrZWFySGgvTEFv?=
 =?utf-8?B?TTVoU3c5NVhRVU8xN0lEbnZDdVB6YXlETk1tTHlqUU9USFd3aVFGejBHTk0r?=
 =?utf-8?B?RWpmT0NCVzNhWElUeVIxWFFDbUd1WjNBaDVsbGZVcGtxSTArNWxINmQwUTlj?=
 =?utf-8?B?UUhud3Z1QjJ0TGdKYXFsMTJIK2pHdjNlZWYvdjZxUmlvbklKZ09rdE5KYnlj?=
 =?utf-8?B?WWgxT0tBUmpPb1dKUFBXVGM5OFAyMThVUE5meUpadDdiZG1jRkNaOUJkY215?=
 =?utf-8?B?RGY4dDNPalcxZ2ZOWXJmTy83aEtaWWF3NHlxMktCeUVZZTJkVTBJa3d5OXlW?=
 =?utf-8?B?T2tCVzVTd1JPSzkyaURhV1NKSE03MmdRejVJZGR3TVJucFhqTy9nRjEwN1g1?=
 =?utf-8?B?RTJDV1BLNU5jeTVnd0FXc0t3WlUzMjNtMVZtOS9EZ2s3OWtNbjFxcklSZVB2?=
 =?utf-8?B?RTFtYm9nTlloU1NBenlqYVM0TkxHRGg5ekVHYUNMQ0ZmNUJOaHZkL0pVUGlV?=
 =?utf-8?B?YW9DQTRGc3NCdkx3Y0xaMWIwdlN5czNQUjRNVU1wdlRmNmJuU002OTJsQmt0?=
 =?utf-8?B?eExtSWNhTHJINDB5bEUyVmNRcElNRHBrcUZ3VDBaTkFqYUs0aTNZWmhpN2Z2?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44040EAE914A1F459D70F9AE6C372144@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6161.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763f658f-0fea-4479-1eb5-08db26c4b913
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 08:50:56.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KUzqfbQhvQn1Rmif1fCmcfJ/BCbLr8ykE9z7Z6FVsxKjsvhSYTxfF9xaJRgtd4Rt40+n2/t2jofGxV7TYxHcxTiZSTTPYUa5Rdti+4bARE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6769
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTI4IGF0IDIwOjA1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAxIE1hciAyMDIzIDAzOjM1OjA1ICswMDAwIFlhbmNoYW8gWWFuZyAo5p2o5b2m
6LaFKSB3cm90ZToNCj4gPiBCVFcsIHRoZSBwYXRjaGVzIGFyZSByZXZpZXdlZCBvbmUgYnkgb25l
IChwYXRjaDEsIHBhdGNoMiwg4oCmLiksIG9yDQo+ID4gYXJlDQo+ID4gY29udHJvbGxlZCBieSBy
ZXZpZXdlcnMgKHRoZXJlIGlzIG5vIG9idmlvdXMgb3JkZXIgZm9yIHJldmlld2luZw0KPiA+IHRo
ZQ0KPiA+IHBhdGNoKT8NCj4gDQo+IFRoZXkgYXJlIHJldmlld2VkIG9uZSBieSBvbmUuDQoNCkhp
IEpha3ViIGFuZCBSZXZpZXdlcnMsDQoNClRoYW5rIHlvdXIgc3VnZ2VzdGlvbnMuIFRoZSBzZXJp
ZXMgcGF0Y2ggdjQgaXMgc3VibWl0dGVkLCB3aGljaCBoYXMNCmJlZW4gcmVkdWNlZCAxayBsaW5l
cyBjb21wYXJlZCB3aXRoIHYzLiBDdXJyZW50bHksIHRoZSB3aG9sZSBwYXRjaCBpcw0KbGVzcyB0
aGFuIDEyayBsaW5lcy4gRm9yIHRoZSBzdWdnZXN0aW9ucyBvZiB0aGUgZmlyc3Qgc2V2ZXJhbCBw
YXRjaGVzDQpvZiB0aGUgdjMgdmVyc2lvbiwgYWxsIGFyZSBhcHBsaWVkIHRvIG90aGVyIHBhdGNo
ZXMuIFBsZWFzZSBoZWxwIHJldmlldw0KaXQgYXQgeW91ciBjb252ZW5pZW5jZS4NCg0KTWFueSB0
aGFua3MuDQpZYW5jaGFvLiBZYW5nDQo=
