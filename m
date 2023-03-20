Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B226C2097
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCTS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCTS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:57:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E3113C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:50:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z19so3123209plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679338201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb5WAjnV64TvIqVog+ALrYqWwxpAYRDfoRexx0FHgtM=;
        b=P26WYm2NWf0WPj3f9FGlGwX0m8mwWNzYTAfzTeuhYb2tHlkAFxn2mVMAH473OO3ANT
         7vKoG8MyNXfWNVhiQcNRGKGUbpU79vDYKbw1Kr0WFv8g0GExqpaTgVKzKjeB1kUHS6o9
         QUPc+PnnpMvxu6on2j6T9QepUT6VNdKWeKucaXr1lpLbjvK1Duf5RBmV4yxqgNpaKw2c
         hJx4kk4VfJ2/mIVuiNi3Lf+I7SRTppK1q66hVY57y9kvE65FyRgSKOUN+gIE+DELu1f1
         /vc16H7piCvg04UVFaBHWjP6JfWqS22tgv6O8EeYrwq/tjhiEvR8aCyAhwqTa1rH0Nx+
         TO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb5WAjnV64TvIqVog+ALrYqWwxpAYRDfoRexx0FHgtM=;
        b=oK4ekoov5hyLKUfoGcliWCSSDG15w3Nm3qGZHCFa1Iscu8COln9l/dq/mO9GhzZLX4
         4tsyUc+LTasbj6Zh3j3hLFuIEc2LhFCI3BrnWg78UTfQu3FXUjj8Q2e1/NKF+RyXldAE
         436XFdEbSVHNbmto+8Hbm+Dkj6eIt6cC/4kjwevc34MWMUQogeHSDjIPtpj851eRe9T+
         0Rl6DJtXSYa4YTczmnUSzcXhV0jaf4U2SdAYFQwePgealHq+K+gyie73nFM/gDSrnrPC
         sv51HYoa047O3MZkmXOzSDKrkdaDD9JGGnbNOMzxKwKj5nGVk942fjQtlIeNZx99MjR8
         xxYA==
X-Gm-Message-State: AO0yUKUTUjnTjqX333UBmYetJYpf45WHEqRD4Ow1h+vg5uY3r2BX79Gv
        /XShPVflJStzCAWcQPqJSj8sJTJU5HQxC0OvqcT71w==
X-Google-Smtp-Source: AK7set9eH0azJC4yqfUlAGq8InyKfmgAzfIqpPamku/x55+E9k/WBoIumDFLsuBW5qWPFIbB3U0nG1RRD8hPh+MZTlk=
X-Received: by 2002:a17:903:452:b0:19e:f660:81ee with SMTP id
 iw18-20020a170903045200b0019ef66081eemr7432644plb.2.1679338200618; Mon, 20
 Mar 2023 11:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230320145513.305686421@linuxfoundation.org> <CA+G9fYvNEThYX-c204_knup5G_1vA27j+HouS-n=HMUsdJpC_g@mail.gmail.com>
In-Reply-To: <CA+G9fYvNEThYX-c204_knup5G_1vA27j+HouS-n=HMUsdJpC_g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Mar 2023 11:49:49 -0700
Message-ID: <CAKwvOdnmwkoeToovShcmfpSAmBmKDTzZNv4R2jFA37hi=+ynaQ@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/211] 6.2.8-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:40=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:

Thanks for the report!

> The bisection pointed to this commit,
>   45f7091aac35 ("powerpc/64: Set default CPU in Kconfig")
>
>
> Follow up fix patch is here as per Christophe Leroy comments,
>  powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG

Greg, Sasha,
Can you please also pick up
commit 4b10306e9845 ("powerpc: Disable CPU unknown by CLANG when CC_IS_CLAN=
G")

4b10306e9845 is missing a fixes tag.  I've filed
https://github.com/ClangBuiltLinux/linux/issues/1820 to track getting
these -mcpu=3D values for ppc added to clang.
--=20
Thanks,
~Nick Desaulniers
