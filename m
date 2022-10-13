Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583F5FD396
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJMDhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJMDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:37:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD2B6003
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:37:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r14so894032edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=km/x4dNbpSXiQbScfZULHzvpKPxUFqn2RX0kYro9dnY=;
        b=G+ijyw+YElgHkz9u0HrJK28v0DxiI72ImZDb0r4hO9PN3coaRP2XfA8ZfAl/8ZZ4AL
         lsFDquibhSUs5NuGplp+wmb/kBY34E9kFVU5p56slsfiU9GVNRw6+OTBtW41bqNqypUY
         1ipXiOtH4yore9LZw99lbA0Zdwcsf7jyfjVvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km/x4dNbpSXiQbScfZULHzvpKPxUFqn2RX0kYro9dnY=;
        b=O/K+3aweJMssvlCDkjsFsf0S+om5sVob0sQpl5EWMpXk+0w24AodGnq4GBjxAkblm7
         /cLqickkjaEWBfIuuu8EysgJoX8gH7jMQMraW3RX15gX096+WXEyLZWEvaXmQz4ZOYjQ
         XEIjOgstx8EwzwCI2L2CojvBUGhoIVjVsi3IzYVFzwewMuguvpN5UYTnH8Q0a9tlVoWJ
         6fT4a965rnpodS2+rncEjhFVsq4pV5aJC6yc2VfVsMqAvuMdWVp+lrFCz3hfHSGRcynF
         xIjKz0mG+noGwZTOjPLo8ElVVLcnYmqj9xOZmb8XRr9kbOlcY10CTNWoYT+bm9QXxavZ
         YDsQ==
X-Gm-Message-State: ACrzQf0Fm5/56u7zcKAgNgQqBZa3OCbqA0VFQlvYHPBezAiYLd0bWWFj
        5X57rJ6Y5W83BNYp7lQSsFdeDkk29JvdZ1APWp1gjw==
X-Google-Smtp-Source: AMsMyM5/cBj9U6Vdv/D7aVLYS1aJOy0vaa6E+V2MaYc8d7mEX7XjtYVDUAeN82NYnkMRxUFJGC4tqxwz5hhVNs84ZDM=
X-Received: by 2002:a05:6402:22ef:b0:458:bfe5:31a3 with SMTP id
 dn15-20020a05640222ef00b00458bfe531a3mr29802577edb.6.1665632247137; Wed, 12
 Oct 2022 20:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220729053254.220585-1-treapking@chromium.org> <9d1d8831-844f-f30f-6c8a-fac052f8699b@collabora.com>
In-Reply-To: <9d1d8831-844f-f30f-6c8a-fac052f8699b@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 13 Oct 2022 11:37:15 +0800
Message-ID: <CAEXTbpdE6JumX0ecP+LtDXnfR5E0VeaxU5N5_nVxVVNGRHATjQ@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: mt8173-elm: Switch to SMC watchdog
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
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

Friendly ping on this patch.

On Fri, Jul 29, 2022 at 4:36 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/07/22 07:32, Pin-yen Lin ha scritto:
> > Switch to SMC watchdog because we need direct control of HW watchdog
> > registers from kernel. The corresponding firmware was uploaded in
> > https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
