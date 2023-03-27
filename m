Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB46C9C60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC0HjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjC0HjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:39:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBC272D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:38:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so2452688wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902717;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bdQygMFSojhHb9UzbfT0qfrW0CvIqYBKB4dBbixr0z0=;
        b=RAroFrR01Ww0lG+ExefIhmrjcnwgID6UKNSOmMxf7UwU5EMjZkj++Usuz99rkqjoeb
         xeTSiWVzh5lUNo30rwi2Fewo82ErgX2B3g2isj4zC3ZLAvSPZmtJlBsxJp4rcUjQF9wA
         PYCPDlkk3Dj9GRTDeopubjVWJlQxC9v2zfxMj1u7ebjSqJaVcJJgJaC7U1UjLsTW/jxW
         Jatj9wGvQQwdQsifl6izeD/2QgKFhh+y5xTjP6sD+cXvIFXonTD6G+Wgqr4H4/cZ4ZqC
         zv5QIb0sznIOzRVZ1Dvz/UTlCMtFkFRm5OLDyQJb+hwDIHWpH/l0bz4pSnYERBTZC4XZ
         zdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902717;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdQygMFSojhHb9UzbfT0qfrW0CvIqYBKB4dBbixr0z0=;
        b=3pVxZtoiMpbG8rGbUpK4I1xGK5HNzMyIYF4+Nm4SEEiep0SrPDJ3vXLjvbi1vBaXbH
         /8y1zAlu2EkfKzLCe1LUc9UhY/SKOqr3JLOZRVO/REJ8gc75gyLmBSCsSz27YL10+wJ9
         9JrJMm80kmBwyly6+Cu0DdEl/YkI37ljylkVm9n49XxwAnHjIEw8i0Xbr7YN7FXQ4W8T
         IyFRPqz/+jZEobaTCG9Q9rOC2BzxNtKeFPUeJpMdu35ag2NwdkhlctmSQUKFhX2sXBCS
         5t64ZgL0SjK30PT2mIo0IZkRPWndYU8lF49CTuOsUypRw+Xr6UJfWdPb43zK0XZVLfac
         sBfg==
X-Gm-Message-State: AO0yUKVobev+ajKIPDGijTwoXKVrVfO1fq+nVJcdRvAElGA+oxOqztMl
        IVprlS1S/9J7CUS6SKIsvQ1zxw==
X-Google-Smtp-Source: AK7set+sqDKP0WhKZcIorES5GqH/LBErNInWZwXQtaQi4praEw2pzSfhRkQfrtcDapc68yHrppL9tA==
X-Received: by 2002:a05:600c:2312:b0:3ee:b3bf:5f7c with SMTP id 18-20020a05600c231200b003eeb3bf5f7cmr8585069wmo.23.1679902717268;
        Mon, 27 Mar 2023 00:38:37 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm12738246wmc.17.2023.03.27.00.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:38:36 -0700 (PDT)
Message-ID: <0d9b75ed-5bfe-4389-f4c9-3b990191f3fc@linaro.org>
Date:   Mon, 27 Mar 2023 09:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] dt-bindings: display: boe,tv101wum-nl6: document
 rotation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
 <20230326155425.91181-6-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326155425.91181-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 17:54, Krzysztof Kozlowski wrote:
> Allow 'rotation' property (coming from panel-common.yaml) already used
> in DTS:
> 
>    sc7180-trogdor-quackingstick-r0.dtb: panel@0: 'rotation' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml      | 1 +
>   1 file changed, 1 insertion(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
