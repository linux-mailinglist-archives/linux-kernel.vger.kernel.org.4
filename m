Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD26D6265
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjDDNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjDDNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:11:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56E359B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:10:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so130459513edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680613856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqtoEDZVWkpxcyzUs7xGDK15f83XMUNAY3m/O6ttw+s=;
        b=h+Dkbi6kOstMI39IA7cvSaywyJX4Ycw3uQ2u6jjtLZTs8F/imiXll66ajpcoXGbhEM
         lGn5DPPGBpyNQBhkv6IltksGxH99RDtaLUyKm4d+hMiDeQuhr0QzAJUcZ3JN3ASKhtXy
         CV6rUEJ1GsCWxcDquhpOpRx0kHERW447ObIZDbM69mQM5Yj4L2VZsgFcFI+hQtXGXBre
         CjIUvJn818WyklraPGkuSgLG97PedNk7tMr7ufDFUFzDy+Au6LvHF91rGhZquZ5B4myF
         MdGvYUVNSzTV+j5Q89sk950JpkemyKlPaZougK/2JqzoDCQKQzZptLwrBmA2Zq3g7oIz
         rrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqtoEDZVWkpxcyzUs7xGDK15f83XMUNAY3m/O6ttw+s=;
        b=UDsqGQ5ip6LBx/9htIMVXK/sZHohyS7KE/wqq54lTh1/ZfnzAjWrhVTYdGSZlRqIcJ
         H6BpQ/pKkTTyZqlyZj8aMzhd//KWf+hVd2hjkOI+agOAuyMNMto0kVf0um65rkAJL9Wi
         rO9aGOUSN4ZjXhkGyca1lSjbxoBvznEINzhxTa70w3skReowxK7Or0Wrvy431SF5Cfzd
         HKoyqI4BOXaX6yH4JMOFEHdpGwrdd+oY03Arwz2gQ+9PtjV4DLMLFpNWQuRgw9r+S6Kg
         AOO92OmRI9LUx3F2bE30SDINbQvy1JckaeFaDfnHh7cf9yiJhDFGO70zqIcRgklCMAbn
         XxGw==
X-Gm-Message-State: AAQBX9e0I6AGtNlpM8P+8kGBG6aGxrXFXaie9eteXzGpwPEjHOF9SF1E
        5KwwiPmf6rFwVYcJcuXiR9E/xQ==
X-Google-Smtp-Source: AKy350bvVu02KBDj6r/vYN8VfjwRMyssZiem2eDoz/ZAF9OvotcITs/vY4jFbqhN0TVVTroBZlyCfw==
X-Received: by 2002:a17:906:3553:b0:944:6d88:206 with SMTP id s19-20020a170906355300b009446d880206mr2250852eja.71.1680613855935;
        Tue, 04 Apr 2023 06:10:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7467:56f4:40b7:cba8? ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id r19-20020a50c013000000b004fd29e87535sm5870813edb.14.2023.04.04.06.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:10:55 -0700 (PDT)
Message-ID: <5c4a2a12-9ae7-fb26-ed48-4fb4dfd792f3@linaro.org>
Date:   Tue, 4 Apr 2023 15:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] drivers: rtc: add max313xx series rtc driver
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-2-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403154342.3108-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 17:43, Ibrahim Tilki wrote:
> Adding support for Analog Devices MAX313XX series RTCs.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>

(...)

> +
> +static int max313xx_clkout_register(struct device *dev)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!device_property_present(dev, "#clock-cells"))

Why would it be not present?

Best regards,
Krzysztof

