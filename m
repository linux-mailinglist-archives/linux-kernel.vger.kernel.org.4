Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6968E979
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBHIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:00:30 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369440FC;
        Wed,  8 Feb 2023 00:00:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 39F175C0159;
        Wed,  8 Feb 2023 03:00:28 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Wed, 08 Feb 2023 03:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675843228; x=1675929628; bh=8a
        gNTG0hQt/eC3ReaOgmb+ialq3AlFxZ6I2fQbsi+14=; b=PCRy9bxBY32tqTbyz8
        GR4JCHlfGsJHRDvHf29CDF7AkxDiD7VemFOUgHH2mHl6BLVuBWNn8q/MqHwO7rVS
        lSqlQRU2ZPKMdoEHsmf7hyaKonGLXSRgro7X2JmCJY9WWhokkImrzylKDKxYrYbC
        Jk/V/l2hktD7pZr+vgsowYtoWctpWAxzeZHh/AYu3oK/FSh6xS8PQxOXIcp1ouwU
        vlZzZXD5U6uwDikht4o77s8RW7mB5QRPJDy/cvvk80MHZn8aDMF1gy7PIf/AbruC
        /XFUBODt03MZ19apsEllJcUaz5lc5tivMlqdwfwGCGNMDSDepUnVBJFSLhbYKZNC
        ZQJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675843228; x=1675929628; bh=8agNTG0hQt/eC3ReaOgmb+ialq3A
        lFxZ6I2fQbsi+14=; b=f60gf+1I4yuNID7DY59wbB7edcO4q2a728wtl/l2sE76
        ySKhE1qPJvVu1ThnFlV7Ah2oDVQJcg6AXz62PuOSLUasHQ+ZS9WDeujx9p8DslW1
        7YLFevq1DvrQA7wQbXOq2Q6Iz18tMNZ5oJPF32BL/lUP+7fi75b8jB5UwGLc+Bfj
        jFBmiYSd03T82AcK97tlMiOa7ACIrqG3+pG7+EVBzNCJU144myegDlo1zvD0Iur7
        cxo9/IqJe4xNsDOmOFVMhIQQmgQt8VF3zLzdreyWB23XMOcI2JY8fPELiURuXetT
        QJgitk1QwuCDpKxnt4wZV/fSNFxPGpKU7Ts/YGb0sA==
X-ME-Sender: <xms:m1bjY4hEVLUnsXrjOV3RTP_8ozPil0K3VK-LIApywrWd2kwy2nLYUA>
    <xme:m1bjYxB6yU-yFY-LYc1iJMYiLBM-CvF4tXNmm5Skc_KxdIb1vkfG7s8BmcmIT0EyF
    nO7iCn3d51qupKo8B4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegledgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomheptehl
    ihhsthgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtf
    frrghtthgvrhhnpeeukeffkefhjeethedtieegudejvedvhfejleekheefhfdufffhjefg
    jeeiheehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:nFbjYwGxk1qH3bUJDwb4CLdfWgoXLSb4bsmTFa6bTK15SNHVNQffng>
    <xmx:nFbjY5SvuJHsvOYv_O0bbsooC4UKGGtuNFTcDHmkm-TtawYbWOpYzg>
    <xmx:nFbjY1x-FWqVblD39Ij5aykNGFCHtLzBj8Lmzrc8YorLepY1Z7E0lw>
    <xmx:nFbjY4pM-bTLHqdCmkIhDH_W4jlmhsBOdqL8BwA2pIGM_admrZpQ5g>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E8DDC2D40074; Wed,  8 Feb 2023 03:00:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <501a6242-c377-4c71-9659-44ddfac00ba7@app.fastmail.com>
In-Reply-To: <Y+LYwu3Zs13hdVDy@google.com>
References: <Y+LYwu3Zs13hdVDy@google.com>
Date:   Wed, 08 Feb 2023 18:00:27 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
Cc:     "Guenter Roeck" <groeck@chromium.org>,
        "Allen Ballway" <ballway@chromium.org>,
        "Hans de Goede" <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: retain initial quirks set up when creating HID devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023, at 9:03 AM, Dmitry Torokhov wrote:
> In certain circumstances, such as when creating I2C-connected HID
> devices, we want to pass and retain some quirks (axis inversion, etc).
> The source of such quirks may be device tree, or DMI data, or something
> else not readily available to the HID core itself and therefore cannot
> be reconstructed easily. To allow this, introduce "initial_quirks" field
> in hid_device structure and use it when determining the final set of
> quirks.
> 
> This fixes the problem with i2c-hid setting up device-tree sourced
> quirks too late and losing them on device rebind, and also allows to
> sever the tie between hid-code and i2c-hid when applying DMI-based
> quirks.
> 
> Fixes: b60d3c803d76 ("HID: i2c-hid-of: Expose the touchscreen-inverted properties")
> Fixes: a2f416bf062a ("HID: multitouch: Add quirks for flipped axes")
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Tested-by: Allen Ballway <ballway@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> 
> v2:
> - corrected spelling/grammar in the commit message per Guenter
> - added reviewed-by/tested-by tags
> 
> 
> drivers/hid/hid-quirks.c                 | 8 +-------
> drivers/hid/i2c-hid/i2c-hid-core.c       | 6 ++++--
> drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 1 -
> include/linux/hid.h                      | 1 +
> 4 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 30e35f79def4..66e64350f138 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -19,7 +19,6 @@
> #include <linux/input/elan-i2c-ids.h>
>  
> #include "hid-ids.h"
> -#include "i2c-hid/i2c-hid.h"
>  
> /*
>   * Alphabetically sorted by vendor then product.
> @@ -1238,7 +1237,7 @@ EXPORT_SYMBOL_GPL(hid_quirks_exit);
> static unsigned long hid_gets_squirk(const struct hid_device *hdev)
> {
> const struct hid_device_id *bl_entry;
> - unsigned long quirks = 0;
> + unsigned long quirks = hdev->initial_quirks;
>  
> if (hid_match_id(hdev, hid_ignore_list))
> quirks |= HID_QUIRK_IGNORE;
> @@ -1299,11 +1298,6 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
> quirks = hid_gets_squirk(hdev);
> mutex_unlock(&dquirks_lock);
>  
> - /* Get quirks specific to I2C devices */
> - if (IS_ENABLED(CONFIG_I2C_DMI_CORE) && IS_ENABLED(CONFIG_DMI) &&
> -     hdev->bus == BUS_I2C)
> - quirks |= i2c_hid_get_dmi_quirks(hdev->vendor, hdev->product);
> -
> return quirks;
> }
> EXPORT_SYMBOL_GPL(hid_lookup_quirk);
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 0ab8f47a84e9..efbba0465eef 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1025,6 +1025,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
> hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
> hid->product = le16_to_cpu(ihid->hdesc.wProductID);
>  
> + hid->initial_quirks = quirks;
> + hid->initial_quirks |= i2c_hid_get_dmi_quirks(hid->vendor,
> +       hid->product);
> +
> snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
> client->name, (u16)hid->vendor, (u16)hid->product);
> strscpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
> @@ -1038,8 +1042,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
> goto err_mem_free;
> }
>  
> - hid->quirks |= quirks;
> -
> return 0;
>  
> err_mem_free:
> diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> index 554a7dc28536..210f17c3a0be 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> @@ -492,4 +492,3 @@ u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product)
>  
> return quirks;
> }
> -EXPORT_SYMBOL_GPL(i2c_hid_get_dmi_quirks);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index daaac4d7f370..56dac09c99d9 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -622,6 +622,7 @@ struct hid_device { /* device report descriptor */
> unsigned long status; /* see STAT flags above */
> unsigned claimed; /* Claimed by hidinput, hiddev? */
> unsigned quirks; /* Various quirks the device can pull on us */
> + unsigned initial_quirks; /* Initial set of quirks supplied when creating device */
> bool io_started; /* If IO has started */
>  
> struct list_head inputs; /* The list of inputs */
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
> 
> -- 
> Dmitry
> 
