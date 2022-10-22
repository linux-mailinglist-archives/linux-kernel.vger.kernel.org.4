Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92C5608ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJVJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiJVJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E15108DCE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9153860B49
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CA4C433C1;
        Sat, 22 Oct 2022 08:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426654;
        bh=z4L3/xqSCV2K+C5GIeeIyFqzJyigHhSodzy2OE9hNEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scIuEuHGtr9qqEV6GCawIaX9Nava8adi6RASKh1Tuyo2Au7fNt+O2UxcIBN8bN384
         t5iFBDBRpLxjuMH665qtFZtdCdBnjvYhspq3uJEzxd5zw6Ppl9eE8JKowqTdNlQQog
         o4pegTBb5PP8QANNK8LZcA/STt59GsUZKT0v47ag=
Date:   Sat, 22 Oct 2022 10:07:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emily Peri <eperi1024@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] clean up driver code in rtw_ioctl_set
Message-ID: <Y1OkzrA5Z9u8llPN@kroah.com>
References: <cover.1666380274.git.eperi1024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666380274.git.eperi1024@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:54:54PM -0700, Emily Peri wrote:
> Created patchset to fix all checkpatch warnings in rtw_ioctl_set
> 
> Changes since v1:

In the future, please use the proper prefix ("staging: rtl8723bs:" in
this case) for your 0/X emails.

thanks,

greg k-h
