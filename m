Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0F68AFF6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBENbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBENbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:31:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE6C1C7FE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:31:02 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q19so9267639edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 05:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLOZbnoCDNRNOtYQJDtOvwaLMzxcbt+wzlYkwFe3eSg=;
        b=q4yhNTBM2D/nrFmVHF2B5oWAV/zZiLDlBbI+DmhZ2jQZTScnZNpnzF0u9Al8xFeH+L
         WXrxf2v25M5EIfPyGDV8CLzrRqs8vGbaSnNuEachvI4wIKh//dTjzBAsFGkFQbgASNeM
         zN12OQy065vNJfbDDv3C+N6eON9l/Jo098I6e62WutcOIv4VGCGIEZdoxehFQcGDRV2R
         wmkaYxfFIha+4xj1HREzRJqQ4ysujvFBNCvL4MumIspMuaK+dIHuSfs5LHgdlWdK8Ayc
         sQgx9hseHHA/PIRX7rZdIfsMvHahLehmJsXbFChE+Nr/4am6QSHEZNJqcUcsqqARiSqR
         +fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLOZbnoCDNRNOtYQJDtOvwaLMzxcbt+wzlYkwFe3eSg=;
        b=1t5ch4nTg04E86wvcaSiRZGXFYhfcXVXr1fUsyKzJr24MT28Z+tmD6KdumNPmBU8vr
         akBUdZf5Rkrah+w/DMaPBKNExNP6c6xIom1lwxQAB2lZ/GkPW1oBos3+Sc4/dsM7M1ce
         A4e2NOTzuLb7pURbmteaFPMRQMLrmoWJr680xwqkfMNNRnVoxEryACDTIaEGMKzKxI40
         OYfuxww1xB3f9nr1Gw+6rB87kRpJFHwziiC828Kh8BGV60/2W3rDanJoIEOJyNtDo576
         lyi2PRt5X7PEbDNKlvIf+I/KQQWewu25ynY3d9FbWp8nKlQ+7PW1EdZJERgGjSZTfv6a
         R1bQ==
X-Gm-Message-State: AO0yUKVwojoRypSY6dqg033zcdrjBZwCDUhGx2OhQCJc25uIam8kQekj
        aKYS3Md0rqR7SEIauxlpIVV1JRoGNWw=
X-Google-Smtp-Source: AK7set+uE+I8Jb1ciCZYk7NWwCvJRLpwU24mwlZSACXV2JOxIHioDO9SXhbb7ma7xVSDoEAqBICHLQ==
X-Received: by 2002:a05:6402:1f06:b0:4a2:358e:e734 with SMTP id b6-20020a0564021f0600b004a2358ee734mr16174976edb.7.1675603861484;
        Sun, 05 Feb 2023 05:31:01 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cb92000000b004954c90c94bsm3820584edt.6.2023.02.05.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 05:31:01 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:30:59 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y9+vkwYfQzYTbIIo@combine-ThinkPad-S1-Yoga>
References: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
 <Y9+sFw0rviTAJNMf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9+sFw0rviTAJNMf@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 02:16:07PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 05, 2023 at 02:08:02PM +0100, Guru Mehar Rachaputi wrote:
> > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > as '(iobase)' to avoid precedence issues"
> > 
> > ---
> > Changes in v3:
> > 	- Whitespace error from checkpatch fixed
> > 
> > Changes in v2:
> > 	- Macros with one statement that is to call 'iowrite8' function changed
> > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > 	In relation to this, names of the callers of macro are also modified
> > 	to call this function.
> > 
> > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> 
> Try to take this patch and apply it to a tree, and see that everything
> below the --- line is thrown away, including your signed-off-by: line :(
> 
Sorry, should not a patch contain signed-off-by: line?
I did not understand.

-- 
Thanks & Regards,
Guru
