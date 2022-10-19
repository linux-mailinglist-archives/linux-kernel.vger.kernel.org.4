Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C2604896
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiJSN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiJSN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:59:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88215D0AD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:40:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z8so11639295qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gv9Lun7DBLjVBiBoKvxeqsrOGopdssrX2I+H018sLA=;
        b=XFxfLPrkMQEzUOcytXFVxfaV49qN882jGAgvy6Ljj2iINc0XtbPaY/szItlpCDO9Bh
         t27Sc+Nt0P/eOMDCR6LHu/fI1nxqfD+wAWXWiKShZfrOpwlQ/d26+lc7M+YGCxYLKxsE
         KHkddQqpXKJp5SGn4yThoJ1mjpSvwLGmkMRRSE64FdqAhyILZHtTMpuRB09nnm3nsWE9
         Abp54P3+G6blsgeHar/3ZnZp7aNlcpa65UVntMpoUdblROmfVOcMBmlyCcQ6dz74fFpK
         8x1m2/IJkLF8jPPjwZFey8BQRXZ+IEq94hDn08OX5TIDDKlPfbZjIUIUB5Do+IhRUBbN
         eorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gv9Lun7DBLjVBiBoKvxeqsrOGopdssrX2I+H018sLA=;
        b=NuoSCVNI0GZALcn3Af3NTGd0DnxGsb7qbqtruXMBkzOCBOPFInDYVEswuqzChqoDzp
         CLZtzyjiIxMSszKElQfww6EDfwUUPSwHqzhY5m6UXuWYbRqvqqNrNirpxNHV2zS2tCJ3
         FGxPql0MExeXymSnfJpsXqHeESsz+X5upKZX1pLKmkduI3IcL0rD0ue6Z46wBTQA6ZvP
         Cphzxf3MwO5v5sK6gQdHh/wr49BhGsJJzfv9Btvabm/HX9bRsCYwAOtL+Qu7EiGLv+Yt
         Xgr3mqTgnkAjEJcVNLY2FrPfmABwwCIC4nrvOGF/b84c7Oq+bQrqtCW4iiWMBE6NIXQX
         FMBQ==
X-Gm-Message-State: ACrzQf0VaED5NmQx9h7VAyWxv/4vwcz2jY8OS8ctdeW73WKhqGyd9hcb
        rxMPQBa/Rg4+Xe7HAvi9HZj69A==
X-Google-Smtp-Source: AMsMyM4VRyoPZLX71PfSdRNp8s95WPKNI3+kFeu/wZbsYd7f2w7jyP+rFcNdmqt6A8lfUJlwX6L0eQ==
X-Received: by 2002:ac8:5792:0:b0:390:ee6e:5d1a with SMTP id v18-20020ac85792000000b00390ee6e5d1amr6189686qta.631.1666186726680;
        Wed, 19 Oct 2022 06:38:46 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b006ce0733caebsm5052065qkn.14.2022.10.19.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:38:46 -0700 (PDT)
Message-ID: <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
Date:   Wed, 19 Oct 2022 09:38:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display
 controller
Content-Language: en-US
To:     =?UTF-8?Q?K=c3=b6ry_Maincent?= <kory.maincent@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-4-kory.maincent@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019133208.319626-4-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 09:32, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Enable the PL110 DRM driver, used by the spear600.
> 
> CONFIG_I2C is dropped from the defconfig as it is selected by CONFIG_DRM.

I2C as a user-selectable option should stay. Don't remove such
(user-selectable) top-level options just because something else selected it.


Best regards,
Krzysztof

