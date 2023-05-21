Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425C870AF85
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjEUSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjEUSaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:30:03 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1DBF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:29:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af7062f064so699563a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684693790; x=1687285790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YdKvk1s42m4/YyjaeLQo6Rg9ti5aRTm6YguiBgoAog=;
        b=Erbz7tA5D0m+MvvR7Ywy2y0rf0TYdz1OZaBimm9pJAQCLdc3a+p/8YHsDgUN5KpOt4
         2kqNEfEOzCtJF04UxYmE57duLHedYwl8EG21VKJ7/yU1zH8hUQazEdwR18/uKsn7+vcN
         FRFW45DaMYsY51lucjDnrzh2yowTtp/0fQeeIxO9IB1Uhe6dL+8I5LFt0MyNuwgLgseH
         TixXH/78EprKDCJgcbiYUkHDcAw/Qk2sY2hUGsmeeCB70UYTX4o772xLoqkGf/RByvfN
         WHN4TmajUR6i6KymqAddi3H1Dc4xyWhVdlk+NlUMrsagJbcB0NgoMh/rvKyQyU8euwvQ
         tUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684693790; x=1687285790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YdKvk1s42m4/YyjaeLQo6Rg9ti5aRTm6YguiBgoAog=;
        b=c0M+KpnOYjXpmg9Sl/Ukr0P/jDARadjyZIz+wgy3wgibHUxsoskq+n8ZbGVIGOW9dI
         GSpbXboearh+X307GBYQnzBMiwPjNSORentbYwBrpOFkt78rT+B+0MvukQOq68Vm8t0A
         aO38SmOXg56BPnpXaLU4ZjF4Sx69s8RbPa6KsJisxViheB9xr+4QYKFN2+y8Jf5B6e0/
         LantoXuh7RpXq4tzkkuSGNAPXM5fpYWa2G/0isen5/dCaoinGJi/JpoFHeQWXrsSLQC+
         mB3/YFmA2zTqJiWU8JmwJgDilcYhE0QSI58ZCL094uspKNzpilggMxo03TWkJA3jglgU
         q9PQ==
X-Gm-Message-State: AC+VfDz1vvVyg9LqqB/T5eXCWRgE8XpbgBYzRntRFY2LWNhgBrf6t7Yy
        7Mt5OIhG0WyXtstTc7HvFGr9yi6QYTRLXBGosbkl5Q==
X-Google-Smtp-Source: ACHHUZ6tUPGnoQNqWfClyhqKpcD4Og/NRsCoCFuUaqfRk4LTXdDwhB41w0GIzYb4N2zjTwdmXRsKwnqf9JYItUOvo1Y=
X-Received: by 2002:a05:6870:b145:b0:19d:6f68:c3f with SMTP id
 a5-20020a056870b14500b0019d6f680c3fmr1170765oal.33.1684693789681; Sun, 21 May
 2023 11:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519135803.13850-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230519135803.13850-1-manivannan.sadhasivam@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sun, 21 May 2023 20:27:45 +0200
Message-ID: <CAMZdPi_QRi_n7=Do_P6E3Xwk=zQ3nS3jpiFBNApCvWd4v=LSCw@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add support for IP_SW0 channels
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 at 15:58, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> IP_SW0 channels are used to transfer data over the networking interface
> between MHI endpoint and the host. Define the channels in the MHI v1
> channel config along with dedicated event rings.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Assuming we can extend the number of event rings (and dedicated irqs)
without hitting any hardware limitation on the device side?

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>



> ---
>  drivers/bus/mhi/host/pci_generic.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index db0a0b062d8e..70e37c490150 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -212,6 +212,19 @@ struct mhi_pci_dev_info {
>                 .offload_channel = false,       \
>         }
>
> +#define MHI_EVENT_CONFIG_SW_DATA(ev_ring, el_count) \
> +       {                                       \
> +               .num_elements = el_count,       \
> +               .irq_moderation_ms = 0,         \
> +               .irq = (ev_ring) + 1,           \
> +               .priority = 1,                  \
> +               .mode = MHI_DB_BRST_DISABLE,    \
> +               .data_type = MHI_ER_DATA,       \
> +               .hardware_event = false,        \
> +               .client_managed = false,        \
> +               .offload_channel = false,       \
> +       }
> +
>  #define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
>         {                                       \
>                 .num_elements = el_count,       \
> @@ -237,8 +250,10 @@ static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
>         MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
>         MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
>         MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> -       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
> -       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
> +       MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 64, 2),
> +       MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 64, 3),
> +       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 4),
> +       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 5),
>  };
>
>  static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
> @@ -246,9 +261,12 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
>         MHI_EVENT_CONFIG_CTRL(0, 64),
>         /* DIAG dedicated event ring */
>         MHI_EVENT_CONFIG_DATA(1, 128),
> +       /* Software channels dedicated event ring */
> +       MHI_EVENT_CONFIG_SW_DATA(2, 64),
> +       MHI_EVENT_CONFIG_SW_DATA(3, 64),
>         /* Hardware channels request dedicated hardware event rings */
> -       MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
> -       MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
> +       MHI_EVENT_CONFIG_HW_DATA(4, 1024, 100),
> +       MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
>  };
>
>  static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
> --
> 2.25.1
>
