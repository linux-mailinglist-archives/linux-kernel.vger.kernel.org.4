Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC0606C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJTXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJTXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:38:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C322BCA1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:38:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g11so684542qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E55XoWUaVDnxpFIJDCFRvowoELsawjlqr/w1P8FEANs=;
        b=bbIrzgcSdvvamus7DMiU1ZNBsiCqboId9FqWEH95Z+qXjRXTjQB4cdeG4UJbO1qZaR
         uONLIrn/X+ovat6AHrYGbugk9s5MP0p7Pkgnchj1XfhasfHwCHEVhrPpOLhLJhpzADsO
         i8BObFmZatt5DolCH+zvzupTXiQAbCLQRzU2TAWzQndBhEkAVwoShYlBwpVQktg6DGMY
         A/ftOjqQGbzpsKkZTfFcIVPv7zYpR/ULjUMlYY5Rrk7QP2sOEcFRi6PP6TAm2KZaIemS
         bAVUpt1Q/EALr6EQFNsp1t7VZjf+ocGwpwfCn4AqbKPzUu0RRTOSLE32tqmGUwnKUHxY
         osNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E55XoWUaVDnxpFIJDCFRvowoELsawjlqr/w1P8FEANs=;
        b=Dl46HL1YfpxImtYP7N6+RyMr9sjf9RMhcfuMFBXYdvxanJAZNXrFiYDSlrb2WloCOk
         KWCoAzMk+GRDOgIjY46RWaFZ6WkIC4GrcFnDlaf2leq6iWWZtoJU4iaaBZM+VrgyKWqW
         5veX3ryf9APuOM4WYQPPVv2irFiANod/lepQ1IBpVcycuvrKwD1OnsDdOX7v9Ir+soP1
         I7l9f8c+HCMVkGgeTd+Z5WqSXPzmwVE/NsBoY2/CJXiUqcLLrbU3KBnfOlmBFEeiCya/
         1wYy2uOuxdvPR+OU3ORnqRLDkpKDCnUNW7hClwgKMwA8ZIlUq1LzeOhCu2KEyadySbBn
         LjUg==
X-Gm-Message-State: ACrzQf1n4BlhJUU3SRosiQf+3U/+VPJWURsuBqTebBtNs516Y0ozvi2+
        an8pbEz4Y5VTditQzmMmT9zWpzkYwpk=
X-Google-Smtp-Source: AMsMyM5NrMa5VEmi/7kwh88DsplR+p4ZxsI/POHShQ5AmiSXiGVm4rWYUfraJoR7IWnGFPcVpa4jPQ==
X-Received: by 2002:a05:622a:310:b0:39c:dc1f:dba6 with SMTP id q16-20020a05622a031000b0039cdc1fdba6mr13067802qtw.121.1666309093503;
        Thu, 20 Oct 2022 16:38:13 -0700 (PDT)
Received: from Slackware ([37.19.198.199])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006e07228ed53sm8639663qkp.18.2022.10.20.16.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:38:12 -0700 (PDT)
Date:   Fri, 21 Oct 2022 05:07:47 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tanju Brunostar <tanjubrunostar0@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: Request for assistance
Message-ID: <Y1Hby38PE/QVlRhF@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        Tanju Brunostar <tanjubrunostar0@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <CAOkYk0iU0B98JsH77avky--AS19V=GhQox2f_b4PAG3ZBB+SVQ@mail.gmail.com>
 <CAHJEyKX=yyuyYFajs880CuPdc019dBOm_LCkgXHzjFaA-Jgt2A@mail.gmail.com>
 <Y1E6qYkzkRxlloNp@kroah.com>
 <Y1Fds7BJjY/OcwU0@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VvOyAvInKJt8bzX6"
Content-Disposition: inline
In-Reply-To: <Y1Fds7BJjY/OcwU0@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VvOyAvInKJt8bzX6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:39 Thu 20 Oct 2022, Theodore Ts'o wrote:
>Tanju, some additional hints.  First of all, please don't send cleanup
>patches to address checkpatch --file complaints about overly long
>lines.  It's generally not worth the code churn.
>
>Secondly for code that *you* are writing, think about why you have
>lines which are exceeding the line width in the first place.  Is it
>because code is being nested too deeply, and perhaps some judicious
>function refactoring with good function names might make the code
>clearer?  Would adding some temporary variables that are judiciously
>named make the code look clearer?
>
>The rules about "thou shalt never have lines which exceed 78
>characters" are rules of thumb.  The high level goal is to make the
>code more readable and easier to understand, since good code is
>maintainable code.  And sometimes it's not just about where to split
>lines of code but whether there is a better way to structure the code
>so that long lines aren't needed in the first place.
>
>Cheers,
>
>					- Ted
Righto!! I failed to miss it my replies. That an editor can be trained or
customized to that way. Especially , vim and emacs.
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--VvOyAvInKJt8bzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmNR28sACgkQsjqdtxFL
KRWmswf/Z7e2ctZTBPECGFqW7rXTEGHaTbPSRXcrRc4Ssv+ufcWsqWiVP+63rcYd
YXPQlDny+ofreXCx+xvyboWv+J19ERIm9WsOicuiWC1FRa9679BzsLdEk67gYecV
zL1ygvEk0yb9gQBuA1SQ64sPtrrQlZ6aaABFhUGF82RMiElfree1MYVSr/sJm/SU
iQpWKEdSgjU/BGjk/AobysU83E32kWmZbBf5i523Q00e/H70D/gyj3Kd8cIETXt2
hWhRX2lLZtyWNAwBG8LBUpzcq2ci1NZ20+Y4KN/iMvwopsjOizwvCO6EpLMalMBg
yiDAx4RaLElFoyzsQllBgQuE06h+KA==
=BqWI
-----END PGP SIGNATURE-----

--VvOyAvInKJt8bzX6--
