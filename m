Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55374133A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjF1OBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjF1OAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:00:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5E2690
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-765942d497fso333887485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687960851; x=1690552851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2DwWiZLvTamlgYfPpZCrrIt3ujgybytQS5TkRWJ5Ns=;
        b=PKzdsmna/9oYlv+8xOC+ufPxxtriQI1hn10QZUxQo+6Smdoi/OQbtb92gYUFiC2F/e
         58zqvvFbIkb+C5CEQpJQJhog0/vG327u7GsvRSNlZYOLs3TjpnNeqURJFejas5ymfnd1
         CiDfznlBzv1kpkWFByinehAmbJZwbsViKSf8LOkzTCjrlPoPQnqCn+SBWWZFLSxeNC5M
         Ke5obbOWbLFe2EB9Lb6OALabxg1R+l53TT5o7Puce562qtRegW2X1sdjRvEq3xiF6bu1
         g/c6HMi0d9r0TLMwwh95ViV46qJs9gq6Ue6seTKIaYdXeNkF90kXuGbMjKJZ3iIIVhAv
         1BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960851; x=1690552851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2DwWiZLvTamlgYfPpZCrrIt3ujgybytQS5TkRWJ5Ns=;
        b=YBweE03PaMjbzBTahf10RETj0ZavHMox1Us/pc9nDjzS1/aATSna2SqFgFr+xLZiSb
         kppxSRRmQpoVkitmrxmiPOYZ39C33/5jzmVeFcOpU3TeOsPruhDeb2si0/9/UBVMbJV2
         Cms+CIaWeDeqDSlrfCIT0IYTrZCxRgsXH8JlZeuR6GTNRmXVN2Jh5sTCTwQ+mKtgeR07
         IKdWQ1ijTqnM91Ojjx+OYbKXocN4S64Bd/5krLdEn/Li/EYFGm42szU06iudkDKmR8tl
         7zckD4zDeK2snR7u9jA+57SYMb6kWUUlRPjc7+5OeIu2EqGSbrHMOQU9G1sd/Pc7mIwT
         bUTg==
X-Gm-Message-State: AC+VfDzMyNSZhKa4VFq8USGn4cGSt/lTIriNZZrVDHmvYKqKqpKqRqct
        uVJNvB9H/lNQsPV8rbNNlDfX/w==
X-Google-Smtp-Source: ACHHUZ6flPS2HiVQ9bTDAYQS0DJenK15VEoltyFmNNsQnOKl4Godt3sTjfCfPGySQH5JiS2Gw/NtLA==
X-Received: by 2002:a05:620a:2950:b0:765:5acc:b86c with SMTP id n16-20020a05620a295000b007655accb86cmr17489333qkp.12.1687960851360;
        Wed, 28 Jun 2023 07:00:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a10b200b00763a3e5f80dsm3429143qkk.15.2023.06.28.07.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEVj0-009OCu-6N;
        Wed, 28 Jun 2023 11:00:50 -0300
Date:   Wed, 28 Jun 2023 11:00:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v6.5
Message-ID: <ZJw9EsEzQbo3pj0C@ziepe.ca>
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
 <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
 <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
 <ZJw26orq0ZLEOL9q@ziepe.ca>
 <9b1a620a-975a-490f-b9ee-6aea7c8effe0@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1a620a-975a-490f-b9ee-6aea7c8effe0@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:46:50AM -0700, Paul E. McKenney wrote:

> The revert meant that 0-day didn't see -rcu without the single-argument
> kfree_rcu() definition.

0-day is also supposed to run on your branches, not just linux-next,
at least it does for my trees..

Jason
