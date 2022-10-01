Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D35F16EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiJAAFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiJAAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:05:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339B20BD6;
        Fri, 30 Sep 2022 17:05:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id t16so6361028ljh.3;
        Fri, 30 Sep 2022 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K8ClR6wuWMGu2q19G/42rzSQpT6MwqxM3bOaaClXmSo=;
        b=HEbCLKvFVeKu5CMnEwqMkqOzuvxQNiPCNut86l3UDbp7XZLk3GqlDm0cg9QG9tjk0n
         xXjsVGcRfxzr8sDBeegxoJbddwfGahcI2CkZh1SA01EfaAn3izbC3ORzTf9gYBQWxi2F
         aN0Jb2N84awx04gDuS6YXtTTO6q0h5C3Orf60ipbV6THEtC8jo55NOqhGLqpaBdN4MFv
         5KqOGTSDrddNjf8OdiblraV1zUs2sJtRiAB68C5cNdRW3WD02r4eAnZ2BDAR7vhLCdo7
         zE6eE42cNAw5mIjVwgUDHeOM8bNOP0pE7COT9L5cTvVa42D14gwj8e0lhkIAs1zcfwPE
         N/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K8ClR6wuWMGu2q19G/42rzSQpT6MwqxM3bOaaClXmSo=;
        b=m+tESQNZqOoK3MQDV6qi2QShc/BU3RmtI+hFfFnx/iSdKf8W1jATT/jpbklNGtKLgB
         uHozmF7n50VZda3FFt6YAgUo3ypPtGYd2MLOx0k6yDzKQ2iVE0kC0ddZSzYj+905EbJl
         spz2N/8TdXgsqe5Z+mL4+gHHZn+t04LW06Xc09yeEbJXXWYjReOR+nCrDUhJEPvt/Rum
         mHEMz9tU/teRNTjy8DfxXDCORYXS/g4bZ+1Q3zXcZlTfIlre2OkBRKE3DfAqQ7as7Vb6
         1d6jabxTM4lRGTU6MZoHv9WuabiK/sztPJtx56rQzeQRqCa+yCd1zjDw40Dpbh4KAQ2r
         DAjg==
X-Gm-Message-State: ACrzQf3OXOBy2X/AgmJhfyHzk2XHokbOjXdhxEUtNRF5Qy2raKJB4mxg
        qlHw6gZOYT418UD4cEH047YrmEpEN7tbgaGfWJc=
X-Google-Smtp-Source: AMsMyM5o5ymhFKVExBFI/Oa/fsktjvy/S8Csm27p4UBP94WMGV8nOHJ127p2bk/1M9WXDMNxqChgCcbKnh2VC7by4ZM=
X-Received: by 2002:a05:651c:88a:b0:26c:81e1:57dc with SMTP id
 d10-20020a05651c088a00b0026c81e157dcmr3869687ljq.236.1664582724307; Fri, 30
 Sep 2022 17:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220930192039.240486-1-krzysztof.kozlowski@linaro.org> <20220930192039.240486-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930192039.240486-3-krzysztof.kozlowski@linaro.org>
From:   Molly Sophia <mollysophia379@gmail.com>
Date:   Sat, 1 Oct 2022 08:05:11 +0800
Message-ID: <CAK0UmJCMcva6WowBosEvdqNfBnF-372n=nhsFNZDwUYzBMXsWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-xiaomi-polaris: fix codec
 pin conf name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Molly Sophia <mollysophia379@gmail.com>

On Sat, Oct 1, 2022 at 3:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Fix typo in the codec's pin name to be configured.  Mismatched name
> caused the pin configuration to be ignored.
>
> Fixes: be497abe19bf ("arm64: dts: qcom: Add support for Xiaomi Mi Mix2s")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index afc17e4d403f..f98259489679 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -628,7 +628,7 @@ sde_dsi_suspend: sde-dsi-suspend {
>         };
>
>         wcd_intr_default: wcd-intr-default {
> -               pins = "goui54";
> +               pins = "gpio54";
>                 function = "gpio";
>                 input-enable;
>                 bias-pull-down;
> --
> 2.34.1
>
