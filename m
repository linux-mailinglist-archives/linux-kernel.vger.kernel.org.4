Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0623B6B44D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjCJO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjCJO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:28:25 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B97B11CD59
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:26:39 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a32so5491934ljq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678458397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmJV4J0/XATLrtNuZZDanGroIlzak6RGa++GJSoMmoM=;
        b=WBS6IwJ/1gkl5nYP9/Kc0Wjc6sqgdaiom21UcYw3Alt7vAM8/6C8PNRdTY5W7dYdvu
         hbK/w9VdS/wetl81xvXVPz05eQ34TS+k2RQLBul0sDXDmbmuepIycBkrXlt7cJMkbpg8
         pW08lNY5L2P5hBq8inV39PQlsP5wapo2LpBKXhlFPp6SaXgnRNiUWFo+K7UriiCTAqen
         uhLlIBjV/zJggOQu7DentX7jy8LwigPCAF44qp+koE6lalPZs1tV1tqSQ7aMBXdOWiSf
         S5fPJiGCv0vWiOg4d4402ctJoui3hfuLi6esc5en8lml1ojepeHZRGLTbYjjMMEqeuOr
         +3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmJV4J0/XATLrtNuZZDanGroIlzak6RGa++GJSoMmoM=;
        b=KN4cC+OElVpeVZrbM84wz5ADi+rzZjBvNU4Rvrff7b2RSoz9j6OF6k8rZap2lAc06F
         szFr2XA+eT+3ao+tf7HD38BHSs9V8OV3U9cQlFotHOF+d2Qcp9f/tLaScf7KsDZtDOEK
         1aaf6RPY4AZvC0+/EVa242sbQzfDgbZzTt9rwPhIapZUDvldQEkF8FsHOiQsU8Kq6wSc
         nJ5Suz9Bp61CcXMRKA9blUBI8etaMJR7dYqjJm3Yi0XowzYpy4rVOgus6Ribe8y4qFKm
         iW4jW5xgN0RpelXP/wtmh+POO3T15DYYPhVG+jkYenHqxkX4+cW550+WeeIYZTsu5DJM
         vaNg==
X-Gm-Message-State: AO0yUKXOZmeL642+AUKeNhlRmjizXOyK0e+J9oRSuHpCr7S7VmonpajV
        p+xd+B2PGWKUlB6wZXHUv1M9mSiUQkGExIhekQQ=
X-Google-Smtp-Source: AK7set9KoeLo3vT/9YD7eeIav5GN8CsM0udkgwLm3S2jxfQLeEF4zv2kUuY07GcThjqxT6KXikF8fw==
X-Received: by 2002:a2e:92cd:0:b0:295:b0a8:951f with SMTP id k13-20020a2e92cd000000b00295b0a8951fmr7225972ljh.27.1678458397685;
        Fri, 10 Mar 2023 06:26:37 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e84d7000000b00295728289dasm23346ljh.79.2023.03.10.06.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:26:37 -0800 (PST)
Message-ID: <6d10906e-08cd-0380-5f5d-3ac0eec60276@linaro.org>
Date:   Fri, 10 Mar 2023 15:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2023 15:21, Bryan O'Donoghue wrote:
> On 08/03/2023 21:40, Konrad Dybcio wrote:
>> Some (but not all) providers (or their specific nodes) require
>> specific clocks to be turned on before they can be accessed. Failure
>> to ensure that results in a seemingly random system crash (which
>> would usually happen at boot with the interconnect driver built-in),
>> resulting in the platform not booting up properly.
> 
> Can you give an example of which clocks on which SoC's ?
See for example 67fb53745e0b

This was a clock documented downstream under the node-qos clocks here:

https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.5.7.r1/arch/arm/boot/dts/qcom/msm8996-bus.dtsi#L102-L109

but there are occasions where such clocks are undocumented and downstream
skips them because it relies on them being on by miracle, such as the case
of MASTER_IPA and the IPA rpmcc clock on msm8998. Downstream has no
sync_state, so they would only set the QoS registers when the relevant
hardware was online, so the clocks were on already.

> 
> Is the intention of this patch to subsequently go through *.dts *.dtsi and start to remove assigned-clocks ?
> 
> Are we saying that currently there ought to be assigned-clocks for some of these NoC declarations ?
Not really, assigned-clocks are used for static ratesetting, see
for example dwc3 nodes where we need it to be fast enough for
HS/SS operation at all times (though that should have prooobably
been handled in the driver but it's a separate topic), I don't
think any of them were used to combat what this commit tries to.

Konrad
> 
> ---
> bod
