Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688D6F0667
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbjD0NL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0NLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:11:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B430C5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:11:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so6577730a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682601080; x=1685193080;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfGyHH2PfPrfkbPBpy+bAVZIzfzjqiyX4dJ97CEcQ98=;
        b=LGlb7KfKTetaiNx8nq8hjUb0MXHmPINSJwSoqGNA0s+/LSzKxdnYhI1vlWSScecZ9k
         jNMs/WnEx3SxLSdRrSqUdiWJYyDVbdypZvroK8vHQol/hJv9/LwAXhwDWxpXh0XxN/mH
         V8dEvpOp+t2j2gwcHVdgIzEfWLTKRb/5zkwfFmO+PhVBABlH4MI4gTLeis/+ra26SlFg
         OmlHWqbOhIlkRZOU0ImB5gFHzjEElhWaKrnprfQ27U/9Y+TgQkK4J6feEYPHM+Md9XyU
         FaRvhunDRmc2yW0RkkFKYHu8Q3zJcRZIy5R26DwnFWeaLK7qmU20lFOF9+2Pj09ztQyT
         2a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601080; x=1685193080;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfGyHH2PfPrfkbPBpy+bAVZIzfzjqiyX4dJ97CEcQ98=;
        b=f0Jb2ud+43Ucc02UBwOuKbE4svrn3hrDpu1xk6JfJZpNkntUlqOGinbR7hSZtrJDT1
         2DyT/Z0is0aoZMllp8UQ7Mue18coTzBiraEC8mjAoaI+B0rzhOLWioqTtfCgT6mT7sH3
         uCNMaERcxcXsf8WygFwy1ZFyU51Hs78lEtsAxtS8ESKC10fK0mLpw1kEgTUvAEx1Nxhh
         Qq7BslGFJ9KDFQzrwMVZfA4B6oc2XE3SpStyqeek0fHBObWvc4VpC6e9aHoDT9Q/dLxl
         PjaPVTNMwhSrfOpizpj08cWxFLUu3jmJeljBGQ8+C4AGnZOoNLztX8X3wkJ128Yq2nl1
         zcYg==
X-Gm-Message-State: AC+VfDxBW7VynuZLeE+4jGCGszIXkO7sT9NyXGGsdZIJOYY6l5O4tgRO
        HqG9jWZ1zPaq9L5UsX5/VOrr6g==
X-Google-Smtp-Source: ACHHUZ6hVTIRGQCEx219U2/y5EcPf/pvENXLICV19fheSZjd50j2Y4tyz3ajAGBq+d00Ei+IDurZDw==
X-Received: by 2002:a17:906:728e:b0:94e:6eb3:abc4 with SMTP id b14-20020a170906728e00b0094e6eb3abc4mr6184980ejl.4.1682601080416;
        Thu, 27 Apr 2023 06:11:20 -0700 (PDT)
Received: from [172.23.2.82] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090614d500b0094b87711c9fsm9657296ejc.99.2023.04.27.06.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 06:11:20 -0700 (PDT)
Message-ID: <d1850d73-9d92-c0aa-7cf8-bae4c0e4144b@linaro.org>
Date:   Thu, 27 Apr 2023 15:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
Content-Language: en-US
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-6-quic_bjorande@quicinc.com>
 <CAJB8c04ah3YfK2VGxDhHMHK4KVJ7kZQv0b5JfPBu7jOk3mFQRA@mail.gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <CAJB8c04ah3YfK2VGxDhHMHK4KVJ7kZQv0b5JfPBu7jOk3mFQRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 12:33, Bryan O'Donoghue wrote:
> On Tue, Apr 25, 2023 at 4:40 AM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
>>
>> The QMP combo PHY sits in an of_graph connected between the DisplayPort
>> controller and a USB Type-C connector (or possibly a redriver).
>>
>> The TCPM needs to be able to convey the HPD signal to the DisplayPort
>> controller, but no directly link is provided by DeviceTree so the signal
>> needs to "pass through" the QMP combo phy.
>>
>> Handle this by introducing a drm_bridge which upon initialization finds
>> the next bridge (i.e. the usb-c-connector) and chain this together. This
>> way HPD changes in the connector will propagate to the DisplayPort
>> driver.
>>
>> The connector bridge is resolved lazily, as the TCPM is expected to be
>> able to resolve the typec mux and switch at probe time, so the QMP combo
>> phy will probe before the TCPM.
>>
>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index 5d6d6ef3944b..84bc08002537 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/usb/typec.h>
>>   #include <linux/usb/typec_mux.h>
>>
>> +#include <drm/drm_bridge.h>
>> +
>>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>>
>>   #include "phy-qcom-qmp.h"
>> @@ -1332,6 +1334,8 @@ struct qmp_combo {
>>          struct clk_hw dp_link_hw;
>>          struct clk_hw dp_pixel_hw;
>>
>> +       struct drm_bridge bridge;
>> +
>>          struct typec_switch_dev *sw;
>>          enum typec_orientation orientation;
>>   };
>> @@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
>>          return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
>>   }
>>
>> +static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
>> +                                  enum drm_bridge_attach_flags flags)
>> +{
>> +       struct qmp_combo *qmp = container_of(bridge, struct qmp_combo, bridge);
>> +       struct drm_bridge *next_bridge;
>> +
>> +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>> +               return -EINVAL;
>> +
>> +       next_bridge = devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_node, 0, 0);
>> +       if (IS_ERR(next_bridge))
>> +               return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "failed to acquire drm_bridge\n");
>> +
>> +       return drm_bridge_attach(bridge->encoder, next_bridge, bridge, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>> +}
>> +
>> +static const struct drm_bridge_funcs qmp_combo_bridge_funcs = {
>> +       .attach = qmp_combo_bridge_attach,
>> +};
>> +
>> +static int qmp_combo_dp_register_bridge(struct qmp_combo *qmp)
>> +{
>> +       qmp->bridge.funcs = &qmp_combo_bridge_funcs;
>> +       qmp->bridge.of_node = qmp->dev->of_node;
>> +
>> +       return devm_drm_bridge_add(qmp->dev, &qmp->bridge);
>> +}
>> +
>>   static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
>>   {
>>          struct device *dev = qmp->dev;
>> @@ -3459,6 +3491,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>
>> +       ret = qmp_combo_dp_register_bridge(qmp);
>> +       if (ret)
>> +               return ret;

I think the DRM part should be only built if CONFIG_DRM is enabled, I don't
have a strong opinion on this, I think Vinod could help here.

>> +
>>          /* Check for legacy binding with child nodes. */
>>          usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>>          if (usb_np) {
>> --
>> 2.39.2
>>
> 
> You need to add some or all of these
>         select DRM_DISPLAY_DP_HELPER
>         select DRM_DISPLAY_HELPER
>         select DRM_DP_AUX_BUS
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL
> 
> 
> /opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> Unexpected GOT/PLT entries detected!
> /opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> Unexpected run-time procedure linkages detected!
> drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function
> `qmp_combo_bridge_attach':
> phy-qcom-qmp-combo.c:(.text+0xb50): undefined reference to
> `devm_drm_of_get_bridge'
> phy-qcom-qmp-combo.c:(.text+0xb6c): undefined reference to `drm_bridge_attach'
> drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function `qmp_combo_probe':
> phy-qcom-qmp-combo.c:(.text+0x13fc): undefined reference to
> `devm_drm_bridge_add'

I think CONFIG_DRM_PANEL_BRIDGE in addition to CONFIG_DRM. should be enough.

With this config added and my drm-bridge hat:

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil


> 
> ---
> bod

