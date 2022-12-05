Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15338642301
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiLEGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLEGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:24:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17811456;
        Sun,  4 Dec 2022 22:24:44 -0800 (PST)
X-UUID: 5f645fb7c21e4ab38751bc6526bdc485-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=86TBxDQXsnOukfOWD5muWnjljS3EtHawAOEUF6+LBWg=;
        b=UVbbihd/c2KKjoQA/Zog8/g5KyhplA0E8XlsD+diMgtZX1gP1ZPszwx7vJ1Ct43hpsSg3P6de4oPZ1dA4Kz8Avq+9mRy104xsGE/60EIErqR3JcEHl1YkJIZ5ePIdL7r1Zs2fOKj6g7jsI8+hSDb1Zla+wELao+ff3Ruwv9Ps04=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:771c1458-0027-4c11-b97f-107852a81bd5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:6500906c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5f645fb7c21e4ab38751bc6526bdc485-20221205
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1909376976; Mon, 05 Dec 2022 14:24:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Dec 2022 14:24:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 5 Dec 2022 14:24:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW4HANo5DoXETaDquJiP9JESyRMggH/3Z7IpeWPPusI38hOeKHiUaGRIIMPMr9XDp+Ath4PFAK5g7+OWRcO7qC2RHRLtFLQC3oJs1wDFY2YWqTBkcJSwM9qFysbBfl2cpNf8PqmKlBL8Jr9tVQuslClFqpVV0/906CDniTyZxMnrsvT4EcwhZronUVuxqC5g4oCdaVjghSZG8VVAfY4lDTIBtIafJFqhgZIug5wT317+qSZiF377PLByU7anOUnRJh2mrfWE8TZLjFkbEBl/msWgJh1ZiOLQ7DAZQIALiGfkCNnWpp5MPEDyw4TCcvSQV7tozRSqUp9eoCtQ0HZZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86TBxDQXsnOukfOWD5muWnjljS3EtHawAOEUF6+LBWg=;
 b=jyYeCDTSKJvRmvH5UygNHJjCDZssvxINUzJNOfQ/56H3mACrPy9aKndK61u5Pp7OOy86hFPoIbrvm/rlZ4de8j2xSPVuI29Czz5NmYeuWnA4u6amUCTdssuHsdjxKuZjLwu4ZkCClqp4x68znhxUcxG0qy1BToUOIkWXiTAN9uie+U2YWZcNpqoxJpS20+rpB2RaY2poEx1wc1TRFRuSEju+DpeXHmIIzqf/q6moCQK4U45FZPUG4E1R9WrEFBMqEnVwppTlYR8EcmZchl8SGgI/gqnLVR2M9ojWdFzzMo7gyWV0JNM72kzehC2xlIfZEi4zINXdyEwuHCfr0JndPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86TBxDQXsnOukfOWD5muWnjljS3EtHawAOEUF6+LBWg=;
 b=ra9Ep0xdWA0oxaaiOprIPfwRraHK11HJnG0sxcoSnzKsBKPtN6R2xbmE1Nvt84AOC4aVR39r/Vjvymo/Mi0dLCbmZxfef6e86ox13juj0A4XN6meUDIf4RYm0tcNc+p81bZZa4OJJynWkLu9cbgd8MNCkrh9ugXwrHzjZIU0+G4=
Received: from TY2PR03MB4016.apcprd03.prod.outlook.com (2603:1096:404:b8::21)
 by KL1PR03MB6288.apcprd03.prod.outlook.com (2603:1096:820:a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 06:24:34 +0000
Received: from TY2PR03MB4016.apcprd03.prod.outlook.com
 ([fe80::379a:86e6:d1f0:950b]) by TY2PR03MB4016.apcprd03.prod.outlook.com
 ([fe80::379a:86e6:d1f0:950b%7]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 06:24:34 +0000
From:   =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>
To:     Sean Wang <Sean.Wang@mediatek.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "vincent@systemli.org" <vincent@systemli.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: Raise proc and sram max voltage for
 MT7622/7623
Thread-Topic: [PATCH] cpufreq: mediatek: Raise proc and sram max voltage for
 MT7622/7623
Thread-Index: AQHZBjP+vuJCUqJP2U28SgK/T1CGlK5aiUIAgAROzwA=
Date:   Mon, 5 Dec 2022 06:24:34 +0000
Message-ID: <28308227f830dd200e4c933cc6baa27910644367.camel@mediatek.com>
References: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
         <75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org>
In-Reply-To: <75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR03MB4016:EE_|KL1PR03MB6288:EE_
x-ms-office365-filtering-correlation-id: 29a7613c-3292-4f61-6913-08dad6896057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QtqUEOUzmlkEtp/BpUzsn94c/13u97Y9B/Qqq9dndEtPQIkv2lNaZitPCv2fmV8LAC1bla4FsAmODZJj6AxRcrYeCm/7ePtq4GwgJBvP5NUnMLfJ1DljTtOmueQ6MCke2kgOMQZNwOfcgm5q4GfeSsZv9hav71H+Y6mB8H2O7sfVQ+BkE3LR1tpPsArjqeCMQP9reMbnxvzLLdU4wSvJA27ooz326rOhnlYc/JbfrDVU87vcFwya4pdcLHEb55kTJhswyPDS+4qmPtecBkNANkuiNkJTrVQYE4NGCJ735uQvbTxDX2LZptaoBUJCAMFDz+tIcw0QPzOBNfEo4HJKmj9tW0Em9vZDAXSwwHldVjawK5P1cyJ2Z8y7lELgUvCOQ5puJS6pCjZ4oVCrKzkjZdjuC9xuqioW6Ob04RD4NO1HVCyrf8ohF87h2qwRud4snDi7EDUVthezQLGRcEH/vECe9O6C+9bP0ui6lKgoad2OPrONoQ6Y9/KPQVciO1buVGbDlDbOvRhG3NizoTbpbQqoNuQnxml1R9gSanbKIrwNTyHilu+igPpI2h+4OSwNLfRvZyXasv+ADpzfG7wV5iNa5B+kBDAkZutv5Ci+CdukMyD+X7fntFpl8jCLWo3THwEV71CyNW3+WzqjZG/59R+9KgPONlLIXJ0wbw5HgX9XH5FxyisyBFcZNh/lULzLyk267+lNWZk/1nMFkEJHVNg3Jifzo3ssTT5ykm61mdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR03MB4016.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(84040400005)(451199015)(478600001)(86362001)(6506007)(53546011)(6486002)(71200400001)(966005)(38070700005)(85182001)(36756003)(26005)(83380400001)(186003)(2616005)(38100700002)(122000001)(4326008)(8676002)(7416002)(5660300002)(41300700001)(6512007)(107886003)(8936002)(66946007)(66556008)(66476007)(76116006)(64756008)(66446008)(54906003)(2906002)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dlN2UwS25UYXVEMWFQTmd6M1dmTlRZeGJRdkdBU05veVIvSzFmaURvMnpR?=
 =?utf-8?B?R0xZVVVjZkMwaTBOVmxDNTUrM2thUk5Teng2YnQxUHkxUlh0VGpNemNmb0d6?=
 =?utf-8?B?Wm5uRG5nQ3B1dDF6WEZ1bmVZU29qSzNZQ3NWaENVTlZ2UDRBRldzTklpeGZJ?=
 =?utf-8?B?NHdCUGtpRldwTzB4bXlrUUpCQ2NNSThKSDhjM2R5alN2aTFuSWM2Ty9tSHI5?=
 =?utf-8?B?TGhPWXU2MmozTi9FamNnY1pBVE8wTE9QMXFMSG5YREdlWHl6TU92WnFjQy9w?=
 =?utf-8?B?OXdZeEk2Y09GYzU2R2dSUUZOc3d4UTJrcm1NaXpURjdwWTV4emx3czFUM2Ex?=
 =?utf-8?B?V3dpWUtHN1FoMUxYaWxtNUtMaWREQnc5c0pPNFJRUDhyd05WdTBDVEdUbnc3?=
 =?utf-8?B?aTFXT3VYYnV4a25RMmxvZlBBUUp6VXNHWDZzT3NhMXF3WXI2eUtNSzNtNzZ5?=
 =?utf-8?B?ZUxxTEd1ejMzWThNd0Y3RjlFQk0wY243RVQyYTFvMkFqeEQ3WlNXaEZrekx5?=
 =?utf-8?B?clY2eWgvVk1kNTVJYzZTdVJtcm81ZlcxaTZWcUtJWnhzaCthZFFKbEt3bW4x?=
 =?utf-8?B?Vys0YzBKMHY4SW5MK3pWQTk1SDE4QTVNSlRrT2hPY0IwbWl4Y0lYbTkxKzVu?=
 =?utf-8?B?WTNBSkdIR0hvTE1hdkJ0OW15c3czWldQU3AvRGFaS3Zzcm5KVlFlSnhVTHJj?=
 =?utf-8?B?UzhzSk56OXpPMmhSbG5jZ1UxOWY3d0pkcDM1aGhsanhwY05sdjF3RnpSczA1?=
 =?utf-8?B?TWxScVZJK3JVMXVkVE5BNFVTOFRQUVlOc2hteno5TDFhTms4QmdpUTRnTW9p?=
 =?utf-8?B?azkvZFFDNVN3NDRraUUwcm9VcG5vanRhckpZWlg0QTV3QVozZ3kwd0RzRGRM?=
 =?utf-8?B?MllpYlpDcU5iTmgwNHdyelIxanBhOU4zZzg0RUN6OHFPVWI5MEZjeVpIYlRP?=
 =?utf-8?B?dzJMUjc1djViaTVyWHpoVmdXc1VpZkFYaTUyenY2NWJJS0pCTytvdndldHR5?=
 =?utf-8?B?TFY2N3BQT0FQdFoxWThkem14OG54MDFWWkY5c2Fqcy90blJ6VXY3WGs1K1FZ?=
 =?utf-8?B?c1A5VjNXY244MUhaY05ZWnQ1eGplejhpZGM5NXEyVnY5SXdmcXlHTnZHOGlt?=
 =?utf-8?B?Nkh2R0hoRStzOHJzNHV5RHY0dkIwOG1RdU9nOFZxQXBYZlBOMjBYcHIyRmlp?=
 =?utf-8?B?YW5adldKSlVtaWdMK2ZDcGdYNnVKbVJmNXAyZWRqWCtSM1hOT2IvQTBEUXVB?=
 =?utf-8?B?SitaUm1kZU0yZy9qdFBXWDNqTHFtVVlPNG1LY3doNjVKNEIwQXhpY3djZDMv?=
 =?utf-8?B?UVJTMTF5elErVEpFQzUvOVI5RmUrL0VzSjhwYmg0WHhsajJmWTFMNkZPMVF1?=
 =?utf-8?B?ekxRQitxKzBLczdVSHY4bmZqeDY2ZFkxbFVObFhyeUwxOVZiak1QSGFIUUcv?=
 =?utf-8?B?M2srWkVYc2RaeklBMmdMMTVGMTVtN3N6MXJ0WHpHcjM1NDdaWXhYZVY3d1h0?=
 =?utf-8?B?QkhMMy9wSWFmVUxqWEFseVMzYjVJRE5LRlprMXYza3FTV294QU0vTTZjMHJn?=
 =?utf-8?B?N2w0dkpyWC9VV1ZuemVQYmRIMVc0Q1dla01ubHVxd0czOU9BVjhXQ1Y5dU8y?=
 =?utf-8?B?bHZEcWZ3UFJnVFdaelJlQm9EbUFEaGZZT0hzbzdYV3YvMUROR1c3K3E5T0Uw?=
 =?utf-8?B?Rkp6TExKUEtDU1c0c1QxOW1jajdWZWdCVE9kcmxVQWdFWkhuclpQT1FPSkU0?=
 =?utf-8?B?K3VubUdVN3RmbHZwOXFNYWpDUDFRRzlUMCtNMURIdUVTek5mNnFkaENGZ1dm?=
 =?utf-8?B?MlBROTFhb0NkMGQ1dzZHYkZ0SUNBenIxRmRnZTdKQW91MFZNOWxaWnFXL1NX?=
 =?utf-8?B?YzdrdkpvWnA2UFdVakhpYUxWTWEyZVREeFA5Qk44RzFnWEpCMWdzWmRvSUMy?=
 =?utf-8?B?Mm9EYkFxSkxRVVhLbS9DbC83MHAzMFBBeXdxUkhUTEdBeVdVVXhaejdIZ2hE?=
 =?utf-8?B?akh0OUZiTHRDT08rdlQzZHRzNEV3Tmo4bzd6NlA1RVd1b2wzZVI1bHZVQ2tx?=
 =?utf-8?B?TGd3OFJyS29YbzYxMDVzMkRqWkR2SFNWcVplaW8rNGM1RkdlUW05a242Znkz?=
 =?utf-8?B?TE5JLzlORjB2OWlMbW1xTCtDQkcxdXZHS29ibnFENm9YZVA1WGNBbzFRaHpJ?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86AAD9554F05A24C938AD7774F246F21@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR03MB4016.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a7613c-3292-4f61-6913-08dad6896057
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 06:24:34.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL0MTWq04aPzdWj+OJI2XCtDCHTIpLinapasLO7bykl4ZOs6iMhiJhOsAMhU/2OSQITT3Ai+tEvi37oUrfmyDY7H45QgKg0t/ufY2E6+AxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6288
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFpbCBsb29wIFNlYW4uV2FuZyBmb3IgTVQ3NjIyIGNwdWZyZXEuDQoNCg0KT24gRnJpLCAyMDIy
LTEyLTAyIGF0IDEzOjM3ICswMTAwLCBOaWNrIHdyb3RlOg0KPiBJdCBub3cgc3RhcnRzLCBob3dl
dmVyLCB3aXRoIGEgbG90IG9mIHRob3NlIG1lc3NhZ2VzIChJIGFwcGxpZWQgdGhlIA0KPiBwYXRj
aCB0byBsaW51eC9tYXN0ZXIgYW5kIG5vdCB0byBsaW51eC1uZXh0LCBiZWNhdXNlIG5leHQgaXMN
Cj4gY3VycmVudGx5IA0KPiBub3QgY29tcGlsaW5nIGFueW1vcmUgZm9yIG1lKToNCj4gDQo+ID4g
WyAgIDEwLjc3NzA0MV0gY3B1ZnJlcTogX190YXJnZXRfaW5kZXg6IEZhaWxlZCB0byBjaGFuZ2Ug
Y3B1IA0KPiA+IGZyZXF1ZW5jeTogLTIyDQoNCkhpIE5pY2ssDQoNClRoZSBlcnJubyBvY2N1cnMg
d2hlbiBjcHVmcmVxIHBsYXRmb3JtIGRyaXZlciBhdHRlbXB0cyB0byBkbw0KbXRrX2NwdWZyZXFf
dm9sdGFnZV90cmFja2luZygpIGJ1dCBpdCBpcyBub3QgYWJsZSB0byBhY2NvbXBsaXNoIHZvbHRh
Z2UNCnNjYWxpbmcgd2l0aGluIGEgY2VydGFpbiBvZiB0aW1lcywgdnRyYWNrX21heC4NCg0KSXQg
d2lsbCBuZWVkcyBmdXJ0aGVyIGRlYnVnIG1lc3NhZ2UgdG8gZmlndXJlIGl0IG91dC4NCg0KPiA+
IFsgICAxMC43OTE1NzddIGNwdSBjcHUwOiBjcHUwOiBmYWlsZWQgdG8gc2NhbGUgdXAgdm9sdGFn
ZSENCj4gDQo+IFRoZSBjb21wbGV0ZSBsb2c6DQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vZ2lzdC5naXRodWJ1c2VyY29udGVudC5jb20vUG9seW5vbWlhbERpdmlzaW9u
LzI2N2M4M2M3YTIxYTM1OWNiYjRlOGQ5OWQwMzAzMjAxL3Jhdy8yOGQzNTY4YTI2NjM0YmViZWYy
ZDkxZWJlMzdmYzVmNzZhZTU4YWRkL210NzYyMi1wYXRjaC1jcHVmcmVxLmxvZ19fOyEhQ1RSTktB
OXdNZzBBUmJ3IW1zV0p5bmM5NlFjNWJ2TUItNWdDcGVwai01ellXaXpPXzk4cmp1YUxXYzdmU0JO
U1NwUE1QdlpxcTFtcHJCZ1JxMTFHQXFZdmY0aFV6d1prWF9JaE02azAkwqANCj4gDQoNCk1heSBJ
IGtub3cgaWYgdGhpcyBmYWlsdXJlIGxvZyBjYW4gYmUgMTAwICUgcmVwcm9kdWNlZCBvbiB5b3Vy
DQpwbGF0Zm9ybT8NCg0KVGhhbmtzLg0KDQo+ICANCj4gDQo+IEJlc3RzDQo+IE5pY2sNCj4gDQo+
IE9uIDEyLzIvMjIgMTA6NTIsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+
IER1cmluZyB0aGUgYWRkaXRpb24gb2YgU1JBTSB2b2x0YWdlIHRyYWNraW5nIGZvciBDQ0kgc2Nh
bGluZywgdGhpcw0KPiA+IGRyaXZlciBnb3Qgc29tZSB2b2x0YWdlIGxpbWl0cyBzZXQgZm9yIHRo
ZSB2dHJhY2sgYWxnb3JpdGhtOiB0aGVzZQ0KPiA+IHdlcmUgbW92ZWQgdG8gcGxhdGZvcm0gZGF0
YSBmaXJzdCwgdGhlbiBlbmZvcmNlZCBpbiBhIGxhdGVyIGNvbW1pdA0KPiA+IDZhMTdiMzg3NmJj
OCAoImNwdWZyZXE6IG1lZGlhdGVrOiBSZWZpbmUNCj4gPiBtdGtfY3B1ZnJlcV92b2x0YWdlX3Ry
YWNraW5nKCkiKQ0KPiA+IHVzaW5nIHRoZXNlIGFzIG1heCB2YWx1ZXMgZm9yIHRoZSByZWd1bGF0
b3Jfc2V0X3ZvbHRhZ2UoKSBjYWxscy4NCj4gPiANCj4gPiBJbiB0aGlzIGNhc2UsIHRoZSB2c3Jh
bS92cHJvYyBjb25zdHJhaW50cyBmb3IgTVQ3NjIyIGFuZCBNVDc2MjMNCj4gPiB3ZXJlIHN1cHBv
c2VkIHRvIGJlIHRoZSBzYW1lIGFzIE1UMjcwMSAoYW5kIGEgbnVtYmVyIG9mIG90aGVyDQo+ID4g
U29DcyksDQo+ID4gYnV0IHRoYXQgdHVybmVkIG91dCB0byBiZSBhIG1pc3Rha2UgYmVjYXVzZSB0
aGUgYWZvcmVtZW50aW9uZWQgdHdvDQo+ID4gU29DcycgbWF4aW11bSB2b2x0YWdlIGZvciBib3Ro
IFZQUk9DIGFuZCBWUFJPQ19TUkFNIGlzIDEuMzZWLg0KPiA+IA0KPiA+IEZpeCB0aGF0IGJ5IGFk
ZGluZyBuZXcgcGxhdGZvcm0gZGF0YSBmb3IgTVQ3NjIyLzc2MjMgZGVjbGFyaW5nIHRoZQ0KPiA+
IHJpZ2h0IHtwcm9jLHNyYW19X21heF92b2x0IHBhcmFtZXRlci4NCj4gPiANCj4gPiBGaXhlczog
ZWFkODU4YmQxMjhkICgiY3B1ZnJlcTogbWVkaWF0ZWs6IE1vdmUgdm9sdGFnZSBsaW1pdHMgdG8N
Cj4gPiBwbGF0Zm9ybSBkYXRhIikNCj4gPiBGaXhlczogNmExN2IzODc2YmM4ICgiY3B1ZnJlcTog
bWVkaWF0ZWs6IFJlZmluZQ0KPiA+IG10a19jcHVmcmVxX3ZvbHRhZ2VfdHJhY2tpbmcoKSIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vs
b2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLmMgfCAxMyArKysrKysrKysrKy0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEuYw0KPiA+IGIv
ZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEuYw0KPiA+IGluZGV4IDdmMjY4MGJjOWEw
Zi4uZjlhOWYwOGM3NWM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRl
ay1jcHVmcmVxLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5j
DQo+ID4gQEAgLTY5NSw2ICs2OTUsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY3B1ZnJl
cV9wbGF0Zm9ybV9kYXRhDQo+ID4gbXQyNzAxX3BsYXRmb3JtX2RhdGEgPSB7DQo+ID4gICAJLmNj
aWZyZXFfc3VwcG9ydGVkID0gZmFsc2UsDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2NwdWZyZXFfcGxhdGZvcm1fZGF0YSBtdDc2MjJfcGxhdGZvcm1fZGF0
YQ0KPiA+ID0gew0KPiA+ICsJLm1pbl92b2x0X3NoaWZ0ID0gMTAwMDAwLA0KPiA+ICsJLm1heF92
b2x0X3NoaWZ0ID0gMjAwMDAwLA0KPiA+ICsJLnByb2NfbWF4X3ZvbHQgPSAxMzYwMDAwLA0KPiA+
ICsJLnNyYW1fbWluX3ZvbHQgPSAwLA0KPiA+ICsJLnNyYW1fbWF4X3ZvbHQgPSAxMzYwMDAwLA0K
PiA+ICsJLmNjaWZyZXFfc3VwcG9ydGVkID0gZmFsc2UsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY3B1ZnJlcV9wbGF0Zm9ybV9kYXRhDQo+ID4gbXQ4MTgz
X3BsYXRmb3JtX2RhdGEgPSB7DQo+ID4gICAJLm1pbl92b2x0X3NoaWZ0ID0gMTAwMDAwLA0KPiA+
ICAgCS5tYXhfdm9sdF9zaGlmdCA9IDIwMDAwMCwNCj4gPiBAQCAtNzE3LDggKzcyNiw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2NwdWZyZXFfcGxhdGZvcm1fZGF0YQ0KPiA+IG10ODE4Nl9w
bGF0Zm9ybV9kYXRhID0gew0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
bXRrX2NwdWZyZXFfbWFjaGluZXNbXQ0KPiA+IF9faW5pdGNvbnN0ID0gew0KPiA+ICAgCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxIiwgLmRhdGEgPQ0KPiA+ICZtdDI3MDFfcGxhdGZv
cm1fZGF0YSB9LA0KPiA+ICAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyIiwgLmRh
dGEgPQ0KPiA+ICZtdDI3MDFfcGxhdGZvcm1fZGF0YSB9LA0KPiA+IC0JeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDc2MjIiLCAuZGF0YSA9DQo+ID4gJm10MjcwMV9wbGF0Zm9ybV9kYXRhIH0s
DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMyIsIC5kYXRhID0NCj4gPiAm
bXQyNzAxX3BsYXRmb3JtX2RhdGEgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ3NjIyIiwgLmRhdGEgPQ0KPiA+ICZtdDc2MjJfcGxhdGZvcm1fZGF0YSB9LA0KPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMiLCAuZGF0YSA9DQo+ID4gJm10NzYyMl9wbGF0
Zm9ybV9kYXRhIH0sDQo+ID4gICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNjciLCAu
ZGF0YSA9DQo+ID4gJm10MjcwMV9wbGF0Zm9ybV9kYXRhIH0sDQo+ID4gICAJeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxN3giLCAuZGF0YSA9DQo+ID4gJm10MjcwMV9wbGF0Zm9ybV9kYXRh
IH0sDQo+ID4gICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMiLCAuZGF0YSA9DQo+
ID4gJm10MjcwMV9wbGF0Zm9ybV9kYXRhIH0sDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZvciB5
b3VyIGhlbHAuDQoNCkkgYWxzbyBmb3VuZCB0aGUgc2ltaWxhciBwcm9ibGVtIHRoYXQgcGxhdGZv
cm1zIHVzaW5nIGluY29ycmVjdA0KdnNyYW0vdnByb2MgY29uc3RyYWludCBwbGF0Zm9ybSBkYXRh
LiAgVGhleSBhcmUgTVQ4MTY3IGFuZCBNVDg1MTYgd2hpY2gNCnJlZmVyIHRvIG10ODUxNi5kdHNp
IGFuZCB0aGUgbWF4IHZvbHRhZ2UgdmFsdWUgb2YgdnByb2MgaXMgMTMwMCBtVi4NCg0KQ2FuIHlv
dSBoZWxwIHRvIGZpeCB0aGUgY29ycmVjdCBwbGF0Zm9ybSBkYXRhIGZvciBNVDgxNjcgYW5kIE1U
ODUxNiBhcw0Kd2VsbD8NCg0KVGhhbmtzLg0K
