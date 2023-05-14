Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDEB701E74
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjENRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjENRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:07:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330810EA;
        Sun, 14 May 2023 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684084060; x=1715620060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qmJ3ffFP++Wvt7VbHVIMTyZyqD9VPMkO+p92O+tUUjc=;
  b=l6ekFGV7Yes5HV/B4K7/ovK8g8iEUcPrPxuBW+qsHMXDGBVp+SBfg8g6
   kgr/HYZp3vBV7LYkKQi9Ay4XS8hruia69s902Y8MHEqJGfvayiIzmbCqM
   AK1LD99bnFusHL2yzcwWn48k7pgMZ+1gWK9+XEK2YEmFCmEmAhedqeDYR
   otql3UXt/yBsXeMZpiS2uDPi6blkVvu5gO7ue7msYosojhdaVBFMB6x3u
   Cwe7XUVUkJgvEh7KtwH9ku53DNJ1AFI7w8RqFjJV6pJlCtYkvHyvQieTm
   HRI7wTgkkl8KpmnImyQX+0vDER7gjDWDYvGi6HuKbJMnq1zG+/4POBDx6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="354210158"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="354210158"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 10:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="812689841"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="812689841"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2023 10:07:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 10:07:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 10:07:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 10:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy7C3T1A2jog5bu6CC1KfGzHPJpebZL8BcodMFSKCDmbyN8Vf2r5wT7OKEJH1IC7pLvIYA/Vsmp1/r5Wk8vySE+zVp+cw86YkL2n7FjN7/wcAfuW0gZHt8Bvax8ArIv4msegFMlW7t4u85k/5ZMdzY7sAzTqgJMQkknOCmgW0gOrIKBLLLm34V3K3x2A+O4ssxcXJ/3Q66WUjPbVpa2ZGW7956wayvyD1uyP+amsWOOhQm8RW0jYPcxXxviQSCiKCoOaudztcjAoq1MYvlbeYNQJ3JhTVIobAWB1zIR4MYb8lPzpq2G8GqMoNmHOOz/mI9qEMFstLu7vmMS8TOjY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiC/2Dmqf2OQh9jK8CcASnlihHr2ZxoCVwbr90Fc5eU=;
 b=drzMGi+h5BG2gxzeHBJNJEqB7ijrBQET9XNqCROgnkacgKzEE9Lza+O0fYIXEwgtMJhcyIBFNypjc1YnDHzKrjw0kWQ7tvbl2W699r6RaR9wHm1UO8XhBGQChMdqQsKuqQIIiRmhjtG5JqpaEG/nEYSEwk7KbRrrdciuyfSgXdBDmo5JF9KccRxGpLEes0nlrJztzwYHbWhFRn/bpkkzfHhkIX9xrIFdi+71HzPH9uE0JM+yu18vEV/u1iSGdJkxXOIV/8lxTKmyfG91hy9cy0mCvJOmS53K1miEr6kEv8DIVMCtuNz6rE8uIneb/V1LWMvvjbA6XE+nKLbbfELnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.28; Sun, 14 May
 2023 17:07:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 17:07:20 +0000
Date:   Sun, 14 May 2023 10:07:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.4-rc2
Message-ID: <646115435c15a_27662945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 252fb61a-99e9-49e9-eba6-08db549dad3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQIcWQHpOTUzpsxR19FvarsOtGLZYgPyclTWimDbOXH6q89D+wbwjsvkvN4c3GbhHfgGsWnH4HPyIrrdx3wNtdw0Q8nq/21Mqqua1fS2K1UbM5zN6UWFuJ1dqNFJt4mldJDpY9pzTlLm6jDRH1QFSqETEdgGjlXpiPCL8SLn+ZZmsnIYDJJre7fxaoX75XHmvjbWjqVmrKW7kyIRC8Gp5qAHSLxovRTPiZIyr1vJWDl4N5eGiPsZSmszb6j1NiI3VilNfc1SJLrtF6gitGE7vDGhddd4ZZU5f08XZ1oTDnTUXt9dqsVD/ex13kUTH30rc1yHa5twxuM6vFVBoigbX0T4HyFl2tLRtWtKrOwnyYgUB54xwoVzlrfYbY7Di5o7QPlm8ryWQDIUJqCOOqqpPdY7eaZEMXv5VJKGZK9Ixx0DsvU75DkgEIzfm62481yT/2zyQHWTwqXBV9vTSuhrMTRM2gtNk0WT+snpyDQ1y7trbjy+JGSQtwRi+UgDirL3a10wIJj92MX+LzELaBeO0548igXtXTPB/UaE6rbjBNWgwVb9O5TqP4jsg7ZH+9tU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(86362001)(4326008)(6916009)(66946007)(66476007)(478600001)(66556008)(316002)(6486002)(83380400001)(26005)(186003)(6512007)(9686003)(6506007)(5660300002)(8676002)(41300700001)(8936002)(2906002)(6666004)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oheMQy7MPsW2FE24kBY92oIC7SeZtzVV8WTuCXmbjgVaQTn8r86qa78P7FaQ?=
 =?us-ascii?Q?Y0e5mmGM8BMO8FBjGGF1vkGzxoHDgWbguA09R/TIBaQh0rw/00haSg4kGnOB?=
 =?us-ascii?Q?Rt7N0P9cmRIp1vUIu7YCHQ/7h/3AEaOf95g+r4VqOm33R3Yk2e2crnk54riu?=
 =?us-ascii?Q?J68kfOsM1UkRI8k2laCu4Dc9JNQfPHeTPdf2kBXUW0Q6OEpOQR2RbiDZixCG?=
 =?us-ascii?Q?apGHX75aGzoi/uZyHOmtaKkAf7b02T5k2XcZZM5iGknWJJDoehfB9vZhAnwX?=
 =?us-ascii?Q?8Iry8iBtoPZIJqvCD1XHIdB/efcu3eZDU95hg8r/U6HLY/FWDa0F8cAD1eSR?=
 =?us-ascii?Q?Sv+VIAvGA4ft+ZZEoTNBsKTC2MsuIyGqI0rSEblZ2l7rVzkp/EdVXVGVi41n?=
 =?us-ascii?Q?qqgMDfjj1BwnA7bLcni3vZYSEw1fzauw8o29fnzZzcEpXjBsgIf62jE453dk?=
 =?us-ascii?Q?hBM8aOq1usSR97zDuIhPZzd7AzMI0+woxXm65VvlsyMyxFJGzMU1QFI69DtF?=
 =?us-ascii?Q?5s8YVbSyzrzk2+ZAXWLGaiZ+VylupXfp+idv7LFc25J5QmdxMYL0ErCSQpSw?=
 =?us-ascii?Q?Fijel7l8pPXzMBBmUfQn2F20NauBtrRRCC70HxYvWaj8rKGMwSC0aLzo7JDb?=
 =?us-ascii?Q?nJPPh7DwSCPOJGi8v3kOtqP+FLNL3ZKC06xDN6AFu54zKBSag3XJ4jOmP3TZ?=
 =?us-ascii?Q?gbOYx6qmcp5fd8RjGrS2i6ffDeWKpADKJBLB9WpxhLXKcoXCkKmAjPzdChpf?=
 =?us-ascii?Q?MjcY5olHPqUhIZYIpaDS915YODmYxQYnoaCoRPFeoy1T1i6JhIe/ty/JtlGu?=
 =?us-ascii?Q?nLLvl1O+RSygMUcvUIvbYFlgeTXtSZQKKAMchuQJTIa6oCiQi7IXXYuyWU7f?=
 =?us-ascii?Q?yxzcmepGRhjS/aT3Qk2YwEbcpILK/iZscK5+vi6cm1LOqAGyIvxY+hJ9MULw?=
 =?us-ascii?Q?gWqoIO+vGk6BR/M1TABjsTek/eUNUD/iJv3rYxAFbcdDK34X0YA0pDxUFs8U?=
 =?us-ascii?Q?TL8clf3aFwssxCGpbmMYlB1NMBuijvMLjhkWk4fkMny5FLKZiTD7BE4gaxjD?=
 =?us-ascii?Q?moZytdj//XZGuB3UGT56ueqyF3nOLNnSPc1eNsvKooPaPkw29PVoWMN7AQRr?=
 =?us-ascii?Q?8FuVDpgLY3AtlQO02zOAuiCauBRPwBvHsuOAGrnzs71pQg/xapMz27dZAd7k?=
 =?us-ascii?Q?WPaf28XJPyGg7SFGGcx8AMzRDJA6XTD+zQZizDXiBpje/RfMxCAwe73LbfMK?=
 =?us-ascii?Q?e9mBReIshmgtO19EV/K6vy7l0jmcvzIkRSjxk4vjezSWnI8bdIcmcwj/gXLW?=
 =?us-ascii?Q?FDTv0lhpNX+aVPqM5fB8i4Hn/1Qp1ioWXv/W94SFsyS0heZHTOWg/UU9Q/Rs?=
 =?us-ascii?Q?Fh2RXwFHZnJ2Se2r1eFY7Y1046vh++tmk3xk2wCBnTTlyGGOYTVjmF8Jmn9H?=
 =?us-ascii?Q?lQB9+zynPNcJU4soE3Din2uIenikLVWz8yQLMqJFLMbdIPCZdD0AciibxfVE?=
 =?us-ascii?Q?vcCsYqHzSji6aVTt0f4clrsUzvSAsUI04zWGt89sX/JzApto7FMKvt16gr2V?=
 =?us-ascii?Q?PoiJ+LFeSK5ZdYoKwp7uvGDV18b1aMqgHRwjp6bwp3tro9DKW6BxPH+8ks15?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252fb61a-99e9-49e9-eba6-08db549dad3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 17:07:20.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sedaaEeacAtOIUwQACimiAwHWmUjRRSe9Dd8w2w2m884lJ7QmvxUeOvUsl2ODkc+CRRg0SVw11g8QD1YhjcK+RGos4YMtj3bxHvEkEfsWCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
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

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc2

...to receive a compile fix and regression fix for v6.4-rc2. They have
been available for Linux next to pull for a couple days, but did not
make the last linux-next release. They are tiny and straightforward, I
do not expect any issues.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc2

for you to fetch changes up to 764d102ef94e880ca834a7fe3968a00a05b1fb12:

  cxl: Add missing return to cdat read error path (2023-05-13 00:20:06 -0700)

----------------------------------------------------------------
cxl fixes for v6.4-rc2

- Fix a compilation issue with DEFINE_STATIC_SRCU() in the unit tests

- Fix leaking kernel memory to a root-only sysfs attribute

----------------------------------------------------------------
Dan Williams (1):
      tools/testing/cxl: Use DEFINE_STATIC_SRCU()

Dave Jiang (1):
      cxl: Add missing return to cdat read error path

 drivers/cxl/core/pci.c        | 1 +
 tools/testing/cxl/test/mock.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)


