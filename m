Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF33629CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKOPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKOPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:08:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77569FF0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:08:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gv23so4020983ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTfeHWdQpYzScR0IYhK542Q4DB1sWCfhQ34vRdL9HzM=;
        b=hjYGcK95V/Y+c+Sw/+JpTF4ubBz9ykH8BcyRLaCltwFDCYcMDDjGsMFFBa1zpl5SoE
         cpq+axRW3kK/HEesuSV28qJGCFX7JAn6PQkUo8vYfxjbcVChjXWLaZpT0fYQcZQOOTsD
         U/U/lWhQxbl6AqVTQN5l1Q0kOvI9TIKMz0ikS+uucocatZvbcOc/Syy0pTGkrm48FpYZ
         xEXh1Ke2hPoElv6fO6x4VTm3QlRJXhEhP926k7srInJ5yg8p/xvVhP9UsRquGU5jLhND
         nVK8gzkNENVpBjTi8cMxFtk0iEX4g4rCzCWe4Pfv+YWX/xO7ESWyvkiJcGdiWI2a9YIv
         iSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTfeHWdQpYzScR0IYhK542Q4DB1sWCfhQ34vRdL9HzM=;
        b=3U0wbOPGAERP+4GDjafdyDEpDvmali59NlYnqnGLKXtrhxG4niJX5mEqe9DP1ZfmVQ
         YYY5DfqZelya1ky963n6TPnQTGEoi5hmzssorQ+wWm58Lkva4zUGEPPccepjNtx6G548
         9I67xUGr9acOHCdmaTZnoMJM6qBAz8IjY/9aWzZXqgzqQJiq23QWvW0/8zOwNFef0AUj
         td89A4vIxfFARkfTTzdrcmAL+vlNSn5ZqXoiN5GD2Qe01V4iujh38py7++F6V/zYhNln
         KbOricvE8nZubF2eWAeotWAJgDMskAw03zdB1d5g+e1PHemWWXI0JtoMhKzcWAWn06TC
         VAQw==
X-Gm-Message-State: ANoB5pn1txTb/Kpg//ibpM/7htcq1yTKaWTqiWPTvZAurNyrjhTs/lck
        mkNwdZGCM9rT1R0GAs+y4X4PvMcoP3GVV8TjXGXbXQczs1x4KA==
X-Google-Smtp-Source: AA0mqf7fwtwTm2k4Iwt5uFb32Yo4UpbADkPfEXjLy9zl6d8qFpihOJ7TWjhicLJEq34UDIzgi+iHUItsHB64k3kNQFo=
X-Received: by 2002:a17:907:9a8c:b0:7a0:948d:80ae with SMTP id
 km12-20020a1709079a8c00b007a0948d80aemr14502708ejc.658.1668524933062; Tue, 15
 Nov 2022 07:08:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOGzEzeOek71ij9M1r2KUKKWbJvAmgS5imcURNKFjKNC3ORBVQ@mail.gmail.com>
In-Reply-To: <CAOGzEzeOek71ij9M1r2KUKKWbJvAmgS5imcURNKFjKNC3ORBVQ@mail.gmail.com>
From:   lkml gm4 <lkml4gm@gmail.com>
Date:   Tue, 15 Nov 2022 16:08:41 +0100
Message-ID: <CAOGzEzfvPHTuuCAEx1n4zVxHF6JT63oHu1nfRfaxuJBKGZxtCw@mail.gmail.com>
Subject: Fwd: CET shadow stack app compatibility
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> I'm disgusted by glibc being willing to just upgrade and break
> existing binaries and take the "you shouldn't upgrade glibc if you
> have old binaries" approach.

But glibc also claims this policy:

https://www.gnu.org/software/libc/
says:
The GNU C Library is designed to be a backwards compatible,

And
https://gcc.gnu.org/onlinedocs/libstdc++/manual/abi.html
Thus, program binaries linked with the initial release of a library
binary will still run correctly if the library binary is replaced by
carefully-managed subsequent library binaries.

And glibc even has it easier then the kernel: implement incompatible
changes by applying
symbol versioning.

-
lkml4gm
