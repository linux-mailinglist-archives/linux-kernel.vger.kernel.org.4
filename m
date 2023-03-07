Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D436AD877
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCGHtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCGHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:49:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698ED55531
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:49:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cw28so48761898edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 23:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678175378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHHst01TA5pU5y6Mqx0oUARXhiVEXo6JqtZFfQAqjhw=;
        b=ONi4Dm9Wgdc5ktedVMzBP0zI8ILcdIFx9j2mwRLxW75ZJSIFMb3l8hndxHyqAgbc/y
         V4U0sW3FN8jA6K3sXloo7tZwrQ6Z5FugIdCB4NWKOW4udbOPX3sJuz1KXQdwwQf0kYnw
         nMdcgjqHIfI7tjlKZ07/vdyerL4PtI0ywcLNIxUx61yTbk861vPuFLVgsveqA43P0LFY
         eixU81tZxjzipHip9/VF6r9nZiJe07LZfLC2NdEzAVJpBGlfQbcq1HcOe995BCtZDYBx
         IajVW5m4XN1qu3PMR+6ZdQ4hBFpkn2mOq6n2LTY1NN0yhMTAijpePVPeEOYTs4xo3pH3
         sbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678175378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHHst01TA5pU5y6Mqx0oUARXhiVEXo6JqtZFfQAqjhw=;
        b=c5ZWmVDUWo2R8MEK5vvWm9uWpsQ68XwRf9BUZ0bJYYdmC5bvGHYJ0mAT4xrnB3UWq/
         Q5M6LnvgOPTe+svDyL3qhKQpqWHAepsUgdyGNfx7CpvRBydQFMurT6xxHTNqAho3N0D0
         lujyXN5tpjqkDcx15giIq3inh5/MYoLs3BXsXEhITbVtBpl9wpOH/o6JqMTiv12SnHaX
         qObONsju+94QZ5R5wwrb3JCneU1aKUdXqxO+KAAKRfBL5+/LmiO+4t+JlZEJ0rpAYOmW
         G3jATIIFwiKQBD8GYIijrJy2ymwOuonb+DTk34wZgEe4XX4BvvwujeXMqiA9r/Hs8Vu7
         NeSA==
X-Gm-Message-State: AO0yUKW8y53es/fWGtl76vVY+caNkAk7t96qDcgOtDPwepRu5f1JR8tq
        z+tEPsK8WWNsmXm1FfNc0UDk3FZwVHs=
X-Google-Smtp-Source: AK7set86+/bGTqYW6cgMYKZruKv9bFALBAziI3VwIp8wzHrqspWFFjXtP4V9fwBm6cVa7guGlQdRZQ==
X-Received: by 2002:a17:906:edd6:b0:906:4739:d73e with SMTP id sb22-20020a170906edd600b009064739d73emr16860850ejb.2.1678175377858;
        Mon, 06 Mar 2023 23:49:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n8-20020a17090695c800b008c76facbbf7sm5762722ejy.171.2023.03.06.23.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:49:37 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:49:29 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioC_Array
Message-ID: <52bc7f2c-50b8-4bd0-aae6-01efd8091d2c@kili.mountain>
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
 <d8f0e8c7ee6dd820b56636db8d891012aa3ab263.1678051460.git.philipp.g.hortmann@gmail.com>
 <51b147e6-d502-461d-9c29-647ec67e0d38@kili.mountain>
 <de4266bf-a2b5-0b34-1802-7886fbd8351a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4266bf-a2b5-0b34-1802-7886fbd8351a@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:43:50PM +0100, Philipp Hortmann wrote:
> Hi Dan,
> 
> thanks for the review. Here some answers to your questions:
> 
> With patch: "[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x to
> table.x" I changed the filename of r8192E_hwimg.c to table.c and
> r8192E_hwimg.h to table.h to adapt filenames from
> drivers/net/wireless/realtek/rtlwifi rtl8192ee and rtl8192se. Task is from
> TODO file.
> 
> The explanation from the cover letter of this patch series was:

I never read cover letters.  No one is ever going to see the cover
letter when they look through `git log -p` so I don't see the point...

> 
> Rtl8192PciERadioC_Array and Rtl8192PciERadioD_Array contain only two
> values set to 0. Reviewing the other Arrays in table.c and looking into
> other realtek drivers (rtl8192se and rtl8192ee) this arrays are not
> containing valid data.
> 
> Here some more examples of my thoughts:
> 
> A valid filled array is looking like this:
> u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE] = {
> 	0x019, 0x00000003,
> 	0x000, 0x000000bf,
> 	0x001, 0x00000ee0,
> 	...
> 	over 100 lines but no 0x000, 0x00000000,
> 	...
> 	0x004, 0x00000975,
> 	0x007, 0x00000700,
> };
> 
> u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE] = {
> 	0x019, 0x00000003,
> 	0x000, 0x000000bf,
> 	0x001, 0x000006e0,
> 	...
> 	over 30 lines but no 0x000, 0x00000000,
> 	...
> 	0x004, 0x00000975,
> 	0x007, 0x00000700,
> };
> 
> The empty (it is not empty but compared to the ones filled with data it is
> empty) one is looking like this:
> u32 Rtl8192PciERadioC_Array[RadioC_ArrayLengthPciE] = {
> 	0x0,  };
> 
> Looking into other cleaned up drivers from the same family:
> Example: drivers/net/wireless/realtek/rtlwifi/rtl8192se
> Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.
> Example: drivers/net/wireless/realtek/rtlwifi/rtl8192ee
> Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.
> Example: drivers/net/wireless/realtek/rtlwifi/rtl8192de
> Arrays RadioA and RadioB are filled RadioC and RadioD do not exist.
> 
> 
> In Example: drivers/net/wireless/realtek/rtlwifi/rtl8192cu
> I can find a RadioB Array that is just filled with one 0 which is odd:
> #define RTL8192CURADIOB_1TARRAYLENGTH	1
> 
> u32 RTL8192CU_RADIOB_1TARRAY[RTL8192CURADIOB_1TARRAYLENGTH] = {
> 	0x0,
> };
> 
> Here it is written to a variable:
> 
> 		rtlphy->hwparam_tables[RADIOB_1T].length =
> 			RTL8192CURADIOB_1TARRAYLENGTH;
> 		rtlphy->hwparam_tables[RADIOB_1T].pdata =
> 			RTL8192CU_RADIOB_1TARRAY;
> 
> Written to an another variable:
> 
> 		radiob_arraylen = rtlphy->hwparam_tables[RADIOB_1T].length;
> 		radiob_array_table = rtlphy->hwparam_tables[RADIOB_1T].pdata;
> 
> 
> And then accessed after with i + 1 the element that is random/undefined.
> 
> 
> 	case RF90_PATH_B:
> 		for (i = 0; i < radiob_arraylen; i = i + 2) {
> 			rtl_rfreg_delay(hw, rfpath, radiob_array_table[i],
> 					RFREG_OFFSET_MASK,
> 					radiob_array_table[i + 1]);

You make a really compelling argument that the code in rtl8192cu
should be deleted, but that's a different driver from what we're
discussing here.

> 		}
> 
> May be another patch.
> 
> I hope this can convince you that Arrays for RadioX that do only contain one
> or two 0 are not in use.

I can easily be convinced of that, but that's not what the commit
message says.  The commit message says the array is "empty" and that
you are deleting "dead code".  When actually you're deleting a call to
rtl92e_set_rf_reg().  So the commit message is just wrong about the
facts.

What you need to do is figure out what the call to rtl92e_set_rf_reg()
does and why it's not required.

I don't have a problem with this *patch* but the commit message says
things which are false.

regards,
dan carpenter

