Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FAE5E793F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiIWLQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIWLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:16:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7376135724
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:16:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w8so19245292lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WVY444sgVZKK+vY4euROZT7RCJrRWYm0QFkYeu7q07A=;
        b=GKMyIrG6A6lX/rlrp3TOcU57GiknL+XUxrwfFH/f1akM2DMNy87i4OzM4NX7/XMkx6
         YED9kf6T+9gIhaeTEvZV+unwNBINlTjTsSqf2qWUseD54NmeKDo0INP/1Keu+uqeLBde
         7HicySAx8BM4kdf9ajk0c3LTUdsD6KOhzZW5aUW8Gev6L2UsDUsVcGiOYquJNPz5viII
         kElCm//hSG38MLMDhotwtKhqhhQY5O35ZU45cuzNbI25thZnSm5XBk5JPw7AmCLeHiGH
         OduCbQp04LfBpS0Vetf0LjQoeLTXfjh3hCbVovgepaPCOoCmBjut3+go3MlEosTHYK//
         c7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WVY444sgVZKK+vY4euROZT7RCJrRWYm0QFkYeu7q07A=;
        b=WG0hb9mmTYMCeNulL7rcvYGoekAEvUDEMHCkob7UDb+DjBAqf28wCYuxc+6w7fHtou
         Xl7E/I0RdlrZJLJu0sqCLRKD8YYqkFdk56j3tcp+89W5mIbj9kUfdsPx7WtzjueoTqpb
         oO8qbq8CR2zOLjyTnVwPbFqRF1LLAxJ8KPoJ2OomUOS1zieeQba6WHqy4QCfdYJcPm2v
         2whrx1a4NaETynmfylygMVuBblbP5nigMA6AdZ6VFeJ2bZnDxpO7jUYgeoCNGOeozqc1
         DMWomRXU85C47qMTku3aBKgrh5Xwv3cw2HgOBBh6XMjVNzwNGzFRZsDfnE6fVQfUt9mK
         BHZA==
X-Gm-Message-State: ACrzQf3L11ZyMikVfpBDHLE1VfgXnycubdpY8DyLcoYSURZsh7amwdJA
        YIhKBomV1/9ogAnOIrFTna+kyg==
X-Google-Smtp-Source: AMsMyM6ZqgtGE6YGi5NHqU38FwIKEP5Y636y2wBc6bsb7FGrQUA/VEzL6pvHiLgIjd3Bhg+MjURUzg==
X-Received: by 2002:a05:6512:3c92:b0:499:a1ff:d6f3 with SMTP id h18-20020a0565123c9200b00499a1ffd6f3mr3099204lfv.153.1663931796319;
        Fri, 23 Sep 2022 04:16:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id du12-20020a056512298c00b004946a1e045fsm1399245lfb.197.2022.09.23.04.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:16:35 -0700 (PDT)
Message-ID: <f6e669dd-f2cf-6e3f-18bb-25b21e5eab0c@linaro.org>
Date:   Fri, 23 Sep 2022 13:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: display: mediatek: dp: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     liangxu.xu@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220923013953.5043-1-liangxu.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923013953.5043-1-liangxu.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 03:39, liangxu.xu@mediatek.com wrote:
> From: liangxu xu <liangxu.xu@mediatek.com>
> 
> Add dt-binding documentation of dp for MediaTek MT8188 SoC.
> 
> Signed-off-by: liangxu xu <liangxu.xu@mediatek.com>
> ---

Where is the DTS? Where are driver changes?

Best regards,
Krzysztof

