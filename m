Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B403661FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjAII0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjAII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:26:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD956572;
        Mon,  9 Jan 2023 00:26:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so8384746wms.0;
        Mon, 09 Jan 2023 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtUHkTRRfiNW5TLc5bwX/ucBfvpI6oGzoNoxA/kdcb4=;
        b=PX/Re6EXO5D5x2aOrBoI7eA99YcH6y0uQW4Vy4O2TGXKH6hdNRvrsHnBZ+Ubcv6tiQ
         TXL+WU+PKwozsVIYHmrowUrubNx4OdxGGBXm6FVfKXw/LCApwYZoSbyIsca39fx+QV1E
         3ZxqQvtEQCEoLV/2KlNULgPiCnKnr+TvOMtU57t0W/50RjnVAUjWgJD4D+dA59AVoKWh
         GEf+f2o1uqAtruBo7es8ttxLoVYaE+bRhLQe3VRGhpiyVNwe01Snp693OaYjzSAdrzV4
         j9VOFaaboM1rMGg1fsBk8OrP0MfGOgOoXRKaV7Ugk8swmNYtUZuiZKCDU98Ui/EnhUWr
         TFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtUHkTRRfiNW5TLc5bwX/ucBfvpI6oGzoNoxA/kdcb4=;
        b=uWwnMpr6j64t3c8NhZVQLOY8g9xznOyDRYM6iAbUewDHXVa6I3QB87DRrYMM/br4fg
         ycLPoYagA4NNfcDvvO046xsyRXH+rSSW2Wk7hNo2akx6sm1aJw5uSKhU5wWMXYPsyPYu
         nUu4gsXY5aKOcrr1KGgCWNFvEtwpzIe9V5vhy1md17h6YeKIPHwm1T+KHwY5nETZKG5s
         fyYkzPJR9HlRYobtE6qE3RaoxHK5zyLGB9Gb81Rbie88EWA2JgP9r27p3QQ8ryV0cz54
         0W1yQye+Ssq4/sOx4E4qqSUUbnITyd/++pI8VCcGyfA6f52cT1OWSn5RBKOJyByprd4t
         xCnA==
X-Gm-Message-State: AFqh2krOBksguDCSlIu+paWWk4M166gqMdDW4MAj9BCmO5tHZ1hCPHkD
        7ezD38HWbR4wY1SIgfeDQxs=
X-Google-Smtp-Source: AMrXdXuAKMUeskJfUuvD8C9z9OcPka00Get8EuUaW0pYUVKXK+LmkvJIxuFXAbNoY9jOuXApvBte+A==
X-Received: by 2002:a05:600c:3b82:b0:3cf:900c:de6b with SMTP id n2-20020a05600c3b8200b003cf900cde6bmr45739129wms.15.1673252776288;
        Mon, 09 Jan 2023 00:26:16 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c4b0600b003d9e91cd08dsm5605620wmp.4.2023.01.09.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:26:15 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:26:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bit_spinlock: Include <asm/processor.h>
Message-ID: <Y7vPnXaUBXPwO0Bj@kadam>
References: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:04:44PM +0100, Christophe JAILLET wrote:
> In an attempt to simplify some includes in <include/dcache.h>, it
> appeared, when compiling fs/ecryptfs/dentry.c, that <linux/bit_spinlock.h>
> was relying on other includes to get the definition of cpu_relax().
> (see [1])
> 
> It broke on arc.
> 
> Include <asm/processor.h> in <linux/bit_spinlock.h> to fix the issue.
> This will help remove some un-needed includes from <include/dcache.h>.
> 
> [1]: https://lore.kernel.org/all/202301082130.LXMj5qkD-lkp@intel.com/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure who to send this to.
> get_maintainer.pl is of no help, and the file is untouched from a too long
> time.
> 
> Greg? Dan? Any pointer?

Andrew Morton is the maintainer of last resort.  Plus spinlocks seem
like something he would be interested in.  Otherwise Ingo, Peter Z and
the x86 team.

regards,
dan carpenter

