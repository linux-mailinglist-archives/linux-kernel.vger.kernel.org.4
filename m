Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9678B668F12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjAMHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjAMHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:22:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939465BA33
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:13:32 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f34so31823850lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAu7No8qt/e/v1T3l96H1YRY9RrDFjfQSEolreIJ/PE=;
        b=GBYbwLJk7yIjaIlQOr1em1Q4HKX7FbjshI8bLNwAouu7Wr/s0KWDvUmt6r+xnWeunN
         A3Ti4quDFtPJqC7SHrR1lBaVLWvxSBo8zQvifEcXb5+T8HSQPxwM+y6mIHePX05oV0RM
         qBNrjEiH8gAYZh7L+XVcwqgd0obzWg1xjYplSmZe3Oh5IzmBCVy3JjXbK4Cz/SpSnBaZ
         RI3ZyDuocVJ4nVMbvynW4Esal4uFUIyDIxhNi/iOSXyQOhVv3fI1gqBN+qMpTIZmxx4l
         og/OcwntyqXlUF/WEmZaD07LHp1RQ8SDEvgbIJJn8JrwMjDloHTxAnShJOjeUwSrNZtw
         o2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAu7No8qt/e/v1T3l96H1YRY9RrDFjfQSEolreIJ/PE=;
        b=rA8eK2GPzrg86cNQPYqIo2wBrHwSEA1kq8c8VgToih9gzf4aJVKN2kJC3EGVbPVYI9
         yroh5k4nSTQk/LF9a14I8dWM5nVFWWZvAdAKPSA/sCfiGO7ZLaPs15Q+pVSrdqpGPWOC
         D0PbDEJp+yoQw0xLaCyv1CLKc+IHOrZcyzZ7h63qO+4cO0+bEBvk1WSW3gEK43C3kJiz
         9xXpdZc/k+xKvLFJ7mBhge9eRr7JQ1MF/MPQPY4WOA0NnAs2F9185J/rgHEqHG5dpef9
         7Fxc8IqT+iz+pas9+GU8EzxMKHFhWqVZUYzNquWztYHrzcNTmLMEtxJueL4vcjWG7f6e
         Fm5w==
X-Gm-Message-State: AFqh2kq91TTHc37AFkN1ArTIcYP7x8boUZRB0vAxwRy4D9DY/zat/vRv
        Q69bAXHNXrBjzqs83vlNeXsa6zUJyuYJyF8DHzKfVA==
X-Google-Smtp-Source: AMrXdXt3hH2dGv/f25uVCkUiSZ3SoiP77zGi/bYcunYQk+MtWJxq0LKObOyy+eTdMp0bIa6h/rL23NxhoK9iwRhDw+w=
X-Received: by 2002:a05:6512:298c:b0:4cb:23b0:5c17 with SMTP id
 du12-20020a056512298c00b004cb23b05c17mr5129822lfb.648.1673594010894; Thu, 12
 Jan 2023 23:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20230113064457.7105-1-jensenhuang@friendlyarm.com>
In-Reply-To: <20230113064457.7105-1-jensenhuang@friendlyarm.com>
From:   Jensen Huang <jensenhuang@friendlyarm.com>
Date:   Fri, 13 Jan 2023 15:13:19 +0800
Message-ID: <CAMpZ1qGtcFaaGK=72Qp9MOEDDvcxb_Gpqir7_+ZCL_ke4XrX8w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add missing #interrupt-cells to
 rk356x pcie2x1
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this error while testing on a rk3568 based board (NanoPi R5S):
  pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
Also I checked of_irq_parse_raw(), it looks like this property is necessary.

BR,
Jensen

On Fri, Jan 13, 2023 at 2:45 PM Jensen Huang
<jensenhuang@friendlyarm.com> wrote:
>
> This fixes the following issue:
>   pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
>
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 5706c3e24f0a..b3185e4115d9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -985,6 +985,7 @@ pcie2x1: pcie@fe260000 {
>                 resets = <&cru SRST_PCIE20_POWERUP>;
>                 reset-names = "pipe";
>                 #address-cells = <3>;
> +               #interrupt-cells = <1>;
>                 #size-cells = <2>;
>                 status = "disabled";
>
> --
> 2.38.1
>
