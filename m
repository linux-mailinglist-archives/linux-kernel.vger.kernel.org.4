Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC060B3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJXRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiJXRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:22:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E945EAC80
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:56:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z14so3429559wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDFVlliW39efbrrCfZ0/dVE6VRPxMJV1lpZ22oSXw1Q=;
        b=gywg8JYD19QTRdYRsy8drpE7vSO8yy/36lpRnuxkFu+ClpA10E037kcqUiQYJjFbiz
         5kEEMdyiDZ0nzXSmF601NAska1FCHBm+M2bJ07Px28iijJMeuJsCr3dEUjtw7RzklIUT
         OctU94h3QRV7cmrCv0suHnAjsIZGQKtBh+GodGwcYCHs+cinOIXcVe3PxE+3iwbrr3Z7
         ZerB/s92MD1SlTM2R/mgN0RhrTr88Cldc6UQktNAL7PAcoBtzLxkmE0VyeFQuIkGYc+1
         maXswxHpFRO56PnNPJvuoIdrW+V1X0kRBgnf5ulVZrBByq3i3crgPZtjIuwszXzuBHJp
         CZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDFVlliW39efbrrCfZ0/dVE6VRPxMJV1lpZ22oSXw1Q=;
        b=dMjq0pdo3gY5bnY6nyZtVmrgtzksPEWfPIKm0r+RYEPBerilzqSz9ZRcTAGOPJRRhB
         PiTvFms9E+TNJXPMGfxfUiTlMTWrhZuEiOZ9v2zXMW35bYNDrEp8PG1lwh+sRj3o/pFx
         OT53S7FBWl5bkq/lFnryvrKpGz4nTidOrddDVQOGJ9d6b+asRlGRiUHdr004hbNdLdxo
         /+5uTXNXV6d2BtmErbEJ/4q6AmDLcRQ9cWXkRexFTdJEPzDzTQcp/7s999sy8E/ZfUYD
         Ro6ah3OslG07UuiCysifjz/3cj1Uya9MYI4Z007v8jDTNakggzql5p8NO/i5hKKL/VRa
         1AGg==
X-Gm-Message-State: ACrzQf2xfjZ6nPkyQ9WnGWSoZdPuHXbbrHj98y6zfChMgEJzqTcqeLrL
        35GYtKBu5SBVGPlDV7rMJuTOIhAnn3PbXw==
X-Google-Smtp-Source: AMsMyM5xJixdAMTXWidAfcHrl0NUtmIch9q35qRxZsQhviqwf65C6oQ8lT68qkPJYpYXmIlpxpXzfQ==
X-Received: by 2002:adf:f2c1:0:b0:231:3f1c:2fb with SMTP id d1-20020adff2c1000000b002313f1c02fbmr21387665wrp.602.1666626032394;
        Mon, 24 Oct 2022 08:40:32 -0700 (PDT)
Received: from [10.35.6.130] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6d45000000b0022e57e66824sm31526618wri.99.2022.10.24.08.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 08:40:31 -0700 (PDT)
Message-ID: <60e69701-c0dd-1c22-5956-775a7b0dac4b@sifive.com>
Date:   Mon, 24 Oct 2022 16:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 00/10] Designware PWM driver updates for OF
Content-Language: en-GB
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 09:39, Jarkko Nikula wrote:
> Hi
> 
> On 10/20/22 18:16, Ben Dooks wrote:
>> This is an updated version of the Designware PWM driver updates
>> for OF support, which now splits the driver into PCI and OF parts
>> as well as tries to sort out the review comments.
>>
>> Hopefully this can now be queued for the next kernel version.
>>
>> v6:
>>   - fix removal ordering of DWC_PERIOD_NS
> 
> I did a quick test on our HW and PWM was counting as before.
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Ok, great to hear, thank you.

I guess I should sort out putting a v7 out this week with all
the updated comments.
