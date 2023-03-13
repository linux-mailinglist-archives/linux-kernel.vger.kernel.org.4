Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C76B7391
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCMKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCMKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:14:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC151F96
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:14:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so1732321wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678702487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LFf8imUXGJ740YH30H8G1wP3R9KYJHw0iP0NBgTQYjg=;
        b=vFNwZo6RCHXiM9iiMArLPMPbJCFc/TRgHdwWgiREr79AhocZJC4USZsObQ2FuO45qf
         /pYOUkBfHdUJyqlNEi2VlUGnNEgay8UO1jJIcF98bJJd0t1+80wfuCAmpy6ttHVnpicF
         S6xbPBQifPCWFghEzurSI479fm+E/lS7GvHvcur+Ni6/yFUh50ABzZmCUgZw82bsVyYm
         CCmqON5iJgMlhnUMKIRzUp6/TzBtAGYeyjuacVbeasFqrd5NRa2/31+Dx5Rd1oCukOIy
         RW+FIo8fvSWDEhx8MREr4tuJ1yF6LRjbzW9bCfsro6jEyRcH3ZUnXLhvbahXnJRTWtE3
         n7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFf8imUXGJ740YH30H8G1wP3R9KYJHw0iP0NBgTQYjg=;
        b=FTSJJJ9LEuIN8wjmY1rYPmdOjYt/2Ip3ay00CAM9mCKa5OKgaZaeMPkdyXs2eM+3N+
         ftdGo0Ogp9OgSnwndkNpbOwUtA9zq8so1jat0/lzavR1m6haCfGSg+ZoK1jR8wyc+eLl
         v7oNMWQ3SCrju/794j6xx1pzsBXbn1v+pYzH0kN0kM8JswqkHzj2OcswO1Ux8rhAJVAK
         Z3ebAYA3Ki5lOypW25TRKHlC+yrB3untKBHL5U569fEqSYNwa7cZw2uT84EOCrngMzRk
         IaQVltTF6Zzmgu4W72XAv/LoC2lcrlNitDmLpU//lqU1LPlLVxhsfEww+A5u1/51vJOt
         ol7Q==
X-Gm-Message-State: AO0yUKXQoexI8TejIy2GB5Z8LBj9uZ+DZZFAGHT8v+0MIhaIoVFCjl1x
        bMvVAnnbwzYxs8IJJVcf5/BaYg==
X-Google-Smtp-Source: AK7set8yLU2cIhBgVUD2MrkZNSiTLmoACOPx2vcTRtog66hQ7l61dtZLkzmt+UbOf2oZpjyAn50keg==
X-Received: by 2002:adf:eb4b:0:b0:2c6:e744:cf71 with SMTP id u11-20020adfeb4b000000b002c6e744cf71mr20498231wrn.52.1678702486687;
        Mon, 13 Mar 2023 03:14:46 -0700 (PDT)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b002cea8664304sm5554039wrs.91.2023.03.13.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 03:14:46 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:14:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: arcxcnn_bl: drop of_match_ptr for ID table
Message-ID: <20230313101444.GD55049@aspen.lan>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
 <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:56PM +0100, Krzysztof Kozlowski wrote:
> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
>
>   drivers/video/backlight/arcxcnn_bl.c:378:34: error: ‘arcxcnn_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
