Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1335E8BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIXLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIXLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:08:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B9D4DC4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:08:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm5so2259586plb.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=plCyAKsA7rnmgRZBPxmuJ30Ufn5ELUWBGQDOTES3vdI=;
        b=fI8ScoO2gv97gpBNWXskcn8xqk7Au7X6G22c8jBFN9S+3bFr6O5pnhto+Jj0zzQ9eD
         xNZUfrr/mLgOop+QsdREusVlJ9BeDP3A6pWt+vmElwjMeYIqkQPzKOonB7RQnTD4v3CD
         BEB1OEu2djuaqQELoF2CS+PtG225xzxotVKTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=plCyAKsA7rnmgRZBPxmuJ30Ufn5ELUWBGQDOTES3vdI=;
        b=JmPDo6Pn5hYRkM6iPdwILLDB9DJG4Ku86J/1AciAB8gSU6aWsTsEtRLQJInCQpwCG4
         GTJA7l7WQMxsJDzzN9cNJ1cs9uZ687Pi59+KyFU/0lz9oPCH6xqS24qdV+Nwe+J2FnZV
         spekqtBUEyJAOwlyYbXPQfLGeGWvRAjNeywn7nD55+t2Pgp7GacdK/vq0LCmewVeLu61
         gaWgfVSvMvKJFL5gew3HSf8KZabn2yPl3LEOkzOUuCJ9HRacOD+rqisaWVwJSRhn5NYf
         x6YbiKyA2h7lhWdT6k6V5rS51UhUFRpqbYfDI0t514EvP3qgbeq40OLrrK7ofzNjl0In
         wxEQ==
X-Gm-Message-State: ACrzQf3/iGBtr3SIEKIrrdQxP43Ox0HAeL3DGVwakP5n2Lzvt6j+OR2V
        LC7QQBIUuIcgCGj9lPgvoQt+gA==
X-Google-Smtp-Source: AMsMyM5vdq+72fMM/hqyGdGBpWiZQ6cOpZkbVwS3823HT3An3U0TSVOYA3sbVY22ngKH2rt5HNR5NA==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id w7-20020a17090a460700b00202e22d489cmr26483756pjg.80.1664017688391;
        Sat, 24 Sep 2022 04:08:08 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902b68600b00173cfaed233sm7509695pls.62.2022.09.24.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:08:07 -0700 (PDT)
Date:   Sat, 24 Sep 2022 20:08:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 14/18] printk: Document struct console
Message-ID: <Yy7lE690p25PUvfX@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-15-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> Add docbook comments to struct console.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
