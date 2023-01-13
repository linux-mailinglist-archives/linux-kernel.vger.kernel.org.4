Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15C5668FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjAMIAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjAMH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112266B598
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so14711120wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s2mQx9yog+cpIOriUmStUlrkzbC/FMXSo06Ooi5txRk=;
        b=MYkoMrAO0rfyI3FYmI5avbqb2uKsWodoC2RzK+K1CbWnQXZrjakiUohK3z2GD/8DwC
         p8djuLAxlrepXC3O4Qc8wceRg8xj5uCfaoDb132wNAHCYViCOmcH4qLmOmjkNeqVhYWs
         4UIFHrKTubjVhDRWj8Bk3W0JmSFeUMay3Mr+ViHLH/Gl4NwZFwkVUqaYsI3/0hyLv7P1
         r46m1fdaboMgJwBsvJ68QFoPrS+8ID55r7tHfXsITe5aJa26vLcWy/DH7nepK6TmpikV
         1WWfqAmVJICrlib3fUa56xnCebytbDXLEG/Qywpxi6c+P8H7nsL3OGIhXxqY8EU3Qzuz
         uA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2mQx9yog+cpIOriUmStUlrkzbC/FMXSo06Ooi5txRk=;
        b=30nZ2OjmpNvPgxXUtKFA4jHrM8hm21suhjzygr0E8Ealn67omZfTgiJioRSpeFeCHz
         p+0wSmYppHHLh/AVNCa1k9cBhelMCnNKAXCF2VnM6v6gNoEJXwgzXvZ29hLc3H7apU7T
         oqQwvuIdW0UJo4Ql5EDTwEPfg0GoPajYzs/gBm1tEEbRdp04rMbpAfUjQ+yWfGhbCclN
         CFTBipejohOvLk+oKloKmK7xBrhvHA5SQ2mcijeCG7VE7pnqrDDbMTBjzA2QtSe2h+eC
         UuXCSIJoLcjzjdz4uhvh64yI67TBX5af4vf4sTNOvoG1hVTmzT0/VEs/dpncFAZkqeY3
         jkYw==
X-Gm-Message-State: AFqh2kr+cBxKeaXChhjcf87hGHRrzTkquq6Og1MFVTmXuTK+HHGgwVd/
        r/7B69CweO9DEMx0EK7HlpHbSA==
X-Google-Smtp-Source: AMrXdXuKnfVFVXHoEptfBW40GBPand9TJmqP0o/d8/MwkRJ6rihFwo5wT6oo6wb5qWGbqi9JKkDsuQ==
X-Received: by 2002:a05:600c:c87:b0:3d9:73fb:8aaa with SMTP id fj7-20020a05600c0c8700b003d973fb8aaamr48000823wmb.8.1673596764651;
        Thu, 12 Jan 2023 23:59:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b47b80cec3sm33158002wmb.42.2023.01.12.23.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:59:24 -0800 (PST)
Message-ID: <9945bb15-f9e4-49a5-9c71-cd1087a91bdd@linaro.org>
Date:   Fri, 13 Jan 2023 08:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/6] arm64: dts: meson-gx: Fix Ethernet MAC address
 unit name
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Vyacheslav Bocharov <adeep@lexina.in>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-5-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Unit names should use hyphens instead of underscores to not cause
> warnings.
> 
> Fixes: bfe59f92d306 ("ARM64: dts: amlogic: gxbb: Enable NVMEM")
> Suggested-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index e3c12e0be99d..f8b115cd6775 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -233,7 +233,7 @@ sn: sn@14 {
>   			reg = <0x14 0x10>;
>   		};
>   
> -		eth_mac: eth_mac@34 {
> +		eth_mac: eth-mac@34 {
>   			reg = <0x34 0x10>;
>   		};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
