Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF058624065
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKJKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKJKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:52:11 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 02:52:09 PST
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C15EFA3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668077530; x=1699613530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EA+kNu4jKtieE4pu4OfllZUbSLoLDwbv18ObV7NG2Jk=;
  b=pSD2e1uMio4P2CIpc2XgBl9d5kOh0q9gh85XcC6Gw3n5gdSNQ2f/wMNs
   +KBeyCZ5nDMzFxQQOTGfyiXqFN2V5xsZsViJcs3tC911s/WMsn4sixZt/
   9RmFMA8Fb4INroidU5NAZmYpxnjRtzlVhhl/EeOk6m8ROitN4buyb+oMv
   N5+I0gX2qO5re6Jj4Ap3X5tTUw+nfgzSn8ikR6MxF7c6zfY7mqkzlV3ri
   2qQOlnNfJpzElMQq89VSxpo3xMR2CdhaRrM+5apz+xSTXn0SMXVL2fBra
   zgt2wED56qFbL1wkIqQaZ3EYhr0bZxdtyd21X3QdgmvTZbtJAswfG9Gn/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="69432567"
X-IronPort-AV: E=Sophos;i="5.96,153,1665414000"; 
   d="scan'208";a="69432567"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:50:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVThoUMM72WWG0ZVhv1Nl4suuTTd2wqFxshLs4DLUFd4W2/ReH8wSC0Lc3XvptrT3a20DzFng1xXIdcGBLxUuqjeKz3DaKDqjC9xTtmVYs+bx/0rXsfemFP1got1r1x2cr0sCYJyTI1MfTTNt1zJscfstKdxd+Tv4iQfhybJ9FTEkZzVwv6YAB1c1sstpibav1IntEfPPjbtin+pijEt8yH3rIg4dk7UJwaLXubJ7PYGiYPOIJcKJ1CZAF2zqj+qDJq6ZE3mmlB1/DqSKl3LcFXFb6+cX2GcAsMfHkuVcgOoiIrbJfp6m1Q0ETrfloMqWLemqWNFWTcqBycQRoUPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKNHyHNlZy79/FOskvaErt+sXx3Bqrz5eOgfrmKql1I=;
 b=kxor+JDerV+R6zXxsHBeiXet+krG64pysOBxDm2geXsxfUaIKHCcTkDKwPf0gJA/1Zt/CCiBTFs/avGijauNCMONhlTfVxT6GtHnEgXaCNwJdssKSP6r63SPceztnL0d7LlNPg639k6ZV66WiFasyJMM8Iqd92o5joeof+M0WmqbQzk9vMn2QJAHxZyRL4cam6vvs0C1P0AvhlbB1L02qkbC1vp0g7U/Q9RD9ffIjb/65lsHwrCR5VJj3oGSKHPSPnN1/ggaROdIi6rXlOnKGUAVOQ0z9HO4oPrBk3XtfrFVjVhHRlxA2xoKsJxADEiIWkP1bqXXVDIbpvTDEUfZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB8494.jpnprd01.prod.outlook.com (2603:1096:400:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 10:50:44 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 10:50:44 +0000
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
Subject: RE: [PATCH 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Thread-Topic: [PATCH 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Thread-Index: AQHY5U7TR0OZadtutkewykCSou3/Aq44F5vQ
Date:   Thu, 10 Nov 2022 10:50:43 +0000
Message-ID: <TYAPR01MB633047FDDF32B4A2CB5431B18B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-7-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-7-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-10T10:42:21Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d8aad486-6aac-4a57-9ae0-53e85e4797ac;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 806a30e098224a23b1587e072ae6d75b
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB8494:EE_
x-ms-office365-filtering-correlation-id: 007cb556-e231-497a-6b54-08dac3096ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hR2x+sJM9VwmtLX1GWoPRHdOGZg6CvYLAZAePNrwAwDm95nXZrXULjgvtOgZR1IZ5UpJGaBcswi54xaG58xsMBNm8FdZnc7J9WaJr/y5VaxYoFacRuAxKYBYzrf5lnlukH9hVsRzJ/RF2ZXfrKM1AufTvPIPm6rcVhPgbNxmt5g5jUF/Dm4H0iI0L8v9ixiLJeYqPwxT07LDWLor4Q49f3Lk6Bl34UM7fNxm0/qgk206GnyUBzNa/6gwt0FWu2Vy+6O0GApi19aTpomE0xzSy67sIMJ4YhMSCLjaTZQ7rrCixpLGYWcyYB1Mg12szvib82zAmDmY0GghidEL//1uAqRzO3TEwsIGL4OhtskRpRnSwCMtGBMIWus849G+5/mwY4m0XZkl1nvKEwfinKfs5ApE+I0eK6o0C1U5TSXsnpibmyb9CbM0koEUiDWATXKYvDMx1xQ7/vrAfCsZfMQdb53WmrEpgvVWl/2oCOHjMmC1dkRRZvMzAUoVSxKBmD2y1oT2W+4l0NkkMSMQbk3+3chkWhn8uE8mEw9mTdS7Dk9LXZeJEbE+s7Yt0+zWknA3GuCPXsmpOdr+VsK8pDl4EHL+fcxKlG66m53jZgCABlLVMVdfva6L+eqMvWf9ezeQbGXUs6LPzE5nLgLftajDjZhu+rqr+xTU8M/WVrz4vhbGWgLEXbh2JUm9NdzzTHtJO3aPomm3QggLSc0iSXAbHT4Q4BioI2g9YLUMv0GosoOYC65AxY1+kBObGsD2uqUjvhEsuJKzlWT3bRJWdWnTUxDoP9JQYrDSlO7W6o5/H34=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(1590799012)(451199015)(85182001)(9686003)(26005)(1580799009)(33656002)(38070700005)(82960400001)(38100700002)(122000001)(83380400001)(186003)(110136005)(7696005)(6506007)(2906002)(5660300002)(52536014)(66476007)(41300700001)(7416002)(8676002)(64756008)(66446008)(76116006)(66556008)(86362001)(66946007)(4326008)(478600001)(54906003)(316002)(71200400001)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Rzd3NTR0Mk5FWEtvUlFiM284SGRRRWEycWRPOGtIeGI1WUJ3Q3dHS2dv?=
 =?iso-2022-jp?B?SWZYeE4wRWE1SHE2ak9ZMU84VnZvUTRmUWdIbUkydWpHMFE5YTRkOU9Q?=
 =?iso-2022-jp?B?Vm55QXVNanEwVXh5TjdBbk1YOWJGTTV0Qk11YW1PRHdXTmxjNlRtcitR?=
 =?iso-2022-jp?B?VURpNGM5TEdkLzY2Z3V0WERRYXhGbzhEbHFJcE45dmg2akFRV2g0eXRn?=
 =?iso-2022-jp?B?d0xiTFVUakxhNnpPRmlITTlSL25UWDJNenBzd2VlTXFGMm4ydkhGYzRp?=
 =?iso-2022-jp?B?VURWU014ekpsZFpvN0ZwZmdUbmx6eG1hMC9xbmJ4a1FKZjh5SXVhUzA1?=
 =?iso-2022-jp?B?NE1FT2Y3VmlwUXNTNExvRlNXRnkzeUhSVmxhamNwSnpkYUdEYjFJK3dj?=
 =?iso-2022-jp?B?NFdpUWtORDBxcXYxd3NQQS9PZnRtenR4Qkd0aS9haUpQM1Y1ZXVESkYx?=
 =?iso-2022-jp?B?S2VjRElucU1mZHNKeTR3aFVKbENzUzRZZjMrMUxsVS9tOGozaTNGUTlR?=
 =?iso-2022-jp?B?YWwzbWROY25RY1lMaFlxcHRobWNaMTVXMlUrY04zbTlTQzlEeXp3a0lp?=
 =?iso-2022-jp?B?K2loRmZhWFFZOUFIUGsrRGhWSEtsSkc2OHFuSFpVczg5ZHVkUnI5b2lm?=
 =?iso-2022-jp?B?VC9pa0J4Um9xazVlWkt5OGNaVkJpTVVtS09xcmRjYTV1cXlUK3VNUjJo?=
 =?iso-2022-jp?B?SCszWWs2eGRzUjBGczVNUGpMaWtKT3VrR1pUSkxxSjJBcWphWXBIYzUz?=
 =?iso-2022-jp?B?cEhRSmVkUDNhZ1FrVnYzRG9NdXh0Zytpc3o5MkJQU2xMNUFvdVZuRy9X?=
 =?iso-2022-jp?B?aXZHdjEyNFE2alFkWDJEanRaR3BYbjBBRk5zQ0xkRDBGdWFkQnpmZlRp?=
 =?iso-2022-jp?B?RVhhVjJGN2kwUUZjYklHay81ZEF0cUY4em44MHNGWkJSb3lmTjVMRzd2?=
 =?iso-2022-jp?B?QjVsS0tEVkFCZGdwWkdDZXY4L3dPL3M2WlJvR0ljZjVzSlg0V1RsYzZO?=
 =?iso-2022-jp?B?ZVRiSXFHdnFwa1NmckJJOTloTm1DbGcwckxkVnNaREZFTDk1cnVqSk93?=
 =?iso-2022-jp?B?VnJ6ZjlKcEtxVDRsZENRUXdXWXVLRU5XczZLalJ5RkpzOFBPbXRHdFNT?=
 =?iso-2022-jp?B?cC9wMzJGa0I1OXBSY1dwOFQxQnQvSFRoZ1BwTzFMcGd4SUFYNWVlTXo2?=
 =?iso-2022-jp?B?QVpZZklYczZwZ00vTnVrQUt3VC8wVmtTQ1JxSW1nUitNcXptMm9heWs0?=
 =?iso-2022-jp?B?b2htdDZKa1pZQTdnV1Y3VW8wTXVQYmxPcTdQdWoyaWxQaU5wSGtJY1pz?=
 =?iso-2022-jp?B?R3FCTHNJWDNTdXIrQkhPZ01yTisyM3phU3JNcGxIRUxPbVprNXloS25m?=
 =?iso-2022-jp?B?QTcvYlQ2bXN2VUJGdEpRbnRMaTNvdnlNWmljaXpkWlAwTDc3ZzBoU1hS?=
 =?iso-2022-jp?B?TDhZRVhLNkF6M1QwM0E1ek9nMGcxVGZrbzdONVlBOVQ0c2d3QkdsaGl0?=
 =?iso-2022-jp?B?TFEwb1dZS0JWMkU4ekpNT1BMaDh1ekFxSnBDaXQwWmwycHpNQUNaaUlQ?=
 =?iso-2022-jp?B?NGlzV2orT0JEWFBDd01qUkxJK2VOcUZ5MWhYUGNvcEFMeHlqQ05UaTh6?=
 =?iso-2022-jp?B?dm95TEhtL3JWSTlRbStnQ2ZmYmR3cmRTaXVpL1Ixd3JaTTNyYkVnRTNR?=
 =?iso-2022-jp?B?L3d6d2VGMHh6NUFCenlPMVVwUVRqdDY0enc4ZGVoaFhQemNtRjc2eTlU?=
 =?iso-2022-jp?B?d0tmWnV3SEVsRmc0ekpmT2FqYlJBZXUzQVMxR0hQSk5NNW9xY0RZL3VW?=
 =?iso-2022-jp?B?MUdZOGFEekwwa0FTbmxHeVEvZFBsTmRyUm95SldnanY3cEwwNzhnbUIz?=
 =?iso-2022-jp?B?L2F5ZFAzSnJLUlFpTXJGMEhRc3hQcGxvMlBFMmVCeWUvMjFaOHpEN01r?=
 =?iso-2022-jp?B?VDVzNGVXVDZLTUlqNXVzS0lFWTNJdnN1dzN3OVBZN1dUUmxTR2dhSnlR?=
 =?iso-2022-jp?B?VXNjVkVRRVJNajJYcVY1bmgxSlNBWkV0VXl6VnozWWFyZ2ZDQUdTelda?=
 =?iso-2022-jp?B?VzA2TjRtcmJjN25weWVSckg3U1lsZWZkeXV3eGw5NHlmbGxVVS8xL1hY?=
 =?iso-2022-jp?B?bnpndEY1RVFEWmR6ditaTUEzV3pEWWNsc21IWG1za0sxWDNmdUJac2xa?=
 =?iso-2022-jp?B?eks3cnVBb2tiK0tIWHVNekRlUkZWSGdoWVNQSHlCb1JZWkhPM1VxeCtr?=
 =?iso-2022-jp?B?QnVqZWRFNTcxY2c5TER4MnJzVkJUaTdxdjR1angxK0lCOUV5elNqMGM3?=
 =?iso-2022-jp?B?anRPbVJWYUM4OFYwVzVOWnhTcHFweTNlM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007cb556-e231-497a-6b54-08dac3096ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 10:50:43.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zq2QDMxlg9q4bxFvIDaQN/p241Q2xNnE7yTrUUkgRvWitYGop+DJQ3FzqctAcvtCRtiUVuPUzXaDuChFUEgUhqFXGlDVZ0q8hfJdYLpNbQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8494
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can
> be used for different control groups.
>=20
> This means once a CLOSID is allocated, all its monitoring ids may still b=
e dirty,
> and held in limbo.
>=20
> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty=
 RMID
> values. This behaviour is enabled by a kconfig option selected by the
> architecture, which avoids a pointless search for x86.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 31
> ++++++++++++++++++++++++++
> arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 +++++++++------
>  3 files changed, 43 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index c8c46fe088be..faec12025a58 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -519,6 +519,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup
> *rdtgrp);  void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r); =
 int
> closids_supported(void);
> +bool resctrl_closid_is_dirty(u32 closid);
>  void closid_free(int closid);
>  int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 59da256a77fe..99854ef4dee4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -320,6 +320,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32
> closid)
>  	return ERR_PTR(-ENOSPC);
>  }
>=20
> +/**
> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for=
 this
> + *                           CLOSID.
> + * @closid: The CLOSID that is being queried.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate
> +CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator
> +will
> + * only return clean CLOSID.
> + */
> +bool resctrl_closid_is_dirty(u32 closid) {
> +	struct rmid_entry *entry;
> +	int i;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return false;
> +
> +	for (i =3D 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
> +		entry =3D &rmid_ptrs[i];
> +		if (entry->closid !=3D closid)
> +			continue;
> +
> +		if (entry->busy)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * As of now the RMIDs allocation is the same in each domain.
>   * However we keep track of which packages the RMIDs diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ac88610a6946..59f33adcf6f8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -93,7 +93,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>   * - Our choices on how to configure each resource become progressively
> more
>   *   limited as the number of resources grows.
>   */
> -static int closid_free_map;
> +static unsigned long closid_free_map;
>  static int closid_free_map_len;
>=20
>  int closids_supported(void)
> @@ -119,14 +119,18 @@ static void closid_init(void)
>=20
>  static int closid_alloc(void)
>  {
> -	u32 closid =3D ffs(closid_free_map);
> +	u32 closid;
>=20
> -	if (closid =3D=3D 0)
> -		return -ENOSPC;
> -	closid--;
> -	closid_free_map &=3D ~(1 << closid);
> +	for_each_set_bit(closid, &closid_free_map, closid_free_map_len) {
> +		if
> (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> +		    resctrl_closid_is_dirty(closid))

IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) is redundant here,
since it is also at the beginning of function resctrl_closid_is_dirty(closi=
d).

Best regards,
Shaopeng Tan

> +			continue;
>=20
> -	return closid;
> +		clear_bit(closid, &closid_free_map);
> +		return closid;
> +	}
> +
> +	return -ENOSPC;
>  }
>=20
>  void closid_free(int closid)
> --
> 2.30.2

