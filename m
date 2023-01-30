Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99656813C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjA3Ovc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3Ovb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:51:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA171E1F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:51:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d8so12333412ybe.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEvtFJQPulrkZV/QhUS2b7eZA6t1FKG+NUf243fMzo8=;
        b=k+9tMQaU6zoHpP+fpxi5OWD6hIzi6bR3xskQpIPNtLjur952NjxQjNQUo2DCbgfE1z
         1yFsgZF6mI42zmk9pdKJ3IiRai484ygIeMkBJxzPLfcpUfsf59qfZ2kd+vxVT6niETem
         sE3mDe8I2D7QX0s0LvEnskDwNi9gDKl82EI2B6r3w45yohUlSECDecqz4Zzip2CkB9Cl
         IOFOr+wJbvhRPXPnHsgdhILBuE09j4DWxxYAZp58yKA7PhHrsWg5CjfP6V4u0aUJWbTr
         bBWmTxhgmL3eghHghqdqW01R/OEdmCwAgq0UnLblj4w1TcksMlWP3nH2V+JPXZECJEe1
         eBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEvtFJQPulrkZV/QhUS2b7eZA6t1FKG+NUf243fMzo8=;
        b=ASHWI0t+h9uj2ym/1ralGyDxFq+Ij5yh8dswQQuD9XTcL0Hfkqoors7UOtNm03wGP8
         9hTwjEkBE1PUe9LxMQJE/cctRGtBkx+FfvlteMK4QJBn9oJfN5jAJ3YsCX5sJgxtwpmD
         B77Uz03vgdeSf4mekDLMmuCqt5sCyFgv0OEYsaJGXeYiQN8zI+azON7vlv4D7auO/n2l
         wj0MDvdfQferLNrXwd8K7LzVOLN+53IptdYDm7yXFcgO/cRZWzkARhABWbu7JfA86yn4
         gFaG7KFQIfbehkNYLPWbms7xTheiP/sFrKLFW6PyWPYZcUIRMg6Ga8bifDp11EgJNjhM
         37xQ==
X-Gm-Message-State: AO0yUKU62/xSGVRjVKea3IFximQaBgH5m5nYd9hSeWT5k4aAwSxBs1xd
        BPdF3DX+xrByJZOczTk3v7WKgUoLXXifbzMgTwyQtQ==
X-Google-Smtp-Source: AK7set+DmIe7j3dOjIUAHsuKWG+Nf9Ts/6kB3gMISs2ovIESVYLF5OSnh2wEH25pcGyXaxyUNOY69zPTLYW8cD3J49o=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr1862087ybd.24.1675090289666; Mon, 30
 Jan 2023 06:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20230130121240.159456-1-ulf.hansson@linaro.org>
In-Reply-To: <20230130121240.159456-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 15:51:18 +0100
Message-ID: <CACRpkdbDxVcLV2JX3duKCQTNMS5-U8jJ4h7SmHYbwnUy1+TVug@mail.gmail.com>
Subject: Re: [PATCH] block: Default to use cgroup support for BFQ
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
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

On Mon, Jan 30, 2023 at 1:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
> most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
> make it default y.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
