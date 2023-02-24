Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740646A190F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBXJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBXJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:51:21 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0EF64D4D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:51:18 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id o2so7183505vss.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+cOUMETYWPj+3zj+V0LZyGIDXw+UlRgZsHTjIWEqX7c=;
        b=OMT/zwGv0rtaA2+O2iliW9lV4XB5TC+1rqUYocI55/ldmQZUOKhPbMapW7AiEsM2pg
         r1fWLwRfGvCc21VrKvUnXrHZ1vgNsAkMkXvSF9hkyjqRwR0hcoS7a+PzlLjTh4W6pAJp
         lOqK3+yXWdtz83RVNOSI3JzNqr64F8a8Mr8B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cOUMETYWPj+3zj+V0LZyGIDXw+UlRgZsHTjIWEqX7c=;
        b=1tOWP1caNyFTmSO1FUGBU9yyzU9P07hAI+K9KfuMfqDBIMZyXfPOXlmDRM7e2FZnCw
         yIlWfglZBRg2/hOKDx2r5ce6cLXAc0QPYxWqgno2kI70lUbzTYgZYEk+QyTBDPmgjhSc
         I/7EBz5N6eJSSvNSndqydvKtlbELQvgnTH4yHzt1FiZYfagHDx+xtuUCRr2HDVLbUBef
         FEZuDxJnR8Vyvu8SOdT9OW+vLmD3NkNT18a8IaG8pidMwZcEzSnE1aFpieT03Cb7Jkgr
         17fLqrm0ejIjUcv/SBk08ls7gktlY7GkPa+Mlh8ttpsojenOf5GJ+R1aRPriSCqxaJcE
         sPwA==
X-Gm-Message-State: AO0yUKXavsU0/72Iq5xmOrAT97sEng3fRM0As1Ey1Axj7wQunxK6exm/
        zKbEJasmN1EO+mSw30Yn6uxbVrVJsPb2B2BFX8NEmg==
X-Google-Smtp-Source: AK7set/xJ8xCePXsC2JlZPb6XO+wk7EFsOgwgVrZbRKYzXiRy2pllaTaIQHKfgnaTfJvc+Dy3pyqED+k3tlyKGtms38=
X-Received: by 2002:a05:6102:3d16:b0:412:d91:5ef5 with SMTP id
 i22-20020a0561023d1600b004120d915ef5mr2576584vsv.0.1677232277889; Fri, 24 Feb
 2023 01:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:51:06 +0800
Message-ID: <CAGXv+5FzzosPhBNFyWu2U8ZBeUg8fHSvEy57LL4gduy6=GOj3Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] arm64: dts: mediatek: mt8183: Remove second
 opp-microvolt entries from gpu table
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This was done to keep a strict relation between VSRAM and VGPU, but
> it never worked: now we're doing it transparently with the new
> mediatek-regulator-coupler driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
