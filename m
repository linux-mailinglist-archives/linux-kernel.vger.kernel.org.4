Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C996EC7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjDXIKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjDXIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:10:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34D1B7;
        Mon, 24 Apr 2023 01:10:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F2709320091B;
        Mon, 24 Apr 2023 04:10:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 04:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682323808; x=1682410208; bh=bX
        ooH0omr7pzgUgg72ktdVlhPup4UV6iGJc1Um0ngrw=; b=jIBt7gcOcEm5RDELkb
        yiHKVadey9HXVGqxFDgXitY/vozB3bKpleI0fq0S6trvnse69qopkYm5X58rD2vH
        EJSreoaGwEOIdSssQs2gs9i6qJotIsBLyrrIhIT9V6h1SdiSd1mE1X4vRXJrfskX
        rA9JjMxq4eNH/M6eMES8XLwegpNcaje1S1EcvYKwCxxAIGCqdtchksDRar+XCVAO
        82mV1IU23Ad23+4H+4RL5MKNvn4tgD6Yd2P9FRLndcbVe8Q/GNq0717Opf7B3d+E
        Or7yvypKxYOStRTXGXZWIOENAHyYCQVHsnn4qPUINwJo8w22OCxU2Sqq9lKpIJZS
        DxrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682323808; x=1682410208; bh=bXooH0omr7pzg
        Ugg72ktdVlhPup4UV6iGJc1Um0ngrw=; b=L7nJR1goQxU4Q5sUnTExlPcYs/5qx
        BXpM9Jkm1ZS7L+YffCxU2RUIxjGel6GWW0lUadD6QykZxFORfBgsgrE2Gf5hXkDr
        jiqOd5+mm53/nRncqJHjT2kcn8BsqX6SHiqdA5bJpdwspto4dsk44SHi0Drz78NO
        3CL/lkLUG6N2QTWbBcWtVYBupMZ3tf5NbqLsoPhJXkHSPJ5+1gjREJRAN7wPkeiK
        KNIBkGrDiN3LVuZ79kyKFCAicGr/JTZVD+gZPXUhCTHdXGSqA5hTjHEvgHUiI5nV
        AgMndTCljI3HLEZawdAGNhaMJES5Pdf7ufEyZU46d5sbIL+iBPFdHKy2A==
X-ME-Sender: <xms:YDlGZEGQwHSTXuhrXH4N5s7wC0baHYPRJQhpFVwOIrGAs22ksQk_Yg>
    <xme:YDlGZNXteVmjhI4Ws3alW45-Npz8Emhh-DAA9x9L_JYlQxdTiNGJaf-ofM0R-KhXo
    mE4t68dwsc2CR3QkKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:YDlGZOL5U5IarnwtLJ76vIkXR5LBn1Ohm1D7jdhu2uXSe34A7JiVXQ>
    <xmx:YDlGZGHdfV1Wa0avUyu9VE9MM8EoJJIW--HwhUs_dGQBld2ui1TSFg>
    <xmx:YDlGZKUsLFO3n90Qc0SEGdCV6hKonOIZLLF6jP2dbLPJwxukjuj9AQ>
    <xmx:YDlGZHXcHzCdAhfBM0mLEzTeDvuS-F24kRw11L6_0juBEWDnjhMmaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 452B9B60086; Mon, 24 Apr 2023 04:10:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
In-Reply-To: <20230424073020.4039-1-lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
Date:   Mon, 24 Apr 2023 10:09:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huisong Li" <lihuisong@huawei.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Shawn Guo" <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com, huangdaode@huawei.com,
        linux-acpi@vger.kernel.org, "Len Brown" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:

> diff --git a/drivers/soc/hisilicon/Kconfig 
> b/drivers/soc/hisilicon/Kconfig
> new file mode 100644
> index 000000000000..81768d47f572
> --- /dev/null
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Hisilicon SoC drivers"
> +	depends on ARCH_HISI
> +
> +config KUNPENG_HCCS
> +	tristate "HCCS driver on Kunpeng SoC"
> +	depends on ARM64 && ACPI

Is there a compile-time dependency on ARM64? If not, it would
be good to allow compile testing. At the same time, you
can probably tighten this to ARCH_HISI instead of ARM64,
since no other vendors are going to use it:

       depends on ACPI
       depends on (ARM64 && ARCH_HISI) || COMPILE_TEST

> +
> +#include "kunpeng_hccs.h"
> +
> +/* PCC defines */
> +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
> +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)

Should these perhaps be in include/acpi/pcc.h? The 0x50434300
number is just "PCC\0", so it appears to not be HCCS specific.

> +
> +static int hccs_get_device_property(struct hccs_dev *hdev)
> +{
> +	struct device *dev = hdev->dev;
> +
> +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
> +		dev_err(hdev->dev, "no device-flags property.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
> +		dev_err(hdev->dev, "no pcc-type property.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
> +		dev_err(hdev->dev, "no pcc-channel property.\n");
> +		return -ENODEV;
> +	}
> +
> +	hdev->intr_mode = hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_B);
> +	if (!hccs_dev_property_supported(hdev))
> +		return -EOPNOTSUPP;
> +

Where are the device properties documented? I'm never quite sure how
to handle these for ACPI-only drivers, since we don't normally have the
bindings in Documentation/devicetree/bindings/, but it feels like there
should be some properly reviewed document somewhere else.

Adding ACPI and devicetree maintainers to Cc for clarification. 

> +static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
> +{
> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> +	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
> +	u16 status;
> +	int ret;
> +
> +	/*
> +	 * Poll PCC status register every 3us(delay_us) for maximum of
> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
> +	 */
> +	ret = readw_relaxed_poll_timeout(&comm_base->status, status,
> +					 status & HCCS_PCC_STATUS_CMD_COMPLETE,
> +					 HCCS_POLL_STATUS_TIME_INTERVAL_US,
> +					 cl_info->deadline_us);

Is it both safe and faster to use a relaxed readw here, compared
to the normal one? If there is any access to shared memory
involved, you need the implied barrier for serialization, and since this
is already a sleeping operation, I would guess that you don't care
about the last nanosecond of latency here.

> +static ssize_t hccs_show(struct kobject *k, struct attribute *attr, 
> char *buf)
> +{
> +	struct kobj_attribute *kobj_attr;
> +
> +	kobj_attr = container_of(attr, struct kobj_attribute, attr);
> +
> +	return kobj_attr->show(k, kobj_attr, buf);
> +}
> +
> +static const struct sysfs_ops hccs_comm_ops = {
> +	.show = hccs_show,
> +};

Every sysfs interface needs to be documented in Documentation/ABI/

> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h 
> b/drivers/soc/hisilicon/kunpeng_hccs.h
> new file mode 100644
> index 000000000000..ca557ef115ea
> --- /dev/null
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.h
> @@ -0,0 +1,204 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2023 Hisilicon Limited. */
> +
> +#ifndef __KUNPENG_HCCS_H__
> +#define __KUNPENG_HCCS_H__

Are you planning to add more drivers that share this file? If not,
just fold the contents into the driver itself.

     Arnd
