Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306CE72198C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjFDTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:31:42 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1525EBD;
        Sun,  4 Jun 2023 12:31:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75d4dd6f012so151999685a.2;
        Sun, 04 Jun 2023 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685907100; x=1688499100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhHt1Igy5XGokOhDhTq6mJz2pRBSZ6AO9ZY+vSnJL5c=;
        b=bjReZaID2MFIkZ43YlEG6qrAJCmtsfoggepopslbsdx9KdAg2rtBdb5RaVRMaGuLZp
         i4ld6ELYnY9l9twnqNvzAIV9jMiphUg0zgIx0NMs1XhwYLP9BURjFysnKIZmEwYQecAY
         upzxRvvaIhsjhtvi+Xs+iTDSHSCpwhCHY42a1v+g182WMOhOtaeLVD8SUpERWWbR6w4Z
         WyYnCXf4I3ajvYriMZTuctlU7IcLHWPluALBXQ+N8nJkhOnIghIlzU2Ps/ydfr7RHL+B
         YbZ8ieT4meKn7qVmsPB7kEivKubzuTx08jhnvqcnM4pG+TJJzgYMSmgL9XqHCv0ho4vV
         lxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685907100; x=1688499100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhHt1Igy5XGokOhDhTq6mJz2pRBSZ6AO9ZY+vSnJL5c=;
        b=VWXVT2GFdw3ReTKJRd0B5J/fy+0FfaC8fBjpbmhTjp86Qc/PuwpgqdwIjnzU+t/ivp
         r+dPT7mv7XeF2D9syVrlnjsVsHF+y4xdh6eNi8z90+Vf5x+EBo+J7qctn7z0JxZYbguq
         drLSO5uG4e3LMnKqcUxLuPLLecJsYGh9mFKN/v5EgFsOUUHxC99CY47Rr5rdbF4GzkGg
         W/CoqDRc4Xs3smh/LGkbX4VKj1zh5ZlVZHjdTWvcgX2uXgT6PyL7EE4wJA4S59ZV0/Ez
         fyA0Ku8GNLJzKjgaaM3gEmT/T6aPxs4DSftUuq9y9mdp+mlD2AOD+vgcM6s4KoAOhvmq
         IqaA==
X-Gm-Message-State: AC+VfDxQthQjeujordYYeZ+nMZ6xNVs1HPKP4emC6cFtFpbXyFKc4wS/
        tRimc1RQhwraXeUxxhN+aPyxTf7FzneDp1WoDDs=
X-Google-Smtp-Source: ACHHUZ6MlIIw7A2FKKKISZs9OPXU4Dcn/MhmC2rODXVKZdRXKFeyPf6aHG+HT2U7NC3LGgFRVY6xoQFh4CvO2DDHJ0k=
X-Received: by 2002:a05:620a:19a5:b0:75d:a13:ae74 with SMTP id
 bm37-20020a05620a19a500b0075d0a13ae74mr19736789qkb.36.1685907100148; Sun, 04
 Jun 2023 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230602152626.284324-1-hugo@hugovil.com> <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh> <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
 <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
In-Reply-To: <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Jun 2023 22:31:04 +0300
Message-ID: <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
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

On Sun, Jun 4, 2023 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> On Sun, 4 Jun 2023 14:57:31 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sun, Jun 4, 2023 at 10:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > > On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:
> >
> > ...
> >
> > > > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
> > >
> > > This returns what, mctrl?  If so, please document that, it doesn't lo=
ok
> > > obvious.
> >
> > Good suggestion. Because I also stumbled over the returned type.
> >
> > >  And as the kernel test robot reported, you do nothing with the
> > > return value so why compute it?
> >
> > It seems that the entire function and respective call has to be moved
> > under #ifdef CONFIG_GPIOLIB.
>
> Hi,
> it cannot. See my explanations in response to Greg's comments.

Then as Greg suggested, store in the structure and make this function
to return an error code (with int), with this amendment you don't need
to add a comment about the returned variable anymore.

--=20
With Best Regards,
Andy Shevchenko
