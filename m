Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5431873594C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFSOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFSOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:15:01 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jun 2023 07:14:59 PDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350B8E;
        Mon, 19 Jun 2023 07:14:59 -0700 (PDT)
Received: from sparky.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7386320153;
        Mon, 19 Jun 2023 22:07:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1687183622;
        bh=Zi8Q3+lSjvBrfrM3SdqJlbZi4/Rc2YBaeBye3BWAkN0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VCafOUSti/j8wBPaEI67oO15YsgZjEm8lvA8i00E8kVkjSQC2gg6e0k7fcOr78eH8
         RcP5euhw5himZZ+NVUyMKF+Qk2el1Ql6Je+xB34vThMA7gNY6jrbMkDnUn3Mlse1gp
         hJXhlxfIn/aZZuajiyGL7qJ+uZ54EajOyFwJYtf8GJg3mzFnsOCjWLzDmchMokMtMh
         6r5a88Eo+yVd9MAOL9fvMT5Ir+Vt5cg6HH4cBKy6B24OjxZWGOqvdvsD8X5pyb0VHP
         eOMeZZnX23dc+pFTO+Pb8LeqSafyRZUlgzXhtfY7hQP4XqjdbK94QQ/4r/eqSrOXSg
         F5Wm3c49BnheA==
Message-ID: <c83bb6cf8f0d1ea8f5e3da690cda5e9742498a39.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp: Reorder fields in 'struct mctp_route'
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Mon, 19 Jun 2023 22:06:59 +0800
In-Reply-To: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
References: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> Group some variables based on their sizes to reduce hole and avoid
> padding. On x86_64, this shrinks the size of 'struct mctp_route' from
> 72 to 64 bytes.
>=20
> It saves a few bytes of memory and is more cache-line friendly.

The savings will be fairly minimal, but this doesn't affect readability
for the route struct. LGTM.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Thanks!


Jeremy
