Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC663659D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiKWQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiKWQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:22:34 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477098FB0D;
        Wed, 23 Nov 2022 08:22:26 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C7786381;
        Wed, 23 Nov 2022 16:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C7786381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669220545; bh=ziUSjWeP0TMKpzDfwp2XgL3RYhpTv8KIM0FmnLlz0Jo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CX6x+J7k4ymUMMZ2It4K+oyhZ8T855S6hUh8X/aJci7V3wvceKALHOn5+XkPTw6cc
         3J4dPxTRCC4LBkrSB1zjCZIbLB87ZHhj0jYDUAohlMGW6s5E71+Wh8Ot4Ie4kKNHjc
         jegz1pL/1aFp9BwuTPpz8aniKxUbEbC1Jm/gYQcU+E9HIiiLTML6ofxJUHYcAc1xRe
         /cVpYHgMorIHg+KmK1JM7SxJ2+FoF1yrRq1XflyenfAY0yX8luU1G8QKfgR34lHfev
         Q+BhSUDCKy+sz+CCSbwhRqLNkbd0AZLm+pOtJ7nB441ZqiHjIkE/pdJnvSEzlGM4LQ
         WtYeulM38TOMw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org, lstoakes@gmail.com
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
In-Reply-To: <093907af-2e4e-d232-1eb0-7331ff2b9320@amd.com>
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <87wn7o9g9s.fsf@meer.lwn.net>
 <093907af-2e4e-d232-1eb0-7331ff2b9320@amd.com>
Date:   Wed, 23 Nov 2022 09:22:25 -0700
Message-ID: <87a64h8wu6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> I don't know if that would have any success. Worst-case scenario, we end up
> with an equally outdated list of resources in a few years. But maybe it's
> worth a try?

I'm certainly not opposed to trying! :)

Thanks,

jon
