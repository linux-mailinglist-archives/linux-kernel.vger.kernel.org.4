Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1416911AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBIUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:00:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613785A9F0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675972830; x=1707508830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kn9IENlnqi7Pv01ITVzyt5hElSTJ0FIij6j1rdDZIJQ=;
  b=F+Yu0XtmTDKHJktMaAcGVuC6ZMCKz7z3Ncz/qEZpe7VWoNKeSh5sLHSk
   xQUPp6+lEfcUfwamsVrp8H4ZujRX3kGG89alg+XR8X1DuSFKSxj/F2aZc
   e6mVq61g9TwN7PHNgqRaZJHejTK/d8Fmy5NzH27TSoSGC+YiT8bk2G+xh
   amHP4aFJym5HL3WT6wDkduq+STnDAaU4Joxw8jA4jVm6zghUutStDo8NA
   X7JN8EhwqVlJpArWS84Ib6w8/JBm90DTj36s29aY0XzmkwI04prVNBFy0
   rxWamtn94Tx98TQdFfhUAkpTesHdmhWwwlpEw5tGN62dVAn/mGXm+vKGH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="332362152"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="332362152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 12:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667802943"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="667802943"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 12:00:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 12:00:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 12:00:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 12:00:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8F/YXuBDTcx7piO1A8CiYla1V5Xut0UQuJdOjfa+1HTBMyQTiRJskB/NfWYdbtpCz+7FQRjjpFAMPWsuH4b59UlCYF4GHeUdGni0IwYpbMi1z7Hqn6wCnb84q8U/dA7m+9p63FBe6TzuWAgswZB376Oz3n3ih68GdOWOTori7CAjh9FN1Lu0eNqLDM+qAt0TQzLzD1Kq/ArGrAjNygUDh2Xwyk8yVfvSWlOtOPbaw2wO1WtLZahQp8Q/tlu3GBrPUdrEnXXG0VS5dhtjCCWrp9/NjaBFbGOo5ZY1p6nHbqe4mpZ7iakQKZf+OFiO4y37sP0oGhGoxQxiu+XtuogBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFRFj74CCU6yoXy7tOUcAvClfoL+JY0H3/mqnPVfqJ0=;
 b=fKpTUSvcTNG+7KKOXi9VTVdlG4/9J+qP1Ku++HNoynV5pva1486CWvtqtFnyO2B4mWvRYJK8XDEVWTZpiQjwgkLnXIfRpBgpzn5NrCWSVfWBWRuXFa3msFHYZJ8+dpLtflQoeMH2AYacHd3SHFOtSs+LW6dAsIEniU+c10gzD4517oms8EadAm0u3+JCBEi0FqW+PtSFZsqT3+58JkF1uQUISQb1KcmfZjHkq8zG5YifJeBvLmTC0v6VdwsEDP9rZXNz0z02SkWIqxhRafpvCNljnKBu4bm24beNVGq84yCDjPmo8u7qurB+z5CVkAgFDZ0dE+L0pxoswfwRJblnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4107.namprd11.prod.outlook.com (2603:10b6:5:198::24)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 20:00:20 +0000
Received: from DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::b04d:cf89:581f:2dd2]) by DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::b04d:cf89:581f:2dd2%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 20:00:20 +0000
From:   "Chen, Tim C" <tim.c.chen@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Brown, Len" <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Thread-Topic: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Thread-Index: AQHZOq/DtsWPHSzMLEmo6OdAAD06ha7GnDyAgABmInA=
Date:   Thu, 9 Feb 2023 20:00:19 +0000
Message-ID: <DM6PR11MB4107F95164772B40B92F66A6DCD99@DM6PR11MB4107.namprd11.prod.outlook.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
In-Reply-To: <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4107:EE_|PH7PR11MB6651:EE_
x-ms-office365-filtering-correlation-id: c8cf5345-a0a1-4414-1069-08db0ad8456f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bd1tyhUUfaO+LRg6pyUOsskeJww3d2HHTt8Lf1PH7PgOhilaidK7u5lcSvePU93jd0CEkdh72DkbQoTqzn78ImziG1Sr8y1MVrJiIGHnEUcisg/QgGAEoqQEXwZUm7eOiRIljY89OWx+BtkozxyXTCz9Zyhy89PIHQFfTDfQ6fVQ8VI0H2zczGaRf4mGLpA5JpgbLh9ZdCc14cPfHPm6t9XPhJshs8MmAUFYQcdNaAG8nCxPKipUVwlAckXVrwVltmROnlra+atJyHiX+FlPmMMywGFSLjjGRVQtWuYyQRqLSAzGEVs6mo5xzd8ghWEwj/HphsPDI9dIHutsDDdXEztyrNCp9XATk2/2dSw+EwZXwTJUenVb4cN4DGcIp1/3O4lklI+a+9zYhdS4oPhXP4sEeQJnw5nuN1SCQK+L/3wnoUIJzDf1SlpGw6YQyjMEc1V2zsGxY9LujWiDK0vIllVI0TnQSN+xZp7d+Fo4clsBjgaVTDMia4IWdDzWneaRLXz6DKDJXpYrba8oPW41ILaFUNEa/qaXEPczVuM5FyawMf9kFhLOs+y/kgs9HDpaoytH1JDamGAJjH5waFeWOlAeG3h6/Ol5ffXe33SStysauZyutDztJl9twNDzNs6HCC27PLwop8w4Ajub9nnBWTHxEfhSRG2iS4qoVxYaMZVZNy7SZfZlX+ofdSsS4gNJVep0mtchN8wdl1/Kl+lVUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199018)(2906002)(33656002)(7696005)(71200400001)(83380400001)(6506007)(9686003)(186003)(26005)(478600001)(8676002)(66556008)(64756008)(66446008)(8936002)(55016003)(76116006)(66476007)(66946007)(86362001)(122000001)(5660300002)(7416002)(316002)(82960400001)(41300700001)(4326008)(38100700002)(52536014)(110136005)(38070700005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XS6q0Bo/IcCWuXuPCkaaK9hLj/GaaGhoGJj0fSQ5YNKibpM2JgskfKL/CUtX?=
 =?us-ascii?Q?MzlcL/Szb089oiUZtrX7VwH1V+NlG41zzAWYE05zmg9qoq7gC9/+GLENZnPl?=
 =?us-ascii?Q?k0XXkmg1wDU0HVhj7+LVE3rEHP6NKOZCXcsfxzenRKIaYxvTuA/1geuIBkqi?=
 =?us-ascii?Q?Y4IMCytZlfDlhCpRC4frYnfNKa7e5D1caiqsvxaslEpVlJt6N+ifSZRnsxps?=
 =?us-ascii?Q?QobGHiGBbVG0Cka0p/17YTmH0dZenf8nH1M9n5qyew/V+NoCjgMYdeQ7i0Cf?=
 =?us-ascii?Q?4fm1qo8LaOCn7lRMwaVymKIaFRIV08aWj5VZCUDdjnSc4LXiMvEbqNBDPOox?=
 =?us-ascii?Q?KYb9jRw8CS6YYTpSxnUjHRhgJD8asXfkQM13fPMjmQ62APuU9o3kVcKzfVTZ?=
 =?us-ascii?Q?PBRmvH05KNm/FqQm3nenJ1cdvvlIwrKCxfSRH2zyiYnUpJ4lUKRSoZ+ODSEc?=
 =?us-ascii?Q?D0tb6rQZpJ4IAIxwSxVdIy/3TaoftiLsDdjSljhPo72Mu2Nph22hVPLtNt/S?=
 =?us-ascii?Q?IXXDliVPFZKV9oQ383AN63/RgUImV8bkJ/MllSKWhveinLbw+88iFfP58mkD?=
 =?us-ascii?Q?cHkEumHg6v4NRfweQCt1w7XQScyG6tkG7Ur/TPMTmR/fhbEzRmgxDNnepIKa?=
 =?us-ascii?Q?PlMPqaOaFOUYAtolz540xxlGAv0Ay+snbs+t0vF3WQFt0uI2NKxUgxhjJ1dP?=
 =?us-ascii?Q?Qt7ixInyNY0R4pcCPefgoWGBltMga7spXw/y93OVKCzl3bOIMckDUyOL/t2s?=
 =?us-ascii?Q?bkP9wfkTxzGRVqtgJlRjcVFNyMzKQUhJLkhYVaNMepYb8QAuz2VjZ+V+kPG3?=
 =?us-ascii?Q?1jAkX2fPSiqh0a0YOjX0S/naLwtWUx67Vv0ElvqJ4+l+37UH0sS0xb4Uptt1?=
 =?us-ascii?Q?EgqwKM6C1f7egEcxVc+HtCnLInB724067vukXcmtvssrSP1cvBwyKAQU9iFk?=
 =?us-ascii?Q?2lxYyDxkhobkv4SWroQk3LKzNDzrJSKrs0OS8GSWqDAEQNtE5e1pGKP8JK3t?=
 =?us-ascii?Q?MGdnnxFWJPWNpbwHDQwfWU2Zde+rNpeKelhrfYS9vxmAU9eJvMltoLkJBrQ1?=
 =?us-ascii?Q?PwfdJbXsyjtSmcWMD/opWoUj8dGapaoeJsdAqWx3T60JdvR1cUvU6JVuBLqo?=
 =?us-ascii?Q?K/FvxwtpRx41NnHHUceE97ZqiZhWRlMF4KovtMKpSTaFwlu2ytgpJnnstPab?=
 =?us-ascii?Q?fZXQv6wD+2TAH0fpTWWjruuQrPK0yINHaR0QKX94u5LwHak/t+4Zx5pKWqHz?=
 =?us-ascii?Q?vuAQgWV9AuRS0I0ztDyXBjBjr3dXz3m6Tw5iP0KmafTJtyaAikwrrT0S2I9i?=
 =?us-ascii?Q?9mT9GedahP5ITBQnQfLzOlkaUtcOsGW9KN7DqcaL1VHNZ4erhHhnEgfIaFuT?=
 =?us-ascii?Q?+YNMl/PHUKgFnu98FYe+glbWssXZIFRynFdWWzk+Enber8upSlmcQi6Cvdpq?=
 =?us-ascii?Q?EjW8uHjV6S3lcVtQ4D8dxQ4C/eY9B5yPfdGsE71Trh46+dOZ2VY2lTUXb6nc?=
 =?us-ascii?Q?r5JuO6eHXnP/dnwaIRNvv1+mmw3MVjq1yvYOpkTti4Z6YuVM1waWaef0NbQE?=
 =?us-ascii?Q?ZsJ8SR/usNepDPrlCu1mhYPxvMdJlSSrdr/u1L6K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cf5345-a0a1-4414-1069-08db0ad8456f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 20:00:19.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYUvfhuZ1+SlmTq+XPTCBg2vJJFPVI5Hp1IRO3Izeq/YoxK7PEv+RmoGvlpJPT6nVkKGBZIPDxoB57hMCdW4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  static inline void update_sd_lb_stats(struct lb_env *env, struct
>> sd_lb_stats *sds)  {
>> -	struct sched_domain *child =3D env->sd->child;
>>  	struct sched_group *sg =3D env->sd->groups;
>>  	struct sg_lb_stats *local =3D &sds->local_stat;
>>  	struct sg_lb_stats tmp_sgs;
>> @@ -10045,9 +10044,11 @@ static inline void update_sd_lb_stats(struct
>lb_env *env, struct sd_lb_stats *sd
>>  		sg =3D sg->next;
>>  	} while (sg !=3D env->sd->groups);
>>
>> -	/* Tag domain that child domain prefers tasks go to siblings first */
>> -	sds->prefer_sibling =3D child && child->flags & SD_PREFER_SIBLING;
>> -
>> +	/*
>> +	 * Tag domain that @env::sd prefers to spread excess tasks among
>> +	 * sibling sched groups.
>> +	 */
>> +	sds->prefer_sibling =3D env->sd->flags & SD_PREFER_SIBLING;
>>
>This does help fix the issue that non-SMT core fails to pull task from bus=
y SMT-
>cores.
>And it also semantically changes the definination of prefer sibling. Do we=
 also
>need to change this:
>        if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
>                sd->child->flags &=3D ~SD_PREFER_SIBLING; might be:
>        if ((sd->flags & SD_ASYM_CPUCAPACITY))
>                sd->flags &=3D ~SD_PREFER_SIBLING;
>

Yu,

I think you are talking about the code in sd_init()=20
where SD_PREFER_SIBLING is first set
to "ON" and updated depending on SD_ASYM_CPUCAPACITY.  The intention of the=
 code
is if there are cpus in the scheduler domain that have differing cpu capaci=
ties,
we do not want to do spreading among the child groups in the sched domain.
So the flag is turned off in the child group level and not the parent level=
. But with your above
change, the parent's flag is turned off, leaving the child level flag on.=20
This moves the level where spreading happens (SD_PREFER_SIBLING on)=20
up one level which is undesired (see table below).

							SD_PREFER_SIBLING after init            =20
							original code	proposed
SD Level		 SD_ASYM_CPUCAPACITY	=20
root			ON				ON		OFF      	(note: SD_PREFER_SIBLING unused at this level)		=
	=09
first level                           ON				OFF		OFF
second level                     OFF				OFF		ON
third level                         OFF				ON		ON

Tim
