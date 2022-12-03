Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7126413B6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiLCCsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiLCCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:48:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D830DBF4E;
        Fri,  2 Dec 2022 18:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670035690; x=1701571690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=khdP+3y1X7d3LGZlC+MWbwP5uE0P00l3WNKMqFynptI=;
  b=JaYqubMLrkot4F8GypDZjB2r8PjqRMvWn02upEVzvx99SlAcsntPNDet
   RbY2MM/4fkN5AXbZKhtr0WGd5YmnoMAIphSoi/onU0A6CQp1Smt68PZUW
   8pXfJuA8fVvJOYAyuexCY3orNqtY/7EWAix1/inLp9Fh+tW6NssVYfGJI
   RtiHxK82ZoNU62IqwL6467P1phL+ww2DcDDGvvnDGXkUCTasYXtjyId2d
   Hb+d6k5pgdunatQwzvgRUZ6zlZEmBu3o8TKLL6VtpsuJUfc6pgiO+RIjg
   IpxJhMNU6+/EU0+SVNm5b2SYUj3Nk0zNHVgaWLSH/3z0J06YMbD6uGTRt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317946361"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="317946361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787504420"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="787504420"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2022 18:48:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 18:48:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 18:48:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 18:48:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzQ+JHEG6NJkh4cT2MNEpZaPyfvsAjC6W41w1vb123uriwEjmeU5hJFhRkzwavFNMR9Be+8wOWsnLFW6laArLOS93KUmh9G62sD8ud/ziwzn4Epb5zMPzBPjW7VlKSxAZ/AZVY+IsdBXYNKhO4lGaeX0hXi7dLwXzVTR9ybKHwtOsEZv/ZZLMf8yb+r+oY+4wJTey4gbHcAOgcw4HGetIjK9PkB6ALXA39gbVH/ITfxTVm9I3q6oGTuFJnjXYuuLvlbUUZUdOZ4MXJfseKLWS2gw5Yn9zqBk6QYubrojmds9Aijqp75x/dIk1yuIOT7P4jPxqDMN0dyB8fbE54eL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daNcA3TVzwyaHtsUi+u0vhv54WZBcPBVB44UwTou+DQ=;
 b=GLLlctfSPTS0cxQiE0P18L2DqAxdOhvrSO917q2zcB4/sa0dYRrgs2QGVFWEjYVME1rG10PBcwHvqlDsX4/CFYHCsIlXQKXheaqQEJGKiCW5QUO6S8cqXrbE6tGMwtyXziGaV7QdJ9Enq86XEmHryjCEsgKvZ3+G4Rp2uKdPIWZHNFfhuuiRgEPv2TYfWwNLtHXQqKjqQmsLsEdTLieDcsbSsTygthhO49G5cL55qUYvawyW791b/v+AdmIts998sw7iV3lsCcRPdMCMBfthNd2TieCxGcmd37wXGYwdbjVNZY4tPS/Myz5w4EroSXfTPrAVDM54H+IAOjVqL8EM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4737.namprd11.prod.outlook.com
 (2603:10b6:5:2a2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 02:48:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 02:48:06 +0000
Date:   Fri, 2 Dec 2022 18:48:02 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>
Subject: [GIT PULL] DAX and HMAT fixes for v6.1-rc8
Message-ID: <638ab8e291345_c95729417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6082b7-cdf4-4a34-6a66-08dad4d8cdf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu5SC1ujnaKR3soyDjLkj1vgNe/+YVOKDJm7f9vqoqQJytucqXiE9dcFLeF1wbN+4mVPHOdVXPhXfQHRJincI5vMkUTxhV990G04vrUaWnughAxPzpZv6XXqBZau+mTecbNEAPtba2FsS8nBLNGrF7rxMvZmbc0Uw64IkJwB9lMlqYcmAU0dWr/cr3LKwi63L7kqayvq3qh8C6EuztW6fNbgTXzvzR0ax7lYgZ1ef8147VoKjTQc9TuUKm3/6Y0qAW3/zLlm59JyjeuG2fy+Y+mtUH15moqaqs1uAc/UA9BW0o4VIHGtRxWNQX7JXS65j/OCB2IxEPCJd0SGoM6a6lebXAOhHbmeaE9Kh/2A/pDH7vQye8xR8vKcTVQg4xmVK68R4lZ8IQ87v+fkw8gSfGpPCuhRrgHpdrKuMRdInsv7rEBpI/BXHtdb6lT8g6o73+Dv2wOdprmvZLzajp8yHEdsrDLw6swE3gQPLCPpttLVXJhgs99mg1S9CVvPuRk2OncIuJze/zhKG+rPDA2+fy27VT3ZZwRiw+2mY5cLWf1uZ7LDUsGRWbDtH03AxLmC9S0DrPnQuBlMByIZ7RD+lr8B7QNfSOpQeo+P5NQfCbqPzAXZUBMnh0/3Xzbn/hjqe/+bcCmXe/hK539jV79UFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(8676002)(4326008)(41300700001)(2906002)(316002)(6916009)(4001150100001)(66946007)(8936002)(66556008)(66476007)(6486002)(478600001)(38100700002)(6666004)(9686003)(6506007)(6512007)(186003)(5660300002)(83380400001)(26005)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJG9rKey1epG7dp6ldiRHhv3YM6Hk0ACdS7TwDSz3wdrBuP3NZW94/4TJksd?=
 =?us-ascii?Q?aAfnUTYtFHhHPkolhwk8DFyoqHgRkruG7eSmtiR5i0lTfOexlmRF+aIFinoq?=
 =?us-ascii?Q?dpmAIo6KTBJz7x3oVD+ChlPZQsnUpdXmH0GJwT6Afw60x5dQWoR3d4/Y9JTz?=
 =?us-ascii?Q?6uiy0hrXFH4Pn/VFJzDFNmh+W1RhEv1IpfiQ30Y5x3OOIPsAacya9X10kcDm?=
 =?us-ascii?Q?8clLdRYojB/bR7emlAv04b0JHO50qr3GtxmE9xW/Vs7kC4dJzXGknCanAWVB?=
 =?us-ascii?Q?oyRsm/6ax+Fayg4xF/0cgUys9jKvn1W1SNWx/xkB4lw3eu81OToYhTpgHBRE?=
 =?us-ascii?Q?bSb0VTd4a4NisjS7AHkuwPMq7jfxFZd5d4I9+d3mgtyyPqsZEsfYmYl0KxrA?=
 =?us-ascii?Q?bKULWGQo7J/MVnbRbB1FB7n3V7xT3PfEnxX/YksPqmtxF8QnGbjg/pvoB+P5?=
 =?us-ascii?Q?niu/9C/GKCMQf3r+8aXLj2nF+4g2Y71t/P/+frGNgKy90l2BMvRioA0q6mn+?=
 =?us-ascii?Q?jgxKNOYyH6nJHUg7zoUAbWdJ1AN/47hTkocgRydIhNq7qjq3/71KAUygTkOx?=
 =?us-ascii?Q?fajNSbVHHS7ivTMqjIzhXpMNnlFcvKiWUIPb+73i9MUgYUnM389Dl1x6+gRw?=
 =?us-ascii?Q?xwjtJDx5BV27xtvFMkEdWkoqzOWgfOMNmIzUpzL44geKDopG/qIAzTHVppg9?=
 =?us-ascii?Q?8cosS7XgL3rl9d7pL7BmqYjyNxeaIoY/7M3Ln92CWoT4DKbfjpk0UGlqLBi/?=
 =?us-ascii?Q?Q+LYVJ21WKrig0mHUL7MIQ+C+QoGFWW2JpmlrGBVedGck4q8ezt+snB/2ae7?=
 =?us-ascii?Q?YHKNggbzKTsgAfMzCykgYg80NgQ0vxPIDGGZNQCAT6b/NpQBqZrik+hcqYgG?=
 =?us-ascii?Q?OjhDUQ+tzNuWDCzB9j5OzFAikpZTTjzdBTw3gTVuwLjKAUFO/SGbGORgtm6S?=
 =?us-ascii?Q?dLcsgr5CkRpk7M7sLNuDHz0e+AhCv0xp39JiYLwlsLh4IQz8pMwV5PluHK13?=
 =?us-ascii?Q?9TUHK957Uxgl6nhqU1mSQJ3hErPesm8Jcc6p8ZrQnvIdrh3eeLlQTglibH26?=
 =?us-ascii?Q?qE+1+TeOyEn6BMCwpVW0j+0oFIWizBaOH7qt/+yh7kUAfR6e1r9EBrpxT3qG?=
 =?us-ascii?Q?p/0sWF+jf6ObLr6R1mIaZEH3/4Vro3IUb/sL1T712zira+ODVj3sLXom8orc?=
 =?us-ascii?Q?Ju0qP4V0FfHTPMfWS9jZ8vqSr5jd5HRkkUlu4CZposc1+is5hG2crbYdYBG4?=
 =?us-ascii?Q?gQfOTeK1NmlEBACkweol3HBXbt8vIFJ45FaNKsZ9Xvz01Aa43/KFSSpqeJRA?=
 =?us-ascii?Q?eFgdP0BNmAe1vXQZNUQmLAI9nZS4SFmOjhJ/QtsVzxU/xYSvLnCO97diFpLf?=
 =?us-ascii?Q?Pz0PWEZ9QgakkHYZ6lRIZwNHk9VKj94oPVKvuHyl/fqdBahxpHnge6x9F49K?=
 =?us-ascii?Q?2f8lQTVt6eE9+Ynvtl5lF7aJATy8Bc2yzWtxFtkCOIif2+QH9f+Pmz4HYFtd?=
 =?us-ascii?Q?Q+Be7qjOCoOCsmb4Xx2YWAhSYUKBH7Qng1CiHaDUokPlIm5myMXNqRuJl0r8?=
 =?us-ascii?Q?8vGH6VVsCl2bJAce/DM1fnMewVPrJUk0mCtWhsSLont5AjU2p6jNk+IAVrGg?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6082b7-cdf4-4a34-6a66-08dad4d8cdf3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 02:48:06.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4MPQxy6o//fTbIzS9qtesUWnjDfaOHyWt5Jt525YPSA/JsUkUVg6r+RBgSmzT9vIUytK+uuVPTsMkCGByaq3zq/AhXnvswR3szB0uO9nHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-6.1-rc8

...to receive a few bug fixes around the handling of "Soft Reserved"
memory and memory tiering information. Linux is starting to enounter
more real world systems that deploy an ACPI HMAT to describe different
performance classes of memory, as well the "special purpose" (Linux
"Soft Reserved") designation from EFI. These fixes result from that
testing.

It has all appeared in -next for a while with no known issues.

---

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-6.1-rc8

for you to fetch changes up to 472faf72b33d80aa8e7a99c9410c1a23d3bf0cd8:

  device-dax: Fix duplicate 'hmem' device registration (2022-11-21 15:34:40 -0800)

----------------------------------------------------------------
dax fixes for v6.1-rc8

- Fix duplicate overlapping device-dax instances for HMAT described
  "Soft Reserved" Memory

- Fix missing node targets in the sysfs representation of memory tiers

- Remove a confusing variable initialization

----------------------------------------------------------------
Dan Williams (1):
      device-dax: Fix duplicate 'hmem' device registration

Vishal Verma (2):
      ACPI: HMAT: remove unnecessary variable initialization
      ACPI: HMAT: Fix initiator registration for single-initiator systems

 drivers/acpi/numa/hmat.c  | 27 ++++++++++++++++++++-------
 drivers/dax/hmem/device.c | 24 +++++++++++++++---------
 2 files changed, 35 insertions(+), 16 deletions(-)
