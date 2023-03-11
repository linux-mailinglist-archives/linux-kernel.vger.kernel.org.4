Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB936B5829
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 05:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCKEQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 23:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCKEQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 23:16:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AEB115DF8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:16:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h14so6830503wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678508185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ1eeqmPCIB2yO855GUqLYB3SG0cWG5CCnQ7/1cNu2o=;
        b=jIeJIOLLGVVM5N6JHLEMYkKL8y0bCVrSEAoj3w9Nk0tZZwPHhGIUETvgT9NRDX6Eqx
         +dRwM8+zAyfC+63OgUu0a4V3n4qewOfUUWr5fr9/OiDiRbCmUYzZXeq40vaosk/49V0U
         nTBSi1TN7JOgdPMBSY7qUAvZCB9FGlsILQZV/7HEka7funKPNBWBDT8HyKkfTTmZ6jmC
         Hi8nYMDsp57VlxGuQ5Fz+aRgMKWNVumZ3eDkFPCG/TAVnojyd2NlSyfxhhkOoIkDpECK
         JVMntykERbTfBC1hHAOgANseFkoR3ZG0vDQGKZZ13N8qgWYhChUrf12c9A8WrExE2IhR
         eHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678508185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ1eeqmPCIB2yO855GUqLYB3SG0cWG5CCnQ7/1cNu2o=;
        b=2Qwy8mE6RNxgIDRLdMkVmsa2/ABd2+p8mfi6MeDiJHXtqCPZOQNez8w/NKMfSBsRiR
         O4+Gch4D9wXsrVJIq9h5xvoBt/rup6VMYNgNQT9VZ/JJe7xVjnxP+6YQAhTS5jXhNdFV
         LtR8ebUWokCdisRQ/muAjxqqMur6Op4cchTTbWR5Opbnqg/6yu6RllRpLGX7Z05IqINk
         nVFOkmHNPj+qktbIRNtPcg0MQj6cD72tm991TRXaTulMY2fZqUjiCmNbbHR/laH6xnFT
         HZnHA+R1NyypkWiFkdebh6WZkDbTbGbu9DQWqnq/Nc+MJn6DzUedb6STzbggDqFIkZxy
         BkgQ==
X-Gm-Message-State: AO0yUKWYSau32F2+/Sf+3B8EMaQNG760hDz4fazbjQKoMC5stZ95poCy
        MVnBDCKJ3JgjiIIABO71nHuqZ6bfRo7FyA==
X-Google-Smtp-Source: AK7set9wqGdBLke8/AXSOYkqEqTSGAiOyaNSJkBw2QuiXFdlDlX1JGE/Id1kDqIXO1jD2BPpFlwflg==
X-Received: by 2002:a5d:5410:0:b0:2c7:5ad:9c69 with SMTP id g16-20020a5d5410000000b002c705ad9c69mr14484486wrv.71.1678508185051;
        Fri, 10 Mar 2023 20:16:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d4105000000b002ce92af57b2sm1316961wrp.42.2023.03.10.20.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:16:24 -0800 (PST)
Date:   Sat, 11 Mar 2023 07:16:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <6e9fd119-6566-4778-899e-bc5a7ee7830c@kili.mountain>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:18:04AM +0500, Khadija Kamran wrote:
> In file drivers/staging/greybus/arche-platform.c,
> - Length of line 181 exceeds 100 columns, fix by removing tabs from the
>   line.
> - If condition and spin_unlock_...() call is split into two lines, join
> them to form a single line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changes in v2:
>  - Change the subject and log message
>  - Merge if condition and spin_unlock...() from two lines to one 

Apply your patch and then re-run checkpatch.pl -f on the file.  You will
see the problem.

regards,
dan carpenter
