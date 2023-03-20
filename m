Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA46C21AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCTThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCTThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:37:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C510F8;
        Mon, 20 Mar 2023 12:31:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so51152370edd.5;
        Mon, 20 Mar 2023 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679340669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGhymUT7Av6T4tSQafa+6oPxUxU1Po/EP5Zx4hiyIzk=;
        b=j9rjklNDxt1T9H4BSDdOtvbKi9dW157aq25t6svt9zrCnUXDdpbUNUXhhDMeJvLdpD
         1lRbj7UsVFv4HeXh0tE+3DMJKDq2cj2Up+he2RTamUQU0sP6z9SmAspXlqWlcsWIfGNl
         KLCfYkLlzwqMxrna/mNLlOC5yHL5XYxWYu3AIzRug35Uc2gdeSSjNfO2SGB7sT4fW3LF
         wyYiEaAb7RXzxIWCMGykh4kQOVs6fB21RO2Uyom/1p+NGiOqAtdHUS+tMqI1nDW47PNF
         Ncx3wkmMk0ul161dyCu4Xpwy2xomqWk5A84XvpjsZ9m+x5ksm8y+pGl4Td6Phu/PcIFP
         CY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGhymUT7Av6T4tSQafa+6oPxUxU1Po/EP5Zx4hiyIzk=;
        b=XtB/rvXG2RT/0znecdk9v+43JZisLjfXO62GAM5sLEBlELtniHg2uJeG6QfJSa4kTI
         6ZkM2V3ALJo2GNOy7fKU8TTT7REDjO0V3yQTNNGSSo7ZbH3eguNNJy7KEf6snHD1l90g
         r45l5sq6CQK/OwQZjYBHzS4JWyNYr5TK+CiC95bK677vwhzFHyN60tbjv7aystWLTbHS
         2aIYWGhBQkF+rDK6wuXyZZ2h82SHQuCo87sk1DwXmAYr4tqusbK0JLMf0mZpXOLOh6Px
         vWm1mWngg26mr74/UMarHdXnrjPJod+SSFvXI3IETjvW1+eCSDxZawyJqSKU7jTcXAqt
         cOCg==
X-Gm-Message-State: AO0yUKWLHKwbzxVZLK4MUAC8LmimIP+4NHMI20KRwQwBe50LpfCaVwjh
        tTRDkfVHyzQPVS901/wggnE=
X-Google-Smtp-Source: AK7set9+EjCitae2DZXL+LRhp/xxIq5Qd10kjPXzYaFzMZV4KM/xIra8+4q7BiTvF75fgM7Yt/6luw==
X-Received: by 2002:a17:906:7f99:b0:931:59f:d42 with SMTP id f25-20020a1709067f9900b00931059f0d42mr185418ejr.29.1679340669025;
        Mon, 20 Mar 2023 12:31:09 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id cd2-20020a170906b34200b0092c8da1e5ecsm4803191ejb.21.2023.03.20.12.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:31:08 -0700 (PDT)
Message-ID: <5428d01b-ec02-df42-3272-a4dcfea2efd9@gmail.com>
Date:   Mon, 20 Mar 2023 21:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: r8188eu: delete driver
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
 <660ef0b7-fb09-5a72-57b1-3b57ddee924e@gmail.com> <ZAxZCJn7AN/yWSRh@equinox>
 <ZAxx1kYjVKFRE3kz@kroah.com>
 <CAFLxGvwKaXviF=5OTtm+pPHwdtXTX6A2e_aRTUraOsxKOL3-4A@mail.gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CAFLxGvwKaXviF=5OTtm+pPHwdtXTX6A2e_aRTUraOsxKOL3-4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 10:06, Richard Weinberger wrote:
> On Sat, Mar 11, 2023 at 1:25 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>>>> Also the rtl8xxxu driver supports way more devices, and is a fraction of
>>>>> the overall size, making this a much better overall solution.
>>>>>
>>>>> Thanks to the r8188eu developers and maintainers and reviewers over the
>>>>> years, your work allowed Linux users to use their hardware before the
>>>>> real driver was implemented properly.
> 
> Both r8188eu and rtl8188eu had support for access point mode but
> rtl8xxxu has none AFAICT.
> Is there something in the pipes to have AP mode supported?

Indeed, rtl8xxxu only supports station mode. I have been thinking about
adding support for AP mode at some point.
