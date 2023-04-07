Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72866DA81E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDGD4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDGD4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:56:51 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE064C2F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:56:49 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ld14so568056qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680839809; x=1683431809;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvnQQSdztXm6KMkGZj+1rqw+ogwyv2W9h9DqnICOnJs=;
        b=P8AAigS//qwdpn3hFFDbDhqeYQ5gBCEFZdF4ByRVIS+FffPcsadM0oKKoqN2F5Ozqa
         hjbbD4+G1fDq9uK3OiVlQxafxDizcGgWQTIixwS0bU+cV7u8PoSVQz+JwXwgjeqsRlYh
         bjVG/mGOyFP+jYcrcokQejHxZu9wyiPZ0Mu+UvaZziiUGTMf4r75b2+luh3o9VRrYA+F
         candlc0y1AjF0MHaLpNx7mSXa+GSKfQ0q/LG9aJJwKmlLAZFxyTJnvX3sbzbXTtr+Mxk
         k4WUCieFygVAqBPku8lyhRdaRyLgOWzKdywuKmKBr4ENOV3/bgpvrJ31NlQYwngm3Pjq
         2Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680839809; x=1683431809;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvnQQSdztXm6KMkGZj+1rqw+ogwyv2W9h9DqnICOnJs=;
        b=gpaqak5ZImy91p7EaN85MLZrDfJitJGISX1mlP+jQlqXKKqtOOTqkc4KmLNvKIUmVg
         g4TelaTnRI3rSO8YyXpH9sIzrbxwvursKtHS9hAZg9Qyp4ZeGKeHJ+ZcQdukMXmOW5eS
         F7dvomhiQ8tasmw0t8nKfZlkH7O2zKtKXBuIMtTBTWM/uIGCC4127sWtGPkLWnWKQdHu
         GZg+iqUYpNwk3Lp3KOY0kzx8C+YoUoT5GNd1zpmFuC3Js7+9XsvDK2bnN/RCdVQjn6ZO
         5YKz106JM2bDu1N/Gl77XFieS8psCmg/eTBWXKK5R0gbBURrgdv9pLkF0hXiN+cqLeNy
         oTzg==
X-Gm-Message-State: AAQBX9f/I4yL4rpWXH4OksIoI/b9oPgMWR/+Lorti7NlkWrxfECx6qmQ
        a3nMAWuZ2MPXIlHBMriLcwhABC4Bo9k=
X-Google-Smtp-Source: AKy350Yr+ZSqXJtoIyhHBrNiqVbDU/JBJlATEABXF7RjnNXbCcp8roz1o4So+IgeLih7NmT5vEMypg==
X-Received: by 2002:a05:6214:3015:b0:5ac:58cc:69d1 with SMTP id ke21-20020a056214301500b005ac58cc69d1mr1975953qvb.31.1680839808667;
        Thu, 06 Apr 2023 20:56:48 -0700 (PDT)
Received: from Gentoo ([191.96.227.146])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfecb000000b005e45f6cb74bsm1033268qvs.79.2023.04.06.20.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 20:56:48 -0700 (PDT)
Date:   Fri, 7 Apr 2023 09:26:25 +0530
From:   Bhaskar Chowdhury <bhaskarlinux73@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Thank you Willy!
Message-ID: <ZC+UadaAz25EC8Jh@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <bhaskarlinux73@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
References: <ZC+CVYgKzer4NElF@Gentoo>
 <ZC+JhjYn/TuLdydk@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZZou33pwPfMdkUKv"
Content-Disposition: inline
In-Reply-To: <ZC+JhjYn/TuLdydk@1wt.eu>
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZZou33pwPfMdkUKv
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

O 05:09 Fri 07 Apr 2023, Willy Tarreau wrote:
>[ dropped Linus and Konstantin who have other things to do of their time]
>
>On Fri, Apr 07, 2023 at 08:09:17AM +0530, Bhaskar Chowdhury wrote:
>>  THIS IS A REAL HUMAN HERE..and who is concerned about blocking..
>>
>>  I am getting spamassassain blocking for sending mail to kernel.org mail address and
>>  the mail to list not showing.
>>
>>  It's been happening for last 2 days.
>>
>>  What is going on?? Why my primary mail id get blocked???
>>
>>  My primary mail id IS: unixbhaskar@gmail.com
>>
>>  It also led me to think, what have I done to get blocked here??
>
>Bhaskar, I can reassure you that your other addresses are not blocked,
>we all have the pleasure to read all your tests... Your test messages
>even represent more spam than the rest we get from the list. I'm sure
>it's just your filter that is causing problems (probably that it rejects
>incoming messages from your address), but please use another method to
>run your tests. There might even be dedicated lists for such purposes.
>
>Thanks,
>Willy

  Thanks Willy. My apologies for "Your test messages even represent more spam
  than the rest we get from the list" ...that was really not intended. I was
  concerned because of not seeing those in lore and in mutt client.

  I do not do any kind on experiment on this list and or any other where I am
  subscribed too, in fact I told people not do that, if you can remember seeing
  that.

I am sorry again for the trouble causing to everyone by my real concern.

Oh, btw, there was reason to include Linus and Konstantine.  We are all
busy,so know when to include whom and for what.

Willy, I am really happy you help me(you did it in the past too, thank
you,honestly.)

  I still need to figure out why I am not seeing those mail in lore and in my
  client. But I promise, will not send any "test mail" again.

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--ZZou33pwPfMdkUKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEs7FAjU4eq1yogJSEAkGeLcGNq5MFAmQvlGIACgkQAkGeLcGN
q5OPYwv+O2AfXxCFTxDl5CfWCd3pHhniNZ12Eftuv9KcemqJ97pap56HufnFSKeh
zlcePn1vbDfPWEEiztXbdRbi9nQBR3VOg720hdOg+MylxQ+953gk+xLCEQzZ3Fzm
2Azi1uYvMOMgz1EKMcFB/q4Qg11TC3I2xMoGec7frJlrRwCIntOlTKq5KxVD9COT
ZnjCIKr6bxgzv76QYimXLiO+BT2r8WQBBjsAU5ra41WxGaO3e5jce8G2/2cUO0ei
gKrzX+EgDwlny38NcIB9AfuQ7sS+2gGxCPcLOxGA2zOSxOuWct4xGF2gHmSFElr3
7czLwd2m59DUJvp+vLRqLLkKzzLTvjDcYIjQGUgqUuEpGBHD6lj0SyURPH5rvj2M
tFO9UfO6qi1p46qDIGq9DQUpNIyIYG2VdFN0LWC1WBAbGrbIe1ITrmLpt5rH7OcC
vRbeBz7sk74o14DevfXp2zKfxNzfO03f4iNuob2fQQYW9mIzX3eA9jY2Fv92dANw
ZjMd0kcC
=he2z
-----END PGP SIGNATURE-----

--ZZou33pwPfMdkUKv--
