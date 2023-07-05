Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15F747E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjGEH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:28:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ED197
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688542121; x=1720078121;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0p618NrMvXlLUkdTf7wXL09ewzLdrjFOssE4p7oP79U=;
  b=M2o9/2zO6L2FbXgknaFavFsePT+bdTUKu7OHPwAlq+3x7xdT3ZHI/m8Q
   FajXgb+g9t28MT58/j2mf/UMWpK7AfZXfhdwt2Byka9N1yszhZALTUDo4
   GeJdFWsUPOe9H2l6wlLgiDa9jRB7qjv++FijUxGeGJciz6ST9hAcVHEt6
   Jid9sbl3JKVtCQ1uT7w42pdR5hyqybkDKaZLKhw8gulFSz73TirTT3QlB
   IcsLQIHGDkQM3OFeneLSvq9P0IRf/Nzo7BOkW39gCT/jCWGElXfPrseN/
   9hg/OqepC2oOpre5aJWL1T5Stt5KzzHAPRWpn4EryGwUze+pZvc5iKVEV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="426954959"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="426954959"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 00:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="722304576"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="722304576"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.142.211])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 00:28:38 -0700
Date:   Wed, 5 Jul 2023 09:28:33 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     Christoph Hellwig <hch@lst.de>, andriy.shevchenko@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] misc: enclosure: remove get_active callback
Message-ID: <20230705092833.000040de@linux.intel.com>
In-Reply-To: <20230530143611.GA10069@lst.de>
References: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
        <20230530140223.13994-2-mariusz.tkaczyk@linux.intel.com>
        <20230530143611.GA10069@lst.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:36:11 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Arnd,
Gentle reminder. Could you please take a look?
When I can expect it to be merged?

I'm working on the NPEM extension to enclosure services which is based on those
changes.

Thanks,
Mariusz
