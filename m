Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0050B654489
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLVPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiLVPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:46:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7D1208E;
        Thu, 22 Dec 2022 07:46:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so3279354lfa.9;
        Thu, 22 Dec 2022 07:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLTomQZwpLMuo8G50n/aC4V5HqCG2EVJQjXm2Bt8aEA=;
        b=oas5F6hFSXuFlPoOwVHsL2k9MsyEesnnblTiaN59/o64vslpDdwTA5kFxmTjWK4/GN
         EkVHuB5vRjl57eOHGvAPvuxH/K7RnOp27DtRhL+AbvJs2qB87yTXS5czJ6VBDsuR9O9R
         S62K3csqpit4MWerlozcuYdlSJvG8kzD27pvEDiRU+Un1+7y6Wph4xjc+1cxwnUTfy3i
         f8HIhlOiRhN8WOq7NHhOv/txLA2BMzr7i9JcoK7tyUjnWBUXw4LQhdZcFv1K43ftM0cF
         FsslVFID3y1ap6P2Fd1pFaDDsWmFYHSCT4+zeK0Flb1aJ6wnhH4Byo6lhOgawfddyKGc
         mHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLTomQZwpLMuo8G50n/aC4V5HqCG2EVJQjXm2Bt8aEA=;
        b=v0paCpOIHfjOqrUQ+98iAypwDwqRW4VJbyPQXzYMSkO3D4nzVQyDv/4tQYiwhm90dS
         by1VVb7GwJtwAP50u/hwp3sQTEXAjN3z9mDx4UZG19ZePIUlWu0XJKpyKyOhxKL2iZJ+
         jws+fUfkN6vu1wUeEjzMEecR67rg2rZQAf2J2UioGGpvoWAJrMhYm/b6/UGLsQlssjOo
         /nj2Jv+OU/Tq6/IZpnoaR05CTOv5yaLUo0cxGoD67qkamb3DKWALwFQKlXgusVDVgTaF
         NLpP5uHWEDsZHtSrGOVblVCdBXGiscwGU0jXnLi+aEtjxX5/M/0JtJJXHHAZjPdvdbZN
         yApQ==
X-Gm-Message-State: AFqh2kr568cac+R4uHLcyD5FqSArqwqL0rPnmKU5AIN7xAuomrCQ+31W
        mArCgodwUCvoBk3aceQk83s=
X-Google-Smtp-Source: AMrXdXtUP2Sw6gGZ5vRyoOR0/6Iich+hcCghn16/3M91utdJiYHWuE6sWhNY2WlqDn+4KazGR4bk7A==
X-Received: by 2002:a05:6512:3a91:b0:4b5:799b:6c8b with SMTP id q17-20020a0565123a9100b004b5799b6c8bmr2133755lfu.56.1671724016578;
        Thu, 22 Dec 2022 07:46:56 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id v12-20020a19740c000000b0049ae3ed42e8sm104316lfe.180.2022.12.22.07.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:46:56 -0800 (PST)
Message-ID: <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
Date:   Thu, 22 Dec 2022 18:46:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221220160240.27494-9-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
> Add support to use OPP table from DT in Tegra194 cpufreq driver.
> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> Cross check the OPP's present in DT against the LUT from BPMP-FW
> and enable only those DT OPP's which are present in LUT also.
> 
> The OPP table in DT has CPU Frequency to bandwidth mapping where
> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> number of MC channels which can vary as per the boot configuration.
> This per channel bandwidth from OPP table will be later converted by
> MC driver to final bandwidth value by multiplying with number of
> channels before sending the request to BPMP-FW.
> 
> If OPP table is not present in DT, then use the LUT from BPMP-FW directy
> as the frequency table and not do the DRAM frequency scaling which is
> same as the current behavior.
> 
> Now, as the CPU Frequency table is being controlling through OPP table
> in DT. Keeping fewer entries in the table will create less frequency
> steps and scale fast to high frequencies if required.

It's not exactly clear what you're doing here. Are you going to scale
memory BW based on CPU freq? If yes, then this is wrong because CPU freq
is independent from the memory subsystem.

All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
activity and CPU memory BW should be scaled based on CPU memory events
counter. We have ACTMON devfreq driver for older SoCs. I have no clue
how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
API for that.

