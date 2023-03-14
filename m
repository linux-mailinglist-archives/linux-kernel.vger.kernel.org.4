Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D46B88B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCNCm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCNCm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:42:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3088EE6;
        Mon, 13 Mar 2023 19:42:12 -0700 (PDT)
X-UUID: c96b33d4c21111ed945fc101203acc17-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sfsBz4xKirUkXBNUC1aFPS9HLxB9G9FVSpJl0LUQKrY=;
        b=E3hlbhC90J3Eo9IxyQ6htXceyLFQ4UUQF/ycbS6ZveZIK2qu3AbeMjiQcHVgAU3lktqpupc5VRqM/oT1FTFbXw9HTMSNT1J2lStT5IZay18PlicjF4lYAF0jRc5YZHiErPuITeeuUmcXHZTJlodUo4ESTZMbU2lJjIdtF128bs0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:d06a43cc-bd8d-409e-ba74-8e6d83102a4a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.20,REQID:d06a43cc-bd8d-409e-ba74-8e6d83102a4a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:25b5999,CLOUDID:5a60b3f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230314104158165HU7PR,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: c96b33d4c21111ed945fc101203acc17-20230314
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1994194948; Tue, 14 Mar 2023 10:41:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 10:41:56 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 10:41:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuatOD60hyMVaxYVm7JcjpnYyA+arh7LvpHJEe5Xkr4RAUT+YgSOfM+C1hac1PZ9GGgGUd5tG1N8z5403++AZTb05/a4EVm3dB61n1n+Ced3Hk/wRso5hs2yap+EjAoBmt/rrIx/wS3rWYncM3eEV5D1v62E2JpHtDrrLKnGAtmov9eS6a6UxVnA3cwpRj6e4vcJ4p7d4dijexLztzlrt8i4NwyB7arJQst5yDThjG9LT/PykFVP6Dj/68uOKl6EYtbctVIvFHmYVD2yjVBT5kjzz8ZLqiYCT1PNABN1neXJJ3lSE8PhuvoNtB+uchiJzuVy4EX/ddtf/x7zuZsbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfsBz4xKirUkXBNUC1aFPS9HLxB9G9FVSpJl0LUQKrY=;
 b=bzeJ3KVq7EHu9gMXQjnnFVOduuYGQ4ETTzrhoEtIBHUUXiW7OcUvRglnKTwyW4D5h9E1P0VtZc4QqAKL0QyrJnOpYSSfvRA6J86TfHp1cF5TBTu5SGSJqUQE0uUvyG13qU5RBHlxUqIf+hsaqZ6ho5DtGbeJ/Mz+ueLDMosucHgjTJEGhLJkcB4kaF9MHfxS0jjkpJ6qzNe0wfs3VdqvGeBdNMJ6y5UgQzk+iyq41KfXZnrMEF6rcF4t+1iZH6l8hfznUF0bqCviVokbORP7XE00mehcQFNwIbvX1ExqxNVLmotG3ScYygy4T1DGu+dyREnRFYulCM5xcHsjBVTQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfsBz4xKirUkXBNUC1aFPS9HLxB9G9FVSpJl0LUQKrY=;
 b=eIQStwPpFtfgCVfYApiwWUyl/JlMVJtp+sD1h/roOz+oAHJ0u978PveHqD4KEO/EsWxbXBpeeYvKO/YMwWQzkwWrsHw1jjULgUbLiUADn3i6r2ok5DM2lSEi2FMb1LAYsNkDCoWPzBxfJePRDDR/e/bb9fyDaPY6EvJ57rW41bQ=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB5576.apcprd03.prod.outlook.com (2603:1096:301:65::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 02:41:54 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:41:54 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Topic: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Index: AQHZUMu55xpLrGlpK0q5UZyv49KYAa7wscOAgAjpuAA=
Date:   Tue, 14 Mar 2023 02:41:54 +0000
Message-ID: <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
         <20230307080555.14399-2-yong.wu@mediatek.com>
         <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
In-Reply-To: <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB5576:EE_
x-ms-office365-filtering-correlation-id: e7dc5e06-1731-4013-483b-08db2435ac78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYRjGpBlXvtNQ0lCcShCRiz4eqeBGDnyeaTO8DYakBBb4xNBAzTDFhIDhu/EbW+m4CnhW+BcMCErPW7aRPkr5gWcrrhfNYpNrKW2HFQh3ZEXU47XjAoBfeDejK/sN475PxJhKuFseVgphPI/kqgyd9pnHOrYzI7Q4pNbpaaNM4+FSceD+JmzD7xGIaQ/fAKvoHwNKQ8rdAvufZ97BIGzaJHilQy18kGI67hEv3i9nomAQ5u2bKOe2tdw2RhZcNmpUlUtIcCYz4fe8rJh6htxBQuA23v7Ua6KkidGQGzrtEE+itxJIOxCJwk2jmG3AaGtVXCEYtvJOVfDRMS7ID6i2vqkpboRTL2E28/RRgnbjdsIeJ0ftW31Z9bN4NPQitgdYEjc3XbOSPsgsX+vwkJ0sB4ZcgOSQ/AjGJzK/4MEHx62nX6Qg4qRCZT5x6mEn6VP3js1lGjrtYEVlxJkVuK0y+YLNG1CQzAnqc4UEZL6Z6HJc81CoE7h/58uq0pN+Rgir2YbVsoeXarJhPhm0ve7PpWpd6mf04a6evzR8CyxLvk2uw+R277NMXfhC7qCnIfOJnyrVAJ+9I1n5jwfjdP7LAjXzfneRUGW5En5Q2yPxQMP6lat/nB/LEcR5tOYtPy7q1c10VlYhRqA/psTvwL/lYfJJ26PJ02xqSqT5Vm1BbqiJQjqe3Zagk3pXuC5/JUETkIsuHyD/ebjqoQSGsXu3IdWPzOeeNQYcAbkKgCxMcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(2616005)(7416002)(186003)(53546011)(6506007)(6512007)(26005)(8936002)(83380400001)(38100700002)(6486002)(38070700005)(5660300002)(4326008)(64756008)(66446008)(85182001)(66556008)(71200400001)(2906002)(8676002)(76116006)(41300700001)(122000001)(110136005)(36756003)(316002)(478600001)(66476007)(66946007)(86362001)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXNOcHBJdmt1VXV0MW8wWEQ4UTNsWVZSVmd0dnZIUm4zdGVtUFp2eUhvRFBs?=
 =?utf-8?B?RWcxUE1qeHBRWlprUndQSGJpV2Nja0NrdVc5aldQbWlKSWRSK0srVmVuazNW?=
 =?utf-8?B?bTBxQ1FwRGpxL0l1TUJmaE5Xa09iMGE3NHpYY2dCYVI2Y0ZHU21EcmVXdTda?=
 =?utf-8?B?TGIxYmNUZXRzMUxpejk2cVdSY1ZmQXNodzE5d0RXUGN1a2FMV09xc0dNemRY?=
 =?utf-8?B?eER2TDZiWE04NERRcURtMGgvbEFkRmxaUHRnRmJFNkxMSnVoOThXaEFKTjJF?=
 =?utf-8?B?ZVl6ckloc3RHR090YU1KYXZzMHh4a3RLQ1pDWUk0Vm5vN1JLMzFHRVp0cWhB?=
 =?utf-8?B?TFcxS1poZUpZZjZhVHdWZGgya2IvMUtVK3dUNzNLZG9VWU9QaElQK0ZOKzBZ?=
 =?utf-8?B?VzRDODI5Qm5JNFdqZnRYRGpNY3cxSGc5SGMybmxzd3kyVjVKenhaWnlhSjFi?=
 =?utf-8?B?TkNvWWc3VnJuS0JsaTh0STlJUmdGa3lmTjFybWpwSGYyeThjNGk2MzNwdmpJ?=
 =?utf-8?B?bmluMHdrUHBrS2VCTWFjWTA3Q2YrZG9lZC9aU0hZRUhBK0JvaU83L1lsZWt5?=
 =?utf-8?B?ZDY3L0pYNXZrSFYvQ3lncWM0THdWMDZxa0QvMzE3cVY0NDBndVpFRzhZVXFJ?=
 =?utf-8?B?TnF2L0NBeXhqTGxxRXBvK1lWbjZDUHphT1lKUFlkT0M4dXl6TWlmTVVSdnF0?=
 =?utf-8?B?SzZZSDczNjhWSDdTTXZkQVB6WFpTaDI4Z3NpZWhDd0dISDUzRTVSKytvZC9o?=
 =?utf-8?B?L2ZtRW5lVWh5Q3Avc2Rkdld3Y2ExRUtRaTZZcmtlU2dOTXdqU0RlUEh4OCtk?=
 =?utf-8?B?K28vWExrYUsvUXNBWUhYeDFhcUVjZXNHMm8yRjdSZTY3SHMybjNTb01rK1Vo?=
 =?utf-8?B?NVhUZDRNZDRNdVpJY3Bzb2F1d3VWeE4zN25JQWpKSmtJK3Bnb0hWazZEeHJC?=
 =?utf-8?B?L3ZDUk5kN0lqSDRUUFV4S1V1bnZIRmwwbVdZMm9RTVJ2QklKTDdhWGVYS1Bk?=
 =?utf-8?B?UFl2Ym8zL0grK1VIcHYzZ1FRQlk1cHhHYUt4NHZ0OEtJbEVsNGkyR1hPdGdI?=
 =?utf-8?B?UmVtY1ZuTXhpdytZOEhuaDNtY2FGa1RtY3VGcnNxZHJseEVheVAyVExMNk9s?=
 =?utf-8?B?WkkzR1ZPck9vUWVPV1pjL25OOHdUWmgvSXJva0YvSVQ0R0NWc2RrbFVtY05P?=
 =?utf-8?B?UTNvREdWbnZuRmtKZGNnL3J3bHJyODFlOUtWRUc2b1dINnpFYnpZaWZ3TU9u?=
 =?utf-8?B?a1pWZi96UnJGR2hXV0ZlMUNxemt5YnZzdUNiQ1NCRzlZdm9vL3JCaDg3MXZB?=
 =?utf-8?B?RTRScnNPdkY2REhla0JHYkJvMVJFQWErcCtSTnlRTlhSVXZpdU5Tdk9wTFBi?=
 =?utf-8?B?L1dHUk5CTXYvQWx6dVRDT3VGM2RCTGtNa2ViYVNCRndKSTVGVHNUZlZvSUJ1?=
 =?utf-8?B?UnpmbE81ZTNuYWpiSDhlamhjVmtxQ2UzY3FNQXJkME5qWE02eUs2bmdvNWh6?=
 =?utf-8?B?eWtjcC94NFZHcFByV3ZRa2tnNTlLaVA1OGw1bkI2QldJZjg4T216ZWVVS1ZQ?=
 =?utf-8?B?TC9zMGNHRkhtdkxxOGZzb0R3OTBxeUllRVZ3YnU4clRrQmpDTXRTUlNWbzB2?=
 =?utf-8?B?R3pWUE1heVRBOXNMZ21qUUZkKzZRdTF6V0RnK0tXNmx6V1lVV0pzdGwvU2l2?=
 =?utf-8?B?d2ZCZFBRK3pEV1dtVnFqa2hMcyszYVN5V3hUemZQcnliTzdqVmtPcjhqdjJh?=
 =?utf-8?B?c1R0NXA4bjRXTi8xa1UvM2RKUUpSQVdmaFpObWczdDlZVUNmNDRUZFJGcFhG?=
 =?utf-8?B?V0VHSXplREViWjZlZ3JrcnB1alByTXNJM0NkZHlTYjNLeEpMSGtLSm1NN1pC?=
 =?utf-8?B?UG1udWVtdmpGWWZXM3VaN3NJeTF6Z1BSZ2p4aXIvWjFYM1I2RFRrTzNUME9y?=
 =?utf-8?B?SG5DbUFaZ1JFWWZza0crNHBJTDRqdUR5dkVZK1c0Sm5ld0Z6UzNXdWxacm8v?=
 =?utf-8?B?bi9UbWFvM0hEd3Q2VjdXdkxlWWtCZ3JtbXExTWY3RnFMNlNsdkhMdXBjdHg2?=
 =?utf-8?B?TWZPck1MbGJIMi80QmZXeGV4MmtUU0NwMkQzWkFsZHhWbnRSNHdHdjRIR3Vp?=
 =?utf-8?B?T2ZPWGRBdXBOTE1xOURUT3FEeXYzcEs3TTh2bS9lWEk0dlpUWnMrSm8rdVZr?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2AA8C37E6296841B0D7203997A3E715@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dc5e06-1731-4013-483b-08db2435ac78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:41:54.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nC4oYZ5LMkuzBl89yvkBayaM7i9iyx2LRjOIGeUt4eUtMynNBc6TVsDhiM++WAczvWePapFPAZxFMx4bYfXUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5576
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAgcmV2aWV3Lg0K
DQpPbiBXZWQsIDIwMjMtMDMtMDggYXQgMTE6MzUgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IE9uIDA3LzAzLzIwMjMgMDk6MDUsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gRnJvbTog
IkNoZW5nY2kuWHUiIDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBBZGQgZGVz
Y3JpcHRpb25zIGZvciBtdDgxODggSU9NTVUgd2hpY2ggYWxzbyB1c2UgQVJNIFNob3J0LQ0KPiA+
IERlc2NyaXB0b3INCj4gPiB0cmFuc2xhdGlvbiB0YWJsZSBmb3JtYXQuDQo+ID4gDQo+ID4gSW4g
bXQ4MTg4LCB0aGVyZSBhcmUgdHdvIHNtaS1jb21tb24gSFcgYW5kIElPTU1VLCBvbmUgaXMgZm9y
DQo+ID4gdmRvKHZpZGVvDQo+ID4gb3V0cHV0KSwgdGhlIG90aGVyIGlzIGZvciB2cHAodmlkZW8g
cHJvY2Vzc2luZyBwaXBlKS4gVGhleSBjb25uZWN0cw0KPiA+IHdpdGggZGlmZmVyZW50IHNtaS1s
YXJicywgdGhlbiBzb21lIHNldHRpbmcobGFyYmlkX3JlbWFwKSBpcw0KPiA+IGRpZmZlcmVudC4N
Cj4gPiBEaWZmZXJlbnRpYXRlIHRoZW0gd2l0aCB0aGUgY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4g
DQo+ID4gU29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiANCj4gPiAgIElPTU1VKFZETykgICAgICAg
ICAgSU9NTVUoVlBQKQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgfA0KPiA+IFNNSV9D
T01NT05fVkRPICAgICAgU01JX0NPTU1PTl9WUFANCj4gPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0g
ICAgIC0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIHwgICAgIHwgICAgLi4uICAgICAgfCAgICAgfCAg
ICAuLi4NCj4gPiBsYXJiMCBsYXJiMiAgLi4uICAgIGxhcmIxIGxhcmIzICAuLi4NCj4gPiANCj4g
PiBXZSBhbHNvIGhhdmUgYW4gSU9NTVUgdGhhdCBpcyBmb3IgaW5mcmEgbWFzdGVyIGxpa2UgUENJ
ZS4NCj4gPiBBbmQgaW5mcmEgbWFzdGVyIGRvbid0IGhhdmUgdGhlIGxhcmIgYW5kIHBvcnRzLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nY2kuWHUgPGNoZW5nY2kueHVAbWVkaWF0ZWsu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPg0KPiANCj4gSW5kZWVkLCBJIG1pc3NlZCBicm9rZW4gY2hlY2twYXRjaC9EQ08gY2hh
aW4uDQoNCkp1c3QgY29uZmlybSB3aGF0IHRoaXMgbWVhbnMuDQoNCkRvIHlvdSBtZWFuIE1BSU5U
QUlORVJTIG5lZWQgdG8gYmUgdXBkYXRlZCBzaW5jZSB3ZSBhZGQgYSBwcmVmaXgNCiJtZWRpYXRl
aywiIGZvciB0aGUgaGVhZGVyIGZpbGU/DQoNCg0KPiANCj4gTkFLLiBQbGVhc2UgZml4IHRoZSBj
aGFpbi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
