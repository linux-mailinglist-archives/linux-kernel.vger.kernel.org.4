Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E006A68920A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjBCIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjBCIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:22:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56C991CF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:20:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so3877470wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45Tnhfu0pAuxepjnBLmTM16w/DDLwSO1jhjjoAKVus8=;
        b=OUGU+d2plzG4JQUvTzSTt/pZc/bAsHxNbwp/HWH8vk4+Gh4xG+LPYlHI9CElCcbnxB
         4JDHm9QJB31ixhJ2S/EnpQRLSQiHIawt5YAt8wKciDlOxVsmFgrVMH70GBKd4MjfvUEa
         Sauy8zaw2OPEWV/GU41j/70NzI+Tkyhc45sFA+dm/p9w6/WmfHTmmnyFnx4zHLnPcCs2
         iYMOEDqqEiIFTMYYQwHgSP9972H0KdOufjFJyEGejeWeVoaOIMOImooURU1xPI1dyZcj
         jrgnPWg80CPQJv5gw/ywY3J3zM+nN5lT91wuINZmtsNCA+f7DZoDqineBN9NTx3yKkw+
         f/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45Tnhfu0pAuxepjnBLmTM16w/DDLwSO1jhjjoAKVus8=;
        b=7FPxgofA5sQZZElMFJjNhvB1Xaqr36AG86NrkRXGdkcxq/6IprJE/Yeo0NY+5esl6A
         UPd3eKVEHeg5gdbH9Gpx76GFI5YK1roY6jWs5W9c/p8cvutsYHaE0UuD5qPQgHeq59h8
         jG7/hPcSw26WaJHS5N57Owj1eDVYp1pJDP1aatG9Bof1h2CA49e+9nwEgCaBL2yvJATH
         z3ycfdRT/WpeVUwXySg6pOQR8FhZA/+BUPekPtPCsaBY8ahzEjHdyWZn/ZdnqJZG1dA1
         Zg8eKS/Gu5bZD5oF287SPvJf6DiCeqOkI8YmPWPqH6Qw6L6cH1L4AotbGE/JzaUZ7dRU
         eEyg==
X-Gm-Message-State: AO0yUKWjc91MloQv5BszGtIcJq5m3sJgU2Ph4KpjPfbxlXVXpmLR4yuZ
        9xn0OPvDbbHLJ/pcuXKpGLgbhA==
X-Google-Smtp-Source: AK7set+EHfIJ8oVMvuan/LXh1dEkhymKWZxpfR3L3yw2Z1sdfrUNYRGI4me9tY8RpOo4+CdlFbpKHA==
X-Received: by 2002:a05:6000:1889:b0:2bf:c5e4:1af4 with SMTP id a9-20020a056000188900b002bfc5e41af4mr10438931wri.15.1675412412036;
        Fri, 03 Feb 2023 00:20:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b002bddac15b3dsm1378894wrt.33.2023.02.03.00.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:20:11 -0800 (PST)
Message-ID: <241f919c-8190-00d6-f89b-6f7f54b29df9@linaro.org>
Date:   Fri, 3 Feb 2023 09:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 13/13] USB: gadget: s3c2410_udc: fix memory leak with
 using debugfs_lookup()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
 <20230202153235.2412790-13-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202153235.2412790-13-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 16:32, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 

Hi Greg,

This driver will be removed in v6.3 via Arnd's tree:
https://lore.kernel.org/all/20221021203329.4143397-13-arnd@kernel.org/

I think we can skip any work on this.

Best regards,
Krzysztof

