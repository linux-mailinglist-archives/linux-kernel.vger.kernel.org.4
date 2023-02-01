Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5C686CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBARYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBARYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:24:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C45E05B;
        Wed,  1 Feb 2023 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675272262; x=1706808262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eIb4AzX4D0S2TKRx22niznt3pvbfZiGy0jVPF07j9Yk=;
  b=b1YS1wQTxZvfIFdGsk1r2bbfC4eb6UnvvHpHtM1YklfCeAL35Rs+8BIs
   WnXz/6iWwP/gprgdWb5Kgsh7BC9QOFMcCuVwld6Ens+sCi96OvDQzV+so
   lJY45WBgjtQc2az4ufottFp4IbYow0wn8fUz+NOqmdu7nblz6EOvt1RMQ
   W57S+rRLVRYKPFoa2agdjmT3DHbWTIC1O5X5dfmfWUj/n7dVBjky3mC2o
   cPGoyvXXIvtCSOBa08kw967esKUcLH8QFm5pOQxJCTst7btUsH0qahMuv
   xszNalEca+nt7u0KLW0NL2DycEuWTSuMGl+J6wqDh9unRpdtx8eGJXhR1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316207940"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="316207940"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="788964374"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788964374"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 09:22:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 09:22:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 09:22:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 09:22:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVmLAbNo26owuYVRUogAgjPXhkoxqHNeIMk7/r6pV3gkdbKiBOOdp15mESZd3blkWbf0kF6mcQ1iMTR4qLuNDxZfA+KhdyPcqTDLrkloblGJC9Ipf5ctZPj2fgvcII8AFtaL4qiGLglHrBeAK6vvaXLISim/mnfM8u0ibA+/RZDCxGY+cANVtKizzE8T/JqAX+yuVkAaPk7H2d0SLqY+bzddSSbhro0rCrdtnootcR6h/GJei15Vrvqv2FgPO8cORri9GQfhPmJ6AT8xgG0rHrav+F7tsSQZuZsCJno50hJ64OYytg+CsTcMJ/rMkj95q4ikQrLUIoFzDm/20wsouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2bFQneMJq3vTuCAfRY9jewuLYDugNTD4pmXY5ADzPY=;
 b=H1V8yLeHISbOgnJF6xoEY8R8intF19C4JzQbN9YsKMCI3cFFlqrHgYTqXlvcM9FyU5nGsXIE+AXArnLlOVMWJufMRNRMwNZyn87k4EuhRRPPy+4yexrqzZjBgwQ4r1QN2LGE7Q1ufR04iOxXiX//ZfeGXI0btzwxyAkvltCXzBLsoaSMOSvW3F3gCDaAbFP5bPis0rQcXZPBuFxmNfgROGIr0JUzr/YVxHOCwZEbx7i4OsBHDoefT6x9O+/btRX2E2qjFzRGCdjVZlY9fP5PdkJrk/5Y3J724XssvB5p0jGTGnifpvM7Jt8QRUNLjYQxX+XrHg4qb3NtUwJDzfBGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6602.namprd11.prod.outlook.com (2603:10b6:806:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 17:22:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 17:22:18 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Topic: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Index: AQHZNc4J4EU3Q3ktD0OwChsEsRbA+K65iRqAgADKv3A=
Date:   Wed, 1 Feb 2023 17:22:18 +0000
Message-ID: <SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <Y9nyWVNtfBEny66w@kroah.com>
In-Reply-To: <Y9nyWVNtfBEny66w@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6602:EE_
x-ms-office365-filtering-correlation-id: 8b7d8ea8-6472-4ae6-9a8e-08db0478deb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5oq1qLNWcxgmzGdqLkC0WcPVXFmvi7EqBmW8QzxG466FPvuxKIN1Bzudfkm8gOH0fhgTq7ZaC3GFMik5IWPm6I4udzFt6n0B8Vhq8ymFku0ddLabYdFrTGSwx+GfYVmah0aPKaMEv1E/mZQTsPw1gnBGQ8jIouRb9d6Qq3BPDROdc4gg9VKP2sSAiJAww+roTG25OL7Hs+8MHypDz2DypAth7gFul4ftLBPiSn7YRtY25zAeGfOoBDwDOLCWfBN73ac1S34FfVSmutbEKVDedqCLkPGLl1CA5ekSWdCi2HJECfEMWb6NFUl2al8CLkO8wwgg/P8gAASBy2ti17ee3oynSJMVDXbpKaRRkqfu9qbSiSGwCm+h2vXSpBGlDhtJgOgPdDkLtog8idRmuDHj+sSVWmqvx10mwWHSw/j//huQ0lqSJ3wEfGgK1nEMg0TkTGThSUekrVxJ5qVDnob9ZJ4pIhfHpo6d65vCUzRNP2ReMC+fjwhs7xTD7N/6/25cU4B52FJw0wZIIgRcyewIpsHDCQH6yScS/NGP0XJHZ44mGmCEVRhw5R7x+9gxmoZLjW/QF7uD5Pyt5Wh4OSB45vpIdREXOq1nVK8BTu/bWxTCgqsr0pCOmEO42h0GyfJ6wgEMsxycDNW1aAHM7nCMak2HgdFz/eJMW6lp04IFRoGJZo1TYcT3iLHFyV1ROOxevn7mVtNZxwDs4Po5hygbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(2906002)(86362001)(7696005)(38070700005)(82960400001)(83380400001)(7416002)(8936002)(41300700001)(54906003)(26005)(478600001)(186003)(9686003)(71200400001)(5660300002)(6506007)(52536014)(110136005)(66476007)(33656002)(4326008)(66446008)(122000001)(66946007)(66556008)(76116006)(64756008)(38100700002)(8676002)(316002)(6636002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSFRx7U+LfZxti+6ZH4Pmp59hHtZ9LLeV+gmNaPD8aT2YeHbHaXVCu1lN/gz?=
 =?us-ascii?Q?uPNxk7MfynSdRX84t9fCxtXy6L/YQkrR13UqvD1CPRSFy9kZhCrsV2S8Tcst?=
 =?us-ascii?Q?CUyiEG4qP5QuiYyqBg1q4KdXfB7q1TrquQ/2nsO1yoI6yr9kImiadXup+Gjj?=
 =?us-ascii?Q?KuqxF45a35PgCLy/zwvLcmRbyiAu+ZP4q83nykDK3CbZO5IkzjtAWnBlpaod?=
 =?us-ascii?Q?bNTIop/dhXEDiTXBZXPL+ulpnJPx/Re76Y/kvjjt0zRKNhlJMBzJI9+tsN/Y?=
 =?us-ascii?Q?XfeCcHX4+OQZQ/Ik3I3T45k+h0Hab++ZmKDVTPPKxtBlaGN0p3+baCGlYQc+?=
 =?us-ascii?Q?2Z9f5kYoi3opaXNcZneYRut7zRcADOF4ulpC1B/kgRD8FiWt2BGhHvfjxUU0?=
 =?us-ascii?Q?bQ9LeWQcO04I2AIFw9ex+jZtVgkfbiM3Y5rurRvjUqZV2aByHrH6CXAUFX7e?=
 =?us-ascii?Q?lUkQa/Fm8/S0iPHb/fA8yyI2b80eezrEig5uuD8JehT4A9wquw6YLyVMapWP?=
 =?us-ascii?Q?HxjeDkESF0DtPb3mSMAnaEo+upG0FA+M+YX4qM9deA2gEatMxjkIO61oVLH6?=
 =?us-ascii?Q?xVgTQ6hJFRKsUCjgwuR+DCQOU880p9bNPAxHcBY3aYzJazCEXLS27b+/iJeW?=
 =?us-ascii?Q?Pd1+OR6RhIi5bLh6B9vqSqC1YqQsbUBpZYMy15q6Re7MvbeqxMQTn4n4qFT4?=
 =?us-ascii?Q?JlhoRUc/njAU6J8tM5wr/UKXHj/wjg2fVERWrP6L6cUWc0FKs8/on5/VElFU?=
 =?us-ascii?Q?cZqhGfHOF7Ymv+78/31u8oHkbhag38/wcvMVIiCYztsKntga7z8W9Z2G9CTD?=
 =?us-ascii?Q?pLUHjZHkgjdWIJcfgicUPCtxZuA3VsSlZRstQBlplsa0y7xDCGzki1kC3dLz?=
 =?us-ascii?Q?IbjtbpwpV5x6qE33Ty8xllOkCeObDB1jhrAV0SoqAzDgWJACNIQXuIumChTJ?=
 =?us-ascii?Q?uFp+OIhZRkQf2vznZH2nQQbz7WoLhX1X3aPh8no38u8+7OEKTUY4veBOhNvd?=
 =?us-ascii?Q?MfB7ZJ9UJrkHNgC9sZOUgez++SuJ0+9Dk/Jm9ToDQwr6+N1yYCY1c4ypQABN?=
 =?us-ascii?Q?JKJzc256tCMkZvnEBzOupqT4k/ESJsYvg1hrzFYozgGlCprm/q3rcuibwt5V?=
 =?us-ascii?Q?BpLCntM1FROXcUxaen4iNzVmRFvVA9o5tL9Y/HvQ8ulB/5gAeubMnrg1ZN73?=
 =?us-ascii?Q?eb0SjFKqjunTWLT45nOkChx0GTMPtds/O8wfNoCStlgkK1EWhivRpmITyTrH?=
 =?us-ascii?Q?h48fUQoxNymu6zqYkz/wpk1AUdLm9J5i7WodJ29zqjVfctNCEBz2bV/j9j2V?=
 =?us-ascii?Q?VIwUY8+OX+18c0vwRijg6mGi1JQN0onBUxQo8mDkFI6fLsIh44kUdW1pae6f?=
 =?us-ascii?Q?qMWSHEmkxGCrzrf+uFJ/kQnEn2bCcRQUaO04SoHOkmJmgMsQQnC+RsLqsV5r?=
 =?us-ascii?Q?wFpwt8rHPa2TOxShGMM0OiMxh0JmcYt05pnJksxjdMLAM5OCQ4Cwt1oTBF06?=
 =?us-ascii?Q?7As21SG0GyfBS5AKv+M5HU8rBf8gvLmY5l23nZ7LcYyfe5qDYmozLogexgqG?=
 =?us-ascii?Q?37hAUvmtRaLhz2xCq6+1Hijqcb8hcxA85bvAqct1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7d8ea8-6472-4ae6-9a8e-08db0478deb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 17:22:18.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEtT/myYVPyhtDX8usBJj4K1N0d+dGFlFnGbdi60YJY5qM/vdQHB3ocJVFrDHKINgNTVhBnjDOuiTFI5KfU3VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* MSR_ARRAY_BIST bit fields */
> > +union ifs_array {
> > +   u64     data;
> > +   struct {
> > +           u32     array_bitmask           :32;
> > +           u32     array_bank              :16;
> > +           u32     rsvd                    :15;
> > +           u32     ctrl_result             :1;
>
> This isn't going to work well over time, just mask the bits you want off
> properly, don't rely on the compiler to lay them out like this.

What is this "time" issue?  This driver is X86_64 specific (and it seems
incredibly unlikely that some other architecture will copy this h/w
interface so closely that they want to re-use this driver. There's an x86_6=
4
ABI that says how bitfields in C are allocated. So should not break moving
to other C compilers.

Is there going to be a "re-write all drivers in Rust" edict coming soon?

> Note, we have bitmask and bitfield operations, please use them.

We do, but code written using them is not as easy to read (unless
you wrap in even more macros, which has its own maintainability
issues).

There are already thousands of bitfields in Linux kernel source:

$ git grep ':[1-9][0-9]*;' -- include/ | wc -l
2251

Has there been a change in attitude at the kernel maintainers summit?

-Tony
