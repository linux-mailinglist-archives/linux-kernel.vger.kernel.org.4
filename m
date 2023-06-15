Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79B7314F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbjFOKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbjFOKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:12:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5842710
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:12:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8d0e814dfso15039265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686823945; x=1689415945;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zz9EX+Ta4PloLk34RJ2hnXK/x9oTdPVOw0dFQbZy70I=;
        b=frDkKppf7lZoIiLPcx/27B7RgHBKXqgtzlP/rh77BLFE3SROa9LxxSjX0hYVsi93Eh
         pihQ2Zb5eyq7gMv33tbGJsRj+Qug3TvDMAJx+xdvCazTNVcRub4Ku3T2MqOG/t9CJ4VA
         BGlhoRaR5ctRw9tEmpJZ2DsMImtcr2nxcf6TtacCV71di92Q2LJrLGygNFVjKwT2SuCf
         2AMISPslSoznjAM6va9T7YngkUzSBuU6lJUPjNsasWZUiKvG6RFDdYYIxyDVbOOE86f0
         VowdSZaUy1Yp2rGYAOwJLEtpaJ+JYGdGN0MqOMnuQxxPUpY4ckofRlcherP+O8FWZeYw
         Vy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823945; x=1689415945;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zz9EX+Ta4PloLk34RJ2hnXK/x9oTdPVOw0dFQbZy70I=;
        b=lG1x8bGFSyO1iDE0YvCRMAhqMJPObmVDbx0bViz4uwbSTXOxBIMKMduREqvRnaYXwM
         1XzVBO6AIqqUoOM/ggrVLrLFF34Gpls0V2YlF7JsWKRax943IHZeK21ikgayh2sVm/uV
         3RtfZAvv8doLsl2uNl5m2QawJgIq1RJnbaAJeCocowO0iycZtXJaiqQOsLzeMhat9uTb
         63NR5/Qo1tyq8E1R49OTurpOXP3pOv2GQnb6zoxLe32mc2vFnlcaw5p/tpMQHbgu1Vml
         JALQ9DTajayR3dJ1TJBh/CVB/iEikNZgurypQmAL6UsEBn/rlgyLQXW175/tlZ6Zirs+
         N0lA==
X-Gm-Message-State: AC+VfDxDcyu33zpSmioml1H2wq7S8E9cEJzMTQAJd7hwQyqTQHZIg5La
        /va+CMo5BLOxdwUrrLgTygA5vg==
X-Google-Smtp-Source: ACHHUZ6cP3h9pbkk+CWbJrI5Giw2RTOJdpJN7rRK57+WSwcGuPKNLwcuav9AADz+5ttsuona8PGN8g==
X-Received: by 2002:a5d:6442:0:b0:311:d35:e23f with SMTP id d2-20020a5d6442000000b003110d35e23fmr2990366wrw.27.1686823945596;
        Thu, 15 Jun 2023 03:12:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f60a:f5e3:7ae:6745? ([2a01:e0a:982:cbb0:f60a:f5e3:7ae:6745])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b0030fb828511csm13974283wrt.100.2023.06.15.03.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:12:25 -0700 (PDT)
Message-ID: <44ebcc5e-d424-0e5f-1384-19397a0c36ae@linaro.org>
Date:   Thu, 15 Jun 2023 12:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org>
 <20230601-topic-sm8x50-upstream-redriver-v3-2-988c560e2195@linaro.org>
 <2023061514-wager-iphone-cf71@gregkh>
Organization: Linaro Developer Services
Subject: Re: [PATCH v3 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
In-Reply-To: <2023061514-wager-iphone-cf71@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 11:47, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 04:50:08PM +0200, neil.armstrong@linaro.org wrote:
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
>> and DisplayPort ALT Mode Linear Redriver chip found on some devices
>> with a Type-C port.
>>
>> The redriver compensates ultra High-Speeed DisplayPort and USB
>> Super Speed signal integrity losses mainly due to PCB & transmission
>> cables.
>>
>> The redriver doesn't support SuperSpeed lines swapping, but
>> can support Type-C SBU lines swapping.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/typec/mux/Kconfig      |   8 +
>>   drivers/usb/typec/mux/Makefile     |   1 +
>>   drivers/usb/typec/mux/nb7vpq904m.c | 529 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 538 insertions(+)
> 
> I get the following build error on my system with this applied:
> 
>    CC [M]  drivers/usb/typec/mux/nb7vpq904m.o
> drivers/usb/typec/mux/nb7vpq904m.c: In function ‘nb7vpq904m_register_bridge’:
> drivers/usb/typec/mux/nb7vpq904m.c:327:20: error: ‘struct drm_bridge’ has no member named ‘of_node’
>    327 |         nb7->bridge.of_node = nb7->client->dev.of_node;
>        |                    ^
> 
> 
> What went wrong?

DRM bridge attach should be protected by #ifdef CONFIG_OF aswell, I'll send a v4 with such fix.

Thanks for the report,
Neil
> 
> thanks,
> 
> greg k-h

