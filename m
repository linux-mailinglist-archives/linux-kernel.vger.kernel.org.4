Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F06450DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLGBRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiLGBRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:17:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185495130C;
        Tue,  6 Dec 2022 17:17:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t17so16128719pjo.3;
        Tue, 06 Dec 2022 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+qLY3EPYZFk3S8t9GrwbvymykpEf3arJ9+0HtFcXNU=;
        b=fjxxThz5ilAc81V5nEwm3dd/bCA0zYXEjNzp1v0Gm4rtpssjcl6lCv5ZT5xQwkJEwI
         ThMhPc7S8fh0CnEh7m/CtQ39yIw1qLN0JfhfZuj3En79JDp30Guc5RUH8rBl0RV9WFEY
         Pl94WzpVWSwnyf2ZVxJHKFhSluUobf0gWhpSvhipad5Yg/A8hHTHoA1URSpaE9b5WMxH
         jVsBc7BDiXat0+cV42MdWNQa4EVTfdul7kg5lg0hri1gtOsqeLuMh9B8IxuT4hXHlmuG
         plRooBm4sq0VU6Yeb0lH+PIKC5kf84bPWe91xWvYEaSVGgIX6lvBpDBQo6FZrv19CsXq
         9Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+qLY3EPYZFk3S8t9GrwbvymykpEf3arJ9+0HtFcXNU=;
        b=qIvGBbc5z7CT0or0MUTGUEtdgJcjtQFpRG6B18l8BgXGLsO+cxIHMTseHpkK1Zk4XZ
         clQDURi44Gwur+1WGy3gvQ77EAbH5mUr1kRU/GXVtkVf/uJ0b8YyZwV3XTgdLQxRGEFt
         hhBd+GpH+nEjENL2UUoUp4VHDGyFDieCInSxajiLgAgNAPG7i1j3Zmune60/3gm3/Ek5
         uo2fGeiM5qVwLSgSZwK+IvwkB9nB1jUjx6Nqc5MnGXVtm95pRlPYJBB8Ul1d6cLsm703
         tauQG+RLfGTqUC00OVGIArXDw7iIXTbQtP6rHZkbpeH9JIRw5oBWd+UgNgwkXavlWDP5
         urWg==
X-Gm-Message-State: ANoB5pkhztc4YN1yBz5Z0Dp2P/o4TC+HADAeHh1oinOx6ycfhtq8rObI
        2/e4JbS9Zw8c4lWkpiLwppk=
X-Google-Smtp-Source: AA0mqf5Vw26+iSPBq95kHhdzX3ISKNub3Ao5W23bX1P5KDcEaq8mCi7EAvfTnjFqiRRS+ayD79/NdA==
X-Received: by 2002:a17:90a:e556:b0:219:b502:a2d2 with SMTP id ei22-20020a17090ae55600b00219b502a2d2mr17823250pjb.230.1670375830461;
        Tue, 06 Dec 2022 17:17:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b00177f4ef7970sm13326204plg.11.2022.12.06.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:17:09 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:17:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH] module/decompress: Support zstd in-kernel decompression
Message-ID: <Y4/pkgE+xHLt9Sm+@google.com>
References: <20221206215318.3955400-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206215318.3955400-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:53:18PM -0800, Stephen Boyd wrote:
> Add support for zstd compressed modules to the in-kernel decompression
> code. This allows zstd compressed modules to be decompressed by the
> kernel, similar to the existing support for gzip and xz compressed
> modules.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Piotr Gorski <lucjan.lucjanov@gmail.com>
> Cc: Nick Terrell <terrelln@fb.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
