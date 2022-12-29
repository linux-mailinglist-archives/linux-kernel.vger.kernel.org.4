Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDE658862
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL2Bfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL2Bff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:35:35 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0310066
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:35:34 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-14fe0e9ed11so10486268fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GSGVEBKAIlZ/VnnDwbHEfeqaFj6W4dYVfJZG8J1vDEo=;
        b=gsovTz3yzb1pKKs0dp289XjkaJot2Z40OSbWPF2alhZHXfW++J5gfpK/oO9oqRSEwq
         gy+ZHb0kLlJeq3lwip/JbZW51xKV6WHIqFcRMLCTJBLOWg0AcMH8pua1smaY5X/auMKw
         4tda35LCLWxbv6U7m2HJY7+Y142RGe7W3bdRbqpTdmoLIWMORkj3hATr7Z1DZpWqeijc
         7rgK/OJue/1jwA2047Xf4/YXLAFey+WkMLdWqO/slCMnjQehHux8uTbKNkSCEkVOJpYE
         /MVLjWkYYfJqMNmZ+Wp/c7DDMtmi42RoH0brk40ndz37MzngbuKkeytx/ybor/xqWFcz
         absQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSGVEBKAIlZ/VnnDwbHEfeqaFj6W4dYVfJZG8J1vDEo=;
        b=T3G5+GEL5+J02+CbuF3aPLCz74bNviwiIvdb/AARm13U8S27LEl6rrnqCgaQlXcEM7
         nkXHRNP5NTe9qxIUDJvcbI5GCUznx3qfgEc4Jaf+vVa/mCHl0emJarGnEK9irIDEwVQN
         X4IaAMRnIwNE2ztjaLTC1hcA5wS9Pfs3EckJSz2HoGuMO11qDvZT2bjnswpcijTgPVr0
         4eihSYe7yF9A6OLgoi0Y9vTFN1rnLQmRjaJE6AMAz60fi8bv1r7dM5BshIml4s/nxT5a
         5uYQ30m0KFdb/lwr4vPX6mDMpONfBRbgLWj8+uG1o1Aidt+4bvdOXr3IRMxUv9eqI1k7
         xMFQ==
X-Gm-Message-State: AFqh2kqsid+vfWazSH4Ay04HV03c21vx5NnE2QNkiWrGCg25SANxPFb1
        uTD/+7kKfs4DtzxeZ4XhyslM1HqbDlgbMzhyObqU0w==
X-Google-Smtp-Source: AMrXdXvMwXPYtYQv54THgA1W7w60L7MLGAdEz2x/u+WyEhE+Cwj1ntLWJ1S9Qxazr8++Wnd8vJezQiZLoOp7G5hQ4Uw=
X-Received: by 2002:a05:6870:6c0b:b0:13b:96fc:18c1 with SMTP id
 na11-20020a0568706c0b00b0013b96fc18c1mr1778248oab.291.1672277733910; Wed, 28
 Dec 2022 17:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20221216230852.21691-1-quic_molvera@quicinc.com>
In-Reply-To: <20221216230852.21691-1-quic_molvera@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:37:28 +0100
Message-ID: <CACRpkdbbFetp0rmOx3k4kaQvFZJWNQGeW+VC_ry3pRcEiDSOfg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add pinctrl support for QDU1000/QRU1000 SoCs
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 12:09 AM Melody Olvera <quic_molvera@quicinc.com> wrote:

> This patchset adds pinctrl support for the Qualcomm QDU1000 and QRU1000
> SoCs.

Patches applied!

Yours,
Linus Walleij
