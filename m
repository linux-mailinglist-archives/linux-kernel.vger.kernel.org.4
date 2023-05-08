Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3C6FB616
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjEHRrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjEHRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:47:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67A658C;
        Mon,  8 May 2023 10:47:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so4402798a12.0;
        Mon, 08 May 2023 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568051; x=1686160051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwiqIZ2I63RCqiXIgneZW79DjsAkV/LlwIrmAUUc1/0=;
        b=b3RuUXNla4UM/mScJ/aKmlt1k8Nu+RZw8EtDGH5xAfvlOwYEtVsLP41i1Dj/jBSRFJ
         zLRQzlKGsWUEjsK/GoOXZ10SvArCcoGlvOkiesaHc4Ufu/Gy5T6HfnZI8kAHaYKlqRz5
         4hsr8DPtDAJ2nA9WpPUm8dBHmGjNneNgkwHAiGUJQDnNRaJ9YbM67Vkksg+ZPpURrSoI
         YBXOQ/FoY1m4waaRjxrdBH2YSqt35OUTbZ43tpCIWxrQSZsdQ00s8iGgq/S/4mQaLpxH
         tmgua+upVtObo+32DouGAjUM3gYppwF3PHEAyglu3r/aA3zqfQyGUd/f4/DkZ0V/4mEi
         R4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568051; x=1686160051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwiqIZ2I63RCqiXIgneZW79DjsAkV/LlwIrmAUUc1/0=;
        b=ie4miyLOGMu0O+INB5ezQmsBPufuXyVpSSAkNQDGLOZSN+Ik08thv5ijCqlXe0uouf
         7ahw8BcFNuBWqKjktyEs1PsO6TNKFI2zPVIBTfysqmaASEtjCosnYNiZugg1GxyuqwGt
         3eJhVfnJbM5FzKF/owIS/ozBUJYBxYj6KeLhwUEwJrZ/zH3tPqEkABVbxpoEZ4vUKHRw
         gcWt9xXiVMlOl2XHPsDlhdZNUPCB4XMN8g5DmcPwQkzesOVcxQ5wkZgHXeLk5lpapvKb
         KhvEMHoAnz8UanUOPaa8PXdfbjWi7r41afPFeMtgUrjb7lpID886/cSWA9Wvc1dkmJhe
         y42w==
X-Gm-Message-State: AC+VfDzbb5/EDU8m6CR+otZemcz6JwO7p7uu79rpa122cyVGshEqxMkc
        SgAvqYid8g00vI8tCrE+q8s=
X-Google-Smtp-Source: ACHHUZ6It7KDYZlq+izvd05DylTaW+hnrUpZogHwSvgqzD8u3MqHc+TqiSNCQEqjJ5xAD01B5LM6tA==
X-Received: by 2002:a05:6a21:7897:b0:100:4b1c:4528 with SMTP id bf23-20020a056a21789700b001004b1c4528mr6510146pzc.60.1683568051131;
        Mon, 08 May 2023 10:47:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j23-20020a62b617000000b0064389eab4c8sm227379pff.126.2023.05.08.10.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:47:30 -0700 (PDT)
Message-ID: <10d8a188-b322-6ae7-96e6-95ad9f741c23@gmail.com>
Date:   Mon, 8 May 2023 10:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/2] dt-bindings: firmware: arm,scmi: support for
 parameter in smc/hvc call
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
 <20230506182428.25343-2-quic_nkela@quicinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230506182428.25343-2-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 11:24, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with smc-id only. The parameters are
> all set to zeros. This change defines a new compatible string that can
> be used to pass shmem address(4KB-page, offset) as two parameters in
> SMC/HVC doorbell.
> 
> This is useful when multiple scmi instances are used with common smc-id.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

