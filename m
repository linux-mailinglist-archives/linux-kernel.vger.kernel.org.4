Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C430A6C4396
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCVGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCVGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:50:52 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD95CC26
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:50:27 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id c10so8254083vsh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679467826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX0SeXk95xfA7fzhyTC54j4JA6MuPQPWNc9h5Ft+JK0=;
        b=OUM2ebTToWE+DLYciLsZanPss0L92kIhxEtZFHjXnSNa3EY+rxceuEZEBNqeCL+42c
         I5zKDOyWs6WvdW1uiGRAEIrvNNd9i53Qq1TK0wyP8GNTFafEDdrImfPmDXDAPRgOVvQF
         DYHPVNcAuZFRMSZlB3rHCkWtSAjJJKY+8wbBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX0SeXk95xfA7fzhyTC54j4JA6MuPQPWNc9h5Ft+JK0=;
        b=VIzuIS5R86TJfZViwGwGkKN13iqulpq36C3uzXK6zd9KmIbEu9POZ9BnhRDLQn0beg
         n0pCzLYA+vrz+h2cxYZqvfSnq47HSM8htzOl8i3H9sZeR0kiUOlwkGLFUSRGnvxaRPkw
         l97yFyLXAxu9ef7GJmsiyr+fjhESJKnpqKMnVZE5nE0Bg5r2Yi5FNcuCg6cKtQFcrcdl
         gJlCtwlHDYtDvn0zO5fddJVbZWThlN/g3hg8SOSZNo36TLElVcU2tkpigBPt/emhT8a1
         cL+vVGCRJNNg/JmDcJGjmu7dUvzrp6eSlo+ePnKy6/NTLHttExFKeKPbNH7IId6j5lSW
         D9JA==
X-Gm-Message-State: AO0yUKVO+PK0G03VpO1/aSEfFqGuD79MKOSpZcrX5CLSVVNDjpcrA12m
        y5Y/QGJ0ZKwfSSgm/LDlf3GzY/dIhnGJcaAmgI15GA==
X-Google-Smtp-Source: AK7set8Ms11ZJJDrulLLbKmxZz5jY9ehpCROWxJN3/SBLOsC8jNk+PkF2io6QogN9ANBqmnLQL6MAMBbwXz/1TJuBOU=
X-Received: by 2002:a05:6102:3e09:b0:421:c4a3:b607 with SMTP id
 j9-20020a0561023e0900b00421c4a3b607mr1041896vsv.3.1679467826251; Tue, 21 Mar
 2023 23:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230317060917.15175-1-allen-kh.cheng@mediatek.com> <20230317060917.15175-6-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230317060917.15175-6-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Mar 2023 14:50:15 +0800
Message-ID: <CAGXv+5FkCuuV5nZ-_7Kf9cgodVcjfOhjvj3+T7xPqc4RuenHEQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] arm64: dts: mediatek: mt8186: Add audio controller node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 2:10=E2=80=AFPM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add audio controller node for MT8186 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 62 ++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

This patch is already merged in v6.1-rc1.
