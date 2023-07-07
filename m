Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFF74AFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGGLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:34:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3E123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:34:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso27786271fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688729662; x=1691321662;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HB1ZBmrI8lJQ2iZKSS1/QjY2dlcegRSejhR78gpSgws=;
        b=fesoF8e5faReTdBi4hjlI1+OvTvH5vK6l0maJFmWIuyW8hrBMJ4tD1TvCP0DLGzrrf
         m8Ibb3T71RJ8V3+85cAuWx1DNPgbR/sQjKhODAUcuFpgamJvWLIcMw9IWm8ll+MoJXiz
         WE4+0MjUDpmzPXYgnjILkvjzXgN2S/dq+wEHEFRdxS3rzalHnAKc6syJrRPi6tATsh2F
         Mcq7n4rzcAB5AxPc1WruPJW7sj/q3R9g9bZRJqAhjGWGuBcWvx8YhA3rwAbUr1YAGPB6
         ab2tjy1VsbjPWU8jUoNvXSrtq3iU4YSbZIp04EL/coy4LOr6RdFYlpHbfL4ovlxLwg2E
         q/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729662; x=1691321662;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB1ZBmrI8lJQ2iZKSS1/QjY2dlcegRSejhR78gpSgws=;
        b=BGDofcPGX5XTV/3lSPxrdJRieILESBzRPd8+rSYCe+r9fXIIMhyZ687MbcqEjxaEqg
         PXp9ZDkt5bajMvejh0c+q3ySo5CJWxqZWzhhZU37NQ+EK8pa3zs7HhpoUR4mP52oYFbJ
         pgNsh2+knJ1tPJAB9qdETBITvnMe1Sb7+HmWTjF7PqCea2Ce/SjOPj/wQZvv1QcbBT43
         dkPJv36PcGL7qtwYQm32GPU6azUEv11pN+akdgRWQOSEFkNg9gz121YhnLmkuVax6tJS
         zO+61ghjNs9Ud/QWsrzPmRh04t0xGvTY8AVMJDkb14lGjS5x6Z9ahPQjC9hIx2B9asVr
         yPHw==
X-Gm-Message-State: ABy/qLZeCDsVZg267xjOMxR8d3EiaGE+MBmV1RiElYRoiZte2/iV5qx+
        +UB/VNLVtae715UPbmRzLtEbvrEPBnvOMUI3GOc=
X-Google-Smtp-Source: APBJJlFvgE3XPnl2pUBXl+hLSjdn/0Ad0xrMugh3YZzi7Rv91sGAhmEDZHbsWpOE8CB+gBnDdLXFx8im1wGUMSO7pCg=
X-Received: by 2002:a2e:9455:0:b0:2b7:29b:d5a5 with SMTP id
 o21-20020a2e9455000000b002b7029bd5a5mr3486874ljh.34.1688729661530; Fri, 07
 Jul 2023 04:34:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.attorney25@gmail.com
Sender: mmbbr2019@gmail.com
Received: by 2002:a05:6022:338e:b0:42:f7b5:db61 with HTTP; Fri, 7 Jul 2023
 04:34:21 -0700 (PDT)
From:   Benjamin Addy <dr.attorney25@gmail.com>
Date:   Thu, 6 Jul 2023 23:34:21 -1200
X-Google-Sender-Auth: sjafDie3qXFW8YljWVASBZDYATI
Message-ID: <CAD7Yj0674WSF0FRzr1i82OVOQ702Nvg-QKytDFGqDjSMA+WvZw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I sent you an email earlier.
Please confirm if you received
Yours sincerely
Dr Ben
