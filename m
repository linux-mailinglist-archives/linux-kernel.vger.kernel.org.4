Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6975FF3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJNSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJNSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:41:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292651C77C1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE990B810EE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25ADC433D6;
        Fri, 14 Oct 2022 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665772882;
        bh=m3HaRT4Am8hiRILJCA1BmK39Zfen9jQhjt24Wl83ADg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kK+Y7Fkc2B0IlmR6GHKMpQX9PjJicT4YxghIJDDddyVv7yOlYX98IdCct89YQbwER
         LEJ/hCd5KCyTWn9lVt7z7zNmQaHGlMpix8gMsWjGXIoMm39PdlVpuGjVxQtmTWn3BQ
         ogubK4BE5FrJNjbsuozm+SJ8L1lHCWjLLJKVGisUALyv4GFD1RylJdrz0oluYoMLLu
         0pTIJNo5i7/MhcpWvjX+KIEd3WRXY4TGCCBX9qunAe6pqdaFNtZerkgc+ZFoBH7mfF
         Yu6I3ah5Fowq0B+aNg5WewpCJG6revmYR11iRIZZrvst4vsN84RB+ZcMiArik5qmmc
         MagDOXW/o/ECA==
Date:   Fri, 14 Oct 2022 13:41:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221014184120.GA3395472@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:06:43PM +0200, Geert Uytterhoeven wrote:
> On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Konstantin: I believe there is a bug in the sending procedure [3]:
> 
>     tar cf full-archives.tar dir-with-mbox-files
> 
> I guess that should be
> 
>     tar cf full-archives.tar ~/linux-kernel-announce
> 
> instead?

While you're looking at typos, there's a "list-archive-marker.py" in
the last section [4] that I think should be "list-archive-maker.py".

> [3] https://korg.docs.kernel.org/lore.html#send-the-archive-to-helpdesk

[4] https://korg.docs.kernel.org/lore.html#can-we-use-mailman-archives
