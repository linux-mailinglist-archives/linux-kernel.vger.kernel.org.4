Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61561737BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFUGlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFUGlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:41:06 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DB135;
        Tue, 20 Jun 2023 23:41:01 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5608a4eb782so1342226eaf.1;
        Tue, 20 Jun 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687329660; x=1689921660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ysgQF8RYTV72R+xlp4a6KaZs3qrJaZLA5K9nlPSfL8=;
        b=UrmUfJacn2+Atvc85yd2QHDTNkeCmZuwEcsNObQV/K1H4n5F6lKNWsgGd4G3uV0x4Y
         us55bgdQD2yOnTXEdqthaJHycm0y9/pO+1u5ivlXTQ8TOAY6TmR9+VTBFzWP5SMGVrZZ
         MtaBHZUwFFwwGxyC82Zn4OYc+pXux7fhJa97O5rpfKuwbsn+ZvQTONgDc0nRuAi68br/
         CHchTdXao7Xnz5rw/IO4kNCfw8ShfrS6jwZZFh6/9g55yJsfMWtvnp1qLFFxATp+o7J7
         uSoS7uvjWKsgSnyeZB7mBUr3Pekfiy8TVHuAeGAVX81HMTJVfSLEV7sake2t2v03PDKs
         gpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329660; x=1689921660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ysgQF8RYTV72R+xlp4a6KaZs3qrJaZLA5K9nlPSfL8=;
        b=TqITqtROuw0RYNZEk3wNSy3tYzU1eoxWcKHswYT9k8OSKfq7AApDaKWqV6jpSQdkTB
         lyhnqSYo5Gdflx52a9ZMGx8anoHzpc8xwWP+Jz5qmhyqBHJ2mWeLulRd8yWnhk5lUDkN
         ilpLesJPQXXhSmnHUs8O3QMPPqc/2chmkFg4tsTDxeAlKXoaCFpaJS4F/5R+fgofPUZe
         +r4/BNm9MByVQqpjV7963gHwWLFaSt6djk93YzrV1Xt4EaYtTlVluuRorV9mefLO6YPw
         YRJAIxI3j1ZU5TYjVHD7tNRsXY0/w8P92IeXP9QnZk1OlZEdpIVMrmAZMSB79vzRT8Fz
         4FnQ==
X-Gm-Message-State: AC+VfDxitYac2ebFi61m93rEHZaa/KKCjbZrtomayk58PIgFd1V78xAf
        iEuqmxeAz4SspcL/9KbZZ/i7XT6GXiE+uLHqkA4=
X-Google-Smtp-Source: ACHHUZ68f8CiCQt9dfD89/gQ6qGI0fl6Y8NNKMolJ+1obYgCjNI0UpYMRqc3N1fNLeEw9V04zXGXrgcnlnhTNJI7ioE=
X-Received: by 2002:a4a:ead0:0:b0:54f:629a:f581 with SMTP id
 s16-20020a4aead0000000b0054f629af581mr7898897ooh.7.1687329660557; Tue, 20 Jun
 2023 23:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H96z65X5L-8=ouuKS-fkBUS4Uo4GTaYYgMDkw5G+v73hQ@mail.gmail.com>
 <TYAP286MB0315167833A9801E56BBFE91BC5DA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB0315167833A9801E56BBFE91BC5DA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 21 Jun 2023 08:40:49 +0200
Message-ID: <CAMhs-H-YVy20KxWgyovGmGh8UtVadDKA8O=mbRv7x6Y3PeEbQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mips: pci-mt7620: reduce unnecessary error logs
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de
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

On Wed, Jun 21, 2023 at 3:04=E2=80=AFAM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> >On Tue, Jun 20, 2023 at 12:48=E2=80=AFPM Shiji Yang <yangshiji66@outlook=
.com> wrote:
> >>
> >> These patches silence some mt7620 PCIe driver error messeges by
> >> removing the useless debugging codes and replacing incorrectly
> >> used 'dev_err()' with 'dev_info()'.
> >>
> >> Shiji Yang (2):
> >>   mips: pci-mt7620: do not print NFTS register value as error log
> >>   mips: pci-mt7620: use dev_info() to log PCIe device detection result
> >>
> >>  arch/mips/pci/pci-mt7620.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> >For the series:
> >Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> >I'd really love to have this driver ported to PCI_DRIVERS_GENERIC
> >moved to 'drivers/pci/controller/pcie-mt7621.c' since they are pretty
> >similar just changing that mt7620 and mt7628 init the hardware
> >different and only use one virtual bridge. My problem is that I don't
> >have and cannot find hardware to test. Do you have interest in helping
> >me to do this?
>
> Thanks,
>     Sergio Paracuellos
>
> Thank you for rewriting these drivers! I am glad to help test them. Pleas=
e
> let me know at any time when they are ready.

Thanks! I need to build time for this but I will do it for sure at any
time and let you know.

Best regards,
    Sergio Paracuellos
>
> Best regards,
>     Shiji Yang
