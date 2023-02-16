Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F2698BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBPF1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBPF1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:27:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900E1EBD2;
        Wed, 15 Feb 2023 21:27:26 -0800 (PST)
X-UUID: 8e4544d6adba11eda06fc9ecc4dadd91-20230216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZdjVQVl6WWCl+LRSQIjEokC9t3Lx5LTXM/5cljsO5VE=;
        b=eI9WAZxj8BPjxSXT2NSTua0BNnkkWWmycif729psorK6mJS6uvtzEDZ1PgWWshq6a72lwvsDgUU8RVnKdFQsmJSscnm8HeSRfSSrxgfrVz7QtVKTrUaJgGDjfMX0XxNanaAP2tU865dmSeL5J3uU0WRfk9WmtzZqPp30RltgbAs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d2ef28ce-16aa-4dd3-9ac7-dca69a6185d9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:d2ef28ce-16aa-4dd3-9ac7-dca69a6185d9,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:bf3529f3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:23021520332381DP33XQ,BulkQuantity:24,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 8e4544d6adba11eda06fc9ecc4dadd91-20230216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1063451475; Thu, 16 Feb 2023 13:27:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Feb 2023 13:27:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 16 Feb 2023 13:27:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by2glLoj2H9lBMIAjJnAL86XKn+kVlHNNyaoCng6iJPETYM/uA/WILybpHig6YTSB60BJ6sJNKYqkdI7ro3eI2xFYvFt1ZWxri/McBABbD/m85TPMGGQ5RL7Ml2chtdJZgjihDLOnic3B2P++mq0nZfZWLKAz2xbUSuEeoW10+pRrgoWDk/58piHX0Un+JtbuF0SpHx18STf4kX9NtzJDAkKuqN2XassMbchovp20/Q+39wXztKmSrb6XMeY2AZnpQTayvIFrguREF2n9YwGL6glBJNs5T51z+LZ3nx8exJKLVgpFqmaMaXarhuLM0c099eelaJw2WmWmcZSlgjfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdjVQVl6WWCl+LRSQIjEokC9t3Lx5LTXM/5cljsO5VE=;
 b=ZReE6Cf2nWF0vpqsmnN1kQnyVCZkwHNXzbv3EfgvkJyt6K8CW0fxhIP2JadMswJcHo5bMBZ5NANDw05e2m8qeALaqY2SikhuJdD/fIx9w1KrtOQHGRutYyfJGbTUyFhKxEKAYdeDRiDfslOft+cfl8sLKIbx3dLfLpxuafff4V5YGrpAIxnJbhJfdqryCfu82j3VaKn+OQr9xCaj74MGa888DGdyPNFyyTUplnktF9lmAvu3fhadO3CKbxCA9I5BBedxF+yeuB7KdOpDn3aJ/KdWhA7MoClE8zk8ytZ0/Qny/6HBD7V5k3ru9rcUhkeVyqX3Qez18yhVZZcQdqXorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdjVQVl6WWCl+LRSQIjEokC9t3Lx5LTXM/5cljsO5VE=;
 b=QKbfDkJsaHuIedFM2xEcoHvvB/mEEZfrf+nuxw6eriVHBSgA3q5fH/3EZU673w7NReyj5nhsSchJgZUeafUnyYdTr3gAW4SzO6mTLfXjX/7mwnB1GCUQjkGMZPyNsVPXVvY/rBqxDDPQrIqi6Xv889v1GqUhYFANzrLx2DWPPDo=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6696.apcprd03.prod.outlook.com (2603:1096:400:1f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Thu, 16 Feb 2023 05:27:05 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c%6]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 05:27:04 +0000
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
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
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
Subject: Re: [PATCH v4 05/11] iommu/mediatek: mt8192: Add iova_region_larb_msk
Thread-Topic: [PATCH v4 05/11] iommu/mediatek: mt8192: Add
 iova_region_larb_msk
Thread-Index: AQHZQQaaS7Nx677VQU+0WZJgVbKQPq7P8UYAgAEbMgA=
Date:   Thu, 16 Feb 2023 05:27:04 +0000
Message-ID: <b15c64dede5dd18b358583ac135607d6b43c46d1.camel@mediatek.com>
References: <20230215062544.8677-1-yong.wu@mediatek.com>
         <20230215062544.8677-6-yong.wu@mediatek.com>
         <5701f81a-07c2-e3d5-d2fc-92c7fe4df58e@collabora.com>
In-Reply-To: <5701f81a-07c2-e3d5-d2fc-92c7fe4df58e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6696:EE_
x-ms-office365-filtering-correlation-id: 5f1ce504-eca2-4d3a-f1cf-08db0fde7074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0wGjzvgPawO+oI4UxcvsqUaQ6vZEAKYSotjVkHMB585/izZ6cx60R9Lc/GIsKoAMbfTF/uuiedvOBtRKm5wIh4wFa0TCcSqtl+ooheeWUj/RpEmff2CJz+7HQ6xeLniFncLvPLiHERvEnSESZpXPbgHIGABjXT324NlsOqpizorKwmPaQw+cv2cs0FdnHmhFBF4Ey5UpMpWXF2sj+QIEB0Kg2pwotdMInA4P49CbTG0CVPN/vJPXw0okmnK9aVrzz84iCXG1R3gF8jnIORpVUN4z7qeekun/CSQfmv1zTXA8b4kF6dULalGWZVzYpsAnABK9yEkBCQsjU6F4PY67ZRhhfMVs+lxPR6daepF2JZFNoO6L2vT1/bj9QCdJGDGVl0bV5qAYly4TDC3oz2ixFvS929mhY2fIJtLJwuN1aOPpfPA9Y7N68w9gM7RKTK0mb9AOCGF+GMXEbkgLe0gamFoj/Gg5MwUjNUhHbaDrbCtJJZX5qXlmLW7n2OCt3d2jha/tWI6RpKZT70BR72i3iI9i59M0FpmgedyaqE9YT6/fT6sTSTxNauYyci/TnmRzbw0ZmFsW7SvOyzn7bRDomJ6eEu76AzdDhDCbq4tDShPDfaaievaJT1jcYd116e6sVYIYjHka1SVbuqrHr0581N8SuSugTDMNBm3Tulc9MwIoRuG/b2KICsJjzDXJ9LrGp6aOJfWES6ber+8/zQM2SRlWQZXi0TKokDBugcETdE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(6512007)(478600001)(41300700001)(6506007)(110136005)(71200400001)(2906002)(186003)(26005)(36756003)(85182001)(6486002)(38100700002)(86362001)(66446008)(76116006)(66946007)(5660300002)(66476007)(8936002)(7416002)(66556008)(316002)(54906003)(38070700005)(64756008)(2616005)(122000001)(8676002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUVZQXhpVzVMN3RhK1VZYWZBR0dZbHh1bTJOVVNacDM3ekZrOHBONlp4VmhY?=
 =?utf-8?B?S0ljN3ZZM1F2SE1taFg0SkhZaHVKSjRPY1plNi8rRndrWTlvazBKNFhwQm5w?=
 =?utf-8?B?N2xMbXBMWHlEZm81UnBzOVNuWEcvQ0ErbUdFMHZ4YjJpMXdBRVE1bzhoVGg1?=
 =?utf-8?B?blJkWGFLQlVwMElnQjFUaFNzQ1o5enBibVhGc3ZFenEyZHpnZkgwNE16R2ti?=
 =?utf-8?B?dXVxN2hvcmxOWXFJR3JVN2dRQm5ldWpkZm5aUjRkalhIZEoycXd5NUtYTkRk?=
 =?utf-8?B?VVFsWEo1NDFHdEMyS3huM2llRVFDTGxzU3NpbkloWXVvUDVNcXFVbEUzTUgz?=
 =?utf-8?B?UW9OR1lCVmZmYm5ydVV0dHIyMjBNQlBNK0orMVhIUGQ5SWxDTU8zc1NYY3VE?=
 =?utf-8?B?NmVoZS82ZitpZG9VUVZxcTJSZmI3M1BlSDFwZ2xONy8zc1ZrU1U4MFVDZUQz?=
 =?utf-8?B?SExocmhnK2Y2NXBCYlF6VTJLQkpaVzZZbERCeGN3ZitCMXhPL0pRTm5zRmIz?=
 =?utf-8?B?VUpZY0tuMlZHc2FKaGNvRUtFOHlLaU9pbkRnVGZWRWdoUkFjYzBMbEhWOU53?=
 =?utf-8?B?by9kTzR1aVQvR3lIOXBtc0NBYjl2aXNjRTMwSDRMN1Uwb0hqenZJUnpScG9V?=
 =?utf-8?B?ZCtZL2ZDdmRrNUs1V1h6MU13RFV1UmZKUkFEWUIyS3IxY0VtblEvTjNZVEZs?=
 =?utf-8?B?STNlbEFDWE5QRkQxYU9mWjhab1FtTTlUbVJqaGZLVkNENzg1VzF3dlBVS0RC?=
 =?utf-8?B?cWNZN1oyZllxeU9BL0VuNG9ERHVRVHorcDFKRDMwL3JWSHA0NFdiS0tkVDh4?=
 =?utf-8?B?SlpvNHNGY1hnQmRJbDlBZWtjRm1EWjJnWjQydXp4VWVYUWM1YTQ3WjdJZFhP?=
 =?utf-8?B?THBRZWkwZE1JQ2JGaXV5OWdaNUhDZDdXbGsyTE56VFVKamcvNXY3V2hTM2w1?=
 =?utf-8?B?QnFSRDVZd2NvUmIyRFJTVSt0bmhQU3ordUFVVW1Sdit1b0U4WFhBSUFudHcw?=
 =?utf-8?B?OGYyYllIOUEwQ3FHUFpWQmdLSyt2ZWFJWndCclJuOTA3OEZHUU5GWkpQVEpB?=
 =?utf-8?B?NnhEN2MybHJmVHM0Z0hTd0NETkx5amxFb3k3UFdPeWdLR21scDVjRGtoN3dm?=
 =?utf-8?B?c05MbXBMSzNVcDhxMGNDc1VvTUtSVXpTMU5sUnZ4bFRSK2o2ZEZUc3NIZEtl?=
 =?utf-8?B?ZDRydVJqcHgzaExvYXNiTGxRMGZ2Zjc5RGFzYWk1SjdSL1VQdDgyZlptZy9x?=
 =?utf-8?B?aHMzVzYvT0FIekVneFJuU29Lcy9oeEhqVEtOSjZ4QVgyVTFYNGZDZmp2dE9S?=
 =?utf-8?B?Y3lEdnhnM1pFeHhsS3dGR1JlRnBiNVlCTEU3eE56V3BvOUt2dVg3Qlh5MW9Z?=
 =?utf-8?B?cHlNdjdSU2FTTVZtMW9iUy9PZ0ZBYndCem1ocXB6TWNyS24rNndJTUxTemNp?=
 =?utf-8?B?bnp3c1hJeTBDUFlRUi9Qa0tZTWMwbmZuL0Q0NGpoMDRKbWdaUFBCbnBhMCs5?=
 =?utf-8?B?ZDlBZDlTQ2x3NldNY0dxb2xSMG8ybVJrZ3JrMFlReHJiNi9pWUFteTZIVUxS?=
 =?utf-8?B?Uy92OEFYZHZBcDFYRWpYaE5VajhvZUNYUytyakkrZ2V6dnFXOXE0T3pXNTIv?=
 =?utf-8?B?TzZwV1UvSUV1R3hkdjFaYk4xamROSjVYaU1zREFMNE5xV3hudGVzNlJLZURk?=
 =?utf-8?B?MSt4Y2JlZU1wUDdWckpucjRJczFBL1pZZENsbVVYVG9lUjdoaTZubHM5M0VV?=
 =?utf-8?B?dUVPZE9CU3R0RHRHcTRDNGpQUHFuM2VmbVZkVFI1VkhPd0M5L3lDK1FPL2dY?=
 =?utf-8?B?bW9qYk16SzJhcHd2TnA4MTcwZzZIazhNWUgvUDNoRDJkKzVnWFhHWEdzd0ww?=
 =?utf-8?B?anVHVDkvSWtMZXhxcTdtZ3l1WUw1alVLdVk2MktEeWkzNVMyTWVpQnNCMmVv?=
 =?utf-8?B?cm1PaDNaYXpjQ1lqczNVakFhR2tWUThpUG84bENVTnJveUVleGl5a2pEaVFX?=
 =?utf-8?B?MWJhWXNQUjJ3N3ZJbVNIRjFKbWc2OWtHOHd6TDF6QzhCeW5vVzB1LzdQZUFG?=
 =?utf-8?B?UFByWVFtR1dPU1lhR2h6U2RBazFSOGwrc3NUZEQzUTlsdmxrRG9acGloMWRh?=
 =?utf-8?B?dEtnVHF1eTA3b2ZHbjN4WUY1Qmo2TkdJWFlWVldQTFc1UTQzK0F2NE5nNlhq?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D2320CB9EF197488E0400E1D095B226@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1ce504-eca2-4d3a-f1cf-08db0fde7074
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 05:27:04.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rT2EJWp3e9z+RJfpDz+cq1gh/TQBohTWVCTUpuC+vrAxR0ljt8f/eq99LAUqFBQ8xuo/8JLVsOBQkugR68Z/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6696
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

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDEzOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTUvMDIvMjMgMDc6MjUsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBBZGQgaW92YV9yZWdpb25fbGFyYl9tc2sgZm9yIG10ODE5Mi4gV2Ugc2VwYXJhdGUgdGhlIDE2
R0IgaW92YQ0KPiA+IHJlZ2lvbnMNCj4gPiBieSBlYWNoIGRldmljZSdzIGxhcmJpZC9wb3J0aWQu
DQo+ID4gTm90ZTogbGFyYjMvNi84LzEwLzEyLzE1IGNvbm5lY3Qgbm90aGluZyBpbiB0aGlzIFNv
Qy4NCj4gPiBSZWZlciB0byB0aGUgY29tbWVudCBpbiBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9y
eS9tdDgxOTItbGFyYi0NCj4gPiBwb3J0LmgNCj4gPiANCj4gPiBEZWZpbmUgYSBuZXcgbWFjcm8g
TVQ4MTkyX01VTFRJX1JFR0lPTl9OUl9NQVggdG8gaW5kaWNhdGUNCj4gPiB0aGUgaW5kZXggb2Yg
bXQ4eHh4X2xhcmJfcmVnaW9uX21zayBhbmQNCj4gPiAic3RydWN0IG10a19pb21tdV9pb3ZhX3Jl
Z2lvbiBtdDgxOTJfbXVsdGlfZG9tIg0KPiA+IGFyZSB0aGUgc2FtZS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4NCj4gDQo+IFAuUy46IEknbSBzb3JyeSBmb3IgdGhlIHN0ZXAt
Ynktc3RlcCByZXZpZXcgYW5kIG1ha2luZyB5b3Ugc2VuZA0KPiBtdWx0aXBsZSB2ZXJzaW9ucywN
Cj4gICAgICAgIEkgZmVlbCB0aGlzIGNhbiBiZSB0ZWRpb3VzIHNvbWV0aW1lcyBidXQgLSBhdCB0
aW1lcyAtIHRoaXMgaXMNCj4gdGhlIG9ubHkgd2F5DQo+ICAgICAgICB0byBtYWtlIHN1cmUgdGhh
dCB0aGUgY29kZSBpcyBhcyAiYmVhdXRpZnVsIiBhbmQgYnVnLWZyZWUgYXMNCj4gcG9zc2libGUh
DQoNCllvdSBhcmUgdG9vIGtpbmQuIFRoaXMgc2hvdWxkIGJlIGFsbCB3ZSBuZWVkIHRvIHRoYW5r
IHlvdSBmb3IgYWx3YXlzDQpoZWxwIHVzIHdpdGggYSBjYXJlZnVsIHJldmlldywgZXZlcnkgY2xl
YXIgYW5kIGNhcmVmdWwgcmVwbHkgYmVuZWZpdCB1cw0KYSBsb3QuDQpNYW55IHRoYW5rcy4NCg0K
PiANCj4gQ2hlZXJzIQ0K
