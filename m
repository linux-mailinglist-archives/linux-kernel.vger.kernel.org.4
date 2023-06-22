Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CBD73A81D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFVSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFVST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:19:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A4268B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:19:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-38dec65ab50so5529056b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687457955; x=1690049955;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eCSU8eCreQMQARaqFK0Z7W8VecyujL3iJIi084r8bk=;
        b=hJ2zkmtwhWO4g6OT6PCjZBUnY/2he9q5drY/j/hU4kEwc0SEnsoJHwTW8w45eM3b4w
         RN+PcJ/CqcpXve69GuN6LRpJXwbStZICZdvtuz9ODFbTBwVrIi4df9d37SnQbadciOVX
         PUWTPjiEemuj1TK613lA+nTvPw7a9KxaI1DpKzSwG53ZJ6cICspUvwoP2+qVvLhzdJBO
         XvSD2WpkIhuOezesW//T48I3MF5cbE7ICNuM9mESqaUSO6Sb1IIqLdz128uSW8oE6emF
         WFbEZsha4ORo5ZYpAK507l77w6vQFM/JTqFd6iyy9X378usl35oJycAQ0wWSu9U37mM8
         J7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687457955; x=1690049955;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eCSU8eCreQMQARaqFK0Z7W8VecyujL3iJIi084r8bk=;
        b=TubF3gpuYZrPwYt05GE3MtcZEycxMe6b5spodDW7d0cBQQ8d8YgfDwp41e/8gh14sQ
         jNCniHfnGyw9+UoTwbRo3La10iY6ISAaNj9FuPmfyMXWTCgTPq22Cz9y3x9GB7lTlPBs
         K7PNeuo/yf1uCLxqlxKHZXIqpmXB67+DtlksbUbXKEkQibyJQsscC7aYRpgkcFs2T1Fc
         2/IUV1ITWGfezalvUK1ahTayidxZt2gzsnNwy0m3HSZ3AAhhu0VX0YIa0KE0g11A4E3R
         f82pXwIIUBBUDz8drq3mnGXNDP0ZWh2qOMKsr/cJbN/HWvHCf+VHQTjThnAyNfXgYbMA
         PSEw==
X-Gm-Message-State: AC+VfDySB19NqZFUjaP3qT0lQDquV+b16nPO8UnM1EGvvPnPgqN580el
        JkgmNAXNMZwIVQ+J78+Vy8AXEA==
X-Google-Smtp-Source: ACHHUZ7EBnnb4fJReoZIx5GFM1PIx+0BLy2Aj/TnlqNdQHm7hdf+kUGwMO2gLRRcnjXYslyeHFqv0w==
X-Received: by 2002:a05:6808:8e8:b0:39e:dc23:d835 with SMTP id d8-20020a05680808e800b0039edc23d835mr13371412oic.48.1687457955221;
        Thu, 22 Jun 2023 11:19:15 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm5184584pgj.37.2023.06.22.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:19:14 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:19:14 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 11:18:34 PDT (-0700)
Subject:     Re: [PATCH 0/9] Add DRM driver for StarFive SoC JH7110
In-Reply-To: <20230602074043.33872-1-keith.zhao@starfivetech.com>
CC:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@esmil.dk, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, p.zabel@pengutronix.de,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        andersson@kernel.org, heiko@sntech.de, shawnguo@kernel.org,
        jagan@edgeble.ai, macromorgan@hotmail.com,
        keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
        shengyang.chen@starfivetech.com, changhuang.liang@starfivetech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keith.zhao@starfivetech.com
Message-ID: <mhng-17a80922-c7a0-4717-adfa-0959d3dfab77@palmer-ri-x1c9a>
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

On Fri, 02 Jun 2023 00:40:34 PDT (-0700), keith.zhao@starfivetech.com wrote:
> Hi,
>
> This series is a DRM driver for StarFive SoC JH7110, which includes a
> display controller driver for Verisilicon DC8200 and an HMDI driver.
>
> We use GEM framework for buffer management and allocate memory by
> using DMA APIs.
>
> The JH7110 display subsystem includes a display controller Verisilicon
> DC8200 and an HDMI transmitter. The HDMI TX IP is designed for transmitting
> video and audio data from DC8200 to a display device. The HDMI TX IP
> consists of  the digital controller and the physical layer.
>
> This series does not support HDMI audio driver.
>
> Keith Zhao (9):
>   dt-bindings: display: Add yamls for JH7110 display subsystem
>   riscv: dts: starfive: jh7110: add dc&hdmi controller node
>   drm/verisilicon: Add basic drm driver
>   drm/verisilicon: Add gem driver for JH7110 SoC
>   drm/verisilicon: Add mode config funcs
>   drm/verisilicon: Add drm crtc funcs
>   drm/verisilicon: Add drm plane funcs
>   drm/verisilicon: Add verisilicon dc controller driver
>   drm/verisilicon: Add starfive hdmi driver
>
>  .../display/verisilicon/starfive-hdmi.yaml    |   93 +
>  .../display/verisilicon/verisilicon-dc.yaml   |  110 +
>  .../display/verisilicon/verisilicon-drm.yaml  |   42 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  MAINTAINERS                                   |    9 +
>  .../jh7110-starfive-visionfive-2.dtsi         |   87 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   46 +
>  drivers/gpu/drm/Kconfig                       |    2 +
>  drivers/gpu/drm/Makefile                      |    1 +
>  drivers/gpu/drm/verisilicon/Kconfig           |   24 +
>  drivers/gpu/drm/verisilicon/Makefile          |   13 +
>  drivers/gpu/drm/verisilicon/starfive_hdmi.c   |  928 ++++++++
>  drivers/gpu/drm/verisilicon/starfive_hdmi.h   |  296 +++
>  drivers/gpu/drm/verisilicon/vs_crtc.c         |  388 ++++
>  drivers/gpu/drm/verisilicon/vs_crtc.h         |   74 +
>  drivers/gpu/drm/verisilicon/vs_dc.c           | 1040 +++++++++
>  drivers/gpu/drm/verisilicon/vs_dc.h           |   62 +
>  drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 2008 +++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  496 ++++
>  drivers/gpu/drm/verisilicon/vs_drv.c          |  301 +++
>  drivers/gpu/drm/verisilicon/vs_drv.h          |   52 +
>  drivers/gpu/drm/verisilicon/vs_fb.c           |  181 ++
>  drivers/gpu/drm/verisilicon/vs_fb.h           |   15 +
>  drivers/gpu/drm/verisilicon/vs_gem.c          |  372 +++
>  drivers/gpu/drm/verisilicon/vs_gem.h          |   72 +
>  drivers/gpu/drm/verisilicon/vs_plane.c        |  440 ++++
>  drivers/gpu/drm/verisilicon/vs_plane.h        |   74 +
>  drivers/gpu/drm/verisilicon/vs_type.h         |   72 +
>  include/uapi/drm/drm_fourcc.h                 |   83 +
>  include/uapi/drm/vs_drm.h                     |   50 +
>  30 files changed, 7433 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/verisilicon/starfive-hdmi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/verisilicon/verisilicon-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/verisilicon/verisilicon-drm.yaml
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.c
>  create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_fb.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_fb.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
>  create mode 100644 include/uapi/drm/vs_drm.h

This popped up in the RISC-V patchwork, so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

in case anyone was looking for one -- I definately don't know anything 
about DRM, though, so not sure that means much...
