Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20796C9054
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCYS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCYS7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 14:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACF5276;
        Sat, 25 Mar 2023 11:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3FEDB80782;
        Sat, 25 Mar 2023 18:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1DAC433EF;
        Sat, 25 Mar 2023 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679770766;
        bh=cvkDQ5VUSugi/Mx0cXn8GHD+HIhy+RhvFVUaPPEbIaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQRaY0SdvHsMw3Qz1+oQ2OU67uhbpMc7NB4AyXGTJ/vep30XWbPOqxbW3fg1+ojV7
         u34Y4IGvGvMqEtc+iLwpwoTEuXWcGUAMUFnV4umx8fuJI/ian4Ct+25DM5Hw7wsZD1
         YCqfBlyPp/njAWIl8h2dhWigJZxZqHb1TOpTn3rGnreTCcepKTiFfZpaYBRj8SdtW3
         7CpscxCm13XMUTxOgl7D5w3IG+8/oWhQl6wla27yb3TaNTBgy6GM1kvwNftE35OWZ7
         ZGnP2ZtMyFSJiS4krHyoeBCpP7ehAbQarDoYa/F5JY5S3eGZ/zsYlUVhDwT3HI2G86
         jkBrUKeIdDG5Q==
Date:   Sat, 25 Mar 2023 19:14:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 4/4] serial: qcom_geni: Comment use of devm_krealloc
 rather than devm_krealloc_array
Message-ID: <20230325191426.5810b644@jic23-huawei>
In-Reply-To: <20230320145710.1120469-5-james.clark@arm.com>
References: <20230320145710.1120469-1-james.clark@arm.com>
        <20230320145710.1120469-5-james.clark@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 14:57:09 +0000
James Clark <james.clark@arm.com> wrote:

> Now that devm_krealloc_array is available, add a comment justifying not
> changing this occurrence to avoid any future auto fixups.
> 
> Link: https://lore.kernel.org/all/20230318173402.20a4f60d@jic23-huawei/
> Signed-off-by: James Clark <james.clark@arm.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 28fbc927a546..8ae1fb7c2636 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1055,6 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>  
>  	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> +		/*
> +		 * Use krealloc rather than krealloc_array because rx_buf is
> +		 * accessed as 1 byte entries as well as 4 byte entries so it's
> +		 * not necessarily an array.
> +		 */
>  		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
>  					     port->rx_fifo_depth * sizeof(u32),
>  					     GFP_KERNEL);

