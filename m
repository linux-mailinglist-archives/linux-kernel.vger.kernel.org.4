Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56756A1998
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBXKIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBXKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:08:29 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F864E06
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:07:25 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id f23so20469547vsa.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZDoDp9QuC05HnCUGFroZeageBxmT4lsXtF5GYcG4lI=;
        b=g7Tk0DyxLJiSdwQj9+fZ+JDu7VS9asBGyeJ8BDtDB6ezGb4c39EJwsNf12hbtzBpcW
         kQCKesuzq7DS6DYWn/T2ENJR5+RCWGak07fn29bUyWLKH3wxR3hsMK4tD1qMkNpoKvw4
         DaNPCEtiA7Weekw+ykdFFO3u6wj7BGzB52Xuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZDoDp9QuC05HnCUGFroZeageBxmT4lsXtF5GYcG4lI=;
        b=GFgzPE8To1ioCcv7sWdVN6WNNi8LmUgCI7/lYJAaV3bqOy8thUf8OUjNM3F9BYljqh
         olStNZT4hzjJkjGLsdxzlK7+G2ioaBGEl1vcGZFexOxxGKx/Yhgg863z90WlhP09IFdW
         2fRyjGP1i7cQooMFXhaeQDMrPk2njAqnlDqIq8NFVU5YY54KCA7aOepV/ZvE6oxF/oJN
         VeGwToINVoQqjNFvrdE76H35aBKtNcON+trKTk5mdLQyIdHNrDRDaL2/qXcZKbQJa/lR
         HVMLbe4lI5gBxYufEaGxb5fmMhvESuhUu/p6dTkayXWj7FFSVeX/1hKxZB7KZps1lOO1
         yobQ==
X-Gm-Message-State: AO0yUKVac1DEVLuT0K3z3Ag5g+oZRiINwoReTjSvqr/sNEjhQJGn0Akm
        cWBt/8JKC+SVGsZXC+6eZ04e1MupbdkBgFRtB8dLGw==
X-Google-Smtp-Source: AK7set9Z3KDRrAXUtzA44i2qVbV1BjyBQ9KHn9SH29kzn0sht9SZ+2jQRb5fBw8cvC/jRXKdcl1bHuaPLYsSWxZmYqM=
X-Received: by 2002:a05:6102:3a61:b0:412:2ed6:d79b with SMTP id
 bf1-20020a0561023a6100b004122ed6d79bmr2036420vsb.3.1677233243900; Fri, 24 Feb
 2023 02:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:07:12 +0800
Message-ID: <CAGXv+5EftwRaS7EKEPRFimVminA3Je5Ot_QHBk-yqxzHcJkUSQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
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

On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Since new platform data was required in Panfrost for getting GPU DVFS
> finally working on MediaTek SoCs, add a new "mediatek,mt8183b-mali"
> compatible.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
