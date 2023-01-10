Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE4665014
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjAJXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAJXzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:55:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008D55663
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:55:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ss4so25536426ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1I7469JYXIc5gDvGFGnP5+v3tcxVnEceL7ffOs9cWQ=;
        b=Q3S4Gjjg/1dWirKm+tca0Ib/qGluT3yY4R1VsLWd4HAxcrMMB84L6VU1X4X25Kr7mJ
         uaZO4T3El1hgk7TUPl+3PtISfr+dtQzUCLIPMvIB20Qa06AN57KlQ8FuYMm7C+nRpCoY
         hL9yoEId4MoJVQG8TEpXuQ4cLqNZrKepSFgVsbuFkuVAaSk56jfvne/vu2qJI2L3yQj+
         SQ7q/ds7swjeyINGr1t63ncphhuzhlt6wWl78Jw+8Q9yFvKzUNE7n+eQcmO03MKYUHBJ
         p9PwnBb7pGnwrWY5Jb7mubmyKu/FnLkqIA9+yXhrSus0VUoHBPeDklTCxu2yc0x6UsFF
         E8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1I7469JYXIc5gDvGFGnP5+v3tcxVnEceL7ffOs9cWQ=;
        b=0Fqe5Wt1X/R//+TdLYx1GNs7wt6kcWbnrqLygDsWDYy8zTJfnQJv2iuxe49QZk6Z1b
         e2ggjb+rk9O/jqBXiX0UmDvHGSDBLFBqM0DHPi0Myn8TpAoiLoQ3uwuCh/SAI5YGzHgr
         dIl/+1F2oHsXEVDIevaWoiMruR5Jv0xLWrYgVrHXXyeRLJQbef4r0FPugbcZ8pQIQ+eQ
         iQi0PacmMWX7aGIq+qTnVHZF+yCfKijGltbiEB0HfiYZRU/3AwJUz5ceRdstOR6AwHyi
         4BkKvsMKWjiJcT2FfyvUFgw+oD3AVOrXeFtJCRpK4HATzayMcQaZjpv2ob/6jF/kEiZ8
         M5Qw==
X-Gm-Message-State: AFqh2kpokk8L5FH/eBznSk2QeUW+JBHKVY8YuGqBymN2601DqJuPsU5L
        4ycJrnlcyhIT2U4EX3xHsh897xq4t6rw9tJGW/Q=
X-Google-Smtp-Source: AMrXdXtBIjUlu/vw1KJrHfgUNZHISRqWvu3FtLkBwpCJidnjv+PqeHvsQpPf0ByXLgjmAescTrAs2g7ohpJQ+Zu8+JM=
X-Received: by 2002:a17:906:2818:b0:836:e897:648a with SMTP id
 r24-20020a170906281800b00836e897648amr3770627ejc.94.1673394903010; Tue, 10
 Jan 2023 15:55:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:d049:0:0:0:0 with HTTP; Tue, 10 Jan 2023 15:55:01
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <usfinancialdepartment0120@gmail.com>
Date:   Tue, 10 Jan 2023 23:55:01 +0000
Message-ID: <CAAH0rADtbCeG3HM58DiTNM4eVBOoP-bhFUgFqt1r-yA=a-CgVA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [usfinancialdepartment0120[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [usfinancialdepartment0120[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

 I am Mr. Thaj Xoa from Vietnam, I Have an important message I want to
tell you please reply back for more details.

Regards
Mr. Thaj xoa
