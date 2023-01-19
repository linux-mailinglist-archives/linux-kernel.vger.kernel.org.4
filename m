Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1355F674277
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjASTNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjASTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:13:21 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DA9B12A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:12:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o7so3146565ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=B8dKgNHmMLSlVFZC3OUx06OLrRIky58Epl+eSt4z3FW+aNHjUxCU+GDcQeIizgpkCM
         jvLKTAu2jhF47CQBVserIn6KAwHAKP3EEQXiTJSeZ1r6hVWGhGwejm11d+rLhvXvSlib
         mhDChN6gIujjM7E120B5yzM0B4rKJ1w/5l3+iROLO7+Mn7ek/h2Se1u7qI3WL8S4Qk4+
         6dVU1ULufQwOrFpwynJnsYqmIc3GwT4rFD115kPes+WNUrGvRkVRu4B369is5U1gw8Ye
         CouNsfwP2CqsX/Bl+He2LhyesXGcnpHGc373+g1TiLA7P1ebe7QYqoqDerEXNq/lVdJH
         0l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkx9shy389bjUkUVzL/gjZ86apFk2k0QZbOelmBX0OE=;
        b=dprVlLN6g5058EhKboa2ug645FqgOJsntRo4VKjh6BR9dPe5/q+CjERj0Pn7gK+vt4
         lQxa7WPmRnbLU+UGeGTp7xlzcMHaeZQOh1xejahHd7D4dTSVd0b21C43ZoPYNVn6lver
         P9zgUUfpkZ1yzLeioOeF+4wiT23NK2SRzU4CeG0myxHRrlw05gvOzt5wxt4tbhxRZsLL
         A2lOxrf8PqWUR4uNGgZ3CjzscAkFRGdJusb33hRAuPDiS+5H9MzD9p4OFxjvhmsHr3TW
         QYYAUIaL2DTwSHVhSzXOzt/IDsVnqHAuM9j98tT5sFkPx2K1PqFGrR3hBaEc7n2unxAR
         tXMw==
X-Gm-Message-State: AFqh2kovoySbPy2UdAQkIuZBfL1z0ROxCv6+Fh69Em0MxwI7F+kOTCVe
        XH+Vr+HqiBNRYtmC0WBcH/pAPd7Vn2OJ1MxWMOw=
X-Google-Smtp-Source: AMrXdXv3hTh/26iD79+NquHhok9b+c5dZi1wxogICVKxsicZnsP3+J5410WJREIpdmn0S69/LF+63JXbBN/Hny/MfbI=
X-Received: by 2002:a05:651c:1050:b0:288:a393:7e34 with SMTP id
 x16-20020a05651c105000b00288a3937e34mr1126079ljm.356.1674155526710; Thu, 19
 Jan 2023 11:12:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6500:211d:b0:17d:7747:94e2 with HTTP; Thu, 19 Jan 2023
 11:12:05 -0800 (PST)
Reply-To: zjianxin700@gmail.com
From:   Zong Jianxin <salihuabdulahi070@gmail.com>
Date:   Thu, 19 Jan 2023 11:12:05 -0800
Message-ID: <CAOC1+kCRy4SWNg-pNHO22yD3PPr0V7KVD6bivvWQnhNGu8CyYQ@mail.gmail.com>
Subject: Hello!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Did you receive my previous email? I have a Profitable deal for you.

Thanks
Zong Jianxin
