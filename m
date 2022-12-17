Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE87264F621
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiLQAYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiLQAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:23:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03482DC9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:18:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so5901647lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WGXs0Da5xeMKOv53CBT3wPoiNkhzYtfmvcyhjfkGc4=;
        b=ZGcE9nGrqhguAbP9ZgQjtsV+NzS0BvGV7bPnxNiFd1T0kTHGUl8R+CxGT0/PwAmMWD
         dgqMz6dZQPF930ADNTZC8iEiPdSgqnPiVwuICNj7bPD/UfB64nTjZjgau/G1f0Yz44hM
         cyyvjuv+rd8qh0t2pAkwKtZn8cdhiIviJKCCV8/dNApRm7ElwcCU+sy8WmVI9XF/m343
         mi8kbWQ0V8KbVRIfTQp/eLHUt/QAhweXPuJZjF9/cg7u2Qdoci1TM9SD9w7+Bt977K6d
         3owduyFzU1ALkWg0Yo2CTv842Av5hXzOhLru504oT2g7USvijOhQeQMGYRj65e/MjkD4
         nlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WGXs0Da5xeMKOv53CBT3wPoiNkhzYtfmvcyhjfkGc4=;
        b=D60NO3O9qePSzSSsr7Y8l+osl0znalihIBtZaRxTm79FFIqlXo0CLpDPkGJYblZTYF
         gtWrbp0H6wKQJt1ynU1MaRGOyUmG2EgSC09nX+R8T0ULHcE7BN5LquZLgmnj+jZ8KaVm
         zK/GB+PWE7PPiTUK3PTQGTdyY1tm5aZxk/XUJIowfHKpU+G65ktFRAj8eDU+FZPguc7U
         7HaxTKRFNHsY0mWh06U3Ato6KEgVmUeZaCuIvWF8E4vuHYWQ/ds8cvFjCQh4uDea8F8N
         X52ZVdpV1gmbVZhFn487ZXIODmnY8b6Zb7oxGwjze7Mz0A49ymhV9SueH+XZa+i3q0oa
         7iuw==
X-Gm-Message-State: ANoB5pkoctQzjrLnGc03tYUOZXsFXye6jChp8v7hqzMz6K0+DZF+XZdM
        rpdvA4RRruEukhtCK03roBczbwcBdK0HNDsA0jg=
X-Google-Smtp-Source: AA0mqf7MHydzXOY/VaQ5lDdSAMyCitjKWYjlgMFw6WL8fMnLgyqqPOOakZk/Gy2ay0rOj2w/DaMHQg==
X-Received: by 2002:a05:6512:2110:b0:4b5:649a:9105 with SMTP id q16-20020a056512211000b004b5649a9105mr8871720lfr.65.1671236309990;
        Fri, 16 Dec 2022 16:18:29 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t28-20020a19dc1c000000b004b5821219fbsm350218lfg.60.2022.12.16.16.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 16:18:29 -0800 (PST)
Message-ID: <f01f19c1-720e-a1dc-4cd1-2682b1202ffa@linaro.org>
Date:   Sat, 17 Dec 2022 02:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] thermal: qcom-spmi-adc5: Suppress probe-deferral error
 message
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Robert Marko <robimarko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216190945.902754-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221216190945.902754-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 21:09, Marijn Suijten wrote:
> Much like 807efb7102e8 ("thermal: qcom-spmi-adc-tm5: suppress
> probe-deferral error message") the ADC5 driver also spams a similar
> probe-deferral error on startup when a channel is not yet available:
> 
>      [    0.343136] qcom-spmi-adc-tm5 1c40000.spmi:pmic@0:adc-tm@3500: get dt data failed: -517
> 
> Suppress it by using dev_err_probe instead, which also takes care of
> storing the message as reason for deferring.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/iio/adc/qcom-spmi-adc5.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

With the prefix fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

