Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8186C0A57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCTGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTGEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:04:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FF1E9E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:04:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so42240250edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A11SfBm/pI4da/gudCiiVZOvwgbzs3utDkJyaSybDSQ=;
        b=LOkqp6v93iTfNHOsO15LEekj4+LrPnF66Ie2aE61djd5a038Aua/yJOXWQk8KYtTbv
         Wykarc1Gb68HXvkkOQXIsx9YhdGlFhCUY2vJxTM361oO4FRUm8iE9aV0nvd6Bnq6C+un
         7z2TFG6pxerFqBH7Q2aS/tn+TsQyQUA7fY47hKx2xm8JHcMIgBG/bzgqlyMsOxCeE+SD
         LBbTu0wPjUm3ZNMqhWxD9ULAziteIgk0jAECRJtfr0/2nsoAur9YeZs1wJrhq05bc3VK
         k7CayGH/gqTMWVp2OKdNEhziiw3PMKp+eraSxGKVCINhOP4PML/lmjDCwQoGCVIITQuv
         FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A11SfBm/pI4da/gudCiiVZOvwgbzs3utDkJyaSybDSQ=;
        b=bUa2vDl7Fkaaq1lbimvktngAUzzScZ73xggnwp5xLnh2o+rXeJi3f6eYbheF18NLgD
         MzDU11PUTpGU23LvwL+C6GckHXJEfj+5+CCmV9V9rm31EQIrBmj+hGImptFf8rLezVco
         3V4GZ/Fn92XxZ2Mq2FMIDltcfKr/yIpAUKSIE+Gy20GhvHL87wKxPckXnyiKIDACr4dW
         H2yOJZKOwSGS0zEPKcRKbKlHPQms4Z6OnxvVCfND2HhS1yorTiW4EXjYiVIvPo4wpuHl
         PSR6zh9p+QS5LJ1oP3tI6Skh/qlgYc96mz09bd1EB+Yqtg5GVmWBP+ohrfCJFNO3oxhu
         4DOA==
X-Gm-Message-State: AO0yUKVNliX0XCC0s4RR72PrgIzNmyK/PqhkVOlonPhyJZZRVSTnkgGU
        L5MH0XgxVdGavo5HRj0hFbaeyD+w0XdCpz5j
X-Google-Smtp-Source: AK7set/ntxn1gQ91zZ0a2omvH6S6l21+8jEpi9+WiSI2458v+15+7OitTW1/O5sW704FTZapNGEYFA==
X-Received: by 2002:aa7:c1cb:0:b0:4fb:953d:c3d0 with SMTP id d11-20020aa7c1cb000000b004fb953dc3d0mr12122441edp.20.1679292277222;
        Sun, 19 Mar 2023 23:04:37 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402520200b004bbb691a334sm4316449edd.2.2023.03.19.23.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:04:36 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:04:34 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBf3cqP4DxyRzn8M@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
 <2162728.C4sosBPzcN@suse>
 <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
 <3531852.LM0AJKV5NW@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3531852.LM0AJKV5NW@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:17:52PM +0100, Fabio M. De Francesco wrote:
> On giovedì 16 marzo 2023 19:35:09 CET Khadija Kamran wrote:
> > On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:
> 
> [snip]
> 
> > > When you are done with build, install, and final reboot to test if your
> > > module can "modprobe" or "insmod" (i.e. link with the running custom 
> kernel
> > > you built, installed and boot), try to compare the output of the following
> > > commands:
> > > 
> > > # uname -a
> > > Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 UTC
> > > 2023 (44ca817) x86_64 x86_64 x86_64 GNU/Linux
> > 
> > The above command works
> > 
> > > AND
> > > 
> > > # modinfo <name of the module you are testing here>
> > 
> > On running 'modinfo axis-fifo' I get error saying module axis-fifo not
> > found.
> 
> I built axis-fifo with your changes and then I ran "make install 
> modules_install" in a QEMU/KVM x86_32 VM that I use on a Linux host for 
> testing my patches (Linux on Linux).
> 
> tweed32:~ # uname -a
> Linux tweed32 6.3.0-rc2-x86-32-debug+ #32 SMP PREEMPT_DYNAMIC Thu Mar 16 
> 18:09:49 CET 2023 i686 athlon i386 GNU/Linux
>

Hey Fabio!

The following command is not working for me. I think I have mentioned
this before, it says, module axis-fifo not found.

Thank you!

Regards,
Khadija

> tweed32:~ # modinfo axis-fifo 
> filename:       /lib/modules/6.3.0-rc2-x86-32-debug+/kernel/drivers/staging/
> axis-fifo/axis-fifo.ko
> description:    Xilinx AXI-Stream FIFO v4.1 IP core driver
> author:         Jacob Feder <jacobsfeder@gmail.com>
> license:        GPL
> srcversion:     EBF46AD6851EAAE67D1000B
> alias:          of:N*T*Cxlnx,axi-fifo-mm-s-4.1C*
> alias:          of:N*T*Cxlnx,axi-fifo-mm-s-4.1
> depends:        
> staging:        Y
> retpoline:      Y
> intree:         Y
> name:           axis_fifo
> vermagic:       6.3.0-rc2-x86-32-debug+ SMP preempt mod_unload modversions K7 
> parm:           read_timeout:ms to wait before blocking read() timing out; set 
> to -1 for no timeout (long)
> parm:           write_timeout:ms to wait before blocking write() timing out; 
> set to -1 for no timeout (long)
> 
> Do you see the "parm" lines? What's the type of read and write_timeout?
> 
> Fabio
> 
> 
