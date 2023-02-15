Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13D69831B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBOSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBOSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:19:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600D22DC0;
        Wed, 15 Feb 2023 10:19:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eq11so24211414edb.6;
        Wed, 15 Feb 2023 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttIkva2vkaSJEn3TjnxbLiCbuCwLLNqZ7Drf/i1oejE=;
        b=i0dK4fl+BixaORy4qMshgt3rJ9EpBhEFNSiv+W7qRkyVCKFRqVcTUxhUJ2KNSA0cEA
         MA8K/vm7wXlEkiw5pOxURMJ0cQRIywRPSNQOc52WocNA0cpFjj1949dZJ4v+aUTTKa/Q
         86UAivebQO15skJypIlSFuJHHuz0PJJbLhuIz0JJozFqdPbkUlPgHfJezHZ7C1fSfgWG
         c3biNlwX88XEqu3hmjUstgty4cfHjds05KPeaVxPFMuV1slhZy7wOxY6gHYpk5Qsp/DX
         k9suVa0kGEstxEDtVPyBLPWOwa6NxHrvGfxzkrrT5xnJp74+O+xWcXgxwqwyPMTyMpbY
         +Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttIkva2vkaSJEn3TjnxbLiCbuCwLLNqZ7Drf/i1oejE=;
        b=CAhREtOcy4SG1VYFUoLxndsVVzCY+FT7x+8E6301NaDLMqvrMvAQX2+kYzqfzCJLkL
         EC27cVgC4feDhXaobf0cwkcxmJavDv4N3rS6p0HmyUqvBwp+xFzJ9d+X3d9OuRgg7lGO
         Db6DwgjqbFXntxRyxiKLVREykV/2AliNN78FSQVR7vDJFlxrnGy+tsin6ShOFUZDZr9p
         hpniMkgGkXjGRZ+KKENa77Tb3FJ+y62dvRM68QbN+KZwunJQrpwAVBy9qc898FWnl2tl
         boLU8cp/APz3UnMcj6vL5Hx+uaXZY6S8iI09iQsJPLk54w97O5L2FXSq5bjBkez6SFOg
         rZ+g==
X-Gm-Message-State: AO0yUKVmSaM+xhi2g5pRqyGups7xX7KBmQnux8p5uKxIjs4PGLteZeJW
        G5YWtBF2DQpgxc5pisQXjf5FfOwjiNwl1E8UVNs=
X-Google-Smtp-Source: AK7set9A2nFDLZYLxfUjanDROq9ejXwSTBvh6MFd6TAptMtGbr5RJKzms5tUlWdywB1kayZeHtxEnIAAAXlrs/1cpy0=
X-Received: by 2002:a05:6402:26cf:b0:4ab:4bce:1a1f with SMTP id
 x15-20020a05640226cf00b004ab4bce1a1fmr197939edd.3.1676485161852; Wed, 15 Feb
 2023 10:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20230114132508.96600-1-fnkl.kernel@gmail.com> <20230114132508.96600-4-fnkl.kernel@gmail.com>
 <20230215111652.lyhebfntqlibtmex@pengutronix.de> <CAMT+MTRydNiYnhBJYVCoS5iXnhr7MywCV0t7FanHWwbwv2TrbQ@mail.gmail.com>
 <20230215180410.jhontngsrb5vvv55@pengutronix.de>
In-Reply-To: <20230215180410.jhontngsrb5vvv55@pengutronix.de>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Wed, 15 Feb 2023 19:19:10 +0100
Message-ID: <CAMT+MTQLOZUids4N8Eba5SYOShPGJWqMSaCyF=cmh2KvBE3CaA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] arm64: dts: apple: t8103: Add PWM controller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 15 Feb 2023 at 19:04, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> I'm not the one who will apply this patch, so I cannot say. Having said
> that, I wonder who will apply. Will this go via the arm tree, or via
> pwm?

That is a good question: The pwm driver should probably go via the
pwm tree, but the device tree changes would be better via asahi-soc.
That leaves the bindings as the, "no idea which one".
I wouldn't mind hearing from marcan or Krzysztof as to what their
thoughts are on how to send it properly.
