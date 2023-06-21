Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B3738D46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFURiS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFURiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:38:16 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC2F1;
        Wed, 21 Jun 2023 10:38:15 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-94ea38c90ccso180573366b.1;
        Wed, 21 Jun 2023 10:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369094; x=1689961094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17zx2MlePPMg0vLEZ3N7mfSj+vherVFzEhZFZJa0v8I=;
        b=TOyaRRYjE1A37slgt+fSZ39QAttnMka4QXqxi3ZMNwE7gKHqMky592GHGwqshN2jC/
         GhpOQ2L/nCPbrvl8rgZrpTxqzLd7NaO34EHpYPDcgcLi3E91bN/Ihb3Md8yLIVZklG7L
         AdhVeCE1xqHc8rHMvyvsLrJTW+9k3Q+RsL8MMFxzRCMXrHd9hr+fC6hITaNyNxDLKgpQ
         xV4sW2Rkz5uZPUZNlQu1XscdIOf6WHHdPM6ykwcSjtwKWK4H7SlNYFqR1jSq+s8f1xdf
         yWXW4s6FMfK1r/QVlRrqo7iRSekwZ4OPj2geJF6UKnMR0uf8g/B7TlQS2YTmDRbZMOqn
         YCTA==
X-Gm-Message-State: AC+VfDwdt+LEPnrkm40/FUpCaOGsvQgy2tWzZglk721Y3OO8Y8c1DwS5
        pQ+kEZ5MACA0Pk6PQ+9Zt2MZ7vluRpSMdtBZpEqQchqJ
X-Google-Smtp-Source: ACHHUZ6Bm6hG15S7LTyOeV56HCdJoMkz9bMDRv5pgE+Nr4oKuN9NHhATCUA2In3XJopHhRtwt6YTahQA689kMhA+jU0=
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba06 with SMTP id
 p12-20020a17090664cc00b00987115dba06mr11378234ejn.4.1687369093768; Wed, 21
 Jun 2023 10:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230620172433.21325-1-mario.limonciello@amd.com>
In-Reply-To: <20230620172433.21325-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 19:38:02 +0200
Message-ID: <CAJZ5v0hjrKS7Cb+wJu9cP8VV9DggUR+2iZ4DheFOSd0bRx-=jw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Enable amd-pstate active mode by default
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        Wyes Karny <Wyes.Karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 7:27 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Active mode for amd-pstate has shown enough success now that it makes sense
> to enable it by default on client systems.
>
> This series introduces a new kernel configuration option to set the default
> policy for amd-pstate modes for a kernel.
>
> Server systems will by identified by the PM preferred profile and still be
> set as disabled by default for now.
>
> v2->v3:
>  * Drop patch 4; Intel intentionally doesn't want intel-pstate on SOHO
>    server
>  * Move symbols from patch 1 into patch 2
>  * Add tags
> Mario Limonciello (3):
>   ACPI: CPPC: Add definition for undefined FADT preferred PM profile
>     value
>   cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
>   cpufreq: amd-pstate: Add a kernel config option to set default mode
>
>  drivers/cpufreq/Kconfig.x86  |  17 ++++++
>  drivers/cpufreq/amd-pstate.c | 101 +++++++++++++++++++++++++----------
>  include/acpi/actbl.h         |   3 +-
>  include/linux/amd-pstate.h   |   4 +-
>  4 files changed, 96 insertions(+), 29 deletions(-)
>
> --

All applied as 6.5 material, thanks!
