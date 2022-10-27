Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7A660FB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiJ0PHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJ0PHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:07:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A03385B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666883259; x=1698419259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hFJGyiNNIKdLDLBnmVaJ+YaAFm78hWdHX//CEF60vOk=;
  b=KWN3pVWqUmQoIQ9WCWfrxOB1E73Bzy5vlNH+8weLEZFmhYnAfRkCSKwo
   bprF8pdxwfI+5Khl/A2qq72K6Ko9sQ5BUB95L+OguBNVChIFvhnYemoWJ
   qPiXGTTAGGwHGM7MjQu7vJbc79Tp0g0cz/x1O0J76+2/Mi8Lo9VEF3Lz4
   KlIgudsLNXL9eCiBDQmfU1IN62UtIhaZZLNTPbfBn7g3LWYT04NGV+LPW
   SacySkuQZObxOClKkfef+lsvr1foM/bTbnkggv6kKZ8GgXDwJ/o5Kqiga
   qiQFW5K+R+S/NtKfTbZyO+ucoyNzXEqUMgeFCgz8LSqscnB2akgZ9qwzP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="295657806"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="295657806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:07:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="695840635"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="695840635"
Received: from vstelter-mobl.amr.corp.intel.com (HELO [10.212.214.108]) ([10.212.214.108])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:07:37 -0700
Message-ID: <94f56ba4-2ee1-581b-36b9-98d59a978354@intel.com>
Date:   Thu, 27 Oct 2022 08:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Content-Language: en-US
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-2-mat.jonczyk@o2.pl>
 <MW5PR84MB18424DF86AE0D9B60994A38BAB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <MW5PR84MB18424DF86AE0D9B60994A38BAB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 07:45, Elliott, Robert (Servers) wrote:
>>  config X86_X2APIC
>> -	bool "Support x2apic"
>> +	bool "x2APIC interrupt controller architecture support"
>>  	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP ||
>> HYPERVISOR_GUEST)
>> +	default y
> Could this option be added to
> 	arch/x86/configs/x86_64_defconfig
> 
> so defconfig builds don't crash on current platforms?

Sounds reasonable.  Care to send a patch?

