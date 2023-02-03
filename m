Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1D6890E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBCHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:31:59 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D70D3D0A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:31:58 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k4so4491039vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=20UFv4FYR0RNRhy2mEzLDHn9GdVhRKvFn1ySTJIDHWo=;
        b=RsxUC4vMRzdVnPDNIlpDSu6HWqexhlUr3/ndoqsY0EjcW+V0zfAdnJtijv7YsU+TcO
         KP5dbNn8LEe6vaxWWUeAbQkcVNYZxVRxSgG/V1wSR7AmvPlMMMOOGCYQGquKCmSUZ84T
         fQFD2VAWxBjKc9fP1AUSzWc+V61mf4ynPPAiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20UFv4FYR0RNRhy2mEzLDHn9GdVhRKvFn1ySTJIDHWo=;
        b=l2niXgU43x82yfbe+lKWoRPIqCS+yGGPwfoQy0orGdRGAm5rFLFMrIhwM6vPmbLfbd
         3WVobZMd8Q70ajkGBalZlhZ+76obD5o6wuvt9Pv+kiNJ3DkUSmms4p/m/TRo6RhCYGwS
         sznNNdefoZ2SonBpbHrjpI/exy7GDdzyd9TM/hWLgw7GdySZYlO3R/TRAj+XMNTvrDB5
         Se3avOnhMt6NXAoiENwWMg0TS8uuftX6bP4F1DYYhuJElpn6Mz5dXReu7tuXLVmW66hI
         EMeJT2R0ldNlRjJnqlT3DKe86wA313frI0Ut8D7AiEEcRbVT1XLXFA+fKTH+9pYMxcQO
         IJTQ==
X-Gm-Message-State: AO0yUKUag9ZYJRbf88le9/YOt0ygi/vhLYKjJYk1w5HNyJ49t3uhjUz1
        JH8XabZZ06aCXs1dF6+KCyWcFAjAh+klhI7QCDDtUA==
X-Google-Smtp-Source: AK7set/4FlDK7sISjom/UmIlvod48p3X4cFzfbV8Lo3q+4ml6FeokBpj89CDwYQ/JOIdYwgsnoY2RhpBJT1ZpU8fMvI=
X-Received: by 2002:a05:6102:23f2:b0:3ed:89c7:4bd2 with SMTP id
 p18-20020a05610223f200b003ed89c74bd2mr1677388vsc.26.1675409517750; Thu, 02
 Feb 2023 23:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20230119124848.26364-1-Garmin.Chang@mediatek.com> <20230119124848.26364-18-Garmin.Chang@mediatek.com>
In-Reply-To: <20230119124848.26364-18-Garmin.Chang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 3 Feb 2023 15:31:46 +0800
Message-ID: <CAGXv+5G4vvtZAcgO9SUczUDq4_94K4jF3G+YuSDYa8QvxpMp7A@mail.gmail.com>
Subject: Re: [PATCH v5 17/19] clk: mediatek: Add MT8188 wpesys clock support
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 8:54 PM Garmin.Chang <Garmin.Chang@mediatek.com> wrote:
>
> Add MT8188 wpesys clock controllers which provide clock gate
> control in Wrapping Engine.
>
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
