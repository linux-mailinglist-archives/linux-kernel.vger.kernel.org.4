Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806FD6B272F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCIOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCIOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:42:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B712200B;
        Thu,  9 Mar 2023 06:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FA6AB81E67;
        Thu,  9 Mar 2023 14:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99BCC433D2;
        Thu,  9 Mar 2023 14:42:02 +0000 (UTC)
Date:   Thu, 9 Mar 2023 15:42:00 +0100
From:   Greg KH <greg@kroah.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
Message-ID: <ZAnwONGXWo5V6Wac@kroah.com>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 02:04:44PM +0100, Thorsten Leemhuis wrote:
> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes. This is a huge and frightening task for quite a few
> users these days, as many rely on pre-compiled kernels and have never
> built their own. They find help on quite a few websites explaining the
> process in various ways, but those howtos often omit important details
> or make things too hard for the 'quickly build just for testing' case
> that 'localmodconfig' is really useful for. Hence give users something
> at hand to guide them, as that makes it easier for them to help with
> testing, debugging, and fixing the kernel.
> 
> To keep the complexity at bay, the document explicitly focuses on how to
> compile the kernel on commodity distributions running on commodity
> hardware. People that deal with less common distributions or hardware
> will often know their way around already anyway.
> 
> The text describes a few oddities of Arch and Debian that were found by
> the author and a few volunteers that tested the described procedure.
> There are likely more such quirks that need to be covered as well as a
> few things the author will have missed -- but one has to start
> somewhere.
> 
> The document heavily uses anchors and links to them, which makes things
> slightly harder to read in the source form. But the intended target
> audience is way more likely to read rendered versions of this text on
> pages like docs.kernel.org anyway -- and there those anchors and links
> allow easy jumps to the reference section and back, which makes the
> document a lot easier to work with for the intended target audience.
> 
> Aspects relevant for bisection were left out on purpose, as that is a
> related, but in the end different use case. The rough plan is to have a
> second document with a similar style to cover bisection. The idea is to
> reuse a few bits from this document and link quite often to entries in
> the reference section with the help of the anchors in this text.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
