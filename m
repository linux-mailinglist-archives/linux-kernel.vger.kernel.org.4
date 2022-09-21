Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55BF5E569C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIUXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIUXL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:11:29 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D8A6C6F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:11:29 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a14so2987132uat.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=hIANwvJHq+cYsbHACUVy8eV74bcyF15lshOyI2ioKMRE3V94+Y3f3nk2asMisw70w4
         By77aJdx+CZi217kmhSlDcvwG4lo/RcJsfcGMarVT4rRr7xfU8gChjvGVvzYhQ0xm9pF
         UhdniQWoQwxDS/VWk1VWDCmP5PevnFUEn34YVKtD71tBCylmdazS8Ldi8lFFngkmPDoq
         eaQQKKwZtPJkD91UXUahXBxuTWd9sFs+gk4jx8D2ufKXZ4tOJ9/tfwKoCewVOEJUfLBA
         ZjpdMjquFZ7KmZ9oy8zJie+yTdZf8aBR4G2DRvEwv5ThdK1TZsiGiMG+XPqPNua8sTgx
         lx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=pv4aPsWMNdO8ERa7QrdDGyvxapHLvVEcajknKEW163iV3Jo6Tjj5Uqp+uX3eUhusmo
         oGHeUVdIVh2LeJDqH+RQUwa9AjH1lnaq+ZQJvM+EHcpZx5YTj+8UPxiDvfxxSw8UlE3d
         sUs3eh8mvwxoPQupU9EDl10li5yg2LEByjS/9SAPtnnYZadL1zUnwGq3BKWaBGq6db9x
         +6bJUIMIounJq0OwgBnpfR3HP8aUN7tsZHdCTv5SuaPvdDTPlyKYRSiiopsevpkBWzX2
         S1yd6fQIzhtEQXnBmduR7Iv6JpWWm9zz45PRI5rRHQU/vrD9/oqFKlSvJCrk+anTshv8
         6n9w==
X-Gm-Message-State: ACrzQf2FN8nP4QyPYk5nrZkAeCrfXxBUer5ApwxY1kfGM/siNIEmROLp
        6sGCiunXqCD5FSNxe+jQ8XgrwP14qyg2VuOA2b0=
X-Google-Smtp-Source: AMsMyM4qtnpUD/Kn0D2spK+EnHWLnfbiUDAyGZoWMHzyZbOqSx2JQG/DWlb8uAvdAFWubXWCx5Mr+KH5dMf+CArKBYY=
X-Received: by 2002:ab0:3c93:0:b0:3c0:b089:1081 with SMTP id
 a19-20020ab03c93000000b003c0b0891081mr270894uax.9.1663801888091; Wed, 21 Sep
 2022 16:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f6d9:0:0:0:0:0 with HTTP; Wed, 21 Sep 2022 16:11:27
 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <alassisidemion@gmail.com>
Date:   Thu, 22 Sep 2022 00:11:27 +0100
Message-ID: <CAG8=QahGOCDKJPr-Cb4muHcy63Xy4QGE4eDii-BBO_evaAckRw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
