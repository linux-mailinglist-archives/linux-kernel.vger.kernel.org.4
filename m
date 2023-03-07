Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502BC6AF63C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjCGT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjCGT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:57:18 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48628D17;
        Tue,  7 Mar 2023 11:49:52 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-53d277c1834so89034347b3.10;
        Tue, 07 Mar 2023 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678218591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODAdwNVzEJVs/dVcubwVWxE4VHHfEBFygq2METYrA4Y=;
        b=edXlVQihYWjJ+QB7BAntgm8hQCzpRqyY8m9YUIt6o1UUMtfFrw/g9FQB3kfQPoa6z4
         YQX5Kb992sM1Iu/rNPY7o2+YntD0HkyJ3f4C8Ipi+Vk5ne6UlQqCg0AniqAwyMuzEbzB
         KYe1rOe1Oj91KgQylfkuNSIDjxvutf5r5+D8DanRkNOf39ey5lcVpmyNU44lz+gLKZc7
         mNwTajLLVF8iSs5ueU/edYWVuULm6hzyxartJALU9cjPUo6rFQqjXwnR8dOXurABYxhm
         Lr1sUG8WihHrWe/YVid3gYRwggk4ulyonvucc+nU+5sOjcM4yjUQG11glkaRLuDN/lkH
         CPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODAdwNVzEJVs/dVcubwVWxE4VHHfEBFygq2METYrA4Y=;
        b=3Ef4BLTaejgeGxQID2UOrClwA1v+V5/kEokGNCJtuSj0C7H5MHO0Cgaf8D+WNIb669
         KnGXnjKE/gyYKmKaKv0pBDjV11D8giQkbPtMKoq/eDWO+nWSUsHr4oLrVpYDbevCsLa0
         m6qYaO5DctyoJ5hRyDWzeA5v4yxCvW7u5pDrer47hjRoQG2wHwqFXxZ90RmIgNo6bVS/
         uJBbVvaYWxSs7PVr6PsPwPxHorgdeKeFkDRiqK/0AUrhXBLHKO5IkfbAEk/kgzMZgaco
         QW0/DjYzEz/Fa16lvfz1ms1zgRTl3Y+NwaxeJ0SHE0nK3+Ss0IIJePiTn/UFq4spTqHB
         v0lA==
X-Gm-Message-State: AO0yUKU+g6RWReh0afl+sgUbO3heDFeYe96nOn0tF62ABXPW0ym/yenS
        A4WZoUu744za8sQ4t6Nc5EjMxKvIs5uPye3fZwo=
X-Google-Smtp-Source: AK7set8vM+CMZxlxyv98A5MqSySRyK6pMxOHBy+yt4Xqs6h/E/gYFtReoHnVnhgwyuh/iIE/+mx+uwpfbPMHV+Oi2/I=
X-Received: by 2002:a81:ac27:0:b0:52e:b488:744b with SMTP id
 k39-20020a81ac27000000b0052eb488744bmr10217793ywh.8.1678218591459; Tue, 07
 Mar 2023 11:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org> <20230305125954.209559-9-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305125954.209559-9-krzysztof.kozlowski@linaro.org>
From:   Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 7 Mar 2023 20:49:38 +0100
Message-ID: <CAB1t1Cz9vmAjdDS6C0CA+UEqAZeEJ5H===MajbtyAbZR8M1ohA@mail.gmail.com>
Subject: Re: [PATCH 09/11] arm64: dts: qcom: msm8994: correct RPMCC node name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
