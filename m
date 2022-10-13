Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB25FDC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJMONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJMONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:13:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470050B82
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:13:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w3so1180482qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31uffpNRwdyYprzTa+ufVXiBmknEXuHQwvr5vQ+4CNs=;
        b=agzuYPwqrSRLKKVtoE5+KTZncK1sZujB9xHGFcWd8jdxLowy+i9fiZBegxrE6cTRuA
         Wt4RDnYd+9+axBcBB7ZwtxOqYmidty380r9BoEkpfxP5EFiHCIUCB0hp6gWchOS/2jLQ
         Qa01qfQ4RJ/33T5FmHZ4y/zJIQ3M2oOYEZHocvTsJ5E6DJvFx36OLH2H6T0d5ISuys6t
         8j6c5GptFwSJW04FG3J0QPH01tDN2SkcMgYOnNFzFb8MOj1lZSmcksWuPSc4Q1VN2sKc
         FktDgrejceY7dvyvY88XDThg5wRyJUx5ozTkiLGr+W7C5vikzjKpE/cX6XKa4w67G56Y
         3jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31uffpNRwdyYprzTa+ufVXiBmknEXuHQwvr5vQ+4CNs=;
        b=Ik65WA8khdnOK3NMjsT+rD6aOXa8nuCVtKjUh89iuofvObZguKZJeoUScCHM4Ie4SM
         ry+pEe3TuDcMDZkMIRO3tMJ8g+SxRMcls5+wlUTo1O89x75HEZfJu+WXEE4OLElQmpQQ
         LfsGSbrRkldxzV34JxpvwLvMB68575tUIgLHsEsDrG2H4caRqNwU09JrKWPt5IkBTfUk
         3ml3mykjfZnLCo9RrCApbcPa2TqV9yQXn6k5SEUf6m96+xj/7tzQVxCbVNq5Go0KDKDj
         CJ6zxj8lCNkT0wazyTtH3IGFwNkqCRQBHaCBgspsBDxiOUjmmUPE1w5F66xrP29nVRMA
         QJVw==
X-Gm-Message-State: ACrzQf0ig/RZ78t1NRDnaDe2MzK3p16kzLYh3G27MRoNZmVsiujW4vsD
        Xr8By6pWU2Ig2+IlHYcG8tLz2A==
X-Google-Smtp-Source: AMsMyM5/a5SlZepFUrzT+rzNGyi1GbWiSQitwIlqhkYdtjGrwIB0/557uIVoDvpjWJq1aGHWujEVbw==
X-Received: by 2002:a05:622a:1a85:b0:39b:d3cc:4714 with SMTP id s5-20020a05622a1a8500b0039bd3cc4714mr3142qtc.310.1665670414574;
        Thu, 13 Oct 2022 07:13:34 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bk19-20020a05620a1a1300b006ec771d8f89sm12214940qkb.112.2022.10.13.07.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 07:13:33 -0700 (PDT)
Message-ID: <d3d2ecab-179a-dbff-4dd5-0785e49b45fa@linaro.org>
Date:   Thu, 13 Oct 2022 10:13:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Content-Language: en-US
To:     Jeff Chang <richtek.jeff.chang@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, jeff_chang@ricthek.com
Cc:     Jeff <jeff_chang@richtek.com>
References: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 04:06, Jeff Chang wrote:
> From: Jeff <jeff_chang@richtek.com>
> 
> The RT5512 is a boosted class-D amplifier with V/I sensing.
> A built-in DC-DC step-up converter is used to provide efficient power for
> class-D amplifier with multi-level class-H operation. The digital audio
> interface supports I2S, left-justified, right-justified and TDM format for
> audio in with a data out used for chip information like voltage sense and
> current sense, which are able to be monitored via DATAO pin through proper
> register setting.
> 
> Signed-off-by: SHIH CHIA CHANG <jeff_chang@richtek.com>
> ---
>  .../bindings/sound/richtek,rt5512.yaml        |  50 +

Bindings are separate patches.

Best regards,
Krzysztof

