Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47736626C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiKLXBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:01:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBADE89;
        Sat, 12 Nov 2022 15:01:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 21so12363976edv.3;
        Sat, 12 Nov 2022 15:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTbt0a2xJBfSnRn2u4bWAXagh9TkCUBqkSMMFYc2JtM=;
        b=p5AEsQfdKfMpFJhMp9ygeLOWB2CLmtACLTJbqsdS/KD2gw5yBHqFWqaaf549kFa0Pb
         1yM3htcAbsJiemoZpQns8tVXsEOQpyKdAUwCkLSR7idEkuPl7UwELwzkGCZUdGR9N1o9
         01sQworEj8hnwCMC/ZzL2jlrTTO0kFSj0on36SrA6s4QOilgG+Kd9Wu6IYKWYmpK5i18
         NHi40mjySwSbA4qxiAhPRXePvbOGSd3fIrWKHPdGkKemcXoMcsey+1ZQpOE97OQAfywr
         eGyPk5lN+ru6a9a4Lihsmpn7AS/qozFUWiTduCvbQCxMXQBEEZW43xGJv3KZqD3Jpf0S
         35hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTbt0a2xJBfSnRn2u4bWAXagh9TkCUBqkSMMFYc2JtM=;
        b=EVF9kstRp2FtkEyZG3+PryW4t1mJgJemzNNpDKrjoR2976tqfECrD214R0utPm3X/6
         Pjpguobi2341MKvFvBggnTAD6Vk+BmkqbmWgUeLXGGVJkR9enn1iBJEovDs/XowBOtvj
         pRAqFvW1KAiP9hriL4pIm8t3RXEkTmTut16+kwkaHY2Ufn8MaGQLuHgfnco8PNDx6Byl
         uEHC1UkPa3vlrxygGUPSFEXyHIAgUruoRjnCIMiQIVMTbWXo6xEPXukAdWNf6KxTF4ZM
         5yOCwf/F2hqQxFg57HHgglI+4uFKvKWlra2UlVwDnJ1Fha9/cfJBeBHCHJ2CbIMbYCgc
         cfwg==
X-Gm-Message-State: ANoB5pkzhEvMHFtau2DHW8v3QfBh/xdFO6oASplItSrJ6iz9O1gF5/yt
        jddQGsqtp6l8KezeovlwdOhGNJ0QxOMizrjorgUsn+K8yew=
X-Google-Smtp-Source: AA0mqf4emPWDsB0Q2Akmslx3fIfr+lkWa5caJWrUvj1LbBOb6Um4B99gTwlj5Q0yAIbFuMDaXuSEUBuyWRxPJOGvoB8=
X-Received: by 2002:a05:6402:715:b0:461:9fe:6d8a with SMTP id
 w21-20020a056402071500b0046109fe6d8amr6453263edx.4.1668294104583; Sat, 12 Nov
 2022 15:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20221110150035.2824580-1-adeep@lexina.in> <20221110150035.2824580-5-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-5-adeep@lexina.in>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 13 Nov 2022 00:01:33 +0100
Message-ID: <CAFBinCCch3RsJbnA602tH924umRVdbgr-20g2F3mYLWCDrkg4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: docs: Update mmc meson-gx documentation
 for new config option amlogic,mmc-phase
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Vyacheslav,

On Thu, Nov 10, 2022 at 4:01 PM Vyacheslav Bocharov <adeep@lexina.in> wrote:
[...]
> +- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx clock with values:
> +       0: CLK_PHASE_0 - 0 phase
> +       1: CLK_PHASE_90 - 90 phase
> +       2: CLK_PHASE_180 - 180 phase
> +       3: CLK_PHASE_270 - 270 phase
As mentioned in another patch: I'd go with the human readable values
(0, 90, 180, 270) instead of the register bits.

[...]
> +               amlogic,mmc-phases = <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0>;
Also I *think* the format here is not correct, for an array of three
u32 values this should be:
  amlogic,mmc-phases = <CLK_PHASE_180>, <CLK_PHASE_0>, <CLK_PHASE_0>;


Best regards,
Martin
