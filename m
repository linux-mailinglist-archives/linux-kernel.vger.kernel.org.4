Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BF676BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAVJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAVJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:36:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDA13D60
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:36:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6523110wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQGkmyos0lptZSiQJgSxMj19ir8RXd2BXhS7aLPksK4=;
        b=a/O7eeWbwW3MkGdxwzCLdf/ODdAB4Xjsl6zkEaR8Md/OVOVl3Z6tMA+Z/vDfOszKnR
         liyNDASxY49rjxITomrTybtNdvwrQd/sqPKLg9omwczQNH8gu44NWw9HPmvIzMbss1sZ
         4JztWJa9cw1un2qO5kTHXjiJXD/i6LlodZw7cYkTA9A0GYpLsJwC59N9rkEYag3r1BBt
         gbbPZkE0wcMc51w3bxvAmhsKjTV41PFwM1v0sBQ4x9peeU+Yiq8PjmPMNboYF3ItfzuM
         P7On+fnIlcrz4GlYwDClVADzBQqU8oV+kW9TvTPr+vNrYSAgUsvVBUc2uTUl4FTvTJqP
         QMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQGkmyos0lptZSiQJgSxMj19ir8RXd2BXhS7aLPksK4=;
        b=XuVjvK3aQBgTxt/VOpiLIaeymQjQVAsV0UYqvB6+7ooacOiEo7TZI4eAHxdwMeyMf/
         IcZ27+hVl0UUjv2NCgnMssY+JgngtCuip2pNcFqHULfRVO6xGO3jxbmXd9KV4RRm7ULN
         hzML4l1E36WVtWu/+OUzK/TYGSMekmwdTObn9uuZ3wdHSLZin2WxNqg6wA/DUL+5Cz98
         vjnn8VdXPwleWyU3RLVtfx5SStgsxo7e/9IbIuP3T1VI1qBjcJeNdFc2QLse/pqdCDU+
         6/oJhCUlyKK0sUw3M4mvoGSji6Judx1miV2YZLBdMqvZEubDstn9u3T6/ZkBAcJ7opDt
         YiAw==
X-Gm-Message-State: AFqh2kpt9Sc5C8/i6jqBgL45DX/hMTXZ5Aw0LfEW8wSHQg1ufbpGrO32
        rhBqKYkRjw/9t6K7yW4BX+aT0A==
X-Google-Smtp-Source: AMrXdXuG1CIYLchLewcqX4Ck0w7BpAgN9xbWaxxrPI3SGtr0y6z83pzW/xubfDxRgesXyEZhxHW7ag==
X-Received: by 2002:a05:600c:3583:b0:3d9:719a:8f7d with SMTP id p3-20020a05600c358300b003d9719a8f7dmr19574436wmq.35.1674380165479;
        Sun, 22 Jan 2023 01:36:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm7951206wmq.44.2023.01.22.01.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 01:36:04 -0800 (PST)
Message-ID: <b32d2c8f-cace-d762-38e6-6a1a17d919cc@linaro.org>
Date:   Sun, 22 Jan 2023 10:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: ldb: Add i.MX93 LDB
 device tree binding
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de, linux-imx@nxp.com
References: <20230122081429.694574-1-victor.liu@nxp.com>
 <20230122081429.694574-2-victor.liu@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122081429.694574-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 09:14, Liu Ying wrote:
> Same to i.MX8mp LDB, i.MX93 LDB is controlled by mediamix blk-ctrl
> through 'ldb' register and 'lvds' register.  Also, the 'ldb' clock

Subject: drop second/last, redundant "device tree binding". The
"dt-bindings" prefix is already stating that these are bindings.

> is required.  i.MX93 LDB supports only one LVDS channel(channel 0,
> a.k.a, LVDS Channel-A in the device tree binding documentation), while
> i.MX8mp LDB supports at most two.  Add i.MX93 LDB device tree binding
> in the existing i.MX8mp LDB device tree binding documentation.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

