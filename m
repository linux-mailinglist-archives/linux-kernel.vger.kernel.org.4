Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198D06D10A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC3VPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC3VOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:14:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ACC19A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:14:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q19so17353068wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680210882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svitRmAwfjSzCiTV3iUGu1W95ui5xUmfJsnHH3NKzfI=;
        b=Rss+c7+JE5WyxT+VVG/iOwxZVc8YNHKmivBSMRMVaBeJ9bdsZX88XJniTyN8h23gsX
         ypDL2EQadCUGFEJqsAPaRGz2BiGTQxSx/dn0UI3QB0tJJbNZJLzumZPkKbipUOWVlQIc
         B5P/iN4aTa397B02f5L8k4L2E7Ta8NeckYfzZ1dmqZls10f5FO6swRQcVPBQ+1Vw33nP
         S6/nUbYIuYag2O/V1N0g9hf5b6B+U47nDXZfAu4GMBf3r5DGoBwgG0D4N8jmnV8dVdGQ
         M6A2BO94NIUMb78mrE7oI0zc1V3mirIgu5L1oFIEq5VtDwPp+7U2LJOeWth8n95TWXQx
         zuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svitRmAwfjSzCiTV3iUGu1W95ui5xUmfJsnHH3NKzfI=;
        b=wTlW7V0tkthqKWc6rb7BL6bqQYDX9RsOy7v3crpYn7nEb9Mb0MFyLRod9gdJzl/r7v
         f0FmbVCcL0R5WMNPrJPVbAnL+sRBBKxTyTpQrK+CeOpJbqfzOBjE/XkTxtVs/k4hI+H6
         KRNECGPpq8xyOx1y6OdyUKYIrKx1u84c4WfsUhtmDkT8OvR+iwC2SUyDQ01xaiPwAR5N
         WSUGSoDEFbpikYY9yh+oRIXB8M0ClauA8hxvjy0uDQzI58Eux05+KPaIfB1Iycor2ANa
         12+GGGBMIKK7FNPOtpGv9KWzPyPrGagqbgy0P6NKNmOhug0AoBu1gZUHTvPpVnsTshUp
         kQpg==
X-Gm-Message-State: AAQBX9cHhFCMs1u7HoHP1BsYL2mvwX9GAYNzVTUaub2IUPMl+4uB699K
        p6FUjzMs4ikzQqog8/+yHAxi8Q==
X-Google-Smtp-Source: AKy350YaiKIoamW1LIp23ecuuhJKv2CmTkC9MN9Posn6KiVuywUpfE2+nyKS9604rK8MW3YV5PxixA==
X-Received: by 2002:a05:6000:8a:b0:2d1:e517:4992 with SMTP id m10-20020a056000008a00b002d1e5174992mr17772196wrx.69.1680210881643;
        Thu, 30 Mar 2023 14:14:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:17ff:909e:1b73:8366? ([2a05:6e02:1041:c10:17ff:909e:1b73:8366])
        by smtp.googlemail.com with ESMTPSA id t17-20020adff611000000b002c5a790e959sm376235wrp.19.2023.03.30.14.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 14:14:41 -0700 (PDT)
Message-ID: <f0d51904-d363-cb76-cd6f-f1ebefd0aa5a@linaro.org>
Date:   Thu, 30 Mar 2023 23:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330094904.2589428-1-cyndis@kapsi.fi>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230330094904.2589428-1-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 11:49, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Thermal zones located in power domains may not be accessible when
> the domain is powergated. In this situation, reading the temperature
> will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
> use -256C as the temperature for offline zones.
> 
> For smooth operation, for offline zones, return -EAGAIN when reading
> the temperature and allow registration of zones even if they are
> offline during probe.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

