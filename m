Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754806FD991
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjEJIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjEJIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:35:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D123C27
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:34:55 -0700 (PDT)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CDA73F17A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683707648;
        bh=LMsA6JxRTYWQXM4naAdveOz2WpVCJs1mzJM+iSTf9FA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TYoNnaq0fv8X4f6D0swEt3Aa4+rATBtdnWDQ2C/HrCRkHvJx8iwAfpiguvdj6Au9L
         +D6KXR0gLhbsFyxdp1GsFRbEUvVjqmsQLB9u1/ZNFJi/ZT/Y1ddUBZi/2ElmyRzWBI
         iyopdZHZwfWHhcqge9Klkp8zESLWsofLorhk0qBUKxH5eIIF52KlotfH8hpononLkG
         EvAQgGDAR7vxrcR5eshla1HsfrwMreKJjmUFfo7ikqvL2rhy4HnrBlPUysBUAN4QXV
         BAvMR8z+++sPg9x7jUZgJkdG7tDJhL1NlG98F59hULMe0cjKEAmFHYEziGCWRHGiFx
         ReafP8PAgO11Q==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7577317870aso251740585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707647; x=1686299647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMsA6JxRTYWQXM4naAdveOz2WpVCJs1mzJM+iSTf9FA=;
        b=Zyr85cyoJPkQm2wH3QqGTwUELZ2CrwGPgLjsOz/VDcJs4E9ZDf6krKYNchBgdyU6sv
         KPXKINf1WaSd+8PI9j5FsINeQRWLGagAI8DbbZHrg8E4mLM7QwW8jiJs6Ek3PJNMHIsE
         LIVM9+Ds1jmUDsmUAJcW8IC40yVF4oardTLJr2beoSqQh9WDSyiUjDeHwUWsVIxi5vDR
         hOP4opHs7uAYvd8Q2mkhcFgQRkycg+0mbrVPphD5G0NG2oYAeDB4opm6QbKt77dF11u6
         3T4NZ/uKfyPXb2QCEYH2WSrVyJNpGeIaTsAsEI8OVLoI3hbsWLA8eVsSaxRl/Wc7FdIi
         spjA==
X-Gm-Message-State: AC+VfDxSqNEz9eUWK2kfZEuPddFFBZuwDNmDMtieBO9UXJeI2Y7WHVlC
        /qoJiUcgUSep+MUh8hEcBfG9sk8z+gMwO37iBoz95/FAelQP0valnll/WL1flxeNO2s28XJnKby
        244GPK0eCV8+cFmdpQcXFqQILhguz72qmuUXK2UMuf27mYlj3HMK9Nn9kGg==
X-Received: by 2002:ac8:598f:0:b0:3ef:31c4:c8da with SMTP id e15-20020ac8598f000000b003ef31c4c8damr26087988qte.50.1683707647634;
        Wed, 10 May 2023 01:34:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DZCX5r73TwM0f7t4oRTD7Y8E8pM8uSWayhN2OzbxOG+SFBnhHTqvrbsOT/q3EKUIZc2ylBzrCQUO23z5q8NA=
X-Received: by 2002:ac8:598f:0:b0:3ef:31c4:c8da with SMTP id
 e15-20020ac8598f000000b003ef31c4c8damr26087975qte.50.1683707647399; Wed, 10
 May 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-4-walker.chen@starfivetech.com> <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com>
 <20230509-overheat-pliable-00d60523637e@spud>
In-Reply-To: <20230509-overheat-pliable-00d60523637e@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 10 May 2023 10:33:51 +0200
Message-ID: <CAJM55Z9AxMVw=ymfFBb=45nODq89O8dMebzRgo-XD0GKduDBYg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
To:     Conor Dooley <conor@kernel.org>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 20:05, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, May 09, 2023 at 08:52:48PM +0800, Walker Chen wrote:
> > Hi Conor/Emil,
> >
> > DT overlay is used to describe combinations of VF2 and hat.
> > Do you have any comments on this patch ?
>
> Up to Emil :)
>
> I seem to recall that he said at the linux-riscv sync-up call that we
> have* that he was not in favour of overlays for hats like this.
> I'll let him confirm that though, I might very well be misinterpreting or
> misremembering what he said.

What probably meant was that I didn't want a bunch of different device
trees for each combination board * hat. An overlay makes a lot more
sense. However, looking through the kernel tree there is a surprising
lack of overlays for hats committed already, so I suspect there is
some sort of policy around overlays already in place.

> Cheers,
> Conor.
>
> * https://lore.kernel.org/linux-riscv/mhng-775d4068-6c1e-48a4-a1dc-b4a76ff26bb3@palmer-ri-x1c9a/
