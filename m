Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD636D4E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjDCQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjDCQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22A186
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680540461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQwDcCskXBeDCSbmN6IgStKJCOu+oFfxGictYR2Li9Q=;
        b=YuidDRsxZcN+J/VK+z1awd04XJC9pXBxS9P+RYLexLaZMQQatNC0oF/4RI/UJR7lC9fiOj
        EUfKGCUh2fewUgLrvJTTNte0sOtDVOVgMlcXLKsqmLmmPgg3Ie0Sa7Trb4cLlGY4lowYJd
        jUsTANmMKE5wQj+SyggAvmCHIHudqPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-l_YbXRY4NnSAbLEpAqh82A-1; Mon, 03 Apr 2023 12:47:37 -0400
X-MC-Unique: l_YbXRY4NnSAbLEpAqh82A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9594185A790;
        Mon,  3 Apr 2023 16:47:36 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B696A2166B26;
        Mon,  3 Apr 2023 16:47:34 +0000 (UTC)
Date:   Mon, 3 Apr 2023 18:47:32 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Torsha Banerjee <torsha@chromium.org>
Cc:     u-boot@lists.denx.de, Jing <jingyliang@chromium.org>,
        Sean <seobrien@chromium.org>, Jora Jacobi <jora@google.com>,
        Harry Cutts <hcutts@chromium.org>,
        Torsha Banerjee <torsha@google.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Series-to: LKML <linux-kernel@vger.kernel.org>
Message-ID: <20230403164646.zwqluchagef34bei@mail.corp.redhat.com>
References: <20230331224536.1685149-1-torsha@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331224536.1685149-1-torsha@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsha,

Well, your commit title is just wrong, it should not start by
"Series-to: LKML ", which seems very much like a badly configured client
;)

On Mar 31 2023, Torsha Banerjee wrote:
> From: Jora Jacobi <jora@google.com>

This is much better than v1: we got the from and a matching S-o-B :)

So thanks for that.

> 
> Restore missing cursor for digitizer devices
> 
> A previously committed patch to remove cursors for HID Digitizer-Pen
> devices also removed the cursors for some tablets which have incorrect HID
> descriptors. These devices should enumerate with Usage ID "Digitizer"
> instead of Usage ID "Pen".
> 
> Patch which introduced the issue: commit 8473a93d1ba5
> ("HID: input: Set INPUT_PROP_-property for HID_UP_DIGITIZERS")
> 
> Changes-
> Add HID quirk HID_QUIRK_DEVICE_IS_DIGITIZER
> Quirk will force INPUT_PROP_POINTER for HID Digitizers
> Apply quirk to Huion tablets
> Apply quirk to UGEE/XP-Pen tablets based on device ID
> 
> Tested with Huion H640P and H430P. Connected the digitizer to the
> Chromebook and confirmed with a drawing program that the cursor appears and
> moves when the digitizer's stylus is hovering over the surface of the
> digitizer.

Would you mind re-testing the issue against the branch for-6.4/core of
hid.git[0]

IIRC UCLogic tablets where having an issue after Commit f7d8e387d9ae
("HID: uclogic: Switch to Digitizer usage for styluses") and it was
manually fixed in 3405a4beaaa8 ("HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE
quirk")

One proposed solution was to use a0f5276716c8 ("HID: Recognize "Digitizer"
as a valid input application"), and given that it was slightly broader,
I was initially reluctant to take it.

Given that Huion tablets tend to use hid-uclogic, I hope that it's
already fixed, and we don't even need to do more work to have your problem
resolved.

Cheers,
Benjamin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.4/core

> 
> Signed-off-by: Jora Jacobi <jora@google.com>
> Reviewed-by: Harry Cutts <hcutts@chromium.org>
> Signed-off-by: Torsha Banerjee <torsha@google.com>
> ---
> 
>  drivers/hid/hid-input.c  | 3 ++-
>  drivers/hid/hid-quirks.c | 9 +++++++++
>  include/linux/hid.h      | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7fc967964dd8..f0c67baddc8d 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -927,7 +927,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		break;
>  
>  	case HID_UP_DIGITIZER:
> -		if ((field->application & 0xff) == 0x01) /* Digitizer */
> +		if (((field->application & 0xff) == 0x01) ||
> +			(device->quirks & HID_QUIRK_DEVICE_IS_DIGITIZER)) /* Digitizer */
>  			__set_bit(INPUT_PROP_POINTER, input->propbit);
>  		else if ((field->application & 0xff) == 0x02) /* Pen */
>  			__set_bit(INPUT_PROP_DIRECT, input->propbit);
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 66e64350f138..094fe4c4f3b3 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -102,6 +102,8 @@ static const struct hid_device_id hid_quirks[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941), HID_QUIRK_ALWAYS_POLL },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641), HID_QUIRK_ALWAYS_POLL },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_HS64), HID_QUIRK_DEVICE_IS_DIGITIZER },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET), HID_QUIRK_DEVICE_IS_DIGITIZER },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
> @@ -1298,6 +1300,13 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
>  		quirks = hid_gets_squirk(hdev);
>  	mutex_unlock(&dquirks_lock);
>  
> +	/*
> +	 * UGEE/XP-Pen HID Pen devices which have 0x0-0x9 as the low nibble
> +	 * of the device ID are actually digitizers, not HID Pen devices
> +	 */
> +	if (hdev->vendor == USB_VENDOR_ID_UGEE && (hdev->product & 0x0F) <= 0x09)
> +		quirks |= HID_QUIRK_DEVICE_IS_DIGITIZER;
> +
>  	return quirks;
>  }
>  EXPORT_SYMBOL_GPL(hid_lookup_quirk);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 1ea8c7a3570b..1653359002b3 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -354,6 +354,7 @@ struct hid_item {
>  #define HID_QUIRK_INPUT_PER_APP			BIT(11)
>  #define HID_QUIRK_X_INVERT			BIT(12)
>  #define HID_QUIRK_Y_INVERT			BIT(13)
> +#define HID_QUIRK_DEVICE_IS_DIGITIZER           BIT(14)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
> -- 
> 2.40.0.348.gf938b09366-goog
> 

