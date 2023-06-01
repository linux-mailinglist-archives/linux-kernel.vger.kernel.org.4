Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD9719ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjFANvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFANu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94D13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDC961D26
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33C6C433D2;
        Thu,  1 Jun 2023 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685627457;
        bh=QDREphHBo51X50wE5o8pzIgRS3f8BuMKRWUde2DjW/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tI9dAIBOkyh53Pd7Lrsbu+8gZEn8/8NByafE17qrEJIVLLFmE06XS0BToWU8CUQDK
         nq/HufrcLUhI3AV7B8aLFYrAEskgu20o/fTF18xEf8wi2lDZq+W5X3eAtnZcz5vzM8
         n+xTeCNvsuY+uRFYoAt0+kK2DjdNGeFq9H+qW23KWHVQJgOQ7JNByZxt/xilx1qvae
         fLb2vYkzlEpjL15T5Yq2Y0UqnKL7chp5R6DWEfARSz7elsYpZAhrNtPiCD4LUsNEft
         ioh1ZlowX7Npe5SIP/StKgxYOsgi36nzt3yFMLxYhUl9ZU4+3ogjEX6ATAfIlwnAOK
         J3+4wQLdXYkHA==
Date:   Thu, 1 Jun 2023 15:50:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 20/20] posix-timers: Polish coding style in a few places
Message-ID: <ZHiiPjaEErr+wcu1@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.888493625@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.888493625@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:27PM +0200, Thomas Gleixner wrote:
> Make it consistent with the TIP tree documentation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
