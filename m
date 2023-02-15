Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1C6974AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBODIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBODIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:08:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B12AEC6C;
        Tue, 14 Feb 2023 19:08:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so502845wmb.2;
        Tue, 14 Feb 2023 19:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su9424YoBxSQcViqvaKYQEHxA3bGvgoNHQj7IVpByqA=;
        b=OpMwd7hw8avSoK21Xlr1VoYksIZrEzOf2u5CSDqMW4hSELEmEWYFQh5PHppSUs5Pbz
         V5ZwnejzMvrwmzBOoX03u6Vpwce1zpGNMKa/gM08UxEV8xbVJJ3HKDxuXHZDTYy0Mnf4
         RAe1LQcBoHiGt8qJcwXRvt3ob7YA05ZDMaVk2+bMekLSoBNR4bfnVKjReaaMB2v2UMBN
         RQeHCodamGq252Vf4W+jV31M4PLaKVxXZXe2+fOknFCIk/f/0VBMb+D9J57gPJVPpinN
         NqFML1S5BXqXW7SvcOTM9/wWEEUoejvR7rjp51xH7JmA2l/7QWTx/Eqv0dSTaOE1obL+
         DwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=su9424YoBxSQcViqvaKYQEHxA3bGvgoNHQj7IVpByqA=;
        b=hEIYV20uIipDYxbx8NxBpmLnOuc/PYDtIDTHTUHOt5umb53UYtRu863R9V6lsgCUjg
         7mJ8ZYvEQ41IvP6t8CD1xS8CEaddfLJgd3zNTYwLwi8p3CyqfkxIZQjPHPiEj23LACFx
         LhWkXtjafDn5LJgmR3rO6m4jcrN/Lz20EYrluqMUEspzIskmX63aztzR60b6sDjw0tLa
         1dJXSRU3KOW93KzDRtfjU2J0jUcPhuRU2sUa1Vh7LW2PkxJw+DVDbCNFFCD/I0odQ00I
         s9HQEWUXtMN9b9tAH9QJjezvWo7Rdjfcx1w3B3GTF9cNn48oCiaFbRUAP6Qxpz7YzfNb
         u8EQ==
X-Gm-Message-State: AO0yUKUAKElZOtsyHupzvHNRNAK/oW732MOl5/O5XjLKIaJC3LMSKDTV
        oGxaO4FeLxhybjz/ibqLBW0=
X-Google-Smtp-Source: AK7set/L+MQGVTyaUuRP20kIVxmEaRfXmhV9V3VwBnzc0xobNnbWSI/TRC828CyiLS0qA/roIctndA==
X-Received: by 2002:a05:600c:90f:b0:3df:e6bb:768 with SMTP id m15-20020a05600c090f00b003dfe6bb0768mr673339wmp.24.1676430492844;
        Tue, 14 Feb 2023 19:08:12 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003dc433355aasm610168wmp.18.2023.02.14.19.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 19:08:12 -0800 (PST)
Message-ID: <a5eea3fa-11be-21f6-4e7b-617cb7ff428d@gmail.com>
Date:   Wed, 15 Feb 2023 04:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
 <20230215022150.pxuhdbx2zdwjpems@illithid>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230215022150.pxuhdbx2zdwjpems@illithid>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HODbdDx8hfy3XMZz93iHTtYQ"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HODbdDx8hfy3XMZz93iHTtYQ
Content-Type: multipart/mixed; boundary="------------Mc0PkVedZaiiM9zPTZrtIKGR";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man <linux-man@vger.kernel.org>
Message-ID: <a5eea3fa-11be-21f6-4e7b-617cb7ff428d@gmail.com>
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
 <20230215022150.pxuhdbx2zdwjpems@illithid>
In-Reply-To: <20230215022150.pxuhdbx2zdwjpems@illithid>

--------------Mc0PkVedZaiiM9zPTZrtIKGR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Branden,

On 2/15/23 03:21, G. Branden Robinson wrote:
> At 2023-02-15T02:52:03+0100, Alejandro Colomar wrote:
>> On 2/15/23 02:20, G. Branden Robinson wrote:
>>> [CC list violently trimmed; for those who remain, this is mostly man
>>> page style issues]
>>
>> Ironically, you trimmed linux-man@  :D
>=20
> I didn't!  It wasn't present in the mail to which I repled.

Hmm, you're right, Mathieu didn't CC linux-man@.  I guessed somewhere
in that big list it would be there, but it wasn't.  Thanks for CCing it.

>=20
> This did puzzle me.  I guess it was an oversight.  You might want to
> re-send that message of yours, and/or Mathieu's, if it lacked it too.
>=20
> Or maybe it doesn't matter because lore.kernel.org finds all.  I just
> used it to track down an exchange between Michael Kerrisk and me that
> GMail refused to find even though it was in my inbox.  It showed me onl=
y
> one thread, didn't highlight the specific message that it thought
> matched, and showed me the _wrong_ thread on top of everything else.
> The word "constraint" was in the thread I wanted, not in the one I
> didn't, and even when I quoted it I was served up an incorrect match.

Which reminds me that I hate searching in the groff@ archives.  It's not
because of the search engine, but because of the thread view.  You are
artificially restricted to a given month, and you can't see entire thread=
s
in the search engine.  Is there anything similar to lore for groff@?
Other GNU projects can now be searched at <https://inbox.sourceware.org/>=

such as <https://inbox.sourceware.org/libc-alpha/>, but groff@ isn't ther=
e
:(

Cheers,

Alex

>=20
> Clearly their AI efforts are going swimmingly.>=20
> Regards,
> Branden

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------Mc0PkVedZaiiM9zPTZrtIKGR--

--------------HODbdDx8hfy3XMZz93iHTtYQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPsTI8ACgkQnowa+77/
2zIjbRAAg7YpJUp5ewzGL6dV4VoiOe6LN+/yXHBvn0xyxUET1JF876SMXNcRfLe/
KgAD3zO1/i0v8jFSPDkdGq17dyta5YPXXSnZ3FjzV0cJSILtdmMB4UtTsYhRnFX1
D4yhcOoyeI+K7An5AxAXZupno0TamogY6473g4gzDzlhFFpNAddWzzqJ7VrBiixA
83YjmWHSwuzu9+UAZjC5n1KIUZpa4bnAMma15Zhk6x5Bs88kYthBzNvT51cnghm/
ASPTYqnyGWClZ9wi9tgoXUfkHIR7x/N07K9c1bttuf0cIE+hk3kT7ExJREXRlx8V
QXKWH8gL2K96PiLgjJZQrDSUXLsxTPEWmjFKb8nPtyd+m5lyUXdUS/hAHJMDLWka
fJf0/4mK1kRLzBhoTXnkcPB/MH15AtgT3d3E/X8IcvuZc6WuCLB5GRPT9CSwxIyb
E+1oj/+iVd32Qq7cfOgz5e8bu6da94tV1lUb8O7bvnj6COu0KfXQfUyz/eXIcgc3
32u5xm+iAdtNVpsL4BvTgala/6MWu+yXTHQn5haH/UjsW8ZVKSQI+OUgHkPLdsj4
myFE1pGAUu3bDk7BVJQA3ini5m84NnnQ1UbF2bGy7iW3wPSzKtnqwL5rr2T7+TVg
7hFtHNCVVmIyOblgVcevniBDeYKgtVyD2IhAPFJ8dal12EoKOps=
=lLEo
-----END PGP SIGNATURE-----

--------------HODbdDx8hfy3XMZz93iHTtYQ--
