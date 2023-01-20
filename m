Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C113674F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjATI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjATI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:26:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621B6C13C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:26:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so4110965wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQD3SeU5cieHqSaSQOFOuvwfEvzyXZdGHoT+3iMV3+Q=;
        b=sVyo1WQwvoZ440cfSfd/pBn6sA68vMHM8R19MkVLWsSsjdsZTDLI/NPzuoCWheFB43
         U7XktPstpagWZ2qz+/mHgKjzQQgu3K9H8IY2GeXgWQYXzCePDwAWGP8CDHTPDv1XAbUK
         dLcildkMljvAn1QFV/+0m7H3A/iSELWMk8RmyCxo4MfsLd0NJX4Bq5SCA2I+UggX4tp6
         W6pC9BpEKDUFQ3uN21L7ZEHZbdVwujf+RUFsv+roVc6i/LE8/3KauFC7lJjED2eJXAaD
         OkTontz5KnEQacEvrHalrX1nNKaPgQUBXoYOJu+4WJhlFa3MztSxvXw8DUEY7rb12NJP
         jhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQD3SeU5cieHqSaSQOFOuvwfEvzyXZdGHoT+3iMV3+Q=;
        b=B5Ie0D14+IkpPlUi4U5Bth4MHXafiPJYbUU3lfo872biW8iCntG0LZCSsdAS1VRbnA
         GdbW3kxws6lWFt7xGmDYJM0Vr4oNwfBxbQDDgpb8bK1SFptcqDj5lKGUGioivquU2Aak
         f4vF0QJbB9DIVjDmIqjyoaeexxMIKPiZJ5BYGJLNZEMzma/Bnsb8UPkUfOupqC1vK2l4
         tVaAQHA8rh7bw37S9krdkz/AFTzEvOeFuaywmAbc1Q4Nor64NwkQKcitYi4RUR+4Y8lg
         a1XTGcW5hDvKpUITH3ldcYSheUNOV2459tr+pOFQTcjMDfTlARWDwE3gFskOfOpg15pM
         X3BA==
X-Gm-Message-State: AFqh2kpqH7kFq/MzdcHAge83b+AVsf5sNiSR2+e37BPFSLGRDOlcPPXY
        bMj/FpOpDETFjt4OrWavcI+CHg==
X-Google-Smtp-Source: AMrXdXumlxfJ8KEAKW4uHiXN9MBz2WNa1cx1COulyE/9/p90MuXxNfk3ZAmuW8Tb8rR6CiXOYcG//A==
X-Received: by 2002:a5d:6447:0:b0:2be:34f9:5284 with SMTP id d7-20020a5d6447000000b002be34f95284mr6818039wrw.48.1674203206302;
        Fri, 20 Jan 2023 00:26:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm35371733wrp.74.2023.01.20.00.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:26:45 -0800 (PST)
Message-ID: <94655b6a-4e2b-9ec5-8c86-17cb8690f44f@linaro.org>
Date:   Fri, 20 Jan 2023 09:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] dt-bindings: display: rockchip-lvds: add compatible
 string for RK3568
Content-Language: en-US
To:     Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     alexander.sverdlin@siemens.com, macromorgan@hotmail.com,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230119184807.171132-1-a1ba.omarov@gmail.com>
 <20230119184807.171132-4-a1ba.omarov@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119184807.171132-4-a1ba.omarov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 19:48, Alibek Omarov wrote:
> RK3568 SoCs have a single LVDS output, that use PHY shared by two display
> pipelines: LVDS and MIPI DSI.
> 
> Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

