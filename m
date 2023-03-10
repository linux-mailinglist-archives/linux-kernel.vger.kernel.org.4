Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71536B50B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCJTJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCJTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:09:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF4112A79
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:08:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a32so6387830ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678475331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aAsGyVx7NR5HR+xvNYcoRf6KVgVqRWKFB6FO2GAIJA=;
        b=Vtz7Nmt9yoM4cZJAd4Ac/Lz5W1ayYre4GZ4trac1YWMbDvMTha4GS/2mEqQi1XKwaa
         l4h8yDZu0Va957lrgp1DW9AxkF3IW27YWn9SlWst8zTIcF5Vqb3ndk39YlLZCJ3EaRfb
         QkoxjljEs+EHQOrmdJ1GEdz8AX9fg8FV9eIUJt4GeJS9sP3Eu+sm2D7wHYc14eqgq6EN
         /zfCa135Kj9lLWH8CkgLhdA3lv4/ey5CdOcAEw4q6y4Sc3UVgLehZh453fpGBdtg0QvU
         jG1oka/PXnsDYABLF6Mdmm3grLtFB6UbZt+7LST4mcGtZl/nOL00LnLskwDfWmzYIlVQ
         RKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aAsGyVx7NR5HR+xvNYcoRf6KVgVqRWKFB6FO2GAIJA=;
        b=tH7eimQgdFWjKQiPwMhphGgasJpMHD5wMMZF7AfjohU8F4k7ba1xdLsDDRHMpaSewv
         F847e+wHynpv7IGLD2qjj0LCRl02Wd0YsOX/MPFBKYOJYRa4HTviu5x2Z3Cf52X8VNVk
         iAt9GJGxiDNOCN4BGsAN5GGv7mqKfUWQG4WhedJHOE77GI37fJI71DdjxXNwDY06AymK
         i1mLZwWAmDygVS1Xg6CtST09uw7Mlb1R3LE9HhtJ51CH6t98gMlwZ54kJwOnHj7v7FDw
         J7l+cc8VSsz/O5GCGAdQaP7Ur5AL/AGxCg4OA7XGzECk5OGLcoqLn6F4tOQzn5BHaxNf
         R+/g==
X-Gm-Message-State: AO0yUKUwVDZ79nwUtFPz7ykoAWiMGYFYSQWsW4VKjKauBoY+LjZDfGVl
        nkcdw+tXjOyNehgdL982Dle3EVSYmDXhuw==
X-Google-Smtp-Source: AK7set9/3pAcpnd/tpmly8oKdr2X6da4QN4Rphc1UEr7Lsx9gJSNMfzLIyA8p2JVtxUv6qcGSzCLZQ==
X-Received: by 2002:a2e:720c:0:b0:293:4ba1:a78b with SMTP id n12-20020a2e720c000000b002934ba1a78bmr8007295ljc.25.1678475331101;
        Fri, 10 Mar 2023 11:08:51 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id bf37-20020a2eaa25000000b002946be8475esm95843ljb.135.2023.03.10.11.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 11:08:50 -0800 (PST)
Message-ID: <660ef0b7-fb09-5a72-57b1-3b57ddee924e@gmail.com>
Date:   Fri, 10 Mar 2023 22:08:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] staging: r8188eu: delete driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
From:   Pavel Skripkin <paskripkin@gmail.com>
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

Hi Greg,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> says:
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
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Martin Kaiser <martin@kaiser.cx>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

I guess, I am late to the party, but if it matters

Acked-by: Pavel Skripkin <paskripkin@gmail.com>




With regards,
Pavel Skripkin
