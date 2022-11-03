Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD16179AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKCJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiKCJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:18:39 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68520DF6D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:17:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i12so726206qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S27rf3kqtxPFXY27Pis05ywWuW6Og2HFmNiBpLHzMEw=;
        b=UCAeBUMO3aUcMiCHOkkum/+gUdMFLZHG0lTSPjNC6VodHeS1weOjt+8XYkTaveoIQP
         J0nM33wjeRHMcj0P3N4QMMBRv4uAT3EpPVkM73Y3zJVZ63oqJV0TfnmlQQtEA/hgvNaO
         SLv/3oxGdvQj7S9OYC7snzo9XnaDv0ECc6wQzRcL1OmfufmqfMSj1GC+2Inh75qRxUKO
         XBAd3DWA9KdL39StkCN3q05Ejp/zfXZt06jQfzqa8JE9dbCBdLjuRu6g4BxJstz0N6L3
         2erYzwxuTq1CBSv3E8IHTAt6XqUdySll7AsiXFdA1nWc2VCh1jJPh3cRLDlqIdhap82a
         kreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S27rf3kqtxPFXY27Pis05ywWuW6Og2HFmNiBpLHzMEw=;
        b=ROC7Uva/mtvZ2xt4omE6kQAvKP1quy4VJUKoadmOIaIBW/f2nSUXzrIroC+HNdnUV+
         2avp2+Yp04nj6GJw1gGl5H3zLgTeWd5IQKxFxICIo0eI840HEJJllZz6VU+/JYDdMxkX
         2vILozm24bVVAMh2OqD5Wh/y+4wMl0Mf5hl7gNU1VJchUOrL5Kh2fok/eaWG5EqOUdzH
         kZngU141I4ZImH8oKdljEePgD5qkI1WQpm7SgZWp8uHbro+aFm9BGpm+rPkITU+d20lE
         aMR3KKCuhR5UKCYWJUJQTuP+U9Xb6fFUD6DeVnkrVqi9ku8FXW2jDX1qNTClgeLq5WI8
         dkDw==
X-Gm-Message-State: ACrzQf2qwkxqV1CiV04xIsoh3z1rvu6DyuZtC4KpI/pgB/WYAw0P0bTK
        si8SSZabyg5fyEZDD9lY0an2ueRQtqYdOoFBEbqbiq+FN4U/n5r4
X-Google-Smtp-Source: AMsMyM5Oj6gFJGt+vv1xABt2GvnCRYvT3lh97M+rZ/HIwYczm9bdVU2DEbSLEDSndFW2q6XByLsn7mEzHBnG1gfBTfs=
X-Received: by 2002:a0c:e547:0:b0:4bb:66d2:2d58 with SMTP id
 n7-20020a0ce547000000b004bb66d22d58mr25788188qvm.69.1667467056490; Thu, 03
 Nov 2022 02:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667397591.git.tanjubrunostar0@gmail.com>
 <5a0649c6019f1717cb2e2e8fc4e262f3747d73a5.1667397591.git.tanjubrunostar0@gmail.com>
 <bfc8e714fbe80a16428a447768def5764083526d.camel@perches.com>
 <CAHJEyKV75q90E1OU2YOGK70EBLm8dQe181m_nS_qmPRsPaB8TQ@mail.gmail.com> <Y2OExzH0QJqHEfNf@kadam>
In-Reply-To: <Y2OExzH0QJqHEfNf@kadam>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 3 Nov 2022 10:17:24 +0100
Message-ID: <CAHJEyKVP9ZvO-EbzGgi+Hu_XoBq18dvpnOjs886gjgvwuAdv_g@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] staging: vt6655: change the function name s_vFillRTSHead
To:     Dan Carpenter <error27@gmail.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 10:07 AM Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Nov 03, 2022 at 09:48:59AM +0100, Tanju Brunostar wrote:
> > The second commit under this patchset resolves this. please take a
> > look at it and let me know if I should change anything
> >
>
> Please don't top post on email.
> http://www.catb.org/jargon/html/T/top-post.html
>
Oh my mistake. sorry
> Don't break the kernel and then fix it in a later patch.  Just fix it
> without first breaking it.
>
> regards,
> dan carpenter
>
I see. So I should send the changes in one patch right?
