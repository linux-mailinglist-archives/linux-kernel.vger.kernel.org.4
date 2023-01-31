Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3A682FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjAaO5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjAaO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:57:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7051C7C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:57:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q8so10526352wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHAz431bQVsrWdf09rNRXz2YYOaoDWdEG53YOtzyMSQ=;
        b=NPd6zNRKzONuD2Bt3nTD1S2D1/hPxA1Tii6pwOg3YI2S7XlGqO3PVRx8DjdKC7usic
         WRgM72iqDgdYDvTlpvokkexd98wusJk2S5CFituZpGdGu59bTyMPueBrOFFDaymNyNJv
         huEHZktGRtEtyL+zjP7bhPjYfRxGhuypLfDcQntqcq5bfg0qw6ivIfp/XiHuWS6nHcD9
         f1K2aJC8SrxaBfk+ytz4zeq5xqeBibECPZy6TW/3gYrB+ec7xhv8+HMWVrT6cPrG/tU2
         iHSxaG8QWDtevNoImOV2yp94wEONl6/SqrtoSGWuRJoUGGyQ3RzlV6sfAHSoi7tgfPcz
         SP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHAz431bQVsrWdf09rNRXz2YYOaoDWdEG53YOtzyMSQ=;
        b=hkogYJ1+EICjEMgU2uvOhyWYDdVhN1p7lYTrrAeoabpGA5j7zVh++oT5crcKeBoaDa
         f1oRNGG3ABxQpFMHW6GOPT5RvtjT3jLODYZ/kcW8LlGyaNAVqb4uX6Jbcu65+MEnTvuL
         Tc5wugvI4rsPKQQqMhF8e5eT3cflvUwrYkYTY2ggxwFJqsRazP9UEm/RGyCP2f7oMp2H
         twnrOmfHHhsJdgkTXm5kp8kYenTQ1YJ2OSWDj2kuwVlGtGuQ1XJ0BWMch2XGDOwG5Sm/
         vJfrzoQCEvg8Hq0OcUqo+5YPCFfrw29+bmQBzo10ees9NWyhF89bNBC6gTK5ZFi5TiTc
         oK7Q==
X-Gm-Message-State: AFqh2kohI+c3aUdjbAnztt7l3KXlLsiQUYXGatgDtTkcHQVvXGgddpd/
        xCwhDSncEecjPiQDcj33FSxX2A==
X-Google-Smtp-Source: AMrXdXt/MYfxZlWFqCP9KNKC+s3TYem6ne/GKkZEeZLYLy2NQfumKPXr30pG4kvYeFN7am8u18dT4Q==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr56227425wmb.23.1675177042481;
        Tue, 31 Jan 2023 06:57:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm21691874wmn.11.2023.01.31.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:57:22 -0800 (PST)
Message-ID: <8897ee56-3043-d2cb-4dbc-3ddc97e19854@linaro.org>
Date:   Tue, 31 Jan 2023 15:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/8] thermal: intel: intel_pch: Eliminate device
 operations object
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <2141577.Mh6RI2rZIc@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2141577.Mh6RI2rZIc@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The same device operations object is pointed to by all of the board
> configurations in the driver, so effectively the same operations
> callbacks are used by all of them which only adds overhead (that can
> be significant due to retpolines) for no real purpose.
> 
> For this reason, drop the device operations object and replace the
> respective callback invocations by direct calls to the specific
> functions that were previously pointed to by callback pointers.
> 
> No intentional change in behavior.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

