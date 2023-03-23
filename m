Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DE6C6406
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCWJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCWJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:49:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487C166CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/W5NnIHjIshco1Dms/7I2CftD5GwAfzEK2tg2IdKDk8=; b=eDK2Bn5maCj5G9cOHauh+Xnt1g
        TPZl4ylHTcNkYc3k3u9wE4ut6cD5VMjBe6AFsVIJzDz/6Zfs5zr3MF9f339i+LcrUs4GBggIZRTC/
        Ar6w6nktocoNseCmrCrDZyH7U7mtmlSuxSrfI4Sow+m59wNk7r48mkOPhLLjEB2dIEDaKmz1gXA05
        KI/rNkzX4dmWoYEW5SBjkGxBy6tPTSbdIjuMWvOXk4g3URngWXLogb1FLD1lQIIin3R+MhBy7L8aj
        9F2ZGKOl2WUXMYZWIfM/EWeRDoIs1oNpvTBmFvzMuouUPnpaldn9W7K0DKFKpRV6ij3YlV/F4bl1V
        /HgFhYpg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfHXk-004pM1-2O;
        Thu, 23 Mar 2023 09:47:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E199E300237;
        Thu, 23 Mar 2023 10:47:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95742200C937C; Thu, 23 Mar 2023 10:47:35 +0100 (CET)
Date:   Thu, 23 Mar 2023 10:47:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230323094735.GC2508414@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:

> +	group->num_childs = 0;
k
> +	 * To prevent inconsistent states, active childs needs to be active
> +	 * in new parent as well. Inactive childs are already marked
> +	 * inactive in parent group.
> +	 */

> +			/* There are no childs that needs to be connected */

s/childs/children/ and s/needs/need/

The child needs ...
The children need ...

