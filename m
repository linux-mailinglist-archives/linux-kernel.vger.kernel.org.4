Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414D733FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjFQIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjFQIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:35:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C062D50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:35:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so130653166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686990909; x=1689582909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWXLjBItIxILy1XStDOYB08gaTJzlRZbsLN5VVFRoX8=;
        b=jhhvse71MG/DeuTLt69otBTQYgyZ6cWT7DZ12lCcGKLGTV5WjPBdP34Ba3hm2sWXxc
         OMrglk13Mo1e+KL9vmWcXNR7OUPTwcgXCR1SOMzTThuyPRvw7xQ8w+d0OUqe6Gslh3g8
         W9jJCrA2N5bzEjl32hnxr8hKnzsMZ/KXMa/uiiyZGgQi4xi29GW+LnOrJ4lXDD9lNzXj
         7AtlZCWwUs67pZbVQaC7FbkyVkffYIu+1Km/KMhF94CPgM5NxCScMbKX0nTY5hUCqHIr
         aXKsVcQ8C1W7n3pImJvJjuveVBYGVrShpO3pgd9VHiPsX6T0H4l0Ebt9Kfwu+FE8LYqf
         I2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686990909; x=1689582909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWXLjBItIxILy1XStDOYB08gaTJzlRZbsLN5VVFRoX8=;
        b=D/HwxXA+E/RGut+n9fyNzr1jYHqpYlI8+GEkOowQ1aESHzcf0K6lBjTcOulpDJrRyg
         9TVTqUGFk7HoJEDtpR3bGuDJgJQ1HKHqD54LIDWuEf9FITpv16igDFx1P+jdHgqcpvp4
         MW/XqR2lzpf4CdmwlOGkTG25Lkzgh3OzF7DuO7xfLQjYb8rOCPocn+/0p44iBT4G0ArB
         6w0WFUEh0Rh8ANI4OmGsB4btWzHH+UCRskQ4dYNt6HikH8+67loX4jsysKtsf7HpJnmG
         Bwwldvi8pIfpO+Bm9o3dFMQFQwO7Tia2vKzMSK2Fo0ol6eMm/BdNqCWDr8XjISR4WAwl
         Z6Hg==
X-Gm-Message-State: AC+VfDw4RBwLKrXN1jHYpDPIBAA1lVME6f5fdizbvnAK/8BVV+NWB3KM
        BHWY3pv9eeG4XA+FbuoZP0MRdw==
X-Google-Smtp-Source: ACHHUZ7EuZmRLIhSc1xJnDpOryKOSOMLJ0NVcyVyY3GQe4isg+Pwfq8u5/LxdN/+PTt3RoRos4OVxQ==
X-Received: by 2002:a17:906:58c5:b0:977:e99c:c958 with SMTP id e5-20020a17090658c500b00977e99cc958mr3803843ejs.10.1686990909194;
        Sat, 17 Jun 2023 01:35:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709067ad600b00973ca837a68sm11767227ejo.217.2023.06.17.01.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:35:08 -0700 (PDT)
Message-ID: <2341d5c2-1865-b7fa-b0a1-b281563490d5@linaro.org>
Date:   Sat, 17 Jun 2023 10:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-3-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614092850.21460-3-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 11:28, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 3.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---

All my comments apply here as well.

Best regards,
Krzysztof

