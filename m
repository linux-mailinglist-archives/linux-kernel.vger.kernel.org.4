Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763707196C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFAJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjFAJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:23:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBF18F;
        Thu,  1 Jun 2023 02:22:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2f4e719eso8096021fa.2;
        Thu, 01 Jun 2023 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685611364; x=1688203364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xu73A7SyMQ/vKw4V8FoQHHfsJoxdUL8BzyNw5Jd0gzg=;
        b=sStLMxnsUA9kUOztr2UAtURKy0UOcEjCG/kCIZ1ItM2EBpXHMYms/al8bzIhiAd3KD
         Bz3BJccK8rqfDE6icjls9TQXlZ6xZz4O01LPUykDpyiymqZJKOll+KgTmnmX3StLa7GM
         x1T+3T1jKsgZI+zAY/Qqlhec+bSXP7yCON8l1dDzIpzfs8yf8vKSG9tFsK8ZbWDtm7xE
         yVUjtkq8GpH/3VSQMdC4hgOipki6EM0ECUHCmgS+pMTwL+B1NpHEhoqDZZCei4N0o2mt
         Ctg/uGoZwduo/SAjE+evrztFryl1tCb8JoeQ/O780johZBI/N/maSC4apzvK0DUfwf1M
         Yw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611364; x=1688203364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xu73A7SyMQ/vKw4V8FoQHHfsJoxdUL8BzyNw5Jd0gzg=;
        b=T3WvFOaAom0xfCmv/Q7hcewPiFrXBq4jQiyLwM+Gk2yjOpnw8dGvR6vJaHe7ifu6+0
         Mt31V0rN5gh/YXF5zjvrRdcbogv4lMwqjwbmMRFEV0WGh2yS5yunVWT6I++SILej5Ubt
         MZ4d1aLQDHMP7i69gtX/7x5C/MOAJO4DaE9T6XH9iN+eNS9dTUQqL+IKR4gx/lBbgzRs
         qI0+6hg669cZYGuaN5Hq4ro0yKl2pAQu5DIzzBzBea6DGVS67X4Xx4U6cRgewbxIcLoG
         pYVopENBL8IFBNCye/Tx3YPxHCD/EocZ+wCh1UzUK8E4G1km4Uq1sKFN5O9tbgZYU6uB
         jE7w==
X-Gm-Message-State: AC+VfDx4LKfXFGmnfdlA2r2s4s4VVOJ/JkcPxVksClzBUiVqRxoyAXe4
        xO0ST8Dy1t+n86jsc6b1X+gEivQxCslG4lRxjpo=
X-Google-Smtp-Source: ACHHUZ41+G57HVbaglyNiCY5aDprCsUSXQubwUCQ4eRJQdir+a5S0eph3E6DQfQlk01eGgpuKDZKTr2BP9dbVWyJaV8=
X-Received: by 2002:a2e:96d1:0:b0:2b1:a3ce:b709 with SMTP id
 d17-20020a2e96d1000000b002b1a3ceb709mr660982ljj.39.1685611364364; Thu, 01 Jun
 2023 02:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230421223154.115312-1-krzysztof.kozlowski@linaro.org> <4a53ed0d-c34b-cea5-b407-066242500611@linaro.org>
In-Reply-To: <4a53ed0d-c34b-cea5-b407-066242500611@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 1 Jun 2023 12:22:33 +0300
Message-ID: <CAP6Zq1gQ0YdEkRw6_aDd_OOkFixQA06jmM_9VOM=uvPnwahoUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: nuvoton: add missing cache properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry for the late reply and thanks for your patch.

On Tue, 16 May 2023 at 19:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> > As all level 2 and level 3 caches are unified, add required
> > cache-unified and cache-level properties to fix warnings like:
> >
> >   nuvoton-npcm845-evb.dtb: l2-cache: 'cache-level' is a required property
> >   nuvoton-npcm845-evb.dtb: l2-cache: 'cache-unified' is a required property
I didn't get these warnings in kernel 6.4-rc4, but still, the patch
has been tested on EVB-NPCM8XX and everything looks good.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Please take the patch via sub-arch SoC tree.
> > ---
>
> Hi Tomer, Tali, Patrick and others,
>
> Anyone picking this up?
>
> Best regards,
> Krzysztof
>
Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>

Best regards,

Tomer
