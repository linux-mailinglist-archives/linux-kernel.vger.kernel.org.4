Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C23715EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjE3MQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjE3MPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:15:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56F12B;
        Tue, 30 May 2023 05:15:26 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA6186606E94;
        Tue, 30 May 2023 13:15:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685448925;
        bh=4wNEnxY6LQ6QUhnOBO99wgPeevp5yEWOIVnYVgFq2ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K9Xc5p9TKYcf8khiFK1yY4EMlDkotGT1R4P4TK35EuA84Fs9v/gwwCy3V9jQpBwUb
         tazT0TXpsYhyI+TofjuTvsn7XaigKSBo3YYNoBoeBuGDn/zWOhY+wV9CCFuYchm8DW
         M5tWdBaEnadB6CXH8kqUxo4PmbdNFtvGTtiMFy1MpZ5yU1pkgD3ak0SN8RV0AGx5qE
         De742jKhCiI+Hf4+nj1TNNkSM2bjp6JEzA1maq2nP4wJi0H5TRXkcy3kR6wQr8dSmD
         eaZsGJGQwG78nf5hxCnXw3fUbpekqi8mh++i44zXGbtJhYMphjUNtRpqXSrmF8r4jq
         o3wF1rqlcjfGA==
Message-ID: <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com>
Date:   Tue, 30 May 2023 14:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
 <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 13:44, Dmitry Baryshkov ha scritto:
> On Tue, 30 May 2023 at 10:24, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi Marijn, Dmitry, Caleb, Jessica,
>>
>> On 29/05/2023 23:11, Marijn Suijten wrote:
>>> On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
>>> <snip>
>>>>> +   if (ctx->dsi->dsc) {
>>>>
>>>> dsi->dsc is always set, thus this condition can be dropped.
>>>
>>> I want to leave room for possibly running the panel without DSC (at a
>>> lower resolution/refresh rate, or at higher power consumption if there
>>> is enough BW) by not assigning the pointer, if we get access to panel
>>> documentation: probably one of the magic commands sent in this driver
>>> controls it but we don't know which.
>>
>> I'd like to investigate if DSC should perhaps only be enabled if we
>> run non certain platforms/socs ?
>>
>> I mean, we don't know if the controller supports DSC and those particular
>> DSC parameters so we should probably start adding something like :
>>
>> static drm_dsc_config dsc_params_qcom = {}
>>
>> static const struct of_device_id panel_of_dsc_params[] = {
>>          { .compatible = "qcom,sm8150", , .data = &dsc_params_qcom },
>>          { .compatible = "qcom,sm8250", , .data = &dsc_params_qcom },
>>          { .compatible = "qcom,sm8350", , .data = &dsc_params_qcom },
>>          { .compatible = "qcom,sm8450", , .data = &dsc_params_qcom },
>> };
> 
> I think this would damage the reusability of the drivers. The panel
> driver does not actually care if the SoC is SM8350, sunxi-something or
> RCar.
> Instead it cares about host capabilities.
> 
> I think instead we should extend mipi_dsi_host:
> 
> #define MIPI_DSI_HOST_MODE_VIDEO BIT(0)
> #define MIPI_DSI_HOST_MODE_CMD  BIT(1)
> #define MIPI_DSI_HOST_VIDEO_SUPPORTS_COMMANDS BIT(2)
> // FIXME: do we need to provide additional caps here ?
> 
> #define MIPI_DSI_DSC_1_1 BIT(0)
> #define MIPI_DSI_DSC_1_2 BIT(1)
> #define MIPI_DSI_DSC_NATIVE_422 BIT(2)
> #define MIPI_DSI_DSC_NATIVE_420 BIT(3)
> #define MIPI_DSI_DSC_FRAC_BPP BIT(4)
> // etc.
> 
> struct mipi_dsi_host {
>   // new fields only
>    unsigned long mode_flags;
>    unsigned long dsc_flags;
> };
> 
> Then the panel driver can adapt itself to the host capabilities and
> (possibly) select one of the internally supported DSC profiles.
> 

I completely agree about extending mipi_dsi_host, other SoCs could reuse that and
support for DSC panels would become a lot cleaner.

For example, on MediaTek DRM there's some support for DSC, more or less the same
for SPRD DRM and some DSI bridge drivers... having a clean infrastructure would
definitely help.

I'm sad I cannot offer testing in that case because despite being sure that there
are MTK smartphones around with DSI panels using DSC, I have none... and all of the
Chromebooks are not using DSC anyway (but using DisplayPort compression, which is
obviously an entirely different beast).

>>
>> ...
>> static int sony_akatsuki_lgd_probe(struct mipi_dsi_device *dsi)
>> ...
>>          const struct of_device_id *match;
>>
>> ...
>>          match = of_match_node(panel_of_dsc_params, of_root);
>>          if (match && match->data) {
>>                  dsi->dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);
>>                  memcpy(dsi->dsc, match->data, sizeof(*dsc));
>>          } else {
>>                  dev_warn(&dsi->dev, "DSI controller is not marked as supporting DSC\n");
>>          }
>> ...
>> }
>>
>> and probably bail out if it's a DSC only panel.
>>

Usually DDICs support both DSC and non-DSC modes, depending on the initial
programming (read: init commands)... but the usual issue is that many DDICs
are not publicly documented for reasons, so yes, bailing out if DSC is not
supported would be the only option, and would be fine at this point.

Cheers,
Angelo

>> We could alternatively match on the DSI controller's dsi->host->dev instead of the SoC root compatible.
>>
>> Neil
> 

