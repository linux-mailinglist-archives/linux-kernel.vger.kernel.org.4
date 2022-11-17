Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060D62D61A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiKQJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiKQJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:11:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C95ADD7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:11:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i21so1588503edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+F5iWVcgnrdzqTiY9j1QAUnZy3iVsRC/Wh3sHGCZWi4=;
        b=LtX/g1RMQt9cXSVGVKP2MDWN/mkziWFTZKiIJ7o7mBkv9dOl7AWs6ncE364jyZC3/s
         i4fLe7LgA9RebQlMYnJb/mmNer/NvTtD47XChEughsfBHOjVHSe8ZeTot75HEF+F+HSa
         GAICHpYZWfWF/bH4Z0sAowijk7vY4kn/89NQHZpTDCLxVwlreQO6Pz0L6eHnkvl+qvFu
         7zmCRpd6EWGARfEm9duTUOWY799ji5srlcmX93hogx/MR6Hy/tARrg1eHeDKuEZz/8eN
         /BFoAbWI7Vavbp6K8WZzBLt5wO84dED+GCxiGVSfrk2RXAqZRE7gnhCYO5s0jUDmk1/k
         QqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F5iWVcgnrdzqTiY9j1QAUnZy3iVsRC/Wh3sHGCZWi4=;
        b=0ncM+mKO4gU3rhUfJfr0wzckUTthOPNUh2KgV7MuvwFV78STjl1yw8k270qh+VlWst
         IY3t06z//u5eDvOdBjgPh5oHDnxLBZZzfjRVKCqbasgkbWFHAEOn4v6yqeqtNbMoaaye
         US2w6n0VzcYsBFyfOl9G7DbfP71ysErnxh9/lnjFOBQYwyxkRUv7XQXBiPdiioH+f4Ly
         OTuOP1iMFXpjbSPIrg47OgghNBM2p/APwyiDsg8VWpkWpbLJWOcPhiVNUYjpREbQXETg
         SIkU0kefrwl4hTBy5ORrnZYRuEC3A1/fwAJgDFe+i44wHCtwPlJNXL9NlOiqoN83+KC+
         c3yw==
X-Gm-Message-State: ANoB5pn0cu3oJUkBHtyCqm0iTcWIFa5+YJ1C2K7chyZsk/UAUZIIX4Om
        i014YmrRKiFopwXLTmeD29PFeotjbZ1uhcy0qOjhDw==
X-Google-Smtp-Source: AA0mqf5DYdrMDRZrvgQEFjePMZc8XLtptBPspZwl6bU4dGYxj8+nqW7gHSkJWAsBBEQqNHFdnkwrNIe+8V0lQ3SebxI=
X-Received: by 2002:aa7:d5c9:0:b0:463:c64e:bc75 with SMTP id
 d9-20020aa7d5c9000000b00463c64ebc75mr1361975eds.205.1668676309518; Thu, 17
 Nov 2022 01:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20221116093939.20111-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116093939.20111-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:11:37 +0100
Message-ID: <CACRpkdZ36JLN_Y7QV5agoCMBf83AH-TCwAvo+yzX6NdkSDS1iQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: dt-bindings: qcom: Second convertions for v6.2
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:39 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Continuation of my cleanups - second, last round based on previous pull request.

Pulled into the pin control tree for v6.2, thanks!

Yours,
Linus Walleij
