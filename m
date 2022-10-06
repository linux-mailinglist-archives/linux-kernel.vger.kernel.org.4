Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343245F7199
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJFXQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiJFXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:16:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A67B48B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:16:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so3028454pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NncYviyMhKALlmYEvMhPeiKu5ofAD5R4PjRUofrlqXk=;
        b=NYDIJrt6BP2NSKdIqnNoA71Zkdbc9FdIdlOaDQGYH/PP3dJ4zo9GTyTv9ZVci261Jl
         uMOjvLvAEaXpeUjs7BhdXUof9pfD2meNyMlLV/dtqRUzoX5eGU2p4vl9MPVuCnzIB45f
         mZKXwNebrYFJQbToKex12Ykoolx4WfBUaDGMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NncYviyMhKALlmYEvMhPeiKu5ofAD5R4PjRUofrlqXk=;
        b=DPWQkPHnEn0PgwIjko8l/RNut25kLYDnejvGm2HM7WMXrVTnkf6tZHgQLUHEug1+al
         C83FWKgrZSdnRU2YbhjHAM8J+eaQU1nyvtR8Y9LtBUJDEl/DFQpYwZARru/gJOoYrjjS
         0tgX406wvh8h43zx0axdkuR99RIYj2HXzteZzvY3TDTmUPoP0yEgScYY2EMYEqb0vzia
         oMYUv54IxC9zcUAVihvfVheAo5au2HW5T5vA7UmhueiX21pL+GecseMAcS1wZUk4JVYk
         YDtW5KXAVeymro/KYnIr39o2Exxg+TnTZeeyGPR0iyqXd3gFyzq7bBNer6AZqoBGQlWU
         M+vA==
X-Gm-Message-State: ACrzQf2Qo1sK/RxYk4T0wxyEGKNSuDRj6LbYz4r7Mlm3hHMpCc5W3YHF
        MUIUuxQ9CAdBdBBqmix3QZBzpQ==
X-Google-Smtp-Source: AMsMyM5mZ5GDxeFzvxFvNtGTSR3yZFQnf6xi3zI/xG/AWIil2irgjHnnq2KZenL+nhmwzy2NmAsvdQ==
X-Received: by 2002:a17:902:e5c9:b0:178:5a6f:6eb8 with SMTP id u9-20020a170902e5c900b001785a6f6eb8mr2221873plf.42.1665098181849;
        Thu, 06 Oct 2022 16:16:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x66-20020a623145000000b005360da6b26bsm150120pfx.159.2022.10.06.16.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:16:21 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
Message-ID: <202210061614.8AA746094A@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-9-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-9-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:12PM -0300, Guilherme G. Piccoli wrote:
> By default, the efi-pstore backend hardcode the UEFI variable size
> as 1024 bytes. That's not a big deal, but at the same time having
> no way to change that in the kernel is a bit bummer for specialized
> users - there is not such a limit in the UEFI specification.

It seems to have been added in commit
e0d59733f6b1 ("efivars, efi-pstore: Hold off deletion of sysfs entry until the scan is completed")

But I see no mention of why it was introduced or how it was chosen.

I remember hearing some horror stories from Matthew Garrett about older
EFI implementations bricking themselves when they stored large
variables, or something like that, but I don't know if that's meaningful
here at all.

I think it'd be great to make it configurable! Ard, do you have any
sense of what the max/min, etc, should be here?

-- 
Kees Cook
