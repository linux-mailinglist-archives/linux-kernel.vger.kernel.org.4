Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560764A7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiLLSyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiLLSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:15 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC9BE1B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:54:13 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so4500964oti.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+X2VvmxEmhbisBsNqbVLqlaBd3BZLP80voBXOCXJT4=;
        b=aSRuZtCSUSKTj6XBhasti/EQQlejw0pnng3EjZYEn7To0xzL2vEX48603uRTe0QOiU
         r9jdSw0t30mV8fFbDnlnyD5xa1LNkwPh1WQp5EWZ+2FhbHfuxqeYGmJHWSRdnad0ObYN
         NzI8A2zpNXvBUGrib6qC/BtFJS5VFAUSDGD5FjjNNTzQpetoRqxY/g8szxWWOIQ8jANw
         s42T/GIxZTbtNnGizm2qutSWwRhKSuocwHwo1Vjwm/i0z3thtMcpD/C+EoyspVNVatQC
         rFSeuGwJHA5feFIR2Nq+ZhhfgBxqHCOGbwH88WeVxnQKMWOcerpwEblV4arNQK92lB/C
         I3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+X2VvmxEmhbisBsNqbVLqlaBd3BZLP80voBXOCXJT4=;
        b=V2d8XO0u5Y5hsA7bBTeS0Q9zspPuvbCCwuMVzTr1ZH+7I6FTI0w5ShRZ6DYQJmp6Um
         n52gVAGo3nxojS3QqinZHuPN5IkLwcwejfZjxwrQTJM6Jm12wFIL6q3RX81iTKcArGwG
         L5sxETIt+JIj3ZdDNW8wTC+IF1wovYusyj2fkzUIAg7JoOoDWYdFHigc4Pn7hcRqmZyQ
         a+k/u8+GFWLAC+D+D2/MzlvD/M9uhUnL95X/18sZeie4WpyWRzSZ5g3QVceSATw7WJzM
         Qjv6Nrq1UfAffMYNoF0PJxOZ77lyK/UyMVg9iw50MyKOqhP7Q2JzSUeB4rNgTzdCKdEo
         Duyg==
X-Gm-Message-State: ANoB5pmjJaBsULTT/Aovk+ucTOo5Zvq1LQD8vkOGa5EA4nb1VB5bUeGs
        ME8lK358Vk7YrjIG4c1W5CyorbC7Crg=
X-Google-Smtp-Source: AA0mqf6ATfK1ZfZdA7exnef3Z0qPhFpAEMhuF5ZRu00fLsruBJ1+MwP1VCP3wk7rT+Yf6AhOs29pUA==
X-Received: by 2002:a05:6830:26d0:b0:66e:a828:54ee with SMTP id m16-20020a05683026d000b0066ea82854eemr7877195otu.28.1670871251035;
        Mon, 12 Dec 2022 10:54:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1-20020a056830154100b006391adb6034sm231224otp.72.2022.12.12.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:54:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 12 Dec 2022 10:54:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.1
Message-ID: <20221212185409.GA3072139@roeck-us.net>
References: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 02:44:24PM -0800, Linus Torvalds wrote:
[ ... ]
> 
> Anyway,  I think I've harped on that enough, let's just enjoy this
> release and the upcoming festivities. As can be seen from the shortlog
> below, last week really was very quiet, and it's mainly a few
> last-minute fixes mostly dominated by drivers (networking in
> particular, but there's some media, HID and GPU noise in there too).
> 

No new regressions.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0

Guenter
