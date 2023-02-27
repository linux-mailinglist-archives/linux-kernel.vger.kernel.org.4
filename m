Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E58D6A3914
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjB0Cxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjB0Cxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:53:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858CA5C8;
        Sun, 26 Feb 2023 18:53:23 -0800 (PST)
X-UUID: d8d0e20cb64411ed945fc101203acc17-20230227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y/Jqojwpu43vihLkwK975Iu2rgojLKEEpUN2An05XII=;
        b=ew6ZiZTzB3mhlcR8cwsYj0qU+Xxka0NlQ+AOYTndI23lgS/8xiL2jIXIlVz61TN5cF0h4AQy1cUPQIdqiP7QLwLkB5XQ7Iw2DDVV1w4QNkcyc5ElWlGLWdtY2NJ6puMT2KKQK7zTul/F9nn+jwTyc8EG6yR6JEpkON9zp6jDWQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:6179c400-1223-4cb3-8e38-c2b565a099a2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:6179c400-1223-4cb3-8e38-c2b565a099a2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:8aaca0b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230227101714YXNHBK5L,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0
X-UUID: d8d0e20cb64411ed945fc101203acc17-20230227
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 444589103; Mon, 27 Feb 2023 10:17:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Feb 2023 10:17:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Feb 2023 10:17:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndqJrdmebUINb+hzTmJ2lYWzPQV80Rug9n9sdYW3u7TeOG7uZJxRXuUCC/qqqhgH3+eSJvNtmApmQIg7JAntXgZ8p9Gy073NdDDXx+hok1Chb6hWSB8ZYtFb6CUc+ev6gBc3LUzeO8qpFd1VjJTX+MMNu4/JFJsSFq/IS/H9O9ang2eNp81gwwKxVs6222lfQCP2cTcqMlgu1C268LjXgMUhztALmsnNBuotatKOFnwLH+rLcLg3yOkfZ/vNFT4MoM8rCORnlfP2uTVXn8snEs8+HPCBIwSSuJM1cGYYY+/VAy0k8QU9WGvfNjufd1AJCdLrHc4omGm6TP1Og1e4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Jqojwpu43vihLkwK975Iu2rgojLKEEpUN2An05XII=;
 b=QdzXRb77moiYJnEaEZKNYWaRdW1fdOsRIFXY3KtC+RdXkxcUTq7yJ3wYOH/D5Lw2AZFd8OJHDCsviigdQgMTqwTdwONAnM+80Do4OBfoKqQn9XFYrdYJzkQdYC7hyNo2OaFOqr+MxUzwb8Zwh25wngIh72mA1DudSdaoJzYhWvZl186GiJ7R/LBg91VP5eGBOJTWyr7C7N/gkqr1IPkNnMUt1bQxiyVoMh7P1EqeK0JgfKfkyjbanV5a+uK3P8AFteMrs/z/S5Ikn9fFqdpF+x+3G2yfiTzP3R+geaGnBNz+xcreEv0/W8sf0EIGe+Y7gwomMVGfE1qCYj4Z3wZI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Jqojwpu43vihLkwK975Iu2rgojLKEEpUN2An05XII=;
 b=hvkft6t78zbcfXvUdayBh4BdIIYefAaE2kS3IG0wn6qOU29U5tz0htf8neeW/j3/dbcRDLreAX9T/t7OrQhxAEpDr5BuAHmSiZO8KBBh7beYvzbnpLvQhfr5eY5QnFFv3txQvMEN9jhJXVM8q+PGE7bt1kWbQwYM0ZDloLhYBN8=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB7002.apcprd03.prod.outlook.com (2603:1096:400:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Mon, 27 Feb
 2023 02:17:09 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%4]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 02:17:09 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v2] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZPRRh7fZS99I5qEegpearM3gM+67IULWAgAVs3YCADczZAIAGnpqA
Date:   Mon, 27 Feb 2023 02:17:08 +0000
Message-ID: <f3d53cf7bfbaf092e1020c41316668b9f53b890b.camel@mediatek.com>
References: <20230210055518.6017-1-yunfei.dong@mediatek.com>
         <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
         <f6148f4c4864d324b52a52cc87b8785d958ceeb5.camel@mediatek.com>
         <20230222211154.mhl7mihycl7eq5v6@notapiano>
In-Reply-To: <20230222211154.mhl7mihycl7eq5v6@notapiano>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB7002:EE_
x-ms-office365-filtering-correlation-id: 956aa791-fcf1-4497-d44b-08db1868baa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVJ+FWlHLtOM/8XXzjrO2mdThEMA1eJj0MujbI03JkZfP5WVFiLArIS93wJMvZoJPcHTlaOQpEAjlDSU0WRFsjR4lsqt43efUpVVbmaBR0sGv3fI+5E0t2gSgBgL/l+uwMQF1MxLRgmeV8JiuBAAV1k1/AgMBwr0RkZOXE5OhslbpcwB4RFMduFGLqzzRAEmdNJk9HP6bDdhRC8Hq+hlk1QOj3DDm7uKPuOHs8Kz4lnZ7oEVVu2Pleafmroav3Y+Ad8gmiZ0pZJKUmKSRcI7eQVeDZCEKriOJYE3pQzXy7Jev26IHMiGVvv1OF9dgzcRHcWNDIrw2ySwx/9oF44BvXGj7C/p4uzjSmP7u4FpkGOXX2bwMIrQGjKkNXhlvE8VCxTvQ922rAeMpANNYETQRHPPkCtOiD6o/bUEvFUeaTaKGoqKiV7n3dPzzTGFsX4VB54w115BLQzI6Dcsx8NFM2VQhzl967gmRJepAYK8F9gE1hAGnBn3jtRFgQw+oXEZQLFV1iPLcGht8t8+lg8DWOkSnhv+j1ufExykFRFEr6KqiQY16OnbSgE3OfpJFne8RanQbqqgmgdsA1Mbo10t7+SoHZ4TvKs/pmLXHBwoxDQnS9YL+hVY5jDDlUkHs2AObjPJikyMTDWXXLiguOuu1mm5NjkFoCU3zZvjmXuGYGw4qrxb9XM5O0hlHOwWD8t46OVAwHfIcXU1KRJLXR6OtlyAix+VasS97m/PibN4x7Y5kpjg0Bl75Kl4GjgaD6Ht
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(366004)(39850400004)(451199018)(8936002)(7416002)(5660300002)(71200400001)(91956017)(2906002)(66946007)(66476007)(66556008)(66446008)(76116006)(64756008)(4326008)(6916009)(8676002)(54906003)(478600001)(316002)(966005)(6486002)(41300700001)(85182001)(66574015)(6506007)(6512007)(186003)(26005)(2616005)(122000001)(86362001)(36756003)(83380400001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnM1VTlmTWtLcHVHRkROMUd2M1pkYWFyS1NsY0tGcGJUSmZRcm9aQ3Y0RFJh?=
 =?utf-8?B?aUtvMVo5emtiRFZ3NDRwQ01CY3ZsdHlHVFU5b2trbFo1UmRlUXVGWHNlZWlE?=
 =?utf-8?B?cnNYTWw0SWtPS2psZDRDUmUyYkNoMnlnSC80ZzlKbTFzaFB5Y1pOL3pYL1Br?=
 =?utf-8?B?VnMzV3BBeWRvU0hDM25ZQUR0ck1QVXRHYnBaZGlYcEZCTUtJTERFQ1ZTWGtv?=
 =?utf-8?B?VlZDUksvclJSWHJuUStoY2xiektYb1dvaVdsMlV2S0RvYitNUlFkM2JkYXdO?=
 =?utf-8?B?ZE43T2FkRkx1TEJuYkZaQ0JRVDJiMjdTVlJ1c0FBS2RxNDBQdEo0QmVQTUNL?=
 =?utf-8?B?TVM3LzdVbTVVVGpockE5Nk1uSjJyVCt6ZUlNWkt0TzBwQW9hcC9mV1pYYWpv?=
 =?utf-8?B?a21SUDQvd3VJM1YrMlpMeE1NNmw1QUJYM1JrcXplYmU3eHNkaFhyNXhiU2s0?=
 =?utf-8?B?cjlPWEo4L0JOSFptWjJOaGVnZ20yQW5WWlh1MFBLZm1ZWHRPNldvMElDVjBm?=
 =?utf-8?B?bENLa0JBVzUyTlkrbTF5OWRiaVg3eENtcTgrUU5DUUZSRUVUdFBxbk5lamlN?=
 =?utf-8?B?anpzYWw1SUxYb1ZLSWw0aHhYcmRPcTB4cS9sejBHMkhSMTlsWWpqdlZBTGhy?=
 =?utf-8?B?aGZ3ZFhLS0VueHEzRXJQRU5WSC9zZ1RQTmpNMkpZWWticzZBNkpMWEhzdXVO?=
 =?utf-8?B?dDBtV2tRMDJTMFRhZHRrSTVBUGduSFdqQzdCZDlWdmg5WHJMdmtJNlhycFVz?=
 =?utf-8?B?Wm5laXY0WkVPS3ZSY1JVdUFaaDN0cllyZFJRZ0YyNHZ5QldCZ2hOQytIUENE?=
 =?utf-8?B?aEY0blh2Q3l0MHlad3V3UTNuYm1RVUIxaVlHUUJWWXQ0djNwS3JMdkFwYmxk?=
 =?utf-8?B?SGVQVGF4RGNwK0lsY1VLQmdvOG5jMnNNR3FwbnhVNWtzWlhPMjRPRHJ4YVFa?=
 =?utf-8?B?eWR4cjlBSWNzRzQ5dFRyeVdvd2RnR01OazJxUHBsRTQ0UE82OW0vU1o4S200?=
 =?utf-8?B?WkxjZFFGRVVIVjlsSC9yNnUycEJ1aldXa25pYmFxc3ZzTjVUUVY1TS92UzVk?=
 =?utf-8?B?RjVUUUhCM2daTHhQeWpuVzVGT2ZIcjZZMGFENnlycG1mZ2JxakVLaElCb00z?=
 =?utf-8?B?YzRwak91NE9Gd1hRT0xBSHBsdVdvb2N6VGNTQ2YrUWU3OU1INHhDTXNSbWEv?=
 =?utf-8?B?Vzdlck1KcDl4alR1WnNVbjVUZG1jUTRnS1hHYUdBdWhMcHlmZ0xzYno1bU9D?=
 =?utf-8?B?cVdXVmVzRGkwTUxXU05EQ0lOYnJncGdDSnpEalZwUGQ5ZTZBamRELzR5a3Mr?=
 =?utf-8?B?VTlJMEg5Z0hPa3ZpRzNCemR2ckhtdEpZYlVtZU1aTFZyT1cwdnNCcW16aDU2?=
 =?utf-8?B?OFFzT0hoaVkwY25Rc04vcUhobGZlclQxMUN1QUczcUlhdFRTaUlEWk0wQ2o0?=
 =?utf-8?B?YmhJYzNPblhUcnF6bnY0ZjF1VVZzQ0xsSldSRStmLzNIRUtzdHpwd0ZMZy81?=
 =?utf-8?B?L3dOazlIS2RIMFhKYTR6NEorSEl0bllOb3VPamNaRmdVcTVMVG5ydm54S1Rs?=
 =?utf-8?B?alY5QlFoNFpUeFUvYVRVTEYzbWZTMS9WR01IVll3enJCa01ZQXZMVmxsQ1dD?=
 =?utf-8?B?czFXSW1GT05VWXNGTzQvZnhKSGtWamhLU2tJVzlQZ1RHY2hieFF3cndjblY5?=
 =?utf-8?B?YzA3TytQMTBFa0xZTTZvdGxnM2hvZjRQQXB1aldpTnNDczN5aHRqaXJ0RUV5?=
 =?utf-8?B?a0xFSWpHdW4zWStwOHExbk9FK2twcStGV3B5RFlwSVI3b3IydkJTa2FWWmNE?=
 =?utf-8?B?YXpzWlNzMzNBYnkwekgyb1UvUWRNSmVRY01NVzMwNVpmYVJTVENBekdYMlUr?=
 =?utf-8?B?UUVrM3Ywck1uNVcwajRJS1gzQVowWTFxbHBldFhzSGNnRUJpSjRiYzRhZEtK?=
 =?utf-8?B?WHBkTit1WnFHRDdyRSt2b045d0d0QzNiMDFGcGhMNFZLTk5BNjg2cG5TQnBL?=
 =?utf-8?B?VFRlQjhrdDZJS1dVT00zak1ndXNoMzc5Zzl4V2NiT0lwTDZrdHpjYVdrNWJU?=
 =?utf-8?B?VUIvaDdGL3l0RmhSRFArbnZEekVOQVU4dGh4VTJlMmpBcVRmUlMwTFN0UEZV?=
 =?utf-8?B?amxRQ1hIbWpVRnpPUUE5UWFpcERPRE9NYTdHeEUweVpEempJbktJNlN4STYx?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E0E2A77CC11FE4BA910B1F0A007AF70@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956aa791-fcf1-4497-d44b-08db1868baa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 02:17:08.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vn3FygrPSHIur1ZqWD9qZNtAVkJIsrr4SV3H3VZObahvkwDfAhPeqmjmMB2pk1+hvTqALDP1m/OA+aKifUYhBhQk6GDIwfTCUOJR5kRii38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7002
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBXZWQsIDIwMjMt
MDItMjIgYXQgMTY6MTEgLTA1MDAsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IE9uIFR1ZSwgRmViIDE0LCAyMDIzIGF0IDAyOjI4OjA0QU0gKzAwMDAsIFl1bmZl
aSBEb25nICjokaPkupHpo54pIHdyb3RlOg0KPiA+IEhpIE5pY29sYXMsDQo+ID4gDQo+ID4gVGhh
bmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQo+ID4gT24gRnJpLCAyMDIzLTAyLTEwIGF0IDEwOjM2
IC0wNTAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOg0KPiA+ID4gTGUgdmVuZHJlZGkgMTAgZsOp
dnJpZXIgMjAyMyDDoCAxMzo1NSArMDgwMCwgWXVuZmVpIERvbmcgYSDDqWNyaXQgOg0KPiA+ID4g
PiBJbiBvcmRlciB0byBjb252ZXIgdGhlIGZvcm1hdCBvZiBjYXB0dXJlIHF1ZXVlIGZyb20gbWVk
aWF0ZWsNCj4gPiA+ID4gTU0yMQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiBzdGFuZGFyZCB5dXY0MjAg
d2l0aCBMaWJ5dXYsIG5lZWQgdG8gZm9yY2UgY2FwdHVyZSBxdWV1ZSBmb3JtYXQNCj4gPiA+ID4g
dG8NCj4gPiA+ID4gTU0yMSBmb3IgTGlieXV2IGNhbid0IGNvdmVydCBtZWRpYXRlayBNVDIxIGZv
cm1hdCBhdCBjdXJyZW50DQo+ID4gPiA+IHBlcmlvZC4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIHJl
d29yayB0aGlzIHRleHQsIGl0IGlzIGhhcmQgdG8gdW5kZXJzdGFuZC4NCj4gPiA+IA0KPiA+IA0K
PiA+IFdpbGwgcmUtd3JpdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIG5leHQgdmVyc2lvbiBhcyBi
ZWxvdywgY291bGQNCj4gPiB5b3UNCj4gPiBwbGVhc2UgaGVscCB0byByZXZpZXcgd2hldGhlciBp
dCdzIHdlbGwgdG8gYmUgdXNlZCA/DQo+ID4gDQo+ID4gTGlieXV2IGlzIG9uZSBzb2Z0d2FyZSBs
aWJyYXJ5IHVzZWQgdG8gY292ZXJ0IGZvcm1hdC4gT25seSBjb3ZlcnQNCj4gPiBtZWRpYXRlayBN
TTIxIHRvIHN0YW5kYXJkIHl1djQyMCBmb3IgTVQyMSBpcyBjb21wcmVzc2VkIG1vZGUgYW5kDQo+
ID4gTU0yMQ0KPiA+IGlzIHVuY29tcHJlc3NlZCBtb2RlIGF0IGN1cnJlbnQgcGVyaW9kLiBOZWVk
IHRvIHNldCBjYXB0dXJlIHF1ZXVlDQo+ID4gZm9ybWF0IHRvIE1NMjEgaW4gb3JkZXIgdG8gdXNl
IExpYnl1di4NCj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVzOiA3NTAxZWRlZjZiMWYgKCJt
ZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogRGlmZmVyZW50IGNvZGVjDQo+ID4gPiA+IHVzaW5nIGRp
ZmZlcmVudCBjYXB0dXJlIGZvcm1hdCIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBE
b25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBjaGFu
Z2VkIHdpdGggdjE6DQo+ID4gPiA+IC0gYWRkIEZpeGVzIHRhZy4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2Rl
Yy5jIHwgNA0KPiA+ID4gPiArKy0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNf
ZGVjLmMNCj4gPiA+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9t
dGtfdmNvZGVjX2RlYy5jDQo+ID4gPiA+IGluZGV4IDY0MWY1MzNjNDE3Zi4uNGY1ZTljMjAyMTRm
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiA+ID4gQEAgLTQxLDcgKzQx
LDcgQEAgc3RhdGljIGJvb2wgbXRrX3ZkZWNfZ2V0X2NhcF9mbXQoc3RydWN0DQo+ID4gPiA+IG10
a192Y29kZWNfY3R4ICpjdHgsIGludCBmb3JtYXRfaW5kZXgpDQo+ID4gPiA+ICAJY29uc3Qgc3Ry
dWN0IG10a192aWRlb19mbXQgKmZtdDsNCj4gPiA+ID4gIAlzdHJ1Y3QgbXRrX3FfZGF0YSAqcV9k
YXRhOw0KPiA+ID4gPiAgCWludCBudW1fZnJhbWVfY291bnQgPSAwLCBpOw0KPiA+ID4gPiAtCWJv
b2wgcmV0ID0gdHJ1ZTsNCj4gPiA+ID4gKwlib29sIHJldCA9IGZhbHNlOw0KPiANCj4gVGhpcyBj
aGFuZ2UgZG9lc24ndCBkbyBhbnl0aGluZywgc28gSSdkIGRyb3AgaXQuDQo+IA0KVGhpcyBjaGFu
Z2UgaXMgdXNlZnVsIHdoZW4gY2FwdHVyZSBmb3VyY2MgaXMgTVQyMSB3aWxsIHJldHVybiBmYWxz
ZSwNCm5vdCBzdXBwb3J0IGV2ZW4gaWYgc2NwIHN1cHBvcnQgbW0yMSBhbmQgbXQyMS4NCj4gPiA+
ID4gIA0KPiA+ID4gPiAgCWZvciAoaSA9IDA7IGkgPCAqZGVjX3BkYXRhLT5udW1fZm9ybWF0czsg
aSsrKSB7DQo+ID4gPiA+ICAJCWlmIChkZWNfcGRhdGEtPnZkZWNfZm9ybWF0c1tpXS50eXBlICE9
DQo+ID4gPiA+IE1US19GTVRfRlJBTUUpDQo+ID4gPiA+IEBAIC02Myw3ICs2Myw3IEBAIHN0YXRp
YyBib29sIG10a192ZGVjX2dldF9jYXBfZm10KHN0cnVjdA0KPiA+ID4gPiBtdGtfdmNvZGVjX2N0
eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0KPiA+ID4gPiAgCWNhc2UgVjRMMl9QSVhfRk1UX0gy
NjRfU0xJQ0U6DQo+ID4gPiA+ICAJY2FzZSBWNEwyX1BJWF9GTVRfVlA5X0ZSQU1FOg0KPiA+ID4g
PiAgCQlpZiAoZm10LT5mb3VyY2MgPT0gVjRMMl9QSVhfRk1UX01NMjEpDQo+ID4gPiA+IC0JCQly
ZXQgPSBmYWxzZTsNCj4gPiA+ID4gKwkJCXJldCA9IHRydWU7DQo+ID4gPiANCj4gPiA+IFRoaXMg
bWFrZXMgdGhlIFZQOCBhbmQgdGhlIG90aGVyIGNhc2VzIGlkZW50aWNhbCwgbGVhdmluZw0KPiA+
ID4gYW55dGhpbmcNCj4gPiA+IHRoYXQgdG91Y2hlcw0KPiA+ID4gTVQyMSBhcyBkZWFkIGNvZGUu
IEknbSBub3Qgc3VyZSwgY2F1c2UgSSBjYW5ub3QgdGVzdCBpdCwgYnV0IGl0DQo+ID4gPiBzaG91
bGQgaW4gdGhlb3J5DQo+ID4gPiByZW5kZXIgTVQ4MTkyIHVudXNhYmxlLCB1bmxlc3MgYSBuZXcg
ZmlybXdhcmUgaGFzIGJlZW4gc3VibWl0dGVkDQo+ID4gPiB0bw0KPiA+ID4gbGludXgtDQo+ID4g
PiBmaXJtd2FyZSB3aXRoIE1NMjEgc3VwcG9ydCA/DQo+ID4gPiANCj4gPiANCj4gPiBJZiB0aGUg
ZmlybXdhcmUgb25seSBzdXBwb3J0IE1UMjEgPT4gd29uJ3QgZXhpc3QgZm9yIHZwOCBuZWVkIHRv
DQo+ID4gdXNlDQo+ID4gTU0yMS4NCj4gDQo+IEFuZCB0aGF0J3MgdGhlIGlzc3VlLCB0aGUgc2Nw
LmltZyBmb3IgTVQ4MTkyIG9uIGxpbnV4LWZpcm13YXJlIG9ubHkNCj4gc3VwcG9ydHMNCj4gTVQy
MSBbMV0uIENhbiB5b3UgcGxlYXNlIHVwZGF0ZSBpdCB0byBzdXBwb3J0IGJvdGggTU0yMSBhbmQg
TVQyMT8NCj4gDQo+IEZvciBNVDgxOTUsIG9ubHkgTU0yMSBpcyBzdXBwb3J0ZWQgaW4gc2NwLmlt
ZyBbMl0sIGJ1dCBzaW5jZSB0aGUNCj4gaGFyZHdhcmUNCj4gc3VwcG9ydHMgYm90aCBNTTIxIGFu
ZCBNVDIxLCB0aGUgZmlybXdhcmUgc2hvdWxkIGFsc28gc3VwcG9ydCBib3RoLg0KPiBTbyBwbGVh
c2UNCj4gYWxzbyB1cGRhdGUgaXQgb24gbGludXgtZmlybXdhcmUuDQo+IA0KPiBbMV0gDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExMjIwNDYyNi5jaWFmZjRhbXNlb2lkeWJ3
QG5vdGFwaWFuby8NCj4gWzJdIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAx
MTIyMDU4MjUud2I1cWNxaGg1a3d2eWkzeUBub3RhcGlhbm8vDQo+IA0KPiBUaGFua3MsDQo+IE7D
rWNvbGFzDQo+IA0KTVQ4MTkyIGFsd2F5cyB1c2UgTU0yMSBmcm9tIHRoZSBiZWdpbm5pbmcsIE1U
MjEgaGF2ZSBub3QgYmVlbiBlbmFibGVkLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0K
PiA+IA0KPiA+IElmIHRoZSBmaXJtd2FyZSBvbmx5IHN1cHBvcnQgTU0yMSwgd2lsbCB1c2luZyBN
TTIxLg0KPiA+IElmIHRoZSBmaXJtd2FyZSBzdXBwb3J0IE1UMjEgJiBNTTIxLCB3aWxsIGZvcmNl
IFZQOCB0byB1c2UgTU0yMSwNCj4gPiBIMjY0L1ZQOS9BVjEgd2lsbCB1c2UgTVQyMSBiZWZvcmUg
dGhpcyBjaGFuZ2UuIA0KPiA+IA0KPiA+IFdpbGwgZm9yY2UgYWxsIGRyaXZlciB0byB1c2UgTU0y
MSBhZnRlciBhZGRpbmcgdGhpcyBjaGFuZ2UuIA0KPiA+IA0KPiA+IEJlc3QgUmVnYXJkcywNCj4g
PiBZdW5mZWkgRG9uZw0KPiA+ID4gPiAgCQlicmVhazsNCj4gPiA+ID4gIAlkZWZhdWx0Og0KPiA+
ID4gPiAgCQlyZXQgPSB0cnVlOw0KPiA+ID4gDQo+ID4gPiANCg==
