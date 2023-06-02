Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF671FED4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjFBKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjFBKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:19:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636F1BF;
        Fri,  2 Jun 2023 03:19:15 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D2792B8;
        Fri,  2 Jun 2023 10:19:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D2792B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1685701155; bh=QMXbgBQiNP/xtmRJwUXLAhiAmFdwAINgR8c7SCTJZn4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a9VxAqMWcSzE5nwi8CWXTFYo4GfHQfgD0mRZOnjY++0mhwtlzOz6e2YBCw9p/Uv7z
         Ht4uXJxQ0N9/OML/2ALt5UFOJorv4QiDc9f+n1kJiBj8PNO51gW64bCEGoex8Sw6cA
         3eOw6iUsiRPiXH5WLTXJD5DhsA5HGHSxd42gRj0frQQu2Bb7EUzcgUEvBqVuYZBFPP
         O2rT2osHRGjjCKhq8h2c3uGPxV5ZwKHonws4HOBHTWisi7S/o4HGLBMGoTQclVfVw+
         T6rxxUi7hs9qS0TgV2QTNwIdrTLRf3po+oyHZp7gtFD8oLGrR70dC8RJLiaL5/oxab
         qGhRuFdIl57pg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
In-Reply-To: <ZHm_s7kQP6kilBtO@debian.me>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com>
 <ZHm_s7kQP6kilBtO@debian.me>
Date:   Fri, 02 Jun 2023 04:19:10 -0600
Message-ID: <87ilc6yxnl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> As you're still newbie here, I'd recommend you to try contributing to
> drivers/staging/ first in order to gain experience on kernel developement
> workflow. Also, you use your RedHat address, so I expect you have been
> given kernel development training from your company (and doesn't make
> trivial errors like these ones).

Bagas, please.  I'll ask you directly: please don't go telling
documentation contributors how to comport themselves; you have plenty
enough to learn yourself on that front.  It's hard enough to get
contributors to the documentation as it is without random people showing
up and giving orders.

I have distractions that are increasing my (already less than stellar)
latency, but I'll get to this stuff.

Thanks,

jon
