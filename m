Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6575B3DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiIIRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIIRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:16:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D9B441E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662743773; x=1694279773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OX8bw6nksb+LKtCKQS5vOOM1Cc1LoEMflw6KFTVSY38=;
  b=YGFW0Hj+svBYdqdem8HYZfNq46S+0SHmfFKpgOGQSx2JVhGwE3Ey6Tv3
   ck9a2yoGfEl76CfD/v6W7zYgM8bDfgRuz8AW6NmnMRjSY7eh5eMUkYn+Z
   wBJbBPM7Qd6NDoM2CzYE+hSPA48j26kxKmuOv6coObjzD5hYoZw2KLGXJ
   GLMohoGmQxKWJoVgbYeXFFFMkZRGsGtcUqh9pGRYxvcEA0IcL7xibA7XR
   7haxIZBVyRLdI/GHa99QfwvNXMYLX5oZU27uR7YLOfZvl+8jHoEMp58LS
   QiqVdQh+XXMqwt/7KPxfOaMb3ucjFVycTxQH5bF2eeSr6vESssNHQ27eT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280548263"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="280548263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 10:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="790881391"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 09 Sep 2022 10:16:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 10:16:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 10:16:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 10:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVTxO10GxEXPF+8tQWxjsbt5JgHKI8oz1r0d633migNqrQOQYJ3UEVLLD0ZPwlD9EaRYbqdEnaDHuDlrA1RHz5m4igflP1tOcsKHtO3yLpVZ5SNu+ElW3pULYf6/9yxNcWRgnfjnvzf8vizaURlEs2ANbkTxFsbgkvVomYLtbnYAQZWqe21CHZW4jF6DIlQC4zlWvhU09ResGg/RG5Rg7BvKH58UF/Gmj9HpnQkcxo+cWr9wNLa9Y88SD69AGEq3HTYdo5yQzlAVLfbYoQ9y/8CXQoFOuoUCOXXpVHe4PeSD/8xeP85BYMt/mfsYVBZiOZxmp68Xng3Wbcuh3M0hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGStcmkE+slpngGFvmrS7LC2OQxb2ym2yY3V2MPpDVo=;
 b=jqrfoOElhhGNDCLF+VV0VHQCPTKEcAjmjS26Hz64nvsfPXnSJ5OiJTjtAdbQvxN/aEqJydYHhM7ihPRewNcx2HO47UvPjS5OpmjY9WRfwGE8XvHj0Nh+HLuDzFuO5A+MsjHXkAhsyZNzctb3aFhviPn9H6T5lkn0DazgDdVAa1ET/Cl33b3kZ4hmN9XCTXx/jVlukq+2os/EZVxNjB98JlQgShGYrcaZnvg4R9hKAZnukvuYZ/EbH70zMQFtUh2lIMF9lJX9iM2x62qQo4dfCB8DYQ5lXWbI3w+ozXSnDvJHxBgcUYCIDjFTdrhbiYub9q96h667MBT/QJK5j95A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.23; Fri, 9 Sep 2022 17:16:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::211b:a022:39b6:5d2]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::211b:a022:39b6:5d2%5]) with mapi id 15.20.5588.018; Fri, 9 Sep 2022
 17:16:10 +0000
Date:   Fri, 9 Sep 2022 10:16:07 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [Intel-gfx] [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Message-ID: <20220909171607.ntchts7ykjrno73p@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <YxDLFWjIllqqh9de@kroah.com>
 <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com>
 <b959d485-5986-4524-8a84-6086f1076cc5@intel.com>
 <a3512279e0ebcd7c4d60926f118dbd435e0b7819.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <a3512279e0ebcd7c4d60926f118dbd435e0b7819.camel@intel.com>
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130d6739-19b8-4941-a063-08da9286fd36
X-MS-TrafficTypeDiagnostic: DM4PR11MB6504:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAMje5l2QfTQCjlp0RxsCtlT+A7wl7woM/oylgLkP0Ma5PI7pyOAA5uLGuLBizeQwDzGykPgsIisrmFOVZUeaos8oQIWIFGajjoqP0bFxB/0YwUYGI1ZPnKQJYFO570As/QtQcosqP5Llb0lMwS97l0n6f6sClHIRz7Hb7TE8HQDyaWDS4Oi4MGJdDhkCq/uU64F1yX1hFJ1nNpBwL3OQKXPWOqDL4envtsgI21NauTAkA61we7pq0JvY+dEzeClubJn3hTM/id7JIhHZvvC2D5u8TPaU78uuStHbe7luyfywkj7buY84LAA17c5NK7S/g9fCM/nhVUBfFoziUle4k7UFHXe9IV5wKlFSA0E/XinDsKDwtL10+oSIo6AM8K1U2n60WbqA/yLgqONOIEB+rI022mS5Heas8KRNDwJrse10buFRYONvsrYHjsk5/Likv++SZ8ez9imtO4Nnx2z8rqAWbeQiXib5vG9f7U8H1d+l829GtIxgqYY8B2oAvrL8nR3GCIsYr82BjfcLWmAIdxHUZ7sw7N6Kfj0AwhmVA043Pid6Dr6rYbCdDHBdwWlACwPGrl8UHlzOG5PRXBfktKXYmwGiQodvn10xVRwVStChuDnNuITQZQODREBUWq70t9yA32YNdr1a3SR/CQ9X8SUGv5lkyE7ULV/q2tkKbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(38100700002)(66556008)(36756003)(6636002)(316002)(54906003)(41300700001)(66476007)(53546011)(66946007)(9686003)(6486002)(6666004)(2906002)(6506007)(26005)(8676002)(86362001)(478600001)(5660300002)(8936002)(83380400001)(6862004)(186003)(4326008)(1076003)(6512007)(966005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VG9ZrzHFS+dT9YNgAtdF6TWpfi3TUgsVAdcfsayg/DDU4b8h5UauTOTu/eD?=
 =?us-ascii?Q?IfZcCZWSu/qjfO4ZaspAOUj7nLKVoLdN5ONe5qieBeG1+W+SZq0VYDfRwgSr?=
 =?us-ascii?Q?hSTnB493WUeVG+8OcRHYxjn3shwJ9q+K4xNWyYKwfit5xrUw2e9zxJx4czvL?=
 =?us-ascii?Q?wC/HwZQ2Sahc5MEtyzN/Ah1CyILWfs8KB4NNXblfYLkZ5ZjMhPwYMPeSEkfI?=
 =?us-ascii?Q?c/9tmd52wqy69gBh+OJxnsrbZA+DyLWLXxDIMWekrg/G7ilikalVnQ5CR/rD?=
 =?us-ascii?Q?ecQQTqddDd99iaFSPbFLsXYz+hJX9KuEY6GhGrFGaycCtkKIimm1R9En7fOX?=
 =?us-ascii?Q?1J9DhndtT9AC/q0q7txlb51rsJjTkgVOpVUtH47J987X4wZ+riVXlbGWEWwH?=
 =?us-ascii?Q?Ryg9EgWcMsR7BUVUgRSmItAYya+xUAc9sozD4DHLGcWvDn5pHTXUAHkMOp7k?=
 =?us-ascii?Q?bU4EcwPf2Wqz86AzmleX5hutitw2URVF59SsYgXRfsRZW+rDGDMj6HdJ5TNI?=
 =?us-ascii?Q?RoFFEl/TYksOtVHBSC5wic0OUm4a5+LDV4et94+6aoMcckM6FhKJ5aHY0ILp?=
 =?us-ascii?Q?lhh9m0ZJd3/el4WgOGlPszykIk7bOMFMurb0QzKGUcJbcDug56+I+k64ck6d?=
 =?us-ascii?Q?ieNwLT/M9Z/d4eXhj8fxKJzwlt2mgY1p4JUGFENbhda0DjgIkRd5f5TTGHTI?=
 =?us-ascii?Q?jXgdsDy8TgBCRgRO+f3yDLWeOGsFb5ETjrpFUtaPQdGKAIQILe7OW7SY3mNL?=
 =?us-ascii?Q?rDRvIhYqiRktobgWsHcB5Tq0SfCVWgwK3b6pVLeoneORbLa9KlGr+VywSCT/?=
 =?us-ascii?Q?Kzm+FnhwZ4Gf7DFXaGK3oVQPaDBkFaj5aLyiE52hTYhtCrfDY1KUH+1BEK+b?=
 =?us-ascii?Q?HzCCCNa10iGSUZU5a42UuY6oYz765+JLwV7XPFmVLOoTyFq9oZ6ZcDRWD4JV?=
 =?us-ascii?Q?yvf+6119QPdI0QfN4AvoVE/UY9DypLZ49IE+i0Odssiwa57s6cB6XFFGpjEO?=
 =?us-ascii?Q?WTlOn67Pxg+qK70qC7N07aFKpMGXoYaBmuQN+HhPwW5JHa5ksJverd7Xc6JL?=
 =?us-ascii?Q?nrScICYLX2n5roMXtKk35f37DMzbbL64gFvJWPCVinyz6iAExJJfQkvmc5Nb?=
 =?us-ascii?Q?d+uMI1FSZxXIzWgrLwZRwNnQAMuLOCfHbU6/Ft6/YPT+wUn6rB4e8ABpBQdx?=
 =?us-ascii?Q?hrdFGa5j3xPlD5DE7skD92Qa+NzE5VjAc5BPyqk4vesYJTRZ9y9xmjNziMuQ?=
 =?us-ascii?Q?bPrIveOcRxloXQf+giRCQwN46TWqbnX0h7Ru0rFw/kPHj9PPp+fV9Mo9BIId?=
 =?us-ascii?Q?/RtrhdSo1SPO7tdvJR4UkucUrVeodUCrA4iw94UN2xs/94014rDCy1UcgfsW?=
 =?us-ascii?Q?MB2hZ0VKTTJjA4Nq6nvrP6v65kJkBgNZ6A0MFOs1LjUO3/CwD05BPRzAO8ql?=
 =?us-ascii?Q?dF1a8a4vwWq3c0JtPmT8CL6iY/T8DvUCAWax2R8WTzOIXx31dl0NxCfEHc+2?=
 =?us-ascii?Q?wx71WkZn3hIQXw50cxFHIprlnFiORk7DzTHdUw4HfkcBhI1HCs2URRouOEok?=
 =?us-ascii?Q?ZIUX24jH6oh3+D0eYelh+jUgoRS9rKNkX79xOtJ89xKvDYqFkM00q0HmsHAz?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d6739-19b8-4941-a063-08da9286fd36
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:16:10.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHEmq3u3ww5rDgcWfRuQaWdQ/JI/fYO1IZtBjf4WD9OrdSkF5n5PIHGNz8BLvIvkwIsAsCRTpQHO+gGWQmlMcMVyqlQdjNgZBsgD1FNlXVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:33:45PM +0000, Rodrigo Vivi wrote:
>On Fri, 2022-09-09 at 08:17 -0700, Ceraolo Spurio, Daniele wrote:
>>
>>
>> On 9/9/2022 3:24 AM, Joonas Lahtinen wrote:
>> > Dave, do you have a preference how to deal with the mishap here,
>> > shall I do a
>> > force-push to drm-intel-gt-next to correctly record the Acked-by or
>> > revert and
>> > re-push? Or just leave it as is?
>
>Dave and Daniel, this question is still pertinent.
>
>> >
>> > Quoting Greg Kroah-Hartman (2022-09-01 18:09:09)
>> > > On Sat, Aug 06, 2022 at 03:26:21PM +0300, Tomas Winkler wrote:
>> > > > Add GSC support for XeHP SDV and DG2 platforms.
>> > > >
>> > > > The series includes changes for the mei driver:
>> > > > - add ability to use polling instead of interrupts
>> > > > - add ability to use extended timeouts
>> > > > - setup extended operational memory for GSC
>> > > >
>> > > > The series includes changes for the i915 driver:
>> > > > - allocate extended operational memory for GSC
>> > > > - GSC on XeHP SDV offsets and definitions
>> > > >
>> > > > This patch set should be merged via gfx tree as
>> > > > the auxiliary device belongs there.
>> > > > Greg, your ACK is required for the drives/misc/mei code base,
>> > > > please review the patches.
>> > > With the exception that you all don't know what year it is:
>> > >
>> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Daniele, why were the patches applied without this A-b?
>>
>> Apologies, I usually rely on dim to pick up all the correct r-bs and
>> acks from the ML and to warn me if something is missing, and I didn't
>> realize that it hadn't automagically picked up the ack.
>
>I understand the feeling. Recently I merged a patch from Vinay relying
>on patchwork to get the reviewed-by and I forgot to double check.
>
>dim picks up the "Link:", but I don't believe it picks any ack or rv-b
>from the mailing list. Patchwork does if you use pwclient or something
>like that.

When you download the patch from patchwork, it will include the
r-b/a-b for the patches, not the cover letter.

	$ curl https://patchwork.freedesktop.org/api/1.0/series/106638/revisions/5/mbox/ | \
		grep Acked-by
	$

Patchwork simply ignores the cover and does nothing.

b4 has an option to propagate the a-b on cover to the patches (-t):

	$ b4 am -o - -t YxDLFWjIllqqh9de@kroah.com | grep Acked
	...
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
	...

b4 also has options to work on your local mailbox instead of relying on
the external server to apply a-b/r-b. Maybe people should be using it
more instead of relying on patchwork.

Should the Acked-by be recorded on each patch? That is what is usually
done, but if preference would be for a merge commit to be created and
Acked-by recorded in the merge commit, dim would need to learn a
few things. b4 is already prepared:

	$ b4 shazam -M -P1-15 YxDLFWjIllqqh9de@kroah.com

Lucas De Marchi
