Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8596C7E65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCXNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:03:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15EC651
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:03:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ix20so1759154plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679663014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emrmxMtoMVVno/g63jGPflCdBnxzHhl5cMb4H3cHM2w=;
        b=JXGTUVqzjPSHsFlThpUxwK/Ih0v4ZTKOShw//J8J3dAwB+pjiJbjfEndJFjN+TbI0l
         HIn3myHtgl/xyx2Ld8/ABN8pf2DfH6JnrzX6xX7B/6xsVIa2sTmTmYgM13cLWmr0oMF2
         vvB5LZXyWToaRliO3e0ruD3gNJkYyFPJIMF5r86XKLD2JkTdr5u4oSH2gIvu3xwI74RZ
         ck9qxSOTf1PrMWfLviRQiUQXVns/ocKi+W0AXTxcfVbpTQ0HV8AAk+xYg67kQ7vtnIY6
         h9xrsA8mDe3eW/dNccG9jx04G6ZFy/y88cj3mNnlQ3xBZatpHg8zUCc0Bo4zYZyWd31X
         vLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679663014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emrmxMtoMVVno/g63jGPflCdBnxzHhl5cMb4H3cHM2w=;
        b=Nj0q8chCzLa9PmNrhtedF5LLHsCCRmDY/7y4qeP/AV/dAcmSNedKOHWUBklMkLUXiF
         44eDgySZAnsp9NUQCw/vq5beFWzq0M17BEFlTnIrZtmDl4bZxtHqkB4oVW3gsrIYDYxL
         FuJhsKI78PDcqsBc9xv/uRW3OxUfMnBZ56Dmxa/OMCqNAGG8ML49NnmgS7LSzHFJoP8m
         XdrgcKOmBSkQN/WpbbFsXu+WndAcGVox36zCz+ePDAWVXOOfFrDO5fpBBkBdfPuiQEzW
         65zXhDj+ffywp0IWqOLxjfY4l9CdwWdakmmCf+X3hoJJy+k4tEEsXZcqjE250y+ddnlM
         J3xg==
X-Gm-Message-State: AAQBX9dIOBzuLf2nd6H1Qig54z9MjLVMReTqyL6zHN1ipfLxoS1gyYFn
        JGosXi3057WNyZsPuV2N3E1dIEzrJxM=
X-Google-Smtp-Source: AKy350YY/SPP1LClkfMG2QLhM3Vl1h/nN2AdwkSTjrLjOuDkSMWN0N/HGdtgKDNDc8c1Zz6JHVpP7Q==
X-Received: by 2002:a17:903:4303:b0:19e:b2ed:6fee with SMTP id jz3-20020a170903430300b0019eb2ed6feemr2253790plb.58.1679663013998;
        Fri, 24 Mar 2023 06:03:33 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902700300b001a19438336esm14173990plk.67.2023.03.24.06.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 06:03:33 -0700 (PDT)
Message-ID: <609742f5-c280-53fc-3b7d-84a5abf3459e@gmail.com>
Date:   Fri, 24 Mar 2023 06:03:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] scripts/gdb: timerlist: fix rb_node access and python
 errors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org
References: <20220727141443.133094-1-aouledameur@baylibre.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220727141443.133094-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad, Jan,

On 7/27/2022 7:14 AM, Amjad Ouled-Ameur wrote:
> This patchset fixes use of lx-timerlist with kgdb.
> 
> It has been tested on Amlogic libretech-cc s905X and works fine [0]
> 
> [0]: https://pastebin.com/RAhQYh6L

Was right about to submit similar fixes. The whole series is:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Jan, it would appear there were earlier attempts at fixing timerlist.py, 
however as of 6.3-rc3, none of those patches have been merged, can you 
take them? Thanks!
-- 
Florian
