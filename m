Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EA6A196D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBXKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBXKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:44 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88417CEF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:14 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id v27so12775821vsa.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81aqISuq2eYUnck2go8oizXxt9eqFaaUJ7kbWY5LcaQ=;
        b=BBIaeUfzGQ8ePb1MEWkKRMSN306q1XdtDnvrgaXMI2a78+E4hErLx37tCLGhJSxY4A
         RMdxBfp07pBnOryIBtcyvGw0ia26eC6PpMmP3Wm0XRyE7bRga3NyH5nlZ7HkoxceIc6S
         Ybi1UNdfJUUIcirP0Oxp+u2C4gL8bYn7DmAiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81aqISuq2eYUnck2go8oizXxt9eqFaaUJ7kbWY5LcaQ=;
        b=L036Z9T5+FbWQdql4GiakUiJQMSF+To1mNpgblJezadapdGMz0uQLq2jf5vYqQhvJt
         71raai+pbp7uAhH2wu8qm4OgOL7HEZlJ33wU0MwdMKmCwJFyRF+4vJ6kP6ggdotO21tG
         0OB/2IyNvwuly3tWCTo4Pqy+e0lUYQQVyb+1VrgEOKkumNx6QLdArP773vFZuuVzDUjS
         CZZsooFojpu+CJA0xEACgV/8JOpzpli81vUeLcfVOhx4I1/I9t8ao5GMZqiFljbgcOIS
         CzjV3UiZiFbZFGPE5rf4pEghf6eqVoEFxV4lSfGO7FH0RRjkM0C7JXOAvygXYHuV2jb+
         dXSw==
X-Gm-Message-State: AO0yUKUVexPreCoPWeGE2JsssJQoYLeRQGRLHx+J7HyNeJjNaicT4Mh8
        iuKJwD9r3JmwuVQdeodPuDQ3VnRntx825cEFNlCRnQ==
X-Google-Smtp-Source: AK7set+3I53BDKCorZLNVo5d0QftsqocEySXrxgfRxSbKglMQGMQLOvpEbCtJonqcgFcA2dFPOyYsedOXPEqiC/zdec=
X-Received: by 2002:ab0:53d5:0:b0:68a:5c52:7f2b with SMTP id
 l21-20020ab053d5000000b0068a5c527f2bmr4368520uaa.1.1677232989554; Fri, 24 Feb
 2023 02:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-17-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:02:58 +0800
Message-ID: <CAGXv+5HgMPvsCUWjeofYBbrGKBvP_eE70exKZ2QLRFuMvn7PAQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] arm64: dts: mediatek: mt8186: Add GPU node
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a GPU node for MT8186 SoC but keep it disabled.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
