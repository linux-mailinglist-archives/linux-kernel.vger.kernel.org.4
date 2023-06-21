Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161B73918F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFUVc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFUVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:32:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C519E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:32:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bff89873d34so896588276.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383144; x=1689975144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pU1mAMfIYrrV/zE8Re8kOdWl7lW0D3T201ge+UaFck=;
        b=Ik11VblBlSOMYQQNi+QzzjQS/OQZ1aRSLSvA4m1sj3DFlGMS0yTLkhu1iuz8OIl+AM
         JMDceKxLl+nR5gFkoONVzmgYKWMUD9pkbiiU7K6rdUoMOun812SPDUn3KGGSno6CTVXq
         ga4SqOTXVE5SbGDULGvH92xzn4fKzs7Ls5qEVZVQVCMO8eWnpd3Rr5/IPb0nNPU4TRRG
         bHvSgv3F7fKiuUyt5f4yoEpwlb4js6nkFkJDZc9KYFvPG+zkDDSZrzXLdFP62z77vkBz
         mVzntB0W4hgjW2oPkYZcxQv2KZdAYeKQ/4V2nzAMxP9iIu2FDGnALVT/kPOYhsrNCnWy
         7LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383144; x=1689975144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pU1mAMfIYrrV/zE8Re8kOdWl7lW0D3T201ge+UaFck=;
        b=AuQiyR0qe0KuX16NK8u8+dAdU0u+iPzHSrPYFv/ToydQ4HAmCLZk9trBJ8nUE8QBLP
         eQdKa0UoQj2Jca0LXfisd2oRYiQV847q8X71zl4NMSLSJN/C31mAWNgbvA3jR2X5FcVs
         hfJeQphLVflHzfv9rKm4awScgprUkZnM/krRhSeOQRZSe4BXItmhgOk5Xe67fTn2ugDW
         HWGJUy/Ik70SPb/lf6qlYHiAlghsYGDOoZ8iAjPRaUR2GJGSPsvEmqgSjuG/Zlx0Umce
         P5sJsGR/LInvWi7cBsYQYryaK/4tY4a6PCvw3Ua+C/bVIJO/eRGbp8UVoTEjN1tGOfia
         eG8g==
X-Gm-Message-State: AC+VfDz7fXz87EZ5/x+Cf0t2+BWb6NPqDDN2ns5rkKMFTmfVSO4NvVdh
        wzy3x2Ih1kv+sssI4c7YrWf1rXjZVlgv2uV1TL31qQ==
X-Google-Smtp-Source: ACHHUZ6G/0prVJxe9tzmmIsm6hY7wbKnUzbja9dYcN3jPGmB15a3wAU5ScWlFR8rpPu3DCRpMq8aYCYow+SD2sKDn3k=
X-Received: by 2002:a25:2102:0:b0:bc8:914b:c83a with SMTP id
 h2-20020a252102000000b00bc8914bc83amr9233735ybh.22.1687383144183; Wed, 21 Jun
 2023 14:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-3-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-3-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:32:13 +0200
Message-ID: <CACRpkdbYzXcw6dbt2YpkOOuYiEqGgOM_+K0t+HmwPtHzowOhZA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: dsa: vsc73xx: Add dsa tagging based on 8021q
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch is simple implementation of 8021q tagging in vsc73xx driver.
> At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> family doesn't provide any tag support for external ethernet ports.
>
> The only way is vlan-based tagging. It require constant hardware vlan
> filtering. VSC73XX family support provider bridging but QinQ only without
> fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
>
> In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> frames.
>
> Tag driver introduce most simple funcionality required for proper taging
> support.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

From my point of view it is the best we can do.
Admittedly I do not understand the implications of using the 802.1
tagging for this, so I leave that to the experts to review.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
