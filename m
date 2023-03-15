Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2C6BBD53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCOTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCOTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:35:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F982343;
        Wed, 15 Mar 2023 12:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B0361120;
        Wed, 15 Mar 2023 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D0AC433EF;
        Wed, 15 Mar 2023 19:34:50 +0000 (UTC)
Date:   Wed, 15 Mar 2023 15:34:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230315153448.6914f85b@gandalf.local.home>
In-Reply-To: <ZBIbloFMm5xRsjfn@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230315151415.2534e11c@gandalf.local.home>
        <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
        <ZBIbloFMm5xRsjfn@pc636>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 20:25:10 +0100
Uladzislau Rezki <urezki@gmail.com> wrote:

> > This was my main complaint too, kvfree_rcu_mightsleep() is an absolutely
> > horrible name for an API... But nobody seemed to care about that!
> > 
> > I like the _synchronize() suggestion, as it matches other RCU naming.
> >   
> This is basically about what it does. If you renamed it to "_synchronize()"
> in reality it would not mean that it always a synchronous call, most of the
> time it is not whereas the name would point that it is.

No, just comment it.

I was going to suggest "kvfree_rcu_might_synchronize()" but that's just
getting ridiculous.

Still, I will replace that code back to a kfree() and rcu_synchonize() than
to let that other name get in.

-- Steve
