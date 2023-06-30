Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315917443FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjF3VkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjF3VkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB835BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5811E617C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E0C433C8;
        Fri, 30 Jun 2023 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688161210;
        bh=AVfeEEw/9l8iHemGPki+SVP2PZfyPzPov9oCeqyc7EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ka/cWZL+fibT3Q51nBqqqi1J6EHVEMxb/pTwbSjz1xyAxseAHUEyjT5vfVBhgV2KO
         2AgzTdrxkRfnupLkj7T/XTtoVtKNJ31sRoNBGkyDWWRzO/lrI/h0cx4QZO5wxPVgkL
         jv5PRDFABZZ3MkstbrV/ZY18bvR/Aw6YAp+iGRH898Ia/En/DXwDYWCwXPb9+H8vrX
         rYKTkP+TXYf51WdOnD+9Rd+6KpBGlQ8EYdk3lAiI8xFRHueXm4wwlNci2K4WO82IJw
         fG91d1K4+lNDNQj0I+AzykL/hUtGMP14A2Yinj0/SBU02WaFkw9dEfF4Jhqr16fBwk
         I+pKPQHjtrMoQ==
Date:   Fri, 30 Jun 2023 23:40:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 15/45] posix-timers: Clear overrun in common_timer_set()
Message-ID: <ZJ9Lt4Jqr-6mOudl@localhost.localdomain>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.872478114@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606142031.872478114@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 06, 2023 at 04:37:42PM +0200, Thomas Gleixner a écrit :
> Keeping the overrun count of the previous setup around is just wrong. The
> new setting has nothing to do with the previous one and has to start from a
> clean slate.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
