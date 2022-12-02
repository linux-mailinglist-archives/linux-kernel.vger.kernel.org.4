Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35D64026C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiLBInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiLBIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:43:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E88B181
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:43:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id cf42so605811lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJToihEiUcVXwRAJ1c8msUWQel23R1+948Yhrr3xtog=;
        b=cUlgBrg0ISSRUvPbqeZjNQjMjhLhDJLZguXc/lAtfPdkcsu8KiQlKbafXFAAnH7Ogb
         IWjzskhipn2EV20shhFpJjlU8EteLt7TUKCbROAyOLODeTq8K4GNioI8CttscvInracs
         hfqNaQH3kxIbJA6wrMUwWBvp6ygD/jXh7O9ciGFrn9UyK0CuuGy6/JQjwHD9AgsTyJC8
         5jE2Ll159diSgKE/4xXNChspr47HjweV1zX1Z4le5zxU9kJ2WWBpaavQ9Bkj+yO9fTqZ
         ub8jGNKnOJzDH9MC3akfJOhSzsaorUyZFFZywOnkqsE3mE+v42eMi+yez74NFgxYcL+t
         uNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJToihEiUcVXwRAJ1c8msUWQel23R1+948Yhrr3xtog=;
        b=NGa3hJnmT2hT96EUWSGjRlDifexYUqfum8QmxYNqEEaQq9L//r2aSDYjdeOpMGg5dE
         yhMGQJkJkvGi0HN9qngxLbFNibkeHr9qpfq9FMMOMZ30knsKICQSZSYTN2TYlbGGJ1Z0
         gLXAB5y0mIwf+NDd79sSW+KKO3u3UOUk8Yz/GhoaYOH7v9qC0ib7LLfbTQq8EeQ3jCS4
         Tlfalfe8yWl7t5PWFEEOwGC1ehBGFcWcO+AHZ9D7pWMh/geW0yuIoHZDB2+VW6ZL4u60
         VTQ2ywYRGPSJNWQRUQZLyOyKu/qd3xjG5hpWP96DAjuiIo9Jd8HvIiLdLvdKQXQJ3LP9
         M9EQ==
X-Gm-Message-State: ANoB5pnucZlC/QFBhXEfrXLR3Fz5JmiS8yX+NoJoqTzRwg3D2WxwakvV
        Q0Gs6pkOU0/G43TTZYBl+Pc=
X-Google-Smtp-Source: AA0mqf5EpmRO1lDVLEYZ6aA64RsS7OhecEJy8COokx89Blxtk6VAzibk7XpDtweaRJ5GjG7fr0qxYg==
X-Received: by 2002:a05:6512:34c6:b0:4a4:71b5:cbd3 with SMTP id w6-20020a05651234c600b004a471b5cbd3mr24862012lfr.518.1669970625631;
        Fri, 02 Dec 2022 00:43:45 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id v13-20020ac258ed000000b004b48c977d8dsm948934lfo.125.2022.12.02.00.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:43:45 -0800 (PST)
Date:   Fri, 2 Dec 2022 10:43:34 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Karol Herbst <kherbst@redhat.com>
Subject: Re: [BUG] lockdep splat using mmio tracer
Message-ID: <20221202104334.649dacdf@eldfell>
In-Reply-To: <20221201213126.620b7dd3@gandalf.local.home>
References: <20221201213126.620b7dd3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nz+X/b9TCsnTswyM0Ms.rQv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nz+X/b9TCsnTswyM0Ms.rQv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Dec 2022 21:31:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I hit this while testing ftrace on an x86 32 bit VM (I've just started
> converting my tests to run on a VM, which is find new found bugs).

Hi Steven,

sorry, I don't think I know anymore how mmiotrace works. Surely the
kernel has changed in those more than 10 years since I last looked at
it. If I'm still listed as a contact for mmiotrace somewhere, maybe it
would be best to drop me?

I don't mind the emails, it's nice to see people hit or touch it, but
I'm afraid I can't help.


Thanks,
pq

--Sig_/Nz+X/b9TCsnTswyM0Ms.rQv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmOJurYACgkQI1/ltBGq
qqeQVw/+KtAe9E+bREDOPpeUdemrIFLt2pEMNvZrdnFIf7r2jCNJB94T3hkshND3
dyYtmphe43w9G5DjsIf9+rfENuvL5n0IZqSgcEGLMbOl/og+yfmC1gwX4U488Jub
5oJuZYqBiAY6HBK9thzoBVh0HKqGX4c8ZRlx1zlDVU5l/c3uUj6Yi9uPB0k8d3wu
TKb4RMo33RBAxYPROJ61Q2G7VbNw1G+qHlZQKdxHizjcOsoLb2eeavJrJQvKneaF
dnzzh4e4R/oflTQESpOd4+alKsYy7YXt/vJZj3CkhYeVcyHbRLZYGiiOHB3NA2QC
/TmgkXyyr9B9/9SOV37rVghcjVnY1r05SdlOuMbDQwi1ZPfDZZ65+sL7RGVvykNr
Wlh7NZYlUGML8Kq+JaaB0CW4kmk3TzN5Um4q1DVHQLfecyniImRvHyCyIDIZmNOk
1Mz0bBMNmcfnBuDjGwmtmmOed8B30V+wE0JZkQ1WHpGI9kL0lhsWu1VCHRekqCyx
s2jWLmnvJWdRjAtXYqQxqIJPv0tmdsLDFBDtDL2q7vgEzjIfw3px9s+IRW51BTdH
Gkp6rla6KgMI688Xq31GW1F+kJesvX8GHBfwQ1hWtfo5HbhQVZnMeUSA1sp2hSd8
rTic9+mdM1BNgcC/PM2lxNcprqjKQ4JkGGy14MXxWfmjkJVVBWo=
=QPej
-----END PGP SIGNATURE-----

--Sig_/Nz+X/b9TCsnTswyM0Ms.rQv--
