Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B780567C86D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbjAZKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjAZKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:21:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C7730CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:21:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so4817487pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=TbbP3dSXNHK+WCKiSy8NwSY69jfIfGRylpoYBlbfh8Vyltgw9fYthWHobDknJ7RrD8
         qJvMB1dc2VVJVzixsiB98VdDTvQSlV1ePPrcoMw7fzWe+wYyrsHjYub3b9lI4FZT6Ylv
         Xqck8nFJVj1FdQNNNDVKxqcZTcJWFMzAIMkgUPORcrgMsOJwppjJB5XorGbQjek8fWCr
         n9cwovZymXFJ1OoXPFBP76X1WHnZXxxxWYpBfpz5XLTszY/qj1k5FiS0emnp8wdOzWcD
         uxCpEpZa3j8EMmrjcNi8kCmCJHbl/t6DtVkxkqzwI3OgbzAhHz6Pv1hxa+lw01tZn5gZ
         UqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=MoRJaCqai1j2Vb7MMU9etcFBBf0i8IJQJp0Ll2y0tTEug3CmR6tiZ7WChg485a6EId
         4iOhiNhq27NsqpLh7xd+Ez3Rw7Qa57tTmX2bWPazB4srg+lOr8YJ0A8gKkb0ILhqJS1D
         YsZ9vfMBbHnNJVV2vKwOEKWu+8cbdM+fJ0QEkPgEZK15EWV88uN3Sq853dykfFj2TybW
         AVBL6cYIuuGPyqViFkiOqIjhH0ZU4JOmC2+YzI95dvF6ZAY/+q+0Ca3AQkw6n3Gydhau
         rrGc1oqVnOFGqGcoOO0KJtpCSL8njuZQDyOfz4ekGs4XXz4hW/3Hi1Zeg9VaamxRwcli
         mi5A==
X-Gm-Message-State: AO0yUKVcUZHyl2C5WzMEXA4u3RI5y5WYCg/nHuy8fCeq96yBKGC4ZW2n
        UJ9Pne9FjFGu0+61OxzgClJql+L6BEepVPimOBo=
X-Google-Smtp-Source: AK7set8wBOA6iH5NzIAsXOU3Ougawg/ftwl+WPlhykJXs/aFBkPdglxIhrHKHeeT4h1XWtB4gbdyF6+ZUdsbf9kKv8Y=
X-Received: by 2002:a17:90a:7f82:b0:22c:249:c116 with SMTP id
 m2-20020a17090a7f8200b0022c0249c116mr1075161pjl.23.1674728472577; Thu, 26 Jan
 2023 02:21:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:ec15:b0:99:6fd6:b648 with HTTP; Thu, 26 Jan 2023
 02:21:12 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikarm <biksusan825@gmail.com>
Date:   Thu, 26 Jan 2023 02:21:12 -0800
Message-ID: <CAP0wf6xgBoHy0xWjvQuiDuDkvHtOL04jGYnR=eD=p87r3ca+fw@mail.gmail.com>
Subject: Please can i have your attention
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

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
