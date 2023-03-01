Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99F6A672A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCAEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAEyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:54:31 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898230B1D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:54:30 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id l24so2842652uac.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvFH86Wx5RN3SI+RWTx88o9Hq2BKwJTQQWbayEx0CcM=;
        b=ZxaXtuNLzBhH5mOpcCdHHrxhSSkg3a6KgAkqv6gPCi/zvpxMijDYgKJ+q+pBqNHmFJ
         2pBzHrrmZqbgpSCptSqsurYJ/zG2ZQd+JtVAf2T6AOK8jix+Zphv691UlgwiPVIdVyXX
         b41vtyIfK3DVq3w8X4atBBuiJSOGJUZS6I1E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvFH86Wx5RN3SI+RWTx88o9Hq2BKwJTQQWbayEx0CcM=;
        b=b6v9piNM6I3uim4hN1pDWJ/XlkJD+fRUXSpuo/2fs+ZKpaVOhbyyV5MsXzZXGoCGB2
         21xpEBOQDsE5syOykp48lZC1yPMaWINRo/yEAKED3pUVzk1PfTTakOpnqSCzt+xX4/lO
         rpyVXd4Sj598/8ZxtN/wBT56xgipMuOICNE6J4Jw3lve4qUtyd95SHwDC+tboXDQc0Yr
         v0C77Fr0/+3TJZ78c2VKVyEwdti+q8sxDHNEkh4xOpkbvR8oUDFEKrTuBEsCio5bfAjO
         aF1RoKs5XpZ1wbTYDeFH4A+A8UjtrPcfpgQmLjIYEo6WZDvH+k3SJs5xwjDzJfj+YZw4
         KjGA==
X-Gm-Message-State: AO0yUKXKd00I5j5+JhFAHgFyOf1iW/LGBKPt+pYQGaaAin3x31Y7R5el
        1YTdCl2+DNkTZq24mxAhI4g1+t5TqedVtaUVCuWuRQ==
X-Google-Smtp-Source: AK7set+THPJY0r+gq7j9HxAaYo15eWTi71Mf/1BMofHghCC0pVVWU1UG0wiC50b7oxUVS3QUrM4pEGGHHFx8WM+5gnk=
X-Received: by 2002:a05:6122:1884:b0:406:1fd2:bb76 with SMTP id
 bi4-20020a056122188400b004061fd2bb76mr2867651vkb.0.1677646469249; Tue, 28 Feb
 2023 20:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-18-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:54:18 +0800
Message-ID: <CAGXv+5HpKhmxALPiGQypV8b6q_E_Q59eVf6fGLzqkknCb-M7tg@mail.gmail.com>
Subject: Re: [PATCH v3 17/18] arm64: dts: mediatek: mt8183-pumpkin: Override
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Override the PMIC-default voltage constraints for VGPU and VSRAM_GPU
> with the platform specific vmin/vmax for the highest possible SoC
> binning.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Suggested-by: Chen-Yu Tsai <wenst@chromium.org>

Chen-Yu Tsai <wenst@chromium.org>
