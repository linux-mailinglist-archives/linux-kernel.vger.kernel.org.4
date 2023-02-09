Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AD690B19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBIN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBIN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:57:05 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEBCA14;
        Thu,  9 Feb 2023 05:57:01 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id g18so1884222qtb.6;
        Thu, 09 Feb 2023 05:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqwgBNgfNhKkNqMMtrvACk5DcOIAbHYzACYlkaulAAE=;
        b=xfPEoqkPmHBvB8VIRxgFCzG4KLJV0YcuU7kC6CzDqhp9uepjJYzrvawbKatPpQ4N1Y
         WSxIt3F5UtyTFL9D0Yzs1DYp2LlJ6aW+1d9eI5u2hpOPBuYya/6EDdnDPRTfhkauIGj/
         72HhTKWntpN7Ci/Zo+kmHiDQVrACxSLfFBT/SIhQyAmIr6O75t++7KCDBgUUDeSNEszw
         5rtIGiJhhxY0M3hOyLshUhLjJuI/MUDULbrnVF+vRzDrOmi5tOFt3zbkY6C+f1kZ83w5
         cKtN3/Uk8Tar8hvHqaCL9V+3Lp3ppD3hgd4m/tAgt+oIeHw3nmEqMQbEzIhbQb+8j8Hf
         efsQ==
X-Gm-Message-State: AO0yUKUuYiNqwcYtzV3qCTgEwDX42q/ic39IHNn0WYDqdn9f173ELWrS
        HL6/Hq+dpSUF72DwxBCU3aDaNXQXjq+ytw==
X-Google-Smtp-Source: AK7set9pTILGaFaFiep2JpXYBUMzByr+wZwqff0ZP9jfRTpYDWNT1vsAHdfmxvTOYC/f9wnePWQs1A==
X-Received: by 2002:ac8:59c1:0:b0:3b9:b6e3:c78e with SMTP id f1-20020ac859c1000000b003b9b6e3c78emr19345108qtf.8.1675951020073;
        Thu, 09 Feb 2023 05:57:00 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u1-20020ac83d41000000b003b643951117sm1275339qtf.38.2023.02.09.05.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:56:59 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-51ba4b1b9feso25654117b3.11;
        Thu, 09 Feb 2023 05:56:59 -0800 (PST)
X-Received: by 2002:a0d:e9c1:0:b0:514:a90f:10ea with SMTP id
 s184-20020a0de9c1000000b00514a90f10eamr1053564ywe.316.1675951018992; Thu, 09
 Feb 2023 05:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20230209010125.23690-1-rdunlap@infradead.org>
In-Reply-To: <20230209010125.23690-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Feb 2023 14:56:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWLAbXFUHg+TT45AqVq6kHxK=FN=5wEHnpdiR0dn2L_g@mail.gmail.com>
Message-ID: <CAMuHMdXWLAbXFUHg+TT45AqVq6kHxK=FN=5wEHnpdiR0dn2L_g@mail.gmail.com>
Subject: Re: [PATCH] input/misc: hp_sdc_rtc: mark an unused function as __maybe_unused
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 2:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When CONFIG_PROC_FS is not set, one procfs-related function is not
> used, causing a build error or warning.
> Mark this function as __maybe_unused to quieten the build.
>
> ../drivers/input/misc/hp_sdc_rtc.c:268:12: warning: 'hp_sdc_rtc_proc_show' defined but not used [-Wunused-function]
>   268 | static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
>       |            ^~~~~~~~~~~~~~~~~~~~
>
> Fixes: c18bd9a1ff47 ("hp_sdc_rtc: Don't use create_proc_read_entry()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
