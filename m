Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCA65B921
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjACB4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjACB4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:56:25 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5BCE3E;
        Mon,  2 Jan 2023 17:56:07 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-14455716674so35360381fac.7;
        Mon, 02 Jan 2023 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96ZA3U+4lODUN3hIoOOVli3grSMHv8whVkE4ZtfzuJM=;
        b=KvXgqBoo9WmoGuCe5vzbMWxElgDcbFiloThShHoBMxljzX+4aV4siZiqAROHBM4128
         2DHl0I4Fz/mmYz49C47k8fQJN3TgddLm5A83pEAOElNOxm72x4v7Ag7vZruc8/h7ODLl
         +gAhtSug9qHjhpoRju+X/hrAAK88RT95HwR3rk97Ut92tAJff9VUb1iQ6Lkz/3RsHX99
         Ri0t1eb/0d6/RV1UnBZqTrfZaglg9kHfOqOAM1of7MO4Ght4sRqKfOJwH6Y5I/MgBczG
         Is1ggOpBcSHlFkKudF5qHDf6ap86WuZOe5JIAVe7f9iMrgmz0WKu8lsU5f5e32NkH/cw
         SF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96ZA3U+4lODUN3hIoOOVli3grSMHv8whVkE4ZtfzuJM=;
        b=PrWFSX6slnDndpoA4viQbpb5E28xMDVw7X1rynn7lXlMtt6o8S+XJSYzrbMS4Jq0/y
         mQs94YZWGQlGGwe2lmEfPlqVic3pA20YTlYbU8jnmw9fV88sb0okeBwmjc1wvRQimujS
         9v7RhV4B+0/zQZnPpdk3V+qOMgidFwMsT/bXZ1k1dsiXDnxtPmgCyNjNv6sh9ScsGhib
         rXGAR7zGHl0vQAInIO0+8aCWwxIm33mGQvREqyIkE2DJycXJEzGmpoy2PHaDUIuY/x03
         FREmge8/4poXgvOFrVqHf/Hp+xDRhKRKp9mKqh4+JcE2NEub912JlsfWDc1CEw7fv/xW
         lTBg==
X-Gm-Message-State: AFqh2kq8rf+Smct3AfngkOVAnlF+6Dh2Tx47fPYqLieYi/W7ewQ3x8lM
        k7X08QSP0fmxxTcgY7G5Ng0=
X-Google-Smtp-Source: AMrXdXtb4bHZ9umAo6HHJUafiGC78lfkM4bBWYxkhrmL8rbnxkgsx2BdYpvMkIIJoXpc34YlsCkINA==
X-Received: by 2002:a05:6870:d8aa:b0:144:7eb3:c9b0 with SMTP id dv42-20020a056870d8aa00b001447eb3c9b0mr20918406oab.42.1672710962830;
        Mon, 02 Jan 2023 17:56:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9-20020a056870b28900b0014474019e50sm13663486oao.24.2023.01.02.17.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:56:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 Jan 2023 17:56:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Temperature sensor support for StarFive JH7110
 RISC-V SoC
Message-ID: <20230103015601.GB313835@roeck-us.net>
References: <20230103013145.9570-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103013145.9570-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:31:41AM +0800, Hal Feng wrote:
> This patch series adds temperature sensor support for StarFive JH7110 SoC.
> The last two patches depend on series [1].
> 
> [1]: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> 
> Emil Renner Berthing (4):
>   dt-bindings: hwmon: Add starfive,jh71x0-temp
>   hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor
>   riscv: dts: starfive: jh7110: Add temperature sensor node
>   riscv: dts: starfive: visionfive-2: Add thermal-zones
> 

The hardware monitoring driver is obviously either the same
or derived from the previous series at
https://patchwork.kernel.org/project/linux-hwmon/list/?series=&submitter=&state=*&q=starfive

Why is this not submitted as v4 of the original series ?
What has changed, and what is the rationale for (re-)submitting
it as v1 ?

Guenter

>  .../bindings/hwmon/starfive,jh71x0-temp.yaml  |  75 ++++
>  Documentation/hwmon/index.rst                 |   1 +
>  Documentation/hwmon/sfctemp.rst               |  33 ++
>  MAINTAINERS                                   |   8 +
>  .../jh7110-starfive-visionfive-2.dtsi         |  28 ++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  13 +
>  drivers/hwmon/Kconfig                         |  10 +
>  drivers/hwmon/Makefile                        |   1 +
>  drivers/hwmon/sfctemp.c                       | 350 ++++++++++++++++++
>  9 files changed, 519 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
>  create mode 100644 Documentation/hwmon/sfctemp.rst
>  create mode 100644 drivers/hwmon/sfctemp.c
> 
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> prerequisite-patch-id: 4dc515731ce237184553c1606ffb3afaeb51c3d8
> prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
> prerequisite-patch-id: a798370d170dc2bcc79ed86f741c21c1e6d87c78
> prerequisite-patch-id: bd9fd8b5cb2376dc7a5e08e1a1fbb969cf475926
> prerequisite-patch-id: c57ebb83bc43ccd2a8366ff166eb499da1e1d2cf
> prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
> prerequisite-patch-id: 94860423c7acc9025249d4bb36652a585bd0a797
> prerequisite-patch-id: b5084253283929d9a6d0e66c350400c7c85d034d
> prerequisite-patch-id: 6e369dbe9dca2785e4ea7d0b80e525e227a90a6e
> prerequisite-patch-id: e08806183c152714c563f3a21c6d7b2f539c4d6e
> prerequisite-patch-id: 79db8036abdc48fd36da227652ec62627a6b548b
> prerequisite-patch-id: 06971b8e6bddc0e87e63bfdb0ce8bfb653bd73aa
> prerequisite-patch-id: 16309a0e23811a2c55d2e56886de3e8eccc51554
> prerequisite-patch-id: bf4f7ab0b6cfa90b6e49e66c7d75ed2eaaebbe78
> prerequisite-patch-id: 38468d532e87867990055d3320679f18c5f52278
> prerequisite-patch-id: 4710f2ac22dca0bdd9ff5d744d2c37cab3c74515
> prerequisite-patch-id: 6bb9a780c62af3bcc2368dfd20303c7b1bc91e23
> prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
> prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
> prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
> prerequisite-patch-id: a2b3a9cff8a683422eb0ccf3a0850091401812d4
> prerequisite-patch-id: e0ba7af0f8d3d41844da9fbcba14b548cbc18f55
> prerequisite-patch-id: bc0176325c11a632c6abaa83e54e891cc92d1c74
> -- 
> 2.38.1
> 
