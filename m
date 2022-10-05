Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325D45F5001
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJEHAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJEHAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:00:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0F6CF51
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:00:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so4909601wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE4YYswoUd6/7vbYuunvLATZVA5nGwNOYV0WjaSQLtA=;
        b=mVfB1cb7TkHBlFjDlceIJOs5IYoA4gnQMcKaI0iySBDQK/VERw1dERZeegVJThnO+k
         TGfPzMKEJhDhHCL62ln+b2NiIMIG0DsGXHPZ5wHnjppxvkthXziRV+adPooY3lvxw+tn
         VHAco+8CPCPR8NmJMWy5MJi7DENDgD95OqBp8gyrAG3PbcJn2TiEkv+3NCeii6GdFU79
         8XKD6iFwUIDZRpb+GK1JowhdyUmp5dXYEIT88mOUj2JuGmYifxJ0cDCAQG4EOtPA4jsf
         4+Waw8T12h1VufNLpHOw4sQ96/SLzHUEtVEAbJJInUjV5VD5oegQZyMt4D8nHnVypOmP
         iHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE4YYswoUd6/7vbYuunvLATZVA5nGwNOYV0WjaSQLtA=;
        b=fR1s4Sl/JT0jV6sH8FJkkRtnkaEdoR5PeI35fawQdLFIXBPnLf1HxF14UP1mrau281
         KSAbEh4rfBZSTiPiAeUN+Va09rgL3HkL5bP0cEu+drC24CjpFMMkDaN4qYFvmOEQn250
         UaasHXmLyjB719ZUBA8a6pT9yRAZ0/HV69eKYRSrR4uf1eBbYm2PsNEQm9K5T8zyVKB1
         HzpOtUAwpv5GHRQmjynvbjsegtvw4dWg4Zd/ObzByVC8LfBmJEvlMXoRAZVbVSAP68sV
         n9pZNIP6/Y7Gdi0Ms3gqfJRgunBpNuEmAcOr7gDdqdMdJaz8PIBLSolgL1IXZNEV3QHp
         oKig==
X-Gm-Message-State: ACrzQf2BAJeKJEEtFGZt8kdt0E+QBk/JdZjNBk30Vuh/c4xpd1tRGEIe
        WNHV1nc+gADwSNbX6LnfF4/+/w==
X-Google-Smtp-Source: AMsMyM6GfIt3WR8bKa3VAfYGyCZN97BZcoU8vHN2RLTAkVDPbt96s2c74SOlpnI/TaIkX8yUGI0ETw==
X-Received: by 2002:adf:ce8b:0:b0:22c:dea6:6ea with SMTP id r11-20020adfce8b000000b0022cdea606eamr15707758wrn.387.1664953224681;
        Wed, 05 Oct 2022 00:00:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5? ([2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5])
        by smtp.googlemail.com with ESMTPSA id m12-20020a5d56cc000000b0022e58c14588sm2241482wrw.85.2022.10.05.00.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:00:24 -0700 (PDT)
Message-ID: <07741aab-c219-c791-c315-6d580736f7d9@linaro.org>
Date:   Wed, 5 Oct 2022 09:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/3] ACPI: thermal: Drop some redundant code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12068304.O9o76ZdvQC@kreacher> <1831358.tdWV9SEqCh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1831358.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop some redundant initialization of local variables, a redundant
> return statement and a redundant "else" from the ACPI thermal driver.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
