Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51C6332EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiKVCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiKVCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:16:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E5E0CBE;
        Mon, 21 Nov 2022 18:15:59 -0800 (PST)
X-UUID: a8c4232e72a64118a44cea1c8dc0b17c-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+GdxOCM6Ff1xTwNLxRHtQMkaXiIXysHeqcUxKghM1Kk=;
        b=jDJGua9VR7zyg4ZJ1UjCP04fz2p3wtj8Wno0EW01px5nllTq00eecYPt0df/buc8YmYNM+z3c0kyViju+eh7UWJmhdYfxQgKDropkIAqJElTgxQuTf8Go9IQO4yNI7U44IaA1FNj7rC2DVoKNXxF/f8wnGmfcD3uX2eSiapLosE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:52e25ddc-26b9-4dab-97f6-6f949665d8dc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:86ba6e2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a8c4232e72a64118a44cea1c8dc0b17c-20221122
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2139087893; Tue, 22 Nov 2022 10:15:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 10:15:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 10:15:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFYSkESQKon+Q9gfwxlVtAWbQ4Y3m8IHV96vmCsaS8EFlcoJCEg4hvKIcrDubeZqM1xcFphwRjdaEBot2pKYM84UwX0pjJiewagqW/s533bPoxX+KYyqp8zfMF+7JodOqpHzcARJH4/WtQuaP0DktbqwY4oNVc4P3HV39lTAhASHn+A+r+u03xXMAbbo78vmasi8jo8uVh9rq0pHP6/xgnbImZsm6fnmKKdwpzeP9Vw07wnY0Nzrl5Osagh55ZsiCSt9G3KUCpW5fe8CZGkp/HCDH/IQeE5VWduOCYKNxtdlzGEOk4cCYNkD6iRgqrdzYBkfH79dpB0HH+C90ROhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GdxOCM6Ff1xTwNLxRHtQMkaXiIXysHeqcUxKghM1Kk=;
 b=VrfIRYVzO90WaluKZ6M1YUZld2ooy3WHpU9qO5kBXXxo8vfyhZDnqIDxYHADrvtk3PEFWm0Wqs0RancVrZ8IQDpb6c0m+kDIyldEOgNvRyBb4FP8prJn+a8gh7yNOi0yNUiFynBVh2KnN1W2eD9Uk/YkGXXjoUX+BH9tZJXXbL1JKNOfnwu8zd/4Uw4EtcZ+pz7dnekKYjxhbjTuW/vUBTCbTMlCSnEWkXurOj1vVj+Qu5hK7YjKSbpB4QLdS3GAxxtlp5wXMhMjVIGI8DQmC6SVeIktpVCdJVD6W+9dSyJxVb4xkx4UCmjEiRBD8Xh/LIILPuk/DO43AhSAN4I/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GdxOCM6Ff1xTwNLxRHtQMkaXiIXysHeqcUxKghM1Kk=;
 b=k1tuSKwWv3+zPEdciylA1jyMllrMp7mTZs7TrqFTdl/xA62CD8vPIOACVRQrGO2Y96u/gtc+GYFD5GWeB5v95ml2KfeqPHNHgkOR49tgQ4Kh7i1SYbl7CPeWze3EmBGB0kN3g8JTVVYa8//Sa1v5XmgknMipQ2uT00LSkUn5jmw=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5551.apcprd03.prod.outlook.com (2603:1096:400:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 02:15:48 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 02:15:48 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Topic: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Index: AQHY9O9JtBuSy65JiUSbaCxiUr6+YK5B2DMAgACTNwCAB9thgA==
Date:   Tue, 22 Nov 2022 02:15:48 +0000
Message-ID: <23dc80f67937797774be0b11c132b36af592f220.camel@mediatek.com>
References: <20221110102834.8946-1-yunfei.dong@mediatek.com>
         <20221116172952.GA461876-robh@kernel.org>
         <b31b0928147804323149ced94fe284cc595ffca1.camel@mediatek.com>
In-Reply-To: <b31b0928147804323149ced94fe284cc595ffca1.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5551:EE_
x-ms-office365-filtering-correlation-id: 9ec1d35b-c222-484d-ed67-08dacc2f78b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jjtjzk1yhW3q68Ho9LA58x28sXjL5OOK1bf9wrWUmFGBVkAMHQrpivrIjMmUTc4DR0O+gNqAd84GfHq3le3Nzmejui73schdzn81TUDJ60zXQO9C+N+HDSlR1e63j/uCRUuyr4KCXh1VHKe4qO6VJ7Yy47uPAs9WIGd2XC5cDru70KaumNd9i9dW9h6dQoGyr+mulujneB0IydbnoQsohuvkxf96tfUmsa+niIpAOmX7nZRkLmivjUgpuB8I0bMqgeZp/hCiJwk91MP7Tf1qm+3XwXP1uMIgeEUG03dB8yotJaQ7Lt6/Y6NRJkqbwfhknAI26poA4HKKQdpILaMXZmbGld5rGFmOknR0dVzKA8/jklbIpkRZPqc6C1DKNr50pCg3OdY37HlNg6RDvyHiRjQLLXAxmClGtcT/XGqzDP/tjRPPAOts64GtzE6sjI4OUGnhkNlconpQ9UHkBE1RYEKonCfcx4hu894X2Nunzrn9ZzUTtMzt0W1D5Gqaio68/6lhxmqXubVYSZjCHhsiO3QAzUIzuf6clGphmHW1XxDNqK7mdgT56ivARDrpD5FlWejL9ix4J1cpOJM+35EjrV8DP2WfjXlAkqsf/pucXLQvaVOnJW75M0FMdBbjLz2OX8xdkt1yLYyR/GxEK6s6O4VPwFbce7VUwcLDK373DbfYrHZxD0lKuzAYwz3A/aYUWtOT7HoHn+G9x5NniAffdyY3lX9vIywjA4jddafiCoTAoBByWF2iQLCqJ0QkIHww0RET75oUKgLx28Nmsd/9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(76116006)(66556008)(91956017)(6512007)(64756008)(8676002)(26005)(66946007)(316002)(66476007)(66446008)(41300700001)(54906003)(4326008)(6916009)(85182001)(71200400001)(36756003)(6506007)(2616005)(478600001)(6486002)(38100700002)(4001150100001)(122000001)(2906002)(83380400001)(8936002)(186003)(7416002)(38070700005)(5660300002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3J1VDlrMURxem1kakRxYUhHUTdjM1REbys4VHBFdm5obHJYUk1lWmc1MTRY?=
 =?utf-8?B?NWl1NUNic25IcFFONC9OS2FFNUlkVjN3V0drSWVBN3ByZS9raXNVN0pOUlNV?=
 =?utf-8?B?RFhodFo0a05xS0ExRDVkVTYvSkw2Y1A1cUVQbFVwVFdETTVoRmtWRzMzR25C?=
 =?utf-8?B?b3R2OTFVYm1oK2FYYzM0dGNVblF1K1BWTCtUQVVSOU02ZUxEQkFQOWVOYU9i?=
 =?utf-8?B?SlJMc2JmOTJLNGRJam9jV2hxK0xKSmZMS1lhZ1RCR2U2WWZaSEZ3ZksvMFF5?=
 =?utf-8?B?blIwRFlDaXFjajJzUUE5Q2hDSlRrOTRQZjZteXpaUC9yemVpRXpIVzk4T3BR?=
 =?utf-8?B?c1kvTWRGa3BRa0d1U3ovNjVPZTNmTi9CNDJjWG1UK2dvTjd6TXk3cW1Ec1FV?=
 =?utf-8?B?OTArQU5MS3FXZ2VjRDBDNVFsNDREQkRjbm13dFJrL0VSc1VrUjZqSGVYNDR1?=
 =?utf-8?B?clRndUJwTE9UeE5BRDBDRGFuMzgxcm5xZ0dUalZNcXFCYytlZ1l6RFFpK3k4?=
 =?utf-8?B?cUwxUUF2SjlIRzNxQUZpVkV5azRDSUZscHU2c3BHc2d4Vkk0SzNncmhVREZF?=
 =?utf-8?B?MWRPOURIM1dScmgyYWZWbDJDbi9sK0NKMDdLUDJYdEVQUURjL3ltcWd6U2U1?=
 =?utf-8?B?blNkNDJCd1lSYnRyTm9aWkp0bnBsbHRnRTh3QWZSZzN5VU0zay90K0VTOWNL?=
 =?utf-8?B?T1pvMjNUZVBXOCtlS2hEY2Q2YW00TDBZU29IendueVY0cDdtaHJXU053MGRx?=
 =?utf-8?B?Y1Z6VkJPUHBGYzg4bjNnN3FWZnl2Z3BFSzd0dm5EUEJ4ZnkrN0RzVjlVNVh2?=
 =?utf-8?B?OHJKQjl4TzV2NEVwQ1kxbi9aNWd4Z2dmVzh3U2xzbXdka3JRalc5cFI0RHFn?=
 =?utf-8?B?YVkwTnlZd1Zjd25YTW81VmxZc0hCRi8yclRUUkJzV1ZGWkdwTGJZZjJHL0t3?=
 =?utf-8?B?a2dzK215VTdzQlA3Z01DZU9DblZvWDRhU0lsdUNabHNVbGNYTWxGTG9HU2Rj?=
 =?utf-8?B?N2RveHBIUWhXOWRVK0dFRE1VSVFzWkgvZk1RdTR2NEF2dTlwMUplZEViUVZy?=
 =?utf-8?B?SjBVUkU4U1BWOGsrWFV5SFoxUzY2TjZlZHF5YUovTklxZDd4anVCdzFVOGlF?=
 =?utf-8?B?clUwWHhoTkFkYXdjN1VEcTk0S296ZUNscGJiWDkwVEdQV3p5cHlKMTBlYWlY?=
 =?utf-8?B?dVZRU1REdTRmMS9EdDlzbDJvZ1VFRjg4UFhUcmZLU29kenJsQ1ZNZzVXb3I1?=
 =?utf-8?B?WnpJdHo5UUpmdThiSkNINE5KbTVOWnRxRWxpekVMQkFvbWRhVzM1SysrckF1?=
 =?utf-8?B?MVJWUEVMUWFJRFVsWXdsTEs0SlVNbHdKUFNvSzc3bVh4VnRUQW5ObERNR01J?=
 =?utf-8?B?RUNpZ3o1c2JoaUJOQThxdWJ4VzlqYlVjWm1TSFAvM1NNOEZzbG9jZ0M2ZWhv?=
 =?utf-8?B?VEpjYzRuSGJsRzJJQjU1Zk9KdFI2Qk15RFhhbEJ6SWVIcXJHeXlsMVpTZEwv?=
 =?utf-8?B?cDNta0tvTDNlaG1RT0dycXVXQUtNU1g5elNDZElHNjA2Y3B6eVJYYTJNTjdm?=
 =?utf-8?B?Q2dOemIzb3U2ZmVreHc5RWloWHdBNzB6SFJ5NHpRc2wyZTBGV1ZQaFlPT3NT?=
 =?utf-8?B?VEU1djdnYUJtN0ExS2JjeU90MXBYd1BZTVZzcHVIQlFLUUFEc0ZBVnFhTFQ4?=
 =?utf-8?B?TFVyQWprcXYyTUhtT0hCZjI0N3YzU3FtOHp5Vk1HRmFETmZNdVVReVFORFY1?=
 =?utf-8?B?Wm5ld1FINXNHSGlZMUlBNFVoUTM1YkE4K3l0NVU2MHRSMVdzUmpkWUdha1hX?=
 =?utf-8?B?TlFzRXQ4OU5BS3c3aXExN3dLODUwZHRHVFFHMmVUQzFXMFJDb0JlYmRGVThG?=
 =?utf-8?B?NVluOTNpM0V1VkwzbEJOSEtyci8zTGVrT0FLV2lRT1czVGRIbXp5eXNhNVJE?=
 =?utf-8?B?T1BJakR6K0hMUDlvcVpFK25zclNwelVLeEozRWgxd3JHQ3ZETlR1T3owdWxu?=
 =?utf-8?B?dlpoY3BXZmxZR1dLU0t3ay93WGNZUVpCYTBib0MyaWp0VkZpOFdtQjhFRjMz?=
 =?utf-8?B?aFY4RUNSS3NNSHIyaE5WRUVDYjlyNE9kL3hVRk1acXhYMWVQMmhwT2dweE5C?=
 =?utf-8?B?Z2R1VG16ZjNJTFFYTER6aDQ3UWZYMHZ4amNESERIL2swU0k5bVBUMnF4Z2RM?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BDF2E64F1562E4AA3E278CB4FA2C16A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1d35b-c222-484d-ed67-08dacc2f78b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 02:15:48.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSFH5kxrzuliRZnvg3PPUbm0xhMeBRS8s9SKTEFUHbs3m0sqta3qYujIuzH6/cbnGBMFRfptzxMvRtr/eQkUpZMYeko9WRt0MZt3tqeh5ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5551
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpTb3JyeSB0byBkaXN0dXJiIHlvdS4NCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0
byBjaGVjayB0aGUgY29tbWVudHMgaW4gbGFzdCBtYWlsIHdoZW4geW91IGFyZQ0KZnJlZT8NCg0K
QmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KT24gVGh1LCAyMDIyLTExLTE3IGF0IDEwOjE2
ICswODAwLCB5dW5mZWkuZG9uZyB3cm90ZToNCj4gSGkgUm9iLA0KPiANCj4gVGhhbmtzIGZvciB5
b3VyIGNvbW1lbnRzLg0KPiBPbiBXZWQsIDIwMjItMTEtMTYgYXQgMTE6MjkgLTA2MDAsIFJvYiBI
ZXJyaW5nIHdyb3RlOg0KPiA+IE9uIFRodSwgTm92IDEwLCAyMDIyIGF0IDA2OjI4OjMyUE0gKzA4
MDAsIFl1bmZlaSBEb25nIHdyb3RlOg0KPiA+ID4gbXQ4MTk1IGFuZCBtdDgxOTIgaGF2ZSBkaWZm
ZXJlbnQgY2xvY2sgbnVtYmVycywgY2FuJ3Qgd3JpdGUNCj4gPiA+ICdjbG9ja3MnIGFuZA0KPiA+
ID4gJ2Nsb2NrLW5hbWVzJyB3aXRoIGNvbnN0IHZhbHVlLg0KPiA+IA0KPiA+IE5vdCBhIGNvbXBh
dGlibGUgY2hhbmdlLiBFeHBsYWluIHdoeSB0aGF0IGlzIG9rYXkgaWYgaXQgaXMuDQo+ID4gDQo+
IA0KPiBUaGlzIGNoYW5nZSBpcyB1c2VkIGZvciBtdDgxOTUgcGxhdGZvcm0gZm9yIHNvbWUgYXJj
aGl0ZWN0dXJlDQo+IGNoYW5nZWQuDQo+IE5lZWQgdG8gc2VwYXJhdGUgdmNvZGVjLWxhdCB3aXRo
IHZjb2RlYy1sYXQtc29jIGludG8gZGlmZmVyZW50IGNoaWxkDQo+IG5vZGUuDQo+IA0KPiBBdCB0
aGUgc2FtZSB0aW1lLCB2Y29kZWMtbGF0LXNvYyBkb24ndCBoYXZlIGludGVycnVwdCwgYnV0IGhh
dmluZw0KPiBwb3dlcg0KPiBkb21haW4gYW5kIGNsa3MuDQo+ID4gPiANCj4gPiA+IE1vdmUgJ2Fz
c2lnbmVkLWNsb2NrcycgYW5kICdhc3NpZ25lZC1jbG9jay1wYXJlbnRzJyB0byBwYXJlbnQNCj4g
PiA+IG5vZGUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5m
ZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAuLi4vbWVkaWEvbWVkaWF0
ZWssdmNvZGVjLXN1YmRldi1kZWNvZGVyLnlhbWwgfCAxMTkgKysrKysrKysrKystDQo+ID4gPiAt
LQ0KPiA+ID4gLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCA0
NyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi0N
Cj4gPiA+IGRlY29kZXIueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi0NCj4gPiA+IGRlY29kZXIueWFtbA0K
PiA+ID4gaW5kZXggYzRmMjBhY2RjMWY4Li43OTQwMTI4NTM4MzQgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVj
LQ0KPiA+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiA+IHN1YmRldi1k
ZWNvZGVyLnlhbWwNCj4gPiA+IEBAIC04OSwyMyArODksMzMgQEAgcHJvcGVydGllczoNCj4gPiA+
ICANCj4gPiA+ICAgIHJhbmdlczogdHJ1ZQ0KPiA+ID4gIA0KPiA+ID4gKyAgY2xvY2tzOg0KPiA+
ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ID4gKyAgICBtYXhJdGVtczogNQ0KPiA+ID4gKw0KPiA+
ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiArICAgIG1h
eEl0ZW1zOiA1DQo+ID4gDQo+ID4gV2h5IGRvIGJvdGggdGhlIHBhcmVudCBhbmQgY2hpbGQgaGF2
ZSBjbG9ja3M/DQo+ID4gDQo+IA0KPiBJZiBtb3ZlIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgdG8g
Y2hpbGQgbm9kZSwgbmVlZCB0byBhZGQgJ3NzaWduZWQtDQo+IGNsb2NrLXBhcmVudHMnIGFuZCAn
YXNzaWduZWQtY2xvY2tzJyBmb3IgZWFjaCBjaGlsZCBub2RlLiBPbmx5IG5lZWQNCj4gdG8NCj4g
YWRkIG9uZSBpbiBwYXJlbnQgbm9kZSwgY2hpbGQgbm9kZSBubyBuZWVkIHRvIGFkZCBpZiBhZGQg
J3NzaWduZWQtDQo+IGNsb2NrLXBhcmVudHMnIGFuZCAnYXNzaWduZWQtY2xvY2tzJyBpbiBwYXJl
bnQgbm9kZS4NCj4gDQo+IEFkZGluZyAnYXNzaWduZWQtY2xvY2stcGFyZW50cycgYW5kICdhc3Np
Z25lZC1jbG9ja3MnIG5lZWQgdG8gYWRkDQo+ICdjbG9ja3MnIGFuZCAnY2xvY2stbmFtZXMnLCBv
ciB3aWxsIGNoZWNrIGZhaWwuDQo+ID4gPiArDQo+ID4gPiArICBhc3NpZ25lZC1jbG9ja3M6DQo+
ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBhc3NpZ25lZC1jbG9jay1w
YXJlbnRzOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+IA0KPiA+IFlvdSBjYW4ganVzdCBk
cm9wIGFzc2lnbmVkLWNsb2NrIHByb3BlcnRpZXMuIFRoZXkgYXJlIGFsbG93ZWQgaW4NCj4gPiBh
bnkgDQo+ID4gbm9kZSB3aXRoICdjbG9ja3MnLg0KPiA+IA0KPiANCj4gT25seSBuZWVkIHRvIGFk
ZCBvbmUgaW4gcGFyZW50IG5vZGUsIG9yIG5lZWQgdG8gYWRkIGZvciBlYWNoIGNoaWxkDQo+IG5v
ZGUuDQo+ID4gPiArDQo+ID4gPiAgIyBSZXF1aXJlZCBjaGlsZCBub2RlOg0KPiA+ID4gIHBhdHRl
cm5Qcm9wZXJ0aWVzOg0KPiA+ID4gLSAgJ152Y29kZWMtbGF0QFswLTlhLWZdKyQnOg0KPiA+ID4g
KyAgJ152Y29kZWMtbGF0LXNvY0BbMC05YS1mXSskJzoNCj4gPiA+ICAgICAgdHlwZTogb2JqZWN0
DQo+ID4gPiAgDQo+ID4gPiAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiAgICAgICAgY29tcGF0aWJs
ZToNCj4gPiA+ICAgICAgICAgIGVudW06DQo+ID4gPiAtICAgICAgICAgIC0gbWVkaWF0ZWssbXRr
LXZjb2RlYy1sYXQNCj4gPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdGstdmNvZGVjLWxhdC1z
b2MNCj4gPiA+ICANCj4gPiA+ICAgICAgICByZWc6DQo+ID4gPiAgICAgICAgICBtYXhJdGVtczog
MQ0KPiA+ID4gIA0KPiA+ID4gLSAgICAgIGludGVycnVwdHM6DQo+ID4gPiAtICAgICAgICBtYXhJ
dGVtczogMQ0KPiA+ID4gLQ0KPiA+IA0KPiA+IERyb3BwaW5nIGludGVycnVwdHM/IE5vdCBleHBs
YWluZWQgaW4gdGhlIGNvbW1pdCBtc2cgKHdoeT8pLg0KPiA+IA0KPiANCj4gdmNvZGVjLWxhdC1z
b2Mgbm8gbmVlZCBpbnRlcnJ1cHRzLCB3aWxsIGFkZCBkZXRhaWwgY29tbWl0IG1lc3NhZ2UgaW4N
Cj4gbmV4dCBwYXRjaC4NCj4gPiA+ICAgICAgICBpb21tdXM6DQo+ID4gPiAgICAgICAgICBtaW5J
dGVtczogMQ0KPiA+ID4gICAgICAgICAgbWF4SXRlbXM6IDMyDQo+ID4gPiBAQCAtMTE0LDIyICsx
MjQsNTUgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiAgICAgICAgICAgIFJlZmVyIHRvIGJp
bmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwuDQo+ID4gPiAgDQo+ID4gPiAgICAgICAg
Y2xvY2tzOg0KPiA+ID4gKyAgICAgICAgbWluSXRlbXM6IDENCj4gPiA+ICAgICAgICAgIG1heEl0
ZW1zOiA1DQo+ID4gPiAgDQo+ID4gPiAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gPiAtICAgICAg
ICBpdGVtczoNCj4gPiA+IC0gICAgICAgICAgLSBjb25zdDogc2VsDQo+ID4gPiAtICAgICAgICAg
IC0gY29uc3Q6IHNvYy12ZGVjDQo+ID4gPiAtICAgICAgICAgIC0gY29uc3Q6IHNvYy1sYXQNCj4g
PiA+IC0gICAgICAgICAgLSBjb25zdDogdmRlYw0KPiA+ID4gLSAgICAgICAgICAtIGNvbnN0OiB0
b3ANCj4gPiA+ICsgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiArICAgICAgICBtYXhJdGVtczog
NQ0KPiA+IA0KPiA+IFdlIGhhZCBuYW1lcyBkZWZpbmVkIGFuZCBub3cgd2UgZG9uJ3QuIFRoYXQn
cyBhIHN0ZXAgYmFja3dhcmRzLg0KPiA+IA0KPiANCj4gTXQ4MTk1L210ODE5Mi9tdDgxODYvbXQ4
MTg4IGhhdmUgZGlmZmVyZW50IGNsb2NrIG51bWJlciBhbmQgY2xvY2sNCj4gbmFtZXMsIHNvIGNo
YW5nZSBpdCBsaWtlIHRoaXMsIGRvIHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9uPw0KPiA+
ID4gIA0KPiA+ID4gLSAgICAgIGFzc2lnbmVkLWNsb2NrczoNCj4gPiA+ICsgICAgICBwb3dlci1k
b21haW5zOg0KPiA+IA0KPiA+IEFkZGluZyBwb3dlci1kb21haW5zPw0KPiANCj4gVmNvZGVjLWxh
dC1zb2MgbmVlZCBwb3dlciBkb21haW4gYW5kIGFkZCBvbmUgbmV3IGNoaWxkIG5vZGUgdmNvZGVj
LQ0KPiBsYXQtDQo+IHNvYy4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gWXVuZmVpIERvbmcNCj4g
PiANCj4gPiBSb2INCg==
