Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C267E59B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjA0Mki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjA0MkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:40:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235903E632
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:39:06 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d132so5818486ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwZuZwMC+f2f/AgCvMkCdUDxtZ31St7fTmiATBXQIEc=;
        b=B16eeh7HmWczjoVldqvEQlcUFdGq6GVI3qJ7ca0R+DKSBxhLu6/n+/kzHARW/+Kukr
         VOftiWNFcTb0fmDwtrtn1ZNw/o5EodIqxmBKlvc6lW+/12mhjdxMgvi8/MoK8Uo1Cy6N
         OVEKOWtO8tv2IMSKEzid+N3iYKnBtnDlz1KFcXzC2XcpYIR8Bvc/sa+Q96HAz5rpHBKt
         tnBrIBNj9XaIytwfS5fECPql+UohU59hAj5mK04bpXEI1tELvUm/dDSZcKXC/SeEewWG
         zNvFcgYnaGFu+XeTJc970niU8hj0J07AfSjaeUJX1A2z7D30EoSMqiCxopMMRQXSA8oo
         XAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwZuZwMC+f2f/AgCvMkCdUDxtZ31St7fTmiATBXQIEc=;
        b=R25ZgJXU6BcC6bSwqI383xRE3V/7z68SbAKsvCik/Ur0GefOTE7UT+tNkTdj+lW8Ql
         ruuzG7ggsxx1h5VHUJ4DLdl5SYhs5yq+++cAeP06zfTj+TZAR65Sf/N+FbNEiqTnSONQ
         8trZOTJP+VsP3tccNa32prZS9uwt+MS2EeAqYa7TBFZX0Jb51jAM7g8ZtEORMlhKaAlL
         Lzm2DxNJFsyKSZFXyY+Els2RHO8aVAGIU7HFvCe6crb8wdG0Pv9vGmevItNLEIufXCfu
         9rqEWQUbedk2g8kRSimfEtEpu/hdZlOE1BCEKlVW3yOSGCR98wRFqXUKMQ4hSrGGzQ31
         l9+Q==
X-Gm-Message-State: AO0yUKUUWX4DpElepQYigGXULgtgyKrCcH15HUJpD4cnIEK270rzdoN5
        412sJIyVsCIqU9r8dnKqnuzhokGDKYcCKs3Q7UrLfQ==
X-Google-Smtp-Source: AK7set8P6BjVJvQtoZCgfykSubTY4hwEKuJfKzYmgIV1cELHLdH5Ujvw88+vwYhILkEtpv+XPIPlvnXeK5VtoxtBuKM=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr1739203ybg.210.1674823144253; Fri, 27
 Jan 2023 04:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com> <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
In-Reply-To: <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:38:53 +0100
Message-ID: <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Thu, Jan 19, 2023 at 2:54 AM Joel Stanley <joel@jms.id.au> wrote:

> As foreseen by Andrew, this caused a regression. On the Romulus
> machine the device tree contains a gpio hog for GPIO S7. With the
> patch applied:

OK shall I just revert the patch?

Yours,
Linus Walleij
