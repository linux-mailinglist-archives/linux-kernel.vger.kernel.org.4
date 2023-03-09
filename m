Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818C6B21C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCIKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCIKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:43:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF5E7ED5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:42:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so5052173edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678358564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIqPwZfACxuoFE0kVLDEX5KFTlxcxIkjr0ZrsCZpJfg=;
        b=euVIL+2duTNYwRJtF+ol1oSzOAan84vhnx9zvHZpXS6JSx5MDgCre/TmAdkCXB7MK2
         I4jb/gEFln7Tc55yGheXC6LCyasYkbRvGkjcfnH9JWP8vMj2oH+ua3kT4DUVvIpio5qm
         8KAaN0aPH4fcLlLBGN+bCLfbIkTte9imoBhZqKTxGi0Pyl2K5hQUKFadjITLBDgC4tRe
         9JvJtm/9nd5d+j3EHVcot8cppwPfqzX8j+IqL+KBQkxJBxYiQJ6OML3Z4VtrIDeOXQI5
         R9C9ULlDParFe3IljpQOQ8H2YOnIJ2Y3EfKjt1gDpCvFDTVz9a1P8ilGCS6jjqBQHFGC
         UNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIqPwZfACxuoFE0kVLDEX5KFTlxcxIkjr0ZrsCZpJfg=;
        b=i19l8rvNpAZwmcQjKqrfHivVSCARjs3EOiDKS3XD4JUUdZ+cTLJTlDvt4drLcMg+oL
         RJAMnS92pjCMhh4MnNrf65znmqOYt1DDxm+b+AXOPaQzMqSKpUmUKAQ7b5x7QbbWJlDl
         BnrOMreGshq7qmQ8mEjayDwW1in2MnR6prJ1MTdPiRPnY71RjFdqugVb/Rz7YzhnLo3A
         Pj6Lmi1j1YqgF2tAT8tZa1aAw4vfvVRD3+KHFypl9TmyHS++Yz/3wEMjVJatK0k9TJR2
         kP+RHzPLWWyKhRhGa+iYvUOuzAKUxFMV73rh3IaaUEGgNNKb5KVk02GiSC3w3lsqH6E3
         uh/w==
X-Gm-Message-State: AO0yUKVgUcpdAjU3fIfwFLKghr5EDemHwtFdJy9iiHPZ3NE0qpjuQNSz
        WYADO4RWb+AxtfGvujGH5hLxLQ==
X-Google-Smtp-Source: AK7set8BzaVa4jd8dPDPAqB41K7DRKm9ax9xddxg4jIMPvb/7B3XF2VQMIRZi0xYFz1/FcAsN4zkZQ==
X-Received: by 2002:a17:907:e8d:b0:8af:5752:691f with SMTP id ho13-20020a1709070e8d00b008af5752691fmr25759324ejc.76.1678358564466;
        Thu, 09 Mar 2023 02:42:44 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id se18-20020a170906ce5200b008d6e551e1bcsm8635884ejb.2.2023.03.09.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:42:44 -0800 (PST)
Message-ID: <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
Date:   Thu, 9 Mar 2023 11:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230309104133.537056-1-lucas.tanure@collabora.com>
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

On 09/03/2023 11:41, Lucas Tanure wrote:
> Add support for Steam Deck bios old properties. If a Steam deck didn't
> upgrade the BIOS, the driver should be able to handle the previous
> properties for shared boost types.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> Changes since V3:
>  - Fixed missing space in if statement
>  - Fix the build issue, as dependency patches are already merged
> 
> Changes since V2:
>  - sent the wrong patch with missing fixed lines
> Changes since V1:
>  - else in same line as {
> ---
>  sound/soc/codecs/cs35l41.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index 1624510d09c0..2803ff0f0003 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -1022,9 +1022,15 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
>  	unsigned int val;
>  	int ret;
>  
> -	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
> -	if (ret >= 0)
> -		hw_cfg->bst_type = val;
> +	if (device_property_read_bool(dev, "cirrus,shared-boost-active")) {

You are now changing ABI and adding undocumented properties.

NAK.

Best regards,
Krzysztof

