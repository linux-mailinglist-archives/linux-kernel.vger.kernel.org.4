Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8276075F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJULT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJULTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:19:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34C53A67
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:19:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p8so4483240lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry8J3AzsAYcOp8SmDfnbNUXitGgoYOKaYRQ6uRWnRWU=;
        b=daE365yCa1g3YT3Ogsc/0phvnpY7BrOOzncWnQ3sfLuU0gpU2cH1cbumKwuTfm12j+
         nhkXFut2118tOsAdLXDvjf8sDSNV9p2u9bm/0f9JTNkW9RR3AgB1JXoQrUxUF5okjfwl
         nlmc7nRkMhb8IcQq9Tp8YXHh2wFFRdj0E4MEE22MFVK4iHWKtZmGMwGiv9aztYevI3Ik
         y/ECRXjNKpNAAObiSLxryE2yGNyV1A8Q8QUbtTLHpgxLiyjz2Pg9WDNu7b7D87HnZze6
         Lel9eKeAAbPws8UExyJh6YIoNl2CIeNOI6hJfr71ChuCnhwEfNp7rg2M9UG84x5QOaKW
         Yo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry8J3AzsAYcOp8SmDfnbNUXitGgoYOKaYRQ6uRWnRWU=;
        b=dnwxVCbVJmhaQgqmxvsQQh/TgCk7wou6AkIyZj4E/22AoJdpyoJ8TrPpKE3A+/Dxy5
         tsZpHH0D9woLn8SS9HT30NwHjnK+Vik0QyZTlT53P3hs6XT3NxjBBxM3rQ9wKZzMLO5r
         zYy95G4s640N+b18xGEubZYgYwEYPkBU83Q5DBaijIzUqe8e9UkCAfi4JTOsbwHD5w1w
         tlvqb+zheFgr0+UILza3lhQyKdoGI5HiCJl4nYQ/wUwwghdPyG7njdD82f1rEIX2iu5R
         0adCfIDcBbCvq9SnOgHlA20ts433ShYtAyX1qhtMV2ywY7jhDQZimktL2NtdWmW1Cul0
         XuFQ==
X-Gm-Message-State: ACrzQf1XTlu3jvyjIs6nembFZ+b8yDb5rCF8SUkHAAQkVxyvSuVfUKMh
        fttiLgAC2bGVjI+/AqeOGdb/yg==
X-Google-Smtp-Source: AMsMyM4ow9jYgXDgpVjyT18F7PpTAHJgqNxNuwIMrdbae9umBoBzQMLU0ULg0iNON8oQ6+JowOTHQg==
X-Received: by 2002:ac2:50da:0:b0:4a2:44dc:b719 with SMTP id h26-20020ac250da000000b004a244dcb719mr6259514lfm.652.1666351183033;
        Fri, 21 Oct 2022 04:19:43 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b00497aa190523sm3123186lfc.248.2022.10.21.04.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 04:19:42 -0700 (PDT)
Message-ID: <d2c2b274-ecee-456e-25b1-dd161641720c@linaro.org>
Date:   Fri, 21 Oct 2022 14:19:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 15/15] phy: qcom-qmp-pcie: add support for sc8280xp
 4-lane PHYs
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221021110947.28103-16-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 14:09, Johan Hovold wrote:
> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> PCIe2A and PCIe2B).
> 
> Add support for fetching the 4-lane configuration from the TCSR and
> programming the lane registers of the second port when in 4-lane mode.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/Kconfig             |   1 +
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 117 +++++++++++++++++++++++
>   2 files changed, 118 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

