Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F573B42F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjFWJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFWJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:55:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014DE75;
        Fri, 23 Jun 2023 02:55:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so447611f8f.0;
        Fri, 23 Jun 2023 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687514116; x=1690106116;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmh+oFPupR7SMi0EW4fghuDVJJeW4dIxynImVpI7xdU=;
        b=eGa/V89BwHHOjZt+jUypN4x4W6+lXA0YeYl0gdt3wuqwV+MubBWHcTdwxBKdzJK87u
         qdWZ8u4s3KEIoC+Ru/iRTVRB13quL8hwLjT1Dh3PRH9PFnn3x9P2d6J5SsiY3AzfYm9S
         rWHHP//2EVNgLZPkofKWuOiq2wOaLhexpYpZt3qpebJ6EbvMEKPEcb7Pa3XOv7nL2krq
         EZ+F1jvL8aGBx7LxhHPJWMFRrZxrHs2RjmPthTsvqXma5GSMoXzVfZmyEY8fvR5y4gbb
         lGrSnWnge4NRg6OgLYxYcxy1tNwrWAhj/ok5KXtrUnzlLMJCvILSESNjwCTTewHf9ZZ9
         zkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514116; x=1690106116;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmh+oFPupR7SMi0EW4fghuDVJJeW4dIxynImVpI7xdU=;
        b=gKrKqgkOiOeQ17crO8hvpB8uUvxolTixlVURghnNRfw1ExHD4hHH6ljKnYjO1V19RD
         EiKE1OKcK9sLmJpPiiL2Q4ZqXtcGLpYne7aLoIkO6R/Uc11lGLzoel30OoPxABGnq8ym
         mLvXjboZ4c8Tfls9b7moAV6hV2ZpxLIR9YY0f7NRBWu8jec8HgQ/gRq9r5eo2IXErkOC
         2vbfolnl6IUJohAatquxug8UXhwGaQPYE/ip1wuzsW1N3q0HCRLpN/fNcrILzJxwQPgK
         tVZIuBw5KSqH8heSbqTW4ZKDgsqZy4wstjDZ/Yv5KIKDJl2WJ+KtrD05X+lmJGpD53iW
         e7rA==
X-Gm-Message-State: AC+VfDxS3VgSda93ODR8GAp7W9rj/71CbPRMJtxeK9cCtckngJ+IWCRw
        DRTcStC3j6WLuLl7k70a9ws=
X-Google-Smtp-Source: ACHHUZ4OSLVmtKTfKtcWCsrjtypAdFc6GlY7TFfwJHa8LbuQj2pKhDsE5iflF0+tykCL2iX3uLTbTQ==
X-Received: by 2002:a5d:591c:0:b0:30f:bd4f:8f00 with SMTP id v28-20020a5d591c000000b0030fbd4f8f00mr18563321wrd.28.1687514115444;
        Fri, 23 Jun 2023 02:55:15 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6850000000b003047ae72b14sm9171536wrw.82.2023.06.23.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:55:14 -0700 (PDT)
Message-ID: <64956c02.5d0a0220.ed611.6b79@mx.google.com>
X-Google-Original-Message-ID: <ZJUNN0RXrUnV8o96@Ansuel-xps.>
Date:   Fri, 23 Jun 2023 05:10:47 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
 <20230622193120.5cc09fc3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622193120.5cc09fc3@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 07:31:20PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Jun 2023 11:54:09 +0200 Christian Marangi wrote:
> > The QCA8K switch supports additional modes that can be handled in
> > hardware for the LED netdev trigger.
> > 
> > Add these additional modes to further support the Switch LEDs and
> > offload more blink modes.
> 
> Something may be funny with the date on your system, FWIW, because your
> patches seem to arrive almost a day in the past.

Lovely WSL istance (Windows Subsystem for Linux) that goes out of sync with
the host machine sometimes. Does the time cause any problem? I will
check that in the future before sending patches...

-- 
	Ansuel
