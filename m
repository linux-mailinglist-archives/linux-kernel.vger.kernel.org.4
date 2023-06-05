Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0A723340
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjFEWeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjFEWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57693131
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B52614DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BEFC433EF;
        Mon,  5 Jun 2023 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686004435;
        bh=Tqjwije9sLgBSKVPubakZQef4W29AG6vJdvRbwzWZFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u4UpGwVAXBNmNOBdzFx2eOpybeXThMuPcjcEDpb2NvlXw2cu+FC/OTJCsZx330ANA
         ltRzzkE8ui5JByaYoCTzdMFV2PZrrWvNUkDpDh0jha8XpttHWzXWT+ePGhofCUdKE3
         Q5lNLMwhAfF3Xd8bBszufYjvzh3itiXD8/PnET6xVflb5MpRr5Yd+XuaEpAfCYDUq7
         sv8v1Ybbgh6I9s7CICIIx/xVvdL73k+fhMTh1xmVjNkwzhuOTbVbkWbV20yCUgSOPr
         tR5qNAtb+o0ibrLWy8YExtafobLRv8gypF8PNeyJwJkdgbWz+BKVhUl6/B/abzxxAZ
         B3YTRXdsObNzg==
Date:   Mon, 5 Jun 2023 15:33:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        netdev@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v9 0/4] drm/i915: use ref_tracker library for tracking
 wakerefs
Message-ID: <20230605153353.029a57ce@kernel.org>
In-Reply-To: <20230224-track_gt-v9-0-5b47a33f55d1@intel.com>
References: <20230224-track_gt-v9-0-5b47a33f55d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 12:21:32 +0200 Andrzej Hajda wrote:
> This is reviewed series of ref_tracker patches, ready to merge
> via network tree, rebased on net-next/main.
> i915 patches will be merged later via intel-gfx tree.

FWIW I'll try to merge these on top of the -rc4 tag so
with a bit of luck you should be able to cross merge cleanly
into another -next tree.
