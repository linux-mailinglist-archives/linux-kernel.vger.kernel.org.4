Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBA693679
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBLI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 03:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 03:28:38 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41A12F1A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 00:28:37 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i1so6566044qvo.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Xwevp/QS8IrtZgkJqcj63hnhj2qn3eJyAR9QfSSpE=;
        b=Lvi4o0/zm5NjAfWl2d7yGoZfoo9kGibQcnIvbCwUnWSQkFgPf2C4JD+Dpk7loQYkLb
         j2DDJUduEe8L3eJ40SKzzf6VPZyjeCkj19TaW8ZR43281fDi51MCmVMdedXVQM2a5fjO
         cIyLKl0NOAqgfw6BPvPi1GiP1ZXGLpYi9BKPYNDdHnD9IsOTMb7yXVEpc/iufl2If99m
         LoMKl+GenAotxAXjS6L2n0W9GzXYYs3BScZCOvM4PlKq+AephlmBoSSiOW0f6oFz40ef
         SpE9XLqIei+K3/ng/oyMaUVq3mepi1bkD14mcpn9Vq5leF6bipqxgmsxd6CDxCFFsNgw
         PLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0Xwevp/QS8IrtZgkJqcj63hnhj2qn3eJyAR9QfSSpE=;
        b=Q9sSUNpA8Y7hGWHLYnEzNEH7C0/zvx3FnJp/XmFjV1But20KmCkp8awyqI/yZjg9Ui
         Qo40IURfW+LFgNQwtauevYKdo6kFDN7oVgGDNk+CspnGCEhrCAnspGQMxOKQoj3TOFAL
         fOuLDYDiZhCqacgGrgQh8o+EZjtJEwSAvmszj7mqhCiTyqofWxI27arAtFtjLZ8rCN2y
         S5Rsj70xdXZylYMMmaaIxdPlhZbXI/Mlci7+59BtrXZ/UEJIHIsadOXzw9ocQH8UbWVb
         Mcl8vOeD4FnCWE5radq5wsdoMZp8+9nUtqgr6F0TAkKnW63GeCydK7ARBde/HYrTBKBI
         FdSw==
X-Gm-Message-State: AO0yUKUc+n5EF3DYOTDrlzHqgX2JMQFdCr3KZlvL7nb9isqRKWQyxrq4
        +/OzXPKPtuQTvdwvO0s3V/U05EE6X2MLg8zSTCM=
X-Google-Smtp-Source: AK7set+A4xJqVAPM510S94EVdLul1yHLpN3wXgml3YDdnK7mPBPE+k3BYFK4iOnD5Dj0Qe/cueupY2DHR/9J278+wdY=
X-Received: by 2002:a0c:cb8f:0:b0:56e:a7f9:2e2a with SMTP id
 p15-20020a0ccb8f000000b0056ea7f92e2amr93609qvk.80.1676190516449; Sun, 12 Feb
 2023 00:28:36 -0800 (PST)
MIME-Version: 1.0
Sender: ameliekengabawade@gmail.com
Received: by 2002:ad4:5a52:0:b0:56e:9b6e:808b with HTTP; Sun, 12 Feb 2023
 00:28:35 -0800 (PST)
From:   Abdulah Aziz Bello <abdulahazizbello1@gmail.com>
Date:   Sun, 12 Feb 2023 09:28:35 +0100
X-Google-Sender-Auth: lSU0Er_LgKQG9XVNG3nLYOiVAKg
Message-ID: <CAMpbS81D8kK=zyqK3EtSPfPbYx12_Vm87CO6Vp1bfVAHx807oA@mail.gmail.com>
Subject: Good business you will be happy in the rest of your life,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I contacted you in a business you will be happy for the rest of your
life, God said knock the door will be open and ask it shall be given
onto you, I asked on your behave and the prayer asked, so it left to
you to complete it, get back to me and the details of the business
will be review to you, thanks, from Mr. Abdulah Aziz Bello.
