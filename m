Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E46144C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKAGpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKAGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:45:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7173A6365
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:45:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f5so13292834ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4hGuyUSfPpzlH7qFL6pPYRA4BNb86wSGZk3W8v2YaQ=;
        b=A21vU3b5Ud1p1PYQ0mYVe1OttP4Gd+A8wDdNXuNrYCFgKbZdgic3iqv/rJSxkEhpqT
         HdD2CG+OxyBNoq462ahvX9kpaXOZCzs1zyULWPhTlRY8pitXA5PJCMdaGmOkSA0vRM/o
         2qD4ERuM2cJ5I+IqqKYJbknkEmPaF8LcwvINncRyQJgHHouaUpQCkAbimTSquZKOUxxc
         juNHE6Gp0bAgKEPDwChnmzg/FnW0qkh53wh5WpWnAChfA+zyobCLgb4I87jIYLxLAqkU
         nNFNhIha/tkVIlWKa2fQ6iVzMsY5uceQWvomGVjGevI5mBY83pRkrg6VZA8AyGuTH4Mq
         lU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4hGuyUSfPpzlH7qFL6pPYRA4BNb86wSGZk3W8v2YaQ=;
        b=uwK6DuEo1M21sK+0UECvBA4CvDVisQlyLB+G18gw5Zc+G4N8XFAvXS+xOVrfUGnr8G
         HkTGHoLv2Ok08Pvb2rYvd+nR6OnLtcl8S40P/Aa1EhTkHa34fba00WcU3yqGLotvcmyc
         MsYIG8vY+Ryfm3AJ0jY1o4xmxO6jw+s7S0z2EwADU23p8yr+9qIfptsK4FtkHQpelwv9
         CdI4+3Q+oDO0a6FH/okxb1Nnhl4VLNzaT5zMv61L+iOrr9LkwZExYLq2M+HjyFXFw8TY
         OhrV5ad43NZwLJLTkvJk03dtBVNPDpavxA3K+d5mPaRWXo83JAju1Ewiy6zmzobqBRwu
         YUxw==
X-Gm-Message-State: ACrzQf1VYKKXHM9pokAgWM0BcEh7WSpp1DqFDUcfPuCJGA0OdIjNo+XE
        Z6AAfb7lKeTcVC0ce8uZCQ==
X-Google-Smtp-Source: AMsMyM7ocNXL8O9KICsd0jaaAg1WxK5d9iHSSfW2FRYFyFGv+QlmMDPQxQpreFagbbgfErrpp4I5mA==
X-Received: by 2002:a17:907:7243:b0:7ad:88f8:7ef1 with SMTP id ds3-20020a170907724300b007ad88f87ef1mr16660053ejc.12.1667285141953;
        Mon, 31 Oct 2022 23:45:41 -0700 (PDT)
Received: from p183 ([46.53.254.38])
        by smtp.gmail.com with ESMTPSA id b7-20020a0564021f0700b00458a03203b1sm4131615edb.31.2022.10.31.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 23:45:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 09:45:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y2DAk9zKYG9hT/Ov@p183>
References: <Y1wunXB2iv0QHr22@p183>
 <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com>
 <Y11h+mbtSEEwHKRZ@p183>
 <429982ba-e06f-e76b-061c-39db67558aa5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <429982ba-e06f-e76b-061c-39db67558aa5@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:37:43PM -0700, Dave Hansen wrote:
> On 10/29/22 10:25, Alexey Dobriyan wrote:
> > 
> > 	$ ./ffff8_64 -h
> > 	usage: ./ffff8_64 [-f] [-r] [-n N] [-s S]
> > 	        -f: sequential scan
> > 	        -r: random scan (default)
> > 	        -n: use N threads (default: $(nproc))
> > 	        -s: lowest address shift (default: 47)
> > 	        -t: time to run (default: 256 seconds)
> 
> Does this mean that if someone is just running all kernel selftests,
> they need to wait for 256 seconds for this to finish?

Yes. But low time will cover negligible amount of address space.

Is there some kind of policy to not do this? LTP surely has similar
tests for races.
