Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51CD6489E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLIVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:08:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB6B3D8D;
        Fri,  9 Dec 2022 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670620083; x=1702156083;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4SapZVjcb8LHNhbRcbm5x3a3jmgWSPTz671/Qj0xgrc=;
  b=QILwmy9DkYjU/jAnb0jiPwjZs/hNThnf8IxXp3FPW9IVZfHBU1mijHVh
   M7G+3V2cpJzMB1Us9h9Lw1UXPW3g8Tc9rHS2NE1/JkbkqkCUDYNd2CpIv
   qZjPEVGRlqgHQbH1qkyW4yqsr4kEfgV7Ir02m36SRx5ECNB6/5+xS+9KH
   lK5LZuFRqiygcAYtqyBSO0KZyxnSXvHEAg7GDkBDKRISem/ikAPTR0l4I
   FHYohaK/g9X5jG137VksXv93QHLkTEQ0pe/ClHV84h8Bj/0AKLEXgoYn5
   BcaHVNKL2XTxjJMFihbvlFfh2+M7PmZcoITGIj0gN0Y922W7hQZV6Blbz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="381853686"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="381853686"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="716145280"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="716145280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2022 13:08:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 13:08:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 13:08:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 13:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niKEpZVhCSDBOJHHG/UDo8FCLNlSK99KoGb34RU7Oby0vwXqZkyESFvgzq2GAZKBi1/uw3YhkD2pRGfsYQJJFnlk1PPqW40VM7ONHd93oLUsyP6aw51tDYr4HMDnQthhfuObMPxkHOqoK1kLfPkDsjTjBNjcReCdpLcjberPZyGyjiQcdLDJ8tIAy+IYl1jbZxMSh++SldENMnNABesDKedaMRq5r3A1CWr5g0gaYUAGbLGrwAZb1HcVtgadyLGGXgF7Qhrdqbbqnmf5urePHZxWvOqJGmPbTsC9UhSdcWIyyRjakXF6+Cqe95sI8hWg4BhNS4Xc4+a+LW2Rx/SLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMw1pKs4XVyKXeAgby/0NCNful3DJbG+tiwCYYeaxOI=;
 b=JEcJTsMl2jX30p7XzoqJyfE9TpLAEKsMi1oW8RGhp0qHnuA7jBwi1TWbgHzxu5X9EPgRP7x7wGPz3wrGaL8DSKSm55wsuRgzl8sADj1tHnq/IB/ZH29DVYB/6OBkWMB2eUW0jdY4uzmbyFjdMqXPEbTpdiB9Uru94mQW4CgdTyLBe2AQojKoEXssyN/CEr24BO4Bjr6H9YxxYIdAl94FZSj2sF6lmU6jYHjEs+iH39iMauJn5cgSTNYN6AjsBO1GqrXL7PSD7vg0dG/GWBWdjix4hP6YPEuxM0b13R/kcMcnXwXGsS+3H+0BbeK3z6U/28KyDxmwwgB+EV/0zak1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB7901.namprd11.prod.outlook.com
 (2603:10b6:8:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 21:07:57 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 21:07:57 +0000
Date:   Fri, 9 Dec 2022 13:07:53 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcee9b2-5aa8-4c5f-bb82-08dada29724f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sh9Nuj+mu0OqFAYikqdUZl+AxhesaRqCKJpDhtic0Jx76uBW8TNZJdWZelmVaK1pgT+r3FE1BqAZxwSqzJlM7WWrXMwSobU9BDrJwdMKXxJyH28+lLTMAdPq9q166qJhQcuF7G5RznQYXANn+vsS52PGeAJ763tdpZqe1cDW42OUL0ViUJPTt7cDh8kD+h5ZX3WYITfqd7W9t+lnVhkGDukon92lEQ5I7PitTdd1PFuO0UARl3835LTdqAe2ATDP0bubeB0wuJxTx26/BvWDYA6ZjPIIQZTmxtNanglt8eLozfcBMUf4WF9xZvla+naVK+RgPE+roLmXBhGQmyQQUccc4sWkG3wMegCwL26yxL7VkfpbEvaVXBiVQK2DjFFjP1GFPvRECLgCOsmcXRZg3aHCHwftnwfp8UViafsEqbp7NQom78qsCAD7XLuThykQQswW3wMFrYMTLLPhUU9/YQWdD/nJtQb7TIotpkB6gmcWIvSels2lJ+S0Qk9c8ymwJoKThOIvJpMXiuiyIByQgW9CJM9CWQMhAfyeewZ/E952t/LYeaXR5pE7xvwAl7VogHS+3oQtCBYzuWlPCyDW9uJVXZ7qVCMqD0bzIClFKIhLsp8VGcaN7C6S2mmgWzIldE3G29lBkidE8VYH9dScg/SNLRj7jFV4SIF4kSh9WDL46eLp23hHhkQo56kmBsnDjY4Y/yOWQTWeOgDobcwJ6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(84970400001)(82960400001)(8936002)(86362001)(186003)(4326008)(41300700001)(2906002)(30864003)(5660300002)(83380400001)(316002)(8676002)(6486002)(45080400002)(38100700002)(66476007)(966005)(66946007)(110136005)(66556008)(53546011)(478600001)(6666004)(6506007)(9686003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdmXUOD4HUTMdh0+KO+lHneCNtVhzVRIcsDGrJzgTsNoIkcMepsBlmfiaoPK?=
 =?us-ascii?Q?cRYRwByN+bIdSoyYXJTqzUAfBmDMWo1OocZhnYJOuYs3EDx9/dAbW0uPJryK?=
 =?us-ascii?Q?ib8d+b107VqenC8WVVjuhTTI1Dtyy63v09ovLk3a32GzDrtE+CyviZ1DM4Ai?=
 =?us-ascii?Q?9PLnYdLyV1sePaTShBLIHPN6K8guEwSELlL+QkHmwcPy8bJ2/5XoDM5/pZgU?=
 =?us-ascii?Q?a60JAVCdZ0+CglQKmSrR83MIAqCibXzAaq2j84q6uwdEAaPBMqqhe4KDGLw1?=
 =?us-ascii?Q?9car5xMvznxbIzPT/7bh03KXk84roea2a09X/b7swM1OwpCdGSNCPXY14Ddn?=
 =?us-ascii?Q?nuLnvKQmV/rEcVrVME8c1ECoWFo45YBf5g3Bbuqvl5A2jRpTqrt8LVmIpsFI?=
 =?us-ascii?Q?IX4VQB0JRlKZXftgIirXPVxPdLMBarXM5yhjpfMQxyWoQTxF7VoqiTFU0uTy?=
 =?us-ascii?Q?Hyh5t1Zhj/ah6yf/Iwp1pXnCjomsPVXriDt7B4AHAjVBNpUmy3uhUfp3Fe0W?=
 =?us-ascii?Q?6yWXoU3cLHbCcLs7PP1a4tNybaDJemsKuFi27m8x7Qw2dIqjSal4Pd/t5MpD?=
 =?us-ascii?Q?gMnCEyI07SMp0flahhBGGZOU/qTjAJ96g/gXIrHzDL4o6hDEI94kuPQbNP1q?=
 =?us-ascii?Q?9JydGvnxd1joMd0UWZxUZjm6+ybYcsstbKRoWP1QOm2/iZkyUxdvsRaSTWFe?=
 =?us-ascii?Q?lyzJbBk4wNz9vwr97R1ykQFXWupPY6OKG++x2s1dJ5gB17X0KfuzVZuoJRDu?=
 =?us-ascii?Q?1S0AvYQoN38bksvtP+Y5O0azVhqJ1NyJXIPyIzORTqs1yBptu4di6oVjAUAC?=
 =?us-ascii?Q?cQhmBA1Zm2jdPsydrE/jAjmo5XhgoDJV2RZ/wr8Py7xdX26PMHoOlhJG0gii?=
 =?us-ascii?Q?x+x0xTaV7CFBANDkEOxBFBzTcdt1/n4cXqJkyYjTKMpKf4x2/HKmmZsx5vui?=
 =?us-ascii?Q?wWiNozB+W0tco1eTuwiN12DnqhkDqgxyAizgyBtoNJnl86sSJ97TwfnRkkvY?=
 =?us-ascii?Q?vP7Y7lKb/4t9YOI/7F7/d7AQsCyHEn7JS1aJdCGiV/oUCORT4/+NjYcE8/yO?=
 =?us-ascii?Q?iFe0iaeFFSBop7HVx+8PWo1nzaJlfJRG6FBkNCNRS2rJUYZc7h9V4fsXw7xS?=
 =?us-ascii?Q?CD8NRHF2EPZnzByqshv0PUV0xxQulI7qWVBNr7H3wJxkjPLrtaXwCFe63g7+?=
 =?us-ascii?Q?BxiitT2Ve2RVq1xXqMkkhlVl6ZWjNOf0UiVJ0pWDtW3Qry+dwRk6Llwz6uLr?=
 =?us-ascii?Q?W7jn2TfMrc1sY9aYrQukEVrOhEVoeUByhAk1l+avoKejjDpyD59VLzqNGS81?=
 =?us-ascii?Q?EnMY+2ZPiWxsRFIS8xan6i6xvNu90yBVSDVX14tMlq2cobgnbXnHilqyF4W+?=
 =?us-ascii?Q?+J4dF6VIDqGXN3azbXoqAYxx77EviOlta0ctW0yJMwaUG+mGmlMNMnGX8M9j?=
 =?us-ascii?Q?S/CAaICy5SwZozvQn35PFHg7QQiGNKq8hfXSpjxgT1d68YPaMwUttxw44EYW?=
 =?us-ascii?Q?hm/dCQBevw53MrjYnn0se4EYINgfZBpw3k6ntbatapPMI5394JLOvL834ncp?=
 =?us-ascii?Q?3nrZUXKUo7F+tiuvodXYeTjImMSeWjFOc4ynweWEvNYYKSh9wnueqOaGUIPL?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcee9b2-5aa8-4c5f-bb82-08dada29724f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 21:07:57.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spUBgcCfzGo/fBMXFLQv/HlXwGfkdIg7zT9JVWAD35eBEyZJzALo4S+SEI7rwf1mcfdl+KtR6t7YkSqJkpm7UfCBw7hqApkqKPYS349xFAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Luis Chamberlain wrote:
> > Simply loading cxl_test ends up triggering a null pointer dereference
> > on next-20221207, and it happens because the fetched ACPI_COMPANION() can
> > end up not correct / missing. As with other code which uses ACPI_COMPANION()
> > (drivers/acpi/device_pm.c comes to mind) be defensive over the assumption
> > the companion is always present and bail right away.
> > 
> > This can be easily reproduced with kdevops [0] with linux next-20221207 [1]
> > and cxl enabled workflows:
> > 
> > make menuconfig      # enable cxl and linux-next
> > make                 # sets up variables, builds qemu from source
> > make linux           # builds and install next-20221207
> > make cxl             # installs cxl tool
> > make cxl-test-probe  # loads cxl_test
> > 
> > The oops:
> > 
> >  # modprobe cxl_test
> > No TPM handle discovered.
> > failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
> > 
> > [0] https://github.com/linux-kdevops/kdevops
> > [1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20221207
> > 
> > cxl_mock: loading out-of-tree module taints kernel.
> > cxl_mock: loading test module taints kernel.
> > cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
> > cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
> > cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
> > cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
> > cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
> > cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
> > cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
> > cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
> > cxl_mem mem8: at cxl_root_port.4 no parent for dport: platform
> > cxl_mem mem9: at cxl_root_port.4 no parent for dport: platform
> > cxl_mem mem10: CXL port topology not found
> > BUG: kernel NULL pointer dereference, address: 00000000000002c0
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 4 PID: 1644 Comm: systemd-udevd Kdump: loaded Tainted: G           O     N 6.1.0-rc8-next-20221207 #5
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:cxl_acpi_probe+0xeb/0x2f0 [cxl_acpi]
> > Code: ff ff ff 48 c7 40 08 ff ff ff ff 48 c7 40 18 00 02 00 00 e8 57 29 fd ff 49 89 c7 41 89 c4 48 3d 00 f0 ff ff 0f 87 73 ff ff ff <49> 8b bd c0 02 00 00 48 c7 c1 c0 64 e4 c0 48 89 c2 31 f6 e8 bd f1
> > RSP: 0018:ffffbe6d008b7c30 EFLAGS: 00010287
> > RAX: ffff97a7c6e01000 RBX: ffff97a7c51fd810 RCX: 0000000000000000
> > RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000ffffffff
> > RBP: 0000000000000000 R08: ffff97a7c51fdaa8 R09: 0000000000000010
> > R10: 0000000000000002 R11: 00000000000013c7 R12: 00000000c6e01000
> > R13: 0000000000000000 R14: ffff97a7d9c653a8 R15: ffff97a7c6e01000
> > FS:  00007f34b038ed00(0000) GS:ffff97a83bd00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000002c0 CR3: 0000000102f7e005 CR4: 0000000000770ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  ? kernfs_create_link+0x5d/0xa0
> >  platform_probe+0x41/0x90
> >  really_probe+0xdb/0x380
> >  ? pm_runtime_barrier+0x50/0x90
> >  __driver_probe_device+0x78/0x170
> >  driver_probe_device+0x1f/0x90
> >  __driver_attach+0xce/0x1c0
> >  ? __pfx___driver_attach+0x10/0x10
> >  bus_for_each_dev+0x73/0xc0
> >  bus_add_driver+0x1ae/0x200
> >  driver_register+0x89/0xe0
> >  ? __pfx_init_module+0x10/0x10 [cxl_acpi]
> >  do_one_initcall+0x43/0x220
> >  ? kmalloc_trace+0x26/0x90
> >  do_init_module+0x4a/0x1f0
> >  __do_sys_init_module+0x17f/0x1b0
> >  do_syscall_64+0x37/0x90
> >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > RIP: 0033:0x7f34b061baaa
> > Code: 48 8b 0d 59 83 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 83 0c 00 f7 d8 64 89 01 48
> > RSP: 002b:00007fff6a198408 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> > RAX: ffffffffffffffda RBX: 00005635afc7e5e0 RCX: 00007f34b061baaa
> > RDX: 00007f34b07a5efd RSI: 0000000000060a29 RDI: 00005635afdd6510
> > RBP: 00007f34b07a5efd R08: 000000000001f5b3 R09: 0000000000000000
> > R10: 000000000000eb81 R11: 0000000000000246 R12: 00005635afdd6510
> > R13: 0000000000000000 R14: 00005635afca6f40 R15: 00005635af874e50
> >  </TASK>
> > Modules linked in: cxl_acpi(+) cxl_pmem cxl_mem cxl_port cxl_mock_mem(ON) cxl_test(ON) cxl_mock(ON) cxl_core libnvdimm cbc encrypted_keys kvm_intel kvm 9p netfs irqbypass crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel crypto_simd cryptd cirrus drm_shmem_helper 9pnet_virtio virtio_balloon i6300esb drm_kms_helper joydev evdev button serio_raw drm configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev nvme virtio_pci_modern_dev crc32_pclmul nvme_core virtio crc32c_intel t10_pi virtio_ring crc64_rocksoft crc64
> > 
> > And gdb:
> > 
> > (gdb) l *(cxl_acpi_probe+0xeb)
> > 0xa8b is in cxl_acpi_probe (tools/testing/cxl/../../../drivers/cxl/acpi.c:648).
> > 643
> > 644             root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> > 645             if (IS_ERR(root_port))
> > 646                     return PTR_ERR(root_port);
> > 647
> > 648             rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
> > 649                                   add_host_bridge_dport);
> > 650             if (rc < 0)
> > 651                     return rc;
> > 652
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > 
> > Note: kdevops also suports now the target:
> > 
> >   make cxl-test-meson
> > 
> > But that does not *at least* crash the kernel although the tests fail too...
> > This is likely a misconfiguration of some sort, but the same kernel
> > works fine when I enable a Type 3 memory device (also supported on
> > kdevops via CONFIG_QEMU_ENABLE_CXL_DEMO_TOPOLOGY_1). This test was run
> > without that enabled, so a naked cxl system.
> > 
> > Even if it *was* a mis-configuration, such things should not crash the kernel.
> > 
> >  drivers/cxl/acpi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index ad0849af42d7..cf5d1a455efc 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -633,6 +633,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >  	struct acpi_device *adev = ACPI_COMPANION(host);
> >  	struct cxl_cfmws_context ctx;
> >  
> > +	if (!adev)
> > +		return -ENODEV;
> > +
> 
> I can hear the static analysis bots sharpening their knives at the
> thought that ACPI platform device drivers need to check the result of
> ACPI_COMPANION(). This is clearly a cxl_test bug, not something the
> cxl_acpi driver should ever worry about. If ACPI_COMPANION() is failing
> for the mock platform device then there are bigger problems afoot and
> this is just a band-aid until the next failure.
> 
> I'll try booting linux-next, because cxl_test is working for me just
> testing the tip of cxl.git/next.

Ok, my 6.1.0-rc8-next-20221208 build passed.

# meson test -C build --suite cxl
ninja: Entering directory `/root/git/ndctl/build'
[109/109] Linking target ndctl/ndctl
1/5 ndctl:cxl / cxl-topology.sh             OK              11.84s
2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               6.82s
3/5 ndctl:cxl / cxl-labels.sh               OK              10.14s
4/5 ndctl:cxl / cxl-create-region.sh        OK              18.32s
5/5 ndctl:cxl / security-cxl.sh             OK               3.35s

So, what I suspect is happening is that the kdevops environment is
permitting the "production" version of cxl_acpi.ko to load rather than
the test module instrumented to make ACPI_COMPANION() work with mock
devices. I.e. note that tools/testing/cxl/Kbuild has:

    ldflags-y += --wrap=is_acpi_device_node

...which means if cxl_acpi is the production version it will call the
real is_acpi_device_node() and result in the crash signature you see.

Let's just preclude that from happening. With the patch below if I force
install the production modules:

    # insmod /lib/modules/6.1.0-rc8-next-20221208+/kernel/drivers/cxl/core/cxl_core.ko 
    # insmod /lib/modules/6.1.0-rc8-next-20221208+/kernel/drivers/cxl/cxl_acpi.ko 

...and then try to load cxl_test I get:

    # modprobe cxl_test
    modprobe: ERROR: could not insert 'cxl_test': Unknown symbol in module, or unknown parameter (see dmesg)

...where dmesg has:

    cxl_test: Unknown symbol cxl_acpi_test (err -2)
    cxl_test: Unknown symbol cxl_core_test (err -2)

-- >8 --
From 93bf2c04cd3a708c73c0e4ad7a4121505a0698da Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Dec 2022 13:04:26 -0800
Subject: [PATCH] tools/testing/cxl: Prevent cxl_test from confusing production
 modules

The cxl_test machinery builds modified versions of the modules in
drivers/cxl/ and intercepts some of their calls to allow cxl_test to
inject mock CXL topologies for test.

However, if cxl_test attempts the same with production modules,
fireworks ensue as Luis discovered [1]. Prevent that scenario by
arranging for cxl_test to check for a "watermark" symbol in each of the
modules it expects to be modified before the test can run. This turns
undefined runtime behavior or crashes into a safer failure to load the
cxl_test module.

Link: http://lore.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org [1]
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/Kbuild          |  6 ++++++
 tools/testing/cxl/cxl_acpi_test.c |  6 ++++++
 tools/testing/cxl/cxl_core_test.c |  6 ++++++
 tools/testing/cxl/cxl_mem_test.c  |  6 ++++++
 tools/testing/cxl/cxl_pmem_test.c |  6 ++++++
 tools/testing/cxl/cxl_port_test.c |  6 ++++++
 tools/testing/cxl/test/cxl.c      |  8 ++++++++
 tools/testing/cxl/watermark.h     | 25 +++++++++++++++++++++++++
 8 files changed, 69 insertions(+)
 create mode 100644 tools/testing/cxl/cxl_acpi_test.c
 create mode 100644 tools/testing/cxl/cxl_core_test.c
 create mode 100644 tools/testing/cxl/cxl_mem_test.c
 create mode 100644 tools/testing/cxl/cxl_pmem_test.c
 create mode 100644 tools/testing/cxl/cxl_port_test.c
 create mode 100644 tools/testing/cxl/watermark.h

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0805f08af8b3..427174feeb7d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -23,22 +23,27 @@ obj-m += cxl_acpi.o
 cxl_acpi-y := $(CXL_SRC)/acpi.o
 cxl_acpi-y += mock_acpi.o
 cxl_acpi-y += config_check.o
+cxl_acpi-y += cxl_acpi_test.o
 
 obj-m += cxl_pmem.o
 
 cxl_pmem-y := $(CXL_SRC)/pmem.o
 cxl_pmem-y += $(CXL_SRC)/security.o
 cxl_pmem-y += config_check.o
+cxl_pmem-y += cxl_pmem_test.o
 
 obj-m += cxl_port.o
 
 cxl_port-y := $(CXL_SRC)/port.o
 cxl_port-y += config_check.o
+cxl_port-y += cxl_port_test.o
+
 
 obj-m += cxl_mem.o
 
 cxl_mem-y := $(CXL_SRC)/mem.o
 cxl_mem-y += config_check.o
+cxl_mem-y += cxl_mem_test.o
 
 obj-m += cxl_core.o
 
@@ -51,5 +56,6 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
+cxl_core-y += cxl_core_test.o
 
 obj-m += test/
diff --git a/tools/testing/cxl/cxl_acpi_test.c b/tools/testing/cxl/cxl_acpi_test.c
new file mode 100644
index 000000000000..8602dc27c81c
--- /dev/null
+++ b/tools/testing/cxl/cxl_acpi_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_acpi);
diff --git a/tools/testing/cxl/cxl_core_test.c b/tools/testing/cxl/cxl_core_test.c
new file mode 100644
index 000000000000..464a9255e4d6
--- /dev/null
+++ b/tools/testing/cxl/cxl_core_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_core);
diff --git a/tools/testing/cxl/cxl_mem_test.c b/tools/testing/cxl/cxl_mem_test.c
new file mode 100644
index 000000000000..ba7fb8a44288
--- /dev/null
+++ b/tools/testing/cxl/cxl_mem_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_mem);
diff --git a/tools/testing/cxl/cxl_pmem_test.c b/tools/testing/cxl/cxl_pmem_test.c
new file mode 100644
index 000000000000..3fd884fae537
--- /dev/null
+++ b/tools/testing/cxl/cxl_pmem_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_pmem);
diff --git a/tools/testing/cxl/cxl_port_test.c b/tools/testing/cxl/cxl_port_test.c
new file mode 100644
index 000000000000..be183917a9f6
--- /dev/null
+++ b/tools/testing/cxl/cxl_port_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_port);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 30ee680d38ff..920bd969c554 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -9,6 +9,8 @@
 #include <linux/pci.h>
 #include <linux/mm.h>
 #include <cxlmem.h>
+
+#include "../watermark.h"
 #include "mock.h"
 
 static int interleave_arithmetic;
@@ -1119,6 +1121,12 @@ static __init int cxl_test_init(void)
 {
 	int rc, i;
 
+	cxl_acpi_test();
+	cxl_core_test();
+	cxl_mem_test();
+	cxl_pmem_test();
+	cxl_port_test();
+
 	register_cxl_mock_ops(&cxl_mock_ops);
 
 	cxl_mock_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
diff --git a/tools/testing/cxl/watermark.h b/tools/testing/cxl/watermark.h
new file mode 100644
index 000000000000..9d81d4a5f6be
--- /dev/null
+++ b/tools/testing/cxl/watermark.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#ifndef _TEST_CXL_WATERMARK_H_
+#define _TEST_CXL_WATERMARK_H_
+#include <linux/module.h>
+#include <linux/printk.h>
+
+int cxl_acpi_test(void);
+int cxl_core_test(void);
+int cxl_mem_test(void);
+int cxl_pmem_test(void);
+int cxl_port_test(void);
+
+/*
+ * dummy routine for cxl_test to validate it is linking to the properly
+ * mocked module and not the standard one from the base tree.
+ */
+#define cxl_test_watermark(x)				\
+int x##_test(void)					\
+{							\
+	pr_debug("%s for cxl_test\n", KBUILD_MODNAME);	\
+	return 0;					\
+}							\
+EXPORT_SYMBOL(x##_test)
+#endif /* _TEST_CXL_WATERMARK_H_ */
-- 
2.38.1
