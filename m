Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635073D197
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFYO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:57:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC61A4;
        Sun, 25 Jun 2023 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687705046; x=1719241046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGqgvaD+5Wnf9e9vSx/grT8jjpbyaA5KF68+R0VXUBM=;
  b=hMoxNVkoU+je1K9rVN9zVMMbNmr3j+/lcj9EnZNNm5EmF7Tmz4e+tnFN
   8EYDwZur9yRMUnD3NioGrQa0XH0AMtwIKK60gc/3fD5ksgPDtJW8eRD7F
   wWTAw61Jd1/fmMLyUiwf5qeyhnQQR3580cfLR7uk8B/vA0Vdy/bP6/Oc8
   PqqrGygzGxFuuuXQIBf1+YuIWjv1RFBtjhfUZuoMZnJRQ/qgl8xQAkQyp
   XdCrrmL1JOe4M/bHEXS6o9Qnntct5CB6p5glZtpeVjRq+VkxsWDhh1EOJ
   ApTi8ZVxW5QKR0XuJT8Mn7vA6sQOkiwF8lF0KaIJd54Fd+hzH6TdxYags
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364521666"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="364521666"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 07:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860412330"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="860412330"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 07:57:24 -0700
Date:   Sun, 25 Jun 2023 07:57:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rongtao@cestc.cn
Subject: Re: [PATCH] docs: trace: Convert decode_msr.py print syntax to
 python3
Message-ID: <ZJhV0lQw59czLEGl@tassilo>
References: <877crwrgo5.fsf@meer.lwn.net>
 <tencent_69EBD5683EE28741BE906B56C8E59D8AE906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_69EBD5683EE28741BE906B56C8E59D8AE906@qq.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 09:03:57AM +0800, Rong Tao wrote:
> Thanks for your reply, jon. How about i submit v2 to remove decode_msr.py
> totally?

Well only if you can explain how the MSR tracer should be used without
it?

Not sure I understand the whole discussion here.


-Andi
