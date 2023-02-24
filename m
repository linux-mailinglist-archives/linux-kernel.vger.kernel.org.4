Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E86A15F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBXEiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBXEiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:38:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA435BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677213500; x=1708749500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h85A9Ga5o+K/kV2eFPuFE4haLLuSdvaUkpdiK8x9fn4=;
  b=hUCE+JnnyEtYxd58oSCwhZQFk00/MPLf/qgReiTjPUEv9QpuINCRnbLj
   U6cdAjnvAzklKUdBuUB9/yNBi5vpjCgZWPwJ3QeADY9Uo1RIe6ykQ9DTw
   99rrtz4Zc50bj95VZefL94Qorcxq+Vr4w4bKTI5lBTFRhL3DCKoulPrBJ
   UYxi9FfVBv0TvzB2+GzRMjE81wnlyCOH8LU51f7+vV/4i1+KSmF5jbmn+
   Yc+JTGkTeFOIY1SsuFWaS6BrbG6gSZvpdJBzjlxqPhy5IAolXRUCTUb5W
   wWoWTPK2Pe3PQkV5Zjy9Zqm17fGtdxzyoyOum7AkjrMuiMrNshxmCtD+a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="333401266"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="333401266"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 20:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918296217"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918296217"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 20:38:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 20:38:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 20:38:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 20:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdzVpyKHzP/OC7r1pLRu+0/9tTWbNQhT8r880yTL24Ie2p2hUKogAIR3ZRevA0hHJlTN+wh69R1+hJiWQ8mxQmZmEgw7JU8SAtwtOI9kbT4r7MIWAQrWNtuXj0151wROWu4YTBxAy0hPuNcWFu6d9Hkr93vLZ4M6PzXZAcwEm1GbDI9p4cYhgPUICmKKt/lnIIVR8lB5HnsuXPnH8n90F4mx9R6DdUhKRvgxtPS0H03sDKh7UAa1B0tQtMP+rbEtNzR81rbJm5ba85GLLZIhnDTuwAXsvy5x90DjKEfNw9omhMCvrZkKjGkDL+azm2vWRo7lqsxa+tnnI4LVwX7qCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WpC3eCOEkDoJNxGzYzVK14as/J/gE7821yI4VRnSMs=;
 b=lpBmOEDu9wcfRKhOPnrWfhgYwdaKl+2xCGd2mzLZWsBW2ZaoTTnHPixFe6FhuvN4Gv7mL1swkmFnvMBO/MheqXtVok7lbdHfgGh0lJRIklFG8wOArmCe/DES6/yvIG/iyz6qThT+L6q707iKL3bl/nPLxPI/QmXAf82VN7DUPPq1GGscUaZg3CMdUAQn+M69VjpZmOOiwV9IHIQemtfNWGbRmP//9O7MiuTq7XHvwH95rzsovQUO9uesZ/LQY4IHYopyBd9VgVFdyzOrTAFnJXX1DyP/BGJJt6QuGT72k0xs5QFifJp5aH/DeTBlldDJNpqr6uCJ6BJa507laInDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 04:38:17 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%5]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 04:38:17 +0000
Date:   Fri, 24 Feb 2023 12:39:25 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <deller@gmx.de>
CC:     <asml.silence@gmail.com>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in v6.2
 in guest
Message-ID: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: bd76d981-2899-4601-2004-08db1620f28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnaDFvaKoxJCVHuau62rjBTCmtYMC75UwxO8ZARM5iivUOPn7Wc6OBo+Jqh6FtCV6b5iOFY+tKn7FQ5thlBS3jCRbJQzCAESCFLA3uL71pW/wvDlU1SPxuaHnowK0dNzcM7VG9DxDzhkLt3ybR2ZreRdiUe4+9BxsD57ZZ+uMsXB0NK9mRP23CwRHGYYNsgCmz0ez2v2Ea0bq7pHIEba1gvBq6srkBO4LxYaqylTJQYlSGCTTvrXIuHT9pUmLpZy5J9dhIxorFtrJacy+PlExcAYyhbpHAKVLbNucSR1YmQgcdhhyZLRb1ap/TV/aNDqm7AxVsU8WXiN7Mg5lyrdo88yNb3YZqabQIdCvepo1DdQT/njkiIt3emPzsgWekDP9fQryPVdASLP7WJ4wsdz7tnvHiIETmsjX+DYkA2jEG6AXTtIPIugS7+0BOM8GlI9QcrNBNHYMYD5Yj3dEAVi2MIvSyS1B5UkopcbzfUkcOPlmNjtIcIQj5IjSZmPPa9bz8PMAe5Z/bQMiymiwAt9wpbniZJlY5XOpcrVfPzDmjx0D9Sk7+YXkvMCiszs4OQOQRpqpxiIyie3QmTRmCktx7Gp6AmxUUDuVk5BXVmZNZ81XPg7alo3IfYKUrVXm1RcH+EY4EXanidSZM2AkkQN+BiJIo2rxZmqzmXuxkeMuJxWKlSQErqGiVbrj7OwgpELuzc2JlKAMp/iD/HwkRX65JiciUur6E6g4Y2m7MQdV0y43IyoYBeaFb4XbDr6RSCI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(45080400002)(6666004)(107886003)(66556008)(316002)(30864003)(38100700002)(478600001)(19627235002)(86362001)(2906002)(44832011)(5660300002)(66946007)(66476007)(8676002)(6916009)(4326008)(83380400001)(82960400001)(966005)(6486002)(8936002)(41300700001)(26005)(6512007)(186003)(6506007)(21314003)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPF61tZdH7H6cEQDFWhNmWGxaXsQQA1mSomdhsgox0ir7o7eTv0za5hW5fYM?=
 =?us-ascii?Q?Q94vCJcpRu6KXlqpnxx4VPxSIh9BFINgSkVeDxEbfmsCytnJd9C8K0NOlIo2?=
 =?us-ascii?Q?9RUGfUq/5RAeUawAjgikRoyJZngcZnc/qa/NwtLjfkwtPRogpu7AF6pbrQ2h?=
 =?us-ascii?Q?z11XvMUe4g6TDFF6wf+ucsyyPR01GwMRF1dl5AE9MpiZYj/u0G9PJFPDuTVn?=
 =?us-ascii?Q?l6OK5SLcRcFKlMi7+RajL8YnYoZC53GNxyCaeAMn9tdx9Uv+SsBDL9F8m99v?=
 =?us-ascii?Q?OGZzsByOVr408amdfEuzHehcep7Jn/3P7/hO+RT7P4uA13lDnNXxY+R+uqCt?=
 =?us-ascii?Q?iDWk010xvyz9Mx/hYmaUwT4pCjI+k6+R34f91UreSTTCAwPqBW3GA4An8KgV?=
 =?us-ascii?Q?M16kTh+qTTSX9ZTo9LH2YxuzG3z1dIC8t1KsyRtNXB8Cht1huAs6i72Wqhn/?=
 =?us-ascii?Q?RQJlvEm3DRt1PaZgqP5Dr2qoZatvW2qC+qVl4RVeu8+y4cH5T/A9azoScNUK?=
 =?us-ascii?Q?XYlV88lGvECC59GtthVtQIxkrL1pvszUwo77itziufDY6mBnoTJcnIKDBUo/?=
 =?us-ascii?Q?lKn49ZYROnIUaPfH0f0f0mSX+jN6Vo2DTd+wj7KZ5neUEuU8IGB6Xp4OCqhB?=
 =?us-ascii?Q?vD41nbih7H56m9cZQYynejHHVV73B/+vCgS3DrUua8JPHFD/S5TnuFuisCCU?=
 =?us-ascii?Q?vQN6KYEh/hKqXnra1rAkKcZ4zI/Ak32r0+B2q1+WqFR0a90KJPFDAAxlakIZ?=
 =?us-ascii?Q?NZd8Z8PT2NaRQJVKvvPqOvdr9YZWR99mcz7naFb5w83Ph84QOlOP/NZxiGOO?=
 =?us-ascii?Q?6mI1DgDjwdokpdGTYEucPeHqS7hS0y9h24YeXPnlEHzPYEYqj3ECNVlLkJr8?=
 =?us-ascii?Q?MhtTXT7oM1SLHubGflVjAnESjEnWZDQJ/VhPvpcIQOUc0ag5gaTI42Uncos7?=
 =?us-ascii?Q?AkgxjelraekWGy2zhP66DvVmzu/R1DG3/N3I5UKOjzAuUkcAJ1+1+JnhVVJo?=
 =?us-ascii?Q?S6hMD26uKx8i87NnetL6U53KJGjI1m5C5IsShRt48KePzYrx3EaHBS08FaJP?=
 =?us-ascii?Q?PzJcayX+e6aUfUDwlCQ3raZfgY9AGbo6d0bMX+AITMdYwAHQBY92xMwNclsC?=
 =?us-ascii?Q?pmM2hlwOZ1WZv7E0eY3WvKhw7emyC6GO9vhZFSOw7SGh19Xz8YZwBlSLBuVg?=
 =?us-ascii?Q?XyOX1AQCeGroLFf0+FwgO+9Lg6mXvuHG2qML5iwA12pMH58zYuWZcYeQg6kn?=
 =?us-ascii?Q?mzzhdTNtfZyyqXYq62AK3OF7NUkEkBogneIWQCRtpsBrYIUnFNJtWS8Y2ufS?=
 =?us-ascii?Q?JDZNYbGazVBItx4KUzNEwjhLdvuI8eS/60Gcps+xQgT5lphqbhAP+mRA8Dir?=
 =?us-ascii?Q?oEszXK09xnrF4dvSrvqrOmmuR27s2BW3rC+5afhXsRKDQB/tv3a8Y34gRV5F?=
 =?us-ascii?Q?zoE7EjUlnP3j9lF8TDbEyzS7jAHiFYSX6LzF8If77unXm3Lp+SWKQOVJHN3w?=
 =?us-ascii?Q?T8YhLIyrIFZuCMAaFQDFbyZvcK4qZ/GnPKs3JFu3CHF0gGqchDq3NydkQEMo?=
 =?us-ascii?Q?90sjirfcOrbsHlkF0g1hqhllV7kG83sdHiJh5n30lzvdZDUfZSeJCwZaHsEC?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd76d981-2899-4601-2004-08db1620f28b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 04:38:17.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1008QmbUrm56XLTQlkynFzzqE79yXx5jGtWlAw7vAreui/3LUOBb30cbrylC3Vr8vep56ZRdtPfY6ZSvn/i3yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge Deller,

Greeting!

Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152458_xfs_dquot_alloc_bug/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152458_xfs_dquot_alloc_bug/kconfig_origin
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152458_xfs_dquot_alloc_bug/v6.2_c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_dmesg.log
Bisect info(Might not be correct this time, but just gave some clues to the problem)
https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152458_xfs_dquot_alloc_bug/bisect_info.log

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230222_152458_xfs_dquot_alloc_bug

Platform: ADL-S, and it could be reproduced on x86 platform in guest.
There is "xfs_dquot_alloc" related BUG in v6.2:

[   71.149963] xfs filesystem being mounted at /root/syzkaller.6TPmw0/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.150653] 00000000: 58 41 47 49 00 00 00 01 00 00 00 00 00 00 80 00  XAGI............
[   71.151006] 00000010: 00 00 00 40 00 00 00 06 00 00 00 01 00 00 00 37  ...@...........7
[   71.151321] 00000020: 00 00 00 20 ff ff ff ff ff ff ff ff ff ff ff ff  ... ............
[   71.151633] 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.151946] 00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.152259] 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.152570] 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.152881] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.153193] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.153607] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.153921] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.154237] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.154549] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.154865] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.155180] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.155494] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.155807] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.156119] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[   71.156433] 00000120: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
[   71.156747] 00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   71.157059] 00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   71.157382] 00000150: 00 00 00 00 00 00 00 00                          ........
[   71.157671] XFS (loop3): Internal error xfs_iunlink_remove_inode at line 2013 of file fs/xfs/xfs_inode.c.  Caller xfs_ifree+0xed/0x9e0
[   71.158154] CPU: 1 PID: 137 Comm: kworker/1:3 Not tainted 6.2.0-c9c3395d5e3d #1
[   71.158447] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   71.158890] Workqueue: xfs-inodegc/loop3 xfs_inodegc_worker
[   71.159117] Call Trace:
[   71.159220]  <TASK>
[   71.159313]  dump_stack_lvl+0xa7/0xdb
[   71.159478]  dump_stack+0x19/0x1f
[   71.159621]  xfs_corruption_error+0xd7/0xe0
[   71.159805]  ? xfs_ifree+0xed/0x9e0
[   71.159957]  xfs_iunlink_remove+0x32e/0x590
[   71.160136]  ? xfs_ifree+0xed/0x9e0
[   71.160290]  xfs_ifree+0xed/0x9e0
[   71.160432]  ? write_comp_data+0x2f/0x90
[   71.160600]  ? xfs_trans_ijoin+0x47/0x70
[   71.160768]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   71.160964]  ? xfs_trans_add_item+0x79/0x1c0
[   71.161151]  xfs_inactive_ifree+0xf8/0x2a0
[   71.161324]  xfs_inactive+0x226/0x340
[   71.161482]  xfs_inodegc_worker+0xd3/0x430
[   71.161657]  process_one_work+0x3b1/0x960
[   71.161837]  worker_thread+0x52/0x660
[   71.161999]  ? __pfx_worker_thread+0x10/0x10
[   71.162184]  kthread+0x161/0x1a0
[   71.162331]  ? __pfx_kthread+0x10/0x10
[   71.162498]  ret_from_fork+0x29/0x50
[   71.162670]  </TASK>
[   71.162773] XFS (loop3): Corruption detected. Unmount and run xfs_repair
[   71.163039] XFS (loop3): xfs_inactive_ifree: xfs_ifree returned error -117
[   71.163869] repro: attempt to access beyond end of device
[   71.163869] loop3: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[   71.164410] XFS (loop3): log I/O error -5
[   71.166002] XFS (loop3): Metadata I/O Error (0x1) detected at xfs_inactive_ifree+0x232/0x2a0 (fs/xfs/xfs_inode.c:1612).  Shutting down filesystem.
[   71.166541] XFS (loop3): Please unmount the filesystem and rectify the problem(s)
[   71.167188] XFS (loop1): DAX unsupported by block device. Turning off DAX.
[   71.167530] XFS (loop7): DAX unsupported by block device. Turning off DAX.
[   71.167859] XFS (loop6): DAX unsupported by block device. Turning off DAX.
[   71.168188] XFS (loop4): DAX unsupported by block device. Turning off DAX.
[   71.168554] XFS (loop1): Mounting V4 Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.168995] XFS (loop7): Mounting V4 Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.169595] XFS (loop2): Unmounting Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.169614] XFS (loop6): Mounting V4 Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.170444] XFS (loop4): Mounting V4 Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.172161] XFS (loop3): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
[   71.172510] xfs filesystem being mounted at /root/syzkaller.mc3H24/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.174633] XFS (loop3): Unmounting Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.175936] XFS (loop5): DAX unsupported by block device. Turning off DAX.
[   71.176303] XFS (loop5): Mounting V4 Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.178679] XFS (loop4): totally zeroed log
[   71.179069] XFS (loop4): Ending clean mount
[   71.179442] XFS (loop4): Quotacheck needed: Please wait.
[   71.183738] XFS (loop6): totally zeroed log
[   71.184537] repro: attempt to access beyond end of device
[   71.184537] loop4: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[   71.184637] XFS (loop6): Ending clean mount
[   71.185052] XFS (loop4): log I/O error -5
[   71.185339] XFS (loop6): Quotacheck needed: Please wait.
[   71.185404] XFS (loop4): Filesystem has been shut down due to log error (0x2).
[   71.185883] XFS (loop4): Please unmount the filesystem and rectify the problem(s).
[   71.186372] XFS (loop4): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
[   71.186705] xfs filesystem being mounted at /root/syzkaller.uq7iOt/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.187608] repro: attempt to access beyond end of device
[   71.187608] loop6: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[   71.188127] XFS (loop6): log I/O error -5
[   71.188317] XFS (loop6): Filesystem has been shut down due to log error (0x2).
[   71.188599] XFS (loop6): Please unmount the filesystem and rectify the problem(s).
[   71.188998] XFS (loop6): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
[   71.189324] xfs filesystem being mounted at /root/syzkaller.OjSrkA/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.191782] XFS (loop4): Unmounting Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.193911] XFS (loop6): Unmounting Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.207573] XFS (loop1): totally zeroed log
[   71.207813] XFS (loop7): totally zeroed log
[   71.208396] XFS (loop7): Ending clean mount
[   71.208664] XFS (loop1): Ending clean mount
[   71.209093] XFS (loop1): Quotacheck needed: Please wait.
[   71.210841] XFS (loop7): Quotacheck needed: Please wait.
[   71.216659] repro: attempt to access beyond end of device
[   71.216659] loop7: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[   71.217165] XFS (loop7): log I/O error -5
[   71.217375] XFS (loop7): Filesystem has been shut down due to log error (0x2).
[   71.217674] XFS (loop7): Please unmount the filesystem and rectify the problem(s).
[   71.218071] XFS (loop7): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
[   71.218402] xfs filesystem being mounted at /root/syzkaller.Q5dMMG/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.219906] XFS (loop7): Unmounting Filesystem 86ecfda0-089a-461f-b078-1b43afedebc1
[   71.224443] repro: attempt to access beyond end of device
[   71.224443] loop1: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[   71.224960] XFS (loop1): log I/O error -5
[   71.225151] XFS (loop1): Filesystem has been shut down due to log error (0x2).
[   71.225543] XFS (loop1): Please unmount the filesystem and rectify the problem(s).
[   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
[   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
[   71.227591] BUG: kernel NULL pointer dereference, address: 00000000000002a8
[   71.227873] #PF: supervisor read access in kernel mode
[   71.228077] #PF: error_code(0x0000) - not-present page
[   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0 
[   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
[   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
[   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
[   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00 <f7> b1 a8 02 2
[   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
[   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 0000000000000000
[   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880093c9ad8
[   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 0000000000000000
[   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 0000000000000009
[   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 0000000000000004
[   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 0000000000770ef0
[   71.232949] PKRU: 55555554
[   71.233061] Call Trace:
[   71.233162]  <TASK>
[   71.233254]  xfs_qm_dqread+0x46/0x440
[   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
[   71.233596]  xfs_qm_dqget_inode+0x154/0x500
[   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
[   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
[   71.234149]  xfs_qm_dqattach+0x52/0x80
[   71.234307]  xfs_inactive+0x186/0x340
[   71.234461]  xfs_inodegc_worker+0xd3/0x430
[   71.234630]  process_one_work+0x3b1/0x960
[   71.234802]  worker_thread+0x52/0x660
[   71.234957]  ? __pfx_worker_thread+0x10/0x10
[   71.235136]  kthread+0x161/0x1a0
[   71.235279]  ? __pfx_kthread+0x10/0x10
[   71.235442]  ret_from_fork+0x29/0x50
[   71.235602]  </TASK>
[   71.235696] Modules linked in:
[   71.235826] CR2: 00000000000002a8
[   71.235964] ---[ end trace 0000000000000000 ]---

Reporting the above issue and providing a reproduced way seems valuable.

But not sure report to who in kernel community.
So used RIP: "xfs_dquot_alloc" key word to bisect between v6.2 and v5.11.
I know there is BUG also but with some other RIP info.

Related commit:
29837019d5ebb80a5f180af3107a0645c731a770
Merge tag 'io_uring-5.19-2022-07-08' of git://git.kernel.dk/linux-block

This might not be the right point of suspicion.
Could you help to take a look or add the correct developer for this issue?
Thanks a lot!

---

If you don't need an environment to reproduce the problem or if you already
have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
In vm and login with root,  there is no password for root.

After login vm successfully, you could transfer reproduced binary to the VM by below way, and reproduce the problem:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
