Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAE6A193D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBXJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBXJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:57:20 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55101305DC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:57:19 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id a3so7655070vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAHZ9cKBBV2LwSn9/zPRVzPfKfg4x4dSAZBG8sLVBgU=;
        b=iG9gidYfEVf9lxEdJHr/frmoYwz96LKdV2a4nqaaSWwF7OAasL5tAC1qGO+XGxQIBU
         GpLhfPk32QpTpgKqcMAo4o89quE8p+AA8WiHfxN3F6SOgdegUwE+tfHY2zusxsIET18r
         +J1VsSao3s8H/A2fIS2ZpjIEkbrlaNL/VIltA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAHZ9cKBBV2LwSn9/zPRVzPfKfg4x4dSAZBG8sLVBgU=;
        b=iKXDL2nP57hXdMQK7Eydpra4brK/7RHvJZ+zgE725jXGw4vJCsVHnmkXs9xfktx18g
         4zM9B7kvW3u63PmJOLPq1y5ennpYcOWAU9Utspwd8wX3t3YWo+APmiumQfSQW8uOo1X1
         k5SRBDKIPRxkio4ALMXglMW+OXnYJkJHzQDdNhurRALAP7geud3GfV+yUdPNk10mucPw
         0pkqXroA8/bEP0b8xD9kBNP8tvQB3bmrZlnqHxaG1UyMMHfp/IgtcCMzCqF24zADsu/F
         mL+o5G0Nz99QBn3glqoWir9CSagjp8t9PfNpdWzbXqgKEji9WIhVfcjbAqhCaCkqntv+
         iUSA==
X-Gm-Message-State: AO0yUKXzxRq9PX0DNYH4VmaBdiybPeWGDJ7qysZNUIW1Zhj2YxHFTrIZ
        ckk+3wEjwdwY5pbFdFhxuvJOXVAmGDvTWC1/5s5X1w==
X-Google-Smtp-Source: AK7set9ECBliwTz1U7da3oEuel1KUAA2o9DoZllUvIWerjx85dWw1VIVGKL8RMLtOdq6HBuz2XEj78CKkrhSFUhaBcQ=
X-Received: by 2002:a67:d28b:0:b0:412:2f46:4073 with SMTP id
 z11-20020a67d28b000000b004122f464073mr2145977vsi.3.1677232638508; Fri, 24 Feb
 2023 01:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:57:07 +0800
Message-ID: <CAGXv+5GECpvXB3qoPr0TwrJP-tOaPULd8uiMOcTKWX5f4zvWWw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] arm64: dts: mediatek: mt8192: Add mfg_ref_sel
 clock to MFG0 domain
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

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The mfg_ref_sel clock is a mux used to switch between different "safe"
> (and slower) clock sources for the GPU: this is used during MFGPLL
> reconfiguration and eventually during idling at very low frequencies.
>
> This clock getting turned off means that the GPU will occasionally be
> unclocked, producing obvious consequences such as system crash or
> unpredictable behavior: assigning it to the top level MFG power domain
> will make sure that this stays on at all times during any operation on
> the MFG domain (only GPU-related transactions).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
