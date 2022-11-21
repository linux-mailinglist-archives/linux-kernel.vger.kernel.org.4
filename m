Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20359632C44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKUSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKUSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:47:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D455FB2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:47:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y4so11412229plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slc6To47rlHTqeVdISg2/ZKmr0STUWIrt9f/pkC/6u4=;
        b=wz4QmcHWoYLuLZDiQdvOhF1LlhHkdjopyRkZVTXjug7tnMGqZ+1Slh2px9OUBglyWe
         MDazcQS6wXqYke2XdS+sSl7WUDIE6HytecaxaSeSqjWCrMuS1oM4EzcxI9lrpJPCheZD
         sEfa3CSSbVp20pegnD1AGZjRYvCj0u16ZzERAHGxbgfWoAaSeFLBZB/BEr2bxZWF9xBp
         WPGUJzxl9mV8OlPsXC2+eHXJz2yvidRapHWaGdXWDU11yIgOxP2z2/dxNzpTKm7LRbW9
         vno/N5V8OHQlhK7Np/GiLNxph+Usd/t6LxIuNswRVLz90u3JPhEwvFdLXaG2FLKAqs4W
         c+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slc6To47rlHTqeVdISg2/ZKmr0STUWIrt9f/pkC/6u4=;
        b=Qq2xsTNHfvZu1XxDaiR05WKbbFlJF1bvjg5ie6rZMtmSttj0jbdnfbwpJ0nxTxtJg+
         oam9yMNqxM4uDFdxv8/xCalDnSFKnT6IIbXCeDzcQZH8vX4poMUj96cJHJZEu5ee55J0
         FD96OTYvY8/Ez21lkeniZlprzwgW0ZdDSoZZP9gFiWk6X5+12XyLniI2W42vmlxiII9x
         MfT2rQdcLUss5VoctlOUw2U6LInUyIFczykNBpfoBx+GQBtcwdIg9mIIFfAHEbssCRKZ
         JvBZ5aAX8DKGFLx8sAdNBnWX0xUMsRNdX8FuIsSahVCZlLzjecv7HoRkPznQnNI4qB/t
         utiw==
X-Gm-Message-State: ANoB5pmIm8g6c1ImZRgP4pCSK11gI0DfdQe0AK+3qOf23XObulxrlmkD
        RpcJ8xwmiNS6N7LkCJhi4r7w8aLWibj2aDL0kaIRa599lQ==
X-Google-Smtp-Source: AA0mqf4Y35tBtTO5GhLJwsHdoVbWb3knJmpPRFMhjBKTnUFCBRf82bGhlt5Uldqb41tru1IhkPSVsQD7DKCXl2FpqHo=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr27550835pjb.147.1669056449326; Mon, 21
 Nov 2022 10:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20221121142014.0ae7c8ff@canb.auug.org.au>
In-Reply-To: <20221121142014.0ae7c8ff@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Nov 2022 13:47:18 -0500
Message-ID: <CAHC9VhSTLnEX58gGFCEDHo8K3CBkU33b2oqVKUvDhRyz33ibmw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 10:20 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   security/commoncap.c
>
> between commit:
>
>   8cf0a1bc1287 ("capabilities: fix potential memleak on error path from vfs_getxattr_alloc()")
>
> from Linus' tree and commit:
>
>   f6fbd8cbf3ed ("lsm,fs: fix vfs_getxattr_alloc() return type and caller error paths")
>
> from the security tree.
>
> I fixed it up (I just used the latter) and can carry the fix as
> necessary.

That's more or less what I've done with my builds, thanks Stephen.

I asked this on a previous conflict but never received an answer so
I'll ask it one more time: is there a recommended way to notify
linux-next of an upcoming conflict?  I generally notice the merge
conflict within a few minutes of merging the patches into a -next
branch, and fix it shortly afterwards.  I'm happy to provide a
heads-up, and a merge example, but I'm not sure what the process is
for that, if any.  Or, would you simply prefer to notice it yourself?
I'm not bothered either way, I just thought you might appreciate the
heads-up.

-- 
paul-moore.com
