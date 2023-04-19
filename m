Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087966E72AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDSFsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSFsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:48:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53C59F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:48:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54f6a796bd0so371911547b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681883316; x=1684475316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4bx1lrPt7EkQTFUhn+tnnmLkUflOfyoDdf2Nh8k7go=;
        b=NDSSkGY3R//+h2GDgeukfHv1wKB990ASuIBacYtJi7akdl78oBCgfqzUJSPDugRLP0
         0SwZh70QC4aV55zP/QS7QkjuUt+R/ftbL/uF2Uvid7vhacEKXQFCH6wEhHW4boT5OtuW
         xD0WPLgd7ZlmSDufqrlyOgVVME77octjjqZX44WnJ24tKUDAT4uSYHEYsYF6PNvjv6BR
         4auPLOMSJpbnUiMUvuFrdPMwEvIgY/oTN0QZGZlEg6K1s/BwCpDpANXd1ujfq7E9ajb5
         9KwkFc7neUNclkx4vZ19h+J+5kQrwLtE5HtAYjkm34KK9f1bk5DV4YiDkvODL8yig6/h
         LN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681883316; x=1684475316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4bx1lrPt7EkQTFUhn+tnnmLkUflOfyoDdf2Nh8k7go=;
        b=dmQJ14d+DAz72RNqb9xI/mQuiEYIE6H3mRpAxP3NkRYJKS+PLMuoQynxZK4XHGE9NX
         gcmurizEQGisMIG7in8uCp4Y8savkNHsagdCFQ5s3F6WTIEeMQ3PMcellYrVodSyvDl1
         4NGI7dg+/oF7inYK4ZuqZenrO6bL/Dn0Z/f9NPv1ia9X38AOw7l7F/WRjaJjjC127kPI
         Zjz1DDarjLrzHqEYwf7OXUKG3woFmWdZOTKC6NGr3udcg+GfWwYlMjp+hNOv7SdrVlFW
         2uqieNDS5tpieZkqzbxzKqb1J82hsFLnGqBLydusQEFZwI050tEg8ZfYLYugPg2qNiOH
         YXRA==
X-Gm-Message-State: AAQBX9fnhlvOtDFh4fJRshSMWSdr+QlkMQDyAiFKr0q+agah+UDH/Moz
        Flaxk1iP4etigsLuKCQUYSDDhHfTujn2pVHBFnbGjw==
X-Google-Smtp-Source: AKy350bhgIZfl+76ufNilmmY2MnTYA9MZXAIWAcOr78M6MH58CYU9cGj3mCALecz83+OYF4IuRIUELBQPUaCYMkEDnc=
X-Received: by 2002:a0d:eb08:0:b0:555:d266:acc5 with SMTP id
 u8-20020a0deb08000000b00555d266acc5mr678715ywe.29.1681883315944; Tue, 18 Apr
 2023 22:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com> <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com>
In-Reply-To: <ZD5JC7BdN1usn6Kd@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Wed, 19 Apr 2023 11:18:25 +0530
Message-ID: <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 1:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:
> > Store address width capabilities of DMA controller during init and chec=
k
> > the same per transfer to make sure the bits/word requirement can be met=
.
> >
> > Current DW DMA driver requires both tx and rx channel to be configured
> > and functional hence a subset of both tx and rx channel address width
> > capability is checked with the width requirement(n_bytes) for a
> > transfer.
>
> ...
>
> > +     /*
> > +      * Assuming both channels belong to the same DMA controller hence=
 the
> > +      * address width capabilities most likely would be the same.
> > +      */
>
> I had a small comment on this In v6 thread.

Sure,

Your comment in V6 thread:
"
I would add something to explain the side of these address width, like

         * Assuming both channels belong to the same DMA controller hence
         * the peripheral side address width capabilities most likely would
         * be the same.
"

I do not think the address width capabilities are dependent on the
side of generation like memory or peripheral. From what I understand,
address width capabilities are solely dependent on the transaction
generation capability of the DMA controller towards the system bus.
What we intend to highlight here is the assumption that both tx and rx
channel would belong to the same DMA controller hence the transaction
generation capabilities would be the same both for read and write
(e.g. if the DMA controller is able to generate 32 bit sized reads
then it should also be able to generate 32 bit sized writes).
With this assumption we are doing a bitwise and of both tx and rx capabilit=
ies.

Please let me know if you think otherwise.

Thanks
Joy

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
