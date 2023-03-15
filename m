Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C036BACF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCOKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjCOKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:44 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46825290
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:02:56 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id g23so8820118uak.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678874576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF6LBLKlsT6uT4Hak2vOqFMzvPLvdsa/UHZ3r6EJWvE=;
        b=erG0GtDtO6s1Iq5EloXAvSzFqpHnKqnX2G6uN3ILHe6gHt9SB1qPM6sbLXkQMtwm68
         cnoMVUaWWBqvoBydH9Vl+aVXv7jPdcojydxM6qwNS/hDM64VXgKsqHKcb8DoscrN7/TP
         1eFBPnOBAMeS8YgwQMtSto5wvzY8ayk9sPQXZU7y4UIhbXAl3IpFQCX/wee5tvMNGnxp
         EHde934aJWCU8oHJfx+264PoH3RuZ4sgdoGO0dYj0un1GoA/j8KpRDFnzxTL9u/bpkc7
         rdP4uhnzAAQ614qTtovXlv05O1zbTreNwZLul/sJ0j8itRfb21kj55p2vkKKImR9bnUY
         VRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF6LBLKlsT6uT4Hak2vOqFMzvPLvdsa/UHZ3r6EJWvE=;
        b=o87ibXOltu88M0n/QTAb31hF2e+5iFATrobUUrtxnJchpNDIx8Sov/hxaybF2ijEPe
         DxD+gA+RlT2+xrC0fykIN7seQcKoJ+MqHf2Wib279E3P3KwmPutR1usOX7GWS0WwRtL1
         yF6lgg98ZV2T1s17MrFhEeA+jcKy0h6+Tz7jtQwTdA0rg94ROjivOM0ntUzaSNJ0bqb/
         fjCB//j8GAfTikni+za10H/xvNV6L4kYfEQnQoP/CmRRkNhJCNeZbFeXw3cAaHvQD7IK
         yGSzaQOrdgb7zTyZv0K7phMFWoPfORuJas6ZqzHfhCvYfD7jRi0itDS/ZHdgBOsPPlRn
         3a1g==
X-Gm-Message-State: AO0yUKWNyF7r4UyqyA8Nc5SwmFA42keQVfr604qBHGD+u6uXfcvO+VuY
        y1PrTuEyZ0cGCSBKal+SgZigYWaRJMVRFoMkyZD7Pg==
X-Google-Smtp-Source: AK7set/qkuKoVcngfib97GKcYJc9/yISAk/PKjRHQUasazdErdyzZQKMIM8sMTTNGAmM6n9NhfAB3+I5c9OL16Rbdc8=
X-Received: by 2002:a1f:7c8b:0:b0:432:5951:176a with SMTP id
 x133-20020a1f7c8b000000b004325951176amr1739375vkc.2.1678874575897; Wed, 15
 Mar 2023 03:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1677515341.git.william.gray@linaro.org> <CACRpkdbAMQ0OAMnxuyf6gMFu8qJakmT=WvRzBTXavXFmnJ9ObA@mail.gmail.com>
In-Reply-To: <CACRpkdbAMQ0OAMnxuyf6gMFu8qJakmT=WvRzBTXavXFmnJ9ObA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 11:02:45 +0100
Message-ID: <CAMRc=Mem3TsNM5coFLKAFQ74Rk4vvXLscuBhWoR-G6mLtxaSPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Migrate IDIO-16 GPIO drivers to regmap API
To:     broonie@kernel.org
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:13=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Mon, Feb 27, 2023 at 5:54 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
>
> This looks good to me.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Bartosz, of you merge this you can drop the corresponding
> patches to immutable irqchip conversion for these chips
> that I will be posting shortly (currently on the build servers).
>
> Yours,
> Linus Walleij

Mark, can you provide me with an immutable tag for the regmap tree
containing commit 1/6 from this series, please?

Bartosz
