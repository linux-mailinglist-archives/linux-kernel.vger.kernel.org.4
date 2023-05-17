Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B565705E26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjEQDeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjEQDeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:34:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFB1FCD;
        Tue, 16 May 2023 20:34:14 -0700 (PDT)
X-UUID: af2c384af46311edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l7HKuSWfsV9Z7KWRPF9sQITux1jvgjBpGOLhlznnBmw=;
        b=IMCGhaQ0TcaNOqME7tBF1HIjYwfHZK88uSr05H99HgNMCkctSIqJnlKSAS67WA85s5RAQCjnIBb7j8rNqrboRDZueaXu0BM+KLSPdXMJXgjtoMUj//gG6C+awy2Wx3vxz8tSad2AkM4A8rs7yyqaSnoR1JMJ5Xpcdg7uCUsvfQc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3b9a8906-e5ec-4eb0-b64d-ef13cc334789,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.25,REQID:3b9a8906-e5ec-4eb0-b64d-ef13cc334789,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b2536a3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230517113410FTGNAD4K,BulkQuantity:0,Recheck:0,SF:17|19|38|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: af2c384af46311edb20a276fd37b9834-20230517
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 388744936; Wed, 17 May 2023 11:34:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 11:34:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 11:34:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkgp3bvwoaJtKRwJDigG0UCZz3OZVmrxwNGjzCHIEneJO5wsnmwgO25psQMeImzHPU60dWf4gc+iut2j5XNVRd57IjuQZ+kskQOaMELrNAJftAwurHCgGdGoqR9+qLfFsif1W2312SbS8nRQhOfZH1HJrS88gvAMmvwpFXizleAEEXsGTEyXS5At4IShW9HeSCUMjLS4mYvYw6aTx1KgOKil24zRORLAPIVSyHK1FQNDJ81th+IA4myof9VLbd/SeYNm/wb/qUjvveAXdBPrNMDkWml46eN+1/p1mSDvFdpIaHh6DGqKndFpgP8EPk2S+OwOrR6E2iiT2ezO7mDfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7HKuSWfsV9Z7KWRPF9sQITux1jvgjBpGOLhlznnBmw=;
 b=H15MHkDrikvlXRMjpn9fIjjzc6AzYSjmyIWmym3RRqUKtMsTmxo7KDDLzUiCHjbJOlAplfnzCf6iW4d7B1glSRjBKBqr2rfKdKhs/MlabBD8siVq56wII+3he6Ab+CaQZMr7vV18+GNGHE0AMZfawP+Lih+g68OOOk5Y5sSRudI28i84/aeeV+CS9iDzB+LcjMwHQ/iPPGxlqax8N1Ou/jFxPYNgoQUmxKikJmVBl4ftQ0eyXZfXx1yMwBGNL7s+UP1D4hl1udWqqqT+dMz3j+klM9JF6j0sLipNhhZJ4J5hYVcf7pXaCEqgGZSgUavKrItGjbLsqc8o8fz89/g5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7HKuSWfsV9Z7KWRPF9sQITux1jvgjBpGOLhlznnBmw=;
 b=BaldCOAkIB5ny5UWI3nrm1o8T6xmWJxFgA+PUHaNG6/e8nJKbFRWFFMbm1s2PVUA+mMP8Aoz2aA5+Sk6XUXvzE1A6YP0IIsjZV/5F2EGO5fP1MlMluAjdD78J2zYlbBxzOLMNtALoyjkGIB30E3NBgufXdnuEafZXN8vA4ojTKM=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5358.apcprd03.prod.outlook.com (2603:1096:400:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 03:34:06 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a%3]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 03:34:06 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3,0/4] media: mediatek: vcodec: Fix decoder under flow
 and plt test fails randomly
Thread-Topic: [PATCH v3,0/4] media: mediatek: vcodec: Fix decoder under flow
 and plt test fails randomly
Thread-Index: AQHZdnJIJDLSf8c5qEG7U7dhQN9Ywa9d8/eA
Date:   Wed, 17 May 2023 03:34:06 +0000
Message-ID: <6ca2ccc8dfab19f45d6f6d25bc489ea7258dbb69.camel@mediatek.com>
References: <20230424060130.18395-1-yunfei.dong@mediatek.com>
In-Reply-To: <20230424060130.18395-1-yunfei.dong@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5358:EE_
x-ms-office365-filtering-correlation-id: ccb4364a-f5e9-4132-c765-08db5687914c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TTFOZRsms+EvRWt1vqc2A7L1ZeKS/E6JdKyU9T90/5yEclj3GdDphE7soGm12GgiIZdxAA9dsBQ6mdm6YdK2xSu/HK3/KmPm/lE4yyoPKEkHsaS874CIqO1OG0OYh97UMcC/Gw0+kplAWYft/A1szGYmxnDKcMjnzE5aOl2jkj+yzaQSrQgL+i7ivQH215k15LcACKpmRqs8mC9FyNkE4gKfZxPEXYdQRjKPuc6n0lfjR8gIHmLwaYrbEQhKQ8jFvWSCgUu8XVraZrgLoXcqpjIg2a/sCEb0oKMWi/K9APBUJ6YVyv42v0wm25KZlcw5qAwxrOZwFgxY6u+96n+J4L9JuWZse+BhL5j5LHhTLYtz1hXrYte8Bjd8A8KpBNM7meW5llcq5E2AoPHfImq69iddQxRARC4e/sgPnjTXbJgIcVn3RMKYfI7EF8rCwrG5WIFLuX3NU7s8po3umYmBo4VU2fdCK/0PubnF2ylmEMrUP499Z3ypV80yUYPx9o4+BGtpQ9Fgd0j19h7CyxGZ6uQqRhQa0GrXu0s55A0GnHvK4fcYFmNC1vsZljYE8NRiZkhPJkI3LiQvLxLdUr8CKiTsG3h0n1vk5L8FNd4WsDzIeVpSdFS6fwV7x50yTFFi8y/EBAI2mqaTmY1AbcBBPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(83380400001)(91956017)(110136005)(478600001)(71200400001)(6486002)(54906003)(2616005)(6506007)(26005)(186003)(6512007)(2906002)(36756003)(38070700005)(4326008)(85182001)(7416002)(38100700002)(122000001)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(41300700001)(5660300002)(316002)(8676002)(8936002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25vVVROZG5JM1lMcnFFemRlQ0xXdTlHKzJxTnREditkMGdheitaQ2tUYzB3?=
 =?utf-8?B?SHdVK1lpNWVJWUF4OHh6RGVzd3g1d1lTcGNDR3lHTFpnYnhuYVVsZVMzemRx?=
 =?utf-8?B?a2FkakQ1Y3YwbDB4eTNocUJodjlGand4MW9hSy9oditBMWF0NW9reTFSdEts?=
 =?utf-8?B?YUIwQUU2UGUwV3JWeVNuK25YWUdmT1RFbjlVZTU1L3RzMW1iTnZWOWdrTEl4?=
 =?utf-8?B?Z25URm5TcDRnVjBmREgxNkRrRU52UVBZVzNKMVhIaEVjblNPWkdQdG5KRTdC?=
 =?utf-8?B?TzluM0poQXQ5MGJibmpUbGFjSG1rZUxudytJRWQvM2lBYVJiMzlMV2FscEFM?=
 =?utf-8?B?bXQreDVvY3ZhMWRoTExmN2l6Qk1lOStINktrWUFtbVhqVTZoZ3luTkl1Z3dq?=
 =?utf-8?B?UDIycDNDbVZsN0RUbkUwM2ZkbVRzTTQ1T0wzL0NFRkNVYkZ6R0JxRldOSUdC?=
 =?utf-8?B?dE1SSEdaUVEzRUMvQlZXZDlhUlp3TzZFcVBqNTJVekNWQndjbHlmWUQ3VEVT?=
 =?utf-8?B?cjFLbTZYUWdhdGpDMlptZERMOWlRMDBKTHZNc1E4VWZTOUlSZHVFNGMwbEsz?=
 =?utf-8?B?U3RNUjRlcFhXWU9UcWpsR2t4REoxZzVmWlFlZEpGMTJBUGFjUmVhWWZydmEx?=
 =?utf-8?B?c3JXeEF4N1g5ZlprQ1hNQWpqNWxLK1dLYTF0S2V2YmJ0SGQ1NllGbjFsVTE3?=
 =?utf-8?B?Tmc1TTh4aXF4VFJ1R2N3d1FTNG9OcVlOQWI2aHJvckhWNFJBWjA1cHZnWlJu?=
 =?utf-8?B?RzEzRkdqUG5CQ1VMWjgxeGlvWUJlR2F4RTBOY2xEN01TU3BlQnZnaDIxQjFu?=
 =?utf-8?B?dk8wNFlUbG1GdjdoaXg5MFdIdFdGTGNud25CVHlnM2hVK2JVZklOdUZaWTVk?=
 =?utf-8?B?NFMxQkJ3SjR1TlVWdXBwTUVWbHV4ZEFhR3VVWlliZnU5QnBwcTlZczBDSlh6?=
 =?utf-8?B?OVo5RjdWQWpCRlh4bzhtWVRIcWpWY01mYU9PbmdhTHJiTk1lbnVJaFNxdjVj?=
 =?utf-8?B?ODBNM3c1WmNWTDRyMktDTzZGUEdJSE5MVzVKdE1GODkwcUgrT2RIbWZIWWda?=
 =?utf-8?B?UGFNcWRyeUpacWcwVkVBR0pXcHVYQXdyRWprQUlWWmlPNnp6M3F1dTZnQkpG?=
 =?utf-8?B?UVE3Q0hhR0dScHFZb0tnU0FVZS9BUGxONWtpamN1UW05RjBaL3FFS3p0UndU?=
 =?utf-8?B?SjZ0ZzczMldoRVh2RTFGWGU5NzJFRzdzQm43RkpmT25TdnhHd2ZhdjVWa2hC?=
 =?utf-8?B?N0d5eVVQcENWQlU2UktNdUkwV2hPdHhGcHRONytFMXVGL3F0YnZiV0ZLTWwv?=
 =?utf-8?B?eU0yTkNSUjRQeEptaEgxMXBQMnhBazZTaXhLVWRUWFZKRUxNUHdJbEZZZGh1?=
 =?utf-8?B?YmJiODF5NHphWTh3MnZFbE9MRUozbU1TdDBaMWN1eWR6cnBBU0NqL0pFYmhK?=
 =?utf-8?B?eHdsRDRLSCtvM29jU0s5N2YzRC9WZGpQT2tZMGdhcDBQOXo5UUNGY3ZYVG9N?=
 =?utf-8?B?RGhoTWtzNGhYU0JXZ0p1U0s4Yk9FeVNQeHo3TWxXQURUU2RLTW96bmNYNmRM?=
 =?utf-8?B?TFpKYUhicjNOaFRJUk42Rit1NmdpQTBWWVpWVEFZNW84QzBrSytSZWQxY1B2?=
 =?utf-8?B?RmVlVHR4L3BxSFl2UVhCUDRiVUoyVmNIWmhVaExydDRqb3NsWlZkd1RuS01C?=
 =?utf-8?B?aG1NZHczczRzVHZwSnZFVzYxVWMyam1vTFI3a3Z4OXNDRytRdzdGODBHOFBX?=
 =?utf-8?B?VUVmWmowcnFlSkl1MWVlQ1E5NGoyZERBdXVja0FlcmZHNS95K0JTYmpRWGt1?=
 =?utf-8?B?RlNHWjZ4ZHYrQURTY0VMODY3VHI4eDVJMVhPTm5RVm50bTYzRkVrdEk3bENy?=
 =?utf-8?B?b0JOY3d4cmFneWswR1lEL2prclNzMWVIVWxiMGhObWtQMnREOE5xN1ZpUjlI?=
 =?utf-8?B?N0s3Mm1iVTM1L2tweXI4NitjZndMMVJDWDI2ZTNpT0NQUWFETjN5bGdJRWhE?=
 =?utf-8?B?bHJYcy84ME5nN20wbG5HSklzdXR4Z2dvWG9VaFNSYkRnWDVPZjNvVHo4RFdW?=
 =?utf-8?B?elhlTDJrbUJTUDJaMzI4WlgvbnhxaDVtVmkzYmpLQ1lsV0JtamxSZjZiZGMr?=
 =?utf-8?B?S2JnT1l0M0M1NllzbElnb2xabUxNdXk5THZCZFpLWFhNbjNFa1FVeGgzenhy?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C4209F9FD48145A679546DAAC50F68@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb4364a-f5e9-4132-c765-08db5687914c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 03:34:06.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p88kyH7p0FRObaYwDaNd2+2eXWI69yLjuYDZ5YyeepV155mlSpNoyldPtOk8AdpWpDkaI9HStN3oYHdnfZpFiwB3xY6v8yzbbLDeYw3mkR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5358
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBIYW5zLA0KDQpTb3JyeSB0byBkaXN0dXJiIHlvdS4NCkNvdWxkIHlvdSBwbGVhc2UgaGVs
cCB0byByZXZpZXcgJiBtZXJnZSB0aGlzIHBhdGNoIHNlcmllcyB3aGVuIHlvdSBhcmUNCmZyZWU/
DQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQoNCk9uIE1vbiwgMjAyMy0wNC0yNCBhdCAx
NDowMSArMDgwMCwgWXVuZmVpIERvbmcgd3JvdGU6DQo+IDE6IEdldHRpbmcgZGVjb2RlciB1bmRl
ciBmbG93IGVycm9yIHJhbmRvbWx5IHdoZW4gZG8gc3RyZXNzIHRlc3Qgd2l0aA0KPiB5b3V0dWJl
Ow0KPiAyOiBWaWRlbyBkaXNwbGF5IGJsYWNrIHdoZW4gZG8gcGx0IHRlc3Qgd2l0aCBvbmUgbmln
aHQuDQo+IA0KPiBwYXRjaCAxIGF2b2lkIHVubmVlZGVkIGVycm9yIGxvZ2dpbmcuDQo+IHBhdGNo
IDIgdXNpbmcgZGVjb2RlciBzdGF0dXMgaW5zdGVhZCBvZiBjb3JlIHdvcmsgY291bnQuDQo+IHBh
dGNoIDMgbW92ZSBjb3JlIGNvbnRleHQgZnJvbSBkZXZpY2UgdG8gZWFjaCBpbnN0YW5jZS4NCj4g
cGF0Y2ggNCB1c2luZyBlbXB0eSBsYXQgYnVmZmVyIGFzIHRoZSBsYXN0IG9uZSB0byBmbHVzaCBk
ZWNvZGVyLg0KPiAtLS0NCj4gY2hhbmdlZCB3aXRoIHYyOg0KPiAtIGZpeCBidWlsZCBlcnJvciBm
b3IgcGF0Y2ggNA0KPiBjaGFuZ2VkIHdpdGggdjE6DQo+IC0gcmUtd3JpdGUgY29tbWl0IG1lc3Nn
YWdlIGZvciBwYXRjaCAxDQo+IC0gc3F1YXNoIHYxIHBhdGNoIDIgdG8gdjEgcGF0Y2ggMyBmb3Ig
cGF0Y2ggMg0KPiAtIHNxdWFzaCB2MSBwYXRjaCA0IHRvIHYxIHBhdGNoIDYgZm9yIHBhdGNoIDQN
Cj4gLS0tDQo+IFl1bmZlaSBEb25nICg0KToNCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzog
QXZvaWQgdW5uZWVkZWQgZXJyb3IgbG9nZ2luZw0KPiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVj
OiB1c2luZyBkZWNvZGVyIHN0YXR1cyBpbnN0ZWFkIG9mIGNvcmUgd29yaw0KPiAgICAgY291bnQN
Cj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogbW92ZSBjb3JlIGNvbnRleHQgZnJvbSBkZXZp
Y2UgdG8gZWFjaA0KPiAgICAgaW5zdGFuY2UNCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzog
dXNpbmcgZW1wdHkgbGF0IGJ1ZmZlciBhcyB0aGUgbGFzdCBvbmUNCj4gDQo+ICAuLi4vbWVkaWF0
ZWsvdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jICAgICAgfCAgIDEgLQ0KPiAgLi4uL3Zjb2Rl
Yy9tdGtfdmNvZGVjX2RlY19zdGF0ZWxlc3MuYyAgICAgICAgIHwgICAyICstDQo+ICAuLi4vcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZHJ2LmggfCAgIDIgLQ0KPiAgLi4uL3Zj
b2RlYy92ZGVjL3ZkZWNfaDI2NF9yZXFfbXVsdGlfaWYuYyAgICAgIHwgICA2ICstDQo+ICAuLi4v
dmNvZGVjL3ZkZWMvdmRlY192cDlfcmVxX2xhdF9pZi5jICAgICAgICAgfCAgIDQgKy0NCj4gIC4u
Li9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlY19tc2dfcXVldWUuYyB8IDEwNSArKysrKysr
Ky0tLS0tLQ0KPiAtLS0tDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWNfbXNn
X3F1ZXVlLmggfCAgMjggKysrKy0NCj4gIDcgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygr
KSwgNzQgZGVsZXRpb25zKC0pDQo+IA0K
