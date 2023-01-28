Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9567F82C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjA1Nj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjA1Njv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:39:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22739CFD
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABE08B8015B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB10C433EF;
        Sat, 28 Jan 2023 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674913188;
        bh=x+XPnNrnuwKcYEao81s6jVrH51ZwvEQ3aiNlN2uvP3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY/KFUcihQWtl+8ikv/bmxp0HkcvV9gl5j5O6O8EH1FtqeIhcATR1fMpvY5iBZ1du
         E+yNgf1bnEq4J9Z6o+XWDzpoPux6pG9OhwYdq0/ohaaMHfMIUwOt1mu9VVbSo4KFh/
         cJfvNrS+54XebkJXHYnMOwh1Ta2tveut8V0eogD8=
Date:   Sat, 28 Jan 2023 14:39:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] nvmem: fixes for 6.2
Message-ID: <Y9Ulm3So08Fg308w@kroah.com>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:40:05AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some nvmem core fixes around nvmem provider device register
> and error paths.
> Most of these patches have been in next for 2-3 weeks.
> 
> Am really not sure if you are taking fixes late in this cycle.
> In case you are not could you please apply them for 6.3

When I apply them, I get the following errors from the scripts:

Commit: 36f5dbea16ad ("nvmem: core: fix return value")
	Fixes tag: Fixes: 60c8b4aebd8e ("nvmem: core: fix cleanup after dev_set_name()")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 7de8892c0527 ("nvmem: core: fix device node refcounting")
	Fixes tag: Fixes: 69aba7948cbe("nvmem: Add a simple NVMEM framework for consumers")
	Has these problem(s):
		- missing space between the SHA1 and the subject

The first one is because you have your own git tree, that's fine.  But the
second one should have given you an error when it was in linux-next, what
happened?

Let me see if I can fix this up...

greg k-h
