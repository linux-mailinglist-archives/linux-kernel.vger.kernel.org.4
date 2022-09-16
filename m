Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808965BB355
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIPUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIPUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D524BA14C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF53162D4C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 20:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D3BC433C1;
        Fri, 16 Sep 2022 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663359249;
        bh=4OYS501qpiQgbj9HkOgfmozfNj5LVm058gc+F6rGESs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHUGJRHszjn4wilVwprmGZlqJZYFiTZViXofUijD/EPSQ6tZwBdV6HFy2v5JpoRtX
         DssCC8oVyep+uKd7OLuLzl+6yKqab17yPfJlKLmdaDD6boJlXBH4mJyzuqp2ElEjQA
         Ar5nDbP8oUqMtFX3qRieIpSwKrwbVkpnDWYfyZQI=
Date:   Fri, 16 Sep 2022 13:14:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yangyicong@hisilicon.com>,
        <viro@zeniv.linux.org.uk>, <jonnyc@amazon.com>,
        <hhhawa@amazon.com>, <andriy.shevchenko@intel.com>
Subject: Re: + libfs-fix-error-format-in-simple_attr_write.patch added to
 mm-nonmm-unstable branch
Message-Id: <20220916131408.f86352344027e77056c894ee@linux-foundation.org>
In-Reply-To: <ce553e2b-0a13-08ee-283c-bc749e41ca61@amazon.com>
References: <20220915213426.3BC15C433D6@smtp.kernel.org>
        <YyQTmZG/tNWd/ErO@localhost.localdomain>
        <ce553e2b-0a13-08ee-283c-bc749e41ca61@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 14:19:29 +0300 "Farber, Eliav" <farbere@amazon.com> wrote:

> Should I still revert the original patch as is, or send a new patch that
> fixes the issue by using kstrtoll()?

That sounds better.
