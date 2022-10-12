Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EB5FCEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJLW77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJLW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:58:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA2142CB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:58:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 67so326465pfz.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgFJeIB3oP3W9drjP/6hWGHdibrVVW8+X4R918qIIwk=;
        b=X70KMAJy64U1sXNf0RXVAKW4S2O5hXzQECXnQoyY5yG7kv/DjNxYhewiS7sjIUmlNz
         0vJMfNzYrtyuyRsDKSBePhLProotbrRTT9BRx4zIV52sybSWD63f9ZEEcpjbCi3V8fwC
         ppZTarKngWbtia4HnLYruIVaYfgwIkkJLjWg8gv1bSZx9C/8eQvNXUkmHR2uDuMHXXpY
         fJvqHvfNUjysC6a1Wu6Wn24GYc38FBSFz5qMp4VTDXnjvL8o40Eqv4fqcsL8Z6rCHXlK
         jor76a+/Wha2wsTcqz3h6USRRZiUw4Hz2fG6WPMhx+MVGvgoNojm8jQxdeNjBTGctjG5
         zC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgFJeIB3oP3W9drjP/6hWGHdibrVVW8+X4R918qIIwk=;
        b=HWLbNi6eJXmts+sS4qQuY4ujGiJ50zVRYd9jTBpXLvDL1v2AfQ6N4KveT5w5+Cr17J
         Y0HGsLxIfq2C6JQbepi/7qPfkGr0BtaeEIn+GXp5oH/2vXf7H8BnPdVQ3SOm9rAtkfHx
         2xtNIyPD0jgxqeGD1uCPRZsBePujlU1h4nmXbF5noRDvKbmN2esVUdk4UEHTsoLk3okD
         bL4t02cSVzRBK5BbD//8HfjRt58rjmP8Ah1QeyVTYIqVmh96Y9OwnG1wTLJT/W2ZAgWO
         EhK7QM1JtAsDpgnOuveEZvhMdnBFZOlSUi94Q6ZaOFW2tls5gYIjsvQpKQI0XjIHPQIc
         dP7A==
X-Gm-Message-State: ACrzQf2vR0MpdXoCw8ITwVtVBO1LmhYPEL9x+spR35Vm9HWVyGT5HKM3
        bQmjq4J9bJUpVFnJWat4GGBG8DKcQMnxB6fbkP940w==
X-Google-Smtp-Source: AMsMyM73mFIuAyRMpEQSPGuVITrQOYzUtmHsyTs/Aw33fg4i3Z2LR7QtB80pmVxD03dZ6LO9V/zUSjA6uKJuxVYt/hA=
X-Received: by 2002:a63:444f:0:b0:464:3985:3c92 with SMTP id
 t15-20020a63444f000000b0046439853c92mr10364342pgk.412.1665615534822; Wed, 12
 Oct 2022 15:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info> <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr> <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr> <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
 <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr> <c40786ab-8b3b-9b64-683f-dac589c024df@alu.unizg.hr>
 <e335e7cd-366f-7ced-2707-b6ef49cfe9eb@alu.unizg.hr>
In-Reply-To: <e335e7cd-366f-7ced-2707-b6ef49cfe9eb@alu.unizg.hr>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Wed, 12 Oct 2022 18:58:43 -0400
Message-ID: <CA+pv=HMSw6iG0y3GWsfjXvBG66K6tkGVzoSmx34_=fAof2fgXg@mail.gmail.com>
Subject: Re: BUG reproduced: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 2:05 AM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> However, I haven't yet done informing the Ubuntu developers.
>
> I will try to do that later today.

Please let me know once you do!

Thanks,
-srw
