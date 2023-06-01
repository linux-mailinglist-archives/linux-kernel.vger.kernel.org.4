Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C949B719EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjFANs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFANsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA895
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A68761044
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A556AC433EF;
        Thu,  1 Jun 2023 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685627303;
        bh=AV0vGPyjz4LgJTCJd45uL+xlJ7ZhyU6MkmwXg1uEI9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH4zYYnC5dGfw2dwJVg3+49CxtjvN2XhcCYyAjpvpo8PqMyUgsgFpp1eL7S0ENfgc
         fizooN1NH1iJxDxVK9OmJlCFNUuQ2zPdPcOzCiSSuDu8L1Giz7qHsBYfFi+uWrFAtS
         uISvWZvmLy+efZnnlEXsJl3g4hZjkh3hY3sSPMGeATRnMACbJ0Jbwm3GyC3mLNzu5i
         3g7RmNwDtD1nJ3yBNIOShYwkj6fYEg3X/2IVQxDxuM1Hvye36I5KuRjegI2ypBGUJ6
         V1uIc86FoxR06j2qxMB4QV/vZnsC4Qdmw2EpJabSl7wpxo4CN42px/213ciNicz8Ir
         +9oA1THccRJVw==
Date:   Thu, 1 Jun 2023 15:48:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 19/20] posix-timers: Remove pointless comments
Message-ID: <ZHihpLMWLnXtl2cy@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.832240451@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.832240451@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:25PM +0200, Thomas Gleixner wrote:
> Documenting the obvious is just consuming space for no value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
