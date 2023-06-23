Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB673B908
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjFWNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFWNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:47:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E46295F;
        Fri, 23 Jun 2023 06:47:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-400813b8d56so6733871cf.0;
        Fri, 23 Jun 2023 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687528019; x=1690120019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtSnLqvq14Rr85WaxZAXeIyzcEXPKQGLmrm6XWEJDhI=;
        b=UtX9KrGRy52Zpz0RnmIaybha36qOxDLdRo1HMbE/pXtTMBLe+8kPWomypmDvRvqjHA
         erDid/mEJs0MmkxUmY/4brVwDfCCTyN5MV1uJzwUUh6vhzYBZzLoSdupC1NxyJtMYzAd
         oPKE8hOecaI56Fj4qaazoNQLFcZu7AtHmNVgpjlWbMvylX2yVh/xlkvcYUUputYHDtI9
         OiCwIm9MPa1vvD7aQZO1raEJVRey/KP9VHqaoC+BEZzXBvCMkLvY1eWHj8/2P0a4tCRe
         sLcohL1jo1D2YB8dBGhfY5k9lfnKwJ7uK9A+GOo8/YjGEz/BgEUkMuL8IPljzywYAFbU
         t7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528019; x=1690120019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtSnLqvq14Rr85WaxZAXeIyzcEXPKQGLmrm6XWEJDhI=;
        b=eOIxsDaaQmeNf9arminReRQKoQFm1DJ8D60/yAItIjFttujqAo6Mt/fj0tzra+lG/6
         nis6OTPAcmJt1ivVA60cVuJ+sJZFEF5h/Whel/oe/b/1DYs0D4V450PCnoYbSf3f8LKm
         eOST+VEolr4ESuo9bBzj39yqEvXsocj28bsLLBT73Z7tWLbveuny79uDeDSfbWrqLHo7
         iMpcvcRy7WDpKWIaX9o8tORTTFp0sWqcB66vfyfCvIPlgZgLPGcilNbXYWHTLQPXbMkf
         MiUtEcAX8hJItWZ/ZfeWCosucGZMCCMe/zcNlv02BhanwJaqvEhX38FIGl55ICHUdHp6
         McCQ==
X-Gm-Message-State: AC+VfDxwIxqQ4fdXuA69LCnzC7/cU3BiZ8z1yCTIHxRNfXM5PIDeUH5i
        MDTsWordPXcBl23G42K0FXByCSeKpvfQfS3gTOo=
X-Google-Smtp-Source: ACHHUZ4C5q1V7sdMNwyidAY3nT0Vr4GNXRcvam8SGvDz9FbE71ZO9W4ixK3LGNQ12fXmcchXkUcAEdAUrgBctnAAX8I=
X-Received: by 2002:a05:622a:203:b0:3f6:b9ff:7a1d with SMTP id
 b3-20020a05622a020300b003f6b9ff7a1dmr26423141qtx.54.1687528019107; Fri, 23
 Jun 2023 06:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3zgmsC2qKph_wDfknSa5eq6EnJqxzzj4K7G4_ZxGr5ZQTqbA@mail.gmail.com>
 <2023062256-walnut-pettiness-f4dc@gregkh>
In-Reply-To: <2023062256-walnut-pettiness-f4dc@gregkh>
From:   Tim Lewis <elatllat@gmail.com>
Date:   Fri, 23 Jun 2023 09:46:48 -0400
Message-ID: <CA+3zgmtGbwS+4VXhT4-G1sQyWFWKSPEu9hF3bkmaCNtagzXqig@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     osmtendev@gmail.com, open list <linux-kernel@vger.kernel.org>,
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

On Thu, Jun 22, 2023 at 3:36=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jun 20, 2023 at 09:25:52AM -0400, Tim Lewis wrote:
> > Is it intentional and acceptable for dmesg to now log 14 "Failed to
> > create debugfs directory" messages?
> >
> > I assume it's related to "regulator: Fix error checking for debugfs_cre=
ate_dir".
> >
> > dmesg 398 lines: diff ./5.10.184-rc1-dirty.txt ./5.10.185-rc1-dirty.txt
> > 19a20
> > > 12V: Failed to create debugfs directory
>
> Do you also see this issue in newer kernel releases?
>
> thanks,
>
> greg k-h

Yes;

# uname -r
6.3.9-dirty

# dmesg | grep -c "Failed to create debugfs directory"
13
