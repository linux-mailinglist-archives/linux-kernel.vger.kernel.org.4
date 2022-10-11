Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C735FB417
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJKOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJKOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:05:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8098F97F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:05:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r22so15647755ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vXGY2FQD0SmjquwVrvQMgguyJMrvlVrQ9GO3c0qOHM=;
        b=HkGuYtt/EZyPyD9ckg/JYMMda1MAxj0DBMlo/GDBvLTh3AKZ7WW2AIkLAx0b+E/8br
         zUila7U6c1voNoKmeB+k85RHDCck5geZ9Tx18LMvkMKwqQ2d0yvwogHPyM4IsUWYERAB
         jcJNGedzyPu8tGWv0hhkQyEbWFM2k/yQY3H6bmvu7G3OGz5Gjl3f0Yo0R7J7HD4yOshm
         BJ7alVpacFwCVTdysKBTTLNZ1XyeHKVd3TBn1Z9UudF2qMUguj75BP96/WL6Gfq8Y50j
         PRgMY6eIhEnAl4qYHU1JPFFAH4JaXu3R3IJIySTW0XEgLI8M0JdCaBLYzzshr8rCAKd7
         cVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vXGY2FQD0SmjquwVrvQMgguyJMrvlVrQ9GO3c0qOHM=;
        b=K5gCEkC+LnSzCql/0MijjCff+A2E05Csfldz5zts28su+2iS3v9V4FepUNpNx52RnC
         lkqGD2e+/QtKVq38I8ZtJaOw1bIROhN7lXwdprJiaCOPcauZpdr0CnkNhgwSBhYw6PT/
         AQNFiPbHPtm6V+1rAr9Y0be0kWALiDW9+dK5TLPj8qgFzfrwEquG59dV3cAaemAuO1J8
         AC8QinquayM815KKEGn79GkNfYJA9qGnlR/ifq7mKXG0pin+SqZoqABHQvcpWDoK0jk/
         bJRs6fTxPui8byNzBIHyggkWTWXSEV2ssaobehWg32TY9ILpTc1jCz9HTbYxCKTJACFF
         uqCw==
X-Gm-Message-State: ACrzQf3++tl7POsKWvFY3NFklgj6Ygmp/egP0dX49iijHNme8NfvdI8X
        ts8l1uzMdvAHdW1zgoaLcdpSTg==
X-Google-Smtp-Source: AMsMyM4oVTsQAm4QAWtn9JgMcWAYzDKMUyCQcIEkLooLNkHTIKRbbJ5kAke70XfECNOILD6oPqQJAQ==
X-Received: by 2002:a05:651c:158e:b0:26b:46a6:bf63 with SMTP id h14-20020a05651c158e00b0026b46a6bf63mr8530052ljq.21.1665497147910;
        Tue, 11 Oct 2022 07:05:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2514b000000b0049f54c5f2a4sm1868188lfd.229.2022.10.11.07.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:05:47 -0700 (PDT)
Message-ID: <236ee060-4001-992b-a1ee-b40c66fb94eb@linaro.org>
Date:   Tue, 11 Oct 2022 17:05:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 13/13] phy: qcom-qmp-usb: drop power-down delay config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The power-down delay was included in the first version of the QMP driver
> as an optional delay after powering on the PHY (using
> POWER_DOWN_CONTROL) and just before starting it. Later changes modified
> this sequence by powering on before initialising the PHY, but the
> optional delay stayed where it was (i.e. before starting the PHY).
> 
> The vendor driver does not use a delay before starting the PHY and this
> is likely not needed on any platform unless there is a corresponding
> delay in the vendor kernel init sequence tables (i.e. in devicetree).
> 
> Let's keep the delay for now, but drop the redundant delay period
> configuration while increasing the unnecessarily low timer slack
> somewhat.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 35 +------------------------
>   1 file changed, 1 insertion(+), 34 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

