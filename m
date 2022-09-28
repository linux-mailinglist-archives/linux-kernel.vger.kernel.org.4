Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE825EE81B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiI1VPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiI1VOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:14:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8926386B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:09:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sd10so29717984ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+ArxDvTuwZCqYAL4oxkzddYwope7pEyQh00wDZZmRZw=;
        b=ZNuUawCKUbpDRAOEhyisqFnqgWkwjc6wcmEMGa8/n3L+N/G06/AMeYSykqhwwIPeFI
         K8nXAS96Gf1KKd3jCQcu73EJUTgkaV85LMzxOeQa6iOxI87ymwLy6Mf741usdSDkozd4
         hDAch4AgRMyEKZYovFzcUcVZvUgflsqK5e3BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+ArxDvTuwZCqYAL4oxkzddYwope7pEyQh00wDZZmRZw=;
        b=Jx0v1THqjkw2DFehrXZrwfUE4zRzofmB/i4I+3DoaGHUCjQRnB0iYScO3978in9Mpz
         8VJ+vWLq44guBcHZmx5vl/Q6KjEdteGw6u7wLtnhZG98smWbpw7R4jbU9NLHAHbfeLvp
         JTmi79kbhwXgixBUk8jv1pqcdXPxR8t3CWqZnJz6yB2VmHsfAR7tFrc1Fd3RPbyjlc20
         G64Qlm/q8G+oHEjxzJYn5kwky02gII3C3TBYnZjNjEyqG9g+yZ4fdYxlN76czPVhRiWk
         uDlTknB47SYLF0ud83eeviIzpHboc0JWbEhvHzx4IgJWdA2prg/vHybenD9+zjSLEaO3
         TAUg==
X-Gm-Message-State: ACrzQf1gA0Kp0Iq+C35Tt56gPidvZW9MX1VRK++Jp7H6Dv4tllH17ULU
        7E871TsY2LOmd2umbA/6MegJ82F9tOeJ+1fO
X-Google-Smtp-Source: AMsMyM5D5v89kh82bH7kbM1lGLunTrzCdElYFAq6JdbkROu7rofHPzToiBrs7SQn09gNB++g54WktA==
X-Received: by 2002:a17:906:fd86:b0:777:d739:1ede with SMTP id xa6-20020a170906fd8600b00777d7391edemr27321466ejb.576.1664399285569;
        Wed, 28 Sep 2022 14:08:05 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ty27-20020a170907c71b00b0074ae59d85a4sm2804221ejc.20.2022.09.28.14.08.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 14:08:03 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id n10so21575130wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:08:03 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr22722202wra.617.1664399282903; Wed, 28
 Sep 2022 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220927112343.2700216-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220927192234.v4.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid> <CAD=FV=Vu-bZFeZVER+dP4pTD6UTTLFhpJX=ZxurBbkep=8uHyg@mail.gmail.com>
In-Reply-To: <CAD=FV=Vu-bZFeZVER+dP4pTD6UTTLFhpJX=ZxurBbkep=8uHyg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 14:07:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uv9R691LZP65ufh2oTQSKCdTdqqH1O7j99dT07svsdEw@mail.gmail.com>
Message-ID: <CAD=FV=Uv9R691LZP65ufh2oTQSKCdTdqqH1O7j99dT07svsdEw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 28, 2022 at 2:04 PM Doug Anderson <dianders@chromium.org> wrote:
>
> The above is an unrelated whitespace change and doesn't belong in this
> patch. Ideally you'd send a v5 where you didn't have that.

Actually you probably want to send a v5 anyway with Bjorn's proper
email address. The fact that you have his old linaro address instead
of his kernel.org address means you were probably need to update your
git tree. Try something like:

git remote add linux_qcom
git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
git fetch linux_qcom
git checkout -b my_patch_series linux_qcom/for-next
# then make your changes and post them up

-Doug
