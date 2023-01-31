Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E3682D93
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjAaNRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAaNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F174C0CC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:16:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t7so5814505wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Leq3Br8tucz3HJXKezu/W0nqkL6CQAl/uSwPttKsgF8=;
        b=o4S/16NLY7JSiLwNRPGMoAIemTVfPSg6AL9SZ+JR+O5op4nH+7MClNQsYpuF9fb0ZY
         LGBbZu+oJ4xl3jNFHecg1jrAE3oE5J+1kRQk901Tor/t+KAHMPK+Q2mq6x5S2dgK3OUZ
         5FLRUHbOTG2tEwJnw76Ld68cOVX3ffhiwRgIA0f1lkGWrV2VlGPYKWupPH1f/H8jcaiz
         eip2S+T0+h/7gVBJAVR9DfkKWciTGWkR+ap/9S6q7nRqF92zjJznFDp8ST51hxP67dYe
         Tm400SWZPguaJKd0dQfry1q34mIYKRE4AkgYEqTF/Py9TSbIbgWqc9rMVebUDHy7vg3U
         OTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Leq3Br8tucz3HJXKezu/W0nqkL6CQAl/uSwPttKsgF8=;
        b=FeHMP8EJDjNKb307ujaBlcdaVO4H2IEZWA4k3LwG9L66IUzBFV6TF9CoQ2+Pv5iq6O
         4WfJofOYQbOmv0lxusOUjJqe1aUXGKysqT2/epH91NMuk3ySnw+ZPiNEo1+EDnEbNJ7u
         6oYSjWDXr7yNq+AETlqRbikyyymN4S6gubXKFD5qO4S04cnQmBQcx9+2xAn+QNrLp7kd
         XmhBB50P32fCrCYZyEGhp7fj4pKGSjWOt1cdCKNFuvciVDMhWifkaWm6mb/KHyjPLhaM
         XQ6hj+HTZzNq4b0XOYAg6HVA2//gVepFw1DQrjFLrd4EF1/sHyjMTapcoLgQcf/3z6c7
         Hd2Q==
X-Gm-Message-State: AFqh2kpZfD2QlkaG2LnacFDgBi6DmLhcuSy3gf44A+vIZJQDYALb41IF
        kVhHBYJuMAuHgdmDz16skPGQ+RWT1u9+abr3
X-Google-Smtp-Source: AMrXdXtYsRWRbZFKwyKPdRYPyxJU/qgmSqxYjdztVLapSLqqIonXfLWODMvHvbl9Zza62nVRER4/aw==
X-Received: by 2002:a05:6000:1c08:b0:2bd:f5bd:5482 with SMTP id ba8-20020a0560001c0800b002bdf5bd5482mr56602829wrb.28.1675171009516;
        Tue, 31 Jan 2023 05:16:49 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e21-20020a5d5955000000b002b57bae7174sm14598150wri.5.2023.01.31.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:16:49 -0800 (PST)
Message-ID: <47330c74-3619-d706-f41e-a2a2c18ece71@linaro.org>
Date:   Tue, 31 Jan 2023 14:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/8] thermal: intel: intel_pch: Make
 pch_wpt_add_acpi_psv_trip() return int
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <1941501.usQuhbGJ8B@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1941501.usQuhbGJ8B@kreacher>
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

On 30/01/2023 19:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify pch_wpt_add_acpi_psv_trip() to return an int value instead of
> using a return pointer for that.
> 
> While at it, drop an excessive empty code line.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

