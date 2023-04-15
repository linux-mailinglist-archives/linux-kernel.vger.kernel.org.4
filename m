Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05D6E33E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDOVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 17:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAD35B1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 14:50:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681595408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RF8rETFXCMTOEukxl28OtsTiYOmUtZ5LkzSVRomdEI=;
        b=bCSe9oIbk38mz6gGtqb83ZHXb79KC5FX34U0HbGtZ0K+gUKZgAlcbCyPtTUyV52BQyjKuJ
        E83vMU/abAzkt43icmo9xeRb70plOh1pHlSKpvGg6bk21bHoNtjdQKP9zZp82j6mUhMtOB
        ojAJOA6Wkqt5MqFOlo5LrMJkSrL+ZyDr3dpvj24OJ3ElQcmI4iF7aEYgp0mPLFZfftA005
        Xb2GFZF53+OLnyrJIbWumxEW/1NA0xIoZrH8FeOOm17fUlpqH+85GFubRgeJ2kNbZtVVKk
        WDcNqXNo23+jG3bFYvMn04cg7NY1gnKdDk6IvW0WFOyQEaigTi3VqDhm1H8Vsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681595408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RF8rETFXCMTOEukxl28OtsTiYOmUtZ5LkzSVRomdEI=;
        b=FGbGIwtE3KdJH2E1FnzqdjS/QofAGcl+GaCS22tt/YdqoNZPnbY2D4F4YdaR0VO/5HSu+T
        Mg3wmKfzxyS+vyDQ==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
Subject: Re: [PATCH v3 0/3] Increase the number of IRQ descriptors for
 SPARSEIRQ
In-Reply-To: <3951b23f-bafa-2979-f349-232c509a33fb@nvidia.com>
References: <20230410155721.3720991-1-sdonthineni@nvidia.com>
 <3951b23f-bafa-2979-f349-232c509a33fb@nvidia.com>
Date:   Sat, 15 Apr 2023 23:50:07 +0200
Message-ID: <87jzycyfw0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15 2023 at 10:49, Shanker Donthineni wrote:
> Hello Thomas,
>
> I wanted to update you that all the review comments have been resolved and
> the necessary fixes for the maple tree have been integrated into the mainline.
> If there are any outstanding tasks required to consider it for the upcoming
> v6.4 release, please let me know.

It's on my todo list and as I'm traveling next week I might not come
around to review/merge this right now.

I'll get to it.

Thanks,

        tglx
