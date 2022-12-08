Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7986471A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLHOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLHOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:23:52 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9D9B7A6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:23:09 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id b189so1564641vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=As/CZIt5orfwQ7Fab3NuD7sU3ZdGXQ0KUV67djSyEM4=;
        b=Svr4EJWyVAy8ZEDYXtdX/3PhjyfOQy/jlGEJYjzvXbZJ6WagFt+kE6B4+1PJM6DBBd
         tYLQU11uo0Z6tw7curiNweecxh8wA0L2msqtQg35Kt9uQJ/dXmeLKTyiqwPV/R3mCv+8
         s/kqcY20HDJpUPmsSOHZCjyjivbBegAoR5eo9s2XyR9jQ+FzbCQYs+D8P4SLK2q9cHF5
         r1KZoEqqJlj3PDOcAXEyAwXUsH7TG2q0p4LRsrwOhuBV7+vP6LMwSLSBAtOQ4HDGd05q
         jd4gAD5Xs9r394g3IL1vPEWZXMXX2Y1gR2c9NUz29GhNXHqBljPeOBwSjxcp//Zl+qql
         /0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As/CZIt5orfwQ7Fab3NuD7sU3ZdGXQ0KUV67djSyEM4=;
        b=TbZDLcnI6OkD6nIPrAHEZCKrZOh8tI6GYIWd6HoPJo1EsEDbdSZGP8mWEMa0zTjLym
         kAa/ZNGlwbRpnS5h4YoAhYDqhFAb0Q+chvYfXZMqmCiKBPBaKvId+K7UzQx2KO9QmwmK
         0Q75w+P0ZfWeCJMKwFiA+j5shvoE8yC+RNvudOs2uNJPR2oACTURe1owB1JgpjsFLwQ2
         7h9plCADRFq9eYoHIwIwbzpgv/rxXYxJCoHb9l6fsRuBH/2X9VzaOvp0uKdKbA4h1ZkP
         W2mdcXrZSTx8t+LT+dg0W+C6mSKoJw+CdIxwUinUqn6bCzxuqTQyCsZsWnxOwPcf6KHG
         Lrsw==
X-Gm-Message-State: ANoB5pmXsfpIyhWTGBM6KS0ZKpyGCtUbntfjs+k1LekljpgolmvDuqo1
        b8wi9+kAEkhCQccDJdkEe9D0TX45g2iwjIspArFgiw==
X-Google-Smtp-Source: AA0mqf5hrLUh6geFTTa3xvTozjjJK81CXBxyGaTS+c820T86mab4aBRhrL3B/1Vxhuy4Xvm3PYggqZk+jFxLc26n1DQ=
X-Received: by 2002:a67:ed4b:0:b0:3b1:1506:bca5 with SMTP id
 m11-20020a67ed4b000000b003b11506bca5mr14620578vsp.35.1670509387721; Thu, 08
 Dec 2022 06:23:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJzde06+FXNpyBzT+NfS2GCfqEERMkGDpdsmHQj=v1foLJW4Cw@mail.gmail.com>
 <20221129224313.455862-1-allenwebb@google.com> <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
In-Reply-To: <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Thu, 8 Dec 2022 08:22:56 -0600
Message-ID: <CAJzde06ACctpK-5ht_Ow9dMuisOwTM5CKE_SK+bW5eWTmwCUxg@mail.gmail.com>
Subject: Re: [PATCH v3] modules: add modalias file to sysfs for modules.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lucas.de.marchi@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 8:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Nov 29, 2022 at 04:43:13PM -0600, Allen Webb wrote:
> > This information is readily available for external modules in
> > modules.alias. However, builtin kernel modules are not covered.
>
> Why add this into the kernel instead of just a modules.builtin.alias
> or something like that?
>
>   Luis

I am fine with that approach and already have a PoC for it. Here are
some considerations:
* This would add a new file to the kernel packaging requirements.
* It is easier for separate files to get out of sync with the runtime
state (this isn't really a big deal because we already have to deal
with it for modules.alias)
