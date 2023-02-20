Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0269C5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBTHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjBTHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:10:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128165A2;
        Sun, 19 Feb 2023 23:09:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ky4so1488595plb.3;
        Sun, 19 Feb 2023 23:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TueDRDm3Jji/rHVHmT68cSt/Lm9yegzVpF0ZkJ2XCVE=;
        b=D5jAbYYcYIQNLmWo/mjCyxRjxk/jqNhpo5cw15EioA77/FMFTzzQXPeJDWJPrc24I3
         JiVqlCoZmoVv8uarvZVqRs4kaOUT+BiQwRijDqpUeQHVQed3T5blk0FEfeHr2JmkAQCs
         IW5idyTLxZsd1g5VxCWk0lS4ivMVXZT60aDVRlqEM2aE0MaPffQVJBxb2zO1kWUWIsNq
         7/UZCXspkNKXFluPj/upqzP0be/Mt96qKJm9WFZ71P4Mape/HOXHlyM0p1jBbPcfbVKX
         uMrWPQZLaNLG/+2U9huGdIRHPU++wKXJ/argjTFlv+ObYObLsmZcZa7ZqZKHe961dpDN
         +u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TueDRDm3Jji/rHVHmT68cSt/Lm9yegzVpF0ZkJ2XCVE=;
        b=3eHmnSJcTIaKazoPViO7CXaZnOn+/F9ob7W6J1UJoPBoOeV/17tklXa3B0UWR3AV+e
         iT9Fbnd/hUpC3QG+aRqxr0EZBLDTJq7qWts7vtEBQ4zQDqtiroRMQrLXOr5xuw8/zNfP
         aFeX6xZm/qFlMFbt2TAeFHj1hVWnFCZgvH96g8haXKSjg4VJ4VQVMgsWxoyDBi22f7y0
         YU/2wzqo6tn1mi7rSQTwTrDNM61/0ArvWLbQo9Gsi7WmMoEhIojC0Li+z+mMxeGwOKS3
         nYV0KvZqWvf2dVI6wDSjcapKm5pioCyGht/DrH92HkSnYF50/3dbSo9M1dF65jc7mKaZ
         /fSg==
X-Gm-Message-State: AO0yUKX39TiXHfd5bIZ3McBeBhbldQowqG6D9TkXZuLNTKoKUWa2gqPR
        kx1CbKVkCvdZuclxQTmrI6w=
X-Google-Smtp-Source: AK7set8v0EAdIMPudHrzDL/rhHKJd+e20xKHgYZU6Ijetv5xgIhVs3HqXRTJBJQFwf7bfV8pmIhncQ==
X-Received: by 2002:a17:902:e54f:b0:19a:89d4:802f with SMTP id n15-20020a170902e54f00b0019a89d4802fmr1638573plf.57.1676876982539;
        Sun, 19 Feb 2023 23:09:42 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b0019c33775574sm621846pln.198.2023.02.19.23.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 23:09:42 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:09:32 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Subject: Re: [PATCH v4 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
Message-ID: <20230220180932.2a7aa6b1@redecorated-mbp>
In-Reply-To: <CAHp75VeF6ypA7mSYZrMsNr777f6zjEJ6nkygEc_NQe-nMhjRFQ@mail.gmail.com>
References: <20230218090709.7467-1-orlandoch.dev@gmail.com>
        <20230218090709.7467-3-orlandoch.dev@gmail.com>
        <CAHp75VeF6ypA7mSYZrMsNr777f6zjEJ6nkygEc_NQe-nMhjRFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2023 16:09:26 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Feb 18, 2023 at 11:08 AM Orlando Chamberlain
> <orlandoch.dev@gmail.com> wrote:
> >
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)  
> 
> ...
> 
> > +       help
> > +       Say Y here if you want support for the keyboard backlight
> > on Macs with
> > +       the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note
> > that this
> > +       driver is not for external magic keyboards.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called hid-apple-magic-backlight.  
> 
> Is it my email client or is the indentation of the help text
> incorrect?
> 
> Hint: the text of the help should be <TAB><SPACE><SPACE> indented.
> 
> I believe checkpatch.pl at least in --strict mode should complain
> about this.

Looking at the hid Kconfig, it seems like some have it as you've
described, and some just have tab (and a few have just tab for the
first line, and tab space space for the rest of the lines).

checkpatch.pl --strict didn't complain about the indentation so
hopefully it's alright as is.
