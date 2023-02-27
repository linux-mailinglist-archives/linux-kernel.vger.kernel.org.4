Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CD06A3AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0FmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0FmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:42:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B0126F9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:42:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp25so7071727lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBFnueqV8L3YkgVg30ou2eBXmOgH1iL4NqHBZZyRfPQ=;
        b=qT9u8hmP/mJSV9Ogy+jfkieX4NEKzxJu426KFxpi4Fik6mxekiA7Gu2UnMzczzroT8
         ez2gZLHYtrcu3Q5DWmlJn0cjYwQQK50EFPoJm6vDqWbDjW/PEaNRwvp87KMdS3tNrtYO
         b03jVlrweft1JCsuhsKZfYdfpLi+z+LqAOLicSL/2g7QIjuYVtGYzPL8POjw02VrlWlo
         0SpX+KnkyabY74j/HjicUZ3y+QI4f5lAdNDTUSxb2uEVwlOF4Yi9q+N6yoMEe/HnZt/k
         CH48qmigBrjPEyvzNNmxDx+edMCDwuSJZcoTmcR0nvwkr1oHCMyu5k8ICzII4M7KWmDt
         zr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBFnueqV8L3YkgVg30ou2eBXmOgH1iL4NqHBZZyRfPQ=;
        b=3Sy9ldmORwBW2RVZQIk6wOkQwS/pr5qN4pYfjoTfGOiwloejKgP3/MC5RpTa5RAmYU
         nPWYwt2fSmfiSFFY01lDFvuiSbk3kgvnfSLpLtuv0ip+xgH5rhjFGkzB0NGdkQWR1WOc
         gMzj0WXdS0Jo5841FqvLFZGhBs1wIE0AWsDTV7w0XyBmoDsl6ZNmCywMBbMfRSVWer15
         DCxGVIt1BYD0tF7vAcCYimZ25QnZioyq9jwh95rs5BOnFd761tHdMqVaAY7nHdwaCcrA
         GooBabt9Uw7I5NwK2/i2VXmUKE77224tG/4hG7sU8QNOtx8o/yonQqNI3UNnWzSWks/7
         noIw==
X-Gm-Message-State: AO0yUKXWyaQd3dW6d6mEgtrFUy9YREostHmfbHo2UiZxB28fFib/GyF2
        NKZvHYJMtwJYODE9ytIVa6SuUS1LCCD1MmS+iT0=
X-Google-Smtp-Source: AK7set/hhUABon+EZNt6QSHD4CZGjr9dZrRmqf6bkJtEJ+rb5YTG519Hp0Un3Jndg+nBQBc0DCkaU5BYI+ZQdbWcwUY=
X-Received: by 2002:ac2:5989:0:b0:4db:2425:5d11 with SMTP id
 w9-20020ac25989000000b004db24255d11mr7112909lfn.5.1677476531211; Sun, 26 Feb
 2023 21:42:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:b318:b0:38:f2c7:9dfa with HTTP; Sun, 26 Feb 2023
 21:42:10 -0800 (PST)
Reply-To: zebulonmatsiattorney@gmail.com
From:   ZEBULON MATSI <chrissandy954@gmail.com>
Date:   Mon, 27 Feb 2023 07:42:10 +0200
Message-ID: <CAGPCK8fJ7=kk4BxmAphnr0po-JuXFZ0xhydttG-xLPwBdpsdNw@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chrissandy954[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [chrissandy954[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I have a business proposal for you  Kindly confirm your willingness to
partner with me.  I will  furnish You with the full details, Thanks

Yours Sincerely
Barr. Zebulon Matsi
zebulonmatsiattorney@gmail.com
