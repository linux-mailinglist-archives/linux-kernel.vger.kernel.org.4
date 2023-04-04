Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B206D6AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjDDRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDDRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:47:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65401997
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:46:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so43396075lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680630418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RV8KrH+fxSPgZ9OjX7icc1BadpyWNvC86iBDQVaMJIw=;
        b=PF0HhkOk1Uv3kOWGXyl9mSqxdS6YA/N/87vyRBGC8x0cWncMBVXKnymFCqGj29/kvK
         sdHDCgf6z/dL33PG2pULxshilFIsUSBrNq8fOVGAInoa6ecOPkLxTTMttgBgmU75EYxk
         2gOXZNOgDPZoHhaS2sL/JKOm2w2xDBNcJUqBbfmRy6IL7nTlbYLWU+ZYLRP0EryMttQb
         GrZd56HPmYBLzWNokynUlaGhraYj51PkTUqIjpKuHhbIowgsgSNMd9xV29mLvJftRto2
         sak0v7kxMlgchEVRm62YYd1IABuCB8F+F/zHmjAMfgi90suEk1MqTbaEr7nYNhIuqhKW
         yQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV8KrH+fxSPgZ9OjX7icc1BadpyWNvC86iBDQVaMJIw=;
        b=es8AVMKF4IipVnJDI5aeknelpVdM/f9dAMDJJJh7LAGKVKjyno57KbeLtLFowWPu/7
         KaWCpXPwXUXZcRFrNdtu4lORpLW927SikbHx0AbtUSJjMP9KojBhW8oho0k//YjdyDmc
         /yz6RCACCDSLXTSAdp6ExMOX5gHSzOAKBg2wt6XaFtvXM1AFABcrIjK8V1w0q49nJY/L
         TsTuA/+zRFN6/NWMZFd0O1I2y4TLnrve2n7JKmFHC1YwfvMs2thGHmLIAywGo+jiE5Ls
         HshqSKStsbDIeR1w4RsCexJQTR6S6rBDymPBHx7Fvbr1kg0krcjkWXOiXBGL/RJgSEsi
         fwlA==
X-Gm-Message-State: AAQBX9eVUE5lc3T90hMbs6mvS9TC6EPIA0pQhwGRnEe/rMliTJLCz6Rv
        YDz9VEz5+qMmFIVreO+ONuRzgA==
X-Google-Smtp-Source: AKy350Y//L+R1u3wX768xf8NTmn0Rca5PKXcaK0O6VJ1OXoOIzxJG+SoZD9d2tEHSjpyL0iqt7Ozpg==
X-Received: by 2002:ac2:4191:0:b0:4e9:a16f:a176 with SMTP id z17-20020ac24191000000b004e9a16fa176mr738208lfh.36.1680630418051;
        Tue, 04 Apr 2023 10:46:58 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004e7fa99f3f4sm2420351lfm.265.2023.04.04.10.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 10:46:57 -0700 (PDT)
Message-ID: <6a937870-af8c-95fb-1ac3-68e9eb2cbf27@linaro.org>
Date:   Tue, 4 Apr 2023 19:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 23:11, Douglas Anderson wrote:
> Developers on the ChromeOS team generally want to be notified to
> review changes that affect Chromebook device tree files. While we
> could individually add developers, the set of developers and the time
> each one has available to review patches will change over time. Let's
> try adding a group list as a reviewer and see if that's an effective
> way to manage things.
> 
> A few notes:
> * Though this email address is actually backed by a mailing list, I'm
>   adding it as "R"eviewer and not "L"ist since it's not a publicly
>   readable mailing list and it's intended just to have a few people on
>   it. This also hopefully conveys a little more responisbility for the
>   people that are part of this group.
> * I've added all sc7180 and sc7280 files here. At the moment I'm not
>   aware of any non-Chromebooks being supported that use these
>   chips. If later something shows up then we can try to narrow down.
IMO it'd be good if you could keep an eye on all of them, especially
with the quite numerous ways that CrOS fw differs! You're the main
users of the SC7xxx SoCs so it only sounds logical.

> * I've added "sdm845-cheza" to this list but not the rest of
>   "sdm845". Cheza never shipped but some developers still find the old
>   developer boards useful and thus it continues to get minimal
>   maintenance. Most sdm845 device tree work, however, seems to be for
>   non-Chromebooks.
Seems to also still be used in mesa CI

> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..b4e9c5bda234 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2604,6 +2604,12 @@ F:	include/dt-bindings/*/qcom*
>  F:	include/linux/*/qcom*
>  F:	include/linux/soc/qcom/
>  
> +ARM/QUALCOMM CHROMEBOOK SUPPORT
> +R:	cros-qcom-dts-watchers@chromium.org
> +F:	arch/arm64/boot/dts/qcom/sc7180*
> +F:	arch/arm64/boot/dts/qcom/sc7280*
> +F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
> +
>  ARM/RDA MICRO ARCHITECTURE
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
