Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0D6F1330
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjD1IWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjD1IWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:22:30 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 490001BE4;
        Fri, 28 Apr 2023 01:22:29 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 73E1110861F;
        Fri, 28 Apr 2023 10:22:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RhJW4r8iCzkn; Fri, 28 Apr 2023 10:21:41 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id B876E1085BD;
        Fri, 28 Apr 2023 10:21:41 +0200 (CEST)
Date:   Fri, 28 Apr 2023 10:21:31 +0200
From:   Simon Guinot <simon.guinot@sequanux.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: Re: [PATCH 1/1] gpio-f7188x: fix pin count on nct6116d bank 7
Message-ID: <ZEuCC5LSYhKwMW7V@76cbfcf04d45>
References: <20230425153911.32135-1-henning.schild@siemens.com>
 <20230425153911.32135-2-henning.schild@siemens.com>
 <ZEoydXMDRONgbhY8@76cbfcf04d45>
 <20230427112106.697dd352@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JKzu/a52J5PxJU+G"
Content-Disposition: inline
In-Reply-To: <20230427112106.697dd352@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JKzu/a52J5PxJU+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2023 at 11:21:06AM +0200, Henning Schild wrote:
> Now having access to some of those specs, i can offer to add more
> variants without testing. Such support would be in patches on top, not
> subject to fixing what we have in stable already. But i would only do
> this on demand and have a weird feeling about it, the code might be
> trivial but i have no means of testing.

OK

Simon

--JKzu/a52J5PxJU+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmRLggsACgkQzyg/RDPm
szo19Q//c1I0Igy5gGYdg2P46oIuQ6YcOukDsg2SnonnZYuHtoYsE70Ktc4XueKd
4Ljm/iBmvVHzkzimhxYtD4/fMUVIJscOJ4tw6EqU4Yx8fCEeA9h6Y2cXy46Zd/if
ngNIixMssM2RryLBUa5emBMBUTfP1+tt4P0u6hfiDB2t6Mi9iY1MmMZmCKQy1XjA
HPHMg+SltG5SmVG+ICPGwjmYZhy6zsnj2bsy+6OY6MZSXJUogNNQgFqpyj/zG35E
XCz44DuTobCpTIGnbLlXDG+snBfow3n5WrKEJbKd85OCG9nn08UtAJDa2nSyFlPp
lhPXuw+1zOYgu058uVs4wp7Uaarv2jEUWT+WyHcoPZD6oBx59zk/RlOTnJeY1D0e
enCTEKZ38r0HTk/507H1xVvBYn+LqXl5w2z25MowxY1FC62SnWrdRpJInpXg06+A
wdaJoTfp9h7cH0XjysfWUCk3PsE5lWTTFjINxmg72tKI3a4BAClISS9rWZW0XtpF
B0WxQ4ye82p4lnbXcHHefpLMI50iyJ1obLvVf06bnjfFKHxlfYca3qO0eAW0zgif
MQC+wn15N3VCsmNzOSjAYzbPrZp3Q78TY3rVk59EpWRexYLUSeqkusivtSWvvFl6
38Yjpequ1FYl1tOfJXz0v3p29O27JE8aLLu7Ci6hCXloabjYyLw=
=flco
-----END PGP SIGNATURE-----

--JKzu/a52J5PxJU+G--
