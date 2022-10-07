Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441E5F7B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJGQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJGQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:07:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99910C4FB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:07:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v186so5261757pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8FmTxgaXwSdGhTRV+E79UmyLRVrLrnpsXk1xAfMbZhs=;
        b=ijrTtkZEvAV/DG/OlzYS1vD9Ac5OwscfWucySwcHgSYrEu6FzIz+3PjfRlvYEQpEFV
         awfcXkjiINQYqy5LYgcBDWGini8pRGQV+9tDaiz602hPbutg5szeHCd6JSq43IE5fhJl
         HJPFHQaX2Z96bC7H+PRuQ+ZAVxPxPZCQ1lBL0Mi3ag7XQ10hZ29LncAhju/IGQ89STvx
         2m5xU6WtW40i43FmjHvRQ0d95Imiy5+9fSMfEaqxH2x0/0M7nyl4xcA/BwBC765hjOge
         s1tnTEjzaNhRDKaF8BpRukK2O/pMmJQCZ+VpZxTIf1Nf+v/uBK96oEw8WxkNDJXPbRB+
         xGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FmTxgaXwSdGhTRV+E79UmyLRVrLrnpsXk1xAfMbZhs=;
        b=M/w5uNofxSLc2x1zp3ExiDodCd5VlEMsft1LxcPyS3pzY+wYs3Dh2RyhAyrqL6QCug
         PG+s51M06/ZXNgh2szujTv3LSLTYakmS8Hw4KIiKmDLYKA6hhEPjiiEsKB7ICJstCvX1
         8OOvfZ+DXJK91ZkUBNFddcznmdpNa8APeBjmRnO55rv1eGHxMML6L1frg+X4Smsw+Xtd
         7p+MOjCzQ4lqNkZwJrROrHSSbVPrATF0s5adN+ets6hhHYC/CiSE5CyLuhQx3646RzC9
         YG039hyeXQRRp29xKGdub93yohFtnwz3br3145UXzEVBni20TVNPDmGIs7ZcTJEi6hl5
         BXyg==
X-Gm-Message-State: ACrzQf2icdfC4HaYgHE1h+aQyKEfrBla5J8BxoSTqoCle9XhvnsR0718
        MLFWu46Owopn19eyQtwaosmxPEFy75FPFxRiDv/twQft
X-Google-Smtp-Source: AMsMyM5479JNS80hxIfq8eEEs4XBn/jrmiYMqmzYEASh6Y7YDmaQUofqJ36edAj0QXWFUE/BCQ8KrWlpKusDRNJSU9c=
X-Received: by 2002:a62:198f:0:b0:554:f1c2:d487 with SMTP id
 137-20020a62198f000000b00554f1c2d487mr5600429pfz.30.1665158836722; Fri, 07
 Oct 2022 09:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
 <Y0BHYPat6L+FZFGQ@kroah.com>
In-Reply-To: <Y0BHYPat6L+FZFGQ@kroah.com>
From:   Carl Dasantas <dasantas2020@gmail.com>
Date:   Fri, 7 Oct 2022 12:07:05 -0400
Message-ID: <CANNVxH_fDjD2TU0ccW19hSKXwTL+m6kDPr6n7=36uipStgwzGA@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kaiwan.billimoria@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's moreso the fact that initial Rust support is being added. Yes I
know it's just initial support/NVMe drivers. The point is that it is a
major change to have another language support added. 6.0 to 6.1 is
clearly the cut off between no Rust at all and *intiail* Rust support.
I wasn't around back when C++ was added and ejected, but what was the
process then? An LTS that is very old prior to C++ > C++ added
*intiially* LTS made > C++ ejected? For those that might have been
hesitant on C++ they could have stayed on an LTS right before C++ was
added and then just skipped any potential issues and went right to the
next LTS after it was removed. Also, Rust support isn't the only major
change in 6.1, by the kernel.orgs own site (time permitting) an LTS is
made if major changes are present. In my opinion, which I am sure
means nothing to most of you but echoes a lot of others, if anything
as a gesture of goodwill towards the community an LTS should be made
prior to any Rust support being added aka 5.19 or 6.0.

Carl

On Fri, Oct 7, 2022 at 11:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 07, 2022 at 11:04:04AM -0400, Carl Dasantas wrote:
> > Please reconsidrer using 6.1 as the next LTS.
> >
> > 6.0 or 5.19 is much more fitting due to not having Rust support, a
> > major  change.
>
> That makes no sense at all given what Rust code will be in 6.1.  Did you
> look at it?  What specific functionality does it provide that is going
> to be a problem for ANY platform that Linux currently supports?
>
> greg k-h
