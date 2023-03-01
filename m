Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE86A6435
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCAAZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAAY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:24:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AAB757
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677630298; x=1709166298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHfaclYQLaH/u63XDYfU/NzvRvJzcirrVR3agca8PPI=;
  b=RbKx2ZGlXUrElDjWFjFq5wuzLixmYJ0Ps7hYm0FlZUgdN0d+fuhjNRL5
   8uFJSdeSWfZgpoGdLcrbOkCVFjPhKv3AAv/x5iJS1OwA0vHCmXNhyAJ7g
   2BuqDHa1KV6AiEbOtn2Bwt7vL9Q0FM/3zh+XSQPHe1SHD9whVnFiWKQwt
   SR0zfbpm9aG5eKUnsNsE1qvzU2pynZjJSXpTBZrU/kpCU28Nghs3F880g
   qaeN8F7+kbroY0e5yd9XrrdOGl/EsWKbWAAMIg4nExcYRcI617eXo5mFY
   Kfwfh2LAIN4EjRwn1BSEVNcwHTkQr0G3TOU4sbMzV/wKJmbVSh3EXMH71
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322544658"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="322544658"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 16:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848422854"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="848422854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2023 16:24:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 16:24:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 16:24:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 16:24:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGNRx+jWLvUUIzRPxcZYBQNlLPPAGDYr6Vs5Ha9CCtysxYURNQ1OSRVc/QUXy54Zvwg4VGcu/7GA/EJF+66cN0T/NoZEajS7y3TkD67+mkR61Ee+cyNYAU5pNc5hP+6F3WKUDovkTmF4W1D6thCEleXhfCJBDMGpWne6FIqqQrhTtvBOuUqq0Ao1RADII5cdysrZ0aKHhmIXnwptD7Fdi53bFe6ZG/Iv0bXRmRT/ozQNNuZFzVLbWuNwxF3wSE8O+OxDxKT91nbVojqPl0AQzqWIIqMTHyw6qSA2ZN3AeHkR7qWRcawHeyUTdB1YEYr49sMtnY+4e+zyupXpCYkRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Jlj19yfcqsNTNuoq7LFGrsQ9iKBwoIqsnZcomG2Ns=;
 b=SGlBKBaqVCJRmmZqHjP3MmY82lcEc+9I87H5SVdWLE3PiZINQZ2tNvzKHxEPCS0tbIpg403/KVnMsFohFKqAHfDXJgWrr1ykMLdlbHH7SdfiCXE2rZPLfyGnNL0XNx127GHkMO7YSBikpJ6O7iIOkGZeWiN06/n5MQcq6dtuLsr+yWGcJxMruOO1XH5OesoQcaC/3COvu671C3/wPy6z10UJdYS3odG5YaqB1n8dxD759w9QFDqjILOBhDQ6c6JOv/HnhYX73tM5db82i0OQjnzNRuvWgl1nO8k073T26jMpm13a49vVRG38zeEZkjzU6GLxbsSirQDBKBb5OUA4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 00:24:55 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::c2bb:5ceb:d39f:b873]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::c2bb:5ceb:d39f:b873%7]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 00:24:55 +0000
From:   "Pulavarty, Badari" <badari.pulavarty@intel.com>
To:     SeongJae Park <sj@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "damon@lists.linux.dev" <damon@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Thread-Topic: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Thread-Index: AQHZQAwTWGMWtxXhJEOj6EmNYga7ca7lJ6sw
Date:   Wed, 1 Mar 2023 00:24:54 +0000
Message-ID: <DM6PR11MB397833DB2DF869EB50D5E92F9CAD9@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <20230214003328.55285-1-sj@kernel.org>
In-Reply-To: <20230214003328.55285-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3978:EE_|SA0PR11MB4704:EE_
x-ms-office365-filtering-correlation-id: 002732ed-cd7a-4aeb-9dc1-08db19eb6198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GEtROAodSit5ULk8EPPxtX1Q6hatZe5WWXCWcv8kLsRAvgyYDOM2EVajcQ6qGLaVnUWEL+AsOmjIDoHGXlV19X37jk3hw28ki47abGV4zzaFtaez8CIv6+MhZgA48efN1EEwAtjADMloprAmJOKD8qpS7Bfw8ZOcDVqivQkoMvIgvYgjTV0UJuIAAyPJESjqz36I8NtLvY7Pxr4HDPXUWyZMoGxOowQ/Q52EM5iI+crnR4dQ1kV8Uz9YQJQ/+uvRheCVwQ8InXAeahC4YU0mOLVE9qauOmuH6+rc2kLtomAAWDQpSCwgbRIT64IVPzzD2WbWao8gT5JcqMPSFDWDvFVS4EjPTBr8CocSpnJywyuwFG1BE8kTPbQWgYOy06YJS9PBy5wfiEs7fJLVzO6THm5bu/FsUhvjw5HOTkHY96wtL5KOfSHqfSBvOXaMPKlxLLAEB6EijQDgjo4c6+rVv0HoMkBZC7AehBhoTlBk/uIJcAxwyWvDlmRaQMIuayul6CdPbYlejlH7SZMvSmt9iwDmQZ+ooTd/ReMF4l/Vx6nA7kttw8Qv7ecsrGcmD7qoxvzvS0XxM3y3QLGn3ht26yNRlzER5DAGFRlaATIHR/16jKFyFfuBO+sEvTcZuMP3FMAVXVPQr69APZV71Oin916nKdmr6GwZ8q9/u5fKlZH2gsVA9UIM0EH8Rt+O5dxz0e13uOz65Humz2yAs2DPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(8676002)(4326008)(33656002)(86362001)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(8936002)(55016003)(2906002)(15650500001)(38100700002)(38070700005)(82960400001)(41300700001)(122000001)(71200400001)(54906003)(52536014)(316002)(478600001)(7696005)(76116006)(83380400001)(110136005)(26005)(53546011)(186003)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?awUxXm8IZMCWhZftWZaPUfwDTmId1011XFDBb1jnEgEAVJY+CBC4yYpESDg2?=
 =?us-ascii?Q?sjv572ggl/5ychYUaKJxYHMTEN99gU/KHrLEFAwylSM/jP+TT9emU9n3MnGs?=
 =?us-ascii?Q?AjLIfH2dt9lCqZ1d7SyP8d4LVWY2hQIWS7TfGzoDaXsHUWiGaHIBjyiEaxVj?=
 =?us-ascii?Q?Li+DoysmrG3r1xCBIU6BcKbhoCmloLDBfNyYMwiwJbhtc01pDvow/4wwcooJ?=
 =?us-ascii?Q?eYDCoft/fRYt7r/RsdfR/GWcVRSFBtkzelXQgwuHSd/6j+r4d5egggyNxNpJ?=
 =?us-ascii?Q?aSDvZWHzN1+jpzj67c5cWcr+yCo/8qbjKeZMexMEF0DImoKAP28zMIRsy+wU?=
 =?us-ascii?Q?QN5bVPQh9FrWHGBAH7wbiFeOsSuAwGW2S/rkNDORu4iDLRVIMsWn729gCo78?=
 =?us-ascii?Q?p7uc9Dt0+sNRgoYUJ0k6hRKeMwqNoyRMTkE/EBRF8OVGKDlFyMSYW8yjMIX1?=
 =?us-ascii?Q?ImsrVa/03LfsoVa/RSi8E8CN5FE1uWATzhrxVth+JVR/5svBH1MdKtjk3YKS?=
 =?us-ascii?Q?zWLTgy8+1iLhQLNhtrAP9t3eGA8C8wVQeBhzL8UVRXfvIfwXucYozGLTJLeu?=
 =?us-ascii?Q?R/gL6O/whEr9N82k7c+Ty3rthvkAgL33friGRebKxgBoV3iWTd36MPlD63pp?=
 =?us-ascii?Q?Z4OYsI+FoUN6QgOPyowcqxj6Eh1gCnEQmFXuVzWQhxkkuCy9UXdAefNWf+ZY?=
 =?us-ascii?Q?GzoWjr9nusILBCgHaLfcL+3F4B/47f3N+m8E9TUA3qKySAfyuokXFWHC6mN1?=
 =?us-ascii?Q?3Wt/BlSAUjr0KespP29D9YeZjYHYcjZBDnUUmrhsBNGbpYmoc23z6h+b0jhI?=
 =?us-ascii?Q?eC1Xs6nSKMVu1y/1b08ygcfIxZjESW4mrhKEqakXgB5074NINbrZkqf80tqn?=
 =?us-ascii?Q?vE5cbCHw6IHmaN43c2smaM+bH5T10GJhrTjQQDdHHDXGV2/nYZ7NFEV2auSQ?=
 =?us-ascii?Q?7AeiZaQU6ve+9XnzYEKDg6PVG2fl9o9evXz3TjDu7dzwRWWOf0v4n+NYQq3Y?=
 =?us-ascii?Q?2plBD7D68CqRU3rLDq1XI3SAuO5s/CQtagpqmeD1p0LP5uiwo87fV17MDnqf?=
 =?us-ascii?Q?muXY/qq8Z8lkAoSqrtylznwJ8R+bQC5rg3+prInyGODbNforld56bl7QJq/J?=
 =?us-ascii?Q?L7DPrLZ6dqMBqC41GquGlgVlKJcgBECw3DSxwRSJ2vpmYWYdCMTKOsSLCoHw?=
 =?us-ascii?Q?mYwxYCfsSviaFVcTjN73dqJ9e+w/lMnCLcXs2S2jGZmEypcIzSNce8pLNtki?=
 =?us-ascii?Q?iPHDWwmopfoNaqpI4SQoDo8gQpggDAa4N8vnJFpBo8p1bkCN7fiG+8ELdwpp?=
 =?us-ascii?Q?cIJ9A/tQLX60GA3i7xhNti435uUQaKcHxH2P3xaOJRDPsHiGTU/QIvw7ysd1?=
 =?us-ascii?Q?U24JM/Nk5iFe8Owyx3z50Gojl8LYMjoDWXyyRzpmmQi8wTUtsX3mwOcjrnWi?=
 =?us-ascii?Q?4Esuip37dctE05TLy6U7BndxVnhpYQtLzE0PltIPHCMaprA7zyIt/USRPzLG?=
 =?us-ascii?Q?TogcHxIsbErMjz0s+zIhr6VPPUVo56oCybqnsMYA5fs/zNN8GOSt6/W2BW0H?=
 =?us-ascii?Q?KRUvviigYTac92YwWOPQlLUEgBbGzNYZEDUc1ezw7xbPyVL2jDAKtpcHUvqM?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002732ed-cd7a-4aeb-9dc1-08db19eb6198
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 00:24:54.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgWIfnn9WpQoBEzC0vqnZ+OkQQM2J7FHSdjKXtOZA7FB4o9D5KbjKNUBkeTq2jFMIX/m8EUj34Q+O2IFxkiorV8WOnX4Y39keUDsTJeWaZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
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

Hi SJ,

We discussed this earlier.=20

- Are there plans to make DAMON monitor/manage cgroup instead of individual=
 pids?=20

Thanks,
Badari

-----Original Message-----
From: SeongJae Park <sj@kernel.org>=20
Sent: Monday, February 13, 2023 4:33 PM
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-mm@kvack.or=
g; linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans

Hi all,


DAMON has merged into mainline as a data access monitoring tool that equips=
 a best-effort overhead-accuracy tradeoff mechanism, and then extended for =
data access-aware system operations.  I'd like to briefly introduce current=
 state of DAMON and share/discuss about 2023 plans including below.

- Finer and easier-to-use DAMOS tuning
  - tuning aggressiveness based on user or kernel feed (e.g., QPS or PSI)
- Merging DAMON user space tool into the mainline
- Extending DAMON
  - Page-granularity monitoring
    - LRU-lists based page-granulariy monitoring
  - CPU-specific access monitoring
  - Read/Write-only access monitoring
- More DAMON-based Operation Schemes
  - Tiered memory management
  - THP memory footprint reduction
  - NUMA balancing

I hope to hear concerns/interests about the plans for prioritizing each wor=
k items and get some suggestions of future works and collaboration with oth=
er kernel subsystems/hackers.


Thanks,
SJ

