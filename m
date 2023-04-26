Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE16EFB97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjDZUMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjDZUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:12:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB119B7;
        Wed, 26 Apr 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682539969; x=1714075969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c7J1Pq+nY5OOEI59jBJPzYIKNrB4jPXkPAjR672Rb/s=;
  b=cktSQg41LlED2uDlMPHxTeLM/JaYkIKJmYyYpC6zRbhb8u5KHM7ksZth
   P0Eglnq92m1lyH62cxEO+qfhxYOiahuH4M5heAqpXmVbaZhWGiJUw60lT
   BAxkN7i8uDEQn7VJOn5GXG+FFEmr9I6apdIVEo645mCDei/a3qGlKvMf0
   K9vWjs3nuV5sp94CJMUELCFT80Alxq2qXAvB8RbnvCgBgYbXoaBcU/Tlh
   bl+EpoSNxxE25+zh3qvQTFCG0zNUrbQGwaq73Lqi/ycnR2m5q34j30Vb3
   riKJU/lYVM7Ws1KGv/Paan1nS0aQ013N+BdcU2Oz4ca8T1Y7tb+nLluEm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="347245902"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="347245902"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 13:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783454877"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="783454877"
Received: from kdaneshi-mobl2.amr.corp.intel.com (HELO [10.209.15.204]) ([10.209.15.204])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 13:12:47 -0700
Message-ID: <45a798dd-af8b-a162-adc5-71237b33b8d1@intel.com>
Date:   Wed, 26 Apr 2023 13:12:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 12:21, Carlos Bilbao wrote:
>>   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
>>   Virtualization) allows guest owners to inject secrets into the VMs              
>>   memory without the host/hypervisor being able to read them.
>>
>> My complaint about this document being too Intel/AMD centric isn't that it doesn't
>> mention other implementations, it's that the doc describes CoCo purely from the
>> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
>> release and not an objective overview of CoCo.
> Be specific about the parts of the document that you feel are too
> AMD/Intel centric, and we will correct them.

That's kinda not the point.

Confidential computing covers a *REALLY* wide swath of technologies,
even on just AMD and Intel: SGX, SEV{,-ES,SNP}, MKTME, TDX.

But this document is talking about one *VERY* *SPECIFIC* thing: VMs
running under SEV-SNP or TDX and in a very specific environment: CSPs.
Also, not even *ALL* CSPs, a subset of CSPs.  You're tossing out a huge
chunk of the confidential computing world without acknowledging it.

I don't have any great suggestions on what you call this subset.  Maybe
you get an ack from the CoVE folks:

> https://lore.kernel.org/all/20230419221716.3603068-1-atishp@rivosinc.com/

and call it
tdx-and-snp-and-cove-at-some-random-unnamed-big-fancy-csps-threat-model.rst.
 Just add an -and-foo each time a new hardware vendor shows up until
someone smarter than us finds a good name.

But I do think the difficulty here is in drawing that "line in the sand"
I was talking about.  You're trying to make the argument that once you
get hardware support for:

1. Increased guest data and state confidentiality from a VMM
2. Better guest data and state integrity in the face of VMM modification
3. More tightly controlled guest interrupt injection
4. Some additional mechanisms to control guest-host page mapping.

... then you need all this *other* stuff that the document talks about.

I think #3 and #4 are really just (SEV and TDX) implementation details.
I can certainly imagine a sane architecture without all of x86's warts
that doesn't care much about #3.

I think I know what #4 is talking about, but it's too handwavy for me to
even offer any improvements.  I actually think #4 is just a subset of
integrity protection: make sure that the same data that the guest puts
in memory at a guest physical address comes back out at that address
later.  SEV and TDX implement that by preventing the host from remapping
guest physical address space willy nilly, but it's just integrity
protection by another name.
