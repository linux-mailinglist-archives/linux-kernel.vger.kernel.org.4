Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C76C5D59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCWDjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:39:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200310CF;
        Wed, 22 Mar 2023 20:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679542757; x=1711078757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDLeJli2NrjXFpW8A9ApB6DhPDJM5XBkBCHuBmJgkhQ=;
  b=Muv/62T5t3AOl+rpncJ/JjKtHDry3VztgGvjCp00dcysVPZeofvn6ErA
   SM7CI1HJk1jmdRqRcl3I+7A423nOQ43oWx9BUtr5+3kL+8BOK8uBFNecD
   VHytIjgGF9udAufm/+ryaLYZTfS5Qykf7Xa68HcaNLBPXNtDNiM6vnMLp
   QHNhTIF+9XMMIJbY6Q2CA7BmALPdgoWdWPTZfb27gJ7xh8dQe830m52Lm
   y8ppLGqmIMiw8wUIQsbtx398nzMVgKbEbCkhi4eHtOxDcerxz493njMRa
   xkQGOBkZk1lM83eqaOnOSPOIlpus+v+HZMwByKplpR7AzyCEVfvi5gBZr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319039095"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319039095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675545895"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675545895"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2023 20:39:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 20:39:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 20:39:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 20:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpyn1uD3D8AGBDgl7vCfnVyRhGaPNNAmH0Gy6o719OKCf9br+QmNvqLX2Mbp568uZVhMnBhCk5tLiTK4vS/r7LQcYvE3xWubolh4OsYX6+0LdyVlB1cBGo/8UP1j6PEo+HkcnzURHFSdg4siqUuuE0Yo+KUfmYRcDCpivfk7cT5qEvIaJMO+at1E97VKbzp4qYHl7LFYFfD3+v6zmJEE4D211dWIkPz0E7/eOOtkVZY66qjS9ZTNOYamX0FhVld6P+jEt2mQxn+IW1WvVJDBYH8amD7+Y6oFBfugO8O8kliTaudUgPv0r2tjqwVwrn99gXy39x4ArYGc8v4doUgYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW5pDLCRsRWJeVSAvEpCWAPhT/u5FzOFbUT8dy6KGic=;
 b=XBY5dkT4t5gooduWh7pd3Ac2c0xjCNi7bz3OcHpdM4cIXNE2WrQirwM1xVqo4QD8YeCJVjrTELDQVZXSfRRtTNFsd8y4dipm4qKH5vjtvLA23uwBT1rX2tE1TaW7E52LOsvebGu57YFGs5ZUFDqb8XgDRc84MiHuR7zQ2HU+CTyPksYxp6sSgIs68hgUzu+4ntgvV2XRV2hWvoGMPvL4uwn1ESJvVnLHaKrElPeMCYIGlU2yaN5JKxw7TcN2Mi7OnO0MKXaPjIRfuS6w9J2s9d3n+EzU4bO2RHH7bQFc3R7ghgOroQRqmpb/okldFm9VkAy8NENuChkr+0Gika200A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:39:13 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 03:39:13 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oIAAFDsAgAAGXDCAAARcQIAABUEAgAAIZMCAADGRAA==
Date:   Thu, 23 Mar 2023 03:39:12 +0000
Message-ID: <PH0PR11MB58805E8C66D55E7CC0239E0FDA879@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
 <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <80edb753-c8d4-4279-853e-201076949bd7@paulmck-laptop>
 <PH0PR11MB58807E8A7FCF686F87079BAADA879@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58807E8A7FCF686F87079BAADA879@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS0PR11MB7191:EE_
x-ms-office365-filtering-correlation-id: f596bad1-ca20-4d09-bf8e-08db2b502b80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxf5qZPWEmEpjBDrfL5p6/yPH9eOAnGFXWY/KyyzI5OZb6blBsm03g5YrwIhxGBmP89BO2W9viOc3qRXQrXThYvKyZ6k3eYTSYjACpITDS3asFjN1B4y9UDDfsV2n987G+TXjz/h6M3EI9/n0OiAZ34HIdPXv6gS06BvgE1MVIZ+2CM1WBP8VS8txJVnFCiQyDouZ0AqZTYkQrgrkO7pOgpesTdihpk+1rOuJtp4q/W/YECtl8P1eb/exQVMz8JZL5Fythfzshz73CteKxyxIlHd8kJ+XOPLopIFmrLrYrHVNNt0uUwL6TPTDe2GzHsD0gkc2ezu4qSCnSqd4nD9ZspXAEha4KlegFGGdG6BIh3oR013uQ+ZjHvrUUSaIMAqmOkf+Ca3SkB/61dttbGav0i3Kcw1j4WBu2LcyXs2IFNI4GruAOZJo6FGiCgl+XTdOjdJfKIkKZT5mkpASeG/f/idkczOKWja4477tqjDBK5oIfdzXSlNB+sxpipQiNSH3hi2IVl+jnXiss1pbnytIExjuzxolb+YL4ucol1k5JHHlPQST9snooXc3Ii3Ezqb2U0ENhCIEQ1959AbjIBCiPilZYMcLBmijpydo6heIqmbfee0Btk/trqAnAaktuj78E5KnbQOw7GGzucDEZYnQI2nfrZXj4CNbHkSwplD/qTQx3SNrAX8FBSURwXloKqSQHwQMa2DOEjK5f0MkGRSWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(45080400002)(5660300002)(478600001)(55016003)(2940100002)(316002)(83380400001)(110136005)(71200400001)(54906003)(26005)(33656002)(7696005)(6506007)(186003)(9686003)(38070700005)(64756008)(8936002)(86362001)(2906002)(38100700002)(122000001)(76116006)(30864003)(41300700001)(82960400001)(52536014)(4326008)(66476007)(66946007)(66446008)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EPeDO6t9w3KatK6VfnUnC4c4pLVmKDkg//WkGl2YK35XsW8O2wYz/oxZK2m1?=
 =?us-ascii?Q?FhuObSxnk0NEdsMaCgGkXkLMg+EdzqMDztBJriTMvMrcTX0dR+3Lx2iR9Yuf?=
 =?us-ascii?Q?4RhbzokoWRU9cfq0tqv8TuSxArqXDKeRW+neuk0ay+L33l+nVRYmI/+EePzf?=
 =?us-ascii?Q?MCmQLbgBQN99P58pRslJkjuJZRxfHpqu930B+Hg+JA4z0E44MuKmDGvVgBoV?=
 =?us-ascii?Q?h4e1/hfst4LmrB2/7t4AHMA2rRvP/P4rg/W3wACsWaz/48hKn/ZW9j9GqOzb?=
 =?us-ascii?Q?TUIPIJy9a/IEs9bHQDjj2SdJ8zP/miVrbCphc3BNMKPr9WpgAiTfgzw5x8S9?=
 =?us-ascii?Q?wl7bntL5RwvzGUi16naUA9Qaxv5kuSLoTuR3riJd3J6gbVlMgcYqYWJHRk5Z?=
 =?us-ascii?Q?riqVf9h4e+AsRoQnf1YGSIS8FjxqXdw5n1rmFpaC5MBZQGfghHSci6xxiReo?=
 =?us-ascii?Q?TXzM56elawZ/P5vHW7CacoyKcj/mvYPdwUAaLDJUxsJgmRzmk8ggWbkw4IOM?=
 =?us-ascii?Q?g5hv+hJNkOcYkcNX7WfsE5JOLtEKIa4wcY1HTxn30d9O8FehqC/GKKnczPQX?=
 =?us-ascii?Q?bATXWDiSaevy0vDJO45d75lLkC1iX5gnNhDN4qtfLgeTUwwpGnpNIpaFKKkV?=
 =?us-ascii?Q?wFKhzI1Sw9g91Kowj5cBDC2SI83sATjQwHdiWyDhQujRLHdoQPiJiW3hlcQ3?=
 =?us-ascii?Q?dZvUgL/QDqmD6g7W3S8l/zWRwkRsNX8llY9RJpQRu2k8Q1QM7eodav5YXB4e?=
 =?us-ascii?Q?9309j7NMFBdFnHY+LyKdwzVSQAGWe4cin/lhWz8yiu8ng7i4UYrMY6FBuRjA?=
 =?us-ascii?Q?4yOezpwTQ+3A/bYohQIG+zc6aSY+HeywExZ0EX2bZh84eKrDYwzOAvVgAl+C?=
 =?us-ascii?Q?l8y48qmkMqiXkPfO+EZtaNyR4ySKFQdsRfGlXOIYObyQi4h2GgNYGpf2K/O5?=
 =?us-ascii?Q?i83JYjUIZHbTxzmPgwbTV2TpuVtnCRLTF75x1m9O/dPdmjRZz+zDZBQicjrV?=
 =?us-ascii?Q?OAu/jkiS6CBFt2ORRp/9Zs9cIHVrLAbhbvDYTVRy+4q/t0rXHTWteGajy2a+?=
 =?us-ascii?Q?LUbEDSuGFRB+tMeyZFlVuaDtKEslMatPqt/j40xQbpvgWleZTDe4RUGnGKT4?=
 =?us-ascii?Q?iTXfWFIWVSIf2nSH6uBslVINw+C+3g7iJ98atxql+SIFKcplxqlzKcqfRSf0?=
 =?us-ascii?Q?L65YIcJEqmYVRKe2irdBm/aQuf+jYQFEUR7R5RFLOgxjFlTLwOmSrQJzFhPm?=
 =?us-ascii?Q?PuEhv2a0arHpVAC7V/P7PZyhzPMA2FIQXJnMRsLp93YzgiB4UA7RmW4C3Z6L?=
 =?us-ascii?Q?971NY7T43KdYNfy5T3xB1ExTFUkQsCbtYpXQvt3qV6jcjQCcBBqN2c+sfrCD?=
 =?us-ascii?Q?jzyQSOz1gE83NK3b51iy5HwegAZVnghbwEfmmr1JGu2KBHsA2iuP8ZYXezq8?=
 =?us-ascii?Q?XynRoAVGnQo/mZqG2V/lh2zKwLwfu3zIGexrzuIqwLMKww3FZMUxrpyvhe5u?=
 =?us-ascii?Q?kxvrrL5foHU5Aw8pEygtdjTKfLCE/B1KkZg2k/T0D9rf6ir14+LtvOAUgAWc?=
 =?us-ascii?Q?jqNCXpQE5yopTv7jWBMJZtF6Ijf104U+4p5H8DoH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f596bad1-ca20-4d09-bf8e-08db2b502b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 03:39:12.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBmyuNLdrTJ0RQj0bor9pyIhGPde+uMK/YPdW8E1WoTAc+IsMc08ao23YcOX/v8uxEaxwCuqs1ZrkAKehsMpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > > insmod rcutorture.ko
> > > > > rmmod rcutorture.ko
> > > > >=20
> > > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:316=
7=20
> > > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=
=20
> > > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standa=
rd+=20
> > > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > >=20
> > > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU=
(),=20
> > > > > when compiling and loading as modules, the srcu_module_coming() i=
s=20
> > > > > invoked, allocate memory for srcu structure's->sda and initialize=
=20
> > > > > sda structure, due to not fully initialize srcu structure's->sup,=
 so=20
> > > > > at this time the sup structure's->delaywork.func is null, if not=
=20
> > > > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > > > srcu_module_going() the __flush_work() find
> > > > > work->func is empty, will raise the warning above.
> > > > >=20
> > > > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > > > structure's->sup, in srcu_module_coming().
> > > > >=20
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > >
> > > > >Good catch, and thank you for testing the in-module case!
> > > > >
> > > > >One question below...
> > > > >
> > > > >							Thanx, Paul
> > > > >
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=
=20
> > > > > 1fb078abbdc9..42d8720e016c 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module=
 *mod)
> > > > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > > >  			return -ENOMEM;
> > > > > -		init_srcu_struct_data(ssp);
> > > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > > +			return -ENOMEM;
> > > > >
> > > > >Wouldn't it be better to simply delete the init_srcu_struct_data()=
?
> > > > >
> > > > >Then the first call to check_init_srcu_struct() would take care of=
=20
> > > > >the initialization, just as for the non-module case.  Or am I miss=
ing=20
> > > > >something subtle?
> > > >=20
> > > > Hi Paul
> > > >=20
> > > > Maybe the check_init_srcu_struct() is always not invoked, for examp=
le,
> > > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(src=
u_ctl),
> > > > but we use torture_type=3Drcu to test,  there will not be any inter=
face=20
> > > > calling
> > > > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > > > structure's->delaywork.func is process_srcu().
> > > > when we unload the rcutorture module, invoke cleanup_srcu_struct() =
to=20
> > > > flush sup structure's->delaywork.func, due to the func pointer is n=
ot=20
> > > > initialize, it's null, will trigger warning.
> > > >=20
> > > > About kernel/workqueue.c:3167
> > > >=20
> > > > __flush_work
> > > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > > 	return false;
> > > >=20
> > > >=20
> > > > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_need=
ed=20
> > > > is zero,  after that when we call
> > > >  check_init_srcu_struct() again, it not be initialized again.
> > > >
> > > >
> > > >Good point!  In the non-module statically allocated case there is ne=
ver a call to cleanup_srcu_struct().
> > > >
> > > >So suppose the code in srcu_module_coming() only did the alloc_percp=
u(), and then the
> > > >code in srcu_module_going() only did the the matching
> > > >free_percpu() instead of the current cleanup_srcu_struct()?
> > >=20
> > > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE=
_STATIC_SRCU(),
> > > when a module is unloaded, we usually don't call cleanup_srcu_struct(=
) in the module
> > > unload function.
> > > If in srcu_module_going() only do free_percpu(), the srcu_sup->node m=
emory maybe
> > > can not free and also lost the opportunity to refresh the running wor=
k.
> > >
> > >
> > >But in the module case, isn't the srcu_sup->node also statically
> > >allocated via the "static struct srcu_usage" declaration?
> >=20
> > static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_f=
lags)
> > {
> > 	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->n=
ode), gfp_flags);
> > 	...
> > }
> >=20
> > Regardless of whether the srcu object is declared in the module or not,=
 sup->node is dynamically allocated.
> > right?
> >
> >You are absolutely right, thank you!
> >
> >There are a couple of ways to resolve this.  One is to simply add
> >a check_init_srcu_struct() before the call to cleanup_srcu_struct()
> >from srcu_module_going(), as shown below.  This seems a bit silly,
> >potentially initializing fields for no good reason.
> >
> >Another way is to make cleanup_srcu_struct() do the same check
> >that check_init_srcu_struct() does:
> >
> >	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
> >
> >If the value is non-zero, then cleanup_srcu_struct() should skip
> >consistency checks that complain about things that cannot happen if
> >there never was an RCU grace period.  Maybe something as shown after
> >the second line of dashes.
> >
> >Thoughts?
> >
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >
> >/* Initialize any global-scope srcu_struct structures used by this modul=
e. */
> >static int srcu_module_coming(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >	struct srcu_struct *ssp;
> >
> >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >		ssp =3D *(sspp++);
> >		ssp->sda =3D alloc_percpu(struct srcu_data);
> >		if (WARN_ON_ONCE(!ssp->sda))
> >			return -ENOMEM;
> >		init_srcu_struct_data(ssp);
> >	}
> >	return 0;
> >}
> >
> >/* Clean up any global-scope srcu_struct structures used by this module.=
 */
> >static void srcu_module_going(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct *ssp;
> >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >
> >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >		ssp =3D *(sspp++);
> >		check_init_srcu_struct(ssp);
> >		cleanup_srcu_struct(ssp);
> >	}
> >}
> >
> >------------------------------------------------------------------------
> >
> >void cleanup_srcu_struct(struct srcu_struct *ssp)
> >{
> >	int cpu;
> >	struct srcu_usage *sup =3D ssp->srcu_sup;
> >	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_g=
p_seq_needed));
> >
> >	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> >		return; /* Just leak it! */
> >	if (WARN_ON(srcu_readers_active(ssp)))
> >		return; /* Just leak it! */
> >	flush_delayed_work(&sup->work);
> >	if (wasused) {
>=20
>   If   wasused=3Dfalse  It not need to invoke   flush_delayed_work(&sup->=
work);
>   this trigger WARN_ON(!work->func)) .
>
>Again, good catch!  I will pull that flush_delayed_work() into this
>"if" statement.
>
> >		for_each_possible_cpu(cpu) {
> >			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> >
> >			del_timer_sync(&sdp->delay_work);
> >			flush_work(&sdp->work);
> >			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> >				return; /* Forgot srcu_barrier(), so just leak it! */
> >		}
> >	}
> >	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D =
SRCU_STATE_IDLE) ||
> >	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->src=
u_gp_seq_needed) ||
> >	    WARN_ON(srcu_readers_active(ssp))) {
> >		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n"=
,
> >			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
> >			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
> >		return; /* Caller forgot to stop doing call_srcu()? */
> >	}
> >	kfree(sup->node);
> >	sup->node =3D NULL;
> >	sup->srcu_size_state =3D SRCU_SIZE_SMALL;
> >	if (!sup->sda_is_static) {
> >		free_percpu(ssp->sda);
> >		ssp->sda =3D NULL;
> >		kfree(sup);
> >		ssp->srcu_sup =3D NULL;
> >	}
> >}
>=20
>=20
> If we have not invoke check_init_srcu_struct() ,  that means call_srcu(),=
  synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are als=
o not invoke, so Is there no need to check
> srcu_readers_active()?
>
>The module might have had lots of SRCU readers, but no updaters, and
>a bug in that module might mean that that readers are still active.
>For example, the module might have passed the srcu_struct structure
>to some function in the main kernel, and then forgotten to tell that
>function to stop doing srcu_read_lock() and srcu_read_unlock() on it.
>
>Or the module might have created a kthread that did SRCU readers, and
>then have forgotten to stop that kthread.
>
>
>fully understand.
>
>
>Please see below for an untested patch.
>
>I will test the following modification.
>
>Thanks
>Zqiang
>
>
>And yet again, thoughts?  ;-)

Maybe add the following modification,  otherwise, in cleanup_srcu_struct()
Kfree(sup) will release ssp->srcu_sup which is statically allocated.

@@ -1926,6 +1926,7 @@ static int srcu_module_coming(struct module *mod)
                if (WARN_ON_ONCE(!ssp->sda))
                        return -ENOMEM;
                init_srcu_struct_data(ssp);
+               ssp->srcu_sup->sda_is_static =3D true;
        }

Thanks
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 1fb078abbdc9..fe04214ce84c 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -645,22 +645,25 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> {
> 	int cpu;
> 	struct srcu_usage *sup =3D ssp->srcu_sup;
>+	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp=
_seq_needed));
>=20
>-	if (WARN_ON(!srcu_get_delay(ssp)))
>+	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> 		return; /* Just leak it! */
> 	if (WARN_ON(srcu_readers_active(ssp)))
> 		return; /* Just leak it! */
>-	flush_delayed_work(&sup->work);
>-	for_each_possible_cpu(cpu) {
>-		struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>+	if (wasused) {
>+		flush_delayed_work(&sup->work);
>+		for_each_possible_cpu(cpu) {
>+			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>=20
>-		del_timer_sync(&sdp->delay_work);
>-		flush_work(&sdp->work);
>-		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>-			return; /* Forgot srcu_barrier(), so just leak it! */
>+			del_timer_sync(&sdp->delay_work);
>+			flush_work(&sdp->work);
>+			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>+				return; /* Forgot srcu_barrier(), so just leak it! */
>+		}
> 	}
>-	if (WARN_ON(rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D SRCU_STATE_I=
DLE) ||
>-	    WARN_ON(rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu_gp_seq_nee=
ded) ||
>+	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D S=
RCU_STATE_IDLE) ||
>+	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu=
_gp_seq_needed) ||
> 	    WARN_ON(srcu_readers_active(ssp))) {
> 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
> 			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
