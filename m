Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D336A1923
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBXJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:53:40 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF612590
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:53:39 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id f31so20673608vsv.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=af4CYOZxGFEia2jFKISPbK0kpnOWXcsASd/qhVrqOvY=;
        b=a/BAa2AE8nY37LlE/Wvo0GMH81qnhvvJ4hkf4UwojYj7HWDi1KSJI7tFXozFbi4bri
         z0/CfyVurxEsbDgYeBDGU7IYtluwW4zbOgzCRdMnWF4RizdiUaEqpbiJm/xtmOr630So
         pOcPJ6MK6D1hkzidJhmEe8VHr/hqOn+dc/y+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=af4CYOZxGFEia2jFKISPbK0kpnOWXcsASd/qhVrqOvY=;
        b=x69G9IPAmqumlOQEoiGmk6rhkstWAzGlb9s4Sv5XdFsRnDZqY7y/HCjqEdEvZ2FHot
         wBDzO4qAo+ovQKOyKLT5R4ZTskLAoBFckxFB1AwJMUIXRE4feRUvYwzkIkf/xnXQi4hx
         rAiDO6+X02/TBK6wM5IsbP6NBQfGmn6VzFxskWBDbdzQWTrSg32TcqbiSYmko7iABvAA
         qBMPE6SoD91tZBcW/ir40tSx+vXcpRKYK4NYXfn13m+ldwTttvJrtXIFnHrADNpcnrSh
         23Pa9k2i09eY+M4L4E6xO9yzHga00qsfdGCKECUtFyb1C5PRAolYNFnBteloaVk6xm7Q
         mSZw==
X-Gm-Message-State: AO0yUKUItgE7ncIOWo3bNkN1jZwmnhb17wj3pSyKjxVd5uX9kRP9LF8m
        9jSOMrrsASb3ikbATsOZ2dqqr7urKEs8beIpZAR03Q==
X-Google-Smtp-Source: AK7set+KvF/SzOSrOq2zhkOe2oGFapubF4kOTt85lB+h7aclUTKhE3m2QERgreU6P9Zm6e3LDGw+xzWKT5klfU2qjGs=
X-Received: by 2002:a1f:bf16:0:b0:413:1498:e843 with SMTP id
 p22-20020a1fbf16000000b004131498e843mr1876592vkf.0.1677232418756; Fri, 24 Feb
 2023 01:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
 <20230223134345.82625-5-angelogioacchino.delregno@collabora.com> <CAGXv+5Eh62NFNW1T7PYiQe+9KD8qX2WB7M3rwrYD=ca872y3WQ@mail.gmail.com>
In-Reply-To: <CAGXv+5Eh62NFNW1T7PYiQe+9KD8qX2WB7M3rwrYD=ca872y3WQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:53:27 +0800
Message-ID: <CAGXv+5Ehm0yb+52m+DL8s99KqBqx7skPZ2xfMFMYVJ23CDsfHQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] arm64: dts: mt8183-pumpkin: Couple VGPU and
 VSRAM_GPU regulators
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

On Fri, Feb 24, 2023 at 5:51 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Add coupling for these regulators, as they have a strict voltage output
> > relation to satisfy in order to ensure GPU stable operation.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Actually, maybe you should override the constraints here as well.
