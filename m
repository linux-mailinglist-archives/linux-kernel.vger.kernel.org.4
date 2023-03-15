Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE486BBCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjCOS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjCOS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:57:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D267813
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:57:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so3364619lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906658;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+Z6yMufViGivHBpi3ybAlT526oTlR6qrL1yn4estsw=;
        b=AwkFVyVX1JCx5J5VtFLHexJqg6+JirVxzXxrteIVK9icHG0yDkGQYUJKWBNhi8Lmw6
         cvDrln/pHVlJZvIeTpROJAQJteEIlCsItdpls77VH1MJ6a/3jivYTvhzfb0M75D/LOMP
         FCOqgcfSdwr+uRysr1+aNuk59OiSaDp6vmhfvHWlXpOn9TDwDwUGz0QHQXOJmBZ53Mb4
         ZWgGFSw4InAXXH0Jm5ALkfZjms3MQeruicJwS9uB35cLgnBE5erxkPsZIN2++9E3w5xT
         MYSGmZJxFgon5h9DnjaPr1WeScggKN4MglbkVICE20lwvH374QWyFoxrdKOMuSdr9UGW
         +ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906658;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+Z6yMufViGivHBpi3ybAlT526oTlR6qrL1yn4estsw=;
        b=o5a/IeKTguu+uyBrwqWnqQsLTOCQgOAqBH4o/oq4cDn1LNvyR5jVi6m2jt5RiQVemK
         PoXVKA13C5cq63uowd8w+FAb57eow3CH9Fie/R40ajfMCfbLYctpKBZkOt08sXslNEs2
         xcbxkIo4/xBh03ywgLRROl0Kjxm+B0Df+1eaaIBVfyHCL9Ef0r6CKLG5d0xTDp6CyxO8
         Cq3ytDskgpCvWoi3OTJb77L6PjAcPExRtimtKIdhm1IZ6tfwmfNsjr3uUEyJLG/yoFfO
         maS+6hab4dgb2mKySeYCY4oxRMhote+6LGlde13SryMDXIEaX25AI1zyxoz+rWd5Ywu0
         MhYw==
X-Gm-Message-State: AO0yUKXOENsHCv8DoQVcC8bLKpOOpksc2GfDA+AvG2QGLULVpi0+UiX5
        shSePTxianEykouIT4UzE8dx15Y2bdET845e
X-Google-Smtp-Source: AK7set9tLECN0x6xdBtYoNEBTbu9cgivpU5jkqabOsPDzCXijrnWn2e4inbxkzAYfEOE0+RuV03+yw==
X-Received: by 2002:ac2:5097:0:b0:4b5:9e70:ca6e with SMTP id f23-20020ac25097000000b004b59e70ca6emr2393178lfm.17.1678906658156;
        Wed, 15 Mar 2023 11:57:38 -0700 (PDT)
Received: from letter.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id d18-20020a05651221d200b004d0ecb0948csm909877lft.217.2023.03.15.11.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:57:37 -0700 (PDT)
Message-ID: <64121521.050a0220.1e179.3226@mx.google.com>
Date:   Wed, 15 Mar 2023 11:57:37 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1bd962b1-2fbc-9bdb-8b7a-9f2c70c316e2@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +      - samsung,exynos7885-dw-mshc
>> +      - samsung,exynos7885-dw-mshc-smu
> 
> What about the if-then at the end? Since this is pretty compatible with
> exynos7, then I would expect being added also there.

Makes sense. Also it probably makes sense to add "samsung,exynos7-dw-mshc"
as a fallback compatible to the jackpotlte.dts, because it probably
somewhat worked for whoever contributed that.

