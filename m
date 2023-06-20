Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064F9736250
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjFTDt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFTDtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:49:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67610C2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687232982; x=1718768982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ab46j1TmWm+Qr6FjkqUGKk5RNLQx13s8AJ1cm07nycI=;
  b=cr/0Xdh52UVBejX9RJ3FJf3wuGkInbUT3Vw7dNw2fFC4nglwOdf5C7vI
   pIitAKE3RyWLDYtz+K6QEQ/HNls41WpZ5g3jLtnG4NZ+853J+D5HiqQcx
   pTh9DI8i8DQ7Qi5Ct2RuVj0N03JO/p90lRFrIcTbhSWocympy7BAM4Rbu
   OJifXETl6QJMDv65TtLOoV+PkaqutO+SSZSygbfPCEGN00KqRSY8fYR8E
   tk7t1KQOVWKLvghDcnE84x6wz5VTtssWMPJ17HJqhpiWfXHRKsYWlHgnf
   ihaImh54QIQ5Vd3x2WcXak3rfKft+PWW5K3TQjq3ba/uFDaiAFJhrqBK8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446134395"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="446134395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="743654809"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="743654809"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2023 20:49:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 20:49:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 20:49:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 20:49:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU1FdYRwNND6FY1e0dVRpQm2oz+jbLKNUrUfE0ajBkErXrVLN4sOf3M28/KDo1Ep004zK+9nY0w05eU0Iq27W35UBpuVR88QbgrD+dg52Z9DrjKiCDbo90plCqdveJofWfIgc9l+TJYhcjT1YxMZpbSPDVkFNF/em/HFE9nxqfZXgZZwZgEK7lPkWjAuUuvJvaatlg7PBnuJbKrqmkgp3v2aZ5rRTKcx3jT8GXp9Egu0LPln3xwXWqbhblpgAva2semETMxBpO+Vzlsfn9xZ90Y3LthvM+/i4qAtdc5I0JxAbi/l9xkHx4XLPdUiFsdl4hP+YM0ZNxkS3Av5ipQAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3sFs9LtDgLLne9EQZ/HTd28xicpq5fPx8AgWg10qWc=;
 b=DzPwOY5oTLj5127tA2EHfJhWJue0QNC6iYPCwmFpbWrw1dJGZt1dDlS48RylzU7kM5IsavfcGrO2EIc/q11BhCn+1kf1PBN7UuOjMs42EkwOpHxsINquD/6vCrCErTqVF+skEKaI5Cuzt/iafY19GCwB5w5i+sSYKdzPQYIGTVZce3bUjUYIiBVLBUekWonmAE+2QzYtTfMrlo6RmloTf5V8iviqT0ceOXGvEYullwW0QXX0/eiSfGxX0JqSv2km/+l5/W7BEHL88d+1w7dB1oU62BV5yQ95L0Mw+U+xZQudkL7J9l1PlO0HxtOb0D9fZ1VHdXuEDOYedzV9jr3zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 03:49:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:49:36 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Topic: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Index: AQHZoyiDuZCsHP7U1EeCATLJj0kK+q+TDQZQ
Date:   Tue, 20 Jun 2023 03:49:36 +0000
Message-ID: <SJ1PR11MB6083D16326FF2D56C4A1CE20FC5CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230620033702.33344-1-tony.luck@intel.com>
In-Reply-To: <20230620033702.33344-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6951:EE_
x-ms-office365-filtering-correlation-id: 01d14953-e850-478e-5b53-08db71415dfc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Dvcdz+oA19zlXr2A8MUh2r9r67EbJx+bj0SAHckyP3zElBZqVc3kXdYle/gpt4ZKaO9uBBDony0FtRuTs4nxUnDqFEC9xlHv5JVRZEDsvebKiTQGeG8FZWN4w4E0QvRhjVwmnxtKuz8YHSp6nFuNAzr7IeTvvWZMYLcPmggHbJQtUY+hWbDq3iid/bgsQDpD7j+hNskGaj/lrH3By5l9J7B7SLLfbBg8jHKqgWbFYSEVPFEBTqXpvJLJ9SyPp/99x+HjCFxox3h5FLVCKjuU0jOQvHOUuun40qDk6fqI/CoHIkYK9b4sL57ZtI/v0Rfg4z/y7iXvz8NHFF9HgRa6tTpxHVfplUCM1e7QhlB3nuieQk0Ie6p88ESeUIEe2ZlwemTJblSl3CCv0dFxrSVDoNjykU5vVvbo9h74+B8VSc4p0aQoVSrP27qY4wXLumR9oWhPnGLCW3mHj6C380VAAmB6csIs2TH0HpsO3xTaVwUsiQgX8DNj64WPPiU1LlGTxOIT55ms1ysQHuloh0ZfD6fBHTnHoOHVPexnaL2QkueOzxvaof+6gSldoY/BkElUWS0j6Lm0U76sXdWaBT5OlApBCjFR/nfQRGpwjXYvBp4uixkoGbx1xkyyiZngftb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8936002)(41300700001)(8676002)(478600001)(38100700002)(122000001)(71200400001)(82960400001)(83380400001)(26005)(9686003)(186003)(6506007)(7696005)(55016003)(54906003)(110136005)(38070700005)(86362001)(316002)(4326008)(33656002)(64756008)(66556008)(66476007)(66946007)(76116006)(66446008)(7416002)(4744005)(52536014)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJO4WT0aMADP/VoF2gM1MKS4fVorn26tBqgH6kNAWQn14shxvZyLMqa+kLuA?=
 =?us-ascii?Q?Zt7js99+3zNpjMPozOLB4MkOTvWZAsS0c4RL811mOS89NB9eP3xnhOs8ngHA?=
 =?us-ascii?Q?J4b22IWYXX2+KgJY7BtBPjbaoefjR6+4CNvnhpA4ReLbQvWZuAznoYNeaaS5?=
 =?us-ascii?Q?As9KOShdX8vGW4mvGt7y1+A8FvqpwsrbetoUXqGCUbXY9ZNwNKJbCYhPg7/3?=
 =?us-ascii?Q?SGciOocVcVLbYy0CA+Tp5HOKtn4a6jc+NuayVXK4eazHOEbGZ3hxE7BderO4?=
 =?us-ascii?Q?p9MMSkiE/MMflsmQVYfUz4M8tbyN/3f6F7xvkht8mzh3SICC49h9lcqyPZkn?=
 =?us-ascii?Q?MLX6RP8OZbRH3W8zrSNohdnZdlht6Rkr8UMLUBEsfRuBAUzMvWp6h3Rl0D09?=
 =?us-ascii?Q?qV8PguqZsvroNQPl9nTdU41khuVQf+Zux1Ytmn65eRMDrka7PH5lScFuAVya?=
 =?us-ascii?Q?g88t/wEP09XC0G2jUyNlInkSrlS9WpxNb9cWa0r3bnEV2uwvsqlWqkjIorBb?=
 =?us-ascii?Q?gZNAAg42Roz6oE9Up0OZSJH0epJQA/1WbOdUm7KcCThqgG2XtaHhfjiAHeFt?=
 =?us-ascii?Q?djT0s7p5rcEof98DHhOXPjZuY6KGavsk6MUR3zYm5l4vJTeL54/vQlQnnmVr?=
 =?us-ascii?Q?ap+0FOajTFBAKk6FwFHSxPnKCYQ33pkZGcp+9BLREx8sRzOk5QwZFT+kJ384?=
 =?us-ascii?Q?/d+w7YBnonea5cy2ETTHiveT1poANAcZGzpRgTvFR2KhoJXft1P0YESuacLz?=
 =?us-ascii?Q?de1ujRvUCiUK6aDD6ySk7mrYjDWYY2wiameCgiQDyQIV8M065NmclNg67S9u?=
 =?us-ascii?Q?fQHkMVQIEwsYK7RttOSwTHPm3psQE9yXEab0RIMre3c4gq0IJPDQ8qulrHpP?=
 =?us-ascii?Q?Ldlbx48iWWhH42PdEc0ywkpFmbT2M67b4hBKd8l/wu2V3RdKVVztTagL8dXJ?=
 =?us-ascii?Q?Slj/wheaILCuBDcG3w+K9G9NgLEM1nVdohu2Xpz8q9nGgdxCZ7HJytLmQeGm?=
 =?us-ascii?Q?7H/7fx9FBm9fJ9wj42895tZeEqOk7RsYppCPi3WII6ajM5u/e+EFWGpKnUvD?=
 =?us-ascii?Q?GbMItyZPi0v9lJyd4BU61SCfFqoHeLMb6LJjUy3jfjqFaNyF62GGWRL35jMn?=
 =?us-ascii?Q?UadysvjrhDDrcuxBpl9bJ5A5dbMR2RP5p+kflDGtpHC4Ls9pOC06CWFtm5nE?=
 =?us-ascii?Q?KtEcy33S8RLTDTwn7kQxY21Htun7VbCBQZofIxP3O65DWbsJzsbMt4bJ/l0a?=
 =?us-ascii?Q?0lWd3rbvL3a3tTod/qHWb6hrINKLR4yFI5sBmQBG57T29ppjb645RaiYLHoz?=
 =?us-ascii?Q?hAnCc9j5mjYfvi29+GtjSTAMWjmdzAYAZ2hNONXZJBa5T8FTlXfEjwscMSGT?=
 =?us-ascii?Q?oInSIuNckDNg6Nompz+5tQ+FEgiUN44bn2lDQtQoX/bnag95bPqYm6AGqwRZ?=
 =?us-ascii?Q?lcTgyxrCwikjTy4J+n81SsxRomXx9lQgVdO5pq5tFMa4qFCeOYZLAejwvCJO?=
 =?us-ascii?Q?xIQPAmh9Osn8irQZlcfXQLagqCwavafRjABfmqVXPTYP4H3NZfdI5hOvNmXz?=
 =?us-ascii?Q?Mfu/s3x0FNl9m0v1O+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d14953-e850-478e-5b53-08db71415dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:49:36.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQcTwBu1DHyPvUgfFkWe0dG4VlUc30nGt5OxQrmhJBLJtDUB4xfnfXI+gZTZx7QY216f58Mpq1NIQuwxk9zpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 38 files changed, 3306 insertions(+), 2 deletions(-)

Lest this be too scary, I'll note the original resctrl code looks like:

$ find arch/x86/kernel/cpu/resctrl  -type f | xargs wc -l
    43 arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
     4 arch/x86/kernel/cpu/resctrl/Makefile
   996 arch/x86/kernel/cpu/resctrl/core.c
   581 arch/x86/kernel/cpu/resctrl/ctrlmondata.c
   560 arch/x86/kernel/cpu/resctrl/internal.h
   845 arch/x86/kernel/cpu/resctrl/monitor.c
  1600 arch/x86/kernel/cpu/resctrl/pseudo_lock.c
  3733 arch/x86/kernel/cpu/resctrl/rdtgroup.c
  8362 total

I'm haven't included pseudo_lock ... but I have most of the rest, so
I'm confident this will end up as a net reduction in lines of code.

-Tony
