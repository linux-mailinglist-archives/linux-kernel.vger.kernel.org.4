Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27355EAC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiIZQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiIZQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:25:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8B12AFA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:14:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso12791518pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=TQR1b+nzyuc8ov+hBmAb0rAfJyo96VnisRwO/RamCmo=;
        b=GJ6jsH7IGUIZ2la75NmNaElN/vQ22kVn/gulzr5q86Zr/Iy721K4WYpP6Uf9UZccn/
         vO76EQgbtaH9E1nfXhmz1HX7GnYpyjRDVD2tAJ6MyAXoI6H8IHSA57fONEgToTEPg0no
         6r+nf8kr4HgOJPz1QUAHdq0XxYRV8Z1N2idvIilddDxu/J9XxMavdc3FVqF/3EvONspb
         6JaYD12I6GWJFCu4LY6+5/OKGgynu/A6XkvS60kx2cajVBiAJzFozuO3rzSJhOOJ7zm0
         TFEUfsmZjpxeemg1XygonGSI+QRKPNaFGVjgGFFBv1j7uRFdtQQys688cAbRIZ3YB2wH
         7zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TQR1b+nzyuc8ov+hBmAb0rAfJyo96VnisRwO/RamCmo=;
        b=76HfS94JMUXnFJqpyPnDieYeA4iav+l9c9L78WaTYypVEJPJi9NpUi7+Uygl4b+AOg
         oZ47A6aeKswMFgAoe5tYXrk8UMj3las0F52Ba1TdzOL8tLCdAbX9+F8EydVigMUOh7vB
         2HVUajEYySTm8mIUoJnd+SPVjy8XWQ5nDZFGybYZsLyOX1o5Yucbfbp2b82wFZZfxZW7
         zVzBif4KtbCDIjYrMvAAQIbESOQmr78QG3UYx/CmR5kXcASUrd//T2Tw7ijxooKuvOye
         9XTs7YWcvWA3AfBuO9LQKnMnqHMxqH+P4bJyof+TXhbRakMrMX5LyT6fkCWU7EEu6sJ2
         71SA==
X-Gm-Message-State: ACrzQf00cIysyuBd0BWs/4c1kY1S3Uj+vD6F6ZSKpJEbXesbwUzicdIx
        X2yuGSl+8XIKT4qrG21KKVH0QYDYpWIZRGuI7+o=
X-Google-Smtp-Source: AMsMyM540lqnCiojFfAVfariKQjTwcr9GDI3uV0TU7MbUBM1MkqXmyvE7AYhOD6hS8D3xz6dIVyKrAcIGila4Q5Ut0E=
X-Received: by 2002:a17:903:240b:b0:178:a475:6644 with SMTP id
 e11-20020a170903240b00b00178a4756644mr22794609plo.96.1664205263101; Mon, 26
 Sep 2022 08:14:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2821:b0:2f4:5df4:ad0b with HTTP; Mon, 26 Sep 2022
 08:14:22 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Mon, 26 Sep 2022 15:14:22 +0000
Message-ID: <CAAnwc9usbG67afgi1TX_kFsJKyPNcL7cckvD2pJAa=qM-o6-ng@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1031 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman358[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman358[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Ich danke dir sehr.
Michelle
