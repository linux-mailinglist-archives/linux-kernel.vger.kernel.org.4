Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7D6E1B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDNEso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNEsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7E744A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416BC615C4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0F0C433EF;
        Fri, 14 Apr 2023 04:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681447720;
        bh=UNYU+uth7VFu5laB9+XYdJ3O6vpWj1hZhbp5alPJOkY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uVHSmzC7pTm3ssbuP9J6fCz3KsiN8JtBHaxjMa/wKzAaAi1nk4QdvGFR8fxXKrgeh
         Aglb+QaJizoFOGtjxK9WwJ0OjC/JWOnCdivIGSivzIgLauWTSR6EHLZ1ut5QRKkbUu
         6eEX2snFOuvnbgQ4GVJ81CQFjFPVoTKA1kj5ghKTjcgD5MfjrqIdBlz3VhxL69H6ad
         ik8n0G7BdajINmIJJCdXJJqJhzkzj/KeG5B7RMVX487RGTbSPMX4Gjg/323sAOgYXc
         4UvuKi6rijQX4BHRtc9d/jOqpT3kc58YEy7EFrIWElJ8UsIOrbQkvJXnQbdB0aq7LG
         wTfOsUqJczmxg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF6C315404B5; Thu, 13 Apr 2023 21:48:39 -0700 (PDT)
Date:   Thu, 13 Apr 2023 21:48:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     quic_neeraju@quicinc.com, urezki@gmail.com, frederic@kernel.org,
        joel@joelfernandes.org, boqun.feng@gmail.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: RCU coverage for this coming week
Message-ID: <4698514c-2309-4adb-8740-04a821b0c9d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9299136a-4c49-4638-b2ce-523cc3329bfd@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9299136a-4c49-4638-b2ce-523cc3329bfd@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:46:01PM -0700, Paul E. McKenney wrote:
> Hello, Linus,
> 
> I will be on travel next week, and will likely have limited Internet
> access at times.  RCU is unlikely to have much trouble at this point
> in the cycle, but Murphy says otherwise.  So, just in case, for the
> components of RCU that have had the most recent changes:
> 
> o	Neeraj Upadhyay is covering Tasks RCU.
> 
> o	Uladzislau Rezki is covering kfree_rcu().
> 
> o	Frederic Weisbecker is covering offloaded callbacks.
> 
> o	Joel Fernandes is covering SRCU.
> 
> o	Boqun Feng is "batting cleanup" with RCU-related memory-ordering
> 	issues.
> 
> They have been through much of the code, as you can see here:
> 
> https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYutdSIajfpLA/edit?usp=sharing
> 
> Have a great week, and I will be back Monday April 17!

Right...  Make that April 24th.  I clearly do need a break.  ;-)

							Thanx, Paul
