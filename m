Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920C69048E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBIKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:23:57 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63008193D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:23:56 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id l201so771094ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESBIV/kNJUNeYCMfLMjpk+d6xlstSirIwM474nZZD/0=;
        b=VvSf7nsrTc1HWEqNg6MATvElyfdndYn0+jgpiSPmGNALuJ2YaX+mF3GB/ewxj4du63
         QYjMg9xZjfdGGfYXEJauxvtHUoY+ohbFXPT1kDLMUdtQRav/86bqucl9bKzjAsldzBnq
         EGumfKi+HVT8/8afw7Nz5WoNOA2vMT6V3YZ1kdLl2KbuI5hVDl6mJ24nMh8RHAckeE2N
         HdLAL1lFLsG7Bju0uufjPwWNpOlz5vUVcdnOOV3mt+imkZMufdKt8VYuQz2jqLvGUPfG
         d4/uChKWIB9oWeOxwMJE2OmYkV1FwuSWdWPXCME8aFd0foD/hv00k824AFxOWTu3l5QJ
         gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESBIV/kNJUNeYCMfLMjpk+d6xlstSirIwM474nZZD/0=;
        b=YklWSTw3586gVjlJpubGv3gM/yLOd//ebNv3cTE9VmSujGiyx1P6cP2k78kxgDBqpK
         Spy7/JRCN+liN4RKGzfTXZQS/w+hqJYG18+We1zTQWqKG4kklBWl17CKHOaR/++rVKoc
         F9FVWl8Z/wSmnki42LEdcx/lQ5fedwKB52P1HMSXl/UXvS+LXbQZBGJqP6undZgF34lQ
         dpbGHP8H/neKiKuCDxKxHevAeB1Qw0IponWcbrFkP8C64P4LQFJ6OjQIvsz1SUPDKsW5
         x2t5uG8FnuRtz6Fk9/GfqsQsKlJQV+sIv1Ef5DXAl2myy7ZCFzSPDTUyCBfE6I9rD2Kh
         /JnQ==
X-Gm-Message-State: AO0yUKVE9130w1GFLzWI0nHQ7FLBURTgGDNUuksZVG0LLiB9TOgJQOzt
        XsdlBjWftMvbFPuvCQY2L4dW3OyVMFnDqrPNpnaRqHwZwdhlUM0I
X-Google-Smtp-Source: AK7set+C4DcjTmcYWBgoWWJilkxDTiApY+tMJci86TbkIHE286R71lPvBSO/vStE0DPkyAJ6+h7YG1xPTY8D86Vb1XQ=
X-Received: by 2002:a25:5d02:0:b0:889:f225:d942 with SMTP id
 r2-20020a255d02000000b00889f225d942mr30014ybb.518.1675938235680; Thu, 09 Feb
 2023 02:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127192139.299228-1-brgl@bgdev.pl> <167591660368.1230100.1469946170144348483.b4-ty@kernel.org>
In-Reply-To: <167591660368.1230100.1469946170144348483.b4-ty@kernel.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 9 Feb 2023 11:23:44 +0100
Message-ID: <CACMJSet=0TW2u5PNPZFmb3WNrjCxRDaozkS9KLaEcEwPp6zHeQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 05:21, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Fri, 27 Jan 2023 20:21:39 +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a compatible for the sa8775p platform's Secure Channel Manager
> > firmware interface.
> >
> >
>
> Applied, thanks!
>
> [1/1] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
>       commit: 27d71e8063d99b4429832bc52de171ace6b1e562
>
> Best regards,
> --
> Bjorn Andersson <andersson@kernel.org>

Bjorn,

FYI I resent this patch as part of an integration series later[1] as
per Krzysztof's suggestion. Could you pick the entire thing up too?

Thanks!
Bart

[1] https://lore.kernel.org/linux-arm-msm/20230201152038.203387-1-brgl@bgdev.pl/
