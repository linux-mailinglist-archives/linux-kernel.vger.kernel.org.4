Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B536E99C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjDTQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjDTQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:43:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2735B5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:43:06 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5fe25d190so928251a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682008986; x=1684600986;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXAUYeebDwCroBAyn2MVZAf4vreitWQ1P0LU3S+PmE4=;
        b=SgUbvvN7wcoUppTJy1wvDmOWKNsvcdF2m0JIpa81FC7Q60NiBt6MeQri1ADXcyqyhj
         bs8QlTqzJ+Spuj0eod8Jrl2l0k5rvKxOZvB+IoOVDnum8qRN903pXvZB2UZmfLZX8BzT
         YY5g522j1i3kdSd35hmwkjO2OVR/dPyjhHq7ougG5PzwPBQvh7dua6ZN3+49okvxzkdL
         qs5WyvT8fkb0TITPf03VF0FrwMsPIl01R32el+lt89Yie8i8/dPF+azHGLILCFliTEDB
         IgebmoTIlWDaINOB7AslnUUdubMxCdbLC/ppXwWFYgJHf2odW0azzW3NUOiZQnGcfK8N
         LNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008986; x=1684600986;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXAUYeebDwCroBAyn2MVZAf4vreitWQ1P0LU3S+PmE4=;
        b=kIVCrn98bOnmpRYp7bdAoDN6q1LHPcM2WAia4nTjzSUzNWXwpx+J4f7N3yhaL3X+lI
         Xn8EvJXJ6+Mp1phWOEifTA895tejbW/Il+0YllJLpgx6JZnEPc9ncdGNb25sRrIQGAKa
         3zVakmQk1J4EoLknxiAGJ4rvpBabq0lwGtSLGWf5frpwlU7JdaJKM2sHtc5eH/XcsuXn
         H26xQRze0Un59wfjRUG7+M/j0z5RoFeJpXw4tXUt2zz/U/P58MTwLHFovZJGU/BxojAt
         KtmpWV9JPZgFzDnJKi1pNfkNNudgLkjw3NC5RjnRtrEmrBztmqVFoly6QLN6l+P9FSvo
         38vw==
X-Gm-Message-State: AAQBX9dRzHWCpml509gI19y+4Wph2c/BJq6IcxFDoL/XV8IzgUp2zCes
        PUmMnj6s9RVhhF/XlOrk8b3ZPypeo6xCuqVob9YDjxuA8f0=
X-Google-Smtp-Source: AKy350bMzUcEjfrmIpfx6pEIIV8BwJTT+nzbXz984BzoNkkWkoGAeTOpzttUj//a2JnmGV7iS88xDUrR1admn5MY9ms=
X-Received: by 2002:ac8:7d07:0:b0:3ef:3ba3:d62 with SMTP id
 g7-20020ac87d07000000b003ef3ba30d62mr2668658qtb.49.1682008638205; Thu, 20 Apr
 2023 09:37:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:28e:b0:3da:9a67:fdb3 with HTTP; Thu, 20 Apr 2023
 09:37:17 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <therve06@gmail.com>
Date:   Thu, 20 Apr 2023 08:37:17 -0800
Message-ID: <CAJ23n_Dow0E0wS3tfxzS+1xGwhyOwGS7nPcJtfn3ARKBf7EUGg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Lily William, I'm from the United States of America
currently living in the UK, I received your email via Linkedln.com.
It is with pleasure that I contact you for a new and special friendship. I
will be happy to see your response so that we can get to know each other
better.

Yours
Lily
