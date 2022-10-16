Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435876003DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJPWOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:13:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004A303DA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 15:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36CB5B80D4E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83087C433D6;
        Sun, 16 Oct 2022 22:13:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hdBMSLBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665958432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4WR4xhXzwlwqvT/KGfQI7zt3I0CyIlPGf1HtC8vbuak=;
        b=hdBMSLBSsBZRL39EgOeblE/qJHrbDGEwcPPJeu+8xBHh4ByuykSUZQ6YKzSMccP4NjtjXm
        mZOVxg1xJ+JuJA7dFs5sF/y8JfH6t+KJnqGEo4Cv0LPx8MbtyQakyFc+AN1V06NSqbttuv
        +UzPcjxNUXDa7P6Y5rsD6HL8HJs/598=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 96b210d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 16 Oct 2022 22:13:52 +0000 (UTC)
Date:   Mon, 17 Oct 2022 00:13:50 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1, part 2
Message-ID: <Y0yCHs0m/pXlF5EM@zx2c4.com>
References: <20221013005845.1325870-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013005845.1325870-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's late in the afternoon on rc1-day, and I noticed you already pushed
the usual Sunday last minute patches up. I assume that, given this has
some treewides in it, you were waiting until the last possible moment to
merge it. But on the off chance it just slipped through the cracks,
here's a pull.

Jason
