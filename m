Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE29B7432BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF3C1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjF3C1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:27:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B6199B;
        Thu, 29 Jun 2023 19:27:04 -0700 (PDT)
X-UUID: 924e7fb016ed11eeb20a276fd37b9834-20230630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4oJff4YBIutlXVHNffqEgCwAsd8nPihxQHjDfQT2OhA=;
        b=p63DRc5OpqEm3JfTgvrWihDlEFB+o/oIACAiJlbZ5krcWybz5qRxj7O2NmY5bE6BWgPJLRhS4Zfte/GAgRB72WXRY8irkVVZKFYvzped5DPKzSEkHXUCFFq8qYNFRdRPxaTQMgizvwZGNoEfKUff/KgWiTvNLOMDir+58sV+lRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:907c158b-f3f6-47dc-a1fe-28ce317fcbab,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:01c9525,CLOUDID:710b660d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 924e7fb016ed11eeb20a276fd37b9834-20230630
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1876066528; Fri, 30 Jun 2023 10:26:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Jun 2023 10:26:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Jun 2023 10:26:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AED5XlLlwChGCar5gdc+tAIHzFKBLSEMiVWg+2Inv8VBgrLXSzHtmItyundSLB3syDzaedPfVdnlUh/HzjkyvRW6ihyKbKByZlPNDVeWfxSEu/E2S7VjBrfMuLfSIHaD73UNW95KQ+x+pU30ERq1bL2YAdJuoIYgfwe9ZcELmnklflj7PrZJejyoLFNCddTUqwio3ZJxd8/eg5R7hgYX5miluJzGPCBBhmtl89YQhlOp5UOQFhn2Mro9OwPSdPqKfKYdu9VZxAQbukJYxpHvcCVyTUOhi3P7UWpgh/KhMGkO9QobuHQFeQuHhJdAjIMvMKqpRmTc6+4/c+zOrF6+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oJff4YBIutlXVHNffqEgCwAsd8nPihxQHjDfQT2OhA=;
 b=VpW9uAM/0EPk4sku+Zkm+NeW4HYLsZphxfbrTcjRWPGmvFvNcoVd0kVsyv+JLOAE1FlarXXcpRn+r8DZ49wOI07vwp1ssfYYCXb7O11upRBVuYZH0Wz05F28ySvbfCT1im82RjZbB257nthz6WD5tUClF0l6GCYEFVlAf0Zx4HRSRDqJqVgg4WR1TlBsWLB4bMx9+MPuT92V0c4RiQ1eFPqrJePP8REvVQMMhYFqwMj26tQ+r5YbH0V1r1Fplq7kHJ/4aVoN3c5taE3XYfzA/1C3yqjpD03dQiEPA+X0y9w/VCXg75jWiJc7y1Qqb3r26CV/4XoOgIOUO8oT0hZw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oJff4YBIutlXVHNffqEgCwAsd8nPihxQHjDfQT2OhA=;
 b=PJwkH3VHunnpi8843+uv/+qTuWLLPIs9qAsv+e8tSbg1GDa6b45Xmpv3iLnWYWXVG+IeyoA9Fpv6OYXpsJGQoLK5at6XbbZr7OQ6ZwVcImo8a/E3pzR2sn9oAgk1Esoj7e7sSgNC6mhH1WaXwJ0E6wvJ5P9PMCdHiTgMXcdT3e4=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SI2PR03MB5674.apcprd03.prod.outlook.com (2603:1096:4:155::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 02:26:48 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 02:26:47 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Topic: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Index: AQHZp9cRysZKG5rRk06LcJsGEM1rPK+h5pkAgAC+W4A=
Date:   Fri, 30 Jun 2023 02:26:47 +0000
Message-ID: <864c525d8daa088e294018d0889cff6262218c72.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-8-maso.huang@mediatek.com>
         <20230629150528.GA2961718-robh@kernel.org>
In-Reply-To: <20230629150528.GA2961718-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SI2PR03MB5674:EE_
x-ms-office365-filtering-correlation-id: c0ea8d14-9d15-43ff-68da-08db79117476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cadI1yz3GNuNi+GGHx6v2JMAKCmPrN/5D/miMS3FjJMYz87uKJ8+dRd9YqcU0YKne4wCH14HWAyhEfu+KbIp1YPnZZw9WP2+igHo0/WED7ghJJS/uL2yFHe6O0TfEmdnNr+gPpXXOn98tXm/MGVgxDaq46YQiOl5NWmzQ5n9EAUQRLnGbVxCV5vhZqSg3fZMuHynCCW7kGsZHbbZmvJKHogpUGmshREeY0TRgNIuO0JkU78hLjFHGC07CBWDKNxtL8VwfqSauylptr83ymNdWwO8GeP3N0xYJdD4NPCa7YlleNhNOeAV1ClUvS6/MxMun9QtjJP64VYmw9WIyz4lAsG6XbY77EZ33ZK/NN6qMWktaWzA1TSUvVzXlkQCwB2JAr//0X7Xh+ja/Z5+XQPnPiiAqhcPvYiqtDFm+RMcMV8swFF3VX+crCvS2KWFyV5EHV7x7wCP8+686ckIyMGvGFM8+dxtSHvgqFwoCF3U7OgUqnwt71vitNe5qtRuc/V5DtWpFGoaedjM/CTpTIvrxS+crgvh40uCMD/t3cOkU68umAAi4Q/dCUNP0JefQBKwQiw1lXcUqsxRpvcRjKnU8Ggm+Rw8QchyxbiRm0gpWuE8ILCbXV7T6HzgdckDGVJ1lOzw6y748aTq0iaKNFAOAH0vq1dck8J1b4VJbf3Fgz2bqnp5IoI/mdpnLoRvmL5z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(66446008)(5660300002)(66476007)(26005)(2906002)(186003)(71200400001)(38070700005)(38100700002)(122000001)(2616005)(6506007)(6512007)(8936002)(83380400001)(41300700001)(91956017)(66946007)(66556008)(64756008)(7416002)(85182001)(36756003)(966005)(6486002)(478600001)(54906003)(8676002)(86362001)(4326008)(6916009)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFcxWXcrTm9DQTdFTFNSd2xGTTJQZDhXVWZncEdObzdPNG81Sy9XYzdSYUFo?=
 =?utf-8?B?WWhJamowMFVoUTViQ0NUK2hpZVNaKzBUSHhkTlJXUHUyTFM0dUo3bDhjYjVr?=
 =?utf-8?B?WUVNQVAwa0VjZU5zRTJ2L3VIcnlpOURTWTJtV1RKRDVjdXhRVjRTY09IdFZp?=
 =?utf-8?B?NTlnRWpaWFoxMmpaMjhVT3Q0eFZlNEZYR3VUQkEvOHZTaE5IREhDZXBOcTRC?=
 =?utf-8?B?ai9ua1QrcDVYTHhGUUNKclJsKzZUU2RKREhDc1M4Q3JQVjBEOUVibGxWM2la?=
 =?utf-8?B?TkloRm95ODEzNTFSRWtENjNBNTVWSW1vbW5NQU5xek9SSUovWjA3elFGL0J2?=
 =?utf-8?B?Ykl3TzJ0TjBjMW4zdS9nVE54aUp0VHN0ZFU4QllKZlhZU0VPRXBXUnVuR0N2?=
 =?utf-8?B?L1FKRmdreUFmdktVR3U1eUJzQmZsc25DOXFDWlREYUsvNEZrd1BaaVgwd3E2?=
 =?utf-8?B?d1Q2SDRVaDFLalUrQklkTWhkc0pGL1JTeVBsZTIxc0RQT0ZqWCtuR3h4YVhJ?=
 =?utf-8?B?WmZVTVlaWGZFRzI3K3owd3d2WTdBbTN1OHUyUFNBS21UR01jdmJ6NFNvZThT?=
 =?utf-8?B?WHRFS2F3VGZwelBXVkk5MDBzT2pOWTE5VTNVa1ZxYmRkRkNMSEhFT1BCVnVF?=
 =?utf-8?B?NkU3V1JrMTEwekUrVUZlTWFYSjNHamtDbXJTRGJHZkpacVd3SjgxSGxkaTN0?=
 =?utf-8?B?Y292WnprL0ZVOXFkRXp5Tlc0TllUcnZLMzNJRGxEdENxYkFzM1JHOEZXRzVq?=
 =?utf-8?B?TXZUS1EwUlc5L0RLSUk2MTJDczRybm56Yng1U2M2ZnJ6bE5VYUFWYlVmOThl?=
 =?utf-8?B?ZDltQUVqQ0Z4Z2E1R1FYRXBxZDNEN0l1cTAwcGo5cWRnQnFhMEZFc1JvNGV2?=
 =?utf-8?B?UytneXNPMUpEakk5Wjg1ZENIVnhCN05uQ3FTMGVDY0JFeVo0ME1DWWpzZFc5?=
 =?utf-8?B?Tk9LdUVkS2lkU3RSYURsWjhTR3BlOWFZa2NSdE5mUG1RMjJmdW12UllCTy9j?=
 =?utf-8?B?VVRwUzZIQ2VxSmpMZGp4bStENVE3ZGlDNkk5SWVLdUE4ZXpoWUZmTFNsRXVW?=
 =?utf-8?B?UWdxblNKL3Q2Y1ZPZVE0YnkvaXdWd2xKbjltQ0xxSTNQUmhwcjZWU2hnR0Qw?=
 =?utf-8?B?WE5rTmxYYjQ2di9hWVI5aWt5UmJhdFdERHhCNkE4OC9SVnluVkdMTGRyd0Nh?=
 =?utf-8?B?b2tYRFBkZEUySWZDR2U1MkJPVHBpR0wxK3oxQmlCL2lKRW8wbHJvOElsNEVN?=
 =?utf-8?B?Y3NQT3QwTkZPMUNZTEIzY05NbGtuNjBHakhGMmtlWE9BRmtJR2dSL0tFMlA1?=
 =?utf-8?B?TzVEbENQQllUd2d3NTdVejVQMzB0ZWxXc05VSEIyaldxWjJRTXhxOERqTEZy?=
 =?utf-8?B?cDNlTlBWTERRU0thTzJEQUNva202R0owWVZQc24yM3VQT3dsT2pnbnJqdzRK?=
 =?utf-8?B?cU5mSkphSUM5bm0rYm40eWxlb0JYVVYzOXVqeG1YeVkrZWZJZytZemNCRVdt?=
 =?utf-8?B?Rk5YZTRDUUEwMzRNaFNiMzZndjZRNDJJOTRnTkExOFdnRVpBYXd2Rjg2bzN4?=
 =?utf-8?B?SExFTlFWSDVBeHJYOVBUalYzbDBwQ3JscjVuWjJyUlo0QkczalV4bDNySVI0?=
 =?utf-8?B?SW5SeTcrMEtoL0dVUFVMa1pIRHoxam5Kd3MxWXNjNGM4aXBRKzNBWCt0dko5?=
 =?utf-8?B?alh0aU1uRCt4aUF3MkQ5M00wTWM2eFN0M0oxbjhMd3N3VVIvMnAwK3cyK1dF?=
 =?utf-8?B?cFZkUHBzSzhKQTg0RDZYRE1oOTNBOEN4R1AwNjVCZDlDRktJeElFak9pQ2Q5?=
 =?utf-8?B?NCtQNkhjVnFZNlk2MFYrQnJlOU5RdEtaSUl1WU5JMjU3MTFSbGIxREtlSis3?=
 =?utf-8?B?Vis5Z2UwZVdCcU5Dc2syTkFqZWFQalV5WHRreVVHR3g4YXhKYlRuc2I4Nk95?=
 =?utf-8?B?cHdFc21Uc2drVHJER29wLzlnajd3blR6M1dXVTdkS0FrWjNoQ2VZaThPWGJF?=
 =?utf-8?B?Tk5yZ3g5Y1FTT3JrbnFiWWI5TlZ4bmpQUXkzLzZzMW1DVTBhQnU5Rkwrc1Rl?=
 =?utf-8?B?WEtiTzQxb080amxreFpkRFlMM2hPNStsMStLZDdYTnQ3bjV6NEN2WElGbkZT?=
 =?utf-8?B?YlNwNzFyaGdFUFhaNjVtYVV3WUR4cEZxSkN3UEpNNUorTnpaNGozUFRFWGNz?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D89B26D5B1EF243921092E26F760626@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea8d14-9d15-43ff-68da-08db79117476
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 02:26:47.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVNoJkKrmZgZFGVyEu0AXv1R2+I7MR02RFhOcI172PQJPSaAAAR5qnOe9V/J8Lct50wuXrGA8yv/JcpIo2R1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5674
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDA5OjA1IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBNb24sIEp1biAyNiwgMjAyMyBhdCAxMDozNTowMUFNICswODAwLCBN
YXNvIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBtdDc5ODYgYXVkaW8gYWZlIGRvY3VtZW50Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LWFmZS55
YW1sICAgfCA4OQ0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4
OSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LWFmZS55YW1sDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tZWRpYXRlayxtdDc5ODYtYWZlLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LWFmZS55YW1sDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI1NzMyN2EzM2VhMQ0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbWVkaWF0ZWssbXQ3OTg2LQ0KPiBhZmUueWFtbA0KPiA+IEBAIC0wLDAgKzEsODkgQEAN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtYWZlLnlhbWwjDQo+ID4gKyRz
Y2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+
ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIEFGRSBQQ00gY29udHJvbGxlciBmb3IgTVQ3OTg2DQo+
ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIE1hc28gSHVhbmcgPG1hc28uaHVhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxl
Og0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Nzk4Ni1h
ZmUNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAg
ICAgICAgICAgICAtIG1lZGlhdGVrLG10Nzk4MS1hZmUNCj4gPiArICAgICAgICAgICAgICAtIG1l
ZGlhdGVrLG10Nzk4OC1hZmUNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Nzk4
Ni1hZmUNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+
ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNs
b2NrczoNCj4gPiArICAgIG1pbkl0ZW1zOiA1DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogYXVkaW8gYnVzIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246
IGF1ZGlvIDI2TSBjbG9jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBpbnRidXMg
Y2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gaG9wcGluZyBjbG9jaw0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBwbGwgY2xvY2sNCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogbXV4IGZvciBwY21fbWNrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlv
IGkycy9wY20gbWNrDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgbWluSXRl
bXM6IDUNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBhdWRfYnVzX2NrDQo+
ID4gKyAgICAgIC0gY29uc3Q6IGF1ZF8yNm1fY2sNCj4gPiArICAgICAgLSBjb25zdDogYXVkX2xf
Y2sNCj4gPiArICAgICAgLSBjb25zdDogYXVkX2F1ZF9jaw0KPiA+ICsgICAgICAtIGNvbnN0OiBh
dWRfZWcyX2NrDQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1ZF9zZWwNCj4gPiArICAgICAgLSBjb25z
dDogYXVkX2kyc19tDQo+IA0KPiAnYXVkXycgaXMgcmVkdW5kYW50Lg0KPiANCg0KSGkgUm9iLA0K
DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpJJ2xsIHJlZmluZSBhcyBiZWxvdyBpbiB2MyBw
YXRjaC4NCml0ZW1zOg0KIC0gY29uc3Q6IGJ1c19jaw0KIC0gY29uc3Q6IDI2bV9jaw0KIC0gY29u
c3Q6IGxfY2sNCiAtIGNvbnN0OiBhdWRfY2sNCiAtIGNvbnN0OiBlZzJfY2sNCiAtIGNvbnN0OiBz
ZWwNCiAtIGNvbnN0OiBpMnNfbQ0KDQpBbmQgbW9kaWZ5IGV4YW1wbGUgYXMgd2VsbC4NCg0KQmVz
dCByZWdhcmRzLA0KTWFzbw0KDQoNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29t
cGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9j
a3MNCj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBhc3NpZ25lZC1jbG9ja3MNCj4gPiAr
ICAtIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0
aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+
ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0K
PiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210Nzk4Ni1jbGsuaD4NCj4gPiAr
DQo+ID4gKyAgICBhZmVAMTEyMTAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ3OTg2LWFmZSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTEyMTAwMDAgMHg5MDAw
PjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA2IElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FV
RF9CVVNfQ0s+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJB
X0FVRF8yNk1fQ0s+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmdfYW8gQ0xLX0lO
RlJBX0FVRF9MX0NLPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JmluZnJhY2ZnX2FvIENMS19J
TkZSQV9BVURfQVVEX0NLPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JmluZnJhY2ZnX2FvIENM
S19JTkZSQV9BVURfRUcyX0NLPjsNCj4gPiArICAgICAgICBjbG9jay1uYW1lcyA9ICJhdWRfYnVz
X2NrIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJhdWRfMjZtX2NrIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICJhdWRfbF9jayIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAiYXVkX2F1ZF9jayIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiYXVkX2VnMl9jayI7
DQo+ID4gKyAgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX0ExU1lT
X1NFTD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9Q
X0FVRF9MX1NFTD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBD
TEtfVE9QX0FfVFVORVJfU0VMPjsNCj4gPiArICAgICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRz
ID0gPCZ0b3Bja2dlbiBDTEtfVE9QX0FQTEwyX0Q0PiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX0FQTEwyPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9QX0FQTEwyX0Q0
PjsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsuLi4NCj4gPiAtLSANCj4gPiAyLjE4LjANCj4g
PiANCg==
