Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E06DC586
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJKGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDJKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:06:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742249EB;
        Mon, 10 Apr 2023 03:06:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z8so7575687lfb.12;
        Mon, 10 Apr 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681121162;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATMiUtX64qR0hwTrZDgb3RHiSTdBt+7AzkUE71TDEpA=;
        b=gct+lbvYlrtdNbqog/h6bLfpEnPaE247rt+vXA19R+KcjQa2tfFmZW17wCi4DI9Ti1
         hf5KHwycpKXUFQWY4eUvBpNGZq/47owrFhn85GJ9S6WEvuSsOJBYMo1UUfExhdZzPj0U
         tvOZsbj2dKAnPc5e8c57rBnL4OcmZ1vcUf1DJWX7vPWA1Mk3ItkqvapId+/mnH0FXCoU
         XeFC43Ej3DdXAc178xiG7+75caZijBIu3eBZni+DJ8PT7plHTJEwbJJ3eyhM1fEMSkkR
         7hxoV1avDx5u2igYk860iu5jn0l2Wx2U3/rYawuYr3rP7Wkqhj/HU0J22gWTf+JN6Mek
         /aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121162;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ATMiUtX64qR0hwTrZDgb3RHiSTdBt+7AzkUE71TDEpA=;
        b=2toNQxEzRkoGpKB0EI8Z2mtf2vpqSsdVNFdLpyGNRBdCBxmBGRT3ETUhKsF9+IBZoE
         6uGtt+iNQh0h3NxelgXKNKvyhWgQAoIhCNxlbDJaYN7JF5LZCR69rRrzSHMClBQ19Q0I
         JjIxxVGv7iJ9auKWENuYPykqC/AuSH22KGAF+cHt0B4iSL62K0iootElpXS1Qi9s5o/3
         kGKoEpPF94fkJnmUdEM14z1IZ6ItYmRN7DkxeBIHX9TzwAN9FpD4PX/E7HCcHDM0hquq
         9jzI1QojPMgOvmnDm7Qy37PvBVkjgGB7F8lwGBchE4U8jCZla6DFnf0CIPPbDeTjwgdB
         CEqw==
X-Gm-Message-State: AAQBX9fAiuyp9SBgAkPxEDcAgPiRk1OLJxmCO4aWWBt7+O2Rwb1UrbFq
        Pa+xxWGa2J9pAtn4GdZxjhFfELuztpU=
X-Google-Smtp-Source: AKy350YPnoDYffi3mvhIikGdK6c67KY+WRWZhkyE4MK7NQ5GJr5B2lpdmBmV9SkFOP/gf5oNz80bJg==
X-Received: by 2002:ac2:42c6:0:b0:4dd:cbf3:e981 with SMTP id n6-20020ac242c6000000b004ddcbf3e981mr2448219lfl.28.1681121162052;
        Mon, 10 Apr 2023 03:06:02 -0700 (PDT)
Received: from [192.168.1.13] (81-197-197-13.elisa-laajakaista.fi. [81.197.197.13])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512021100b00498f67cbfa9sm2045804lfo.22.2023.04.10.03.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 03:06:01 -0700 (PDT)
Message-ID: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
Date:   Mon, 10 Apr 2023 13:06:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Per-process flag set via prctl() to deny module loading?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd propose to add a per-process flag to irrevocably deny any loading of 
kernel modules for the process and its children. The flag could be set 
(but not unset) via prctl() and for unprivileged processes, only when 
NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, 
but unlike capabilities, there would be no issues with namespaces since 
the flag isn't namespaced.

The implementation should be very simple.

Preferably the flag, when configured, would be set by systemd, Firejail 
and maybe also container managers. The expectation would be that the 
permission to load modules would be retained only by udev and where SUID 
needs to be allowed (NoNewPrivileges unset).

-Topi
