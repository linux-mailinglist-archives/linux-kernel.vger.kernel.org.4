Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315369EF52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBVHai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBVHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:30:36 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEA305C3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:30:35 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id cq23so26364278edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr7FCiWEdM1TF3cY0Q7dZMCHrQRPrAdzzUL/noGYiW4=;
        b=cHZxvhSbbWWJ9g3hAuWj2GvZ8z2vxFuMBR5+Ye8WDH9wLacEuHueQClBg1aUwpd8JR
         MB+giCVe0hA9eTJkqwwhp0mlLG4QI1ahWPMzihICaMHkDPf863gYha74Vmgcv8ZDEY5/
         VhNodu4TqTtjGvpxpEStpX2Sz6Q8CW5bJX2v+3RRceosAftHpzzF+N7Tgbdzedz+8aPV
         D8aEz6eK2GT/rfk8VnvVOEz5YjfKAQN9ajFY888/XEyU5cVO6JobIjT3VcEDA5oOck9/
         m3jkc6l2CQoCMdsR2lPDub9lSXAPZBkUCXuB1CgbSrhPyCJzJvbP8KEcajVhUAu2i1Fo
         PWzA==
X-Gm-Message-State: AO0yUKWpW+lJlfzDe1I4ifEcwCDFe/T8rBkcyFCQjm3olFIjDBKuHp71
        /LNTQ1kBAy98Gn2KzD8ueDLdceVyMYs=
X-Google-Smtp-Source: AK7set9uVxoyg9MRc9OWxnlfpTaxy1dwkkgY3svKdmpgO+/p/rKymLLo+cGFHV3qSvWs3i2nP6wxMw==
X-Received: by 2002:a17:907:9b06:b0:8b7:80d5:e7e5 with SMTP id kn6-20020a1709079b0600b008b780d5e7e5mr13274740ejc.17.1677051032049;
        Tue, 21 Feb 2023 23:30:32 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906b19300b008ddf3476c75sm1990271ejy.92.2023.02.21.23.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:30:31 -0800 (PST)
Message-ID: <4de4974d-9e61-4d63-8e23-d154aacb53f2@kernel.org>
Date:   Wed, 22 Feb 2023 08:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] tty: tty_ldisc: Remove the ret variable
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20230222202303.3195-1-zeming@nfschina.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230222202303.3195-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 23, 21:23, Li zeming wrote:
> The int variable ret does not receive the return value in this function.
> It should be removed and returned 0 directly.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

