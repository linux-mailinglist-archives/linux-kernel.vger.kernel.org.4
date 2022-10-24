Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989C60AD35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiJXOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiJXOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:14:35 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52D63A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:54:16 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c8so5702110qvn.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP0GRqUpor24cOH1tEBiHC87nojq4fSpk3LI5p6Ckp4=;
        b=XRBGZO5MVF7CI4UHFcrvg13XdwBso/2nmo2YDZ0bH8OKQiAlCnuKJ1VZoAxAlbe7vJ
         CAYuyde23VO9NkEY1ya6fzkz+7YHvguJtz5ssVwJ9jH227mS1GdAtPuJYLQLhxcL0ULx
         kEbBVHMdRY4i3vRhTbUs0VWPNaACPKBDC4GCmv7VR4CteBaHMRsAFmBn/xx6km4G/fm5
         ocJBKWOxYTHGr6ACnUeDjREzJgADKB8gyXMSHNb/FNj+ImYg30hzOfRXxxiaXVVfx0/W
         RASu/BGO4XV0u/9yHpr977xZ+FhtLAeiHgHDT7n7RZDcYXX2aTBSYMd4O89lgP7pDqrd
         N1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP0GRqUpor24cOH1tEBiHC87nojq4fSpk3LI5p6Ckp4=;
        b=2p7qsybEY9RJ5cEGJNVLk8zAIN8PgdTAc8cZ1ioxkBvUJFhnqH6PHMd1k5UjvOCASL
         qZjRok8xwCVquVcrO8U23yn8RYhvvfiAWqUPXU8zt3peSF4D052apY+jmuHWWyCMP0Kw
         3b9FnCAsiGaU+xOfi5okleFtLNDBkNP2htpDvhgE8fA3+mKCSX/tShxOp+mJzB2vfGRo
         1pVThpe8d1HNdOk9Z7xnADjuAvPTfIjHVDKI0yPiDjQgo7MqvRirV1Xkt9z1MLdSU/PU
         ir+Rio9htWmDzgk6c5KhHdhvj044F80WKHVVBwzOjzusxhn0L3KWeFDPrfZfTE5jmTgE
         7i4A==
X-Gm-Message-State: ACrzQf2i9LAPUMd88X+otTW3BFGlj3to9A9SNEWCLAfndirDJQ6Xstcl
        USHfvOM6cRsTXzu0jVujg5nsQg==
X-Google-Smtp-Source: AMsMyM5pEMM2Bi7JxVx/uhw3V7bjtZquIqMyyGVb4C9x3lpPLi0aOW91eLJDguaYAYZqOYirlfbN/g==
X-Received: by 2002:a0c:ca11:0:b0:4bb:5f97:2d29 with SMTP id c17-20020a0cca11000000b004bb5f972d29mr8985693qvk.63.1666615926276;
        Mon, 24 Oct 2022 05:52:06 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id x7-20020ac85387000000b0039cc944ebdasm12828196qtp.54.2022.10.24.05.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:52:05 -0700 (PDT)
Message-ID: <713fb339-ba0d-0513-facd-cb79d1c68584@linaro.org>
Date:   Mon, 24 Oct 2022 08:52:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 19/21] spi: remove s3c24xx driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-19-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-19-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform was removed,s o there are no remaining users
> for its spi driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

