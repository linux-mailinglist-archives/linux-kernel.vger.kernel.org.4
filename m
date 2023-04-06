Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB86D9916
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjDFOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbjDFOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:08:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05389A265
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:07:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q191so6510168pgq.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680790072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RteKmS59a4b/Livq4/wTXxuwKDD1ND5d5F3gxwIyVvg=;
        b=Xi3N3uf5n3HG7rl/sNskFtGj1RNofGb3+2wBADR7noNd2P3L+/v5dDNKnxMStYdMnj
         NEYr2YAdH5+MN38JsQ1GAHSpVut9UxJYLIQlcIuZ3CdbJ9UURnL+ADLY6to4zriy3UgC
         16A/zTS6wa8pTSKoo69bDSVzXZa5V9JpbnsyAtamv0TnVUpyK2Wef9r2rkPMCF818edF
         yDXKxyvpUUJih4Qcxxjn+BmfscliDE7YOENd6IgoDwB1I/skvbWfzOuxOERCnXGT8BHn
         wm6YTG5qt76L52qMmUJx7AVmzDJqXWxiPM9LitnIXvabsmN0HDVwVfGXdKGtzfZlGOO0
         mK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RteKmS59a4b/Livq4/wTXxuwKDD1ND5d5F3gxwIyVvg=;
        b=Qhsp8rmmPVH5CbqGl7N6o29q+bN+LPAOH0LcVYtaUjmywXEHQeZjTDz3MqRGm53Xsn
         /KpSbd5+ZyoOKj+CVzkjEzS+SKDBVLb5GjWGwQbMWdp1wcLoMfVtsUx5fgCULvAsS6Hf
         oBXKBWwHBLgahhIspXKy7rnIcdkln8afQV0TqNKG+thjgK4olb1s6AjG0jWK4MOLOh9k
         YVnjzg3kqh/5r8FSEGwiif8gV1lvLRX7uHEZ/td69Abxms8AoTQLIVHwqnDsMVshM/HZ
         hUzkNgaipG4uBJCdbljIoQ8GnGYVpNB6yu91Ir4KLIfwbBvAMB2hpT1MyN1u4T7MIiEL
         nCkw==
X-Gm-Message-State: AAQBX9f1xhN6Bmkdj0Ca7nwfUNPj8CV4T4sAt7ubSaQGgfnTdXhsy/rX
        qE1Jk9wEB5y3nv/k+t88st6m+qgZpL8r2D+LK5pJZg==
X-Google-Smtp-Source: AKy350YoVVmnwmCMwUMTWP2nqTW4bt4E5fTltvq1au01bIxYuEWJDJK6lNIfy0Guy3dt3kbmzskK2BuZHqzBgMrbr5Q=
X-Received: by 2002:a05:6a00:2313:b0:593:fcfb:208b with SMTP id
 h19-20020a056a00231300b00593fcfb208bmr5391071pfh.3.1680790072028; Thu, 06 Apr
 2023 07:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230406022249.2501-1-seanwang1@Lenovo.com>
In-Reply-To: <20230406022249.2501-1-seanwang1@Lenovo.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Apr 2023 15:07:41 +0100
Message-ID: <CAJ9a7VhgytZMUtgq7cJFzCDkbqu1krSO4xrubHe0sL1LrWUBrQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: add AMBA id for Cortex-A510
To:     Sean Wang <seanwang1@lenovo.com>
Cc:     asherbai@lenovo.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, janetliu@lenovo.com,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please also post to all the relevant lists when submitting a patch, as
defined in ./scripts/get_maintainer.pl


On Thu, 6 Apr 2023 at 03:23, Sean Wang <seanwang1@lenovo.com> wrote:
>
> From: Sean Wang <seanwang1@lenovo.com>
>
> Add AMBA UCI id to support Cortex-A510
>
> Signed-off-by: Sean Wang <seanwang1@lenovo.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1ea8f173cca0..702704cf4f1f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2186,6 +2186,15 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>         }
>  };
>
> +static struct amba_cs_uci_id uci_id_ete[] = {
> +       {
> +               /*  ETE UCI data */
> +               .devarch        = ETM_DEVARCH_ETE_ARCH,
> +               .devarch_mask   = ETM_DEVARCH_ID_MASK,
> +               .devtype        = 0x00000013,
> +       }
> +};
> +
>  static void clear_etmdrvdata(void *info)
>  {
>         int cpu = *(int *)info;
> @@ -2264,6 +2273,7 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
>         CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
>         CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
> +       CS_AMBA_UCI_ID(0x000bbd46, uci_id_ete),/* Cortex-A510 */
>         {},
>  };
>
> --
> 2.34.1
>

I do not believe that this is needed. ETE is architecturally required
to implement the system instructions interface to the ETE trace
registers, and memory mapped access to the ETE from the PE is removed
by the specification

Your board .dts should declare ETE with the compatible
"arm,embedded-trace-extension", and the system instruction platform
driver will be initialised, which does not require the AMBA matching
IDs.

If your solution does have the optional APB interface to the ETE we
would expect this to be used by any external debug system and not by
self hosted trace in the linux kernel.

Regards


Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
