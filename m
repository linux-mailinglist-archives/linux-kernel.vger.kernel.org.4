Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AE624050
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKJKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiKJKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:50:25 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F55E9DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668077425; x=1699613425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DhctW2aWJgcd7FDEp7vOlRBOsESuHkV4uVeKIsKRWVA=;
  b=qMRCkHM+uaJcOGZSqxE7c/7NDHPkLoXQz/hlcvE8nIR0Z+gPAEAOUHpB
   hSJR1ODXx4dJeV6CLJNcNEnkgmJ5B0Ggn6EIB9ltv/wiKd15DkBPMZS7C
   OOb6atBl4tRnbZlyUQYDJnKLW3xXAAxQpwJ4MatFZNiQ4umqkoCFah6Si
   xZU+G/ThRlhUb33m+YF3K8xc0HnAQBJfFErY3rbbFOUEQcENPjIlUtDdz
   D6h0JBvhPzKDVEKwtKmwNy1i7cNyEBg0OMZwLSvYsycaYW7zOowkrmCoH
   /Z4MU92Bktino3GSlifLMfZftWu2S3ba4mlTlxqxbflnFO00gvmxizqz5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="71551918"
X-IronPort-AV: E=Sophos;i="5.96,153,1665414000"; 
   d="scan'208";a="71551918"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:50:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NthRas2wH12PYmuk/uVU+Kmb+wO61i/DksRIPfTTkFYK0BpPnPRl38EOttcQ/jnJ2pbcN5YeNCOJp93twmH8ok/9iers2d98oePJck1nDv+PkbMoxHVDPXcXvytgOB7NWLYpSUg/OhDmucUcrJjkTapJR3BUN/LkaAmQARgoSomnGPOKWodAgz3O3L8jrLq+/tz7It7TyBoejVqBaMO/epXDQeOzDvEgiWxPADSwVdOhc31L3KBH73UdB/15/gSX5tOfSrauoFMgRcKScTqL5Zk3lrmVnzhwke7o6CkvhfQULXANUW1yFJxzD0iTaG0BIJsp4X9/p8z+JEpta/pHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3F1xzVEOBWdzhYAjoW0gJ1hY6v+tj/e0ClQ1EPN3ww=;
 b=fZmS7slF4yLODXMAvudptTKrNTTjasDsuSiCCL5aWoaJlp7+3xUIhCl1yZ4tgrOgDe83qoRjNybu6L9+a96dRTzRCb75TpeutZ4zAbrJIk8/XE4TXZmOHgANquMixrCuwtCnLEsc/BMSWXyUB19nKi3T5h003XH5Yq4JfUmZaYSz+3rxz2fEVAm93lAGL2pwzNE26rJpLzyP2r1yNjT1RyGb8CcRX+m/zDKZDAF0JYicmjumlt46evcZrSb6BebqTK/noRUk6PGH/dO4O1GcmTXwQDPGmH+LCTa/icNi4gyj2oHV9ai7//wKPt8fegRv6mpAFGBTh9xmOxnVwPnxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB8494.jpnprd01.prod.outlook.com (2603:1096:400:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 10:50:14 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 10:50:14 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Thread-Topic: [PATCH 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Thread-Index: AQHY5U7PgTNr4d3Ng0CrSPZdPnk6ca44FkVw
Date:   Thu, 10 Nov 2022 10:50:14 +0000
Message-ID: <TYAPR01MB6330FB646459F4D48D6BA4C88B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-5-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-5-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-10T10:37:34Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=68433d02-c2a3-407b-971a-1f4f5deceeec;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 66b7517419234b55bb9e1fbaa25baf8c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB8494:EE_
x-ms-office365-filtering-correlation-id: 3d926477-655f-4e62-a9d7-08dac3095910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6LkNx0g5iVV0kSSgk6UqRkGGcWTJVga0progGOzZYul/Kuo/KguiD51t6E4gAQED01jVJl5z8iXwFdymuW1AcvxULJ+eM0YuIPwtW1sP/QLQtEG8Kxd2+zPCRtq/O7bySB4pN2i+w9LYMjCMj+0xgRiHB6wjKblNacUb7+DkqjNXLW6xhMGZh4jjRHKOHsJBs6OEwymlzHqWe2OgEmpdPHdt0owu96p5ZS2HB7QppYgnkibjKOaiwMYoJTbqvqoeLxKlvE7To2Q5czWqlacncQJYivzH8xya0BUkIGIB3fzEyOcX2CCEzPfI8CNguObfv3BeUybOznMDAWi3F1jOZd09cOHNzHYEdn53Of00rVW7/3/cTumBg3dfk8vHBbzgiR64ofpCCrBBhketSUCXEif3uDhB4B9D0YurkcPZwCi7BGlIJ1JO+zs4FAKrUgL8Ht8ivoNxue0YkdZPQNEALgUhmnXE0PFMgcyb/Zf7XKdG7GiL7Cek3Ajyy7KQdq3b0BTfwnjH/udP5n8i6dbdv46Ys6yLG+UUf9ssHIRfwnWVpD7y5L3YHAoY8T62TQ0hVQx+UV1ngkkRjGGixJzED0Vkh6s1h2kJIxMqM4Ut3N702aDDSjNYdl2G7RDxBqfBUr8kLu4QKwhoNUS4/V3hFo82pNUm6HQMuvcajr83pZ/nRFdkWB5xKtVhFzXQQ/rSpULBztxw7P/wpQGf/ULwbQMSfF8J8ZRQpMuOvEc+DUjYHYWgvLgpDctNoBmggE2Kmi7GNI3ZfO3lNM63hyYfd/H3Ysy7cubefjmuzkB8rc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(1590799012)(451199015)(85182001)(9686003)(26005)(1580799009)(33656002)(38070700005)(82960400001)(38100700002)(122000001)(83380400001)(186003)(110136005)(7696005)(6506007)(2906002)(5660300002)(52536014)(66476007)(41300700001)(7416002)(8676002)(64756008)(66446008)(76116006)(66556008)(86362001)(66946007)(4326008)(478600001)(54906003)(316002)(71200400001)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TWY2b1Y3a0dIaUxtcFovUWlteXNGYXlGejFHZ24zWEovYkpPREw4d1cy?=
 =?iso-2022-jp?B?RXBhVXI5dWY0N2dibzBJWWE5bk1COFJQS00rZGpmRmQ5clRtYThFSEdS?=
 =?iso-2022-jp?B?bk13OERsbnJHdk1iSnVoUk93Q1cwcUNrbWZrcG1weXNJN3VxU3JncldI?=
 =?iso-2022-jp?B?eUJUMzN2RnpTa25IVURKbzRQMlF1TTA5SkRVa3JWcldPNGcrUW5WeEp4?=
 =?iso-2022-jp?B?dlViRnk5Qk96YUxwcFI4RFB5Q3RTaUkxdHNPOUcrWmFhMFI1OXRkaU5w?=
 =?iso-2022-jp?B?TG5LL1NZQlpTVkVUOUdVM0hNTER4ZDh5VFl3bjRHZXRKeS93YU1GcnNM?=
 =?iso-2022-jp?B?VEkwM2Y2UGtFdkozTTgzRGVDVTJPbExuaXZZbUI2TVdQWWwxWmxRS3B6?=
 =?iso-2022-jp?B?aU0xV1NIdzVSank5dlNNblA3UGtzOWNDVGVYdVVteWVJNjdsaHYvbEwr?=
 =?iso-2022-jp?B?aWVxSG05WVNRZVFmY0hpRmdONFNpUFhLNXlxeUI4WjRSSGgvUmpQVTAx?=
 =?iso-2022-jp?B?Z2NBanRCbjhnY2ZYVmZHekdSMWFraDlaNHpxTUJGKzY1dVhydEZCdkNl?=
 =?iso-2022-jp?B?RHVzS1psZnBGckVBcnBzMGR3K01vcHpkR3hvQmQzbHhNYjRER29wRmlL?=
 =?iso-2022-jp?B?aGhDOU5OR1BJSDRuR0hmRWJVL3RNdWkrQklSUzZtdmdzVlNpeDFYSW9H?=
 =?iso-2022-jp?B?aUlRbitSd2Z6LzRYNjlseGlMRUw5NnBMUi96UnpjNWtCN3dGR0pzYmVB?=
 =?iso-2022-jp?B?WjNRVG1DMXFER1pjZUQ3WUduVFZMZzRBaUZvcllKd2VKeFZsaXoza01w?=
 =?iso-2022-jp?B?a0w2czNXYzFnTmFQWm1BTitYcjcvMUc1NmxDVDBxWmg4cEtqVmdLSFZs?=
 =?iso-2022-jp?B?WjhPVVVCK3VoOCszSEZ6eE1OWm10azlpU3doNTVHajMwL2ozS0RsNnda?=
 =?iso-2022-jp?B?YjNqbjA0NjZSdjFVMDJHRFZabFRGVFRNcDl6WkNBVjYvV3lqdVBJeUZ3?=
 =?iso-2022-jp?B?eUZoczd4dG5aQ2piUSs4R0pYNTh6ekt5OWVqeXVuK1lXbGUxcXQ2U25J?=
 =?iso-2022-jp?B?cjI1UlpSUFhienJLOGN4S08xRXhTdTFEQmZZT2FmbENIRlhTeU13WnJS?=
 =?iso-2022-jp?B?Snl1ZFR2RVM4dkdwNmFTRkY2TkVHa295YVpzSWM1aWtmMnN2bWVQTmFs?=
 =?iso-2022-jp?B?Q3hrc0hDbCtqZ1cvYldQR2FaQVFPMDlUR3lyK01sdXFRbHF2K1RMcVJl?=
 =?iso-2022-jp?B?UUFtcFl3RERNS1F5OGZOZmJaRXZoVXZjVnppaFdaQ0tWL1NRaEkrVTVs?=
 =?iso-2022-jp?B?aGZrQWN3RmRGUU11Ry9zOGNSYVVteS8rcXpVWTRFWEE4KzFhd1E3WndJ?=
 =?iso-2022-jp?B?L3phOWROUkFsQnRnYUJaWHB3ckl0TndUZC82QmJyUkR1WmMrdHc1NTJv?=
 =?iso-2022-jp?B?M2FxdWl5a1JOYk5DbnFqSnhTTVdtcU9HODJ6ZnlYRWdiN2JOQlh0em0z?=
 =?iso-2022-jp?B?bE0yNk54VG1vUWt5MmFqYnFKd0pibnhTbFlmQ1J0K1crWmUyaEttQ2tm?=
 =?iso-2022-jp?B?bkZ1czE2MlZtM0Q2MytpOHVoWTQ4K05KZmJGR2JpZnBnd2htN1BKOWIx?=
 =?iso-2022-jp?B?UnY4OUJOR29lUFNQOUxic01YLy85S09WZHB4Q1VtaFVrVmVBYjJZTm5m?=
 =?iso-2022-jp?B?YThrMjA3cC9jNFhPMURXODZ0S2ZpWnIzRUYrT0FDRWFjWTF0em1GZksw?=
 =?iso-2022-jp?B?SVNDZHFDS1diNVdQTktVdmRibDJsLzFPRThJYkdCc2F3eGlkakRDb0Zh?=
 =?iso-2022-jp?B?clV1ZFZoTEhqT0R1bGhaRWo3dmJqRWo3RWZBVDlIQkVvdldvcGY1WEs2?=
 =?iso-2022-jp?B?WEQzb25aVFlnY0UzUmp0c2JOVVVsYkFxTy9EVVBLUXlCdkRTajA0bm1E?=
 =?iso-2022-jp?B?SjdlbkFNWEZ4Rnk0ZVZLT091YnB5M2ZNV0tGY21LelBWSEdwVXk1MmhO?=
 =?iso-2022-jp?B?dW9ubFkrUFRBRHFYZWxVK0tsTkNkMUp1Q3huQkRNS3Z5ckxBaXZVT2d4?=
 =?iso-2022-jp?B?Sld3T1lLL2pIU3NWaEJJQjF4N0lKYy9mdkZSVVYyTkl2NWxjditVbWhC?=
 =?iso-2022-jp?B?VHNQeE5KMUUzRHQ4YXZqSk9QMnBCT0R4S0JralZSSk1SVXRLemVHRWRL?=
 =?iso-2022-jp?B?S25RN3A0eWh3dVRFemhNTHQxK3hsaC9HYm1ZQ0EwRnZ3ZFZsZEZHd1Ns?=
 =?iso-2022-jp?B?TUlSaUdGRUpBMjNsdXowZnh4M1VTa1ZSUVNxUThXOCtPK1dsS1NZSTBw?=
 =?iso-2022-jp?B?cmpxUzJRSWowUzR1b254RHl4ckduMnpFSWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d926477-655f-4e62-a9d7-08dac3095910
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 10:50:14.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huX0d4oqy2Ba1ZvsGJm02nzVEybL6riD9FpngSf/jP6YoG3SACUXEl5Cn198U1NNLJHwVQt813LJCkYg38DCPp8VUO7WtEtarIVoW3saOX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8494
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> RMID are allocated for each monitor or control group directory, because e=
ach of
> these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>=20
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the closid is known. An RMID allocation for one CLOSID ma=
y fail,
> whereas another may succeed depending on how many monitor groups a
> control group has.
>=20
> The RMID allocation needs to move to be after the CLOSID has been allocat=
ed.
>=20
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its calle=
r, after
> the mkdir_rdt_prepare() call. This allows the RMID allocator to know the
> CLOSID.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29
> +++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 841294ad6263..c67083a8a5f5 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2892,6 +2892,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)
>  	return 0;
>  }
>=20
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp) {
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->closid, rgrp->mon.rmid); }
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -2957,10 +2963,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>  		goto out_destroy;
>  	}
>=20
> -	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
>  	kernfs_activate(kn);
>=20
>  	/*
> @@ -2981,7 +2983,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)  =
{
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->closid, rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>=20
> @@ -3003,12 +3004,19 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
> *parent_kn,
>  	prgrp =3D rdtgrp->mon.parent;
>  	rdtgrp->closid =3D prgrp->closid;
>=20
> +	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Add the rdtgrp to the list of rdtgrps the parent
>  	 * ctrl_mon group has to track.
>  	 */
>  	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>=20
> +out_unlock:
>  	rdtgroup_kn_unlock(parent_kn);

Is there any case that a lock is not unlocked here?

Best regards,
Shaopeng Tan

>  	return ret;
>  }
> @@ -3039,10 +3047,15 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>  	ret =3D 0;
>=20
>  	rdtgrp->closid =3D closid;
> -	ret =3D rdtgroup_init_alloc(rdtgrp);
> -	if (ret < 0)
> +
> +	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
>  		goto out_id_free;
>=20
> +	ret =3D rdtgroup_init_alloc(rdtgrp);
> +	if (ret < 0)
> +		goto out_rmid_free;
> +
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>=20
>  	if (rdt_mon_capable) {
> @@ -3061,6 +3074,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>=20
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
> +out_rmid_free:
> +	mkdir_rdt_prepare_rmid_free(rdtgrp);
>  out_id_free:
>  	closid_free(closid);
>  out_common_fail:
> --
> 2.30.2

