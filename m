Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2243640288
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLBIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:53:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045A2408B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:53:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg10so3056884wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QxYMAsGyR71I9W5SUgkWB+llmDVJb8G0ACBqsOItD8w=;
        b=VWWxBi/mto+dbgJ+YJ7AJhtfhqMmQVeNQL9WGGDcTlx+jwxapK3HeUhhq7B3+P9MIH
         4KAQaQ1imzwCLnTirIDeQE/0DdAfCP9zK04WuufUJLgPb7GdmxrWdUn1ZWyWlbmMN686
         nN1vUTPTRicwxC5Fw5+o+PK2nfNtX5IYgaWQMiFL6mJsMrqJ5FA6Vwfn/CayGreDm71D
         8RqkEba2tBVAcx6JY/WWnoPuZ+SGts6CoBuLiH1giBZb/PbFI9TUeIb8m2+SJGzZUlck
         gwKGVu4/Kj+uK78efWmT+uVcZJRlAr6v5FJ8ZOyTTV+YjJ7Tuv3ZAmTEPVnuSdVOZ0m3
         T91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxYMAsGyR71I9W5SUgkWB+llmDVJb8G0ACBqsOItD8w=;
        b=gJAcVgnG3932CCCKZwWT121xwmIbiDpOal1noeRvJBMEIdgKttVyW579G7YdVzlZDs
         D6pkUJ9dxVvGjxS7g1j7PNWm9X3Vof+NyDl1Huf7hHvDZP1aD5fZTRaWPb1doFGS0A6q
         UKW/RIRMUeUPvFirmYSnqDI2GE6XkI4SqiGOWcgx/J9FZ/ByEmo7/rXhRH3vhI6faamG
         U4hnJIb3LPZbsHlz87yhfeMvmiV+OIuxZwaDGsLu1dn+K1O18qHho+c9tsDD0ZOCNqr0
         I9nD50BEfiJa4K3a+ZzaF8fyUOwg6bNiBr3AMUs6FuHAslLt8Ka1AJwGT6mqyjBkJm0R
         Holw==
X-Gm-Message-State: ANoB5pmExmvM5HXFjvTAWF8KLyRiQdxzJh832mL9Vez3TJS0FHqQbEEd
        IRW9WTLi+4VVlbzGmFb/37Lmng==
X-Google-Smtp-Source: AA0mqf76iCLnpL4DNa1AXxs+nKSmcg+KY3QSSiwfiuYE8GJ1CwfTAQCHoz170ug0rrN6daek6w1AmA==
X-Received: by 2002:a05:600c:4f01:b0:3cf:8952:2fd2 with SMTP id l1-20020a05600c4f0100b003cf89522fd2mr42157915wmq.9.1669971203363;
        Fri, 02 Dec 2022 00:53:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b003cfa81e2eb4sm8969203wmo.38.2022.12.02.00.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 00:53:22 -0800 (PST)
Message-ID: <f1eeffde-3940-4daa-0307-68ebc0485228@linaro.org>
Date:   Fri, 2 Dec 2022 09:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 3/7] soc: amlogic: meson-pwrc: Add NNA power domain for
 A311D
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
 <20221201103026.53234-4-tomeu.vizoso@collabora.com>
 <CAFBinCB1pZm0AaJq4_dsVksdp7RP+aTiXK04wFeLQ9vChbkYCQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCB1pZm0AaJq4_dsVksdp7RP+aTiXK04wFeLQ9vChbkYCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 23:43, Martin Blumenstingl wrote:
> On Thu, Dec 1, 2022 at 11:30 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>
>> Based on power initialization sequence in downstream driver.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
>> +       { G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
>> +       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
> I noticed the discussion in v1 of this series where Neil noted that
> you should change GENMASK(31, 0) to GENMASK(23, 0) (for
> G12A_HHI_NANOQ_MEM_PD_REG1).
> This is all a bit confusing because the S905D3 datasheet mentions that
> the HHI_NANOQ_MEM_PD_REG1 register uses the full 32 bits.
> I'm still fine with the way it is right now because the datasheets are
> not always perfect.

Yes they're different in G12B & SM1
Neil

> 
> 
> Best regards,
> Martin

