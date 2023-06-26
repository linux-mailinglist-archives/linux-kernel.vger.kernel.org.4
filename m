Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5173E318
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFZPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFZPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:21:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44218E;
        Mon, 26 Jun 2023 08:21:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b73741a632so1531177a34.3;
        Mon, 26 Jun 2023 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687792888; x=1690384888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U7yKgaTyZsXh/LVlqDwX9ljmxURKTiccXbAlSGToiHo=;
        b=Tjt5O7M7jioM8v1Toy2pI9OfzlJeKKDu+DWcLnjVGtnbDktNv+pDXB85tYgfkIi8Yf
         clTgzs36PawH2B5mrkGWKfKzYPVKg1UAM3XCVpPHAgr4SFfsqRNQ2zbM7MDY98su4M3f
         sQxMD43E7nFYe72FJpLoGHrymFRxI5Sv/oUcDgMsso8CK54UI+iFTX6lfwfQrLCeOAIe
         +lYsMWsaHbWPSmZoVOT/+X3D96MNULl2sW8iOpFfLD/xZdLa3rICUtO+Ssbu+MLZJOce
         BhlWpuyGIoLwPFbe/0wJ533GCiBsSvx6058d82i8TLEOQOGxfE5Yw2JMMOC3Zf/81Mcj
         8Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792888; x=1690384888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7yKgaTyZsXh/LVlqDwX9ljmxURKTiccXbAlSGToiHo=;
        b=I+8KGYeSL5++m9iPn1xU4BpPzYvVWl56/st32UuDtGA6ivl6aNHdF7DOFgQpPxzfVn
         a8LDh2QfJiG43AhDp1ELLC7hFIzGjmo3UfM6FyhPIMDYUuUcYOIRZ7etzrrQRnLff663
         6YGGE+0Bdeylpd3xcnwkJ1I03G5B4Q15GqeA22Te+IONovBuaRaD1LscXI+e5t+QoUTm
         oejkQadllvU8ALAxOpoLRfJtKk6/5Evc6dWacQ7MtPJLFplH5W1fw+oEDMgO4AN9tEfU
         DrwmLLiHlWyR99z9opg840KhAbe3hVUav7r6DJipgmwfVohnIbRFxwFlp71PBGWEtk5v
         3Oww==
X-Gm-Message-State: AC+VfDysTYHFLy5fJAX2gJkf3XRfpH/0PQUDT6wFHR8TDMNArl4hZZas
        ECRQsxEyzWG5cFnsKngoATc=
X-Google-Smtp-Source: ACHHUZ5wqv+0eYYAwSPD6a/T5HCMJ1GPot627Zd3ObnUIycb4X9Nq4NcidPVG6HtiBEAV0Du0HSGCA==
X-Received: by 2002:a05:6830:1041:b0:6b7:1d92:3796 with SMTP id b1-20020a056830104100b006b71d923796mr9333165otp.22.1687792888297;
        Mon, 26 Jun 2023 08:21:28 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d6a8f000000b006b58e0ef27esm407894otq.39.2023.06.26.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:21:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
Date:   Mon, 26 Jun 2023 10:21:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Language: en-US
To:     Sardonimous <sardonimous@hotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 07:44, Sardonimous wrote:
> If I were to send you some test patches, could you create a kernel with them 
> applied?
> 
> Doubtful.

Sardonimous,

OK, that essentially eliminates  getting DMA to work. The cost of a MacBookPro7 
is too much for me to acquire one to debug that issue.

On my PowerBook G4, I also got the failure to connect, thus I should be able to 
fix that problem, but getting a new kernel with the fix onto your machine will 
not be easy.

Is it possible to ssh into your machine, or to use TeamViewer? Those questions 
do not need an answer now, but think about them.

Larry



