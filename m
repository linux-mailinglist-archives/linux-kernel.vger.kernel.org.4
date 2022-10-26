Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1C60DE57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiJZJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiJZJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FF3E757;
        Wed, 26 Oct 2022 02:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DE761D96;
        Wed, 26 Oct 2022 09:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D658FC433D6;
        Wed, 26 Oct 2022 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666777230;
        bh=htdOOYurCJIZsVSaVVuVoWXOfQvlH6d2OhO+9vBnWRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hV3ukEHTFXCXwTzFHNIzZ3Bn02cNz6RC/gV/2KRvldzQQ40yyXKFd5zn5Ajyj0Aeb
         5vys5+neAd5iINvz1mr1zBd04UTTWHpfgK1AaXrRGzayYDiR/a/toWNQVJgeS7LMp/
         TV/AzznGO8upG423Ti6y0iHiO6cumZUZwFGTzsTSp9hwM45FttWIu12t6NcoNv5jmV
         Oekq0yIfu+R4JjtY7oZmk/TqJuaea173ur6PthPZwJu1Di9DsscTgmh5FDRuU0RI49
         KX3E74AFeyIV/vL/H3iJWXCk5nlVPKh6Lw0zVJHUKZAs3VAAN32Zhe0i+Ahx3Zvd2+
         CTnEZfj2ntcFA==
Date:   Wed, 26 Oct 2022 11:40:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v3 04/17] timer: Split next timer interrupt logic
Message-ID: <20221026094027.GB1327339@lothringen>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
 <20221025135850.51044-5-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135850.51044-5-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:58:37PM +0200, Anna-Maria Behnsen wrote:
> Logic for getting next timer interrupt (no matter of recalculated or
> already stored in base->next_expiry) is split into a separate function
> "next_timer_interrupt()" to make it available for new call sites.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
