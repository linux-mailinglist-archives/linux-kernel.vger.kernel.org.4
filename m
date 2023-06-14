Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D0730756
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjFNS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:27:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFE2120
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:27:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b4274f7640so1057551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1686767270; x=1689359270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABp1fdnv+GxTRjoai1QiZdJs+Tqn9QPie2PZlQX7SYQ=;
        b=aUuV4t9Cp4YartQWekEqJSlGz4ilrPruLsK0cwj2wsptDwvKYbbUJ1Jdgsr8PdLywz
         K0M6WxGd8dFb1JcSTc3n4H0R3DpqvLwsjl/hpMvLcfavWazNyoTE95tMXpEaPHbOSRmU
         BAwtf6QmjcIlqogrk3Gg9S51FK+GfF5zT1AYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686767270; x=1689359270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABp1fdnv+GxTRjoai1QiZdJs+Tqn9QPie2PZlQX7SYQ=;
        b=CDPTZd8WgQFWSlLumSA//xbxHDKl1O0hrBlzZIFv6KR1pmwz1DGIKvK4MZAxrNaR4b
         1yLSwiI4WcnPnYyE7fcr/BxVxBrOqY+ZpY6sJCwTaYGhxVwA2y4FN2MhB89ZVTlX3Zgt
         9Kx2X0gj5gcayqWq2DIjKRp4vua+Rcv7YHvjsWcJ2UN2FV6tS+u8lSQwLgZil0OnjjI/
         fefEAvdgszLEfZUCueboyRUzvp9BOy2mTC7cO2Kj62NrQ0sOrfpTpPhIe1mc7mslVp25
         O3xpgUBso+RZkYPNLznVT5sQNnJz5MRkRRwepsOqeIByHzo5FE/uaNQ4A82Xx1kIkA57
         vgfw==
X-Gm-Message-State: AC+VfDxW6J0t6rlsfkozrkvSElQKhgGb30c98NbNnXrW1qxNUI84FBvj
        lGqnRmnqUCHKXT4h/jmOsTfasBc7JPWG5/kZ4bFpbA==
X-Google-Smtp-Source: ACHHUZ5TwhhohYKXUJ45UiHCzDXDmdjiwBtYB9veq7wpGPUMmbcrFqDtvWXqSEGET17zCBQpTabvrm4ZHeFGXM5qMaw=
X-Received: by 2002:a2e:8e28:0:b0:2b1:b06f:889d with SMTP id
 r8-20020a2e8e28000000b002b1b06f889dmr916884ljk.17.1686767270184; Wed, 14 Jun
 2023 11:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org> <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org> <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
 <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org> <ZInLcNqGpLCw8xsn@localhost.localdomain>
In-Reply-To: <ZInLcNqGpLCw8xsn@localhost.localdomain>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Jun 2023 14:27:38 -0400
Message-ID: <CAEXW_YTea1LdPkcwPDw5wdvM+205k4eFfaM_DwhvGKB8rCn_Ug@mail.gmail.com>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:15=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com>=
 wrote:
>
> Hey,
[..]
> > By postponing the enqueue/replanishment of the DL server here, we are f=
ixing the
> > problem in a practical way, that works without breaking existing useful=
 properties &
> > use-cases.
>
> In my understanding, if we simply postpone actual activation of the DL
> server up to the point it really needs to boost/run for giving CFS tasks
> some breath (the infamous 0-laxity :), we save RT tasks from useless
> interruptions and still can keep EDF/CBS working w/o much changes.
>
> It looks like a low hanging fruit, small improvement on what we have toda=
y
> than doesn't prevent us for implementing more complex features (i.e., ful=
l
> blown hierarchical scheduling, alternative schedulers) in the future if
> the need arises.

Agreed, thanks!

 - Joel
