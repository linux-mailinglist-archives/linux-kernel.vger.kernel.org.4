Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DEC637E93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXRvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C24FF42C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so3432636wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gCHPS/CBoPc1slTf1Jl8HwmAh5NcCs13IxfjnHxcuc=;
        b=pptPcOebGI5RqtyMdPIDq6eaS1xitwTymvRr7pZqtyBvJRPYv8jIdgV0iqhjyEZRwf
         1epl5Cu2EAgWvN1yeTAYpj7tYVxRc5QKCCwW+72koCuEQQS3DSzbVWivy9QXnh3Vlixz
         EZ5zovnnYZC9+gUjK1LdlXd33h14oE4vFeqjCoMw6rpz7uhqNWekNxEY9kjXjubgcJYU
         OaE+j7E4j+2qbcOo5GIMUbNxUrsc9HHHCAzKEp91X1NdnpabxX0VQ/YYz5XePrYAzNee
         wgwaWOlyMlIkERfS4aahwMk8jvy2ST8wMKDh8EZl3USwNjShArr2jsR0XZU1zosylGJZ
         Y/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gCHPS/CBoPc1slTf1Jl8HwmAh5NcCs13IxfjnHxcuc=;
        b=i8yB5EMgC+550QxneWzGjxAhTmTheTFcqM2GEK8aaG26AnLUCKGosnwsWx+SsfAoye
         D2wz6/cT+kXFsJkjRNRsDpw0x9ynJhYXIyE4/7H6OtaKIQe2gJ/wb9q+4ioxj1PMiy5t
         6GdylWhvfnlov1v9us/00s9nGnw500hylnLDSeEe5tqdrWkuLE36JnEbcXXq9B5AIEpS
         lgEfihw7yGiYPrRk7/KQorPXumFvKMa5b9RTLzCVak0ld7Ep2bbJcBrTYIrb2B9s246T
         0x3za3cqP5ZxGaFhOuiYkPXuSHz3xZGgKF0bK9SHWHS5l49dfwF6bZ/urieZxeJ0EMtS
         02BQ==
X-Gm-Message-State: ANoB5pm3mvWjCKnPjiSCCXT1rGbG9j03+js+E6NVaeFLGWKsI49q+/7J
        RKlmH/IFHa76YYWlFtz/Jza2AA==
X-Google-Smtp-Source: AA0mqf5swSoVTl9EPxEn1ux2bENl1GKL4VIuZtsIF4DH06HHMOqWRM/WsuZLaub1XXHnLPznm0mfIg==
X-Received: by 2002:adf:f84f:0:b0:236:7805:48d3 with SMTP id d15-20020adff84f000000b00236780548d3mr20672705wrq.644.1669312297251;
        Thu, 24 Nov 2022 09:51:37 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/11] misc: fastrpc: patches for 6.2
Date:   Thu, 24 Nov 2022 17:51:14 +0000
Message-Id: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 

Here are some fastrpc patches which add new feature to handle Audio
Protection Domain. Along with it there is one locking update on dma-buf
and an update to bindings.

Could you please queue them up for 6.2.

Thanks,
Srini


Abel Vesa (10):
  dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries
  misc: fastrpc: Rename audio protection domain to root
  misc: fastrpc: Add reserved mem support
  misc: fastrpc: Add fastrpc_remote_heap_alloc
  misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
  misc: fastrpc: Rework fastrpc_req_munmap
  misc: fastrpc: Add support for audiopd
  misc: fastrpc: Safekeep mmaps on interrupted invoke
  misc: fastrpc: Add mmap request assigning for static PD pool
  misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

Dmitry Osipenko (1):
  misc: fastrpc: Assert held reservation lock for dma-buf mmapping

 .../bindings/misc/qcom,fastrpc.yaml           |   2 +-
 drivers/misc/fastrpc.c                        | 263 +++++++++++++++---
 include/uapi/misc/fastrpc.h                   |   7 +
 3 files changed, 239 insertions(+), 33 deletions(-)

-- 
2.25.1

