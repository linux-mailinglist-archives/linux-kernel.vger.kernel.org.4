Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289ED661E26
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjAIFC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjAIFCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:02:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4EF9FCE
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:02:47 -0800 (PST)
X-UUID: 59a81ed02ff743478f3fb8c28e5ff2eb-20230109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kFi4/MFIgI/0LmaYm1LqCv7qDrMYCq2P+g4CFiHgHAQ=;
        b=CJOzQHq3wtAhhzkm8XpqglGrg/ph0JDG3+ZMabN2lb2/aedAS6jCQOp3MN7ohytExMy1o4GbYz96kACsFs6n/MGHJsPyEbyvSdOWBiiaP3XDaZ64FSz6po1m6dAiQQ5XKDrMKLYXK0IPB5Vwf8W+VFd/1KztItB+8Cd+uYhlka8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:f335b2f0-c516-4e4c-8d86-5a19c698c9ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:f335b2f0-c516-4e4c-8d86-5a19c698c9ae,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:e9daaa8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2301091302433IZZU6AN,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0
X-CID-BVR: 0,NGT
X-UUID: 59a81ed02ff743478f3fb8c28e5ff2eb-20230109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1266390611; Mon, 09 Jan 2023 13:02:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 9 Jan 2023 13:02:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 9 Jan 2023 13:02:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMlsujdZOrUTvN90e5V8ScWAFzwMicDQREX11vcbbdHn7Bs6dpgPL/7RWGmIbAPwT3UerV3LwyiH+MBSxKFqwE+jfWZ4Um2G11vYVxLr69SE6lYZ69Xd5wpFV/zXRNmW/4O9W1u//dyG4Ll3UKNPY+ShxLCkjrnbGL9pndMj8D9YBOMgYy0hFrbpK7y/Z7xFVivJFvYcLbqEsUPUBGhEuWOqI/Es2rQDCyuzjPo4yejLQfBKg/u/NpE5hQEjmUSCHGgozxYIPWIQdGDFgNGHUakzI3oS4vaoOkEW+Zh10JGdBdnsA0P8HH3fYPAlUygr/nGKB90RSrMvYvsZi7rTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFi4/MFIgI/0LmaYm1LqCv7qDrMYCq2P+g4CFiHgHAQ=;
 b=odF2HJZeYIT2CPx5btxRMOKZEUhu0E+j6aK2FHEpuIU9CAxJ9oqVF9ekSDiKmiA+jTJuSz348piEbEhZZjAamIid8thIKAfVRjZter4yEZPldkc22ntbkIWZ4WxYlfFBZ+pMbC0G2ILLnubgxhlVfggBP4liI0/E1EIpcYeZ92k/qzQAg65Uag0oyakWLHH80PiUQYjyK2PEE+Xgxg970fS6+POSrHvuQZ+gU6F7gMvPNU4glYPH1Y6Z9ZnJUNpPsZ0oGQe88I98FLxnuUuI2FK4MtcXLwlu8Qur0KKGs6cfSqENonyv/ULEw6xUcfMPAV5sO6GWD7qPonkmbwLvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFi4/MFIgI/0LmaYm1LqCv7qDrMYCq2P+g4CFiHgHAQ=;
 b=K/nnx14k/oB5HR2KPPdeCpIq/oWY7ssyHV5UcY+IeGazBMFScbzBp3ku409d8zjIctT1eu9fzYXbxAf6GqJY79CQbuJBmeHXVaKdoOxRt8crlqMtC0fA4Q0P3ipWkfHm9XXncKPPZypkiNfEbPp1z+5d0aOZiUAgTA84LHaYIcw=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by KL1PR0302MB5411.apcprd03.prod.outlook.com (2603:1096:820:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 05:02:38 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 05:02:38 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] kasan: infer the requested size by scanning shadow memory
Thread-Topic: [PATCH] kasan: infer the requested size by scanning shadow
 memory
Thread-Index: AQHZH0jgINbB3ihm8EOrOsTiVH1z6q6NgimAgAgOdIA=
Date:   Mon, 9 Jan 2023 05:02:38 +0000
Message-ID: <dbaeb044c547ddb908bffdce4d2dfa0936805ef7.camel@mediatek.com>
References: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
         <CA+fCnZdk0HoWx6XCbTsiNhyR2Z_7zv5JUdgNs8Q_tV4GRkkmCg@mail.gmail.com>
In-Reply-To: <CA+fCnZdk0HoWx6XCbTsiNhyR2Z_7zv5JUdgNs8Q_tV4GRkkmCg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|KL1PR0302MB5411:EE_
x-ms-office365-filtering-correlation-id: 48b3be3f-62eb-4c79-824b-08daf1febac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nm3AFYYtf5/KWln8Hj8jyZgVhLaTUM0/eQI/rS+ZW69qbMZBkVvPJ4XC7FA9egQ18kXoZZzylYmjHWxm4StyRupFt0cSLgAhcCT5Wmzfss1MsgcZ+wRAPZMDNX58zoZVZn4Uy659SLl//iLmqeCqN8BjsZIUsH1MR7tTgz5PAULZwwQAAfaILtV28YVH1ucvwI4jEUyQf5bTQtPoOmWR+mIiZZzZK9hiIUJFmCl1+60R4B7p3JAw82prTOy7LXUYqcocx7HFNVlVLmCbQKPDrTmXLDpBgcbydfI/BgmqGIbdQqBZDU0ObwOwVgH1+k18nAAD6U3wq+CahlBoV+NJm+yK9KJUcqLdvWja5IVRWdQXK99pgBCQrNFh9BSOhCmWiUPmG7OJ4JEDPKjv45im9ivDQt0CPyz8qZ0ENIwVPjJwdSmNc6Jjik7MPDeGDUf+0e1CVnITjTxbEvbSPxR3uTE0n9b2Db9O4zb/oyAFoJnguKhEm6rP7P9Iy1atq7V4DYxz7t/K5yct5phcWkUc2bljHE7+S0hXI8OZP4/6HsLdKZMi9jKqbowYJ48vf1hA0q2yFIZbYJn323Lv+4bQBbNWUAl5UdJVNHfKMp/1nY7slW6ryGiub+HnaNaHr5aWicrVE3XEHKHNM+9qrVd70UgGelJJv5p9X5LG2u5T+Aeioqnc4xFmr8jfmp2MyTzHjd+YGApKfK1iRUhahxkQPk0H5JAIWYESyL8E815PHeds6W181xJMofTu7tPrgXWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(2906002)(8936002)(7416002)(85182001)(5660300002)(36756003)(41300700001)(64756008)(91956017)(8676002)(66446008)(66946007)(66476007)(76116006)(66556008)(316002)(71200400001)(54906003)(4326008)(6486002)(478600001)(26005)(53546011)(6506007)(186003)(6512007)(2616005)(6916009)(86362001)(83380400001)(38070700005)(122000001)(38100700002)(99106002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME55cWFCTk5zQW9JS1dqdnQ2SFBGQnpocE1sUVEwQUt4VHMzNUlPWHlOMENM?=
 =?utf-8?B?a25IRjFDNWZCOWRhSWFMOWhGdi9HUFJJRmRmMjdQTExtTXZYd3hNQjVmZytN?=
 =?utf-8?B?aFlvN0ZZTExuZWxVQlBLemdmMHJrWU9SY2s2NS8wc0o0bGFnSXNwdWRKYW1F?=
 =?utf-8?B?S29pdXdvWmNnS0dXOUV2SGhqeUZVMHVNZXh0eXBFUXA0ZFlOZjRuTVY1Tnc2?=
 =?utf-8?B?NC9lbmwvVm1hbzdPRkUyY1FIdHQ0SEtuMVpnWHNIbEJHclBhSVpLUDZTM3NB?=
 =?utf-8?B?R0tXc0VNR2wrak5XcU5Td28zangzRHJyU2cwRS9pd2pIVWtSVVVwb01yazBF?=
 =?utf-8?B?d2RJcjFZekZHT3FCR05vejR6NWRmekdZNjJGNFVieXJrYlBPTTdjVzFjditU?=
 =?utf-8?B?Y05HMXhmb0xReTMrQ0c3VTVaU20wSDRmbm1WQStNQ2hUNG93WnJ5b1lvenFy?=
 =?utf-8?B?UUp4MzBxWS9vMnZzcWpTYlZCdG45ZHkwK1pUZGhBQnhiaUUyZzlQejE5eVh4?=
 =?utf-8?B?RHVLM0lZTzRRSDFucEFFUlg5OVVFZWE1M3JFVWdFVmErNXp5Nm1xejYwMDE1?=
 =?utf-8?B?d0grT2pTZ0FWQkNJTm5jY2w0azJsZ2Z4VTVXdkxDL2JmZlFhVzN5UHRLbGRE?=
 =?utf-8?B?NXpYTHFIa1luVkk5UnZaZlNMbGV4K1lSK1lWbmxRTXcxcHZBU3dtckVFSU44?=
 =?utf-8?B?RGFsNFA1V21zR2hLc1dUNTd0Q0N1Q3FLcnpHc2paRnZtTzBOazlRMUorOVNp?=
 =?utf-8?B?cjFySHZLNk9yaG9XNGVEcFdXRGFrK0lJWkppMVdYOGtUZjdrUXVkWCtzSlZF?=
 =?utf-8?B?OUwxbG8rcjUxUXdkVHRyOTVYWE0xUE0zSEhaSDkvMmpYUEQzRUpjVmR3ZExt?=
 =?utf-8?B?RlB5YlNON2RiZG16aWtNeGtVaCs4ZG9YZ0tEYURydjlYSkJEeWhIUkdCMExt?=
 =?utf-8?B?MEc0amN3Q3pTWDkxOU9IMThVVnpLdkRuTFFObytQeUE5T1VXNHQ3V1FYczRV?=
 =?utf-8?B?bnFEeTNDL0JGRzNGc0xEM0xpcUxqWFM2eENpNnBuN0tmL2k3eU5QL3JoNTJw?=
 =?utf-8?B?NVFGZFE5Vi8vR2ZJcmw1d0xycVVGV0FkbUdMQmo3OUlER2F5dXN2SkJZTDRx?=
 =?utf-8?B?YndsZmpXRE1xNjJrK0RSZXdUaHQ2dHlPcnRYNlc3Q2dCMklLOW1JTnlpbEZU?=
 =?utf-8?B?Z1NGM2EzdUx6SmtrbklpWDZjblJPUHlLT2trOHpsWFZ0aGszOVFNTE5hRTFV?=
 =?utf-8?B?eDVUSnBPYjFyNlJGUUxHSGczeUd3V0NhY096Z0MrTzkxVFBEMFhXQzNmUUZY?=
 =?utf-8?B?dDkxcUxndTR4QkVaUC9PWHJvZGo0czFkb3hHTTg0TW5sS2x3MFE0VE5FQmdT?=
 =?utf-8?B?UEdoWU5wcHpMKzFaQS9sVVZkdUFxdDR2bUxpNUtJaStmL09WK2oyNUJUMFo1?=
 =?utf-8?B?Ykg2Rm82dWV1UUlvcG5WaHk3Y3JpTmhhTC82NVd4YS83dXdZcWxuVW0wa3Jw?=
 =?utf-8?B?eTVNTGpuN3phc09Hc3IrYkFqV3p6bFF0REtyeFN4M0hlZE4xdmR0QXpWNWxR?=
 =?utf-8?B?M2d5a295NkRFTFBoTTJLd21kTzZ6MFRSRG54NmRqKzhoVG9Ydm1BTm5FaTE2?=
 =?utf-8?B?NmdFWDdLZ1ZEaGUrczd5MTVpdVV5bEk3RG11TXBRYm5CclJrL2Jhc1ZhMDhE?=
 =?utf-8?B?WUNCMlJKSmt0OTVkVlQvNERCK0tBQVMrYk1lOTNXNXVaTnFMMWcwTFJNZGlR?=
 =?utf-8?B?ZXU3RWVHZnlUQXRyUTJQdFJaZk00Y09ZSEhXemxwakxBalNsN0N2MVBPdEdi?=
 =?utf-8?B?TlpvemxETFA4YWo2S1pVQm1YeXNMdUEvcFhDaFZoNGFMd1hDZTlaYVlRQ0NM?=
 =?utf-8?B?bGhsbkMwWGFYT3lZSnBoY0xNdi90elBnb2VTQURlMGpST3VKNkdDTzUraW9Y?=
 =?utf-8?B?UWVudzhqZUZ2ZytzT00xRFZvS0doVUZIL1JHZE5UV1NWaHBKZFloeGZlOXJ6?=
 =?utf-8?B?QWFjbm9QVVptN1YzbFRJbG5IbjdrdFUvVUhzbUpjcTNyaHQ5WDhUSjE5UVdG?=
 =?utf-8?B?UnZtb0huWlk3OFpML3REcm5YZndWVXJsc21GV3FBbzAzN2djTzdaQmlDVFRy?=
 =?utf-8?B?d1Nzb2VDNldzRlZlMVR4cHprRmNNS2g0UjFMRGcreVVOZFludVVoeVIvZWxG?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4E8FD454221D24EAD5D3D500652D74D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b3be3f-62eb-4c79-824b-08daf1febac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 05:02:38.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaoeGTbDqefBp55mGeogXMq4Kgp+AdFA5J73SXJsEhDQHX5ORVEfLKurzPX4+TCtjZbAWIaLOofXfZG8q14aldn1jeuM74t35zBilsfPbR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5411
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTA0IGF0IDAzOjAwICswMTAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBUdWUsIEphbiAzLCAyMDIzIGF0IDg6NTYgQU0gS3Vhbi1ZaW5nIExlZSA8DQo+IEt1
YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBXZSBzY2FuIHRoZSBz
aGFkb3cgbWVtb3J5IHRvIGluZmVyIHRoZSByZXF1ZXN0ZWQgc2l6ZSBpbnN0ZWFkIG9mDQo+ID4g
cHJpbnRpbmcgY2FjaGUtPm9iamVjdF9zaXplIGRpcmVjdGx5Lg0KPiA+IA0KPiA+IFRoaXMgcGF0
Y2ggd2lsbCBmaXggdGhlIGNvbmZ1c2luZyBnZW5lcmljIGthc2FuIHJlcG9ydCBsaWtlIGJlbG93
Lg0KPiA+IFsxXQ0KPiA+IFJlcG9ydCBzaG93cyAiY2FjaGUga21hbGxvYy0xOTIgb2Ygc2l6ZSAx
OTIiLCBidXQgdXNlcg0KPiA+IGFjdHVhbGx5IGttYWxsb2MoMTg0KS4NCj4gPiANCj4gPiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gX2ZpbmRfbmV4dF9i
aXQrMHgxNDMvMHgxNjANCj4gPiBsaWIvZmluZF9iaXQuYzoxMDkNCj4gPiBSZWFkIG9mIHNpemUg
OCBhdCBhZGRyIGZmZmY4ODgwMTc1NzY2YjggYnkgdGFzayBrd29ya2VyLzE6MS8yNg0KPiA+IC4u
Lg0KPiA+IFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZmODg4
MDE3NTc2NjAwDQo+ID4gIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGttYWxsb2MtMTkyIG9m
IHNpemUgMTkyDQo+ID4gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAxODQgYnl0ZXMgaW5z
aWRlIG9mDQo+ID4gIDE5Mi1ieXRlIHJlZ2lvbiBbZmZmZjg4ODAxNzU3NjYwMCwgZmZmZjg4ODAx
NzU3NjZjMCkNCj4gPiAuLi4NCj4gPiBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRy
ZXNzOg0KPiA+ICBmZmZmODg4MDE3NTc2NTgwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYw0KPiA+ICBmZmZmODg4MDE3NTc2NjAwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+ID4gZmZmZjg4ODAxNzU3NjY4
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gPiAN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+ICBmZmZm
ODg4MDE3NTc2NzAwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYw0KPiA+ICBmZmZmODg4MDE3NTc2NzgwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYw0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IA0KPiA+IEFmdGVyIHRoaXMg
cGF0Y2gsIHJlcG9ydCB3aWxsIHNob3cgImNhY2hlIGttYWxsb2MtMTkyIG9mIHNpemUgMTg0Ii4N
Cj4gDQo+IEkgdGhpbmsgdGhpcyBpbnRyb2R1Y2VzIG1vcmUgY29uZnVzaW9uLiBrbWFsbG9jLTE5
MiBjYWNoZSBkb2Vzbid0DQo+IGhhdmUNCj4gdGhlIHNpemUgb2YgMTg0Lg0KPiANCj4gTGV0J3Mg
bGVhdmUgdGhlIGZpcnN0IHR3byBsaW5lcyBhcyBpcywgYW5kIGluc3RlYWQgY2hhbmdlIHRoZSBz
ZWNvbmQNCj4gdHdvIGxpbmVzIHRvOg0KPiANCj4gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRl
ZCAwIGJ5dGVzIHRvIHRoZSByaWdodCBvZg0KPiAgcmVxdWVzdGVkIDE4NC1ieXRlIHJlZ2lvbiBb
ZmZmZjg4ODAxNzU3NjYwMCwgZmZmZjg4ODAxNzU3NjZjMCkNCg0KRGlkIHlvdSBtZWFuIHJlZ2lv
biBbZmZmZjg4ODAxNzU3NjYwMCwgZmZmZjg4ODAxNzU3NjZiOCk/DQoNCj4gDQo+IFRoaXMgc3Bl
Y2lmaWNhbGx5IHBvaW50cyBvdXQgYW4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MuDQo+IA0KPiBOb3Rl
IHRoZSBhZGRlZCAicmVxdWVzdGVkIi4gQWx0ZXJuYXRpdmVseSwgd2UgY291bGQgc2F5ICJhbGxv
Y2F0ZWQiLg0KPiANCj4gPiAtLS0gYS9tbS9rYXNhbi9rYXNhbi5oDQo+ID4gKysrIGIvbW0va2Fz
YW4va2FzYW4uaA0KPiA+IEBAIC0zNDAsOCArMzQwLDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0K
PiA+IGthc2FuX3ByaW50X2FkZHJlc3Nfc3RhY2tfZnJhbWUoY29uc3Qgdm9pZCAqYWRkcikgeyB9
DQo+ID4gDQo+ID4gICNpZmRlZiBDT05GSUdfS0FTQU5fR0VORVJJQw0KPiA+ICB2b2lkIGthc2Fu
X3ByaW50X2F1eF9zdGFja3Moc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLCBjb25zdCB2b2lkDQo+
ID4gKm9iamVjdCk7DQo+ID4gK2ludCBrYXNhbl9nZXRfYWxsb2Nfc2l6ZSh2b2lkICpvYmplY3Rf
YWRkciwgc3RydWN0IGttZW1fY2FjaGUNCj4gPiAqY2FjaGUpOw0KPiA+ICAjZWxzZQ0KPiA+ICBz
dGF0aWMgaW5saW5lIHZvaWQga2FzYW5fcHJpbnRfYXV4X3N0YWNrcyhzdHJ1Y3Qga21lbV9jYWNo
ZQ0KPiA+ICpjYWNoZSwgY29uc3Qgdm9pZCAqb2JqZWN0KSB7IH0NCj4gPiArc3RhdGljIGlubGlu
ZSBpbnQga2FzYW5fZ2V0X2FsbG9jX3NpemUodm9pZCAqb2JqZWN0X2FkZHIsIHN0cnVjdA0KPiA+
IGttZW1fY2FjaGUgKmNhY2hlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gY2FjaGUtPm9i
amVjdF9zaXplOw0KPiANCj4gUGxlYXNlIGltcGxlbWVudCBzaW1pbGFyIHNoYWRvdy90YWcgd2Fs
a2luZyBmb3IgdGhlIHRhZy1iYXNlZCBtb2Rlcy4NCj4gRXZlbiB0aG91Z2ggd2UgY2FuIG9ubHkg
ZGVkdWNlIHRoZSByZXF1ZXN0ZWQgc2l6ZSB3aXRoIHRoZQ0KPiBncmFudWxhcml0eQ0KPiBvZiAx
NiBieXRlcywgaXQgc3RpbGwgbWFrZXMgc2Vuc2UuDQoNCldpbGwgZG8gaW4gdjIuDQoNCj4gDQo+
IEl0IG1ha2VzIHNlbnNlIHRvIGFsc28gdXNlIHRoZSB3b3JkICJhbGxvY2F0ZWQiIGluc3RlYWQg
b2YNCj4gInJlcXVlc3RlZCINCj4gZm9yIHRoZXNlIG1vZGVzLCBhcyB0aGUgc2l6ZSBpcyBub3Qg
ZGVkdWNlZCBwcmVjaXNlbHkuDQo+IA0KPiA+IC0tLSBhL21tL2thc2FuL3JlcG9ydC5jDQo+ID4g
KysrIGIvbW0va2FzYW4vcmVwb3J0LmMNCj4gPiBAQCAtMjM2LDEyICsyMzYsMTMgQEAgc3RhdGlj
IHZvaWQgZGVzY3JpYmVfb2JqZWN0X2FkZHIoY29uc3Qgdm9pZA0KPiA+ICphZGRyLCBzdHJ1Y3Qg
a21lbV9jYWNoZSAqY2FjaGUsDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgYWNj
ZXNzX2FkZHIgPSAodW5zaWduZWQgbG9uZylhZGRyOw0KPiA+ICAgICAgICAgdW5zaWduZWQgbG9u
ZyBvYmplY3RfYWRkciA9ICh1bnNpZ25lZCBsb25nKW9iamVjdDsNCj4gPiArICAgICAgIGludCBy
ZWFsX3NpemUgPSBrYXNhbl9nZXRfYWxsb2Nfc2l6ZSgodm9pZCAqKW9iamVjdF9hZGRyLA0KPiA+
IGNhY2hlKTsNCj4gDQo+IFBsZWFzZSBhZGQgYW5vdGhlciBmaWVsZCB0byB0aGUgbW9kZS1zcGVj
aWZpYyBzZWN0aW9uIG9mIHRoZQ0KPiBrYXNhbl9yZXBvcnRfaW5mbyBzdHJ1Y3R1cmUsIGZpbGwg
aXQgaW4gY29tcGxldGVfcmVwb3J0X2luZm8sIGFuZCB1c2UNCj4gaXQgaGVyZS4gU2VlIGthc2Fu
X2ZpbmRfZmlyc3RfYmFkX2FkZHIgYXMgYSByZWZlcmVuY2UuDQoNCkdvdCBpdC4gV2lsbCBkbyBp
biB2Mi4NCg0KPiANCj4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMhDQo=
