Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362806D4531
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjDCNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDCNDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:03:43 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EF1D864;
        Mon,  3 Apr 2023 06:03:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 72-20020a9d064e000000b006a2f108924cso4085628otn.1;
        Mon, 03 Apr 2023 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680526987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gdit34yJQcy1eg+Fj4fh5GPEiQrMUeLrxLZa8sMa+M=;
        b=Ecs4+hj3b55o0lLfR81erixSbxqrVStTLim7x2gps4tzMczni/9SCliEOaOy1Fu/Ew
         5yPg22mEK8i/Zxeh57BS66hJ1Ds97WVIQLQ5LSLpWEeuMSWiQm9WUJmKeifeN6X1YLaj
         wc25vZrUQdZ55h8rhg2LBFppd4i91XnhrOAgi///Mmcz0b8SAl4uBs0mBicVB4lDZvp2
         3nKF0T8jd+wTn6HMDagWew6cyKKZD1pco9EeWOuip8x0k1SoS0eYQwBj8L2mO2SjFy1p
         z5BPUWydkHOmXnRAlC0M+p1YJr8s7mTamJWX2zCRSJPstLn0/+fT3QjDes1EKgdqTdzq
         zzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Gdit34yJQcy1eg+Fj4fh5GPEiQrMUeLrxLZa8sMa+M=;
        b=EIKnOOO+nCd9dG+wMuOm8+xCsD8JBc6n3HlW0lbUQzzkvnn8JtrY4esJoytF294jNj
         ULARERhhXJRuEvW79pPrXEZ0qbL0nPiJ++GRI/VHQ+wZZuTbRZKHFfCzccgJhatub1aw
         j1Hj3Om6oBZwKzcscf5vRjhoiGCZ+YZDV26IYXDNQw5EVn9tWLcEL1aC53xL2JfJ9Irs
         5I4fS3sDlMG46R9Yf9h3Yg7xf0MFh+tQWO0dU7Nd4BfnnjRGPSdG18osXLccF5zzkKuw
         EMZf5nyt6O5ECFDtOK4quc+lOGIsu8VjGYwqd/oKJuS3hlRJIVGlYV4Fdj6JGYqU5w4w
         EEqw==
X-Gm-Message-State: AAQBX9d4pEmlbdbXVQUpiGcB0d9GoXSzoXHi9Vp+y10cHkiKJOljdsIY
        ep/rK3h/ihyEawGYMBYiI2v1yEAi0VlkUH7+mEs1JHsqh9U=
X-Google-Smtp-Source: AKy350aMNAvhZfzNhfPBjzMtuKuxt7Yferv0TB5CfYNoGd5il+hxXP809UlOPVg+ggfNoAlSjzKBquv4SspYghzR8q0=
X-Received: by 2002:a05:6830:1be4:b0:6a1:1b5c:c6db with SMTP id
 k4-20020a0568301be400b006a11b5cc6dbmr10357940otb.7.1680526987086; Mon, 03 Apr
 2023 06:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230120003051.9100-1-bb@ti.com> <20230120003051.9100-2-bb@ti.com>
In-Reply-To: <20230120003051.9100-2-bb@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 3 Apr 2023 15:02:55 +0200
Message-ID: <CAH9NwWfDpF5L=pXfOY8_9Fv3QWo5pNgz-GXmnuV432=9uT=Fmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: dts: ti: k3-am64-main: add VTM node
To:     Bryan Brattlof <bb@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> The am64x supports a single VTM module which is located in the main
> domain with two associated temperature monitors located at different hot
> spots on the die.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
