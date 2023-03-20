Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E86C2357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCTVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCTVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:04:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963B14212
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679346259; x=1710882259;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k1kEEYzxcteur9FhqFxW6TSpgrf0rK0Y3YruqmLPAPo=;
  b=IsNmxM7mEFP9VbRnOY9/syZl/aJm3PHtFi8TTzuvOBH3QpWVHrGMgXxg
   h83eALbTuZU8ceLcJy6Xu4pVVWKMKlqFBQBTuLJAHlDSnLkQvQlQcqCvA
   s1KWuSQowzd8CJ4PwS97QN0265fmgvguRFovNnyhiJOepatcClbD96Ehh
   UWujJp4CECR8g2QymllLbSJzDW0zqrnYLPTa+KayC44Iaue2KTlKpZrkP
   br9G8JSkyZOFcKgMG7tBceq0qA4xf6Z9ryEjJd9WOKLaRAfHYYSQPRdtW
   2JVkL7Ma5J29lFowx7P9bLaLY6o3rubsxPlui8b8tVN+soXk/78CWeQQG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322620449"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322620449"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713696581"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713696581"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 14:04:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 14:04:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 14:04:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 14:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3dgxdIza/qLgyUPhz152X1BvhUPYHbh2sPtto9sQXY9EL8NdUSU6Jis5cORbr8ZcsELDPkyNu5YNjz/JrfB0UQP7R+81jKKnJTdCkzipyXt50tZB6cet/YQnmqvAsRCNXpB0EQmOJ4rdFLo8eRpQWCWD56ugJ57tqwSfkH277hJJT22Su30L1P8c74wls72cxMup1+4ArAQ+q8FTsBLLhg5CMjrBFEpxSY4apaPvgpdlvK5etX3PGPqXuJX5oMwMtxesF5Ht2R7mwDD0qBqG04dMXg+e61TfsGZd4gLmy3Xsho3I3Il7emtKfn3PHKXSlW4JerDGxetQOkxT70KPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+p1WKd8GTL79muxvehl/06LvuOS7QKuxvexv9Lb51o=;
 b=FHwhmV0MPrhvCEZOrRL6XCyEZ44lCMZlS99mnRTbiVaaIXAGB3G58P6p6GNOHUmoETbm+p2cSNKMsLp5m4fVBaQCDqWtH2mXwdL3/htOvTdn5T7qO6kDnP74SCYm7xfA94Jbt48EwSutpUFSSIkbCnBvTcjWa8rdxkNXXYxXBtkUZC6jiugPL1lDIbvS48En/WU6t72w8SP1lAEa+pdgJ/g1oUINXRdvv8ZPlu0nUWCWg3h4nCCiNJKmQK3r9N8hYUeJtupJ84yAnDy6w/Kz7F0Dr4G8fbfaCUsuUxrHcWFj0DJeiOzJZ2251W2IFv53FC+YeUTPXcqmIxoQLLQefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5454.namprd11.prod.outlook.com (2603:10b6:5:399::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:04:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 21:04:08 +0000
Date:   Mon, 20 Mar 2023 14:04:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Carpenter <error27@gmail.com>,
        Kloudifold <cloudifold.3125@gmail.com>
CC:     <outreachy@lists.linux.dev>, <teddy.wang@siliconmotion.com>,
        <sudipm.mukherjee@gmail.com>, <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <6418ca43e651b_2c274e294ae@iweiny-mobl.notmuch>
References: <ZBW+NX4SLaCyEnJd@CloudiRingWorld>
 <dd1e1fcc-2a4e-438f-ad61-ef7640b8e423@kili.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd1e1fcc-2a4e-438f-ad61-ef7640b8e423@kili.mountain>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee47b5-0719-4f2b-bb54-08db2986a58d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTYpBs6zYzqlKB/D17amPNnz3pEym9QlQqkn74GXVkQI6nfBNSn3JTEwKZ9tEH6jWNL9hzzHJgLAjL5Vm2s+BAFln1KL2PWMGFPz15n1lWkmDs9Oxntif8ePunANKvx3WpSnrNd1fsuw0if88KSSwDIGNB6iSbBPirDhPCBItVEQGA4sFK6BoXZ2kbg3j6G1N6NEx02G10Cgk8jQA4wsT+hTYwxhmO6Uzab6oCcflFnYOAaDbFETcU4kOBb6EFwBIYTMK23+gAC9X4xBIghiw9dWWJDAuIw9bAr1AFb7rkwtPjf/qpxYXQ5O6lST7cL3gWruQQrFULtOCFHjcrI5hKTr6PSlxEwNAxDrCinK/4G6Yfgp3/pZGpWTWg4x1VZAyD7aff0lC1kQMZlP6qN8K0qObqA2lJiVcHSxQeNccbQQXrScW01N7nCPIrU2ejd/aOf/RHVwU2P4Nc5GnJCRuSNFmn+uBugChjsjR+JT9jWZwXA2XhWJ3DPiCXzKzdMZK5D9iYOGDYDkeKUxGush8H/fsSjUzyv37NC9MrAQ1c0uZPQSWESnD3gCmfAc7kIV9G0Udf5296+E4FWO/9effK4Gb6vm0yTWy9svwJIJvaTree++6L5GWCq5CD2nVuyY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(66556008)(6506007)(26005)(6512007)(110136005)(107886003)(9686003)(966005)(6486002)(6666004)(8676002)(4326008)(83380400001)(316002)(66476007)(66946007)(478600001)(186003)(5660300002)(8936002)(82960400001)(44832011)(2906002)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YZmdrmyii05KoaUX1WwE4R857dEI17FAXqjR/3xP4gFsTV1ssU67/8jTM1v?=
 =?us-ascii?Q?2Bo1bJl8ursHSEXr/UFO6zuU/ActjHbLIvsXl1H6ksQxq83o8CEzaEtg9FJd?=
 =?us-ascii?Q?EQ2wY4KlOZMafnFoRruSynyjKGPdtf0O3Ku9AFpj5vt2t0VyT5JvmynaOvsA?=
 =?us-ascii?Q?v/oZViv3xbYGGsKXYWS/s0S0x97hkC2gG8tn31qB4LTxAcNPHZ910Uzwaf9R?=
 =?us-ascii?Q?xrPGpbCRsZqOgt9E9iK2f3WJaYB65xvFjzSH7VcKtJGYsN3IUdAyVlwOJQYM?=
 =?us-ascii?Q?QLh3y/YR46S+4ViQKKZ3IYx723DHum5IxmReAOoANceo5WZPEaVkrc8euudm?=
 =?us-ascii?Q?84pMF4xRVUWjQoAvbagkbuwSUALeYOOnmxbIF5d28VelQ/YQOmQQC+wNrstG?=
 =?us-ascii?Q?JmjUH5zk5/MUHg7+Zs5uEoHBTdOgZfm1/bLWs+OR0UXF5m+xlkJyl0wspnDl?=
 =?us-ascii?Q?426nDyc2vTJYbugts7pAPcsdJ2h/fPAGYC6o4NxeSf74fJZ1m1iXRhmE+Iq8?=
 =?us-ascii?Q?BiVfoCVD9aqG9mSE9iGH0gk+1qKF1bHH7zjrylDoeCgu1jvODY/Ae9VWkWyg?=
 =?us-ascii?Q?zfSozZ9YPZq81n12T3juy+UoUp4ct3S87VywAL3SyDbALKIvDrUjgoEQhdq6?=
 =?us-ascii?Q?L4M9s9CEVonkEiWOVtnahg7Yu0q5pEN6twAlo5/5lHXelwNpHVQPy9LmwaDz?=
 =?us-ascii?Q?mzsXdq4eSh/SKm8Z3paGnV73XTy4e7K/p2LHIX1S/crpAzWgA+xl8cbGQsew?=
 =?us-ascii?Q?fZHg/l6y86UyUEkZmmvh7mdLe0eAbd+1nmEFJXLTG106lvTbUXQn8wrAMs65?=
 =?us-ascii?Q?RXlON5Q6K45qpcps+NXcqdGgk/LeIY3E5CIOqfVMsYLdgsUEJknIiarFnG2z?=
 =?us-ascii?Q?VKqfQmsLQCkbKArpual2SC9sA00SBi0dE1tS5xRYyMLNct0K0Pr3rjDrePLf?=
 =?us-ascii?Q?zijyQs5HTeSMHRY4LDGoALWUhqS8UwrBfGdIctIICwnSvFls9z5j0A/Q0ouM?=
 =?us-ascii?Q?i+ZUFdbUfRi2qQ3xeshEr9xVNv1cSr5K1+gPcfbArs6CUScfHtQcJd/gXW4D?=
 =?us-ascii?Q?1iMSdrQ0McTWkuig+jinakqkI6BOyzHh8fXvqg9EsF1OInWx6vIy7U1aAI5R?=
 =?us-ascii?Q?XGaxiZ/kwCzuY5XVK4PESlS/+4mo5Z3iahH8joaR4LF++DwAgEkQNsNl1FsA?=
 =?us-ascii?Q?840fu0z+Xfb1sJygwcn0fnuqh1EamMZYeF69c7ugWDZa1i4pzv+eo6h0Qnv5?=
 =?us-ascii?Q?0ehqLSxIZo0PlL7Tfl2/yNOyXMvqIOdDY6zoQ7tAQO/DOuvEuU32drnjZaeU?=
 =?us-ascii?Q?2Jfg4kmUDQXjEb7IGtBWAq91syjoCYLImMZ9SvIwXs2efFbqNFyeYVKYwgHn?=
 =?us-ascii?Q?4bMEkx0zX5YZk2W+6FOeD9WEtcPN6lsJSoTm7IJEvjQ1bO+0m9Nx9Jj4ne6J?=
 =?us-ascii?Q?D/Ys+y9bVfSkVL9H1Uyi3230MTeVw8FcPhLPPXsTeWlmRmkIIU+WKYUcWEAD?=
 =?us-ascii?Q?zAGI75f6G+muc9rL8V/1JqgVOCCXAg8mV5vRQ2fiiLO5dmppcG86NANERSVx?=
 =?us-ascii?Q?5Dqd4x1Buu/e4VgW9BNZwc3b6JoMWJlNFUHuCEWG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee47b5-0719-4f2b-bb54-08db2986a58d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:04:08.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLh1y+/bAJA/8jIwOTzvUNh2+5dRrgdt9mHhYjHsR4b9s3oFFcbk1st6HDR4nqgoX2soNtFKrLP5yMEgfTTQxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter wrote:
> On Sat, Mar 18, 2023 at 09:35:49PM +0800, Kloudifold wrote:

[...]

> 
> > ---
> > Changes in v3:
> > - Add this changelog (Philipp)
> > - Move lkp tags and link to the correct location in commit log (Alison)
> > - Update the commit msg (Philip)
> > - Update the commit log (Bagas, Julia)
> > 
> > Changes in v2:
> > - Use new function names in call sites (LKP)
> > 
> > This v2 patch was prompted by an error reported by the Linux test
> > robot, which detected the compile error.
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> > ---
> > ---
> 
> Delete these two --- lines.
> 

Yes the 2 --- lines are not needed but...

I'd like to clarify because I think some of the tools insert these
automatically.  I've included a bunch of examples below and the patches they
generate as examples.  Please follow along if you are not sure what I mean.

To summarize you should only insert 1 '---' line in your manually created
commit message.  Do not add one to the cover letter either.  Any other lines
which are created by the tools are fine.  Just leave them.

So for this example...

_This_ is _wrong_[1]

_This_ is _correct_[2]

The correct example [2] results in a patch like [3].

But notice how B4 has added my 'cover' into the single patch, patch?  And it
has a bunch of '---' lines?


Specifically:

<quote>
---
Nothing really to be said here.  This would be a cover letter if the
patch series had more than 1 patch in it...
---
Changes in v2:
        show version info example.
---
</quote>


This is because b4 defaults to using the cover letter as part of the single
patch background information.  When using b4 to send a single patch I leave my
cover letter blank.


So if you leave the b4 cover letter blank[4] you get a correctly formatted
patch as in [5].

But _please_ _note_ that there are still 3 '---' lines in the final patch
output.  2 of which are around the changes section.  The following quote is
perfectly fine.


<quote>
---
Changes in v2:
        show version info example.
---
</quote>

I hope this helps clarify because I'm worried that folks may be trying to edit
the emails that the tools are generating and I don't think that is required.

Ira



[1]
13:39:43 > git sh
commit b513858163640433f7938ff93848a5af1e675383 (HEAD -> b4/outreachy-demo)
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Mon Mar 20 13:14:51 2023 -0700

    Documentation: Example staging doc change
    
    Update the documentation with an example showing how to update the
    documentation.
    
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>
    
    ---
    Changes in v2:
            show version info example.
    ---

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index ded8254bc0d7..2de034ddd059 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+Fixing staging documentation somehow.
+
 Unsorted Documentation
 ======================
 



[2]
13:41:03 > git sh
commit 352cbf83a2da890ba974c043ae6047a625210ea2 (HEAD -> b4/outreachy-demo)
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Mon Mar 20 13:14:51 2023 -0700

    Documentation: Example staging doc change
    
    Update the documentation with an example showing how to update the
    documentation.
    
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>
    ---
    Changes in v2:
            show version info example.

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index ded8254bc0d7..2de034ddd059 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+Fixing staging documentation somehow.
+
 Unsorted Documentation
 ======================
 


[3]
<email headers>
...
Subject: [PATCH] Documentation: Example staging doc change
...
</email headers>

Update the documentation with an example showing how to update the
documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Nothing really to be said here.  This would be a cover letter if the
patch series had more than 1 patch in it...
---
Changes in v2:
        show version info example.
---
 Documentation/staging/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index ded8254bc0d7..2de034ddd059 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+Fixing staging documentation somehow.
+
 Unsorted Documentation
 ======================
 

---
base-commit: 38e04b3e4240a6d8fb43129ebad41608db64bc6f
change-id: 20230320-outreachy-demo-bfa128532a93

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


[4]
Cover example

# Lines starting with # will be removed from the cover letter. You can
# use them to add notes or reminders to yourself. If you want to use
# markdown headers in your cover letter, start the line with ">#".

# You can add trailers to the cover letter. Any email addresses found in
# these trailers will be added to the addresses specified/generated
# during the b4 send stage. You can also run "b4 prep --auto-to-cc" to
# auto-populate the To: and Cc: trailers based on the code being
# modified.

To: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>


[5]
<email headers>
...
Subject: [PATCH] Documentation: Example staging doc change
...
</email headers>

Update the documentation with an example showing how to update the
documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
        show version info example.
---
 Documentation/staging/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index ded8254bc0d7..2de034ddd059 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+Fixing staging documentation somehow.
+
 Unsorted Documentation
 ======================
 

---
base-commit: 38e04b3e4240a6d8fb43129ebad41608db64bc6f
change-id: 20230320-outreachy-demo-bfa128532a93

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

