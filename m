Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909F73F2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjF0DmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjF0Dla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:41:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFEF19A3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:38:07 -0700 (PDT)
X-UUID: 03d1e978149c11eeb20a276fd37b9834-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WH992h0mq3C7ELQzOJUNHvrJ4aMUaUN/5rXB3c5+cN0=;
        b=iY/0CC7T9JHzd2mam78sXwQc53yfhvpn2QiWDlsaYGbOROONU0/DYebjw6oaED28OnUw66OV4blu2LnTY5DwqyRPpKgG9gg/sG0hgD3Kgm7i6dE7IgWLOs6DvU5bf+lV7fUgFwi+7GLX15uWadAj8AF2PjylqWE/EL47v2AYs5A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e2495762-ea20-4cb3-ba4d-d4f68f9cbdb2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:e2495762-ea20-4cb3-ba4d-d4f68f9cbdb2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:bd5544da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230627113802X2Y01TNC,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS
X-UUID: 03d1e978149c11eeb20a276fd37b9834-20230627
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 59490217; Tue, 27 Jun 2023 11:38:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 11:37:59 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 11:37:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ87VZaFvj8w+Uhx9r5TDSK1c4t5DDS3dIqs4DyxVHpV7yt8ZyzFJgxBoqBcxFb14sKtOqoFQV03xFrZFYGPAkJpxq7d9KlIr2HgyelEyc5tpvxACS7SwF00d6bn/thBrrkufQz+rlJ/aSO80vkkuKJW0ctfs7S0wTcfnPl7+11Z+rOpqu39Qh7Qbb8Z7ThVR5Amx6NUhL2xoHGxQQg1BXkd8vTB58Wo5uoxDNqg39JX9P2oWzq3R+JKZ6owyMc4zr+k0MkeC9XWS2h0nILBQYCYWm5GMA7RsEAxhP51Z7/26MKnNq1HhUUY09S9d9H5In8LRMoWx/9DtyCPp/MMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH992h0mq3C7ELQzOJUNHvrJ4aMUaUN/5rXB3c5+cN0=;
 b=L6c3FJ0hm8DFiBXsnqNPkOxsYICrhFfJpQGPflHPSwcPzpHnp3Cnebb5MgHi3i9oSq83ZO+w4W3f50asVu4+VJZaNmRJ5PxQaxn+B/23Gk/ujVqDmZeKsfCFZd9WIUc+UamViLZoSt1iW7F9a0vw03VQmNiT5Jxvk4HjMpuTDuBY1NPtRtP8gKgeplxQhXnkcmuWyzS6KthomSYPEeWshwmD5SD6Jk4Erx82uL363rMwd9RaUln1c/83pLu6GgpvHxe/baUpfWRWUgpXEnwQWQSrAYF7zvR5L1neE3BZiiAEYlPKvCnqT6jkVEAj+TrNDnVMFmyvLiGReVBnjrQnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH992h0mq3C7ELQzOJUNHvrJ4aMUaUN/5rXB3c5+cN0=;
 b=IEhNR+U6FIsZY/Lc0/+zTMuFQYKUSv9inJw5nydIq9Fo5+IMSlG7O5Npwtw8Fqa48Hl+xZa+FtK8AgN8jq0gXzX9inTZVY3Cl7EIubW/ADr8PikL/zq2uqQjfPN8rdXn9NI5r17URZvVSBQy5eduiUuzX47nftycIp/mPrXXzVw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7174.apcprd03.prod.outlook.com (2603:1096:820:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.46; Tue, 27 Jun
 2023 03:37:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 03:37:57 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 03/11] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Topic: [PATCH v5 03/11] drm/mediatek: gamma: Support SoC specific LUT
 size
Thread-Index: AQHZlIIaExF5+QRysEaRPt3OoGHjMK+eKIEA
Date:   Tue, 27 Jun 2023 03:37:56 +0000
Message-ID: <2505a4a3d3e88629173fa266fd54084862d7e1a3.camel@mediatek.com>
References: <20230601121022.2401844-1-angelogioacchino.delregno@collabora.com>
         <20230601121022.2401844-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601121022.2401844-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7174:EE_
x-ms-office365-filtering-correlation-id: 73b39a30-d25c-49a2-3caf-08db76bfe5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKJayz08NUTIw+8rY1tpa1m91P2ifGLJC3NsI886QI/hN8lX2kqv6qyPsb+c5Gct/igvpow+k3S4f+pfCuakUXc8sellm7kQO8IwanrV5xnPCDWKqVVeyyxEUvC4TkrzULiq3uygOT2pX9zeUmj7PS9y4uIKlN+mAk1w2Ym2MwHrvDNH1zOBLXTxst2GXex3uFSei7OkXIqHwH5ktLA/h9HPMcR6tzvh3fo05ZUATA5+uCMwzwEWZ1X1U1xU7Y4Z7kLoKaL6nKYrYhqwzuSYFZyth/hsZRtkFkI6KwGufjH+Fb7rB3SpBErUxwRoNSO+zURDyswjm69oInH1nsPag+osucLtl1P5b0DgLEFh5KnZOz1S1WuCS1qC1wundgyy6H4G4FS7xJSGkooWkFJtu5NyyVnI8yWpI6jTOBZLh9dZyTQY+O78vz8CH2AT8kfIzd8dBxfqhgjXuNfLh+i6slIGe9PB0+VaJ5EQoABQFfCQ2nltxGOn92B54nhtAo7FVzPWL/o5mrsvooNRKY9EgYAc2nb8tmgp40xX9bj6fAT1d7ZZFJkqdO4ntwLRJ8c+HknyQZKiG/9oVO5/5+9iwLIm2AZEvtY5GgK+nz+rJsOrcigBv20nrVyDXX9qQVebxJMTaRx601n/yHEVpbk9/4zqZ5Sri3Ol/TjHC1pXjN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(6512007)(2906002)(6486002)(71200400001)(2616005)(38100700002)(83380400001)(122000001)(26005)(186003)(6506007)(54906003)(41300700001)(86362001)(110136005)(478600001)(38070700005)(36756003)(66946007)(66476007)(64756008)(66556008)(76116006)(66446008)(4326008)(316002)(85182001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHM5a013bGxnMHFGSFFHS1ZRVE4razdjN1hPcHRLVForNDV5TmRBUkV2NWtp?=
 =?utf-8?B?V092UExFWFVTeU1tQnlkUjA3Vld3VVprWGR6amZJRnErbGMzVUdEUU54bHAw?=
 =?utf-8?B?VkF0alNUWEV6M0t1TGtzZFlSZ2d2em5EalVMdGcwZGRYVXlQQTFueURGVmZw?=
 =?utf-8?B?V2tmdnA3Y001dDNxdWlQWWVGYzlMUmwzVmN4VTJXRTR3dkNjdER3WDV2NXdk?=
 =?utf-8?B?b1NXUTAwaDMzVklqWW5OVGtWci82ZHhyNEw4Z2l6bUZSeGIxK3k5VUc5QWF1?=
 =?utf-8?B?UFdhZU9tQTlibWNNbmtRT1ZUNElhbDA1ZkIwTHEzRkRpa1VvdG9UNFBSM0pi?=
 =?utf-8?B?K1FpVTkxTUtaanVBV1hYVjF0N2FPU2ZZVDNTMnZicGRSZXJpR0pxUlJXL1Jv?=
 =?utf-8?B?WHpXckNjU3kxZ0llYzFvaklzUjc0NDlodUd6L0JHaEhpYjMrK09ibXBpcVJR?=
 =?utf-8?B?ZisvV3RmaWFLMWpuZ0NYeC9wSUV3cnJ6VW9XZ04zMzhETHMzbnVFZk83bytW?=
 =?utf-8?B?NmszS1JKMkVEODVSUUxPVkFJT0dXbUR4UC9ZUDJacG1GZ1ZNQ01ZWGp5Sks5?=
 =?utf-8?B?ckk5WVZYNHdqdVNNaWZHdVdFbnZsNU95THg0bTk1SEtKMTQzeUFISS80SW9Y?=
 =?utf-8?B?RGZnN1RNek12V0FjRHBkSFdXU2hKMzlNdnljd00wQjlqS2RheWFHRmdqK2E2?=
 =?utf-8?B?K2NNWXlyWWgzYVgvc2dkd1c5SHF5UUFobi9FekRsUWx6cytQZUJZdTRCcC9w?=
 =?utf-8?B?R05rSjVQSnFZUGI2L3U0VVBjaVFHK01aRWxZMC9wTkhrUnZxWjJramtzdUlk?=
 =?utf-8?B?ZGN3VXo2TklWV1NSaXdBWVovNGhVMHU5c09kaVpDd3E0ZlYvRk9WM2JvNndq?=
 =?utf-8?B?eXQyWUlLVW80cEtsRFpFNVNJZ2xOQU5uRm9ydklCVTAyQWpRL3ZUaHlnTXor?=
 =?utf-8?B?NFdmK25hZFMwV3NVWklnOFJvdG9LUlc1UmJGbDZoVXpVL2tvWXN6blBLbWlC?=
 =?utf-8?B?TUtEcVJ2NVNBMWtrU21YWFpES3FhRHFjUkFNSVQ4MUtYYzk5aU9JeERJRkpN?=
 =?utf-8?B?bFpZb2VLZXFyUkVsK0NKYTNGT0JmTTRUaUpGY1RFQkMvaE12WjAveDVGUWFX?=
 =?utf-8?B?bDMrbzFHYk9FVVI0dUVEZUNkZEowaytVaGw4M0hvWEZ3UzVmNXNWMHgvOTll?=
 =?utf-8?B?ek9UMDZyRlE5WXFEdXByOE84bWIvTStpZU1nUGJVdHhkRExJM2Q2MU5mVnNG?=
 =?utf-8?B?bFpyeWg1OHJLT0cxamt5cE0wSW9zSWZSdS9EOTluOHlxRlF2OVhXa2VQVVFZ?=
 =?utf-8?B?MEtlN0FWZ1htdG9SUG40UXFwZVJlQWYrcjE1cFgrMDY5ZkVGSHZqaU5YUHI5?=
 =?utf-8?B?eGxLY1FlcG1YVzB6S0JiWG82RVJPdStWSjJQcDFEc3Irb25EaHNlT2krbUk1?=
 =?utf-8?B?L0x1cUs5bVBTTW05eHFzTTAyMlp1blBOcGZPWTdzK09uT3ByNzVlL1FiUE5N?=
 =?utf-8?B?Q0F3aVRpYUZtdnVNQzRhSmk3ckh1aHR0dWdMa2E0NVpNcUpGQTBqVi9ZWEZM?=
 =?utf-8?B?dGgwQVZVREdxZUhOZERLcWtaRDArTThGbjNoTzBWU0hOTSsyd05Ed2ZFS3cy?=
 =?utf-8?B?MlR5a1JrRnpyY2FhdmY3a1NJbEdSR1VLSythUmY5SEJEdDgzeEIrd2V0Z3Uv?=
 =?utf-8?B?dTh2UnYvTVUzb0JjejBpeXdsb2tOM0dnQXlwRnhhbCtBMWhEdWRGOGtlejhJ?=
 =?utf-8?B?R09TZHBsaWZjZ3htelljbGNCZnF5YmlJUVVOL1V2Ymo2VEpKZDlSVnIrRStN?=
 =?utf-8?B?a1gvUTFNc1NiNmJhbGEwN2xyN3FEQkN2RXdTNkF5ZG9PZjhKbkVEdHJTQ094?=
 =?utf-8?B?WHh5YThpOEl4U1JvSFp5UnlySkVrNEU4SlFYNXVyS0hLODBocW14N1FBdUNR?=
 =?utf-8?B?NHNKZFR2U1JWRC9NK3lvSTZwWXdXL3h6bVIyU1dzM2FPSU5LYVRIK0FicVpR?=
 =?utf-8?B?QWd5RWJFNGRSd0tWL0FReXVFYzF1LzhIcWM4WE5ITXpiRlRrTmhVVUxCamt0?=
 =?utf-8?B?MDVsSDlYbFBKODdERjVtTGU0WEZJdGU2ZThvWEdwbWxQb0crTWppTnRMQ1Jl?=
 =?utf-8?Q?hrs0mpZVwMNdL87Iw6HlO5LPZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA412F0C963A234F82BBB429C686FB45@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b39a30-d25c-49a2-3caf-08db76bfe5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 03:37:56.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaFUUzmYgY24K7mKB8UBnaTBxfpW+UWGg/l9ITe8CV7KrKWgUOTNRST8nhuY4twFK2IaxqQc0I9vpGspNRV+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA2LTAxIGF0IDE0OjEwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBOZXdlciBTb0NzIHN1
cHBvcnQgYSBiaWdnZXIgR2FtbWEgTFVUIHRhYmxlOiB3aXJlIHVwIGEgY2FsbGJhY2sNCj4gdG8g
cmV0cmlldmUgdGhlIGNvcnJlY3QgTFVUIHNpemUgZm9yIGVhY2ggZGlmZmVyZW50IEdhbW1hIElQ
Lg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1l
ZGlhdGVrLmNvbT4NCj4gW0FuZ2VsbzogUmV3cml0dGVuIGNvbW1pdCBtZXNzYWdlL2Rlc2NyaXB0
aW9uICsgcG9ydGluZ10NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFJldmll
d2VkLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8ICAxICsNCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jICAgfCAyNSArKysrKysr
KysrKysrKysrKystDQo+IC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5oICAgICB8ICAxIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5oIHwgIDkgKysrKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmgNCj4gaW5kZXggNzUwNDU5MzIzNTNlLi5lNTU0YjE5ZjQ4MzAgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTUzLDYgKzUzLDcgQEAg
dm9pZCBtdGtfZ2FtbWFfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQg
bXRrX2dhbW1hX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAg
CQkgICAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiAgCQkgICAg
ICB1bnNpZ25lZCBpbnQgYnBjLCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KTsNCj4gK3Vuc2ln
bmVkIGludCBtdGtfZ2FtbWFfZ2V0X2x1dF9zaXplKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2
b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3Rh
dGUNCj4gKnN0YXRlKTsNCj4gIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmlj
ZSAqZGV2LCB2b2lkIF9faW9tZW0gKnJlZ3MsDQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3Rh
dGUpOw0KPiAgdm9pZCBtdGtfZ2FtbWFfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggY2U2ZjI0
OTliODkxLi5iMjViYTIwOWU3YTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9nYW1tYS5jDQo+IEBAIC0yNSwxMCArMjUsMTIgQEANCj4gICNkZWZpbmUgRElTUF9H
QU1NQV9MVVQJCQkJMHgwNzAwDQo+ICANCj4gICNkZWZpbmUgTFVUXzEwQklUX01BU0sJCQkJMHgw
M2ZmDQo+ICsjZGVmaW5lIExVVF9TSVpFX0RFRkFVTFQJCQk1MTINCg0KT25seSBBQUwgZHJpdmVy
IHVzZSB0aGlzIGRlZmluaXRpb24sIHNvIG1vdmUgdGhpcyB0byBBQUwgZHJpdmVyLg0KDQpSZWdh
cmRzLA0KQ0sNCg0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFfZGF0YSB7DQo+ICAJYm9v
bCBoYXNfZGl0aGVyOw0KPiAgCWJvb2wgbHV0X2RpZmY7DQo+ICsJdTE2IGx1dF9zaXplOw0KPiAg
fTsNCj4gIA0KPiAgLyoNCj4gQEAgLTU1LDYgKzU3LDE3IEBAIHZvaWQgbXRrX2dhbW1hX2Nsa19k
aXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZ2Ft
bWEtPmNsayk7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtfZ2FtbWFfZ2V0X2x1dF9z
aXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEg
KmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdW5zaWduZWQgaW50IGx1dF9zaXpl
ID0gTFVUX1NJWkVfREVGQVVMVDsNCj4gKw0KPiArCWlmIChnYW1tYSAmJiBnYW1tYS0+ZGF0YSkN
Cj4gKwkJbHV0X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X3NpemU7DQo+ICsNCj4gKwlyZXR1cm4g
bHV0X3NpemU7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0
IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKnJlZ3MsDQo+IHN0cnVjdCBkcm1fY3J0Y19zdGF0
ZSAqc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kaXNwX2dhbW1hICpnYW1tYSA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiBAQCAtNjIsNiArNzUsNyBAQCB2b2lkIG10a19nYW1tYV9zZXRf
Y29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZA0KPiBfX2lvbWVtICpyZWdzLCBzdHJ1Y3Qg
ZHJtX2NydA0KPiAgCXN0cnVjdCBkcm1fY29sb3JfbHV0ICpsdXQ7DQo+ICAJdm9pZCBfX2lvbWVt
ICpsdXRfYmFzZTsNCj4gIAlib29sIGx1dF9kaWZmOw0KPiArCXUxNiBsdXRfc2l6ZTsNCj4gIAl1
MzIgd29yZDsNCj4gIAl1MzIgZGlmZlszXSA9IHswfTsNCj4gIA0KPiBAQCAtNjksMTcgKzgzLDIw
IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LA0KPiB2b2lk
IF9faW9tZW0gKnJlZ3MsIHN0cnVjdCBkcm1fY3J0DQo+ICAJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0
KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gLQlpZiAoZ2FtbWEgJiYgZ2FtbWEtPmRhdGEpDQo+ICsJ
aWYgKGdhbW1hICYmIGdhbW1hLT5kYXRhKSB7DQo+ICAJCWx1dF9kaWZmID0gZ2FtbWEtPmRhdGEt
Pmx1dF9kaWZmOw0KPiAtCWVsc2UNCj4gKwkJbHV0X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X3Np
emU7DQo+ICsJfSBlbHNlIHsNCj4gIAkJbHV0X2RpZmYgPSBmYWxzZTsNCj4gKwkJbHV0X3NpemUg
PSBMVVRfU0laRV9ERUZBVUxUOw0KPiArCX0NCj4gIA0KPiAgCXJlZyA9IHJlYWRsKHJlZ3MgKyBE
SVNQX0dBTU1BX0NGRyk7DQo+ICAJcmVnID0gcmVnIHwgR0FNTUFfTFVUX0VOOw0KPiAgCXdyaXRl
bChyZWcsIHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+ICAJbHV0X2Jhc2UgPSByZWdzICsgRElT
UF9HQU1NQV9MVVQ7DQo+ICAJbHV0ID0gKHN0cnVjdCBkcm1fY29sb3JfbHV0ICopc3RhdGUtPmdh
bW1hX2x1dC0+ZGF0YTsNCj4gLQlmb3IgKGkgPSAwOyBpIDwgTVRLX0xVVF9TSVpFOyBpKyspIHsN
Cj4gKwlmb3IgKGkgPSAwOyBpIDwgbHV0X3NpemU7IGkrKykgew0KPiAgCQlpZiAoIWx1dF9kaWZm
IHx8IChpICUgMiA9PSAwKSkgew0KPiAgCQkJd29yZCA9ICgoKGx1dFtpXS5yZWQgPj4gNikgJiBM
VVRfMTBCSVRfTUFTSykgPDwNCj4gMjApICsNCj4gIAkJCQkoKChsdXRbaV0uZ3JlZW4gPj4gNikg
JiBMVVRfMTBCSVRfTUFTSykNCj4gPDwgMTApICsNCj4gQEAgLTE5NiwxMCArMjEzLDEyIEBAIHN0
YXRpYyBpbnQgbXRrX2Rpc3BfZ2FtbWFfcmVtb3ZlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWFfZGF0YSBt
dDgxNzNfZ2FtbWFfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmhhc19kaXRoZXIgPSB0cnVlLA0KPiAr
CS5sdXRfc2l6ZSA9IDUxMiwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2Rpc3BfZ2FtbWFfZGF0YSBtdDgxODNfZ2FtbWFfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmx1dF9k
aWZmID0gdHJ1ZSwNCj4gKwkubHV0X3NpemUgPSA1MTIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZGlzcF9nYW1tYV9kcml2ZXJfZHRfbWF0Y2hb
XSA9DQo+IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBp
bmRleCBkNDAxNDI4NDJmODUuLjBkZjYyYjA3NmY0OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAtOTU4LDggKzk1OCw4IEBAIGludCBtdGtfZHJt
X2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm1fZGV2LA0KPiAgCQltdGtfY3J0
Yy0+ZGRwX2NvbXBbaV0gPSBjb21wOw0KPiAgDQo+ICAJCWlmIChjb21wLT5mdW5jcykgew0KPiAt
CQkJaWYgKGNvbXAtPmZ1bmNzLT5nYW1tYV9zZXQpDQo+IC0JCQkJZ2FtbWFfbHV0X3NpemUgPSBN
VEtfTFVUX1NJWkU7DQo+ICsJCQlpZiAoY29tcC0+ZnVuY3MtPmdhbW1hX3NldCAmJiBjb21wLT5m
dW5jcy0NCj4gPmdhbW1hX2dldF9sdXRfc2l6ZSkNCj4gKwkJCQlnYW1tYV9sdXRfc2l6ZSA9DQo+
IG10a19kZHBfZ2FtbWFfZ2V0X2x1dF9zaXplKGNvbXApOw0KPiAgDQo+ICAJCQlpZiAoY29tcC0+
ZnVuY3MtPmN0bV9zZXQpDQo+ICAJCQkJaGFzX2N0bSA9IHRydWU7DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gaW5kZXggM2U5MDQ2OTkzZDA5Li5iMmU1MDI5
MmU1N2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4g
QEAgLTEwLDcgKzEwLDYgQEANCj4gICNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICAj
aW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0KPiAgDQo+IC0jZGVmaW5lIE1US19MVVRfU0laRQk1
MTINCj4gICNkZWZpbmUgTVRLX01BWF9CUEMJMTANCj4gICNkZWZpbmUgTVRLX01JTl9CUEMJMw0K
PiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0K
PiBpbmRleCBmMTE0ZGE0ZDM2YTkuLmM3N2FmMmU0MDAwZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC0zMjIsNiArMzIyLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2RzaSA9DQo+IHsNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9nYW1tYSA9IHsNCj4g
IAkuY2xrX2VuYWJsZSA9IG10a19nYW1tYV9jbGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9
IG10a19nYW1tYV9jbGtfZGlzYWJsZSwNCj4gKwkuZ2FtbWFfZ2V0X2x1dF9zaXplID0gbXRrX2dh
bW1hX2dldF9sdXRfc2l6ZSwNCj4gIAkuZ2FtbWFfc2V0ID0gbXRrX2dhbW1hX3NldCwNCj4gIAku
Y29uZmlnID0gbXRrX2dhbW1hX2NvbmZpZywNCj4gIAkuc3RhcnQgPSBtdGtfZ2FtbWFfc3RhcnQs
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29t
cC5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiBp
bmRleCBmZWJjYWVlZjE2YTEuLmMxMzU1OTYwZTE5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0cnVj
dCBtdGtfZGRwX2NvbXBfZnVuY3Mgew0KPiAgCXZvaWQgKCpsYXllcl9jb25maWcpKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJCSAgICAgc3RydWN0IG10a19wbGFu
ZV9zdGF0ZSAqc3RhdGUsDQo+ICAJCQkgICAgIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0K
PiArCXVuc2lnbmVkIGludCAoKmdhbW1hX2dldF9sdXRfc2l6ZSkoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gIAl2b2lkICgqZ2FtbWFfc2V0KShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJCQkgIHN0
cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpOw0KPiAgCXZvaWQgKCpiZ2Nscl9pbl9vbikoc3Ry
dWN0IGRldmljZSAqZGV2KTsNCj4gQEAgLTE4Niw2ICsxODcsMTQgQEAgc3RhdGljIGlubGluZSB2
b2lkDQo+IG10a19kZHBfY29tcF9sYXllcl9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29t
cCwNCj4gIAkJY29tcC0+ZnVuY3MtPmxheWVyX2NvbmZpZyhjb21wLT5kZXYsIGlkeCwgc3RhdGUs
DQo+IGNtZHFfcGt0KTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQg
bXRrX2RkcF9nYW1tYV9nZXRfbHV0X3NpemUoc3RydWN0DQo+IG10a19kZHBfY29tcCAqY29tcCkN
Cj4gK3sNCj4gKwlpZiAoY29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPmdhbW1hX2dldF9sdXRf
c2l6ZSkNCj4gKwkJcmV0dXJuIGNvbXAtPmZ1bmNzLT5nYW1tYV9nZXRfbHV0X3NpemUoY29tcC0+
ZGV2KTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5saW5lIHZv
aWQgbXRrX2RkcF9nYW1tYV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gIAkJCQkg
ICAgIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+IC0tIA0KPiAyLjQwLjEN
Cg==
