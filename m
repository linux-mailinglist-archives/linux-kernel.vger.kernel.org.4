Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602872F798
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbjFNIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjFNIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:17:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94F4199C;
        Wed, 14 Jun 2023 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hss47gyp6BYYMhFB7hAoae1QAy3auKS104enX9ZgrIY=;
        t=1686730630; x=1687940230; b=MX5Q1OKNaxE0pbxo5ugU8AJumLk781/uUL6I1kbJzJdPBDi
        jk12HTceTWGFIwu/CXwcmOY6wmZ9zz0rVXIpgUyN/svuQMlHtpcCl/+uRbfrueJg5xGjQT/RaX32k
        4UhoIWHXVXGvInF5NRHgiK3Ys4IuKYQuczgGOpyc30nrDQ1vVT8ZfwkbvDA4jVCQ9FWgZH2l+haC2
        er+4EjXg4XMPxwlMZGuLPM0asGs70+XuKnLEfujzVF6flZA/G2kQ58vLyN6rNJyzrQNY+OO1lCDjJ
        Pa1lHfGLEut5F+N8R0d92pp16rcZyvvHjbrPIg9QxjUwZs3UbeUa9ZXXrROBziyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9LgY-0060G9-2h;
        Wed, 14 Jun 2023 10:16:59 +0200
Message-ID: <058dd31ef48495f8641f5b66839aaea039af0f08.camel@sipsolutions.net>
Subject: Re: [PATCH] b43legacy: Remove unneeded variable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     wuyonggang001@208suo.com, Larry.Finger@lwfinger.net,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Jun 2023 10:16:57 +0200
In-Reply-To: <12c1079d6e73f8f62c33b8a53dff7ff4de0728dc.camel@sipsolutions.net>
References: <20230614075250.29097-1-zhanglibing@cdjrlc.com>
         <194e8e87fda5f02664fcfac3717458f2@208suo.com>
         <12c1079d6e73f8f62c33b8a53dff7ff4de0728dc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-14 at 10:02 +0200, Johannes Berg wrote:
> On Wed, 2023-06-14 at 15:55 +0800, wuyonggang001@208suo.com wrote:
> > Fix the following coccicheck warning:
> >=20
> > drivers/net/wireless/broadcom/b43legacy/debugfs.c:68:9-14: Unneeded=20
> > variable: "count".
>=20
> Hey, no. Please stop it already. This won't even _compile_. Just don't.
> There's really not much value in cleaning up those coccicheck warnings
> in the first place. You're just wasting everyone's time (including your
> own).

And BTW, I've just looked at all your other contributions to other areas
of the kernel, and heard from others as well - not doing any better!

I can only suggest that you stop all of your patch submissions and re-
evaluate what you're even trying to do. And not just you personally, but
all of the @208suo.com folks who popped up recently.

johannes
