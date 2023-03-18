Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00106BF789
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCRD1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCRD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:27:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC203E635;
        Fri, 17 Mar 2023 20:27:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t9so7716859qtx.8;
        Fri, 17 Mar 2023 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679110030;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNIRkRl5zC8m2QTrPNecHQHCMYnZxZA1VwIYi9JlFGI=;
        b=XGoNLpXRHc+GLJ851Rd5Loeqs1kXb33lR4NSprklyL3tgVauAtx6Wv69fuhDAwdiwZ
         2xxThor2GrUH88kV+N/DnY8ey/wuUO//j+qUz2yKdf3q2wj1hJu5hQGf2aNTgqzrQG4s
         ho5TdBycUwPZ5Ff+UbN3j0NO/zqa9Dgyc2/bsg/ek8QHN1KP9gwEFugI6XAeE9E2unpt
         hHPwcIx6SGUKMgUuJqnpxgckp2ILG4SyhAF1Kfj2Oi16T96eHguq4rin5LhOFHrIykOO
         614WP++BocVJ7yM5ApPXq62A3b0Vzp2s4whc7LRV/kSv9/DIqjuYKrZaRs0ZKvQelC2k
         W0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679110030;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNIRkRl5zC8m2QTrPNecHQHCMYnZxZA1VwIYi9JlFGI=;
        b=hmCjXExSvl6FCFd3MnmYNq0wEdz5ojDPHBC3Jo6HsS0WyjRshR8r1yf5oLTWlNGaCp
         jeFhLGPCAHBsLDrNvxfMPo2Zvv41EZZ1usXPLRKHWSSaoKL8fFNshg5TyW3I1MU0w8mz
         WCmELnLTDnv/64CtbMwqHXmfYRJs7lzhmt4sl6Xx+Vy42EZmZV4CxkEfyk/am1uxPrHW
         McvkyEVjaruDspSxBb8vmG7VVMkOAeNHhdPQwmWj8sNTzvDbti6wnLxChQRtXzYpjC4a
         Swuhu2ItDYMZkROK/yb37HcMnk2YR6GJFGNefmf2iVICC/3Ecjuk/5z6NitVUcrppfBf
         eJTg==
X-Gm-Message-State: AO0yUKW3QnrPdo3tt6EYe1/Jqw1zJkKK6Es3hBLkqMlzuhCSPWtLjIOJ
        JnHVSVKlwi/KgqPs+wEoN/TE3ECL/YI=
X-Google-Smtp-Source: AK7set+dNbdG709Jg4tWdvfgTxOCvAjjhrHkkOkiMVH0nRkPV7iwgdevC3nWV3zgsRp5wTcSISbGNQ==
X-Received: by 2002:ac8:7d05:0:b0:3bf:d8ec:a9fc with SMTP id g5-20020ac87d05000000b003bfd8eca9fcmr15758705qtb.52.1679110030313;
        Fri, 17 Mar 2023 20:27:10 -0700 (PDT)
Received: from Gentoo ([154.16.192.34])
        by smtp.gmail.com with ESMTPSA id c15-20020a37e10f000000b0071f0d0aaef7sm2869169qkm.80.2023.03.17.20.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 20:27:09 -0700 (PDT)
Date:   Sat, 18 Mar 2023 08:56:45 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] Kbuild: Elevate sha1sum to sha256sum for atomic headers
 check
Message-ID: <ZBUvddx7PkTZHj4Y@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
References: <20230315130518.4496-1-unixbhaskar@gmail.com>
 <0bbdd88ca0cb465a85d7b90ebacb5e83@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n9V0ZVZceJnPTOYA"
Content-Disposition: inline
In-Reply-To: <0bbdd88ca0cb465a85d7b90ebacb5e83@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n9V0ZVZceJnPTOYA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 08:58 Fri 17 Mar 2023, David Laight wrote:
>From: Bhaskar Chowdhury
>> Sent: 15 March 2023 13:05
>>
>> Thought it would be a good idea to use a elevated mechanism i.e sha256sum
>
>How can this change possibly work.
>It is just a list of definitions read by another makefile.
>You've changed the name of a definition without changing where it is used.
>Also if the code is looking for a change, you'd need to change
>what it is compared against.

Gotcha. Thanks for the heads-up , David. I missed it.

>In any case no one is worried about malicious attempts to change
>things without being noticed, even sha1 is OTT.
>
>        David
>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Kbuild | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Kbuild b/Kbuild
>> index 464b34a08f51..b74040346d76 100644
>> --- a/Kbuild
>> +++ b/Kbuild
>> @@ -45,14 +45,14 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
>>
>>  # Check the manual modification of atomic headers
>>
>> -quiet_cmd_check_sha1 = CHKSHA1 $<
>> -      cmd_check_sha1 = \
>> -     if ! command -v sha1sum >/dev/null; then \
>> -             echo "warning: cannot check the header due to sha1sum missing"; \
>> +quiet_cmd_check_sha256 = CHKSHA256 $<
>> +      cmd_check_sha256 = \
>> +     if ! command -v sha256sum >/dev/null; then \
>> +             echo "warning: cannot check the header due to sha256sum missing"; \
>>               exit 0; \
>>       fi; \
>>       if [ "$$(sed -n '$$s:// ::p' $<)" != \
>> -          "$$(sed '$$d' $< | sha1sum | sed 's/ .*//')" ]; then \
>> +          "$$(sed '$$d' $< | sha256sum | sed 's/ .*//')" ]; then \
>>               echo "error: $< has been modified." >&2; \
>>               exit 1; \
>>       fi; \
>> --
>> 2.39.2
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>Registration No: 1397386 (Wales)
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--n9V0ZVZceJnPTOYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmQVL3UACgkQsjqdtxFL
KRUCngf+PRAc7rGZQ7BkqHCHphzw5U9Tk+UrlbX+sv2yFbLG4tdYHazBbIcZNJSz
PIxZN68OVY4K2WExYlZuUi+8GSy4xlF9nLoxMOLv9oCMHOaiGueGnzgQBjPmixet
PKY4DKkw9qc2BDd7KsVaZQtsjfvjugnrvSYPqvyDPWFJnxRvF+/vY55xunVDPcQX
NZ0xVMI/9vWhM9+ttKgO9SGjauNdhOQrNNgr5CLbXiMKkReT4ddsMy4d89HlJYbd
pB0AOa1vclSW+4iWUgcyjj8qpzTHK84pRR03CqqdrmQgmzxiGH5O2BLXxxXpjPOT
OONDb8Z1Ks65i5g+UXfMYwzhjxfzmw==
=95ci
-----END PGP SIGNATURE-----

--n9V0ZVZceJnPTOYA--
