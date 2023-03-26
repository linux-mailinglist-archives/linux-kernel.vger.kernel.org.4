Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2F6C9878
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCZWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCZWTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:19:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70074EC6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:19:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y5so8263884ybu.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679869152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3RhjbUKhYoFJPGpVqkj+RfFM6ZDQt5Oakswv0bATk0=;
        b=lisZ7rPJ4DmRmWsSoLubEUsPm1Zp95wiNM9bSmuMrael6PachvqS6FwUpdR20alj5V
         DBQYuqyCqJQJJ1kPFbEadAQBHtgHhTsM3qhzWBnzGGpNqYejfJ6JZqtlpMOXw88xv6mv
         zfOSXxceyvoqqw9qaxiUYh25Da4tnrTBVFIxJAk3YXyrN61TLCCSB00FRwCKDXjCqfwq
         OxsqENqcjmLJ0DWN2R+9el3h0RegkEq62rWeIyOJeOvAXiYq0U+CnqpPVQ519xGaFP5N
         8V9R0ilfnYLLmkaKUV0IHDmzO8S2qhKDFP3UJSKsgnzItc+oGwUAO3emh0/WyKh+9Ldn
         kTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679869152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3RhjbUKhYoFJPGpVqkj+RfFM6ZDQt5Oakswv0bATk0=;
        b=FTx/K/kCWmJHyMDoQk5qPrA3sHdGoSrqWg+24Gets29+49QNwXHrfCoXXJPcD4D3Gn
         9CiU5ZS7sA5ZL6/jFbhx5jKGDhbmQKKAgzb6KVDg/x2NuQWOfeFcB2q3uJqg3j9NCNTb
         mawCC6MGa/kSta/nIM6Avy8q42NKXtayvbvtl/1OMuHEyT/1G4nOSCFi7Ww/QfMMVMnw
         K/Nl7DoaYSxLwVtbO5YISWc5CKdVFneseg1qkCm+jIb8GDz49Hv1EDtMWt2j+fljRfSa
         xQ0rgnE/NVF0PMJovARm/LTCN+1CkO4V5UCwAPTy/sMIINDJk/62CvpLFI4CjCU+roUQ
         1Gnw==
X-Gm-Message-State: AAQBX9eFzVyTjNdlW+gpTX+/HgABN3axFNqqRiFBKNpGtkJrnbMjCms6
        FwRFYCV9FNmPLtEr2RCXU6HneNa/SfLmOdaZ+j7Z3Vip7oD1bdlj27zACpqY
X-Google-Smtp-Source: AKy350be0EIzoZQ0Pt5iVdCMCp+n/nPurjKJ+P55Og2QJiR49E58Pc2RJUB8ABQAhmXA8qmkmnjTIkUiAnoIlh+gmmE=
X-Received: by 2002:a05:6902:168d:b0:b6c:2d28:b3e7 with SMTP id
 bx13-20020a056902168d00b00b6c2d28b3e7mr5704650ybb.9.1679869152192; Sun, 26
 Mar 2023 15:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org> <20230326155753.92007-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326155753.92007-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 01:19:01 +0300
Message-ID: <CAA8EJppbQcdNWvptApwsYrLrfgUYGJWmw9CcAe_=kjPgWn3EMQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s:
 use just "port" in panel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 at 18:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The panel bindings expect to have only one port, thus they do not allow
> to use "ports" node:
>
>   sc8280xp-lenovo-thinkpad-x13s.dtb: panel: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

--
With best wishes
Dmitry
