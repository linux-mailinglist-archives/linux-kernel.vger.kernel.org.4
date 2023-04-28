Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA46F1D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjD1RmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjD1RmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:42:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC90468F;
        Fri, 28 Apr 2023 10:42:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74fb8677a36so5000085a.0;
        Fri, 28 Apr 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682703729; x=1685295729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l67YUxlMnkaGZuUZgq5z9SXdJ72p+MYe/kIUPDNC8kw=;
        b=LxBha8esb4yLQ3KSIaTSo/VFi71Eq8OXn8kG2J5zj9/vGd97lRmpReQffJt0GuLqqf
         3HaeoA7KPbZ+kTztSXCZly0L3UFPd/sVmDGeTLKa5JtUuggXRfg6/DGgcQZL1z5l1XST
         IYkMnjptJR38zpWwnJ29WMFGDhrfB8Tu8MNqaj4072BkLggixKHZWkRu4Ac+Q6Q/vUfK
         cnpOajSPvW3xljKZ92DqCbYjrY0BO3AbbFiLMlvAag1joRInjnhL3aHsVg3kKJsV+gf7
         tEOAwy/EaoXjdfiFglnHm4MyLP2sD0YGCE39vS2KvSxWccSEHkUWSbuBFWCFdKCLwGX/
         BoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703729; x=1685295729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l67YUxlMnkaGZuUZgq5z9SXdJ72p+MYe/kIUPDNC8kw=;
        b=Bce2wzLa1bhKR2yNHuW+DuLY2ar6ohvnia8/WRV16vzsbRnoyUaRWIRSBRllg2P7ay
         AVBAGZ36JDWmzYmIklAsLikRtQyIsgfcdeZ1LDGd2FtpzuJ7ttix0jeM0Z4C9QC+AIZY
         dYn2QZFwVc25GpmZRVG1JOjgWLT9Km39cFsFO8N4YPIUsiiTWW5TDXY3U+KniMAYYeEz
         OeLuSNarKPaIgAQNlsfWuYUJFRWSaClvDdltV8DtnSvwEVuZv2q/hBI/6mSovgbrDihr
         NE3ELorqiG3bl3cM/kGf94ezm7YY6UEyFXioWmHV75lDf4Te7gB+9fcDHefapEu+zamx
         nGLw==
X-Gm-Message-State: AC+VfDz0K2N2VgZ5YNooNZjf7JtXCXuGNPw81dQLn3FFMmNtlEFSyWkc
        LAMgpDs7qEfvCs3vXcs9eWs=
X-Google-Smtp-Source: ACHHUZ48PpjpFeDxPGXE7wMzlMMSfCw3wFAMa6sjQnCJlfFPWJA5URu23pVIApjal8WsPtep/sp3Zg==
X-Received: by 2002:ac8:5cd1:0:b0:3ba:2203:6c92 with SMTP id s17-20020ac85cd1000000b003ba22036c92mr11314980qta.10.1682703728873;
        Fri, 28 Apr 2023 10:42:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cf23-20020a05622a401700b003ef58044a4bsm6871236qtb.34.2023.04.28.10.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:42:07 -0700 (PDT)
Message-ID: <a9bbc2e2-faf4-7107-7496-66ba08e1f5b0@gmail.com>
Date:   Fri, 28 Apr 2023 10:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] serial: 8250_bcm7271: balance clk_enable calls
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20230427181916.2983697-1-opendmb@gmail.com>
 <20230427181916.2983697-2-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230427181916.2983697-2-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 11:19, Doug Berger wrote:
> The sw_baud clock must be disabled when the device driver is not
> connected to the device. This now occurs when probe fails and
> upon remove.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Reported-by: XuDong Liu <m202071377@hust.edu.cn>
> Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

