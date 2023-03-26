Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA3E6C9884
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjCZWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjCZWUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:20:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE815BA2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:20:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p204so8207209ybc.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679869207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=foOnpfIYG0px2xtCe2qdMBsyq8TVBOTSn6mu2GF/zDg=;
        b=GPT1qZRYCtzPeP8RsM5dc0gjR9NijUAa26kXFs4Ub0oDIh70ssYWD62OtMFvdZevFe
         EXX/xFjzVqZvEvNAAnFsznAYGzkgNmt91cGh/M2H17IklqNKyT/+o84UqwgNG3i4kcM9
         ZnD8h4l3Y5pOG0rgpjZ5ySt7LDMsEzgL3I3fal8Rsvxlg4cRl6mD8ehmDfw1RMqonjiD
         1whV4KLxPJ/AL7bYP0Ly8hs4ZBlCHGB/A8/sWXBbMA85sLjH3TRk1X1NytKMqlc3tP+f
         Auxc9uE2ljlW5+tfXVnPCLXSULfH+fnjnYTTYhdo3ZA7mOB4qF8U9nvBZnQa/vuI/w0+
         yNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679869207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foOnpfIYG0px2xtCe2qdMBsyq8TVBOTSn6mu2GF/zDg=;
        b=bg6uVq+fJQThTQukS3C/nCR6R+XnFJ1+4tD7zTkEUdIExwT5JGhI8RSnUBad7Gs8aj
         ifmnA3CJERGPLDc7mxigjfbdGaYOlRxKuy7uqAB2YyyWno8l6JWLJqQOxUvemvcRcanQ
         udne+4mXRXF3b9pfJBEiIl8jkHWBWm4mQ8KgqqsUWyGxOA4qhNGzoduATcGxfIMoVEST
         x1MPbY8qSNsNZ+MZ9vdmFUbYGmga2ym8PKBrQfbL62vw+ywPnWQvICUh5Th/g9THy8Vw
         yyyAg2lBclx6uFyMOt5p9mQ82rtwTKbaMwvqdbQrpUsj4dbLvat2hdjoE1KOPpgx0wfV
         PZCQ==
X-Gm-Message-State: AAQBX9fwPl9inPc6D3hNY/eH6vckRXGwtsMXpLyveiEYQ4ah8UUsHcGu
        4+OUXmcUGmFBLsgceWVHLDbgyzdpVyqxCvpksLucSQ==
X-Google-Smtp-Source: AKy350YCDKOFoHOb5/Bc82gl0QSgBzmoGtwsAhdj0iVIryNrpBQmYK61Y91NKeNBLwElnbOicqiRIEVFcnvbsuvsHnU=
X-Received: by 2002:a05:6902:1549:b0:b77:be38:6406 with SMTP id
 r9-20020a056902154900b00b77be386406mr4139356ybu.9.1679869207636; Sun, 26 Mar
 2023 15:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 01:19:57 +0300
Message-ID: <CAA8EJpp5+G=ujJQ_03+FWXA4N58pznCnXho-ctmdBdrT+Bi+sw@mail.gmail.com>
Subject: Re: [PATCH 01/11] arm64: dts: qcom: sdm845-cheza: use just "port" in
 Innolux panel
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
>   sdm845-cheza-r2.dtb: panel: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
