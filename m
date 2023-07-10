Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31E74D5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGJMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:50:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A6A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:50:02 -0700 (PDT)
X-UUID: 464c3ec81f2011ee9cb5633481061a41-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iWcr6lTA4E0b+H7haOxuCj4hAj+Q0TmDv68IS5jmtRM=;
        b=L5g03HrXGWx+HGBhiDWgNfizUCYG8BQB8CXwa0FpgpW7zBZ/lIHUbKYygVMMTFuffCKl0gAvyxWNSCQ5qrfOYuu+U6OCbtaG/Y6ArPztZF3caEOiFDKsqXestHXelD6zne77tvkCijIYd45BvdNXMZoWmaCZKCUopCtaZQVOPlQ=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:3698faa8-c6ed-462c-99b0-6d9257eb5390,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:54
X-CID-INFO: VERSION:1.1.28,REQID:3698faa8-c6ed-462c-99b0-6d9257eb5390,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:54
X-CID-META: VersionHash:176cd25,CLOUDID:670ec50d-26a8-467f-b838-f99719a9c083,B
        ulkID:2307102049573VGXKJZY,BulkQuantity:0,Recheck:0,SF:16|19|48|29|28|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 464c3ec81f2011ee9cb5633481061a41-20230710
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <john.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1820990154; Mon, 10 Jul 2023 20:49:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 20:49:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 20:49:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccyfFBdeXbCUgtDEvGx9MKQstxTszzlLDDkDmf4UgidL8OpN+RJiDTH6D8jrXf3s9hNubHTAx7SJ6jBKRgeetfZdZi6fAX42u3bDw/j8f2oZDw/0Mon1kua1NkBtCz9VkYmAk+k9mCzEjWRRz7USugo6BZgVblzR9STXFR+0AvfzUw86WQxFEnQEmS505cz0wlof2KmlXF9idjK9qc4ByxpcrWeenBJz2s8Qs8+AuhUURB9VkKXaj5dwU6VXXsHcwhcaMmxNzccesvc5oHwL8dx4a/zYU+fZPB/HRc0Gperr494cC0XG+V+CvadUO5oLYqE3X8Rdvu8e57xDzQQjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWcr6lTA4E0b+H7haOxuCj4hAj+Q0TmDv68IS5jmtRM=;
 b=Ow0VLCKU9hfmqVdeDknQvn2WShAHrd8w2p8H8gAhlZeDmj2XQbGbauoeGH3BhopDhnHTM9RjRfHfkhu/tQYsrkppVAXnbADQD1Tkw1a8fNdyceALWcSyZ9GkInIZK58qfebPrEiweTYAZgzKadb5tmi/rgeRNLvA3zPZIafSF9/NrNPqCkBg+r5hPTOyk7pkopmRVfztqFhPg1zUR7zM0q7Wd4spfZibLz35M4zMLlgCaKKMJWtMJW3pPESMxkuyHlO9sbt0+1x4MbsuQYDgPm/kMbkpWIJcyeJex2qvRWTiodrl/dczBbGlCCv+UXAeLMdb9gproas93mn13Z239w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWcr6lTA4E0b+H7haOxuCj4hAj+Q0TmDv68IS5jmtRM=;
 b=qLs1qaGlgpFX7VKdbE6/48y1DwbU3Q3oNQD/z4X5OnBbcrJayjNH8yyg/Q6vzRmgtKDCv9zEnCMp6m2HRNBWMdsbAH5S12z9MsHdoKl+c8QK7NJ+Ntv3l3oq/gSlBrisCtqofBoUnShaP5lX1CWF+EhQhXR5STqvoG+eGitRo3o=
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com (2603:1096:301:b3::11)
 by SEYPR03MB8067.apcprd03.prod.outlook.com (2603:1096:101:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 12:49:53 +0000
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::d21:7640:7279:f22a]) by PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::d21:7640:7279:f22a%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 12:49:52 +0000
From:   =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>
CC:     =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Topic: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Index: AQHZmq2hr8VIEXfZDUmuykLw57Rh9K+IzHcAgAEbhYCAAJTEAIACtPMAgCAPjwCABeNrgA==
Date:   Mon, 10 Jul 2023 12:49:52 +0000
Message-ID: <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
         <20230613141114.bwbnqsdazqbmyj3u@revolver>
         <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
         <20230614155826.cxcpv33hs763gyrg@revolver>
         <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
         <20230706185436.agobbv72o3hma43z@revolver>
In-Reply-To: <20230706185436.agobbv72o3hma43z@revolver>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5963:EE_|SEYPR03MB8067:EE_
x-ms-office365-filtering-correlation-id: 6bb3a00e-3f7c-4c88-df19-08db814427b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htNiC7W7HegWVL7bPk/3JPFghEq5fAyF89Qg9tMo2ixx5OaVhyjbWvpuG57jdrz8ENdEkhLtRkkBKrMwIaMsteRcGT/2oeZssm8QWspVyR1stG0Ajg8w8nGNTAOswXdLfGQzWDNEmHSIUCb8IlliaQq5ACLjrjWIfrhNSTAHSlOVAyt93tuKpEsG97M+K4/7a46hl60U8ckVyprfJEWMcZB1yLVFwsoCfYSypOq0usfD8///d9UtmHy34huLbIxdj17m8mujK6EWxm1mkdPNNX1fk8MH6EEAI2RVCPcgRjrLBnNMHuG3M+e+exyWcuuCQAKsfMyuuSuMk4iTzOb4S/R99/Ut8QHJx5y1hPss9hhouRuFTEcanWUZ//b+UV4HqNqhTA6N1AaNFLP3G1vx2cyRvQ+6LgKsMrbkk8nFXddr71tNzFwoMJWozIYeFZb6ZBRFgwu1IC3x1333npZicUrzkYoH4VUn7Zkzb6hdBat3BJI+dIBKJux8wiY6/QXTYGwXPWCPE6FH0AMP+v33Ok260Mx9QO0c8Nu8RHihwK0rUrFnuTniH14dhoe2Y+49HqYtpMzPq9uQxvJ1RMMQlCRxL6ZT4ImwF4RnmEkD5gqo1Zf7rtqEp4fk2Nf/XIFU4SdmHDjg+o9qgbznU2r1FZ2G1T5paNpZkDrcs+np4qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(38100700002)(38070700005)(86362001)(36756003)(85182001)(6486002)(54906003)(76116006)(71200400001)(91956017)(122000001)(26005)(6506007)(186003)(6512007)(2616005)(5660300002)(2906002)(316002)(66556008)(66946007)(66476007)(478600001)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(6916009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0l2c293TmNiUHpyZWk0aVFEeGN4NEw4REttYkdvdW55SW0vc1A1ZVVFOWtz?=
 =?utf-8?B?bE1QOHVPT3FFeFh2RlcrTlMzVVBJVVd6V2VjbytEUDVIeTZkR3dKbnhVblRn?=
 =?utf-8?B?eWhJK0lIVHAyWTIvOFp3N3U2MGtEWmRhY2ZwbUJKVFVXYUFyQWVYOVQ4VDNh?=
 =?utf-8?B?TXRqS0k4SnZESW5hSTBPK0V3VnoxSGdqNnFtMENLYXc0dXVBcVZDK1E4MEpi?=
 =?utf-8?B?bnp4eHVpNDk2cTR1N3FFQXFDUnRjL1NlREZMMm9tV2tDbjNFdjdpejJmeVZ3?=
 =?utf-8?B?c25tVHFGS0hPOXhzelhSZ2lIdU10eVRXMTVPUFU3QzBnL0RwQW5vY0g0TUM2?=
 =?utf-8?B?Y21JUkxqNGE3REtrSnVlMUJqN0pJeXFyWFlHTWI0Z2dxcU9qenBNTko1Z1VU?=
 =?utf-8?B?aUd2RVNiTzRtR1AraFYxS0cxa1dLaW9kclNJcUNWUTlySWZSVXdQd3UzeTNr?=
 =?utf-8?B?SGg2QktRVE9zdjRNbUFMSHY0b3o5MmxlNnRRVThTdUM0ODRQdFlsVTg1VWFh?=
 =?utf-8?B?M1daU2ZmM1VObHNCMnpyZHI3eExPamhWWUxwc2tOa05KM1Z2cmNzaXFEbW9a?=
 =?utf-8?B?T1RkaFFDdjUyN0hoS2NUSGhnTlI0TStjK3pJdFc5dlBlWFRtUW1HTWF2NVhU?=
 =?utf-8?B?UkdMTmxPc09tUytQMGhHbkJaSDFqQmZkS1cwdmY1SlJvbzFNa2ZKQWNCNlB6?=
 =?utf-8?B?cUxOK202SStPSzBpYVFxT1AvVkNIMGNTSTNWbTVSdncxZjZYU3hxRVRnMGVq?=
 =?utf-8?B?dkVOM0FHaEw1THBYOGxaa3ZkZUZSc2RiKy83dkxBSWtZS2cxcTdFOVAwMFU3?=
 =?utf-8?B?UDJxZVZKZEFiN05Ldkl0akVrTG9zajVlTEQxQWF2c1Zsd01OaU9kUndJZ213?=
 =?utf-8?B?Ky9oSExJYXMzZEpidHdxUmpCYm16S0lFK3p5bmh6eWZUelg2K1E2MlltVnI4?=
 =?utf-8?B?TEVGTkVCaEk4NWpneG1MOGJhRzY4TXFTQy80V1ZMRW81TlJPZTEraW00cFFK?=
 =?utf-8?B?eXcxWkVJM3NtNG5tK1laSkhMQURESEhuN2NVd2NGWlgyYVk2R1N2Q1N5STd5?=
 =?utf-8?B?NjRlZnlBcDM1Q1VTNzd3dThlNnhJR3A5a1JDS1FnSWNvS3NJNE1GQW5BbmEw?=
 =?utf-8?B?Nk5sR01pcnZNTkg1RzNLclBNa3lSZXlTTVpQeVVwWFBvWU1uMmE3SlVuRmNW?=
 =?utf-8?B?SlRGeXlMMkZ5SkVzbzV6WjMwcVZxUHMwMkdDUmNYaGswY2ZVdWs1NHM2c0Ir?=
 =?utf-8?B?WkkxcDFZMWxldHNvdmJHVVZQK1B3d09oT2xzVTNUM1JlT21zWW9YQ05jeU8y?=
 =?utf-8?B?MHAyV25zTkg5cHNUSEluUnI1QzZMejJ3YkVLK05oVjRYeW0rdWlZcGV4UEEw?=
 =?utf-8?B?NHpEQkJlNUpWYXJyNEdBdkx4UngyZWUySitzak5RYXZ1Wms5eGM4bEN1L0VE?=
 =?utf-8?B?TXYzU3BoYlJoM2JOTlM2d2JxNkEvMitBZU5MVFRJZTVkZHFRRGlJdC9JbTU3?=
 =?utf-8?B?cWVMaGI4ZDNxNktpN2t6UWxaZlVUcHF0TjM1RVVGV1ZSNDlrbmtCZkpNTDkw?=
 =?utf-8?B?dUs4bkYxRG41YjdMbzhOSDNQYkVhTkVUVCtBcDdPOUUxc1FVTFBFSENHWFBi?=
 =?utf-8?B?bkhmeG1MVzJvMXFGRGJHVWswbVl4OExQU2xCaUpFOVoxTE9xbktERVl2Uno4?=
 =?utf-8?B?Ly9iQ3UvQ2UxcVpOUFRJZkh3UTJkeHBNWFNiZXlrMmluaEk2dS84QUhNb0RU?=
 =?utf-8?B?ZXpKNG43Qlp2eFk5Y1cwODRYUHNVNE41T08wRzdRcEFkZ1BpQjZ1VllpRGpH?=
 =?utf-8?B?YTRzdGxjMjJyK1FuTy9yMkZYWFJQampUMytYTEdYNXJubUREVEkzWk0wSjhM?=
 =?utf-8?B?Q3krYjdvZm83WUQ1VzQ1SWFvc2p5RXV6VVMvS0ErQ2N3Smd2TU51QmtYbkpm?=
 =?utf-8?B?S0ZmQXJpVVRxOXBUV0V0ZFcya0ZhaFlHZ3ZscG9xRTRURkZyazhPOFR1bWdw?=
 =?utf-8?B?YkFZb1lEQ3RyRXd3eldmQkhGbWJ5eHZlVGFPWWNGWmhwcmFiYUNQYjlnbEtN?=
 =?utf-8?B?TmxtU1lnc3F4Z08waXlVQ29BUk9nNlpQQ3lueTNVMmlhVkJVSzFZUzkyOHVy?=
 =?utf-8?B?d2ZvWE1aUk1DTUVvQ2x1VHlLMGpPRWQ5ZlR5aW8zZEdSK0x1U1Ftemd2bVNS?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06B78EA40C261F40ADA15B87BAA4F8B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3a00e-3f7c-4c88-df19-08db814427b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 12:49:52.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOyq3P9fXtS5nrRsF5wXttY3FgrFIDc0XaO3f4jz1ApF/J5ffXdyJ3J9irDSIDuuAjRFu5sYQKOzgdNzpinxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTA2IGF0IDE0OjU0IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgDQo+IEFwb2xvZ2llcyBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuDQo+
IA0KPiAqIEpvaG4gSHN1ICjoqLHmsLjnv7ApIDxKb2huLkhzdUBtZWRpYXRlay5jb20+IFsyMzA2
MTYgMDU6MTldOg0KPiA+IE9uIFdlZCwgMjAyMy0wNi0xNCBhdCAxMTo1OCAtMDQwMCwgTGlhbSBS
LiBIb3dsZXR0IHdyb3RlOg0KPiA+ID4gICANCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNl
IGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4gPiB5
b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gICogSm9o
biBIc3UgKOioseawuOe/sCkgPEpvaG4uSHN1QG1lZGlhdGVrLmNvbT4gWzIzMDYxNCAwMzowNl06
DQo+ID4gPiA+IEhpIExpYW0sIHRoYW5rcyBmb3IgeW91ciByZXBseS4NCj4gPiA+IA0KPiA+ID4g
U29ycnksIHlvdXIgZW1haWwgcmVzcG9uc2Ugd2l0aCB0b3AgcG9zdGluZyBpcyBoYXJkIHRvIGZv
bGxvdyBzbw0KPiBJDQo+ID4gPiB3aWxsDQo+ID4gPiBkbyBteSBiZXN0IHRvIGFuc3dlciB5b3Vy
IHF1ZXN0aW9ucy4NCj4gPiANCj4gPiBTb3JyeSBmb3IgdGhlIHdyb25nIGZvcm1hdC4uLi4NCj4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gdmVyc2lvbiA2LjEgb3Ig
Ni4xLng/ICBXaGljaCBleGFjdCB2ZXJzaW9uIChnaXQgaWQgb3IgdmVyc2lvbg0KPiA+ID4gbnVt
YmVyKQ0KPiA+ID4gPiANCj4gPiA+ID4gT3VyIGVudmlyb25tZW50IGlzIGtlcm5lbC02LjEuMjUt
bWFpbmxpbmUtYW5kcm9pZDE0LTUtDQo+ID4gPiBnZGVhMDRiZjJjMzk4ZC4NCj4gPiA+IA0KPiA+
ID4gT2theSwgSSBjYW4gaGF2ZSBhIGxvb2sgYXQgNi4xLjI1IHRoZW4uDQo+ID4gDQo+ID4gT0ss
IHRoYW5rcy4NCj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIEJVR19PTigp
IGlzIG5lY2Vzc2FyeSBzaW5jZSB0aGlzIGZ1bmN0aW9uIHNob3VsZCBfbmV2ZXJfDQo+IHJ1bg0K
PiA+ID4gb3V0IG9mDQo+ID4gPiA+IA0KPiA+ID4gPiBtZW1vcnk7IHRoaXMgZnVuY3Rpb24gZG9l
cyBub3QgcmV0dXJuIGFuIGVycm9yIGNvZGUuDQo+ID4gPiBtYXNfcHJlYWxsb2NhdGUoKQ0KPiA+
ID4gPiANCj4gPiA+ID4gc2hvdWxkIGhhdmUgZ290dGVuIHlvdSB0aGUgbWVtb3J5IG5lY2Vzc2Fy
eSAob3IgcmV0dXJuZWQgYW4NCj4gPiA+IC1FTk9NRU0pDQo+ID4gPiA+IA0KPiA+ID4gPiBwcmlv
ciB0byB0aGUgY2FsbCB0byBtYXNfc3RvcmVfcHJlYWxsb2MoKSwgc28gdGhpcyBpcyBwcm9iYWJs
eQ0KPiBhbg0KPiA+ID4gPiANCj4gPiA+ID4gaW50ZXJuYWwgdHJlZSBwcm9ibGVtLg0KPiA+ID4g
PiANCj4gPiA+ID4gVGhlcmUgaXMgYSB0cmVlIG9wZXJhdGlvbiBiZWluZyBwZXJmb3JtZWQgaGVy
ZS4gIG1wcm90ZWN0IGlzDQo+ID4gPiBtZXJnaW5nIGENCj4gPiA+ID4gDQo+ID4gPiA+IHZtYSBi
eSB0aGUgbG9va3Mgb2YgdGhlIGNhbGwgc3RhY2suICBXaHkgZG8geW91IHRoaW5rIG5vIHRyZWUN
Cj4gPiA+IG9wZXJhdGlvbg0KPiA+ID4gPiANCj4gPiA+ID4gaXMgbmVjZXNzYXJ5Pw0KPiA+ID4g
PiANCj4gPiA+ID4gQXMgeW91IG1lbnRpb25lZCwgbWFzX3ByZWFsbG9jYXRlKCkgc2hvdWxkIGFs
bG9jYXRlIGVub3VnaA0KPiBub2RlLA0KPiA+ID4gYnV0IHRoZXJlIGlzIHN1Y2ggZnVuY3Rpb25z
IG1hc19ub2RlX2NvdW50KCkgaW4NCj4gbWFzX3N0b3JlX3ByZWFsbG9jKCkuDQo+ID4gPiA+IElu
IG1hc19ub2RlX2NvdW50KCkgY2hlY2tzIHdoZXRoZXIgdGhlICptYXMqIGhhcyBlbm91Z2ggbm9k
ZXMsDQo+IGFuZA0KPiA+ID4gYWxsb2NhdGUgbWVtb3J5IGZvciBub2RlIGlmIHRoZXJlIHdhcyBu
byBlbm91Z2ggbm9kZXMgaW4gbWFzLg0KPiA+ID4gDQo+ID4gPiBSaWdodCwgd2UgY2FsbCBtYXNf
bm9kZV9jb3VudCgpIHNvIHRoYXQgYm90aCBjb2RlIHBhdGhzIGFyZSB1c2VkDQo+IGZvcg0KPiA+
ID4gcHJlYWxsb2NhdGlvbnMgYW5kIHJlZ3VsYXIgbWFzX3N0b3JlKCkvbWFzX3N0b3JlX2dmcCgp
LiAgSXQNCj4gc2hvdWxkbid0DQo+ID4gPiB0YWtlIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHRp
bWUgdG8gdmVyaWZ5IHRoZXJlIGlzIGVub3VnaA0KPiBub2Rlcy4NCj4gPiANCj4gPiBZYXAuLi4s
IGl0IGRpZG4ndCB0YWtlIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHRpbWUgdG8gdmVyaWZ5DQo+
IHdoZXRoZXINCj4gPiB0aGVyZSBpcyBlbm91Z2ggbm9kZXMuIFRoZSBwcm9ibGVtIGlzIHdoeSB0
aGUgZmxvdyBpbg0KPiBtYXNfbm9kZV9jb3VudA0KPiA+IHdpbGwgYWxsb2Mgbm9kZXMgaWYgdGhl
cmUgd2FzIG5vIGVub3VnaCBub2RlcyBpbiBtYXM/DQo+IA0KPiBXaGF0IEkgbWVhbnQgaXMgdGhh
dCBib3RoIG1ldGhvZHMgdXNlIHRoZSBzYW1lIGNhbGwgcGF0aCBiZWNhdXNlDQo+IHRoZXJlDQo+
IGlzIG5vdCBhIHJlYXNvbiB0byBkdXBsaWNhdGUgdGhlIHBhdGguICBBZnRlciBtYXNfcHJlYWxs
b2NhdGUoKSBoYXMNCj4gYWxsb2NhdGVkIHRoZSBub2RlcyBuZWVkZWQsIHRoZSBjYWxsIHRvIGNo
ZWNrIGlmIHRoZXJlIGlzIGVub3VnaA0KPiBub2Rlcw0KPiB3aWxsIGJlIHF1aWNrLg0KDQpTbyB3
aGV0aGVyIHRoZSBwdXJwb3NlIG9mIG1hc19wcmVhbGxvY2F0ZSgpIGlzIGRlY3JlYXNpbmcgdGhl
IGxvY2sNCnJldGVudGlvbiB0aW1lPw0KDQo+ID4gDQo+ID4gPiA+IEkgdGhpbmsgdGhhdCBpZiBt
YXNfcHJlYWxsb2NhdGUoKSBhbGxvY2F0ZSBlbm91Z2ggbm9kZSwgd2h5IHdlDQo+ID4gPiBjaGVj
ayB0aGUgbm9kZSBjb3VudCBhbmQgYWxsb2NhdGUgbm9kZXMgaWYgdGhlcmUgd2FzIG5vIGVub3Vn
aA0KPiBub2Rlcw0KPiA+ID4gaW4gbWFzIGluIG1hc19ub2RlX2NvdW50KCk/DQo+ID4gPiANCj4g
PiA+IFdlIGNoZWNrIGZvciB0aGUgYWJvdmUgcmVhc29uLg0KPiA+ID4gDQo+ID4gDQo+ID4gT0su
Li4sIHRoaXMgaXMgb25lIG9mIHRoZSByb290IGNhdXNlIG9mIHRoaXMgQlVHLg0KPiANCj4gVGhl
IHJvb3QgY2F1c2UgaXMgdGhhdCB0aGVyZSB3YXMgbm90IGVub3VnaCBtZW1vcnkgZm9yIGEgc3Rv
cmUNCj4gb3BlcmF0aW9uLiAgUmVnYXJkbGVzcyBvZiBpZiB3ZSBjaGVjayB0aGUgYWxsb2NhdGlv
bnMgaW4gdGhlDQo+IG1hc19zdG9yZV9wcmVhbGxvYygpIHBhdGggb3Igbm90LCB0aGlzIHdvdWxk
IGZhaWwuICBJZiB3ZSByZW1vdmUgdGhlDQo+IGNoZWNrIGZvciBub2RlcyB3aXRoaW4gdGhpcyBw
YXRoLCB0aGVuIHdlIHdvdWxkIGhhdmUgdG8gQlVHX09OKCkgd2hlbg0KPiB3ZQ0KPiBydW4gb3V0
IG9mIG5vZGVzIHRvIHVzZSBvciBoYXZlIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIEJVRw0K
PiBhbnl3YXlzLg0KPiANCllhcCwgdGhlIHJvb3QgY2F1c2UgaXMgb29tLiBUaGUgQlVHX09OKCkg
Zm9yIHRoZSBzaXR1YXRpb25zIHRoYXQgdGhlDQptYXBsZSB0cmVlIHN0cnVjdCBjYW5ub3QgYmUg
bWFpbnRhaW5lZCBiZWNhdXNlIG9mIHRoZSBsYWNrIG9mIG1lbW9yeSBpcw0KbmVjZXNzYXJ5LiBC
dXQgdGhlIHRoZSBidWRkeSBzeXN0ZW0gaW4gbGludXgga2VybmVsIGNhbiByZWNsYWltIG1lbW9y
eQ0Kd2hlbiB0aGUgc3lzdGVtIGlzIHVuZGVyIHRoZSBsb3cgbWVtb3J5IHN0YXR1cy4gSWYgd2Ug
dXNlIEdGUF9LRVJORUwNCmFmdGVyIHRyeWluZyBHRlBfTk9XQUlUIHRvIGFsbG9jYXRlIG5vZGUs
IG1heWJlIHdlIGNhbiBnZXQgZW5vdWdoDQptZW1vcnkgd2hlbiB0aGUgc2Vjb25kIHRyeSB3aXRo
IEdGUF9LRVJORUwuIA0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gV2UgaGF2ZSBzZWVuIHRoYXQg
dGhlcmUgbWF5IGJlIHNvbWUgbWFwbGVfdHJlZSBvcGVyYXRpb25zIGluDQo+ID4gPiBtZXJnZV92
bWEuLi4NCj4gPiA+IA0KPiA+ID4gSWYgbWVyZ2Vfdm1hKCkgZG9lcyBhbnl0aGluZywgdGhlbiB0
aGVyZSB3YXMgYW4gb3BlcmF0aW9uIHRvIHRoZQ0KPiA+ID4gbWFwbGUNCj4gPiA+IHRyZWUuDQo+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE1vcmVvdmVyLCB3b3VsZCBtYXBsZV90cmVlIHByb3Zp
ZGVzIGFuIEFQSSBmb3IgYXNzaWduaW5nIHVzZXIncw0KPiBnZnANCj4gPiA+IGZsYWcgZm9yIGFs
bG9jYXRpbmcgbm9kZT8NCj4gPiA+IA0KPiA+ID4gbWFzX3ByZWFsbG9jYXRlKCkgYW5kIG1hc19z
dG9yZV9nZnAoKSBoYXMgZ2ZwIGZsYWdzIGFzIGFuDQo+ID4gPiBhcmd1bWVudC4gIEluDQo+ID4g
PiB5b3VyIGNhbGwgc3RhY2ssIGl0IHdpbGwgYmUgY2FsbGVkIGluIF9fdm1hX2FkanVzdCgpIGFz
IHN1Y2g6DQo+ID4gPiANCj4gPiA+IGlmIChtYXNfcHJlYWxsb2NhdGUoJm1hcywgdm1hLCBHRlBf
S0VSTkVMKSkNCj4gPiA+IHJldHVybiAtRU5PTUVNOw0KPiA+ID4gDQo+ID4gPiBsaW5lIDcxNSBp
biB2Ni4xLjI1DQo+ID4gPiANCj4gPiA+ID4gSW4gcmJfdHJlZSwgd2UgYWxsb2NhdGUgdm1hX2Fy
ZWFfc3RydWN0IChyYl9ub2RlIGlzIGluIHRoaXMNCj4gPiA+IHN0cnVjdC4pIHdpdGggR0ZQX0tF
Uk5FTCwgYW5kIG1hcGxlX3RyZWUgYWxsb2NhdGUgbm9kZSB3aXRoDQo+ID4gPiBHRlBfTk9XQUlU
IGFuZCBfX0dGUF9OT1dBUk4uDQo+ID4gPiANCj4gPiA+IFdlIHVzZSBHRlBfS0VSTkVMIGFzIEkg
ZXhwbGFpbmVkIGFib3ZlIGZvciB0aGUgVk1BIHRyZWUuDQo+ID4gDQo+ID4gR290IGl0ISBCdXQg
dGhlIG1hc19ub2RlX2NvdW50KCkgYWx3YXlzIHVzZSBHRlBfTk9XQUlUIGFuZA0KPiBfX0dGUF9O
T1dBUk4NCj4gPiBpbiBpbnNlcnRpbmcgdHJlZSBmbG93LiBEbyB5b3UgY29uc2lkZXIgdGhlIHBl
cmZvcm1hbmNlIG9mDQo+IG1haW50YWluaW5nDQo+ID4gdGhlIHN0cnVjdHVyZSBvZiBtYXBsZV90
cmVlPw0KPiANCj4gU29ycnksIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGJ5ICdj
b25zaWRlciB0aGUgcGVyZm9ybWFuY2UNCj4gb2YNCj4gbWFpbnRhaW5pbmcgdGhlIHN0cnVjdHVy
ZSBvZiBtYXBsZV90cmVlJy4NCj4gDQpBcyBJIG1lbnRpb25lZCBhYm92ZSwgR0ZQX05PV0FJVCB3
aWxsIG5vdCBhbGxvdyBidWRkeSBzeXN0ZW0gZm9yDQpyZWNsYWltaW5nIG1lbW9yeSwgc28gIkRv
IHlvdSBjb25zaWRlciB0aGUgcGVyZm9ybWFuY2Ugb2YgbWFpbnRhaW5pbmcNCnRoZSBzdHJ1Y3R1
cmUgb2YgbWFwbGVfdHJlZSIgbWVhbnMgdGhhdDogd2hldGhlciB0aGUgbWFzX25vZGVfY291bnQo
KQ0KcGF0aCBpcyBub3QgYWxsb3dlZCB0byByZWNsYWltIG9yIGNvbXBhY3QgbWVtb3J5IGZvciB0
aGUgcGVyZm9ybWFuY2UuDQo+ID4gDQo+ID4gPiBJdCBhbHNvIHdpbGwgZHJvcCB0aGUgbG9jayBh
bmQgcmV0cnkgd2l0aCBHRlBfS0VSTkVMIG9uIGZhaWx1cmUNCj4gPiA+IHdoZW4gbm90IHVzaW5n
IHRoZSBleHRlcm5hbCBsb2NrLiAgVGhlIG1tYXBfbG9jayBpcyBjb25maWd1cmVkIGFzDQo+IGFu
DQo+ID4gPiBleHRlcm5hbCBsb2NrLg0KPiA+ID4gDQo+ID4gPiA+IEFsbG9jYXRpb24gd2lsbCBu
b3Qgd2FpdCBmb3IgcmVjbGFpbWluZyBhbmQgY29tcGFjdGluZyB3aGVuDQo+IHRoZXJlDQo+ID4g
PiBpcyBubyBlbm91Z2ggYXZhaWxhYmxlIG1lbW9yeS4NCj4gPiA+ID4gSXMgdGhlcmUgYW55IGNv
bmNlcm4gZm9yIHRoaXMgZGVzaWduPw0KPiA+ID4gDQo+ID4gPiBUaGlzIGhhcyBiZWVuIGFkZHJl
c3NlZCBhYm92ZSwgYnV0IGxldCBtZSBrbm93IGlmIEkgbWlzc2VkDQo+IGFueXRoaW5nDQo+ID4g
PiBoZXJlLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSB0aGluayB0aGF0IHRoZSBtYXNfbm9kZV9jb3Vu
dCgpIGhhcyBoaWdoZXIgcmF0ZSBvZiB0cmlnZ2VyaW5nDQo+ID4gQlVHX09OKCkgd2hlbiBhbGxv
Y2F0aW5nIG5vZGVzIHdpdGggR0ZQX05PV0FJVCBhbmQgX19HRlBfTk9XQVJOLiBJZg0KPiA+IG1h
c19ub2RlX2NvdW50KCkgdXNlIEdGUF9LRVJORUwgYXMgbWFzX3ByZWFsbG9jYXRlKCkgaW4gdGhl
IG1tYXAuYywNCj4gdGhlDQo+ID4gYWxsb2NhdGlvbiBmYWlsIHJhdGUgbWF5IGJlIGxvd2VyIHRo
YW4gdXNlIEdGUF9OT1dBSVQuDQo+IA0KPiBXaGljaCBCVUdfT04oKSBhcmUgeW91IHJlZmVycmlu
ZyB0bz8NCj4gDQo+IElmIEkgd2FzIHRvIHNlcGFyYXRlIHRoZSBjb2RlIHBhdGggZm9yIG1hc19z
dG9yZV9wcmVhbGxvYygpIGFuZA0KPiBtYXNfc3RvcmVfZ2ZwKCksIHRoZW4gYSBCVUdfT04oKSB3
b3VsZCBzdGlsbCBuZWVkIHRvIGV4aXN0IGFuZCBzdGlsbA0KPiB3b3VsZCBoYXZlIGJlZW4gdHJp
Z2dlcmVkLi4gIFdlIGFyZSBpbiBhIHBsYWNlIGluIHRoZSBjb2RlIHdoZXJlIHdlDQo+IHNob3Vs
ZCBuZXZlciBzbGVlcCBhbmQgd2UgZG9uJ3QgaGF2ZSBlbm91Z2ggbWVtb3J5IGFsbG9jYXRlZCB0
byBkbw0KPiB3aGF0DQo+IHdhcyBuZWNlc3NhcnkuDQo+IA0KWWFwLiBUaGVyZSBpcyBubyByZWFz
b24gdG8gc2VwcmF0ZSBtYXNfc3RvcmVfcHJlYWxsb2MoKSBhbmQNCm1hc19zdG9yZV9nZnAuIElz
IGl0IHBvc3NpYmxlIHRvIHJldHJ5IHRvIGFsbG9jYXRlIG1hc19ub2RlIHdpdGgNCkdGUF9LRVJO
RUwgKHdhaXQgZm9yIHN5c3RlbSByZWNsYWltIGFuZCBjb21wYWN0KSBpbnN0ZWFkIG9mIHRyaWdn
ZXJpbmcNCkJVR19PTiBvbmNlIHRoZSBHRlBfTk9XQUlUIGFsbG9jYXRpb24gZmFpbGVkPw0KDQo+
IFRoYW5rcywNCj4gTGlhbQ0KDQpCZXN0IFJlZ2FyZHMsDQpKb2huIEhzdQ0K
