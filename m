Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E06A6703
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCAEie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCAEic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:38:32 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4C37F00
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:38:28 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id by13so479365vsb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28yKfwjO/0s4rJfe6O0bQSgJmZe5IPEVZaGiHKCxTg4=;
        b=ltkNxU1yuA7SsUdnMUKFZgbgRjVolNxel8F30fl8qwMT2mZ1gkbagUUvp7KPIZb9Aq
         cqKY6RXZOfPn7rsWN+BPGfLphSlLwzpHvF67QeDuAvB4SvFJml65XJaT2vWDSQN1afSo
         AZ1zD+02Au1E68OYq07MYfZvCt1TE1R5m7iGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28yKfwjO/0s4rJfe6O0bQSgJmZe5IPEVZaGiHKCxTg4=;
        b=MWDsCPc8frUXI1PjHGYMY4accY49l4IXfHtpLAHzLzhYO9QxvyRKTZuwn/gzoDdrGj
         0GwilqrA2kNhLxHTKm3mrHEzvdSQ+kHItYL7ZYn126GQFWg9+MzornCgle+QpqtNXA2n
         D9BN+RkQb/Bs39rqfkaQxqCbHtYCHAieFcN53qFZkNt2g0roUtERh1pKAtAr1uKhLY1V
         aNiyYHrHFptso0NneblMAg2XPy1YOphzgJkM2/8F7G2d609YoyVz2oYYDd/giXDxM7Gb
         Fw/m+we1pNNP7k8z1ImNpURlyGVFIGOcYJOwMUQPx7s6MnRWkP7aP35XbGWtCMYt7qnz
         tN3g==
X-Gm-Message-State: AO0yUKWFtCS+y4sD1Tf5a0crsRhXNLZ9SqjKdcx9DNKhk3VzHNm3baZj
        42UUaT9SR0BBC8ZuYMdH6BfAKlmuhyuGeNMon3vbmg==
X-Google-Smtp-Source: AK7set91+2QnXMA/l4LPBLXs/2Khip/xRn9a22mox+dUKEcVere1J9qIQiz8Gao6UOQmlxbGnEkxjEAOVVyl6273gFk=
X-Received: by 2002:a67:a641:0:b0:411:c62b:6bf0 with SMTP id
 r1-20020a67a641000000b00411c62b6bf0mr3655682vsh.3.1677645507920; Tue, 28 Feb
 2023 20:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:38:16 +0800
Message-ID: <CAGXv+5HB-0XYw-vs97fbFu6nXWOOJzCf=rK31aL_ecC04vkq0Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/18] arm64: dts: mediatek: mt8183-kukui: Override
 vgpu/vsram_gpu constraints
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Override the PMIC-default voltage constraints for VGPU and VSRAM_GPU
> with the platform specific vmin/vmax for the highest possible SoC
> binning.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
