Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5D6203D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiKGXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiKGXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:36:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8B5FF6;
        Mon,  7 Nov 2022 15:36:04 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s196so11913840pgs.3;
        Mon, 07 Nov 2022 15:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6+t9BRAAElMuyAd9jyg2LbJwD0gdcLK+WHij3+TgOQ=;
        b=Y9dKowagG/XvHm+0TMIIOSnLsxlrWwlZsxSRqyNr9WaHIqQ15ZRys4gg3i3ZxbLAv/
         P9qg5BVFP0liD+HoB/3rKLAN0ioiCaeqInm8/R4dfoEMErqroQ4KJsl/myXFepxOfDOh
         h4tsaCDdoY6mzCVfTzQ9mv8uveer2lBcHLaYcIDE1DnykUjbn/ZJgH7H4gD9WZ/vWacI
         Kr0K9q4v7a3ZfvihQfKbPrjYkyBpORSXXPcx4JFSbitBwaVaOdFMiTFwoxK55focdox/
         Wp3pj3YyI5vtLjfFszntwNjp+pBe7jIGdCEprESurQGt+ti2zdAlKXdHXHV+4aj4QYTc
         b3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6+t9BRAAElMuyAd9jyg2LbJwD0gdcLK+WHij3+TgOQ=;
        b=yZJlOS593F1Xcb2m81sLvmjBGNn7PXyaT/XtAVY+Ivcxth/d3AUNGot2HjBESlqWet
         LkuxlqhZEsgbSdXVBEkI869WhmBd0EShIIV6jqDTYUHv+8qrX4Qltq9LrxOaSV6LNv06
         DSlWJJ2xucECKL1DXSD67W53GwbPzT04GKOYPx61f0sQBQlVEA3OTBl3/wjovwQ77Q7v
         tK8lDXrDFZBKyjPgl7YWx0WaqjxeOvFBJU6Xy3YcrgzGpU3B44QoziloAxElH9SxK1Er
         a3LbQ8Ix3zne4zQYdAwWcl6MFs4nN08SfPjU6OPGYGfI0b1y9IV8H2HmpSUqUJnVWBek
         xVMA==
X-Gm-Message-State: ACrzQf2M32KnHK3K0J/tVaxT7qDh4cLaM9Ay7Ppmg5wNx26pQsbcXNTH
        OGXT/JT+Tw3q4+oW4Crg+uAZnt/5I+sFiDEXgxA=
X-Google-Smtp-Source: AMsMyM4I7+RU/c1gxy+M/sT3xI/aGM5k9qiVJeKfAcM251JephW6u7ff0aPsPIxtFOTMF88/Qw8JhqGe8eSqGKUQsME=
X-Received: by 2002:a62:1b11:0:b0:56d:568d:c293 with SMTP id
 b17-20020a621b11000000b0056d568dc293mr45767339pfb.41.1667864164431; Mon, 07
 Nov 2022 15:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20221107145522.6706-1-konrad.dybcio@linaro.org> <20221107145522.6706-9-konrad.dybcio@linaro.org>
In-Reply-To: <20221107145522.6706-9-konrad.dybcio@linaro.org>
From:   Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 8 Nov 2022 00:35:53 +0100
Message-ID: <CAB1t1CyNJqEeEkmd0vOgexkrjP=bB-KSMxuDgzswG7MMkDksgA@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm64: dts: qcom: msm8992-*: Fix up comments
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
