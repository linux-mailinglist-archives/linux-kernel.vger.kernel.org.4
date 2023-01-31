Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D0683308
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjAaQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjAaQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:51:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292982E0CA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675183897; x=1706719897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4/Pr+nTNrN5S1fQu3qT0O6idcEgxoMi20WoBfP+TH/4=;
  b=dWD7qWvgtLrg23FS892K4vs31iwqTYIuGQlfeu3mU+ywd/YbLX1CXpHI
   ryXmJViSmDZZYj/X3WrxUkbJ3b5slAhvEbeAcbbr4HO+o9TeQRGzL7rXJ
   IWkNpN7EjhnqSiN7A2NSJIyMFfo5DGqpGP+YSASLqciQM263nOkzZEt0I
   pVB6LCAVft/hOdwHUAQsPG7/ymCGUy03mClJWwgtqBNzJO1dY9EcJWEPN
   SAjds7WYMvJvbdmCmkdh0YrUziI26q9+xbza3e2zCz7O6m4lo82wezN9d
   MeTB6ZkXwuNUbDSYOBFJqXsYTxbRii6EU7DyR9n6/q5mSAKCnKY7ucQJJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390254758"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390254758"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696885138"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="696885138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2023 08:51:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 08:51:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 08:51:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 08:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExGv0IgVzoVG0Mn3PZRMopDPLN+fN021YH1zy4E12aIqjaZkTglNDDeW2MaFF3ECcYVa2pOQhtrEDah0Gp5n59XeERGSoe7vXPr7S5zIrvQngSomTFUALfHNkYq2cdJmQE1ZLxn6vfE8T9MqBuHnP6iRpPCsfNF+fP/w+x4SIwOzHMtZC5TShmz0EBkmPA0qYDfqUFN1VhpxwjntFQe8Pahfar0aTwMO9xNfdE+8kO/GJc6pgqXydYs8TcWbsDtudU4fzIr5gyWeCMN1068wmgzvakx1fXXZLOf0jrSx0mQdbTYwplVITloywUKfwb8BYaXZu621150bItHDPyiurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eIND+rlfWhj0VuKxI6VPAPpOlzbUU11SpQRltn4osU=;
 b=H5wib4AKAg6E15gBLnXyLxB+MfhmMcaZPatXAE3/blKg+kwlGJ2xg/5lQz/s7GmJxu2Ef57XDnTfoPugmv5m38ATPWuRLX8g7QYpdLg3TMhwep6I2zRojRif/Yigc/vvQ/uPVgctFUGJJIC/ZhDcfNFbFJxEAzLEqAwhpxOVPIG0KI+1rzX4ERsOX57lOVDZSXCGQ1ACkJNapDz/UyfaFEV649hfF76yV8yqvfpCPoDiFunPZfINF+m2NwF65Fd80xkB+w7ZF9YzWHl+egYmFMbZSVgjXSnDSCV6n1JqKeRhuarNtFmFJZXcWlqYGpeH8xW2i/KEiALrvzcS5Xzq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:51:29 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 16:51:29 +0000
Date:   Tue, 31 Jan 2023 08:51:25 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9kAlKFfdek2rq6g@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: b8167c59-c738-4cac-398c-08db03ab65c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcexGZI78oO3KQ1ZhZzrEenj0yux4iTQM6qej69XzygofKqe18pVNxZ8pwmRpX7gx6YtVxbsTrfVCXeG6VzjA6CMAqc36mG1IEAWtNZPJl8dH8HyC/t4c/CxP0Yo5ubsMsPkYgqfboKAcjvdyyadyeBb9LWFil+hWgrMQXNIa+EK3P8FxnMQEnuCNGoZG62UIUKrtWayqFlUmo7Rev3c+zYwTlulloBemapvBYgEpXwuz/QDnedjoWZjUhA4cYy2HQnD4nuErJ241pnGOQUhvUmAxUBZhwCDR8O6l8HXWUYzqz1FOdx1QKJSxyuFkQy/gtIwhiKNh25rh6AraRp4SJroWL4j+chM39zPJPgzncqreGLP9PeJ80p9uU8o/zQSUDSY3nvFccQU2RzzA0K/K2CcPbqR2fCMV4YbP8xwjvNsBOviPuIwH8H+9lHx831CSn6yUhYSe5wVKQIfoSUvnukgNG697qv86DuQ2KDZ/PNU6pgZZqKgmN6p8gbqeJJ6RtayVoLJ6FvZRJJPjvWr1Ihn5BC+mZxK/HawHeOK8NuJj8qVaLF039AUiSDuv/mEeVY7wh7DdXAD5aH6WwyAgggOnCadrQff5ZLAuuP/yc/XSX50aXB+jTlT7ewt0SxhLYXAOs+JLwY0d2VyggBbW+UxU6oQaZ9mt//LEP14YHHo5vEkiSnQUqcxZJSPeTuU5YBREGsycZfDZaU7ttL/DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(66556008)(316002)(66476007)(6916009)(54906003)(8676002)(4326008)(41300700001)(8936002)(5660300002)(66946007)(7416002)(38100700002)(86362001)(82960400001)(6666004)(107886003)(26005)(186003)(6506007)(6512007)(83380400001)(2906002)(44832011)(6486002)(478600001)(334744004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNPpq/FZ59dV9JENGFEFLIB3KVhpJFB7kfJrecp9VmDBUzC2TSt/r9Y8eNB8?=
 =?us-ascii?Q?yHa9RA01+18PuOdDxrrrgMnqKMt3kpmcFPjbsxmwsuk7VCfjAIX6UdDx8RWV?=
 =?us-ascii?Q?hTif5dtAL7u47lHgdk+/Ec1FZGDVV20k/aUKb3cnxQogWDqd/r0rbBFb2dCI?=
 =?us-ascii?Q?76GtwxwK87JbuunQjkECdaOXMECEljHTgNwAZ2YgDrrmmqvTUMvK4fJ7F1Pt?=
 =?us-ascii?Q?Klp8jaL1tGm7K4wG+rvEHskMTNEUMWN8WHU7jKyU5WPE9WfCwdL0XhuJIoir?=
 =?us-ascii?Q?pHJ8k6JUbLZIBJ9/aQRwFfMCuADAK2pperxpaObIwFb0Rpgk0wJPuWaRnFsa?=
 =?us-ascii?Q?8tHZLOrRMdUld53fsCEF6KJjwKxJqaXeVK4ZN23vTSho6sv636bYz+RBP1Yv?=
 =?us-ascii?Q?jPdN2DyfWCtsvkG1rpfG2M97nm1YYEbwTWxcZLtABVs+Q5iH1r5uH/Of/OZA?=
 =?us-ascii?Q?P5uQ65Udlv2Z5EJY17QmC5eXzgjIPHsN9g9zlxvouWmYUan3W5bLShiAD07E?=
 =?us-ascii?Q?O1uqNflbrRJO0Y+/M4c1ZejcU20ASACbjkC2odx7fl8byyVb6UF8lmz96X/P?=
 =?us-ascii?Q?lmhlXUSZpw4viUCv7fOL9OytDF2ePtkYUxuPB03jMhTniuYKdYwRzpRbNBIp?=
 =?us-ascii?Q?+7f1RvNqxkaAqcnUM23tHtDKylkzlK7dBDmsYkuOns0SozgKBVPMpUsKyY4/?=
 =?us-ascii?Q?0B/BVyva6U1mbzLGAIj+zv7oIzjvIbuBHRrTyxqGONEYFDZpOJ+rIV8e1ojg?=
 =?us-ascii?Q?G/rIDZLfbBIRb+z+9PJBcFeyPaHqcliZuJwbtYbvN59ygsK8Dz3qEadTJkMz?=
 =?us-ascii?Q?msCtn6jWnbVB91eSkaalA259D/J5PzgTjlTM/f5tYoblvJ3anl4je/7tLoeA?=
 =?us-ascii?Q?cykM9MlW+XM03QIYNjFHR7EGCVDcPK3RGe1T0VLhhWOFfbsX23Qz1shkBqAJ?=
 =?us-ascii?Q?iICSINJX88bfruJi/XQ4zUKWGhZyGvI4MHFzIjXm30MUgbg7O+td88mFuEvv?=
 =?us-ascii?Q?dxu78WLitaItkj6LJY6VpDLVz56AtuiWNBv+GZYc0UErhHRWhh3wuqiO9Opf?=
 =?us-ascii?Q?jsT1dh8PdVd09kkmKifILxE/5qXCSzJCn5GeCqmMbjz/nUcvbrZa820mObqI?=
 =?us-ascii?Q?KuA6JfVi4BaC4RGU2ZoBppjCPm2/8R34eheTWE2qRE67A7oMDQtOpTxuukpQ?=
 =?us-ascii?Q?5pe+PImqqKPHnurAYhfaRl0ycSAoRwhdtHLWbB5H+zaXkrrdJd4LgTQk9+5p?=
 =?us-ascii?Q?NRHMoMWjQB2IZxz0Zkc1iSNh5Y/cTZVnNuOKeaPX5nW86adiX5LmsRndyGZb?=
 =?us-ascii?Q?vD5xsR7V42Tra96lkpvCDTtZsvZy1zFwD50ewPtNG8S9xpTdb36xP2AaVHuL?=
 =?us-ascii?Q?1x2rk6iSyGgCcHiQaLT9S8GSLsHykD/IY3X3GdSFIWRnL7ZhW3sLTyUl8aLI?=
 =?us-ascii?Q?9Qj5rdT+AeDU/kbt9qLkOAZdyDRxgqCxnnofThTCypZSdUtjuPCwd0I+SvX0?=
 =?us-ascii?Q?g5JKi+uU0zLxRXcABfpVNj5FnJxM2WScUHi+1jqyYU1MDLNQxNuLUl/nFbcy?=
 =?us-ascii?Q?Ahq9UGH/7H/h0v9N+MReYuHNSKNOhpTYweUbFikwUbUbv+ud4gagxBfAjuXc?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8167c59-c738-4cac-398c-08db03ab65c8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:51:28.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRg3ekFbiPRe1iCY7vcXtYRBNDR0Mgxn30PSJM4yLUh0b8KpeU+d/0RJiLjBLLdImcIybS3M2AhuG2/v0TddxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:50:44PM +0100, Borislav Petkov wrote:
> On Mon, Jan 30, 2023 at 01:39:47PM -0800, Ashok Raj wrote:
> >  arch/x86/kernel/cpu/microcode/core.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> Why all this hoopla and unrelated changes?
> 
> Why don't you simply hoist the call to ->request_microcode_fw outside of
> the locked region as it doesn't have to be there and then do the usual
> pattern?

Makes total sense, and seems to make the code more readable. Thanks!

Just some minor changes below.

remove ret = 0 during initialization since its cleared right below. (tglx)

Some more below, updated patch at the end.

I have tested with the modified patch below.

> 
> ---
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 14a2280fdcd2..23f4f22df581 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -481,28 +481,28 @@ static ssize_t reload_store(struct device *dev,
>  	if (val != 1)
>  		return size;
>  
> +	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> +	if (tmp_ret != UCODE_NEW)
> +		return ret;
> +
>  	cpus_read_lock();
>  
>  	ret = check_online_cpus();
>  	if (ret)
> -		goto put;
> -
> -	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> -	if (tmp_ret != UCODE_NEW)
> -		goto put;
> +		goto unlock;

Need to set ret explicitly to either -EINVAL, or size. Otherwise it will be
endlessly waiting for write to complete. (As Aubrey pointed out)

>  
>  	mutex_lock(&microcode_mutex);
>  	ret = microcode_reload_late();

I think its safe to leave ret as is, since microcode_reload_late() only
returns -1, or 0.

>  	mutex_unlock(&microcode_mutex);
>  
> -put:
> -	cpus_read_unlock();
> -
>  	if (ret == 0)
>  		ret = size;
>  
>  	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);

Pull this into the ret == 0, so taint only if the update was successful? 
And add a message so its not silent?

>  
> +unlock:
> +	cpus_read_unlock();
> +
>  	return ret;
>  }
>  
> 

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 94d942c1bf2c..550b7c566311 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -472,7 +472,7 @@ static ssize_t reload_store(struct device *dev,
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
-	ssize_t ret = 0;
+	ssize_t ret;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -483,7 +483,7 @@ static ssize_t reload_store(struct device *dev,
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
-		return ret;
+		return (tmp_ret == UCODE_ERROR ? -EINVAL : size);
 
 	cpus_read_lock();
 
@@ -495,10 +495,11 @@ static ssize_t reload_store(struct device *dev,
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
 
-	if (ret == 0)
+	if (ret == 0) {
 		ret = size;
-
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		pr_warn("Microcode late loading tainted the kernel\n");
+	}
 
 unlock:
 	cpus_read_unlock();
