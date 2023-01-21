Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018976769E5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAUW5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjAUW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:57:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565235B7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:57:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so7738428wrv.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXevFDlFQdM/zI7Jx7BcXm3YkWz/eRd8voNlgNsEDEs=;
        b=fOk7XXQyvFjmtjCFm1qgajijZ9hisHU8wsSpmwQeu0iyQ/WWys4CJdsCq3k+0fbDH/
         R1z3xUq7q4lDTiZHyX2MgmIzRO9JvoSjwwWC7WiZAmJzWZy9OGov5nfpupFLKX1BffXc
         jGgpG/MCAXB59mRd8Lrkb4t07e32LrFaojqAtswjVCGnhWaV6j3+dFViR7qSl/ddn5mi
         M6JaI6gCDUW2fLgrU2/9m28Sm+yocGfFl9LfpQs8qJorogk9CNXo8++TTZNrnBuJoKlb
         5R+9hXzpsVsQT91uBXHZ+kECAHLaQj0zXzBFqthurQj3Y6R3YWpGlhh/cbLj7ttO+l8K
         AsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXevFDlFQdM/zI7Jx7BcXm3YkWz/eRd8voNlgNsEDEs=;
        b=TeXbEN+jjL17M8XRh04B7xlb6ds7yPCUOVmd146851jiB9cflfLsdzgqK1LbW5RKb9
         A8JQdCNYr44jxWqesFl4vBWCjjhzXaGqW0DA2T0ZFroA9ht7NCX/45YrgNdUSUmou7Zf
         LzQgAmVDfPm1c1oi08xvVN77SN2PgtLfTSaDsJ+AqMXuyeFQedJGM6SNv5uwmAxL8Vg6
         DKU/SxqjKI0+2QuQUOJ4rQB5hQy+H1tw9ZCC/Fk/AhKPjhayZ3/nOVyzIRvOEUsb3DTx
         HhFeWTuflbT4gWPFypkCPfNLHhjUBXRzHSmMqCuzu8Y64qK7+p/VkSO4qZcvW+0iNPpv
         ZuHw==
X-Gm-Message-State: AFqh2kp07O9n+PnQeQkbwvCyAJzqknJydlp4qPAHHoM85SH/TbewYdBz
        //jw3wJANjNBWWmj77p2uydlsg==
X-Google-Smtp-Source: AMrXdXsUDxCkXVypog+Cjl1KgXGXiZ+K1LLyRLQkDar7eCHpCQ0/MhePcfFKKNBi0EORYD4Ui4ot6Q==
X-Received: by 2002:a5d:4fc8:0:b0:256:ff7d:2347 with SMTP id h8-20020a5d4fc8000000b00256ff7d2347mr24451448wrw.13.1674341866203;
        Sat, 21 Jan 2023 14:57:46 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b002be15ee1377sm13079444wrw.22.2023.01.21.14.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 14:57:45 -0800 (PST)
Message-ID: <1d6c5aae-dde8-3780-e851-f304e43d3ddf@linaro.org>
Date:   Sat, 21 Jan 2023 22:57:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <Y8fC/GCHfENQmBNC@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y8fC/GCHfENQmBNC@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 09:59, Stephan Gerhold wrote:
> Why are you adding a dummy power domain here? IMO this would be better
> added together with CPR. Especially because I would expect two power
> domains here later ("mx", "cpr"). For cpufreq you also need to make
> votes for the "MSM8939_VDDMX" power domain.

Confirmed power-domain is a required property, dtbs check will complain 
without it.

I'll leave further discussion on the format of CPR for the CPR series 
but our working example supposes the below as a starting point.

I'm not aware of VDDMX in the CPR path but its not at this node.

CPU2: cpu@102 {
     device_type = "cpu";
     compatible = "arm,cortex-a53", "arm,armv8";
     reg = <0x102>;
     next-level-cache = <&L2_1>;
     enable-method = "qcom,kpss-acc-v2";
     qcom,acc = <&acc2>;
     qcom,saw = <&saw2>;
     clocks = <&apcs1>;
     operating-points-v2 = <&cluster1_opp_table>;
     power-domains = <&cpr>;
     power-domain-names = "cpr";
     #cooling-cells = <2>;
     capacity-dmips-mhz = <1024>;
};

cluster1_opp_table: cluster1-opp-table {
     compatible = "operating-points-v2-qcom-cpu";
     opp-shared;

     /* Used by qcom-cpufreq-nvmem.c */
     nvmem-cells = <&cpr_efuse_speedbin_pvs>;
     nvmem-cell-names = "cpr_efuse_speedbin_pvs";

     opp-200000000 {
         opp-hz = /bits/ 64 <200000000>;
         opp-supported-hw = <0x3f>;
         required-opps = <&cpr_opp3>;
     };

     opp-345600000 {
         opp-hz = /bits/ 64 <345600000>;
         opp-supported-hw = <0x3f>;
         required-opps = <&cpr_opp3>;
     };
};

cpr_opp_table: cpr-opp-table {
     compatible = "operating-points-v2-qcom-level";

     cpr_opp1: opp1 {
         opp-hz = /bits/ 64 <200000000>;
             opp-level = <1>;
             qcom,opp-fuse-level = <1>;
         };
     cpr_opp2: opp2 {
         opp-hz = /bits/ 64 <345600000>;
             opp-level = <2>;
             qcom,opp-fuse-level = <1>;
          };
          cpr_opp3: opp3 {
             opp-hz = /bits/ 64 <400000000>;
             opp-level = <3>;
             qcom,opp-fuse-level = <1>;
          };
     };
     /* etc */
};

---
bod
