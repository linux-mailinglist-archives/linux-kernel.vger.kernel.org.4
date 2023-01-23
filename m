Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561AA67869A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjAWTla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjAWTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:41:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37C30E9B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:41:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d14so8178833wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/RsMe/pvsRxXGnKgG44ap9RIqwrmY5BGtfT8sB3Eh4=;
        b=OMnyhIAFcuf8nT4iXKlhGZ1df39+dR+qfI3xswY1zqPdP6REFLZ1jGmagTJf0E/qZg
         fSW8p77CNMLw+pmKKkZy2rMGx8V6D5sDerkC7rLtD6BL+JogehS+v3JKKYoyI3rwglN5
         2PpB28eDnu5Esw+nb/k+NfdGU6f0H5WhAn+f2eaVsl5C4qGAxLnL5LfSwVOLT8QSXgeY
         v44j/NvtBsgcIIWOcZ7luzLDwmgckOU01IckCg6HSLZgpli3Dtg1CV9XJDSQLmeHR7gO
         fwN0z4WMjlYZ7L75MkD6TbA8Kqvuv3LgKMrDwTKQpJHLy48xMDMk0oau5V9Ic0FeBvNK
         pCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/RsMe/pvsRxXGnKgG44ap9RIqwrmY5BGtfT8sB3Eh4=;
        b=dwxEl8IeWjhOiDBGJpKjwl6YD1tF5AGiMAfhgdTBy9aaF3tuUqvYtk4voQicOfekrm
         Dcu0rKPqVBBVQa4pVjo3qFn89W+LPqZO3y1NowXNE3DuMWJP2DFqSksh8zXEeyQ/mMGK
         FJwrtQuJVFFCvJgHuulcgRgM4YdD4iocpAI4SlYlm4HDy84kYhH6i383UbWR/kWfAZjD
         ipl+MbvclYIybM03LxMxeEXTwlVWJ68NWef5UZ9stg68s7DPCO4iEJh61oK+J4nRTJ4y
         YvlQrvRn/aJJabUnVWJ7tZnJ2rFFj/w1ZuCTP5xKF3yHg+/bIK3VhkOliT2lZ34ratu2
         pxSg==
X-Gm-Message-State: AFqh2kp9QA/7n7fMO9oTasrwS7B/i7CXGHtBddRFiInoejohlhTkjlOX
        5+zJrfdYqMjgClxWzHhrHZmsyg==
X-Google-Smtp-Source: AMrXdXtxGOM+IE7OMAYhEmDiWqfKeOMQpDAVWOJWd/wcOgQQY/5Q9ZqrysmmRjNZV7CdShF+92RTyQ==
X-Received: by 2002:adf:dcd2:0:b0:2bb:ebc4:2f5c with SMTP id x18-20020adfdcd2000000b002bbebc42f5cmr31696184wrm.43.1674502882043;
        Mon, 23 Jan 2023 11:41:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n3-20020adff083000000b002714b3d2348sm172556wro.25.2023.01.23.11.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:41:21 -0800 (PST)
Message-ID: <62eb3874-b9e1-7c7c-3147-a9cd9b65ae0a@linaro.org>
Date:   Mon, 23 Jan 2023 20:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 5/5] drivers: mmc: sdhci-cadence: Add debug option for
 sdhci-cadence driver.
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-6-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123192735.21136-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:27, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Use Kernel config CONFIG_MMC_DEBUG to support dumping PHY and host
> controller register configuration for debug.
> 

Commit title/subject does not end with full stop.

Best regards,
Krzysztof

