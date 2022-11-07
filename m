Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E912F61EACE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKGGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:09:51 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85488BF58
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:09:50 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3691e040abaso94954057b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81OwnGwvJnQYmOVDKkykoPFn7wFRcskQuKrp/5MV0cA=;
        b=FgDvnNYcbah826ClKQr0dNF/O5K1NK1Y3ToNyjx/BeE43Jl8E9VCxI+JUUAWeEYCru
         lWFCS8amfGMSfKYGtnrMQKm3gBbT9Pgqk/iiJ3nI/mnEi+bkeZ5yI7Do+xZs2MjYWEW4
         2rNz8j05el5kRHXZbBt6Y8WhbolzI4wKTnDtBL0soWL1qDgzVakhyDY1xTpuWp2v4ZJs
         DpP8UdN6IIF0ZYhklfvSQVqyFHZI3Bk83t27Uw1vFqSbBnFKznP3z/SthAL+R2scEkqG
         OxijTFjDCHogAJpiajima2cnUvC7V9sdA+eIGHluqYFmXxq0IcWZBN/kOqHzW3B0KTg/
         eR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81OwnGwvJnQYmOVDKkykoPFn7wFRcskQuKrp/5MV0cA=;
        b=VopX4DEYIlsL6JloBMEbihA0nnBERVMnF/7O1/ArMvDVCQme0635lUIwN5eRNv0WGJ
         2XCoaZHzqWe2R89XJT5dpsMBTBh3icCyy94uy0u9fG0uV7/FhY1iJ38R5qDuKz9cRvwn
         f4czeiO/jXTVzGBnOtnBDAvUwcW7b/xfRWxabvIx3a6aZHACt61xRe4K5OA6sMsfV1zE
         Poqk6tFR+HZX3asbkXkvIQbGhHPMLXXPf391S0TdJ1FcRXBQ3briVipt68kEf6INK/EB
         +fELb60D0gWmOnDVetYD5+D+pak4ByNRmb+gF/kDvzGnXkVq8o943IpGbZ2VZUMWtTkA
         NBAw==
X-Gm-Message-State: ACrzQf3sBGpl6LUs6kzu9ILUSi3cpd4BXi/cfSwh73mxwZtgSbaW1Lj+
        3s5vzo3pkjn1PUkkwPdnMvHF1q/igjOksO1c5tdYvy2hng0=
X-Google-Smtp-Source: AMsMyM4sWzWZdeNRBWGTamabtDqOb9fla3MuSyVyGsHdbdMJ63mrzdP8vG82YIQEBYmbUXDdqMLpZWvKVROpO5RrCLk=
X-Received: by 2002:a81:1243:0:b0:36f:ced7:9826 with SMTP id
 64-20020a811243000000b0036fced79826mr46158117yws.507.1667801389557; Sun, 06
 Nov 2022 22:09:49 -0800 (PST)
MIME-Version: 1.0
References: <Y2h7PgIkraOI1zVC@xpf.sh.intel.com>
In-Reply-To: <Y2h7PgIkraOI1zVC@xpf.sh.intel.com>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Mon, 7 Nov 2022 08:09:39 +0200
Message-ID: <CAHsH6Gt92EH7eC5MyL23G7ySYk4OyNoC9U=0Y7vXbbqVyyZ7SQ@mail.gmail.com>
Subject: Re: [syzkaller] There is "lwtunnel_valid_encap_type" WARNING in
 6.1-rc3 mainline kernel
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
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

Hi,

On Mon, Nov 7, 2022 at 5:27 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> Hi Birger and net expert,
>
> Greeting!
>
> There is "lwtunnel_valid_encap_type" WARNING in 6.1-rc3 mainline kernel in syzkaller test in guest:

<snip>

>
> Bisect and found the first bad commit is 2c2493b9da9166478fe072e3054f8a5741dadb02.
> "xfrm: lwtunnel: add lwtunnel support for xfrm interfaces in collect_md mode"
> And revert this commit, this issue could not be reproduced.
>
> All bisect and test dmesg log, kconfig, repro.c and repro binary are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221103_152117_lwtunnel_valid_encap_type
>
> Kconfig, repro.c are in attached.
>
> If you fix this issue, thanks to add the Reported tag.
>
> Resend the email due to previous large attachment.

Thanks for the report.

A fix was submitted to the IPsec tree:
https://lore.kernel.org/netdev/Y0UwqMZQ6n+G%2F%2FaD@shredder/

Thanks,
Eyal.
