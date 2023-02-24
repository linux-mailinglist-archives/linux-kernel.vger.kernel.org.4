Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A346A1984
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBXKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBXKFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:05:43 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F865CC2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:04:23 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m10so18790710vso.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cvk5wpFc0DKAQZ00qghhmUCCY/U6r1q0rqg+NhQNPzA=;
        b=cFMugqChQXL7ym79hnpjF2hy0qq6heDITVRFQzF1T1+HR4BxaalKvPgMUPnCRgc2zX
         K1aVXJYjdC2pMFkdGMfIO8PLYW8/FdHp58Gd909cvpu1zA9uWb65c/7iUrbp/K39tbWh
         kIyW+EGGp+t7Iq7ObQSH+ZZNR054KabiSeNLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvk5wpFc0DKAQZ00qghhmUCCY/U6r1q0rqg+NhQNPzA=;
        b=W+4fVah+ngqm4WowTekqdrKcl5L09iSKE2mJsOkt+YHdvkOjVKnUnFMJa3BxNuilJm
         NxjHqma3W4iIjAcrhUeUuFal9Yw8AEz0ZZXt+etbt+EA6/oK+DpaiW3Fubuid7Z4gEdD
         qIDoV6X3kxS9sHTwsdH7NIvxex7WZ4sa+AC5IzvFHkM6B2R2vQ5C4A/fHOETQ3v2vKYK
         gtGmjkVkFfgy1Ah0A2Jh+PA+2T5SF9MHePvKqgp8OpAj+526dDcFK7Pg16+At8Db0HtQ
         YR3Pqlt8DOdLyYiJGeZsaTTA7yOF8EBeGViGpKnNO0EQR3wIMhHT3qwt3A2vhiLWoOr1
         VKDQ==
X-Gm-Message-State: AO0yUKVzY3dVW9tgS+/lLZUNkhlYTudXoNTINMutf5uEB35r0W7hcUC3
        SlNj7dNKM5K5vRsyAcbCJvSIxsY8SLgZdtfausCouA==
X-Google-Smtp-Source: AK7set8sv/uOez4Rc/C6TZ50n1VhpLKNUw7QlrbXGvX7eDuYw8eujWp0Kc33QvhtJcEfRx7ZMOIkuYwOnR4Jt0xVR7Q=
X-Received: by 2002:a1f:41c8:0:b0:404:d819:960b with SMTP id
 o191-20020a1f41c8000000b00404d819960bmr2200097vka.0.1677233059185; Fri, 24
 Feb 2023 02:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:04:08 +0800
Message-ID: <CAGXv+5FV-Y_gaVNZ9s_9y+F5HLE799vVJ8bJyx-JZiPXhAFVwg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] drm/panfrost: Add mediatek,mt8192-mali compatible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

On Thu, Feb 23, 2023 at 9:35 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> Required for Mali-G57 on the Mediatek MT8192 and MT8195, which
> uses even more power domains than the MT8183 before it.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> [Angelo: Removed unneeded "sram" supply, added mt8195 to commit description]
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
