Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0980E73AF29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFWDtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWDtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:49:17 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162181BFA;
        Thu, 22 Jun 2023 20:49:16 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5607cdb0959so124536eaf.2;
        Thu, 22 Jun 2023 20:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687492155; x=1690084155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK2w5YLLWQfyLk99c4dGrp7Ry7D+7sXRqTp8uyJMcJM=;
        b=T3YaPZi6VVQUWV3/gIIm0WyKD92ym3iOMxnT/zcEdfrtJaBPbHlnXFbfSzRUbFOyg3
         h/z/vZZ43apQzumWua4w8F5B67B+o/YVs47BlCqE3uOMgSEfBE98bJts1Akjfp1RsORO
         OzYm+U9t7tA510ujkWATyROhvwK7/ponSa7GA8a8VXTmXyfMaiOgObOwEo8dF0D/RuT4
         +duLqRoW7EQ9fcAHSeVcocQcLP+aadt8Psy3WhIATrbIouqnWzFY6egSnWpaU/iAhRAZ
         aLWduzseYl7vIcmqRyLzMsv3GSJ7bCKpGPeftTPeRbYga1f5VmBW/yjX8OLtBqmC43nH
         a6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687492155; x=1690084155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK2w5YLLWQfyLk99c4dGrp7Ry7D+7sXRqTp8uyJMcJM=;
        b=CU+3Dt2joQt7GM/Ai5B1WIgd/9rApXeCfBYvfw+7XrCKjxEq7wX32HhXmKInqHNrNy
         0mWyooTJohDvHFBLAZB1+W2ldCgH8OXwnHqt3d5UhBnE+JTymFSLvUFoQ11nnQ+QLGBE
         akjUkE50F0P9YK1G/WkuRVV9iLs+x9M430aQpiFk+QoPyUJHCDWKQQCUBKH4qduZdyRr
         lHivMKTCN2cJu2UMMel+kkm+ZF2rt3tk5O9CNpzCD2VrCtlVJVOhXf2VeNnG/iNqlNcB
         yi8Qbbydn1gCdLbEd/t3hn5qmWmegwNe29zWLUNRnZf08zGXIZi7OGUpLQDX0AhaXOby
         kRiA==
X-Gm-Message-State: AC+VfDwL09LqaEcTAWdJtn4GYcbMF4xxeRbadCuzEyv1m3S5EXSom+5Z
        cY0WXhtsEu0Ycz3tmFL8ytVtt7rxBOkQk6as/yi96ilS
X-Google-Smtp-Source: ACHHUZ62yiEw9wU9b+2HtfuVVpHp1AudqNYYveH4M7OXy9pdZOfp+EDgIDLumZpFAV1g9ySL9bOTNHjv+lfU+RLEGeQ=
X-Received: by 2002:a4a:dc8f:0:b0:562:ef98:51f6 with SMTP id
 g15-20020a4adc8f000000b00562ef9851f6mr1868853oou.9.1687492155213; Thu, 22 Jun
 2023 20:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <TYAP286MB03151148AF8C054621DD55C3BC23A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB03151148AF8C054621DD55C3BC23A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 23 Jun 2023 05:49:04 +0200
Message-ID: <CAMhs-H_4Q2uqizru+ePKbHsdaZ2qT50yzhVh2DqaV51414yzFQ@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: match all supported system controller
 compatible strings
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 23, 2023 at 2:18=E2=80=AFAM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> Recently, A new clock and reset controller driver has been introduced to
> the ralink mips target[1]. It provides proper system control and adds mor=
e
> SoC specific compatible strings. In order to better initialize CPUs, this
> patch removes the outdated "ralink,mt7620a-sysc" and add all dt-binding
> documented compatible strings to the system controller match table.
>
> [1] https://lore.kernel.org/all/20230619040941.1340372-1-sergio.paracuell=
os@gmail.com/
>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/ralink/of.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
