Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C15FF6FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJNXoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:44:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C42F07D5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791050; x=1697327050;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wd56YaD6138XciAP1QkdApGJBL/A3doHpelBytb5Mxk=;
  b=h77Tk7Cd4ZPvAz3Nx4Yyws4ApTBxF5HIaet2yOu1kugwWtQBs+cBKfUP
   ObmOUFwKnD6BqYqBJ9wCr2SkwuIIWY1Zy0FHJ5vUljPdBWMmqEFk91fiL
   6UAPLphJ00/vChVCmS6YbwfoFyBElUUuEyxlCSNHX1i5wwUlslR6JRLOQ
   cPcJ1qMj5En6VWvg5Gu+o2g4in4OJZ3+fVKBYkp7tfZpAKgoBAcqE7jnr
   Ij1AsoLd/SZ5g/23l0T+MA/meOWg6ztrtH61A8G8VSntMDiY6UyY9ArsZ
   f2S6x2PRydv4SE1i2hq85THya9vIeUSAdLDOaBrMcu2xFXQISJME2rdRp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285885780"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="285885780"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="802796189"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="802796189"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 14 Oct 2022 16:44:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:44:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 16:44:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 16:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iesiL0JPU0w3gX28BJXRURbfdx5PZLqEX/JGcvn8g23+7of1mF75kDHhfn53wUfTkPo4Luzfc60jd5jVC44nMUOWcxOujCFQQacIfuv3XahKAwet3tH6RYs6dxZjlIGFivp1as/SD4NchHWbL0O+oGpiae50loizvF9rxx6MV+0UTspZP5ajsv1z1lW2w9OP2j4F0OT4Z0nBacTpVriC4McztcYi3kH1YzQzteLmAC/ktllIPNLVqOD8qiVAXjG2O/oxjQb1AVYsZPBcmPCMxiFr3shafdS5GsmmO3fouRZjjNkMiM3++67tT3LuHzISxncroSHWu9YtI6xyNRiegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQFW7UEBek+UehWzqqmSueyZOuJzTMhk4cgc+QVwRqE=;
 b=WKI4MOquDMV5YM9Ix0bmRBMj0V1GDQgt2s02A2B0ybnJmrbJIOSbWTQC48709UkxHrTw0Z8o3E58wIc6TfFcmgaC98JIfdKZ5+mHyAcxn2fFPlRn9c8oAQv+8lQI7wjCaMTUZBy8dcUNjDMTYSih85dw1jr4KesWFHvzBYR4OCEWbKEQJwoDzy/50l+QanvN/g4gGtmzM1q31Uob42IHFcQaU3fZZa01lgOgbvoIP8dmlEqYgDUA63pUSxc86db7kVOkPn066DYV9kosWct1kAkuY8QjyS8RVgk5uomfOwZM7iNTlepnLf83Ia7HxsBVfGt5TiUGttSCtdLSvFn8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB6050.namprd11.prod.outlook.com
 (2603:10b6:208:392::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 23:44:05 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.029; Fri, 14 Oct
 2022 23:44:05 +0000
Date:   Fri, 14 Oct 2022 16:44:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NVDIMM for 6.1
Message-ID: <6349f4435df76_7ddc2943e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 274b7bdc-b89f-4800-b547-08daae3dfae2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWfWh7R38hQ9DvOwFCcfsLFznhcc6m2CadfPJ1Dqbaec1C84b4lAvrbpr5TfGF/CViTQMkZt97lGivpvw9A7uC/URZg0+ZMchIdu4DconVotL1pjyfyX0Hvgu0r25KOEY1IzhLB3Q4AY5DKw/DC077Kad78+c6EIXk9DhYYDwp/lgP0P08CxGanplblCRyj8kFghCq9KeAB4p6crxQbe5nE/oOWOkBen8tWNUNjveTWsQaqE32AmKQPyJqXdALQmZanYb2gT18IcDGt6cf++4V/pr7WeyeEn6NwjcgTp9Lpip1fVZnPkQ2abkCA06IsAoEFtsL5gjQOa2a9VMALpN5bl2ErFL51EfNDM+wDU95N0YDtO5KLYhND5dYq/+uX7BklfZMz8Bm/jOnLxV7Zi9dA9utMUoyZg+kty+HIjer4dK8l/5/d8yi80stacFqhzDhWM4q6Io4ZJAfseENkbQnGpUNrM/aDFWynbz3JaN9RB+CKi69QEhp/GruNzN/Xrh52lP0ngfCawv6o/zQckNpfy2uvPSnjvHs3nnZw3RweGOy0i+lxrgpGuy+CQts6ONmDXEgsi5/A2acjncXUZpAizLCnCg7db7nKRR7kGFHdhOXS4GjAR9h+4y53crMzOhTckUCdHOce29mHszyFpDPq40GNUvwutFgv1cQ60PdkuDUEzMZkyChb+9iqRsubIM4Om36F0ZnUjK5nUm6QnAsoIn341tYIijoXIx1j7ysaoJn9qZKipNjsJP3Dof+qW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(9686003)(6512007)(6506007)(26005)(83380400001)(2906002)(5660300002)(186003)(6916009)(316002)(6486002)(478600001)(66476007)(8936002)(41300700001)(66556008)(4326008)(8676002)(66946007)(82960400001)(86362001)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JY8zQqMJOUSROldcT4P19TqgpplOiXceshdxvCayKArXDOTNGCpB/1F54h3D?=
 =?us-ascii?Q?kSeOs9DpO9P0hTwza0upNtZLd67XkvIKkSUK+rC5Ai7m6UUkToN75BkPLwGh?=
 =?us-ascii?Q?hDQuO4/nMlJ3KQhmwlfXPi9oa+e48HxjbpVXWC7ggLiOgZnJLD+DptnCMdLy?=
 =?us-ascii?Q?kj6X57LJpjdg+HRkSrh23NiTEmF5v+TbmnzNwEisk3yAKc4kaqJQH0ku0blU?=
 =?us-ascii?Q?aM8rPvbKwoyShJ4AXAAPUfCZQD1HndpBynoebak5UT0TOS+M3jAGZoX0dpl9?=
 =?us-ascii?Q?hUi0Hn+Zqgqq83i9FQJ/rnOLrbpCM8oj/6Rvu8laIQJcr95cEI2fCNkMWnE0?=
 =?us-ascii?Q?G2jGZ8KBDyc132vU/TEe2WQZYcxRrFMA40HvEw9eS9fqyCboV6KrcKTTtYTp?=
 =?us-ascii?Q?U9MwH1scKtpmVBHRRVBLXnBj+zqq5os6CzgkZ5Erl7a7yNLy5eMwm7Q8lRMJ?=
 =?us-ascii?Q?ORcb2Brl6BRyYuosT86mEueJdXqnlMYohKVplRfYOsBYHE9R+em61wIRL6FV?=
 =?us-ascii?Q?YdFFlfH1C19gzqy1AhxHntniCFoctDBtro6IIP91AS408Cp+HAOTGzQhvD1l?=
 =?us-ascii?Q?Wzy3Ocw7IhqxCrHkpUaEsBFRFdT2ZMJqWiQrNeH0Jwp879BW8haCIOPI5bL3?=
 =?us-ascii?Q?YJ/EjyIEF0Xz95SKoxYlbC3H1peZScy7ZC9TODD86A0cj2JtFNKyR+Jd0Q2a?=
 =?us-ascii?Q?6zC2KULpzwrE+dkjNCyhqik7LyDaNgKRrKez7k3ETOS1l0+UZTHJclBzGUU8?=
 =?us-ascii?Q?CS+80uq2/2UXNifQSRGfzsXjN+duxVrwuqjiK1J789GzRHg76y+OqodB8bR+?=
 =?us-ascii?Q?pLryr+nvroWI7UoHbW3rGWThRTvyFGh6Mug1ypW4Adymhe89qaKV9WcJKJCV?=
 =?us-ascii?Q?2lDtpHmV8SDFPNcZ3dApXGNg/1rmZU5zeg5LhXWghecDcQ6HQvG8fnoxyOCY?=
 =?us-ascii?Q?nA4iuRjJNCEZGhUcBi8wcNRyWs2Ydsgx+JC8c8zVCg42DpDhz6xoNx8WVLXm?=
 =?us-ascii?Q?4Mp/dXVWXhX1uNmnh6uC0uO6e8rIR3BYpwrwq/u3yuBbKxXzJy3vEmuDzQ8i?=
 =?us-ascii?Q?Mio+Dtuuq2XxXzilwlT4R/CjQ86Apf4OfAgzthYJNkqc2pkSpsKDWnqgeok3?=
 =?us-ascii?Q?Y/PPC7YyH1nEJbsUmCsImKy4+9FKpMEnLpQjx4zwBAQY/tSFnOO+rjovUrS/?=
 =?us-ascii?Q?k52cCj1xAT2hIPBe78gGsHdL/bHmQCnwzxxYOAOFKP3Z92pyiD+T4/0+UhDR?=
 =?us-ascii?Q?gTo+LgJdzMOmsibiE0TjScv6M0dWytdYV6dwBT9ytMjUgyWkkBEAvNu9A8Dh?=
 =?us-ascii?Q?+b1N8v/THUHcwjSax+eLc7rAWAQO4f5jV2OptyUJceTav02kZAH+QTm16QSH?=
 =?us-ascii?Q?mrgd13/pOWRTH4Hp2+QK6maUbkbUxKxeqp4HCCJMzUfX7lvbgpMVw3Xz3/io?=
 =?us-ascii?Q?ePhzoDN9NggJME5++++WmmX1lJmpKjCEFSPa3qXHlPu9XQCGSIlr4gevyNQ5?=
 =?us-ascii?Q?9V/WRhivf4zaDhV3lofnFrH7dvcVGfu0+m5JM/usB5Ju+qt9XiH0Sx5rxvgF?=
 =?us-ascii?Q?B6L+2VipoxkZXF0sn2V5vw2Xo8pfUN8TdmdG5ie24TNNRBz+8xy4J28LB4YY?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 274b7bdc-b89f-4800-b547-08daae3dfae2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 23:44:05.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z7P+VVhi8IHO029K9S/KLRa8gt1KaqDB/gXqtJ22ujhjnFJjA8dFmo3Mrm/wmCLuXMz0wKsdbU5omT8SJS24Cv8fGDbYtqrxeeZwQQhn9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
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

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-6.1

...to receive some small cleanups and fixes in and around the nvdimm
subsystem. The most significant change is a regression fix for nvdimm
namespace (volume) creation when the namespace size is smaller than 2MB.

It has appeared in linux-next with no reported issues.

---

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-6.1

for you to fetch changes up to 305a72efa791c826fe84768ca55e31adc4113ea8:

  Merge branch 'for-6.1/nvdimm' into libnvdimm-for-next (2022-10-01 19:16:16 -0700)

----------------------------------------------------------------
libnvdimm for 6.1

- Fix nvdimm namespace creation on platforms that do not publish
  associated 'DIMM' metadata for a persistent memory region.

- Miscellaneous fixes and cleanups.

----------------------------------------------------------------
Andy Shevchenko (2):
      nvdimm/namespace: return uuid_null only once in nd_dev_to_uuid()
      nvdimm/namespace: drop unneeded temporary variable in size_store()

Bo Liu (1):
      dax: Remove usage of the deprecated ida_simple_xxx API

Dan Williams (1):
      Merge branch 'for-6.1/nvdimm' into libnvdimm-for-next

Jason Wang (1):
      nvdimm/namespace: Fix comment typo

Jiapeng Chong (2):
      nvdimm/region: Fix kernel-doc
      nvdimm: make __nvdimm_security_overwrite_query static

Lin Yujun (1):
      ACPI: HMAT: Release platform device in case of platform_device_add_data() fails

Tyler Hicks (1):
      libnvdimm/region: Allow setting align attribute on regions without mappings

 drivers/dax/hmem/device.c       |  4 ++--
 drivers/dax/super.c             |  6 +++---
 drivers/nvdimm/namespace_devs.c | 24 ++++++++----------------
 drivers/nvdimm/region_devs.c    | 10 ++++------
 drivers/nvdimm/security.c       |  2 +-
 5 files changed, 18 insertions(+), 28 deletions(-)
