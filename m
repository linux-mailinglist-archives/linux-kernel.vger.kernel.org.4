Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4B64B1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiLMJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiLMJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C685F5C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:09:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u12so14885050wrr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIVTOIopR7ny8mcBhxoHaQP+arorKf3xecWG15pp+jM=;
        b=bPG86XW4UqHnuiZQmj4O5NsaRIDZgwHODuYofxhGUYzZIdoAzRWFWk9lYAgCgaANd7
         JuN7L/Z8kxVEkwEKN7433JrTqm2eGwWsttm0Nt85wuIF7NLH9I01zShZatV0TpUKVLdf
         wL7r/54HvLRvAWKUKcBd819GopB83N7t5bE0yWKfomZ6zX61gcS8rYwkUgkFndiO781f
         oV7TGowwux0Aj08awrA8nNF4wPJvrrjZNNy0vNkUqgW2jgBsd30A5o6v2LGk1E1880AG
         cUyKSmjqEk9sfp4hd7ai3/xY7qEIH6iKb3QhgI+CIoelk9Zn1DMHdfh5iu5Ev6F2mukw
         o/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIVTOIopR7ny8mcBhxoHaQP+arorKf3xecWG15pp+jM=;
        b=fTVKVhk9VFLO+8ryu5ccWLAEFK8/PBi0O6eApjXVrkNcxVA6ueY79GMoGQl83VXWpM
         /1hYUZIXe7IWF85Z/ZgrS9wnjwXcVLxelQtWq4FfxxBfWQoheEkeo1/etegMgUp7/Z5C
         Thi6/6BPNQFExRbX5tqz5W5HGvkBAqhMPhGNGevj6jgX7KPMkC1TDIYdbexLHwmQ0prs
         o1iBF+xLGNFtJuCBU5l39J0P13H3oOpzdzOV7G7AToov+2HjEFVQAFU+wRKFOWL24MlP
         Krv9SWxHUHLH/3SzJRffQ3vdOKLaFpCd6yxmQS++JFnNARxTclmrMxAC8b41MGxlsV0X
         ld1A==
X-Gm-Message-State: ANoB5pnEjpDysCjwaVlhscHK/o9Nj0JQjw+5RxfHI+gVQiVqipXrKIKG
        EWh02XaOrl1mO9Tey4EmkgvMCw==
X-Google-Smtp-Source: AA0mqf4TeeujeK7g7Ukb5t7AN0/Qzgr/psCWg0qZdf/wnN6uNbR5ryi28sAc6N7an4/szN0P7dmdqQ==
X-Received: by 2002:adf:dd51:0:b0:242:17a6:8bad with SMTP id u17-20020adfdd51000000b0024217a68badmr11838383wrm.60.1670922597306;
        Tue, 13 Dec 2022 01:09:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d8-20020a5d5388000000b0024258722a7fsm11022984wrv.37.2022.12.13.01.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:09:56 -0800 (PST)
Message-ID: <68cf70aa-ec3b-6a90-f2b1-865275bb20ab@linaro.org>
Date:   Tue, 13 Dec 2022 10:09:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: Signed-off-by missing for commit in the thermal tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221213084838.33d6678c@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221213084838.33d6678c@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 22:48, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    c64c9a768c09 ("Revert "thermal/sysfs: Remove unnecessary check in trip_point_hyst_show()"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits (and change the code) and so need Signed-off-by tags.

Fixed, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

