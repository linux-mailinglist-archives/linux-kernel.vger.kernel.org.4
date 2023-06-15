Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE840731C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbjFOPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbjFOPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:15:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348182120
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686842149; x=1718378149;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EgFlpglqvdqOXOPo00Hp42GDxXHVEoTdFDgnw2O2tKI=;
  b=OiDwsVVthpJGmfv+jWRXZgDeMFbQY9iqJpVHzsGkYHiThlnzydmM/2TY
   IbOFkUDuQ+Ii7QO26ihAUinrTD3WH2J03ZB8BOOcFy9v7q9/WBTT6lmLR
   btHALLRRQuhSo+NsFAaT4eIBIWG0NVrkd0xX6Rzkf7r6cFLg/8Gadx104
   2RyjTH8WVgYr1D9PLjstPDbHY8weaBXmHCcl+uG0DAJ2064OEoZJrPB7R
   bfYnBxbotxO7uMtYlDGsW2qfl4CQEQ8G7e7LQg3E5n4wXoYSOehd8cnBd
   WWpgOU8f6NutQrqgXtM+hji/sAgh4Df3FeQ/iLx2zTZgqjoMxZFNOCoEG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362344891"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="362344891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689802533"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689802533"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 08:04:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:04:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 08:04:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 08:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug/OBJ0EKiSLFgTxB+anrx5CHOhzxNUJDH/c1KLmVmh/GaktFmcaax4SV0g28MpIQNNB4KB8LN6wE/7C7fkfyc3DGSOuWs1REC1U+8+JX23NC7X0iTbLmF2o1jWYysUkvSvW0MXiL40I+8/7hX5C7hP5AiDtEkzJrrlU10yMHAFMQkzpUUFuBU1P0W0nSkdswF70L8yXd5ktOMCoTr11rJUmTGIqmuX5lHk//0oWGGTQ3930PkYwiikE0Rk2xjtEuFqfhkYk9n72CntS19T944cFNt0pRgwzcrSk5cwm7WQcKoFu7wPrCt/FVR5jMNq1MgfHCkAuKuIoq+loQfPkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWwP9iSMiSCU4HrVuglSpYOAafZ0zlUU3E1zfMwivbU=;
 b=jAzaDdAaZjv+8EUqDRwch3YnctzRq11K+WjD4g1ApvmgOESuS33t/Ri9M6DS1HF+mZtGhkFZoD93PHl+ZZIuBRjDV9Z6g4TJ/FxnevKhF3cTHj4Zms/q+qFYwAuXYA+y7XyZstHi4HjxUg5yqxZsBeZVCLcxcCHC43Xu20mtj+EfshNo/Ofvfjx4DwLLMflJS4M3Vb8bmqPs251xRpBo3EyRMWregmxyXNzpk5r9WteIOOYstlgT1ROb+HwA62xl6Dd/YS8u8tBtavISXdWXFXDjzlz1VAgZmwSzvGn6d/WaLmHNva45L2D57cY/dGhXTXEL6hGGEjtq57euJYMh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 15:04:43 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::2728:b097:ff42:bd19]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::2728:b097:ff42:bd19%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 15:04:43 +0000
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>
Subject: RE: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
Thread-Topic: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
Thread-Index: AQHZnuBLo8//l5DYL061VraX79fiSq+LGOsAgADel8A=
Date:   Thu, 15 Jun 2023 15:04:43 +0000
Message-ID: <IA1PR11MB641820FC52D35D1CECE6830DC15BA@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
 <b777a049b3817c7eee364310aac89470e9ea882e.camel@perches.com>
In-Reply-To: <b777a049b3817c7eee364310aac89470e9ea882e.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|SA0PR11MB4622:EE_
x-ms-office365-filtering-correlation-id: babdcf8f-33db-4b05-a45c-08db6db1d9aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nmdggi76+MVwlJvmP931gCGqB4zeB/1e/Ew8KwfI73LcgirgpA0z+MbtXig6OeTWCJlh36slQcsI4a68D5nk7Z4FXvthEdaMzAkbMVZb63jQoImssruOsR7yHk4Rn6q5fr2sWJA1H7wZTmNx7M47Y4PxFlC7rHJHKln5V5s3QS+p6SdVp8+2/3crH/X9hRpksRtT/KQhXbVaoDlzrug4tE5jLH737qPFIhrOSl4/WG3NwgqE/pLNvOZjguWNlWCPEsDjh+E8JAK2RURQRC8iLnhLKNfTwfeaCIQORu5nEy3s8cfSrcnBhBRaSKXpT9RmQmZWoRrJs7GpZVZ+6Jng+GBxTrd8PNEfnVO5kjrutWyi3uhdlAsMvJxvtQW9LBmLjIkkZ9V9P5vegiIwd7My2RRbecydox5dUPGWEcNqAJcdrb7lBffhzKQlGZp7ZI22ojx0vnb98iGuRbUgy32p+GuJXxNY1cpyXSgI0krZ6gexGskP3Mne3hRUdi8if03GH9Ls8x29InvLlYB9heprsPouoBUvYKVOWa+8vtpWXZpNbjDxgNWtGBHFGuLsTw5wNtFtqUXh1gGhaMYHUxTjjHpSrtc1k321aaSmG9QuVNGXmfebrF0O6ebJQnlp7+hI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6418.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(76116006)(86362001)(2906002)(38070700005)(316002)(66446008)(66946007)(64756008)(66556008)(66476007)(41300700001)(52536014)(110136005)(5660300002)(8676002)(8936002)(38100700002)(478600001)(122000001)(82960400001)(7696005)(71200400001)(83380400001)(55016003)(6506007)(186003)(9686003)(26005)(33656002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w2lNGFU39/T+8AsEDmUjgxaUTs6veL8hv5mwOE7iovztwbzQgTgIbsh5B9gv?=
 =?us-ascii?Q?NklfxspX5/7E42EzZ52bPtsPYf5Jvos3vBgVctQDCGIaLx7rmPjqTvN8noYx?=
 =?us-ascii?Q?isFvJu6F81HDjZKLn96SniKstItWIMm0SDbvEHQnEGqNUl3Ydy/Nh0ho5CC8?=
 =?us-ascii?Q?8w8ykB/KZTbFN70SqQLuOtnJLhpnXLOS7j2fgNSl6MF+TqFT4Th7rQ1YHfm/?=
 =?us-ascii?Q?s92LlEhiqfIaSvxgK5+4JdKn0X1WQrFsNZu/jEePE4yAqibLcGm7ob/8mgtZ?=
 =?us-ascii?Q?TgARhHEVQWAdy1WVlNZsLhJtWx96FygEN9BoUOl9NhW2TWTlQGIgm2F6dOib?=
 =?us-ascii?Q?56N6gVy7FVM2VbMrIrHOLV+xu8UwoWCikphEdovwgBPHu2gDpLVOEZFbUMqd?=
 =?us-ascii?Q?ozNkl2BYfQ52DEGL7x279LOm2e7CDJvCp3nrwcW6qqjCSnvjXaxEtDHzCYp4?=
 =?us-ascii?Q?EdFTRh9fCdxki8hPvOulZRImJ4/WqN2hHhA4CeCfzWVJMU1swmgvddpjOsay?=
 =?us-ascii?Q?Bml/H2kyDyxHV8ZkskoLZ8PoP5ht7iM2Hh4bsHdrwb+5wZX1sLZrhpeKINWS?=
 =?us-ascii?Q?HJYPgG3N8+UvXkuYy2J6tdRFZhT6NnGnGo5UG4dMi83kpZFEaIJTibGXk+Ld?=
 =?us-ascii?Q?onTqnVy4mqdcStoFAbKHtVJbndxPyzkRzc5LnK/ilHC04OtdRrnqknwDQ12p?=
 =?us-ascii?Q?eg5YHlPsYritppbDKYEHnV6uotjrEyAP1Ddv24iFeJP82J4yi2F5JZFQaz0m?=
 =?us-ascii?Q?7LgMrrG8eW8Innw+cuVn1AIkBaxEyWBTzqs/mx6aathAA/Z0mSMKoCvh6K3o?=
 =?us-ascii?Q?LEkLfIa/h1xdh0Owpn8n+bcR1x3gK3ZI31PPs+UC6mU6S1ivpb4+ZF5D+rwq?=
 =?us-ascii?Q?WXhdGqb04/B+DmSXu94YOV+0uZl/eFPjoxwzO4zBgwQYX3NTZrR0rfLFOVtV?=
 =?us-ascii?Q?2QVmTF87HFq34RdxHBzviVNvQ5OQB5kePqSFaldG78PWWEFfKR8fzps8osgT?=
 =?us-ascii?Q?NfZVgmn1e1uWu91UPwh9uuy+PZLGkUw8GkkauQEKduYMetHcV6iWQffhO3Ha?=
 =?us-ascii?Q?iRFLUF3SIuIRd66itbvxSESjJPWyJCW7e14AuBgkFHSg5qpdmE3vZxwLh9Oa?=
 =?us-ascii?Q?+jD6Wy2EevHKLLtHjQhDnkukbr6FyluPZyUgTL0++Xb1OGWMMR+S+F9NOofZ?=
 =?us-ascii?Q?a32b51svyADZgg6xq1iACuvRNA6CgvkMdfad3gy6mLd2F4BzunfSZ5C4bgIZ?=
 =?us-ascii?Q?yWkZqNxM+NzYpsVp1DHQDCPlnis6dNe5OdrkpkIxInUQq99W28QHyFyRLhZF?=
 =?us-ascii?Q?UBp2NYG1wta0Zph/rQUaZWrul7JBkyh9Yg54awUSb6U9rGDCE9050PG8h/j9?=
 =?us-ascii?Q?+Tkzu+aHlxUgqe7XHd6dFLoIORKazn2gXzndTdrltj6ZgJE8asuMRAMmzuzB?=
 =?us-ascii?Q?7PJ19/KxAiC0Jukn/hdSmLqdQu1KKdHHkv3CzFCO4EZ1QAjtL5t3RhXHlNBF?=
 =?us-ascii?Q?AVXnJIa5OIq1+txCNsMYgd1zEOGH8kUrdwmz+BkFAqw5X84tuNrYdGU4xQ9Y?=
 =?us-ascii?Q?w0eIfLOqwKss9qYSVKl2h/sYXUs3UxzXzxrLO66X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babdcf8f-33db-4b05-a45c-08db6db1d9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 15:04:43.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgKg93w/PgadNWabLa8Zb60ZFn8O4Ib5cXtRUJYjRmpMXlbsR/auI9C+uo7lfjxdSW9GRdC1NZ+nSuOjg0Y7YkiFNbjYwTaN+FQh+4y4800=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Joe Perches <joe@perches.com>
>Sent: Wednesday, June 14, 2023 9:47 PM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>; linux-kernel@vger.kernel.o=
rg;
>apw@canonical.com; dwaipayanray1@gmail.com; lukas.bulwahn@gmail.com;
>corbet@lwn.net; david@redhat.com
>Subject: Re: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the
>excluded check list
>
>On Wed, 2023-06-14 at 12:49 -0400, Michael J. Ruhl wrote:
>> GEM_BUG_ON is usually compiled as WARN.  You have to change to
>> debug configuration to get this to be BUG.
>>
>> checkpatch flags this a WARN level issue.
>>
>> Since this is a i915 local debug macro, allow its use in checkpatch.pl.
>>
>> Fixes: 69d517e6e210 ("checkpatch: warn on usage of VM_BUG_ON() and
>other BUG variants")
>
>Not a "Fixes", just an additional check

That makes sense.

Do I need to resubmit without the Fixes?

Thanks,

M

>>
>> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> ---
>>  scripts/checkpatch.pl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index b30114d637c4..d3ddde4cd63e 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -4821,7 +4821,7 @@ sub process {
>>  		}
>>
>>  # do not use BUG() or variants
>> -		if ($line =3D~
>/\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-
>Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
>> +		if ($line =3D~
>/\b(?!AA_|BUILD_|DCCP_|GEM_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a
>-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
>>  			my $msg_level =3D \&WARN;
>>  			$msg_level =3D \&CHK if ($file);
>>  			&{$msg_level}("AVOID_BUG",

