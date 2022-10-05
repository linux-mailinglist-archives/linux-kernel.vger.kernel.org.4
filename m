Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42235F4EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJEDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJEDdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:33:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186B75FE4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 20:29:04 -0700 (PDT)
X-UUID: 4b76852ca1f046dfb0b3fb799cd67881-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CUfKe5Bi176pExLTXoC/0Zioc0nRVISwQK06Gk94ldc=;
        b=hD0GnBP7QMnuDBOnSByuNPHAd+A5YAzJmNbXzpCNX6CKHZg+6IyXtOyNllaDW3XXOGsnBCweK4F8kMs2+3YIFeUIA1Teu6k43VvvOcGBwuL7vJQTfodBXGESpmTdQpo0s7tmFE7ljI9oZK/JHLCMGPc1zy5sBBFASqjNYjngK8A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:18ab457d-f599-4365-891e-93f01b5d0553,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.11,REQID:18ab457d-f599-4365-891e-93f01b5d0553,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:39a5ff1,CLOUDID:f07043fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:22100511290116F86UD6,BulkQuantity:0,Recheck:0,SF:38|17|19|823|824|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0
X-UUID: 4b76852ca1f046dfb0b3fb799cd67881-20221005
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1580226020; Wed, 05 Oct 2022 11:28:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 5 Oct 2022 11:28:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 5 Oct 2022 11:28:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0cTmdZt8pOp6zsnAmh91ak89j0xISe2Ir/wvL48BB2iXjpN5WzjE7SRH0xA32xD+uzQu+MC9EIGx0P5gcTJI8rPcdOVKw+FkZDY8sNgWpb6DQfYiulCFj96h12zzQsLq9E02X6UH4nTsFz4TDWr67xQLA5HAOuUg0Io6P74bduA6Uqn3ksWE+9dl8SSrsXA9h3cYMMHHlv55iwUUdsjCuppHXkeGt6z1XFrMUTuBllQlEXC79JiE+JHVS2A/9KGwIn34TzxNMeBzPyeS/WM6c03pNNwGs3lLOgofJ+xhS2eK595UwvD4xPFVh+vFxNywThhA3rlD9vcTBf76+NpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUfKe5Bi176pExLTXoC/0Zioc0nRVISwQK06Gk94ldc=;
 b=OHP1sKhbZAKUYYoGIhVtLMay+Ubmzg+C8X0opjGkBP8CegeP3molNzVRsVZCpe9fRKcDe0LofUmbsjFKeb20WUPHKr9KRB03wMuTuN4z/CYVZlugaRkY7sPdeRrFb8tpwz+kaVDxetzbVPZKBNIreFVDMi8+wzNQTZk8TcpN96vws1SWq0UalFMB2Zyz12kSM0/gcmn0DCRSwhMDH1/kphVNEKcG//jwsvN74zBN+wPyNZBdbHYXHqnvFf773SspkTunACLkAMbkE6alXn+2g3pmCxWvDEp12jMdVt7GonmGJIBXKQVa0qyxLKkMqsaxoHzPiuSOBRZKI/hufTbVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUfKe5Bi176pExLTXoC/0Zioc0nRVISwQK06Gk94ldc=;
 b=hBVPH1F/Cah5Ij2dTzk0+zPCFt2oqWx9px6jYbL9kYvL2mzKZ/TpNi2LgxvvYyxRgaTsamuwb6WKirG8xNyy59vweu1QjW8LMfOPRe2pk07rE0g1Pf83rQCTt9TgLrXolLBFET0Ey1TlIQsy0Sl0z3VXBoJKAXfKbMCmH8E8jjA=
Received: from TYZPR03MB6527.apcprd03.prod.outlook.com (2603:1096:400:1f8::13)
 by TY0PR03MB6703.apcprd03.prod.outlook.com (2603:1096:400:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Wed, 5 Oct
 2022 03:28:55 +0000
Received: from TYZPR03MB6527.apcprd03.prod.outlook.com
 ([fe80::454f:dbf:4e1f:7a07]) by TYZPR03MB6527.apcprd03.prod.outlook.com
 ([fe80::454f:dbf:4e1f:7a07%8]) with mapi id 15.20.5676.030; Wed, 5 Oct 2022
 03:28:54 +0000
From:   =?utf-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 2/4] tee: Remove vmalloc page support
Thread-Topic: [PATCH 2/4] tee: Remove vmalloc page support
Thread-Index: AQHY1vVsOAI3aGkJ6kG1DIjOysEShq3/JzRQ
Date:   Wed, 5 Oct 2022 03:28:54 +0000
Message-ID: <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
In-Reply-To: <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6527:EE_|TY0PR03MB6703:EE_
x-ms-office365-filtering-correlation-id: 3d85c08e-0712-40cb-780c-08daa681bb48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwFlREBBU6ib7GZrfaUiCbotAKSW8UNkkthVqc20LCYqdxc3IBAYdrLCpTI6guqGfoaFkeIEtnRkLxIS6GWdwc4fDKZw+zLa067hPKrzz6JgysXZVgvGjh/4yOTZWwrBdFxVm2n8wWn5DBcF2jiraOq4/GZH0srcqRboAhmrHLfLMf8ypXuxyeeM9NFpQ0oeT6sxEQ9QWpiPGPq1cQpJricCED9oYw7+1D0ZMS2wN+egltZ+mxhBFF7Z6ei7chtF6sVRNQwJNZK6OwMUKRTsaTHceLv1gtXKSXwy7wchD+4FgRo2b1ffDA6U5eGqX9DjHaLdzNlcDaBjI4FZ3nd4BIuPfwRTHv306CodQVyr2Ch5Fn0R+wG29ohsfspz/x9VURfuMRvbntSIjExB3VN+40NSdmHSJuLEZrTraoXuLPY6bSlvseyvsYkjwKCrLtB7FuqS7OLwq8sZRSWySapSzGx0Zkg8ZA/zu1GlZifbAUFVJEduLKnweeQjrXg5USEKbsb9QiAR4B1meFWgD5FaZoMtzzlA023QmjnMJGQ+2/A3cHNUuOGlzoYKuBmmNmnL5CfJjj+RolAvjEu6jYGId9qYpTtWQb65JfnXcQ9hGajEL9jwuleEDnf4QeDc5+HnHe00A4MfwpQLbJZsw4ecMXSNh+hCEMziKQNp8m8qkSTKzam92076gRQ0ceaRfMVrhuljhw763ukx7RgWeHLgpX1lwN/7q2QqAEpVFuvADZa3m2ufwDJfXAqe1SQKxkyVbAQsARKQHC6VtmctKxFl2fNKhrU9m4IWnhNzu5qbGea+hTrkT1oVT6is59guj1HIUEsLlZqKkx7y2qAI7XtiFfEV6n71PgwptA7UwB/JssA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6527.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(66556008)(316002)(41300700001)(85182001)(5660300002)(2906002)(7416002)(8936002)(52536014)(122000001)(55016003)(71200400001)(64756008)(38100700002)(9686003)(38070700005)(66476007)(66946007)(478600001)(33656002)(66446008)(966005)(110136005)(76116006)(54906003)(4326008)(8676002)(186003)(7696005)(26005)(86362001)(53546011)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFaYzRGSlhPRlFGVjVia1hZNzNJNXhhWFFONXcyRXpKVHVXWEFCQXlreExp?=
 =?utf-8?B?OGtFRUZwa1VnNWxlUkZFbGVCdUxSRlk4Z2R5TEY1cWZ1NnlJNTM0YmJGdGp5?=
 =?utf-8?B?ZXJPZGZLQ0trM3RMUGNhUlF3RmMvNVkwakI0djRkdWdTQWdpL3ZuV04zK0xW?=
 =?utf-8?B?VVBEWUJsZ1M3S0hBYzIzM29oWE1EdmlnWGpFbTN3eVFhekltS3cyclhQc1V2?=
 =?utf-8?B?RTdqV3JpOUtjR3N6NXlvUTBnN3A1Z2hQYWVIOWhZMllVZXdvWmJyYXhpVys3?=
 =?utf-8?B?YmlXWE5oMjJXU0JKMktBaHcxT25pc2VJZEw2ODRqK2pmQTRpSHR5ejU1bS9N?=
 =?utf-8?B?Qkx6b25wdDdkR3VScjA5N2liQlBmeVh2c1BFN3ZKM0xFRGU1RDg0U29LUDRB?=
 =?utf-8?B?M3pQT1BBVEkvWTBQNjZJTGFMZG53c0p2ZlBoYzhwdUM4bkNvSmFBeEY1a08y?=
 =?utf-8?B?YmdxMmxmOE5zSW51UGtISFdkanJFb2VLcW1neE9iaEsxUTBMWjZEdFFxU1NO?=
 =?utf-8?B?TkdnUXdlS2dxSjB4ZnNTdUd6VHlwdk1ScTBqUW9aeUw4Zm9mVWFXZGVIRzh2?=
 =?utf-8?B?UlUwWDZxZzVHY1o0QndIM1JQdWpYekhrZ1dxdVdpa1ZkUWVZaThIcXg1SktS?=
 =?utf-8?B?cUFWb3B1QWJodXZLZ0QwdnpETWFMMVVGU3RiSy9sN0Zad3lDeG8ydG9rVHNu?=
 =?utf-8?B?bkpyazRZbmJ1YTREdElvR0FqWUpjT3ZWYUhRUUpRbGpXeG9TWmZpR0hHQjVB?=
 =?utf-8?B?a0NOSzZJeTNqYVFwSDB0VVdvMHc0RTZlaEY3QmRKcGdNbmdKWHM4VlM2d0Ni?=
 =?utf-8?B?RlB4aTNxSlprVnZIQzlYTjBmNk9vRk5Wa0xWVi9kVFl2L2hmbVZocUczRlVw?=
 =?utf-8?B?M2s2dFZXYisyTWVwSHZNZCsrdk94SmZVcnJaL2FJeEJSQ2gzcEllOHVwSk4v?=
 =?utf-8?B?N1VkU2FDY1dsSXFqNEFNMEFrZjVtRlpqd2pLWHZ3T2ZoVWNDQkpGU3lQNlFW?=
 =?utf-8?B?cENHdmpMWG5WMzR4b0ZrdWJxbUdtNk5ReUgyMS9RNFRFMzJGcXRqWlhqaW9w?=
 =?utf-8?B?eW5KVS9wNG9xKzZaQm44OGhubFhGRks1QjJTcUtmbVJ3dXVWUDBpZEcrVnRL?=
 =?utf-8?B?cXBzL0NTeTBLTHpmejNtU0Y5WnV2TG1NL0lmaTVwSGVnc09RNHJoK1NHcTdV?=
 =?utf-8?B?dHA4cGJDSWFjUWVBQWx5QktKMkFyT29xbm9weHhXYVNyTmdrSkJKWVltRjdC?=
 =?utf-8?B?VW1KRjB1UDhMYUczWVdNc1ZpeTlqYml3a05NcnVXL2VSVEVHN3E0MW9hMXV3?=
 =?utf-8?B?L00rcmlQQUN4cUVxUkJjdFRmYmVYd3J6ZVdQTWZsaFFEZ2k3ODJiK3ZqUVRt?=
 =?utf-8?B?NTdKaC84ZUJITitsQkNBeS9OdThaQjN4VytqSW41ODdRbFNHSDhWaGlSRUJE?=
 =?utf-8?B?YXhSSjY2ZE1ib1VQU1hudDlqZDRIMHcvbE9VZjV1Q3Z4S2EraVdYV1RQd1lp?=
 =?utf-8?B?NmZKa1VlZ1NxVVVmRU9YWTZ6L3BxMzBXKzArUTE0L3U2Ui9IV254bHF2YzU3?=
 =?utf-8?B?aXpTbE5zUUZNMzZBN3VGQ0V0NElKbzU4VTRDN2ZDWndIVzlicFgyN1NjS0tm?=
 =?utf-8?B?TnNqZ2xsRXVlY25jM25qVXAvZTU4OXRPSGNZdS94a2lBWVk5a2pXejhNdlJ4?=
 =?utf-8?B?dUtYSVRJL2R1dHZzWEZTc2xGMnBHODN4dzR2S3RMY1d2ZzFhOUZJcjFyOFEz?=
 =?utf-8?B?cWh4VUxTcHI5am5SMTBvYzFVYk1yTEw0Y1VKRXdKWFRMYXppT3d3eTNtUC9j?=
 =?utf-8?B?QmJjZFJwT1JLZlVIN2VxMzJ0R0IybVdaU3l0REFmc0RyMWpXbzN0czBoYS9m?=
 =?utf-8?B?cnBUM2hWbUdrRDJSWERZS2JGbU1kQlpoSSsxZlNnelBtYktEY2V3NVBKclJR?=
 =?utf-8?B?Ykswc0x2QXBmbmNrYkNpTnprU1dyRkhrRzBFc2s2WllpTDU3TG10ME1JQ2Nz?=
 =?utf-8?B?RmZTUjV3bE9QNWNwNndKM3NMY09QK2FvU0h4RG52TzQ5OThDOHQ1WCtSL0k0?=
 =?utf-8?B?THU5aTExQ25wa1NiU01EQksyaTA1MlpQWVloL2J3TXBmYm1GQjFLZDk4SDZH?=
 =?utf-8?Q?nAuPqKU3jK35jkyUjPM++hAPN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6527.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d85c08e-0712-40cb-780c-08daa681bb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 03:28:54.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ympki48gXE9ajcjD5IsAYFozn9K3JRiGU75aWXdgn9kZhawgDzNT7lYu5AUaQjbLinPpNDOLxuOzDRvx2GlRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6703
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtaXQNCg0KVGhhbmtzIGZvciBtZW50aW9uaW5nIHRoYXQsIGluIGZhY3QsIG91ciBwcm9k
dWN0IGlzIGxvdyBtZW1vcnkgZGV2aWNlcywgYW5kIGNvbnRpbnVvdXMgcGFnZXMgYXJlIGV4dHJl
bWVseSB2YWx1YWJsZS4NCkFsdGhvdWdoIG91ciBkcml2ZXIgaXMgbm90IHVwc3RyZWFtIHlldCBi
dXQgaGlnaGx5IGRlcGVuZGVudCBvbiB0ZWUgc2htIHZtYWxsb2Mgc3VwcG9ydCwNCnNvbWUgc2Nl
bmFyaW9zIGFyZSBkcml2ZXIgYWxsb2MgaGlnaCBvcmRlciBwYWdlcyBidXQgc3lzdGVtIG1lbW9y
eSBpcyBmcmFnbWVudGF0aW9uIHNvIHRoYXQgYWxsb2MgZmFpbGVkLg0KSW4gdGhpcyBzaXR1YXRp
b24sIHZtYWxsb2Mgc3VwcG9ydCBpcyBpbXBvcnRhbnQgYW5kIGdpdmVzIGZsZXhpYmxlIHVzYWdl
IHRvIHVzZXIuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFN1bWl0IEdh
cmcgPHN1bWl0LmdhcmdAbGluYXJvLm9yZz4gDQpTZW50OiBNb25kYXksIE9jdG9iZXIgMywgMjAy
MiAyOjU3IFBNDQpUbzogaXJhLndlaW55QGludGVsLmNvbQ0KQ2M6IEplbnMgV2lrbGFuZGVyIDxq
ZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZz47IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsgRmFiaW8gTS4g
RGUgRnJhbmNlc2NvIDxmbWRlZnJhbmNlc2NvQGdtYWlsLmNvbT47IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24u
b3JnPjsgb3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgUGhpbCBDaGFuZyAo5by15LiW5YuzKSA8
UGhpbC5DaGFuZ0BtZWRpYXRlay5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gdGVlOiBS
ZW1vdmUgdm1hbGxvYyBwYWdlIHN1cHBvcnQNCg0KKyBQaGlsDQoNCkhpIElyYSwNCg0KT24gU3Vu
LCAyIE9jdCAyMDIyIGF0IDA1OjUzLCA8aXJhLndlaW55QGludGVsLmNvbT4gd3JvdGU6DQo+DQo+
IEZyb206IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4NCj4gVGhlIGtlcm5lbCBw
YWdlcyB1c2VkIGJ5IHNobV9nZXRfa2VybmVsX3BhZ2VzKCkgYXJlIGFsbG9jYXRlZCB1c2luZyAN
Cj4gR0ZQX0tFUk5FTCB0aHJvdWdoIHRoZSBmb2xsb3dpbmcgY2FsbCBzdGFjazoNCj4NCj4gdHJ1
c3RlZF9pbnN0YW50aWF0ZSgpDQo+ICAgICAgICAgdHJ1c3RlZF9wYXlsb2FkX2FsbG9jKCkgLT4g
R0ZQX0tFUk5FTA0KPiAgICAgICAgIDx0cnVzdGVkIGtleSBvcD4NCj4gICAgICAgICAgICAgICAg
IHRlZV9zaG1fcmVnaXN0ZXJfa2VybmVsX2J1ZigpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZ2lzdGVyX3NobV9oZWxwZXIoKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNobV9nZXRfa2VybmVsX3BhZ2VzKCkNCj4NCj4gV2hlcmUgPHRydXN0ZWQga2V5IG9wPiBpcyBv
bmUgb2Y6DQo+DQo+ICAgICAgICAgdHJ1c3RlZF9rZXlfdW5zZWFsKCkNCj4gICAgICAgICB0cnVz
dGVkX2tleV9nZXRfcmFuZG9tKCkNCj4gICAgICAgICB0cnVzdGVkX2tleV9zZWFsKCkNCj4NCj4g
UmVtb3ZlIHRoZSB2bWFsbG9jIHBhZ2Ugc3VwcG9ydCBmcm9tIHNobV9nZXRfa2VybmVsX3BhZ2Vz
KCkuICBSZXBsYWNlIA0KPiB3aXRoIGEgd2FybiBvbiBvbmNlLg0KPg0KPiBDYzogSmVucyBXaWts
YW5kZXIgPGplbnMud2lrbGFuZGVyQGxpbmFyby5vcmc+DQo+IENjOiBBbCBWaXJvIDx2aXJvQHpl
bml2LmxpbnV4Lm9yZy51az4NCj4gQ2M6ICJGYWJpbyBNLiBEZSBGcmFuY2VzY28iIDxmbWRlZnJh
bmNlc2NvQGdtYWlsLmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBT
aWduZWQtb2ZmLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+DQo+IC0tLQ0K
PiBKZW5zIEkgd2VudCB3aXRoIHRoZSBzdWdnZXN0aW9uIGZyb20gTGludXMgYW5kIENocmlzdG9w
aCBhbmQgcmVqZWN0ZWQgDQo+IHZtYWxsb2MgYWRkcmVzc2VzLiAgSSBkaWQgbm90IGhlYXIgYmFj
ayBmcm9tIHlvdSByZWdhcmRpbmcgTGludXMnDQo+IHF1ZXN0aW9uIGlmIHRoZSB2bWFsbG9jIHBh
Z2Ugc3VwcG9ydCB3YXMgcmVxdWlyZWQgYnkgYW4gdXAgY29taW5nIA0KPiBwYXRjaCBzZXQgb3Ig
bm90LiAgU28gSSBhc3N1bWVkIGl0IHdhcyBzb21ldGhpbmcgb3V0IG9mIHRyZWUuDQoNCkl0IGxv
b2tzIGxpa2UgSSB3YXNuJ3QgQ0MnZCB0byB0aGF0IGNvbnZlcnNhdGlvbi4gSUlSQywgc3VwcG9y
dCBmb3Igdm1hbGxvYyBhZGRyZXNzZXMgd2FzIGFkZGVkIHJlY2VudGx5IGJ5IFBoaWwgaGVyZSBb
MV0uIFNvIEkgd291bGQgbGlrZSB0byBnaXZlIGhpbSBhIGNoYW5jZSBpZiBoZSBpcyBwbGFubmlu
ZyB0byBwb3N0IGEgY29ycmVzcG9uZGluZyBrZXJuZWwgZHJpdmVyIHVwc3RyZWFtLg0KDQpbMV0g
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMudHJ1c3RlZGZpcm13YXJl
Lm9yZy9hcmNoaXZlcy9saXN0L29wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnL3RocmVh
ZC9NN0hJM1AyTTY2VjI3U0szNUNHUVJJQ1o3REpaNUoyVy9fXzshIUNUUk5LQTl3TWcwQVJidyF3
R09LUjlrM2toWkpsUHQxS194QkNYWDRFQk01WkNmV0t1cnVGZ1NQNDVIOHdUdkpyeDRfU3QzRmI1
WnJsakQ1UVEkIA0KDQotU3VtaXQNCg0KPiAtLS0NCj4gIGRyaXZlcnMvdGVlL3RlZV9zaG0uYyB8
IDM2ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90ZWUvdGVlX3NobS5jIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jIGluZGV4IA0KPiAy
NzI5NWJkYTNlMGIuLjUyN2E2ZWFiYzAzZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90ZWUvdGVl
X3NobS5jDQo+ICsrKyBiL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPiBAQCAtMjQsMzcgKzI0LDI1
IEBAIHN0YXRpYyB2b2lkIHNobV9wdXRfa2VybmVsX3BhZ2VzKHN0cnVjdCBwYWdlIA0KPiAqKnBh
Z2VzLCBzaXplX3QgcGFnZV9jb3VudCkgIHN0YXRpYyBpbnQgc2htX2dldF9rZXJuZWxfcGFnZXMo
dW5zaWduZWQgbG9uZyBzdGFydCwgc2l6ZV90IHBhZ2VfY291bnQsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKipwYWdlcykgIHsNCj4gKyAgICAgICBzdHJ1
Y3Qga3ZlYyAqa2lvdjsNCj4gICAgICAgICBzaXplX3QgbjsNCj4gICAgICAgICBpbnQgcmM7DQo+
DQo+IC0gICAgICAgaWYgKGlzX3ZtYWxsb2NfYWRkcigodm9pZCAqKXN0YXJ0KSkgew0KPiAtICAg
ICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7DQo+IC0NCj4gLSAgICAgICAgICAgICAgIGZv
ciAobiA9IDA7IG4gPCBwYWdlX2NvdW50OyBuKyspIHsNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgcGFnZSA9IHZtYWxsb2NfdG9fcGFnZSgodm9pZCAqKShzdGFydCArIFBBR0VfU0laRSAqIG4p
KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFwYWdlKQ0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiAtDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGdldF9wYWdlKHBhZ2UpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBwYWdl
c1tuXSA9IHBhZ2U7DQo+IC0gICAgICAgICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICByYyA9
IHBhZ2VfY291bnQ7DQo+IC0gICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAgIHN0cnVj
dCBrdmVjICpraW92Ow0KPiAtDQo+IC0gICAgICAgICAgICAgICBraW92ID0ga2NhbGxvYyhwYWdl
X2NvdW50LCBzaXplb2YoKmtpb3YpLCBHRlBfS0VSTkVMKTsNCj4gLSAgICAgICAgICAgICAgIGlm
ICgha2lvdikNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsg
ICAgICAgaWYgKFdBUk5fT05fT05DRShpc192bWFsbG9jX2FkZHIoKHZvaWQgKilzdGFydCkpKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+IC0gICAgICAgICAgICAgICBm
b3IgKG4gPSAwOyBuIDwgcGFnZV9jb3VudDsgbisrKSB7DQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGtpb3Zbbl0uaW92X2Jhc2UgPSAodm9pZCAqKShzdGFydCArIG4gKiBQQUdFX1NJWkUpOw0K
PiAtICAgICAgICAgICAgICAgICAgICAgICBraW92W25dLmlvdl9sZW4gPSBQQUdFX1NJWkU7DQo+
IC0gICAgICAgICAgICAgICB9DQo+ICsgICAgICAga2lvdiA9IGtjYWxsb2MocGFnZV9jb3VudCwg
c2l6ZW9mKCpraW92KSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgaWYgKCFraW92KQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+DQo+IC0gICAgICAgICAgICAgICByYyA9IGdl
dF9rZXJuZWxfcGFnZXMoa2lvdiwgcGFnZV9jb3VudCwgMCwgcGFnZXMpOw0KPiAtICAgICAgICAg
ICAgICAga2ZyZWUoa2lvdik7DQo+ICsgICAgICAgZm9yIChuID0gMDsgbiA8IHBhZ2VfY291bnQ7
IG4rKykgew0KPiArICAgICAgICAgICAgICAga2lvdltuXS5pb3ZfYmFzZSA9ICh2b2lkICopKHN0
YXJ0ICsgbiAqIFBBR0VfU0laRSk7DQo+ICsgICAgICAgICAgICAgICBraW92W25dLmlvdl9sZW4g
PSBQQUdFX1NJWkU7DQo+ICAgICAgICAgfQ0KPg0KPiArICAgICAgIHJjID0gZ2V0X2tlcm5lbF9w
YWdlcyhraW92LCBwYWdlX2NvdW50LCAwLCBwYWdlcyk7DQo+ICsgICAgICAga2ZyZWUoa2lvdik7
DQo+ICsNCj4gICAgICAgICByZXR1cm4gcmM7DQo+ICB9DQo+DQo+IC0tDQo+IDIuMzcuMg0KPg0K
