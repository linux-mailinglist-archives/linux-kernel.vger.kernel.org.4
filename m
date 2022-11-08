Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3D620D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiKHKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiKHKar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:30:47 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44954044D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:30:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k2so37426270ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=atid+edrTzuA80uie5QzASVMiLlCSb3CRaHv4tRjrTo=;
        b=MVT4fW33uw7BUUBENA2h0LV1Q06r+UqbCZNEDgKULbWhbaBkr5apVHL2rx1O+g8PgH
         c2EMukiFZDuQYe2l4M/hz8G7UxJ9znVy4hQHTuDLytfE5WvFbJp2kG7Fl++xEzwOmRzU
         kSoimhpnWfoF3JP52N5zc5isTOagoCadDirj5DKlDroCCHlmItdjjPBVRqK/Klxfnzmn
         ylxfCz7F1v4ZqjzMj6JNF5uDAyNXT3b+HN6q41mG93J6LhKZlBSDxOT7dEKX0qgsx8r6
         0ncJJbT7GxafxPLN5gHwihgOcT113BQ3yKaFRoCmxF5aQc+ANwm4qEmjeaCAn7ozdxm7
         OdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atid+edrTzuA80uie5QzASVMiLlCSb3CRaHv4tRjrTo=;
        b=aiTEjP2/LsaM20IJVehNQl9tB5vSnF6YhNzy0gd/Xzt0L/9iSmLkosm4WUbkuDSAwx
         VCt2fAcGRc1h1+n1MH3xB9ScvUYs+GD5xxnIHPr2gjUW7ysm5FhdLoBAdXPQYuTpNW5o
         9Nfav8ZgxZgKsGAgVXuaKzDAgClgaL8fK2Q6pqjnmtXgNF4mUHNB2D1/X6wS7OC15V7n
         tMxEvYQK287+/hpoe4oDfZCkedHYhhM1pPUykEUo2vO/8khEtqXopf1YS2nf3djW9iWD
         yElOAJjZ2Loo9K7atuD+vZ9/C+ShqE0BrIo2fpgSN0ex1YqaleUHquxzcIL5dgQHfIjV
         auHw==
X-Gm-Message-State: ACrzQf2EtnPL7ajij8az5QdcdI1cyM+Q0ErWaSjSER2409zM6gvPzk0z
        j4nU8YjNh4MyJYnjY9MA9rGeAvNEx/qnH55ayjJuzMDSzfg=
X-Google-Smtp-Source: AMsMyM6C4pYdpFc+2xWSYisNGabYiqSF7IYYb9LDhANci3pbCXop9mslrGeLo/xG0Uw0avfdB4yFFoIj54JUCGNp/Uo=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20498403ejc.690.1667903438431; Tue, 08
 Nov 2022 02:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20221024002356.28261-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024002356.28261-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:30:27 +0100
Message-ID: <CACRpkdb8JN1R2tG0o=zKNkMohDSAHHz-K2QC=mjJfPjNC6TaaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8916: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 2:24 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Convert Qualcomm MSM8916 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect that I get this in a pull request with some other qcom stuff or so :)

Yours,
Linus Walleij
