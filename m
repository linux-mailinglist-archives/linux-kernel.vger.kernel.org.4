Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF8619AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKDO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiKDO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:56:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247032ED4C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667573816; x=1699109816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hJWKUf4NuPQtRp34Roj2E15yGLAfK5Wxv7G4E7L5eFc=;
  b=TqlIxOBUavySJ6GzvnfFcqwF8VMYWdKE0MMgKxURVngtlNOLdSW8CXBI
   C9oWfGewd7G3zvY9HZFa4JUh1fQJ6gdXuIWQ40kuMMsMvCVJkb4OaO9Cw
   xOo0339ZbI4I71eWFpidmeu2yRIDUoTYMVj7qvbJ4YQulLbIxOJ0YHC+x
   7IgzFQ4E6PN1tm1wKACHa4jL9JSYgLCVFNIKtlkG/7kHGQnSVd6iVYBhM
   3Er6Unj8o5JxWBU71xQ5h19KT/rmNpG/tvN75iHhl4D3QP3lxkXogF15e
   qBUujNiHYNgYdW6VPNBKJ2HRTyW5LaI2I5IRWCm4zwCav0iJf4HJHzzch
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="336687923"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="336687923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:56:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="704106559"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="704106559"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:56:54 -0700
Message-ID: <7af3d21c-4313-4892-eff5-be66dacf3b13@intel.com>
Date:   Fri, 4 Nov 2022 07:56:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/5] x86: add X86_FEATURE_XENPV to disabled-features.h
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221104072701.20283-1-jgross@suse.com>
 <20221104072701.20283-2-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104072701.20283-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 00:26, Juergen Gross wrote:
> Add X86_FEATURE_XENPV to the features handled specially in
> disabled-features.h.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

