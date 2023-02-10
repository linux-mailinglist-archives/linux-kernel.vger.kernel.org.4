Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137366920A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBJOSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBJOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:18:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCD305C6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:18:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso4160109wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7gCIwjkW4mj7GEg4UX9SIJbxJsdVXdDoLdVX95U4ZAQ=;
        b=M3meFAUZgc4u9VSgIMNLyini72JXil8R3ReEZy3l+Bsoz3c0UwpsB/hKm305UETshl
         MFQBDze7HK6wxEUG3/dRu4ElC+I/uF/VMx85M6FQ+K7hIrO0Lz0zxK8YQR4mCn5anGM7
         4hS/z/LBg0+KBiiBbqhBBvbBlQCQLkq6jNqKEGxoeOFy9FQl8s+vIzIcFL4L0rKP6wOb
         COEn8tIf5vKXfMct526CvjCQJcmRUdgMV6NoLT8GlJSWdGmzfVEkWWdkSFp0UOTuck0P
         17snSHuLRHQfzAvzxd2EKyT8S5OAmaLZjAFHzsoQsH/HeMZnRo6o6GRFdIZ3F3gTDleS
         QoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gCIwjkW4mj7GEg4UX9SIJbxJsdVXdDoLdVX95U4ZAQ=;
        b=Hs8ZUmTg6h5rTr2dQ7JPZGN7TjWDg7WiwmZ4JhfdUiRSTdAoX8D2pB7nZadONapA6v
         0tEzpijWGi/p/E8LW0YO8BvnWbt6ZtEwva1bRV9xZWc83D+VcIZj+b55KXsXMCOgpGCS
         YuHBfKdahutq9HOHhnGD/DBglEPT/uXZDoU+z/TmcU1d/3/BC0TMOrVfFJKwy0kSeqss
         b8QNkoy5aj+QWT5oucpiOdLBuSfN8b6LUTuvJVk+WaKxQ9pIFhj2xD6CpPg1dKFMzdk+
         dgLdxND6X/iFfMM4BMgxpq+ei2zX+NF/esEo0vQ/5NkwJ/r08v6MKjqxHBoOZ6WoGU9m
         zg/Q==
X-Gm-Message-State: AO0yUKXmCGnRJ+NJcfNT4qgmqey2N6I5z/MzLewWAnSyjdExlrdVhWzP
        Oy+qHRESCmnNjtUy3kfk2z706Q==
X-Google-Smtp-Source: AK7set+T/gE/eEuVsE9zQ3Jy0gI89TK3IKOAoZY4Znv+SjSwr9woOUaDXg3eq8Dj9gXBQxyJoubVBg==
X-Received: by 2002:a05:600c:1684:b0:3dc:52fc:7f06 with SMTP id k4-20020a05600c168400b003dc52fc7f06mr12894199wmn.41.1676038683509;
        Fri, 10 Feb 2023 06:18:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a65:5553:55cf:3027? ([2a01:e0a:982:cbb0:5a65:5553:55cf:3027])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b003dd1bd0b915sm8173477wms.22.2023.02.10.06.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:18:02 -0800 (PST)
Message-ID: <37d23af4-7920-055f-76b0-87ad907896e2@linaro.org>
Date:   Fri, 10 Feb 2023 15:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sm8350: add dp controller
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v2-3-529da2203659@linaro.org>
 <df068428-c086-4f6a-3cda-9ef6ce665f13@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <df068428-c086-4f6a-3cda-9ef6ce665f13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 12:08, Dmitry Baryshkov wrote:
> On 10/02/2023 12:34, Neil Armstrong wrote:
>> Add the Display Port controller subnode to the MDSS node.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 82 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index d490ce84a022..eb636b7dffa7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -2862,13 +2862,20 @@ ports {
>>                       port@0 {
>>                           reg = <0>;
>> -                        dpu_intf1_out: endpoint {
>> -                            remote-endpoint = <&mdss_dsi0_in>;
>> +                        dpu_intf0_out: endpoint {
>> +                            remote-endpoint = <&mdss_dp_in>;
> 
> No need to reorder these ports. Please add DP to the end.

Right, but I'll keep the dpu_intf0_out label for this port,
but having dpu_intf1_out, dpu_intf2_out then dpu_intf0_out isn't very clean...

> 
>>                           };
>>                       };
>>                       port@1 {
>>                           reg = <1>;
>> +                        dpu_intf1_out: endpoint {
>> +                            remote-endpoint = <&mdss_dsi0_in>;
>> +                        };
>> +                    };
>> +
>> +                    port@2 {
>> +                        reg = <2>;
>>                           dpu_intf2_out: endpoint {
>>                               remote-endpoint = <&mdss_dsi1_in>;
>>                           };
>> @@ -2876,6 +2883,77 @@ dpu_intf2_out: endpoint {
>>                   };
>>               };
>> +            mdss_dp: displayport-controller@ae90000 {
>> +                compatible = "qcom,sm8350-dp";
>> +                reg = <0 0xae90000 0 0x200>,
>> +                      <0 0xae90200 0 0x200>,
>> +                      <0 0xae90400 0 0x600>,
>> +                      <0 0xae91000 0 0x400>;
> 
> This will not validate against the schema. Please add p1 region at the end (I assume it is <0 0x0ae91400 0 0x400>).
> 
>> +                interrupt-parent = <&mdss>;
>> +                interrupts = <12>;
>> +                clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
>> +                clock-names = "core_iface",
>> +                          "core_aux",
>> +                          "ctrl_link",
>> +                                  "ctrl_link_iface",
>> +                          "stream_pixel";
>> +
>> +                assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
>> +                          <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
>> +                assigned-clock-parents = <&usb_1_qmpphy 1>,
>> +                             <&usb_1_qmpphy 2>;
> 
> Please use defined names here and in the phys below

Ack, will do in all the patches

> 
>> +
>> +                phys = <&usb_1_qmpphy 1>;
>> +                    phy-names = "dp";
>> +
>> +                    #sound-dai-cells = <0>;
>> +
>> +                operating-points-v2 = <&dp_opp_table>;
>> +                power-domains = <&rpmhpd SM8350_MMCX>;
>> +
>> +                status = "disabled";
>> +
>> +                ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                        reg = <0>;
>> +                        mdss_dp_in: endpoint {
>> +                            remote-endpoint = <&dpu_intf0_out>;
>> +                        };
>> +                    };
>> +                };
>> +
>> +                dp_opp_table: opp-table {
>> +                    compatible = "operating-points-v2";
>> +
>> +                    opp-160000000 {
>> +                        opp-hz = /bits/ 64 <160000000>;
>> +                        required-opps = <&rpmhpd_opp_low_svs>;
>> +                    };
>> +
>> +                    opp-270000000 {
>> +                        opp-hz = /bits/ 64 <270000000>;
>> +                        required-opps = <&rpmhpd_opp_svs>;
>> +                    };
>> +
>> +                    opp-540000000 {
>> +                        opp-hz = /bits/ 64 <540000000>;
>> +                        required-opps = <&rpmhpd_opp_svs_l1>;
>> +                    };
>> +
>> +                    opp-810000000 {
>> +                        opp-hz = /bits/ 64 <810000000>;
>> +                        required-opps = <&rpmhpd_opp_nom>;
>> +                    };
>> +                };
>> +            };
>> +
>>               mdss_dsi0: dsi@ae94000 {
>>                   compatible = "qcom,sm8350-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>>                   reg = <0 0x0ae94000 0 0x400>;
>>
> 

