Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112716ACD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCFSuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCFSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:50:32 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1ED69066
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:50:28 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m25-20020a05683026d900b006941a2838caso5885881otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678128627;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl9PzkGTNX+thecKR4XivBtLzgWl/2M0Fkh5qWqLnkM=;
        b=ICFufWtJUiPqHV0KKDhKvhAt3NJnaIMuHad9FzeEjdzGpRpGnNWif3x0I9yLS82H/z
         TsolVO1yBAd9p8frFSmKJzqFkr1T8IIbwu8DtQDHi6uvZm6+uN+Ni+xHuKYMHrUiCS60
         Gsf4EkYzg6zl4kWPxe7wRAQqJR9pvGJG29NddAaFZ+tsMYE21YM+3kbr6qEPLpyhOQd/
         05rXnESsOOc4O0+qXGVDTRrWB+VD3paAIaz/FsGlIWd55ce47I+trnRdVunHYecU6Qti
         UjFI86PWIbSnTDeO4gju50LtYCRRac/fV0/Ay89L+oNQkFgO565qKXL+sO8n9ReEFsw8
         V37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128627;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dl9PzkGTNX+thecKR4XivBtLzgWl/2M0Fkh5qWqLnkM=;
        b=0E4Z/SFharV4k5cLHtUDlzR7aWGvqitqfkl1FJF1llctEEDQWP6BXCxX18U4gw81ov
         TDqWUncet085FC3cgno1/7NPW03pgWkw2BreUbpb7PhA60AU292XBcXDlW4ysGs0ZaKz
         yXJ5Wzc1kZcPqmVGGzetiAsGF0ka8vKIj5zCLn/DHd9ntJmm6uu+WBrQJiLHZmIKT7Zw
         wLhWASvLOW8bEoDEX9+t8nniWfa5ziC01qx50lUOPuHsgEBiB9gzcIRif12sgA+Uq1Y5
         SW9Q6CMnCXeTzQMwKhupk1waEZWZc/fD4cU4hK1W73mowHQfJzWmWvvb8B0jqAA5yY7V
         GGTQ==
X-Gm-Message-State: AO0yUKUuWek/7S94lYPgvspYhTRcFluPGE88IEJhj/jkUBbTBYW6lOpU
        dd0RnwA8Vb1J2Mv6EdLssp4j+6obTh0=
X-Google-Smtp-Source: AK7set/kV9qFOpUfJqqRjD/yumRURjtuVaPZbZhJURRFWpzNCfWP01ajGBVlNbCXUF5ICch67QPKYA==
X-Received: by 2002:a05:6830:4423:b0:693:d998:f52f with SMTP id q35-20020a056830442300b00693d998f52fmr6601602otv.35.1678128627357;
        Mon, 06 Mar 2023 10:50:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6519000000b0068bd5af9b82sm4501905otl.43.2023.03.06.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:50:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 10:50:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc1
Message-ID: <67c5ad57-beed-4988-9b5d-76b5bf4dc348@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:12:01AM -0800, Linus Torvalds wrote:
> On Mon, Mar 6, 2023 at 8:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Various crashes, affecting several architectures.
> >
> > [   11.664666] BUG: unable to handle page fault for address: 000000000002d3db
> > [   11.667043]  lock_acquire+0xcb/0x330
> > [   11.667163]  _raw_spin_lock+0x2b/0x40
> > [   11.667255]  add_timer_on+0x92/0x150
> > [   11.667302]  try_to_generate_entropy+0x256/0x280
> 
> Ok, this seems to be due to the issue discussed here
> 
>    https://lore.kernel.org/all/CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com/
> 
> and I think the fix is as per the appended patch (that particular
> crash is due to the random.c part, but I did the others that 'git
> grep' picked out too).
> 
> Can you run your test-runs on this patch?
> 
In process.

Guenter
