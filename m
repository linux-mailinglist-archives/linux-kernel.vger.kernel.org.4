Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19076712ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjEZVRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjEZVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:17:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF299
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:17:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so12318865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685135828; x=1687727828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTZ2eTIi+dbM8D638/pa8mpVNPNj7JMHBYTJceqIyYw=;
        b=HSdLPH4/oJa1eARDfOrecCl7rMzSudwuX7YbfKpsJepRkJEUTOtE7NAgeK7NmY6Mc+
         QZKj2STMXSR7dTR+WXvkfvrUY66tuDLC4pnXt+BhgIFM48Z2VLWVXHq2vkGCiUeqKkX3
         PCWQg4kIGzNQzpzxIibTFdtRjsv2+E9juaNW7D1xillrtYAGVXkDtQrZaETbUFSpu+aA
         cLLk4s8M22vP8rA4k3RLIWHAyzHV75t74rB83Efu1Y3mA5ZICwRa1krG6HmUXx7IrJ9s
         Ijozp6sNwGxh6UYfnRSPmaONvO5g2eAY68xxO0NplwRJuyHUIy8fqDMlR+Dfp1L4wnb7
         S7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135828; x=1687727828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTZ2eTIi+dbM8D638/pa8mpVNPNj7JMHBYTJceqIyYw=;
        b=HI3iRCUcfB3d5xEz9TqRn8+qK+rJpg0G81h4g1v1YhM/801mFW/cnf65ObvsLfjfV5
         QCDCuCGAXm/sZWT6Nun51DRGYEdy6q/5hGNxvvRPdQr7lvxGbAnmm/tFNrw6nEa3A1BZ
         p5YhGwLAbUaOj5xjRfJDkS/3Xs4hnmdIUovhrRgiid+9oMpbcLPHc5dk5MyLhl3eZNK+
         yOdZ2+sX+es4mD985cFcpTLSSqBpzPqyQftiKCDyxiphkPSXzVHwkWY13Ayk046o73OE
         ax0h/vR29xxot+MLF8hQ4KZCILGPyNwnN4750E1MIw4Gdd9prMSe1+J8TpM5vAI9p+QT
         Ti7A==
X-Gm-Message-State: AC+VfDyvEOX3wPRPpQQBjUBHcwNRLWBVKf2EQc7DDJTNj0iVyTjA1//k
        dArc2yqVYNDJa+z0fdW3kTzfiQ==
X-Google-Smtp-Source: ACHHUZ7mmG08d1oCokGQ0OUOjjya3HeUe1ATW3LFm5q7dy7RvaiKWJRYLkGlsTmSEucp5+EGF0/NZA==
X-Received: by 2002:a05:600c:228c:b0:3f6:1a9:b9db with SMTP id 12-20020a05600c228c00b003f601a9b9dbmr2388250wmf.21.1685135828039;
        Fri, 26 May 2023 14:17:08 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d49cb000000b0030732d6e104sm6187025wrs.105.2023.05.26.14.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:17:07 -0700 (PDT)
Message-ID: <7bbbf520-d70f-5df6-33ce-a888bf364aa5@linaro.org>
Date:   Fri, 26 May 2023 22:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-4-y.oudjana@protonmail.com>
 <fa395680-0e6c-3eb0-9d5a-f90a95c394b8@linaro.org>
 <e755eabf-f8d7-c2cd-aa5a-bc48c7a5d5ae@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e755eabf-f8d7-c2cd-aa5a-bc48c7a5d5ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 21:57, Konrad Dybcio wrote:
> This code contains a whole bunch of hacky counting logic that should have
> been substituted with _byname, but now we're stuck with indices to keep
> compatibility with old DTs :/
> 
> If CAMSS_GDSC (talking about pre-TITAN hw) was a parent of all the other
> CAMSS-related GDSCs, we could make it their parent in the clock driver
> and call it a day.

I mean, it wouldn't make much sense from a hw design POV if that weren't 
the case..

Hmm looks like its already there.

static struct gdsc vfe0_gdsc = {
         .gdscr = 0x3664,
         .cxcs = (unsigned int []){ 0x36a8 },
         .cxc_count = 1,
         .pd = {
                 .name = "vfe0",
         },
         .parent = &camss_gdsc.pd,
         .pwrsts = PWRSTS_OFF_ON,
};

static struct gdsc vfe1_gdsc = {
         .gdscr = 0x3674,
         .cxcs = (unsigned int []){ 0x36ac },
         .cxc_count = 1,
         .pd = {
                 .name = "vfe1",
         },
         .parent = &camss_gdsc.pd,
         .pwrsts = PWRSTS_OFF_ON,
};

I feel this is probably a problem in the description of dependencies for 
the CSIPHY in the dts for the 8996..

I.e. the CSIPHY requires some clocks and power-rails to be switched on ah..

static const struct resources csiphy_res_8x96[] = {
         /* CSIPHY0 */
         {
                 .regulators = {},
                 .clock = { "top_ahb", "ispif_ahb", "ahb", 
"csiphy0_timer" },


should probably look something like

static const struct resources csiphy_res_8x96[] = {
         /* CSIPHY0 */
         {
                 .regulators = {},
                 .clock = { "top_ahb", "ispif_ahb", "ahb", 
"csiphy0_timer", "vfe0"},

But basically yeah, we haven't modeled the dependency to the CAMSS_GDSC 
via the VFEx

Hmm wait - why haven't we included the CAMSS_GDSC in the dtsi for the 8996 ?

git diff
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi 
b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 30257c07e1279..60e5d3f5336d4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2120,7 +2120,8 @@ camss: camss@a00000 {
                                 "vfe0",
                                 "vfe1";
                         power-domains = <&mmcc VFE0_GDSC>,
-                                       <&mmcc VFE1_GDSC>;
+                                       <&mmcc VFE1_GDSC>,
+                                       <&mmcc CAMSS_GDSC>;

Either of those approaches should mitigate this patch.

---
bod
