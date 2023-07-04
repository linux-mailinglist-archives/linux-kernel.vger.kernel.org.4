Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF1746E34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDKCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGDKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD8E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6EB6113E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6814DC433C7;
        Tue,  4 Jul 2023 10:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688464956;
        bh=g+37I2Inh9XnVZNZIJsfCQugjk/wFyNtA25X1x/ceME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quby+ZdYNO0n30DwlqDwvvaLg4+92nEZBGUGvssfGvMGEqiiQIzdohC1ib9s+sPI0
         863WyMHxxXTkOaMdOtFGrS3NP2HJLkNcEf7F5tMkBaPcOgUXWNTaqzkHp5URxcUWcZ
         3bVAaUXeFnNzAMbb/ww3gfJWfF+4Gkk6r923oXrZwYVj6YSwXm/fbiszmogdSRuyb5
         vtqqI51Bqb8A0NUvp4qrnENTIutbmUTMGTR+CbpOEPprFFkU2Pt2wM//92kryQuKsG
         WIgv3zIPN3QqElb0zvUAbOZkYU66NalMdEJGD1X8m2PLRkJZT1lKl1VJk5sdBjHx2t
         axXortRk8acGg==
Date:   Tue, 4 Jul 2023 12:02:33 +0200
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
Subject: Re: [patch 19/45] signal: Remove task argument from dequeue_signal()
Message-ID: <ZKPuOTqU8c4f5HsE@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142032.095893220@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142032.095893220@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:48PM +0200, Thomas Gleixner wrote:
> The task pointer which is handed to dequeue_signal() is always current. The
> argument along with the first comment about signalfd in that function is
> confusing at best. Remove it and use current internally.
> 
> Update the stale comment for dequeue_signal() while at it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
