Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDA5FBD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJKVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJKVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:40:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F030F52;
        Tue, 11 Oct 2022 14:40:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E24957F9;
        Tue, 11 Oct 2022 21:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E24957F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665524441; bh=MIuAxRUV7RKGiQyfYAcl6aM18LcMGnxjLzjJ2gmaegk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S17sUfoSGF1QknyhOtcxEWkRnsOTVZWUHXBDjz5zCNRgapUXo/GsamKWHxJTSVI0p
         iO/rHSsQZnB9z03FJyCjX4ijUSz54FgJtIB6KOMzpH6YohI7wI7lj5/Lyete1hB/7x
         jvT15Gc2FgZEybTbE0E1aWoru/c/omeEltkVqPAlz8nfTjEpA2qI1RLLYe9zIuauCU
         Xh5Cj7fRQ7vMGyZQf1AatzVWwoNpfDBe5eTZfCUJ9YUw+6V2YG95s5k5cCLsGEBijJ
         Nr8ltT14/Fu9NlpWl1NghANMwBd8iid5dmNxOXgfSylYXwW/Vo6bxvd6ijUaFFqLz6
         KWzBCkMMbI3dg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
In-Reply-To: <20221011210450.6eb13ec6@sal.lan>
References: <20221011190047.749145-1-corbet@lwn.net>
 <20221011210450.6eb13ec6@sal.lan>
Date:   Tue, 11 Oct 2022 15:40:40 -0600
Message-ID: <875ygqninb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> No objections from my side. Surely more things could be tweaked. In
> particular, I didn't like having two ToCs at the index (a complete one
> and a second one pointing to where we are at the docs), but that's a lot
> better than before, so, I'm OK with that.

Oops...that was actually a leftover from my initial attempts to improve
the information there.  That's not what the patches create...I've
updated the rendered docs to reflect the actual output.

Sorry for the confusion,

jon
