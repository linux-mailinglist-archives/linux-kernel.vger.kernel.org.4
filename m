Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A015E7FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiIWQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:23:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220812C1C5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663950223; x=1695486223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ohgz4vUkNpBw0/bFzU4TdicddjZG3hCBlJt1N4VxeBU=;
  b=iv+i8Mo8jHT7+A0aStP4XZZlc8QJ2Lz7CFbGD69NOnzmu87DKCtG5ST/
   t9KjJnzVzUHpgds+FuXyB5rwfamKnWrDNg2+GEeY/TU8rYlnxvzTQiuwy
   mWmeok6DGlaeZVj5FCzgTsw1M0S93vBABzQFv8XeusQP0XL2CBTnIAxAs
   zptsW+Fqh4nqrow0PQxIKbw5gCBEZ3vXxedRPKTrxj6iDx2m2WFA0bOCG
   qMDO66K5lVSOYg5HA0gxb7F8nbUDkVUCrC1ONMCL7j5qu4Jv1gDL0tFZK
   OUdIwAmjM+ls/cyB7vq6H4kxVeRIPm4GdXjOWihxQfhn+E+4fyzmJ9cP7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="326957726"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="326957726"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:23:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="651003049"
Received: from hanjulee-mobl1.amr.corp.intel.com (HELO [10.252.138.32]) ([10.252.138.32])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:23:40 -0700
Message-ID: <21e4a613-cf21-6d90-17e7-91aa960bdafa@intel.com>
Date:   Fri, 23 Sep 2022 09:23:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
References: <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
 <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
 <c3fb5e4f-a906-bdee-7b34-533f36ba59f7@intel.com>
 <Yy3UWTLdIldKIfgu@araj-MOBL2.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yy3UWTLdIldKIfgu@araj-MOBL2.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 08:44, Ashok Raj wrote:
>> But, the point that Kirill and I were getting at is still that devices
>> *have* a role to play here.  The idea that this can be hidden at the
>> IOMMU layer is pure fantasy.  Right?
> If you *can't* send tagged memory to the device, what is the
> role the device need to play? 
> 
> For now you can only send proper VA's that are canonical. 

Today, yes, you have to keep tagged addresses away from devices.  They
must be sequestered in a place that only the CPU can find them.

The observation that Kirill and I had is that there are thing that are
done solely on the device today -- like accessing a translated address
twice -- without IOMMU involvement.  We were trying to figure out how
that would work in the future once tagged addresses are exposed to
devices and they implement all the new PCI magic.

After our private chat, I think the answer is that devices *have* a role
to play.  Device-side logic must know how to untag memory before asking
for translation or even *deciding* to ask for address translation.  But,
hopefully, the communicating that untagging information to the device
will be done in a device-agnostic, standardized way, just how PASIDs or
ATS are handled today.

