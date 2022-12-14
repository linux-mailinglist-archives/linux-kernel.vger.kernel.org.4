Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4164C98D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiLNNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiLNNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:00:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED6656C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4751CB818B6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A991C43396;
        Wed, 14 Dec 2022 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671022842;
        bh=POT7ff21J0hjrhDir02ZLiDMjcG6kodQY8QRBTFQv8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv841yBJ6H9naJe1+vSQTOP7hlp7NAl7HnSToSASDL0Jcz11uhVw/GOpGJdwyNhE6
         XyxetkugZd/ASmUbs3jORP5OS7SfxRaIpfpyqHwC4vA0FvMk7woC52Ch55Lj6k/BuB
         qnwitZbvfFfCK/F5hyLmbHQu5Q+yWUXqMoV8iWYm88MuV2QFKqu7YtTfWzRip4f3uX
         hmRuqo+0jh/ftgIv3pVhTgK19a8IBehOEYSN9ZJl2AwnuPLImD7kiBHyFfFPYa3RXQ
         KoRVpdoxlE1PSfplN3IBReUi03BPJUfm/gYBkAF1qLeqBv3rZehwwH7T1KnQvNKQmt
         LJwz32y0myfdw==
Date:   Wed, 14 Dec 2022 14:00:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 4/5] tick/nohz_full: Ensure quiet_vmstat() is called
 on exit to user-mode when the idle tick is stopped
Message-ID: <20221214130040.GC1930067@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.509808578@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162416.509808578@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:18:30PM -0300, Marcelo Tosatti wrote:
> From: Aaron Tomlin <atomlin@redhat.com>
> 
> This patch ensures CPU-specific vmstat differentials do not remain
> when the scheduling-tick is stopped and before exiting to user-mode
> in the context of nohz_full only.

Please also don't forget to mention why this change is needed.

Thanks.
