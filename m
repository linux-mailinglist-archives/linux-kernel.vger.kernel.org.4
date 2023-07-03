Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC0745F67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGCPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F327BC;
        Mon,  3 Jul 2023 08:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F165960F8C;
        Mon,  3 Jul 2023 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2816C433C8;
        Mon,  3 Jul 2023 15:05:37 +0000 (UTC)
Date:   Mon, 3 Jul 2023 16:05:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>,
        Qun-wei Lin <Qun-wei.Lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Casper Li <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
Message-ID: <ZKLjwjYUM2zSRtJ5@arm.com>
References: <20230523004312.1807357-1-pcc@google.com>
 <20230523004312.1807357-2-pcc@google.com>
 <20230605140554.GC21212@willie-the-truck>
 <CAMn1gO4k=rg96GVsPW6Aaz12c7hS0TYcgVR7y38x7pUsbfwg5A@mail.gmail.com>
 <ZJ1VersqnJcMXMyi@arm.com>
 <20230702123821.04e64ea2c04dd0fdc947bda3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702123821.04e64ea2c04dd0fdc947bda3@linux-foundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 12:38:21PM -0700, Andrew Morton wrote:
> On Thu, 29 Jun 2023 10:57:14 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Andrew, what's your preference for this series? I'd like at least the
> > first patch to go into 6.5 as a fix. The second patch seems to be fairly
> > low risk and I'm happy for the third arm64 patch/cleanup to go in
> > 6.5-rc1 (but it depends on the second patch). If you prefer, I can pick
> > them up and send a pull request to Linus next week before -rc1.
> > Otherwise you (or I) can queue the first patch and leave the other two
> > for 6.6.
> 
> Thanks.  I queued [1/3] for 6.5-rcX with a cc:stable.  And I queued
> [2/3] and [3/3] for 6.6-rc1.
> 
> If you wish to grab any/all of these then please do so - Stephen
> will tell us of the duplicate and I'll drop the mm-git copy.

That's great, thanks. We'll let you know if there are any conflicts
during the 6.6 preparation.

-- 
Catalin
