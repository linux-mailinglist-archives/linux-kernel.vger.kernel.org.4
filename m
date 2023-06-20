Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E09737033
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjFTPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjFTPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:18:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6E1709;
        Tue, 20 Jun 2023 08:18:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a5eec783cso2602166a12.3;
        Tue, 20 Jun 2023 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687274329; x=1689866329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZDKKOakvN05hpS3AjCZw+OdYDZU5cyEh1RFlcjf8m8=;
        b=EGh2zndZ642Kg7kJIUKZ+qnpYZXT8OGe8Pi22E05jfCUVVpM3w68U1GGzySWBtBXDl
         QHxwGbRhYPcimhS+IlKNc0KsdUPEF7XYr68jsjShLAWZgGEFfjuvmC/lq25uBxYFRxNs
         lKpVyd4gnAICDFqnNVdTG7n38kZrkRjQUPMYZHGSN4x+1AvCDweoop0KCQyh7Gvv/O7A
         Z+aJPb0htqwvQfE33h6GhSL8QWCDAzUw2Yvmal/cBgJo2uzNZTpRCgi818gStOUpuyAQ
         H7wMw2g6GFLWt4wq5e8zOl11B0Tqp9cq5RJQ0oes0KqFt94iYI2gsO+82phW41ZVoV24
         1ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274329; x=1689866329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZDKKOakvN05hpS3AjCZw+OdYDZU5cyEh1RFlcjf8m8=;
        b=TvTKUzi2y15vozE/nDYTPGpZRdbHHn2iNNiztc+H6J/K1P72lr6claMNJSO3X9CaaM
         TYMdZHrWrYdpn66E81C/wCGgYKOlL89fTGmmuF0LcQET6KgO+JEVHSJbfS7F5P6DS5vg
         ZztWHEkgQBaHG0/9lS0uAMw+PlTWTjUlBP1N4HJQvFu3EZHa/fQl+42plfIJCWMzn/81
         pXMTBAFC4QWRxmypJxiwx0GayWYCKlwVSzfjt1k1BJcqGvZ/p6AyY4nxfAlYcV7bNSDd
         tcDPKlJfwBm7qiNM/nWgYdg2rqdomELPfjnpVWdltQcb4uZYflSgq9wtGwOosxfB9gBr
         94gA==
X-Gm-Message-State: AC+VfDxjQExlLFnj0vHUHLv8LybmhO26eZ95ebkXpRkAYyj5mnkrx95C
        bOnHJNY3neOiQAiO4qjiiUgl+E5Yxh8TdSLSUjA=
X-Google-Smtp-Source: ACHHUZ4K8IHLVxWGs/x+ckmsWQp/GKbNdQqaxI28mZt/qOXmQJkEfLWRBtVzuuFF77VTfWzYfGY7jOHN0P1FVgcZjYI=
X-Received: by 2002:a17:907:728b:b0:988:e0cd:99c4 with SMTP id
 dt11-20020a170907728b00b00988e0cd99c4mr3863115ejc.31.1687274328475; Tue, 20
 Jun 2023 08:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230602152626.284324-1-hugo@hugovil.com> <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh> <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
 <20230604134459.3c3844012e9714fa2a61e642@hugovil.com> <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
 <20230620100846.d58436efc061fb91074fa7e5@hugovil.com>
In-Reply-To: <20230620100846.d58436efc061fb91074fa7e5@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jun 2023 18:18:12 +0300
Message-ID: <CAHp75VcWSVgA8LFLo0-b5TfKWdHb2GfLpXV-V3PZvthTv1Xc4A@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
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

On Tue, Jun 20, 2023 at 5:08=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Sun, 4 Jun 2023 22:31:04 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> did you have a chance to look at V8 (sent two weks ago) which fixed all
> of what we discussed?

The patch 6 already has my tag, anything specific you want me to do?

--=20
With Best Regards,
Andy Shevchenko
