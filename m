Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4210E6A1941
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBXJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBXJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:58:11 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD9126CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:58:08 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id x14so20695227vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDHJK7PCQBx6L0iZv4CPd9HBFqqmGXlBJv6+kgrFacU=;
        b=oL19UenMCpOV6pa0xyeo6Y7yZge9bBDslkKDkzJo5E1gesVFErH0K6sXV82MZq0bqG
         aIceBOKnJjTAzG8mpqvDoAp0VtPt6eEKqYYCKR2Al8VsFLhuNJGDajyihntPJocNB2DX
         ObGsoi/XbXx5b/ji4LU29lQvfduveVXsIQLTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDHJK7PCQBx6L0iZv4CPd9HBFqqmGXlBJv6+kgrFacU=;
        b=vvMXcCMzJ/cWxZoIZUKOucipI4nDJRqoJ87vEj/ewmZv/gBLoKfJDwREtTj0sAofEz
         kK7QtfhBJ0Ynr2CwdlXWQhOqauWf/JTn2qKVdOLR2HefCje7IIrJB84ZYN3Fn71eBkA5
         T6Xr3zmTkYINdAQiaavFqwlF/jDsPZM/35nDQYKjXG8wmTLP2v7rzxex8BZztGoIkkF5
         M+UOgfv589AGiS9imLDMF/M8bGJbzC4BW9u5ZRdPmocbjKhM0mfDM4BlhtYbje63QcR8
         3YdtMsWqYv3aJvr97IpfBGW7TD6uzKtJRD2IFTCRMliZ+eaJkAV0mQAShqxw7XyGihTk
         RDdQ==
X-Gm-Message-State: AO0yUKXhSSBrMcMfeIMX9Ni0BlzASWMvZtJsuUVi+PROmvrCfLydey6O
        u3bTYZl+iAQBSEZhWKDeIcF/4TBgcRMd4m7qwk5kZQ==
X-Google-Smtp-Source: AK7set8ySk174IvOPAfFf/U/t0BY8s+z1UpjOQThmLdmHOI8zTcs7XG1QV01MtzQ7FuxKIyGDqYBqfAiPp9X2FyzL7Q=
X-Received: by 2002:ab0:5550:0:b0:68a:a9d:13f5 with SMTP id
 u16-20020ab05550000000b0068a0a9d13f5mr4693072uaa.1.1677232687691; Fri, 24 Feb
 2023 01:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-11-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:57:56 +0800
Message-ID: <CAGXv+5HQfpdA3qART761WqRQ_nb_8fFtj8uEY=_WtpbxWc8TZA@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] arm64: dts: mediatek: mt8192-asurada: Assign
 sram supply to MFG1 pd
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
> Add a phandle to the MT8192_POWER_DOMAIN_MFG1 power domain and
> assign the GPU VSRAM supply to this in mt8192-asurada: this allows to
> keep the sram powered up while the GPU is used.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
