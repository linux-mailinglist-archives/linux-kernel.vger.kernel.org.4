Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A108570B537
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjEVGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjEVGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:41:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F1B4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:41:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-970028cfb6cso39206066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1684737713; x=1687329713;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJchVhVXH9Pf5bh8o3X5e0MaNqDm51aU4pHZLRBh/rY=;
        b=kVpTRRWGT8/kR5rq5l+1tj8tRbHVbcbOY43GPRrEz/3+jvFN03mEhiYBzdumHr19/m
         thDKxvBRKoe4AVhhXmFn8e45GNFQMsoCg8FiXam2IdlWsH+Qjs70VQogzVJYCFiTNPED
         RlFPMXobgftiq5AhziO413H9tHO3BZPf2CzwJJZarEpDI0f/LfivagNY6+9Y9if1OuD5
         tDYQCGXBIBjyZGFsmBf2HI7/EGowdeRpDWr68JxVpfju+SWi5qhkL5is2Iut09J3Tosv
         zHYMpyAxfL653C10gG54Z1FtngnARUgw8/OD6j7VlIxkdbeThAb1Et9WsX3QMqnAcpUW
         MWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737713; x=1687329713;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJchVhVXH9Pf5bh8o3X5e0MaNqDm51aU4pHZLRBh/rY=;
        b=BOKL1sQ5zgPVovvGp4rOtSalfPQPat6vjk4XbR0HkQidDXP7lz00yPxP7W/iqlwKDG
         9V0XlQVekwVoOkwZ1zz33aJJKSdgSVReXLVDSViHtIYFa8eMbMPNQO0Ws6izDZz7LJd5
         zNDeeVhMefYjUrZsLU6vJcFQP3s28eJYNsxRdUq/a+LPRz/Ur3GNdPuE16g24uNuHHfG
         1FXqYoJkFj1jmdyG1tiZlMkwU1R90I07Owl8T5AriN5RZ5m0VzQZScwkTdRfq0ek+8aT
         IheVVf+s+lMM+zr799bCU+4xseYWR4EZd+NNh4Ix+68WEWJ5Hn12ZIhbu8qfOtgXgOqo
         xx5A==
X-Gm-Message-State: AC+VfDzQNlAQHKDeUn1USbqc2O15GkWIO8J2zKQcppaVqQ23FHVc42/I
        dK8asENQTT8LqLTUHEVrgGxJiA==
X-Google-Smtp-Source: ACHHUZ5AsJHZlgYjQ+r41PLZ3kgOLmnY3ldyRb6lRs48EHoxQ970/CCsXl5nSXAJur/0g4HRNW5B/g==
X-Received: by 2002:a17:907:3f29:b0:966:63ac:3706 with SMTP id hq41-20020a1709073f2900b0096663ac3706mr10075942ejc.26.1684737713543;
        Sun, 21 May 2023 23:41:53 -0700 (PDT)
Received: from localhost (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id my19-20020a1709065a5300b0094f3d700868sm2673332ejc.80.2023.05.21.23.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 23:41:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 22 May 2023 08:41:51 +0200
Message-Id: <CSSLOC8WDIPE.1WO9BXZQA7A12@otso>
Cc:     "Petr Mladek" <pmladek@suse.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Jonathan Corbet" <corbet@lwn.net>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: printk-formats: Clarify %*pb format parameters
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.15.1
References: <20230516-printk-bitmap-v1-1-d5f810192a10@fairphone.com>
 <ZGT+lJasWhZ0TPRi@smile.fi.intel.com>
In-Reply-To: <ZGT+lJasWhZ0TPRi@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 17, 2023 at 6:19 PM CEST, Andy Shevchenko wrote:
> On Tue, May 16, 2023 at 08:52:43AM +0200, Luca Weiss wrote:
> > Since it's rather unusual for printk formats to require two parameters,
>
> I don't think this is "unusual".

Well, unusual for me at least. I've never really used anything except
the standard integer types and %px. And I've been contributing to the
kernel since 2017.

> The %*... is very well described in the printf(3) (the meaning of *).
> It applies here for %*p... as well.

The printf(3) man page is never mentioned on this docs page. And even if
it would be mentioned somewhere, I doubt anyone is reading most of the
page when they're just looking for a format specifier for e.g. bitmap.
At least I am not.

>
> > expand the documentation to clearly mention that in the printk format
> > for bitmaps.
> >=20
> > As an extra example, for example from include/net/bluetooth/hci_core.h
> > we have a bitmap DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
> > This can be printed with ("%*pb", __HCI_NUM_FLAGS, hdev->dev_flags)
>
> I think this change is not needed. But try to convince PRINTK maintainers=
.
> Maybe they will be okay with it if it covers all %*p... cases (like %*ph)=
.

Cannot say I haven't tried :) As I wrote in the initial email I'd be
happy also if someone who knows more about the formats to include some
text for all the %* options so users know what's up.

Regards
Luca
