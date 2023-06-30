Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8D7438AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjF3Jt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjF3JtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:49:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F6A130
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 02:49:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311367a3e12so1971810f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688118538; x=1690710538;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H4WQ9WREDHQhAsmqGkRKXbmJuG4yjOsaqLYYuWGFXmY=;
        b=tcSpLJjf+PpJ5MEq3gPHXnVE8L7ukgZ54W9nsdSu0t1/xoz5P3hHN8lNW5t6EXtMYB
         flGF1Ys6F3XhKPltK8MLq+T2KI8DFbojJsODSEy7LR3xSMwNVPlOGA1QYQqa8x1aVmiq
         AF+YeJt/nF2VrT3RwLUHU+4WNgkyy0HCCfKX0QDTC2UpcF7Ckq13sq3LvfuhcVNKKW8a
         48Tv4byu6Ha8F+UIGWzD/c2leLPZgH/N+oRnM6+wQKJXuGpwB2T2BkInHbpHrRwg3pwi
         ex/nFbNk4zOOcBJKrgmZE0XIqQV3XK7TATgRrVfnPx90oMlXb45wKHs3XRAGg1d2xo6U
         QgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688118538; x=1690710538;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4WQ9WREDHQhAsmqGkRKXbmJuG4yjOsaqLYYuWGFXmY=;
        b=LDDAhgioCpGWo2yF1hIESZKrFQe/SAnaHl1vPOGVgfuWCS1KSX31P8Z60BKsO0e2tf
         Qp31DdRRZWi99mO94ct1cwD51vSkoy/boHfUi/6OY9o/re0ZSKANSvji51ZQ3mlexPqz
         ZbZLQXIpPgWT7MkQW3kIq3zRMsMEsWGktu/+cMGW5PXN19BOVOUz6SiMjQTRVLWxNhzV
         B03EIyzcegtmC7VZq+JnqCqiX5ljjCEgIpLQRPuw9Fki0NeJoVb3cZe587xhNiVDF5n2
         GWrjeU8S1w9DIYcmPnTGjx6XUuMpBFigUrKgx+dTY7PIBW5D49cI1w3y1k73MU/KzKFh
         bCCw==
X-Gm-Message-State: ABy/qLaP20QnmmtZRsy4plnvS61K8J3H6bGOp7xMj/IK2pYpAY1szx/z
        9Rw5QFpDdWtyZiuxiwphH+mp1g==
X-Google-Smtp-Source: APBJJlFvTKZ4bkmolzJ3455GDbomTlZGe4QENj/1fv8bZ9cgiNj7j6ATNRV5pCkYYZdlV9+3eG2Bsg==
X-Received: by 2002:a5d:550b:0:b0:314:216:578f with SMTP id b11-20020a5d550b000000b003140216578fmr1639262wrv.18.1688118538528;
        Fri, 30 Jun 2023 02:48:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2? ([2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b0030ae3a6be4asm17944860wrl.72.2023.06.30.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 02:48:57 -0700 (PDT)
Message-ID: <618c66ef-74e2-0602-589c-586789c8530b@linaro.org>
Date:   Fri, 30 Jun 2023 11:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] Fix up the boe-tv101wum-nl6 panel driver
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 16/06/2023 23:07, Linus Walleij wrote:
> This is two patches fixing things I would normally complain about
> in reviews, but alas I missed this one, so I go in and fix it up
> myself.

The serie doesn't apply cleanly on drm-misc-next.

Thanks,
Neil

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Fix a missed static keyword
> - Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org
> 
> ---
> Linus Walleij (2):
>        drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
>        drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
> 
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2420 ++++++++++++------------
>   1 file changed, 1193 insertions(+), 1227 deletions(-)
> ---
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> change-id: 20230615-fix-boe-tv101wum-nl6-6aa3fab22b44
> 
> Best regards,

