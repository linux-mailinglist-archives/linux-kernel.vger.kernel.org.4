Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8544600A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJQJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJQJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:14:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B504D141
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:13:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d26so23395252ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qUk1uQhdbMxD0/T/au1bW4ciWhKciAmc4+RpG6d2heA=;
        b=vfbDFYPQeOsjqvmBqlSXKZrnbw9dcBRMtC/z267YLsxGP7mXixqCCr+FChTkCxH2+o
         q3AHwbpjoL8JJpkxbEv/rgopQpF5cvOOK1ZCvu72+2HzXSIqfHPH3tJ8WEvs/yPMGRH8
         qnJbKsMekd6FtUlkPibir5Uw0cccXqTbmDC1b4ArqomJu1rL6mLzqZAksH3TUGP99UOk
         cfbj2n9R7ZH3M6ntyMZKftT9U+7tudK4NdC45uKeF2SH5eLuGtYfHk8QqcKwHw5JdHI3
         qU5QdFL6/bXHhXJ9ZKWumQrA4raDTMkyQdppjDfvAjnairo4MLHq81zqZIWlTNe39XFj
         rbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUk1uQhdbMxD0/T/au1bW4ciWhKciAmc4+RpG6d2heA=;
        b=T3HOSGXoRRqlZAHwIApQ3eTorSn6NtW/psI6o34GCPiOp4RO8WMrpE5yWXKog/6VFE
         p2D1SHmZZmlF9n2/d4B4j6jKsCQgM9INm/qIelsJJzwY5XcDef0FEMsMQchkx4hbcxGF
         JqMVsEJm5S/eq90okGcMee/bWH9HVZWQK/t+mtgoLxYuwdEgPVQaKba6tDKN/Syvvz9C
         aRzXcyEZtoZppXgmUJq+/jmk7kjRmwOlvd62Pf2Tkzr2Sdm/yWvyutT2+u+B+usrnu7E
         nxaTpcts6weYK2Zh9dtyXdQJr0GWhXwAd55jb9EZRYLhVx0T7v1S6OaQorAQCd1EgtNX
         jGfQ==
X-Gm-Message-State: ACrzQf2/FG8CEOe9gs27dFPufg1K7CYx5n9gF34ZMbM+7Zz6qUP94iwO
        RI41Tekq315ztl0179wN9XKvPnfEk9x51taHukJjEg==
X-Google-Smtp-Source: AMsMyM5IcaB+/89z7lKy2GkwDgaJrMZTmiPyWfiVGfk2VKHOuGBwhZczAZ2NNHz84JySZqBRAKhaHChWmfkTPCymXmg=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr7442664ejc.690.1665998019502; Mon, 17
 Oct 2022 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 11:13:28 +0200
Message-ID: <CACRpkdb9b6Vckv3kVRWkB9dfTWetG5u6YkxMb7Re0O+EgH5QtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] MediaTek pinctrl DT binding cleanup and MT6735
 pinctrl support
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 7, 2022 at 2:59 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> This series adds a driver for the pin controller found on the MediaTek MT6735
> and MT6735M SoCs. The two differ in the last 6 physical pins, which are used
> for MSDC2 on MT6735 but don't exist on MT6735M (since MSDC2 doesn't exist on it
> to begin with). In preparation to document DT bindings for this pin controller,
> the existing documents for MT67xx SoCs are combined into one in order to
> eliminate duplicate property definitions and standardize pin configuration node
> names. Necessary cleanup is done along the way.
>
> Changes since v2:

v3 is already looking very good!

Please fix up the remaining comments, then rebase on kernel
v6.1-rc1 and resend, I think we can get the final reviews and apply
it after that.

Yours,
Linus Walleij
