Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2955261E05E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKFFfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKFFfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:35:15 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6F62E1;
        Sat,  5 Nov 2022 22:35:10 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id g62so7892680pfb.10;
        Sat, 05 Nov 2022 22:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdcHygyluxlSKZYhnOmBthfqKtj/GWkjEK+v9KvjztY=;
        b=fW6UwGe8o/Ye2VvIC4G/mRQYZUqUzC3TICxqAIhCgigDzUlNKtzQZ3DWpWaSIS7Dx0
         Lj0mYdsFtfLSb/VXvUGMe4G1U3O09R1Ialntx4TNGj/8wU+QOBn6ivqyvZOZDScyOwG/
         +1vyZUR+7Zq/qBzjZ/d4bWsCRCPY2MgR+/H16B30r3F1N9jqhH0FP4LeeYisW9MQe6Cw
         k8oS33/VpzLXjqnQzuYp1JXwCciUAyDfC1npGZheSNYzNBI2yjI8yLse6raoOV7DJnPe
         qq1dpVRxoLoQD+6fWi+XU6L41P0fWEfijhddktjTZEr8l8jBLzBK3KjzLRsBKIam7FOw
         00TA==
X-Gm-Message-State: ACrzQf1XqOlAZRrRq/8j5rrQFF5XpJZbN31Jccf9VS2pWG1iom/dp3/y
        jmfxdJ8Lqus9pt9JPPqzdZ6rd8CUQIRBWrgYlFyPD4Ic28UlSQ==
X-Google-Smtp-Source: AMsMyM7Q8GwZh9SKm3Tco3931Q8FVqiPXIX2xv52FjuT3th+35TD7IfyBqv8xJC1D1lvq8zZgm1YJMpabzvuqegeaYI=
X-Received: by 2002:a65:6894:0:b0:470:76d:6f4a with SMTP id
 e20-20020a656894000000b00470076d6f4amr19455046pgt.457.1667712910263; Sat, 05
 Nov 2022 22:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr> <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com> <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com> <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
In-Reply-To: <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 6 Nov 2022 14:34:58 +0900
Message-ID: <CAMZ6Rq+hc+YObxCAFL8Go3gvc8budzdaxLZY2b4GexcG1xHzdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun. 6 Nov. 2022 at 09:48, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, Nov 05, 2022 at 06:38:35PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Nov 06, 2022 at 02:21:11AM +0900, Vincent MAILHOL wrote:
> > > On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
> > > <mailhol.vincent@wanadoo.fr> wrote:
> > > > On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > It's late right now, and I can't remember the whole USB spec, but I
> > think the device provides a list of the string ids that are valid for
> > it.  If so, we can add that to sysfs for any USB device out there, no
> > matter the string descriptor number.
>
> No, there is no such list.
>
> > If not, maybe we can just iterate the 255 values and populate sysfs
> > files if they are present?  I'll dig up the USB spec tomorrow...
>
> Yes, we could do that.  But the filename would have to be the string
> id, which is not meaningful.  We wouldn't be able to have labels like
> "product-info" unless somehow a driver could provide the label.

My shot on this would be like this:

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..d0a4fc3ffe07 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -77,6 +77,19 @@ struct ieee1394_device_id {
  * Use the flag values to control which fields are compared.
  */

+/**
+ * struct custom_string - information of custom string and their indexes
+ * @idx: Index of the custom string descriptor.
+ * @label: Mnemotechnic, will be used as a filename for the sysfs entry.
+ *
+ * USB devices might expose some information in some customs strings. Drivers
+ * can use this structure to inform the USB core of where to find these.
+ */
+struct custom_string {
+       __u8 idx;
+       const char *label;
+};
+
 /**
  * struct usb_device_id - identifies USB devices for probing and hotplugging
  * @match_flags: Bit mask controlling which of the other fields are used to
@@ -110,6 +123,9 @@ struct ieee1394_device_id {
  * @driver_info: Holds information used by the driver.  Usually it holds
  *         a pointer to a descriptor understood by the driver, or perhaps
  *         device flags.
+ * @customs_strings_table: devices using customs strings can use this table to
+ *         inform the USB core of how to retrieve them. If used, must
contained an
+ *         empty terminating entry.
  *
  * In most cases, drivers will create a table of device IDs by using
  * USB_DEVICE(), or similar macros designed for that purpose.
@@ -150,6 +166,7 @@ struct usb_device_id {
            /* not matched against */
            kernel_ulong_t  driver_info
                        __attribute__((aligned(sizeof(kernel_ulong_t))));
+           const struct custom_string *custom_strings_table;
 };

 /* Some useful macros to use to create struct usb_device_id */


Then the driver would declare its custom stings like this:

  static const struct custom_string es58x_custom_strings_table[] = {
          { .idx = 6, .label = "product_info" },
          { /* Terminating entry */ }
  };


Finally, the USB core can iterate through it and populate the sysfs
entries using the provided label.


> Also, there's the matter of language.  Devices can have string
> descriptors in multiple languages; which one should we show in sysfs?
> All of them?  Right now we use just the default language for the strings
> that we put in sysfs.

I do not have the knowledge to comment on the multiple languages
issue. FYI, the device which I maintain does not have multiple
languages.

> > I say do this at the USB core level, that way it works for any USB
> > device, and you don't have a device-specific sysfs file and custom
> > userspace code just for this.
>
> This is unavoidable to some extent.  Without device-specific information
> or userspace code, there is no way to know which string descriptor
> contains the data you want.

ACK. I also do not want any userspace code for that. Users should not
need to know a magic number to retrieve the thing.

> Alan Stern
>
> > Sound reasonable?
> >
> > greg k-h
