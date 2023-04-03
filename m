Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC226D5064
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjDCSak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDCSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:30:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8C273E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:30:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so120939283edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680546619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFB10rxKhuSnr8G+D45g+FQ9NDBsDveWCcMjexIqOoQ=;
        b=Kaj1AMXaoU7F3KH6UVSShPDhgf9THNic7EhcuaPT3ZujyG7EvehDV246LeYUnL+qyI
         K/7fFdKmOgWDQRLZaTrks3l102LTG8YX7JoP4WbXdsKtOe8UU5WF8dMMd1NqPPVEkmGq
         AljMz56PV392UV+a5X6G04dFDGi3uM8IHqJBePgHcF2RhwegwsCsT27MnRX1M1cjf0V2
         rsM0DepOIMYQsex3QUowLDxMiw/A4ys5s64mVZ97GFNBcorAZgOapKB/35pHkoGu8MNr
         9/dCmlATdw06rQ8Zpw8HSBp50prrAhM/Kus4E4KUKmghlC8tPbkg+TStMALQbPqbVovK
         ugxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFB10rxKhuSnr8G+D45g+FQ9NDBsDveWCcMjexIqOoQ=;
        b=Sao5GO0KvhVtrdVN5GUEqvJvUV1Z57aCl/quyIvBorHs41NzAuHL+iDZ2RsqnDAeBX
         KcWB56nrwswkGhjGUuJSFMkK/mYBqxzM6d8Fi+gD7Lzhzj+CDgA8zylo/IWcljtuEDih
         f4cEdMT11egTB+n0u9tKC/mzw8ieD1CRWL6+iITuM+zjikBESkRtyggjpZIzmxvt9IEq
         zba8Wo3b/ASD/ZOci34nP7Rki/JCmKNOJiszBZjpO/5HEe6e2KwySDwHBGdnevv6QjFB
         bBaze431cfX2ftTmezBpogW+4Jalqat+MVGi+/obKJ4rUwKxOMCOCD9LGQYYlKI7z2wk
         NpSA==
X-Gm-Message-State: AAQBX9dHsN1ggqYWjrRrjOIWLYaaOhlUBLgSajDKgP+55aGe2jrHbxZG
        xfkj7HXPkHVaw/FootsA1n/xsA==
X-Google-Smtp-Source: AKy350ZXjZbzVWh7Vb801ZxzHCIBWyoTyi83AEpPBnF/1+m2w/AJzS242zLY0pfrMJRViuKuzJD5uQ==
X-Received: by 2002:a17:907:8a8e:b0:944:49ee:aea2 with SMTP id sf14-20020a1709078a8e00b0094449eeaea2mr32280742ejc.71.1680546619534;
        Mon, 03 Apr 2023 11:30:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b00882f9130eafsm4783674eju.26.2023.04.03.11.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:30:19 -0700 (PDT)
Message-ID: <d9aade73-1bce-c2a3-f9da-883a5388527f@linaro.org>
Date:   Mon, 3 Apr 2023 20:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 1/4] MAINTAINERS: Add fragment for Xilinx watchdog
 driver
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com, neelisrinivas18@gmail.com
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
 <20230331074117.356339-2-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331074117.356339-2-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 09:41, Srinivas Neeli wrote:
> Added entry for Xilinx xps-timebase watchdog driver.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V3:
> -None
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8287eb2ab4a..4ed139d56913 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23071,6 +23071,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
>  F:	drivers/media/platform/xilinx/
>  F:	include/uapi/linux/xilinx-v4l2-controls.h
>  
> +XILINX WATCHDOG DRIVER
> +M:	Srinivas Neeli <srinivas.neeli@amd.com>
> +R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
> +F:	drivers/watchdog/of_xilinx_wdt.c

Your patchset is not bisectable. These files do not exist.

Best regards,
Krzysztof

