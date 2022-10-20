Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E1605C00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJTKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiJTKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:15:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35D1D79BA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:15:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f8so12456614qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QwJgtBGQmZdLQupX+ESzBTFLWc6n9kUQz57Nvp54uJo=;
        b=WjJRlkVwDhD5PSVz1u9sMYo53DGbNpPiqdwbF8DP2N2sVl5DeBvNoQBiho7Izg6l/y
         fz579yHz2NjGfna2wVbnnV4B91fz3VnH30TwNqwi+QsSbYqI+eX11Tm2n+dPKEKhvoPI
         b0MVjjPLaZIUHETpAHDw4v1MSBInxw5YbCwYzHsOimSoVQsoVBXMvCKZ2E8/B5FCckzE
         aaX11127bsTkYVoNJj33z4B0KEEAXrNGdBBvINDmjGiRwcFFRjWFI3fSTfpW1W/suU7h
         ejZ9tEhCcozNmh0c1bq6uAS7bTnpKs+6yYTj1SqRKLJk7vqN7c0MI0nb2tozCUExRHen
         6zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwJgtBGQmZdLQupX+ESzBTFLWc6n9kUQz57Nvp54uJo=;
        b=aB03Mh7/8XphVjVdmFElb1GZ4SS3tF24rnRstO9+WS7+r0uwYrQ5Jhr+WZIOvqqRUn
         pN9VeI4ca9e/dJ8Pz4QhWvDKR/JDNk16npaInqZszhk+NtzHa2JaUl5qZKwj5fXGc0VT
         B9BJAGP+QiqAuiy+3Jaj0vcna+dP8pZ2OnFmz+GCMSRn/jZ9n2Y+1fN7p9mdAqalayCf
         rK6hWYYqiQsx+c3dGPzWPyPvZdQKshsiV7sdPVOzpqL9Ewsto+PSAi/27DVx6VMGnX4e
         tpYhTGPICO0+SVfxAPed+OUDnLzYnEQJ9zJt6297zkmOuaRMTuoL2QDIwGGBL30rIQc4
         f4dg==
X-Gm-Message-State: ACrzQf16C1kKhG1OOKiSkEYImabT2AyDDHacsq7pSriX8Jxciv35Rccz
        fPAbQU2Y63W6MNky3JlL/vy/dXpSEHOM1rJazBs=
X-Google-Smtp-Source: AMsMyM678yzTbhZ6Wi35yGYH3+/dUCyMJ2QqvzaXS5CMEpyZXZK9eRLCliTGMAJ7WaDpOQE+ec0KBqq7mWEi2x1gKi0=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr8532799qki.158.1666260950158; Thu, 20
 Oct 2022 03:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <20221019223446.GA154747@nam-dell>
In-Reply-To: <20221019223446.GA154747@nam-dell>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 11:15:38 +0100
Message-ID: <CAHJEyKUsZ-V0waEwBEy67g+MNMR29MGJbBx3qCA4axKyPk9RGQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: vt6655: Fix Lines should not end with a '('
To:     Nam Cao <namcaov@gmail.com>
Cc:     greg@kroah.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:35 PM Nam Cao <namcaov@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 07:20:11PM +0000, Tanjuate Brunostar wrote:
> > Code style warnings reported by checkpatch.
> > Improve the layout of a function header:
> > Put the first parameter immediately after the '(' and align the other
> > parameters underneath it.
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> >
> > ---
> > v2: put static and void on the same line and adjusted the indentation as
> > suggested by Greg KH
>
> I think he meant putting "static" and "void" and also function name on
> the same line.
>
Oh I will do this now. thanks

> Additionally, I think your patch introduces new checkpatch problems. Did
> you run checkpatch.pl on your patch?
>
> Best regards,
> Nam
>
Yes I did. the checkpatch says this:
Alignment should match open parenthesis
#89: FILE: drivers/staging/vt6655/rxtx.c:89:
+static void s_vFillRTSHead(struct vnt_private *pDevice,
+               unsigned char byPktType,

The only way to resolve this would be to add white space which would
generate another checkpatch problem. how do i fix this please?
