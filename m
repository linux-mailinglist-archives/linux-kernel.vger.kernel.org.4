Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F090728CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjFIBCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFIBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:02:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF9270B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:02:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b022faa1dbso1879305ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686272533; x=1688864533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQmmOcARHheT/z0yqfeYwhuuLEt2pQoVjtP4drhj3Is=;
        b=f6Ro4yKSSB8vqHOEQfM8BBmex4shPq1e4xgFGvpi0ZMfFgMtFAuoUkLB3uEbzKbol0
         bwa5UqJDV7JzuHls5aWMaO/80Au9uBLvgK1Hl0n1nq3h6xDyReOyb9F22aeDfbV5slJS
         k3T/0ovb7Dgfc2FLO7qHR+LKrZ68Zj4VwiSHkJI7tvUMk1GrKAIpJcW1kYB8M9HDxKV+
         9MJiavQOZ5Ej3J0hi44VcEJdbwmifu/rb4IoghCWbMJCcgIHtcq/hzJphxs3eVdKSxY5
         7lTDV7iBiTKEGSpkvG7SQ96nadCW2tTkRLDn8yV5Uld/Ilery/ywiCfDNgp2Onbn6mvO
         Vk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272533; x=1688864533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQmmOcARHheT/z0yqfeYwhuuLEt2pQoVjtP4drhj3Is=;
        b=FHyc8pNeyISaWe94SlAdI6iZLfT0Wfvwpw7sNPGDdxNmqn9dbGRz6JOUTXOKEOqco/
         f9AKRQZ/VzYse+LWR6S/QSAEcVo/EfIol8xxrEP5LD+qVxhO+TfO93xGVHcft+CGchDp
         CCUCJlg4uZuo5dOTyx+s7kluDPQ8j34+qYFNbUHBiHpqHWP5hqyIAFxqSXyA1DTU/psK
         UAuLJOlK6340FQhWW8dPEPVeGrivmrbxmL4w9+u2RBRHjchIt1YKkXRD8oNko3xTfoRv
         0EuBBwkqxdv+uuC/FQ4jP/tllyXmlfIIT3Nhg/Ttmf3wnKl7oAYlPqUARBs+llpxGuE2
         VbWw==
X-Gm-Message-State: AC+VfDz0P/eX8FP3ukY43dQAFr0wh9K5dfOfQHc1N2kcq6lYjvDVSPwM
        DoLez4sOyVCT3+Voc6MPJ5v1JS65Ep/gxRbbmiJmezad
X-Google-Smtp-Source: ACHHUZ4JlzYLrk3G44UTV1BNyYCkM2xR3ckuEqr6N3eVqsOpz/ptx9A3yYPL5QJQFNkL0vmhXikApWVt32L1jCsCoZc=
X-Received: by 2002:a17:902:e881:b0:1b0:3cda:6351 with SMTP id
 w1-20020a170902e88100b001b03cda6351mr98158plg.0.1686272533333; Thu, 08 Jun
 2023 18:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230607135746.92995-1-hch@lst.de> <aab7ae20-d36a-47cf-bc1a-9590c3d8b3b7@sirena.org.uk>
In-Reply-To: <aab7ae20-d36a-47cf-bc1a-9590c3d8b3b7@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Jun 2023 22:02:00 -0300
Message-ID: <CAOMZO5DhO7G70FZXZzwoX_Xm=VHtb8E=8G8moz+CjEdnUc2Eeg@mail.gmail.com>
Subject: Re: [PATCH] block: fix rootwait=
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
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

Hi Mark,

On Thu, Jun 8, 2023 at 3:26=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:

> instead of mounting the device we already knew about.  A bisect (log
> below) lands on this commit and reverting the first hunk:
>
> > @@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *nam=
e, dev_t *devt)
> >         *p =3D '\0';
> >         *devt =3D blk_lookup_devt(s, part);
> >         if (*devt)
> > -               return 0;
> > +               return -ENODEV;

I have tested reverting this first hunk and it also works for me, so
if someone submits this fix:

Tested-by: Fabio Estevam <festevam@gmail.com>

Thanks
