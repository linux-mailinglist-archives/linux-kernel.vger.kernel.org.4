Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92325621A49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKHRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiKHRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:19:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43C2634
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:19:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk15so21973463wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFf56fXHcN5swktvY+aK0n5WX8IgDNtgChpp7Zn/EMw=;
        b=LZMzqP8OhgAalFg41YjuQEN/hi06EX3F9dRAqZ1u3mSJ6u9jA4wLIE2oOZ6seXnmku
         7mzHOseABc++gWBA7DUwRzIRI68A6mgdGZuJQKzcd1mSUtTEs5rijiRX3pQTybsIpgFa
         NUyD82SmKVrKzRm/Jp1PcD7faXGL4EjoRQnFnRl8aw3qkdjsk3xwm1F882I4LKGT47GR
         hNQUTChfpzwtJiJ+dol3gjpiZg1m0intCt4g9IHnKLLkSXkdJK0kxANh72y9VsEOeXIA
         8k9HvWs+Sa3djYZpo+LilxIt+32lXTRshYrrEGO3zWtD4n4a5x2P9Y3ri4mam0UrTyYt
         jreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFf56fXHcN5swktvY+aK0n5WX8IgDNtgChpp7Zn/EMw=;
        b=W4v9W2A9e0MjQT05xUh27W1f583abJUG3TT7fUugPf9ZRRp79u7C/NvYQhA1iZ0KnZ
         AGmJf86QfzeNxNjcAP4bT7N/qwnGDIWjqnEmUJ3Jmm697c991XXZFdAu0UBaa2jFnldh
         6kJaWUdHwXMxiyzwEWxI+XuMqBvpsiBzzj3mwW1qoiWpZKT0ikukNBQyuheZmY07EX6m
         mknl/48+uA4dphBCKUObbOBb7HwzcvEh6Y1SJVaBZkCeJ1j1lWeUZzLs46ltZvUnAC2R
         HW5Wnzc+a7tq6J0AklkUH9gRWnBo1uOzHcs0Gefzn2dis8DD9s6mYrWi6fyx5+NAWcoy
         ed7w==
X-Gm-Message-State: ACrzQf3EGaZgCRb/qC4fsk+G1HJKM0FWa5BRkYMN/VRw0nQ/TNW+rTye
        nyVl81d/Pwm/UgNf2B4OODrtoX+uM1Sd7f1b21IcSAsL/25yhMHA
X-Google-Smtp-Source: AMsMyM7Jkn0gWL5gs0/xf6bPZllJz9C5ZuFICxylcZ1ZTH0lc04ZzghM3sDGh/E7Ux3hMxpwSdZCpit2TagIefqQTm0=
X-Received: by 2002:adf:f88b:0:b0:236:7134:d4ec with SMTP id
 u11-20020adff88b000000b002367134d4ecmr34382445wrp.669.1667927945417; Tue, 08
 Nov 2022 09:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20221004143901.130935-1-mpfj@newflow.co.uk>
In-Reply-To: <20221004143901.130935-1-mpfj@newflow.co.uk>
From:   Mark Jackson <mpfj@newflow.co.uk>
Date:   Tue, 8 Nov 2022 17:18:54 +0000
Message-ID: <CAAbcLfiCoa=-20cydPG9=42G9npaeBOCRXPPPTwkNFU-3yGoCg@mail.gmail.com>
Subject: Re: [PATCH] Update Nanobone
To:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        tony@atomide.com, mpfj@newflow.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on this patch ?
Did it ever get through ?
Do I need to re-submit for some reason ?

Regards
Mark J.
