Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7262E9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiKQXyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKQXyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:54:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2BB7ED
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668729281; x=1700265281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=ifNgXix6UY+4zxJYIfL1i9Cvl28acOJnPFX6Dwbdguc=;
  b=NYCzhENBnb4LjAWuEeQZwy3teGC1MQlHsjJ5thD5wmKpbmusknXlCH+a
   AxFOYB1M/NtGmfV6xysCirOjQsceFBE2+mq/bv4X3cKbB188y7h/9CAmW
   dFQszLIB0XjtbRozBxZIi2r9wHIkGr0wN/QW6wCNr+4/XYxRtnD9GvdqY
   Pq0jKad2dImD3PAGl0bFvHjUt/UGRBqzcUpXSstyTTj78YEEQSXHvoIi1
   o116zQN53tyP3Nz2jhSAg7uInf30VIBLuL0sGHLYL+cc1H2BselIOfwgL
   B3cNB91rv/wb9Ebh93/W+d1MKVdY20bNBokgK7FZBUeQ/tUbqkurHQxsO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292709623"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="292709623"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:54:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703530903"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703530903"
Received: from vrgatne-mobl4.amr.corp.intel.com (HELO [10.209.115.197]) ([10.209.115.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:54:22 -0800
Content-Type: multipart/mixed; boundary="------------Lh9aXApYj7BdK6v1bd25dwlY"
Message-ID: <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
Date:   Thu, 17 Nov 2022 15:54:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46
 kfence_protect
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
References: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
 <Y3Y+DQsWa79bNuKj@elver.google.com>
 <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
 <Y3bCV6VckVUEF7Pq@elver.google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y3bCV6VckVUEF7Pq@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Lh9aXApYj7BdK6v1bd25dwlY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/22 15:23, Marco Elver wrote:
> Yes - it's the 'level != PG_LEVEL_4K'.

That plus the bisect made it pretty easy to find, thanks for the effort!

Could you double-check that the attached patch fixes it?  It seemed to
for me.

The issue was that the new "No changes, easy!" check in the suspect
commit didn't check the cpa->force_split option.  It didn't split down
to 4k and then all hell broke loose.

Oh, and I totally misread the kfence ability to tolerate partial TLB
flushes.  Sorry for the noise there!

--------------Lh9aXApYj7BdK6v1bd25dwlY
Content-Type: text/x-patch; charset=UTF-8; name="kfence.patch"
Content-Disposition: attachment; filename="kfence.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgYi9hcmNoL3g4Ni9t
bS9wYXQvc2V0X21lbW9yeS5jCmluZGV4IDIyMDM2MWNlYjk5Ny4uOWI0ZTJhZDk1N2Y2IDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jCisrKyBiL2FyY2gveDg2
L21tL3BhdC9zZXRfbWVtb3J5LmMKQEAgLTE3MjcsNyArMTcyNyw4IEBAIHN0YXRpYyBpbnQg
X19jaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIoc3RydWN0IGNwYV9kYXRhICpjcGEsIGludCBw
cmltYXJ5KQogCS8qCiAJICogTm8gY2hhbmdlcywgZWFzeSEKIAkgKi8KLQlpZiAoIShwZ3By
b3RfdmFsKGNwYS0+bWFza19zZXQpIHwgcGdwcm90X3ZhbChjcGEtPm1hc2tfY2xyKSkpCisJ
aWYgKCEocGdwcm90X3ZhbChjcGEtPm1hc2tfc2V0KSB8IHBncHJvdF92YWwoY3BhLT5tYXNr
X2NscikpCisJICAgICYmICFjcGEtPmZvcmNlX3NwbGl0KQogCQlyZXR1cm4gcmV0OwogCiAJ
d2hpbGUgKHJlbXBhZ2VzKSB7Cg==

--------------Lh9aXApYj7BdK6v1bd25dwlY--
