Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296686239C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKJC1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKJC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:27:08 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9661E703
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:27:07 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n83so529569oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhMEnlxS44znfr2YlrbYyzq5ZBdKkCjGtEGeH1Y4tdw=;
        b=FbaDTZ5ul1IxTf7AeW4k/N5YOWNRDKcJ1uRnxdtDqTuIT65vCwu5HF0WtroUMlYcr0
         kv9XOEsiiRraR4P9idPwqdJWeJlMlFSPGouIMJ6PeAN6fhxsWAilf0zpbDGxwyGmkcK0
         d8AtpUJ/I8fyi5/arefzbFZqS7yxpjBu6ZfY4B9eJjW1BL7p7rdBYmOE0QYNkjxuJyeD
         Jr9tnIa0OkvYs35rYI8QowG5fYrDgCwjMBSrwn7PtRl4K7WhFYZUshDIrLLoEGyfBI5i
         oqwwI9Nnn7vIOZUwMtet/iYu6qt2upQAlbuzc7dUerz2swNCrrZRBEBj/PKkVDFNCvyX
         fS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhMEnlxS44znfr2YlrbYyzq5ZBdKkCjGtEGeH1Y4tdw=;
        b=dFVvrofCkfNjrtBc/f5uwwLacJcR8FAtw5/2JsYWKOxe6gVdwSxFgVj7xjuPfviXwN
         K8RJodHwDOsWcEdiuKE3AjWUtoZtDYPFFahrzbkNWGIYEouq0+f5bPOGeolPHz7N6NW8
         Fa1oNLVdYL3BIEtf1iFAwnsPN22FoTqlgXC5ugoz68IvB4XtRZZcaL4Lndr/nkf5NU5T
         kQ4tZzvtx8M0eTACFkRFR5+lSpi7kfNK7DzOR6MtG439Y2493/5ZZ1vSUmdIBx2Fkbhs
         2+8BgUIJCWfCQ8Zp+NUbyrV7G2k3QJgJw09UxdPc8oWEevYYUh5mxrbqeYAEu0CHf5NP
         sFIg==
X-Gm-Message-State: ACrzQf2ajE+to4nXaTyWQ1ET5jkxoIsEYZn0uOXTDDR2PTHU9H+Cst5N
        DfkGw0SRImbLclheIv15p0klIwQRB6NCZnVcXoag
X-Google-Smtp-Source: AMsMyM5uysiz+69SlikdhKDCUdpn1Mw/JBS3Yyz9CcV/LYE5OY8RPdM7Oz8skcn1OBFgHkqG1WLzs9QNU/FMKeLAFZ0=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr20456669oiv.172.1668047226370; Wed, 09
 Nov 2022 18:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20221110124118.37e626fb@canb.auug.org.au>
In-Reply-To: <20221110124118.37e626fb@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 21:26:55 -0500
Message-ID: <CAHC9VhSgxNy93KZFfmG8-0-MqTVE-WuDbJNGz=c4NSEnmTWPuw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
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

On Wed, Nov 9, 2022 at 8:44 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the selinux tree got conflicts in:
>
>   security/selinux/ss/services.c
>   security/selinux/ss/sidtab.c
>   security/selinux/ss/sidtab.h
>
> between commit:
>
>   abe3c631447d ("selinux: enable use of both GFP_KERNEL and GFP_ATOMIC in convert_context()")
>
> from Linus' tree and commit:
>
>   048be156491f ("selinux: remove the sidtab context conversion indirect calls")
>
> from the selinux tree.
>
> I fixed it up (see below) and applied the following merge fix patch
> as well and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

I had to make a similar patch for my own testing.  Thanks Stephen.

Out of curiosity, is there an established procedure for notifying
linux-next about such conflicts?  I'm happy to let Stephen find it on
his own and handle the merge for linux-next, but it seems like there
is some duplicated work here ...

-- 
paul-moore.com
