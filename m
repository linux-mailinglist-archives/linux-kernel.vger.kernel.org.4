Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3007737CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjFUHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjFUHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:42:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339B170D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:42:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76245581814so335362885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687333330; x=1689925330;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBQz0IOlrvvG27I0CCcV8HFmVTwl6NNK9WzR6JerA6A=;
        b=lWmYT3deBirj4WcAIBbh5w6KEBYxe/cXyCFjVlhuSR/LMDr1BgntlxHRiajIK/oVoM
         bGodNLCj0yWQfnkauKSaEyqxtY2qAJ8aszl8g8VRmcNDjk/ou/jvaZJ1OGy4/FAcP+rb
         BSKzgVxZV011bLZAaMPfIL+J0w/oupH4DnBySwrgWO3YrBiNqYtEq6KgwFd/jPcAZysi
         1dXulU2jX6A8QMpQIKriPrh8z/dK6DgrC4QohQ4bEtT0H6xtxkoJ281zE5hxfOS5g+wI
         Du2V/vcshJip/xHtQ046N2MlUzBi+0V7JHhQ+MMGIo9wLV0yujQIwaFqg5J179Q/cfA7
         WVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333330; x=1689925330;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBQz0IOlrvvG27I0CCcV8HFmVTwl6NNK9WzR6JerA6A=;
        b=Thp6Wbn492mwhfVND+ohkWvTm29h2yTVE9NeWZKItUtr52KqhMN4f32H2bMcS4I5Mt
         WTI4PJ833WrJl4XfWYBSxeqRND8v7wJ4BwC7c+ZwV/3TWNOwNkAmYpCRe7GTWNOU7HEt
         mNigAUWYzAXl+bbMzmBJ0dW+Uixgqceytra1IPucKMcAt/b/6ZjUWCNXxA9qHcH4Aadn
         92/W3IBaw6KYoh5zXg4+qTc8ieaScMezN5bCzUynEKJr/7/8eGbxaoAXVcVQIJRar7uC
         hhYDeXhlNQopznm1sObeADnMObHNd0KXzbJBqHcyl9EmUEF5NGTuath26CnhVmGH7mL0
         Bu1Q==
X-Gm-Message-State: AC+VfDxnSA5LRb5nyboNIEzr5nzT9XZa7S9QOPVKkIKE3QZJuoji9b9m
        2/FHjIF+MKSHCrqfZ278KSSf9bpHEkhPGsdq3Dg=
X-Google-Smtp-Source: ACHHUZ4SmN090J8JJjQbisJ8zB3qPdRW6AU4nTReuOIeXRzS+LYOwUsF3Gw9X5sV/XU/jaazgqI+iLRqvHOEh6R3zFw=
X-Received: by 2002:a05:6214:2242:b0:626:16ba:539f with SMTP id
 c2-20020a056214224200b0062616ba539fmr16750542qvc.5.1687333330388; Wed, 21 Jun
 2023 00:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1998:b0:3f6:b7b1:372b with HTTP; Wed, 21 Jun 2023
 00:42:09 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <kojofofone8@gmail.com>
Date:   Wed, 21 Jun 2023 09:42:09 +0200
Message-ID: <CADiSXQY18FhUGVACLQmeGRfrTkVSk5FkG=R7GN3TDMEv+EH92g@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you.Please answer
me.Regard, Mr.Abraham,
