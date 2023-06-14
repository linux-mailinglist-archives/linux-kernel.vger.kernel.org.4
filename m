Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B9D72F776
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjFNIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:12:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243BC7;
        Wed, 14 Jun 2023 01:12:28 -0700 (PDT)
X-UUID: afd5950a0a8611eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=2aULfhO15ozhKLevnQsBRP3luIdXLrF50Nav5TLOok0=;
        b=uWTOl6TElh6UX5HBkIPirBv3m6ylBbDHJVQidnp3JVSGWWlDZofNZ1qjtV3hId4lWEAInWRsuE+heOeVZAK4JAVaLYI/VMMoqSdJApX8e2aaD8Qs31o0qRcLrI86Xym8AgyuADpCiZ+mCoWzduRblgtbgTAF/B2n/T5Hjjv4KkY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:421f77b5-75b5-48e6-beb6-30cf51f97d2e,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:98
X-CID-INFO: VERSION:1.1.26,REQID:421f77b5-75b5-48e6-beb6-30cf51f97d2e,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:98
X-CID-META: VersionHash:cb9a4e1,CLOUDID:46b2623e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230613165153OC2057HH,BulkQuantity:22,Recheck:0,SF:29|28|17|19|48|38,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,
        TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: afd5950a0a8611eeb20a276fd37b9834-20230614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 63948010; Wed, 14 Jun 2023 15:40:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:40:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:40:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOodyse7lurJNqifHNlW2eANhXG9FMlfb9ZoqNG+gtslmSB4dyjYjhrFtmTHaMoJ1+fWETvaYHO2WIAfoEsMBRO8jb2kESoJzJXiuByjNHI3zZ8x+yG2Q4i5r3P1Ionp3XcsSlAcWICRqMEDocKFpWftHGDr1vS8hgXeExXWRvN+QExgT0YJf8viyvf5i/8CDVRUtSZwkdvKLKQIVgjQ3TNDJ4iv2U5mQu5dyUhud6jpwprWkGIjJgr8Nz1jYQ2C34OWzGTR0q1C+IestgXKWoiYSjGlVnjGgmmJ7I0mWB0NpUj6asqzs/zyQPCgaoeFCaLRp+WdsZPfJYsUTxiguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aULfhO15ozhKLevnQsBRP3luIdXLrF50Nav5TLOok0=;
 b=VfxfNsjPhGYI62ekoaWBH3PcgM4RtLhAQPsy/N1wS6Kohcsmzg25KLT+TnbKtQiFaivHj/GComwk1togmsJO9tFZFUEg0o119XWE2iwvcjKMo+GT30820J+A+Sn1R32gqNujCaZDfb+gTSuwIp1htAFD4lft/73A7lXxr50q5CMwQODkPafGD2uSE73zSQ3AYSs15/7bu55Dguk2AVQukGjqYJo5B65Kg3QJt8//6fTK8evyvEMdorQGs6iNU3QNngoxBKRW5V/72CLg6UgFx2yn0h+IU8qzkyLB+nInIZNVS5LPBJqx1i82iTw6LdU2KpeMpfhAyu6+lzmrMO2IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aULfhO15ozhKLevnQsBRP3luIdXLrF50Nav5TLOok0=;
 b=ge91eoy7tJQHxa3d25lgDDTK2F/hpnuBvIEh9IylmTy3EvO9YsFl7RuhhPCcK1Xy0cAyzM6DHo6M2ZCxRmR1cEd9R3lde7ZRtdB2PfXFnDBqFajlu6gmCvfASMNY+/ZJQ/+P4bTY37avhsR4nXLmCtThK38LhDAqi+gBXXnZ++g=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5518.apcprd03.prod.outlook.com (2603:1096:400:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 07:37:03 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 07:37:03 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio
 afe document
Thread-Index: AQHZnRwwFFXmmj8e60u4F1KEKx4v7q+IblCAgAE08ICAADcngIAAEWUA
Date:   Wed, 14 Jun 2023 07:37:03 +0000
Message-ID: <a338bf978dfa0af84a6728ab66dc51e45a20c7c4.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-8-maso.huang@mediatek.com>
         <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
         <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
         <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
In-Reply-To: <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5518:EE_
x-ms-office365-filtering-correlation-id: 2599d05c-0380-4d29-c44c-08db6caa25b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55j/uK+uoGVRnbFYrRklxTf6l1abX/wZImqTLyIpFF05H8lALJMFxz2vmE8ARg6ozz3FSzUKBHVUKFNibou2KzGpx/7nBaawilBYXPoIZDD2eS/UPgkNbABUycUuc4JFe5S5s95Q09oqCQYkZPQZoict6hJwdYY+QRY0aYIzR4PqrxC8tREEaxuxb50uv0vOTBRjB0NyXIDjmn4aBLz2xAt8QJjpQvzeZzvio9lyNWjTHqljXiEXAqqxiCT3B0qzxrwPTEaxrC+cfAjspWTdY1Qv1ZV6g80uSHHXkUa7lIcWUlRu7rDCjai9K9sLE3/V4NZNZAjFQVjIq8JPhnfS06yeM17GGWWWqR/c5CpYruzfCSl5AJT+/o1rqW05P4vOOvFLFjb0VR4rBjmqCT4U8UTKoQ4qB6CvOJdqmXuR2vjjW71uofqFwEpnysEbukhLu++N7H4ZiwvR0pmqB/8DhAH2XDXMM/ckKqqg+BPcGfUFhAao7jqLSUrmv3W0VyxXLpncDtGNMn/Us4uulo82H1/XKRZlM+OXl6/T/Ws7Cq1xNp6Y3dlPW3tWuwQKAdFicpiNDoTQP3hWYvNv7uuk6zpazWMcOv+Z2vu5/sDAJM6vVZ+MY2k7bLwg4ZtSo1klNjClAG4tGaUSPbE+N1FqMcqZgRL+CgcHzqKoGtTqB3g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(83380400001)(66946007)(921005)(122000001)(36756003)(85182001)(38070700005)(6636002)(316002)(41300700001)(38100700002)(71200400001)(966005)(6506007)(6512007)(66476007)(91956017)(26005)(53546011)(6486002)(66446008)(66556008)(76116006)(64756008)(7416002)(8936002)(8676002)(5660300002)(2616005)(478600001)(86362001)(2906002)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umw4MXFSMG1KeXRKMXdObkhJU3k2ME1RL1pQUmJPMkM3S1pHcWZRYTNESmQy?=
 =?utf-8?B?R2M3QmhSN2pDcnZtT3pYdU1lbnRyT1RkYkJzakkxSGd3V1E2NU1QWDcyeFow?=
 =?utf-8?B?QTBmdWxUaXlhKzFqTFRrV3ZCcEp5eHlIZ2NrcGxBWkFzQytiWVMweGpFQmdH?=
 =?utf-8?B?TXRNZ2MrMnRCcHZxZlpkam8zV0lYRnF1ZE1Vd01hRGE5RTJlZlRTSUFtNm5Y?=
 =?utf-8?B?ZTBMcjZPNVpCcGJqTkxpZ2Frd3hINTM1eWtjZWVxYzJJUFA4TlkzQkRUajFu?=
 =?utf-8?B?U29kSFB5bFBtUTZ4Mjh2Tjc4WGJVTVJYSXZ1N3pjNUUveTU2NTVVMFJtVE43?=
 =?utf-8?B?d1NWdFRBZmVGSzJERWZUbGFWbnBSYVJ1S2l1cDdsVUZBSlhVSWc4V3RkYUsv?=
 =?utf-8?B?cmNZVW5QK09aTnZRLzlnRDNyKzYwT3Jhcitnbk5NQWFyU1pVYm54T05YWkNV?=
 =?utf-8?B?cTE0ci9rQUQ4ZVcrQzRhYkRib0ErNmoremVZeXU5TTlSWnN4WkEyTmFzTkFR?=
 =?utf-8?B?dHIxOFpma09VTTdTYTh2M3JLZnd2NnV5dVBvVk44TXFjWU5ZeHZjMVo3QVBO?=
 =?utf-8?B?QU03Z3BWWUFiUGNvYms1aVBWTElPTUg2UUJ3ZWNHS2Q2OFBibngrZjR5QTZl?=
 =?utf-8?B?MFE3SDNLWWdCdEdHdGJIMlNlb1FHNkI5a0Q0eWZOa1hucVJ2a1pzcXRYcnZK?=
 =?utf-8?B?WE9ucEtoY094YU9SVDlubSs5V05RYW9ndEpDbVNuZUhpUldJUkF5Tmg0OUdn?=
 =?utf-8?B?bHhJRDVJdDNpKzFtcnBFQ0x5K3UxREhmNnZJNEZqVUoxT3Z1d2xNZEkvQlAv?=
 =?utf-8?B?a2hkUDlrQWRLajFabDVtcFd1LzAwSVJGYVpqb3BxSGNhRGo4eDU2Um0wUGxu?=
 =?utf-8?B?Y0hrVWcvN3BkRHpxRjFXdy9LZlhFTlBqMGNmUGtVSTgyaWVoQXAyai9Gblpa?=
 =?utf-8?B?MkpiQk9STi95QVRaOGxpQmk1cXFBQStEUTROZ1dYTVRpQ3l4Y2M2M3kzV0FD?=
 =?utf-8?B?T0VJa3lDclpCNTcyUzFweWJTWjVabURnUnppSWpuTnlGRkJzVW5LcW81aGRE?=
 =?utf-8?B?TWc5VFlXZmFGd05JemNKSkkwNU9WWmw2T1o0b0JRTDNLd3ZZaG5FY0VVSFlV?=
 =?utf-8?B?UDZRWHR6cFljTHFlMTFaK29mTUZVT2ovM0hMOEJINEdqMGZNWnJvbFZmY2Yx?=
 =?utf-8?B?MTVuM1NjMHNFKzJQenY0U1JjN3dHdWYzWmFoMHFXMlphSU95WmtmRGZOUTdU?=
 =?utf-8?B?cnI4Y1BXRW8vQTEzSnlhRjRkTmkwOUd2NU9ONjRtM2JYWmNtbkZlWm43OXdL?=
 =?utf-8?B?RGlOelFpRFlHTlNtWnA1MDg4eEJzR3pVT2wzS25lYWdrSVVGS2k4em12Q3I4?=
 =?utf-8?B?cjE5SmJGQzErRnkvWFNhbTdZd3BaQUpkM0RiQVhMaDNSVWRYWTVkZU1hUHh0?=
 =?utf-8?B?dUh4dUJKS2NqNXZ4N3JQRXFxWWdSK3Nwc2k5ZlJiUTlpL1VqZjhxc0xONmd0?=
 =?utf-8?B?V25XRVUvQ3kwdlJZemJ5MzJheExxREVOUjlaMkhnL3VFSUtscGl6aGtvNTN6?=
 =?utf-8?B?cmpPTi90Yy8yejVCczZzeGtpMk9objNMcHpQbk1aTk9teG03K2VPcllMenMy?=
 =?utf-8?B?czB4cHd5UVNocWRuTlM1eDE2SzB5Q2pSNnpldE9BeFBGT1NDdzEvZGE4NUto?=
 =?utf-8?B?MVFZZ3A3T0V5bmVYUXZORjRVMkQ4OVJSSkdHSUU5SVRtNzVxdVV4MHZoTlBh?=
 =?utf-8?B?aHE0djQxYTVsTkdDMnJud256eitseDM0UjRRK0gvWG51N3puTERtbXQvR3FC?=
 =?utf-8?B?cXB0ZnFuVHA5bG5HODNPOVFGS3Fma3ZpK2E5UHdjTkMvSjY3dWNyT0RqVkNC?=
 =?utf-8?B?c3NNMEkwbDFESlhjS0FHTHRFeGpwS3lseFR5eW4vSDhaNjUrNXZXUU41bU1o?=
 =?utf-8?B?elJ6RytIUmpGeWNZY3dZcGorcWRYeGxNU2lCUE5TN2gyUnJScUdUL1VPakdv?=
 =?utf-8?B?c2dxSlJvMWV0ZWlROUhobG56MXl2T3AvQjVwQTBiZG4xTDJ3RUdMK3NQeC8w?=
 =?utf-8?B?dmdHc25QOVN2Q1hIZ3AzbVkyZW5GNU03U1ZCVlFvWExTUWU4OFE1WWZpV01H?=
 =?utf-8?B?OXZXU2NhMEFGdlJINFlDY0tkc2ViY1gxZHdCZEZvcDhzOFFqNnJFRlNxME5t?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <795D2E7490AE534EB5739F6B15E9EF21@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2599d05c-0380-4d29-c44c-08db6caa25b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:37:03.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vO2R2lfgAI4oJ4/LbQfSXRneJmGcmONHIA4wFI8fE9BJpUaEv6PTRGi6SG3f54jvoV58mlJIVSROZagFBilcgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA4OjM0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE0LzA2LzIwMjMgMDU6MTcsIE1hc28gSHVhbmcgKOm7
g+WKoOeruSkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjUxICswMjAwLCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0K
PiA+PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAg
DQo+ID4+IE9uIDEyLzA2LzIwMjMgMTI6NTIsIE1hc28gSHVuYWcgd3JvdGU6DQo+ID4+PiBGcm9t
OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPj4+DQo+ID4+PiBBZGQg
bXQ3OXh4IGF1ZGlvIGFmZSBkb2N1bWVudC4NCj4gPj4NCj4gPj4gUGxlYXNlIHVzZSBzY3JpcHRz
L2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeQ0KPiA+PiBwZW9w
bGUNCj4gPj4gYW5kIGxpc3RzIHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQg
d2hlbiBydW4gb24gYW4NCj4gb2xkZXINCj4gPj4ga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQg
ZW50cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UNCj4gPj4gYmFzZQ0KPiA+PiB5
b3VyIHBhdGNoZXMgb24gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gPj4NCj4gPiANCj4gPiBIaSBL
cnp5c3p0aWYsIA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEFuZCBzb3JyeSBm
b3IgbWlzc2luZyBzb21lIG5lY2Vzc2FyeQ0KPiA+IG1haW50YWluZXJzLg0KPiA+IFdoYXQncyB5
b3VyIHN1Z2dlc3Rpb24sIHJlc2VuZCB0aGVzZSBwYXRjaGVzIGFnYWluIHdpdGggdGhlbSwgb3IN
Cj4gYWRkDQo+ID4gdGhlbSBiYWNrIGluIHYyIHBhdGNoPw0KPiANCj4gDQo+IFlvdSBuZWVkIHRv
IGZpeCB0aGUgcGF0Y2ggYW55d2F5LCBzbyB1c2UgZ2V0X21haW50YWluZXJzLnBsIGluIHYyLiBJ
DQo+IGRvbid0IHVuZGVyc3RhbmQgd2h5IHlvdSBDYyBoZXJlIG1hbnkgdW5yZWxhdGVkIHBlb3Bs
ZSBidXQgbm90IHRoZQ0KPiBhY3R1YWwgbWFpbnRhaW5lcnMgd2hpY2ggZ2V0X21haW50YWluZXJz
LnBsIGFza3MgeW91IHRvIENjIQ0KPiANCg0KT0ssIEknbGwgYWRkIG5lY2Vzc2FyeSBtYWludGFp
bmVycyBiYWNrIGluIHYyIHBhdGNoLg0KDQo+ID4gDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+
ICAuLi4vYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OXh4LWFmZS55YW1sICAgfCAxMDINCj4g
Pj4gKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDEwMiBpbnNlcnRp
b25zKCspDQo+ID4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtYWZlLnlhbWwNCj4gPj4+DQo+
ID4+PiBkaWZmIC0tZ2l0DQo+ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL21lZGlhdGVrLG10Nzl4eC1hZmUueWFtbA0KPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtYWZlLnlhbWwNCj4gPj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjExZWYxY2ZkZjQ5
Yg0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzl4eC0NCj4gPj4gYWZlLnlhbWwNCj4gPj4+
IEBAIC0wLDAgKzEsMTAyIEBADQo+ID4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQ
TC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4+PiArJVlBTUwgMS4yDQo+ID4+PiArLS0t
DQo+ID4+PiArJGlkOiANCj4gaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbWVk
aWF0ZWssbXQ3OXh4LWFmZS55YW1sIw0KPiA+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+Pj4gKw0KPiA+Pj4gK3RpdGxlOiBNZWRp
YVRlayBBRkUgUENNIGNvbnRyb2xsZXIgZm9yIE1UNzl4eA0KPiA+Pg0KPiA+PiA3OVhYIHNvdW5k
cyB3ZWlyZC4gQXJlIHlvdSBzdXJlIHlvdSBhcmUgbm90IHVzaW5nIHdpbGRjYXJkcyAod2hpY2gN
Cj4gPj4gYXJlDQo+ID4+IG5vdCBhbGxvd2VkKT8NCj4gPj4NCj4gPiANCj4gPiBXZSB3b3VsZCBs
aWtlIHRvIHVzZSBtdDc5eHggZm9yIG10Nzk4Ni9tdDc5ODEvbXQ3OTg4IHNlcmllcy4NCj4gPiBP
ciBpcyBpdCBiZXR0ZXIgdG8ganVzdCB1c2UgbXQ3OTg2IGZvciB0aGlzIHNlcmllcz8NCj4gDQo+
IFlvdSBjYW5ub3QgdXNlIHdpbGRjYXJkLiBHZXQgc29tZSBpbnRlcm5hbCByZXZpZXcgb2YgeW91
ciBwYXRjaGVzDQo+IHByaW9yDQo+IHRvIHN1Ym1pc3Npb24gdG8gbWFpbGluZyBsaXN0Lg0KPiAN
Cj4gDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xLXJjMS9zb3VyY2UvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRpbmctYmluZGluZ3MucnN0DQo+IA0K
DQpPSywgSSdsbCB1c2UgbXQ3OTg2IGluc3RlYWQgb2YgbXQ3OXh4IGluIHYyIHBhdGNoLg0KDQo+
ID4gDQo+ID4+PiArDQo+ID4+PiArbWFpbnRhaW5lcnM6DQo+ID4+PiArICAtIE1hc28gSHVhbmcg
PG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+Pj4gKw0KPiA+Pj4gK3Byb3BlcnRpZXM6DQo+
ID4+PiArICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICBvbmVPZjoNCj4gPj4+ICsgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDc5eHgtYWZlDQo+ID4+PiArICAgICAgLSBpdGVtczoNCj4gPj4+ICsg
ICAgICAgICAgLSBlbnVtOg0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDc5ODEt
YWZlDQo+ID4+PiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Nzk4Ni1hZmUNCj4gPj4+ICsg
ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3OTg4LWFmZQ0KPiA+Pj4gKyAgICAgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDc5eHgtYWZlDQo+ID4+DQo+ID4+IEkgYWxyZWFkeSBzYXcgQUZFLCB3
aHkgaXQgY2Fubm90IGJlIHBhcnQgb2YgZXhpc3RpbmcgYmluZGluZ3M/DQo+IA0KPiBDYW4geW91
IGFuc3dlciB0aGlzPw0KPiANCg0KRGlkIHlvdSBtZWFuIG10ay1hZmUtcGNtLnR4dD8NCklmIHll
cywgSSdsbCBtb2RpZnkgbXRrLWFmZS1wY20udHh0IHRvIHlhbWwgZm9ybWF0LCBhbmQgYWRkIG10
Nzk4NiB0bw0KaXRzIGNvbXBhdGlibGUgbGlzdC4NCg0KPiA+Pg0KPiA+PiBUaGlzIGxpc3QgaXMg
b2RkLiA3OXh4LCA3OTgxPyBTbyBpdCBpcyB3aWxkY2FyZD8NCj4gPj4NCj4gPiANCj4gPiBZZXMs
IGl0IGlzIHdpbGRjYXJkIGZvciBtdDc5ODYvbXQ3OTgxL210Nzk4OCBzZXJpZXMuDQo+ID4gSXMg
aXQgYmV0dGVyIHRvIGp1c3QgdXNlIG10Nzk4NiBmb3IgdGhpcyBzZXJpZXM/IA0KPiANCj4gTm8g
d2lsZGNhcmRzLg0KPiANCk9LLCBJJ2xsIHVzZSBtdDc5ODYgaW5zdGVhZCBvZiBtdDc5eHggaW4g
djIgcGF0Y2guDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpCZXN0
IHJlZ2FyZHMsDQpNYXNvDQo=
