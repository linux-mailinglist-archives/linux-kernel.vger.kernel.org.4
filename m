Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650367FBE3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 00:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjA1Xxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 18:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA1Xxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 18:53:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D0023137;
        Sat, 28 Jan 2023 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674950010; x=1706486010;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WnsGLIxFjTJ1BEKNYqyWsMB2NvFjwqQVENNM2IaSAsk=;
  b=ctMoIL/DZbuNtpwogqfxlUSuplJWYTM4Wv6rnRIizDZKvz4Qr9rXFrht
   9kL3pVxNc53uV2dQq7EbNDGAeL6denh3x09130/Si1xCBM7dWHGCZbfFP
   yKaIBX+k3YZ8aJ5SaV0AdDhu6RZbuenQV9/eyWQbMN/xcKGQSnWZHlYYL
   ssz+Y/CWvObz7YRLu1QtDLqTQJ/835Hz1D6SMyVGAqTRQCljwwkb22oyR
   0GxPSn/o7QyHA1oebE3k1Z/9tHq8qnuHEKixaXOaNKIKXhInbHK2RtmwU
   FYIVABPNVivRTwpMUCj0gHuUoMZqC0jwZAyxaebuqxOpTQWeSDrJFgCgn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413567374"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="413567374"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 15:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="695954083"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="695954083"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2023 15:53:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 15:53:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 28 Jan 2023 15:53:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 28 Jan 2023 15:53:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFg5KpycOZ779zMQyMeQZyVY+aZlN0e1b8WFgjSmg+Rrlb2Y5h+Sn/68N5eiFggOzf2buht4tj+LKHon6I213KsFHuUEEROWxR6BLhS1t6kC3qjA1Kd+xiWBhM2oy4MIbLdut5xZXrl2EdjoTq4EMZzz909jcukniUmjnCKeO6EZQy0lwi76+4ANiCY8EL0pkIC6oFxjpivj8EXbvo4M1VLJKOCn80+Gqnaxu3NC/B2YIXpEiyEJwrQVXx4lpfNbdGqMr/kWreF0wINDkaoiXZRcJNNmA9KIBZ3BKJAlTGLZ1vSsHrxB+NV2TQVwQ+A4zvjO66Qbr3YOeE5ptmCspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIiWm5Uv7kTyG0DQh4aWgve/FFJ9wB4NyXQXyTWiVts=;
 b=DokQpDQcPgiRlt3VLytU/mEXVADtGvsDJkxHhoOECpfPrl68i0onqzrdHg+pLzpucA5ijpgGfFr91yfeZjvtn1MWLbsmYHokwJMizrT1myZp6p9Z2uFOnWoXeERyj7FmEDg08c8Q/mncVqTsS3wz+/dJxMFJQIvblTojPw3pyVlKvJIXSEs81jWNKIhM9NG+S4W9oyLtJ963vns/Odm28gMZ4g60ca1nixS77lFZOeWTtFxpceSS3/wEi4Zaoq5vNlFUTwmcTt+thuC4IHppk4kO5q5sS4Np4BcT1k/A6g6pdhSQslZ6UIxG0r91EQisuXh4hXiB0JUb20B6P85VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sat, 28 Jan
 2023 23:53:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 23:53:26 +0000
Date:   Sat, 28 Jan 2023 15:53:22 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) fixes for 6.2-rc6
Message-ID: <63d5b57256698_1e36329481@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc131e4-847b-49e0-90f2-08db018ad91d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr2beY8GrQm5lA4imD8WayCS9gnH3xMOBix45ZTdSVmoyxxaggRyKYwCdd3pUmwu/g+qiP3Duj4oqnBd6l6k67mUxSvKX/teJnO8DHh+HxaCiV3JZm06H6AR+Vok0hNjvPIEUxPIbOX3ZKYmIgZa06Hp78D/TDQnrv6/BzQEf8Mu9FXSFoTEDSx9DcNKK320xjqDOcapngYfAA65u2mDwQsklb+l84s+nMufyh0B0TAMC3DuxYdPIEoQ8Y/XfpBU//OGzE8fECAadI6UsdfskiHdjNMHUoDIAxhVx6nhRkKIx7swiPYKsyRqyDrSrCz9p1frjIKYFxg0V7bxBi0sm97bJQfPLjT7LqwM/7ePhsXuUMFUhaXrzhlLf9ThDZyhG3gHF2RUcM7nch/IBBhoi55Oyumhzx0yo0JHN3XPL9ks0xeh9l30R974HmfuDqng0lF0jbHki+kHwuN9UopUXQWmyJEbzICh4PW9C8EHfdObxnjdCl78UPuDDwIloEkbXpmaoz2Vj6T9duVOLUQQVX+1EsXEVzR5LCDcxVZ60KL8h0oc2QkK08BPTblT+u2QGwbR/b3HkTe8Ri68We62lI3MZnv8VVGSYo5ToUtocrAF8FEguDMrm44CAVS1CVRnDbAlE+tJotR/VO0sM2g1VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199018)(5660300002)(2906002)(38100700002)(6486002)(6512007)(9686003)(186003)(478600001)(26005)(6506007)(86362001)(82960400001)(83380400001)(316002)(66476007)(66556008)(66946007)(6666004)(8676002)(6916009)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNsC5FfZfV6P5VIGd1G0OUx5oNLUv7BHJrCHa1nsZArLrwuRwaxGOSxqIqSz?=
 =?us-ascii?Q?d5F0NVFfWJ3K4SSNmYEVh8cI+4Tq1Y+jPm+0VFqvopnNX40BZHp1YpZPkQ8s?=
 =?us-ascii?Q?e890iSJjllpQE1rffbWl5XSsHfu2V7y0PrXDT8Spe1KJvxX3vLG9RbHhtkSS?=
 =?us-ascii?Q?M2b3wdoZV9TvZoYCnHDkIulQVKCVMAEaTQ073q2eJSC+XvWsH33OKte70RLG?=
 =?us-ascii?Q?oMKR4m/zfiHlpOBVYh8OteK+5KiD7dpan6YEx8lYl6OFst5kn9hF1ZW5bGZQ?=
 =?us-ascii?Q?Q2s/Mbo58yy62HQ1cUCHQfZ/D4/i5jTrvVlWrTqXzZCFglS0FVNRDzqzBa4Z?=
 =?us-ascii?Q?ZjwG/heMhMNS+fIxw+lwX2ROWanIDXAm5M0VTD2/KDJXXgtDrZ69m0V9tc7J?=
 =?us-ascii?Q?vr4OljPvS/XJBJYDJEj9h7s+DSi3zk3jiUCVxHOoxhyMD4g7f264EZ76WLPJ?=
 =?us-ascii?Q?3msTH9oAdO3sjLQJnMwJEqOkBSv8H5MjqMUX4IEIb1SDnOyffF88LDdAcOlx?=
 =?us-ascii?Q?PucGR/SZfPu9+BGFw9q3pDZ3Pa+spNcRwm11zSsC+tJpqXcf1HPeOgk5ssA5?=
 =?us-ascii?Q?2XdIOAReYQCLZXyt/PeX10pIYayIP6S4F9V68ZDmzYEQlZbLlFrtLP6GBK8c?=
 =?us-ascii?Q?MNKapFdS5emxEPq1eaxJxzNBPw5/XowBoTE8+MBDQjTpPoevjJi2y6NDuKYY?=
 =?us-ascii?Q?zHLDNndVWFua0rgnBe0qpKsAcvii96Z0LyORotLrwwfOciZvFgNp+VITMoq9?=
 =?us-ascii?Q?mi+RtPKZAtcxzInCOwMh30kmtm11TwtdshKt2XBuLIbz6SfvJhB/Wo5/2CYD?=
 =?us-ascii?Q?3awBg6cqbi4H9qxrUcQokN9qLBP4Tp+q2891vC+ZE8D6dVcBFXOB7vXShX5i?=
 =?us-ascii?Q?rpQ2sKAlpi/kvYkKb8XPSyEjeERJpCkcM+VDo/R0id1N4G2ELs/m8nlv2WzT?=
 =?us-ascii?Q?DFR1qRX2UFaCnsejEQTiavEGby/iNUFian05BFd0/QkS20MZ0bM2Bdq//m61?=
 =?us-ascii?Q?RJQyw9RFspgheHGTc0NWFCt3WI7d++AmzkhoXeb3cr9QsNBbVKEqp35gkCir?=
 =?us-ascii?Q?rG6YzOme9wRQkBp/Tc3O6x++nPGVenNha381Z4Ezwj6Vt/5TsM30iygTNQrA?=
 =?us-ascii?Q?T6rsTPvXoMr/DKPdHe9+QKPG8P8XGrpCt8SsgJjK8/Znv5Kv+HtI/whN4hmV?=
 =?us-ascii?Q?drky8wB9S2guFU2mdjF4nCK5wXkQmHIJaUhmRXkQIJfO5Zv/uBhbH47rjQCm?=
 =?us-ascii?Q?qd8UOrGVpmIKwra9TNXZtDpBxNf+zjvh6tAPUR5WHTtbSowjRSZ2jD6CrGsh?=
 =?us-ascii?Q?6530i+HMreGic3oyk9LRdkxLRAcbOyVLj3Rlr+vUPBDri1GueOZ+zvcFmmUR?=
 =?us-ascii?Q?XC2atNPSPw7YdhKbbyaP/0gDV23OVXOd3Yu1pE/+chQsd1r838Uqs+kcLPra?=
 =?us-ascii?Q?KnpkLrvkxAwUJCC9Shv4K800pnLioxv3+FdIu/lf+DU3A5rVpUTUBHHCmfhA?=
 =?us-ascii?Q?nEBnyxF7sdQW0mKbNanY/ujFLx2m1gaP9u/TwAnOrFaJ9rpizR0BjQpbblv4?=
 =?us-ascii?Q?ol9NnHrdE9eW4UHYtCr3YpZcxzm5vt8QuSHPCKT5gZHEgze6dG7ScrSljrND?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc131e4-847b-49e0-90f2-08db018ad91d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 23:53:26.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpiZnZV58uluf7c8y5wJajUEwoX0XeeWbDZv2zy1yJ5BqG2eh6oORinFtwggwH/2yKeC+m3ETQ6a+6HIbpeaW7tbWbRzxUYvyF9bEXg7Uzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
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

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.2-rc6

...to receive a couple fixes for bugs introduced during the merge
window. One is a regression, the other was a bug in the CXL AER handler.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.2-rc6

for you to fetch changes up to 19398821b25a9cde564265262e680ae1c2351be7:

  cxl/pmem: Fix nvdimm unregistration when cxl_pmem driver is absent (2023-01-25 15:35:26 -0800)

----------------------------------------------------------------
cxl fixes for 6.2-rc6

- Fix a crash regression due to module load order of cxl_pmem.ko

- Fix wrong register offset read in CXL AER handling path

----------------------------------------------------------------
Dan Williams (1):
      cxl/pmem: Fix nvdimm unregistration when cxl_pmem driver is absent

Dave Jiang (1):
      cxl: fix cxl_report_and_clear() RAS UE addr mis-assignment

 drivers/cxl/acpi.c      |  1 -
 drivers/cxl/core/pmem.c | 42 ++++--------------------------------------
 drivers/cxl/pci.c       |  7 +++++--
 drivers/cxl/pmem.c      | 24 ++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 41 deletions(-)
