Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2987156CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjE3HbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjE3Ha1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:30:27 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8CA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:29:52 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso1245493241.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685431791; x=1688023791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZN4QnyKrnxiBs4E17NJb3ZAuAuwM5m7siN0Hd43Wwc=;
        b=nYn/YGbyfBNmz+lexWZr0TyjGCBc6NcIQSLPze6+c7Qn28R/DOrhrNKArMa5MNjB8t
         1R8k+DFg4jZkZL85GHp6/9B1DzH6b1YcdhznnkpbvQxC6Pu/46+OWnKV4RjkPe3O6OSN
         5TIwLxxA9CZ7i9PD0m9eKg0/EHs4PGlFcZaPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685431791; x=1688023791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZN4QnyKrnxiBs4E17NJb3ZAuAuwM5m7siN0Hd43Wwc=;
        b=XMi/67r3jwGfAMZdMbcWJN/sWn+elXFuqCFhMYhXPQIM3JnHxNfThZW+mm4/c/iJEr
         br47ZtLkBiejrssZs+zS1fmycB+dG2WVMd4QWCkdFHb9P7yYw089duMZNRLrYd5W2dW/
         WERosJPyuguKjog5fcER5b1+MCJdGrW5zWJ2DwDV03WTJ6NTLlSKn0DZJ+t1fnObxE0Y
         dKGQFuPIn50+e0Z3rsY76+uCR1IxzDCpHke8+roX+0+KZbALLakpUqipj3KTG0Mk5xrO
         PaC6mm+lDLOVjT/PjVo8EYCNHUV8xWSkiPQtWyLsRDsTHFjIPnj/qz9hXJlcR8d7TBr5
         Kfvw==
X-Gm-Message-State: AC+VfDy2X4vAhiA08eMpkvUDcsxfLL/EjtAQYCjD479QEm6rikAVFSmc
        ikpapHdCmag4+i26SvBntdtxY6zCNaWINGk+6bPHjg==
X-Google-Smtp-Source: ACHHUZ685uMwzIsN5k4ruyfFJG+uL5euWQ7CixRe5wGcspUJWh5A1E77FzA1+QPQ6Cn4xvLSstZut1Fy7DkMh2u1aBo=
X-Received: by 2002:a67:fbcf:0:b0:439:4112:820 with SMTP id
 o15-20020a67fbcf000000b0043941120820mr383122vsr.27.1685431791178; Tue, 30 May
 2023 00:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230317061944.15434-1-allen-kh.cheng@mediatek.com> <20230317195453.lpymxjk7oqvbxkq5@notapiano>
In-Reply-To: <20230317195453.lpymxjk7oqvbxkq5@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 30 May 2023 15:29:40 +0800
Message-ID: <CAGXv+5GyLeVBAk_DXJoTxoG400mnq4y6pa1JXRD7Svc4rtMQBg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add cpufreq nodes for MT8192
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 3:55=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Fri, Mar 17, 2023 at 02:19:44PM +0800, Allen-KH Cheng wrote:
> > Add the cpufreq nodes for MT8192 SoC.
> >
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Tested on Asurada Spherion Chromebook as well. In particular, verified th=
at
> applying this commit makes suspend/resume work. Before, it would hang dur=
ing
> resume:
>
>         Enabling non-boot CPUs ...
>         Detected VIPT I-cache on CPU1
>         GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
>         CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
>
> But with this commit applied the machine is able to proceed bringing up t=
he
> secondary processors and complete resume.

Ping on this patch.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
