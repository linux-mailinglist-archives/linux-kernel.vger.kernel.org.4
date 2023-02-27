Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF87B6A4BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjB0TxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjB0TxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:53:07 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30B29149;
        Mon, 27 Feb 2023 11:52:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n8so2138858qkp.5;
        Mon, 27 Feb 2023 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSsgZWyIjjhvP3sjrbbVr8r5Vs+/XtNNoaaW0/Jw94k=;
        b=Jo/gB88R3PcJRGED/liLAt1U7D7EMYrsWbKO/RBG/SEZzZ0x8Bp5CbuTMygLdl3G+n
         dVG/YQpfGxJBV3tgmSrcPIq+sWuMXE2KwZFXPdYdzo10TPBoshMftmasXgwzTpF2SZwa
         bEcq3ytV+buZkIX9IkF1HvfEhk1AVmgv1PLYo+yUKnilRZEYbyYbuIaptyVgwdHWcAlV
         agRuHl0V/K4JCQ9bpvPspfev9ma7ss0FPJ7VaK5WGO8vahGWQaN+a/1MevY7b8P+4/ZN
         Jd5pwsk/vLKQf4axcDslkqm+hKSxN5AQu5WAyN9T493Ov99czED2G6SXwFHXuCKpFAru
         4U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSsgZWyIjjhvP3sjrbbVr8r5Vs+/XtNNoaaW0/Jw94k=;
        b=A578MQQTIEm4vH1cQeukYq0+V6/auWPpsLDiD2yq2Q/+aX95wFCtmZ/Q5u+9niL3Td
         K0IcB7PVwJVS+LvZxiBGENq7gFg1QlQDh0eOgzzdfX9/wbL8eGfl7f0itLwFqShSgT7j
         bns+SynryLlDhaAis21h8eDrjdDr8J08Pu2BDqOx3nuvvxfBulTAnoTrL6VCyiWCt4Rs
         gRlo+u+zCcSnXGojRa0KCptnXvThd8hGbhIv3JcqtMzaaqZKn7TAgN5+OwlVeom4pjyL
         ziJNDcuDFBQn1FPN8ky15jdJO9m4akyL1RU5IN5urXRNRDabI5kcb0RMBBoB5Qc2BDd9
         MclA==
X-Gm-Message-State: AO0yUKU7SKBBTYdFSCZZDA4hv6+yQELc6gitsmYoUGGFHZGX7Zo6ogs/
        Jl+kBaKKCIczp/BfTdO+7+B4n5V+gK+oPm9kozc=
X-Google-Smtp-Source: AK7set9FhqzZNm4d5fnk3uPKs07IVfxLRaRdUfHyGCSsNLMR9tksR/Whi1dm5kNCEAntRNyZEB9onhn6/SayTbktlT4=
X-Received: by 2002:a37:745:0:b0:741:5749:283c with SMTP id
 66-20020a370745000000b007415749283cmr4703325qkh.10.1677527550767; Mon, 27 Feb
 2023 11:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20230224113837.874264-1-jneanne@baylibre.com> <20230224113837.874264-2-jneanne@baylibre.com>
 <Y/iqhsEIvHgnZ+5l@surfacebook> <CADL8D3bm82+=LwYnve04FB2zsSJ6ceKQHycV9oNWoYFiOQnVCA@mail.gmail.com>
In-Reply-To: <CADL8D3bm82+=LwYnve04FB2zsSJ6ceKQHycV9oNWoYFiOQnVCA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Feb 2023 21:51:54 +0200
Message-ID: <CAHp75Vc52cqPaTFTvi2E-3Gg6gAsDWc7wSWjn7wMuhcxWqFXBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     Jon Cormier <jcormier@criticallink.com>
Cc:     Jerome Neanne <jneanne@baylibre.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, tony@atomide.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:20=E2=80=AFPM Jon Cormier <jcormier@criticallink.=
com> wrote:
> On Fri, Feb 24, 2023 at 7:16 AM <andy.shevchenko@gmail.com> wrote:
> > Fri, Feb 24, 2023 at 12:38:36PM +0100, Jerome Neanne kirjoitti:

...

> > > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> > > Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> >
> > Not sure how to interpet this along with the From line.
> Are two sign-offs not allowed/expected?  I wrote the initial
> implementation of this driver and Jerome updated it and is handling
> submitting it since he did the rest of the TPS65219 drivers.

1. Submitter's SoB must be the last SoB in the chain.
2. Developers also need to be marked with Co-developed-by.


--=20
With Best Regards,
Andy Shevchenko
