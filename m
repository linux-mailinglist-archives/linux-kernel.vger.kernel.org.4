Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541774212F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF2HlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF2Hk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:40:29 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563235A1;
        Thu, 29 Jun 2023 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1688024348; x=1719560348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4MmuWEnfORkrmkF3q0pT/AwZmJeN1quDpxxqMtsMdGY=;
  b=ANBdCEAJyYF9NT4p9COUvmqICD7ic3XdBLu0MjDrMhdAJMIM+DM0Ddrc
   ssREzgOpfhHvvpBV9bvHBaJ+ZYu5rAarKzis41FWyBqLXOVrJWFWCeRzT
   VX7YgRAPyyA3VlHf7bn6C8li8k8vlcm7GrH//Pol/rZjKKqoeyzfkt4zO
   21hmmxmR2oHqrYl7zt2gEy9Yab5JFNNo5q1y1tbBxWIlSemGOerQ9JNJR
   no8cZCeR1rSlBU+PKZ7VO5yaMScg5HtkUV/cpMiCuAjP0RjnySVYlCbv+
   BmnEUokpZ2K7o5zAwtPAkpsgwBpCYgKvFjkDS03qXiO9EKWxw5zaR0Etn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="88293702"
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="88293702"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 16:39:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTtAE0V7OvnYoOg3WkS4rXOx9BMT5kvB3gvNug7idN9Ca86LGsNBmCflja5+e2VaWWOwEiakATvZM4ptLXNdfws9MpTUkfxpE0Iq+vC70UuMKNai3/CUaZx+k9cU7e00HWVtgOMzIk9eR9oFn4M29MiBXYA41wyuQ5wwxUg8sKk8UvX6cqlqg/dGj3J8kdp+YOpywjZqM1nqTllHI36GPNTdX8wn5Kk+OHhpFy4tmtgDPgpQ/syIjfZ0wlZtHD+hcyig0nnAPdL30ZEi4TLcRzER5TpyZ+uxG4VfdwLcXtDRUsSnR+ulFxR+hYDvRIxWCBrKPpd7ypLoEJZLoVyhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKsA6jorout9CFOdDMBhuDA944PvnKcj1GN9zQ/q2o0=;
 b=nGUD9htxQFtExK8SGHrL2+BhFpVsF0y00A/7wuTXs4uThksGUqtCzk2YPatom4G8W103NsTeOKm+gV1bV6+wrEVxlegeyRTEA9Qkk+xYikwyjy0CV+GpfU2KgtkbZ3b4O2GrB3yLa6ABIz0EfLrxkakjWVBziBE5CrUcrenF8W4tINA/noOu6dc1FJZOFp9N1t7tkyCMtNhzYz+MUIX4frXo0UJB58nx3hHhE3eFayFhJu8DIuh5Ej/pExwLRH5nBwebuiLm8FW0RR4VVrB0/FdWHBtAfCe1Dh0AEBBtFf/P0+gRve8LeTEWETbZVFF88HHi+R9NUT10evcn8A9YIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB6210.jpnprd01.prod.outlook.com (2603:1096:604:f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 07:38:59 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 07:38:59 +0000
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
Subject: RE: [PATCH v2 5/7] x86/resctrl: Add package scoped resource
Thread-Topic: [PATCH v2 5/7] x86/resctrl: Add package scoped resource
Thread-Index: AQHZpGeD2GY+fKkTx0a8T9Xl0XMEVa+hb62Q
Date:   Thu, 29 Jun 2023 07:38:58 +0000
Message-ID: <TYAPR01MB63303189EC7C6F78549727028B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-6-tony.luck@intel.com>
In-Reply-To: <20230621174006.42533-6-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-29T07:35:14Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a595040a-6a37-407e-ae9c-a7b5a2f8d1c6;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: dc4ace1e20594b45a2a8d195f4ea49fa
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB6210:EE_
x-ms-office365-filtering-correlation-id: c1ad0dfc-e4e9-4e8f-7889-08db7873e6af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNAX2YqPjfigJytX+448XW6VcFzFAY/Oyxp59zlj8rhzu7Tws8yN8lo43qsbYgEPWOxW+nOTI/uKbBdlUZgmWJSXMnJjDfkY4B4cMQkL/Shf3qdG//uKms/lCJUTlyBdP8nT1CTbsxi+AxpHG+F0Oat0r9NpSj5EqFGU8EWevJ5vaJLQvg3ztt7XQKNd6C5TOmyHXaU2Ry92b3gacM1CU5a0eI/uElZmCiHFLSOfgo27gaJl5+7Ie6DoTAA2uSRFMaThH2GM4kI3vlGGQGKYA32KzXYfDWW4p1pd0dGHbOEqCIA88ZnTY2fnhrKz/fK71TPUSuLhgxJO8RJseEzbZ63S7nzRjlIyW1IQLXKSOGba12Aias3vkD3M6AcETZHYJBQj0p2vCf+8xtdGxcB/kNrDqSIKTUSSb2wVnvGKA4fLVBLu70Dx6o6Ux5tBw/7FR4W7SUGH6OrxMN4TZqVcjji4DeZeVBfI31OMlBHf1QTV7u9ZOlFijRGb/CL/KDgxrUs2AIqWV2GWZtJtlLbzB5EjztNtuczkYsIqUr1tlmqQdooVK8AdMHT5vDHRjigd8NunQwpdrajpN7Y+o3ksywNUddM7B2f2NJVrCCClJtPikN9WlO0Oky3gI8qMKBrn7mtDcLlWdmK2+7VKelLtdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(1590799018)(316002)(33656002)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(5660300002)(4326008)(38070700005)(478600001)(85182001)(52536014)(8676002)(8936002)(7416002)(1580799015)(55016003)(86362001)(54906003)(41300700001)(110136005)(2906002)(9686003)(7696005)(6506007)(186003)(83380400001)(38100700002)(82960400001)(71200400001)(26005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NmhZZmd3bis2KzM2VUJRNSs2T3k2V0pNd0JhNzBXSTF3K3dSSk9lNlJG?=
 =?iso-2022-jp?B?bFhXOTRhc1pvYWFFeS8xSkUzMmlZMnV4QkR1VnczQXhnQjllVXYrY3Y2?=
 =?iso-2022-jp?B?ZGt4SE5ocExvblhHQU0yWWR2eFFRZWVjKytaeVNPQ2U5RnRRZW0wamwy?=
 =?iso-2022-jp?B?Qk5TU0RobDhIQ1lVdlY4RDJzZXhHQjExOXhNOUZXWnlPQ1U4YmFzdHJj?=
 =?iso-2022-jp?B?Y0ZFejBQeXFxUng0VzJWZmtTWWthRVNJQXpJRUw4aFNuNXdUY0dOYVVa?=
 =?iso-2022-jp?B?WE9pZ09LR2ZLU1lHakRuRzdRaldZOWNZQzZxdjFRTzA2RjdjSDEvd1B2?=
 =?iso-2022-jp?B?dVdRdnV2V2JwbXQyazd6YWxlNmxkSUJwQ216WWYrTHQyNUtVcEtDZU8z?=
 =?iso-2022-jp?B?WkZxSEpwUFM4cUZlejZraHJBVk0rNGNLVGQyTkRmeXNCS0RXZjFnNnJa?=
 =?iso-2022-jp?B?UVZqenBSY05Vd0F4VVV5RkxaSGJvTXluQTd1KytNYUREcnR0bng4dGpk?=
 =?iso-2022-jp?B?YnBDYzZraEkxbkl4a0lyNE10SmhqRzlxd05INGJQZXZaUUNZSHoxS3BV?=
 =?iso-2022-jp?B?cmhuTE9kYkJianVvQlFYV056SEVmcE9vK3VYdWRJUWFYdHBRQS96NHds?=
 =?iso-2022-jp?B?YmZSWFREWVQzZlp1eFNuTjIxOVdmR0hLQmxXdzE1M3VwS09jMnBsT1Vu?=
 =?iso-2022-jp?B?SVRZYzFidVFEbGVuVkVJUy9hU3hkWXlhb1cyUUJtbXNYTWFkSW5za25D?=
 =?iso-2022-jp?B?dEFTdVdVU0lGZGlRRHJNT3RVNGpFenRETDRNWFRCSVkxcnhsbjN0YzhN?=
 =?iso-2022-jp?B?WTA5OVpXczA1dVk2RWJORXpHTEljVUs2SmpFQ3dwZ0VVTjNzOWFoMWlK?=
 =?iso-2022-jp?B?Um1wblIyeGVqT1RIWnd1U3ExZVgzUTJmU0Y4VWdrK3dKSWp5eENoZWcz?=
 =?iso-2022-jp?B?Z1VTMEpvRi82b2ZUNlF1VFJsQ2hkWStFaHFzUmVQSzRwRFUxenJTemg1?=
 =?iso-2022-jp?B?dXlyNGYzSmJkbktKRmU0MXA0YTU0QTVweFVHd2pVZGpBQndhYVNWUnJk?=
 =?iso-2022-jp?B?S0NEZDJrcDdlMThyRHYzMW9rbXpEbnNYdTFJd0tDcUZkaVhoOXREbHZw?=
 =?iso-2022-jp?B?b0dDajBXQTVDRzQrS1h0bFNoQ2xyZGQzakFWemFBRjltckRYN2ZRbTJn?=
 =?iso-2022-jp?B?NTJWNjNDVkpCVWE3blY5V0R4VDVHRDJYaEc2cWZXaERZNHZ3K3Q0WUVw?=
 =?iso-2022-jp?B?Q1FOZm5EMjd1ZXlDZVJxNlR5VVliTTB0cE55Z2hqSW83ZWFxSzR0bElC?=
 =?iso-2022-jp?B?b1cxbHVQM3I1RUpvYXNMQTV2Mi9wZ2p1eE9KdEkvRXdZNitkWW9LNkFF?=
 =?iso-2022-jp?B?STROTktpMEZZQzlXampZUURKeFc0Nk9Iazcyd3JwTld2VzhUOGlSQkVk?=
 =?iso-2022-jp?B?VElDSGNVUnpBMmRiZ0RDM2xwM1FuVVhMeEVYR2hLWUFyVVNtRXNkRUV5?=
 =?iso-2022-jp?B?THdraG82NUFxaGxlN3JLYkV0YnRoV0J1SS80MnpuNXRjakIxdW0rTlp1?=
 =?iso-2022-jp?B?WkJjTTl0Rm5ZdTVja3lrYzZtbC9qL2dKZW1uLy8yTWVkUEJhanJPekZR?=
 =?iso-2022-jp?B?dFJDaTRqYUJPSFJQZElNeVJtSmJYbmRjNGhIbElaQW1HNTRmcWh0bHdV?=
 =?iso-2022-jp?B?MHZCYkkyTlNXd2hhd2o1b3hYKzFGdlN6WndhSytESkpkbCs4MWVYUFo2?=
 =?iso-2022-jp?B?dG9DeVhQeFpoZkVIM1Q0eGx6Vlp5djNIZndiOWxDVDdXb0YvWE9sYWEy?=
 =?iso-2022-jp?B?YnUzVmhDRTZSZDlPODQwQ1V4Y3c5NXhnL0Zxa3dObTRHOUZJb01iWUI4?=
 =?iso-2022-jp?B?M3M2bjlTdzlzYVQ4VDZwQlJLYy9vbVVWSy8ybC9ZRUNoZDZnd1o0ZDRP?=
 =?iso-2022-jp?B?NnJDdGI2SUVIVWxiUGV2MllnVFJiR2NaUjlTaC9zZ0t4WDJoWkUrMGJ2?=
 =?iso-2022-jp?B?WXg3NmlhZWNzTFk4WHh4WlU5OVV2QmhuS3F5Q2piQWpQV3NIL2dNV1pF?=
 =?iso-2022-jp?B?M1VLTUt1VDFEdS9hMWVzaEJZQ2dVQ25HMVZDNHRyVUF6NzRFTjlyMmlk?=
 =?iso-2022-jp?B?NVNpUjE4UmJodW1mclhOcWVtYVR2U2ZFQk1zY21BT2ozM2VtTkpvRTE2?=
 =?iso-2022-jp?B?K0VhOGlwNEE1cEpVWUg5QUVzVTh0RndKTXZ2OUZJdzlkWjdrNjlSQzE2?=
 =?iso-2022-jp?B?NnNKdE5weHYwTStidzF0SmFkV3NMRUZGSHdNVUdFaTRyam5oK1BPejVG?=
 =?iso-2022-jp?B?elVkbEVSRFBub3pvUzhOY29Hbnl6QmM5RUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?WVF6TjVrM1RaQWlBRG5qRGVMRTNjeGpXRGR5U01Fb0dkMno5QitrWGM3?=
 =?iso-2022-jp?B?SjFLTkhuQk1mbHNmcy9abEdrZDFIUEhjeCtsYnRDMTAyODI0S3BSbE5u?=
 =?iso-2022-jp?B?N2x5Y3hJWGdnSGxPZGJ2aTYvUFliYUZ4SStMVEl6Sm9JdGN4MnZwRDY0?=
 =?iso-2022-jp?B?OG9FYk41MEs1WTdXVlBvdWdhdTRsb3lFTGlPb2Z3M0QyR2k0U0xYNXRi?=
 =?iso-2022-jp?B?LzZEdTRWU1RhbndTNW1haUZhTVVoMGVrRTFuNExCKzIyZXVyejIzVzFC?=
 =?iso-2022-jp?B?WCs1MjhpSGZrSUljSW5HN0VuN0hrR3pRVUJKZEZ0azIzcm12bXdwS3JQ?=
 =?iso-2022-jp?B?VEMvcDhPZDBOLzBsZmhMV0FqM01GZzlLeWZFNWYzVXJ4dmlCaG43RmY2?=
 =?iso-2022-jp?B?OVdhL2RuSGM2SkFpQzlqdXNlNmZFZkNiWW5NcXFrNGhxSFI4L3dqMS9T?=
 =?iso-2022-jp?B?dUVtYWpRQnZPci9uTlNBUlFyZVVEenMwTkVTUkNMeTViUmNIUDUzQ1Vv?=
 =?iso-2022-jp?B?WXBUQ25ZRjJtNkREOVB4SG1VNkdUdVUveldvUWsxZGFvTDZrWXdsSVpO?=
 =?iso-2022-jp?B?N2NhSGxTQW5BYlVGV01rTDdBY0VHZU45STZEbmRFV1V0L0N3SlRNNnR3?=
 =?iso-2022-jp?B?VzJpdmk5T3RBQ2dCQm9xc2VoZGJ0d21SR05YRlF3QUVqa0xMemlYR3Fi?=
 =?iso-2022-jp?B?WU1RTm0xandVaUVFUklaM1l4SUdTVkVPM1ViemlGQU5hL2dBNFVNcHlL?=
 =?iso-2022-jp?B?cldVak52d2g4OTA0bnRsdmtXRG1XMExQU2RMWHdWenNlVE1LNFpDWFJx?=
 =?iso-2022-jp?B?S0F4VmVZaHg4ZjVWU3doR0RBZTMrVDB5VnBSWVZSVkpvN0VSWmxLUVFo?=
 =?iso-2022-jp?B?S2k2WHA1SnlXRjV1ZVQxc1c3RnpFQnc5UmNkWjZkc3pFc3dUZW4veVFV?=
 =?iso-2022-jp?B?RDJGa2JKTTJSclNBQWo4V0lGQTlZbWs4ckNEQnJubHNUVjhhYklmaWhL?=
 =?iso-2022-jp?B?ZUNESjhTc2MzWHlXYUhuczdlOE9Ta1E5SFZqZm1BZEVmVkVaT3FlLzhM?=
 =?iso-2022-jp?B?MVdTb1hRNk1IdEdtVGZJNjlyUG5pTWN3azZNTTZVUUNBNlhQUXNhQzJF?=
 =?iso-2022-jp?B?NTZPc1NGN1lEaUpyM0hOT1FoN05VK0xaVHEzVUttRGNRZUw2WmNIU2JS?=
 =?iso-2022-jp?B?VE9aaXBnamVYTXd3M3BYTTJaVjI5UkNJcFpWQzNRK3pKRXdFWjRMMHMx?=
 =?iso-2022-jp?B?ZDQ3MGVUV1g3R3dPMU9hS0g0OUhhV2cyZm5PS1pyOE0vWXY3UUx5d3hE?=
 =?iso-2022-jp?B?cjE1Q21BelVhV1I3RmlOOHk3KzFJeFpoRTZWUnB2TWdjWGxYTndwMDJN?=
 =?iso-2022-jp?B?dVJjUUllNXcyOVdSUmV2Uzg3SDROL29EOUJTaEI0Z0Nld3NrSkJnK1hv?=
 =?iso-2022-jp?B?NXU4U0lFZXVBZEUyYkdXRQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ad0dfc-e4e9-4e8f-7889-08db7873e6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 07:38:58.9720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpWX6i1GZoEEs1zceU8cpOXBhaAt9Lg3pbdiI2R1YWHkiaetPKX+L5QSzuzWzVoWam7hzEMCqsd3w7I7mf6JlsnsddEunOmL67A25aN0Cfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6210
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Some Intel features require setting a package scoped model specific regis=
ter.
>=20
> Add a new resource that builds domains for each package.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/core.c     | 23
> +++++++++++++++++++----
>  3 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> 25051daa6655..f504f6263fec 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -167,6 +167,7 @@ struct rdt_resource {
>  	int			rid;
>  	bool			alloc_capable;
>  	bool			mon_capable;
> +	bool			pkg_actions;
>  	int			num_rmid;
>  	int			scope;
>  	struct resctrl_cache	cache;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 38bac0062c82..e51a5004be77 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -438,6 +438,7 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_MBA,
>  	RDT_RESOURCE_SMBA,
>  	RDT_RESOURCE_NODE,
> +	RDT_RESOURCE_PKG,
>=20
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
> @@ -447,6 +448,7 @@ enum resctrl_scope {
>  	SCOPE_L2_CACHE =3D 2,
>  	SCOPE_L3_CACHE =3D 3,
>  	SCOPE_NODE,
> +	SCOPE_PKG,
>  };
>=20
>  static inline int get_mbm_res_level(void) @@ -482,6 +484,10 @@ int
> resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>  	for_each_rdt_resource(r)					      \
>  		if (r->alloc_capable || r->mon_capable)
>=20
> +#define for_each_domain_needed_rdt_resource(r)
> 	      \
> +	for_each_rdt_resource(r)					      \
> +		if (r->alloc_capable || r->mon_capable || r->pkg_actions)
> +
>  #define for_each_alloc_capable_rdt_resource(r)
> \
>  	for_each_rdt_resource(r)					      \
>  		if (r->alloc_capable)
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 6fe9f87d4403..af3be3c2db96 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -127,6 +127,16 @@ struct rdt_hw_resource rdt_resources_all[] =3D {
>  			.fflags			=3D 0,
>  		},
>  	},
> +	[RDT_RESOURCE_PKG] =3D
> +	{
> +		.r_resctrl =3D {
> +			.rid			=3D RDT_RESOURCE_PKG,
> +			.name			=3D "PKG",
> +			.scope			=3D SCOPE_PKG,
> +			.domains		=3D
> domain_init(RDT_RESOURCE_PKG),
> +			.fflags			=3D 0,
> +		},
> +	},
>  };
>=20
>  /*
> @@ -504,9 +514,14 @@ static int arch_domain_mbm_alloc(u32 num_rmid,
> struct rdt_hw_domain *hw_dom)
>=20
>  static int get_domain_id(int cpu, enum resctrl_scope scope)  {
> -	if (scope =3D=3D SCOPE_NODE)
> +	switch (scope) {
> +	case SCOPE_NODE:
>  		return cpu_to_node(cpu);
> -	return get_cpu_cacheinfo_id(cpu, scope);
> +	case SCOPE_PKG:
> +		return topology_physical_package_id(cpu);
> +	default:
> +		return get_cpu_cacheinfo_id(cpu, scope);
> +	}
>  }
>=20
>  /*
> @@ -630,7 +645,7 @@ static int resctrl_online_cpu(unsigned int cpu)
>  	struct rdt_resource *r;
>=20
>  	mutex_lock(&rdtgroup_mutex);
> -	for_each_capable_rdt_resource(r)
> +	for_each_domain_needed_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask); @@ -657,7
> +672,7 @@ static int resctrl_offline_cpu(unsigned int cpu)
>  	struct rdt_resource *r;
>=20
>  	mutex_lock(&rdtgroup_mutex);
> -	for_each_capable_rdt_resource(r)
> +	for_each_domain_needed_rdt_resource(r)

Function for_each_capable_rdt_resource(r) is no longer used in anywhere,
I think it is better to remove "#define for_each_capable_rdt_resource(r)" t=
ogether.

Best regards,
Shaopeng TAN

