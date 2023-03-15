Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17B6BB5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjCOOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjCOOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:22:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530177B9AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:22:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z21so10912450edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678890162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyMDQCOfBAZusZX5jSmhyE2oTgujKm5FjLZ6IDt+eWw=;
        b=Lhf966giEYD7DdgGJ+Tz1IuYvaioY68FS6sfbPCAREGADGZFyDV32s+eTuDrrgcreZ
         mi/qz9Hn+sfnFj9f9650ii2tB9jHqfi2hZJzYA+x2lYPGk0HtgOqilDYUykpypoxF+2P
         tn8nYH/mo6sUqGyzdxzURP839qlrCT4V4CFcSQiiRsQQkO+ESY+zWwJL7eIrolvamIFO
         VJq5uyb5YtxoojAAo40Q/bwdDkJMt8s3laEDaukNqI13/Ds8aRIaLn0WsFv+kMN/nkAu
         +cLZ3g1t85lsHNczlGLyWzleyyS7W5lVNZNjO0fEsT5Cjcml9Pf2NFfJg0IKh4M1MOiA
         +pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678890162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyMDQCOfBAZusZX5jSmhyE2oTgujKm5FjLZ6IDt+eWw=;
        b=RFcrpzPvw9Zs5o2iELceYAQQ69oJqABq1xc5/QHX8JeR0uKQMSl0C/PRsB6Q3HR4Tc
         z7zpxS5qMRroCwgn3muq7yehIhmWJ560kC3V6eDYHR3uxyh6WLl713YH5SFdcveyt4LN
         7yK5bCkaXBO0doXCeUFdXoDX+LD8/6j0tkFjS8CZ1ljO8gRBTdxgtqrjPockD40G92X3
         AtO7O+ANpCSbnkEM2kfIe4z9ddLcbDuja4p2+mTKmBJrJdLPvdNffHYmiun7Mu5Qg1XQ
         ovPQ3mfs9r9DJpgehTm6ePwtXXW18wj8+D2QWtNjol3rre/2CvPgeE73ObZHppZYUvaC
         yXvQ==
X-Gm-Message-State: AO0yUKUPAfVm40W06XHu5GPUzxkxo0NpsZvoG5NsiTHDK7U0w1e/Mz9T
        qe2Oz6MpkCYr5GHMNfeBvd46Q5yS2SzXw5fm
X-Google-Smtp-Source: AK7set/cq7DV7NTF6kHldxZalTeU1yLLUdwXpYOBY3rGJHSRtrA5447S7BksGJ6MrvGukEvzmE+UHA==
X-Received: by 2002:a05:6402:4d1:b0:4fa:ba60:8188 with SMTP id n17-20020a05640204d100b004faba608188mr3149556edw.8.1678890162551;
        Wed, 15 Mar 2023 07:22:42 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id 18-20020a508e12000000b004fa380a14e7sm2531501edw.77.2023.03.15.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:22:42 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:22:39 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <16148020.1MiD057Pog@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16148020.1MiD057Pog@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> Aside from what I said and asked for with the other message of this same 
> thread, please take note that you can build a specific module if you prefer 
> not to re-build the whole kernel and other modules at the same time. 
> 
> I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch 
> tutorial.
> 
> If they are not there, please let us know.
> 
> Fabio

Hey Fabio!

In the Outreachy FirstPatchTutorial under the 'Compiling only part of
the kernel' section there are ways to compile only some part of the
kernel.

I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
'nothing to be done for'. 

Should I start with the steps to reproduce? :'(

Thank you!

Regards,
Khadija


> 
> 
> 
