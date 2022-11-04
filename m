Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF7619EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDR3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKDR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:29:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648C260D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667582975; x=1699118975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=+3+3ou0wY1hnEBRsPKS/qKxUl7eyDgWjwmY9+Jq/l2k=;
  b=NoP4RNFxdId3KPMSKGw70OilGkdDrrC+9WTzcOXi8kqS8KTR7Q+elQW7
   Ka1XspgZB7BG5gM99Rxce3aRKai6joNuP84I3gQG5vP0iX099Yy32iskH
   D4eCDCU8YrdM7tNom65oI/y2sle8pZ82v7ZMHMzopopLFcEQQ2z9fePpf
   b3SiK4PrkEyPOr4sNGQfcS6oDNcdOLtam/ij3Yz0Nktx3+xyCkR0+ada5
   g+Nu4F7A8ruUZEFvDqHKMkQRbZXhwAReQYkKz9AZSXPj+OsugJVibCWiL
   21NuomgZHtawXtCjdtwsEVbL56KiLjzFljOYj53A9WcyvU0BrROelUmPH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="374263385"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="374263385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:29:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="637658888"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="637658888"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:29:33 -0700
Content-Type: multipart/mixed; boundary="------------N0gS0AJ0YtPQ46c7sxUVmRvK"
Message-ID: <11ccd37a-fa33-2d43-619d-e82df23708b8@intel.com>
Date:   Fri, 4 Nov 2022 10:29:33 -0700
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
 <94f56ba4-2ee1-581b-36b9-98d59a978354@intel.com>
 <DM4PR84MB185539050D426BFA8EFAC36BAB389@DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <DM4PR84MB185539050D426BFA8EFAC36BAB389@DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------N0gS0AJ0YtPQ46c7sxUVmRvK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/22 16:41, Elliott, Robert (Servers) wrote:
> How are the defconfig files supposed to keep up with valid
> combinations of options?

On some level, it doesn't matter as long as "make defconfig" and the
Kconfig rules result in something generally sane.

> Despite its filename, arch/x86/configs/x86_64_defconfig does not even have:
>   CONFIG_X86_64=y
> which enables many options. That was added by:
>   commit 622e3f28e50f ("x86: 64-bit defconfig remake")
>   Sun May 4 19:57:19 2008 +0400 
> but removed by:
>   commit 8b1bb90701f9a51f ("defconfig reduction")
>   Sat Aug 14 22:05:58 2010 +0200
> 
> It does have
>   CONFIG_SMP=y
> 
> which should imply X86_LOCAL_APIC, but that's missing too.
> 
> It does have 
>   CONFIG_HYPERVISOR_GUEST=y
> so doesn't need IRQ_REMAP to enable X86_X2APIC.

It sounds like folks generally want the defconfig files to have minimal
contents.  CONFIG_X86_64 isn't in there because it's not _needed_.

So, if the attached patch results in:

$ rm .config
$ make defconfig
$ grep X86_X2APIC .config
CONFIG_X86_X2APIC=y

Is there really anything else we need?  Kconfig seems to have figured
everything out just fine and without any complaints.
--------------N0gS0AJ0YtPQ46c7sxUVmRvK
Content-Type: text/x-patch; charset=UTF-8; name="x64-defconfig.patch"
Content-Disposition: attachment; filename="x64-defconfig.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvbmZpZ3MveDg2XzY0X2RlZmNvbmZpZyBiL2FyY2gv
eDg2L2NvbmZpZ3MveDg2XzY0X2RlZmNvbmZpZwppbmRleCA2OTc4NDUwNWE3YTguLjhjY2Nk
YTJhODljOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvY29uZmlncy94ODZfNjRfZGVmY29uZmln
CisrKyBiL2FyY2gveDg2L2NvbmZpZ3MveDg2XzY0X2RlZmNvbmZpZwpAQCAtMzAsNiArMzAs
NyBAQCBDT05GSUdfS0FMTFNZTVNfQUxMPXkKIENPTkZJR19QUk9GSUxJTkc9eQogQ09ORklH
X1NNUD15CiBDT05GSUdfSFlQRVJWSVNPUl9HVUVTVD15CitDT05GSUdfWDg2X1gyQVBJQz15
CiBDT05GSUdfUEFSQVZJUlQ9eQogQ09ORklHX1g4Nl9SRVJPVVRFX0ZPUl9CUk9LRU5fQk9P
VF9JUlFTPXkKIENPTkZJR19NSUNST0NPREVfQU1EPXkK

--------------N0gS0AJ0YtPQ46c7sxUVmRvK--
