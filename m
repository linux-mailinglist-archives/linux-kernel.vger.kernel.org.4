Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB996DC559
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDJJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDJJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:49:56 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7E1726
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:49:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54c17fa9ae8so189349337b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681120194; x=1683712194;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWIONkUKCX2JMCosfarTeLGkNWabBO6R8R+bGsxbMRQ=;
        b=RpUyosrOhhL0wZpx0h55J1Kik864LAMd7bldb+7jzAs0QxLpSaP+na0qnhocaSrYoh
         H2XkdBwYkVuay7o2ydjB9mv2VhEvi1G80G+RCw7UY7uDl56fHZudaI3xNtxGx1QZLHff
         JM7ywUbW+svS5R5illHglMeeQyTQG7xPEBAJv2IbF46ebhVFFcSIGkWH9W8wfPRdoG+Q
         bATKzdi4RK6kES2fycfsN+q5XfYJSJaXtzU3NKAlKqdFi3+zOFkdkSpwtiskIdAekcFO
         JEJ53JSEqjlmXZjzboI3YErYoR2Yn4OMctIJownq9BlgU+pJIG4Ib7doDHYUNRVH3Eox
         2Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120194; x=1683712194;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWIONkUKCX2JMCosfarTeLGkNWabBO6R8R+bGsxbMRQ=;
        b=xCPBOa6wVc8E+AIjnSZw1cCaase1wdX3RD0Jtp/zBVP3faLwIO6IzFvOg37Xx8Uw3q
         OioarxjfN+rGunY1WRdrTxgrr2ma+hSlO7lCchjvaLkXTjmN5Q+uvxTk6+FRMNJH+iT8
         NufPzfvzBqLlekpCGsvcapED2CZekYVM66dLRZ0WrNGSw8OvaSvLZyv8pokp/H8SUNSa
         cNbbbGbJIYM3shWcLN6kGvo8ouHky3ZWT/IQhX7YNrV9ZGPfNYDD8oBEN4So3kLfAzoc
         TuPmqXTzcr7RNepCrzWUG+odCNiCzmcM1ZTRbn7GH7C0go2PiT//zO/gvXtOC4Lsb6+d
         kqsg==
X-Gm-Message-State: AAQBX9cINKvnpxHdySvt+4sco93517xfG/Yr9KQxJ5rekddLN8YPUsjm
        gpspBoi8tKuxg+IzqfUTm22+KyHc95C7gaqxRL8=
X-Google-Smtp-Source: AKy350addpWjKvmKKBtX77oSHTNYJAOdWDs3i/GVMNGa8jPwwWxm16ndUxRIy2roUEhHgAp1PnNRmsgJdwN4L6eizpU=
X-Received: by 2002:a81:b654:0:b0:54c:88d:4052 with SMTP id
 h20-20020a81b654000000b0054c088d4052mr3697018ywk.1.1681120194172; Mon, 10 Apr
 2023 02:49:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:4ec3:b0:49a:2de4:d8ab with HTTP; Mon, 10 Apr 2023
 02:49:53 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <jyotsnafarhadmurad123@gmail.com>
Date:   Mon, 10 Apr 2023 09:49:53 +0000
Message-ID: <CAJzJiXWYn=eZHUKBx9=NNMLw2gz58vp3_M+0ju8rKqbpW51d_w@mail.gmail.com>
Subject: I WANT TO KNOW YOU BETTER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly want to know if you're ready for investment project in your country. i
need serious investment partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Your friend
Wormer,
