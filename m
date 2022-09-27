Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243085ECCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiI0T2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiI0T2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:28:04 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBACF6F7A;
        Tue, 27 Sep 2022 12:28:03 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id s18so6693591qtx.6;
        Tue, 27 Sep 2022 12:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NIONAaDa/CADxbi7Sj9zHshfF9vGG01MwuU+DCD7TQY=;
        b=Rkmg159kE40tLfYifaqXBFQPnxFfS06LLu5OsNjCHxo36N3E8GctQvI58RcSnPBA8f
         MGgnwZ8o0V53mSANQDYuJCL0K99+4FF8floFS/QaWm3fBdMF2MdR+4y6f5HoQMmSXZKw
         dhOUExu4NI3PQ7tuCD5R4kSvN6zpIFrcCiopwNGL41NnFATa+24ac7rDRB5apagnTzQ9
         UnKPdZCbgtsuF98PlTq/VfWwMIXUXDB2RLYEWa78RbvHMJCN90BRxu3c1SzHmB7brJkI
         hhE+mLBJXo0NWlF0dmorUmDDcb9KYoGGHZaBqcaWfDID+YYaDYSV0mfN+qi8L1gfqFbJ
         x8xQ==
X-Gm-Message-State: ACrzQf14qqErQhXxI9eNje8sWg3XJNEjZ8qXEn62XQWZtqUzWzDUXHvk
        FKRSEq7YvSYSSfr4P+dXvcF2u4h+NiAHwRrS
X-Google-Smtp-Source: AMsMyM6BkwutEucPQbPLyi+ty7KrMRWnC+/VhpD1A+2SENS97pX0SLoDDbNw2Cgo9vs2kn76tlmwfA==
X-Received: by 2002:a05:622a:174d:b0:35c:bf34:fc7 with SMTP id l13-20020a05622a174d00b0035cbf340fc7mr24134556qtk.13.1664306882006;
        Tue, 27 Sep 2022 12:28:02 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::13c6])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b006cbb8ca04f8sm1585838qkn.40.2022.09.27.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:28:01 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:28:05 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 7/7] docs: add a man-pages link to the front page
Message-ID: <YzNOxW4H5nNaTNp8@maniforge.dhcp.thefacebook.com>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-8-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927160559.97154-8-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:05:59AM -0600, Jonathan Corbet wrote:
> Readers looking for user-oriented information may benefit from it.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: David Vernet <void@manifault.com>
