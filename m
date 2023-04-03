Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525F96D5486
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjDCWGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjDCWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:06:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E726AD;
        Mon,  3 Apr 2023 15:06:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s19so18486859pgi.0;
        Mon, 03 Apr 2023 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680559607; x=1683151607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJCa9oZ04Ks8sMazcFO/VKQNTdXem14KycuV76f0rrc=;
        b=FHX/VJiKxcQNIunXX6dEEzh3e6W+9GpDmGjmr7CIxo0y1LST4Tzaoih3CiVSXBTJn5
         HBbbIK8BCCN0pK0okxMRS3OFyVfjlFo8BpqPTLva+NvrpfMYfM8X5zOPRmyZ4xhnu9VQ
         i3jSLwr/1vhkcA6aXT66mAHIbnro4FiRw/8N9C+gQn5xwsM2EvNjPpXatQdPMK9BYcrK
         wgwgJq6r6ULGp5rZ7YAKtaqlYxp8n3P2Un+12bC0BlusxY5ljFkaQP4JirRfHMU29ezS
         jRuz2+ouLT58Dy2repjboyQuKAa+k+Ujj/Rd3eTvc35JhJHhziwjIln9zKiY0HbI4fnc
         e92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559607; x=1683151607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJCa9oZ04Ks8sMazcFO/VKQNTdXem14KycuV76f0rrc=;
        b=1u1qo3NH+FtzyOe2KmGEy/ul8f4NeaXY6lYhimWIELi1u/Y8VFQHuPYrz6tWlM5K4h
         Fo0wMshunFfdYpMBKReo7tEcATNj9TwNlge1ywBCTpi714sLQXYXvj15rKhu2LzpcY6w
         ubTBdWD96wIBGB7IrnrtWCczzEK5vzY9Z1K9Vwb+bVfZZGbeZUZm3GoDBpN3l/+fIgx4
         EW7MfhTnb4SUaobOgVbMOmg2ojr47nfqbGfhVAg2bmsK8zM5U1cB52lKmaS5Gygd+CLD
         TYhgz4WTbfAQph6cVTfSjRYicqo4Zn8qEQgB7Wb1PPRBM3NUTy/xVfW5HNLCPyMWiavU
         XZ4Q==
X-Gm-Message-State: AAQBX9fcVE1VgaBOWn4gqr+zeVxQef5OSriawRc3dDA5fUlWcyBWVZVN
        dvyzhG1A5MMRzlWBhdEPeM1VhKWcNxvHsQ==
X-Google-Smtp-Source: AKy350ZdXGE6cpbpmVZYo9Rg3/ffEZdfUGFP72Tgn4WpghMdGFVbRqHiowBWfPTd0tPVnKF/cGUnsQ==
X-Received: by 2002:a62:7bc4:0:b0:5e2:da34:4aaf with SMTP id w187-20020a627bc4000000b005e2da344aafmr172473pfc.4.1680559606801;
        Mon, 03 Apr 2023 15:06:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 9-20020aa79149000000b0062dd28aaca6sm7341178pfi.212.2023.04.03.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:06:46 -0700 (PDT)
Message-ID: <4cea1e91-f0d4-291f-813d-353f8b9d2a5e@gmail.com>
Date:   Mon, 3 Apr 2023 15:06:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/2] Correct gpio-ir-recv wakeup capability
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthew Lear <matthew.lear@broadcom.com>
References: <20230324203833.3540187-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230324203833.3540187-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 13:38, Florian Fainelli wrote:
> This small patch series fixes the gpio-ir-recv binding and driver to
> first indicate that it can be a wake-up source for the system, and
> second actually make that happen.
> 
> Changes in v2:
> - corrected the indentation of the description for "wakeup-source"
> 
> Florian Fainelli (2):
>    dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
>    media: rc: gpio-ir-recv: Fix support for wake-up

Ping? Someone maintaining this driver?
-- 
Florian

