Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AF6B152D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCHWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCHWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:36:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10765135
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:36:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so71793312edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678314964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzDf4+4sG/Th13nL0Nk+rTjw3K6s3TCf1TZrS78TwVk=;
        b=TKYPU3ZRnNzZcIrmpbFdrOELb3qHa4Mmd5uxjy5Awp0yXXXvcwOqQf7P4LJRy6hkvm
         356DfYqVabeiY6tfx37KrcRPlwazFBeFFB9Tfnx+EGs0XQr2QklDBe15O3uLbQEeDkAH
         JmAbzE6hh+DjMf80YADuMmOQEB+qci9YSSMdgo0AIOXb5GeAeoAx5z2V/5hfke90LAtN
         4HhBVyxVkWoEeVADYD4Ktn11RWIcpUdql83m+s3RlPW/v5kQ1tvko9IhKGHHdQcs5GRS
         tH19/5tiBmopZIsq2eiEuXXp73MF6ezkSL6HYF1SHmoSgQJ7NYIHmtkVH/LK0IG3dBK1
         7Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678314964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzDf4+4sG/Th13nL0Nk+rTjw3K6s3TCf1TZrS78TwVk=;
        b=fNcnWHUO/SD/AVgDf8B4cM/xvHsmsFUEBDPJJ4sOhr37FfN0QKGGTQsMKeWFzTI7/+
         MSIFT2uyQ0IaTUU4ag+rXgGn+5MUteJfOJyKL+zaEITO3jy1xUQqMlOiaXJvw+KZoJ0F
         H28hO1uasLXEYgl/DQ0uFY2Y5bsujwccMxrtHkYJeJHNsn0mefWQYIIBOQFUh+8TuujR
         A79JkVFTljiGwBqOf5LrptIj+aNsokry0NsnPnKFDiaA413B3l0GTuNnA7uSMdIed+im
         xSBlgeYIOuwK3t6vQaztdnRRJORW7qnEQ1f7UmAEbVtc0WpDoNy1Y6V0LwtiQON7+FsP
         2pTw==
X-Gm-Message-State: AO0yUKVeq2KTVyFC3MCLW4HFZbvE7Tp7Ofgx13SNplh1SqAKk7mP5/G1
        +7Be86A2B2dVISP7CxhQPbc=
X-Google-Smtp-Source: AK7set/8kMxm9e7Ww76G9dAgDiHgWhS+pXwdbv/atF+1sdRH7bnZyj6ZiiACFFD6T7xTA7L5lspPLA==
X-Received: by 2002:a17:907:7748:b0:8e8:6b69:2093 with SMTP id kx8-20020a170907774800b008e86b692093mr22362157ejc.25.1678314963862;
        Wed, 08 Mar 2023 14:36:03 -0800 (PST)
Received: from [192.168.0.151] (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id q1-20020a50c341000000b004bbb691a334sm8862127edb.2.2023.03.08.14.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:36:03 -0800 (PST)
Message-ID: <9e4d7f04-3114-8240-341b-1fff5ae69b0b@gmail.com>
Date:   Wed, 8 Mar 2023 23:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
From:   Michael Straube <straube.linux@gmail.com>
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
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Martin Kaiser <martin@kaiser.cx>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

The rtl8xxxu driver works well for me.

Acked-by: Michael Straube <straube.linux@gmail.com>

