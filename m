Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC816319C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKUGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKUGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:37:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81CBC37;
        Sun, 20 Nov 2022 22:37:34 -0800 (PST)
X-UUID: 50cc8236736e4d5aa17e1f39169f5f90-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/J9SzbdCsbMBQyz37jU8g/oSleN/gUYklesrCE4l7iE=;
        b=pncqfehGcnG1qTI7a8kSRlv3/E5iHX7PYforwFT61IIAeQqG0YxMDJdoYbaH0LomNrLf6xPBsPxlH4gdwmQn8SHpJbPnuTwIXkxaVh5gi1Tcsto/pFGRUS9rOHJXsdy81F5CsAgD01NHKgIBBNkZ+k0xCM09ksT+NJmJz4Zy6wc=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:eae10e7c-708f-40d2-bdad-ae478d94052a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.12,REQID:eae10e7c-708f-40d2-bdad-ae478d94052a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:62cd327,CLOUDID:1f6d582f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121143729XY4KKMTT,BulkQuantity:0,Recheck:0,SF:16|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 50cc8236736e4d5aa17e1f39169f5f90-20221121
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chengci.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 780304693; Mon, 21 Nov 2022 14:37:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 14:37:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 14:37:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2a4yYW3nqL01WhwAjb0p5Ldz9BS+ZrYfifa6ruB+8y5ONP41jxpef2+UXptmeBu0EoDDGp6K1qTuq11W6HJTg0VwPwqevyjE82586JtzKPBlEuK2mKlm3cHCBQGQxYwKzZrtEbt4ftj+wPkxDYjIfF9wFRTL+jz6fDXpnDJ06nQ52RagI4la95PfUfUqn0DK6FpgR2Dx24q1XozPrspvpYpyhLoP1dtd1PqAtEHKe56m2NAV0KzD45aVOUfsvaHVMRw8s9KSIfC59htaDfvivNsbYyFJ5jUTJqABSSE9yDF7dbjgivB3Mp2/JAI6SSD9KWuu8OSi84y4syuLufa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J9SzbdCsbMBQyz37jU8g/oSleN/gUYklesrCE4l7iE=;
 b=O3kzVh/dOIqZ2gBy+R28XzkfttPd4sc7eJei3VKGmoQbY2V2Bc8QBzdZqeyntLhS5AExWwUNK97R5D3/jAjMUpPc26gk0/or3oUbRUVaeGkYXQ8/u5V42pyuZ/6NoXxVivwklXeV+6/DBNFB+uxIK1lGDsCbHXRe+dC3kXimC0vDNDvA4HY7sZn7s/C5ZGL5LkpalZ7H37d3ZHVvnshN/aiJKtI0NHOOJZJOshc2UxYulDaBMFWoRSoHAgdRTZVKyY98IifZVPYTqn+aOwqDiOwjiRI7cGS1jotFxRGvpFEL3etBfvotSu0coEICWSO5SPBEBY3KtE+/Z/rHbIA/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J9SzbdCsbMBQyz37jU8g/oSleN/gUYklesrCE4l7iE=;
 b=HqARfpPqUNXsxffP97lmhLFN9WPAklRA2F4XtqX579VUw6PR37SYBEQgUmq8eYcKNZT3db4e3dKxeyBK75q1v4kI3Y4c+YoAj3b/XP35CSo8BXcPkAECsdVzVpaEqp88BiKIfU0OGs5PXcvMTDhKKU1Ik5A4HvECefiZ68ORHTE=
Received: from PS1PR03MB3416.apcprd03.prod.outlook.com (2603:1096:803:48::12)
 by SG2PR03MB6828.apcprd03.prod.outlook.com (2603:1096:4:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 06:37:23 +0000
Received: from PS1PR03MB3416.apcprd03.prod.outlook.com
 ([fe80::e469:1b83:3ee:79a7]) by PS1PR03MB3416.apcprd03.prod.outlook.com
 ([fe80::e469:1b83:3ee:79a7%4]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 06:37:23 +0000
From:   =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>
To:     =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v4 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Topic: [PATCH v4 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Index: AQHY4r0QU/K3bnGoUkqGJjOMfGc2dq5JC70AgAAWNAA=
Date:   Mon, 21 Nov 2022 06:37:22 +0000
Message-ID: <65be8fa931847d690b3cfa1a97155bb599656e33.camel@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
         <20221018064239.13391-3-chengci.xu@mediatek.com>
         <2ea0120c31d4230701aa031daf57317720f78cf0.camel@mediatek.com>
In-Reply-To: <2ea0120c31d4230701aa031daf57317720f78cf0.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3416:EE_|SG2PR03MB6828:EE_
x-ms-office365-filtering-correlation-id: a191a9e0-2208-4d0c-8ec7-08dacb8ad8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEk3hnceBlfCZyDIrsCz96P0qnglG63fQfLB+VrLsCucNZCIJ2MCKhwoSKHJ5WjSSqQE0gzDKQ7hrv8JwbN3QISCbYLszqDULThOldzoMqbTw0om32rEAMI6KW79quzw+nQCX8V0yt7pr83WpaUQsr63yuM4pmMVJsMO40NlDNaui8vdtuhU2PezRfINXLPuvcDZpFPmYYiY/RVHuoiITBk+zFScKpis49nNnUiG2QmU8pAf9XcmcOYVQMtpxs+ST699FwEeQHVH04sWY1ag4KZ7s5hejuYBHhWLj7ZmUjZs/oTNUgEumE309OHHmmishgqiDI8H4oaD+b1GxJfmPYlDjii9WivPb3UaBYPq1OjxweCliR7rP3ArAiEovKpgQJLzz8kpIB36mAJjLIMjZKhYRjFv/8PfA7tGBWpVDsA7aU3xqeMDWsgDFxox6QS7WmJRaM2ABszbJshILNOmIhqEJ6p9tJb8xLPy84K/gqya0/CMpLMjbNemy45kwB72qwlbSwBKtHdURxjf5GdHxV61H9AD8YKV3fH2utt4zmtDDm2ONupzRRoouyzeEeHuyIJFKQSxKQetoTn25S68i3qSHme860IBr9ZUbX7Lzg67BHRs8iAPkawrBbVMhvTGmnYbVHRe3rSSnoBftZNTYE20fIJUNU05xZeOZyVZmgQNvzli327Dk6yLv9YwKnOj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(86362001)(38070700005)(6506007)(6512007)(2906002)(478600001)(26005)(36756003)(85182001)(71200400001)(83380400001)(122000001)(38100700002)(2616005)(186003)(4001150100001)(7416002)(6862004)(8936002)(41300700001)(6486002)(66946007)(64756008)(8676002)(4326008)(5660300002)(6636002)(66476007)(66556008)(66446008)(76116006)(91956017)(316002)(37006003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlpNZnBJZE92UjY1WktRTmhkQ0tOV011bklHbzlQYTNuNzRzYnhRNElKckkx?=
 =?utf-8?B?OWZvc0JteDNBejFRNkZQMHVZcWtMQnZUQU1HVVQwNXVWcm9uMFRrNjVDVnBZ?=
 =?utf-8?B?SnB1c0tvSHcwczlqQ0FDaVdJREF4dlNKMTFCOWxydTlhM0hOSG9pY3lSQlFN?=
 =?utf-8?B?SklHanM5aUpoN055WU9jY2d5MldJV2MwMzZ5ZWtZVmFKaUlhNUM3eUVJUmpx?=
 =?utf-8?B?Qm9UTjNjM0lzM3I3UVJ0VnArV1lsbmQ1MWdhWjE4WkR6NHhGek1IbGNlR3FH?=
 =?utf-8?B?S3NlRDl6OGh3SXdWU2tHbG1QVTV5OVd5bVdoS2hGbU85d1I5LzBxcjdudXVV?=
 =?utf-8?B?MytZV0hnaGZ3d1JybE4xZXQ2N00xWHR4cXVOMWgrcGZSbTVLdzBYT3pOMloz?=
 =?utf-8?B?cm9kbjgxNVNxYlB1YzVvRy83Sm94YktPT1QwREdIR2VsRUp6UUYrbHRGTUJW?=
 =?utf-8?B?M20rZEpRSVl3R24zdldzWG1lTDFoMHErMHhrMzVyejVnc0l4UVpDMFFocFJa?=
 =?utf-8?B?Z2twN2lPVVE3YkZYWHQrcHRiNEJnU3JRVGVnQUZFYjFLblVERzVyUnIxTmNZ?=
 =?utf-8?B?RWNCOXQ0b242ajhOL2l6WG5FR2UvN1p3VWY1VUcyUWZPSVVyU3hQK1gyVXNJ?=
 =?utf-8?B?WEgyNW9RdjNlYTlJVEl5WFJqZjVOOVBxU3lZUmxDZWhReG41VnlNZUNuQjE1?=
 =?utf-8?B?a0hMdGUxREd0SmxSa0JLRW5obGN5a0x4Rm9RMnF4czJHeXlTcDNPV241RVU1?=
 =?utf-8?B?Nm5YWEUrSFZkckRWVVlKdzZtci83MEZZTU5TR0NKc0wxRGdGN2gvNml5blY1?=
 =?utf-8?B?ejZOWExqV1dZZjdBS0l6MU91azRnT1phM1djRzhtTURtWkZvMEhqQlFHQ1JE?=
 =?utf-8?B?UjFFN0RCMWYvWGJtUG0za0lEeXFybkV6dUZLWEJhY01BeGZ0UVhpazNOT0l0?=
 =?utf-8?B?YmdyWFk0MjhlcEd1VEJ6YSthRytpUFliTEp4UlFlb2g2MVIxcjVZTHlqWGdZ?=
 =?utf-8?B?ck4wOHBEVkRUTzlxS0hMeEtmV3k0Q2ZDT1lSQUFTd1Z6WVlvRmprcFk0cDlV?=
 =?utf-8?B?YmtZRzhFY2lQa3FjQXU2ODVRVzdKaTgvaWw1SnlaZXkxYnEzVmxOY1dWVjcy?=
 =?utf-8?B?Q04zTlREMlI1bmVQN1RVdW1kMTN0Z2twQ2o2YkY4OGxUMEVzMlZ1UHdUeGRG?=
 =?utf-8?B?VHljQ2RKVjBYOGhFYncxT2NQdmNYZGUyQ3BDSGxZZ3NyM0JRUE40bTFEcGFt?=
 =?utf-8?B?eDdLVytNVjg3Q0gyeXduTHl4YUp1ZXZqYS81RGVtUzEwR2N2MGxoUVA4dlN6?=
 =?utf-8?B?YitoZ1JMN3FEMzB0aGM3dXRiOWtVaWR2MnFIa0lwcnhQZ3orOHJ2UkZ0Tjd5?=
 =?utf-8?B?YktaOVFYNjh0N1I5SGZFR2JsZUVLR081OU9HUlJtdTNBbFpuT25aSWJoaTRj?=
 =?utf-8?B?YlF1NWJNODlmRm5IUE5jcFJXeFlTdDFYdENjamNmRll1cTlobHdPRU1NcGJl?=
 =?utf-8?B?N3VmK1pRUW43elZUcUxRSnBYNmtwc05Ud3lMSmdwZWJLamczL3NzQlAwZVcr?=
 =?utf-8?B?VmIwVFdwUjFGMXVCTEFxampYUU5nQWZDcDdJRzExNnVkMXFHRmFYUTVjY2Jt?=
 =?utf-8?B?MXZIaHg1SUh4V21WRWJJbEtLQmRHN1g1UHNmYkw2SXJVemN0WllEWnVOSHVr?=
 =?utf-8?B?R09md3NlcnZvWlFzdHRhRTVUQmZvL2IraFZud0xNeElZdGtJd1p0VUc0dUpK?=
 =?utf-8?B?SGpxUUNiK1pGc2p1M3krMjV3ejVmWUVrMGE1Q0tjaVRVZ2xwZFlycjlCNmZQ?=
 =?utf-8?B?UG0yWEhqZE1OMHVFMHRyOE44STJCd3RubFpNM0JJcEFhNTZkanBsR3NnRlFp?=
 =?utf-8?B?U2lScnhtMHBRWmZGUU5taFJBbXJwQmxrNHVEYjdXd0dvcHlSaElpWWlKSURL?=
 =?utf-8?B?elhRMDFPcVZCSXNndmRXdm81ZWtmQWRPeWlwcjhQbHFmK0dwOVk1K0FRVGNy?=
 =?utf-8?B?dW9mVmJkZjdNMUJqanRhbUZOSmZQaUVVMkFIbTlyU3JyTU93cGw2Y2hYeU9s?=
 =?utf-8?B?M2QrMUE2QnlISjFpeGNrYU16VFhQWWEvQW9qa3daa0gyNnBGVGQwZ05EVThy?=
 =?utf-8?B?dXRmekdBQkFvaG9wR0MvMTR3RGE5NmgxN1NNT3AzbVJwYkNNOFg2T2ZJYlZz?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D358651034E3145B8FD24CFB765CFDD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a191a9e0-2208-4d0c-8ec7-08dacb8ad8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 06:37:23.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcTsPOW5Gz08tXM7zoyrVcVGfF7XMDf/Gu0kXNJKKGvuvRgAuepsE0ZBH3gJdiwEn1YfhxKMb87J++m16W/zkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTIxIGF0IDA1OjE3ICswMDAwLCBZb25nIFd1ICjlkLTli4cpIHdyb3Rl
Og0KPiBPbiBUdWUsIDIwMjItMTAtMTggYXQgMTQ6NDIgKzA4MDAsIENoZW5nY2kuWHUgd3JvdGU6
DQo+ID4gRm9yIHJlZHVjZSBpbmRlbnRpb24gd2l0aG91dCBmdW5jdGlvbmFsIGNoYW5nZSwgcHJl
cGFyZSBmb3IgTVQ4MTg4Lg0KPiA+IElmIHRoZXJlIGFyZSBtYW55IHBvcnQgaW4gYSBzYW1lIGxh
cmIsIGN1cnJlbnQgZmxvdyB3aWxsIHVwZGF0ZQ0KPiA+IGxhcmJfbW11LT5tbXUgb3IgdXBkYXRl
IElORlJBIHJlZ2lzdGVyIGZvciB0b28gbWFueSB0aW1lcy4NCj4gPiBTbyB3ZSBzYXZlIGFsbCBw
b3J0IHRvIHBvcnRpZF9tc2sgaW4gdGhlIGZyb250IG9mDQo+ID4gbXRrX2lvbW11X2NvbmZpZygp
LA0KPiA+IGFuZCB0aGVuIHVwZGF0ZSBvbmx5IG9uY2UgZm9yIElPTU1VIGNvbmZpZ3VyZS4gQnkg
dGhpcw0KPiA+IG1vZGlmaWNhdGlvbiwNCj4gPiB3ZSBjYW4gcHJldmVudCBNVDgxODggZnJvbSBz
ZW5kaW5nIHRvIG1hbnkgU01DIGNhbGxzLCBhdm9pZGluZw0KPiA+IGVudGVyDQo+ID4gQVRGIGZv
ciBlYWNoIHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbmdjaS5YdSA8Y2hlbmdj
aS54dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMgfCA2MCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+IC0tDQo+ID4g
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IDVhNGUwMGU0YmJiYy4uZmJhZjQwMWYz
NGUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTUzNCw0MSArNTM0LDQ5IEBAIHN0
YXRpYyBpbnQgbXRrX2lvbW11X2NvbmZpZyhzdHJ1Y3QNCj4gPiBtdGtfaW9tbXVfZGF0YSAqZGF0
YSwgc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAJdW5zaWduZWQgaW50ICAgICAgICAgICAgICAg
ICBsYXJiaWQsIHBvcnRpZDsNCj4gPiAgCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRl
dl9pb21tdV9md3NwZWNfZ2V0KGRldik7DQo+ID4gIAljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lv
dmFfcmVnaW9uICpyZWdpb247DQo+ID4gLQl1MzIgcGVyaV9tbXVlbiwgcGVyaV9tbXVlbl9tc2s7
DQo+ID4gKwl1bnNpZ25lZCBsb25nIHBvcnRpZF9tc2tfZXh0Ow0KPiA+ICsJdTMyIHBvcnRpZF9t
c2sgPSAwOw0KPiA+ICAJaW50IGksIHJldCA9IDA7DQo+ID4gIA0KPiA+ICAJZm9yIChpID0gMDsg
aSA8IGZ3c3BlYy0+bnVtX2lkczsgKytpKSB7DQo+ID4gLQkJbGFyYmlkID0gTVRLX000VV9UT19M
QVJCKGZ3c3BlYy0+aWRzW2ldKTsNCj4gPiAgCQlwb3J0aWQgPSBNVEtfTTRVX1RPX1BPUlQoZndz
cGVjLT5pZHNbaV0pOw0KPiA+ICsJCXBvcnRpZF9tc2sgfD0gQklUKHBvcnRpZCk7DQo+ID4gKwl9
DQo+ID4gIA0KPiA+IC0JCWlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5wbGF0X2RhdGEsDQo+
ID4gTVRLX0lPTU1VX1RZUEVfTU0pKSB7DQo+ID4gLQkJCWxhcmJfbW11ID0gJmRhdGEtPmxhcmJf
aW11W2xhcmJpZF07DQo+ID4gKwlpZiAoTVRLX0lPTU1VX0lTX1RZUEUoZGF0YS0+cGxhdF9kYXRh
LCBNVEtfSU9NTVVfVFlQRV9NTSkpIHsNCj4gPiArCQkvKiBBbGwgcG9ydHMgc2hvdWxkIGJlIGlu
IHRoZSBzYW1lIGxhcmIuIGp1c3QgdXNlIDANCj4gPiBoZXJlICovDQo+ID4gKwkJbGFyYmlkID0g
TVRLX000VV9UT19MQVJCKGZ3c3BlYy0+aWRzWzBdKTsNCj4gPiArCQlsYXJiX21tdSA9ICZkYXRh
LT5sYXJiX2ltdVtsYXJiaWRdOw0KPiA+ICsJCXJlZ2lvbiA9IGRhdGEtPnBsYXRfZGF0YS0+aW92
YV9yZWdpb24gKyByZWdpb25pZDsNCj4gPiAgDQo+ID4gLQkJCXJlZ2lvbiA9IGRhdGEtPnBsYXRf
ZGF0YS0+aW92YV9yZWdpb24gKw0KPiA+IHJlZ2lvbmlkOw0KPiA+ICsJCXBvcnRpZF9tc2tfZXh0
ID0gcG9ydGlkX21zazsNCj4gPiArCQlmb3JfZWFjaF9zZXRfYml0KHBvcnRpZCwgJnBvcnRpZF9t
c2tfZXh0LCAzMikNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIGRlZmluZSBhIG5ldyBwb3J0aWRfbXNr
X2V4dD8gQ2FuJ3Qgd2UgdXNlIHBvcnRpZF9tc2sNCj4gZGlyZWN0bHk/DQoNClRoYW5rcyBmb3Ig
eW91ciByZXZpZXcuDQoNClRoZSBzZWNvbmQgcGFyYW1ldGVyIG9mIGZvcl9lYWNoX3NldF9iaXQg
aXMgYW4gYWRkcmVzcyBvZiAidWxvbmciLA0Kd2hpY2ggaXMgc2hvd24gYXMgImNvbnN0IHVuc2ln
bmVkIGxvbmcgKiIsIGJ1dCBwb3J0aWRfbXNrIGlzICJ1MzIiLg0KDQpJIGhhdmUgdHJpZWQgZm9s
bG93aW5nIHR3byBzb2x1dGlvbnMgdG8gZ2V0IGNvcnJlY3QgYWRkcmVzcyBvZiB1bG9uZw0KZnJv
bSBwb3J0aWRfbXNrOg0KKDEpICh1bnNpZ25lZCBsb25nICopJnBvcnRpZF9tc2sNCglJZiB3ZSBn
ZXQgdGhlIGFkZHJlc3Mgb2YgcG9ydGlkX21zayBieSAiJiIgYW5kIGNhc3QgaXQgdG8NCiJ1bnNp
Z25lZCBsb25nICoiLCAiYnVpbGQgZXJyb3Igd2lsbCBoYXBwZW5lZC4gVGhlIGZhaWwgcmVhc29u
IHdlIGNhbg0KZmluZCBpbiBidWlsZF9hbGxtb2Rjb25maWcuYXJtNjQubG9nIGlzIg0KL3RtcC9z
cmNfa2VybmVsL2tlcm5lbC9saW51eC1uZXh0L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmM6IElu
DQpmdW5jdGlvbiAnbXRrX2lvbW11X2NvbmZpZyc6IC90bXAvc3JjX2tlcm5lbC9rZXJuZWwvbGlu
dXgtDQpuZXh0L2luY2x1ZGUvbGludXgvZmluZC5oOjU4OjIzOiBlcnJvcjogYXJyYXkgc3Vic2Ny
aXB0ICdsb25nIHVuc2lnbmVkDQppbnRbMF0nIGlzIHBhcnRseSBvdXRzaWRlIGFycmF5IGJvdW5k
cyBvZiAndTMyWzFdJyB7YWthICd1bnNpZ25lZA0KaW50WzFdJ30gWy1XZXJyb3I9YXJyYXktYm91
bmRzXQ0KICAgNTggfCAgICAgICAgICAgICAgICAgdmFsID0gKmFkZHIgJiBHRU5NQVNLKHNpemUg
LSAxLCBvZmZzZXQpOw0KKDIpICYoKHVuc2lnbmVkIGxvbmcpcG9ydGlkX21zaykNCglUaGlzIGlz
IG5vdCBhbGxvd2VkIGJlYWN1c2UgIih1bnNpZ25lZCBsb25nKXBvcnRpZF9tc2siIGlzIGENCnJp
Z2h0IHZhbHVlIGFuZCBnZXRpbmcgdGhlIGFkZHJlc3Mgb2YgYSByaWdodCB2YWx1ZSBpcyBpbGxl
Z2FsLg0KDQpTbyBJIGNob29zZSB0byBkZWZpbmUgYSBuZXcgdmFyaWFibGUgInBvcnRpZF9tc2tf
ZXh0IiB3aG9zZSB0eXBlIGlzDQoidW5zaWduZWQgbG9uZyIuIEkga25vdyBpdCBpcyBhIHVnbHkg
c291bHRpb24ganVzdCB0byBtYWtlIGZ1bmN0aW9uIG9rDQphbmQgYnVpbGQgcGFzcywgYnV0IGl0
J3MgaGFyZCBmb3IgbWUgdG8gY2F0Y2ggdXAgd2l0aCBvdGhlciBzb3VsdGlvbnMuDQoNCk1heSBi
ZSB3ZSBjYW4gY2hhbmdlIHRoZSB0eXBlIG9mIHBvcnRpZF9tc2sgZnJvbSAidTMyIiB0byAidTY0
IiwgaXMNCnRoaXMgT0sgZm9yIHlvdT8NCg0KDQo=
