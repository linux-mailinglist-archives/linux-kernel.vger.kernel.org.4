Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B067466F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGDBr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDBr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:47:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B8E4E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688435276; x=1719971276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wsh0n+4ofRg3W5YAy205nkrsm0YK7/rTAXxRSMVrsmA=;
  b=Ka34WQo+c3GrrlE48s2BEjCYvm8Fd7jxTaWZDq14dmLyI99qjuUo61mg
   0ZOVsFxUxgoo1PZ5l5JpfM4UhTDZ48ytjAmyxW7EwZLckDUmp9/1vJaRi
   2pHYRP5GmHkJQmUP6Rb4+Y3g4cAtx/W4xnabnH7BA7YvL981MMiLfw3fR
   elrelUcQaA70sFharfu51fCxOSXHj3zSIyoFBctTSdLaVYmQRMR/xPiK9
   Edvti4dLN1KnY2v9c6LEL/uObTVEE3/qEBciXKhwldyUFpUbGJQYn4EfM
   JvjSQrtcwojcp8Cfld5as9cLMcZjO2+V2e2mX4v6r3b6mnK20MTk9MCQ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352833584"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="xz'341?scan'341,208,341";a="352833584"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 18:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863240985"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="xz'341?scan'341,208,341";a="863240985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 18:47:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 18:47:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 18:47:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 18:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6tPTKLoVy5oC0WLhVvhF9a+q2omiw6cIkV/IhAXAPLLwZVyaesUDDQ/yEaeuj0aAFSZu87Q/v++2xKId4DRoEnKtfUSltKFxNhRG2jB0ee5ljlB4kyQip12hwtbCQmCxXJIewLQ3atDdk9q4JLwo4N74QB3URxoFanuqTx7YxltEerDpOuokwoDKywdwh1Gf/s5GIaXNgnTFedvD1BZCrLOWWD/1c08mbMIaxYUdnlJ5ZmrCgZipIMGlEPqvdrcJWqAzQj+870AKMy2abVOJZ5vLLcl4Pyp5+2yi5QfMVrgjg6msi3DIF6HwH/3etH0sz7rlIR39yFMrPhVeNHJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMKwu91tSL8RPq9LsRdGT98rSfRtUneXE+8VIpnEyqQ=;
 b=kOSlsTOKiSwfPYfzoTyLup9rSuvzzpMiaeVZOk4KDdkaBx6sW+foNdRnMhlKC8VLoiArS3dsXw+nBWH0BozBVHIUUSS3KqW9Ri4xsd4ZP7iZn7FOgwMmArOetGTbRtQ3QQIe+KhGtPDPWhgKkkxi4mRQWQY607VvaUS8aLeTmynUrLj7MIWpYIkoH7FarQtDyNws34zaUkDHs32cyKFzwNMT7ojM6OoKq3IF0D4KlEuGWavGjavb/kLgSybtSLliuJJt6cNFwhWC8q6+eOZrxf8pU8Hy+hwQiNEu0fNdMugtSO03fdGrHsZ3ySYMqMBb/JgWMTpHYm9R1zEw5OAfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Tue, 4 Jul
 2023 01:47:00 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:46:59 +0000
Date:   Tue, 4 Jul 2023 09:46:49 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <oliver.sang@intel.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="+abfRsaU5rGaSLKx"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: bcaa4523-c033-4c8b-9881-08db7c308dd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUYDRxECzB3PGhavAHB2eSEzcA85EyQXqqDhV3qHUkUKXXvcZOHLQTBTIe95w1daSou5HCQ0vw3ImhxIowJt2Dq6cMGqjNy97GCbgpUChefryZ6aQbZIbpIYJmdxCrKHo+AkXSejZR/ur7weoGn2dt312ojTrjyOHCB9xzibFilVdqvnRZJCizmHGI668z+QxvUme5QpwobCfsmlnAWw0HeNq1nXWnKXDFT+mOjFrNik+WG1e7mtbr4D/crFn4rTI6xZdbc6z9muyyslx9Y4YDmQ6eoESZzLhEHCpcnit+MkWxFLrgmKJZQ/4A+i4ouyVUHvzDjGYH87VL2FteF3eeNlgkUMoIuhLj9bPAug6ZevCs74/l32yxYuh0osBXtHxtVwA2T193LmsVZe6j/x623kkuN/IwB06z0lte7TkbVhJZseBbdS6bFFv6MVOMe+ynV2vGqeBhcGS94n+iJWBqTDYbkXl0HQSC0kCPUFWxX/c9hgc3YHIU68dGoBmgv0QqLsqGIZPNoHMC/zTRKiAHxqImgZJCu9s4FSlv4o5poNJcQwwgeEJkmCFUpOPni9d2pqno6uOttZ808fc96s2g6GS70lscJVyw+pQI71JEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(44832011)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(6916009)(478600001)(8936002)(8676002)(235185007)(5660300002)(41300700001)(9686003)(966005)(6512007)(86362001)(54906003)(6666004)(44144004)(6486002)(33716001)(38100700002)(6506007)(26005)(186003)(83380400001)(82960400001)(107886003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUE7Xv/QMdhqFf+DaG9z5ui2usQABNGwjIkbOwU/Hvuc/yxt0DR/4kJxOYTO?=
 =?us-ascii?Q?WBezvdlAUQo/f0tITmxyWjhZukAxfWQpLBCXdEE+CT6Ak7veLB6CSkl+t4eK?=
 =?us-ascii?Q?mUe3896uSuKjgqeJEJWfvDKH30OAJlSp/iexWGMwxUFgAs/hqY07ZTQfuusO?=
 =?us-ascii?Q?qWCJhUJHnbS1ufSzWy89UHzPI+rG96JofkZtJ7lltU4f1RbGgjgcgoDRvDem?=
 =?us-ascii?Q?5hcmzB0L5mEctUGH98c8zvNOh0eTP//qfzwaktXCnO42y6sOKU226eGVFLHu?=
 =?us-ascii?Q?9FsTdT7ITMgdiodIPKBg8B8CYeGs+CTxFlueJO0yqHLqrlxDEsOvBAsRYk0c?=
 =?us-ascii?Q?SGy47vPjCS+ff0rxSBO9cIGXcLp59MKCxmyk0ygoBZjI0VvCmyQaBynShxBc?=
 =?us-ascii?Q?pIp6Q25FFZZaT+V94fDOKA50Rq+W2KapLWmZICWBsahYjmLa3H1cqEI5RSKb?=
 =?us-ascii?Q?qho6z0C8etpAwuQxdzkkOLUegKOaWWu4GiHiSO2i8+Q5nn3hGyyW9+/113QX?=
 =?us-ascii?Q?bKaYHoddiWic+wqRO5zjHd4U074zEQ49yJghL2lbmPKYW6IR/u7REZiBUc7I?=
 =?us-ascii?Q?R7glAG6SB9RwLf+ZrE8unq1LiNYeVJxxK6JBoD60fUIPRpp7m5bEa/JswIr6?=
 =?us-ascii?Q?Of795Kvns/jtH0uW5+Vp8ES+Zc/SV8Z7De5XGz+VKB3xu5iHG0qYqICSnxsf?=
 =?us-ascii?Q?m3QIYRK4zCSF0vbcryJBNwvZ4ZhmqyxmGnrdh0gaq5GuhxwJdrOReakDwEFL?=
 =?us-ascii?Q?fROTyCq+YAJxM37goLrPT90/lGPZ4soMwiZACk4v0SqWU+pRzTFmVNIrO9ZC?=
 =?us-ascii?Q?wGtzfCZzzAP+SAGV4LJBx0stVpIE5vgSPb67UJ5vIMexUo/1TwKVVvNosGdq?=
 =?us-ascii?Q?OjeF35G0+S92igdrYJKpzH2M2ejQwKgah+hpXlj90lI3uJVvfrtvsuc69EwC?=
 =?us-ascii?Q?VV1E8NNVeGON/OXe6Qqomu1fz4FFEEazLr+hXHZ/3jSAlsc5os0PT1vme/NP?=
 =?us-ascii?Q?3DkIKDYRCZLh6is/8NrO14b3qeLCMzF2hrp8Wi4oKqGlTb15H0vcqVSTjiEz?=
 =?us-ascii?Q?0nDAx+GdENd5D3pr+Qy/+Y4hTgYnBGkUJsM9ijbzlPdQP2Q1aeKwC75DXqP6?=
 =?us-ascii?Q?Cz76gd31+u14qbknNfgZ7CHyoM8j9gXOv/b9/144moqWNBKKeyGJz5ccPIYy?=
 =?us-ascii?Q?OQS2QIGvQICv1ilzWKeiDz9EvNaSldgIJusec5FxdEFJrWgC87VSy4IeaLVw?=
 =?us-ascii?Q?W93wCq1v1PnBFr+u+QkdO7NDB3bxq4zpwxKsShyX0J0K36iRISrHAjbWXMwk?=
 =?us-ascii?Q?inxtnXMSEX8N5ChLR7bwkbC1NCaLS1bk8WbvvfQlBq78kSvNWiv298Ista6J?=
 =?us-ascii?Q?Zt45fy03XcR4806DyQPSjJIedZnJIoMXGPB5ro2dGg2Zl58NGSnnBaeoXNIG?=
 =?us-ascii?Q?+44vve6z1Uo7tkiQxAZDTisfqqVnQir+2Eb+XU9JyElkQnNXxAGDs8jTqoXT?=
 =?us-ascii?Q?G2QulZI2iea4esBC+fBErWv/qOzqqHfUIA5vAqTYOLvofETy5eU/MJO7Md5A?=
 =?us-ascii?Q?NGRKtSlP5I7CsWEleqGPxHqOx3TKUqp0dmB96jioeydt0Y0ouxGA9belOcT5?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaa4523-c033-4c8b-9881-08db7c308dd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 01:46:58.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIGBtflVucbhyzqt2hOh67/8G+Qpd4FGgRt6KZQm7fNcZEFopnIy64LyJStrNcM6VYDJqIdQYlebfakW5yXZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+abfRsaU5rGaSLKx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Linus,

On Sun, Jul 02, 2023 at 09:34:35PM -0700, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 19:04, kernel test robot <oliver.sang@intel.com> wrote:
> >
> > commit: 408579cd627a15bd703fe3eeb8485fd02726e9d3 ("mm: Update do_vmi_align_munmap() return semantics")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > [  215.088258][    T1] WARNING: suspicious RCU usage
> 
> I think the
> 
>         validate_mm(mm);
> 
> call (mm/mmap.c:2561) needs to be moved up to before the
> 
>         if (unlock)
>                 mmap_read_unlock(mm);
> 
> that is just a couple of lines earlier.
> 
> Can you verify that that fixes the warning?

by patch [1], we found the warning is not fixed.


we also found there are some changes in stack backtrace. now it's as below:
(detail dmesg is attached)

[   26.412372][    T1] stack backtrace:
[   26.412846][    T1] CPU: 0 PID: 1 Comm: systemd Not tainted 6.4.0-09908-gcb226fb1fb7a #1
[   26.413506][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   26.414326][    T1] Call Trace:
[   26.414605][    T1]  <TASK>
[   26.414847][    T1]  dump_stack_lvl+0x73/0xc0
[   26.415225][    T1]  lockdep_rcu_suspicious+0x1b7/0x280
[   26.415669][    T1]  mas_start+0x280/0x400
[   26.416037][    T1]  mas_find+0x27a/0x400
[   26.416391][    T1]  validate_mm+0x8b/0x2c0
[   26.416757][    T1]  __se_sys_brk+0xa35/0xc00
[   26.417141][    T1]  ? vtime_user_exit+0x1a6/0x280
[   26.417563][    T1]  do_syscall_64+0x2b/0x80
[   26.417935][    T1]  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
[   26.418410][    T1] RIP: 0033:0x7f8a92160bb7

as a contrast, for commit 408579cd62:

[  215.095989][    T1] stack backtrace:
[  215.097067][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-09907-g408579cd627a #1
[  215.098372][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  215.099963][    T1] Call Trace:
[  215.100474][    T1]  <TASK>
[  215.101027][    T1]  dump_stack_lvl+0x73/0xc0
[  215.101807][    T1]  lockdep_rcu_suspicious+0x1b7/0x280
[  215.102688][    T1]  mas_start+0x280/0x400
[  215.103355][    T1]  mas_find+0x27a/0x400
[  215.104024][    T1]  validate_mm+0x8b/0x2c0
[  215.104777][    T1]  do_vmi_align_munmap+0xf92/0x1180
[  215.105691][    T1]  do_vmi_munmap+0x1a4/0x240
[  215.106384][    T1]  __vm_munmap+0x19f/0x300
[  215.107145][    T1]  __x64_sys_munmap+0x60/0x80
[  215.107962][    T1]  do_syscall_64+0x2b/0x80
[  215.108784][    T1]  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
[  215.109733][    T1] RIP: 0033:0x7f5ef4577e07



[1]
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2554,11 +2554,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
        mas_set(&mas_detach, start);
        remove_mt(mm, &mas_detach);
        __mt_destroy(&mt_detach);
+
+       validate_mm(mm);
+
        if (unlock)
                mmap_read_unlock(mm);

-
-       validate_mm(mm);
        return 0;

 clear_tree_failed:


> 
>                  Linus

--+abfRsaU5rGaSLKx
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAEWVo=

--+abfRsaU5rGaSLKx--
