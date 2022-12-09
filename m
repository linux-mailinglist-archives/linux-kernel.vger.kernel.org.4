Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E766487E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLIRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLIRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:41:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E88D182
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:41:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn7so5595895plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFm1mHWqGIzhe+rb1eJUuw0XvgXopgBYaEtqlXPVfz0=;
        b=hKQY4J/pRm6CWAMtVWIamF1UR1S5ytG4Q0dHLvMKrbYlyUycxPoWBv9Nvh4aE85080
         MWzlNOjWwFO925vt2GUNcS/9BsF/orNKSvNrMiJHpxpXZP/fsRzj2P95wFaUt+bI8jC4
         HKRo33TkZwcuRzKPFMZ/Et6g/CaKhLpD6XEakiYyIPyXFiTK9hpXRej8x43ZakzvAdnu
         cc2uWLlT8LDekFoJ0DodzV9KIG5fEqwrWeJJE5FFSWTew4hhwEfHkkmQuMbzZJ1BkUaR
         /AoTD8PntICNQW80RuAfzK6ZOG6OUwhJeXxnL+Z8dW9hRID7YD/0yMk+1SSU/RwDz4Iv
         IAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFm1mHWqGIzhe+rb1eJUuw0XvgXopgBYaEtqlXPVfz0=;
        b=PYo2/Ybrad/Kk+CUNznHSPuAqvUypucXniETTVBGP34hlQkqjMbXWscEhujhcVWS4l
         jmZOEedA4nDtUnqXNSpa4atxfCCcWTytTp8UdCIf52Op5/W+9nqMxd95HKi50OwxBnR5
         p1rmhC03M9R7ypG1raRI3qq+wFmIdDKaaU3TxM7rB0O5vMX/aCCAxGtVY6i5q4NmPD3W
         aEBgNst93z1g/xM5kdOZOd0beJzv4Xy0I2GxgezotimIo8D7CxdzNGZvfDblXf85dpDS
         7MsJYY1TQOPkxoWqWcRyOGzNbh8yikIoJz2WGP59BDWZftc1DUPaqxoQXvley5dcTDv7
         wVcw==
X-Gm-Message-State: ANoB5pnSr5s/pETTMhle5882v4yDa+E+6/3i6QYGZo/Na6RsG/psalQR
        nkW7qgQKGy9lLJko5ZFYpyazEbY+KlgOLfoK78QZ7HOmfszr
X-Google-Smtp-Source: AA0mqf42Th/ALMFAQak9uQXYbmo+LSPCJ2qrOZQ93/pWBADQWGsh/kyFsqjnomlO+PB/OJ41SRslxU9sOKyJx0wF70I=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr108635116pjb.147.1670607703640; Fri, 09
 Dec 2022 09:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com> <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 12:41:32 -0500
Message-ID: <CAHC9VhSz6b9AcpKzAn2Lz_9SW0yNqiQ0Ub8fXytFy7sSBmXipQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Fix fs_context_parse_param description in mount_api.rst
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Align with the description of fs_context_parse_param in lsm_hooks.h, which
> seems the right one according to the code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  Documentation/filesystems/mount_api.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

I'm going to leave this patch as a "hold" for right now.  The existing
text is arguably not great, but I'm not really in love with the
replacement text taken from the LSM hook comments; given the merge
window opens in a couple of days, we don't have much time to fiddle
with the wording so let's just hold this for a little bit.

These comment corrections (which are very welcome!) have also reminded
me that we really should move the hook comment blocks out of the
header file and into security.c like every other kernel function.
This should help increase their discoverability while also making it
easier to maintain the comments over time.  I'm going to post a first
pass at this as soon as the merge window closes, and once that is done
we can do further work to cleanup the descriptions and add more detail
(including notes both for the other kernel subsystems that call the
hooks and the LSM devs who provide implementations).

-- 
paul-moore.com
