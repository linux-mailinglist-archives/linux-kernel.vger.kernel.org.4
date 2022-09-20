Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E65BE896
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiITOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiITOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:18:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E396580D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:16:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so6569760ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BV+bMpM/fk2Fhnz6QLswtDiUmDEO+rj/bi3ZNDBFzjI=;
        b=A9JCOD2EYEnLgHDjhV6RWfz1gM9YilfLikmnE5+Pir+vBmFKGDsLfb7YQPjevWqY0g
         A1kAaV5v7wZ/QkdXwe2IKIKt1bzYlpAs+ilbD/zX2URREqonYlVGmaJklILYlgQMEUhw
         q23d6OJTaNUybc6+WSVxbtCczs0LizrKzwrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BV+bMpM/fk2Fhnz6QLswtDiUmDEO+rj/bi3ZNDBFzjI=;
        b=iRKZWyOHXF6HsE6CLOyave9a5KC9xBGws6O5e04sd4qQyHy1dhy38tcekjiJCG3P6n
         CyW5AwBY69gAcQucfUgGpFuhxvvdfqYBwE28s3OVlTXSbpTWTG0T5W4oCn9EUX1Qbtwm
         lYr6F96FAGpzVLNuexAwtoaqqiAwndDZZTpTqcbKB8cKuohaoTFVcrJXVQ2IlOfVzGJ4
         i63wA70XD3c+ffwYMQTGutnVnCgNLPbGup7X6wI5iKzVudFhRMMXV37ozGCoRiV5Pd+B
         g7y9Jffw8REtTkXTsCs+9xvzuX/7LbuFPCLYpH9chc/Bo1+nHqXWGoe2LkjIIyDaeZN0
         GZhQ==
X-Gm-Message-State: ACrzQf02KwYsVFer0kTHdMFI4C0HFj04SbzCOg7g78d8Zu/SyzvHCIfI
        eQiRxIMwHIvoyl766gDzWl/8V4meV+ALCyHe
X-Google-Smtp-Source: AMsMyM51iQc8DqTfZoTSz3rm4K8M8D3B2JbPW5V30A7Y3PFbMGku2zFeDXq85IQVCMmauMkVYDX9zA==
X-Received: by 2002:a17:906:8a66:b0:781:714a:1f2a with SMTP id hy6-20020a1709068a6600b00781714a1f2amr6293367ejc.205.1663683361145;
        Tue, 20 Sep 2022 07:16:01 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b0073d84a321c8sm897678ejg.166.2022.09.20.07.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:15:58 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id t14so4509163wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:15:58 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr14878330wra.617.1663683357727; Tue, 20
 Sep 2022 07:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220919165808.1.Idfb956ebc035c3bd0d682f4697c297c7a975c50d@changeid>
 <20220920114020.2185607-1-sheng-liang.pan@quanta.corp-partner.google.com>
In-Reply-To: <20220920114020.2185607-1-sheng-liang.pan@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Sep 2022 07:15:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmeLSyziXXuOgkWUzhkOy7_wTyv=SF+JwnYh4NkYCa=Q@mail.gmail.com>
Message-ID: <CAD=FV=WmeLSyziXXuOgkWUzhkOy7_wTyv=SF+JwnYh4NkYCa=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: All current evoker boards are LTE
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 20, 2022 at 4:40 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> > At the time that commit 2abf6b6b9429 ("arm64: dts: qcom: sc7280: Add
> > device tree for herobrine evoker") was posted, all herobrine SKUs were
> > LTE.
> >
> > At the time that commit d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs
> > for sc7280-villager family"), the evoker board device tree hadn't yet
> > landed.
> >
> > I belive that the above two facts mean that the evoker boards ought to
> > be setup for LTE but currently aren't. Let's fix that.
> Evoker should also have wifi/lte SKU,
> I think we need to follow villager to create evoker.dtsi then separate wifi/lte dts.

OK, sounds good. I'm happy if you want to post patches for that. If
you need me to then let me know, but you probably know better what
hardware exists and at what version.

-Doug
