Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7716F84D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEEO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjEEO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0E1FE7;
        Fri,  5 May 2023 07:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E8A363E7D;
        Fri,  5 May 2023 14:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E897FC433EF;
        Fri,  5 May 2023 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683296912;
        bh=aRLeerLndjGyuIZ+tMj/S2QANE3R8KUtezWRPAvSRUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WemVywAPBbLQDwL5sRbh21zIgaNUiIO8zY5uD9wMCTQjKhcoTl1KCG4zWaOPsecEp
         xzn2AWL+r6fIGQgXyioXcwlQ1wfcWozzCBQoXA94SHNsIAvAOmf60nmopMR4cVUyRS
         cw8nG846Wewv8Ux6dMaHR2UzYumbPYqRzysA9VhexnxFApUX9XthKP2P189U7tXfuo
         sHOxZ300jYVvqMR8sbAuCaLO80CV1YAXL9+u53QJqiQdfcYSd0FUDiOr/leWHtL/N2
         UJjOaqXeMthUPEMNoxzusD14dcookbbSBctpCZk+VJE+z1JGJUokVO+qQLT4f0zX3B
         ZAxYr6/aaadIA==
Date:   Fri, 5 May 2023 08:28:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
Message-ID: <ZFUSjXJlXP5M2KQY@kbusch-mbp.dhcp.thefacebook.com>
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
 <ZFOLdr2CssE4O7+L@x1-carbon>
 <20230504191022.bc06f36a432dea7df74cc554@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504191022.bc06f36a432dea7df74cc554@linux-foundation.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 07:10:22PM -0700, Andrew Morton wrote:
> Please check that all is as expected.

Thanks for the quick turn-around. This looks correct and passes my
sanity tests.
