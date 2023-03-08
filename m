Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEF6B131E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCHUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCHUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:33:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E37B0B96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:33:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso2205558wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678307626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0PHdmmNJusG1epclYYmQTbwEIZkKSzfpFAnnbOVxlE=;
        b=TtKOv1V1408AuF6vuwpZW+5EVawzPS6WnKGiHr0wVcJgvgDHDr5ajirvjs+VWAnwe+
         GCpAUXbvT3ooT+CzEoIbT6N+FobLF0B58By4KQCaGvW7mj9Au+Jy1UiT/+Lju75AU+3O
         l0NhQR6ownk8BvgolOKoC9isVmK/bQX5DT5DEDvlMxcCrZwOb1fhP1ckt7RShSO05+Ly
         lupVNHp55CwRIq3FCFYpfQ17ZNi5KyYW/DpLXDyb6etnXe032YMOTSAENYDoAF0v0GBb
         h5wMIvM394arqjAL0aE+mGNk6oWWAdK9Xy3dcxAYGAsMG9snoixqXOZWDEdC22YZ2yZ8
         59mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0PHdmmNJusG1epclYYmQTbwEIZkKSzfpFAnnbOVxlE=;
        b=68DlQ9HQ0MxACfdSOCbGsKeSpQiusOKmV4+uBBQ5jhGaRVOunoR3r9PydCZeN7Hn0v
         Xm8t99oJdH7iTRzNIo5jUtM3U2j/VFEkrkfY8g2xSChkjEmpK8GhaWPsatuiIJlHgWTq
         2WQ7KnMTBcrNVefvzNgWjoyMtXmmY1+yI6zTImLsl7gpTgZz2NK3qvB/iAM9JBUtpdnQ
         6QKZikrAl3xTQ4HsyH8tmgOvxsXMGiRxXL6bTaz7Djdqq1eOTwQt+rMKJ6yylfd/4/Gz
         2kjvf6V2WuvDAuN8JcrsDr9LuFI4mCSfX2KGhJ58ML5nEhqra9GGTs/rFATAbjqHxR5C
         Frvg==
X-Gm-Message-State: AO0yUKWPDInBXXTKhrN5pHdarjuiY+e16aUA8IFLZSvl2uC8ANFqFhZL
        Hz5X9Dsv1HanXd87MxsE7lUSRBjh6QY=
X-Google-Smtp-Source: AK7set9mrwvbQ2AGOynSLhzAtgvFkMELvmNU5TzXvABg6Hplqti24OdZXB3ofyF0E5kns3kzi3NV3A==
X-Received: by 2002:a05:600c:3b07:b0:3eb:2e2a:be82 with SMTP id m7-20020a05600c3b0700b003eb2e2abe82mr16380951wms.2.1678307625757;
        Wed, 08 Mar 2023 12:33:45 -0800 (PST)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003e2096da239sm512795wmq.7.2023.03.08.12.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 12:33:45 -0800 (PST)
Message-ID: <9578ec97-bca8-6335-4f84-9b6fa6c59522@gmail.com>
Date:   Wed, 8 Mar 2023 21:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: r8188eu: delete driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230308131934.380395-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 14:19, Greg Kroah-Hartman wrote:
> Now that the same hardware that the r8188eu driver supported is
> supported by the real wireless driver rtl8xxxu, the r8188eu driver can
> be deleted.
> 
> Also the rtl8xxxu driver supports way more devices, and is a fraction of
> the overall size, making this a much better overall solution.
> 
> Thanks to the r8188eu developers and maintainers and reviewers over the
> years, your work allowed Linux users to use their hardware before the
> real driver was implemented properly.
> 
> Reported-by: Hans de Goede<hdegoede@redhat.com>
> Cc: Martin Kaiser<martin@kaiser.cx>
> Cc: Larry Finger<Larry.Finger@lwfinger.net>
> Cc: Phillip Potter<phil@philpotter.co.uk>
> Cc: Pavel Skripkin<paskripkin@gmail.com>
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>


New driver rtl8xxxu is working fine for me.
r8188eu is gone.

Thanks for your support.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
