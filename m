Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFA5EE8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiI1VyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiI1Vxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:53:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A09B600A;
        Wed, 28 Sep 2022 14:53:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so13445390pgc.0;
        Wed, 28 Sep 2022 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rwxTbqg7Xc3irSvqNgtb9zG62AE7Qip58l/cJQg1XlI=;
        b=Xt698KYjpjJ84vIuRanpK/wLtkDt7DY3z7LwWCRDcyLW1odzM0rEZobjATnUl+ZIvp
         pH9Bq5y/PGOaysVA91ZzYOC5D2qMsKSWCSceSaB42SZ6gD24F++VhKOmSSmIUpu8CBys
         ZSRbH0gm/QCGwybjgwl6BGdCXbWrx5mIxh0ArN7HDXDdUR5/Wp8mhekydGso4ADjfzah
         wOaJpvje/jLQhXwfhv0llWrPb25kgfkDKKby5eBBqgUYSOg2rl9qrUoxXCF8m0c3My1X
         8mMpLfRe9dos3PNWwG34AyAinKHwvZpLF1rdQAQWMah0BVwqrq80yZQhsl4UgkZdK/fd
         4hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rwxTbqg7Xc3irSvqNgtb9zG62AE7Qip58l/cJQg1XlI=;
        b=DsLAcLbcMZ4vd+cVlLWgsJ9vU1lpLGI/cMSsEa0SXntGYpAdUPvtVcwZBQ4dbrn3eW
         EG79nNApmbfKCW+33fjqi7XQsK9Ao6Ff9+mC1txmGHtt1AG8wcLnvBnlUkpZPn/MIo13
         XHfxD9KGF0NqC4PLl2n6HUt0nVQ4NAjDYJ1NDoMp1LkEsXfZvoctK5EVEz/cUukC4aIS
         5u94PXgA24MH2BDeGQwrq1GLJqrtVhfrTyboChpgocDJNEz8HfX7607I78eTEXmKFWr3
         jZZ/ZAFjoe39b1UTiHEwKGzal3ksCXnU80mNzDBOCLpVS75t7ojrhiszp2AI9S+Xpxd9
         ch1A==
X-Gm-Message-State: ACrzQf2RokPbVguF/HkS6LRNHpsEIUi0n1JW4GQHs+y90GawYtAKN2n0
        UqzMPqdrgB+sD4UmTZ8fDh7XeYcjZm8=
X-Google-Smtp-Source: AMsMyM62WoDTbaELfdTYT6DlHU48/X79U3e3xQ+Ym4ogNXlrzZzDA8STmg9JIV8islx0iP+cGEBcwA==
X-Received: by 2002:a05:6a00:1911:b0:554:9a8d:bb41 with SMTP id y17-20020a056a00191100b005549a8dbb41mr36426424pfi.47.1664402027447;
        Wed, 28 Sep 2022 14:53:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id f145-20020a623897000000b005366696b735sm4505950pfa.77.2022.09.28.14.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:53:47 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:53:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu: Fix spelling mistake "BOOLTLOADER" ->
 "BOOTLOADER"
Message-ID: <YzTCaCuMadUC0+oh@google.com>
References: <20220928211003.61872-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928211003.61872-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:10:03PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
