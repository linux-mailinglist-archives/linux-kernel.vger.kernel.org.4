Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB86ED467
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjDXSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:31:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601555FE8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:31:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682361065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FfybgEkdcRYCzLjq/rryZN29CQ38aZ6y7kl628n9gI=;
        b=KrnvKPs0g2vveS7wRKs8pb3guzuq8/Cx1wlXFLNKoZECVCD9ai2ij2P8jX4cyQutKLfvhc
        etPvDP093lzMeRfwaZE6oEhdOFot6v1YL9Z9nKyT6YXGvpJMzmFr62ntJD0CPUubawHyro
        q65r6mINKek5sHrnPU/RsDfsAFYyyNiXimp8+yEGI1v9BKq7Hob0h6DvICpIBsYdNMPRjE
        nJdfSCTPzWW3xinwmpqQdrO1rc5vQfxRYf5Q1zsLWyF3fOwBoqY88xO3FEo3C1xjhxXqmt
        WlBIkOf9k5UX+pU6i+U/CmYotI8neX+VAtwKusHdqZCxuo1mc8gISXrWa+9RcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682361065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FfybgEkdcRYCzLjq/rryZN29CQ38aZ6y7kl628n9gI=;
        b=Dt96BqQqGt6nWJ0SFfIQ9kyQ+bv4qCZ0HIWNfUTLPdQX/mLZtZmy6Z/FgyIrBTef+8guA+
        dkwgDiye6vXCgsBg==
To:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <875y9l16es.ffs@tglx>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <e4d1f832-d95e-02c9-ae7d-2aca48a45fb1@allwinnertech.com>
 <875y9l16es.ffs@tglx>
Date:   Mon, 24 Apr 2023 20:31:04 +0200
Message-ID: <87354p16af.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24 2023 at 20:28, Thomas Gleixner wrote:

Btw, does the patch fix your issue?

Thanks,

         tglx
