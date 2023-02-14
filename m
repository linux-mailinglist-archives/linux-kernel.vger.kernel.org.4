Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26881695FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjBNJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBNJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:46:05 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320E233C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:46:02 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 46F51240308
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676367961; bh=uLmz//y1yvE3HoFw//y4zEkCSNNtd9iN4bLEf+FBaIc=;
        h=Date:From:To:Cc:Subject:From;
        b=NvK7hL7SsyZNfWg0X9CVu1MTcuhaNUtUMsU3lbw8XBqKmAIPqHQnvVmocugPP+PDa
         VvnFHUaqk/GB3blwSaxLGL1yLDQ3WS4FK7KjEGxnfkhsfXEfGQe4v3rXSKUpYQY95g
         UEL6pD6l4Mp4g337N7fQZWMDWYPJQf41MDZ0QUkTozTsTg0JR41obePk8CVnQvZE07
         7+r/Sx1PoOi55JsdcAQXRsN4LI/1t3DDk5lwVtLQdgTbRHqzn6JEXGAviSagBAZKYk
         XcYa0tPdESHNbbrto/Phhl727R8HgJiG2jj8VAmsm7wsjNbVTQwadPjOLoEbxKxshf
         K/OohAZOgDHQw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PGGYH0cQvz9rxL;
        Tue, 14 Feb 2023 10:45:55 +0100 (CET)
Date:   Tue, 14 Feb 2023 09:45:54 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Bastian Germann <bage@debian.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230214104554.35338faa@posteo.net>
In-Reply-To: <20230213231931.6546-3-bage@debian.org>
References: <20230213231931.6546-1-bage@debian.org>
        <20230213231931.6546-3-bage@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 00:19:29 +0100
Bastian Germann <bage@debian.org> wrote:

> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> and reset-names set to "ahb" as required by the driver.

Hmm, this one is a bit odd. If you look into my earlier versions of the
patchset, you may notice, that I actually included these bindings and they
were refused. I think the argumentation was like
"there is only one bus = no need for it".

If it gets accepted now, I really like to know why. (It was some trouble
back then to get the documentation properly done and accepted.)

greetings,
Will
