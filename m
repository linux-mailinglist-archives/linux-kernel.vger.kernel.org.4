Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFD5FF2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJNRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJNRMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:12:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45259727;
        Fri, 14 Oct 2022 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767569; x=1697303569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blL2GC3Mi5CfVsUI46WjXtXVD+aHyOwcn1x6p0aKgGg=;
  b=GnA0hhSWd2N1ROwZfTtFnMJEn25F3emtxEoAyQoFBICFxeimVZHlutQ7
   6psVrHC0Kw6SS74NvfuHB3XuTGi3xntglAJqjeb1X6KqnYhW/M81YxUED
   nYDkcJXT5HLU3pKiNf1W6lTqep1Am+vifovk6W0aTWT39fST3a3L8zbkL
   aSv/vWaptLqmcmt5q0tsfWAn+HnDY2tAEjaBUC3I0ssZ5WOfZh/BAZ/a0
   QCktCAM8CslE4RFO5ClkmGumrQq9foPAjtQnB0kELIwrnNtUuWwgts5Qo
   Gdt6UKhJUnLFx02aJgra9fhJD+Vp5MSGM+CYSZNXglkQkuWf5MYZ41SDg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369623263"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="369623263"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:12:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716823179"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="716823179"
Received: from atabbass-mobl.amr.corp.intel.com (HELO [10.212.48.152]) ([10.212.48.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:12:45 -0700
Message-ID: <ad558e83-3e42-aefd-754d-e71f49dda206@intel.com>
Date:   Fri, 14 Oct 2022 10:12:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 1/4] hwmon/coretemp: Rename indx to index
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
References: <20221014090147.1836-1-rui.zhang@intel.com>
 <20221014090147.1836-2-rui.zhang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221014090147.1836-2-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 02:01, Zhang Rui wrote:
> Use variable name 'index' instead of 'indx' for the index in the
> core_data[] array.
> 
> No functional change expected.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Hi,

Thanks for paring this series down.

I think I'm also going to pull this patch out of the series before I
apply it and just rework 2/4 to apply cleanly without it.  I just can't
put this in our "urgent" fixes pile and keep the stable@ tag on such a
trivial rename and keep a straight face.

