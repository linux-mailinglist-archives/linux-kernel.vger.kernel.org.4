Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87F70A8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjETQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjETQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BF189;
        Sat, 20 May 2023 09:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCDD6132C;
        Sat, 20 May 2023 16:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D1EC433EF;
        Sat, 20 May 2023 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684598876;
        bh=V4usJZqRAFqQRrB2t/cEprnBUvtDDffV3Y2qt9ee9NM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2e1vkPiu+Au/fOv8dpSaECuWvpg5sz/3KlYc6+XVZEMKqmifqR1LZoIBQcBcNwnS
         N19K5hWcRI3O9L+48G7hglwvVKVUeY5oKNk50B40tIATkeLNebsVaW4FuRl5/KtNAM
         XiY169Oq8wFU7ofjcxfGQS9ORDdX4I3Gir+/Zf98nbcWhY4IPEjenmgSNP79tdp8b3
         gma7bdaPPEaBp5Xu0Ka6RB77KkgArzBAwlrRC2kfyNpo2IN2uQSRMBTuLqsZUB41yC
         QXzdikdZyvoN4yMaJ6YRvJeuf3rjB0ta8xuSoQrbzN3m48sDkv3GP6+tO7P3C2/Pfd
         nVufObl4xmFSw==
Date:   Sat, 20 May 2023 17:24:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <20230520172405.0e1a3ff8@jic23-huawei>
In-Reply-To: <ZGNpZM137jF5yzie@arbad>
References: <ZGNpZM137jF5yzie@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 13:30:44 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Support Honeywell mprls0025pa pressure sensor.
Series applied to the togreg branch of iio.git and initially pushed out
as testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> This patch series adds support for Honeywell mprls0025pa pressure sensor series.
> There are a variety of sensors with different pressure ranges supported.
> 
> Changes in v5:
> - Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
>   - add Reviewd-by tag
>   - preserve formating in description
> - Patch 2: "iio: pressure: Honeywell mprls0025pa pressure sensor"
>   - make use of div_s64_rem()
>   - document calculation
>   - reorder includes
>   - use NANO from units.h
> - Patch 3: "MAINTAINERS: Add Honeywell mprls0025pa sensor"
>   - no changes
> 
> Changes in v4:
> - Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
>   - change line length to 80 characters
>   - make vdd-supply mandatory
> - Patch 2: "iio: pressure: Honeywell mprls0025pa pressure sensor"
>   - change line length to 80 characters
>   - change regulator vcc to devm_regulator_get_enable()
>   - switch to probe_new
>   - many changes from the review
> - Patch 3: "MAINTAINERS: Add Honeywell mprls0025pa sensor"
>   - no changes
> 
> Changes in v3:
> - Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
>   - fix errors while doing dt_binding_check
>   - add vdd-supply
> - Patch 2: "iio: pressure: Honeywell mpr pressure sensor"
>   - change to _RAW interface
>   - add transfer function
>   - add regulator
>   - move to device_property_xxx functions
>   - many more changes from the feedbacks
> - Patch 3: "MAINTAINERS: Add Honeywell mpr sensor"
>   - change file names
> 
> Changes in v2:
> - Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
>   - change the global sensor decription of mpr to the specific sensor
>     mprls0025pa
>   - change compatible string
>   - rename the file to honeywell,mprls0025pa.yaml
>   - honeywell,pmin-pascal and honeywell,pmax-pascal: add unit pascal to property
>     names 
>   - add new property honeywell,transfer-function
> - Patch 2: "iio: pressure: Honeywell mpr pressure sensor"
>   - no change so far
>   - will be changed and send out as new version when the dt definition is
>     settled down
> - Patch 3: "MAINTAINERS: Add Honeywell mpr sensor"
>   - no change so far
> 
> Andreas Klinger (3):
>   dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor
>   iio: pressure: Honeywell mprls0025pa pressure sensor
>   MAINTAINERS: Add Honeywell mprls0025pa sensor
> 
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/pressure/Kconfig                  |  13 +
>  drivers/iio/pressure/Makefile                 |   1 +
>  drivers/iio/pressure/mprls0025pa.c            | 450 ++++++++++++++++++
>  5 files changed, 575 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
>  create mode 100644 drivers/iio/pressure/mprls0025pa.c
> 
> 
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4

