Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6060AD66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiJXOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiJXOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:19:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E49527E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:57:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h10so6409772qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/bSMV1G3NHftbbiOMlkZDGHMaXgJ5YWpzbaRA4vltk=;
        b=i4/IMfcBcqGglzqf/SOvPdhvpU7og45mEipaleqJvV0IxkNgUXpeN/5TqBeDm27w+B
         IQj2IgB/C6j4DCe1/0GlHqq10k8PL5xAGcJIWtEDJ+4DhQb0DpIUOnTArvyeyTG3btf2
         acgOXuAqVzKQ4nSgiYnWsg6RdIJA076s29z+kMFvxN/D9pNE9ifkIJtiX7Nfo+mPIGd3
         KS6lmrFs1I57KeLB4unHBQIPM0rrdTFTWNcnNPqnMJPMRbVZe/EMzCCGeTrEm2sHlibk
         JYibkdFzHQ598Ngik1IJ6MFW6sc5fncG6eeHbHIedrJmnqC9gM3ieMmr3EdmSBJsPFHF
         ozvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/bSMV1G3NHftbbiOMlkZDGHMaXgJ5YWpzbaRA4vltk=;
        b=uuLnNeRcyMLoJlv6Mu9lC9BPvNgVi3gdv/fi1P5uh/kBoLGJEh9L6/16nuDlN1TTda
         4qDb2IbR7zzE9KJO5rtpmokkGor+Wq81ldWczgBwKg0WBkspIHldiYil4a09uZZzRV6e
         kzkBwahm6kRLw4iZ+Hp4LsCBNX4CzTf8eBXTwqgrwFYbC3uB/GkK5b0Sf9vhwm3CR+WC
         9OD2wLNkrZ/TlsSYSBUkGa1iTJKBHeRhG5r0AL2o1SG3FNGcycQWzWfvPqVtDyytj8d3
         Q4j/+jnjqZXusIdsJ7TM5SH+ph2rwQcGYztnOCUYukLyLUZAuNcE1q6Kd1io75rOQZcC
         XF1Q==
X-Gm-Message-State: ACrzQf1jV3zn333nL5eOwoX11GYd9v/jyOa0VhGv2+irJtGwupS/IsZY
        GGDgcxy6Z7GmnoGR4CaKmkiZNkbDd2/XpA==
X-Google-Smtp-Source: AMsMyM7Vpky++x5MIrkJgLvsDPhgytK0mR3B44Tn1o/0g0QQxp6rwdOkC063mLEkuVJ38OVb52Zveg==
X-Received: by 2002:a0c:dd13:0:b0:4bb:664c:5aaa with SMTP id u19-20020a0cdd13000000b004bb664c5aaamr6607970qvk.121.1666614397292;
        Mon, 24 Oct 2022 05:26:37 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cf3592cc20sm14672531qkh.55.2022.10.24.05.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:26:36 -0700 (PDT)
Message-ID: <774a317d-959c-a40d-5855-d5094ee55c70@linaro.org>
Date:   Mon, 24 Oct 2022 08:26:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 03/21] ARM: s3c: remove most s3c64xx board support
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kwangwoo Lee <kwangwoo.lee@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Darius Augulis <augulis.darius@gmail.com>,
        Maurus Cuelenaere <mcuelenaere@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-3-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All traditional board files except for MACH_WLF_CRAGG_6410 were
> marked as unused, so remove them now.
> 
> Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Darius Augulis <augulis.darius@gmail.com>
> Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

