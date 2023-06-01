Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A84719A80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjFALGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjFALG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897212C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C90663FBA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B05C433D2;
        Thu,  1 Jun 2023 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685617585;
        bh=xAWlOEKN1rDDM9NQNl85QtvghXQz6N2ZHItmMtSPuOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuP67o+BcP3kiUwJ4sC02+q3wwn2buHaXm7Tc7J6jEtycJt9jfiUBemfqPASePWS1
         Hac8LA1f0ThGKtzAUjdqD3/qkbPiYKy7RjpEphqOyH6qsVxAhRfWKBGColHzIuAnQ1
         leFlDBnha2HfwUCSw2+TqRUm/ftDpWHFwtw5j534L96qDHgQcTA2BtQofyrATHm4Op
         iB4wAOf7Ie92BW7G76t0UK61BeWBPP7HimAIt894oiGPFiVvB/zuE6GRIy3W6YT825
         nQt8JANtsQZ2RboisUvWlM+5qC6HVWqmkQW21qSCW2+XkccBU0isa+I+J5YIS2Uk7C
         G5Lo/MqTAoifA==
Date:   Thu, 1 Jun 2023 13:06:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [patch 12/20] posix-timers: Document sys_clock_getoverrun()
Message-ID: <ZHh7ruSFBhTlWY9D@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.462051641@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.462051641@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:14PM +0200, Thomas Gleixner wrote:
> Document the syscall in detail and with coherent sentences.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
