Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEADA6F25ED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjD2S6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD2S6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:58:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54710A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:58:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a516fb6523so11535245ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682794685; x=1685386685;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tneK3rBistnd9Ha67Ea2Jz2s60WaNrk0c+1Wr5wtZd4=;
        b=bNJ0a9PlEcdBF+D7KklysARre66PsS60KW+fqG+FgUkVbvZBScXzV/P/qemIinvqdA
         RGjVj3zDl7+7EkuCjfrdbpQ0s4DPd3daiJj3DDYvtgjnilpb4n+rlVqYpNMi32EdVk9z
         4ScOzIRJFMYTstYR5uFnSTj6AoU3o3Fa8ypRxptygBv2aX/e/Cnp8o8zOoMo+Kxir2hq
         RCzHThJv5X7vqng0eMKkZNIKLFHcNPnebigPe3eMwzmTmqtKBftjHNNBbhckPj+b1Osf
         FyHXLMIO6pisf5F61w+pkhU5ZQWdLtoDNoQVDMCa06KuRcFHigfnw38q9VLh0f894bO5
         v+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682794685; x=1685386685;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tneK3rBistnd9Ha67Ea2Jz2s60WaNrk0c+1Wr5wtZd4=;
        b=Kx64Blc5Or/HzaHY2LtZy2fnKgWKWSYfLEIDlCP0Ul1pCWDg/HQn9XtFzdvmYZVNIa
         YMgmCQfws7UstRZzfgQo7TxwfJGiSKMxK5Daplhp+mVjbV/COVkguWCmYjr1Znbx76K4
         jqFNM7KKA3tbXX7yMJWmPCmcYXEn3S6Faz8eyboVyekFtZKOUA4v8k/RGH5UTimo2vmj
         Dni33JBfHqlS9eQofNrfknNzZFaxSo66IyVSC+PDE2hE2mNe5gymv9wSlS1qU2wiezqA
         gR3BBIUMH/7a8t1wxHQsqzVsTfTAPkPBw7bSnUKCGb7tQOsjLuR/uTYB58G064jiXr+T
         Drhw==
X-Gm-Message-State: AC+VfDx78LhUTwKrq9sF3RO9PtfD8FJkjxctNrctHBmAZWy0yWuTLULL
        a0TcFF9Lk7reay6Z4/K70//A8A==
X-Google-Smtp-Source: ACHHUZ5s+GEIwUVRzUqUdkcm4/YL6Qb5gwwrAB6zsCenMUYBzTYBLu4Hq1rlV4SjZnoSUrs2/azH/Q==
X-Received: by 2002:a17:902:bd8d:b0:1a9:90bc:c3c5 with SMTP id q13-20020a170902bd8d00b001a990bcc3c5mr8643899pls.62.1682794685224;
        Sat, 29 Apr 2023 11:58:05 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001a1a82fc6d3sm774266plg.268.2023.04.29.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 11:58:04 -0700 (PDT)
Date:   Sat, 29 Apr 2023 11:58:04 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 11:57:50 PDT (-0700)
Subject:     Re: [PATCH v7 0/2] StarFive's SYSCON support
In-Reply-To: <20230406103308.1280860-1-william.qiu@starfivetech.com>
CC:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Conor Dooley <conor@kernel.org>,
        kernel@esmil.dk, william.qiu@starfivetech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     william.qiu@starfivetech.com
Message-ID: <mhng-698f09f5-3840-4456-87c2-5c04742b42f4@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 03:33:06 PDT (-0700), william.qiu@starfivetech.com wrote:
> Hi,
>
> This patchset adds initial rudimentary support for the StarFive
> designware mobile storage host controller driver. And this driver will
> be used in StarFive's VisionFive 2 board. The main purpose of adding
> this driver is to accommodate the ultra-high speed mode of eMMC.
>
> The last patch should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/
>
> Changes v5->v6:
> - Rebased to 6.3-rc3.
> - Modified compatible's property.
> - Added clock-controller and power-controller node.
>
> Changes v5->v6:
> - Rebased to 6.3-rc1.
> - Changed file name to starfive,jh7110.yaml.
> - Modified commit description.
> - Added syscon node dts patch to other dependent modules.
>
> Changes v4->v5:
> - Added a incremental updates to fix a bug that prev_err is uninitialized.
> - Dropped the merged patches.
> - Dropped the dts patch.
> - Sorted compatible alphabetically in yaml.
>
> Changes v3->v4:
> - Added documentation to describe StarFive System Controller Registers.
> - Added aon_syscon and stg_syscon node.
> - Fixed some checkpatch errors/warnings.
>
> Changes v2->v3:
> - Wraped commit message according to Linux coding style.
> - Rephrased the description of the patches.
> - Changed the description of syscon regsiter.
> - Dropped redundant properties.
>
> Changes v1->v2:
> - Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
> - Changed the type of 'starfive,syscon' and modify its description.
> - Deleted unused head files like '#include <linux/gpio.h>'.
> - Added comment for the 'rise_point' and 'fall_point'.
> - Changed the API 'num_caps' to 'common_caps'.
> - Changed the node name 'sys_syscon' to 'syscon'.
> - Changed the node name 'sdio' to 'mmc'.
>
> The patch series is based on v6.3.
>
> William Qiu (2):
>   dt-bindings: soc: starfive: Add StarFive syscon doc
>   riscv: dts: starfive: jh7110: Add syscon nodes
>
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 15 +++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
