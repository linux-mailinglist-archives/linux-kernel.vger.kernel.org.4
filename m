Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E6624919
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKJSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKJSJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27563CFC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB60761DE3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AF3C433D6;
        Thu, 10 Nov 2022 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668103745;
        bh=u4Fz0YsPf83bjBO/+y2wo42yol4sXpWCZYxnY7kcC2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKxUbEXI6lDG7Y/WCP/zwB6HFfDMFVOTu2oXsoBE1i2oDHZGzGgCMhJ/PS+wRjxyX
         qkPmcBj16GHgzV78EYp/p3+uAQNk+5q8IuH8siruSxFKLt6uakiFxNuba6C67qcMia
         mjchfsNM1rnubXpEVA5FmzIzNTfskv5rPphrbDhU=
Date:   Thu, 10 Nov 2022 19:09:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 0/2] RESEND vmlinux.lds.h tweaks
Message-ID: <Y20+PqtF+dFAe7hX@kroah.com>
References: <20221022225637.1406715-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022225637.1406715-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 04:56:35PM -0600, Jim Cromie wrote:
> hi Greg,
> 
> this time w/o the stale patch 2.
> 
> These 2 patches are "no functional change", but they are a simple step
> towards de-duplicating the repetitive columms in the __dyndbg section.
> 
> For a DYNAMIC_DEBUG=y kernel with 5k pr_debugs/drm.debugs, the
> footprint reduction should be ~100 KiB

Cool stuff, let me add it to my tree and see what breaks!  :)

greg k-h
