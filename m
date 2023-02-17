Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B469A370
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBQBez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQBey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:34:54 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3F38E8D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:34:53 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id d66so3989707vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l9QawtwefYsPnZKBD7o3oFX19/phkpZnUIQwuclt4C8nCybZmd70j6cPg+VLix84oL
         Fq5IifR2kzA99F5rVHh7PwQHunL8sGLnZIcku0Ae6XP/bX4AyBTvIrwG55KYXgyij8om
         XBpyCmAvBaDX6gn1FOtBvDJCbPuOtnxYGci4RjJaYF33Xlka5+sQ0fuiIA22brOfax9U
         0yMee2lD42gmWztZxhcfe0jvocLUtg0PeNy2SgucXP1j4SswaUtndo2Jz4D41bRWGtMw
         onCHfqBhPdlh0hLXa2+5kUqNgqn4REVp7FHPvxIdkHv+9sGlrb4rE2dhexRXzvneygqI
         qBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=qmIgtTVXtJz3Of1f58uZbC8CM1u6AIYCWiQqPLn0VpOAAcL122aw8ApakEQT2iz0Kf
         1Eb9QKOFCgPjIWHSjRhXlGcgkyD9ZkDG+b7cubjWaSL+31GInmyCm6+9C6eMdNden7xn
         J1o5NPo47jO5pw1M6kUSuWaQ7Da/1alLBPaxvX6uxDhZxCrxmxj86McLBnVi+5xhiijP
         6H799Rsy8G03H8bgmtxLe4FXvepBxCbYT5Y2aPXfCsWYSLdE210Nnr9jPZDJgU5THPlV
         A6br+lrSglIs/kYtXDulgQ06Eh9EEETJAbPmfrG/paw1IKBiG1BtRb0rjWDlxcpxlHRa
         UlgQ==
X-Gm-Message-State: AO0yUKU6pderGE5f+D0s4erMByuKMLZFqQozFCUpA3evjYh9B+5GX92r
        4lcPMRmv+9xDjqLsEzWj67LmkomRDE+M0wzdtgk=
X-Google-Smtp-Source: AK7set/KkH+PFjCyZCo7YQ4x89/y6zOI3yE2/W4ujTrtC3fsrxoAVA/C1wO78ZDBhv1o6GQdd/3rzVLgTspXkVSfQBE=
X-Received: by 2002:a05:6102:115a:b0:3fd:c79b:f165 with SMTP id
 j26-20020a056102115a00b003fdc79bf165mr1520755vsg.81.1676597692701; Thu, 16
 Feb 2023 17:34:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:c6c8:0:b0:399:5de0:e36a with HTTP; Thu, 16 Feb 2023
 17:34:52 -0800 (PST)
Reply-To: garnerjulianne64@gmail.com
From:   Garner Julianne <jenniferluo48@gmail.com>
Date:   Fri, 17 Feb 2023 01:34:52 +0000
Message-ID: <CACSpFE8Xo=SzPV2G0uq3BE+d0ETFgjAV6uSRAuQEg0_8G5BwEw@mail.gmail.com>
Subject: Bitte, haben Sie meine vorherige E-Mail erhalten?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [garnerjulianne64[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jenniferluo48[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jenniferluo48[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


