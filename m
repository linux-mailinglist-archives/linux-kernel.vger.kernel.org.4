Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B8748853
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGEPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjGEPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:48:58 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F921730;
        Wed,  5 Jul 2023 08:48:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c2743325e2dso1293987276.1;
        Wed, 05 Jul 2023 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688572137; x=1691164137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rADWg9u/1BJDYIt3vLRjrV0s75Gr6YuZE8thJU8q/rI=;
        b=VU68UufOWgKJSjdhtCDRT9FixyTZ/q2/t2AjAxdb4F2M3BlToo54fs1FEA0XP6kRql
         W5h3m/VZtGm790+6AOkFaIhAzmI9P4o0N+GgSJeK1t8yoqoXaoe1CHrlk0UybtpT4gNA
         EDZX0DbhVcnJOpYLbBRQl8jgYd4Lz4Ux/2a+eJgGHCDEBtpUMyRfy3J+/5bYgUvoBodt
         VrLsArNFscIKLEbOPBaW9Nzv8cEaT1Xs4eZzPOjYeld6gKoT5gS6wU0Z7A4IUJQQFBoU
         EvCvAdYlHAO1zihB6YyEbGv3TcoGg/PuONPvNfLljmkjHVO5Hrww0l+mxOHrkOQMP6c2
         BxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572137; x=1691164137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rADWg9u/1BJDYIt3vLRjrV0s75Gr6YuZE8thJU8q/rI=;
        b=PTq243Yg6wCN3/EE2k0WqWvrzcNZwiqf7bT6w++l2duObLAW5CsbMYNLSuMlYkoj9P
         idaGsU3xiRPZsdmmT+GyrSCFzWlOhtKOxTdwcczpS3JC7rmdlc8R2evsuK7R10hP8zVj
         Vh0kQf1rJ0qIPLLz5EusM+lJja3dycyZPR1UyULChSD7byp/HSKW6eUlq+OzrqhTHvsU
         WOMbwdKozFCD0IknynIihKh4NJnOCwyHsmeGrBVNjrkbe45OmRcpeYtNJjhHo1CoDihd
         y8ECOOpvKGmrxpiXGioaZI0GWDorNc9+dXEtqo8n40btX5BMm6DPAX1gNiiwkWh88xOi
         BjOg==
X-Gm-Message-State: ABy/qLZ9DQ/Vei71T68Wk/KAOOfH4S0MTxz9Jd3jZ2vXA17sdrkKdIaC
        n4GqR+6EBqZMwRyyzuVsjH/D50wQMndUU+aAfr+j3uEObj2a2aJG
X-Google-Smtp-Source: APBJJlHPCTYg9Bs30dB81jOMQaHgFQ11PYgkS06RIQYtcad/nb1fw3CXz1aH2kMto4mPbGAQOrv6zcc83hJYsI1n7vM=
X-Received: by 2002:a25:9f8e:0:b0:c3d:eff4:1c39 with SMTP id
 u14-20020a259f8e000000b00c3deff41c39mr1717279ybq.12.1688572136950; Wed, 05
 Jul 2023 08:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230704163848.169853-2-davidwronek@gmail.com>
 <20230704163848.169853-3-davidwronek@gmail.com> <a0bd842d-b6d0-e126-7b05-e488357330ab@linaro.org>
In-Reply-To: <a0bd842d-b6d0-e126-7b05-e488357330ab@linaro.org>
From:   David Wronek <davidwronek@gmail.com>
Date:   Wed, 5 Jul 2023 17:48:46 +0200
Message-ID: <CAEoe_eWHbnE2EeWerkZAmGznagCoxB7kXsqtbTUxjtzgdmMRtQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, map220v <map220v300@gmail.com>,
        Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 11:46=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2023 18:31, David Wronek wrote:
> > From: map220v <map220v300@gmail.com>
> >
> > Add the SoC ID for Qualcomm SM7125.
> >
> > Signed-off-by: map220v <map220v300@gmail.com>
>
> We accept known identities, but this looks like a nickname/pseudonym.
> Are you sure you got such SoB from map220v?
>
> None of the commits here:
> https://github.com/map220v/sm7125-mainline/commits/a72q-6.0
> have signed-off-by. Did you add it by yourself?
>
> Best regards,
> Krzysztof
>
(Please ignore my E-Mail from before, I forgot to click "reply all")

I have asked map220v for permission to add their Signed-off-by to the commi=
ts
and this is the one they gave me. Is the nickname a problem?

Sincerely,
David
