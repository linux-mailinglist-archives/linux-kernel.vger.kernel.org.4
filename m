Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C165A5D3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiLaQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:49:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C260D0;
        Sat, 31 Dec 2022 08:49:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge16so21717112pjb.5;
        Sat, 31 Dec 2022 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYINHIBvIPZ94wkN7bsE5kBpRC6xDTJKXTDJN6EwWSY=;
        b=i0IzArBut4mD0lhTFSAM1Ynf1jFhKRWz2I6Sx5gxV7E7HeCl3mLw2dW/Aogp2JwO0R
         L+HamDLZNhHpDgVTW0sjNpmKGTuAxsKBHuFd4ZK5UjMNhsEMEUlOwI8BjtRTWE+uopty
         A/0xF61G/iGRC16q+P/wcuvigq4T+6OdE2ztr1i/8qNGdMgT1/jcFFuq7ur6aaZAhCfK
         3AVNcGjoyZfTz19p86sHVzRBrvGibWmVXCYzXBlGNzu6vkTMu5SeIU4Bbj99Fx3QaphH
         A/97k6/jV91CbXcM51WQ3OJCGYowXCZF5a4BIlKqzihSVIP3AyBECYWO7UO1xxysSmIE
         MwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYINHIBvIPZ94wkN7bsE5kBpRC6xDTJKXTDJN6EwWSY=;
        b=bd3vIBdRRry/kmr2wgqpHzNJZ+B2jCWJH28lALnK/rXpTJmByPJxATHY3PBW36ouRC
         qirYconEgvG7tijslyUirpJVujziLtPfg8kcrYBDat6rvGiH+EOvfQRTz7iKJQFh8ZL4
         sqvWL008QQ5qZce+JAD3ywv1+b6yFPhW1rTVuYnIzRhPplEMeHBkGdpgmZC6pVuvi96Z
         SRyASh7Zd5BjV3vg/xmBSH4g+UtAQVnrv1KfGKj25CqrK1qjtzpEyOLDouVAfc2lk5+l
         aG69UVzLNGa0lWCwJTrbXpbvOCaGoC/VRQgLvIKe02ATlRr599UYqfgdqg6iV0nM9IjQ
         jeag==
X-Gm-Message-State: AFqh2kpOFwQrVzRJbHFxR5Pd6Yib8D50QqvA3vLZgeY+alzYyjiRlJq9
        YaLmjduV1ockzTPOqIB3Ciw=
X-Google-Smtp-Source: AMrXdXvjc3VeLMtvKzd//XfM5kf8MJjdzawdUxJY4jxOIcJUojdKvm+5gzALvXeM7Vbl3c2f5WjIQw==
X-Received: by 2002:a17:902:bd01:b0:191:309a:826e with SMTP id p1-20020a170902bd0100b00191309a826emr39157292pls.15.1672505373841;
        Sat, 31 Dec 2022 08:49:33 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:8541:7679:d795:745a? ([2600:8802:b00:4a48:8541:7679:d795:745a])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b00187022627d7sm17004956plb.36.2022.12.31.08.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 08:49:32 -0800 (PST)
Message-ID: <8aadec85-f941-430e-22c0-03012fb538d2@gmail.com>
Date:   Sat, 31 Dec 2022 08:49:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] watchdog: bcm7038: Use devm_clk_get_enabled() helper
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <9c055911e9f557b7239000c8e6cfa0cc393a19e9.1672474203.git.christophe.jaillet@wanadoo.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <9c055911e9f557b7239000c8e6cfa0cc393a19e9.1672474203.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/2022 12:10 AM, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
