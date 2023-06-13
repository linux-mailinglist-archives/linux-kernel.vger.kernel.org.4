Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095372DCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbjFMIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbjFMIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:44:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94654BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:44:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5011509f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645893; x=1689237893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOhgvg1tjgafIn2t+KwWYybBDc/75RdZdtgrlDL+3EA=;
        b=REFaRKCHuUB70AGB7KYmstKdfVIkGaxUOfB7fCWdLqCESlPwK/Inb5th6qTZ1N829L
         39wfQATFZ0c9o+w+bJMeKQLEmXA6o6QptjSjY7avQLpycOtgNvXxnBIkY8R+ANHoGTF1
         A4aO/wt7SIO7wgJD2pPGighMiQZaGi4mXD0HsQgy+GMdmXTJRZLpVx2L5SoxQf9NEIAi
         tMybnU+9rqmJ73d9Kzs4uG/XQbQfHTGcwujoc3r5u4d6URyHLhsBdmykeW+mZADwbHRa
         ndlw6KFh4VcPthrarjlxoL9hTMWSsz45vnFieixcxHmDkkeWxpRW0/2d/LLOFaipTU9G
         M8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645893; x=1689237893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOhgvg1tjgafIn2t+KwWYybBDc/75RdZdtgrlDL+3EA=;
        b=E6IIuTpf63TmufLn5M34i25U92QPfpgwLv/576hEgS/XF1VrS+rn73/TtrBInPhtMf
         9NDBy11TNBwr2HFN2L6S6y/TRu+Ko53/nDyBklttCv5WReGsD8ix5mujmkRLHINECme3
         RLlkPCkBaztzEajbxFva3ZJr70dOeee7pWDsNWb7GSYR0y8wuZnxBsw7/ovTF1SHGlL5
         qlhixjQFi04QOQ7sckUzDIxvWeBAvjzJJGIMXlsrELxS1iuwZ8WnBoicyGcj4S1YPoeP
         jJevJfkueUNiXiXWB87xFj+4lQHsSE0T/lrEhYqNt3Y76CrEeG2EPQkr2aRC/UF++nWP
         IVqQ==
X-Gm-Message-State: AC+VfDzAy9Fcg2zA4taeNeV8A3uBqmPao7gH0j0xhb2UYUqc/4h3Dr2G
        VSKFckJXrZrvwogPR3VqfCfNKw==
X-Google-Smtp-Source: ACHHUZ7hNYq/zghQXR6ERx3XAR0do/qjH3nprDgDS+u5UZCPAMy0t1gAr0y3xtWkgtSF1gecspk6Vw==
X-Received: by 2002:a5d:40c2:0:b0:30f:ce0e:c819 with SMTP id b2-20020a5d40c2000000b0030fce0ec819mr804311wrq.12.1686645892885;
        Tue, 13 Jun 2023 01:44:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id u13-20020adfeb4d000000b00301a351a8d6sm14664217wrn.84.2023.06.13.01.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:44:52 -0700 (PDT)
Message-ID: <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
Date:   Tue, 13 Jun 2023 10:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] thermal/drivers/mediatek: fix a regression affecting
 other subsystems
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kang Chen <void0red@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230529162056.3786301-1-uwu@icenowy.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230529162056.3786301-1-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 18:20, Icenowy Zheng wrote:
> In the commit I reverted as the first commit of this patchset, the
> of_iomap function call, which allows multiple mapping of the same
> physical memory space, is replaced to calling devm_of_iomap, which
> registers exclusivity, and on my system (mt8173-elm), preventing display
> from working.
> 
> So I reverted it, and to really solve the problem that the original
> commit wants to solve, I read the source of auxadc-thermal and realized
> that the address of these two memory blocks are not saved after probe,
> and they're only used when initializing the thermal sensors. This leads
> to my final fix, which is the second commit here, that adds of_iounmap
> just to the probe function.
> 
> Icenowy Zheng (2):
>    Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource
>      leak in mtk_thermal_probe"
>    thermal/drivers/mediatek: unmap foreign MMIO after probing
> 
>   drivers/thermal/mediatek/auxadc_thermal.c | 46 ++++++++++++-----------
>   1 file changed, 24 insertions(+), 22 deletions(-)

I'll apply only the revert and let you revisit the patch 2 which could 
be improved.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

