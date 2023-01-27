Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02167DF60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjA0Ihx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjA0Ih1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:37:27 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65EE4B4B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:37:21 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x4so5143566ybp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GEf7QxJkV2lK+zd3rAlZgziuhyilMpeFi0rsnqoFFQ=;
        b=InUQr75C75OupAU4ZiPJSfbUP3jzxez7OoMIX8RuGUFLIssgPtWbP37I+0em/pbNx7
         CoSiLXSruCBM2C0imVfmiluRvz3RPNq+XbSquQJzFvNT66uVvqviop9UGSNqUHWB0xhl
         cHzzMl0/ZKkg2HU7UdUmb31xgazfgkomH3WYwPtYfl7SNzJHbL0ty5YiavUGZn+GWt3e
         QT4+fgM83vCRASU/grwcP5HpUHgHUPEZyaC6OIHgFU6uE/AxryFXDJYkm4bNZQGzjN+l
         ZNB6jmiBnT8VyE+yNDdUFLZCP0s8YeeE78LXq0f0mCPAaLbYrE9EFkYTrhcdEjSfDSlr
         6Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GEf7QxJkV2lK+zd3rAlZgziuhyilMpeFi0rsnqoFFQ=;
        b=rLlu4v/YdpAjxFndM6wIi6zq8OGAvsDE+CRFKe3yjPCeZrIDJUux9l8+F29DJrhrv/
         ralyMfl+EkPGHwoxv4dN+KozYOYJf/7Pu7Z7pwmxiOQY7mUlgC+N/AYE5l6DSFDd0O5G
         rS+cMDKNMwtlpYX1d9HCkvKxskBA0/Mqtan9sO3TEa3sMcHGS65PPdkNQYlD0WPbh/++
         YJaK/hfh6g5rNfNvWxz/65Utd9oGBxH28x1HxqiUCcbnUG2DSAYTT/6a2IDPwGl2LzQ6
         PGELu1VprwCy9Lmm4m8yROLpXg3rDhkGbxzc3w4QPyTiTQJbk3zlFNeRcPBoXWmMntnG
         2Cxw==
X-Gm-Message-State: AO0yUKVvRn1Z9oFySEvF9CVXYT48tvEg3UtU/HSAf+JplTMwUWU6A6Od
        iQ7zBQkOsbIZ635DurMaZXzJkXnWRW2M2Pu7wc7DFg==
X-Google-Smtp-Source: AK7set+HozZEe5bAEwW9VgJFk2rLRsxQWYsM/CeXpOYqfTpUlft9aACuvd7bRiUrSnoeRoakCB7MKB2LKpuAOxMqClQ=
X-Received: by 2002:a5b:c1:0:b0:80b:c9d0:c676 with SMTP id d1-20020a5b00c1000000b0080bc9d0c676mr819539ybp.341.1674808641146;
 Fri, 27 Jan 2023 00:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20230123151519.369158-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123151519.369158-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 09:37:09 +0100
Message-ID: <CACRpkdb2aZp6x=vGVp0J0=XWuN=5eACQVzFBbvSWR3sF7TpZeQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ste: align UART node name with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Patch applied to the ux500 tree!

Yours,
Linus Walleij
