Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51E5E8195
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIWSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiIWSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:12:55 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA3EE64C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:12:54 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id q26so760302vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7t6V8MWLRtUrTvu+MoIbCnjiI/X4WEGD3aHIxGZW2yA=;
        b=PQRyfmgaolbiYniSRKRyPZi4Elih62nuDEKXwXyjPtGLW3tx9GzmDbmqpLrVb0cipO
         KaK0fgca2P0sl9fyfgP7IbPxvfrX2DIOmqV+8Y4ut5fJQNEGEDRg+Xz4tiPdUTR5WDWJ
         Z1LrctFgO3ffQziTPoOmZjEzbrD573/5f8I5NlFWuB0TMlya2n/FQJr4fq+FtRtQnpxB
         i35ObhVFZcvWf6M1NtzB8+wHkfnhGKonv2bfbyfOnNjg3y201TEbCZqb987KGBeeWt1j
         L1UsNEdU/azcrk5n5A77BUJmQnrbRA9o2MkAj79KIa0GXmiJYo+lPC2wMmv2B0krtHJh
         UumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7t6V8MWLRtUrTvu+MoIbCnjiI/X4WEGD3aHIxGZW2yA=;
        b=5hBrmuggDDvx7EMN4vSRomfSiqnDDybpEZCSPJ7lwfb4WIsHBJzFo8eZSlisCvGZwq
         LSVDqLLAJcrhUQsZWopgOFgF8SmCDfmzU7QsWi27g5qGXi2ejUdj9a9di6LhkaCOEslA
         dnrTd4OAsaYJ4QGlAs4Au9ZMfCKgOptPJloGaJAQk+nrtsyp/7sfyC2TdQo9r1cvhwnj
         2ii/XdAHsfFh8MS97Q8ZumFjhWJc5s8OaTptkj2LYHw+8vjglCyLHv3ntiqmE1tNjwQN
         RzPAPgKBlQ3hJNG/wHt51jcDZyr/3gKzohU/2fYnrHPBuTN45YJ2X516RxGaQ5q3Phe+
         tCTA==
X-Gm-Message-State: ACrzQf06rgjSGMgKXQjSngvdvEZBk+wF3qf92tVb4urJlX9kOhi6V+b2
        YOMCFSAdrrnQa8uJidbCFppGPRoQ3AVmJkddcN6QYmd5xH4=
X-Google-Smtp-Source: AMsMyM5h14W/BLMKzlIRTPJMJ9YQE8hsu3vqrIBJtsX20teoF1ATwExCh1jUlvj5Pgln0m4yLc4eVdl4/uQSuSs1sfA=
X-Received: by 2002:a67:ea0b:0:b0:391:7da:9d76 with SMTP id
 g11-20020a67ea0b000000b0039107da9d76mr4105764vso.84.1663956773490; Fri, 23
 Sep 2022 11:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220923110332.24090-1-unixbhaskar@gmail.com>
In-Reply-To: <20220923110332.24090-1-unixbhaskar@gmail.com>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Fri, 23 Sep 2022 11:12:42 -0700
Message-ID: <CAE2F3rDymUUDyXrxFyhSGe4k1jrsZih2DbXViA23wAND=XJuyg@mail.gmail.com>
Subject: Re: [PATCH] kernel:gen_kheaders:Replace md5sum to sha256sum
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     masahiroy@kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 4:06 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> Thought to apply a better encryption mechanism.

MD5 and SHA256 are secure (or, in the case of MD5, not so secure) hash
algorithms, not encryption mechanisms.

> Replace all occurance of md5sum to sha256sum .

Looking at this script, I'm not convinced that it relies on MD5 being
a cryptophically secure hash function. It appears to me as if this
script uses MD5 to simply detect innocent changes to a set of files as
opposed to guarding against malicious attacks. I also found that
sha256sum takes almost three times longer than md5sum. So, in the
absence of security requirements, md5sum might actually be the better
choice because it's faster.
