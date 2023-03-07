Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE166AF639
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCGT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCGT4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:56:04 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE938480A;
        Tue,  7 Mar 2023 11:49:08 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-53916ab0c6bso264537287b3.7;
        Tue, 07 Mar 2023 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678218547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODAdwNVzEJVs/dVcubwVWxE4VHHfEBFygq2METYrA4Y=;
        b=EBGWV9P9hc3MhvtusP8cy+4BsbVkm6N67AT3jWnp1OFU5rEaEQi5sduiRH5mTr+8ei
         mWQ8ihfvkC5X+ezWw45gQhzNl/nlwPwUfENgT3rns1tmdW8YB8WAI7i94BrBU8mKwhEz
         2SXKy/89P2gnp9O1ZeaTkb59HQYtRUX15S6V6dtANB2bJ8rFVe6VwSW2HdZmZ01Ogpi1
         3CJpbCtndTp3o5BDLE3N5VumJziHOXtc7FwsSG3f5j7BqvnLU1ZquM5vVveCzukkIs9Q
         WOF8YncBVIBEydqfhUIF2zmFwB9MszGOD/OM3n+Ftr9IutT8/FWE+7YSaHT1dMqTLgwz
         7ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODAdwNVzEJVs/dVcubwVWxE4VHHfEBFygq2METYrA4Y=;
        b=1I8E1VRjLgV3xsNvv3MfoLfCZeedNvzc9LDwUMX8d+5n93NimXjBW9vO3v/nFx/ZsU
         h+OsozPUUHmFkD75ci4kY+4CKp2Uve5ZRmlGhKp/mIJ2S+wCvoJcwSmSrobGLF3rNcdw
         ot5/vq0WfpfbZmRkJ5B2ILaTlrVY76ENIgR2blmh3lerYqtfc8IH0KjuO8G+Ue6b6pus
         /1q+rKnBkByV76FJ2TzdgxhY3TaB2nf1Eq0IisUc+gUzvJZeBCgaga0RWphP+j5dkO3d
         +AJxoZqzrxDrqCunMRzzY9awNdGmA0Q8UDWU2c8yYzunWZ510dwfpoCysnn8D/Vjbc8F
         HUcQ==
X-Gm-Message-State: AO0yUKV/HGh65WVPy79pwIfJ5E0fvy+IjCEenv5pKJxEO+zE745H4WoH
        sPVXwOnXZvX9sPWHfr2Lq/1Rj3E/A2ysPpEXHHA=
X-Google-Smtp-Source: AK7set8HTAxm99sXyODDgRgvKbJw/T/FIqvJQcIBrp4hcUm2oTnHRLqYjSKe2ZK5X06Pk2qEoBKlCPMSxsoxGSXENgY=
X-Received: by 2002:a81:b64f:0:b0:52f:b5a:9643 with SMTP id
 h15-20020a81b64f000000b0052f0b5a9643mr9943432ywk.8.1678218547453; Tue, 07 Mar
 2023 11:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
From:   Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 7 Mar 2023 20:48:54 +0100
Message-ID: <CAB1t1CzF+E=h9bWWwKf1vpt+ThOOxHvYZ1Nh0f5ep6A=1WZNEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: qcom: smd-rpm: re-add missing qcom,rpm-msm8994
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
