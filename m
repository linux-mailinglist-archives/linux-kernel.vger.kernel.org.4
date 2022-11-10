Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D001623B31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiKJFWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:22:44 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1F2251B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:22:44 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-36cbcda2157so5920557b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 21:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgojZt3szNIP5LGIhGbw6QUbtksVVJxnVOA5dfLkMwo=;
        b=Ex6S07d+pfmojPN4/WYput06nIk1Gj4Yh6temAe9wBW2D0PfhwFnS5jJzc7Izw/D16
         1P0mT9YmkcqmAi/ZuseETi+gmnn970XUMXZcZ1S+tumSHlwoyK9M8JvEiUhybUFHf4lm
         DR1qyX/OhEph/KFD1F2KzfYgIyW3c4WrYvq/dOLQYx+PnkYnqu4n//E1n6r8FpiS+c62
         N3zPHrHhWDqiOIDYCtL2su0/S2MGgsRdExQGDPryqOLd/fB/qrSHKFOducQ7/yKJBRu+
         +zDF+I7Oh3QKAAgFR49+uw0sN9wL/9NCStBpiAFFIu/tI5sLRP9Stw4GQGq9qnKUezVi
         HlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgojZt3szNIP5LGIhGbw6QUbtksVVJxnVOA5dfLkMwo=;
        b=50iGLjF/TOIxOmT/pOo6+JBpYlvJfOSa1Dl4PeMwTGQvlClbGy9MxGZmS9ZHxStn7n
         lVRsA8xJZo6dKOyGbMuRd2vMXMDp5TdIY/G/X9JmJVpN0gxJNr8NS7K6Zxa+IqxT+Jwi
         wy3irjFxNPZ+tRo+Tq2uNsQZEHv50CDBd8LRQoptY5veH3mEPuce6AFd7r/q5eNx9CY+
         FrW7Jk4dnz0O77pLoYyXdBmAW3+Yd0CcIlOQQhROZQcgVC4xM+zSMvn/nfOjK3ZCVtz8
         O7arDHobxCYpKmSg+M8TKshF011u18LcCFWNifPhV79oKl6jH9ywMWmpKuMBo4OZbbkt
         F7Mg==
X-Gm-Message-State: ACrzQf0BXCIcGcjVz/9MtjvTaK9bHdme7nBoB7yI7Ky8E/62ylQK1E+H
        1TEZEbcJsboox0OO+wjMcQKmcZSyY/YgFFd6Q9bbqrkRV74=
X-Google-Smtp-Source: AMsMyM5802CMhEDXDmlJdA8Kq7VzU0ua7eJlKov8TRJ4hLyYaqez6Bh03ZuJMoOYNbHI0qLm37CWjXN9YZh+PMUFsZY=
X-Received: by 2002:a0d:cd02:0:b0:341:a401:4630 with SMTP id
 p2-20020a0dcd02000000b00341a4014630mr59569528ywd.293.1668057763115; Wed, 09
 Nov 2022 21:22:43 -0800 (PST)
MIME-Version: 1.0
From:   A <amit.general.misc@gmail.com>
Date:   Thu, 10 Nov 2022 10:52:33 +0530
Message-ID: <CAEq81z03GOTiME=q83B9L-fg3bG6Mu_0_Em67Y1DqTp_oj_fZg@mail.gmail.com>
Subject: Submitting patches without using git.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is learning git necessary to submit patches to linux kernel?

Can I do it without git?

I have used SVN, etc. but I found git a little bit complex.

Amit
