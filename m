Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330F735EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjFSUoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:44:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469A128
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:43:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b50a419ab6so7391175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687207438; x=1689799438;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC2tnKZazU9uVlrm2A6bHgfVySKOOyCWLXqbM4UiIQg=;
        b=kvelQzVi3hjDhJ1f6AVzfGp4bEg7VBq0/Kn4byBa3sy4DWm4qYGLhlwvefXJHzaSAH
         yT5c5FOdH3jVm57CXHlBChTiBmL3YHLNLW4ZEF04V/daCQnP1a/Xev0jF+bSPjAQT7Gu
         YLmmjJmXlAcBojdHAOIFxWUzrn0Gt5VQn4IS0O4KHbHCntWNOKHdsk39JZfkyZ64axvg
         uXc0ZnSEhoN9BQjkCmfDiu2cUPXmE+JefJTynZpqiJqxI5lCQBteEL9hLXR+eYRj3oAB
         txCrK2O6dwC23NlqPRISzEaglytnQ+4KIO8GWEwk7AtFsagi5u92HtrerIid610iZJuc
         b55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687207438; x=1689799438;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oC2tnKZazU9uVlrm2A6bHgfVySKOOyCWLXqbM4UiIQg=;
        b=VIaArHjetmE+RzzhdHln5+/Sfsl8TFmjBT6udTE3qfcHf1LpT38y7mbQIzBAh4DhhG
         QbCRqXtq7NLMFyuAy2T4zgtZi2se9CnilhYvnS2CnZtGmvIGo1hvH7UQ9Wzrc0zYNRsh
         7xkzCycZ30CJ7cMdne6p86Aa/bVuX4DBTMXPgwnjGyCCPxtVkW+k209+6nH1bt5EcJGF
         RLM5pyxsYoyINXM1rXMuX2JHCDy0M2Bu8QCLMC28SU1VlCS9z19SQ6/5BxdWW5By/51P
         76s9GtFQMk+ZVZhMVvwrhPAmUWwkixLSiJRRc0f6V85nb07p5KyqJCpEuvU+s4xJ5fOK
         zLDg==
X-Gm-Message-State: AC+VfDy+wcFmBEwD6mUsTEgCe5zBd+GfCZn4vTmLQ+CoIcia4zQYwrm9
        90kEF6A7POEu8wNVANksBBAaMScZljy9RMINPRA=
X-Google-Smtp-Source: ACHHUZ5dDre5JtwuZeS25jOuzOzvltt1rhev/GGrypbNGHP5rit3XtWQeaKUe6C2Iv3OsmxEJsi0GA==
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id n5-20020a170903110500b001b3ebda654emr12740048plh.5.1687207438599;
        Mon, 19 Jun 2023 13:43:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jl17-20020a170903135100b001a65fa33e62sm235362plb.154.2023.06.19.13.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 13:43:57 -0700 (PDT)
Message-ID: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
Date:   Mon, 19 Jun 2023 14:43:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: f2fs async buffered write patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I came across this patch in a news posting:

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d

which has me a bit worried. As far as I can tell, all that patch does is
set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
the rest?

What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:

generic_perform_write(iocb, from)
	...
	->write_begin() <- does this block?
	...
	->write_end() <- or this one?
	...
	balance_dirty_pages_ratelimited() <- this one surely does...

If you look just one level down the latter to
balance_dirty_pages_ratelimited_flags(), you'll even see the 'flags'
argument documented there.

This looks pretty haphazard and cannot possibly work as-is, so please
get this reverted until f2fs is converted to iomap, or IOCB_NOWAIT is
handled by generic_perform_write() and below.

-- 
Jens Axboe

