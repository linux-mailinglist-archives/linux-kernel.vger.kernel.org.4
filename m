Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02D6916C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBJCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBJCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:42:07 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0306F8FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:42:06 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id g3so4252942vsr.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltJXCegFyxQxBBXU8F8ooPEr0BK+lcdYJkdrUHd++HQ=;
        b=WFbOPUT+c7v5lpq3MwmMtjN+FwqFeeOxJmKEDTvdecknTdR5RFl6FU8bpTfPQ6vsyz
         g06nq9sTVTiMVVMU/QgYQm2U7hrQVET3Is1Z3bZTidzvYbn19cO6jj5jR4DErtzwCTwQ
         RYSqlTdXqYpWbgXbWme5CheEai7OnfcprPl1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltJXCegFyxQxBBXU8F8ooPEr0BK+lcdYJkdrUHd++HQ=;
        b=OtHJKHvmFJWjfUlnJOQmDcVGfASKq0oP6UcuevQ+tgs2U1v75EcmDmom6d6PdZ/VEG
         vfZPWoouYsf6XzPslvLkPZnmJCDTCljpZidLOBt0xGvNpgAkLF4hCUzYruQXKjt3GK5q
         kgOM64SIeaQmPPRm7mtpFRRx5BsX+lGsyENVRbi9k6e1rGLo6GBZhtT8LR4O2kSf1ON4
         1RMuDBI2G1kbbseXUCZ4LM7dtwIuQMShBXfDF+Tnpjs8N7aGuGieMVH+Q7QoPyVEm4ZB
         tJZ5xHsdrnQxeOOewy64QGycVLzEqn2DUZ57XotqCOdUO+zuSL8mNwrrUHPqIE8AC2jK
         SUrQ==
X-Gm-Message-State: AO0yUKW0DLqOL0vnemtGZ9T5K/71vhHb5RKzQVEMwSGH1oKJwJkFH3UV
        T8sn8yFHFfr9z37pAYokoi9gY1EyOL+VlWJDZIf0Ng==
X-Google-Smtp-Source: AK7set/7PiJgyHmJjk/TX8Tls2T1YGvpQMaRarIFVi8Si4X3RLkp6SbWn96rOJwrf2bKykCzh1oZynfO0cWAOjJD1DU=
X-Received: by 2002:a67:d28d:0:b0:411:c14a:5bce with SMTP id
 z13-20020a67d28d000000b00411c14a5bcemr1359139vsi.26.1675996925169; Thu, 09
 Feb 2023 18:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
In-Reply-To: <20230209160357.19307-1-matthias.bgg@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Feb 2023 10:41:54 +0800
Message-ID: <CAGXv+5FcK9QbAKxa0TQ22C5iX9AL=zHGKBc9zQdat7CaOLd2+w@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: mt8195: Update vdosys compatible
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:04 AM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> In an effort to fix the vdosys implementation, the compatible has
> changes. Fix the device tree to adhere the binding definition.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
