Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1469C08E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBSOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBSOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:10:04 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219CDD510;
        Sun, 19 Feb 2023 06:10:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w4so28593qkw.4;
        Sun, 19 Feb 2023 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fr2lIso7bpIUD7Ha1nqI8K+I3x8DLSNI6+bQlnGF+k=;
        b=IX4GE9MaRsieijPWNpdzJP4LX1Q29TIa+xP+iUIR9KvBiN1zjhKHaiCNuTpGiKnTiH
         Leb17rrsVfxr6rxPPTn9UD+4zp/93qOZnFG0Zz3MTRJVNX7B8edZ+JIn+cm9usrxfcFt
         md1NELfQrvWYidiKR9508qDxUewGMvpQeQoHgM49swqpMSb6bZopgwli14eexUejf0J0
         o6z1PpCy8E1ehfulj4xHoJOa2Q+EjqWZWVU480pH27rCouUPrwORvSuuqdlcd2CrIhLM
         GPg7C6sRAoC1kgohoDymxXW4zTnkmNNbeFN+G5GUb1cxEoFacYcp/oh2Xj99/yW0/LE8
         jN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fr2lIso7bpIUD7Ha1nqI8K+I3x8DLSNI6+bQlnGF+k=;
        b=wFdqTWNN+ecrGM5g6pYwTixUQy6wcOaJetikM8bqu6i7KMjs1EqNhOrH82ewfNZfJL
         SaRKrUo4L7l3Z+FFK2s/BN/cZDMk1RUtcI+YwqoRy+rb6NrOO5dU1YUxOVxRnn/9apqH
         WQAfOZNS26C+xkV0vHTHns/rvNsbqeDP7mogWm+0204t7OjhHeUiOVUBMGpyRbK01BLW
         ZejopZrjYhO8v9X0ThxW0iWebq/Y+SQrPZ1JwVxfyV8qyYkKD6YWjiwUCQMhLfV1UsX/
         mOgkkCBIYXIxa8SAUb9j2SRloIS1rfeM/KEk8d5Fzb/zhyUQPDubtwuiUxsK+lqyXeS+
         UpUA==
X-Gm-Message-State: AO0yUKUCsHSBCOT+DLvcB/ZzLQ89muf0hPdvbmAmgZrHm1LVZD1XYnGZ
        xUmib2F5yg8xCTEU4/h/8UYNC0VVM9reVavUMTM=
X-Google-Smtp-Source: AK7set+clf2xmfexuw1XmRCmusE/KdeVHwwYxVr5A/glHe9HDYyvGTmY8ad5/pz4ykamUQVOdCKpAsgMIacdUwAEdgk=
X-Received: by 2002:ae9:f716:0:b0:71f:b8ba:ff4c with SMTP id
 s22-20020ae9f716000000b0071fb8baff4cmr614308qkg.10.1676815802247; Sun, 19 Feb
 2023 06:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20230218090709.7467-1-orlandoch.dev@gmail.com> <20230218090709.7467-3-orlandoch.dev@gmail.com>
In-Reply-To: <20230218090709.7467-3-orlandoch.dev@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Feb 2023 16:09:26 +0200
Message-ID: <CAHp75VeF6ypA7mSYZrMsNr777f6zjEJ6nkygEc_NQe-nMhjRFQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 11:08 AM Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
>
> This driver adds support for the keyboard backlight on Intel T2 Macs
> with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)

...

> +       help
> +       Say Y here if you want support for the keyboard backlight on Macs with
> +       the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note that this
> +       driver is not for external magic keyboards.
> +
> +       To compile this driver as a module, choose M here: the
> +       module will be called hid-apple-magic-backlight.

Is it my email client or is the indentation of the help text incorrect?

Hint: the text of the help should be <TAB><SPACE><SPACE> indented.

I believe checkpatch.pl at least in --strict mode should complain about this.

-- 
With Best Regards,
Andy Shevchenko
