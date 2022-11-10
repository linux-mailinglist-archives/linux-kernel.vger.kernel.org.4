Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76167624064
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiKJKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKJKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:51:57 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132862CE3F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668077516; x=1699613516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SUm5Irc6DjKKXl7EH+JYWfNkKIj66ZlkCpypTR1CkDc=;
  b=JFOZyLZcbFt9YsxkHByhKAX5oXys2/VtPMoik9XL/hZHwd870PFa7Pwh
   3H4SV8JnwnQKeaCJrJjKpLMsqNgmWY3Av6Vr4Aaphm+1m73c+O45LuuHb
   PhwwvNsMv8ga43zhCUNN13Sf+Jo17fmdamhZGKlFNhbqmbDU6czVO8szN
   fZoWUbPHtUHCQL8kD/JbRpl1hlh8by1vRvDPQlRGmAl1RB4SFfJZbBeQu
   NkPKjxBkHag5HJAlzovb7VxII966ZWMW2i/xglAdt5cO/jLS5AVpxmHY3
   LzZSGqD5CpN6oDN5hDARv8ReeBogvTq2VvduKGz99PIlS3xe7+19+s1jp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="69862293"
X-IronPort-AV: E=Sophos;i="5.96,153,1665414000"; 
   d="scan'208";a="69862293"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:51:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJUSFi6yea15DoozanHFpWrFSPBiSQeb3SudAgwljFJjrsBKghy5//sytUjPv/9n9r8awgwSG+2UQmhC5H7SSATRHZkTM2r4LFDfvuljO4RUTsk9ZFQw8+vNM82fRDFZ33SzdnJanv/YAzJnK4aYtn2hKJfveYHRe7AKiP7XYPO2Av3+WEnmmu7SC37rCUFL1Qz9yILT6Z0DGzFwf7puYd5rMmPlGkGMstfiGNIo63ZcRjULW3+Q1s6zB5Cp3iUn2uv2/LRVvQVdYErrk/cKxDjxCI3WDunP5gkLm8grr8EA6DOabNqGmlI7pwu6c5fBSQBTouTWD1Q8XqTG0ybm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9x89yOR9qpp3b0I9Hjc5niEYG/TJUjtd8Ud3p+4ei0=;
 b=i2AbjWKPZlNgVp+RRWl5zfkb9ZI9i33Cl0GpC6E1ZXpkQRn6SXeo7ezQD0FQImbtf7lRnXaDdtk10ewNXdZlK/dtgy7gCcqdAxsQRD+/IUcCpYd+7KInXNCkPUOqqlQ+Uhm37OR/FMOGcgmD1liqbDcU3cKJVeVjutY7KyREgkR5GmVBn/Q0d65mYeNT8ak5QqulKfx+5up0r5q7+nZEIEAp+MdBzE6k8O7vFPxqKaWDhde5pkK50PK850hjfs9CbybCQy9i5Cysc2RVWT4nKrjIrb5orhPcZAk/L4gL1ijspKp6OoKPBrh41n29ZdmP3qiW5C3tdc4i6lElOYWKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYYPR01MB10611.jpnprd01.prod.outlook.com (2603:1096:400:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 10:51:45 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 10:51:45 +0000
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
Subject: RE: [PATCH 14/18] x86/resctrl: Add helpers for system wide mon/alloc
 capable
Thread-Topic: [PATCH 14/18] x86/resctrl: Add helpers for system wide mon/alloc
 capable
Thread-Index: AQHY5U7gujOL3jgaUkWCz5+5INwClq44GD8Q
Date:   Thu, 10 Nov 2022 10:51:45 +0000
Message-ID: <TYAPR01MB633026AE84D35BCB92211C4B8B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-15-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-15-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-10T10:44:38Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=da0ccdef-9c0d-4dc9-be01-b29b9d6d9015;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 2082d442a63f44bfb8ecac12e1f89a5e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYYPR01MB10611:EE_
x-ms-office365-filtering-correlation-id: 65487f93-c9c1-406e-cfe0-08dac3098f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJArIrvPgiP9MbTBGkbmJH++hcWSDitB08jOekKFtgMCjyBnWQ0sHf1zIFfTv7dUy7TSlgxGEbaxRFRfcc4GVIbUfpT4S/QF/UzWASYCoGdAb033HX9tQn2IAF54F4KGMdWPBm4Klus+PwAC3+DHEG8LgyoExi5hgRjyUVh+2zV34NT3jabpMgooq2CioUctTISw0YIlJX7Uox/+4JXaS6Rzm7upGusfaWo/+km35xhKlIRyFJ7vJzFG6W8s/vAHZg4irMmhwMrzH7srqUq82gPL97elo1rZFlVfYcS6WkgRGgrJ4BMXksQ9mf0xYVLi/gGlwuzAtOJcSuugDt9pvfOKb/l6q5cuyZbF28dt2XPM+siV2qcEzbc2kNiizJXcjnQpKSRV+74rNbK37hweg4r3RmvaH/0SIp0cTvbjqL7PmMpsVB3L8r5YyfSmjhSWDmbnvHnO4+BuKDjB+6WFO58z4MFaBGdOPMGfradpedD0QLPNs/KNc5aUUnS/rvrawRnSyxJIoxVGm0pEPw0+l9Rv6/W7VHtNZjSu6FedLLaDwUWgKs7FYuSk3uCuJ72GQ6lViXkOMMmYXFBUO+TewhqiWoAZiuYVLdQe0X8iWT83RyqcvJu/8Nw5RkOQtGmWS8D6o0J8rwnE2ufb5GbC7ZavxoDzBHM9L7vrGWZffiK5CXz6RW3xXX2cFowxEEeqE8sSOPlPCAA+eK4OMZf5/+zff7jAtJpym5N6k/oOv43beaG9N1L2r78idpNZctGd/9wQ2mHZ0qRIChQZYPqyfXjSvBTEiD7gq1zvuswd5tA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(1590799012)(1580799009)(33656002)(2906002)(4326008)(6506007)(7696005)(38070700005)(122000001)(38100700002)(86362001)(186003)(85182001)(52536014)(5660300002)(7416002)(41300700001)(83380400001)(316002)(66476007)(66556008)(66946007)(76116006)(110136005)(54906003)(66446008)(71200400001)(478600001)(26005)(9686003)(55016003)(8936002)(8676002)(82960400001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OE91dEdYaEFRUm5kRUhNaVhYS1Y2RWFwTklBaEtDRWR1Y2FwOURtWGQz?=
 =?iso-2022-jp?B?Q0dMQk5WeTU0Q0w5bnQ3NDNFZGcvcWhTYWJwcC9mT2xmcEI2a25lR2hk?=
 =?iso-2022-jp?B?Zmk3WlovL0I1Z3YzQ1NjSVFHTzBHSVEySFlFVUpJMDZEajk5a1N0RGRC?=
 =?iso-2022-jp?B?TWVZaVZBMWhpMTdYQk9RUEFNd2V0L3F0SzFOdE8xL2FLb0M0c0NTcWpi?=
 =?iso-2022-jp?B?RytqZU52Ym03L09OOHZnRktZMWxyQW8rWVBkMUZmcmRxTmU5Y1BlMlRz?=
 =?iso-2022-jp?B?eXZyUUxTUXY0VWpZU2FreWxXbUFJOUcvaDcycEdLUGNscHFFbzdNQTVu?=
 =?iso-2022-jp?B?MnlqZWZLQWdNclE2cmljZWdpdm1BWjNnYXJIOU0xYStYckl4bnlmQ29w?=
 =?iso-2022-jp?B?WU5DejZZRHBDd0hUaUpFV2FvU3FnRDRVS1ZOTnZMM0Uzc0x2VTAyZm41?=
 =?iso-2022-jp?B?NkVtNGtQeUxHdGJETWlUTGoxdUZzbzI5eWlqZWovazhiYm8yRVg3L3dX?=
 =?iso-2022-jp?B?ZnR0L2dVaFAvdkprWnJXbDVHQ2FNamZ0YWJ6Q1BPS0NtQnpGbStPRHlp?=
 =?iso-2022-jp?B?dlYzR3ZjS2lhM3lGd1F1ZTVQNlRqUVpmWjVnZlFRNktSV0JDTHM4Nlkz?=
 =?iso-2022-jp?B?VDhqL3hCcUZXV1BGemVuSGI5TjBreW8zYjBTSG1aMW5XT1RnRWVNSmF0?=
 =?iso-2022-jp?B?MEFqOW5iNlBrd1lpbW9HWnlUdEZiR1pMUnVrR2wrQnZZN3VOeTZCMEI4?=
 =?iso-2022-jp?B?T2kyK0RJWlpmczlQeGNxRlZURHZZbXA3S1RIUnpnQlllVzRsYWJyMUVn?=
 =?iso-2022-jp?B?ejR6Q0E4UWl5VzNia05icmdnRE9kS21mRXNiVWNZUDBVbFhFSUhpYjJw?=
 =?iso-2022-jp?B?VXlYalN1cnFrSHJQTysvSkNvZVlvN0M1Y1M1eVRuTktYUGh2ZDUwT2dz?=
 =?iso-2022-jp?B?T3BtZGJSdjloQkhIL3JBL3R1aUo3SFZFM3BzZ1FqcndSSjlwOHh3eVc4?=
 =?iso-2022-jp?B?OFRodEpGRzFVYlpHdmlTM3FZUzdIazJWdlora0JXRnhPa2hjR1BKOGRq?=
 =?iso-2022-jp?B?aktYcTRLMjJWckVBbDFNYmdqekpINHlvbkRJR1ZoM3Y3TlpFd0NzNndr?=
 =?iso-2022-jp?B?UXA0VEplSWh5K2pwYi9sbSs4UHlwNVVIdkZ1b0tOL3pUZ0VPKzV4dE9r?=
 =?iso-2022-jp?B?Q2M2V0FZTXlJYzNUWGYzRnExWDVhRi9yblpJNys4djRDQ0F5eGtPL3A3?=
 =?iso-2022-jp?B?NERGYjV5ZEhFUUV1Z3NoWjc0VkNZRjRZKzcvYW1Pc29WcGQ5YWNlQUor?=
 =?iso-2022-jp?B?clVRR1dlTWNUTHFPZ2F2WFdOYUVRSy9RNFZTMG1jakhNR1BoRVNDUUtV?=
 =?iso-2022-jp?B?Y1BCa2RpTHpJdHBQVldXNjlwTUNreHNEZzVoNXQ0ZjR5R1NpRGo2YS9X?=
 =?iso-2022-jp?B?UkJzeEFhUDFzSitEaTRNSTRCQXZNRHBkQ2liZk9oV2R4THFqMUREd2t3?=
 =?iso-2022-jp?B?QXJEYVQ1bzZ4RVM5VWVvTXpvOVlBSUtrRWZqMGRESmsrbW1OVlc0SVBQ?=
 =?iso-2022-jp?B?SE1hcE5qS1hadWZqdUFUMVBJNDVkbjczM3E4YjdOWFZwWmVtd3pKUjlp?=
 =?iso-2022-jp?B?empzOGV1M1ZuMXBWMDBxdXNpTXVrTWRXaWNCU01ha0ZITkN3bUx6RDNy?=
 =?iso-2022-jp?B?ZFlNNWRsd3dyUlIwcDZiZXZhN1NWYkJVOVhqSmFTYUdTZ0ZJUzg5NHBw?=
 =?iso-2022-jp?B?M0NIS0YrNStwUGhCRGZFWFgwMnVGcXFEeHJGUDVNTE1xM2VPdnB1a2Y5?=
 =?iso-2022-jp?B?byt1d1VJV1BlRTRlL0V6a3BYcmR3c3RnVWpyMXI3VmxkTXd1SnVIMmFR?=
 =?iso-2022-jp?B?d2hYbStwUC9QazRqY25JNGp5YkpvT0NMQXh3RllHRDUrSlk1bnU5eGNH?=
 =?iso-2022-jp?B?a1o3MUE4UG5UckFBRkdnQzZjeDFzU3ZqWkJudzVzOVVVM0IzREVXWGlQ?=
 =?iso-2022-jp?B?cGxLNHVMQytlaEl6VDVVcWdLWDZyQWtPKzNUQk9lTXlpT3hwaFVhY3lS?=
 =?iso-2022-jp?B?NnFJRGlMTnlHeUlBbGFLY1QwR0pPMUIxVEw3QXRlaXhVNHE4SGlGSFp6?=
 =?iso-2022-jp?B?bTFldUtEREt1c21vZHBLc2RDNU9XcEVlcVZNandERURvTTZMUVpOUjdv?=
 =?iso-2022-jp?B?THhTN0dzMjhYUkdjM0VoOTMzZEFZYlh3S1QyanpvUU00S3ZFN0NoNEhn?=
 =?iso-2022-jp?B?R0c0N05Oam9nRU9hUVBSWkMyRzJTdlpGNEd2MzlLT1pmb2xNZVRYOHlS?=
 =?iso-2022-jp?B?UlVRTzY5MU00S0N6bVlUM2JpWlMybE0veFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65487f93-c9c1-406e-cfe0-08dac3098f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 10:51:45.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHVSoRH0Z0aomz8rd9RnwDuL2aI1weu4KnUZWbk+Ua9p+QJrJ+Yn51N/rQAdjdVokS//sS31Yd5zgALShZmtRssEaHbYP4eijwCZt1AHd4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10611
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine whether a=
ny
> of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's context-=
switch
> code to determine the same thing.
>=20
> This forces another architecture to have the same static-keys.
>=20
> As the static-key is enabled based on the capable flag, and none of the
> filesystem uses of these are in the scheduler path, move the capable flag=
s
> behind helpers, and use these in the filesystem code instead of the stati=
c-key.
>=20
> After this change, only the architecture code manages and uses the static=
-keys
> to ensure __resctrl_sched_in() does not need runtime checks.
>=20
> This avoids multiple architectures having to define the same static-keys.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h            | 13 +++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 32
> +++++++++++------------
>  5 files changed, 34 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 00cffc43eb49..c404d4611f83 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -33,10 +33,18 @@ struct resctrl_pqr_state {
>=20
>  DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>=20
> +extern bool rdt_alloc_capable;
> +extern bool rdt_mon_capable;
> +
>  DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>=20
> +static inline bool resctrl_arch_alloc_capable(void) {
> +	return rdt_alloc_capable;
> +}
> +
>  static inline void resctrl_arch_enable_alloc(void)  {
>  	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> @@ -49,6 +57,11 @@ static inline void resctrl_arch_disable_alloc(void)
>  	static_branch_dec_cpuslocked(&rdt_enable_key);
>  }
>=20
> +static inline bool resctrl_arch_mon_capable(void) {
> +	return rdt_mon_capable;
> +}
> +
>  static inline void resctrl_arch_enable_mon(void)  {
>  	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index f7ea5432cbdb..adbbfaabf70b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -98,8 +98,6 @@ struct rmid_read {
>  	int			arch_mon_ctx;
>  };
>=20
> -extern bool rdt_alloc_capable;
> -extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;  extern bool resctrl_mounted=
; diff
> --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 043fcb32435f..a9af7c56a04a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -788,7 +788,7 @@ void mbm_handle_overflow(struct work_struct *work)
>=20
>  	mutex_lock(&rdtgroup_mutex);
>=20
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>=20
>  	r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -816,7 +816,7 @@ void mbm_setup_overflow_handler(struct rdt_domain
> *dom, unsigned long delay_ms)
>  	unsigned long delay =3D msecs_to_jiffies(delay_ms);
>  	int cpu;
>=20
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
>=20
>  	cpu =3D cpumask_any(&dom->cpu_mask);
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index acebbc35331f..48f196007e9c 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -567,7 +567,7 @@ static int rdtgroup_locksetup_user_restrict(struct
> rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
>  		if (ret)
>  			goto err_cpus_list;
> @@ -614,7 +614,7 @@ static int rdtgroup_locksetup_user_restore(struct
> rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
>  		if (ret)
>  			goto err_cpus_list;
> @@ -762,7 +762,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp) =
 {
>  	int ret;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D alloc_rmid(rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Out of RMIDs\n"); diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f076e516f381..81ed458be70b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -610,13 +610,13 @@ static int __rdtgroup_move_task(struct task_struct
> *tsk,
>=20
>  static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)  =
{
> -	return (rdt_alloc_capable && (r->type =3D=3D RDTCTRL_GROUP) &&
> +	return (resctrl_arch_alloc_capable() && (r->type =3D=3D
> RDTCTRL_GROUP) &&
>  		resctrl_arch_match_closid(t, r->closid));  }
>=20
>  static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)  {
> -	return (rdt_mon_capable && (r->type =3D=3D RDTMON_GROUP) &&
> +	return (resctrl_arch_mon_capable() && (r->type =3D=3D
> RDTMON_GROUP) &&
>  		resctrl_arch_match_rmid(t, r->mon.parent->closid,
>  					r->mon.rmid));
>  }
> @@ -2221,7 +2221,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_schemata_free;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D mongroup_create_dir(rdtgroup_default.kn,
>  					  &rdtgroup_default, "mon_groups",
>  					  &kn_mongrp);
> @@ -2243,12 +2243,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_psl;
>=20
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_enable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_enable_mon();
>=20
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
>  		resctrl_mounted =3D true;
>=20
>  	if (is_mbm_enabled()) {
> @@ -2262,10 +2262,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mondata);
>  out_mongrp:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> @@ -2513,9 +2513,9 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_disable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
>  	resctrl_mounted =3D false;
>  	kernfs_kill_sb(sb);
> @@ -2890,7 +2890,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)  {
>  	int ret;
>=20
> -	if (!rdt_mon_capable)
> +	if (!resctrl_arch_mon_capable())
>  		return 0;
>=20
>  	ret =3D alloc_rmid(rdtgrp->closid);
> @@ -3076,7 +3076,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>=20
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		/*
>  		 * Create an empty mon_groups directory to hold the subset
>  		 * of tasks and cpus to monitor.
> @@ -3131,14 +3131,14 @@ static int rdtgroup_mkdir(struct kernfs_node
> *parent_kn, const char *name,
>  	 * allocation is supported, add a control and monitoring
>  	 * subdirectory
>  	 */
> -	if (rdt_alloc_capable && parent_kn =3D=3D rdtgroup_default.kn)
> +	if (resctrl_arch_alloc_capable() && parent_kn =3D=3D
> rdtgroup_default.kn)
>  		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
>=20
>  	/*
>  	 * If RDT monitoring is supported and the parent directory is a valid
>  	 * "mon_groups" directory, add a monitoring subdirectory.
>  	 */
> -	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
> +	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn,
> name))
>  		return rdtgroup_mkdir_mon(parent_kn, name, mode);
>=20
>  	return -EPERM;
> @@ -3342,7 +3342,7 @@ void resctrl_offline_domain(struct rdt_resource *r,
> struct rdt_domain *d)
>  	 * If resctrl is mounted, remove all the
>  	 * per domain monitor data directories.
>  	 */
> -	if (resctrl_mounted &&
> static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>=20
>  	if (is_mbm_enabled())
> @@ -3419,7 +3419,7 @@ int resctrl_online_domain(struct rdt_resource *r,
> struct rdt_domain *d)
>  	if (is_llc_occupancy_enabled())
>  		INIT_DELAYED_WORK(&d->cqm_limbo,
> cqm_handle_limbo);
>=20
> -	if (resctrl_mounted &&
> static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>=20
>  	return 0;

arch/x86/kernel/cpu/resctrl/rdtgroup.c
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
         if (rdt_mon_capable)=20
                 free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
I think you forgot to fix rdt_mon_capable here.
if (rdt_mon_capable) =3D> if (resctrl_arch_mon_capable())

Best regards,
Shaopeng Tan
