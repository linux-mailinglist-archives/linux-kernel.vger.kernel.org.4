Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73276219C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiKHQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:50:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234256572;
        Tue,  8 Nov 2022 08:50:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so21915266wrb.4;
        Tue, 08 Nov 2022 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzu8o9GG+rQV95TQcHmCItfsXISynxSuosbBYQlCmt8=;
        b=SocYvczHroVp4XHkMPIp7gSKsqd8xgbGlvXi6yx0ZnEsRTpc++d1845nkZ8B3q4ksI
         3JueTDqPardWkafPpYSdIC7Hv3HVTv1xXtizytQMqzC3aou+N2EurrBv/sg9cvKYm8+p
         YEBagF9gfNE6GWScWusf4ee0BwQKbSwF4orAOzvow0FPH/4Xe8G2RWxc3WYHFNZv2g5t
         dVbAmFLNH4/7ED4Jz2eww5MpqUrM8Pt30OA1qM0Qz0eKf9OC+Ruo6ehAB5PPQ4WP7JU7
         bjzKsPnT3gjs3hFQJIw4GrgAJf9+rycMeL/i5s2EjKuzbC9R6eVgXICy/QWwd7XG1GW7
         vMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzu8o9GG+rQV95TQcHmCItfsXISynxSuosbBYQlCmt8=;
        b=o+YKJUi42cPECJ5hUzkyaB2SJQ4rs/4vfJD7GFsJtDphHDuiQASeLpzzSecmnt+xVE
         jcpbGv+mmdaYK9DfkBr7Z1XKAhLg2lAcEjsFmJk2dH2qx55L3ytGHEXbuYwi4UAFoS5o
         1tYEqG+KmWa5Q2wkmAWAtG3+Hh5yePPXD6UGT3cxJR+fIKw/if/ZOMpLHAPVnBNmVgH/
         oGoL3g47UL4gk15t1YQ26xvVHFFoknNJDD7EHyRI1JLp9BXEKdCMRS2VGLosb4X4DeJj
         RYCW5F2KDPab2RsPrjXawO4GSAePksXgkeienWx6EtVvi3riHX0Wgs5jh4ic3Lk1dI7T
         dNsg==
X-Gm-Message-State: ACrzQf1QdVPjBwEXKeokhy2I361rMzaaGfPmi7uKRa3lPysMfnIN5HSV
        CY5Eap2d9TbS5jRzi/qdi+s=
X-Google-Smtp-Source: AMsMyM7PeyIbqxOVDwCt3DMl8SeeLMT1BoIW3zIboH7LXzL+d3ylaG9gT1A3k7WMgfTd+2c53cgLZQ==
X-Received: by 2002:a05:6000:a11:b0:236:7685:e7 with SMTP id co17-20020a0560000a1100b00236768500e7mr37639616wrb.359.1667926204501;
        Tue, 08 Nov 2022 08:50:04 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id k186-20020a1ca1c3000000b003cf4d99fd2asm11701116wme.6.2022.11.08.08.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:50:03 -0800 (PST)
Message-ID: <e6cb428b-bfa6-d7f0-e648-668dcd93eeb8@gmail.com>
Date:   Tue, 8 Nov 2022 17:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 01/13] arm64: dts: mediatek: mt6779: Remove syscon
 compatible from pin controller
To:     Linus Walleij <linus.walleij@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
 <20221028153505.23741-2-y.oudjana@protonmail.com>
 <CACRpkdYtJze2ziz+XBzNnsi_7r0jzujW0o=2P5Brgsi5QCZBuw@mail.gmail.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CACRpkdYtJze2ziz+XBzNnsi_7r0jzujW0o=2P5Brgsi5QCZBuw@mail.gmail.com>
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



On 08/11/2022 13:18, Linus Walleij wrote:
> On Fri, Oct 28, 2022 at 5:35 PM Yassine Oudjana
> <yassine.oudjana@gmail.com> wrote:
> 
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Remove syscon compatible string from pin controller to follow
>> DT bindings and pass checks. Adding the syscon compatible to
>> the DT bindings documentation instead causes a different check
>> error due to the syscon document specifying a maximum of 1 item
>> in the reg property, while this has 9. This pin controller has
>> never been, and will never be, used as a syscon, hence it is
>> safe to drop this compatible.
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

Applied, thanks.
