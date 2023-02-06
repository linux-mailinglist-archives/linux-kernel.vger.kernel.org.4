Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D368BE20
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBFN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:29:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC40A5C5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675690185; x=1707226185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B12tCSr4sP7CZewdvGWMqeYh1i8kn1qIe7iV/F7WRbA=;
  b=QOZ+o0kjZ5IiZtJL1wdsFjFjjA9Pxa89QC181MnHcKZoxqDe/XI5C8qx
   fR1g8OW9VUCnl3iqxIwoUqlvfbG2CEmOGcN4nosDVWvkmdDfVch2dzLen
   498kpMPIHg1PjXvX5VTnLbrLfO9vMzost98XZppVM17uCa0RNNHauNf0p
   nLZabw95DZLDeszrrr7QZlruIpGNzomooZEtpZot28grrSeRVld4CoBXi
   R96Wqjskzi1goLM2Z7yXLuL9tffdwrNQVCthyMmpdD2XHD+Ra62UD01ir
   uFWpDye3BY3hZS9D92qBe7FOuUeNTwmo6gQyrq4Saxybb0mi9dSEiS/zr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="327836816"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="xz'341?scan'341,208,341";a="327836816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 05:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="644027812"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="xz'341?scan'341,208,341";a="644027812"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 05:29:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 05:29:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 05:29:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 05:29:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB01TANmH54z76PgAaLFT/tjTDTR1BGItA7B0RhAOXJl5k+UrMfBxy0AyA/FXChtTwlG+A2evt0vxnhot+Mlj1TiuqieJYlWQJ9PwweK2kCqHeIKqHRc71Itl52MUXY3wx8svzUIcR0bSDbBULfg1WkhoMXO2f5yGqmWOm54xerlPZ1N93ZavC7Q/WqFIi0Kij6qfNAt2BaeZS9iZezm1yCYIn5yunlrX1P0kRgif/gBusL/BIc+OLfi6ppYTlJDtSW2kLIV9vGogJhJ0VaqCCy7P2t2bv0jDRY/r+XYaQ8IoDSClZx+lsX5UCvykkYCw0fRLYl9qFGnsJfl8WiFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI3dvuzBY/BG+bQaJePEgnRStu7iEOH8NNLiZfr/Kig=;
 b=gbEcBEALtYmo+uJeOQRscp44GeRCWZDsUq12DzkhZ0i2oFDcP51APmjrnusiX1lCAVN7xoyCmncwzQT+WZWv3c07vr7m63rYPuh9DWc+JM29HH8ENFOJUFND5YX+gwl8MrFv6+OJylRXYPZk8JRpGi07lcUj3ee5dL45dDn30sna7PGlCjRc2KTvmO3Jc4Jx3xr3EQGTlOhcwBW2KTk2iMyROT9b7Fg+Bweb3mynOeKd9hx+SSejgROAWjFfFteuau5hl+oFAK4Qt21YekPgjfl8+jGW7Eswa4987G9wkSs3Cd57h3qtBItfrsTpKJU7q2R0Kxc7+/f+4C4N2TZD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:29:36 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%7]) with mapi id 15.20.6064.035; Mon, 6 Feb 2023
 13:29:36 +0000
Date:   Mon, 6 Feb 2023 21:29:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [linus:master] [iov_iter]  a41dad905e:
 WARNING:at_lib/iov_iter.c:#_copy_from_iter
Message-ID: <202302061504.e8b9acac-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="z6BYmsN3xFEB9Cw0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: fa70f357-2bec-469c-9760-08db08463068
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Sy9Uu4yS/bzjBCNHR4WkH1ZJ03qV+YTSn+75zkW3TCzEhF9bp+O5g+dvBpBf+0meMYs2QVP4iETkbFtWGaivz8g0JFIeC03gE42VtVM047BG78VfMMnmE0VlqLdqXqhLTcowXcc0SyrsGvTHOR2i9Jmv5zM5rHHCp0xMwbkCgqhkBeQz38jCZdlVYn8TifNvvGIQagiSmJXHlvCy4XzbAhlN1nhElx20zHJlrRpYA5noi4VCdizH02ZFc04Sf8gFha1ilgTFG+NOT6h+65laUFeeeMd7P3w4Ip8Eq3QR4xfnoepLRrOjLL/054OT/laa81NtmLheJLlqXLRTgudJPPznp/I8cbIEylEMDa7b2rFH1n5ti5QgeESO8XyfVMTdZGk8Q8hL7e6JYPbIKqaIyJ/ZqhiqBpPqO7VcfEh8NCGZtfnTZWKkgFIT66KWo4l/M8TLHE7+K8LacF8/TRdim6wEnSEDT85fAn2cBZQGi+JEtzkqFavvM+O3StOCyUk5wtvf2USCnNBRw4fom7HbFGCrKtH/o5IdEgBk4phtBkQqu4BKL7Y5WOdWJEiS4SzUjiRNizWBMt7R0+Nr2efvJz06WJEOExvCvywJDmffbxHafGRkfFEkaZyL9R1Od7uRNAqsAaTnvJ9DZk5mxTXwn7UhptWfIM8pdklmee1ZoP3uC8BqWtp3eyy/kLC1nf0B17DOMMvXOpxpomQewQdOih/PhyJsFBIIWtHhvChIth6F7eQNMENqwC1Apq+xe3lL632zFvEG5BtpCGnmmuh1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(235185007)(5660300002)(8936002)(41300700001)(83380400001)(2906002)(66556008)(316002)(66476007)(66946007)(45080400002)(26005)(8676002)(6512007)(186003)(4326008)(82960400001)(36756003)(38100700002)(86362001)(6916009)(966005)(478600001)(6486002)(2616005)(6506007)(44144004)(1076003)(6666004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVHv7QtJFICFThfKyRNnWS2TJlFWcj6M9nHqDMx/NaYGfO8SbuPbCnNUFmu2?=
 =?us-ascii?Q?JS3Rkp21tOueOp1wHYdfENAElxZBe6QJ2aWlvlHVAjantJXDFU6AF4IlCNjm?=
 =?us-ascii?Q?JR0eTCjvVz7Uc7VSqr38pSOtaCiNdH2EGPdAM+743obE9f4LtYrtQGrsdtBY?=
 =?us-ascii?Q?uGzMnC2Z/CW3TFPrgAWu+AxrFbLZnzryEFmjc67C+IJNNE9eXqDYLKOJm2Rd?=
 =?us-ascii?Q?80FlkyL82cmC01oFsFZY+wATkkYrf/NgvcIdP2BdHxCb/wbAi/Bys2hjcRPQ?=
 =?us-ascii?Q?IvZKAZJ32S2hXEYMnuImpoeXFXAD7a62baUrtjA2Wc0pwT2Ypq+DHgVRq+TF?=
 =?us-ascii?Q?OqAK+ZjHguLeS/6Z9kKmkeTYZmAWshmwdRZY4hCh81d3x69WaM77SqKqFYL0?=
 =?us-ascii?Q?li28UY15fGHNLmzjfGPXB86dyirQTIA+b/66Jjvb4h3QfBTZpjtGg8b4o8EB?=
 =?us-ascii?Q?XJu+ujztvZuGZ2NO0azyVnMccnKsT1SnpzhPHLgjWVO1cPPzeMFgdQyXMQNA?=
 =?us-ascii?Q?zv5CU5tn5Rt9MXexA+hNb+D17pgTJM5nRNYBsVWS8ptcIalugFBqi8QSmfyy?=
 =?us-ascii?Q?JBYMpeQVZb73/TZ8tZgkfh4zoItNVawwwC0846MGCFPqSftd4jrnnUN7cMNt?=
 =?us-ascii?Q?zxBLURS3whqV+BORPtcBxtgBTw3jLSNDTXthfKCWHITpJExNj+FToprhBStM?=
 =?us-ascii?Q?8g9BJwlMQm5tmyP93XnDX3z90LjDiLLEYts5szN6OGVIa6ca3Z43NBU/bBz5?=
 =?us-ascii?Q?4HahymZSoPlPNXkSnttOnHhU9JR9K4GJo17GqsZ9xFcUjD3HdQMKWBvdpxvw?=
 =?us-ascii?Q?DcA0Dzd+gYbpjllusMb/b7MzZi3xUqPCOCPfIJtuhZiFNBGHPyLrKWTN69VJ?=
 =?us-ascii?Q?T4bC/K4GzaE7ysfBINr3cpANDd1J7teM3P0te3Tjp3tHbQDGFLzyPF1V35TG?=
 =?us-ascii?Q?kR969QMdDMVpffFnV0eRCI+Cg9O2WRUCT07FOYKZJXxVngqgRxM2Pp228hGD?=
 =?us-ascii?Q?mZ4XgIC/wnY7osy/yHXbCnWZwrrpDgNyk4sX/d3/GLh7ZFPcbvf/vp5E7lWh?=
 =?us-ascii?Q?i5KgkIxM+mZBpxCEBHy8jDZzSJH2J/Qp1wXhpvhfmJ3P9uqgf7FOo+S99v8c?=
 =?us-ascii?Q?L9OKLVzk6P6a69Ouqm1c+XoOpa9VxadhYy8vKFBKDlkBNsHOcrZE4HPefk3o?=
 =?us-ascii?Q?7Gf0nMEayv02nGIUW9B/+3D7GU0rgLjXUa6M9oRg4nWbgmz/rDA03spVjB15?=
 =?us-ascii?Q?395c6zSJnpStxBXOT6KYYBA0IMH0M8zjOe16ndWXY5TZ3tNpOMEeGoWsRH4x?=
 =?us-ascii?Q?ATdN7shEOH0zLXHN4rCMcfCNfPJAs9SGF58kVysO0YVLpYyPSAbebLr0G5Z0?=
 =?us-ascii?Q?jX+Me1PG4LALRiYr26TYfX0va1lQjpgaFpH+PaMdKTLzO2wpc/sYlp4+9y7q?=
 =?us-ascii?Q?bstvP8RT596b6WyndShsC3kkHVl00gwwp49xNlPYhOSpvYum6Fd9jmt/s4I/?=
 =?us-ascii?Q?dnZRxrKUqLZMngsnTMuKQxhw4I6I1paUCVy0x6r3gngA7bHvHDPsVWZcDXWo?=
 =?us-ascii?Q?iC0WCwiFsYMgzd50MtUcGpdB35ilm+xF44AVr8A+As7sp6MV5apqvnr+1XJ0?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa70f357-2bec-469c-9760-08db08463068
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:29:36.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EdVJ+EkgucREfcnYRK7uSPMuQexsd2+wLx44ElEs4J73x9dQ/Vws2bjfPg4EEzrBa0pH0+bzGkbKKreYrbaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--z6BYmsN3xFEB9Cw0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_lib/iov_iter.c:#_copy_from_iter due to commit (built with gcc-11):

commit: a41dad905e5a388f88435a517de102e9b2c8e43d ("iov_iter: saner checks for attempt to copy to/from iterator")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf]

in testcase: trinity
version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s
	group: group-04

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202302061504.e8b9acac-oliver.sang@intel.com


[  242.221465][ T3972] ------------[ cut here ]------------
[ 242.222124][ T3972] WARNING: CPU: 0 PID: 3972 at lib/iov_iter.c:629 _copy_from_iter (lib/iov_iter.c:629 (discriminator 1)) 
[  242.222964][ T3972] Modules linked in:
[  242.223371][ T3972] CPU: 0 PID: 3972 Comm: trinity-c1 Not tainted 6.1.0-rc6-00011-ga41dad905e5a #1 8339b44c8ec3d4f18a4319a90a0bcea7aff1ead6
[  242.224466][ T3972] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 242.225385][ T3972] RIP: 0010:_copy_from_iter (lib/iov_iter.c:629 (discriminator 1)) 
[ 242.225915][ T3972] Code: 5f 31 d2 31 c9 31 f6 31 ff c3 e8 d6 2d b0 fe be 79 02 00 00 48 c7 c7 80 55 96 86 e8 35 d0 e1 fe e9 5b fe ff ff e8 bb 2d b0 fe <0f> 0b 45 31 f6 eb 9a e8 af 2d b0 fe 31 ff 89 ee e8 a6 29 b0 fe 40
All code
========
   0:	5f                   	pop    %rdi
   1:	31 d2                	xor    %edx,%edx
   3:	31 c9                	xor    %ecx,%ecx
   5:	31 f6                	xor    %esi,%esi
   7:	31 ff                	xor    %edi,%edi
   9:	c3                   	retq   
   a:	e8 d6 2d b0 fe       	callq  0xfffffffffeb02de5
   f:	be 79 02 00 00       	mov    $0x279,%esi
  14:	48 c7 c7 80 55 96 86 	mov    $0xffffffff86965580,%rdi
  1b:	e8 35 d0 e1 fe       	callq  0xfffffffffee1d055
  20:	e9 5b fe ff ff       	jmpq   0xfffffffffffffe80
  25:	e8 bb 2d b0 fe       	callq  0xfffffffffeb02de5
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	45 31 f6             	xor    %r14d,%r14d
  2f:	eb 9a                	jmp    0xffffffffffffffcb
  31:	e8 af 2d b0 fe       	callq  0xfffffffffeb02de5
  36:	31 ff                	xor    %edi,%edi
  38:	89 ee                	mov    %ebp,%esi
  3a:	e8 a6 29 b0 fe       	callq  0xfffffffffeb029e5
  3f:	40                   	rex

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	45 31 f6             	xor    %r14d,%r14d
   5:	eb 9a                	jmp    0xffffffffffffffa1
   7:	e8 af 2d b0 fe       	callq  0xfffffffffeb02dbb
   c:	31 ff                	xor    %edi,%edi
   e:	89 ee                	mov    %ebp,%esi
  10:	e8 a6 29 b0 fe       	callq  0xfffffffffeb029bb
  15:	40                   	rex
[  242.227582][ T3972] RSP: 0018:ffffc90006ad77f8 EFLAGS: 00010246
[  242.228150][ T3972] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  242.228892][ T3972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  242.229631][ T3972] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  242.230364][ T3972] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90006ad7c90
[  242.231109][ T3972] R13: ffff888167d8d8d0 R14: 0000000000000000 R15: ffff88810ae52c10
[  242.231843][ T3972] FS:  0000000000000000(0000) GS:ffffffff87d1b000(0063) knlGS:0000000008acb840
[  242.232662][ T3972] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  242.233259][ T3972] CR2: 0000000000000004 CR3: 00000001762d0000 CR4: 00000000000406f0
[  242.233996][ T3972] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  242.234738][ T3972] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  242.235475][ T3972] Call Trace:
[  242.235830][ T3972]  <TASK>
[ 242.236165][ T3972] ? write_comp_data (kernel/kcov.c:236) 
[ 242.236643][ T3972] ? memset (mm/kasan/shadow.c:44) 
[ 242.237057][ T3972] ? __build_skb_around (include/linux/skbuff.h:5033 (discriminator 4) net/core/skbuff.c:296 (discriminator 4)) 
[ 242.237563][ T3972] ? _copy_mc_to_iter (lib/iov_iter.c:628) 
[ 242.238062][ T3972] ? __alloc_skb (net/core/skbuff.c:479) 
[ 242.238521][ T3972] ? kmalloc_reserve (net/core/skbuff.c:479) 
[ 242.238998][ T3972] ? __lock_release (kernel/locking/lockdep.c:5344) 
[ 242.239470][ T3972] ? tipc_node_find (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/linux/refcount.h:147 include/linux/refcount.h:152 include/linux/refcount.h:227 include/linux/refcount.h:245 include/linux/kref.h:111 net/tipc/node.c:342) 
[ 242.239947][ T3972] ? write_comp_data (kernel/kcov.c:236) 
[ 242.240418][ T3972] ? write_comp_data (kernel/kcov.c:236) 
[ 242.240892][ T3972] ? __check_object_size (mm/usercopy.c:218) 
[ 242.241399][ T3972] tipc_msg_build (include/linux/uio.h:192 net/tipc/msg.c:404) 
[ 242.241871][ T3972] ? tipc_msg_assemble (net/tipc/msg.c:370) 
[ 242.242361][ T3972] ? tipc_node_find_by_name+0x420/0x420 
[ 242.242975][ T3972] ? tipc_node_get_mtu (net/tipc/node.c:230) 
[ 242.243479][ T3972] __tipc_sendmsg (net/tipc/socket.c:1506) 
[ 242.243964][ T3972] ? tipc_sendmcast (net/tipc/socket.c:1410) 
[ 242.244442][ T3972] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5670) 
[ 242.244904][ T3972] ? lock_sock_nested (include/net/sock.h:1820 net/core/sock.c:3451) 
[ 242.245388][ T3972] ? find_held_lock (kernel/locking/lockdep.c:5158) 
[ 242.245866][ T3972] ? autoremove_wake_function (kernel/sched/wait.c:478) 
[ 242.246419][ T3972] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:227 (discriminator 3) kernel/locking/lockdep.c:4612 (discriminator 3)) 
[ 242.246864][ T3972] ? mark_held_locks (kernel/locking/lockdep.c:4236) 
[ 242.247337][ T3972] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4262 kernel/locking/lockdep.c:4321) 
[ 242.247900][ T3972] ? write_comp_data (kernel/kcov.c:236) 
[ 242.248378][ T3972] tipc_connect (net/tipc/socket.c:2625) 
[ 242.248828][ T3972] ? tipc_sendmsg (net/tipc/socket.c:2572) 
[ 242.249278][ T3972] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4262 kernel/locking/lockdep.c:4321) 
[ 242.249844][ T3972] ? write_comp_data (kernel/kcov.c:236) 
[ 242.250317][ T3972] ? security_socket_connect (security/security.c:2216 (discriminator 14)) 
[ 242.250843][ T3972] ? tipc_sendmsg (net/tipc/socket.c:2572) 
[ 242.251297][ T3972] __sys_connect_file (net/socket.c:1976) 
[ 242.251794][ T3972] __sys_connect (net/socket.c:1993) 
[ 242.252258][ T3972] ? __sys_connect_file (net/socket.c:1983) 
[ 242.252771][ T3972] ? find_held_lock (kernel/locking/lockdep.c:5158) 
[ 242.253245][ T3972] ? __lock_release (kernel/locking/lockdep.c:5344) 
[ 242.253714][ T3972] ? __task_pid_nr_ns (include/linux/rcupdate.h:99 include/linux/rcupdate.h:770 kernel/pid.c:501) 
[ 242.254209][ T3972] __ia32_sys_connect (net/socket.c:2000) 
[ 242.254687][ T3972] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
[ 242.255182][ T3972] ? __task_pid_nr_ns (include/linux/rcupdate.h:99 include/linux/rcupdate.h:770 kernel/pid.c:501) 
[ 242.255676][ T3972] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4262 kernel/locking/lockdep.c:4321) 
[ 242.256244][ T3972] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 242.256748][ T3972] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 242.257253][ T3972] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
[ 242.257734][ T3972] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:122) 
[  242.258318][ T3972] RIP: 0023:0xf7fb5549
[ 242.258730][ T3972] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc6-00011-ga41dad905e5a .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--z6BYmsN3xFEB9Cw0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc6-00011-ga41dad905e5a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
# CONFIG_NET_NS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
# CONFIG_HIBERNATION_SNAPSHOT_DEV is not set
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_NFIT=y
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
# CONFIG_ACPI_APEI_MEMORY_FAILURE is not set
CONFIG_ACPI_APEI_EINJ=y
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_AMD_PSTATE_UT=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_SECCOMP_CACHE_DEBUG=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
# CONFIG_PTE_MARKER_UFFD_WP is not set
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
# CONFIG_LRU_GEN_STATS is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_TLS_DEVICE=y
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_INTERFACE=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_ESP=y
# CONFIG_NET_KEY is not set
CONFIG_SMC=y
CONFIG_SMC_DIAG=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
# CONFIG_IPV6_PIMSM_V2 is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
# CONFIG_MPTCP_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
CONFIG_BPFILTER=y
# CONFIG_BPFILTER_UMH is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
CONFIG_L2TP_V3=y
# CONFIG_L2TP_IP is not set
CONFIG_L2TP_ETH=y
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_AR9331=y
CONFIG_NET_DSA_TAG_BRCM_COMMON=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_HELLCREEK=y
CONFIG_NET_DSA_TAG_GSWIP=y
CONFIG_NET_DSA_TAG_DSA_COMMON=y
# CONFIG_NET_DSA_TAG_DSA is not set
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_OCELOT=y
CONFIG_NET_DSA_TAG_OCELOT_8021Q=y
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_NET_DSA_TAG_RTL4_A=y
CONFIG_NET_DSA_TAG_RTL8_4=y
CONFIG_NET_DSA_TAG_RZN1_A5PSW=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_SJA1105=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_NET_DSA_TAG_XRS700X=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=y
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_IFE_SKBMARK is not set
CONFIG_NET_IFE_SKBPRIO=y
# CONFIG_NET_IFE_SKBTCINDEX is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUG=y
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
# CONFIG_BAYCOM_PAR is not set
CONFIG_YAM=y
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
CONFIG_BT_HIDP=y
CONFIG_BT_HS=y
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_AOSPEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=y
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_BT_MRVL_SDIO=y
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_MCTP_FLOWS=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
CONFIG_ZRAM_DEF_COMP_ZSTD=y
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
CONFIG_ZRAM_DEF_COMP="zstd"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=y
# CONFIG_DRBD_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=y
# CONFIG_BLK_DEV_UBLK is not set
# CONFIG_BLK_DEV_RNBD_CLIENT is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set
CONFIG_NVME_TARGET_TCP=y
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_SCSI_BNX2X_FCOE is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_LIBFC=y
CONFIG_LIBFCOE=y
# CONFIG_FCOE is not set
# CONFIG_FCOE_FNIC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
# CONFIG_ATA_ACPI is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_DWC=y
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
CONFIG_SATA_DWC=y
CONFIG_SATA_DWC_OLD_DMA=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
CONFIG_BCACHE_CLOSURES_DEBUG=y
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
# CONFIG_DM_CACHE_SMQ is not set
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_EBS=y
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=y
CONFIG_DM_MULTIPATH_HST=y
CONFIG_DM_MULTIPATH_IOA=y
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=y
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
CONFIG_TCM_FC=y
CONFIG_ISCSI_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=y
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_MDIO_DRIVER=y
# CONFIG_B53_MMAP_DRIVER is not set
CONFIG_B53_SRAB_DRIVER=y
CONFIG_B53_SERDES=y
CONFIG_NET_DSA_BCM_SF2=y
CONFIG_NET_DSA_LOOP=y
CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK=y
CONFIG_NET_DSA_LANTIQ_GSWIP=y
CONFIG_NET_DSA_MT7530=y
CONFIG_NET_DSA_MV88E6060=y
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=y
# CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C is not set
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=y
# CONFIG_NET_DSA_MV88E6XXX is not set
CONFIG_NET_DSA_MSCC_SEVILLE=y
CONFIG_NET_DSA_AR9331=y
CONFIG_NET_DSA_QCA8K=y
CONFIG_NET_DSA_XRS700X=y
# CONFIG_NET_DSA_XRS700X_I2C is not set
CONFIG_NET_DSA_XRS700X_MDIO=y
CONFIG_NET_DSA_REALTEK=y
CONFIG_NET_DSA_REALTEK_MDIO=y
CONFIG_NET_DSA_REALTEK_SMI=y
# CONFIG_NET_DSA_REALTEK_RTL8365MB is not set
CONFIG_NET_DSA_REALTEK_RTL8366RB=y
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
CONFIG_NET_DSA_VITESSE_VSC73XX=y
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=y
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_NET_VENDOR_DAVICOM is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
CONFIG_TSNEP=y
# CONFIG_TSNEP_SELFTESTS is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_NET_VENDOR_WANGXUN is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH_LIB=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_8390 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=y
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_SELFTESTS is not set
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_DWMAC_INTEL=y
# CONFIG_DWMAC_LOONGSON is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_SFP=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
CONFIG_ADIN_PHY=y
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=y
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MARVELL_88X2222_PHY is not set
CONFIG_MAXLINEAR_GPHY=y
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=y
CONFIG_NATIONAL_PHY=y
CONFIG_NXP_C45_TJA11XX_PHY=y
CONFIG_NXP_TJA11XX_PHY=y
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_PSE_CONTROLLER=y
CONFIG_PSE_REGULATOR=y

#
# MCTP Device Drivers
#
CONFIG_MCTP_SERIAL=y
CONFIG_MCTP_TRANSPORT_I2C=y
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_I2C=y
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
CONFIG_PCS_LYNX=y
CONFIG_PCS_ALTERA_TSE=y
# end of PCS device drivers

CONFIG_PLIP=y
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=y
CONFIG_PPPOL2TP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
# CONFIG_SLIP is not set
CONFIG_SLHC=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
CONFIG_WAN=y
# CONFIG_HDLC is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
# CONFIG_WWAN_HWSIM is not set
# CONFIG_RPMSG_WWAN_CTRL is not set
# CONFIG_IOSM is not set
# CONFIG_MTK_T7XX is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
CONFIG_FUJITSU_ES=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=y
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_IQS62X=y
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADC is not set
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATC260X_ONKEY=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_IBM_PANEL=y
CONFIG_INPUT_IQS269A=y
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_INPUT_RT5120_PWRKEY=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
CONFIG_SERIAL_LITEUART_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_N_GSM=y
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_RPMSG_TTY=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_RK3X=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
CONFIG_PTP_1588_CLOCK_IDTCM=y
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_METEORLAKE=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD71815=y
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WHISKEY_COVE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_MT6323 is not set
CONFIG_POWER_RESET_REGULATOR=y
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
# CONFIG_MAX8925_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9030 is not set
CONFIG_CHARGER_DA9150=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_RK817=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1266 is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE152=y
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC2305=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=y
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_MENZ069_WATCHDOG is not set
CONFIG_WDAT_WDT=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=y
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_EXAR_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_BXTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_NTXEC=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_QCOM_PM8008=y
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD71815=y
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6331=y
CONFIG_REGULATOR_MT6332=y
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5120 is not set
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS68470 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=y
CONFIG_IR_FINTEK=y
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_HIX5HD2=y
CONFIG_IR_ITE_CIR=y
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_LOOPBACK=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_VIDEO_MUX is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#
# CONFIG_VIDEO_ASPEED is not set

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
CONFIG_VIDEO_CADENCE_CSI2RX=y
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
# CONFIG_VIDEO_CAFE_CCIC is not set

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
CONFIG_VIDEO_XILINX=y
CONFIG_VIDEO_XILINX_CSI2RXSS=y
CONFIG_VIDEO_XILINX_TPG=y
CONFIG_VIDEO_XILINX_VTC=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
CONFIG_VIDEO_AR0521=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
CONFIG_VIDEO_HI847=y
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=y
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX334=y
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
CONFIG_VIDEO_IMX412=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_NOON010PC30=y
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV5648=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV9734=y
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_S5K6A3=y
CONFIG_VIDEO_S5K6AA=y
CONFIG_VIDEO_SR030PC30=y
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=y
CONFIG_VIDEO_DW9768=y
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Video and audio decoders
#
CONFIG_MEDIA_TUNER=y

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_USE_DYNAMIC_DEBUG is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
CONFIG_DRM_RCAR_USE_MIPI_DSI=y
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_EDP=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_JDI_R63452=y
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=y
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CHIPONE_ICN6211 is not set
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_ITE_IT6505=y
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=y
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=y
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NWL_MIPI_DSI=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=y
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TOSHIBA_TC358768=y
CONFIG_DRM_TOSHIBA_TC358775=y
CONFIG_DRM_TI_DLPC3433=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_CDNS_MHDP8546=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_LOGICVC=y
CONFIG_DRM_MXS=y
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_IMX_LCDIF=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=y
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
# CONFIG_NINTENDO_FF is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PXRC is not set
CONFIG_HID_RAZER=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_TOPRE=y
CONFIG_HID_THINGM=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
CONFIG_I2C_HID_OF=y
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SD8787=y
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_LITEX=y
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MAX77693=y
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
CONFIG_RDMA_SIW=y
# CONFIG_INFINIBAND_IPOIB is not set
CONFIG_INFINIBAND_SRP=y
CONFIG_INFINIBAND_SRPT=y
CONFIG_INFINIBAND_ISER=y
CONFIG_INFINIBAND_ISERT=y
CONFIG_INFINIBAND_RTRS=y
CONFIG_INFINIBAND_RTRS_CLIENT=y
# CONFIG_INFINIBAND_RTRS_SERVER is not set
CONFIG_INFINIBAND_OPA_VNIC=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
# CONFIG_VDPA_SIM is not set
CONFIG_VDPA_USER=y
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=y
# CONFIG_VHOST_VDPA is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_MLXREG_LC=y
CONFIG_NVSW_SN2201=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=y
CONFIG_SURFACE_HOTPLUG=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_HUAWEI_WMI=y
CONFIG_MXM_WMI=y
CONFIG_PEAQ_WMI=y
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=y
CONFIG_XIAOMI_WMI=y
CONFIG_GIGABYTE_WMI=y
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACER_WMI=y
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_TF103C_DOCK=y
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=y
# CONFIG_DCDBAS is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
CONFIG_DELL_WMI_AIO=y
CONFIG_DELL_WMI_LED=y
CONFIG_DELL_WMI_SYSMAN=y
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
CONFIG_WIRELESS_HOTKEY=y
# CONFIG_HP_WMI is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_THINKPAD_LMI=y
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_SKL_INT3472=y
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=y

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
# CONFIG_INTEL_MRFLD_PWRBTN is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_WMI=y
CONFIG_PCENGINES_APU2=y
CONFIG_BARCO_P50_GPIO=y
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_FW_ATTR_CLASS=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=y
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_VC7=y
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_INTEL_MRFLD is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL367=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
# CONFIG_AD7291 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD799X is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
# CONFIG_INTEL_MRFLD_ADC is not set
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_NAU7802 is not set
# CONFIG_PALMAS_GPADC is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_QCOM_SPMI_ADC5=y
# CONFIG_RICHTEK_RTQ6056 is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VF610_ADC=y
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BOSCH_BNO055=y
CONFIG_BOSCH_BNO055_I2C=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
# CONFIG_LTR501 is not set
CONFIG_LTRF216A=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2591=y
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_NTXEC is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
# CONFIG_BTT is not set
# CONFIG_OF_PMEM is not set
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_INTERRUPT_CNT is not set
CONFIG_FTM_QUADDEC=y
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
# CONFIG_INTEL_QEP is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_ENCRYPTION_INLINE_CRYPT is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_ZONE=y
CONFIG_PSTORE_BLK=y
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_LSM_MMAP_MIN_ADDR=65536
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_SELINUX=y
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_AVC_STATS is not set
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
# CONFIG_INTEGRITY_AUDIT is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_EXTRA_SMACK_XATTRS=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
CONFIG_CRYPTO_STATS=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
CONFIG_SAMPLE_AUXDISPLAY=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=y
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_CONNECTOR is not set
# CONFIG_SAMPLE_FANOTIFY_ERROR is not set
CONFIG_SAMPLE_HIDRAW=y
CONFIG_SAMPLE_LANDLOCK=y
CONFIG_SAMPLE_PIDFD=y
CONFIG_SAMPLE_SECCOMP=y
# CONFIG_SAMPLE_TIMER is not set
# CONFIG_SAMPLE_UHID is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
CONFIG_SAMPLE_VFS=y
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_TEST_DYNAMIC_DEBUG=y
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--z6BYmsN3xFEB9Cw0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Sherry-Sun/tty-serial-fsl_lpuart-don-t-enable-receiver-transmitter-before-rx-tx-dma-ready/20230130-134334'
	export commit='a41dad905e5a388f88435a517de102e9b2c8e43d'
	export kconfig='x86_64-randconfig-a004-20230130'
	export nr_vm=300
	export submit_id='63dc42ba1a47166a4697bec8'
	export job_file='/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-a41dad905e5a388f88435a517de102e9b2c8e43d-20230203-27206-w8qgfc-0.yaml'
	export id='99859ac06ac26bcc2cd0db4a1ff33e5eeac8103a'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-i386-minimal-20190520.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-02-03 07:09:46 +0800'
	export _id='63dc42ba1a47166a4697bec8'
	export _rt='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/yocto/yocto-i386-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d/vmlinuz-6.1.0-rc6-00011-ga41dad905e5a
branch=linux-review/Sherry-Sun/tty-serial-fsl_lpuart-don-t-enable-receiver-transmitter-before-rx-tx-dma-ready/20230130-134334
job=/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-a41dad905e5a388f88435a517de102e9b2c8e43d-20230203-27206-w8qgfc-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a004-20230130
commit=a41dad905e5a388f88435a517de102e9b2c8e43d
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-102'
	export kernel='/pkg/linux/x86_64-randconfig-a004-20230130/gcc-11/a41dad905e5a388f88435a517de102e9b2c8e43d/vmlinuz-6.1.0-rc6-00011-ga41dad905e5a'
	export dequeue_time='2023-02-03 07:47:00 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-a41dad905e5a388f88435a517de102e9b2c8e43d-20230203-27206-w8qgfc-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-04' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--z6BYmsN3xFEB9Cw0
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--z6BYmsN3xFEB9Cw0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="trinity"

Seeding trinity by 482730 based on vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-a004-20230130
2023-02-02 23:48:41 trinity -q -q -l off -s 482730 -N 999999999 -c accept4 -c clock_settime -c connect -c delete_module -c fallocate -c fchown16 -c fcntl -c finit_module -c futimesat -c getgroups16 -c getsockopt -c gettid -c kill -c lchown -c llistxattr -c madvise -c mkdirat -c mmap -c modify_ldt -c move_mount -c msgget -c perf_event_open -c pivot_root -c pkey_alloc -c pkey_mprotect -c prctl -c pread64 -c ptrace -c rename -c rt_sigprocmask -c sched_rr_get_interval -c select -c setfsgid -c setpriority -c setresuid16 -c setsid -c sigprocmask -c symlinkat -c tee -c timerfd_create -c times -c unshare -c utimes -c vm86old -X
Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
shm:0xf754a000-0x3cf6e14 (4 pages)
[main] Marking syscall accept4 (364) as to be enabled.
[main] Marking syscall clock_settime (264) as to be enabled.
[main] Marking syscall connect (362) as to be enabled.
[main] Marking syscall delete_module (129) as to be enabled.
[main] Marking syscall fallocate (324) as to be enabled.
[main] Marking syscall fchown16 (95) as to be enabled.
[main] Marking syscall fcntl (55) as to be enabled.
[main] Marking syscall finit_module (350) as to be enabled.
[main] Marking syscall futimesat (299) as to be enabled.
[main] Marking syscall getgroups16 (80) as to be enabled.
[main] Marking syscall getsockopt (365) as to be enabled.
[main] Marking syscall gettid (224) as to be enabled.
[main] kill is marked as AVOID. Skipping
[main] Marking syscall kill (37) as to be enabled.
[main] Marking syscall lchown (198) as to be enabled.
[main] Marking syscall llistxattr (233) as to be enabled.
[main] Marking syscall madvise (219) as to be enabled.
[main] Marking syscall mkdirat (296) as to be enabled.
[main] Marking syscall mmap (90) as to be enabled.
[main] Marking syscall modify_ldt (123) as to be enabled.
[main] Marking syscall move_mount (422) as to be enabled.
[main] Marking syscall msgget (393) as to be enabled.
[main] Marking syscall perf_event_open (336) as to be enabled.
[main] Marking syscall pivot_root (217) as to be enabled.
[main] Marking syscall pkey_alloc (381) as to be enabled.
[main] Marking syscall pkey_mprotect (380) as to be enabled.
[main] Marking syscall prctl (172) as to be enabled.
[main] Marking syscall pread64 (180) as to be enabled.
[main] ptrace is marked as AVOID. Skipping
[main] Marking syscall ptrace (26) as to be enabled.
[main] Marking syscall rename (38) as to be enabled.
[main] Marking syscall rt_sigprocmask (175) as to be enabled.
[main] Marking syscall sched_rr_get_interval (161) as to be enabled.
[main] Marking syscall select (82) as to be enabled.
[main] Marking syscall setfsgid (216) as to be enabled.
[main] Marking syscall setpriority (97) as to be enabled.
[main] Marking syscall setresuid16 (164) as to be enabled.
[main] Marking syscall setsid (66) as to be enabled.
[main] Marking syscall sigprocmask (126) as to be enabled.
[main] Marking syscall symlinkat (304) as to be enabled.
[main] Marking syscall tee (315) as to be enabled.
[main] Marking syscall timerfd_create (322) as to be enabled.
[main] Marking syscall times (43) as to be enabled.
[main] Marking syscall unshare (310) as to be enabled.
[main] Marking syscall utimes (271) as to be enabled.
[main] Marking syscall vm86old (113) as to be enabled.
[main] Using user passed random seed: 482730.
[main] Enabled 44 syscalls. Disabled 385 syscalls.
--dropprivs is still in development, and really shouldn't be used unless you're helping development. Expect crashes.
Going to run as user nobody (uid:65534 gid:65534)
ctrl-c now unless you really know what you are doing.
Continuing in 10 seconds.
Continuing in 9 seconds.
Continuing in 8 seconds.
Continuing in 7 seconds.
Continuing in 6 seconds.
Continuing in 5 seconds.
Continuing in 4 seconds.
Continuing in 3 seconds.
Continuing in 2 seconds.
Continuing in 1 seconds.
[main] Using pid_max = 32768
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] Reserved/initialized 5 futexes.
[main] Added 22 filenames from /dev
[main] Something went wrong during nftw(/proc). (-1:Value too large for defined data type)
[main] Added 15252 filenames from /sys
[main] Enabled 14/14 fd providers. initialized:14.
[main] Error opening tracing_on : No such file or directory
[main] 14331 iterations. [F:10824 S:3493 HI:5123]
[main] 24642 iterations. [F:18678 S:5944 HI:10343]
[main] 37035 iterations. [F:28072 S:8931 HI:11755]
[main] 47942 iterations. [F:36367 S:11535 HI:17808]
[main] 59281 iterations. [F:45028 S:14208 HI:19585]
[main] 71087 iterations. [F:54238 S:16794 HI:22961]
[main] 82736 iterations. [F:63275 S:19398 HI:26558]
[main] 98951 iterations. [F:75840 S:23038 HI:31064]
[main] 111460 iterations. [F:85687 S:25689 HI:34717]
[main] 125766 iterations. [F:96963 S:28713 HI:37555]
[main] 136014 iterations. [F:105046 S:30865 HI:38586]
[main] 148020 iterations. [F:114475 S:33440 HI:43418]
[main] 160386 iterations. [F:124260 S:36011 HI:44999]
[main] 170832 iterations. [F:132546 S:38163 HI:48292]
[main] 184714 iterations. [F:143496 S:41089 HI:51936]
[main] 195527 iterations. [F:151972 S:43419 HI:53602]
[main] 206970 iterations. [F:160936 S:45893 HI:57813]
[main] 217480 iterations. [F:169262 S:48071 HI:59594]
[main] 227963 iterations. [F:177453 S:50355 HI:63413]
[main] 244393 iterations. [F:190450 S:53782 HI:68227]
[main] 256971 iterations. [F:200389 S:56418 HI:71196]
[main] 267633 iterations. [F:208805 S:58658 HI:72425]
[main] 283013 iterations. [F:221020 S:61820 HI:75923]
[main] 296080 iterations. [F:231374 S:64527 HI:82254]
[main] 308001 iterations. [F:240856 S:66960 HI:85748]
[main] 320593 iterations. [F:250840 S:69559 HI:87871]
[main] 334470 iterations. [F:261766 S:72504 HI:88916]
[main] 344712 iterations. [F:269853 S:74650 HI:92872]
[main] 357517 iterations. [F:279946 S:77356 HI:96132]
[main] 367928 iterations. [F:288185 S:79518 HI:100975]
[main] 382482 iterations. [F:299677 S:82573 HI:105941]
[main] 395715 iterations. [F:310098 S:85377 HI:109101]
[main] 406371 iterations. [F:318497 S:87632 HI:113286]
[main] 417616 iterations. [F:327439 S:89928 HI:118899]
[main] 428412 iterations. [F:336011 S:92142 HI:122165]
[main] 439045 iterations. [F:344384 S:94389 HI:124584]
[main] 449809 iterations. [F:352887 S:96642 HI:128029]
[main] 463601 iterations. [F:363770 S:99539 HI:130179]
[main] kernel became tainted! (512/0) Last seed was 482730
trinity: Detected kernel tainting. Last seed was 482730
[main] 476727 iterations. [F:374139 S:102282 HI:132800]
[main] exit_reason=7, but 2 children still running.
[main] Bailing main loop because kernel became tainted..
[main] Ran 476727 syscalls. Successes: 102282  Failures: 374139

--z6BYmsN3xFEB9Cw0--
