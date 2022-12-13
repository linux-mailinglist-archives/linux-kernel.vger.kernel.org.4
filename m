Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA664AC90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiLMAm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiLMAmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:42:10 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE5112757;
        Mon, 12 Dec 2022 16:42:08 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso6248402ott.10;
        Mon, 12 Dec 2022 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbqL3VgUGL1FVhGoBoEKpskmhDGn/c46rzKHLqxTXoI=;
        b=gqPx3aylY0jjbVSnMe1Z38P/Xkih0MuThhG+bzCdkZoG2WcK5nJn+8rtseLobNUAe4
         qPFEbezy8KC24+PV8QPSIPs+1AzRWLYKlZz2QYmAvBpPOJhgtkBxzJNllpeI/6I1bIC4
         YLsuWnpVrEp2Enjn4swCE3gy1PoeOQ0euIL0QGwiBgmuhHgo4OA8rm8BlgSp4GkUBMQn
         s11QBbr4nJ5sL1k9+zZUHqDWdwpUMWmkJGjH2aOYPCsaIZGMJfhJMwyv11THdv7iY8eD
         OaQCF4KuPMZp4iKY0/icQce1SNbIYg8AcLNmkzqsUwA7E5LpqU+eccvX3PR9FrWV6dg2
         uxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbqL3VgUGL1FVhGoBoEKpskmhDGn/c46rzKHLqxTXoI=;
        b=15dZnRMypkEZ6eLPkKUS9hyCyX5QLJD87OwG+N5lCXEGyQV3va75ko3yuwhwxFG3jf
         9B+DTTrit0A1J0Qtz+UaoFy1xiqn6UslypPCqXsNLGNeVRkxF8iFFT1NHS1wMAEvRzBA
         tEOcmXTELF7E3DF6rNgXFMn0mFvNw048vVMoESyauFcTtvq4cfsQrcIGBc40l52aWPFd
         qIutF+jtoERBY756uEnJRFwXSp1JY6WqRbyknYBYAswQX7YVikxnbLTgpYhe0WF6Dhko
         g04jsrAxgzw8/q8lteCAUZDkrqHiLZVff/cVK3Smboximx2mpD0tUzmM69aQZAPmjrls
         btgg==
X-Gm-Message-State: ANoB5pmXQeU6+qIlvMA7OUIbizfhhruGgpqcTqrWs4acwvhtLKqnVr7j
        8DbRUG6a8GS5/smiwq+XoeJaxFWAJiY=
X-Google-Smtp-Source: AA0mqf7K4+nEABpYZCDpkhVNruN0HBpNDYblRQQfqEUxb16zfEieOGn7hF5Lm1kPOntnVJj+n8sNqg==
X-Received: by 2002:a9d:1cf:0:b0:66e:c503:97a8 with SMTP id e73-20020a9d01cf000000b0066ec50397a8mr8777210ote.3.1670892127849;
        Mon, 12 Dec 2022 16:42:07 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m4-20020a9d7e84000000b0066eab2ec808sm585564otp.1.2022.12.12.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:42:07 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:42:06 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the bitmap tree
Message-ID: <Y5fKXpj54XPyJnrW@yury-laptop>
References: <20221213085419.3f983d80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213085419.3f983d80@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:54:19AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   e58d68e2633f ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
>   06a99cbab38e ("sched/topology: Introduce for_each_numa_hop_mask()")
>   5c0da4f67fe1 ("sched/topology: Introduce sched_numa_hop_mask()")
> 
> are missing a Signed-off-by from their committers.

Fixed, thanks.
