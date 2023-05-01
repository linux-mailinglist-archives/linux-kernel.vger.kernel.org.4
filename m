Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBE6F3272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjEAPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjEAPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:05:40 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E7ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:05:39 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-44066390652so841767e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682953538; x=1685545538;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnXkDl66O4OPFTrH1c6ivbD/OAvfUXLiZ4cFYpE+OHI=;
        b=XI+DIvCVdkSCuAk6bxGj9ZNw72XYA+iSEgR+5A6p7AzmvQi/nOErkJ6hUwEajqfhrA
         s5MQbMU/OHYYsbsO2bqr35wm0/CeS0ZWMfhbRsWkSU1Jgohri/b5+B6otKSAAa2Zano1
         5oOOlE99jPfBP2MXpnfwITOshekl5FSAZRhIUS1FsVfTJjyVls9faTbRZB2r1sutijpt
         D73v276hZ7HWsMo+7leOu7g6bn6zvfA3hJODE7u5oQly7NRdncMMyJV34f6fXzdXIyjo
         zojkU/84tvg7mml7kdf8gbkIuiKkrJZd8lZq/JQZ0hIwaNT7Nl1eLcODV7K/dP3Wsq+y
         bWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682953538; x=1685545538;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnXkDl66O4OPFTrH1c6ivbD/OAvfUXLiZ4cFYpE+OHI=;
        b=BbxnZwBIKWyePenXRQ1ysvslPhxbz29noPPfXCLz34iwulYOCkhBrmUP1Lkg72BUcl
         NjxEN0/7epsXuTPPInkIPCnNq7be4Vzn89Uy8f9Rir4kk9GsJ9uMxP1vsw2evrGBYsQr
         Y1mYU0VfDN0843nrBVIhhCkFnzi7yu3dcau3Cql0oszhwNbwE82fONsfORPKEy5dXEqr
         JCRpE0/+60pLUT0iZ6zNYBTzPqI+xsIvcRXARcoEhya0Ox0rgkaerDsI3gb6PeDP7X2J
         WbWFjVfsa1uNho1tURBt2Wa1qXSSrJ5w5E79nisQBWY4vKVM9KkajUIzs2lP6izQ5Ukd
         uDPQ==
X-Gm-Message-State: AC+VfDxP5GAWtKZkbzx/umFBCdtuehSxe5xPEcEqPDAr2yXr+nBDeItv
        ix2f3myQfw6x81QJ9R8nmzTmU9PUytUkcLFv0yA=
X-Google-Smtp-Source: ACHHUZ588UBHaoLizQEkoKd3YBNfxM1xMyQtub6EHgy7CJI+3VqeTlEnr+XbJzvPTyFG+UOuBzTn7QvzmSKODI96IXE=
X-Received: by 2002:a1f:3d50:0:b0:401:87c8:4a7c with SMTP id
 k77-20020a1f3d50000000b0040187c84a7cmr4456286vka.14.1682953538308; Mon, 01
 May 2023 08:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly>
In-Reply-To: <ZE9ngFLRqLkN6faH@ugly>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 1 May 2023 23:05:27 +0800
Message-ID: <CAAJw_ZtKnZ3QruicqFRG_TLV0Ltbc8LSvdJSCEQRkr5GMSWvCw@mail.gmail.com>
Subject: Re: linux-6.4 alsa sound broken
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
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

On Mon, May 1, 2023 at 3:17=E2=80=AFPM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
>
> On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
> >Latest git pull from Linus's tree ... playing a simple sound file will
> >resulted in a lot of echo.
> >
> how _exactly_ does it sound?
> have you recorded a file through loopback for us to investigate? best
> would be a short sample of a clean wave (sine or sawtooth) with some
> leading and trailing silence.

Just send .. in another email. If the atttachment got stripped off,
please let me know.



> >Running on Lenovo X1 with ..
> >00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
> >Definition Audio Controller (rev 01)
> >
> >I've bisected and reverted the following patch fixed the problem.
> >
> this seems weird. so my first thought is: are you _sure_ that your
> bisect isn't "contaminated" somehow? is the effect consistent across
> several reboots with the same build? does re-applying my patch
> immediately re-introduce the problem?
>
> - this code is about silencing. getting dropouts or no playback at all
>    would be plausible, while echo (that is, repetition) seems surprising.
>    theoretically, the driver may be setting a bad fill_silence() callback
>    which copies some garbage instead of zeroing, but the HDA driver
>    doesn't set one at all (i.e., uses the default one).
> - this code must be explicitly enabled, which for all i know is done by
>    almost nothing. what players did you try? did you get consistent
>    results? did you try taking out audio servers from the equation?
> - the affected hardware belongs to the extremely widely used HDA family,
>    which at the layer the patch is even remotely connected with is
>    completely standardized. so _a lot_ of people should be affected, and
>    we should be getting reports like yours by the dozen. are we?
>
> of course i can't exclude the possibility that my patch is affected by
> an uninitialized variable or memory corruption (or in the worst case
> causes it), which would of course have very hard to predict effects. but
> that should be investigated properly instead of just reverting, lest we
> might be papering over a much more serious problem.
>
> -- ossi
>
> >commit 9f656705c5faa18afb26d922cfc64f9fd103c38d
> >Author: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> >Date:   Thu Apr 20 13:33:23 2023 +0200
> >
> >    ALSA: pcm: rewrite snd_pcm_playback_silence()
> >
> >    The auto-silencer supports two modes: "thresholded" to fill up "just
> >    enough", and "top-up" to fill up "as much as possible". The two mode=
s
> >    used rather distinct code paths, which this patch unifies. The only
> >    remaining distinction is how much we actually want to fill.
> >
> >    This fixes a bug in thresholded mode, where we failed to use new_hw_=
ptr,
> >    resulting in under-fill.
> >
> >    Top-up mode is now more well-behaved and much easier to understand i=
n
> >    corner cases.
> >
> >    This also updates comments in the proximity of silencing-related dat=
a
> >    structures.
> >
> >    Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> >    Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> >    Link: https://lore.kernel.org/r/20230420113324.877164-1-oswald.budde=
nhagen@gmx.de
> >    Signed-off-by: Takashi Iwai <tiwai@suse.de>
