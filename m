Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC564EF30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiLPQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiLPQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:32:43 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A71266C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:32:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id ay32so3059427qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWTKvq0Z8Lun5k4EX7m861ECUbu18rBFF3DYFc725RY=;
        b=pN2JdeL0UXzd0Dvw69uGbyO7tEP5Z75yckU+lEI9GqWB2dwXfjqmoTqGgVNJzAStVW
         HbzM3PlWFRmHdb42JC/0VgGu96m7oXL6hCh8wHsa3vk0+xxCa78smCePNcfotnhMSBpq
         /QuECKwer8WkZpESIRjEsUQGLbXIQ1jQkB3X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWTKvq0Z8Lun5k4EX7m861ECUbu18rBFF3DYFc725RY=;
        b=N8MOiAf9ZKVc0Dg/XRYoB+wn6r+kw+iN8smEQvIZvSCz3s0EAR6ST9HEMh14r0HDFQ
         Aa3DGUnjUKBga/E2qWRbYuVsDA0mxZHVx4ZJDKE6BW71fUOxocdbwvsb5TkUCqQDTTnl
         3FrMXaO6xg2rGY2VZd7QCmb4XYoIcb8xVey+O2K2+t3PWqDgvW4xaFwPpsrnvwc2lMpx
         Qz+2tFjDXsXeMKr0uZh1BMlji2GfYdE4/52j11AUj+yU859AP3X8EIir9uPSdfzVFwAf
         OaGYe+JuvT2eK/3p0l0g8ryknHxq3kJuiHXiem7CQNyYM9hDBq8u0n9ACDZ6O+QEzNyn
         YCKw==
X-Gm-Message-State: ANoB5pklw0KtuP8Rte/rsyx4Ua8IWXSp23Hd5rBE5ELf7a1bA+0+yUqK
        nZBiynD1JkKZXoLUMbXuWWEaCw==
X-Google-Smtp-Source: AA0mqf6EAnHcIVAw94wyGebCIhI6qcQwBvfweRpFyWYod0KCt4TMiZOpuPrTAWnKpCwZpJ/UeBgy4w==
X-Received: by 2002:ac8:1084:0:b0:3a8:2e:ea22 with SMTP id a4-20020ac81084000000b003a8002eea22mr39513623qtj.44.1671208360762;
        Fri, 16 Dec 2022 08:32:40 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003a6847d6386sm1536318qti.68.2022.12.16.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:32:40 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:32:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <Y5ydp2YPRqGHq+eM@google.com>
References: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
 <20221216010914.GX4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216010914.GX4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
[...]
> > >> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> > >> has no new smp_mb() that happens AFTER the flip happened. So it can
> > >> totally sample the old idx again -- that particular reader will
> > >> increment twice, but the next time, it will see the flipped one.
> > > 
> > > I will let you transliterate both.  ;-)
> > 
> > I think I see what you mean now :)
> > 
> > I believe the access I am referring to is the read of idx on one side and
> > the write to idx on the other. However that is incomplete and I need to
> > pair that with some of other access on both sides.
> > 
> > So perhaps this:
> > 
> > Writer does flip + smp_mb + read unlock counts [1]
> > 
> > Reader does:
> >  read idx + smp_mb() + increment lock counts [2]
> > 
> > And subsequently reader does
> > Smp_mb() + increment unlock count. [3]
> > 
> > So [1] races with either [2] or [2]+[3].
> > 
> > Is that fair?
> 
> That does look much better, thank you!

Perhaps a comment with an ASCII diagram will help?


Case 2:
Both the reader and the updater see each other's writes too late, but because
of memory barriers on both sides, they will eventually see each other's write
with respect to their own. This is similar to the store-buffer problem. This
let's a single reader contribute a maximum (unlock minus lock) imbalance of 2.

The following diagram shows the subtle worst case followed by a simplified
store-buffer explanation.

READER                  UPDATER
-------------           ----------
                           // idx is initially 0.
read_lock() {
  READ(idx) = 0;
  lock[0]++; --------------------------------------------,
                           flip() {                      |               
                              smp_mb();                  |
  smp_mb();                                              |
}                                                        |
                                                         |
// RSCS                                                  |
                                                         |
read_unlock() {                                          |
  smp_mb();                                              |
                              idx++;  // P               |
                              smp_mb();                  |
                           }                             |
                                                         |
                           scan_readers_idx(0) {         |
                               count all unlock[0];      |
                                   |                     |
                                   |                     |
  unlock[0]++; //X <--not-counted--`-----,               |
                                         |               |
}                                        V               `------,
                               // Will make sure next scan      |
                               // will not miss this unlock (X) |
                               // if other side saw flip (P) ,--`
                               // Call this MB [1]           |
                               // Order write(idx) with      |
                               // next scan's unlock.        |
                               smp_mb();                 ,---`
read_lock() {                                            |
  READ(idx)=0;                                           |
  lock[0]++; ----------------> count all lock[0];        |
  smp_mb();         |     }                              |
}     |             |                                    V
      |             `---> // Incorrect contribution to lock counting
      |                   // upto a maximum of 2 times.
      |
       `---> // Pairs with MB [1]. Makes sure that
             // the next read_lock()'s' idx read (Y) is ordered
             // with above write to unlock[0] (X).
                            |
rcu_read_unlock() {         |
  smp_mb(); <---------------`
  unlock[0]++; 
}

read_lock() {
  READ(idx) = 1; //Y
  lock[1]++;
  ...
}
                           scan_readers_idx(0) {
                               count all unlock[0]; //Q
                               ...
                          }

This makes it similar to the store buffer pattern. Using X, Y, P and Q
annotated above, we get:

READER                    UPDATER
X (write)                 P (write)

smp_mb();                 smp_mb();

Y (read)                  Q (read)


thanks,

 - Joel

