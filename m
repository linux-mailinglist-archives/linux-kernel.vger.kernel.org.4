Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145A6B3414
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCJCMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCJCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:12:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F0105572;
        Thu,  9 Mar 2023 18:12:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so14751686eda.7;
        Thu, 09 Mar 2023 18:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1678414338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuW4ttN77OvnIjS1cIi9jdp1Pd2rdF64Np6HBzcn+YU=;
        b=mJzW8Wu5I/Hg1hF0Q36rFa3tvzC3JlTYCKrjrNiltc1NI32FOW6cto00C3faNLO/6w
         bDwXj2GgUzRfAprgDVA5Z0xJ/EkxKp/2aETvIFvUK6J68XEwLiPAfXHI5uucJ2FNMuVy
         NzQKUKzVTY7NmiFx87rNdTfC3dwW3fM6SH7+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuW4ttN77OvnIjS1cIi9jdp1Pd2rdF64Np6HBzcn+YU=;
        b=lRQlR8FJBUtx6EELQLqQWwi5nXBTGPJsIzeuyqGSxOC7mQG6kzcr8MyP3j9luNzu2a
         oGNZeatnq7R08CfFLvACg4PfofAhNiJqHhMoAxbPXqR+D5H63P29p3N2PFvvsS2CvLvT
         ppW+vjuVAh+82xA4uGiKx+hjDC+12cMU+BA89Eif89whmjn6AzdAI04oll/5PndO95ki
         npFIAwIFnLGk7Sp4d7iAOWAnYFJaoc6rZ1VkdXUb9D+hs6E7KMf3rRCwp2fZawWrvkVK
         8fv0UMYV1iJSavJKrf9ShSnNdOwYEk4s3aVjsYTG58cefDL3Bj3doTsxU9k4RTMdrA92
         e/eQ==
X-Gm-Message-State: AO0yUKWGubB5Z8CucHcJKn2vhMK5DGQDQw8WkfQwhURqRmL2mP7GnAjD
        3skbQTuftllMNaC2ELQ2HLtp1nLUQzQ8UytN/9SRcu1u
X-Google-Smtp-Source: AK7set9H9OV3vryGZj48SNjrLUz32UJ7lBdohTX/2Nl1ENmRnSLgkqtYDeaGw9JX7zVePBeUiT1UfXwthANnNyP332I=
X-Received: by 2002:a50:ab1e:0:b0:4ab:4933:225b with SMTP id
 s30-20020a50ab1e000000b004ab4933225bmr13188807edc.6.1678414337592; Thu, 09
 Mar 2023 18:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20230310130653.38c908de@canb.auug.org.au>
In-Reply-To: <20230310130653.38c908de@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 10 Mar 2023 02:12:05 +0000
Message-ID: <CACPK8Xc4wspCSK67PCUeKf4OHoiF2cT=hdfNP35Y2yRUycMK4w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 02:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   68ed3289c72a ("ARM: dts: aspeed: everest: Add reserved memory for TPM event log")

Thanks, I've pushed out a fixed version.

>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell
