Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB5626036
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiKKRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiKKRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:15:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD493C6CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:14:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gw22so4938204pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VaPoeYE4uEi9Lmo7p9yRpFWEg7l1U2uEZTo6yD3TkRM=;
        b=lghTviNWaq+AkqOQRd5UDvTAxXSEy7IeXOvFlezCg3KZ4VkOUh3Wn9AWjzmSqeMVPI
         9tWkEXiZLMR/IpUAKuosI6h+Ykg6p/T0hfs0PxodRkgccD5nWAaZvyo86cvt7/d0Gqf/
         tIMkuvVR+AnDBd4cGDrAGKwgGqHZMSSabod95GAhwceSSImLnx0AmzMJadnWp/a05+gd
         waUrejkaon/AJK/xfGprBQm2ML5Wr+cj/vSiP2zlcUjjCKLUc0imwHpPy+7VKWxOPLOp
         x+9cTL2iXG4G8PCQsgxeZsXYBkQNyPmgO4SpOvK604wJLBKbv7aiscKSOL8FNzai3zzO
         4E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaPoeYE4uEi9Lmo7p9yRpFWEg7l1U2uEZTo6yD3TkRM=;
        b=jrVT/TrDKcFCl746ZP9rRB7xgkPnHChq2pXQBYDqQ/p7aEohKyxfnOoZYPvlBfhf+1
         DCGm6rZebuxIITJNbX5CCnPZHU6cpdvtVj6FXdEaSZaoZ40C4Nnzo/p7qFEatFX894Ej
         wZ5ZMOx8jCww/2MKU4T2FnR3xecVB3A9B1aFUcP67SjKEGQFHk4XXX0wMeAsAzJ2zDk9
         VKn6VwQM/swF6o4PHwk4gc1trEXT5cSdv8t+LlBwPfMy4rxBVCwRwFASCAV/jS127H+t
         KyUqj62tg4Vki9ZChzvHOdOeYwNHDImYLMBbQNUbM11Yeg+St4oEFA/actzKMnn3Ppqy
         RETw==
X-Gm-Message-State: ANoB5plIGv0hO0m1/Ql9ATDzRaqqrf3R56Q+UbvKH8lfFg56mNfLVxvy
        DJQnkz7CUPcS6xjKc/FGEbbp5+r6kBbG2UOfCTk=
X-Google-Smtp-Source: AA0mqf4ZJx4qqRa/BdK8gQWNZKMu3MCDEQvRH3e3ZoU4lsON/NGPkpKfE2JGmKB2rzeH5Pv45K1pMygdBG+Iw2g4SqY=
X-Received: by 2002:a17:902:6ac6:b0:186:a8c1:884f with SMTP id
 i6-20020a1709026ac600b00186a8c1884fmr3630644plt.25.1668186899027; Fri, 11 Nov
 2022 09:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20221108110715.227062-1-pedro.falcato@gmail.com>
 <202211101934.22CACD615@keescook> <CAKbZUD2r=zK91J4c6pyHQhDuqqMzmrx+BBgFF4Cso2jK+jjhHA@mail.gmail.com>
 <202211102214.D764FAE21@keescook>
In-Reply-To: <202211102214.D764FAE21@keescook>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 11 Nov 2022 17:14:47 +0000
Message-ID: <CAKbZUD0aGmrb=GtK_sQM54LtajKLfArkKjrV7f7BaVyKGhQwgw@mail.gmail.com>
Subject: Re: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, dalias@libc.org,
        ebiederm@xmission.com, sam@gentoo.org, viro@zeniv.linux.org.uk
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

On Fri, Nov 11, 2022 at 6:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 11, 2022 at 03:59:08AM +0000, Pedro Falcato wrote:
> > We could of course also just sort the program headers at load time,
> > but I assume that's unwanted overhead for most well behaved ELF
> > program headers :)
>
> Large refactoring of the ELF loader needs proper unit testing, and we're
> still a bit away from that existing. In the meantime, we'll need to make
> very very small changes to fix bugs. I've sent a minimal change which I
> think should fix the problem (now at v2 since right after sending it I
> realized I was trading one accidentally correct state for another in the
> v1):
> https://lore.kernel.org/linux-hardening/20221111061315.gonna.703-kees@kernel.org/
Got it. I understand you may be a bit nervous deploying this patch ATM.

What are we missing for ELF loader kunit testing? How can one help?

Note that my -v1 is still relatively safe and was already tested, you
could just apply that.

Thanks,
Pedro
