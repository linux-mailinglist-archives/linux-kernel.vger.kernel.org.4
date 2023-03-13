Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF346B7B76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCMPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCMPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:05:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4381EBCB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:04:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r18so11644752wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678719890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntw4NswkvkQ8h4CSwsdP0fvCQYzjvQ4rhoDvE1FRNiA=;
        b=j10p2JFxLeoHLyUKBSeFyBDKP8szefabaernl+MIsCTI4EsJ0TjMK7xKZ1W5wUwk6T
         51ojoE0tgrdxgXvREnMJPWzo0iGFEV7FmeEYmlLSKRIyJaBlUkyWFlE4cKtLLhxfMgKs
         PY54x3NkgVGUvTMxZ+jaEjEakk2abQv78cLmqNkxfVWOPk33HKjrWeQv0x0lSt6nBpWx
         ATG74d+DjAzGBWQ0Fa6qquq0FLm46glGf2mSuSfiXP1Y6erKo1R6lVqcCiZCe/QPXYRO
         AYku9cgirKzxb5QvocIfW2hcaXjH4f1x3An32WVACgIMC+ilsYW/BtbNDqmDROTXquKq
         mM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678719890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntw4NswkvkQ8h4CSwsdP0fvCQYzjvQ4rhoDvE1FRNiA=;
        b=GRva+X+Rm2FRgA+R49CEd/Kl/NKCyvfuKRqx804Seinu2KbtkR6INH8QAkX74a5gtS
         MkbGEvCZzFVtGqnrO8MXn8h8C6QdyTOOfi0EUoTUF7QSE6k9fIjdegDMpAlE1pQD2oJx
         4jilrQe9GAH8mW1I76L7xDZiSIukBlgoquJChp4CGCGf6cXOFpguKNnx7chfjJdzYnlc
         3X8qMi0hqm4EfaPL2nbRoL5/9tQHOSK/x3jb//fvvrF+Swk0Ns5Bv3uhgL7gUHQwZqJ4
         yVtU4hj/JQCud5FF6YHUVGtUbdwMw6eIC/IpmKYfCyL8JIFajo70ayq3HklOxxgCEUGs
         ZMhA==
X-Gm-Message-State: AO0yUKUCwxMEVkSEBZ2ppGjNMC6XWCVwpPZgsjafRtFCHfSa3lidFmmE
        7YnrpZGtHHsXtC4NrIswDUM=
X-Google-Smtp-Source: AK7set/gCQvm68a5pe7NSAw/Kg7jjyn4kTIWaXE6wPFgiLpBwBQ8F+KtE0HSFSLXBouSVD6vahFiPg==
X-Received: by 2002:a5d:684d:0:b0:2cf:e739:9fbb with SMTP id o13-20020a5d684d000000b002cfe7399fbbmr482116wrw.22.1678719890408;
        Mon, 13 Mar 2023 08:04:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4250000000b002c56179d39esm4438264wrr.44.2023.03.13.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:04:49 -0700 (PDT)
Date:   Mon, 13 Mar 2023 18:04:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <f545dc88-717b-4fa0-851a-733dd5fc2eff@kili.mountain>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
 <9938109.ZD9C4EEAuf@suse>
 <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:48:43PM +0500, Khadija Kamran wrote:
> Also, I had one question. Is it okay to write a long subject as I have
> used in this patch?

People say subject should be 50 chars (I forget the exact limit) but
there is a little bit of flexibility.  This subject is too long though.
Perhaps I would use something like:

[PATCH v5] staging: axis-fifo: initialize timeouts in probe only

regards,
dan carpenter

