Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04C46D33F7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDAUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDAUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:52:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668D42B0C6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:51:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so15895098wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680382317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMEGkXCvg7/CGHXH3d3dGgGNTGrxC2XQcGrgCdNoPME=;
        b=R8Q8NOGOSVBDe/QebqkipZUS+N88Rq/PBjCw4V7x/npzW3GwFWca0J2gO+EdlzOlbi
         efbPSkdAr/+lXSXG9Op9JcPpF1kHBXl8XFM7Bf8FWrs/0EjTwmAElts0Nj9blrIbgVHv
         LMM25G5bwhfh9ADPFG52cABNRf5Las7c6ztSwlxI9Bx5PE09XkQozcT7gV8zQOvWt3qU
         SdxwY9RfYT29A9RkeyPqe4wjuNoaZ20Raqxz5hAjrViECDSivs3UZk55XmXDAfrF6tV9
         b4F7vjA581/JK94Ug3QDvV6gP/akEAIh9x84ZrEVjj+5nfuyozadiyQ/cdR+h6RlaRkT
         C5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMEGkXCvg7/CGHXH3d3dGgGNTGrxC2XQcGrgCdNoPME=;
        b=CLkHsTeqq/nxtkwfxZ5qlM8DRs8g98A04yUHOCk13LVUbla7BvdHiy3dOhY2YaZK/3
         tcVO+D7ngdRJKDeGD8N6RSGmRO6BQ0EF68wi0ANhB7jFjhPPu1oAfSt4XoI5JMv6R0IH
         uf6xy9vBuaxonYQYuygGG4Sr+UImHQy//1oGH3lLDQPFvjhsgv0gZ+HNm7RoqwdCU8FN
         U0GE/DxSqsYJ0rAp2fmSyhYXhsI49QIfXQHHC9f2Rg00okht2PPKDciCdtpkMp4XZPEr
         rlxdxTtYwF1fBGr29yylUN5/BHrosXJXxSEkAQ0TBXyyNn8H33z0DGwsHgWw10QhWgP3
         H+1w==
X-Gm-Message-State: AO0yUKVezKQwQlkdxuneExUZ/vBVSNNLt4ccRipQ0KukhFoqctwXC0nU
        cg2+ZYAw37RRMVq2NltsPCoKRIS3QjC01UU/4EM=
X-Google-Smtp-Source: AK7set99TkACr0I2jVXwkGkUioKzfXxq2WJuqXn9pqAYA/4kbGZCzC8In0m4IIw4vt8k4LjpmeVgRw==
X-Received: by 2002:a7b:cb93:0:b0:3ee:814b:9c39 with SMTP id m19-20020a7bcb93000000b003ee814b9c39mr23073849wmi.18.1680382317297;
        Sat, 01 Apr 2023 13:51:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm14298909wmq.19.2023.04.01.13.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:51:56 -0700 (PDT)
Message-ID: <0a86d734-000e-560b-8f47-1c0a113c01ee@linaro.org>
Date:   Sat, 1 Apr 2023 22:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain
 for mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-3-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307154524.118541-3-bchihi@baylibre.com>
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

On 07/03/2023 16:45, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add MT8195 AP Domain support to LVTS Driver.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---

Applied, thanks

Changed the commit log to reflect the comments change

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

