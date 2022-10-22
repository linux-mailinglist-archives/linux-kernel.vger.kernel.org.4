Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE1608475
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJVFQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVFQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:16:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F902A8A6C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:16:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b12so13008335edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yFsO2k9GJqskGirXTy30+Rr4ObgZBCuJO3gxd2Y2+g=;
        b=hSn9Ud8MZRAcuu/0OXR4Ra0GC+vLv9JzfjMakBRJrHH9stUfS664LvveE40eqxDc1B
         YoV/m2gqS3KlfwqA3buJnJ0cIbld0d8fjksV2YwNCHuggS18BV/Z5+fuHPVpW7/mP63r
         0lN41601nLdfUS8V4pdqK7j8t02wfhyrmeAq+bPll0DmZKXyt8TXnPagAJ+h6vhiVenK
         T4JnuT1SsH4nJ9lUxDQrBtXWBTDDreDaeuoSX5OL5KnyyHYZcEfUV7CvzSEB0M/xc6g1
         uVBkwHDamo+2w3oXbYfSWo8MCc8YVURW+ZNmMPgvKptqHiUm/xyY1IHZSzwMvAiaz1bY
         Ev/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yFsO2k9GJqskGirXTy30+Rr4ObgZBCuJO3gxd2Y2+g=;
        b=KJEPkGRLbsN/zoL9DuH4cGMtCBzujCJa13lrqZ9iLV/YhP5f5RR/qgW5KCzjfbA5ve
         G6bsBIGK/tKgRRy4ouc5GYc7WZG9uS160k1MRA5St9zb1iPnlOUcOoJW2cnxlMb5tmVA
         2xANLvBONJ8P7QlHaaOl7Rgg6/iViVThcjsGLDp7MyI0CMLrxCXZggwoFJXMIYg0/zgy
         8j6bgWtb2f9tycgKXjXiGYv0lSofFLWQgxZ6UjfBvqDBXFaYEiR+VBAbKiEJJ5QhFKOB
         GopxMX8s293QpKK5mtWNBZumcA3r2v1344DjSCk2/UXM2OT8Twx/ERxPSnzRO2VmZ2US
         Dfbg==
X-Gm-Message-State: ACrzQf2Y2s//0Rw+sE3uJjrbqQO85Nu8pldlPOOkjLVueB63Q7VAL8/7
        jqYhCQuXZvP0CibyJyJbT4JU/Ua6aFQ=
X-Google-Smtp-Source: AMsMyM6Kdb3U8Sua5e/k8W7PleyvXrI55p8LwSSe3xrXFb0we5Sb/RXS9n/go/MwJdScEdzHmWHouw==
X-Received: by 2002:a05:6402:e87:b0:456:c93c:5361 with SMTP id h7-20020a0564020e8700b00456c93c5361mr20203693eda.88.1666415786147;
        Fri, 21 Oct 2022 22:16:26 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a47:f906:12eb:e934:9c2e? (p200300c78f3e6a47f90612ebe9349c2e.dip0.t-ipconnect.de. [2003:c7:8f3e:6a47:f906:12eb:e934:9c2e])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090655cc00b0078d3e54aca1sm12327092ejp.75.2022.10.21.22.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 22:16:25 -0700 (PDT)
Message-ID: <ee426ce3-b336-1b9d-32a1-55e184028f8a@gmail.com>
Date:   Sat, 22 Oct 2022 07:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Staging: rtl8192e: fixed multiple coding style issues
Content-Language: en-US
To:     Aaron Lawrence <t4rmin@zohomail.com>, linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <be839b05d799ff8e62fc2f79e6f0aaec81a8cd19.camel@zohomail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <be839b05d799ff8e62fc2f79e6f0aaec81a8cd19.camel@zohomail.com>
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

On 10/22/22 07:05, Aaron Lawrence wrote:

Hi,

please do not attach patches to the email. Make the email the patch.

Have a look at the examples:
https://lore.kernel.org/linux-staging/

 > Subject: [PATCH] Staging: rtl8192e: fixed multiple coding style issues
 >
 > Fixed multiple coding style issues on multiple files
 > according to the checkpatchscript.

Please do one type of a change at a time and not multiple changes. Look 
for examples in the above link or in the kernel.
Thanks

Bye Philipp


