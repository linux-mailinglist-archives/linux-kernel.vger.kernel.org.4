Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EEF66B9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAPJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjAPJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:13:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB991717C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:12:07 -0800 (PST)
X-UUID: d6c27d5a957d11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eme5lYwujabdYMY0XvriFcEJV9cXxEaF5QcM8U8T1hA=;
        b=X/XKqXDdjimoHZ6GUyy1D6LuM6SRQD6Qe/yWWsrKh9mSCZW9M0xeHx+kJVt9wxx0vFD2MveWK45DBMO9wsvj8zufVPTimCioiHQZjqz7DrTOkN9SruvYk1T2RcSVEkr6XjArZXIrm2qkdZKciy8UC2RJmFnI9CcvkiY3YhtWozU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:0c32d47a-78a5-4605-ad46-e8b6c67e216b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:0c32d47a-78a5-4605-ad46-e8b6c67e216b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:f4d7eff5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230114021304YBKD6RBN,BulkQuantity:33,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: d6c27d5a957d11ed945fc101203acc17-20230116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1183515271; Mon, 16 Jan 2023 17:12:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 Jan 2023 17:12:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 17:12:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZc5ghn6694RKzLu6azttsXFEqC7zUrcqwo1BPZSnoaTzew+cRgbOzTRbnNKPrStH+s73u6m94DEPzSsI23gSedv1DmJHor9aQdzL5g45ENyhGPU0H+oDUmwnoGbUHjuSiEgfK0vCF0Wq4VWqkOXKyv6fAuTeqxfdv7iH2Ogv9Mq3cX/xtTj5XGvLKO53HYP9EEKAfBRIfVNpAQuNNplbSOGFNQHzzB5yqrhkremfVL+CjwCqqHKwiECHeuSTNl/5l1gv6550XDlhEMflqP5Ly9OzMXqKuhHz0MBhx23CzSybyj1++ykN+katdU4ahgQaHhqK6DftfCmZrt1pjGO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eme5lYwujabdYMY0XvriFcEJV9cXxEaF5QcM8U8T1hA=;
 b=fxEim4R5V9LkkK51+TE6xsOvV+/xzZrGv0ivlnr0FoAwH6fOuC7l12ZgPVXLr/yK6aRljMxQxz8egSXy3fSentvPs9LxCZ94HCyc6ZyKBFTis8qJk0nfhNeIWoPr03u4hnk61LBhv/nO2edIDekgDUClLcm3Oxq4DftkwMeb5xEWHzqkxrxW4ZM7eb48xu8Mot+09A2VRNHpmr38jr3Ipvc6hpVFZ4KzhbbmIqE4fEyl30YZTHWN1cCD+WivUi4ArkX6WOzKsNtKmajaZEJWBekBCYxqt0bVD/4HjxLdgRaYMYs5nyjvC3qXmU7zjAZZ3AslfQUnYJtIc9vmRQFuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eme5lYwujabdYMY0XvriFcEJV9cXxEaF5QcM8U8T1hA=;
 b=cykjAXcmEXY9Q4jCAEW4yJlJSLn+xA3PvuTJ/1GHqf1dHaO5qCRIWQkk6AiFvkC31atYkcOGVYPK/tzDy505JxNitYfH1d4HVeLV87JHM59dyZFhikWUnVLxmK02ZyZo8E9WX8iuOU/qaifl31R6crHAAVIKkB57cZw+oVBGfJ4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PSAPR03MB5765.apcprd03.prod.outlook.com (2603:1096:301:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:11:58 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:11:57 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Topic: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Index: AQHZIEA7g6q5Ep2afU2pWWp4HJGwLq6cu2OAgAQZRIA=
Date:   Mon, 16 Jan 2023 09:11:56 +0000
Message-ID: <4ae389c8b81f54d209c9fa359f36b46896904cfa.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
In-Reply-To: <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PSAPR03MB5765:EE_
x-ms-office365-filtering-correlation-id: cbc35292-5e4b-4ec2-9353-08daf7a1b773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1osNqJQydgHr99reqa8vePsixLeob3n2/wrbc4MbtzcLnLS7HyjizjJSA4ALvYI6n+udrNO++l7bkKLPAfV3dsmyHRURthaRrVXYwQxfdoK1hxolng0uFk+1BiYjIuXjyKPSxu2RTpq9DzBsk/+X3sX1GotMNcMCq9eG3Qf++YT8nl/HYwlfvmef/2AAEd1thFqRBiQQUbeo7wC2dyVzC8ol6JHnjmNa3eExyFNMSp0di+pH9C/d9Vl++uzY+oUHFpmQ07brELKqNJFPy5KAMIM6fky7Vfxk+nVDZtEd7OzE3l0nhcCAnzKCvj2Y5LwxYp/oIYnZLCg7nxxS7+Tp1iK4D1lOqdNg3UT5E63wX6kj4MFGVqGp5Z0oLebsUYaZ/QhXuLt+XigpLoUAsgwoYcK+CqAJbQBt5EOGlEcgmUG1sno/XijQux39YdmhfM7Ps45kvmKZiv6NzhxCWEWRKYW+eyyDLfwRKHYZ49Lyh5UxfaWTTKB7ME9E6Y/Cfm/UzfmDuEEblDojgV5eIoUIQLEajHrc/oIjE0AVizdgf7YLx4SdmWle+FTGExo/Ozhq34xhE+GIu5wn7dUsrWDTNuEODR9blkw92sVhH40x2/YLKwcVJasOz4ztybRkV6B49T7dTSrf2nx2RgnO1qynOG/uy3eNafpdyPXv+PZdxg0AK0QyZwoMeqZQ1eu7Bo/GEtM/igvg4uYQn+nWK8nPVgQSwwYxGwt+cGaVA0WivgQQIjc/3hzL5HO8h7rGnfK8H+54D62w8BtL8ysLX/PQYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(85182001)(36756003)(53546011)(86362001)(6512007)(186003)(26005)(6916009)(8676002)(64756008)(91956017)(4326008)(66556008)(41300700001)(76116006)(2616005)(66476007)(66446008)(66946007)(316002)(71200400001)(6506007)(478600001)(54906003)(122000001)(6486002)(7416002)(38100700002)(2906002)(38070700005)(83380400001)(5660300002)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBoSW9oMEYrS3FTSWJSTnFHM3ZlRHVqVmdiMnYxdmNRUFh6Nm9Xc0tWT0pM?=
 =?utf-8?B?cWpnamRGckxnR1pNaERPRVJaVy9kMkxFbkJDSkp3K3R5Tm9YSlRSSlVmYkcx?=
 =?utf-8?B?cFJQTUs2Qjl2M3JMVjJFeS90KzU5SFk3WVJIS2dyVFBHVis3YXBTSGV3RUNq?=
 =?utf-8?B?dXBsY2JCSWNmczN5cHdTY3lzWW9WcXJETEtHTEs0Mnh0c0gxSG9tSFJtRE4z?=
 =?utf-8?B?ekZneGlXTEJzNEQvSWZQVE56QlBrQkhMM3d0T2ErMkhOOVNaK0p2c05CQUVw?=
 =?utf-8?B?NnNSNW4wMXBJSU5HTEVWZFFpVUI4NGlWSWxnb1FZZVJKYzl5K0ZTVFkzdTRV?=
 =?utf-8?B?bkRnOWhoVnBqajdmNVFUMkxJai8wZ1V6QlQvZEtnbUE3SjNOVzhPdysrczRV?=
 =?utf-8?B?cHU5VHpvWmhVQldTb05nOVdaNjUzMS81M0lRZjJGRnZDbVpGSjR2VDg3ZGdj?=
 =?utf-8?B?eHZvbWlBWmRPaFlOZnRnWEVEVVZUWVlSbkhSNHFOMWtqNWRhNUE2NGJnbWY4?=
 =?utf-8?B?MDJ0QWloQWpYcENZNklXSC9CY3NPVFVpNlNBTXRhc1JEaDdqWkRvSUdHU080?=
 =?utf-8?B?SWRYTjhvR2c0SElDMXUxNWh4a1BIT280K3kzclBkZFhuaGo0eGVKSFlyTUxZ?=
 =?utf-8?B?QTkzUTRoV2RZemZuNXpzL2F5K3k3eS9vWHIrQnFQWStqSE5EUmwyVGREL0E3?=
 =?utf-8?B?aUdiZ1pVU2N3OW1GSUhYczc0T3F6SjdlMDA3YjFDT09HZCt6REpjbDNYWE9n?=
 =?utf-8?B?bWNhYVRJRXd4TXZ6d0tZbmJRWFVkdFZ3eXFHZXZGME04alo3OTMrTnNYdjNP?=
 =?utf-8?B?S3RIamxUTU1DbThPVlREUXRrVVZ2STJxbk1Cem9LajF1KzNYcG84Ny9SNUR5?=
 =?utf-8?B?RmZoRUlDQ2FQY1FKSXB5ZWdzUW1kZ3hrakswZEYwOHZxSFRBRkk1eVg0QXpF?=
 =?utf-8?B?YXd0bThaN2hzUStNYjZhdUNEcE15WWJmZUJYR1FXUHdUTlgzM0xvTUlrbUhK?=
 =?utf-8?B?aUhISDJrbVk2TE9yRkNFTXRmbWVDdUcxU2JYQ1ZzRFJPRzFJZEhNYVZ3T0Jw?=
 =?utf-8?B?ZkxxTi8rY3dsSmpGeEFYcWkzV2lDbmtPeWhJNUdxb0lnSys5NFdweXRydDJw?=
 =?utf-8?B?TVpnTFVvdWNhS1Y1cGVkbW1pdTQzUW9VWXJ1MzVDVmx4TTduUDU2Z2g3dEhw?=
 =?utf-8?B?UE1vdVQ4a2I4TVovRldMbzBiWit3MzVjY1V2dTJuM094MnM4bDgwWEk3d0Zu?=
 =?utf-8?B?d3htTkVqdXZ0bTZTa1FueDF2dVBFbVljdVFOY2NpS3NEdzRxZHlRa3p2QWdR?=
 =?utf-8?B?empsQ0FaVURyd0NVbWFyQlNQQ21UMFp1QkRoTERIa1VoZHBYRHVWUFBzS21X?=
 =?utf-8?B?NndRdjA4L2NodXJGUTUwQ1cwWXBPN1BKOWppanp3L0lXYXBWSmVBZk9FbXlN?=
 =?utf-8?B?Umc0WE80YmdmazFLc1h4WUpvWDVyMERsREw2UHV6c1FOYzhIWXVML1JvNVE1?=
 =?utf-8?B?Rzl6NnBOMy84anBsb2NLaTdOdjY1YUpjMDdDL2lRQjlWaVVsYW1ZL29XYVZQ?=
 =?utf-8?B?RFFteVRnU2g5dDFVZ2JJU3BXRzBUZTB6ZndqeEdtQ2hNY0FRUXIxdG9uRTJ3?=
 =?utf-8?B?Z2hwOEJ6SDVvNllPeFJSZEwvMFNxcjROZjJScEI4alZsVEFJeExWazcrZ1Ja?=
 =?utf-8?B?MzA0ejlaZWRoZk43MzlaeUw1Ym1DRWhaR2hPbThhYUpPcHFlZmZRanNSVWp2?=
 =?utf-8?B?SDdoQjZiZ2h1ODZINURyejU2YXNvRlBkOHFhVzJRSUNIRjBkdEZhNTJFTTln?=
 =?utf-8?B?cy85azBBQlJYV2trQlYwTW01VUh4N21EK3l6Q1F5R0dLOVphZU1zd24rWXFr?=
 =?utf-8?B?VVUxV1J2SUxzMDFleVE2SDh0aTNHVmVuS3ptT3d4Z01KZktRazdUVXFsTzVH?=
 =?utf-8?B?UXpuN09YUnlTWlZHbENSRGRpUVBta2I3NFVLR1M3QlpPamJZQ1BNS01wUkV5?=
 =?utf-8?B?WlFJc3VXdXhyb3FTc0xTYWgwVDcxbHJ3S1BHai91ZHZ0ekI1Y2k4NEZhQ0lu?=
 =?utf-8?B?cHZKV0o2NTNrT1ZTL0prNGhLU09GbnZaNE80UFBGTjZTMGhIakVFVkJrRENE?=
 =?utf-8?B?UytsYmc1RWJmWjhvdm1RYlUxbTVzb3g2eW8zMWdkYXVhK3YxcnhjZ2lpOFBX?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23176B206701384E868F6D592F4E88F9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc35292-5e4b-4ec2-9353-08daf7a1b773
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:11:56.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQWnypmKrprJo2cqu6z9cTx1fkHCQ867Q8uOLsfiLktVR5e2uLVVsgCnl9/M256KxmYZYqm2kMYBefYsLjs/yb721h9n7tM1Vpr2TSmy84o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5765
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

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDEwOjM2IC0wODAwLCBOaWNrIERlc2F1bG5pZXJzIHdyb3Rl
Og0KPiBPbiBXZWQsIEphbiA0LCAyMDIzIGF0IDU6MjYgQU0gQ2h1bmZlbmcgWXVuIDwNCj4gY2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSB0ZW1w
b3JhcnkgQG1hc2tfLCB0aGlzIG1heSBjYXVzZSBidWlsZCB3YXJuaW5nIHdoZW4gdXNlDQo+ID4g
Y2xhbmcNCj4gPiBjb21waWxlciBmb3IgcG93ZXJwYywgYnV0IGNhbid0IHJlcHJvZHVjZSBpdCB3
aGVuIGNvbXBpbGUgZm9yDQo+ID4gYXJtNjQuDQo+ID4gdGhlIGJ1aWxkIHdhcm5pbmcgaXMgLVd0
YXV0b2xvZ2ljYWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmUsDQo+ID4gYW5kDQo+ID4g
Y2F1c2VkIGJ5DQo+ID4gIkJVSUxEX0JVR19PTl9NU0coX19iZl9jYXN0X3Vuc2lnbmVkKF9tYXNr
LCBfbWFzaykiDQo+IA0KPiBDYW4geW91IHBsZWFzZSBpbmNsdWRlIHRoZSB0ZXh0IG9mIHRoZSBv
YnNlcnZlZCB3YXJuaW5nPw0KPiANCj4gPiANCj4gPiBBZnRlciByZW1vdmluZyBAbWFza18sIHRo
ZXJlIGlzIGEgIkNIRUNLOk1BQ1JPX0FSR19SRVVTRSIgd2hlbiBydW4NCj4gPiBjaGVja3BhdGNo
LnBsLCBkdWUgdG8gQG1hc2sgaXMgY29uc3RhbnQsIG5vIHJldXNlIHByb2JsZW0gd2lsbA0KPiA+
IGhhcHBlbi4NCj4gPiANCj4gPiBGaXhlczogODQ1MTNlY2NkNjc4ICgicGh5OiBtZWRpYXRlazog
Zml4IGJ1aWxkIHdhcm5pbmcgb2YNCj4gPiBGSUVMRF9QUkVQKCkiKQ0KPiANCj4gVWgsIHdoeSB3
YXMgODQ1MTNlY2NkNjc4IHNlbnQvcmV2aWV3ZWQvbWVyZ2VkIGlmIGl0IGRpZG4ndCBmaXggdGhl
DQo+IGlzc3VlIGNvcnJlY3RseSBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+IA0KPiBJcyB0aGUgaXNz
dWUgcGVyaGFwcyB0aGF0IHlvdXIgbWFzayBpc24ndCB3aWRlIGVub3VnaCBpbiB0aGUgZmlyc3QN
Cj4gcGxhY2UsIGFuZCBzaG91bGQgYmU/ICBTZWU6DQo+IGNvbW1pdCBjZmQ2ZmI0NWNmYWYgKCJj
cnlwdG86IGNjcmVlIC0gYXZvaWQgb3V0LW9mLXJhbmdlIHdhcm5pbmdzDQo+IGZyb20gY2xhbmci
KQ0KPiBmb3IgaW5zcGlyYXRpb24uDQoNCkkgbG9vayBhdCB0aGlzIHBhdGNoLCBpdCBzYWlkIHRo
YXQgIg0KVGhpcyBkb2VzIG5vdCBoYXBwZW4gaW4gb3RoZXIgcGxhY2VzIHRoYXQganVzdCBwYXNz
IGEgY29uc3RhbnQgaGVyZS4NCiINClRoYXQncyBpbmRlZWQgdHJ1ZSwgbm8gc3VjaCB3YXJuaW5n
IGJlZm9yZSB1c2luZyBGSUVMRF9QUkVQKCkgZHVlIHRvDQp0aGUgbWFza3MgYXJlIGFsd2F5cyBj
b25zdGFudC4NCg0KU28gc2VlbXMgdGhhdCBpdCBjYW4gZml4IHRoZSB3YXJpbmcgaWYgYXZvaWQg
dXNpbmcgYSB0ZW1wb3JhcnkgdmFyaWFibGUNCkBtYXNrXyBpbiBtdGtfcGh5X3VwZGF0ZV9maWVs
ZCgpIG1hY3JvLg0KDQpUaGFua3MgYSBsb3QNCg0KPiANCj4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBDYW4geW91IHBsZWFzZSBpbmNsdWRl
IHRoZSBMaW5rOiB0YWcgdG8gdGhlIGxvcmUgVVJMIG9mIHRoZSByZXBvcnQ/DQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiB2NjogbW9kaWZ5IHRoZSB0aXRsZQ0KPiA+IHY1OiBubyBjaGFuZ2VzDQo+ID4g
djQgbmV3IHBhdGNoLCBJJ20gbm90IHN1cmUgaXQgY2FuIGZpeCBidWlsZCB3YXJuaW5nLCBkdWUg
dG8gSSBkb24ndA0KPiA+IGNyb3NzIGNvbXBpbGUNCj4gPiAgICAgaXQgZm9yIHBvd2VycGMgdXNp
bmcgY2xhbmcgaW4gb2ZmaWNlLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9w
aHktbXRrLWlvLmggfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVk
aWF0ZWsvcGh5LW10ay1pby5oDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlv
LmgNCj4gPiBpbmRleCBkMjBhZDVlNWJlODEuLjU4ZjA2ZGI4MjJjYiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmgNCj4gPiArKysgYi9kcml2ZXJzL3Bo
eS9tZWRpYXRlay9waHktbXRrLWlvLmgNCj4gPiBAQCAtMzksOCArMzksOCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgbXRrX3BoeV91cGRhdGVfYml0cyh2b2lkDQo+ID4gX19pb21lbSAqcmVnLCB1MzIg
bWFzaywgdTMyIHZhbCkNCj4gPiAgLyogZmllbGQgQG1hc2sgc2hhbGwgYmUgY29uc3RhbnQgYW5k
IGNvbnRpbnVvdXMgKi8NCj4gPiAgI2RlZmluZSBtdGtfcGh5X3VwZGF0ZV9maWVsZChyZWcsIG1h
c2ssIHZhbCkgXA0KPiA+ICAoeyBcDQo+ID4gLSAgICAgICB0eXBlb2YobWFzaykgbWFza18gPSAo
bWFzayk7ICAgIFwNCj4gPiAtICAgICAgIG10a19waHlfdXBkYXRlX2JpdHMocmVnLCBtYXNrXywg
RklFTERfUFJFUChtYXNrXywgdmFsKSk7IFwNCj4gPiArICAgICAgIEJVSUxEX0JVR19PTl9NU0co
IV9fYnVpbHRpbl9jb25zdGFudF9wKG1hc2spLCAibWFzayBpcyBub3QNCj4gPiBjb25zdGFudCIp
OyBcDQo+ID4gKyAgICAgICBtdGtfcGh5X3VwZGF0ZV9iaXRzKHJlZywgbWFzaywgRklFTERfUFJF
UChtYXNrLCB2YWwpKTsgXA0KPiA+ICB9KQ0KPiA+IA0KPiA+ICAjZW5kaWYNCj4gPiAtLQ0KPiA+
IDIuMTguMA0KPiA+IA0KPiANCj4gDQo=
