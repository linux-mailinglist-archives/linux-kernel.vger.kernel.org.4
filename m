Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE26C1A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCTPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjCTPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:48:12 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413F33454;
        Mon, 20 Mar 2023 08:40:07 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-177ca271cb8so13460508fac.2;
        Mon, 20 Mar 2023 08:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgk3KZtzxxXItnf/+rB0VTBN9p0dTxRpbFOr+Nh5gQo=;
        b=VZNeo0puhsbgqKNUAvBZYuCJYjJdQMdqjh25it533X6n7z+6Ai1QYuJJTzUp/2isbA
         43ND6b3mDmhCpEiWX7mc2yIjA11oSurFIYgP1KQTudPR/hEofjx9fzkNDZox516pSFsz
         oMpDrazVqaeYEy80ylGn4jcYNsEaXMyfmBO+HxrcvnH9BHamf14NHLBBFZrlvh5tiER/
         H5BpHatpgQFBzK65dTu7bOJzzHmbJzxXaDOBHmqwvUm2JwHobUHdPRYpzS8uesyL8Vfp
         iM8laxAgjmy2o+gokUFBwrerXIVSGs2m+sbBZOWiuLqyIB2031YMezJ1PwMRXnIqgcIU
         w2Ng==
X-Gm-Message-State: AO0yUKWhzgKppxYRhoBM5jMTdLwl8aSS4gqIgDP/SJRUQrdEgqE8SdCX
        4ccXyJq4YQulTAh4rCTPug==
X-Google-Smtp-Source: AK7set87VF+yIaIfxL/PlV0G1miQvufThf1triexklF4keCIjfhdIpG9fdtEZpA/DP+1tMLyJ5YfXw==
X-Received: by 2002:a05:6870:c351:b0:177:b62d:cc26 with SMTP id e17-20020a056870c35100b00177b62dcc26mr5085501oak.8.1679326807020;
        Mon, 20 Mar 2023 08:40:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k126-20020acaba84000000b00386eff32f58sm2155846oif.13.2023.03.20.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:40:06 -0700 (PDT)
Received: (nullmailer pid 1739413 invoked by uid 1000);
        Mon, 20 Mar 2023 15:40:05 -0000
Date:   Mon, 20 Mar 2023 10:40:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH v2 0/4] TI TPS6594 PMIC support (Core, ESM, PFSM)
Message-ID: <20230320154005.GA1733616-robh@kernel.org>
References: <20230315110736.35506-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315110736.35506-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:07:32PM +0100, Julien Panis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
> 
> This series adds support to TI TPS6594 PMIC and its derivatives.
> 
> The features implemented in this series are:
> - Core (MFD I2C and SPI entry points)
> - ESM (child device)
> - PFSM (child device)
> 
> - Core description:
> I2C and SPI interface protocols are implemented, with and without
> the bit-integrity error detection feature (CRC mode).
> In multi-PMIC configuration, all instances share a single GPIO of
> the SoC to generate interrupt requests via their respective nINT
> output pin.
> 
> - ESM description:
> This device monitors the SoC error output signal at its nERR_SOC
> input pin. In error condition, ESM toggles its nRSTOUT_SOC pin
> to reset the SoC.
> Basically, ESM driver starts ESM hardware.
> 
> - PFSM description:
> Strictly speaking, PFSM is not hardware. It is a piece of code.
> PMIC integrates a state machine which manages operational modes.
> Depending on the current operational mode, some voltage domains
> remain energized while others can be off.
> PFSM driver can be used to trigger transitions between configured
> states.
> 
> Link to v1:
> https://lore.kernel.org/all/20230216114410.183489-1-jpanis@baylibre.com/
> 
> Others series will be submitted over the next few weeks, providing
> drivers for others child devices like GPIOs (pinctrl), RTC, and
> regulators. Board support will also be added (device trees).

I don't care about the drivers, but I need a complete binding for 
the device to review it.

Rob
