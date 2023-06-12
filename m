Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514672B8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjFLHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjFLHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:45:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F4135
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:44:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686555780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DiAnLIiUBYXaguUIy03BSnkoDkgFyfGxUR0k1sms9NE=;
        b=qcEWZY0y09KDrSdYwgdNe0WiYynOfnfwsdasV4hTPglnG+Wzm2/dL7reBEWt5TVLZ798lu
        zu32SV4XsNbaQR0YVJkFEqtOpyvaGBTvA2uQmHy5m9r7q79aZokdESSCZ6VRMeiUGJl+59
        VOrF3berSK4QDJACwpxEZ+ukpflAM9u0GM5n339xLJeHbxXOpc6PwO4eKnrGwpCdtV8qNh
        SvgH5E5aSdemfZ7H55ygSKeUG2mj0IlyNIvmJiGqEPTtK75l1t24KfLhFWEPTB4khvfY+A
        KTL6+FSJGz8dhFCkQnWExB+/0WaN6NYH13/n8U0LnsQIBHy6VG4Bjy43j8EGYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686555780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DiAnLIiUBYXaguUIy03BSnkoDkgFyfGxUR0k1sms9NE=;
        b=LvUwJ79Dm8d2aBXh/UQeqx6cTJWr7+h08SmAhE7sSVOaH9gwdCkuO7xwaV4YziKJbo9Qq/
        VSGmfyW3xi/ODwBw==
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: clocksource: remove unnecessary (void*) conversions
In-Reply-To: <20230613193919.3439-1-zeming@nfschina.com>
References: <20230613193919.3439-1-zeming@nfschina.com>
Date:   Mon, 12 Jun 2023 09:43:00 +0200
Message-ID: <87r0qh6s8r.ffs@tglx>
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

On Wed, Jun 14 2023 at 03:39, Li zeming wrote:
> Pointer variables of void * type do not require type cast.

Neither the subject nor this sentence make sense. I fixed that up for you on your
previous patch:

  https://lore.kernel.org/all/168640113003.404.3362295823712498263.tip-bot2@tip-bot2/

Thanks.

        tglx


