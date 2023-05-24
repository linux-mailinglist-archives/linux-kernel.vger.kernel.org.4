Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C263970F074
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbjEXISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjEXISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:18:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CDC0;
        Wed, 24 May 2023 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684916330; x=1716452330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hb8J2MFbOfq0VGcu3FwoZuanocKpvt9FfhzDs3/3LCs=;
  b=LDtxQPo/D50Bxe4YWQryFm2sq5niXWuKcH1lgoPofXn966wEJK9Iuk8u
   4jmdcFkm0Fapbk8gXle2UPZJh0Mr8UieMQQjNT5pNfw5pYnqN67nlZdps
   jyo5+VKJuQiSQ2z00jjl+njdvUUeeGpYr2AackJY83sZnG9GdJzDsiiR+
   L4QLce46FmT8voYsQDSvEjjeCXd4RUkAP/sLYl54U4xuqBqq2r/dRDP3o
   d/VFPA8766QLle/1SYUwx9Hdk6ZtGBWnWlhpyu1iboVYL4jdC/V8xT5+C
   cmj3038tnjlGGr4SoZ6JxBvm+6Ake1UQF2RPIERpc4ZGoT/dBlTVzOsI5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439847984"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439847984"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950910430"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="950910430"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2023 01:18:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 01:18:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 01:18:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 01:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i69hat6pZptAWzSwQHEtXwR+N0K+OSpVmk/ZHV8Ma564WBP6+c7opL/qmdQm9rDGZmTyv/NANXYfjC3hJppXDYTbcR6Hc3r3AdmyBJJlzhCnxSoVYR7leAEfZdrgelU0YaolTTBPiBan9EnIEVT5PWpgGcJfQutzvN4TMIODapFtSJ6F6AohSRhuWW28zrQuqwS3YINsvR8TBj22G7nfFyeNzH7Rh/iVml+jneUGrB4DR1cSqvjtG2JVJz/DKL8XXWEz56YhScs8WfIA4caLNfAjLit8DLfnddlvs4rbFO8ZcXI/duNQJHxBn2JFhBPFh/RejDn2tKNf+lUMkk4cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68HZp1/q9Km0Iu4OtSx3ZtBi5/MoFs9AMdSDgpKT5lw=;
 b=TLE055O8E5WDgRgTa8N0vbjEN6Qwsoo42SD5LvTUn+xFUsC7aJL6oKj3jw18NSEEWHGD0jLQ5DFF6OPkKho+yUexu74YlOebbTng3Rft6tIy3lnyWF+vxlcfjZxaEMbxnq/vdeTvUeHjugNB59+x2PPJ3dvT2pp8pzQJQelWifULYr04q+YsCayKzO429B01rcnOGvHRJCZjj48FKzjZlxJGpOVLAS2lphQOndNQK5Zb/u2+ZIS6ixyDAkta1prNQ6qy3faNx1/gGP+mEE5LkGhAL4v6pARasLe+MRsUiqeI7TPc8L8c/vq0EnwSGXWNAigoiL8Lk4SkWjr7SrzE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:18:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:18:47 +0000
Date:   Wed, 24 May 2023 16:15:31 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-modules@vger.kernel.org>
Subject: Re: [linus:master] [module] 8660484ed1:
 WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait
Message-ID: <ZG3Ho7eK+KqoAdda@yujie-X299>
References: <202305221508.753c7b78-yujie.liu@intel.com>
 <ZG2doZJrCK7Nlrqf@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG2doZJrCK7Nlrqf@bombadil.infradead.org>
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2745ca3b-da9d-4fa7-3e6e-08db5c2f7f2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anie08aM82AsKQfamveu4vMZSnG687xQMgDvvbreV4shOCJXPG0yBgWGq++GAqyAT3YojTN3j7XlVvQjqb0aQ23NoKr+ewGIO9cS5AbapdIl4PfXeb5NOW77E5Bc7E/xAJov+zrSRWKm72J4SFrxKGHoFRJUkL1Do65zRZCTpfQhEGGIIQr96VGWaqEQ/TFFiU8sWEvwHYmU0UuHql4Z0Med1TrtJPcTOWOIFtNm+luP3g7SzVgIIwgEeXqGGzzbARubju0ZRyukbhofxDNhCF6pWZMuuExv/3KF454KCpRBlyHAb1lwZumdCc0PZHyd+a9Gxd1ep5+9g7M/4a0531V2SMVEsGGkdQbwciFEg2aIOaJIWPMqWudd6Hg1RrpNCWBrU3YeiATdtk4zEcz9fUDk5E/SQRme+SaE79iLm+ZD8Cmu9npbc8jPbXk7CNHRbPXJM2gszz/bbOqyw9igIOpWYb7aj5Nd7kcXcRD3sCuDOzYder9vO8PLiqoQEniCgR7qZAXAmkpHXatjObahOB5eCQTM9jlUeJXB7YdctYd5Uk+8GMTBbsFaGfKu9TletuOEK1wlZkQ12BiSzJUdyvrivVpm1qaqYK9aQEWxu4S3Rb5GR223Z6Oms96mLTVUKNQlYCWxlweRCim08ZYeGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(966005)(2906002)(186003)(44832011)(8936002)(8676002)(9686003)(5660300002)(6512007)(6506007)(26005)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(45080400002)(86362001)(38100700002)(82960400001)(33716001)(41300700001)(83380400001)(6486002)(66899021)(316002)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rns04yHAZWDPi4Jd+yPMsTMWw+y9qnKYdiM6ohIdhzSolh+r9ue767FMATq3?=
 =?us-ascii?Q?I12m7wIQqjgdQ06EEHgWQO2E9bzD5XuuSoEgpGIgIg5lYkid3V0lfdFZ0/aG?=
 =?us-ascii?Q?PM6CKfYiK0tAPZHk96nqIGHknEh00S/AoHoAZveCJnBW3BK6hizWWf+8LQkk?=
 =?us-ascii?Q?3LwBMuxpS0db7T8d9Yfd2Kf2m1zsl0ElKmDQoA40UxbARgdJRf2ej/l1M14Q?=
 =?us-ascii?Q?SqPaotql/ya8+IgS+dqT8JZUexeWFf0iZjTXA7VEJEWcTy26NBABmuYwOAcP?=
 =?us-ascii?Q?+fXPpfeoTehuoL1nQyrcVBPo+uIeehHVHvDcHBsP64NKgXlpI9celWLRujlg?=
 =?us-ascii?Q?xarp5H1Pkn2+PWjmsfhw9Dz/wlSxTocEprXagwD/VTtVlocbSte3Dah0ORG1?=
 =?us-ascii?Q?ne3Q25imC+iTJ2qzXc+/NkruWfhjcteHuj0jHqjvZWeKHi/rWbDIMe1ua3Zk?=
 =?us-ascii?Q?WXUWBmfffq6ODnzV9/vWcmX+VUN4GcTM/ohIXqa6xVH16hIqwjeeSitaTZ9q?=
 =?us-ascii?Q?vmOwGVNFtxpNmXx+tcqLdNTiIlUNsc+6dvgFrur05NnPQ+x8CnLJZABdCf1M?=
 =?us-ascii?Q?7TOiimfEeiSKIyGkJKNwYAf5Pbn+/OftZqRb2XTI0pvVhYPNkdWwdojCpo+1?=
 =?us-ascii?Q?XjksRkzgOuBS8lvm4C4S+fUeFHCxt9exxWAMuAYrtAPArG+UamesUaIPuiGj?=
 =?us-ascii?Q?pJjYDPIDm05TamRd4/fqV2YNfsqmeSNMfWfnZzgHldyVhbtCtnBLKaWi/EgP?=
 =?us-ascii?Q?OPbrEfex80RMzUWpjzjTMHWV8/jGjfyU16dZVA/hOlhkg/8oTEIycEtH+WDE?=
 =?us-ascii?Q?/MmI96U8Mje2n25J0B6QKpT3R4F5SrB4c8dpjlN1VTiT775h4cu9oXkw3tYX?=
 =?us-ascii?Q?fiufaw1TCxgcnQsfQKLeFzwnMqehBgpVCvcPh6W/WEDXKqYxyLa8lofWro1Q?=
 =?us-ascii?Q?p9O8rMzf8JPmnxL9duZPmTZB8Qrfq6qqNrwnVBL4wH81SOdnsms1Y7h2TB3J?=
 =?us-ascii?Q?c2BcBWwYlNrFVQyF5tAR01GddfuQqaNkAHSzLe/QUKuIoZ7gClikZiGn615K?=
 =?us-ascii?Q?F7D2DCnUHuZMCgeBZMRtUbs7XAxJeOh6y+4CwHcpqPgCbsgx6ukoYcgpexHE?=
 =?us-ascii?Q?h7tWip4WG5vLLP+vtB9scypADDLoe2T81fjwECdGFpZZ4bKyezY8uYAPJcRZ?=
 =?us-ascii?Q?zHADH4Ulo8L/DgjdswmljSfPV4ftKPenN/GY3bntguXd1rum1yZ4sCmjw9mt?=
 =?us-ascii?Q?bnVHmCGkiF/xxYhalLxKFQxVxQg4CNcTx6G1BOPva81LPgGVcZJZSOEvDNI7?=
 =?us-ascii?Q?qarczLhLfq1kdC/+tGb1ssvnoTxG7dn8oOWhOcyQH5wa2zeFkvMWd4GBPn15?=
 =?us-ascii?Q?DNtRwWyGmJOOPvZEjkGRDxRrZvtump4vvX3pJO0sIiVhQCodIGQQnhta2vqJ?=
 =?us-ascii?Q?igvFRblCyTWsf3fUS7rH7P5OuF6CM+6bTIAtdC+bmVBVVxIGr3CkaMNaHCol?=
 =?us-ascii?Q?FiGDBcbuE8QsScjFHNw+pLIc7EnqM4zKhv6/MsBHacExPN/Nd2SbQrO+hvBH?=
 =?us-ascii?Q?VpshGvm2/lAe+k9WJeiietNkrB+LJX4R3qtXaU/d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2745ca3b-da9d-4fa7-3e6e-08db5c2f7f2e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:18:47.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGjSXxU7f5FP7CsUq9ARyAyy8UoRracMwSj/oz8Wtfv4VHptmOdldiLApsOv52zPTrUEHrq6VnSGT345TO3FLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
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

Hi Luis,

On Tue, May 23, 2023 at 10:16:17PM -0700, Luis Chamberlain wrote:
> On Mon, May 22, 2023 at 03:51:59PM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait" on:
> > 
> > commit: 8660484ed1cf3261e89e0bad94c6395597e87599 ("module: add debugging auto-load duplicate module support")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master 798d276b39e984345d52b933a900a71fa0815928]
> > 
> > in testcase: boot
> > 
> > compiler: gcc-11
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > We are not sure if this is expected as this patch is for debugging
> > duplicate module requests issues, so we are sending this report for
> > your information. Thanks.
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202305221508.753c7b78-yujie.liu@intel.com
> > 
> > 
> > [   48.705567][    T1] ------------[ cut here ]------------
> > [   48.706519][    T1] module-autoload: duplicate request for module intel_qat
> > [ 48.707866][ T1] WARNING: CPU: 0 PID: 1 at kernel/module/dups.c:183 kmod_dup_request_exists_wait (kernel/module/dups.c:183 (discriminator 1)) 
> 
> This is a real issue since CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE was enabled.
> If you enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE and these warnings
> come up a bette detailed report would be better. In this case the goal
> was to capture races of request_module() and so the idea for developers
> is to identify the module that caused this, in this case intel_qat, and
> then see who called the request_module() for it. They could try things
> like try_module_get(), but could also ensure that multiple requests
> won't be done in the code by using locking schemes or whatever. Only
> one request should be issued.
> 
> The trace below would show possible users but I don't even see
> drivers/crypto/qat/qat_c3xxx/adf_drv.c in my kernel tree.
> 
> If you don't to deal with this reporting you can just disable this
> config option.

Thanks a lot for the information. Does this indicate that there is
indeed a multiple requests issue in that crypto driver and we could
report to its author/owner? Thanks.

Not sure if I undertand this correctly: enabling
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE can help detect multiple
requests issues in existing code, so we should report to the original
author of the modules that have this issue, but shouldn't report on
this commit that introduces the CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
option?

--
Best Regards,
Yujie

> 
>   Luis
> 
> > [   48.709747][    T1] Modules linked in:
> > [   48.710593][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.3.0-rc1-00121-g8660484ed1cf #1
> > [ 48.712267][ T1] RIP: 0010:kmod_dup_request_exists_wait (kernel/module/dups.c:183 (discriminator 1)) 
> > [ 48.713599][ T1] Code: c7 80 e3 2a 83 e8 ba 9f fe 00 48 89 ef e8 fe 4c 17 00 80 3d 87 15 0e 02 00 4c 89 e6 74 10 48 c7 c7 20 c0 47 82 e8 d8 ba f2 ff <0f> 0b eb 0c 48 c7 c7 80 c0 47 82 e8 f7 73 fc ff 45 84 f6 75 3a 48
> > All code
> > ========
> >    0:	c7 80 e3 2a 83 e8 ba 	movl   $0xfe9fba,-0x177cd51d(%rax)
> >    7:	9f fe 00 
> >    a:	48 89 ef             	mov    %rbp,%rdi
> >    d:	e8 fe 4c 17 00       	call   0x174d10
> >   12:	80 3d 87 15 0e 02 00 	cmpb   $0x0,0x20e1587(%rip)        # 0x20e15a0
> >   19:	4c 89 e6             	mov    %r12,%rsi
> >   1c:	74 10                	je     0x2e
> >   1e:	48 c7 c7 20 c0 47 82 	mov    $0xffffffff8247c020,%rdi
> >   25:	e8 d8 ba f2 ff       	call   0xfffffffffff2bb02
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	eb 0c                	jmp    0x3a
> >   2e:	48 c7 c7 80 c0 47 82 	mov    $0xffffffff8247c080,%rdi
> >   35:	e8 f7 73 fc ff       	call   0xfffffffffffc7431
> >   3a:	45 84 f6             	test   %r14b,%r14b
> >   3d:	75 3a                	jne    0x79
> >   3f:	48                   	rex.W
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2
> >    2:	eb 0c                	jmp    0x10
> >    4:	48 c7 c7 80 c0 47 82 	mov    $0xffffffff8247c080,%rdi
> >    b:	e8 f7 73 fc ff       	call   0xfffffffffffc7407
> >   10:	45 84 f6             	test   %r14b,%r14b
> >   13:	75 3a                	jne    0x4f
> >   15:	48                   	rex.W
> > [   48.717441][    T1] RSP: 0000:ffffc9000001fc48 EFLAGS: 00010286
> > [   48.718679][    T1] RAX: 0000000000000000 RBX: ffffc9000001fcb8 RCX: 0000000000000000
> > [   48.720263][    T1] RDX: ffffc9000001f96f RSI: 0000000000000008 RDI: fffff52000003f7f
> > [   48.721791][    T1] RBP: ffff88812ec34000 R08: 0000000000000000 R09: ffffc9000001fa17
> > [   48.723349][    T1] R10: 0000000000000001 R11: ffffffff81199faf R12: ffffc9000001fd08
> > [   48.724701][    T1] R13: ffff88812a9cd800 R14: 0000000000000001 R15: 0000000000000001
> > [   48.726139][    T1] FS:  0000000000000000(0000) GS:ffffffff82cb6000(0000) knlGS:0000000000000000
> > [   48.727857][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   48.729151][    T1] CR2: ffff88843ffff000 CR3: 0000000002c6d000 CR4: 00000000000406b0
> > [   48.730703][    T1] Call Trace:
> > [   48.731336][    T1]  <TASK>
> > [ 48.731859][ T1] ? adfdrv_init (drivers/crypto/qat/qat_c3xxx/adf_drv.c:254) 
> > [ 48.732687][ T1] __request_module (kernel/module/kmod.c:168) 
> > [ 48.733637][ T1] ? free_modprobe_argv (kernel/module/kmod.c:133) 
> > [ 48.734681][ T1] ? w1_ds2760_family_init (drivers/power/supply/ds2760_battery.c:801) 
> > [ 48.735699][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125) 
> > [ 48.736791][ T1] ? adfdrv_init (drivers/crypto/qat/qat_c62x/adf_drv.c:251) 
> > [ 48.737658][ T1] adfdrv_init (drivers/crypto/qat/qat_c3xxx/adf_drv.c:254) 
> > [ 48.738518][ T1] do_one_initcall (init/main.c:1306) 
> > [ 48.739479][ T1] ? rcu_lock_acquire (kernel/notifier.c:262) 
> > [ 48.740637][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125) 
> > [ 48.741731][ T1] ? lock_is_held (include/linux/sched.h:1572) 
> > [ 48.742565][ T1] do_initcalls (init/main.c:1378 init/main.c:1395) 
> > [ 48.743358][ T1] kernel_init_freeable (init/main.c:1638) 
> > [ 48.744281][ T1] ? rest_init (init/main.c:1514) 
> > [ 48.745140][ T1] kernel_init (init/main.c:1524) 
> > [ 48.745996][ T1] ret_from_fork (arch/x86/entry/entry_64.S:314) 
> > [   48.746959][    T1]  </TASK>
> > [   48.747563][    T1] irq event stamp: 2359969
> > [ 48.748417][ T1] hardirqs last enabled at (2359977): __up_console_sem (arch/x86/include/asm/irqflags.h:26 (discriminator 3) arch/x86/include/asm/irqflags.h:67 (discriminator 3) arch/x86/include/asm/irqflags.h:127 (discriminator 3) kernel/printk/printk.c:345 (discriminator 3)) 
> > [ 48.750315][ T1] hardirqs last disabled at (2359986): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3)) 
> > [ 48.752231][ T1] softirqs last enabled at (2359662): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
> > [ 48.754058][ T1] softirqs last disabled at (2359653): irq_exit (kernel/softirq.c:445 kernel/softirq.c:650 kernel/softirq.c:674) 
> > [   48.755866][    T1] ---[ end trace 0000000000000000 ]---
> > [ 48.757648][ T1] initcall adfdrv_init+0x0/0x45 returned 0 after 52170 usecs 
> > [ 48.759132][ T1] calling adfdrv_init+0x0/0x45 @ 1 
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-6.3.0-rc1-00121-g8660484ed1cf .config
> > 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> > 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> > 	cd <mod-install-dir>
> > 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> > 
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> > 
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
