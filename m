Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26946719AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjARKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjARKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:50:57 -0500
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36787663;
        Wed, 18 Jan 2023 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1674036009; i=@lenovo.com;
        bh=XoQwNyzjDT5tvmicWIscdcRunbbY7E3v1qzH3Sn8snc=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=HSYHrbOhOdP8FXFa80aRquVti+TjhAi5m325xE8AfnrFft6Yz5eqbYuLmgmgOo4Gm
         GB/uIhND7d9fWsMXH8w/rzcf+L2u2P6i4uft/vyWo5NQ/sXRiWzQnBxKkZtmqjwNuv
         hByxSb5CX2AD2ov/9nPIeAumc3IQ1IRpSZzQTGKxKOht9xGZCZVqvtP4esalOFjA11
         Id5wD+YDxaHpsHT80cO8otPhgFaIrAc56BBD99ZOGXCBf2kVDDyhZM3QxF+1fKHhSW
         eFIUYC5CHEGdyLrD1Sw+hNv8zSCxc93kq+RY8Y5Z4ovYDjhEA4xmmHGOs1mkm57Bkz
         06wyxZBwnDejw==
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSf0wTZxjm612vB2nNtUD62YC6Rh3D9QaaLXV
  OGYuYxs2ETMecmehBb7RbKU3vwNYlW2EkU1gdM0CgQMevEeyMzO4Hs2mhCggYCRvbHMya8jOz
  mjhXoHHjx9b20LH/nud9nvd7n+/NiyOSaUyG0yaWNuopnRyLQzXPyQyKlL7B/LRF627lP+46g
  fInVyOmnLf2A2VLWblA2bRQgygvL6pexlRtndV81UX7RaByOs5iKt8tN6aad27K5h/ja/V5Ra
  aTfM3KQDlqcKeYppx+YAGPnq4AcTggvkBgcCnE40grH452uAQc+QrAyr/nQYRIiEYe/HPUinH
  ED2B3eRCtALE4RihgYNAXxjieQOjgDw15EQ9CtAHonfQgEU88kQUDv7qj/gTiADwXWuZzmIRn
  zjiidZTYBj8OcVhEHIeuvgqUG1YF4FKlF4sIscQeOGHp5EUwIJJh7bQ/ihFCCptqbdFHIUHAd
  vcowuFEGJhZ5XN+Fv4W6MK4ejIc+7wScDgDXu/sRjl8CLpafAIOb4IO69RafTOsbf1jrZ4EJ8
  e7o5uARBUGq+Z+BBy5jUJHqY/HudKgPdS/5jqXCIdaewRc1FRotyytxX4KVldOCarADtu6X9j
  W2WzrbLboasRwuH4WbQaoA7zA0MYS2qjYmU7mGbUFGraQ0upI6rSCIosZBU0xrGInSZ1iSJph
  SMZcmK9Tk3qadYLwcamNr9z4Hlg6lslrYCPOkyeKZryD+ZINeUVqs4ZiNCeMxTqauQaScFwOR
  XO9YU1spAto0ztaXfhEH8sQF8oTRIFIq4gxUIWMtoCTboAM/OfvPB4Ev9XV3IPg9obVXgTvbK
  +5ikhQfZGelklFwavhNiLSpinWP3n08emPgWRZvAjExMRIhAbaWKhl/6/fA1IcyONFvZHhQq2
  efTL7XjgWLxxLxQ5EYrHUf5LMwjPU+I+zZU2nY8oTd13ZM7LvdTzzzUOw/dGrGzwxR3+ZeOtk
  790vvV87RpoEeoN384NQ83X/keGJ977dGHtBJNx1XvpMwwc3VZJSs2CglB+UvTR72LNSj42ku
  28mj9k/ifssy/phcnzm77nP6uXikteGyOxjeebMOx9VNPgKJ9/Iefu2NHjnLnrpcvDhp3En6v
  qO7O7bsv/KNuH2anph+9Cs/2FHn/qviqOr44cpDba4xVpiSupaGtrReKonqeHgpYNK12j28IG
  SjJn+8bPLKSCk3nu/zZvLn0t94Fwxt+TmeMg09P1pWNmcpRAbt/pf7Liwv76sbF/K84FvFsR7
  37Xn1J2/L0cZDZWeihgZ6l8/J9GLdQQAAA==
X-Env-Sender: vincentwang3@lenovo.com
X-Msg-Ref: server-6.tower-715.messagelabs.com!1674036006!58484!1
X-Originating-IP: [104.47.26.112]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19436 invoked from network); 18 Jan 2023 10:00:08 -0000
Received: from mail-sgaapc01lp2112.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.112)
  by server-6.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jan 2023 10:00:08 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDh72dSchll0dNrzsILs9khFYRyuSMIxQ81WgWULF6PQ4mw0FObpkSK3rnQ6uVPrhZ3DZIDYhJ6oageaqHQeBRierHxDOISDS60Zlz8/1b5eZY9v4Pu8N5hzX+8YZzxL9QnVtZgW90t2rNpwjXA6BTO5Cl3M2WOwRrPU3oqG8T8O8NsUxy1qWcXaFEKNdeV3nA1uhnExjA26N5oRIXcdcEPLrcLt5MvswQ51yBQS4Lx+ZDE8VLKlSkxwiAGYjppAC3n1HMJHhmBFa12RrJAaf/6Mkgb7+vrFY4u8uvhbK+VWrrvgOeuBdgehROmz6zzM7zEQucRrDHixqNPEI5o0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoQwNyzjDT5tvmicWIscdcRunbbY7E3v1qzH3Sn8snc=;
 b=RdYcVF89I/qaUfN4RRGe5FoD6T4GdtjMe5AGZ0Q/86kFYwu4XTlSiMxxma8V6CXO0GS+EJtW1PI7HDjQrFXlnTgHJjpweOii7GsmSdlDf1ONegUAp3pnvLqwtjsiMqGtognwJqKl557K0dVgRhurUVUpkrGGLowADYkg7asq8Lv4AL5yunGa/l6ka4jyKBGPt1SLR+QP7buDJKQFUzPzm8cxkZ/C4himx0KBriWjlRGnK9ODE0udbyK+4vs8JbLn9Xyjj/CBMgSXkOvPvMkWMuLxVkBhdw6xEW/0/tAOHpf2LobX4S2yhLpa4mG8ziq13kR714QUtJAPsbsut21bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SG2PR03MB6456.apcprd03.prod.outlook.com (2603:1096:4:1c4::6) by
 TYZPR03MB5727.apcprd03.prod.outlook.com (2603:1096:400:8d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 10:00:05 +0000
Received: from SG2PR03MB6456.apcprd03.prod.outlook.com
 ([fe80::c9e4:f03b:b6d4:f36c]) by SG2PR03MB6456.apcprd03.prod.outlook.com
 ([fe80::c9e4:f03b:b6d4:f36c%6]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 10:00:05 +0000
From:   Vincent Wang3 <vincentwang3@lenovo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Wang <bhuwz@163.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2] cpufreq: Register with perf domain before
Thread-Topic: Re: [PATCH v2] cpufreq: Register with perf domain before
Thread-Index: AQHZKyOjEfJRmZRSokujrJSwEinVtg==
Date:   Wed, 18 Jan 2023 10:00:04 +0000
Message-ID: <SG2PR03MB6456E1E22B9D26317B1BE9AFE5C79@SG2PR03MB6456.apcprd03.prod.outlook.com>
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
 <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
In-Reply-To: <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6456:EE_|TYZPR03MB5727:EE_
x-ms-office365-filtering-correlation-id: e32ff2fe-9700-4a97-1c88-08daf93ac5eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BS67ATm08PYucEe+IrlQk2lQonpVZV2f4djp7MePdnmu4tzvfXycEMmoqgYld9ouDOpbIIGu6OgUq4UuqZXExyWSqBcSxjtFSHTyZqBywBKTErpHFuNEqHepRjLvT3DxZHC/6BT0TQ4agsiSdHRYhrqjlBVaJXUKIiTz5zjtua4hM05vkC/aaY7tEKT/z2ZmbIHbDVqi5wH+u1JzOjpaD5YnpTWdvO/r+KB7l9Tih00rlZd41+qLjA04xd3nZTFOr9q/Hpz8GapOL2rZmaIHvWqLbPnbcX+krb4XfR4Ek0VxHzYv4zaKRv0z62HfMJMKbK2pTJ/hNlPGbcBf1RStyu13q6e23FzEvK8oXsgS6XyUz+NE7YSJDx2eq+VNcjqHjup22aGckK9jCxQNeoUKWOvrQiawbCgZWaBlj3qafghD73l9ns4cZsVf4ZgpS1Gve/LT0f94THSiSndnd1NVo4wfXflvGkyMMBrY2+eZTYmWmqdGbP7J4+2TkhNhNlV0x28mLxjxz/rileW9CLyzwVdmhS2IcrLnC2j94CeYod7hNIMqTh5wB65YGAWQK2xOhJg2OnGIY0PWwvWUDMYEaN79stBpC090TIQVYp7tNpsuGso2WfeWiU4jY3t5UHXgMStc6uUHMZUjfT8kMuqM371VwVzt506p7M+EHQyxKUMYsKxK60RYhwZ1BANUYTTmlxnCH4Ps2bli9HAJco2sxbpnT1zqBnd25au4oq4CU2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6456.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(66556008)(41300700001)(186003)(26005)(52536014)(5660300002)(76116006)(64756008)(66476007)(4326008)(66446008)(66946007)(82960400001)(38070700005)(54906003)(8676002)(122000001)(316002)(8936002)(110136005)(86362001)(38100700002)(2906002)(71200400001)(966005)(478600001)(7696005)(6506007)(53546011)(55016003)(45080400002)(9686003)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cG9PNlJaNng1SUtqWUE2cVFPQ1ZabTQxY1liRnF6TkpRSHlkSmpTMFlGazFx?=
 =?gb2312?B?Y2VqTUVoNkJ6UXdVS01aMk1hUk1RWUdhSC9KRHl0MG9JU05iR3l4RzhoaUlm?=
 =?gb2312?B?ZjlXN2NrZDJDc0lsVlpESkZmdWUrMVdINGZ3Q1gzOW9zazNTYXZCWGQ4WEdP?=
 =?gb2312?B?ank1NHBYb0l6M1ZKV1BlUkRGUldYc1UvcVB1K1ZqTmhwSTYvZHNRUGdrQnl4?=
 =?gb2312?B?dFpSYkxRT2lPWUwzaHBnTnZPVlpHZktoSlJuTFBWVGVhZk1CemllK1ByeERC?=
 =?gb2312?B?ME1mRlRGNUx6YzA2dmRoY0pJdW5OcUdJaUF6QVE4QTdJU3M1WWUvOERaSmZW?=
 =?gb2312?B?NkdPNm1sVXpNUjJDY0JiOENSV0d3V1YvWERxUUxNNlhQeDNrZGdyRkNJUjRB?=
 =?gb2312?B?ZGpZS2szb0tSRERqNUhSdlZ3eVBBdE1qb3g2Qk0xaHVTdHBDRFZ2QmtuSHFs?=
 =?gb2312?B?WTVyK2t2RXY0NUhBZEx1UC9NcWM4Mit6REV6SkxoSGk1SVBFRUhEMnh4YzR3?=
 =?gb2312?B?aThkNFNuVHcxdlprOTc4YUpmZXFMN04ySHFuZmdWOGduZHhCRSsxemg5OCtH?=
 =?gb2312?B?c01Oa3NRZlVCV1NEWm5Jd05Edmk2VUlFbTM4R0lCU2NkdnVBZVd0Q2RkN05K?=
 =?gb2312?B?Tm9oQXI5dHdlSTBSUHdRVTlWTS9HbmFNNDlLQ3VEbUs5cldRZzFXZ3FPR2RW?=
 =?gb2312?B?NFZSbFlBM25qUHhDcDBzSXBGc3VHcnNvRExla0Q4NDFLSkNvSC81UkEvMGpG?=
 =?gb2312?B?dmxubHNmeTh6aGJ3ZzdiVFFGZ0t3alVRSWFPbU16L0ppajNSSEJoUUUwOXMw?=
 =?gb2312?B?ZDc4SjRIMktUR0RXWG51QVloOGRFVUpWb3hOOUZQRzg1RUJac1QwL0RETkJV?=
 =?gb2312?B?MFI3akRGQ2ZZcGIvQUNwdEZ6dmc4cENNNGNWOGJwTFZxMUFTcm5JckM2VCsr?=
 =?gb2312?B?dVNzRUJ1dElBcGZNcVJxSUgwK2N5aGhHRXpuREtqbGJURiswTEdsWm9qckk1?=
 =?gb2312?B?dEpDMXJBV3IyQkNpMWZXbzA5aU01K2dwTnNPaHdOdEhLL2pJT2NFUzk3VWl5?=
 =?gb2312?B?VjdBd1RUeVJTdlZCc3FSYnZHVHU3emdnOVdDbHJzUTdjUVFkWk9kN3JMOHRi?=
 =?gb2312?B?NW9kTmJGOEI4RUdRWEJpMGxoVW5KZ0NET29DNjJnbHRYZlBEdm8yOVNwa2V6?=
 =?gb2312?B?M3lUdGtjV0ZBUHRPeENGRGtXbExVaWFVY1ZId0JhT2MxdVdlSzFaTnFrSGZh?=
 =?gb2312?B?OGRMbVVGUkdvQkVCS1RLdTJ6YXBubFgzUEd0KzBrcTBsK1dlZ1YwK2tXemU5?=
 =?gb2312?B?YjZpZnBJYTNlSGV5cjBuK2Fib3U2SXUzUDJ6VU5GQ0thQU9rdWpnZytsUnJp?=
 =?gb2312?B?aVNsdTUyS29uTXhnRk91UGxjY2p5VW5kZU50VGQrS29GcGR6NDZZMTVjNG9M?=
 =?gb2312?B?YXZrSEtldzd2VzFUeVhTNjJ6WDloV3ppeUIrSTdZZEdueVdOZnc5R1J5eXR4?=
 =?gb2312?B?Y3FWeWorYjdSb1lKUWF6eGhCbjRGTDc0SmNiVkRFQTBtZkpoMlRUL29FSDE0?=
 =?gb2312?B?bDM0TndnaGJLMWJkNEp1WE5uTW4xbGJmM01zU1BWbEhOajhiYWN2MlBJeXRL?=
 =?gb2312?B?dkpLL1ovZ2VqUlVGVUIzajF5a25OOENrL1MxTkxRVXA5T3FpbVFMejFNS1Fp?=
 =?gb2312?B?ZDZ0Q21rQWMrQ1FXM3dpVDJlb0cwY0cxL09mRXRnZTRRWFgyVFg2dkVIQ3JJ?=
 =?gb2312?B?RFZwU0xuUnR3WTJhc1pVK2x2NzF4ZWFwVVZMTEV3SDhsRlZNbTAyZkdrUzlQ?=
 =?gb2312?B?U01YbDJPWU9YMGhPY2d1RDlZOUN0MncrT0pqSUdxbXhueTZhRTBZUlRCRGxx?=
 =?gb2312?B?VWk2bU5WdlRLbkRTaUpyOFhsVDhFUnQ5a2VsbnFqQjUzZy9GcExlZFZrbHhx?=
 =?gb2312?B?WW1WNzNkSjVLd29QTVg5RWNmRUthVEQxODY1eXVYOWNBZk9qdlg1N2R5REt6?=
 =?gb2312?B?bkk2bEpsd2R1VjJHakgweGhRVGhwZ3FBczNEMGxJVXVqd1lwcVUvanZEWHJF?=
 =?gb2312?B?RW5zd2JCMTN4RkxtbXc4dHVPdmltQ1dYNWhsQkl4eTdhSWxCV0I0VjhVa2pZ?=
 =?gb2312?Q?3xoenM7ztMX/iCbHp9vf9RMCe?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6456.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32ff2fe-9700-4a97-1c88-08daf93ac5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 10:00:04.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YktDwBHzv7A01NckOAazwB4s+Z1D0YgUT4CbeQ8vJdVfLgEoTPF7TolBICup5JcBbfLBe2IBovQvbn/LaLzyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1a2FzeiwgVmlyZXNoDQoNCkkgZm91bmQgdGhpcyBpc3N1ZSBvbiBBbmRyb2lkIHBob25l
IHdpdGgga2VybmVsIDUuMTUsIGFuZCB0aGUgZ292ZXJub3IgaXMgc2NoZWR1dGlsLg0KV2l0aCB0
aGUgcGRfaW5pdCBpc3N1ZSwgdGhlIHJkLT5wZCB3aWxsIGJlIE5VTEwgYW5kIEVBUyBkb2Vzbid0
IHdvcmsgc2luY2UgcmQtPnBkIHdpbGwgYmUgY2hlY2tlZCBpbiBmdW5jdGlvbiBmaW5kX2VuZXJn
eV9lZmZpY2llbnRfY3B1KCApLg0KDQpJIGRpZG4ndCBub3RpY2UgdGhlIG1vZGlmaWNhdGlvbiBp
biBzY2hlZHV0aWwgYXQgbWFpbmxpbmUsIHNvIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2ggdG8gZml4
IHRoZSBwcm9ibGVtLCBzb3JyeSENCg0KSG93ZXZlciwgYmVzaWRlcyBFQVMgd2lsbCBjaGVjayBy
ZC0+cGQsIEkgbm90aWNlZCB0aGF0IGl0J3MgYWxzbyB1c2VkIGluIHRoZSBmaW5kX2J1c2llc3Rf
Z3JvdXAoKSBhbmQgdXBkYXRlX2NwdV9jYXBhY2l0eSgpIGZ1bmN0aW9ucyBhdCBtYWlubGluZSwg
c28gSSdtIHdvcnJpZWQgdGhhdCBtYXkgbm90IGJlIGVub3VnaCB0byBjaXJjdW12ZW50IGl0IG9u
bHkgaW4gc2NoZWR1dGlsLg0KDQoNCmRldGFpbCBvZiB0aGUgZXhhY3QgY29kZSBwYXRoOg0KaW4g
ZnVuY3Rpb24gcmVnaXN0ZXJfY3B1ZnJlcV9ub3RpZmllciggKSwgdGhlIG5vdGlmaWVyX2Jsb2Nr
IGluaXRfY3B1X2NhcGFjaXR5X25vdGlmaWVyIGlzIHJlZ2lzdGVyZWQgd2l0aCBDUFVGUkVRX1BP
TElDWV9OT1RJRklFUi4NCkR1cmluZyB0aGUgaW5pdGlhbGl6YXRpb24gb2YgYSBuZXcgcG9saWN5
LCB0aGUgbm90aWZpZXJfY2FsbCBmdW5jdGlvbiBpbml0X2NwdV9jYXBhY2l0eV9jYWxsYmFjaygg
KSB3aWxsIGJlIGNhbGxlZKOsaW4gd2hpY2ggdGhlIHdvcmsgdXBkYXRlX3RvcG9sb2d5X2ZsYWdz
X3dvcmsgd2lsbCBiZSBzY2hlZHVsZWQuDQoNCmZvciB0aGUga3dvcmsgZnVuY3Rpb24gdXBkYXRl
X3RvcG9sb2d5X2ZsYWdzX3dvcmtmbiggKaO6DQp1cGRhdGVfdG9wb2xvZ3lfZmxhZ3Nfd29ya2Zu
KCApIC0+IHJlYnVpbGRfc2NoZWRfZG9tYWlucyggKSAtPiByZWJ1aWxkX3NjaGVkX2RvbWFpbnNf
bG9ja2VkKCApIC0+IHBhcnRpdGlvbl9zY2hlZF9kb21haW5zX2xvY2tlZCggKSAtPiBidWlsZF9w
ZXJmX2RvbWFpbnMoICkgLT4gcGRfaW5pdCggKQ0KDQoNCkJScw0KVmluY2VudA0KDQotLS0tLdPK
vP7Urbz+LS0tLS0NCreivP7IyzogTHVrYXN6IEx1YmEgPGx1a2Fzei5sdWJhQGFybS5jb20+IA0K
t6LLzcqxvOQ6IDIwMjPE6jHUwjE4yNUgMTc6MjQNCsrVvP7IyzogVmlyZXNoIEt1bWFyIDx2aXJl
c2gua3VtYXJAbGluYXJvLm9yZz47IFZpbmNlbnQgV2FuZyA8Ymh1d3pAMTYzLmNvbT47IFZpbmNl
bnQgV2FuZzMgPHZpbmNlbnR3YW5nM0BsZW5vdm8uY29tPg0Ks63LzTogcmFmYWVsQGtlcm5lbC5v
cmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0K1vfM4jogW0V4dGVybmFsXSBSZTogW1BBVENIIHYyXSBjcHVmcmVxOiBSZWdpc3RlciB3aXRo
IHBlcmYgZG9tYWluIGJlZm9yZQ0KDQpIaSBWaXJlc2gsIFZpbmNlbnQNCg0KSSdtIHN1cnByaXNl
ZCBzZWVpbmcgdGhpcyB0aHJlYWQgYW5kIHRoYW5rcyB0aGF0IHlvdSBWaXJlc2ggaGF2ZSBhbnN3
ZXJlZCwgc28gaXQgY291bGQgZ28gdGhyb3VnaCBteSBzcGFtL2p1bmsgZmlsdGVycy4NCihJIGhv
cGUgd2hlbiBhbnN3ZXIgdG8gdGhhdCBkb21haW4gaXQgd291bGQgY2hhbmdlIHNvbWV0aGluZyku
DQoNCk9uIDEvMTgvMjMgMDg6NDksIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gT24gMTgtMDEtMjMs
IDEyOjQ3LCBWaW5jZW50IFdhbmcgd3JvdGU6DQo+PiBGcm9tOiBWaW5jZW50IFdhbmcgPHZpbmNl
bnR3YW5nM0BsZW5vdm8uY29tPg0KPj4NCj4+IFdlIGZvdW5kIHRoZSBmb2xsb3dpbmcgaXNzdWUg
ZHVyaW5nIGtlcm5lbCBib290IG9uIGFuZHJvaWQgcGhvbmU6DQo+Pg0KPj4gWyAgICAxLjMyNTI3
Ml1bICAgIFQxXSBjcHUgY3B1MDogRU06IGNyZWF0ZWQgcGVyZiBkb21haW4NCj4+IFsgICAgMS4z
MjkzMTddWyAgICBUMV0gY3B1IGNwdTQ6IEVNOiBjcmVhdGVkIHBlcmYgZG9tYWluDQo+PiBbICAg
IDEuMzM3NTk3XVsgICBUNzZdIHBkX2luaXQ6IG5vIEVNIGZvdW5kIGZvciBDUFU3DQo+PiBbICAg
IDEuMzUwODQ5XVsgICAgVDFdIGNwdSBjcHU3OiBFTTogY3JlYXRlZCBwZXJmIGRvbWFpbg0KPj4N
Cj4+IHBkIGluaXQgZm9yIGNsdXN0ZXIyIGlzIGV4ZWN1dGVkIGluIGEga3dvcmtlciB0aHJlYWQg
YW5kIGlzIGVhcmxpZXIgDQo+PiB0aGFuIHRoZSBwZXJmIGRvbWFpbiBjcmVhdGlvbiBmb3IgY2x1
c3RlcjIuDQo+IA0KPiBDYW4geW91IHBsZWFzZSBnaXZlIGRldGFpbCBvZiB0aGUgZXhhY3QgY29k
ZSBwYXRoLCBmb3IgbWFpbmxpbmUga2VybmVsIA0KPiA/IEkgYW0gbm90IHN1cmUgd2hpY2gga3dv
cmtlciB0aHJlYWQgYXJlIHlvdSB0YWxraW5nIGFib3V0IGhlcmUuDQoNClBsZWFzZSBhbHNvIHRl
bGwgdXMgeW91ciBjcHVmcmVxIGdvdmVybm9yLiBUaGUgc2NoZWR1dGlsIGdvdmVybm9yIGF0IG1h
aW5saW5lIGNhbiBoYW5kbGUgdGhvc2Ugc2l0dWF0aW9ucyBhbmQgd2UgcmVidWlsZCB0aGUgcGVy
ZiBkb21haW5zIGhlcmUgWzFdLg0KDQo+IA0KPj4gcGRfaW5pdCgpIGlzIGNhbGxlZCBmcm9tIHRo
ZSBjcHVmcmVxIG5vdGlmaWNhdGlvbiBvZiANCj4+IENQVUZSRVFfQ1JFQVRFX1BPTElDWSBpbiBj
cHVmcmVxX29ubGluZSgpLCB3aGljaCBpcyBlYXJsaWVyIHRoYW4gdGhhdCANCj4+IGNwdWZyZXFf
ZHJpdmVyLT5yZWdpc3Rlcl9lbSgpIGlzIGNhbGxlZC4NCg0KVmlyZXNoLCBJZiB0aGF0J3MgYW4g
aXNzdWUgZm9yIG90aGVyIGdvdmVybm9ycywgdGhhbiBtYXliZSB3ZSBzaG91bGQgYWRkcmVzcyB0
aGF0LiBJTU8gdGhlIHBhdGNoIGp1c3QgcmVsaWVzIG9uIHNpZGUtZWZmZWN0IGluIGFyY2hfdG9w
b2xvZ3kuYyB1cGRhdGVfdG9wb2xvZ3lfZmxhZ3Nfd29ya2ZuKCkuIFRoYXQgd291bGQgYmUgYSB3
b3JrYXJvdW5kIGFuZCBkYW5nZXJvdXMgaWYgc29tZW9uZSB3b3VsZCBjaGFuZ2UgdGhhdCBhcmNo
X3RvcG9sb2d5LmMgZGVzaWduLiBTaG91bGRuJ3Qgd2UgY29tZSB1cCB3aXRoIHNvbWV0aGluZyBy
ZWxpYWJsZSBpbnNpZGUgdGhlIGNwdWZyZXEuYyBpZiB0aGVyZSBpcyBhIHJlYWwgaXNzdWU/DQpF
dmVuIG5vdywgdGhlc2UgdHdvIG1lY2hhbmlzbXM6DQoxLiBpbiB0aGUgc2NoZWR1dGlsIFsxXQ0K
Mi4gaW4gdGhlIHVwZGF0ZV90b3BvbG9neV9mbGFnc193b3JrZm4oKSBhcmUgYSBiaXQgbGVha3kg
KGluIHRlcm1zIG9mIGRlc2lnbiBob2xlcykuDQoNClJlZ2FyZHMsDQpMdWthc3oNCg0KWzFdDQpo
dHRwczovL2FwYzAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZlbGl4aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRmxhdGVzdCUyRnNvdXJjZSUyRmtl
cm5lbCUyRnNjaGVkJTJGY3B1ZnJlcV9zY2hlZHV0aWwuYyUyM0w4NTgmZGF0YT0wNSU3QzAxJTdD
dmluY2VudHdhbmczJTQwbGVub3ZvLmNvbSU3Q2M2OWI3ZGNhNDQwMTQ3NGJkMjM4MDhkYWY5MzVi
ZmQ1JTdDNWM3ZDBiMjhiZGY4NDEwY2FhOTM0ZGYzNzJiMTYyMDMlN0MwJTdDMCU3QzYzODA5NjMw
NjUwNzM5MjE0NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdD
JTdDJnNkYXRhPVdUUHBXRHl0SXNiZmRXOTIwY0dOaUhoRXM3dWRnclgwTzc4c0FoOEpWN0klM0Qm
cmVzZXJ2ZWQ9MA0KDQo=
