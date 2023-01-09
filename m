Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F37662E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjAISOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbjAISNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:13:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8C13FB2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:11:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bn26so9108052wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fML4kPdr/TJZTTTjmDRqZF2NKNyIrXL/psZmLGwFohM=;
        b=m+fHzmBRRmF0BsG7LIAgKERc94P4/TYZiGuv2hl2kyEkRddu8aKFzX9476xmik78CG
         UsJw18F5gsV9YLSp8LMulmGbo1rrCZI/o3bDIe0W8l30ll1ABpAY6m04D7bQK4wo/kKB
         xVUEoSchbv5Qt1rguhdILk1ezkn7KVaPbEGAIirexPPBmqoN8Lp8UGUQdyQPnVQXy1dE
         xysaH5osPcYaE1IJfvlKrTw3cHMyEnpBocHevQ9EqRUPZNX/xBrrYNvP0aHlRNcy6mtr
         clG/Mt8HIMOjgc+tRH4qcP+UXGaSoxO4A9IlzcI7amrv1SDxIz2FWQJdaTqaYV447O4l
         D1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fML4kPdr/TJZTTTjmDRqZF2NKNyIrXL/psZmLGwFohM=;
        b=FvJxbMhwaCuzPQ9bFBHHJhSkedwZ60CYqtq0C+nT1oLQlg5HtxqInG5xeTFkYywSmy
         MrKMn9Q3uXDnVCmW2k77XavSmQ7Nn5aWHJLYYNJjf41CUHwS/fM8R8eimTRuBAK8FuUo
         a5cwB5vrsk/8L/qmB3AuXz2vYq7B50CRKZsYxy7p83o8sL2CpYl/v6MadlajdwZZncX2
         JUwhNjHZjoXQci/ea2Oz0m43Y+pBFFDrDEPP4BMVFVyMgdlG+a2FIyG+9HcTmGsUEknI
         DxUWjzBAOZCR86VYc7E1y6bv2BMjA+/3YHqBv7QOpMrP9Xuf6VeCopGwpMtQUnnAKiDZ
         fRXQ==
X-Gm-Message-State: AFqh2kp02GYS9GdDUY1wBi/OkC8WWN3z1wxLOSbCh5+vurwsl/27e43X
        DrUTGLYO9ytYIfbxVAfsuYUkvA==
X-Google-Smtp-Source: AMrXdXt7fojJue/+zqiYvHFyhcP0O74KqMDyTAn2+LC1MBCbIrE+iHWW/13fcFX63cwCA3EoHUAtcQ==
X-Received: by 2002:a05:6000:136c:b0:2bb:e1fb:5d83 with SMTP id q12-20020a056000136c00b002bbe1fb5d83mr4390655wrz.58.1673287865741;
        Mon, 09 Jan 2023 10:11:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y15-20020adffa4f000000b002bbec19c8acsm3846694wrr.64.2023.01.09.10.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:11:05 -0800 (PST)
Message-ID: <04bcb4c5-0605-2ea8-d658-feee4370ac4b@linaro.org>
Date:   Mon, 9 Jan 2023 19:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 11/18] arm64: defconfig: enable the pinctrl driver for
 Qualcomm SA8775P platforms
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-12-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the Qualcomm SA8775P TLMM pinctrl and GPIO driver. It needs to be
> built-in for UART to provide a console.

One defconfig patch for entire SA8775p patchset. There is no point to
enable piece by piece because anyway each defconfig will have to go via
qcom soc tree.

Best regards,
Krzysztof

