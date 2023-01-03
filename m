Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29E65BED2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjACLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbjACLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:19:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52EF03B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:19:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gh17so72862911ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQJyR5W3A4f1ySu0UGGHSzR6lOpSLkq+TzKRR4GKR3s=;
        b=uiPQEnOeSUlbBNbrKOyzbrLx7Zl5d72kqG93ulTrg7ZDZHPRt3L2aE9Ks1kaQ54CcS
         F6xoKoMzKDU362iYQwJ2zkA7JNzUywQQRqGJJYSsXKBIw4fKyVttGqrm58ZqONb7LDos
         GyhEp1x6L8zoMYFqjvpPqxveF0qm6HcsNL5FGAhxpk0pQVlnZXRbKI1ZCNWRYYZdsE9I
         6H8yFx8gO+IKKkFdtsGCqUYw3uzjhEvCLPylg5rwFjVmi01rbrMtok282mVbe0DBv6ld
         fgupCUMFpEC9XSe5Uy3gmezyioXlafT+EpISk0rzNNaNSVtl3h6S6GLV8+qTJMK9b5Su
         MfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQJyR5W3A4f1ySu0UGGHSzR6lOpSLkq+TzKRR4GKR3s=;
        b=LWTNV5aEXkaUi6+NPByW5wg9kByKeVNeS06uuHHKp2tzKeygeHsVw/C/uS6YZOkxk4
         Gd4hnJDI7xwaf7p/OokAgZasajx/tcfkU7Oskqz7bvQJh8+iDD/gXFdczyOgFxQmgYLt
         Ms7KMm+M/CbET1ZplpFVaaQb5qN0yeQ/Pk2dUG4q3tIF7Ro86+EclkIeIS3NilrBGJER
         nwSbUKO7yEhLp3wjnzavYFpS2+zzcKT5rGsvcwSVzPFsZjDTAf+JVoPVxznvghNPcSuZ
         nS6Jw4BHuW8tD3a2RjrQy2Posk6n2GtZdap9K9YsHN6mXFkE8h6Qp+DgNFCtn/Avza2Y
         9Zag==
X-Gm-Message-State: AFqh2ko9d8TSLCxLAk0DEU1nTIcqJ81Aiyxcop3y57h1qB7h55QKQmUN
        BF5NGtQI2hiWF+NGJkQNy6AxrQ==
X-Google-Smtp-Source: AMrXdXuzwiaCZt1ZjEmk+p69Sd4xpuX0vBLO7a+8it9tst+k6JqXO4pEx2T5IkhLyynjradloprwRA==
X-Received: by 2002:a17:907:d389:b0:7c1:5a37:825 with SMTP id vh9-20020a170907d38900b007c15a370825mr49560094ejc.34.1672744754929;
        Tue, 03 Jan 2023 03:19:14 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:29fe:fa1a:5ca3:7f83? (2001-1c06-2302-5600-29fe-fa1a-5ca3-7f83.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:29fe:fa1a:5ca3:7f83])
        by smtp.gmail.com with ESMTPSA id bw1-20020a170906c1c100b007aef930360asm13997509ejb.59.2023.01.03.03.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:19:14 -0800 (PST)
Message-ID: <b146fcf8-e829-8df7-7153-b4a8913e4c9b@linaro.org>
Date:   Tue, 3 Jan 2023 11:19:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
 <f293e1c3-d192-fe98-c599-e9c40d01175d@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <f293e1c3-d192-fe98-c599-e9c40d01175d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:29, Konrad Dybcio wrote:
> 12, 13?
> 
> Also, why does this node exist in the first place? Is it
> going to be used for some non-standard touchpanel-off-flipping?

For most of your comments here the answer is "because that's what the 
incoming dts does" from Sony's downstream.

For V3 I will see if I can get some better insight on the gpio bias and 
what this entry here is intended for.

---
bod
