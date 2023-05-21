Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3370D70ADA3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEULlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjEULgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:36:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D71B5;
        Sun, 21 May 2023 04:35:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae58e4b295so30873375ad.2;
        Sun, 21 May 2023 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684668935; x=1687260935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIeF0Ho4NovaLTv8j0PXxNoLNVguWyAjL6rrIVe8Pt8=;
        b=YGBlhygxVvCZJhvVSS9QDlsvRUD0MtJGp9smEL7MHNlUdUdyD4IALtp1z2acae0Rgx
         +y2nd1KF0Z2/Bae4Jqf2mXr95eMrIs7qIiM7+Q/gwB1l0FMRJm6k26w0pE4fAXJ5dabt
         oggoIku/r1MhLjLPkoRg0iyiNPlfdApothl87cGwvfQCbQyzom6qfUKsOUmRz4W+HgXV
         Pc5O/y8wtI3Iyxzf/Rd9VSdY/ldXr/FS3RWVX4ABn4hrHP4njJ/p4CCk9CUcwwSNx7LM
         UcKdGoZJUcJ7MpUfiQVFK2C8L1ilNF3og8iWlnJUNMT8nMIl6lBXztc1mDQAtHbeEipl
         sGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684668935; x=1687260935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIeF0Ho4NovaLTv8j0PXxNoLNVguWyAjL6rrIVe8Pt8=;
        b=fpq+edppHROU5CL6HdJFfzaWgBIRndlIQgqbRrsSU8fHUASdhyVvnIxWBE9nOOd34i
         wrw3OIUltoxZBomcNsjldxuk3hieqoC4ZQjPL1u1BhmzSaaZQZWfEpoPVJmxxJniKlIj
         vuDCDNOPLYm8PVYG+c3/1thoXGX5ZwR2sI3BPa2eOcPX6l6qxsJBqoj5kArNSJVnOOMP
         4WFnHtBqcssdBn3s0CKTkkvuP5pRF+FcqmFncBo7usJ06q9tERFttaJJmWW5J44+f34s
         KGmtqGFs65eA68gljSQeKdNUz69+hUxn+51WTsnrqwkDhTlePW9MOXxM+Zq4GzUGUi03
         nZCw==
X-Gm-Message-State: AC+VfDz3JrBtrMrIpTfjCQTMTjOKFp7TsfxigMfSQy6X4T5UoTqBxauM
        Zcxe9U2e2VCOSMTzcmYIEnQhLAh9J4VkVtSe7E0=
X-Google-Smtp-Source: ACHHUZ4q5z6zUOxbAakZYvfNK56g4apgtSVmHPxH8oTh7wNaxv+vGOm0HlJvpCeFfBP5tr3QPDTcMApTqKXsvNZ1kAI=
X-Received: by 2002:a17:902:ef84:b0:1ae:5916:9f12 with SMTP id
 iz4-20020a170902ef8400b001ae59169f12mr8731984plb.13.1684668934661; Sun, 21
 May 2023 04:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
 <20230520190856.34720-5-boerge.struempfel@gmail.com> <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
In-Reply-To: <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Sun, 21 May 2023 13:35:23 +0200
Message-ID: <CAEktqcv3NEZKmxBdCjf29JbSbFfTzZB9p0yXF+btVrNYO5XU4w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     bstruempfel@ultratronik.de, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 21. Mai 2023 um 11:00 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Sat, May 20, 2023 at 10:09=E2=80=AFPM Boerge Struempfel
> <boerge.struempfel@gmail.com> wrote:
> >
> > Added the three missing spi mode bits SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP,
> > and SPI_MOSI_IDLE_LOW. Due to the length of the new options, the
> > indentation of the options in the help message was also adjusted for al=
l
> > other options.
>
> Actually since you are touching all of them in the user-visible
> output, you may also reshuffle them to be grouped logically. I'm not
> sure if the switch-case ordering would be nice to have shuffled as
> well. If so, in this case it might be better to have it as a
> preparatory patch before you adding new options (and hence take care
> of indentation in the first patch). That said, just think about it,
> I'm not insisting.
>

Thanks for the suggestion. I tried coming up with a logical way of
ordering, but I am having some difficulties deciding. What do you
think of the following order?

general device settings
" -D --device device to use (default /dev/spidev1.1)\n"
" -s --speed max speed (Hz)\n"
" -d --delay delay (usec)\n"
" -l --loop loopback\n"

spi mode
" -H --cpha clock phase\n"
" -O --cpol clock polarity\n"
" -F --rx-cpha-flip flip CPHA on Rx only xfer\n"

number of wires for transmission
" -2 --dual dual transfer\n"
" -4 --quad quad transfer\n"
" -8 --octal octal transfer\n"
" -3 --3wire SI/SO signals shared\n"
" -Z --3wire-hiz high impedance turnaround\n"

additional parameters
" -b --bpw bits per word\n"
" -L --lsb least significant bit first\n"
" -C --cs-high chip select active high\n"
" -N --no-cs no chip select\n"
" -R --ready slave pulls low to pause\n"
" -M --mosi-idle-low leave mosi line low when idle\n"

data
" -i --input input data from a file (e.g. \"test.bin\")\n"
" -o --output output data to a file (e.g. \"results.bin\")\n"
" -p Send data (e.g. \"1234\\xde\\xad\")\n"
" -S --size transfer size\n"
" -I --iter iterations\n");

misc
" -v --verbose Verbose (show tx buffer)\n"

--
Kind regards,
B=C3=B6rge Str=C3=BCmpfel
