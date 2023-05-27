Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2A7130DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjE0AX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjE0AXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:23:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F31AD;
        Fri, 26 May 2023 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685147034; x=1716683034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9JFuCLTPE45+Dw7KRi33f+v/1fe/HHVRaImO6qgC/ZE=;
  b=VkezAr+FR06JqLwpowNCXhcmOaeed+YP3dUey+lcduBCzHSBg0r6P2E7
   ab6eTdyYinhQcNhpxmW+cZ5yxQZ7IfPyhxYmKRoolItIVK6zA6mgVMsT0
   G2qtxPutK2ElpGst6Od5Fw9YkI/6t6suAtUE6HzzAMdJhau1w4EYSv0FL
   bih/6AMk0qR2z+i9Um6RN9Gn842kgGTfWzmrIsSHCbmjeyT/TsbMUc140
   kEm51780CQw7KP3vomabyIHmf6gOnerd4bGDA39O+N2fYJtKC2NscmLRG
   VRNvKbZjFgZ3VM7Q9ngtM/D9dFiGWYPFh+0HKBK3m9ChnN9pEoMf1Gl8L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="420100394"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="420100394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="736184196"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="736184196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2023 17:23:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 17:23:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 17:23:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 17:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiIqLz3l+hkb6RuXxyOrRlRTQedHIQEEoI7SHcMwF+DeXewv7ereI0WU5usf6EASw4rNTep/Tk7phAL6g/O4d/6B+XGfDKuX4Qmw/NSwCdAjSW2kf5EXZ7oR7v/RkhLbGxbJE6sn16u437hq90z7Pj4t48agOVunMW/JY/lFvTr1MVpIBB/ckjt2sM0xgUFM4BfXiyuwKrAE3x3PkYgNS82fN+eEkw8B7WRJCBRumUf3OVFauLJsWyfZvPh4hZ0sqHIRxwz2Sejkl5uQ+J/ahZDUHrvQxgTkjfCqS5O6tm5tdnfg0m5zyvOtir2g3/KW2XbmBeLVkgIaQ9gzFl7EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8ny+7WifwcrP5RFnFqeu0SLE/hdqpj07qpMo1nyoCM=;
 b=XUqAeNWQSvFHM0CFtjU1DKeF9Wr1iFExfZxnWeVFvmkXMY6iGSS3Y0+pAWOzBm3HbQz89HMlCUrytMbbc/hcKo6oXNsEor+fCPi0pA8cvmaUTbSGc2BRhaMwe0TBEg09Bj0bBJ5iGmMVOACK1uNiI1ZFzPQb1GbNEcHEkdgXDIIxNFjKNEmg4Bw9xVKHO1YxNr++CiVHRiUIqV7th8Ggyz+fubfw56AveTfopuXEpv625WQtUgffErG9KwEZ9e9If61GsxIkJgEtZ8DYcb7KV24a4NOUzORG2kiR701Wipz5P6ZT4Vqvi4Zmtui+Z7dwH2NMtVaRGW3Dfj/JSIDhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Sat, 27 May
 2023 00:23:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.017; Sat, 27 May 2023
 00:23:51 +0000
Date:   Fri, 26 May 2023 17:23:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.4-rc4
Message-ID: <64714d92a5ba8_1ec11294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 173a8462-9475-4725-4609-08db5e48a54d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwKc8bJbdIHIqdXVUHVdjOMmrXh0jIDA0oLbbW1V/1NXHbh4+P2ZDQqFCkezSOHdkvdn4Q0Q57GYR+LxJlPDT333IxHv0r/lDfTmKWky3BcL0pSmEjTUXkaRdXjAgNvoq19KYRx+vO40AZ7zt8eNpjcNwIh9sAKfrMct/3StMQAtRXx+q5rinPCQa553I9dk9nEJo/BDBV4k+o785ptiy9ghoqJn1n82ifjNbecNNJjfMs3BDGpVlTPno8EE/BEuzJDJF4TSqn0ePHESDmjYH+1J1xQ+rZr4yIvQDQ23pO4amyODSxdXEoIo8HrFmkSyZSTOWzNj4tv2gunIGyyKrdjNv6NR3Yegx2NzE97zNGQX/paLoyFu95tcFgkMy+oAid7qNeDYAPRds61zaIrDQXciwxIeOQ+nvf+Iwx1Ej0z0btamsFZp+yHI174J6icVnhliH9fovkCOepD70KhEkq7yVPWMTQhz+A4r+q3M3sAHnhtrvxf4m7GxZ5OA4YY4u8eYDkyg5OgrWmM06QrJUDkaU/kzShYVQIB8w9hItayJcPEAUdr/YwmLqMZmXS40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(6506007)(26005)(9686003)(6512007)(2906002)(186003)(6666004)(83380400001)(316002)(66476007)(4326008)(6916009)(66556008)(38100700002)(66946007)(41300700001)(86362001)(6486002)(82960400001)(478600001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxX+xwXoK5nNeKZ8a03HjuZhVL/i4RQyodEUa3epNwMo990Y0uWje2Dmy3gR?=
 =?us-ascii?Q?aKBDHzUYMUnZNWf7xMq55wZtrCuVTjjKcS/KfEfOrBJ97NJZUVgp2LCtBjfJ?=
 =?us-ascii?Q?XocfSVJxq057noX1fZnjC/udWhqP55hj4bBCSMkmsWIgR1bRegXXvM70bSyo?=
 =?us-ascii?Q?rib4FDRjs/ktZOYbBhS+pUIBCWQbSFoDnAzhVZsnQQx3oQE9SLu0vkQFvKYC?=
 =?us-ascii?Q?jxrx3Gg++LvTQPfXYWOASEwnip6GOuzU5u5AlJ7MR1f66CSLAsz3n/i3084j?=
 =?us-ascii?Q?OzmLhL2lR4kW3EvazcsgQ47U5Qk4EHN7s+gGQPBRxGUvmC8B1qMyyHpHw4M6?=
 =?us-ascii?Q?k8lz7pqMHsF5xgxjELb6Md2LHfAhQADmXrXjInq7WNUJLHbBXCVlRSqUdRSU?=
 =?us-ascii?Q?+UUWCD0DOmTlOAGOXhpSdQd62rv6UAtWgoBIbRY1v4SSezepdYot+lBIQ9yI?=
 =?us-ascii?Q?joYBCpp+3pOwZW18TX1PHH+K7WQhyy56B1vn+zUS/tCNNmLyRSfvcZARqBeP?=
 =?us-ascii?Q?1G0+EpMrolu5aZN3q4MnmU5uXWRExIv5XfRTX3+vlY1DXG5xfvhwh/TRynMe?=
 =?us-ascii?Q?ExKwcBEtSoKwWU/hOyxCd314mSvVcj/X97lPJNW1Hx5cDKBchKiNDtJNK7pN?=
 =?us-ascii?Q?vBviBi6b77hkds9E6ICUo+8j+CHzZR6CBn+gsmUKS5BXPjKA3dIJXja3IQja?=
 =?us-ascii?Q?TVLddQVMIR37oU2PiR4ryW73MIKJk2jimMJpJM/bk4KuU+mrSupZsjwsnYz5?=
 =?us-ascii?Q?P+og1ZxWzbA9VATc2dxBRCTh8FmCROpnYjeYppYzWXC4WQCaIxn9DK+mX0+e?=
 =?us-ascii?Q?Xktq38i4WfphEp0nGZ0EFm5pgcOKq6eF53Vy0lr7dFBki8nKTl9pUPLtOm+d?=
 =?us-ascii?Q?kIlj5xpx1ARohPZ8t1VKk/R2Bxh/CqlesKWSvD9cYIesh0E8lbnjEc1KM8Zv?=
 =?us-ascii?Q?VuLkhVHQ4T6TToX7wd3tMbKZ4wMRpRm9vxWJFTvO27X2D4S1tJNOgBnjeSlX?=
 =?us-ascii?Q?KQqmnK/c1xbzKWXD3kVt19rtoVASJuI6piS8cLY47abGZCntklGoetLvnwXh?=
 =?us-ascii?Q?Gj1Ho8W4wZ0wcGM4+WCthirAuOYfDa/LISljP8ZTLpv+5BUbMyCsX2SwxghQ?=
 =?us-ascii?Q?0Qbrd5DrVs+eMJ7QJ8qE7ni8wePi9lktQSweZwkEn53/8B1hUUjmq+mmsm1m?=
 =?us-ascii?Q?wETQQftr1TQtecRusEPhMW4Bcu2qAUpD9l7n7pJ5sq4FAULY6ek2V/YgqcW0?=
 =?us-ascii?Q?zfVlDp6q+y4s6DOp2vN7E4zDyY9YrZX3qKbi1KEXZUNssAne8b7YlvO49/nS?=
 =?us-ascii?Q?mKRfZIijC5iA9X94pa4HFsaXVjXys8RaRkLvpjC0SDnV43wMkoHQ76Rb1Zog?=
 =?us-ascii?Q?fVNTHUVZ9rT3q+5IoWS/eNj3GunzL/D6jbouC5GNlP6IB5aQ3xd0krQNQ9Ci?=
 =?us-ascii?Q?rmjHxgQ4g+uEEAd5APAtGH7y5Bnzk9/3XVYc4FgHJ8h+qqEIs19NLg5oKp+m?=
 =?us-ascii?Q?/YzWHcFHPZbDzeVdZxe8nHMuzutfEiv3mAROBen/qv1S8YqRQw+y+fk5fCqL?=
 =?us-ascii?Q?i6ogzDPeAE+uQLt5KmFT7sT0X9R1dem1qXMLTPw62FsFU3sS/nKiOtWC7mj6?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 173a8462-9475-4725-4609-08db5e48a54d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 00:23:50.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfmJDiV2jn+SMJ/4dZ48mC4U22I4dIabHJKlEdMaKNE8ZwuQELuCelyTkgUsNTRLKB+HX8fukjkGUSWxqCB03LB30/sKzTVkMUfEI61Fucs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
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

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc4

...to receive a small collection of CXL fixes. The "media ready" series
prevents the driver from acting on bad capacity information, and it
moves some checks earlier in the init sequence which impacts topics in
the queue for 6.5. Additional hotplug testing uncovered a missing enable
for memory decode. A debug crash fix is also included.

All but the last patch has appeared in -next with no issues. That last
patch improves the readability of the fix and is low risk.

---

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc4

for you to fetch changes up to 793a539ac78843ef9378bb42a44edfbc552a67d5:

  cxl: Explicitly initialize resources when media is not ready (2023-05-26 13:34:39 -0700)

----------------------------------------------------------------
cxl fixes for v6.4-rc4

- Stop trusting capacity data before the "media ready" indication

- Add missing HDM decoder capability enable for the cold-plug case

- Fix a debug message induced crash

----------------------------------------------------------------
Dan Williams (1):
      cxl/port: Enable the HDM decoder capability for switch ports

Dave Jiang (3):
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move cxl_await_media_ready() to before capacity info retrieval
      cxl: Explicitly initialize resources when media is not ready

Robert Richter (1):
      cxl/port: Fix NULL pointer access in devm_cxl_add_port()

 drivers/cxl/core/mbox.c       |  12 ++++-
 drivers/cxl/core/pci.c        | 112 +++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/port.c       |   7 ++-
 drivers/cxl/cxl.h             |   1 +
 drivers/cxl/cxlmem.h          |   2 +
 drivers/cxl/cxlpci.h          |   2 +
 drivers/cxl/mem.c             |   3 ++
 drivers/cxl/pci.c             |   6 +++
 drivers/cxl/port.c            |  20 ++++----
 tools/testing/cxl/Kbuild      |   1 +
 tools/testing/cxl/test/mem.c  |   1 +
 tools/testing/cxl/test/mock.c |  15 ++++++
 12 files changed, 153 insertions(+), 29 deletions(-)
