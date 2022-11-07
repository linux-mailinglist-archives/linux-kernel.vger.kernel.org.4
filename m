Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB161F714
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiKGPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiKGPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:03:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D24BA458
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:03:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so15485513lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5cqfO9vASlyV1UQ/Ymj1gXHUZKIE6uTQs8zVm2OS0g=;
        b=ABMi7gpaZVTAukaw/B77ZaYTM4PQVevR8kKr1nU9K4X++l13EbJhVlgU7PHLsi2qM3
         N/qL452zRKmaOU/WbFpspe3Zm3J2MQP9pxzBAFH2bkyXe+Ig08aw17weJ3kYpvD12aBk
         uiK/nD15Bk0yhAwt4tF9FyPb0lEDvgf/yRApUJqDRzOD05r3+uhsqYvXQA2sGaKhAvwz
         sbbZxXc61tY1HYsMOuwhX7e9BFOk6NofwvNR9apE/Nz2g52B8yQnVZDZagcv0+sD1dFj
         F25Xcx38iJU9LwhzHq45KMbzXpAPYJ3ZEQU9InHvpZO8NsLhkURjIKtewRDXbiHlMIUe
         AqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5cqfO9vASlyV1UQ/Ymj1gXHUZKIE6uTQs8zVm2OS0g=;
        b=N0aR1VPwiDp/yp4IyYfmBL7yKER6/11qebeuEM0IJ0ykdNqLdkiROnkhxBn5AZkEPQ
         vTLkNzO0yETSGHl5hVaXhZNZxnDmxiNTvBQW5xGJ+SQDi3OJk69fkJhPw+nWL7U2DqjO
         a1cKyiUWjDLsnzmLjGg6djflnRO9572Ryiw+I2LLJAuPGAUgRczd3Nq7ZR1RefSBBe0W
         myDy7y8ZTS7XmzrjM/xTTj6dNlJ14TiCluJN25bTV4dIbKMOxSU3gaJaUN6+Kla+O9Lr
         EuXuuVU5xh10BBC5//+YjyoopZfs2NJL8DfZGUX06SckmGdNa9u1Y9WWtv8zVWAy6MbA
         B1PQ==
X-Gm-Message-State: ACrzQf02ZNu1MgDYH7CheBSavBIzgWxds71stSeXleCoxf45yz/lFS/a
        6eQQLTSJvD2PoVSz7zlTaWOQ/w==
X-Google-Smtp-Source: AMsMyM4wGYjZBicYju8APQdvIo86aRDOkUKW+W36UmLcDJ2UOsVG1nnMwIluDHwG4hCvF4MiB0U8Dg==
X-Received: by 2002:a05:6512:298e:b0:4a2:9ffd:d084 with SMTP id du14-20020a056512298e00b004a29ffdd084mr17142217lfb.449.1667833435023;
        Mon, 07 Nov 2022 07:03:55 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t7-20020a056512208700b004b18830af7asm1277912lfr.54.2022.11.07.07.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:03:54 -0800 (PST)
Message-ID: <03994d2e-261a-5ca1-36ca-b9380fe4085b@linaro.org>
Date:   Mon, 7 Nov 2022 16:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Remove redundant soundwire
 property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
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

On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
> Remove redundant property qcom,port-offset in soundwire

redundant and undocumented property

> controller nodes.
> This patch is required to avoid dtbs_check errors with
> qcom,soundwie.yaml
> 
> Fixes: 12ef689f09ab ("arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs")
> Fixes: 24f52ef0c4bf ("arm64: dts: qcom: sm8250: Add nodes for tx and rx macros with soundwire masters")

These should be two separate commits.


Best regards,
Krzysztof

