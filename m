Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48716673C12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjASOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjASOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:32:54 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47222DF7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:32:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4fd37a1551cso4813007b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxbmQQnppwWipwY+7UMUv45QxwTbva6H7m4OgO4CL+g=;
        b=jAf0mB3bHlNaeYBduqwR1vVVqS+WYNlZmEDa2g59jQ1zQ5s4Rt73Et8LXdtllpnq4f
         RAnPn83bUgVqODpdayn1j27M58kqRj04/J7DY75PTxSdZdfeAPhZbXR3XS9JpAOxc4lz
         LABBEX47Tzb3k0Uxva9hJztJ4w7HEC4rKhDFcdvrLdLmS75odAOiqH0FC9hPShIFOhIa
         duLs1ec89noN1qlI0didbv10lAKWO44VW7I4hCyhcPFam46gb3ZSQq82dXSMalz6T+wD
         ZHNjkzdUT3XVoI70P+E4zcRFWtcN7o9Sy+CHL4m01advLhRlKb6fKpUZGmgFV9imI9Tv
         BX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxbmQQnppwWipwY+7UMUv45QxwTbva6H7m4OgO4CL+g=;
        b=g+G3CjHZD1EbIJHswFNyLBpr3W4+D6C7e+o6l4F3EYwxExTzFRT01iP09mM3qaSCio
         lvQJGlCR47otCIq0GDFA3/p6pcRAKm/fNaNxZkMpdRST0qCpfo+7bUMaTPtEIFNYGxKi
         rTXb3gXsRDN/Sw9wLExyCoFuyYMUPs+JeDZH2LoHBS17bTswWY3RJQBsb0N/SfLS74nr
         VctkymuEMOgyUeXBA/sGHn8AKadVMPh6UbdXZjagozXs+IZKmrf4FJmUoGwWZwSmGJZ5
         JOVwRPeQA1PW6alNXelkwf3xfnSrFOT9N/04ui3OzomTDrMqe85gasiDEkOr90/lhaC4
         TVBg==
X-Gm-Message-State: AFqh2kruzhJGSxXnh/UCQFX0gsJgpBYFrTa46jBSJsSCszJt8KpwaBgn
        W48FZAO3BBckJc5nNdam9KQzDEqMXu8xy6joPZWPww==
X-Google-Smtp-Source: AMrXdXtJ9W+vaXTePLu279j/F8U38ArAthhZLyHvsMhW95lavv0nHZWowqIK5iJxnWnP9Zyr4/2chS0gedQfh31Vy2w=
X-Received: by 2002:a81:66d7:0:b0:4be:6d20:dc66 with SMTP id
 a206-20020a8166d7000000b004be6d20dc66mr1304877ywc.151.1674138720498; Thu, 19
 Jan 2023 06:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com> <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com> <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
 <Y8lS5eBliYw5EHBb@kadam>
In-Reply-To: <Y8lS5eBliYw5EHBb@kadam>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 19 Jan 2023 14:31:50 +0000
Message-ID: <CAMEGJJ2b1KFQY1m1eTcvf8_kGBBTjzrBD2i_M2uR+6v4gEcbVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Drop custom logging
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 at 14:25, Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Jan 19, 2023 at 01:47:44PM +0000, Phil Elwell wrote:
> > > > I understand the desire to remove the custom logging. I don't welcome
> > > > the loss of flexibility that comes with such a strategy
> > >
> > > What "loss of flexibility"?  You now have access to the full dynamic
> > > debugging facilities that all of the rest of the kernel has.  What is
> > > lacking?
> >
> > Perhaps I've missed something, either in this patch set or the kernel
> > as a whole, but how is one supposed to set different logging levels on
> > different facilities within a driver/module, or even for the module as
> > a whole?
>
> Yeah.  You will be still able to do that and more besides after the
> transition.  Cleaning this up makes the code better in every way.
>
> Documentation/admin-guide/dynamic-debug-howto.rst

Are you saying this patch set gets us to that point?
