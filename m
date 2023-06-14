Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A872F769
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbjFNIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjFNIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:08:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530701FCC;
        Wed, 14 Jun 2023 01:08:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B59988027;
        Wed, 14 Jun 2023 08:07:41 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:07:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ARM: OMAP2+: Fix -Warray-bounds warning in
 _pwrdm_state_switch()
Message-ID: <20230614080740.GH14287@atomide.com>
References: <ZIFVGwImU3kpaGeH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFVGwImU3kpaGeH@work>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gustavo A. R. Silva <gustavoars@kernel.org> [230608 07:11]:
> If function pwrdm_read_prev_pwrst() returns -EINVAL, we will end
> up accessing array pwrdm->state_counter through negative index
> -22. This is wrong and the compiler is legitimately warning us
> about this potential problem.
> 
> Fix this by sanity checking the value stored in variable _prev_
> before accessing array pwrdm->state_counter.
> 
> Address the following -Warray-bounds warning:
> arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]

Thanks applying into omap-for-v6.5/cleanup, seems this can wait
for the merge window.

Regards,

Tony
