Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED06666AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAKXAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjAKW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:59:59 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7E2630;
        Wed, 11 Jan 2023 14:59:58 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3EA85BF;
        Wed, 11 Jan 2023 22:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3EA85BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477998; bh=rtPNIDXg8+GBAfcNqMMnISpShTAUZwiOD82iMYOuxEw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y5E8Fbwjw36ohmKzr7bZgIhcU/bYp2c8b9ry5EhYKHVf+I6hPNKMzp9yrRZ/tAWgR
         nLYWOi7OkB0hZFblieTFCj0lw/iM4HKMAYuXFQZ3DOeoFCxdQqhqeKoVZ3fLnANSGh
         v2doGCPzuTrt3g7Cqv0VN7latgPvoNrQkOxcKsFQdehneyO/2sNEoIsLdZATwvWINh
         yo/tR6zt2qn2SgLfkeXQp1f6Nqyn/RwpVfPwNG7klq82muMq3rGzUHtfLHNmYCY9/G
         pHQwh2X9P7SQ1bF5axtUoQX4mN2O3lV5dQisrNC8zGAOQ+X9vuS74ue6NR2gR9eV8i
         MYHfZD5k8IkTw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc: monospace style for inline code in botching ioctl
In-Reply-To: <20230102183649.9626-1-federico.vaga@vaga.pv.it>
References: <20230102183649.9626-1-federico.vaga@vaga.pv.it>
Date:   Wed, 11 Jan 2023 15:59:57 -0700
Message-ID: <874jswwuc2.fsf@meer.lwn.net>
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

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Highlighting inline code improves text readability.
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

It improves *HTML* text readability; the results for plain text are
... less clear.  I think it's better to avoid this kind of extra markup
when we can.

Thanks,

jon
