Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC946F1D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjD1Rmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346448AbjD1Rmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:42:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCF2117;
        Fri, 28 Apr 2023 10:42:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74da25049e0so7351185a.0;
        Fri, 28 Apr 2023 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682703754; x=1685295754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8a/sNfuFHeTYkRfUGTacjmyO5fiNH1n34jQYCPOYeU=;
        b=aBICx4HdFdftyd2cexB1TEC8uihhQ3ERDYPz+dGMLWf3uULFsApE9sqTSHD24wZrkx
         nN8KNtao4llaap8cFT8cb6UlWd2FYtjdq8GQrgBGEYaGL2QBHPW8WZoshuLFDdfaLph+
         W7VdwJP37JAA5X8PRwfsAD6WF7+TrGRXQ73x5icKcUKbqCW5akeWnAYWVzX+K1ZCo/kU
         okmUb2vtLoO92KgtVbu/B5Nk0YwgI4sQwyqOPk3IQA09kEzEkJBhE6QkWfUvg9jldbA3
         wV9+/PLRbnSZiByElCJyewdsNzIPGjcE/dEITj9XFoP2y39SuQ+ZEHryjJdlrFNieXsB
         Mpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703754; x=1685295754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8a/sNfuFHeTYkRfUGTacjmyO5fiNH1n34jQYCPOYeU=;
        b=CQhf5KxEM7nqpL8p+NJvSOhO6GAfImuq3+LTael44wZ6tuk3SkIFpEl1fauxkAJpkg
         uAjZI+CCObuS/hn+qjUy0ZYMxBzQhybUTlAL9kyfKU3JZu0CMHmity9TWj5GNug7m/vf
         VkpJyTDQNQK1aBDhR14qCGes0zgNFNVOjU2nmMV6ZUAXpRdJQTSe9Yzito+BisRkOXgs
         hmILhYJjWBqGwCXsUEXmQL+pBUlPzkqBJsws+VD09O/99RyfD0w00OeKaZxI6rJyckJE
         D7qRqSHyA/YasxoKzDIptR2hkLIRJ1F/fyBDdqTbv76nP/zI975769Oqng+d2aIbBulr
         EZWw==
X-Gm-Message-State: AC+VfDwdpWhFyHSCZFOElYClNka97IccIBqYKVoE7Ybls/6aZwG4gfZe
        iw6DvN+fRsXkkkX14ecQAv8=
X-Google-Smtp-Source: ACHHUZ7uQcxZstv8zxd3b27p5++ZgSbpdvgsWfyTzumlxCX3o6MgfclI5TFsoiJYExuaNqAlYxCEbw==
X-Received: by 2002:a05:622a:15c3:b0:3e3:9117:66e8 with SMTP id d3-20020a05622a15c300b003e3911766e8mr10555313qty.35.1682703753810;
        Fri, 28 Apr 2023 10:42:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g13-20020ac8774d000000b003eae8609f64sm7197806qtu.13.2023.04.28.10.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:42:33 -0700 (PDT)
Message-ID: <4befb5a4-4483-8e93-f402-4f54385610c4@gmail.com>
Date:   Fri, 28 Apr 2023 10:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
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
 <20230427181916.2983697-3-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230427181916.2983697-3-opendmb@gmail.com>
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
> Smatch reports:
> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
> 
> The issue is fixed by using a managed clock.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Reported-by: XuDong Liu <m202071377@hust.edu.cn>
> Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

