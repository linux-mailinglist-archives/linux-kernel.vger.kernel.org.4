Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86970CFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjEWArP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjEWAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:46:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D62423C;
        Mon, 22 May 2023 17:30:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-253340db64fso6198705a91.2;
        Mon, 22 May 2023 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684801801; x=1687393801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEifJEBSj843qwkcWh042z8MQfZIbIFpzgNR/nZXc5s=;
        b=PjMYjRIziDSPvIlo9uMabR3TcCLJABTa7b5x2+c2JcD3JRZ60jrEAQafRzLNHwwV+I
         enUO/HEFYmmQgZcCuq6wb/35dF/6jUolpkPPW34vPT3AOfBIGogDIIo9cqrjHY90XTY+
         PXZGtxAta++G1i94Z4nT9DOtmrPiCRZ8iQrqgyYfpyHqWs9v804Y7btk9ga1u/gxoRfI
         DJCUc0PyN4ZTEBXIYLQ5kRorIvYr0Pa2R2HgCFz4UDUwWgm5Q90LGBID+8D0W2Aiss9D
         1iQE6V2mqAGOj7mwKTMjKWZpUyzMDjTa/NKWCWypDA0WsqpeffcdGvaXLuG+CfuC8wzY
         nqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801801; x=1687393801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEifJEBSj843qwkcWh042z8MQfZIbIFpzgNR/nZXc5s=;
        b=Vba19XvgG6OcRW8gyi4eLLnVTUgnJaFz1Zmj5FcSDsuIh1KhYVvXnqGSzS9b8JY8c5
         GkJ/IHo+wJO9ehPHvld/kOnZI+yVkV+KMHW7PLM5ndInGjTCZVy6pSfTN3XntVZl1b3B
         Ng4velwVTX5hdPaHsXYajn3SHuz49GjtAdTT5HOPiKLXnqWQOC46OxmFHB180+uy/zpQ
         HfIGoRRBynllV12qNJ9Ivmz/7J5x+LSoq2lnjFXDligJHs5OeloWemxsUDHChjzn8kXP
         ahbPSvEXvufMH/YFr1sULCjcZwNrDu2cX0JWJ+J+nHVFWDvcUfK1/e91npqVoyAqTMdq
         HPmA==
X-Gm-Message-State: AC+VfDwxaQL2015z7FFFpo4W8SCrXIFNxyq/9UCdhxFskBRY/jevhqQt
        7oYo03XwyeBrVwTCR9tOFho=
X-Google-Smtp-Source: ACHHUZ7wWyVCJpxZmHsghH/6/RZ4D9JiWJJ7UL2PxapwGvf1T3n3EcRWA2L20zNwu0GC2oCe+8joqg==
X-Received: by 2002:a17:90b:2292:b0:253:83d8:e487 with SMTP id kx18-20020a17090b229200b0025383d8e487mr10976879pjb.0.1684801800788;
        Mon, 22 May 2023 17:30:00 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:54fa:e8a7:76de:888d])
        by smtp.gmail.com with ESMTPSA id gj13-20020a17090b108d00b00250ad795d72sm4590532pjb.44.2023.05.22.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:30:00 -0700 (PDT)
Date:   Mon, 22 May 2023 17:29:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cameron Gutman <aicommander@gmail.com>,
        Marcos Alano <marcoshalano@gmail.com>
Subject: Re: [PATCH v2] xpad: Spelling fixes for "Xbox", improve and
 proofread the listed xpad device names
Message-ID: <ZGwJBTFd4JRKzocu@google.com>
References: <401b1d94-1348-15fd-b48f-a80e8885c7a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401b1d94-1348-15fd-b48f-a80e8885c7a4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 12:30:20AM +0100, Ismael Ferreras Morezuelas wrote:
> The Linux kernel is notorious for misspelling X-Box, X-box, XBox or XBOX;
> the official spelling is actually just Xbox. Plain and simple.
> 
> Tried to respect the existing notes but still following the style guide.
> No functional changes intended. This only affects ancillary parts.
> 
> Sounds trivial, but this makes it easier to search the correct
> entries in xmenu by name. It has always been a pet peeve of mine.
> 
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---

Adjusted the patch description a little to remove mention searching by
name (since user-visible names are not touched), and applied.

Thanks.

-- 
Dmitry
