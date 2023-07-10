Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB574DABD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGJQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGJQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:07:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326DBC;
        Mon, 10 Jul 2023 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689005220; x=1720541220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VwIObvOTKqxbNBRZrEsj+7UUcplfeAejBxc/TzaG/mc=;
  b=S3MkCXL6pSlmyLjwI6I//UO7KsLcQufRNE9Hv/xvn/xFJfNwPfsIVV7F
   jboSdheL+3E2ML8LayBJhQXw8ziuOblq7Ueiq9dxVZwAQNJXsfBAFQC7s
   KSVdgDJxd+LNOc4sBJ+xlXoGJHLQBHhDnENtVeSyhKl6adq0oj+Db0W+v
   DCnBo9RqGoP3UNBQ7HawvK6tGyp/ksFpkXDtrLmN+6JbO2YgToCttlPeL
   gs1EObFpnFm/GriAayW9e7fz9iE6d4TnYSa2nH0dfsB+8hlBt1PWF+eRs
   rv5Z9UroThr13KTjbtct/j0WgvmYAE7U5ASLhp+vSZO2TpiulQ63ctCm4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344709355"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344709355"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="786240981"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="786240981"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:06:43 -0700
Message-ID: <e131af56-cd6e-a78d-ac2b-344107d8bee6@intel.com>
Date:   Mon, 10 Jul 2023 19:06:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V8 00/23] Add support UHS-II for GL9755
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <CAK00qKDgViDf=i5F2NNKBWO6HEeFtDcTQWSVbpLVFMkfKKi+1g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKDgViDf=i5F2NNKBWO6HEeFtDcTQWSVbpLVFMkfKKi+1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/23 13:24, Victor Shih wrote:
> Hi, Ulf and Adrian
> 
> Excuse me, may I know the patch's status?

SDHCI patches are good - just a small number of cosmetic
changes that could be made.

