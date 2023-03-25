Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028F16C8CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjCYJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCYJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:03:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B312CD1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:03:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id eh3so16580551edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679734981;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJNE9HivEezriU17FulVrFkExzHQ9JpPi27VKincFV0=;
        b=hO0PtRqRGh27XG2Q03qtijcunvOaFggIFKqyeLIDxMWkumO+j4v2ngFbi5QhQqL0wU
         OwKKGVlunEZajxolA2G1eq5ibsOC6cd/GwZ/nhcrTCb4tZO0uRGiB/+W75fnFIKxHFKP
         zspgk6zA9Gr9Y8uo7jY/0Jc/Uzyjg2rTHUU6aL2KJ4ozs+rdsikH/4cL0F/sS+9Fx6vw
         DECgCfesg1+M76pYvYqzsufw99R0liWyqzVmQR/UAw+6EUiLDPwv9jTEn9gbG1lnYVQU
         Q6PgbZT7EcdJQjbma9/s2FKJUddOu6N6nZ34EjW7qa5+qPndGepF4JDmPxu9TgL2hDpw
         qu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679734981;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJNE9HivEezriU17FulVrFkExzHQ9JpPi27VKincFV0=;
        b=3MAYVOJnZcb38R24HN80s9+8FPyNJ/apgdkZ/WPspUSY4JTK6FBxUfGh6joVeifFXI
         WIkkO/vcknSouY2dGxjyu0hhUFP9BbHmz21/c5YrapmSi6kwmxGe8xVj5n+4QAQNY96G
         ofXq+tFyT68+CM4ugHmbQC2Xj+xQ+fjtCMhEFf9/j3htBi9PTRvpxcJet3k0IpDWqmFu
         ShlpeUrOd2Kp2PeY3fmIMT7YZd0CKgGGgvUqHd6FOvmT7cAYMQVzyl7+qRPolQy1ZW2o
         1xt9CzDaSpZno41MTiKOWh+r5JMgQLEVij/cTT6yIqnE4lttqAPMaQisn/tblLf6ewDx
         FEHQ==
X-Gm-Message-State: AAQBX9ckJ0ROFKTuEICodaASD+YC/ZKlwLrQCp+oUzI87sofxxht67py
        FgEQqt/OouEsE4fwpdl9PgtRKR/J/TQ83bSrIUk=
X-Google-Smtp-Source: AKy350YOn1Ke8MEjGtT6OvUD6kZL4USFhMArQfj8PTnRORUqFIO3+on+oaCLKkLyCtVi91CPF7+iDCYYfDDbvpZa+I8=
X-Received: by 2002:a17:906:d9c6:b0:932:fab:8a56 with SMTP id
 qk6-20020a170906d9c600b009320fab8a56mr2770659ejb.4.1679734981195; Sat, 25 Mar
 2023 02:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:92d2:0:b0:1be:aa58:e437 with HTTP; Sat, 25 Mar 2023
 02:03:00 -0700 (PDT)
Reply-To: ska.anna794@gmail.com
From:   Anna <emelinekouakou3@gmail.com>
Date:   Sat, 25 Mar 2023 10:03:00 +0100
Message-ID: <CALXFQUj95ptVon__Vh+h_gik6e3j4KE-UA85q5vSEJVhNjNtKw@mail.gmail.com>
Subject: HOSPITAL MESSAGE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=DEAR_FRIEND,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [emelinekouakou3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [emelinekouakou3[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ska.anna794[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with humble regards,

Dear friend, how are you, I have a charity donation fund that I want
donate by helping you. Please try to contact me to know more
information. Hereby I will tell you more about myself and my plans
money when I hear from you.

Waiting for your reply to give you more details.
