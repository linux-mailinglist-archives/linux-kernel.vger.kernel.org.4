Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741715FBDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJKWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:49:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF92DD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:49:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z197so7173961iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=GEoUpWzyQJ1EOpEsREXd5rTYPMHiuAtqAlmA0RR0NMubUUPrnJ4/XkiOaDGQLJrOu8
         FuvNQm2L8j7Lcya9lRWWV+Bs+fCZTboDyWd/H71oavlGvovpnNwepb9T5Az1cjsOxmCl
         4b2f9h3cdBvjSOva+H1+oKdfmwZwoIgQAI7hpsGP2hm01xv2Xp8lTmeJCXfCQ5qwmpwv
         lWiZ4lphzHITpaEyXvNgHDhDJlBIWdgrhKw8Ds6IFnbhypMaypZ7MsrGhvMuq/Ti5DjW
         S0Yzrpr+ovSetT0en3/fIhcod5jPEX/deYIEdxuJTAvTGY7URssjTt7/yAtymbdJDmD5
         au4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=bMHy9kZGauhsuCNWhFmIxxilMN4RKirQ5yCva7+/L7ZpCY+tv00k+/xHkY/3RLrJpA
         q8Hma5j8+0QZRwGvPOYQquKjBuXgWdX1oqq7F+rxO4OBSFaJ63qr5GRwlf8wodkR0bln
         tOR2bRUa5lBoRa9fk/Ln14vJDLrBgj2NGtGWUWIJotEuuvsyU9QXLBXj1PVbpP5AoN31
         196uPiOSMuqC72JUBctMerGH2YIHGs1Sjl4T+dqTXBWfvUI+PoX9elF4VgDktxgIDpaQ
         MUn9vEf6mmVleWgaZ+S1tFVba7Hb/YQfwbL02n0DmovlUT4RiwTc/z8yZYDlQ17CYX53
         e5Tw==
X-Gm-Message-State: ACrzQf2rDGrwpKt6jcrAU9SpdtBMcO5mve1ICYIbUJ1ha+3aOQ9FulA0
        mqVRQhbHQ53Iyjeeg+5GHvwcLHvrXr1IxtIndI8=
X-Google-Smtp-Source: AMsMyM7lj2VaHp6DpaLYCPCiyTlfN8Mg/6zisqjcfW7o7ASVVQ4oZXaJvGu9y1QaAD+MjDAzjEMpD4rowwV/MJw0dKE=
X-Received: by 2002:a05:6638:2641:b0:363:a80a:644f with SMTP id
 n1-20020a056638264100b00363a80a644fmr9546775jat.205.1665528581803; Tue, 11
 Oct 2022 15:49:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f154:0:0:0:0:0 with HTTP; Tue, 11 Oct 2022 15:49:41
 -0700 (PDT)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <mr.bruceross22@gmail.com>
Date:   Tue, 11 Oct 2022 15:49:41 -0700
Message-ID: <CAKeG-00cDdf1Sks1M9piNQsn=prK3xGE-zsZwdw+ZV8SH52BRw@mail.gmail.com>
Subject: Reply and let me know if you received this email.!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5028]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mmrstephen16[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.bruceross22[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.bruceross22[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
