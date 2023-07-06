Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496E7492E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjGFBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGFBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:07:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD31995
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:07:23 -0700 (PDT)
X-UUID: 74ede28e1b9911ee9cb5633481061a41-20230706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U+VIK/pAmA9DpI5cbSfUEhvT+BDKPoxninqp7wECauc=;
        b=gZOlGqnfKrFKPBEF88vBMjJ+GU0OtCBgL0yZRZxDIAaQUsL/PjLTDrqQbQhY61/LQJUeSGaCNgJT59U9yANheUObO/3zHUxN/D5PYk01vxGEwT9gDoyqq/JS4pE67Ki18SfllQwwDrles96Hh/BS8PiRVYITzyymSKXwZ5gWiIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:21742a80-7131-4eda-9004-562ccaaf12e8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.27,REQID:21742a80-7131-4eda-9004-562ccaaf12e8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:01c9525,CLOUDID:2c11acda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:2307060907208JDI02HE,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: 74ede28e1b9911ee9cb5633481061a41-20230706
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1151707007; Thu, 06 Jul 2023 09:07:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jul 2023 09:07:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jul 2023 09:07:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVpxpwoyp4nRoW/cqk+5xY3pksnyIJnfrQmDsLyOKk5omp6agijJWiTfpVb4Arg9Kb7DR7SSqXxFQgl+iBIjMYBjptw4n7AiTuT77Xr3cnEdnnCfRF/zfghMpP3iDPKYq8mvZMkoicBzL9l2FvzWaK25tUH8OeixWP38a0+teOFCdTgM6V+7/KTqg6F3ydn4gS43vSpcfF/Ngb4UwdJpEfNMh7C5o9qzVzrWljxPZeR06DBESmFiV9WdCZMKLLWoTOKRAxBt8wjt3luZNap2uYh2DWOgAcrlTNfLvbWHdWQM96/lCfhPooKyo+eayx3trWaIkEStBuWYB7YR7hSRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+VIK/pAmA9DpI5cbSfUEhvT+BDKPoxninqp7wECauc=;
 b=hd3dXxdWX+KZIHSoYDw3dWyTJrHkVT33Lf7lr0De4cWmqX3QBAcwASNxWTPN0RExEtEdLIXBDpddW3irTpyLWLtaU764oSPbmSTCJzhkpc8NzBXRbaCTr9sEEXTqZBU6TTIJefmY2cxqgnsYAZS7HOVkNVljZZTPx6uOlIK5mpMQE8Fbu8e0fNXmfdIxLIArnxZcJ0bV8UtK0mjkCSSFn/bHSW6fVQojJgGJMztagQ80cD+GAHNlAnqFyeFWm38sTI+AqbCCQo9cGsgcLU+Qtvx8Cjsrdpm/hoijAVHO5PR5ULKaPp0mCNX5IcJahtriRHHhKQV5GKKQ4sH6DGtlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+VIK/pAmA9DpI5cbSfUEhvT+BDKPoxninqp7wECauc=;
 b=bWIWg80MrffxW1nWBMkz9G+ngzQ9Enr5XGW/q7msr2txXBgIlzo3GRB3yoiV73AmAQkOTDu+Tqilcm4LsJmaa9KhsnQoRBHS//o063emWBZ4hOMh5aCmN8FWbzGDAOF9p86usas0Mo4MgMjq6uTb9KqkhAKu9UqIIKPRSb65JBg=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by SEYPR03MB6996.apcprd03.prod.outlook.com (2603:1096:101:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 01:07:13 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::f5d3:d81c:730:2909]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::f5d3:d81c:730:2909%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 01:07:12 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v5 0/4] Support timer drivers as loadable modules
Thread-Topic: [PATCH v5 0/4] Support timer drivers as loadable modules
Thread-Index: AQHZiGcAlWtFKUKClEylT3CLdkSqYK+SicEAgBmx04A=
Date:   Thu, 6 Jul 2023 01:07:12 +0000
Message-ID: <e80e467b22f7c19445e0b2e86fca7173f7e43701.camel@mediatek.com>
References: <20230517022557.24388-1-walter.chang@mediatek.com>
         <4c2f66f1-2623-306f-f1d3-83a32a0c2885@linaro.org>
In-Reply-To: <4c2f66f1-2623-306f-f1d3-83a32a0c2885@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|SEYPR03MB6996:EE_
x-ms-office365-filtering-correlation-id: f6e48495-4721-4227-9181-08db7dbd54c1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzS5rp1VbBnD1dWCwXRfLTFeaVYHiVzctEFKQeCtBSzNL0nvu/0N6L8T3gj4CRQd2cuLoVI8o77qpukhb82/eqiQ2ZQg1OJCn+78HD8DrNcqVFwnhdA2SQWHI1++fSqnGi0WHJ9h2v6QjFP+4pRI46PI5UPr3x629Q3sQHntxQgrOB+9w1Gp/I846NYWK4rEbHEBgUhL2SFYN40d82iOHSFRT/ggkC2HFwwJlwUaGMhD1E9MOQQV7vAbrjmSmeH/4LEIdHiWf+cgH9BTR2Lwa1B1ejwR3RZzskWzUhRBOAhnJEutFQBv38TRrAGtXuWHuIcMM0QjNUdYdb4rbMPpXiL+i81o200UxstHElQMneA/nKyJdS83HIm5qVZci8iFcKKd8n9lJd+LkArbmew6t4YOUnF7ewsrd91HVSrtRlWwLHWSvhS4VtLemjCX4i4+VfgqFfglP1DtfLdhriAmG+ih+f8aLbIyBGuh2W93MsVmIX3chv9ZX+Todk6BTvTBMPK7dWfmfCS2FO/JcwSbFbe6Ya+QcOx3on8sSMAbbi+1bMPiq+bDpwZ0pNKcmdnS281Lmc0EfTeDiILbErdD9RNdBop/TbmqzIefwnAWr6E4sgCqSqlFt4K08ijTCH1/juoMo1pef0GCXfPaqfpgGDFyD8XS7TSkSbDFpyVYREg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(2906002)(5660300002)(2616005)(86362001)(66556008)(8676002)(66946007)(36756003)(8936002)(6506007)(54906003)(478600001)(110136005)(71200400001)(6486002)(186003)(107886003)(4744005)(6512007)(26005)(122000001)(38070700005)(38100700002)(83380400001)(85182001)(316002)(4326008)(91956017)(66446008)(66476007)(76116006)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1RUZzNpK0NBb0JXTWRrK0RDc0JBV2ZXNndqbjdDaGw1YkZ0SjNDcU53cnFh?=
 =?utf-8?B?RjJ4THJNOXFNZ3ZtYVhaakd6bWRkazRZNmhoL2s1TlR1eDhZN2E2NHhyQ0xL?=
 =?utf-8?B?a21iT1dJVTc1NTBDMFkwZ04rKzlaQ2hLQ1dqclhNZFNsQ3NnVlg1QnJMZ3pU?=
 =?utf-8?B?T3Y0RnVLbW02bnVaTkFsazlJalJuR3Q4Q0NUa0hoVVVQUmEvMHJJRTh0RWNs?=
 =?utf-8?B?UndMY2ZtUkxCMHE3a1BTelFQSmdEdzlNM2c5ck5HamhObFlqSW9pM1N3OEVp?=
 =?utf-8?B?MGp6M0dVV21pY2ZsU2xTaERyVWltekxQN0oxcElRbjI3VTFuQ2JMSGJsMXlD?=
 =?utf-8?B?cWJLMUc5Wm1vU0xFUGVvWG0ybjhiVkxTKzZTdFdOcUlLalRjcVovbmhNYjll?=
 =?utf-8?B?Rm01OHQwcXBzcTZObWJGU0JDUGhWNmRsMnVxaFJJd3h1OXhGQ2JEalhQSWdT?=
 =?utf-8?B?dGZONEVtTFlFcTNwUGlkWXNGYllLaHZDSEQ4ckdYUHBmYzhQSTRKTzkyaC8x?=
 =?utf-8?B?M2V0NS81OVRGaS9VclZLSk5mRzJyS1Vpcm1XRkVnOFA1MWlPWm9Ed2ZVU1pT?=
 =?utf-8?B?MmwrQzFYZDFlemtoRThzdXpXMnQyMERrajdnR2pyU3FjQS91V3BDZ05NOFlY?=
 =?utf-8?B?WkcxZyt2ZWRURXJXUk5mdXNOa1hYdWpzQnU2akk3VFJFdk5YMDNVN3VSbkkw?=
 =?utf-8?B?UjJXQlN6YTY5RERhNWorRjhPbWNqQyt1cDZmMUxzN3MrLzlxYUhkZTdycnR6?=
 =?utf-8?B?TndMUHhDbDBtOWdMSnVraktCVE9OR21WeXNPdHlmbUJDcnZRTlhlYXYvRnY3?=
 =?utf-8?B?Wmw5ZTREcXRubDVHb1BNeEZ3anJ6bkxUWjkxRzNvYlBTcm96VlBjeHg0Mit4?=
 =?utf-8?B?dDV2bnV3RVIwL1lQdGdTVWovOFRmcVdTT1FNRGRrUndmZmJwVmY0aE1OZ0tH?=
 =?utf-8?B?WGZBZEQ3bGJoM0I0OHh2bGRkMHlFWmNORyt4aEJMenF0bWxRNGFyL3dpK2ZU?=
 =?utf-8?B?emRDRmlmSUhUajdoTTk4U2ttWmU4b0E5WUlQa3d1aDJPWEluam9QWWZRK0U0?=
 =?utf-8?B?cEJzcktFeXJVZGF4dFJEUEpnNUtucy9SWGJvTWJvRnNOZHFvYm5SbittNTdz?=
 =?utf-8?B?VVhYQ1ZLNlgzb1FCWUYxWWJHeVJWcUZLTnpiWWhKUWFQaVV0bGsveFRKdjdy?=
 =?utf-8?B?SzRpYkhhSVBSMTdOczdYTzI0UE4wRnkxZk90Z3NtSjdIKzRicTMva2VGbDNZ?=
 =?utf-8?B?M3pqdGdxaEhoTGxYRFZQN2hoeDZoWjQ3b3IyeVhlbC95TFhQUkhWTGNJK1Qz?=
 =?utf-8?B?b1BTdG5jcHBITTBld21FT0NDQ2p3cC9Ma2JQc3JHaERlY3lGQjdBc083bklM?=
 =?utf-8?B?YiszamZMTkVZaktwTXgrejRaeU55WXdFeTUwaDVQaWc2cGFmZjV1d2hXUEJJ?=
 =?utf-8?B?b1RtOG9wVjg0a1c0N0RCZXVPWW5kRGlUYVFVaEZPRGV6eHgrSGxINzdSUFhE?=
 =?utf-8?B?ekNRY0I1SzJVRDFLOURnWGlkRnk2cWhnZFdIUHp5RkdMaURmRDlSc0JaMmdL?=
 =?utf-8?B?NXJTU0lkREkxOU90TVpNRWZveVpDbW91QklTOTdBcnE0S2R4aiszenR2K2NH?=
 =?utf-8?B?QUVpY2JHdXpOTHdrZnJ4OFBBdzZPcUVIbDUyNlMzdDNhNkZ5Zi8yMytmVk81?=
 =?utf-8?B?eVFobnVtWVFoM0t2YXZraUczUTVJc2hnYkZ1Y1NzNEg0Z3ZWaHJkQS9GckFh?=
 =?utf-8?B?ZENFY3JRSXhURDZ1VG4wMTdWV0RFN0wzMUQ1YzJKMW5hbHQ0c2lNeGExVUhn?=
 =?utf-8?B?UXJXLy94TS9SY2JWTGpKdHpBdUNCZWd5ODdiQ0dHMVNEc3BDSGlmMzF5VEJX?=
 =?utf-8?B?aDVJVUx5WUlhZUQ4ejJZcnZudWphU2V3aFhML0JoOHJrOVZYamNBTzdyUlFL?=
 =?utf-8?B?NlhuWmZKSTdtN3hpcStyei9Pb2VLOFVGazBaRzNLU2s0bDFzTHBIU3FLTlpR?=
 =?utf-8?B?bkk5VThPRW5zTzNjOWNjaGVib2xDZUU4REZ2c2Z4T1dlU1ZVVVdLbjBJcjB4?=
 =?utf-8?B?eVAzYk1aS1RMQ0pZb0tzVytmK3hNWTNyb1YyTW1yY2R3RUtBTDNwZnpuajNX?=
 =?utf-8?B?cjBhSmZTVU93c0M0STVYUmhsdEgzeE5saXlnN21mQTIwbUg1RGJvN3RXSGZT?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF1EF2AFF1C5C444A5A2E94B4C347ED3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e48495-4721-4227-9181-08db7dbd54c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 01:07:12.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdIYYdhlMwMp2hkgGw5JJUmbeZuXgy0otSSud9vpOp8SolXWc6WzqGvyFDaaZZ+Z8Tf3GepO/crVLedItct1tYD6YKaD8CHY25sPRCAlKwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDE4OjQ0ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICANCj4gQXMgSSBhbHJlYWR5IHNhaWQsIEknbSBub3QgdmVyeSBjb21m
b3J0YWJsZSB3aXRoIHRoZXNlIGNoYW5nZXMgYW5kDQo+IHRoZSANCj4gcG90ZW50aWFsIGltcGFj
dCBpdCBjYW4gaGF2ZSBvbiB0aGUgb3ZlcmFsbCB0aW1lIGZyYW1ld29yay4NCj4gDQo+IEkgd2ls
bCBwaWNrIHRoZSBzZXJpZXMgaWYgVGhvbWFzIGdpdmVzIGl0cyBBY2tlZC1ieQ0KPiANCj4gVGhh
bmtzDQo+IA0KPiANCg0KVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cuIEkgd2lsbCB3YWl0IGZv
ciBUaG9tYXMncyByZXNwb25zZS4NCg0KVGhhbmtzLA0KV2FsdGVyIENoYW5nDQo=
