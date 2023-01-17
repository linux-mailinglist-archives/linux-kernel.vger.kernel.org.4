Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD866DE70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjAQNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjAQNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:13:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4761136095;
        Tue, 17 Jan 2023 05:13:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z9so4413918qtv.5;
        Tue, 17 Jan 2023 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b79N7KJMhxkT+qW/OfYVFkH/B+UqS+gV4VbsqmLlPs=;
        b=Br4CJJdkJhXYVJrBL9kTCUPwZ2UWWoW8o/zZKTOKTu5HjOJJPT5DAXrg0kyd+PCez5
         gfNPaS9pIgO1lxRgNOdMv3flCpFAwS7VljdqxyfGvPQto1xMPpkFytUWwjR3XMasQtvV
         5+IwTFVmZTGfUVVpAalM2I73pBA0R6Mpbp3GZbQlW1Wj1VWy/lkLH0I4TWOh8I0Cjiz2
         GZSBYHKn1RMLy5ocN2T6waHqYhvWWdJ2XzbkO9C0SAQRS6hrEUk9f15KNYvZSOr4wDCY
         7laeNbgQnvpcRrvRt0qIsQaeKtNHSuWPip5/pAUsQAfvRaE7CLiiYcbQutf0hAWj4IPH
         bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7b79N7KJMhxkT+qW/OfYVFkH/B+UqS+gV4VbsqmLlPs=;
        b=1kRsBdxaXWiOSdvfTwepnh+yELpdDu+KlSMEluWDXT2Br5OdOQFiz8oq6Wifv5X9Hz
         fBCW8YXqL4NRgb1E2DzOer+OzAXU+v9w7eppdsdxpVKyHYsNy7WgGJhaFewUafkhznTQ
         H4w7VP9y3Ahyxgphdyt9N9fl3SBuSjuT57AuljJt7milpgWZfxBQFBKNPCA48og9uHLZ
         iDCDSAtvQAdy9h50gc2dtj/lCXWhClyD47qw5Ofo5TzDTNcxA00P+Z+G8IYaDhr1vlDk
         3oKxZ+xJHPoDBTXGSmcf24LPCVJYlsZeU4g45k4Z6J8y4+pabOf129a1Yd5BPqYOW01W
         g1Ww==
X-Gm-Message-State: AFqh2kqk7XKiwyT9zC9ghBeeiw/AjUeUNmpKR7vKfZBs18CQgYvx7GS6
        lxNT2XCX4dIkANfDtxC6UVISkyx0niq2Gtub48o=
X-Google-Smtp-Source: AMrXdXvYbvRHhebhi05nP88q/h3NPgYCbBXJwUUlkKDkoWULG81efNjQrD4K3ofikMz29ir7lkW3G41nLnl80hcVhxE=
X-Received: by 2002:a05:622a:229f:b0:3a9:8c90:dce3 with SMTP id
 ay31-20020a05622a229f00b003a98c90dce3mr86701qtb.39.1673961205133; Tue, 17 Jan
 2023 05:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
 <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com> <CAHbf0-FzLyQeWN0ii2-2TqMg+5ptVsaoAjqrNe4ceXG_MtNeqA@mail.gmail.com>
In-Reply-To: <CAHbf0-FzLyQeWN0ii2-2TqMg+5ptVsaoAjqrNe4ceXG_MtNeqA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 17 Jan 2023 18:13:14 +0500
Message-ID: <CABXGCsNDYNGVKHh50SneQwdd5A4oWT2=Fb1r5YsO=N9W5aGA_A@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     nbd@nbd.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org,
        sujuan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 6:06 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> I can confirm this fixes things for me, thanks

Sorry for offtop.
Maybe somebody knows, is it possible to extend channel width to 160MHz
on this chip?

=E2=9D=AF sudo iw wlp5s0 info
Interface wlp5s0
ifindex 3
wdev 0x1
addr 48:e7:da:57:9a:33
type managed
wiphy 0
channel 44 (5220 MHz), width: 80 MHz, center1: 5210 MHz
txpower 3.00 dBm
multicast TXQ:
qsz-byt qsz-pkt flows drops marks overlmt hashcol tx-bytes tx-packets
0 0 0 0 0 0 0 0 0

=E2=9D=AF sudo iw wlp5s0 set channel 36 160MHz
Usage: iw [options] dev <devname> set channel <channel>
[NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]
Options:
--debug enable netlink debugging

--=20
Best Regards,
Mike Gavrilov.
