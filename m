Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A867CFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjAZPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjAZPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:16:28 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2170D40;
        Thu, 26 Jan 2023 07:15:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 5so2106348plo.3;
        Thu, 26 Jan 2023 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IUMglE7oIMks0RLQ6Ljbyu9rHxNe78WuuFe544zjMU=;
        b=lhZydBIEBXohwuADdNmiN1QRNyqQ7/FkdK8WXfloJ4wTi9dFeAz+fYeV5lwIsC9HjU
         ohYDxBW5rLEdIx9OUWWHRYrkZiE4KpId0Iu/2/8JFGHKH3V9DNlWtBud7Y9u5Rwv9u1g
         aYwaSKo5lcYpHp7dwYi+2d3oWO1YMZdBUPM25bUfYfct8DRisQAO593mWUd02gV7zyAx
         yjVUxQdRSrrPY08MKq6f/scDwJybQBbbf2/6apySXxeRVUHzmjIifX6cJVEn5+qeVWs4
         29hLuUD74+hltnd6ypqYeXaf2x5fYOdMnR99yXxg0QhXc256XR05rDk7LkHLFypv6XCq
         /2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IUMglE7oIMks0RLQ6Ljbyu9rHxNe78WuuFe544zjMU=;
        b=jJLPJ8qSpggg6OrgQ7QPYjR50OhJBt9jVTSzKvu3+ePENqeB752UKY4QPZ9umDQDKb
         VA8qbAq97X2JL5iVIX/mBmsajCRgHyiZe1POdO5MoHRrc+fXa1jlRnqrembZd7QdWt3O
         X3V3Z/ivVAxC+/Yqc/sAQQVt9l/fCx41tZ4MBvAXtNHCyKo8ZDywUkrsTPf9AWW3pqfo
         f1vR4al9znIkNK96T+9XF3g44SApN3CH8U2FtRPIk7+KB7vyFys/t0KJ30lDSnNgt4Bo
         oIIplrnEGTvUV7m9j/3Lg8dF+lOgEHh7eMsWCW7YcW2upbb0Xqt/v2uuo3ouYOv1tvGj
         GNrQ==
X-Gm-Message-State: AFqh2koFoKyxNwkNfOf/kVYwvbZAt9hugQtMeOCUx88e/SZMmW3OBD4y
        JwfRNxRWi/tyWFhSny242zPIU8TF4NyfegVreAs=
X-Google-Smtp-Source: AMrXdXvb5OpCoUW2QPkNJzzZ5WP7DXx7VOrVFPRWZNL1EBCxdVqKoluVdSIYu3nmLS+d37hq51dYuvfwf4VuxpEzCGw=
X-Received: by 2002:a17:90b:291:b0:227:3f:57be with SMTP id
 az17-20020a17090b029100b00227003f57bemr5726599pjb.158.1674746156510; Thu, 26
 Jan 2023 07:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com> <20230124221218.341511-13-william.zhang@broadcom.com>
In-Reply-To: <20230124221218.341511-13-william.zhang@broadcom.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 26 Jan 2023 16:15:44 +0100
Message-ID: <CAOiHx=nX5GUnE-y0HfbA3j=-YNRD6qfuYJPjyKpn0hGhOUCLLQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] spi: bcm63xx-hsspi: Disable spi mem dual io
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 at 23:33, William Zhang <william.zhang@broadcom.com> wrote:
>
> In general the controller supports SPI dual mode operation but the
> particular SPI flash dual io read op switches from single mode in cmd
> phase to dual mode in address and data phase. This is not compatible
> with prepend operation where cmd and address are sent out through the
> prepend buffer and they must use same the number of io pins.
>
> This patch disables these SPI flash dual io read ops through the mem_ops
> supports_op interface. This makes sure the SPI flash driver selects the
> compatible read ops at run time.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>
> ---
>
> Changes in v2:
> - Remove the code that uses the deprecated flag use_cs_workaround
> - Always disable dual io read ops as prepend is the default mode
>
>  drivers/spi/spi-bcm63xx-hsspi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index 2a0bef943967..dd320fda7611 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -20,6 +20,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/spi/spi-mem.h>
>  #include <linux/reset.h>
>  #include <linux/pm_runtime.h>
>
> @@ -663,6 +664,23 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>         return 0;
>  }
>
> +static bool bcm63xx_hsspi_mem_supports_op(struct spi_mem *mem,
> +                           const struct spi_mem_op *op)
> +{
> +       if (!spi_mem_default_supports_op(mem, op))
> +               return false;
> +
> +       /* Controller doesn't support spi mem dual/quad read cmd in prepend mode */
> +       if ((op->cmd.opcode == 0xbb) || (op->cmd.opcode == 0xeb))

There are defines in linux/mtd/spi-nor.h you can use:

if ((op->cmd.opcode == SPINOR_OP_READ_1_2_2) || (op->cmd.opcode ==
SPINOR_OP_READ_1_4_4))

Though SPINOR_OP_READ_1_4_4 seems to be redundant, since the
controller does not support quad mode, and does not advertise it, so
it should never even be an option.

Looking at that file, instead what is missing is
SPINOR_OP_READ_1_2_2_4B (0xbc) which shouldn't be usable either.


> +               return false;
> +
> +       return true;
> +}
> +
> +static const struct spi_controller_mem_ops bcm63xx_hsspi_mem_ops = {
> +       .supports_op = bcm63xx_hsspi_mem_supports_op,
> +};
> +
>  static irqreturn_t bcm63xx_hsspi_interrupt(int irq, void *dev_id)
>  {
>         struct bcm63xx_hsspi *bs = (struct bcm63xx_hsspi *)dev_id;
> @@ -760,6 +778,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>         mutex_init(&bs->msg_mutex);
>         init_completion(&bs->done);
>
> +       master->mem_ops = &bcm63xx_hsspi_mem_ops;
>         master->dev.of_node = dev->of_node;
>         if (!dev->of_node)
>                 master->bus_num = HSSPI_BUS_NUM;
> --
> 2.37.3
>
