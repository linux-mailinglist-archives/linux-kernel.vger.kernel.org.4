Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BA6A6706
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCAEjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAEjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:39:47 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8137F04
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:39:46 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id by13so480999vsb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwsREfLzKNuoHKNJGJ6iVvjj/6dxpXa/wWiq+aOws3Q=;
        b=a3gecTzILo4UywzFzA6XXXh6RaikEw/YKRyaBgeIOOMjPEbvFOf7aAOe/Mq9fpzGHy
         FfYlwS4LQOXAL4xQ+sHOGdG2UyTEo8fQhglatZHkCeSF5TXhcYX2Y2uRTMTUYxtM/Pg7
         W5//enhVOfpdJrGh3Rbn/9Cg3KaUMtsUd5v0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwsREfLzKNuoHKNJGJ6iVvjj/6dxpXa/wWiq+aOws3Q=;
        b=XVwm3eLllt+NuzXuVJxSA660zOboJeo7htmOe8tW6I9uUeaUB+si5qVTUkU43/69oT
         aZ1M1KS1L3VAcoz3BCTdpjVtEFpmY9Sz3XCsCshAunhc3Sx7iGyAj0dJ1ihHMvrRypgv
         AEO78SdOaLi27Nr4dUSssIjQjPykOgAbrCDV/E+LbG5NpQ7nvqvUavi3XxG0QcUFDCB7
         moJ74VxnNbeXWlRdKW4B6OgdjcVZ4W0tgDGc0q9ic47id/DWFDJ6k17YLJdxlJRTQnij
         CKbkuuS+6zQM1kLtjOOjx4hqtFsEGz1P/2BVEyigGMFWuNqOW7kI0e6NPFM39YtmT6rB
         /X2A==
X-Gm-Message-State: AO0yUKVKtrbAFO3gDbNxto5lsBiFpgZSfStmINwp4/Qn+AUWWanR8bf+
        j6l+SMwzBEuFZRM5Rg5ycNIufNC1XlJWiw5cv4taaw==
X-Google-Smtp-Source: AK7set96qHrtO9E5hIU6PpiS/WcbX+668xtUf+kbQTX5iSHTL+FANLylbrBzA8nGrr2JX/hYjLJn25PCOTFRJBtAILY=
X-Received: by 2002:a05:6102:3c8d:b0:412:d91:5ef5 with SMTP id
 c13-20020a0561023c8d00b004120d915ef5mr11393790vsv.0.1677645585976; Tue, 28
 Feb 2023 20:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:39:34 +0800
Message-ID: <CAGXv+5FVKK0BJHu2Y9ne9zQ043J=AaXyXScMKZcx4ZqZSLyFUg@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] arm64: dts: mt8183-pumpkin: Couple VGPU and
 VSRAM_GPU regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as they have a strict voltage output
> relation to satisfy in order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
