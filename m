Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6770DEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjEWOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjEWOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:16:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B019D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:15:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso21772295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684851357; x=1687443357;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz6Gi3RTfxiYpLAjeGysY3hGl/xWM9p135m8/b2TXIE=;
        b=UEF/dplSE18i60LNJHY5+75WHRsq7a8bp9344rUJENC0RIZogsD+Dj7OCMgtZvVtCK
         BgRxCAeSOQmjl425KJ/8KXtN0qfbU2/25dZafKreLE6V7vuzckw039vx8ffmCrvDqRsd
         Na6xgqpcayH3RMjBdV6qDNFORd5vLqE3C221ag9TOI0uHS1WplMNmN3CcQ6Cuxup/bL7
         pYZhhwAl90l+vZibWpbLdm88U0sLJKQ2MGl749iuViYaDK36ORa5HkkAJGfeS2+CNZ8e
         DL79dSaryADhgw3SE+R2jmM2Cj9JrasYMbicgehclDprVu74sd0iq6OZCt78pjuntzMh
         jTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851357; x=1687443357;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kz6Gi3RTfxiYpLAjeGysY3hGl/xWM9p135m8/b2TXIE=;
        b=dX6F122r6K9l9HWkJWC338hp/FD9jW3eHACbE40m0Ts/ermzHcRBNQuH0531bVU44d
         rMvIQ5n6N21+HBWOyuI51f95HwprQun39NI6lRdbbPiFDW1PJMAmsJ7razphbjQuNGSQ
         ZA1ish7XK2rttC30NCQg4Pu0gfR2gH0L8b/nmaKd0uET0goMtjsFt8QmKISx0fDikPCz
         d0YbLt3JXpI6KdKLxhrGx8Thmu2MKFdPLKaM3iD/npCaZSmvoKPV5NB9YmN2Rr5CY7IG
         2dokpbaQ3sZkZk1vIin39ot5uZRQiDQLZgyEXUK+KZnOd5/uSOcRQTLwek6sDMbDQZY9
         ef/g==
X-Gm-Message-State: AC+VfDw5Z0awxTKBG60NwgqNumv5uEyqYaIyqph1dceGBhQ+N9IJoG0X
        j+oOTxCa3ZCp+hiIcldEirk=
X-Google-Smtp-Source: ACHHUZ5SvExwQliWsy9HlQCZ6K1qT4JGa8cKUENvdZEqfQj3cGZfMhE81Fc05n1Cp3bT1caUFO6SmA==
X-Received: by 2002:a05:600c:1c8b:b0:3f6:286:95d with SMTP id k11-20020a05600c1c8b00b003f60286095dmr5551614wms.18.1684851356571;
        Tue, 23 May 2023 07:15:56 -0700 (PDT)
Received: from [192.168.1.2] (host-95-237-135-26.retail.telecomitalia.it. [95.237.135.26])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c028300b003f43f82001asm15125467wmk.31.2023.05.23.07.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:15:56 -0700 (PDT)
Message-ID: <a2b2c557-c46e-6236-24a1-d605758e87f2@gmail.com>
Date:   Tue, 23 May 2023 16:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     akpm@linux-foundation.org
From:   Alessandro Astone <ales.astone@gmail.com>
Cc:     kamezawa.hiroyu@jp.fujitsu.com, hughd@google.com, jakub@redhat.com,
        ales.astone@gmail.com, linux-kernel@vger.kernel.org
Subject: Increasing the vm.max_map_count value
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing userspace requiring more than the default 65330 mappings,
specifically some Windows games running through wine. We are looking into
changing the default in Fedora, but the source code includes a scary comment
about the current value:

 > Default maximum number of active map areas, this limits the number of 
vmas
 > per mm struct. Users can overwrite this number by sysctl but there is a
 > problem.
 >
 > When a program's coredump is generated as ELF format, a section is 
created
 > per a vma. In ELF, the number of sections is represented in unsigned 
short.
 > This means the number of sections should be smaller than 65535 at 
coredump.
 > Because the kernel adds some informative sections to a image of 
program at
 > generating coredump, we need some margin. The number of extra sections is
 > 1-3 now and depends on arch. We use "5" as safe margin, here.

It seems that going over 16 bits would at least break ELF coredumps (for
programs actually requesting as many mappings).

Do you think it is otherwise safe to increase this value arbitrarily?

