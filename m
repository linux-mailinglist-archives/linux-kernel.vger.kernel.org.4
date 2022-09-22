Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F905E5ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIVFac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIVFaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:30:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A73ABF13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u132so8197893pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=29krL0qvuFg0KCphJZfO0u7z2tvgm5X6ahpdbCTG5JM=;
        b=n2CDFCVq+NijhKq28N0Aj315cnhJnRhM4bxGYBq+d9sJPi7E9uujmDTxRYvi5M2We2
         lIbhnGBVBDwMTmPm4TFmJjWPUY3nRltAQWpXrXCg1v4oGqm+nVHzlU5jdmJHrxz7I1Hl
         tYp5BSHxCOH42fzVB/A8OR4XlMt8IE7wguFeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=29krL0qvuFg0KCphJZfO0u7z2tvgm5X6ahpdbCTG5JM=;
        b=nnfQO7CmRqaA4V/yX6mVAFroHLsbj4cntMLmQi7rp4IzVjNrT1ikBoIoYxnI1oAmjR
         bdTokIcAnhhY3t8UpX7UiT0CPKMLWdQJs8cl/8xib6oL3rMGTv5eRhmC6mhoj3se9vWX
         GoEMwsbD/LorEk50Qaj8f2iLYPrPcuRCdDTcYgqxT8gQ+x0KCvqMmCRTpoG+pIXsvtEk
         5f2Hq8giWEIFBoYRSXTcvdlW0Jo5ygltninXG0dXA6O26uttf3PPGavnWJTBkSH0Vjmp
         rrDbxBATy8CQG3FesdibLnf7bwwF33MhZ2L3qGMZQhPUrqzUkUpcZElBBWx4oJzEA4K8
         M+eg==
X-Gm-Message-State: ACrzQf21db0KwXjbvxQyBUQD/Esbt4sNR4mSnEg+2r2fH16bfdQEGsW+
        0pwy4wsX2BtbQReSiPHI9J2WmA==
X-Google-Smtp-Source: AMsMyM6v2iHcKBv3dbH5kl/i70Ai8m8LshgThkTu5jlpNWXMW8oMZccFmHnMq8TJAFDqKc01zRPIrg==
X-Received: by 2002:a05:6a00:1743:b0:548:8629:ceab with SMTP id j3-20020a056a00174300b005488629ceabmr1764304pfc.23.1663824628324;
        Wed, 21 Sep 2022 22:30:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l187-20020a633ec4000000b0043057fe66c0sm2834975pga.48.2022.09.21.22.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 22:30:27 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:30:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [RFC] docs: Define c_paren_attributes for attributes with
 arguments
Message-ID: <202209212229.1C07A60456@keescook>
References: <20220902223507.2537469-1-keescook@chromium.org>
 <d1af650a-1e0b-a650-4cda-57fb1d54f1af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1af650a-1e0b-a650-4cda-57fb1d54f1af@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:08:30PM +0900, Akira Yokosawa wrote:
> Hi Kees,
> 
> I expected some responses from Jon, but looks like he's been busy
> elsewhere. Let me chime in.
> 
> On Fri,  2 Sep 2022 15:35:07 -0700, Kees Cook wrote:
> > While Sphinx's "c_id_attributes" is needed for basic attributes, any
> > attributes with arguments need to be defined in "c_paren_attributes"
> > to avoid errors like:
> > 
> > include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
> > include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'
> 
> These warnings are from ./scripts/kernel-doc.
> So I think you need to teach the script about "__diagnose_as" so that
> the kernel-doc comment of strncpy() can be converted to reST doc
> which Sphinx can understand.

Ah! Thank you, yeah, I couldn't figure out where it was coming from.

> Past changes in ./scripts/kernel-doc might give you some hints.

Yeah, including changes from me for similar things. How quickly I
forgot! :)

Thanks,

-Kees

-- 
Kees Cook
