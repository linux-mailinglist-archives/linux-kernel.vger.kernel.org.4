Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DED73269E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbjFPF3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjFPF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:29:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4692966;
        Thu, 15 Jun 2023 22:29:46 -0700 (PDT)
X-UUID: c9e02ab00c0611ee9cb5633481061a41-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Br0lwdUZ5nMDHsNGlzazKgWY2uvaNzwPvtkKUO6QtKw=;
        b=J0MbY9HkYsNUIJ9xDh7ZsaeXU0fGSpuTokFsAmrad3wbrPy/6obYDpaQkr48KjJTdnbJHRPeCpYK9w586EuwdVNlOQr/VvfM5JTpreJAHFHPosBEGuh8y7iAvESr+ifHE/4L5X1cySK38LunywvOq5QVpbbi3Uc+zVUXkgN21qE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:e481e391-23e8-40f9-8c4a-7e75c0275f7f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:68
X-CID-INFO: VERSION:1.1.26,REQID:e481e391-23e8-40f9-8c4a-7e75c0275f7f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:68
X-CID-META: VersionHash:cb9a4e1,CLOUDID:b2a0416f-2f20-4998-991c-3b78627e4938,B
        ulkID:230614194207RFZQALWW,BulkQuantity:15,Recheck:0,SF:48|38|29|28|17|19|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: c9e02ab00c0611ee9cb5633481061a41-20230616
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 645858517; Fri, 16 Jun 2023 13:29:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 13:29:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 13:29:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuAB7JuJmcsxeWUFJr6kosgsr7N8QwW+EY37oWxVFZKsqRHuE3nDzGpQVpkKA5gYng9rdZfHiel8gFbQ7BIMFFk9O5j8xXQNpc4njtq38mtiwEEhOUCykzdV2ugpcScu3FrwvRaIC5+kfMMvE6Ll9MX/JXdOAEbc8/AVUqfaiZPDYX9vfah8gKMjpvRH0Wq+SjfOJKqtXHzI6b92aUMH8hX6NOg8Dh8g4wxjbrVl45r5DvD6YOhBXScprcc5qrC0F1RRH6JJVnzcc3HEqzBY9d9lgDH5P1fTePgL9woV+4glqkUDIiXGNlfwJdABnNxr2ZQY8FxZpBK+yVus/TxJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br0lwdUZ5nMDHsNGlzazKgWY2uvaNzwPvtkKUO6QtKw=;
 b=QgOkcPdaNgLSxERTMDZ7wPOYWKFN3qX+mQ72In282+6aWiL92RvNJF2zpUjVPFhKbqW0pI7tpDaFX+I5cqZ2BYuQ9xs+zanwpPJQR4uAQRxP07t673EANSzoX4uOs5qDwCBs5cDFExmlnk/OORC1zuv8cyv/XztS3sQuZflXqKsPLGC2Y44v5som92kUqZA3cdwb7uCsAsd7ZadlzfPTmwDtfg9LrjvWbl9PT9VVPvdOje7bOY2f/d3zZn2/MuNDuZ67wEc47lZyTOuAAV/akxgE9ermlyj3c9RmXg41HnQj9I2j12kF6RLdA7RizJNhenHZ+kbNzR4dft7RidANRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0lwdUZ5nMDHsNGlzazKgWY2uvaNzwPvtkKUO6QtKw=;
 b=HeYK8yljFD0KRTjpNy3yjrSS5yJSCsUnlyJIFxp0dKx7Syq6vWchdmDNPKc/MrlXhSXLPEqPCxYwku7/SVXdZftfsGy+IRf1GC8Ms3+Qnr1qvb6EGqMELcSRlbqU9+Y0C1ZLTqwVkpsa3mDrD84+WyrjEOOD8A7d6+PHs/+AnWo=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB5995.apcprd03.prod.outlook.com (2603:1096:400:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 05:29:35 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 05:29:35 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Topic: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Thread-Index: AQHZnpJ04dr81uVobkOio2R0/Knn6q+LiYOAgAFgZgA=
Date:   Fri, 16 Jun 2023 05:29:35 +0000
Message-ID: <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-4-shawn.sung@mediatek.com>
         <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
In-Reply-To: <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB5995:EE_
x-ms-office365-filtering-correlation-id: b82f8998-e66a-47bf-f5c6-08db6e2aabae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvwCN+8kCCAJKox0CqqNKXuUcT5xNBCVkH/UJQWXb0k0Vrl0Oxs49I2H0KI6Eg9Kn5UQHno5SXfqxDh7Ikl+aGrLpgdjbrz56QjoWehSFAWaaYdgNq3+5KVpLGCnn2pK+haQ2pik96jsMBoPrhstQY8Dgh5UsrEmOH8S6iTUXL9BTxCInRMepzt/WcOx3NKkC72HFfbYcw7NgeVuej9vMMpCySEBOiIVU+Bo/wgB6jqDcpw9tCIw7mpqeFHzewD2xt4jEqKeIu6r7wjdt8PYuwHFLpHCq7gcM3t5MoNVCvKWc3Sv1OvL2qAR5p9VVYE5dZeItYg+EMIYsUXs7ifkojSE6LX5QE9W+0frmdV8tVkWKltdzZFNdiG185/jNcCSKiFYBvrfXb5SYBpCcz/72oFTQFZQCwpM7DlQKNhz4zlSwRqVIdIjuadLqApK+L+OoJUImNrCSGHbG5ok3zmIzEOehhKTuAtSfdsHTGy7U4NLdBRhRdAsYQz+nabWNaoZ5XFgvITy7ftW3S+F+9v+wpEILit18OHNJQJGLgZlqrGG/APgfsuVuW7FCmdvbgTiRsMa59RF7OPX6a5ZeICREK0y/wUKwQJ7tXnPXFuyN//PYLqgsjhydNFaH8PkciiWcLYJNQ9YgQcZGkt+LJ/Egivro+/3ZN5RP2Vsv8rbg5U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(36756003)(85182001)(478600001)(122000001)(38100700002)(71200400001)(4326008)(64756008)(66556008)(66946007)(66476007)(66446008)(316002)(38070700005)(8676002)(6486002)(8936002)(41300700001)(5660300002)(7416002)(76116006)(6506007)(53546011)(26005)(6512007)(186003)(86362001)(2906002)(2616005)(83380400001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M21rZ3VzZnhHSDZYNUg2V24rdlo4MVJlVGg3UGFMTGtpcnluVzE3d2pKanEz?=
 =?utf-8?B?ZlY1MStJWGRVR3lNSTV0Rk9lckVMa2IrTklGUlkxWldON0k2bDFXSmg3QzZR?=
 =?utf-8?B?MWFIdG5NYlliWFViditadFpJNnhiVGRjanFadzlpVTJHdWM3ckRwdVQ5ZEF1?=
 =?utf-8?B?RDJBZmQwcFBvcmFsMGhuTlBWVkdscitQdHgzcHlWQ3IrSHVuMTk4S2FtTUc1?=
 =?utf-8?B?SDMxeFdwV0ZpNXl6cS9NblorNDlXWEhFNHJrZVdnYktob01ocG9uZlNZc0ZI?=
 =?utf-8?B?SUdqUEVjQ3ZUaUZDb3MvQW1IVENyYVh5NjFSMExSN3FqMjhpUTJhT3lrajZm?=
 =?utf-8?B?TUI4YldXejlxclNwUTZzOUtuc3RoWXpQL3NUcTNJQ0FGZWdkMStvQUlzRnRi?=
 =?utf-8?B?YUttYng2aUNWaDFaUkVhc1FINHBKa0lwZFJHR2hKcjVGWFc5QnE2emhLaGpX?=
 =?utf-8?B?YlZMV1JSUk1hYS8zM0svZHppRkZsN0RpSzJTWFRaOUZQbXpWN2ZyZGpGaFJT?=
 =?utf-8?B?c2IyS0xQWVl1bGYwMEpXdWVJSzB4NVd2cFhZRU5ZK3hrblB2NytCYm5teTl6?=
 =?utf-8?B?UlVVQml1bmEwaSticCtRL2RjcEl4MzVReERGT2w5K1dPVi9OMVdJbURkYXEz?=
 =?utf-8?B?eHk1akFCdGRVenlUbHNwSjMyQzMxS1A0Vk5KaCs3Y01ydEtjM20wRzR3dEtJ?=
 =?utf-8?B?M3ArdDRRREY1WFpFRmhhVkpDU3JpbFdHeklwNzZHSCtDNFJsU2s2dmJBc0Rk?=
 =?utf-8?B?TUhZaWlJb2JUbGZFc0JKL3Jaejd4d2hya0lUVDdJRmIyc0NIdkpWUWtMSFNE?=
 =?utf-8?B?cHRXQ2RDQm1zV1g5WUF1NFd4SzRaUXNyajFsYjhaRTJLQ0EweFdlRy9yY21J?=
 =?utf-8?B?QjI4aXBKdWZTc0gzTUoweG1uSktwVFo3cnJyUm83eGJ0WXNWMENIS2JvV1lw?=
 =?utf-8?B?TzRtTVB5dnVCNjduL1gxTTZKa0RkdzM0a0NGeU82VnFFdU5zekZZMUwwdVRk?=
 =?utf-8?B?Q1pKK0l6blZrOGxiZyt6RWVCTXh0QXcrNE9OTXRwM2xKQlVmQStXb0hKR1Ro?=
 =?utf-8?B?di9aMjM0N2todWtqV3NYWVZLbVEzYVhMWEhKbGM1VTljNkg2Q2I1eVhuRnla?=
 =?utf-8?B?bzNtTU5ZU1Z4NjhmdTNhYTBOeE03MGt2SGk1bFR4T2ZOYXltenExYkwvTnMz?=
 =?utf-8?B?NGVVTEwyeHZyYVh0QlNacmU1NWZCS2JlNVFPNXlDbU5JcUJOeGNBQXFiVFZu?=
 =?utf-8?B?ajZYRUdzcXNESUJrbW9GUXQ4RHZzekM1MVdDR2NOQ1ZVRzNXOG1oWGZnZkFF?=
 =?utf-8?B?cjhZL0dST1llZUhocDNaWFpxRGNIcWtlT3kwY1l1dEtCWTRibTA1RGRheTNv?=
 =?utf-8?B?WDcyNXJFZVdXSW92TWxqVld0YVdNek9GcXdQQm9Va090QmdWMkRpOVgxcTkv?=
 =?utf-8?B?T2RUSDQrS0I0eWd6M2JxNWpGZnJjRTdtQzBmcjd4V2VJM3Y3VWtlbWFlTUYr?=
 =?utf-8?B?cUxncFY4czNyVGV4RGowVG9STmtoZzEwOGFDUGZJK24zdXE2TWhtWGRwdHZE?=
 =?utf-8?B?Nk0rS2JidmhtSlF1WVZpbE1hQ1ZNRDdtVEZmdmFpTTU0L2QySm9EczYzUGE0?=
 =?utf-8?B?Qit3MnhtVS9pWnY1SGNFQXRSNDU1Y1hPcUdOb3pPbVV1cFppNUZ1eVUvYXNX?=
 =?utf-8?B?SzZBcG04dDd0RE0yZVlENzhDUUUxREtKbkhpU1FmRHNhZGhOVnNGMitnSTRh?=
 =?utf-8?B?blQ3MXBBbXhRMmExMFBFaGJmVVhuNEhBWERLbCt1Z29ZeFNuZzVVSEhWMGZ2?=
 =?utf-8?B?TWE5Y2RWYlVTbjFHQ1dCMkdGVlZYR2V4YlYxb1pWYjd4Q3huL2UyZUE1OWcr?=
 =?utf-8?B?SjY4elczbWJpQzkydWVINXZncC9zZzdRUG5sNW80OXg3bVRLU1FFQW1SbjRS?=
 =?utf-8?B?SUlCRWdaU3JHR01zZjBhb3JwNm1VVDF3NUQrUVlzcmhiZGR3MzVhcWQ3ejJK?=
 =?utf-8?B?Rk55U2RrK0pIdkhJTmtWSDBkUmIwS3QrcW9WNjRGR2Rmd0d3RFZUK2ZxTVc0?=
 =?utf-8?B?ZGorUzYvOWxRb3lEZHV4MVBHaHpmOStNTWVGWlRZTFE3MHdlSnRESG4yUlAw?=
 =?utf-8?B?WkRnNlNQbHBUZHoxUDZNVXhWSEhwSXZaWkM4RnlERHJlUlRyRjN2Ty9SdGlO?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BB67A6C3329C54990D2AA699CFEFA4F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82f8998-e66a-47bf-f5c6-08db6e2aabae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 05:29:35.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYBaBMmeUc2Gz2KCsLUil1JAplQC+oPBjMrGEyoBWsdnkh0TMa2e7FFU16SlSgDtXYqwQYsWmqmumoq5emqn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgYmVjYXVzZSBNVDgxODgg
aXMgbm90IHJlbGF0ZWQgdG8gTVQ4MTczLCBJ4oCZbGwNCmtlZXAgaXQgYXMgaXQgaXMgZm9yIG5v
dywgaG93ZXZlciwgSSBkbyBmaW5kIHRoYXQgTVQ4MTk1IGRvZXNu4oCZdCBleGlzdA0KaW4gdGhp
cyBkdC1iaW5kaW5ncyB3aGljaCBpdCBzaG91bGQgYmUsIHNvIHRoZXJlIG1heSBiZSBjb25mbGlj
dHMgd2hlbg0KdGhpcyBzZXJpZXMgaXMgZ29pbmcgdG8gYmUgbWVyZ2VkLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpIc2lhbyBDaGllbiBTdW5nDQoNCk9uIFRodSwgMjAyMy0wNi0xNSBhdCAxMDoyOCArMDIw
MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiAxNC8wNi8y
MDIzIDA5OjMxLCBIc2lhbyBDaGllbiBTdW5nIHdyb3RlOg0KPiA+IEFkZCBjb21wYXRpYmxlIG5h
bWUgZm9yIE1lZGlhVGVrIE1UODE4OCBNRVJHRS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
c2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtZXJnZS55
YW1sICAgfCAzDQo+ICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG1lcmdlLnkNCj4gYW1sDQo+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbWVyZ2Uu
eQ0KPiBhbWwNCj4gPiBpbmRleCBlZWFkNWNiODYzNmUuLjVjNjc4Njk1MTYyZSAxMDA2NDQNCj4g
PiAtLS0NCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxtZXJnZS55DQo+IGFtbA0KPiA+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG1lcmdlLnkNCj4g
YW1sDQo+ID4gQEAgLTI3LDYgKzI3LDkgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBpdGVt
czoNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Njc5NS1kaXNwLW1lcmdlDQo+
ID4gICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxNzMtZGlzcC1tZXJnZQ0KPiA+ICsg
ICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTg4LWRp
c3AtbWVyZ2UNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5NS1kaXNwLW1l
cmdlDQo+IA0KPiBMaW51eCBuZXh0IGhhcyBzb21ldGhpbmcgZW50aXJlbHkgZGlmZmVyZW50LiBJ
IGRvbid0IGtub3cgdGhlIGJhc2UNCj4gaGVyZSwNCj4gYnV0IGl0J3MgcmVhbGx5LCByZWFsbHkg
ZGlmZmVyZW50IGFuZCBpdCBzdWdnZXN0cyB5b3Ugc2hvdWxkIGFkZA0KPiBtdDgxODgNCj4gdG8g
YW4gZW51bSB3aXRoIG10ODE3My4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
IA0K
