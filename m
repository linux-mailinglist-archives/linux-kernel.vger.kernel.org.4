Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510D260AF67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJXPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJXPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:48:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD4E8AAF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:40:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cr19so5748215qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQzXqrwIC0QwRKejNt8LVE2JYI0YL7ErsUlEluRisec=;
        b=VfrgqMHPLBsQhMyfqIb+txPYc98Nb3UJm4VvRFohYHEeVwpx5tEBEq/qBfp6gx8Oot
         qqNONpCEVA9Y6PrzVNsO2cPI6ZrdGi3zbCUh1qRXfqKP2iVfZD41ff+/vmbWKvqgjkY0
         EQD1PbksJVU2r1r1LaSqfAx+hNjRbpxbNlW37LpNKNDBaXX3PWq5lOiDnarzKr1pIiUE
         tPUO5uNmIfe527jUdxGKP4d7ckN7lInohm+x/98bvtgDhmWbTvMHzebP0K1gcFSynduB
         mhNDJ9hXNk/va2Neh8DUz32F1PN/3vPSVmgoBzSGtszc77n498r4iRw/HkVj2xnWNJ+N
         53zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQzXqrwIC0QwRKejNt8LVE2JYI0YL7ErsUlEluRisec=;
        b=wvmfm8UkF9ooj1blsnl+Rw5XRthg5eqN5Q1qlN6gAppndoSPk6Fbjty0C9dEye6Z6k
         VCku4E2dbEORkXuc5HLwSbP4H6iEUoGXcOTrOkWS+tUS7ejwepxugrnDGlQU/PMR2nmU
         H5MZgJ+EkJvcs2LnPS/Rp8GwX9112AjyFGLhAXIzeBZ9NjCDz4mIBlZIUuS42961WXjV
         TH+x5hmS8FDTQxGm1Cp/Ci6fWinEurfBy3paErg71xrEbzOKL5iMUqtP94I7bWf/Kk+q
         e06IHKy7GHJBXqCsPUIQVL8c342uJ/hu2d++K3k7A5I+7MQfcvWDm3BzJY84RuHryUmr
         DBXQ==
X-Gm-Message-State: ACrzQf34Oc6OhVT1wmQyElewUd50Hr9nzwcDePfLJ09nM/Xq65SPBaX0
        G6mrSEtKOvawGVCLy9syVgX6n2TYy2nuAw==
X-Google-Smtp-Source: AMsMyM5GJlopQSnchtqeAVaJKk0KkeZOI6RZXCaagWiqyRgE+7EghQIXyEkNJ8GlAlpcNHsw1akpBg==
X-Received: by 2002:a05:620a:1469:b0:6ee:d38a:7acc with SMTP id j9-20020a05620a146900b006eed38a7accmr22626676qkl.585.1666615202919;
        Mon, 24 Oct 2022 05:40:02 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm15325374qkb.82.2022.10.24.05.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:40:02 -0700 (PDT)
Message-ID: <be51d813-f36c-61ac-88d4-8a18cc6507f8@linaro.org>
Date:   Mon, 24 Oct 2022 08:40:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 14/21] dmaengine: remove s3c24xx driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-14-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-14-arnd@kernel.org>
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
> The s3c24xx platform was removed and this driver is no longer
> needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

