Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0D6044B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiJSML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiJSMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:10:42 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897AC5130
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:45:58 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u10so28696229wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=veefSpmCEaSzEYZOHgJlbLK7mKiem3jbiT2QhSe/bYM=;
        b=UtgxVNkB5KqW11YYWEnWP275MLheN5JO1hvhm+lkEug9ipvI4NaEqmHwvjC7EEU5ix
         IlUIEhIlExmMwLfJTfs4PcnCobMquFSCZ3zn+JXJqEPDIhzo4OCosnmqTD9/XY7An0Uw
         LqfQuK1fIckyr12d6ZwKS1mBbCdAAQu4LvPvoFv7orxnALAmm2AXLydr8JGriFRZbCnq
         U1npfT24e5b2yU4zphbn2gIofLgp7CN2+2aL2fqRLyTC0Y1P0bNfPKatjBVIf6uPR8ny
         Ce5rZ5amUrjVnsVVYPgNx2XeivIi3ekz6mMMkpvpGNB3hWUMDfFwJF5tgcJqrotkkWui
         EX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veefSpmCEaSzEYZOHgJlbLK7mKiem3jbiT2QhSe/bYM=;
        b=NT550axrQaHyfaAjXyhnoYSI9ua+Peo4N4vryQOhYuZm4NmmZpKg2BRIeZIFhGMqUi
         7Ozm+/HotfAg9hBc4DIUmgXr/KD3/o1hJUWmp6OWxVVVGsLtWsVdbfcipAC/9k9ud6qo
         xlqHy9nepjdPNV7gr1TiwIr1cPCYuDLSjc5PVeXHVJ/OCNsiG7s6Q5Jz9cGZ9lg882Z4
         azktSH8Rvc56PEJWvbJjYwewvdbeD+fP2pNdKon3HuEyFkBZqUiV/2UXITAptA0dC6ZL
         5qKmZFwHbcIX2vQt7BzihFXd115T7rf2hxE3lSwu5SrFZeetEl24VZQu8Ilap7zekHLI
         4Xjg==
X-Gm-Message-State: ACrzQf0p7fEJtjMinMZEeGSBGjZNISz+TQkZtDaRbm1SfPrZqMuSpHKH
        24Q+UlAq3I+x/IbBbC/mpowK1g==
X-Google-Smtp-Source: AMsMyM6/W/E5CFf72zm9LnvLDDpmUQ9I7DEQk8iXL3Z11yqnh6YURaFSd1kfYytRGGqbVdZEchQEWA==
X-Received: by 2002:adf:f591:0:b0:22e:504e:fe76 with SMTP id f17-20020adff591000000b0022e504efe76mr4869340wro.553.1666179839455;
        Wed, 19 Oct 2022 04:43:59 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003c701c12a17sm3044680wmq.12.2022.10.19.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:43:58 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:43:57 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <20221019114357.yipijpetxz7ns5aq@airbuntu>
References: <20221003214501.2050087-1-connoro@google.com>
 <Y0y8iURTSAv7ZspC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0y8iURTSAv7ZspC@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 02:23, Joel Fernandes wrote:

> I ran a test to check CFS time sharing. The accounting on top is confusing,
> but ftrace confirms the proxying happening.
> 
> Task A - pid 122
> Task B - pid 123
> Task C - pid 121
> Task D - pid 124
> 
> Here D and B just spin all the time. C is lock owner (in-kernel mutex) and
> spins all the time, while A blocks on the same in-kernel mutex and remains
> blocked.
> 
> Then I did "top -H" while the test was running which gives below output.
> The first column is PID, and the third-last column is CPU percentage.
> 
> Without PE:
>   121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C)
>   123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B)
>   124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D)
> 
> With PE:
>   PID
>   122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A)
>   121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C)
>   123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B)
>   124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D)
> 
> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Instead I
> get 4 threads with 25% in the top. Ftrace confirms that the D-state task is
> in fact not running and proxying to the owner task so everything seems
> working correctly, but the accounting seems confusing, as in, it is confusing
> to see the D-state task task taking 25% CPU when it is obviously "sleeping".
> 
> Yeah, yeah, I know D is proxying for C (while being in the uninterruptible
> sleep state), so may be it is OK then, but I did want to bring this up :-)

I seem to remember Valentin raised similar issue about how userspace view can
get confusing/misleading:

	https://www.youtube.com/watch?v=UQNOT20aCEg&t=3h21m41s


Cheers

--
Qais Yousef
