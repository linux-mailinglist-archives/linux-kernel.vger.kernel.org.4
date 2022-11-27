Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD73D639AA3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiK0MxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiK0Mw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:52:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA5A1A4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:52:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z24so10201277ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ss5EUFYPSLGMMtCcaAzc2NEgCFyiqQz6TqOrspmzT7k=;
        b=yRgWk2ZV1ZvWEkkGQ2sMm4idAV4jCqZTJZQZWul9VNq35/Jecpnaq6m+o/bBLof/KK
         B+n1vE5uih+kG4sLFEEi+Bt3+GeAM6gTFPlAmnWMXKF+d32BXBBJKJBqnhI8Rc519SoB
         Ote1mVtEkWMdz0xQkc5NmNpevAlj+hBvhLH9D1NabJnZr21UGhYwIoSxbIVFdVx1LXjr
         p60xa+1EcWNgvsikg9hVQnkQ/2q8m5OPQi0eDBHoyb8beuVZLeBmpxCCl7zHL5njZ5ka
         DcZ1NHXZL+Iawih3/XT5Nx4Ohdnp1HUJxD5Wye2/FSzvU004n873jje7koAuMLBXOYqj
         Mmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss5EUFYPSLGMMtCcaAzc2NEgCFyiqQz6TqOrspmzT7k=;
        b=Vta5QMjazgw4VE1VaSSMuqaqqsBbTZ+5BlvPDvcv5u+A7NXrNLE5b7W7IqiAnFb3bN
         YSKQ5aeHZXe1mCwU3RHjdlDbcq2laery6n0yJMN0DPCPu8ZJ2uX0DnJHN7ULn5LBRwSq
         obSyG/NaSut/wzvyh/uxxvit+92TriBLi7YTUoemn79r3r5JgrSw6taXkSRmVXvlRd0u
         7DnA2o4h4Pznf9YnUOeSEWhvBZ223sH4F6XCg4reCtARuAQlRoHpdzSBYNUcpgwqQ/bj
         Bt7yQ5JTGNxso8RJH0IJXr7GZnu9iL//Nnus2/HYyHzz1C0G0xFHDMDiUfYUR1F/NDI8
         CHMQ==
X-Gm-Message-State: ANoB5pkQP9J1RNzFR6ymZ3YQwGdysWRcR1bxE6OavlJrpnj0tAh9ng50
        F1vfdRHYoeap0bqPJQ1gzqXW/g==
X-Google-Smtp-Source: AA0mqf4FJ/CyuhoSCfxd/ghP9L2qHeHhWw5y9hR1vY3+aLslf998u7GsJYanC/tq9NL8S+7j7DpLzA==
X-Received: by 2002:a05:651c:220a:b0:277:2428:3682 with SMTP id y10-20020a05651c220a00b0027724283682mr16171606ljq.291.1669553575358;
        Sun, 27 Nov 2022 04:52:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l14-20020a19c20e000000b004afd23cf7eesm1276073lfc.168.2022.11.27.04.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 04:52:54 -0800 (PST)
Message-ID: <0a5cd856-c819-b084-a0e8-e97d551dab88@linaro.org>
Date:   Sun, 27 Nov 2022 13:52:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: mipi-dbi-spi: Add
 missing property
Content-Language: en-US
To:     Affe null <affenull2345@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <43ccb0fb-119b-1afe-758b-e413729dd704@gmail.com>
 <81722eba-3910-2117-8b07-bb030ab754dd@gmail.com>
 <CACYkpDr204QaCEmfFfuVH_=CWxH6mRixeRoyv6QXav9T7YP-sQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACYkpDr204QaCEmfFfuVH_=CWxH6mRixeRoyv6QXav9T7YP-sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 19:16, Affe null wrote:
> Sorry for the spam, unfortunately I can use neither git-send-email nor
> Mutt with GMail, so I had to use Thunderbird for sending the patches.

GMail does not have problem with git send-email or mutt (I was using it
a lot), so you need to fix your setup. Unfortunately some of the patches
are heavily corrupted.

Best regards,
Krzysztof

