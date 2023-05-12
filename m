Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251E67006E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjELLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjELLdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124C13C19;
        Fri, 12 May 2023 04:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9026559E;
        Fri, 12 May 2023 11:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8265C433D2;
        Fri, 12 May 2023 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683891177;
        bh=NF4txKZiBkvrVApJrpYj7ld5CZCPBALVeS88lb3HeD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTMg/lp4/cC0FYWvxlqnfF53oJsFogxtiNMYsEdkrjUQsQRhL6qYQW891Gc/V1dRE
         JxcIvPH4cMR2iACFFAUl7CSsmcjZrfq7Odoq6SoRAH5iE7OCM/dutcAy32ggyTCFJB
         XseIrDzraZ8z+JU6DGpSuSkv6hymXtPSAasMa84E=
Date:   Fri, 12 May 2023 20:32:50 +0900
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     zhangqiumiao <zhangqiumiao1@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: KASAN: soft lockup in paste_selection
Message-ID: <2023051248-captivity-primary-b3c6@gregkh>
References: <16846f8e017948dcba9bf32b75a770f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16846f8e017948dcba9bf32b75a770f0@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:28:26AM +0000, zhangqiumiao wrote:
> Hello,
> 
> We found the following issue using syzkaller on Linux v5.10.0.

5.10.0 is very old and obsolete and over 20 thousand patches old.
Please, if you are testing LTS kernels, use the latest one.

> A similar issue was found in function `paste_selection` before and
> I believe they are the same.
> (https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/)
> 
> Unfortunately, no one seems to be paying attention to this issue.

Do you have a proposed patch for this fix now that you have a way to
reproduce this?  Do you see this in real situations or only in
fault-injection systems running syzbot?

And can you reproduce this on 6.4-rc1?  Do you have a reproducer?

thanks,

greg k-h
