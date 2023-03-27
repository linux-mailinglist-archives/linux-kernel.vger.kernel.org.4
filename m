Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDA6C990F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC0Apa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0Ap2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:45:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318249F5;
        Sun, 26 Mar 2023 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679877926; x=1711413926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3AoAnGCMCtvOUZDavRh1iuwNHoi8vQlwnSL9zKV5Pe8=;
  b=dsIpH5fIzcOJQgjhiHo9cw6iHxudoM6Cl0kSsX9X2OjSpTd1w5+iPFT9
   iVoO/bXKbcx6w9ZsmhDfPsboVRcHUE49c8xleZupjdQXwc3lVhKKChyOp
   J3MUryXnciseIhXnYNuKqYAHwh7Af8H3RzrXfdIBV6PG5EH3kk6vuKRdv
   cDATKBe858YWA7FQ7e/GmXCRKIvyb2xh4ePVOmQpK84+34+5JcpaOYxF0
   Y3eOzOiJtPAP3cycwa6Q539blDTud6gdcDVSVZ7ok3c4ArdqLTUClh5sR
   HrnYnmWavFZoP5LS1vbHqqhTlurKAkvE0hsHhOEJyar8NJAf3snEExBA7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319806614"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="319806614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 17:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="715888228"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="715888228"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2023 17:45:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 17:45:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 26 Mar 2023 17:45:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 26 Mar 2023 17:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx+rPe22Z1LeNLup7YKSts/z4eHFBsuCuB4pmZDJHFrY2vYBHOJA3bP7/uCX1jb5mOjMEaCkvU761Pn474wKxp5n65GiSkb7i5a21kSKUHHGIsdV0+UvUJkccuEsYknelvRd645JsBAhKALD9IHuJIYYtcu6NZOFVLlrUPA3DWKAeDuschmeDp/lDyYTm6KC/YSPLH6RHG778PR6krY3LEBez/DO5ulnWciIYBn92YEXKXwbhxqvHbJFXYJE8/R1WhHvTdt6IlWMaO+HaZBihl3eEfV2w8YfgKz1KTNycitrWHoXZL+CVU8FVbdRUcVlQgi3bAFCAQCPOc+Rbh/zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVyGv5XSBGI8mG9Q8HbPreNOhApFdrSDj20qZqOZPXM=;
 b=ZXJTzWyRr0SHHzi5yJax8ZkwsWdIRTZMve+TivUL3suN5OGnFh6sctXgujo+F4Y6/K3PxCBz1ZM3BDkMUwn8GMzB1/dVVheQl1qtsHTdz7X9CzwYsz1MbsnA8FQAY0icL2BBpqwd643zWO1HOsvDsoxXJCdTIILoRtC093eax+b8Hlyr3aYeG6CQfRWMjprxeZ5VWsNy1y3bldFSBStNH0wKJH+5neApAXAaWlTenM2X8PP90ZUYZjfnEX1aohT269xmiIx1DlwNt2tmJwgHbEeLwr1NyUOGXqB/WkoNA3X836qmNriuRZtr1vDvaaeK3DPcIAlKdA64RyCSbN5zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 27 Mar
 2023 00:45:21 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242%9]) with mapi id 15.20.6178.038; Mon, 27 Mar 2023
 00:45:21 +0000
Date:   Mon, 27 Mar 2023 08:39:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, <dave.hansen@intel.com>,
        <ying.huang@intel.com>, <tim.c.chen@intel.com>,
        <andi.kleen@intel.com>
Subject: Re: [PATCH v1] Documentation: Add document for false sharing
Message-ID: <ZCDl1o16eZDx1HW1@feng-clx>
References: <20230324071316.167337-1-feng.tang@intel.com>
 <ZB2baIDIPhxj5Vdl@debian.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZB2baIDIPhxj5Vdl@debian.me>
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7a0dc6-05da-4b84-c6fd-08db2e5c8b32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AWSF0bl/bc6p8zQmotT9g7rgIDywi56/2gxW5y9iuUUh2jlpMvLinQ7OipDmHDBCb+kwikfMmbUTYGnvakJvqXTLF0RybtGVVcKQwdtQ7dTeW7nNbJnpIk38IbA+hewQ2ZDJwmofZwk8rb/TQgohRZWYtklSn2OaoVyUfDp2s5x5HMCuWTCjGjjyEhhlz4amEKbL/+5c/cgFhSIYvcdH1m7w2xVSwXXqbBWLqpboJsjYc8grkML5iuhQFevuYr8iRE6up/gBJxbRhWxcJBV8ABweQud1J0AXmiZBDhZiADFFdtAfRRuG/WLThzZ/YGV0qDfW+HtOohOR593Ce0Ni3E+7lKXXcKQnW6166F8xrAxLzlZsSCNUcbBsShn6FSuGxhByKuj/DaCbQKcWJmpOnzM1ImVyD0tAg4qI+neuw+basqBc9SR8xjEhRPKTkaqYpd7LplSVjpM9vkg9kyXouBqu4hJCn18n+p6Atgs5a0uYFdkvTLyk5oYeCTMo/V+6Cqf2eiyAgFL8vygH6ue75u7879ddRZjKLNYeXt9yUZqZD409FynbXkbjdK0/xOR5DsElC7QbtK39EYBPehc/hCci2CTutBjetSc3dIZnik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(82960400001)(66476007)(7416002)(44832011)(54906003)(38100700002)(26005)(2906002)(107886003)(86362001)(33716001)(6666004)(83380400001)(6486002)(8936002)(4326008)(41300700001)(5660300002)(6916009)(66556008)(8676002)(6512007)(6506007)(186003)(66946007)(9686003)(316002)(478600001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Byd5Wp9oFsipWe5KaYN2ydlK+jm+iTSjlMYJeRR/6iGVXmZ4zT6vMofL/d5?=
 =?us-ascii?Q?aQu9yclAOHKpnwfEiDhYET+SVdM21MGoK7vYRG91Zl3fAvlxG7RCVd5+2Q4P?=
 =?us-ascii?Q?pWa1P6B2Y24W+ldzINodt7qYL+VkGGlBH9+Db01kJdjrkfDzmob0akdlBKZE?=
 =?us-ascii?Q?8fTTUWGzZVI8GDM6CmUZCgt1keiW2mpUjl+fbvIWuXoOXFRpN/a4V0l64xxK?=
 =?us-ascii?Q?nv3I0Vd3MKDrskd601YVgqP4TVwN1Fhpx6Rv9UYLFEMv7SUf0Qyyg2U14I0V?=
 =?us-ascii?Q?GXd/I83FbCIPH/qiOD5P+NA7o9Awb87RVekWQETUaMnzarKAGqIsZgQqdD+e?=
 =?us-ascii?Q?noXNrsRDJQoAWQv8QROwFQs1Dx4me89QUfkRBxsuIkR9mpfbQ0QzuoCOyomi?=
 =?us-ascii?Q?TUrsP3oObopj+uKDRrTorduRyHy7QTTWEKm12SZXhnjhHWKOSSGh8L5Fp69Q?=
 =?us-ascii?Q?kqj4D9lxjJ1Pas7W93C09gpNRcLdmyJBGI1zODwkXn1EeLvJGQo2ZD5FC6lr?=
 =?us-ascii?Q?B+RCJDSQfEJaa+WiOu0iA6Swo3O58bqmVOht+30cTMS1fhUqXXOKWts2Ov7D?=
 =?us-ascii?Q?8G6XnYXkLBIOI2IXSyjREK3uZzfvNY/ETUg423FUqgpIVSAcMmTFEEU9cbqc?=
 =?us-ascii?Q?+UKuCypjAtqbBl+CFEK4bf6jWlloOu8lY/D5Oqob2YuXwwvCgxwMUaGWZYE4?=
 =?us-ascii?Q?Q1ATkg4ne6kl5ivj6N9coK7yuludORvK8loBGsbH+QNiYnpigWlSAby1/Q5z?=
 =?us-ascii?Q?Fl+ngq+N5wI5gEdfGb3iQldspB4z1eZaEj3KpXFrOU6qVuf0EsB/83V99rRk?=
 =?us-ascii?Q?9uJGpCAvRON1CK30lK+ozDA27gylmHXRkq/sECKFEnRDstO0g0n7z+Ja6YEe?=
 =?us-ascii?Q?EtoJ1XD955uKeL3JFpOEuiFvcBWhk5RXSFPE8xVlS2yLrbvBhkQ3GLGPs42s?=
 =?us-ascii?Q?HVE52lPiQCnivOsNN0zQVMPJZizrizbPYut7XucHouQWsyC8BmEAKLnAY7gb?=
 =?us-ascii?Q?22V0bgD6hULIwe5JuiXfrDeUBR7V7jjNt6JMhp9mPptAgG94igAQ1Hjt4RKb?=
 =?us-ascii?Q?R4sW7ugk8WkSEI2i+vRDsxcox3bwcBLHZGyU4naolxFpkFcEYnUBTIkC8Kjo?=
 =?us-ascii?Q?+tT+/r46qZHTVoi0BPrf42SJDiNpn2QSKjzihFCkgti0ppFE7PM1ZQ4fpKPV?=
 =?us-ascii?Q?2OCv5bhXYMm798kMC5jOJ3d6qoagBrlnOjf3waOOtRV3m/0ZYx+Xbv1/H3K/?=
 =?us-ascii?Q?I5SuZyWcblqv7hHvLs/Sc2NTi8fR+q3PO2kGzZT2iiuYfYb1JxEA8FBvrWYS?=
 =?us-ascii?Q?kSdLukOK+Skpfj7UHJTUr/saYbUlC+HgPaIl6V9O6fcPnYapACd4lm5PEayS?=
 =?us-ascii?Q?Hv6cKIiHEGGbWCI+3s8338csX6xWtFHAIvV8+xggFvl6Jw8jFsl9GjvIqgfg?=
 =?us-ascii?Q?MxpHrlUyALlJrwCm7qHw2nz9v0gLtJQbLMILoV8oc1oHHSnxA3eZk/RYB+7U?=
 =?us-ascii?Q?HgNL6lfRjhUFU4fU6dZPOFn1pSiwsz5xeWcuCE3f+lRGvBz3OsS7p4hrHLnV?=
 =?us-ascii?Q?wg+5XLpYXZd/N0OcDWxOLGNCEiHDFK0KQ7D8hr/g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a0dc6-05da-4b84-c6fd-08db2e5c8b32
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 00:45:21.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcGnUeQuwZh6wSav6dINry1zmKF+DQEa3mxK0zXxwYhHI5sF2azhVc/l6gi40xbpYP1Bpj6ESStwW5RC/PU6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas Sanjaya,

Many thanks for the reviews!

On Fri, Mar 24, 2023 at 07:45:28PM +0700, Bagas Sanjaya wrote:
> On Fri, Mar 24, 2023 at 03:13:16PM +0800, Feng Tang wrote:
> > +There are many real-world cases of performance regressions caused by
> > +false sharing, and one is a rw_semaphore 'mmap_lock' inside struct
> "... . One of these is rw_semaphore 'mmap_lock' ..."

OK, will use this.

> But I think in English we commonly name things as "foobar struct"
> instead of "struct foobar" (that is, common noun follow the proper noun
> that names something).

I can change that. And IIRC, I saw 'struct XXX' and 'XXX struct' both
frequently used in kernel. I just run '# git log | grep -w struct'
and the majority use 'struct XXX'

> > +* A global datum accessed (shared) by many CPUs
> Global data?

In RFC version, I used 'data' and Randy suggested 'datum'. TBH, I 
looked it up in a dictionary :),  and found:
	"Data" is the Latin plural form of "datum"

> > +Following 'mitigation' section provides real-world examples.
> "The real-world examples are given in 'Possible mitigations' sections."

Will use this, thanks.

> > +  #perf c2c record -ag sleep 3
> > +  #perf c2c report --call-graph none -k vmlinux
> 
> Are these commands really run as root?

You are right, people can run it as 'root' or a normal user. And I
guess this won't confuse kernel developers.

My original version is kind of too long and full of explainations,
and some kernel developer suggested that this doc is under
'kernel-hacking' and its audience is kernel developers, and I should
make it clear and short, and not make it look like a wiki page or
man page.

> > +
> > +Run it when testing will-it-scale's tlb_flush1 case, and the report
> > +has pieces like::
> 
> "When running above during testing ..., perf reports something like::"

This is more logical, will change.

> > +False sharing hurting performance cases are seen more frequently with
> > +core count increasing, and there have been many patches merged to
> > +solve it, like in networking and memory management subsystems.  Some
> > +common mitigations (with examples) are:
> 
> "... Because of these detrimental effects, many patches have been
> proposed across variety of subsystems (like networking and memory
> management) and merged."

This is much better, thanks

> > +
> > +* Separate hot global data in its own dedicated cache line, even if it
> > +  is just a 'short' type. The downside is more consumption of memory,
> > +  cache line and TLB entries.
> > +
> > +  Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
> > +
> > +* Reorganize the data structure, separate the interfering members to
> > +  different cache lines.  One downside is it may introduce new false
> > +  sharing of other members.
> > +
> > +  Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
> > +
> > +* Replace 'write' with 'read' when possible, especially in loops.
> > +  Like for some global variable, use compare(read)-then-write instead
> > +  of unconditional write. For example, use:
> "... For example, write::"

The following is a coding pattern (for bit operation, atomic, etc.),
and I think 'use' may also be good?

> > +
> > +	if (!test_bit(XXX))
> > +		set_bit(XXX);
> > +
> > +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
> > +
> > +  Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
> > +  Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> > +
> > +* Turn hot global data to 'per-cpu data + global data' when possible,
> > +  or reasonably increase the threshold for syncing per-cpu data to
> > +  global data, to reduce or postpone the 'write' to that global data.
> > +
> > +  Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
> > +  Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
> 
> IMO it's odd to jump to specifying example commits without some sort of
> conjuction (e.g. "for example, see commit <commit>").

I agree, and I had the same concern, but I was also afraid of that
too many repeating of this, so the previous 
"Following 'mitigation' section provides real-world examples." 
in last section (which you helped to improve) was added trying
to address this.

> > +
> > +Surely, all mitigations should be carefully verified to not cause side
> > +effects.  And to avoid false sharing in advance during coding, it's
> > +better to:
> > +
> > +* Be aware of cache line boundaries
> > +* Group mostly read-only fields together
> > +* Group things that are written at the same time together
> > +* Separate known read-mostly and written-mostly fields
> 
> Proactively prevent false sharing with above tips?

You are right. And most of these bullets are directly taken from
Dave Hansen's reviews (thanks to Dave)

Thanks,
Feng

> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


