Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62695F8648
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJHRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJHRrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:47:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0643641A;
        Sat,  8 Oct 2022 10:47:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so7135852pls.4;
        Sat, 08 Oct 2022 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjOpq6xMtwZ+a3cDZHo77w5YYPm/GULCq55aoUGSZUY=;
        b=k2PdDqrMFH9TDVs4NNmkDNVW1tZ4DZI2Om3NlqRmVHq/ORP6Ek4CTPo2ChxBkffpqG
         +exGCZ37mPRtxWvp6qBnqE51uk026LglhI9PMAO1O0WUkbcNgu4Y2BZXkX4t0sjQd2vv
         6opOW+kcQSbdkSpElJuHFi30ya2mMiySGYPTaFGq0WxOmKGXV06z3yEjDfIXrmXuxfwG
         LY02yLVqQiOuRSdG3YwNVAoAWHltYXP64dKm09HkasL6+NSyzt6Bu3TtVqj+KdzVFqrD
         wkzEcXMbwaFHyPvrYgZndfNKbNlXQQI3cU0OG8RlRAKS1Hh8l7+Wf+c1raSlJVQu6xVB
         w1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjOpq6xMtwZ+a3cDZHo77w5YYPm/GULCq55aoUGSZUY=;
        b=Gz9JEEyc6WAgib6HJwb4+3Z6UQVpsqk18K4/sm5HjgTN7KrVBg5GJ6kGrgjNIVBoiR
         NYhsCBKDEMfRE24zjdoXx8uDRX5PH+xAM6slwOlssfJPA81f92cd7Nx6TVZvkU6ze9sk
         QlJaBrR3wyPPl9VFw32o1V/0UX+GSIipcQ+nxIezQ10yapN5GPKsbofO0IxYXuvDb1gt
         +Kr30rSAd+JJ6Jwjq8qiY/zBzWxbxttKisgJZvKiv2wYUoGOvsBuHpldme91ZyS5fonb
         prT/aoRetxUXxlE3JIlQcWGJ4gwthqpm0dzqpD/DbJ/znzvQBcsYKIhblFz5e7+Vd3PE
         tq7g==
X-Gm-Message-State: ACrzQf1mhYUfOxk6D3Cm5gLWH/Cr0mTO58oxcx3aWDW4QoQpKJ6n213l
        oo4krmoopl+R1txDapLTokfvydvtyygNog==
X-Google-Smtp-Source: AMsMyM5PNS0KaEXVCBl5n03E5vdpEpUJXbhW17H5h1iuFum/emGaclK/NUUxFJWQgBx3uTysCD1PQg==
X-Received: by 2002:a17:90b:1d4c:b0:20a:8db1:da52 with SMTP id ok12-20020a17090b1d4c00b0020a8db1da52mr22216569pjb.98.1665251229287;
        Sat, 08 Oct 2022 10:47:09 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id o9-20020a170903210900b0017f7d7e95d3sm3583270ple.167.2022.10.08.10.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 10:47:08 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v3 0/2] remoteproc: qcom: Add support for MSM8953 ADSP
Date:   Sat,  8 Oct 2022 23:16:56 +0530
Message-Id: <20221008174658.336470-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the ADSP PIL as found on the MSM8953
platform. It is a subset of a previous patch series.

Changes since v2:
 * Made ordering of compatible strings lexical in doc patch

Link to v1: https://lkml.org/lkml/2022/10/6/18

Sireesh Kodali (2):
  remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
  dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953

 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 drivers/remoteproc/qcom_q6v5_pas.c                          | 1 +
 2 files changed, 6 insertions(+)

-- 
2.37.3

