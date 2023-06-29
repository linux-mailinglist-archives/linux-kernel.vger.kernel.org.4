Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509BB7421ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjF2ITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjF2ISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:18:15 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411973A89;
        Thu, 29 Jun 2023 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1688026439; x=1719562439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jDVOXRc+3Dd6X038rvtfVGku3OOcjgjW7ttiIUTXL0=;
  b=Mcb4ktzlGhPRpAt4JyMcERlSkdfCpE7zUJ1B7Bi0svRuyhYxXGLEZfKG
   azYWgCEI8zr/5gW6LYSQ1NL6YsH8ccEIXioLk0CCu9lQajlKoFZNkYsKE
   oVDibv1RYjr/2oetXZEbc5sAIkmwJRXoMF0hUcDYwn/rkRYLZuSmYEzlc
   XrRFuEs1NejANBxr/Ue+ils4TfrEspzpHnV8rDtk00amTdhLjhxjIAU+B
   lQwjOgfgXw/e4cTjwg9fqlVmxIan24iyKMq2dTH0Kc7Ms8iTXkXgyniTS
   7ZvC0lEzJ8tETdi3bcc1S6wBJheIdKhyY+sRnA052xup/zu9RlA8EGI1B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="88471552"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; 
   d="scan'208";a="88471552"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:13:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyQkZcgiXOMxqP1HU4pnCqhCiCfNmm97oqbh4bqhgDDvUgpCJXVNNcKSmy8g5cJ/b96J9TIBMSbaaUTxsfyEpp1JrRFlAGYBLFBu5ur8KrcavvUgfDDU6hvkDmjoty+t5uy2oby6zS7jr7kn6eJILUSjSA4m+syY6tkAUbDRMJUq2m6RkNyA2mKWlUgJjxwYpa3SHfM7hG3IElj/XYe8WZVSfKEKhHiKibfoFOdHi0VeB/vgyQZ8c61O6zTrU2Bt61Ils74eKajcAMHWPY4s009cm+V4z1MlGGDo2zhepqILjlMaJ0O6+KpImV1KEQcaWYLOKLqjcRcwT0FowgnWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jDVOXRc+3Dd6X038rvtfVGku3OOcjgjW7ttiIUTXL0=;
 b=YRp4wFv3DyDx01LRM0NkLzUc0CwEN1UD4+vBdPhOK3zZXld1TQLN3CzqDJVMn/EMqhRFdi+Q2Lm2/DKYHgzITjFon1gSz+dBTvpkBo8jBbl+59SFcOxtNsBpOd7FRcdQ6nmverBJwxCeqhOlfBPOUHkyqarrzwGfCsmWPDpnV8Cdh57WL3Qan0D7a8x/H5U+a09gfATgyeymLMdzDbepJrDJIssUB0pzmVE9XXtJjCtOVNMRIZuUTXa1HlG7oJ5zdru7mpQNADGm/uH4+qVlPpg+WYJH+OKB9TcorZaVjfxQCiIEM3X5nuqIfHx4iszt3PQmHG+1st1v/txRz3F6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY1PR01MB10803.jpnprd01.prod.outlook.com (2603:1096:400:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Thu, 29 Jun
 2023 08:13:50 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:13:50 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Topic: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Index: AQHZpGeATIPi5YBzi0GOCDuOp24i0q+heQwA
Date:   Thu, 29 Jun 2023 08:13:50 +0000
Message-ID: <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
In-Reply-To: <20230621174006.42533-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-29T08:08:47Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=b73e44bf-f1e5-48f7-90bc-39d98fdc2335;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 2d82721919c149aa869dc96515442901
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY1PR01MB10803:EE_
x-ms-office365-filtering-correlation-id: cbbf3e8f-12af-476d-2b36-08db7878c524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: foBHsYCmIn8jSyWl2GzYtgAvcRU2rQ5/mf4k8ygd+PYkFpvsY7JBzKp/fUzVwER28eSsevrGflfgg9z/gbhYzqYwSQgKRSSuYdqo9KyIgYAut3Gj7XCFTvz3tJP8KP82SfGqj88n9w2L4JVcSuIEsT2aLbc7sZ10x5EvVb3vp2puwVmHh9mwKYQ1g8J1OcpwLy+4dvgWi2XafkmtQx/zQ+QHp3w17sS3Hjm++9AV5Z3VKKhf1sqvR7mY321AUIqOpIMcqGPJM/gpLc4GANRu5/Y0r7PuT2j2dHRxLexgFwKmBpES3DkYa96jSTXrQz18WN1xACuAUFQ06s6wO3MA89YMpWXQ6O399uWtVQicM4KvT1jM83Za365eZjm4z5O53qVy/0y9dBMwh0BhJQqxuZcaQgrCV1eFkRub3MnGkZQgKvF6d35aAfpwNCewKzXbeMk75Zc3tVgdHWcd6wGxxNd7b1eZ809YLZu3zs85FuWSHGgJfdaGgii4w/QN+1CDTEcAfF4TAIiks+ijFo7sD8k1TuONUGt4fRjUBdfaUReI/t1E7YVNjYH6RApYcmkpfc5ec+YMcObBtBkd2O2+6Jc/pg133U23b0IVMPhuru+SWM9XMOgutDBy9Q0c7RkmVFPD6PFzS4Fnf7x3IldYjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(1590799018)(4744005)(7696005)(122000001)(71200400001)(186003)(26005)(9686003)(38100700002)(82960400001)(38070700005)(86362001)(110136005)(41300700001)(6506007)(54906003)(55016003)(2906002)(478600001)(316002)(33656002)(66446008)(66946007)(64756008)(66556008)(85182001)(4326008)(76116006)(8676002)(8936002)(66476007)(7416002)(5660300002)(52536014)(1580799015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bEFmczhHRFNlWHZMK1lhSkRCc2RBc3FuTlByUHBOa1BSV01lSnlBWi96?=
 =?iso-2022-jp?B?OTMrK2JXTVpCSUxTSlorN0FiSWdzR0FWK0ozcWNZRXlYQUZBYUhnSW5s?=
 =?iso-2022-jp?B?emVQYzVEVVNQWklxUkJNR3pyNHdsSVdKc1ZxdHJGSjhweUJEeXRKdThE?=
 =?iso-2022-jp?B?SlB1ckpzaHo1djJSdHA5dHdleXY2Nmg3ME1Nb3lyUytuWUVMY3JhbnFZ?=
 =?iso-2022-jp?B?NEltQ3BTeEdJeGVVZEt6a1hjR0VEUVJVd3ZibnhNVS9QS1EyaDhhZHZp?=
 =?iso-2022-jp?B?TUVJcnJUZXF1WDNreE5QOFdiMU9ZYzdKRTQvNVpCa09DNTVWNkt5bk9R?=
 =?iso-2022-jp?B?RmR2d1dJTStlQlJDZUp1NTVDVEI2M01tOUZRcWE5RGFuTGNSSjU1d1Va?=
 =?iso-2022-jp?B?N2x3VXMxNWlISDlEbnVsVVNybG5EL0szaTZDWGs2WWVXUW9LOUpKSlFn?=
 =?iso-2022-jp?B?djBhdW9ldVNvSG0xWjhDYXRESU5oRW1hTTBnRVNkaHloZ2hPdDcrZmZT?=
 =?iso-2022-jp?B?VjEyKzgwSmFLWVJwOTRkUEQxRHplL2ZwNjZPbzlJV2N3VDFiSy9HemUx?=
 =?iso-2022-jp?B?U29DZ014a1o1THQzWlkyQUNDSUVnb2xvWjFSTlJTc1FqeENpY3BYOUZT?=
 =?iso-2022-jp?B?cy9UeEpaRVdWNm54aVlFKytMb0lYWTlyNDBFRkNmSlNYZG9rTlRBQVpP?=
 =?iso-2022-jp?B?NTYvd1gyOGd2akZPTXFKQ0x5WThmZW85TFRFQ0IxR3NiTjUzV2JUWWta?=
 =?iso-2022-jp?B?UE5pTi93Q3d1M2xObXJqMi80TzVMTWFYVWlzSnlNU0owY1BhdzdVVVJ0?=
 =?iso-2022-jp?B?c0ZVbHYwM2FHdkhCRXNBQ1dhcWVpbVB4dEl6c2o2UHNjMG9rbDZiS1FG?=
 =?iso-2022-jp?B?WWczcXZJTjlZUXdJVWZ0Z2pscnpBRGM1K2kzencrQ3hNNDQxemJ1VVZK?=
 =?iso-2022-jp?B?WE9WRW1xWGJyYnZQNnZpL2s3dmt2YTBNT2ozaW5ycDdqTnAvbjMxNit0?=
 =?iso-2022-jp?B?VWp1QnFyMXdya0F2L0JrSUtyeWxneHdzVGxiTWhsd1VwSitVb3FMMlNO?=
 =?iso-2022-jp?B?d0JDZ25zc1A4bWxpbXJWSDlodE4vNnNNMExhQmcwK0VEd1dlY0Y5R3hD?=
 =?iso-2022-jp?B?SXhidVFtNlkreStjWmN6VkE1Y1RBQjVZZjFXZUVjWTZrT3IzTkR0RkJp?=
 =?iso-2022-jp?B?OFVMSml0NEhYazR2dFNnOWtwVndzdUVMZDIzZ0U2REYvbnVYR2FCbmRE?=
 =?iso-2022-jp?B?eEZtV2puRlk5SGhuYmlGZ0gydFEwaWlSQ281YzlKUkFGYVR0OUp3eUhC?=
 =?iso-2022-jp?B?YnlIZkVBOXFNWkFUN2xPSUxMa091Q2tWQytPWWVLbXMrSmpoZmlkUGpM?=
 =?iso-2022-jp?B?NzlmM2xhc0pidnkzRko0bjVTTkQ3U2FHMGwxOTdxZS9LdmhMZWFKblJk?=
 =?iso-2022-jp?B?ZGNRZngyTThMMUY1WlAvaytuVUdjK0NTUGpYei9mWXhhTGRGYURrdHVi?=
 =?iso-2022-jp?B?dndST25RN2dQNC9GTGp2RnJTdjRaZG5DelJmTzRLRHdFOXhmOHhmWFl0?=
 =?iso-2022-jp?B?L2dGOEpVWUNXZ3FsMHB2NHQ0NEZOWTFoOWxXT0s1RnhpVEhzd2JCS0Nm?=
 =?iso-2022-jp?B?UG1TdjFITmI1aHM2WnNJbjJHYW9uSHdmWnZ5c05ybVlNakZ5cnFHWU5z?=
 =?iso-2022-jp?B?NEVGWng0a20wZUxyTDc3SERFL3ZxbElVeWk4dmFweEpzYUcwMUVobjFF?=
 =?iso-2022-jp?B?ak4xVm8xdUl1ZHU5bExGVTlBYTZzQXdtWUVqS092OVNNekRSRnJXTmJJ?=
 =?iso-2022-jp?B?VVRlbnFmZWlNQktkUXV2QXlBU2FRZUdrM21wYTVSWWVGN3lWb0lnMkR6?=
 =?iso-2022-jp?B?eEZkbFg1VmxrNzBPQUU1b2xsSmtZQ0NGV2R0cjV0d05FRFhTMlJHTjFN?=
 =?iso-2022-jp?B?eG96RVJQZGhWZXo0dzJvZlRqb0F0T0pXQXN2d0xjTWFQQnd4S1o5SzFw?=
 =?iso-2022-jp?B?Rk9EcmhtdktNTnhlQ3h3VWQ2OGk2WUEwUnQ1Nk50ZUcxWEt3MFVaWXBD?=
 =?iso-2022-jp?B?bmJqMklZRU9pRjNoRHNQQ0toeVQvNk44VjVOOHVRaWJxT1NsaHdmNkxX?=
 =?iso-2022-jp?B?bWFOVVpxUUw4UzhyUDVtRHNkb3pROWlVVDdWeGJNM1FESk9qUXRLWGZI?=
 =?iso-2022-jp?B?cGVwSHdYcnRVQVE3SThxQzhZR0FKdjJ6TER4cVc3NDY2ajNxVGJ2TkNz?=
 =?iso-2022-jp?B?eHhiRFI1VnpRM21keVpiZGpiMjZjUkJ1M0xaMlluMGg0Si96WEdvdlI4?=
 =?iso-2022-jp?B?V21nYzAwejB2M0t0eTBmYkFrVFA3cUpJa2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?NjJsQmRlRURvczExK28wZG4rQTFxdlg2THZxbXVPT1hpdFpxRE14Ukc2?=
 =?iso-2022-jp?B?ODJUN0lDck5YTjhGZm5lQ01ac3dlM2x2M0YyTVI4WGN1UGVEWFVqdDYy?=
 =?iso-2022-jp?B?L1hXaCtvSTQrQ1NlSHQwZzlTby81ZkUrM3RFeVB1Y0swY2xIbkdITHc1?=
 =?iso-2022-jp?B?YllVVjBkcHBIQkRKVmFEd0tOdUVVTldKV28wUG1vRWFFRnBxdFhKb2w4?=
 =?iso-2022-jp?B?SzFaK0prbG1yanowNzJ5TkxkSlMva0dscGhINWdZYVlEbUJlcWJrNE01?=
 =?iso-2022-jp?B?OEhFdlFJdHFodVdITUJvNXlyVG51SEVmd1JBZ0E3Z25vYUNvUkFvMVUw?=
 =?iso-2022-jp?B?cnN4VmpGdDY0ZGpURFRPcXhQTUw3bVpuUTNJL2J2UDFvdXhlT3lzeE5T?=
 =?iso-2022-jp?B?TG8rL0R2ckR1ajRCcGtTZUNSREhGR2NuM3F3bXcybS8rZDNJc3dGeFpy?=
 =?iso-2022-jp?B?WFJRYmFsMTlFN2JzejQ1VEhVWlFESVNjb3IxWkVuTkpkVzMwWFVNRkpM?=
 =?iso-2022-jp?B?WkYvdkF0VWswQk50aTYrd291ZlBPMyt2cjFQV09pdjhoV041YjluNEdw?=
 =?iso-2022-jp?B?bWYwU0JHT2dLQThxZEJ5bXNFaFI0czJPaGZlOS9jeXFVVUdIRERabW54?=
 =?iso-2022-jp?B?dGk1UDR3L3lyOFhIMnlzaGM1eDBVRDdoNE43R1U3K1cyQnAzUFM5YjhH?=
 =?iso-2022-jp?B?VFRYZTN1dUxET0hZbi9ZRTVKYkxGemRLSStPR2YxZE9WaENuWXpIamRu?=
 =?iso-2022-jp?B?NWl3bUdqbjJOY1JaME9NdHpLNzlOamU2WVBkSEhSOHZqRlhzMkV6RTVu?=
 =?iso-2022-jp?B?QkI3aXVpanJHeHpXRkpQN3NJUjQ4OUtianZpeWNkNkkxelFzSVd3a2FT?=
 =?iso-2022-jp?B?b3RQK3BPTlpyYkhFbHBaTUI0ejZlb0hhMXZGUGJPU3Fadm5GNVYwNlA1?=
 =?iso-2022-jp?B?d3lFZTJTVlBHSmlCVEdnK2YrVGs1YytVSkxTVWlrY1dncjdPWFlsUmd4?=
 =?iso-2022-jp?B?U2xSYTVsZ1hJbEdQLzRTQjNxeGpnK3NaTzFaaE5NRURnRXNaWE1kWVpu?=
 =?iso-2022-jp?B?REVva2hkNTFZVERkY2w0QmNMVi9wOW1kTmFzb3JwWHJhbS9rYTNKaWVm?=
 =?iso-2022-jp?B?ZXRTYzFjMUpmL2krSjdFNTBGeGJRUFhteTQ1MEVMWWhGWVVBR2tjaW1i?=
 =?iso-2022-jp?B?NUduSmptQnpCblRON0kweC94WDZaUThpb2YvSGYrN25hVTk3b2tqb1pj?=
 =?iso-2022-jp?B?NnpHRUc5eDZxS1pmYlpHN0d2TG5kK1lxRThpQkFFN242U2crcVJoY0I1?=
 =?iso-2022-jp?B?dXFKZzZjenJLcm9VZTZPT2N6dnNlRmd0VlhIVWZhWkk4ZG9sdFhZdHJi?=
 =?iso-2022-jp?B?RUtsNXZNbkcydWdTWmdtblU3YU5SZS9mSSsrK1h1bHlRQU8xNkJJRUxZ?=
 =?iso-2022-jp?B?dEdJREMwVmx3UlZjTHNycA==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbf3e8f-12af-476d-2b36-08db7878c524
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 08:13:50.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwzokKI8Ilpoid2DL87VINkV+xTCg6Zi1DrliLKirTi95/MgSGlanBFWDyO2+/hRT90o4P/iUkFhmz5Miei+ADxVv15NGXhaEQwGlyCbJbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10803
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tony,

I ran selftest/resctrl in my environment,
CMT test failed when I enabled Sub-NUMA Cluster.

I don't know why it failed yet,
I paste the test results below.

Processer in my environment:
Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz

$ sudo make -C tools/testing/selftests/resctrl run_tests
# # Starting CMT test ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Cache size :25952256
# # Benchmark PID: 8638
# # Writing benchmark parameters to resctrl FS
# # Checking for pass/fail
# # Fail: Check cache miss rate within 15%
# # Percent diff=3D21
# # Number of bits: 5
# # Average LLC val: 9216000
# # Cache span (bytes): 11796480
# not ok 3 CMT: test

Best regards,
Shaopeng TAN
