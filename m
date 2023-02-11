Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F8693080
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBKLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBKLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:50:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059511E80
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:50:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so5727594pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=bjtnxPtSdNgO03GDV74vCQ/tuv5XeQmHRj0DrCG3m+y/ONquF54HfqT5C7y4NUqK2K
         +vPHDjSLHSzN4PiqrZDa2ftux9Cgbqlrjpzxx782WZst/RHm/hwetOrkQh40olNYGEdI
         X9gryj+Qy+akAxztelCHuhVnDzZoWci/oVWQijfxYZr/XPFNxZGzAVW04pGuQQH3oMRQ
         z1ldU/dz5/B0Y/Bam+I8HW6TA9PN8RaVqnfFNtxfITwCDSmFlhk3GYy7esJAiFpz62LQ
         M4x1s/ll9i41dJXixLhNlx8bUWf06LijSMTbylf9rUxvNnbSh+AAqLuQPE0XGIO+gg0c
         OFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=7NBjXIZiBMCBwJ2pXkWPNhvrspbJ4hWHLjcU6f6SzWEJap+5rpTmLkcq36OKslHwn4
         +6P6hYMlUHUwJl1tvnfxE0/ECoyNFaTB0GdlakOItXeDK1vmb/Cru0oCod2dXXPw+Lht
         KqMj7Qw63tqw/H5tl92ZzDbd9dNFiFHTTBsv+nTgHUPFaSMwZp5q62SOA1It7QSNjCcY
         p2s9eEYg40LtOCy0UpbJ9VwaF8A5L+f+ExUtwafUz2YNe4AtppDqIr6OWma7j3XL0uwi
         h9RO6kEJFmribULAI/Ltr95GzFAIK4EePoarc8g5948OKv4rMwFHs63aE1djNyik5KYw
         5ljg==
X-Gm-Message-State: AO0yUKWw2uasg5puYnDft9u3/dvurFp2CXyhjkkHVjGmbGrmOy9dUIWU
        2msJKT1mSqnfBdoBmPA9LdMNNLzCoQ5peK/38N4=
X-Google-Smtp-Source: AK7set9mGe8uRvhB5NWxNriuTilPHZLeIDcLgVOqV4Om4IeNhwV/5iMEcdajx+Gd9NRCy8bT5ezixDDA3FWTzyLM0GA=
X-Received: by 2002:a17:902:b78a:b0:199:26df:77b6 with SMTP id
 e10-20020a170902b78a00b0019926df77b6mr4272652pls.3.1676116249552; Sat, 11 Feb
 2023 03:50:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:23c4:b0:408:ac32:17f2 with HTTP; Sat, 11 Feb 2023
 03:50:49 -0800 (PST)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <leea4982@gmail.com>
Date:   Sat, 11 Feb 2023 03:50:49 -0800
Message-ID: <CADa=nC0u3sTgnfME2U4UNttJv3n7RZpmKXNJK=0Sy3wf-T8_Bg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello did you receive my message?
