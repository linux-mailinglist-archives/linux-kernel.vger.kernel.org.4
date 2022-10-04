Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF05F3BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJDDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJDDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:54:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365AA45E;
        Mon,  3 Oct 2022 20:54:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b2so6714476plc.7;
        Mon, 03 Oct 2022 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=t68JD1LRSTUwiOm802DHOi8HVYbNo1SEL5P3KG0KYLk=;
        b=AWMtfH+JoFgOUei7K3blEpTgsCrHAxADwH6DiHlEkzfPtf6nrbCHPuPejKofUK8GcU
         kiTkQ90VY+CG0eWUgmMmeq4qzb5l9fz9BFCeuAUw8YMfARYjA6w08ZdFTBvf1Q8auMBo
         kIci3Z3F0wN7fUABgSCUkYgUPyAfRup4ZekG5HYrjzVbwoxMdTYHAGELdQHG2UJ1YVcN
         qMBYNs4v7KF5uFsjZsDC0seBmGYnZ9DrroaEgxO0S7QsfFpKXRrXMScADwli9HdxHSm5
         B49JIOtoO/sry8JweWP9eSfdcqcozm4Mzfh+LOglX7ODY3GviyzgcfnoMc/IHUqAWwvt
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t68JD1LRSTUwiOm802DHOi8HVYbNo1SEL5P3KG0KYLk=;
        b=BUWcxG3r8kVZ9cVP92UZ9F0lMww3d0eJ7rwS5FlIzzi9nTMUhCHkkTYzLBYR3AtvKC
         PO6xGTHn+gec8y7RTQFjzBIatF10/QeXGcIqRebfCFGPM/lOUX89Yi6a9aFU9WFgTEHZ
         jrrygu3ekNYJDMstGgFrzXEjdZxoHYQdJMUPEQjNRtg6UCQA6QsBnpA/18uU/EDoUloZ
         08dUmtx2GS/DG/quOHkUG1H5KDeJ84pXrETJcV8Ml5WrP+2eyVb5LRmWJNNOHCzWou9x
         IQXi0YgdRCyYBW/5h9e1Wfs0bjo7iWeBDbClJTKf3vw8XWjGVw8HjNtEp1vvKOB53TsO
         RNFg==
X-Gm-Message-State: ACrzQf1Y9WfJlbPNkrVSAjdc7WFuC9f+Va6px0R14LfVbPRDIVfT+dRQ
        tc7FFd4jJh6RXEpevC4YDIk=
X-Google-Smtp-Source: AMsMyM7+9TYSUuPCfy6syHO0fgovIAUgA0zhvpmhWV0lyS/dxInXUMCqICYJeLa1DJB9RRcTfGGpIA==
X-Received: by 2002:a17:90a:4588:b0:205:d605:8bcc with SMTP id v8-20020a17090a458800b00205d6058bccmr15620463pjg.205.1664855691737;
        Mon, 03 Oct 2022 20:54:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:85c4:e70d:dcc0:91e1])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a4dc100b001efa9e83927sm10766208pjl.51.2022.10.03.20.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 20:54:50 -0700 (PDT)
Date:   Mon, 3 Oct 2022 20:54:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Daniel Hung-yu Wu <hywu@google.com>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: misc - atmel_captouch does not depend on OF
Message-ID: <YzuuiJwdtnHYQK1G@google.com>
References: <20221003172953.30354439@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003172953.30354439@endymion.delvare>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Mon, Oct 03, 2022 at 05:29:53PM +0200, Jean Delvare wrote:
> The atmel_captouch driver does not actually depend on OF, it includes
> a non-OF device ID which could be used to instantiate the device, and
> the driver code is already prepared to be built with or without OF. So
> drop the unneeded dependency.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Daniel Hung-yu Wu <hywu@google.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> The problem I'm trying to solve here is that "depends on OF ||
> COMPILE_TEST" does not make sense since OF can now be enabled on all
> architectures. One way to fix this is by removing the dependency
> altogether (this patch).
> 
> If the driver is known to be needed only on OF-enabled systems then we
> could leave the dependency on OF and only drop COMPILE_TEST (and
> simplify the driver code accordingly). I have an alternative patch
> doing that already. Tell me what you prefer, I'm fine either way.

The driver is not operable on systems without OF:

static int atmel_captouch_probe(...
	...

	node = dev->of_node;
	if (!node) {
		dev_err(dev, "failed to find matching node in device tree\n");
		return -EINVAL;
	}

	if (of_property_read_bool(node, "autorepeat"))

So the reason for "depends on OF || COMPILE_TEST" is to avoid prompting
users who actually try to configure real systems for drivers that make
no sense for them while still allowing people interested in compile
coverage to select COMPILE_TEST and enable more drivers.

Thanks.

-- 
Dmitry
