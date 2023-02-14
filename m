Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABB695889
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBNFdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBNFds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:33:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856716AFA;
        Mon, 13 Feb 2023 21:33:42 -0800 (PST)
X-UUID: 1ee9119aac2911ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5CLNVnLIJmqGnO7nRtEKzFceh1J2uVMphcfh3LLuNCc=;
        b=QWazMzCZHp9DKqE2VSAzLfm83aPyT6XEaqf4FuvpMYwuA/lnuzOfNhuWF+Q+J6TJSPKj4WCfHoy5Yx+DkWYPj1A4IzDShrlruS8IqFRwjezXnX8nv5oig1bxRaI+DXgiUC+spZzlsy0GQPPbbXZcF0lkFKp5KFM56UhKbZHNjq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:89ae45d4-c9aa-4444-9c1c-88bbee9a1097,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:89ae45d4-c9aa-4444-9c1c-88bbee9a1097,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:cf1660f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:2302141333343H2WP2CF,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 1ee9119aac2911ed945fc101203acc17-20230214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 924590628; Tue, 14 Feb 2023 13:33:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 13:33:31 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Feb 2023 13:33:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8y9sMP6VuO2cDCI6/7jkh6unO7BF74DICR3WPqDWbVLo9ZMzCPLPelhwB41Iz/8lVxylGzCEQ1NX6RKv9dtCzdPgdDcgVdiSGpUrQMnnbBk7aHeuNtEdWhO9XQkZrQTh6S3423ITmGGn3/H/l7OzvDDLdQan/6Xt7dQEUftIevJ4lXSuV/Lbt/J5HqvE6LCoT97uVh/hna2VHlMgTmeeB3tF7Wc6xV7wEtX6aF0nhH2teLE1Dp3GtlOvIAj0DeQwSDWvMDjHBsUqUtNX17LDwHyg6Yk1TXPHDZ4EoBxcp5jtX9bmevQSW2gw+8hz/1dKaUrnSRA7YWGFpZWgbt9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CLNVnLIJmqGnO7nRtEKzFceh1J2uVMphcfh3LLuNCc=;
 b=QlqPSHzDlrTjhL3NNQbl/HHs5apQleHqkMwKx+/UHcp+dm04BY78Gp/gMcbaf+Z0ul7AzK+k1fbeV3gCaFbwsXT5HChtvXlNbLmcErgpOIxusEZSWSA5i1GOtSXaLJwX6FgQWxmpKDvFa1qbGNJnIsdj4QP0MMFyQ6Q1LYIG/IPIQTrox8lpCOmWFYNdQKge6PLeVFWes+HjSFDSarRpuFLjD3qzT7pU+GsstVSVSTWc6jAk0hqkvWZfk9JfrwhiQBRWAVd8wLTT7iXmiXhgEW1Knx6PkdBlO5UPs//tFYAiv8SjesY1OT6jDBsfIxfX/5D9/G9FUJf8vyAuTyc1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CLNVnLIJmqGnO7nRtEKzFceh1J2uVMphcfh3LLuNCc=;
 b=XozmxNPlFoZ+B8heAM/qdwsENhx5fOHY2r/s6lM9++xI70kc+8JKDe60UupjtuYOOyl2E5DT9rbtLfFVAiG56aACmFA//1OhaCYpfSFwM81PiiNsBRKHxHQQFe18wAWTh6QIZZlwTMTCz6X3vzoz07/dRcKgbsGuW2t5kmjyt8w=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB5304.apcprd03.prod.outlook.com (2603:1096:301:42::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 05:33:29 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:33:28 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?utf-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 07/10] iommu/mediatek: Add a gap for the iova regions
Thread-Topic: [PATCH 07/10] iommu/mediatek: Add a gap for the iova regions
Thread-Index: AQHZJxTOuH8NMp5lsEGAJuHBVALjHa6g0JcAgAEdKQA=
Date:   Tue, 14 Feb 2023 05:33:28 +0000
Message-ID: <35937e036d7d62f048b84c0f1ea6e98136e7ad5c.camel@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
         <20230113060133.9394-8-yong.wu@mediatek.com>
         <1a9a09d5-58e2-badc-6d1c-fe2008c305f9@collabora.com>
In-Reply-To: <1a9a09d5-58e2-badc-6d1c-fe2008c305f9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB5304:EE_
x-ms-office365-filtering-correlation-id: 8735313c-0335-433e-7b83-08db0e4d0049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTUAJWhM5lZppvjBgQwT0wiFn09lejDdjATY/3xFyipwiFx6ny897MuFL4KzbMBwgri7E/LtxAJUSwj/3QiFMp+ClW6p7jEc+FlPHdCBDByASL81Th65Y2x3JHJv0xwkkaXs7kHswuIz9BuQFOv73vzVMtjTHxQKq8CIbNRv0mRC8Pm+CkaX4SuTejWG+R89YwHx08sqUQTwf1vu9s86Medmz6HAOUAIJtO4amCHeNpxxsXk9+Nyqj1Uz0NocRlGhpqh2K1qMIpOKprONQRzHcaQcp8NJbb61IxiOaXYTfJRqq1t4C9FTKpU6ohvuA9SRNCSYd8y+bXvcCN2mMHnxWwzYA9Omz/sVUAf+PzmVDTgsf07Pr+sVRh0RoC+FvXCNc4qS1Qa5Bo8OQyQSsijwkhj85KmBXva8kDwgchmDgZCS8e8rod0W5nqcu1SfdM9NoP+gWJQniwTU5ZMj9vaVauXD3em22WbLQfxOC1FdIyFsx8YaCN7G04DiU70SFg8sJBZCoNHHW3bp7+n/5PKeM5RLgVuf0j3Dr3Z4U7liejAgAFmlKYLqX5bMrs3NDuwWTyuKKnFH7kpUa3cTGL7Ox2GZIHyhBVhhytZtjeJmikkPQhteh95vGoj53sjKO9OUVSfP6WQhRnKBm9XhekcFC2yXgC3gw0cE1M13fnsVJMbS0WWD8QYjp2sKEutYwUgnB/SPJh13g/QzSpvY+N8J1K5KfX2+tRUS9nxn4A3cg43bAXYAX0JWwgFnTaXsTzx2k/d+Wfq2VlVf/jnr27xeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199018)(6486002)(2906002)(122000001)(86362001)(478600001)(71200400001)(2616005)(38100700002)(38070700005)(7416002)(5660300002)(8936002)(4326008)(66556008)(110136005)(8676002)(66446008)(66476007)(64756008)(83380400001)(54906003)(6506007)(41300700001)(66946007)(186003)(85182001)(316002)(36756003)(26005)(6512007)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lYNllidVU2WFRQVkIrZERmajlmUkxCeVExT0tNbGg0SkFNK3ROWWlScWdy?=
 =?utf-8?B?SUhuYk5WSGFiQ01jR3F6c2xqQ0tMUDRDU2VQMG9xcmFDM201MXBnU01vdU43?=
 =?utf-8?B?Snlhem5GL2ZRS0V5Sm1jOTJDN0dqUHhldmJZRHFIRWRsVElQRUx6bVF1N0h2?=
 =?utf-8?B?ZjJ6RGE4Rk9nM244Y214NHd5czdwQjM4emk4Q0krRUtocGU4d0tVbVdFeGtz?=
 =?utf-8?B?UU5aY0s1UzYweGtXYjV4M0RKU2RmalZhN1FHcFdTT3Q1dlFxNENlQ3BPM3NJ?=
 =?utf-8?B?QnBNQ1Y4VE4ydGg0RVhHUWZCOXhrWSs3QTluUFpiSzlEUTNVbDB4V3J5ZTMy?=
 =?utf-8?B?VXUxbjRvTTNsbUcwakphRnZnZW1seXFvenhQazNJbW1LSU9rMmwrSEF2RlBt?=
 =?utf-8?B?YjFManNBei9JaCsyUjY3SkV6c0V6ODVZc2xBekpwbkp4Rk5VSzkxVXJiM3hC?=
 =?utf-8?B?N2NWcVhpOXpSVjRZeGk1YnhlOXBBY295b1ZFb0REcWY2N1ZGVGF5RGR3alQ1?=
 =?utf-8?B?ZVRrUGk3cXlpZ3dmcFpUaTA0THl0NTVneGxQaUdMNDYrVUNTNUxzaitjM0hS?=
 =?utf-8?B?aDFoZnRjcU1ORE1KeC9rVGxWdWJGdzdmQVptVzV0U1BVYW5WZThuYlFFOFhH?=
 =?utf-8?B?MkpGL2hGSEV3aFJhOGlDeWY2ZTVnaVBxWDdPNTAvdlFnYXgwdXVnQ1dPSW1I?=
 =?utf-8?B?Tkt3OHgxR1BNeDdlczZMc3ZDbjZxWDc4SnpMazh2eS9WWmpweVNOOWV4RTdu?=
 =?utf-8?B?N2gwajd2ZWdGd2xua2JCRHE4eHU5T0J5Mkx3ZlhPcU9Bek5OUVZWaWUrSG1w?=
 =?utf-8?B?dFRlYVhOb3d2OSt1bUZSRmFRR2lVcGNWUmluc2t0eTR2YmV3VlRDZTg4NEY4?=
 =?utf-8?B?bE81N0diNEY2QUpPd2ZIM2xIMzk2VmU5ZTR1QVZIRTEraHZlRWR2SW9SQlVD?=
 =?utf-8?B?b0tJWERzKzM3dWg0UGx2WkJFRjEyZmQ2SWZEQUZ1YTU2Uklnc2NBOWZBZEhG?=
 =?utf-8?B?SXRqVVJsSWhYQ05BWFAvZExJVlNzdU0wbVI4RlpQM1hXTVNFbFFYTStrb3Nm?=
 =?utf-8?B?b2lzNWpiZWVJVjEwNXlKR0xCUkNybGUrQ01qcFIzRTRIS2ZMNmZCVi9DeU9W?=
 =?utf-8?B?TUxwZnVYeTdnZExhdjJTckFmdjhGdDM5WEFpcUQyRzFPaHQ3WTBrbnJ5L2Y5?=
 =?utf-8?B?b1hnSDkzYnhOQWZNdjV4eVFFL3d4MklIWVZVa2tNNkdUQ04zaTRTbUFKL0pB?=
 =?utf-8?B?eDZvRVpuUjNWYkRGVCtrWGRQR2pVZnpkdlVNNzYzdGRQSnQzR2R6UkY1QXdD?=
 =?utf-8?B?WjhQbFBrZ2hzeTMrSFZqZ2FBekV3c3VpTVVXVmFTd0ZCb0dkQmpXMEgvMkR1?=
 =?utf-8?B?MnN6RjF5eTVhdVhGU3BnYWpSUFVyT0cwd0VlQjIzeS9BUENyY1ZJdnFvT2xl?=
 =?utf-8?B?S3VsN1BpK0RrVGE2M1JzQncwQ0MzUVRyQXZ6VmhJNVh0QUtBb0FXcnBQUGlw?=
 =?utf-8?B?ZEdqYjV5R3RWK3FnUkloTlIwNHNxbmY1bFJ3Tlh6bzJLd2t5OUhhc2JlRzBo?=
 =?utf-8?B?UVMrcTJZb2JOeVJvR2ZaVTkzNXJtSkgrS1RVcWcyUDh5aU4wUU5UT3dtUysy?=
 =?utf-8?B?cmV2elYyV1JIT2Mybk1KL0VSaEdqOHpkMGhHb1pUSkV3SFphMXZNZzU4Mm0x?=
 =?utf-8?B?RXhOUktVaWhHWFFEWGM4ZUhpY2xGZWFnTTNXaE9DNVVnOUw4VnFoaDlCMWEz?=
 =?utf-8?B?aDdoZC9zb3MvelBEMjJ6bjhqeW9ydkkrL3BZNk13TitIbVViNGlDalpGdk05?=
 =?utf-8?B?b3dXOEJ3SzhZS0xRcFQxRGpNdXF5S1YrZWJLcVVMNFBwb3RkWDJzcmxraDBX?=
 =?utf-8?B?UEhTN1NPdXYrUVpSMzcxbjhpVTc1YWV2M2RWaFJ6UmdoTTA3aWMrZkpMZWo1?=
 =?utf-8?B?WGJOR0dGMkdZYXZvKzd1bnJRMWk1a05BOFd4VXNmbjNDbm1CcDV0VmJtUzlV?=
 =?utf-8?B?cnZPdlNvdlhnVFBJNXhlSHZrYW5YeGNFa1lLMWlaVDViN0FpalVXbVp3YThB?=
 =?utf-8?B?ZEF6cDlkRmNabkRKVnhpYUZUdUtYM1FtTXNDd2FuMm9ocVUydnBuYXBCQ1Nx?=
 =?utf-8?B?ZERmc0RSSGNNUi93SUtXNnFBQjNWTm5PUTlraXhDMGZTaUpRK3N2Q0hFM2No?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE394A41C9BBE46ADD9FB2F202CAC05@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8735313c-0335-433e-7b83-08db0e4d0049
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 05:33:28.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVPXx8RQ6OSHjqGY0jnWFV4dJU0SmEsItYAGangY0tfU3LQV9pLzJpvcQAUT+EUvbYvomTXzEtPq/PO5fdWa7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5304
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDEwOjQ2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTMvMDEvMjMgMDc6MDEsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBDdXJyZW5seSBtYXN0ZXJzIGNhbiBub3QgaW5kaWNhdGUgaXRzIHNwZWNpYWwgZG1hLXJhbmdl
cy4gUHJlcGFyZQ0KPiA+IGZvciB2Y29kZWMuIHNvbWUgdmNvZGVjIGVuZCBhZGRyZXNzIGlzIGFk
ZHJlc3MgKyBzaXplLCBpZiBvdXIgc2l6ZQ0KPiA+IGlzIDRHLCB0aGUgZW5kIGFkZHJlc3MgbWF5
IGJlIDB4Ml8wMDAwXzAwMDAuIGFuZCB0aGUNCj4gPiByZWdpc3RlciBpcyB1MzIsIHRoZW4gaXQg
bWF5IGdldCB6ZXJvLiB0aHVzIGFkZCBhIGdhcCg4TSkgZm9yDQo+ID4gYWxsIHRoZSByZWdpb25z
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KPiANCj4gSSBkZWZpbml0ZWx5IGFncmVlIG9uIHRoZSBmYWN0IHRoYXQgd2UgZG8gKm5lZWQq
IHRoaXMgc2VyaWVzLi4uIA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlldy4NCg0K
PiBidXQgdGhpcyBwYXJ0aWN1bGFyIGNvbW1pdCBsb29rcyBsaWtlIGEgaGFjay4NCj4gDQo+IEkn
bSBub3QgY29udmluY2VkOiBJIGhhdmUgYSBodW5jaCB0aGF0IHRoaXMgb25lIHdpbGwgc29vbmVy
IG9yIGxhdGVyDQo+IGJhY2tmaXJlDQo+IG9uIHVzIGFuZCBicmVhayB0aGluZ3MgYWdhaW4uLi4g
YXQgdGhlIHNhbWUgdGltZSwgSSdtIG5vdCBzdXJlIGhvdyB0bw0KPiBkbyB0aGlzDQo+IHByb3Bl
cmx5IGF0IHRoaXMgcG9pbnQgKEkgZGlkbid0IGRvIGFueSByZXNlYXJjaCwgYW55d2F5KS4NCg0K
SSBnb3QgYSByZWFsIHZjb2RlYyBpc3N1ZSBkZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
LiBBcyB5b3UgbWF5DQpzZWUgaW4gdGhlIHZjb2RlYydzIGR0LWJpbmRpbmcgZXhhbXBsZVsxLzEw
XSBvciB0aGUgZHRzIG5vZGVbOS8xMF0sDQp0aGVpciBsZW5ndGggaXMgMHhmZmYwMDAwMCB0aGF0
IG1lYW5zIHRoZXkgdXNlIDFNIGFzIHRoZSBnYXAuIFZjb2RlYw0KdXNlIHRoaXMgZm9yIGEgbG9u
ZyB0aW1lLiBBZnRlciB0aGlzIHBhdGNoc2V0LCB0aGlzIHByb3BlcnR5IGlzIHVudXNlZCwNCnRo
ZW4gSSBoYXZlIHRvIHRha2UgY2FyZSB0aGlzIGluIHRoZSBpb21tdSwgdGhlcmVmb3JlIHRoaXMg
cGF0Y2ggaXMNCnJlcXVpcmVkLCBhbmQgSSBqdXN0IGdpdmUgYSBiaWdnZXIgZ2FwKDhNKSBoZXJl
Lg0KDQo+IA0KPiBJZGVhcz8NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg==
