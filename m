Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD136A192F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBXJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBXJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:54:43 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488C48E33
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:54:31 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id f13so16599953vsg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd8U/PCi0p6o8UgaJg/HLKkspvkAHB5A6pexOvPjfR4=;
        b=KVBqsIOUbphURupL/Z7Haw0sLK34ZhqLI14Zv6P1iiGy1OGYTBYzEb0wc5M6tuiyFI
         ujCiYCDkCg3cptrEb1R18nTEuWYEsAR8Ijp9n/zIWKWnbg0ARFOu7TL791vlu/BgFYz2
         Hg6dVzhahUTBzfexhFW6sCDEYFMrlUcEt/Shg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd8U/PCi0p6o8UgaJg/HLKkspvkAHB5A6pexOvPjfR4=;
        b=aopmG6sCtNka7xaEcSUGd1l5DhegwRCNnC+rcSSAcHbokKaGWI69F1W/lybpYPyxQt
         Pm5KbdLHcRDm5K/Z96ONbGyVy1hQYcJBjRz6U6joyk74dHNoQQLl9wmS1e5UcjzXZ1Pg
         9tNuX7viwVU1uNodgpVwbKd15TKtjxCVgUExVCc3sPoFKOCB/in4h+DPZlGPg/kqnqyu
         OoyqPFpowAWrC5v3AMMgZFSgyOMdPJJDfHA62fJSRIeNd64fVsQDjx5q/A7X5JW580RH
         OIT6HXoOqUq+FRh8TAAkaIoxCm9P1fEeXDVrNC7ILw4vSqITH+xOkjzJCKEZwPJUv7DY
         ingA==
X-Gm-Message-State: AO0yUKXf9OBgdqC6TsoE4MKN4aJJ6hxiyDLaO1eMP4m5qBuzkNFuLdYE
        xvBLBWgrN+s2F+HCqVSz9QePthS6BrWCitVraztNpg==
X-Google-Smtp-Source: AK7set/5nxZl0eckNXI6Q503VgTEGQfN71DtPSOnMcy7mMkQne8mOsAfpJuhK2AcNqxwdbl36ZLhTsBZt57SOZ7m6V8=
X-Received: by 2002:a05:6102:3a61:b0:412:2ed6:d79b with SMTP id
 bf1-20020a0561023a6100b004122ed6d79bmr2017113vsb.3.1677232470933; Fri, 24 Feb
 2023 01:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:54:19 +0800
Message-ID: <CAGXv+5HgfRbuyJM9Xk31TC8bgSGTCoeV-N+4wSVXmqskGHD_Ew@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] arm64: dts: mediatek: mt8183: Use
 mediatek,mt8183b-mali as GPU compatible
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
> Use the new GPU related compatible to finally enable GPU DVFS on
> the MT8183 SoC.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
