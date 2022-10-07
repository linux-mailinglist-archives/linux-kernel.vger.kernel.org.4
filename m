Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B55F74A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJGHTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:19:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364FC09B1;
        Fri,  7 Oct 2022 00:19:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qw20so8770148ejc.8;
        Fri, 07 Oct 2022 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lknl2bbejKIQb1Zoi19TdokFshSnqIa9OlmWLCl6ULE=;
        b=XmXzY3hCnSM5f8YKuCFrg74zTouggm2xO+sPdVQG6Ja9DO+Syg4mg2BDaqKkai2eeN
         EP01r65PzbxLBjyvTZhl9zQtVhYtEA4BP4m6hk6IGpXYWQI5YciAi6DaCjh2ejGO0m3u
         yM3H/e/sLWl2RjuT/Jz6g0RWOkSRSIW0hljRm2A2xKG27zMIFKaslsPFrjWYHE6BjhA3
         Ww2mWJJvFP1jH6SenJyMZNjusRS9HKnuxEx1XMyqiVFHxOoYMPJkgwPMshMgdz5gfeSK
         yxNrNbhjc/SGGsqXWgDkn2i/Eyy6z3qf9Z6YQV9vwlvBoVti/yJMNCwB01Fmh9kgSVEu
         zVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lknl2bbejKIQb1Zoi19TdokFshSnqIa9OlmWLCl6ULE=;
        b=VhN96S1xtM4EPVjuPbphFoo/OriQeqk3KHrI9K2+XSN8LQbG2BZOLRRhCikH6iHaXz
         NXptV0TO800Usmo2osnMLWDAesTeCkYdZHjZb2UxSSvkebJSVQSbhL9Kka40snQ/FdtR
         y0CgE7QMbNVudCpRwLXR0Ag5TSKftrmGTGYALxtokNFIK1AaiQu8jcBwQp6tqdALzSUk
         0o4X6Ex5olzSzSDFzwOCQcCzev7YAYbBGoQbiVl9A61ZOt1Kec9R3yBz0L7v1i7v2ddo
         Zqk2zihyie3UjtH4L1+D5mLRhxL84tACfJwgqhLfc7v9+0IwvYoUcFrBuDsyMl5c8FXn
         mbUw==
X-Gm-Message-State: ACrzQf1enkT0vcgbN/6rM1uZKnGx2fBJKKU1Pt1h3cuOFXBf9d4SoULV
        O/M9aR4DYqcR3ZzdbyUQVTrrZI5JGQaC770+aHI=
X-Google-Smtp-Source: AMsMyM5cU10ttpP/Y93CTsKqgciBh3e1tpcgSkvJ1+T5S7nTlvTQS9q6lQ6AarvfcN+/hmMtE94HX/4+vGNbjdMD+fg=
X-Received: by 2002:a17:907:94c4:b0:78c:79d0:d9ec with SMTP id
 dn4-20020a17090794c400b0078c79d0d9ecmr3085560ejc.344.1665127153599; Fri, 07
 Oct 2022 00:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
 <Yz/G0jQxc4c2gzhl@kroah.com> <CAJx26kUTzBeNkV_=gEeUYaatBwugT1uFH_b_ggq-fXaJDRBMqQ@mail.gmail.com>
 <Yz/Oik0uXXo0uGk6@kroah.com>
In-Reply-To: <Yz/Oik0uXXo0uGk6@kroah.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Fri, 7 Oct 2022 00:19:01 -0700
Message-ID: <CAJx26kVL4nYL2fbHd31ZqpXxEos-nyQ2-GSZbL6FUa5ztAbxXw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org,
        f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 11:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 06, 2022 at 11:46:45PM -0700, Justin Chen wrote:
> > On Thu, Oct 6, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
> > > > From: Justin Chen <justinpopo6@gmail.com>
> > > >
> > > > Al Cooper is no longer the downstream maintainer for broadcom USB.
> > > > I will be taking his place as downstream and as an additional
> > > > upstream maintainer.
> > >
> > > What do you mean by "downstream" here?
> > >
> > Downstream as in internal to Broadcom. Apologies for the confusion.
>
> Ok, but then why are these all gmail.com addresses?  Why not use your
> proper work addresses instead so that we can at least validate that the
> patches are coming from a broadcom.com domain?
>
I believe the idea is we can continue to support as maintainers even
if we are no longer part of broadcom without having to change emails.
I believe Florian should be able to comment more. :)
> Also, you should reword the changelog text :)
>
Will do! Will submit a v2 tomorrow.

Thanks,
Justin
> thanks,
>
> greg k-h
