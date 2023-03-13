Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404A56B718E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCMIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjCMIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:50:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5B1EBF8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:48:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id da10so45543817edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678697301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYebPHbCYlq536pyuASzma+BqBMabPZtr85QVHAg0mw=;
        b=VXM/as5ptTza/LqdP2gaOKcPNo08rqm4nEiRDaKWwHfoT509x4KoPJLtN4PF/iTYk9
         BKYhyGraGRmoEJUciW3vM7zmCBszmds+7XI3FlzpL3V+thXWJzr/n/zd1SlA8NFi8yf8
         QbqXMG5nOA3DNMMgmfgruAf0r7gFG23uzf7C/uYC+qeZFFuFb1Z/zO9QMGAgg41BGEFc
         szau7z5set3PxBlW1rOL0nmqpeyVRezmOIOFgpn6rG79MGtEOIhFvL6k2qV7/3k6ZPJF
         UieVY5Z+jKXAkxkYfjNw6ACmuh4UXKk1C7mHeX33uNlKdWzVao4Xzz5LaiSj/Z0at3R1
         jrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYebPHbCYlq536pyuASzma+BqBMabPZtr85QVHAg0mw=;
        b=BZq8H8TN3WWtjqxQchmWIR0BEoyQupnQv5ErECklyCH7Pxz2ozEy2nC1bdKbe0FVCC
         HHi2sqN15VqV8rXlYHgOhcyPQyPNhhrdxeugvOU7ue+6NgsRlS2/by9J4DBbXHvv6ETc
         uc555Zx5umKZwMxnXg61D2xGbL8t9sZ95JyUql9YiB4jnj+iTlm2rG7PgK97izPTDTE/
         W+baxMCWtocshqKUY+SYpOf/EHEIiJuEm48l4zX+nDfBwD5Zz7j+YtGgJXHxz/LJASDO
         3V24TQ790ZlmSYCJq+V9HkoTrg/GCENv3zNxxxm6f24ylqQUxludO+eTni482Uqmgbl7
         k0Mg==
X-Gm-Message-State: AO0yUKUIsH2wgncgIvMjEpU39BJfPK2D9hxgxSKJLmQpTfF7j5P7NTQ2
        Ho+ZjxVR5sfKOERJRCvfXYx+xA==
X-Google-Smtp-Source: AK7set8xmjglP6bDYh4KU79tBTt8O9DsU3OK3wVlOF/nnQr0H7Vjqz9Z4Hbd8g2grWj3Wjra3O0ssQ==
X-Received: by 2002:a17:907:320a:b0:87a:ee05:f7b with SMTP id xg10-20020a170907320a00b0087aee050f7bmr39446997ejb.24.1678697301571;
        Mon, 13 Mar 2023 01:48:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b009245ba892d6sm2051886ejf.103.2023.03.13.01.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:48:21 -0700 (PDT)
Message-ID: <ea652d10-d910-40d8-9eae-39f2ba722466@linaro.org>
Date:   Mon, 13 Mar 2023 09:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] ARM: dts: imx6dl-yapp4: Change LED channel names
 according to dt-binding
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-3-michal.vokac@ysoft.com>
 <20230313082834.GO143566@dragon>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313082834.GO143566@dragon>
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

On 13/03/2023 09:28, Shawn Guo wrote:
> On Fri, Feb 10, 2023 at 04:48:51PM +0100, Michal Vokáč wrote:
>> The lp55xx LED controller binding was converted to schema and dtbs_check
>> now complains:
>>
>>   led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes
>>
>> Use correct names to fix that.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> It's been address as part of this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b0d1f2738899dbcc7a026d826373530019aa31b
> 

Which is mainline, so it raises the question on what old tree this was
based on...

Best regards,
Krzysztof

