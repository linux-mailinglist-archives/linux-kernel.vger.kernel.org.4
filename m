Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789DA707460
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEQVfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjEQVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:34:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B304496;
        Wed, 17 May 2023 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H2c6uRb95qpElPmZyz5hJS7ZREoAr6SQ6O2hH5vnwIA=;
        t=1684359286; x=1685568886; b=hewDQxWcuLXS0utycf/O9EqKnTv+Yy8TVw6Sp1RE8+uctXa
        PvXBlJjz1MVyk3HRK7Wx2IBGKoersVyo83tqv5SbfxsbYRPnZ593epQLUocW/PEPYKF1fXUflJyPN
        PkZ6fLUXFyHx+6aXcEi/50ZirHQyiysyJCtbMUu4iXga4zhFou53+ExOndnKD9rz2jE0PnaBLCV1s
        LlB+Og9h4+Ocf43ijW2EAIjpUwDWm+7yEr/jmdlsHFC4bSvS+Xws2G6ebCD9cO7OKJtbaE5NZz7S4
        JNIMsS2ne6Z10DnyO5JKaPTw9VZAVgbyrfazvcj3Sc4qO7v8HggKwhprHGoHocpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pzOnC-00D3gi-16;
        Wed, 17 May 2023 23:34:42 +0200
Message-ID: <056e71bd6a06779bfcb1ef4518a2f67f67730fe7.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/1] wifi: mac80211: fortify the spinlock against
 deadlock by interrupt
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Date:   Wed, 17 May 2023 14:34:38 -0700
In-Reply-To: <20230517213101.25617-1-mirsad.todorovac@alu.unizg.hr>
References: <20230517213101.25617-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

>=20
> Fixes: 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs for resumption")
> Link: https://lore.kernel.org/all/1f58a0d1-d2b9-d851-73c3-93fcc607501c@al=
u.unizg.hr/
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/all/cdc80531-f25f-6f9d-b15f-25e16130b53a@al=
u.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>=20

You really should say what you changed, but anyway, it's too late - I
applied a previous version yesterday.

Also, I suspect you just collected the reviewed-by tag here, which
really you shouldn't be doing a resend for.

johannes
