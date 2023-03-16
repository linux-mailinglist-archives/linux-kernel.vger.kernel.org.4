Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCC6BC21E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjCPAHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjCPAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:07:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE195D275
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:06:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t129so65212iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678925205; x=1681517205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuNcsmeN42kok9LgHZFVGZJj/7uQxuqfGp6Z52a3bGI=;
        b=BCrSMMfdCRl3jnf8M5puijH0r2rvUCkkX8qGRuDWPnUsVs7AljqcFIA3cVWeMeW+hz
         SzukmM1nxXG+dkxzeopJEE/0BZq26vUj3+zYJstGh5k3D9YedOVta7Si+FEwDK9cjIWV
         yLAfhl08ssqUUfK47rMUxWT+FS/PWw90YWAB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925205; x=1681517205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuNcsmeN42kok9LgHZFVGZJj/7uQxuqfGp6Z52a3bGI=;
        b=WQX6uMMhXBvcDzlTGEGFopCSqswKrw8iT6FwsUeIPmes3sDJbeM/ThYKWLIf+qckO1
         LFftW4v7eAeOuw2LcS+QYtKerm9jfs/3YlsBgbHUr6a3YAs+cWlZAnViryRt99lIYI0Q
         L3wV8MwfrK+kNYlnwfuRrNAujkH1TfZtn0SSDqNs+PqVEcQRNQcaNum69EgmPbMXpGdI
         d7AS7vp7Ul+N9D4eDs+8l/LRgyD80Bf9fVM6CvP0XLxjzlTiW+JNNCudCaEBAEJfYfm+
         9H9OS3D4jBdGqf34PvZm1gH5CZ58yJSuGjfrej2Rx+hl4oqOvJ3zpCX0+c2ju1wP8K4r
         dTQg==
X-Gm-Message-State: AO0yUKW+Rj4l/ZeChHDIuhbJGjpyVBg/KVZiTolfurXlJLGQcdQE2Dtm
        cGQh3wfktwJa+5N5oaRkZxSD1BVCYsgTpLYxM5Ksbg==
X-Google-Smtp-Source: AK7set+VHYorBec5NQIz/Z98L4+M3QD9SMbOd4Y1fOLag9wgwkyzmSLtiTXhR1rYZ/4BvieJtrm+0A==
X-Received: by 2002:a5e:a70d:0:b0:752:dcbc:9f12 with SMTP id b13-20020a5ea70d000000b00752dcbc9f12mr704002iod.2.1678925205625;
        Wed, 15 Mar 2023 17:06:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f20-20020a5d8154000000b00734262159a1sm2078986ioo.31.2023.03.15.17.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:06:45 -0700 (PDT)
Message-ID: <474229d5-a7b2-81e9-1ac9-05bb86eaf0b9@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 18:06:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: make me a reviewer of USB/IP
Content-Language: en-US
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <ZBIBCRiFGSqQcOon@Sun>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZBIBCRiFGSqQcOon@Sun>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 11:31, Hongren (Zenithal) Zheng wrote:
> I think I am familiar enough with USB/IP and is adequate as a reviewer.
> 
> Every time there is some patch/bug, I wish I can get pinged
> and I will feedback on that.
> 
> I had some contributions to USBIP and some support for it.
> 
> Contribution:
> Commit 17af79321 ("docs: usbip: Fix major fields and
>      descriptions in protocol")
> Commit b737eecd4 ("usbip: tools: add options and examples
>      in man page related to device mode")
> Commit a58977b2f ("usbip: tools: add usage of device mode in
>      usbip_list.c")
> 
> Support:
> Commit 8f36b3b4e1 ("usbip: add USBIP_URB_* URB transfer flags")
> Bug report: https://lore.kernel.org/lkml/ZBHxfUX60EyCMw5l@Sun/
> 
> I also have implemented a userspace usbip server in
> https://github.com/canokeys/canokey-usbip
> and maintain a list of usbip implementations
> https://github.com/usbip/implementations
> 

Thank you for volunteering to be a reviewer for usb/ip driver
and usbip tool.

> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a3b14ec33830..45f4fd92126b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21645,6 +21645,7 @@ USB OVER IP DRIVER
>   M:	Valentina Manea <valentina.manea.m@gmail.com>
>   M:	Shuah Khan <shuah@kernel.org>
>   M:	Shuah Khan <skhan@linuxfoundation.org>
> +R:	Hongren Zheng <i@zenithal.me>
>   L:	linux-usb@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/usb/usbip_protocol.rst

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

