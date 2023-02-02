Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C06878EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjBBJeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBBJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB436591
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:33:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id a1so1397916ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xi1bs9nufsc3+EME8AXoJt5mo4hrHqFb7dqbf2Kkupk=;
        b=n870+M65xFEJzmKn11iqw4mJqHzgG50feQ1MP7WIyMEGNd1qortTgjqjJmuZb+vcmF
         qNQc1WWVHexk05QGeS7IlLuKedPULFsbKlWXi1xDB5L+jdxe+CR+bTuQXISV0ib1/kkY
         kksePvcZ6qCs4yh1d/Apo8GHzJNIBgOSwg/a/xlW/yLlwXc3ZralUN6BzSyivi9MgMLL
         pTBw1LBe/QghKeFslNMlAl/k9G9Jmpq5sTT3VhLRNFI+mCfEBdB1nGFeNv2J7KZbiPmq
         EnX169pwIHj56O0EXxOc5KJyfUbMdLcpRiB8w4VsS9fah7I1eES9RqA9aKg8jrzoqFEp
         M58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi1bs9nufsc3+EME8AXoJt5mo4hrHqFb7dqbf2Kkupk=;
        b=CaHuCz+SgrQezwCTYWij7dgHHWkN6MzcyO9IsQGpy5+4jjSgshXiqO2O1Oa7dibGX0
         9SRLbSL3uwNPWsUN3+Ai4iyp3HAbwvea/DdOhCLdFt5qoOy3u/LZq3rm/dUHWB3P3E/O
         2IdHwNsblbyaKeu0TqjLcFG5335Un7+9fYxz6X7YHBjj8sw7JgwuAvv44/46oKBHmWnk
         mdxDR/1icqVwpv+RpmnX8J+YwkStZAqrBG24ZfU3WmdFgIscvAyDe+4sUCXMEVuoro6U
         Y8ZzUs8MSzyLBlOehBiB/4+mby8atvuBdM3WyI5mJcTPoY6KpoEQKubvhuheJLbV5+KK
         WiFA==
X-Gm-Message-State: AO0yUKWqKDFl1AeJCcowzwWkx3chfMrrT176+ikkEur3tYQmXo/vAfG1
        tnz/lGDg6rf0ymJR/tQ584xLUDmvG1zdOxbEI9pbIQ==
X-Google-Smtp-Source: AK7set+BRqMslReHdxKtjUTDq+efY87Bn5jBE5ep0tPovWA5zPEPuFYV7gepkvxaNpNXHoA6F+nlc3zUxTpVgQyerpk=
X-Received: by 2002:a25:4609:0:b0:6f4:fbb0:e0f2 with SMTP id
 t9-20020a254609000000b006f4fbb0e0f2mr743801yba.650.1675330409368; Thu, 02 Feb
 2023 01:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20230202085958.11055-1-brgl@bgdev.pl> <a27ab5a2-ff8a-b5b7-dcd1-afffd3d78d8a@linaro.org>
In-Reply-To: <a27ab5a2-ff8a-b5b7-dcd1-afffd3d78d8a@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 2 Feb 2023 10:33:18 +0100
Message-ID: <CACMJSevVVuuGnGMpt3=M0z14jsV+1BtzOFk0bO3OQH10QACH8g@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: defconfig: enable drivers required by the
 Qualcomm SA8775P platform
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 at 10:23, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 02/02/2023 10:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Enable the pinctrl, GCC clock and interconnect drivers in order to allow
> > booting SA8775P boards. The drivers need to be built-in for QUPv3 and
> > subsequently UART console to work.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Note, you didn't include linux-arm-msm into the To/Cc, so this patch
> might miss Bjorn's patchwork.
>

Thanks for the heads-up, I'll resend it if he doesn't pick it up in
the following days.

Bart
