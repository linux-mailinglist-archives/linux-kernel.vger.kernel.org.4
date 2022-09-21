Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5305C046B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiIUQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiIUQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:39:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3E9F184;
        Wed, 21 Sep 2022 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663777584; x=1695313584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P+S1fZO2WkNxVKu8FZnNMDSE/3I+MDIv2i/NsqPOwNg=;
  b=jzymwPfbm7qgr/WLMdZgujzR3OhgZKi+kR2ZyDENGZzT6teVKi1y4682
   g1RtcyqaFne6EO56Ph9fEcf2LhH0icWh7txdCjONSq7ZQd+C8u80jZ7no
   H7vqLpKj0nbxGH8VTm0S7oiFM5vibTpZfE5CzSVKypc/SW67s9K89YJhX
   lNHlfV2OupWHrCDOxB0+zhUhOSY023/NovO8zttn7JVJM9JxK0XMq78Gn
   on3x2cMT4D/hrdD1eIuXDWEQ6/2fkhAoAvSOSe/7x3mMb9xFVwq6ZF2js
   Y8BTUN7U6JQTMvL4EIWgoUEycj+LxaLBI2a+hIsoOK2x1bKBAB+loqXfl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297652936"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="297652936"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 09:26:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="708519972"
Received: from nchaplot-mobl1.amr.corp.intel.com (HELO [10.209.89.231]) ([10.209.89.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 09:26:23 -0700
Message-ID: <878e55f8-be4b-78bd-e1cb-5fbf674f6a02@intel.com>
Date:   Wed, 21 Sep 2022 09:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 4/8] x86/topology: Fix multiple packages shown on a
 single-package system
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com
References: <20220816051633.17775-1-rui.zhang@intel.com>
 <20220816051633.17775-5-rui.zhang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220816051633.17775-5-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 22:16, Zhang Rui wrote:
> Suggested-and-reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

"Please do not use combined tags, e.g. Reported-and-tested-by, as they
just complicate automated extraction of tags."

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
