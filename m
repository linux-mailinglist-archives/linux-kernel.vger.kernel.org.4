Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94B667C7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjAZKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjAZKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:02:26 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9EF6C111
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:02:18 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4ff1fa82bbbso16052497b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPp8p2IU+Yo/tv8MptrTkR3LAPKvoMO3xbtflO/ATRM=;
        b=q2hX7MzP5UHZaIyhfPr3hleh1jHYXEwU3nLOTdLLgalQ/Czfn2t+vLet52ZXwtyyGA
         q5Go7RplsIwfzTzyzKBZ7Lka6hLIpNt4H0TxkAKrRfkFo4N1ztt/HQbjuly96pJeV+CX
         hdDq/+IaWW7b1Y2gZrAjEWD98qlKYDX0xx4HWmWDTubgnY4O6JavFVJMRRjLWbzU3O9r
         chZvAIXjDQNyURrsFpnbm9mO9jSvO/Gy0eOcVbrLf7/q+ks6YUeDobUZhPe9QYHEEkqu
         3y1BZ2wR+e198LtME88GV2ag8A+Wc0mL9bR65GXNZZ3izwfJP2kNK60WAT7dLiVWxGTs
         PCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPp8p2IU+Yo/tv8MptrTkR3LAPKvoMO3xbtflO/ATRM=;
        b=cDg8MoC2JzU0cSDnv9HxnDPdVoxa3CZQJzGB5+UkVvHt+DL4aitwgCxopmmA+88Iwz
         jjCrzWL9k7kXsLEXB0CwTvolu+lA5Wg8h1hsW3ddXJmx4ipLsOlorW41p2Jnf7L2GfQI
         u/R4ygWteCu5EhN+0yqXoB7TFWN1eMW4ENke9QoMyZJnGlRJMEYRw+mXCRRlSSO0ZJJu
         qJEHZwM0MsnTXUfAj9M+n6GpaMUcvnBJi+bcTPQHOx7Ur0J3l9uv4tJxAUk14OyItTK8
         G7B3ZDHMl1HhJNRL1oxuIXdf4Dd23rNcQDJTbrhpQR7tiRbidkwgc5cz8iZMAYWjfyxl
         AZsg==
X-Gm-Message-State: AFqh2kp9mRn/RnCG8fqawM6kjtjSfDPDFa/Xq13BeIkW3AIIop0hlKUC
        IJyYWD60Idh47vUCfcvsRsqDm1ZRYaJEHWAoNQ6W2w==
X-Google-Smtp-Source: AMrXdXvB0ebdu+mUaLb+cYjitkUROCW3jas+htqUwZ+2VnP58aTGKtOvieP9n7CzKY2/8R/eJSLvQWMFmVLZ9396h74=
X-Received: by 2002:a0d:ce43:0:b0:474:b3f2:8df1 with SMTP id
 q64-20020a0dce43000000b00474b3f28df1mr4148267ywd.434.1674727337977; Thu, 26
 Jan 2023 02:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 11:02:07 +0100
Message-ID: <CACRpkdajaDLB6VPTrT93Q8y=k8nvkXUGcipTpA1xwzc6kE_v9A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: arm: align UART node name with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 4:15 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Bindings expect UART/serial node names to be "serial".
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Whoa! This traces back to things like
commit 3ba7222ac992d24d09ccd0b55940b54849eef752
"arm/versatile: Add device tree support"
Grant Likely june 2011 :D

Nice that we put things in order finally.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you have a way to queue this to the SoC tree for v6.3?

Yours,
Linus Walleij
