Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760B56176C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKCGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:35:38 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B9FCFD;
        Wed,  2 Nov 2022 23:35:37 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v1so1163253wrt.11;
        Wed, 02 Nov 2022 23:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2peYu2N8EVJUBKH1QNpFpwqJVNBRNcFb/SQ8ZpQUXqw=;
        b=cwE0wmJ/pdWSJoVfgeO6VOVccmZfRQt7c8zYyRQqnNiYwOddiYk42Bv42GZVxAC1Hi
         9q0Ilb+EMYoTdLktT1rGoI2PVSxB4cr5jij9hjZL2f4oRjExoFCzGGJ1E61UFfBEz7bG
         En4+U9g0a+RDGaUx04uMOo2ty7Pgw5GDkKlmI6ZAkI0Tb4+ly4zwo+JF33X3Rl6eDwt9
         C3HPpNwJBJV6ipcp6wtOuwL6lwdDqkUopziVNlCipsaH0gqYPpIsbHaHi6YAbnH9skKJ
         /QhhIGerWiXCMC8nnndhe3Z6/S29RdDkbjOV2yXpWG7J+X5UT9dWvdaPhlyUx9lkRwEg
         CTxA==
X-Gm-Message-State: ACrzQf2/LZvk578Y53sAcLjiD0rlvO9NxPcQ2xJZP0m3J1gvhgMKcLdF
        1BLk4g8snw5cYW7e8tehGUDX8C0iKT0=
X-Google-Smtp-Source: AMsMyM5cH8p3jHGZx1sSmiuv3q/MbmqEELP2Y0Kn23ND0mek7T0463NakmLD9KmiA+heVun2C3vI7g==
X-Received: by 2002:adf:e610:0:b0:236:737f:8e5d with SMTP id p16-20020adfe610000000b00236737f8e5dmr17813010wrm.316.1667457335536;
        Wed, 02 Nov 2022 23:35:35 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003c71358a42dsm4952657wmq.18.2022.11.02.23.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 23:35:35 -0700 (PDT)
Message-ID: <f4255e8e-a5ac-c507-4c07-ce087cdc8042@kernel.org>
Date:   Thu, 3 Nov 2022 07:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] docs/driver-api/miscellaneous: Remove kernel-doc of
 serial_core.c
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4e54c76a-138a-07e0-985a-dd83cb622208@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <4e54c76a-138a-07e0-985a-dd83cb622208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 11. 22, 12:48, Akira Yokosawa wrote:
> Since merge of tty-6.0-rc1, "make htmldocs" with Sphinx >=3.1 emits
> a bunch of warnings indicating duplicate kernel-doc comments from
> drivers/tty/serial/serial_core.c.
> 
> This is due to the kernel-doc directive for serial_core.c in
> serial/drivers.rst added in the merge. It conflicts with an existing
> kernel-doc directive in miscellaneous.rst.
> 
> Remove the latter directive and resolve the duplicates.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks.

> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 607ca0f742b7 ("Merge tag 'tty-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")
> Cc: stable@vger.kernel.org # 6.0
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-- 
js
suse labs

