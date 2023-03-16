Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40C6BC3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCPCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPCux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:50:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1FA5CE;
        Wed, 15 Mar 2023 19:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2492CB81FAE;
        Thu, 16 Mar 2023 02:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5CFC433D2;
        Thu, 16 Mar 2023 02:50:48 +0000 (UTC)
Date:   Wed, 15 Mar 2023 22:50:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230315225046.3cfed1ee@gandalf.local.home>
In-Reply-To: <CAEXW_YSMr7b4K11T6kjThG8-DyxNiJMU3LOo-SwQ+Ev8h9taMw@mail.gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230315151415.2534e11c@gandalf.local.home>
        <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
        <ZBIbloFMm5xRsjfn@pc636>
        <20230315153448.6914f85b@gandalf.local.home>
        <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
        <20230315162840.106a5b4f@gandalf.local.home>
        <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
        <20230315182628.39329315@gandalf.local.home>
        <CAEXW_YSMr7b4K11T6kjThG8-DyxNiJMU3LOo-SwQ+Ev8h9taMw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 22:13:26 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > Why not call it kvfree_rcu_alloc() ? It allocates right?  
> 
> Sure, but one can say now that allocating is an implementation detail? ;-)

I was being sarcastic.

But as the mighty Linus once said: "In the Internet, nobody can hear your sarcasm"

-- Steve
