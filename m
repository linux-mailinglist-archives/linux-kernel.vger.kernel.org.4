Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438B6176D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKCGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:40:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B0EA5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:40:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g12so1177763wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESHWUn7hNVM3hhfp0corAi9A6QZkBTRcaV/Qj5TdN2M=;
        b=m8etF77RJYcU7J1sOVO1hLLRMjfj5Tf7qPlNpIPyaWyIHVdPjQspnr0Z9tyRdcsdoX
         V4ZQJxuzny0UrPq0nxtj+ZXBkiaJjzbvXjieN43wSvdsP4oAGp9FSr7HXK5shYlXUUFo
         poF5wJbHyCCQQf5LvWd3uaGeoyLCOlt05/4VwRq3n/ggLtCfygcow+k0xTvqFipf1Meq
         ejRtVxrskaCTQ5VHYzOoAiDxxh8thuQ50etRTkalqsQs89Osn9w40d9O269UVWfjz4yA
         4x4566vCnM6ZZVrFQd+MxZaG+PHHFciBmILdQLuHcgjTZmU8jRTpKDbuhXrQA2V4k6Xp
         4KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESHWUn7hNVM3hhfp0corAi9A6QZkBTRcaV/Qj5TdN2M=;
        b=ABpOeITjPXHapcN0OyOqJ9PvL+KeDfe2aeTpxD7G78bijCJ8cqMTMMy6XUx5UZ63Ie
         qALiu3Va6GJ81mlYR2zbvXRe7TRFfzvjwIm9CIsVWmhOL6sZ/1ke1qmvKfu6jvfUAztC
         Xp6a4LETA4Hli9Nar2/s4HxV0yK0uoVbOraDgd/J/iexArMJpvO3x7WyE1ecGJYLdssf
         sbFVX4wDaKvjrzT6q40jK5PZ2IlL4Q5TEVTVAdA20gUsFOu0k/oPrBPeY58ReRiPLWR6
         cHx3TjubIOjXAtZS+QzcKZiCo7LIu4XOt8x5+n31CFFF9ORF/bl90P6ORQZnPeVanOYT
         vzmQ==
X-Gm-Message-State: ACrzQf26GdDuk2sxlC/3o/4650H7FHGkn9SuYCfEIiVrg/oThUitQFad
        qhIk342308TC8cqqyNylQKOJcODwjsLy+A==
X-Google-Smtp-Source: AMsMyM7BwKP/AL76bBxpVj+2Z8rQIC99KpoZS93KzfFkSfEZudsbo2+YXLYhQaWEbMIGw+fSyb0Eow==
X-Received: by 2002:adf:f081:0:b0:236:5e7c:4ec2 with SMTP id n1-20020adff081000000b002365e7c4ec2mr17024440wro.641.1667457623087;
        Wed, 02 Nov 2022 23:40:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003c3a1d8c8e6sm249628wmq.19.2022.11.02.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 23:40:22 -0700 (PDT)
Date:   Thu, 3 Nov 2022 09:40:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [RESEND PATCH v2] staging: vt6655: change 2 variable names
 wFB_Opt0 and wFB_Opt1
Message-ID: <Y2NiUwrvFt1V6xdK@kadam>
References: <Y2Ncr9fQ5P6OChuV@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Ncr9fQ5P6OChuV@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 06:16:15AM +0000, Tanjuate Brunostar wrote:
> These variables are named using Hungarian notation, which is not used
> in the Linux kernel.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> 
> v2: corrected errors on the subject line of this patch
> 

Don't put RESEND in the title.  RESEND means that the first patch was
perfect but the maintainer accidentally ignored it.  v2 means the
maintainer wanted something changed.  RESEND v2 means that v2 was
perfect and the MAINTAINER ignored it.

regards,
dan carpenter

