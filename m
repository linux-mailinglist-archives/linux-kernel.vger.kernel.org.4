Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06166689C75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjBCO74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjBCO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:59:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66983C27;
        Fri,  3 Feb 2023 06:59:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6145061F45;
        Fri,  3 Feb 2023 14:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCB4C433EF;
        Fri,  3 Feb 2023 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436390;
        bh=rfmO/dREt9Imo+N73/l/mF1DQB8gO2iX+lEgI7Qhwyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZcjUmtUwOTSG4F/C0O+uQLYB4EJnN9ro8TR/5Rcm9oRaMr6wF4uiCUz/ScZEYfkJK
         JnohmNcu3PNRE5bRJv565qHzq7yof2HENanROH7aS8rnUkmpL9JxIA8oEaxrnPnFkT
         E3EFCj9JkYDA1K3zDepa5K/cNtUqlwMcVzP58ac1QmNqxEBFnyQpUM2kcc30KVPszZ
         ilpoFIbW+bAoauZodHLkjA1GR/W6nXBFG+pqNhaLvgHDAYLuSuV4UsaALtR58EAVfr
         kzsCynugKx22V6oPgopxKZG7YgVNwutxKJQB8TlFnaXZdtfhuSPqjRsouMj1uBXRE8
         1YMa0tP5Lxw0Q==
Received: by mail-vk1-f176.google.com with SMTP id b81so2697431vkf.1;
        Fri, 03 Feb 2023 06:59:50 -0800 (PST)
X-Gm-Message-State: AO0yUKWZLJuR70OU47HCGxxjT+hXQ/Visfcv7n2xrXDlYye4ZapF15XQ
        y69uO43koCR4KRiVjQqmTtk6uqW1TTMoJ7EyVA==
X-Google-Smtp-Source: AK7set//vUFGhsUQAEZraWmVzMVWQepTrIloqT6Ulj0U8pBpwsSoKl6gUK9+4JS/5knyhdY6NSM0qaPT02hxE7VwGJY=
X-Received: by 2002:ac5:cb05:0:b0:3e8:ab22:ae05 with SMTP id
 r5-20020ac5cb05000000b003e8ab22ae05mr1577053vkl.26.1675436389661; Fri, 03 Feb
 2023 06:59:49 -0800 (PST)
MIME-Version: 1.0
References: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
 <20230202235916.GA2931100-robh@kernel.org> <d2af0b0c-718a-a625-3630-05631d0e310c@quicinc.com>
In-Reply-To: <d2af0b0c-718a-a625-3630-05631d0e310c@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Feb 2023 08:59:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKV6EEpsDNdj1BTN6nODb=hsHkzsdkCzzWwnTrygn0K-A@mail.gmail.com>
Message-ID: <CAL_JsqKV6EEpsDNdj1BTN6nODb=hsHkzsdkCzzWwnTrygn0K-A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: ramoops: Add support to get the
 region dynamically
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 2:20 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 2/3/2023 5:29 AM, Rob Herring wrote:
> > On Thu, Feb 02, 2023 at 02:58:00PM +0530, Mukesh Ojha wrote:
> >> The reserved memory region for ramoops is assumed to be at a
> >> fixed and known location when read from the devicetree. This
> >> is not desirable in an environment where it is preferred the
> >> region to be dynamically allocated at runtime, as opposed to
> >> being fixed at compile time.
> >>
> >> So, update the ramoops binding by using some reserve memory
> >> property to allocate the ramoops region dynamically.
> >
> > Sorry, but I still don't think this belongs in DT as I commented on v4
> Do you mean, we should not even document this here ? or are you against
> the size property mentioned in this patch.

I don't think dynamic ramoops location should be defined in DT.

Rob
