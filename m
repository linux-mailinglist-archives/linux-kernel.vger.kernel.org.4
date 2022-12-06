Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6778644219
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLFL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiLFL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:27:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063932AA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:27:32 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D9F2C4423E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670326050;
        bh=pcwj0xSndXh6KnkaS8bTnDF5WeQqaKV6mdZEo74JDfA=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=OCS+wM3QWnEVZ3mJDRTN6lzA6e3mmojAItdofh9D84YYkzVP3f2KQnKCZWAP8/Z4N
         yxvoy4x58Oj5iGYjyrvU+TqXivZoLsPHIfd6Qg+csCGFyFjWDu4cMkWp2uj9nwry0g
         cSPdYvJxJRf+57jVjf4sQBtQVM3Mt5bG1TbleFYGt5xQtUFSmOm1f9L3DhHuIsBqfj
         Gbqx0CN3PQ3XCiocaMeuOVEsa2P+2cVHEDmoC0P2vp/c/o0hQlh7IseApkvsQc82CJ
         3UVzTZB+vK/6byDM42BcBQw4f71u5I7npbzQ+mRoIdF399X6E4ynWd820Q4ObmxHpJ
         FqgbwKVfG+ePA==
Received: by mail-ej1-f71.google.com with SMTP id sa20-20020a1709076d1400b007bbe8699c2eso1346518ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 03:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcwj0xSndXh6KnkaS8bTnDF5WeQqaKV6mdZEo74JDfA=;
        b=yaRn4QxIIMxTJAm+3wormezSFhOyww2eAy9QVI+UtmIUYiHciJ8tEezjtRJvDG1/Ut
         Dxr6wl9Y69+HKK04QaXsJ95fLxuq42y/U1lqTfVcqo507QWppPb0GBBMGibRcuQQLH0u
         yf34UWSNn0XmHd9SJcIeV+KGEQJigl9ljcgMLMTYVNYZQjrSqBHhr9wNDqiVNaa55Vux
         oHjYzXYaUNIb0ufBcTM52fc6iiYB81x3yakdPOUcTnhrwos6xalWzXie1MGNwHkXmO5h
         mD4CrlE2FsZR2r4sWFDRRrWKO8kw2pZBYNvX6ZjS0VvNuJxMzBGVL/s9D3x0HMYpEQct
         PW2A==
X-Gm-Message-State: ANoB5pmMP1Cm26fK51lSka+MqFujCI7jOgkq0pzFEx1aD/gKT6i9pgTa
        PH0WnP67ojyrNvYR9UEB5VfSWuGVbBhCBTR6+5G7kC8IhO+CtKjzI+vf0Cj5UIQia7b6doSC6le
        WKZbmq6I2Yn4g5yNih5keuqXmuFTkPHvMlEwJSZovYQ==
X-Received: by 2002:a17:906:a209:b0:78e:ebf:2722 with SMTP id r9-20020a170906a20900b0078e0ebf2722mr69523361ejy.490.1670326049537;
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+7hJEm7RS//qwjZI2NkgcgeFfx5BgIMCo+8buUL8NMmMPAqOa0RpikMn7gYObBbSc3mEwnw==
X-Received: by 2002:a17:906:a209:b0:78e:ebf:2722 with SMTP id r9-20020a170906a20900b0078e0ebf2722mr69523351ejy.490.1670326049362;
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
Received: from [192.168.1.27] ([92.44.145.54])
        by smtp.gmail.com with ESMTPSA id r6-20020a508d86000000b004587f9d3ce8sm865452edh.56.2022.12.06.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:27:29 -0800 (PST)
Message-ID: <f0b260c1-a7c4-9e0e-5b29-a3c8a7570df1@canonical.com>
Date:   Tue, 6 Dec 2022 14:27:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
From:   Cengiz Can <cengiz.can@canonical.com>
Subject: Regarding 711f8c3fb3db "Bluetooth: L2CAP: Fix accepting connection
 request for invalid SPSM"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luiz Augusto,


I'm by no means a bluetooth expert so please bear with me if my
questions sound dumb or pointless.


I'm trying to backport commit 711f8c3fb3db ("Bluetooth: L2CAP: Fix
accepting connection request for invalid SPSM") to v4.15.y and older
stable kernels. (CVE-2022-42896)


According to the changes to `net/bluetooth/l2cap_core.c` there are two
functions that need patching:


* l2cap_le_connect_req
* l2cap_ecred_conn_req



Only the former exists in kernels <= v4.15.y. So I decided to skip

l2cap_ecred_conn_req for older kernels.


Do you think this would be enough to mitigate the issue?



If so, older kernels also lack definitions of L2CAP_CR_LE_BAD_PSM and

L2CAP_PSM_LE_DYN_END.


I see that L2CAP_CR_LE_BAD_PSM is basically the same as
L2CAP_CR_BAD_PSM so I used it to signify an error.


I think it should be enough for the sake of a backport.


What do you think?


Also the range boundary that is defined with L2CAP_PSM_LE_DYN_END is

non-existent in older kernels, and it's hard to decide which value to
use in this expression:

`if (!psm || __le16_to_cpu(psm) > L2CAP_PSM_LE_DYN_END) {`


I can easily define L2CAP_PSM_LE_DYN_END as 0x00FF and call it a day
but I had to ask if we are absolutely sure if that's the right value.


Because the comment block states that it's from the "credit based
connection request" ranges but l2cap_le_connect_req is not credit based.

Is it?

Thank you in advance.

Cengiz Can
