Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B66F98DB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjEGOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEGOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A05273;
        Sun,  7 May 2023 07:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 136DC60C67;
        Sun,  7 May 2023 14:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDFBC433EF;
        Sun,  7 May 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683468852;
        bh=I3Y8wMsWRPaekrCJ/2rQji7fk4OHU8l/ZeZRBFYLhf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mSScxPdd/chNzxXj83p5eHeUOHSymgonau+25cW0+s33hDFkjK/r2Qp6UEULJlea6
         gUqqE46HpHMlXSYtnbKY6ZkQzlyVRzlRIu8/OHRNU1OTJuGIOCew0ae7/6hwnYfDZJ
         hNjIkkXOiQO68OSwIt8mjFDcHpflcaomBoeP7pG3fm7uO13aeX3KfHhGzHt+5rXP1v
         kYNit7JFp/jG9o7gA7ysdsy36szMA8fJhTEqQaJFyCgkX4Lv2oOEMhwP8zBqzHyz+l
         lLZFgsCK3zzd0gAdKX8RiVeaDsHsigyyXbHWSksNgqBU2L1EAZPdCfffTM84tvNBWG
         PFoJfVv7NhRcw==
Date:   Sun, 7 May 2023 15:30:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/5] iio: adc: qcom-spmi-vadc: Propagate fw
 node  label to userspace
Message-ID: <20230507153004.3461eccd@jic23-huawei>
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
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

On Tue,  2 May 2023 01:17:32 +0200
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> Implement read_label in qcom-spmi-vadc to see DT-specified label names
> in userspace.  At the same time clear up some documentation around
> extend_name to promote read_label, and normalize similar code in
> qcom-spmi-adc5.

Whole series looks good to me. I'd like some review from QCOM focused
folk though before I take it.

Thanks,

Jonathan

> 
> v3 resend: added missing to/cc addresses via b4 prep --auto-to-cc.
> 
> Changes since v2:
> - Dropped RFC tag;
> - Reworded @extend_name deprecation comment.
> 
> v2: https://lore.kernel.org/r/20230116220909.196926-1-marijn.suijten@somainline.org
> 
> Changes since v1:
> - qcom-spmi-vadc: Use read_label instead of extend_name.
> 
> New since v1:
> - core: Point users of extend_name field to read_label callback
> - qcom-spmi-adc5: Use datasheet_name string literal for
>   iio_chan_spec::datasheet_name;
> - qcom-spmi-adc5: Fall back to datasheet_name instead of
>   fwnode_get_name() for iio_chan_spec::extend_name (gets rid of @xx in
>   sysfs filenames and labels);
> - qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check.
> 
> v1: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/
> ---
> Marijn Suijten (5):
>       iio: core: Point users of extend_name field to read_label callback
>       iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT label
>       iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwnode name
>       iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
>       iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
> 
>  drivers/iio/adc/qcom-spmi-adc5.c | 15 +++++++--------
>  drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
>  include/linux/iio/iio.h          |  3 +++
>  3 files changed, 28 insertions(+), 9 deletions(-)
> ---
> base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
> change-id: 20230502-iio-adc-propagate-fw-node-label-b1fff2e63ae8

