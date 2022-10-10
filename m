Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5D5FA219
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJJQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:43:56 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481D6DFA2;
        Mon, 10 Oct 2022 09:43:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-131dda37dddso13122952fac.0;
        Mon, 10 Oct 2022 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5myLNmhoucYx5sLzIgfFeipy2y94xnDcGd39sjhkYms=;
        b=AcaA5y/ZjDNeDlTKW5EepUXm5ZR4XinlM9+t2mIuqdnUxDp/YeiRgKzhFfCFzngKAM
         XsAbqld5Iu/KbgMdAZcQwDW/P8gmhh89rEjlqPv5y1ch2UjUy/bcR8e3iT9TbmTrCxA6
         cftP70YKsmkCQANAUcyqYHEBusGKIQBEb76ikwWRE9QHMXhGQOm/5JtNxR93kKXF3rqj
         /JdPx+3UotfC3mr7+WZrlnUiVtF8o1Thamd11i/ktpGsjdT+b0rbYJ/pny5pg4EWwyXX
         IPGXqbJ0NB45vfxdcdkZ40JsPGqHDlEJ9tBlTgf36vHIWZ9BO4gsi4l8COOZR684K2nD
         dT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5myLNmhoucYx5sLzIgfFeipy2y94xnDcGd39sjhkYms=;
        b=lacV1164IdKFUP9ZMgn6k6aikFn9Lg5jz+PST+yKBapR8W4TdsZ9GRQ1w9vhWAizhf
         V4oKaTZ30vOo0+8dtc9E+GHJt1VTHTeqbxL2Lyw8wKurVSR6fjG32WRZ8J0k+/WMYRzO
         ShtOYsTxsYiEzgUCcGMtN49rQJN5HeXhaJFWgfzQ19E/Ac0F5lLEHl1mDIkabhUfxzYS
         0lxIn5+nRwXuyTBprj+1fj2KluaJXoHQb36hq64iCyg/Vc19pU+5R++TXx1KPQ1DAbVQ
         Y8nFoX+iq3j8zYD70ptgQaaabIgQEc2wSMAABjSic8s8nTp/MFkc9V+bqXn+gKrALzCW
         5y8A==
X-Gm-Message-State: ACrzQf1m3MUZ4Ukur7BbIsryIe9qN65t7iyID7764Z3I2irl9x2f5aXU
        0Kh1M8V1NeTGI2EA+N7H1aR0OU/4W3VQXYrdWE4=
X-Google-Smtp-Source: AMsMyM6oTserZCSUFYyfuBgccLh2Gw/HZPJXcfzUrw/gXloHQlyD1RF/O1o3fo5G1nwSPVRLGSXuxLlK8NSFySnFR48=
X-Received: by 2002:a05:6870:c0d5:b0:136:375f:3131 with SMTP id
 e21-20020a056870c0d500b00136375f3131mr7739727oad.75.1665420235114; Mon, 10
 Oct 2022 09:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220617110130.2300438-1-dsankouski@gmail.com> <9bf584a1-bab9-33f3-02b6-6b10a7cfb043@linaro.org>
In-Reply-To: <9bf584a1-bab9-33f3-02b6-6b10a7cfb043@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Mon, 10 Oct 2022 19:43:44 +0300
Message-ID: <CABTCjFBneTPT=PoCh=c8hyxfgvCr=14pJYA+11sQ0ooyf6Ri1g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: starqltechn: add initial device tree
 for starqltechn
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
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

(...)
>
> Why do you have DTSI for one DTS?
Samsung has several devices on sdm845 SoC (at least 3 phones:
starqltechn, starq2ltechn, crownltechn). I don't have plans to
introduce support for any new Samsung sdm845 device except
starqltechn, but I guess we should extract common dtsi now to make
future contributions easier. I think I should rename common dtsi file
to '$soc-$vendor-common.dtsi', like others device trees doing now
>
(...)

-- 

Best regards,
Dzmitry
