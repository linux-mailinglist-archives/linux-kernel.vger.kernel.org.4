Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC84736FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjFTPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjFTPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:09:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24913C4;
        Tue, 20 Jun 2023 08:09:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9891c73e0fbso191220466b.1;
        Tue, 20 Jun 2023 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687273738; x=1689865738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2mLdzSLUl8y6c/t/8Wm4qNEyDP3SjWzGKpRm4knn7Q=;
        b=IX0HiChvPjI8bEqQMIhzI+Swh+a/JCB+Kk6jJ/fI+RKC8gZE93B0UoPvRCgCveX4qR
         I3kkTKCyC4Nuajdpr3OisySx0tiSNtyHE3QGNciu5+In3K8X5BmiuVgHQlUiYAXrldSD
         jDTeKx2zQosaggmrYZvacqtBG4o23Rei4NJjgfIlAdYJQMtWNdKE8LE672eS/a4CA/y/
         qHUNPNfy2TtLjq+kB4/FuB+b1cEQIQsK98lHZEzc2jM8upsvXaM92BnUSNUeY1dCtr2q
         vadQF8Fgov1L3tn4y7H2E/PredyZTOD5iaFRapkJGTgtBr2nyVp1RsUY/yan1wgV8Nyx
         03lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273738; x=1689865738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2mLdzSLUl8y6c/t/8Wm4qNEyDP3SjWzGKpRm4knn7Q=;
        b=XOwISIppRFBP8chlhUkKCVJp5f7gR2bXxnO7N84kmA1eOWjgJLjSff7a7vsTA4oAv+
         fqVwPvz9B5i+YV3a0k1hwYVZaMgUM+juG25k8zgjvKkmlitcLO1VyH+YNp4SCI9hqRAQ
         NeSfjmd+rmSzR3GbrNxJPmwjgOJ1mQ7MC/M8w4VHPCkZl1sTjhymnUKeWCGrCdvdv42I
         qAZtrh2bbpwNw6uX37kR5SqCqXMR4mVhQ/B5mLmpDURwCXyutCC3Mwr3mMx9N10au7hg
         NoYkT8JEf+H8xcjvE5VtUHRj82pRs3jnqqGHJ2GiUrDENVc/8pm2LtiIwDr/DX9dNyN7
         5n8w==
X-Gm-Message-State: AC+VfDwoo8szWxzC1qS1Rl7Cnbg6IPcT97XqXHQN6tFADJTDAII9C2ND
        OCmFAyqRjOmq76UZCDJsjysV5/uzv1aM1cyiN9E=
X-Google-Smtp-Source: ACHHUZ4WfZf/+NzTZw5JsLgwRkQivFZU6Qd1oDUTqhJVAtr38466A+7jtd1uSJR3BL725fR1OiY4L1eMR6S5Dx7/tA0=
X-Received: by 2002:a17:907:6da2:b0:973:7096:60c2 with SMTP id
 sb34-20020a1709076da200b00973709660c2mr16212051ejc.20.1687273738404; Tue, 20
 Jun 2023 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
 <20230529135044.2746339-3-pdeschrijver@nvidia.com> <ZJGlz7AoaZ6YB095@44189d9-lcedt>
In-Reply-To: <ZJGlz7AoaZ6YB095@44189d9-lcedt>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 20 Jun 2023 10:08:47 -0500
Message-ID: <CABb+yY0nTx8SQs1==rD3hdBJAvLjHW1R3_Yw40f4-oLNweXw4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] mailbox: tegra: add support for Tegra264
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     stefank@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
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

On Tue, Jun 20, 2023 at 8:12=E2=80=AFAM Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
>
> Ping! Jassi, any objections?
>
None. It will be picked before I send the pull request.

cheers.
