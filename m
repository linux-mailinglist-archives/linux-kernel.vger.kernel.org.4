Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEE60FF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ0RaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiJ0R35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:29:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF003C8D8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C73B82726
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3BC433D6;
        Thu, 27 Oct 2022 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666891792;
        bh=AGsC0hjTQr8VlagabTIS0/mrR7vHEhqZGJ5Iuwauy0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAxYN5zuqnatKL6hbYPimiFFMnN3t1QEhBFfjLa5sDzmjRPNBH3ugEVTAp8FDAlJh
         1H0SdjqZLVFC0ZE9Q9lZbeWwi+2Hc7gMOuOJm6lbCUcJD45NSXLGOp+Jjs0UtZ1HOR
         4mGYn9+NFbFxzMs58DTTv3QMQRl0goZY516D9gcw60HcnhuOgO+8V7EnzJQIjJkHA1
         Yhwd7bHCyfMo7l3cIpoC5C+eVYDV2EayJVQ1g25fCMMwrO66pUUhBgSdxTmgZUFvwM
         bH33bchDuk5n1gacRca72wf21n4oqs39kLrDwyVUZmTrmKVrhyPMj0RNdbNdTaYy3F
         hw+zW4WSbDw7g==
Date:   Thu, 27 Oct 2022 10:29:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: fix return val in f2fs_start_ckpt_thread()
Message-ID: <Y1rADqN9gFjfL/AX@google.com>
References: <20221027102447.75708-1-frank.li@vivo.com>
 <20221027102447.75708-2-frank.li@vivo.com>
 <db6d8470-47f5-39e4-a692-efdc16603144@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6d8470-47f5-39e4-a692-efdc16603144@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I integrated two patches into single one. I think we don't need Fixes.

On 10/27, Chao Yu wrote:
> On 2022/10/27 18:24, Yangtao Li wrote:
> > Return PTR_ERR(cprc->f2fs_issue_ckpt) instead of -ENOMEM;
> > 
> 
> Fixes line?
> 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
