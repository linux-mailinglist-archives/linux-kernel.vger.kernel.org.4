Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3668050E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjA3Ee0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3EeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:34:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67510A;
        Sun, 29 Jan 2023 20:34:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z3so6859054pfb.2;
        Sun, 29 Jan 2023 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjvApUUZfQnnuI/RkgAT/sYUXmootMZoZRsxxLhMUo8=;
        b=gJdkH4IhC1zF11moSrTif9My4UTpfIxR4xY0wpLNAHml6E6CsoXik5adNHjoNX24la
         VSx6zBzLNBX9CHm0OIZTm+IICr6ekV3PmeEXZPNWGKYfWEbMYnTmz032/jKe8CB7Sj2m
         dGwZfjJSsI97imsPxZSq1vzOYnsm3tplDYfDVBwdU19my2nt2At1Zxq2FTr3oTpHaADg
         mVZY/2TBtDhbMwBRsofq9HfKEJno2M4Hdfx09M9AXyti/2RqLlkqCxgvfOakDXD3NFS/
         hUGKtPwzqujgAWVhDkCROT04DKowHrTeeN0oIUsNuS4aRpeo5EGGRiY+It07k6x8UPxt
         4NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjvApUUZfQnnuI/RkgAT/sYUXmootMZoZRsxxLhMUo8=;
        b=Hx1QoV3B5ozL3wclAXQ3MBsT3sa3lcVZM5wGnduX8j6uW00R4xk472lsNXHtMANUnq
         Mk/NpWIg/L8//FYmbNJmOW5BSUcrbW7M8liVn0TAw1HjWzwirFR6TeVAV7qUDmWjsdzw
         XBq+R4ehhOVMYFjVAi0mIs6GktHYc04TUEMgA4WO0g7WqwVQOH9QW0pZar3e/V1PSgXI
         uipKoX+i5N6X8D0EuGdysQ+wNdhvnP8u35JeUKpFrf6b+eg9hWzipu/G75qCH7gdhsyx
         bXliWrf4duXpGZ4jX0/+TTBs65Clyb+IwBHWKTLnUoSUGz3D49LbfJsZAXtAFY4tOuIl
         PVAQ==
X-Gm-Message-State: AO0yUKXovWXXL950tFo73hSnrYy0grsLrnrWNnlp1JyQgrnRMBzL/Ncw
        6U0yIqCWUVjDMTrlQ9WU+jw=
X-Google-Smtp-Source: AK7set8TLE1JOuuknWEc+oXZqJWJfgDMVxjQyNpNN0aVK0Mu1BQNlxa8T8uR6c3YA8XUdVlvd9uYNg==
X-Received: by 2002:a05:6a00:be4:b0:593:da8:6f2c with SMTP id x36-20020a056a000be400b005930da86f2cmr7849764pfu.5.1675053261504;
        Sun, 29 Jan 2023 20:34:21 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id m2-20020a056a00164200b00587304cbd3fsm6299961pfc.181.2023.01.29.20.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:34:20 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:34:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] input: keyboard: fix a Kconfig spelling mistake &
 hyphenation
Message-ID: <Y9dIydcawFmk2A07@google.com>
References: <20230124233453.22893-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124233453.22893-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:34:53PM -0800, Randy Dunlap wrote:
> Correct a spelling mistake (reported by codespell).
> Also hyphenate "matrix-based".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Applied, thank you.

-- 
Dmitry
