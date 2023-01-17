Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059E666D4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjAQDIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjAQDH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:07:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6077233D6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:07:55 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9so32146534pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnJ9Zmocxu4Xq5ufmgMvMkKxKjqhgHcC/CXVZl3M6Kg=;
        b=VT/EEiv5boIzMV75DdA9/aJwFxF8Is84Rhw3/LYBmRMMYQpCUAgfOvntIelHvMClTW
         yMMYT/gArron1p5NI3ZWwNx7VwexbGk5nFEciNhajeDchErJns5L+5ncMt8OcUPsVqtQ
         jQb27l54t7AeQHJvNQXLmE7rhaplUy52bbmBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnJ9Zmocxu4Xq5ufmgMvMkKxKjqhgHcC/CXVZl3M6Kg=;
        b=05R8d3jyPE0Jyqyh9lmeAzwp0JwJcTOAglwZEHrEECNsPao+PinCEa8MaYrtObxHiw
         AXkfM2Vx2kAYxFcFGKRmM8Q1eXYY+KRKhFedyJhXfrBiGq3WGhP3WkmqAMfFzaKYYCrU
         twQOY4BLqnZWI7KyzX+eX1K8Y6P6h2AyVOFLiKFoz5/scgzaqpCYOB7RRoQZ64109Y2P
         1+Lu4Ivqf7IGTDp7ft9+redkxbrLI6LRqxE2lONZuRCKbIY+EcAIArPP/T5VovROkYN1
         z/XwyP6HgFEJzMbl95ruHaLkFXYnookqCfL+Fpt/+03RvHEU+taXs1o2mtBuvJAjk4zr
         wQXw==
X-Gm-Message-State: AFqh2kpt5OtEbYFD9u5H307x32ukl1CUsTu8O1aicAnQDpj83oINRZAo
        sn3rT+qooeWAXF8jxXv98qml/w==
X-Google-Smtp-Source: AMrXdXtQj78NfF9qx+TabtfHmEG+hyBEpYjSaH0gM6kYOQE/gPWnG4sWnLISWWRe0lGgYM28aT9AHQ==
X-Received: by 2002:a17:903:54d:b0:193:a5b:ccf6 with SMTP id jo13-20020a170903054d00b001930a5bccf6mr808312plb.0.1673924875310;
        Mon, 16 Jan 2023 19:07:55 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00189e1522982sm19987634plr.168.2023.01.16.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 19:07:54 -0800 (PST)
Date:   Tue, 17 Jan 2023 12:07:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        coverity-bot <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <Y8YRBo7ZmtzWT4J1@google.com>
References: <202301131544.D9E804CCD@keescook>
 <Y8KAhaiZQOWTcfyF@google.com>
 <Y8V8tqMJeB7t+rcJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8V8tqMJeB7t+rcJ@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/16 17:35), Petr Mladek wrote:
> 
> I am going to send a patch.

Sure, sounds good.

> The code might be safe with the current size of the buffer and
> the string. But it is true that the following is wrong:
> 
> 	len = snprintf(scratchbuf, scratchbuf_sz,
> 		       "** %lu printk messages dropped **\n", dropped);

Wouldn't

	if (WARN_ON_ONCE(len + PRINTK_PREFIX_MAX >= outbuf_sz))
		return;

prevent us from doing something harmful?
