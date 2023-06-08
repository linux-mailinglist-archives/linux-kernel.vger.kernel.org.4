Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B97281C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjFHNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjFHNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:50:11 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F61FD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:50:05 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565bdae581eso5371827b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686232205; x=1688824205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8QpnJSVLjkLfqhjKetMXB1z/ynBlgTXzzXr8NIKQBg=;
        b=eoeJediBHOzQ4sCzvkREN7NkrM+aOyYC9wrM0BBnD9QxoBLoy5vPtbG+E2gPKOhIwu
         EyNOe2N8inNUgS6tjtZnWsksbeCvcU8AoFBZ6DobK57j0QMubICD10enZz9lOfMoiZto
         dnEvHA8rWj9ZLoqv3YvVr4raYrYLM79xqk8YTt2cbBiEZAPfbmHKLO3XZuEbr0szb/95
         SsCYDLUHDN/89usT82gCPbSachy3FrjGTVQM2qjW2EJ9uSXC3cX2taX/RguroKB4gpOF
         aOvxH6ic6qAbhoKc4/toPBBjaozoEySEUg2T2tBycGzEMbSPSZvDTUa9JAlMnTpiNlUU
         uJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232205; x=1688824205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8QpnJSVLjkLfqhjKetMXB1z/ynBlgTXzzXr8NIKQBg=;
        b=SBe3I0XX7fmAuo/yrK5yWmhA3czwnEwDVWBXAyk+WOTEEU55r5CLDKm0Whu5ES4qHV
         AoLqAgc1KmK/D80D+XOyj3oT992EyAlNmdzMj4OEcXO13l4zghLO5G8bPf3wkh6vtoBT
         3RxCe8EYq+seRcSvU3nTsrrTfKJR/y2Z+yRti0Tdk7HRBo0q0AzcR01UZCfO8sv5vtLt
         YJ0ZauAqC6iTHducMOk5DXKx/VMZwPx5mPtjm2dH3LAJERKqQDtmzaol2vkPI9rDiYlq
         0oL26PD1nnJ2KcQnEgqefsaz5HiGvKi+pJ/Y3cceSrcFGJQNPb+tuzIDKwBXIGi8vcSE
         Mk6Q==
X-Gm-Message-State: AC+VfDzMEY+8KMpLE+1S6lfzPQE186CsklnSYfZ+qt63vuUYgDFHPLBP
        DN90qVb4thMB+0WoUljDEH/WFfSr4Lr7fDdEzLl4tQ==
X-Google-Smtp-Source: ACHHUZ7B7bXPRaT8K13It0iwZz1KqJEF7lXGqjS4rO8Dx3uKOw8HQryytQq7nhVtQCV6nX83IX6Uwme+LOGCLFP0Fx4=
X-Received: by 2002:a81:6a87:0:b0:568:fe3a:46b3 with SMTP id
 f129-20020a816a87000000b00568fe3a46b3mr10251209ywc.28.1686232205112; Thu, 08
 Jun 2023 06:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com> <20230602132859.16442-3-alexandre.torgue@foss.st.com>
In-Reply-To: <20230602132859.16442-3-alexandre.torgue@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Jun 2023 15:49:54 +0200
Message-ID: <CACRpkdahyWFFscLYTDBGGSp-67_+4Qj1dsDif-jDFWoEK0mXzw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] pinctrl: stm32: add stm32mp257 pinctrl support
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:29=E2=80=AFPM Alexandre Torgue
<alexandre.torgue@foss.st.com> wrote:

> Add stm32mp257 pinctrl support.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge the whole series through ARM SoC with my ACK.

Yours,
Linus Walleij
