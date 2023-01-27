Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AB67F07E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjA0ViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjA0ViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:38:04 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77631C5AB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:38:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so4031388pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieKGpw0qSkomisCAwTZ7FnjclgPzfg7EJIEEUGgfqTI=;
        b=lb14P5NgP3z52lpuwacFSySVxFE0yPNgRcjQll83HXZPFO4KnEoA6Hy9XWe+nu20oF
         3h5BnVyYGZvVIsg0SwBUqg4qZW04Lq6aSQbtX6xBmUQ5er4z8oS1hYRH0t7/ou1yW8PI
         zHGhXKxg83vRm+ZZEbsZnG66Q57KGJdg495hZC3m1r8k+0imLlWpJdnReIFInBjDFeD5
         jrKv2pNpKeiVor0HoLDM2GiuOo1pOKZGB1KpkzNvW2Z/QYEyaDHZkgPuNfIC9IGvgZgf
         gXI+qXL7eUyeGimURWiXj4WvFkt0uJr4ny4uWE1c3vHe6DRKD+WNVSJDOq8/SUWJdZUp
         R3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieKGpw0qSkomisCAwTZ7FnjclgPzfg7EJIEEUGgfqTI=;
        b=K27khZp7B9034woND8tA0DMqMAr8WOR1Qamk/immfKsDiwbu3BFFXHKfbrTfgUfKSn
         DXlkQ1D2FB9wZhrIeKqMzGicggmYX2hoPr12BH5DOSLAQ5zjbnAfH0ldi1uEm6WByJIp
         /azUCR1az78I67YOMuartkqU2hHhlaeRCKP7eg9w/D5vQR61rtxAePGfgHgfIxna8syk
         HHCpdmw/Kw+vwyy3hpS0mWMherKu46WoV8pZHThjsNVe6I/VKdPeGKUHCMWJJVP64iAE
         4RzxUwxwfcUc3/O7fesrWK8PGYAoIQxRRh35UpdhsI2MP+S59rrKegr0/z5XCI/A3ACD
         4Tug==
X-Gm-Message-State: AO0yUKXOx3lfn87OWeWsKceQwuJAN4i6GucQJhIvnoub/qXSLQ7C2l5k
        XwAEpaDcybhJsRY7pRM7u1R9BwiwgHYUjfuYn1Q=
X-Google-Smtp-Source: AK7set88dMfzY5pL6ndgn+HGPaEV8H9JrlGLvqUI90h1gzp+fadV8jIgoLZlq6WD6UurJAAZKN6GwHBg+zm0aYQ/7mk=
X-Received: by 2002:a62:7b96:0:b0:592:5e6d:5145 with SMTP id
 w144-20020a627b96000000b005925e6d5145mr764350pfc.59.1674855482858; Fri, 27
 Jan 2023 13:38:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c589:b0:3e7:2719:a38c with HTTP; Fri, 27 Jan 2023
 13:38:02 -0800 (PST)
Reply-To: mrrichard.ne@gmail.com
From:   Mr Richard <abdullahibuhari920@gmail.com>
Date:   Fri, 27 Jan 2023 13:38:02 -0800
Message-ID: <CANAHEa_kPKQvVv-wBGLcO9o42KmucGEBj5yUvJmzhwZupUh6rg@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day sir/madam
My name is Mr Richard Nelson, i work with trust wallet company..
There are lot of lost funds in blockchain network and trust wallet
have decided to give it out this new year to individual contact
the admin for more information (mrrichard.ne@gmail.com)
i am waiting
Thanks.
Mr Richard Nelson
