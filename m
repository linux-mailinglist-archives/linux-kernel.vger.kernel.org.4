Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC86C6B69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCWOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjCWOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:45:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5A2595D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:45:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so20777188wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679582722;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4MzrlpTb4Yhk+gf2dIUjuh7tsdX9/TNDTntW+YKJvQ=;
        b=VNwqpfZrV6vnFmwiRhLKz9jY1Ib2cmBxdbakZRZrHeSHzA9AKpPVstW5bUCEJCE5Dq
         Rprv/C1AYM3gKWrk0hpsmQZpmZMTCBD5Mhd9nkaP6QHffhntf1hkEhmDTI6s/SXZSxho
         6jRUFnSso3D7ypelnHOflwy+xoxZSJo9rcG8mUvDwqMVtb16X1CfTci70fPpd0d5ZMYg
         dv8C2R78hJroZ7ldiETHkKLa9e9Nxxtq0/XEz3SwiugYytzGgyfvtKgcBNCc6kWgnOiD
         KFOtM5WsAYQPvBIsypLEo1OkcmcV1YT/tc0KBwnXhEv9vzn1JPdiWBxzk9AgQTm/NQcg
         pncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582722;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4MzrlpTb4Yhk+gf2dIUjuh7tsdX9/TNDTntW+YKJvQ=;
        b=wgf0hdxlVSzH1QmC+sZYekp+p2hK4MPx0y+P126uvkuHtCdme4QWtqj7NDGusb+C+v
         Uo+f5OgI4lg5Bnwy1oXZN6efZG2MGtHpK13SW48uPRMoZfsz/UQ3C0hwhPz2VcxAufg3
         6WIk32jYQhX9ZkwMRbXJeogQtruxF1XwsJ26VaeyfqWskNWSozHoKCIfs22CmPIGmAwA
         JnC4mdSrIYon0eXPa4APmCQnua7SEHhwxdPwx9uYOxkPcsCzged3mhClzLOvTbKw45Sc
         3vyu5R2j1otT2BEkXInqyW57NBFarnYXJyK6D6dLyGt9lCf9XK7oQa9xDh4pcglIW29W
         fXpw==
X-Gm-Message-State: AAQBX9c0hAUltvNRar2rKn/HjZqroD2q2KB8RWsR1/mII5TDOU9wKFSU
        ZY22OLsMKnvYM+pHlHdq0SYIlg==
X-Google-Smtp-Source: AKy350YwaJwmjXC3UxTKUTSA0ajmbVXL4atAUE52yKdngL+u+dc4euwmiy4LP0GSK7l3dnIU6r4mCw==
X-Received: by 2002:a5d:4d82:0:b0:2db:11f3:f7ee with SMTP id b2-20020a5d4d82000000b002db11f3f7eemr2473114wru.63.1679582721738;
        Thu, 23 Mar 2023 07:45:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e25a:65de:379a:3899? ([2a01:e0a:982:cbb0:e25a:65de:379a:3899])
        by smtp.gmail.com with ESMTPSA id p7-20020a1c5447000000b003dd1bd0b915sm2121364wmi.22.2023.03.23.07.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:45:21 -0700 (PDT)
Message-ID: <d16ebe42-e462-b1dd-0ea3-c368b8721ba5@linaro.org>
Date:   Thu, 23 Mar 2023 15:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/8] dt-bindings: ufs: qcom: document the fact the UFS
 controller can have an ICE core
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Avri Altman <avri.altman@wdc.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Lee Jones <lee@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        freedreno@lists.freedesktop.org
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-3-3ead1e418fe4@linaro.org>
 <167957963115.3095299.4593054829506617284.robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <167957963115.3095299.4593054829506617284.robh@kernel.org>
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

On 23/03/2023 14:58, Rob Herring wrote:
> 
> On Thu, 23 Mar 2023 11:25:18 +0100, Neil Armstrong wrote:
>> Move the qcom,sm8450-ufshc to the right allOf:if allowing the ICE clocks
>> and registers to be specified.
>>
>> Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clocks: [[4294967295, 151], [4294967295, 10], [4294967295, 150], [4294967295, 166], [4294967295, 0], [4294967295, 164], [4294967295, 160], [4294967295, 162]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clock-names: ['core_clk', 'bus_aggr_clk', 'iface_clk', 'core_clk_unipro', 'ref_clk', 'tx_lane0_sync_clk', 'rx_lane0_sync_clk', 'rx_lane1_sync_clk'] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: reg: [[0, 30949376, 0, 12288]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

Same as patch 1, I forgot to fix the example...

Neil

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-3-3ead1e418fe4@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

