Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68F5F37D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJCVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJCVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:32:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14D1E3D0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:26:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso9762058wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TbLJGpAoh1+RCALCBnZCTh1yz06EWYCAOBbIs7c2PSk=;
        b=ob4292xxuGhqmfoG3oy8OEuZVXrlKVUgOEuDrY9HJyHwfLQDbaJyTEwyUJwg2AYWsN
         NWIEUC81YV1Zo5lF2MbHeE4all4NsMNiFstiAeELHnaSvkeYQorvJAEhRA2sdQq7BflV
         QiVojQhOWyzU/Ex6YxPupWoRvXQjPL2oOMuxIWLVheBXRa31wG4mZOvZjNFAU+1VyPhR
         W/LaHsmEYODc/HU4lxbwxhbt/Y9OuSNkkU5JoIaoBpzechU7k6zRsalg78IHmS3zM1Hv
         nswEy7iexEpa8/DczLKsobFFk46es0XbAlRrmAQJ3A/J7anKBIlDHiBmT+m4UjujPIwC
         cgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TbLJGpAoh1+RCALCBnZCTh1yz06EWYCAOBbIs7c2PSk=;
        b=sYWmNzd+VG+yG0XqysnsoznBT/ZsXydNNFUJ//wyIpT6NQ4VIJ3Yv5dvE7Cz4npcsO
         f3Ee51J+1eHU6qVscHRf1HG/PTLQfxBdAuHrG44Y2ArGSCBWnhWU5w7axh3QtDdLW3J8
         DRGoRSTO/HnwtsO8Bxy296M9qAPhGC4BYfH1XY7jHBt70otM6oFnb3P/qGz+1qVqjomz
         10Mgd22YrhS6R4DRdRp5CWjKaXfNqlPAIhreKS0z7g6Jhf3SCpWh/e8mgwUvQ5tOoG5f
         MU8AOOnR0rP9t+QlmIXixpJGVKhHxTgaHveEivZnemHO81ETZ2VMU0cvehhoOo6IMCy8
         4npg==
X-Gm-Message-State: ACrzQf1EDIdx70v3BXrr716KasNsB30FIN8siSNyotky+2B0vNLPxtXE
        smD/4IMGTMxMIonWm5erW2GHVQ==
X-Google-Smtp-Source: AMsMyM49CweP3Rm+Z6pqyfxkfUOD+rc52VCn3vthTdHqD4+GdUGryyipzzfPQbjqsJVFwq3miIMNLQ==
X-Received: by 2002:a05:600c:3ba6:b0:3b4:9894:d482 with SMTP id n38-20020a05600c3ba600b003b49894d482mr7943738wms.120.1664832382804;
        Mon, 03 Oct 2022 14:26:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id l18-20020a5d6692000000b0022ac1be009esm10700742wru.16.2022.10.03.14.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 14:26:22 -0700 (PDT)
Message-ID: <beccdfbd-9b30-6cca-01a1-37f935b22a8a@linaro.org>
Date:   Mon, 3 Oct 2022 23:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Fixes tag needs some work in the thermal tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221004081813.4f33f06f@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221004081813.4f33f06f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 23:18, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    74978f704d5c ("thermal/drivers/exynos: Fix NULL pointer dereference when getting the critical temp")
> 
> Fixes tag
> 
>    Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")
> 
> has these problem(s):
> 
>    - SHA1 should be at least 12 digits long
>      This can be fixed for the future by setting core.abbrev to 12 (or
>      more) or (for git v2.11 or later) just making sure it is not set
>      (or set to "auto").

Fixed, thanks for the tip

   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
