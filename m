Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8946FC85E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjEIOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjEIOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:01:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBF83;
        Tue,  9 May 2023 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683640866; x=1715176866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EHKsvTdHCdNCK1HuRWa7ynsK0osfnVqDf2droaNtqyY=;
  b=H6+xzbeCK+V+hjeC9nQn+1efJZLJf+pJBOinOa9DV/TF4O2nyjBhBMtF
   4CHW5mx/Ya3RYKGKBPra8gN9Vv5cq6Fq1vCd81JgKQNQUT06nn+Dr4oVT
   pHYD9PHhQcT+RICSw1yr6i799MZotKp7xbV6W52nsOF5/uh108e60x3fZ
   DrYY33qq2angysAGVobCH3HfzigetaPRmDfZqtttAH3TpiTnuTXYpTbj3
   2OZrsIEbnJrk0OtJPXUZTpq+BLUVeQpDSMEUYH0Wch/Hn0i/F6v2zy8bO
   /YST4DiwXq7IYWEXxucet7vefwA8hzXPvr5jLoloHNnl4SqXwuBS5QujD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="352997100"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="352997100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 07:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="768503018"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="768503018"
Received: from dcourtn1-desk1.amr.corp.intel.com (HELO [10.212.182.218]) ([10.212.182.218])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 07:01:03 -0700
Message-ID: <af88a590-e20a-0669-c0d8-e073cc6e109f@intel.com>
Date:   Tue, 9 May 2023 07:01:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pjones@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZFnoXiZGGhuWDl2S@Red>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZFnoXiZGGhuWDl2S@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 23:29, Corentin Labbe wrote:
> The tablet has only one port, so I use a hub for keyboard and USB key.
> Immediatly after booting Linux, all hub port light goes to off.

If it's dying in the installer, can you boot it to a shell or rescue
media?  Are you getting any kernel messages on the screen before the
installer?

