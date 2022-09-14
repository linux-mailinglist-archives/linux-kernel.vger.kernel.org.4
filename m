Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85C75B8833
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiINMZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiINMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:25:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CC28714;
        Wed, 14 Sep 2022 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663158347; x=1694694347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ORuF9D4Y/8G7urH0ILcZTwbi7f6D7KyK4hVaHWMMUY=;
  b=Nv/I8lGr4oEwA90Fc7Fwh7KssskLn28w/3NMiSJ0CeKWBlK5PTepcF+e
   XxR9BuT+gJcYf0tuTkUnu2KIMGaBwGSRBQVaxWiDsycIVBC3kq4dvaThJ
   akPUPQDNxz1n3qcJcueLSJPJZH+57V2r1la+aukoUIL/VlGiDkYUHiUQi
   ET2UMrZCOsrQG4HrGGh+d1HqT0ZVKUwI2Nz1noUctn5zmYHO/UMiPNWsn
   w34kq/+5AydPmgNW+TArwQifo3AWNKePmGfLhJZ+Za/aYuuiA4ftylc1y
   f5cekRmI5CIAmLqN/EEDpn7drKY4UIwvZXg62GIE4OyByK0AsELOuNq/I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278142957"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278142957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679023166"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2022 05:25:46 -0700
Message-ID: <07f71b65-b900-62e2-6550-ae89708c9294@linux.intel.com>
Date:   Wed, 14 Sep 2022 15:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] xhci: dbc: Fix memory leak in xhci_alloc_dbc()
Content-Language: en-US
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914023609.695296-1-rafaelmendsr@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20220914023609.695296-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.9.2022 5.36, Rafael Mendonca wrote:
> If DbC is already in use, then the allocated memory for the xhci_dbc struct
> doesn't get freed before returning NULL, which leads to a memleak.
> 
> Fixes: 534675942e90 ("xhci: dbc: refactor xhci_dbc_init()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Thanks, nice catch

Adding to queue

-Mathias
