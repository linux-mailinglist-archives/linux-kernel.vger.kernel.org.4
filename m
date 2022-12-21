Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4572653446
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiLUQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiLUQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:44:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8C248CB;
        Wed, 21 Dec 2022 08:44:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so513240lfn.0;
        Wed, 21 Dec 2022 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1GxVlFtu0zCkDwe7OA4gE30k4+6vDGKypeT2LbMmpY=;
        b=ohLeKa4fWkqEflcAjGdhW0fc9PIllRxRoAK6t2D8h9ZtsESxHGlRCTGEwQfA4URDZi
         GW5vtWM3dCIdYbM8QfULNCWgJmcA8lIByKbsJDsv/p2BU7qkI/mzS/kgQ/ZqzdNW5edm
         jSSh02un1IgbrC/LHsbMKVR/Ab43Z5qSd2FpEGsZJ3iG8g0s70lTmhgADPGUzprPHtfa
         CMt2hoLWRYaSYyCREVyQmUlqmUH9o4k+fboqNEvMintawy+IY166zU3Bk7XEVi9tiI36
         b0DmlCmxY2MozgfFUfvJmwbA4QSA9k9whl8enTpnzwKWxBtXxTg6wS/l5+CmxMIHSuXw
         6xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1GxVlFtu0zCkDwe7OA4gE30k4+6vDGKypeT2LbMmpY=;
        b=U+dvNHDFdkMpVvzg5feaNb7AMTAFbIVzN9wgCemanmL+rWP1b/FMb5T84fkiXUvaLu
         Ikj/Ucye4CzSkZ7clmawaua2qJ+Iw17yJOgVFx3qRE+8mwPHPVGnmr06b2BLiEhUlgjX
         fwHYdiEIrvagmQ8Ms6/Aa1DUg8Tj4+SOHT7wPCt4GKBucwhtLPmsuaHnnFiEb/PtR4Lx
         isWfmc8TMkcXmQYQw9YOrrj6VC6pwzn9R8XXPZeAkhYGF7n90kO5DO/Z1BclDTA0q5rF
         aBUaiOFEPLnJDjrYnNBdiZHwe+AB8SBCSd1s3r8kzAuqwD/Va38XnkZl6f6350y0o2BD
         R02Q==
X-Gm-Message-State: AFqh2kpU+sqgE86cZmUVXfwT05pKHSHELzsHrIRVM8gikWhTGrI+scMh
        aPPi3fVGOWykHMViDFQAh5Q=
X-Google-Smtp-Source: AMrXdXuhxpnbu3WNSK/2fBzR2ROsxfxciQceZtoHHQ/NorD7dRS7cd1FyIECjUesI2KCr2l9BxDb5A==
X-Received: by 2002:a19:6508:0:b0:4bc:8c94:82f7 with SMTP id z8-20020a196508000000b004bc8c9482f7mr706475lfb.13.1671641049928;
        Wed, 21 Dec 2022 08:44:09 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id s21-20020a195e15000000b004b575d239besm1893177lfb.237.2022.12.21.08.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:44:09 -0800 (PST)
Message-ID: <98b5a73d-be59-457f-e7ce-71cfbbdd025f@gmail.com>
Date:   Wed, 21 Dec 2022 19:44:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <f4e05666-d094-18cf-2641-ebf92da85dc8@gmail.com>
 <221c1bab-8f4d-9dbb-bb12-4f7ab5dc5d90@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <221c1bab-8f4d-9dbb-bb12-4f7ab5dc5d90@nvidia.com>
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

21.12.2022 11:05, Sumit Gupta пишет:
> On 20/12/22 23:37, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 20.12.2022 19:02, Sumit Gupta пишет:
>>> +#ifndef MEMORY_TEGRA_ICC_H
>>> +#define MEMORY_TEGRA_ICC_H
>>> +
>>> +enum tegra_icc_client_type {
>>> +     TEGRA_ICC_NONE,
>>> +     TEGRA_ICC_NISO,
>>> +     TEGRA_ICC_ISO_DISPLAY,
>>> +     TEGRA_ICC_ISO_VI,
>>> +     TEGRA_ICC_ISO_AUDIO,
>>> +     TEGRA_ICC_ISO_VIFAL,
>>> +};
>>
>> You using only TEGRA_ICC_NISO and !TEGRA_ICC_NISO in the code.
>>
>> include/soc/tegra/mc.h defines TAG_DEFAULT/ISO, please drop all these
>> duplicated and unused "types" unless there is a good reason to keep them
>>
> 
> These type are used while defining clients in "tegra234_mc_clients[]"
> and its passed to BPMP-FW which has handling for each client type.

The type should be based on the ICC tag, IMO. AFAICS, type isn't fixed
in FW and you can set both ISO and NISO BW, hence it's up to a device
driver to select the appropriate tag.

