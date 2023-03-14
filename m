Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19D6B8CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCNIIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCNIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:08:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED681CCB;
        Tue, 14 Mar 2023 01:07:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b13so15108962ljf.6;
        Tue, 14 Mar 2023 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678781220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwDokkDCp3gvd4WNjn3p9IwIzF1O1UFas2ZgKmXkVJI=;
        b=BnpTt+CwtlFY0mm8gOhspRyImXLr2eyZ/8mVMFuQBCPLXA7cgKRp5FDKgWxU2om0Cn
         DaVCITLeQBWUgPNQLBOyXgmsXeXm3RuzC22bj+DeBxUw0kqNJKaa18QbhPaTSXPMFRzF
         4m9N3/ffmAPfMfcXLqwetrZWe3qW80RyPPp3dh3N/AjblVvsR66tle0XyX6BvPJqs9W0
         muyM5KEcEezxwN45H3z43xdKGb3gK06bkCnoS9Tawhi3hGBdNO1i6kqC3hfufzQsToEY
         fNFjW6asyErZQdSYv0FOLw9CKDYlOk/2lCD9iS77cHUm0AMfOOGtKU4WKdFuvyxomDVE
         Oq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwDokkDCp3gvd4WNjn3p9IwIzF1O1UFas2ZgKmXkVJI=;
        b=Lq+L0kckSQqYwLPATmvmo/+lFZtSfMjOtmPiCQmxFY8v+OoMLbpsx+N2jQEnZYIjd7
         KRf+zmytbUVvR6nTqxjLwYa9oFxbnm3Al+TN1cwDYhKxg77z68VXM2AzmTUtoCVp7HaU
         /tTF3BzV6+0ModHo1z0hMyo4prQIVGjTvXl2GbXm2DSmPVlo0jUrXZE4y+tQlOKNffBN
         eeZGzTmoj/d5UX2iYOHENLGiU/25b0DaBH2lQ8twUg04uHvyJdStWbAWzfAoFnCFW8nK
         uv4un8UB4a9jOJD8AOez/k2wVOS0KJTyLlO8ja9jZFp0J551FlP5sA6FXk0RH4obJRG/
         JyJw==
X-Gm-Message-State: AO0yUKXCnWuym5Wfm3fUTYZHMvdhiM8WwBq9lGdM9koikv284Ma50EFR
        NhclAOiwW/OuWfgh0NByCT2TBCGbLNgIQcas/ZQ=
X-Google-Smtp-Source: AK7set8ikbfZwHpd0zd3uhb8WhF1wXT9RDCk4Kevrrp3L4QFWYrViPVbZZ4pvMSKv6L1Ml/llbqKy/R0trZedVRhsW8=
X-Received: by 2002:a2e:7011:0:b0:295:ba28:a43 with SMTP id
 l17-20020a2e7011000000b00295ba280a43mr5249701ljc.4.1678781219868; Tue, 14 Mar
 2023 01:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
 <660ef0b7-fb09-5a72-57b1-3b57ddee924e@gmail.com> <ZAxZCJn7AN/yWSRh@equinox> <ZAxx1kYjVKFRE3kz@kroah.com>
In-Reply-To: <ZAxx1kYjVKFRE3kz@kroah.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 14 Mar 2023 09:06:46 +0100
Message-ID: <CAFLxGvwKaXviF=5OTtm+pPHwdtXTX6A2e_aRTUraOsxKOL3-4A@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: delete driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
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

On Sat, Mar 11, 2023 at 1:25=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > > > Also the rtl8xxxu driver supports way more devices, and is a fracti=
on of
> > > > the overall size, making this a much better overall solution.
> > > >
> > > > Thanks to the r8188eu developers and maintainers and reviewers over=
 the
> > > > years, your work allowed Linux users to use their hardware before t=
he
> > > > real driver was implemented properly.

Both r8188eu and rtl8188eu had support for access point mode but
rtl8xxxu has none AFAICT.
Is there something in the pipes to have AP mode supported?
